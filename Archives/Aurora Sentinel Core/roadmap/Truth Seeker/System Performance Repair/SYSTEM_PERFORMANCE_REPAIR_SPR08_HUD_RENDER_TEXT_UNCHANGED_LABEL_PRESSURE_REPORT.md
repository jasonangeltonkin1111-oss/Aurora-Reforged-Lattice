# SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-08 / HUD PAGE RENDER TEXT CONSTRUCTION + UNCHANGED LABEL UPDATE PRESSURE REPAIR

## 1. GIT HEADER SUMMARY

SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-08 / HUD PAGE RENDER TEXT CONSTRUCTION + UNCHANGED LABEL UPDATE PRESSURE REPAIR  
GPT CODE-REPAIR PROMPT  
NOT PART OF TRUTH SEEKER MAIN ROADMAP  
NOT RUN107  
ZIP-FIRST WORKFLOW USED  
ROOT DISCOVERY USED BEFORE FILE ACCESS  
SPR-07 COMPILE-SAFETY CHECKPOINT PERFORMED STATICALLY  
SOURCE PATCH APPLIED  
COMPILE CLAIM NOT MADE  
LIVE CLAIM NOT MADE

## 2. EXECUTIVE SUMMARY

SPR-08 patches the remaining HUD ordinary-render pressure seam without changing HUD layout, operator wording, truth ownership, ranking/order, artifacts, FileIO, heartbeat cadence, or scan/write/read lane law.

The patch adds compact proof counters and makes three narrow reductions:

1. The existing visible row render signature now explicitly counts and proves row/card text cache hits when the row page is unchanged, avoiding repeated row title/summary/detail/chip/button text rebuilds.
2. `ASC_HudSetLabelTextIfExists(...)` now records unchanged label text skips when the local object-signature cache proves the final text is unchanged, without `ObjectGetString()` hot-path reads.
3. Clock/display-only paths now return early when the already-visible UTC second is unchanged, avoiding status/meta string construction and label updates for duplicate same-second beats.

No `ChartRedraw()` call was added. The only existing `ChartRedraw(0)` remains in the batched redraw flush path.

## 3. ZIP / ROOT / FILE INTAKE SUMMARY

Discovery commands executed from `/mnt/data/spr08_work/extracted`:

```bash
pwd
find . -maxdepth 6 -type f \( -name 'AuroraSentinelCore.mq5' -o -name 'ASC_Dispatcher.mqh' -o -name 'ASC_HUD_Manager.mqh' -o -name 'ASC_FunctionResults.mqh' -o -name 'ASC_FileIO.mqh' -o -name 'ASC_Version.mqh' -o -name 'TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md' -o -name '*SPR*' \) | sort
find . -type f -path '*Aurora Sentinel Core*' | head -300
find . -type f \( -iname '*SPR-02*' -o -iname '*SPR-03*' -o -iname '*SPR-04*' -o -iname '*SPR-05*' -o -iname '*SPR-06*' -o -iname '*SPR-07*' -o -iname '*HUD*' -o -iname '*PROOF*' -o -iname '*SUMMARY*' \) | sort
```

Selected `REPO_ROOT`: `/mnt/data/spr08_work/extracted/Aurora Sentinel Core`  
Selected `ASC_ROOT`: `/mnt/data/spr08_work/extracted/Aurora Sentinel Core`

| Item | Discovered Path | Status |
|---|---|---|
| REPO_ROOT | `/mnt/data/spr08_work/extracted/Aurora Sentinel Core` | found |
| ASC_ROOT | `/mnt/data/spr08_work/extracted/Aurora Sentinel Core` | found |
| AuroraSentinelCore.mq5 | `mt5/AuroraSentinelCore.mq5` | found/read-only |
| ASC_Dispatcher.mqh | `mt5/runtime/ASC_Dispatcher.mqh` | found/read-only |
| ASC_HUD_Manager.mqh | `mt5/hud/ASC_HUD_Manager.mqh` | found/changed |
| ASC_RuntimeState.mqh | `mt5/core/ASC_RuntimeState.mqh` | found/read-only |
| ASC_Constants.mqh | `mt5/core/ASC_Constants.mqh` | found/read-only |
| ASC_FunctionResults.mqh | `mt5/logging/ASC_FunctionResults.mqh` | found/read-only |
| ASC_FileIO.mqh | `mt5/io/ASC_FileIO.mqh` | found/read-only |
| ASC_Version.mqh | `mt5/core/ASC_Version.mqh` | found/changed |
| SPR-02 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR02_WRITE_LANE_TIME_SLICE_REPORT.md` | found |
| SPR-03 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR03_READBACK_MANIFEST_BACKFILL_PRESSURE_REPORT.md` | found |
| SPR-04 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR04_HUD_PRIORITY_CURRENT_FOCUS_CACHE_WARM_REPORT.md` | found |
| SPR-05 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR05_HUD_OBJECT_PROPERTY_CHURN_REDRAW_PRESSURE_REPORT.md` | found |
| SPR-06 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR06_VIEWPORT_LAYOUT_TRANSITION_RESET_STORM_REPORT.md` | found |
| SPR-07 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR07_HUD_PROOF_SUMMARY_HEARTBEAT_PROOF_PRESSURE_REPORT.md` | found |

## 4. SPR-02 / SPR-03 / SPR-04 / SPR-05 / SPR-06 / SPR-07 BASELINE VERIFICATION

| Baseline Area | Verified? | Evidence |
|---|---:|---|
| SPR-02 write-lane budget/yield logic | yes | SPR-02 report present; dispatcher left read-only in SPR-08. |
| SPR-02 Dossier queue early-yield | yes | SPR-02 report present; no Dossier writer or dispatcher edits in SPR-08. |
| SPR-02 UI-priority write reduction | yes | SPR-02 report present; no write-lane edits in SPR-08. |
| SPR-03 side-duty yield helper | yes | SPR-03 report present; dispatcher side-duty path left read-only. |
| SPR-03 readback/manifest/presence safe deferral | yes | SPR-03 report present; FileIO/artifact writers left read-only. |
| SPR-04 HUD priority Current Focus cache-only behavior | yes | HUD priority/cache counters and deferred Current Focus path retained; no file reads added. |
| SPR-04 stale/pending/missing posture | yes | Current Focus cache posture fields retained; no artifact truth change. |
| SPR-05 object/property skip counters | yes | `hud_obj_set_skipped`, `hud_obj_set_changed`, object cache and scoped hide counters preserved. |
| SPR-05 redraw dedupe | yes | `ASC_HudRequestRedraw()` and `ASC_HudFlushPendingRedraw()` retained; only one `ChartRedraw(0)` remains. |
| SPR-06 viewport material-change gate | yes | `ASC_HudViewportMaterialChange`, jitter ignored, layout dirty skipped, transition rebuild avoided retained. |
| SPR-07 proof emit-gating | yes | `hud_summary_build_skipped`, `hud_summary_lowfreq_only`, `proof_string_build_avoided`, `proof_emit_gate_blocked` retained and extended. |
| FileIO rewrite absent | yes | `mt5/io/ASC_FileIO.mqh` read-only. |
| Artifact truth/schema/path unchanged | yes | Current Focus, Dossier, Market Board writers read-only. |
| Lane/timer change absent | yes | `AuroraSentinelCore.mq5` and dispatcher read-only. |
| HUD redesign absent | yes | No layout constants, coordinates, visible fields, or operator wording changed. |

## 5. SPR-07 COMPILE-SAFETY CHECKPOINT

| Check | Result |
|---|---|
| Brace balance on `ASC_HUD_Manager.mqh` | pass: `{` and `}` counts match after patch. |
| Brace balance on `ASC_Dispatcher.mqh` | pass: `{` and `}` counts match; dispatcher read-only. |
| SPR-07 helper prototypes/definitions ordered safely | pass by static grep; SPR-07 proof builder prototypes and definitions retained. |
| SPR-07 fields initialized/reset | pass; SPR-07 fields retained and SPR-08 fields added to reset path. |
| Undefined helper calls introduced by SPR-07 | no new undefined SPR-07 helper call found by static trace. |
| Unknown-to-string risk in SPR-07 proof summary | no new large `StringFormat`; SPR-08 uses explicit `IntegerToString` counters. |
| Duplicate macros in `ASC_Version.mqh` | pass: single `ASC_VERSION_LABEL`, single current run, single next live proof macro. |
| ChartRedraw remains batched | pass: only existing `ASC_HudFlushPendingRedraw` `ChartRedraw(0)` call remains. |
| Error/warning/degraded proof suppressed | no; SPR-07 critical/degradation gates retained. |

## 6. INTERNET RESEARCH CONVERSION TABLE

| Research Finding | Source Constraint | File / Function Target | Patch Decision |
|---|---|---|---|
| Timer events are not stacked when a Timer event already exists in the queue or is processing. | Ordinary HUD render work inside timer cadence must stay cheap. | `ASC_HUD_Manager.mqh::ASC_HudRenderRows`, clock fast paths | Reuse existing row render signature to return before row text construction; add same-second clock early return. |
| MQL5 EA events are processed sequentially through the event queue. | Long string construction can delay HUD/chart event responsiveness. | ordinary HUD render and display-only paths | Avoid row/card/status string assembly where source signature/final displayed text is unchanged. |
| `ObjectSetString()` and other object setters are asynchronous chart commands. | Avoid enqueueing property changes when local signature proves text unchanged. | `ASC_HudSetLabelTextIfExists` | Count and skip unchanged text via local object signature cache; no hot-path `ObjectGetString()`. |
| `ChartRedraw()` forces chart redraw. | Do not add redraws to compensate for wasted text/property work. | redraw paths | No new `ChartRedraw()` added; batching preserved. |
| String functions like `StringLen`/`StringSubstr`/formatting are explicit runtime string operations. | Avoid repeated status/meta/string conversion work on unchanged clock/status beats. | clock/display-only paths | Early return before clock meta construction when visible UTC second is unchanged. |

## 7. ORDINARY HUD PAGE RENDER TEXT BUILDER TRACE

| Text Builder / Label Group | File / Function | Page/Trigger | Built Every Render? | Object Signature Gate Before Build? | Patch Needed? |
|---|---|---|---:|---:|---:|
| page headers/runtime/status | `ASC_HudRenderHeader` | all full renders | yes during full render | no, signature gate after text | held; full render gate already limits cadence |
| top navigation button captions | `ASC_HudRenderTopNav` | all full renders | yes during full render | no, button signature after text | held; no wording/layout change |
| breadcrumbs | `ASC_HudRenderBreadcrumbZone` | all full renders | yes during full render | no | held; low cost compared with rows |
| list row title/summary/detail/chips/buttons | `ASC_HudRenderRows` | list pages | previously avoided only by whole-row signature skip | yes through row signature before loop | patched telemetry/proof on cache hit |
| symbol detail card labels | symbol detail render body | symbol pages | yes during full render | no | held; selected-symbol tactical signature already gates full render |
| bottom status/page count | `ASC_HudRenderBottomRow` | all full renders | yes during full render | object signature after text | held; no layout/content change |
| clock/status text | `ASC_HudRefreshClockCadence`, `ASC_HudRefreshDisplayOnlyFastPath` | heartbeat/display-only | yes once cadence path entered | label cache after text | patched same-second early return |
| Current Focus stale/pending/missing text | Current Focus display path | selected symbol/current focus pages | cache-only from SPR-04 | object signature after text | preserved; no file reads added |

## 8. LABEL UPDATE PATH TRACE

| Label Update Path | Trigger | Text Built First? | Skips ObjectSetString If Unchanged? | Patch Decision |
|---|---|---:|---:|---|
| `ASC_HudEnsureLabel` | full render label path | yes | yes through full object signature | preserved |
| `ASC_HudEnsureButton` | full render button path | yes | yes through button signature | preserved |
| `ASC_HudSetLabelTextIfExists` | tactical/clock fast paths | yes, but local text compare exists | yes | patched counters: `hud_label_set_skipped_text`, `hud_label_text_reused` |
| row shell hide/collapse labels | stale row cleanup | hide text fixed empty | yes through signature | preserved |
| clock labels | cadence/display-only fast path | previously always built clock/meta after cadence | yes after text | patched same-second early return |

## 9. ROW / CARD RENDER WORK TRACE

| Row/Card Path | Loop Count | Text Fields Built | Cache/Fingerprint Exists? | Safe to Cache? | Patch Decision |
|---|---:|---:|---:|---:|---|
| `ASC_HudRenderRows` main buckets | visible row slots | title/summary/detail/meta/center/end/chips/button | yes: `list_rows_render_signature` | yes | patched proof counters on whole-loop skip |
| `ASC_HudRenderRows` sub-groups | visible row slots | title/summary/detail/meta/center/end/chips/button | yes | yes | patched proof counters on whole-loop skip |
| `ASC_HudRenderRows` symbols/leaders/top10 | visible row slots | title/summary/detail/meta/center/end/chips/button | yes incl shortlist/source/data fingerprint | yes | patched proof counters on whole-loop skip |
| `ASC_HudRenderCard` stat/detail cards | several per page | title + 3 lines | page/tactical signature | partial | held to avoid truth/layout drift |
| empty row state | first row when no data | fixed empty-state strings | whole row signature | yes | covered by row signature skip |

## 10. CLOCK / STATUS / STALE-PENDING TEXT TRACE

| Status Text Path | Trigger | Full Render? | Text Cache Exists? | Safe Minimal Update? | Patch Decision |
|---|---|---:|---:|---:|---|
| header clock text | heartbeat cadence / display-only | no | yes: `proof_clock_last_visible_text_token` + object signature | yes | patched duplicate same-second early return |
| header clock meta | heartbeat cadence / display-only | no | label signature after build | partial | same-second early return avoids build |
| overview clock text | display-only | no | label signature | yes | same-second early return preserved |
| bottom status text | full render | yes | object signature | partial | held; full render already gated |
| stale/pending/missing Current Focus status | selected-symbol render | yes/cache-only | Current Focus cache state | yes | preserved from SPR-04 |

## 11. PATCH DETAILS

Changed `mt5/hud/ASC_HUD_Manager.mqh`:

- Added compact SPR-08 counters: `hud_text_build_skipped`, `hud_label_text_reused`, `hud_label_set_skipped_text`, `hud_row_text_cache_hit`, `hud_status_text_cache_hit`, `hud_clock_text_unchanged`, `hud_render_string_build_avoided`.
- Added reset initialization for those counters.
- Extended `ASC_HudSetLabelTextIfExists(...)` unchanged-text branch to count text skips/reuse when cached final text matches.
- Extended the existing `ASC_HudRenderRows(...)` unchanged `list_rows_render_signature` fast return to count avoided field builds and row cache hits before returning.
- Added same-second clock early return to `ASC_HudRefreshClockCadence(...)` and `ASC_HudRefreshDisplayOnlyFastPath(...)`.
- Extended compact and high-frequency HUD proof summaries with the new compact text-cache counters.

Changed `mt5/core/ASC_Version.mqh`:

- Updated version label/run identity to SPR-08.

## 12. LABEL TEXT CACHE / FINGERPRINT POLICY

The HUD does not cache trading truth. SPR-08 only counts and reuses display text when an existing local display-object signature or existing row-render signature proves the rendered text would be unchanged.

## 13. OBJECTSETSTRING UNCHANGED-TEXT POLICY

`ASC_HudSetLabelTextIfExists(...)` continues to avoid `ObjectGetString()` in the hot path. It extracts cached final text from the local object signature and returns before `ObjectSetString()` when unchanged.

## 14. ROW / CARD TEXT CACHE POLICY

`ASC_HudRenderRows(...)` already had a page/source/data/layout row signature. SPR-08 makes that skip visible through proof counters and treats it as the row/card text-cache hit boundary. It does not add hidden truth ownership or change row content/order.

## 15. CLOCK / STATUS MINIMAL TEXT POLICY

Clock/status fast paths now return before clock-meta/status label construction when the visible UTC second is already current. This avoids needless status text work and label update attempts without suppressing stale/pending/missing truth or full render invalidation.

## 16. TELEMETRY ADDED / PRESERVED

Added compact proof tokens:

- `hud_text_build_skipped=`
- `hud_label_text_reused=`
- `hud_label_set_skipped_text=`
- `hud_row_text_cache_hit=`
- `hud_status_text_cache_hit=`
- `hud_clock_text_unchanged=`
- `hud_render_string_build_avoided=`

Preserved SPR-07 tokens:

- `hud_summary_build_skipped=`
- `hud_summary_lowfreq_only=`
- `proof_string_build_avoided=`
- `proof_emit_gate_blocked=`

## 17. PROTECTED AREAS NOT TOUCHED

No trading logic, entries, lot sizing, SL/TP, OrderSend/CTrade, ranking formula/order, L3 score, L4 ranking, Top3/Top5/Top10 ordering, Market Board order, Dossier schema/content, Current Focus derivative truth, artifact paths, FileIO atomic contract, heartbeat cadence, lane law, HUD truth ownership, HUD layout, operator wording, or `ChartRedraw()` placement was changed.

## 18. COMPILE / TEST STATUS

Static checks performed:

- `ASC_HUD_Manager.mqh` brace balance: pass.
- `ASC_Dispatcher.mqh` brace balance: pass.
- New counters are declared and reset.
- No duplicate version macros detected.
- `ChartRedraw` grep shows one existing call in `ASC_HudFlushPendingRedraw` only.

MetaEditor is unavailable in this environment, so compile proof is not claimed. Live proof is not claimed.

## 19. CHANGED FILES

- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR08_HUD_RENDER_TEXT_UNCHANGED_LABEL_PRESSURE_REPORT.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`

## 20. NEXT PERFORMANCE PROMPT SEED

SPR-09 should audit HUD symbol-detail card/body construction only if live proof still shows sluggishness after SPR-08. It must not redo SPR-01 through SPR-08 and must first prove whether symbol detail card construction is still hot-path expensive after row render cache hits and same-second clock/status skips are visible.
