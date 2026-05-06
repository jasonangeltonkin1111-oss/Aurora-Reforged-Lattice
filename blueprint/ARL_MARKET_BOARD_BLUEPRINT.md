---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Market Board Blueprint

`MarketBoard_Current.txt` is the operator command board for review selection.

It does not grant trade permission.

## Required Sections

1. Header
2. Account Snapshot
3. Exposure Snapshot
4. System Health
5. Warmup / Ready State
6. Global Top 10
7. Top 5 Per Major Bucket
8. Top 5 Per Minor Bucket
9. Upload Suggestions Best 3 / 5 / 10
10. Exclusions
11. Retry + Schedule Status
12. Permission Boundary

## Header Fields

```text
system=Aurora Reforged Lattice
file=MarketBoard_Current.txt
mode=Review Only
trade_permission=false
generated_utc=
server_time=
cycle_id=
l3_snapshot_id=
l4_snapshot_id=
l4_consumed_l3_snapshot_id=
board_snapshot_id=
board_schema_version=
```

## Readiness Block

```text
warmup_state_code=100
warmup_state_label=READY
l3_snapshot_status=COMPLETE
l4_snapshot_status=COMPLETE
board_publish_status=ATOMIC_PROMOTED
readback_status=PASS
active_l4_set_count=
```

## Candidate Row Shape

```text
rank=2
symbol=CADSGD
major_bucket=FOREX
minor_bucket=FOREX_EXOTICS

global_rank=2
major_bucket_rank=1
minor_bucket_rank=1
raw_rank=6

board_score=90.10
surface_score=86.50
selection_score=76.30
context_score=99.60
execution_score=89.70
timing_score=87.50
risk_drag_score=6.60
spread_to_atr=0.00945
tick_age_seconds=0

market_state_code=1
broker_spec_code=100
l3_status_code=100
l4_status_code=100
l5_status_code=100
exposure_code=0

upload_priority_score=92.40
upload_group=BEST_3
trade_permission=false
```

## Keep From ASC

- Global Top 10
- bucket top-5 ranking
- diversified vs bucket-local distinction
- board-vs-dossier authority boundary
- score stack
- exposure context
- correlation / peer pressure
- L3/L4 trace
- board currentness
- no-trade-permission boundary

## Drop From ASC

- long proof-boundary paragraphs
- repeated artifact identity blocks
- route diagnostics unless contradiction exists
- giant taxonomy strings
- labels without numbers
- redundant permission flags in every block

## Completion Rule

Market Board must not publish as ready unless:

```text
l3_snapshot_status=COMPLETE
l4_snapshot_status=COMPLETE
l4_consumed_l3_snapshot_id == l3_snapshot_id
global_top10_count >= min(10, eligible_population)
all_nonempty_major_buckets_have_rank_rows=true
all_nonempty_minor_buckets_have_rank_rows=true
readback_status=PASS
```
