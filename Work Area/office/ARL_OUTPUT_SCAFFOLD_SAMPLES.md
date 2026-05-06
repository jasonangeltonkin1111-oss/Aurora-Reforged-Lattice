# ARL Output Scaffold Samples

## Purpose

These samples define the desired operator-facing style.

They are not runtime proof.
They are not trade signals.
They use masked/private-safe sample values.

## Output style laws

- Numeric first.
- Labels optional.
- Every label should have a score or code.
- Dev layer names may exist in debug JSON, but operator files use readable section names.
- No long route diagnostics unless contradiction exists.
- No repeated `trade_permission=false` in every minor block; one clear boundary per artifact is enough.

---

# Market Board Sample

```text
AURORA REFORGED LATTICE — MARKET BOARD
mode=REVIEW_ONLY
trade_permission=false

SNAPSHOT
generated_utc=2026.05.06 14:42:11
cycle_id=ARL-CYCLE-000184
l3_snapshot_id=ARL-L3-000184
l4_snapshot_id=ARL-L4-000184
l4_consumed_l3_snapshot_id=ARL-L3-000184
publish_result=promoted_current
warmup_state_code=100
warmup_state_label=READY

ACCOUNT
account_login=***MASKED***
account_currency=USD
balance=100000.00
equity=100214.30
margin=1200.00
free_margin=99014.30
open_positions_count=2
pending_orders_count=1
closed_deals_lookback_days=7

UNIVERSE
source_universe=MARKET_WATCH
symbols_seen=216
symbols_open=181
symbols_closed_scheduled=11
symbols_unknown_retry=24
symbols_rank_eligible=181

SCHEDULE
market_state_mode=schedule_retry
broker_specs_active_set_refresh_seconds=60
surface_ranking_refresh_minutes=20
bucket_ranking_refresh_minutes=20
bucket_ranking_offset_minutes_after_surface=5
deep_review_refresh_minutes=5

GLOBAL_TOP_10
rank | symbol | major_bucket | minor_bucket | board_score | surface_score | spread_to_atr_m15 | exposure_state | upload_priority_score | l5_status
1 | BTCUSD | CRYPTO | CRYPTO_MAJOR_COINS | 92.40 | 82.50 | 0.07400 | NONE | 92.40 | QUEUED
2 | CADSGD | FOREX | FOREX_EXOTICS | 90.10 | 86.50 | 0.00945 | NONE | 90.10 | COMPLETE
3 | XAUUSD | METALS | METALS_GOLD_SILVER | 88.40 | 84.10 | 0.04200 | OPEN_POSITION_EXISTS | 71.00 | QUEUED

TOP_5_PER_MAJOR_BUCKET
FOREX
rank | symbol | minor_bucket | board_score | exposure_state | l5_status
1 | CADSGD | FOREX_EXOTICS | 90.10 | NONE | COMPLETE
2 | EURUSD | FOREX_MAJORS | 79.20 | NONE | NOT_QUEUED
3 | GBPUSD | FOREX_MAJORS | 76.40 | NONE | NOT_QUEUED

CRYPTO
rank | symbol | minor_bucket | board_score | exposure_state | l5_status
1 | BTCUSD | CRYPTO_MAJOR_COINS | 92.40 | NONE | QUEUED
2 | ETHUSD | CRYPTO_MAJOR_COINS | 78.80 | NONE | NOT_QUEUED
3 | SOLUSD | CRYPTO_ALTCOINS | 71.20 | NONE | NOT_QUEUED

TOP_5_PER_MINOR_BUCKET
FOREX_EXOTICS
rank | symbol | board_score | spread_to_atr_m15 | exposure_state
1 | CADSGD | 90.10 | 0.00945 | NONE
2 | USDZAR | 61.80 | 0.19000 | NONE

CRYPTO_ALTCOINS
rank | symbol | board_score | spread_to_atr_m15 | exposure_state
1 | SOLUSD | 71.20 | 0.12000 | NONE
2 | XRPUSD | 69.40 | 0.11000 | NONE

UPLOAD_SUGGESTION
best_3=BTCUSD,CADSGD,EURUSD
best_5=BTCUSD,CADSGD,EURUSD,ETHUSD,GBPUSD
best_10=BTCUSD,CADSGD,EURUSD,ETHUSD,GBPUSD,SOLUSD,XAGUSD,US30,GER40,AUDUSD

EXCLUDED_FROM_UPLOAD
symbol=XAUUSD | reason=open_position_exists | board_score=88.40
symbol=NAS100 | reason=open_position_and_pending_order | board_score=85.70

RETRY_AND_SCHEDULE
confirmed_open_no_retry=181
confirmed_closed_scheduled=11
unknown_retry_queue=24
next_l3_due_utc=2026.05.06 15:00:00
next_l4_due_utc=2026.05.06 15:05:00
next_l5_due_utc=2026.05.06 14:45:00
```

---

# Dossier Sample

```text
AURORA REFORGED LATTICE — SYMBOL DOSSIER
mode=DEEP_REVIEW
trade_permission=false

SNAPSHOT
symbol=CADSGD
dossier_snapshot_id=ARL-DOSSIER-CADSGD-000184
source_l3_snapshot_id=ARL-L3-000184
source_l4_snapshot_id=ARL-L4-000184
generated_utc=2026.05.06 14:42:11
publish_result=promoted_current

IDENTITY
exact_symbol=CADSGD
canonical_symbol=CADSGD
major_bucket=FOREX
minor_bucket=FOREX_EXOTICS
classification_confidence_score=100.00

MARKET_STATE
state_code=1
state_label=OPEN
tick_age_seconds=0
inside_quote_session=true
inside_trade_session=true
next_check_utc=2026.05.06 14:43:59
retry_required=false

BROKER_AND_SYMBOL_SPECS
spec_status_code=100
digits=5
point=0.00001000
base_currency=CAD
quote_currency=SGD
margin_currency=CAD
spread_points=1.00
spread_to_atr_m5=0.01953
spread_to_atr_m15=0.00945

SURFACE_RANKING
surface_score=86.50
execution_score=89.70
timing_score=87.50
quote_health_score=96.00
risk_drag_score=6.60

BUCKET_RANKING
global_rank=2
major_bucket_rank=1
minor_bucket_rank=1
raw_rank=6
board_score=90.10
relative_score=90.10
leader_separation_score=100.00
top10_compression_score=39.50

DEEP_REVIEW
l5_status_code=100
l5_status_label=COMPLETE
l5_refresh_age_seconds=0
pressure_score=51.60
momentum_score=49.30
move_age_score=73.70
liquidity_score=82.80
participation_score=100.00
execution_deep_score=93.20
burst_score=50.70

ACCOUNT_EXPOSURE
open_position_count_symbol=0
pending_order_count_symbol=0
recent_closed_deals_symbol=0
symbol_recent_closed_pnl=0.00
exposure_load_score=0.00
exposure_state=NONE

MISSING_AND_DEGRADED
required_missing_count=0
optional_missing_count=2
irrelevant_missing_hidden=true
degraded_reason=optional_broker_metadata_missing
blocks_review=false
blocks_trade=true

OPERATOR_SUMMARY
upload_priority_score=90.10
upload_group=BEST_3
numeric_reason=high_board_score_low_exposure_clean_spread_to_atr
main_caution=review_only_no_trade_permission
```
