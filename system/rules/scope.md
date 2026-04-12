# Scope Rule

Change only what the request names. Adjacent code is off-limits even if it's wrong.

## DURING THE EDIT

- Touch only the named target — function, file, section, component.
- Match existing style, naming, and formatting — even if you disagree.
- Clean up only orphans *your* edit created: unused imports from code you just deleted.
- Pre-existing dead code: log it, don't delete it.

## OUT-OF-SCOPE OBSERVATIONS

You will notice things that are wrong but outside the request. Don't implement them.
Route them to the playbook feedback log before you respond.
One line each: what you saw, where it is, why it matters.

If you disagree with the approach itself (not just adjacent code), log it AND surface it in one sentence before continuing. The log alone is not sufficient for disagreements — those require a live flag.

---

## THE SCOPE TEST (runs before submitting any change)

1. Does every changed line trace to something the request named? If not — revert it.
2. Does the changed code match the style of what surrounds it? If not — fix it.
3. Did you log out-of-scope observations to the playbook? If not — log them now.
