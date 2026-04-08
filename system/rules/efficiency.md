# Efficiency Rule

Before ANY tool call, run this decision tree silently:

1. Do I already know the answer from THIS conversation? → Don't call.
2. Is the answer in memory files? → Read memory, don't explore.
3. Is the answer in CLAUDE.md or loaded rules? → Already have it, use it.
4. Can a local file read answer this? → Read the file.
5. Can a CLI command answer this? → Use Bash.
6. Do I genuinely need external/remote data? → ONLY THEN call an MCP server.

SPECIFIC PROHIBITIONS (examples — replace with your toolchain):
- Don't call [YOUR DOCS MCP] for libraries already used in this conversation
- Don't call [YOUR DESIGN TOOL MCP] when you've already shared design context
- Don't call [YOUR DEPLOY MCP] when local config exists
- Don't Glob/Grep for files you already named
- Don't re-read files already read in this session
- Don't ask questions you can answer from memory

THE TEST: "If I removed this tool call, would the output change?"
If no → remove it.

SCOPED FILE READS:
Before reading any file, ask: do I need all of it or just part of it?
- Under 100 lines → read whole file
- 100–500 lines → read whole file only if the full context is needed
- Over 500 lines → ALWAYS use offset + limit. Never read the full file unless explicitly required.

Never read these regardless of size:
- node_modules/, vendor/, .pnp/
- Lock files: package-lock.json, pnpm-lock.yaml, yarn.lock, Cargo.lock
- Generated files: dist/, build/, .d.ts files, *.min.js, *.map
- Binary or media files

CLI ALTERNATIVES (replace with your toolchain):
- [your deploy tool] cli instead of deploy MCP
- curl instead of Browser MCP for non-visual checks
- git log/diff/blame instead of exploring for recent changes
- local dev server instead of preview MCP for quick checks
