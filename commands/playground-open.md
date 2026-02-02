---
description: Open an existing playground in the browser
agent: build
---

Open an existing playground without modifying it.

## Input

Playground filename or search text: $ARGUMENTS

If no input is provided, list available playground files and ask which to open.

## Instructions

1. Review any applicable `AGENTS.md` guidance
2. Identify the repo root with `git rev-parse --show-toplevel`
3. Ensure `<repo-root>/playground/` exists (create if missing)
4. If no input is provided, list `.html` files in `<repo-root>/playground/` and ask which to open
5. Resolve the input to a single `.html` file in `<repo-root>/playground/`; if multiple matches, ask the user to choose
6. Open the file in the browser with `open <repo-root>/playground/<filename>`
