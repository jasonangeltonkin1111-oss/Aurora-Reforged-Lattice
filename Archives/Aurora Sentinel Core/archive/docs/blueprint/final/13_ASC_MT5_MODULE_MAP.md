# ASC MT5 Module Map

## Purpose

This file defines the current MT5 implementation surface and the cleanup rules that keep it patchable.

## Current implementation truth

The present implementation surface is the current `mt5/` tree rooted at `mt5/AuroraSentinelCore.mq5`.

Active compile-path ownership currently runs through:
- `core/`
- `runtime/`
- `logging/`
- `artifacts/`
- `hud/`
- `menu/ASC_TraderControlRegistry.mqh`
- `market_state/`
- `open_symbol_snapshot/`
- `candidate_filtering/`
- `shortlist_selection/`
- `symbols/`
- `io/ASC_FileIO.mqh`
- `io/ASC_WorkbenchPaths.mqh`

That compile path is the live implementation truth.
A file that is present in `mt5/` but not reachable from the active compile path is not active runtime truth by default.
Nested duplicate trees (for example `mt5/mt5/`) are reviewed evidence and are not compile owners unless the root include map proves otherwise.

## Module discipline

- One owner per module.
- No dead stubs.
- No orphan menu or settings files.
- No unused placeholder engines.
- Prefer the fewest modules that keep ownership clear.

## Reachability rule

If a module is not referenced by the active compile path and does not own live schema or runtime truth, it must be merged or removed.

## Merge rule

When two small files split one responsibility awkwardly, prefer one clear owner module.

## Publication ownership

- Bundle state ownership: `mt5/core/ASC_RuntimeState.mqh`
- Bundle manifest writing: `mt5/runtime/ASC_Dispatcher.mqh`
- Market Board writing: `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- Current Focus writing: `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- Open Symbol Snapshot writing: `mt5/artifacts/ASC_OpenSymbolSnapshotWriter.mqh`
- Dossier writing: `mt5/artifacts/ASC_DossierWriter.mqh`
- Common promote path: `mt5/io/ASC_FileIO.mqh`

## Publication rules

- Small pass-through writer helpers should be merged into the real owner when they do not hold unique logic.
- Shortlist Selection summary data used by publication is built once per write pass in runtime ownership and passed through to writers; writers must not recompute it internally.
- Publication logging must keep write, promote, and retained-last-good truth explicit for each artifact publish outcome.

## Current audit decisions

| Path | Decision | Reason |
|---|---|---|
| `mt5/menu/ASC_MenuModel.mqh` | remove | Zero inbound references from the active compile path and no unique live ownership. |
| `mt5/menu/ASC_SettingsModel.mqh` | remove | Zero inbound references from the active compile path and no unique live ownership. |
| `mt5/io/ASC_PublicationState.mqh` | remove | Zero inbound references; live publication enum ownership already lives in `mt5/core/ASC_Types.mqh`; the unused label helper was not part of the active compile path. |
| `mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh` | remove | Zero inbound references; the live manual-only Deep Selective Analysis helpers already exist in `mt5/hud/ASC_HUD_Manager.mqh`. |

## Runtime repair record

- `mt5/io/ASC_PublicationState.mqh` dropped out of the live publication path and is removed in this repair.
- Publication identity and shortlist reuse are now owned by runtime dispatch and carried through the real artifact writers.
