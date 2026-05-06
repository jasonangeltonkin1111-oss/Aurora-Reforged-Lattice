# SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-05 / HUD OBJECT PROPERTY CHURN + REDRAW PRESSURE REPAIR

## 1. GIT HEADER SUMMARY

SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-05 / HUD OBJECT PROPERTY CHURN + REDRAW PRESSURE REPAIR
GPT CODE-REPAIR RUN
NOT PART OF TRUTH SEEKER MAIN ROADMAP
NOT RUN107
ZIP-FIRST WORKFLOW USED
ROOT DISCOVERY COMPLETED BEFORE FILE ACCESS
SPR-02 / SPR-03 / SPR-04 REPORTS READ BEFORE PATCH
INTERNET RESEARCH COMPLETED AGAINST OFFICIAL MQL5 DOCS
SOURCE PATCH APPLIED
NO REPORT-ONLY SUCCESS
NO VERSION-ONLY SUCCESS
NO AUDIT-ONLY SUCCESS
NO HUD LAYOUT REDESIGN
NO TRADING LOGIC / RANKING / ARTIFACT TRUTH / FILEIO / LANE / TIMER CHANGE

## 2. EXECUTIVE SUMMARY

SPR-05 patches the next HUD-specific pressure seam after SPR-04. Existing HUD object signature skip logic was preserved and instrumented more explicitly. Redundant redraw requests are now deduped when a redraw is already pending, unchanged-object skips are surfaced with compact SPR-05 counters, object-cache reuse is counted, scoped page-local hides are counted as delete-avoided events, and clock/status minimal updates now expose proof that they avoided full render pressure.

The patch is intentionally narrow. It does not redesign the HUD, change operator wording, change ranking/order, change Dossier / Current Focus / Market Board truth, change FileIO, change heartbeat cadence, or alter scan/write/read lane law.

## 3. ZIP / ROOT / FILE INTAKE SUMMARY

| Item | Discovered Path | Status |
|---|---|---|
| REPO_ROOT | `/mnt/data/spr05_work/Aurora Sentinel Core` | found |
| ASC_ROOT | `/mnt/data/spr05_work/Aurora Sentinel Core` | found |
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
| SPR-02 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR02_WRITE_LANE_TIME_SLICE_REPORT.md` | found/read |
| SPR-03 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR03_READBACK_MANIFEST_BACKFILL_PRESSURE_REPORT.md` | found/read |
| SPR-04 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR04_HUD_PRIORITY_CURRENT_FOCUS_CACHE_WARM_REPORT.md` | found/read |

Discovery commands used: `pwd`, maxdepth anchor search for expected MQL/control/SPR files, full recursive `Aurora Sentinel Core` path search, and exact/phrase-oriented SPR/HUD/CACHE searches.

## 4. SPR-02 / SPR-03 / SPR-04 BASELINE VERIFICATION

| Baseline Area | Verified? | Evidence |
|---|---:|---|
| SPR-02 write-lane budget checks | yes | SPR-02 report states write-lane near-budget guards were added and no heartbeat/lane semantics changed. |
| SPR-02 Dossier queue early-yield | yes | SPR-02 report records Dossier queue early-yield before next symbol/class boundary after bounded progress. |
| SPR-02 UI-priority write reduction | yes | SPR-02 report records Top10 side-duty/UI-priority deferral and compact yield telemetry. |
| SPR-02 FileIO untouched | yes | `ASC_FileIO.mqh` was read-only in SPR-05 and not changed. |
| SPR-03 side-duty yield helper | yes | SPR-03 baseline preserved in dispatcher; no dispatcher edits were made in SPR-05. |
| SPR-03 Dossier readback safe deferral | yes | SPR-03 report/control baseline found; SPR-05 did not alter readback state. |
| SPR-03 manifest/presence/scanner side-duty yield | yes | SPR-03 report/control baseline found; no manifest/presence/scanner code was changed. |
| SPR-03 compact side-duty telemetry | yes | No logging schema or FunctionResults changes were made. |
| SPR-04 Current Focus priority cache-only behavior | yes | SPR-04 report confirms priority service no longer reads Current Focus file/cache warm/deep parse; SPR-05 did not edit that path. |
| SPR-04 stale/pending/missing posture | yes | HUD cache-only display semantics left untouched. |
| Artifact truth/schema/path | yes | Dossier, Current Focus, Market Board writer files were read-only. |
| Lane/timer law | yes | `AuroraSentinelCore.mq5` and dispatcher remained unedited. |
| HUD redesign absent | yes | Only telemetry/redraw request dedupe/object-cache proof counters were patched. |

## 5. INTERNET RESEARCH CONVERSION TABLE

| Research Finding | Source Constraint | File / Function Target | Patch Decision |
|---|---|---|---|
| `ObjectCreate()` is asynchronous; `true` only means the command was added to the chart queue. | Avoid unnecessary object create commands and prove reuse instead of recreating. | `ASC_HudEnsureRect`, `ASC_HudEnsureLabel`, `ASC_HudEnsureButton` | Count cache reuse with `hud_obj_create_reused=` and preserve existing create-on-miss behavior only. |
| Object property changes are processed through the chart event/operation queue with delay. | Unchanged property writes should remain skipped through signatures and be visible in telemetry. | object ensure helpers and `ASC_HudSetLabelTextIfExists` | Preserve signature skip policy and add `hud_obj_set_skipped=` / `hud_obj_set_changed=` proof tokens. |
| `ChartRedraw()` is a forced redraw boundary usually used after object-property changes. | Do not call redraw inside inner loops; redraw should be batched and skipped if nothing changed. | `ASC_HudRequestRedraw`, `ASC_HudFlushPendingRedraw`, `ASC_HudRender` | Deduplicate redraw requests while one is pending; count `hud_redraw_avoided=`. |
| Chart operations are queued; several property changes should be made first, then redrawn once. | Batched chart work is preferable to repeated redraw flush pressure. | render end / clock update path | Existing end-of-render flush remains; no inner-loop `ChartRedraw` added. |
| ChartSet-style docs describe asynchronous queue execution and recommend one `ChartRedraw()` after several changes. | Mutations must be grouped; request flags are cheaper than repeated forced redraw boundaries. | redraw request/flush path | Kept one flush boundary and avoided duplicate pending requests. |

## 6. HUD OBJECT CREATION / UPDATE / DELETE TRACE

| HUD Object Path | File / Function | Trigger | ObjectCreate? | ObjectSet? | ObjectDelete? | Cache/Skip Present? | Patch Needed? |
|---|---|---|---:|---:|---:|---:|---:|
| Rectangle shells/cards | `ASC_HudEnsureRect` | render/page/hide | yes on miss | yes on changed signature | no | yes | patched telemetry/reuse proof |
| Labels/text | `ASC_HudEnsureLabel` | render/page/hide | yes on miss | yes on changed signature | no | yes | patched telemetry/reuse proof |
| Buttons | `ASC_HudEnsureButton` | nav/action/footer rows | yes on miss | yes on changed signature | no | yes | patched telemetry/reuse proof |
| Minimal label text | `ASC_HudSetLabelTextIfExists` | clock/tactical patches | no | text only | no | yes | patched skip/change counters |
| Full reset delete | `ASC_HudDeleteObjects` | viewport/layout reset | no | no | yes | clears cache | retained fallback |
| Page-local cleanup | `ASC_HudDeletePageLocalObjects` | page/scope transition | no | hide via ensure for known types | only unknown types | yes | patched delete-avoided/hide counters |
| Object cache lookup | `ASC_HudFindObjectCacheTracked` | all ensures | no | no | no | yes | preserved |
| Object signature skip | `ASC_HudCommitObjectSignature` | all ensures | no | no when unchanged | no | yes | preserved and measured |

## 7. PAGE SWITCH OBJECT CHURN TRACE

| Page Transition | Rebuild Type | Object Count Estimate | Property Writes | Redraw | Churn Risk |
|---|---|---:|---:|---:|---|
| overview → bucket page | render batch + page-local cleanup | medium/high | signature-skipped where unchanged | one flush after batch | medium |
| bucket → sub-bucket page | render batch + page-local hide | medium/high | signature-skipped | one flush after batch | medium |
| sub-bucket → symbols page | symbol list row render | high | row/card/button changed-only signatures | one flush after batch | high |
| symbols → symbol detail page | detail surface render | high | detail labels/cards changed-only signatures | one flush after batch | high |
| detail → back / next / prev | navigation render | medium/high | cache reuse + signature skip | one flush after batch | medium |
| resize/layout reset | full reset fallback | high | forced rebuild | one flush after rebuild | accepted fallback |

## 8. REDRAW PRESSURE TRACE

| Redraw Path | File / Function | Trigger | Inside Loop? | Batched? | Patch Needed? |
|---|---|---|---:|---:|---:|
| Redraw request | `ASC_HudRequestRedraw` | render/clock/tactical changed | no | yes | patched duplicate-pending suppression |
| Redraw flush | `ASC_HudFlushPendingRedraw` | render end / service boundary | no | yes | patched no-pending/no-mutation avoided count |
| ChartRedraw | `ASC_HudFlushPendingRedraw` | pending redraw only | no | yes | preserved |
| Priority navigation render | `ASC_HudServicePriorityNavigation` → render | click navigation | no | yes | SPR-04 cache-only preserved |
| Clock update | `ASC_HudRefreshClockCadence` / fast display path | cadence tick | no | minimal label path | patched minimal-update proof |

## 9. CLOCK / STATUS MINIMAL UPDATE TRACE

| Clock/Status Path | File / Function | Full Render Required? | Object Writes | Redraw Needed? | Patch Decision |
|---|---|---:|---:|---:|---|
| Header clock text | `ASC_HudRefreshClockCadence` | no when cache valid | text only | only when changed and HUD not dirty | preserved + proof counter |
| Header clock meta | `ASC_HudRefreshClockCadence` | no when cache valid | text only | only when changed and HUD not dirty | preserved + proof counter |
| Overview clock text | `ASC_HudRefreshClockCadence` | no when cache valid | text only | only when changed and HUD not dirty | preserved + proof counter |
| Display-only fast path clock | `ASC_HudRefreshDisplayOnlyFastPath` | no under committed-context guard | text only | existing path | proof counter added |

## 10. PATCH DETAILS

- Added compact SPR-05 HUD counters to `ASC_HudState`.
- Added pending-redraw dedupe in `ASC_HudRequestRedraw()` so repeated requests before flush do not inflate redraw pressure counters.
- Added no-pending/no-mutation `hud_redraw_avoided=` accounting in `ASC_HudFlushPendingRedraw()`.
- Added object-cache reuse proof for rect/label/button ensure paths.
- Added explicit changed/skipped object-set accounting around existing signature skip behavior.
- Added scoped hide/delete-avoided counters to page-local cleanup.
- Added clock minimal update/full-render avoided counters to clock cadence and display-only fast-path clock updates.
- Added compact SPR-05 proof token block to HUD proof summary.
- Bumped `ASC_Version.mqh` to SPR-05 and added SPR-05 source identity macros.

## 11. OBJECT SIGNATURE / SKIP POLICY

Existing object signature skip remains authoritative:

- Rectangles skip all property writes when `x|y|w|h|fill|border` signature is unchanged.
- Labels skip all property writes when `x|y|size|color|text` signature is unchanged.
- Buttons skip all property writes when `x|y|w|h|bg|border|textColor|caption` signature is unchanged.
- Clock/status text uses `ASC_HudSetLabelTextIfExists(...)` to update text only and skip if unchanged.

SPR-05 makes the skip visible via `hud_obj_set_skipped=` without introducing object reads in hot loops.

## 12. OBJECT LIFECYCLE / REUSE POLICY

- Object names and layout are unchanged.
- Existing cache lookup remains the hot path.
- Existing create-on-miss behavior remains.
- Existing page-local cleanup still hides known page objects instead of deleting them.
- Full delete/reset remains available for viewport/layout reset and corruption recovery.
- SPR-05 adds `hud_obj_create_reused=`, `hud_obj_delete_avoided=`, and `hud_scoped_hide_count=` to prove reuse/hide behavior without adding per-object log spam.

## 13. REDRAW BATCHING POLICY

- No `ChartRedraw()` was added inside any row/control/object loop.
- `ChartRedraw()` remains centralized in `ASC_HudFlushPendingRedraw()`.
- Duplicate pending redraw requests are now ignored and counted as avoided.
- No redraw occurs when no redraw is pending and no mutations exist.

## 14. TELEMETRY ADDED / PRESERVED

Added compact tokens:

- `hud_obj_set_skipped=`
- `hud_obj_set_changed=`
- `hud_obj_create_reused=`
- `hud_obj_delete_avoided=`
- `hud_scoped_hide_count=`
- `hud_redraw_avoided=`
- `hud_clock_minimal_update=`
- `hud_full_render_avoided=`

Preserved existing SPR-01/SPR-02/SPR-03/SPR-04 telemetry; no per-object spam added.

## 15. STALE OBJECT SAFETY GUARD

- Full reset fallback remains in `ASC_HudDeleteObjects()`.
- Page-local cleanup still hides known object types and deletes only unknown/unsupported page-local objects.
- Object cache is still invalidated after actual delete or full reset.
- No chart-object scanning was added to hot render loops.

## 16. PROTECTED AREAS NOT TOUCHED

Not changed:

- Trading logic, entries, lot sizing, SL/TP, `OrderSend` / `CTrade` paths.
- Ranking formulas, L3 score, L4 ordering, Top3/Top5/Top10 order, Market Board order.
- Dossier content/schema/truth, Current Focus derivative truth, Market Board truth.
- Artifact paths or schema.
- FileIO atomic write contract.
- Dispatcher/write/read/scan lane law.
- Heartbeat cadence or runtime lanes.
- HUD layout/operator wording.

## 17. COMPILE / TEST STATUS

- Static brace balance check on `ASC_HUD_Manager.mqh`: pass (`brace_balance 0`).
- Diff inspection completed against extracted original.
- MetaEditor compile was not available in this environment; compile proof is not claimed.
- Runtime/live performance proof is not claimed.

## 18. CHANGED FILES

- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR05_HUD_OBJECT_PROPERTY_CHURN_REDRAW_PRESSURE_REPORT.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`

## 19. NEXT PERFORMANCE PROMPT SEED

SPR-06 should audit the next remaining HUD pressure seam only after SPR-05 is compile-verified: viewport resize/layout reset storms and transition-window invalidation frequency. It must not touch trading truth, ranking/order, FileIO, artifact schema, lane/timer law, or HUD layout redesign.
