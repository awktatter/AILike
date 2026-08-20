# Prompting Strategies

## 0. Before picking a strategy

Most weak prompts fail on missing context, not wrong technique. Check these first —
if any are blank, fill them in before reaching for the table below.

| Element | Question to answer |
|---|---|
| **Goal** | What should exist when this is done? |
| **Audience** | Who reads the output, and what do they already know? |
| **Source material** | What must the answer be based on? Is it attached? |
| **Format** | Length, medium, structure |
| **Constraints** | Must-haves, never-dos, tone, scope limits |
| **Done** | How would you tell a good answer from a mediocre one? |

A zero-shot prompt with all six is usually better than a few-shot prompt missing three.

## 1. Strategy table

Pick the lightest strategy that fits. Combine only when the task genuinely needs it
(e.g. role + structured output). Grouped by what they shape.

### Shaping the output

| Strategy | Use when the task is... | What to add | Skip it when |
|---|---|---|---|
| **Zero-shot** | Simple, unambiguous, one clear answer | A clear instruction. No examples. | Never wrong to start here |
| **Few-shot** | Format/style matters or the pattern resists description | 2–5 input→output examples in the exact shape wanted, clearly delimited | You can just state the rule in a sentence |
| **Structured output** | Result feeds another system or must be parsed | An exact schema, plus what to emit when a field is unknown | The output is for a human to read |
| **Constraint / rubric** | A quality bar or "must/never" conditions apply | Explicit constraints, or a rubric the answer is checked against | Constraints are obvious from the task |
| **Role / persona** | Tone, register, or audience shapes the answer | A role in the context: "You are writing for a board of non-technical trustees" | You want accuracy, not voice — see note below |

### Shaping the reasoning

| Strategy | Use when the task is... | What to add | Skip it when |
|---|---|---|---|
| **Chain-of-thought** | You need reasoning you can audit, or you're on a smaller/non-reasoning model | "Show your reasoning before the answer" | Using a reasoning model on a task where you only want the conclusion |
| **Decomposition** | Large or multi-part, best done in stages | Ordered sub-tasks in one prompt; solve, then combine | The parts aren't really separable |
| **Prompt chaining** | Stages need review, or context would overflow | Separate turns: output of one becomes input of the next, with a checkpoint between | One pass is good enough — chaining costs time |
| **Self-critique** | First drafts are typically 80% there | "Draft, then check against [criteria], then give the revised version" | Speed matters more than polish |

### Grounding and refinement

| Strategy | Use when the task is... | What to add | Skip it when |
|---|---|---|---|
| **Retrieval-grounded** | Answer must come from supplied documents, not model memory | Use only the provided sources, cite them, **and say so plainly if the sources don't answer it** | General knowledge is fine or preferable |
| **Meta-prompting** | You're unsure how to ask | "Before answering, tell me what's ambiguous or missing in this request" | The request is already specific |

## 2. Quick selection

- Specific **format** you can show but not describe → few-shot, and/or structured output.
- Output is **machine-read** → structured output; state the fallback for unknown fields.
- Needs **thinking** → decomposition if large; chain-of-thought only if you need to see the work.
- Needs a **voice or audience fit** → role/persona.
- Must stay **faithful to given material** → retrieval-grounded, with an abstention clause.
- **Quality bar** matters → constraint/rubric plus self-critique — they work as a pair.
- **Simple and direct** → zero-shot. Don't over-engineer.

## 3. Worked micro-examples

**Few-shot** — delimit examples so they aren't read as instructions:
```
Rewrite each as a ticket title.
Input: the login page is broken on safari → Output: Safari: login page fails to render
Input: users cant find export → Output: Export action not discoverable
Input: <your text>
```

**Structured output:**
```
Return only JSON, no prose: {"claim": str, "confidence": "high|medium|low", "source": str|null}
Use null for source when the claim isn't in the attached documents.
```

**Retrieval-grounded:**
```
Answer using only the attached transcript. Cite the speaker and timestamp for each claim.
If the transcript doesn't cover something I've asked, say so rather than inferring.
```

**Self-critique:**
```
Draft the summary. Then check it against: (1) under 200 words, (2) no jargon,
(3) every number traceable to the report. Give me only the corrected version.
```

## 4. Notes and caveats

- **Personas shape voice, not competence.** Assigning an expert role reliably changes
  register and framing; it does much less for factual accuracy than people assume.
  Use it for audience fit, not to "unlock" knowledge.
- **Chain-of-thought has narrowed in usefulness.** Reasoning models already reason
  internally, and forcing shallow visible steps can make output worse. Ask for visible
  reasoning when you want to *check* it, not as a default accuracy booster.
- **Few-shot examples bias output toward the examples.** If all five are short, expect
  short. If all five are edge cases, expect edge-case treatment. Keep them varied and
  representative.
- **Prefer native features over prose instructions.** Where a tool offers real structured
  output or a JSON schema parameter, that constrains the model more reliably than asking.
- **Negative constraints work better with a positive alternative.** "Don't use bullet
  points — write flowing paragraphs" beats "don't use bullet points."

## 5. Iterating

If an output misses, diagnose before adding technique:

1. **Wrong content?** → context or grounding problem. Add sources, not strategies.
2. **Right content, wrong shape?** → few-shot or structured output.
3. **Right shape, shallow?** → decomposition, or raise the bar with a rubric.
4. **Inconsistent across runs?** → your criteria are underspecified. Write them down.

Change one thing per iteration. Keep prompts that work — a small personal library of
proven prompts beats re-deriving them each time.
