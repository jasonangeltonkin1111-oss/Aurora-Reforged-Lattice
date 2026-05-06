# Aurora Truth Seeker Edge Truth Audit

## Executive summary

This audit treats the latest uploaded Aurora Sentinel Core zip as the system of record and focuses on L3 Candidate Filtering, L4 Shortlist Selection, L5 Deep Selective Analysis, and the existence or absence of a real L6 final-interpretation owner. The strongest conclusion is that the codebase is now **materially more honest about its own limits than its earlier architecture likely was**. Across L3, L4, L5, Dossier, Market Board, Current Focus, and the Truth Seeker run reports, the source repeatedly encodes `trade_permission=false`, `entry_signal=false`, `execution_permission=false`, `final_trade_decision=false`, and `strategy_edge_proof=false`. That is good systems hygiene, and it aligns with what the external benchmark demands: partial data must stay partial, out-of-sample robustness matters more than elegant in-sample heuristics, transaction costs and correlation shifts can erase paper edge, and multi-timeframe data must not be treated as complete just because it is rich or verbose. Using official entity["company","MetaQuotes","mt5 vendor"] MQL5 documentation and validation literature surfaced via entity["organization","SSRN","research repository"] and entity["organization","PLOS","open access publisher"] as the benchmark, the architecture currently passes the **honesty** test better than it passes the **validated edge** test. citeturn9search0turn9search2turn9search1turn9search5turn10search0turn10search1turn8search9turn8search4turn7search12turn6search2turn8search0turn6search1turn6search12

The practical verdict is straightforward. **L3 is a heuristic opportunity filter**, not a trade signal. **L4 is a diversification-aware priority and queueing layer**, not a final decision-maker. **L5 is a selected-symbol context expander and scenario narrator**, not empirical proof of edge. **L6 exists, but only as a composer-side derived replay / handoff surface built from L5 truth**, not as an independently accountable runtime owner that statistically validates or authorises a trade. The system therefore has decent “truth-language discipline” but still carries major “edge-proof debt”. What it knows how to do is *describe*, *rank*, *defer*, and *bound*. What it does **not** yet know how to do is demonstrate that its weighted heuristics survive walk-forward validation, data-snooping controls, realistic cost modelling, and regime instability. citeturn8search9turn8search1turn8search4turn7search1turn7search8turn6search2turn8search0turn6search1turn6search9

The most important high-confidence findings are these:

- **L3 can pass with “score-led penalty carry” even when support is weaker than ideal.** That is honest in wording, but it means a pass state is not a clean-state guarantee.
- **L4 adds real structure** through overall-board score, correlation penalties, bucket penalties, exposure penalties, and deep-request priority. That is better than a raw L3 sort, but it is still a heuristic blend, not a validated strategy layer.
- **L5 has the best support taxonomy in the system.** It explicitly records requested vs copied bars/ticks, partial vs complete, historical-only vs live, fresh vs stale, and resolver limits.
- **L6 is present but not autonomous.** It is produced inside `ASC_DossierComposer.mqh` by replaying L5 output into a bounded interpretive surface. It does not exist as a separate runtime owner with its own empirical acceptance standards.

Deep Research Reports 1–3 were not present under those exact names in the zip. The operationally relevant chain inside the repository is the Truth Seeker report lineage around RUN067R–RUN072R, which already documents and reinforces the source’s “support-only / no-live-proof / source-patched-live-unproven” posture.

## External benchmark and source baseline

The external benchmark used in this audit becomes four source-control questions.

First, does the code clearly separate **availability**, **freshness**, and **completeness**? The answer matters because MQL5’s own interfaces do not guarantee complete data on every call. `CopyRates()` can return a partial count or `-1`; `CopyTicks()` can return available ticks while synchronization continues; `SymbolInfoTick()` and `SymbolInfoDouble()` are point-in-time lookups; `PositionsTotal()`, `OrdersTotal()`, and `HistorySelect()` are three different domains and should not be collapsed into one “exposure” idea. The source mostly respects this distinction, especially in L5 and portfolio/history surfaces. citeturn9search2turn9search0turn9search1turn9search7turn9search5turn10search0turn10search1

Second, does the code confuse a useful heuristic with a validated edge? The literature says that if a trading system has not survived out-of-sample checks, walk-forward evaluation, and data-snooping controls, its apparent edge can be fragile or entirely false. Window choice itself materially changes results, and technical-rule findings can weaken or disappear once White-style reality checks and related corrections are applied. Aurora’s source does **not** yet own this proof burden anywhere. The reports acknowledge that; the code does not solve it. citeturn8search9turn7search1turn7search8turn8search1turn8search4turn8search9

Third, does the system model execution reality strongly enough? Spread, slippage, floating-vs-fixed spread behaviour, and transaction costs can turn a paper edge into a live loss. Aurora currently uses spread, spread-to-ATR, friction quality, and trade-mode/specification gates. That is directionally sensible, but it is still a thin execution-realism layer compared with the cost modelling demanded by robust strategy validation. citeturn6search2turn8search0turn6search9

Fourth, does the system treat diversification and regime risk honestly? Research on regime detection and spillovers shows that correlation structures and covariance regimes change; diversification weakens when stress is rising. Aurora’s L4 correlation view is shortlist-local and useful, but it is not yet a full regime-aware portfolio correlation owner. citeturn6search1turn6search11turn6search12

Against that benchmark, the present source is **truthful in language, partial in empirical grounding, and still unproven in edge**.

## What L3, L4, L5, and L6 really do

### What L3 really does

L3 lives primarily in `mt5/candidate_filtering/ASC_SelectionFilter.mqh`. The core evaluation path is `ASC_SelectionFilterEvaluate()` around lines 2332–2560, with score-pack construction around lines 1895–2009 and carry logic around lines 2133–2265.

In plain terms, L3 does **three things**. It checks basic admissibility gates, it synthesises a weighted score pack, and it decides whether the symbol should be treated as a clean candidate, a guarded carry, or a blocked/pending case. The gate stack is coherent: open market state, resolved classification, fresh L1/L2 status, live or lawful corroboration, quote freshness, trade mode, specification readiness, post-warmup hydration, spread cap, and market-state confidence. That is a real filter, not just a score board.

But L3 then deliberately allows a second mode: **scoring-first carry**. If the symbol is not clean enough for a pure pass, it can still become `ASC_SELECTION_FILTER_RESULT_PASS` with reason code `score_led_penalty_carry`. That means L3 is not “hard pass or fail”; it is “pass cleanly, pass with drag, or stay pending/blocked”. This is not hidden. The source says so. That improves honesty, but it also means downstream consumers must not read `PASS` as “ready to trade”.

The score pack is a handcrafted weighted blend. `context_strength_score`, `execution_alignment_score`, `entry_readiness_score`, `risk_drag_score`, `opportunity_density_score`, `score_gross`, and `score_net` are all built from subcomponents that use neutral defaults, threshold bands, and weighted arithmetic. There is nothing pathological about that. Many scanner architectures start exactly this way. The weakness is not that the math is heuristic. The weakness is that the repository carries **no empirical owner** that proves those weights discriminate true opportunity better than nearby alternatives, or that they stay robust after costs, regime change, and walk-forward validation. That is precisely the kind of overconfidence risk the validation literature warns about. citeturn8search9turn8search4turn7search12

#### L3 Candidate Filter Audit

| Element | Current source behavior | Truth meaning | Weakness | Future fix |
|---|---|---|---|---|
| Gate stack | Requires open L1 state, resolved classification, lawful L2 corroboration, acceptable freshness, tradability, specification, spread cap, confidence | “Candidate intake is lawful enough to be *considered*” | Gate satisfaction is still intake truth, not strategy proof | Add post-research validation owner that scores gate predictive value by family / market bucket |
| Score pack | Builds price, microstructure, volatility, structure, session, execution, and risk scores into `score_net` | Heuristic candidate-quality summary | No empirical calibration owner; weights are source-rational, not validated | Add offline score attribution and walk-forward rank-stability study |
| Carry logic | `score_led_penalty_carry` can still return PASS with penalties | Best-available reserve carry | PASS can be misread as clean readiness | Split pass states more sharply in downstream displays |
| Freshness / dependency tokens | Rich tokens for freshness, authority source, dependency status, recovery state, metric validity | Good truth hygiene | Tokens are descriptive only; no historical conversion tracking | Add evidence ledger correlating token states with later shortlist / deep outcomes |
| Tradability handling | Full trade mode helps ranking; restricted mode degrades rather than invents new veto lane | Opportunity support, not deployability | “Trade mode full” is not fill realism, slippage realism, or alpha | Add execution-realism surface outside L3 |
| Risk / opportunity blending | `opportunity_density_score` and `risk_drag_score` coexist | Better than raw momentum-only ranking | Risk drag still excludes fees, slippage, market impact, queue position | Add cost-aware and venue-aware drag components after research |
| Falsehood boundary | Emits `trade_permission=false`, `entry_signal=false`, `strategy_edge_proof=false` | Strong anti-overclaim contract | Consumer could still ignore the tokens | Enforce explicit display of falsehood boundary wherever L3 is surfaced |
| Sample / intake status | Distinguishes clean, non-clean, unavailable, stale, dependency-blocked | Honest intake semantics | Neutral defaults can make sparse support look numerically smoother than it is | Add stronger “numeric carry withheld” posture in all consumers |

### What L4 really does

L4 lives in `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh`, with supporting ATR, regime, and liquidity/friction summary engines. It is not a thin sorter. It is a substantial **priority-routing layer**.

The first L4 blend is `ASC_ShortlistCompositePriorityScore()` around lines 1007–1040. It takes an L3 spine score, a context score, stability bias, cleanliness, session fit, and asset execution penalty, then adjusts them with L3 subfields such as execution alignment, entry readiness, session alignment, risk drag, and late-move risk. After that, L4 adds a second and more important layer: `ASC_ShortlistOverallAdmissionScore()` around lines 1412–1483 and the diversified overall-board build around lines 1577–1680. This is where Aurora stops being a pure one-symbol ranker and becomes a **competitive shortlist allocator**. L4 subtracts correlation pressure, bucket concentration, sub-bucket concentration, and active/pending exposure conflicts. That is materially more useful than a simple descending score list.

This is one of the cleaner architectural areas. The source is honest about L4 meaning. The run reports from RUN069R onward reinforce that L4 is “ranking support only”, and the file itself finalises `trade_permission_token = "false"` and `entry_signal_token = "false"` while explicitly tagging correlation and exposure status. It also correctly separates `closed_history_not_active_exposure=true`, `open_positions_are_active_exposure=true`, and `pending_orders_are_future_exposure=true`.

The weakness is not conceptual. The weakness is **scope**. Correlation is calculated within the shortlist context, not across the wider universe or regime-conditioned factor structure. Bucket diversification is useful, but bucket diversity is not the same thing as crisis diversification. The literature on regime detection and spillovers strongly suggests that covariance structure changes across regimes, which means a local shortlist correlation view can look cleaner than the real risk field. citeturn6search1turn6search11turn6search12

L4 also owns `deep_request_priority_score` around lines 2250–2334. That is important. It does **not** mean “best trade”; it means “best immediate candidate for deep review”. The source treats it that way. That is a good separation of opportunity from attention.

#### L4 Shortlist Audit

| Element | Current source behavior | Truth meaning | Weakness | Future fix |
|---|---|---|---|---|
| Composite priority | Blends L3 score, context, stability, cleanliness, session fit, and asset penalties | Priority for shortlist ordering | Still a handcrafted blend with no calibration owner | Add out-of-sample rank-quality audit |
| Overall board admission | Re-ranks with quality adjust, correlation penalty, bucket penalty, and exposure conflict penalty | Diversified shortlist / board support | Correlation scope is shortlist-local | Add wider peer-set and stress-regime correlation pass |
| Tie-breakers | Uses near-tie delta, execution tie score, L3 score, context, attention posture, spread, packet age | Deterministic rank stabilisation | Tie logic may still encode incidental preferences without evidence | Add tie-break sensitivity audit |
| Correlation summary | Builds “true-correlation summary” across shortlist peers only | Useful crowding signal | Not whole-universe, not factor, not regime-switch aware | Add regime-conditioned alternative and stress-correlation view |
| Exposure tokens | Distinguishes clean / limited / unknown exposure and active vs future vs history | Strong semantic hygiene | Account-local exposure is not full portfolio-factor risk | Add factor / cluster exposure lens later |
| Deep request priority | Scores symbols for L5 attention queue | Review urgency, not execution urgency | Easy to misread as conviction | Rename or hard-label as review-priority everywhere |
| Rank reasons | Produces rank reason, reason summary, and attention posture | Explainable shortlist output | Reasons are narrative heuristics, not causal proof | Add evidence-class tags inside reason strings |
| Falsehood boundary | Final tokens remain `trade_permission=false`, `entry_signal=false` | Good anti-overclaim rule | Needs hard carry into all artefacts | Add consumer-side verifier for L4 boundary tokens |

### What L5 really does

L5 lives in `mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh`. It is the richest source of tactical and structural detail in the system, and it is where most readers are most likely to overread confidence.

L5 begins with an **entitlement gate** in `ASC_BuildDeepSelectiveAnalysisResult()` around lines 1816–1867. If the selected symbol is not entitled, the build stops. If entitlement passes, L5 collects point-in-time packet context, then pulls deeper market support using `CopyTicks()` and `CopyRates()` for enabled timeframes. The engine tracks `rates_requested`, `rates_copied`, `ticks_requested`, `ticks_copied`, `timeframe_coverage`, `sample_status`, `sample_window_age`, `partial_timeframe_reason`, `unavailable_timeframe_reason`, `support_posture`, `l5_support_posture`, `resolver_limit`, and `artifact_projection`. This is the most mature proof-boundary vocabulary in the codebase.

That vocabulary matters because MQL5 itself does not turn data requests into proof of completeness. `CopyTicks()` can return the ticks currently available while synchronization continues, and `CopyRates()` can return fewer bars than requested or `-1`. Aurora’s L5 does **not** hide that. It surfaces partial support and historical-only support explicitly. That is one of the strongest areas in the repo. citeturn9search0turn9search2

What L5 adds analytically is not order logic. It adds **selected-symbol depth context**: microstructure posture, breadth of timeframe alignment, directional split counts, expansion vs compression split counts, move freshness, invalidation and confidence-break narratives, SIAM setup-fit summaries, and path contest language. That can be very useful for operator review.

The weakness is twofold.

The first weakness is the same one L3 and L4 carry: **no empirical proof owner**. L5 is rich in narrative and bounded in language, but it does not validate whether its path and fit outputs improve realised decision quality after costs, regime shifts, and out-of-sample testing.

The second weakness is **narrative density under partial support**. The engine is careful to mark `fresh_partial_support`, `historical_only_support`, `retained_support`, `degraded_support`, `rates_unavailable`, `ticks_unavailable`, and `sample_insufficient`. That is good. But it still produces highly articulate structure and path narratives under non-full support. A human operator can over-trust a coherent story even when the support posture remains limited. The source itself tries to guard against this by repeating `trade_permission=false`, `strategy_edge_proof=false`, `built_does_not_mean_fresh=true`, and `lawful_does_not_mean_complete_support=true`. The architecture deserves credit for that. The risk remains because the text is compelling. citeturn9search0turn9search2turn8search9turn6search2

#### L5 Deep Analysis Audit

| Element | Current source behavior | Data dependency | Weakness | Future fix |
|---|---|---|---|---|
| Entitlement gate | Deep build only for entitled selected symbol / override context | L1 state, shortlist context, packet availability | Selected-symbol override can still be mistaken for merit | Add explicit “entitled ≠ edge” banner in deep summary |
| Rates collection | Uses `CopyRates()` across enabled timeframes and tracks requested/copied/coverage | Historical bars per timeframe | Partial/missing bars can still yield rich output | Add minimum-effective-sample thresholds per timeframe set |
| Tick collection | Uses `CopyTicks()` and tracks requested/copied/status | Recent tick history | Timeout / sync continuation means partial microstructure can look sufficiently detailed | Add stricter “microstructure_trust ceiling” when copied/requested is short |
| Support posture | Classifies fresh full / fresh partial / historical only / retained / degraded / unavailable | Combined packet + rates + ticks evidence | Excellent taxonomy, but no empirical confidence mapping | Add calibrated confidence classes tied to validation results |
| Tactical summaries | Builds tactical, structure, timing, score-context, microstructure, SIAM fit and path narratives | L2 packet + rates/ticks + shortlist context | Narrative richness can exceed support strength | Hard-cap narrative assertiveness when support is partial |
| SIAM fits | Produces primary / secondary fit, path split, invalidation, confidence-break, vulnerability | Derived from L5 workbench outputs | Fit scores are not proven family-performance edges | Add family anti-habitat test owner before expanding SIAM authority |
| Cost realism | Uses spread quality and spread-to-ATR style friction proxies | Packet spread / ATR / copied spread window | No slippage, no fill quality, no commission ladder, no impact | Add execution realism layer outside L5 |
| Falsehood boundary | Repeats `trade_permission=false`, `entry_signal=false`, `final_trade_decision=false` | N/A | Good source hygiene, but not sufficient by itself | Make consumers fail closed if these boundary tokens disappear |

### Whether L6 exists or is missing

L6 **does exist in source**, but it does **not** exist as a standalone runtime engine or independent truth owner.

The evidence is in `mt5/artifacts/dossier/ASC_DossierComposer.mqh`. `ASC_L6PopulateWorkbenchFromDeepResult()` around lines 851–971 copies L5 deep-result fields into an L6 workbench packet, explicitly notes `source_layer_ref = "L5"` and `source_contract_note = "consumer_only_l6_projection_from_l5"`, then `ASC_DossierBuildLayer6SurfaceBlocks()` around lines 973–1075 builds the L6 surface by composing derived packets such as normalised context, MTF posture, readiness, semi-auto surface, maturity, advanced patterns, and review deltas. The file itself includes hard boundaries such as:

- “Consumer Boundary: Layer 6 remains a bounded replay surface...”
- “Execution Boundary: handoff language is descriptive only...”
- L5 boundary lines preserving `trade_permission=false`, `entry_signal=false`, `final_trade_decision=false`, `strategy_edge_proof=false`.

So L6 is **present**, but present as a **derived composer-side interpretation surface**. It is not an autonomous owner that independently validates edge, owns contradiction resolution at runtime, or grants execution permission. That means the answer to “does L6 exist?” is: **yes as a descriptive surface, no as a final truth authority**.

#### L6 Final Interpretation Gap Table

| Expected function | Exists? | Current source evidence | Gap | Future fix |
|---|---:|---|---|---|
| Bounded L6 replay / handoff surface | yes | `ASC_DossierComposer.mqh` builds L6 blocks from L5-derived packets | None on existence | Preserve boundaries |
| Independent runtime L6 owner | no | L6 is built inside composer from L5 output, not from a dedicated engine | No accountable final owner | If needed later, separate engine after all validation work is done |
| Final trade-decision authority | no | Source repeats `final_trade_decision=false` | Missing by design | Keep missing until proven strategy layer exists |
| Empirical confidence calibrator | no | No file owns probability calibration or confidence-error mapping | Major edge-proof gap | Add offline validation surface before any runtime confidence use |
| Contradiction resolver with veto semantics | partial | L6 can describe contradictions and review deltas | Advisory, not decisive | Keep advisory until contradiction rules are validated |
| Portfolio-aware final interpreter | partial | L4 exposure/correlation feeds exist upstream | No full L6 portfolio/risk owner | Add only after cross-asset concentration audit |
| Walk-forward evidence owner | no | No runtime or roadmap-owned empirical acceptance engine in code | Major gap | Add research-only ledger before any execution semantics |
| Cost-aware final interpreter | no | Spread/friction proxies exist; no slippage/fill model owner | Major gap | Add execution research layer first |

## False assumptions, score meanings, and data-support limits

The source is much better than average at saying what its scores are **not**. That helps. It does not remove the need to state what users could still misread.

### False Assumption Table

| Assumption | Where it appears | Why dangerous | How to falsify |
|---|---|---|---|
| L3 PASS means trade-ready | L3 result state and downstream displays | PASS can still be `score_led_penalty_carry` | Compare clean PASS vs carry PASS against later outcomes |
| L3 `score_net` is edge | Candidate filtering score pack | Weighted heuristic can look precise without being predictive | Walk-forward rank-to-return and rank-to-failure study |
| Clean tradability means deployability | L3 trade-mode/spec checks | Trade mode excludes slippage / fill / latency / queue | Add live execution realism audit |
| Spread cap is enough execution control | L3 spread gate and L5 spread proxies | Floating spreads and slippage can dominate edge | Backtest with floating spread and slippage regimes |
| L4 rank equals best trade | Shortlist rank and overall board rank | It is diversification-aware priority, not permission | Compare rank with realised edge after costs |
| L4 deep priority equals conviction | `deep_request_priority_score` | It is attention routing, not signal certainty | Measure whether high priority truly improves deep-review hit rate |
| Shortlist correlation is full portfolio risk | `ASC_ShortlistBuildCorrelationSummary()` | Correlation is shortlist-local and regime-sensitive | Stress-test against wider universe / crisis periods |
| Bucket diversity equals real diversification | L4 bucket / sub-bucket penalties | Cross-bucket assets can still co-move in stress | Add covariance-regime and factor clustering audit |
| L5 built/lawful means complete support | L5 deep result | Built/lawful still allows partial / historical-only support | Compare built/lawful vs fresh-full support outcomes |
| Multi-timeframe alignment is permission | L5 MTF and SIAM narratives | Alignment is context, not execution authority | Track false positives when alignment is present but support is partial |

### Score and rank meaning table

| Score/rank output | What it means | What it does not mean | Missing proof |
|---|---|---|---|
| L3 `score_net` | Heuristic candidate-support blend | Alpha, expectancy, permission, edge | No walk-forward / OOS owner |
| L3 `opportunity_density_score` | Balance of context, readiness, acceleration, lift, drag | Forecasted return | No realised-return mapping |
| L4 `shortlist_score` | Priority inside shortlist formation | Final trade quality | No calibration against realised trade set |
| L4 `overall_board_score` | Diversified board-support admission score | Safe portfolio inclusion | No crisis-regime diversification study |
| L4 `deep_request_priority_score` | Review urgency for L5 | Conviction or signal probability | No deep-review payoff attribution |
| L5 `support_posture` | Packet and data-support condition | Strategy confidence | No confidence-error table |
| L5 `l5_support_posture` | Fresh/full vs partial/historical/retained/degraded mapping | Completeness of view | No empirical threshold study |
| L5 SIAM primary fit | Best current structural family candidate from deep context | Only valid path or executable setup | No family discrimination evidence owner in code |
| L6 maturity / handoff text | Human-readable derived interpretation | Orders, lot size, TP/SL, permission | No final decision owner |

### Freshness and data-support table

| Data item | Freshness support | Partial/unavailable handling | Weakness | Future fix |
|---|---|---|---|---|
| L1 market state | Open / uncertain / unknown with stale/degraded flags | Pending / guarded outcomes | No external validation of state-quality impact | Add outcome study by L1 posture |
| L2 open-symbol snapshot | Packet freshness, continuity, packet age, trade mode, specs | Continuity / stale / degraded tokens | Point-in-time packet still not fill realism | Add fill/slippage study |
| ATR summary | D1 CopyRates ATR with cache; fallback to day range when needed | `sufficient`, `partial`, `insufficient` | One-bar fallback can be too permissive | Separate fallback token from ATR-ready token |
| L4 correlation summary | Ready / limited / pending / unavailable across shortlist peers | Lawful-peer gating | Shortlist-local scope only | Add broader peer universe |
| L5 rates | Requested / copied / missing / partial / complete | Explicit partial and unavailable reasons | Same numeric thresholds across very different symbols may be weak | Bucket-aware thresholds |
| L5 ticks | Requested / copied / sync status / partial / unavailable | Explicit partial and unavailable reasons | Available ticks by timeout can still read “rich” | Strict trust ceiling under partial tick windows |
| L5 sample status | `sufficient` vs `insufficient` plus window-age reasons | Explicit falsifier tokens | No venue-specific robustness thresholds | Research sample-size policy per symbol class |
| Portfolio / history | Open positions, pending orders, closed history clearly separated | `history_unavailable` explicitly not treated as zero | Consumers may still ignore labels | Hard-check artefact surfaces for these boundary labels |

### L3 Candidate Filter Audit

| Element | Current source behavior | Truth meaning | Weakness | Future fix |
|---|---|---|---|---|
| Evidence intake state | Clean / non-clean / stale-recoverable / dependency-blocked taxonomy | Intake honesty before score use | No predictive evidence on which states still add value later | Add state-to-outcome tracker |
| Candidate bucket | Bucket labels based on classification and support | Routing / grouping support | Bucket labels are descriptive, not edge classes | Add family-habitat evidence later |
| Score pack summary | Emits compact support summary with falsehood tokens | Helpful compressed operator view | Summary may still seduce readers into certainty | Add explicit “heuristic only” lead label |
| Result reason / next step | Produces reasons and next steps | Strong explainability | Reasons are local logic, not empirical diagnosis | Add evidence provenance per reason |
| Tradability labels | `scalp_tradable`, `intraday_tradable` | Surface suitability hints | Can be misread as permission | Rename to `execution_style_fit_hint` later |
| Sample status token | `sufficient`, `partial`, `unavailable` | Honest support level | Numeric scores exist even when support not sufficient | Suppress or visually downgrade numeric carry harder |

### L4 Shortlist Audit

| Element | Current source behavior | Truth meaning | Weakness | Future fix |
|---|---|---|---|---|
| Deep queue | Prioritises high-value candidates for deep review | Attention allocation | Not proof of actionability | Keep queue-only semantics explicit |
| Overall board posture | `selected`, `bucket-top5-only`, `reserve` | Board-facing membership meaning | Membership can be mistaken for alpha tier | Add board meaning banner in artefacts |
| Relative field rank / leader separation / top10 compression | Gives field-relative context | Competitive landscape support | Rich ranking language without outcome validation | Add score-vs-outcome research |
| Correlation status token | `complete`, `partial`, `pending`, `unavailable` | Honest support scope | “Complete” only means complete for shortlist scope | Rename to `shortlist_scope_complete` later |
| Exposure status token | Clean / limited / unknown / not applicable | Active/future exposure hygiene | No factor or macro concentration overlay | Extend portfolio research later |
| Reason builder | Concise narrative reasons | Good explainability | Narrative is not causal evidence | Add confidence / falsifier class in reason text |

### L5 Deep Analysis Audit

| Element | Current source behavior | Data dependency | Weakness | Future fix |
|---|---|---|---|---|
| Support proof tokens | Explicit L5 proof-contract string | Deep result + support posture | Strong source discipline but no runtime validation | Preserve and later measure |
| Coverage status | `full_enough_for_deep_support` vs `partial_but_lawful` | Timeframe, tick, spread, split counts | “Full enough” is still a source heuristic | Empirically test threshold robustness |
| Resolver limit | Distinguishes rates unavailable, ticks unavailable, sample insufficient, timeframe missing | Rates + ticks + freshness | Good semantics, no confidence curve | Add confusion-matrix style validation |
| Data tier | Distinguishes live, retained, historical-only style postures | Packet + copied history | Rich narrative under thin data still possible | Reduce narrative scope under historical-only support |
| Dossier / Current Focus projection | Writers do not own L5 truth | Consumer-only / mirror-only design | Good architecture, but interpretation can still feel authoritative | Make L5-origin stamp visible in every L6 projection |

## Research backlog and implementation guardrails

The repository’s own strategy doctrine files are actually aligned with the right next move. `STRATEGY_TESTING_EVIDENCE_LAYER.md` correctly says more prose is not more evidence and that family discrimination, habitat validity, anti-habitat behaviour, and data-surface uplift all need testing. That is consistent with the external benchmark: walk-forward and out-of-sample validation matter, data-snooping controls matter, costs matter, and regime / covariance shifts matter. In other words, the right future work is not “add more logic first”; it is “falsify the current logic honestly first.” citeturn8search9turn8search1turn8search4turn7search1turn7search8turn6search2turn8search0turn6search1turn6search12

### Edge Research Backlog

| Research idea | Why it may help | Risk | Required falsifier before implementation |
|---|---|---|---|
| Walk-forward rank validation by layer | Tests whether L3/L4 ordering survives unseen windows | Could expose weak edge | Rank advantage disappears after OOS costs |
| Family habitat / anti-habitat study | Validates whether L5/L6 family language maps to real discrimination | May reveal family overlap | Families fail to outperform in claimed habitat |
| Cost-aware edge netting | Adds spread, slippage, commission realism | Can collapse apparent edge | Gross edge vanishes net of realistic costs |
| Regime-conditioned shortlist quality | Tests whether L4 ranks hold across calm/stress regimes | Static ranks may fail under switches | Rank quality is regime-fragile |
| Correlation stress test | Measures shortlist diversification under changing covariance | Could show crowding illusion | Crisis co-movement overwhelms bucket diversity |
| Deep-review payoff audit | Checks whether high deep priority improves decisions | Might show deep queue is cosmetic | High deep score adds no outcome value |
| ATR fallback audit | Tests whether one-bar fallback pollutes volatility truth | Could show false robustness | Fallback symbols perform worse materially |
| Historical-only support policy study | Measures whether historical-only deep contexts are useful or dangerous | Could show narrative overclaim | Historical-only contexts underperform random waiting |
| Session-fit validation | Tests whether session timing and move age really improve shortlist quality | Could expose noisy weighting | Session-fit adds no net rank quality |
| Microstructure trust ceiling study | Determines how many copied ticks are “enough” | Could require stricter gating | Partial tick windows produce unstable signals |

### Do Not Implement Yet Table

| Idea | Why tempting | Why not now | What audit/proof needed first |
|---|---|---|---|
| Add auto-entry logic to L6 | L6 text looks close to execution language | L6 is explicitly descriptive only | Separate validated execution owner |
| Change L3/L4 weights | Many weights look tweakable | Tuning before falsification creates data snooping risk | Walk-forward / OOS evidence first |
| Add more indicators to L3 | Easy way to look smarter | More factors can mean more overfit noise | Evidence of marginal uplift |
| Convert deep fit to buy/sell signal | SIAM output is rich | Rich narrative is not empirical edge | Family discrimination validation |
| Add ML ranker over current features | Attractive shortcut | Would compound unvalidated labels | Label-quality audit first |
| Broaden CopyTicks / CopyRates loops | Looks like more evidence | Can create performance and false-confidence debt | Sample-size policy first |
| Use closed-history context as blocker | Recent history feels relevant | Source semantics correctly say context only | Exposure semantics proof first |
| Let correlation penalty veto symbols globally | Sounds risk-aware | Current correlation scope is shortlist-local | Wider universe correlation proof first |
| Treat historical-only support as lawful enough for action | Keeps system active | Historical-only is explicitly limited | Outcome study on historical-only cases |
| Collapse L3/L4/L5 into one master score | Simpler UI | Destroys layer truth and falsifier boundaries | Final synthesis audit first |

### Top 25 false assumptions

1. A Layer 3 pass means trade-ready.
2. `score_net` is the same as validated edge.
3. `score_led_penalty_carry` is only slightly worse than a clean pass.
4. Trade-mode availability means real-world deployability.
5. Spread caps are enough execution realism.
6. L4 rank is a recommendation to act.
7. Overall-board score means portfolio safety.
8. Bucket diversity means true diversification.
9. Shortlist-local peer correlation is enough concentration control.
10. High deep-request priority means higher conviction.
11. A selected-symbol deep entitlement implies the symbol deserves deep attention.
12. Built and lawful deep output means complete support.
13. Fresh partial support is almost as good as fresh full support.
14. Historical-only support is safe if the narrative is clear.
15. MTF alignment means permission.
16. SIAM primary fit means the correct family is known.
17. L6 handoff language implies an execution template.
18. Rich explanation implies causal understanding.
19. Closed-trade context should influence active-exposure blocking.
20. Packet freshness implies slippage robustness.
21. ATR fallback from day range is interchangeable with a proper ATR sample.
22. Neutral defaults are harmless when support is missing.
23. The shortlist peer set approximates the market opportunity set.
24. Static heuristics stay valid across regimes.
25. Extra text or extra layers equal extra evidence.

### Top 25 edge and truth weaknesses

1. No walk-forward owner in source.
2. No out-of-sample evidence owner in source.
3. No data-snooping control owner in source.
4. Static heuristic weights are uncalibrated.
5. Neutral defaults can smooth over missing evidence.
6. L3 can pass with drag-carry.
7. L3 score meaning is still easy to overread.
8. Asset-class spread caps are crude.
9. Execution reality is approximated mostly by spread and spread-to-ATR.
10. No explicit slippage or fill-quality model.
11. No commission and market-impact integration in L3/L4/L5 meaning.
12. L4 correlation is shortlist-local, not universe-aware.
13. L4 diversification is not crisis-regime diversification.
14. L4 exposure is account-local, not factor-level.
15. Deep-request priority is a queue score that can look like conviction.
16. L5 can narrate richly under partial support.
17. L5 has support taxonomy but no calibrated confidence.
18. L5 fit/path language is structurally rich but statistically unverified.
19. L6 is derived, not independently accountable.
20. No empirical owner for family habitat / anti-habitat truth.
21. No contradiction owner that can move from advisory to proven.
22. No outcome attribution from score bands to realised performance.
23. No venue / broker realism layer for fills and frictions.
24. No regime-sensitive acceptance standards for correlation and volatility.
25. No formal “edge invalidated” stopping rule in code.

### Top 25 future research ideas

1. Walk-forward quality of L3 rank order.
2. Walk-forward quality of L4 board order.
3. Delta between clean L3 pass and carry-pass outcomes.
4. Symbol-bucket-specific spread/friction realism study.
5. Slippage study by asset class and session.
6. Stress correlation / regime-switch shortlist study.
7. Family habitat and anti-habitat matrix.
8. False-positive analysis for deep-request priority.
9. Outcome study for historical-only deep support.
10. Outcome study for fresh-partial vs fresh-full deep support.
11. ATR fallback reliability audit.
12. Session-fit predictive value audit.
13. Move-age / late-move risk predictive value audit.
14. Exposure conflict penalty usefulness audit.
15. Bucket penalty usefulness audit.
16. Correlation penalty usefulness audit.
17. SIAM fit family discrimination study.
18. Confidence-break and invalidation usefulness study.
19. Current Focus / L6 interpretive stability study.
20. Regime-conditioned shortlist behaviour study.
21. Macro/regime overlay study before any L6 expansion.
22. Execution-style fit study for scalp vs intraday hints.
23. Cross-asset spillover / crowding study.
24. Robustness of threshold bands across asset classes.
25. “When to stop trusting the model” failure-rule research.

### Top 25 future code-improvement pointers

1. Introduce an offline validation ledger rather than runtime formula changes.
2. Separate clean-pass and carry-pass visuals everywhere.
3. Rename tradability hints to style-fit hints.
4. Mark `deep_request_priority` explicitly as review urgency.
5. Add `shortlist_scope_complete` wording to correlation completeness.
6. Split ATR fallback from full ATR support in tokens.
7. Add stronger suppression of narrative depth under historical-only support.
8. Add stricter trust ceiling when `ticks_copied < ticks_requested`.
9. Add stricter trust ceiling when enabled timeframes are only partially copied.
10. Add explicit confidence-calibration placeholder fields instead of implied confidence.
11. Add support-to-outcome telemetry fields for offline analysis.
12. Add factor / cluster exposure placeholders upstream of L4.
13. Add regime-class placeholders for shortlist behaviour.
14. Add bucket-aware sample-size policy placeholders.
15. Add separate `cost_realism=limited` token in L3/L4/L5.
16. Add explicit “edge_unvalidated” token in all L3/L4/L5 operator summaries.
17. Add a hard verifier that all falsehood tokens survive into artefacts.
18. Add a verifier that exposure semantics never conflate open / pending / history.
19. Add a verifier that L6 retains `descriptive_only` language.
20. Add a verifier that deep narratives are downgraded when support is partial.
21. Add offline-friendly export of rank and posture snapshots for later evaluation.
22. Add offline-friendly export of score components and penalties by symbol/time.
23. Add contradiction classes for “heuristic confidence exceeds support posture”.
24. Add contradiction classes for “diversification claim exceeds peer-scope evidence”.
25. Add contradiction classes for “story richness exceeds completeness”.

## Report 5 handoff and limitations

### Report 5 handoff

The final synthesis audit should start with these exact files and line ranges, because they contain the highest-value truth seams:

1. `mt5/candidate_filtering/ASC_SelectionFilter.mqh`
   - `ASC_SelectionFilterEvaluate()` around **2332–2560**
   - `ASC_SelectionFilterPopulateScorePack()` around **1895–2009**
   - `ASC_SelectionFilterApplyScoringFirstCarry()` around **2133–2265**
   - Focus question: where does L3 become numerically persuasive despite limited support?

2. `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh`
   - `ASC_ShortlistCompositePriorityScore()` around **1007–1040**
   - `ASC_ShortlistOverallAdmissionScore()` around **1412–1483**
   - overall-board context around **1577–1680**
   - `ASC_ShortlistBuildDeepRequestPriorityScore()` around **2250–2334**
   - `ASC_ShortlistBuildCorrelationSummary()` around **2945–3080**
   - Focus question: how much of L4 is ranking truth vs diversification theatre?

3. `mt5/shortlist_selection/ASC_ATRSummaryEngine.mqh`
   - `ASC_SummaryComputeDailyAtrPoints()` **28–68**
   - `ASC_SummaryAtrReady()` **70–116**
   - support / falsifier tokens **129–214**
   - Focus question: where does ATR fallback become too permissive?

4. `mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh`
   - D1 rates build around **1987–2043**
   - packet-age / freshness handling around **2231–2274**
   - Focus question: how strong is L2 freshness truth relative to L3/L5 confidence?

5. `mt5/market_state/ASC_MarketStateEngine.mqh`
   - `ASC_L1EntitlesLayer2LiveRefresh()` around **878–890**
   - summary readiness lines around **1095–1098**
   - Focus question: does L1 entitlement policy unintentionally overcredit stale states?

6. `mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh`
   - `ASC_BuildDeepSelectiveAnalysisResult()` **1816–2845**
   - `CopyTicks()` block around **2182–2316**
   - `CopyRates()` block around **2533–2688**
   - support proof tokens around **525–579**
   - L5 boundary / falsehood lines around **3313–3315**
   - Focus question: when does story richness outrun support posture?

7. `mt5/artifacts/dossier/ASC_DossierComposer.mqh`
   - L6 consumer boundary around **722**
   - `ASC_L6PopulateWorkbenchFromDeepResult()` **851–971**
   - `ASC_DossierBuildLayer6SurfaceBlocks()` **973–1075**
   - L5/L6 boundary lines around **1562**, **2330–2352**
   - Focus question: is L6 the right kind of descriptive surface, or is it becoming a soft final authority?

8. `mt5/portfolio/ASC_PortfolioExposureSnapshot.mqh`
   - active/future/history semantics around **796–983**
   - Focus question: are portfolio semantics still clean when consumed by ranking and narratives?

9. `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
   - section identity and protected richness around **110–158**
   - protected readback around **165–210**
   - Focus question: does Current Focus preserve the L5/L6 boundary without adding new truth?

10. Truth Seeker report chain to re-read first:
    - `roadmap/Truth Seeker/TRUTH_SEEKER_RUN068R_REPORT.md`
    - `...RUN069R_REPORT.md`
    - `...RUN070R_REPORT.md`
    - `...RUN071R_REPORT.md`
    - `...RUN072R_REPORT.md`
    - Focus question: does the report chain describe the same truth boundaries the code now actually enforces?

### Open questions and limitations

This was a source audit only. It does **not** claim compile proof, runtime proof, live proof, or trading proof. The strongest findings are code-grounded and report-grounded, not market-validated. Deep Research Reports 1–3 were not present under those exact names inside the zip, so the nearest authoritative continuity trail was the Truth Seeker RUN067R–RUN072R report chain. The system’s biggest unresolved question is no longer “does it say the right cautious words?” It does. The unresolved question is “which parts of those words survive honest falsification?” That remains the central proof debt.