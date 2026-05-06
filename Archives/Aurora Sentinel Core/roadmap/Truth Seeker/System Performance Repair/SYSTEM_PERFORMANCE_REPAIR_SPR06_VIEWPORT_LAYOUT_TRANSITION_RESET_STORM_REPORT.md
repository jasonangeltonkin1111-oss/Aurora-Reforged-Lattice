# SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-06 / VIEWPORT RESIZE + LAYOUT RESET STORM + TRANSITION INVALIDATION REPAIR

## 1. GIT HEADER SUMMARY

SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-06 / VIEWPORT RESIZE + LAYOUT RESET STORM + TRANSITION INVALIDATION REPAIR  
ZIP-FIRST WORKFLOW USED. ROOT DISCOVERY USED BEFORE FILE ACCESS. SOURCE PATCH PRODUCED. COMPILE NOT CLAIMED.

## 2. EXECUTIVE SUMMARY

SPR-06 patches the next HUD-specific pressure seam after SPR-05: chart resize and transition invalidation. The source showed that `CHARTEVENT_CHART_CHANGE` immediately touched HUD object geometry, armed transition state, and later converted the resize into `ASC_HudMarkDirtyDataHeavy()`. That meant a pure viewport/layout event could force heavy data/render behavior and repeated reset pressure.

The patch adds a material viewport-change gate, ignores unchanged/tiny jitter dimensions, defers viewport commit until render, converts consumed chart changes to layout-dirty rather than data-heavy, preserves full-reset fallback for real material viewport changes, and adds compact SPR-06 proof counters.

## 3. ZIP / ROOT / FILE INTAKE SUMMARY

| Item | Discovered Path | Status |
|---|---|---|
| REPO_ROOT | `/mnt/data/spr06_src/Aurora Sentinel Core` | found |
| ASC_ROOT | `/mnt/data/spr06_src/Aurora Sentinel Core` | found |
| AuroraSentinelCore.mq5 | `mt5/AuroraSentinelCore.mq5` | found |
| ASC_Dispatcher.mqh | `mt5/runtime/ASC_Dispatcher.mqh` | found/read-only |
| ASC_HUD_Manager.mqh | `mt5/hud/ASC_HUD_Manager.mqh` | found/patched |
| ASC_RuntimeState.mqh | `mt5/core/ASC_RuntimeState.mqh` | found/read-only |
| ASC_Constants.mqh | `mt5/core/ASC_Constants.mqh` | found/read-only |
| ASC_CurrentFocusWriter.mqh | `mt5/artifacts/ASC_CurrentFocusWriter.mqh` | found/read-only |
| ASC_DossierWriter.mqh | `mt5/artifacts/ASC_DossierWriter.mqh` | found/read-only |
| ASC_MarketBoardWriter.mqh | `mt5/artifacts/ASC_MarketBoardWriter.mqh` | found/read-only |
| ASC_FunctionResults.mqh | `mt5/logging/ASC_FunctionResults.mqh` | found/read-only |
| ASC_FileIO.mqh | `mt5/io/ASC_FileIO.mqh` | found/read-only |
| SPR-02 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR02_WRITE_LANE_TIME_SLICE_REPORT.md` | found |
| SPR-03 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR03_READBACK_MANIFEST_BACKFILL_PRESSURE_REPORT.md` | found |
| SPR-04 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR04_HUD_PRIORITY_CURRENT_FOCUS_CACHE_WARM_REPORT.md` | found |
| SPR-05 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR05_HUD_OBJECT_PROPERTY_CHURN_REDRAW_PRESSURE_REPORT.md` | found |

Discovery evidence used: zip entry listing showed 707 entries; source anchors were found under `Aurora Sentinel Core/mt5/*`; reports were found under `Aurora Sentinel Core/roadmap/Truth Seeker/*`.

## 4. SPR-02 / SPR-03 / SPR-04 / SPR-05 BASELINE VERIFICATION

| Baseline Area | Verified? | Evidence |
|---|---:|---|
| SPR-02 write-lane budget/yield | yes | SPR-02 report present; Dispatcher remains read-only in this pass. |
| SPR-02 no FileIO changes | yes | `ASC_FileIO.mqh` read-only; no patch target touched FileIO. |
| SPR-03 side-duty yield | yes | SPR-03 report present; Dispatcher remains read-only in this pass. |
| SPR-03 compact side-duty telemetry | yes | SPR-03 report present; no log spam restored. |
| SPR-04 Current Focus priority cache-only | yes | HUD still calls cache/navigation-safe path; Current Focus writer read-only. |
| SPR-04 no artifact/truth/schema change | yes | Artifact writers and FileIO not changed. |
| SPR-05 object/property skip counters | yes | `hud_obj_set_skipped`, `hud_obj_set_changed`, `hud_obj_create_reused`, `hud_obj_delete_avoided` preserved. |
| SPR-05 redraw dedupe | yes | `ASC_HudRequestRedraw()` and `ASC_HudFlushPendingRedraw()` retained; only one `ChartRedraw(0)` remains in flush path. |
| SPR-05 clock/full-render avoided proof | yes | `hud_clock_minimal_update` and `hud_full_render_avoided` preserved. |

## 5. SPR-05 COMPILE-SAFETY CHECKPOINT

| Check | Result |
|---|---|
| Brace balance on `ASC_HUD_Manager.mqh` | pass: `{` and `}` counts match. |
| SPR-05 helper/counter names defined and used | pass: SPR-05 counters remain in struct, reset, and summary. |
| Struct fields initialized/reset | pass for SPR-05; SPR-06 fields also added to reset/init. |
| Undefined helper calls from SPR-05 | no new undefined SPR-05 calls observed in this pass. |
| Unknown-to-string risk in SPR-05 proof summary | no new giant `StringFormat`; SPR-05 summary remains string concatenation. |
| Duplicate macros in `ASC_Version.mqh` | no duplicate macro names detected by static grep/awk check. |

## 6. INTERNET RESEARCH CONVERSION TABLE

| Research Finding | Source Constraint | File / Function Target | Patch Decision |
|---|---|---|---|
| `ObjectCreate()` is asynchronous; true means queued, not executed. | Avoid creating/deleting/resetting objects during transient resize noise. | `ASC_HUD_Manager.mqh` / chart-change and render paths | Gate unchanged/jitter viewport events before object mutation. |
| `ObjectSetString()` is asynchronous and enqueues property changes. | Avoid needless label/property updates during resize storms. | `ASC_HudShowDeferredTransition`, chart-change path | Do not call transition/update path for unchanged/jitter resize events. |
| `ChartRedraw()` is a forced redraw, usually used after object property changes. | Keep redraw batched; do not add redraws inside resize/layout loops. | `ASC_HudRequestRedraw`, `ASC_HudFlushPendingRedraw` | Preserve SPR-05 redraw dedupe; no new `ChartRedraw()` added. |
| `CHART_WIDTH_IN_PIXELS`, `CHART_HEIGHT_IN_PIXELS`, and `CHARTEVENT_CHART_CHANGE` are chart-size/property signals. | Chart-change events can be noise; size must be rechecked before reset. | `ASC_HudOnChartEvent`, `ASC_HudConsumeChartChangePending`, `ASC_HudRender` | Add material-change + jitter gate before dirty/full-reset behavior. |

## 7. VIEWPORT / RESIZE DETECTION TRACE

| Viewport Path | File / Function | Trigger | Reads Chart Size? | Marks Layout Dirty? | Full Reset? | Patch Needed? |
|---|---|---|---:|---:|---:|---:|
| Chart event resize path | `ASC_HudOnChartEvent` | `CHARTEVENT_CHART_CHANGE` | yes | previously deferred via pending/heavy path | indirectly yes | patched |
| Debounced resize consume | `ASC_HudConsumeChartChangePending` | heartbeat after debounce | yes after patch | yes, layout only after patch | only material change | patched |
| Render viewport compare | `ASC_HudRender` | render pass | yes | yes only material change | page-local delete only material/non-burst | patched |
| Viewport-dependent layout | layout/render helpers | normal render | consumes stored viewport | no | no | preserved |

## 8. LAYOUT RESET / FULL DELETE TRACE

| Reset Path | File / Function | Trigger | Full Delete? | Scoped Hide? | Cache Invalidate? | Safe to Gate? |
|---|---|---|---:|---:|---:|---:|
| Page-local object delete | `ASC_HudRender` / `ASC_HudDeletePageLocalObjects` | viewport changed outside burst | no full global delete | yes/scoped | limited | yes, gated by material viewport change |
| Panel reset on scope/viewport | `ASC_HudRender` / `ASC_HudResetPanelsForScopeChange` | scope changed or viewport changed | no | yes | limited | yes, only material viewport change |
| Full reset fallback | existing HUD reset/recovery paths | corruption/recovery/material resize | retained | retained | retained | not removed |

## 9. TRANSITION-WINDOW INVALIDATION TRACE

| Transition Path | File / Function | Trigger | Full Render? | Repeats While Stable? | Patch Decision |
|---|---|---|---:|---:|---|
| Pending navigation transition | `ASC_HudServicePriorityNavigation`, heartbeat | navigation click | first transition render only | previously possible when resize pending | preserved and counted |
| Chart resize transition banner | `ASC_HudOnChartEvent` | chart change | only material change after patch | unchanged/jitter avoided | patched |
| Layout dirty repeat | `ASC_HudMarkDirtyLayout` | resize/layout request | layout render only | duplicate dirty counted/skipped | patched |

## 10. CLOCK / STATUS AFTER TRANSITION TRACE

| Clock/Status Path | Trigger | Full Render Forced By Transition? | Minimal Path Preserved? | Patch Needed? |
|---|---|---:|---:|---:|
| Clock minimal update | heartbeat cadence | no when unchanged | yes | no |
| Fast display patch | non-click display event | no when guard clear | yes | no |
| Resize storm | chart-change events | no after unchanged/jitter gate | yes | patched |

## 11. PATCH DETAILS

Changed `mt5/hud/ASC_HUD_Manager.mqh`:

- Added `ASC_HUD_VIEWPORT_JITTER_PX` threshold.
- Added viewport pending/committed fields.
- Added compact SPR-06 telemetry fields.
- Added `ASC_HudViewportMaterialChange()` helper.
- Changed duplicate layout-dirty requests to count `hud_layout_dirty_skipped` instead of repeatedly re-marking layout dirty.
- Changed `ASC_HudConsumeChartChangePending()` to re-read chart size after debounce and return false for unchanged/tiny jitter viewports.
- Changed chart-change event handling to avoid immediate background object mutation and avoid transition redraw when viewport is unchanged/jitter-only.
- Changed heartbeat chart-change consumption from `ASC_HudMarkDirtyDataHeavy()` to `ASC_HudMarkDirtyLayout()`.
- Preserved SPR-05 redraw batching/dedupe.

Changed `mt5/core/ASC_Version.mqh`:

- Updated active version/run tokens from SPR-05 to SPR-06.
- Added SPR-06 scope/boundary/proof/research/patch summary macros.

## 12. VIEWPORT STABILITY POLICY

- Equal dimensions: no layout dirty, no full reset, no object-cache invalidation, no transition banner update.
- Tiny jitter within `ASC_HUD_VIEWPORT_JITTER_PX`: count and ignore.
- Material dimensions: allow debounced layout render and full reset fallback where existing source already requires it.

## 13. TRANSITION INVALIDATION POLICY

- Navigation transition remains cache-first/priority-safe.
- Repeated layout dirty requests are counted and skipped.
- Resize transition banner is only shown for material viewport change.
- Navigation-only dirty state suppresses resize full rebuild and increments `hud_transition_rebuild_avoided`.

## 14. FULL RESET FALLBACK POLICY

Full reset/recovery was not removed. Material viewport changes still allow layout processing and existing scoped reset/delete behavior. Corruption/recovery paths remain untouched.

## 15. REDRAW BATCHING POLICY

No new `ChartRedraw()` calls were added. The only HUD `ChartRedraw(0)` remains inside `ASC_HudFlushPendingRedraw()`, preserving SPR-05 batching and redraw dedupe.

## 16. TELEMETRY ADDED / PRESERVED

Added compact SPR-06 tokens in the low-frequency HUD proof summary:

- `hud_viewport_reset_avoided=`
- `hud_viewport_jitter_ignored=`
- `hud_layout_dirty_skipped=`
- `hud_transition_rebuild_avoided=`
- `hud_full_reset_reason=`
- `hud_layout_commit_count=`
- `hud_transition_commit_count=`

Preserved SPR-05 telemetry:

- `hud_obj_set_skipped=`
- `hud_obj_set_changed=`
- `hud_obj_create_reused=`
- `hud_obj_delete_avoided=`
- `hud_scoped_hide_count=`
- `hud_redraw_avoided=`
- `hud_clock_minimal_update=`
- `hud_full_render_avoided=`

## 17. STALE OBJECT SAFETY GUARD

The patch does not suppress material viewport layout commit. It only suppresses unchanged/tiny jitter chart-change events and duplicate layout-dirty requests. Existing scoped hide/delete and panel reset behavior remains available when material viewport or scope changes occur.

## 18. PROTECTED AREAS NOT TOUCHED

No changes were made to FileIO, artifact writers, ranking/order formulas, trading logic, scan/write/read lane law, heartbeat cadence, Dossier schema, Current Focus truth, Market Board ordering, or HUD operator layout/wording.

## 19. COMPILE / TEST STATUS

Static checks only. MetaEditor compile was not available in this environment, so compile proof is not claimed. Static checks completed:

- HUD brace balance passed.
- SPR-05 helper/counter presence checked.
- SPR-06 helper has prototype before use and definition before later calls.
- `ChartRedraw(0)` remains batched in flush path only.
- `ASC_Version.mqh` duplicate macro check passed.

## 20. CHANGED FILES

- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR06_VIEWPORT_LAYOUT_TRANSITION_RESET_STORM_REPORT.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`

## 21. NEXT PERFORMANCE PROMPT SEED

SPR-07 should audit HUD high-frequency proof/summary string construction and heartbeat proof emission pressure after SPR-05/SPR-06. It must preserve SPR-01 log throttling, SPR-02 write slicing, SPR-03 side-duty yielding, SPR-04 cache-only priority navigation, SPR-05 object/redraw churn counters, and SPR-06 viewport/layout/transition gating. Patch only if string assembly or proof cadence still causes measurable heartbeat pressure.
