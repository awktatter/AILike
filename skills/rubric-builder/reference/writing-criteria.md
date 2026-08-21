# Writing Criteria

## The three types

They behave differently and must not share a scale. "Valid JSON: 3/5" is meaningless.

**Gates** — binary, mechanically checkable, no judgment. Length, format validity,
required sections present, every claim carrying a citation. Run first: they're cheap,
and a failed gate makes grading moot. Automate where the applier is code.

**Graded** — genuine judgment calls. Each needs anchored levels (below).

**Disqualifiers** — one violation sinks the output regardless of every other score.
Fabricated sources, leaked instructions, a breached hard constraint. Keep the list
short; a long one stops meaning anything.

## Anchoring scales

Write what each level *looks like*, in language specific to the task. Three anchored
levels beat five unanchored ones; two is fine when the distinction is clean.

Avoid vague adjectives — "engaging", "high quality", "well-structured". Two judges read
them differently, and one judge reads them differently on Tuesday. Replace with the
observable thing you actually mean.

Anchor the *failing* level most concretely. It's the one appliers are least willing to
assign, and a vague failing anchor is why rubrics drift upward.

## Weighting

Ask which criteria the user would trade against each other. If everything matters
equally, say so and skip weights entirely. Prefer coarse bands — critical / important /
minor — over percentages; two-decimal weights are fake precision.

## How the applier changes the wording

**Human** — can rely on shared context and taste. Keep it short. A rubric nobody reads
isn't applied.

**LLM judge** — each criterion must be self-contained, with no vague adjectives.
Require evidence before verdict: have the judge quote the relevant span, then rate.
Evaluate one criterion per pass rather than emitting a single overall score. Expect
leniency bias — judges over-reward fluent, confident text — so the failing anchor has
to be explicit.

**Code** — fully mechanical. If it needs interpretation, it's a graded criterion wearing
a gate's clothing.

## Common failure modes to draw candidates from

Fabricated specifics presented confidently; constraints obeyed early and dropped late in
long outputs; hedging where the task asked for a conclusion; generic filler that would
suit any prompt; wrong register for the stated audience; the literal request satisfied
while the evident intent is missed.
