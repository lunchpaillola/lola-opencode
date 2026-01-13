---
description: Convert a PRD to Ralph's prd.json format
agent: build
---

Load the `ralph` skill and convert a PRD to `ralph/prd.json`.

## Input

PRD file path: $1

If no file path is provided, look for the most recent PRD in `tasks/` (files matching `prd-*.md`).

## Instructions

1. Review any applicable `AGENTS.md` guidance
2. Create the `ralph/` directory if it doesn't exist
3. Read the specified PRD file (or find the most recent one in `tasks/`)
4. Parse the user stories and requirements
5. Convert to prd.json format following the ralph skill
6. Ensure stories are ordered by dependency (schema first, then backend, then UI)
7. Set appropriate priorities (1 = highest priority, do first)
8. Save to `ralph/prd.json`
9. Create `ralph/progress.txt` if it doesn't exist
10. Create the git branch specified in `branchName` if it doesn't exist
11. Confirm all files were created and show the prd.json content

## Example Usage

```
/ralph-convert tasks/prd-user-settings.md
```

Or to auto-detect the most recent PRD:

```
/ralph-convert
```
