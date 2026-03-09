---
description: Review OpenCode session history for a project and propose the best skills, agents, and command architecture
---

Analyse local OpenCode sessions for the target project, identify recurring workflows, and recommend the right split between interactive agents, reusable skills, and deterministic commands.

Canonical command: `/session-workflow-audit`
Alias: `/session-flow-audit`

**Usage**: `session-workflow-audit $ARGUMENTS`

## Input handling

Treat `$ARGUMENTS` as free-text guidance that may include:
- a project path or project name fragment
- a focus area such as `skills`, `commands`, `agents`, `routing`, or `command bloat`
- an optional output path

Default behavior when details are missing:
- target project/worktree: current repository root
- focus: architecture recommendations for `skills`, `agents`, and `commands`, with bias toward agent-first interaction and commands reserved for deterministic or schedulable runs
- output path: `docs/plans/YYYY-MM-DD-opencode-session-workflow-audit.md`

## Workflow

1. **Resolve the target project**
   - Start from the current repo root unless `$ARGUMENTS` clearly point to a different project.
   - Inspect the local OpenCode storage to map the worktree to its project id.
   - Prefer the SQLite database first:
     - `~/.local/share/opencode/opencode.db`
   - Use storage files only if needed for validation:
     - `~/.local/share/opencode/storage/project/`
     - `~/.local/share/opencode/storage/session/<project-id>/`
     - `~/.local/share/opencode/storage/message/<session-id>/`

2. **Inspect the current local OpenCode setup for the target repo**
   - Read:
     - `.opencode/commands/`
     - `.opencode/skills/`
     - `.opencode/agents/`
   - Count existing commands, skills, and agents.
   - Note obvious duplication, overly narrow commands, missing routers, and thin vs heavy abstractions.

3. **Quantify recent session patterns before reading deeply**
   - Use the session database to gather high-signal stats such as:
     - total sessions for the project
     - recent session titles
     - agent usage counts
     - tool usage counts
     - sessions with file edits / patches
     - repeated keywords in titles
   - Use these stats to choose representative samples rather than reading everything blindly.

4. **Sample representative sessions carefully**
   - Review a representative set of recent and high-signal sessions.
   - For each sampled session, inspect at minimum:
     - title
     - first real user prompt
     - final assistant response
     - any notable tool or agent usage
   - Prefer sessions that reflect repeated work, not only unusual one-offs.
   - If a workflow looks important, inspect enough session content to understand:
     - what the user was trying to get done
     - what tools or agents were needed
     - where routing or prompting friction appeared

5. **Identify workflow clusters**
   - Group recurring work into a small number of workflow buckets.
   - For each bucket, capture:
     - workflow name
     - typical trigger request
     - common inputs
     - common outputs
     - tools involved
     - whether the workflow is primarily `interactive agent work` or `deterministic command work`
     - current friction or command bloat symptoms
   - Prefer real workflow names over abstract labels.

6. **Recommend the architecture**
   - Recommend the best split between:
     - interactive agents
     - deterministic commands
     - router skills
     - domain skills
     - activity skills
     - custom agents
   - Prefer fewer commands and more reusable skills when that lowers memory burden.
   - Bias toward agents for interactive, judgment-heavy, or evolving tasks.
   - Bias toward commands for stable workflows that have a clear input/output contract and could plausibly be scheduled.
   - Only recommend a custom agent when a role needs a distinct execution style, tool set, or persistent specialization.
   - Explicitly call out:
     - primary interactive entrypoints to keep or create
     - commands to keep
     - commands to merge
     - commands to convert into skills
     - commands to retire

7. **Bias toward a simple interface**
   - Optimise for a system the user can remember without a long list of command names.
   - If the observed workflows support it, prefer a very small set of interactive agents such as `work` vs `ops` over many narrow commands.
   - Treat commands as deterministic entrypoints, not the primary day-to-day interface.
   - Do not recommend a giant catch-all command unless the evidence clearly supports it.

8. **Write the audit artifact**
   - Write the report to the resolved output path.
    - Use this section order:
      - `# OpenCode Session Workflow Audit`
      - `## Target project`
      - `## Current .opencode layout`
      - `## Session evidence`
      - `## Workflow clusters`
      - `## Interactive agent recommendations`
      - `## Recommended skills`
      - `## Recommended agents`
      - `## Recommended commands`
      - `## Migration suggestions`
      - `## Minimal next step`

9. **Return a concise completion summary**
   - Include:
     - output path
     - top workflow clusters found
     - recommended interactive surface
     - recommended command surface
     - highest-leverage skill to build first

## Guardrails

- Use local session evidence, not guesses.
- Prefer representative sampling plus summary statistics over exhaustive transcript dumping.
- Do not expose secrets, tokens, or sensitive message content unnecessarily.
- Quote only short excerpts when needed to justify a recommendation.
- Keep recommendations opinionated and practical.
- Favour stable architectural recommendations over one-off workflow hacks.
- Only recommend commands for workflows that are deterministic enough to automate, schedule, or run with minimal ambiguity.

## Output expectations

The final audit should help answer:
- What work am I actually doing repeatedly?
- Which of those behaviors should stay interactive via agents?
- Which of those behaviors should become skills?
- Which ones deserve custom agents?
- Which workflows are deterministic enough to keep as commands?
- What is the smallest interface I need to remember?
