# ASC Runtime and Scheduler

## Purpose

ASC must behave like a rolling runtime with:
- time
- memory
- due work
- bounded updates
- restore continuity
- safe publication
- explicit degradation
- queue protection

## MT5 event law

ASC is timer-driven orchestration.
This is not optional design taste.
It is a direct response to MT5 runtime behavior:
- one timer per EA/program
- timer events are not queued repeatedly if one is already queued or processing
- chart events and ticks are serialized through the program queue
- `OnTick()` is chart-symbol specific and cannot be the whole-universe control plane

Therefore ASC must use:
- one dispatcher timer
- one internal schedule wheel
- stage-owned due queues
- short handlers
- bounded per-pulse work

## Global dispatcher heartbeat

### Base mode
- default dispatcher cadence: 1 second
- job: orchestration only

This does not mean:
- every symbol updates every second
- every capability updates every second
- every field rewrites every second

It means:
- every second, ASC checks which lane(s) are due now and admits only a bounded subset

### Focus mode
When the operator is inside a focused symbol view, ASC may temporarily switch to a higher-resolution timer for HUD paint only.
That fast mode must stay:
- cheap
- scoped to the focused symbol
- display-only
- reversible on focus exit

## Runtime mode spine

### Boot mode
Creates shell state, loads config, discovers the current universe, restores continuity, and starts the dispatcher.

### Restore mode
Restores persistence first and validates what can be trusted.

### Warmup mode
Runs Layer 1 acquisition until market-state readiness is honestly earned.
Warmup exit is Layer-1-owned only.

### Steady-state mode
Rolls forward with due-based refreshes only.

### Degraded mode
Protects core truth when timer pressure, broker pressure, memory pressure, or file pressure rises.
Later layers yield first.

## Dispatcher lane model

ASC does not dispatch “everything due.”
It dispatches narrow lanes.

### Light lanes
- Layer 1 maintenance slice
- Layer 2 packet slice
- Layer 3 gate slice
- focused HUD live paint slice
- small persistence flush slice

### Heavy lanes
- initial Layer 1 full-universe acquisition
- Layer 4 shortlist rebuild
- Layer 5 deep refresh wave
- dossier compose/export wave
- broad HUD layout/object rebuild wave

### Admission law
Per dispatcher pulse ASC may run:
- up to 3 light lanes, or
- exactly 1 heavy lane

Heavy lanes may not be mixed with another heavy lane.

## Due item model

The scheduler works with discrete due items.
Each due item owns one narrow job.

Canonical fields:
- `due_id`
- `symbol`
- `layer`
- `lane`
- `task_kind`
- `field_group`
- `timeframe`
- `priority`
- `reason`
- `last_run_at`
- `next_due_at`
- `retry_count`
- `last_outcome`
- `estimated_cost`
- `hold_window_until`

## Due item examples

### Layer 1
- one symbol market-state recheck
- one near-open confirmation recheck
- one hourly session-schedule refresh slice

### Layer 2
- one symbol open-packet refresh
- one focused-symbol fast packet poll

### Layer 3
- one symbol eligibility reevaluation after Layer 1/2 change

### Layer 4
- one shortlist/top-5 rebuild for one main bucket set

### Layer 5
- one promoted symbol deep refresh for one rank cadence
- one timeframe packet refresh for one promoted symbol

### Publication
- one layer-owned symbol block flush
- one dossier compose pass for one promoted symbol set
- one summary compose pass when materially changed

## Scheduler priority spine

Suggested priority order:
1. runtime safety and queue health
2. focused HUD fast paint
3. Layer 1 due work
4. Layer 2 due work
5. Layer 3 due work
6. Layer 4 due work
7. Layer 5 due work
8. essential persistence/publication
9. cosmetic layout work

## Queue-protection law

A pulse is invalid if it risks starving the MT5 event queue.
Protect with:
- `g_heartbeat_running`
- pulse start/end timestamps
- skipped/deferred pulse counters
- lane-specific max-cost ceilings

If a pulse is already active:
- mark the next pulse skipped/deferred
- do not recursively enter
- do not silently widen the next pulse to “catch up everything”

## Layer 1 warmup law

Warmup exit is defined by Layer 1 truth only.
It is not keyed off:
- prepared explorer hydration
- dossier existence
- Layer 2+ packet completion
- HUD page state

Layer 1 warmup exit requires:
- first-pass market-state coverage across the configured minimum share of the live universe
- first-pass truth across the compressed priority-set-1 buckets
- confirmation rechecks for unresolved boot cases within the configured burst policy

## Fairness and starvation

The scheduler should not permanently favor the same symbols or the currently visible page.
Use:
- round-robin cursoring
- age-based boost for neglected due items
- debt tracking for deferred families
- separate caps for cheap vs expensive services
- explicit hold windows for Layer 4/5 promoted sets

## Retry behavior

### Retry soon
- temporary feed unavailable
- symbol not yet synchronized
- near-open confirmation case
- just-open confirmation case
- focused HUD packet unavailable for the current symbol

### Retry later
- closed and far from next session open
- symbol demoted from the promoted set
- heavy lane deferred by queue protection

### Do not retry blindly
- unsupported symbol property
- permanently invalid schema version
- bad configuration
- non-owned field request from the wrong layer

## HUD coupling law

The HUD may:
- request focus changes
- request navigation changes
- request a bounded focused-symbol paint mode

The HUD may not:
- authorize broad whole-universe recomputation
- trigger ranking rebuilds on page open
- force dossier compose on redraw
- bypass lane admission

## Persistence coupling law

Persistence is a lane, not an ambient side effect.
Fast display movement is not file-write permission.
The dispatcher decides when owned publication work is due.
