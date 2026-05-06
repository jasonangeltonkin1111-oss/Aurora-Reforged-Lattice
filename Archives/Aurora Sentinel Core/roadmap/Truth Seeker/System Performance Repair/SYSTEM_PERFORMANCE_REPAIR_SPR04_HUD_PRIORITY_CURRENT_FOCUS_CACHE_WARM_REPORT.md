# SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-04 / HUD PRIORITY + CURRENT FOCUS CACHE-WARM FILE-READ PRESSURE REPAIR

## 1. GIT HEADER SUMMARY

SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-04 / HUD PRIORITY + CURRENT FOCUS CACHE-WARM FILE-READ PRESSURE REPAIR  
Run type: GPT code-repair source patch  
Boundary: not Truth Seeker main roadmap, not RUN107  
Decision: PASS — source patched, compile/live proof not claimed  
Proof boundary: `SPR04_source_patched_compile_not_claimed_live_not_claimed`

## 2. EXECUTIVE SUMMARY

SPR-04 verified the SPR-02 and SPR-03 performance mini-roadmap baseline, consumed the latest latency audit evidence present in the package, and patched the next pressure seam: `ASC_HudServicePriorityNavigation(...)` still performed deferred Current Focus selected-symbol sync and Current Focus file cache warm after priority render but before the normal heartbeat completed.

The patch makes HUD priority navigation cache-only. It preserves click acknowledgement and priority rendering, but blocks Current Focus file reads, modification-time checks, deep parsing, and selected-symbol Current Focus reconciliation from the immediate priority path. Deferred Current Focus sync/cache warm is now serviced from the normal non-priority heartbeat path via `ASC_HudServiceDeferredCurrentFocusWork(...)`.

## 3. ZIP / ROOT / FILE INTAKE SUMMARY

Commands run during intake:

```bash
pwd
find . -maxdepth 6 -type f \( -name 'AuroraSentinelCore.mq5' -o -name 'ASC_Dispatcher.mqh' -o -name 'ASC_HUD_Manager.mqh' -o -name 'ASC_CurrentFocusWriter.mqh' -o -name 'ASC_FileIO.mqh' -o -name 'ASC_Version.mqh' -o -name 'TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md' -o -name '*SPR*' \) | sort
find . -type f -path '*Aurora Sentinel Core*' | head -300
find . -type f \( -iname '*SPR-02*' -o -iname '*SPR-03*' -o -iname '*WRITE_LANE*' -o -iname '*READBACK*' -o -iname '*MANIFEST*' \) | sort
```

Selected root:

| Item | Discovered Path | Status |
|---|---|---|
| REPO_ROOT | `/mnt/data/spr04_work/extracted/Aurora Sentinel Core` | found |
| ASC_ROOT | `/mnt/data/spr04_work/extracted/Aurora Sentinel Core` | found |
| AuroraSentinelCore.mq5 | `mt5/AuroraSentinelCore.mq5` | found |
| ASC_Dispatcher.mqh | `mt5/runtime/ASC_Dispatcher.mqh` | found |
| ASC_HUD_Manager.mqh | `mt5/hud/ASC_HUD_Manager.mqh` | found |
| ASC_RuntimeState.mqh | `mt5/core/ASC_RuntimeState.mqh` | found |
| ASC_Constants.mqh | `mt5/core/ASC_Constants.mqh` | found |
| ASC_CurrentFocusWriter.mqh | `mt5/artifacts/ASC_CurrentFocusWriter.mqh` | found |
| ASC_DossierWriter.mqh | `mt5/artifacts/ASC_DossierWriter.mqh` | found |
| ASC_MarketBoardWriter.mqh | `mt5/artifacts/ASC_MarketBoardWriter.mqh` | found |
| ASC_FunctionResults.mqh | `mt5/logging/ASC_FunctionResults.mqh` | found |
| ASC_FileIO.mqh | `mt5/io/ASC_FileIO.mqh` | found |
| SPR-02 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR02_WRITE_LANE_TIME_SLICE_REPORT.md` | found |
| SPR-03 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR03_READBACK_MANIFEST_BACKFILL_PRESSURE_REPORT.md` | found |

Additional latest audit evidence found:

- `roadmap/Truth Seeker/TRUTH_SEEKER_RUN107A_FULL_SYSTEM_LATENCY_ROOT_CAUSE_AUDIT.md`
- `FORENSIC_DOSSIER_RUNTIME_AUDIT_2026-04-17.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_RUN001_TO_RUN061_FORENSIC_VERIFICATION_REPORT.md`

## 4. SPR-02 / SPR-03 BASELINE VERIFICATION

| Baseline Area | Verified? | Evidence |
|---|---:|---|
| SPR-02 write-lane budget checks | yes | SPR-02 report present; `ASC_RunWriteLane(...)` retains write budget/yield logic in `ASC_Dispatcher.mqh`. |
| SPR-02 Dossier queue early-yield | yes | Dossier queue still yields before unsafe next symbol/class boundary; no redo in SPR-04. |
| SPR-02 UI-priority write reduction | yes | `ui_priority_write_reduced` and write-yield telemetry preserved in dispatcher/report baseline. |
| SPR-02 immediate Dossier readback behavior | yes | SPR-02 baseline preserved; SPR-03 later adds safe deferral only near budget/UI pressure. |
| SPR-02 FileIO untouched | yes | `mt5/io/ASC_FileIO.mqh` read only; no diff. |
| SPR-03 side-duty yield helper | yes | `ASC_SideDutyShouldYield(...)` remains in `ASC_Dispatcher.mqh`. |
| SPR-03 Dossier readback safe deferral | yes | `readback_deferred/readback_pending` logic remains. |
| SPR-03 manifest/presence/scanner side-duty yield | yes | `manifest_yield`, `sweep_yield`, `side_yield_reason` baseline retained. |
| SPR-03 compact side-duty telemetry | yes | `ASC_PHASE3A_HEARTBEAT_REQUIRED_FIELDS` retains SPR-03 side-duty tokens. |
| FileIO atomic contract | yes | no FileIO edit. |
| Artifact truth/schema/path | yes | no Dossier/Current Focus/Market Board writer or path/schema edits. |
| Ranking/order/formula | yes | no L3/L4/Top10/Market Board order edits. |
| Lane/timer law | yes | heartbeat cadence remains 1 second; no scan/write/read lane-law rewrite. |

## 5. INTERNET RESEARCH CONVERSION TABLE

| Research Finding | Source Constraint | File / Function Target | Patch Decision |
|---|---|---|---|
| MQL5 events are processed sequentially; long handlers delay later events. | Keep `OnChartEvent` and priority pre-heartbeat paths short. | `AuroraSentinelCore.mq5`, `ASC_HUD_Manager.mqh` | Priority path no longer warms Current Focus file or queues Current Focus sync. |
| Timer events are not stacked when a timer event is already queued/processing. | Avoid adding cache-warm/file reads into the timer's priority front. | `OnTimer`, `ASC_HudServicePriorityNavigation` | Move safe Current Focus background work to normal non-priority heartbeat service. |
| Chart/custom events are handled through the chart event queue. | Click acknowledgement must not be blocked by file I/O or deep parse. | `ASC_HudOnChartEvent`, priority render service | Navigation path remains intent/ack/render only; heavy cache refresh remains deferred. |
| Chart object/property commands are queued for the chart. | Do not compensate for slow file/cache work with extra redraw/object churn. | `ASC_HudRender`, `ASC_HudFlushPendingRedraw` | No HUD redesign; no object lifecycle broad rewrite; only cache-warm pressure removed from priority path. |
| `ChartRedraw` is a forced redraw boundary. | Avoid extra redraws as a substitute for removing file work. | `ASC_HudFlushPendingRedraw` | No new redraw spam added. |
| File access / flushing can be expensive enough to affect execution speed. | File reads must stay out of immediate UI path unless explicitly manual/background. | `ASC_HudReadCurrentFocusFileCached` | File-reading accessor remains but is called from manual/background helper, not priority render. |

## 6. HUD PRIORITY / CHART EVENT TRACE

| Step | File / Function | Runs In ChartEvent / Priority Path? | File Read? | Deep Parse? | Object Ops? | Blocks Click? |
|---|---|---:|---:|---:|---:|---:|
| Chart event entry | `AuroraSentinelCore.mq5::OnChartEvent` | ChartEvent | no | no | no | bounded by existing event queue only |
| HUD click handling | `ASC_HudOnChartEvent(...)` | ChartEvent | no direct file read found | no deep Current Focus parse found | minimal ack/redraw only | after patch still fast ack path |
| Navigation intent | `ASC_HudQueueNavigationIntent(...)` | ChartEvent | no | no | no | no file block |
| Priority render service | `ASC_HudServicePriorityNavigation(...)` | pre-heartbeat priority | **no after SPR-04** | **no after SPR-04** | render object ops only | no file/cache warm block |
| Selected-symbol Current Focus sync | formerly called in priority service | was priority path | no file read but runtime side-duty queue | no | no | **deferred after SPR-04** |
| Current Focus cache warm | formerly `ASC_HudReadCurrentFocusFileCached(..., "background")` in priority service | was priority path | **yes before / no after** | yes if fresh payload parsed | no | **removed from priority path** |
| Redraw flush | `ASC_HudFlushPendingRedraw()` | ChartEvent/Timer | no | no | `ChartRedraw` only if pending | unchanged |

## 7. CURRENT FOCUS READ / CACHE-WARM TRACE

| Current Focus Path | File / Function | Trigger | File Read? | Cache Only? | Safe to Defer? | Patch Decision |
|---|---|---|---:|---:|---:|---|
| Render/navigation read | `ASC_HudReadCurrentFocusCached(...)` | symbol detail render | no | yes | n/a | preserved cache-only accessor. |
| Manual refresh read | `ASC_HudReadCurrentFocusText(...)` -> `ASC_HudReadCurrentFocusFileCached(...,"manual")` | explicit/manual | yes | no | no if explicitly requested | preserved. |
| Background warm read | `ASC_HudReadCurrentFocusFileCached(...,"heartbeat_background")` | normal heartbeat helper | yes | no | yes | moved from priority service to normal non-priority heartbeat path. |
| Priority service warm | old `ASC_HudServicePriorityNavigation(...)` | priority render | yes before | no | yes | removed/deferred. |
| Selected-symbol sync | `ASC_HudQueueViewedCurrentFocusSync(...)` | symbol context entry | no direct file read | runtime flags | yes | priority service no longer queues it; helper services later. |
| Missing/stale cache | `ASC_HudCurrentFocusNavigationSafe(...)` | navigation/render | no | yes | yes | displays missing/stale/pending posture and marks refresh pending. |

## 8. HUD PARSE / STRING EXTRACTION TRACE

| Parser / Extractor | File / Function | Trigger | Runs During Render? | Runs During Click? | Cacheable? | Patch Decision |
|---|---|---|---:|---:|---:|---|
| Label extraction | `ASC_HudExtractLabeledValue(...)` | Current Focus VM build | only when VM build receives fresh payload | no direct click path | yes | parse remains associated with cache refresh/VM build, not priority click path. |
| Current Focus field selection | `ASC_HudCurrentFocusValue(...)` | VM build | yes only during VM build | no | yes | preserved. |
| Deep timeframe extraction | `ASC_HudBuildDeepSectionViewModel(...)` | VM build | yes only after file refresh | no | yes | added timing telemetry; deferred counter increments when cache refresh deferred. |
| Dossier deep truth check | `ASC_DossierDeepSectionHasCompletedTruth(text)` | VM build | yes only after payload present | no | yes | unchanged truth function; not moved into click path. |
| Navigation VM | `ASC_HudBuildNavigationViewModel(...)` | priority render | yes | no | already prepared | remains lightweight/cache-status only. |

## 9. HUD OBJECT / REDRAW PRESSURE CHECK

| HUD Visual Work | File / Function | Trigger | Object Ops | Redraw? | Needs Patch Now? |
|---|---|---|---|---:|---:|
| Priority render | `ASC_HudRender(...)` | pre-heartbeat priority | existing object ensure/set path | existing batched redraw | no broad rewrite in SPR-04 |
| Ack label | `ASC_HudAckNavigationClick(...)` | ChartEvent | minimal label/redraw path | flush if pending | no |
| Redraw boundary | `ASC_HudFlushPendingRedraw()` | tick/timer/event | no file work | `ChartRedraw(0)` if pending | no new redraw spam added |
| Object lifecycle | HUD ensure/hide helpers | render | existing object queue pressure | batched | future target only if still slow after file/cache patch |

## 10. PATCH DETAILS

Changed `mt5/hud/ASC_HUD_Manager.mqh`:

- Added SPR-04 telemetry counters:
  - `hud_click_file_read_blocked_count`
  - `hud_priority_cache_only_count`
  - `current_focus_refresh_deferred_count`
  - `current_focus_cache_stale_count`
  - `deep_parse_deferred_count`
  - `hud_cache_refresh_pending_count`
  - `hud_priority_render_last_ms`
- Added `ASC_HudServiceDeferredCurrentFocusWork(...)`.
- Removed `ASC_HudQueueViewedCurrentFocusSync(...)` from the priority service hot path.
- Removed `ASC_HudReadCurrentFocusFileCached(...,"background")` from priority service hot path.
- Priority service now records cache-only/pending telemetry instead of performing file reads/cache warm.
- Current Focus refresh/deep-parse pending states remain truthful via stale/missing/pending cache posture.
- Added deep parse timing around `ASC_HudBuildDeepSectionViewModel(...)`.

Changed `mt5/AuroraSentinelCore.mq5`:

- Normal non-priority heartbeat now calls `ASC_HudServiceDeferredCurrentFocusWork(g_runtime_state, true, "heartbeat_background")` before `ASC_HudOnHeartbeat(...)`.
- Priority-served beats still skip this background work, keeping click-response path clean.

Changed `mt5/core/ASC_Constants.mqh`:

- Extended `ASC_PHASE3A_HEARTBEAT_REQUIRED_FIELDS` with SPR-04 HUD/cache proof tokens.

Changed `mt5/core/ASC_Version.mqh`:

- Advanced source identity to SPR-04.
- Added SPR-04 scope/boundary/proof/research/patch summary macros.

## 11. CURRENT FOCUS CACHE POLICY

- Navigation/render uses `ASC_HudReadCurrentFocusCached(...)`, which is cache-only.
- Manual/background refresh uses `ASC_HudReadCurrentFocusFileCached(...)`.
- Missing cache displays unavailable/pending posture instead of blocking.
- Stale cache displays stale posture and schedules background refresh.
- Priority render does not read file metadata, read Current Focus text, or parse Current Focus text.
- Background refresh remains safe and explicit from normal non-priority heartbeat/manual paths.

## 12. DEEP PARSE DEFERRAL POLICY

- Deep parse remains bound to fresh payload/cache refresh, not click path.
- Navigation cache miss/stale states increment `deep_parse_deferred_count`.
- Deep parse timing now records last/max elapsed when `ASC_HudBuildDeepSectionViewModel(...)` runs.
- Repeated priority renders consume prepared VM/cache state rather than reparsing payload text.

## 13. TELEMETRY ADDED / PRESERVED

Added compact tokens:

- `hud_click_file_read_blocked=`
- `hud_priority_cache_only=`
- `current_focus_refresh_deferred=`
- `current_focus_cache_stale=`
- `deep_parse_deferred=`
- `hud_priority_render_ms=`
- `hud_cache_refresh_pending=`

Preserved:

- SPR-01 throttling / no log spam restoration.
- SPR-02 write-yield telemetry.
- SPR-03 side-duty telemetry.
- Existing object/redraw/cache telemetry.

## 14. STALE / PENDING TRUTH GUARD

The patch does not display stale Current Focus as fresh. It preserves and reinforces cache states:

- `fresh`
- `stale`
- `missing`
- `pending`
- `refresh_deferred`
- `manual_refresh_required`

When priority render blocks a file read, it increments pending/cache-only telemetry and leaves cache posture truthful.

## 15. PROTECTED AREAS NOT TOUCHED

- No trading logic changed.
- No entries/signals/lot sizing/SL/TP/order path changed.
- No L3 score formula changed.
- No L4 rank/order/correlation formula changed.
- No Top3/Top5/Top10 order changed.
- No Market Board ordering changed.
- No Dossier/Current Focus/Market Board truth schema changed.
- No artifact path changed.
- No FileIO atomic contract changed.
- No heartbeat cadence changed.
- No scan/write/read lane law changed.
- No HUD layout redesign.
- No SPR-01/SPR-02/SPR-03 redo.

## 16. COMPILE / TEST STATUS

Static/source checks completed:

```bash
sed -n '994,1068p' mt5/hud/ASC_HUD_Manager.mqh | rg 'ASC_ReadTextFile|ASC_HudReadCurrentFocusFileCached|FileRead|ASC_HudQueueViewedCurrentFocusSync'
rg -n 'ASC_HudReadCurrentFocusFileCached|ASC_ReadTextFile|ASC_FileTryGetModifyUtc' mt5/hud/ASC_HUD_Manager.mqh
rg -n 'ASC_HudServiceDeferredCurrentFocusWork|hud_click_file_read_blocked|hud_priority_cache_only|current_focus_refresh_deferred|current_focus_cache_stale|deep_parse_deferred|hud_priority_render_ms|hud_cache_refresh_pending' mt5/hud/ASC_HUD_Manager.mqh mt5/AuroraSentinelCore.mq5 mt5/core/ASC_Constants.mqh mt5/core/ASC_Version.mqh
```

Result:

- Priority service block has no `ASC_ReadTextFile`, no `ASC_HudReadCurrentFocusFileCached`, no direct `FileRead`, and no `ASC_HudQueueViewedCurrentFocusSync` call after patch.
- Current Focus file-read accessor still exists for manual/background refresh only.
- MetaEditor compile was not available in this environment. Compile proof and live proof are not claimed.

## 17. CHANGED FILES

- `mt5/AuroraSentinelCore.mq5`
- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/core/ASC_Constants.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR04_HUD_PRIORITY_CURRENT_FOCUS_CACHE_WARM_REPORT.md`

## 18. NEXT PERFORMANCE PROMPT SEED

SPR-05 should audit remaining HUD object/property churn and redraw command pressure after SPR-04. It must not change layout, truth ownership, ranking/order, artifact schema/path, FileIO atomic contract, or heartbeat cadence. Focus only on proving whether page switch latency is now dominated by object command volume, viewport reads, or dirty-scope rebuilds, and patch the smallest safe object/update batching seam if static evidence proves it.
