# Schema — Symbol Trader Pack

Run: ARL-RUN006  
Scope: Blueprint additive schema outline

---

## Required Top-Level Blocks

```text
quick_trader_snapshot
account_symbol_history
market_state_cost
volatility_range
momentum_microstructure
liquidity_structure
recent_closed_bars
setup_fit
final_trader_read
permission_boundary
```

---

## Field Requirements

### quick_trader_snapshot

```text
symbol: string
asset_class: string
major_bucket: string
minor_bucket: string
review_state: enum(CHECK_NOW,WATCH,GUARDED,AVOID)
global_rank: integer|null
major_bucket_rank: integer|null
minor_bucket_rank: integer|null
board_score: number|null
surface_score: number|null
deep_score: number|null
clean_review_score: number|null
main_reason: string
main_caution: string
```

### account_symbol_history

```text
open_positions_on_symbol: integer
pending_orders_on_symbol: integer
floating_pnl_symbol: number
exposure_load_score: number
lookback_days: integer
closed_trades: integer
net_pnl: number
wins: integer
losses: integer
win_rate_pct: number|null
avg_win: number|null
avg_loss: number|null
largest_win: number|null
largest_loss: number|null
last_trade_pnl: number|null
last_trade_age_hours: number|null
recent_closed_trades_first_two: array(max=2)
```

### recent_closed_bars

```text
bars_first_two: array(max=2)
bar.time: datetime
bar.open: number
bar.high: number
bar.low: number
bar.close: number
bar.range_points: number
bar.body_points: number
bar.upper_wick_points: number
bar.lower_wick_points: number
bar.tick_volume: integer
bar.spread_points_at_close: number|null
```

---

## Metadata Exclusion

This schema is for trader data.

Verbose route/source/proof metadata belongs to Manifest/Debug schemas.
