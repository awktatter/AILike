# Design Principles

A collection of **portable skills** that work across LLM CLIs — Claude Code,
Gemini CLI, GitHub Copilot, and others. Every skill is designed to travel
without depending on any single tool's proprietary features.

## Principles

1. **Lowest common denominator.** A skill is portable instructions plus, at
   most, a deterministic helper in `bash`/`python3`/`git`. No dependency on a
   proprietary tool API (browser automation, MCP servers, IDE hooks). If a skill
   needs one, it belongs in a CLI-specific area, not the universal tier.

2. **Explicit I/O contract.** Each skill states what it reads (file, stdin,
   args, git state) and what it produces (stdout, a named file), so any agent
   can wire it up.

3. **Minimal context.** Treat the model's context window as scarce. A `SKILL.md`
   should be short and load only what the current task needs — push detail into
   `reference/` files and `scripts/` the skill points to on demand, rather than
   inlining it. Prefer a deterministic script over instructions that make the
   model read or reason over large inputs.

4. **One job, minimal surface.** Each skill does one thing. No speculative
   flags or configurability that wasn't asked for.

5. **When, not just how.** The `description` must let an agent decide relevance
   from one line.

## Format

One folder per skill:

```
skill-name/
  SKILL.md          # required: frontmatter + instructions
  scripts/          # optional: portable bash/python helpers
  reference/        # optional: detail loaded on demand
```

`SKILL.md` frontmatter (a subset Claude Code reads natively; other tools ignore
or map it):

```yaml
---
name: skill-name              # kebab-case, matches folder
description: One line — WHAT it does and WHEN to use it.
---
```

## Per-CLI loading

- **Claude Code**: skills in `~/.claude/skills/` (global) or `.claude/skills/`
  (project) are discovered automatically.
- **Others**: point the tool's instruction file (`GEMINI.md`,
  `.github/copilot-instructions.md`, or the cross-tool `AGENTS.md`) at this
 
