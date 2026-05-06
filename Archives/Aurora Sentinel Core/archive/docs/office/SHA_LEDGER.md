# Aurora Sentinel Core — SHA Ledger

## Purpose

Compact integrity checkpoint for active ASC control/runtime/office surfaces touched by the latest implementation pass.

## Current checkpoint

- checkpoint date: 2026-04-06
- checkpoint scope: Layer-5 explicit pair-write/ownership hardening pass (deep-priority write admission + ownership lock + failure-family status hardening)
- hash type: SHA-256
- note: this ledger does not hash itself

## Entries

```text
ddc17fb69b4d0fbaf0bbfff98950b20a92ce9ca7a6346a18aa462ea1613b6075  Aurora Sentinel Core/mt5/runtime/ASC_Dispatcher.mqh
94a6e95d597d6874cb345a4b13cb5bec77d4a6f10c6961a2e40ec747e6630c20  Aurora Sentinel Core/mt5/core/ASC_RuntimeState.mqh
e64ab98a8b5c9f96f27580e536b0074673b464d32fb435d43f2c75e66b6c4780  Aurora Sentinel Core/mt5/hud/ASC_HUD_Manager.mqh
76367438bc036148139d477c5435e692a977ae381c4fa0b84274cd3f36c1ef43  Aurora Sentinel Core/mt5/core/ASC_Version.mqh
999d72958b4a0b8280baef772ce1d153b0fedef62b4dba907c2698f3cb8d550c  Aurora Sentinel Core/office/CHANGE_LEDGER.md
797740458ea29d78d22e8412951127b6b19416876ac39c97c3a2191afa546076  Aurora Sentinel Core/office/WORK_LOG.md
40ab9d630df87225c56f6d8d1a6861d794e3ce6c706f8fbaedbda175330a44e8  Aurora Sentinel Core/office/ROADMAP_STATUS.md
```
