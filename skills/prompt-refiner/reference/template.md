# Prompt Template

```
# Context
<background the LLM needs; audience and register; a role only if voice matters>

# Task
<the single, concrete task>

# Inputs
<the material, or {{PLACEHOLDER}} for what gets pasted in>

# Output
<format, structure, length>

# Constraints          (when a quality bar or must/never rules apply)
<explicit constraints, or a rubric the answer is checked against>

# Examples             (only when they reduce ambiguity)
<input → output pairs, clearly delimited>
```

Omit any section the task doesn't need.

## Per-strategy fragments

**Few-shot** — delimit examples so they aren't read as instructions:
```
Input: the login page is broken on safari → Output: Safari: login page fails to render
Input: users cant find export → Output: Export action not discoverable
Input: {{TEXT}}
```

**Structured output:**
```
Return only JSON, no prose: {"claim": str, "confidence": "high|medium|low", "source": str|null}
Use null for source when the claim isn't in the attached documents.
```

**Retrieval-grounded:**
```
Answer using only {{SOURCE}}. Cite the speaker and timestamp for each claim.
If it doesn't cover something I've asked, say so rather than inferring.
```

**Self-critique:**
```
Draft the summary. Then check it against: (1) under 200 words, (2) no jargon,
(3) every number traceable to the report. Return only the corrected version.
```
