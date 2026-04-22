# Maya's Design Playbook

*Shared brain for Maya + Claude. Swapped in from `templates/playbook-design.md` after 3 weeks on canonical — the domain-specific sections started earning their place.*

---

## Active Projects

| Project | Status | Current Phase | Last Touched |
|---------|--------|--------------|-------------|
| **Ledger** | Active | Pricing page redesign — v4 exploration | 2026-04-18 |
| **Ledger Design System** | Active | Token consolidation — merging `color-primary-*` into semantic aliases | 2026-04-12 |
| **Forge (marketing)** | Active | Mobile nav interaction pattern | 2026-04-05 |
| **Internal iconography** | On hold | Waiting on illustration lead hire | 2026-03-20 |

---

## Last Session

**Date:** 2026-04-18
**Project:** Ledger — pricing page

**Accomplished:**
- Shipped v3 of pricing layout (three-tier, with the "most popular" plate) — reviewed with @noah-eng, approved for implementation handoff
- Rebuilt the comparison table at 375px — was breaking on the right edge of iPhone SE

**Unresolved:**
- Annual/monthly toggle — the `active` state reads as a button, but it's a radio semantically. Screen reader announces it wrong.

**Decisions:**
- Keeping the "most popular" plate despite @noah's push to remove it — A/B data from Q1 shows a +12% conversion on the middle tier when plated
- Typography scale fixed at 14/16/20/28/40 — dropping the 24 tier

**Next session goals:**
1. Fix the toggle's a11y — use `role="radiogroup"` + `aria-pressed`, verify with VoiceOver
2. Export final tokens for the new pricing typography tier into `design-tokens.json`

---

## Feedback Log

*Every correction becomes a permanent rule. Confirmations too.*

> **[PROCEDURAL]** — how to work (always relevant). **[SEMANTIC]** — domain facts (stack, conventions). **[EPISODIC]** — dated events (incidents, one-off decisions). If unsure, tag [PROCEDURAL].

> **Security note:** Entries persist and load as high-authority context. Review `playbook-draft.md` before promoting (draft captures come from untrusted transcript content). Never store secrets here. On projects that read untrusted third-party code, review draft captures with extra care. Full threat model: `docs/security.md` in the loop-closed repo.

### [PROCEDURAL]
- 2026-02-09: Proposed a layout without screenshotting at 375px first — shipped, noah caught the overflow in review. Rule: Design QA's responsive check is not optional, even for "small" tweaks.
- 2026-03-04: CONFIRMED GOOD — asking @noah one concrete question before mid-session handoff (not a menu of options) shortens the review cycle. Keep doing.
- 2026-04-02: Shipped a component with hardcoded `#2A2D38` instead of `color-neutral-900`. Rule: never hardcode hex — always check token source first.

### [SEMANTIC]
- 2026-01-22: Ledger is Figma-primary. Designers own tokens; engineers consume via the weekly export job.
- 2026-03-11: Spacing is 4px base, not 8px. The old system was 8px and migration is 40% through — if you see a `spacing-8` utility, it's legacy, use `spacing-4` multiples.
- 2026-04-08: Forge uses a different type scale than Ledger. Don't cross-apply.

### [EPISODIC]
- 2026-03-17: Pricing v1 shipped with a contrast bug on the "most popular" plate — `color-accent-500` on `color-brand-100` = 3.8:1, below AA. Caught post-ship by compliance. Reshipped with `color-accent-600`. Added to Design QA checklist as an explicit step.

---

## Checklists

### Design QA
- [ ] Screenshot taken and critically analyzed
- [ ] Typography: correct fonts, weights, sizes, no descender clipping
- [ ] Spacing: multiples of 4px (current scale), no stray 8px legacy
- [ ] Colors: match brand tokens, no hardcoded hex
- [ ] Responsive: 375px, 768px, 1440px
- [ ] Accessibility: AA contrast, interactive targets ≥ 44px
- [ ] Craft push: one thing that elevates from "done" to "remarkable"
- [ ] Would you show this to someone whose taste you respect?

### Session Start — Quick
- [ ] Glance at Last Session
- [ ] Spec or micro-spec exists
- [ ] One genuine question for @noah (not a menu)

### Session End
- [ ] Update Last Session + Active Projects
- [ ] Add corrections and wins to Feedback Log
- [ ] Update Active Style Decisions if anything changed

### Retro
- [ ] Keep / Stop / New rule? Snapshot before applying.

---

## System Info

- **Version:** 1.0.0 (design variant swapped in 2026-03-25) | **Rules:** `~/.claude/loop-closed/rules/`

### Active Style Decisions
- **Typography scale:** 14/16/20/28/40px (dropped 24 on 2026-04-18)
- **Color token source:** `design-tokens.json` in `ledger/design-system/tokens/`
- **Spacing unit:** 4px base (migrating off 8px legacy — ~40% done)
- **Accessibility baseline:** WCAG 2.1 AA; interactive targets ≥ 44px

### Source of Truth
*Which system wins when two representations disagree. Fill this in once per project — the meta-decision that governs every other entry above.*

- **Tokens:** Figma variables (authoritative) → `design-tokens.json` via Style Dictionary on merge to `main`
- **Components:** Figma library for design; production React for implementation truth. When they disagree during handoff: Figma wins until handoff is complete, production wins after.
- **Copy:** Lokalise is canonical. Figma text is illustrative only — never paste directly into code.
- **Drift owner:** @maya-chen for design-side mismatches; @noah-eng for implementation drift. Quarterly audit on the first Monday.

*This block saved a full day in March when the implementation team thought the old 8px grid was still truth. One paragraph resolved it without a meeting.*
