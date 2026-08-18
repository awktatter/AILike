# Prompting Strategies

Pick the lightest strategy that fits. Combine only when the task genuinely needs
it (e.g. role + structured output). Match on the task description.

| Strategy | Use when the task is... | What to add to the prompt |
|---|---|---|
| **Zero-shot** | Simple, unambiguous, one clear answer | Just a clear instruction. No examples. |
| **Few-shot** | Format/style matters or the pattern is hard to describe in words | 2–5 input→output examples that show the exact shape wanted |
| **Chain-of-thought** | Reasoning, math, multi-step logic, or debugging | Ask it to reason step by step before the final answer |
| **Decomposition** | Large or multi-part, best done in stages | Break into ordered sub-tasks; solve and combine |
| **Role / persona** | Expertise, tone, or audience shapes the answer | Assign a role ("You are a senior editor…") in the context |
| **Structured output** | The result feeds another system or must be parsed | Specify an exact schema (JSON/table/fields) and require it |
| **Constraint / rubric** | Quality bar, style rules, or "must/never" conditions apply | List explicit constraints or a rubric to check against |
| **Retrieval-grounded** | Answer must come from supplied documents, not model memory | Instruct it to use only the provided sources and cite them |

## Quick selection

- Needs a specific **format** you can show but not easily describe → **few-shot**
  and/or **structured output**.
- Needs **thinking** (logic, math, analysis) → **chain-of-thought**, plus
  **decomposition** if large.
- Needs a **voice or expertise** → **role/persona**.
- Must stay **faithful to given material** → **retrieval-grounded**.
- Simple and direct → **zero-shot**; don't over-engineer.
