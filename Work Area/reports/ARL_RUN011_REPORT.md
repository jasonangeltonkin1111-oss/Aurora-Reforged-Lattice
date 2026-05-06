# ARL-RUN011 Report — Runtime Output Path Verification + Status/Manifest Write Smoke Prep

Run date: 2026-05-06  
Mode: AUDIT + RESEARCH + DEBUG + PATCH + RUNTIME SMOKE PREP  
Source package: current uploaded RUN010R Work Area package  
Output package: `ARL_RUN011_RUNTIME_OUTPUT_PATH_VERIFICATION.zip`

---

## 1. Bottom Line

RUN010R had user-supplied compile evidence:

```text
0 errors, 0 warnings, 491 ms elapsed, cpu='AVX2 + FMA3'
```

That proves compile only for the incoming RUN010R baseline. It did **not** prove runtime publication.

RUN011 found the real blocker: `OnTimer()` only called heartbeat and scheduler. It did **not** call `ARL_StatusWriter_Publish()`. Therefore the EA could compile cleanly and still write no `Status_Current.json` or `Manifest_Current.json`.

RUN011 patched the owner path by wiring status/manifest publication into `OnTimer()`, adding startup path diagnostics, and exposing final/temp path + file mode fields in status/manifest payloads.

Current decision: TEST FIRST. RUN011 source changed after the RUN010R compile result, so the next proof must be a fresh MetaEditor compile and MT5 runtime smoke.

---

## 2. Audit Results

Active root confirmed:

```text
Work Area/
```

Archives check:

```text
No Archives folder found inside uploaded Work Area package.
```

Required source files confirmed present:

```text
Work Area/mt5/ARL_Core.mq5
Work Area/mt5/io/ARL_Paths.mqh
Work Area/mt5/io/ARL_FilePublisher.mqh
Work Area/mt5/io/ARL_PublicationManifest.mqh
Work Area/mt5/telemetry/ARL_StatusWriter.mqh
Work Area/mt5/runtime/ARL_Heartbeat.mqh
Work Area/mt5/runtime/ARL_Scheduler.mqh
Work Area/mt5/telemetry/ARL_RuntimeMetrics.mqh
Work Area/roadmap/ARL_ROADMAP_COMPLETION_STATUS.md
```

Mandatory guides read if present:

```text
Work Area/AGENTS.md
Work Area/WORK_AREA_INDEX.md
Work Area/GPT_CODEX_README.md
Work Area/office/ARL_MANDATORY_READ_INDEX.md
Work Area/roadmap/ARL_ROADMAP_COMPLETION_STATUS.md
Work Area/brain/AURORA_BRAIN_GUIDEBOOK_INDEX.md
Work Area/brain/AURORA_CODING_BRAIN_GUIDEBOOK.md
Work Area/brain/AURORA_RESEARCH_BRAIN_GUIDEBOOK.md
Work Area/brain/AURORA_FAILURE_PATTERNS_GUIDEBOOK.md
Work Area/roadmap/ARL_GPT_ZIP_WORKFLOW.md
Work Area/roadmap/ARL_EVIDENCE_AND_PROOF_LANGUAGE_GUIDE.md
Work Area/roadmap/ARL_ARCHIVE_MINING_GUIDE.md
Work Area/mt5/MT5_AGENT_IMPLEMENTATION_GUIDE.md
Work Area/mt5/MT5_MODULE_OWNERSHIP.md
Work Area/mt5/MT5_VERSION_POLICY.md
Work Area/mt5/MT5_INCLUDE_BOUNDARY_PLAN.md
```

Missing from the explicit requested read list:

```text
None from the list above were missing.
```

---

## 3. Official MQL5 Research Converted to Constraints

### 3.1 FILE_COMMON / sandbox finding

Official MQL5 docs say file work is sandboxed. Without `FILE_COMMON`, `FileOpen()` works under the client terminal `MQL5\Files` folder; with `FILE_COMMON`, it works under the shared common folder for all MetaTrader 5 client terminals.

Constraint:

```text
If ARL publisher uses FILE_COMMON, operator verification must check Terminal Common\Files, not terminal-local MQL5\Files.
```

Owner files:

```text
mt5/io/ARL_Paths.mqh
mt5/io/ARL_FilePublisher.mqh
mt5/telemetry/ARL_StatusWriter.mqh
mt5/io/ARL_PublicationManifest.mqh
```

Acceptance test:

```text
Experts log prints COMMON_FILES mode and common-files base path.
Status/manifest payloads include file_location_mode=COMMON_FILES.
```

Falsifier:

```text
Source uses FILE_COMMON but report/operator checks terminal-local MQL5\Files.
```

### 3.2 Subfolder behavior finding

Official MQL5 docs state that when a file is opened for writing, missing subfolders specified in the path are created inside the allowed sandbox.

Constraint:

```text
The writer may write nested relative paths under the sandbox, but temp-write failures must report final/temp paths and not create a duplicate route.
```

Owner file:

```text
mt5/io/ARL_FilePublisher.mqh
```

Acceptance test:

```text
Temp write failure message includes final_path and temp_path.
```

Falsifier:

```text
Nested folder failure is silent or patched by adding a second writer.
```

### 3.3 FileIsExist / FileMove flag consistency finding

Official MQL5 docs state `FileIsExist()` and `FileMove()` accept a common/local flag. `FileMove()` needs `FILE_REWRITE` to overwrite an existing destination.

Constraint:

```text
ARL must use the same common/local area for write, readback, existence, delete, move, and final readback.
```

Owner file:

```text
mt5/io/ARL_FilePublisher.mqh
```

Acceptance test:

```text
Write/read/exist/delete/move use FILE_COMMON consistently; move uses FILE_COMMON|FILE_REWRITE.
```

Falsifier:

```text
Temp file exists in common folder, but promote/readback checks local folder or refuses overwrite.
```

### 3.4 Timer finding

MQL5 supports timer events via `EventSetTimer()` and `OnTimer()`. But a timer only proves calls to code actually inside the handler.

Constraint:

```text
OnTimer must call ARL_StatusWriter_Publish or the status writer cannot publish from runtime.
```

Owner file:

```text
mt5/ARL_Core.mq5
```

Acceptance test:

```text
OnTimer calls heartbeat, scheduler, status writer publication, and runtime metrics.
```

Falsifier:

```text
OnTimer ticks heartbeat/scheduler but never calls status writer.
```

---

## 4. Output Path Audit

### 4.1 ARL_Paths.mqh

Exact current path functions after RUN011:

```text
ARL_OUTPUT_ROOT_FOLDER = "Aurora Reforged Lattice"
ARL_Paths_ServerFolder() = "Default"
ARL_Paths_CurrentFolder() = "Aurora Reforged Lattice/Default/Current"
ARL_Paths_StatusCurrent() = "Aurora Reforged Lattice/Default/Current/Status_Current.json"
ARL_Paths_ManifestCurrent() = "Aurora Reforged Lattice/Default/Current/Manifest_Current.json"
ARL_Paths_TempFor(final_path) = final_path + ".tmp"
ARL_Paths_CommonFlag() = FILE_COMMON
ARL_Paths_FileLocationMode() = "COMMON_FILES"
```

Expected relative paths:

```text
Aurora Reforged Lattice/Default/Current/Status_Current.json
Aurora Reforged Lattice/Default/Current/Status_Current.json.tmp
Aurora Reforged Lattice/Default/Current/Manifest_Current.json
Aurora Reforged Lattice/Default/Current/Manifest_Current.json.tmp
```

Expected base path when `FILE_COMMON` is used:

```text
TerminalInfoString(TERMINAL_COMMONDATA_PATH) + "\\Files"
```

Typical Windows shape:

```text
%APPDATA%\MetaQuotes\Terminal\Common\Files\Aurora Reforged Lattice\Default\Current\
```

RUN011 added startup log diagnostics:

```text
ARL paths: mode=COMMON_FILES | common_files_base=<TerminalInfoString(TERMINAL_COMMONDATA_PATH)>\Files | status_current=Aurora Reforged Lattice/Default/Current/Status_Current.json | manifest_current=Aurora Reforged Lattice/Default/Current/Manifest_Current.json
```

### 4.2 ARL_FilePublisher.mqh

Confirmed source behavior:

```text
FileOpen readback: FILE_READ|FILE_TXT|FILE_ANSI|FILE_COMMON|FILE_SHARE_READ
FileOpen temp write: FILE_WRITE|FILE_TXT|FILE_ANSI|FILE_COMMON|FILE_SHARE_READ
FileIsExist final: FILE_COMMON
FileIsExist temp: FILE_COMMON
FileDelete temp: FILE_COMMON
FileMove promote: source FILE_COMMON, mode FILE_COMMON|FILE_REWRITE
Final readback: FILE_COMMON
```

Publication chain:

```text
required token check
no-change current readback skip
stale temp delete
write temp
flush temp
close temp
read temp back
hash compare
FileMove temp -> current with FILE_REWRITE
read current back
hash compare
return result with paths, bytes, code, message, signature
```

RUN011 strengthened messages so failures include final/temp path context.

### 4.3 ARL_StatusWriter.mqh

Confirmed / patched status payload now includes:

```text
product_name
product_version
run_id
product_channel
product_state
permission_text
generated_server_time
generated_utc_time
heartbeat_count
heartbeat_status
scheduler_tick_count
scheduler_status
last_cycle_ms
max_cycle_ms
timer_seconds
work_budget_ms
file_writes_enabled
file_location_mode
status_final_path
status_temp_path
manifest_final_path
manifest_temp_path
trade_permission=false
signal_permission=false
execution_permission=false
hud_permission=false
status_publication_result
manifest_publication_result
last_error_code
last_error_source
last_error_message
```

### 4.4 ARL_PublicationManifest.mqh

Confirmed / patched manifest payload now includes:

```text
product_name
product_version
run_id
artifact_name
final_path
temp_path
file_location_mode
publish_status
readback_status
no_change_skip
payload_size
generated_time
permission_boundary
proof_boundary
```

### 4.5 ARL_Core.mq5

Incoming RUN010R state:

```mql5
void OnTimer()
  {
   ARL_Heartbeat_Tick();
   ARL_Scheduler_Tick();
  }
```

That was the runtime-output blocker.

RUN011 patched it to:

```mql5
void OnTimer()
  {
   uint cycle_start = GetTickCount();

   ARL_Heartbeat_Tick();
   ARL_Scheduler_Tick();

   ARL_StatusWriter_Publish(InpARL_EnableFileWrites,
                             InpARL_TimerSeconds,
                             InpARL_WorkBudgetMs);

   ARL_RuntimeMetrics_RecordCycle((int)(GetTickCount() - cycle_start));
  }
```

File writes input:

```text
InpARL_EnableFileWrites = false by default
```

Smoke implication:

```text
The operator must set InpARL_EnableFileWrites=true for runtime write smoke.
```

---

## 5. Version Decision

RUN011 changed active runtime behavior, so version identity was advanced:

```text
#property version: 1.006
ARL_PRODUCT_VERSION: 1.006
ARL_PRODUCT_RUN_ID: ARL-RUN011
ARL_PRODUCT_CHANNEL: RUNTIME_OUTPUT_PATH_VERIFICATION
ARL_PRODUCT_STATE: RUNTIME_OUTPUT_PATH_VERIFICATION_NO_TRADING
```

This version bump does not prove compile or runtime output. It only identifies the new intended runtime behavior.

---

## 6. Static Validation Performed Here

Static quote/brace validation checked these files:

```text
mt5/ARL_Core.mq5
mt5/io/ARL_Paths.mqh
mt5/io/ARL_FilePublisher.mqh
mt5/io/ARL_PublicationManifest.mqh
mt5/telemetry/ARL_StatusWriter.mqh
mt5/telemetry/ARL_RuntimeMetrics.mqh
mt5/runtime/ARL_Heartbeat.mqh
mt5/runtime/ARL_Scheduler.mqh
mt5/core/ARL_Version.mqh
```

Result:

```text
quote parity: no bad lines found
brace delta: 0 for checked files
```

Forbidden behavior grep found only no-permission boundary text, not trading implementation:

```text
No OrderSend / CTrade buy/sell implementation was added in changed source scope.
```

MetaEditor compile:

```text
Not run in this environment.
```

Runtime smoke:

```text
Not run in this environment.
```

---

## 7. Operator Runtime Smoke Instructions

Use this exact verification path:

1. Compile `Work Area/mt5/ARL_Core.mq5` in MetaEditor.
2. Confirm compile output is recorded exactly.
3. Attach EA to a chart.
4. Set:

```text
InpARL_EnableFileWrites = true
InpARL_AllowTrading = false
InpARL_PrintStartupSummary = true
```

5. Check Experts log for:

```text
ARL paths: mode=COMMON_FILES
ARL file writes input: InpARL_EnableFileWrites=true
```

6. Open the common files folder. The EA prints the base path, but the expected form is:

```text
%APPDATA%\MetaQuotes\Terminal\Common\Files\Aurora Reforged Lattice\Default\Current\
```

7. Confirm these files exist:

```text
Status_Current.json
Manifest_Current.json
```

8. Confirm both files contain:

```text
"run_id":"ARL-RUN011"
"product_version":"1.006"
"file_location_mode":"COMMON_FILES"
```

9. Confirm no temporary-only failure remains:

```text
Status_Current.json.tmp should not be the only updated artifact.
Manifest_Current.json.tmp should not be the only updated artifact.
```

10. If writes do not appear, collect:

```text
Experts log lines
Status/manifest temp files if any
InpARL_EnableFileWrites value
common_files_base path from log
last_error_code / last_error_message if present in payload
```

---

## 8. Changed Files

```text
Work Area/brain/AURORA_CODING_BRAIN_GUIDEBOOK.md
Work Area/brain/AURORA_FAILURE_PATTERNS_GUIDEBOOK.md
Work Area/mt5/ARL_Core.mq5
Work Area/mt5/core/ARL_Version.mqh
Work Area/mt5/io/ARL_FilePublisher.mqh
Work Area/mt5/io/ARL_Paths.mqh
Work Area/mt5/io/ARL_PublicationManifest.mqh
Work Area/mt5/telemetry/ARL_StatusWriter.mqh
Work Area/office/ARL_ACCEPTANCE_TESTS.md
Work Area/office/ARL_CHANGE_LEDGER.md
Work Area/office/ARL_DECISIONS.md
Work Area/office/ARL_RESEARCH_LEDGER.md
Work Area/office/ARL_RISK_LEDGER.md
Work Area/roadmap/ARL_ROADMAP_COMPLETION_STATUS.md
Work Area/reports/ARL_RUN011_REPORT.md
```

---

## 9. Explicit Non-Changes / Forbidden Scope Preserved

Not added:

```text
account scanning
universe implementation
market state layer
broker spec layer
indicators
ranking
Market Board
Symbol Trader Pack
Dossier
HUD
trading
signals
execution
strategy formulas
direct archive copy
duplicate publisher
duplicate status writer
new output route
changelog .mqh
```

---

## 10. Final Decision

TEST FIRST.

Strongest next move:

```text
Compile RUN011 source, attach with InpARL_EnableFileWrites=true, and verify Status_Current.json + Manifest_Current.json under the printed COMMON_FILES path.
```
