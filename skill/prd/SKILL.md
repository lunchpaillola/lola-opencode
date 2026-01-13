---
name: prd
description: Generate a Product Requirements Document (PRD) for a new feature with user stories suitable for autonomous implementation
---

# PRD Generator

Create detailed Product Requirements Documents that are clear, actionable, and suitable for autonomous AI implementation.

## Setup

Before generating a PRD, ensure the project has a `tasks/` directory. If it doesn't exist, create it:

```bash
mkdir -p tasks
```

## The Job

1. Receive a feature description from the user
2. Ask 3-5 essential clarifying questions (with lettered options)
3. Generate a structured PRD based on answers
4. Save to `tasks/prd-[feature-name].md`

## Question Format

Ask questions with lettered options for quick answers:

```
1. What is the primary goal?
   A. Improve user experience
   B. Increase performance
   C. Add new functionality
   D. Other: specify

2. Who is the primary user?
   A. End users
   B. Administrators
   C. Developers
   D. Other: specify

3. What is the scope?
   A. Single component/feature
   B. Multiple related features
   C. System-wide change
   D. Other: specify
```

## PRD Structure

### 1. Introduction/Overview
Brief description of the feature.

### 2. Goals
Specific, measurable objectives.

### 3. User Stories
Each story needs:
- **ID**: US-001, US-002, etc.
- **Title**: Short descriptive name
- **Description**: "As a [user], I want [feature] so that [benefit]"
- **Acceptance Criteria**: Verifiable checklist

**Critical**: Each story must be small enough to complete in ONE context window.

### Story Size Guidelines

Right-sized:
- Add a database column and migration
- Add a UI component to an existing page
- Update a server action with new logic
- Create a single API endpoint
- Add form validation to existing form

Too big (split these):
- "Build the entire dashboard"
- "Add authentication"
- "Create the settings page"
- "Implement the payment flow"

### 4. Functional Requirements
Numbered list: FR-1, FR-2, etc.

### 5. Non-Goals
What this feature will NOT include.

### 6. Technical Notes (optional)
Any technical considerations, dependencies, or constraints.

## Output

1. Create the `tasks/` directory if it doesn't exist
2. Save the PRD to `tasks/prd-[feature-name].md` using a slugified feature name
3. Confirm the file was created and provide the path

## Example Output Path

For a feature called "User Profile Settings":
```
tasks/prd-user-profile-settings.md
```
