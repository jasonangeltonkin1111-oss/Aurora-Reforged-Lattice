---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Numeric-First Standard

Words are support. Numbers are authority.

## Required Pattern

```text
momentum_score=79.20
momentum_label=STRONG
```

Do not output only:

```text
momentum=Strong
```

## Score Scale

Unless otherwise specified:

```text
0.00   = worst / absent / unusable
50.00  = neutral / balanced
100.00 = strongest / cleanest / best
```

## Core Score Fields

Surface Ranking:

- `surface_score`
- `friction_score`
- `quote_health_score`
- `session_score`
- `spread_score`
- `volatility_sanity_score`
- `rank_eligible_score`

Bucket Ranking:

- `board_score`
- `rank_blend_score`
- `relative_field_score`
- `leader_separation_score`
- `top10_compression_score`
- `correlation_penalty_score`
- `diversity_penalty_score`
- `exposure_load_score`

Deep Review:

- `pressure_score`
- `momentum_score`
- `move_age_score`
- `liquidity_score`
- `participation_score`
- `execution_score_deep`
- `burst_score`
- `late_move_risk_score`

## Label Policy

Labels may help readability:

- `LOW`
- `MEDIUM`
- `HIGH`
- `EXTREME`
- `READY`
- `PARTIAL`
- `BUILDING`
- `FAILED`

But the label must not replace the numeric field.

## ASC Lesson

ASC outputs had useful numeric DNA, for example participation, execution, pressure, momentum, timing, move age, board score, relative score, leader separation, and compression. ARL keeps those numeric ideas but cuts the prose bloat.
