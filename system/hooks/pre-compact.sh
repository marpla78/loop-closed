#!/usr/bin/env bash
# PreCompact hook — write a small rescue anchor before Claude Code
# compacts context. The UserPromptSubmit rehydrate hook re-injects it
# on the next turn so the session picks up without re-exploration.
#
# Why this exists: compaction drops mid-flight context. PostCompact
# in Claude Code has no decision control and cannot inject context,
# so the rescue has to happen on the *next* UserPromptSubmit instead.
# This script is the write half; user-prompt-submit-rehydrate.sh is
# the read half.
#
# The snapshot filename is namespaced by session_id so concurrent
# sessions (different worktrees / clients) don't leak each other's
# compaction state.
#
# Keep the snapshot small — this is a pointer back to where we were,
# not a transcript replay.

set -euo pipefail

TARGET_DIR="$HOME/.claude/loop-closed"
mkdir -p "$TARGET_DIR"

INPUT=$(cat 2>/dev/null || echo '{}')
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // empty' 2>/dev/null || true)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "default"' 2>/dev/null || echo default)
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

STATE_FILE="$TARGET_DIR/compact-state.$SESSION_ID.md"

{
  echo "# Compaction Rescue — $TIMESTAMP"
  echo ""
  echo "Context was just compacted. Snapshot below — pick up from here, don't re-explore."
  echo ""

  if [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ]; then
    echo "## Last turns (most recent up to 8)"
    echo ""
    tail -n 40 "$TRANSCRIPT_PATH" 2>/dev/null \
      | jq -r 'select(.type=="user" or .type=="assistant")
          | .message.content
          | if type=="string" then .
            elif type=="array" then (map(select(.type=="text") | .text) | join(" "))
            else "" end
          | .[0:240]
          | select(length > 0)
          | "- " + .' 2>/dev/null \
      | tail -n 8 \
      || echo "- (transcript unreadable)"
    echo ""

    echo "## Files recently touched (chronological, most recent last)"
    echo ""
    # Preserve transcript order: awk dedup by first occurrence, then take
    # the last N — which are the chronologically most recent unique entries.
    tail -n 80 "$TRANSCRIPT_PATH" 2>/dev/null \
      | jq -r '.message.content?
          | select(type=="array")
          | .[]
          | select(.type=="tool_use")
          | select(.name=="Edit" or .name=="Write" or .name=="MultiEdit" or .name=="Read")
          | .name + ": " + (.input.file_path // .input.path // "?")' 2>/dev/null \
      | awk '!seen[$0]++' \
      | tail -n 10 \
      || echo "- (none detected)"
  else
    echo "(no transcript available — resume from user's next message)"
  fi
} > "$STATE_FILE"

# PreCompact doesn't inject context — just exit cleanly.
exit 0
