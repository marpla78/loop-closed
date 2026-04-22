# Security

## The risk

`CLAUDE.md` and `playbook.md` load as high-authority context. The first ~200 lines of `CLAUDE.md` become part of the system prompt. Malicious content in untrusted code, API responses, or external files that the AI reads can be laundered through auto-capture and written into memory, persisting across sessions. (Attribution: Cisco Talos research on CLAUDE.md prompt injection.)

## What loop-closed does about it

- Auto-capture (Session B hooks) writes to `playbook-draft.md`, not `playbook.md`
- Promotion from draft into the loaded playbook requires a human decision on SessionStart — no captured content becomes authoritative automatically
- Recommend: review `playbook.md` entries before pushing to git if the project reads untrusted third-party code

## What you should do

- Review `playbook-draft.md` before promoting entries into `playbook.md`
- Never run loop-closed auto-capture on projects with untrusted repos without reviewing draft entries first
- Keep secrets (API keys, credentials, client names) out of `CLAUDE.md` and `playbook.md` entirely — they load as system-prompt context and become part of the compounding memory. Use environment variables or `.env` files with ripgrep-ignored paths instead.
