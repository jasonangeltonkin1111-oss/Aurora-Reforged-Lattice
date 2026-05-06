RUN078R STATUS:
Post-warmup material degradation threshold and Steady status final-polish source-code repair run.

CURRENT BASELINE:
RUN059 / commit 796a8b6 plus RUN060R through RUN077R source/control state is the active authority unless current source proves otherwise.

RUN077R RESULT TO RESPECT:
RUN077R refined the RUN076R warmup gate so complete_first_publish requires broad L2 readiness plus Top10-critical L2 cleanliness, degraded_first_publish cannot release too early from retry_cycles alone, retry nudge coverage reaches the visible Top10 target, complete/degraded wording is aligned, and maintenance due_symbols alone no longer blocks complete. RUN077R protected GlobalTop10 formula/order, L3 score, L4 rank/order, Market Board order, FileIO, HUD, FunctionResults schema/spam, strategy, execution, and trade management.

RUN078R PURPOSE:
Patch the remaining post-warmup status semantics seam so Steady is not blocked by one minor degraded symbol after warmup, while still preserving strict safety for material degradation, unknown/uncertain thresholds, dirty Top10-critical L2, active refresh/rebuild, and incomplete required visible surfaces.

PROOF BOUNDARY:
RUN078R is source-patched-live-unproven until RUN080R or later. Do not claim compile/live/runtime/output proof.

## GIT HEADER SUMMARY
```text
TRUTH SEEKER ROADMAP — RUN078R / SOURCE PATCH REFINEMENT — POST-WARMUP MATERIAL DEGRADATION THRESHOLD + STEADY STATUS FINAL POLISH BEFORE RUN080
DECISION: PASS — source/control patched, live-unproven
PATCHED: mt5/market_state/ASC_MarketStateEngine.mqh; mt5/core/ASC_Version.mqh; roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md; roadmap/Truth Seeker/TRUTH_SEEKER_RUN078R_REPORT.md
PROTECTED: GlobalTop10 formula/order; Top3/Top5/Top10 formulas; L3 score; L4 rank/order/tie-breaker; Market Board order; FileIO; HUD; FunctionResults schema/spam; strategy/execution/trade management
PROOF: source_patched_live_unproven until RUN080R or later
```

## SOURCE / ROADMAP INTAKE TABLE
| Check | Result | Evidence path | Decision |
|---|---|---|---|
| Source package found | yes | Aurora Sentinel Core(319).zip | continue |
| Compile root found | yes | mt5/AuroraSentinelCore.mq5 listed in package | continue |
| RUN077R report found | yes | roadmap/Truth Seeker/TRUTH_SEEKER_RUN077R_REPORT.md | continue |
| RUN077R patched source verified | partial-static | ASC_Dispatcher.mqh grep + RUN077R report | continue |
| RUN076R report found | yes-listed | roadmap/Truth Seeker/TRUTH_SEEKER_RUN076R_REPORT.md | continue |
| RUN075R report found | yes-listed | roadmap/Truth Seeker/TRUTH_SEEKER_RUN075R_REPORT.md | continue |
| Deep research reports 1–5 found | yes-listed | roadmap/Truth Seeker/deep-research-report1-5.md | continue |
| Dispatcher found | yes | mt5/runtime/ASC_Dispatcher.mqh | inspect/protect RUN077R patch |
| RuntimeState found | yes-listed | mt5/core/ASC_RuntimeState.mqh | protect; extraction unstable in sandbox |
| MarketState owner found | yes | mt5/market_state/ASC_MarketStateEngine.mqh | patched materiality seam |
| OpenSymbolSnapshot owner found | yes-listed | mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh | read-only |
| Candidate Filtering owner found | yes-listed | mt5/candidate_filtering/ASC_SelectionFilter.mqh | protected |
| Shortlist owner found | yes-listed | mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh | protected formulas |
| GlobalTop10 owners found | yes | mt5/runtime/ASC_Dispatcher.mqh | inspected/protected formula/order |
| Market Board writer found | yes-listed | mt5/artifacts/ASC_MarketBoardWriter.mqh | protected |
| FunctionResults found | yes-listed | mt5/logging/ASC_FunctionResults.mqh | protected/no spam |
| FileIO found | yes-listed | mt5/io/ASC_FileIO.mqh | read-only/protect |
| HUD found | yes-listed | mt5/hud/ASC_HUD_Manager.mqh | read-only/protect |

## RUN077R FINISH-STATE VERIFICATION TABLE
| RUN077R finish item | Present in source/report? | Gap? | RUN078R repair decision |
|---|---:|---|---|
| complete_first_publish requires Top10-critical L2 clean | yes | no | protected |
| RuntimeState includes warmup_top10_l2_unavailable_count | report yes / source listed | no source edit | protected |
| degraded_first_publish maturity floor | yes | no | protected |
| retry nudge covers visible Top10 target 10 | yes | no | protected |
| complete/degraded strings aligned | yes | no | protected |
| maintenance due_symbols no longer blocks complete | yes in MarketState | no | preserved |
| GlobalTop10 formula/order untouched | yes | no | no formula edit |
| L3 score formula untouched | yes | no | no edit |
| L4 rank/order untouched | yes | no | no edit |
| FileIO untouched | yes | no | no edit |
| HUD untouched | yes | no | no edit |
| FunctionResults schema/spam untouched | yes | no | no edit |
| MarketState uses degraded_symbols > 0 direct trigger | yes | yes | patched |
| RUN077R report fenced summaries | yes | no | protected |
| RUN077R proof debt source_patched_live_unproven | yes | no | preserved |

## DEEP RESEARCH ABSORPTION TABLE
| Report | Relevant finding | RUN078R source constraint | Patch target | Deferred item |
|---|---|---|---|---|
| 1 | Truth status must not overclaim | Steady cannot hide unknown/uncertain breaches | MarketState | live proof RUN080R |
| 2 | Artifact/status wording must map to real state | Degraded wording only for material degradation | MarketState | board runtime validation |
| 3 | Protected ranking/score paths must not drift | No Top10/L3/L4 formula edit | none | future formula audits |
| 4 | Warmup gates must remain bounded | No blocking loop or wait introduced | MarketState | live timer observation |
| 5 | Proof debt must remain explicit | source_patched_live_unproven retained | report/version | RUN080R proof |

## INTERNET RESEARCH CONVERSION TABLE
| Research item | Finding | Source constraint | Patch target | Acceptance test | Forbidden misuse |
|---|---|---|---|---|---|
| MQL5 OnTimer/EventSetTimer | Timer work must remain event-light and timer lifecycle is OnInit/OnDeinit owned | Boolean-only status logic; no waits/loops | MarketState | no new timer or blocking loop | no EventSetTimer churn |
| MQL5 FileFlush/FileOpen/FileMove | FileFlush is valuable but frequent calls can affect speed; FileMove is the move/rename primitive | Do not solve status noise via FileIO churn | none | FileIO untouched | no write/flush rewrite |
| Readiness/degradation threshold design | Any minor issue differs from material degradation | degraded_symbols needs threshold | MarketState | 1 minor degraded symbol not degraded summary | no hidden unknown/uncertain risk |
| Dashboard status UX | Status indicators should direct attention to meaningful changes | Disturbed/degraded reserved for material state | MarketState | Steady allowed when settled | no fake steady with dirty Top10 L2 |
| Regression testing/risk-based testing | Changes must preserve core behavior and target high-risk surfaces | protect RUN077R and formulas | Dispatcher/MarketState | protected table passes | no rank/order drift |

## MATERIAL DEGRADATION THRESHOLD TABLE
| Requirement | Current source behavior | New behavior | Patch decision |
|---|---|---|---|
| Single minor degraded symbol | `degraded_symbols > 0` forced degraded | threshold allows one isolated degraded symbol post-warmup | patched |
| Clustered degraded symbols | same as single | `degraded_symbols > max(1, floor(assessed*0.02))` is material | patched |
| Unknown safety | blocked through degraded condition | remains hard blocker | preserved |
| Uncertain safety | blocked through degraded condition | remains hard blocker | preserved |
| Top10-critical L2 | RUN077R dispatcher gate | unchanged | protected |

## POST-WARMUP STEADY ELIGIBILITY TABLE
| Steady condition | Current source behavior | New behavior | Patch decision |
|---|---|---|---|
| Warmup ready | required | required | preserved |
| Complete coverage | required | required | preserved |
| Maintenance due only | no longer blocks complete | still does not block complete | preserved |
| Material degradation | any degraded symbol blocked | only material degradation blocks | patched |
| Unknown/uncertain limits | strict | strict | preserved |
| Stale threshold | strict | strict | preserved |

## STATUS WORD SEMANTICS TABLE
| Status word | Current behavior | New allowed meaning | Forbidden misuse |
|---|---|---|---|
| Steady | impossible with one degraded symbol | settled coverage without material degradation/stale/unknown breach | not allowed with dirty Top10-critical L2 |
| Degraded/Disturbed | any degraded symbol | material degradation or unknown/uncertain breach | not one minor non-critical degraded symbol |
| Rebalancing | dispatcher-owned active rebuild | actual rebuild/refresh only | not default settled wording |
| Partial | incomplete coverage | incomplete required surface/held first publish | not default complete coverage |
| Fresh | complete and not degraded | complete and not materially degraded | not if stale/material |

## RUN077R REGRESSION GUARD TABLE
| RUN077R protected repair | Still intact? | Evidence |
|---|---:|---|
| Top10 L2 clean gate | yes | Dispatcher constants include critical L2 max 0 and report says complete requires clean |
| degraded maturity floor | yes | Dispatcher constants include min maturity seconds/heartbeats |
| retry target count 10 | yes | `ASC_WARMUP_FIRST_TOP10_VISIBLE_TARGET 10` |
| complete/degraded wording | yes | no dispatcher/report string edit in RUN078R |
| maintenance due not blocker | yes | MarketState material_due_symbols limited to unknown/uncertain |

## NO-FREEZE / TIMER / HEARTBEAT GUARD TABLE
| Risk | Source guard | Patch decision |
|---|---|---|
| timer queue starvation | no timers added | pass |
| blocking loop | no loops added beyond helper math | pass |
| FileIO churn | FileIO untouched | pass |
| heavy CopyRates/CopyTicks | no market data loops added | pass |

## PROTECTED FORMULA / ORDER DRIFT TABLE
| Protected area | Touched? | Drift? | Evidence |
|---|---:|---:|---|
| GlobalTop10 formula/order | no | no | Dispatcher order functions not edited |
| Top3/Top5/Top10 formulas | no | no | no scoring code touched |
| L3 score | no | no | SelectionFilter untouched |
| L4 rank/order/tie-breaker | no | no | Shortlist untouched |
| Market Board order | no | no | writer untouched |
| FunctionResults | no | no | untouched |
| FileIO | no | no | untouched |
| HUD | no | no | untouched |

## PATCH CANDIDATE MATRIX
| File | Candidate patch | Why needed | Risk | Chosen/rejected |
|---|---|---|---|---|
| mt5/market_state/ASC_MarketStateEngine.mqh | material degradation helper | direct seam owner | low/moderate compile risk | chosen |
| mt5/core/ASC_Constants.mqh | add constants | not needed; avoid broad control surface | unnecessary | rejected |
| mt5/runtime/ASC_Dispatcher.mqh | status semantics | RUN077R owner protected | high regression risk | rejected |
| mt5/artifacts/ASC_MarketBoardWriter.mqh | wording | no exact owner gap proven | board order risk | rejected |

## PATCH TABLE
| File | Function/area | Patch made | Why truthful | Compile-risk note |
|---|---|---|---|---|
| mt5/market_state/ASC_MarketStateEngine.mqh | `ASC_Layer1MaterialDegradedSymbolLimit` | added threshold helper | separates minor vs material degradation | uses existing MathFloor/MathMax |
| mt5/market_state/ASC_MarketStateEngine.mqh | `ASC_Layer1HasMaterialDegradation` | added hard safety check | unknown/uncertain remain strict | no new state fields |
| mt5/market_state/ASC_MarketStateEngine.mqh | `ASC_Layer1RebuildSummary` | `summary.is_degraded` now materiality-based | one minor degraded no longer blocks Steady | Boolean-only change |
| mt5/core/ASC_Version.mqh | run identity | RUN078R label/current run/proof defines | control alignment | preprocessor-only |
| roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md | package manifest | appended RUN078R expected changed files | control alignment | markdown-only |
| roadmap/Truth Seeker/TRUTH_SEEKER_RUN078R_REPORT.md | report | created report | proof/debt clarity | markdown-only |

## STATIC COMPILE-SAFETY TABLE
| Check | Result | Evidence |
|---|---|---|
| helper placement before use | pass | helpers inserted before posture/rebuild functions |
| no new struct field | pass | no runtime serialization drift |
| no FileIO/HUD/FunctionResults edit | pass | files not packaged |
| no score/rank formula edit | pass | only MarketState + version/control/report |
| compile proof claimed | no | source-patched-live-unproven retained |

## PROOF-DEBT UPDATE TABLE
| Proof item | Before RUN078R | After RUN078R | Next proof action |
|---|---|---|---|
| Source | RUN077R source-patched | RUN078R source-patched | inspect changed diff |
| Static compile-safety | RUN077R static only | RUN078R static only | MetaEditor compile in RUN080R/live checkpoint |
| Compile | unproven | unproven | RUN080R |
| Live | unproven | unproven | RUN080R |
| Output | unproven | unproven | RUN080R |

## NEXT_PROMPT_SEED TABLE
| Next run | Must read first | Primary target | Known proof debt | Must not do |
|---|---|---|---|---|
| RUN079R optional source polish or RUN080R live | RUN078R report + changed zip + RUN077R report | prove material degradation threshold and first GlobalTop10 gate in runtime/output | no compile/live/output proof yet | no formula/order/FileIO/HUD/strategy drift |

## FINAL DECISION TABLE
| Area | Decision | Why |
|---|---|---|
| Material degradation | AUTHORIZE source patch | direct source seam found and patched |
| RUN077R gate | HOLD/protect | already patched; no regression introduced |
| Formula/order areas | KILL edits | outside scope and protected |
| Proof | HOLD until RUN080R | no live/compile run performed |

## FINAL SUMMARY
```text
RUN:
RUN078R

DECISION:
PASS — source/control patched; live-unproven.

RUN TYPE:
- code edit: yes
- live output requested: no
- compile/live proof claimed: no
- next live checkpoint: RUN080R

RUN077R ABSORPTION:
- RUN077R report read: yes
- RUN077R patched source verified: partial static verification, Dispatcher and MarketState checked
- finish gaps found: MarketState still treated any degraded symbol as summary degraded
- deep reports absorbed: yes as constraints; no broad source expansion

MATERIAL DEGRADATION VERDICT:
- single degraded symbol blocks steady: no after patch when non-material
- material threshold: max(1, floor(assessed_symbols * 0.02)); material when degraded_symbols exceeds threshold
- Top10-critical degradation: protected by RUN077R Top10-critical L2 gate, unchanged
- selected-symbol degradation: not newly hidden; no selected-symbol owner edit made
- visible-board degradation: not newly hidden; board writer/order untouched
- unknown/uncertain safety: preserved as hard blockers

POST-WARMUP STATUS VERDICT:
- Steady default: allowed only when warmup-ready, complete, non-stale, and no material degradation
- due_symbols handling: maintenance due alone still does not block complete/steady
- Disturbed restricted: material degradation or safety breach only
- Rebalancing restricted: dispatcher active rebuild/refresh semantics untouched
- Partial restricted: incomplete required coverage/first-publish conditions only
- real degradation preserved: yes when material
- active refresh preserved: no dispatcher weakening

RUN077R REGRESSION VERDICT:
- Top10 L2 clean gate: preserved
- degraded maturity floor: preserved
- retry target count 10: preserved
- complete/degraded wording: preserved
- no-freeze guard: preserved

PROTECTED AREAS:
- GlobalTop10 formula: untouched
- L3 score: untouched
- L4 rank/order: untouched
- Market Board order: untouched
- FunctionResults: untouched
- FileIO: untouched
- HUD: untouched
- strategy/execution: untouched

PATCHES:
- ASC_MarketStateEngine.mqh / materiality helper — separates minor degraded symbol from material degradation — no formula/order drift
- ASC_MarketStateEngine.mqh / rebuild summary — summary.is_degraded now materiality-based — unknown/uncertain strictness preserved
- ASC_Version.mqh / RUN078R identity — source-control alignment — preprocessor-only
- TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md / RUN078R append — package declaration — markdown-only
- TRUTH_SEEKER_RUN078R_REPORT.md / report — proof and next prompt seed — markdown-only

PROOF STATUS:
- Source: patched
- Static compile-safety: checked by diff/static inspection only
- Compile: not claimed
- Live: not claimed
- Output: not claimed
- Post-patch proof: source_patched_live_unproven until RUN080R

NEXT_PROMPT_SEED:
- next run: RUN079R optional source polish or RUN080R live proof
- first files to read: RUN078R report, RUN078R changed zip, RUN077R report, Dispatcher, RuntimeState, MarketState
- primary target: prove Steady is not blocked by one non-critical degraded symbol while dirty Top10 L2/material degradation still blocks
- proof debt to preserve: source_patched_live_unproven until compile/live/output evidence exists
- forbidden drift: no GlobalTop10/L3/L4/Market Board order/FileIO/HUD/FunctionResults/strategy/execution changes

ZIP:
RUN078R changed-files zip produced.
```
