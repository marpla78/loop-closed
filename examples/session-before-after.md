# Session Before / After

*The same bug. Two different Mondays. The difference is the playbook.*

---

## Before — Monday, no playbook

Sam opens Claude Code. It's been four days since Friday's session on the Stripe webhook retry bug. There's no session log because the session felt productive but ran long, and by the end Sam just closed the window.

Sam types: "Hey, I'm working on a Stripe webhook issue in my Next.js app where the retry fires but the state doesn't update correctly."

Claude asks what state management Sam is using. Sam has answered this before, in at least three previous sessions. Sam types "Jotai." Claude responds: "Got it — Jotai is similar to Zustand in a lot of ways, so we can apply a similar pattern here..."

It's not similar to Zustand. They have fundamentally different mental models. Sam corrects this. Claude acknowledges and moves on.

Claude suggests using Stripe's built-in retry mechanism with the `maxNetworkRetries` config option. Sam explains that their webhook handler is custom — it's tightly coupled to Jotai atoms and can't use Stripe's built-in retry without a larger refactor they're not ready to do. Claude didn't know the handler was custom because there's no session context and it hasn't read `lib/stripe/` yet.

Claude pivots and proposes adding a `useEffect` hook to sync the webhook state when the response comes back. Sam corrects it: the webhook fires server-side. There's no client-side event. The state update has to happen through the server. Claude apologizes and revises.

Claude suggests wrapping the handler in a `useCallback` to stabilize the reference. Sam explains again that this is a server-side handler — `useCallback` doesn't apply. It's not a React component. Claude apologizes again.

Twenty-five minutes in, Claude proposes an idempotency key approach: store the webhook event ID and skip processing if it's been seen. Sam recognizes this immediately. They tried it two weeks ago. It was documented as insufficient in a Slack message Sam sent themselves. The idempotency key prevents double-processing, but it doesn't solve the race condition — the Jotai atom update still happens before the handler's Promise resolves, so a retry mid-flight stomps the first result. Sam explains all of this again.

Sam pastes the relevant section of `lib/stripe/webhooks.ts` — lines 43 through 67, the handler registration — because there's no other way to get Claude oriented. This is the third time Sam has pasted this code across different sessions. Claude reads it and finally produces something that looks like it's aimed at the actual problem.

But it's 9:45 AM now. Sam has a standup at 10:00. There's not enough time to test the proposed fix properly, and Sam doesn't fully trust it because the path to get here was so erratic. The fix gets deferred. No session log gets written. Next Monday: the same conversation starts over.

Total: 40 minutes to rebuild context that should have been free.

---

## After — Monday, with playbook

Before Sam types anything, Claude reads the playbook. In 30 seconds it knows:

- Stack: Next.js 14, Jotai (not Zustand — explicitly noted), custom Stripe integration in `lib/stripe/`
- Last session: Stripe webhook retry — idempotency key approach tried and ruled insufficient, race condition suspected in `lib/stripe/webhooks.ts` lines 43–67 where `checkoutAtom` is set before the handler's Promise resolves. Issue #47 is open.
- Feedback log: "Don't suggest Zustand in Quill — Jotai, not interchangeable" and "Stripe webhook handler is custom — don't suggest Stripe's built-in retry without reading `lib/stripe/` first" and "Jotai async atoms don't behave like `useEffect` — webhooks are server-side, client doesn't have an event to hook into"

Claude's first message: "Picking up from last session — the race condition in the webhook handler. Want to write a quick micro-spec before touching code? My instinct is to start in `webhooks.ts` around lines 43–67 and look at the timing of the atom update relative to the Promise."

Sam says yes. The micro-spec takes 90 seconds: what are we fixing, what's the constraint, how do we know it's done.

Claude reads `lib/stripe/webhooks.ts` directly — not generic Stripe docs, not the Next.js docs for API routes. It reads the actual file. It sees the registration pattern and the atom update on line 58, before the Promise resolves on line 61.

First approach: move the handler registration to fire after the initial processing completes, adjusting the order so the atom update happens inside the resolved Promise chain. Tested in the webhook simulator. The timing changes but the race condition persists under load — two retries in quick succession still stomp each other.

Two attempts at the same approach. Claude recognizes the pattern without Sam prompting it: "Two tries at adjusting timing, both insufficient. That's telling me the approach is wrong, not the implementation. Different angle: what if we use an Jotai atom with a write function that checks the current state before applying the update — make the update itself idempotent at the atom level rather than at the webhook level?"

This is different from the idempotency key approach. That prevented double processing. This makes the state update safe to apply twice — if the atom already reflects the completed state, a duplicate update is a no-op.

Second approach: update the `checkoutAtom` write function to compare the incoming status against current state before applying. Works. Tested with two simultaneous retries in the webhook simulator — second update is silently dropped, state is correct.

Claude writes the session log before Sam closes the window. Last session entry updated, Active Projects table updated, Feedback Log gets one new entry confirming the two-strike approach.

Next Monday: warm start.

Total: 12 minutes.

---

*The difference isn't Claude's intelligence. It's the infrastructure around the conversation.*
