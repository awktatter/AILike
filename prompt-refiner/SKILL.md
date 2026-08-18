---
name: prompt-refiner
description: Turn a user's rough request into a clear, structured prompt ready to hand to an LLM. Use when the user states a loose intent and wants it formalized into context, task, inputs, outputs, and examples, with an appropriate prompting strategy chosen for the task.
---

# Prompt Refiner

Refine a user's raw input into a structured prompt an LLM can act on directly.
Work through a brief conversation to fill gaps, pick a prompting strategy that
fits the task, and assemble the result.

## Input / output contract

- **Input**: the user's rough request or intent, stated when they invoke the
  skill.
- **Output**: a single refined prompt (see template) the user can paste into any
  LLM. Present it in one copy-ready block.

## Steps

1. **Read the intent.** Restate what the user wants in one sentence to confirm
   you understood it.

2. **Find the gaps.** Check the input for the five parts below. Ask about the
   missing ones **in one batched, short round of questions** — do not
   interrogate. Skip parts the input already makes clear.
   - **Context** — background, domain, audience, tone the LLM needs.
   - **Task** — the single concrete thing to produce.
   - **Inputs** — data/material the LLM will act on, and where it comes from.
   - **Output** — format, length, structure of the result.
   - **Examples** — sample input→output pairs, only if they'd remove ambiguity.

3. **Pick a strategy.** Classify the task and choose a prompting strategy. Read
   `reference/strategies.md` and match on the task type; state which you picked
   and why in one line.

4. **Assemble** the prompt using the template, shaped by the chosen strategy
   (e.g. add worked examples for few-shot, a "think step by step" clause for
   reasoning, a schema for structured output).

5. **Present and offer one refinement pass.** Output the prompt in a fenced
   block, then ask if they want anything adjusted. Stop when they're satisfied.

## Prompt template

```
# Role / Context
<who the LLM is acting as, and the background it needs>

# Task
<the single, concrete task>

# Inputs
<the material to act on, or a placeholder for where it will be pasted>

# Output
<required format, structure, length, constraints>

# Examples        (include only when they reduce ambiguity)
<input → output pairs>
```

Omit any section the task genuinely doesn't need — a minimal prompt beats a
padded one.

## Reference

- `reference/strategies.md` — prompting strategies and when to use each. Consult
  in step 3; don't inline it.
