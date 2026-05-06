---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Layer Model

Internal layer names may exist in source. Operator output must use meaningful names.

| Internal | Operator Name | Purpose | Runs On |
|---|---|---|---|
| Layer 0 | Runtime Nervous System | heartbeat, scheduler, cycle IDs, atomic output | whole system |
| Layer 1 | Market State | open/closed/stale/unknown and next schedule | symbol universe |
| Layer 2 | Broker & Symbol Specs | Market Watch, spread, tick, volume, stops/freeze, broker constraints | symbol universe, then active L4 set |
| Layer 3 | Surface Ranking | fast numeric ranking using cheap data | full universe every 20 min after warmup |
| Layer 4 | Bucket Ranking | Global Top 10, Top 5 per major bucket, Top 5 per minor bucket | committed L3 snapshot |
| Layer 5 | Deep Review | expensive deeper calculations | active L4 set only |

## Layer Completion Rules

### Market State

Must output:

- `market_state_code`
- `market_state_label`
- `tick_present`
- `tick_age_seconds`
- `session_state_code`
- `next_check_utc`
- `retry_required`

### Broker & Symbol Specs

Must output:

- `spec_status_code`
- `digits`
- `point`
- `tick_size`
- `tick_value`
- `contract_size`
- `volume_min`
- `volume_max`
- `volume_step`
- `stops_level`
- `freeze_level`
- `spread_points`
- `spread_bps`
- `missing_required_fields_count`
- `missing_optional_fields_count`

### Surface Ranking

Must output:

- `surface_score`
- `friction_score`
- `spread_to_atr`
- `quote_health_score`
- `session_score`
- `volatility_sanity_score`
- `rank_eligible`

### Bucket Ranking

Must output:

- `global_rank`
- `major_bucket_rank`
- `minor_bucket_rank`
- `raw_rank`
- `membership_flags`
- `active_l4_set=true/false`

### Deep Review

Must output numeric fields first:

- `pressure_score`
- `momentum_score`
- `move_age_score`
- `liquidity_score`
- `participation_score`
- `execution_score_deep`
- `burst_score`
- `deep_review_status_code`
