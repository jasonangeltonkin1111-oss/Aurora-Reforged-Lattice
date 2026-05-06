# ASC Artifact Schema and Versioning

## Purpose

This document defines the canonical schema and versioning doctrine for Aurora Sentinel Scanner (ASC) artifacts.

The scanner does not become trustworthy merely because it writes files.
Artifacts must also say what they are, who owns them, when they were built, what upstream committed truth they depend on, whether they are fresh or continuity-backed, and whether they represent one coherent cycle or a mixed state assembled from different moments.

This file exists to make that metadata contract explicit.

---

## Core doctrine

### Schema-is-trust law
Artifact payloads are not enough.
Without schema and versioning discipline, two dangerous things happen:
- consumers cannot tell what they are reading
- mixed-cycle or stale outputs masquerade as current coherent truth

### Every artifact must declare itself
Every important ASC artifact must declare, in machine-readable form, at minimum:
- what family it belongs to
- who owns it
- what logical surface it represents
- when it was built
- what freshness posture it has
- what upstream committed states it depends on
- what continuity or degradation posture it carries

If an artifact cannot describe itself, it is not yet safe to trust.

### Versioning-is-lineage law
Versioning is not only about change over time.
In ASC it is primarily about lineage and coherence.
The system must be able to answer:
- which committed layer state produced this artifact
- whether this artifact reflects one coherent generation of truth
- whether this artifact reused last-good continuity
- whether this artifact is stale, degraded, partial, or blocked

### Mixed-cycle detection law
ASC must be able to detect and expose when an artifact is assembled from upstream states that do not belong to the same coherent generation.
A mixed-cycle artifact may still be useful in bounded cases, but it must not pretend to be fully current and cleanly unified.

### Family-sensitive schema law
Different artifact families may carry different payloads, but all important families must share a common schema spine for identity, freshness, lineage, and continuity posture.

---

## What schema/versioning owns

The schema/versioning system owns:
- canonical artifact identity fields
- family and owner fields
- schema version fields
- build/land timestamps
- upstream lineage references
- freshness posture fields
- completeness posture fields
- continuity and last-good markers
- mixed-cycle detection fields
- generation/coherence markers
- restore trust posture fields
- metadata rules for partial, pending, degraded, stale, and failed publication states

Schema/versioning owns the metadata contract.
It does not own scanner truth meaning.

---

## What schema/versioning does not own

Schema/versioning does not own:
- market-state rules
- packet truth rules
- filter rules
- shortlist rules
- deep-analysis rules
- HUD wording
- governor policy
- artifact-family ownership boundaries

If schema starts inventing runtime meaning, the architecture is drifting.

---

## Canonical metadata spine

Every important ASC artifact should expose a canonical metadata spine.
The exact encoding may vary later, but the logical fields must survive.

### 1. Artifact identity
These fields answer what this artifact is.

Canonical examples:
- `artifact_family`
- `artifact_kind`
- `artifact_name`
- `artifact_scope`
- `owner_layer` or `owner_system`
- `schema_version`

### 2. Build identity
These fields answer when and under what build event the artifact was created.

Canonical examples:
- `build_id`
- `commit_id`
- `build_started_at`
- `build_completed_at`
- `landed_at`
- `build_mode`

### 3. Freshness posture
These fields answer how current the artifact is.

Canonical examples:
- `freshness_state`
- `freshness_age_ms` or equivalent
- `last_refreshed_at`
- `stale_since`
- `fresh_until` where architecture uses bounded expiry posture

### 4. Completeness posture
These fields answer whether the artifact is whole, partial, blocked, or degraded.

Canonical examples:
- `completeness_state`
- `is_partial`
- `is_blocked`
- `is_degraded`
- `missing_components`

### 5. Continuity posture
These fields answer whether the artifact includes last-good or continuity-backed content.

Canonical examples:
- `uses_last_good`
- `last_good_source_id`
- `continuity_state`
- `continuity_reason`

### 6. Upstream lineage
These fields answer what committed upstream states were used.

Canonical examples:
- `upstream_refs`
- `upstream_layer_versions`
- `source_commit_ids`
- `source_landed_at`
- `dependency_set_id`

### 7. Coherence posture
These fields answer whether the artifact is a clean single-generation output or a mixed-cycle output.

Canonical examples:
- `coherence_state`
- `generation_id`
- `is_mixed_cycle`
- `mixed_cycle_reason`
- `coherence_notes`

### 8. Landing posture
These fields answer the persistence state of the artifact.

Canonical examples:
- `landing_state`
- `temp_written_at`
- `promoted_at`
- `last_landing_error`
- `retry_posture`

### 9. Restore posture
These fields answer how the artifact should be treated during recovery.

Canonical examples:
- `restore_trust_state`
- `requires_live_revalidation`
- `restore_notes`

---

## Canonical posture vocabularies

To keep artifact interpretation consistent, ASC should use a bounded set of posture vocabularies across families where possible.

### Freshness states
Suggested canonical posture set:
- `fresh`
- `aging`
- `stale`
- `pending_refresh`
- `degraded`
- `unknown`

### Completeness states
Suggested canonical posture set:
- `complete`
- `partial`
- `blocked`
- `degraded`
- `invalid`

### Continuity states
Suggested canonical posture set:
- `none`
- `last_good_assist`
- `continuity_backed`
- `continuity_only`
- `continuity_invalid`

### Coherence states
Suggested canonical posture set:
- `coherent`
- `mixed_cycle`
- `partial_cycle`
- `recovery_assembled`
- `unknown`

### Landing states
Suggested canonical posture set:
- `pending`
- `temp_written`
- `promoted`
- `failed`
- `retry_scheduled`
- `abandoned`

### Operator-facing value-state law
Engineering landing posture is not the same thing as long-lived operator wording.
Operator-facing artifact consumers such as HUD, Market Board, Current Focus, and dossier files at `Dossiers/<SYMBOL>.txt` must not freeze on indefinite `pending`, `reserved`, or `placeholder` labels.

Allowed operator-visible value states are:
- actual value
- not yet observed
- unavailable
- not applicable
- last confirmed value
- awaiting next refresh

If engineering posture is still in flight, consumer surfaces must translate that honestly into bounded operator wording rather than leaking permanent pending semantics.

### Operator-visible naming model (two-layer, mandatory)
ASC naming is two-layered and both layers must remain explicit:

1. **Internal schema layer**
   - Internal identifiers are allowed to remain technical for machine integrity.
   - Internal identifiers are internal-only schema examples and must not be rendered as operator-facing headings/titles/filenames.
   - Example allowed internal identifiers: `all_markets_top_10`, `artifact_family`, `shortlist_correlation_ready`.
2. **Operator-visible layer**
   - Operator-visible headings and filenames must be trader-safe and must not expose layer/stage/runtime jargon.
   - Operator surfaces must render only human-readable names.

Canonical operator-visible names:
- `Market Board`
- `Current Focus`
- `Dossiers/<SYMBOL>.txt`

Mandatory operator-visible board section headings:
- **Leading Three**
- **Full Five**
- **All-Markets Top Ten**
- **Account and Risk Snapshot**
- **Excluded / Already Active**

### Prohibited operator-visible heading vocabulary
The following must not appear in operator-visible headings/titles/filenames:
- layer/stage jargon: `Layer 1`, `Layer 2`, `Layer 3`, `Layer 4`, `Layer 5`, `Stage`, `Phase`, `Pipeline`
- internal runtime words: `runtime`, `telemetry`, `governor`, `artifact_family`, `schema_version`, `transport`, `hydration`, `packet`

This prohibition applies to operator-visible surfaces only; internal schema documentation may still use these terms where required.

### All-Markets Top 10 publication gate
`all_markets_top_10` may exist internally as a schema identifier, but operator-visible All-Markets Top 10 output must be shown only when Shortlist correlation readiness is true.

When candidate-summary correlation support readiness is unavailable, operator-visible output must withhold All-Markets Top 10 and include this exact failure-state line:
- `All-Markets Top 10 withheld: candidate-summary correlation support is unavailable.`

### Board artifacts schema contract (mandatory)
ASC board publication must be split into two separate artifacts:
- major-group board artifact (`Market Board`)
- sub-group board artifact (separate board output)

Both board artifacts must include mandatory section payloads with explicit section-level metadata.

Operator-visible section headings in those artifacts must use only the human-readable names defined above; schema keys remain internal-only and must not appear in rendered headings.

#### Mandatory board section payload fields
`account_and_risk_snapshot` fields (all required):
- `balance`
- `equity`
- `free_margin`
- `used_margin`
- `margin_level`
- `open_trades`
- `pending_orders`
- `open_risk_estimate`
- `exposure_note`

`excluded_or_already_active` row fields (all required):
- `symbol`
- `status`
- `direction`
- `entry`
- `stop`
- `target`
- `stop_size`

Optional field allowed for pending-order visual styling:
- `operator_style_label` (for example Unicorn-style label)

`operator_style_label` is optional and non-authoritative; `status` remains the required operational meaning field.

#### Mandatory section-level publication metadata
Board artifacts must track section-level metadata including:
- `section_name`
- `section_publication_state`
- `section_last_refreshed_at`
- `section_source_age_ms`
- `section_continuity_state`
- `section_failure_reason` (when applicable)

Required per-section behavior:
- selection sections refresh every board publish cycle
- account/risk snapshot refreshes every board publish cycle
- excluded/already-active refreshes every board publish cycle
- `all_markets_top_10` remains compact and correlation-gated, and is published only when shortlist correlation readiness is true

If correlation readiness is false, `all_markets_top_10` must be withheld with the exact canonical message already defined in this blueprint.

#### Operator naming validation rule (mandatory)
Validation must explicitly enforce that internal schema keys never appear in operator-facing headings, titles, or filenames.

At minimum, operator-facing outputs must reject heading/title/filename leakage of:
- `top_3_per_bucket`
- `top_5_per_bucket`
- `top_3_per_subgroup_bucket`
- `top_5_per_subgroup_bucket`
- `all_markets_top_10`
- `account_and_risk_snapshot`
- `excluded_or_already_active`

### Restore trust states
Suggested canonical posture set:
- `fresh_restore_safe`
- `stale_restore_visible`
- `continuity_restore_only`
- `requires_live_revalidation`
- `do_not_restore_as_current`

These are conceptual standards.
Implementation may refine names later, but the posture distinctions must survive.

---

## Artifact identity doctrine

### Family must be explicit
Every artifact must declare its family so consumers know whether they are reading:
- layer transport truth
- runtime telemetry
- recovery/continuity support
- human-readable composition
- HUD support
- audit/lineage surfaces

### Scope must be explicit
Artifacts must declare whether they are scoped to:
- one symbol
- one bucket
- the shortlist/promoted set
- whole-scanner posture
- one runtime mode/control surface

### Owner must be explicit
Artifacts must identify the owning layer or owner system.
Ownership ambiguity at the metadata layer is unacceptable.

---

## Build identity doctrine

### Build identity must outlive memory state
Every landed artifact should carry enough build identity to explain which build event produced it.
This matters for debugging, recovery, and mixed-cycle detection.

### Build identity must not be overloaded
One field should not try to represent every concept.
At minimum ASC should distinguish between:
- artifact-local build identity
- upstream dependency identity
- persistence landing identity

### Build timestamps must remain honest
The artifact should not blur:
- when data was computed
- when the artifact was staged
- when it was promoted to canonical visibility

Those may be close together, but they are not always the same event.

---

## Upstream lineage doctrine

### Why lineage matters
A consumer must be able to answer:
- which Layer 1 state this Layer 3 artifact depended on
- whether a Layer 4 shortlist used current Layer 3 survivors or older ones
- whether a human-readable summary is built from one coherent truth generation or several staggered ones

### Minimum lineage rule
Any artifact that depends on upstream structural truth must carry references to the committed upstream states it used.
These references should be stable enough to compare later.

### Lineage should prefer committed upstream states
References should usually point to committed upstream blocks, not transient in-memory states that vanish without trace.

---

## Coherence and generation doctrine

### Generation identity
Where architecture uses generation/grouping semantics, artifacts should carry a `generation_id` or equivalent that helps determine whether multiple surfaces belong to the same logical publication cycle.

### Coherent artifacts
An artifact is coherent when its upstream references satisfy the rules for a clean single-generation or otherwise architecture-approved build.

### Mixed-cycle artifacts
An artifact is mixed-cycle when it combines upstream states from materially different committed points in time without a rule that explicitly blesses that mixture.

Mixed-cycle does not always mean unusable.
It does mean the artifact must not silently present itself as a clean fresh whole.

### Partial-cycle artifacts
An artifact is partial-cycle when expected components are missing or blocked but the artifact is still intentionally published for bounded usefulness.

### Recovery-assembled artifacts
An artifact is recovery-assembled when it is composed during recovery using a blend of live and preserved continuity support.
This can be useful, but it must be clearly labeled.

---

## Completeness doctrine

### Completeness must be explicit
Consumers need to know whether an artifact is whole enough for their role.
An artifact that is present is not necessarily complete.

### Missing components must be inspectable
If an artifact is partial or blocked, it should expose which required components were unavailable or intentionally omitted.

### Completeness must not be inferred from file existence
Existence is not completeness.
A landed file can still be degraded, partial, stale, or mixed-cycle.

---

## Continuity doctrine

### Continuity is metadata, not just payload reuse
If an artifact reuses last-good or continuity-backed components, that fact must be explicit in metadata.
Consumers must not have to infer continuity from the values alone.

### Continuity must name its source
Where possible, continuity metadata should identify:
- which prior artifact or version provided continuity support
- why continuity was used
- whether continuity is assisting a mostly fresh artifact or dominating the whole artifact

### Continuity must not erase freshness truth
An artifact may be continuity-backed and still stale or degraded.
Those states must coexist honestly.

---

## Landing and promotion doctrine

### Staging and promotion are distinct events
Schema must preserve the distinction between:
- candidate/staged artifact state
- canonical promoted artifact state

### Consumers should normally trust promoted state
Consumers should usually bind to the canonical promoted surface, not to staging artifacts.

### Landing failure must remain visible
If staging or promotion failed, metadata must preserve enough signal that the system can explain:
- what failed
- whether prior committed truth remains visible
- whether retry is pending

---

## Restore doctrine

### Restore needs family-aware trust posture
Schema must help recovery logic decide whether an artifact can be:
- shown as fresh-enough structural truth
- shown only as stale continuity support
- restored only with visible revalidation requirement
- excluded from current-truth presentation

### Restore posture must not be guessed from age alone
Age matters, but family, continuity, and coherence posture matter too.
A very recent mixed-cycle artifact may still be unsafe to treat as clean current truth.

---

## Family-specific schema expectations

### Layer transport artifacts
Must strongly preserve:
- owner layer
- schema version
- freshness posture
- upstream lineage
- coherence state
- continuity markers where applicable
- landing state

### Runtime telemetry artifacts
Must strongly preserve:
- runtime owner/system
- mode/build time
- landing time
- freshness posture
- scope
- coherence posture where aggregation is involved

### Recovery/continuity artifacts
Must strongly preserve:
- continuity source
- restore trust posture
- last-known-good time
- revalidation requirement

### Human-readable artifacts
Must strongly preserve:
- source family references
- upstream lineage set
- coherence state
- freshness posture
- continuity markers if any derived section is continuity-backed

### HUD support artifacts
Must strongly preserve:
- structural source references
- freshness posture
- coherence state
- restore trust posture where used during recovery

### Audit/lineage artifacts
Must strongly preserve:
- version references
- change reason where assigned
- landing results
- linkage to the artifact(s) being audited

---

## Schema-version doctrine

### Schema version must be explicit
Every important artifact should declare its schema version.
This allows future migration, compatibility checks, and safer restore logic.

### Schema version changes must be intentional
A schema version should change because the artifact contract changed, not because the code happened to rebuild.

### Compatibility posture should be knowable
Where relevant, the system should be able to determine whether a consumer can still safely read an older schema version or whether migration/rebuild is required.

---

## Consumer doctrine

### Consumers must read metadata first
A consumer should not treat payload alone as sufficient.
Before trusting content, the consumer should be able to inspect:
- family
- owner
- freshness
- continuity
- coherence
- restore posture

### Consumers must not silently flatten posture
A UI or summary that strips away stale, degraded, partial, or mixed-cycle posture is unsafe.
Consumer friendliness must not erase truth.

### Consumer rules must be family-aware
What is acceptable for a human-readable summary may not be acceptable for a structural layer consumer.
The same metadata spine supports both, but trust thresholds differ by consumer role.

---

## Common failure patterns

### Pattern 1 — File exists, therefore trusted
The system assumes an artifact is trustworthy merely because it is present.

Result:
- stale or mixed outputs masquerade as current
- restore logic becomes reckless

### Pattern 2 — No lineage, no causality
Artifacts do not record what upstream committed truth they used.

Result:
- mixed-cycle bugs are hard to detect
- downstream trust becomes guesswork

### Pattern 3 — Freshness fraud through continuity
Last-good content is reused, but metadata fails to expose that clearly.

Result:
- continuity-backed artifacts look fully fresh
- operator and system trust erode

### Pattern 4 — Staged/promoted blur
The system cannot distinguish between staged candidate output and canonical landed output.

Result:
- consumers may bind to half-finished state
- publication integrity weakens

### Pattern 5 — Schema drift without versioning
Artifact shape changes over time but version metadata does not.

Result:
- restore/consumer failures become subtle
- compatibility breaks silently

---

## Implementation obligations

Any future MT5 implementation of ASC artifact schema/versioning must:
- give every important artifact a canonical metadata spine
- expose family, owner, scope, and schema version explicitly
- distinguish build time, landing time, and upstream lineage clearly
- preserve freshness, completeness, continuity, coherence, and restore posture as first-class metadata
- support mixed-cycle detection instead of assuming coherence
- preserve staging vs promoted landing distinction
- make last-good support explicit and source-linked where practical
- keep consumer trust family-aware
- refuse silent schema drift
- refuse payload-only trust shortcuts

If an implementation cannot explain whether an artifact is coherent, stale, continuity-backed, or mixed-cycle, that implementation is incomplete.

---

## Final standard

ASC artifact schema/versioning is correct when every important artifact can describe its identity, freshness, completeness, lineage, continuity, and coherence strongly enough that consumers do not need to guess what they are reading.

That means schema/versioning must be:
- identity-explicit
- lineage-aware
- freshness-honest
- continuity-explicit
- coherence-aware
- landing-aware
- restore-aware
- hostile to mixed-cycle fraud and silent schema drift

The standard is not that metadata exists.
The standard is that metadata is strong enough to protect trust across runtime, persistence, recovery, and operator consumption.
---

## Contract extension — Board/Dossier/Current Focus publication contract

### Required surface fields
For the Market Board, Dossier, and Current Focus artifacts, schema must include at minimum:
- `artifact_surface` (`market_board`, `dossier`, `current_focus`)
- `publication_state` (bounded to pending/fresh/stale/degraded/continuity/failure)
- `state_reason`
- `missing_components`
- `failure_visibility`


### Surface placement schema law
Schema validation must enforce strict surface placement boundaries for deep payloads:
- `market_board` surface must reject `deep_analysis.required_subsections`, OHLC bar arrays, tick window payloads, and rolling spread window payloads.
- `dossier` surface is the owning surface for full deep subsection payloads and mandatory minimum datasets.
- `current_focus` surface may include only compact deep outcome summaries and deep publication posture, not full deep subsection payload replicas.

If deep payload placement violates these boundaries, schema validation must fail with explicit placement reason metadata.

### Market Board schema requirements
Market Board payload must contain:
- `top_3_per_bucket` (required)
- `top_5_per_bucket` (required)
- `all_markets_top_10` (conditionally present)
- `correlation_readiness_state`
- `correlation_readiness_reason`

Enforcement:
- `all_markets_top_10` may be populated only when `correlation_readiness_state == ready`.
- Otherwise, it must be absent or empty with explicit gate reason.

### Dossier schema and lifecycle requirements
Dossier must be modeled as full symbol intelligence.
Dossier schema must include:
- `symbol`
- `intelligence_sections`
- `publication_state`
- `lifecycle_state`
- `failure_visibility`
- `missing_components`
- `continuity_posture`
- `section_contract_version`

Allowed lifecycle/publication states are exactly:
- `pending`
- `fresh`
- `stale`
- `degraded`
- `continuity`
- `failure`

#### Mandatory dossier section contract schema
Each dossier must include the following mandatory sections with explicit schema contracts:
1. `operator_snapshot`
2. `account_and_trade_context`
3. `selection`
4. `live_market`
5. `trading_conditions`
6. `classification`
7. `market_context`
8. `deep_analysis`
9. `aurora_signal_scaffold`, `semi_auto_scaffold`, `full_auto_scaffold`
10. `dossier_status_and_last_actions`

For every mandatory dossier section, schema must include:
- `section_name`
- `required_fields`
- `section_source_family`
- `section_publication_state`
- `section_state_reason`
- `section_source_age_ms`
- `section_continuity_state`
- `section_last_refreshed_at`
- `section_missing_components`
- `section_optional_fields`

#### Required field sets per mandatory dossier section
- `operator_snapshot.required_fields`:
  - `symbol`, `canonical_symbol`, `publish_time_utc`, `scanner_mode`, `dossier_publication_state`
- `account_and_trade_context.required_fields`:
  - `balance`, `equity`, `free_margin`, `used_margin`, `margin_level`, `open_trades`, `pending_orders`, `open_risk_estimate`, `exposure_note`
- `selection.required_fields`:
  - `selection_state`, `selection_reason`, `selection_rank`, `selection_bucket`, `correlation_score`, `correlation_top`, `correlation_high`, `correlation_low`, `correlation_conflict_interpretation`
  - correlation line is mandatory and must always include score + top/high/low + conflict interpretation
- `live_market.required_fields`:
  - `bid`, `ask`, `spread`, `spread_pct`, `tick_age_ms`, `market_status`, `market_status_reason`
- `trading_conditions.required_fields`:
  - `broker_spec_summary`, `min_stop_distance`, `lot_step`, `contract_size`, `trading_session_state`, `session_liquidity_posture`, `friction_classification`
- `classification.required_fields`:
  - `asset_class`, `group`, `subgroup`, `regime`, `classification_confidence`
- `market_context.required_fields`:
  - `day_open`, `day_high`, `day_low`, `prev_day_high`, `prev_day_low`, `vwap`, `atr`, `context_summary`
- `deep_analysis.required_subsections` (structured, not flat, exact order):
  - `deep_analysis_overview`, `timeframe_settings`, `bar_pack`, `ohlc_by_enabled_timeframe`, `bar_interpretation`, `recent_tick_activity`, `live_spread_rollover`, `preservation_state`, `microstructure_notes`, `advanced_context`, `decision_support`
- `deep_analysis.mandatory_data_minimums`:
  - `ohlc_by_enabled_timeframe` must include actual OHLC bars for each enabled timeframe
  - `bar_pack` must include bars-per-timeframe counts
  - `recent_tick_activity` must include `tick_window_minutes` with default `5`
  - `live_spread_rollover` must include `rolling_window_minutes` with minimum `1`
- `deep_analysis.preservation_contract`:
  - preserve valid rolling tick/spread recordings during partial or degraded deep refresh
  - fill missing deeper data without destructive rolling-state reset
  - must declare `reset_allowed_conditions` and `reset_forbidden_conditions`
- `aurora_signal_scaffold.required_fields`, `semi_auto_scaffold.required_fields`, `full_auto_scaffold.required_fields`:
  - `*_state`, `activation_guardrails`, `non_active_state_wording`
  - each scaffold is mandatory and must explicitly render non-active wording when inactive
- `dossier_status_and_last_actions.required_fields`:
  - `dossier_status`, `status_reason`, `last_actions`, `proof_lines`, `publication_state`, `last_successful_publish_at`

#### Source-family and failure-visibility rules
- `operator_snapshot`, scaffolds: Family 4 composition with dependencies on Family 1/2.
- `account_and_trade_context`: Family 2, continuity-backed by Family 3 where assigned.
- `selection`, `classification`, `market_context`, `deep_analysis`, `live_market`, `trading_conditions`: derived from Family 1 truth blocks with section-specific dependencies.
- `dossier_status_and_last_actions`: Family 6 audit/lineage rendered in Family 4.
- Any mandatory section failure must remain visible with `section_publication_state = failure` (or `degraded` where partial) and explicit missing component names.
- Optional fields may enrich sections but cannot replace or nullify required field sets.

### Current Focus single-file contract fields
Current Focus schema must include:
- `focus_symbol`
- `focus_switched_at`
- `replacement_mode` (`rewrite_single_file`)
- `artifact_path_kind` (`singleton_current_focus`)

Contract law:
- there is exactly one canonical Current Focus path.
- symbol switch triggers replacement write to the same canonical path.
- visible-surface discovery must not enumerate per-symbol focus files as active Current Focus.

### Operator-safe naming and banned filename schema checks
Visible-surface artifact registry/schema validation must enforce:
- operator-safe naming profile
- banned dev-language tokens are absent in canonical visible filenames

Minimum banned tokens:
- `tmp`, `test`, `debug`, `wip`, `draft`, `vnext`, `scratch`, `placeholder`, `new`, `old`, `final_final`

### Publication-state matrix normalization
All three surfaces (board, dossier, current focus) must normalize to the same publication-state matrix:
- `pending`
- `fresh`
- `stale`
- `degraded`
- `continuity`
- `failure`

No alternate operator-visible spellings are allowed in canonical artifacts.
