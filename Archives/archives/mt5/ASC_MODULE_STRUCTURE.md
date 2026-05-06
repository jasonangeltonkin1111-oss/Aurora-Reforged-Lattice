# ASC MT5 Module Structure

## Purpose

This document translates the final ASC architecture into the concrete MT5 code-tree structure that implementation will follow.

Its job is to make the `mt5/` surface immediately understandable to a future contributor or codegen pass:
- what top-level domains exist
- what each domain owns
- what each domain must not own
- how dependencies should flow
- how the tree stays clean as implementation grows

This file is an implementation-facing bridge.
It does not replace the final blueprint.
It makes the blueprint easier to build directly.

---

## Core doctrine

### Structure-must-express-ownership law
The MT5 tree must make ownership visible.
If someone cannot tell roughly what a file owns from where it lives and how it is named, the structure is already drifting.

### One-domain-one-role law
Each major MT5 domain should have one dominant purpose.
If a domain becomes a dumping ground for unrelated work, its meaning is gone.

### Lower-before-higher law
The tree must reflect the fact that ASC builds upward:
- shared types and state first
- runtime/governor control next
- layers on top of that
- artifact/persistence and HUD consuming lawful truth after that

### Consumer-domains-stay-downstream law
HUD, persistence consumers, summaries, and tooling may consume truth.
They must not quietly become better sources of truth than the owning domains.

---

### Runtime execution model must remain visible
The MT5 tree must preserve the runtime execution model structurally, not merely mention it in prose.

That means the structure must keep visible room for:
- one major lane owning each heartbeat
- bounded sub-lane admission
- scan / write / read breathing order
- atomic write isolation
- cursor/progression state
- HUD as a downstream consumer

Future implementation must not dissolve this model by convenience through cross-domain shortcuts.

### `dev/` internal-domain law
A clean `dev/` domain may exist for internal technical components only.
A canonical example shape is:

```text
include/
  asc/
    dev/
      scheduling/
      persistence/
      coordination/
      utilities/
```

These are example internal domains, not permission to grow `dev/` without ownership.

Rules:
- `dev/` is strictly internal
- `dev/` is not user-facing
- `dev/` must not leak into product naming
- `dev/` must remain structured, bounded, and meaning-based
- `dev/` must not become a dumping ground for unowned logic
- `dev/` must not contain summary files
- `dev/` must not contain dossier files
- `dev/` must not contain HUD output
- `dev/` must not contain other user-facing artifacts
- clear ownership must be maintained inside `dev/`

If a technical component has a clear permanent owner in another named domain, prefer that named domain over casual `dev/` growth.

---

## Canonical MT5 tree

The intended tree is:

```text
mt5/
  README.md
  ASC_MODULE_STRUCTURE.md
  ASC_TYPES_AND_STATE_PLAN.md
  ASC_BUILD_SEQUENCE_REFERENCE.md

  experts/
    Aurora Sentinal Core.mq5

  include/
    asc/
      core/
      types/
      config/
      runtime/
      control/
      layers/
      persistence/
      artifacts/
      hud/
      diagnostics/
      recovery/
      testsupport/
      dev/

  files/
    README.md
    artifact_families/

  tests/
    README.md
    scenarios/
    harness/

  tools/
    README.md
```

This is the default implementation target.
Any major deviation should be justified explicitly, not drift in by convenience.

---

## Root-level documents

### `README.md`
Explains the purpose and operating law of the whole `mt5/` surface.

### `ASC_MODULE_STRUCTURE.md`
This file.
It explains the structural ownership map of the MT5 tree.

### `ASC_TYPES_AND_STATE_PLAN.md`
Explains the shared type/state layer that the implementation depends on before broad code growth begins.

### `ASC_BUILD_SEQUENCE_REFERENCE.md`
Explains the recommended code-build order inside the MT5 surface.

These files together make the root of `mt5/` readable before implementation volume grows.

---

## `experts/` domain

### Purpose
This domain contains the EA entrypoint and nothing more ambitious than that.

### Canonical file
- `experts/Aurora Sentinal Core.mq5`

### Owns
- MT5 event hookup
- OnInit / OnTimer / OnDeinit / OnChartEvent delegation
- runtime bootstrap bridge

### Must not own
- layer logic
- artifact generation
- HUD render logic
- selection logic
- deep logic
- hidden scheduler behavior

### Rule
If the entrypoint becomes large, the structure is drifting.

---

## `include/asc/` domain

### Purpose
This is the main code surface of ASC.
All major implementation domains live under this subtree.

### Core rule
Every subdomain here must have a meaning-based role, not a historical or convenience-based role.

---

## `types/` domain

### Purpose
Holds shared enums, structs, posture vocabularies, IDs, and cross-domain contracts.

### Canonical examples
- `ASC_Enums.mqh`
- `ASC_Types_Runtime.mqh`
- `ASC_Types_Layers.mqh`
- `ASC_Types_Artifacts.mqh`
- `ASC_Types_HUD.mqh`
- `ASC_Types_Control.mqh`

### Owns
- freshness/degraded/coherence/continuity vocabularies
- layer and control posture enums
- artifact metadata records
- shared state record shapes
- interface/result contract types

### Must not own
- runtime behavior
- file I/O
- HUD drawing
- business logic

### Dependency posture
This is one of the lowest domains.
Most other domains may depend on it.
It should depend on almost nothing.

---

## `config/` domain

### Purpose
Holds centralized defaults, thresholds, cadence constants, and explicit configurable posture.

### Canonical examples
- `ASC_Config_Defaults.mqh`
- `ASC_Config_Inputs.mqh`
- `ASC_Config_Thresholds.mqh`
- `ASC_Config_Cadence.mqh`
- `ASC_Config_Artifacts.mqh`

### Owns
- tunable constants
- threshold surfaces
- cadence defaults
- artifact-family policy defaults

### Must not own
- dynamic runtime state
- hidden behavioral logic
- cross-domain glue

### Dependency posture
Most domains may read config.
Config should not depend upward into runtime or layers.

---

## `core/` domain

### Purpose
Holds foundational runtime scaffolding that is not owned by one layer alone.

### Canonical examples
- `ASC_Core_Bootstrap.mqh`
- `ASC_Core_RuntimeState.mqh`
- `ASC_Core_SymbolRegistry.mqh`
- `ASC_Core_Time.mqh`
- `ASC_Core_Ids.mqh`
- `ASC_Core_Guards.mqh`

### Owns
- bootstrap scaffolding
- root runtime state container posture
- symbol registry identity posture
- ID helpers
- invariant/guard helpers
- canonical time helpers

### Must not own
- layer truth
- governor decisions
- artifact-family landing
- HUD rendering

### Dependency posture
Lower than runtime/control/layers.
Should remain foundational and relatively calm.

---

## `runtime/` domain

### Purpose
Holds the runtime manager and lifecycle orchestration that bridges the EA entrypoint into the governed scanner runtime.

### Canonical examples
- `ASC_Runtime_Manager.mqh`
- `ASC_Runtime_Boot.mqh`
- `ASC_Runtime_Shutdown.mqh`
- `ASC_Runtime_ModeBridge.mqh`
- `ASC_Runtime_DirtyRouting.mqh`

### Owns
- runtime lifecycle stages
- bridge between entrypoint and governor
- dirty-routing intake/registry
- high-level orchestration

### Must not own
- detailed layer logic
- full persistence logic
- HUD rendering
- mode policy by convenience outside control-domain law

### Dependency posture
May depend on lower foundational domains and coordinate with control/layers/persistence.
It should orchestrate, not absorb everything.

---

## `control/` domain

### Purpose
Holds the governor, lane ownership, credits, starvation logic, congestion posture, and heartbeat telemetry.

### Canonical examples
- `ASC_Control_Governor.mqh`
- `ASC_Control_Modes.mqh`
- `ASC_Control_Lanes.mqh`
- `ASC_Control_Credits.mqh`
- `ASC_Control_Starvation.mqh`
- `ASC_Control_Queues.mqh`
- `ASC_Control_HeartbeatTelemetry.mqh`

### Owns
- major-lane admission
- mode transitions
- credit posture
- forced-service posture
- starvation/congestion posture
- heartbeat observability

### Must not own
- layer truth generation
- artifact building
- UI behavior

### Dependency posture
May query lower and sibling domains through bounded surfaces.
Must not become a shadow owner of layer meaning.

---

## `layers/` domain

### Purpose
Holds the five truth layers and their publication bridge.

### Canonical examples
- `ASC_Layers_Registry.mqh`
- `ASC_Layer1_MarketState.mqh`
- `ASC_Layer2_OpenSymbolSnapshot.mqh`
- `ASC_Layer3_CandidateFiltering.mqh`
- `ASC_Layer4_ShortlistSelection.mqh`
- `ASC_Layer5_DeepSelectiveAnalysis.mqh`
- `ASC_Layers_PublicationBridge.mqh`

### Owns
- layer-specific truth generation
- layer-specific state transitions
- layer freshness/degraded posture
- handoff of owned truth toward publication

### Must not own
- global governor policy
- final persistence landing mechanics
- HUD rendering policy
- later-layer role creep backward into earlier truth ownership

### Dependency posture
Layer N may consume earlier lawful truth.
Layer N must not depend on later layers.

---

## `persistence/` domain

### Purpose
Holds the artifact landing system and continuity/restore logic around landed truth.

### Canonical examples
- `ASC_Persistence_Manager.mqh`
- `ASC_Persistence_Atomic.mqh`
- `ASC_Persistence_Families.mqh`
- `ASC_Persistence_LastGood.mqh`
- `ASC_Persistence_Lineage.mqh`
- `ASC_Persistence_Restore.mqh`
- `ASC_Persistence_PublishThresholds.mqh`

### Owns
- atomic landing
- family-aware landing rules
- last-good support
- lineage/landing state tracking
- restore posture helpers
- publish-threshold enforcement

### Must not own
- upstream truth invention
- UI meaning
- selection logic

### Dependency posture
Consumes owned payloads from layers/control/HUD support builders where lawful.
Must never become a shadow truth engine.

---

## `artifacts/` domain

### Purpose
Holds schema helpers, metadata assembly, serialization, validation, and artifact builders.

### Canonical examples
- `ASC_Artifacts_Schema.mqh`
- `ASC_Artifacts_Metadata.mqh`
- `ASC_Artifacts_Serialize.mqh`
- `ASC_Artifacts_Validate.mqh`
- `ASC_Artifacts_Builders_Layers.mqh`
- `ASC_Artifacts_Builders_Runtime.mqh`
- `ASC_Artifacts_Builders_HUD.mqh`

### Owns
- payload construction from owned truth
- metadata-spine attachment
- artifact validation logic
- family-aware serialization

### Must not own
- truth generation itself
- landing mechanics
- runtime scheduling

### Dependency posture
Below persistence in the sense that it builds artifacts and persistence lands them.

---

## `hud/` domain

### Purpose
Holds operator-surface logic, source selection, focus overlays, transitions, layout, and retained-object rendering.

### Canonical examples
- `ASC_HUD_Manager.mqh`
- `ASC_HUD_Pages.mqh`
- `ASC_HUD_Render.mqh`
- `ASC_HUD_Layout.mqh`
- `ASC_HUD_Focus.mqh`
- `ASC_HUD_Transitions.mqh`
- `ASC_HUD_Sources.mqh`

### Owns
- page model
- source-aware hydration
- structural/tactical visual separation
- focus overlay behavior
- transition/freeze logic
- render discipline

### Must not own
- hidden scheduler behavior
- layer truth generation
- artifact trust decisions beyond lawful source interpretation

### Dependency posture
Consumes lawful structural truth and bounded tactical sources.
Must remain downstream.

---

## `diagnostics/` domain

### Purpose
Holds instrumentation, counters, assertion helpers, and bounded health inspection surfaces.

### Canonical examples
- `ASC_Diagnostics_Events.mqh`
- `ASC_Diagnostics_Counters.mqh`
- `ASC_Diagnostics_Assertions.mqh`
- `ASC_Diagnostics_Dumps.mqh`
- `ASC_Diagnostics_Health.mqh`

### Owns
- traces
- counters
- invariant checks
- health snapshots

### Must not own
- production truth meaning
- production scheduling authority
- production artifact authority

### Dependency posture
May read broadly.
Production domains must not depend on diagnostics to function correctly.

---

## `recovery/` domain

### Purpose
Holds explicit restart/revalidation/repair helpers used to restore lawful runtime posture after interruption.

### Canonical examples
- `ASC_Recovery_Manager.mqh`
- `ASC_Recovery_Restore.mqh`
- `ASC_Recovery_Revalidate.mqh`
- `ASC_Recovery_Repair.mqh`

### Owns
- family-aware restore orchestration
- revalidation bridges
- bounded repair coordination

### Must not own
- permanent runtime policy
- quiet truth invention
- operator-surface authority

### Dependency posture
May depend on control/persistence/layers through bounded interfaces.
Must remain explicitly recovery-shaped, not become default runtime glue.

---

## `testsupport/` domain

### Purpose
Holds test scaffolding that helps scenario/harness work without contaminating production logic.

### Canonical examples
- `ASC_TestSupport_Fakes.mqh`
- `ASC_TestSupport_Scenarios.mqh`
- `ASC_TestSupport_SeedData.mqh`

### Owns
- fake inputs
- deterministic scenario helpers
- bridge utilities for harness/testing

### Must not own
- production runtime truth
- production control logic
- production artifact policy

### Dependency posture
May depend on many lower domains for testing.
Production code must not depend back on testsupport.

---

## `files/` domain

### Purpose
Documents the runtime artifact roots and family layout used by ASC.

### Owns
- file-root documentation
- artifact-family documentation
- example structural file layouts where needed

### Must not own
- runtime logic
- truth computation
- UI behavior

This domain exists to make persisted shape intentional rather than accidental.

---

## `tests/` domain

### Purpose
Holds MT5-facing tests, scenarios, and harness assets.

### Owns
- scenario definitions
- harness runners
- test readmes and acceptance helpers

### Must not own
- production runtime logic
- architecture law

This domain supports validation; it does not replace blueprint or runtime domains.

---

## `tools/` domain

### Purpose
Holds repo-local helpers that support packaging, inspection, or implementation convenience.

### Owns
- local utility scripts/helpers
- packaging helpers
- lint-like or structure-check helpers where needed

### Must not own
- scanner truth generation
- runtime authority
- architecture law

This domain must stay subordinate and optional.

---

## `dev/` domain

### Purpose
Holds tightly scoped internal technical helpers that support implementation domains without becoming product-facing structure.

### Typical examples
- scheduler support helpers
- persistence support helpers
- runtime coordination helpers
- narrow technical utilities that do not deserve their own permanent product-facing domain

### Must not own
- operator-facing surfaces
- product-language structures
- scanner truth ownership that belongs in `layers/`
- governor authority that belongs in `control/`
- artifact landing authority that belongs in `persistence/`
- product-facing files of any kind

### Dependency posture
This domain is subordinate and internal.
Use it carefully.
It exists to keep technical implementation domains clean, not to become a convenience sink.

---

## Dependency direction summary

The high-level dependency direction should remain:

```text
types / config / core
    -> runtime / control / layers
    -> artifacts / persistence / hud / recovery
    -> diagnostics / testsupport / tests / tools
```

More precise rules:
- lower domains may be depended on broadly
- higher consumer domains must not quietly backflow ownership downward
- later layers must not redefine earlier layers
- HUD and persistence must not become hidden truth owners
- diagnostics/testsupport must not become required production infrastructure

---

## Forbidden structural patterns

The MT5 tree must help prevent these patterns.

### Entry-file obesity
The EA entrypoint becomes the real runtime brain.

### Helper-sprawl
Unowned helper files become the real architecture center.

### Cross-domain convenience reach
Domains directly mutate or reinterpret one another instead of using bounded interfaces.

### Archive inheritance
Old folder names and structures return because they feel familiar.

### Layer inversion
Later layers rebuild earlier truth instead of consuming it.

### Consumer authority creep
HUD or persistence begin deciding what truth should be, not merely presenting or landing it.

---

## Implementation posture right now

At the current rebuild point:
- the MT5 tree is still in planning-surface establishment
- this file exists to stop structure drift before runtime code begins in earnest
- Stage 0 remains active until the MT5 planning file set is complete

That means this document is part of closing the repo-reset phase properly, not a sign that Stage 1 implementation is already complete.

---

## Update doctrine

Update this file when:
- the domain structure changes materially
- a domain’s ownership role changes by explicit blueprint decision
- the implementation surface gains or loses a top-level MT5 domain
- Stage 0 closes and the planning surface transitions into active code growth with any structural clarifications required

Do not update this file for ordinary local coding changes.
This is a structure reference, not a running log.

---

## Final standard

`ASC_MODULE_STRUCTURE.md` is correct when a contributor can read it and immediately understand:
- what domains exist in the MT5 tree
- what each domain owns
- what each domain must never quietly absorb
- how dependencies should flow
- how the code tree protects the architecture rather than dissolving it

The standard is not that folders are listed.
The standard is that the structure now gives future implementation a clear lawful shape strong enough to resist sprawl and drift.