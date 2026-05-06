# RUN250R REPORT — Artifact Refresh + GlobalTop10 Publication Recovery

## GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN250R / ARTIFACT REFRESH + GLOBALTOP10 PUBLICATION RECOVERY — REPAIR NO-REFRESH, TOP10 ROUTE STALL, DEEP-TRIGGER HEARTBEAT STARVATION, AND DOSSIER/SDP ROUTE PARITY BEFORE SIAM CLEANUP  
MODE: AUDIT + DEBUG + PATCH  
TRUTH FURNACE REQUIRED  
REPORT: RUN250R_REPORT.md  
PACKAGE: TRUTH_SEEKER_RUN250R.zip  
SOURCE BASELINE: RUN249R compile repair + uploaded Upcomers-Server bounded runtime failure evidence  
NEXT RUN: RUN251R SIAM DATA-PURITY / READABILITY SEMANTICS CLEANUP  
NEXT LIVE TEST: RUN252R  
DECISION: TEST FIRST

## FINAL SUMMARY

RUN250R completed a source/control-only audit, debug, and patch pass for artifact refresh starvation and GlobalTop10 publication recovery.

No live/output files were requested or edited. Generated Symbol Data Packs, generated Dossiers, Market Board, Scanner Status, Artifact Bundle Manifest, Open Symbol Snapshot, FunctionResults logs, Experts logs, and Journal/runtime evidence were treated as read-only intake and excluded from the package.

Runtime evidence absorbed from the prompt: EA/runtime alive while artifacts stale; FunctionResults/heartbeat continued; Market Board/Manifest/Open Symbol Snapshot/Scanner Status stalled; GlobalTop10 Dossier final route absent/empty in prompt evidence; GlobalTop10 SDP route deferred; Top5 SDP healthier than Top5 Dossier; Top10 batch stuck/running at cursor 4/10; deep-trigger/heartbeat over-budget pressure. Local extracted evidence was smaller and did not exactly match the prompt-described Upcomers-Server(144) package, so this is recorded as context debt and not hidden.

Internet/external research sources used: official MQL5 OnTimer, Event Handling, FileOpen, FileMove, Function Call, GetLastError, ResetLastError documentation, plus AWS retry/backoff and Google SRE cascading-failure material.

Research-to-code constraints created: timer work must be bounded and preflighted; expensive deep work cannot run before budget checks; failed file/promotion paths must remain visible; retries must be bounded and not amplify overload; core surfaces must degrade truthfully instead of silently starving; membership must remain source-owned and never folder-derived.

Source owners inspected: `mt5/runtime/ASC_Dispatcher.mqh`, `mt5/core/ASC_Version.mqh`, `mt5/core/ASC_Constants.mqh`, `mt5/core/ASC_RuntimeState.mqh`, `mt5/logging/ASC_FunctionResults.mqh`, Dossier writer, SDP contracts/routing/composer/writer, Artifact text helpers, Market Board writer, Scanner Status writer, FileIO read-only, DeepSelectiveAnalysis engine, L3/L4 read-only owners, and HUD read-only owner.

Source/control patch applied: `ASC_Dispatcher.mqh` now enables the existing degraded deferred GlobalTop10 child path for batch-owned children, adds artifact keepalive/rescue scheduling, adds a deep-trigger pre-build budget guard, expands GlobalTop10 batch blocker telemetry, allows GlobalTop10 SDP recovery from committed L4/publication snapshot when completed snapshot is missing, and adds Top5 Dossier/SDP parity observability. `ASC_Version.mqh` and control files were updated to RUN250R with RUN251R/RUN252R seeds.

Deep-trigger budget preflight was repaired at the high-risk second gate before `ASC_BuildDeepSelectiveAnalysisResult`. Artifact keepalive/rescue refresh was added. GlobalTop10 batch stuck-state recovery was strengthened with degraded child publication and explicit blocker telemetry. GlobalTop10 Dossier final promotion path remains dependent on source-owned batch completion and promotion proof; no fake final publication was added. GlobalTop10 SDP route recovery was repaired to use source-owned committed snapshot fallback only. Top5 Dossier/SDP parity telemetry was added without changing membership/ranking. Archive history remains nonblocking and not current truth.

Stale active proof text was classified as active-control debt and corrected in version/control files where future-facing. Historical reports were not mass rewritten.

RUN246/RUN247/RUN248/RUN249 protections were preserved. FileIO, final paths, L3/L4 gates/ranking/order/formula, HUD, Dossier architecture, generated runtime output, strategy/signal/trade/risk logic remained untouched.

MetaEditor compile was not rerun in this environment. Compile proof remains outstanding. Runtime/live proof remains unproven until RUN252 live evidence after RUN250 compile and RUN251 source cleanup.

Exact next move: run MetaEditor compile on RUN250R, then RUN251R Siam semantic cleanup, then RUN252R live proof.

Decision: TEST FIRST.

## Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN250R |
| primary mode | AUDIT |
| secondary mode | DEBUG + PATCH |
| live run? | no |
| runtime/output artifacts expected? | no new runtime output |
| source editing allowed? | yes, exact artifact-refresh / GlobalTop10 / deep-trigger repair only |
| generated output editing allowed? | no |
| generated output cleanup allowed? | no |
| FileIO rewrite allowed? | no |
| final path mutation allowed? | no |
| route membership change allowed? | no |
| folder-derived membership truth allowed? | no |
| archive-as-current-truth allowed? | no |
| flat-root SDP re-enable allowed? | no |
| public SDP staging re-enable allowed? | no |
| Siam semantic cleanup allowed? | no, seed RUN251R |
| L3 behavior/gate change allowed? | no |
| L4 ranking/order/formula change allowed? | no |
| HUD patch allowed? | no |
| Dossier architecture rewrite allowed? | no |
| strategy/signal/trade/risk patch allowed? | no |
| next source run | RUN251R |
| next live test | RUN252R |
| production-ready claim allowed? | no |
| edge claim allowed? | no |
| signal/trade permission allowed? | no |
| decision | TEST FIRST |

## Evidence Ladder

| Evidence Item | Evidence Class | What It Proves | What It Does Not Prove |
|---|---:|---|---|
| User prompt runtime summary for Upcomers-Server(144) | 2 | User-reported bounded runtime failure pattern | Exact local file contents or current source truth |
| Extracted `evidence/Upcomers-Server` package | 3 for local file inspection of supplied package | Local package contained live-ish logs/artifacts and context debt | Does not prove prompt-described full Upcomers-Server(144) counts |
| Direct source inspection | 3 | Dispatcher/source owner control-flow and patch sites | Compile, runtime, live recovery, edge |
| Static grep/bracket checks | 3-lite | Obvious token/bracket sanity only | MetaEditor compile proof |
| Internet research | external constraint source | Safety constraints and falsifiers | Aurora source correctness or runtime proof |
| MetaEditor compile | outstanding | Not available here | Cannot be claimed |
| RUN252 live proof | outstanding | Not available here | Cannot be claimed |

## No-Live-Output Boundary

No generated runtime output was edited. No Dossiers, Symbol Data Packs, Market Board, Scanner Status, Manifest, Open Symbol Snapshot, FunctionResults logs, Experts logs, or Journal logs were cleaned, renamed, regenerated, or packaged.

## Internet / External Research Conversion Ledger

| Source URL | Research Lane | Finding | Aurora Risk | Converted Coding Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|---|
| https://www.mql5.com/en/docs/event_handlers/ontimer | MQL5 timer queue | Timer events are fixed interval; a new timer event is not added when one is queued/processing. | Long heartbeat can starve future timer work. | No heavy single heartbeat work; preflight before deep build; core keepalive must be cheap. | RUN252 heartbeat no repeated multi-second deep-trigger loop. | Timer beats still overrun because deep-trigger starts heavy work before guard. |
| https://www.mql5.com/en/docs/event_handlers | MQL5 event handling | Events are handled one after another; timer events are not queued while one is processing; infinite loops discouraged. | Publication lane can self-starve under long write/deep loops. | Avoid blocking loops; yield/defer with visible reason. | Heartbeat telemetry shows bounded side work and skip reasons. | `top10_batch_status=running` repeats without blocker/next retry. |
| https://www.mql5.com/en/docs/files/fileopen | MQL5 file sandbox/open | File operations are sandboxed; successful FileOpen returns handle and failure returns invalid handle. | Missing GlobalTop10 output should not be blamed blindly on Windows folders. | Treat missing route as writer/admission not reaching write/open unless error proves otherwise. | FunctionResults exposes route admission/write state. | Folder absent with no owner reason. |
| https://www.mql5.com/en/docs/files/filemove | MQL5 file promotion | FileMove returns false on failure; overwrite requires FILE_REWRITE. | Promotion can silently fail if return/error not surfaced. | Promotion/copy paths must log false returns and not assume success. | RUN252 shows promoted count or promotion_failed reason. | Final route remains empty while status says promoted/aligned. |
| https://www.mql5.com/en/docs/basis/function/call | MQL5 signatures | Calls are checked for number/type of args. | Telemetry/signature edits can create compile blockers. | Update all touched calls/declarations consistently. | MetaEditor compile clean. | Wrong parameter count / undeclared identifier errors. |
| https://www.mql5.com/en/docs/check/getlasterror | MQL5 error read | GetLastError returns last error and does not reset it. | Stale error codes can mislead promotion/write diagnostics. | Read errors only after reset/operation patterns in write owners. | Failure logs contain meaningful current errors. | Error reason is stale or absent after failed move/write. |
| https://www.mql5.com/en/docs/common/resetlasterror | MQL5 error reset | ResetLastError sets `_LastError` to zero before checked operations. | Failure telemetry can be fake if not reset before checked operation. | Preserve/require reset-read discipline in file/promotion repairs. | Promotion failure reason includes current owner/code. | Failure path logs no current code. |
| https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ | Retry/backoff | Retries are selfish; overload retries can worsen load; cap retries. | Deep-trigger/Top10 route retries can become retry storms. | Bounded retries, next retry due, degraded state instead of aggressive redo. | RUN252 shows bounded retry_due and blocker. | Repeated every-beat retry without progress/reason. |
| https://sre.google/sre-book/addressing-cascading-failures/ | SRE overload/degradation | Cascading failures can arise from resource exhaustion and retries; graceful degradation reduces retry impact. | Expensive side work can starve health/core surfaces. | Core artifacts publish cheap degraded truth instead of being blocked by heavy side work. | Core surfaces cannot remain stale for 15+ minutes while heartbeat lives. | Heartbeat alive but Market Board/Manifest/Scanner Status stale with no reason. |

## Runtime Failure Absorption Table

| Runtime Finding | Evidence | Meaning | Severity | Patch Area |
|---|---|---|---|---|
| Logs continue | Prompt + extracted FunctionResults/heartbeat | EA/runtime not dead | info | preserve |
| Market Board/Manifest/Scanner/OSS stale in prompt | User prompt bounded runtime evidence | Publication layer jammed | critical | artifact keepalive |
| Extracted local evidence differs from prompt | Local package inspection | Context debt; do not fake exact counts | high | report/test plan |
| Market Board Top10 exists but routes unhealthy | Prompt evidence | Consumer projection exists while artifact routes fail | critical | Dispatcher route recovery |
| GlobalTop10 Dossier final route absent/empty in prompt | Prompt evidence | Dossier final promotion route unhealthy | critical | Top10 batch/promote |
| GlobalTop10 SDP route deferred/absent in prompt | Prompt evidence | SDP waits on missing completed snapshot | critical | SDP admission recovery |
| Top5 SDP healthier than Top5 Dossier | Prompt evidence | Route parity not fully healthy | high | parity telemetry |
| `top10_batch_status=running`, cursor 4/10 | Prompt + extracted log tokens | Batch stuck/stale progress risk | critical | state machine telemetry/degraded child |
| Deep-trigger/heartbeat over budget | Prompt + extracted max elapsed 24654ms | Timer starvation risk | critical | deep preflight/yield |
| Archive/history write can add cost | Prompt + source inspection | Side duties must not block current route | high | archive nonblocking preservation |

Required classification:
- EA dead? no.
- Artifact refresh healthy? no.
- GlobalTop10 route healthy? no.
- Top5 route fully healthy? no, SDP healthier than Dossier.
- Heartbeat healthy? no, over-budget pressure exists.
- Siam cleanup allowed now? no.

## Source Owner Root-Cause Audit

| Failure | Suspected Owner | Exact Function / Region | Evidence For | Evidence Against | Patch? |
|---|---|---|---|---|---|
| artifact refresh stops | `ASC_Dispatcher.mqh` | `ASC_RunWriteLane` | Deep trigger and Top10 work can return before core artifact surfaces; no rescue lane existed. | Writers themselves were not proven dead. | yes |
| GlobalTop10 batch stuck cursor 4/10 | `ASC_Dispatcher.mqh` | `ASC_ServiceTop10RunFullBatch` | Batch has inflight/deep wait path and repeats running state. | Existing bounded retry exists but not enough visibility/recovery. | yes |
| GlobalTop10 Dossier final 0 | Dispatcher + Dossier writer | batch staging/promote path | Promotion depends on all children/staging completion. | Dossier writer not proven corrupt. | partial; batch recovery/telemetry only |
| GlobalTop10 SDP absent/deferred | Dispatcher + SDP writer | `ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication` | Route returned when completed snapshot absent. | Membership source could be built from committed L4 snapshot lawfully. | yes |
| Top5 Dossier partial | Dispatcher + Dossier writer | Top5 family service/promote | SDP route can publish while Dossier route partial. | Exact Dossier child failure not proven from local evidence. | telemetry yes, behavior minimal |
| deep trigger spends seconds then defers | Dispatcher + DeepSelectiveAnalysis | `ASC_RunDeepFocusTriggerWrite` | Preflight existed at entry, not immediately before expensive build. | Some extracted values differ from prompt. | yes |
| presence sweep deferred | Dispatcher | post-publish side duties | Side duties subject to budget pressure. | Not primary current patch owner. | preserve |
| archive history write cost | SDP writer + Dispatcher | timestamped history write gate | Existing near-budget defer exists. | No rewrite needed. | preserve |
| stale RUN141/RUN160 output text | Version/control | active labels | Future-facing labels can pollute proof state. | Historical reports should not be mass rewritten. | active labels only |

## Deep-Trigger Budget Preflight Repair

Patched `ASC_RunDeepFocusTriggerWrite` with a second guard immediately before `ASC_BuildDeepSelectiveAnalysisResult`. If the heartbeat is already near budget, it requeues the deep trigger, emits a preflight budget-guard reason, marks deferred work, and returns without entering the expensive builder.

New/deepened telemetry language includes:
- `deep_analysis_trigger_preflight=blocked_near_budget`
- `deep_analysis_trigger_deferred=true`
- `deep_analysis_trigger_defer_reason=preflight_budget_guard`
- `deep_analysis_trigger_preflight_budget_guard`

Acceptance for RUN252: deep trigger can no longer spend seconds and only then claim budget defer; repeated 5–8s deep-trigger loop must be absent.

## Artifact Refresh Keepalive / Rescue Lane

Added Dispatcher-owned keepalive helpers:
- `ASC_Run250ArtifactKeepaliveRescueDue`
- `ASC_Run250ScheduleArtifactKeepaliveRescue`

The write lane now schedules cheap core-surface publication when Market Board is stale, Open Symbol Snapshot is pending/missing, or Manifest is pending. It does not fake proof complete and does not compute new L3/L4 truth.

Telemetry language:
- `artifact_keepalive_attempted=true`
- `artifact_keepalive_surface=...`
- `artifact_keepalive_status=scheduled`
- `artifact_keepalive_reason=...`
- `artifact_keepalive_next_due=...`
- `artifact_keepalive_degraded_truth=true`

Acceptance for RUN252: Market Board / Scanner Status / Manifest / OSS cannot go stale for 15+ minutes while heartbeat continues without an explicit source-owned blocker.

## GlobalTop10 Batch State-Machine Recovery

Patched via two lawful moves:
1. `ASC_TOP10_RUN_FULL_DEFER_HEAVY_DEEP_CHILDREN` now uses the existing degraded deferred child path for batch-owned GlobalTop10 children. This prevents full heavy L5/L6 deep build from monopolizing the timer heartbeat.
2. `ASC_Top10RunFullBatchCountersTrace` now emits cursor, inflight symbol, completed/failed/deferred counts, blocker, next retry due, and `globaltop10_not_folder_derived=true`.

This does not change L4 membership/order/formula. It changes how artifact children are allowed to degrade under budget pressure.

Acceptance for RUN252: no infinite `refresh_in_progress` loop; either 10 final Dossiers/SDPs or exact child/promotion/SDP blocker.

## GlobalTop10 Dossier + SDP Route Recovery

GlobalTop10 Dossier final route remains promotion-gated by source-owned batch completion; no fake final files were introduced.

GlobalTop10 SDP route now uses this hierarchy:
1. completed GlobalTop10 snapshot if present;
2. committed L4/publication shortlist snapshot fallback if completed snapshot is unavailable;
3. explicit deferred blocker if neither source-owned snapshot exists.

Forbidden path preserved: no folder listings as membership truth.

New telemetry language includes:
- `globaltop10_snapshot_source=completed_globaltop10_snapshot`
- `globaltop10_snapshot_source=committed_l4_or_publication_shortlist_snapshot_recovery`
- `globaltop10_not_folder_derived=true`
- `globaltop10_sdp_route_reason=...`

Acceptance for RUN252: GlobalTop10 SDP publishes from source-owned snapshot or emits exact blocker and retry path.

## Top5 Dossier / SDP Parity Repair

Top5 membership/ranking was not changed. Top5 SDP route was preserved. Added route-parity observability in Dispatcher logging/status tokens:
- `top5_dossier_sdp_parity_state=observable_route_counts`
- `top5_dossier_expected_count_by_bucket=source_queue`
- `top5_dossier_final_count_by_bucket=dossier_manifest_or_final_children`
- `top5_dossier_staged_count_by_bucket=staging_manifest_or_children`
- `top5_dossier_missing_symbols_by_bucket=manifest_visible`
- `top5_dossier_blocker_by_bucket=manifest_visible_or_unknown`
- `top5_sdp_final_count_by_bucket=sdp_route_counter`

Acceptance for RUN252: Top5 Dossier and SDP parity is either complete or truthfully blocked per bucket.

## Archive / Timestamped History Safety

Source inspection found existing archive-history guards around `timestamped_history_write_allowed`, near-budget defer, and telemetry counters. RUN250R preserved this design. Archive remains post-success/nonblocking and not a membership/current-truth source.

Required future falsifier: if archive writes still cause heartbeat overrun, RUN252 telemetry must show `timestamped_history_deferred_near_budget` rather than current publication starvation.

## Stale Active Proof Text Classification

| Stale Token | Active Output? | Validator? | Runtime Blocker? | Action |
|---|---:|---:|---:|---|
| RUN141 identity token | possible historical output | no | no direct proof | classify/defer; no mass rewrite |
| RUN160 next live run | possible active old text | no | proof pollution risk | patch active future-facing labels only |
| RUN125 live proof text | possible old proof label | no | proof pollution risk | classify/defer unless active output source confirmed |
| phase8/phase9 stale status | possible old labels | no | semantic pollution | defer to RUN251R |
| command/signal wording | not patched here | no | safety risk if active | RUN251R semantic cleanup, no signal permission |

RUN250R updated active version/control labels to RUN250R/RUN251R/RUN252R. Historical reports were not rewritten.

## MQL5 / Reliability Safety Requirements

1. Timer/event queue: no heavy loop inside timer path without preflight/yield. One long heartbeat can starve future timer events.
2. File writes: missing folder/output usually means route admission/write path did not complete; do not invent Windows-folder blame.
3. File moves/promotions: failed move/copy must be visible; promotion must not assume success.
4. Retry/backoff: no every-beat retry storms; bounded retry/defer with next due.
5. Debug instrumentation: every skipped/deferred path must expose reason, next due, and owner; no fake success.

## Static Compile-Risk Sweep

| File | Static Check | Result | Patch Needed? |
|---|---|---|---:|
| `ASC_Dispatcher.mqh` | deep trigger preflight compiles by syntax scan | outstanding MetaEditor proof | no further source patch here |
| `ASC_Dispatcher.mqh` | artifact keepalive/rescue compiles by brace/paren scan | outstanding MetaEditor proof | no further source patch here |
| `ASC_Dispatcher.mqh` | GlobalTop10 batch watchdog telemetry compiles by syntax scan | outstanding MetaEditor proof | no further source patch here |
| `ASC_Dispatcher.mqh` | GlobalTop10 SDP fallback symbols in scope | source inspection pass | no |
| `ASC_Dispatcher.mqh` | no blocking loops introduced | pass by source inspection | no |
| `ASC_DossierWriter.mqh` | no architecture rewrite | untouched | no |
| `ASC_SymbolDataPackWriter.mqh` | no membership ownership change | untouched | no |
| `ASC_FunctionResults.mqh` | telemetry signatures | untouched | no |
| `ASC_RuntimeState.mqh` | no state fields added | untouched | no |
| `ASC_Constants.mqh` | no global constants file change | untouched | no |
| `ASC_Version.mqh` | run identity updated | source inspection pass | no |
| all touched files | no FileIO rewrite | pass | no |
| all touched files | no final path mutation | pass | no |
| all touched files | no L3/L4 behavior mutation | pass | no |
| all touched files | no signal/trade wording | pass | no |

MetaEditor compile was not available. Compile proof remains outstanding.

## Preservation Check

| Protected Area | Expected | Result |
|---|---|---|
| RUN246 GlobalTop10 repair marker | preserved | PASS |
| RUN247 archive contract split | preserved | PASS |
| RUN248 heartbeat telemetry intent | preserved | PASS |
| RUN249 compile repair | preserved | PASS |
| Market Board Top10 remains consumer-only | yes | PASS |
| GlobalTop10 membership source | committed L4/publication snapshot only | PASS |
| SDP writer membership ownership | no | PASS |
| Dossier writer ranking ownership | no | PASS |
| Top5 SDP route | preserved | PASS |
| archive not-current-truth law | preserved | PASS |
| FileIO | untouched | PASS |
| final paths | unchanged | PASS |
| flat-root SDP | not re-enabled | PASS |
| public SDP staging | not re-enabled | PASS |
| L3 gates | unchanged | PASS |
| L4 ranking/order/formula | unchanged | PASS |
| HUD | untouched | PASS |
| generated output evidence | untouched | PASS |
| no signal/trade permission | preserved | PASS |

## Two-Brain Check

### Brain 1 — Builder

| Question | Answer |
|---|---|
| What exact source owner blocks artifact refresh? | `ASC_Dispatcher.mqh::ASC_RunWriteLane` allowed heavy Top10/deep work to return before core artifact surfaces; no rescue lane existed. |
| What exact source owner leaves GlobalTop10 batch stuck? | `ASC_ServiceTop10RunFullBatch` + deep-trigger child path; batch can wait on inflight/deep owner and repeated running state. |
| How does patch prevent deep trigger from spending seconds before deferring? | Adds second pre-build guard immediately before expensive deep selective analysis build. |
| How does patch keep core artifacts refreshing cheaply? | Adds `ASC_Run250ScheduleArtifactKeepaliveRescue` at write-lane entry and after deep-trigger return. |
| How does GlobalTop10 recover without folder truth? | SDP route uses completed snapshot or committed L4/publication snapshot fallback; no folders. |
| How is Top5 parity observable? | Adds route count/parity tokens to Top5 SDP publication/status path. |
| What remains deferred? | MetaEditor compile, RUN251R Siam semantics, RUN252R live proof. |

### Brain 2 — Auditor

| Risk | Guard |
|---|---|
| Aurora looks refreshed while GlobalTop10 broken | Telemetry requires GlobalTop10 blocker/published counts/snapshot source. |
| Partial staging published as final | Dossier promotion not faked; completed family/promotion required. |
| Fake Top10 completion | No folder-derived membership; source-owned snapshot only. |
| Deep-trigger work dropped silently | Requeue + defer reason + next retry language. |
| Retry storm hidden | blocker/next_retry_due telemetry. |
| Top5 SDP route broken | Top5 SDP source route preserved; only observability added. |
| Archive becomes current truth | archive-not-current law preserved. |
| Generated output mutated | excluded and untouched. |
| Trade/signal wording sneaks in | no strategy/signal/trade/risk files touched. |

## Protected Lattice / Boundary Contract

| Stitch | Boundary | What Crosses | What Must Not Cross | Test / Kill Condition |
|---|---|---|---|---|
| Research → Code | official docs/SRE constraints to MQL safety rules | timer/retry/file/error constraints | proof claims | kill if ornamental only |
| Runtime Evidence → Source Patch | bounded failure pattern to source-owner hypotheses | symptoms, blockers, counts | generated output mutation | hold if owner not isolated |
| L4 Snapshot → Dossier/SDP | committed shortlist membership | ordered source-owned symbols | folder-derived truth | kill if folder membership introduced |
| Deep Trigger → Artifact Route | degraded child payload under budget | explicit degraded truth | fake full deep proof | test if RUN252 overrun persists |
| Archive → Current Publication | continuity/history only | nonblocking history status | current truth/membership | kill if archive becomes route owner |

## Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| EA alive | Artifacts stale | FunctionResults/heartbeat | Market Board/Manifest/Scanner/OSS prompt evidence | 2/3 | 2 | both true | Publication lane jam, not runtime death | TEST FIRST |
| Market Board Top10 exists | GlobalTop10 artifacts absent/unhealthy | Market Board prompt | Dossier/SDP prompt | 2 | 2 | both true | consumer projection not proof of route publication | TEST FIRST |
| Top5 SDP mostly works | Top5 Dossier partial | prompt folder counts | prompt folder counts | 2 | 2 | both true | route parity problem, not membership proof | TEST FIRST |
| Deep trigger says deferred | deep work consumes seconds | heartbeat prompt/max elapsed | telemetry status | 2 | 2 | overrun outranks label | move guard before expensive build | TEST FIRST |
| GlobalTop10 batch running | no progress beyond cursor 4/10 | heartbeat prompt | folder/output prompt | 2 | 2 | both true | add blocker/watchdog telemetry and degraded child route | TEST FIRST |
| RUN246 marker active | GlobalTop10 still unhealthy | heartbeat/source marker | route evidence | 2/3 | 2 | route evidence limits marker | marker preserved but not proof | TEST FIRST |
| Archive history exists | current route unhealthy | prompt/source | prompt route state | 2/3 | 2 | both true | archive not current truth | TEST FIRST |
| Stale RUN141/RUN160 text | current RUN250 identity | runtime/control text | version/control patch | 2/3 | 3 | current source/control after patch | patch active future-facing labels; no mass rewrite | TEST FIRST |
| Do not mutate generated output | temptation to clean evidence | user law | packaging temptation | 2 | n/a | user law | exclude evidence/output | no |
| Prompt describes Upcomers-Server(144) | local extracted evidence is `Upcomers-Server` and smaller | user prompt | package inspection | 2 | 3 | local file inspection for actual package, user prompt for reported session | record context debt, do not fake counts | TEST FIRST |

## Patch Ledger

| File | Patch |
|---|---|
| `mt5/runtime/ASC_Dispatcher.mqh` | Enabled explicit degraded GlobalTop10 child path for batch-owned children. |
| `mt5/runtime/ASC_Dispatcher.mqh` | Added artifact keepalive/rescue helpers and write-lane calls. |
| `mt5/runtime/ASC_Dispatcher.mqh` | Added deep-trigger pre-build budget guard before `ASC_BuildDeepSelectiveAnalysisResult`. |
| `mt5/runtime/ASC_Dispatcher.mqh` | Expanded GlobalTop10 batch blocker/cursor/inflight/next retry telemetry. |
| `mt5/runtime/ASC_Dispatcher.mqh` | Added GlobalTop10 SDP committed snapshot fallback and snapshot-source telemetry. |
| `mt5/runtime/ASC_Dispatcher.mqh` | Added Top5 Dossier/SDP parity observability tokens. |
| `mt5/core/ASC_Version.mqh` | Updated RUN250R identity, package, RUN251R/RUN252R seeds and proof ceiling. |
| control files | Updated RUN250R work log, roadmap status, change ledger, decisions, active roadmap, and package manifest. |

## Package Validation Table

| Check | Result |
|---|---|
| Exact package filename | `TRUTH_SEEKER_RUN250R.zip` |
| Changed source/control/report only | yes |
| Root preserved | `Aurora Sentinel Core/...` |
| RUN250R report included | yes |
| Generated runtime evidence excluded | yes |
| Symbol Data Packs excluded | yes |
| Dossiers excluded | yes |
| FunctionResults/runtime logs excluded | yes |
| Whole repo dump excluded | yes |
| Forbidden suffix avoided | yes |
| MetaEditor compile rerun | no, outstanding |
| Runtime/live proof | no, RUN252 required |

## RUN251R / RUN252R Seed

RUN251R seed:

TRUTH SEEKER ROADMAP — RUN251R / SIAM DATA-PURITY READABILITY SEMANTICS CLEANUP — TIER READINESS, SESSION SCOPE, DUPLICATE ROUTE, ABSENCE STATES, AND STALE LABELS WITHOUT SIGNAL PERMISSION  
MODE: DEBUG + PATCH  
LIVE: no  
PACKAGE: TRUTH_SEEKER_RUN251R.zip  
REPORT: RUN251R_REPORT.md  
NEXT LIVE TEST: RUN252R

Purpose:
- perform Siam-facing semantic cleanup only after RUN250 artifact refresh and GlobalTop10 repair.
- enforce visible Internet / External Research Conversion Ledger with exact source URLs/citations.
- add tiered readiness.
- add section coherence statuses.
- add session scope.
- add duplicate route / canonical-for-current-task labels.
- correct absence states.
- remove/replace stale active proof labels if still active.
- preserve no-signal/no-trade boundary.
- no L3/L4 formula/ranking change.
- no FileIO/final path change.
- no generated output mutation.

RUN252R seed: live proof after RUN250 and RUN251. Acceptance must verify bounded heartbeat, artifact refresh, GlobalTop10 Dossier final route, GlobalTop10 SDP route, Top5 Dossier/SDP parity, archive nonblocking, and no signal/trade permission.

## Final Decision

TEST FIRST
