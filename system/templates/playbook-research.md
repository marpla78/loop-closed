# Shared Playbook — Research
<!-- Pick this variant if your primary output is hypotheses, experiments, findings, or literature syntheses. -->
<!-- To use (from repo clone):  cp system/templates/playbook-research.md system/playbook.md -->
<!-- To use (after install.sh):  cp ~/.claude/loop-closed/templates/playbook-research.md ~/.claude/loop-closed/playbook.md -->

*Shared brain for research work. Both of you maintain it.*

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

> **[PROCEDURAL]** — how to work (always relevant). **[SEMANTIC]** — domain facts (stack, conventions). **[EPISODIC]** — dated events (incidents, one-off decisions). Experiments ARE episodes — this section is heavier in research work. If unsure, tag [PROCEDURAL].

### [PROCEDURAL]
- 2026-02-28: Cited a secondary source as primary — the original study had a smaller n and different population. Rule: always trace citations to the primary source before recording a finding.

### [SEMANTIC]
- 2026-01-20: The domain distinguishes "engagement" (clicks, time-on-page) from "comprehension" (recall, transfer). They measure different constructs and often diverge. Rule: name the exact construct being measured in every hypothesis. *(Example shown assumes UX research — replace with your domain's core distinctions.)*

### [EPISODIC]
- 2026-03-15: 6-participant usability test on v3. Key finding: users expected inline validation, not end-of-form errors. Error recovery time dropped 60% after fix. Notes: `/research/sessions/2026-03-15.md`.
- 2026-04-01: H2 ("shorter onboarding reduces drop-off") tested on 200 users. Result: no effect (p=0.41). Hypothesis falsified. Next question logged in Live Hypotheses.

---

## Checklists

### Experiment Log
- [ ] Hypothesis stated: falsifiable claim, not a goal
- [ ] Method documented: participants, conditions, what was measured
- [ ] Result recorded: actual numbers — null results count
- [ ] Confidence assessed: sample size, confounds, replication risk
- [ ] Next question derived from this result
- [ ] Filed at: [path to notes/data]

### Session Start — Quick
- [ ] Glance at Last Session
- [ ] Trigger question confirmed: what are we trying to learn or decide?
- [ ] One genuine question for the human

### Session Start — Full
- [ ] Read playbook + CLAUDE.md
- [ ] Review Live Hypotheses + Key References
- [ ] Confirm the research question — not just the topic
- [ ] Surface open threads, propose approach, confirm with human

### Session End
- [ ] Update Last Session + Active Projects
- [ ] Add corrections and wins to Feedback Log
- [ ] Move completed experiments from Live Hypotheses → [EPISODIC]
- [ ] Update Key References if new anchor sources used

### Retro
- [ ] Keep / Stop / New rule? Snapshot before applying.

---

## Templates Quick Reference

**Full spec / Micro spec / Session log** — see `~/.claude/[your-system]/templates/`

---

## System Info

- **Version:** [set yours] | **Rules:** `~/.claude/[your-system]/rules/`

### Live Hypotheses
- **H1:** [Falsifiable claim] — **Status:** Untested — **Test plan:** [how you'd test it]
- **H2:** [Falsifiable claim] — **Status:** In progress — **Signal:** [what confirms or denies it]

### Key References
- [Author, Year] — [Title] — [What it establishes for this project] — [Link or path]
