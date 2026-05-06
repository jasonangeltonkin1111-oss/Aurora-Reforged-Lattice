# ASC Runtime Kernel and Event Model

## Runtime philosophy

ASC is timer-driven orchestration with optional live tick evidence as one input into symbol-state truth.
That is not a style preference. It is the correct MT5 posture.

## MT5 event stance

### One-timer law
Each EA/program gets one timer.
So ASC must not be designed as if it can run many independent MT5 timers for many services.
Cadence diversity must be internal scheduler truth.

### Queue law
If a timer event is already queued or being processed, MT5 does not keep adding more timer events.
Therefore long handlers directly damage cadence quality.
ASC must optimize for short handlers and bounded pulses.

### `OnTick()` law
`OnTick()` belongs only to the chart symbol.
It is not the whole-universe control plane.
ASC should keep `OnTick()` empty or nearly empty.

### `OnChartEvent()` law
`OnChartEvent()` is for interaction and explicit layout invalidation.
It is not permission to trigger scanner recomputation.

## Kernel responsibilities

The kernel decides:
- what lane is due now
- what may wait
- what is too expensive this pulse
- what is stale enough to justify work
- what must publish now
- what must be deferred for queue health

The kernel does not decide trader-facing interpretation.

## Dispatcher model

### Base dispatcher
- default cadence: 1 second
- job: orchestration only

### Focus dispatcher mode
When a focused symbol page is active, ASC may temporarily use a higher-resolution timer for display-fast focused-symbol paint only.
That fast mode must remain cheap and reversible.

## Lane model

### Light lanes
- Layer 1 maintenance slice
- Layer 2 packet slice
- Layer 3 gate slice
- focused-symbol HUD paint slice
- small persistence flush slice

### Heavy lanes
- Layer 1 full-universe boot acquisition
- Layer 4 shortlist/top-5 rebuild
- Layer 5 deep refresh wave
- dossier compose/export wave
- broad HUD layout rebuild wave

### Admission law
Per pulse ASC may run:
- up to 3 light lanes, or
- exactly 1 heavy lane

## Re-entry guard

The runtime should protect against overlapping work.
Use:
- `g_heartbeat_running`
- pulse start/end timestamps
- skipped/deferred pulse count
- queue-pressure flags

If a pulse is already active:
- do not re-enter
- mark the next pulse skipped/deferred
- do not silently widen the next pulse to “catch up everything”

## Due-item model

A due item is the atom of work.
Recommended fields:
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

## Dispatch priority

Suggested priority order:
1. queue health / runtime safety
2. focused-symbol fast paint
3. Layer 1 due work
4. Layer 2 due work
5. Layer 3 due work
6. Layer 4 due work
7. Layer 5 due work
8. publication/persistence
9. cosmetic layout work
