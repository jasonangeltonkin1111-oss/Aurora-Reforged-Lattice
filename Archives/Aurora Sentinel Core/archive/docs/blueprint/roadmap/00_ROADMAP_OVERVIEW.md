# ASC Roadmap Overview

## Purpose

This document defines the role, scope, and operating law of the ASC roadmap.

The roadmap exists to answer one question:

> how does Aurora Sentinel Scanner (ASC) get built from frozen design into trustworthy implementation without collapsing back into patch-loop chaos?

The roadmap is not the design lawbook.
It is the controlled construction path.

This file exists to make that distinction explicit so implementation sequencing does not quietly mutate into architecture drift.

---

## Core doctrine

### Roadmap-is-subordinate law
The roadmap is subordinate to `blueprint/final/`.

That means:
- the roadmap may stage work
- the roadmap may sequence dependencies
- the roadmap may define milestones, gates, and work packages
- the roadmap may not silently redefine final architecture

If the roadmap appears to contradict the final blueprint, the final blueprint wins until explicitly changed.

### Build-order-is-a-risk-control law
The build order of ASC is not a convenience detail.
It is a risk-control system.

A wrong build order creates:
- fake progress
- partial systems with hidden contradictions
- patch pressure
- architecture drift
- repeated restart cycles

A correct build order reduces these by making implementation follow the truth hierarchy already locked in the final blueprint.

### No-runtime-patch-loop law
The roadmap exists specifically to stop the old pattern where runtime friction triggered improvised local fixes, which then mutated architecture indirectly.

The new rule is:
- architecture freezes first
- roadmap sequences the work second
- code follows both
- deviations are surfaced explicitly

### Stage-gate law
ASC should be built through explicit stages.
A stage is not complete because some code exists.
A stage is complete when its scope, acceptance criteria, and dependency obligations are satisfied honestly.

### Anti-speedrun evidence law
Gate closure does not equal implementation completion by default.

Forbidden drift patterns:
- stage activation used to authorize runtime-substitute artifacts
- visible placeholder files treated as proof that product paths are working
- stage-side proof packets used to claim runtime publication readiness

Required posture:
- blueprint defines contracts
- roadmap sequences implementation
- office records truth
- runtime publishes Board / Current Focus / Dossiers

### Incomplete-is-better-than-fake-complete law
A stage may remain incomplete as long as its boundary is explicit and its outputs are honest.
What is forbidden is pretending a stage is done by cross-wiring unfinished layers or hiding missing truth behind UI or persistence tricks.

---

## Relationship to other blueprint domains

### Relationship to `blueprint/final/`
`blueprint/final/` defines:
- what ASC is
- what each layer owns
- how runtime, persistence, HUD, schema, and modules must behave
- what designs are invalid

`blueprint/roadmap/` defines:
- the order in which those laws should be implemented
- the gates required before advancing
- the practical construction slices
- the dependency chain between unfinished work packages

### Relationship to `office/`
`office/` tracks:
- decisions
- execution status
- work logs
- change records

The roadmap does not replace office governance.
Office records progress and change reality.
The roadmap describes the intended controlled path.

Archive inheritance decision canon reference:
- `blueprint/ASC_ARCHIVE_INHERITANCE_CLASSIFICATION.md`

### Relationship to `mt5/`
The roadmap does not contain production runtime code.
It tells the future `mt5/` implementation surface what should be built first, what must wait, and what evidence is required before the next domain is allowed to widen.

---

## Why ASC needs a roadmap at all

ASC is not a trivial EA.
It has:
- one dispatcher runtime
- explicit work-class separation
- a five-layer truth model
- governed persistence and artifact families
- a hybrid structural/tactical HUD model
- family-aware schema/versioning and recovery posture

That means a naive coding order would almost certainly create local conveniences that blur ownership.
The roadmap exists so implementation does not have to guess the safest order.

---

## Roadmap goals

The roadmap must achieve all of the following:

1. protect architectural boundaries during implementation
2. sequence implementation in dependency-respecting order
3. make progress measurable without faking completeness
4. define stage exits clearly
5. reduce restart pressure by avoiding premature widening
6. preserve compile safety and runtime continuity as the codebase grows
7. keep office governance aligned with real stage status

If a future roadmap slice undermines these, the slice is wrong even if it looks productive.

---

## Roadmap anti-goals

The roadmap is **not** trying to:
- brainstorm new architecture during codegen
- maximize output volume per session at the cost of coherence
- skip foundational stages because later features look more exciting
- allow partial UI or dossier work to stand in for missing truth infrastructure
- preserve old implementation habits merely because they feel familiar

---

## Build philosophy

### Build from truth spine outward
ASC should be built from the structural truth spine outward, not from the most visible surface backward.

That means the order of emphasis is broadly:
1. repo/office/authority reset
2. pre-implementation freeze contracts and evidence
3. Stage 1 foundation rails: types/state contracts + runtime writing scaffold + HUD scaffold + dev logging scaffold
4. dispatcher/governor spine
5. Layer 1 broad truth hydration into already-existing runtime-owned outputs/HUD homes
6. Layer 2 packet truth hydration
7. Layer 3 filtering truth hydration
8. Layer 4 selection truth hydration
9. Layer 5 deep promoted truth hydration
10. persistence/artifact-family hardening and atomic landing maturity (not first-write authorization)
11. board/dossier/current-focus maturity and family-aware trust posture
12. rich HUD/operator completion (not first-HUD authorization)
13. recovery hardening
14. diagnostics and tests

This order exists because later surfaces depend on earlier truth being trustworthy.

### Build narrow before rich
ASC should prove narrow ownership slices before adding richer behavior.

Examples:
- Layer 1 broad market-state truth before Layer 2 richness
- shortlist authority before deep promoted enrichment
- structural HUD truth before tactical polish
- atomic landing before rich summary surfaces

### Build what reduces ambiguity first
The roadmap should favor stages that reduce uncertainty in system shape over stages that merely produce visible output.

### Build what future codegen can obey directly
Every roadmap stage should leave the repo easier to extend without reinterpretation.

### Pre-implementation freeze gate
Before MT5 rebuild implementation starts, ASC must pass a formal pre-implementation freeze gate.

At minimum, the freeze must verify and record stable contracts for:
- heartbeat matrix
- layer contracts
- publication matrix
- artifact lifecycle
- HUD role matrix
- symbol-action scaffold
- EA settings/menu contract

MT5 rebuild work is not admissible until this freeze gate is passed with file-linked evidence (per canonical definitions in `02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`).

---

## Stage model

The roadmap is organized into explicit stages.
Each stage should define:
- scope
- prerequisites
- files/modules affected
- deliverables
- prohibited widening
- quality gates
- evidence of completion
- what becomes newly admissible after completion

A stage is not just a task bucket.
It is a controlled boundary.

---

## Stage dependency law

Each stage must respect upstream dependencies.

Examples:
- governor logic should not be considered complete before foundational types and runtime state shape exist
- Layer 3 should not be widened before Layer 1 and Layer 2 truth are trustworthy
- HUD structural build should not outrun landed structural artifacts
- recovery hardening should not substitute for missing normal runtime law

If a stage seems blocked by missing upstream law, the answer is not to hack around it.
The answer is to complete or clarify the upstream stage.

---

## Stage gates

### Why gates exist
Without stage gates, implementation pressure naturally produces soft completions such as:
- “good enough for now”
- “we can clean it later”
- “the UI proves it works”
- “the artifact exists so it must be fine”

ASC explicitly rejects that style.

### Every stage must define
- entry criteria
- exit criteria
- minimum evidence required
- what counts as invalid completion
- what must remain forbidden after exit

### Gates are architectural, not ceremonial
A gate that is always passed regardless of real posture is useless.
Gate conditions must protect actual quality and dependency truth.

---

## Stage completion doctrine

A stage is complete only when:
- its primary ownership slice is implemented coherently
- its declared outputs exist in honest form
- its failure/degraded posture is representable
- it does not rely on unauthorized downstream shortcuts
- it does not violate final blueprint law
- EA settings/menu behavior in scope remains compliant with `blueprint/final/ASC_MENU_AND_SETTINGS_CONTRACT.md`
- its tests or validation evidence meet the declared bar for that stage

A stage is not complete merely because it compiles or displays something.

---

## Cross-stage invariants

The following invariants must hold across the whole roadmap:

### 1. Blueprint final remains the authority
No stage may quietly replace final design law with local implementation convenience.

### 2. Ownership stays explicit
If a stage creates shared or fuzzy ownership to move faster, that stage is invalid.

### 3. Structural truth outruns presentation
UI, dossiers, and support surfaces may not get ahead of landed structural truth.

### 4. Persistence remains a trust boundary
Publication logic must be treated as structural, not optional cleanup.

### 5. Mode and lane law remain real
Implementation stages must preserve one-major-lane-per-heartbeat and class-sensitive governor posture.

### 6. Degraded behavior must remain honest
Stages may be incomplete, but they may not lie about freshness, completeness, or continuity.

### 7. Foundation scaffolds begin in Stage 1
From the first real EA build onward, three rails are mandatory and already admissible:
- runtime-owned write scaffold for `Market Board.txt`, `Current Focus.txt`, and `Dossiers/*.txt`
- HUD consumer scaffold with structural homes present early
- bounded dev/workbench logging scaffold that records function, scope/symbol, result, failure reason, and target path where relevant

Later stages hydrate and harden these rails; they do not authorize their first existence.

### 8. Placeholder-replacement law
Early scaffold sections may contain truthful bounded placeholders (for example: `not yet observed`, `unavailable`, `awaiting later layer`, `not applicable`).

Placeholder use is valid only when:
- structure already exists in the canonical output/HUD location,
- placeholder status is explicit and truthful,
- later stages replace placeholders with runtime truth in place rather than rewriting architecture.

---

## Roadmap slice categories

The roadmap should generally use four kinds of slices:

### Foundation slices
These establish shared types, contracts, module structure, and runtime foundations.

### Truth slices
These implement the actual scanner truth stack across Layers 1 through 5.

### Landing/consumption slices
These implement persistence, artifact schema, HUD structural hydration, and consumer-safe surfaces.

### Hardening slices
These implement tests, recovery posture, diagnostics, performance hardening, and acceptance verification.

This categorization helps prevent rich visible work from leapfrogging structural dependencies.

---

## Failure posture during the roadmap

The roadmap must assume some stages will expose friction.
That is normal.

The correct response to stage friction is:
- isolate the boundary that failed
- determine whether the issue is implementation, sequencing, or architecture
- update the correct surface explicitly
- continue with preserved ownership

The incorrect response is:
- widen scope impulsively
- bolt missing pieces into unrelated files
- treat local hacks as acceptable glue
- declare the stage effectively done because downstream work can now continue

---

## Relationship to commits and work sessions

One roadmap stage may require multiple commits.
One commit may also complete only part of a stage.
That is acceptable.

What matters is that commits can still be understood relative to:
- current stage
- stage objective
- stage gate
- what remains blocked
- what newly became admissible

This is why `office/ROADMAP_STATUS.md`, `office/WORK_LOG.md`, and `office/CHANGE_LEDGER.md` must remain aligned with roadmap reality.

---

## Validation philosophy

Validation must grow with the roadmap.
Early stages should validate:
- shape
- type integrity
- ownership correctness
- compile safety

Middle stages should validate:
- truth progression
- freshness posture
- admission rules
- artifact landing behavior

Later stages should validate:
- cross-stage coherence
- recovery honesty
- HUD source clarity
- performance under realistic load
- acceptance against the full final blueprint

The roadmap therefore treats testing as staged, not as a final afterthought.

---

## What counts as roadmap drift

Roadmap drift happens when the roadmap stops being a controlled build sequence and starts acting like a second architecture layer.

Warning signs include:
- a roadmap file introducing new ownership not present in final blueprint
- a roadmap file redefining which layer owns what
- stage descriptions that rely on undefined helpers or convenience hacks
- stages declared complete despite unresolved trust-boundary problems
- implementation work repeatedly skipping upstream gates for visible downstream wins

When this happens, the roadmap must be corrected.

---

## Future-stage placeholders (reserved, non-admissible now)

The roadmap reserves future-stage placeholder space for symbol-action evolution beyond Stage 10.

These placeholders are planning markers only and do not authorize current implementation:
- Layer 6 (Semi-Auto) exploratory scaffolds
- Layer 7 (Full Auto) exploratory scaffolds
- possible future Layer 7 workflow-collapse doctrine

Until those stages are explicitly authored and accepted, the active contract remains:
- Layer 6/7 scaffold-only
- symbol-scoped action surfaces only
- no scanner-global HUD/operator automation loops
- post-Deep-Analysis bridge semantics must stay explicit and eligibility-gated

Reference contract: `blueprint/final/ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md`.
Additional boundary contract: `blueprint/final/ASC_SCOPE_BOUNDARY_AND_ADMISSIBILITY_MAP.md`.

## Stage overview

The canonical roadmap is divided into these files:

1. `00_ROADMAP_OVERVIEW.md`
2. `01_BUILD_STRATEGY.md`
3. `02_STAGE_0_REPO_RESET.md`
4. `02A_STAGE_0A_PRE_IMPLEMENTATION_FREEZE.md`
5. `02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`
6. `03_STAGE_1_FOUNDATION_AND_TYPES.md`
7. `04_STAGE_2_DISPATCHER_AND_GOVERNOR.md`
8. `05_STAGE_3_LAYER_1_MARKET_STATE.md`
9. `06_STAGE_4_LAYER_2_OPEN_SYMBOL_SNAPSHOT.md`
10. `07_STAGE_5_LAYER_3_FILTERING.md`
11. `08_STAGE_6_LAYER_4_SHORTLIST.md`
12. `09_STAGE_7_LAYER_5_DEEP_ANALYSIS.md`
13. `10_STAGE_8_PERSISTENCE_AND_ARTIFACTS.md`
14. `11_STAGE_9_HUD_AND_OPERATOR_SURFACE.md`
15. `12_STAGE_10_HARDENING_AND_ACCEPTANCE.md`
16. `13_TEST_MATRIX.md`
17. `14_RISKS_FAILURE_MODES_AND_RECOVERY.md`
18. `15_EXECUTION_BACKLOG.md`

The later files define the stages in detail.
This file defines how to interpret them.

---

## Roadmap acceptance criteria

The roadmap overview is correct only when all of the following are true:
- final blueprint remains the authority over roadmap sequencing
- stage order follows the truth/dependency hierarchy
- stages are explicit enough to block premature widening
- progress can be measured without faking completeness
- validation is staged and ownership-aware
- office governance can track stage reality without ambiguity
- implementation can follow the roadmap without inventing structure mid-flight

---

## Final standard

ASC roadmap is correct when it makes disciplined implementation easier than improvisation.

That means the roadmap must be:
- subordinate to final architecture
- dependency-aware
- stage-gated
- ownership-protective
- hostile to patch-loop drift
- honest about incomplete work
- explicit enough to guide real implementation directly

The standard is not that a sequence exists.
The standard is that the sequence protects the architecture while the system is being built.
---

## Builder-proof execution law (pre-EA stabilization)

This section is normative for future implementation passes.

### First 3 slices must run in this exact order

1. **Slice 1: Stage 0A freeze closure**
   - prove freeze criteria with exact file-linked evidence,
   - update office status/log/ledger in same pass,
   - do not open Stage 1 coding before this closure is evidenced.

2. **Slice 2: Stage 0B integration hard-gate closure**
   - run Gate 1–6 as binary pass/fail,
   - include unresolved contradiction list explicitly,
   - verify menu/settings canonical path singularity and reference coherence.

3. **Slice 3: Stage 1 foundation/type/runtime-prerequisite opening**
   - only after Slice 1 and Slice 2 are passed,
   - prove contract/schema/runtime-prerequisite foundations only,
   - keep Board/Current Focus/Dossiers runtime-owned and non-substitutable by stage-side static files,
   - do not claim downstream stage readiness from docs alone.

### Evidence law for each slice

Each slice must leave all of the following:
- updated stage posture in `office/ROADMAP_STATUS.md`,
- an execution entry in `office/WORK_LOG.md`,
- a change-meaning entry in `office/CHANGE_LEDGER.md`,
- required register rows in Stage 0A/0B templates when applicable,
- explicit statement of blocked versus newly admissible work.

### Drift conditions (automatic fail)

Treat the slice as failed if any of the following occur:
- implementation order is skipped,
- office surfaces are not synchronized,
- archive evidence is used as current runtime proof,
- future-scope placeholder behavior is claimed as current obligation,
- canonical owner/reference boundaries are violated.


## 2026-03-26 Stage 1 opening clarification

- Stage 1 now includes creation of an active MT5 implementation root and compile-oriented EA scaffold modules.
- Stage 1 remains bounded: no Stage 2 governor completion, no Layer-rich scanner logic, and no fake runtime output artifacts as proof.
- Runtime publication homes are opened as code-owned paths and directory scaffolds only.
