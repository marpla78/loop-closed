# Shared Playbook — Backend
<!-- Pick this variant if your primary output is services, APIs, schemas, or data pipelines. -->
<!-- To use (from repo clone):  cp system/templates/playbook-backend.md system/playbook.md -->
<!-- To use (after install.sh):  cp ~/.claude/loop-closed/templates/playbook-backend.md ~/.claude/loop-closed/playbook.md -->

*Shared brain for backend/API work. Both of you maintain it.*

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

> **Security note:** Entries persist and load as high-authority context. Review `playbook-draft.md` before promoting (draft captures come from untrusted transcript content). Never store secrets here. Full threat model: `docs/security.md` in the loop-closed repo.

### [PROCEDURAL]
- 2026-02-14: Shipped a migration without a down() function. Took 40 min to recover. Rule: every migration needs a tested rollback path before it merges — no exceptions.

### [SEMANTIC]
- 2026-01-30: `/v1/events` is consumed by three external clients with pinned versions. Rule: treat all `/v1/` routes as frozen contracts — breaking changes require a new route.

### [EPISODIC]
- 2026-03-05: P95 latency on `/orders` spiked +340ms after adding eager-loading for `line_items`. Fixed with pagination + lazy load. Baseline now in Active Service Contracts.

---

## Checklists

### Pre-merge API Check
- [ ] Contract tested: all consumers covered
- [ ] Migration reversible: down() exists and run locally
- [ ] Perf delta measured: before/after numbers recorded
- [ ] Logs added: new code paths emit structured logs
- [ ] Metrics added: latency + error rate observable
- [ ] Error taxonomy consistent: uses project's existing error types
- [ ] No silent failures: every swallowed error has a log

### Session Start — Quick
- [ ] Glance at Last Session
- [ ] Spec or micro-spec exists
- [ ] One genuine question for the human

### Session Start — Full
- [ ] Read playbook + CLAUDE.md
- [ ] Review Active Service Contracts before touching any route or schema
- [ ] Verify spec exists
- [ ] Surface risks, propose priorities, confirm with human

### Session End
- [ ] Update Last Session + Active Projects
- [ ] Add corrections and wins to Feedback Log
- [ ] Update Active Service Contracts if any changed

### Retro
- [ ] Keep / Stop / New rule? Snapshot before applying.

---

## Templates Quick Reference

**Full spec / Micro spec / Session log** — see `~/.claude/[your-system]/templates/`

---

## System Info

- **Version:** [set yours] | **Rules:** `~/.claude/[your-system]/rules/`

### Active Service Contracts
- **Route:** [e.g., `GET /v1/users/:id`] — **Consumers:** [list] — **Perf baseline:** [e.g., P95 < 80ms]
- **Schema:** [e.g., `orders` table] — **Policy:** [e.g., additive-only until v2]
- **Error format:** [e.g., RFC 7807 — `type`, `title`, `status`, `detail`]

### Source of Truth
*Which artifact wins when contract, code, and docs disagree. Fill this in once per project — the meta-decision that governs every Active Service Contract above.*

- **API contract:** [OpenAPI spec / production behavior / generated clients — which is authoritative on disagreement]
- **Schema:** [migration files / ORM model / production DB dump — which wins]
- **Error taxonomy:** [where error types, codes, and shapes are canonically defined]
- **Drift owner:** [named person or role who reconciles when they diverge — without an owner, the rule is a wish]

*Filled example: API contract: `api/openapi.yaml` (generated clients consume it). Schema: migration files in `db/migrations/` authoritative; ORM models regenerated. Error taxonomy: `errors.ts`. Drift owner: @backend-lead.*
