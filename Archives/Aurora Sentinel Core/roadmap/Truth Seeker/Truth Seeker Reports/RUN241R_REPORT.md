# GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN241R / HEARTBEAT PERSISTENCE STARVATION HARDENING — CAP SIDE-DUTY, TOP10, STATUS RETRY, MANIFEST CASCADE, AND DEFERRED QUEUE PRESSURE BEFORE LIVE RETEST
MODE: DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN241R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN241R.zip
SOURCE BASELINE: RUN240R TOKEN-CONTRACT REPAIR
NEXT LIVE TEST: RUN242R
FINAL DECISION: TEST FIRST

# FINAL SUMMARY

RUN241R was source/control only. No live run was requested. No generated runtime output, Symbol Data Packs, Dossiers, Artifact Bundle Manifest, Scanner Status, FunctionResults, Experts logs, or Journal logs were edited, cleaned, regenerated, renamed, or packaged.

Exact heartbeat/persistence/Top10/deferred queue source owners inspected: `mt5/runtime/ASC_Dispatcher.mqh` as the active heartbeat/write-lane/persistence/Top10/Manifest owner; `mt5/artifacts/ASC_ScannerStatusWriter.mqh` as Scanner Status required-token owner; `mt5/artifacts/ASC_MarketBoardWriter.mqh` as Market Board token owner; `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` as emitted missing-runtime policy token owner; `mt5/core/ASC_Constants.mqh` and `mt5/core/ASC_Version.mqh` as compile-visible contract/identity owners. FileIO, final routes, L3 gates, L4 ranking/formula, HUD, Dossier/Current Focus architecture, and generated output evidence remained untouched.

Exact source/control patch applied:
- `ASC_Dispatcher.mqh`: added RUN241R side-duty hard-cap helpers, converted Top10 full-family service admission into bounded/yield-aware slices, deferred Top10 work when budget/side-duty cap is reached, preserved Top10 membership/ranking/formula behavior, and added RUN242 proof telemetry fields.
- `ASC_Dispatcher.mqh`: updated active Artifact Bundle Manifest required tokens away from stale RUN155 live-contract wording toward RUN242 live retest wording.
- `ASC_ScannerStatusWriter.mqh`: updated active Scanner Status required tokens away from stale RUN155 live-contract wording toward RUN242 live retest wording.
- `ASC_Constants.mqh`: updated active emitted contract token values and heartbeat required-field contract to include RUN241R proof fields.
- `ASC_Version.mqh`: advanced compile-visible identity/package state from RUN240R to RUN241R and next live proof to RUN242R.
- Office/control files and roadmap package manifest were advanced to RUN241R/RUN242R.

Side-duty budget/yield was added for the Top10 persistence side-duty path. The new guard yields when the write heartbeat is expired, near budget, UI-priority constrained, or past a RUN241R side-duty hard cap. Top10 service cap/yield was added at pre-service, post-admission, inflight verification, completion/promotion, and next-symbol queue boundaries. Deferred queue observability was extended through `deferred_processed_this_beat` and `deferred_remaining`; existing dossier queue caps/backlog counters were preserved. Publication retry cooldown/backoff already existed for write/essential/dossier failures and was preserved; RUN241R exposes `publication_retry_skipped_count` and `publication_next_retry_due` in heartbeat telemetry. Manifest dependency cascade containment was strengthened by exposing `manifest_dependency_missing` and `manifest_next_retry_due`; failed proof is not marked success. Telemetry fields for RUN242 were added or verified: heartbeat budget/elapsed/lane/major work/top10/side duty/persistence/deferred counts/retry due/manifest dependency/over-budget reason.

Stale legacy RUN150/RUN155 tokens were classified. Historical macro names and old report files remain inheritance evidence, not active authority. Active future-facing required tokens in Scanner Status and Manifest were patched from RUN155 to RUN242 where they could mislead RUN242 evidence or cause proof-contract drift. RUN240 token fixes were preserved: `missing_runtime_surface_classification=policy_declared` remains required by Scanner Status and Manifest; Market Board still emits and requires `board_surface_role=siam_review_intake`; `Operator Command Surface` does not appear in active MT5 source validation.

MetaEditor compile was not rerun in this environment. Compile proof remains outstanding. Runtime/live proof remains outstanding until RUN242R. No production readiness, trading edge, buy/sell signal, execution permission, risk permission, or prop-firm permission is granted.

Exact next move: RUN242R live crash-freeze retest.

## Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN241R |
| primary mode | DEBUG |
| secondary mode | PATCH |
| live run? | no |
| runtime/output artifacts expected? | no new runtime output |
| source editing allowed? | yes, heartbeat/persistence starvation hardening only |
| generated output editing allowed? | no |
| FileIO rewrite allowed? | no |
| final path mutation allowed? | no |
| L3 behavior/gate change allowed? | no |
| L4 ranking/order/formula behavior change allowed? | no |
| membership source change allowed? | no |
| HUD patch allowed? | no |
| strategy/signal/trade/risk patch allowed? | no |
| next live test | RUN242R |
| production-ready claim allowed? | no |
| final decision | TEST FIRST |

## Evidence Ladder

| Evidence | Class | RUN241 Use | Limit |
|---|---:|---|---|
| RUN238 heartbeat/runtime evidence described in reports | bounded runtime evidence | starvation intake | no Experts/Journal/hard-crash proof |
| RUN239 audit | 2/3 | root-cause framing and owner candidates | not compile/live proof |
| RUN240 source package inspected directly | 3 | token repair baseline | not compile proof |
| RUN241 direct source inspection and patch | 3 | source/control truth | not runtime proof |
| MetaEditor compile | 4 if supplied | not supplied | compile remains outstanding |
| RUN242 live | future | required proof boundary | not available in RUN241 |

## RUN240 Safety Gate

| RUN240 Item | Expected | Observed | PASS / HOLD / FAIL | Action |
|---|---|---|---|---|
| Scanner Status token aligned | `missing_runtime_surface_classification=policy_declared` | source-present in `ASC_ScannerStatusWriter.mqh` | PASS | preserved |
| Manifest token aligned | `missing_runtime_surface_classification=policy_declared` | source-present in `ASC_Dispatcher.mqh` | PASS | preserved |
| Market Board token aligned | `board_surface_role=siam_review_intake` | emitted and required in `ASC_MarketBoardWriter.mqh` | PASS | preserved |
| `Operator Command Surface` active validation removed | yes | no active MT5 validation hit | PASS | no action |
| SIAM_DOSSIER_REQUEST_BLOCK preserved | yes | present in Market Board source | PASS | no action |
| TOP10_NUMERIC_MATRIX preserved | yes | present in Market Board source | PASS | no action |
| FileIO untouched | yes | not edited | PASS | preserved |
| final paths untouched | yes | not edited | PASS | preserved |
| L3 behavior untouched | yes | no L3 patch | PASS | preserved |
| L4 ranking/formula untouched | yes | no formula/order patch | PASS | preserved |
| generated output excluded | yes | no generated output included | PASS | preserved |
| compile proof supplied | optional | not rerun | OUTSTANDING | RUN242 must compile first |
| next live proof | RUN242R | seeded | PASS | retest next |

## Stale Legacy Token / Drift Classification

| Token / Wording | Found? | File | Active future-facing output? | Runtime validator? | Risk | RUN241 Action |
|---|---:|---|---:|---:|---|---|
| RUN150 | yes | historical constants/reports/helpers | mixed | some old output prose | legacy/history | left historical context, no mass rewrite |
| RUN155 | yes | constants/helpers/required tokens | yes before patch | yes before patch | stale live-proof instruction | active required-token values patched to RUN242 where future-facing |
| `next_live_run=RUN155R` | yes before patch | `ASC_Constants`, `ASC_ScannerStatusWriter`, `ASC_Dispatcher` | yes | yes | stale live-proof instruction | patched to `next_live_run=RUN242R` |
| `Operator Command Surface` | no active MT5 validator | none in active MT5 source validation | no | no | command-bias/stale validator | no action |
| signal/trade wording | historical only / negated boundaries | guidebooks/reports | no permission | no | forbidden if affirmative | no signal/trade permission added |

## Heartbeat Starvation Absorption

| Runtime Metric / Finding | RUN238 Value | Source Owner Candidate | Severity | RUN241 Action |
|---|---:|---|---|---|
| heartbeat budget | 880ms | Dispatcher heartbeat law | high | preserved |
| worst heartbeat | ~24654ms | Dispatcher / persistence / Top10 side duty | critical | Top10 side-duty yield points added |
| rows above budget | 73/77 | Dispatcher lanes | critical | telemetry expanded for RUN242 |
| rows above 1200ms | 47 | Dispatcher lanes | high | retest threshold seeded |
| rows above 2000ms | 5 | Dispatcher lanes | high | cap/yield seeded |
| rows above 5000ms | 4 | Dispatcher lanes | critical | cap/yield seeded |
| worst lane | persistence | Dispatcher write/persistence lane | critical | write lane inspected/patched |
| side_duty_ms | ~24809 | side duty service | critical | side hard cap added for Top10 service |
| top10_ms | ~24654 | Top10 service | critical | service checkpoints added |
| deferred_work_count | ~1036 | deferred queue | high | backlog telemetry added/preserved |
| Scanner Status failures | 89 | token fixed RUN240 | high | token verified preserved |
| Market Board failures | 4 | token fixed RUN240 | medium | token verified preserved |
| Manifest failures | 4 | token/dependency cascade | high | RUN242 dependency/retry telemetry added |

## Heartbeat / Side-Duty Source Audit

| Source Area | Function / Region | Current Behavior | Risk | Patch Needed? |
|---|---|---|---|---:|
| OnTimer / heartbeat entry | `ASC_RunHeartbeat` | one heartbeat drives lane + side duties | timer starvation if work blocks | yes |
| lane selection | `ASC_SelectModeAndLane` call boundary | one active lane selected | side duty can still dominate | yes, bounded side-duty |
| persistence lane | `ASC_RunWriteLane` | handles Top10, SDP mirrors, board, dossiers, manifest | one beat can exceed budget | yes |
| side-duty loop | post-lane scanner/status/presence | has yield checks near budget | can still run after heavy lane | preserved + telemetry |
| Top10 side-duty | `ASC_ServiceTop10RunFullBatch` | admission/verify/promotion/queue inside one service | 24s blocking class | yes |
| deferred queue drain | dossier queue service + write counters | existing caps/backlog counters | backlog proof not explicit enough | telemetry added |
| status publication retry | `ASC_MaybeWriteScannerStatus` | has 2s write guard and RUN240 token fix | failed publication could still show pressure | observed via telemetry |
| Market Board retry | write-lane essentials | has failure/backoff state | retry storm if failures persist | backoff preserved, retry due exposed |
| Manifest retry | manifest pending flag | can remain pending after dependency failure | cascade ambiguity | dependency/retry telemetry added |
| FunctionResults logging | `ASC_RecordResult` | records decisions | logging amplification possible | no broad rewrite |
| heartbeat telemetry | `ASC_LogHeartbeatTelemetry` | already rich but missing retry/deferred fields | RUN242 cannot prove containment fully | fields added |

## Required Patch Objectives

| Objective | RUN241 Result |
|---|---|
| Side-duty budget/yield | Added RUN241R hard-cap guard for Top10 side duty; existing post-lane sweep yield preserved |
| Top10 service cap | Added checkpoints at pre-service, post-admission, inflight verify, completion/promotion, next-symbol queue |
| Deferred queue control | Existing dossier queue caps preserved; telemetry for processed/remaining added |
| Publication retry containment | Existing write/essential/dossier backoff preserved; retry-skipped and next-retry fields exposed |
| Manifest dependency cascade | Missing dependency and next retry due surfaced; no fake completion |
| Telemetry for RUN242 | Added fields listed in acceptance seed |

## Patch Style Rules

| Rule | Result |
|---|---|
| bounded cooldowns | existing cooldowns preserved |
| per-beat work caps | Top10 checkpoints added; existing dossier caps preserved |
| elapsed-time yield checks | added for Top10 service boundary |
| compact counters | added to heartbeat telemetry |
| no validation weakening | preserved |
| no ranking/order/formula change | preserved |
| no FileIO rewrite/path mutation | preserved |
| no generated output edit | preserved |

## Multi-Domain Research Lattice

| Research Lane | Source / Authority | Finding | Converted RUN241 Constraint | Falsifier |
|---|---|---|---|---|
| MQL5 / MT5 timer mechanics | Official MQL5 `OnTimer`, `EventSetTimer`, event handling docs | Timer events are queued per program; if timer event is already queued/processing, new timer event is not added; event handlers process sequentially; infinite loops are discouraged | OnTimer heartbeat must return quickly; no Sleep/spin loop; heavy Top10 work must yield | RUN242 shows 20s+ timer beats remain |
| MQL5 Sleep / blocking | Official MQL5 `Sleep` docs | Sleep suspends EA/script execution | no sleeping inside heartbeat | Sleep/spin loop appears in heartbeat path |
| SRE reliability | Google SRE cascading failures / retry overload guidance | overload and retries can amplify failure | failed publications stay visible but bounded by cooldown/backoff | repeated failed publication hammers every heartbeat |
| Queueing / scheduling | bounded queue/cooperative scheduling practice | queues must expose backlog and drain rate | add processed/remaining counters; do not silently drop work | backlog decreases only because work vanished |
| Observability | reliability observability practice | recovery needs counters, state, reason, due time | add retry due, manifest dependency, over-budget reason | RUN242 cannot tell why heartbeat improved/failed |
| Secure SDLC / root-cause discipline | source-owner debugging discipline | patch smallest source owner, do not mutate evidence | Dispatcher/control patch only; no generated output mutation | package includes runtime evidence or broad rewrite |
| Protected lattice / boundary surgery | Aurora guidebook law | stitch boundaries require allowed data/proof and forbidden ownership leaks | Top10 consumes committed L4; Dispatcher schedules; HUD/trading untouched | rank/formula/HUD/trading mutation appears |

## Brain Guidebook / Two-Brain Check

| Guidebook | Read? | Key Rule Extracted | Converted RUN241 Constraint | Patch Needed? |
|---|---:|---|---|---:|
| AURORA_GUIDEBOOK_INDEX.md | yes | active control drift must be repaired; historical text cannot outrank current authority | patch active RUN155 future-facing tokens only | yes |
| AURORA_CODING_BRAIN_GUIDEBOOK.md | yes | compile-visible identity/control can be patched only as narrow boundary work | version/control advanced; no FileIO/path/L3/L4/HUD rewrite | yes |
| AURORA_TRADING_BRAIN_GUIDEBOOK.md | yes | data proof is not trade permission | no signal/trade/execution/risk permission | no trading patch |

Builder answer: the smallest safe patch is Dispatcher-side Top10 yield/cap plus active RUN242 proof-token/telemetry alignment. The starvation owner candidate is persistence-side Top10 service, not L4 ranking itself. Yieldable work: Top10 admission continuation, inflight verification, promotion, and next-symbol queueing. Failures needing cooldown visibility: write/essential/dossier publication and Manifest pending dependency. Untouched: FileIO, routes, L3/L4 formula, HUD, Dossier/Current Focus broad architecture, generated output, trading logic.

Auditor answer: the patch must not hide failures, mark missing proof complete, drop queue work, change final routes, weaken validation, mutate L3/L4, make the EA look faster by skipping truth, edit generated evidence, or add signal/trade wording. RUN241R preserves those boundaries; RUN242 must falsify runtime behavior.

## Protected Lattice / Boundary Contract

| Boundary | System A | System B | Lawful Interface | Source Of Truth | Allowed Crossing | Forbidden Crossing | Acceptance Criteria | HOLD / KILL Condition |
|---|---|---|---|---|---|---|---|---|
| heartbeat ↔ side-duty | 1-sec timer | background work | bounded slices | Dispatcher | work item + yield state | blocking loop | beat returns quickly | 20s beat remains |
| publication failure ↔ retry | failed surface | scheduler | failure + next retry due | writer/dispatcher | reason/cooldown | fake success | bounded retries visible | retry storm |
| Manifest dependency ↔ proof | missing dependency | manifest publisher | dependency-missing state | Dispatcher/proof owner | missing reason | proof complete lie | no cascade hammer | fake proof |
| Top10 side-duty ↔ shortlist truth | heavy refresh | committed L4 source | bounded refresh only | L4/Dispatcher | refresh state | rank/formula change | no ranking drift | formula mutation |
| deferred queue ↔ runtime budget | backlog | heartbeat | per-beat drain cap | Dispatcher | count/drain telemetry | silent drop | observable backlog | queue loss |
| source patch ↔ runtime evidence | active source | RUN242 output | future proof only | source files | checklist | generated mutation | evidence untouched | output edit |
| data review ↔ trade permission | scanner data | trading action | no-permission boundary | Trading Brain law | review labels | buy/sell/entry | permission false | signal wording |

## Static Compile-Risk Sweep

| File | Static Check | Result | Patch Needed? |
|---|---|---|---:|
| ASC_Dispatcher.mqh | brace/paren balance | PASS by static count | no |
| ASC_Dispatcher.mqh | no unbounded loop added | PASS | no |
| ASC_Dispatcher.mqh | elapsed-time/yield helper inserted | PASS by static inspection | no |
| ASC_Dispatcher.mqh | Top10 service signature/call alignment | PASS one callsite updated | no |
| ASC_Dispatcher.mqh | deferred/retry/manifest telemetry fields emitted | PASS | no |
| ASC_FunctionResults.mqh | no logging signature changed | not touched | no |
| ASC_ScannerStatusWriter.mqh | RUN240 token fix preserved | PASS | no |
| ASC_MarketBoardWriter.mqh | RUN240 token fix preserved | PASS | no |
| ASC_ShortlistSelectionEngine.mqh | no ranking/formula behavior change | not touched | no |
| all touched files | no FileIO/path mutation | PASS | no |
| all touched files | no L3/L4 behavior mutation | PASS | no |
| all touched files | no signal/trade wording | PASS | no |

MetaEditor compile was not available/rerun. Compile proof remains outstanding.

## Preservation Check

| Protected Area | Expected | PASS / HOLD / FAIL |
|---|---|---|
| RUN240 Scanner Status token fix | preserved | PASS |
| RUN240 Manifest token fix | preserved | PASS |
| RUN240 Market Board Siam token fix | preserved | PASS |
| RUN228 flat-root disable/dev-only | preserved | PASS |
| RUN228 staging disable/dev-only | preserved | PASS |
| RUN228 archive truth labeling | preserved | PASS |
| GlobalTop10 final path | unchanged | PASS |
| Top5PerBucket final path | unchanged | PASS |
| internal atomic temp/validate/promote safety | preserved | PASS |
| FileIO validation strictness | preserved | PASS |
| RUN229 membership lineage | preserved | PASS |
| RUN230 duplicate resolver | preserved | PASS |
| RUN231 Siam Dossier Request Block | preserved | PASS |
| RUN231 Top10 Numeric Matrix | preserved | PASS |
| RUN233 L3 denominators | preserved | PASS |
| RUN235 L4 transparency fields | preserved | PASS |
| RUN236 sync bridge fields | preserved | PASS |
| Market Board remains consumer-only | yes | PASS |
| SDP remains consumer-only | yes | PASS |
| Dossier/Current Focus architecture | untouched | PASS |
| L3 behavior/gates | unchanged | PASS |
| L4 ranking/formula behavior | unchanged | PASS |
| HUD | untouched | PASS |
| generated output evidence | untouched | PASS |
| no signal/trade permission | preserved | PASS |

## RUN242 Live Acceptance Seed

RUN242 must capture: MetaEditor compile output, Experts log, Journal log, heartbeat_telemetry.log, FunctionResults, Scanner Status, Market Board, Artifact Bundle Manifest, GlobalTop10 final SDP folder, Top5PerBucket/crypto final SDP folder, GlobalTop10 Dossier folder, Top5PerBucket/crypto Dossier folder, broker/server/session note, timestamped freeze/crash note, and whether terminal closed, EA removed, chart froze, or files kept updating.

RUN242 must verify:
- Scanner Status stale-token errors are gone.
- Market Board `Operator Command Surface` errors are gone.
- Manifest stale missing-runtime cascade is gone.
- heartbeat worst value is materially below RUN238 24654ms.
- above_5000ms rows = 0 target.
- above_2000ms rows = 0 after warmup target or clearly explained.
- side_duty_ms no longer dominates heartbeat.
- top10_ms no longer blocks a whole beat.
- deferred_work_count is bounded and/or drains.
- publication retry skipped/cooldown counters appear if implemented.
- no final route regression.
- no FileIO/path regression.
- no signal/trade permission.

If heartbeat remains severe, classify next root as Top10 side-duty, deferred queue, persistence payload, Dossier/SDP burst, terminal resource issue, or unknown. Do not continue semantic upgrades.

## Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| RUN240 token repair is source-present | heartbeat can still starve | RUN240 source/report | RUN238/RUN239 heartbeat evidence | 3 | bounded runtime | both true | RUN241 patches heartbeat side-duty, RUN242 retests | no, but TEST FIRST |
| next live is RUN242 | active required tokens still referenced RUN155 | RUN240 report/version | Scanner Status/Manifest validators before patch | 3 | 3 | current active source outranks old report momentum | active future-facing tokens patched to RUN242 | no after patch |
| faster heartbeat means fixed | faster heartbeat could mean skipped truth | future RUN242 telemetry | guidebook law | future | doctrine | doctrine controls interpretation | added deferred/remaining/retry fields | RUN242 must verify |
| Top10 cap must not change ranking | Top10 service must yield | L4 law | Dispatcher budget law | 3 | 3 | both preserved | scheduler yields without formula/membership change | no |

## Patch Ledger

| File | Patch |
|---|---|
| `mt5/runtime/ASC_Dispatcher.mqh` | RUN241R side-duty hard cap; Top10 service yield checkpoints; heartbeat telemetry additions; RUN242 Manifest required tokens |
| `mt5/core/ASC_Constants.mqh` | heartbeat required fields expanded; active live-contract token values advanced to RUN242 |
| `mt5/core/ASC_Version.mqh` | current run/package advanced to RUN241R; next live proof RUN242R |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | active Scanner Status required tokens advanced to RUN242 |
| `office/ROADMAP_STATUS.md` | RUN241R status updated |
| `office/WORK_LOG.md` | RUN241R work log updated |
| `office/CHANGE_LEDGER.md` | RUN241R change ledger updated |
| `office/DECISIONS.md` | RUN241R TEST FIRST decision updated |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | RUN241R active roadmap log updated |
| `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | RUN241R package manifest updated |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN241R_REPORT.md` | report created |

## Package Validation Table

| Check | Result |
|---|---|
| package name exactly `TRUTH_SEEKER_RUN241R.zip` | PASS |
| changed files only | PASS |
| active repo-relative folder layout preserved | PASS |
| report included | PASS |
| generated runtime output excluded | PASS |
| Symbol Data Packs/Dossiers excluded | PASS |
| Experts/Journal logs excluded | PASS |
| whole repo dump excluded | PASS |
| compile proof claimed | no |
| runtime/live proof claimed | no |
| final decision | TEST FIRST |

## Exact RUN242 Prompt Seed

```text
TRUTH SEEKER ROADMAP — RUN242R / LIVE CRASH-FREEZE RETEST AFTER RUN240–RUN241 REPAIR — VERIFY PUBLICATION RECOVERY, HEARTBEAT STABILITY, ROUTE OUTPUTS, AND NO SIGNAL PERMISSION
MODE: LIVE EVIDENCE REVIEW + DEBUG
LIVE: yes
PACKAGE: TRUTH_SEEKER_RUN242R.zip
REPORT: RUN242R_REPORT.md
PURPOSE:
- compile first
- run bounded live proof after RUN240 token repair and RUN241 heartbeat hardening
- capture MetaEditor compile output, Experts, Journal, heartbeat telemetry, FunctionResults, Scanner Status, Market Board, Artifact Bundle Manifest, routes, Dossiers, broker/session note, and freeze/crash note
- prove or falsify publication recovery
- prove or falsify heartbeat starvation reduction
- classify hard crash vs freeze/starvation with terminal logs
- verify no FileIO/path/L3/L4/HUD/Dossier regression
- verify no signal/trade/execution/risk/prop-firm permission
- generated output is read-only evidence
```
