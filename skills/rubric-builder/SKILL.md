---
name: rubric-builder
description: Build reusable eval criteria for judging LLM output, from a prompt, an output, or both. Use to formalize what "good" looks like; not for one-off critique of a single piece of work.
---

# Rubric Builder

Turn a fuzzy sense of "good output" into criteria that can be applied repeatably.

## I/O contract

- **Reads**: a prompt, an output, or both — pasted inline or as file paths given in
  args. Optionally, sample outputs the user has already judged good or bad.
- **Produces**: a rubric on stdout in the format in `reference/template.md`. Writes to a
  named file only if the user asks.
- **Scripts**: none. This skill is instruction-only.

## Non-interactive fallback

If no user is available to answer questions (piped input, headless run), skip step 1,
infer what you can, and print an `## Assumptions` block listing what you inferred and
what would change the rubric if wrong. Never stall waiting for input.

## Steps

1. **Establish context.** In one batched round, ask only what you can't infer: who or
   what applies the rubric (human / LLM judge / code), whether it judges one output or
   compares many, and — most useful — a concrete bad output the user remembers.

2. **Generate candidates wide.** Pull from what the prompt demands, what the samples
   reveal, and the usual failure modes for the task type.

3. **Cut by the discrimination test.** For each candidate, picture a realistic output
   that fails it — if you can't, cut it, it measures nothing. Then picture an output
   that passes it and is still bad; that gap is a criterion you're missing.

4. **Sort into gates, graded criteria, and disqualifiers.** These don't share a scale.
   See `reference/writing-criteria.md`.

5. **Anchor and weight.** Write what each level looks like in task-specific language;
   no vague adjectives. Weight only if the user would trade criteria against each other.

6. **Calibrate.** Score at least one known-good and one known-bad sample. If the bad one
   scores well, or the two land close, the rubric is broken — usually a missing
   criterion or an unanchored scale. Fix, re-run. Don't skip this: an uncalibrated
   rubric feels rigorous while measuring nothing.

7. **Output** the rubric, the calibration result, and — if the applier is an LLM judge —
   a ready-to-use judge prompt.

## Notes

- A rubric that scores everything 4/5 is a broken rubric, not a good output.
- Criteria that surface in step 3 but weren't in the original prompt belong back in the
  prompt. Fixing the prompt beats grading the same failure repeatedly.
- Don't judge output on information the model was never given — that measures the
  prompt, not the output.

## Reference

- `reference/writing-criteria.md` — criterion types, scale anchoring, and how the
  applier changes the wording. Load at step 4.
- `reference/template.md` — output format. Load at step 7.
