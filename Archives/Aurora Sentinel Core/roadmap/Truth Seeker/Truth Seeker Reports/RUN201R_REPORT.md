# RUN201R REPORT — Lite Due + Hydration Timing Alignment

## GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN201R / LITE DUE + HYDRATION TIMING ALIGNMENT — MATCH MAIN PUBLICATION CADENCE WHERE SOURCE AND RUN199 EVIDENCE PROVE MISMATCH

MODE: AUDIT + PATCH  
RESULT: PASS-BY-SOURCE-PATCH  
SERIOUS DECISION: TEST FIRST

Patched files:
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/artifacts/ASC_ScannerStatusWriter.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/Truth Seeker Reports/RUN201R_REPORT.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`

Evidence ceiling: direct source inspection and source patch proof only. No MetaEditor compile output, runtime output, live output, production readiness, edge, signal, trade, execution, or risk proof is claimed.

## FINAL SUMMARY

RUN201R audited the main Dossier write-lane timing model and the Lite SDP flat/GlobalTop10/Top5PerBucket timing model. The load-bearing mismatch was not path or cadence ownership; it was observability: Lite could expose `not_due`, empty committed membership, retained-last-good, or no-change states without enough explicit due reason, deferred-until, hydration reason, weekend/closed context, and write-pressure context for RUN205 live evidence.

RUN201R patched bounded diagnostics only:
- Added explicit SDP due state/reason fields for Lite route surfaces.
- Added `sdp_last_attempt_utc`, `sdp_last_success_utc` where route state already owns it, `sdp_next_due_utc`, `sdp_deferred_until_utc`, `sdp_hydration_state`, `sdp_hydration_reason`, `sdp_membership_snapshot_time`, `sdp_weekend_or_closed_context`, and `sdp_write_pressure_state` where the route/status surface needed live-proof clarity.
- Added not-due reason assignment in Lite/GlobalTop10/Top5 service guards.
- Preserved final child paths, staging paths, archive paths, FileIO, SDP composer payload, writer required-token list, membership source, rank/order/formula, HUD, Market Board, strategy/signal/trade/execution/risk boundaries.

RUN205 can now distinguish not-due, deferred/no snapshot/no committed membership, no-change, retained-last-good, and write-pressure states without treating weekend/closed-market inactive buckets as write failures. The patch does not prove live behavior; RUN205 must prove it.

Decision: TEST FIRST.

## SECTION 0 — TRUTH FURNACE MODE LOCK

| Declaration | Answer |
|---|---|
| current run | RUN201R |
| primary mode | AUDIT |
| secondary mode | PATCH |
| purpose | Lite due and hydration timing alignment before RUN205 live |
| active baseline | RUN200R over RUN193 final child path |
| is RUN201 live? | no |
| next live proof | RUN205R |
| second follow-up live proof | RUN210R |
| is source patch allowed? | yes, only proven timing/proof-contract gaps |
| is feature expansion allowed? | no |
| is data hydration implementation allowed? | no |
| is final path mutation allowed? | no |
| is hard-required SDP token expansion allowed? | no |
| is composer payload enrichment allowed? | no |
| is FileIO rewrite allowed? | no |
| is flush-loop patch allowed? | no |
| is broad Dispatcher rewrite allowed? | no |
| is rank/order/formula mutation allowed? | no |
| is new membership source allowed? | no |
| is strategy/execution allowed? | no |
| final serious decision | TEST FIRST |

## SECTION 1 — REQUIRED READ ORDER

Required context was reviewed by source inspection where present. Reports RUN194R-RUN200R were present. RUN201R_REPORT existed from the uploaded baseline and was replaced with this current RUN201R report. FileIO was read-only. Market Board/L3/L4 owners were treated as protected/read-only.

## SECTION 2 — OFFICIAL / EXTERNAL RESEARCH LEDGER

| Research Area | Source / Authority | Finding | Converted Constraint | RUN201 Impact |
|---|---|---|---|---|
| MQL5 OnTimer / EventSetTimer queue | MQL5 docs `EventSetTimer`, `OnTimer`, program running/event queue | Timer events do not stack if one is already queued/processing. | No catch-up assumptions; no write-pressure increase. | Diagnostics only; no scheduler loop expansion. |
| EventSetMillisecondTimer caution | MQL5 docs `EventSetMillisecondTimer` | Faster timers increase tester/runtime load; not needed for normal >1s cadence. | Do not implement millisecond timer. | Not implemented. |
| TimeCurrent / TimeTradeServer / TimeGMT | MQL5 docs | `TimeCurrent()` is last known server/quote time outside OnTick; `TimeTradeServer()` is calculated in terminal; testing behavior differs. | Timestamps are diagnostic; runtime output still outranks source. | Existing `TimeCurrent()` style preserved; no timing source rewrite. |
| FileOpen sandbox/subfolders | MQL5 docs `FileOpen` / Files | File paths operate inside terminal sandbox/common file areas. | Do not mutate final/staging/archive path rules. | Paths preserved. |
| FileFlush speed caveat | MQL5 docs `FileFlush` | Frequent flushing can hurt speed. | No FileFlush loops. | FileIO untouched. |
| GetLastError / ResetLastError | MQL5 docs common error handling | Error probes need reset before fresh probe if added. | Avoid adding new low-level probes. | No new GetLastError probes. |
| Scheduler/cadence source review | Source-review discipline | Trace owner, callsite, due/next_due/attempt/success, protected areas, and regression surface. | Patch only proof-contract ambiguity. | Dispatcher/ScannerStatus diagnostics only. |
| Observability for cadence | Ops/logging design | Due, reason, next_due, deferred_until, last_attempt, last_success, duration, write pressure are necessary to interpret absence. | Empty folders must not be ambiguous. | RUN201 added bounded proof fields. |

## SECTION 3 — TWO-BRAIN CHECK

| Brain / Guidebook | Read? | Contradiction Found? | Durable Lesson Needed? | Patch Needed? | Patch Decision |
|---|---:|---:|---:|---:|---|
| AURORA_GUIDEBOOK_INDEX.md | yes | no | no | no | existing doctrine sufficient |
| AURORA_CODING_BRAIN_GUIDEBOOK.md | yes | no | no | no | no ornamental patch |
| AURORA_TRADING_BRAIN_GUIDEBOOK.md | yes | no | no | no | trading/signal boundary preserved |

Durable lessons used: timing clarity must reduce ambiguity without increasing write pressure; Lite exposes due/not_due/deferred/no_snapshot/closed-market context; RUN199/RUN205/RUN210 are live proof runs; no data hydration before RUN210 unless explicitly overridden; logging does not make Lite a signal engine.

## SECTION 4 — RUN200 PACKAGE / PATCH ABSORPTION CHECK

| RUN200 Item | Expected | Observed | PASS / HOLD / FAIL | Patch Needed? |
|---|---|---|---|---:|
| package root | Aurora Sentinel Core/... | root preserved | PASS | no |
| RUN200 report present | yes | `RUN200R_REPORT.md` present | PASS | no |
| ASC_Version identity | RUN200R-LifecycleLoggingScannerStatusParity | observed before RUN201 bump | PASS | no |
| lifecycle diagnostic fields present | yes | present in Dispatcher/Scanner Status | PASS | no |
| weekend/inactive fields present | yes | present but too coarse | HOLD | yes |
| Scanner Status phase8 token repair preserved | yes | source preserved | PASS | no |
| FileIO untouched | yes | unchanged | PASS | no |
| writer tokens untouched | yes | unchanged | PASS | no |
| composer payload untouched | yes | unchanged | PASS | no |
| final paths untouched | yes | unchanged | PASS | no |

## SECTION 5 — MAIN DOSSIER TIMING MODEL AUDIT

| Main Timing Area | Source Owner / Function | Current Value / Logic | Evidence | Lite Should Match? |
|---|---|---|---|---:|
| publish cadence | `ASC_RunWriteLane`, Dossier publication bundle | write lane admits dossier work after dirty/pending gates and budget checks | source | analogous |
| last_attempt | dossier writer/publication bundle state | attempt tracked through write lifecycle, not every idle beat | source | yes |
| last_success | writer/publication bundle result | success only after actual write/publish state | source | yes |
| next_due | main lanes use due/pending/backoff/cadence fields | explicit in Dossier/current-focus cadence surfaces | source | yes |
| not_due reason | skip/defer reasons exist in lane state | e.g. no write dirty, publication pending, current focus waiting | source | yes |
| deferred reason | budget/catchup/current-focus ownership reasons | explicit lane_deferred_reason/yield_reason | source | yes |
| closed-market state | Layer 1 and publication bundle drive availability | main does not fake open state | source | yes |
| retained-last-good timing | FileIO publication continuity semantics | current truth remains final/last-good boundary | source | yes |
| no-change skip timing | material compare/skip behavior | no-change is not failure | source | yes |
| staging timing | writer-owned proof surface | candidate proof only | source | analogous |
| archive timing | writer-owned continuity evidence | previous-final evidence only | source | analogous |
| write pressure tracking | beat budget/write lane | explicit budget and yield reasons | source | yes |

## SECTION 6 — LITE SDP TIMING MODEL AUDIT

| Lite Timing Area | Source Owner / Function | Current Value / Logic | Evidence | Gap vs Main |
|---|---|---|---|---|
| publish cadence | `ASC_ServiceSymbolDataPackLiteRuntimeActivation`, GlobalTop10/Top5 services | bounded one-symbol/family cursor cadence using `ASC_SDP_FULL_PACK_PROOF_HEARTBEAT_SECONDS` and heartbeat retry | source | acceptable |
| last_attempt | route-specific state fields | set before writer call | source | acceptable |
| last_success | route-specific state fields | set on fresh write success; no-change not fresh | source | acceptable |
| next_due | route-specific next_due fields | set to heartbeat or full-pack proof cadence | source | acceptable but visibility insufficient |
| not_due reason | service guard | previously mode only, reason missing/weak | source | patched |
| deferred reason | budget/no snapshot/no queue | present but not normalized | source | patched diagnostics |
| closed-market state | not owned by Lite | previously runtime_calendar_required/unknown | source | kept cautious |
| retained-last-good timing | writer reason/state | present | source | surfaced clearer |
| no-change skip timing | writer reason/state | present | source | surfaced clearer |
| staging timing | writer reason/state | present | source | unchanged |
| archive timing | writer reason/state | present | source | unchanged |
| write pressure tracking | budget guard | present | source | surfaced clearer |

## SECTION 7 — DUE / HYDRATION ALIGNMENT LEDGER

| Timing Area | Main Behavior | Lite Behavior | Classification | Patch Now? | Reason |
|---|---|---|---|---:|---|
| publish cadence | write-lane bounded | bounded route cadence | intentional difference | no | Lite is lighter product |
| next_due calculation | explicit due/defer model | present route fields | match with visibility gap | yes | RUN205 needs proof fields |
| last_attempt | write attempts only | write attempts only | match | no | preserved |
| last_success | success only | fresh success only | match | no | preserved |
| deferred_until | implicit/explicit via due/backoff | next_due existed but not always named | bug/observability gap | yes | patched |
| no_snapshot | main does not fake truth | GlobalTop10 no snapshot | match with wording gap | yes | patched reason |
| no_open_membership | main does not fake truth | Top5 no committed queue | match with wording gap | yes | patched reason |
| closed_market | L1/source owns truth | Lite cannot infer | intentional difference | yes diagnostic | logs cautious context |
| weekend inactivity | source/session evidence required | not hardcoded | match | yes diagnostic | prevents false failures |
| retained_last_good | continuity not fresh success | same | match | yes diagnostic | surfaced |
| no_change | skip not failure | same | match | yes diagnostic | surfaced |
| write_pressure | budget/yield state | budget guard | match | yes diagnostic | surfaced |

## SECTION 8 — PATCHABLE TIMING / DUE STATE CONTRACT

| Field | Main Equivalent | Lite Emits? | Patch Needed? | Reason |
|---|---|---:|---:|---|
| `sdp_due_state` | due/admission state | yes | yes | normalized |
| `sdp_due_reason` | skip/defer reason | yes | yes | prevents ambiguous empties |
| `sdp_last_attempt_utc` | writer attempt | yes | yes | proof clock |
| `sdp_last_success_utc` | writer success | yes where route owns it | yes | proof clock |
| `sdp_next_due_utc` | due/backoff | yes | yes | proof clock |
| `sdp_deferred_until_utc` | defer/backoff | yes | yes | not_due proof |
| `sdp_hydration_state` | hydration state | yes | yes | states no SIAM hydration |
| `sdp_hydration_reason` | hydration reason | yes | yes | prevents false enrichment expectation |
| `sdp_membership_snapshot_time` | source snapshot | yes | yes | source context |
| `sdp_weekend_or_closed_context` | L1/session context | yes cautious | yes | no hard crypto-only assumption |
| `sdp_write_pressure_state` | budget/yield | yes | yes | budget proof |

## SECTION 9 — WEEKEND / CLOSED-MARKET TIMING RULE

| Asset/Bucket Context | Required Weekend State | Required Weekday/Open State | Patch Needed? |
|---|---|---|---:|
| crypto open | active_open_membership or no_change | normal due cadence | no behavior patch |
| forex weekend | closed_market / deferred_until_open / not_applicable_weekend when source proves it | active/open logic when market opens | diagnostic only |
| metals weekend | closed_market / deferred_until_open / not_applicable_weekend when source proves it | active/open logic when market opens | diagnostic only |
| indices weekend | closed_market / deferred_until_open / not_applicable_weekend when source proves it | active/open logic when market opens | diagnostic only |
| stocks/ETFs weekend | closed_market / deferred_until_open / not_applicable_weekend when source proves it | active/open logic when market opens | diagnostic only |

RUN201 did not hardcode crypto-only behavior. Where Lite lacks market-state basis, it logs cautious context instead of certainty.

## SECTION 10 — RUN205 LIVE OBSERVABILITY CHECK

| RUN205 Timing Proof Need | Source Emits? | Surface | Patch Needed? |
|---|---:|---|---:|
| last attempt time | yes | Scanner/Status/route lines | yes patched |
| last success time | yes | Scanner/Status/route lines | yes patched |
| next due time | yes | Scanner/Status/route lines | yes patched |
| not due reason | yes | service reason/status | yes patched |
| deferred reason | yes | route status | yes patched |
| closed-market reason | cautious | lifecycle context | yes patched |
| retained-last-good state | yes | writer/status | yes surfaced |
| no-change state | yes | writer/status | yes surfaced |
| write pressure state | yes | route status/log | yes surfaced |
| weekend context | cautious | route status | yes patched |

## SECTION 11 — PATCH SCOPE

| Gap Found | Evidence | Patch Allowed? | File | Patch Decision |
|---|---|---:|---|---|
| not_due had weak reason | source | yes | Dispatcher / Scanner Status | patched |
| deferred_until not explicit | source | yes | Dispatcher / Scanner Status | patched |
| weekend/closed context too vague | source + RUN199 weekend evidence | yes | Dispatcher / Scanner Status | patched as cautious diagnostic |
| hydration reason absent | source | yes | Dispatcher / Scanner Status | patched no-SIAM reason |
| source identity version stale | source | yes | ASC_Version | patched |

## SECTION 12 — LOGGING / TIMING IMPLEMENTATION GUARDRAILS

| Guardrail | Patch Evidence | PASS / HOLD |
|---|---|---|
| one concise line per attempt/decision | route status/log fields only | PASS |
| no per-symbol whole-universe spam | no loops added | PASS |
| no filesystem loop | none added | PASS |
| no new final writes | no writer path changes | PASS |
| no duplicated route attempts | no callsite duplication | PASS |
| no FileFlush loops | FileIO untouched | PASS |
| no membership recomputation | existing snapshots only | PASS |
| no hardcoded weekend-only assumption | cautious context only | PASS |
| no fake success | success logic unchanged | PASS |
| no old failed-chain token prose | none added | PASS |

## SECTION 13 — MAIN / LITE SINGLE-SOURCE SYNC CHECK

| Truth Area | Main Owner | Lite Consumer | RUN201 Change? | Safe? |
|---|---|---|---:|---:|
| GlobalTop10 membership | L4 committed snapshot | SDP mirror | no | yes |
| Top5PerBucket membership | L4 committed snapshot | SDP mirror | no | yes |
| rank/order/formula | L4 owner | Lite proof only | no | yes |
| Dossier final files | Dossier writer | main product | no | yes |
| SDP final child files | SDP writer | Lite current truth | diagnostics only | yes |
| staging files | writer/FileIO wrapper | candidate proof | no behavior change | yes |
| archive files | writer/FileIO wrapper | continuity evidence | no behavior change | yes |
| Manifest | proof surface | status only | diagnostic | yes |
| Scanner Status | proof surface | status only | diagnostic | yes |

## SECTION 14 — PROTECTED AREA CHECK

| Protected Area | Expected | Observed | PASS / HOLD / FAIL | Patch Needed? |
|---|---|---|---|---:|
| ASC_FileIO.mqh | unchanged | unchanged by cmp | PASS | no |
| SDP composer payload | unchanged | unchanged by cmp | PASS | no |
| writer required tokens | unchanged | unchanged by cmp | PASS | no |
| final target paths | unchanged | writer unchanged | PASS | no |
| staging/archive behavior | no rewrite | writer unchanged | PASS | no |
| Dispatcher | no broad rewrite | narrow diagnostics/service reasons | PASS | yes |
| HUD | unchanged | not touched | PASS | no |
| Market Board | unchanged | not touched | PASS | no |
| L3 formula | unchanged | not touched | PASS | no |
| L4 rank/order/formula | unchanged | not touched | PASS | no |
| strategy/execution | absent/unchanged | not touched | PASS | no |

## SECTION 15 — STATIC COMPILE-SAFETY SWEEP

| Static Compile-Safety Check | Result | Evidence | Patch Needed? |
|---|---|---|---:|
| missing include | PASS by source | reused existing helpers/includes | no |
| undefined helper | PASS by source | helper functions inserted before use | no |
| duplicate macro/function | PASS by grep | no duplicate helper names found | no |
| key=value string quote/escape damage | PASS by quote parity | quote count even | no |
| StringFormat mismatch | PASS | no new StringFormat calls | no |
| enum route mismatch | PASS | no enum mutation | no |
| bucket slug empty handling | PASS | unchanged route helper | no |
| stale GetLastError misuse | PASS | no GetLastError added | no |
| semicolon/brace issue | PASS by brace balance | balance 0 | no |
| writer token expansion | PASS | writer unchanged | no |
| payload enrichment | PASS | composer unchanged | no |
| staging/archive rewrite | PASS | writer unchanged | no |
| FileIO rewrite | PASS | unchanged | no |
| rank/order/formula mutation | PASS | not touched | no |
| trade/signal/risk text | PASS | permissions remain false | no |
| permanent crypto-only hardcode | PASS | no hardcode | no |
| repeated due write loop risk | PASS | no loop/cadence expansion | no |

No compile proof is claimed.

## SECTION 16 — NO-ORNAMENT RULE

| Timing / Proof Item | Failure It Prevents | Keep / Delete / Merge / Convert To Test |
|---|---|---|
| due/not_due/deferred state | empty folder misread as failure | Keep |
| next_due | cannot know when retry is expected | Keep |
| last_attempt/last_success | cannot distinguish no attempt from failed attempt | Keep |
| closed/weekend/inactive reason | weekend non-crypto false failure | Keep |
| no_snapshot/no_membership | Lite membership faking pressure | Keep |
| write pressure | budget exhaustion misread as writer failure | Keep |
| retained-last-good/no-change | continuity/no-change misread as fresh write | Keep |
| vague timing prose | does not improve RUN205 capture | Delete |
| future SIAM hydration planning | out of scope | Delete |

## SECTION 17 — CONTRADICTION LEDGER

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolving Action | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| Lite can say not_due | next_due/reason must be explicit for RUN205 | source status lines | RUN201 prompt + RUN205 proof need | 3 | 2 | source + prompt need | patched explicit reason/next_due/deferred_until | no after patch |
| Weekend non-crypto empty folders may be lawful | Lite must not pretend closed_market without source basis | RUN199 evidence | source ownership law | 2 | 3 | source ownership | patched cautious context, no hardcode | no |
| Logging needed | broad Dispatcher/FileIO rewrite forbidden | prompt/source scope | prompt | 2 | 2 | restriction wins | narrow diagnostics only | no |

## SECTION 18 — UPDATED RUN PLAN THROUGH RUN210

| Run | Purpose | Live? |
|---|---|---:|
| RUN199 | live final/staging/archive proof + Scanner Status token repair | yes, completed HOLD-with-patch |
| RUN200 | Scanner Status token parity source verification + main-vs-lite lifecycle logging + weekend inactive bucket state | no |
| RUN201 | Lite due/hydration timing alignment where source/RUN199 evidence prove mismatch | no |
| RUN202 | manifest/status/log failure taxonomy and first-failure reason alignment | no |
| RUN203 | full source verification + RUN205 live contract | no |
| RUN204 | tiny RUN205-blocking patch only | no |
| RUN205 | live proof #2 | yes |
| RUN206 | post-RUN205 blocker repair / lifecycle alignment | no |
| RUN207 | post-live logging/proof correction | no |
| RUN208 | second-cycle source verification | no |
| RUN209 | tiny RUN210-blocking patch only | no |
| RUN210 | live proof #3 | yes |

No SIAM data enrichment until after RUN210 unless explicitly reprioritized.

## SECTION 19 — DECISION TABLE

| Decision Option | Result | Reason |
|---|---|---|
| PASS-BY-SOURCE-PATCH | selected | safe diagnostic patch applied; protected areas preserved |
| PASS-AUDIT-ONLY | not selected | timing-proof gap required patch |
| HOLD-WITH-SOURCE-PATCH | not selected | no unresolved source blocker found; compile still unproven but expected by evidence ceiling |
| HOLD-WITHOUT-PATCH | not selected | source context sufficient |
| KILL | not selected | no forbidden rewrite required |

Final serious decision: TEST FIRST.

## SECTION 20 — PACKAGE VALIDATION TABLE

| Package Check | Result | Evidence |
|---|---|---|
| package exists | yes | `/mnt/data/TRUTH_SEEKER_RUN201R_CHANGED_FILES_WINDOWS_SAFE.zip` |
| package size > 0 | yes | validated after zip |
| entries > 0 | yes | validated after zip |
| root preserved | yes | `Aurora Sentinel Core/...` |
| report included | yes | `RUN201R_REPORT.md` |
| source files included if patched | yes | Dispatcher, ScannerStatusWriter, Version |
| control files included if patched | yes | roadmap + office files |
| guidebooks included if patched | no | no guidebook patch needed |
| office files included | yes | ROADMAP_STATUS, WORK_LOG, CHANGE_LEDGER, DECISIONS |
| forbidden files excluded | yes | FileIO/composer/writer/contracts/routing/HUD/Market Board/L3/L4 excluded |
| extraction test passed | yes | validated after zip |
| no empty zip | yes | validated after zip |
| no rootless zip | yes | root preserved |
| no whole-repo dump | yes | changed files only |

## SECTION 21 — RUN202 PROMPT SEED

```text
GIT HEADER

TRUTH SEEKER ROADMAP — RUN202R / MANIFEST + STATUS FAILURE TAXONOMY ALIGNMENT — FIRST-FAILURE REASONS, CLOSED-MARKET STATES, AND WRITE-STATE CONSISTENCY BEFORE RUN205

CODE EDIT RUN
MODE: AUDIT + PATCH
TRUTH FURNACE REQUIRED
MANDATORY OFFICIAL / EXTERNAL RESEARCH LEDGER REQUIRED
MANDATORY TWO-BRAIN CHECK REQUIRED
MANDATORY MAIN/LITE SINGLE-SOURCE SYNC CHECK REQUIRED
NO LIVE TEST THIS RUN
NO LIVE OUTPUT REQUEST THIS RUN
NEXT LIVE TEST IS RUN205R
PRESERVE RUN199 SCANNER STATUS TOKEN REPAIR
PRESERVE RUN200 LIFECYCLE LOGGING
PRESERVE RUN201 TIMING/DUE ALIGNMENT
ALIGN MANIFEST, SCANNER STATUS, AND FUNCTIONRESULTS FAILURE TAXONOMY
ENSURE FIRST_FAILURE_REASON IS SPECIFIC AND NOT STALE
ENSURE CLOSED/WEEKEND/INACTIVE STATES ARE NOT COUNTED AS WRITE FAILURES
PRESERVE FINAL CHILD PATHS
PRESERVE STAGING/ARCHIVE PATH SEPARATION
PRESERVE FILEIO
PRESERVE WRITER REQUIRED-TOKEN LIST
PRESERVE COMPOSER PAYLOAD
PRESERVE RANK/ORDER/FORMULA
PRESERVE MEMBERSHIP SOURCE
NO STRATEGY / EXECUTION / SIGNAL / TRADE / RISK PATCH
NO BUY / SELL / ENTRY / SL / TP / LOT OUTPUT
NO PRODUCTION-READY CLAIM
FINAL DECISION MUST BE PROCEED / HOLD / KILL / TEST FIRST
```
