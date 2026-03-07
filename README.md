# Agent Skills

A collection of skills for AI coding agents. Skills are packaged instructions that extend agent capabilities with multi-agent workflows.

Skills follow the [Agent Skills](https://agentskills.io/) format.

## Available Skills

### adversarial-review

Multi-agent adversarial code review that dispatches three specialist agents in parallel to find bugs, security vulnerabilities, and design problems. Findings are consolidated by severity into a single actionable report.

**Use when:**
- Reviewing code changes, diffs, or PRs
- Before merging significant changes
- When you want thorough, adversarial code analysis

**Review agents:**
- **Agent A — Bugs & Logic**: correctness, races, null handling, off-by-one, state management
- **Agent B — Security & Edge Cases**: injection, auth, input validation, DoS, cryptographic issues
- **Agent C — Design & Performance**: architecture, coupling, N+1 queries, API design, testability

### verified-planning

Drafts implementation plans then dispatches two independent review agents to adversarially verify them before presenting to the user. No plan reaches the user without dual verification.

**Use when:**
- Planning any feature or multi-step task
- Before implementing significant changes
- When brainstorming transitions to planning

**Review agents:**
- **Agent A — Adversarial Reviewer**: finds logic flaws, edge cases, architectural risks, security concerns
- **Agent B — Completeness Reviewer**: verifies file accuracy, missing steps, dependency order, test coverage

## Installation

```bash
npx skills add shrimalmadhur/agent-skills
```

## Usage

Skills are automatically available once installed. The agent will use them when relevant tasks are detected.

**Examples:**
```
Review this PR for issues
```
```
Plan the implementation for adding user authentication
```

## Skill Structure

Each skill contains:
- `SKILL.md` - Instructions for the agent

## License

MIT
