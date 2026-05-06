---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Retry and Scheduling Blueprint

Retries exist to resolve uncertainty, not to hammer the terminal.

## Retry Classes

```text
NO_RETRY_CONFIRMED_OPEN
NO_RETRY_CONFIRMED_CLOSED_SCHEDULED
RETRY_UNKNOWN_NO_TICK
RETRY_SYMBOL_NOT_SYNCED
RETRY_SPEC_PARTIAL
RETRY_INDICATOR_BUILDING
RETRY_HISTORY_LOADING
RETRY_FILE_WRITE_FAILED
HARD_ABSENCE_CONFIRMED
```

## Market State Retry Law

If market is confirmed open:

```text
retry_open_closed=false
next_check=normal_maintenance
```

If market is confirmed closed and next open is known:

```text
retry_open_closed=false
next_check=next_open_time - wake_buffer
```

If market state is unknown:

```text
retry_with_backoff=true
max_attempts=bounded
```

## Backoff Pattern

```text
attempt_1: +2s
attempt_2: +5s
attempt_3: +15s
attempt_4: +60s
attempt_5: degraded / scheduled
```

## Jitter

Where many symbols retry at the same time, add small jitter.

This prevents retry clusters.

## Fail Fast

Do not retry non-transient failures endlessly.

Examples:

- invalid symbol
- not selected and selection not allowed
- unsupported property
- hard broker absence confirmed

## Output Fields

```text
retry_required
retry_reason
retry_attempt
retry_next_due_utc
retry_max_attempts
hard_absence_reason
```
