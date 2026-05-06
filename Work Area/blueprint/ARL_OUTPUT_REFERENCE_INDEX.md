# ARL Output Reference Index

This file indexes the final product output references that future implementation runs must read before building or changing Market Board, symbol, dossier, pack, manifest, schema, or trader-facing output behavior.

## Trader-Data-First Law

Human trader files must put trader-useful truth first.

Metadata, debug state, producer details, hashes, and long diagnostics belong in JSON, manifest, status, or debug files unless they directly affect the trading decision.

## Output Reference Map

| Output Area | Blueprint / Standard | Samples / Schemas |
|---|---|---|
| Market Board | `ARL_MARKET_BOARD_BLUEPRINT.md`, `ARL_MARKET_BOARD_TRADER_DATA_STANDARD.md` | `samples/MarketBoard_Current.sample.txt`, `samples/MarketBoard_TraderData.sample.txt`, `samples/MarketBoard_Current.sample.json`, `schemas/market_board.schema.md` |
| Symbol Trader Pack | `ARL_SYMBOL_TRADER_PACK_BLUEPRINT.md`, `ARL_TRADER_DATA_OUTPUT_STANDARD.md` | `samples/Symbol_Trader_Pack.sample.txt`, `schemas/symbol_trader_pack.schema.md` |
| Dossier | `ARL_DOSSIER_BLUEPRINT.md`, `ARL_DOSSIER_TRADER_DATA_BLUEPRINT.md` | `samples/Symbol_Dossier.sample.txt`, `samples/Symbol_Dossier_TraderData.sample.txt`, `schemas/dossier.schema.md` |
| Symbol Current JSON | `ARL_SYMBOL_FILE_BLUEPRINT.md` | `samples/Symbol_Current.sample.json`, `schemas/symbol_current.schema.md` |
| Account Current JSON | `ARL_ACCOUNT_EXPOSURE_BLUEPRINT.md` | `samples/Account_Current.sample.json`, `schemas/account_current.schema.md` |
| L3 Surface Ranking | `ARL_LAYER_MODEL.md` | `samples/L3_SurfaceRank_Current.sample.json`, `schemas/l3_surface_rank.schema.md` |
| L4 Bucket Ranking | `ARL_BUCKET_MODEL.md`, `ARL_LAYER_MODEL.md` | `samples/L4_GroupRank_Current.sample.json`, `schemas/l4_group_rank.schema.md` |
| Publication Manifest | `ARL_ATOMIC_PUBLICATION_BLUEPRINT.md` | `samples/Manifest_Current.sample.json`, `schemas/manifest.schema.md` |

## JSON / Manifest / Debug Split

- Human `.txt` output owns operator readability.
- `.json` output owns structured current facts.
- Manifest output owns publication truth, timestamps, producer, hash, freshness, and atomic promotion state.
- Debug output owns diagnostics and internal failure investigation.

Do not dump debug metadata into trader text just because it is available.

## First Two Bars / Trades Display Rule

When the final product shows recent bars, trades, sessions, or comparable per-symbol context, the top of the human trader output must expose the first two relevant bars/trades/records in readable form when they affect current interpretation. This prevents “trust me” summaries and gives the operator immediate texture before deeper metadata.

## Acceptance Requirement

Before any output module is considered lockable:

- the correct blueprint is read;
- sample text output is compared against the trader-data-first law;
- JSON/schema ownership is checked;
- manifest/debug split is preserved;
- stale, missing, partial, and placeholder states are visible;
- metadata does not bury the trader decision.
