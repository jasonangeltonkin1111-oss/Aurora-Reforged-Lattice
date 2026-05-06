# RUN248R Report — Heartbeat Deep-Payload and Presence-Sweep Hardening

## GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN248R / HEARTBEAT DEEP-PAYLOAD AND PRESENCE-SWEEP HARDENING — CAP DEEP ANALYSIS TRIGGER, TOP5 CHILD PAYLOAD, ARCHIVE WRITE, AND POST-PUBLISH PRESENCE SWEEP BEFORE LIVE PROOF  
MODE: DEBUG + PATCH  
TRUTH FURNACE REQUIRED  
REPORT: RUN248R_REPORT.md  
PACKAGE: TRUTH_SEEKER_RUN248R.zip  
SOURCE BASELINE: RUN247R ARCHIVE CONTRACT REPAIR  
NEXT RUN: RUN249R SIAM DATA-PURITY / READABILITY SEMANTICS CLEANUP  
NEXT LIVE TEST: RUN250R  
DECISION: TEST FIRST

## FINAL SUMMARY

RUN248R was completed as a source/control DEBUG + PATCH run only. No live/output files were requested or used as proof, and no generated Symbol Data Packs, Dossiers, Market Board, Scanner Status, Manifest runtime output, FunctionResults runtime evidence, Experts logs, or Journal logs were edited, cleaned, renamed, deleted, regenerated, or packaged.

Exact heartbeat/deep-payload/presence-sweep/archive-write owners inspected:

- Heartbeat entry and write-lane orchestration: `mt5/runtime/ASC_Dispatcher.mqh::ASC_RunHeartbeat` and `ASC_RunWriteLane`.
- Deep analysis trigger publication: `mt5/runtime/ASC_Dispatcher.mqh::ASC_RunDeepFocusTriggerWrite`.
- Top5 deep child payload attachment: `ASC_RunDeepFocusTriggerWrite` branch for `ASC_Top5BucketDeepOrigin`.
- Post-publish presence sweep: `ASC_RunHeartbeat` post-lane `ASC_RefreshDossierPresenceCounters` path.
- Timestamped archive history write: `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh::ASC_SymbolDataPackTryPublishAtomicForRoute` and `ASC_SymbolDataPackTryWriteTimestampedHistoryForRoute`, called by Dispatcher GlobalTop10 and Top5PerBucket SDP route mirror services.

Exact source/control patch applied:

- Added RUN248 heartbeat budget constants and telemetry required fields in `mt5/core/ASC_Constants.mqh`.
- Advanced run identity/package/next-run state in `mt5/core/ASC_Version.mqh`.
- Extended heartbeat log header fields in `mt5/runtime/ASC_Bootstrap.mqh`.
- Added Dispatcher budget/defer helpers, deep trigger requeue/defer control, Top5 child payload guard, post-publish presence sweep guard, archive-history budget permission, and compact/full telemetry output in `mt5/runtime/ASC_Dispatcher.mqh`.
- Added timestamped-history write permission/defer reason parameters in `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh`, preserving final publication as current truth and making timestamped history nonblocking near budget.
- Updated office/control/report files for RUN248R and seeded RUN249R.

Deep analysis trigger cap/defer was added. Top5 deep child payload cap/defer was added. Post-publish presence sweep cap/defer was added. Archive timestamped-history budget guard was added. Deferred queue counters/control were preserved and made more visible through heartbeat telemetry. Telemetry fields for RUN250 were added to required heartbeat fields, compact/full heartbeat lines, and heartbeat log header.

RUN246 GlobalTop10 repair was preserved. RUN247 archive contract repair was preserved. FileIO, final paths, flat-root SDP, public SDP staging, L3/L4 gates/ranking/formula, HUD, Dossier architecture, Market Board architecture, generated output, and strategy/signal/trade/risk logic remained untouched.

MetaEditor compile was not rerun in this environment, so compile proof is outstanding. Runtime/live heartbeat proof, archive-history runtime behavior, freeze resistance, throughput improvement, production readiness, edge, and any signal/trade/execution/risk permission remain unproven until RUN250R live proof after RUN249R unless explicitly overridden.

Exact next move: RUN249R Siam data-purity readability semantics cleanup.

## Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN248R |
| primary mode | DEBUG |
| secondary mode | PATCH |
| live run? | no |
| runtime/output artifacts expected? | no new runtime output |
| source editing allowed? | yes, heartbeat/deep-payload/presence-sweep/archive-write hardening only |
| generated output editing allowed? | no |
| generated output cleanup allowed? | no |
| FileIO rewrite allowed? | no |
| final path mutation allowed? | no |
| current route membership change allowed? | no |
| archive-as-current-truth allowed? | no |
| flat-root SDP re-enable allowed? | no |
| public SDP staging re-enable allowed? | no |
| GlobalTop10 route behavior patch allowed? | no; RUN246 preserved only |
| archive contract rewrite allowed? | no; RUN247 preserved only |
| L3 behavior/gate change allowed? | no |
| L4 ranking/order/formula change allowed? | no |
| HUD patch allowed? | no |
| Dossier architecture rewrite allowed? | no |
| Siam semantic cleanup allowed? | no; seeded RUN249 only |
| strategy/signal/trade/risk patch allowed? | no |
| next source run | RUN249R |
| next live test | RUN250R |
| production-ready claim allowed? | no |
| edge claim allowed? | no |
| signal/trade permission allowed? | no |
| final serious decision | TEST FIRST |

## Evidence Ladder

| Evidence Item | Class | What It Proves | What It Does Not Prove |
|---|---:|---|---|
| RUN247R source package baseline | 3 | archive contract source state exists in active files | compile/live behavior |
| Direct RUN248R source inspection | 3 | owner locations and source patch content | runtime performance or execution correctness |
| Static text/brace/grep sweep | 3 | no obvious text-level forbidden changes and no `Sleep()` inserted | MetaEditor compile success |
| MetaEditor compile output | not supplied | none | compile clean remains outstanding |
| RUN250 live proof | not run | none in RUN248R | heartbeat/runtime/archive proof remains outstanding |

## No-Live-Output Boundary

- No live test was run.
- No runtime output was requested.
- No generated Symbol Data Packs, Dossiers, Market Board, Scanner Status, Manifest runtime files, FunctionResults runtime evidence, Experts logs, or Journal logs were mutated.
- Prior heartbeat numbers were treated as read-only intake from reports/user-provided context, not as source truth.
- Active source files remained the only patch authority.

## RUN247 Safety Gate

| RUN247 Feature | Expected | Observed | PASS / HOLD / FAIL | Action |
|---|---|---|---|---|
| previous_state_cache folder constant | `_previous_state_cache` | `ASC_SYMBOL_DATA_PACK_PREVIOUS_STATE_CACHE_FOLDER` present | PASS | preserve |
| timestamped_history folder constant | `archive` | `ASC_SYMBOL_DATA_PACK_TIMESTAMPED_HISTORY_FOLDER` present | PASS | preserve |
| SDP previous-state cache role labels | continuity fallback only | previous-state cache role and reader policy present | PASS | preserve |
| SDP timestamped history labels | historical comparison only | timestamped history family/role/envelope present | PASS | preserve |
| archive_not_current_truth=true | present | present in SDP writer/composer/manifest labels | PASS | preserve |
| archive_not_membership_source=true | present | present in SDP writer/composer/manifest labels | PASS | preserve |
| archive_not_ranking_source=true | present | present in SDP writer/composer/manifest labels | PASS | preserve |
| archive_not_siam_canonical_selection=true | present | present in SDP writer/composer/manifest labels | PASS | preserve |
| archive_not_current_route_reconciliation_source=true | present where relevant | present in route/archive manifests | PASS | preserve |
| timestamped history write is post-final-success only | yes | writer attempts timestamped history only after final success/readback/no-material logic | PASS | preserve |
| timestamped history failure is nonblocking | yes | `timestamped_history_nonblocking=true` and failure does not block current final publication | PASS | preserve |
| RUN246 GlobalTop10 repair preserved | yes | `run246_globaltop10_repair_marker=active` and route context repair remain present | PASS | preserve |
| FileIO untouched | yes | `mt5/io/ASC_FileIO.mqh` unchanged | PASS | preserve |
| L3/L4 unchanged | yes | L3/L4 source owners unchanged | PASS | preserve |
| compile proof supplied | optional | not supplied / not rerun | HOLD for proof only | state outstanding |

## Prior Heartbeat Failure Absorption

| Runtime Pressure | Evidence | Likely Owner | Severity | RUN248 Action |
|---|---|---|---|---|
| `deep_analysis_trigger_published` | prior heartbeat evidence/report context | Dispatcher / Deep Selective Analysis trigger publisher | high | cap/defer/requeue before heavy publish and before final publish |
| `top5_deep_child_payload_attached` | prior heartbeat evidence/report context | Dispatcher / Dossier Top5 child payload attach branch | high | cap/defer and emit attempted/attached/deferred telemetry |
| `sweep_post_publish_presence_deferred_near_write_budget` | prior heartbeat evidence/report context | Dispatcher post-publish presence sweep | high | defer near budget and emit next retry due |
| archive timestamped history write | RUN247 source path | SDP writer / Dispatcher route services | medium/high | budget permission flag; nonblocking defer near budget |
| deferred queue pressure | prior heartbeat evidence/report context | Dispatcher deferred/write queue | high | preserve cap/drain telemetry; expose remaining counts |
| publication retry/backoff | prior failures/report context | Dispatcher/status/manifest writers | medium | preserve bounded retry visibility; no retry storm patch beyond source-owned telemetry |
| Top10 side-duty | prior improved but still relevant | Dispatcher | medium | preserve RUN241/RUN246; no route mutation |

Required diagnosis:

- Deep trigger owner: `ASC_RunDeepFocusTriggerWrite`.
- Top5 child payload attach owner: `ASC_RunDeepFocusTriggerWrite` Top5 bucket branch.
- Presence sweep owner: `ASC_RunHeartbeat` post-lane side-duty block.
- Timestamped archive history owner: `ASC_SymbolDataPackTryPublishAtomicForRoute` / `ASC_SymbolDataPackTryWriteTimestampedHistoryForRoute`, invoked by Dispatcher SDP route services.
- These can be sliced/yielded without dropping work by setting defer state, preserving pending trigger, requeueing source-owned request fields, and carrying telemetry.
- Existing budget telemetry existed, but RUN248 adds missing per-family proof fields for RUN250.
- Archive writes do not own current truth and now can defer without blocking final publication.

## Heartbeat Owner Source Audit

| Source Area | Function / Region | Current Behavior | Risk | Patch Needed? |
|---|---|---|---|---:|
| heartbeat entry | `ASC_RunHeartbeat` / OnTimer path | one heartbeat services scan/write/read/side duties | long handler blocks future timer events | yes |
| write lane / persistence lane | `ASC_RunWriteLane` | routes write work and side duties with existing budget guards | route publish overrun | yes, targeted telemetry/guards |
| deep analysis trigger publish | `ASC_RunDeepFocusTriggerWrite` | could build/compose/publish trigger payload in one beat | heavy trigger in one beat | yes |
| Top5 deep child payload attach | `ASC_RunDeepFocusTriggerWrite` Top5 branch | attached child payload after deep build | payload attach over budget | yes |
| post-publish presence sweep | post-lane `ASC_RefreshDossierPresenceCounters` | sweep attempted after write lane | sweep hammers after publish | yes |
| archive timestamped history write | SDP writer / route writer | RUN247 adds timestamped history after final success | new archive write cost | yes |
| deferred queue drain | Dispatcher write/deferred telemetry | counters existed; visibility needed strengthened | backlog / over-drain | verify/preserve |
| publication retry/backoff | Dispatcher / writers | existing cooldown and missing dependency labels | retry storm if hidden | verify/preserve |
| FunctionResults logging | `ASC_FunctionResults` | read-only | spam/string cost | no patch |
| telemetry emission | Dispatcher / Bootstrap | missing RUN248 family-specific fields | insufficient proof fields | yes |

Smallest safe patch: patch Dispatcher admission/defer/telemetry and SDP writer archive-history permission only. Read-only owners remained read-only: FileIO, L3/L4, HUD, deep engine internals, Dossier architecture, Current Focus except through existing Dispatcher deep trigger path.

## Patch Objectives

| Objective | Result |
|---|---|
| Deep analysis trigger cap | Added initial and pre-publish budget guards; pending work is deferred/requeued with reason and next retry due. |
| Top5 deep child payload cap | Added budget guard before Top5 child payload staging/promote; emits attempted/attached/deferred count and reason. |
| Post-publish presence sweep cap | Added near-budget defer path; sweep completion is not faked when skipped. |
| Archive write budget guard | Added timestamped-history write permission/defer reason; final current publication remains nonblocking. |
| Deferred queue control | Preserved existing counters and made RUN248 defer families visible in heartbeat telemetry. |
| Publication retry/backoff | Preserved existing dependency/cooldown behavior; no hammer loop added. |
| No silent discard | Deferred deep trigger work is requeued; side work marks `write_dirty` / deferred counters. |
| No fake success | Deferred trigger/sweep/history are labeled deferred, not completed. |
| No heartbeat budget inflation | Existing budget remains; work yields instead. |
| No `Sleep()` / spin loop | Static grep found no `Sleep(` insertion in touched files. |

## Telemetry Contract for RUN250

| Family | Fields Added / Verified |
|---|---|
| Heartbeat/workload | `heartbeat_budget_ms`, `heartbeat_elapsed_ms`, `heartbeat_over_budget_reason`, `major_work_type`, `write_lane_elapsed_ms`, `side_duty_ms`, `deep_analysis_trigger_ms`, `top5_deep_child_payload_ms`, `presence_sweep_ms`, `archive_history_write_ms`, `deferred_work_count`, `deferred_processed_this_beat`, `deferred_remaining` |
| Deep trigger | `deep_analysis_trigger_attempted`, `deep_analysis_trigger_published`, `deep_analysis_trigger_deferred`, `deep_analysis_trigger_defer_reason`, `deep_analysis_trigger_next_retry_due` |
| Top5 child payload | `top5_deep_child_payload_attempted`, `top5_deep_child_payload_attached_count`, `top5_deep_child_payload_deferred_count`, `top5_deep_child_payload_defer_reason` |
| Presence sweep | `presence_sweep_attempted`, `presence_sweep_completed`, `presence_sweep_deferred`, `presence_sweep_defer_reason`, `presence_sweep_next_retry_due` |
| Archive | `timestamped_history_attempted`, `timestamped_history_saved_count`, `timestamped_history_deferred_count`, `timestamped_history_defer_reason`, `timestamped_history_failed_count`, `timestamped_history_nonblocking=true` |
| Publication retry | `publication_retry_skipped_count`, `publication_next_retry_due`, `manifest_dependency_missing`, `manifest_next_retry_due` preserved in required heartbeat fields |

Telemetry exposes deferred work. It does not prove runtime improvement until RUN250.

## MQL5 Timer / File Safety Requirements

| Constraint | Source Impact | RUN248 Rule |
|---|---|---|
| Timer event non-stacking | long work starves heartbeat | yield/defer heavy work |
| FileOpen subfolder creation | archive/history paths viable | path remains source-owned and sandboxed |
| FileMove false on overwrite without FILE_REWRITE | promotion/archive must log failures | no guessed success; FileIO untouched |
| sandboxed file access | no external path assumptions | preserve server-root doctrine |
| FileIO not rewritten | use existing helpers | patch owners, not FileIO |

Research sources used as constraints: MQL5 OnTimer/EventSetTimer and event queue documentation; MQL5 FileOpen/FileMove/file-function documentation. These facts constrain the design but do not prove Aurora runtime behavior.

## Multi-Domain Research Lattice

| Research Lane | Source / Authority | Finding | Converted RUN248 Constraint | Falsifier |
|---|---|---|---|---|
| MQL5 timer/event behavior | Official MQL5 AlgoBook / event queue docs | Timer events are not queued while a timer event is queued or processing | no long blocking heartbeat; defer heavy work | RUN250 shows long timer starvation remains from patched families |
| MQL5 file operations | Official MQL5 FileOpen/FileMove docs | file operations are sandboxed; FileOpen can create subfolders; FileMove overwrite needs FILE_REWRITE | preserve FileIO/server-root doctrine; do not rewrite FileIO | archive writes fail silently or paths mutate |
| Reliability / SRE | retry/backoff reliability pattern | retry storms and unbounded work create self-inflicted outages | bounded retry/defer with next retry visibility | repeated every-beat retries with same missing dependency |
| Queueing / cooperative scheduling | cooperative scheduling pattern | per-beat caps/yields preserve responsiveness without losing work | min-remaining guards and requeue/deferred counters | deferred count drops without corresponding completion |
| Observability | operational telemetry practice | counters/reasons/next due make skipped work auditable | add compact heartbeat fields for RUN250 | skipped work appears as success or disappears |
| Protected lattice | Aurora source-truth doctrine | boundaries prevent false ownership leaks | heartbeat ↔ archive/deep/sweep interfaces must expose state and not own truth | archive/current-truth or HUD/deep/ranking ownership collapse |

## RUN247 / RUN246 Preservation Check

| Protected Area | Expected | PASS / HOLD / FAIL |
|---|---|---|
| RUN246 GlobalTop10 repair marker | preserved | PASS |
| RUN246 GlobalTop10 route telemetry | preserved | PASS |
| RUN246 Manifest upload-root repair | preserved | PASS |
| RUN247 previous_state_cache split | preserved | PASS |
| RUN247 timestamped_history split | preserved | PASS |
| archive_not_current_truth law | preserved | PASS |
| archive_not_membership_source law | preserved | PASS |
| archive_not_ranking_source law | preserved | PASS |
| GlobalTop10 final route path | unchanged | PASS |
| Top5PerBucket final route path | unchanged | PASS |
| SDP final route path | unchanged | PASS |
| Dossier final route path | unchanged | PASS |
| FileIO validation strictness | preserved | PASS |
| L3 gates | unchanged | PASS |
| L4 ranking/order/formula | unchanged | PASS |
| Market Board Top10 | consumer-only | PASS |
| SDP writer | consumer/projection only | PASS |
| Dossier writer | writer/composer only | PASS |
| generated output evidence | untouched | PASS |
| no signal/trade permission | preserved | PASS |

## Brain Guidebook / Two-Brain Check

| Guidebook | Read? | Key Rule Extracted | Converted RUN248 Constraint | Patch Needed? |
|---|---:|---|---|---:|
| `AURORA_GUIDEBOOK_INDEX.md` | yes | guidebooks are law before source patching | read before patch; convert rules into constraints | no guidebook edit |
| `AURORA_CODING_BRAIN_GUIDEBOOK.md` | yes | patch smallest source owner; never fake proof; preserve source of truth | Dispatcher/SDP writer only; no FileIO/path/L3/L4/HUD rewrite | yes in owners |
| `AURORA_TRADING_BRAIN_GUIDEBOOK.md` | yes | scanner output is not trade permission | no signal/trade/risk wording or logic | no trading patch |

Builder answer: the smallest safe patch is budget-aware defer/requeue in Dispatcher plus a timestamped-history permission gate in SDP writer. Heavy delay owners are deep trigger, Top5 child payload attach, presence sweep, and timestamped history writes. Deferrable work: deep trigger publish, Top5 child attach, presence sweep, and archive history. RUN250 needs per-family attempted/completed/deferred/reason/next-retry telemetry. RUN246/RUN247 are preserved by not mutating route membership, final paths, archive law, FileIO, L3/L4, or generated output.

Auditor answer: Aurora can look faster by silently skipping deep trigger, Top5 payload, presence sweep, or history writes. That is why each skipped family now requires defer reason and retry/backlog visibility. Work can be lost if pending flags are cleared without publish; RUN248 requeues deep trigger on defer. Proof can be hidden if deferred sweep/history looks complete; RUN248 labels deferred separately. Final publication can be blocked if archive history is treated as current truth; RUN248 keeps timestamped history nonblocking. No L3/L4, generated output, or signal wording was introduced.

## Protected Lattice / Boundary Contract

| Boundary | System A | System B | Lawful Interface | Source Of Truth | Allowed Crossing | Forbidden Crossing | Acceptance Criteria | HOLD / KILL Condition |
|---|---|---|---|---|---|---|---|---|
| heartbeat ↔ deep trigger | timer budget | deep analysis trigger | bounded attempt/defer | Dispatcher/deep owner | reasoned trigger status | blocking trigger | bounded work | 8s+ trigger persists in RUN250 |
| heartbeat ↔ Top5 child payload | timer budget | child payload attach | bounded slice | Dispatcher/Dossier owner | count/reason | all-at-once heavy attach | yield visible | payload freeze |
| heartbeat ↔ presence sweep | timer budget | post-publish sweep | defer near budget | Dispatcher | sweep status | fake complete | bounded sweep | sweep blocks final path |
| heartbeat ↔ archive history | timer budget | timestamped history | post-success bounded archive | final publication | history status | archive blocks current truth | nonblocking archive | archive freezes/current truth collapse |
| deferred queue ↔ truth preservation | backlog | future work | cap + telemetry | Dispatcher | work state | silent drop | backlog visible | work lost |
| source patch ↔ generated evidence | active source | runtime output | future proof only | source files | checklist/report | output mutation | evidence untouched | generated edit |
| data review ↔ trade permission | scanner data | trading action | no-permission boundary | Trading Brain law | review labels | buy/sell/entry | permission false | signal wording |

## Static Compile-Risk Sweep

| File | Static Check | Result | Patch Needed? |
|---|---|---|---:|
| `ASC_Dispatcher.mqh` | no blocking/infinite loop introduced | PASS by grep; no `Sleep(` in touched files | no |
| `ASC_Dispatcher.mqh` | elapsed-time/defer checks compile | STATIC ONLY; MetaEditor not run | compile outstanding |
| `ASC_Dispatcher.mqh` | deep trigger deferral state compiles | STATIC ONLY; MetaEditor not run | compile outstanding |
| `ASC_Dispatcher.mqh` | Top5 child payload cap compiles | STATIC ONLY; MetaEditor not run | compile outstanding |
| `ASC_Dispatcher.mqh` | presence sweep deferral compiles | STATIC ONLY; MetaEditor not run | compile outstanding |
| `ASC_Dispatcher.mqh` | deferred queue counters compile | STATIC ONLY; MetaEditor not run | compile outstanding |
| `ASC_SymbolDataPackWriter.mqh` | archive history nonblocking preserved | PASS by source inspection | compile outstanding |
| `ASC_FunctionResults.mqh` | telemetry signatures compile if touched | not touched | no |
| `ASC_RuntimeState.mqh` | state fields compile if added | not touched | no |
| `ASC_Constants.mqh` | constants compile if added | STATIC ONLY; MetaEditor not run | compile outstanding |
| `ASC_Version.mqh` | run identity updated | PASS by source inspection | compile outstanding |
| all touched files | no FileIO rewrite | PASS | no |
| all touched files | no final path mutation | PASS | no |
| all touched files | no L3/L4 behavior mutation | PASS | no |
| all touched files | no signal/trade wording | PASS | no |

Brace-balance text sweep after patch showed matched brace counts in touched MQL files. This is not compile proof.

## Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| Faster heartbeat means skip heavy work | Skipped truth must remain visible/retryable | runtime pressure premise | Aurora doctrine/guidebooks | 2 | 3 | doctrine/source patch outranks | defer/requeue/telemetry instead of silent skip | no |
| Archive history should be written after every final success | Timer budget must not be blocked by history evidence | RUN247 archive contract | MQL5 timer constraint + heartbeat risk | 3 | 3 | both retained through boundary | nonblocking defer near budget after final success | no |
| Presence sweep helps proof | Presence sweep can block final publication | prior heartbeat evidence | Dispatcher source inspection | 2 | 3 | source inspection | defer sweep and label not complete | no |
| Deferred work can be reduced to make telemetry look clean | Deferred work must not be lost | temptation/risk | Truth Furnace + source patch | 1 | 3 | source patch | requeue/counters/remaining fields | no |
| RUN248 may shortcut archive contract for speed | RUN247 archive law must be preserved | patch pressure | RUN247 source | 1 | 3 | RUN247 source | no archive/current-truth collapse; no path mutation | no |
| RUN248 can touch GlobalTop10 route behavior | RUN246 repair must be preserved | patch pressure | RUN246/RUN247 source markers | 1 | 3 | source markers | no route behavior rewrite | no |
| Generated evidence could be cleaned for package | Generated evidence mutation fakes proof | package pressure | user scope/source doctrine | 1 | 3 | user scope/doctrine | exclude generated outputs | no |
| Better data may imply trade signal | Scanner data is not trade permission | trading temptation | Trading Brain law | 1 | 3 | Trading Brain law | no signal/trade/risk wording | no |

## Patch Ledger

| File | Patch |
|---|---|
| `mt5/core/ASC_Constants.mqh` | RUN248 budget constants and telemetry required fields. |
| `mt5/core/ASC_Version.mqh` | RUN248 identity, package, evidence ceiling, RUN249 seed, TEST_FIRST decision. |
| `mt5/runtime/ASC_Bootstrap.mqh` | heartbeat log header extended for RUN250 telemetry. |
| `mt5/runtime/ASC_Dispatcher.mqh` | deep trigger defer/requeue, Top5 child payload cap, presence sweep cap, archive history guard, telemetry output. |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | timestamped history write permission/defer state and nonblocking telemetry reason. |
| control/report files | RUN248R status, work log, change ledger, decisions, active roadmap log, package manifest, report. |

## Package Validation Table

| Check | Result |
|---|---|
| exact package name | `TRUTH_SEEKER_RUN248R.zip` required |
| changed files only | yes; source/control/report only |
| root folder preserved | `Aurora Sentinel Core/...` |
| report included | `roadmap/Truth Seeker/Truth Seeker Reports/RUN248R_REPORT.md` |
| generated Symbol Data Packs excluded | yes |
| generated Dossiers excluded | yes |
| generated runtime manifests/status/FunctionResults excluded | yes |
| Experts/Journal logs excluded | yes |
| whole repo dump excluded | yes |
| FileIO excluded | yes |
| final paths/L3/L4/HUD/Dossier architecture excluded | yes |
| compile proof included | no; outstanding |
| live proof included | no; RUN250 required |

## Exact RUN249 Prompt Seed

TRUTH SEEKER ROADMAP — RUN249R / SIAM DATA-PURITY READABILITY SEMANTICS CLEANUP — TIER READINESS, SESSION SCOPE, DUPLICATE ROUTE, ABSENCE STATES, AND STALE LABELS WITHOUT SIGNAL PERMISSION
MODE: DEBUG + PATCH
LIVE: no
PACKAGE: TRUTH_SEEKER_RUN249R.zip
REPORT: RUN249R_REPORT.md
NEXT LIVE TEST: RUN250R

PURPOSE:
- clean Siam-facing data readability after route/archive/heartbeat repairs.
- add tiered readiness instead of blunt dirty/pass labels.
- clarify session scope and active/closed buckets.
- clarify duplicate route and canonical-for-current-task labels.
- fix absence states so alive quote data is not called dirty absence.
- remove/replace stale RUN238 verification labels.
- preserve no-signal/no-trade/no-execution/no-risk boundary.
- no L3/L4 formula/ranking change.
- no generated output mutation.
- no FileIO rewrite.
- no final path mutation.

## Final Decision

TEST FIRST.
