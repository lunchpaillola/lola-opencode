---
description: Create a named playground HTML file and open it
agent: build
---

Load the `playground` skill and generate a single-file HTML playground.

## Input

Playground topic or request: $ARGUMENTS

If no topic is provided, ask: "What should the playground be about?"

## Instructions

1. Review any applicable `AGENTS.md` guidance
2. Identify the repo root with `git rev-parse --show-toplevel`
3. Ensure `<repo-root>/playground/` exists (create if missing)
4. Append `playground/` to `<repo-root>/.gitignore` if not already listed
   - If `.gitignore` does not exist, create it with `playground/` on its own line
5. If the request includes a file path (relative or absolute) that exists and is not under `playground/`, treat it as the source file and read it for content
6. Use the `playground` skill to select the best template and generate a single-file HTML playground
7. Create a filename from the topic:
   - Slugify the topic to lowercase ASCII with hyphens (letters and numbers only)
   - Use `playground` if the slug is empty
   - Append a timestamp `YYYYMMDD-HHMMSS`
   - Example: `document-viewer-20260131-142233.html`
8. If a source file was used, base the playground's content on it
9. Ensure the first line is a metadata comment in this format:
   `<!-- playground: topic="<topic>" template="<template>" source="<path>" created="<ISO8601 UTC>" -->`
   - Use the provided topic for `<topic>`
   - Use the chosen template slug for `<template>`
   - If a source file was used, set `<path>` to its repo-relative path
   - If no source file was used, omit the `source="<path>"` attribute entirely
   - Use `date -u "+%Y-%m-%dT%H:%M:%SZ"` for `<ISO8601 UTC>`
10. Save it to `<repo-root>/playground/<filename>`
11. Open the file in the browser with `open <repo-root>/playground/<filename>`

## Example Usage

```
/playground-create an interactive SQL query builder for our analytics tables
```
