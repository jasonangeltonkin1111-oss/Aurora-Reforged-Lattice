# ASC Governor Modes and Starvation

## Purpose

This document defines the canonical governor model of Aurora Sentinel Scanner (ASC).

The governor is the runtime control authority.
Its job is not to invent scanner truth.
Its job is to decide, per heartbeat, which already-defined class of work is allowed to own the pulse, how much of it may proceed, what must yield, and how starvation is detected before the system decays into false calm or blended-pulse chaos.

Binding reference: `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`.

The governor exists because the scanner does not fail only by doing too much.
It also fails by doing the wrong kinds of work together, by letting noisy classes crowd out protected classes, and by mistaking visible activity for honest progress.

This file makes the breathing system explicit.

---

## Core doctrine

### Governor-authority law
The governor owns heartbeat admission and major-lane control.
No individual layer, HUD surface, persistence writer, or convenience helper may silently seize pulse ownership.

Layers may request service.
Dirty routing may create eligibility.
The governor decides what actually runs now.

### One-major-lane-per-heartbeat law
Each heartbeat has one dominant major lane.
That dominant lane determines:
- pulse identity
- work-class posture
- budget posture
- yield behavior
- which companion work, if any, is allowed

This law exists to prevent timer obesity and hidden pileups.
The scanner must breathe in bounded phases rather than attempt simultaneous ownership by every due subsystem.

### Breathing-system law
Scheduler calmness must not be confused with execution starvation.
Starvation is not solved by shrinking active-lane work into timid tiny packets; focused active-lane packet completion remains lawful.
Governor protection does not mean artificial slow-motion.
ASC is a breathing runtime.
At a high level it cycles through major families such as:
- scan / read acquisition
- write / persistence landing
- consume / HUD or recovery hydration

This does not mean only three total kinds of work exist.
It means the runtime must preserve phase identity.
The governor protects that identity so the machine does not revert to “everything due runs now.”

### Eligibility-is-not-admission law
A layer becoming dirty or due does not mean it gets immediate service.
Dirty routing creates eligibility.
The governor decides admission.

### Protected-class law
Some work classes must be protected from chronic starvation even when noisier classes appear more visibly active.
Protected classes typically include:
- atomic persistence landing
- Layer 1 scan during warmup or recovery
- bounded tactical truth for an explicitly focused symbol when architecture gives it priority

### Starvation-detection law
Backlog size alone is not a trustworthy measure of system health.
The governor must detect starvation by class, by artifact family, and by mode-sensitive guarantees.
A system can look busy while still starving what matters.

### No-fake-calm law
A quiet runtime is not healthy if it is quiet only because protected work never gets admitted.
The governor must be hostile to false calm created by deferral.

---

## What the governor owns

The governor owns:
- heartbeat ownership
- major-lane admission
- work-credit policy
- yield rules
- class fairness policy
- mode transitions
- congestion response
- starvation detection
- backlog truth interpretation
- heavy vs light posture distinction where architecture uses it
- heartbeat telemetry posture
- forced-service response for protected work when thresholds are crossed

The governor owns control, not scanner truth.

---

## What the governor does not own

The governor does not own:
- market-state truth
- packet truth
- filter truth
- shortlist truth
- deep truth
- artifact contents
- HUD wording
- architecture redesign on the fly

If the governor starts redefining what layers mean, the architecture is drifting.

---

## Canonical control units

### Heartbeat
A heartbeat is one governor decision cycle.
It is not just a timer tick.
It is a contract boundary where the runtime must answer:
- what mode are we in
- which major lane owns this beat
- what work class dominates the beat
- what credits apply
- what companion work, if any, is permitted
- what yields first under pressure
- whether starvation or forced landing must override normal rhythm

### Major lane
A major lane is the dominant work family for a heartbeat.
Typical major lanes may include:
- broad scan / acquisition lane
- snapshot / read lane
- calculation / gate lane
- promotion / selection lane
- deep analysis lane
- persistence / write lane
- HUD / render lane

Implementation may use different internal identifiers, but every admitted pulse must map to one dominant major lane.

### Sublane
A sublane is a narrower bounded unit of work inside the dominant major lane.
Examples include:
- Layer 1 confirmation slice
- Layer 2 admitted-subset packet slice
- Layer 3 dirty bucket reevaluation slice
- Layer 4 shortlist repair event
- Layer 5 promoted refresh slice
- atomic landing for a ready artifact family
- focused-symbol tactical HUD refresh

### Work credits
Work credits are the governor’s bounded allowance units.
They determine how much work of the currently admitted dominant lane may proceed before the beat must yield.
Credits are class-sensitive.
They are not one global universal budget pretending all work is equivalent.

---

## Governor goals

The governor must preserve all of the following simultaneously:
- rhythm clarity
- class separation
- protected guarantees
- truthful progression
- bounded latency for required landings
- resistance to noisy-class domination
- resistance to cosmetic activity replacing real progress

If a future implementation optimizes only for throughput and loses these, it is out of contract.

---

## Work-credit doctrine

### Why work credits exist
The scanner needs bounded forward motion without allowing one lane to quietly consume the whole runtime.
Credits are how the governor makes that boundary explicit.

### Credits are class-sensitive
A broad cheap scan lane may legitimately receive wide throughput credits.
A deep-analysis lane may receive far fewer units.
A persistence lane may receive small throughput but high landing priority.

This is why a single universal “items per beat” budget is invalid.
Credits must reflect class identity.

### Credits must define both width and stop conditions
A credit policy must answer:
- how many units may be serviced in this beat
- what counts as one unit for this class
- what event consumes extra credits
- what early-stop conditions end the beat before all credits are spent
- what class-specific guarantees still override nominal credit exhaustion

### Credits do not authorize class widening
A lane that still has spare credits may not opportunistically do another class of work just because time appears available.
Unused credits do not erase class boundaries.

---

## Mode doctrine

The governor must operate under explicit runtime modes.
Modes do not change architecture.
They change admission posture.

### Mode 1 — Warmup
Purpose:
- establish sufficient early truth for honest scanner admission

Typical posture:
- strong protection for Layer 1 scan service
- aggressive reduction of unknown market-state posture
- limited downstream admission until Layer 1 readiness is earned
- write protection for critical early landings

Warmup is not allowed to be held hostage by downstream richness.

### Mode 2 — Normal
Purpose:
- maintain rolling scanner truth with calm bounded rhythm

Typical posture:
- balanced lane rotation according to dirty routing and class importance
- stable persistence landing cadence
- protected tactical service only where architecture allows
- minimal noise-driven escalation

### Mode 3 — Focus
Purpose:
- honor bounded tactical immediacy for the currently focused symbol or page while preserving structural runtime law

Typical posture:
- limited tactical elevation for approved read/render surfaces
- no grant of lower-layer or deep entitlement merely because a page is open
- persistence cadence stays separate from tactical display cadence

Focus mode is a narrow overlay, not a new architecture.

### Mode 4 — Congestion
Purpose:
- respond when pressure rises enough that normal rotation no longer protects guarantees

Typical posture:
- cosmetic or lower-priority work yields first
- protected write landings gain priority
- broad heavy waves may be deferred
- dirty-but-noncritical lanes may remain pending longer

Congestion is about preserving truth under pressure, not about looking smooth.

### Mode 5 — Recovery
Purpose:
- restore truthful state after restart, reconnect, writer disruption, or continuity damage

Typical posture:
- Layer 1 and critical read-side recovery gain priority
- critical artifact landing or repair is protected
- downstream richness is gated until structural truth is re-established

### Mode 6 — Degraded
Purpose:
- acknowledge that one or more guarantees cannot currently be maintained at normal quality

Typical posture:
- preserve honesty over apparent completeness
- protect last-good visibility where allowed
- surface stale, degraded, pending, and blocked posture clearly
- avoid fake-normal pacing that hides damage

---

## Mode transition doctrine

### Transitions must be reasoned
The governor must know why it is entering or leaving a mode.
Mode changes may be triggered by:
- Layer 1 readiness thresholds
- pressure thresholds
- starvation thresholds
- recovery events
- focused-symbol state changes
- artifact landing failures that cross a degraded boundary

### Modes must not thrash
Mode transitions should themselves be stable.
A governor that flips constantly between modes becomes hard to trust.
Hysteresis or similar calm-down logic is allowed and usually desirable.

### Mode transitions do not erase class law
Changing mode changes admission priority, not ownership boundaries.
A congested system still may not let HUD seize shortlist authority.
A focused system still may not grant deep rights to non-promoted symbols.

---

## Heartbeat ownership doctrine

### Every beat must declare an owner
A heartbeat is incomplete if it cannot answer which major lane owned it.

### Owner determines allowed companions
Once the beat owner is selected, companion work is allowed only if it is:
- explicitly permitted for that owner
- materially smaller than the dominant work
- incapable of recursively triggering more work
- within budget and stop conditions

### Example valid owner patterns
- Layer 1 scan owner + tiny telemetry bookkeeping
- persistence owner + small landing audit marker
- focused HUD owner + bounded tactical direct read
- Layer 3 gate owner + tiny state counters

### Example invalid owner patterns
- Layer 1 scan owner + Layer 4 rebuild + dossier compose
- HUD owner + packet rebuild + filter rerun + write landing
- deep owner + broad universe scan + broad artifact flush

---

## Yield doctrine

### Why yielding exists
Yielding protects rhythm and prevents pulse obesity.
A lane must know when to stop even if useful work remains.

### First-yield ordering
Under pressure, the governor should usually yield in this order:
1. cosmetic extras
2. noncritical broad richness work
3. opportunistic recompute work
4. deeper heavy enrichment
5. only then protected landings or foundational truth service

The exact implementation may vary, but the protection hierarchy must survive.

### Forced yield conditions
A beat should yield early when:
- dominant-lane credits are exhausted
- a stop condition for the mode is reached
- latency or pressure thresholds are crossed
- a protected landing must preempt further expansion
- the beat risks losing its dominant-class identity

### Yield does not mean abandonment
Deferred work remains eligible later.
The governor must track that deferral honestly.

---

## Persistence override doctrine

### Why persistence may override
Atomic landing is not optional residue.
If ready committed truth cannot land, the scanner begins to separate visible memory state from trustable artifact state.
That is dangerous.

### Persistence override conditions
The governor may elevate persistence / write service when:
- a protected artifact family is ready to land
- landing latency crossed a bounded threshold
- a temp-to-final promotion is waiting
- a last-good preservation point is pending
- restart/recovery requires critical artifact stabilization

### Persistence override must remain bounded
Override does not mean “write everything now.”
It means the governor may admit a protected write lane or brief landing pause to prevent trust erosion.

### Write priority is not write frenzy
Protected landing must remain calm and atomic.
The governor must not respond to write pressure by widening into a same-speed write storm.

---

## Dirty-routing and lane admission doctrine

### Dirty routing creates candidate work
Dirty routing should specify:
- which symbols or artifacts are affected
- which class owns the next required action
- which later classes may become eligible later
- what remains explicitly unauthorized

### Admission must remain local when possible
If a local packet change dirtied one bucket or one symbol set, the governor should prefer local admission over broad recompute.

### Admission must remain class-faithful
A dirty Layer 2 packet event may make Layer 3 eligible.
It does not mean the governor should immediately admit Layer 4 or Layer 5 too.
Eligibility chains are not instant ladders.

---

## Starvation doctrine

### What starvation means
Starvation occurs when a class, artifact family, or protected runtime obligation remains repeatedly eligible but fails to receive sufficient service to preserve its architectural guarantees.

### Starvation is class-specific
A busy runtime may still be starving:
- persistence landings
- Layer 1 warmup coverage
- deep service for promoted members that were actually entitled to it
- focused tactical truth under an explicitly active focus policy

Therefore starvation must be measured by class, not just by total pending count.

### Starvation signals
The governor should watch for signals such as:
- repeated deferred count for the same class
- landing age beyond allowed thresholds
- unresolved protected dirty state across too many beats
- rising stale posture in a class that is supposed to remain current
- warmup coverage not advancing despite active pulses
- focus-entitled tactical truth lagging beyond policy limits

### Fake backlog vs real backlog
Not every pending unit is a crisis.
The governor must distinguish:
- real protected backlog that threatens truth or guarantees
- cosmetic or optional backlog that can wait

A healthy system may carry optional backlog.
It must not quietly carry protected starvation.

---

## Forced-service doctrine

### Why forced service exists
If a protected class is repeatedly deferred, the governor must eventually force admission rather than wait for the runtime to self-correct.

### Typical forced-service cases
Forced service may be appropriate when:
- Layer 1 warmup coverage stalls
- critical artifact landing age exceeds bounds
- shortlist validity is threatened and deferred too long
- promoted deep service falls behind beyond architecture limits
- recovery-mode obligations are stuck

### Forced service must stay narrow
Forced service should admit the minimum required lane or sublane to relieve the protected risk.
It must not become a panic wave that collapses class boundaries.

---

## Congestion doctrine

### What congestion means
Congestion means the runtime cannot continue normal rotation while preserving guarantees.
This is not just “the queue looks big.”
It is a condition where protected work is at risk unless the governor tightens posture.

### Congestion response
Under congestion the governor should generally:
- suspend cosmetic extras first
- defer noncritical heavy waves
- protect atomic landing
- protect foundational truth service
- reduce opportunistic recomputation
- keep tactical focus rights narrow and honest

### Congestion must remain explicit
The system should be able to say it is congested.
Silent congestion that merely manifests as stale truth is not acceptable.

---

## Fairness doctrine

### Fairness is not equal pulse count
Classes do not need identical service frequency.
They need the service profile their role demands.

### Fairness means protected adequacy
The governor is fair when:
- foundational classes do not stall
- protected writes land in time
- selected-set deep work gets honest service
- cosmetic work does not crowd out structural work

### Fairness must respect architecture, not UI impressions
The fact that a page is visible or moving is not, by itself, a fairness argument for giving it more runtime than a starving protected landing lane.

---

## Focus-mode doctrine

### Focus is bounded priority, not special sovereignty
The governor may elevate limited tactical service for the focused symbol or page when architecture explicitly allows it.
Governor mode may shape admission and protect classes, but may not reinterpret scheduler pulse as minimum compute boundary.
That service remains bounded to approved classes.

### Focus may elevate
Typical allowed focus elevation may include:
- tactical Layer 2 read for the selected symbol
- bounded HUD render refresh
- consumption of already-landed structural truth for the selected page

### Focus may not elevate
Focus may not justify:
- Layer 4 shortlist rebuild
- Layer 5 deep entitlement for a non-promoted symbol
- same-speed persistence landing
- broad packet refresh for unrelated symbols

### Focus must yield under protected pressure
If protected structural work is starving, focus extras must yield before core guarantees are broken.

---

## Telemetry doctrine

The governor must expose enough telemetry that runtime rhythm can be inspected honestly.
Useful telemetry may include:
- current mode
- dominant lane per beat
- credits granted and consumed
- forced-yield events
- deferred counts by class
- starvation flags by class
- protected landing age
- warmup coverage progression
- congestion posture
- focus overlay posture

Telemetry must support truth, not cosmetics.
If telemetry makes the runtime look calm while protected work is starving, the telemetry model is wrong.

---

## Common failure patterns

### Pattern 1 — Blended queue swamp
Everything due receives a little service every beat and nothing has real ownership.

Result:
- timer obesity
- class ambiguity
- hidden starvation

### Pattern 2 — Visible-busy false health
HUD moves, counters tick, and logs look active, but protected writes or Layer 1 coverage are not advancing.

Result:
- fake progress
- trust erosion

### Pattern 3 — Focus takeover
The focused page quietly becomes the runtime’s real scheduler.

Result:
- page-dependent truth
- unstable performance
- structural work starvation

### Pattern 4 — Universal budget superstition
One generic budget is applied to all classes as though they cost and matter equally.

Result:
- cheap broad scan gets unfairly throttled
- deep or write costs are mis-modeled
- rhythm degrades

### Pattern 5 — Congestion denial
The runtime is under pressure, but the governor keeps pretending it is in normal mode.

Result:
- stale truth rises silently
- guarantees break without explicit mode change

---

## Implementation obligations

Any future MT5 implementation of the governor must:
- declare one dominant lane per heartbeat
- keep class-aware credits explicit
- expose mode transitions and their reasons
- preserve protected-class guarantees under pressure
- distinguish real starvation from optional backlog
- provide forced-service mechanisms for protected obligations
- keep focus overlay narrow and subordinate to structural truth guarantees
- permit persistence override only in bounded protected form
- expose enough telemetry to inspect rhythm honestly
- refuse blended-pulse convenience paths that bypass admission rules

If an implementation cannot explain why a given beat admitted its owner instead of another eligible lane, that implementation is incomplete.

---

## Final standard

The governor is correct when it keeps ASC decisive under pressure.
Future implementation may not use governor wording as justification for fake throttling.

That means the runtime must remain:
- phase-aware
- class-separated
- mode-explicit
- credit-bounded
- starvation-aware
- protected where it matters
- calm without becoming fake-calm
- hostile to blended-pulse drift

The standard is not that the timer keeps firing.
The standard is that each beat remains understandable, justified, and protective of the guarantees that make the scanner trustworthy.
---

## Governing Contract Attachments (Operational)

For enforceable heartbeat-level admission behavior, starvation protection, and publication forcing, use the attached contracts below:

- `ASC_HEARTBEAT_BREATHING_CONTRACT.md`
  - defines per-beat lane decision precedence
  - defines forced-service triggers and starvation relief posture
  - defines companion-work allow/deny boundaries
- `ASC_MEMORY_RESIDENCY_AND_EVICTION_LAW.md`
  - defines dirty-routing ownership and non-self-admission boundaries
  - defines residency/eviction obligations that shape recovery and starvation handling
- `ASC_WRITE_TRIGGER_AND_PUBLICATION_MATRIX.md`
  - defines artifact-family publication triggers and guard-denial logic
  - binds write forcing to materiality/freshness/state transitions

These attachments are part of governor-runtime doctrine and are not optional guidance.
