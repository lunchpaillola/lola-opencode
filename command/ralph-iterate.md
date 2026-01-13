---
description: Execute one Ralph iteration - implement the next pending user story
agent: build
---

You are an autonomous coding agent. Execute ONE iteration of the Ralph loop.

## Instructions

1. **Review guidance**: Read any applicable `AGENTS.md`
2. **Read the PRD**: Load `ralph/prd.json` to find the current state
3. **Check progress**: Read `ralph/progress.txt` for context from previous iterations
4. **Check branch**: Ensure you're on the correct branch from PRD `branchName`. If not, switch to it or create it.
5. **Pick a story**: Select the **highest priority** (lowest number) user story where `passes: false`
6. **Implement**: Complete that single user story
7. **Quality checks**: Run typecheck if a project-specific typecheck command exists, plus lint and any other project-specific checks; record any failures in notes
8. **Update AGENTS.md**: If you discover reusable patterns, add them
9. **Update prd.json**: Always update `ralph/prd.json` to record the current status and notes. Set `passes: true` only when the story is completed and checks pass; otherwise leave `passes: false` and note why (including check failures)
10. **Log progress**: Always append to `ralph/progress.txt` before ending the iteration (even if blocked or checks fail)
11. **Commit**: If the story is completed and checks pass, stage all changes and commit. Use `feat: [Story ID] - [Story Title]` and include `ralph/prd.json` + `ralph/progress.txt` when modified. Do not use `git stash`.
12. **Push**: Push the commit to origin (set upstream if needed). Do this whenever a completion commit is created.

## Progress Report Format

APPEND to `ralph/progress.txt`:

```
---
## [Date/Time] - [Story ID]: [Story Title]

### Implemented
- What was built

### Files Changed
- path/to/file1.ts
- path/to/file2.ts

### Learnings
- Patterns discovered
- Gotchas encountered
- Notes for future iterations
```

## Stop Condition

After completing a story, check if ALL stories have `passes: true`.

If ALL complete, output exactly:

```
<ralph>COMPLETE</ralph>
```

If stories remain with `passes: false`, end normally (the external loop will call again).

## Rules

- Work on ONE story per iteration
- Never use `git stash` (do not stash or reset away work). Commit or stop with notes instead
- Always append to `ralph/progress.txt` before ending the iteration
- Always update `ralph/prd.json` with current status/notes; set `passes: true` only when completed and checks pass
- If checks fail or a story is blocked, do not mark it complete; still log progress and notes
- Commit and push to origin after each completed story (keep commits atomic)
- Keep CI green - don't break the build
- If you encounter an issue that affects multiple stories, document it in progress.txt

## Before Starting

If `ralph/prd.json` doesn't exist, output:

```
<ralph>ERROR: No prd.json found. Run /ralph-convert first.</ralph>
```

If all stories already have `passes: true`, output:

```
<ralph>COMPLETE</ralph>
```
