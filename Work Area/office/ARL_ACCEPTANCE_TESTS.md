# ARL Acceptance Tests

## Purpose

This file defines tests required before module locks.

## Global forbidden claims

No run may claim:
- live trading readiness
- strategy edge
- prop-firm safety
- execution safety
- compile proof
- runtime proof

unless the evidence exists.

## Global required checks

Every source run must check:
- No HUD unless explicitly scoped later.
- No trading/execution/entry/stop/target logic.
- No copied ASC source without migration record.
- No new alternate routes.
- Office files updated.
- Change ledger updated.

---

## TEST-001 — Atomic status publish

Scope:
Runtime / FilePublisher.

Pass condition:
- Writes temp file.
- Validates temp.
- Promotes to current.
- Manifest records success.
- Current file remains intact if temp validation fails.

Falsifier:
Partial temp content appears in current output.

---

## TEST-002 — Warmup completion gate

Scope:
Warmup / Scheduler.

Pass condition:
READY requires:
- account ready
- universe ready
- market state classified
- specs classified
- L3 complete
- L4 complete
- board atomic publish success

Falsifier:
READY with L3 or L4 incomplete.

---

## TEST-003 — L3 snapshot commit

Scope:
Surface Ranking.

Pass condition:
L3 current promotes only complete snapshot with:
- snapshot_id
- scoring_version
- processed_count
- eligible_count
- required numeric fields
- exact broker symbols

Falsifier:
Layer 4 consumes L3 staging/in-progress file.

---

## TEST-004 — L4 snapshot commit

Scope:
Bucket Ranking.

Pass condition:
L4 current promotes only if:
- consumes committed L3 snapshot
- Global Top 10 complete or insufficient population stated
- Top 5 per major bucket complete or available_count_below_target
- Top 5 per minor bucket complete or available_count_below_target
- active_l4_set deduped

Falsifier:
Major/minor bucket output uses forex-pair major/minor meaning instead of hierarchy.

---

## TEST-005 — Ready cadence

Scope:
Scheduler.

Pass condition:
After READY:
- L3 every 20 minutes
- L4 every 20 minutes, 5 minute offset
- L2 every 1 minute for active L4 set
- L5 every 5 minutes for active L4 set

Falsifier:
L5 runs full universe by default.

---

## TEST-006 — Market State retry law

Scope:
Market State.

Pass condition:
- Confirmed open stops open/closed retries.
- Confirmed closed schedules next open if known.
- Unknown uses bounded backoff.
- Retry exhaustion marks degraded, not fake closed/open.

Falsifier:
Confirmed open symbol remains in retry queue.

---

## TEST-007 — Account exposure requirement

Scope:
Account / Market Board.

Pass condition:
Board READY requires account snapshot or explicit account_unavailable status.
Open positions and pending orders counted separately.
Exposure affects upload suggestion.

Falsifier:
Upload suggestion ignores open/pending conflict.

---

## TEST-008 — Indicator readiness

Scope:
Indicators / ATR.

Pass condition:
- handle created once
- CopyBuffer partial/-1 becomes BUILDING/PARTIAL/FAILED
- no fake ATR zero with READY
- handle released on deinit

Falsifier:
ATR=0 with READY after failed CopyBuffer.

---

## TEST-009 — Numeric-first output

Scope:
Market Board / Dossier.

Pass condition:
Every qualitative label has numeric value or is optional display-only.
Scores show timeframe/source/freshness where relevant.

Falsifier:
"Strong" or "Expanding" appears alone with no score.

---

## TEST-010 — Dossier missingness cleanup

Scope:
Dossier.

Pass condition:
Required missing fields visible.
Optional missing fields summarized.
Irrelevant missing fields hidden from operator view and available only in debug JSON.

Falsifier:
FX dossier degraded because ISIN/country missing.

---

## TEST-011 — No route bypass repair

Scope:
All patches.

Pass condition:
Fix modifies owner file/module.

Falsifier:
Patch creates new parallel writer or output to bypass owner defect without approved route-change record.

---

## TEST-012 — Lock qualification

Scope:
All modules.

Pass condition:
Module can be locked only after:
- compile pass if source exists
- output contract pass
- runtime smoke pass where applicable
- no protected-route mutation
- no trade permission leak
- lock file created

Falsifier:
Module marked done without lock file or test evidence.

---

## TEST-006 — Version identity parity

Scope:
MT5 source identity and office records.

Pass condition:
- `mt5/ARL_Core.mq5` `#property version` matches `mt5/core/ARL_Version.mqh` `ARL_PRODUCT_VERSION`.
- EA description uses the same version string.
- MT5 README uses the same version string.
- Office ledger records whether the run was a behavior bump or maintenance alignment.

Falsifier:
Any active identity file reports a different current version.

---

## TEST-007 — No-trade / no-HUD scaffold preservation

Scope:
Whole Work Area package.

Pass condition:
- No HUD module is added.
- No trade, signal, execution, stop, target, lot, order-send, or prop-firm permission path is added.
- `InpARL_AllowTrading` remains false by default and startup rejects true in scaffold mode.

Falsifier:
A source grep finds trading/execution/HUD behavior outside explicit no-permission boundary text.

---

## TEST-008 — Research proof honesty

Scope:
Run reports and office research ledger.

Pass condition:
- If live web research is unavailable, the run says so.
- No uncited internet claim is treated as fresh evidence.
- Future research-capable runs cite official/primary sources and convert findings into constraints/tests/falsifiers.

Falsifier:
Report says external research was completed when no live source access existed.

## ARL-RUN007 Acceptance Addendum

Minimum acceptance before first real implementation run:

1. `Work Area/` is the only active uploaded source root.
2. Uploaded package excludes `Archives/`.
3. Git current Work Area state is checked after research.
4. RUN006 trader-data reference files are confirmed present or absence is logged.
5. `ARL_Core.mq5` version and `ARL_Version.mqh` version agree.
6. Product version decision is recorded in MT5 policy and office decisions.
7. Git summary/description standard is documented.
8. Trader-data-first law is referenced by office, roadmap, and blueprint.
9. MT5 remains no-HUD/no-trade/no-signal/no-execution.
10. Include scan finds no missing includes.
11. Duplicate-function scan finds no duplicate active function definitions.
12. No cosmetic module risk is left unreported.
13. Compile is reported only if MetaEditor output exists.
14. Output package excludes Archives.
15. `Work Area/ARL_RUN007_REPORT.md` exists.


---

## TEST-009 — Runtime IO foundation acceptance

Scope:
RUN009 runtime heartbeat, scheduler, status writer, file publisher, manifest writer, and permission boundary.

Pass condition:
- `ARL_Core.mq5` `#property version` is `1.005`.
- `ARL_PRODUCT_VERSION` is `1.005`.
- `ARL_PRODUCT_RUN_ID` is `ARL-RUN009`.
- `OnTimer()` stays bounded: heartbeat, scheduler/status publication, and metrics only.
- `Status_Current.json` payload includes product identity, timestamps, heartbeat count, scheduler tick count, cycle metrics, timer/work budget, file-write status, publication status, and all permission fields false.
- `Manifest_Current.json` payload includes artifact name, final path, temp path, publish status, readback status, no-change flag, payload size, permission boundary, and proof boundary.
- File publication uses temp/write/flush/close/readback/promote/final-readback flow.
- No account, universe, layers, Market Board, dossier, HUD, trading, signal, execution, or strategy formula module is implemented.

Falsifier:
Any direct current write without temp/readback, version mismatch, heavy `OnTimer` loop, true permission flag, missing manifest, missing readback result, compile claim without compile output, or runtime claim without terminal evidence.


---

## TEST-010R — Runtime IO compile-repair acceptance

Scope:
ARL-RUN010R changed source and control files only.

Pass condition:
- `ARL_Paths.mqh` uses compile-safe path separators and does not contain raw invalid `"` path fragments.
- `ARL_FilePublisher_ResultJson`, `ARL_PublicationManifest_Compose`, and `ARL_StatusWriter_ComposePayload` use escaped JSON quotes.
- `ARL_Core.mq5` includes providers before consumers.
- Main EA `#property version` matches `ARL_PRODUCT_VERSION`.
- No forbidden module families are patched.
- MetaEditor compile is either recorded exactly or honestly marked unavailable.

Falsifier:
`closing quote expected`, `Current undeclared`, downstream include avalanche from malformed string syntax, stale main EA version property, forbidden module edits, or compile success claimed without exact compiler output.

---

## TEST-011 — Runtime output path verification and status/manifest smoke

Scope:
ARL-RUN011 timer publication path, common-files path diagnostics, status payload, manifest payload, and no-trade boundary.

Pass condition:
- `ARL_Core.mq5` `#property version` is `1.006`.
- `ARL_PRODUCT_VERSION` is `1.006`.
- `ARL_PRODUCT_RUN_ID` is `ARL-RUN011`.
- `OnInit()` initializes path/output/publisher/manifest/runtime-metrics/status owners.
- Startup Experts log prints `ARL_Paths_DiagnosticLine()` and `InpARL_EnableFileWrites` state.
- `OnTimer()` calls `ARL_Heartbeat_Tick()`, `ARL_Scheduler_Tick()`, `ARL_StatusWriter_Publish(...)`, and `ARL_RuntimeMetrics_RecordCycle(...)`.
- `InpARL_EnableFileWrites` remains false by default; runtime smoke requires the operator to set it true.
- Status payload includes file writes enabled/disabled, file location mode, status final/temp path, manifest final/temp path, publication result, and last error fields.
- Manifest payload includes artifact name, final path, temp path, file location mode, no-change skip, readback result, publish status, payload size, and generated time.
- Publisher uses `FILE_COMMON` consistently for write/read/exist/delete/move and `FILE_REWRITE` on promote.
- No account scanning, universe implementation, ranking, Market Board, Dossier, HUD, trading, signal, execution, strategy formula, duplicate writer, duplicate publisher, or direct archive copy is added.

Runtime smoke operator check:
1. Compile `Work Area/mt5/ARL_Core.mq5` in MetaEditor.
2. Attach EA to a chart.
3. Set `InpARL_EnableFileWrites=true`.
4. Keep `InpARL_AllowTrading=false`.
5. Check Experts log for `ARL paths: mode=COMMON_FILES`.
6. Open `%APPDATA%\\MetaQuotes\\Terminal\\Common\\Files\\Aurora Reforged Lattice\\Default\\Current\\` or the path printed from `TerminalInfoString(TERMINAL_COMMONDATA_PATH) + "\\Files"`.
7. Confirm `Status_Current.json` and `Manifest_Current.json` exist.
8. Confirm both files update after timer ticks and contain `run_id=ARL-RUN011` / `product_version=1.006`.

Falsifier:
Clean compile but no timer publication call, files written under a different sandbox than reported, status/manifest missing path fields, output exists only as `.tmp`, or any permission flag becomes true.


---

## TEST-011R — Runtime file-write repair acceptance

Scope:
ARL-RUN011R common-files folder-chain creation, failure-loud diagnostics, and runtime smoke preparation.

Source pass condition:
- `ARL_Core.mq5` still calls `ARL_StatusWriter_Publish(...)` from `OnTimer()`.
- `ARL_Paths.mqh` identifies `COMMON_FILES`, common data path, common files base, terminal data path, terminal files base, relative status path, relative manifest path, and expected Common Files status/manifest path patterns.
- `ARL_Paths.mqh` creates `Aurora Reforged Lattice`, `Aurora Reforged Lattice/Default`, and `Aurora Reforged Lattice/Default/Current` using `FILE_COMMON` before nested publication.
- `ARL_FilePublisher.mqh` uses the same `FILE_COMMON` mode for write/read/exist/delete/move and keeps `FILE_REWRITE` for promotion.
- Failures include path, code, folder diagnostic, and `GetLastError()` where applicable.
- Disabled writes clearly log that no files will be written and that smoke requires `InpARL_EnableFileWrites=true`.
- No forbidden modules are changed.

Compile pass condition:
Exact MetaEditor output shows `0 errors` for `Work Area/mt5/ARL_Core.mq5` after RUN011R.

Runtime pass condition:
With `InpARL_EnableFileWrites=true`, Experts prints the exact Common Files path and confirms status/manifest publish OK; `Status_Current.json` and `Manifest_Current.json` exist under that printed path.

Falsifier:
Folder-chain creation is absent, `FileOpen()` fails without logged error, path diagnostics point to common files while user checks only local files, only the probe file exists, or any trading/signal/execution behavior appears.

- 2026-05-06 ARL-RUN012: Runtime file output rescue updated folder-chain proof/preflight diagnostics and publish-result logging; runtime validation required in MT5 terminal.
