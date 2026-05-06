# ASC Stage 0 — Repo Reset

## Purpose

This document defines Stage 0 of the Aurora Sentinel Scanner (ASC) rebuild roadmap.

Stage 0 is the repo reset stage.
Its job is to turn the rebuild from a design decision into a controlled repository reality.

Before this stage is complete, ASC may have architecture documents and intentions.
After this stage is complete, the active repo shape, ownership surfaces, and build posture are reset into the new law.

This stage exists because a rebuild cannot remain clean if the repo itself still carries mixed authority, mixed structure, or active-path ambiguity.

---

## Stage objective

Stage 0 establishes the new active build surface and removes ambiguity about where the rebuild actually lives.

It defines:
- the active top-level repo domains
- the boundary between active surfaces and archives
- the initial blueprint/roadmap/office/mt5 structure
- the first canonical files that future work must build on
- the rule that archives are evidence only and no longer the active implementation surface

The goal is not to write runtime code yet.
The goal is to freeze the repository shape strongly enough that future implementation can proceed without inheriting old clutter by accident.

---

## Why Stage 0 matters

Without an explicit repo reset stage, the rebuild immediately faces these risks:
- old and new blueprint surfaces compete for authority
- legacy runtime folders continue to feel “almost active”
- implementation starts in the wrong place out of habit
- office/control files fail to match the new reality
- archive content gets preserved by inertia rather than scrutiny

Stage 0 prevents that.

It is the repo-level equivalent of establishing Layer 1 before Layer 5.
The structural surface must be correct before richer work begins.

---

## Stage 0 scope

Stage 0 includes:
- establishing the canonical top-level repo shape
- confirming the active blueprint split into `final/` and `roadmap/`
- establishing the active `office/` role
- establishing the active `mt5/` planning/build surface
- explicitly demoting archives to evidence/reference status
- creating the initial canonical markdown files that future stages depend on
- aligning authority language so later work cannot claim confusion about what is active

Stage 0 does **not** include:
- implementing the MT5 runtime
- building layer logic
- building the governor runtime code
- building persistence logic
- building the HUD
- solving recovery logic

Those belong to later stages.

---

## Stage 0 canonical repo target

After Stage 0, the active repo shape must be:

```text
blueprint/
  final/
  roadmap/
mt5/
office/
archives/
```

### Meaning of each surface

#### `blueprint/final/`
Holds the frozen architectural lawbook.
This is the highest active authority after the foundation file.

#### `blueprint/roadmap/`
Holds the controlled build sequence.
This is subordinate to `blueprint/final/`.

#### `mt5/`
Holds the new active MT5 build surface and planning documents for implementation.
This is where the new codebase will live.

#### `office/`
Holds governance, decision, status, work logging, and change tracking.
This is the active operational control surface.

#### `archives/`
Holds lineage and old generations.
This is no longer an active build surface.
It is evidence only.

---

## Stage 0 authority outcome

When Stage 0 is complete, authority must be unambiguous.

### Active authority order
1. `blueprint/final/00_ASC_FOUNDATION.md`
2. the rest of `blueprint/final/`
3. `blueprint/roadmap/`
4. `office/`
5. `mt5/` implementation reality
6. `archives/` as evidence only

### What this solves
This prevents old docs, old runtime folders, or archive naming from continuing to act like shadow authority after the rebuild has already been declared.

---

## Stage 0 deliverables

Stage 0 is expected to deliver the following active surfaces.

### Blueprint final surface
The `blueprint/final/` lawbook files must exist and be complete enough to guide future implementation directly.

Required files:
- `00_ASC_FOUNDATION.md`
- `01_ASC_CORE_RUNTIME_LAWS.md`
- `02_ASC_WORK_CLASS_MODEL.md`
- `03_ASC_FIVE_LAYER_SYSTEM.md`
- `04_ASC_LAYER_1_MARKET_STATE.md`
- `05_ASC_LAYER_2_OPEN_SYMBOL_SNAPSHOT.md`
- `06_ASC_LAYER_3_CANDIDATE_FILTERING.md`
- `07_ASC_LAYER_4_SHORTLIST_SELECTION.md`
- `08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md`
- `09_ASC_GOVERNOR_MODES_AND_STARVATION.md`
- `10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md`
- `11_ASC_HUD_AND_OPERATOR_SURFACE.md`
- `12_ASC_ARTIFACT_SCHEMA_AND_VERSIONING.md`
- `13_ASC_MT5_MODULE_MAP.md`
- `14_ASC_ENGINEERING_GUIDELINES.md`
- `15_ASC_INVALID_DESIGNS.md`

### Blueprint roadmap surface
The `blueprint/roadmap/` skeleton must exist and begin with its controlling overview and strategy files.
At minimum, Stage 0 should establish the roadmap authority files first so later stage files are interpreted correctly.

### Office surface
The active `office/` files must be created as the control room for execution status, decisions, and change tracking.

### MT5 planning surface
The active `mt5/` planning files must be established so the new implementation surface is visible before code begins.

---

## Stage 0 file-creation order

The preferred Stage 0 file-creation order is:

1. `blueprint/final/00_ASC_FOUNDATION.md`
2. remaining `blueprint/final/` lawbook files
3. `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`
4. `blueprint/roadmap/01_BUILD_STRATEGY.md`
5. remaining roadmap stage files
6. `office/` control files
7. `mt5/` planning/build-surface files

### Why this order matters
The final lawbook must exist before the roadmap can be interpreted correctly.
The roadmap must exist before office can accurately track stage progress.
The planning/build surface for MT5 must exist before code implementation begins.

---

## Archive posture during Stage 0

### Archives remain present
Stage 0 does not require deleting historical archives.
Archives remain in the repo as lineage and evidence.

### Archives lose active authority
What changes in Stage 0 is their role.
Archives must no longer be treated as:
- the active blueprint
- the active runtime surface
- the active office/control plane
- the default source of module naming

### Archive usage after Stage 0
After Stage 0, archive usage is legitimate only for:
- lineage review
- failure-pattern extraction
- evidence comparison
- selective doctrine retention when it survives final blueprint scrutiny

If future implementation keeps “borrowing” from the archive casually, Stage 0 failed.

---

## MT5 surface posture during Stage 0

### MT5 is planned before coded
Stage 0 creates the new MT5 build surface as a planning and structure domain, not as a rushed runtime implementation zone.

### Why this matters
If code begins before the MT5 surface is structurally planned, the repo will inherit:
- naming drift
- helper sprawl
- ad hoc module placement
- cross-domain leakage

Stage 0 exists so that when code begins, it begins inside a deliberate structure.

---

## Office posture during Stage 0

### Office must stay lean
Stage 0 should establish office as a compact control layer rather than a paperwork explosion.

The office role is:
- decisions
- stage status
- work log
- change ledger
- operational canon

It is not:
- a second blueprint
- a dumping ground for every thought
- an archive replacement

### Why this matters
Without a lean office surface, the rebuild starts accumulating operational drag before code even begins.

---

## Stage 0 constraints

Stage 0 must obey the following constraints:

### 1. No runtime implementation widening
Do not begin Layer 1, governor, persistence, or HUD runtime code under the banner of repo reset.

### 2. No placeholder canon
Do not create shallow outline docs that force later reinterpretation.
Stage 0 documents must already be substantive enough to govern future work.

### 3. No archive cloning
Do not recreate old folder trees simply because they existed before.
The new active repo must follow the final blueprint, not historical inertia.

### 4. No ambiguous active paths
There must not be two plausible active blueprint roots or two plausible active MT5 roots after Stage 0.

### 5. No office sprawl
Do not explode office into unnecessary governance clutter.

---

## Stage 0 quality gates

Stage 0 is only complete when all of the following are true:

### Gate 1 — Active repo shape is explicit
The active repo domains are present and unambiguous.

### Gate 2 — Final blueprint authority is established
The lawbook exists in `blueprint/final/` and is recognized as the design authority.

### Gate 3 — Roadmap authority is established
`blueprint/roadmap/` exists and is explicitly subordinate to the final blueprint.

### Gate 4 — Archives are demoted cleanly
Archives remain present but are no longer active build surfaces.

### Gate 5 — Office is aligned
The office role is explicitly defined for the rebuild and is not bloated.

### Gate 6 — MT5 planning surface is declared
The active MT5 build surface exists at least as a structure/planning domain, even before runtime code begins.

### Gate 7 — No active-path ambiguity remains
A future implementation pass can identify exactly where to read authority from and where to place code.

---

## Evidence required for Stage 0 completion

Stage 0 completion should be evidenced by:
- the existence of the new top-level active repo surfaces
- the existence of completed foundational blueprint files
- the existence of roadmap control files
- explicit archive demotion language
- explicit office role definition
- explicit MT5 planning/build-surface definition
- office status reflecting that Stage 0 was completed

The presence of old archive content is not evidence against Stage 0 completion by itself.
What matters is whether active authority is clean.

---

## What Stage 0 makes newly admissible

Once Stage 0 is complete, the following become admissible:
- Stage 1 foundation/type planning and implementation work
- office tracking against a stable roadmap
- MT5 module-structure planning work
- controlled branch/commit work that can reference active blueprint authority directly

What does **not** become automatically admissible:
- jumping ahead to rich UI or dossier work
- deep runtime implementation without the next stage gates
- any MT5 rebuild implementation before Stage 0A pre-implementation freeze is passed
- archive-derived module naming by convenience

---

## Common failure patterns Stage 0 must prevent

### Pattern 1 — Two active repos inside one repo
The new blueprint exists, but the old runtime or old blueprint still feels active in practice.

Result:
- contributors pull from the wrong authority
- naming and folder drift begin immediately

### Pattern 2 — Docs exist but repo shape still lies
The documents say the rebuild started, but the repo still physically suggests the old active structure.

Result:
- future implementation follows habit, not law

### Pattern 3 — Placeholder doctrine
Stage 0 creates vague top-level docs that still force future work to reinterpret ownership.

Result:
- patch-loop pressure begins before runtime code exists

### Pattern 4 — Archive nostalgia leakage
New active files and names are repeatedly chosen by resemblance to archive layout rather than by final blueprint meaning.

Result:
- old clutter returns through inertia

### Pattern 5 — Office bureaucracy bloom
The office surface becomes too large too early and starts consuming energy that should go into clean architecture and implementation.

Result:
- operational drag
- weaker focus

---

## Stage 0 invalid completions

Stage 0 is **not** complete if any of the following are true:
- active blueprint authority is still ambiguous
- the active MT5 build surface is unclear
- archives still function as shadow-active design law
- office role is bloated or undefined
- the repo still suggests multiple plausible build roots
- blueprint files are only thin outlines
- runtime implementation quietly began without the next stage’s law being in place

---

## Relationship to later stages

Stage 0 does not produce runtime truth.
It produces the conditions under which runtime truth can be built safely.

That means every later stage depends on Stage 0 having already solved:
- repo authority
- path clarity
- active-domain clarity
- archive demotion
- control-plane alignment

If later stages appear confusing about where to place work, Stage 0 was incomplete.

---

## Final standard

Stage 0 is correct when the rebuild becomes physically real in the repository and the active path is too clear to mistake.

That means Stage 0 must leave ASC with:
- one active blueprint authority surface
- one active roadmap surface
- one active office surface
- one active MT5 build surface
- archives preserved but demoted
- no credible excuse for future implementation to build in the wrong place

The standard is not that folders exist.
The standard is that the repository itself now reinforces the rebuild instead of undermining it.