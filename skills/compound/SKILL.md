---
name: compound
description: Capture and compound learnings from conversations into reusable commands and skills through interactive dialogue
---

# Compound Engineering Skill

Capture learnings from conversations and compound them into reusable commands, skills, and documentation through an interactive, one-shot workflow.

## Overview

Compound engineering means each unit of work makes the next unit easier. This skill helps you:
1. Review conversation context for learnings and patterns
2. Generate concrete proposals for improvement
3. Present proposals interactively and apply approved changes directly

## The Job

1. Receive context about a learning or iteration
2. Ask 2 essential clarifying questions (with lettered options) if needed
3. Generate 1-3 actionable proposals
4. Present proposals with diff-style patches
5. Ask which proposals to apply (lettered selection)
6. Apply selected proposals directly to target files
7. Output a summary of changes

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

Each proposal should include:

- **Summary**: One-sentence description of the change
- **Target**: File(s) that will be modified
- **Patch**: Diff-style showing exact changes to apply

```markdown
## Proposal A: Add validation pattern to commands

### Summary
Add validation guidance to command templates.

### Target
- `commands/template.md` (new or existing)

### Patch
```diff
+## Validation
+
+Always validate inputs before processing.
+Use the existing validation patterns in the codebase.
```
```

## Target Files

Proposals can update:
- `commands/` - Slash commands in the opencode config
- `skills/` - Skill definitions in the opencode config
- `AGENTS.md` - Global agent guidance
- Any explicitly specified file path

## Extraction Rules

When analyzing context for proposals, look for:
1. **Repeated patterns**: "I keep doing X the same way" → propose a command or skill update
2. **Documentation gaps**: "This was hard to figure out" → propose AGENTS.md update
3. **Workflow inefficiencies**: "This takes too many steps" → propose a new command
4. **Knowledge loss**: "I learned this but will forget" → propose documentation

## When to Generate Proposals

Generate proposals **only** when:
- There is a clearly actionable improvement
- The user explicitly requests compounding
- A pattern has been observed multiple times
- The learning has direct implications for commands/skills behavior

Do **not** generate proposals for:
- Generic reflections without actionable follow-ups
- One-off issues that don't indicate a pattern
- Items that are already well-documented

## Workflow

### Interactive Compound Flow

1. User provides context: `/compound [description]`
2. Command asks clarifying questions if needed
3. Command presents 1-3 proposals
4. User selects proposals to apply (e.g., "A and C")
5. Command applies patches directly to files
6. Command outputs summary of changes

### Example Session

```
User: /compound I want to add a pattern for error handling

Assistant:
1. What type of improvement is this?
   A. New command pattern
   B. Update existing command
   C. New skill guidance
   D. Update AGENTS.md
   E. Other: specify

User: A

2. Which proposals should be applied?
   A. All proposals
   B. Specific proposals (e.g., "A and C")
   C. None

User: A

Assistant:
Proposal A: Add error handling pattern to command template

Summary: Add error handling guidance to command templates.

Target: `commands/template.md`

Patch:
```diff
+## Error Handling
+
+Always handle errors gracefully.
+Provide clear error messages for the user.
+Log errors for debugging.
```

Applied 1 proposal(s):

- `commands/template.md`: Add error handling guidance

Files modified:
- `commands/template.md`
```

## Best Practices

- Capture learnings promptly while context is fresh
- Propose small, focused improvements rather than large rewrites
- Ask clear, actionable questions with lettered options
- Present diff-style patches for transparency
- Apply changes directly without intermediate files
- Output clear summaries of what was changed
