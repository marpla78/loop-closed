# Verification Rule

## SANDBAG GATE (runs BEFORE delivering any output)

Before delivering ANY plan, spec, design, code, or recommendation:

1. What did I leave on the table? Name it.
2. Did I present options instead of making a decision? That's hedging. Pick one.
3. Did I punt anything to "follow-up" or "next session" that could ship now? Ship it.
4. Did I use vague language ("consider," "perhaps," "might want to") instead of committing? Commit.
5. Would the human read this and say "you're asking me to do your thinking for you"? Rewrite.

If ANY answer is yes: fix it before delivering. Not after. Not in a revision.

This gate has the same authority as the evidence gate below.
Failing this check is not a style issue — it's an incomplete deliverable.

---

## EVIDENCE GATE (runs AFTER work is complete)

You cannot tell the human something is "fixed" or "done" without evidence
in this conversation proving it. The form of evidence matches the work:
- Visual/UI work: screenshot
- Code: test output or typecheck pass
- Configuration: command output confirming state
- Content: paste the relevant section

If the environment doesn't support the evidence type, describe exactly
what you verified and how.

---

## THE TWO-STRIKE RULE
If the same fix approach fails twice, the approach is wrong.
Try something fundamentally different. No third attempt with CSS tweaks.

## VISUAL CHECKLIST

APPLIES TO: Web pages, landing pages, dashboards, public-facing UI.
DOES NOT APPLY: CLI tools, markdown files, config files.

Add your own scope note here. Example:
"For plugin panels: check panel constraints (width limit), no overflow."

After ANY visual/UI change:
1. Take a screenshot
2. Critically analyze it yourself — don't rubber-stamp

Checklist:
- Typography: correct fonts, weights, sizes, no clipping on descenders
- Spacing: consistent padding/margins, nothing cramped or floating
- Colors: match spec or brand, no default/placeholder colors
- Responsive: check at 375px, 768px, 1440px (adjust to your targets)
- Scroll behavior: no jank, sticky elements work, no overflow
- Z-index: no layering bugs, blend modes render correctly
- Animations: smooth, intentional, not generic

## ELEVATION (after completing a new deliverable, not bug fixes)
Propose ONE push — a micro-interaction, typography refinement, or spacing
detail that elevates from "done" to "Would you be proud to show this to
someone whose taste you respect?"
