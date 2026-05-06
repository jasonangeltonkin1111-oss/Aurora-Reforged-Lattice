# ARL Refresh and Timing Model

## Purpose

This file locks the warmup and ready-state refresh model.

## Core rule

Warmup must reach true completion before READY.

After READY, heavy work must be scheduled, offset, and restricted by active set.

## Warmup flow

```text
0. Runtime start
1. Account snapshot
2. Market Watch universe load
3. Symbol folder creation
4. Market State classify every symbol
5. Broker & Symbol Specs classify every symbol
6. Indicator handles prepared only where needed
7. Surface Ranking full warmup
8. Bucket Ranking full warmup
9. Atomic Market Board publish
10. READY
```

## Warmup state codes

| Code | State |
|---:|---|
| 0 | NOT_STARTED |
| 10 | ACCOUNT_READY |
| 20 | UNIVERSE_READY |
| 30 | MARKET_STATE_CLASSIFIED |
| 40 | BROKER_SPECS_CLASSIFIED |
| 50 | SURFACE_RANK_RUNNING |
| 60 | SURFACE_RANK_COMPLETE |
| 70 | BUCKET_RANK_RUNNING |
| 80 | BUCKET_RANK_COMPLETE |
| 90 | BOARD_PUBLISHED |
| 100 | READY |

## Completion law

READY is forbidden unless:
- Account snapshot exists.
- Universe snapshot exists.
- Symbol folders exist for every Market Watch symbol.
- Market state is OPEN, CLOSED-SCHEDULED, or UNKNOWN-RETRY for every symbol.
- Broker specs are READY, PARTIAL, or HARD-ABSENCE for every eligible symbol.
- Surface Ranking has processed all rank-eligible symbols.
- Bucket Ranking produced:
  - Global Top 10
  - Top 5 per major bucket where symbols exist
  - Top 5 per minor bucket where symbols exist
- Board published atomically from the committed L4 snapshot.

## Ready-state cadence

After READY:

| Module | Cadence | Scope |
|---|---:|---|
| Market State | schedule/retry based | all symbols due |
| Broker & Symbol Specs | 1 minute | active L4 set |
| Surface Ranking | 20 minutes | universe-wide |
| Bucket Ranking | 20 minutes, 5 min after L3 | consumes committed L3 snapshot |
| Deep Review | 5 minutes | active L4 set |

## Offset schedule

```text
00:00 Surface Ranking starts
00:05 Bucket Ranking consumes committed Surface Ranking snapshot
00:10 Deep Review refresh
00:15 Deep Review refresh
00:20 Surface Ranking starts
00:25 Bucket Ranking consumes committed Surface Ranking snapshot
```

## Active L4 set

```text
active_l4_set =
  GlobalTop10
  union Top5PerMajorBucket
  union Top5PerMinorBucket
```

Deduplicate by exact broker symbol.

## Retry rules

Open market confirmed:
- stop open/closed retries
- next check = normal maintenance

Closed market confirmed:
- stop open/closed retries
- schedule next check near next session open

Unknown:
- retry with bounded backoff

Suggested backoff:
- attempt 1: +2 seconds
- attempt 2: +5 seconds
- attempt 3: +15 seconds
- attempt 4: +60 seconds
- attempt 5: degraded / scheduled repair

## Hard rule

Layer 4 must never consume a staging/in-progress Layer 3 table.

Layer 5 must never change Layer 3 or Layer 4 membership directly.
