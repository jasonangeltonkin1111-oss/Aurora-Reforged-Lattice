# SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-02 WRITE-LANE TIME-SLICE + DOSSIER QUEUE EARLY-YIELD REPAIR

## 1. GIT HEADER SUMMARY

SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-02 / WRITE-LANE TIME-SLICE + DOSSIER QUEUE EARLY-YIELD REPAIR  
GPT CODE-REPAIR PROMPT  
NOT PART OF TRUTH SEEKER MAIN ROADMAP  
NOT RUN107  
SOURCE PATCH APPLIED  
COMPILE CLAIM NOT MADE  
LIVE CLAIM NOT MADE

## 2. EXECUTIVE SUMMARY

SPR-02 patches the next latency source after SPR-01: write-lane work monopolizing the one-second `OnTimer` heartbeat. The patch keeps the existing Scan / Write / Read lane law and heartbeat cadence intact, but adds write-lane near-budget guards, Top10 family side-duty deferral during UI priority, non-critical Market Board defer near budget, Dossier queue early-yield after bounded progress, manifest deferral when Dossier backlog still owns the slice, and compact telemetry proving the yield decision.

No trading logic, ranking/order formula, Market Board order, Dossier truth/schema, Current Focus truth, artifact path, FileIO atomic contract, or heartbeat cadence was changed.

## 3. ZIP / ROOT / FILE INTAKE SUMMARY

Discovery commands executed from `/mnt/data/spr02`:

```bash
pwd
find . -maxdepth 4 -type f \( -name 'AuroraSentinelCore.mq5' -o -name 'ASC_Dispatcher.mqh' -o -name 'ASC_HUD_Manager.mqh' -o -name 'ASC_Version.mqh' -o -name 'TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md' -o -name 'SPR-01*' \) | sort
find . -type f -path '*Aurora Sentinel Core*' | head -200
find . -iname '*SPR*' -o -iname '*SYSTEM PERFORMANCE*'
grep -RIl 'SPR-01\|LOG BLOAT\|SPR-01_LogBloatTelemetryThrottlePatch\|SYSTEM PERFORMANCE REPAIR MINI-ROADMAP' 'Aurora Sentinel Core'
```

Selected `REPO_ROOT`: `/mnt/data/spr02`  
Selected `ASC_ROOT`: `/mnt/data/spr02/Aurora Sentinel Core`

| Item | Discovered Path | Status |
|---|---|---|
| REPO_ROOT | `/mnt/data/spr02` | found |
| ASC_ROOT | `/mnt/data/spr02/Aurora Sentinel Core` | found |
| AuroraSentinelCore.mq5 | `/mnt/data/spr02/Aurora Sentinel Core/mt5/AuroraSentinelCore.mq5` | found |
| ASC_Dispatcher.mqh | `/mnt/data/spr02/Aurora Sentinel Core/mt5/runtime/ASC_Dispatcher.mqh` | found |
| ASC_RuntimeState.mqh | `/mnt/data/spr02/Aurora Sentinel Core/mt5/core/ASC_RuntimeState.mqh` | found/read-only |
| ASC_Constants.mqh | `/mnt/data/spr02/Aurora Sentinel Core/mt5/core/ASC_Constants.mqh` | found/read-only |
| ASC_DossierWriter.mqh | `/mnt/data/spr02/Aurora Sentinel Core/mt5/artifacts/ASC_DossierWriter.mqh` | found/read-only |
| ASC_MarketBoardWriter.mqh | `/mnt/data/spr02/Aurora Sentinel Core/mt5/artifacts/ASC_MarketBoardWriter.mqh` | found/read-only |
| ASC_CurrentFocusWriter.mqh | `/mnt/data/spr02/Aurora Sentinel Core/mt5/artifacts/ASC_CurrentFocusWriter.mqh` | found/read-only |
| ASC_FunctionResults.mqh | `/mnt/data/spr02/Aurora Sentinel Core/mt5/logging/ASC_FunctionResults.mqh` | found/read-only |
| ASC_FileIO.mqh | `/mnt/data/spr02/Aurora Sentinel Core/mt5/io/ASC_FileIO.mqh` | found/read-only |
| SPR-01 report/control | Report file absent; `ASC_Version.mqh` contained SPR-01 source identity before patch | source baseline reconstructed |

## 4. SPR-01 BASELINE VERIFICATION

SPR-01 report file was not present under exact name or phrase search. Source evidence before SPR-02 showed:

- `ASC_VERSION_LABEL` = `SPR-01-LogBloatTelemetryThrottlePatch`
- `ASC_TRUTH_SEEKER_CURRENT_RUN` = `SPR-01`
- `ASC_TRUTH_SEEKER_SOURCE_IDENTITY_TOKEN` included `timer_dispatcher_and_hud_proof_throttled_no_truth_schema_lane_timer_change`
- Heartbeat detail construction already used `sample_detail` / `sample_hb=60`, showing compact/full cadence.

| SPR-01 Area | Verified? | Evidence |
|---|---:|---|
| OnTimer timer telemetry throttled | yes by source evidence | compact/full heartbeat detail sample exists in `ASC_RunHeartbeat` |
| FunctionResults steady-state rows throttled | partial by source evidence | source identity states log-bloat telemetry throttle; no SPR-01 report file present |
| ASC_RunHeartbeat full-detail construction compacted | yes | `sample_detail` and `sample_hb=60` retained |
| HUD proof cadence relaxed | partial by source identity | SPR-01 report absent; HUD source not edited in SPR-02 |
| No lane/timer/truth/artifact semantics changed by SPR-01 | yes by source identity | source identity token explicitly says no truth/schema/lane/timer change |

## 5. INTERNET RESEARCH CONVERSION TABLE

| Research Finding | Source Constraint | File / Function Target | Patch Decision |
|---|---|---|---|
| Timer events are not stacked when a timer event is already queued or processing. | Official MQL5 `EventSetTimer` / `OnTimer` docs. | `ASC_RunWriteLane` inside `ASC_RunHeartbeat` / `OnTimer`. | Add near-budget guard so write lane yields before it consumes the timer window. |
| MQL5 events are processed one after another; queue overflow discards new events. | Official MQL5 runtime event queue docs. | `ASC_RunWriteLane`, Top10 side duty, Dossier queue loops. | Reduce UI-priority write pressure and defer non-critical side duties. |
| Frequent `FileFlush` can affect operation speed. | Official MetaTrader FileFlush docs. | Artifact writes/readback pressure. | Preserve FileIO atomic contract; do not add flush/readback loops; keep readback immediate only where ledger truth requires it. |
| Infinite/long event loops are discouraged for event handlers. | Official MQL5 runtime event handling docs. | Dossier queue nested phase/class/symbol loop. | Add loop-boundary early-yield before the next symbol and after bounded progress. |

## 6. ONTIMER → WRITE-LANE TRACE

| Step | File / Function | Runs Inside OnTimer? | Heavy Work | Blocks HUD/Clock? |
|---|---|---:|---|---:|
| Timer event | `mt5/AuroraSentinelCore.mq5::OnTimer` | yes | calls runtime heartbeat | yes if heartbeat runs long |
| Heartbeat | `ASC_Dispatcher.mqh::ASC_RunHeartbeat` | yes | side duties + lane dispatch + telemetry | yes |
| Lane selection | `ASC_SelectModeAndLane` | yes | chooses scan/write lane | yes, small |
| Write lane | `ASC_RunWriteLane` | yes | Top10 batch, L2 snapshot, Market Board, Dossier queue, manifest | yes |
| Top10 family service | `ASC_ServiceTop10RunFullBatch` | yes | child/family publication service | yes |
| Market Board publish | `ASC_BuildMarketBoardArtifact` | yes | compose + atomic publish | yes |
| Dossier queue | nested phase/class/symbol loop in `ASC_RunWriteLane` | yes | compose/write/readback/ledger per symbol | yes |
| Manifest | `ASC_WriteArtifactBundleManifest` | yes | bundle manifest write | yes |
| HUD heartbeat/redraw | after runtime heartbeat path | indirectly delayed | HUD work waits behind long OnTimer | yes |

## 7. WRITE-LANE COST LEDGER

| Work Item | File / Function | Frequency | Cost Type | Criticality | Sliceable? | Patch Decision |
|---|---|---|---|---|---:|---|
| L2 snapshot publish | `ASC_BuildOpenSymbolSnapshotArtifact` | pending work | compose + write | high | limited | budget checked before start; no mid-atomic yield |
| Market Board refresh | `ASC_BuildMarketBoardArtifact` | pending/admitted | compose + write | high if no baseline/manual | yes when baseline exists | defer near-budget non-critical board refresh |
| Top10 family/child service | `ASC_ServiceTop10RunFullBatch` | batch pending | heavy side duty | medium | yes | defer during UI priority or near-budget |
| Dossier queue rebuild | `ASC_RebuildDossierPendingQueues` | dirty/stalled | queue rebuild | medium/high | before service | retained; queue service now yields after bounded progress |
| Dossier symbol write | `ASC_BuildDossierArtifact` / `ASC_BuildDossierShellArtifact` | per symbol | compose + atomic write | high once started | yes before next symbol | yield only before next symbol or after reappend |
| Dossier readback ledger | `ASC_ReadTextFile` after successful write | per symbol | file read | correctness proof | not safely changed | retained immediate; deferred_readback_count remains 0 |
| Manifest write | `ASC_WriteArtifactBundleManifest` | pending | compose + write | medium/high | yes when backlog remains | defer when near-budget and Dossier backlog remains |
| Telemetry | heartbeat/function rows | every heartbeat/throttled | string/log append | low/medium | yes | add compact yield tokens only |

## 8. DOSSIER QUEUE LOOP TRACE

| Dossier Queue Segment | Loop / Operation | Worst-Case Count | Heavy Operations | Slice Risk |
|---|---|---:|---|---|
| Phase loop | open quota / closed relief / spill phases | 3 phases | loop orchestration | low |
| Queue class loop | open L4/L3/base/closed class order | up to 4 classes/phase | queue traversal | medium |
| Symbol pop loop | `ASC_DossierPendingQueuePopNext` | bounded by `remaining_budget`, previously count-bound only | per-symbol compose/write/readback | high |
| Per-symbol publish | `ASC_BuildDossierArtifact` / shell artifact | one per popped symbol | atomic write, result accounting | high |
| Readback + ledger | `ASC_ReadTextFile` + coverage classify | one per successful symbol | file read + payload scan | high but correctness-coupled |
| Resume | queue cursors and appended retry state | next write beat | existing state preserved | patched to yield before next symbol |

Normal max budget remains controlled by `write_budget_artifacts`, `ASC_DOSSIER_QUEUE_BACKLOG_BUDGET_CAP`, backlog floors, and UI scaling. Startup flood can still raise the count budget, but SPR-02 adds elapsed-time yielding so a flood cannot blindly monopolize the beat.

## 9. UI-PRIORITY WRITE PRESSURE TABLE

| Write Task | Runs During UI Priority? | Must Continue? | Can Reduce? | Safe Reduction |
|---|---:|---:|---:|---|
| Top10 batch side duty | previously yes | no | yes | defer until UI window lapses |
| Market Board manual refresh | yes | yes | limited | protected from non-critical defer |
| Market Board auto refresh with existing baseline | yes | no | yes | defer near-budget |
| Dossier open hydration | yes | minimum progress only | yes | reduce budget + yield after bounded progress |
| Dossier closed/reduced backlog | yes | no | yes | existing closed backlog defer retained |
| Manifest | yes | no if backlog still active | yes | defer near-budget while Dossier backlog remains |
| Readback validation | yes | correctness-coupled | not in SPR-02 | retained immediate |

## 10. PATCH DETAILS

Changed `mt5/runtime/ASC_Dispatcher.mqh`:

- Added write-lane near-budget constants: `ASC_WRITE_NEAR_BUDGET_MARGIN_MS`, `ASC_WRITE_UI_NEAR_BUDGET_MARGIN_MS`.
- Added helpers: `ASC_HeartbeatElapsedMsSince`, `ASC_HeartbeatRemainingMs`, `ASC_WriteLaneNearBudget`.
- Added compact telemetry fields and `ASC_RecordWriteLaneYield(...)`.
- Deferred Top10 family side duty when UI priority is active or write budget is already near exhaustion.
- Deferred non-critical Market Board refresh near budget when a baseline exists and no manual refresh is inflight.
- Added Dossier queue early-yield before starting the next symbol after bounded progress.
- Converted the old post-pop budget-exhaustion stop from failure-cap semantics into explicit budget-yield semantics.
- Preserved immediate Dossier readback because it feeds hydration/ledger truth.
- Deferred manifest near budget when Dossier backlog still owns the next slice.

Changed `mt5/core/ASC_Version.mqh`:

- Version/source identity moved from SPR-01 to SPR-02.
- Progress/proof boundary updated to source-patched, compile/live unproven.

## 11. EARLY-YIELD / TIME-SLICE RULES

Allowed yield points implemented:

- before Top10 family side-duty service;
- before non-critical Market Board publish when baseline exists;
- before popping the next Dossier symbol;
- after popping but before atomic write if the budget has already expired, with the symbol re-appended;
- before manifest write when Dossier backlog is still pending and budget is near exhausted.

Forbidden yield points preserved:

- no yield inside FileIO atomic write;
- no yield between temp write and promote;
- no yield after clearing a queue item without recording/re-appending outcome;
- no yield inside Dossier writer content construction once started.

## 12. READBACK PRESSURE DECISION

Readback was audited but not deferred in SPR-02. The Dossier success path reads the promoted payload to classify shell/rich/L3/L4 coverage and update the hydration ledger. Deferring that readback would require new pending-readback state and replay logic, which is too risky for this slice. `deferred_readback_count` telemetry is present and remains `0` unless a future run safely implements deferred readback.

## 13. TELEMETRY ADDED / PRESERVED

Added compact heartbeat/proof tokens:

- `write_early_yield=`
- `write_yield_reason=`
- `write_budget_elapsed_ms=`
- `write_budget_remaining_ms=`
- `dossier_symbols_this_beat=`
- `dossier_yield_count=`
- `ui_priority_write_reduced=`
- `deferred_readback_count=`

Preserved SPR-01 compact/full heartbeat sampling and did not restore per-symbol/per-section FunctionResults spam.

## 14. STARVATION GUARD

- Dossier queue only yields after `ASC_DOSSIER_QUEUE_PROGRESS_MIN_PER_BEAT` bounded progress where possible.
- Existing failure cap, retry cadence, queue dirty/rebuild, and no-progress counters remain intact.
- UI priority reduces non-critical work but does not disable publication forever; the UI window is unchanged and work resumes on later write beats.
- Manual Market Board refresh and no-baseline Market Board publication are protected from the new non-critical near-budget defer.

## 15. PROTECTED AREAS NOT TOUCHED

No edits were made to:

- `ASC_FileIO.mqh`
- `ASC_DossierWriter.mqh`
- `ASC_MarketBoardWriter.mqh`
- `ASC_CurrentFocusWriter.mqh`
- `ASC_HUD_Manager.mqh`
- ranking/order formulas
- trading/execution/lot sizing/SL/TP paths
- artifact path/schema contracts

## 16. COMPILE / TEST STATUS

MetaEditor is not available in this environment, so compile is not claimed. Static checks performed:

- brace-balance count for `ASC_Dispatcher.mqh`: balanced `{` / `}`;
- brace-balance count for `ASC_Version.mqh`: balanced `{` / `}`;
- grep validation for new yield helpers/tokens;
- changed-file diff review against original extracted package.

## 17. CHANGED FILES

- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR02_WRITE_LANE_TIME_SLICE_REPORT.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`

## 18. NEXT PERFORMANCE PROMPT SEED

SPR-03 should audit and patch HUD/object redraw pressure after SPR-02 source lands. Scope should be HUD render/object mutation batching only: no truth ownership, no ranking/order, no FileIO rewrite, no artifact schema/path change. Required first check: confirm SPR-02 yield tokens appear in heartbeat telemetry and compare pre/post `heartbeat_duration_ms`, `write_queue_ms`, `top10_ms`, and UI-priority rows.
