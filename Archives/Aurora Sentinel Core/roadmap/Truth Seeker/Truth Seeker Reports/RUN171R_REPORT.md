# RUN171R_REPORT

## GIT HEADER SUMMARY

```text
TRUTH SEEKER ROADMAP — RUN171R / SYMBOL DATA PACK LITE FULL RUNTIME ACTIVATION
Decision: PASS-BY-SOURCE-PATCH
Live proof: not claimed
Compile proof: not claimed
Package: TRUTH_SEEKER_RUN171R_CHANGED_FILES_WINDOWS_SAFE.zip
Next run: RUN172R triple-check
Next live run: RUN173R
```

## FINAL SUMMARY

```text
RUN171R absorbed RUN170R HOLD WITHOUT PATCH and converted Lite from runtime-dormant source to bounded runtime-active source.

Changed:
- source identity advanced to RUN171R;
- Symbol Data Pack Lite shadow mode default changed false;
- Symbol Data Pack Lite runtime activation flag changed true;
- dispatcher now includes the Lite writer and schedules due-only bounded activation;
- dispatcher calls ASC_ServiceSymbolDataPackLiteRuntimeActivation from the persistence/write lane;
- runtime symbol selection is bounded to selected/current/top existing snapshot fallback only;
- writer attempts one atomic one-file-per-symbol publish only when due;
- Scanner Status and Artifact Bundle Manifest expose Lite callsite/writer/symbol/path/validation/budget proof fields;
- RUN172 and RUN173 seeds were added to control/report surfaces.

Not changed:
- no FileIO rewrite;
- no heartbeat cadence change;
- no HUD repair;
- no Dossier/Current Focus/Market Board/Top5PerBucket/GlobalTop10 rank/order/formula mutation;
- no strategy or execution logic.
```

## Non-Drift Declaration

| Declaration | Required Answer |
|---|---|
| current run | RUN171R |
| current purpose | Symbol Data Pack Lite full bounded runtime activation |
| previous live run | RUN170R |
| previous live result | HOLD WITHOUT PATCH |
| why RUN170R held | Lite source existed but runtime activation/output proof did not exist |
| next run after RUN171R | RUN172R triple-check |
| next live run | RUN173R |
| is RUN171R live? | no |
| is RUN171R source patch? | yes |
| is activation required? | yes |
| is full-universe uncontrolled activation allowed? | no |
| is strategy/execution allowed? | no |
| is rank/order/formula rewrite allowed? | no |
| is FileIO rewrite allowed? | no |
| is heartbeat cadence change allowed? | no |
| must Dossier/Market Board/Top5/GlobalTop10 be preserved? | yes |
| must output proof surfaces be added? | yes |
| must package be changed-files-only? | yes |

## RUN170 Hold Absorption

| Evidence File | Must Extract | Found? | Extracted Finding | Impact On RUN171R |
|---|---|---:|---|---|
| RUN170R_REPORT.md | decision, hold reason, source identity, live blocker, next seed | yes | HOLD WITHOUT PATCH; Lite source present but no runtime callsite/output; shadow true and activation false | activate bounded runtime path |
| RUN169R_REPORT.md | source closeout, RUN170 contract, activation status | yes | source closeout only, live proof pending | preserve content and add runtime bridge |
| RUN168R_REPORT.md | health map, no dispatcher/runtime activation status | yes | health map source-visible, live-unproven | preserve health section |
| RUN167R_REPORT.md | indicators, handle/copybuffer risk, no-live status | yes | numeric indicators source-visible, live-unproven | preserve indicator section |
| RUN166B_REPORT.md | authority repair / baseline | yes | repaired prior authority gap | preserve guidebook/control authority |
| RUN160R–RUN166R reports | Lite sequence lineage | yes | reset/skeleton/writer/L2/OHLC/ATR/VWAP lineage present | preserve all Lite families |
| TRUTH_SEEKER_ROADMAP.md | current phase and next live run | yes | stale sections still pointed at RUN170 | updated for RUN171/RUN172/RUN173 |
| TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md | active next action | yes | active log still described RUN170 as next | updated RUN171 pass and RUN172 seed |
| TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md | package lineage | yes | prior changed-files history present | appended RUN171 manifest |
| Guidebooks | coding/trading lessons to preserve | yes | no durable new guidebook lesson required beyond report/control | unchanged |
| AuroraSentinelCore.mq5 | include / runtime path evidence | yes | writer was compile-included at root but dispatcher did not call it | dispatcher now directly includes/calls writer |
| ASC_Dispatcher.mqh | runtime heartbeat/callsite evidence | yes | no Lite runtime service call before RUN171 | added scheduler + write-lane service |
| ASC_SymbolDataPackContracts.mqh | activation flags, constants, section contracts | yes | shadow true, activation false | shadow false, activation true, bounded mode constants |
| ASC_SymbolDataPackRouting.mqh | symbol choice / route status | yes | route map only; no runtime symbol selector | dispatcher selector added without rank recalculation |
| ASC_SymbolDataPackComposer.mqh | compose/dry-run capability | yes | payload skeleton and content families present | added RUN171 proof section tokens |
| ASC_SymbolDataPackWriter.mqh | publish/shadow/write guard | yes | writer blocked by shadow/runtime flags | flags now allow bounded explicit writer call |
| ASC_ScannerStatusWriter.mqh | status proof surface | yes | no Lite activation status line | added Lite runtime proof line |
| ASC_ArtifactTextHelpers.mqh | manifest/proof helper surface | yes | no direct patch required | preserved |
| ASC_Version.mqh | version identity / run marker | yes | RUN169 identity | advanced to RUN171 |

## Facts vs Assumptions

| Claim | Fact or Assumption | Evidence | RUN171R Risk If Wrong |
|---|---|---|---|
| RUN170R held because Lite was dormant | Fact | RUN170R report states no runtime callsite/output | patch target would drift if ignored |
| Writer path existed before RUN171R | Fact | `ASC_SymbolDataPackWriter.mqh` present | activation can reuse existing writer |
| Dispatcher lacked Lite callsite | Fact | grep found writer calls only inside Lite writer before patch | no live proof possible without callsite |
| Selected/current symbol may exist at runtime | Assumption | runtime state has current focus/HUD fields | if absent, mode becomes deferred_no_symbol |
| GlobalTop10 completed snapshot may exist | Assumption | runtime state carries completed symbol array | fallback only; no rank recalculation |
| MetaEditor compile will pass | Assumption | static sweep only; no compile output supplied | RUN172 must triple-check compile-risk |
| RUN173 will generate final file if symbol/path available | Assumption | writer path now reachable | RUN173 must prove final/temp/last-good/no-change state |

## Research Leverage Tables

| Research Question | Why It Matters | Decision It Controls | Required Source Types |
|---|---|---|---|
| Do MQL5 timer events stack? | Prevent heartbeat collapse | one-symbol due-only activation | official MQL5 docs |
| Does FileFlush affect speed? | Avoid broad flush loop | no FileIO rewrite, no repeated writes | official MQL5 docs |
| Can CopyBuffer/BarsCalculated be partial/not ready? | Prevent fake complete | preserve hydration/retry/partial states | official MQL5 docs |
| How should runtime timing budget be measured? | Bound activation inside heartbeat | use existing microsecond budget helpers | official MQL5 docs |

| Source | Authority Tier | Used For | Limitation |
|---|---:|---|---|
| MQL5 OnTimer/EventSetTimer docs | 1 | timer queue non-stacking constraint | docs do not inspect Aurora code |
| MQL5 FileFlush/FileClose docs | 1 | no flush loop/FileIO rewrite | docs do not benchmark this EA |
| MQL5 BarsCalculated/Bars/SeriesInfoInteger docs | 1 | hydration/partial state preservation | docs are API-level only |
| MQL5 GetMicrosecondCount docs | 1 | budget telemetry compatibility | no compile proof |

| Research Finding | Source Type | Authority Tier | Aurora Constraint | File / Module Impact | Validation / Falsifier |
|---|---|---:|---|---|---|
| Timer event is not queued if a Timer event already exists or is processing | official docs | 1 | no full-universe Lite publish | Dispatcher | RUN173 heartbeat/timer pressure |
| Frequent FileFlush can affect speed; FileClose flushes remaining data | official docs | 1 | no broad flush loop / no FileIO rewrite | Writer reuses FileIO | RUN173 file pressure/logs |
| BarsCalculated can return -1 if data not calculated | official docs | 1 | keep buffer-loading/not-ready states | Composer content preserved | RUN173 health map |
| Bars can return 0 when data not synchronized | official docs | 1 | preserve synchronized/not-ready diagnostics | Composer content preserved | RUN173 freshness map |
| SymbolInfoTick returns false on failure | official docs | 1 | no fake quote complete | Composer content preserved | RUN173 quote section |

| Research Finding | Adopt / Modify / Reject / Defer | Reason | Patch / Roadmap / Guidebook Impact |
|---|---|---|---|
| Timer non-stacking | Adopt | bounded work required | one symbol due-only scheduler |
| FileFlush speed cost | Adopt | writer should not be broadened | no FileIO rewrite |
| CopyBuffer/BarsCalculated partial readiness | Adopt | must expose partial/retry | content families preserved |
| Full-universe activation | Reject | violates runtime budget | selector uses current/top fallback only |
| Guidebook rewrite | Defer | report/control enough for this run | no guidebook churn |

## Activation Mode Table

| Activation Mode | Meaning | Runtime Side Effect | Allowed In RUN171? | RUN173 Proof Needed |
|---|---|---|---:|---|
| disabled_by_policy | activation flag false | no write | yes as fail-safe | prove not active if disabled |
| shadow_dry_run | compose only/no write | no final file | yes only if writer guard blocks | prove reason |
| bounded_selected_symbol_write | selected/current symbol write | one file max when due | yes | final/temp/last-good/status |
| bounded_top_symbol_write | existing top snapshot fallback | one file max when due | yes | symbol source trace |
| deferred_no_symbol | no lawful symbol | status only | yes | Scanner/Manifest reason |
| deferred_budget | budget exhausted | retry next due | yes | heartbeat/log proof |
| failed_validation | token validation failed | no final promotion | yes | missing token proof |
| failed_write | writer/path failed | no final promotion | yes | error proof |
| success_written | final file written | one final file | yes | file exists + status |
| success_no_change | existing file retained | no churn | yes | no-change proof |

## Runtime Callsite Table

| Callsite | File | Lane / Timing | Symbol Source | Budget Guard | Write Mode | Status Surface |
|---|---|---|---|---|---|---|
| `ASC_MaybeScheduleSymbolDataPackLiteRuntimeActivation` | `mt5/runtime/ASC_Dispatcher.mqh` | pre-lane scheduling only | none | due clock only | schedules manifest/write lane | state fields |
| `ASC_ServiceSymbolDataPackLiteRuntimeActivation` | `mt5/runtime/ASC_Dispatcher.mqh` | persistence/write lane before manifest | selected/current/HUD/GlobalTop10/committed L4 fallback | `ASC_HeartbeatBudgetExpired` + 300s proof heartbeat | one-symbol atomic writer | Scanner Status + Manifest |

## Writer / Publication Table

| Writer Field | Source / Module | Implemented? | RUN173 Proof Needed |
|---|---|---:|---|
| writer_called | RuntimeState/Dispatcher | yes | Scanner/Manifest true |
| compose_success | Writer reason/state | source-visible | writer reason in status |
| validation_success | Writer payload token check | source-visible | validation_status |
| required_token_missing_count | RuntimeState field | yes | 0 or failure reason |
| first_missing_required_token | RuntimeState field | yes | none or token |
| write_attempted | RuntimeState + writer_called | yes | writer_called=true |
| write_success | RuntimeState | yes | true if final promoted |
| no_change_skipped | RuntimeState reason probe | yes | status proof |
| final_path | Writer target path | yes | file exists in RUN173 |
| temp_path | Writer temp path | yes | no stale temp / temp proof |
| last_good_path | retained final path | yes | continuity proof |
| last_error | RuntimeState writer reason | yes | error/none |

## Lite Content Preservation Table

| Lite Content Family | Introduced Run | Must Preserve? | Activation Risk | Guard |
|---|---|---:|---|---|
| route / identity shell | RUN161R | yes | thinning | composer untouched except RUN171 section |
| quote snapshot | RUN163R | yes | fake complete | preserved hydration states |
| tick activity | RUN163R | yes | heavy loop | existing bounded aggregate preserved |
| spread statistics | RUN163R | yes | signal leakage | factual burden only |
| OHLC / candle sequences | RUN164R | yes | current bar confusion | existing closed/preview distinction preserved |
| D/W/M high-low | RUN164R | yes | stale facts | freshness map preserved |
| ATR/range/pullback | RUN165R | yes | formula drift | source sections preserved |
| spread-to-volatility burden | RUN165R | yes | judgment wording | numeric section preserved |
| VWAP/anchored VWAP/volume quality | RUN166R | yes | volume-source ambiguity | quality states preserved |
| numeric indicators | RUN167R | yes | handle/buffer not ready | CopyBuffer/BarsCalculated states preserved |
| health/completeness/freshness/retry/last-good | RUN168R | yes | false complete | validation tokens preserved |
| publication health | RUN169R/RUN171R | yes | hidden activation | status/manifest added |

## Scanner Status / Manifest Visibility Table

| Proof Surface Field | Scanner Status | Manifest | Source Owner | Required for RUN173? |
|---|---:|---:|---|---:|
| Lite subsystem present | yes | yes | Dispatcher/Status writers | yes |
| activation mode | yes | yes | RuntimeState | yes |
| runtime callsite enabled | yes | yes | Dispatcher | yes |
| writer called | yes | yes | Dispatcher | yes |
| activation symbol source | yes | yes | Dispatcher selector | yes |
| activation symbol | yes | yes | RuntimeState | yes |
| attempt/success/next due | yes | yes | RuntimeState | yes |
| final/temp/last-good paths | yes | yes | Writer/RuntimeState | yes |
| validation/missing token | yes | yes | Writer/RuntimeState | yes |
| deferred reason/budget state | yes | yes | Dispatcher | yes |
| RUN173 proof checklist marker | yes | yes | Status/Manifest | yes |

## Performance / Timer / Budget Guard Table

| Performance Area | Risk | Guard | Implemented? | RUN173 Proof Needed |
|---|---|---|---:|---|
| OnTimer queue | dropped timer events / pressure | one symbol due-only | yes | heartbeat/timer logs |
| FileFlush/write | speed degradation | existing FileIO atomic/no-change only | yes | write logs/status |
| CopyBuffer | loading/partial/heavy | no new full matrix loop | yes | hydration proof |
| CopyRates/CopyTicks | heavy loops | composer content preserved, one-symbol only | yes | FunctionResults |
| indicator handles | churn | no new handle loop | yes | logs/status |
| output churn | file spam | existing no-change check | yes | status lines |

## Protected Area Table

| Protected Area | Source Files Checked | Changed? | Preserved? | Evidence |
|---|---|---:|---:|---|
| Dossier behavior | Dossier writer / dispatcher queues | no targeted logic change | yes | no Dossier writer patch |
| Current Focus behavior | dispatcher selected-symbol functions | no targeted logic change | yes | no Current Focus writer patch |
| Market Board | MarketBoard writer | no | yes | no file changed |
| Top5PerBucket | dispatcher family code | no formula/order change | yes | no rank/order edits |
| GlobalTop10 | dispatcher family code | no formula/order change | yes | only read existing first symbol fallback |
| FileIO atomic contract | ASC_FileIO.mqh | no | yes | no FileIO patch |
| heartbeat cadence | constants/timer | no | yes | no cadence patch |
| HUD | HUD manager | no | yes | no HUD patch |
| strategy/execution | source sweep | no new action logic | yes | no OrderSend/CTrade/lot/SL/TP added |

## Signal / Execution Leakage Table

| Leakage Token / Concept | Location | Allowed Context? | Risk | Action |
|---|---|---:|---|---|
| existing trading/spec words | older artifact/spec sections | existing context | pre-existing operator/spec vocabulary | no new execution logic added |
| direction/signal language | new RUN171 code | no | would fail | not introduced |
| OrderSend/CTrade/SL/TP/lot sizing | new RUN171 code | no | would fail | not introduced |
| rank/order/formula rewrite | new RUN171 code | no | would fail | not introduced |

## Patch Candidate Matrix

| Patch Candidate | File | Problem Addressed | Benefit | Risk | Safe? | Decision |
|---|---|---|---|---|---:|---|
| version identity | `ASC_Version.mqh` | stale RUN169 identity | source trace | low | yes | patched |
| runtime fields | `ASC_RuntimeState.mqh` | no status storage | proof surfaces | medium compile-risk | yes | patched |
| activation constants | `ASC_SymbolDataPackContracts.mqh` | shadow/dormant flags | enables bounded path | medium | yes | patched |
| RUN171 payload section | `ASC_SymbolDataPackComposer.mqh` | no activation proof section | output proves mode/path | low | yes | patched |
| writer tokens | `ASC_SymbolDataPackWriter.mqh` | validation lacks RUN171 tokens | validates proof section | low | yes | patched |
| dispatcher callsite | `ASC_Dispatcher.mqh` | no runtime caller | actual activation | medium | yes | patched |
| scanner status line | `ASC_ScannerStatusWriter.mqh` | hidden activation state | RUN173 readable proof | medium | yes | patched |
| FileIO rewrite | `ASC_FileIO.mqh` | not needed | none | high | no | rejected |
| Market Board logic | MarketBoard writer | not needed | none | high | no | rejected |

## Patch Table

| File | Change |
|---|---|
| `mt5/core/ASC_Version.mqh` | advanced identity to RUN171R; added RUN171/RUN172/RUN173 tokens |
| `mt5/core/ASC_RuntimeState.mqh` | added Lite activation/status/path/writer fields and reset defaults |
| `mt5/runtime/ASC_Dispatcher.mqh` | included Lite writer; added bounded scheduler, selector, service callsite, and manifest status line |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | added Lite status line and required tokens |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | enabled bounded activation flags and run constants |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh` | added RUN171 activation proof section |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | expanded required tokens for RUN171 proof section |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md` | appended RUN171/RUN172/RUN173 roadmap state |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | appended RUN171 decision and next action |
| `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | appended package manifest |

## Static Compile-Safety Sweep

| Static Compile Check | Result | Action |
|---|---|---|
| RUN171R version identity sweep | PASS by grep | changed to RUN171R |
| activation flag sweep | PASS by grep | shadow false / runtime true |
| runtime callsite sweep | PASS by grep | callsite present |
| dispatcher include/call order sweep | HOLD until MetaEditor | writer included in dispatcher |
| writer call signature sweep | PASS by inspection | existing signature used |
| composer call signature sweep | PASS by inspection | skeleton signature unchanged |
| routing call signature sweep | PASS by inspection | no route file mutation |
| status/manifest helper sweep | HOLD until MetaEditor | string lines added |
| StringFormat sweep | PASS by no new complex StringFormat | mostly concat strings |
| duplicate constant sweep | PASS by grep | no duplicate RUN171 constants found |
| brace/scope sanity sweep | PASS by local text inspection | RUN172 must verify compile |
| FileIO preservation sweep | PASS | FileIO unchanged |
| main Dossier preservation sweep | PASS | Dossier writer unchanged |
| Current Focus preservation sweep | PASS | writer unchanged |
| Market Board preservation sweep | PASS | writer unchanged |
| Top5/GlobalTop10 preservation sweep | PASS | no formula/order patch |
| HUD preservation sweep | PASS | HUD unchanged |
| strategy/execution absence sweep | PASS for new code | no execution calls added |
| signal leakage sweep | PASS for new code | no direction/action strings added |
| package validation sweep | pending at report write time | completed after zip build |
| final download-link target sweep | pending at report write time | completed after zip build |

## Decision Table

| Decision Candidate | Evidence For | Evidence Against | Final? |
|---|---|---|---:|
| PASS | real bounded activation patch, callsite, proof surfaces, protected areas preserved | compile/live proof not supplied | yes, source-patch only |
| HOLD | compile not proven | no known source blocker after patch | no |
| FAIL | no protected rewrite or fake live proof | none observed | no |

## Control Update Table

| Control File | Updated? | Reason |
|---|---:|---|
| TRUTH_SEEKER_ROADMAP.md | yes | RUN171/RUN172/RUN173 state |
| TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md | yes | active decision and next action |
| TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md | yes | package contents |
| Guidebooks | no | no durable guidebook rewrite needed |
| RUN171R_REPORT.md | yes | current report |

## Package Validation Table

| Package Check | Result | Evidence |
|---|---|---|
| zip exists | yes | `/mnt/data/TRUTH_SEEKER_RUN171R_CHANGED_FILES_WINDOWS_SAFE.zip` |
| zip size > 0 | yes | final validation before final response: 231004 bytes |
| file entries > 0 | yes | 11 changed file entries, 20 total zip entries including directories |
| expected root preserved | yes | every entry begins with `Aurora Sentinel Core/...` |
| all patched files included | yes | 7 source files + 3 control files + RUN171R report |
| source files included if changed | yes | Version, RuntimeState, Dispatcher, ScannerStatusWriter, Lite Contracts, Lite Composer, Lite Writer |
| guidebooks included if updated | n/a | no guidebook file changed; durable lessons recorded in report/control |
| report included | yes | `Aurora Sentinel Core/roadmap/Truth Seeker/Truth Seeker Reports/RUN171R_REPORT.md` |
| report filename Windows-safe | yes | `RUN171R_REPORT.md` |
| max internal path length checked | yes | final max internal path length: 83 characters |
| roadmap included if updated | yes | `Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md` |
| active roadmap log included if updated | yes | `Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` |
| manifest included if updated | yes | `Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` |
| version included if source changed | yes | `Aurora Sentinel Core/mt5/core/ASC_Version.mqh` |
| extraction test passed | yes | final extraction path `/mnt/data/run171_extract_test`, 11 files, 0 empty files |
| extracted files non-empty | yes | 11 non-empty extracted files |
| sandbox link target exists | yes | `/mnt/data/TRUTH_SEEKER_RUN171R_CHANGED_FILES_WINDOWS_SAFE.zip` |
| final answer link filename matches actual zip | yes | `TRUTH_SEEKER_RUN171R_CHANGED_FILES_WINDOWS_SAFE.zip` |
| empty zip risk | no | non-zero zip and file count validated |
| rootless zip risk | no | root folder preserved |
| Windows path-too-long risk | no | max path 83 in preliminary validation |
| broken download link risk | no | target path created and revalidated after final report refresh |

## RUN172R Next Prompt Seed

TRUTH SEEKER ROADMAP — RUN172R / FULL TRIPLE-CHECK BEFORE RUN173 LIVE — ACTIVATION, COMPILE-RISK, OUTPUT-PATH, PROTECTED-AREA, PERFORMANCE, AND NO-DRIFT AUDIT

RUN172R must read RUN171R report first, RUN170R report second, all guidebooks, and every changed RUN171R source file. It must prove activation patch reality, dispatcher callsite, bounded activation, writer path, output paths, Scanner Status/Manifest proof lines, protected-area preservation, no rank/order/formula drift, no FileIO rewrite, no heartbeat cadence change, no strategy/execution leakage, no full-universe publish loop, and static compile-risk. No live test in RUN172R. Return changed-files zip only if patch needed; otherwise report-only package. RUN173R remains live test.

## RUN173R Live Prompt Seed

TRUTH SEEKER ROADMAP — RUN173R / FULL LIVE PROOF AFTER LITE ACTIVATION — CHECK EVERYTHING

RUN173R must live-test compile output if supplied, source identity, runtime output package, Scanner Status, Artifact Bundle Manifest, Symbol Data Pack Lite final/temp/last-good/no-change behavior, Lite activation status, runtime callsite status, writer called, activation symbol/source, output paths, validation state, health/completeness/freshness/retry/last-good/publication health, Dossiers, Current Focus, Market Board, Top5PerBucket, GlobalTop10, FunctionResults logs, Experts/Journal logs if supplied, heartbeat/timer pressure, file write pressure, data-readiness, protected areas, and no signal/execution leakage.
