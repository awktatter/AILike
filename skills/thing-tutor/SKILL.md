---
name: thing-tutor
description: Teach a technical concept to mastery, mid-conversation. Use when the user says things like "explain containers to me" or wants to learn/understand a topic — digress from the current work, explain in layers, quiz with real scenarios, and save progress for later revisits. Aims to lift a mid-level engineer toward senior-staff/principal depth.
---

# Thing Tutor

Turn a request like "explain <concept>" into a focused teaching session: pause
the current work, teach the concept in layers, drill it with applied scenarios,
and persist the learner's progress so they can resume later. Default audience: a
mid-level software engineer; default goal: understanding that mirrors how a
senior-staff/principal engineer reasons about the topic.

## Input / output contract

- **Input**: the concept to learn (from a mid-chat invocation), plus any saved
  notes at `~/.llm-learning/<topic-slug>.md`.
- **Output**: an interactive teaching session, and a created/updated notes file
  at `~/.llm-learning/<topic-slug>.md` capturing the learner profile, progress,
  gaps, and a suggested revisit.

## Steps

1. **Bookmark the digression.** Say plainly that you're pausing the current work
   to teach the concept (e.g. "Parking our work on X — let's dig into
   containers."). Remember the paused task so you can return in step 8.

2. **Resume prior state.** Check `~/.llm-learning/<topic-slug>.md`. If it exists,
   read it and continue from the learner's known level and open gaps — don't
   re-teach mastered material.

3. **Calibrate briefly.** If prior notes don't already establish it, ask **one
   or two** quick questions: current familiarity and what they want to do with
   the concept. Tailor depth to the answer; don't interrogate.

4. **Teach in layers.** Consult `reference/mastery-rubric.md` and work up the
   rungs with concrete examples: mental model → mechanics/internals →
   tradeoffs and failure modes → the staff/principal lens (system-level
   implications, scale, cost, operability, when *not* to use it). Check for
   understanding between layers; slow down where they struggle.

5. **Drill with applied scenarios.** Quiz using mock scenarios and applications,
   not recall — design problems, "what breaks at 100x", 3am-debugging prompts,
   "why choose this over the alternative", boundary cases. Use the question
   archetypes in `reference/mastery-rubric.md`. React to answers: correct
   misconceptions, push one level deeper when they're solid.

6. **Assess mastery** against the rubric. Name where they are on the ladder and
   the specific gaps left.

7. **Capture progress.** Create or update `~/.llm-learning/<topic-slug>.md` using
   `reference/notes-template.md`: learner profile, mastery level, covered
   subtopics, open gaps/misconceptions, next steps, and a spaced-revisit
   suggestion. Create the `~/.llm-learning/` directory if missing.

8. **Return.** Give a short takeaway summary, then offer to resume the work you
   paused in step 1.

## References

- `reference/mastery-rubric.md` — the mid→staff/principal ladder and the
  question archetypes that probe each rung. Consult in steps 4–6.
- `reference/notes-template.md` — the learner-notes file format. Use in step 7.
