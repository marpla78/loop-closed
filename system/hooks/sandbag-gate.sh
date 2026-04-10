#!/usr/bin/env bash
# Sandbag Gate — injects a pre-output check into Claude's context
# before every user message.
#
# Why this exists: the sandbag gate in rules/verification.md is text.
# Text-based rules compete with trained defaults and lose. A hook runs
# OUTSIDE the generation loop and modifies context before the model
# generates anything — which is the only layer where this can be
# structurally enforced, not just documented.
#
# If you find yourself asking your AI "did you play safe?" and it
# finds real hedges on inspection, that's the failure this is fixing.
#
# Installed by install.sh. To activate: open /hooks once or restart
# Claude Code so the settings watcher picks it up.

cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"[SANDBAG GATE — runs BEFORE you reply]\nBefore any plan, spec, decision, or recommendation:\n1. Did you present options instead of committing? Pick one.\n2. Did you hedge (\"consider\", \"perhaps\", \"might want to\")? Commit.\n3. Did you punt work to \"next session\"? Ship it now.\n4. What did you leave on the table? Add it or explain why not in one sentence.\nIf any answer is yes, fix it BEFORE you reply — not after the human asks \"did you play safe?\""}}
EOF
