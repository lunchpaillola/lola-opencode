---
description: Regenerate a playground from its source document
agent: build
---

Regenerate an existing playground using the latest version of its source document, keeping the same template and overall layout.

## Input

Playground filename or search text, plus optional source file path: $ARGUMENTS

If no input is provided, list available playground files and ask which to refresh.

## Instructions

1. Review any applicable `AGENTS.md` guidance
2. Identify the repo root with `git rev-parse --show-toplevel`
3. Ensure `<repo-root>/playground/` exists (create if missing)
4. If no input is provided, list `.html` files in `<repo-root>/playground/` and ask which to refresh
5. Parse input for file paths:
   - If a path points to a file under `<repo-root>/playground/`, treat it as the target playground file
   - If a path points to a file outside `<repo-root>/playground/`, treat it as the source document
   - Any remaining text is treated as optional update notes
6. Determine the target playground file:
   - Use the explicit playground file path if provided
   - Else resolve remaining text to a single `.html` file in `<repo-root>/playground/` (ask if multiple)
   - Else use the most recently modified `.html` in `<repo-root>/playground/`
7. Read the first line of the selected file and extract `topic`, `template`, and optional `source` from `<!-- playground: topic="..." template="..." source="..." created="..." -->`
8. Determine the source document:
   - If a source file path was provided, use it
   - Else if metadata `source` exists and the file is present, use it
   - Else ask the user for a source file path
9. Read the source document content
10. Regenerate the playground HTML using the `playground` skill:
   - Use the original `topic` and `template` when present
   - Keep the overall layout and visual style consistent with the existing file
   - Base the document content and any suggestions on the latest source content
   - Apply any optional update notes
11. Ensure the first line is updated to `<!-- playground: topic="<topic>" template="<template>" source="<path>" created="<ISO8601 UTC>" -->` using `date -u "+%Y-%m-%dT%H:%M:%SZ"`
12. Overwrite the selected file with the regenerated playground
13. Open the file in the browser with `open <repo-root>/playground/<filename>`
