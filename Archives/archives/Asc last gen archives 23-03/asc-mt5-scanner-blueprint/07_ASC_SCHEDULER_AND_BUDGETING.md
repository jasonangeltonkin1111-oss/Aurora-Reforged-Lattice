# ASC Scheduler and Budgeting

## Purpose

ASC scheduling is now explicitly dispatcher-and-lane based.
The old mental model of “one heartbeat that just does all due things” is rejected.

## Budget law

Per pulse ASC may run:
- up to 3 light lanes, or
- exactly 1 heavy lane

## Light lanes
- Layer 1 maintenance
- Layer 2 packet slice
- Layer 3 gate slice
- focused-symbol HUD paint
- small persistence flush

## Heavy lanes
- Layer 1 boot acquisition
- Layer 4 shortlist rebuild
- Layer 5 deep wave
- dossier compose wave
- broad layout rebuild

## Fairness

Use:
- round-robin cursoring
- age boost for neglected due items
- debt tracking for deferred families
- promoted-set hold windows

## Queue-protection budget

A pulse is invalid if it is long enough to poison timer cadence.
So budgeting is about:
- time cost
- lane count
- heavy-lane exclusivity
- queue health

## Later-layer calm-down rule

Once Layer 4 settles the promoted set, upper layers should calm down.
Layer 5 then becomes the main selective refresh owner.
That means the runtime should not keep broad Layer 3/4 churn alive just because promoted symbols now exist.
