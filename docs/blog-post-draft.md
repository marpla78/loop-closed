# Your AI Forgets Everything You Teach It. Here's How I Fixed It.

*Draft — for publication on [your platform]*

---

Monday morning. Open Claude Code. I type: "As I mentioned last week, there's this edge case in the checkout flow where..." and stop mid-sentence.

It has no idea what I mentioned last week. It doesn't know the project. Doesn't know that we spent 45 minutes on this exact bug on Friday. Doesn't know that I've already rejected the standard Stripe implementation three separate times because we use a custom handler.

Start over. Again.

---

It's not Claude's fault. Sessions are stateless by design. Each one starts fresh — not because the model forgot, but because it never had access to what happened before. The session ended, the context evaporated, and whatever I taught it on Friday is gone.

Every correction I made — "don't suggest that library, we use this one" — disappeared the moment I closed the window. Every piece of context I rebuilt from scratch — the stack, the architecture decisions, the things we've already tried — gone.

Most people's response to this is to write a longer first message. Context dump at the top of every session. That works, kind of. But it's doing the memory work manually, every session, forever. You're compensating for missing infrastructure by doing infrastructure work by hand.

The feedback loop never closes. You keep teaching the same lessons. The relationship resets.

I recognized the pattern around session 8 or 9. It wasn't that Claude was making bad suggestions — it was making reasonable suggestions for a project it knew nothing about. The problem wasn't the AI. It was the lack of any persistent layer between sessions. Every session started with the same blank slate. The same questions. The same recalibration period.

That's an infrastructure problem. Infrastructure problems have infrastructure solutions.

---

Two files. Not one.

Most Claude Code users have a CLAUDE.md — a set of behavioral rules that tell the AI how to work. Don't do X, always verify before saying done, run this test before shipping. It's the operating manual. It handles explicit knowledge: principles, rules, what to do in general.

What I was missing was a place for experiential knowledge. The stuff that's only true for this project, this week. The checkout flow uses a custom Stripe integration in lib/stripe/. Zustand isn't used here — we use Jotai and they're not interchangeable. The webhook retry behavior is an open issue. That's not rules — that's memory.

The second file is a shared playbook. A plain markdown file that both the AI and I maintain. Active projects with their current status. A Last Session log that captures what we built, what's unresolved, and what comes next. A feedback log where every correction gets written down before the session ends.

Together: the CLAUDE.md (behavioral rules) and the playbook (accumulated memory). The AI reads both before touching anything. Session 10 starts where session 9 ended. The loop closes.

I called this architecture "Two Brains" — one for principles, one for experience. The insight is that you need both. One without the other is either stateless behavior or unstructured memory. Combined, they give you something that actually compounds.

---

Three rules changed how I work. Not in a "productivity hack" way — in a way where the sessions felt structurally different. Worth explaining each one honestly.

**The efficiency decision tree.** Before any tool call — before searching for a file, running a command, checking documentation — run this silent test: do I already know this? Six steps in order: already in context, then memory files, then CLAUDE.md, then local file read, then CLI command, then and only then call an external service.

I added this because I kept watching the AI run redundant searches. It would search for a file I'd already mentioned in that same session. Pull documentation for a library we'd used three times that morning. The decision tree cut that out almost entirely. The surprising effect: sessions feel faster even when the total work is the same. Less noise.

The rule also changed how I think about my own work. Before asking a question, I now check whether I already know the answer. That's a habit that showed up in my non-AI work too. You start noticing how often you reach for a search when you already have the information.

**The two-strike rule.** Same approach fails twice, the approach is wrong. Stop entirely. Try something fundamentally different. No third CSS tweak. No refined version of the same idea.

Before this rule, I'd watch the AI iterate on a broken direction four, five times. Each attempt a small variation on the last. The variation felt like progress because something was changing. But the underlying approach was wrong and small variations weren't going to fix it. The two-strike rule forces an exit from that loop. The first failure is data. The second failure is a signal. The third attempt at the same approach is stubbornness.

The psychological shift this required was being willing to say "this direction is wrong" after two attempts instead of "let me refine it once more." That's harder than it sounds. There's a momentum to a direction you've already committed two attempts to. The rule makes the exit point explicit, which makes it easier to take.

**The feedback log.** Every correction gets recorded immediately, before the session ends. "Don't suggest Zustand — we use Jotai." But also: every confirmation. When something works and I confirm it worked, that goes in too. The log is not just a list of failures.

What I didn't expect: recording confirmed-good approaches was as valuable as recording corrections. In sessions after I confirmed a pattern, the AI used it without prompting. The positive feedback loop compounds just like the correction loop does. It turns out praise is load-bearing, not just politeness.

The feedback log starts thin. After 10 sessions it has teeth.

---

Four sessions in, the changes weren't dramatic. That's worth saying plainly — I'm not going to describe a transformation. What actually changed: sessions start knowing the context. The 40-minute debug session that was mostly re-establishing what we already knew became 12 minutes. Not because the AI got smarter. Because the infrastructure got better.

The cost is real. The playbook needs maintenance. If I don't write the session log before I close the window, the loop doesn't close. It's 5 minutes at the end of a session, and it requires the discipline to do it even on the sessions that ran long and you're tired. The compounding only works if you show up for the maintenance. Most tools don't ask that of you. This one does.

The return on 5 minutes of maintenance is felt most on the Mondays after a complicated Friday. Context transfers. Corrections stick. The work continues from where it stopped.

---

The repo is at github.com/marpla78/loop-closed — fork it, make it yours. Takes 10 minutes to set up via the install script. Two weeks to feel different.

What's inside: one constitutional file that tells Claude how to work, three behavioral rules that auto-load every session, a shared playbook template, and filled examples showing what it looks like after a month of real use.

What to change first: the "About You" section in CLAUDE.md. That's where you describe who you are and how you work. Everything else can wait until the first session.

---

This won't work if you treat it as a configuration file you install and forget.

The playbook needs you to write in it. The feedback log needs honest corrections — specific ones, not vague ones. "AI was bad at CSS" is noise. "Don't use inline styles for layout — always a flexbox or grid solution because inline styles break at the first media query" is a rule. The specificity is the whole point.

There's a version of this where you set it up, write two feedback entries, and stop. The system will be marginally better than nothing. The version where it actually earns its weight is the one where you treat the end-of-session log as non-optional. Not every session. Not a formal process. Just: what did we build, what's unresolved, what did I correct.

Five minutes. Before you close the window.

The system is as good as what you put into it. That's true of every tool worth using.

The loop closes when you close it.
