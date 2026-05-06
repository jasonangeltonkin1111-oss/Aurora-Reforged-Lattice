---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Dossier Blueprint

`Dossier_Current.txt` is a same-symbol review file.

It supports operator review. It does not override the Market Board and does not create trade permission.

## Required Sections

1. Header
2. Identity
3. Account Exposure For Symbol
4. Market State
5. Broker & Symbol Specs
6. Surface Ranking
7. Bucket Ranking
8. Deep Review
9. Missing / Degraded Summary
10. Operator Summary
11. Permission Boundary

## Header Fields

```text
system=Aurora Reforged Lattice
file=Dossier_Current.txt
symbol=
mode=Deep Review
trade_permission=false
generated_utc=
cycle_id=
dossier_snapshot_id=
source_l3_snapshot_id=
source_l4_snapshot_id=
source_board_snapshot_id=
schema_version=
```

## Numeric Section Example

```text
SURFACE RANKING
surface_score=86.50
friction_score=82.10
spread_bps=1.70
spread_to_atr_m15=0.00945
quote_health_score=98.00
session_score=100.00
volatility_sanity_score=76.00
rank_eligible=true
```

## Deep Review Example

```text
DEEP REVIEW
deep_review_status_code=100
deep_review_trigger=AUTO_ACTIVE_L4_SET
l5_refresh_age_seconds=0

pressure_score=51.60
momentum_score=49.30
move_age_score=73.70
liquidity_score=82.80
participation_score=100.00
execution_score_deep=93.20
burst_score=50.70
late_move_risk_score=31.00
```

## Keep From ASC

- same-symbol board baseline preservation
- publication health
- numeric score stack
- section status
- market state and broker specs
- currentness and stale/retained boundaries
- no-trade-permission boundary

## Drop From ASC

- repeated diagnostic blocks
- repeated symbol identity blocks
- route debugging unless contradiction exists
- wall-of-taxonomy text
- optional unavailable fields in operator output
- prose conclusions that repeat the same numeric facts

## Dossier Authority Rule

Dossier may add depth for the same symbol, but the board keeps ordinary ranking authority.

Dossier cannot:

- promote itself into Global Top 10
- change bucket membership
- override exposure exclusion
- create a signal
- authorize execution
