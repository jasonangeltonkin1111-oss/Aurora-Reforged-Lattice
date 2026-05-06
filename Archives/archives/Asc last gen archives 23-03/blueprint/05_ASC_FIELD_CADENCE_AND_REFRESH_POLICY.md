# ASC Field Cadence and Refresh Policy

## Purpose

ASC field freshness is not a single global heartbeat rule.
Each field belongs to an owning capability and an owned cadence tier.

## Core law

A field may refresh only when:
1. the owning capability is active for that symbol/surface
2. the field is stale enough to justify work
3. the dispatcher admits the lane

No field is allowed to refresh merely because:
- the HUD is open
- a page changed
- a dossier exists
- another layer is busy

## Cadence tiers

### Tier A — display-fast
Cheap focused-symbol display reads only.
Examples:
- focused-symbol server time line
- focused-symbol bid/ask/spread/day-change paint
- focused-symbol market-watch packet view

Rules:
- symbol-scoped only
- display-only
- no atomic write requirement
- no authorization to refresh unrelated symbols

### Tier B — background-rolling
Normal broad-universe cadence.
Examples:
- Layer 1 maintenance rechecks
- Layer 2 bounded open-symbol packet refresh
- Layer 3 gate reevaluations after upstream change

### Tier C — hold-window selective
Promoted-set cadence owned by Layer 4/5.
Examples:
- shortlist stability checks
- promoted-set deep refreshes
- per-rank deep packet upkeep

### Tier D — cold/on-demand
Expensive or rare refreshes only when clearly due.
Examples:
- broad dossier compose waves
- summary rebuilds
- layout rebuilds
- long-horizon structural checks

## Layer-owned cadence map

### Layer 1
- boot acquisition: heavy lane, exclusive
- boot confirmation rechecks: fast but bounded
- steady maintenance: schedule-driven, not constant
- hourly session sweep: allowed

### Layer 2
- focused symbol display packet: display-fast
- background open-symbol packet: background-rolling
- no broad fast cadence for all open symbols

### Layer 3
- reevaluate only when Layer 1/2 changed materially or Layer 3 went stale
- no independent blanket “all symbols” churn loop

### Layer 4
- shortlist/top-5 rebuild only when membership changed materially, hold window expired, or operator explicitly requests it
- calm-down behavior after rebuild is required

### Layer 5
- promoted-set per-rank cadence:
  - rank 1 every 5 sec
  - rank 2 every 10 sec
  - rank 3 every 15 sec
  - rank 4 every 20 sec
  - rank 5 every 25 sec
- promoted set should remain the main focus for at least 10 minutes unless invalidated

## Hold-window law

Later-layer cadence is not pure freshness.
It also obeys stability rules.
Layer 4 and Layer 5 may intentionally hold a promoted set steady for an operator-readable focus window even when tiny upstream changes occur.

## Focus law

Focus may elevate cadence only for the focused symbol and only for owned fields.
Focus may not:
- speed up the whole bucket
- speed up the whole universe
- force writes at display cadence
- authorize later-layer work before the symbol earned it

## Persistence split

Display cadence and persistence cadence are different.
Examples:
- focused-symbol bid/ask may move every second on the HUD
- the symbol file does not need a file write every second
- Layer 5 promoted packets may write on their own cadence, but that is still slower and more selective than display movement

## Anti-patterns

Do not:
- treat the 1-second dispatcher as permission to update all fields every second
- let dossier writes become the universal freshness driver
- let open-state ownership drag snapshot/filter/shortlist/deep work in the same pulse
- let focused symbol pages mutate whole-universe cadence
