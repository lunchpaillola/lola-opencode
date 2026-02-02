---
name: ralph
description: Convert PRDs to prd.json format for the Ralph autonomous agent system and set up project structure
---

# Ralph PRD Converter

Convert existing PRDs to the `prd.json` format for autonomous execution by the Ralph loop system.

## Setup

Before converting a PRD, ensure the project has the Ralph directory structure. If it doesn't exist, create it:

```bash
mkdir -p ralph
```

Also create an empty progress file if it doesn't exist:

```bash
touch ralph/progress.txt
```

## The Job

1. Read the PRD from `tasks/prd-*.md` (or specified path)
2. Parse user stories and requirements
3. Convert to `prd.json` format
4. Create the Ralph directory structure if needed
5. Save to `ralph/prd.json`
6. Initialize `ralph/progress.txt` if empty

## Output Format

```json
{
  "project": "[Project Name]",
  "branchName": "ralph/[feature-name]",
  "description": "[Feature description from PRD overview]",
  "userStories": [
    {
      "id": "US-001",
      "title": "[Story title]",
      "description": "As a [user], I want [feature] so that [benefit]",
      "acceptanceCriteria": [
        "Criterion 1",
        "Criterion 2",
        "Typecheck passes"
      ],
      "priority": 1,
      "passes": false,
      "notes": ""
    }
  ]
}
```

## Critical Rules

### Story Size
Each story must be completable in ONE iteration (one context window). If a story from the PRD is too large, split it into smaller stories.

### Story Ordering
Set priorities to ensure dependencies come first:
1. Schema/database changes (priority: 1)
2. Server actions / backend logic (priority: 2)
3. Utility functions / helpers (priority: 3)
4. UI components (priority: 4)
5. Dashboard/summary views (priority: 5)
6. Tests and documentation (priority: 6)

### Acceptance Criteria
Must be verifiable, not vague.

Good:
- "Add status column to users table with default 'pending'"
- "API returns 200 with user object on success"
- "Form displays validation error when email is invalid"
- "Typecheck passes"

Bad:
- "Works correctly"
- "Is user friendly"
- "Handles errors properly"

Always include at the end of each story:
- "Typecheck passes"

For UI stories, also include:
- "Verify changes work in browser"

### Initial State
All stories start with:
- `passes: false`
- `notes: ""`

## Output Steps

1. Create `ralph/` directory if it doesn't exist
2. Save `ralph/prd.json` with the converted PRD
3. Create `ralph/progress.txt` if it doesn't exist
4. Confirm all files were created and provide the paths

## Branch Naming

Generate branch name from the feature:
- "User Profile Settings" -> `ralph/user-profile-settings`
- "Payment Integration" -> `ralph/payment-integration`

Use lowercase, hyphen-separated format.
