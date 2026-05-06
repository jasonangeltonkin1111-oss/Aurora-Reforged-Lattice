# ASC Persistence and Atomic Write

## Core rule

Layer-owned truth writes first.
Composed surfaces later.

## Symbol-file block order
1. Layer 1 block
2. Layer 2 block
3. Layer 3 block
4. Layer 4 block
5. Layer 5 block

## Display vs persistence

Focused symbol HUD movement is not a file-write clock.
Display-fast movement may happen much faster than file persistence.

## Frequent write doctrine

Frequent atomic hydration writes should be reserved for the promoted set only.
Non-promoted symbols should usually write:
- on state transition
- on slow cadence
- on summary checkpoints

## Atomicity

Use temp-to-final writes with `.last-good` protection.
Later-layer failures must not wipe earlier valid truth.
