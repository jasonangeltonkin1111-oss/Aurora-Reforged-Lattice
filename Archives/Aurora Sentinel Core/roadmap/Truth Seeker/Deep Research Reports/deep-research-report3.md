# AURORA TRUTH SEEKER — DATA OWNERSHIP + LAYER TRUTH + ARTIFACT ALIGNMENT + CONTRADICTION AUDIT

## Executive verdict

The system’s **ownership doctrine is now much clearer than its implementation**. The compile-path law is explicit: dispatcher orchestrates, engines own truth, writers project, and HUD owns zero truth (`ASC_CORE.MD:114-117`, `129-149`, `154-163`, `177-188`). The source also now embeds strong falsehood boundaries in the owner layers: **L3, L4, and L5 all explicitly say they are not trade permission, not entry signal, and not final execution authority** (`mt5/candidate_filtering/ASC_SelectionFilter.mqh:997-1127`; `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh:255-310`, `510-535`; `mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh:529-535`). That is a real improvement.

But the implementation is **not ownership-pure yet**. The biggest flaw is that **portfolio/exposure truth still has duplicate owners in practice**. The roadmap and RUN064 claim a canonical open/pending portfolio owner in `ASC_PortfolioExposureSnapshot.mqh` with “no duplicate owner” (`TRUTH_SEEKER_RUN064_REPORT.md:54-60`), but compile-path code still reads open/pending exposure directly through `ASC_ArtifactTextHelpers.mqh` helper counts and uses that duplicate path inside Dossier, Market Board, and L4 logic (`mt5/artifacts/ASC_ArtifactTextHelpers.mqh:527-582`; `mt5/artifacts/dossier/ASC_DossierComposer.mqh:3282-3284`; `mt5/artifacts/ASC_MarketBoardWriter.mqh:1274`, `1717`, `1752`, `1767`, `1787`, `2039`, `2095`, `2133`; `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh:1473`). That is the clearest current contradiction between roadmap cleanliness claims and source reality.

The second big flaw is that **writers still synthesise decision-shaped narrative**. `ASC_MarketBoardWriter.mqh` does not just render upstream truth; it computes `candidate_type`, “first-pick” phrasing, and “do not pick” reasons from L4 fields, freshness, and live exposure counts (`mt5/artifacts/ASC_MarketBoardWriter.mqh:521-579`). The source also repeatedly says the board keeps “ordinary board command authority” (`mt5/artifacts/ASC_MarketBoardWriter.mqh:1297`, `1877`, `2548-2549`). That is not a rank recomputation, but it is **more than neutral projection**. It raises real hidden-authority risk if the wording ever drifts ahead of L4 owner truth.

The good news is that **Dossier still looks like the canonical selected-symbol truth artifact**, and **Current Focus still behaves as a derivative/mirror/guard rather than a competing truth owner**. The active roadmap log explicitly says `ASC_CURRENT_FOCUS_FILE` resolves to `Dossier.txt`, and that Current Focus is a derivative expectation, not a separate family by default (`TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md:1267-1269`). In source, `ASC_CurrentFocusWriter.mqh` mostly performs canonical-symbol matching, protected completed-deep readback, and same-symbol downgrade prevention rather than market-state or shortlist recomputation (`mt5/artifacts/ASC_CurrentFocusWriter.mqh:47-96`, `157-178`, `210-270`, `288-294`).

The cleanest summary is this:

**Verdict: partial clean, not contradiction-clean, not owner-pure.**  
The architecture is directionally right. The owner layers are better labelled than before. But duplicate exposure ownership, hidden writer-side actionability summaries, mixed projection taxonomy, and mostly-advisory contradiction handling mean the system is **still carrying meaningful truth-purity debt**.

## Truth owner map

### Clean ownership areas

The source now states its ownership theory clearly and repeatedly. L3 defines itself as candidate-ranking support only, stamps its source owner, and adds explicit falsehood boundaries (`mt5/candidate_filtering/ASC_SelectionFilter.mqh:997-1127`). L4 does the same for shortlist-ranking support and explicitly says rank is not deep analysis or final trade decision (`mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh:255-310`, `510-535`). L5 explicitly says it is selected-symbol depth only, not Market Board truth ownership, not GlobalTop10 truth ownership, and not complete evidence (`mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh:529-535`). Portfolio/history semantics are also clean inside the portfolio owner: open positions are active exposure, pending orders are future exposure, and closed trades are context only (`mt5/portfolio/ASC_PortfolioExposureSnapshot.mqh:351`, `368`, `408`, `656-662`, `798-809`, `814`, `834`, `853`, `954`).

### Duplicate and unclear ownership risks

The exposure domain is still not singular. The codebase has both a canonical portfolio snapshot owner and old-style direct counting helpers. That means the same truth is reachable through two independent paths. This is the single largest ownership impurity in the current baseline.

The second unclear area is board-level actionability language. Market Board does not re-own rank, but it does compute “top overall candidate”, “overall backup candidate”, “first-pick workflow”, and “do not pick” text from multiple upstream inputs. That is still derivative, but it is not a purely passive projection.

### Truth owner map table

| Truth domain | True owner | Consumers | Duplicate owner risk | Evidence |
|---|---|---|---|---|
| Market state and symbol state | `ASC_MarketStateEngine.mqh` | L2, L3, L4, Dossier, Market Board, dispatcher | Low | `ASC_CORE.MD:129-142`; `mt5/market_state/ASC_MarketStateEngine.mqh:33-57`, `127-171` |
| Open Symbol Snapshot and packet freshness | `ASC_OpenSymbolSnapshotEngine.mqh` | L3, L4, Dossier, Market Board, L5 | Low to medium | `mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh:25-196`, `531-578`, `625-712`, `999-1025` |
| Candidate Filtering truth | `ASC_SelectionFilter.mqh` | L4, Dossier, Market Board, L5 context | Low | `mt5/candidate_filtering/ASC_SelectionFilter.mqh:997-1127`, `1979-2017` |
| Shortlist Selection truth | `ASC_ShortlistSelectionEngine.mqh` | Dossier, Market Board, L5 context, Current Focus mirror | Medium | `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh:255-310`, `510-535` |
| Deep Selective Analysis truth | `ASC_DeepSelectiveAnalysisEngine.mqh` | Dossier, Current Focus, selected-symbol support surfaces | Low to medium | `mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh:529-535`, `1816-1891`, `2004-2033` |
| Selected-symbol ownership / synchronisation | Dispatcher | Dossier, Current Focus, L5 trigger path | Medium | `ASC_CORE.MD:177-188`; `mt5/runtime/ASC_RuntimeState.mqh:675-686`; `mt5/artifacts/ASC_CurrentFocusWriter.mqh:47-96`, `210-270` |
| Portfolio exposure and history | Intended: `ASC_PortfolioExposureSnapshot.mqh` | Market Board, Dossier, L4-related summaries | **High** | Roadmap claim: `TRUTH_SEEKER_RUN064_REPORT.md:54-60`; duplicate source paths: `mt5/artifacts/ASC_ArtifactTextHelpers.mqh:527-582`; uses in `ASC_DossierComposer.mqh:3282-3284`, `ASC_MarketBoardWriter.mqh:1274` and many later calls, `ASC_ShortlistSelectionEngine.mqh:1473` |
| Dossier canonical selected-symbol artifact | `ASC_DossierComposer.mqh` + `ASC_DossierWriter.mqh` | Operator surfaces, Current Focus derivative path | Low to medium | `ASC_CORE.MD:458-484`; `mt5/artifacts/ASC_DossierWriter.mqh:216-257`; `mt5/artifacts/dossier/ASC_DossierComposer.mqh:3255-3261` |
| Current Focus payload | Derivative/mirror guard, not primary truth owner | Operator selected-symbol convenience surface | Low | `ASC_CORE.MD:476-484`, `1554-1571`; `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md:1267-1269`; `mt5/artifacts/ASC_CurrentFocusWriter.mqh:157-178`, `210-270` |
| Market Board compressed summary | `ASC_MarketBoardWriter.mqh` as projection owner only | Operator board surface | Medium to high | `ASC_CORE.MD:487-499`, `1577-1583`; `mt5/artifacts/ASC_MarketBoardWriter.mqh:521-579`, `1297`, `1877`, `2387` |
| GlobalTop10 current family | Dispatcher/publication family + child dossiers | Operator, manifests, family readers | Medium | `TRUTH_SEEKER_RUN065R_REPORT.md:66-69`, `81-82`; `mt5/artifacts/dossier/ASC_DossierComposer.mqh:2571-2591` |
| GlobalTop10 archive family | Artifact-family continuity/archive flow | Operator, audit/evidence readers | Medium | `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` family-role helpers; `TRUTH_SEEKER_RUN065R_REPORT.md:69`, `81` |

### Artifact projection map table

| Artifact | Truth consumed | Source owner | Projection risk | Contradiction risk |
|---|---|---|---|---|
| Market Board | L1 state, L2 packet posture, L4 shortlist, portfolio snapshot, direct exposure counts | L1, L2, L4, Portfolio | **Medium to high** because of writer-side selection/actionability narratives | **High** where direct counts can diverge from snapshot |
| Root Dossier ordinary path | L1, L2, L3, L4, selected exposure context | L1, L2, L3, L4, Portfolio | Medium because it builds opportunity/constraint and hold/replacement summaries | Medium |
| Selected-symbol Dossier deep override | L1-L5 plus dispatcher-selected symbol context | L1-L5 + dispatcher | Medium because one artifact family mixes baseline and selected deep support | Medium |
| Current Focus | Mirrored/protected selected-symbol payload from root dossier path | Dossier + L5 selected-symbol truth | Low to medium | Medium if path identity or selected-symbol revision drifts |
| GlobalTop10 child dossier | L1-L4 and possibly deep child context depending on runtime path | Dispatcher/top10 batch + Dossier composer | Medium | Medium |
| FunctionResults | Claim evidence, proof scopes, publication status | Dispatcher / publication functions / seam emitters | Medium | Medium because contradiction taxonomy is stronger than actual contradiction checking |
| HUD | Prepared truth only | Upstream owners only | Unknown in this pass | Unknown in this pass |

## Artifact alignment and contradiction risks

### The strongest contradiction in the current baseline

The strongest contradiction is between the **project’s stated “canonical portfolio owner / no duplicate owner” claim** and the actual compile-path implementation. RUN064 says the canonical owner exists and should be preserved without duplicate ownership (`TRUTH_SEEKER_RUN064_REPORT.md:54-60`). But compile-path code still exposes and consumes direct open/pending counts through helper functions outside the portfolio owner (`mt5/artifacts/ASC_ArtifactTextHelpers.mqh:527-582`). Those direct counts are then reused inside Dossier, Market Board, and shortlist-related logic (`mt5/artifacts/dossier/ASC_DossierComposer.mqh:3282-3284`; `mt5/artifacts/ASC_MarketBoardWriter.mqh:1274`; `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh:1473`). That means active exposure truth is still duplicated.

### Market Board as a hidden authority surface

Market Board repeatedly tries to police its own scope. It says the selected-symbol deep path is support-only and cannot override the board role (`mt5/artifacts/ASC_MarketBoardWriter.mqh:1297`, `1877`, `2548-2549`). That is good. But the same file also computes action-shaped summaries such as “top overall candidate”, “overall backup candidate”, “first-pick workflow”, and “do not pick” reasons (`mt5/artifacts/ASC_MarketBoardWriter.mqh:521-579`). This does not make Market Board a literal ranking owner, but it does make it a **secondary interpretive authority surface**. That is precisely the kind of drift a contradiction checker should catch later.

### Dossier remains canonical, but not perfectly passive

Dossier is still the strongest canonical selected-symbol surface. It consumes shortlist rows directly from L4 (`mt5/artifacts/dossier/ASC_DossierComposer.mqh:3244-3253`) and includes L3/L4 only when the ordinary path is visible or when a selected-symbol deep override is active (`mt5/artifacts/dossier/ASC_DossierComposer.mqh:3255-3261`). It also carries explicit L5 falsehood boundaries, including `trade_permission=false` and `entry_signal=false` (`mt5/artifacts/dossier/ASC_DossierComposer.mqh:1562`), and it explicitly tells the operator that shortlist rank/score fields are priority-ordering support only, not trade permission, not entry signal, and not final execution decision (`mt5/artifacts/dossier/ASC_DossierComposer.mqh:4118-4119`).

The weakness is that Dossier also computes summary-level “primary opportunity”, “primary constraint”, and one-line interpretation logic from mixed upstream fields. That is still within the repo’s own “artifact-only notes derived from owner-backed truth” doctrine, but it is close enough to hidden compute that it needs explicit invariant coverage later.

### Current Focus is mostly clean

Current Focus remains one of the cleaner areas. The active roadmap log clearly says it resolves through the root dossier derivative path, not a new artifact family (`TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md:1267-1269`). `ASC_CurrentFocusWriter.mqh` is mostly a **canonical-symbol matcher, protected completed-deep reader, and downgrade blocker** (`mt5/artifacts/ASC_CurrentFocusWriter.mqh:47-96`, `157-178`, `210-270`). That is the right shape for a mirror surface. I did **not** find evidence in this pass that Current Focus is inventing separate L3/L4/L5 truth.

### Hidden compute table

| File/function | Possible hidden computation | Should own truth? | Risk | Future fix |
|---|---|---:|---|---|
| `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` — `ASC_CountOpenPositionsForSymbol`, `ASC_CountPendingOrdersForSymbol`, `ASC_OpenPendingConflictValue` | Direct live exposure truth outside portfolio owner | No | **High** | Route all exposure truth through portfolio snapshot accessors/revisioned snapshot |
| `mt5/artifacts/ASC_MarketBoardWriter.mqh` — `ASC_BoardSelectionSummaryCompact` | Candidate-type and first-pick style summary from L4 + exposure + freshness | No | **High** | Replace freeform synthesis with owner-token-based wording |
| `mt5/artifacts/ASC_MarketBoardWriter.mqh` — `ASC_BoardDoNotPickReason` | Negative authority summary built in writer | No | **High** | Move any blocking/admission reason to L4 or portfolio owner tokens |
| `mt5/artifacts/ASC_MarketBoardWriter.mqh` — `ASC_BoardDisplayRankForScope` | Scope-relative display rank selection | Projection only | Medium | Stamp source-rank and display-rank separately |
| `mt5/artifacts/dossier/ASC_DossierComposer.mqh` — primary opportunity/constraint/summary logic | Mixed-layer interpretation from L1-L5 | No, except artifact-only note synthesis | Medium | Bind summaries to explicit upstream tokens and revision IDs |
| `mt5/artifacts/dossier/ASC_DossierComposer.mqh` — direct `ASC_OpenPendingConflictValue` use | Duplicate exposure owner path | No | **High** | Replace with portfolio-snapshot-derived symbol exposure view |
| `mt5/artifacts/ASC_CurrentFocusWriter.mqh` — visible section richness and downgrade blocker | Payload authority/readback guard, not business truth | Partly yes for mirror integrity, no for market truth | Low | Keep, but add revision-based selected-symbol invariant later |
| `mt5/artifacts/dossier/ASC_DossierComposer.mqh` — hydration class generation | Derived availability classification from owner state | Yes, as artifact integrity classification | Low | Keep, but explicitly mark it as artifact-integrity-only |

### Cross-artifact contradiction table

| Contradiction type | Surfaces affected | Current detection | Missing detection | Future fix |
|---|---|---|---|---|
| Exposure counts from direct helper path vs snapshot path | Dossier, Market Board, L4 summaries, portfolio section | None | Revisioned equality check | Add single exposure revision and compare all consuming surfaces |
| Selected symbol vs mirrored payload mismatch | Dispatcher, Dossier, Current Focus | Partial in Current Focus readback/match logic | Full dispatcher-to-surface invariant log | Add selected-symbol revision token and surface compare |
| Rank/score meaning drift into action authority | Dossier, Market Board, Current Focus mirror | Advisory constants/tokens only | Surface-level contradiction scan | Add aggregate contradiction summary block |
| Deep-analysis overclaim | Dossier, Current Focus, board commentary | Dossier placeholder/completed token checks | Cross-surface L5 meaning scan | Add L5 contradiction evaluator |
| Source-supported line read as runtime-observed truth | Market Board, FunctionResults, manifest | Partial wording controls | Unified proof-scope normaliser | Unify artifact proof token schema |
| Retained/current confusion | Dossier, Current Focus, Market Board, GlobalTop10 | Helper vocabulary exists | Cross-surface retained-current mismatch detection | Add retained-vs-current contradiction check |
| Current/archive confusion | GlobalTop10 current, archive, staging, manifests | Family semantics exist | Owner-map-level detector | Add family-role invariant checker |
| Unavailable/partial shown as clean | Any artifact section | Local wording in owners | Global contradiction roll-up | Add contradiction categories to manifest and aggregate logs |
| Board authority text outruns L4 owner truth | Market Board vs Dossier vs shortlist owner | None beyond prose | L4-to-board authority alignment check | Emit board-authority-source token from L4 owner |
| Portfolio history context leaking into blockers | Board, Dossier, shortlist/exposure narratives | Portfolio owner labels this well | No check on downstream consumers | Add history-context-only contradiction category |

### Report contradiction table

| Report/control context | Claim | Contradicting evidence | Severity | Recommendation |
|---|---|---|---|---|
| `TRUTH_SEEKER_RUN064_REPORT.md:54-60` | Canonical open/pending portfolio owner exists; preserve no duplicate owner | Direct exposure helpers still exist and are consumed outside portfolio owner (`ASC_ArtifactTextHelpers.mqh:527-582`; `ASC_DossierComposer.mqh:3282-3284`; `ASC_MarketBoardWriter.mqh:1274`; `ASC_ShortlistSelectionEngine.mqh:1473`) | **High** | Reclassify repo status from “clean owner” to “duplicate-owner debt still present” |
| `TRUTH_SEEKER_RUN067R_REPORT.md:66`, `104-110`, `141` | Shared fields have owner/projection vocabulary; writers should not recompute or own truth | Market Board still synthesises candidate/actionability narratives (`ASC_MarketBoardWriter.mqh:521-579`) | Medium | Treat current state as “projection-plus-interpretation”, not “pure projection” |
| `TRUTH_SEEKER_RUN069R_REPORT.md:165-167` | Market Board is consumer-only/read-only | Board is read-only for rank inputs but not neutral in meaning output; it generates decision-shaped summaries | Medium | Narrow wording: “consumer of rank inputs, but still interpretive compression surface” |
| `TRUTH_SEEKER_RUN070R_REPORT.md:75`, `214-216`, `345-348` | Dossier validates L5 owner tokens; Current Focus is protected mirror | Source largely agrees | Low | Keep this claim; it is one of the cleaner areas |
| `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md:1267-1269` | Current Focus is root-dossier derivative, not separate family by default | Source agrees: mirror/match/protected readback logic, contract target path, no separate truth engine found | Low | Keep this claim, but keep operator wording explicit to avoid artifact-path confusion |

## Proof semantics and falsehood boundaries

### Layer meaning risks

L3, L4, and L5 all now defend their semantic boundaries much better than older runs suggested. L3 says candidate ranking support only (`ASC_SelectionFilter.mqh:997-1003`), stamps falsehood boundaries (`1006-1013`), and projects to downstream consumers without claiming trade permission (`1087-1127`). L4 says shortlist priority ordering only and explicitly encodes `trade_permission=false`, `entry_signal=false`, `l4_not_deep_analysis=true`, and `l5_not_implied_by_rank=true` (`ASC_ShortlistSelectionEngine.mqh:255-310`, `510-535`). L5 says deep selected-symbol analysis only, not Market Board truth owner, not GlobalTop10 truth owner, not complete evidence, and not fresh just because it is built (`ASC_DeepSelectiveAnalysisEngine.mqh:529-535`).

The risk is not the owner layers now. The risk is the **artifact compression layers**. If an operator reads only the board or only a dossier summary line, the narrative can still feel more decisive than the actual owner semantics. The repo has much better falsehood tokens than before, but the contradiction system is still mostly a vocabulary layer, not an implemented cross-surface checker.

### Source-supported and runtime-observed semantics

This area is **partly clean and partly confusing**.

Inside owner layers, the semantics are mostly coherent. Portfolio aggregate proof tokens dynamically emit `runtime_observed` and `source_supported=true` (`mt5/portfolio/ASC_PortfolioExposureSnapshot.mqh:712`). The L5 owner explicitly encodes `source_supported_not_runtime_observed=source_patched_live_unproven` (`mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh:533`). That is honest.

The confusion appears when a live artifact embeds a **source contract line** that still says `runtime_observed=false`. Market Board does exactly that in its body metadata and alignment line (`mt5/artifacts/ASC_MarketBoardWriter.mqh:967`, `997`, `2387`, `2644-2649`). That can be defensible if read as “this specific embedded line is not the runtime publish outcome source”, but it is still easy to misread because it sits inside a live file.

### Layer meaning table

| Layer/domain | Output meaning | What it must not imply | Current source evidence | Weakness |
|---|---|---|---|---|
| L1 Market State | Open/closed/uncertain/stale state and cadence | Not shortlist, not execution permission | `ASC_MarketStateEngine.mqh:33-57`, `127-171`, cadence/recheck helpers | Low |
| L2 Open Symbol Snapshot | Live/support packet, freshness, quote/spec context | Not selection authority, not deep analysis | `ASC_OpenSymbolSnapshotEngine.mqh:25-196`, `531-578`, `625-712` | Low |
| L3 Candidate Filtering | Candidate ranking support | Not trade permission, not entry signal, not final rank | `ASC_SelectionFilter.mqh:997-1127` | Low in owner; medium in consumer surfaces |
| L4 Shortlist Selection | Priority ordering support and board admission context | Not deep analysis, not entry signal, not final trade decision | `ASC_ShortlistSelectionEngine.mqh:255-310`, `510-535` | Medium because board narratives can feel stronger |
| L5 Deep Selective Analysis | Selected-symbol depth/support only | Not board authority, not GlobalTop10 authority, not complete evidence | `ASC_DeepSelectiveAnalysisEngine.mqh:529-535` | Low in owner; medium in summary surfaces |
| Market Board | Compact board summary and ordinary-board baseline | Must not silently become rank owner or L5 owner | `ASC_MarketBoardWriter.mqh:521-579`, `1297`, `1877`, `2548-2549` | **High** interpretive risk |
| Dossier | Canonical selected-symbol artifact | Must not imply L4 rank equals permission or L5 equals execution readiness | `ASC_DossierComposer.mqh:1562`, `4118-4119` | Medium |
| Current Focus | Derivative selected-symbol convenience mirror | Must not become a competing truth owner | `ASC_CurrentFocusWriter.mqh:157-178`, `210-270` | Low |
| Portfolio/history | Exposure and recent history context | Closed history must not become active blocker | `ASC_PortfolioExposureSnapshot.mqh:351`, `368`, `798-809`, `853`, `954` | Low in owner, medium in downstream duplicate-count usage |

### Source_supported / runtime_observed table

| Surface/token | Current use | Clear/misleading | Risk | Future fix |
|---|---|---|---|---|
| Market Board body metadata | `source_supported=true`, `runtime_observed=false` in live file body | Partial / potentially misleading | Medium | Rename as `embedded_source_contract_*` only and keep runtime outcome elsewhere |
| Market Board alignment line | Also says `runtime_observed=false` inside live artifact | Partial / potentially misleading | Medium | Use separate `contract_scope` vs `artifact_runtime_scope` schema |
| Portfolio aggregate proof tokens | Dynamic runtime observation signal based on snapshot status | Clear | Low | Keep; use as canonical exposure proof model |
| L3 owner proof tokens | Support-only, projection-only, explicit falsehoods | Clear | Low | Keep |
| L4 owner proof tokens | Support-only, no-trade/no-entry, no-deep | Clear | Low | Keep |
| L5 owner proof tokens | Selected-symbol-only, not board, not GlobalTop10, not complete evidence | Clear | Low | Keep |
| Current Focus runtime posture | Roadmap classifies selected-symbol mirror as source-supported/runtime-unobserved when no selected symbol | Clear enough | Low | Keep, but emit selected-symbol revision later |
| GlobalTop10 current/archive posture | Family semantics exist; current/archive/staging are separated in reports and helper vocabulary | Partial | Medium | Add single compile-path family-role invariant emitter |

### Trade permission falsehood table

| Surface | Has trade_permission=false? | Has entry_signal=false? | Missing risk | Future fix |
|---|---:|---:|---|---|
| L3 owner (`ASC_SelectionFilter`) | Yes | Yes | Low | Keep as canonical source |
| L4 owner (`ASC_ShortlistSelectionEngine`) | Yes | Yes | Low | Keep as canonical source |
| L5 owner (`ASC_DeepSelectiveAnalysisEngine`) | Yes | Yes | Low | Keep as canonical source |
| Dossier L5 section | Yes | Yes | Low | Keep |
| Dossier L4 prose surface | Yes in meaning/prose, but machine-token uniformity is not as obvious in this pass | Partial | Medium | Surface owner tokens more directly in dossier section |
| Market Board artifact-level lines | Yes | Yes | Medium because board wording still sounds action-shaped | Medium | Tie all board action text to owner tokens |
| Current Focus | Inherits from mirrored payload rather than owning independent falsehood tokens | Partial | Medium | Add explicit mirror-boundary token on publish |
| FunctionResults | Not fully audited for this specific falsehood pair in this pass | Unknown | Medium | Audit in next report or dedicated contradiction/logger run |

### Portfolio/history semantics table

| Concept | Correct meaning | Current source evidence | Risk | Future fix |
|---|---|---|---|---|
| Open positions | Active exposure | `ASC_PortfolioExposureSnapshot.mqh:656-662`, `814` | Low in owner | Keep |
| Pending orders | Future exposure | `ASC_PortfolioExposureSnapshot.mqh:656-662`, `834` | Low in owner | Keep |
| Recent closed trades | History context only | `ASC_PortfolioExposureSnapshot.mqh:351`, `408`, `853`, `954` | Low in owner | Keep |
| HistorySelect failure | Unavailable, not zero | `ASC_PortfolioExposureSnapshot.mqh:364-368` | Low in owner | Keep |
| Same-symbol exposure summary | Blocks on active exposure, not historical context | `ASC_PortfolioExposureSnapshot.mqh:798-809` | Low in owner | Keep |
| Downstream symbol exposure counts | Often bypass portfolio owner through direct helper counts | `ASC_ArtifactTextHelpers.mqh:527-582`; consumer call sites above | **High** | Consolidate into portfolio snapshot |

### Contradiction category backlog table

| Category | Why needed | Source owner candidate | Artifact impact | Priority |
|---|---|---|---|---|
| Exposure snapshot vs direct-count drift | Biggest real duplicate-owner seam | Portfolio owner + artifact consumers | Board, Dossier, L4 | **High** |
| Current Focus vs Dossier symbol mismatch | Mirror surface must not drift | Dispatcher + Current Focus guard | Dossier, Current Focus | **High** |
| Current Focus vs dispatcher selected revision mismatch | Selected-symbol ownership needs revision proof | Dispatcher | Current Focus, Dossier | **High** |
| Board action text outruns L4 owner truth | Prevent hidden authority drift | L4 owner + Board | Market Board | **High** |
| L4 rank visible without falsehood context | Rank misread risk | L4 owner + Dossier/Board consumers | Dossier, Board, Focus | **High** |
| L5 completed section overclaims freshness/support | Deep section is easily over-read | L5 owner + dossier validator | Dossier, Focus | **High** |
| Retained-last-good shown as current | Freshness/continuity confusion | Artifact family owner | All artifacts | High |
| Current vs archive confusion | Family-role ambiguity | Family/publication owner | GlobalTop10, Dossier families | High |
| Source-supported shown as runtime-observed | Proof-boundary confusion | FunctionResults + artifact metadata | Board, manifests, logs | High |
| Partial/unavailable shown as clean | Trust-purity risk | All owners + contradiction aggregator | All artifacts | High |

## Future source fixes

### Top 20 future source fixes

1. **Delete duplicate exposure ownership at the call-site level.** Replace all `ASC_OpenPendingConflictValue(...)` consumers with snapshot-derived accessors from `ASC_PortfolioExposureSnapshot`.
2. **Make portfolio snapshot the only exposure revision authority.** Every consuming artifact should reference a single snapshot revision/timestamp.
3. **Stop Market Board from generating unowned actionability language.** Move “top overall candidate”, “first-pick”, and “do not pick” reasoning onto owner-token-backed phrasing.
4. **Emit explicit L4 authority-source tokens for board wording.** Let the board quote L4 authority, not infer it.
5. **Emit a dispatcher-owned selected-symbol revision token.** Dossier and Current Focus should both publish it.
6. **Make Current Focus publish an explicit mirror-boundary token on every selected-symbol payload.**
7. **Normalise projection taxonomy.** Today the repo mixes `projection_only`, `consumer_only`, `mirror_only`, and `qualified`. Choose one coherent hierarchy and use it everywhere.
8. **Normalise proof taxonomy inside live artifacts.** Separate `embedded_source_contract` from `artifact_runtime_observation` in a machine-readable way.
9. **Give Dossier a direct “owner source bundle” block.** Instead of recomputing summaries loosely, bind them to L3/L4/L5 owner token bundles.
10. **Pull exposure summaries out of generic artifact helpers.** Generic helpers should format only, not query broker state directly.
11. **Create a compile-path ownership index.** One file should map every truth domain to one owner and list all lawful consumers.
12. **Add a contradiction aggregator that is advisory-only and aggregate-only.** Do not add per-symbol spam to FunctionResults.
13. **Add a selected-symbol family invariant.** Root Dossier, Current Focus, and selected deep path should all cross-check canonical symbol and selected-symbol revision.
14. **Add a GlobalTop10 family-role invariant.** Current, staging, preserved, and archive should be machine-checked, not only described.
15. **Make board and dossier expose the exact exposure source path used.** If counts came from snapshot or direct live query, say so until duplication is removed.
16. **Add retained/current freshness contracts to all major artifact families.**
17. **Bind one-line summaries to contradiction-safe templates.** The summary layer is where truth drift is most likely to become operator-facing.
18. **Move any remaining “why not higher / why not pick” logic as close as possible to owner layers.**
19. **Create static greps/checks for required falsehood tokens and projection tokens.**
20. **Add a low-cardinality “cross-artifact alignment state” block backed by real checks, not just vocabulary.**

### Top 20 contradiction categories to implement later

1. `exposure_snapshot_vs_direct_count_drift`
2. `current_focus_vs_dossier_symbol_mismatch`
3. `current_focus_vs_dispatcher_selected_revision_mismatch`
4. `market_board_action_text_vs_l4_owner_mismatch`
5. `market_board_vs_dossier_rank_context_mismatch`
6. `market_board_vs_dossier_exposure_context_mismatch`
7. `selected_symbol_deep_path_vs_board_authority_overclaim`
8. `l4_rank_visible_without_falsehood_context`
9. `l3_support_visible_as_trade_permission`
10. `l5_completed_visible_as_complete_evidence`
11. `l5_built_visible_as_fresh`
12. `retained_last_good_presented_as_current`
13. `archive_presented_as_current_family`
14. `source_supported_presented_as_runtime_observed`
15. `pre_patch_live_proven_post_patch_unproven_presented_as_clean`
16. `partial_or_unavailable_presented_as_clean_truth`
17. `globaltop10_current_vs_archive_confusion`
18. `portfolio_history_vs_active_exposure_confusion`
19. `canonical_symbol_mismatch_across_surfaces`
20. `projection_taxonomy_mismatch_across_surfaces`

## Report 4 handoff

The next audit should start with the **real duplicate-owner seam**, not with more wording review.

Inspect these first:

1. `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` — especially `ASC_CountOpenPositionsForSymbol`, `ASC_CountPendingOrdersForSymbol`, and `ASC_OpenPendingConflictValue`.
2. `mt5/portfolio/ASC_PortfolioExposureSnapshot.mqh` — confirm what the canonical exposure owner already provides and what downstream consumers still bypass.
3. `mt5/artifacts/ASC_MarketBoardWriter.mqh` — trace every place where board narrative is computed from L4 plus exposure counts.
4. `mt5/artifacts/dossier/ASC_DossierComposer.mqh` — trace selected-symbol exposure logic, one-line summary construction, and any direct broker-state or duplicate-count use.
5. `mt5/artifacts/ASC_CurrentFocusWriter.mqh` — verify it remains a mirror/guard and does not pick up new ownership after later patches.
6. `mt5/runtime/ASC_Dispatcher.mqh` — map the selected-symbol revision path, Current Focus publish path, and any place a revision token could be attached.
7. `TRUTH_SEEKER_RUN064_REPORT.md`, `TRUTH_SEEKER_RUN065R_REPORT.md`, `TRUTH_SEEKER_RUN067R_REPORT.md`, `TRUTH_SEEKER_RUN068R_REPORT.md`, `TRUTH_SEEKER_RUN069R_REPORT.md`, and `TRUTH_SEEKER_RUN070R_REPORT.md` — use them to separate “clean source owner”, “clean vocabulary only”, and “still duplicated in compile path”.

The priority question for Report 4 should be:

**Can the repo remove duplicate exposure ownership and add real cross-artifact contradiction detection without breaking publication safety, FunctionResults log budget, GlobalTop10, or selected-symbol continuity?**

### Open questions and limitations

This pass was strongest on the compile-path owner files and Truth Seeker reports named above. It did **not** exhaustively line-audit the full `mt5/hud/` tree, and it did **not** claim compile or runtime proof. The live-proof posture remains whatever the repo’s own reports already classify: RUN065R pre-patch evidence for Market Board/portfolio/GlobalTop10, and source-only truth-purity patches for RUN067R-RUN070R.