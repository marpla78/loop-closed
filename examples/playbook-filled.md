# Sam's Playbook

*Shared brain for Sam + Claude. Claude reads this at session start. Sam can edit it in any text editor.*

---

## Active Projects

| Project | Status | Current Phase | Last Touched |
|---------|--------|--------------|-------------|
| **Quill** | Active | Stripe integration hardening — webhook reliability | 2026-03-28 |
| **hatch** | Active | v0.4.0 feature work — `hatch new` template system | 2026-03-25 |
| **Merano** | Active | Contact form validation bug, client waiting | 2026-03-27 |
| **Quill (marketing site)** | Active | Pricing page redesign — blocked on copy approval | 2026-03-15 |
| **Internal CLI tools** | On hold | Deprioritized until Quill ships v1.1 | 2026-02-20 |

---

## Last Session

**2026-03-28 — Quill / Stripe webhook retry**

Accomplished:
- Fixed the checkout edge case where webhook fires twice on flaky network (partial fix — main path works, retry behavior still inconsistent)
- Added email receipt template for successful payments (uses Resend, triggers in `lib/stripe/webhooks.ts` after `payment_intent.succeeded`)
- Updated Stripe API version from 2023-10-16 to 2024-04-10 — required updating 3 type signatures in `lib/stripe/types.ts` (`PaymentIntentCreateParams`, `CheckoutSessionCreateParams`, `WebhookEvent`)

Unresolved:
- Stripe webhook retry under flaky network: idempotency key approach insufficient — webhook fires correctly but Jotai state doesn't reflect the retry result. Tentatively: might be a race condition in the webhook handler. The atom update happens before the handler's Promise resolves, so a retry mid-flight can stomp the first result. Open issue #47.

Decisions:
- Ship the main fix without retry handling — affects <2% of transactions per Stripe dashboard, documented in issue #47 with reproduction steps
- Switched to Stripe 2024 API version — no breaking changes except the 3 type signatures; verified all existing tests still pass
- Did NOT use Stripe's built-in retry — our custom handler in `lib/stripe/webhooks.ts` is tightly coupled to Jotai atoms and switching would require a larger refactor; not worth it before v1.1 ships

Next session goals:
1. Investigate race condition in `lib/stripe/webhooks.ts` (check lines 43–67, specifically the handler registration order and where `checkoutAtom` is set relative to Promise resolution)
2. Write an integration test for the webhook retry path using Stripe's test webhook CLI
3. Review Merano's contact form — client pinged about a validation bug on the required fields (says required fields submit blank, likely a Zod schema issue in the Astro API route)

---

## Feedback Log

*Every correction becomes a permanent rule. Every confirmation of a good approach gets recorded too.*

> Three kinds of memory live here. Tag new entries so the right ones load at the right time:
> **[PROCEDURAL]** — how to work (workflow rules, always relevant). **[SEMANTIC]** — what's true about this project (domain facts: stack, conventions, architecture). **[EPISODIC]** — specific dated events (incidents, debugging sessions, one-off decisions). If unsure, tag [PROCEDURAL].

### [PROCEDURAL] — How to work on this project

*Workflow rules. Always loaded. Keep these tight — each one earns its place.*

**2026-01-03 — Always write the test before shipping a fix.** Fixed a session handler bug that immediately regressed because I shipped without a test. Not optional — even tiny fixes get a test if the path is regression-prone.

**2026-01-11 — Read the full error output before proposing a fix.** Claude suggested a fix for a TypeScript error based on the first line of the message; the actual cause was three lines down in the chain. Wasted 20 minutes. Full error first, always.

**2026-01-19 — Don't assume the error is in the file it appears in.** Got a runtime crash in `pages/api/checkout.ts` that Claude traced to that file. The actual bug was in `lib/stripe/session.ts` — the API route was just the first place it surfaced. Ask about the call chain before proposing fixes.

**2026-02-17 — CONFIRMED GOOD: Micro-spec before touching code, every time.** Tried skipping it once for a "quick" fix to the auth redirect. Ended up touching 4 files and breaking the OAuth flow. The sessions where Claude wrote a 3-line micro-spec first were consistently faster and produced fewer surprises. Keep doing this.

**2026-03-12 — Cross-project: Zod schema errors are almost never where they appear.** Both Quill and Merano use Zod for validation. In both projects, the runtime error surfaces in the route handler but the actual schema mismatch is in the shared schema file. Check `lib/schemas/` (Quill) or `src/schemas/` (Merano) before touching the route.

**2026-03-25 — CONFIRMED GOOD: Two-strike rule on approaches.** Claude hit the same wall twice trying to fix hatch's template resolution with path manipulation. On the second failure, flagged it and proposed a fundamentally different approach (embed the templates with `go:embed` instead of resolving paths at runtime). Worked immediately. The rule is right — if the same approach fails twice, it's the wrong approach.

### [SEMANTIC] — What is true about this project

*Domain facts: stack choices, architectural constraints, naming conventions, load-bearing decisions. These rarely change.*

**2026-01-27 — On Quill: business logic lives in `lib/`, not `app/`.** Quill's `lib/` holds stripe, auth, email, plans. The `app/` directory is mostly wiring. Proposing changes to `app/` without understanding `lib/` produces solutions that look right but break the actual data flow. Read `lib/` first, always.

**2026-02-04 — On Quill: state management is Jotai, never Zustand.** Quill uses Jotai throughout — atoms, derived atoms, async atoms for server state. Zustand is not a drop-in replacement; they have fundamentally different mental models. Any state recommendation must start from Jotai atoms. If it can't be expressed as an atom or selector, that's a design problem worth surfacing, not a reason to reach for Zustand.

**2026-03-01 — On hatch: Cobra conventions, not Go standard patterns.** hatch is CLI-first and uses Cobra. Its architecture follows Cobra conventions — don't swap the command registration for an `init()`-based approach common in Go libraries. That would break hatch's lazy-loading design entirely. Read `cmd/root.go` before suggesting structural changes.

**2026-03-07 — On Quill: Jotai async atoms don't behave like useEffect.** Webhooks fire server-side — there's no client-side event to hook into. The pattern for server-triggered state changes in Quill is: API route updates a server-side store, client polls via an async Jotai atom with a short interval. Don't propose `useEffect` for server-triggered sync.

**2026-03-18 — On Merano: 3 external integrations depend on specific URLs.** The contact form endpoint at `/api/contact` is wired to HubSpot. Two other endpoints (`/api/newsletter`, `/api/webhook`) feed Mailchimp and Zapier. Before proposing any route rename or restructure on Merano, check `docs/integrations.md`. Migration plan or it doesn't ship.

**2026-03-22 — On hatch: `--dry-run` is load-bearing, not redundant.** It's the primary way enterprise users audit what hatch will do before running it in CI. Two people in GitHub issues depend on it explicitly. Don't touch `--dry-run`.

### [EPISODIC] — Specific past events

*Dated incidents and one-off decisions. Useful for "have we seen this before?" — archived after 90 days (see Playbook Hygiene in memory-first.md).*

**2026-03-14 — Merano deploy rollback after CSS regression.** Shipped a Tailwind config change that broke the contact form's mobile layout; caught in client review, not CI. Rolled back via Netlify UI, reshipped with a Playwright visual test. One-off — the fix shipped, the lesson went into [PROCEDURAL] as the visual-regression test rule.

**2026-03-20 — hatch `go:embed` migration, issue #112.** Template resolution rewritten to use `go:embed` instead of runtime path lookups. Unblocked the two-strike rule confirmation above. Referenced occasionally when debugging template load order.

---

## Checklists

### Design QA
- [ ] Screenshot taken and critically analyzed (not rubber-stamped)
- [ ] Typography: correct fonts, weights, sizes, no clipping on descenders
- [ ] Spacing: consistent padding/margins, nothing cramped or floating
- [ ] Colors: match spec or brand, no default/placeholder colors
- [ ] Responsive: checked at 375px, 768px, 1440px
- [ ] Scroll/animation: smooth, intentional, not stock-feeling
- [ ] Z-index: no layering bugs
- [ ] Craft push: proposed ONE thing that elevates from "done" to "remarkable"
- [ ] The final question: would I be proud to show this to someone whose taste I respect?

### Session Start — Quick (continuation or < 30 min task)
- [ ] Glance at Last Session — continuing or starting fresh?
- [ ] Spec or micro-spec exists for this task
- [ ] One genuine question based on last session context

### Session Start — Full (new phase, new project, or > 30 min)
- [ ] Read this playbook — Last Session + Active Projects
- [ ] Read active project's CLAUDE.md
- [ ] Verify spec exists (if not, write one before anything else)
- [ ] Check: is this a bigger-picture decision that needs more thought first?
- [ ] Surface risks from last session
- [ ] Propose priorities

### Session End
*Before closing out any significant session.*
- [ ] Update "Last Session" section above
- [ ] Update "Active Projects" table (status, phase, date)
- [ ] Add any corrections from this session to the Feedback Log
- [ ] Add any confirmed-good approaches to the Feedback Log
- [ ] Note any system improvements worth making

---

## Templates Quick Reference

**Full spec:** ~/.claude/loop-closed/templates/spec-full.md
**Micro spec:** ~/.claude/loop-closed/templates/spec-micro.md
**Session log:** ~/.claude/loop-closed/templates/session-log.md

---

## System Info

- **Version:** 1.0.0
- **Built:** 2026-02-01
- **Rules location:** ~/.claude/loop-closed/rules/
- **To undo any system change:** keep snapshots before major changes
