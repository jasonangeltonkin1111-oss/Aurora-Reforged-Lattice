# ASC MT5 Build Sequence Reference

## Purpose

This document defines the canonical MT5-side build order for Aurora Sentinel Core (ASC).

Its job is to translate the roadmap into a code-surface sequence that a contributor or codegen pass can follow directly inside `mt5/`.

This file answers:
- what gets built first inside the MT5 tree
- what depends on what
- what must not be started early
- what evidence makes a phase ready to hand off to the next one

This is an implementation-facing reference.
It does not replace the roadmap.
It makes the roadmap executable in the MT5 surface.

---

## Core doctrine

### Build-order-protects-architecture law
The MT5 build order is not a convenience preference.
It is one of the main ways ASC prevents code from silently rewriting the blueprint.

If the code tree is built in the wrong order, the most likely outcomes are:
- local helper sprawl
- hidden truth invention
- UI-first pressure
- weak persistence posture
- patch-loop convenience drift

### Lower-before-higher law
Inside `mt5/`, lower structural surfaces should exist before richer behavioral or consumer surfaces grow on top of them.

That means the default logic remains:
- types before behavior
- control before layers
- lower layers before higher layers
- artifacts/persistence before structural HUD
- hardening after the integrated shape is real

### Honest-incomplete law
A phase may stop with bounded incompleteness if:
- ownership remains clear
- the next phase is not yet admissible
- the current outputs are honest about being partial

A phase should not widen just to look fuller.

### No-feature-jump law
A feature that looks exciting is still blocked if its upstream shape is not ready.
This file exists specifically to make those boundaries harder to violate.

---

## Relationship to other files

This file is subordinate to:
- `blueprint/final/`
- `blueprint/roadmap/`
- `mt5/ASC_MODULE_STRUCTURE.md`
- `mt5/ASC_TYPES_AND_STATE_PLAN.md`
- `office/ROADMAP_STATUS.md`

Its role is to answer:

> given the architecture and roadmap, what is the lawful code-build sequence inside the active MT5 surface?

It is a bridge document, not a second roadmap.

---

## Runtime Execution Model — Heartbeat & Lane System (MANDATORY)

This runtime model must be read before implementing Phase 3 governor/control work or widening any later runtime behavior.

It is hard law for the MT5 build surface.
Future chats must not invent their own execution model.

### Mandatory runtime posture
- one major lane per heartbeat
- at most one bounded sub-lane
- scan -> write -> read breathing rhythm
- atomic write windows using temp -> validate -> promote -> last-known-good fallback
- bounded work budgets per beat
- cursor-based continuation rather than restart-from-front loops
- HUD consuming prepared state only
- no heavy concurrency across scan, write, and display domains

### Build-sequence consequence
A phase is not lawful merely because its own code compiles.
It is lawful only if it fits inside this runtime model without redefining heartbeat behavior.

---

## Current posture

At the current rebuild point:
- the MT5 planning surface is already landed
- the thin EA entrypoint and runtime manager spine are active
- shared types, publication proof, and Layer 1 proof are now present
- deeper Stage 2 governor work remains the next bounded build target

That distinction matters.
The presence of the sequence reference is not itself evidence that later phases have begun.

---

## Build sequence overview

The MT5 build sequence should follow this high-level order:

1. MT5 planning surface completion
2. foundational shared language (`types/`, `config/`, `core/`)
3. thin entrypoint + runtime manager spine
4. governor/control spine
5. Layer 1 market-state truth
6. Layer 2 open-symbol packet truth
7. Layer 3 candidate filtering
8. Layer 4 shortlist selection
9. Layer 5 deep promoted analysis
10. artifact builders and persistence landing
11. structural HUD and bounded tactical overlays
12. recovery/diagnostics/testsupport hardening
13. end-to-end validation and acceptance-oriented tightening

This order is derived from truth ownership and dependency law, not from convenience.

---

## Phase 0 — MT5 planning surface completion

### Purpose
Finish the MT5 root reference files so the code surface is structurally clear before broad implementation begins.

### Files in scope
- `mt5/README.md`
- `mt5/ASC_MODULE_STRUCTURE.md`
- `mt5/ASC_TYPES_AND_STATE_PLAN.md`
- `mt5/ASC_BUILD_SEQUENCE_REFERENCE.md`

### Why first
Without these, code can still drift into:
- ad hoc folder placement
- vague state planning
- hidden module-boundary assumptions
- premature stage activation

### Completion signal
Phase 0 is complete when the MT5 root planning surface is materially present and Stage 0 close conditions can be satisfied alongside the remaining office truth.

### Forbidden widening
- no broad runtime code under the banner of “just getting started”
- no archive-like tree recreation
- no opportunistic helper files outside declared domains

---

## Phase 1 — Foundational shared language

### Purpose
Create the shared type/state/config/core language that later code depends on.

### Domains in scope
- `include/asc/types/`
- `include/asc/config/`
- `include/asc/core/`

### Typical targets
- posture enums
- layer/control/artifact/HUD type records
- artifact metadata structures
- symbol identity and registry records
- root runtime state containers
- ID helpers
- threshold/cadence/config surfaces

### Why this phase must come first
If layers or HUD code begins before the shared language exists, each domain starts inventing its own state and vocabulary.

### Completion signal
Phase 1 is complete when:
- posture vocabularies are centralized
- root state partitions are defined
- symbol identity/registry plan has lawful code homes
- artifact metadata shapes exist centrally
- later phases can code against shared structures without reinterpretation

### Forbidden widening
- no real Layer 1 scanning yet
- no governor logic hidden inside core/types
- no persistence behavior hidden inside metadata types

---

## Phase 2 — Entrypoint and runtime manager spine

### Purpose
Create the thin EA bridge and the runtime manager handshake into the governed system.

### Domains in scope
- `experts/`
- `include/asc/runtime/`
- small support from `core/`

### Typical targets
- `Aurora Sentinal Core.mq5`
- runtime bootstrap/shutdown bridge
- runtime manager entry surfaces
- bounded event delegation posture
- dirty-routing intake scaffolding

### Why before governor detail
The code needs one lawful place to enter the runtime before the control spine becomes richer.

### Completion signal
Phase 2 is complete when:
- entrypoint is thin and delegating
- one runtime-manager path exists
- there is no competing scheduler root

### Forbidden widening
- no layer logic in the entrypoint
- no HUD behavior as scheduler substitute
- no broad runtime behavior hidden in bootstrap glue

---

## Phase 3 — Governor/control spine

### Purpose
Make lawful heartbeat ownership, lane isolation, breathing-cycle rhythm, credits, and starvation/congestion behavior real.

### Domains in scope
- `include/asc/control/`
- `include/asc/runtime/`

### Typical targets
- major-lane ownership
- bounded sub-lane admission
- class-aware credits
- mode transitions
- dirty-routing as eligibility only
- forced-service posture
- starvation/congestion detection
- heartbeat telemetry
- cursor/progression state
- write-lane isolation posture

### Why before truth layers
Without the governor spine, layers will self-schedule or opportunistically widen pulses.

### Completion signal
Phase 3 is complete when:
- one-major-lane-per-heartbeat is structurally real
- bounded sub-lane admission is explicit
- dirty work does not self-admit
- credits and modes materially affect runtime behavior
- starvation/congestion posture is inspectable
- heartbeat rhythm preserves scan -> write -> read breathing rather than mixed-domain burst behavior

### Forbidden widening
- no real Layer 1/2/3 work hidden in control modules
- no generic budget theater replacing class-aware control

---

## Phase 4 — Layer 1 market-state truth

### Purpose
Build the first real broad truth layer of the scanner.

### Domains in scope
- `include/asc/layers/ASC_Layer1_MarketState.mqh`
- supporting publication bridge
- runtime/control integration only as needed

### Typical targets
- broad cheap scan waves
- Open / Closed / Uncertain / Unknown posture
- next-check reason/timing
- readiness posture
- bounded confirmation posture
- Layer 1 committed publication handoff

### Why first among layers
Everything else depends on broad truthful market-state posture.

### Completion signal
Phase 4 is complete when:
- Layer 1 broad scan is real and cheap
- Unknown/Uncertain posture is honest
- readiness is grounded in Layer 1 truth
- Layer 1 can land committed structural truth

### Forbidden widening
- no packet enrichment
- no filtering or shortlist semantics
- no write frenzy because broad scan exists

---

## Phase 5 — Layer 2 open-symbol snapshot truth

### Purpose
Build admitted-subset current-state packet truth on top of Layer 1.

### Domains in scope
- `include/asc/layers/ASC_Layer2_OpenSymbolSnapshot.mqh`
- supporting publication bridge

### Typical targets
- open-subset packet service
- packet freshness posture
- continuity posture where assigned
- selected-symbol tactical packet rights
- Layer 2 committed publication handoff

### Why after Layer 1
Layer 2 must be admitted from lawful upstream market-state truth rather than acting like a richer Layer 1.

### Completion signal
Phase 5 is complete when:
- Layer 2 is subset-driven
- packet freshness/continuity are explicit
- selected-symbol tactical packet rights are bounded
- Layer 2 can land committed packet truth

### Forbidden widening
- no candidate filtering
- no shortlist semantics
- no universe-wide packet loop
- no same-speed structural publication

---

## Phase 6 — Layer 3 candidate filtering

### Purpose
Create the cheap explainable survivor gate.

### Domains in scope
- `include/asc/layers/ASC_Layer3_CandidateFiltering.mqh`
- supporting publication bridge

### Typical targets
- eligibility posture
- reason codes
- bucket assignment where assigned
- filter freshness posture
- Layer 3 committed publication handoff

### Why after Layer 2
Filtering should consume real packet truth, not ad hoc current-value reads.

### Completion signal
Phase 6 is complete when:
- cheap gate service is real
- reason-code posture is bounded and explainable
- bucket assignment does not become selection
- Layer 3 can land committed survivor truth

### Forbidden widening
- no shortlist behavior
- no heavy/deep inputs
- no hidden ranking engine

---

## Phase 7 — Layer 4 shortlist selection

### Purpose
Create the first real downstream privilege authority: the promoted set.

### Domains in scope
- `include/asc/layers/ASC_Layer4_ShortlistSelection.mqh`
- supporting publication bridge

### Typical targets
- selected-set membership authority
- hold posture
- Dirty-Held / Invalid / Material-Shift posture
- top-per-bucket and spill/fill where assigned
- Layer 4 committed publication handoff

### Why after Layer 3
Selection must consume explicit survivor truth rather than redefining eligibility for itself.

### Completion signal
Phase 7 is complete when:
- Layer 4 is the sole promoted-membership authority
- hold/materiality are real
- hold expiry alone does not trigger rebuild
- Layer 4 can land committed shortlist truth

### Forbidden widening
- no deep-analysis behavior
- no ranking-universe drift
- no time-driven fake causality

---

## Phase 8 — Layer 5 deep promoted analysis

### Purpose
Create deeper rolling truth for promoted symbols only.

### Domains in scope
- `include/asc/layers/ASC_Layer5_DeepSelectiveAnalysis.mqh`
- supporting publication bridge

### Typical targets
- promoted-only deep state
- rank-sensitive/service-tier cadence
- deep freshness posture
- continuity posture where assigned
- Layer 5 committed publication handoff

### Why after Layer 4
Depth becomes lawful only after selected-set scope is already constrained.

### Completion signal
Phase 8 is complete when:
- deep service stays promoted-only
- cadence varies inside scope without widening scope
- freshness/continuity are explicit
- Layer 5 can land committed deep truth

### Forbidden widening
- no non-promoted deep entitlement
- no selection-authority leak backward
- no focus-driven scope expansion

---

## Phase 9 — Artifact builders and persistence landing

### Purpose
Turn runtime truth across Layers 1–5 into durable lawful artifacts.

### Domains in scope
- `include/asc/artifacts/`
- `include/asc/persistence/`

### Typical targets
- metadata spine attachment
- artifact-family builders
- atomic landing
- lineage/coherence posture
- last-good handling
- restore-trust posture scaffolding
- publish-threshold posture

### Why after Layers 1–5
The persistence system should harden real owned truth, not act as a compensating structure for missing layers.

### Completion signal
Phase 9 is complete when:
- Layers 1–5 can land committed artifacts lawfully
- atomic landing is real
- family boundaries are explicit
- continuity and restore posture are meaningful

### Forbidden widening
- no dossier-first truth transport
- no persistence truth invention
- no write-at-display-speed behavior

---

## Phase 10 — HUD and operator surface

### Purpose
Create the lawful consumer-facing surface on top of landed truth and bounded tactical overlays.

### Domains in scope
- `include/asc/hud/`

### Typical targets
- structural pages from landed truth
- source-aware page/field typing
- tactical selected-symbol overlays
- retained-object render posture
- stale/degraded/continuity-backed signaling
- focus release and transition behavior

### Why after persistence/artifacts
The structural HUD should consume landed truth rather than becoming a hidden transport or recompute layer.
It must not redefine heartbeat ownership, trigger heavy recomputation, or collapse scan/write/read separation through interaction convenience.

### Completion signal
Phase 10 is complete when:
- structural pages hydrate from artifacts
- tactical overlays stay narrow
- source classes are inspectable
- HUD remains downstream and not a scheduler

### Forbidden widening
- no hidden runtime authority from page visibility
- no second-engine recompute in view code
- no focus entitlement bug

---

## Phase 11 — Recovery, diagnostics, and test support hardening

### Purpose
Strengthen observability, restart/revalidation posture, and validation helpers around the already-built system.

### Domains in scope
- `include/asc/recovery/`
- `include/asc/diagnostics/`
- `include/asc/testsupport/`
- `tests/`
- limited `tools/` support where useful

### Typical targets
- restore/revalidation helpers
- bounded repair flows
- heartbeat/publication/health instrumentation
- scenario helpers and harness support
- acceptance support scaffolding

### Why after main structure exists
These domains should reinforce the real system, not act as substitute infrastructure for missing primary runtime behavior.

### Completion signal
Phase 11 is complete when:
- restart/revalidation posture is explicit and testable
- diagnostics observe rather than own truth
- testsupport enables lawful scenarios without contaminating production code

### Forbidden widening
- no recovery-as-default-runtime
- no diagnostics becoming required production behavior
- no testsupport leaking into main code dependencies

---

## Phase 12 — End-to-end validation and acceptance tightening

### Purpose
Prove the integrated MT5 system remains lawful under realistic scale, restart, pressure, and operator use.

### Domains in scope
- all domains indirectly
- especially `tests/` and office/test-matrix/risk alignment

### Typical targets
- wide-universe validation
- starvation/congestion validation
- restart/recovery humility validation
- artifact trust validation
- source-truthful HUD validation
- acceptance evidence packaging

### Why last
Acceptance must test the integrated system rather than isolated slices.

### Completion signal
Phase 12 is complete when:
- hardening evidence supports full or explicitly conditional acceptance
- office, risk, and test-matrix posture align honestly
- the system survives the failure modes the rebuild was designed to resist

### Forbidden widening
- no scope expansion disguised as hardening
- no acceptance theater based on smooth presentation or vague confidence

---

## Cross-phase gating rules

A later phase should not begin just because a contributor feels ready.
The next phase becomes lawful only when the current phase has:
- real outputs
- honest partial-state visibility where needed
- no major forbidden widening
- enough structural evidence that the next phase will not need to invent missing upstream truth

If a later phase still needs to guess what an earlier phase means, the earlier phase is not done.

---

## Forbidden sequencing shortcuts

The following shortcuts are invalid.

### UI-first shortcut
Building rich pages before landed truth and source posture exist.

### Deep-first shortcut
Building promoted depth before shortlisted membership authority exists.

### Persistence-last shortcut
Treating durable artifacts as optional cleanup after everything else.

### Recovery-as-glue shortcut
Using restart/repair logic to compensate for weak normal runtime law.

### Broad-many-domain shortcut
Touching many phases weakly instead of completing one lawful slice strongly.

These shortcuts may look productive briefly, but they almost always raise rework and drift later.

---

## Completion evidence by phase

Every phase should produce evidence in one or more of these forms:
- lawful file/domain creation
- centralized type/state surfaces
- inspectable runtime behavior
- landed artifacts with real metadata
- source-aware HUD behavior
- test-matrix-aligned validation evidence
- office status that matches actual reality

The exact evidence varies by phase.
The core rule does not:
**done means evidence exists, not that code merely landed.**

---

## Current next move

At the current rebuild point, the immediate next move after this file is:
- harden the current compile surface and path truth
- keep Layer 1 bounded and honest
- begin deeper Phase 3 / Stage 2 governor work without widening into later layers

This file is therefore now a live implementation reference, not a Stage 0 planning placeholder.

---

## Update doctrine

Update this file when:
- the lawful MT5 build order changes because the blueprint/roadmap changed explicitly
- a new MT5 phase boundary becomes necessary
- a major gating rule changes materially

Do not update it for ordinary local code progress.
This is a sequence reference, not a changelog.

---

## Final standard

`ASC_BUILD_SEQUENCE_REFERENCE.md` is correct when a contributor can read it and immediately understand:
- what MT5 code phases exist
- what each phase is supposed to build
- why that phase comes before the next one
- what must not be started early
- what counts as enough evidence to move on

The standard is not that a list of phases exists.
The standard is that the code-side order is now clear enough to protect the rebuild from feature-jumping and patch-loop sequencing drift.