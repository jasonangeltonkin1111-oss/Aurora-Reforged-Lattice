# Phase 03 — Market State and Symbol Specs

## Purpose

Classify every Market Watch symbol and fill broker/spec truth.

## Modules

```text
mt5/universe/
mt5/layer1_market_state/
mt5/layer2_symbol_specs/
```

## Key rules

- open confirmed = stop open/closed retry
- closed confirmed = schedule next open
- unknown = bounded retry/backoff
- specs must be READY/PARTIAL/UNAVAILABLE with reason

## Completion

- all symbols have folders/current files
- all eligible symbols have market state
- all active symbols have spec status
