# RUN239R REPORT — Crash/Freeze Root-Cause Audit After RUN238 Live Failure

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN239R / CRASH-FREEZE ROOT CAUSE AUDIT AFTER RUN238 LIVE FAILURE — FIND WHY EA FREEZES/CRASHES BEFORE PATCHING PUBLICATION OR DATA SEMANTICS
MODE: AUDIT + DEBUG
TRUTH FURNACE REQUIRED
REPORT: RUN239R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN239R.zip
SOURCE BASELINE: RUN238R COMPILE-CLEAN SOURCE STATE
NEXT PATCH RUN: RUN240R ONLY AFTER ROOT CAUSE AUDIT
FINAL DECISION: HOLD
```

```text
FINAL SUMMARY

RUN239R is audit-only. No source patch was applied. No generated output was edited. No live run was requested. The supplied RUN238 runtime evidence was read-only evidence.

Hard crash is NOT proven. Experts and Journal logs were absent, MetaEditor compile output was absent, and no terminal exception/EA removal evidence was supplied. The user report that the EA crashed remains respected, but the supplied evidence cannot upgrade it to a proven hard crash.

Freeze/starvation is proven as the strongest failure class from available evidence. heartbeat_telemetry.log shows 77 heartbeat rows, 73 above the 880ms budget, 47 above 1200ms, 5 above 2000ms, and 4 above 5000ms. The worst heartbeat was 24654ms against an 880ms budget at 2026.05.03 13:27:33, lane=persistence, major_work_type=persistence, side_duty_ms=24809, top10_ms=24654, deferred_work_count=1036. That is enough to explain terminal freeze / apparent crash without proving a terminal exception.

Publication failure loop is proven for Scanner Status and Market Board required-token contracts. FunctionResults shows 89 Scanner Status write errors with missing_token=missing_runtime_surface_classification=missing_runtime_surface. Source inspection confirms ASC_ScannerStatusWriter.mqh requires missing_runtime_surface_classification=missing_runtime_surface while ASC_ArtifactTextHelpers.mqh emits missing_runtime_surface_classification=policy_declared. FunctionResults also shows 4 Market Board errors with missing_token=Operator Command Surface. Source inspection confirms ASC_MarketBoardWriter.mqh emits Siam Review Intake Surface while its required-token list still requires Operator Command Surface.

Manifest cascade is confirmed at runtime and source-plausible. FunctionResults shows 4 Artifact Bundle Manifest failures with missing_token=missing_runtime_surface_classification=missing_runtime_surface and board proof missing / missing_or_unverified dependency context. Source inspection shows Dispatcher manifest required tokens also include missing_runtime_surface_classification=missing_runtime_surface.

The strongest suspected chain is: stale required-token contracts reject Scanner Status and Market Board publication; those failures keep bundle proof/dependency state degraded; Manifest fails downstream; write_dirty / l1_publish_pending_manifest / write cooldown/backoff keep persistence returning; meanwhile Top10/side-duty and deferred work dominate heartbeat time; MT5 appears frozen/starved even though some files continue to be produced.

Exact source owners implicated for RUN240:
- mt5/artifacts/ASC_ScannerStatusWriter.mqh: stale required token at required_tokens[241].
- mt5/runtime/ASC_Dispatcher.mqh: matching stale manifest required token at required_tokens[72].
- mt5/artifacts/ASC_ArtifactTextHelpers.mqh: emitted missing-runtime-surface policy line currently uses policy_declared.
- mt5/artifacts/ASC_MarketBoardWriter.mqh: stale required token Operator Command Surface while body emits Siam Review Intake Surface.
- mt5/runtime/ASC_Dispatcher.mqh: persistence/write-lane retry, side-duty/top10 timing, manifest retry, post-lane Scanner Status write behavior.

What remains unproven:
- hard terminal exception / true EA crash;
- clean compile proof from MetaEditor output;
- whether token fixes alone reduce max heartbeat below budget;
- whether successful Dossier/SDP/Top10 child writes remain too heavy after publication failures are removed;
- whether terminal CPU/memory/resource exhaustion occurred.

Exact RUN240 patch plan:
1. Align Scanner Status missing-runtime-surface token contract without weakening FileIO validation.
2. Align Dispatcher Artifact Bundle Manifest missing-runtime-surface required token to the same canonical token.
3. Align Market Board required token away from stale Operator Command Surface and toward Siam Review Intake Surface or a stable non-heading key that cannot drift with visible wording.
4. Do not reintroduce command-bias wording.
5. Do not rewrite FileIO, final paths, L3 gates, L4 ranking/formula, HUD, Dossier architecture, Current Focus architecture, generated output, or trading logic.
6. Add only tiny throttle/diagnostic protection if patch inspection proves Scanner Status / Manifest / Market Board failure retry is still hammering every heartbeat after token repair; otherwise leave throttling for the live retest evidence.
7. Rerun MetaEditor compile and bounded live proof with Experts, Journal, heartbeat_telemetry.log, FunctionResults, Scanner Status, Market Board, Artifact Bundle Manifest, and timestamped freeze/crash notes.

Final decision: HOLD.
```

---

## 0. Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN239R |
| primary mode | AUDIT |
| secondary mode | DEBUG |
| live run? | no |
| runtime/output artifacts expected? | no new runtime output |
| RUN238 evidence used? | read-only evidence only |
| source editing allowed? | no, audit/report only |
| generated output editing allowed? | no |
| generated output cleanup allowed? | no |
| FileIO rewrite allowed? | no |
| path mutation allowed? | no |
| L3 behavior change allowed? | no |
| L4 ranking/order/formula behavior change allowed? | no |
| membership source change allowed? | no |
| HUD patch allowed? | no |
| Market Board patch allowed? | no, audit only |
| Dossier/Current Focus broad rewrite allowed? | no |
| strategy/signal/trade/risk patch allowed? | no |
| production-ready claim allowed? | no |
| edge claim allowed? | no |
| signal/trade permission allowed? | no |
| final serious decision | HOLD |

## 1. Evidence Ladder

| Evidence Item | Available? | Evidence Class | Use In This Report | Limit |
|---|---:|---:|---|---|
| User report that compile passed / EA crashed | yes | 2 | respected as report | not proof of compile or hard crash |
| RUN238R_REPORT.md | yes | 2/3 | prior audit summary + pointers | report claims rechecked against source/logs where possible |
| MetaEditor compile output | no | n/a | context debt | compile success remains unproven by package |
| Experts log | no | n/a | context debt | hard EA exception not provable |
| Journal log | no | n/a | context debt | terminal/platform crash not provable |
| FunctionResults log | yes | 5 bounded runtime evidence | publication failures and function counts | does not prove terminal exception |
| heartbeat_telemetry.log | yes | 5 bounded runtime evidence | freeze/starvation proof | does not prove terminal closed |
| Generated Dossiers / SDPs | yes | 5 bounded runtime evidence | confirms some output produced | output production does not equal runtime health |
| Source inspection | yes | 3 | token owners, scheduler/write lane owners | cannot prove live effect until patched/retested |

## 2. Crash vs Freeze Classification

| Failure Type | Evidence Needed | Supplied? | Evidence Found | Classification |
|---|---|---:|---|---|
| hard EA exception / crash | Experts + Journal + terminal errors | no | none supplied | unproven |
| MT5 freeze / starvation | heartbeat telemetry / huge OnTimer duration | yes | max heartbeat 24654ms vs 880ms budget; persistence lane; side_duty_ms 24809 | proven freeze-class starvation |
| publication failure loop | FunctionResults repeated failures | yes | Scanner Status 89 errors; Market Board 4 errors; Manifest 4 errors | proven |
| output route failure | missing final route files | partial | GlobalTop10/Top5/Dossiers/SDP files exist; Market Board/Scanner Status/Manifest absent | partial: core status/board/manifest failed |
| source compile failure | MetaEditor compile output | no | no compile output supplied | unknown/unproven |
| terminal resource exhaustion | logs / CPU / memory / deferred queue | partial | deferred_work_count max 1036; no CPU/memory logs | possible |
| watchdog/timeout behavior | logs / heartbeat / terminal symptoms | partial | timer_pressure_possible and huge heartbeat rows; no terminal watchdog log | possible |

Required verdict:

- Hard crash proven? **No.**
- Freeze/starvation proven? **Yes.**
- Publication failure loop proven? **Yes.**
- Most likely chain: **publication-token rejection + manifest dependency cascade + persistence/Top10/side-duty overrun + deferred backlog = freeze-class starvation.**
- Evidence that would upgrade certainty: **Experts log, Journal log, timestamped freeze note, whether terminal closed, whether EA removed itself, whether heartbeat/file updates continued after the reported freeze.**

## 3. RUN238 Runtime Failure Absorption

| RUN238 Failure | Evidence Source | Evidence Rank | Source Owner Candidate | Severity | Next Action |
|---|---|---:|---|---|---|
| Scanner Status write failures x89 | FunctionResults | 5 | ASC_ScannerStatusWriter / ASC_ArtifactTextHelpers | critical | align token contract |
| missing token `missing_runtime_surface_classification=missing_runtime_surface` | FunctionResults + source | 5 + 3 | ScannerStatusWriter / Dispatcher / ArtifactTextHelpers | critical | patch exact token parity in RUN240 |
| emitted token `missing_runtime_surface_classification=policy_declared` | source | 3 | ASC_ArtifactTextHelpers | critical | decide canonical token; do not weaken validation |
| Market Board failures x4 | FunctionResults | 5 | ASC_MarketBoardWriter | critical | align required token |
| missing token `Operator Command Surface` | FunctionResults + source | 5 + 3 | ASC_MarketBoardWriter | critical | remove stale command-bias required token |
| emitted surface `Siam Review Intake Surface` | source | 3 | ASC_MarketBoardWriter body | critical | preserve doctrine after RUN231 |
| Manifest board proof missing | FunctionResults/report/source | 5/3 | Dispatcher manifest owner | high | align dependency tokens after scanner/board fix |
| max heartbeat 24654ms | Heartbeat telemetry | 5 | Dispatcher persistence/top10/side-duty | critical | retest after token patch; inspect throttling if persists |
| side_duty_ms 24809 | Heartbeat telemetry | 5 | Dispatcher side-duty/Top10 service | critical | inspect Top10/side-duty budget enforcement |
| deferred_work_count 1036 | Heartbeat telemetry | 5 | deferred scheduler | high | verify queue drains after failures removed |
| GlobalTop10 SDP wrote 10 | generated output | 5 | SDP writer | positive | preserve |
| Top5 crypto SDP wrote 5 | generated output | 5 | SDP writer | positive | preserve |
| Dossiers wrote 10/5 | generated output | 5 | Dossier writer | positive/heavy risk | do not patch yet; retest load after token repair |

Hard separation: **file production is not health proof.** Aurora wrote useful files while still starving badly.

## 4. Publication Token Contract Audit

| Surface | Required Token | Emitted Token / Body | Source Required Owner | Source Emit Owner | Match? | Runtime Failure? | Fix Owner |
|---|---|---|---|---|---:|---:|---|
| Scanner Status | `missing_runtime_surface_classification=missing_runtime_surface` | `missing_runtime_surface_classification=policy_declared` | ASC_ScannerStatusWriter.mqh required_tokens[241] | ASC_ArtifactTextHelpers.mqh `ASC_MissingRuntimeSurfaceClassificationLine()` | no | yes, 89 errors | ScannerStatusWriter / ArtifactTextHelpers |
| Artifact Bundle Manifest | `missing_runtime_surface_classification=missing_runtime_surface` | helper emits `policy_declared` | ASC_Dispatcher.mqh manifest required_tokens[72] | ASC_ArtifactTextHelpers.mqh | no | yes, 4 errors | Dispatcher / ArtifactTextHelpers |
| Market Board | `Operator Command Surface` | `Siam Review Intake Surface` | ASC_MarketBoardWriter.mqh required_tokens[1] | ASC_MarketBoardWriter.mqh `ASC_BoardAppendCommandBlock()` | no | yes, 4 errors | MarketBoardWriter |
| FunctionResults proof | expected status/proof tokens | FunctionResults records failures correctly | ASC_FunctionResults.mqh / callers | Dispatcher/writers | partial | no direct proof failure | preserve logging |

Answers:

1. Required tokens are defined in writer/manifest required token arrays before `ASC_WritePublicationArtifact()`.
2. Emitted tokens are composed by the visible body helpers/writers.
3. Yes, tokens are stale from old wording.
4. Yes, repeated required-token failure is observed. The exact retry mechanics need RUN240/retest, but runtime repetition is proven.
5. Yes, FileIO validates after composing/writing temp/readback; repeated failure implies repeated compose/write/validation cost.
6. Yes, Manifest proof is blocked by missing Scanner/Board proof dependencies and the same missing-runtime token.
7. The cleanest initial fix is token contract alignment only.
8. Required tokens should follow current doctrine and stable contract keys, not stale visible headings.
9. After RUN231, `Siam Review Intake Surface` / review-router wording is doctrinally correct; `Operator Command Surface` is stale command-bias wording.
10. Yes. `Operator Command Surface` conflicts with the no-command-bias shift.

## 5. Heartbeat Starvation Audit

| Heartbeat Metric | Observed | Budget / Expected | Severity | Meaning |
|---|---:|---:|---|---|
| heartbeat rows | 77 | n/a | info | enough sample to classify runtime pressure |
| rows above 880ms | 73 | 880ms | critical | almost every heartbeat exceeded budget |
| rows above 1200ms | 47 | 880ms | critical | frequent timer pressure |
| rows above 2000ms | 5 | 880ms | high | visible freeze risk |
| rows above 5000ms | 4 | 880ms | critical | terminal unresponsive risk |
| max heartbeat ms | 24654 | 880 | critical | freeze-class starvation |
| worst lane | persistence | one major lane/beat | critical | write/persistence lane is implicated |
| side_duty_ms | max 24809 | should stay below heartbeat budget | critical | side-duty/top10 path consumed wall time |
| top10_ms | max 24654 | should be bounded | critical | Top10 full batch/side-duty is major suspect |
| deferred_work_count | max 1036; p50 1036 | should drain | high | queue/backlog stuck or re-created faster than drain |
| Scanner Status failures | 89 | 0 | critical | repeated status publication rejection |
| Market Board failures | 4 | 0 | critical | board cannot publish |
| Manifest failures | 4 | 0 | high | bundle proof cannot close |
| Dossier write count | max 2 per beat; total 38 | bounded | medium | not proven as primary freeze cause |
| SDP/Top10 child work | globaltop10_child_work_count max 10 | bounded by cadence | medium/high | not false, but heavy in failing runtime |

Diagnosis:

- Heartbeat starvation is temporally compatible with persistence/write pressure and Top10/side-duty work.
- The worst row has `top10_ms=24654` and `side_duty_ms=24809`, while artifact publish ms fields are zero. That points away from a simple Market Board compose-only stall and toward Top10/side-duty/persistence workload dominating the beat.
- Scanner Status is attempted after the lane in `ASC_RunHeartbeat()` if side-duty is not deferred; `ASC_MaybeWriteScannerStatus()` only advances `scanner_status_last_write_utc` on OK/WARNING, so repeated ERROR can hammer more often than a successful two-second cadence.
- Market Board/Manifest failures set `write_dirty`, `l1_publish_pending_manifest`, write cooldown/backoff, and degraded posture, keeping the persistence loop alive.
- Dossier/SDP writes are successful enough to preserve, but they are not cleared as harmless until retested after token failures disappear.

Heartbeat cause classification:

- `TOKEN_FAILURE_RETRY_LOOP_LIKELY` — high.
- `MANIFEST_DEPENDENCY_CASCADE_LIKELY` — high.
- `DEFERRED_QUEUE_BACKLOG_LIKELY` — high.
- `DOSSIER_SDP_WRITE_BURST_LIKELY` — medium.
- `PERSISTENCE_PAYLOAD_TOO_HEAVY_LIKELY` — medium.
- `LOGGING_AMPLIFICATION_LIKELY` — medium.
- `UNKNOWN_NEEDS_EXPERTS_JOURNAL_AND_MORE_TELEMETRY` — still true for hard crash classification.

## 6. Persistence / Side-Duty Source Audit

| Source Area | File | What Was Inspected | Risk | Finding |
|---|---|---|---|---|
| heartbeat scheduler | ASC_Dispatcher.mqh | lane selection / budget fields / telemetry | heartbeat overrun | budget is recorded, but actual beats can massively exceed budget |
| side duty loop | ASC_Dispatcher.mqh | pre/post lane side-duty, Top10 service, Scanner Status post-lane | queue burst | side-duty can include heavy Top10/ScannerStatus/presence work; worst telemetry shows side-duty/top10 domination |
| Scanner Status write path | ASC_ScannerStatusWriter.mqh / Dispatcher | `ASC_MaybeWriteScannerStatus` and token validation | repeated failure | errors do not set last_write_utc, so failure can repeat aggressively |
| Market Board write path | ASC_MarketBoardWriter.mqh / Dispatcher | board body and required tokens | repeated failure | stale `Operator Command Surface` required token rejects current body |
| Manifest proof path | ASC_Dispatcher.mqh | manifest required tokens and dependency state | cascade | same missing-runtime token and board proof dependency fail |
| FunctionResults logging | ASC_FunctionResults.mqh / callers | aggregate failure rows | amplification | 782 rows, 97 errors, 89 warnings; logging is useful but may amplify churn |
| Dossier write path | ASC_DossierWriter.mqh / Dispatcher | bounded count evidence | heavy writes | successful but not primary proven cause; preserve and retest |
| SDP write path | SDP writer/composer/routing | generated outputs and logs | heavy writes | successful GlobalTop10/Top5 outputs; preserve |
| FileIO atomic write | ASC_FileIO.mqh | required token validation | cost, not patch target | validation correctly catches mismatches; do not weaken |
| HUD render | ASC_HUD_Manager.mqh | read-only only | likely secondary | no evidence HUD caused this freeze; do not patch HUD |

Answers:

1. Persistence appears allowed to do too much during failure states, especially Top10/side-duty plus failed publication proof.
2. Failed required-token writes are repeated; Scanner Status repeats 89 times.
3. Yes, token failure occurs after body compose/write validation, so repeated failure is not free.
4. Logging is aggregate, not per-symbol spam, but the volume is still material during failure loops.
5. Manifest rechecks fail when dependencies remain missing/unverified.
6. Deferred work is not effectively draining in this evidence; `deferred_work_count=1036` dominates.
7. Side duties are supposed to yield near budget, but evidence shows side-duty/top10 can still consume 24s.
8. The one-major-lane law is violated in practical runtime effect: persistence plus side duties consume far beyond the 1-second heartbeat budget.
9. The system defers some work, but keeps pushing enough to starve.
10. Throttling owners are `ASC_Dispatcher.mqh` write lane, `ASC_MaybeWriteScannerStatus()`, manifest publication, Top10 full batch service, and side-duty yield logic.

## 7. Failure Chain Hypotheses

| Hypothesis | Evidence For | Evidence Against | Confidence | Test / Falsifier |
|---|---|---|---|---|
| H1: Scanner Status token mismatch causes repeated write failures and heartbeat starvation | 89 errors; source mismatch confirmed; errors do not advance status last-write time | worst heartbeat points to Top10/side-duty too, not status alone | high for failure loop; medium as sole starvation cause | patch token and retest Scanner Status + heartbeat |
| H2: Market Board stale required token causes repeated board failures and Manifest cascade | 4 board errors; source body/required mismatch confirmed; board absent | only 4 board errors, not 89 | high for board failure; medium for freeze alone | patch board token and retest board/manifest |
| H3: Manifest dependency cascade amplifies persistence load | 4 manifest errors; board proof missing; same runtime-surface token mismatch | not enough rows to prove it alone caused 24s | high | patch upstream tokens; verify manifest success/failure count |
| H4: Dossier/SDP successful writes are too heavy independent of failures | 38 dossier writes; Top10 child work and side-duty heavy | successful writes bounded at max 2 dossiers/beat; artifact publish ms zero on worst row | medium | compare heartbeat after token fixes with same symbol/server scope |
| H5: deferred queue is unbounded or drained too aggressively | deferred_work_count max/p50 1036; skipped_due_budget_count same | source has yield/backoff logic | high as symptom, medium as root | inspect queue after token patch; require backlog decline curve |
| H6: HUD/render causes apparent terminal freeze | user symptom could look like chart freeze | no HUD evidence; ui_priority=off | low | run with HUD state noted; capture chart/terminal responsiveness |
| H7: true terminal exception/hard crash occurred | user report | no Experts/Journal/Event Viewer | unknown | require Experts/Journal; Event Viewer only if terminal closes |
| H8: compile-clean source still contains runtime infinite loop | 24s Top10/side-duty row | no direct infinite-loop evidence; EA continued logging | medium/low | after token patch, if Top10 still spikes >5s, isolate Top10 service loop |

Hypothesis rank by evidence:

1. H1 + H2 + H3 combined: stale token contracts break publication and proof closure.
2. H5: deferred queue/backlog pressure keeps the system degraded.
3. H4/H8: successful Top10/Dossier/SDP work may still be too heavy, but retest after token repair is the cheapest falsifier.
4. H6: HUD is not supported by evidence.
5. H7: hard crash remains unknown until terminal logs exist.

Cheapest falsifying test: **RUN240 token alignment only, compile, then bounded live proof with Experts/Journal + heartbeat + FunctionResults.** If heartbeat remains severe after status/board/manifest stop failing, the cause shifts toward Top10/side-duty payload size or queue-throttle design.

## 8. Crash Evidence Requirements For Next Live

RUN240/next live must capture:

- MetaEditor compile output.
- Experts log.
- Journal log.
- heartbeat_telemetry.log.
- FunctionResults.
- Scanner Status.
- Market Board.
- Artifact Bundle Manifest.
- broker/server/session note.
- timestamped note of when the EA “crashed/froze”.
- whether MT5 terminal became unresponsive or EA removed itself.
- whether the chart froze but terminal lived.
- whether OnTimer kept logging after apparent crash.
- whether files continued updating after apparent crash.
- Windows Event Viewer only if terminal actually closes.

Required classification fields:

| Field | Required Value |
|---|---|
| crash_observed | true/false/unknown |
| terminal_closed | true/false/unknown |
| chart_unresponsive | true/false/unknown |
| ea_removed | true/false/unknown |
| experts_error_present | true/false/unknown |
| journal_error_present | true/false/unknown |
| heartbeat_after_freeze_present | true/false/unknown |
| files_updated_after_freeze | true/false/unknown |
| likely_failure_class | hard_crash / freeze_starvation / publication_failure_loop / unknown |

## 9. Siam Report Absorption — Semantic Patches Deferred

| Siam Finding | Runtime-Crash Relevant? | Patch Now? | Reason |
|---|---:|---:|---|
| token publication failures | yes | RUN240 yes | blocks proof and causes repeated failures |
| heartbeat starvation | yes | RUN240 triage/retest | freeze-class failure |
| epoch/alignment wording | no/secondary | defer | semantic cleanup, not crash root |
| session/bucket scope unknown | secondary | defer unless tied to crash | data trust but not publication survival |
| section coherence too blunt | no | defer | semantic clarity |
| absence wording dirty | no | defer | semantic clarity |
| `canonical_for_current_siam_task` missing | no | defer | task routing, not crash |
| no-sample invariant | no | preserve/defer | data purity |
| Market Board as router | partly already | preserve | do not reintroduce command bias |

Do not let semantic polish steal the pass. Publication survival and heartbeat stability outrank everything here.

## 10. Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---:|---:|---:|---|---|---:|
| EA crashed | Experts/Journal not supplied | user report | evidence package | 2 | n/a | neither proves hard crash | collect Experts/Journal; classify current evidence as freeze/starvation | yes |
| Compile passed | compile output not packaged | user report | package audit | 2 | n/a | compile output required | next live must include MetaEditor output | yes |
| Runtime files produced | runtime unhealthy/freezing | generated Dossiers/SDPs | heartbeat/logs | 5 | 5 | heartbeat/logs show health failure despite output | separate file production from runtime health | yes |
| Scanner Status body emits policy_declared | required token expects missing_runtime_surface | ArtifactTextHelpers | ScannerStatusWriter | 3 | 3 | direct source conflict | align token in RUN240 | yes |
| Manifest expects missing_runtime_surface | helper emits policy_declared | Dispatcher | ArtifactTextHelpers | 3 | 3 | direct source conflict | align manifest/status/helper contract | yes |
| Market Board body emits Siam Review Intake Surface | required token expects Operator Command Surface | MarketBoardWriter body | MarketBoardWriter required array | 3 | 3 | current doctrine/body outranks stale command heading | align required token without command bias | yes |
| RUN231 removed command bias | stale required token says command | RUN231/report/doctrine | source token | 2/3 | 3 | source token causes runtime failure; doctrine says do not reintroduce command | patch required token to router wording | yes |
| Manifest expects proof | dependencies fail | Dispatcher/FunctionResults | Runtime evidence | 3/5 | 5 | runtime evidence confirms cascade | patch upstream tokens first | yes |
| L3/L4 fields improved | publication surfaces failing | reports/source | runtime evidence | 2/3 | 5 | runtime evidence outranks improvement claims | defer semantic upgrades | yes |
| Generated evidence must stay read-only | temptation to clean output | prompt law | package work | 2 | n/a | prompt law controls scope | no output mutation done | no |

## 11. Exact RUN240 Patch Plan

RUN240 should be a surgical DEBUG + PATCH pass:

1. Read `ASC_ArtifactTextHelpers.mqh`, `ASC_ScannerStatusWriter.mqh`, `ASC_Dispatcher.mqh`, `ASC_MarketBoardWriter.mqh`, and `ASC_FileIO.mqh` validation call paths.
2. Choose one canonical missing-runtime-surface token. Preferred repair: keep the richer policy line but make required tokens match a stable emitted key, or emit the required canonical key while preserving policy details. Do not weaken validation.
3. Patch Scanner Status required token parity.
4. Patch Artifact Bundle Manifest required token parity.
5. Patch Market Board required token away from `Operator Command Surface` and toward `Siam Review Intake Surface` or a stable `market_board_role=selection_context_not_trade_signal` / `siam_review_intake_surface=present` contract key.
6. Preserve no-trade/no-signal/no-execution/no-risk permission fields.
7. Do not change FileIO, paths, L3 gates, L4 formulas, membership ownership, HUD, Dossier/Current Focus architecture, generated output, or trade logic.
8. Only add tiny retry/throttle guard if direct source inspection proves failed Scanner Status/Manifest/Market Board can hammer every heartbeat after token repair; otherwise defer throttle to post-patch evidence.
9. Bump version/control files only if actual source changes are made.
10. Package changed files only in `TRUTH_SEEKER_RUN240R.zip`.

RUN240 acceptance:

| Acceptance Gate | Required Result |
|---|---|
| MetaEditor compile | clean output supplied |
| Scanner Status | no `missing_runtime_surface_classification` required-token failure |
| Market Board | no `Operator Command Surface` required-token failure |
| Manifest | no board/scanner missing proof cascade caused by stale tokens |
| Heartbeat | max materially reduced or cause isolated with new evidence |
| Routes | GlobalTop10 and Top5PerBucket final routes preserved |
| Doctrine | no command-bias, no trade permission, no FileIO/path/ranking/HUD rewrite |

## 12. Package Validation Table

| Package Rule | Result |
|---|---|
| exact zip name | TRUTH_SEEKER_RUN239R.zip |
| report created | `roadmap/Truth Seeker/Truth Seeker Reports/RUN239R_REPORT.md` |
| source patch included | no |
| generated output edited | no |
| generated output cleanup | no |
| FileIO rewrite | no |
| path mutation | no |
| L3/L4 behavior change | no |
| HUD/Market Board patch | no |
| whole repo dump | no |
| package layout | active repo-relative layout preserved under `Aurora Sentinel Core/...` |
| final decision | HOLD |
