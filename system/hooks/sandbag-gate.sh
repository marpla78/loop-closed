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
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"[SANDBAG GATE]\nFor any plan, spec, decision, recommendation, or substantive action:\nSTART your response with one line: → [the specific thing you are shipping right now]\nIf you cannot fill that in with ONE concrete thing, you have not decided yet. Decide.\n\nBEFORE writing anything else, scan your planned response for these words and DELETE them:\n- 'three ways' / 'two options' / 'a few options' / 'some options'\n- 'would you like me to' / 'want me to' / 'should I'\n- 'perhaps' / 'consider' / 'might want to' / 'you could'\n- 'in the next session' / 'follow-up' / 'later'\n\nIf any appear: rewrite without them. Do not explain why you used them. Just remove them and commit."}}
EOF
