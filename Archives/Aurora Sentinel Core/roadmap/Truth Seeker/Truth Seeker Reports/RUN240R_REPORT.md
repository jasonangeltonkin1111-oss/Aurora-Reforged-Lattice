# RUN240R REPORT — Publication Token Contract Repair + Failure-Loop Containment

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN240R / PUBLICATION TOKEN CONTRACT REPAIR + FAILURE-LOOP CONTAINMENT — FIX SCANNER STATUS, MARKET BOARD, AND MANIFEST VALIDATION BEFORE HEARTBEAT HARDENING
MODE: DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN240R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN240R.zip
SOURCE BASELINE: RUN238R COMPILE-CLEAN SOURCE STATE + RUN239R AUDIT FINDINGS
NEXT RUN: RUN241R HEARTBEAT / PERSISTENCE / TOP10 / DEFERRED QUEUE HARDENING
NEXT LIVE TEST: RUN242R
FINAL DECISION: TEST FIRST
```

```text
FINAL SUMMARY

RUN240R patched source/control only. No live/output files were requested, regenerated, cleaned, renamed, deleted, edited, or packaged. RUN238/RUN239 evidence was treated as read-only intake, and generated output was not used as source truth.

Exact Scanner Status token contract repair: ASC_ScannerStatusWriter.mqh required token changed from missing_runtime_surface_classification=missing_runtime_surface to missing_runtime_surface_classification=policy_declared so it matches the active ASC_ArtifactTextHelpers.mqh emitted line.

Exact Artifact Bundle Manifest token/dependency repair: ASC_Dispatcher.mqh manifest required-token contract changed from missing_runtime_surface_classification=missing_runtime_surface to missing_runtime_surface_classification=policy_declared so Manifest and Scanner Status require the same canonical missing-runtime policy token.

Exact Market Board required-token repair: ASC_MarketBoardWriter.mqh now emits stable machine-readable token board_surface_role=siam_review_intake immediately under the existing Siam Review Intake Surface heading, and the required token list now validates board_surface_role=siam_review_intake instead of stale Operator Command Surface.

Operator Command Surface no longer appears anywhere in active mt5 source required-token validation by grep. Command-bias wording was not restored. SIAM_DOSSIER_REQUEST_BLOCK and TOP10_NUMERIC_MATRIX remain present. FileIO validation remained strict: no FileIO file or validation helper was edited, and required-token validation was aligned rather than removed.

No retry/failure-loop containment was added in RUN240R. Source inspection showed Scanner Status already has a small 2-second write guard, but Market Board / Manifest / write-lane retry behavior belongs to the broader heartbeat/persistence hardening pass. RUN241R must handle side-duty, Top10, manifest cascade, and deferred queue pressure.

Files changed: mt5/artifacts/ASC_ScannerStatusWriter.mqh; mt5/runtime/ASC_Dispatcher.mqh; mt5/artifacts/ASC_MarketBoardWriter.mqh; mt5/core/ASC_Version.mqh; office/ROADMAP_STATUS.md; office/WORK_LOG.md; office/CHANGE_LEDGER.md; office/DECISIONS.md; roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md; roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md; roadmap/Truth Seeker/Truth Seeker Reports/RUN240R_REPORT.md.

MetaEditor compile was not rerun in this environment. Compile proof remains outstanding. Runtime/live proof remains outstanding until RUN242R after RUN241R heartbeat persistence starvation hardening.

Untouched: generated output evidence, FileIO, final routes, path constants, L3 gates, L4 ranking/order/formula, membership source, HUD, Dossier/Current Focus broad architecture, strategy/signal/trade/execution/risk logic, and prop-firm permission.

Exact next move: RUN241R heartbeat persistence starvation hardening, then RUN242R live proof.
```

## Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN240R |
| primary mode | DEBUG |
| secondary mode | PATCH |
| live run? | no |
| runtime/output artifacts expected? | no new runtime output |
| source editing allowed? | yes, token-contract repair only |
| generated output editing/cleanup allowed? | no |
| FileIO rewrite allowed? | no |
| final path mutation allowed? | no |
| L3/L4 behavior change allowed? | no |
| HUD / Dossier / Current Focus broad patch allowed? | no |
| signal/trade/execution/risk patch allowed? | no |
| next source run | RUN241R |
| next live test | RUN242R |
| final serious decision | TEST FIRST |

## Evidence Ladder

| Evidence | Rank | Meaning in RUN240R |
|---|---:|---|
| RUN239 report and RUN238 report | 2/3 | Prior audit claims; useful but rechecked against active source where possible |
| Direct active source inspection | 3 | Current authority for token ownership and patch scope |
| Static grep/diff after patch | 3 | Shows expected strings changed/removed; not compile proof |
| MetaEditor compile output | 4 | Not supplied/rerun here |
| Runtime/live proof | 5+ | Not produced in RUN240R |

## No-Live-Output Boundary

No generated Symbol Data Packs, Dossiers, Manifest, Scanner Status, FunctionResults, heartbeat telemetry, Experts logs, Journal logs, screenshots, or live output folders were edited or packaged. Generated evidence remains read-only history, not source authority.

## RUN239 Absorption Table

| RUN239 Finding | Evidence Source | Evidence Rank | Source Owner | Patch Required? | RUN240 Action |
|---|---|---:|---|---:|---|
| Scanner Status requires `missing_runtime_surface_classification=missing_runtime_surface` | RUN239 + direct source | 3 | ASC_ScannerStatusWriter.mqh | yes | aligned required token to `policy_declared` |
| helper emits `missing_runtime_surface_classification=policy_declared` | direct source | 3 | ASC_ArtifactTextHelpers.mqh | no emitter change | preserved helper output |
| Manifest requires stale token | RUN239 + direct source | 3 | ASC_Dispatcher.mqh | yes | aligned manifest required token to `policy_declared` |
| Market Board requires `Operator Command Surface` | RUN239 + direct source | 3 | ASC_MarketBoardWriter.mqh | yes | replaced validator with stable Siam token |
| body emits `Siam Review Intake Surface` | direct source | 3 | ASC_MarketBoardWriter.mqh | preserve | heading preserved; stable key added below it |
| heartbeat starvation severe | RUN238 telemetry / RUN239 | 5 bounded runtime evidence | Dispatcher/persistence | defer broad repair | RUN241 seed created |
| hard crash unproven | missing Experts/Journal | evidence gap | runtime evidence | no patch | require RUN242 logs |
| successful SDP/Dossier writes | RUN238 evidence | bounded runtime evidence | writers | preserve | no route/path change |

## Publication Token Contract Repair Table

| Surface | Prior Required Token | Current Emitted Token / Heading | Correct Canonical Direction | Patch Owner | PASS / HOLD / FAIL |
|---|---|---|---|---|---|
| Scanner Status | `missing_runtime_surface_classification=missing_runtime_surface` | `missing_runtime_surface_classification=policy_declared` | require emitted stable key/value | ASC_ScannerStatusWriter.mqh | PASS |
| Artifact Bundle Manifest | `missing_runtime_surface_classification=missing_runtime_surface` | depends on same helper/status proof | match Scanner Status policy token | ASC_Dispatcher.mqh | PASS |
| Market Board | `Operator Command Surface` | `Siam Review Intake Surface` + new `board_surface_role=siam_review_intake` | validate stable non-command key | ASC_MarketBoardWriter.mqh | PASS |

## Manifest Cascade Repair Check

| Manifest Dependency | Current Requirement After Patch | Failure Mode Before Patch | RUN240 Patch? | RUN241 Seed? |
|---|---|---|---:|---:|
| Scanner Status proof | `missing_runtime_surface_classification=policy_declared` | Scanner Status could fail before Manifest proof | yes | yes, prove cascade stops live |
| Market Board proof | stable board proof can publish if board body validates | board proof missing due stale command token | yes | yes, inspect retry cadence |
| missing-runtime-surface classification | same canonical policy token across Status and Manifest | stale mismatch | yes | no broad change |
| board proof missing | truthfully remains missing if board fails | dependency cascade | no fake proof | yes |
| repeated manifest retry | not broadly changed | potential write-lane pressure | no | yes |

## Failure-Loop Containment Inspection

| Source Area | File | Finding | RUN240 Patch? |
|---|---|---|---:|
| Scanner Status write failure retry | ASC_Dispatcher / ASC_ScannerStatusWriter | `ASC_MaybeWriteScannerStatus` already has a two-second last-write guard; token mismatch was the direct blocker | no extra containment |
| Market Board write failure retry | ASC_Dispatcher / ASC_MarketBoardWriter | board writes occur inside write-lane when bundle work is pending; stale token was direct blocker | no broad retry patch |
| Manifest dependency failure retry | ASC_Dispatcher | manifest token was stale; repeated retry behavior needs budget-aware pass | no broad retry patch |
| FunctionResults logging | ASC_FunctionResults | no direct source patch required for token repair | no |
| heartbeat/deferred queue | ASC_Dispatcher | starvation evidence points at persistence/top10/deferred work | inspect/defer |
| Top10 side-duty time | ASC_Dispatcher | RUN238 evidence shows top10_ms ~= worst heartbeat | inspect/defer |

## Heartbeat Starvation RUN241 Seed

| Field | RUN241 Target / Inspection Requirement |
|---|---|
| heartbeat_max_ms target | prove worst heartbeat no longer reaches multi-second starvation; hard target under 1200ms after warmup, aspirational near 880ms budget |
| above_5000ms target | 0 rows in bounded live proof |
| above_2000ms target | 0 rows after warmup or clearly explained exceptional startup only |
| deferred_work_count behavior | bounded, drains over time, no unbounded 1000+ pressure without yield reason |
| side_duty_ms behavior | capped/yielded; never allowed to dominate whole heartbeat |
| top10_ms behavior | Top10 side duty must yield before starving 1-second heartbeat |
| persistence retry behavior | required-token failures must not hammer every write lane |
| publication failure retry behavior | failed Scanner Status / Market Board / Manifest should expose last reason + next retry due |
| manifest dependency cascade behavior | dependency-missing state must be truthful and bounded, not fake complete and not full rebuild storm |

## Multi-Domain Research Lattice

| Research Lane | Source / Authority | Finding | Converted RUN240 Constraint | Falsifier |
|---|---|---|---|---|
| MQL5 / MT5 mechanics | Official MQL5 EventSetTimer / OnTimer docs | Timer events are queued per program; if a Timer event is already queued or processing, a new one is not added | do not assume heartbeat overlap; starvation can look like frozen OnTimer processing | claim hard crash without Experts/Journal |
| MQL5 FileIO/error discipline | Official MQL5 FileFlush, GetLastError, ResetLastError docs | file writes may require flush/close for durable disk state; frequent flush can affect speed; GetLastError is not self-resetting | do not weaken FileIO validation; do not rewrite FileIO in token pass | FileIO edited or validation removed |
| SRE/reliability | Google SRE cascading failures + retry-storm guidance | overload/retry loops can amplify failure load | token failures should not hammer publication lanes; defer broader backoff to RUN241 | failed publication treated as success or retried unbounded |
| Observability | IBM/Red Hat/New Relic observability guidance | logs/metrics/events are needed to infer system state | RUN241/RUN242 must expose counters, last reason, next retry due, and heartbeat lane timings | no telemetry to prove recovery |
| Secure SDLC/root-cause discipline | source-owner debugging discipline | smallest owner repair beats broad rewrite | patch validators/emitters only; no generated output mutation | patch spreads into scheduler/HUD/FileIO |
| Data governance/validation contracts | contract-validity principle applied to active source | stable machine-readable tokens resist visible heading drift | add `board_surface_role=siam_review_intake`; align Status/Manifest to emitted key | heading-only validation drifts again |
| Protected lattice / boundary surgery | Aurora doctrine and guidebooks | source truth and proof surfaces need explicit lawful boundary | emitter↔validator contract repaired; generated evidence untouched | fake proof or boundary leak |

## Brain Guidebook / Two-Brain Check

| Guidebook | Read? | Key Rule Extracted | Converted RUN240 Constraint | Patch Needed? |
|---|---:|---|---|---:|
| AURORA_GUIDEBOOK_INDEX.md | yes | guidebooks are authority gates for coding/trading brain split | include two-brain check and prevent drift | no guidebook patch |
| AURORA_CODING_BRAIN_GUIDEBOOK.md | yes | source files outrank reports; patch smallest owner | edit validators/emitters only | no guidebook patch |
| AURORA_TRADING_BRAIN_GUIDEBOOK.md | yes | scanner/review surfaces do not grant trades | avoid command/signal wording | no guidebook patch |

### Brain 1 — Builder

Smallest safe patch: align Scanner Status and Manifest required tokens to the helper’s existing `policy_declared` token; add and require one stable board role key; preserve visible Siam heading. Token repair was done without touching FileIO. Failure-loop containment beyond token repair is not small enough for RUN240 and belongs to RUN241.

### Brain 2 — Auditor

Main hidden dangers: removing validation instead of aligning it; restoring command wording; leaving Manifest stale; faking dependency proof complete; slipping into scheduler redesign; mutating generated output; changing L3/L4 behavior; introducing signal/trade language. None of those were done.

## Protected Lattice / Boundary Contract

| Boundary | System A | System B | Lawful Interface | Source Of Truth | Allowed Crossing | Forbidden Crossing | Acceptance Criteria | HOLD / KILL Condition |
|---|---|---|---|---|---|---|---|---|
| emitter ↔ validator | ArtifactTextHelpers / Board body | required-token lists | stable canonical token | active source | token string | stale heading drift | validator matches emitter | mismatch remains |
| Scanner Status ↔ Manifest | status proof | manifest dependency | same canonical proof token | source contract | proof/missing state | fake proof complete | cascade token aligned | dependency lie |
| Market Board ↔ Manifest | board proof | manifest dependency | Siam intake proof token | MarketBoard source | review-surface proof | command surface wording | board validates Siam role | command bias |
| failure logging ↔ heartbeat | failures | runtime scheduler | bounded retry/counter | Dispatcher/logging owner | reason/cooldown | retry storm | no hammering in RUN242 | failure storm |
| source patch ↔ generated evidence | active source | runtime output | future proof only | source files | checklist | output mutation | evidence untouched | generated edit |
| review surface ↔ trade permission | Siam intake | trading decision | no-permission boundary | Trading Brain law | review labels | buy/sell/entry | permission false | signal wording |

## Static Compile-Risk Sweep

| File | Static Check | Result | Patch Needed? |
|---|---|---|---:|
| ASC_ScannerStatusWriter.mqh | required token matches emitted token | PASS: `policy_declared` | done |
| ASC_ScannerStatusWriter.mqh | required token count/list valid | PASS: no count changed | no |
| ASC_ArtifactTextHelpers.mqh | canonical missing-runtime line emitted | PASS: unchanged | no |
| ASC_ArtifactTextHelpers.mqh | no contradictory duplicate classification | PASS by grep | no |
| ASC_Dispatcher.mqh | Manifest token contract aligned | PASS: `policy_declared` | done |
| ASC_Dispatcher.mqh | no broad scheduler rewrite | PASS | no |
| ASC_MarketBoardWriter.mqh | stale Operator Command Surface removed from required tokens | PASS by grep | done |
| ASC_MarketBoardWriter.mqh | Siam Review Intake Surface / stable board token emitted | PASS | done |
| ASC_MarketBoardWriter.mqh | SIAM_DOSSIER_REQUEST_BLOCK preserved | PASS by grep | no |
| ASC_MarketBoardWriter.mqh | TOP10_NUMERIC_MATRIX preserved | PASS by grep | no |
| ASC_FunctionResults.mqh | only touched if needed | PASS: untouched | no |
| all touched files | no FileIO/path mutation | PASS | no |
| all touched files | no L3/L4 behavior mutation | PASS | no |
| all touched files | no signal/trade wording | PASS | no |

MetaEditor compile was not available/rerun. Compile proof remains outstanding.

## Preservation Check

| Protected Area | Expected | PASS / HOLD / FAIL |
|---|---|---|
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

## Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| Scanner Status requires `missing_runtime_surface_classification=missing_runtime_surface` | helper emits `missing_runtime_surface_classification=policy_declared` | ASC_ScannerStatusWriter.mqh | ASC_ArtifactTextHelpers.mqh | 3 | 3 | neither; contract must align | validator changed to emitted token | no after patch; compile still needed |
| Manifest requires stale missing-runtime token | Scanner Status/helper uses policy token | ASC_Dispatcher.mqh | ASC_ArtifactTextHelpers.mqh | 3 | 3 | source contract alignment required | Manifest validator changed to policy token | no after patch; runtime still needed |
| Market Board validator expects command surface | body emits Siam review intake | ASC_MarketBoardWriter.mqh validator | ASC_MarketBoardWriter.mqh body | 3 | 3 | RUN231 non-command direction wins | added stable Siam role token and validator | no after patch; runtime still needed |
| FileIO validation strictness must remain | stale token must be fixed | FileIO law | token contract source | 3 | 3 | both preserved | validation aligned, not removed | no |
| RUN240 token repair done | runtime proof exists | source diff | no RUN240 runtime | 3 | n/a | no runtime proof | TEST FIRST | yes, live proof deferred |

## Patch Ledger

| File | Change |
|---|---|
| mt5/artifacts/ASC_ScannerStatusWriter.mqh | required token aligned to `missing_runtime_surface_classification=policy_declared` |
| mt5/runtime/ASC_Dispatcher.mqh | Manifest required token aligned to `missing_runtime_surface_classification=policy_declared` |
| mt5/artifacts/ASC_MarketBoardWriter.mqh | emitted `board_surface_role=siam_review_intake`; required token changed to that stable key |
| mt5/core/ASC_Version.mqh | run identity advanced to RUN240R; next source RUN241R; next live RUN242R; package name RUN240R |
| office/control + roadmap/control | status, work log, decision, package manifest, active roadmap advanced to RUN240R/RUN241R |
| RUN240R_REPORT.md | created |

## Package Validation Table

| Check | Result |
|---|---|
| exact package name | TRUTH_SEEKER_RUN240R.zip |
| changed files only | yes |
| repo-relative root preserved | Aurora Sentinel Core/... |
| generated output excluded | yes |
| FileIO excluded | yes |
| whole repo excluded | yes |
| report included | yes |
| live proof claimed | no |
| compile proof claimed | no |
| final decision | TEST FIRST |

## Exact RUN241 Prompt Seed

```text
TRUTH SEEKER ROADMAP — RUN241R / HEARTBEAT PERSISTENCE STARVATION HARDENING — CAP SIDE-DUTY, TOP10, STATUS RETRY, MANIFEST CASCADE, AND DEFERRED QUEUE PRESSURE BEFORE LIVE RETEST
MODE: DEBUG + PATCH
LIVE: no
PACKAGE: TRUTH_SEEKER_RUN241R.zip
REPORT: RUN241R_REPORT.md
NEXT LIVE TEST: RUN242R
PURPOSE:
- inspect and patch heartbeat starvation sources after RUN240 token repair
- protect 1-second heartbeat law
- cap or yield Top10 side-duty if source shows blocking risk
- ensure Scanner Status / Market Board / Manifest failure retry cannot hammer every heartbeat
- ensure deferred queue drain is bounded and observable
- preserve RUN240 token fixes
- preserve RUN228–RUN236 source corridor
- no generated output request
- no output mutation
- no FileIO rewrite
- no final path mutation
- no L3 behavior changes
- no L4 ranking/formula changes
- no HUD/Dossier architecture patch
- no signal/trade permission
```

TEST FIRST.
