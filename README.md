# AILike: Universal Skills

A collection of **portable skills** for LLM CLIs — Claude Code, Gemini CLI,
GitHub Copilot, and others. Each skill is tool-agnostic: plain-language
instructions plus, at most, a small `bash`/`python3`/`git` helper, with an
explicit input/output contract. No dependency on any single tool's proprietary
features.

See [`DESIGN.md`](DESIGN.md) for the principles every skill follows.

## Skills

| Skill | What it does |
|---|---|
| [`prompt-refiner`](prompt-refiner/) | Turns a rough request into a clear, structured prompt (context, task, inputs, outputs, examples) and picks a fitting prompting strategy. |
| [`skill-authoring`](skill-authoring/) | Scaffolds a new portable skill that conforms to this collection's format and design principles. |
| [`explain-codebase`](explain-codebase/) | Surveys an unfamiliar repo with native OS tools and writes a reusable `PROJECT_CONTEXT.md` any coding agent can read. |
| [`thing-tutor`](thing-tutor/) | Teaches a technical concept mid-conversation — explains in layers, quizzes with real scenarios, and saves learner progress for later revisits. |

## Layout

One folder per skill:

```
skill-name/
  SKILL.md          # required: YAML frontmatter (name, description) + instructions
  scripts/          # optional: portable bash/python helpers
  reference/        # optional: detail loaded on demand
```

## Install

Clone the repo, then wire it into your CLI:

- **Claude Code** — symlink or copy skills into your skills directory (they're
  discovered automatically):
  ```bash
  ln -s "$PWD"/* ~/.claude/skills/        # global
  # or per-project: ln -s "$PWD"/* .claude/skills/
  ```
- **Gemini CLI / GitHub Copilot / others** — point the tool's instruction file
  (`GEMINI.md`, `.github/copilot-instructions.md`, or a cross-tool `AGENTS.md`)
  at this collection, or paste the relevant `SKILL.md` body inline.

## Usage

Invoke a skill by name and state your input, e.g.:

- `prompt-refiner` — "help me turn this into a clean prompt: …"
- `explain-codebase` — run it in a repo to generate `PROJECT_CONTEXT.md`
- `thing-tutor` — "explain containers to me"

## Contributing

New skills should follow [`DESIGN.md`](DESIGN.md): one clear job, an explicit
input/output contract, no tool lock-in, and a `description` that states *what*
the skill does and *when* to use it. The [`skill-authoring`](skill-authoring/)
skill scaffolds a conforming skill for you.

## License

MIT
