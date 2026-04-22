#!/usr/bin/env bash
# UserPromptSubmit hook — re-inject the pre-compaction snapshot on the
# first user prompt after a compaction event.
#
# Why this exists: PostCompact in Claude Code has no decision control
# and cannot add context. UserPromptSubmit CAN — it supports
# hookSpecificOutput.additionalContext. Pairs with pre-compact.sh.
#
# Fires on every prompt; fast-exits when there is nothing to rehydrate.
# Self-consuming: once the snapshot is injected it's renamed so the
# next prompt doesn't keep replaying it.

set -euo pipefail

TARGET_DIR="$HOME/.claude/loop-closed"
STATE_FILE="$TARGET_DIR/compact-state.md"
SESSION_MARKER="$TARGET_DIR/.session-start"

# Nothing to do if no snapshot exists.
[ -f "$STATE_FILE" ] || exit 0

# If the snapshot is older than this session's start marker, it was
# already consumed (or belongs to a previous session). Skip.
if [ -f "$SESSION_MARKER" ] && [ "$STATE_FILE" -ot "$SESSION_MARKER" ]; then
  exit 0
fi

CONTENT=$(cat "$STATE_FILE")

jq -nc --arg ctx "[POST-COMPACTION REHYDRATION]
The session was just compacted. The snapshot below captures what was in flight. Resume from here — do not re-ask the user for context already present.

$CONTENT" '{hookSpecificOutput: {hookEventName: "UserPromptSubmit", additionalContext: $ctx}}'

# Mark consumed so this fires exactly once per compaction.
mv "$STATE_FILE" "${STATE_FILE}.consumed.$(date +%s)" 2>/dev/null || rm -f "$STATE_FILE"

exit 0
