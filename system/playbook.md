# Shared Playbook

*This is your shared brain. You can open it in any text editor. Your AI reads it at the start of every session. Both of you maintain it.*

---

## First Use — Fill This In

1. Add your active projects to the Active Projects table below
2. Set your system path in System Info
3. Read the CLAUDE.md — the "About You" section needs your info
4. Start a session — your AI will read this file first

> The playbook starts useful on day 1 and becomes essential by week 2.
> Don't optimize it. Just use it.

---

## Active Projects

> Replace the row below with your actual projects.

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

*Every correction becomes a permanent rule. Every confirmation of a good approach gets recorded too.*

> Replace these with your actual feedback entries. Corrections AND confirmations both belong here.

- 2026-01-01: Always run typecheck before saying something is done — caught 3 silent failures in a row. Rule: verification requires evidence, not confidence.
- 2026-01-08: Don't suggest library X — this project uses library Y, they serve different use cases and aren't interchangeable. Rule: read the imports before recommending dependencies.
- 2026-01-15: The "one question at a time" approach worked well in the planning session — keep doing this for complex decisions, it prevents overwhelm.
- [date]: The AI read the "push harder" rule, acknowledged it, and still produced a conservative plan. Rule isn't the problem — execution is. Fix: bold version must be drafted FIRST, before any output. "Push harder" is a pre-output filter, not a post-hoc correction. If the human has to say "did you play safe?" — that's a miss.
- [date]: Added scope.md as the 4th rule — surgical change discipline from reviewing Karpathy's CLAUDE.md template. loop-closed-native move: out-of-scope observations route to the playbook feedback log instead of expanding the diff. Also promoted two-strike rule to a named, discoverable concept in the README.

---

## Checklists

### Design QA
*Run this before showing any visual/UI work to the human. Don't skip it. Don't present unfinished work.*

- [ ] Screenshot taken and critically analyzed (not rubber-stamped)
- [ ] Typography: correct fonts, weights, sizes, no clipping on descenders
- [ ] Spacing: consistent padding/margins, nothing cramped or floating
- [ ] Colors: match spec or brand, no default/placeholder colors
- [ ] Responsive: checked at 375px, 768px, 1440px
- [ ] Scroll/animation: smooth, intentional, not stock-feeling
- [ ] Z-index: no layering bugs
- [ ] Craft push: proposed ONE thing that elevates from "done" to "remarkable"
- [ ] The final question: Would you be proud to show this to someone whose taste you respect?

### Session Start — Quick (continuation or < 30 min task)
- [ ] Glance at Last Session — continuing or starting fresh?
- [ ] Spec or micro-spec exists for this task
- [ ] One genuine question for the human (not "what do you want to do?" — something specific from last session context)

### Session Start — Full (new phase, new project, or > 30 min)
- [ ] Read this playbook — Last Session + Active Projects
- [ ] Read active project's CLAUDE.md
- [ ] Verify spec exists (if not, write one before anything else)
- [ ] Check: does this task call for more capable model or faster model?
- [ ] Surface risks from last session
- [ ] Propose priorities + confirm with the human
- [ ] One genuine question for the human

### Session End
*Before closing out any significant session.*

- [ ] Update "Last Session" section above
- [ ] Update "Active Projects" table (status, phase, date)
- [ ] Add any corrections from this session to the Feedback Log
- [ ] Add any confirmed-good approaches to the Feedback Log
- [ ] Write memory files for anything important learned
- [ ] Note any system improvements worth making

**Trigger:** When the human signals the session is winding down, offer:
"Want me to update the playbook before we close?" One sentence, not an interruption.

### Retro
*Run after completing a project phase or milestone. Not on a schedule — on a trigger.*

- [ ] What went well this phase? (keep doing)
- [ ] What went poorly? (stop doing)
- [ ] Any pattern that showed up 2+ times? (candidate for a new rule)
- [ ] Propose system updates — new rule? Template update? Playbook section?
- [ ] Apply approved changes
- [ ] Create snapshot of your system before applying
- [ ] Update CHANGELOG.md
- [ ] Bump VERSION

---

## Templates Quick Reference

**Full spec** — for any task that will take more than 30 minutes:
See `~/.claude/[your-system]/templates/spec-full.md`

**Micro spec** — for quick tasks (30 seconds to fill in):
See `~/.claude/[your-system]/templates/spec-micro.md`

**Session log** — template for the Last Session section above:
See `~/.claude/[your-system]/templates/session-log.md`

---

## System Info

- **Version:** [set yours]
- **Built:** [date]
- **Spec:** (path to your design spec if you have one)
- **Rules location:** ~/.claude/[your-system]/rules/
- **To undo any system change:** keep snapshots before major changes
- **Max rule files:** keep them few — each should earn its place
