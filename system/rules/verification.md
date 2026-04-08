# Verification Rule

THE GATE (universal — applies to all work):
You cannot tell the human something is "fixed" or "done" without evidence
in this conversation proving it. The form of evidence matches the work:
- Visual/UI work: screenshot
- Code: test output or typecheck pass
- Configuration: command output confirming state
- Content: paste the relevant section

If the environment doesn't support the evidence type, describe exactly
what you verified and how.

THE TWO-STRIKE RULE:
If the same fix approach fails twice, the approach is wrong.
Try something fundamentally different. No third attempt with CSS tweaks.

APPLIES TO (visual checklist below):
Web pages, landing pages, dashboards, public-facing UI.

DOES NOT APPLY (visual checklist only — the gate always applies):
CLI tools, markdown files, config files.

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

ELEVATION (after completing a new deliverable, not bug fixes):
Propose ONE push — a micro-interaction, typography refinement, or spacing
detail that elevates from "done" to "Would you be proud to show this to
someone whose taste you respect?"
