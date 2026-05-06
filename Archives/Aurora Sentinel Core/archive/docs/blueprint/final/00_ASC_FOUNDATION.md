# ASC Foundation

## Purpose

This document is the frozen structural authority for the rebuild of **Aurora Sentinel Scanner (ASC)**.

Its job is not to brainstorm.
Its job is to remove ambiguity.

The next version of ASC must not be built as an evolving pile of ideas. It must be built as a controlled engineering program with explicit boundaries, explicit contracts, explicit sequencing, explicit ownership, and explicit kill rules.

This file defines the system identity, repository shape, authority order, runtime posture, responsibility classes, layer posture, file and persistence doctrine, HUD doctrine, anti-loop rules, and the conditions under which implementation is allowed to proceed.

---

## Rebuild Doctrine

The rebuild is based on one hard conclusion:

> repeated restarts are not primarily a coding failure;  
> they are primarily a system-definition failure.

The historical failure pattern is assumed to be:

1. implementation begins before architecture is fully frozen
2. hidden contradictions survive into runtime
3. patches accumulate around undefined or overlapping responsibilities
4. complexity expands faster than clarity
5. trust in the build collapses
6. restart follows

The rebuild therefore prioritizes:

- frozen design boundaries before implementation
- fewer degrees of freedom
- explicit ownership of runtime responsibilities
- explicit contracts between layers, modules, and files
- staged delivery order
- removal of spontaneous implementation invention
- clear kill rules for invalid patterns

ASC must no longer solve architecture during coding.

---

## Archive Posture

The old ASC archive is **evidence**, not authority.

It exists to:
- preserve lineage
- reveal failure patterns
- show which ideas were valuable
- show which shapes caused drift

It does not have automatic authority over the rebuild.

Nothing is inherited merely because it existed before.
Legacy ideas survive only if they remain coherent, bounded, and compatible with the new design law.

---

## ASC Identity

ASC is a **stateful MT5 scanner EA**.

Its purpose is to:
- observe the broker symbol universe
- determine market-state truth
- build progressively richer symbol truth in layers
- persist that truth safely and atomically
- surface that truth clearly through operator-facing views
- do so with bounded runtime pressure and stable heartbeat behavior

ASC is **not**:
- an execution EA
- a signal generator
- a portfolio allocator
- a HUD-driven calculation engine
- a dossier-first truth engine
- a giant all-at-once analytics monolith
- a patch-driven architecture project

ASC must prefer:
- continuity over bursts
- explicit ownership over convenience
- bounded cadence over opportunistic sprawl
- atomic correctness over throughput illusions
- operator clarity over internal cleverness
- stable truth progression over reactive chaos

---

## Top-Level Repository Shape

ASC is constrained to exactly **three primary domains**:

- `blueprint`
- `mt5`
- `office`

### Domain meanings

#### `blueprint`
The architectural truth of the system.

Contains:
- final design law
- runtime contracts
- layer model
- lane model
- heartbeat model
- persistence model
- HUD model
- build roadmap
- acceptance criteria

`blueprint` defines what the system is allowed to become.

#### `mt5`
The implementation domain.

Contains:
- runtime code
- modules
- definitions
- execution-safe implementation artifacts

`mt5` does not invent architecture.
It implements already-approved blueprint contracts.

#### `office`
The operational control domain.

Contains:
- decisions
- status
- audits
- work logs
- change records
- future ideas not yet promoted into blueprint

`office` is the pressure-release chamber.
It exists so that new ideas do **not** leak directly into code.

### Hard boundary rule

No new top-level domain may be introduced unless the existing three-domain structure is proven insufficient by explicit written decision inside `office`, followed by a blueprint update.

Default posture: **do not expand the shape**.

---

## Authority Ladder

When conflicts appear, authority resolves in this order:

1. `blueprint/final/00_ASC_FOUNDATION.md`
2. other files inside `blueprint/final`
3. files inside `blueprint/roadmap`
4. recorded decisions inside `office`
5. `mt5` implementation reality

Code is not the source of truth when it drifts from blueprint.
Code is a lagging artifact until corrected.

Roadmap is not allowed to silently redefine final architecture.
Office is not allowed to silently redefine blueprint.

---

## Primary Runtime Doctrine

ASC runtime is governed by four non-negotiable laws.

### 1. Single-dispatcher law
ASC runs through one dispatcher-controlled runtime spine.
MT5 event constraints are treated as architectural law, not implementation detail.

### 2. One-major-lane-per-heartbeat law
A heartbeat may have only one dominant major lane owner.
Minor bounded companion work is allowed only when explicitly authorized by budget policy.

### 3. Work-class separation law
Performance comes from separating work classes correctly, not from timidly touching fewer symbols.
The primary failure mode is not symbol count by itself; it is mixing too many work classes into the same pulse.

### 4. Scan -> atomic commit -> consume law
Truth must be acquired, committed, and consumed in disciplined order.
HUD and higher consumer surfaces must not become the birthplace of truth.

---

## Foundational Engineering Posture

The rebuild follows these principles:

### 1. Freeze before build
If a responsibility is not clearly owned, coding for it is premature.

### 2. One owner per concern
Every major runtime responsibility must have one primary owner.
Shared ownership is treated as latent instability unless explicitly justified.

### 3. Lanes are real runtime resources
Every lane consumes time, cadence, and interference budget.
A lane is not a conceptual bucket; it is a bounded runtime commitment.

### 4. Persistence is part of the operating system
Persistence is not a side-effect.
If truth cannot land safely and consistently, the upstream layer is incomplete.

### 5. HUD clarity is a product requirement
HUD is not decoration.
HUD is the operator-visible expression of system state and must be designed as a first-class contract surface.

### 6. New ideas do not enter code directly
Unplanned ideas go to `office` first.
Nothing enters `mt5` unless it is already defined or explicitly promoted into blueprint.

---

## Responsibility Classes

ASC runtime is divided into explicit responsibility classes.
These are not the same thing as layers.
They describe **what kind of work is being performed**.

### A. Market Read Path
Responsible for raw observable market intake.

Owns:
- symbol universe visibility
- open/closed status detection inputs
- direct bid/ask and other explicitly permitted live reads
- immediate read-side inputs required before truth construction

Does not own:
- final truth scoring
- persistence publication
- HUD navigation logic
- shortlist policy

### B. Truth Construction Path
Responsible for converting raw observations into progressively richer structured truth.

Owns:
- layer-by-layer derived state
- readiness transitions
- freshness status
- filter eligibility progression
- shortlist-eligible candidate truth

Does not own:
- atomic file promotion
- UI navigation handling
- ad hoc feature invention

### C. Persistence Path
Responsible for landing runtime truth safely and atomically.

Owns:
- temp writes
- promote writes
- last-good preservation where required
- bounded write cadence
- file-level continuity guarantees
- write observability

Does not own:
- broad truth derivation
- operator navigation
- strategy invention

### D. Persistence Read Path
Responsible for reading persisted artifacts when the design calls for file-backed consumption.

Owns:
- hydration from persisted state
- file-backed HUD panels where specified
- recovery visibility from landed runtime artifacts

Does not own:
- direct market reads unless explicitly assigned
- truth generation that belongs upstream

### E. HUD Direct Read Path
Responsible only for explicitly permitted real-time operator views that should bypass file-backed delay.

Allowed examples:
- ticking server time
- focused-symbol bid/ask
- selected direct market-watch columns

This path exists for operator immediacy, not for bypassing architecture.

### F. Control and Coordination Path
Responsible for heartbeat ownership, lane scheduling, budgets, and bounded runtime behavior.

Owns:
- major lane order
- sublane sequencing
- heartbeat admission
- per-pulse budgeting
- starvation prevention
- heavy vs light lane separation

Does not own:
- redefining downstream logic on the fly

---

## Work-Class Model

ASC must explicitly distinguish these work classes:

- **scan**
- **snapshot/read**
- **calc/gate**
- **promotion/select**
- **deep-analysis**
- **persistence/write**
- **HUD/render**

### Core law
The system must not treat these as interchangeable.
Runtime instability appears when too many classes are blended into the same pulse.

### Performance law
ASC is allowed to process large cheap batches where the work class is genuinely cheap.
Broad Layer 1 market-state scanning may therefore be high-throughput.
The design must not pretend that small weak batches are automatically superior.

### Mixing law
Allowed mixing must be explicit and bounded.
Default posture:
- one major work class owns the heartbeat
- any companion work must be narrow, cheap, and policy-approved

---

## Lane Model

ASC is designed around a **breathing system**, not a chaotic free-for-all.

### Major lane concept
Major lanes are broad bounded categories of work that rotate through runtime.

Baseline posture:
- major lane A: scan / read
- major lane B: write / persistence landing
- major lane C: consume / hydration / HUD support

This is a runtime breathing doctrine, not a claim that only three labels will ever exist.
The key requirement is phase discipline.

### One-major-lane-per-heartbeat rule
A heartbeat may admit only one major lane as the dominant owner of that pulse.

Minor bounded companion work is allowed only when explicitly permitted by policy and budget.
The runtime must never drift into uncontrolled multi-major-lane pileups.

### Sublane concept
Each major lane may contain sublanes representing narrower bounded units of work.

Examples:
- layer-specific scan work
- focused-symbol refresh
- atomic write promotion
- HUD hydration refresh

### Atomic-write pause rule
When a sublane reaches a designated persistence landing point, atomic write work may briefly preempt or pause competing activity long enough to complete the landing safely.

The system must prefer a short controlled pause over prolonged dirty-state uncertainty.

---

## Heartbeat Contract

Heartbeat is a contract surface, not merely a timer.

Each heartbeat must answer:
- which major lane owns this pulse
- which sublane or sublanes are allowed inside it
- what budget applies
- what is forbidden during this pulse
- whether a persistence landing checkpoint is due

### Required heartbeat properties

Every heartbeat policy must define:
- cadence source
- heavy-lane admission rules
- light-lane admission rules
- persistence override conditions
- HUD-safe rendering conditions
- backlog handling policy
- starvation detection hooks

### Forbidden heartbeat behavior

The following are forbidden unless later explicitly authorized in blueprint:
- unbounded lane stacking
- silent budget escalation
- allowing expensive writes to accumulate without landing policy
- letting HUD work freely compete with every other workload
- redefining cadence ownership inside implementation without blueprint change

---

## Layer Posture

Layers describe **how truth is progressively built**.
They are not interchangeable with responsibility classes.
A layer may use multiple work classes, but it must remain narrow in purpose and explicit in ownership.

### Layer 1
Owns broad market-state acquisition and low-cost availability truth.

### Layer 2
Owns open-symbol snapshot freshness and directly relevant packet truth construction.

### Layer 3
Owns candidate-filter truth and readiness progression.

### Layer 4
Owns shortlist selection and shortlist-shaping truth.

### Layer 5
Owns promoted-set-only deep selective analysis.

### Layer rule
A layer may not absorb responsibilities simply because it already touches nearby data.
Ownership creep is drift.

### Layer progression rule
Later layers may consume earlier truth.
They may not silently rebuild lower-layer truth just because they are due.

---

## File Contract Doctrine

If a file exists, it must have a declared role.

Every persisted artifact must define:
- its owner
- when it is written
- who reads it
- whether it is direct truth, derived truth, audit, snapshot, or recovery state
- whether it requires temp-write then promote behavior
- whether it requires last-good protection
- whether it is optional, required, or best-effort

### File categories

Persisted files should fall into explicit classes such as:
- runtime state
- scheduler/control state
- symbol snapshot truth
- filter truth
- shortlist truth
- dossier outputs
- audit logs
- HUD support artifacts

### Forbidden file behavior

The following are forbidden:
- mystery files with no documented owner
- multiple modules writing the same file without explicit arbitration
- persistent output with undefined promotion semantics
- HUD dependence on files that have no freshness contract

---

## Persistence Contract Doctrine

Persistence must be engineered for trust.

### Required persistence guarantees

Where applicable, persistence must support:
- write intent tracking
- temp write before promote
- final promotion to canonical path
- last-good preservation for important artifacts
- bounded retry behavior
- observability of pending vs landed state

### Persistence priorities

ASC must prefer:
1. correctness of landing
2. continuity of last-good visibility
3. predictable cadence
4. throughput optimization after the above

### Persistence failure contract

Each important artifact must define what happens if write landing fails:
- retry now
- retry later
- preserve last good
- mark degraded
- surface to HUD or audit

Silent persistence ambiguity is forbidden.

---

## HUD Contract Doctrine

HUD must clearly separate what is read directly from market state versus what is hydrated from persisted truth.

### HUD ownership rules

HUD may read directly, when immediacy matters:
- server time
- focused-symbol bid/ask
- explicitly authorized real-time columns

HUD may read from persistence, when structured truth matters:
- layered readiness
- dossier-backed summaries
- snapshot history
- shortlist context
- filter state

### Hybrid HUD law
The HUD must always know which source it is showing.
Direct market immediacy and persisted structured truth must never be blurred into one ambiguous feed.

### HUD refresh contract must define
- what refreshes per second
- what refreshes per heartbeat
- what refreshes after write landing
- what is allowed during transition lock
- what must remain frozen during page or mode change

### Transition posture
HUD may use bounded freeze or lock behavior to protect smooth transitions, but this must be explicitly timed and must not become a hidden runtime starvation engine.

---

## Timing and Budget Doctrine

Budgets are mandatory.

Every lane and sublane class must be able to state:
- expected frequency
- expected cost class
- maximum allowed work per pulse
- what yields first under pressure
- what must still land even under pressure

### Budget hierarchy

Under runtime pressure, ASC should generally prefer preserving:
1. control continuity
2. atomic persistence safety
3. focused-symbol truth freshness where explicitly prioritized
4. system-wide continuity
5. nonessential presentation extras

Optimization must not arrive by quietly deleting guarantees.

---

## Failure and Degradation Contract

Every important subsystem must define degraded behavior.

### Required degraded-state questions
- what remains visible if the latest write fails?
- what becomes stale but still serviceable?
- what is allowed to be pending?
- what must never silently disappear?
- what operator-facing signals expose the degradation?

### Design standard
A degraded system is acceptable.
An ambiguous system is not.

---

## Anti-Loop Rules

These rules exist specifically to stop restart recursion.

### Rule 1: no feature injection during implementation
If a feature is not already in blueprint, it does not go into code.
It goes into `office`.

### Rule 2: no contractless convenience
No shortcut is allowed if it creates hidden ownership overlap.

### Rule 3: no architecture solved inside a patch
Patches may repair implementation; they may not silently rewrite system shape.

### Rule 4: no broadening layers to rescue unclear design
If a layer needs to absorb unrelated responsibilities to make progress, the blueprint is incomplete.

### Rule 5: no uncontrolled top-level sprawl
The three-domain shape remains the default containment boundary.

### Rule 6: no roadmap before design freeze
Sequencing work may only proceed after authority and ownership are clearly frozen.

---

## Invalid Foundation Patterns

The following patterns are invalid at foundation level:
- giant blended heartbeat passes
- HUD-triggered lower-layer compute
- dossier-first truth creation
- silent budget escalation
- shared ownership without written arbitration
- implementation reality overruling blueprint by accident
- small weak throughput being mislabeled as discipline
- roadmap files quietly redefining final architecture

---

## Build Sequence Doctrine

The rebuild must proceed in this order:

1. system shape
2. authority model
3. runtime responsibility map
4. contracts
5. skeleton implementation
6. read path
7. truth path
8. persistence path
9. HUD path
10. control path
11. optimization after truth stability

This order is not optional unless a written blueprint exception is added.

---

## Definition of Done for the Rebuild Foundation

The foundation is valid only when all of the following are true:
- repository shape is stable and limited
- each major runtime concern has a single clear owner
- work classes are explicit
- lane and heartbeat contracts are explicit
- persistence behavior is explicit
- HUD direct-vs-persisted boundaries are explicit
- degraded behavior is visible and bounded
- roadmap work is subordinate to frozen design
- implementation can proceed without inventing architecture mid-flight

---

## Non-Goals

The rebuild foundation is **not** trying to:
- maximize cleverness
- capture every future idea immediately
- encode every micro-detail of optimization upfront
- justify existing drift because it already exists in code
- preserve complexity for its own sake

---

## Promotion Rule for New Ideas

A new idea may move from `office` into `blueprint` only when it can answer all of the following:
- what exact problem it solves
- who owns it
- what it is allowed to touch
- what it is forbidden to touch
- what contract it introduces or modifies
- what runtime budget it consumes
- what failure mode it creates
- why it cannot remain an office note

If these cannot be answered cleanly, the idea stays out of blueprint and out of code.

---

## Final Standard

ASC must be rebuilt so that **discipline is easier than drift**.

The goal is not merely to produce working code.
The goal is to produce a system whose boundaries are strong enough that implementation no longer decays into repeated reinvention.

This document is not a suggestion layer.
It is the structural authority for the rebuild until explicitly replaced.
