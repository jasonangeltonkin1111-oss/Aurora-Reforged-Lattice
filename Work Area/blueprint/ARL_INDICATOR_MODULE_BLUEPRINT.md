---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Indicator Module Blueprint

Indicators must be cached, readiness-aware, and cheap.

## Indicator Folder

```text
mt5/indicators/
  ARL_IndicatorRegistry.mqh
  ARL_IndicatorCache.mqh
  ARL_ATRModule.mqh
  ARL_RangeModule.mqh
  ARL_VolatilityModule.mqh
  ARL_IndicatorRelease.mqh
```

## Indicator Lifecycle

```text
create handle once
store handle by symbol/timeframe/params
copy buffer only when due
if not ready, mark BUILDING
retry later
release handle on deinit
```

## Indicator Status

```text
NOT_REQUESTED
HANDLE_READY
BUILDING
READY
PARTIAL
FAILED
RELEASED
```

## Numeric Output

ATR example:

```text
atr_m5_points=
atr_m15_points=
atr_h1_points=
atr_status=READY
atr_sample_count=
atr_last_bar_time=
atr_error_code=
```

## Forbidden

- creating handles every heartbeat
- treating `0.0` as valid if data failed
- hiding `CopyBuffer` failures
- deep indicator matrix during early build
- unlabeled preview/current-bar values mixed with closed-bar values
