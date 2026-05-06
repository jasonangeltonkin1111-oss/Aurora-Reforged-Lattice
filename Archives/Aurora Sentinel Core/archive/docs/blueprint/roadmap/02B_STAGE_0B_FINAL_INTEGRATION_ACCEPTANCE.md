# ASC Stage 0B — Final Integration Acceptance

## Purpose

This document defines Stage 0B of the Aurora Sentinel Scanner (ASC) rebuild roadmap.

Stage 0B exists to run a hard integration checkpoint after Stage 0A freeze evidence is complete and before MT5 re-entry claims are allowed.

---

## Stage objective

Stage 0B verifies that frozen contracts, office posture, and roadmap intent are coherent as one integrated surface.

This stage is a pass/fail checkpoint for:
- runtime/heartbeat/memory/write contract coherence
- artifact/page/menu coherence
- present-vs-future scope consistency
- bridge-law consistency
- office + front-door alignment
- repo reality alignment (archives as evidence, active MT5 absent until explicit re-entry)

---

## Hard admissibility rule

**MT5 re-entry claims are not admissible until Stage 0B passes all hard gates.**

Until Stage 0B is marked pass with evidence:
- no active-runtime claim is allowed from archive notes
- no office surface may imply active MT5 runtime presence
- no roadmap item may bypass archive-vs-active boundary law

---

## Canonical admissibility definitions (normative)

Use these terms exactly across roadmap/office/front-door surfaces.

- **Historical archive evidence** = prior implementation notes and historical status claims preserved for provenance, audit trail, and sequencing context.
- **Current admissible scope** = only what is presently supported by active control files, dependency gates, and explicit same-era verification evidence.
- **Admissible** = allowed to be claimed or executed now under current-stage dependency reality and required evidence.
- **Blocked** = meaningful but not admissible yet due to unmet prerequisite stage, gate, or evidence.
- **Non-admissible / rejected** = explicitly disallowed under current architecture/gates and not promotable to active work.
- **MT5 re-entry admissible** = allowed only after Stage 0A is complete and Stage 0B is passed with evidence.

## Hard pass/fail gates

Each gate is binary. Any single fail keeps Stage 0B open.

### Gate 1 — Runtime / heartbeat / memory / write contract coherence
**Pass requires all of the following:**
- heartbeat cadence and lane ownership are mutually consistent across runtime law files
- runtime memory/state ownership does not conflict with write-discipline law
- board/dossier/current-focus write contract remains explicit and non-contradictory

**Fail conditions:**
- heartbeat or lane ownership drift between canon files
- memory/state ownership ambiguity that allows silent cross-lane writes
- write-discipline wording that conflicts with runtime ownership law

### Gate 2 — Artifact / page / menu coherence
**Pass requires all of the following:**
- artifact families and publication posture align with page hierarchy expectations
- page requirements do not demand fields absent from artifact schema law
- menu/settings contract does not expose controls that violate artifact/page ownership boundaries
- Menu/settings canonical file path is singular and consistent across all references.

**Fail conditions:**
- page or menu claims that require synthetic artifact fill
- artifact schema gaps hidden by UI assumptions
- menu controls that imply disallowed runtime ownership

### Gate 3 — Present-vs-future scope consistency
**Pass requires all of the following:**
- current-stage documents remain scoped to present admissible work
- future placeholders remain explicitly non-admissible
- no future-scope feature appears as current-stage obligation

**Fail conditions:**
- current docs quietly importing future-scope responsibilities
- placeholder stages presented as active contracts
- acceptance wording that collapses present/future boundary

### Gate 4 — Bridge-law consistency
**Pass requires all of the following:**
- symbol-action bridge semantics remain eligibility-gated and explicit
- bridge behavior does not mutate scanner authority boundaries
- bridge references align with symbol-action surface contract and scope-boundary law

**Fail conditions:**
- bridge wording that implies scanner-global automation loops
- bridge semantics that bypass eligibility gates
- contradictory bridge definitions across control documents

### Gate 5 — Office + front-door alignment
**Pass requires all of the following:**
- office control files and front-door roadmap/blueprint files report the same stage posture
- blocked/admissible language is consistent across office and roadmap surfaces
- status wording does not overclaim runtime reality

**Fail conditions:**
- office says blocked while front-door text implies active runtime progression
- roadmap status claims not reflected in office control files
- stale front-door wording that contradicts office truth

### Gate 6 — Repo reality alignment
**Pass requires all of the following:**
- archives are explicitly treated as historical evidence only
- active `mt5/` runtime implementation is absent (or explicitly marked non-active) until re-entry criteria pass
- no document uses archive output as present runtime proof

**Fail conditions:**
- archive notes presented as active runtime validation
- implicit claim of active MT5 runtime presence without re-entry evidence
- repo control surfaces that blur archive-evidence vs active-runtime truth

---

## Required evidence bundle

Stage 0B pass requires file-linked evidence recorded in:
- `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`
- `blueprint/roadmap/15_EXECUTION_BACKLOG.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md` (integration-check run entry)
- `office/CHANGE_LEDGER.md` (if any control wording changed to resolve fails)

### Mandatory closure evidence register format
Stage 0B closure is valid only when the office surfaces above include a shared evidence register block using this exact schema:

- **gate name**
- **pass/fail**
- **exact file references**
- **unresolved contradiction list**
- **decision reference**
- **closure date**

#### Stage 0B closure evidence register template (required)
```md
### Stage 0B Closure Evidence Register

| gate name | pass/fail | exact file references | unresolved contradiction list | decision reference | closure date |
|---|---|---|---|---|---|
| [Gate 1..6] | [pass\|fail] | [repo-path references] | [explicit list or `none`] | [e.g., D-0XX] | [YYYY-MM-DD] |
```

Completion is invalid if any schema field is omitted, vague, or represented as soft “overall confidence” language.

---

## Invalid completion patterns

Stage 0B is invalidly marked complete if:
- any gate result is inferred without file-linked evidence
- gate failures are reframed as “future hardening” when they are current control contradictions
- archive evidence is used as substitute for active-runtime proof
- office and front-door surfaces are known divergent at checkpoint close

---

## What Stage 0B makes newly admissible

Once Stage 0B exits pass with evidence, the following become admissible:
- explicit MT5 re-entry planning under frozen and integrated control law
- Stage 1 activation on a coherent repo-control surface
- downstream implementation sequencing governed by verified office/front-door alignment

What remains not admissible:
- runtime progression claims without re-entry evidence logging
- shortcut reinterpretations of bridge, menu, or artifact law to accelerate coding

---

## Stage 0B gate-run protocol (auditable, non-soft)

### Gate evidence matrix (must be executed gate-by-gate)

| Gate | Canonical evidence owners | Gate pass requirement |
|---|---|---|
| Gate 1 — Runtime/heartbeat/memory/write coherence | `blueprint/final/01_ASC_CORE_RUNTIME_LAWS.md`, `blueprint/final/ASC_HEARTBEAT_BREATHING_CONTRACT.md`, `blueprint/final/ASC_MEMORY_RESIDENCY_AND_EVICTION_LAW.md`, `blueprint/final/ASC_WRITE_TRIGGER_AND_PUBLICATION_MATRIX.md` | No ownership contradictions and unresolved contradiction list = `none`. |
| Gate 2 — Artifact/page/menu coherence | `blueprint/final/10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md`, `blueprint/final/12_ASC_ARTIFACT_SCHEMA_AND_VERSIONING.md`, `blueprint/final/ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md`, `blueprint/final/ASC_MENU_AND_SETTINGS_CONTRACT.md` | Page/menu requirements do not depend on missing artifact truth; menu canonical path singularity verified. |
| Gate 3 — Present-vs-future scope consistency | `blueprint/final/ASC_SCOPE_BOUNDARY_AND_ADMISSIBILITY_MAP.md`, `office/ROADMAP_STATUS.md`, `FRONT_DOOR_CHECKLIST.md` | No future-scope lane appears as present obligation. |
| Gate 4 — Bridge-law consistency | `blueprint/final/ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md`, `blueprint/final/08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md` | Symbol-scoped eligibility/fail-closed semantics remain coherent and non-global. |
| Gate 5 — Office + front-door alignment | `office/ROADMAP_STATUS.md`, `office/DECISIONS.md`, `office/WORK_LOG.md`, `office/CHANGE_LEDGER.md`, `FRONT_DOOR_CHECKLIST.md` | Stage posture and admissibility wording are synchronized across all control surfaces. |
| Gate 6 — Repo reality alignment | `archives/README.md`, `office/ROADMAP_STATUS.md`, `FRONT_DOOR_CHECKLIST.md` | Archives are evidence-only and no active-runtime claim is made from archive notes alone. |

### No-soft-pass law

Stage 0B is invalidly closed if any gate row uses narrative-only confidence language.
Each gate row must declare pass/fail with exact file references and explicit unresolved contradiction outcome.

### Required same-pass office synchronization

A Stage 0B close attempt is invalid unless all are updated in the same pass:
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md` (if gate criteria wording or interpretation changed)
