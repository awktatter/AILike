---
name: skill-authoring
description: Author a new portable skill for this cross-CLI collection. Use when creating, scaffolding, or reviewing a skill so it stays tool-agnostic and follows the collection's format and design principles.
---

# Skill Authoring

Create a skill that works across LLM CLIs (Claude Code, Gemini, Copilot).
Follow `../DESIGN.md` — portable instructions plus, at most, a
`bash`/`python3`/`git` helper, with an explicit input/output contract and no
dependency on any one tool's proprietary features.

## Input / output contract

- **Input**: a description of the skill to create (its job, inputs, outputs).
  If any is unclear, ask before scaffolding.
- **Output**: a new `skill-name/SKILL.md` (and optional `scripts/`,
  `reference/`) conforming to the format below.

## Steps

1. **Clarify the job.** State in one sentence what the skill does and when an
   agent should reach for it. If you can't, ask. A skill does exactly one job.

2. **Check portability.** Confirm it needs only plain instructions and, at most,
   a `bash`/`python3`/`git` helper. If it requires a browser, MCP server, or
   IDE-specific API, stop — say so and suggest a CLI-specific home instead.

3. **Define the I/O contract explicitly.** Name what it reads (file, stdin,
   args, git state) and what it produces (stdout, a named file). Put these in
   the body so any agent can wire it up.

4. **Reuse before adding.** Scan existing skills. If one covers the job, extend
   it rather than duplicating.

5. **Scaffold the folder**, adding `scripts/` only if there is deterministic
   work to factor out, and `reference/` only for detail loaded on demand.
   ```
   skill-name/
     SKILL.md
     scripts/        # optional
     reference/      # optional
   ```

6. **Write `SKILL.md`** with the template below. Keep the body tight: purpose,
   contract, numbered steps, pointers to `scripts/`/`reference/`. Per the
   minimal-context principle, push long detail into `reference/` and mechanical
   work into `scripts/` — don't inline either.

7. **Verify** against `../DESIGN.md`: single job, explicit contract, no tool
   lock-in, `name` matches the folder, `description` states what + when.

## SKILL.md template

```markdown
---
name: skill-name
description: One line — WHAT it does and WHEN to use it.
---

# Skill Name

One-paragraph summary of the job.

## Input / output contract

- **Input**: <what it reads>
- **Output**: <what it produces>

## Steps

1. ...
2. ...
```

## Notes

- `description` is the only thing an agent sees when deciding to use the skill —
  make it earn its place in one line.
- Prefer POSIX-compatible bash and the `python3` standard library so helpers run
  anywhere without setup.
