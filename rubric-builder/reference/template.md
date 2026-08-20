# Output Template

```
## Gates (binary — all must pass)
- [ ] <check> — <how it's verified>

## Disqualifiers (any one fails the output)
- <violation>

## Graded criteria
| Criterion | Fails | Acceptable | Strong | Weight |
|---|---|---|---|---|
| <name> | <what a bad one looks like> | <what a passable one looks like> | <what a good one looks like> | critical / important / minor |

## Calibration
| Sample | Result | Matches user's judgment? |
|---|---|---|

## Assumptions        (non-interactive runs only)
- <what was inferred, and what would change if it's wrong>
```

Omit any section the task doesn't need — a rubric with no real disqualifiers shouldn't
have an empty disqualifiers heading.
