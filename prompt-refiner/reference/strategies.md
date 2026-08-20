# Prompting Strategies

Pick the lightest strategy that fits. Combine only when the task needs it. Most weak
prompts fail on missing context, not wrong technique — a zero-shot prompt with full
context beats a few-shot prompt without it.

## Shaping the output

| Strategy | Use when... | Add | Skip when |
|---|---|---|---|
| **Zero-shot** | Simple, unambiguous, one clear answer | A clear instruction, no examples | Never wrong to start here |
| **Few-shot** | Format/style matters or the pattern resists description | 2–5 input→output examples in the exact shape, clearly delimited | You can state the rule in a sentence |
| **Structured output** | Result feeds another system or must be parsed | Exact schema, plus what to emit for unknown fields | Output is for a human to read |
| **Constraint / rubric** | A quality bar or must/never conditions apply | Explicit constraints or a rubric to check against | Constraints are obvious from the task |
| **Role / persona** | Tone, register, or audience shapes the answer | The audience and register in context | You want accuracy, not voice |

## Shaping the reasoning

| Strategy | Use when... | Add | Skip when |
|---|---|---|---|
| **Chain-of-thought** | You need reasoning you can audit, or a smaller/non-reasoning model | "Show your reasoning before the answer" | Reasoning model, and you only want the conclusion |
| **Decomposition** | Large or multi-part, best done in stages | Ordered sub-tasks in one prompt; solve, then combine | The parts aren't separable |
| **Prompt chaining** | Stages need review, or context would overflow | Separate turns, output of one feeding the next, checkpoint between | One pass is good enough |
| **Self-critique** | First drafts land at ~80% | "Draft, check against [criteria], return the revision" | Speed matters more than polish |

## Grounding and refinement

| Strategy | Use when... | Add | Skip when |
|---|---|---|---|
| **Retrieval-grounded** | Answer must come from supplied documents | Sources-only instruction, citations, **and say so plainly if the sources don't answer it** | General knowledge is fine |
| **Meta-prompting** | Unsure how to ask | "Before answering, name what's ambiguous or missing" | The request is already specific |

## Caveats that change the choice

- **Personas shape voice, not competence.** An expert role reliably changes register and
  framing; it does far less for accuracy than people assume.
- **Chain-of-thought has narrowed.** Reasoning models already reason internally, and
  forcing shallow visible steps can flatten output. Request visible reasoning to *check*
  it, not as a default accuracy booster.
- **Few-shot examples bias toward themselves.** All-short examples produce short output;
  all-edge-case examples produce edge-case treatment. Keep them representative.
- **Prefer native features.** Where the target tool offers real structured output or a
  JSON schema parameter, that binds more reliably than asking in prose.
- **Negative constraints need a positive alternative.** "Don't use bullets — write
  flowing paragraphs" beats "don't use bullets."
