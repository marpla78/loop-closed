#!/usr/bin/env bash
# SessionStart hook — surface last session's draft memories for
# human-in-the-loop promotion into the permanent playbook.
#
# Why this exists: the session-end capture hook drafts memories
# automatically, but auto-promoting them into playbook.md would open
# a prompt-injection surface (malicious transcript content becoming
# authoritative memory). The human decides. This hook is that nudge.
#
# Also writes a session-start marker that the rehydrate hook uses
# to distinguish a fresh session from a mid-session compaction.

set -euo pipefail

TARGET_DIR="$HOME/.claude/loop-closed"
DRAFT_FILE="$TARGET_DIR/playbook-draft.md"
PLAYBOOK_FILE="$TARGET_DIR/playbook.md"
SESSION_MARKER="$TARGET_DIR/.session-start"

mkdir -p "$TARGET_DIR"
touch "$SESSION_MARKER"

# If no drafts, stay silent — don't add noise at session start.
[ -f "$DRAFT_FILE" ] || exit 0

PENDING=$(grep -cE '^\s*\[(PROCEDURAL|SEMANTIC|EPISODIC)\]' "$DRAFT_FILE" 2>/dev/null) || PENDING=0
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
