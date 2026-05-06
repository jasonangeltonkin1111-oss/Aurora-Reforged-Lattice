# ARL Market Board Trader Data Standard

Run: ARL-RUN006  
Scope: Blueprint additive reference

---

## Role

Market Board is the operator battle board.

It should not carry full per-symbol data.

It should point to the best symbols and summarize enough trader data to choose what to inspect next.

---

## Required Sections

```text
1. Header
2. Account Summary
3. Account Exposure Summary
4. Account Trade History Summary
5. System Health
6. Operator Command Surface
7. Global Top 10
8. Top 5 Per Major Bucket
9. Top 5 Per Minor Bucket
10. Best 3 / 5 / 10 To Check Now
11. Guarded / Avoided / Blocked
12. Immediate Rotation
13. Retry + Schedule
14. Permission Boundary
```

---

## Operator Command Surface

Must include:

```text
best_pick_now
best_pick_context
backup_pick
backup_context
avoid_right_now
avoid_context
immediate_rotation
```

This is separate from Best 3/5/10.

Best pick is command guidance.

Best 3/5/10 is shortlist guidance.

---

## Top 5 Sections

Each Top 5 section must be rich enough to be useful.

Minimum row fields:

```text
symbol
major_bucket
minor_bucket
global_rank
bucket_rank
minor_bucket_rank
board_score
surface_score
deep_score if available
friction_score
spread_to_atr
exposure_state
review_state
```

If fewer than 5 symbols exist:

```text
bucket_capacity
bucket_target
bucket_complete=true
bucket_reason
```

Do not fake five rows.

---

## Account Trade History Summary

Market Board must include account-level trade history summary:

```text
lookback_days
closed_trades_count
closed_trades_net_pnl
wins
losses
win_rate_pct
largest_win
largest_loss
symbols_traded
recent_closed_trades_first_two
```

This is board-level context.

Symbol-specific history belongs in Symbol Trader Pack and Dossier.

---

## Guarded / Avoided Section

Guarded symbols must include numeric reason:

```text
symbol
board_score
reason
exposure_load_score
spread_to_atr
risk_drag_score
```

No vague “avoid” without data.

---

## Final Permission

Market Board must end with:

```text
review_permission: TRUE/FALSE
trade_permission: FALSE
signal_permission: FALSE
execution_permission: FALSE
```
