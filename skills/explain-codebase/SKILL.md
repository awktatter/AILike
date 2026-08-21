---
name: explain-codebase
description: Build a mental model of an unfamiliar codebase and capture it in a reusable PROJECT_CONTEXT.md reference. Use when onboarding to a repo, or when you want a tool-agnostic context file any coding agent can read to understand the project.
---

# Explain Codebase

Survey a project and write a concise, tool-agnostic **`PROJECT_CONTEXT.md`** at
the repo root that any coding agent (Claude, Gemini, Copilot, …) can read to
gain context without re-exploring the tree each time.

## Input / output contract

- **Input**: a path to a codebase (default: the current repo).
- **Output**: `PROJECT_CONTEXT.md` at the repo root, following the template
  below. If one already exists, update it rather than overwriting wholesale.

## Steps

1. **Gather structure with native tools.** Run `scripts/survey.sh [dir]` (or
   `scripts/survey.ps1 [dir]` on Windows PowerShell). It uses
   the best tools the OS/shell already has — `git ls-files`/`fd`/`find` for
   listing, `rg`/`grep` for search, `tree` for layout — to report the layout,
   manifests, CI/tooling, language mix, entry-point candidates, and test
   locations. Rely on this instead of LLM-driven exploration.

2. **Locate with shell tools; read only the few key files.** For any further
   lookup (find a symbol, config, or definition) use `rg`/`grep`/`find` — not
   model scanning. Then open only the README, the primary manifest (e.g.
   `package.json`, `pyproject.toml`, `go.mod`), and the entry point(s) the survey
   surfaced. Skip vendored/generated dirs.

3. **Infer the essentials**: what the project does, its architecture and main
   components, entry points, how to build/test/run it, and the conventions a
   contributor must follow.

4. **Write `PROJECT_CONTEXT.md`** using the template. Keep it short and
   high-signal — it's a map, not documentation. Note anything non-obvious an
   agent would otherwise get wrong.

5. **Confirm the build/test/run commands** are real by checking the manifest or
   CI config; mark any you couldn't verify as unverified rather than guessing.

## PROJECT_CONTEXT.md template

```markdown
# Project Context

> Reusable context for coding agents. Keep concise and high-signal.

## What this is
<one-paragraph purpose>

## Architecture
<main components and how they fit; key directories>

## Entry points
<where execution starts — main files, CLIs, servers>

## Build / test / run
- Build: <command>
- Test: <command>
- Run: <command>

## Conventions
<language/version, style rules, patterns to follow, things to avoid>

## Gotchas
<non-obvious facts an agent would otherwise get wrong>
```

## Scripts

- `scripts/survey.sh [dir]` — prints structural signal (layout, manifests,
  CI/tooling, language mix, entry-point candidates, test dirs) using native OS
  tools. Prefers `git ls-files`→`fd`→`find` for listing, `rg`→`grep` for search,
  and `tree` for layout, degrading gracefully when a tool is absent. Run it in
  step 1 before reading any files.
- `scripts/survey.ps1 [dir]` — PowerShell port of the above for native Windows,
  using `git ls-files`→`fd`→`Get-ChildItem` for listing and `rg`→`Select-String`
  for search.

### Platform note

`survey.sh` targets any POSIX shell and runs the same under bash/zsh/fish (it is
executed via its `bash` shebang, not sourced), so no zsh/fish variant is needed.
On **Windows**, use `survey.ps1`, or run `survey.sh` under Git Bash or WSL (both
provide `bash`, `find`, and `grep`).
