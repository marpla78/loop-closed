#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYSTEM_DIR="$SCRIPT_DIR/system"
TARGET_DIR="$HOME/.claude/loop-closed"
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
HOOKS_DIR="$HOME/.claude/hooks"
SETTINGS_FILE="$HOME/.claude/settings.json"
DRY_RUN=false

for arg in "$@"; do
  case $arg in
    --dry-run) DRY_RUN=true ;;
    *) echo "Unknown argument: $arg"; exit 1 ;;
  esac
done

run() {
  if $DRY_RUN; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

# Require jq — the settings.json merge uses it.
if ! command -v jq >/dev/null 2>&1; then
  echo "error: jq is required. Install with: brew install jq" >&2
  exit 1
fi

echo "loop-closed installer"
echo "====================="
if $DRY_RUN; then echo "(dry run — no changes will be made)"; fi
echo ""

# Back up existing CLAUDE.md
if [ -f "$CLAUDE_MD" ]; then
  echo "→ Backing up $CLAUDE_MD → ${CLAUDE_MD}.backup"
  run cp "$CLAUDE_MD" "${CLAUDE_MD}.backup"
fi

# Create target directory structure
echo "→ Creating $TARGET_DIR/"
run mkdir -p "$TARGET_DIR/rules"
run mkdir -p "$TARGET_DIR/templates"

# Copy system files
echo "→ Copying system files..."
run cp "$SYSTEM_DIR/CLAUDE.md" "$CLAUDE_MD"
run cp "$SYSTEM_DIR/playbook.md" "$TARGET_DIR/playbook.md"
# Don't clobber an existing draft file — it may have pending memories
if [ ! -f "$TARGET_DIR/playbook-draft.md" ]; then
  run cp "$SYSTEM_DIR/playbook-draft.md" "$TARGET_DIR/playbook-draft.md"
fi
run cp "$SYSTEM_DIR/rules/"*.md "$TARGET_DIR/rules/"
run cp "$SYSTEM_DIR/templates/"*.md "$TARGET_DIR/templates/"

# Create .claude/rules/ directory and symlinks for auto-loading
RULES_DIR="$HOME/.claude/rules"
echo "→ Creating rule symlinks in $RULES_DIR/"
run mkdir -p "$RULES_DIR"
for rule in efficiency memory-first verification scope; do
  run ln -sf "$TARGET_DIR/rules/${rule}.md" "$RULES_DIR/${rule}.md"
done

# Install all hook scripts
echo "→ Installing hook scripts in $HOOKS_DIR/"
run mkdir -p "$HOOKS_DIR"
for hook in sandbag-gate pre-compact user-prompt-submit-rehydrate session-start-promote; do
  run cp "$SYSTEM_DIR/hooks/${hook}.sh" "$HOOKS_DIR/${hook}.sh"
  run chmod +x "$HOOKS_DIR/${hook}.sh"
done

# -----------------------------------------------------------------------------
# Register hooks in settings.json
# -----------------------------------------------------------------------------
# Events:
#   UserPromptSubmit                   → sandbag-gate.sh + user-prompt-submit-rehydrate.sh
#   PreCompact                         → pre-compact.sh
#   SessionStart (startup|resume|clear) → session-start-promote.sh
#   SessionEnd                         → type:"prompt" inline — extracts draft memories
#
# Why the SessionStart matcher excludes "compact": that source fires after
# mid-session context compaction, and re-touching the .session-start marker
# there would invalidate the timestamp guard pre-compact.sh relies on, silently
# dropping the rescue anchor on every compaction.
#
# Why SessionEnd (not Stop) for the capture hook: Stop fires after every
# assistant turn (it's "agent considers stopping"), which would re-run the
# Haiku capture on every reply. SessionEnd is the once-per-session terminal
# event.
#
# Idempotent: re-running install.sh preserves sibling hooks owned by other
# tools (dedup filters at the inner hooks level, not the outer matcher entry).
# The capture prompt dedups on a stable sentinel prefix so edits to the prompt
# body don't leave the previous version alongside the new one.
#
# Requires Claude Code v2.0.30+ (type:"prompt" hook).

# Sentinel prefix makes dedup stable across future edits to the prompt body.
# Bump the version (v1 → v2) intentionally if you want old + new to coexist.
CAPTURE_SENTINEL='[loop-closed:capture-v1]'

CAPTURE_PROMPT="$CAPTURE_SENTINEL"' Read the conversation transcript at $TRANSCRIPT_PATH. Extract up to 3 durable memories worth saving from this session — things the next session would not figure out on its own.

Tag each one at column 0 (no leading "-", "*", or indentation):
[PROCEDURAL] for how-we-do-X rules (working patterns, corrections)
[SEMANTIC] for facts that stay true about the person, project, or stack
[EPISODIC] for what-happened-this-session events worth remembering

Follow the conventions in ~/.claude/loop-closed/rules/memory-first.md.

Append your entries to ~/.claude/loop-closed/playbook-draft.md under a new "## YYYY-MM-DD" date header (today'"'"'s date). One entry per line, tag at column 0. If nothing durable happened, write nothing — silence is fine.

Do NOT edit playbook.md. Drafts only. The human reviews and promotes keepers at the start of the next session.'

echo "→ Registering hooks in $SETTINGS_FILE"
if [ ! -f "$SETTINGS_FILE" ]; then
  if $DRY_RUN; then
    echo "[dry-run] would create $SETTINGS_FILE with {}"
  else
    echo '{}' > "$SETTINGS_FILE"
  fi
fi

# Single-quote the path inside the command so hook-runner shells don't word-split
# on a $HOME that contains spaces (common for macOS GUI-created accounts).
SANDBAG_CMD="bash '$HOOKS_DIR/sandbag-gate.sh'"
REHYDRATE_CMD="bash '$HOOKS_DIR/user-prompt-submit-rehydrate.sh'"
PRECOMPACT_CMD="bash '$HOOKS_DIR/pre-compact.sh'"
SESSIONSTART_CMD="bash '$HOOKS_DIR/session-start-promote.sh'"

build_settings() {
  jq \
    --arg sandbag_cmd "$SANDBAG_CMD" \
    --arg rehydrate_cmd "$REHYDRATE_CMD" \
    --arg precompact_cmd "$PRECOMPACT_CMD" \
    --arg sessionstart_cmd "$SESSIONSTART_CMD" \
    --arg capture_prompt "$CAPTURE_PROMPT" \
    --arg capture_sentinel "$CAPTURE_SENTINEL" \
'
# Filter by inner hook command/prompt, not by the outer matcher entry —
# so a user who consolidated a custom hook into the same matcher block as
# a loop-closed hook does not lose their custom one on re-install.
def dedup(marker):
  map(.hooks = ((.hooks // []) | map(select((.command // .prompt // "") != marker))))
  | map(select((.hooks | length) > 0));

# Match by prefix — lets us evolve CAPTURE_PROMPT body while still replacing
# the old registration on upgrade.
def dedup_prefix(prefix):
  map(.hooks = ((.hooks // []) | map(select(((.command // .prompt // "") | startswith(prefix)) | not))))
  | map(select((.hooks | length) > 0));

.hooks //= {} |
.hooks.UserPromptSubmit = (
  ((.hooks.UserPromptSubmit // []) | dedup($sandbag_cmd) | dedup($rehydrate_cmd))
  + [
    {matcher: "", hooks: [{type: "command", command: $sandbag_cmd}]},
    {matcher: "", hooks: [{type: "command", command: $rehydrate_cmd}]}
  ]
) |
.hooks.PreCompact = (
  ((.hooks.PreCompact // []) | dedup($precompact_cmd))
  + [{matcher: "", hooks: [{type: "command", command: $precompact_cmd}]}]
) |
.hooks.SessionStart = (
  ((.hooks.SessionStart // []) | dedup($sessionstart_cmd))
  + [{matcher: "startup|resume|clear", hooks: [{type: "command", command: $sessionstart_cmd}]}]
) |
.hooks.SessionEnd = (
  ((.hooks.SessionEnd // []) | dedup_prefix($capture_sentinel))
  + [{matcher: "", hooks: [{type: "prompt", prompt: $capture_prompt, model: "claude-haiku-4-5-20251001", timeout: 60}]}]
)
' "$1"
}

if $DRY_RUN; then
  TMP_INPUT=$(mktemp)
  if [ -f "$SETTINGS_FILE" ]; then
    cp "$SETTINGS_FILE" "$TMP_INPUT"
  else
    echo '{}' > "$TMP_INPUT"
  fi
  echo "[dry-run] resulting settings.json would be:"
  build_settings "$TMP_INPUT"
  rm -f "$TMP_INPUT"
else
  cp "$SETTINGS_FILE" "${SETTINGS_FILE}.backup.$(date +%s)"
  MERGED=$(build_settings "$SETTINGS_FILE")
  # Validate before writing.
  echo "$MERGED" | jq . >/dev/null
  # Atomic write: rename(2) within the same directory is atomic on POSIX,
  # so an interrupted install can't leave settings.json truncated.
  TMP_OUT="${SETTINGS_FILE}.tmp.$$"
  echo "$MERGED" > "$TMP_OUT"
  mv "$TMP_OUT" "$SETTINGS_FILE"
fi

printf '\nDone.\n\nNext steps:\n  1. Edit the "About You" section: %s\n  2. Add your active projects: %s/playbook.md\n  3. Open /hooks in Claude Code once (or restart) so the hooks activate.\n  4. Start a session — it reads the playbook first.\n\nHooks registered:\n  • UserPromptSubmit                   → sandbag-gate.sh + user-prompt-submit-rehydrate.sh\n  • PreCompact                         → pre-compact.sh (rescue anchor)\n  • SessionStart (startup|resume|clear) → session-start-promote.sh (surfaces drafts)\n  • SessionEnd                         → inline prompt hook (extracts drafts — Claude Code v2.0.30+)\n\nDocs and examples: %s/\n' "$CLAUDE_MD" "$TARGET_DIR" "$SCRIPT_DIR"
