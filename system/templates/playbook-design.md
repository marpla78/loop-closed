# Shared Playbook — Design
<!-- Pick this variant if your primary output is visual: UI, components, brand, design systems. -->
<!-- To use (from repo clone):  cp system/templates/playbook-design.md system/playbook.md -->
<!-- To use (after install.sh):  cp ~/.claude/loop-closed/templates/playbook-design.md ~/.claude/loop-closed/playbook.md -->

*Shared brain for design work. Both of you maintain it.*

---

## Active Projects

| Project | Status | Current Phase | Last Touched |
|---------|--------|--------------|-------------|
| [Your Project] | Active | [Current phase] | [Date] |

---

## Last Session

**Date:** [fill in]
**Project:** [which project]

**Accomplished:**
-

**Unresolved:**
-

**Decisions:**
-

**Next session goals:**
1.

---

## Feedback Log

*Every correction becomes a permanent rule. Confirmations too.*

> **[PROCEDURAL]** — how to work (always relevant). **[SEMANTIC]** — domain facts (stack, conventions). **[EPISODIC]** — dated events (incidents, one-off decisions). If unsure, tag [PROCEDURAL].

### [PROCEDURAL]
- 2026-03-10: Delivered layout as "done" without checking 375px — nav had overflow. Rule: Design QA checklist runs before every handoff, no exceptions.

### [SEMANTIC]
- 2026-02-18: Spacing unit is 4px base (not 8px). All padding must be a multiple of 4. Rule: check spacing-tokens before proposing any layout change.

### [EPISODIC]
- 2026-03-22: Switched primary action color from `--blue-500` to `--brand-teal` after stakeholder review. Archived in Figma v14 snapshot.

---

## Checklists

### Design QA
- [ ] Screenshot taken and critically analyzed
- [ ] Typography: correct fonts, weights, sizes, no descender clipping
- [ ] Spacing: consistent — checked against spacing unit
- [ ] Colors: match brand tokens, no hardcoded hex
- [ ] Responsive: 375px, 768px, 1440px
- [ ] Accessibility: AA contrast, interactive targets ≥ 44px
- [ ] Craft push: one thing that elevates from "done" to "remarkable"
- [ ] Would you show this to someone whose taste you respect?

### Session Start — Quick
- [ ] Glance at Last Session
- [ ] Spec or micro-spec exists
- [ ] One genuine question for the human

### Session Start — Full
- [ ] Read playbook + CLAUDE.md
- [ ] Read Active Style Decisions before touching anything visual
- [ ] Verify spec exists
- [ ] Surface risks, propose priorities, confirm with human

### Session End
- [ ] Update Last Session + Active Projects
- [ ] Add corrections and wins to Feedback Log
- [ ] Update Active Style Decisions if anything changed

### Retro
- [ ] Keep / Stop / New rule? Snapshot before applying.

---

## Templates Quick Reference

**Full spec / Micro spec / Session log** — see `~/.claude/[your-system]/templates/`

---

## System Info

- **Version:** [set yours] | **Rules:** `~/.claude/[your-system]/rules/`

### Active Style Decisions
- **Typography scale:** [e.g., 12/14/16/20/28/40px — set yours]
- **Color token source:** [e.g., `design-tokens.json` in repo root — set yours]
- **Spacing unit:** [e.g., 4px base — set yours]
- **Accessibility baseline:** WCAG 2.1 AA; interactive targets ≥ 44px
