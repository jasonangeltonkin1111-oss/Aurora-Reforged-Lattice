# ASC Dispatcher and Lane Model

## Purpose

This file makes the new scheduler shape explicit.
ASC is not a giant heartbeat.
ASC is one dispatcher timer that admits narrow lanes of work.

## MT5 grounding

The dispatcher model exists because MT5 imposes hard event rules:
- one timer per EA/program
- timer events are not repeatedly queued when one is already queued or processing
- `OnTick()` is only for the chart symbol and cannot own the whole universe
- chart events are interaction hooks, not a scheduler replacement

## Dispatcher spine

### Timer modes
- normal mode: 1 second
- focused symbol mode: higher resolution allowed for display-fast paint only

### Core dispatcher loop
Each pulse:
1. capture current server/dispatcher time
2. update queue-health metrics
3. decide whether focused-symbol fast paint is due
4. admit lanes by priority
5. stop after 3 light lanes or 1 heavy lane
6. flush due publication lanes if still admitted
7. record pulse cost and backlog

## Lane catalog

### Light lanes
- L1 maintenance slice
- L2 packet slice
- L3 gate slice
- focused HUD paint slice
- small persistence flush slice

### Heavy lanes
- L1 full-universe boot acquisition
- L4 shortlist/top-5 rebuild
- L5 deep wave
- dossier compose wave
- broad layout/object rebuild wave

## Admission rules

### Light-only pulse
Allowed when:
- queue health is good
- no heavy lane is due with higher priority

### Heavy-only pulse
Required when:
- boot acquisition is running
- shortlist rebuild is materially due
- deep wave is due and the hold window permits it
- a broad compose/layout rebuild is required

### Rejection rules
Reject or defer work when:
- queue health is poor
- the pulse already admitted 3 light lanes
- a heavy lane is already admitted
- the request comes from a non-owning layer

## Layer examples

### Boot pulse
- heavy lane: Layer 1 boot acquisition only

### Normal pulse
- light lanes: focused HUD paint + Layer 1 maintenance + one small persistence flush

### Promotion pulse
- heavy lane: Layer 4 shortlist rebuild only

### Deep pulse
- heavy lane: Layer 5 promoted-set refresh wave only

## Queue-health fields

Recommended runtime fields:
- `pulse_started_at`
- `pulse_duration_ms`
- `pulse_kind`
- `lane_count`
- `skipped_pulse_count`
- `deferred_heavy_count`
- `deferred_light_count`
- `queue_pressure_state`

## Invalid designs

The following are invalid:
- “everything due runs now”
- a focused symbol page that drags Layer 4 and Layer 5 with it
- a timer pulse that mixes shortlist rebuild with deep wave and dossier compose together
- broad whole-universe writes from display-fast movement
