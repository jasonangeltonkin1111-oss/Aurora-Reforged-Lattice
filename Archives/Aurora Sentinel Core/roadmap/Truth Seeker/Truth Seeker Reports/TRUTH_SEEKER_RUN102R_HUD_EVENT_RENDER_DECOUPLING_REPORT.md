# TRUTH SEEKER RUN102R — HUD EVENT-RENDER DECOUPLING + INSTANT CLICK ACKNOWLEDGMENT

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN102R / HUD EVENT-RENDER DECOUPLING + INSTANT CLICK ACKNOWLEDGMENT — SPLIT CLICK INTENT FROM HEAVY RENDER, REMOVE ORDINARY NAVIGATION ARTIFACT SYNC FROM CLICK PATH, AND HARDEN HUD PRIORITY SERVICE

RUN TYPE: HUD PERFORMANCE EVENT/RENDER DECOUPLING / SOURCE PATCH / CONTROL UPDATE / NO-LIVE PERFORMANCE REPAIR  
NEXT HUD RUN: RUN103R / OBJECT LIFECYCLE + REDRAW OPTIMIZATION  
PROOF BOUNDARY: `hud_event_render_decoupled_source_patched_live_unproven`  
COMPILE CLAIM: not claimed  
LIVE CLAIM: not claimed  
OUTPUT CLAIM: claimed only from inspected source/control/report package

## 2. OPERATOR SNAPSHOT

| Field | RUN102R Verdict |
|---|---|
| User-reported latency | About 4 minutes from major bucket → minor bucket → symbol page. |
| Source patched | Yes. |
| Click path split | Yes: ordinary navigation no longer calls `ASC_HudRender(runtime)` directly inside `ASC_HudOnChartEvent(...)`. |
| Immediate ack source path | Yes: `ASC_HudAckNavigationClick(...)` records ack telemetry, sets pending render intent, updates a small transition label, and returns to the handler without full page render. |
| Ordinary nav heavy artifact sync removed/deferred | Yes: selected-symbol Current Focus sync is marked as deferred from ordinary symbol-page entry and queued later by priority service, not inside the click handler. |
| Biggest remaining HUD bottleneck | Object lifecycle churn and chart command queue pressure inside the full render path. |
| Next HUD target | RUN103R: object lifecycle + redraw optimization. |
| Protected areas not touched | FileIO, GlobalTop10 rank/order/formula, L3 score formula, L4 rank/order, Market Board order, strategy/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP. |
| Expected performance effect | Ordinary navigation click handlers should exit after navigation mutation + ack/intent; render and selected-symbol artifact sync move into deferred service. |

## 3. INPUT ZIP / FILE INTAKE SUMMARY

| Input | Verified Result |
|---|---|
| `/mnt/data/Aurora Sentinel Core(349).zip` | Extracted successfully. |
| Root layout | One active root found: `Aurora Sentinel Core/`. |
| Nested roots | No competing active root found. |
| File count | 602 files found under the active root. |
| RUN101R report | Present: `roadmap/Truth Seeker/TRUTH_SEEKER_RUN101R_HUD_PERFORMANCE_EXTREME_AUDIT_REPORT.md`. |
| RUN101R patched HUD source | Present: `mt5/hud/ASC_HUD_Manager.mqh`. |
| Runtime entry | Present: `mt5/AuroraSentinelCore.mq5`. |
| Version owner | Present: `mt5/core/ASC_Version.mqh`. |
| Active controls | Present: active roadmap log and output package manifest. |
| Live output evidence in this upload | No separate runtime-output zip found; RUN100/RUN100R-REDO reports present as source-control evidence only. |

## 4. RUN101R ABSORPTION

| RUN101 Item | Verified In Source? | Remaining Gap | RUN102 Action |
|---|---:|---|---|
| HUD latency telemetry fields | Yes | Needed click-handler vs deferred-render split | Added handler total, deferred wait/render, fast/slow path, control class, target page/symbol fields. |
| Click-to-ack measurement | Yes | Ack still paired with immediate render in light nav path | Created ack helper and removed ordinary nav direct render. |
| Render build measurement | Yes | Full render still monolithic | Preserved measurement; deferred service now records deferred render time. |
| Object churn counters | Yes | Object lifecycle still costly | Preserved for RUN103 object lifecycle work. |
| Redraw duration counter | Yes | Redraw still required for ack label | Kept batched through request/flush wrapper. |
| Current Focus file-read counter | Yes | Ordinary symbol entry could still queue Current Focus sync | Deferred selected-symbol sync out of click path. |
| `ASC_HudPriorityServicePending()` | Yes | Needed pending render/service semantics | Kept as service gate; RUN102 service now consumes pending intent. |
| `ASC_HudServicePriorityNavigation(...)` | Yes | It simply called full render | Extended to measure wait/render, consume pending render, and process deferred Current Focus sync after render. |
| OnTimer HUD priority before heartbeat | Yes | Source support already landed in RUN101R | Preserved. |
| `ASC_HudOnChartEvent(...)` still too heavy | Yes | Direct light-navigation render and selected-symbol sync queueing | Patched. |
| `ASC_HudRender(...)` still monolithic | Yes | Still full-page render | Deferred out of click path; RUN103 must optimize internals. |
| Current Focus sync still possible during navigation | Yes | Ordinary symbol entry was coupled to click | Replaced with deferred marker for ordinary symbol-page entry. |

## 5. ROADMAP AUTHORITY CHECK

| Authority Item | Status | Impact |
|---|---|---|
| Operator problem statement | Absorbed as highest authority. | HUD latency treated as trading-critical failure. |
| RUN101R report | Read and verified against source. | RUN102 targeted the carry-forward gap. |
| RUN101R patched source | Verified directly. | Patch based on current code, not report wording. |
| `TRUTH_SEEKER_ROADMAP.md` | Present. | Control continuity preserved. |
| Active roadmap log and manifest | Present and updated. | RUN102R control trail added. |
| Older reports/live evidence | Present as support only. | No live/compile claim made. |

## 6. INTERNET RESEARCH CONVERSION TABLE

| Research Area | Source | Finding | HUD Event/Render Constraint | Patch / Audit Impact |
|---|---|---|---|---|
| `OnChartEvent` behavior | Official MQL5 `OnChartEvent` docs | Chart/object events are delivered to EA handlers for user/program chart changes. | Treat object-click handler as a latency-sensitive event handler, not a place for heavy render work. | `ASC_HudOnChartEvent(...)` now mutates intent and acknowledges first. |
| Chart command queue | Official MQL5 Chart Operations / `ChartSetInteger` docs | Chart property setters are asynchronous and enqueue commands to the chart event queue. | Do not assume chart command completion inside click handler. | Ack label is minimal; heavy render is deferred. |
| Object operations and readback | Official MQL5 `ObjectMove` / object docs | Object commands enqueue; property reads wait behind the chart queue and can be time-consuming with many objects. | Avoid object readback churn in click path. | RUN102 keeps click path out of render/object update loops; RUN103 targets object lifecycle. |
| `ObjectsDeleteAll` | Official MQL5 `ObjectsDeleteAll` docs | Bulk object deletion is synchronous and can be time-consuming with many objects. | Do not delete/recreate HUD surface during ordinary navigation. | No delete-all path added; RUN103 must preserve stable object shells. |
| `ChartRedraw()` batching | Official MQL5 chart/object docs | Redraw flushes queued chart updates and should be batched after grouped changes. | Use one small ack redraw at most; render redraw remains batched. | Ack uses existing request/flush wrapper; full render is deferred. |
| Timer queue behavior | Official MQL5 `EventSetTimer` docs | Timer events are not queued if one is already queued or processing. | Priority service must stay bounded or it can starve future timer events. | Service is gated, skips dirty-heavy data, and only serves pending nav intent. |

## 7. PROMPT EVOLUTION / HUD PERFORMANCE PROMPT UPGRADE

| RUN101/RUN102 Prompt Weakness | Evidence | New Rule For RUN103–RUN105 | Expected Improvement |
|---|---|---|---|
| HUD work can be misread as polish | 4-minute navigation failure blocks trading-critical packet collection. | Every HUD run must treat latency as trading-critical, not visual cleanup. | Prevents cosmetic-only HUD passes. |
| Patch requirement can drift into audit-only | RUN101 confirmed but did not fully split click/render. | Every HUD run must patch source if a patchable HUD gap exists. | Keeps warpath runs outcome-producing. |
| Latency taxonomy was incomplete | Click ack, navigation mutation, render, redraw, file reads, and artifact sync were not separated enough. | Every HUD run must distinguish click ack, navigation mutation, render build, redraw, file read, and artifact sync. | Bottlenecks become falsifiable. |
| Truth ownership can drift during speed work | HUD temptation is to compute/rebuild truth locally. | Every HUD run must protect truth ownership and formulas. | Speed cannot corrupt scanner truth. |
| Compile-risk checks need to be explicit | Object/chart helpers are sensitive to parameter counts and identifier lengths. | Every HUD run must include static MQL5 compile-risk checks for chart/object helper changes. | Reduces syntax/regression risk. |
| Object/readback churn can be added accidentally | Official docs warn synchronous reads can wait behind chart queue. | Every HUD run must avoid adding object/readback churn. | RUN103 focuses object cache lifecycle instead of more queue pressure. |

## 8. CLICK PATH CLASSIFICATION

| Control / Branch | Class | Heavy Work Currently Done? | Should Ack Immediately? | RUN102 Patch |
|---|---|---:|---:|---|
| `btn_back` / `btn_forward` | page_back_forward | Before: could render immediately | Yes | Classified + deferred render. |
| `btn_home` / `btn_buckets` / `btn_top10` | bucket_navigation | Before: could render immediately | Yes | Classified + deferred render. |
| `btn_sub_groups` / `btn_leaders` | sub_bucket_navigation | Before: could render immediately | Yes | Classified + deferred render. |
| `btn_symbols` | symbol_list_navigation | Before: could render immediately | Yes | Classified + deferred render. |
| `btn_symbol` / `btn_details` | symbol_detail_entry | Before: could queue Current Focus sync and render | Yes | Current Focus sync deferred; render deferred. |
| Row buttons from main bucket | bucket_navigation | Before: direct render possible | Yes | Classified by current page + deferred render. |
| Row buttons from sub-groups | sub_bucket_navigation | Before: direct render possible | Yes | Classified by current page + deferred render. |
| Row buttons from symbols/leaders/top10 | symbol_detail_entry | Before: direct render + selected sync queue possible | Yes | Classified by current page + deferred sync/render. |
| `pager_prev` / `pager_next` | page_back_forward | Before: direct render possible | Yes | Classified + deferred render. |
| `sym_stat_*` / `deep_sub_*` / `act_semi` | symbol_prev_next | Before: direct render possible | Yes | Classified + deferred render. |
| `btn_sync` / `act_page_refresh` | manual_refresh | Explicit heavy | Ack allowed; heavy explicit | Preserved as slow path. |
| `act_aurora` | forced_downstream_refresh | Explicit heavy queue | Ack allowed; heavy explicit | Preserved as slow path. |
| `act_deep` | deep_analysis_trigger | Explicit heavy queue | Ack allowed; heavy explicit | Preserved as slow path. |
| `act_full` | higher_scope_refresh | Explicit heavy | Ack allowed; heavy explicit | Preserved as slow path. |
| Chart resize | chart_resize | Resize guard + bg update | Debounced | Existing guarded path preserved. |
| Unknown control | unknown_or_legacy_control | Unknown | No accidental heavy work | Classified slow/unknown. |

## 9. SPLIT CLICK ACK FROM RENDER

| Path | Before RUN102 | After RUN102 | Expected Latency Impact |
|---|---|---|---|
| Ordinary nav click | Mutate nav, queue sync if symbol context, call `ASC_HudRender(runtime)` for light navigation, flush redraw. | Mutate nav, mark deferred Current Focus sync if needed, ack with transition label, queue pending navigation intent, return without full render. | Click handler exits much faster. |
| Deferred render | RUN101 priority service called full render, but click path still called render. | Priority service records wait/render ms, renders outside click handler, clears pending intent. | Render cost moves off event hot path. |
| Artifact sync | Symbol page entry could queue Current Focus sync from click handler. | Symbol entry marks sync deferred; service queues sync after deferred render. | Ordinary symbol entry no longer queues artifact sync inside event handler. |

## 10. ORDINARY NAVIGATION ARTIFACT SYNC AUDIT

| Heavy Operation | Current Trigger | Ordinary Nav Uses It? | RUN102 Patch |
|---|---|---:|---|
| Current Focus sync | Entering symbol overview/detail | Before: yes | Deferred via `ASC_HudMarkCurrentFocusSyncDeferred(...)`. |
| Dossier full-file read | Current Focus/deep preview paths | Not directly in ordinary click handler | No new file reads added. |
| Market Board parse | Manual refresh / data rebuild paths | Not patched into ordinary click | Preserved outside ordinary nav click. |
| GlobalTop10 parse/cache | Top10/render/data paths | Not patched into click | No rank/order change. |
| Forced downstream refresh | Explicit refresh/deep controls | No ordinary nav use | Explicit controls preserved. |
| Deep selective analysis | `act_deep` explicit action | No ordinary nav use | Explicit heavy path preserved. |
| Heavy dataset refresh | Dirty-heavy / explicit sync | Not ordinary nav fast path | Priority service skips dirty-heavy state. |

## 11. HUD ACKNOWLEDGMENT SURFACE

| Ack Field / Surface | Exists Before | RUN102 Patch | Compile Risk |
|---|---|---|---|
| `hud_click_acknowledged` | No | Added state flag. | Low: struct field only. |
| `hud_ack_label` | No | Added label field. | Low. |
| `proof_last_click_to_ack_ms` | Yes | Preserved and driven by helper. | Low. |
| `proof_last_click_handler_total_ms` | No | Added handler total measurement. | Low. |
| `hud_pending_render` | No | Added pending render flag. | Low. |
| `hud_pending_target_page` | No | Added target page string. | Low. |
| `hud_pending_target_symbol` | No | Added target symbol string. | Low. |
| `hud_deferred_render_reason` | No | Added reason string. | Low. |
| Transition label | Yes | Reused as minimal ack surface. | Low. |

## 12. DEFERRED RENDER SERVICE

| Deferred Render Requirement | Source Support | RUN102 Patch |
|---|---|---|
| Service pending navigation before heartbeat | RUN101 `OnTimer()` support exists. | Preserved. |
| Render only if dirty/pending | Existing `ASC_HudPriorityServicePending()` gate. | Preserved; heavy dirty state remains excluded. |
| No render while resize guard active | Existing gate excludes resize/chart-change states. | Preserved. |
| No heavy data refresh | Gate excludes dirty-heavy and queued-heavy refresh. | Preserved and skip reason added in service. |
| No infinite pending state | Service clears pending intent after render. | Extended to clear reason/target flags. |
| Telemetry increments service count / skip reason | Partial before. | Added skip count/reason and deferred render wait/ms. |
| Deferred Current Focus sync | Not separated before. | Added service-side sync after deferred render. |

## 13. RUN101 PRIORITY SERVICE REVIEW

| RUN101 Priority Service Behavior | Risk | RUN102 Decision | Patch |
|---|---|---|---|
| Calls `ASC_HudRender(runtime)` | Correct service point but too blunt | Keep as service point | Extended telemetry + intent cleanup. |
| No deferred render wait metric | Could not distinguish queue delay | Add metric | `proof_last_deferred_render_wait_ms`. |
| No handler total metric | Click path still opaque | Add metric | `proof_last_click_handler_total_ms`. |
| Could not show artifact sync deferral | Current Focus sync ambiguity remained | Add deferral marker | `current_focus_sync_deferred*` fields. |
| Heavy data excluded by pending gate | Good | Preserve | Priority render does not run dirty-heavy. |

## 14. HUD PERFORMANCE TELEMETRY EXTENSION

| Telemetry Field | Present After RUN101 | RUN102 Need | Patch |
|---|---:|---|---|
| click handler total | No | Yes | Added `proof_last_click_handler_total_ms`. |
| click ack | Yes | Yes | Preserved and centralized. |
| deferred render wait | No | Yes | Added `proof_last_deferred_render_wait_ms`. |
| deferred render build | No | Yes | Added `proof_last_deferred_render_ms`. |
| redraw duration | Yes | Yes | Preserved. |
| object churn | Yes | Yes | Preserved. |
| file reads | Yes | Yes | Preserved. |
| artifact sync deferred | No | Yes | Added `proof_last_artifact_sync_deferred`. |
| priority service count | Yes | Yes | Preserved. |
| priority service skip reason | No | Yes | Added. |
| fast path count | No | Yes | Added `proof_nav_fast_path_count`. |
| slow path count | No | Yes | Added `proof_nav_slow_path_count`. |
| last control class | No | Yes | Added. |
| last target page | No | Yes | Added. |
| last target symbol | No | Yes | Added. |

## 15. PATCH CANDIDATE MATRIX

| Candidate | Patch? | Reason |
|---|---:|---|
| `mt5/hud/ASC_HUD_Manager.mqh` | Yes | Owns click path, render intent, priority service, HUD telemetry. |
| `mt5/AuroraSentinelCore.mq5` | No | RUN101 already moved HUD priority before heartbeat; no RUN102 source change needed. |
| `mt5/core/ASC_Version.mqh` | Yes | Source identity/version bump required. |
| `mt5/core/ASC_RuntimeState.mqh` | No | Runtime ownership unchanged. |
| `mt5/io/ASC_FileIO.mqh` | No | Protected; no FileIO gap required edit. |
| Artifact writers | No | HUD remains read-only consumer; publication ownership unchanged. |
| L3/L4/L5 formula owners | No | Protected. |

## 16. PATCH TABLE

| File | Patch |
|---|---|
| `mt5/hud/ASC_HUD_Manager.mqh` | Added navigation intent/ack fields, control classification, ack helper, deferred Current Focus marker, extended priority service telemetry, and removed ordinary navigation direct render from `ASC_HudOnChartEvent(...)`. |
| `mt5/core/ASC_Version.mqh` | Advanced current run/source identity to RUN102R and added RUN102R scope/boundary/proof/research tokens. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | Added RUN102R PASS entry and RUN103R carry-forward. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | Added RUN102R changed-files manifest. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_RUN102R_HUD_EVENT_RENDER_DECOUPLING_REPORT.md` | Created this report. |

## 17. SOURCE FILES TOUCHED

| File | Touched |
|---|---:|
| `Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh` | Yes |
| `Aurora Sentinel Core/mt5/core/ASC_Version.mqh` | Yes |
| `Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | Yes |
| `Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | Yes |
| `Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_RUN102R_HUD_EVENT_RENDER_DECOUPLING_REPORT.md` | Yes |

## 18. PROTECTED AREAS NOT TOUCHED

| Area | Verdict |
|---|---|
| FileIO | Not touched. |
| GlobalTop10 rank/order/formula | Not touched. |
| L3 score formula | Not touched. |
| L4 rank/order | Not touched. |
| Market Board order | Not touched. |
| Strategy/execution | Not touched. |
| BUY/SELL / OrderSend / CTrade | Not introduced. |
| Lot sizing / SL / TP | Not introduced. |
| HUD truth ownership | No new truth ownership; HUD remains read-only consumer. |

## 19. HUD PERFORMANCE ACCEPTANCE UPDATE

| HUD Acceptance Target | RUN101 State | RUN102 Source State | RUN105 Target | Proof Method |
|---|---|---|---|---|
| Click acknowledgment under 100 ms by source design | Measured but still coupled | Ack helper before render | Live median/p95 under 100 ms | HUD telemetry logs. |
| Ordinary nav handler exits without full render | No | Yes by source inspection | Proven live | Handler telemetry + no `served_immediate_render`. |
| Deferred render service handles page update | Partial | Yes | Proven live | Priority service render count + deferred render ms. |
| No ordinary nav Current Focus sync in click handler | No | Yes | Proven live | `artifact_sync_deferred=yes` and handler logs. |
| No Dossier full-file read in click handler | No direct proof of read | No new read added | Proven live | File-read counters unchanged during click. |
| ChartRedraw batched | Partial | Ack redraw via wrapper; full render deferred | One redraw/transition target | Redraw count/duration. |
| Object churn measurable | Yes | Preserved | Reduced in RUN103 | Object counters. |
| File reads measurable | Yes | Preserved | Zero in click path | File-read counters. |
| Slow path explicitly classified | No | Yes | All slow controls named | `last_control_class`. |

## 20. STATIC COMPILE-SAFETY TABLE

| Static Compile Check | Result | Action |
|---|---|---|
| Identifiers under 63 chars | Pass by grep for 63+ chars. | No action. |
| No giant `StringFormat` | Pass: added log string has bounded parameter count. | No action. |
| No wrong parameter count | Source-inspected for new helper calls. | No action. |
| No block-scoped variable used outside | Pass by source inspection. | No action. |
| No missing helper declarations | Prototypes added before use. | No action. |
| No include-order break | Only HUD/version touched. | No action. |
| No `ChartRedraw` wrapper mismatch | Existing wrapper unchanged. | No action. |
| No enum/string helper missing cases | Control class returns fallback. | No action. |
| No recursive service loop | Service calls render once and clears pending state. | No action. |
| No unbounded pending navigation state | Pending intent cleared after service render. | No action. |
| No duplicate function names | Grep found one prototype/one implementation for new helpers. | No action. |
| No strategy/execution includes touched | Pass. | No action. |

## 21. REGRESSION GUARD

| Guard | Result |
|---|---|
| no strategy/execution | Pass. |
| no BUY/SELL / OrderSend / CTrade | Pass. |
| no lot sizing | Pass. |
| no SL/TP | Pass. |
| no GlobalTop10 rank/order/formula change | Pass. |
| no L3 score formula change | Pass. |
| no L4 rank formula/order change | Pass. |
| no FileIO rewrite | Pass. |
| no HUD truth ownership | Pass. |
| no hidden compute inside HUD | Pass: patch changes event/render scheduling only. |
| no broad Dossier rewrite | Pass. |
| no broad L5/L6 all-symbol hydration | Pass. |

## 22. TRUE ROADMAP PROGRESS UPDATE

RUN102R advances HUD performance warpath run 2 of 5. It does not claim live speed proof, but it removes the largest source-level click-path coupling left by RUN101R: ordinary navigation no longer directly renders a full page nor queues selected-symbol Current Focus sync from inside `ASC_HudOnChartEvent(...)`.

## 23. RUN103R NEXT_PROMPT_SEED

NEXT RUN: RUN103R / OBJECT LIFECYCLE + REDRAW OPTIMIZATION

First files to read:
1. `roadmap/Truth Seeker/TRUTH_SEEKER_RUN102R_HUD_EVENT_RENDER_DECOUPLING_REPORT.md`
2. `mt5/hud/ASC_HUD_Manager.mqh`
3. `mt5/hud/ASC_HUD_ObjectCacheIndex.mqh`
4. `mt5/hud/ASC_HUD_ReadModelRenderInput.mqh`
5. `mt5/AuroraSentinelCore.mq5`
6. `mt5/core/ASC_Version.mqh`
7. active roadmap log and manifest

Primary target:
- Reduce object create/update/readback churn and make render redraw batching stricter without changing truth ownership.

Evidence needed:
- ObjectCreate/ObjectSet/ObjectFind/ObjectGet counts by render cycle.
- Redraw count/duration by page transition.
- No `ObjectsDeleteAll` in HUD hot paths.
- Stable object shell reuse for list/symbol panels.

Proof debt to preserve:
- RUN102R live latency unproven.
- Compile proof not claimed.
- Live proof not claimed.
- Current Focus sync is deferred by source design but must be live-proven.

Forbidden drift:
- FileIO rewrite.
- Rank/order/formula changes.
- Strategy/execution changes.
- Market Board order changes.
- HUD truth ownership.
- Object/readback churn additions.

## 24. FINAL DECISION

PASS — RUN102R lands a safe HUD source patch that splits ordinary navigation click acknowledgment from heavy render/service work, defers ordinary selected-symbol Current Focus sync, expands telemetry, preserves protected areas, and seeds RUN103R object lifecycle/redraw optimization.

