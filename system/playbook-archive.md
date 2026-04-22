# Playbook Archive

*Cold storage for [EPISODIC] entries older than 90 days.*

Episodic entries are dated events — incidents, one-off decisions, debugging sessions. Useful for "have we seen this before?" but not worth loading into every session. When the active playbook crosses its soft cap (~2,000 tokens / ~150 lines), the oldest episodic entries move here.

**What belongs here:**
- [EPISODIC] entries older than 90 days from the active Feedback Log

**What does NOT belong here:**
- [PROCEDURAL] entries — workflow rules stay in the active playbook forever
- [SEMANTIC] entries — domain facts stay in the active playbook forever
- Session logs, meeting notes, planning docs — those live elsewhere

**How to use it:**
Your AI reads this file only when explicitly asked ("have we run into this before?", "check the archive for X"). It is not loaded at session start.

---

## Archived Episodes

*Append archived entries below, newest first. Keep the original date — don't rewrite history.*

<!-- Example entry format:
- 2025-12-03: Debugged a race in stripe.ts — root cause was async atom order. Fixed by awaiting the handler Promise before the atom set. Resolved in PR #42.
-->
