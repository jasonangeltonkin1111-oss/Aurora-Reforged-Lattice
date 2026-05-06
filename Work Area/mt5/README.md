# MT5 Scaffold — Aurora Reforged Lattice

Run: `ARL-RUN004`  
Status: **scaffold only**  
Version: `1.004`

This folder contains the first MT5 source scaffold for Aurora Reforged Lattice.

It is intentionally **not** a working trading system yet. It is a compile-visible structural skeleton for future GPT zip-audit / research / patch runs.

## Hard boundaries

- No HUD.
- No trading.
- No signals.
- No execution.
- No direct ASC source copy.
- No formulas finalized.
- No runtime changelog module.
- Version identity exists in `core/ARL_Version.mqh`, but change history belongs to `office/` and Git.

## Anti-cosmetic module rule

Every module scaffold contains:
- owner
- purpose
- inputs
- outputs
- forbidden ownership
- future runtime contract expectation

A module must later prove real use through source implementation, output contract, acceptance test, runtime evidence, or lock file. If it cannot earn that role, delete or merge it.

## Product identity shown in MT5

`ARL_Core.mq5` exposes version/run/channel/state through:
- `#property version`
- `#property description`
- grouped `input` fields visible in the EA properties window

Do not add `ARL_Changelog.mqh`. Git and `office/` own history.
