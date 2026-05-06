# Phase 05 — L4 Bucket Ranking

## Purpose

Build final ranking groups.

## Required groups

```text
Global Top 10 across all symbols
Top 5 per major bucket
Top 5 per minor bucket
```

## Correct bucket hierarchy

Major bucket = broad class: FOREX, CRYPTO, METALS, INDICES, COMMODITIES, STOCKS.

Minor bucket = subgroup: FOREX_EXOTICS, CRYPTO_ALTCOINS, INDICES_US, etc.

## Timing

L4 refreshes every 20 minutes after warmup, offset 5 minutes after L3.

## Completion

- L4 consumes committed L3 snapshot only
- bucket snapshots have stable IDs
- active L4 set deduplicated by exact broker symbol
