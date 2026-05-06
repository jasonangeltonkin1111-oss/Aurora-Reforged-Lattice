# ARL_RUN012_REPORT

Date: 2026-05-06
Run: ARL-RUN012
State: TEST FIRST

## Scope
Runtime file output rescue for Status_Current.json and Manifest_Current.json under FILE_COMMON.

## Contradiction Ledger
- Claim A: RUN011 notes implied nested write path may be auto-created.
- Claim B: Operator observed no ARL output folder/files after attach.
- Resolution: explicit folder-chain creation remains mandatory; added publish preflight + compact publish result line with last_error and folder_ready.

## Operator Smoke
1. Compile `Work Area/mt5/ARL_Core.mq5`.
2. Attach EA and set `InpARL_EnableFileWrites=true`, `InpARL_AllowTrading=false`, `InpARL_PrintStartupSummary=true`.
3. Wait >=3 timer cycles.
4. Verify Experts log lines for preflight/publish results and open printed common folder path.
5. Confirm `Status_Current.json` and `Manifest_Current.json` exist and contain run/version fields.

## Compile/Runtime Evidence
- MetaEditor compile unavailable in this environment.
- MT5 runtime unavailable in this environment.
