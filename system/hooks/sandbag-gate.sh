#!/usr/bin/env bash
# Verification Gates Hook — injects the sandbag gate AND the adversarial test
# into Claude's context before every user message.
#
# Historical filename (sandbag-gate.sh) kept for install-compatibility.
# The file now enforces two gates from rules/verification.md:
#
#   1. SANDBAG GATE (pre-output): force bold commitment, strip hedging language.
#   2. ADVERSARIAL TEST (pre-declaration): before declaring anything done,
#      name one way it could be wrong that hasn't been verified, and verify
#      it instead of shipping with a caveat.
#
# Why two injections in one hook: both fire on UserPromptSubmit, both
# modify the same context window, and Claude Code registers one command
# per matcher entry. Splitting into two scripts would double the hook
# overhead without a behavioral gain.
#
# The evidence gate is NOT enforced here — it runs after work is done and
# requires surface-specific proof (screenshot, test output, dry-run). The
# human audit is its backstop.
#
# If you find your AI asking "did you play safe?" and finding real hedges
# or missed failure modes on inspection, that's the failure this is fixing.
#
# Installed by install.sh. To activate: open /hooks once or restart
# Claude Code so the settings watcher picks it up.

cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"[SANDBAG GATE]\nFor any plan, spec, decision, recommendation, or substantive action:\nSTART your response with one line: → [the specific thing you are shipping] (skip for conversational replies with no decision or action)\nIf you cannot fill that in with ONE concrete thing, you have not decided yet. Decide.\n\nBEFORE writing anything else, scan your planned response for these words and DELETE them:\n- 'three ways' / 'two options' / 'a few options' / 'some options'\n- 'would you like me to' / 'want me to' / 'should I'\n- 'perhaps' / 'consider' / 'might want to' / 'you could'\n- 'in the next session' / 'follow-up' / 'later'\n\nIf any appear: rewrite without them. Do not explain why you used them. Just remove them and commit.\n\n[ADVERSARIAL TEST]\nBefore declaring any deliverable done in this response, name one way it could be wrong that you haven't checked. If you can name one, verify it first — do not ship it as a caveat. If after honest effort you cannot name one, proceed.\n\nRun the test against the specific claim you're about to make. 'Looks good' is not honest effort. 'I checked X but not Y' is. If the deliverable crosses a boundary (install, deploy, handoff), the test MUST include whether your evidence crossed that boundary — local Edit applying is not end-to-end proof."}}
EOF
