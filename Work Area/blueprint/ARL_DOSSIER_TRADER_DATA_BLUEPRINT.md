# ARL Dossier Trader Data Blueprint

Run: ARL-RUN006  
Scope: Blueprint additive reference

---

## Role

The Dossier is a human-readable selected-symbol deep review.

It should read cleaner than the Symbol Trader Pack, but it may not drop critical trader data.

---

## Relationship To Symbol Trader Pack

```text
Symbol Trader Pack = full per-symbol trader data.
Dossier = readable selected-symbol interpretation.
```

The Dossier may summarize, but not contradict, the Symbol Trader Pack.

---

## Required Sections

```text
1. Selected Symbol Summary
2. Account + Symbol Exposure
3. Symbol Trade History
4. Market State + Friction
5. Ranking Context
6. Deep Review Scores
7. Analyst Execution
8. Analyst Liquidity / Position
9. Analyst Momentum / Microstructure
10. Recent Closed Bars — first two only
11. Recent Closed Trades — first two only
12. Setup Fit
13. Final Trader Read
14. Permission Boundary
```

---

## Analyst Blocks

Dossier must include analyst-style blocks, numeric-first:

```text
ANALYST EXECUTION
  execution_quality_score
  spread_to_atr
  friction_score
  spread_stability_score
  tradability_read

ANALYST LIQUIDITY / POSITION
  liquidity_score
  liquidity_proximity_score
  sweep_risk_score
  range_position_pct
  distance_to_high/low

ANALYST MOMENTUM / MICROSTRUCTURE
  momentum_score
  pressure_score
  burst_score
  tick_bias_score
  upticks/downticks/flats

ANALYST SETUP FIT
  scalp_fit_score
  intraday_fit_score
  swing_fit_score
  clean_review_score
  risk_drag_score
```

---

## Metadata Rule

Dossier text must not print full route diagnostics or proof-boundary walls.

If alignment/currentness matters, show compact fields:

```text
snapshot_match: true
data_status: current
stale_field_count: 0
required_missing_count: 0
```

Full metadata goes to Manifest/Debug JSON.

---

## Final Read

Dossier must end with:

```text
status
why
caution
operator_action
review_permission
trade_permission=false
```
