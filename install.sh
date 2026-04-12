#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYSTEM_DIR="$SCRIPT_DIR/system"
TARGET_DIR="$HOME/.claude/loop-closed"
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
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
echo "→ Creating $TARGET_DIR/rules/"
run mkdir -p "$TARGET_DIR/rules"
run mkdir -p "$TARGET_DIR/templates"

# Copy system files
echo "→ Copying system files..."
run cp "$SYSTEM_DIR/CLAUDE.md" "$CLAUDE_MD"
run cp "$SYSTEM_DIR/playbook.md" "$TARGET_DIR/playbook.md"
run cp "$SYSTEM_DIR/rules/"*.md "$TARGET_DIR/rules/"
run cp "$SYSTEM_DIR/templates/"*.md "$TARGET_DIR/templates/"

# Create .claude/rules/ directory and symlinks for auto-loading
RULES_DIR="$HOME/.claude/rules"
echo "→ Creating rule symlinks in $RULES_DIR/"
run mkdir -p "$RULES_DIR"
for rule in efficiency memory-first verification scope; do
  run ln -sf "$TARGET_DIR/rules/${rule}.md" "$RULES_DIR/${rule}.md"
done

# Install the sandbag gate hook — the structural fix for push-harder
HOOKS_DIR="$HOME/.claude/hooks"
echo "→ Installing sandbag-gate hook in $HOOKS_DIR/"
run mkdir -p "$HOOKS_DIR"
run cp "$SYSTEM_DIR/hooks/sandbag-gate.sh" "$HOOKS_DIR/sandbag-gate.sh"
run chmod +x "$HOOKS_DIR/sandbag-gate.sh"

printf '\nDone.\n\nNext steps:\n  1. Edit the "About You" section: %s\n  2. Add your active projects: %s/playbook.md\n  3. Register the sandbag hook: add this to ~/.claude/settings.json under "hooks":\n     "UserPromptSubmit": [{"matcher": "", "hooks": [{"type": "command", "command": "bash ~/.claude/hooks/sandbag-gate.sh"}]}]\n  4. Open /hooks in Claude Code once (or restart) so the hook activates.\n  5. Start a session — it reads the playbook first.\n\nDocs and examples: %s/\n' "$CLAUDE_MD" "$TARGET_DIR" "$SCRIPT_DIR"
