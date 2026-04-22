# Security

## The risk

`CLAUDE.md` and `playbook.md` load as high-authority context — the full files, every session. Claude Code does not truncate `CLAUDE.md`, so whatever lives there is effectively part of the system prompt. Malicious content in untrusted code, API responses, or external files that the AI reads can be laundered through auto-capture and written into memory, persisting across sessions.

Attribution: multiple security research groups have documented high-authority context files (CLAUDE.md, agent rules) as a prompt-injection surface during 2025–2026. Representative references: Adversa's analysis after the Claude Code source leak (March 2026), Cymulate's *InversePrompt* (CVE-2025-54794 / CVE-2025-54795), Oasis Security, and Lasso. No single vendor owns the finding.

## What loop-closed does about it

- Auto-capture (the SessionEnd hook) writes to `playbook-draft.md`, not `playbook.md`
- Promotion from draft into the loaded playbook requires a human decision on SessionStart — no captured content becomes authoritative automatically
- Recommend: review `playbook.md` entries before pushing to git if the project reads untrusted third-party code

## What you should do

- Review `playbook-draft.md` before promoting entries into `playbook.md`
- Never run loop-closed auto-capture on projects with untrusted repos without reviewing draft entries first
- Keep secrets (API keys, credentials, client names) out of `CLAUDE.md` and `playbook.md` entirely — they load as system-prompt context and become part of the compounding memory. Use environment variables or `.env` files with ripgrep-ignored paths instead.
