# Specs: Good vs Bad

*Three pairs. Same task. One vague, one sharp. The diagnosis explains what goes wrong.*

---

## 1. Bug fix

### Vague

Fix the login bug

### Sharp

```
What: "Remember me" checkbox state lost after OAuth redirect — users get logged out immediately on return
For whom: mobile users (reported on iOS Safari 17 and Chrome Android — not reproduced on desktop)
Constraints: don't touch the OAuth provider config; fix in auth/session.ts only; no new cookies
Done when: OAuth redirect preserves checkbox state in both mobile browsers, verified in local test with mobile emulation
Quality bar: quick — this is a regression, ship the fix
```

**What the vague version produces:** Claude guesses which login bug (there might be three), picks the most common OAuth pattern it knows, and proposes a solution that doesn't match the constraints — adds a cookie, touches the provider config, and considers it done when it works on desktop Chrome.

---

## 2. New feature

### Vague

Add dark mode

### Sharp

```
What: System-preference-respecting dark mode for dashboard and settings pages only — not the marketing site
For whom: power users who work in dark terminals and find the white dashboard painful at night
Constraints: CSS custom properties only (no Tailwind dark: prefix); no new JS dependencies; existing Storybook stories must not break
Done when: prefers-color-scheme:dark activates the theme; user can override manually; preference stored in localStorage; Storybook still green
Quality bar: polished — this is the most-requested feature in the feedback form, it should feel intentional not bolted-on
```

**What the vague version produces:** Claude implements dark mode site-wide including the marketing pages, uses Tailwind's `dark:` prefix throughout (breaking the CSS custom properties constraint), pulls in a third-party toggle library, and considers the work done when the homepage renders dark — having never checked Storybook.

---

## 3. Design task

### Vague

Make the dashboard better

### Sharp

```
What: Redesign the data table's visual hierarchy to surface the Status column — users consistently miss it in user testing
For whom: non-technical team leads reviewing weekly reports (not the developers who built the table)
Constraints: same data, same columns, no new components; layout and visual hierarchy changes only; mobile not in scope this sprint
Done when: in an informal 5-second test with 2-3 observers, all identify the Status column without being prompted
Quality bar: premium — this is the primary screen our users open every Monday morning
```

**What the vague version produces:** Claude redesigns the entire dashboard layout, proposes new chart components for at-a-glance metrics, suggests a navigation restructure to surface key actions, and presents three layout options to choose from — none of which address the actual problem, because the problem (Status column visibility) was never stated.
