# ARL-RUN013 Report — Compile/Runtime Evidence Attempt

Date: 2026-05-06
Decision: TEST FIRST

## Requested evidence
1. Compile `Work Area/mt5/ARL_Core.mq5` with exact output.
2. Capture Experts logs for `OnInit`, timer heartbeat, resolved paths, folder-chain creation, temp write, promote/publish, and error details.
3. Verify `Status_Current.json`, `Manifest_Current.json`, and temp lifecycle at exact expected path.

## Environment check
- `metaeditor64.exe`: not found
- `metaeditor.exe`: not found
- `wine`: not found
- `mql5compiler`: not found

## Compile result
Compile not run in this environment because no MT5 compiler binary is available.

## Runtime result
Runtime not run in this environment because no MT5 terminal/runtime process is available.

## Output artifact verification
File verification not possible without runtime execution creating artifacts.

## Expected runtime output path to verify in MT5 terminal
`<TERMINAL_COMMONDATA_PATH>/Files/Aurora Reforged Lattice/Default/Current/`

Expected files:
- `Status_Current.json`
- `Manifest_Current.json`
- Temp lifecycle files: `Status_Current.json.tmp`, `Manifest_Current.json.tmp`

## Changed files package scope
Documentation/evidence-only update. No MT5 source owner file changes in this run.
