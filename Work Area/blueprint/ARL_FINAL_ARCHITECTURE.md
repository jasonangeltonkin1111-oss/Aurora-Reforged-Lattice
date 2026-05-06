---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Final Architecture

## Final Product Layers

```text
Runtime Nervous System
  -> Account + Exposure Context
  -> Symbol Universe
  -> Market State
  -> Broker & Symbol Specs
  -> Indicator Cache
  -> Surface Ranking
  -> Bucket Ranking
  -> Active Set
  -> Deep Review
  -> Market Board
  -> Symbol Files
  -> Dossiers
  -> Manifest + Logs
```

## High-Level Data Flow

```text
Account Snapshot
Market Watch Universe
        |
        v
Market State + Broker Specs
        |
        v
Fast Numeric Surface Ranking
        |
        v
Committed Bucket Ranking Snapshot
        |
        v
Active L4 Set
        |
        +--> 1-minute spec refresh for active symbols
        +--> 5-minute deep review for active symbols
        +--> Market Board
        +--> Symbol Files
        +--> Dossiers
```

## Ownership Law

Each major truth has exactly one owner:

| Truth | Owner |
|---|---|
| runtime heartbeat/cycle | runtime |
| account balance/equity/margin | account |
| open positions | account/positions |
| pending orders | account/orders |
| closed deals | account/deals |
| selected symbol universe | universe |
| market open/closed | market_state |
| broker specs | symbol_specs |
| indicator handles | indicators |
| surface score | layer3_surface_rank |
| global/top/bucket membership | layer4_bucket_rank |
| active set | layer4_bucket_rank |
| deep review fields | layer5_deep_review |
| operator board text | market_board |
| dossier text | dossiers |
| atomic writes | io |
| permission flags | permission |

## Forbidden Ownership Leaks

- Market Board must not calculate hidden rankings.
- Dossier must not calculate broker facts.
- Deep Review must not mutate Layer 3 ranking.
- Symbol files must not invent L3/L4 context.
- Output writers must not decide trade permission.
- Runtime scheduler must not contain ranking formulas.

## ARL-RUN007 Output Boundary Alignment

The operator output stack is separated as follows:

- Market Board: operator battle board for the broad scan and best review candidates.
- Symbol Trader Pack: full per-symbol trader data for review without metadata walls.
- Dossier: selected-symbol readable review assembled from structured truth lanes.
- `Symbol_Current.json`: structured symbol truth.
- `Manifest_Current.json`: publication/source/readback truth.
- `Debug_Current.json`: verbose diagnostics.

The text layer may summarize truth. It must not own hidden calculations or silently override JSON/source truth.
