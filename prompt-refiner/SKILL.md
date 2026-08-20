---
name: prompt-refiner
description: Turn a rough request into a structured prompt, or diagnose one that isn't working. Use for help writing or fixing a prompt; not for doing the underlying task itself.
---

# Prompt Refiner

Turn a raw request into a prompt an LLM can act on, or repair one that's failing. Keep
it short — the goal is a usable prompt, not an intake interview.

## I/O contract

- **Reads**: a rough request, or an existing prompt plus how it's failing. Inline or as
  a file path in args.
- **Produces**: one refined prompt on stdout in a single fenced block, plus at most
  three lines naming the strategy chosen and any assumptions made. Writes to a named
  file only if asked.
- **Scripts**: none. This skill is instruction-only.

## Non-interactive fallback

If no user is available to answer questions (piped input, headless run), skip step 3,
build the prompt on best inference, and append an `## Assumptions` block listing what
was inferred and what would change if wrong. Never stall waiting for input.

## Early exit

If the request is already a single clear task with an obvious output shape, tighten the
wording, return it, and stop. Don't run the full process on "summarise this email in
three bullets."

## Steps

1. **Read the intent.** Restate it in one sentence. If the user brought a failing
   prompt, name the failure type — wrong content means a context or grounding gap,
   wrong shape means a format gap, shallow output means a missing quality bar,
   inconsistent across runs means underspecified criteria.

2. **Classify the task and pick a strategy** — before asking anything, since the
   strategy determines which gaps matter. Load `reference/strategies.md`. Note the
   target model if mentioned; it changes whether visible reasoning is worth requesting.

3. **Ask about the gaps that matter**, in one short batched round. Skip what the input
   settles and what the strategy doesn't need.
   - **Context** — background, domain, audience, register.
   - **Task** — the single concrete thing to produce.
   - **Inputs** — material to act on, and its source.
   - **Output** — format, length, structure.
   - **Success criteria** — what separates a good answer from a mediocre one. Ask
     whenever it isn't obvious; usually the most useful answer you get.
   - **Strategy-specific** — examples for few-shot; schema and null-case for structured
     output; sources and citation expectation for retrieval-grounded.

   After one round, fill remaining ambiguity with a labelled assumption. Don't open a
   second round.

4. **Assemble** using `reference/template.md`, shaped by the chosen strategy. Use
   `{{DOUBLE_BRACE_CAPS}}` for anything pasted in each run, so the result is reusable.

5. **Present**, then offer both adjustments and running the prompt to see what it
   produces. One real output usually beats another round of tweaking.

## Reference

- `reference/strategies.md` — strategies and when to use each. Load at step 2.
- `reference/template.md` — prompt skeleton and per-strategy fragments. Load at step 4.
