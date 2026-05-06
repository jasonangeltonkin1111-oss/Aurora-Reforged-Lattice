# ASC Stage 2 — Dispatcher and Governor

## Purpose

This document defines Stage 2 of the Aurora Sentinel Core (ASC) rebuild roadmap.

Stage 2 is the dispatcher-and-governor stage.
Its job is to create the runtime control spine that all later layers, persistence work, tactical HUD reads, and recovery behavior must obey.

If Stage 1 creates the shared language of the system, Stage 2 creates the first real runtime authority of the system.

This stage exists because ASC must not let layers self-schedule, let HUD visibility become hidden runtime authority, or let persistence operate as residue.
Before the truth stack is implemented, the machine needs a lawful heartbeat owner.

---

## Stage objective

Stage 2 establishes the governed single-dispatcher runtime spine.

It defines and/or implements the first lawful versions of:
- the dispatcher heartbeat entry
- dominant-lane selection
- sublane admission posture
- class-aware work credits
- runtime modes
- starvation detection posture
- congestion posture
- persistence override posture
- dirty-routing intake surfaces
- heartbeat telemetry posture

The goal is not to finish every runtime nuance.
The goal is to make later layer work occur inside a real governed runtime rather than inside ad hoc timer logic.

---

## Why Stage 2 matters

Without a dedicated dispatcher/governor stage, the first implemented layers will naturally begin to:
- self-admit work inside their own modules
- widen a timer pulse opportunistically
- mix unlike work classes casually
- create local backlog policies that disagree with one another
- treat writes or focus updates as immediate rights

Stage 2 prevents that by making admission law real before the layers become rich enough to demand exceptions.

---

## Stage 2 dependency position

Stage 2 depends on:
- Stage 0 repo reset being complete
- Stage 1 foundational types/state/contracts being complete enough to support runtime posture
- final blueprint files for core runtime law, work classes, five-layer system, and governor/starvation law already being authoritative

Stage 2 is the prerequisite for:
- Layer 1 runtime implementation
- lawful layer dirty-routing and downstream eligibility behavior
- persistence landing windows in later stages
- tactical HUD admission in later stages
- recovery-mode behavior in later stages
- any future runtime implementation that wants to remain lawful under the heartbeat/lane model

If Stage 2 is weak, every later stage will try to compensate locally.

---

## Runtime Execution Model — Heartbeat & Lane System (MANDATORY)

This section is hard law for Stage 2.
It must be read before implementing dispatcher/governor behavior.
It must not be treated as optional guidance.

Any dispatcher/governor implementation that violates this section is invalid even if it compiles.
Code must conform to blueprint law.
Code must not redefine runtime behavior by convenience.

### 1. Heartbeat law
The system operates on a discrete repeating heartbeat.

Each heartbeat:
- executes exactly one major work lane
- may execute one bounded sub-lane
- must not execute multiple heavy domains concurrently

No uncontrolled parallelism is allowed.

### 2. Lane system law
The runtime is divided into major lanes such as:
- Market Scan
- Publication (Write)
- Read / Display (HUD / Explorer)
- future analysis domains

Rules:
- only one major lane per heartbeat
- lanes must not mix responsibilities
- lanes must not execute concurrently
- each lane owns a clear responsibility boundary

### 3. Breathing cycle law
The runtime follows a breathing sequence:

Scan -> Write -> Read -> Repeat

Example:
- Heartbeat 1: Scan
- Heartbeat 2: Write (atomic)
- Heartbeat 3: Read / Display
- Heartbeat 4: Scan

This breathing model must be preserved.
Future chats must not invent a burst model that casually collapses unlike domains into one pulse.

### 4. Atomic write law
All publication must be atomic.

Rules:
- write operations are exclusive
- during write, other lanes pause briefly
- no partial file states are allowed

Required sequence:
- write to temp
- validate
- promote
- maintain last-known-good fallback

The write phase must never be mixed with scanning or heavy computation.

### 5. Work budget law
Each lane must respect bounded work per heartbeat.

Work must:
- scale with symbol-universe size
- avoid blocking the heartbeat
- be split across cycles

Example guidance, without freezing exact numbers:
- Market scan: wide coverage, fast
- Snapshot work: medium batch
- Filtering work: smaller batch

No unbounded loops inside a single heartbeat are allowed.

### 6. Fairness / progression law
Processing must not restart from the beginning every cycle.

Rules:
- maintain cursor state
- continue from last position
- ensure full coverage over time

Avoid starvation of symbols through repeated front-of-list restarts.

### 7. Separation of responsibility law
Each lane must remain pure:
- Scan: detect only
- Write: format and publish only
- Read: consume prepared data only

No lane may perform another lane's role by convenience.

### 8. HUD / display law
HUD must:
- not trigger heavy recomputation
- read prepared state
- perform lightweight updates only

HUD interaction may:
- briefly pause background work
- improve responsiveness

HUD must never become a hidden compute engine.

### 9. No heavy concurrency law
The runtime must not run scanning, writing, and display logic at the same time.
All heavy domains must remain lane-isolated.

### 10. Performance intent law
The runtime model prioritizes:
- consistency over speed spikes
- smoothness over burst throughput
- deterministic behavior over uncontrolled concurrency

This model is required for:
- large symbol universes
- stable HUD behavior
- consistent publication
- correct summary and dossier outputs

---

## Stage 2 scope

Stage 2 includes:
- building the dispatcher entry spine
- defining runtime modes in executable posture
- defining major-lane ownership per heartbeat
- defining sublane admissibility posture
- implementing class-aware work-credit handling
- implementing starvation and congestion detection posture
- implementing forced-service hooks for protected obligations
- defining heartbeat telemetry and inspection posture
- defining the bridge between dirty-routing requests and governor admission

Stage 2 does **not** include:
- full Layer 1 market-state logic
- Layer 2 packet logic
- Layer 3 filtering logic
- Layer 4 shortlist logic
- Layer 5 deep logic
- final persistence-family landing mechanics
- final HUD page/render logic

Those belong to later stages.

---

## Stage 2 deliverables

Stage 2 should deliver the following runtime-control outcomes.

### 1. One dispatcher runtime entry
The MT5 surface must have a thin but real runtime entry path such that heartbeat authority is centralized.

This includes:
- a dispatcher-facing runtime manager entry
- one heartbeat entrypoint
- no competing scheduler roots

### 2. Mode-aware governor skeleton
The governor must have a real runtime state model for at least the canonical modes:
- Warmup
- Normal
- Focus
- Congestion
- Recovery
- Degraded

It is acceptable if some later stages enrich the transition logic, but the stage must establish the mode framework and its ownership now.

### 3. Major-lane ownership model
The runtime must be able to state, per heartbeat:
- which major lane owns the pulse
- why it was chosen
- what companions are allowed
- what is forbidden this beat

### 4. Work-credit system
The runtime must have class-aware credits or equivalent bounded service allowances.
These credits must be real enough that later layer work cannot quietly expand without explicit budget posture.

### 5. Starvation/congestion posture
The runtime must be able to recognize protected starvation and pressure conditions at a structural level, even before all later layers exist.

### 6. Dirty-routing intake surface
There must be a defined way for later layers to declare work eligibility without self-admitting that work.

### 7. Heartbeat telemetry posture
The runtime must be able to expose enough information to inspect heartbeat ownership, mode, pressure, and deferral posture honestly.

---

## Canonical files/domains implicated by Stage 2

Stage 2 should primarily engage the `control/` and `runtime/` domains, with support from `types/`, `config/`, and `core/`.

Typical target files include:
- `mt5/include/asc/runtime/ASC_Runtime_Manager.mqh`
- `mt5/include/asc/runtime/ASC_Runtime_Boot.mqh`
- `mt5/include/asc/runtime/ASC_Runtime_ModeBridge.mqh`
- `mt5/include/asc/runtime/ASC_Runtime_DirtyRouting.mqh`
- `mt5/include/asc/control/ASC_Control_Governor.mqh`
- `mt5/include/asc/control/ASC_Control_Modes.mqh`
- `mt5/include/asc/control/ASC_Control_Lanes.mqh`
- `mt5/include/asc/control/ASC_Control_Credits.mqh`
- `mt5/include/asc/control/ASC_Control_Starvation.mqh`
- `mt5/include/asc/control/ASC_Control_Queues.mqh`
- `mt5/include/asc/control/ASC_Control_HeartbeatTelemetry.mqh`

This stage may also require small thin wiring in:
- `mt5/experts/Aurora Sentinal Core.mq5`

But the entrypoint must remain thin.

---

## Dispatcher doctrine in Stage 2

### One heartbeat authority
The dispatcher must become the only legal heartbeat owner.
No layer module may create an alternative rhythm center.

### Heartbeat contract must become executable
At minimum, the dispatcher/governor surface should now be able to answer:
- current mode
- owning lane
- allowed companions
- credit budget posture
- early-yield conditions
- whether persistence override is pending

### No pulse ambiguity
A heartbeat should not be allowed to run in a way that leaves later inspection unable to say which lane owned it.

---

## Lane doctrine in Stage 2

### Major lanes must be real runtime concepts
Stage 2 should create the executable representation of major-lane ownership.
This does not require every later lane to be fully implemented yet, but the runtime must already understand the concept of:
- owning lane
- candidate lane
- deferred lane
- forced lane
- forbidden lane in current mode

### Sublane posture must be representable
Even before all layer logic exists, the runtime must already have room for bounded sublane concepts such as:
- Layer 1 broad scan slice
- Layer 1 confirmation slice
- Layer 2 packet slice
- Layer 3 gate slice
- Layer 4 shortlist slice
- Layer 5 deep slice
- persistence landing slice
- tactical HUD slice

The point is not to implement them all now.
The point is to make sure the governor vocabulary is ready for them.

---

## Work-credit doctrine in Stage 2

### Credits must become real now
Stage 2 must not postpone work credits until later.
Without real credits, later stages will naturally assume they can spend “just a little more” runtime whenever work appears.

### Credits must be class-aware
At minimum, Stage 2 must preserve the ability to distinguish credit posture across classes such as:
- cheap broad scan
- packet/snapshot work
- calculation/gate work
- promotion/select work
- deep-analysis work
- persistence/write work
- HUD/render work

### Credits must include stop conditions
A credit model is incomplete if it can count units but cannot explain when a beat must stop.

---

## Mode doctrine in Stage 2

### Modes must be operational, not decorative
Stage 2 should make runtime modes materially real enough that later work can actually respond to them.

At minimum, a mode should influence:
- lane priority posture
- credit posture
- companion-work tolerance
- starvation sensitivity
- persistence protection posture

### Minimum mode requirements

#### Warmup
Must strongly protect foundational truth acquisition.

#### Normal
Must provide calm lane rotation without hiding pressure.

#### Focus
Must allow narrow tactical elevation without granting broad compute authority.

#### Congestion
Must narrow nonessential work and preserve protected obligations.

#### Recovery
Must support bounded restoration of truthful runtime posture.

#### Degraded
Must represent explicit weakened guarantees rather than fake normal behavior.

---

## Starvation doctrine in Stage 2

### Starvation must be class-aware early
Even before all later layers are implemented, the runtime must already be capable of detecting starvation by class and protected obligation rather than by generic backlog size alone.

### Minimum starvation targets
At minimum, Stage 2 should preserve the ability to detect future starvation in:
- Layer 1 warmup/foundational scan service
- atomic persistence landing
- bounded tactical truth where explicitly protected
- forced recovery obligations

### Forced-service posture
Stage 2 should create the conceptual and structural hooks for forced service even if later stages refine exact thresholds.

The runtime must already know that some work, once deferred too long, cannot stay discretionary forever.

---

## Congestion doctrine in Stage 2

### Congestion must be a real runtime posture
Stage 2 should make it possible for the governor to shift into a pressure-aware mode where:
- cosmetic work yields first
- protected writes gain priority
- broad heavy waves may be deferred
- optional backlog is allowed to wait honestly

### Congestion must not be hidden
A quiet system that is only quiet because protected work is not being served is not healthy.
Stage 2 should already protect against that pattern conceptually and structurally.

---

## Dirty-routing intake doctrine

### Dirty-routing is eligibility, not admission
Stage 2 should establish the executable distinction between:
- a unit of work becoming eligible because upstream truth changed
- that work actually being admitted this heartbeat

### Why this matters now
If this distinction is not built before later layers exist, each layer will tend to create its own hidden “run me now” rules.

### Dirty-routing should be localizable
Even at this stage, the dirty-routing surface should favor local affected-scope tracking rather than broad implicit recompute entitlement.

---

## Persistence override doctrine in Stage 2

### Persistence cannot wait until the persistence stage to exist conceptually
Even before full family-aware landing logic is built, Stage 2 must establish the control posture that persistence may become protected work when atomic landing age or continuity risk demands it.

### Why this must happen now
If later stages build layers first without persistence override posture in the governor, then write behavior will tend to become side-effect residue.

Stage 2 therefore needs to make room for:
- write-lane ownership
- bounded write companionship
- override escalation for protected landings

The details come later, but the control law starts here.

---

## Heartbeat telemetry doctrine in Stage 2

### Telemetry must start early
The runtime should become inspectable as soon as the governor exists.
Otherwise, later stages will make it difficult to tell whether problems came from layer logic or from control logic.

### Minimum heartbeat telemetry should be able to answer
- what mode was active
- which lane owned the beat
- what credits were granted/used
- what was deferred
- whether starvation or override posture existed
- why the beat yielded

This telemetry does not need to be visually rich yet.
It needs to be structurally real.

---

## Entry-point posture in Stage 2

### EA file remains thin
Stage 2 may require event wiring through `Aurora Sentinal Core.mq5`, but the entry file must remain thin.
Its job is to delegate MT5 lifecycle hooks into the runtime manager, not to become the real governor.

### Minimal expected event posture
Stage 2 should make the following wiring real in a bounded way:
- `OnInit()` -> runtime bootstrap
- `OnTimer()` -> dispatcher heartbeat
- `OnDeinit()` -> runtime shutdown
- `OnChartEvent()` -> bounded HUD/input bridge only

The meaning of the system must still live below the entrypoint.

---

## What Stage 2 must not do

### 1. No layer logic smuggling
Do not hide real Layer 1 or Layer 2 behavior inside the governor just because the governor is active first.

### 2. No UI-led governor shaping
Do not let focus/UI logic become the first real runtime authority.
Focus is an overlay, not the scheduler.

### 3. No fake modes
Do not create mode names that do not materially change runtime posture.

### 4. No generic budget counter pretending to solve everything
Credits must remain class-aware.

### 5. No backlog theater
Do not produce counters that make the runtime look healthy while protected work is still starving.

### 6. No persistence side-effect loopholes
Do not let later code assume it can publish whenever convenient just because the persistence stage is not “finished” yet.

---

## Stage 2 implementation approach

The preferred progression inside Stage 2 is:

1. create runtime-manager and governor entry scaffolding
2. establish major-lane and sublane vocabulary in executable form
3. establish mode handling and mode transitions in bounded form
4. implement class-aware credits and stop conditions
5. implement dirty-routing intake and deferred-work posture
6. implement starvation/congestion posture and forced-service hooks
7. expose heartbeat telemetry
8. verify the entrypoint remains thin and delegating

### Why this order matters
The runtime manager provides the handshake.
Lane/mode/credit concepts define the legal space.
Starvation and telemetry then make that space inspectable and trustworthy.

---

## Stage 2 quality gates

Stage 2 is complete only when all of the following are true:

### Gate 1 — One dispatcher spine exists
There is one real runtime heartbeat authority and it is structurally central.

### Gate 2 — Major-lane ownership is explicit
A heartbeat can identify its owning lane unambiguously.

### Gate 3 — Credits are class-aware
The runtime has bounded work-credit posture that distinguishes unlike work classes.

### Gate 4 — Modes are operational
Modes materially change runtime posture rather than merely existing as labels.

### Gate 5 — Starvation/congestion posture exists
The runtime has structural awareness of protected starvation and congestion risk.

### Gate 6 — Dirty-routing does not self-admit
Work eligibility can be recorded without bypassing governor admission.

### Gate 7 — Entry file remains thin
MT5 lifecycle wiring delegates rather than becoming the control center itself.

### Gate 8 — No layer ownership has been absorbed
The control spine does not secretly implement layer truth behavior.

---

## Evidence required for Stage 2 completion

Stage 2 completion should be evidenced by:
- real runtime-manager/governor control files in the MT5 surface
- explicit lane/mode/credit structures in code planning or implementation
- explicit starvation/congestion posture in the control surface
- dirty-routing intake structure
- heartbeat telemetry surface
- office tracking showing Stage 2 completion honestly
- later stages being able to rely on governor admission rather than inventing their own

A timer that merely fires is not enough.
The evidence must show governed runtime posture.

---

## What Stage 2 makes newly admissible

Once Stage 2 is complete, the following become admissible:
- Stage 3 Layer 1 implementation inside a lawful heartbeat/governor system
- later layer dirty-routing against a real admission surface
- persistence landing work in future stages against a real write-lane posture
- tactical HUD rights in future stages against a real focus overlay posture

What does **not** become automatically admissible:
- skipping directly to deep logic because the timer exists
- letting layers self-schedule because the governor is “close enough”
- treating mode names as proof the runtime is already pressure-safe

---

## Common failure patterns Stage 2 must prevent

### Pattern 1 — Timer without governor
A timer exists, but lane selection, credits, and mode posture are still implicit.

Result:
- later layers self-schedule anyway
- blended heartbeat behavior returns quickly

### Pattern 2 — Fake mode scaffold
Mode enums exist, but no real posture changes occur when they switch.

Result:
- runtime looks designed but still behaves opportunistically

### Pattern 3 — Credits as decoration
A budget counter exists, but it does not actually stop widening or distinguish cost classes.

Result:
- the next stages will quietly overspend pulses

### Pattern 4 — Dirty means run now
Dirty-routing exists conceptually, but the code path still self-admits eligible work immediately.

Result:
- local modules become hidden schedulers

### Pattern 5 — Early focus takeover
Focused-symbol behavior becomes the first strong runtime cadence while foundational structural cadence remains weak.

Result:
- UI shape starts driving runtime design

---

## Stage 2 invalid completions

Stage 2 is **not** complete if any of the following are true:
- multiple plausible runtime heartbeat owners still exist
- lane ownership is not inspectable per beat
- credits remain generic or mostly decorative
- modes exist only in name
- starvation/congestion posture is absent or cosmetic
- layers would still need to self-admit work to function
- dirty-routing still behaves like implicit immediate execution
- the entrypoint file has become the real logic center

---

## Relationship to later stages

Stage 2 does not yet deliver scanner truth.
It delivers the runtime law inside which scanner truth will later be built.

That means later stages should rely on Stage 2 for:
- legal heartbeat ownership
- lane/mode/credit posture
- dirty-routing admission distinction
- starvation and congestion structure
- thin MT5 lifecycle delegation

If later stages still have to invent their own scheduler logic, Stage 2 was incomplete.

---

## Final standard

Stage 2 is correct when ASC has a real governed heartbeat spine strong enough that every later layer is forced to become a lawful resident instead of an opportunistic scheduler.

That means Stage 2 must leave ASC with:
- one dispatcher runtime authority
- explicit major-lane ownership
- class-aware work credits
- real runtime modes
- starvation/congestion posture
- dirty-routing without self-admission
- heartbeat telemetry strong enough to inspect runtime rhythm honestly
- a thin entrypoint that delegates instead of thinking

The standard is not that a timer runs.
The standard is that a lawful runtime now exists for the scanner to inhabit.