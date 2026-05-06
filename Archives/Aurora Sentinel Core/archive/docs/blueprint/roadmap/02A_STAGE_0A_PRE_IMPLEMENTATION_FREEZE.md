# ASC Stage 0A — Pre-Implementation Freeze

## Purpose

This document defines Stage 0A of the Aurora Sentinel Scanner (ASC) rebuild roadmap.

Stage 0A exists to freeze the minimum contract surfaces that implementation must obey before MT5 rebuild work begins.

---

## Stage objective

Stage 0A establishes and verifies pre-implementation freeze criteria for:
- heartbeat matrix
- layer contracts
- publication matrix
- artifact lifecycle
- HUD role matrix
- scheduler-vs-execution boundary and heartbeat-vs-burst separation
- HUD transaction ownership and visible-only render compute boundary
- symbol-action scaffold
- EA settings/menu contract
- scope-boundary admissibility map

This stage prevents code-first reinterpretation of system law.

---

## Hard admissibility rule

**MT5 rebuild is not admissible until Stage 0A freeze criteria pass.**

Until the freeze gate is satisfied with explicit evidence, the following remain blocked:
- MT5 runtime implementation widening
- dispatcher/governor coding
- layer runtime coding
- HUD runtime coding

Planning, audit, and contract clarification are allowed. Runtime build-out is not.

---

## Freeze criteria

### Criterion 1 — Heartbeat matrix freeze
Heartbeat cadence, lane ownership, scheduler boundary vs execution granularity, and admission budgets are frozen and consistent.

### Criterion 2 — Layer contract freeze
Layer ownership boundaries, handoff fields, and admission/exit expectations are frozen.

### Criterion 3 — Publication matrix freeze
Publication families, write ordering, and visibility scope are frozen.

### Criterion 4 — Artifact lifecycle freeze
Create/update/archive/restore lifecycle posture is frozen with degradation honesty.

### Criterion 5 — HUD role matrix freeze
HUD consumer roles, HUD transaction ownership and completion-bounded freeze law, structural vs tactical boundaries, tactical display vs structural authority separation, and non-authority posture are frozen.

### Criterion 6 — Symbol-action scaffold freeze
Board/dossier/current-focus symbol-action contracts and write-discipline are frozen.

### Criterion 7 — EA settings/menu contract freeze
Section model, forbidden controls, runtime-safe vs dangerous classes, runtime mapping law, and operator-facing wording rules are frozen.

---

## Stage 0A exit evidence checklist

Stage 0A exits only when each item below has explicit evidence in the named blueprint files:

1. Heartbeat matrix evidence in:
   - `blueprint/final/ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`
   - `blueprint/final/ASC_HEARTBEAT_BREATHING_CONTRACT.md`
   - `blueprint/final/01_ASC_CORE_RUNTIME_LAWS.md`
   - `blueprint/final/09_ASC_GOVERNOR_MODES_AND_STARVATION.md`
2. Layer contract evidence in:
   - `blueprint/final/03_ASC_FIVE_LAYER_SYSTEM.md`
   - `blueprint/final/04_ASC_LAYER_1_MARKET_STATE.md`
   - `blueprint/final/05_ASC_LAYER_2_OPEN_SYMBOL_SNAPSHOT.md`
   - `blueprint/final/06_ASC_LAYER_3_CANDIDATE_FILTERING.md`
   - `blueprint/final/07_ASC_LAYER_4_SHORTLIST_SELECTION.md`
   - `blueprint/final/08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md`
3. Publication matrix evidence in:
   - `blueprint/final/10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md`
   - `blueprint/final/12_ASC_ARTIFACT_SCHEMA_AND_VERSIONING.md`
4. Artifact lifecycle evidence in:
   - `blueprint/final/10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md`
   - `blueprint/final/12_ASC_ARTIFACT_SCHEMA_AND_VERSIONING.md`
5. HUD role matrix evidence in:
   - `blueprint/final/ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`
   - `blueprint/final/11_ASC_HUD_AND_OPERATOR_SURFACE.md`
   - `blueprint/final/ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md`
   - `blueprint/final/ASC_TACTICAL_REALTIME_FIELD_CONTRACT.md`
6. Symbol-action scaffold and write-discipline evidence in:
   - `blueprint/final/11_ASC_HUD_AND_OPERATOR_SURFACE.md`
   - `blueprint/final/14_ASC_ENGINEERING_GUIDELINES.md`
7. EA settings/menu contract evidence in:
   - `blueprint/final/ASC_MENU_AND_SETTINGS_CONTRACT.md`
8. Scope-boundary admissibility map evidence in:
   - `blueprint/final/ASC_SCOPE_BOUNDARY_AND_ADMISSIBILITY_MAP.md`

### Required office evidence
- `office/ROADMAP_STATUS.md` marks Stage 0A as complete only after all checklist items pass.
- `office/WORK_LOG.md` records the freeze review pass and unresolved gaps (if any).
- `office/CHANGE_LEDGER.md` records contract changes made to pass freeze criteria.

### Mandatory closure evidence register format
Stage 0A closure is valid only when the office surfaces above include a shared evidence register block using this exact schema:

- **gate name**
- **pass/fail**
- **exact file references**
- **unresolved contradiction list**
- **decision reference**
- **closure date**

#### Stage 0A closure evidence register template (required)
```md
### Stage 0A Closure Evidence Register

| gate name | pass/fail | exact file references | unresolved contradiction list | decision reference | closure date |
|---|---|---|---|---|---|
| [freeze criterion / gate name] | [pass\|fail] | [repo-path references] | [explicit list or `none`] | [e.g., D-0XX] | [YYYY-MM-DD] |
```

Completion is invalid if any schema field is omitted, vague, or replaced with narrative-only wording.

---

## Invalid completion patterns

Stage 0A is invalidly marked complete if:
- freeze items are implied but not file-linked
- MT5 coding started while any freeze item was unresolved
- HUD polish or menu work is used to claim contract readiness
- board/dossier/current-focus contracts are deferred to “later polish”
- settings/menu controls are left as ad hoc labels without runtime mapping and safety classes

---

## What Stage 0A makes newly admissible

Once Stage 0A exits with evidence, the following become admissible:
- Stage 1 implementation under frozen contracts
- dispatcher/governor implementation planning tied to frozen heartbeat/lane law
- board/dossier/current-focus runtime scaffolding that follows frozen write-discipline

What remains not admissible:
- HUD tactical polish ahead of structural truth landing
- reinterpretation of frozen contracts without explicit blueprint change

---

## Stage 0A closure runbook (auditable, non-optional)

This section makes closure execution operational rather than interpretive.

### Gate-to-owner mapping (must be checked explicitly)

| Freeze criterion | Canonical owner file(s) | Required evidence row signal |
|---|---|---|
| Heartbeat matrix freeze | `blueprint/final/ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`, `blueprint/final/ASC_HEARTBEAT_BREATHING_CONTRACT.md`, `blueprint/final/01_ASC_CORE_RUNTIME_LAWS.md` | Row shows `pass` only if scheduler-boundary vs execution-granularity contradictions are `none` and heartbeat cannot be reinterpreted as one tiny packet per beat. |
| Layer contract freeze | `blueprint/final/03_ASC_FIVE_LAYER_SYSTEM.md` + layer owner files 04–08 | Row lists exact owner files reviewed and unresolved contradiction list. |
| Publication matrix freeze | `blueprint/final/ASC_WRITE_TRIGGER_AND_PUBLICATION_MATRIX.md` | Row confirms trigger/guard/deny coherence with no unresolved conflicts. |
| Artifact lifecycle freeze | `blueprint/final/10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md`, `blueprint/final/12_ASC_ARTIFACT_SCHEMA_AND_VERSIONING.md` | Row confirms lifecycle + schema alignment and no synthetic-fill shortcuts. |
| HUD role matrix freeze | `blueprint/final/ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`, `blueprint/final/11_ASC_HUD_AND_OPERATOR_SURFACE.md`, `blueprint/final/ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md`, `blueprint/final/ASC_TACTICAL_REALTIME_FIELD_CONTRACT.md` | Row confirms HUD consumer-only posture, page hierarchy alignment, tactical cadence containment, and completion-bounded transaction law remain explicit. |
| Symbol-action scaffold freeze | `blueprint/final/ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md`, `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`, `blueprint/final/ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md` | Row confirms Deep Analysis-only advanced action, placeholder containment, page visibility non-authority, and no page-level contradiction against completion-bounded HUD ownership. |
| EA settings/menu contract freeze | `blueprint/final/ASC_MENU_AND_SETTINGS_CONTRACT.md` | Row confirms canonical path lock and no alternate owner path references. |
| Scope/admissibility freeze | `blueprint/final/ASC_SCOPE_BOUNDARY_AND_ADMISSIBILITY_MAP.md` | Row confirms present vs future boundaries remain explicit and unchanged. |

### Closure validity law

Stage 0A remains **fail** unless all are true in the same pass:
1. every criterion has a gate row,
2. pass/fail is explicit (no implicit pass wording),
3. unresolved contradiction is either explicit list or `none`,
4. office status + work log + change ledger are synchronized,
5. decision reference is present if doctrinal wording changed.

Stage 0A remains fail if scheduler pulse is still open to “one tiny packet per beat” reinterpretation or if HUD page law still uses fixed millisecond freeze budgets that contradict completion-bounded transaction ownership.
