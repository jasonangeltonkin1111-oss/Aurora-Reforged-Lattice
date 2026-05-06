# SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-07 / HUD PROOF SUMMARY STRING CONSTRUCTION + HEARTBEAT PROOF EMISSION PRESSURE REPAIR

## 1. GIT HEADER SUMMARY

SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-07 / HUD PROOF SUMMARY STRING CONSTRUCTION + HEARTBEAT PROOF EMISSION PRESSURE REPAIR  
ZIP-FIRST WORKFLOW USED. ROOT DISCOVERY USED BEFORE FILE ACCESS. SOURCE PATCH PRODUCED. COMPILE NOT CLAIMED.

## 2. EXECUTIVE SUMMARY

SPR-07 patches the proof-summary pressure seam left after SPR-01 through SPR-06. The patch keeps proof power but moves expensive HUD proof inventories out of the high-frequency proof builder and into low-frequency / transition / degradation proof. It also gates heartbeat telemetry file row construction before building the large tab-delimited row during healthy non-sample steady state.

No trading logic, ranking/order formulas, Market Board order, Dossier truth/schema, Current Focus truth, artifact paths, FileIO atomic mechanics, scan/write/read lane law, heartbeat cadence, HUD ownership, HUD layout, or ChartRedraw behavior was changed.

## 3. ZIP / ROOT / FILE INTAKE SUMMARY

Discovery commands executed from `/mnt/data/spr07_work`:

```bash
pwd
find . -maxdepth 6 -type f \( -name 'AuroraSentinelCore.mq5' -o -name 'ASC_Dispatcher.mqh' -o -name 'ASC_HUD_Manager.mqh' -o -name 'ASC_FunctionResults.mqh' -o -name 'ASC_FileIO.mqh' -o -name 'ASC_Version.mqh' -o -name 'TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md' -o -name '*SPR*' \) | sort
find . -type f -path '*Aurora Sentinel Core*' | head -300
find . -type f \( -iname '*SPR-02*' -o -iname '*SPR-03*' -o -iname '*SPR-04*' -o -iname '*SPR-05*' -o -iname '*SPR-06*' -o -iname '*HUD*' -o -iname '*PROOF*' -o -iname '*SUMMARY*' \) | sort
```

Selected `REPO_ROOT`: `/mnt/data/spr07_work/extracted/Aurora Sentinel Core`  
Selected `ASC_ROOT`: `/mnt/data/spr07_work/extracted/Aurora Sentinel Core`

| Item | Discovered Path | Status |
|---|---|---|
| REPO_ROOT | `/mnt/data/spr07_work/extracted/Aurora Sentinel Core` | found |
| ASC_ROOT | `/mnt/data/spr07_work/extracted/Aurora Sentinel Core` | found |
| AuroraSentinelCore.mq5 | `mt5/AuroraSentinelCore.mq5` | found/read-only |
| ASC_Dispatcher.mqh | `mt5/runtime/ASC_Dispatcher.mqh` | found/changed |
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

## 4. SPR-02 / SPR-03 / SPR-04 / SPR-05 / SPR-06 BASELINE VERIFICATION

| Baseline Area | Verified? | Evidence |
|---|---:|---|
| SPR-02 write-lane budget/yield | yes | SPR-02 report found; dispatcher write-lane budget/yield code retained. |
| SPR-02 no FileIO changes | yes | `ASC_FileIO.mqh` not changed in SPR-07. |
| SPR-03 side-duty yield | yes | SPR-03 report found; side-duty yield tokens retained in dispatcher telemetry. |
| SPR-03 compact side-duty telemetry | yes | `side_yield`, `manifest_yield`, `sweep_yield`, `post_publish_elapsed_ms` retained. |
| SPR-04 Current Focus priority cache-only | yes | HUD priority/cache counters retained; no file reads added to priority path. |
| SPR-04 stale/pending/missing posture | yes | Current Focus cache posture fields retained; no artifact writer touched. |
| SPR-05 object/property skip counters | yes | `hud_obj_set_skipped`, `hud_obj_set_changed`, `hud_obj_create_reused`, `hud_obj_delete_avoided` retained. |
| SPR-05 redraw dedupe | yes | `ASC_HudRequestRedraw` / `ASC_HudFlushPendingRedraw` unchanged; no new `ChartRedraw`. |
| SPR-06 viewport material-change gate | yes | `ASC_HudViewportMaterialChange`, jitter ignored, layout dirty skipped, and transition rebuild avoided counters retained. |
| Artifact truth/schema/path | yes | Artifact writer files and FileIO were read-only. |
| Lane/timer law | yes | Heartbeat cadence and lane routing unchanged. |
| HUD redesign absent | yes | Only proof strings, counters, and emit gates were changed. |

## 5. SPR-06 COMPILE-SAFETY CHECKPOINT

| Check | Result |
|---|---|
| Brace balance on `ASC_HUD_Manager.mqh` | pass: `{` and `}` counts match after patch. |
| SPR-06 helper prototypes/definitions ordered safely | pass: prototype/implementation locations preserved after re-extraction repair; `ASC_HudBuildHighFrequencyProofSummary` remains prototype + implementation only. |
| SPR-06 fields initialized/reset | pass: SPR-06 counters retained in state and reset path. |
| Undefined helper calls introduced by SPR-06 | no SPR-06 helper call issue observed in static grep. |
| Unknown-to-string risk in SPR-06 proof summary | reduced: expensive SPR-06 proof remains low-frequency; high-frequency uses explicit `IntegerToString` / helper conversion. |
| Duplicate macros in `ASC_Version.mqh` | no duplicate SPR-07 macros intentionally introduced. |
| ChartRedraw remains batched | pass by patch scope: no `ChartRedraw` call added. |

## 6. INTERNET RESEARCH CONVERSION TABLE

| Research Finding | Source Constraint | File / Function Target | Patch Decision |
|---|---|---|---|
| Timer events are not stacked while a timer event is already queued or processing. | Keep heartbeat proof work cheap so one timer does not crowd out the next timer window. | `ASC_HUD_Manager.mqh::ASC_HudEmitProofSummary`; `ASC_Dispatcher.mqh::ASC_LogHeartbeatTelemetry` | Add emit-gate-before-build and skip healthy non-sample heartbeat log row construction. |
| MQL5 program/event handlers execute sequentially for an EA. | Long string building inside timer/HUD heartbeat delays other event work. | `ASC_RunHeartbeat`, HUD heartbeat proof emit path | Move expensive proof tokens to low-frequency / transition / error path. |
| `ObjectCreate` and object property setters enqueue chart commands asynchronously. | Proof must not trigger more chart queue pressure or redraw work. | HUD proof path | Do not add chart object operations; preserve read-only proof counters. |
| `ChartRedraw` is a forced redraw boundary. | Do not use redraw as proof emission. | HUD render/redraw path | No `ChartRedraw` added; batching preserved. |
| MQL5 strings can be assembled using explicit concatenation/conversion; giant format blocks are compile-fragile in this codebase. | Avoid oversized `StringFormat` and avoid building unused long strings. | HUD proof builders and heartbeat detail strings | Keep typed concatenation but move expensive strings behind emit gates. |

## 7. HUD PROOF SUMMARY BUILDER TRACE

| HUD Proof Builder | File / Function | Trigger | Builds Every Beat? | Emits Every Beat? | Heavy String Work? | Patch Needed? |
|---|---|---|---:|---:|---:|---:|
| High-frequency HUD proof | `ASC_HUD_Manager.mqh::ASC_HudBuildHighFrequencyProofSummary` | cadence / critical transition / verbose | no | no | previously yes | patched compact |
| Low-frequency HUD proof | `ASC_HUD_Manager.mqh::ASC_HudBuildLowFrequencyProofSummary` | scope/visibility/degradation transition | no | no | yes by design | preserved + SPR-07 moved-token proof |
| Compact telemetry | `ASC_HudBuildCompactTelemetrySummary` | compact due after HF gate | no | no | medium | preserved gated |
| HUD emit gate | `ASC_HudEmitProofSummary` | HUD heartbeat | yes, cheap gate only | no | no after patch | patched counters |

## 8. HEARTBEAT / TIMER PROOF EMISSION TRACE

| Runtime Proof Path | File / Function | Trigger | String Built Before Emit Decision? | Emit Gate? | Patch Needed? |
|---|---|---|---:|---:|---:|
| Heartbeat telemetry file row | `ASC_Dispatcher.mqh::ASC_LogHeartbeatTelemetry` | each heartbeat call | previously yes | previously weak | patched |
| Heartbeat FunctionResult detail | `ASC_Dispatcher.mqh::ASC_RunHeartbeat` | each heartbeat result | compact only before full gate | yes | patched tokens |
| Write-lane proof strings | `ASC_RunWriteLane` | write work/yield | only on lane events | yes | preserved |
| Side-duty proof strings | `ASC_SideDutyShouldYield` / telemetry | post-publish duties | only on work/yield | yes | preserved |

## 9. STRING CONSTRUCTION COST LEDGER

| String Path | File / Function | Hot Path? | Approx Token Count | Built When Not Emitted? | Patch Decision |
|---|---|---:|---:|---:|---|
| Full HUD HF summary | HUD / `ASC_HudBuildHighFrequencyProofSummary` | yes during cadence/transition | high | no, but too heavy per HF emission | compacted; full inventories moved LF |
| HUD LF summary | HUD / `ASC_HudBuildLowFrequencyProofSummary` | no | high | cached 2 sec | retained low-frequency only |
| Heartbeat telemetry log row | Dispatcher / `ASC_LogHeartbeatTelemetry` | yes | very high | yes before file append | gated before row build |
| Heartbeat FunctionResult full detail | Dispatcher / `ASC_RunHeartbeat` | yes | high | only on full trigger | retained, compact proof added |
| Compact telemetry | HUD / `ASC_HudBuildCompactTelemetrySummary` | gated | medium | no after gate | preserved |

## 10. PROOF VALUE CLASSIFICATION

| Proof Token / Group | Current Path | Value Class | Frequency Needed | Patch Decision |
|---|---|---|---|---|
| HUD render pass / mutation / redraw core | HF | critical performance sample | HF sample/transition | retained compact |
| HUD object cache/readback inventory | LF | sample-only diagnostic | LF/transition | moved/kept LF |
| SPR-05 object/redraw counters | LF + compact HF subset | regression proof | LF/transition; compact HF core | preserved |
| SPR-06 viewport/layout/transition counters | LF | regression proof | LF/transition | preserved LF |
| Current Focus cache-only counters | HF compact + LF detail | critical regression proof | HF compact + LF detail | preserved |
| Heartbeat tab log full row | heartbeat file | sample/error/transition proof | sample/error/pressure only | gated |
| Heartbeat FunctionResult full detail | FunctionResults | sample/error/pressure proof | full only on gate | preserved |

## 11. PATCH DETAILS

Changed files:

- `mt5/hud/ASC_HUD_Manager.mqh`
  - Added compact SPR-07 counters: `hud_summary_build_skipped`, `hud_summary_lowfreq_only`, `proof_string_build_avoided`, `proof_emit_gate_blocked`.
  - Replaced high-frequency HUD summary with compact core proof.
  - Preserved expensive proof in low-frequency summary and added `spr07[...]` moved-token proof.
  - Incremented build-avoided / emit-blocked counters when emit gates reject steady state.

- `mt5/runtime/ASC_Dispatcher.mqh`
  - Added heartbeat telemetry row emit gate before constructing the huge tab-delimited row.
  - Emits heartbeat telemetry rows only for startup, sample, budget pressure, error, UI priority, yield, or HUD handoff states.
  - Added optional proof tokens: `proof_emit_gate=` and `heartbeat_detail_build_avoided=`.
  - Added compact heartbeat FunctionResult detail tokens showing full-detail build avoidance.

- `mt5/core/ASC_Version.mqh`
  - Advanced source identity from SPR-06 to SPR-07.
  - Added SPR-07 scope/boundary/proof/research/patch-summary macros.

## 12. EMIT-GATE-BEFORE-BUILD POLICY

Implemented for heartbeat telemetry file rows and strengthened for HUD proof summaries. Normal healthy non-sample heartbeats return before the large telemetry row is assembled. HUD proof returns before HF/LF builders run when no cadence, transition, degradation, or verbose proof trigger exists.

## 13. COMPACT HIGH-FREQUENCY PROOF POLICY

HF HUD proof now includes only heartbeat/page/render status, build-avoided counters, render/redraw core, navigation cache-only proof, blocked-read proof, and pressure/stall hints. Full object/cache/classification/viewport inventories are no longer in the HF proof string.

## 14. LOW-FREQUENCY / TRANSITION / ERROR PROOF POLICY

LF proof remains the destination for expensive inventories: object cache, object readback, classification distribution, leader audit, SPR-05 counters, SPR-06 viewport/layout/transition counters, and full navigation cache detail.

## 15. TELEMETRY ADDED / PRESERVED

Added: `hud_summary_build_skipped`, `hud_summary_lowfreq_only`, `proof_string_build_avoided`, `proof_emit_gate_blocked`, `heartbeat_detail_build_avoided`, `proof_emit_gate`.

Preserved: SPR-02 write-yield telemetry, SPR-03 side-duty telemetry, SPR-04 cache-only HUD proof, SPR-05 object/redraw proof, SPR-06 viewport/layout/transition proof.

## 16. PROOF TOKENS MOVED OR HELD

Moved from HF to LF: object-cache detail, readback inventory, nav-cache detail, classification health/distribution, leader audit, full SPR-05 inventory, full SPR-06 inventory.

Held in HF compact: render pass, redraw count, navigation click/ack, priority cache-only, blocked read count, tactical/clock/transition pressure.

## 17. PROTECTED AREAS NOT TOUCHED

No artifact writer source changed. No FileIO source changed. No ranking/order/formula source changed. No Market Board order changed. No Dossier or Current Focus truth/schema/path changed. No lane/timer cadence changed. No HUD layout/operator wording changed. No `ChartRedraw` added.

## 18. COMPILE / TEST STATUS

Static checks performed:

- Brace balance: pass for `ASC_HUD_Manager.mqh` and `ASC_Dispatcher.mqh`.
- HUD prototype/implementation location: pass after re-extract repair; only one prototype and one implementation remain.
- New counters initialized/reset: pass.
- Duplicate SPR-07 macro intent: no duplicate SPR-07 macro block added.
- MetaEditor compile: unavailable in this environment; compile proof not claimed.
- Live/runtime proof: not run; live proof not claimed.

## 19. CHANGED FILES

- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR07_HUD_PROOF_SUMMARY_HEARTBEAT_PROOF_PRESSURE_REPORT.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`

## 20. NEXT PERFORMANCE PROMPT SEED

SPR-08 should inspect whether any remaining expensive proof or UI status strings are still built during ordinary HUD page render even when labels are unchanged, without changing HUD layout, truth ownership, artifact schema, FileIO, rank/order, lane law, or heartbeat cadence.
