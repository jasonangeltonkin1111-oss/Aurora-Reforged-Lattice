# ARL Symbol Trader Pack Blueprint

Run: ARL-RUN006  
Scope: Blueprint additive reference  
Status: Primary per-symbol trader-data standard.

---

## Role

The Symbol Trader Pack is the full per-symbol trader-data file.

It is not a metadata file.

It is not a route diagnostic file.

It is the symbol's trading-relevant truth packet.

---

## Required Sections

```text
1. Quick Trader Snapshot
2. Account + Symbol Trade History
3. Market State + Cost
4. Volatility + Range
5. Momentum + Microstructure
6. Liquidity + Structure
7. Recent Closed Bars — first two only
8. Setup Fit
9. Final Trader Read
10. Permission Boundary
```

---

## 1. Quick Trader Snapshot

Must include:

```text
symbol
asset_class
major_bucket
minor_bucket
review_state
global_rank
major_bucket_rank
minor_bucket_rank
board_score
surface_score
deep_score
clean_review_score
main_reason
main_caution
```

---

## 2. Account + Symbol Trade History

Must include:

```text
open_positions_on_symbol
pending_orders_on_symbol
floating_pnl_symbol
exposure_load_score
lookback_days
closed_trades
net_pnl
wins
losses
win_rate_pct
avg_win
avg_loss
largest_win
largest_loss
last_trade_pnl
last_trade_age_hours
recent_closed_trades_first_two
```

---

## 3. Market State + Cost

Must include:

```text
market_state
tick_age_seconds
quote_session_open
trade_session_open
spread_points
spread_bps
atr_m15_points
spread_to_atr_m15
friction_score
volume_min
volume_step
stops_level
freeze_level
cost_read
```

---

## 4. Volatility + Range

Must include:

```text
atr_m5_points
atr_m15_points
atr_h1_points
day_range_points
current_position_in_day_range_pct
distance_to_day_high_points
distance_to_day_low_points
volatility_score
compression_score
expansion_score
late_move_risk_score
```

---

## 5. Momentum + Microstructure

Must include:

```text
momentum_score
momentum_speed_score
pressure_score
burst_score
recent_ticks_used
upticks
downticks
flat_ticks
tick_bias_score
spread_samples_used
avg_spread_points
max_spread_points
spread_stability_score
microstructure_read
```

---

## 6. Liquidity + Structure

Must include:

```text
liquidity_score
liquidity_proximity_score
sweep_risk_score
structure_score
continuation_score
reversal_risk_score
move_age_score
structure_read
```

---

## 7. Recent Closed Bars

Text shows first two closed bars only.

Each bar must include:

```text
time
open
high
low
close
range_points
body_points
upper_wick_points
lower_wick_points
tick_volume
spread_points_at_close
```

Full bar arrays belong in JSON.

---

## 8. Setup Fit

Must include:

```text
scalp_fit_score
intraday_fit_score
swing_fit_score
execution_quality_score
participation_score
clean_review_score
risk_drag_score
best_use
not_ideal_for
```

---

## 9. Final Trader Read

Must include:

```text
status: CHECK_NOW / WATCH / GUARDED / AVOID
why
caution
review_permission
trade_permission
```

---

## Failure Condition

If the Symbol Trader Pack is mostly metadata, it fails.

If it lacks symbol-specific trade history, it fails.

If it lacks recent bars, it fails.

If it lacks setup fit, it fails.
