---
name: prompt-refiner
description: Turn a rough request into a clear, structured prompt ready to hand to an LLM, or diagnose and improve an existing prompt that isn't working. Use when the user asks for help writing, refining, structuring, or debugging a prompt, or says an LLM keeps giving them the wrong kind of answer. Do NOT use when the user wants the task itself done — "write me a blog post" is a request for a blog post, not for a prompt that produces one.
---
 
# Prompt Refiner
 
Turn a raw request into a structured prompt an LLM can act on, or repair one that
isn't working. Keep the conversation short: the goal is a usable prompt, not a
thorough intake interview.
 
## Input / output contract
 
- **Input**: a rough request, or an existing prompt plus a description of how it's
  failing.
- **Output**: one refined prompt in a single copy-ready fenced block, plus a one-line
  note on the strategy chosen and any assumptions made.
## Early exit
 
If the request is already a single clear task with an obvious output shape, tighten
the wording, hand it back, and stop. Don't run the full process on "summarise this
email in three bullets." A minimal prompt beats a padded one, and that applies to
this skill's own process.
 
## Steps
 
1. **Read the intent.** Restate it in one sentence to confirm. If the user brought an
   existing prompt, also name what's going wrong with it — wrong content points to a
   context or grounding gap, wrong shape points to a format gap, shallow output points
   to a missing quality bar.
2. **Classify the task and pick a strategy.** Do this *before* asking questions — the
   strategy determines which gaps matter. Read `reference/strategies.md` and match on
   task type. Note the target model if the user mentioned one; it changes whether
   visible reasoning is worth requesting.
3. **Ask about the gaps that matter.** Check the input against the parts below, then
   ask about the missing ones in **one short batched round**. Skip anything the input
   already settles, and skip anything the chosen strategy doesn't need.
   - **Context** — background, domain, audience, register.
   - **Task** — the single concrete thing to produce.
   - **Inputs** — material to act on, and where it comes from.
   - **Output** — format, length, structure.
   - **Success criteria** — what separates a good answer from a mediocre one. Ask this
     one whenever it isn't obvious; it's usually the most useful answer you get.
   - **Strategy-specific** — examples for few-shot, a schema and null-case for
     structured output, the source material and citation expectation for
     retrieval-grounded.
   After one round, fill any remaining ambiguity with an explicit assumption and label
   it when you present the prompt. Don't open a second round of questions.
4. **Assemble** using the template, shaped by the strategy: worked examples for
   few-shot, a schema plus unknown-field handling for structured output, a
   sources-only clause with an abstention instruction for retrieval-grounded, a
   visible-reasoning clause only if the target model needs it or the user wants to
   audit the reasoning.
   Use `{{DOUBLE_BRACE_CAPS}}` for anything the user will paste in each time, so the
   result works as a reusable template.
5. **Present.** Output the prompt in a fenced block. Below it, in no more than three
   lines: the strategy chosen and why, and any assumptions made. Then offer both —
   adjustments, or running the prompt to see what it produces. One real output usually
   beats another round of tweaking. Iterate as long as the user wants.
## Prompt template
 
```
# Context
<background the LLM needs; audience and register; a role only if voice matters>
 
# Task
<the single, concrete task>
 
# Inputs
<the material, or {{PLACEHOLDER}} for what gets pasted in>
 
# Output
<format, structure, length>
 
# Constraints          (include when a quality bar or must/never rules apply)
<explicit constraints, or a rubric the answer is checked against>
 
# Examples             (include only when they reduce ambiguity)
<input → output pairs, clearly delimited>
```
 
Omit any section the task doesn't need.
 
## Reference
 
- `reference/strategies.md` — prompting strategies and when to use each. Consult in
  step 2; don't inline it.
