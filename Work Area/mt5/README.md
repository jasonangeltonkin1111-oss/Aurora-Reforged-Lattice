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

## ARL-RUN007 MT5 State

Active source root: `Work Area/mt5/`.

Version: `1.004`.
Run identity: `ARL-RUN007`.
State: pre-work unification only; no runtime proof.

RUN007 did not add HUD, trading, signal, execution, strategy formulas, or direct ASC archive migration. Compile must be performed in MetaEditor before any compile claim is made.

## ARL-RUN008 MT5 Agent Guide Addendum

RUN008 added `MT5_AGENT_IMPLEMENTATION_GUIDE.md`.

Future MT5 implementation agents must read it before editing source. It reinforces module ownership, version policy, include boundaries, no changelog `.mqh`, no HUD/trading/signals/execution, no duplicate owners, no direct archive copy, and compile-proof honesty.

RUN008 did not change MT5 source behavior. Product version remains `1.004`.
