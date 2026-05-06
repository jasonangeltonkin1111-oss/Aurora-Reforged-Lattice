# SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-03 READBACK + MANIFEST + BACKFILL PRESSURE REPAIR

## 1. GIT HEADER SUMMARY

SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-03 / READBACK + MANIFEST + BACKFILL PRESSURE REPAIR  
GPT CODE-REPAIR PROMPT  
NOT PART OF TRUTH SEEKER MAIN ROADMAP  
NOT RUN107  
SOURCE PATCH APPLIED  
COMPILE CLAIM NOT MADE  
LIVE CLAIM NOT MADE

## 2. EXECUTIVE SUMMARY

SPR-03 patches the next write-side pressure after SPR-01 log throttling and SPR-02 write-lane time slicing: defer-safe post-publish readback, manifest, scanner-status, and presence/backfill sweep side duties.

The patch does not redo SPR-02. It reuses the existing write budget and UI-priority posture, keeps the one-second heartbeat law intact, preserves atomic publication once started, and does not change trading logic, ranking/order/formulas, artifact truth, artifact paths, artifact schema, Current Focus truth, Market Board order, FileIO atomic mechanics, or HUD design.

The patch changes the source so defer-safe side duties can yield near budget or during UI-priority pressure, while compact telemetry records that proof work was deferred rather than faking completion.

## 3. ZIP / ROOT / FILE INTAKE SUMMARY

Discovery commands executed from `/mnt/data/spr03`:

```bash
pwd
find . -maxdepth 5 -type f \( \
  -name 'AuroraSentinelCore.mq5' -o \
  -name 'ASC_Dispatcher.mqh' -o \
  -name 'ASC_FileIO.mqh' -o \
  -name 'ASC_DossierWriter.mqh' -o \
  -name 'ASC_MarketBoardWriter.mqh' -o \
  -name 'ASC_CurrentFocusWriter.mqh' -o \
  -name 'ASC_Version.mqh' -o \
  -name 'TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md' -o \
  -name '*SPR*' \
\) | sort
find . -type f -path '*Aurora Sentinel Core*' | head -250
find . -type f \( -iname '*SPR*' -o -iname '*RUN107*' -o -iname '*forensic*' -o -iname '*vagueness*' \) | sort
```

Selected `REPO_ROOT`: `/mnt/data/spr03/Aurora Sentinel Core`  
Selected `ASC_ROOT`: `/mnt/data/spr03/Aurora Sentinel Core`

| Item | Discovered Path | Status |
|---|---|---|
| REPO_ROOT | `/mnt/data/spr03/Aurora Sentinel Core` | found |
| ASC_ROOT | `/mnt/data/spr03/Aurora Sentinel Core` | found |
| AuroraSentinelCore.mq5 | `/mnt/data/spr03/Aurora Sentinel Core/mt5/AuroraSentinelCore.mq5` | found |
| ASC_Dispatcher.mqh | `/mnt/data/spr03/Aurora Sentinel Core/mt5/runtime/ASC_Dispatcher.mqh` | found/changed |
| ASC_RuntimeState.mqh | `/mnt/data/spr03/Aurora Sentinel Core/mt5/core/ASC_RuntimeState.mqh` | found/read-only |
| ASC_Constants.mqh | `/mnt/data/spr03/Aurora Sentinel Core/mt5/core/ASC_Constants.mqh` | found/changed |
| ASC_DossierWriter.mqh | `/mnt/data/spr03/Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh` | found/read-only |
| ASC_MarketBoardWriter.mqh | `/mnt/data/spr03/Aurora Sentinel Core/mt5/artifacts/ASC_MarketBoardWriter.mqh` | found/read-only |
| ASC_CurrentFocusWriter.mqh | `/mnt/data/spr03/Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh` | found/read-only |
| ASC_FunctionResults.mqh | `/mnt/data/spr03/Aurora Sentinel Core/mt5/logging/ASC_FunctionResults.mqh` | found/read-only |
| ASC_FileIO.mqh | `/mnt/data/spr03/Aurora Sentinel Core/mt5/io/ASC_FileIO.mqh` | found/read-only |
| SPR-01 report/control | exact report absent; source identity found in inherited SPR-02 report/control | source baseline reconstructed from SPR-02 report |
| SPR-02 report/control | `/mnt/data/spr03/Aurora Sentinel Core/roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR02_WRITE_LANE_TIME_SLICE_REPORT.md` | found/read |

Additional latency audit found/read:

- `/mnt/data/spr03/Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_RUN107A_FULL_SYSTEM_LATENCY_ROOT_CAUSE_AUDIT.md`
- `/mnt/data/spr03/Aurora Sentinel Core/FORENSIC_DOSSIER_RUNTIME_AUDIT_2026-04-17.md`

## 4. SPR-02 BASELINE VERIFICATION

| SPR-02 Area | Verified? | Evidence |
|---|---:|---|
| write-lane budget checks were added | yes | `ASC_WriteLaneNearBudget`, `ASC_HeartbeatBudgetExpired`, and `ASC_RecordWriteLaneYield` were present before SPR-03 patch |
| dossier queue can yield before next symbol/class boundary | yes | Dossier loop checks write near-budget before next symbol after bounded progress and re-appends popped symbol on budget exhaustion |
| UI-priority write reduction exists | yes | UI-priority budget scaling and Top10/Dossier/Board reductions were present |
| immediate Dossier readback was preserved | yes | pre-SPR-03 successful Dossier write path immediately called `ASC_ReadTextFile(dossier_contract.target_path, persisted_payload)` |
| deferred_readback_count exists but remained zero | yes | telemetry field existed and was initialized/logged, but no readback deferral implementation incremented it before SPR-03 |
| no FileIO changes were made | yes | SPR-02 report and current diff show no `ASC_FileIO.mqh` edits |
| no lane/timer/truth/artifact semantics changed | yes | heartbeat, lane law, artifact paths/schema, rank/order formulas untouched by SPR-02 and SPR-03 |

## 5. INTERNET RESEARCH CONVERSION TABLE

| Research Finding | Source Constraint | File / Function Target | Patch Decision |
|---|---|---|---|
| Timer events do not stack when a Timer event is already queued or processing. | Official MQL5 `OnTimer` docs: new Timer event is not added if a Timer event is queued/processing. | `ASC_RunWriteLane`, post-lane scanner/presence duties. | Add defer-safe side-duty yield so write-side proof work does not consume the timer window after publication. |
| MQL5 application events are processed sequentially in their own queue. | Official MQL5 event/runtime docs: events are handled one after another. | `ASC_RunHeartbeat` after lane service. | Avoid post-lane file sweeps when persistence lane is already near budget or UI priority is active. |
| File reads and writes move the file pointer and do real file work. | Official `FileWriteString` / `FileReadString` docs describe file writes/reads against file handles and pointer movement. | Dossier readback and manifest/presence proof paths. | Do not add extra readbacks; defer proof-only readback near budget/UI priority. |
| Frequent file flushes can affect speed; expensive file work should not be multiplied inside event handlers. | Official file guidance used from prior SPR-02 research and preserved here. | FileIO atomic path and write lane. | Leave FileIO atomic contract untouched; reduce calls around it instead of rewriting FileIO. |

## 6. POST-PUBLISH SIDE-DUTY TRACE

| Step | File / Function | Runs Inside OnTimer? | File IO? | Sliceable? | Blocks HUD/Clock? |
|---|---|---:|---:|---:|---:|
| heartbeat write lane entry | `ASC_RunHeartbeat` -> `ASC_RunWriteLane` | yes | possible | yes | yes |
| Top10 family reconcile/service | `ASC_ReconcileTop10RunFullChildFamily`, `ASC_ServiceTop10RunFullBatch` | yes | possible | yes | yes |
| Dossier publish | `ASC_BuildDossierArtifact` / `ASC_BuildDossierShellArtifact` | yes | yes | before next symbol only | yes |
| Dossier readback | `ASC_ReadTextFile(dossier_contract.target_path, persisted_payload)` | yes | yes | yes if proof/ledger can infer from queue class | yes |
| Bundle manifest | `ASC_WriteArtifactBundleManifest` | yes | yes | yes before start | yes |
| post-publish presence sweep | `ASC_RefreshDossierPresenceCounters(... write_lane_post_publish ...)` | yes | yes | yes | yes |
| scanner status side write | `ASC_MaybeWriteScannerStatus` -> `ASC_WriteScannerStatusArtifact` | yes | yes | yes | yes |
| heartbeat post-summary sweep | `ASC_RefreshDossierPresenceCounters(... heartbeat_post_summary ...)` | yes | yes | yes | yes |
| compact telemetry | `ASC_WriteHeartbeatTelemetry` / function result detail | yes | yes/log | already throttled | limited |

## 7. READBACK PRESSURE LEDGER

| Readback Item | File / Function | Why It Exists | Immediate Correctness Required? | Can Defer? | Patch Decision |
|---|---|---|---:|---:|---|
| Dossier payload readback after successful publish | `ASC_RunWriteLane` -> `ASC_ReadTextFile(dossier_contract.target_path, persisted_payload)` | Hydration ledger coverage proof | not always; queue class can infer pending L3/L4 target after known write result | yes near budget/UI priority | Guarded by `ASC_SideDutyShouldYield`; increments `readback_deferred`/`readback_pending` instead of faking completion |
| Manifest readback | no direct separate readback found in changed path | bundle manifest emits proof boundary | no immediate readback path changed | n/a | No change |
| Current Focus readback | selected-symbol reconciliation paths use `ASC_ReadTextFile(state.current_focus_path, ...)` | selected-symbol alignment | context-sensitive | not patched in SPR-03 | Read-only/no source change |
| Market Board readback | manifest alignment checks can read board payload | cross-artifact manifest support | no for same-beat timer budget | indirectly yield by manifest deferral | Manifest deferred before start near budget/backlog/UI priority |
| Scanner status validation readback | scanner writer validates payload via writer contract | status proof | no if budget stressed | yes | scanner/status and heartbeat post-summary side duties can yield after persistence lane |
| General `ASC_ReadTextFile` sweeps | dossier presence and coverage sweeps | backlog/presence proof | no same-beat requirement | yes | Post-publish and post-lane sweeps can yield near budget/UI priority |

## 8. MANIFEST / BACKFILL / SWEEP PRESSURE LEDGER

| Side Duty | File / Function | Frequency | Criticality | Can Yield Near Budget? | Can Reduce During UI Priority? |
|---|---|---|---|---:|---:|
| bundle manifest write | `ASC_WriteArtifactBundleManifest` | pending bundle | medium/high proof artifact, not atomicity core | yes before start | yes when dossier backlog remains |
| family manifest write | Top10 family helpers | batch/family pending | medium | already guarded by SPR-02 | yes |
| scanner status write | `ASC_MaybeWriteScannerStatus` | every ~2s if due | proof/status | yes | yes |
| dossier presence sweep | `ASC_RefreshDossierPresenceCounters` | post publish / heartbeat | proof/backfill | yes | yes |
| backlog recompute | `ASC_CountRemainingDossierBacklog` / pending queue counters | write lane | queue progress | limited | no broad rewrite |
| top10 staging cleanup/family side work | Top10 run-full service | pending batch | medium | already guarded | yes |
| stale artifact cleanup | not directly patched | maintenance | low/medium | yes if future found | n/a |
| proof-only maintenance | function result / heartbeat tokens | heartbeat | proof | compact only | yes via throttling retained |

## 9. FILE IO HOT-PATH CLASSIFICATION

| File IO Operation | Owner | Required Same Beat? | Defer Rule | Failure Handling |
|---|---|---:|---|---|
| Atomic artifact publish once started | FileIO / artifact writer | yes | never yield mid-atomic | existing FileIO result/continuity handling preserved |
| Dossier proof readback after successful write | Dispatcher hydration ledger | no near budget/UI | defer and mark `readback_deferred/readback_pending` | ledger falls back to queue-class inference; later sweeps refresh proof |
| Bundle manifest write | Dispatcher manifest writer | no when backlog/budget/UI pressure exists | keep pending manifest + dirty write | existing manifest failure path preserved |
| Scanner status artifact | Scanner status writer | no | skip when persistence side duties yielded | existing 2s cadence retries later |
| Dossier presence sweep | Dispatcher coverage telemetry | no | skip near budget/UI, preserve deferred work | next beats/scanner cadence refresh counters |
| FunctionResults/heartbeat telemetry | logging | yes but compact/throttled | keep compact tokens only | SPR-01 throttling retained |

## 10. PATCH DETAILS

Changed `mt5/runtime/ASC_Dispatcher.mqh`:

- Added compact telemetry fields: `readback_pending_count`, `manifest_yield_count`, `sweep_yield_count`, `post_publish_elapsed_ms`, `side_duty_count_this_beat`, `side_yield_reason`.
- Added `ASC_SideDutyShouldYield(...)`, reusing existing SPR-02 budget helpers and `ASC_RecordWriteLaneYield(...)`.
- Guarded Dossier post-publish readback so it can defer during UI priority or near budget, while incrementing `deferred_readback_count` and `readback_pending_count`.
- Extended manifest defer logic to also yield during UI priority when Dossier backlog remains pending.
- Guarded write-lane post-publish presence sweep.
- Guarded post-lane scanner status + heartbeat post-summary presence sweep when persistence lane is already near budget or UI priority is active.
- Added compact proof tokens to heartbeat telemetry/detail rows.

Changed `mt5/core/ASC_Constants.mqh`:

- Extended `ASC_PHASE3A_HEARTBEAT_REQUIRED_FIELDS` with SPR-03 side-duty tokens.

Changed `mt5/core/ASC_Version.mqh`:

- Advanced source identity to SPR-03.
- Added SPR-03 scope/boundary/proof/research/patch summary macros.

Changed control/report files:

- Updated active roadmap log.
- Updated output package manifest.
- Added this SPR-03 report.

## 11. READBACK DECISION

Immediate Dossier readback is preserved when budget allows. SPR-03 defers it only when side-duty pressure is unsafe for the current timer beat: near write budget, exhausted write budget, or UI-priority pressure. The patch does not mark deferred proof as complete. It records `readback_deferred` and `readback_pending` compactly and relies on existing later presence/coverage sweeps to refresh proof.

## 12. SIDE-DUTY EARLY-YIELD RULES

- Check budget at side-duty boundaries, not inside tiny inner loops.
- Do not yield inside atomic FileIO publication.
- Do not clear proof debt silently.
- Do not suppress artifact errors.
- Defer manifest/scanner/presence proof work only before it starts.
- If yielded, keep dirty/deferred state so later beats can continue.
- UI-priority can reduce non-critical side-duty pressure without changing truth ownership.

## 13. TELEMETRY ADDED / PRESERVED

Added/preserved compact tokens:

- `side_yield=`
- `side_yield_reason=`
- `readback_deferred=`
- `readback_pending=`
- `manifest_yield=`
- `sweep_yield=`
- `ui_priority_side_reduced=`
- `post_publish_elapsed_ms=`
- `side_duty_count_this_beat=`
- existing `write_early_yield=`, `write_yield_reason=`, `deferred_readback_count=`, `ui_priority_write_reduced=` retained

No per-symbol spam was restored.

## 14. STARVATION GUARD

Deferred side duties are not permanently suppressed:

- Manifest remains `l1_publish_pending_manifest=true` and `write_dirty=true` when deferred.
- Sweep/scanner-status deferral preserves `write_dirty=true` and `deferred_write_artifacts>=1`.
- Scanner status already has a cadence gate and retries on later beats.
- Dossier readback deferral increments pending/deferred proof tokens and leaves later coverage refresh paths intact.
- Atomic publication success/error remains recorded by the artifact writer before defer-safe proof work can yield.

## 15. PROTECTED AREAS NOT TOUCHED

- No trading logic changed.
- No entry/signal/lot/SL/TP/order path changed.
- No L3 score formula changed.
- No L4 rank/order/correlation formula changed.
- No Top3/Top5/Top10 order changed.
- No Market Board ordering changed.
- No Dossier/Current Focus/Market Board truth/schema/path changed.
- No FileIO atomic contract changed.
- No heartbeat cadence changed.
- No scan/write/read lane law changed.
- No HUD redesign.
- No SPR-01 throttling removed.
- No SPR-02 write-yield safeguards removed.

## 16. COMPILE / TEST STATUS

Static/source checks completed:

```bash
grep -n "ASC_SideDutyShouldYield" mt5/runtime/ASC_Dispatcher.mqh
grep -n "readback_deferred\|manifest_yield\|sweep_yield\|side_yield_reason" mt5/runtime/ASC_Dispatcher.mqh
grep -n "ASC_SYSTEM_PERFORMANCE_SPR03" mt5/core/ASC_Version.mqh
diff -u /mnt/data/ASC_Dispatcher.before.spr03 mt5/runtime/ASC_Dispatcher.mqh
```

MetaEditor compile was not available in this environment. Compile proof and live runtime proof are not claimed.

## 17. CHANGED FILES

- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_Constants.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR03_READBACK_MANIFEST_BACKFILL_PRESSURE_REPORT.md`

## 18. NEXT PERFORMANCE PROMPT SEED

SPR-04 should audit whether HUD-priority pre-heartbeat paths still perform file reads or heavy parsing after SPR-03, specifically selected-symbol Current Focus reconciliation/readback and HUD cache warm paths. It must not redesign HUD, change truth ownership, or alter artifact schemas; it should only move/defer safe file-read cache warming out of immediate ChartEvent/priority-render pressure if static evidence proves it remains hot.
