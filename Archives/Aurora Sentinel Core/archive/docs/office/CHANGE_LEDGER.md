## Ledger ID: CL-209

### Date
2026-04-06

### Change title
Layer-5 explicit pair-write/ownership hardening: deep-priority write admission + frozen-request alignment + explicit failure-family statuses

### Change class
bounded runtime reliability hardening for explicit Deep Analysis pair publication/readback ownership

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_RuntimeState.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- added explicit deep runtime ownership fields and lock lifecycle so explicit deep pair publication owns selected-symbol dossier/current-focus write path until completion
- removed broad-catchup hard deferral for explicit deep write service and promoted explicit deep to forced write-pressure lane admission while catchup context remains only as deferred-note evidence
- hardened explicit deep failure-family statuses to explicit `deep_pair_*` outcomes (`...failed_write/partial_publish/pair_mismatch/deep_truth/symbol_alignment/runtime_path/build`) with direct runtime status/reason propagation
- added frozen-request alignment check before pair publication and request-id payload stamping for explicit deep runs to reduce brittle no-material-change/retained false-failure paths
- parked ordinary selected-symbol view-sync when explicit deep ownership lock is active for the same symbol, surfacing ownership-conflict status instead of racing writes
- refreshed HUD deep trigger/lifecycle/current-focus outcome text mapping to the explicit `deep_pair_*` status families
- bumped version posture and refreshed ASC office continuity surfaces

### Operational effect
- explicit Deep Analysis now receives write-lane priority service even under broad backlog pressure and holds exclusive pair-write ownership for its selected symbol until completion
- readback/failure evidence is more deterministic because frozen symbol alignment and explicit failure families replace ambiguous blocked/fail wording
- ordinary selected-symbol sync can no longer quietly race and overwrite explicit deep pair ownership for the same symbol during active deep execution

## Ledger ID: CL-208

### Date
2026-04-06

### Change title
Layer-5 explicit override detachment: dedicated deep-override dossier mode + degraded tiered landing + frozen click-time symbol execution

### Change class
bounded Layer-5 execution-path detachment and truthful degraded-publication pass

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh` + `mt5/artifacts/dossier/ASC_DossierContracts.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + `mt5/core/ASC_RuntimeState.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- added dedicated dossier product mode `ASC_DOSSIER_MODE_DEEP_OVERRIDE` and routed explicit Deep Analysis pair publication through that mode (never closed-market mode), preserving Layer-5 section inclusion for closed/dormant symbols
- removed explicit deep hard blocks for unresolved classification and zeroed timeframe controls; deep build now applies safe fallback timeframes when configured enabled-timeframe count is zero
- replaced no-bars hard failure with truthful degraded publication tiers: full deep, historical-only, microstructure-only, and metadata/spec/session-only, with tier/context carried into the deep payload
- detached explicit deep trigger execution from moving HUD selection by freezing request symbol context at click-time and using frozen symbol/canonical/normalized fallback resolution in dispatcher service
- updated HUD deep posture/messaging to explicit-override language (including classification-unresolved, closed-context, fallback-timeframe, and detached entitlement messaging) and removed shortlist-entitlement-dependent operator wording
- bumped version posture and refreshed ASC office continuity surfaces

### Operational effect
- explicit Deep Analysis now lands Layer-5 dossier + Current Focus duplicate for selected symbols across closed/dormant/outside-shortlist/unresolved-classification and thin-data contexts, unless true catastrophic publication failures occur
- deep publication remains truthful under thin data by publishing reduced lawful payload tiers instead of failing solely due to missing copied bars
- request ownership is stable because deep execution no longer cancels when HUD selection changes after click-time

## Ledger ID: CL-207

### Date
2026-04-06

### Change title
Dossier persistence throttle recovery: aggressive hydration throughput + material-signature queue rebuild policy

### Change class
bounded runtime persistence throughput/rebuild optimization pass

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_RuntimeState.mqh` + `mt5/core/ASC_Version.mqh` + `office/SHA_LEDGER.md` + office sync surfaces

### What changed
- raised dossier persistence aggression under lawful pressure by increasing write streak tolerance and forcing earlier dossier-pressure persistence admission once broad catchup is complete
- materially increased dossier write budget floors for large backlog bands and relaxed scan-pressure clamps so hydration can flood on large universes while preserving broad-catchup guardrails
- added material-signature queue rebuild gating (`ASC_DossierPendingQueueRebuildDue`) so dossier pending queues rebuild only when needed (dirty, unready, material ownership change, or stall)
- removed wasteful queue-dirty behavior from non-due next-stage hydration transitions; queue rebuild now skips when material state is stable
- added runtime evidence logs for chosen dossier budget, throttle reason, rebuild decision/reason, and backlog before/after service beat
- added ASC SHA checkpoint ledger for active changed control/runtime/office surfaces
- bumped version posture for this throughput recovery pass

### Operational effect
- startup/continuation dossier hydration can consume materially larger budgets on large backlogs instead of dribbling behind scan pressure
- queue rebuild churn is reduced, lowering wasted persistence cycles and improving backlog progression continuity
- runtime/operator evidence now makes throttling/rebuild/progression reasons explicit and auditable

## Ledger ID: CL-206

### Date
2026-04-06

### Change title
Layer-5 deep-trigger same-cycle execution + retained no-material-change verification + selected-symbol write ownership repair

### Change class
bounded Layer-5 execution-path correctness repair

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- removed the queued-only heartbeat handoff in deep trigger service so `queued -> running` now immediately continues into same-cycle build/publish when persistence lane is admitted
- fixed retained/no-material-change verification branch coupling by running post-write strict pair readback only for non-retained writes (`!retained_pair`), preventing false failure on lawful already-current deep payloads
- added explicit selected-symbol pair-write ownership gate that parks ordinary Current Focus selected-symbol pair service when an active deep trigger owns the same symbol
- preserved strict retained/readback verification and failure-family mapping while improving deep trigger ownership defer reason visibility
- bumped version posture for this repair pass

### Operational effect
- explicit Deep Analysis requests no longer burn an extra admitted persistence beat just transitioning to running
- lawful no-material-change deep outcomes can verify as retained continuity without falling into non-retained strict branch false failures
- selected-symbol view-sync pair writes no longer race/overwrite deep-trigger-owned pair publication for the same symbol

## Ledger ID: CL-205

### Date
2026-04-06

### Change title
Layer-5 retained-pair override-context verification hotfix for truthful continuity classification

### Change class
bounded Layer-5 verification/failure-classification repair

### Stage / domain
`mt5/artifacts/dossier/ASC_DossierComposer.mqh` + `mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- hardened retained dossier/current-focus pair verification (deep-required path) to require override-context labels in both artifacts
- classified retained-pair override-context-missing outcomes as `failed_deep_truth` in dispatcher readback failure mapping
- bumped version label and recorded this repair in office continuity surfaces

### Operational effect
- prevents false continuity success when retained deep payloads lack override-context evidence
- keeps override-mode Layer-5 success/failure truth stricter and more trustworthy for operator-facing HUD/runtime status


## Ledger ID: CL-204

### Date
2026-04-06

### Change title
Enable explicit selected-symbol Deep Analysis landing; add L3/L4 cadence and shortlist liveliness fixes (#374)

### Change class
bounded integration/bookkeeping alignment pass (no new runtime redesign)

### Stage / domain
`mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- validated that current HEAD still carries the required L3/L4 cadence and shortlist liveliness hardening in compile-owned paths from prior hotfix passes
- updated version posture label to an integrated `Fix374` scope so runtime/operator bookkeeping references the bundled deep-landing + cadence/liveliness delivery intent
- recorded issue-374 integration alignment in office continuity surfaces

### Operational effect
- version/control surfaces now directly reflect the integrated #374 scope already present in code
- reduces drift between landed runtime behavior and top-of-stack ledger/version labeling


## Ledger ID: CL-203

### Date
2026-04-06

### Change title
Layer-5 explicit selected-symbol landing finalization: override-context deep payload + strict pair/readback truth + HUD lifecycle alignment

### Change class
hard forensic + bounded Layer-5 implementation repair (no Layer 3/4 redesign)

### Stage / domain
`mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh` + `mt5/artifacts/dossier/ASC_DossierComposer.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- removed remaining promoted/open shortlist hard-block entitlement gates from deep build path and switched to explicit selected-symbol override entitlement while keeping provenance/classification/explicit-action law
- added canonical override context labels to deep payload contract (`execution_context`, `shortlist_context`, `shortlist_rank`, `market_state_context`, `support_posture`, `build_context`) so non-promoted/reserve/outside-shortlist/closed runs keep truthful context in final dossier + Current Focus duplicate
- hardened `ASC_DossierPayloadHasFreshDeepTruth(...)` to require these override labels during deep success verification, preventing false success when context labels are missing
- updated HUD deep posture and relationship wording to report explicit override readiness/lifecycle truth instead of promoted-only gating language
- kept one-canonical-payload law intact: dispatcher still composes once and pair-publishes to dossier + Current Focus with strict post-write verification
- bumped version label for Layer-5 landing finalization tracking

### Operational effect
- explicit selected-symbol Deep Analysis can lawfully land end-to-end beyond promoted-open shortlist contexts when build data is available
- pair-readback success is stricter because completed deep truth now includes override-context evidence, not just generic deep section presence
- HUD now describes final deep posture/lifecycle in explicit-override terms that match runtime behavior


## Ledger ID: CL-202

### Date
2026-04-06

### Change title
Current Focus baseline reliability hotfix: durable selected-symbol queueing + catchup-safe baseline pair service

### Change class
bounded selected-symbol baseline reliability patch (no Deep override redesign)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- hardened unresolved selected-symbol reconciliation to keep baseline sync queued (`current_focus_view_pending/current_focus_view_symbol`) instead of returning deferred-only
- removed broad-catchup hard gate that blocked ordinary selected-symbol Current Focus pair service when write was due
- preserved explicit Deep-trigger catchup protections while allowing baseline selected-symbol pair writes to proceed
- refreshed HUD selected-symbol queue timestamps so explicit queue/deferred actions refresh request timing for the current symbol
- bumped version label for this baseline reliability pass

### Operational effect
- Current Focus baseline pair service is less likely to remain absent/stale under long broad-catchup windows
- selected-symbol sync request state remains more durable and truthful from HUD observation to runtime consumption


## Ledger ID: CL-201

### Date
2026-04-06

### Change title
Layer-3/Layer-4 cadence deadline hotfix: stop next-recheck sliding under reuse

### Change class
bounded runtime cadence correctness hotfix (deadline ownership + traceability)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- fixed Layer-3/Layer-4 non-forced reuse branches so `committed_*_next_recheck_utc` is not repeatedly pushed forward on each reuse touch
- preserved initialization behavior when next-recheck fields are empty, while keeping existing deadlines intact otherwise
- added explicit per-layer cadence schedule/execute traces for Layer 3 and Layer 4
- added explicit bucket-top5 change trace line on material bucket-driven shortlist changes
- bumped version label for hotfix tracking

### Operational effect
- minute cadence no longer stalls behind frequent reuse calls
- shortlist cadence telemetry is now clearer for diagnosing schedule vs execution outcomes and bucket-top5 movement


## Ledger ID: CL-200

### Date
2026-04-06

### Change title
Layer-3/Layer-4 one-minute cadence hardening for live shortlist and bucket top-5 competition

### Change class
bounded runtime cadence + shortlist anti-sticky rebalance patch (no Layer-5 redesign)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_RuntimeState.mqh` + `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- added committed selection cadence fields (`committed_l3_next_recheck_utc`, `committed_l4_next_recheck_utc`) and reset wiring in runtime state ownership
- hardened Layer-3/Layer-4 commit path to support forced minute-cadence rechecks for open-symbol scope even when scanner pass timestamp has not advanced
- added shortlist material-change comparators (global shortlist membership signature + bucket top-5 signature) so rewrite triggering keys off real shortlist competition changes
- added dispatcher cadence traceability logs for schedule/execute cadence events, shortlist challenge held/accepted/stable outcomes, and rewrite triggered/skipped outcomes
- added runtime cadence hook in heartbeat flow to run one-minute open-symbol selection refresh before lane dispatch
- wired material shortlist/bucket change to bounded publication pending flags plus open-symbol dossier refresh request
- reduced shortlist stickiness by rebalancing hold/challenge/material-shift thresholds (`hold 30s`, `dirty challenge beats 1`, lower material delta thresholds)
- bumped ASC version label for this pass

### Operational effect
- Layer 3 and Layer 4 now stay live on one-minute cadence for open symbols instead of passively waiting for slower ownership conditions
- bucket top-5 remains competitive and can change promptly when challengers lawfully outrank incumbents
- publication remains bounded: material shortlist/top-5 changes trigger rewrite; non-material cadence passes log skip rationale without fake churn


## Ledger ID: CL-199

### Date
2026-04-06

### Change title
Final Layer-5 HUD/operator polish + selected-symbol counter semantics split

### Change class
bounded finalization patch (operator wording cleanup + telemetry semantics discipline)

### Stage / domain
`mt5/hud/ASC_HUD_Manager.mqh` + `mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_RuntimeState.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- added operator-facing Current Focus outcome mapper for deep/selected-symbol statuses so HUD stops showing raw status-like phrasing as primary operator copy
- refined Deep Analysis cards to preserve proof facts while presenting cleaner lifecycle/readback/ownership language
- finalized deep lifecycle wording to distinguish view-opened-only, queued, running, blocked, build failed, partial publish, pair mismatch, deep truth missing, continuity retained, and succeeded
- introduced `selected_symbol_runtime_request_count` so runtime reconciliation-created selected-symbol queue actions are tracked separately from explicit HUD requests
- updated runtime telemetry/manifest wording to report selected-symbol explicit requests and runtime reconciliation requests as separate counters
- bumped ASC version label/date for this finalization pass

### Operational effect
- Deep View reads like a finished operator surface while remaining runtime-truthful
- acceptance testers can now prove request semantics without ambiguous “request” counter inflation from mixed explicit/reconciliation meanings


## Ledger ID: CL-198

### Date
2026-04-05

### Change title
Final Layer-5 HUD proof hardening: lifecycle/alignment/blocker truth and runtime-driven deep-page refresh signal

### Change class
bounded HUD truth/proof patch (operator lifecycle clarity + runtime proof-field refresh coupling)

### Stage / domain
`mt5/hud/ASC_HUD_Manager.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- added runtime proof fields into HUD state for deep/current-focus lifecycle evidence (runtime reason, current-focus outcome/reason/live symbol/served timestamp)
- integrated these fields into tactical signature to force truthful deep-page refresh when runtime lifecycle or alignment state changes
- rewrote deep page status card lines to show request symbol ownership, selected-symbol match, current-focus live symbol + match, last write outcome, and blocker/latest runtime reason
- retained explicit-action messaging (`Run Deep Analysis`) and made page wording less optimistic when truth is incomplete
- bumped ASC version label for final Layer-5 HUD-proof pass

### Operational effect
- removes “nothing happened” feel by surfacing concrete request/consumption/outcome/alignment evidence on the deep page
- stale mismatch wording is less likely to linger because runtime lifecycle/reason/alignment fields now participate in HUD tactical refresh signature
- improves manual tester ability to prove end-to-end deep trigger behavior from HUD + logs


## Ledger ID: CL-197

### Date
2026-04-05

### Change title
Layer-5 pair-publish/readback landing hardening: classified deep pair verification failures and explicit pair-attempt/result traces

### Change class
bounded Layer-5 publication/verification hardening patch (pair-write observability + post-write failure taxonomy)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- added explicit deep pair-publish attempt trace including selected canonical symbol and dossier/current-focus contract paths
- introduced `ASC_DeepReadbackFailureStatus(...)` helper to classify deep pair verification reasons into partial/mismatch/deep-truth failure families
- applied classification to retained-pair verification failures and direct pair-readback verification failures (instead of generic `failed_write` collapse)
- added explicit traces for classified readback failures and verified pair success/continuity outcomes
- preserved atomic pair-write and retained-pair verification laws
- bumped ASC version label for this pass

### Operational effect
- deep pair landing failures are now easier to diagnose by failure family
- success/continuity logs now better prove that deep completion was pair-published and verified as a selected-symbol dossier/current-focus pair
- reduces ambiguous “served but unclear landing state” posture


## Ledger ID: CL-196

### Date
2026-04-05

### Change title
Layer-5 deep admission/build truth repair: precise gate ordering, packet-resolution fallback, and explicit no-data build-failure state

### Change class
bounded Layer-5 compute-path hardening patch (admission ordering + build completion truth + runtime/HUD status mapping)

### Stage / domain
`mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh` + `mt5/runtime/ASC_Dispatcher.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- reordered deep entitlement checks so classification/open/shortlist/promotion blockers are reported before lower-layer packet blockers
- replaced deep packet lookup with shortlist-style multi-symbol fallback resolver for selected symbol continuity
- aligned deep canonical fallback with identity canonical continuity chain
- introduced `BUILD_FAILED` entitlement/failure state when all enabled timeframes copy zero bars, preventing false completed deep status with empty subsection substance
- mapped `BUILD_FAILED` to runtime trigger status `failed_build` and added HUD operator text for this failure family
- added runtime trace logs for deep entitlement evaluation and deep build start/failure points
- bumped ASC version label for this pass

### Operational effect
- entitled deep requests now require meaningful bar-copy evidence to be treated as completed
- non-entitled and no-data deep requests now surface explicit, auditable blocker/failure reasons
- improves trust that “trigger served” means either completed lawful deep build or an exact blocked/failure state


## Ledger ID: CL-195

### Date
2026-04-05

### Change title
Layer-5 explicit trigger semantics repair: separate deep-page navigation from explicit execution and harden click->queue->intake observability

### Change class
bounded trigger-semantics patch (HUD control semantics + runtime intake traceability)

### Stage / domain
`mt5/hud/ASC_HUD_Manager.mqh` + `mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- explicit action button caption changed to `Run Deep Analysis`; deep section tab caption changed to `Deep View` to reduce operator ambiguity between view navigation and execution request
- deep tab (`sym_stat_6`) now emits explicit navigation-only notice and trace log confirming no trigger was armed
- Deep action click path now logs click reception, context validation, rejection-before-queue, and successful arm events
- Deep trigger emitter now logs request creation/rejection/arming and updates HUD-local trigger status to `queued` immediately for visible feedback continuity
- runtime deep-trigger intake now logs request intake metadata, queued->running transition, blocked outcomes, and symbol-not-found failure at intake edge
- version label bumped for this pass

### Operational effect
- opening the Deep view is now clearly a navigation action only
- explicit action button remains the sole lawful trigger source and is easier to audit end-to-end via logs/status
- operator receives clearer immediate feedback when action is accepted or rejected


## Ledger ID: CL-194

### Date
2026-04-05

### Change title
Layer 0–4 prerequisite truth hardening: canonical-symbol continuity, committed-shortlist fallback, and selected-symbol readiness wording repair

### Change class
bounded ownership/readiness hardening patch (canonical continuity + shortlist ownership fallback + operator readiness truth)

### Stage / domain
`mt5/artifacts/dossier/ASC_DossierComposer.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + `mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- aligned canonical resolution in canonical dossier composer with runtime/writer continuity chain by inserting `identity.canonical_symbol` fallback before normalized symbol fallback
- added HUD shortlist cache fallback to committed Layer-4 rows when publication shortlist rows are not yet available, preventing false shortlist-unknown posture during publication lag
- added prerequisite-aware deep relationship wording for shortlist context so operator sees lawful blockers (waiting rank, not promoted, selected-symbol alignment pending) instead of premature readiness wording
- tightened Deep Analysis posture projection to require selected-symbol readback/alignment before “ready” wording persists
- added runtime trace logging for selected-symbol canonical resolution, selected-symbol shortlist posture/rank context, and dossier/current-focus contract paths in Current Focus selected-symbol service path
- bumped ASC version label for this implementation pass

### Operational effect
- reduces opportunities for cross-symbol canonical drift between HUD/readback and dossier contract ownership
- keeps shortlist/promotion posture on HUD anchored to runtime committed ownership when publication shortlist timing lags
- improves operator trust by avoiding optimistic deep-readiness posture while selected-symbol pair alignment is still unresolved


## Ledger ID: CL-193

### Date
2026-04-05

### Change title
Layer 0–4 selected-symbol ownership repair: lawful HUD ownership sync, truthful selected-symbol queue counters, and honest Current Focus alignment status

### Change class
bounded runtime/HUD repair patch (ownership-chain hardening + status/logging truth correction)

### Stage / domain
`mt5/hud/ASC_HUD_Manager.mqh` + `mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_Version.mqh` + office sync surfaces

### What changed
- added HUD-to-runtime selected-symbol ownership sync helper so symbol-context navigation continuously refreshes runtime selected symbol and observation timestamp from resolvable Layer-1 truth
- changed HUD selected-symbol queue flow so duplicate same-symbol queue attempts are marked deferred (not re-counted) while genuine queue creation still increments `selected_symbol_request_count`
- added explicit selected-symbol trace logs for observed, queued, deferred, served, and already-current outcomes across HUD queueing and runtime reconciliation/service paths
- hardened runtime reconcile behavior when HUD selected symbol is temporarily unresolved by recording deferred status/reason instead of silently returning
- tightened Deep Analysis readback alignment wording so mismatch text appears only when readback exists but points elsewhere; missing readback now reports unavailable posture
- bumped ASC version label/date for continuity posture after this repair pass

### Operational effect
- reduces false “not selected” and stale-mismatch operator posture when symbol context is active
- keeps selected-symbol queue counters and runtime status closer to actual queue/write lifecycle truth
- preserves pair-verification law and avoids forced per-heartbeat rewrites while still reconciling lawful mismatch/staleness cases


## Ledger ID: CL-192

### Date
2026-04-05

### Change title
HUD Deep Analysis readiness alignment: replace stale 11/11 counters with canonical 8/8 contract truth

### Change class
bounded HUD truth-alignment patch (operator-readiness messaging correction; no ownership shift)

### Stage / domain
`mt5/hud/ASC_HUD_Manager.mqh` + office sync surfaces

### What changed
- updated `ASC_HudDeepReadinessSummary(...)` to report readiness against the current canonical deep subsection family count (`8`) instead of obsolete `11`
- updated completed readiness text to `subsections ready 8/8`
- updated non-completed readiness text to `subsections ready 0/8`
- updated Deep Analysis page fallback readiness string (`no matching readback`) from `0/11` to `0/8`

### Operational effect
- HUD readiness messaging now matches current canonical Layer-5 completion contract and no longer implies missing sections that were intentionally retired
- improves operator trust/readability without reintroducing legacy deep scaffold sections or heavy normal-path computation


## Ledger ID: CL-191

### Date
2026-04-05

### Change title
HUD Deep Analysis compile fix: use global runtime owner for verification hint reason text

### Change class
bounded compile-fix patch (scope correction; no behavior redesign)

### Stage / domain
`mt5/hud/ASC_HUD_Manager.mqh` + office sync surfaces

### What changed
- replaced out-of-scope `runtime.deep_focus_last_reason` access in Deep Analysis HUD render path with `g_asc_runtime.deep_focus_last_reason`
- preserved existing verification hint rendering contract on the readback card (`Runtime reason: ...`)
- kept all deep lifecycle/readback/preview logic unchanged aside from scope-correct runtime source access

### Operational effect
- removes the reported `undeclared identifier 'runtime'` compile failure at the Deep Analysis HUD card block and the cascade parse errors that followed at that line
- keeps HUD consumer-only behavior and runtime-owned reason sourcing intact


## Ledger ID: CL-190

### Date
2026-04-05

### Change title
Layer-5 residual drag cleanup: remove dead legacy deep computation from ordinary canonical dossier path

### Change class
bounded Layer-5 cleanup/finalization patch (dead computation removal; no canonical-path redesign)

### Stage / domain
`mt5/artifacts/dossier/ASC_DossierComposer.mqh` + office sync surfaces

### What changed
- removed obsolete deep-adjacent helper functions in composer that were no longer connected to emitted Layer-5 output (`ASC_DossierIsHigherTimeframe`, `ASC_DossierDefaultOhlcDepth`, `ASC_DossierConfiguredOhlcDepth`, `ASC_DossierBuildOhlcEvidenceByEnabledTimeframes`)
- removed residual dead Layer-5 intermediate computation block from canonical payload builder (timeframe/depth placeholders, OHLC evidence projection, price-map/microstructure/regime/external/trade/handoff placeholder preparation) that no longer contributes to final payload body
- removed dead deep-related section-status struct declarations corresponding to legacy subsection outputs that are no longer rendered
- preserved canonical Layer-5 body insertion (`body += deep_section`) and left pair-publish/readback/HUD consumer paths unchanged

### Operational effect
- ordinary selected-symbol canonical payload assembly no longer performs unnecessary legacy Layer-5 heavy/dead prep work
- explicit-trigger deep heaviness boundary is cleaner in code: heavy deep work remains in deep-engine explicit-trigger path, while canonical builder mirrors resolved/preserved deep section without extra legacy computation


## Ledger ID: CL-189

### Date
2026-04-05

### Change title
Layer-5 canonical integration finalization: deep section now lands in final canonical dossier body and legacy split scaffold path is retired

### Change class
bounded Layer-5 canonical-path integration patch (composer inclusion law + split-brain drift removal)

### Stage / domain
`mt5/artifacts/dossier/ASC_DossierComposer.mqh` + `mt5/artifacts/dossier/ASC_DossierContracts.mqh` + office sync surfaces

### What changed
- confirmed canonical dossier composition still forced `include_l5_section = false`, preventing Layer-5 section landing in final body output even when deep completion existed
- changed canonical dossier inclusion law to include L5 section in non-closed canonical mode and append the resolved canonical `deep_section` text directly under `DEEP SELECTIVE ANALYSIS [L5]`
- removed legacy split deep subsection builder chain from composer (activation/timeframe/OHLC/price-map/microstructure/regime/external/trade/handoff) so canonical deep block is the only active Layer-5 payload representation
- removed now-obsolete legacy deep subsection include dependencies from composer
- updated L5 subgroup contract in dossier contracts to the canonical deep block subsection family and removed stale normal-path shell-only helper wording

### Operational effect
- completed deep truth now lands in the final canonical payload body instead of remaining status/header-only context
- dossier and Current Focus remain aligned through one payload source because dispatcher/current-focus pair-publish the same canonical payload output
- HUD timeframe preview continues as consumer-only parsing against a now-guaranteed canonical deep section contract


## Ledger ID: CL-188

### Date
2026-04-05

### Change title
HUD Deep Analysis page finish: explicit lifecycle/readback families and compact canonical timeframe preview

### Change class
bounded HUD consumer-surface hardening patch (status/readback projection + compact preview; no ownership shift)

### Stage / domain
`mt5/hud/ASC_HUD_Manager.mqh` + office sync surfaces

### What changed
- extended HUD deep lifecycle mapping to surface explicit failed-family UI states (partial/mismatch/deep-truth) rather than collapsing all `failed_*` runtime statuses to one generic label
- extended HUD trigger status text mapping for newly explicit runtime deep verification outcomes (`failed_partial_publish`, `failed_pair_mismatch`, `failed_deep_truth`)
- implemented compact timeframe-row field extraction for preview (`ATR`, `ATR%%`, `Regime`, `Friction Posture`, `Liquidity Posture`, `Spread Posture`, `Freshness/Readiness Note`) from canonical readback text without local metric computation
- improved readback card alignment messaging to show selected-symbol match and canonical match separately and include runtime deep verification reason context
- preserved explicit trigger-only behavior and consumer-only HUD boundary (no deep payload composition or metric ownership moved into HUD)

### Operational effect
- HUD Deep Analysis page is now a clearer operational surface for trigger/lifecycle/readback truth
- readback mismatch/partial/deep-truth failures are more visible and less likely to be mistaken for completion
- compact timeframe preview remains strictly consumer-side by parsing canonical deep payload output


## Ledger ID: CL-187

### Date
2026-04-05

### Change title
Layer-5 readback verification hardening: bilateral symbol/canonical checks and explicit deep pair failure families

### Change class
bounded Layer-5 verification patch (post-publish readback strictness + status truth hardening)

### Stage / domain
`mt5/artifacts/dossier/ASC_DossierComposer.mqh` + `mt5/runtime/ASC_Dispatcher.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + office sync surfaces

### What changed
- hardened retained dossier/current-focus pair verification to require symbol-context checks on both artifacts and canonical-symbol alignment checks on both artifacts when canonical context is present
- expanded deep-trigger readback verification classification in dispatcher so post-publish failure outcomes are separated into partial artifact landing, pair mismatch, and deep-truth-missing families
- introduced explicit verification-code derivation for deep readback failures (missing side, publication/payload mismatch, symbol/canonical mismatch, deep truth missing) and propagated these into runtime/current-focus reason surfaces
- updated deep-trigger runtime status stamping to use explicit failure families (`failed_partial_publish`, `failed_pair_mismatch`, `failed_deep_truth`) instead of a single generic `failed_write` label for all readback failures
- updated HUD trigger-status text/lifecycle mapping to consume the expanded deep failure family so UI does not soften strict verification outcomes

### Operational effect
- full deep success now more clearly means both dossier and Current Focus were verified with expected symbol/canonical alignment and deep truth
- partial/mismatch/deep-truth failures are easier to diagnose and less likely to be misread as generic write issues
- continuity remains distinct from fresh success and is not conflated with failed/partial outcomes


## Ledger ID: CL-186

### Date
2026-04-05

### Change title
Layer-5 entitlement/execution law hardening: explicit blocked families, execution-time lower-layer revalidation, and one-symbol trigger guard

### Change class
bounded Layer-5 runtime hardening patch (entitlement contract + status alignment; no Layer 3-4 redesign)

### Stage / domain
`mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh` + `mt5/runtime/ASC_Dispatcher.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + office sync surfaces

### What changed
- formalized deep entitlement status-family contract in deep owner gate with explicit reasons for selected-symbol mismatch, controls disabled, classification unresolved, shortlist missing/not-shortlisted, promotion required, not-open, and lower-layer unavailable/insufficient
- extended entitlement inputs to include execution-time Layer-2 packet posture (`has_packet`, freshness) and block deep execution when packet support is missing or stale/degraded
- expanded dispatcher blocked-status mapping so deep trigger lifecycle reports explicit blocked tokens instead of collapsing most failures into generic `blocked_not_entitled`
- updated HUD trigger-status text + lifecycle blocked mapping to consume and display the expanded blocked family coherently
- aligned HUD deep-action pre-admission with lower-layer packet law and added a one-symbol-at-a-time guard that blocks queueing a different symbol while a deep trigger is already pending

### Operational effect
- deep trigger entitlement is more explicit and less implicit at execution time
- blocked reasons are more operator-readable and stable across runtime/HUD surfaces
- selected-symbol-only and one-symbol-at-a-time deep trigger behavior is more explicit without widening Layer-5 scope


## Ledger ID: CL-185

### Date
2026-04-05

### Change title
Layer-5 presentation-order hardening: summary-first deep section and compact deep-absent posture

### Change class
bounded Layer-5 presentation contract patch (ordering/readability + placeholder minimization; no ownership redesign)

### Stage / domain
`mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh` + `mt5/artifacts/dossier/ASC_DossierComposer.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + office sync surfaces

### What changed
- hardened completed deep top block to expose operator-first header fields before subsection payloads (status, symbol/canonical, trigger provenance, entitlement, refresh, freshness, continuity, run summary)
- enforced concise canonical section order for completed deep output: `deep_analysis_overview` -> `cross_timeframe_summary` -> `timeframe_analytic_summary` -> `decision_support` -> `ohlc_by_enabled_timeframe` -> `recent_tick_activity` -> `live_spread_rollover` -> `preservation_state`
- removed non-essential intermediate deep sections that diluted readability and could front-load noise (`deep_data_family_contract`, `timeframe_settings`, `bar_pack`, `bar_interpretation`, `microstructure_notes`, `advanced_context`)
- minimized deep-absent placeholder output to compact truthful status/summary/guardrail lines and removed fake raw-evidence placeholder walls
- updated deep-completed validation required-section list to match the hardened canonical order and required section set
- adjusted HUD timeframe preview parser to stop at `decision_support` (with legacy fallback), preserving consumer preview behavior after section simplification

### Operational effect
- operators now read Layer-5 in the intended top-down order (summary/interpretation first, proof later)
- deep-absent mode no longer floods dossier/current-focus with large unavailable walls
- dossier and Current Focus continue to mirror identical deep structure because both consume the same canonical payload


## Ledger ID: CL-184

### Date
2026-04-05

### Change title
Layer-5 implementation pass: compile-real timeframe-owned metrics for ATR/regime/volatility/drift/range with lawful microstructure projection

### Change class
bounded Layer-5 implementation patch (metric computation + payload wiring hardening; no Layer 3-4 redesign)

### Stage / domain
`mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh` + office sync surfaces

### What changed
- added explicit per-timeframe ATR(14) computation from copied timeframe bars (true-range average) with minimum-bar and sample sufficiency guards
- added per-timeframe ATR% computation with zero/invalid-price guards and explicit unavailable wording when evidence is insufficient
- added per-timeframe regime, volatility posture, drift posture, and range posture classification derived from each timeframe row's own bar window evidence
- added lawful microstructure projection logic: shared live spread-window support is computed once, then projected into each timeframe row as spread/friction/liquidity posture using spread-to-timeframe-ATR ratio (with explicit unavailable wording if spread support or ATR support is missing)
- replaced contract-pending placeholders in `timeframe_analytic_summary` rows with compile-real metric outputs and explicit readiness notes (`ready`, `partial`, `insufficient`) tied to bars/ATR/spread sufficiency
- kept deep payload family ordering intact so timeframe summaries remain before raw OHLC evidence and preserved canonical payload reuse for dossier + Current Focus + HUD preview consumers

### Operational effect
- Deep Analysis now provides real per-timeframe Layer-5 metric evidence instead of placeholder contract wording
- timeframe ownership is explicit per row, with honest missingness when bar or microstructure support is insufficient
- dossier and Current Focus keep one canonical deep truth payload while HUD remains consumer-only


## Ledger ID: CL-183

### Date
2026-04-05

### Change title
Layer-5 timeframe analytics contract formalization (family classification, stable timeframe rows, cross-timeframe header, and raw-evidence ordering)

### Change class
bounded Layer-5 contract hardening patch (design-to-implementation bridge; metric computation intentionally deferred)

### Stage / domain
`mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh` + `mt5/artifacts/dossier/ASC_DossierComposer.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + `mt5/artifacts/ASC_CurrentFocusWriter.mqh` + office sync surfaces

### What changed
- added explicit Layer-5 data-family contract section in deep output (`deep_data_family_contract`) to classify timeframe-owned analytics vs cross-timeframe summary vs raw evidence
- added explicit cross-timeframe summary section (`cross_timeframe_summary`) and stable per-timeframe summary section (`timeframe_analytic_summary`) with fixed field order and honest missingness posture
- reordered deep output scaffold so operator-summary contract blocks appear before raw-evidence-heavy sections
- updated dossier deep placeholder and deep-completion section requirements so the new contract sections are present in both unavailable and completed deep payload states
- added HUD compact timeframe-summary preview extraction from Current Focus readback as a consumer-only projection

### Operational effect
- Layer-5 contract ownership is now explicit and compile-real before full metric implementation
- Current Focus and dossier can mirror one stable deep contract structure without local HUD re-derivation
- next implementation pass can land per-timeframe ATR/regime/liquidity/friction/spread metrics into fixed contract slots without ambiguity


## Ledger ID: CL-182

### Date
2026-04-05

### Change title
Light-vs-heavy separation hardening: explicit Current Focus status families for viewed sync vs deep-trigger outcomes

### Change class
bounded runtime semantics hardening patch (request/status separation; no deep-content redesign)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + office sync surfaces

### What changed
- introduced explicit Current Focus status-family separation in dispatcher: `view_*` for light selected-symbol sync outcomes and `deep_pair_*` for explicit deep-trigger pair outcomes
- extended selected-symbol sync stable-status admission to include the expanded family tokens while retaining backward-compatible recognition for legacy tokens
- stopped deep-trigger HUD queue path from incrementing `selected_symbol_request_count`, preserving request-metric separation between light view-sync and explicit deep-trigger requests
- stamped HUD view-sync queue state as `view_queued` to keep browsing/sync notices distinct from deep-trigger lifecycle semantics

### Operational effect
- ordinary selected-symbol sync success/failure state can no longer be mistaken for deep-trigger success/failure by raw status token alone
- deep-trigger lifecycle remains explicit and separate while Current Focus duplicate law stays intact
- browse-trigger accounting and deep-trigger accounting are less mixed in runtime counters


## Ledger ID: CL-181

### Date
2026-04-05

### Change title
Current Focus duplication hardening: writer path now enforces dossier/current-focus pair publication and verification

### Change class
bounded Layer-5 ownership hardening patch (duplicate-law enforcement + target-path safety guards)

### Stage / domain
`mt5/artifacts/ASC_CurrentFocusWriter.mqh` + `mt5/runtime/ASC_Dispatcher.mqh` + office sync surfaces

### What changed
- changed `ASC_CurrentFocusWriter.mqh` from single-file Current Focus write to canonical pair publish (`dossier/<symbol>.txt` + `Current Focus.txt`) using one payload and pair readback verification
- added retained/no-material-change handling in Current Focus writer parity with dispatcher duplicate-law behavior
- added dispatcher guardrails to fail fast when dossier/current-focus target paths are unavailable or collide, preventing accidental single-target collapse

### Operational effect
- Current Focus writer can no longer silently diverge from dossier duplication law if invoked
- pair-target contract integrity is now explicitly checked before deep/view pair publication
- duplication-law enforcement is strengthened across compile-reachable surfaces, not only the active dispatcher path


## Ledger ID: CL-180

### Date
2026-04-05

### Change title
Layer-5 ownership hardening: explicit deep-trigger pair verification now treats unchanged payloads as retained-pair proof (no false write-success/failure drift)

### Change class
bounded runtime ownership hardening patch (selected-symbol deep-trigger publication/readback integrity + HUD/Current-Focus boundary annotation)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + `mt5/artifacts/ASC_CurrentFocusWriter.mqh` + office sync surfaces

### What changed
- deep-trigger pair publication now recognizes unchanged payload writes (`reason=no_material_change`) as retained-pair state and routes them through retained dossier/current-focus verification instead of strict exact-payload readback against a newly composed header
- deep-trigger completion remains strict: success/continuity requires selected-symbol pair alignment, freshness-floor validity, and completed Deep Analysis truth across both dossier and Current Focus
- deep-trigger telemetry/status/reason handling now distinguishes retained/unchanged pair states from true pair writes so write-count telemetry does not overclaim artifact writes when no write occurred
- added explicit comments to keep HUD as trigger/readback-only boundary and Current Focus as canonical dossier-duplicate surface (not independent intelligence composition)

### Operational effect
- deep-trigger completion claims are more truthful under no-material-change cycles
- pair-publish/readback ownership remains one canonical payload path for dossier + Current Focus
- HUD boundary posture is documented in code where trigger queueing happens


## Ledger ID: CL-179

### Date
2026-04-05

### Change title
End-to-end Layer 3–4 consumer-truth alignment: shortlist state/posture fidelity + proxy peer-similarity contract parity

### Change class
bounded consumer-projection alignment patch (dossier/board/HUD fidelity hardening; no producer doctrine redesign)

### Stage / domain
`mt5/artifacts/dossier/ASC_DossierComposer.mqh` + `mt5/artifacts/dossier/shortlist_selection/ASC_DossierCorrelationExposureSection.mqh` + `mt5/artifacts/ASC_MarketBoardWriter.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + office sync surfaces

### What changed
- fixed Market Board required-token contract drift so token validation expects the rendered `Proxy Peer Similarity:` heading (instead of legacy `Peer Similarity:` token)
- updated dossier shortlist-core and stability/hold projection lines to include producer membership and stability posture carry, reducing shortlist-band/posture ambiguity on consumer output
- updated dossier shortlist correlation/exposure section heading and score label to `Proxy Peer Similarity` wording
- updated HUD shortlist priority/reason/scope lines to consume producer `membership_state`, `shortlist_band`, `shortlist_posture`, and `shortlist_reason` more faithfully
- removed reserve-vs-shortlisted conflation in HUD leader-row status chip logic (`Reserve` no longer marks as shortlisted)
- confirmed Current Focus remains consumer-only by inheriting canonical dossier payload path without local shortlist truth invention

### Operational effect
- Layer 3–4 producer truth now projects more consistently across dossier, Market Board, and HUD surfaces
- reserve/pending/blocked/shortlisted/promoted semantics are less likely to drift through local consumer wording
- proxy peer-similarity labeling and token checks are now contract-consistent end to end


## Ledger ID: CL-178

### Date
2026-04-05

### Change title
Layer-4 shortlist authority hardening: state-family separation + transparent priority scoring + proxy peer-similarity honesty

### Change class
bounded Layer-4 producer hardening patch (shortlist law/stability + score transparency + correlation semantics clarity)

### Stage / domain
`mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh` + `mt5/shortlist_selection/ASC_CorrelationSummaryEngine.mqh` + `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` + `mt5/artifacts/ASC_MarketBoardWriter.mqh` + office sync surfaces

### What changed
- added explicit shortlist row state-family carry (`membership_state`, `shortlist_stability_posture`) so membership/band/stability posture semantics are less conflated
- reworked Layer-4 shortlist score into a PASS-only transparent shortlist-priority model (execution efficiency + freshness priority + context readiness) and removed broad mixed-policy re-scoring of Layer-3 gate checks
- hardened material-shift detection: top-symbol replacement now requires meaningful score advantage (`>= 5.0`) instead of triggering on any top-symbol swap, reducing blunt rotation
- preserved bounded shortlist law (top-10 global, top-5 per bucket) and existing invalid/dirty-held continuity safeguards
- documented and enforced proxy semantics in similarity scoring path (not statistical return correlation), with reduced name-similarity weighting in packet-missing fallback branches
- aligned board/helper wording to `Proxy Peer Similarity` so downstream operator surfaces do not overclaim method semantics

### Operational effect
- Layer-4 remains shortlist authority rather than hidden signal brain, with clearer row semantics and more bounded score intent
- shortlist continuity behavior is less jumpy under minor top-symbol swaps while preserving lawful invalid/material-shift rebuild paths
- peer-context carry is more honest about method limits and fallback behavior


## Ledger ID: CL-177

### Date
2026-04-05

### Change title
Layer-3 candidate-filter doctrine hardening: crisp gate-state semantics + removal of bucket priority leakage

### Change class
bounded Layer-3 producer hardening patch (eligibility doctrine + deterministic outcome contract)

### Stage / domain
`mt5/candidate_filtering/ASC_SelectionFilter.mqh` + `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` + office sync surfaces

### What changed
- removed Layer-3 candidate bucket suffix semantics (`_priority`, `_guarded`, `_watch`) so candidate bucket remains classification ownership only (no hidden shortlist pre-ranking)
- introduced a single Layer-3 outcome stamping helper to enforce deterministic result-state/posture/reason/disqualifier/next-step alignment across PASS/PENDING/FAIL paths
- clarified pending-posture meaning by separating blocked/degraded/stale dependency waits from fail/ineligible hard disqualification outcomes
- retained and explicitly documented strict Layer-3 non-directional tradability law (`SYMBOL_TRADE_MODE_FULL` required for admission), with restricted/unavailable trade modes remaining blocked-pending
- refreshed dependency evidence wording and reason-code operator mapping for `trading_permission_unavailable` and `trading_permission_restricted`

### Operational effect
- Layer-3 output contract is more stable for consumers: state and posture meanings are now cleaner and less contradiction-prone
- shortlist preference leakage from Layer-3 bucket naming is removed, preserving Layer-4 shortlist authority boundaries
- trade-mode policy meaning is explicit to operators without reclassifying lawful pending restrictions as fail/ineligible


## Ledger ID: CL-176

### Date
2026-04-04

### Change title
PROMPT 8 full-slice hardening: conservative dossier convergence accounting + shortlist correlation peer-context edge fix

### Change class
bounded final hardening patch (tiny dispatcher convergence/accounting + tiny producer edge-case correction)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh` + office sync surfaces

### What changed
- adjusted dossier coverage-state resolution so existing but unreadable/empty dossier payload files are classified as shell-equivalent non-rich state rather than silently dropping out of shell/rich counters
- tightened shortlist correlation peer skip logic to use symbol-context matching when excluding the anchor from peer comparisons
- preserved all ownership boundaries (dispatcher/runtime owns convergence accounting, producer owns shortlist/correlation truth, consumers remain format-only)

### Operational effect
- shell-vs-rich convergence telemetry is more conservative and less prone to false-rich impressions from unreadable payload files
- correlation summary peer set is safer under normalized/canonical symbol context variance
- full current slice is now at final operator stop gate pending compile/live review


## Ledger ID: CL-175

### Date
2026-04-04

### Change title
Final hardening/regression: tighten packet-law coherence and edge-case readability across shortlist, board, and HUD consumers

### Change class
bounded final hardening patch (tiny producer-helper + tiny consumer wording/readiness coherence)

### Stage / domain
`mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh` + `mt5/artifacts/ASC_MarketBoardWriter.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + office sync surfaces

### What changed
- tightened `ASC_ShortlistCorrelationReady(...)` to require lawful packet snapshots for shortlisted support counts and hardened anchor row matching using shortlist symbol-context resolution
- corrected Market Board bucket summary promoted metric to consume producer `shortlist_band` truth (`promoted`) instead of inferring from bucket-top membership count
- improved HUD leaders row detail fallback so shortlist-reason missingness degrades to filter reason text rather than plain unavailable

### Operational effect
- L4 helper readiness semantics now match board/HUD snapshot-law expectations more closely under partial packet states
- board and HUD surface wording remains consumer-only while reducing misleading promotion/readiness impressions
- current L3/L4 + Market Board + HUD slice is now at final stop gate pending operator compile/live review


## Ledger ID: CL-174

### Date
2026-04-04

### Change title
HUD browse-flow parity: direct bucket leaders route + explicit leaders/sub-groups/symbols role separation

### Change class
bounded HUD consumer browse-flow correction (routing + role labels + shortlist consumer parity)

### Stage / domain
`mt5/hud/ASC_HUD_Manager.mqh` + office sync surfaces

### What changed
- changed main-bucket row click routing from forced sub-group browse to direct leaders route (`ASC_HUD_PAGE_BUCKET_LEADERS`) while keeping sub-groups available from top navigation
- implemented leaders-list row rendering + click routing from producer shortlist carry (`bucket_rank`, `bucket_shortlisted`, `shortlist_band`) and kept symbol detail entry path shared with symbols page
- separated scope-card wording and chips for leaders vs symbols so symbols remains a sub-group scoped browse view rather than a bucket-wide ranking surrogate
- added missing top-nav leaders button event handling and included leaders page in shortlist-sensitive refresh/cadence checks

### Operational effect
- operator can now discover true bucket leaders directly from main-bucket selection without losing classification browse depth
- HUD consumer meaning is more consistent with producer shortlist/filter truth across leaders and symbols surfaces
- stop gate: operator compile + HUD interaction review before final hardening/regression pass


## Ledger ID: CL-173

### Date
2026-04-04

### Change title
Market Board exact-product pass: continuous Top 10 + bucket Top 5 sections with producer-input consumption

### Change class
bounded Market Board consumer/product correction (format/order/token contract only)

### Stage / domain
`mt5/artifacts/ASC_MarketBoardWriter.mqh` + office sync surfaces

### What changed
- removed split-era bucket section rendering (`Leading Three` / `Full Five`) and replaced it with continuous per-bucket sections (`<Bucket> — Top 5`) in canonical order after `All-Markets Top 10`
- switched bucket-row selection to consume Layer-4 bucket membership/rank carry (`bucket_shortlisted`, `bucket_rank`) for deterministic bucket Top-5 admission
- updated row-level selection wording to consume producer shortlist meaning (`shortlist_band`) and added producer correlation readiness posture/reason rendering
- updated board publication token validation requirements to the new exact-product headings (`All-Markets Top 10`, six bucket `Top 5` sections, account/risk, excluded/active)
- kept exposure/account sections consumer-owned from live positions/orders and account snapshot paths

### Operational effect
- board now presents the operator product spine as continuous lists rather than split fragments
- producer truth is consumed more directly for membership meaning and correlation readiness
- stop gate: operator compile + board artifact spot-check before HUD implementation slices


## Ledger ID: CL-172

### Date
2026-04-04

### Change title
Harden Layer-4 producer correlation readiness and shortlist meaning carry for downstream board inputs

### Change class
bounded Layer-4 producer/input refinement (correlation + shortlist meaning carry)

### Stage / domain
`mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh` + office sync surfaces

### What changed
- added explicit shortlist meaning carry on producer rows (`shortlist_band`) with deterministic values: `promoted`, `shortlisted`, `reserve`, `pending`, `blocked`
- expanded `ASC_ShortlistCorrelationSummary` with producer readiness metadata (`summary_ready`, posture/reason, peers compared, peers packet-ready, anchor packet readiness)
- hardened `ASC_ShortlistBuildCorrelationSummary(...)` to stamp deterministic readiness/posture/reason outcomes for anchor-missing, anchor-packet-missing, no-peer, partial-support, and ready-support cases
- adjusted `ASC_ShortlistCorrelationReady(...)` gating to a bounded readiness threshold aligned with shortlist scope (`packet_ready >= min(3, shortlisted_count)` for shortlisted_count > 1)
- left exposure ownership in Market Board consumer path (positions/orders snapshot) with no producer-side exposure policy migration

### Operational effect
- Layer-4 producer now emits clearer board-input truth so later consumer passes can render correlation/readiness and shortlist meaning without local policy inference
- readiness semantics no longer depend on all-peers packet availability in small/medium shortlist scopes
- stop gate: operator compile + runtime shortlist correlation verification before Market Board exact-product implementation


## Ledger ID: CL-171

### Date
2026-04-04

### Change title
Recover Layer-4 shortlist core capacity and posture determinism for global Top-10 + bucket Top-5 carry

### Change class
bounded Layer-4 producer-core recovery (shortlist membership/rank/posture carry only)

### Stage / domain
`mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh` + office sync surfaces

### What changed
- increased producer global shortlist authority from 5 to 10 (`ASC_SHORTLIST_SIZE=10`) to remove the structural cap blocking later all-markets Top-10 product requirements
- added per-row producer carry for bucket ranking (`bucket_rank`) and bucket shortlist entitlement (`bucket_shortlisted`) with deterministic assignment for passed-filter symbols capped at bucket top-5
- fixed shortlist posture escalation ordering so degraded/stale posture checks evaluate shortlisted membership before global rank assignment
- preserved dispatcher runtime shortlist cache path and consumer contracts (no board/hud product-shape changes in this pass)

### Operational effect
- Layer-4 now emits stable producer truth that can support later consumer passes requiring all-markets top-10 and per-main-bucket top-5 without forcing consumer-side invention
- hold/material-shift behavior remains intact while posture transitions regain lawful degraded/stale visibility
- stop gate: operator compile + shortlist cache verification before proceeding to Market Board/HUD product passes


## Ledger ID: CL-170

### Date
2026-04-04

### Change title
Fix dossier shell-vs-rich convergence accounting so shell artifacts cannot satisfy completion

### Change class
bounded dossier convergence recovery (coverage/backlog/continuation accounting)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + office sync surfaces

### What changed
- added compile-path helper checks to classify dossier artifacts as missing, shell, or rich based on live dossier payload content
- updated dossier presence telemetry counters so `dossier_shell_present_count` and `dossier_rich_present_count` are measured separately, and missingness now reflects rich coverage instead of file-existence coverage
- added non-rich dossier convergence admission so shell-only symbols queue canonical continuation duty even when file existence duty is already satisfied
- preserved open-symbol rich publication routing while ensuring closed/non-open shell dossiers stay in backlog scope until rich publication replaces shell state

### Operational effect
- only-open rich convergence failure mode is removed from completion accounting: shell files no longer close backlog truth
- startup/existence duty remains narrow for truly missing files, while continuation duty now remains active until shell-only coverage converges to rich dossiers
- stop gate: operator compile + live whole-universe dossier verification required before additional passes


## Ledger ID: CL-169

### Date
2026-04-04

### Change title
Recover canonical OPEN dossier routing during startup shell-existence duty

### Change class
bounded dossier routing recovery (writer dispatch only)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + office sync surfaces

### What changed
- corrected dossier dispatch branch selection so `dossier_existence_shell_only` no longer forces OPEN symbols through `ASC_BuildDossierShellArtifact(...)`
- preserved shell artifact usage for non-open existence seeding while routing OPEN symbols through `ASC_BuildDossierArtifact(...)` with Layer-1-driven continuation mode
- kept publication admission/backoff/deep-trigger lanes unchanged

### Operational effect
- startup shell duty can no longer dominate OPEN symbol dossier output with tiny shell artifacts
- canonical rich dossier payload publication resumes for OPEN symbols during the same bounded duty window
- stop gate: operator compile + live closed/open dossier comparison required before additional work


## Ledger ID: CL-168

### Date
2026-04-04

### Change title
Final L0-L2 hardening: preserve margin semantics and remove residual projection leakage

### Change class
bounded producer/projection hardening (L0-L2 only)

### Stage / domain
`mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` + `mt5/artifacts/dossier/ASC_DossierComposer.mqh` + office sync surfaces

### What changed
- removed per-order `SymbolInfoMarginRate(...)` coefficient remap from displayed Layer-2 margin fields to preserve broker-visible symbol margin semantics
- kept account-owned margin mode carry and clarified packet session/margin source wording
- removed residual raw integer fallback leakage for dossier filling/expiration/order mode projection
- aligned classification-authority exchange projection to the same symbol exchange owner path used by metadata section
- kept commission truthfully omitted because active compile-reachable symbol/spec/session owners do not expose commission fields

### Operational effect
- margin/session/spec/operator parity is hardened without semantic drift from coefficient remaps
- dossier sections now agree on exchange when exchange owner truth exists
- no fabricated commission truth was introduced


## Ledger ID: CL-167

### Date
2026-04-04

### Change title
Finish L0-L2 parity for session windows, margin carry fidelity, and readable mode projection

### Change class
bounded producer+projection parity repair (L0-L2 only)

### Stage / domain
`mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` + `mt5/artifacts/dossier/ASC_DossierComposer.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + office sync surfaces

### What changed
- normalized Layer-2 session-window text so full-day windows render as `00:00-24:00` and wrapped windows are handled without collapsing to confusing output
- corrected Layer-2 margin-mode carry ownership to account margin mode and enriched buy/sell initial/maintenance margin via `SymbolInfoMarginRate(...)` when broker/order-type margin rates are available
- removed operator-facing numeric leakage for dossier GTC/margin mode fields by switching to readable projection text
- improved HUD specification mode projection to readable calc/filling/expiration/order-mode text and added explicit truthful commission-unavailable note where no active owner field is available

### Operational effect
- dossier/HUD output now aligns more closely with MT5-facing session/margin/spec semantics at L0-L2
- commission remains truthfully unavailable in the active owner path rather than fabricated


## Ledger ID: CL-166

### Date
2026-04-04

### Change title
Relieve Layer-2 companion cadence starvation under large-universe scan pressure

### Change class
bounded runtime/producer cadence-budget tuning (no scheduler architecture rewrite)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` + office sync surfaces

### What changed
- updated Layer-2 companion admission to account for sustained Layer-2 backlog pressure (`l2_due_remaining` + live-entitled pressure) and to allow earlier starvation relief under pressure
- reduced over-strict Layer-2 deferral during L1 confirmation/budget protection when backlog pressure is high
- increased companion budget practicality with a pressure floor and less-aggressive throttling inside active L1 scan beats
- raised dynamic Layer-2 packet budget ceilings for larger admitted-open populations

### Operational effect
- Layer-2 companion scans make materially better progress across open/live symbols under large-universe pressure
- Layer-1 protection and lane ownership remain in place; this pass does not redesign selected-symbol/current-focus or deep-trigger logic


## Ledger ID: CL-165

### Date
2026-04-04

### Change title
Decouple Layer-2 non-quote family admission from quote-lawful snapshot gate

### Change class
bounded Layer-2 lawful-admission recovery (no scheduler or convergence redesign)

### Stage / domain
`mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` + `mt5/shortlist_selection/*SummaryEngine.mqh` + consumer projection touchpoints + office sync surfaces

### What changed
- changed day-range lawfulness to depend on day-range owner truth rather than quote-lawful snapshot success
- updated Layer-2 day-structure and volatility/liquidity finalizers so non-quote families can hydrate from lawful bars/history/reference-price truth without requiring live bid/ask lawfulness
- updated ATR/regime/liquidity/friction summary helpers to stop hard-blocking on quote-lawful snapshot for non-quote families
- adjusted dossier and HUD market-watch/day projections to consume packet family validity flags (`valid_day_range`, `valid_daily_change_pct`, `valid_day_range_position`, `valid_spread_to_atr`) instead of quote-only gating for those families

### Operational effect
- quote subset remains guarded behind lawful quote/tick truth
- non-quote L2 families (day structure, ATR-driven posture, spec/session derived families) now retain lawful availability more often when quote lawfulness is missing
- dossier and HUD continue consuming the same upstream Layer-2 packet path with improved parity and reduced false missingness


## Ledger ID: CL-164

### Date
2026-04-04

### Change title
Prioritize open-symbol dossier convergence over pending generic dossier backlog

### Change class
bounded runtime publication-admission refinement (no Layer-2 producer redesign)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_RuntimeState.mqh` + office sync surfaces

### What changed
- changed `ASC_RequestOpenSymbolDossierRefresh(...)` so open-refresh is priority-admitted when a generic dossier batch is already pending, instead of being skipped
- added runtime carry `dossier_resume_full_publish_after_open_refresh` to preserve and auto-resume the generic dossier continuation duty after the open-refresh slice finishes
- kept startup shell-existence duty explicitly separate by deferring open-refresh priority while shell-only flood duty is active
- preserved selected-symbol/current-focus pair path, explicit deep-trigger pair path, and atomic write/promote semantics

### Operational effect
- open/live symbols with fresh Layer-2 changes can converge dossier output sooner under backlog pressure
- generic dossier continuation remains lawful and resumes automatically after the priority open-refresh slice
- no truth ownership shift from Layer-2 producers to dossier consumers was introduced


## Ledger ID: CL-163

### Date
2026-04-04

### Change title
Finalize explicit Layer-2 sessions/swap/margin packet attachment in runtime cache

### Change class
producer-first L2 sessions/swap/margin packet tightening (small scope)

### Stage / domain
`mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` + office sync surfaces

### What changed
- added explicit sessions/swap/margin carry fields for session status/hours, swap profile, and margin posture/notes
- added centralized `ASC_L2FinalizeSessionsSwapMarginPacket(...)` and invoked it from both paths of `ASC_L2EvaluateSpecification(...)`
- kept unavailable/degraded truth explicit when broker session/swap/margin properties are missing

### Operational effect
- active Layer-2 runtime packet now carries a clearer single-source sessions/swap/margin result per symbol before consumer read paths
- quote/day/volatility/spec packet ownership and publication/routing behavior were not redesigned in this pass


## Ledger ID: CL-162

### Date
2026-04-04

### Change title
Finalize explicit Layer-2 specs/permissions/volume packet attachment in runtime cache

### Change class
producer-first L2 specs/permissions packet tightening (small scope)

### Stage / domain
`mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` + office sync surfaces

### What changed
- added explicit specs/permissions/volume carry fields for contract/tradability/permission/volume posture and broker-validation posture
- added centralized `ASC_L2FinalizeSpecificationPacket(...)` invoked from both paths in `ASC_L2EvaluateSpecification(...)`
- kept degraded/unavailable specification truth explicit via posture + contract-note carry

### Operational effect
- active Layer-2 runtime packet now carries a clearer single-source specs/permissions/volume result per symbol before consumer read paths
- quote/day/volatility packet ownership and publication/routing behavior were not redesigned in this pass


## Ledger ID: CL-161

### Date
2026-04-04

### Change title
Align Layer-2 volatility/liquidity packet ATR ownership to daily ATR(14) with guarded fallback

### Change class
producer-first L2 volatility/liquidity refinement (small scope)

### Stage / domain
`mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` + office sync surfaces

### What changed
- updated `ASC_L2FinalizeVolatilityLiquidityPacket(...)` to compute ATR points from daily ATR(14) in the producer path using `CopyRates(PERIOD_D1, ...)`
- retained fresh day-range fallback only when ATR(14) cannot be built from lawful bars
- preserved existing volatility/friction/liquidity posture stamping and degraded/unavailable truth handling

### Operational effect
- active Layer-2 runtime packet volatility/liquidity posture now anchors to a clearer ATR(14)-first upstream source with explicit fallback behavior
- no quote/day/spec/session/publication ownership redesign in this pass


## Ledger ID: CL-160

### Date
2026-04-04

### Change title
Finalize explicit Layer-2 volatility/liquidity packet attachment in runtime cache

### Change class
producer-first L2 volatility/liquidity packet tightening (small scope)

### Stage / domain
`mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` + office sync surfaces

### What changed
- added explicit volatility/liquidity packet fields for ATR/ATR%/spread-to-ATR plus volatility/friction/liquidity posture carry
- added centralized `ASC_L2FinalizeVolatilityLiquidityPacket(...)` invoked from `ASC_L2EvaluatePacket(...)` after quote/day packet finalization
- kept degraded/unavailable posture truthful when lawful snapshot or day-range truth is absent

### Operational effect
- active Layer-2 runtime packet now carries a clearer single-source volatility/liquidity result per symbol before consumer read paths
- quote/day packet ownership, specs/sessions packet ownership, and publication/routing behavior were not redesigned in this pass


## Ledger ID: CL-159

### Date
2026-04-04

### Change title
Finalize explicit Layer-2 day-structure packet attachment in runtime cache

### Change class
producer-first L2 day-structure packet tightening (small scope)

### Stage / domain
`mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` + office sync surfaces

### What changed
- added explicit day-structure packet fields for day-open/day-change/range-position plus day direction/action and posture/reason carry
- added centralized `ASC_L2FinalizeDayStructurePacket(...)` invoked from `ASC_L2EvaluatePacket(...)` after quote finalization and before packet cadence/spec follow-up
- kept daily structure derivation in the Layer-2 producer path so downstream consumers can read packet truth directly

### Operational effect
- active Layer-2 runtime packet now carries a clearer single-source day-structure result per symbol before consumer read paths
- quote packet, specs/sessions packet, and publication/routing ownership were not redesigned in this pass


## Ledger ID: CL-158

### Date
2026-04-04

### Change title
Finalize explicit Layer-2 quote snapshot packet attachment in runtime cache

### Change class
producer-first L2 quote packet tightening (small scope)

### Stage / domain
`mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` + office sync surfaces

### What changed
- added explicit Layer-2 quote packet fields for last/spread/spread_pct plus quote/freshness/continuity posture carry
- added centralized `ASC_L2FinalizeQuoteSnapshotPacket(...)` invoked from `ASC_L2EvaluatePacket(...)` before packet cadence/spec follow-up
- updated `ASC_L2BuildMarketWatchQuoteProjection(...)` to consume finalized packet fields instead of recomputing quote metrics ad hoc

### Operational effect
- active Layer-2 runtime packet now carries a clearer single-source quote snapshot result per symbol before consumer read paths
- publication/routing and non-quote Layer-2 ownership were not redesigned in this pass


## Ledger ID: CL-157

### Date
2026-04-04

### Change title
Finalize explicit Layer-1 market-state packet attachment in runtime symbol state

### Change class
producer-first L1 market-state attachment tightening (small scope)

### Stage / domain
`mt5/market_state/ASC_MarketStateEngine.mqh` + office sync surfaces

### What changed
- added explicit runtime packet fields in Layer-1 symbol state: `state_posture`, `state_resolved`, `state_reason`
- added `ASC_Layer1FinalizeMarketStatePacket(...)` to centralize final market-state packet stamping and due/recheck cadence application
- routed `ASC_Layer1EvaluateSymbol(...)` branch exits through the centralized finalizer before cache attach

### Operational effect
- runtime Layer-1 cache now carries one clearer per-symbol market-state packet with explicit posture/resolution/reason + due ownership
- downstream consumer and publication/routing behavior were not redesigned in this pass


## Ledger ID: CL-156

### Date
2026-04-04

### Change title
Stabilize Layer-1 runtime identity/classification packet attachment

### Change class
producer-first L0 attachment tightening (no consumer/routing redesign)

### Stage / domain
`mt5/market_state/ASC_MarketStateEngine.mqh` + office sync surfaces

### What changed
- added `ASC_Layer1AttachIdentityClassificationPacket(...)` as a centralized producer helper for identity/classification packet alignment
- removed fragmented inline canonical/state attachment writes in `ASC_Layer1EvaluateSymbol(...)`
- ensured all evaluate-symbol paths pass through one post-lookup/post-reuse attachment step before state is consumed downstream
- preserved truthful missingness via fallback-only filling when values are absent

### Why it mattered
Identity/classification attachment was spread across branch-local writes; centralizing it reduces producer-side ambiguity before dossier/HUD/board consumers project L0 fields.

### Operational effect
- one clearer upstream identity/classification packet path is carried in active runtime symbol state
- consumer files were not redesigned in this pass
- routing/publication behavior remains untouched


## Ledger ID: CL-155

### Date
2026-04-04

### Change title
Tighten dossier Layer 2 Market Watch quote consumption to upstream packet projection

### Change class
bounded Layer-2 consumer-path cleanup (no specs/sessions/routing redesign)

### Stage / domain
`mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` + `mt5/artifacts/dossier/ASC_DossierComposer.mqh` + office sync surfaces

### What changed
- added `ASC_L2BuildMarketWatchQuoteProjection(...)` in Layer-2 open-symbol snapshot owner path to centralize quote/freshness/spread/timing projection from packet truth
- changed dossier composer Market Watch quote fields to consume that upstream projection output
- removed duplicated local dossier-side quote/freshness/spread recomputation where upstream packet projection is already present
- preserved specs/permissions/volume and sessions/swap/margin section behavior

### Why it mattered
Market Watch dossier rows should consume upstream Layer-2 packet truth directly, not maintain parallel ad hoc projection logic that can drift.

### Operational effect
- Market Watch quote snapshot fields now come from one upstream projection path
- dossier remains a formatter/consumer of Layer-2 truth
- routing/publication and OPEN/CLOSED product-mode behavior were not redesigned in this pass


## Ledger ID: CL-154

### Date
2026-04-04

### Change title
Make ordinary dossier continuation/open-refresh explicitly Layer-1 posture driven

### Change class
bounded dispatcher continuation-gating cleanup (no Layer-1 engine redesign)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + office sync surfaces

### What changed
- changed ordinary open-refresh candidate admission to require `state == ASC_L1_OPEN` when `dossier_open_refresh_only` is active
- added `ASC_DossierContinuationModeFromLayer1(...)` helper and used it in the ordinary dossier publish loop
- made ordinary continuation mode selection explicitly consume Layer-1 `state`/`due_class` posture instead of a local inline ternary only
- left startup/existence shell route and selected-symbol/deep-trigger pair routes unchanged

### Why it mattered
Ordinary open/closed continuation handling should be directly and consistently driven by existing Layer-1 posture, reducing drift where closed symbols could enter open-refresh-style handling.

### Operational effect
- ordinary open-refresh now stays open-symbol only
- ordinary continuation mode assignment is centralized and Layer-1 posture explicit
- no broader publication-routing or dossier-layout redesign was introduced


## Ledger ID: CL-153

### Date
2026-04-04

### Change title
Tighten dossier L0 identity/classification consumption to upstream Layer-1 fields

### Change class
bounded dossier consumer-path cleanup (no producer/routing redesign)

### Stage / domain
`mt5/artifacts/dossier/ASC_DossierComposer.mqh` + office sync surfaces

### What changed
- changed dossier L0 asset-type projection to prefer upstream `classification.asset_class` and only use minimal bucket-id fallback when missing/unresolved
- changed dossier L0 instrument-family projection to prefer upstream `classification.main_bucket_name` with fallback to effective bucket-id operator mapping
- aligned classification-authority `advanced_main_bucket` projection to the same upstream-fed instrument-family helper
- retained hierarchy-note gating against effective main-bucket id and kept all routing/publication behavior untouched

### Why it mattered
L0 visible dossier output was still applying local identity/classification stitching where upstream Layer-1 classification fields already existed and should be consumed directly.

### Operational effect
- dossier remains a consumer of upstream identity/classification truth
- L0 identity/classification rows now use a more direct and consistent upstream-fed display path
- truthful missingness remains where upstream values are absent


## Ledger ID: CL-152

### Date
2026-04-04

### Change title
Constrain canonical CLOSED dossier visible output to opening frame + L0/L1/L2 posture

### Change class
bounded composer closed-mode seam correction (no routing/deep-trigger redesign)

### Stage / domain
`mt5/artifacts/dossier/ASC_DossierComposer.mqh` + office sync surfaces

### What changed
- kept existing closed-mode early return boundary after L2 section families
- made closed-mode operator snapshot/publication integrity summary logic avoid L3/L4/L5 delayed-placeholder projection
- set closed-mode deep header status line to a closed-mode not-applicable posture instead of open-path deep-delay wording
- left OPEN canonical composition and shell artifact routing behavior unchanged

### Why it mattered
Closed canonical dossiers should terminate as a bounded L0/L1/L2 product and should not leak later-layer delayed placeholders into visible closed-mode output.

### Operational effect
- CLOSED canonical output remains top frame + L0/L1/L2 and stops without L3/L4/L5 section headings
- CLOSED top summary fields no longer report candidate-filter/shortlist/deep delayed placeholders
- OPEN canonical path and explicit deep-trigger/selected-symbol pair paths remain unchanged in this pass


## Ledger ID: CL-151

### Date
2026-04-04

### Change title
Bound ordinary dossier continuation/open-refresh to canonical publication success

### Change class
bounded runtime routing correction (no startup/deep-trigger redesign)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + office sync surfaces

### What changed
- removed ordinary-path fallback from canonical dossier publish to `ASC_BuildDossierShellArtifact(...)` in the main dossier publication loop
- retained explicit shell publication path for `dossier_existence_shell_only` startup/existence duty
- left selected-symbol Current Focus pair publication and explicit Deep Analysis trigger pair publication unchanged
- recorded the routing-law update in roadmap/work log

### Why it mattered
Ordinary continuation/open-refresh was able to silently publish full shell dossiers and count that as normal completion, masking canonical dossier publish failure.

### Operational effect
- ordinary continuation/open-refresh now records dossier failure when canonical dossier compose/write fails
- full shell dossier artifact publication remains intentionally bounded to startup/existence routing in this pass
- deep-section placeholder behavior inside canonical dossiers is unchanged


## Ledger ID: CL-150

### Date
2026-04-04

### Change title
Root control-surface ownership cleanup (one-job-per-file reset)

### Change class
control governance cleanup + live-status consolidation

### Stage / domain
`README.md` + `MASTER_INDEX.md` + `FRONT_DOOR_CHECKLIST.md` + `CHAT_CONTINUATION_GUIDE.md` + `Aurora Sentinel Core/office/ROADMAP_STATUS.md` + office sync records

### What changed
- reduced root `README.md` to front-door-only responsibilities
- reduced `MASTER_INDEX.md` to navigation-spine-only responsibilities
- reduced `FRONT_DOOR_CHECKLIST.md` to concise go/no-go admissibility gating
- reduced `CHAT_CONTINUATION_GUIDE.md` to lightweight takeover workflow
- consolidated `Aurora Sentinel Core/office/ROADMAP_STATUS.md` into concise live-truth posture and removed duplicated freeze-status block
- synchronized office decision/work/change records to reflect new control ownership chain

### Why it mattered
Control docs had overlapping law ownership and stale stage narrative drift, which made entry and admissibility decisions harder to trust.

### Operational effect
- entry chain is clearer and easier to follow
- live status ownership is clearer in office
- duplicate governance families are materially reduced
- runtime/code behavior was not changed


## Ledger ID: CL-149

### Date
2026-04-03

### Change title
Layer 1 lock-in telemetry and regression-trap hardening

### Change class
bounded observability hardening + office truth alignment

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_RuntimeState.mqh` + `mt5/artifacts/ASC_ScannerStatusWriter.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + office control surfaces

### What changed
- added runtime dossier coverage telemetry fields (`expected`, `missing`, missing/cursor stall counters, regression signal)
- added dispatcher-side dossier coverage telemetry updater and surfaced compact dossier coverage/convergence fields in heartbeat detail
- extended Scanner Status artifact summary with expected/missing/backlog estimate/regression signal lines
- extended HUD proof telemetry with tactical-age and tactical-stall beat visibility
- aligned office control files with Prompt 1-5 landed truth and remaining environment-limited validation risk

### Why it mattered
Prompt 1-4 behavior was improved but regressions could still hide without explicit low-noise proof signals. This pass makes Layer 1 completion health easier to verify quickly and harder to drift silently.

### Operational effect
- missing dossier and convergence regressions are visible from existing heartbeat/status surfaces
- HUD cadence stalls are surfaced compactly in existing HUD proof telemetry
- office/control wording now reflects landed Layer 1 completion phases and current remaining risk honestly


## Ledger ID: CL-148

### Date
2026-04-03

### Change title
HUD + Market Board classification consumer guard hardening after Layer 1 recovery sweep

### Change class
bounded consumer-surface hardening with lightweight regression guard evidence

### Stage / domain
`mt5/hud/ASC_HUD_Manager.mqh` + `mt5/artifacts/ASC_MarketBoardWriter.mqh`

### What changed
- added HUD classification guard computation that checks visible-vs-runtime distribution match and unresolved/fallback posture
- added `class_guard` field to HUD proof summary log line
- updated HUD Overview attention card to show compact guard posture
- added Market Board counts lines for classification health, main-group distribution, and compact fallback-ratio guard posture

### Why it mattered
This keeps consumer surfaces aligned with repaired Layer 1 classification truth and makes future sticky Unknown/fallback regressions visible quickly without moving classification ownership downstream.

### Operational effect
- operator-facing HUD/board now expose fast classification regression cues
- consumer surfaces continue projecting upstream truth without local reclassification ownership
- genuinely unresolved symbols remain visible; no cosmetic hiding was introduced

## Ledger ID: CL-147

### Date
2026-04-03

### Change title
Layer 1 one-time classification recovery sweep + active bridge-path confirmation hardening

### Change class
bounded runtime recovery hardening (classification owner preserved; no HUD/dossier/shortlist redesign)

### Stage / domain
`mt5/market_state/ASC_MarketStateEngine.mqh` + `mt5/symbols/ASC_ClassificationBridge.mqh`

### What changed
- added one-time Layer 1 full-universe classification recovery sweep state and counters (`armed/active/completed`, `done/total`, `changed`, `promoted`, `unresolved`)
- added per-symbol pending marker so every cached symbol is forced through fresh classification once under the current bridge
- forced reclassification during sweep even for previously reusable cache rows to flush stale poisoning from earlier runs
- appended compact recovery proof block to scan-slice detail output
- added explicit active bridge source-path helper used by recovery proof output

### Why it mattered
This neutralizes stale cache poisoning persistence after prior bad runs and provides compact proof that recovery is progressing against the current authoritative bridge path.

### Operational effect
- unresolved/unknown/fallback-poisoned cache rows are not allowed to survive the one-time sweep cycle
- operators can verify sweep progress and bridge path in existing scan result detail surfaces without noisy telemetry redesign
- classification ownership remains upstream in Layer 1 + bridge

## Ledger ID: CL-146

### Date
2026-04-03

### Change title
Classification/HUD stability hardening with compact fallback and distribution diagnostics

### Change class
bounded ownership hardening + lightweight diagnostics (no layout/engine redesign)

### Stage / domain
`mt5/market_state/ASC_MarketStateEngine.mqh` + `mt5/runtime/ASC_Dispatcher.mqh` + `mt5/hud/ASC_HUD_Manager.mqh`

### What changed
- added Layer 1 summary counters for fallback classification usage and per-main-group distribution
- added compact Layer 1 helper summaries for classification health and main-group distribution
- extended dispatcher heartbeat detail line with `class_health` and `class_groups` fields sourced from Layer 1 summary
- centralized group-surface HUD labels via `ASC_HudLabelMarkets()` and `ASC_HudLabelGroups()` in active browse surfaces
- extended HUD proof summary line with compact `class_health`, `class_groups`, and `subgroup_by_market` diagnostics
- updated HUD overview attention card to include resolved/unresolved/fallback totals and market/group counts

### Why it mattered
This makes classification fallback drift and group-distribution regressions more visible during live runs while keeping classification upstream-owned and HUD consumer-only.

### Operational effect
- regressions where unresolved/fallback starts dominating are easier to catch quickly from existing heartbeat/HUD proof logs
- main-group and subgroup distribution posture is visible without adding a noisy debug panel
- HUD group vocabulary has a clearer single adjustment point for future copy changes

## Ledger ID: CL-145

### Date
2026-04-03

### Change title
Runtime proof-surface hardening for HUD, selected-symbol sync, and publication outcomes

### Change class
bounded instrumentation and regression-evidence hardening (no behavior redesign)

### Stage / domain
`mt5/core/ASC_RuntimeState.mqh` + `mt5/hud/ASC_HUD_Manager.mqh` + `mt5/runtime/ASC_Dispatcher.mqh`

### What changed
- added lightweight cumulative proof counters in runtime state for publication outcomes, bundle lifecycle, selected-symbol flow, and deep-trigger publication flow
- added HUD proof counters (full rebuild, selected-list rebuild, render passes, tactical cadence refreshes) and bounded periodic proof summary logging
- added dispatcher-side publication outcome accounting at ownership points (snapshot, board, dossier, manifest, and selected-symbol/deep pair publishes)
- added selected-symbol request counting at HUD ingress and reconcile counting at dispatcher reconcile owner path
- extended artifact bundle manifest and heartbeat detail with compact regression-facing counters

### Why it mattered
This makes regressions easier to detect after live MT5 runs without adding noisy per-event tracing or changing runtime ownership boundaries.

### Operational effect
- proof is now visible for HUD rebuild cadence, selected-symbol request/reconcile/publish flow, and publication outcome posture
- publication continuity/failure drift is easier to spot from existing manifest + heartbeat evidence surfaces
- no HUD pacing redesign, no dispatcher pacing redesign, no artifact product redesign

## Ledger ID: CL-144

### Date
2026-04-02

### Change title
Phase 5 dossier L3/L4 summary family extraction

### Change class
bounded summary-family ownership extraction (Layer 3/Layer 4 engines unchanged)

### Stage / domain
`mt5/artifacts/dossier/candidate_filtering/*` + `mt5/artifacts/dossier/shortlist_selection/*` + `mt5/artifacts/dossier/ASC_DossierComposer.mqh` + minimal blueprint/office updates

### What changed
- extracted Candidate Filtering subgroup renderers (Gate Status, Blockers & Dependencies, Sorting Inputs) into dedicated family files
- extracted Shortlist Selection subgroup renderers (Shortlist Core, Stability & Hold, Correlation & Exposure) into dedicated family files
- removed inline renderer definitions for extracted L3/L4 groups from central composer body and wired composer direct calls to family files
- preserved writer compatibility-entry/publish-bridge role and left publication mechanics unchanged
- preserved summary honesty and explicit unavailable/degraded posture wording

### Why it mattered
This moves L3/L4 dossier summary areas into explicit family ownership while preserving frozen visible contract and upstream filter/shortlist engine authority boundaries.

### Operational effect
- composer remains sequence owner and calls extracted L3/L4 families directly
- writer remains compile-safe entry
- summary honesty wording remains explicit
- no Deep Analysis migration or Layer 3/Layer 4 engine redesign was introduced

## Ledger ID: CL-143

### Date
2026-04-02

### Change title
Phase 4 dossier L1/L2 projection family extraction

### Change class
bounded projection-family ownership extraction (no upstream engine redesign)

### Stage / domain
`mt5/artifacts/dossier/market_state/*` + `mt5/artifacts/dossier/market_watch/*` + `mt5/artifacts/dossier/trading_conditions_contract_specs/*` + `mt5/artifacts/dossier/sessions_swap_margin/*` + `mt5/artifacts/dossier/ASC_DossierComposer.mqh` + minimal blueprint/office updates

### What changed
- extracted Market State subgroup renderers (State Core, State Timing) into dedicated family files
- extracted Market Watch subgroup renderers (Quote Snapshot, Day Structure, Volatility & Friction) into dedicated family files
- extracted Trading Conditions & Contract Specs subgroup renderers (Price & Contract, Trading Permissions, Volume Rules) into dedicated family files
- extracted Sessions/Swap/Margin subgroup renderers (Sessions, Swap, Margin) into dedicated family files
- removed inline renderer definitions for extracted L1/L2 groups from central composer body and wired composer direct calls to family files
- preserved writer compatibility-entry/publish-bridge role and left publication mechanics unchanged

### Why it mattered
This moves continuous read-only L1/L2 dossier projection areas into explicit family ownership while preserving frozen visible contract and honesty posture.

### Operational effect
- composer remains sequence owner and calls extracted L1/L2 families directly
- writer remains compile-safe entry
- freshness/continuity/missingness wording remains explicit
- no Layer 3/4/5 migration or upstream engine redesign was introduced

## Ledger ID: CL-142

### Date
2026-04-02

### Change title
Phase 3 dossier Symbol Identity family extraction

### Change class
bounded section-family ownership extraction (classification authority preserved)

### Stage / domain
`mt5/artifacts/dossier/symbol_identity/*` + `mt5/artifacts/dossier/ASC_DossierComposer.mqh` + minimal blueprint/office updates

### What changed
- extracted Identity Core rendering into `ASC_DossierIdentityCoreSection.mqh`
- extracted Classification Authority rendering into `ASC_DossierClassificationAuthoritySection.mqh`
- extracted Symbol Metadata rendering into `ASC_DossierSymbolMetadataSection.mqh`
- removed inline Symbol Identity renderer definitions from central composer body and wired composer to call Symbol Identity family files directly
- preserved writer compatibility-entry/publish-bridge role and left publication mechanics unchanged
- preserved authoritative-classification-vs-broker-support hierarchy wording unchanged

### Why it mattered
This moves a complete coherent dossier area into family ownership while preserving contract stability and classification authority boundaries.

### Operational effect
- Symbol Identity area now has dedicated dossier family owners
- composer remains sequence owner and calls Symbol Identity family files directly
- writer remains compile-safe entry
- no broader section migration or classification-engine redesign was introduced

## Ledger ID: CL-141

### Date
2026-04-02

### Change title
Phase 2 dossier top-surface section-family extraction

### Change class
bounded section-family ownership extraction (no runtime/publication redesign)

### Stage / domain
`mt5/artifacts/dossier/top_header/*` + `mt5/artifacts/dossier/operator_snapshot/*` + `mt5/artifacts/dossier/publication_integrity/*` + `mt5/artifacts/dossier/ASC_DossierComposer.mqh` + minimal blueprint/office updates

### What changed
- extracted Top Header rendering into `ASC_DossierTopHeaderSection.mqh`
- extracted Operator Snapshot rendering into `ASC_DossierOperatorSnapshotSection.mqh`
- extracted Publication & Integrity rendering into `ASC_DossierPublicationIntegritySection.mqh`
- removed inline definitions of those three renderers from central composer body and wired composer to call extracted section-family files directly
- preserved writer compatibility-entry/publish-bridge role and left publication mechanics unchanged

### Why it mattered
This advances dossier section-family migration at the lowest-risk top surface while preserving the frozen visible contract.

### Operational effect
- top-surface sections now have dedicated dossier section-family owners
- composer remains sequence owner and calls extracted section files directly
- writer remains compile-safe entry
- no broader section migration or runtime redesign was introduced

## Ledger ID: CL-140

### Date
2026-04-02

### Change title
Phase 1 dossier wrapper/composer/common split (compile-safe continuity)

### Change class
architecture refactor (ownership split, no runtime redesign)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + `mt5/artifacts/dossier/ASC_DossierComposer.mqh` + `mt5/artifacts/dossier/ASC_DossierSectionCommon.mqh` + `blueprint/final/03A_ASC_DOSSIER_LAYOUT_AND_COMPOSITION_LAW.md` + minimal office updates

### What changed
- moved dossier sequencing/scaffold body orchestration into new `ASC_DossierComposer.mqh`
- moved shared dossier presentation helpers into new `ASC_DossierSectionCommon.mqh`
- reduced `ASC_DossierWriter.mqh` to compile-safe compatibility wrapper + publish bridge while keeping active entry and publication semantics
- updated `03A` doctrine to explicitly define writer/composer/common target roles and anti-monolith/anti-hidden-owner guardrails
- recorded phase scope truth in office control files

### Why it mattered
This prepares later section-family migration by splitting structure ownership now, without changing the frozen visible dossier contract or publication flow.

### Operational effect
- compile entry remains stable
- composer now owns visible dossier sequencing
- shared presentation helpers now have a dedicated common owner file
- no section-folder migration or runtime redesign was introduced in this pass

## Ledger ID: CL-139

### Date
2026-04-02

### Change title
Phase 0 dossier contract freeze + dossier layout doctrine owner-file prep

### Change class
architecture-prep contract freeze (no runtime redesign)

### Stage / domain
`mt5/artifacts/dossier/*` + `mt5/artifacts/ASC_DossierWriter.mqh` + `blueprint/final/03A_ASC_DOSSIER_LAYOUT_AND_COMPOSITION_LAW.md` + minimal office truth updates

### What changed
- added `ASC_DossierContracts.mqh` to freeze canonical dossier section order, subgroup order, required-token contract, and normal-path Deep Selective Analysis shell rule
- added `ASC_DossierScaffold.mqh` to freeze dossier scaffold divider conventions and canonical field-label registry
- updated `ASC_DossierWriter.mqh` to consume dossier contract/scaffold owners for required tokens and section/subgroup heading emission while preserving existing output contract
- added dedicated dossier layout/composition blueprint doctrine owner file `03A_ASC_DOSSIER_LAYOUT_AND_COMPOSITION_LAW.md`
- updated office truth to mark this pass as architecture-prep only with explicit deferrals (no runtime redesign, no composer extraction, no broad ownership migration)

### Why it mattered
This creates explicit dossier contract ownership before folder/composer migration so later structural moves can happen without hidden visible-surface drift.

### Operational effect
- compile entry remains stable with `ASC_DossierWriter.mqh` still compile-reachable
- visible dossier contract is frozen outside ad hoc writer-body ordering
- no publication mechanics, runtime ownership paths, or selected-symbol behavior were redesigned in this pass

## Ledger ID: CL-138

### Date
2026-04-02

### Change title
Dossier scaffold reset pass — canonical visible contract restoration + Layer 5 shell collapse in normal path

### Change class
operator-surface scaffold reset + visible clutter removal (bounded writer-side cleanup)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- restored canonical Symbol Dossier visible scaffold ordering and section-contract shape in the active dossier builder path
- removed visible `Section Telemetry:` lines from operator-facing dossier output
- removed non-canonical visible clutter fields that inflated payload surface (`Previous Day High/Low (Preserved)`, trader-context preserved account payload lines)
- removed normal-path rendering of `Preserved Deep Payload Block`
- collapsed Layer 5 normal visible output to canonical shell labels/structure without auto-emitting giant OHLC evidence dumps
- preserved honest missingness, deferred wording, and continuity posture where owner-backed truth is unavailable

### Why it mattered
Operator-facing dossier cleanliness and section-contract stability had drifted; this pass restores the canonical product surface before any larger module-layout redesign.

### Operational effect
- normal dossier output is cleaner and bounded
- Layer 5 no longer dominates normal publishes with large evidence payload expansions
- writer remains a projector/composer of existing owner truth; no engine ownership transfer was introduced
- broad module-layout redesign remains intentionally deferred

## Ledger ID: CL-137

### Date
2026-04-02

### Change title
Dossier baby step 33 — Recent Change Trace extraction with compact section telemetry

### Change class
writer-side decomposition + change-trace surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `RECENT CHANGE TRACE` rendering into dedicated helper `ASC_BuildDossierRecentChangeTraceSection(...)`
- preserved exact visible labels/order: `Latest Meaningful Change`, `Previous Meaningful Change`, `State Transition Notes`, `Selection Transition Notes`, `Publication Transition Notes`, `Deep Analysis Transition Notes`
- projected existing lawful state/selection/publication/deep transition context strings without introducing new derivation logic in the writer
- improved operator wording for sparse history posture by replacing bare `deferred` with `deferred (historical change anchor is not hydrated yet)`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with `owner_truth_available` and `transition_context_available` posture note

### Why it mattered
This extends the dossier baby-step modularization pattern to Recent Change Trace while preserving ownership boundaries and honest missingness.

### Operational effect
- Recent Change Trace rendering is modular and reusable
- section now emits compact status telemetry for owner-truth and transition-context availability posture
- broader change-trace hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-136

### Date
2026-04-02

### Change title
Dossier baby step 31 — Analyst / SIAM Handoff extraction with compact section telemetry

### Change class
writer-side decomposition + deep-analysis handoff surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Analyst / SIAM Handoff` rendering into dedicated helper `ASC_BuildDossierDeepAnalystSiamHandoffSection(...)`
- preserved exact visible labels/order: `What Matters Most`, `Best Supporting Evidence`, `Biggest Warning`, `What Is Still Missing`, `What To Check Next`, `Handoff Summary`
- projected existing lawful handoff context from active writer truth (market-state/snapshot/disqualifier/next-step/deep-status lines) without introducing new synthesis logic
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth and handoff-context availability posture note

### Why it mattered
This extends the dossier baby-step modularization pattern to DEEP SELECTIVE ANALYSIS Analyst / SIAM Handoff while preserving Layer 5 ownership boundaries and honest missingness.

### Operational effect
- Analyst / SIAM Handoff rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 5 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-135

### Date
2026-04-02

### Change title
Dossier baby step 30 — Trade Framing Support extraction with compact section telemetry

### Change class
writer-side decomposition + deep-analysis trade-framing surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Trade Framing Support` rendering into dedicated helper `ASC_BuildDossierDeepTradeFramingSupportSection(...)`
- preserved exact visible labels/order: `Directional Bias Support`, `Continuation Support`, `Reversal Risk`, `Breakout Support`, `Fade Risk`, `Invalidation Context`, `Trade Framing Notes`
- projected existing lawful packet/deep posture into concise operator-readable trade-framing wording while preserving explicit deferred wording for non-hydrated models
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth and trade-framing-context availability posture note

### Why it mattered
This extends the dossier baby-step modularization pattern to DEEP SELECTIVE ANALYSIS Trade Framing Support while preserving Layer 5 ownership boundaries and honest missingness.

### Operational effect
- Trade Framing Support rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 5 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-134

### Date
2026-04-02

### Change title
Dossier baby step 29 — Correlation & External Context extraction with compact section telemetry

### Change class
writer-side decomposition + deep-analysis external-correlation/context surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Correlation & External Context` rendering into dedicated helper `ASC_BuildDossierDeepCorrelationExternalContextSection(...)`
- preserved exact visible labels/order: `Cross-Market Alignment`, `Related Symbols`, `Conflict Symbols`, `Beta / Proxy Notes`, `Correlation Context Notes`
- projected existing lawful packet/deep posture into concise operator-readable external-context wording while preserving explicit deferred wording for non-hydrated models
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth and external-context availability posture note

### Why it mattered
This extends the dossier baby-step modularization pattern to DEEP SELECTIVE ANALYSIS Correlation & External Context while preserving Layer 5 ownership boundaries and honest missingness.

### Operational effect
- Correlation & External Context rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 5 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-133

### Date
2026-04-02

### Change title
Dossier baby step 28 — Regime & Context extraction with compact section telemetry

### Change class
writer-side decomposition + deep-analysis regime/context surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Regime & Context` rendering into dedicated helper `ASC_BuildDossierDeepRegimeContextSection(...)`
- preserved exact visible labels/order: `Market Regime`, `Volatility Regime`, `Liquidity Regime`, `Session Regime`, `Context Quality`, `Context Notes`
- projected existing lawful packet/session helper truth into concise operator-readable regime/context posture lines while keeping explicit missingness wording
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth and regime/context availability posture note

### Why it mattered
This extends the dossier baby-step modularization pattern to DEEP SELECTIVE ANALYSIS Regime & Context while preserving Layer 5 ownership boundaries and honest missingness.

### Operational effect
- Regime & Context rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 5 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-132

### Date
2026-04-02

### Change title
Dossier baby step 27 — Microstructure & Tick Context extraction with compact section telemetry

### Change class
writer-side decomposition + deep-analysis microstructure/tick-context surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Microstructure & Tick Context` rendering into dedicated helper `ASC_BuildDossierDeepMicrostructureTickContextSection(...)`
- preserved exact visible labels/order: `Tick Evidence Status`, `Spread Evidence Status`, `Microstructure Notes`, `Quote Stability`, `Spread Stability`, `Execution Friction`, `Microstructure Risk Notes`
- projected existing lawful packet/deep-preserved context into concise operator-readable microstructure posture lines while preserving explicit deferred/missingness wording
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth and tick/spread-context availability posture note

### Why it mattered
This extends the dossier baby-step modularization pattern to DEEP SELECTIVE ANALYSIS Microstructure & Tick Context while preserving Layer 5 ownership boundaries and honest missingness.

### Operational effect
- Microstructure & Tick Context rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 5 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-131

### Date
2026-04-02

### Change title
Dossier baby step 26 — Price Map extraction with compact section telemetry

### Change class
writer-side decomposition + deep-analysis price-map surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Price Map` rendering into dedicated helper `ASC_BuildDossierDeepPriceMapSection(...)`
- preserved exact visible labels/order: `Nearest Support`, `Nearest Resistance`, `Key Reaction Zones`, `Session Extremes`, `Gap / Void / Imbalance Notes`, `Price Map Notes`
- projected existing session-range context (`day_high` / `day_low`) into concise map anchors when available while keeping deferred posture explicit for non-hydrated map-model fields
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth and price-map-context availability posture note

### Why it mattered
This extends the dossier baby-step modularization pattern to DEEP SELECTIVE ANALYSIS Price Map while preserving Layer 5 ownership boundaries and honest missingness.

### Operational effect
- Price Map rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 5 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-130

### Date
2026-04-02

### Change title
Dossier baby step 25 — OHLC Structure extraction with full timeframe OHLC evidence projection

### Change class
writer-side decomposition + deep-analysis OHLC-structure surface hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal deep control defaults alignment + minimal office truth updates

### What changed
- extracted visible `OHLC Structure` rendering into dedicated helper `ASC_BuildDossierDeepOHLCStructureSection(...)`
- preserved exact visible labels/order: `Higher-Timeframe Structure`, `Trend Structure`, `Range / Expansion Structure`, `Impulse / Pullback Structure`, `Break / Reclaim / Rejection Notes`, `OHLC Evidence Status`
- added writer-side OHLC evidence projection grouped by enabled deep-analysis timeframe with bar time and `O/H/L/C` rows plus copied counts and partial/missing honesty
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner/context availability plus timeframe count, total bars, and full/partial OHLC availability posture
- reused existing configurable deep timeframe control path (`deep_tf_*_bars`) and aligned defaults to `350` for lower timeframes and `150` for higher timeframes

### Why it mattered
This extends the dossier baby-step modularization pattern to DEEP SELECTIVE ANALYSIS OHLC Structure while keeping Layer 5 ownership boundaries intact and making OHLC evidence operator-visible without claiming broader model completion.

### Operational effect
- OHLC Structure rendering is modular and reusable
- OHLC section now publishes grouped per-timeframe OHLC bar evidence with explicit missing/partial posture
- configurable depth defaults now start at `350 LTF / 150 HTF` through the existing trader-control surface
- broader Layer 5 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-129

### Date
2026-04-02

### Change title
Dossier baby step 24 — Timeframe Coverage extraction with compact section telemetry

### Change class
writer-side decomposition + deep-analysis timeframe-coverage surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Timeframe Coverage` rendering into dedicated helper `ASC_BuildDossierDeepTimeframeCoverageSection(...)`
- preserved exact visible labels/order: `Enabled Timeframes`, `Bars per Timeframe`, `Coverage Sufficiency`, `Missing Timeframes`, `Coverage Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth-available and timeframe/bar-context-available posture note
- improved touched readability by explicitly distinguishing deferred coverage posture from preserved deep-payload coverage availability

### Why it mattered
This extends the dossier baby-step modularization pattern to DEEP SELECTIVE ANALYSIS Timeframe Coverage while preserving Layer 5 truth ownership boundaries.

### Operational effect
- Timeframe Coverage rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 5 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-128

### Date
2026-04-02

### Change title
Dossier baby step 22 — Correlation & Exposure extraction with compact section telemetry

### Change class
writer-side decomposition + shortlist correlation/exposure surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Correlation & Exposure` rendering into dedicated helper `ASC_BuildDossierShortlistCorrelationExposureSection(...)`
- preserved exact visible labels/order: `Correlation Score`, `Highest Correlations`, `Lowest Correlations`, `Exposure Conflict Status`, `Open / Pending Conflict Notes`, `Portfolio Conflict Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth-available and correlation/exposure-context-available posture note
- improved touched readability by projecting concise peer and conflict lines from existing correlation/exposure helpers with explicit operator wording

### Why it mattered
This extends the dossier baby-step modularization pattern to SHORTLIST SELECTION Correlation & Exposure while preserving Layer 4 truth ownership boundaries.

### Operational effect
- Correlation & Exposure rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 4 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-127

### Date
2026-04-02

### Change title
Dossier baby step 21 — Stability & Hold extraction with compact section telemetry

### Change class
writer-side decomposition + shortlist stability/hold surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Stability & Hold` rendering into dedicated helper `ASC_BuildDossierShortlistStabilityHoldSection(...)`
- preserved exact visible labels/order: `Hold Status`, `Stability Status`, `Replacement Pressure`, `Selection Continuity`, `Shortlist Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth-available and hold/continuity-context-available posture note
- improved touched readability by projecting concise deferred-model wording while keeping explicit continuity posture and missingness honesty

### Why it mattered
This extends the dossier baby-step modularization pattern to SHORTLIST SELECTION Stability & Hold while preserving Layer 4 truth ownership boundaries.

### Operational effect
- Stability & Hold rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 4 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-126

### Date
2026-04-02

### Change title
Dossier baby step 20 — Shortlist Core extraction with compact section telemetry

### Change class
writer-side decomposition + shortlist-core surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Shortlist Core` rendering into dedicated helper `ASC_BuildDossierShortlistCoreSection(...)`
- preserved exact visible labels/order: `Shortlist Status`, `Shortlist Rank`, `Priority Score`, `Selection Posture`, `Reason Summary`, `Promotion Status`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth-available and shortlist-context-available posture note
- improved touched readability by projecting concise shortlist values and explicit score/rank posture while retaining owner-backed reason and promotion truth

### Why it mattered
This extends the dossier baby-step modularization pattern to SHORTLIST SELECTION Shortlist Core while preserving Layer 4 truth ownership boundaries.

### Operational effect
- Shortlist Core rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 4 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-125

### Date
2026-04-02

### Change title
Dossier baby step 19 — Candidate Filtering Sorting Inputs extraction with compact section telemetry

### Change class
writer-side decomposition + sorting-input surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Sorting Inputs` rendering into dedicated helper `ASC_BuildDossierCandidateFilteringSortingInputsSection(...)`
- preserved exact visible labels/order: `Spread Gate`, `Freshness Gate`, `State Gate`, `Liquidity Gate`, `Volatility Gate`, `Quality Gate`, `Sorting Input Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth-available and gate-context-available posture note
- improved touched readability by projecting concise `Pass`/`Fail`/`Pending` gate wording while retaining owner-backed summary and explicit unavailable volatility posture

### Why it mattered
This extends the dossier baby-step modularization pattern to CANDIDATE FILTERING Sorting Inputs while preserving Layer 3 truth ownership boundaries.

### Operational effect
- Sorting Inputs rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 3 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-124

### Date
2026-04-02

### Change title
Dossier baby step 18 — Candidate Filtering Blockers & Dependencies extraction with compact section telemetry

### Change class
writer-side decomposition + blocker/dependency surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Blockers & Dependencies` rendering into dedicated helper `ASC_BuildDossierCandidateFilteringBlockersDependenciesSection(...)`
- preserved exact visible labels/order: `Disqualifiers`, `Dependencies`, `Missing Confirmation`, `Next Required Step`, `Constraint Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth-available and blocker/dependency-context-available posture note
- improved touched readability by projecting concise operator-facing unavailable/fallback wording while retaining owner-backed values

### Why it mattered
This extends the dossier baby-step modularization pattern to CANDIDATE FILTERING Blockers & Dependencies while preserving Layer 3 truth ownership boundaries.

### Operational effect
- Blockers & Dependencies rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/context availability posture
- broader Layer 3 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-123

### Date
2026-04-02

### Change title
Dossier baby step 17 — Candidate Filtering Gate Status extraction with compact section telemetry

### Change class
writer-side decomposition + candidate-filter gate-surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Gate Status` rendering into dedicated helper `ASC_BuildDossierCandidateFilteringGateStatusSection(...)`
- preserved exact visible labels/order: `Filter State`, `Eligibility Status`, `Gate Freshness`, `Reason Summary`, `Decision Confidence`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with owner-truth-available and freshness-available posture note
- improved touched readability by projecting concise filter state wording while retaining explicit owner-backed reason/freshness/confidence posture

### Why it mattered
This extends the dossier baby-step modularization pattern to CANDIDATE FILTERING Gate Status while preserving Layer 3 truth ownership boundaries.

### Operational effect
- Gate Status rendering is modular and reusable
- section now emits compact status telemetry for owner-truth/freshness availability posture
- broader Layer 3 hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-122

### Date
2026-04-02

### Change title
Dossier baby step 16 — Margin extraction with compact section telemetry

### Change class
writer-side decomposition + margin-surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Margin` rendering into dedicated helper `ASC_BuildDossierMarginSection(...)`
- preserved exact visible labels/order: `Margin Mode`, `Margin Hedged`, `Margin Buy Initial`, `Margin Buy Maintenance`, `Margin Sell Initial`, `Margin Sell Maintenance`, `Margin Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with account-context-available and broker/spec-margin-detail-available posture note
- improved touched readability by projecting concise account/spec-backed values when available and keeping explicit unavailable posture when sparse

### Why it mattered
This extends the dossier baby-step modularization pattern to SESSIONS, SWAP & MARGIN Margin while preserving margin/account truth ownership boundaries.

### Operational effect
- Margin rendering is modular and reusable
- section now emits compact status telemetry for account/spec margin availability posture
- broader margin hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-121

### Date
2026-04-02

### Change title
Dossier baby step 15 — Swap extraction with compact section telemetry

### Change class
writer-side decomposition + swap-surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Swap` rendering into dedicated helper `ASC_BuildDossierSwapSection(...)`
- preserved exact visible labels/order: `Swap Type`, `Swap Long`, `Swap Short`, `Swap Monday`, `Swap Tuesday`, `Swap Wednesday`, `Swap Thursday`, `Swap Friday`, `Swap Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with swap-values-available and swap-schedule-available posture note
- improved touched readability by keeping concise, explicit unavailable swap posture and compact swap notes

### Why it mattered
This extends the dossier baby-step modularization pattern to SESSIONS, SWAP & MARGIN Swap while preserving swap truth ownership boundaries.

### Operational effect
- Swap rendering is modular and reusable
- section now emits compact status telemetry for swap value/schedule availability posture
- broader swap hydration/completeness redesign remains intentionally deferred

## Ledger ID: CL-120

### Date
2026-04-02

### Change title
Dossier baby step 14 — Sessions extraction with compact section telemetry

### Change class
writer-side decomposition + session-surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Sessions` rendering into dedicated helper `ASC_BuildDossierSessionsSection(...)`
- preserved exact visible labels/order: `Quote Session Status`, `Trade Session Status`, `Quote Sessions`, `Trade Sessions`, `Session Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with session-state-available and schedule-detail-available posture note
- improved touched readability by keeping concise session status/note projection and explicit unavailable schedule placeholders

### Why it mattered
This extends the dossier baby-step modularization pattern to SESSIONS, SWAP & MARGIN Sessions while preserving Layer 1/tradeability ownership boundaries.

### Operational effect
- Sessions rendering is modular and reusable
- section now emits compact status telemetry for session/schedule availability posture
- explicit schedule hydration and broader session completeness redesign remain intentionally deferred

## Ledger ID: CL-119

### Date
2026-04-02

### Change title
Dossier baby step 13 — Trading Conditions Volume-Rules extraction with compact section telemetry

### Change class
writer-side decomposition + volume-rule surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Volume Rules` rendering into dedicated helper `ASC_BuildDossierTradingConditionsVolumeRulesSection(...)`
- preserved exact visible labels/order: `Minimum Volume`, `Maximum Volume`, `Volume Step`, `Stops Level`, `Freeze Level`, `Position Rule Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with packet-values-available and stop/freeze-completeness-available posture note
- improved touched readability by keeping concise volume/stop projections and explicit `Freeze Level: unavailable` posture

### Why it mattered
This extends the dossier baby-step modularization pattern to TRADING CONDITIONS & CONTRACT SPECS Volume Rules while preserving Layer 2/spec ownership boundaries.

### Operational effect
- Volume Rules rendering is modular and reusable
- section now emits compact status telemetry for volume/stop availability posture
- broader Layer 2 volume/spec completeness redesign remains intentionally deferred

## Ledger ID: CL-118

### Date
2026-04-02

### Change title
Dossier baby step 12 — Trading Conditions Trading-Permissions extraction with compact section telemetry

### Change class
writer-side decomposition + permission/spec surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Trading Permissions` rendering into dedicated helper `ASC_BuildDossierTradingConditionsPermissionsSection(...)`
- preserved exact visible labels/order: `Trade Mode`, `Execution Mode`, `Filling Mode`, `Expiration Mode`, `GTC Mode`, `Orders Allowed`, `Trade Permission Status`, `Broker Validation Status`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with packet-values-available and permission/spec-freshness-available posture note
- improved touched readability by keeping helper-humanized mode fields and explicit sparse placeholders for unavailable permission detail fields

### Why it mattered
This extends the dossier baby-step modularization pattern to TRADING CONDITIONS & CONTRACT SPECS Trading Permissions while preserving Layer 2/spec ownership boundaries.

### Operational effect
- Trading Permissions rendering is modular and reusable
- section now emits compact status telemetry for permission availability posture
- broader Layer 2 permission/spec completeness redesign remains intentionally deferred

## Ledger ID: CL-117

### Date
2026-04-02

### Change title
Dossier baby step 11 — Trading Conditions Price & Contract extraction with compact section telemetry

### Change class
writer-side decomposition + contract/spec surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Price & Contract` rendering into dedicated helper `ASC_BuildDossierTradingConditionsPriceContractSection(...)`
- preserved exact visible labels/order: `Digits`, `Point`, `Contract Size`, `Tick Size`, `Tick Value`, `Spread Type`, `Calculation Mode`, `Contract Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with packet-values-available and spec-values-available posture note
- improved touched readability by projecting `Calculation Mode` from existing symbol-spec helper and keeping explicit `Spread Type: unavailable` posture

### Why it mattered
This extends the dossier baby-step modularization pattern to TRADING CONDITIONS & CONTRACT SPECS Price & Contract while preserving Layer 2/spec ownership boundaries.

### Operational effect
- Price & Contract rendering is modular and reusable
- section now emits compact status telemetry for packet/spec availability posture
- broader Layer 2 contract/spec completeness redesign remains intentionally deferred

## Ledger ID: CL-116

### Date
2026-04-02

### Change title
Dossier baby step 10 — Market Watch Volatility & Friction extraction with compact section telemetry

### Change class
writer-side decomposition + volatility/friction surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Volatility & Friction` rendering into dedicated helper `ASC_BuildDossierMarketWatchVolatilityFrictionSection(...)`
- preserved exact visible labels/order: `ATR Value`, `ATR %`, `Spread / ATR`, `Volatility Posture`, `Friction Posture`, `Liquidity Posture`, `Market Watch Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with atr-available, continuity-sensitive, and regime/liquidity-helper-availability posture note
- improved touched readability by projecting concise helper-backed posture text and compact market-watch notes with explicit continuity/unavailable messaging

### Why it mattered
This extends the dossier baby-step modularization pattern to MARKET WATCH Volatility & Friction while preserving Layer 2 and summary-helper ownership boundaries.

### Operational effect
- Volatility & Friction rendering is modular and reusable
- section now emits compact status telemetry for ATR/continuity/helper-availability posture
- broader Layer 2/ATR/regime/friction model redesign remains intentionally deferred

## Ledger ID: CL-115

### Date
2026-04-02

### Change title
Dossier baby step 9 — Market Watch Quote Snapshot extraction with compact section telemetry

### Change class
writer-side decomposition + quote-snapshot surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Quote Snapshot` rendering into dedicated helper `ASC_BuildDossierMarketWatchQuoteSnapshotSection(...)`
- preserved exact visible labels/order: `Bid`, `Ask`, `Last`, `Spread`, `Spread %`, `Last Tick Time`, `Tick Age`, `Quote Freshness`, `Observed Time`, `Quote Continuity Status`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with live-quote, continuity-backed, and freshness-degraded/stale posture note
- improved touched readability: tick age now compact seconds text; continuity status now explicit `Live` / `Continuity-backed` / `Unavailable`

### Why it mattered
This extends the dossier baby-step modularization pattern to MARKET WATCH Quote Snapshot while preserving Layer 2 quote/freshness/continuity ownership boundaries.

### Operational effect
- Quote Snapshot rendering is modular and reusable
- section now emits compact status telemetry for live/continuity/freshness posture
- broader Layer 2 quote/watch model redesign remains intentionally deferred

## Ledger ID: CL-114

### Date
2026-04-02

### Change title
Dossier baby step 8 — Market State State-Timing extraction with compact section telemetry

### Change class
writer-side decomposition + timing/freshness surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `State Timing` rendering into dedicated helper `ASC_BuildDossierMarketStateTimingSection(...)`
- preserved exact visible labels/order: `Last Checked`, `Next Check Due`, `State Freshness`, `State Confidence`, `Bid / Ask Presence`, `State Notes`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with stale/degraded freshness and confidence-availability posture note
- improved `State Notes` readability by projecting due-reason through existing operator helper

### Why it mattered
This extends the dossier baby-step modularization pattern to MARKET STATE State Timing while preserving Layer 1 timing/freshness/confidence ownership boundaries.

### Operational effect
- State Timing rendering is modular and reusable
- section now emits compact status telemetry for freshness/confidence posture
- broader Layer 1 timing/freshness model work remains intentionally deferred

## Ledger ID: CL-113

### Date
2026-04-02

### Change title
Dossier baby step 7 — Market State State-Core extraction with compact section telemetry

### Change class
writer-side decomposition + market-state surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `State Core` rendering into dedicated helper `ASC_BuildDossierMarketStateCoreSection(...)`
- preserved exact visible labels/order: `Market Status`, `Tradeability Status`, `Session Status`, `Open / Closed / Uncertain`, `Open / Closed / Uncertain Reason`
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with uncertain/degraded and tradeability-availability posture note
- kept `State Timing` and other MARKET STATE subsections untouched

### Why it mattered
This extends the dossier baby-step modularization pattern to MARKET STATE State Core while preserving Layer 1/filter ownership boundaries.

### Operational effect
- State Core rendering is modular and reusable
- section now emits compact status telemetry for uncertain/degraded posture
- broader Layer 1 behavior redesign remains intentionally deferred

## Ledger ID: CL-112

### Date
2026-04-02

### Change title
Dossier baby step 6 — Symbol Metadata extraction with compact section telemetry

### Change class
writer-side decomposition + metadata-surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Symbol Metadata` rendering into dedicated helper `ASC_BuildDossierSymbolMetadataSection(...)`
- preserved exact visible labels/order for metadata fields (`Exchange` through `Contract Profile Summary`)
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with broker/spec support counts
- tightened `Contract Profile Summary` to a compact operator-readable format while preserving metadata-source truth

### Why it mattered
This extends the dossier baby-step modularization pattern to Symbol Metadata while preserving broker/spec ownership boundaries.

### Operational effect
- Symbol Metadata rendering is modular and reusable
- section now emits compact status telemetry for sparse/available posture
- broker/spec completeness and sourcing redesign remain intentionally deferred

## Ledger ID: CL-111

### Date
2026-04-02

### Change title
Dossier baby step 5 — Classification Authority extraction with compact section telemetry

### Change class
writer-side decomposition + classification-surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Classification Authority` rendering into dedicated helper `ASC_BuildDossierClassificationAuthoritySection(...)`
- preserved exact visible labels/order for advanced, broker-support, and resolved classification fields
- added lightweight section telemetry via shared `ASC_DossierSectionStatus` with resolved/support posture note
- improved touched operator wording while keeping advanced-authoritative and broker-supporting doctrine boundary explicit

### Why it mattered
This extends the dossier baby-step modularization pattern to the Classification Authority subgroup while preserving upstream classification ownership boundaries.

### Operational effect
- Classification Authority rendering is modular and reusable
- section now emits compact status telemetry
- classification engine logic and row/data cleanup remain intentionally deferred

## Ledger ID: CL-110

### Date
2026-04-02

### Change title
Dossier baby step 4 — Identity Core extraction with compact section telemetry

### Change class
writer-side decomposition + identity-surface clarity hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `Identity Core` rendering into dedicated helper `ASC_BuildDossierIdentityCoreSection(...)`
- preserved exact visible labels/order: `Symbol`, `Display Name`, `Broker Symbol Name`, `Asset Type`, `Instrument Family`, `Calculation Type`, `Chart Mode`
- added lightweight Identity Core telemetry via shared `ASC_DossierSectionStatus`, including partial-resolution posture/note
- kept Classification Authority and Symbol Metadata rendering untouched

### Why it mattered
This extends the dossier baby-step modularization pattern to the Identity Core subgroup while preserving identity truth ownership boundaries.

### Operational effect
- Identity Core rendering is modular and reusable
- Identity Core section now emits compact status telemetry
- broader Symbol Identity subgroup work remains intentionally deferred

## Ledger ID: CL-109

### Date
2026-04-01

### Change title
Dossier baby step 3 — Publication & Integrity extraction with section telemetry and clarity hardening

### Change class
writer-side decomposition + integrity-surface clarity pass (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `PUBLICATION & INTEGRITY` rendering into dedicated helper `ASC_BuildDossierPublicationIntegritySection(...)`
- preserved exact visible labels/order: `Publication Status`, `Last Published`, `Last Good Fallback`, `Current Bundle Status`, `Continuity Mode`, `Missing / Delayed Areas`, `Integrity Notes`
- landed lightweight section telemetry for this section via shared `ASC_DossierSectionStatus`
- improved touched wording while preserving honesty around degraded/continuity/delayed posture

### Why it mattered
This extends the dossier baby-step extraction pattern to a publication-sensitive section without changing publication engine behavior or ownership boundaries.

### Operational effect
- PUBLICATION & INTEGRITY is now modularized and easier to reuse in later baby steps
- section-level integrity telemetry is now available
- broader dossier and publication pipeline redesign remains intentionally deferred

## Ledger ID: CL-108

### Date
2026-04-01

### Change title
Dossier baby step 2 — Operator Snapshot extraction, compact readability cleanup, and section telemetry landing

### Change class
writer-side decomposition + trader-surface hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted visible `OPERATOR SNAPSHOT` rendering into dedicated helper `ASC_BuildDossierOperatorSnapshotSection(...)`
- preserved exact visible labels/order: `Primary Read`, `Primary Risk`, `Primary Opportunity`, `Primary Constraint`, `Primary Next Check`, `One-Line Summary`
- landed lightweight section telemetry for Operator Snapshot using `ASC_DossierSectionStatus` (`section/ran/posture/populated/missing/continuity_used/note`)
- tightened touched wording for trader readability and reduced One-Line Summary from verbose status dump to compact read/risk/next line

### Why it mattered
This extends the dossier baby-step modularization standard from header-only to Operator Snapshot while keeping writer/engine ownership boundaries intact.

### Operational effect
- Operator Snapshot rendering is modular and reusable for future dossier/current-focus alignment
- section-level telemetry is now available for this subsection
- rest of dossier remains intentionally deferred in this pass

## Ledger ID: CL-107

### Date
2026-04-01

### Change title
Dossier baby step 1 — top header block extraction, operator wording cleanup, and section telemetry seed

### Change class
writer-side decomposition + surface hardening (bounded)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + minimal office truth updates

### What changed
- extracted canonical dossier top header block composition into dedicated writer helper `ASC_BuildDossierTopHeaderSection(...)`
- preserved exact visible header labels and order (`Generated` through `Deep Analysis Status`)
- added compact reusable section telemetry (`ASC_DossierSectionStatus`) and emitted one header telemetry line with section/posture/populated/missing/continuity/note
- cleaned touched operator wording in header value projection (`Selection Sync Pending`, concise deep-analysis header wording)

### Why it mattered
This establishes the standard baby-step extraction pattern for later dossier modularization without rewriting unrelated sections or moving engine ownership into the writer.

### Operational effect
- top header block is now modular and easier to test/extend in future baby steps
- header status telemetry is now available as lightweight section-level evidence
- rest of dossier body remains intentionally deferred and behaviorally unchanged

## Ledger ID: CL-106

### Date
2026-04-01

### Change title
First post-doctrine MT5 hardening: temp-readback validation, dossier skip evidence, and operator wording cleanup

### Change class
runtime hardening + contradiction closure (bounded)

### Stage / domain
`mt5/io/ASC_FileIO.mqh` + `mt5/runtime/ASC_Dispatcher.mqh` + `mt5/core/ASC_RuntimeState.mqh` + HUD/dossier operator text wording

### What changed
- added explicit temp-readback validation before promote in single and pair publication write paths so publish now enforces temp -> validate -> promote behavior more strictly
- added bundle-level dossier skipped count tracking and surfaced it in write-lane bundle logs and Artifact Bundle Manifest output
- replaced visible operator-facing `packet` wording with `market-watch snapshot` wording in HUD and dossier text paths to reduce dev-language leakage

### Why it mattered
The active runtime had a publication integrity contradiction (temp writes were token-validated pre-write but not explicitly validated from temp payload before promote), plus weak dossier skip evidence and operator-facing dev-language leakage in visible surfaces.

### Operational effect
- publication dishonesty risk is reduced by explicit temp validation guards
- write-lane evidence is stronger (`attempted/succeeded/failed/skipped`)
- operator-facing wording better matches doctrine without changing truth ownership

## Ledger ID: CL-105

### Date
2026-04-01

### Change title
ASC_CORE doctrine integration into active blueprint/roadmap/office control stack

### Change class
blueprint + office control-system integration (no runtime code change)

### Stage / domain
`Aurora Sentinel Core/ASC_CORE.MD` -> `Aurora Sentinel Core/blueprint/final/*` + `Aurora Sentinel Core/blueprint/roadmap/*` + front-door/office control files

### What changed
- split-integrated canonical doctrine from `ASC_CORE.MD` into active doctrine owner files for runtime law, data ownership contract, dossier product law, publication continuity law, HUD/operator-surface law, and logging/validation evidence law
- landed `ASC_SYSTEM_RECOVERY_AND_PRODUCT_HARDENING_ROADMAP.md` under active roadmap control from the source doctrine roadmap block
- aligned front-door control docs (`README.md`, `MASTER_INDEX.md`, `CHAT_CONTINUATION_GUIDE.md`, `FRONT_DOOR_CHECKLIST.md`) to reference the landed doctrine stack
- updated office status/log/decision records to mark this pass as blueprint/control-only and to explicitly defer MT5/runtime implementation edits

### Why it mattered
A single-source doctrine (`ASC_CORE.MD`) existed but was not fully landed into split owner files and office truth. This pass removes that integration gap and strengthens anti-drift control alignment without claiming runtime completion.

### Operational effect
- active blueprint/roadmap doctrine stack now contains explicit owner files for the full ASC core law set
- office and front-door surfaces now acknowledge the new doctrine stack as landed control truth
- MT5/runtime implementation remains intentionally deferred

## Ledger ID: CL-104

### Date
2026-04-01

### Change title
Recovery consolidation — align Phase 0–7 scope truth across front-door and office control surfaces

### Change class
cross-phase consolidation and over-claim prevention hardening

### Stage / domain
`FRONT_DOOR_CHECKLIST.md` + `office/ROADMAP_STATUS.md` consolidation truth alignment

### What changed
- added a front-door `Recovery phase reality map` that explicitly states the actual landed scope of Phases 0 through 7 and locks out subsystem-complete over-claims
- added a matching office `Recovery phase reality map` in roadmap status to keep control truth aligned with active runtime evidence and recovery history

### Why it mattered
Recovery phases landed unevenly and mostly as narrow seam repairs; without explicit consolidation mapping, future work can over-read phase labels as broad subsystem completion.

### Operational effect
- repo front door and office now tell one coherent “what actually landed” story
- future workers can continue safely without re-auditing every recovery diff to infer scope truth
- runtime behavior remains unchanged in this consolidation pass

## Ledger ID: CL-103

### Date
2026-04-01

### Change title
PHASE 7 hardening gate — owner-map recheck, regression invariants, and patch-category verification matrix

### Change class
front-door/control-surface regression prevention hardening

### Stage / domain
`FRONT_DOOR_CHECKLIST.md` recovery hardening gate for post-recovery patches

### What changed
- added a dedicated `PHASE 7 — Regression-prevention hardening gate` section that:
  - reasserts active compile root and owner map
  - freezes non-drift recovery invariants (selected-symbol owner path, essentials-first publication honesty, HUD consumer-only law, starvation-safe calmness)
  - defines required verification checks by patch category
  - bans high-risk phase mixing patterns that previously caused drift/regression

### Why it mattered
Recovered runtime correctness/performance can regress quietly when future patches mix phases or skip owner/invariant verification.

### Operational effect
- future workers have explicit, bounded hardening checks before patching sensitive lanes
- owner-boundary drift and “quiet regression” classes become easier to detect during review
- no runtime behavior was changed in this hardening pass

## Ledger ID: CL-102

### Date
2026-04-01

### Change title
PHASE 6 throughput restoration — sustained scan-pressure boost and dossier write-slice bounding

### Change class
runtime performance/throughput tuning (correctness-preserving)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` dynamic scan admission + write-lane pacing

### What changed
- expanded `ASC_DynamicL1PacketTarget` with sustained-scan-pressure boosting and broader hard-cap admission so backlog periods can process more Layer 1 work per scan beat
- widened `ASC_DynamicL1BurstCap` ceiling and added backlog-sensitive burst boosts to increase lawful scan micro-burst throughput under pressure
- added scan-pressure-aware dossier budget bounding in write lane so dossier continuation proceeds incrementally without consuming oversized write slices during active scan backlog

### Why it mattered
Recent calmness controls could leave scan throughput too conservative under sustained backlog and allow long dossier-heavy write beats that made Layer 1 feel less instant.

### Operational effect
- Layer 1 can admit materially more useful work when backlog persists
- write lane remains serviceable for essentials/dossiers while avoiding write-beat monopolization under scan pressure
- correctness and ownership boundaries remain unchanged

## Ledger ID: CL-101

### Date
2026-04-01

### Change title
PHASE 5 HUD reset-admission hardening for same-scope transitions and sync cache invalidation

### Change class
HUD consumer-surface correctness repair

### Stage / domain
`mt5/hud/ASC_HUD_Manager.mqh` panel reset gate + sync cache invalidation

### What changed
- replaced scope-only reset admission in `ASC_HudNeedsPanelReset` with broader lawful gating that also resets when page identity changes, selected symbol changes in symbol scope, or section/stat view changes in aspect-detail scope
- updated manual `Sync` handler to clear shortlist signature cache alongside data/structure signatures so operator rehydrate requests cannot retain stale shortlist ordering state

### Why it mattered
Scope-only reset gating could preserve stale panel state across same-scope transitions, which risks overlap, ghost content, and half-old/half-new symbol/section views even when backend truth is current.

### Operational effect
- same-scope HUD transitions now clear stale panels lawfully before redraw
- selected-symbol and section switches now commit cleaner consumer-surface transitions
- manual sync now forces full HUD rehydrate signatures for list + symbol surfaces without shifting ownership into HUD

## Ledger ID: CL-100

### Date
2026-04-01

### Change title
Dossier Deep Analysis metadata deduplication guard in section enhancement

### Change class
artifact formatting stability correction

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` Deep Analysis section enrichment path

### What changed
- updated `ASC_DossierEnhanceDeepSection` to strip previously injected top-of-body metadata lines (`Working Deep View` / `Operator Use`) before writing current metadata
- retained existing section header normalization and preserved downstream deep body payload untouched after metadata cleanup

### Why it mattered
Repeated enhancement/preservation passes could accumulate duplicate metadata lines at the top of the Deep Analysis section, creating avoidable formatting drift.

### Operational effect
- Deep Analysis metadata now remains single-instance per enhancement pass
- preserved deep body content remains intact while top-of-section metadata reflects the current pass cleanly

## Ledger ID: CL-099

### Date
2026-04-01

### Change title
PHASE 3 selected-symbol synchronization repair — runtime owner enforcement and ordinary-sync starvation relief

### Change class
selected-symbol ownership and propagation correction

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` + `mt5/hud/ASC_HUD_Manager.mqh`

### What changed
- added `ASC_CURRENT_FOCUS_SYNC_STARVATION_SEC` and runtime helper logic so ordinary selected-symbol Current Focus sync can be admitted when queue age shows starvation under persistent scan backlog
- lane selection now admits persistence for starved ordinary Current Focus sync without coupling to Deep Analysis trigger behavior
- removed HUD helper mutations that directly set `current_focus_live_symbol` or Current Focus runtime status, keeping HUD as event source/consumer instead of a selected-symbol truth owner

### Why it mattered
Selected-symbol synchronization had drift and starvation risk: ordinary browsing could lag behind scan pressure and HUD logic could silently act like a second owner of Current Focus state.

### Operational effect
- one-owner selected-symbol state transitions are clearer in runtime
- ordinary viewed-symbol changes can progress without Deep Analysis dependency
- Deep Analysis remains explicit-trigger only and separate from normal sync

## Ledger ID: CL-098

### Date
2026-04-01

### Change title
PHASE 2 publication repair — Market Board weak-state validation seam closure

### Change class
essential publication integrity correction

### Stage / domain
`mt5/artifacts/ASC_MarketBoardWriter.mqh` required-section and correlation-token publication behavior

### What changed
- Market Board bucket rendering now returns whether a canonical bucket section was emitted
- build path now guarantees `Leading Three` and `Full Five` sections are present for lawful weak states (zero lawful survivors or no canonical-bucket survivors)
- correlation-token validation (`Cor `) is now required only when correlation lines are actually present in the generated board body

### Why it mattered
Valid zero-shortlist/pending-shortlist publication states could previously fail required-token validation and falsely mark essentials as failed/pending, which then blocked downstream dossier continuation for avoidable reasons.

### Operational effect
- essential board publication is deterministic across normal and weak shortlist states
- bundle failure signals now better reflect real publication faults instead of preventable section-omission validation failures
- later phases can repair selected-symbol sync and HUD on a more stable publication base

## Ledger ID: CL-097

### Date
2026-04-01

### Change title
PHASE 1 scanner/state restoration — Layer 2 companion starvation-relief admission

### Change class
runtime scanner-state correction (upstream only)

### Stage / domain
`mt5/runtime/ASC_Dispatcher.mqh` companion-work admission logic

### What changed
- added a bounded Layer 2 starvation-relief guard in `ASC_ShouldRunLayer2CompanionWork`
- companion-work defer now protects Layer 1 confirmation/budget by default, but allows Layer 2 service when Layer 2 has been unsafely deferred beyond a short threshold
- preserved existing cycle-complete and idle-packet allowances; did not widen into publication/HUD logic

### Why it mattered
Without this correction, sustained Layer 1 due pressure could keep Layer 2 deferred long enough to distort open-symbol snapshot freshness and upstream readiness posture.

### Operational effect
- Layer 1 remains the dominant truth producer
- Layer 2 receives lawful periodic service under sustained scan pressure
- upstream scanner-state truth remains explainable without downstream publication/HUD dependence

## Ledger ID: CL-096

### Date
2026-04-01

### Change title
PHASE 0 live MT5 recovery freeze and guardrail hardening

### Change class
recovery-control hardening (no runtime behavior change)

### Stage / domain
front-door recovery gate + office status alignment

### What changed
- added a Phase 0 live recovery freeze section to `FRONT_DOOR_CHECKLIST.md` that explicitly defines compile root, runtime owner map, regression window, read-first order, do-not-touch-early boundaries, and required verification surfaces
- recorded temporary recovery precedence rule: active MT5 compile/runtime evidence outranks stale office/blueprint wording when contradictions are found
- recorded duplicate-tree warning that `mt5/mt5/**` is non-authoritative unless include-reachable from the active compile root
- synchronized office status/work-log surfaces to show this pass as control hardening only

### Why it mattered
Without this freeze layer, future recovery passes could patch the wrong tree, split selected-symbol ownership, or treat HUD/office wording as authority over active runtime behavior.

### Operational effect
- future workers can identify active runtime owners immediately
- early-phase recovery edits are bounded and phase-mixing risk is reduced
- Phase 1+ now has explicit proof surfaces to validate post-repair truth

## Ledger ID: CL-095

### Date
2026-04-01

### Change title
Stage 6 front-door, continuation, control-stack, and handover hardening

### Change class
repo-truth hardening + handover closure

### Stage / domain
front-door docs + office/control truth + implementation-next guidance

### What changed
- hardened `README.md`, `MASTER_INDEX.md`, `CHAT_CONTINUATION_GUIDE.md`, and `FRONT_DOOR_CHECKLIST.md` so the repo now states clearly what ASC is, what ASC is not, where canonical authority lives, what must be read first, and what comes next
- aligned office truth so Stage 1–6 completion, blueprint closure, implementation-pending truth, and verification/proof-pending truth are all explicit
- made implementation-next guidance practical: runtime/menu landing, Layer 5 payload landing, output proof, and live MT5 verification
- strengthened front-door anti-drift warnings against signal-engine creep, Layer 3 directional drift, Layer 4 best-trade drift, Layer 5 scope creep, Market Board signal-dashboard drift, Current Focus auto-deep misreadings, menu/settings backdoors, and hidden truth ownership in consumer surfaces
- preserved blueprint owner contracts as-is because no new contradiction required a doctrine reopening

### Why it mattered
Without this pass, future chats could still reopen doctrine accidentally, start in the wrong files, treat blueprint completion as runtime completion, or drift implementation work back into hidden signal-engine behavior.

### Operational effect
- the blueprint upgrade program now closes cleanly at the repo front door
- implementation and proof work can proceed from a stable doctrine base
- future chats now have one explicit read order, one explicit owner map, and one explicit warning surface for what must never drift

## Ledger ID: CL-094

### Date
2026-04-01

### Change title
Stage 5 blueprint consolidation for cross-file doctrine, front-door authority, and anti-drift hardening

### Change class
blueprint consolidation + repo-truth alignment

### Stage / domain
front-door/control truth + canonical blueprint authority + invalid-design hardening

### What changed
- aligned the root front-door files so they now point to the same authority order, Stage 1–5 completion story, and implementation-next guidance
- reinforced the five-layer doctrine so Layer 3 remains gate-only, Layer 4 remains attention-priority only, and Layer 5 remains promoted-only deep evidence ending in analyst / SIAM handoff
- hardened persistence, HUD, symbol-spine, action-surface, scope, menu/settings, and invalid-design contracts against signal-dashboard drift, hidden truth ownership, menu/settings backdoors, and Current Focus auto-deep misreadings
- synchronized office truth so Stage 5 is recorded honestly as blueprint consolidation rather than runtime completion

### Why it mattered
Without this pass, future implementation chats could still re-derive ownership from scattered docs, treat front-door files as competing doctrine, or drift Market Board, Current Focus, menu/settings, or Layer 5 into hidden signal-engine behavior.

### Operational effect
- future workers now have one clear answer for where authority lives
- blueprint completion and implementation-next work are explicitly separated
- the repo now presents one coherent architecture story across blueprint, office, and root entry surfaces

## Ledger ID: CL-093

### Date
2026-04-01

### Change title
Stage 4 field-contract completion for Layers 1–5 and SIAM handoff doctrine

### Change class
doctrine completion + repo-truth alignment

### Stage / domain
blueprint field-contract doctrine + front-door/control truth surfaces

### What changed
- completed the explicit required field contracts for Layer 1 Market State, Layer 2 Open Symbol Snapshot, Layer 3 Candidate Filtering, and Layer 4 Shortlist Selection
- completed the final Layer 5 ordered subsection contract with required fields for overview, timeframe settings, bar pack, OHLC evidence, interpretation, tick/spread windows, preservation state, microstructure notes, advanced context, decision support, and SIAM / analyst handoff
- froze observed-truth vs interpreted-truth separation where Layer 5 mixes raw evidence with bounded scanner interpretation
- made the ASC → SIAM / analyst handoff contract explicit while preserving the prohibition on final signal ownership inside ASC
- synchronized front-door and office truth so future repo entry points show that Stage 4 doctrine completion has landed

### Why it mattered
Without this pass, later schema and implementation work could still blur mandatory fields versus optional enrichments, mix raw evidence with interpretation, or let Layer 5 drift into a hidden signal engine.

### Operational effect
- future work now inherits complete layer field-law rather than vague output expectations
- symbol-context consumers now have one explicit deep-analysis subsection model and one bounded handoff contract
- ASC remains a truth producer with bounded interpretation, while SIAM / Aurora remains the downstream signal interpreter

## Ledger ID: CL-092

### Date
2026-04-01

### Change title
Stage 3 control-contract completion for trader controls, menu/settings doctrine, and Layer 5 Deep Analysis configuration

### Change class
doctrine completion + repo-truth alignment

### Stage / domain
blueprint control doctrine + front-door/control truth surfaces

### What changed
- completed the canonical menu/settings section model and section-by-section ownership boundaries
- froze timeframe enablement, bars-per-timeframe sufficiency doctrine, ATR/spread/tick evidence controls, and analyst-facing output controls for Deep Analysis
- made forbidden menu powers explicit so settings cannot drift into signal issuance, execution verdicts, order logic, shortlist authority, or hidden signal scoring
- synchronized Layer 5, persistence, HUD/operator-surface, symbol-information spine, scope/admissibility, canonical product spine, README/index/continuation docs, and office truth with the same Stage 3 control doctrine

### Why it mattered
Without this pass, later runtime and schema work could still treat the menu/settings surface as a lawless reconfiguration path that blurred service configuration, signal ownership, and consumer output.

### Operational effect
- future work now inherits one explicit trader-control doctrine for lawful Layer 5 configuration
- Deep Analysis completeness can no longer be treated as an opaque blob; per-timeframe sufficiency posture is now mandatory doctrine
- analyst-facing output controls are now frozen as consumer projection only

## Ledger ID: CL-091

### Date
2026-04-01

### Change title
Stage 2 operator-artifact contract completion for Market Board, Dossier, and Current Focus

### Change class
product contract completion + repo-truth alignment

### Stage / domain
blueprint artifact doctrine + front-door/control truth surfaces

### What changed
- completed the Market Board contract as a compact inspection-priority board that stops at Layer 4 depth
- completed the Dossier contract as the full per-symbol intelligence artifact with required section-level publication and failure/continuity visibility
- completed the Current Focus contract as the singleton selected-symbol working artifact with explicit selected-symbol-following law
- froze explicit role separation between Market Board, Dossier, and Current Focus
- made hard law vs required product contract vs future expansion option explicit for these artifacts
- aligned persistence/HUD/spine/front-door/control files so future work cannot drift these three artifacts into signal-board or hidden-truth-owner roles

### Why it mattered
Without this pass, later schema and menu/settings work could still blur inspection priority, per-symbol intelligence, and selected-symbol working posture into one confused surface.

### Operational effect
- future passes now inherit one frozen operator workflow: board first, then current focus/dossier inspection, then downstream SIAM interpretation
- product doctrine now explicitly blocks Market Board from becoming a signal dashboard
- Current Focus and Dossier no longer risk being treated as interchangeable hidden truth owners


## Ledger ID: CL-090

### Date
2026-04-01

### Change title
Stage 1 doctrine freeze for scanner truth ownership vs downstream SIAM / Aurora interpretation ownership

### Change class
doctrine freeze + repo-truth alignment

### Stage / domain
blueprint layer stack + scope/admissibility + front-door/control truth surfaces

### What changed
- added explicit Signal Ownership Law to the five-layer doctrine so ASC is frozen as truth producer rather than signal engine
- added explicit SIAM Consumption Contract for lawful Layer 1–5 truth consumption and downstream interpretation rights
- hardened Layer 3 into gate-pure/neutral eligibility authority with blocker taxonomy
- reframed Layer 4 ranking semantics into attention / inspection / promotion priority while preserving shortlist authority
- froze Layer 5 as deep evidence / deep context / bounded structural interpretation ending in analyst / SIAM handoff direction
- synchronized README, master index, continuation, front-door, roadmap status, and decision/work-log control files with the same scanner-vs-interpreter split

### Why it mattered
Without this freeze, future blueprint and product passes could keep drifting ASC toward owning final trade signals, which would corrupt layer boundaries and downstream interpretation authority.

### Operational effect
- future work now has one explicit doctrinal baseline for scanner truth vs interpretation ownership
- office/control/front-door docs no longer leave the scanner-vs-signal split implicit
- later stages remain open for handoff schema and product-contract expansion without reopening Stage 1 ownership law


## Ledger ID: CL-089

### Date
2026-03-30

### Change title
Deep Analysis trigger-status hardening on HUD selected-symbol readback with command-only posture alignment

### Change class
bounded layer5-preparation trigger-path hardening

### Stage / domain
selected-symbol deep-action surface (`hud`) + dossier deep wording alignment

### What changed
- HUD now carries runtime deep-trigger last-status and last-served timestamps into the selected-symbol Deep Analysis section
- added explicit trigger-status text mapping for queued/succeeded/failed/idle presentation
- Deep Analysis cards now surface trigger status + last-served timing while preserving explicit “no hidden run on page-open” messaging
- aligned Dossier deep-overview wording to command-only explicit-trigger posture

### Why it mattered
This removes lingering ambiguity where Deep Analysis readiness could be visible but trigger execution status remained opaque to the operator.

### Operational effect
- clearer explicit-trigger ownership in HUD Deep Analysis section
- stronger non-misleading selected-symbol deep-action experience
- preserved prepared-not-active Layer 5 posture without widening into payload implementation


## Ledger ID: CL-088

### Date
2026-03-30

### Change title
Cross-surface composition wording alignment across HUD, Market Board, Dossier, and Current Focus

### Change class
bounded operator-surface composition coherence correction

### Stage / domain
surface composition owners (`artifacts` + touched `hud`)

### What changed
- aligned Dossier and Current Focus section-family wording in touched selection context headings and filter-state labels
- aligned Deep Analysis command-only wording across Dossier/Current Focus status lines
- removed duplicated correlation/exposure suffix composition in Dossier for compact-line parity
- aligned Market Board role/missingness wording and corrected Current Focus refresh line to viewed-symbol sync posture
- aligned touched HUD shortlist-context language away from mixed Priority vs Shortlist terminology

### Why it mattered
This resolves remaining cross-surface wording drift that made the four primary operator surfaces feel fragmented despite shared runtime truth.

### Operational effect
- cleaner shared terminology across HUD/Board/Dossier/Current Focus
- improved product-family coherence without flattening surface role differences
- preserved existing ownership boundaries while reducing contradictory phrasing


## Ledger ID: CL-087

### Date
2026-03-30

### Change title
Layer 4 shortlist authority stabilization with stronger hold/material-shift evidence wording

### Change class
bounded shortlist-authority behavior/wording correction

### Stage / domain
shortlist owner + shortlist-context consumer (`shortlist_selection` + touched `hud`)

### What changed
- added shortlist decision evidence helper to emit deterministic transition evidence (`delta/proposed/existing`) for shortlist state decisions
- strengthened hold-defer reason wording with remaining-hold-seconds and evidence payload
- strengthened stable/material-shift shortlist reason text for clearer shortlist-authority explanation
- aligned HUD shortlist context reason text to show shortlist posture + shortlist authority reason when a symbol is shortlisted

### Why it mattered
This resolves weak shortlist transition explainability where shortlist authority behavior could appear opaque even when deterministic hold/material-shift logic was functioning.

### Operational effect
- calmer, more explainable shortlist authority posture in operator-facing shortlist context
- stronger trust in Top-3/Top-5 shortlist continuity without widening into board redesign
- preserved deterministic ordering and hold discipline while improving readability of shortlist decisions


## Ledger ID: CL-086

### Date
2026-03-30

### Change title
Layer 3 candidate-filter reason strengthening and downstream consumer wording alignment

### Change class
bounded layer3 cheap-gate quality correction

### Stage / domain
candidate filtering owner + touched consumers (`candidate_filtering` + `hud` + `dossier` + `current-focus`)

### What changed
- improved candidate-filter operator outcome labels to better distinguish blocked/degraded/stale posture from generic pending/fail wording
- strengthened reason summaries and dependency text into clearer trader-usable gate explanations and next-step guidance
- added shared candidate-bucket operator rendering so survivor posture suffixes map to readable bucket labels
- aligned touched HUD/Dossier/Current-Focus consumer text to consume strengthened Layer 3 reason outputs

### Why it mattered
This resolves thin/generic Layer 3 explanation quality that forced downstream surfaces to read like vague filler and weakened cheap-gate usefulness for operator decisions.

### Operational effect
- clearer pass/fail/pending/blocked/degraded/stale distinction for candidate-filter outputs
- stronger cheap-gate explainability without blurring into shortlist authority
- better consumer consistency across HUD Opportunity Check, Dossier Selection Filter, and Current Focus Selection Filter


## Ledger ID: CL-085

### Date
2026-03-30

### Change title
Layer 2 consumer-alignment hardening for HUD selected-symbol market/spec truth and zero-spread honesty

### Change class
bounded layer2-consumer ownership correction

### Stage / domain
open-symbol snapshot consumers (`hud` + `dossier` + `current-focus`)

### What changed
- replaced touched selected-symbol HUD quote-strip paths that directly consumed `SymbolInfoTick` with Layer 2 packet consumption
- hardened HUD Market Watch spread rendering to avoid synthetic zero-style presentation when packet truth is unavailable
- adjusted HUD Specification section precedence to favor Layer 2 packet truth for admitted symbols and reserve specification-cache fallback for non-packet states
- fixed dossier/current-focus spread-percent gating so valid zero spread is treated as lawful when Layer 2 spread validity is true

### Why it mattered
This resolves consumer-path drift where live market/spec truth could diverge from Layer 2 ownership and where valid 0.0 spread could be mislabeled as unavailable.

### Operational effect
- stronger single-owner behavior from Layer 2 for touched selected-symbol consumers
- cleaner missingness honesty in HUD Market Watch
- improved consistency between HUD, Dossier, and Current Focus spread semantics


## Ledger ID: CL-084

### Date
2026-03-30

### Change title
Market Board compact row recovery for trader scanability and canonical correlation/exposure composition

### Change class
bounded market-board composition correction

### Stage / domain
market-board artifact writer (`mt5/artifacts/ASC_MarketBoardWriter.mqh`)

### What changed
- tightened board Selection row composition to include shortlist state, candidate-filter operator state, compact reason wording, and shortlist posture in a stable operator-facing sequence
- removed duplicate exposure suffix concatenation in Correlation / Exposure row so each symbol row publishes one canonical compact correlation/exposure line
- preserved existing Leading Three / Full Five anti-duplication behavior and readiness-gated All-Markets Top Ten publication behavior
- kept board summary-only role and command-only Deep Analysis posture line intact

### Why it mattered
This resolves weak/duplicative compact row behavior that made board rows harder to scan quickly for shortlist intent and exposure posture.

### Operational effect
- cleaner, denser row readability for trader shortlist discovery
- explicit compact “why selected” context on every board symbol row
- correlation/exposure signaling remains mandatory and no longer repeats exposure wording in the same row


## Ledger ID: CL-083

### Date
2026-03-30

### Change title
Current Focus singleton viewed-symbol sync recovery with explicit Deep-enrichment separation

### Change class
bounded current-focus ownership correction

### Stage / domain
current-focus runtime ownership path (`runtime` + `hud` + `current-focus writer`)

### What changed
- added runtime state fields for viewed-symbol Current Focus sync queue/status tracking
- added dispatcher-owned viewed-symbol Current Focus write execution path separate from Deep trigger path
- expanded write-lane admission checks so viewed-symbol Current Focus sync can execute even when ordinary bundle write_dirty is false
- queued viewed-symbol Current Focus sync from HUD symbol-context interactions without triggering broad deep/runtime escalation
- updated Current Focus artifact wording to reflect singleton viewed-symbol ownership with explicit trigger-only Deep enrichment

### Why it mattered
This resolves the half-trigger/half-view ambiguity where Current Focus could remain stuck on an old symbol or appear missing unless Deep trigger semantics were used.

### Operational effect
- Current Focus now rewrites in place for the currently viewed symbol through a dedicated sync lane
- Deep Analysis remains explicit enrichment and is not implied by page visibility
- singleton Current Focus ownership is restored without introducing multiple focus artifacts


## Ledger ID: CL-082

### Date
2026-03-30

### Change title
Dossier full-universe publication continuation recovery in write lane

### Change class
bounded runtime publication-lane correction

### Stage / domain
dispatcher dossier continuation + dossier writer wording alignment

### What changed
- removed dossier candidate/count gating that effectively restricted publication to changed-subset behavior
- removed structural-delta dossier-trigger gating and unconditional write-cursor resets that could restart dossier waves before completion
- preserved bounded multi-beat continuation so dossier pass walks the full admissible symbol cache under write-budget limits
- retained atomic artifact + manifest-last publication discipline
- updated dossier coverage wording to explicit full admissible-universe bounded continuation posture

### Why it mattered
This resolves dossier starvation/under-publication where dossier waves could remain stuck in small recurring subsets instead of converging toward full broker-universe coverage.

### Operational effect
- dossier publication now trends to full admissible universe across beats
- partial publication remains explicit continuation rather than silent narrowed scope
- write-lane calmness and atomic publication discipline remain intact


## Ledger ID: CL-081

### Date
2026-03-30

### Change title
HUD cadence hardening for smoother selected-symbol tactical refresh without structural churn

### Change class
bounded HUD hot-path performance + cadence correction

### Stage / domain
HUD owner tactical refresh path (`mt5/hud/ASC_HUD_Manager.mqh`)

### What changed
- replaced heavy structural-signature hashing loop with lightweight revision/context signature
- enabled tactical cadence on symbol overview and aspect detail pages when selected symbol context is active
- aligned header clock baseline rendering to GMT source used by tactical cadence updates
- expanded selected-symbol tactical label refresh so symbol pages keep freshness/age feel across section switches
- kept refresh path bounded to selected-symbol lawful tactical fields; no shortlist/deep hidden recompute path added

### Why it mattered
This addresses jumpy/skipped-second HUD feel and weak selected-symbol liveliness caused by heavy signature work + suppressed tactical cadence on symbol pages.

### Operational effect
- smoother 1-second-feel HUD updates in symbol context
- less dependence on broad dirty render cycles for lawful fast fields
- preserved consumer-only HUD boundary and structural honesty posture


## Ledger ID: CL-080

### Date
2026-03-30

### Change title
HUD symbol-context recovery: persistent bottom-row section navigation and selected-symbol continuity hardening

### Change class
bounded HUD owner recovery patch

### Stage / domain
HUD selected-symbol workflow surface (`mt5/hud/ASC_HUD_Manager.mqh`)

### What changed
- restored persistent bottom symbol section row in symbol context with full eight-section coverage
- switched section row labels to canonical section-family names for doctrine alignment
- added adaptive two-row row layout on narrower widths to reduce clipping/inaccessibility while preserving pinned behavior
- preserved top symbol action row and command-only Deep Analysis semantics
- changed bottom-row Overview navigation to open symbol overview page directly while preserving selected symbol context

### Why it mattered
This resolves the symbol-context navigation regression where section flow became fragile/inaccessible and restores coherent selected-symbol workflow without turning HUD into hidden runtime authority.

### Operational effect
- symbol pages remain reachable through one persistent section row
- selected symbol stays pinned across section switches
- no hidden shortlist/deep execution path was introduced by visibility changes


## Ledger ID: CL-079

### Date
2026-03-30

### Change title
Phase-1 doctrine reconciliation and ownership lock for Current Focus / Dossier / HUD symbol context / Layer 4 discoverability / Deep Analysis boundary

### Change class
bounded doctrine-control reconciliation (no runtime code patch)

### Stage / domain
office + blueprint contract ownership alignment

### What changed
- recorded one canonical doctrine decision set in office controls and superseded trigger-owned-only Current Focus wording
- locked Current Focus as singleton selected-symbol working file rewritten in place on symbol switch
- reinforced full admissible-universe dossier publication target with explicit degraded/incomplete honesty rule for partial publication
- hardened HUD symbol-context contract wording: mandatory persistent top action row + mandatory persistent bottom section row, selected-symbol continuity across section switches, HUD consumer-only boundary preserved
- added explicit Layer 4 browse/discoverability wording for bucket/sub-group/symbol navigation with mandatory Leading Three / Full Five discoverability
- clarified Layer 5 near-term role as command-only/prepared and explicit non-implication rule (Deep Analysis page open does not imply deep run executed)
- reaffirmed Market Board role boundaries as shortlist-summary/discoverability surface only (not tick board, not second dossier, not deep payload surface)

### Why it mattered
This resolves active doctrine contradictions before runtime repair passes so implementation can proceed from one non-ambiguous product/ownership baseline.

### Operational effect
- office and blueprint control surfaces now state one coherent doctrine baseline
- downstream runtime phases have explicit implementation targets without reinterpretation drift
- doctrine authority supersedes trigger-owned-only wording in CL-078


## Ledger ID: CL-078

### Date
2026-03-30

### Change title
Final surface wording alignment across HUD, Market Board, Dossier, and Current Focus

### Change class
bounded surface-truth coherence cleanup

### Stage / domain
operator-facing artifact and HUD wording alignment

### What changed
- aligned Market Board deep-analysis line wording to explicit command-only posture
- reduced Dossier publication section dump feel by replacing “Last Actions/Proof” phrasing with concise publication-integrity language
- aligned Current Focus deep-analysis and status reason wording to explicit trigger-owned command-only semantics
- tuned touched HUD shortlist/deep-analysis wording for consistent Current Focus trigger/readback language

### Why it mattered
This removes residual cross-surface wording drift and keeps HUD, Market Board, Dossier, and Current Focus coherent as one operator-facing system.

### Operational effect
- cleaner, less contradictory operator wording
- better cadence/ownership signaling across surfaces
- improved final review readiness before one consolidated user commit


## Ledger ID: CL-077

### Date
2026-03-30

### Change title
Layer 3 reason posture and Layer 4 invalid/material-shift shortlist correction

### Change class
bounded selection-stack semantics hardening

### Stage / domain
candidate filtering owner + shortlist authority transition handling

### What changed
- improved Layer 3 gate reason summaries and dependency text in `mt5/candidate_filtering/ASC_SelectionFilter.mqh` with explicit spread-cap visibility and richer pass/fail/pending context
- expanded candidate-bucket posture shaping to include `_watch` for compression-regime monitoring while preserving `_priority`/`_guarded` semantics
- preserved lawful 0.0 spread treatment by removing zero-spread invalidation in gate spread-percent helper
- corrected Layer 4 shortlist invalid transition in `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh` so unlawful existing membership with lawful replacements transitions to `material-shift` replacement instead of staying invalid

### Why it mattered
This strengthens selection-stack inspectability and closes an invalid/membership replacement ambiguity without widening into Layer 5 or layout redesign.

### Operational effect
- stronger Layer 3 gate readability and next-step clarity
- clearer candidate-bucket intent for downstream shortlist context
- more lawful Layer 4 invalid/material-shift replacement behavior under survivor refresh


## Ledger ID: CL-076

### Date
2026-03-30

### Change title
Derived engine correctness hardening for ATR/regime/liquidity/friction/correlation

### Change class
bounded derived-owner correction and compact-consumer alignment

### Stage / domain
shortlist derived engines + board/current-focus compact context consumers

### What changed
- replaced weak ATR approximation path with bounded D1 true-range ATR calculation and short-lived cache reuse in `mt5/shortlist_selection/ASC_ATRSummaryEngine.mqh`
- tightened regime/context-quality derivation in `mt5/shortlist_selection/ASC_RegimeSummaryEngine.mqh` using ATR %, spread/ATR support, freshness posture, and explicit unavailable/guarded/weak states
- strengthened `mt5/shortlist_selection/ASC_LiquidityFrictionSummaryEngine.mqh` to preserve lawful 0.0 spread behavior and clearer unavailable boundaries
- hardened `mt5/shortlist_selection/ASC_CorrelationSummaryEngine.mqh` to penalize low-support correlation (name-only or stale/continuity-backed packet posture)
- aligned compact spread/ATR consumer rendering in `mt5/artifacts/ASC_MarketBoardWriter.mqh` and `mt5/artifacts/ASC_CurrentFocusWriter.mqh` to rely on readiness checks

### Why it mattered
This reduces generic placeholder drift in derived outputs and improves inspectable compact context truth without widening into deep-analysis or layout redesign work.

### Operational effect
- ATR/regime/liquidity/friction/context outputs are more bounded and honest under weak evidence
- compact correlation scores are less likely to overstate confidence with weak peer support
- board/current-focus compact context lines now reflect derived readiness more faithfully


## Ledger ID: CL-075

### Date
2026-03-30

### Change title
Layer 2 open-snapshot broker-validation contract hardening and risk-consumer ownership alignment

### Change class
bounded Layer 2 truth audit and consumer-alignment correction

### Stage / domain
open symbol snapshot owner + artifact text helper consumer path

### What changed
- expanded `mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` changed-subset block to include broker-validation-ready market-watch and trading-conditions fields (`spread_pct`, day-range fields, contract/tick/volume/trade/execution/currency fields) while preserving explicit `unavailable` posture for missing truth
- preserved lawful quote ownership behavior without introducing forced universe assumptions or invalid spread interpretation
- updated `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` position-risk estimate path to consume Layer 2 packet-owned `tick_size`/`tick_value` first, then use broker raw symbol fallback only when Layer 2 packet truth is unavailable
- added explicit broker-truth validation notes to `mt5/artifacts/ASC_OpenSymbolSnapshotWriter.mqh` ownership section for later manual/live comparison workflow

### Why it mattered
This reduces split ownership drift and improves inspectability of Layer 2 truth for later broker/live validation without widening into a new subsystem.

### Operational effect
- stronger Layer 2 contract visibility for broker-validation checks
- cleaner downstream ownership alignment for tick-value/tick-size consumer reads
- preserved cadence split and explicit missingness posture on touched paths


## Ledger ID: CL-074

### Date
2026-03-30

### Change title
Candidate-filtering cheap-gate reason and survivor-context hardening

### Change class
bounded Layer 3 gate-logic and reason-clarity correction

### Stage / domain
candidate filtering owner + downstream reason text alignment

### What changed
- strengthened `mt5/candidate_filtering/ASC_SelectionFilter.mqh` reason summaries/codes for pass/pending/fail branches to reduce generic wording and improve inspectable gate posture
- added bounded candidate-bucket posture shaping in candidate filtering (`_priority` / `_guarded`) based on lawful market-watch readiness and cheap liquidity/friction context
- enriched dependencies text with spread percent and compact liquidity/friction/regime context for downstream consumers
- updated pass reason code to `gate_checks_satisfied` and aligned `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` reason-to-operator mapping
- refreshed office control surfaces for landed Layer 3 correction truth

### Why it mattered
This improves Layer 3 gate explainability and survivor context quality without drifting into shortlist authority or heavy compute behavior.

### Operational effect
- stronger cheap gate reason clarity for Board/Dossier/Current Focus/HUD consumers
- less generic “checks satisfied” drift
- better inspectable candidate posture while preserving Layer 3/shortlist separation


## Ledger ID: CL-073

### Date
2026-03-30

### Change title
Derived summary engine correction for ATR/regime/liquidity/friction/correlation and ATR readiness alignment

### Change class
bounded derived-engine ownership hardening

### Stage / domain
shortlist derived engines + board/dossier derived-consumer gating

### What changed
- corrected `mt5/shortlist_selection/ASC_ATRSummaryEngine.mqh` ATR value/rules to emit lawful day-range-point ATR only when snapshot/day-range/freshness readiness is valid
- strengthened `mt5/shortlist_selection/ASC_RegimeSummaryEngine.mqh` regime/context-quality posture handling for stale/continuity/insufficient-data states
- strengthened `mt5/shortlist_selection/ASC_LiquidityFrictionSummaryEngine.mqh` liquidity/friction handling under continuity and partial derived readiness
- upgraded `mt5/shortlist_selection/ASC_CorrelationSummaryEngine.mqh` with bounded market-watch-assisted peer scoring and aligned shortlist correlation builder consumption in `ASC_ShortlistSelectionEngine.mqh`
- aligned ATR emission gates in `mt5/artifacts/ASC_MarketBoardWriter.mqh` and `mt5/artifacts/ASC_DossierWriter.mqh` to use ATR readiness rather than day-range presence alone

### Why it mattered
This reduces generic placeholder drift and removes weak derived contradictions, especially around ATR readiness and shortlist correlation honesty under mixed evidence quality.

### Operational effect
- ATR now behaves as a lawful bounded derived field with clearer unavailable posture
- regime/liquidity/friction/context outputs are less generic under weak evidence
- shortlist compact correlation support is more grounded when market-watch peers are available
- board/dossier ATR lines no longer emit weak values when ATR readiness is not satisfied


## Ledger ID: CL-072

### Date
2026-03-30

### Change title
Layer 2 market-watch/specification consumer hardening for touched HUD symbol detail paths

### Change class
bounded Layer 2 ownership alignment correction

### Stage / domain
open symbol snapshot consumers + symbol specification owner expansion

### What changed
- expanded `mt5/core/ASC_Types.mqh` + `mt5/symbols/ASC_SymbolSpecification.mqh` specification owner fields to include filling/expiration/order/chart/spread-float modes in the cached owner path
- updated `mt5/hud/ASC_HUD_Manager.mqh` touched specification section reads to consume spec owner fields instead of direct raw SymbolInfo integer pulls
- updated touched HUD market-watch detail cards to rely on admitted Layer 2 market-watch packet truth for quote/spread/day-range timing posture and explicit unavailable behavior
- preserved explicit unavailable wording when Layer 2 truth is absent, avoiding zero-value contamination on touched paths

### Why it mattered
This reduces split ownership drift and raw symbol-query sprawl in touched consumers, while preserving Layer 2 as the shared owner of market-watch and specification/trading-conditions truth.

### Operational effect
- cleaner Layer 2 consumer alignment in touched HUD symbol detail cards
- fewer ad hoc direct symbol-property rebuild paths
- clearer “unavailable” posture when owned Layer 2 truth is not yet present


## Ledger ID: CL-071

### Date
2026-03-30

### Change title
Shortlist admitted-set hardening to Selection Filter survivors only

### Change class
bounded per-layer workload governance correction

### Stage / domain
shortlist selection admission boundary and runtime swiftness discipline

### What changed
- updated `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh` shortlist summary-set admission to include only symbols with `ASC_SELECTION_FILTER_RESULT_PASS`
- removed non-survivor symbols from shortlist scoring/sorting workload in the same pass to enforce reduced-set-only Layer 4 evaluation
- refreshed `office/ROADMAP_STATUS.md` and `office/WORK_LOG.md` to keep control surfaces aligned with the landed admitted-set boundary

### Why it mattered
This closes layer-creep where shortlist processing considered symbols outside lawful Selection Filter survivor scope and restores bounded serial workload behavior.

### Operational effect
- shortlist processing now runs on a tighter admitted symbol set
- less duplicate/wasted shortlist work per cycle
- cleaner Layer 3 -> shortlist handoff boundary


## Ledger ID: CL-070

### Date
2026-03-30

### Change title
Current Focus trigger-only ownership hardening for dispatcher/manifest/HUD alignment

### Change class
bounded runtime ownership correction

### Stage / domain
dispatcher bundle truth, HUD explicit trigger bridge, and publication status alignment

### What changed
- updated `mt5/runtime/ASC_Dispatcher.mqh` to stop treating Current Focus as an ordinary bundle status member in finalize logic and ordinary bundle summary logging
- changed bundle manifest payload in dispatcher to declare Current Focus as explicit Deep Analysis trigger-owned and outside ordinary bundle routing
- removed `mt5/hud/ASC_HUD_Manager.mqh` deep-action writeback into `runtime.publication_bundle.current_focus_status`
- aligned runtime defaults in `mt5/core/ASC_RuntimeState.mqh` and `mt5/runtime/ASC_Bootstrap.mqh` so Current Focus status posture is trigger-owned, not ordinary idle/skip semantics
- updated `office/ROADMAP_STATUS.md` current publication truth block to match landed runtime doctrine

### Why it mattered
This removes half-transition ambiguity and ensures Current Focus cannot be interpreted as a passive ordinary heartbeat publication artifact.

### Operational effect
- ordinary heartbeat bundle truth no longer reports Current Focus as a passive tracked member
- Current Focus publication remains explicit HUD Deep Analysis trigger-owned
- runtime/manifest wording now matches trigger-only ownership doctrine


## Ledger ID: CL-069

### Date
2026-03-30

### Change title
Derived summary engine hardening for ATR, regime, liquidity, friction, correlation, and context quality

### Change class
bounded derived-engine ownership correction

### Stage / domain
shortlist-derived engine owners and direct consumer alignment

### What changed
- hardened `mt5/shortlist_selection/ASC_ATRSummaryEngine.mqh` ATR readiness to avoid stale or insufficient-data leakage
- upgraded `mt5/shortlist_selection/ASC_RegimeSummaryEngine.mqh` and `mt5/shortlist_selection/ASC_LiquidityFrictionSummaryEngine.mqh` to use bounded multi-signal evidence (freshness + day range + spread/ATR posture) instead of weak single-threshold labels
- upgraded `mt5/shortlist_selection/ASC_CorrelationSummaryEngine.mqh` with normalized symbol comparison and FX pair-aware scoring to replace weak prefix-only similarity behavior
- aligned `mt5/artifacts/ASC_MarketBoardWriter.mqh`, `mt5/artifacts/ASC_DossierWriter.mqh`, `mt5/artifacts/ASC_CurrentFocusWriter.mqh`, and touched HUD wording to consume improved derived outputs without placeholder-summary wrappers

### Why it mattered
This reduces generic filler drift and improves inspectable derived truth quality across board/dossier/current-focus/HUD consumers while preserving bounded runtime scope.

### Operational effect
- stronger derived labels for regime/liquidity/friction/context quality
- cleaner ATR readiness posture
- more meaningful compact correlation behavior for shortlist peers
- reduced placeholder-style derived wording on touched consumer surfaces


## Ledger ID: CL-068

### Date
2026-03-30

### Change title
Layer 2 truth hardening for specification/trading-conditions ownership and HUD consumer alignment

### Change class
bounded Layer 2 ownership hardening

### Stage / domain
open symbol snapshot engine + selected-symbol specification consumer path

### What changed
- updated `mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` specification refresh path to use `ASC_GetSymbolSpecification(...)` as the source owner for contract/spec fields instead of ad hoc direct broker field reads in Layer 2
- kept quote cadence and specification cadence separated, with explicit specification refresh-state reasoning
- updated `mt5/hud/ASC_HUD_Manager.mqh` specification section to consume Layer 2/spec-cache values for Layer 2-owned fields (digits/point/trade/execution/contracts/volumes/currencies/stop distance) and reduce raw-query drift
- verified artifact consumers remain Layer 2 consumers and do not rebuild quote/spec truth with direct SymbolInfo pulls

### Why it mattered
This reduces split ownership drift, strengthens Layer 2 as the shared owner of live market-watch + specification/trading-conditions truth, and lowers consumer-side contradictory interpretations.

### Operational effect
- cleaner Layer 2 spec ownership path
- better downstream consistency for selected-symbol specification display
- reduced ad hoc raw-query sprawl on touched consumer paths


## Ledger ID: CL-067

### Date
2026-03-30

### Change title
Main Market Board and Symbol Dossier composition cleanup with Current Focus alignment

### Change class
bounded operator-surface composition cleanup

### Stage / domain
artifact writer composition and shared wording helpers

### What changed
- refined `mt5/artifacts/ASC_MarketBoardWriter.mqh` wording hierarchy for cleaner board scanability while preserving required sections and anti-duplication structure
- refined `mt5/artifacts/ASC_DossierWriter.mqh` composition by removing duplicate low-value lines and compressing deep/automation placeholder verbosity
- aligned `mt5/artifacts/ASC_CurrentFocusWriter.mqh` with cleaner selection/deep-status wording while keeping compact scope
- updated `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` to reduce noisy approximation/placeholder suffix wording and simplify metadata block labels

### Why it mattered
This pass reduces schema-export feel and placeholder clutter on key operator surfaces without changing runtime ownership or hiding unavailable/stale/degraded truth.

### Operational effect
- Market Board is cleaner and more trader-usable at shortlist-summary depth
- Dossier sections are easier to scan with less metadata dominance
- Current Focus wording is cleaner and consistent with dossier style


## Ledger ID: CL-066

### Date
2026-03-30

### Change title
Runtime breathing and Current Focus ownership correction (explicit Deep Analysis trigger only)

### Change class
bounded runtime ownership correction

### Stage / domain
dispatcher publication lane and HUD symbol-action trigger path

### What changed
- removed Current Focus from ordinary heartbeat publication bundle execution in `mt5/runtime/ASC_Dispatcher.mqh`
- removed passive shortlist-head / cached-first-symbol fallback path that previously selected Current Focus during normal bundle writes
- added explicit HUD Deep Analysis action bridge in `mt5/hud/ASC_HUD_Manager.mqh` to publish Current Focus only when the operator triggers Deep Analysis on a selected symbol

### Why it mattered
This closes ownership drift where Current Focus behaved like a normal bundle artifact and could be passively rewritten during ordinary publication passes.

### Operational effect
- Current Focus no longer consumes routine write-lane bundle budget
- normal heartbeat bundle now keeps Current Focus status skipped
- Current Focus refresh now requires explicit selected-symbol Deep Analysis action


## Ledger ID: CL-065

### Date
2026-03-30

### Change title
Final integration-gate coherence cleanup for candidate-filter compatibility and board artifact doctrine

### Change class
bounded runtime/control-surface alignment

### Stage / domain
candidate-filter compatibility path and control-surface doctrine sync

### What changed
- updated compatibility `ASC_SelectionFilterEvaluate(...)` overload to honor lawful live Open Symbol Snapshot corroboration when present, even if legacy callers pass stale availability flags
- marked `office/DECISIONS.md` Decision D-041 as superseded and removed stale subgroup-board publication wording
- updated `blueprint/roadmap/10_STAGE_8_PERSISTENCE_AND_ARTIFACTS.md` to reflect canonical single Market Board artifact doctrine

### Why it mattered
This removes a remaining mismatch where compatibility callers could publish pending posture despite lawful corroboration, and closes a live control-surface contradiction on board artifact count.

### Operational effect
- stronger cross-surface candidate-filter coherence for compatibility callers
- office/roadmap wording now matches active runtime publication behavior


## Ledger ID: CL-064

### Date
2026-03-30

### Change title
Cross-surface dependency cleanup and compile-risk sweep after layered hardening passes

### Change class
bounded runtime alignment and stale-consumer cleanup

### Stage / domain
filter/shortlist consumers, helper mapping alignment, and board-contract wording sync

### What changed
- patched `mt5/hud/ASC_HUD_Manager.mqh` filter evaluations to consume direct Layer 2-backed inputs
- hardened compatibility overload in `mt5/candidate_filtering/ASC_SelectionFilter.mqh` so fallback callers resolve live Layer 2 packet truth before using default initialization
- aligned `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` selection-reason mapping with current reason-code output set
- aligned `mt5/artifacts/ASC_MarketBoardWriter.mqh` Top-10-withheld wording to the active board contract line

### Why it mattered
This removes stale compatibility drift and wording contradiction risk introduced by incremental layered passes, leaving cleaner cross-surface consumer coherence.

### Operational effect
- lower risk of stale filter posture in HUD and shared helpers
- cleaner board-contract wording alignment
- cleaner dependency path from Layer 2/3/4 truth to operator surfaces


## Ledger ID: CL-063

### Date
2026-03-30

### Change title
Shortlist stability and compact correlation/exposure hardening pass

### Change class
bounded Layer 4 selection-authority hardening

### Stage / domain
shortlist selection owner and shortlist-summary compact correlation/exposure helper

### What changed
- hardened `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh` shortlist stability behavior with sustained dirty-challenge pressure tracking before post-hold shortlist replacement
- reinforced hold-expiry discipline so hold expiry alone does not trigger shortlist rebuild
- added deterministic tie-break ordering by symbol for equal shortlist scores
- improved non-selected membership wording in shortlist summary truth
- hardened `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` compact correlation/exposure line so limited-peer conditions remain explicit rather than silently implying full peer support

### Why it mattered
This reduces unnecessary shortlist churn, strengthens posture inspectability, and keeps shortlist-summary correlation/exposure output compact but honest under limited peer support.

### Operational effect
- shortlist authority remains in Layer 4 with calmer replacement behavior
- shortlist ordering is more stable/deterministic
- compact correlation/exposure output is more resilient and inspectable


## Ledger ID: CL-062

### Date
2026-03-30

### Change title
Candidate Filtering completion and reason-strengthening hardening pass

### Change class
bounded runtime gate-owner hardening

### Stage / domain
Layer 3 candidate-filter owner, shortlist consumer alignment, and selection-surface consumption

### What changed
- strengthened `mt5/candidate_filtering/ASC_SelectionFilter.mqh` with richer cheap gate logic that consumes committed market-watch/specification truth from Layer 2
- expanded bounded reason outputs (`reason_code`, `reason_summary`, `disqualifiers`, `dependencies_text`, `next_required_step`) for clearer pass/fail/pending/blocked/degraded/stale meaning
- preserved Layer 3/Layer 4 separation while improving shortlist input quality through updated cheap scoring factors in `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh`
- aligned dossier/current-focus selection sections to consume the stronger Layer 3 reason context

### Why it mattered
This closes thin-reason and weak-gating drift so downstream shortlist and operator surfaces no longer need to guess why a symbol passed, failed, or is pending.

### Operational effect
- Candidate Filtering is more explainable and actionable while remaining cheap
- shortlist input truth is stronger without authority drift into Layer 3
- selection context in dossier/current-focus is materially clearer


## Ledger ID: CL-061

### Date
2026-03-29

### Change title
Layer 2 ownership expansion for market-watch and specification/trading-conditions truth

### Change class
bounded runtime ownership hardening

### Stage / domain
Open Symbol Snapshot engine/writer and downstream dossier/current-focus consumers

### What changed
- extended `mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` packet schema with specification/trading-condition fields, validity flags, spec freshness posture, spec due cadence, and spec state reason
- added slower specification refresh cadence (`ASC_L2_SPEC_RECHECK_SEC`) and staleness/degraded thresholds separate from quote cadence
- expanded changed-field and material-change detection so Layer 2 revisions now include specification deltas
- updated `mt5/artifacts/ASC_OpenSymbolSnapshotWriter.mqh` to publish specification freshness and due counts
- removed direct `SymbolInfo*` specification reads from `mt5/artifacts/ASC_DossierWriter.mqh` and switched Trading Conditions output to Layer 2-owned fields
- aligned `mt5/artifacts/ASC_CurrentFocusWriter.mqh` to consume compact Layer 2 specification truth

### Why it mattered
This closes split ownership drift where consumer writers were still rebuilding trading-condition truth directly instead of consuming the Layer 2 owner.

### Operational effect
- Layer 2 now provides one shared truth path for both live market-watch and slower specification/trading-condition data
- fast quote cadence and slower spec cadence are separated
- dossier/current-focus outputs consume owned Layer 2 truth and reduce raw symbol-query sprawl


## Ledger ID: CL-060

### Date
2026-03-29

### Change title
Single-board publication cleanup and dossier/current-focus composition refinement

### Change class
bounded MT5 publication-surface correction

### Stage / domain
Market Board writer, Dossier writer, Current Focus writer, artifact constants, and owner truth synchronization

### What changed
- removed subgroup Market Board companion artifact publication from `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- removed subgroup board constant from `mt5/core/ASC_Constants.mqh`
- cleaned Market Board visible wording (section framing, row labels, deep-analysis posture line, and withheld Top Ten phrasing) while preserving required sections and anti-duplication behavior
- improved Symbol Dossier operator wording (live market labels, selection/trade wording, automation section phrasing) without removing required section family
- improved Current Focus wording to remove raw export-key style labels and align with dossier readability
- synchronized board/persistence contract wording and office status to match active runtime single-board publication truth

### Why it mattered
This removes subgroup-board publication drift, improves trader usability of the main board and dossiers, and keeps control surfaces aligned with active runtime behavior.

### Operational effect
- only one Market Board artifact is published in the active runtime path
- main board is cleaner and easier to scan without hiding uncertainty
- dossier and current-focus outputs are less schema-dump-like while preserving truth visibility and required sections


## Ledger ID: CL-059

### Date
2026-03-29

### Change title
Compile-safe Market Board repair and write-lane essential-cursor hardening

### Change class
bounded MT5 compile/runtime correction

### Stage / domain
Stage 1 publication/runtime stabilization

### What changed
- repaired broken multiline string literals in `mt5/artifacts/ASC_MarketBoardWriter.mqh` that were breaking MT5 parsing and cascading into false undeclared identifiers
- normalized subgroup rendering so empty `sub_bucket_id` rows land under explicit `unassigned` coverage on the subgroup board instead of being skipped
- hardened `mt5/runtime/ASC_Dispatcher.mqh` so Market Board and Current Focus complete before dossier cursor advancement when write budget is constrained
- tightened Dossier and Current Focus selection labels/buckets so non-shortlisted symbols no longer default to misleading `Candidate` wording and bucket output keeps main/subgroup truth
- refreshed owner surfaces to reflect this bounded direct-fix pass

### Why it mattered
This closes the active compile break, removes a low-budget persistence edge case that could strand Current Focus behind dossier writes, and keeps subgroup/selection truth aligned with the live Layer 4 publication contract.

### Operational effect
- Market Board writer is materially more compile-safe
- subgroup board coverage is more truthful for unassigned rows
- essentials-first publication resumes correctly across beats
- Dossier and Current Focus selection fields are more operator-truthful


## Ledger ID: CL-058

### Date
2026-03-29

### Change title
Full-universe dossier publication hardening and Layer 4 artifact-truth correction

### Change class
bounded MT5 runtime correction + owner-file synchronization

### Stage / domain
write-lane throughput, Market Board/Current Focus/Dossier writers, and owner truth surfaces

### What changed
- raised default write budget and replaced tiny dossier-per-beat throttling with backlog-aware batch sizing
- added separate `Market Board - Subgroups.txt` companion publication and fixed board top-10 gating/compact correlation grammar
- updated Current Focus and Dossier fields to publish active Layer 4 shortlist state, rank, bucket, numeric correlation peers, and open/pending conflict truth
- synchronized blueprint/office owner files to active Layer 4 runtime reality while preserving Layer 5 command-only wording

### Why it mattered
This closes the runtime gap that left dossier coverage artificially tiny and artifacts still lagging the active shortlist authority already present in code.

### Operational effect
- dossier flush is no longer trapped in tiny partial subsets under normal write-lane operation
- board/current-focus/dossier now publish contract-level Layer 4 truth more accurately
- Layer 5 remains non-automatic and command-only


## Ledger ID: CL-057

### Date
2026-03-29

### Change title
MT5 runtime hard-correction: responsibility-based folder/file migration and bounded artifact/HUD fixes

### Change class
runtime structure correction + bounded correctness hardening

### Stage / domain
MT5 runtime module topology, artifact publication wording/validity, and HUD usability lane

### What changed
- renamed active runtime folders from numbered layer naming to responsibility naming (`market_state`, `open_symbol_snapshot`, `candidate_filtering`, `shortlist_selection`, `deep_selective_analysis`)
- renamed forbidden runtime files `ASC_Layer1MarketState.mqh` and `ASC_Layer2OpenSymbolSnapshot.mqh` and migrated include references
- updated Market Board/Current Focus/Dossier rendering for stricter missingness truth on spread-percent fields and scaffold-posture wording
- fixed dossier token-validation drift in atomic writer path
- applied light HUD fixes: header height/clock layout, symbol-row action button width, pager/footer spacing
- synchronized office records with `D-043` and `WL-061`

### Why it mattered
This pass removes remaining runtime naming drift and prevents misleading zero-value display behavior while preserving maturity truth boundaries.

### Operational effect
- runtime no longer contains forbidden numbered layer folders/files
- artifact outputs are more truthful when market packet fields are unavailable
- HUD readability/usability blockers are reduced without redesign scope


## Ledger ID: CL-056

### Date
2026-03-29

### Change title
Runtime-first hardening: top-per-bucket board correction + light HUD usability fixes

### Change class
bounded runtime hardening + minimal canon/office synchronization

### Stage / domain
MT5 artifact publication and HUD usability correction lane

### What changed
- updated `mt5/artifacts/ASC_MarketBoardWriter.mqh` to enforce top-per-bucket Leading Three/Full Five semantics and subgroup board artifact output
- updated `mt5/hud/ASC_HUD_Manager.mqh` for header clock spacing, symbol-row action button width, and pager/footer overlap corrections
- added small anti-duplication rendering clarification in `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
- recorded this pass in office control surfaces (`D-041`, `WL-060`)

### Why it mattered
This removes remaining runtime drift and usability blockers without widening scope beyond canon-correct behavior.

### Operational effect
- board output is closer to canonical top-per-bucket behavior
- HUD interaction/readability issues in this lane are reduced


## Ledger ID: CL-055

### Date
2026-03-29

### Change title
Consolidation anti-drift corrections for board rendering and office supersession clarity

### Change class
bounded consolidation hardening (post-pass verification correction)

### Stage / domain
blueprint-office-runtime coherence lane

### What changed
- updated `mt5/artifacts/ASC_MarketBoardWriter.mqh` to avoid duplicate 1-3 card repetition while preserving Leading Three grammar and Full Five canonical ranking semantics
- added `D-040` in `office/DECISIONS.md` for explicit consolidation decision and anti-duplication rendering clarification
- added supersession clarification in `office/ROADMAP_STATUS.md` and recorded this verification pass in `office/WORK_LOG.md` as `WL-059`

### Why it mattered
These were the smallest remaining drift points after the prior three passes and could cause future workers to reintroduce duplicate board rows or misread historical office wording.

### Operational effect
- board rendering now matches canonical anti-duplication intent
- office records now clearly separate historical scaffold context from active doctrine for this lane


## Ledger ID: CL-054

### Date
2026-03-29

### Change title
Office synchronization to hardened board/current-focus/dossier canon and atomic publication doctrine

### Change class
office/control synchronization pass (doctrine alignment + anti-drift hardening)

### Stage / domain
office control surfaces aligned to blueprint final authority

### What changed
- updated `office/ROADMAP_STATUS.md` to reflect 2026-03-29 office synchronization pass marker, implementation-readiness posture, and anti-drift reminders for board/current-focus/dossier module lanes
- added `D-039` in `office/DECISIONS.md` to lock eight explicit doctrine decisions (board scope, Leading Three/Full Five relationship, fixed board grammar, numeric correlation law, Current Focus live-duplicate rule, dossier persistence ownership, summary-vs-deep module split, atomic writer discipline)
- added `WL-058` in `office/WORK_LOG.md` documenting what changed, why it changed, drift closed, and what remains implementation-only
- synchronized office references to hardened blueprint files:
  - `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
  - `blueprint/final/03_ASC_FIVE_LAYER_SYSTEM.md`
  - `blueprint/final/ASC_SCOPE_BOUNDARY_AND_ADMISSIBILITY_MAP.md`
  - `blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`
  - `blueprint/final/ASC_WRITE_TRIGGER_AND_PUBLICATION_MATRIX.md`
  - `blueprint/final/10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md`

### Why it mattered
Without explicit office synchronization, future passes can regress into duplicated Top 3/Top 5 rendering, vague board correlation output, compact-only Current Focus interpretation, blurred shortlist/deep ownership, and writer-engine boundary drift.

### Operational effect
- office truth now matches hardened blueprint doctrine for this lane
- module-implementation planning can proceed with clearer constraints
- no runtime completion claim was introduced


## Ledger ID: CL-053

### Date
2026-03-28

### Change title
Task 11 Layer 1-3 finalization polish for Selection Filter operator consistency

### Change class
bounded finalization pass (integration polish + wording drift kill)

### Stage / domain
Layer 1-3 finalization, touched selection-filter surfaces

### What changed
- upgraded Selection Filter state output to operator-safe title-case values
- aligned HUD/Dossier/Current Focus Selection Filter surfaces to same owner fields with compact disqualifier visibility in Current Focus
- normalized Market Board aggregate wording to `baseline scope` while preserving one counting method
- kept Layer 4-7 behavior untouched and scaffold-only

### Why it mattered
This closes remaining touched-scope wording drift and makes final Selection Filter reporting more coherent across all active Layer 1-3 consumer surfaces.

### Operational effect
- cleaner operator-facing Selection Filter wording
- unchanged cheap owner behavior and accounting method
- improved cross-surface consistency for final Layer 1-3 handoff posture


## Ledger ID: CL-052

### Date
2026-03-28

### Change title
Task 10 Selection Filter owner landing with shared evaluation and unified board accounting

### Change class
bounded runtime/surface implementation pass (real Layer 3 ownership)

### Stage / domain
Selection Filter owner implementation across HUD + artifacts

### What changed
- introduced shared Selection Filter owner module with explicit result state/reason/disqualifier/dependency/corroboration/next-step outputs
- switched HUD, Dossier, and Current Focus Selection Filter surfaces to shared owner evaluation instead of duplicated inline logic
- switched Market Board Selection Filter counts to shared summary accounting to prevent drift or overlapping count methods
- preserved non-implementation boundaries for Shortlist Context and Deep Analysis

### Why it mattered
This pass makes Selection Filter a real owner and removes cross-surface drift risk from duplicated logic paths.

### Operational effect
- one consistent Selection Filter posture across operator surfaces
- board counts now come from one accounting method
- corroboration dependency now truthfully holds symbols in pending state until packet support exists


## Ledger ID: CL-051

### Date
2026-03-28

### Change title
Task 9 symbol architecture lock: global browse vs symbol-local navigation separation

### Change class
bounded HUD architecture cleanup (navigation separation + naming normalization)

### Stage / domain
Task 9 HUD symbol-surface usability cleanup

### What changed
- constrained global browse navigation to market-structure pages only (Overview, Main Buckets, Sub-Groups, Symbols)
- preserved persistent symbol-local section navigation for selected-symbol context and direct sibling switching
- preserved persistent top symbol action row across symbol-local pages
- normalized touched HUD section enum naming from layer-shorthand constants to meaning-based constants

### Why it mattered
This pass removes navigation-role mixing and hardens the shared symbol information architecture without widening deeper-feature implementation.

### Operational effect
- cleaner operator flow between market browse and symbol context
- lower touched-scope naming drift
- unchanged ownership boundaries and scaffold-only status for non-active sections


## Ledger ID: CL-050

### Date
2026-03-28

### Change title
Task 8 final integration cleanup: operator wording and de-dup in touched symbol surfaces

### Change class
bounded integration cleanup (drift kill / wording alignment)

### Stage / domain
Task 8 final symbol-surface integration pass

### What changed
- introduced shared artifact helper mappings for trade/execution mode text
- removed raw numeric mode dumps from specification surfaces in favor of operator-safe wording
- normalized policy-group wording to availability posture where broker-defined values are not stable operator labels
- preserved existing scaffold/status framework and did not widen deeper-layer implementation

### Why it mattered
Final integration pass required killing remaining drift and dev-language leakage in touched scope while retaining shared spine alignment.

### Operational effect
- cleaner operator-facing specification outputs
- lower cross-surface wording drift
- unchanged layer activation boundaries


## Ledger ID: CL-049

### Date
2026-03-28

### Change title
Task 7 Layer 4-7 scaffold completion + Layer 5 status/progress framework

### Change class
bounded implementation pass (scaffold completion + live status framework)

### Stage / domain
Task 7 scaffold completion

### What changed
- implemented meaningful Layer 5 status/progress framework in HUD scaffold page (state, reason, groups, retries, write posture, landed posture)
- expanded Dossier and Current Focus Layer 4-7 sections with explicit scaffold readiness and framework lines
- added compact Layer 5 status/progress counts to Market Board hooks
- kept Layer 4-7 payload outputs non-fake and non-final by contract

### Why it mattered
Task 7 required Layer 5 to stop being a dead placeholder and become live-update ready while maintaining truthful non-activation of deeper layers.

### Operational effect
- Layer 5 operator visibility is now framework-complete
- Layer 4/6/7 remain structurally complete and explicitly non-active
- summary surfaces can communicate progress posture without fabricated deep results


## Ledger ID: CL-048

### Date
2026-03-28

### Change title
Task 6 Layer 3 selection filter page + aligned artifact surfaces

### Change class
bounded implementation pass (Layer 3 decision posture)

### Stage / domain
Task 6 Layer 3 implementation

### What changed
- replaced Layer 3 scaffold-only messaging in HUD with real pass/fail/pending decision posture and dependency-based reasoning
- expanded Dossier and Current Focus Layer 3 sections to aligned decision-state, reason/disqualifier, dependency, corroboration, and next-step fields
- added compact Layer 3 pass/pending/fail counts to Market Board symbol hooks
- preserved strict non-drift boundaries: no Layer 4 shortlist logic and no Layer 5 deep-analysis payloads

### Why it mattered
Task 6 required Layer 3 to become the highest real decision layer in current scope with clear operator-facing filter posture.

### Operational effect
- Layer 3 is now clearly distinct from Overview/Market Watch/Specification
- cross-surface decision ownership is aligned
- summary surfaces carry compact truthful Layer 3 posture where lawful


## Ledger ID: CL-047

### Date
2026-03-28

### Change title
Task 5 Specification / Contract page implementation (HUD + Dossier + Current Focus)

### Change class
bounded implementation pass (broker/spec/session group surfaces)

### Stage / domain
Task 5 specification surface implementation

### What changed
- added grouped specification cards in HUD for precision, permissions, volume, swap/margin, and sessions
- expanded Dossier specification section with richer grouped broker fields and execution/order/calc/session posture
- aligned Current Focus specification section to a trimmed broker-rule subset
- retained truthful missingness for unavailable/non-applicable broker fields

### Why it mattered
Task 5 requires a true symbol contract page so operators can inspect trade/spec/session rules without mixing live quote payload.

### Operational effect
- spec data is now clearly separated from Market Watch
- cross-surface ownership remains aligned with density split
- unsupported fields are explicit rather than fabricated


## Ledger ID: CL-046

### Date
2026-03-28

### Change title
Task 4 Market Watch / Live Quote real Layer 2 surface pass

### Change class
bounded implementation pass (live packet page depth + dynamic field suppression)

### Stage / domain
Task 4 market-watch implementation

### What changed
- rebuilt HUD Market Watch section cards around live quote, spread/freshness, day posture, and intraday range posture groupings
- enriched Dossier Market Watch with spread percent, daily change, open/close, and bid/ask range fields when available
- aligned Current Focus Market Watch to a trimmed subset of the same ownership fields
- preserved truthful missingness (`awaiting open-symbol snapshot`, `unavailable`) for absent/unsupported fields

### Why it mattered
Task 4 required a real Layer 2 page that is operator-useful and clearly distinct from Overview.

### Operational effect
- live quote packet information is now easier to scan in symbol context
- cross-surface ownership remains aligned while respecting density differences
- no fake or unsupported field claims were introduced


## Ledger ID: CL-045

### Date
2026-03-28

### Change title
Task 3 Symbol Overview rebuild across HUD, Dossier, and Current Focus

### Change class
bounded page-role rebuild (short-page compression + cross-surface alignment)

### Stage / domain
Task 3 overview alignment pass

### What changed
- compressed HUD Symbol Overview into short operator-summary composition and removed extra wide repetitive overview card layout
- tightened Dossier Overview lines to compact identity and one tradeability posture line instead of scattered repeated identity/detail fields
- tightened Current Focus Overview with explicit tradeability posture and concise routing guidance
- preserved shared semantics across all three surfaces while keeping density tiers (HUD shortest, Current Focus compact, Dossier fuller)

### Why it mattered
Task 3 required Overview to answer only "what matters right now" and stop duplicating deeper page payloads.

### Operational effect
- faster operator scanning in symbol context
- lower cross-page duplication pressure
- clearer handoff from Overview into Market Watch/Specification pages


## Ledger ID: CL-044

### Date
2026-03-28

### Change title
Task 2 shared scaffold implementation across HUD, Dossier, Current Focus, and Market Board

### Change class
bounded implementation alignment (shared section shells + placeholder law enforcement)

### Stage / domain
Task 2 shared scaffold implementation

### What changed
- rebuilt HUD symbol section-detail cards into role-specific section shells with dynamic missingness and explicit scaffold messaging
- aligned Dossier and Current Focus to strict eight-section sequence with no extra duplicate packet-detail pseudo-sections
- kept real detail in active sections through Layer 3 posture only; Layer 4-7 remain scaffold homes
- updated Market Board symbol-section hooks to include Layer 3 candidate baseline context and stable Layer 4-7 placeholders

### Why it mattered
Task 2 required implementation-level structural alignment after Task 1 architecture lock so all symbol surfaces now share one scaffold spine without fake later-layer depth.

### Operational effect
- HUD, Dossier, Current Focus, and Board now expose the same section-family skeleton
- navigation and section homes remain stable while preserving truthful missingness
- future Layer 4-7 expansion can proceed without changing section topology


## Ledger ID: CL-043

### Date
2026-03-28

### Change title
Task 1 closure hardening: symbol spine checklist + HUD section-title naming sync

### Change class
architecture/specification hardening + minimal HUD naming alignment

### Stage / domain
Task 1 closure pass (symbol information architecture lock)

### What changed
- expanded `ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md` with explicit bounded implementation-alignment notes
- added mini debug session checklist to make closure validation executable and auditable
- adjusted HUD selected-symbol section title text to use `Overview` for the first section in-line with persistent section-row button naming

### Why it mattered
Task 1 required a no-drift architecture lock where downstream implementation can follow one unambiguous symbol information spine without section-name mismatch.

### Operational effect
- section-family contract is clearer and easier to validate before future implementation widening
- selected-symbol navigation wording is consistent across row button and section title surfaces
- no new runtime layer behavior was introduced


## Ledger ID: CL-042

### Date
2026-03-28

### Change title
Task 1 symbol information spine lock across blueprint, office, and artifact scaffolds

### Change class
architecture/specification lock + bounded code alignment

### Stage / domain
HUD + Dossier + Current Focus + Board information architecture

### What changed
- introduced `ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md` with exact section-family law and per-surface mapping
- bound existing HUD and board/dossier/current-focus contracts to the new spine contract
- aligned dossier/current-focus/board scaffold section headings to the locked section families and scaffold wording
- updated front-door indexes to include the new symbol information spine contract

### Why it mattered
This establishes one explicit symbol information architecture and prevents future drift in where symbol identity, watch data, specification, and layer-scaffold homes are shown.

### Evidence / references
- `Aurora Sentinel Core/blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`
- `Aurora Sentinel Core/blueprint/final/ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md`
- `Aurora Sentinel Core/blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `Aurora Sentinel Core/README.md`
- `Aurora Sentinel Core/MASTER_INDEX.md`

### Operational effect
Future symbol-page implementation can proceed against one stable section contract without re-arguing placement semantics per surface.

## Ledger ID: CL-041

### Date
2026-03-28

### Change title
HUD sample-style visual pass: soft corners, layered outlines, and persistent header clock cadence

### Change class
mt5 HUD visual styling hardening

### Stage / domain
Stage 2 HUD active surface

### What changed
- introduced `ASC_HudApplySoftCorners(...)` and applied it to primary shell/cards/list panels for rounded-edge visual treatment
- tuned border base/edge palette for stronger premium outline separation
- ensured server clock header label updates on tactical cadence for all pages

### Why it mattered
This aligns the in-terminal HUD closer to the requested premium sample (outline depth + rounded feel) while respecting MT5 control limitations and preserving runtime speed doctrine.

### Evidence / references
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`

### Operational effect
Operator surface appears cleaner and more modern with no change to scan/write lane behavior or layer ownership.

## Ledger ID: CL-040

### Date
2026-03-28

### Change title
HUD hardening: compile-error fix set + sub-group naming and navigation clarity cleanup

### Change class
mt5 HUD bug fix + operator-surface wording/layout cleanup

### Stage / domain
Stage 2 HUD active surface

### What changed
- removed undeclared density-mode references and density-label call paths from HUD row/pager logic
- fixed duplicate variable declaration and undefined pager height variable in `ASC_HudRenderRows`
- updated top-nav/breadcrumb wording (removed arrow style) and shortened aspects button label to prevent truncation
- introduced always-visible header server clock panel
- normalized sub-group display naming to avoid repeated main-bucket wording in list rows and symbol list section naming
- removed redundant “No open symbols” row-meta emission and cleared latent stray meta label rendering

### Why it mattered
The prior state failed compile and produced visible operator drift (stray labels, repeated wording, truncation, and awkward nav hints), reducing control-surface clarity and violating HUD polish expectations.

### Evidence / references
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`

### Operational effect
HUD can render with cleaner list hierarchy language, stable header clock visibility, and repaired row/pager internals without introducing Layer 3–5 behavior.

## Ledger ID: CL-039

### Date
2026-03-28

### Change title
Layer 1/2 fairness hardening: tactical-symbol fix, essentials-write completion guard, and Layer 2 materiality de-churn

### Change class
runtime bug fix + scheduling fairness hardening

### Stage / domain
Layer 1 + Layer 2 active runtime surfaces

### What changed
- fixed dispatcher tactical symbol selector to use first admitted Layer 2 packet when available
- fixed write-lane essentials completion to avoid clearing essential publish pending before both Market Board and Current Focus writes are actually completed
- replaced Layer 2 always-changing packet-age/quote equality materiality checks with significant-shift thresholds to reduce non-material write pressure

### Why it mattered
These issues caused hidden drift against blueprint publication calmness and scan-vs-write fairness doctrine: tactical reads could miss admitted truth, essentials could be considered complete too early, and Layer 2 could trigger write churn from non-material micro-motions.

### Evidence / references
- `Aurora Sentinel Core/mt5/runtime/ASC_Dispatcher.mqh`
- `Aurora Sentinel Core/mt5/layer2/ASC_Layer2OpenSymbolSnapshot.mqh`

### Operational effect
Runtime should preserve broader scan visibility under write pressure and keep Layer 2 publication behavior materially bounded without widening beyond open-subset scope.

## Ledger ID: CL-038

### Date
2026-03-27

### Change title
HUD post-redesign bug-kill and consistency hardening pass

### Change class
mt5 HUD paging/responsive/button consistency QA hardening

### Stage / domain
Stage 2 active surface (bounded final QA polish pass)

### What changed
- made top-nav button placement width-aware so narrow layouts hide overflow controls instead of rendering clipped chrome
- rebalanced breadcrumb title/path/hint widths to prevent overlap and broken page identity text on smaller viewports
- hardened quick-action strip geometry with constrained-width fallback (Deep Analysis only) to avoid detached or out-of-bounds button rows
- tightened list-row button/text geometry for compact density to reduce clipping and vertical misalignment artifacts
- switched list section identity lines and pager text to canonical computed paging state and explicit no-rows wording

### Why it mattered
Final HUD acceptance required a cleanup pass that kills visible fit/paging/control drift across major operator flows after redesign completion.

### Operational effect
Major page families now present more stable paging identity, cleaner responsive fit, and tighter action/button consistency without widening scope into new features.

## Ledger ID: CL-037

### Date
2026-03-27

### Change title
Aspect Detail premium deep-page rebalance (guide rail shrink + selector polish + richer card depth)

### Change class
mt5 HUD Aspect Detail visual/layout redesign within canonical product contract

### Stage / domain
Stage 2 active surface (bounded Aspect Detail redesign pass)

### What changed
- shrank/repositioned the Aspect Detail guide surface into a compact right-side Operator Rail and removed weak filler wording
- rebuilt Aspect Detail selector band presentation with explicit canonical-order context and tighter premium button geometry
- rebalanced hero/selector/content spacing and card heights with density-aware values for compact/normal display behavior
- deepened category card compositions into stronger primary/secondary evidence blocks to reduce empty scaffold feel
- cleaned Aspect Detail quick action strip copy density so symbol+aspect context is clear without occupying extra visual overhead

### Why it mattered
Aspect Detail had become scaffold-heavy and visually underpowered relative to deep-page intent. This pass increases evidence-first focus and improves operator readability while preserving canonical ownership and ordering law.

### Operational effect
Operators now get a cleaner, richer, and denser Aspect Detail page with clearer active-aspect context, better use of horizontal/vertical space, and safer compact-mode behavior.


## Ledger ID: CL-036

### Date
2026-03-27

### Change title
One-shot trader control surface pass: MT5 inputs + control registry + layer-aligned wiring

### Change class
mt5 control-surface architecture + runtime wiring + office/version continuity

### Stage / domain
Stage 2 active surface (bounded trader control pass)

### What changed
- added canonical control registry file with Class A/B/C assignment and system-owned exclusion list
- rebuilt EA Inputs into trader-meaningful groups including Layer 5 per-timeframe bars (`0 = off`)
- added shared trader-control registry module for normalized runtime control values
- wired control values into bootstrap, dispatcher, Layer 1 cadence/thresholds, HUD behavior, and artifact writers
- added dynamic board top-N and dossier/current-focus section controls
- enforced deep-action guard when all Layer 5 timeframes are disabled
- updated version label/date and office decision/worklog records

### Why it mattered
The MT5 menu needed to become a trader-useful control surface with strict separation between controllable behavior and observed runtime truth.

### Operational effect
Traders can now tune HUD richness, board/dossier visibility, Layer 1 cadence posture, and Layer 5 timeframe/bar structure without exposing system-owned runtime state as input.


## Ledger ID: CL-035

### Date
2026-03-27

### Change title
Office control truth repair: monotonic ID cleanup + MT5 reality wording alignment

### Change class
office governance hygiene + control-surface wording hardening

### Stage / domain
Office-only control pass

### What changed
- enforced strict monotonic unique `WL-*` IDs across `office/WORK_LOG.md`
- enforced strict monotonic unique `CL-*` IDs across `office/CHANGE_LEDGER.md`
- corrected stale office references to the active MT5 entrypoint (`AuroraSentinelCore.mq5`)
- updated office status language to report active MT5 runtime authority while preserving office/non-office ownership boundaries for canonical wording repairs
- added decision D-027 to anchor office reporting posture for cross-surface contradiction handling

### Why it mattered
Duplicate/non-monotonic ledger IDs and stale filename references reduce operational trust and make continuity auditing brittle. This pass restores deterministic office traceability.

### Operational effect
Office IDs are now collision-free and ordered, active MT5 runtime truth is explicit, and office contradiction reporting is ownership-safe (reporting, not silent architecture redesign).


## Ledger ID: CL-034

### Date
2026-03-27

### Change title
Task 10 final HUD QA/compliance/performance hardening pass

### Change class
mt5 HUD overflow hardening + action-surface compliance tightening + final regression pack manifest

### Stage / domain
Stage 2 active surface (bounded Task 10 closure pass)

### What changed
- converted HUD card text rendering to width-clamped labels to reduce clipping/overflow across overview/list/symbol/aspect cards
- tightened Deep Analysis action behavior so enablement is evaluated against selected-symbol context and fail-closed blocked-reason wording
- preserved symbol action matrix posture: Deep Analysis only advanced action path, Aurora/Semi/Full remain explicit reserved non-active placeholders
- kept tactical refresh confined to lawful tactical regions and avoided any tactical-driven structural rebuild paths
- added final HUD regression pack manifest with required benchmark page-state set and explicit screenshot-capture limitation note for this environment

### Why it mattered
Final HUD acceptance required one end-to-end cleanup pass that improves visual fit and compliance without reopening architecture or degrading responsiveness.

### Operational effect
HUD surfaces are more robust under tight widths, action-strip behavior is contract-cleaner, and regression benchmark requirements are now documented as an explicit control artifact.


## Ledger ID: CL-033

### Date
2026-03-27

### Change title
Symbol Aspect Detail canonical category realignment + density rebuild

### Change class
mt5 HUD Aspect Detail architecture alignment + readability/density hardening

### Stage / domain
Stage 2 active surface (bounded Aspect Detail architecture pass)

### What changed
- aligned runtime Aspect Detail category model to the canonical six-category blueprint contract
- rebuilt aspect selector surfaces (Symbol Overview and Aspect Detail) into two-row canonical category controls to prevent clipping and preserve hierarchy
- reduced guide rail width and language density so the help lane no longer crowds core evidence space
- redesigned aspect section cards by category to enforce one clear section job and deeper evidence framing than Symbol Overview
- removed symbol-page leakage of universe aggregate posture from detail cards; retained symbol-scoped publication/continuity wording
- preserved tactical redraw law by limiting Aspect Detail tactical cadence refresh to Market Action mini-strip content

### Why it mattered
The implementation had drifted from the canonical aspect architecture and the compact guide lane was consuming useful evidence space. This pass restores contract alignment and improves operator evidence density.

### Operational effect
Operators now navigate lawful canonical aspect categories with cleaner language, stronger section intent, and denser symbol-scoped evidence surfaces.


## Ledger ID: CL-032

### Date
2026-03-27

### Change title
HUD structural contract alignment: hierarchy/page-family/control-zone normalization

### Change class
mt5 HUD architecture alignment + hierarchy truth hardening + control-zone normalization

### Stage / domain
Stage 2 active surface (bounded HUD structural alignment pass)

### What changed
- normalized runtime HUD page identities and names to canonical family wording (Overview, Main Buckets, Sub-Groups, Symbols, Symbol Overview, Aspect Detail)
- replaced mixed-purpose top navigation with explicit zone separation: top nav zone, breadcrumb/title zone, quick actions zone
- moved symbol action controls into the quick actions zone on symbol pages only, preserving symbol-scoped action-surface law
- removed open-only survivor filtering from hierarchy lists so structural pages reflect lawful member sets instead of filtered subsets
- hardened breadcrumb lineage to include selected hierarchy context (bucket, sub-group, symbol) and align page-role semantics
- normalized remaining mixed Main Group wording toward Main Bucket terminology in HUD surface text

### Why it mattered
Earlier HUD behavior mixed zone roles and allowed structural list filtering drift, which weakens contract alignment for downstream HUD work. This pass restores a lawful foundation before cosmetic/detail expansion.

### Operational effect
Operators now navigate a cleaner, blueprint-aligned structure where hierarchy pages reflect structural truth and controls stay in stable, predictable zones.


## Ledger ID: CL-031

### Date
2026-03-26

### Change title
HUD realization + performance/state hardening on active runtime truth

### Change class
mt5 HUD consumer implementation + render/input hardening + office/version/continuation hygiene

### Stage / domain
Stage 2 active surface (bounded HUD realization pass; Stage 9 full completion still gated)

### What changed
- added active HUD module at `mt5/hud/ASC_HUD_Manager.mqh` with retained-object UI lifecycle and page-local state
- landed complete early-operational page hierarchy (Overview, Main Groups, Sub-Groups, Symbols, Symbol Overview, Menu/Settings)
- wired immediate chart-event navigation and row actions (bucket -> subgroup -> symbol -> detail)
- consumed runtime Layer 1 summary/cache truth directly for counts, hierarchy, and unresolved/partial posture visibility
- added selected-symbol tactical strip using selected-symbol-only direct tick reads and freshness labeling
- integrated HUD lifecycle with EA init/timer/deinit/event flow
- synchronized version label and office/continuation surfaces

### Why it mattered
The runtime had truthful artifacts but no real in-chart operator HUD. This pass lands a real consumer surface now while preserving strict ownership and read-only law.

### Operational effect
Operators now have a fast, truthful, usable HUD with immediate navigation and explicit freshness/degraded posture instead of shell behavior.


## Ledger ID: CL-030

### Date
2026-03-26

### Change title
Layer 1 speed restoration + early partial publication + scaffold completion hardening

### Change class
mt5 runtime admission hardening + Layer 1 summary posture hardening + artifact scaffold completion + office/version/continuation sync

### Stage / domain
Stage 2 active surface (bounded speed/output restoration pass)

### What changed
- increased runtime throughput constants (`heartbeat`, `scan_budget`, `write_budget`) for fast broad scans with bounded writes
- replaced full-cycle-only write eligibility with meaningful partial-write eligibility during ongoing scans
- adjusted dispatcher lane choice to prioritize scan backlog while enforcing timely publication beats
- updated Layer 1 summary model to publish `assessed_symbols`, `remaining_symbols`, and `partial` posture continuously
- completed Market Board scaffold with early-pass posture and canonical top-bucket placeholder rows always visible
- kept dossier scaffolds durable and prevented early-pass writes for unassessed symbols
- synchronized version label and office/continuation truth surfaces

### Why it mattered
The runtime had drifted into slow, visibility-starved behavior. This pass restores speed and visible artifacts without breaking bounded coordination.

### Operational effect
Operators receive early and incremental board/focus/dossier outputs while Layer 1 continues sweeping rapidly under one heartbeat authority.

---

## Ledger ID: CL-029

### Date
2026-03-26

### Change title
Output scaffold completion for Market Board/Symbol Dossier + write-lane log spam reduction

### Change class
mt5 artifact scaffold hardening + dispatcher logging posture hardening + office/version/continuation hygiene

### Stage / domain
Stage 2 active surface (bounded implementation hardening)

### What changed
- strengthened Market Board into durable truthful sections including publication/freshness posture and current-focus reference
- strengthened Symbol Dossier into a durable future-layer scaffold with explicit placeholder homes and publication/continuity posture
- kept Current Focus bounded but structurally aligned with publication wording
- replaced per-symbol routine dossier success logging with one dispatcher dossier-batch summary per write beat
- preserved detailed symbol/path failure logging for dossier write failures
- updated version label and office/continuation control surfaces to reflect new runtime output/logging ownership

### Why it mattered
This pass finishes output skeleton quality before deeper layer expansion and restores operational signal quality by reducing routine log spam without reducing failure observability.

### Operational effect
Artifacts are now stable long-term homes for in-place future hydration, and function result logs remain proof-rich while becoming materially easier to inspect.


# Aurora Sentinel Core — Change Ledger

## Ledger ID: CL-028

### Date
2026-03-26

### Change title
Old-HUD-anchored HUD completion + correctness restoration

### Change class
mt5 hud hierarchy/routing/render restoration + office/version/continuation synchronization

### Stage / domain
Stage 2 active surface (bounded HUD completion/hardening; Stage 9 still blocked)

### What changed
- used archive benchmark files `ASC_ExplorerHUD.mqh` and `ASC_ExplorerBuckets.mqh` as direct evidence for current HUD restoration
- restored page hierarchy depth to include bucket-detail and stat-detail pages in active routing
- added history-backed back/home semantics and hardened route transitions across bucket/sub-bucket/symbol/stat drilldowns
- restored old-HUD visual grammar patterns (header strip, nav strip, operator cards, row panels, status strip) guided by user screenshots
- fixed pager and row action behavior for main buckets, sub-buckets, and symbol rows
- removed compile-invalid runtime readiness field usage and switched readiness display to Layer 1 summary-derived percentage
- added blueprint-conformant symbol action placeholders on symbol pages only (Deep Analysis active placeholder, Aurora/Semi/Full non-active placeholders)
- kept HUD read-only truth boundaries intact (no scanner/runtime ownership migration)

### Why it mattered
Previous HUD behavior was materially weaker than archive-proven operator flow. This pass restores the proven operator hierarchy and immediate-feel navigation while preserving current blueprint ownership law.

### Operational effect
HUD is now operator-usable with stable depth navigation, clear symbol/stat detail separation, and stronger visual/operator continuity with old HUD benchmarks.


## Archive notice
Legacy ledger entries CL-007 through CL-013 are treated as archived evidence in historical git state.
They do not constitute active compile/runtime proof for current control posture.


## Ledger ID: CL-027

### Date
2026-03-26

### Change title
Classification foundation hardening and completion synchronization pass

### Change class
mt5 classification hardening + grouped-summary/dossier identity truth + office/version/continuation hygiene

### Stage / domain
Stage 2 active surface — classification foundation completion (bounded)

### What changed
- hardened conservative classification scoring and tie-break policy (server-aware + exact-raw preference)
- constrained canonical alias matching to explicit alias-capable rows to reduce loose canonical drift
- preserved six canonical top-level buckets and explicit stock secondary grouping while adding `sub_bucket_source` provenance
- updated dossier classification identity output to include subgroup-source ownership and safer canonical fallback
- clarified grouped-summary subgroup ownership language as classification-owned (no synthetic grouping)
- synchronized office status, decision/work-log records, continuation handoff, and version label

### Why it mattered
This converts classification from directional support into a safer completed foundation layer for Layer 1 grouped output and dossier identity, while keeping unresolved symbols explicit and avoiding shortcut grouping drift.

### Operational effect
Layer 1 grouped outputs and dossier artifacts now consume a stronger, explicitly-owned classification backbone that later stages can build on without re-interpreting identity ownership.


## Ledger ID: CL-026

### Date
2026-03-26

### Change title
Stage 2 opening spine landed: dispatcher/governor heartbeat, lane ownership, dirty-routing, and telemetry

### Change class
mt5 runtime control + layer1 admission + write-lane governance + logging/telemetry hardening + office hygiene

### Stage / domain
Stage 2 opening implementation

### What changed
- added mode-aware dispatcher selection with explicit lane/sublane ownership per heartbeat
- implemented bounded scan/write credits with explicit deferred-work and yield reasons
- moved Layer 1 into cursor-based admitted scan slices and promoted write eligibility only when scan cycle completes
- separated write publication into persistence lane admission with bounded artifact write budget
- added heartbeat telemetry file (`heartbeat_telemetry.log`) and cleaner operator-useful heartbeat summaries
- reduced repetitive success spam while preserving symbol/path failure visibility
- synchronized office control truth, version posture, and continuation handoff doctrine in same pass

### Why it mattered
This converts the existing Layer 1 + writes + logging stack into a lawful Stage 2 opening control model with one heartbeat authority and explicit admission boundaries.

### Operational effect
Runtime behavior is now governable and inspectable per beat (mode, lane owner, admitted budgets, deferred work, and yield cause), with scan and write heavy work no longer mixed opportunistically.


## Ledger ID: CL-025

### Date
2026-03-26

### Change title
Landed bounded Layer 1 runtime pass with early artifacts and function-result logging

### Change class
mt5 runtime + layer1 + artifacts + logging

### Stage / domain
Stage 3 opening behavior on thin Stage 2 heartbeat hooks

### What changed
- introduced dispatcher heartbeat execution from EA timer with explicit scan-lane ownership
- implemented Layer 1 market-state scan logic and summary counters
- implemented runtime writers for Market Board, Current Focus, and per-symbol Dossiers with truthful placeholders for later layers
- added bounded workbench function-result file logging and integrated it across scan/write heartbeat outcomes

### Why it mattered
This converts Stage 1 scaffold placeholders into first real runtime-owned truth surfaces without widening into Layer 2, shortlist, deep analysis, or HUD work.

### Operational effect
Runtime can now produce bounded truthful Layer 1 artifacts and inspectable function-level success/failure outcomes per heartbeat.

## Ledger ID: CL-024

### Date
2026-03-26

### Change title
Stage 0B final integration hard-gate execution and closure evidence registration

### Change class
office + integration-gate evidence execution

### Stage / domain
Stage 0B integration acceptance

### What changed
- executed Stage 0B Gate 1–6 as binary pass/fail and recorded exact-file evidence rows
- added Stage 0B Closure Evidence Register to `office/ROADMAP_STATUS.md` using full mandatory schema fields
- updated Stage 0B stage-table status from `ready_to_start` to `complete`
- synchronized work-log evidence narrative with exact gate outcomes and contradiction state
- retained NO-GO readiness posture because Stage 0A closure evidence remains pending

### Why it mattered
Stage 0B closure doctrine required an auditable hard-gate run (not narrative confidence). This pass converts Stage 0B from pending doctrine to explicit gate-by-gate evidence with contradiction outcomes.

### Evidence / references
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md` (WL-022)
- `blueprint/roadmap/02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`
- `blueprint/final/ASC_CANONICAL_PRODUCT_SPINE.md`
- `FRONT_DOOR_CHECKLIST.md`
- `archives/README.md`

### Operational effect
Stage 0B is now explicitly evidenced as complete on office surfaces, while MT5 canonical-migration/authority-widening and EA readiness remained blocked at that time by unresolved Stage 0A closure evidence and downstream Stage 2 requirements.

## Ledger ID: CL-023

### Date
2026-03-26

### Change title
Mandated shared closure evidence register schema for Stage 0A/0B and integration-lane closure

### Change class
office + roadmap + governance hardening

### Stage / domain
Closure evidence discipline

### What changed
- introduced a mandatory shared evidence register schema in office roadmap status for Stage 0A closure, Stage 0B closure, and integration coherence lane closure
- added required Stage 0A closure evidence register template with schema-enforcement language
- added required Stage 0B closure evidence register template with schema-enforcement language
- aligned work-log doctrine so closure claims must be row-based, file-linked, and contradiction-explicit

### Required shared schema (normative)
- **gate name**
- **pass/fail**
- **exact file references**
- **unresolved contradiction list**
- **decision reference**
- **closure date**

### Why it mattered
Prior closure posture allowed high-quality intent but could still drift into narrative-only “done” claims. This change forces structured gate-by-gate evidence and explicit unresolved contradiction disclosure.

### Evidence / references
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md` (WL-019)
- `blueprint/roadmap/02A_STAGE_0A_PRE_IMPLEMENTATION_FREEZE.md`
- `blueprint/roadmap/02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`

### Operational effect
Stage 0A/0B and integration-lane closure claims are now non-admissible unless they use the shared register schema with explicit pass/fail and exact file references.

## Ledger ID: CL-022

### Date
2026-03-26

### Change title
Established canonical integration baseline, anti-drift rules, and integration-coherence lane

### Change class
office + governance + roadmap

### Stage / domain
Integration coherence control

### What changed
- recorded D-013 as the canonical integration baseline and anti-drift governance decision
- added an explicit office-language admissibility distinction between historical archive evidence and current admissible scope
- added an “integration coherence” lane with pass criteria and current blockers
- synchronized contradiction mapping with explicit removed-vs-remaining lists in work-log posture

### Contradictions removed (exact map)
1. Missing explicit canonical baseline while enforcing post-archive truth informally.
2. Missing explicit control lane for integration coherence despite recurring coherence concerns.
3. Missing explicit office-language doctrine separating archive evidence from admissible current scope.

### Contradictions remaining (exact map)
1. Stage-gate evidence contradiction remains: governance requires Stage 0A/0B/2 completion evidence that is not yet logged as passed.
2. Historical-note reuse risk remains: legacy narrative text can still drift into present-tense claims unless anti-drift qualifiers are preserved each pass.

### Why it mattered
This pass converts integration coherence from implied doctrine into auditable control structure, reducing drift risk and preserving truthful scope claims.

### Evidence / references
- `office/DECISIONS.md` (D-013)
- `office/ROADMAP_STATUS.md` (integration coherence lane + scope law)
- `office/WORK_LOG.md` (WL-018)

### Operational effect
Integration claims are now baseline-governed, lane-tracked, and contradiction-audited. Remaining blockers are explicit evidence gaps rather than implicit narrative uncertainty.

## Ledger ID: CL-021

> Correction note: ledger IDs in this file were renumbered in-order for strict monotonic uniqueness.
### Date
2026-03-25

### Change title
Normalized control truth to dependency order and post-archive reality

### Change class
office + governance + roadmap

### Stage / domain
Control-surface normalization

### What changed
- roadmap stage statuses were normalized so Stage 3+ cannot be `active` before Stage 2 completion
- legacy MT5 “landed runtime” statements were reclassified as archived evidence references
- a new decision was recorded defining post-archive truth and stage re-activation conditions
- present-tense compile/runtime implication language was removed from office controls where active-surface verification is absent

### Why it mattered
The prior control narrative overstated current operational certainty and violated prerequisite order. This pass restores truthful control semantics and prevents archive momentum from being mistaken for current runtime state.

### Evidence / references
- `office/ROADMAP_STATUS.md`
- `office/DECISIONS.md` (D-012)
- `office/WORK_LOG.md` (WL-016)

### Operational effect
Stage status reporting is now prerequisite-driven and evidence-gated. Re-entry to Stage 3+ `active` requires documented Stage 2 completion plus explicit verification evidence.


## Ledger ID: CL-020

### Date
2026-03-26

### Change title
Added archive inheritance classification canon and integration links

### Change class
blueprint + roadmap + office

### Stage / domain
Archive carryover governance

### What changed
- added `blueprint/ASC_ARCHIVE_INHERITANCE_CLASSIFICATION.md` as the concise inheritance canon
- classified HUD, menu/settings, board/dossier, and runtime cadence by preserve vs visual-only vs reject outcomes
- linked the canon from carryover amendment and roadmap overview

### Why it mattered
Archive reuse decisions were previously implicit across multiple files. This pass makes inheritance posture explicit, evidence-anchored, and easier to audit before implementation widening.

### Evidence / references
- `blueprint/ASC_ARCHIVE_INHERITANCE_CLASSIFICATION.md`
- `blueprint/ASC_ARCHIVE_CARRYOVER_AMENDMENT.md`
- `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`

### Operational effect
Archive-derived implementation choices now have a single canonical classification source, reducing drift risk during rebuild sequencing.

## Ledger ID: CL-019

### Date
2026-03-26

### Change title
Final pre-EA blueprint stabilization: canonical ownership map + builder-proof execution law

### Change class
front-door + final + roadmap + office anti-drift hardening

### Stage / domain
Pre-EA control-layer stabilization

### What changed
- converted compact canonical spine into explicit owner/reference-only map with must-edit-together guardrails
- added strict first-three-slice execution order doctrine across roadmap and office control surfaces
- strengthened front-door/build-door handoff so present admissible scope and blocked future scope are explicit in one place
- tightened continuation law with required pre-implementation builder questions and co-edit synchronization requirements
- added mandatory pre-EA backlog queue entries (`S0A-FREEZE-CLOSURE`, `S0B-INTEGRATION-GATES`, `S1-FOUNDATION-OPENING-PACKET`)

### Why it mattered
Existing files were mostly correct in isolation but still unsafe in combination for future builders. This pass reduces wrong-file edits, stale-pointer reading, and out-of-order stage opening risk.

### Evidence / references
- `blueprint/final/ASC_CANONICAL_PRODUCT_SPINE.md`
- `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`
- `blueprint/roadmap/15_EXECUTION_BACKLOG.md`
- `FRONT_DOOR_CHECKLIST.md`
- `CHAT_CONTINUATION_GUIDE.md`
- `office/ROADMAP_STATUS.md`
- `office/DECISIONS.md` (D-014)
- `office/WORK_LOG.md` (WL-020)

### Operational effect
The repo is materially safer to build from step by step: canonical ownership is clearer, execution order is explicit, evidence closure requirements are stronger, and future-scope leakage into present implementation is more tightly contained.

## Ledger ID: CL-018

### Date
2026-03-26

### Change title
Blueprint completion hardening: Stage 0A/0B gate-run protocols + EA readiness go/no-go card

### Change class
roadmap + office + front-door + final-law readiness hardening

### Stage / domain
Freeze/integration closure readiness and build-entry control

### What changed
- added auditable Stage 0A closure runbook with criterion-to-owner evidence mapping
- added auditable Stage 0B gate evidence matrix and explicit no-soft-pass language
- introduced EA creation readiness decision card (`GO` / `NO-GO`) in office status
- linked front-door pass validity to office readiness card state
- added builder-answer quick map in canonical product spine for low-interpretation handoff

### Why it mattered
The prior wave improved structure, but final readiness could still be misread from prose. This pass enforces binary go/no-go control based on explicit gate evidence.

### Evidence / references
- `blueprint/roadmap/02A_STAGE_0A_PRE_IMPLEMENTATION_FREEZE.md`
- `blueprint/roadmap/02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`
- `blueprint/final/ASC_CANONICAL_PRODUCT_SPINE.md`
- `office/ROADMAP_STATUS.md`
- `FRONT_DOOR_CHECKLIST.md`
- `CHAT_CONTINUATION_GUIDE.md`
- `office/DECISIONS.md` (D-015)
- `office/WORK_LOG.md` (WL-021)

### Operational effect
EA creation start conditions are now explicit and auditable: no gate evidence -> no GO decision -> no implementation start.

## Ledger ID: CL-017

### Date
2026-03-26

### Change title
Stage 1 foundation opening packet: types, menu schema map, and runtime-prerequisite contracts

### Change class
office + stage1 foundation controls

### Stage / domain
Stage 1 foundation / types / runtime prerequisites

### What changed
- moved Stage 1 from blocked posture to active posture in office stage table
- added Stage 1 implementation evidence packet references into the Stage 1 roadmap owner file
- introduced shared Stage 1 foundation type schema (`ASC_STAGE1_FOUNDATION_TYPES.json`)
- introduced Stage 1 menu/settings mapping schema with required sections and safety-class/owner mappings (`ASC_STAGE1_MENU_SETTINGS_SCHEMA.json`)
- added validation script `validate_stage1_foundation.py` to prove schema integrity

### Why it mattered
Stage 1 requires structural language and contract-ready foundations. This pass provides compile-safe schema evidence without inventing downstream runtime publication truth.

### Evidence / references
- `blueprint/roadmap/03_STAGE_1_FOUNDATION_AND_TYPES.md`
- `stage1/ASC_STAGE1_FOUNDATION_TYPES.json`
- `stage1/ASC_STAGE1_MENU_SETTINGS_SCHEMA.json`
- `stage1/validate_stage1_foundation.py`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md` (WL-023)

### Operational effect
Stage 1 now has tangible foundational schema/contract artifacts and validation evidence; Stage 2 remains blocked until Stage 1 is closed as complete.


## Ledger ID: CL-016

### Date
2026-03-26

### Change title
Correction pass: remove fake Stage 1 output proofs and harden runtime-publication law

### Change class
blueprint + roadmap + office anti-drift correction

### Stage / domain
Stage 1 correction / runtime ownership enforcement

### What changed
- deleted invalid stage-side operator artifact scaffold files from `stage1/output_proof/`
- rewrote Stage 1 roadmap file to de-authorize static Board/Current Focus/Dossier proof files
- hardened final-law owner files to enforce runtime-only publication ownership
- hardened roadmap/backlog anti-speedrun wording against proof-packet completion claims
- updated office status/decision/work-log truth to remove output-proof completion framing

### Why it mattered
The prior posture allowed documentation theater to appear as implementation progress. This correction restores EA-first build law: blueprint defines, roadmap sequences, office records, runtime publishes.

### Evidence / references
- `blueprint/roadmap/03_STAGE_1_FOUNDATION_AND_TYPES.md`
- `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`
- `blueprint/roadmap/15_EXECUTION_BACKLOG.md`
- `blueprint/final/ASC_CANONICAL_PRODUCT_SPINE.md`
- `blueprint/final/10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md`
- `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
- `office/ROADMAP_STATUS.md`
- `office/DECISIONS.md` (D-017)
- `office/WORK_LOG.md` (WL-024)

### Operational effect
Stage-side fake output artifacts are no longer active Stage 1 evidence. Future stage advancement is now harder to speed-run via fabricated proof packets.


## Ledger ID: CL-015

### Date
2026-03-26

### Change title
Stage 0A/0B true-closure re-audit + correlation-line contract hardening

### Change class
front-door + roadmap + final + office synchronization correction

### Stage / domain
Stage 0A/0B closure integrity and anti-drift law hardening

### What changed
- re-audited and reaffirmed Stage 0A and Stage 0B closure posture in office status with explicit true-closure note
- removed stale Stage 1 “output-proof” wording from front-door and roadmap-overview slice law
- hardened board owner contract with mandatory fixed-position compact correlation line for Leading Three / Full Five / All-Markets Top Ten symbol cards
- added Layer 4 cross-reference so correlation-line omission is explicitly non-compliant
- synchronized canonical spine guardrail to keep correlation-line wording ownership centralized

### Why it mattered
This closes residual wording drift that could make Stage 0A/0B closure look soft, preserves blueprint-vs-runtime publication boundaries, and prevents future omission of required Top-5 correlation posture detail.

### Evidence / references
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md` (WL-025)
- `office/DECISIONS.md` (D-018)
- `FRONT_DOOR_CHECKLIST.md`
- `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`
- `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
- `blueprint/final/07_ASC_LAYER_4_SHORTLIST_SELECTION.md`
- `blueprint/final/ASC_CANONICAL_PRODUCT_SPINE.md`

### Operational effect
Stage 0A/0B closure posture is now re-audited and explicit; Stage 1 terminology no longer implies fake output-proof evidence; board correlation compact line law is locked strongly enough to prevent Top-5/Top-10 omission drift.


## Ledger ID: CL-014

### Date
2026-03-26

### Change title
Stage 1 MT5 opening scaffold landed with code-owned runtime publication homes

### Change class
mt5 scaffold + roadmap/office synchronization

### Stage / domain
Stage 1 foundation opening

### What changed
- created active `Aurora Sentinel Core/mt5/` implementation surface
- added grouped Stage 1 EA scaffold modules (`core`, `runtime`, `io`, `logging`, `artifacts`, `menu`, `symbols`, `tests`)
- wired runtime path ownership for server root, board/current-focus filenames, dossier folder, and Workbench folders
- synchronized Stage 1 roadmap and office control wording to reflect implementation opening truth

### Why it mattered
This is the first real EA scaffold pass that converts Stage 1 from schema-only posture to active compile-oriented implementation posture without crossing into Stage 2 or fake publication proofs.

### Evidence / references
- `Aurora Sentinel Core/mt5/AuroraSentinelCore.mq5`
- `Aurora Sentinel Core/mt5/core/*`
- `Aurora Sentinel Core/mt5/runtime/*`
- `Aurora Sentinel Core/mt5/io/*`
- `Aurora Sentinel Core/mt5/logging/*`
- `Aurora Sentinel Core/mt5/artifacts/*`
- `Aurora Sentinel Core/mt5/menu/*`
- `Aurora Sentinel Core/mt5/symbols/*`
- `Aurora Sentinel Core/blueprint/roadmap/03_STAGE_1_FOUNDATION_AND_TYPES.md`
- `Aurora Sentinel Core/office/ROADMAP_STATUS.md`

### Operational effect
Stage 1 is now materially opened on an active MT5 code surface. Stage 2 and beyond remain blocked pending Stage 1 closure evidence.

## Ledger ID: CL-013

### Date
2026-03-26

### Change title
Roadmap correction: Stage 1 foundation rails explicit, Stage 8/9 first-authorization drift removed

### Change class
blueprint + roadmap + office doctrinal synchronization

### Stage / domain
Stage 1 / Stage 8 / Stage 9 sequencing integrity

### What changed
- updated roadmap overview with explicit Stage 1 foundation rails and placeholder-replacement law
- updated Stage 1 stage file to require early runtime-owned bounded testing outputs, HUD scaffold homes, and dev/workbench logging scaffold
- reframed Stage 8 to hardening maturity posture (atomic landing, lineage, continuity, calm publication) rather than first-write authorization
- reframed Stage 9 to rich HUD/operator completion posture rather than first-HUD authorization
- synchronized office roadmap status, decisions, and work log with corrected sequencing doctrine

### Why it mattered
Without this correction, future passes could defer essential testing surfaces and mis-sequence implementation. The corrected doctrine preserves lawful early scaffolding while keeping Stage 8/9 focused on maturity hardening.

### Evidence / references
- `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`
- `blueprint/roadmap/03_STAGE_1_FOUNDATION_AND_TYPES.md`
- `blueprint/roadmap/10_STAGE_8_PERSISTENCE_AND_ARTIFACTS.md`
- `blueprint/roadmap/11_STAGE_9_HUD_AND_OPERATOR_SURFACE.md`
- `office/ROADMAP_STATUS.md`
- `office/DECISIONS.md` (D-020)
- `office/WORK_LOG.md` (WL-027)

### Operational effect
Future builders now receive one clear sequencing law: Stage 1 rails first, Stage 2 spine next, Layers 1–5 hydration next, Stage 8/9 maturity hardening after; fake output proofs remain inadmissible.

### Addendum (2026-03-26)
CL-024 confirmed: unresolved symbols remain explicit and are excluded from synthetic grouped membership in Market Board counts.


## Ledger ID: CL-015

### Date
2026-03-28

### Change title
HUD symbol section navigation alignment and Layer 3/4 scaffold exposure fix

### Change class
hud contract-alignment + interaction bugfix

### Stage / domain
Stage 1 HUD scaffold / symbol-context navigation

### What changed
- corrected symbol-context section navigation to expose all eight locked section families (`Overview`, `Market Watch`, `Specification`, `Layer 3`, `Layer 4`, `Layer 5`, `Layer 6`, `Layer 7`)
- added missing `sym_stat_7`/`sym_stat_8` controls and click handlers so Layer 6/7 are reachable without fallback behavior
- remapped prior six-aspect switching flow to section-family switching flow and updated section detail hero labels
- updated section detail rendering so Layer 3/4 remain explicit scaffold homes and Layer 6/7 remain explicit future scaffold homes
- updated UI wording from "Aspect" to "Section" where symbol-context navigation semantics are section-family based

### Why it mattered
This closes a contract drift where symbol-context navigation did not faithfully implement the eight-family section spine and left Layer 3/4 inaccessible from the section row.

### Evidence / references
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`

### Operational effect
Selected symbol context now retains one consistent section-family navigation path across all required section homes, with truthful scaffold posture for non-admitted layers.

## Ledger ID: CL-016

### Date
2026-03-28

### Change title
Task 2 shared scaffold implementation pass across HUD + dossier/current-focus + board hooks

### Change class
shared scaffold implementation + symbol-context navigation hardening

### Stage / domain
Stage 1 scaffold maturity (symbol information spine alignment)

### What changed
- made HUD symbol section row persistent across symbol pages by reserving bottom symbol-section navigation space in render flow
- retained top symbol action row while keeping bottom section row visible for sibling-page switching without back-navigation dependency
- aligned dossier/current-focus Layer 3 section homes to carry real current-input posture (open-state + classification baseline) while preserving explicit "awaiting layer completion" decision posture
- kept Layer 4–7 as scaffold-only homes with explicit non-active wording
- refined Market Board symbol-architecture hook section to point cleanly into shared section families

### Why it mattered
This closes navigation and structural drift against Task 2 laws: all surfaces now share one section spine, symbol navigation remains persistent in symbol context, and no fake later-layer payloads are fabricated.

### Evidence / references
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_MarketBoardWriter.mqh`

### Operational effect
Shared symbol scaffold is now materially implemented through Layer 7 section homes across HUD and artifact surfaces, with real inputs limited to currently admitted layers and truthful scaffold posture elsewhere.

## Ledger ID: CL-017

### Date
2026-03-28

### Change title
Task 3 Symbol Overview rebuild: short-page posture and cross-surface overview alignment

### Change class
hud/operator summary rebuild + artifact overview alignment

### Stage / domain
Stage 1 symbol overview posture hardening

### What changed
- rebuilt HUD Symbol Overview into a short operator summary page (compact identity, primary state/eligibility, key quote posture, friction/tradeability posture, one current-summary line, one next-page hint)
- removed redundant large Overview-card repetition by collapsing prior multi-card overlap and hiding duplicate overview cards
- aligned Dossier and Current Focus Overview sections so each carries the same core summary spine at different densities (HUD shortest, Current Focus compact, Dossier fuller)

### Why it mattered
This addresses Task 3 role law: Overview now answers “what matters right now” without duplicating Market Watch / Specification / later-layer pages.

### Evidence / references
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`

### Operational effect
Symbol Overview is now materially short, operator-focused, and structurally aligned across HUD + Current Focus + Dossier without turning into a dumping surface.

## Ledger ID: CL-018

### Date
2026-03-28

### Change title
Task 4 Market Watch / Live Quote implementation across HUD + dossier/current-focus

### Change class
layer2 symbol-page implementation + cross-surface alignment

### Stage / domain
Stage 1 symbol page maturity (Layer 2 surface)

### What changed
- implemented a real HUD Market Watch page branch backed by admitted Layer 2 packet data and grouped by function (`Live Quote`, `Spread / Freshness`, `Day Posture`, `Intraday Range Posture`)
- added dynamic field suppression in HUD for optional day/open/close/high/low values so unavailable values are not fabricated
- expanded Dossier Market Watch section with richer Layer 2 packet fields when lawfully available (spread %, server/tick time, open/close, daily change, bid/ask highs-lows)
- aligned Current Focus Market Watch section with a trimmed version of the same ownership model and dynamic suppression behavior

### Why it mattered
This establishes Market Watch as a true Layer 2 page (distinct from Overview), improves operator usefulness, and keeps cross-surface ownership alignment without inventing unsupported values.

### Evidence / references
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`

### Operational effect
Symbol-context Market Watch now delivers real current packet posture in HUD and aligned artifact outputs, with dynamic suppression for optional fields and no empty-value clutter inflation.

## Ledger ID: CL-019

### Date
2026-03-28

### Change title
Task 5 Specification / Contract implementation across HUD + dossier/current-focus

### Change class
broker specification/session/tradeability surface implementation

### Stage / domain
Stage 1 symbol page maturity (specification surface)

### What changed
- replaced HUD Specification section branch with grouped broker/spec cards: precision, execution permissions, volume constraints, swap/margin/sessions
- expanded Dossier Specification section with richer broker contract/session fields and dynamic suppression for non-applicable values
- aligned Current Focus Specification section with trimmed key broker/spec constraints and currency/volume posture

### Why it mattered
This creates a dedicated specification page that is clearly distinct from Market Watch and Overview while exposing useful broker/tradeability rules without dumping unsupported values.

### Evidence / references
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`

### Operational effect
Specification/Contract now surfaces practical broker constraints and tradeability permissions in aligned densities across HUD + Current Focus + Dossier.

## Ledger ID: CL-020

### Date
2026-03-28

### Change title
Task 6 Layer 3 selection filter implementation and alignment pass

### Change class
layer3 symbol-page implementation + summary posture alignment

### Stage / domain
Stage 1 symbol page maturity (Layer 3 surface)

### What changed
- implemented real Layer 3 selection-filter posture in HUD with pass/fail/pending state, reasoning, disqualifiers, freshness dependency, corroboration status, and next-step guidance
- aligned Dossier Layer 3 section with fuller pass/fail/pending evidence narrative and disqualifier details
- aligned Current Focus Layer 3 section with compact pass/fail/pending corroboration and next-step posture
- added compact Layer 3 summary posture counts (pass/fail/pending) to Market Board symbol section hooks based on admissible current evidence

### Why it mattered
This makes Layer 3 the highest fleshed real-data page in the current wave while preventing drift into Layer 4/5 logic and keeping summary surfaces truthful.

### Evidence / references
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_MarketBoardWriter.mqh`

### Operational effect
Layer 3 now answers a distinct selection-filter question across symbol surfaces with compact summary propagation and no downstream fake values.

## Ledger ID: CL-021

### Date
2026-03-28

### Change title
Fixup Pass 1: operator wording drift kill + engineering naming cleanup + symbol-surface contract hardening

### Change class
cross-surface terminology and naming integrity correction

### Stage / domain
Stage 1 active symbol-surface correctness hardening

### What changed
- removed operator-visible numeric layer headings from HUD section tabs, symbol section titles, summary lines, and artifact section headings
- normalized shared operator section-family wording to `Overview`, `Market Watch`, `Specification`, `Selection Filter`, `Shortlist Context`, `Deep Analysis`, and `Future Expansion`
- replaced compressed drifted local names (`layer3_*`, `layer5_*`, `l3_*`, `l2_summary`) with role-aware semantic names in touched artifact writers
- fixed compile errors from drifted symbols by removing undefined `ASC_L1IsEligibleState` usage and correcting execution-mode key usage to `SYMBOL_TRADE_EXEMODE`
- strengthened `ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md` with explicit operator-visible terminology lock for the shared symbol information spine

### Why it mattered
This pass removes mixed terminology and brittle shorthand in the active symbol-surface path, restoring one operator-safe language contract and reducing future cross-surface drift risk.

### Evidence / references
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `Aurora Sentinel Core/blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`

### Operational effect
HUD, Dossier, Current Focus, and Board symbol hooks now present a consistent operator-safe vocabulary while retaining internal engineering ownership boundaries.

## Ledger ID: CL-022

### Date
2026-03-28

### Change title
Fixup Pass 2: symbol information architecture rebuild (HUD + Dossier + Current Focus)

### Change class
page-role separation and anti-repetition hardening

### Stage / domain
Stage 1 active symbol-surface architecture quality pass

### What changed
- reworked HUD Overview section cards so the page stays short and high-value (state, eligibility, quote posture, freshness, next-check context) instead of role/filler repetition
- enriched HUD Market Watch with dedicated timing/context cards for packet age, last-good time, observed time, next due, status note, ambiguity, and continuity posture
- locked bottom symbol section captions to exact shared family names (`Selection Filter`, `Shortlist Context`, `Deep Analysis`, `Future Expansion`)
- reduced duplication in artifact Specification sections by removing repeated classification identity lines in Dossier and Current Focus
- tightened symbol-spine blueprint with explicit page-role law so Overview/Market Watch/Specification/Selection Filter remain distinct and non-overlapping

### Why it mattered
This pass addresses repetition-heavy symbol surfaces and restores clear operator page purpose while keeping one shared symbol information spine across HUD, Dossier, and Current Focus.

### Evidence / references
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `Aurora Sentinel Core/blueprint/final/ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`

### Operational effect
Selected-symbol page navigation remains persistent, page roles are clearer, and symbol intelligence density is concentrated where operators expect it (Market Watch and Specification) without repeated shallow blocks.

## Ledger ID: CL-023

### Date
2026-03-28

### Change title
Fixup Pass 3: L1/L2/L3 truth-flow hardening and publication/status bug fixes

### Change class
runtime-consumer accounting correction + publication/status integrity

### Stage / domain
Stage 1 active runtime reporting hardening

### What changed
- corrected Market Board Selection Filter accounting by removing duplicated counting path and normalizing to one per-symbol accounting flow
- updated Selection Filter accounting to include market-watch packet availability in one unified pass/pending/fail decision path
- expanded Deep Analysis scaffold aggregation with explicit live-status and dossier-write pending/complete/result counters
- added `Cycle Posture` and `Publication Posture` lines to Market Board scanner posture so partial/stale/degraded reality is surfaced explicitly
- updated Dossier and Current Focus Deep Analysis sections with explicit `Live Status` lines and more honest dossier-write pending posture
- replaced generic Dossier continuity line with explicit continuity-backed packet status

### Why it mattered
This pass removes contradictory board accounting and improves consumer-surface honesty for status/progress/publication posture without inventing Layer 4/5 final truth.

### Evidence / references
- `Aurora Sentinel Core/mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh`
- `Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh`

### Operational effect
Board totals are no longer inflated by duplicated Layer 3 counting, and symbol consumer surfaces now carry clearer live-status and publication/continuity posture under dynamic server conditions.

## Ledger ID: CL-024

### Date
2026-03-28

### Change title
Compile stabilization: HUD execution enum constants + missing datetime helper

### Change class
compile-safety bugfix

### Stage / domain
Stage 1 active HUD/runtime integration stabilization

### What changed
- replaced invalid execution enum identifiers (`SYMBOL_TRADE_EXEMODE_*`) with valid `SYMBOL_TRADE_EXECUTION_*` constants in HUD execution-mode text mapping
- added missing `ASC_HudDateTimeText` helper and wired existing Market Watch timing-card calls to this declared formatter

### Why it mattered
This removes concrete compile blockers in active HUD symbol-surface code and restores function-level integration for timing-card lines.

### Evidence / references
- `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh`

### Operational effect
HUD symbol timing cards can format datetime fields without unresolved references, and execution-mode label mapping now compiles against valid enum constants.


## 2026-03-29
- MT5: activated Layer 4 shortlist publication in Market Board, Current Focus, and Dossier.
- MT5: added shortlist helper lookup and compact correlation summary helpers.
- Blueprint/Office: updated runtime maturity truth from Layer 1-4 active to Layer 1-4 active.

## 2026-03-30
- MT5: corrected Layer 3 degraded-upstream reason wording in `ASC_SelectionFilterEvaluate` to reflect degradation truth without stale-only implication.
- MT5: expanded Layer 3 dependency line to include continuity-clear and confidence-acceptable booleans for clearer operator diagnostics.
- Office: recorded Layer 3 gate-line hardening in `WORK_LOG.md`.

## 2026-03-30
- MT5 shortlist owner: added explicit existing-membership validity check so hold does not preserve unlawful shortlist members; invalid shortlist now refreshes from lawful survivors when available.
- MT5 shortlist consumers: switched shortlist totals/correlation peers to shortlisted membership only, preventing universe-size rank/peer drift.
- MT5 Market Board: corrected shortlisted/promoted and bucket shortlist counts to reflect shortlist membership truth rather than all candidate rows.
- Runtime bundle cache: publication shortlist total now records shortlisted membership count.

## 2026-03-30
- Dispatcher: write lane now enforces bounded dossier-per-beat publication budget, preserving one-lane breathing under large universes.
- Dispatcher: dossier publication now continues across beats with write cursor continuity instead of forcing one-beat full-universe flush.
- Dispatcher: shortlist cache rebuild now reuses existing cache when scan pass identity is unchanged.
- HUD: shortlist context lookup now uses a short-lived cache to prevent repeated shortlist rebuild work on each symbol-page render call.


## Ledger ID: CL-090

### Date
2026-03-31

### Change title
Dossier-first Current Focus ownership and real selected-symbol Layer 5 activation

### Change class
runtime ownership correction + lawful deep-analysis activation

### Stage / domain
selected-symbol HUD path (`hud` / `dispatcher` / `artifacts` / `deep_selective_analysis`)

### What changed
- Current Focus stopped authoring its own independent baseline body and now publishes the canonical dossier payload for the selected symbol
- ordinary dossier publication now preserves an existing lawful Deep Analysis block instead of overwriting it with placeholder text
- the explicit HUD Deep Analysis action now runs a real symbol-scoped Layer 5 builder for the selected promoted symbol only
- Deep Analysis completion now atomically lands the same enriched dossier payload into both the symbol dossier and `Current Focus.txt`
- HUD view-sync now tracks selected-symbol changes so same-symbol page navigation does not silently flatten a deep-enriched Current Focus file

### Why it mattered
The previous split-ownership model let Current Focus drift away from dossier truth and kept Layer 5 as a placeholder surface that did not enrich the dossier owner.

### Operational effect
- opening or switching to a symbol rewrites Current Focus as that symbol's dossier duplicate
- Deep Analysis remains explicit-trigger only, never runs on page open, and is blocked outside promoted/entitled scope
- Layer 5 now produces real OHLC/tick/spread/freshness/preservation content and updates both artifacts together

## Ledger ID: CL-138

### Date
2026-04-02

### Change title
Deep debug takeover evidence capture — active owner/contradiction audit (no runtime patch)

### Change class
debug evidence + control-surface truth update

### Stage / domain
`office/WORK_LOG.md` (bounded debug evidence recording)

### What changed
- recorded a bounded deep-debug takeover entry that verifies active compile path, selected-symbol pair sync chain, publication helper behavior, HUD behavior, and Layer 3/4/5 owner flow
- captured the highest-risk contradiction cluster found in active runtime truth: HUD consumer-law drift via local shortlist/filter recomputation and dossier-as-current-focus substitution
- recorded one explicit next repair battlefield only: HUD consumer-only boundary enforcement in `mt5/hud/ASC_HUD_Manager.mqh`

### Why it mattered
This prevents another broad speculative pass and locks the next repair target to the highest-risk proven contradiction cluster.

### Operational effect
- control room now has explicit debug evidence of where runtime can appear current while drifting from owner truth
- next repair pass can be tightly bounded to one battlefield

## Ledger ID: CL-145

### Date
2026-04-02

### Change title
Phase 6 deep dossier family extraction and explicit shell/payload policy split

### Change class
dossier composition ownership extraction

### Stage / domain
`mt5/artifacts/dossier` deep selective analysis subgroup lane

### What changed
- extracted deep subgroup renderer functions into `mt5/artifacts/dossier/deep_selective_analysis/` family files
- introduced `ASC_DossierDeepSectionPolicy.mqh` for explicit shell-first normal-path posture and payload admission boundaries
- updated `ASC_DossierComposer.mqh` to call policy and deep family owners directly
- preserved writer compatibility ownership in `ASC_DossierWriter.mqh`

### Why it mattered
This reduces deep subgroup implementation concentration in composer and keeps shell/payload admission logic explicit and auditable without redesigning Layer 5 engine behavior.

### Operational effect
- normal path keeps shell-first posture through policy owner
- fresh deep payload projection and preserved payload access are policy-gated explicitly
- deep dossier subgroup rendering is now modularized under one bounded family folder

## Ledger ID: CL-146

### Date
2026-04-02

### Change title
Phase 7 terminal dossier family extraction (Trader Context + Recent Change Trace)

### Change class
dossier terminal-section ownership extraction

### Stage / domain
`mt5/artifacts/dossier` terminal sections

### What changed
- moved Trader Context render assembly into `trader_context/ASC_DossierTraderContextSection.mqh`
- moved Recent Change Trace render assembly/status projection into `recent_change_trace/ASC_DossierRecentChangeTraceSection.mqh`
- updated composer to call terminal family functions directly and removed inline terminal-section rendering blocks

### Why it mattered
This preserves the frozen dossier contract while reducing central composer ownership concentration for terminal sections.

### Operational effect
- visible dossier scaffold/order/labels remain unchanged
- Trader Context and Recent Change Trace remain projection-only surfaces
- writer remains compatibility compile entry; final writer-thinning is still pending

## Ledger ID: CL-147

### Date
2026-04-02

### Change title
Phase 8 dossier writer-thinning finalization and architecture completion posture

### Change class
dossier architecture finalization (no runtime redesign)

### Stage / domain
`mt5/artifacts/ASC_DossierWriter.mqh` + dossier contract owner lane

### What changed
- removed writer-local `ASC_DossierContract` implementation residue
- moved dossier contract-construction ownership into `mt5/artifacts/dossier/ASC_DossierContracts.mqh`
- preserved writer role as compile entry + composer call + publish bridge

### Why it mattered
This closes remaining writer ownership residue and aligns implementation with the intended dossier architecture boundaries.

### Operational effect
- writer is a true thin compatibility wrapper
- composer/family/common ownership boundaries remain intact
- visible dossier contract and publication behavior are unchanged
- dossier folder redesign is complete at architecture level

## Ledger ID: CL-148

### Date
2026-04-02

### Change title
Dossier consolidation/debug narration alignment + writer include ownership tightening

### Change class
dossier consolidation maintenance (no behavior redesign)

### Stage / domain
`mt5/artifacts` dossier owner-boundary + dossier control surfaces

### What changed
- writer now includes dossier contract owner directly (`dossier/ASC_DossierContracts.mqh`)
- dossier roadmap/decision/work-log/layout-law wording now states mixed landing reality and code-first ownership precedence

### Why it mattered
This reduces dossier narration drift risk where phase labels can mislead future debugging away from current code truth.

### Operational effect
- compile path and publication behavior remain unchanged
- dossier ownership reporting now tracks actual landed code boundaries more honestly

## Ledger ID: CL-149

### Date
2026-04-04

### Change title
Phase 3 Slice 7 L2 availability recovery and HUD/dossier packet parity

### Change class
L0-L2 producer hydration + consumer parity correction

### Stage / domain
`mt5/open_symbol_snapshot`, `mt5/artifacts/dossier`, `mt5/hud`

### What changed
- Layer-2 packet evaluation now falls back to `SymbolInfoTick` for quote/tick-time acquisition and to D1 bar owners (`iHigh`/`iLow`) for day-structure hydration.
- Day-structure packet fields now hydrate independently from strict live quote success where lawful owner bars are present.
- Layer-2 specification path now fills `gtc_mode` from `SYMBOL_ORDER_GTC_MODE`.
- Dossier sessions/swap/margin/spec rows now consume Layer-2 packet fields first (session statuses/hours, swap weekdays, margin terms, freeze/gtc), with snapshot fallback retained.
- HUD specification/session scope now uses admitted Layer-2 packet context even when lawful quote snapshot is absent.

### Why it mattered
Open/closed symbols were losing lawful L2 structural/spec/session truth when quote-path hydration was incomplete, and HUD/dossier were not consistently projecting the same packet-owned fields.

### Operational effect
L2 unavailable surfaces are reduced where MT5 owners already expose truth; missingness remains explicit only when owner reads fail.

## Ledger ID: CL-150

### Date
2026-04-04

### Change title
Layer-3 producer recovery: shortlist-optional filter truth consumption for HUD + dossier confidence contract alignment

### Change class
L3 producer/consumer boundary correction

### Stage / domain
`mt5/candidate_filtering`, `mt5/hud`, `mt5/artifacts/dossier`

### What changed
- HUD selection truth resolver now computes filter truth from producer owners (`ASC_SelectionFilterEvaluate`) when shortlist cache rows are unavailable, instead of treating L3 truth as unavailable by default.
- HUD selected-symbol tactical and L3 detail cards now consume resolved filter fields (state/reason/blockers/dependencies/corroboration/confidence/next-step) from that unified path.
- Dossier Candidate Filtering gate-status confidence now consumes the producer L3 contract field `filter.confidence_text` directly.

### Why it mattered
L3 filter truth was already available from producer owners before shortlist publication, but HUD consumed shortlist cache presence as a hard prerequisite and could emit misleading "awaiting shortlist" posture for symbols with lawful L3 filter truth.

### Operational effect
L3 truth projection is now coherent across dossier and HUD, with shortlist still owning shortlist membership/rank and Layer-4 promotion posture.

## Ledger ID: CL-151

### Date
2026-04-04

### Change title
Layer-3 consumer parity hardening: remove remaining shortlist-only HUD filter reads

### Change class
L3 consumer parity correction

### Stage / domain
`mt5/hud` + L3 parity control surfaces

### What changed
- `ASC_HudResolveSelectionTruth(...)` now initializes packet state before producer filter evaluation when no packet is found.
- HUD Symbols list rows now derive filter posture/reason/snapshot readiness from resolved L3 filter truth, not shortlist-presence alone.
- HUD Selected Symbol detail filter lines now consume resolved L3 filter truth (posture/reason/next-step) instead of shortlist-only fallback.
- HUD tactical signature now records resolved L3 filter fields so signature refresh tracks shortlist-optional L3 truth changes.

### Why it mattered
Consumer parity still drifted in HUD pages that treated shortlist cache as the only L3 source, while dossier already consumed producer filter truth when shortlist was absent.

### Operational effect
HUD and dossier now project the same Layer-3 meaning for a symbol across core operator surfaces, with shortlist continuing to own rank/membership posture only.

## Ledger ID: CL-152

### Date
2026-04-04

### Change title
Layer-3 final hardening: shortlist-absent HUD boundary correction and stop-gate tightening

### Change class
L3 edge-case / boundary hardening

### Stage / domain
`mt5/hud` + Layer-3 stop-gate control sync

### What changed
- Added explicit filter-owned eligibility label path for shortlist-absent HUD symbol rows, preventing shortlist-structure reads when shortlist data is absent.
- Tightened tactical signature shortlist marker to `shortlist:unranked` when filter truth exists without shortlist rank context.
- Kept rank/membership semantics deferred to shortlist-owner (Layer 4), while preserving L3 filter meaning in consumer paths.

### Why it mattered
Final L3 hardening required edge-case honesty: consumer output must not imply ranked shortlist state or depend on shortlist membership objects when only filter truth is available.

### Operational effect
Layer-3 consumer output is now boundary-safe for final stop-gate review, with clearer separation between L3 filter meaning and L4 shortlist ranking semantics.

## Ledger ID: CL-153

### Date
2026-04-04

### Change title
Layer-3 P4 hardening: tradability boundary correction + dependency/corroboration coherence

### Change class
L3 producer edge-case / meaning hardening

### Stage / domain
`mt5/candidate_filtering` + Layer-3 stop-gate control sync

### What changed
- Tradability gate now treats unavailable/restricted trade mode as blocked-pending (not false fail), with explicit trade-mode labeling.
- Entry permission check was tightened to require full trade mode for L3 admission.
- Dependency summary spread segment formatting was corrected (`Spread Gate` + explicit spread value/cap).
- Corroboration text now explicitly distinguishes continuity-backed corroboration from live corroboration.

### Why it mattered
Final L3 hardening needed truthful boundary semantics: missing/restricted tradability should not be overclaimed as terminal fail, and operator-facing dependency/corroboration text must stay coherent.

### Operational effect
Layer-3 producer outcomes are more stable under tradability and corroboration edge cases, with cleaner stop-gate semantics before Layer-4 work.
