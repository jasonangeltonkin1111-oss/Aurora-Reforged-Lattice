# ASC Active Implementation Target

## Purpose

This file removes ambiguity about what is active now, what is transitional, and what is future-facing.

## Active truth stack

Use this order when implementation choices conflict:
1. active `blueprint/`
2. this `asc-mt5-scanner-blueprint/` pack as deep implementation manual
3. active runtime build surface
4. older archive contracts and lineage systems

## Active implementation target

### Active runtime build surface now
- `mt5_runtime_flat/`

### Current architecture target
The next real runtime target is:
- one dispatcher timer
- lane admission instead of blended heartbeat work
- Layer 1 boot isolation
- Layer 4 top-5 main-bucket authority
- Layer 5 rank-sensitive promoted-set cadence
- focused-symbol fast HUD paint split from persistence cadence

### Long-term source architecture target
- semantic MT5 tree under `mt5/Include/ASC/...`

## Final rule

The active implementation target is:
- clean responsibility-based module naming
- no dev/phase naming leakage
- flat runtime surface for now
- dispatcher-first runtime shape next
- semantic source tree later when the implementation is stable enough to migrate cleanly
