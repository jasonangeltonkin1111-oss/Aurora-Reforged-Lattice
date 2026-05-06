---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Refresh and Warmup Blueprint

## Warmup Goal

Warmup must reach complete first truth quickly.

Not perfect trading truth. Complete review baseline truth.

## Warmup State Codes

```text
0   NOT_STARTED
10  ACCOUNT_READY
20  UNIVERSE_READY
30  SYMBOL_FOLDERS_READY
40  MARKET_STATE_CLASSIFIED
50  BROKER_SPECS_CLASSIFIED
60  INDICATORS_PREPARED
70  L3_RUNNING
80  L3_COMPLETE
90  L4_RUNNING
95  L4_COMPLETE
100 READY
```

## Warmup Complete Only If

```text
account_snapshot_complete=true
universe_snapshot_complete=true
symbol_folders_created=true
market_state_classified_or_scheduled_for_all_symbols=true
broker_specs_ready_partial_or_hard_absence_classified=true
l3_processed_all_rank_eligible_symbols=true
l3_snapshot_status=COMPLETE
l4_global_top10_complete=true
l4_major_bucket_top5_complete=true
l4_minor_bucket_top5_complete=true
l4_consumed_l3_snapshot_id == l3_snapshot_id
market_board_atomic_publish_pass=true
```

## After Ready Cadence

```text
Layer 1 / Market State:
  open symbols: maintenance check
  closed symbols: scheduled next-open wake
  unknown symbols: bounded backoff retry

Layer 2 / Broker Specs:
  every 1 minute for active L4 set
  slower stale/spec repair for non-active symbols

Layer 3 / Surface Ranking:
  full universe every 20 minutes

Layer 4 / Bucket Ranking:
  every 20 minutes
  offset 5 minutes after Layer 3

Layer 5 / Deep Review:
  every 5 minutes
  active L4 set only
```

## Offset Example

```text
00:00 Layer 3 full universe snapshot starts
00:05 Layer 4 consumes committed Layer 3 snapshot
00:10 Layer 5 active set refresh
00:15 Layer 5 active set refresh
00:20 Layer 3 full universe snapshot starts
00:25 Layer 4 consumes committed Layer 3 snapshot
```

## Forbidden

- Layer 4 consuming Layer 3 staging data
- board readiness before L4 complete
- L5 delaying board publication
- deep work on every symbol
- endless warmup without a degraded explanation
