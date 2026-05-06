# ASC System Overview

## Product identity

ASC is a stateful MT5 scanner EA.
Its job is to maintain a truthful, rolling, broker-facing, and human-usable view of the symbol universe without collapsing the whole machine into one overloaded timer pass.

## ASC is
- a broker-universe scanner
- a market-state observer
- a selective open-symbol packet builder
- a cheap broad filter and bounded shortlist system
- a selective deep-analysis system for promoted symbols only
- a persistence and publication system
- a presentation surface for already prepared truth

## ASC is not
- an execution EA
- a signal generator
- a strategy selector
- a portfolio allocator
- a giant all-at-once every-second analytics monolith
- a HUD-driven calculation engine
- a second hidden engine inside the explorer

## Core runtime question set

ASC exists to answer, continuously and honestly:
1. Which symbols exist in the current broker universe?
2. Which symbols are open now, closed now, uncertain, or still unknown?
3. What is the latest owned packet for the symbols that matter now?
4. Which symbols are cheap-pass survivors worth carrying forward?
5. Which symbols earned the bounded top set inside each main bucket?
6. Which promoted symbols deserve deeper rolling analysis right now?
7. What truth is current, stale, pending, degraded, restored, or unavailable?

## Core design laws

### Single-dispatcher law
ASC runs on one EA timer only.
All cadence diversity is internal scheduler truth, not many independent MT5 timers.

### Lane law
The runtime dispatches narrow lanes of work instead of blending all capabilities inside one heartbeat.
Per pulse ASC may run:
- up to 3 light lanes, or
- exactly 1 heavy lane

### Cheap broad, expensive narrow law
Broad discovery and filtering must stay light.
Heavy enrichment belongs only to the final promoted set.

### Layer-order law
The ordered capability stack is real runtime ownership, not cosmetic wording.
A later layer may consume earlier truth but must not silently rebuild lower-layer truth just because it is due.

### Layer-1-first law
Startup is won or lost by Layer 1.
The machine first acquires whole-universe market-state truth.
Everything else waits until Layer 1 reaches its own readiness threshold.

### Focus-display law
Focused symbol views may paint fast-moving cheap fields for the focused symbol only.
Display cadence is not persistence cadence.
HUD entry must not authorize broad background recomputation.

### Publication discipline law
Layer-owned symbol files come first and evolve by owned sections.
Dossiers and summaries are consumer surfaces built from layer-owned truth blocks.

### Human-readable output law
The HUD, menu, and output files must show readable labels, not mechanic names.

### Atomic rolling persistence law
HUD-visible truth is rolling state, not render-time derivation.
Layer-owned last-good truth must survive partial refreshes, bounded updates, downgrade events, and restart restore.

### Stale-bound recomputation law
No field may recompute merely because the HUD redrew, a page opened, or a button was clicked.
A field or surface refresh is justified only when:
1. the owning capability says the field belongs to the active surface
2. the field is stale enough to justify work
3. the dispatcher budget can admit the work honestly

## Runtime spine

The runtime is built from:
- one dispatcher timer
- one internal schedule wheel
- stage-owned due queues
- an explicit ordered capability stack
- light-lane vs heavy-lane dispatch rules
- field-tier cadence ownership and stale-bound refresh rules
- atomic publication rules
- symbol files and prepared snapshots that evolve over time

## Canonical ordered capability stack

1. Market State Detection
2. Open Symbol Snapshot
3. Candidate Filtering
4. Shortlist Selection
5. Deep Selective Analysis

The ordered progression must stay explicit for debugging and implementation sequencing.

## Canonical publication order

1. layer-owned symbol file exists
2. Layer 1 truth fills first
3. Layer 2 open-symbol packet fills when earned
4. Layer 3 eligibility fills when earned
5. Layer 4 shortlist / top-set truth fills when earned
6. Layer 5 deep packet fills for the selected set only
7. dossier / summary surfaces compose from those blocks later

## Current target runtime shape

### Layer 1
Fast full-universe market-state acquisition and scheduled maintenance.
Internally it keeps `Open`, `Closed`, `Uncertain`, and `Unknown`.
Operator surfaces may map those to simpler labels.

### Layer 2
Selective open-symbol packet truth.
This owns current bid/ask/spread/day-range/static tradability fields and last-good continuity.

### Layer 3
Cheap eligibility only.
No ranking, no strategy logic, no heavy history.

### Layer 4
Bounded top-5-per-main-bucket ownership with anti-churn, spill/fill honesty, and hold windows.

### Layer 5
Rank-sensitive deep refresh only for the current promoted set.

## Current active implementation boundary

The repo is now being tightened toward:
- Layer 1 as the true boot gate
- one dispatcher + schedule wheel instead of one giant heartbeat blender
- focused-symbol fast HUD paint only for the active symbol
- top-5-per-bucket Layer 4 ownership
- rank-sensitive Layer 5 cadences
- dossiers as consumer surfaces rather than the birthplace of truth
