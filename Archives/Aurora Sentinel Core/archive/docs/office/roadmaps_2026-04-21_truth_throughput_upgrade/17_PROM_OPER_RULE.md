# Prompt Operating Rules

## Purpose

This file defines how future prompts in this roadmap family must be written.
It exists to reduce drift, overreach, and regression.

## Every future prompt must do these things

1. Name the exact seam.
2. Name what is already solved and must not be reopened blindly.
3. Say whether the pass is audit-only, code-edit, runtime validation, or closure.
4. State whether edits are admitted.
5. List the real compile-path owners to read first.
6. List the runtime evidence to read first.
7. Demand a pre-edit audit before any code changes.
8. Demand explicit “do not touch” boundaries.
9. Demand batch-aware test posture.
10. Demand the changed-files zip link at the end if files changed.

## Every future prompt must forbid these things

- broad redesign
- random cleanup unrelated to the seam
- formula drift outside the lane
- HUD redesign unless the lane is explicitly HUD-facing
- second owner path
- second analysis path
- fake closure language
- reopening solved deep/Global Top 10 seams without proof

## Good prompt spine

1. GIT HEADER
2. PASS NAME
3. WORKING RULES
4. CURRENT TRUTH TO RESPECT
5. FILES TO READ FIRST
6. PRE-EDIT AUDIT QUESTIONS
7. EDITING RULE
8. OUTPUT FORMAT
9. TRIPLE-CHECK NO BREAKAGE

## Test cadence rule for prompts

Prompts must say whether the lane is:

- no-test planning only
- batch candidate only
- runtime-proof batch
- calibration batch

They must not default to “test every commit.”
