# TRUTH SEEKER RUN101R — HUD PERFORMANCE EXTREME AUDIT + FIRST SOURCE PATCH

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN101R / HUD PERFORMANCE EXTREME AUDIT + FIRST SOURCE PATCH — 4-MINUTE NAVIGATION FAILURE, CHART OBJECT QUEUE PRESSURE, REDRAW CHURN, HUD EVENT LATENCY, AND BACKGROUND WORK INTERFERENCE

RUN TYPE: HUD PERFORMANCE EXTREME AUDIT / SOURCE PATCH / CONTROL UPDATE / NO-LIVE PERFORMANCE REPAIR  
NEXT HUD RUN: RUN102R / EVENT-RENDER DECOUPLING + CLICK ACKNOWLEDGMENT  
PROOF BOUNDARY: `hud_performance_source_patched_live_unproven`  
COMPILE CLAIM: not claimed  
LIVE CLAIM: not claimed  
OUTPUT CLAIM: claimed only from inspected source/control/report package

## 2. OPERATOR SNAPSHOT

| Field | RUN101R Verdict |
|---|---|
| User-reported latency | About 4 minutes from major bucket → minor bucket → symbol page. |
| Source patched | Yes. |
| Biggest suspected latency cause | HUD navigation shares one chart/event/runtime queue with object mutations, redraw flushing, selected-symbol artifact sync, and heartbeat scan/write side duty. |
| Biggest confirmed source bottleneck | `ASC_HudOnChartEvent(...)` can perform navigation mutation, selected-symbol sync queueing, immediate render, and redraw flush in the click path; `OnTimer()` previously ran `ASC_RunHeartbeat(...)` before HUD service. |
| First patch made | Added HUD latency telemetry, click-to-ack measurement, render/redraw/object counters, Current Focus file-read counters, and a priority HUD navigation service before timer heartbeat work. |
| Next HUD target | RUN102R: hard event/render decoupling + visible click acknowledgment before heavyweight render/state sync. |
| Protected areas not touched | FileIO, rank/order/formula owners, Market Board order, L3/L4/L5 scoring, strategy/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP. |
| Expected performance effect | Source now gives immediate proof of click ack/build/redraw/object churn and lets pending navigation render before timer heartbeat work during UI-priority window. |
| Remaining risk | Full render still uses many ObjectSet calls and selected-symbol page entry can still queue Current Focus sync; live timing proof is required. |

## 3. INPUT ZIP / FILE INTAKE SUMMARY

| Input | Verified Result |
|---|---|
| `/mnt/data/Aurora Sentinel Core(348).zip` | Extracted successfully. |
| Root layout | One active root found: `Aurora Sentinel Core/`. |
| Nested roots | No competing current source root found at same authority level. |
| Roadmap authority | `roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md` present. |
| Latest RUN100 report | `TRUTH_SEEKER_RUN100R_REDO_LIVE_REAUDIT_CODE_REPAIR_REPORT.md` present. |
| HUD source | `mt5/hud/ASC_HUD_Manager.mqh` present, ~14.9k lines. |
| Runtime owners | `mt5/AuroraSentinelCore.mq5`, `mt5/runtime/ASC_Dispatcher.mqh`, `mt5/runtime/ASC_Bootstrap.mqh`, `mt5/core/ASC_RuntimeState.mqh`, `mt5/core/ASC_Types.mqh`, `mt5/core/ASC_Constants.mqh` present. |
| Artifact/read-model owners | Market Board, Current Focus, Dossier, ArtifactTextHelpers present. |
| Live output evidence in this zip | No separate Upcomers runtime-output zip in this upload; RUN100R-REDO report exists as source-control evidence only. |

## 4. ROADMAP AUTHORITY CHECK

| Authority Item | Status | Impact |
|---|---|---|
| Operator problem statement | Absorbed as top authority. | 4-minute HUD navigation is treated as trading-critical, not polish. |
| Latest source package | Inspected directly. | Patch is based on actual current source, not filename assumptions. |
| `TRUTH_SEEKER_ROADMAP.md` | Present. | RUN101R remains under Truth Seeker roadmap controls. |
| RUN100R-REDO report | Present. | Prior phase boundary preserved; no live/compile claim made. |
| Active roadmap log | Updated. | RUN101R source patch recorded. |
| Output package manifest | Updated. | Changed-files package listed. |

## 5. INTERNET RESEARCH CONVERSION TABLE

| Research Area | Source | Finding | HUD Performance Constraint | Patch / Audit Impact |
|---|---|---|---|---|
| Object creation queue | Official MQL5 `ObjectCreate` docs | `ObjectCreate()` is asynchronous and returns when the command is queued; property-checking functions such as `ObjectFind()` / `ObjectGetXXX` wait for queue results and can be time-consuming with many objects. | Avoid create/delete/readback churn during HUD navigation. Prefer stable object names, object cache signatures, and no property read loops. | Confirmed existing cache is directionally correct; RUN102/RUN103 must remove remaining `ObjectFind` dependency pressure from hot render path. |
| Object property queue | Official MQL5 `ObjectSetInteger`, `ObjectSetString`, `ObjectSetDouble` docs | Object property setters enqueue commands and return before execution; property reads wait behind chart queue and can be costly with many objects. | Batch property writes, avoid repeated style writes, avoid ObjectGet/ObjectFind verification loops in click path. | RUN101R added object update counters so live output can prove mutation counts per transition. |
| Redraw batching | Official MQL5 `ChartRedraw` docs | `ChartRedraw()` forces chart redraw after object property changes. | Redraw must be batched to one flush per committed transition, not spammed inside loops. | RUN101R measures redraw duration and keeps redraw routed through `ASC_HudRequestRedraw()` / `ASC_HudFlushPendingRedraw()`. |
| Chart command queue | Official MQL5 `ChartSetInteger` docs | `ChartSetInteger()` is asynchronous and returns after command is added to chart queue; `ChartRedraw()` can force queued commands to execute. | Do not use chart property toggles as synchronous state guarantees during navigation. | RUN101R report locks future HUD prompts to chart queue awareness. |
| Event handling | Official MQL5 chart event docs | `OnChartEvent()` receives click/object events, but object/chart paint is queue-mediated. | Click receipt is not the same as visible page completion; telemetry must split click ack from render completion. | RUN101R added `ack_ms`, build, redraw, total transition metrics. |
| Timer queue | Official MQL5 `OnTimer` / runtime docs | Timer events are not added if a timer event is already queued or processing. | Long timer heartbeat work can delay HUD service and hide skipped timer pressure. | RUN101R patches `OnTimer()` to service pending UI-priority navigation before `ASC_RunHeartbeat(...)`. |

## 6. PROMPT EVOLUTION / HUD PERFORMANCE PROMPT UPGRADE

| Prior Prompt Weakness | Evidence | New Rule For RUN102–RUN105 | Expected Improvement |
|---|---|---|---|
| HUD work treated as polish | 4-minute navigation makes opportunity collection impossible. | HUD latency is trading-critical. | Performance acceptance becomes first-class proof. |
| Patch requirement too vague | Previous HUD passes could improve visuals while leaving click path coupled. | Every HUD run must include source patch if a patchable latency gap exists. | No report-only or style-only pass. |
| No latency taxonomy | Click handling, render, file read, object churn, redraw, and heartbeat interference were not separated. | Every HUD run must distinguish click latency, render latency, file-read latency, object churn, redraw churn, and background heartbeat interference. | Proof can identify the actual bottleneck. |
| No acceptance targets | “Snappy” was not measurable. | Every HUD run must include performance acceptance criteria. | RUN105 closeout can pass/fail objectively. |
| Truth boundary could drift | HUD temptation is to compute or rebuild truth during render. | HUD remains read-only consumer; formulas/ranks/order protected. | Speed work cannot corrupt scanner truth. |

## 7. HUD LATENCY OWNER MAP

| HUD Latency Area | Source Owner | Current Behavior | Suspected Cost | Patch Candidate |
|---|---|---|---|---|
| Click handling | `ASC_HudOnChartEvent` | Handles control routing, navigation mutation, sync queueing, render decision, redraw flush, logging. | Severe if render/object queue or artifact sync is slow. | Split click acknowledgment from render. |
| Bucket page transition | `ASC_HudHandleRowClick`, `ASC_HudOpenPage`, `ASC_HudRenderRows` | Mutates scope then may render immediate list. | Moderate/severe with object churn. | Cache visible slot maps and reuse row objects. |
| Sub-bucket transition | `ASC_HudOpenPage`, browse node helpers | Stock browse tree and subgroup mapping recalculated as needed. | Moderate. | Prebuilt browse view-model. |
| Symbol list transition | `ASC_HudRebuildSelectedSymbolList`, visible slot maps | Scope list rebuild can happen around navigation. | Severe if list rebuild touches large universe. | Cache per-scope prepared list. |
| Symbol detail page entry | `ASC_HudRenderSymbolDetailPage`, `ASC_HudQueueViewedCurrentFocusSync` | Symbol page can queue Current Focus sync and render multiple cards. | Trading blocker if artifact sync couples to click. | RUN102 decouple selected-symbol sync from click. |
| Next/prev symbol navigation | pager + selected symbol mutation | Page changes can invalidate selected symbol cache and trigger render. | Severe when render waits behind heartbeat. | RUN101 priority navigation service. |
| Page rebuild | `ASC_HudRender` | Full render function always traverses layout zones and page branch. | Moderate/severe. | Dirty-region render budget. |
| Object create/update/delete | `ASC_HudEnsureRect/Label/Button`, hide/delete helpers | Stable cache exists, but `ObjectFind` still used before create. | Severe with many objects and queued readbacks. | Replace ObjectFind with cache-first existence discipline in RUN103. |
| ChartRedraw calls | `ASC_HudRequestRedraw`, `ASC_HudFlushPendingRedraw` | One explicit wrapper call site for redraw. | Moderate if called too often per transition. | RUN101 telemetry proves redraw count/duration. |
| ObjectsDeleteAll calls | HUD source | None found in HUD file. | Low in current HUD. | Keep forbidden in hot navigation path. |
| ObjectFind/ObjectGet calls | HUD source | 7 ObjectFind, 1 ObjectGet occurrence in HUD source. | Severe if executed repeatedly against many objects. | RUN103 object-pool/cache-first patch. |
| File reads during HUD navigation | `ASC_HudReadCurrentFocusCached` | Current Focus cache reads file if cache is stale/modified. | Severe if symbol page click forces read. | RUN101 file-read counters; RUN104 no file read in click handler. |
| Dossier/Market Board/Current Focus reads | HUD + Dispatcher | HUD direct read found for Current Focus cache; dispatcher also reconciles artifacts. | Severe if selected-symbol navigation triggers readback. | RUN102/RUN104 isolate artifact sync. |
| Background heartbeat | `OnTimer`, `ASC_RunHeartbeat`, `ASC_HudOnHeartbeat` | Timer ran runtime heartbeat before HUD heartbeat. | Severe when heartbeat scan/write side duty is long. | RUN101 services pending UI-priority HUD navigation before heartbeat. |
| FunctionResults telemetry logging | `OnTimer`, logging owner | Logs after heartbeat. | Moderate; file logging can add timer pressure. | Keep observed, do not rewrite logging this run. |
| OnTimer vs OnChartEvent coupling | `AuroraSentinelCore.mq5` | Chart click marks UI priority; timer still ran heartbeat first. | Severe. | RUN101 patched priority HUD service before heartbeat. |
| HUD retained state/cache | HUD state/object cache | Object signature cache exists; page cache incomplete. | Moderate. | RUN104 view-model cache. |
| Small-screen pagination | HUD layout/render rows | Dynamic row calculation and bottom pager exists. | Moderate if every page recalculates layout. | RUN103/RUN104 cache layout/view rows. |
| Top 3/top5/top10 display | HUD shortlist rows/cache | Rank surfaces consume shortlist cache. | Moderate; do not change order/formula. | Cache display rows only, not formulas. |

## 8. HUD SOURCE AUDIT

| HUD Source Finding | Evidence | Severity | Patch Needed |
|---|---|---|---|
| Click handler performs too much | `ASC_HudOnChartEvent` branches over controls, syncs selected symbol/current focus, may render immediately, flushes redraw, logs event. | trading_blocker | RUN102 must split event ack from render and artifact sync. |
| Full page render is monolithic | `ASC_HudRender` renders shell/header/nav/breadcrumb/body/footer in one function. | severe_latency | RUN103/RUN104 dirty-region and view-model patch. |
| Existing dirty flags present but not enough | `dirty_navigation`, `dirty_data_light`, `dirty_data_heavy` exist. | moderate | RUN101 added priority service and telemetry. |
| ChartRedraw wrapper exists | One explicit `ChartRedraw(0)` inside `ASC_HudFlushPendingRedraw`. | moderate | Keep wrapper; add duration metric. |
| Broad `ObjectsDeleteAll` not found | HUD grep found 0. | cosmetic | Guard remains: do not add broad delete. |
| ObjectFind remains hot-path risk | HUD grep found 7 `ObjectFind` occurrences, mostly ensure/hud-existence helpers. | severe_latency | RUN103 replace with cache-first / no synchronous object readback where safe. |
| ObjectGet remains risk | HUD grep found 1 `ObjectGetInteger`. | moderate | Audit object type read in RUN103. |
| Current Focus file read exists | `ASC_HudReadCurrentFocusCached` calls `ASC_ReadTextFile`. | severe_latency | RUN101 counts file reads; RUN104 removes reads from click path. |
| No complete HUD transition telemetry before patch | Existing counters lacked click ack/build/redraw/file-read split. | severe_latency | RUN101 patched telemetry. |

## 9. RUNTIME INTERFERENCE AUDIT

| Runtime Interference | Evidence | HUD Impact | Patch Candidate |
|---|---|---|---|
| Timer heartbeat before HUD | `OnTimer()` called `ASC_RunHeartbeat(...)` before `ASC_HudOnHeartbeat(...)`. | HUD render can wait behind scan/write lane and side-duty. | RUN101 patched UI-priority navigation service before heartbeat. |
| UI priority existed but was budget-only | `ui_priority_until_utc` set on chart event; dispatcher scales budgets. | Budget scaling helps, but does not render HUD first. | RUN101 uses UI priority to service navigation first. |
| Dossier/current focus reconciliation in heartbeat | Dispatcher has selected-symbol Current Focus reconciliation paths. | Can consume timer time before HUD if ordered first. | RUN102/RUN104 decouple artifact sync from navigation. |
| Logging after heartbeat | FunctionResults log written after heartbeat. | Could add pressure but after main work. | Leave protected unless telemetry proves bottleneck. |
| Heavy L5 manual actions | Explicit action branches queue deep/full refresh. | Must not run inside ordinary navigation. | Guard future runs from action-trigger drift. |

## 10. CHART OBJECT / REDRAW AUDIT

| Object / Redraw Pattern | Evidence | Cost Risk | Patch Candidate |
|---|---|---|---|
| HUD objects created per page | Existing counters `proof_cycle_object_creates`; RUN101 adds last-transition object metrics. | Severe if page family changes create many objects. | RUN103 object pool. |
| HUD objects deleted per page | Existing delete counters; no `ObjectsDeleteAll`. | Moderate. | Prefer hide/reuse over delete. |
| ChartRedraw per click/page | Wrapper exists; RUN101 adds `redraw_ms` and last render redraw count. | Severe if repeated. | Keep max one committed flush. |
| Object names stable/reused | `ASC_HUD_PREFIX` names and object cache signatures exist. | Good foundation. | Cache-first existence check. |
| Style properties reapplied | Signature cache prevents unchanged writes; still ObjectFind first. | Moderate. | Remove ObjectFind where cache is authoritative. |
| Text-only changes | `ASC_HudSetLabelTextIfExists` exists. | Good. | Expand use for click-ack and fast pages. |
| Object create/delete events | No source toggle found in this run. | Unknown. | RUN103 ensure unnecessary object event flags disabled. |
| Mouse move events | No hot use found in HUD source. | Unknown. | RUN103 ensure no unnecessary mouse move event subscription. |

## 11. HUD PERFORMANCE TELEMETRY AUDIT

| HUD Metric | Exists? | Source Owner | Patch Needed |
|---|---:|---|---|
| hud_click_ts | partial | `ASC_HudOnChartEvent` local start | RUN101 uses `event_started_ms`. |
| hud_click_to_ack_ms | yes | HUD state | Added `proof_last_click_to_ack_ms`. |
| hud_page_build_ms | yes | HUD state | Added `proof_last_render_build_ms`. |
| hud_object_update_ms | yes | HUD state | Added `proof_last_object_update_ms`. |
| hud_chart_redraw_ms | yes | HUD state | Added `proof_last_chart_redraw_ms`. |
| hud_total_transition_ms | yes | HUD state | Added `proof_last_transition_total_ms`. |
| hud_objects_created | yes | HUD state | Added last-render created metric. |
| hud_objects_updated | yes | HUD state | Added last-render updated metric. |
| hud_objects_deleted | yes | HUD state | Added last-render deleted metric. |
| hud_redraw_count | yes | HUD state | Added last-render redraw metric; existing cycle redraw retained. |
| hud_file_reads | yes | HUD Current Focus reader | Added file-read counter. |
| hud_dossier_reads | no | Not directly in HUD hot path found | RUN104 audit required. |
| hud_market_board_reads | no | Not directly in HUD hot path found | RUN104 audit required. |
| hud_runtime_pause_used | partial | UI priority window | RUN101 priority renders counted. |
| hud_background_deferred_count | partial | Dispatcher telemetry | RUN102 to expose HUD-specific deferred count. |
| hud_page_cache_hit | no | HUD cache future work | RUN104 required. |
| hud_page_cache_miss | no | HUD cache future work | RUN104 required. |
| hud_navigation_depth | partial | page/symbol/bucket state | RUN102 add explicit depth metric. |
| hud_current_page_type | yes | HUD proof summary page name | Present. |
| hud_target_symbol | partial | selected symbol in proof summary | Present as selected symbol. |

## 12. PATCH CANDIDATE MATRIX

| Patch Candidate | Expected Latency Impact | Risk | Chosen? | Why |
|---|---|---|---:|---|
| Add HUD navigation performance telemetry | High proof impact | Low | yes | Required to stop guessing and prove bottleneck. |
| Add dirty-render/render-needed flag | Medium | Already partial | no | Existing dirty flags already present. |
| Batch ChartRedraw to one call | Medium/high | Low | partial | Existing wrapper retained; duration/count telemetry added. |
| Object reuse/update-in-place | High | Moderate | no | Requires wider object lifecycle patch; RUN103. |
| Click acknowledgment before heavy render | High | Low/moderate | partial | RUN101 flushes transition ack before final render path; RUN102 deepens split. |
| Bounded HUD-priority mode | High | Low | yes | Timer now services pending UI-priority navigation before heartbeat. |
| Guard broad ObjectsDeleteAll | Medium | Low | no source change | No HUD `ObjectsDeleteAll` found. |
| Object churn counters | High proof impact | Low | yes | Added last-transition object metrics. |
| Page-cache/view-model placeholder | High future impact | Moderate | no | RUN104 target. |

## 13. FIRST SOURCE PATCH TARGET

Chosen target: **HUD telemetry + UI-priority navigation service before timer heartbeat work.**

Reason: it is the safest high-impact patch because it does not touch trading formulas, rank ordering, FileIO, strategy/execution, or Market Board truth. It directly addresses the confirmed coupling where timer heartbeat work could run before HUD service and adds the missing proof metrics needed to identify whether the next bottleneck is render build, redraw, object churn, file read, or runtime interference.

## 14. PATCH TABLE

| File | Patch | Expected Performance Impact |
|---|---|---|
| `mt5/hud/ASC_HUD_Manager.mqh` | Added HUD latency telemetry fields and high-frequency proof summary fields. | Live proof can now separate click ack, render build, redraw, total transition, object churn, and HUD file reads. |
| `mt5/hud/ASC_HUD_Manager.mqh` | Added `ASC_HudPriorityServicePending()` and `ASC_HudServicePriorityNavigation(...)`. | Pending navigation can be served during UI-priority window before timer heartbeat work. |
| `mt5/hud/ASC_HUD_Manager.mqh` | Measured `ChartRedraw()` duration in `ASC_HudFlushPendingRedraw()`. | Redraw churn becomes visible. |
| `mt5/hud/ASC_HUD_Manager.mqh` | Measured render build/object update counts in `ASC_HudRender(...)`. | Object churn and build cost become visible per transition. |
| `mt5/hud/ASC_HUD_Manager.mqh` | Counted Current Focus file reads in HUD cache path. | Proves whether symbol navigation is reading files. |
| `mt5/AuroraSentinelCore.mq5` | Changed `OnTimer()` to service pending HUD priority navigation before `ASC_RunHeartbeat(...)`. | Prevents simple pending navigation from waiting behind scan/write heartbeat work. |
| `mt5/core/ASC_Version.mqh` | Advanced source identity to RUN101R. | Artifacts identify source patch boundary. |

## 15. SOURCE FILES TOUCHED

| File | Reason |
|---|---|
| `mt5/hud/ASC_HUD_Manager.mqh` | HUD performance telemetry and priority navigation service. |
| `mt5/AuroraSentinelCore.mq5` | Timer order patch for UI-priority HUD navigation before heartbeat. |
| `mt5/core/ASC_Version.mqh` | RUN101R source identity/version/proof boundary. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | RUN101R progress entry. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | RUN101R package manifest. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_RUN101R_HUD_PERFORMANCE_EXTREME_AUDIT_REPORT.md` | Required run report. |

## 16. PROTECTED AREAS NOT TOUCHED

| Protected Area | Status |
|---|---|
| FileIO rewrite | Not touched. |
| GlobalTop10 rank/order/formula | Not touched. |
| L3 score formula | Not touched. |
| L4 rank/order/tie-breakers | Not touched. |
| Market Board order | Not touched. |
| Strategy/execution | Not touched. |
| BUY/SELL / OrderSend / CTrade / lot sizing / SL/TP | Not introduced. |
| Dossier truth expansion | Not touched. |
| L5/L6 all-symbol hydration | Not touched. |
| HUD truth ownership | Not added; HUD remains consumer. |

## 17. HUD PERFORMANCE ACCEPTANCE BASELINE

| HUD Acceptance Target | RUN101 Baseline | RUN105 Target | Proof Method |
|---|---|---|---|
| Click acknowledgment | Previously not split; RUN101 adds `ack_ms`. | Under 100 ms by source design. | HUD proof summary `ack_ms`. |
| Bucket page transition | Unknown; RUN101 adds build/redraw/object metrics. | 250–500 ms cached page. | HUD proof summary total/build/redraw. |
| Sub-bucket transition | Unknown; now measurable. | 250–500 ms cached page. | HUD transition metrics. |
| Symbol page entry | Known user failure around minutes; now measurable. | Under 500 ms prepared page; under 2 sec requires review. | HUD proof summary + live packet. |
| Symbol-to-symbol navigation | Known user failure while collecting packet. | Under 500 ms prepared page. | HUD proof summary + operator click sequence. |
| ChartRedraw count | Existing wrapper; count now explicit. | Max once per committed render batch. | `last_transition.redraws`, cycle redraws. |
| Full object deletion/recreate | No `ObjectsDeleteAll`; deletes counted. | None unless page family changes. | Object create/delete counters. |
| Dossier/Market Board file read in click | Not proven in HUD direct path. | No full-file read inside click handler. | RUN104 file-read telemetry. |
| Heavy scan/write/deep blocking navigation | Timer previously heartbeat-first. | No heavy background work before pending priority navigation. | RUN101 `priority_renders` + heartbeat UI priority telemetry. |

## 18. FIVE-RUN HUD PLAN

| Run | Focus | Source Target | Expected Performance Gain | Live Test? |
|---|---|---|---|---:|
| RUN101 | Audit + first safe patch + telemetry | HUD telemetry + timer priority navigation | Proof and first uncoupling | no |
| RUN102 | Event/render decoupling + click acknowledgment | `ASC_HudOnChartEvent`, selected-symbol sync path | Click feels instant; heavy work deferred | no |
| RUN103 | Object lifecycle / redraw / object pool | `ASC_HudEnsure*`, hide/delete helpers, object cache | Lower chart queue pressure | no |
| RUN104 | HUD view-model/cache + no file reads during navigation | Current Focus/Market Board/Dossier read paths and prepared page cache | Cached pages under 250–500 ms | no |
| RUN105 | HUD performance closeout + RUN106/RUN111 proof seed | Acceptance proof instrumentation and live checklist | Ready for live HUD performance proof | yes/seed |

## 19. STATIC COMPILE-SAFETY TABLE

| Static Compile Check | Result | Action |
|---|---|---|
| Identifiers under 63 chars | New identifiers checked under 63 chars. | Pass by static inspection. |
| No giant new `StringFormat` risk | One existing HUD proof `StringFormat` expanded; argument count remains bounded and matched by static count. | Monitor compile; no compile claim. |
| Wrong parameter count | New helper calls use declared signatures. | Pass by static inspection. |
| Block-scoped variable used outside | New variables remain local to functions. | Pass by static inspection. |
| Missing helper declarations | Added forward declarations for new helpers and `ASC_HudRender`. | Pass by static inspection. |
| Include-order break | `ASC_HUD_Manager.mqh` remains included before OnTimer uses helper. | Pass by static inspection. |
| `ChartRedraw` wrapper signature mismatch | Wrapper unchanged externally; internal timing added. | Pass by static inspection. |
| Enum/string helper missing cases | No enum cases added. | Not applicable. |
| Broad object deletion side effects | No `ObjectsDeleteAll` added. | Pass. |
| Strategy/execution includes touched | Not touched. | Pass. |
| Brace/paren balance | Touched files checked balanced by static text count. | Pass by static inspection. |

## 20. REGRESSION GUARD

| Guard | Verdict |
|---|---|
| No strategy/execution | Pass. |
| No BUY/SELL / OrderSend / CTrade | Pass. |
| No lot sizing | Pass. |
| No SL/TP logic | Pass. |
| No GlobalTop10 rank/order/formula change | Pass. |
| No L3 score formula change | Pass. |
| No L4 rank/order change | Pass. |
| No FileIO rewrite | Pass. |
| No HUD truth ownership | Pass. |
| No hidden compute inside HUD | Patch adds telemetry/service order only; no new truth computation. |
| No broad Dossier rewrite | Pass. |
| No broad L5/L6 hydration | Pass. |

## 21. TRUE ROADMAP PROGRESS UPDATE

RUN101R starts the HUD performance warpath. It does not close performance proof because no live output was requested or provided for this run. It does create the first reliable source-level proof spine for HUD latency and makes a narrow priority-order repair so pending UI navigation can be serviced before heartbeat scan/write work during the UI-priority window.

Progress state: `hud_performance_source_patched_live_unproven`.  
Next state needed: RUN102R must prove the click path can acknowledge immediately and move render/artifact sync out of the click handler.

## 22. RUN102R NEXT_PROMPT_SEED

RUN102R / EVENT-RENDER DECOUPLING + CLICK ACKNOWLEDGMENT

First files to read:
1. `roadmap/Truth Seeker/TRUTH_SEEKER_RUN101R_HUD_PERFORMANCE_EXTREME_AUDIT_REPORT.md`
2. `mt5/hud/ASC_HUD_Manager.mqh`
3. `mt5/AuroraSentinelCore.mq5`
4. `mt5/runtime/ASC_Dispatcher.mqh`
5. `mt5/core/ASC_RuntimeState.mqh`

Primary target:
- Split `ASC_HudOnChartEvent(...)` into a tiny click-ack/navigation-intent phase and a deferred render/service phase.
- Do not queue Current Focus sync or downstream refresh inside ordinary bucket/sub-bucket/symbol navigation click handling.
- Add explicit navigation depth/page-type telemetry.

Evidence needed:
- Static proof that click path does not call full artifact sync for ordinary navigation.
- Static proof that click acknowledgment is emitted before render/service work.
- Telemetry proof fields preserved from RUN101R.

Forbidden drift:
- No FileIO rewrite.
- No rank/order/formula changes.
- No strategy/execution changes.
- No Market Board order change.
- HUD remains read-only consumer.

## 23. FINAL DECISION

PASS — RUN101R performed a deep HUD performance audit, converted official MQL5 chart/event/timer findings into source constraints, landed a safe HUD performance source patch, added transition telemetry, patched timer priority ordering, updated control files, and seeds RUN102R with the next HUD performance target. Compile/live proof is not claimed.
