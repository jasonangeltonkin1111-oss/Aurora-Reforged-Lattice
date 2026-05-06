# ASC Types and State Plan

## Purpose

This document defines the shared type and state planning surface for the active MT5 implementation of Aurora Sentinel Scanner (ASC).

Its job is to translate the final blueprint and Stage 1 roadmap law into a concrete implementation-facing plan for:
- posture vocabularies
- shared record types
- root runtime state containers
- symbol identity and registry state
- artifact metadata structures
- the difference between state, contracts, and behavior

This file exists because ASC cannot remain coherent if each domain invents its own local truth language as code grows.

---

## Core doctrine

### Shared-language-first law
ASC implementation must begin with a shared structural language before broad runtime behavior is added.

That shared language includes:
- posture enums
- record shapes
- identity surfaces
- metadata contracts
- result/contract structs used between domains

If these are improvised locally, later stages will drift even if they look clean in isolation.

### Explicit-state law
Important runtime posture must be represented explicitly.
ASC should prefer:
- enums over loose booleans
- structured records over scattered fields
- named state groups over implicit conventions

This makes the system easier to reason about under pressure, restart, and integration.

### State-is-not-behavior law
A state plan defines:
- what information must exist
- how it is grouped
- who owns it conceptually
- how other domains may reference it

It does **not** mean the behavior that mutates that state is already implemented.
This distinction must stay clear.

### Ownership-before-convenience law
Shared state should be shaped by ownership and architectural meaning, not by which file happens to want the field first.

---

## Relationship to blueprint and roadmap

This file is subordinate to:
- `blueprint/final/`
- `blueprint/roadmap/03_STAGE_1_FOUNDATION_AND_TYPES.md`
- `blueprint/final/12_ASC_ARTIFACT_SCHEMA_AND_VERSIONING.md`
- `blueprint/final/13_ASC_MT5_MODULE_MAP.md`

Its role is to make those laws easier to implement directly inside `mt5/`.

It does **not** redefine the architecture.
It explains how the shared types/state surfaces should be shaped so implementation can obey the architecture without improvising.

---

## What this file is for

This file should help a contributor answer:
- what shared enums must exist first
- what major record families must exist first
- how the root runtime state should be partitioned
- how symbol-level state should be keyed and located
- what artifact metadata structures must already be available before full persistence work begins
- what kinds of result/contract objects should exist between domains

If implementation still has to invent these from scratch later, this file failed.

---

## Canonical type families

The MT5 surface should establish at least the following shared type families.

### 1. Posture enums
These define bounded architectural states used across multiple domains.

### 2. State records
These define structured runtime-state containers for layers, control, artifacts, HUD posture, and recovery posture.

### 3. Identity records
These define stable IDs and symbol-registry mapping surfaces.

### 4. Metadata records
These define artifact identity, lineage, continuity, coherence, freshness, and restore-trust posture.

### 5. Contract/result records
These define bounded payloads passed between domains without leaking internal state shape everywhere.

These families should live primarily in the `types/` domain and be referenced by `config/`, `core/`, `runtime/`, `control/`, `layers/`, `persistence/`, `artifacts/`, `hud/`, and `recovery/` as needed.

---

## Canonical posture vocabularies

The following posture vocabularies should be centralized and shared.

### Freshness posture
Used across layers, artifacts, HUD, and recovery.

Canonical states should include a bounded set such as:
- `fresh`
- `aging`
- `stale`
- `pending_refresh`
- `degraded`
- `unknown`

### Completeness posture
Used where the system needs to know whether a truth surface is whole enough to trust.

Canonical states should include:
- `complete`
- `partial`
- `blocked`
- `degraded`
- `invalid`

### Continuity posture
Used where last-good or continuity-backed surfaces exist.

Canonical states should include:
- `none`
- `last_good_assist`
- `continuity_backed`
- `continuity_only`
- `continuity_invalid`

### Coherence posture
Used where a surface may be coherent, mixed-cycle, or recovery-assembled.

Canonical states should include:
- `coherent`
- `mixed_cycle`
- `partial_cycle`
- `recovery_assembled`
- `unknown`

### Landing posture
Used by persistence and artifact consumers.

Canonical states should include:
- `pending`
- `temp_written`
- `promoted`
- `failed`
- `retry_scheduled`
- `abandoned`

### Restore-trust posture
Used during restart/recovery and in consumers of persisted truth.

Canonical states should include:
- `fresh_restore_safe`
- `stale_restore_visible`
- `continuity_restore_only`
- `requires_live_revalidation`
- `do_not_restore_as_current`

---

## Control posture vocabularies

The following vocabularies belong to the control/runtime spine.

### Governor mode posture
Canonical modes:
- `warmup`
- `normal`
- `focus`
- `congestion`
- `recovery`
- `degraded`

### Work-class posture
Canonical work classes should distinguish at least:
- broad scan work
- packet work
- gate/filter work
- shortlist/select work
- deep-analysis work
- persistence/write work
- HUD/render work
- recovery/repair work

### Lane ownership posture
Canonical lane-related states should support ideas such as:
- active owner
- candidate
- deferred
- forced
- forbidden in current mode

### Queue / starvation posture
Should allow runtime and telemetry to express:
- healthy
- deferred
- starved
- congestion-pressure
- forced-service-due

These should be centralized so the governor and diagnostics speak the same language.

---

## Layer posture vocabularies

The layer system needs additional shared states where architectural reuse makes sense.

### Layer 1 posture
Should support classification concepts such as:
- open
- closed
- uncertain
- unknown

It should also support reason-linked next-check posture and confirmation posture.

### Layer 2 posture
Should support packet state concepts such as:
- packet fresh/stale/degraded
- continuity-backed packet
- focused tactical eligibility
- packet completeness or blocked posture

### Layer 3 posture
Should support candidate-filter concepts such as:
- eligible
- ineligible
- pending
- blocked
- degraded
- stale

And bounded reason-code structures.

### Layer 4 posture
Should support shortlist concepts such as:
- stable
- dirty_held
- invalid
- material_shift
- pending
- degraded
- stale

And hold-window/materiality posture.

### Layer 5 posture
Should support deep-service concepts such as:
- promoted entitlement
- service-tier/rank posture
- deep fresh/stale/degraded/continuity-backed posture

These should be explicit enough that later acceptance tests can target them directly.

---

## Root runtime state plan

The root runtime state should exist as a structured container with clear subdomains rather than one giant unattributed blob.

At a high level, the runtime state should include subcontainers such as:
- runtime identity and lifecycle posture
- governor/control posture
- symbol registry
- layer state containers (1 through 5)
- artifact/publication posture
- HUD state and source posture
- recovery posture
- diagnostics/telemetry posture where needed

### Why this matters
A clear root-state plan allows:
- ownership inspection
- targeted mutation
- more lawful recovery behavior
- better testing
- less helper-sprawl around global fields

### What to avoid
Avoid a master state object that becomes a bag of unrelated fields with weak attribution.
That shape becomes difficult to reason about very quickly.

---

## Symbol identity and registry plan

The symbol registry should provide stable symbol identity surfaces for the whole scanner.

### The registry should answer
- what is the canonical key for this symbol in runtime state
- how is raw broker symbol identity preserved
- how do layers locate per-symbol state reliably
- how does suffix or display complexity avoid turning into string-chaos everywhere

### Identity concepts to preserve
At minimum, a symbol identity record should be able to express:
- raw broker symbol name
- normalized/canonical symbol identity where architecture uses it
- lookup key used in runtime state maps
- bucket/classification linkage where available later
- activity/known-state posture

### Why this matters
Without a clean registry plan:
- layers will invent their own symbol lookup logic
- state duplication becomes easier
- suffix/normalization bugs spread across domains

---

## Layer state record plan

Each layer should have a distinct record family for its owned truth.

### Layer 1 state record should support
- current market-state classification
- last checked time
- next check time
- next-check reason
- uncertainty/confirmation posture
- stale/degraded posture

### Layer 2 state record should support
- current packet fields assigned by architecture
- last built time
- packet freshness posture
- continuity posture where assigned
- tactical selected-symbol overlay eligibility where relevant

### Layer 3 state record should support
- candidate eligibility posture
- last evaluation time
- reason code / failure reason surface
- bucket assignment where assigned
- stale/degraded posture

### Layer 4 state record should support
- selected membership truth
- shortlist state posture
- hold posture
- material-shift posture
- last evaluation time
- stale/degraded posture

### Layer 5 state record should support
- deep fields assigned by architecture
- service-tier/rank posture
- last refresh time
- deep freshness posture
- continuity posture where assigned

Each of these record families should stay distinct even if they share some common posture enums.

---

## Artifact metadata plan

Before full persistence work begins, the type surface should already support a canonical metadata spine.

### Core metadata record should support
- artifact family
- artifact kind
- artifact name
- owner layer / owner system
- scope
- schema version
- build identity
- freshness posture
- completeness posture
- continuity markers
- coherence posture
- lineage/upstream refs
- landing posture
- restore trust posture

### Why this matters
Without shared metadata records, artifact builders and persistence logic will improvise incompatible shapes later.

### Keep metadata separable from payload
Artifact metadata should be attachable to many artifact kinds without forcing their payloads to look the same.

---

## Identity / ID plan

The shared type surface should also support stable identity concepts such as:
- artifact ID
- build ID
- generation ID
- dependency-set ID
- last-good source ID
- runtime session ID where useful

The point is not to multiply IDs unnecessarily.
The point is to make causal tracking, lineage, and recovery sane.

IDs should be shaped by what later recovery, validation, and auditability require, not by momentary coding convenience.

---

## Contract/result record plan

Cross-domain work should prefer bounded contract/result records rather than raw deep reach into neighbor state.

Examples of useful contract/result families:
- dirty-routing request/result
- publish request/result
- validation result
- selection result
- focus request/result
- recovery/revalidation result
- artifact landing result

### Why this matters
These structures reduce cross-domain leakage and make side effects more inspectable.

### What to avoid
Avoid functions that return only vague booleans when the architecture really needs to know:
- partial vs blocked
- stale vs fresh
- continuity-backed vs fresh
- promoted vs not entitled
- yielded vs completed

---

## HUD-related type/state plan

The HUD domain should not invent its own posture language from scratch.
It should share core vocabularies and add only the HUD-specific pieces it truly needs.

### HUD-specific state should include
- current page identity
- selected symbol identity
- focus overlay state
- source-class typing for visible fields/pages
- transition/freeze state
- retained-object bookkeeping posture where needed

### HUD source-class typing should support distinctions such as
- structural_committed
- tactical_direct
- runtime_control
- continuity_backed
- stale_structural

The exact enum names may vary, but the distinctions must survive.

---

## Recovery-related type/state plan

Recovery and restore work require explicit type/state surfaces rather than vague flags.

### Recovery-related records should include concepts such as
- restore candidate posture
- revalidation required posture
- continuity source linkage
- repair/containment state
- recovery-mode support state where relevant

### Why this matters
Restart/recovery logic is one of the easiest places for optimism to creep in unless the state language itself resists that drift.

---

## Diagnostics-related type/state plan

Diagnostics should primarily observe shared state rather than create parallel hidden truth.

Useful diagnostic record concepts may include:
- heartbeat trace record
- lane-ownership trace record
- publication trace record
- health snapshot record
- starvation/congestion event record

These should remain observation-friendly and non-authoritative.

---

## File mapping plan

The type/state plan should primarily map into files such as:
- `mt5/include/asc/types/ASC_Enums.mqh`
- `mt5/include/asc/types/ASC_Types_Runtime.mqh`
- `mt5/include/asc/types/ASC_Types_Layers.mqh`
- `mt5/include/asc/types/ASC_Types_Artifacts.mqh`
- `mt5/include/asc/types/ASC_Types_HUD.mqh`
- `mt5/include/asc/types/ASC_Types_Control.mqh`
- `mt5/include/asc/core/ASC_Core_RuntimeState.mqh`
- `mt5/include/asc/core/ASC_Core_Ids.mqh`
- `mt5/include/asc/core/ASC_Core_SymbolRegistry.mqh`

This does not mean every file must be fully implemented immediately.
It means these are the lawful homes for the shared structural language.

---

## Implementation sequencing guidance

This type/state surface should be implemented before broad runtime behavior because later domains depend on it.

The recommended order is:
1. define posture enums
2. define artifact metadata structures
3. define runtime/control/layer state records
4. define symbol identity and registry records
5. define contract/result records
6. then begin runtime/governor and layer implementation against those shared structures

This reduces reinterpretation and makes Stage 1 materially useful rather than ceremonial.

---

## What this file must prevent

This file should help prevent the following common failures.

### Vocabulary drift
Different domains invent different words for the same posture.

### Boolean soup
Important architectural state gets represented by loose scattered flags instead of explicit records/enums.

### Blob-state sprawl
The runtime state becomes a giant unattributed object with weak boundaries.

### Artifact metadata improvisation
Persistence and builders invent their own metadata shapes locally.

### Symbol-identity chaos
Layers each create their own raw symbol lookup logic.

### Contract weakness
Cross-domain flows use vague booleans or hidden side effects instead of explicit result structures.

---

## Current posture

At the current rebuild point:
- this file exists to help close Stage 0 cleanly by finishing the MT5 planning surface
- it also directly prepares Stage 1 by making the foundational language of the MT5 build surface explicit
- broad runtime implementation is still not the active focus until Stage 0 is formally closed

That distinction must remain clear.

---

## Update doctrine

Update this file when:
- the shared type/state plan changes materially
- the blueprint changes core posture/state expectations
- Stage 1 implementation reveals a real planning gap that must be fixed explicitly

Do not update it for ordinary local implementation noise.
This is a structural reference, not a scratchpad.

---

## Final standard

`ASC_TYPES_AND_STATE_PLAN.md` is correct when a contributor can read it and understand:
- what shared posture vocabularies must exist
- what major record families must exist
- how the root runtime state should be partitioned
- how symbol identity and artifact metadata should be handled
- how state stays explicit instead of dissolving into ad hoc local conventions

The standard is not that enums and structs are mentioned.
The standard is that the shared language of the scanner is now planned strongly enough that future implementation can grow without inventing its own local realities.