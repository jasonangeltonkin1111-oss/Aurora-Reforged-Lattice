# ASC Symbol Action Surface Contract

## Purpose

This contract defines the post-Deep-Analysis symbol action surface for Aurora Sentinel Scanner (ASC).

It exists to keep operator action flows lawful while ASC remains a five-layer truth engine with bounded HUD-triggered Deep Analysis.

This is a **contract file** and binds both final doctrine and roadmap staging.

---

## Binding status

This file is authoritative for symbol action surface behavior and must be read together with:
- `blueprint/final/08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md`
- `blueprint/final/11_ASC_HUD_AND_OPERATOR_SURFACE.md`
- `blueprint/roadmap/11_STAGE_9_HUD_AND_OPERATOR_SURFACE.md`

If implementation convenience conflicts with this contract, this contract wins until final blueprint files are explicitly revised.

---

## Present-state ownership law

ASC currently owns Layers 1 through 5 as live truth layers.

Layer 6 (Semi-Auto) and Layer 7 (Full Auto) are **scaffold-only** in the present doctrine:
- they are reserved as future design surfaces
- they are not active runtime ownership lanes now
- they must not be used to justify hidden automation in current ASC

Any implementation that treats Layer 6 or Layer 7 as active scanner-global control logic is invalid.

---

## Symbol-scoped action surface law

All operator actions after Deep Analysis must remain **symbol-scoped action surfaces**.

That means actions are admitted only for the selected symbol context and must not become:
- scanner-global automation loops
- background sweep executors
- implicit multi-symbol orchestration engines
- hidden strategy daemons attached to HUD visibility

Opening pages, selecting tabs, or viewing a symbol does not grant scanner-global action rights.

---


## Symbol action button matrix (present-state binding)

The HUD symbol action surface must implement the following button matrix with these exact columns and semantics.

| Button | Page location | Visibility condition | Enabled condition | Current behavior | Future behavior | Forbidden scopes |
|---|---|---|---|---|---|---|
| Deep Analysis | Symbol Overview quick actions; Symbol Aspect Detail quick actions | Selected symbol context is active on a symbol page and bridge provenance can be evaluated | Symbol is eligible, promoted/entitled posture is lawful, deep truth is not stale beyond allowed posture, and governor/mode posture allows trigger | **Only working advanced action now.** Analyse / Deep Analysis emits Layer 5 arm request for selected symbol context only (Layer 5 bridge path) | May remain entrypoint into later symbol-scoped post-analysis surfaces if doctrine is revised | Must never appear on Overview/Home, Main Groups, or Sub-Groups; must not create scanner-global side effects |
| Aurora Signal | Symbol Overview quick actions; Symbol Aspect Detail quick actions | Selected symbol context is active on a symbol page | Never enabled in present state | **Placeholder only (non-active).** Must display reserved/not-active wording and perform no runtime action | Reserved for future symbol-scoped action surface doctrine | Must never appear on Overview/Home, Main Groups, or Sub-Groups |
| Semi-Auto | Symbol Overview quick actions; Symbol Aspect Detail quick actions | Selected symbol context is active on a symbol page | Never enabled in present state | **Placeholder only (non-active).** Must display reserved/not-active wording and perform no runtime action | Reserved for future Layer 6-aligned doctrine after explicit blueprint activation | Must never appear on Overview/Home, Main Groups, or Sub-Groups |
| Full Auto | Symbol Overview quick actions; Symbol Aspect Detail quick actions | Selected symbol context is active on a symbol page | Never enabled in present state | **Placeholder only (non-active).** Must display reserved/not-active wording and perform no runtime action | Reserved for future Layer 7-aligned doctrine after explicit blueprint activation | Must never appear on Overview/Home, Main Groups, or Sub-Groups |

### Matrix interpretation law
- Symbol action buttons are **symbol-page-only controls**: they may render on Symbol Overview and Symbol Aspect Detail only.
- Symbol action buttons are forbidden on Overview/Home, Main Groups, and Sub-Groups.
- Deep Analysis is the only advanced action that may be enabled and executable in present doctrine.
- Aurora Signal, Semi-Auto, and Full Auto must remain explicit non-active placeholders until doctrine changes.

### Blocked/failure wording law (stale or ineligible symbol context)
When a symbol action is blocked, HUD wording must explicitly identify the block reason using operator-safe language.

Required blocked wording classes:
- **Visible but not promoted**: `Action unavailable: symbol is visible but not promoted for Deep Analysis.`
- **Promoted but stale/ineligible**: `Action unavailable: promoted symbol is stale or currently ineligible for Deep Analysis.`
- **Mode/governor blocked**: `Action unavailable: runtime mode/governor currently blocks this action.`
- **Unverified bridge provenance**: `Action unavailable: bridge provenance could not be validated.`
- **Stale context**: `Action unavailable: symbol context is stale; refresh structural/deep state.`
- **Ineligible context**: `Action unavailable: symbol is not eligible for this action.`

These blocked states must fail closed and must not silently fall through into background execution.

## Analyse button lifecycle (canonical)

The Analyse / Deep Analysis button lifecycle is ordered and mandatory:
1. selected symbol context verified
2. entitlement / promotion / provenance / mode posture checked
3. Layer 5 arm request emitted
4. HUD shows blocked/running/completed posture
5. Layer 5 output becomes available for downstream consumption after lawful completion/publication

Opening a symbol page or changing tabs must not silently arm Layer 5.

---

## Post-Deep-Analysis bridge semantics

### Bridge purpose
The bridge exists to hand off lawful outputs from Deep Analysis (Layer 5) into a symbol-scoped action surface.

### Required bridge inputs
A symbol-scoped action bridge input must include at least:
- symbol identity and scope key
- Deep Analysis provenance (artifact/reference id)
- freshness/staleness posture
- eligibility posture for action surface access
- governance/mode posture relevant to safe action display

### Required bridge outputs
The bridge may output only symbol-scoped surfaces such as:
- symbol action card/state for operator review
- symbol-specific readiness / blocked / ineligible posture
- symbol-scoped action intent payloads for explicit operator workflows
- symbol-scoped continuity posture (last-good vs current)

Bridge outputs must remain downstream of Layer 5 truth and must not mutate Layer 1-5 ownership boundaries.

### Eligibility law
Action surfaces are visible only when eligibility is explicit.

Eligibility must remain revocable and should fail closed when:
- deep truth is stale beyond allowed posture
- symbol is no longer lawfully entitled
- governor/mode posture disallows the action surface
- bridge provenance cannot be validated

No inferred entitlement is allowed.

---

## Shared bridge lifecycle table (canonical)

This is the **single canonical home** for the full bridge lifecycle table.

Binding references:
- `blueprint/final/08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md`
- `blueprint/final/ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md`
- `blueprint/final/ASC_MENU_AND_SETTINGS_CONTRACT.md`
- `blueprint/roadmap/09_STAGE_7_LAYER_5_DEEP_ANALYSIS.md`
- `blueprint/roadmap/11_STAGE_9_HUD_AND_OPERATOR_SURFACE.md`

Anti-duplication note: **If bridge table changes, only canonical source is edited.**

| Lifecycle step | Required checks | Current admissible behavior | Fail-closed / revocation behavior | Future-only note (non-admissible now) |
|---|---|---|---|---|
| 1) Deep Analysis output prerequisites | Symbol is currently promoted (Layer 4), explicit symbol-scoped trigger exists, deep artifact provenance id is present, freshness posture is explicit, governor/mode posture permits handoff | Deep Analysis may produce bridge-candidate output only for the selected admitted symbol | If any prerequisite is missing, output is marked `not_bridge_eligible` and no action-surface handoff payload is emitted | No scanner-global or multi-symbol prerequisite shortcuts are admissible |
| 2) Bridge eligibility checks and fail-closed behavior | Validate provenance, staleness bounds, entitlement state, and mode/governor posture in strict order | Bridge emits only symbol-scoped readiness/blocked/ineligible payloads after all checks pass | First failed gate blocks handoff with explicit reason (`stale`, `ineligible`, `unverified_provenance`, or `mode_blocked`); no background fallback execution | Future probabilistic/heuristic auto-unblock paths are reserved and non-admissible |
| 3) Placeholder-only behavior now (Aurora/Semi-Auto/Full-Auto) | Button/surface is symbol-page scoped and tied to selected symbol context only | Aurora Signal, Semi-Auto, and Full Auto remain visible placeholders with explicit `not active` wording and no runtime side effects | Any attempt to execute placeholder actions is rejected with explicit non-active message and no hidden queueing | Future activation requires explicit blueprint promotion of Layer 6/7 doctrine and revised contracts |
| 4) Revocation triggers (stale/ineligible/demotion/etc.) | Monitor for demotion, stale beyond bound, provenance invalidation, continuity expiry, or governor/mode disallow | Previously ready symbols may remain viewable only via bounded continuity posture when allowed | Active entitlement/bridge readiness is revoked immediately on trigger; jobs/tokens are canceled; output reclassified blocked or continuity-only | Future grace windows or soft-retry overlays are non-admissible until explicitly contracted |
| 5) Explicit future-only states | State is labeled as reserved and excluded from runtime dispatch | Documentation may name reserved states for planning clarity only | Reserved states must never map to executable menu controls, HUD execution paths, or runtime work-class rights | Examples: autonomous multi-symbol orchestration, Layer 7 workflow collapse, inferred bridge entitlement without explicit trigger |

## Future doctrine note (non-admissible now)

Layer 7 may later collapse separate post-analysis workflows into a more unified automation posture.

That is a **future doctrine possibility only**.
In present ASC ownership:
- no Layer 7 workflow collapse is active
- no roadmap stage may back-port that collapse into current implementation
- current behavior remains symbol-scoped and operator-explicit

---

## Invalid patterns

The following are explicitly invalid in present ASC doctrine:
- treating HUD focus as permission for scanner-global action loops
- auto-expanding one symbol action trigger to many symbols without explicit doctrine change
- skipping bridge eligibility checks because data "looks fresh"
- implementing Layer 6/7 behaviors as if they are already active ownership layers
- mixing symbol action outputs back into upstream layer truth ownership

---

## Stage 4 handoff-boundary addendum

The symbol action surface may expose the existence of the Layer 5 `siam_analyst_handoff` block, but it must preserve the downstream boundary.

### Hard law
- Deep Analysis may produce handoff direction fields only after lawful Layer 5 completion.
- The action surface must not reinterpret the handoff block into a final trade verdict.
- No button, badge, or quick-action summary may convert ASC handoff posture into buy / sell / execute ownership.

### Required product contract
Where the selected-symbol action surface references handoff readiness, it may show only:
- `analyst_readiness_state`
- `signal_interpretation_allowed`
- bounded constructive / danger / watch-next references
- degraded or unavailable posture

### Forbidden action-surface drift
The action surface must never show or imply:
- final trade verdict
- buy / sell command
- execution command
- final signal owner label inside ASC
- page-open or Current Focus presence as proof that Deep Analysis already completed
- Market Board depth or shortlist rank as a substitute for downstream signal interpretation

## Acceptance checklist

A symbol action implementation is contract-compliant only when all are true:
- Layer 6 and Layer 7 remain scaffold-only in runtime behavior
- every action surface is symbol-scoped and non-global
- post-Deep-Analysis bridge inputs/outputs are explicit and typed
- eligibility checks are explicit, auditable, and fail-closed
- future Layer 7 workflow collapse remains a note, not present behavior
