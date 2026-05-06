# ASC Canonical Product Spine

## Purpose

This file is the compact **build-from-here** integration spine.
It exists to prevent wrong-file edits, stale-reference drift, and out-of-order implementation claims.

This file does not replace domain contracts. It points to ownership and enforces execution law.

Stage 5 consolidation lock:
- use this file as the compact build-door and authority map after reading the root front-door files
- use it to identify the owner file before editing anything
- do not treat roadmap, office, HUD wording, or archive material as substitute doctrine when this file points to an owner contract

Recovery clarification:
- this file is the compact doctrine/build map, not a replacement for proving the active compile/runtime tree
- during live MT5 recovery, start by proving the active compile root and include graph under `mt5/`
- if support wording here ever conflicts with verified active runtime ownership, correct the support wording; do not force runtime truth to match stale doctrine wording

---

## 0) Canonical ownership map (single-source map)

Use this table first before editing any contract or opening any implementation slice.

| Domain | Canonical owner file (edit authority) | Reference-only files (must not override owner) | Must-edit-together guardrail |
|---|---|---|---|
| Runtime / dispatcher law | `blueprint/final/01_ASC_CORE_RUNTIME_LAWS.md` | `blueprint/roadmap/04_STAGE_2_DISPATCHER_AND_GOVERNOR.md`, `office/ROADMAP_STATUS.md` | If runtime ownership changes, verify heartbeat/memory/write contracts in same pass. |
| Scheduler vs execution / HUD transaction law | `blueprint/final/ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md` | `blueprint/final/ASC_HEARTBEAT_BREATHING_CONTRACT.md`, `blueprint/final/11_ASC_HUD_AND_OPERATOR_SURFACE.md` | Scheduler pulse interpretation, lane execution granularity, and HUD transaction ownership must stay aligned across heartbeat/HUD/page contracts. |
| Heartbeat lane law | `blueprint/final/ASC_HEARTBEAT_BREATHING_CONTRACT.md` | `blueprint/roadmap/02A_STAGE_0A_PRE_IMPLEMENTATION_FREEZE.md`, `blueprint/roadmap/04_STAGE_2_DISPATCHER_AND_GOVERNOR.md` | Any lane/precedence change requires synchronized check of `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`, memory dirty-routing law, write trigger/publication law, and Stage 0A freeze-evidence review row update. |
| Memory residency / eviction law | `blueprint/final/ASC_MEMORY_RESIDENCY_AND_EVICTION_LAW.md` | `blueprint/roadmap/02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md` | Any T0/T1/T2/T3 truth change requires write-guard coherence check in Stage 0B Gate 1. |
| Write trigger / publication law | `blueprint/final/ASC_WRITE_TRIGGER_AND_PUBLICATION_MATRIX.md` | `blueprint/final/10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md`, `blueprint/roadmap/10_STAGE_8_PERSISTENCE_AND_ARTIFACTS.md` | Any write-trigger change requires denial-condition and atomicity re-verification. |
| Artifact families/schema | `blueprint/final/10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md` + `blueprint/final/12_ASC_ARTIFACT_SCHEMA_AND_VERSIONING.md` | `blueprint/roadmap/10_STAGE_8_PERSISTENCE_AND_ARTIFACTS.md`, `office/ROADMAP_STATUS.md` | Family/schema edits must remain synchronized across both owner files. |
| Board / Dossier / Current Focus law | `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md` | `blueprint/roadmap/10_STAGE_8_PERSISTENCE_AND_ARTIFACTS.md`, `blueprint/roadmap/11_STAGE_9_HUD_AND_OPERATOR_SURFACE.md` | If section naming or write-discipline changes, verify artifact contract and HUD consumer wording in same pass; Top-5/Top-10 correlation line wording/placement must be edited only in the owner file and cross-referenced elsewhere. |
| Symbol action + bridge law | `blueprint/final/ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md` | `blueprint/final/08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md`, `blueprint/roadmap/09_STAGE_7_LAYER_5_DEEP_ANALYSIS.md`, `blueprint/roadmap/11_STAGE_9_HUD_AND_OPERATOR_SURFACE.md` | Bridge lifecycle table is canonical in symbol-action contract only; no duplicate lifecycle tables elsewhere. |
| HUD page hierarchy / product contract | `blueprint/final/ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md` | `blueprint/final/11_ASC_HUD_AND_OPERATOR_SURFACE.md`, `blueprint/roadmap/11_STAGE_9_HUD_AND_OPERATOR_SURFACE.md` | Page performance/freeze wording must be coherent with `11_ASC_HUD_AND_OPERATOR_SURFACE.md`, `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`, and `ASC_TACTICAL_REALTIME_FIELD_CONTRACT.md`; contradictory fixed-delay freeze wording is non-admissible. |
| EA menu/settings law | `blueprint/final/ASC_MENU_AND_SETTINGS_CONTRACT.md` | all roadmap references to menu/settings | **Path lock**: only this file path is canonical; legacy `ASC_EA_MENU_AND_SETTINGS_CONTRACT.md` is retired. Stage 3 control doctrine must stay synchronized with `ASC_TRADER_CONTROL_REGISTRY.md`, `08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md`, and `11_ASC_HUD_AND_OPERATOR_SURFACE.md`. |
| Scope / admissibility law | `blueprint/final/ASC_SCOPE_BOUNDARY_AND_ADMISSIBILITY_MAP.md` | `blueprint/roadmap/02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`, `office/ROADMAP_STATUS.md`, `FRONT_DOOR_CHECKLIST.md` | Any admissibility change requires synchronized office + front-door wording update in same pass. |
| Signal ownership + layer handoff law | `blueprint/final/03_ASC_FIVE_LAYER_SYSTEM.md` | `blueprint/final/06_ASC_LAYER_3_CANDIDATE_FILTERING.md`, `blueprint/final/07_ASC_LAYER_4_SHORTLIST_SELECTION.md`, `blueprint/final/08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md`, `office/DECISIONS.md` | Signal ownership, layer neutrality, and SIAM / Aurora downstream interpretation wording must remain synchronized across the layer stack and office doctrine in the same pass. |
| Re-entry gate law | `blueprint/roadmap/02A_STAGE_0A_PRE_IMPLEMENTATION_FREEZE.md` + `blueprint/roadmap/02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md` + `FRONT_DOOR_CHECKLIST.md` | `office/ROADMAP_STATUS.md`, `office/DECISIONS.md` | Gate criteria and closure schema must match across roadmap/front-door/office without drift. |
| Office status truth | `office/ROADMAP_STATUS.md` | `office/WORK_LOG.md`, `office/CHANGE_LEDGER.md`, `office/DECISIONS.md` | Status changes are invalid unless decision/log/ledger are synchronized in same pass. |

---

## 1) Exact present buildable scope (current admissible product)

Stage 2 artifact-contract completion and Stage 3 control-contract completion are now part of the admissible product baseline:
- **Market Board** = compact inspection-priority board, not signal board
- **Dossier** = full per-symbol intelligence artifact
- **Current Focus** = singleton selected-symbol working artifact
- these three surfaces are consumer artifacts only and do not own shortlist truth, deep-truth birth, or final signal logic
- menu/settings now has a frozen trader-control doctrine for timeframe/bars/ATR/spread/tick/output configuration without granting signal ownership


Current admissible scope is limited to:
- scanner truth flow through **Deep Analysis**,
- SIAM / Aurora downstream interpretation ownership defined doctrinally but not widened into active runtime execution,
- **Market Board**,
- **Symbol Dossier**,
- **Current Focus**,
- menu/settings law surfaces,
- HUD consumer pages,
- symbol-scoped **Deep Analysis** action only,
- Aurora Signal / Semi-Auto / Full Auto as **placeholder-only non-active controls**.

Normative files:
- `blueprint/final/ASC_SCOPE_BOUNDARY_AND_ADMISSIBILITY_MAP.md`
- `blueprint/final/ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md`
- `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
- `blueprint/final/ASC_MENU_AND_SETTINGS_CONTRACT.md`

---

## 2) Explicitly blocked now (future-scope containment)

Blocked in current implementation scope:
- ASC-owned final trade signals,
- active SIAM / Aurora execution behavior,
- active Semi-Auto execution,
- active Full Auto execution,
- workflow collapse into scanner-global automation behavior,
- archive output used as present runtime proof.

Normative files:
- `blueprint/final/ASC_SCOPE_BOUNDARY_AND_ADMISSIBILITY_MAP.md`
- `blueprint/roadmap/02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`
- `FRONT_DOOR_CHECKLIST.md`

---

## 3) Builder-proof execution order (first 3 lawful slices)

Do not open these slices out of order.

### Slice 1 (first lawful slice)
**Scope:** Stage 0A freeze evidence closure.

**Must prove:** frozen heartbeat/memory/write/symbol-action/board-dossier/menu/scope contracts with file-linked evidence.

**Evidence owner files:**
- `blueprint/roadmap/02A_STAGE_0A_PRE_IMPLEMENTATION_FREEZE.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`

### Slice 2 (second lawful slice)
**Scope:** Stage 0B integration hard-gate run.

**Must prove:** Gate 1–6 pass/fail with contradictions explicit, including menu/settings canonical path singularity.

**Evidence owner files:**
- `blueprint/roadmap/02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`

### Slice 3 (third lawful slice)
**Scope:** Stage 1 foundation/type/runtime-prerequisite implementation planning under passed Stage 0A/0B gates.

**Must prove before opening Stage 2:** schema/contract foundations and office synchronization are real, with no stage-side runtime-substitute artifact evidence.

**Evidence owner files:**
- `blueprint/roadmap/03_STAGE_1_FOUNDATION_AND_TYPES.md`
- `blueprint/roadmap/15_EXECUTION_BACKLOG.md`
- `office/ROADMAP_STATUS.md`

---

## 4) Acceptance evidence law (non-optional)

Completion claims are invalid unless all are present:
1. gate-by-gate pass/fail rows using the mandatory shared evidence register schema,
2. exact file references (not summary-only prose),
3. unresolved contradiction list (or explicit `none`),
4. synchronized updates across office status + work log + change ledger,
5. explicit decision reference for any doctrinal change.

Documentation-only completion claims are non-admissible.
Archive-only completion claims are non-admissible.

---

## 5) Anti-drift execution law

Future workers must not:
1. edit reference-only files while skipping the owner file,
2. split canonical consolidated files into parallel twins,
3. implement future-scope placeholder behavior in present scope,
4. run implementation slices out of order,
5. promote archive evidence into present-tense runtime proof,
6. use stage-side static Board/Current Focus/Dossier files as implementation proof,
7. mark completion from partial gates or partial office updates.
8. open EA/runtime implementation from heartbeat/HUD files alone while skipping `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`.
9. drift ASC from truth producer into signal engine language or ownership.
10. treat future SIAM / Aurora interpretation schema details as if Stage 1 already froze them.

If any of these occur, treat as drift and reopen the gate.

---

## 6) Canonical-migration blockers (hard)

MT5 runtime is already active in `mt5/`.
Migration from the current active MT5 tree into the target canonical module-map structure remains non-admissible until:
- Stage 0A = complete with closure evidence register,
- Stage 0B = complete with hard-gate evidence register,
- front-door checklist statuses and office stage table are synchronized,
- no unresolved integration coherence contradictions remain open.

Authoritative files:
- `FRONT_DOOR_CHECKLIST.md`
- `blueprint/roadmap/02A_STAGE_0A_PRE_IMPLEMENTATION_FREEZE.md`
- `blueprint/roadmap/02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`
- `office/ROADMAP_STATUS.md`

---

## 6A) Stage 4 doctrine completion lock

Stage 4 is the field-contract completion pass.
It freezes:
- complete Layer 1 market-state field contract
- complete Layer 2 open-symbol packet field contract
- complete Layer 3 neutral gate field contract
- complete Layer 4 attention-shortlist field contract
- complete Layer 5 deep-analysis subsection contract
- explicit observed-truth vs interpreted-truth separation
- final ASC → SIAM / analyst handoff contract
- required vs optional vs future-expansion distinction

This pass does **not**:
- change MT5 runtime code
- move ASC into final signal ownership
- widen Layer 4 into best-trade ranking
- widen Layer 5 into execution or signal-engine ownership

## 6B) Stage 5 consolidation lock

Stage 5 is the final blueprint-consolidation pass.
It freezes:
- front-door authority order
- office/status alignment for Stages 1–5
- cross-file consistency around signal ownership, layer ownership, artifact roles, and menu powers
- invalid-design warnings against hidden signal drift
- authoritative next-step guidance toward implementation / verification work

This pass does **not**:
- claim runtime implementation completion
- widen ASC into final signal ownership
- reopen artifact, control, or layer doctrine except for wording alignment
- authorize arbitrary MT5 rewrites

## 7) Builder-answer quick map (EA creation readiness)

Use this checklist as the compact answer surface before opening implementation work.

1. Exact current buildable product? -> Section **1** above.
2. Exact first lawful slice? -> Section **3 / Slice 1**.
3. Exact second lawful slice? -> Section **3 / Slice 2**.
4. Exact third lawful slice? -> Section **3 / Slice 3**.
5. Exact evidence required per slice? -> Section **4** + Stage 0A/0B register schemas.
6. Canonical owner files? -> Section **0** owner column.
7. Reference-only files? -> Section **0** reference-only column.
8. Files that must be edited together? -> Section **0** must-edit-together column.
9. Work blocked before MT5 canonical migration? -> Section **6**.
10. Mistakes that count as drift? -> Section **5**.
11. Placeholder-only behavior? -> Sections **1** and **2**.
12. Forbidden-now behavior even if desired later? -> Section **2**.

If any answer is unclear, do not open implementation; fix control surfaces first.
