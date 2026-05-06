# ARL Roadmap

## Current phase

Phase:
OFFICE + BLUEPRINT FOUNDATION

Status:
Planning only. No active MQL5 source created by this office pack.

Trading permission:
FALSE.

HUD:
OUT OF SCOPE.

## Core design

ARL is a lightweight layered MT5 review system.

Internal layers:
- Layer 0: Runtime nervous system
- Layer 1: Market State
- Layer 2: Broker & Symbol Specs
- Layer 3: Surface Ranking
- Layer 4: Bucket Ranking
- Layer 5: Deep Review

Operator-facing terms:
- Market State
- Broker & Symbol Specs
- Surface Ranking
- Bucket Ranking
- Deep Review

## Build order

### ARL-RUN001 — Office and blueprint foundation

Scope:
- office files
- decisions
- roadmap
- risk ledger
- research ledger
- migration register
- acceptance tests
- output samples
- timing and atomic publication rules

No MT5 code.

### ARL-RUN002 — Source scaffold only

Scope:
- mt5 folder layout
- minimal placeholder headers
- no formulas
- no HUD
- no trading
- no copied ASC source

Expected folders:
- mt5/core
- mt5/runtime
- mt5/io
- mt5/telemetry
- mt5/account
- mt5/layer1_market_state
- mt5/layer2_symbol_specs
- mt5/layer3_surface_rank
- mt5/layer4_group_rank
- mt5/layer5_deep_review
- mt5/indicators
- mt5/dossiers
- mt5/permission
- tests
- locks

### ARL-RUN003 — Runtime + status proof

Scope:
- ARL_Core.mq5
- version
- clock
- scheduler
- heartbeat
- status writer
- atomic status file

Test:
- compile
- status file atomic publish
- heartbeat does not perform heavy work

Lock candidate:
Runtime / Status Writer.

### ARL-RUN004 — Account and exposure module

Scope:
- Account snapshot
- Open positions
- Pending orders
- Closed/deal history lookback
- Symbol exposure map

Test:
- account info present
- open positions and pending orders not mixed
- sample mode masks account login
- local runtime may expose full account if user enables it

Lock candidate:
Account Snapshot / Exposure Map.

### ARL-RUN005 — Market Watch universe and symbol folders

Scope:
- Load Market Watch symbols.
- Create per-symbol folders.
- Create Symbol_Current.json skeletons.

Test:
- every Market Watch symbol has folder/current file
- no rank/deep computations
- no UI/HUD

Lock candidate:
Universe / Symbol Folder Publisher.

### ARL-RUN006 — Market State

Scope:
- open/closed/unknown
- tick freshness
- session summary
- next-open scheduling
- retry only unknowns

Test:
- open confirmed stops retry
- closed confirmed schedules next open
- unknown uses backoff
- no infinite retry storm

Lock candidate:
Market State.

### ARL-RUN007 — Broker & Symbol Specs

Scope:
- specs cache
- spread
- tick value
- volume min/max/step
- stops/freeze
- broker constraints
- partial/hard-absence classification

Test:
- missing optional fields do not degrade required spec readiness
- required field missing is visible
- active L4 set refreshes every 1 minute after ready

Lock candidate:
Broker & Symbol Specs.

### ARL-RUN008 — Indicator foundation

Scope:
- indicator registry/cache
- ATR module first
- CopyBuffer readiness handling
- handle lifecycle

Test:
- handle created once
- CopyBuffer -1/partial does not become fake zero
- BUILDING/READY/FAILED states are visible

Lock candidate:
Indicator Registry + ATR.

### ARL-RUN009 — Surface Ranking

Scope:
- numeric surface score
- spread bps
- spread-to-ATR
- quote health
- execution/friction numeric stack
- universe-wide warmup and 20 minute ready refresh

Test:
- full L3 snapshot reaches COMPLETE during warmup
- L3 current only promotes complete snapshot
- no trade/signal language

Lock candidate:
L3 Surface Ranking.

### ARL-RUN010 — Bucket Ranking

Scope:
- Global Top 10
- Top 5 per major bucket
- Top 5 per minor bucket
- active L4 set
- L4 refresh offset 5 minutes after L3

Test:
- L4 consumes committed L3 snapshot only
- major/minor hierarchy correct
- bucket with fewer than 5 available symbols still marks complete with available count

Lock candidate:
L4 Bucket Ranking.

### ARL-RUN011 — Market Board

Scope:
- numeric-first board
- upload suggestion best 3/5/10
- account exposure exclusions
- retry/schedule state
- active L4 set published

Test:
- board atomic publish
- l3/l4 snapshot ids match
- no stale/retained baseline presented as current
- no trade permission leak

Lock candidate:
Market Board.

### ARL-RUN012 — Deep Review scheduler

Scope:
- L5 every 5 minutes for active L4 set
- auto deep for major-bucket leaders
- manual deep support
- minor bucket deep only manual/authorized

Test:
- L5 does not run full universe
- L5 cannot change L3/L4 membership directly
- L5 status appears in board and dossiers

Lock candidate:
Deep Review Scheduler.

### ARL-RUN013 — Dossier skeleton

Scope:
- numeric-first dossier
- sections: snapshot, identity, market state, specs, ranking, deep review, account exposure, missing/degraded, operator summary
- no route diagnostics unless contradiction exists

Test:
- dossier preserves board baseline
- required missing fields visible
- optional unavailable fields summarized
- no signal/trade language

Lock candidate:
Dossier Base.

### Later

- Formula refinement
- Efficiency profiling
- ASC migration candidate review
- Runtime output audits
- HUD only after core is proven and locked
