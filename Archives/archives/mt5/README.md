# Aurora Sentinel Core MT5 Surface

## Purpose

This directory is the active MetaTrader 5 implementation surface for Aurora Sentinel Core.

For the current pass, the MT5 surface must prove three things cleanly:
- the EA attaches and heartbeats
- Layer 1 market-state truth is materially real
- that truth lands visibly into the lawful output scaffold

---

## Current implementation posture

The active MT5 surface now owns:
- thin EA entrypoint
- runtime manager
- passive HUD comment surface
- publication-path proof
- summary scaffold
- dossier scaffold with homes for all layers
- bounded Layer 1 market-state service

It intentionally does **not** yet own:
- archive-based classification
- archive-based HUD inheritance work
- menu scaffolding
- Layer 2 richness
- Layer 3/4/5 execution logic

---

## Runtime execution model entry law

Before implementing or widening runtime behavior in `mt5/`, future passes must read:
1. `blueprint/roadmap/01_BUILD_STRATEGY.md`
2. `blueprint/roadmap/04_STAGE_2_DISPATCHER_AND_GOVERNOR.md`
3. `blueprint/roadmap/05_STAGE_3_LAYER_1_MARKET_STATE.md`
4. `mt5/ASC_MODULE_STRUCTURE.md`
5. `mt5/ASC_BUILD_SEQUENCE_REFERENCE.md`

The heartbeat-and-lane runtime model is mandatory.
Future chats must not invent their own scheduler shape, burst model, or mixed-domain pulse behavior.

The required runtime posture is:
- one major lane per heartbeat
- at most one bounded sub-lane
- scan -> write -> read breathing rhythm
- atomic publication windows
- HUD reading prepared state only
- bounded work budgets with cursor-based progression

Any MT5 implementation that violates these rules is invalid even if it compiles.
