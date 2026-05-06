# Phase 04 — Indicators and L3 Surface Ranking

## Purpose

Create readiness-aware indicator cache and numeric surface ranking.

## Modules

```text
mt5/indicators/
mt5/layer3_surface_rank/
```

## Key rules

- handle once, reuse
- CopyBuffer failure = BUILDING/PARTIAL/FAILED, not zero READY
- L3 refreshes full universe every 20 minutes after warmup
- L3 snapshot must be committed before L4 consumes it

## Completion

- L3 warmup complete
- L3 snapshot atomic
- no trade language
