## Decision ID: D-100
### Date
2026-04-04
### Title
Control-surface one-job-per-file cleanup ownership reset
### Status
active

### Context
Root control surfaces carried duplicated law families, stale stage wording, and overlapping ownership across front-door/index/checklist/continuation/status files.

### Decision
1. `README.md` is front-door entry only.
2. `MASTER_INDEX.md` is navigation spine only.
3. `FRONT_DOOR_CHECKLIST.md` is hard go/no-go admissibility gate only.
4. `CHAT_CONTINUATION_GUIDE.md` is lightweight takeover workflow only.
5. `Aurora Sentinel Core/office/ROADMAP_STATUS.md` is the live program truth owner.
6. `Roadmap_Blueprint.md` remains detailed dossier recovery doctrine owner.
7. Compile-reachable active ownership remains precedence when stale wording conflicts.

### Consequences
- Redundant governance duplication across root control files is reduced.
- Stage/status truth is centralized into office live status.
- Entry path and control ownership are clearer and lower drift.

### References
- `README.md`
- `MASTER_INDEX.md`
- `FRONT_DOOR_CHECKLIST.md`
- `CHAT_CONTINUATION_GUIDE.md`
- `Aurora Sentinel Core/office/ROADMAP_STATUS.md`


## Decision ID: D-099
### Date
2026-04-03
### Title
Layer 1 Prompt 5 lock-in: compact observability and regression traps
### Status
active

### Context
After Prompt 1-4 landed behavior changes, runtime and office surfaces still needed explicit low-noise proof to detect regression quickly without heavy debug redesign.

### Decision
1. Layer 1 completion health must be surfaced through compact runtime counters/signals, not inferred from prose.
2. Dossier regression traps are explicit: missing-without-duty, cursor-stall, and missing-stall signals.
3. HUD cadence proof must include tactical-age/stall indicators while remaining consumer-only and low-noise.
4. Scanner Status and heartbeat detail are authoritative compact proof surfaces for Layer 1 completion posture.
5. Office control files must mirror landed Prompt 1-5 truth and remaining environment-limited validation risk without fantasy completion claims.

### Consequences
- Future regressions in dossier convergence and HUD cadence become visible faster from existing logs/artifacts.
- Runtime observability improves without adding heavy debug systems.
- Office/control truth remains aligned with actual landed code state.

### References
- `Aurora Sentinel Core/mt5/core/ASC_RuntimeState.mqh`
- `Aurora Sentinel Core/mt5/runtime/ASC_Dispatcher.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_ScannerStatusWriter.mqh`
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`


## Decision ID: D-092
### Date
2026-04-02
### Title
Phase 5 L3/L4 dossier summary family extraction
### Status
active

### Context
After L1/L2 projection extraction, the next bounded step is extracting Candidate Filtering and Shortlist Selection dossier summary areas without altering Layer 3/Layer 4 engine ownership.

### Decision
1. Candidate Filtering and Shortlist Selection subgroup renderers are extracted into dedicated dossier family files.
2. Composer calls these L3/L4 family files directly and remains sequence owner.
3. Writer remains compile-reachable compatibility entry and publish bridge.
4. Summary honesty wording (pass/fail/pending and unavailable/degraded posture) remains explicit and unchanged.
5. No Layer 3/Layer 4 engine redesign and no Deep Analysis family migration is authorized in this phase.

### Consequences
- Inline L3/L4 rendering ownership is removed from the central composer body for extracted groups.
- Visible dossier contract remains stable while L3/L4 family ownership is localized.
- Summary projection remains distinct from filter/shortlist engine authority.

### References
- `Aurora Sentinel Core/mt5/artifacts/dossier/candidate_filtering/ASC_DossierGateStatusSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/candidate_filtering/ASC_DossierSortingInputsSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/shortlist_selection/ASC_DossierShortlistCoreSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/shortlist_selection/ASC_DossierCorrelationExposureSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`

## Decision ID: D-091
### Date
2026-04-02
### Title
Phase 4 L1/L2 dossier projection family extraction
### Status
active

### Context
After Symbol Identity extraction, the next bounded migration step is moving L1/L2 read-only dossier projection areas into dedicated section families without changing visible contract or upstream truth ownership.

### Decision
1. Market State, Market Watch, Trading Conditions & Contract Specs, and Sessions/Swap/Margin subgroup renderers are extracted into dedicated dossier family files.
2. Composer calls these L1/L2 family files directly and remains sequence owner.
3. Writer remains compile-reachable compatibility entry and publish bridge.
4. Freshness/continuity/degraded/stale/unavailable posture wording remains explicit and unchanged.
5. No upstream engine redesign and no Layer 3/4/5 family migration is authorized in this phase.

### Consequences
- Inline L1/L2 rendering ownership is removed from the central composer body for extracted groups.
- Visible dossier contract remains stable while L1/L2 family ownership is localized.
- Projection-vs-engine ownership boundaries remain explicit.

### References
- `Aurora Sentinel Core/mt5/artifacts/dossier/market_state/ASC_DossierMarketStateCoreSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/market_watch/ASC_DossierQuoteSnapshotSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/trading_conditions_contract_specs/ASC_DossierPriceContractSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/sessions_swap_margin/ASC_DossierSessionsSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`

## Decision ID: D-090
### Date
2026-04-02
### Title
Phase 3 Symbol Identity dossier family extraction
### Status
active

### Context
After Phase 2 top-surface extraction, the next bounded migration step is extracting the full Symbol Identity area while preserving visible contract and authoritative classification hierarchy.

### Decision
1. Identity Core, Classification Authority, and Symbol Metadata are extracted into dedicated dossier section-family files under `mt5/artifacts/dossier/symbol_identity/`.
2. Composer calls the Symbol Identity section-family files directly and remains sequence owner.
3. Writer remains compile-reachable compatibility entry and publish bridge.
4. Advanced classification remains authoritative; broker descriptors remain supporting evidence only.
5. No classification-engine redesign, broker-source redesign, or broader section-family migration is authorized in this phase.

### Consequences
- Inline Symbol Identity rendering is removed from central composer body.
- Visible dossier contract is preserved while Symbol Identity ownership is localized.
- Classification authority hierarchy remains explicit and unchanged.

### References
- `Aurora Sentinel Core/mt5/artifacts/dossier/symbol_identity/ASC_DossierIdentityCoreSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/symbol_identity/ASC_DossierClassificationAuthoritySection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/symbol_identity/ASC_DossierSymbolMetadataSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`

## Decision ID: D-089
### Date
2026-04-02
### Title
Phase 2 top-surface dossier section-family extraction
### Status
active

### Context
After Phase 1 wrapper/composer/common split, the next bounded step is extracting only the top dossier sections to dedicated section-family files without changing visible contract or publication behavior.

### Decision
1. Top Header, Operator Snapshot, and Publication & Integrity are extracted into dedicated dossier section-family files under `mt5/artifacts/dossier/`.
2. Composer calls these section families directly and remains sequence owner.
3. Writer remains compile-reachable compatibility entry and publish bridge.
4. Publication mechanics, continuity/fallback semantics, and selected-symbol/current-focus compatibility remain unchanged in this phase.
5. Broader section-family migration (Identity, L1/L2, L3/L4, L5 families) remains explicitly deferred.

### Consequences
- Inline top-surface assembly is removed from the central composer body for these three blocks.
- Visible dossier contract remains stable while ownership boundaries improve.
- No hidden truth-owner shift is admitted in extracted top-section files.

### References
- `Aurora Sentinel Core/mt5/artifacts/dossier/top_header/ASC_DossierTopHeaderSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/operator_snapshot/ASC_DossierOperatorSnapshotSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/publication_integrity/ASC_DossierPublicationIntegritySection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`

## Decision ID: D-088
### Date
2026-04-02
### Title
Phase 1 dossier wrapper/composer/common ownership split
### Status
active

### Context
After Phase 0 contract freeze, dossier structure ownership had to move out of a monolithic writer while keeping compile-safe entry and publication behavior stable.

### Decision
1. `ASC_DossierWriter.mqh` remains compile-reachable and becomes a compatibility wrapper in progress (context + composer call + publish bridge).
2. `mt5/artifacts/dossier/ASC_DossierComposer.mqh` owns dossier sequencing/scaffold body order orchestration for the frozen visible contract.
3. `mt5/artifacts/dossier/ASC_DossierSectionCommon.mqh` owns shared presentation helpers (section/subgroup separators, label/value helper, section-status presentation helper).
4. No section-family folder migration, runtime redesign, or publication mechanics rewrite is authorized in this phase.

### Consequences
- Structure/order ownership is no longer centralized only in writer.
- Compile entry remains stable while migration preparation advances.
- Composer/common remain bounded and must not become hidden domain-truth owners.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierSectionCommon.mqh`
- `Aurora Sentinel Core/blueprint/final/03A_ASC_DOSSIER_LAYOUT_AND_COMPOSITION_LAW.md`

## Decision ID: D-087
### Date
2026-04-02
### Title
Phase 0 dossier contract freeze before folder ownership migration
### Status
active

### Context
Phase 0 is a bounded architecture-prep pass that must freeze dossier visible contract ownership outside ad hoc writer-body ordering before any composer/folder migration work.

### Decision
1. Canonical dossier section order, subgroup order, and field-label contract are frozen in dedicated MT5 dossier contract/scaffold files under `mt5/artifacts/dossier/`.
2. Normal dossier publish contract is frozen to the stable Deep Selective Analysis shell; heavy deep payload remains outside the normal dossier contract and is deferred to a later explicit shell/payload split phase.
3. A dedicated blueprint doctrine owner file (`blueprint/final/03A_ASC_DOSSIER_LAYOUT_AND_COMPOSITION_LAW.md`) now governs dossier layout ownership, composer boundaries, writer-thin target posture, and section-folder migration law.
4. This phase is architecture prep only; no runtime redesign, no composer extraction, and no broad dossier ownership migration is authorized.

### Consequences
- Later folder/composer migration can proceed against a frozen visible contract.
- `ASC_DossierWriter.mqh` remains compile-reachable and behaviorally stable while contract ownership is externalized.
- Ownership boundaries remain explicit: upstream engines keep truth ownership; dossier projection layers do not re-derive authoritative engine truth.

### References
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierContracts.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierScaffold.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/blueprint/final/03A_ASC_DOSSIER_LAYOUT_AND_COMPOSITION_LAW.md`

## Decision ID: D-086
### Date
2026-04-02
### Title
Dossier scaffold reset law: enforce canonical visible shell and suppress normal-path telemetry/payload clutter
### Status
active

### Context
The active Symbol Dossier visible surface drifted from canonical product contract via telemetry noise, extra non-canonical field blocks, and oversized Layer 5 payload rendering in the normal scaffold path.

### Decision
1. The canonical dossier scaffold in `03_ASC_DOSSIER_CANONICAL_PRODUCT_LAW.md` is the enforced visible contract for normal dossier publication.
2. Normal operator-facing dossier output must not render `Section Telemetry:` lines.
3. Layer 5 normal path must render canonical subgroup shell/field labels without heavy automatic evidence-block expansion.
4. Preserved/deferred/missingness posture must remain explicit and honest; no fake completeness is allowed.
5. This pass is bounded to writer-side scaffold cleanup and does not authorize runtime/layer-engine/HUD redesign.
6. Broad dossier module-layout redesign is intentionally deferred until scaffold stabilization is complete.

### Consequences
- Dossier visible product surface is reset to clean canonical structure.
- Layer 5 remains readable and bounded in normal publication path.
- Ownership boundaries remain intact (writer composes/project truth; engines remain truth owners).

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-085
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Recent Change Trace must render via dedicated section helper
### Status
active

### Context
Recent Change Trace projection remained inline in the monolithic dossier payload builder and did not follow the helper-based baby-step decomposition/telemetry pattern.

### Decision
1. Dossier baby step 33 scope is locked to `RECENT CHANGE TRACE` only.
2. Visible Recent Change Trace rendering must route through dedicated writer-side section helper.
3. Recent Change Trace must emit lightweight section telemetry using shared dossier section-status pattern, including owner-truth and transition-context availability posture in the section note.
4. Readability can be tightened only where operator clarity improves without changing the field labels or ownership boundaries.
5. Existing lawful state/selection/publication/deep transition strings may be projected; broader change-trace derivation/hydration remains explicitly deferred.
6. Broader dossier and transition-engine redesign work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Recent Change Trace subgroup.
- Operator surface is clearer and telemetry-backed without ownership drift.
- History/transition-engine redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-084
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Analyst / SIAM Handoff must render via dedicated section helper
### Status
active

### Context
Analyst / SIAM Handoff truth projection remained inline in the monolithic dossier payload builder and did not follow the helper-based baby-step decomposition/telemetry pattern.

### Decision
1. Dossier baby step 31 scope is locked to `DEEP SELECTIVE ANALYSIS [L5]` -> `Analyst / SIAM Handoff` only.
2. Visible Analyst / SIAM Handoff rendering must route through dedicated writer-side section helper.
3. Analyst / SIAM Handoff must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Existing lawful handoff context may be projected; broader Layer 5 handoff/synthesis hydration remains explicitly deferred where unavailable.
6. Broader Layer 5 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Analyst / SIAM Handoff subgroup in DEEP SELECTIVE ANALYSIS.
- Operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level synthesis/decision/SIAM redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-083
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Trade Framing Support must render via dedicated section helper
### Status
active

### Context
Trade Framing Support truth projection remained inline in the monolithic dossier payload builder and did not follow the helper-based baby-step decomposition/telemetry pattern.

### Decision
1. Dossier baby step 30 scope is locked to `DEEP SELECTIVE ANALYSIS [L5]` -> `Trade Framing Support` only.
2. Visible Trade Framing Support rendering must route through dedicated writer-side section helper.
3. Trade Framing Support must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Existing lawful packet/deep posture may be projected; broader trade-framing hydration remains explicitly deferred where unavailable.
6. Broader Layer 5 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Trade Framing Support subgroup in DEEP SELECTIVE ANALYSIS.
- Operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level directional/continuation/reversal/breakout/fade/invalidation redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-082
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Correlation & External Context must render via dedicated section helper
### Status
active

### Context
Correlation & External Context truth projection remained inline in the monolithic dossier payload builder and did not follow the helper-based baby-step decomposition/telemetry pattern.

### Decision
1. Dossier baby step 29 scope is locked to `DEEP SELECTIVE ANALYSIS [L5]` -> `Correlation & External Context` only.
2. Visible Correlation & External Context rendering must route through dedicated writer-side section helper.
3. Correlation & External Context must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Existing lawful packet/deep posture may be projected; broader external-correlation hydration remains explicitly deferred where unavailable.
6. Broader Layer 5 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Correlation & External Context subgroup in DEEP SELECTIVE ANALYSIS.
- Operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level cross-market/related-conflict/beta-proxy redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-081
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Regime & Context must render via dedicated section helper
### Status
active

### Context
Regime & Context truth projection remained inline in the monolithic dossier payload builder and did not follow the helper-based baby-step decomposition/telemetry pattern.

### Decision
1. Dossier baby step 28 scope is locked to `DEEP SELECTIVE ANALYSIS [L5]` -> `Regime & Context` only.
2. Visible Regime & Context rendering must route through dedicated writer-side section helper.
3. Regime & Context must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Existing lawful packet/session helper truth may be projected; broader regime/context hydration remains explicitly deferred where unavailable.
6. Broader Layer 5 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Regime & Context subgroup in DEEP SELECTIVE ANALYSIS.
- Operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level regime/volatility/liquidity/context-model redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-080
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Microstructure & Tick Context must render via dedicated section helper
### Status
active

### Context
Microstructure & Tick Context truth projection remained inline in the monolithic dossier payload builder and did not follow the helper-based baby-step decomposition/telemetry pattern.

### Decision
1. Dossier baby step 27 scope is locked to `DEEP SELECTIVE ANALYSIS [L5]` -> `Microstructure & Tick Context` only.
2. Visible Microstructure & Tick Context rendering must route through dedicated writer-side section helper.
3. Microstructure & Tick Context must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Existing lawful packet/deep-preserved context may be projected; non-hydrated microstructure model areas must remain explicitly deferred.
6. Broader Layer 5 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Microstructure & Tick Context subgroup in DEEP SELECTIVE ANALYSIS.
- Operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level tick/spread/execution-friction redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-079
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Price Map must render via dedicated section helper
### Status
active

### Context
Price Map truth projection remained inline in the monolithic dossier payload builder and did not follow the helper-based baby-step decomposition/telemetry pattern already used in adjacent sections.

### Decision
1. Dossier baby step 26 scope is locked to `DEEP SELECTIVE ANALYSIS [L5]` -> `Price Map` only.
2. Visible Price Map rendering must route through dedicated writer-side section helper.
3. Price Map must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Session range context may be projected from existing lawful packet truth (`day_high` / `day_low`) when available; non-hydrated map-model fields must remain explicitly deferred.
6. Broader Layer 5 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Price Map subgroup in DEEP SELECTIVE ANALYSIS.
- Price Map operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level support/resistance/zone/imbalance redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-078
### Date
2026-04-02
### Title
Dossier baby-step standard extension: OHLC Structure must render through dedicated section helper with grouped timeframe OHLC evidence
### Status
active

### Context
OHLC Structure truth projection was still inline/deferred in the monolithic dossier payload builder and did not visibly project grouped per-timeframe OHLC bars inside the section itself.

### Decision
1. Dossier baby step 25 scope is locked to `DEEP SELECTIVE ANALYSIS [L5]` -> `OHLC Structure` only.
2. Visible OHLC Structure rendering must route through dedicated writer-side section helper.
3. OHLC Structure must include grouped per-timeframe OHLC evidence projection (time + O/H/L/C + copied count) for enabled deep-analysis timeframes, with explicit missing/partial posture.
4. OHLC evidence depth remains configurable through existing deep timeframe controls; defaults are aligned to `350` for lower timeframes and `150` for higher timeframes.
5. OHLC Structure must emit lightweight section telemetry using shared dossier section-status pattern.
6. Broader Layer 5 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the OHLC Structure subgroup in DEEP SELECTIVE ANALYSIS.
- OHLC section is telemetry-backed and operator-readable with explicit evidence posture and no ownership drift into writer-side deep-model redesign.
- Engine-level structure-interpretation redesign and broader Layer 5 completeness remain explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/menu/ASC_TraderControlRegistry.mqh`
- `Aurora Sentinel Core/mt5/AuroraSentinelCore.mq5`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-077
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Timeframe Coverage must render via dedicated section helper
### Status
active

### Context
Timeframe Coverage truth projection remained explicit deferred placeholder posture and was still rendered inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 24 scope is locked to `DEEP SELECTIVE ANALYSIS [L5]` -> `Timeframe Coverage` only.
2. Visible Timeframe Coverage rendering must route through dedicated writer-side section helper.
3. Timeframe Coverage must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Broader Layer 5 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Timeframe Coverage subgroup in DEEP SELECTIVE ANALYSIS.
- Timeframe Coverage operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level deep/timeframe/bar/sufficiency redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-076
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Correlation & Exposure must render via dedicated section helper
### Status
active

### Context
Correlation & Exposure truth projection existed through shortlist correlation/exposure helper outputs, but visible rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 22 scope is locked to `SHORTLIST SELECTION [L4]` -> `Correlation & Exposure` only.
2. Visible Correlation & Exposure rendering must route through dedicated writer-side section helper.
3. Correlation & Exposure must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Broader Layer 4 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Correlation & Exposure subgroup in SHORTLIST SELECTION.
- Correlation & Exposure operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level correlation/exposure/portfolio-conflict redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-075
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Stability & Hold must render via dedicated section helper
### Status
active

### Context
Stability & Hold truth projection was mostly explicit unavailable/deferred posture with continuity text, but visible rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 21 scope is locked to `SHORTLIST SELECTION [L4]` -> `Stability & Hold` only.
2. Visible Stability & Hold rendering must route through dedicated writer-side section helper.
3. Stability & Hold must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Broader Layer 4 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Stability & Hold subgroup in SHORTLIST SELECTION.
- Stability & Hold operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level hold/continuity/replacement redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-074
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Shortlist Core must render via dedicated section helper
### Status
active

### Context
Shortlist Core truth projection existed from current shortlist owner fields, but visible rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 20 scope is locked to `SHORTLIST SELECTION [L4]` -> `Shortlist Core` only.
2. Visible Shortlist Core rendering must route through dedicated writer-side section helper.
3. Shortlist Core must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Broader Layer 4 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Shortlist Core subgroup in SHORTLIST SELECTION.
- Shortlist Core operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level shortlist/rank/score/promotion redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-073
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Candidate Filtering Sorting Inputs must render via dedicated section helper
### Status
active

### Context
Sorting Inputs truth projection existed from current candidate-filter owner gates and summary text, but visible rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 19 scope is locked to `CANDIDATE FILTERING [L3]` -> `Sorting Inputs` only.
2. Visible Sorting Inputs rendering must route through dedicated writer-side section helper.
3. Sorting Inputs must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Broader Layer 3 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Sorting Inputs subgroup in CANDIDATE FILTERING.
- Sorting Inputs operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level gate-derivation/ranking redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-072
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Candidate Filtering Blockers & Dependencies must render via dedicated section helper
### Status
active

### Context
Blockers & Dependencies truth projection existed from current candidate-filter owner fields, but visible rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 18 scope is locked to `CANDIDATE FILTERING [L3]` -> `Blockers & Dependencies` only.
2. Visible Blockers & Dependencies rendering must route through dedicated writer-side section helper.
3. Blockers & Dependencies must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Broader Layer 3 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Blockers & Dependencies subgroup in CANDIDATE FILTERING.
- Blockers & Dependencies operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level blocker/dependency/confirmation/next-step redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-071
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Candidate Filtering Gate Status must render via dedicated section helper
### Status
active

### Context
Gate Status truth projection existed from current filter/freshness/confidence sources, but visible Gate Status rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 17 scope is locked to `CANDIDATE FILTERING [L3]` -> `Gate Status` only.
2. Visible Gate Status rendering must route through dedicated writer-side section helper.
3. Gate Status must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Broader Layer 3 hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Gate Status subgroup in CANDIDATE FILTERING.
- Gate Status operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level candidate-filter/eligibility/freshness redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-070
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Margin subgroup must render via dedicated section helper
### Status
active

### Context
Margin truth projection was mostly explicit unavailable posture with small account-context notes, but visible Margin rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 16 scope is locked to `SESSIONS, SWAP & MARGIN [L2]` -> `Margin` only.
2. Visible Margin rendering must route through dedicated writer-side section helper.
3. Margin must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Broader margin hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across the Margin subgroup in SESSIONS, SWAP & MARGIN.
- Margin operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level margin sourcing/completeness redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-069
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Swap subgroup must render via dedicated section helper
### Status
active

### Context
Swap truth projection currently remains explicit unavailable/placeholder posture, but visible Swap rendering was inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 15 scope is locked to `SESSIONS, SWAP & MARGIN [L2]` -> `Swap` only.
2. Visible Swap rendering must route through dedicated writer-side section helper.
3. Swap must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Broader swap hydration/completeness work remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across another SESSIONS, SWAP & MARGIN visible subgroup.
- Swap operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level swap sourcing/completeness redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-068
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Sessions subgroup must render via dedicated section helper
### Status
active

### Context
Sessions truth projection already existed through Layer 1 state text, tradeability posture, and reason helpers, but visible rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 14 scope is locked to `SESSIONS, SWAP & MARGIN [L2]` -> `Sessions` only.
2. Visible Sessions rendering must route through dedicated writer-side section helper.
3. Sessions must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. Explicit session schedule hydration and broader session completeness work remain out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends into SESSIONS, SWAP & MARGIN visible subgroups.
- Sessions operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level session sourcing/completeness redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-067
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Trading Conditions / Volume Rules must render via dedicated section helper
### Status
active

### Context
Volume Rules truth projection already existed through Layer 2/spec fields and existing filter dependency notes, but visible rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 13 scope is locked to `TRADING CONDITIONS & CONTRACT SPECS [L2]` -> `Volume Rules` only.
2. Visible Volume Rules rendering must route through dedicated writer-side section helper.
3. Volume Rules must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. `Price & Contract`, `Trading Permissions`, and broader volume/spec completeness work remain out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across another TRADING CONDITIONS visible subgroup.
- Volume Rules operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level Layer 2 volume/spec completeness redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-066
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Trading Conditions / Trading Permissions must render via dedicated section helper
### Status
active

### Context
Trading Permissions truth projection already existed through Layer 2/spec fields and existing text helpers, but visible rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 12 scope is locked to `TRADING CONDITIONS & CONTRACT SPECS [L2]` -> `Trading Permissions` only.
2. Visible Trading Permissions rendering must route through dedicated writer-side section helper.
3. Trading Permissions must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. `Price & Contract`, `Volume Rules`, and broader permission/spec completeness work remain out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends across another TRADING CONDITIONS visible subgroup.
- Trading Permissions operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level Layer 2 permission/spec completeness redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-065
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Trading Conditions / Price & Contract must render via dedicated section helper
### Status
active

### Context
Price & Contract truth projection already existed through Layer 2 packet/spec fields and existing text helpers, but visible rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 11 scope is locked to `TRADING CONDITIONS & CONTRACT SPECS [L2]` -> `Price & Contract` only.
2. Visible Price & Contract rendering must route through dedicated writer-side section helper.
3. Price & Contract must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. `Trading Permissions`, `Volume Rules`, and broader contract/spec completeness work remain out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends into TRADING CONDITIONS & CONTRACT SPECS visible subgroups.
- Price & Contract operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level Layer 2/spec sourcing and contract completeness redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-064
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Market Watch / Volatility & Friction must render via dedicated section helper
### Status
active

### Context
Volatility & Friction truth projection already existed through Layer 2 packet values and ATR/regime/liquidity-friction summary helpers, but visible rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 10 scope is locked to `MARKET WATCH [L2]` -> `Volatility & Friction` only.
2. Visible Volatility & Friction rendering must route through dedicated writer-side section helper.
3. Volatility & Friction must emit lightweight section telemetry using shared dossier section-status pattern.
4. Readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. `Quote Snapshot`, `Day Structure`, and broader Layer 2/ATR/regime/friction behavior redesign remain out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends to another visible MARKET WATCH subgroup.
- Volatility & Friction operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level Layer 2/ATR/regime/friction/liquidity redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-063
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Market Watch / Quote Snapshot must render via dedicated section helper
### Status
active

### Context
Quote Snapshot truth projection already existed through Layer 2 packet fields and existing freshness/continuity helpers, but visible Quote Snapshot rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 9 scope is locked to `MARKET WATCH [L2]` -> `Quote Snapshot` only.
2. Visible Quote Snapshot rendering must route through dedicated writer-side section helper.
3. Quote Snapshot must emit lightweight section telemetry using shared dossier section-status pattern.
4. Quote Snapshot readability can be tightened only where operator clarity improves without changing field labels or ownership boundaries.
5. `Day Structure`, `Volatility & Friction`, and broader Layer 2 quote/watch model redesign remain out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends into MARKET WATCH visible subgroups.
- Quote Snapshot operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level Layer 2 quote/spread/freshness/continuity redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-062
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Market State / State Timing must render via dedicated section helper
### Status
active

### Context
State Timing truth projection already existed from Layer 1 timing/freshness/confidence helpers, but visible State Timing rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 8 scope is locked to `MARKET STATE [L1]` -> `State Timing` only.
2. Visible State Timing rendering must route through dedicated writer-side section helper.
3. State Timing must emit lightweight section telemetry using shared dossier section-status pattern.
4. Stale/degraded freshness and confidence availability posture must remain explicit.
5. Broader Layer 1 timing/scheduler/freshness redesign remains out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now covers the main visible MARKET STATE subgroups.
- State Timing operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level timing/freshness model redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-061
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Market State / State Core must render via dedicated section helper
### Status
active

### Context
State Core truth projection already existed through Layer 1 operator-text and filter posture helpers, but visible State Core rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 7 scope is locked to `MARKET STATE [L1]` -> `State Core` only.
2. Visible State Core rendering must route through dedicated writer-side section helper.
3. State Core must emit lightweight section telemetry using shared dossier section-status pattern.
4. Uncertain/degraded posture must remain explicit and not be cosmetically softened.
5. `State Timing` and broader Layer 1/filter behavior redesign remain out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now extends into MARKET STATE visible subgroups.
- State Core operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level Layer 1/tradeability redesign remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-060
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Symbol Identity / Symbol Metadata must render via dedicated section helper
### Status
active

### Context
Symbol Metadata truth assembly already existed in `ASC_BuildDossierSymbolMetadata(...)`, but visible Symbol Metadata rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 6 scope is locked to `SYMBOL IDENTITY [L0]` -> `Symbol Metadata` only.
2. Visible Symbol Metadata rendering must route through dedicated writer-side section helper.
3. Symbol Metadata must emit lightweight section telemetry using shared dossier section-status pattern.
4. Metadata sparse/unavailable posture must remain explicit; no cosmetic completeness inflation.
5. Broker/source completeness and symbol-spec sourcing redesign remain out of scope for this pass.

### Consequences
- Baby-step decomposition pattern now covers all visible Symbol Identity subgroups.
- Symbol Metadata operator surface is clearer and telemetry-backed without ownership drift.
- Metadata collection/sourcing improvements remain explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-059
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Symbol Identity / Classification Authority must render via dedicated section helper
### Status
active

### Context
Classification Authority truth assembly already existed in `ASC_BuildDossierClassificationAuthority(...)`, but visible Classification Authority rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 5 scope is locked to `SYMBOL IDENTITY [L0]` -> `Classification Authority` only.
2. Visible Classification Authority rendering must route through dedicated writer-side section helper.
3. Classification Authority must emit lightweight section telemetry using shared dossier section-status pattern.
4. Doctrine boundary remains explicit: advanced classification authoritative; broker metadata supporting only.
5. Classification engine matching, row cleanup, and broker sourcing remain out of scope for this pass.

### Consequences
- Baby-step decomposition pattern is now repeated across Symbol Identity visible subgroups.
- Classification Authority operator surface is clearer and telemetry-backed without ownership drift.
- Engine-level classification improvement work remains explicitly deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-058
### Date
2026-04-02
### Title
Dossier baby-step standard extension: Symbol Identity / Identity Core must render via dedicated section helper
### Status
active

### Context
Identity Core truth assembly already existed in `ASC_BuildDossierIdentityCore(...)`, but visible Identity Core rendering remained inline in the monolithic dossier payload builder.

### Decision
1. Dossier baby step 4 scope is locked to `SYMBOL IDENTITY [L0]` -> `Identity Core` only.
2. Visible Identity Core rendering must route through dedicated writer-side section helper.
3. Identity Core must emit lightweight section telemetry using shared dossier section-status pattern.
4. Partial/unresolved identity posture must remain explicit; no cosmetic over-claiming.
5. Classification Authority and Symbol Metadata remain deferred in this pass.

### Consequences
- Baby-step decomposition pattern is now repeated across identity surface work.
- Identity Core operator surface is clearer and telemetry-backed without ownership drift.
- Remaining Symbol Identity subgroups stay intentionally deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-057
### Date
2026-04-01
### Title
Dossier baby-step standard extension: Publication & Integrity rendering must be sectionized with honest compact telemetry
### Status
active

### Context
Publication/integrity truth projection already existed in a dedicated helper, but visible section rendering remained inline in the monolithic dossier builder.

### Decision
1. Dossier baby step 3 scope is locked to the visible PUBLICATION & INTEGRITY subgroup only.
2. Visible rendering for PUBLICATION & INTEGRITY must route through a dedicated writer-side section builder.
3. This section must emit lightweight section telemetry using shared dossier section-status pattern.
4. Wording cleanup is allowed only where it improves operator clarity while preserving degraded/continuity honesty.
5. Publication engine behavior (temp/validate/promote orchestration) remains out of scope for this pass.

### Consequences
- Baby-step modularization pattern is now landed across three dossier visible groups.
- Publication-sensitive operator surface is clearer without moving ownership.
- Remaining dossier groups stay intentionally deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-056
### Date
2026-04-01
### Title
Dossier baby-step standard extension: Operator Snapshot must use dedicated section builder + compact telemetry
### Status
active

### Context
Dossier baby step 1 established header extraction pattern. Operator Snapshot remained inline-rendered in the monolithic payload assembly even though its truth inputs were already helper-built.

### Decision
1. Dossier baby step 2 scope is locked to OPERATOR SNAPSHOT visible subgroup only.
2. OPERATOR SNAPSHOT rendering must be emitted via dedicated writer-side section builder, not inline raw concatenation in the monolith.
3. Operator Snapshot must emit lightweight section telemetry using the shared dossier section-status pattern.
4. Wording cleanup is allowed only for trader readability and compactness; upstream truth ownership remains unchanged.
5. Non-Operator-Snapshot dossier sections remain explicitly deferred.

### Consequences
- Later dossier baby steps now have a repeated extraction/telemetry template across two visible groups.
- OPERATOR SNAPSHOT readability improves without engine leakage.
- Completion posture remains truthful and bounded.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-055
### Date
2026-04-01
### Title
Dossier baby-step standard lock: header-only extraction with lightweight section telemetry
### Status
active

### Context
The canonical dossier builder remained monolithic, with top header fields assembled inline. The first dossier baby step needed to prove a bounded extraction pattern without widening into engine logic or broad dossier rewrites.

### Decision
1. Dossier baby step 1 scope is locked to the top header block only (`Generated` through `Deep Analysis Status`).
2. Header composition must route through a dedicated writer-side section builder path, not inline raw assembly in the monolithic body builder.
3. A lightweight reusable section-status telemetry structure is required for extracted sections (ran/posture/populated/missing/continuity/note).
4. Operator-facing header value wording may be tightened for clarity, but no upstream truth ownership may move into writer logic.
5. Remaining dossier sections are explicitly deferred and must not be claimed complete by this pass.

### Consequences
- Future dossier baby steps now have a concrete extraction/telemetry template.
- Header modularization is landed without engine-side ownership drift.
- Dossier completion posture remains truthful: only header block hardened in this pass.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`
- `Aurora Sentinel Core/office/CHANGE_LEDGER.md`

## Decision ID: D-054
### Date
2026-04-01
### Title
Post-doctrine hardening lock: publication temp-readback validation and dossier skip-evidence accounting
### Status
active

### Context
The first runtime hardening audit found a high-risk contradiction: publication followed temp write + token precheck, but did not explicitly validate temp payload readback before promote in single/pair publish paths. Write-lane evidence also did not expose skipped dossier counts.

### Decision
1. Publication write paths must validate temp payload readback before promote for single and pair publication operations.
2. Write-lane bundle evidence must include dossier skipped counts alongside attempted/success/failure.
3. Operator-facing visible wording should avoid `packet` phrasing in HUD/dossier surfaces where `market-watch snapshot` is the doctrine-aligned term.
4. This decision is bounded hardening only and does not claim full dossier/HUD/classification completion.

### Consequences
- Publication integrity posture is stricter and easier to prove.
- Artifact bundle evidence is more complete for deferred/filtered dossier behavior.
- Operator-surface language drift is reduced without moving ownership boundaries.

### References
- `Aurora Sentinel Core/mt5/io/ASC_FileIO.mqh`
- `Aurora Sentinel Core/mt5/runtime/ASC_Dispatcher.mqh`
- `Aurora Sentinel Core/mt5/core/ASC_RuntimeState.mqh`
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`

## Decision ID: D-053
### Date
2026-04-01
### Title
ASC_CORE doctrine is now the integrated blueprint/office control source for runtime/data/dossier/publication/HUD/logging law
### Status
active

### Context
`Aurora Sentinel Core/ASC_CORE.MD` contained the full doctrine stack but active split owner files and office/front-door control surfaces were not fully synchronized to that source in one pass.

### Decision
1. `ASC_CORE.MD` remains source doctrine authority for this stack and is now landed into active split owner files under `Aurora Sentinel Core/blueprint/final/` and `Aurora Sentinel Core/blueprint/roadmap/`.
2. The active doctrine files for this integrated stack are:
   - `01_ASC_CORE_RUNTIME_LAWS.md`
   - `02_ASC_DATA_OWNERSHIP_AND_CANONICAL_FIELD_CONTRACT.md`
   - `03_ASC_DOSSIER_CANONICAL_PRODUCT_LAW.md`
   - `04_ASC_PUBLICATION_CONTINUITY_AND_INTEGRITY_LAW.md`
   - `05_ASC_HUD_MARKET_BOARD_CURRENT_FOCUS_AND_OPERATOR_SURFACES.md`
   - `06_ASC_LOGGING_AND_VALIDATION_EVIDENCE_LAW.md`
   - `ASC_SYSTEM_RECOVERY_AND_PRODUCT_HARDENING_ROADMAP.md`
3. This decision is blueprint/control-only and does not claim MT5/runtime implementation completion.
4. MT5/runtime/HUD behavior edits remain deferred to later implementation passes under existing stage law.

### Why
This locks one coherent doctrine source into active owner files and office control truth, reducing duplicate-canon drift and making later implementation passes explicit about what is already doctrinally fixed vs what is still code work.

### Consequences
- Doctrine control strength increases without widening runtime risk.
- Office/front-door truth now explicitly records blueprint-only integration posture.
- Future implementation passes must not treat this decision as runtime completion evidence.

### References
- `Aurora Sentinel Core/ASC_CORE.MD`
- `Aurora Sentinel Core/blueprint/final/01_ASC_CORE_RUNTIME_LAWS.md`
- `Aurora Sentinel Core/blueprint/final/02_ASC_DATA_OWNERSHIP_AND_CANONICAL_FIELD_CONTRACT.md`
- `Aurora Sentinel Core/blueprint/final/03_ASC_DOSSIER_CANONICAL_PRODUCT_LAW.md`
- `Aurora Sentinel Core/blueprint/final/04_ASC_PUBLICATION_CONTINUITY_AND_INTEGRITY_LAW.md`
- `Aurora Sentinel Core/blueprint/final/05_ASC_HUD_MARKET_BOARD_CURRENT_FOCUS_AND_OPERATOR_SURFACES.md`
- `Aurora Sentinel Core/blueprint/final/06_ASC_LOGGING_AND_VALIDATION_EVIDENCE_LAW.md`
- `Aurora Sentinel Core/blueprint/roadmap/ASC_SYSTEM_RECOVERY_AND_PRODUCT_HARDENING_ROADMAP.md`

## Decision ID: D-052
### Date
2026-04-01
### Title
Phase 0 live-recovery freeze — active compile/runtime truth override and owner-chain lock
### Status
active

### Context
The repo front door was blueprint-complete, but it did not yet state the verified active compile root, the verified runtime owner chain, the inactive duplicate tree risk, or the current regression battlefield clearly enough for disciplined MT5 recovery. That created real drift risk: future passes could start from doctrine wording, HUD wording, or duplicate paths instead of the live runtime chain.

### Decision
Office freezes the following as current recovery-control truth:
1. **Active compile/runtime truth**
   - The verified active compile root is `mt5/AuroraSentinelCore.mq5`.
   - The verified heartbeat/write owner is `mt5/runtime/ASC_Dispatcher.mqh`.
   - The verified bootstrap owner is `mt5/runtime/ASC_Bootstrap.mqh`.
   - The verified HUD owner is consumer-only `mt5/hud/ASC_HUD_Manager.mqh`.
2. **Owner-chain lock**
   - Scanner/state owners are the active Layer 1–5 MT5 modules under `mt5/`.
   - Publication orchestration is dispatcher-owned.
   - Atomic publish/promote is `mt5/io/ASC_FileIO.mqh`.
   - Selected-symbol synchronization is dispatcher-owned; HUD may observe/request but may not own selected-symbol truth.
3. **Duplicate-tree exclusion**
   - `mt5/mt5/` is currently an inactive duplicate tree for recovery purposes because it is not in the verified include graph of the active compile root.
   - No recovery pass may patch `mt5/mt5/` unless the live compile graph is re-proven.
4. **Regression baseline**
   - The current evidence-backed regression window is 2026-03-26 through 2026-03-30, with the highest-risk cluster on 2026-03-30 around HUD cadence, dossier continuation, Current Focus sync, Layer 2 consumer alignment, and Deep trigger status.
5. **Recovery override rule**
   - During live MT5 recovery, verified active code/runtime ownership is primary truth.
   - Blueprint, office, and front-door wording remain support truth and must be corrected when they drift from verified active runtime ownership.

### Consequences
- future recovery workers can identify the live MT5 battlefield quickly
- duplicate-tree drift is explicitly blocked
- HUD consumer-only law and single selected-symbol ownership are now operationally pinned to active runtime evidence
- later phases can verify progress against one named regression baseline and one named proof pack

## Decision ID: D-051
### Date
2026-04-01
### Title
Stage 6 closure — front-door, continuation, control-stack, and implementation-next hardening
### Status
active

### Context
Stage 5 consolidated doctrine across blueprint, office, and front-door surfaces, but future chats could still resume unsafely unless the repo entry surfaces clearly closed the blueprint program, stated what ASC is and is not, and made implementation-next guidance explicit.

### Decision
Office freezes the following as current repo-control truth:
1. **Blueprint-program closure**
   - Stages 1–6 of the blueprint upgrade are complete.
   - The blueprint program is closed for normal implementation work.
   - Closing the blueprint program does not claim runtime implementation completion.
2. **Front-door reading order**
   - Future chats must enter through `README.md`, `MASTER_INDEX.md`, `CHAT_CONTINUATION_GUIDE.md`, `FRONT_DOOR_CHECKLIST.md`, and the `office/` truth files before opening implementation work.
   - `blueprint/final/ASC_CANONICAL_PRODUCT_SPINE.md` is the compact implementation owner map after front-door reading.
3. **What ASC is and is not**
   - ASC remains scanner-truth authority only.
   - ASC is not the final signal engine, execution engine, or hidden owner of directional trade calls through artifacts, rank, HUD, or settings.
   - SIAM / Aurora remains downstream interpretation authority.
4. **Implementation-next lock**
   - Next lawful work is runtime/menu landing, Layer 5 payload landing, and runtime proof against the frozen doctrine.
   - Future passes must not casually reopen ownership, artifact roles, menu powers, or scope boundaries unless a real contradiction is found and an explicit doctrine pass is admitted.
5. **Anti-drift lock at the front door**
   - The repo entry surfaces must explicitly warn against Layer 3 directional drift, Layer 4 best-trade drift, Layer 5 universe creep, Market Board signal-dashboard drift, Current Focus auto-deep misreadings, menu/settings backdoors, and consumer surfaces becoming hidden truth owners.

### Consequences
- future chats can resume safely without re-deriving architecture from buried context
- front-door files, office truth, and implementation-next guidance now tell one coherent story
- the repo now distinguishes blueprint-complete, implementation-pending, and verification/proof-pending explicitly

## Decision ID: D-050
### Date
2026-04-01
### Title
Stage 5 doctrine freeze — blueprint consolidation, authority-order lock, and anti-drift hardening
### Status
active

### Context
Stages 1–4 froze ownership, artifact roles, control doctrine, and layer field contracts, but future chats could still drift because the repo entry surfaces and overlapping doctrine files did not yet read as one fully consolidated system.

### Decision
Office freezes the following as current doctrine authority:
1. **Authority order**
   - `blueprint/final/` owner contracts are the canonical doctrine source.
   - `blueprint/roadmap/` governs implementation sequencing and admission gates.
   - `office/` records current stage/status truth and evidence-backed decisions.
   - root front-door docs guide re-entry only and do not override owner contracts.
   - archives remain evidence-only.
2. **Cross-file doctrine lock**
   - ASC remains the truth producer and never owns the final trade signal.
   - SIAM / Aurora remains downstream interpretation authority.
   - Layer 3 is gate-only and direction-neutral.
   - Layer 4 rank is attention priority, not best-trade superiority.
   - Layer 5 is promoted-only deep evidence and ends in bounded analyst / SIAM handoff.
   - Market Board stops at Layer 4 depth.
   - Dossier is the full per-symbol intelligence artifact.
   - Current Focus is the singleton selected-symbol working artifact and does not imply automatic Deep Analysis completion.
   - menu/settings may not become a signal-engine backdoor.
3. **Next-step lock**
   - The blueprint foundation is now consolidated through Stage 5.
   - Next lawful work is implementation, schema landing, verification, and runtime/menu alignment against the frozen doctrine stack.
   - Future passes must not casually reopen ownership or role boundaries without an explicit doctrine pass.

### Consequences
- future chats can continue safely from the root/front-door surfaces without re-deriving architecture from scattered files
- invalid-design doctrine now has stronger direct blockers against hidden signal drift
- office status can now separate doctrine completion from implementation completion cleanly

## Decision ID: D-049
### Date
2026-04-01
### Title
Stage 4 doctrine freeze — completed layer field contracts and bounded ASC → SIAM handoff
### Status
active

### Context
Stage 1 froze scanner truth ownership vs downstream SIAM interpretation ownership.
Stage 2 froze Market Board, Dossier, and Current Focus role separation.
Stage 3 froze the trader-control surface for lawful Deep Analysis configuration.
The remaining drift risk was field ambiguity: the repo still described what each layer generally does, but not yet the exact required field contracts, mandatory-vs-optional split, or the final handoff block that ends Layer 5 without turning ASC into a signal engine.

### Decision
Office freezes the following as current doctrine authority:
1. **Layer 1–4 required field law**
   - Layer 1 must publish market-state classification, freshness, confidence, recheck posture, and degraded / uncertain posture.
   - Layer 2 must publish quote packet, spread %, tick age, packet continuity, day-range, and tradability posture.
   - Layer 3 must publish `eligibility_state`, `eligibility_code`, `eligibility_reason`, `block_type`, `retry_posture`, diagnostic failures, survivor bucket, and next useful step.
   - Layer 4 must publish `selection_state`, attention-priority rank framing, shortlist reason, promotion basis or denial posture, hold / churn posture, exposure context, and shortlist freshness / stability posture.
2. **Layer 5 subsection law**
   - Layer 5 must publish the ordered 12-part subsection model ending in `siam_analyst_handoff`.
   - A lawful deep block requires explicit timeframe completeness, OHLC visibility doctrine, tick/spread sufficiency posture, preservation / reset metadata, and honest partial / degraded / continuity / unavailable posture.
3. **Observed vs interpreted truth law**
   - Raw evidence such as OHLC, ATR, spread, tick, and levels must remain distinguishable from bounded interpretations such as compression, expansion, alignment, conflict, invalidation posture, and scenario posture.
4. **Final handoff boundary**
   - ASC may hand SIAM / analyst directional posture, alignment posture, volatility posture, friction posture, invalidation / constructive / danger / watch-next references, and analyst-readiness posture.
   - ASC must not issue the final trade verdict, buy / sell command, execution command, or final signal ownership.

### Consequences
- later implementation work now has one explicit schema target for all five layers
- consumer artifacts can no longer hide mandatory layer fields behind compact output modes
- later signal-engine work, if ever admitted, must occur downstream of ASC rather than being smuggled into Layer 5 or symbol action surfaces

## Decision ID: D-048
### Date
2026-04-01
### Title
Stage 3 control doctrine freeze — menu/settings law, Deep Analysis configuration law, and forbidden menu powers
### Status
active

### Context
Stage 1 froze scanner truth ownership vs downstream SIAM interpretation ownership.
Stage 2 froze Market Board, Dossier, and Current Focus role separation.
The remaining drift risk was the menu/settings surface: without a complete control doctrine, future work could still blur trader convenience, Layer 5 service configuration, artifact output projection, and hidden signal-engine behavior.

### Decision
Office freezes the following as current doctrine authority:
1. **Canonical section model**
   - Menu/settings sections are locked to HUD & Display, Market Board, Current Focus, Dossier, Market State, Open Symbol Snapshot, Selection Filter, Shortlist Context, Deep Analysis, Advanced Controls, and Reserved / Future Scaffolds.
   - Future work must not invent parallel section families without blueprint update.
2. **Deep Analysis service controls**
   - Trader controls may configure canonical timeframe enablement only for `M1`, `M5`, `M15`, `H1`, `H4`, and `D1`.
   - Trader controls may configure bars requested per enabled timeframe, but completeness must remain inspectable through requested / minimum required / copied / missing / sufficiency posture fields.
   - ATR, spread, and tick controls are lawful Layer 5 evidence controls only.
3. **Analyst-facing output controls**
   - Output modes such as compact brief vs full evidence pack are lawful consumer controls.
   - Optional visibility controls may govern OHLC, ATR, spread, tick, support/resistance, scenario, and handoff blocks.
   - These controls must not manufacture new truth or suppress mandatory freshness/completeness metadata.
4. **Forbidden menu powers**
   - Menu/settings must never directly control final trade direction, signal issuance, execution verdicts, order placement logic, hidden shortlist authority, hidden signal-quality scoring, or unauthorized ownership jumps.
5. **Tier distinction**
   - Hard law, required product contract, and future expansion option are explicit for Stage 3 control doctrine.
   - Stage 3 completion in this pass is doctrinal only; it does not claim runtime code completion.

### Consequences
- Blueprint control files, Layer 5 doctrine, persistence doctrine, HUD/operator-surface wording, symbol-information spine wording, scope/admissibility wording, root/index/continuation files, and office truth must remain synchronized with this control doctrine.
- Later implementation may operationalize these controls, but may not reopen the ownership boundaries without a new doctrine pass.

---

## Decision ID: D-047
### Date
2026-04-01
### Title
Stage 2 artifact doctrine freeze — Market Board, Dossier, and Current Focus role completion
### Status
active

### Context
Stage 1 froze scanner truth ownership vs downstream SIAM interpretation ownership, but the operator-artifact layer was still vulnerable to drift.
Future work on schemas, HUD wording, and menu/settings could still blur the roles of Market Board, Dossier, and Current Focus.

### Decision
Office freezes the following as current doctrine authority:
1. **Market Board role**
   - Market Board is the compact board of what deserves inspection now.
   - It exists for inspection priority, shortlist visibility, passed-filter visibility, overlap awareness, and low-overlap next-look workflow.
   - It stops at Layer 4 depth.
   - It may show only compact deep-readiness posture, not Layer 5 internals.
   - It must not become a signal board.
2. **Dossier role**
   - Dossier is the full per-symbol intelligence artifact.
   - It may consume Layer 1-5 truth when available.
   - It must remain useful when deep analysis is absent, pending, completed, continuity-backed, degraded, or partially failed.
   - It must show section-level publication, continuity, degraded, and failure posture.
   - It remains a consumer artifact, not a truth birthplace.
3. **Current Focus role**
   - Current Focus is the singleton currently selected-symbol working artifact.
   - It follows the selected symbol and must not remain silently pinned to an older symbol.
   - It may closely mirror dossier depth for the selected symbol, but remains distinct from dossier because it is the current working file.
   - It must always show selected-symbol identity and deep-analysis posture (`not armed`, `armed/pending`, `completed`, `continuity-backed`, or `unavailable`).
4. **Role separation**
   - Market Board = what to inspect now
   - Dossier = full per-symbol intelligence artifact
   - Current Focus = currently selected-symbol working artifact
   - Future work must preserve these roles explicitly.
5. **Tier distinction**
   - Hard law, required product contract, and future expansion option are explicit for these artifacts.
   - Later product refinement may evolve wording or presentation, but may not reopen the role boundaries without a new doctrine pass.

### Consequences
- Blueprint contract files, persistence doctrine, HUD wording, symbol-information spine wording, front-door files, and office control truth must remain synchronized with this separation.
- Later stages may complete schemas, menu/settings, and runtime work from this baseline, but may not drift Market Board into signal ownership or make Current Focus / Dossier hidden truth owners.

---

## Decision ID: D-046
### Date
2026-04-01
### Title
Stage 1 doctrine freeze — ASC truth ownership, SIAM / Aurora interpretation ownership, and layer-boundary hardening
### Status
active

### Context
Repo truth surfaces were still vulnerable to drift that blurred scanner truth production with downstream signal interpretation.
The next blueprint expansion stages require a frozen doctrine baseline so future work cannot keep pulling ASC toward final signal ownership.

### Decision
Office freezes the following as current doctrine authority:
1. **Signal Ownership Law**
   - ASC / EA is the scanner truth producer only.
   - ASC may produce market-state truth, packet truth, eligibility truth, shortlist truth, deep evidence, and bounded structural interpretation.
   - ASC may not produce final directional trade calls, execution verdicts, final signal classification, entry commands, or order instructions.
2. **SIAM / Aurora interpretation ownership**
   - SIAM / Aurora is downstream of ASC and consumes lawful Layer 1–5 ASC truth in order.
   - SIAM / Aurora may derive directional bias, setup interpretation, invalidation framing, trigger interpretation, signal readiness, signal classification, trade narrative, and risk framing.
3. **Layer 3 neutrality**
   - Candidate Filtering is gate-pure and neutral.
   - It owns eligibility, block reasons, blocker classes, downstream inspection readiness, and bounded diagnostic failure exposure.
   - It does not imply trade direction, setup attractiveness, or signal quality.
4. **Layer 4 attention-priority framing**
   - Shortlist Selection remains the sole shortlist authority.
   - Its rank semantics are attention priority, inspection priority, and promotion priority only.
   - It may explain promotion basis, denial reason, and churn / hold / entry / exit reasoning, but it does not declare the best trade.
5. **Layer 5 handoff direction**
   - Deep Selective Analysis remains promoted-set-only and explicit-trigger-gated.
   - It is the last scanner-owned packet before analyst / SIAM interpretation.
   - Stage 1 freezes the handoff direction only; the final downstream field schema remains later-stage work.
6. **Tier distinction**
   - Hard law, required product contract, and future expansion option are now explicitly distinguished in blueprint doctrine.
   - Later work must not treat all future ideas as immutable law.

### Consequences
- Blueprint layer files, scope/admissibility wording, and front-door/control surfaces must remain synchronized with this scanner-vs-interpreter split.
- Later stages may expand handoff schema and downstream products, but they may not reopen ASC signal ownership without an explicit new doctrine pass.

---


## Decision ID: D-045
### Date
2026-03-30
### Title
Phase 1 doctrine reconciliation lock — Current Focus ownership, dossier target, HUD symbol context, Layer 4 discoverability, and Deep Analysis boundary
### Status
active

### Context
Recent carried-forward office wording introduced drift that treated Current Focus as explicit Deep Analysis trigger-owned only, which conflicted with board/dossier/current-focus contract law and current operator requirement for selected-symbol continuity in HUD context.

### Decision
Office locks the following as one canonical baseline:
1. **Current Focus ownership**
   - Current Focus is the singleton working file for the currently viewed/selected symbol.
   - Symbol change rewrites that same singleton file in place.
   - Current Focus follows HUD selected-symbol context and must not remain pinned to an older symbol when HUD context changes.
   - Deep Analysis may enrich that same Current Focus file after explicit trigger; Deep Analysis page-open alone does not imply deep work already ran.
2. **Dossier publication target**
   - Dossiers target the full admissible broker universe by default.
   - Open-only, shortlist-only, or silently narrowed publication is non-compliant.
   - Partial publication is allowed only with explicit degraded/incomplete posture signaling.
3. **HUD symbol-context contract**
   - Persistent top symbol action row is mandatory in symbol context.
   - Persistent bottom symbol section row is mandatory in symbol context.
   - Selected symbol context must persist across section switches; HUD remains consumer-only and gains no hidden runtime authority.
4. **Layer 4 browse/discoverability**
   - Bucket/sub-group/symbol browsing must prioritize operator discovery.
   - Leading Three / Full Five membership visibility is mandatory and must be easy to find without manual hunting through structural trees.
5. **Deep Analysis role (near-term)**
   - Layer 5 remains command-only/prepared and not broadly active.
   - Trigger path remains explicit and symbol-scoped; it may enrich Current Focus after trigger.
   - Ordinary symbol-view ownership remains with selected-symbol context surfaces and must not be hijacked by Layer 5.
6. **Market Board role boundary**
   - Market Board remains the Layer 4 summary/shortlist surface.
   - It is not a tick board, not a second dossier, and not a deep payload surface.
   - It must support Leading Three / Full Five discoverability and operator selection flow.

### Supersession / drift correction
- Any prior office wording that described Current Focus as trigger-owned only is superseded for doctrine authority by this decision.
- Historical runtime logs remain historical evidence and are not doctrine owners.

### Consequences
- Blueprint and office control files must carry one non-contradictory ownership baseline for downstream runtime repair passes.
- Later runtime passes must implement this lock explicitly without reinterpretation.

---

## Decision ID: D-044
### Date
2026-03-29
### Title
Full-universe dossier publication and Layer 4 artifact-truth hardening (single-board amendment landed)
### Status
active

### Context
Server evidence showed only 60 dossiers for a 1202-symbol universe, while runtime artifacts still omitted contract-required correlation detail and needed board/dossier composition cleanup.

### Decision
- Dossier publication remains full-universe law and must not be reduced to open-only or shortlist-only scope.
- Runtime write-lane defaults and dossier batch sizing are increased so a full-universe flush is achievable in bounded normal operation.
- Market Board publishes one canonical artifact, and every compact correlation line must include numeric peer values plus open/pending conflict and final exposure interpretation.
- Current Focus and Dossier must consume active Layer 4 truth explicitly; Layer 5 remains command-only.

### Why
This closes the gap between active Layer 4 runtime ownership and the still-lagging publication surfaces.

### Consequences
- normal runs can flush dossier publication toward the whole universe instead of tiny subsets
- board/current-focus/dossier wording now matches active Layer 4 truth
- Layer 5 remains non-automatic and command-only

---

## Decision ID: D-043
### Date
2026-03-29
### Title
MT5 runtime naming hard-correction: remove numbered layer folders/files from active runtime tree
### Status
active

### Context
Active MT5 runtime still used numbered folder/file naming (`layer1`-`layer5`, `ASC_Layer1*`, `ASC_Layer2*`) in implementation paths. This drifted from responsibility-based runtime naming law and increased migration/boundary confusion.

### Decision
- Rename runtime folders to responsibility owners:
  - `mt5/layer1` -> `mt5/market_state`
  - `mt5/layer2` -> `mt5/open_symbol_snapshot`
  - `mt5/layer3` -> `mt5/candidate_filtering`
  - `mt5/layer4` -> `mt5/shortlist_selection`
  - `mt5/layer5` -> `mt5/deep_selective_analysis`
- Rename forbidden runtime filenames:
  - `ASC_Layer1MarketState.mqh` -> `ASC_MarketStateEngine.mqh`
  - `ASC_Layer2OpenSymbolSnapshot.mqh` -> `ASC_OpenSymbolSnapshotEngine.mqh`
- Migrate includes and runtime path references accordingly.
- Keep runtime maturity truth unchanged (market-state/open-symbol-snapshot/candidate-filtering active; shortlist/deep-analysis scaffold only).

### Consequences
- Runtime structure now follows responsibility naming and no longer exposes numbered layer folders/files.
- Include graph and writer publication paths remain coherent after migration.
- Office records preserve this migration as a hard-correction pass, not a maturity-widening claim.

### References
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/runtime/ASC_Bootstrap.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/hud/ASC_HUD_Manager.mqh`

---

## Decision ID: D-042
### Date
2026-03-29
### Title
Runtime maturity truth reset: enforce Layer 1-4 active cutoff and downgrade Layer 4/5 to scaffold posture
### Status
active

### Context
Runtime and doctrine drift had begun to present shortlist/deep-analysis behavior as if Layer 4 and Layer 5 were live authority layers. That conflicted with actual implementation maturity and caused mixed operator posture across blueprint, office, and MT5 artifacts.

### Decision
- Lock current runtime truth to Layer 1 Market State, Layer 2 Open Symbol Snapshot, and Layer 3 Candidate Filtering only.
- Mark Layer 4 Shortlist Selection as scaffold/not-yet-active runtime authority.
- Mark Layer 5 Deep Selective Analysis as scaffold/not-yet-active runtime authority.
- Require operator-facing artifacts to use explicit non-active wording for Layer 4/5 (`scaffold only`, `not yet available`, `awaiting section activation`, `unavailable`).
- Treat correlation math used by board summaries as bounded support logic only, never shortlist authority.

### Consequences
- Market Board, Current Focus, and Dossier no longer claim promoted/deep active authority.
- Office and blueprint control surfaces must distinguish future doctrine from current runtime maturity.
- Future Layer 4/5 implementation remains in scope as doctrine, but no runtime claim is admissible until explicit implementation evidence lands.

### References
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `blueprint/final/03_ASC_FIVE_LAYER_SYSTEM.md`
- `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
- `blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`
- `office/ROADMAP_STATUS.md`

---

## Decision ID: D-041
### Date
2026-03-29
### Title
MT5 runtime-first hardening: enforce top-per-bucket board rendering and light HUD usability corrections
### Status
superseded

### Context
Runtime verification found remaining implementation drift: board ranking was still effectively global and HUD had clipping/overlap issues that directly reduced usability of symbol navigation and status visibility.

### Decision
- Enforce top-per-bucket Leading Three/Full Five rendering in Market Board runtime output.
- Keep anti-duplication by showing Full Five entries 4-5 when Leading Three already shows entries 1-3.
- Apply only light HUD correctness fixes tied to this lane (header clock spacing, symbol-row button width, pager/footer overlap).

### Consequences
- Runtime board now aligns to canonical per-bucket semantics with no duplicate 1-3 row repetition.
- HUD usability blockers in this lane are reduced without broad visual redesign.

### References
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `mt5/hud/ASC_HUD_Manager.mqh`
- `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`

---

## Decision ID: D-040
### Date
2026-03-29
### Title
Consolidation hardening: resolve remaining board/full-five rendering and office supersession drift
### Status
active

### Context
Post-runtime pass verification found a remaining doctrinal risk: Leading Three rendering and Full Five rendering could still be interpreted as duplicated card sets, and office history needed explicit supersession wording for older scaffold-era notes.

### Decision
- Leading Three remains entries 1-3 of Full Five with full per-symbol grammar.
- Full Five remains canonical rank order 1-5, but rendering must avoid duplicate 1-3 card repetition by showing entries 4-5 in the Full Five section when Leading Three cards are already present.
- Office control surfaces must explicitly mark D-039 as superseding older scaffold-era wording for this lane.

### Why
This removes the last ambiguity between blueprint anti-duplication law, office memory, and runtime board rendering behavior.

### Consequences
- Board output remains canonical without duplicate row printing.
- Office truth now explicitly distinguishes historical context from active doctrine for this lane.

### References
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `office/DECISIONS.md`
- `office/ROADMAP_STATUS.md`

---

## Decision ID: D-039
### Date
2026-03-29
### Title
Blueprint canon hardening adoption: Board/Current Focus/Dossier boundary lock and publication doctrine sync
### Status
active

### Context
Blueprint final contracts were hardened to remove ambiguity that previously allowed board-depth drift, duplicated shortlist presentation, vague correlation wording, and contradictory Current Focus behavior.
Office control surfaces must record these laws explicitly so future passes do not regress.

### Decision
Office adopts and enforces the following canon decisions:
1. Market Board is a Shortlist Selection summary surface only.
2. Leading Three is entries 1-3 of Full Five, not a second duplicated list.
3. Market Board per-symbol rows/cards must use the fixed compact line grammar in exact order.
4. Board correlation line must include numeric score + top 2 highest and top 2 lowest correlation peers with numeric values.
5. Current Focus is the selected symbol's singleton live working duplicate of dossier structure.
6. Symbol dossier remains the persistent archival/deep-intelligence owner.
7. Summary-side light calculations and Deep Selective Analysis heavy calculations remain separated by module boundary.
8. Writers must use atomic write discipline (temp write, validate, promote) with truthful publication-state and continuity handling.

### Why
These decisions remove recurring drift vectors:
- duplicated Leading Three/Full Five rendering,
- board leakage into deep payload publication,
- compact-summary-only interpretation of Current Focus,
- blurred shortlist-versus-deep ownership,
- writer/engine boundary erosion.

### Consequences
- Office is now synchronized to the hardened blueprint law for Market Board, Current Focus, and Dossier families.
- Module implementation planning may proceed in bounded scope without reopening doctrine ambiguity.
- Runtime completion is still not claimed; implementation evidence remains stage-gated.
- For Market Board/Current Focus/Dossier doctrine, this decision supersedes older historical entries that described scaffold-only Layer 4/5 posture during earlier passes.

### Affected domains
- blueprint/final board/dossier/current-focus contract lane
- blueprint/final five-layer ownership lane
- blueprint/final write-trigger/publication lane
- office status, decisions, work log, and change ledger synchronization lanes

### References
- `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
- `blueprint/final/03_ASC_FIVE_LAYER_SYSTEM.md`
- `blueprint/final/ASC_SCOPE_BOUNDARY_AND_ADMISSIBILITY_MAP.md`
- `blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`
- `blueprint/final/ASC_WRITE_TRIGGER_AND_PUBLICATION_MATRIX.md`
- `blueprint/final/10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md`

---

## Decision ID: D-038
### Date
2026-03-28
### Title
Layer 1-3 finalization: lock Selection Filter operator wording and aggregate phrasing
### Status
active

### Context
After shared Selection Filter owner landing, remaining drift was mostly wording-level: state casing and board aggregate phrasing were still partly technical.

### Decision
Finalize touched Layer 1-3 surfaces by:
- using title-case operator state labels for Selection Filter outputs,
- keeping one shared owner/summary path for Selection Filter logic and counts,
- replacing Market Board technical aggregate phrasing with operator-safe wording,
- preserving all Layer 4-7 boundaries as scaffold-only.

### Why
This pass closes final readability and drift issues without widening scope or changing ownership boundaries.

### Consequences
- Selection Filter outputs are more operator-clean while retaining same logic.
- Board aggregate line remains single-method and less technical.
- Layer 1-3 surfaces are better aligned for budget movement to later layers.

### Affected domains
- Selection Filter owner module
- HUD Selection Filter card
- Dossier Selection Filter section
- Current Focus Selection Filter section
- Market Board Selection Filter aggregate line

### References
- `mt5/layer3/ASC_SelectionFilter.mqh`
- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`

---

## Decision ID: D-037
### Date
2026-03-28
### Title
Task 8 final symbol-surface integration cleanup (naming + de-dup + operator wording)
### Status
active

### Context
After Tasks 1-7, remaining integration drift centered on operator-language leakage and duplicated technical mode codes across specification surfaces.

### Decision
Complete final symbol-surface integration cleanup in touched scope by:
- removing raw mode-code leakage from HUD/Dossier/Current Focus specification surfaces,
- using operator-safe availability wording for broker-defined policy families,
- centralizing trade/execution text mapping helpers for artifact surfaces,
- preserving scaffold/status framework and navigation behavior without widening deeper-layer logic.

### Why
This kills remaining drift between architecture intent and operator-visible wording while keeping the symbol spine coherent.

### Consequences
- specification surfaces remain richer/trimmed by surface role without technical code dumps,
- naming and wording alignment improve across HUD and artifact outputs,
- no Layer 4-7 real implementation was introduced.

### Affected domains
- HUD specification rendering
- Artifact text helpers
- Dossier and Current Focus specification wording
- office continuity records

### References
- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/artifacts/ASC_ArtifactTextHelpers.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`

---

## Decision ID: D-036
### Date
2026-03-28
### Title
Task 7 Layer 4-7 scaffold completion with Layer 5 live status framework
### Status
active

### Context
Layer 3 is now real. Task 7 requires full structural scaffold completion for Layer 4-7 and a meaningful Layer 5 live status/progress framework that is update-ready without fabricating deep-analysis results.

### Decision
Complete Layer 4-7 structural homes across HUD, Dossier, Current Focus, and Board hooks, and implement Layer 5 status/progress framework fields including:
- not started,
- queued,
- running,
- pending data,
- field groups completed/remaining,
- retries in progress,
- dossier write pending/complete,
- result landed.

All values remain scaffold-status posture and must not imply final Layer 4-7 payloads.

### Why
This provides a live-update-ready operational framework for future Layer 5 activation while keeping present scope truthful.

### Consequences
- Layer 5 surfaces are no longer dead placeholders.
- Layer 4, 6, and 7 keep explicit structural homes with truthful non-active posture.
- Board summary hooks can report compact Layer 5 progress posture without fake deep results.

### Affected domains
- HUD Layer 5 scaffold rendering
- Dossier Layer 4-7 sections
- Current Focus Layer 4-7 sections
- Market Board Layer 5 summary hooks
- office continuity records

### References
- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`

---

## Decision ID: D-035
### Date
2026-03-28
### Title
Task 6 Layer 3 selection filter surface implementation across HUD and artifacts
### Status
active

### Context
Task 5 completed Specification ownership. Task 6 requires Layer 3 to become the highest real decision posture surface in this wave, with explicit pass/fail/pending reasoning and no drift into Layer 4 or Layer 5 logic.

### Decision
Implement Layer 3 surfaces across HUD, Dossier, Current Focus, and compact Board hooks using only lawful Layer 3 posture:
- selection state (pass/fail/pending),
- reason and disqualifiers,
- dependency/freshness gates,
- corroboration posture,
- evidence status,
- next required step.

No shortlist/deep-analysis payloads may appear in Layer 3 surfaces.

### Why
This creates a usable selection-filter decision surface while preserving current stage boundaries and downstream non-admissibility.

### Consequences
- HUD Layer 3 now answers a distinct decision question with concise filter posture.
- Dossier and Current Focus Layer 3 sections align to the same ownership logic at richer/trimmed density.
- Board hook now exposes compact Layer 3 pass/pending/fail posture counts.

### Affected domains
- HUD section rendering
- Dossier writer
- Current Focus writer
- Market Board writer
- office continuity records

### References
- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`

---

## Decision ID: D-034
### Date
2026-03-28
### Title
Task 5 Specification / Contract implementation across symbol surfaces
### Status
active

### Context
Task 4 separated live quote ownership into Market Watch. Task 5 requires a dedicated specification page that exposes broker rules, trade permissions, size constraints, swap/margin, and session posture without mixing live quote payload.

### Decision
Implement Specification / Contract surfaces across HUD, Dossier, and Current Focus with grouped topic layout:
1. price/trade precision,
2. execution/trading permissions,
3. size/volume constraints,
4. swap/margin,
5. sessions.

HUD remains compact, Current Focus remains trimmed, Dossier remains richer. Non-applicable or unavailable fields must stay explicit and truthful.

### Why
This gives operators a practical symbol contract inspection page and prevents spec data from leaking into Overview or Market Watch roles.

### Consequences
- HUD Specification is now materially distinct from Market Watch and Overview.
- Dossier specification section carries richer grouped broker/spec/session detail.
- Current Focus carries compact aligned specification checkpoints.

### Affected domains
- HUD symbol section rendering
- Dossier writer
- Current Focus writer
- office continuity records

### References
- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`

---

## Decision ID: D-033
### Date
2026-03-28
### Title
Task 4 Market Watch / Live Quote implementation as real Layer 2 symbol page
### Status
active

### Context
Overview compression is complete. Task 4 requires a true Layer 2 Market Watch surface that carries live/current packet information without Overview repetition and with dynamic field suppression.

### Decision
Implement Market Watch as the dedicated Layer 2 page across HUD, Dossier, and Current Focus with these rules:
- prioritize bid/ask/spread, spread percent, freshness, observed age/tick time,
- include day posture and intraday range fields only when available,
- keep Dossier richer and Current Focus trimmed,
- no unsupported-field invention and no filler-empty-table behavior.

### Why
This establishes one usable live packet surface and removes ambiguity between Overview intent and Market Watch ownership.

### Consequences
- HUD Market Watch now surfaces dense live quote/freshness/day/intraday posture groups.
- Dossier Market Watch includes richer optional packet/session/range fields when lawful.
- Current Focus Market Watch keeps a trimmed subset with the same ownership.

### Affected domains
- HUD section detail rendering
- Dossier writer
- Current Focus writer
- office continuity records

### References
- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`

---

## Decision ID: D-032
### Date
2026-03-28
### Title
Task 3 Symbol Overview rebuild: shortest-page operator summary law
### Status
active

### Context
After Task 2 scaffold alignment, Symbol Overview surfaces still carried avoidable repetition risk. Task 3 requires rebuilding Overview into the shortest symbol page with only immediate operator context and explicit routing to deeper sibling pages.

### Decision
Enforce Symbol Overview as the shortest symbol section across HUD, Current Focus, and Dossier:
- compact identity line,
- primary state and eligibility,
- key quote posture,
- friction/tradeability posture,
- one current-summary line,
- one next-page guidance line.

No full Market Watch, Specification, or later-layer payload duplication is admissible in Overview.

### Why
This keeps Overview usable in real operator flow and prevents it from degrading into a repetitive dumping surface.

### Consequences
- HUD Symbol Overview now uses one compact hero + one compact summary card and removes extra wide identity-only block behavior.
- Current Focus and Dossier Overview sections now mirror the same core semantics at compact/fuller density levels.
- Overview alignment remains shared while respecting density split (HUD shortest, Current Focus middle, Dossier fuller).

### Affected domains
- HUD Symbol Overview page
- Current Focus Overview section
- Dossier Overview section
- office continuity records

### References
- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`

---

## Decision ID: D-031
### Date
2026-03-28
### Title
Task 2 shared scaffold implementation through Layer 7 with real data limited to Layer 1-3
### Status
active

### Context
Task 1 locked the shared symbol information architecture. Task 2 requires implementation alignment across HUD, Dossier, Current Focus, and Market Board so all surfaces carry the same section homes while avoiding fake later-layer payloads.

### Decision
Implement structural section homes across all symbol surfaces for the full eight-family spine, with real active detail only through Layer 3. Keep Layer 4 through Layer 7 as explicit scaffold homes with truthful placeholder language and no inferred values.

### Why
This creates one operational scaffold implementation lane for future expansion without reintroducing cross-surface drift or fabricated readiness claims.

### Consequences
- HUD section-detail pages now render role-specific shells per section family without repeating shallow cross-page blocks.
- Dossier and Current Focus now keep strict eight-section ordering with compact density split and no extra duplicate pseudo-sections.
- Market Board section-family hooks now expose Layer 3 candidate baseline context and preserve Layer 4-7 scaffold posture.

### Affected domains
- HUD symbol section rendering
- Dossier writer
- Current Focus writer
- Market Board writer
- office continuity surfaces

### References
- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`

---

## Decision ID: D-030
### Date
2026-03-28
### Title
Task 1 symbol information architecture lock hardening (contract-to-HUD naming sync)
### Status
active

### Context
Task 1 already established the eight-family symbol spine. A final bounded lock pass was required to make the implementation checklist explicit and remove remaining naming drift risk between contract wording and HUD section titles.

### Decision
Keep the eight-family symbol spine unchanged and add explicit closure checks in the spine contract. Align selected-symbol section title naming so the section row label and section title both use `Overview` for the first section family while preserving `Symbol Overview` as the family name in contracts and dossier/current-focus section headings.

### Why
This keeps operator navigation wording stable (`Overview` in the bottom row) while preserving canonical architecture ownership naming (`Symbol Overview` family) in the blueprint and artifacts.

### Consequences
- blueprint spine contract now contains explicit bounded-implementation notes and mini-debug closure checklist;
- HUD selected-symbol section naming no longer drifts between row button and page section title;
- no layer activation or HUD cosmetic redesign was introduced.

### Affected domains
- blueprint symbol spine contract
- HUD section title naming
- office continuity records

### References
- `blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`
- `mt5/hud/ASC_HUD_Manager.mqh`

---

## Decision ID: D-029
### Date
2026-03-28
### Title
Symbol information architecture lock across HUD/Dossier/Current Focus/Board
### Status
active

### Context
Symbol-context information placement was drifting between HUD pages, dossiers, and summaries, with repeated shallow fields and no single locked section-family spine for future Layer 4–7 homes.

### Decision
Adopt one canonical symbol information spine with exactly eight section families:
1. Symbol Overview
2. Market Watch / Live Quote
3. Specification / Contract
4. Layer 3 — Selection Filter
5. Layer 4 — Shortlist / Selection Context (scaffold only)
6. Layer 5 — Deep Analysis (scaffold only)
7. Layer 6 — Future Scaffold
8. Layer 7 — Future Scaffold

And enforce symbol-context layout law:
- top symbol header strip,
- persistent top symbol action row,
- one active symbol section page,
- persistent bottom symbol section navigation row with exact buttons (Overview, Market Watch, Specification, Layer 3–7).

### Why
This prevents future implementation drift, keeps ownership explicit, and provides one stable information architecture for HUD, dossier, and summary surfaces.

### Consequences
- Blueprint now has one dedicated symbol information spine contract.
- HUD hierarchy and board/dossier/current-focus contracts are explicitly bound to that spine.
- Active artifact writers align section headings/placeholders to the same eight families without opening Layer 4–7 logic.

### Affected domains
- blueprint final contracts
- HUD architecture contract interpretation
- dossier/current-focus/board scaffold section naming
- office control records

### References
- `blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`
- `blueprint/final/ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md`
- `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`

---

## Decision ID: D-028
### Date
2026-03-27
### Title
Canonical trader control registry and MT5 input surface realignment
### Status
active

### Context
The active MT5 input surface carried mixed developer/runtime tuning and lacked a canonical registry aligned to ASC ownership classes.

### Decision
Adopt a canonical trader control registry and enforce this split in active code:
1. trader-facing controls for HUD/Board/Current Focus/Dossier and Layer 5 timeframe bars;
2. advanced trader controls for Layer 1 cadence thresholds and dispatcher budgets;
3. system-owned runtime truth remains non-input and publication-only.

### Why
This keeps Inputs as a trader control surface while preserving runtime ownership boundaries and preventing observed-state contamination.

### Consequences
- MT5 Inputs are grouped by trader meaning.
- Layer 5 timeframe bars follow explicit numeric law (`0 = off`, positive integer = bars).
- Board/Dossier/HUD controls become dynamic publication/render controls.
- System-owned runtime facts remain hidden from Inputs.

### Affected domains
- mt5 input menu declarations
- runtime/layer1 control wiring
- board/current-focus/dossier publication surfaces
- HUD display behavior

### References
- `blueprint/final/ASC_TRADER_CONTROL_REGISTRY.md`
- `mt5/AuroraSentinelCore.mq5`
- `mt5/menu/ASC_TraderControlRegistry.mqh`

---

## Decision ID: D-027
### Date
2026-03-27
### Title
Office truth posture for active MT5 runtime vs unresolved non-office canonical wording
### Status
active

### Context
Office records show active Stage 2 runtime/HUD work on the live MT5 surface. Cross-surface wording drift can still occur outside office ownership and must be handled without office silently rewriting blueprint/root authority.

### Decision
Office must speak with this explicit boundary:
1. report live repo/runtime reality from active evidence (`mt5/AuroraSentinelCore.mq5`, dispatcher/governor, Layer 1, and HUD active paths);
2. report unresolved cross-surface contradiction when blueprint/root wording is found to be mixed;
3. name ownership correctly: office reports contradiction status, blueprint/root files own canonical wording repairs;
4. never claim contradiction closure in office before owning files are corrected.

### Why
This preserves truthful operations reporting without letting office silently redesign architecture ownership.

### Consequences
- office control files remain evidence-first and ownership-bounded.
- readers can distinguish “active runtime now” from “canonical wording still being harmonized elsewhere.”
- unresolved contradiction posture is explicit instead of implied.

### Affected domains
- office status language
- office continuity/decision memory discipline

### References
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `mt5/AuroraSentinelCore.mq5`

---

## Decision ID: D-026
### Date
2026-03-27
### Title
Final HUD QA/compliance/performance hardening law (Task 10 / Track J)
### Status
active

### Context
After Tasks 1–9, HUD structure and detail depth were materially improved but required one final bounded pass to validate clipping safety, semantic consistency, action-strip contract behavior, and tactical performance boundaries.

### Decision
For Task 10 closure, HUD implementation must enforce all of the following together:
1. card-level text surfaces must clamp to available width to avoid overflow/clipping on reduced viewport widths;
2. symbol-action surfaces must stay symbol-page-only and Deep Analysis must fail-close with explicit operator-safe blocked reasons when ineligible;
3. Aurora Signal/Semi-Auto/Full Auto remain explicit reserved placeholders (non-active, no side effects);
4. tactical refresh remains strip-local and must not escalate into structural rebuild authority;
5. final regression benchmark pack must exist and enumerate required page-state captures, with explicit missingness when capture tooling is unavailable.

### Why
This locks final HUD polish and contract compliance without reopening architecture or sacrificing runtime responsiveness.

### Consequences
- overflow risk is reduced on compact/narrow chart widths.
- action-strip behavior is stricter and contract-explicit.
- tactical-vs-structural boundary remains preserved.
- benchmark capture requirements are preserved even when runtime screenshot tooling is unavailable.

### Affected domains
- mt5/hud rendering and action-strip interaction behavior
- office continuity and QA/regression control surfaces

### References
- `mt5/hud/ASC_HUD_Manager.mqh`
- `office/HUD_REGRESSION_PACK_2026-03-27.md`

---

## Decision ID: D-024
### Date
2026-03-26
### Title
HUD realization and hardening law on active runtime truth
### Status
active

### Context
The MT5 surface had runtime truth and artifact scaffolds, but no active HUD consumer implementation on the current code path.

### Decision
Land a bounded real HUD now as a strict read-only consumer of runtime-owned Layer 1/classification truth with the following required posture:
1. complete usable page hierarchy (Overview, Main Groups, Sub-Groups, Symbols, Symbol Overview, Menu/Settings view);
2. preserve canonical six main buckets and classification-owned subgroup truth without synthetic rows;
3. show partial/fresh/degraded posture explicitly from current summary/symbol freshness truth;
4. provide selected-symbol tactical strip using selected-symbol-only direct reads;
5. enforce retained-object render lifecycle and immediate navigation via chart event input;
6. keep scanner ownership with runtime layers and artifact writers (HUD stays consumer-only).

### Why
Operator visibility required a real usable HUD surface now, without widening into Layer 2+/selection/deep logic or violating ownership law.

### Consequences
- HUD is materially real and immediately navigable.
- Page transitions are event-driven and no longer heartbeat-bound.
- Runtime truth ownership boundaries remain unchanged.

### Affected domains
- mt5 EA entry and chart-event plumbing
- mt5 hud module (state/render/input)
- office/continuation/version synchronization

### References
- `mt5/AuroraSentinelCore.mq5`
- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/core/ASC_Version.mqh`

---

## Decision ID: D-023
### Date
2026-03-26
### Title
Layer 1 speed + early-partial publication restoration law
### Status
active

### Context
Runtime evidence showed a slow scan posture and visibility starvation: Layer 1 scanned in small slices while publication waited for full-cycle completion, so operators mostly saw logs during long sweeps.

### Decision
For Stage 2 bounded scope, the runtime must enforce all of the following together:
1. increase Layer 1 sweep throughput materially (heartbeat and scan budget tuned for broad-scan speed);
2. admit partial publication before full-universe completion once assessed coverage is meaningful;
3. keep canonical six main-bucket rows always visible in Market Board, with truthful zero/partial posture;
4. preserve bounded write batches and one-heartbeat authority while avoiding write-lane spam;
5. keep Layer 2+/shortlist/deep behavior blocked while preserving placeholder homes.

### Why
Speed and visibility are both required runtime law. Coordination that starves visible outputs is operationally invalid.

### Consequences
- Layer 1 now progresses as a fast broad sweep.
- Market Board/Current Focus/Dossiers can publish incrementally during scan progress.
- Summary and dossier scaffolds remain truthful and durable without widening scope.

### Affected domains
- mt5 runtime governor/dispatcher
- mt5 Layer 1 summary posture
- mt5 Market Board / Dossier writers
- office and continuation control surfaces

### References
- `mt5/core/ASC_Constants.mqh`
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/layer1/ASC_Layer1MarketState.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`

---

## Decision ID: D-022
### Date
2026-03-26
### Title
Output scaffold completion and bounded write-batch logging law
### Status
active

### Context
Market Board and Symbol Dossier outputs were real but still too thin as long-term homes, and write-lane success logging remained noisy due to per-symbol success entries.

### Decision
For current bounded scope, output and logging behavior must hold the following:
1. Market Board keeps truthful Layer 1 bounds while providing stable homes for timing/posture, universe counts, classification posture, main/sub-bucket counts, unresolved truth, current-focus reference, later-layer placeholders, and publication/freshness posture.
2. Symbol Dossier remains truthful to landed Layer 1 + classification facts while exposing durable placeholder homes for open snapshot, selection filter, shortlist, deep analysis, and publication/continuity posture.
3. Current Focus remains bounded but structurally aligned with publication/continuity wording.
4. Write lane must preserve detailed failure logging while summarizing routine dossier successes as one bounded batch result per beat (attempted/succeeded/failed/deferred window).
5. Layer 2+/HUD/shortlist enrichment remains blocked in this pass.

### Why
This preserves operational truth while reducing log noise and gives later layers stable in-place scaffold homes instead of temporary output fragments.

### Consequences
- Operators can inspect outputs as durable skeletons without fabricated richness.
- Function-result logs become materially less spammy while still preserving symbol/path failure detail.
- Future layer hydration can replace placeholders in place instead of rewriting artifact structure.

### Affected domains
- mt5 artifact writers (Market Board, Symbol Dossier, Current Focus)
- mt5 dispatcher write-lane logging posture
- office status/decision/work-log/change-ledger/continuation surfaces

### References
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `office/ROADMAP_STATUS.md`
- `CHAT_CONTINUATION_GUIDE.md`

---

# Aurora Sentinel Core — Decisions

## Decision ID: D-025
### Date
2026-03-26
### Title
Old-HUD-anchored operator HUD completion and correctness law
### Status
active

### Context
The active HUD existed but diverged from archive-proven operator structure and had weak hierarchy behavior (missing bucket-detail/stat-detail split, weak back/history semantics, and inconsistent page-routing reliability).

### Decision
For this bounded pass, HUD implementation must use archive files `ASC_ExplorerHUD.mqh` and `ASC_ExplorerBuckets.mqh` as direct benchmark evidence for structure/behavior while staying within current read-only boundary law. Required outcomes:
1. restore six-depth view stack: Overview -> Main Buckets -> Sub-Buckets -> Bucket Detail (Symbols) -> Symbol Detail -> Stat Detail;
2. restore strong back/home navigation memory and non-skipping hierarchy transitions;
3. restore operator visual grammar (header/nav strip/cards/status strip) anchored to archive + screenshot evidence;
4. harden correctness for subgroup routing, symbol selection, stat drill-down, and pager actions;
5. keep HUD as runtime-truth consumer only (no scanner/classification ownership migration).

### Why
Operator trust depends on stable hierarchy and truthful immediate navigation. Archive HUD already proved a working operator grammar, so restoration to that grammar is the shortest lawful path to correctness.

### Consequences
- HUD now presents archive-anchored hierarchy and behavior with explicit stat/detail split.
- Routing dead-ends and weak transitions are removed through history-backed navigation and deterministic row routing.
- Runtime ownership boundaries remain unchanged.

### Affected domains
- mt5/hud page-model, routing, rendering, and interaction handling
- office status/change continuity controls
- version/continuation handoff surfaces

### References
- `archives/Asc last gen archives 23-03/mt5_runtime_flat/ASC_ExplorerHUD.mqh`
- `archives/Asc last gen archives 23-03/mt5_runtime_flat/ASC_ExplorerBuckets.mqh`
- `mt5/hud/ASC_HUD_Manager.mqh`

---

## Decision ID: D-021
### Date
2026-03-26
### Title
Classification foundation completion law for Layer 1 grouped truth and dossier identity
### Status
active

### Context
Classification support had landed directionally, but completion gates were still soft in two places: conservative matching allowed weak canonical alias carryover in some cases, and subgroup derivation provenance was not explicit in classification outputs.

### Decision
Classification foundation stage is now considered complete for current active scope only when all of the following remain true in code and office posture:
1. symbol resolution is conservative and server-aware, with raw/exact priority and unresolved fallback preserved;
2. canonical alias matching is allowed only for explicit alias rows (not generic base-row loose matching);
3. top-level operator grouping remains fixed to six main buckets (`fx`, `indices`, `metals`, `energy`, `crypto`, `stocks`);
4. stock secondary grouping remains explicit (`us_stocks`, `eu_stocks`, `hk_stocks`, `global_stocks`) and non-stock subgrouping remains primary-bucket derived;
5. subgroup-source provenance is published from classification ownership (`sub_bucket_source`), not synthesized by UI writers;
6. grouped summary and dossiers keep unresolved posture explicit and do not assign synthetic membership.

### Why
This prevents drift from “classification exists” to “classification appears complete” without preserving conservative matching law, truthful subgroup ownership, and unresolved honesty.

### Consequences
- Classification outputs are safer for Layer 1 grouping and dossier identity consumption.
- Later HUD/filtering/shortlist work can consume stable identities without redefining ownership.
- Stage 2 remains active and incomplete; this decision closes only the classification foundation sub-stage inside current active implementation.

### Affected domains
- mt5 symbol normalization/classification bridge
- mt5 market-board grouped summary writer
- mt5 dossier writer identity/classification surface
- office control and continuation posture

### References
- `mt5/symbols/ASC_ClassificationBridge.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `office/ROADMAP_STATUS.md`
- `CHAT_CONTINUATION_GUIDE.md`

---

## Decision ID: D-013
### Date
2026-03-26
### Title
Canonical integration baseline and anti-drift admissibility law
### Status
active

### Context
Recent normalization removed major status contradictions, but integration governance still needed an explicit canonical baseline defining what counts as current admissible truth versus historical archive evidence.

### Decision
The office canonical integration baseline is now defined as:
- **Current admissible scope**: only statements backed by current control surfaces, dependency order, and explicit in-repo evidence from active files.
- **Historical archive evidence**: legacy notes/claims retained for traceability, never sufficient alone for present-tense runtime/compile/integration claims.

Anti-drift rules are mandatory:
1. No lane, stage, or integration claim can be marked passed from archive evidence alone.
2. Integration coherence must be tracked as an explicit status lane with pass criteria and blockers.
3. Contradiction removals and remaining contradictions must be logged in both work log and change ledger in the same pass.
4. Office language must keep “historical evidence” and “current admissible scope” explicitly distinct.

### Why
Without an explicit baseline, control surfaces can silently drift back into mixed-tense claims that overstate current reality.

### Consequences
- Integration status is now evidence-gated and contradiction-audited.
- Archive content remains valuable for provenance, but cannot be promoted to active truth without re-verification.
- Work-log and ledger entries must include exact contradiction mapping whenever coherence changes.

### Affected domains
- office governance
- integration control posture
- anti-drift enforcement language

### References
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`

---

## Decision ID: D-010
### Date
2026-03-26
### Title
Stage 2 opening runtime spine law for current MT5 surface
### Status
active

### Context
Layer 1 outputs and writes were real enough to prove direction, but dispatcher/governor boundaries were still too thin: scan and write work could mix in one beat, dirty eligibility was not separated from admission, and telemetry lacked per-beat control truth.

### Decision
Stage 2 is now opened with the following mandatory runtime posture on the active MT5 surface:
1. Dispatcher heartbeat is the single runtime authority for beat admission.
2. Exactly one major lane owns each beat (scan or persistence in current opening scope).
3. Layer 1 scan work runs as bounded cursor slices under scan-lane credits.
4. Write publication is admitted only through persistence lane with bounded write credits.
5. Dirty eligibility (`write_dirty`) does not imply immediate admission.
6. Heartbeat telemetry must log mode/lane/budget/deferred/yield posture every beat.

### Why
Without these controls, later layers would inherit an opportunistic runtime that quietly violates heartbeat law and makes debugging/operations unreliable.

### Consequences
- Stage 2 posture changes from blocked to active opening pass (not complete).
- Stage 3+ remains blocked until Stage 2 completion evidence is explicitly logged.
- Future passes can extend lanes/modes without broad rewrite because control vocabulary is now explicit.

### Affected domains
- MT5 runtime control spine
- Layer 1 admission posture
- write-lane governance
- heartbeat telemetry/logging
- office continuity truth

### References
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/layer1/ASC_Layer1MarketState.mqh`
- `mt5/runtime/ASC_Bootstrap.mqh`
- `office/ROADMAP_STATUS.md`
- `CHAT_CONTINUATION_GUIDE.md`

---


## Decision ID: D-011
### Date
2026-03-24
### Title
Foundation includes landed output proof
### Status
active

### Context
The rebuild had drifted toward treating foundation as mostly in-memory structure plus heartbeat/HUD behavior.

### Decision
Foundation explicitly includes write-path proof, server-root publication proof, summary scaffold, dossier scaffold, and section homes for major layers.

### Why
Without this correction, runtime behavior can appear alive while proving little for development and debugging.

### Consequences
- Stage 1 doctrine is broader than pure type containers
- dossier scaffold exists early
- later layers hydrate existing homes rather than reshaping dossiers repeatedly

### Affected domains
- roadmap interpretation
- office truth
- publication surface doctrine

### References
- `blueprint/roadmap/01_BUILD_STRATEGY.md`
- `blueprint/roadmap/03_STAGE_1_FOUNDATION_AND_TYPES.md`
- `office/ROADMAP_STATUS.md`

---

## Decision ID: D-012
### Date
2026-03-25
### Title
Post-archive control truth and Stage re-activation law
### Status
active

### Context
Office surfaces accumulated legacy “active landed runtime” language while Stage 2 remained incomplete and no current active MT5 verification was recorded in control files.

### Decision
Control truth is normalized as follows:
- Stage 2 is a hard prerequisite for any Stage 3+ `active` claim.
- Legacy MT5 implementation statements are treated as archived evidence, not active runtime truth.
- Compile/runtime behavior is not claimed from archive notes alone.
- Stage 3+ can re-enter `active` only after explicit re-activation evidence is logged.

### Re-activation conditions
All conditions are required:
1. Stage 2 completion is recorded in office control files.
2. Active-surface verification evidence is logged (compile/build/test checks as applicable).
3. Roadmap, work log, and change ledger are updated in the same pass to keep continuity truthful.

### Why
Dependency order and current-reality truth must dominate narrative momentum from historical notes.

### Consequences
- Existing Stage 3/4/9 active claims are downgraded until Stage 2 completion is evidenced.
- Legacy version/pass notes remain available for historical traceability only.
- Future status upgrades require same-pass evidence and control-surface synchronization.

### Affected domains
- office governance
- roadmap status semantics
- work-log and ledger truth model

### References
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`

---

## Decision ID: D-014
### Date
2026-03-26
### Title
Pre-EA blueprint stabilization execution law and canonical ownership map lock
### Status
active

### Context
Control doctrine improved substantially, but builder-proof execution order and canonical ownership/reference boundaries were still too easy to misread in combination across front-door, roadmap, office, and compact pointer surfaces.

### Decision
The repo now enforces the following as explicit law:
1. `blueprint/final/ASC_CANONICAL_PRODUCT_SPINE.md` is the compact build-door map for canonical ownership, reference-only boundaries, and must-edit-together guardrails.
2. First three lawful implementation slices are fixed: Stage 0A closure -> Stage 0B closure -> Stage 1 opening packet.
3. Completion claims are invalid without synchronized office evidence updates (status + work log + change ledger).
4. Placeholder lanes (Aurora/Semi-Auto/Full-Auto/workflow collapse) remain blocked and non-admissible in present implementation scope.

### Why
Without explicit build-door execution law, future passes can still drift by editing the wrong control file, opening stages out of order, or over-claiming progress from incomplete evidence.

### Consequences
- Builders now have one compact ownership map plus fixed first-slice ordering.
- Anti-drift enforcement is visible in front-door, roadmap, continuation, and office surfaces.
- Re-entry and stage-opening claims are harder to overstate.

### Affected domains
- final blueprint integration spine
- roadmap execution order doctrine
- office status truth and gate semantics
- front-door/continuation anti-drift guardrails

### References
- `blueprint/final/ASC_CANONICAL_PRODUCT_SPINE.md`
- `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`
- `blueprint/roadmap/15_EXECUTION_BACKLOG.md`
- `FRONT_DOOR_CHECKLIST.md`
- `CHAT_CONTINUATION_GUIDE.md`
- `office/ROADMAP_STATUS.md`

---

## Decision ID: D-015
### Date
2026-03-26
### Title
EA creation readiness go/no-go decision card and gate-run protocol lock
### Status
active

### Context
Pre-EA stabilization improved ownership and order law, but freeze/integration closure remained too easy to treat as pending narrative rather than binary gate execution.

### Decision
1. Stage 0A and Stage 0B are now explicitly run as auditable gate-run protocols with gate-to-owner evidence mapping.
2. `office/ROADMAP_STATUS.md` must carry an EA creation readiness decision card (`GO` / `NO-GO`) as the single office truth for build entry.
3. Front-door pass is invalid unless office readiness card is `GO`.

### Why
This removes remaining soft-pass ambiguity and makes EA creation start criteria operationally binary.

### Consequences
- Builders can no longer infer readiness from partial prose.
- Gate closure requires explicit row evidence and synchronized office updates.
- MT5 rebuild remains blocked until readiness card flips to GO with evidence.

### References
- `blueprint/roadmap/02A_STAGE_0A_PRE_IMPLEMENTATION_FREEZE.md`
- `blueprint/roadmap/02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`
- `office/ROADMAP_STATUS.md`
- `FRONT_DOOR_CHECKLIST.md`

## Decision ID: D-016

### Date
2026-03-26

### Decision title
Activate Stage 1 foundation lane with contract-only evidence boundaries

### Status
superseded_by_D-017

### Context
Stage 0A and Stage 0B closure registers are present in office status. A later correction pass determined that stage-side output scaffold artifacts were being misused as implementation evidence, which violates runtime ownership law.

### Decision
Activate Stage 1 as the current implementation stage and constrain this pass to:
- shared structural schemas and runtime container homes,
- menu/settings section + safety + owner mapping proof,
- schema/contract validation scripts,
- explicit prohibition of stage-side static operator artifact proof files.

### Non-admissible widening in this decision
- no dispatcher/governor runtime behavior,
- no deep logic hydration,
- no operator-facing invented truth,
- no Stage 2 activation.

### Evidence linkage
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md` (WL-018)
- `office/CHANGE_LEDGER.md` (CL-017)
- `blueprint/roadmap/03_STAGE_1_FOUNDATION_AND_TYPES.md`


---

## Decision ID: D-017
### Date
2026-03-26
### Title
De-authorize stage-side operator artifact scaffolds and restore EA-first runtime publication law
### Status
active

### Context
Stage 1 documentation drifted into treating repo-side static Board/Current Focus/Dossier scaffold files as implementation evidence. That pattern blurs blueprint law, roadmap sequencing, and runtime artifact ownership.

### Decision
1. Stage-side static operator artifact files are forbidden as implementation proof.
2. Stage 1 evidence is narrowed to contracts, schema, runtime-container foundations, and validation checks.
3. Board / Current Focus / Dossiers remain runtime-published artifacts only.
4. Gate closure language must not imply runtime publication completion.

### Why
EA-first build posture requires runtime to publish real operator artifacts. Allowing stage-side scaffold files as proof creates documentation theater and stage-speedrunning risk.

### Consequences
- Stage 1 output-proof scaffold files are removed from active evidence posture.
- Roadmap/final/office surfaces now carry explicit anti-drift law against runtime-substitute artifacts.
- Stage progression remains blocked by real implementation evidence, not fabricated proof packets.

### References
- `blueprint/final/ASC_CANONICAL_PRODUCT_SPINE.md`
- `blueprint/final/10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md`
- `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
- `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`
- `blueprint/roadmap/03_STAGE_1_FOUNDATION_AND_TYPES.md`
- `blueprint/roadmap/15_EXECUTION_BACKLOG.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`


## Decision ID: D-018
### Date
2026-03-26
### Title
Stage 0A/0B true-closure re-audit lock and Top-5/Top-10 correlation-line hardening
### Status
active

### Context
A corrective pass identified remaining wording drift: stale references to Stage 1 “output-proof” opening language, weakly locked Top-5 correlation presentation wording, and office-history wording that could be misread as unresolved Stage 0A closure despite pass rows.

### Decision
1. Stage 0A and Stage 0B closure rows are re-audited and remain pass under current gate law.
2. Stage-side static Board/Current Focus/Dossier artifacts are non-admissible as runtime publication evidence.
3. Top-5/Top-10 board symbol cards must carry a mandatory fixed-position compact correlation line with required field semantics owned by `ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`.
4. Front-door/roadmap/office wording must use “foundation/type/runtime-prerequisite” language instead of “output-proof” for Stage 1 slice naming.

### Why
This prevents false closure drift, locks the blueprint-vs-runtime publication boundary, and blocks future omission of required operator-facing Top-5 correlation posture details.

### Consequences
- Stage 0A: pass (re-audited).
- Stage 0B: pass (re-audited).
- Stage 1 remains active under contract/schema evidence boundaries only.
- Correlation compact line omission in Leading Three/Full Five/All-Markets Top Ten is now explicit non-compliance.

### References
- `office/ROADMAP_STATUS.md`
- `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
- `blueprint/final/07_ASC_LAYER_4_SHORTLIST_SELECTION.md`
- `blueprint/final/ASC_CANONICAL_PRODUCT_SPINE.md`
- `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`
- `FRONT_DOOR_CHECKLIST.md`


## Decision ID: D-019

### Date
2026-03-26

### Decision
Open Stage 1 with a real MT5 implementation surface and compile-oriented EA scaffold, while explicitly prohibiting fake repo-side operator artifact proofs.

### Why
Stage 0A/0B closure allows bounded Stage 1 opening. The repository now requires code-owned runtime homes and coherent module boundaries before Stage 2 or layer-rich work can lawfully start.

### Consequences
- `Aurora Sentinel Core/mt5/` becomes the active MT5 implementation surface for Stage 1.
- Grouped module structure is mandatory for scaffold coherence.
- Runtime publication homes are path-owned in code, not fabricated as static proof files.
- Stage 2+ remains blocked until Stage 1 closure evidence is recorded.

## Decision ID: D-020

### Date
2026-03-26

### Title
Correct roadmap foundation-rail drift: Stage 1 opens write/HUD/logging scaffolds; Stage 8/9 harden maturity

### Status
active

### Context
Recent roadmap wording could be misread as if Board/Current Focus/Dossier writing first becomes lawful in Stage 8 and HUD first becomes lawful in Stage 9. That drift conflicts with Stage 1 EA-opening intent and encourages delayed testability.

### Decision
1. Stage 1 explicitly owns three foundation rails from first real EA build: runtime writing scaffold, HUD scaffold, and dev/workbench logging scaffold.
2. Runtime-owned bounded testing outputs are admissible early for `Market Board.txt`, `Current Focus.txt`, and `Dossiers/*.txt` with truthful placeholders when upstream layer truth is not yet available.
3. Stage 8 is reframed as persistence/artifact-family hardening maturity, not first-write authorization.
4. Stage 9 is reframed as rich HUD/operator completion, not first-HUD authorization.
5. No fake proof law remains strict: repo-side static sample outputs are never runtime evidence.

### Consequences
- Future builders get a clean build order: Stage 1 rails -> Stage 2 spine -> Layers 1–5 hydration -> Stage 8/9 maturity hardening.
- Placeholder replacement is explicit and in-place, reducing architecture rewrite pressure.
- Office/roadmap control surfaces remain synchronized on anti-drift publication/HUD doctrine.

### References
- `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`
- `blueprint/roadmap/03_STAGE_1_FOUNDATION_AND_TYPES.md`
- `blueprint/roadmap/10_STAGE_8_PERSISTENCE_AND_ARTIFACTS.md`
- `blueprint/roadmap/11_STAGE_9_HUD_AND_OPERATOR_SURFACE.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`

## Decision Addendum (2026-03-26)
D-017 implementation evidence synchronized in active MT5 files and continuation surfaces during the classification foundation pass.

## Decision ID: D-021

### Date
2026-03-28

### Title
HUD symbol context must navigate by locked section families, not reduced aspect subsets

### Status
active

### Context
The prior HUD pass left symbol-context detail switching bound to a six-item aspect strip and omitted direct section navigation coverage for Layer 3 and Layer 4 while the spine contract requires an eight-family section row.

### Decision
1. Symbol context navigation is section-family first and must present all eight section homes in fixed order.
2. Layer 3 and Layer 4 section homes must be directly reachable and remain scaffold-only until separately admitted.
3. Layer 6 and Layer 7 remain explicit future scaffold homes and non-active.
4. HUD wording in symbol-context detail surfaces should use "Section" semantics where the interaction is section-family navigation.

### Consequences
- Section-row controls now expose full contract coverage.
- No layer activation is implied by visibility; scaffold posture remains explicit.
- Selected symbol context persists across section switches with reduced navigation ambiguity.

### References
- `Aurora Sentinel Core/blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`

## Decision ID: D-022

### Date
2026-03-28

### Title
Task 2 symbol-context navigation and scaffold-home enforcement

### Status
active

### Context
Task 2 requires one shared symbol scaffold architecture across HUD, Dossier, Current Focus, and Board hooks, plus persistent top action + bottom section navigation within symbol context.

### Decision
1. HUD render flow must reserve structural space for a persistent bottom section row on both Symbol Overview and Section Detail pages.
2. Dossier and Current Focus must keep exact 8-section order while limiting non-scaffold detail to admitted layers only.
3. Layer 3 homes may expose real current-input posture only; filter decision output remains "awaiting layer completion" until Layer 3 owner is promoted.
4. Layer 4–7 remain explicit scaffold homes with non-active posture wording.

### Consequences
- Symbol context now supports sibling section switching without back-stack dependence.
- Shared section spine remains schema-stable and role-consistent across surfaces.
- No fake later-layer certainty is introduced.

### References
- `Aurora Sentinel Core/blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_MarketBoardWriter.mqh`

## Decision ID: D-023

### Date
2026-03-28

### Title
Symbol Overview is a short operator-summary page (no cross-page duplication)

### Status
active

### Context
Task 3 requires replacing shallow/repetitive Overview behavior with a shortest-page operator summary that points to deeper sibling pages instead of duplicating them.

### Decision
1. HUD Symbol Overview is explicitly the shortest symbol page and must not duplicate full Market Watch / Specification / layer pages.
2. Overview must show only compact identity, state/eligibility, key quote posture, friction/tradeability posture, one current summary line, and one next-detail-page hint.
3. Overview role alignment remains shared across HUD, Current Focus, and Dossier with density split: HUD shortest, Current Focus compact, Dossier fuller.

### Consequences
- Overview becomes immediately usable in operator flow.
- Repetition pressure across symbol pages is reduced.
- Sibling page architecture remains clear and discoverable.

### References
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`

## Decision ID: D-024

### Date
2026-03-28

### Title
Market Watch is the real Layer 2 packet page with dynamic suppression

### Status
active

### Context
Task 4 requires Market Watch to be distinct from Overview and to expose useful current packet truth without filler empties or unsupported synthetic values.

### Decision
1. HUD Market Watch must present admitted Layer 2 packet truth grouped by live quote, spread/freshness, day posture, and intraday range posture.
2. Dossier and Current Focus Market Watch sections must follow the same ownership model at different densities (Dossier richer, Current Focus trimmed).
3. Optional packet-adjacent fields are shown only when lawfully available; unavailable values are omitted or explicitly marked unavailable without placeholder spam.

### Consequences
- Market Watch differs clearly from Overview role.
- Layer 2 packet information is surfaced in operator-usable form.
- Cross-surface alignment is maintained while preserving density split.

### References
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `Aurora Sentinel Core/blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`

## Decision ID: D-025

### Date
2026-03-28

### Title
Specification page owns broker rules/session/tradeability contract detail (not Market Watch)

### Status
active

### Context
Task 5 requires a clean symbol specification page for broker rules/session/tradeability details and forbids mixing those details into Market Watch or Overview surfaces.

### Decision
1. Specification section in HUD must group key fields by precision, execution permissions, volume constraints, and swap/margin/sessions.
2. Dossier Specification remains richer while Current Focus Specification remains compact, both aligned to the same ownership model.
3. Optional or unsupported broker fields must be dynamically suppressed or marked unavailable without synthetic placeholders.

### Consequences
- Specification becomes clearly distinct from Market Watch and Overview roles.
- Tradeability constraints become easier to inspect quickly.
- Cross-surface alignment remains intact with density split.

### References
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `Aurora Sentinel Core/blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`

## Decision ID: D-026

### Date
2026-03-28

### Title
Layer 3 selection page is active pass/fail/pending evidence surface; Layer 4/5 remains out of scope

### Status
active

### Context
Task 6 requires a real Layer 3 symbol page that answers filter admission questioning without drifting into shortlist/deep-analysis logic.

### Decision
1. Layer 3 surfaces must render explicit pass/fail/pending filter posture with reasoning and next-step guidance.
2. Disqualifier and freshness dependency posture is mandatory where relevant.
3. Summary surfaces may carry compact Layer 3 posture counts only; no Layer 4/5 inference is admissible.

### Consequences
- Layer 3 now answers a distinct question from Overview/MarketWatch/Specification.
- Cross-surface ownership alignment is preserved.
- Layer 4/5 boundaries remain protected.

### References
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `Aurora Sentinel Core/blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`


## 2026-03-29 — D-016 Layer 4 activation and compact correlation line
- Layer 4 shortlist selection is active runtime truth.
- Market Board rows must publish `Cor <score> | High <sym1>, <sym2> | Low <sym1>, <sym2>`.
- Current Focus and Dossier must consume active shortlist rank/score/correlation truth.
- Layer 5 remains command-only.

## Decision ID: D-086
### Date
2026-04-02
### Title
Next recovery battlefield lock: HUD consumer-only boundary enforcement must precede further publication/dispatcher expansion
### Status
active

### Context
Deep debug takeover verified that active HUD runtime currently recomputes shortlist/filter truth locally and may substitute selected dossier readback as Current Focus readback. This creates a high-risk false-current surface despite lawful-looking publication mechanics.

### Decision
1. The next repair pass is locked to `mt5/hud/ASC_HUD_Manager.mqh` consumer-only enforcement only.
2. In-scope: remove/stop local shortlist rebuild and selection-filter recomputation in HUD paths; remove dossier-as-current-focus substitution behavior.
3. HUD must consume runtime-owned shortlist/state/artifact truth without becoming a second owner.
4. Dispatcher/layer engines/writers remain out of scope for this bounded repair unless strictly required for compile integrity.

### Consequences
- Highest-risk owner-boundary drift is addressed before widening other domains.
- Reduces risk of HUD presenting misleadingly current/aligned truth.

### References
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/runtime/ASC_Dispatcher.mqh`
- `Aurora Sentinel Core/mt5/io/ASC_FileIO.mqh`
- `Aurora Sentinel Core/office/WORK_LOG.md`

## Decision ID: D-093

### Date
2026-04-02

### Title
Phase 6 dossier deep-family extraction with explicit shell/payload policy ownership

### Status
active

### Context
Deep Selective Analysis subgroup rendering and shell/payload policy gates were still centralized in dossier composer flow, creating avoidable ownership concentration.

### Decision
1. Deep Selective Analysis dossier subgroup renderers move to `mt5/artifacts/dossier/deep_selective_analysis/` section-family files.
2. Shell/payload admission gates become explicit deep policy functions for normal-path shell posture, fresh payload projection admission, and preserved payload access.
3. Dossier composer remains sequence owner and call surface; writer remains compatibility wrapper.
4. No Layer 5 engine/entitlement/trigger redesign is admitted in this phase.

### Consequences
- Deep dossier subgroup ownership is explicit and bounded.
- Composer retains orchestration role without reabsorbing deep subgroup implementation details.
- Existing visible dossier scaffold contract remains intact.

### References
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/deep_selective_analysis/`
- `Aurora Sentinel Core/blueprint/final/03A_ASC_DOSSIER_LAYOUT_AND_COMPOSITION_LAW.md`

## Decision ID: D-094

### Date
2026-04-02

### Title
Phase 7 extracts dossier terminal sections into projection-only families

### Status
active

### Context
Trader Context and Recent Change Trace remained inline in composer and needed bounded family ownership without visible dossier contract drift.

### Decision
1. Extract Trader Context rendering into `mt5/artifacts/dossier/trader_context/ASC_DossierTraderContextSection.mqh`.
2. Extract Recent Change Trace rendering into `mt5/artifacts/dossier/recent_change_trace/ASC_DossierRecentChangeTraceSection.mqh`.
3. Keep composer as sequence owner and direct caller of terminal families.
4. Keep writer as compile entry/compatibility wrapper.
5. Do not redesign semantics for Trader Context or Recent Change Trace in this phase.

### Consequences
- Terminal sections now have explicit family ownership boundaries.
- Projection-only posture is preserved with no new trade-selection or transition engine ownership.
- Final writer-thinning remains deferred.

### References
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/trader_context/ASC_DossierTraderContextSection.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/recent_change_trace/ASC_DossierRecentChangeTraceSection.mqh`
- `Aurora Sentinel Core/blueprint/final/03A_ASC_DOSSIER_LAYOUT_AND_COMPOSITION_LAW.md`

## Decision ID: D-095

### Date
2026-04-02

### Title
Phase 8 finalizes dossier writer thinning and architecture completion posture

### Status
active

### Context
After Phase 7 extraction, writer still carried contract-construction residue. Final architecture required writer to remain compatibility-only and keep contract ownership with dossier contract owners.

### Decision
1. `ASC_DossierContract` ownership moves to `mt5/artifacts/dossier/ASC_DossierContracts.mqh`.
2. `ASC_DossierWriter.mqh` remains compile entry and publish bridge only, with no section rendering ownership.
3. Composer remains dossier assembly/orchestration owner consuming family renderers in canonical order.
4. Dossier folder redesign is complete at architecture level; no runtime/engine redesign is admitted.

### Consequences
- Writer now reflects true thin compatibility-wrapper posture.
- Dossier contract ownership is explicit and colocated with other dossier contracts.
- Visible dossier contract and publication behavior remain unchanged.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierContracts.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `Aurora Sentinel Core/blueprint/final/03A_ASC_DOSSIER_LAYOUT_AND_COMPOSITION_LAW.md`

## Decision ID: D-096

### Date
2026-04-02

### Title
Dossier consolidation pass locks repo-truth precedence over phase-label narration

### Status
active

### Context
Dossier architecture landed across mixed commits with phase-tagged office wording that can overstate isolated closure boundaries.

### Decision
1. Dossier architecture truth is governed by current HEAD code ownership, not PR titles or phase labels.
2. Writer/composer/common/family boundaries are assessed by live compile-reachable code paths.
3. Dossier office/blueprint wording must explicitly avoid claiming isolated phase closure when landing was mixed.
4. Consolidation cleanup may remove dossier-local duplication/drift without changing visible dossier contract or publication path.

### Consequences
- Future passes rely on code reality first and avoid phase-narrative drift.
- Dossier debugging scope narrows to concrete ownership evidence.

### References
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `Aurora Sentinel Core/mt5/artifacts/dossier/ASC_DossierContracts.mqh`
- `Aurora Sentinel Core/office/ROADMAP_STATUS.md`
- `Aurora Sentinel Core/blueprint/final/03A_ASC_DOSSIER_LAYOUT_AND_COMPOSITION_LAW.md`
