# TRUTH SEEKER ROADMAP — RUN107A / FULL SYSTEM LATENCY & HUD SLUGGISHNESS ROOT-CAUSE AUDIT

## 1) Scope, method, and hard constraints

- Date: 2026-04-28.
- Run type: forensic audit only (no runtime behavior patch).
- Evidence basis: static source-trace across timer/event dispatch, heartbeat lanes, HUD render/object pipeline, write queue, Current Focus parse/read paths, and latest commit deltas.
- Critical runtime law used for interpretation: MQL5 EA event handlers are single-threaded and sequential, so any long `OnTimer` or `OnChartEvent` handler blocks later events.

## 2) SECTION 1 — FULL HEARTBEAT EXECUTION TRACE

### 2.1 Top-level order (exact code flow)

`OnTimer()` executes in this order:

1. capture timer start + counters.
2. if UI-priority window active and HUD has deferred nav work: `ASC_HudServicePriorityNavigation(...)`.
3. run runtime heartbeat: `ASC_RunHeartbeat(...)`.
4. if priority render was not served, run `ASC_HudOnHeartbeat(...)`; else only `ASC_HudFlushPendingRedraw()`.
5. log function result + timer telemetry.

Source: `mt5/AuroraSentinelCore.mq5` lines 192-243.

### 2.2 HUD priority pre-heartbeat path

`ASC_HudServicePriorityNavigation(...)` path:

- guard rejects if HUD not pending or heavy/queued-heavy states are active.
- builds nav view-model.
- calls full `ASC_HudRender(...)`.
- optionally performs deferred Current Focus sync queueing and **background file read warm** (`ASC_HudReadCurrentFocusFileCached(...)`).
- clears pending transition state and marks service as served.

This means pre-heartbeat “priority” can still include render + optional file I/O and parse work if deferred refresh is active.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 994-1050, 1030-1035.

### 2.3 `ASC_RunHeartbeat(...)` structure

Inside one beat:

- side duties first: forced refresh intake, manual board refresh admission, run-full baseline reconcile, selected-symbol Current Focus reconciliation, cadence reconcile, lane selection.
- compute budget and telemetry frame.
- execute **either scan lane or write lane**.
- refresh summary/counters, scanner status write gate, dossier presence sweep/telemetry, heartbeat telemetry log.

Source: `mt5/runtime/ASC_Dispatcher.mqh` lines 12449-12629.

### 2.4 Scan lane work profile

`ASC_RunScanLane(...)`:

- burst loop over L1 slices (budget-checked per burst).
- L1 refresh + posture update.
- optional L2 companion scan slice with dynamic budget logic.
- on cycle/partial conditions, sets publish flags and can refresh dossier hydration ledger from filesystem + backlog counting.

Worst-case characteristics:

- repeated burst loops + L2 companion loops.
- lane can perform substantial compute before yielding.

Source: `mt5/runtime/ASC_Dispatcher.mqh` lines 10864-11173.

### 2.5 Write lane work profile

`ASC_RunWriteLane(...)` performs, in one beat (admission dependent):

- top10 full-family reconcile + possible batch service.
- deep-trigger write path.
- selected-symbol Current Focus view write path.
- open-symbol snapshot build.
- market board build/publish.
- dossier queue service loop (budget-based, class queues, retries, readback checks).
- manifest publish.

Write lane explicitly includes repeated `ASC_ReadTextFile(...)` checks in multiple branches and can perform many artifact compose/publish operations in one handler call.

Source: `mt5/runtime/ASC_Dispatcher.mqh` lines 11175-12280.

### 2.6 `ASC_HudOnHeartbeat(...)` post-runtime HUD path

When not skipped:

- copies runtime state into HUD state.
- runs clock cadence refresh.
- runs structure/data/tactical fingerprint checks.
- may mark heavy/light dirty and shortlist dirty.
- if dirty, calls full `ASC_HudRender(...)`; else tactical refresh path.
- emits proof summaries + flushes redraw.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 15132-15372.

## 3) SECTION 2 — EVENT QUEUE PRESSURE ANALYSIS

### 3.1 If `OnTimer` exceeds 1 second

Given single-thread event queue semantics and 1-second timer interval (`ASC_HEARTBEAT_SECONDS=1`), an over-budget `OnTimer` delays processing of all other incoming events until it returns. Timers do not provide parallel catch-up execution.

Source: `mt5/core/ASC_Constants.mqh` line 19; timer usage in `mt5/AuroraSentinelCore.mq5` lines 162, 192-243.

### 3.2 Timer skip/coalescing implication for this system

This code instruments `over_budget` but does not introduce alternate catch-up threading (impossible in EA handler model). Therefore, sustained over-budget beats produce effective cadence drift: visual/perceived 1-second tasks become best-effort.

Source: `mt5/AuroraSentinelCore.mq5` lines 224-242.

### 3.3 Chart events under load

`OnChartEvent(...)` is queued behind current handler execution. If a long `OnTimer` is running, click processing waits. If `OnChartEvent` itself is heavy, later timer ticks and further clicks queue behind it.

Source: `mt5/AuroraSentinelCore.mq5` lines 245-253; HUD chart event handler `mt5/hud/ASC_HUD_Manager.mqh` lines 15450-16010.

### 3.4 HUD click wait behavior

HUD clicks are acknowledged quickly in intent (`ASC_HudAckNavigationClick`), but still only after handler entry. So under timer pressure, ack itself is delayed.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 15967-15975.

### 3.5 Multi-click drop/deferral behavior

System explicitly queues guarded nav replay in some transition-guard states (`queued_nav_click_pending`). That mitigates but does not remove queue-pressure delay; it is still serialized.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 15484-15501.

## 4) SECTION 3 — HUD RENDER PATH DEEP TRACE

### 4.1 Entry and classification

`ASC_HudRender(...)` classifies dirty states into navigation-only/light/heavy/layout and computes rebuild requirement from structural revision + nav/layout invalidation.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 13772-13837.

### 4.2 Rebuild triggers

Full rebuild trigger requires heavy processing + structural revision/scope invalidation. It can call:

- `ASC_HudInvalidateSelectedSymbolCache()`
- `ASC_HudRebuildData()`
- `ASC_HudEnsureSelectedDefaults()`
- `ASC_HudRebuildBucketLeadersList()`
- conditional `ASC_HudRebuildSelectedSymbolList()`

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 13800-13823.

### 4.3 Partial/list-sensitive rebuild triggers

Even without full rebuild, heavy mode can rebuild symbol list on sub-bucket change and leaders list when shortlist signature changes.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 13824-13849.

### 4.4 Panel/scope reset work

Scope change path may run full reset or optimized hide/reuse branch. Even optimized branch still performs many panel hide/show/object writes and visibility state transitions.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 13901-13941.

### 4.5 Expensive repeated operations in render

- recurrent `ChartGetInteger(...)` viewport reads each render.
- high-volume `ASC_HudEnsureRect/Label/Button(...)` calls (object mutation heavy).
- extensive string assembly (`StringFormat` and concatenations) for headers/sections.
- list paging + row shell prep when layout changes.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 13851-14011 and broad body rendering region 13943 onward.

### 4.6 Hidden parsing in render-adjacent path

Current Focus VM build invokes repeated labeled value extraction and deep timeframe parser traversal over text blocks when symbol detail contexts are active.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 2998-3015, 3045-3055, 7236-7390.

## 5) SECTION 4 — OBJECT LIFECYCLE PRESSURE

### 5.1 Create/set/delete pattern

Primary object ops:

- create on cache miss: `ObjectCreate(...)` in ensure helpers.
- mutation each changed signature: multiple `ObjectSetInteger/String(...)` per object.
- delete/hide cycles in page cleanup (`ASC_HudDeletePageLocalObjects`).

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 5868-6119, 6296-6340.

### 5.2 Worst-case page switch pressure

On scope/page/viewport changes, HUD can:

- iterate whole object cache,
- resolve unknown object types (potential `ObjectGetInteger` readback),
- hide/reset many objects via ensure helpers (which themselves call multiple sets),
- then render target page objects.

This is high object-command throughput even without hard delete-all.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 6296-6339, 13768-13941.

### 5.3 Reuse effectiveness assessment

Reuse is real but partial:

- signature cache avoids identical writes (good).
- cache miss path still uses `ObjectFind`-like existence probing (`ASC_HudObjectExistsAfterCacheMiss`).
- scoped cleanup often “hides by rewrite” rather than destroy, which avoids create/delete churn but still incurs object set churn.

Conclusion: reuse reduces create/delete counts but does **not** eliminate command-queue pressure from high-volume property sets.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 5838-5850, 5872-5907, 5969-6014, 6296-6330.

## 6) SECTION 5 — REDRAW & VISUAL UPDATE ANALYSIS

### 6.1 Redraw call sites

Central redraw flush path is `ASC_HudFlushPendingRedraw()` → `ChartRedraw(0)` when `redraw_pending` is true.

Called from:

- `OnTick()` after micro-refresh.
- `OnTimer()` when priority render already served.
- end of `ASC_HudOnHeartbeat(...)`.
- several chart-event paths.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 964-981, 15371; `mt5/AuroraSentinelCore.mq5` lines 189, 218; chart-event lines 15515, 15987, 15993.

### 6.2 Batching vs starvation

Design batches redraw via pending flag (good), but redraw execution still depends on handler return path. If long runtime/write work consumes the beat, redraw request waits; thus redraw can be starved by queue pressure.

### 6.3 Too often vs too late

Not primarily “too often”: code suppresses no-mutation redraws.
Primary issue is “too late”: redraw queue flush delayed behind heavy serialized work.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 966-971.

## 7) SECTION 6 — CLOCK FAILURE ROOT CAUSE (DEFINITIVE)

### 7.1 Where clock updates

Clock labels updated in `ASC_HudRefreshClockCadence(...)` (and fast display path) using `ASC_HudSetLabelTextIfExists(...)`, then redraw requested only when not already dirty.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 12502-12542, 12544-12613.

### 7.2 Why it does not visually update every second

Definitive chain:

1. Clock update execution is heartbeat/event-handler dependent (no independent UI thread).
2. If `OnTimer` is delayed/over-budget, clock update call is delayed.
3. If HUD is dirty/heavy, redraw can be postponed until end-of-handler flush.
4. If handler queue is blocked (write lane/top10/dossier loops), visual commit is delayed further.

Therefore clock miss is **not** a clock function bug; it is a symptom of queue blocking + long handler occupancy.

Source: `mt5/AuroraSentinelCore.mq5` lines 192-243; `mt5/runtime/ASC_Dispatcher.mqh` lines 11175-12280; `mt5/hud/ASC_HUD_Manager.mqh` lines 15178-15372, 964-981.

## 8) SECTION 7 — WRITE LANE & BACKGROUND PRESSURE

### 8.1 Heavy components

Highest write-lane pressure contributors:

- Top10 run-full batch service and family promotion logic.
- Market Board compose/publish.
- Dossier queue service loops (queue classes + retries + ledger updates + readback checks).
- Manifest publish.
- Current Focus reconcile/readback and selected-symbol queueing.

Source: `mt5/runtime/ASC_Dispatcher.mqh` lines 11186-11195, 11530-11654, 11718-12167, 12239-12270, 6289-6453.

### 8.2 Runs every beat vs conditional

- Reconcile side duties run every heartbeat before lane execution.
- Write lane can execute repeatedly when `write_dirty` persists and backlog remains.
- Dossier queue service may consume substantial portion of budget each admitted write beat.

### 8.3 UI interaction overlap

No true overlap exists (single-thread). “Overlap” in user perception is actually contention for same event queue time slice: clicks wait behind write lane.

## 9) SECTION 8 — DEEP PARSE / CURRENT FOCUS ANALYSIS

### 9.1 Parse locations and frequency

- VM field extraction via `ASC_HudCurrentFocusValue(...)` invokes label search multiple times.
- Deep section parser scans multiline timeframe section and per-line field extraction for multiple keys.
- These are triggered during VM builds for symbol pages and priority navigation renders when relevant.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 2998-3015, 3045-3055, 7236-7390.

### 9.2 Duplicate/stacked parse costs

- same payload can be traversed repeatedly for different labels.
- row parsing repeatedly calls key extraction on same line.

Cost type is CPU/string-scan heavy (not dominant versus write-lane I/O under worst load, but significant in HUD-heavy symbol workflows).

### 9.3 File-read boundary

Ordinary nav accessor is cache-only, but priority service may invoke background file-cached read when deferred refresh is set.

Source: `mt5/hud/ASC_HUD_Manager.mqh` lines 2899-2905, 1030-1035, 2907-2946.

## 10) SECTION 9 — RECENT COMMIT IMPACT ANALYSIS

### 10.1 What changed recently

Latest commits heavily modified `ASC_HUD_Manager.mqh` with telemetry additions and scope reuse optimization.

- `952c095`: scope-change reuse logic + extra telemetry fields in proof summary.
- `4658b1d`: deep-parse and Current Focus read counters/timing instrumentation.
- `f35703c`: clock/fast-path instrumentation fields and log payload growth.
- `43e1ee3`: broad explicit telemetry counters + compact summary logging emission.

### 10.2 Regression likelihood from these commits

- Instrumentation added counter increments and larger string/log assembly in hot paths (render, heartbeat summary, object helpers).
- This increases per-beat CPU and logging overhead, but likely **secondary** to existing write-lane queue pressure.
- Scope-reuse optimization (`952c095`) is a net mitigation for some page transitions; not a likely primary regression source.

## 11) SECTION 10 — BOTTLENECK MASTER LIST

| Rank | Bottleneck | Location | Type | Impact | Confidence |
|---:|---|---|---|---|---|
| 1 | Write-lane dossier queue + artifact publish workload monopolizes timer beat | `ASC_RunWriteLane` | queue blocking / IO / orchestration | Very high: blocks clicks, redraw, clock visual cadence | High |
| 2 | Serialized event model + long `OnTimer` occupancy | `OnTimer` + `ASC_RunHeartbeat` | orchestration | Very high systemic latency amplifier | High |
| 3 | HUD render object mutation volume on scope/layout changes | `ASC_HudRender` + ensure helpers | object churn / CPU | High on page switches and resize | High |
| 4 | Redraw flush delayed behind heavy handlers | `ASC_HudFlushPendingRedraw` call timing | redraw starvation | High perceived “lag/heavy” effect | High |
| 5 | Deep Current Focus string parse workload in symbol pages | VM/deep parser helpers | parsing / CPU | Medium-high in detail workflows | Medium-High |
| 6 | Telemetry/log string expansion in hot paths | HUD proof/compact summary + click logs | CPU / orchestration | Medium (amplifies existing pressure) | Medium |
| 7 | Top10 run-full batch family service | write lane top10 batch | orchestration / IO | Medium-high during active run-full cycles | Medium-High |

## 12) SECTION 11 — FALSE FIXES (CRITICAL)

1. “Update clock every second directly.”
   - Fails because clock delay is queue-delay; call frequency cannot bypass blocked handler execution.

2. “Add more `ChartRedraw()` calls.”
   - Fails because redraw itself queues/executes in same blocked timeline; can increase pressure.

3. “Optimize HUD only.”
   - Incomplete: major stalls originate in write-lane and heartbeat orchestration, upstream of HUD.

4. “Raise timer frequency.”
   - Counterproductive under overload; creates more scheduling pressure while single-thread bottlenecks remain.

5. “Only cache more object names.”
   - Partial: avoids some existence checks, but dominant cost on churn paths is still mass property set + write lane blockage.

## 13) SECTION 12 — FIRST REPAIR STRATEGY (NO CODE)

### Single highest-leverage first fix

Introduce strict **time-sliced write-lane admission** that hard-caps non-essential write/dossier work per beat when UI-priority or pending HUD render is active, with mandatory early-yield before budget overrun.

### Why this dominates

- It directly shortens `OnTimer` occupancy (root of queue starvation).
- It improves click servicing, deferred render latency, redraw timeliness, and clock visual cadence simultaneously.
- It attacks the broadest shared bottleneck rather than a local HUD symptom.

### Affected surfaces

- write-lane queue service planner,
- dossier class service budget,
- top10/manual refresh admission ordering,
- heartbeat yield policy.

### Risk

- Publication throughput drops short-term.
- Backlog growth risk if caps are too aggressive.
- Must preserve truth/ordering guarantees for essential artifacts.

### Telemetry that would confirm improvement

- `OnTimer` over-budget count trend down.
- heartbeat duration p95 down.
- HUD deferred render wait + click handler latency down.
- redraw flush latency down.
- clock success age near 0-1 sec under steady state.
- backlog stable/declining rather than exploding.

```text
root cause summary: HUD lag is a systemic queue-occupancy symptom, not an isolated HUD drawing defect.
primary bottleneck: write-lane artifact + dossier queue service monopolizing OnTimer under serialized event execution.
secondary bottleneck: HUD object/property mutation volume during scope/layout transitions, amplified by same-thread execution.
queue blocking sources: long ASC_RunWriteLane paths, top10 batch service, dossier queue loops, heavy render passes.
render bottlenecks: full/partial rebuild paths, panel reset/hide cycles, repeated ensure* object mutations, deep parse-driven symbol detail rendering.
object bottlenecks: high ObjectSet throughput on page/scope changes; scoped cleanup still mutates many objects even when reuse is enabled.
write lane impact: directly delays ChartEvent processing, deferred render service, redraw flush, and clock visual updates.
clock failure reason: clock update is heartbeat-bound and redraw-commit-bound; timer overruns and queued handlers prevent true 1Hz visual cadence.
regression source (if any): recent HUD telemetry instrumentation increases hot-path overhead (secondary); dominant systemic pressure already existed in write-lane orchestration.
first recommended fix: enforce strict UI-priority-aware write-lane time slicing with hard early-yield on non-essential queue work.
risk of fix: slower publication throughput / temporary backlog growth if budgets are mis-tuned.
confidence level: high for systemic root cause; medium-high for exact rank split between write-lane vs render within different market/load regimes.
```
