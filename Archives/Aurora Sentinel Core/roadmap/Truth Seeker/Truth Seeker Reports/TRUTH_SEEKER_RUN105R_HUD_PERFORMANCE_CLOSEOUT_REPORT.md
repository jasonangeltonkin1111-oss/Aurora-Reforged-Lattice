# TRUTH SEEKER ROADMAP — RUN105R / HUD PERFORMANCE CLOSEOUT + LIVE-PROOF READINESS

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN105R / HUD PERFORMANCE CLOSEOUT + LIVE-PROOF READINESS — FINAL HUD WARPATH SOURCE HARDENING, COMPILE-RISK SCAN, HOT-PATH ZERO-FILE-READ PROOF, TELEMETRY LOCK, AND NEXT LIVE TEST SEED

## 2. OPERATOR SNAPSHOT

| Field | Result |
|---|---|
| User-reported latency | About 4 minutes for major bucket → minor bucket → symbol page navigation |
| Source patched | yes |
| HUD warpath run | 5 of 5 |
| Zero-file-read navigation source status | ready by source inspection: ordinary render-facing Current Focus accessor is cache-only |
| Click ack / render decoupling status | preserved from RUN102R: ack helper + pending navigation + priority service still present |
| Object/redraw optimization status | preserved from RUN103R: object cache, skip counters, miss-only find, redraw request/flush counters remain |
| Cache/view-model status | preserved from RUN104R: display-only navigation VM + stale/missing cache posture + deferred refresh remain |
| Compile-risk status | patched: oversized HUD proof-summary StringFormat blocks split into typed concatenated segments |
| Biggest remaining HUD risk | live terminal proof is still pending; source inspection is not latency proof |
| Next live proof target | RUN106R / HUD live latency proof + recent RUN100 redo evidence package parity |
| Protected areas not touched | FileIO, GlobalTop10 rank/order/formula, L3 score formula, L4 rank/order, Market Board order, Current Focus/Dossier/Market Board truth ownership, strategy/execution |
| Expected performance effect | proof logging is less compile-fragile; ordinary nav remains cache/view-model driven and measurable without file reads |

## 3. INPUT ZIP / FILE INTAKE SUMMARY

| Input | Inspection |
|---|---|
| `Aurora Sentinel Core(352).zip` | Extracted under one root: `Aurora Sentinel Core/...` |
| Total files | 605 files found under the source root |
| Nested roots | No competing active source root found; active root selected as `Aurora Sentinel Core/...` |
| Required reports | RUN101R, RUN102R, RUN103R, RUN104R present and inspected |
| Required HUD files | `mt5/hud/ASC_HUD_Manager.mqh`, `ASC_HUD_ObjectCacheIndex.mqh`, `ASC_HUD_ReadModelRenderInput.mqh` present |
| Live output files | No new live output/MetaEditor transcript used or claimed |

## 4. RUN104R ABSORPTION

| RUN104 Item | Verified In Source? | Remaining Gap | RUN105 Action |
|---|---:|---|---|
| navigation-safe Current Focus cache accessor | yes | none | preserved |
| file-reading accessor split | yes | background/manual only | preserved |
| cache state/posture fields | yes | none | preserved |
| view-model fields | yes | none | preserved |
| view-model builder | yes | none | preserved |
| zero-file-read navigation counters | yes | live proof pending | included in proof summary |
| cache hit/miss telemetry | yes | live proof pending | included in proof summary |
| stale/placeholder display counters | yes | live proof pending | included in proof summary |
| deferred cache warm | yes | bounded after priority render | preserved |
| object/redraw improvements preserved | yes | none | preserved |
| event/render decoupling preserved | yes | none | preserved |
| compile/live proof still missing | yes | MetaEditor/live not provided | not claimed |
| large proof-summary StringFormat risk | yes | compile fragility | patched |

## 5. ROADMAP AUTHORITY CHECK

Operator latency remains the top authority. RUN105R only touched HUD proof-summary formatting, version identity, active log, manifest, and this report. It did not change strategy, rank/order/formula, FileIO, artifact writers, or execution.

## 6. INTERNET RESEARCH CONVERSION TABLE

| Research Area | Source | Finding | HUD Closeout Constraint | Patch / Audit Impact |
|---|---|---|---|---|
| Chart object queue | Official MQL5 Object Functions | ObjectCreate/ObjectSet/ObjectMove style calls enqueue commands; visual updates happen later through the chart event queue | do not assume immediate visual completion after object updates | preserve deferred render + batched redraw |
| ObjectsDeleteAll | Official MQL5 ObjectsDeleteAll | ObjectsDeleteAll is synchronous and waits for prior chart commands, so it can be time-consuming with many objects | no broad delete-all in hot navigation | verified no new broad delete-all path |
| ObjectFind/readbacks | Official MQL5 ObjectFind | ObjectFind is synchronous and can wait behind chart queue | miss-only ObjectFind and object cache must remain | verified RUN103 object cache path survived |
| ChartRedraw | Official MQL5 ChartRedraw | ChartRedraw forces redraw after object property changes | batch redraw after grouped mutations | verified request/flush counters remain |
| ChartSet* queue | Official MQL5 Chart Operations / ChartSetString | chart property set calls are asynchronous; synchronous get/readback waits for queue | avoid readbacks in click hot path | preserved no ordinary nav object readback expansion |
| File sandbox/read work | Official MQL5 File Functions | file work is sandboxed and is explicit file I/O | ordinary navigation must not read artifact files | verified `ASC_HudReadCurrentFocusCached()` remains cache-only |
| Timer service | Official MQL5 event/timer docs reviewed by previous HUD runs | timer events can be starved if already queued/processing | priority service must not rely on stacked timer backlog | preserved priority render service counters/skip reason |
| StringFormat / PrintFormat | Official MQL5 StringFormat/PrintFormat | format specifiers must match parameters; PrintFormat has a 64-parameter ceiling | split oversized HUD proof summaries before compile failure | patched HF/LF proof summaries + event log summaries |

## 7. PROMPT EVOLUTION / HUD LIVE PROOF PROMPT UPGRADE

| RUN101–RUN105 Prompt Weakness | Evidence | New Rule For Next Live Prompt | Expected Improvement |
|---|---|---|---|
| source inspection is not live latency proof | RUN101–RUN105 were source/control runs | next live prompt must collect actual HUD telemetry logs | prevents false performance pass |
| next live prompt must collect actual HUD telemetry | proof counters now exist | require `runtime.hf`/`runtime.lf` HUD proof lines | measurable click/render/object/file-read evidence |
| live package must include logs containing HUD proof summaries | no live proof package in RUN105 | require `Workbench/logs/function_results.log` and heartbeat/HUD logs | avoids missing-file mistakes |
| next live audit must inspect click-to-ack/deferred render/object churn/redraw/file counters/cache | telemetry now exposed in summaries | make these metrics mandatory pass/fail fields | converts screenshots into measurable proof |
| next live audit must not repeat missed-file mistakes | RUN100 redo exposed package mismatch | recursively list uploaded package roots before conclusions | prevents false absence claims |
| next live audit must patch source if live metrics still fail | source readiness does not guarantee terminal speed | allow targeted HUD source patch if metrics show stall | keeps warpath practical |
| next live audit must protect truth owners | HUD cache is display-only | forbid FileIO/writer/rank/strategy drift | preserves scanner truth law |

## 8. FULL HUD HOT-PATH AUDIT

| Hot Path Step | File Read? | Large Parse? | Object Churn? | Redraw? | Telemetry? | Patch Needed |
|---|---:|---:|---:|---:|---:|---|
| click event | no | no | no | no | yes | no |
| click ack | no | no | minimal transition label only | request only | yes | no |
| navigation intent queue | no | no | no | no | yes | no |
| deferred priority service | background only after render | no nav parse | bounded | batched | yes | no |
| render call | no ordinary artifact read | no ordinary artifact parse | counted | batched | yes | no |
| view-model build | no | no | no | no | yes | no |
| Current Focus cache access | no via render accessor | no | no | no | yes | no |
| symbol page render | no ordinary file read | no large artifact parse | counted/skipped | batched | yes | no |
| object update | no | no | reduced by cache/skips | request only | yes | no |
| redraw request/flush | no | no | no | one flush path | yes | no |
| cache warm after render | yes, background/manual accessor | parses Current Focus only outside ordinary nav | no | no | yes | no |
| telemetry proof summary | no | no | no | no | yes | patched |

## 9. ZERO-FILE-READ NAVIGATION VERIFICATION

| Navigation Path | File Read Possible? | Source Evidence | Patch Needed |
|---|---:|---|---|
| ordinary bucket navigation | no | ordinary nav uses ack/deferred render and cache/view-model path | no |
| ordinary sub-bucket navigation | no | render-facing Current Focus accessor remains `ASC_HudReadCurrentFocusCached()` | no |
| ordinary symbol list navigation | no | cache-only accessor has no `ASC_ReadTextFile` | no |
| ordinary symbol detail entry | no | symbol detail calls cache accessor; file accessor separated | no |
| ordinary symbol next/prev | no | same page/symbol nav path and cache accessor | no |
| ordinary symbol tab switching | no | same symbol context preserves cached runtime pointer and cache-only Current Focus read | no |
| `ASC_HudReadCurrentFocusCached(...)` | no | comment and body delegate only to `ASC_HudCurrentFocusNavigationSafe()` | no |
| file-reading accessor | yes, explicit | only `ASC_HudReadCurrentFocusFileCached(...)` calls `ASC_ReadTextFile()` | no |
| background cache warm | yes after render | `ASC_HudServicePriorityNavigation()` warms after `ASC_HudRender()` | no |

## 10. VIEW-MODEL / CACHE CORRECTNESS AUDIT

| View-Model / Cache Rule | Source Evidence | Status | Patch Needed |
|---|---|---|---|
| view-model is display-only | VM fields labeled display/cache; no writer calls | pass | no |
| stale cache is labeled | `current_focus_cache_state/posture` set stale | pass | no |
| missing cache shows placeholder/deferred posture | missing state + deferred refresh counters | pass | no |
| manual refresh remains explicit | `ASC_HudReadCurrentFocusText()` routes manual accessor | pass | no |
| background refresh does not block ordinary nav | service warms after priority render | pass | no |
| view-model does not alter ranking/order/formulas | no L3/L4/Top10 formula owners touched | pass | no |
| view-model does not compute signals/strategy | HUD contains no execution/strategy patch | pass | no |
| view-model does not overwrite truth artifacts | no writer/FileIO changes | pass | no |

## 11. OBJECT / REDRAW PRESERVATION AUDIT

| Object / Redraw Rule | Source Evidence | Status | Patch Needed |
|---|---|---|---|
| cache-first object shell detection | object cache index and object hit/miss counters remain | pass | no |
| miss-only `ObjectFind()` | ObjectFind counted in helper path | pass | no |
| cached object type use | object type cache remains | pass | no |
| unchanged text/style/visibility skip counters | skip counters remain | pass | no |
| redraw request/flush counters | request/flush/suppression counters remain | pass | no |
| redraw suppressed/no-mutation counter | present | pass | no |
| no new broad delete-all path | no new ObjectsDeleteAll path added | pass | no |
| no redraw inside hot loops | redraw is requested/flushed through central path | pass | no |
| deferred render batches redraw | priority render preserves request/flush model | pass | no |

## 12. EVENT / RENDER DECOUPLING PRESERVATION AUDIT

| Event / Render Rule | Source Evidence | Status | Patch Needed |
|---|---|---|---|
| ordinary navigation click does not call full render directly | click path queues ack/dirty state | pass | no |
| ack helper exists | `ASC_HudAckNavigationClick(...)` | pass | no |
| pending navigation intent exists | pending navigation fields and queue helper | pass | no |
| deferred render service exists | `ASC_HudServicePriorityNavigation(...)` | pass | no |
| priority service before heartbeat exists | priority service helper retained | pass | no |
| heavy/manual actions separated | explicit manual/background Current Focus accessor | pass | no |
| transition telemetry exists | click/handler/deferred/render/transition counters | pass | no |

## 13. HUD TELEMETRY CLOSEOUT

| Telemetry Metric | Source Present? | Live Proof Location | Patch Needed |
|---|---:|---|---|
| click_ack_ms | yes | HUD event/HF proof line | no |
| click_handler_total_ms | yes | HUD event/HF proof line | no |
| deferred_render_wait_ms | yes | HUD event/HF proof line | no |
| deferred_render_ms | yes | HUD event/HF proof line | no |
| chart_redraw_ms | yes | HF proof line | no |
| transition_total_ms | yes | HF proof line | no |
| objects_created/updated/deleted | yes | HF/LF proof line | no |
| object_cache_hit/miss | yes | LF proof line | no |
| text/style/visibility skips | yes | LF proof line | no |
| ObjectFind/ObjectGet counts | yes | LF proof line | no |
| ObjectsDeleteAll count | yes | LF proof line | no |
| redraw request/flush/suppressed | yes | LF proof line | no |
| nav file read count | yes | HF/LF proof line | no |
| nav Current Focus/Dossier/Market Board read count | yes | HF/LF proof line | no |
| nav large parse count | yes | HF/LF proof line | no |
| cache hit/miss/deferred | yes | HF/LF proof line | no |
| background/manual cache read | yes | HF/LF proof line | no |
| view-model build ms | yes | HF/LF proof line | no |
| cache stale/placeholder count | yes | HF/LF proof line | no |
| priority service count/skip reason | yes | HF proof line | patched into split summary |

## 14. HUD PROOF SUMMARY FORMAT / COMPILE-RISK AUDIT

| Proof Summary Formatter | Risk | Patch Needed | Patch |
|---|---|---:|---|
| `ASC_HudBuildHighFrequencyProofSummary(...)` | oversized variadic StringFormat, wrong parameter count risk, future 64-param style fragility | yes | replaced with typed concatenated segments using `IntegerToString`, `DoubleToString`, helper bool/uint text |
| `ASC_HudBuildLowFrequencyProofSummary(...)` | multiple growing StringFormat blocks with many fields | yes | replaced with typed concatenated segments |
| `ASC_HudOnChartEvent` terminal log | large proof-event StringFormat | yes | replaced with concatenated typed log line |
| Other non-proof StringFormat uses | not RUN105 target unless compile evidence exists | no | left untouched |

## 15. PATCH CANDIDATE MATRIX

| Candidate | Evidence | Decision |
|---|---|---|
| split proof-summary StringFormat | RUN104 caveat + source risk | patched |
| add missing proof counter | required counters present | no patch |
| harden zero-file-read guard | cache-only accessor already present | no patch |
| add live-proof summary line | proof line already exists; patched formatting includes fields | patched by rewrite |
| cache stale/deferred label | present | no patch |
| priority-service skip reason | present; added to HF summary | patched |
| background cache warm bounds | after priority render | no patch |
| accessor naming | already split manual/background/cache | no patch |

## 16. PATCH TABLE

| File | Patch | Reason | Expected Impact |
|---|---|---|---|
| `mt5/hud/ASC_HUD_Manager.mqh` | split HF/LF HUD proof summary formatters and event log proof line into typed concatenated segments | reduce compile fragility and preserve telemetry | safer MetaEditor compile path; clearer live proof lines |
| `mt5/core/ASC_Version.mqh` | bumped active run/version identity to RUN105R | source changed | currentness proof |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | added RUN105R entry | control update | roadmap continuity |
| `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | added RUN105R manifest | package continuity | output traceability |
| `roadmap/Truth Seeker/TRUTH_SEEKER_RUN105R_HUD_PERFORMANCE_CLOSEOUT_REPORT.md` | created closeout report | required output | audit evidence |

## 17. SOURCE FILES TOUCHED

- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_RUN105R_HUD_PERFORMANCE_CLOSEOUT_REPORT.md`

## 18. PROTECTED AREAS NOT TOUCHED

FileIO, GlobalTop10 rank/order/formula, L3 score formula, L4 rank/order, Market Board order, Dossier writer, Current Focus writer, Market Board writer, strategy/semi-auto/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP.

## 19. HUD LIVE PROOF PACKAGE CONTRACT

| Live Proof Item | Required? | Expected Path / Evidence | Why |
|---|---:|---|---|
| function results log | yes | `Workbench/logs/function_results.log` | HUD proof lines / FunctionResults evidence |
| heartbeat telemetry | yes | `Workbench/logs/heartbeat_telemetry.log` | heartbeat pressure/stall check |
| HUD proof lines/logs | yes | Workbench logs / terminal log | click/render/object/cache proof |
| Scanner Status | yes | Scanner Status artifact | system status + run identity |
| Market Board | yes | Market Board artifact | selection board parity |
| Dossier | yes | root and symbol dossier files | truth artifact parity |
| Artifact Bundle Manifest | yes | bundle manifest | publication integrity |
| Open Symbol Snapshot | yes | snapshot artifact/folder | L2 currentness evidence |
| GlobalTop10 folder | yes | GlobalTop10 current/archive/_staging | no closed-market actionable regression |
| screenshots/video timing | optional but useful | operator-provided | human-visible latency confirmation |
| manual notes | optional | operator notes | observed click timing context |

Required checks: bucket click-to-ack, sub-bucket click-to-ack, symbol entry click-to-ack, symbol-to-symbol nav click-to-ack, deferred render time, object churn, redraw count, zero nav file reads, cache hit/miss/deferred, background/manual cache reads, heartbeat pressure, no UI stall above 2 seconds, no 4-minute transition, no closed-market actionable Top10 regression if relevant.

## 20. HUD ACCEPTANCE DECISION

| HUD Acceptance Criterion | Source Status | Evidence | If Open |
|---|---|---|---|
| ordinary navigation source path has zero file reads | pass | cache-only render accessor | live verify counters zero |
| click ack separated from render | pass | ack + deferred service | live verify ack ms |
| render deferred/service-driven | pass | priority service | live verify deferred render ms |
| object churn reduced/counted | pass | cache/skip counters | live verify counts |
| redraws batched/counted | pass | request/flush/suppressed counters | live verify counts |
| cache miss stale/deferred/placeholder | pass | cache state/posture | live verify no block |
| telemetry can prove above | pass | HF/LF summaries | live collect logs |
| no giant compile-risk proof formatting | pass | patched proof/event summaries | MetaEditor compile still needed |
| protected areas preserved | pass | file touch list | continue guard |

Decision: PASS — HUD source is ready for live proof, with compile/live proof still explicitly unclaimed.

## 21. NEXT ROADMAP PLAN AFTER HUD WARPATH

| Next Run | Phase | Type | Target | Live? |
|---|---|---|---|---:|
| RUN106R | HUD live proof | live/output audit + patch-if-fail | prove click-to-ack/deferred render/object/cache/file-read counters; inspect RUN100 redo debts | yes |
| RUN107R | HUD correction if needed | source patch only if live metrics fail | fix measured stall source | no unless RUN106 fails hard |
| RUN108R | main roadmap resume | Phase 4 claim evidence / unavailable cleanup / contradiction work | resume truth roadmap after HUD proof | no |

## 22. STATIC COMPILE-SAFETY TABLE

| Static Compile Check | Result | Action |
|---|---|---|
| identifiers under 63 chars | no new long identifiers beyond existing style | pass |
| no giant proof `StringFormat` | patched | pass |
| no wrong parameter count in proof summaries | patched to typed concatenation | pass |
| no raw implicit number-to-string in patched summaries | used `IntegerToString`, `DoubleToString`, `ASC_HudUintText` | pass |
| no block-scoped variable used outside | no such new use | pass |
| no missing helper declarations needed before use | helpers defined before event use; existing prototypes retained | pass |
| include-order break | no includes touched | pass |
| file accessor signature mismatch | no signature change | pass |
| cache state helper mismatch | no helper signature change | pass |
| recursive cache warm/render/service loop | no new loop | pass |
| unbounded pending refresh state | no new state | pass |
| duplicate function names | no duplicates found | pass |
| strategy/execution includes touched | no | pass |

## 23. REGRESSION GUARD

| Guard | Status |
|---|---|
| no strategy/execution | pass |
| no BUY/SELL / OrderSend / CTrade | pass |
| no lot sizing | pass |
| no SL/TP | pass |
| no GlobalTop10 rank/order/formula change | pass |
| no L3 score formula change | pass |
| no L4 rank formula/order change | pass |
| no Market Board order change | pass |
| no FileIO rewrite | pass |
| no HUD truth ownership | pass |
| HUD remains read-only consumer | pass |
| no hidden truth compute inside HUD | pass |
| no broad Dossier rewrite | pass |
| no broad L5/L6 all-symbol hydration | pass |
| no Current Focus writer ownership drift | pass |
| no Market Board writer ownership drift | pass |

## 24. TRUE ROADMAP PROGRESS UPDATE

HUD warpath source readiness is now closed by inspection: RUN101 added audit/first patch, RUN102 decoupled event/render, RUN103 reduced object/redraw churn, RUN104 removed ordinary Current Focus file reads through cache/view-model, and RUN105 hardened proof logging/compile-risk. Remaining debt is live proof, not source readiness.

## 25. NEXT_PROMPT_SEED

GIT HEADER

TRUTH SEEKER ROADMAP — RUN106R / HUD LIVE LATENCY PROOF + PACKAGE PARITY AUDIT — CLICK-TO-ACK, DEFERRED RENDER, OBJECT CHURN, REDRAW BATCHING, ZERO NAV FILE READS, CACHE HIT/MISS, AND RUN100 REDO EVIDENCE CHECK
LIVE OUTPUT REQUIRED
NO STRATEGY WORK
NO RANKING FORMULA WORK
NO EXECUTION WORK
NO REPORT-ONLY SUCCESS

First files to read:
1. `roadmap/Truth Seeker/TRUTH_SEEKER_RUN105R_HUD_PERFORMANCE_CLOSEOUT_REPORT.md`
2. `mt5/hud/ASC_HUD_Manager.mqh`
3. `mt5/core/ASC_Version.mqh`
4. `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
5. uploaded live package roots recursively

Evidence needed:
- `Workbench/logs/function_results.log`
- `Workbench/logs/heartbeat_telemetry.log`
- HUD proof lines from terminal/workbench logs
- Scanner Status, Market Board, Dossier, Artifact Bundle Manifest, Open Symbol Snapshot, GlobalTop10 folder
- optional screenshot/video timing notes

Pass thresholds:
- nav file reads = 0 during ordinary bucket/sub/symbol/tab/next-prev navigation
- click ack should be immediate and under 250 ms target where logged
- no transition above 2 seconds without explicit heavy/manual action reason
- no 4-minute transition
- object churn/redraw counts bounded and explained
- cache miss shows stale/deferred/placeholder, not blocking

Patch triggers:
- any ordinary nav file read > 0
- click handler/ack/deferred render stalls
- ObjectFind/ObjectGet/ObjectsDeleteAll spikes on ordinary nav
- redraw flush storm
- cache warm blocks priority render
- missing HUD proof counters

Forbidden drift:
FileIO rewrite, rank/order/formula, Market Board order, L3/L4 strategy logic, Current Focus/Dossier/Market Board truth ownership, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP.

## 26. FINAL DECISION

PASS — RUN105R patches the remaining HUD proof-summary compile-risk, verifies the source hot path remains zero-file-read for ordinary navigation, preserves RUN102–RUN104 HUD performance boundaries, and seeds RUN106R live proof. Compile/live proof is not claimed.
