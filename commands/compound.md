---
description: Review conversation, propose compounding improvements, and apply them
agent: build
---

Load the `compound` skill and compound learnings from the conversation.

## Input

Context about what to compound: $ARGUMENTS

If no arguments provided, ask for a brief description of the learning or iteration.

## Instructions

1. Load the `compound` skill to understand the approach
2. Review the conversation for learnings, patterns, and improvement opportunities
3. Ask 2 essential clarifying questions (with lettered options) if context is unclear
4. Generate 1-3 concrete proposals for compounding
5. Present proposals with diff-style patches
6. Ask which proposals to apply (lettered selection)
7. Apply selected proposals directly to target files
8. Output a summary of changes made

## Question Format

Ask questions with lettered options for quick answers:

```
1. What type of improvement is this?
   A. New command pattern
   B. Update existing command
   C. New skill guidance
   D. Update AGENTS.md
   E. Other: specify

2. Which proposals should be applied?
   A. All proposals
   B. Specific proposals (e.g., "A and C")
   C. None
```

## Proposal Format

Present each proposal as:

```
Proposal [Letter]:

## Summary
Brief description of the change.

## Target
- `commands/filename.md`
- `skills/compound/SKILL.md`
- `AGENTS.md`
- Or other explicitly specified file

## Patch
```diff
[diff-style patch]
```
```

## Application Rules

- Only apply patches when explicitly approved via lettered selection
- Parse diff-style patches carefully
- Back up files before modifying (optional, for safety)
- Report any errors during application
- If a target file doesn't exist, create it with the patch content

## Example Usage

```
/compound I want to improve how we document API patterns
```

```
/compound Make commands easier to discover by adding examples
```

## Output Summary

After applying changes, output:

```
Applied [N] proposal(s):

- [Target file]: [Brief description]
- [Target file]: [Brief description]

Files modified:
- path/to/file1.md
- path/to/file2.md
```

## Example Usage

```
/compound I want to improve how we document API patterns
```

```
/compound Make commands easier to discover by adding examples
```
Applied [N] proposal(s):

- [Target file]: [Brief description]
- [Target file]: [Brief description]

Files modified:
- path/to/file1.md
- path/to/file2.md
```
