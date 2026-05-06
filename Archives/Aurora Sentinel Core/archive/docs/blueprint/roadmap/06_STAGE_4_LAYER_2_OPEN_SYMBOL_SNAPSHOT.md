# ASC Stage 4 — Layer 2 Open Symbol Snapshot

## Purpose

This document defines Stage 4 of the Aurora Sentinel Scanner (ASC) rebuild roadmap.

Stage 4 is the Layer 2 open-symbol snapshot stage.
Its job is to turn broad Layer 1 market-state truth into bounded current-state packet truth for the symbols that have earned snapshot service.

If Stage 3 allows ASC to answer what is open, closed, uncertain, or unknown across the universe, Stage 4 allows ASC to answer the next lawful question:

> for the symbols currently in active scope, what is the current usable packet of truth?

This stage exists because later filtering, shortlist logic, structural symbol views, and focused tactical surfaces need a real current-state packet owner rather than ad hoc direct reads scattered across the system.

---

## Stage objective

Stage 4 establishes lawful Layer 2 runtime behavior inside the governed runtime spine.

It defines and/or implements:
- admitted open-subset packet service
- Layer 2 packet state and freshness posture
- current packet fields for admitted symbols
- last-good continuity posture for Layer 2-owned fields where assigned
- focused-symbol tactical Layer 2 rights
- Layer 2 committed artifact publication
- degraded/stale posture for Layer 2 packet truth
- Layer 2 dirty-routing outputs into later eligibility surfaces without granting later-stage entitlement yet

The goal is not to decide which symbols are good.
The goal is to make current packet truth real and trustworthy for the symbols that matter now.

---

## Why Stage 4 matters

Without Stage 4, later layers are forced into one of two bad options:
- work from broad Layer 1 truth alone, which is too thin
- invent packet reads ad hoc inside filtering, HUD, or deep-analysis code, which destroys ownership boundaries

Stage 4 matters because it creates the bounded packet owner that later stages depend on.

If Stage 4 is weak:
- Layer 3 gating runs on stale or improvised packet inputs
- focus views become hidden schedulers of packet logic
- packet freshness becomes ambiguous
- last-good continuity becomes accidental instead of explicit
- persistence and HUD lose clean source boundaries

---

## Stage 4 dependency position

Stage 4 depends on:
- Stage 0 repo reset being complete
- Stage 1 shared types/state/contracts being complete enough for packet/freshness/continuity posture
- Stage 2 dispatcher/governor spine being real enough to lawfully admit Layer 2 work
- Stage 3 Layer 1 market-state truth being trustworthy enough to define the admitted active subset
- final blueprint files for Layer 2, persistence/artifact doctrine, HUD doctrine, and runtime law already being authoritative

Stage 4 is the prerequisite for:
- Stage 5 Layer 3 candidate filtering
- structural symbol-level packet surfaces later in HUD
- lawful focused-symbol tactical packet behavior later in HUD
- packet-backed later shortlist and deep-analysis stages

---

## Stage 4 scope

Stage 4 includes:
- implementing executable Layer 2 packet state for admitted symbols
- implementing open-subset packet acquisition/refresh behavior
- implementing packet freshness posture and aging/stale/degraded state
- implementing packet continuity/last-good posture where assigned
- implementing bounded focused-symbol tactical Layer 2 reads
- implementing Layer 2 committed artifact publication
- implementing Layer 2 dirty-routing outputs for later filtering eligibility
- implementing lawful distinction between structural packet truth and tactical direct packet reads

Stage 4 does **not** include:
- Layer 3 filtering logic
- shortlist logic
- deep-analysis logic
- broad deep history enrichment
- rich dossier generation
- full structural HUD pages beyond future admissibility

---

## Stage 4 deliverables

Stage 4 should deliver the following outcomes.

### 1. Layer 2 packet state becomes real
The active MT5 surface must now have real Layer 2 runtime records/state capable of tracking:
- admitted packet fields for symbols in scope
- packet freshness posture
- last built time
- stale/degraded posture
- continuity/last-good posture where assigned
- focused tactical eligibility for the selected symbol where relevant

### 2. Open-subset packet service exists
The runtime must be able to lawfully service the active admitted subset rather than re-reading the whole universe as though Layer 2 were just a richer Layer 1.

### 3. Packet ownership becomes executable
Layer 2 must become the clear owner of the current-state packet fields assigned by architecture, such as:
- bid
- ask
- spread
- point
- digits
- day high/day low or day-range posture where assigned
- static tradability packet fields where assigned

### 4. Focused tactical Layer 2 rights exist
The selected symbol must be able to receive bounded tactical packet refresh rights without turning Layer 2 into a hidden full-scope fast loop.

### 5. Layer 2 committed artifact block lands
Layer 2 packet truth must become lawfully committable so later structural consumers do not depend on provisional packet state.

---

## Core implementation targets

Stage 4 will primarily engage:
- `mt5/include/asc/layers/ASC_Layer2_OpenSymbolSnapshot.mqh`
- `mt5/include/asc/layers/ASC_Layers_PublicationBridge.mqh`
- `mt5/include/asc/core/ASC_Core_RuntimeState.mqh`
- `mt5/include/asc/runtime/ASC_Runtime_DirtyRouting.mqh`
- `mt5/include/asc/control/ASC_Control_Governor.mqh`
- supporting artifact/persistence scaffolding only as much as lawful Layer 2 landing requires
- later HUD tactical use only through approved source typing, not full page implementation yet

Layer 2 ownership must stay visible and bounded.

---

## Admission doctrine in Stage 4

### Layer 2 depends on Layer 1 truth
Stage 4 must make it real that Layer 2 is not a universe-first surface.
It is admitted based on earlier Layer 1 market-state truth.

### Default admitted subset
The default active Layer 2 subset should be:
- symbols currently classified as open

Additional bounded admission cases may exist later, such as:
- recently transitioned symbols needing continuity repair
- the currently selected symbol for tactical purposes
- recovery-bound repair cases

But these must remain explicit and bounded.

### Admission is not entitlement to full-scope speed
The presence of many open symbols does not grant Layer 2 a universal fast loop.
Layer 2 remains a subset-driven packet service.

---

## Packet doctrine in Stage 4

### Packet-first, not rich-first
Stage 4 should implement the smallest complete current-state packet that later cheap filtering and structural symbol consumption need.
It should avoid pulling in fields that belong naturally to later deep-analysis stages.

### Packet truth must remain current-state oriented
The packet should emphasize current usable state rather than broad historical richness.
If Stage 4 becomes history-heavy, it has already drifted.

### Packet completeness must be honest
A symbol packet may be:
- fresh and complete enough for later filtering
- partially filled but still pending completion
- stale or degraded
- continuity-backed

The packet must not pretend to be complete when it is not.

---

## Freshness doctrine in Stage 4

### Packet freshness must become real now
Stage 4 must create actual Layer 2 freshness posture rather than leaving packet age implicit.
The runtime should be able to answer:
- when the packet was last built
- whether it is fresh enough for its role
- whether the packet is stale, degraded, or continuity-backed

### Not all packet fields move equally
Stage 4 may support the concept that some packet fields are:
- fast-moving current fields
- calmer static fields
- repair/rebuild-required fields after transitions

But this remains Layer 2 ownership.
Later stages and consumer surfaces must not become the source of packet reconstruction because of it.

### Freshness must stay inspectable
Packet freshness is not just for debugging.
It is structural truth needed by later filtering and operator interpretation.

---

## Continuity doctrine in Stage 4

### Why continuity matters
Packet truth can temporarily weaken because of:
- scheduling gaps
- restart/recovery
- transient data issues
- bounded service pressure

Stage 4 should make continuity/last-good posture explicit where assigned.

### Continuity must remain honest
A continuity-backed packet is not a fresh packet.
Stage 4 must not allow continuity to masquerade as newly refreshed packet truth.

### Controlled continuity only
Continuity should apply only to fields and cases the architecture explicitly allows.
It should not become a blanket excuse to preserve stale packet state everywhere.

---

## Focus doctrine in Stage 4

### Focused-symbol tactical rights start here
Stage 4 is where lawful focused-symbol tactical packet behavior should begin to become real.

### Tactical Layer 2 rights may include
- selected-symbol bid/ask refresh
- selected-symbol spread refresh
- selected-symbol explicitly assigned tactical packet fields

### Focus must remain narrow
Stage 4 must make it structurally impossible for focus to mean:
- refresh all open symbols at focused cadence
- rerun filtering because a symbol page is visible
- trigger shortlist or deep-analysis work
- trigger write-at-display-speed publication

### Structural vs tactical split must be preserved
Stage 4 should already make a clean distinction between:
- structural committed packet truth
- tactical direct packet reads for the selected symbol

These will matter later in HUD implementation.

---

## Scheduling doctrine in Stage 4

### Subset-first scheduling
Layer 2 should now schedule the admitted active subset rather than trying to distribute packet service across the whole broker universe.

### Open symbols deserve more active service than inactive symbols
If a symbol leaves active market-state scope, Stage 4 should allow packet service posture to relax, even if continuity support remains visible.

### Tactical focus is an overlay, not a second scheduler
Focus may elevate one symbol’s tactical packet service.
It must not flatten all of Layer 2 into the same cadence.

### Repair service should remain bounded
Stage 4 may support bounded packet repair for:
- stale packets
- recently transitioned symbols
- restart/recovery continuity repair

But this must remain explicit and limited.

---

## Layer 2 artifact/publication doctrine in Stage 4

### Layer 2 must land committed packet truth
Stage 4 should produce the second real layer-owned artifact block of the rebuild.

### Minimum Layer 2 artifact content
At minimum, the Layer 2 structural block should support:
- current packet fields assigned by architecture
- packet freshness posture
- last built time
- stale/degraded posture
- continuity/last-good markers where applicable

### Publication must remain lawful
The stage does not need the full richness of later persistence family support, but it does need lawful Layer 2 publication discipline so later stages can consume packet truth structurally.

### Layer 2 must not publish at tactical speed
Focused packet movement must not drag publication cadence into same-speed writes.
Stage 4 should preserve calm structural packet landing.

---

## Dirty-routing doctrine in Stage 4

### Layer 2 creates later eligibility
When Layer 2 commits materially changed packet truth, it may make later stages eligible.
Typical future effects include:
- Layer 3 re-evaluation eligibility for affected symbols
- structural symbol packet consumers needing refresh later
- packet-based later-layer prerequisites becoming satisfied

### Stage 4 must not auto-run later layers
Stage 4 must be especially careful not to smuggle Layer 3 behavior into Layer 2 packet success paths.
The rule remains:
Layer 2 completion creates eligibility, not pile-on execution.

---

## Interaction with Stage 2 governor

### Layer 2 lives under the governor
Stage 4 must not let packet refresh self-schedule just because current values seem operationally useful.
All Layer 2 service must remain governor-admitted.

### Tactical rights still respect credits
Even focused-symbol tactical service must remain bounded by governor posture and yield rules.

### Packet service must remain class-aware
The governor must still be able to distinguish packet work from:
- broad Layer 1 scanning
- later filtering work
- persistence landing
- render work

If Stage 4 collapses those distinctions, it failed.

---

## Evidence of success in Stage 4

A healthy Stage 4 should allow the system to demonstrate things like:
- admitted open symbols now have real current-state packet truth
- packet freshness is inspectable per symbol
- focused selected-symbol tactical packet fields can move without widening whole-scope service
- continuity-backed packet posture is distinguishable from fresh packet posture
- committed Layer 2 truth can be consumed later without ad hoc packet reconstruction

These are better signs of success than simply seeing more numbers on screen.

---

## What Stage 4 must not do

### 1. No Layer 3 smuggling
Do not implement candidate gating inside packet logic just because the fields are available.

### 2. No shortlist or rank creep
Do not let Stage 4 attach candidate worthiness or selection semantics to the packet.

### 3. No deep-history drift
Do not let packet service widen into rich historical or deep analytical fields that belong later.

### 4. No focus takeover
Do not let focused-symbol handling become the dominant runtime scheduler for packet behavior.

### 5. No same-speed structural writes
Do not let tactical packet movement force the persistence cadence upward.

### 6. No whole-universe packet loop
Do not treat Layer 2 as a second Layer 1 with richer fields.

---

## Stage 4 implementation approach

The preferred progression inside Stage 4 is:

1. implement executable Layer 2 packet state records and transitions
2. implement admitted open-subset packet service under lawful governor ownership
3. implement packet freshness posture and last-built tracking
4. implement continuity/last-good posture where assigned
5. implement bounded focused-symbol tactical packet rights
6. implement Layer 2 publication bridge and committed artifact block
7. verify dirty-routing outputs without Layer 3 self-admission

### Why this order matters
Packet state comes first.
Subset packet service makes it live.
Freshness and continuity make it trustworthy.
Tactical rights make it operationally useful.
Publication makes it consumable.

---

## Stage 4 quality gates

Stage 4 is complete only when all of the following are true:

### Gate 1 — Layer 2 packet truth exists as runtime reality
The scanner can actually build and hold lawful packet truth for admitted symbols.

### Gate 2 — Open-subset packet service is real
Layer 2 behaves as an admitted subset service rather than a disguised universe refresh surface.

### Gate 3 — Packet freshness is explicit
Fresh/stale/degraded packet posture is inspectable rather than implicit.

### Gate 4 — Continuity posture is honest
Where last-good support exists, it is explicit and distinguishable from fresh packet truth.

### Gate 5 — Focused tactical rights are bounded
Selected-symbol tactical packet behavior exists without granting broad runtime authority.

### Gate 6 — Layer 2 committed truth lands lawfully
Layer 2 outputs can be committed without forcing future consumers to read provisional packet state.

### Gate 7 — No later-layer drift exists
Layer 2 has not absorbed filtering, selection, or deep-analysis roles.

---

## Evidence required for Stage 4 completion

Stage 4 completion should be evidenced by:
- real executable Layer 2 packet state and service logic
- lawful admitted-subset packet refresh behavior
- packet freshness and continuity posture
- bounded focused-symbol tactical behavior
- Layer 2 committed publication surface
- office tracking showing Stage 4 completion honestly
- later stages being able to consume real packet truth rather than improvising direct reads

Seeing packet values somewhere is not enough.
The evidence must show bounded owned Layer 2 packet truth.

---

## What Stage 4 makes newly admissible

Once Stage 4 is complete, the following become admissible:
- Stage 5 Layer 3 candidate filtering against real packet truth
- structural symbol packet views later consuming committed Layer 2 truth
- lawful focused-symbol tactical packet surfaces in later HUD stages

What does **not** become automatically admissible:
- shortlist or deep-analysis behavior before their own stages
- turning packet fields into hidden ranking semantics
- relying on focus as proof that broad packet logic is solved

---

## Common failure patterns Stage 4 must prevent

### Pattern 1 — Packet truth exists only as ad hoc reads
The system shows current values but does not have a real Layer 2 owned packet surface.

Result:
- later consumers must improvise their own reads
- ownership collapses

### Pattern 2 — Layer 2 widens too far
Layer 2 starts servicing too much of the universe or accumulating too much richness.

Result:
- subset advantage is lost
- runtime pressure rises
- boundary drift begins

### Pattern 3 — Focus becomes scheduler
Selected-symbol tactical views start controlling packet cadence broadly.

Result:
- page-dependent runtime
- unstable causality

### Pattern 4 — Continuity fraud
Last-good packet support is shown without clear posture, making stale packet state look current.

Result:
- trust erosion
- filtering and operators misread freshness

### Pattern 5 — Tactical writes contaminate structural landing
Fast tactical packet movement drags Layer 2 structural publication into same-speed behavior.

Result:
- write pressure rises
- calm publication is lost

---

## Stage 4 invalid completions

Stage 4 is **not** complete if any of the following are true:
- Layer 2 packet truth is still mostly ad hoc rather than owned
- open-subset admission is unclear or weak
- packet freshness is implicit rather than explicit
- focused tactical packet rights widen into broader runtime authority
- committed Layer 2 truth does not land lawfully
- continuity support is ambiguous with fresh truth
- Layer 2 has already absorbed filtering or selection semantics
- later stages would still need to improvise packet truth to proceed

---

## Relationship to later stages

Stage 4 does not deliver candidate filtering or shortlist truth yet.
It delivers the current-state packet layer that those later stages depend on.

That means later stages should rely on Stage 4 for:
- real admitted packet truth
- freshness/continuity posture
- focused tactical packet rights within architectural limits
- committed Layer 2 structural outputs

If later stages still have to invent their own packet reads, Stage 4 was incomplete.

---

## Final standard

Stage 4 is correct when ASC can truthfully answer the next scanner question inside the governed runtime:

> for the symbols currently in active scope, what is the current usable packet of truth?

That means Stage 4 must leave ASC with:
- real Layer 2 executable packet truth
- lawful open-subset packet service
- explicit packet freshness and continuity posture
- bounded focused-symbol tactical packet rights
- lawful committed Layer 2 publication
- no filtering, selection, or deep-analysis drift

The standard is not that Layer 2 shows prices.
The standard is that Layer 2 now owns trustworthy current packet truth strongly enough that the rest of the scanner can start depending on it.