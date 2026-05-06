# GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN103R / HUD OBJECT LIFECYCLE + REDRAW OPTIMIZATION — STOP OBJECT CHURN, REDUCE CHART QUEUE PRESSURE, BATCH REDRAWS, AND PREPARE STABLE OBJECT SHELLS FOR INSTANT NAVIGATION

Run Type: HUD object lifecycle / redraw optimization / source patch / control update / no-live performance repair  
Decision: PASS  
Proof Boundary: `hud_object_lifecycle_redraw_optimized_source_patched_live_unproven`  
Compile Claim: not claimed  
Live Claim: not claimed

# OPERATOR SNAPSHOT

| Field | RUN103R State |
|---|---|
| User-reported latency | ~4 minutes bucket → sub-bucket → symbol page navigation. |
| Source patched | Yes. |
| Object churn reduced by source design | Yes — cache-first shell detection and unchanged signature skips now avoid ordinary per-render `ObjectFind()` and repeated set calls. |
| Redraw batching hardened | Yes — redraw requests/flushes/suppressed no-mutation flushes are counted; render still flushes once after committed render mutation batch. |
| Object readback reduced/counted | Yes — ordinary ensure paths no longer call `ObjectFind()` when cache already knows the object; remaining property reads are counted. |
| Hidden sync call classified | Yes — runtime selected-symbol pointer/state sync; no FileIO, no artifact publication, no Dossier/Current Focus write. Same-symbol section clicks no longer repeat the lookup. |
| Biggest remaining HUD bottleneck | RUN104R must remove navigation-time file/read-model pulls and build a dedicated HUD view-model/cache layer. |
| Next HUD target | RUN104R / HUD view-model + cache + no file reads during navigation. |
| Protected areas not touched | FileIO, strategy/execution, GlobalTop10 rank/order/formula, L3 score, L4 rank/order, Market Board order, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP. |
| Expected performance effect | Lower chart queue pressure during deferred render: fewer synchronous object lookups, fewer repeated object property writes, stable shells retained/hidden instead of deleted in page-local transitions. |

# INPUT ZIP / FILE INTAKE SUMMARY

| Input | Result |
|---|---|
| Uploaded package | `/mnt/data/Aurora Sentinel Core(350).zip` extracted. |
| Root discovered | `Aurora Sentinel Core/` root confirmed. |
| Nested roots inspected | `mt5/`, `mt5/hud/`, `mt5/runtime/`, `mt5/core/`, `mt5/artifacts/`, `mt5/logging/`, `roadmap/Truth Seeker/`. |
| RUN102 report present | Yes: `roadmap/Truth Seeker/TRUTH_SEEKER_RUN102R_HUD_EVENT_RENDER_DECOUPLING_REPORT.md`. |
| RUN101 report present | Yes: `roadmap/Truth Seeker/TRUTH_SEEKER_RUN101R_HUD_PERFORMANCE_EXTREME_AUDIT_REPORT.md`. |
| Live output evidence | No new live output required or claimed for RUN103R. |
| Source authority | `mt5/hud/ASC_HUD_Manager.mqh` inspected and patched directly. |

# RUN102R ABSORPTION

| RUN102 Item | Verified In Source? | Remaining Gap | RUN103 Action |
|---|---:|---|---|
| `ASC_HudAckNavigationClick(...)` | Yes | Ack still flushed redraw immediately, but render object churn remained after ack. | Preserved; redraw request/flush telemetry hardened. |
| `ASC_HudQueueNavigationIntent(...)` | Yes | Deferred render still used old object lifecycle paths. | Preserved; object lifecycle patched below. |
| `ASC_HudServicePriorityNavigation(...)` | Yes | Priority render still called full render path when dirty navigation was pending. | Preserved; render cost reduced through object cache-first updates. |
| pending navigation flags | Yes | Navigation dirty state did not reduce object churn by itself. | Preserved. |
| click handler total telemetry | Yes | Needed object lifecycle detail beneath render timing. | Extended with cache/readback/redraw metrics. |
| deferred render wait/render telemetry | Yes | Did not explain object churn source. | Extended telemetry. |
| fast/slow path telemetry | Yes | Classification exists but object lifecycle cost remained. | Preserved. |
| deferred Current Focus marker | Yes | Artifact sync deferred, but runtime selected-symbol sync still remained. | Classified and narrowed same-symbol repeated sync. |
| ordinary navigation direct render removed | Yes | Deferred render may still be slow. | Reduced deferred render object/readback cost. |
| `ASC_HudSyncRuntimeSelectedSymbol(runtime,false)` caveat | Yes | It was still in symbol-context click path. | Classified as runtime pointer/state sync only; same-symbol repeat lookup removed. |
| object lifecycle not yet optimized | Yes | Create/set/readback churn was still open. | Patched. |
| redraw/object churn still pending | Yes | Redraw telemetry was too coarse. | Patched with request/flush/suppressed counters. |

# ROADMAP AUTHORITY CHECK

RUN103R followed the operator HUD latency statement first, then RUN102 report/source, RUN101 report, active roadmap/control files, HUD source, runtime/event owners, artifact/read-model owners, and logging/performance owners. No rank/formula/strategy/FileIO owner was edited.

# INTERNET RESEARCH CONVERSION TABLE

| Research Area | Source | Finding | HUD Object/Redraw Constraint | Patch / Audit Impact |
|---|---|---|---|---|
| Object create queue | Official MQL5 `ObjectCreate` reference | `ObjectCreate()` returns success for adding a command to the chart queue; execution result is not immediately known. | Do not create/delete/recreate shells casually in navigation render. | Reuse stable object cache entries and skip unchanged signatures. |
| Object readback cost | Official MQL5 `ObjectCreate`, `ObjectFind`, `ObjectGetInteger` references | `ObjectFind()` and `ObjectGet*` are synchronous and can wait for prior chart commands. | Ordinary render should not verify object existence/properties every time. | Cache-first object detection; remaining readback counted. |
| Delete-all cost | Official MQL5 `ObjectsDeleteAll` reference | `ObjectsDeleteAll()` is synchronous and can be time-consuming with many objects. | No broad delete-all in ordinary HUD navigation. | Verified no `ObjectsDeleteAll()` in HUD; telemetry field added for future guard. |
| Redraw batching | Official MQL5 `ChartRedraw` and `ChartSetInteger` references | Group property changes and call `ChartRedraw()` once after the block when immediate visual update is required. | No redraw inside object loops; request then flush after batch. | Redraw request/flush/suppressed telemetry hardened. |
| Chart property queue | Official MQL5 `ChartSetInteger` reference | Chart property set commands are asynchronous and queued; synchronous gets wait for results. | Treat chart queue as a scarce resource. | Object and redraw telemetry now exposes queue-pressure contributors. |
| Timer queue | Official MQL5 `EventSetTimer` reference | New timer event is not added if a timer event is already queued or processing. | Long render/service work can starve heartbeat timing. | RUN104 seed keeps priority on cache/no-file-read navigation. |

# PROMPT EVOLUTION / HUD PERFORMANCE PROMPT UPGRADE

| RUN102/RUN103 Prompt Weakness | Evidence | New Rule For RUN104–RUN105 | Expected Improvement |
|---|---|---|---|
| Event/render decoupling is not enough if render object churn remains high. | RUN102 deferred render still called object ensure paths. | Every HUD run must inspect render object lifecycle after event decoupling. | Removes next bottleneck rather than only moving it later. |
| Hidden sync calls can remain in click path. | `ASC_HudSyncRuntimeSelectedSymbol(runtime,false)` remained after RUN102. | Every HUD run must inspect source for hidden sync calls left in click path. | Prevents accidental reintroduction of blocking work. |
| Object reads are as dangerous as writes. | MQL5 docs classify `ObjectFind`/`ObjectGet*` as synchronous. | Every HUD run must audit object reads as well as writes. | Less chart queue waiting. |
| Reuse can create stale UI if not guarded. | Cache-first UI relies on signature correctness. | Every HUD run must protect object reuse from becoming stale data. | Keeps speed without false surface state. |
| Performance changes can drift into truth. | HUD is consumer-only by law. | Every HUD run must preserve truth ownership and formula/rank safety. | No edge/ranking/strategy drift during UI work. |

# OBJECT LIFECYCLE OWNER MAP

| Object Lifecycle Function | Source Owner | Current Behavior | Cost Risk | Patch Candidate |
|---|---|---|---|---|
| label creation | `ASC_HudEnsureLabel` | Creates only on cache miss/object miss. | Object create enqueues command. | Cache-first detection patched. |
| button creation | `ASC_HudEnsureButton` | Creates only on cache miss/object miss. | Button row churn. | Cache-first detection patched. |
| panel/card creation | `ASC_HudEnsureRect` | Creates only on cache miss/object miss. | Rectangle shell churn. | Cache-first detection patched. |
| text update | ensure label/button helpers | Writes only after signature mutation. | Repeated text sets enqueue commands. | Text skip telemetry added. |
| style update | ensure rect/label/button helpers | Writes only after signature mutation. | Repeated style sets enqueue commands. | Style skip telemetry added. |
| hide/update inactive controls | `ASC_HudDeletePageLocalObjects` | Hides known cached local objects by type. | Previous object type readback could block. | Cached object type used first. |
| object cache lookup | `ASC_HudFindObjectCache*` | Indexed lookup. | Low. | Tracked hit/miss wrapper added. |
| object create path | `ASC_HudEnsure*` | Create only on miss. | Queue pressure. | Miss-only `ObjectFind`; cache hit avoids readback. |
| object delete path | `ASC_HudDeleteObjects`, fallback in page local delete | Shutdown/full delete only. | Synchronous enumeration. | Counted; ordinary page-local hides rather than deletes. |
| object readback path | `ASC_HudObjectExistsAfterCacheMiss`, fallback object type read | Miss/fallback only. | Synchronous. | Counted and reduced. |
| ChartRedraw request path | `ASC_HudRequestRedraw` | Mark pending. | Redraw spam if overused. | Request counted. |
| ChartRedraw flush path | `ASC_HudFlushPendingRedraw` | One forced redraw if pending. | Blocks UI if repeated. | Flush counted; no-mutation suppressed counted. |
| full render path | `ASC_HudRender` | Builds page scope and object shell state. | Deferred render bottleneck. | Object lifecycle reduced. |
| display-only fast path | `ASC_HudRefreshDisplayOnlyFastPath` | Clock/tactical patch only. | Could use object readbacks. | Clock patch switched to cache test. |
| deferred navigation render path | `ASC_HudServicePriorityNavigation` | Calls `ASC_HudRender`. | Slow if object churn/readback high. | Uses patched object lifecycle. |

# OBJECT CHURN AUDIT

| Operation | Count / Location | Hot Path? | Cost Risk | Patch Needed |
|---|---:|---:|---|---|
| `ObjectCreate` | 3 call sites: rect/label/button ensure helpers | Yes on first shell creation | Queue pressure | Patched cache-first; create only on miss. |
| `ObjectSetInteger` | 27 call sites in ensure helpers | Yes | Queue pressure | Existing signature skip preserved; skip telemetry added. |
| `ObjectSetString` | 6 call sites in ensure helpers | Yes | Queue pressure | Existing signature skip preserved; skip telemetry added. |
| `ObjectSetDouble` | 0 | No | None | None. |
| `ObjectDelete` | shutdown/full delete and fallback unknown object delete | No ordinary nav intended | Queue pressure | Single-delete telemetry added. |
| `ObjectsDeleteAll` | 0 | No | Guard only | Telemetry field added for future proof. |
| `ObjectFind` | miss-only helper after patch | Yes only on first/cache-miss object | Synchronous queue wait | Reduced from every ensure call to cache miss. |
| `ObjectGetInteger` | page-local unknown object type fallback | Rare | Synchronous queue wait | Cached object type added. |
| `ObjectGetString` | 0 | No | None | None. |
| `ObjectGetDouble` | 0 | No | None | None. |
| `ObjectsTotal` | shutdown/full delete only | No ordinary nav | Synchronous enumeration | Counted as readback. |
| `ChartRedraw` | `ASC_HudFlushPendingRedraw` only | Yes | Forced redraw | Batched via request/flush counters. |
| `ChartSetInteger` | 0 | No | None | None. |

# OBJECT REUSE / STABLE SHELL PATCH

| Reuse Strategy | Before | After Patch | Expected Impact | Risk |
|---|---|---|---|---|
| Cache-first shell detection | `ObjectFind()` on every ensure. | Indexed cache checked first; `ObjectFind()` only on miss. | Lower synchronous chart queue waits. | Cache must stay valid. |
| Update text only when changed | Signature skip existed but not measured. | Text skipped-same counter added. | Proves fewer text writes. | Signature correctness required. |
| Update style only when changed | Signature skip existed but not measured. | Style skipped-same counter added. | Proves fewer style writes. | Signature correctness required. |
| Hide inactive controls | Page-local objects hidden by zero-size/text shells. | Uses cached type first, no routine `ObjectGetInteger`. | Less readback during page transitions. | Unknown cached type falls back to property read. |
| Avoid broad delete-all | No `ObjectsDeleteAll()` in HUD. | Guard metric added. | Regression detector. | None. |
| Avoid property readback | `ObjectFind` and object type readback in hot helpers. | Reduced to miss/fallback. | Lower chart queue blocking. | External manual deletion can make cache stale until full rebuild. |

# REDRAW BATCHING PATCH

| Redraw Path | Before | After Patch | Batch Guarantee |
|---|---|---|---|
| Render batch | Request redraw after render mutation, flush once at render end. | Same, now request/flush counted. | One flush per committed render call. |
| Click ack | Ack queues navigation intent and flushes pending transition redraw. | Preserved; request/flush counted. | Ack redraw remains separate from deferred full render. |
| Display-only fast path | Flushed pending redraw. | No-pending/no-mutation suppressions counted. | No mutation means no forced redraw. |
| Object loops | No direct `ChartRedraw()` in ensure loops. | Preserved. | No redraw inside object loops. |

# OBJECT READBACK REDUCTION

| Readback Pattern | Reason Used | Hot Path? | Patch / Justification |
|---|---|---:|---|
| `ObjectFind` in `ASC_HudEnsureRect/Label/Button` | Determine whether shell exists. | Yes | Replaced by cache-first lookup; `ObjectFind` only after cache miss. |
| `ObjectFind` in clock fast patch | Determine whether clock labels exist. | Yes | Replaced with object cache lookup. |
| `ObjectGetInteger(OBJPROP_TYPE)` in page-local hide | Determine object type. | Page transition | Replaced with cached `object_type`; fallback counted only if unknown. |
| `ObjectsTotal/ObjectName` in delete all HUD objects | Full shutdown/init cleanup. | No ordinary nav | Left intact; counted as property readback. |

# HIDDEN CLICK-PATH SYNC AUDIT

| Sync Call | What It Does | Cost Risk | Hot Path? | Patch Needed |
|---|---|---|---:|---|
| `ASC_HudSyncRuntimeSelectedSymbol(runtime,false)` | Finds selected symbol in HUD/L1 cached state, writes `runtime.hud_selected_symbol`, updates observed UTC, optional log suppressed when false. | Lightweight if selected-symbol cache is warm; possible loop over cached symbols if lookup misses. | Yes on symbol-context entry/change. | Same-symbol repeated section-click sync removed; entry/change sync retained because it does not publish artifacts or read files. |

Classification: lightweight runtime selected-symbol pointer/state sync. It does not call FileIO, Dossier writer, Current Focus writer, Market Board refresh, downstream trigger, or artifact publication. RUN103R narrowed it further by not repeating it on same-symbol section clicks.

# HUD TELEMETRY EXTENSION

| Telemetry Field | Present Before | RUN103 Need | Patch |
|---|---:|---|---|
| `object_cache_hit_count` | No | Prove cache reuse. | Added `proof_object_cache_hit_count`. |
| `object_cache_miss_count` | No | Prove miss/readback pressure. | Added `proof_object_cache_miss_count`. |
| `object_text_skipped_same_count` | No | Prove unchanged text skips. | Added. |
| `object_style_skipped_same_count` | No | Prove unchanged style skips. | Added. |
| `object_visibility_skipped_same_count` | No | Prove inactive shell skip behavior. | Added. |
| `object_property_read_count` | Partial | Count synchronous readbacks. | Added. |
| `object_find_count` | No | Count synchronous `ObjectFind`. | Added. |
| `object_delete_all_count` | No | Regression guard. | Added. |
| `object_delete_single_count` | Partial | Count single deletes. | Added. |
| `redraw_request_count` | Partial | Prove batching request pressure. | Added. |
| `redraw_flush_count` | Partial | Prove actual forced redraws. | Added. |
| `redraw_suppressed_no_mutation_count` | No | Prove no-mutation redraw suppression. | Added. |
| `render_scope` | Partial enum state | Log render scope. | Added string proof field. |
| `render_reason` | No | Distinguish heavy/light/navigation/display. | Added. |
| `last_render_mutation_count` | Partial | Expose mutation count. | Added. |
| `last_render_object_cache_hit_ratio` | No | Quick performance ratio. | Added. |

# PATCH CANDIDATE MATRIX

| Candidate | Landed? | Reason |
|---|---:|---|
| Cache-first object shell lookup | Yes | Highest safe reduction in synchronous `ObjectFind` calls. |
| Cached object type for page-local hide | Yes | Avoids routine `ObjectGetInteger` readback. |
| Remove all deletes from page changes | Partial | Known objects are hidden; unknown fallback delete remains. |
| Pre-create all row shells upfront | No | Riskier full rewrite; defer until view-model/cache pass if still needed. |
| Rewrite HUD renderer | No | Too broad for RUN103R. |
| Defer runtime selected-symbol sync completely | No | It is lightweight runtime pointer sync, but same-symbol repeats were removed. |

# PATCH TABLE

| File | Patch | Expected Performance Impact |
|---|---|---|
| `mt5/hud/ASC_HUD_Manager.mqh` | Added `object_type` to HUD object cache entries. | Lets page-local hide use cache instead of `ObjectGetInteger`. |
| `mt5/hud/ASC_HUD_Manager.mqh` | Added tracked object cache lookup and miss-only `ObjectFind`. | Reduces synchronous readback in ordinary render. |
| `mt5/hud/ASC_HUD_Manager.mqh` | Patched rect/label/button ensure helpers to use cache-first object shell detection. | Fewer chart queue waits and less create/recreate churn. |
| `mt5/hud/ASC_HUD_Manager.mqh` | Added text/style/visibility skip counters. | Proves unchanged UI updates are being skipped. |
| `mt5/hud/ASC_HUD_Manager.mqh` | Added redraw request/flush/suppression counters. | Proves redraws are batched and not blindly forced. |
| `mt5/hud/ASC_HUD_Manager.mqh` | Removed repeated same-symbol runtime selected-symbol sync on symbol-context clicks. | Reduces lookup work in symbol detail navigation. |
| `mt5/core/ASC_Version.mqh` | Advanced active run/version macros to RUN103R. | Source identity aligns with patch. |
| roadmap files | Active log, manifest, report updated. | Control surface aligns with package. |

# SOURCE FILES TOUCHED

- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_RUN103R_HUD_OBJECT_LIFECYCLE_REDRAW_REPORT.md`

# PROTECTED AREAS NOT TOUCHED

FileIO, GlobalTop10 rank/order/formula, L3 score formula, L4 rank/order, Market Board order, Dossier writer truth, Current Focus writer truth, strategy/semi-auto/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP were not changed.

# HUD PERFORMANCE ACCEPTANCE UPDATE

| HUD Acceptance Target | RUN102 Source State | RUN103 Source State | RUN105 Target | Proof Method |
|---|---|---|---|---|
| ordinary nav click handler remains fast-path | Ack/deferred render present. | Preserved. | Click feels instant. | `proof_last_click_to_ack_ms`, `proof_last_click_handler_total_ms`. |
| deferred render has lower object create/delete count | Object churn not optimized. | Cache-first create detection and hide-over-delete retained. | Near-zero create/delete after warm shells. | object create/delete telemetry. |
| unchanged updates skip | Signature skip present but under-instrumented. | Text/style/visibility skip counters added. | High skip counts on repeated navigation. | new skip telemetry. |
| redraw flushed once per committed render batch | Request/flush existed. | Request/flush/suppressed counters added. | One flush per render batch when mutated. | redraw telemetry. |
| no broad delete-all in ordinary navigation | No `ObjectsDeleteAll()`. | Preserved and guarded. | Zero. | `object_delete_all_count`. |
| readback reduced or counted | `ObjectFind` in ensure helpers. | Cache-first and counted. | Readbacks near zero after warm cache. | `object_find_count`, `object_property_read_count`. |
| object churn telemetry available | Partial. | Extended. | Used in live proof. | low-frequency proof summary. |
| symbol page transition source path no hidden heavy sync | Current Focus deferred, runtime sync remained. | Runtime sync classified and narrowed. | No file/read-model work in click path. | source audit + RUN104 proof. |

# STATIC COMPILE-SAFETY TABLE

| Static Compile Check | Result | Action |
|---|---|---|
| identifiers under 63 chars | No new long MQL identifiers found; version macro values are strings. | PASS by inspection. |
| no giant new `StringFormat` | New telemetry appended in low-frequency summary; no new giant high-frequency format expansion. | PASS by inspection. |
| no wrong parameter count | `ASC_HudCommitObjectSignature` changed with default third arg; all patched calls compile-shape aligned. | PASS by inspection. |
| no block-scoped variable used outside | New cache variables stay inside helper scope. | PASS by inspection. |
| no missing helper declarations | New helpers are defined before ensure helpers. | PASS by inspection. |
| no include-order break | Only HUD manager/version/control docs changed. | PASS by inspection. |
| no ChartRedraw wrapper signature mismatch | `ASC_HudFlushPendingRedraw()` signature unchanged. | PASS by inspection. |
| no ObjectSet/ObjectGet wrong parameter types | Existing ObjectSet calls preserved; fallback `ObjectGetInteger` unchanged type. | PASS by inspection. |
| no recursive render/service loop | No render call added to click path. | PASS by inspection. |
| no unbounded pending navigation state | RUN102 pending state preserved. | PASS by inspection. |
| no duplicate function names | New helper names unique by grep. | PASS by inspection. |
| no strategy/execution includes touched | None touched. | PASS. |

# REGRESSION GUARD

| Guard | Verdict |
|---|---|
| no strategy/execution | PASS |
| no BUY/SELL / OrderSend / CTrade | PASS |
| no lot sizing | PASS |
| no SL/TP | PASS |
| no GlobalTop10 rank/order/formula change | PASS |
| no L3 score formula change | PASS |
| no L4 rank formula/order change | PASS |
| no Market Board order change | PASS |
| no FileIO rewrite | PASS |
| no HUD truth ownership | PASS — HUD remains read-only consumer. |
| no hidden compute inside HUD | PASS — patch only object lifecycle/telemetry. |
| no broad Dossier rewrite | PASS |
| no broad L5/L6 all-symbol hydration | PASS |

# TRUE ROADMAP PROGRESS UPDATE

RUN103R advances HUD Performance Warpath run 3/5. It does not claim compile/live latency proof. It converts RUN102 event/render decoupling into lower deferred-render object queue pressure by reducing per-render readbacks and unchanged object updates.

# RUN104R NEXT_PROMPT_SEED

Next run: RUN104R / HUD VIEW-MODEL + CACHE + NO FILE READS DURING NAVIGATION.  
First files to read: RUN103R report, RUN103R patched `ASC_HUD_Manager.mqh`, RUN102R report, RUN101R report, `ASC_HUD_ReadModelRenderInput.mqh`, `ASC_MarketBoardWriter.mqh`, `ASC_CurrentFocusWriter.mqh`, `ASC_DossierWriter.mqh`, runtime dispatcher.  
Primary target: prove and remove any file/read-model pulls or heavy data assembly from ordinary navigation and symbol-to-symbol transitions.  
Evidence needed: source grep for FileIO/read functions in HUD paths; proof telemetry for HUD file reads/current focus reads during navigation; static path table for all click controls.  
Proof debt to preserve: compile/live unproven; object cache stale-state risk must be guarded.  
Forbidden drift: FileIO rewrite, rank/order/formula changes, strategy/execution, Market Board order, Current Focus/Dossier truth ownership, hidden HUD compute.

# FINAL DECISION

PASS — RUN103R reduces HUD object lifecycle/redraw/readback pressure by source patch, preserves RUN102 event/render decoupling, classifies hidden runtime selected-symbol sync, extends telemetry, protects non-HUD truth owners, and seeds RUN104R view-model/cache/no-file-read work.
