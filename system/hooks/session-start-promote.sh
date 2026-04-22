#!/usr/bin/env bash
# SessionStart hook — surface last session's draft memories for
# human-in-the-loop promotion into the permanent playbook.
#
# Why this exists: the session-end capture hook drafts memories
# automatically, but auto-promoting them into playbook.md would open
# a prompt-injection surface (malicious transcript content becoming
# authoritative memory). The human decides. This hook is that nudge.
#
# Writes a per-session start marker. The rehydrate hook uses it to
# distinguish a fresh session from a mid-session compaction.
#
# Registered only for source ∈ {startup, resume, clear} in install.sh —
# never fires on source=compact, which would otherwise bump the marker
# after pre-compact.sh writes the rescue anchor and invalidate the
# timestamp guard in user-prompt-submit-rehydrate.sh.

set -euo pipefail

TARGET_DIR="$HOME/.claude/loop-closed"
DRAFT_FILE="$TARGET_DIR/playbook-draft.md"
PLAYBOOK_FILE="$TARGET_DIR/playbook.md"

INPUT=$(cat 2>/dev/null || echo '{}')
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "default"' 2>/dev/null || echo default)
SESSION_MARKER="$TARGET_DIR/.session-start.$SESSION_ID"

mkdir -p "$TARGET_DIR"
touch "$SESSION_MARKER"

# If no drafts, stay silent — don't add noise at session start.
[ -f "$DRAFT_FILE" ] || exit 0

# Count tagged entries. Tolerate:
#   - leading bullets (- or *), which some models reliably produce
#   - any leading whitespace
#   - POSIX character class (works on BSD grep / macOS default)
# The capture prompt now asks for tags at column 0, but the regex is
# intentionally forgiving so a model that mirrors the template's
# bulleted example still gets counted.
PENDING=$(grep -cE '^[[:space:]]*[-*]?[[:space:]]*\[(PROCEDURAL|SEMANTIC|EPISODIC)\]' "$DRAFT_FILE" 2>/dev/null) || PENDING=0
[ "$PENDING" -gt 0 ] || exit 0

if [ "$PENDING" -eq 1 ]; then
  NOUN="1 draft memory"
else
  NOUN="$PENDING draft memories"
fi

MSG="📝 Last session left $NOUN. One read to close the loop:

    cat $DRAFT_FILE

Keep the keepers in $PLAYBOOK_FILE, drop the rest. That single decision is how the loop compounds — not a chore, the whole point."

jq -nc --arg ctx "$MSG" '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $ctx}}'

exit 0
