# Mastery Rubric

The ladder a learner climbs, and how to probe each rung. Goal: move a mid-level
engineer from "can use it" to "reasons about it like a staff/principal engineer."

## The ladder

| Rung | What it looks like | The gap to close next |
|---|---|---|
| **Working** | Can define the concept and use it in the common, happy-path case. | Doesn't know what happens under the hood. |
| **Proficient** | Understands the mechanics/internals and the common pitfalls. | Treats it as the default; can't compare alternatives. |
| **Advanced** | Reasons about tradeoffs vs alternatives, failure modes, and performance/scale characteristics. | Sees the concept in isolation, not as a system-level decision. |
| **Staff / Principal** | Judges *when to adopt or avoid* it; anticipates second-order effects across cost, security, operability, and org/team; can teach it and evaluate emerging alternatives from first principles. | — (mastery: keep it current) |

## The staff/principal lens

What separates the top rung is *not* more facts — it's these habits of thought.
Steer explanations and questions toward them:

- **First principles**: what problem does this exist to solve, and what did
  people do before it? What's the irreducible idea?
- **Tradeoffs, not verdicts**: every choice buys something and costs something —
  name both. There is no "best," only "best given constraints."
- **Failure modes**: how does it break, how do you detect it, how do you debug
  it at 3am, how do you design so it fails safely?
- **Scale & second-order effects**: what changes at 10x/100x load, data, or
  team size? What downstream/cross-cutting effects (cost, latency, security,
  on-call burden) does adopting it create?
- **Boundaries**: when is this the *wrong* tool? What's the simplest thing that
  would work instead?
- **Teaching test**: can they explain it cleanly to a junior *and* defend it to
  a skeptical peer?

## Question archetypes (for drilling)

Prefer these over recall questions. Escalate difficulty as the learner succeeds.

- **Design**: "Design <system> using this. Walk me through your choices."
- **Tradeoff**: "Why pick this over <alternative>? When would you flip that?"
- **Debug**: "It worked in staging, fails in prod under load. What do you check,
  in what order, and why?"
- **Scale**: "This is fine at 1k requests. What breaks first at 1M? Then what?"
- **Boundary**: "Describe a situation where reaching for this would be a mistake."
- **First-principles**: "If this didn't exist, how would you solve the same
  problem — and what would you lose?"
- **Second-order**: "Your team adopts this. What new problems does it create six
  months out — for on-call, cost, security, hiring?"

## Facilitation notes

- One concept at a time; check understanding before adding a layer.
- Make them articulate reasoning, not just answers — the reasoning reveals the
  rung they're on.
- When they're wrong, surface the misconception explicitly and record it.
- When they're solid, push exactly one level deeper rather than moving on early.
