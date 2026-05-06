# ARL Build Sequence

## Build doctrine

Build the system in layers.

Do not start with strategy, HUD, or execution.

Do not import ASC as a body. Mine ASC as evidence.

Do not let Codex build everything at once.

## Stage 0 — Planning files

Creates:
- `office/`
- `roadmap/`
- `blueprint/`

No active MQL5 source.

Purpose:
- lock the plan
- define the final product
- define the build sequence
- prevent ASC drift from re-entering

## Stage 1 — Codex MT5 scaffold only

Codex creates folder structure and empty/placeholder-safe `.mq5/.mqh` scaffold only.

Allowed:
- folder creation
- include-boundary skeleton
- header comments linking roadmap/blueprint/office
- compile-safe no-op placeholder functions if needed

Forbidden:
- ranking formulas
- market strategy logic
- execution logic
- HUD
- old ASC copy-paste
- file route rewrites
- live/edge claims

## Stage 2 — GPT zip workflow begins

After Codex scaffold exists, GPT works by zip upload method.

Every source pass follows:

```text
1. Audit uploaded zip.
2. Mandatory external/official research.
3. Second audit against Git/current repository state.
4. Analyze how source + research + archive knowledge should be used.
5. Patch correct owner files only.
6. Debug and compile check when source changed.
7. Package changed files in original folder layout.
8. Update office ledgers.
```

## Stage 3 — Runtime / IO / Account

Build:
- version identity
- heartbeat
- scheduler
- warmup state
- refresh cadence
- atomic file publisher
- manifest
- account snapshot
- exposure map

Proof:
- compile
- status output
- account output
- atomic write/readback
- no HUD
- no trading

## Stage 4 — Universe / Market State / Symbol Specs

Build:
- Market Watch universe
- symbol folder creation
- market open/closed/unknown state
- next-open scheduling
- bounded retries
- broker/symbol specs cache

Proof:
- all Market Watch symbols classified
- open symbols stop open/closed retry
- closed symbols schedule next open
- unknown symbols retry with backoff
- specs show `READY/PARTIAL/UNAVAILABLE` with reason

## Stage 5 — Indicators + Layer 3 Surface Ranking

Build:
- indicator registry
- ATR module first
- CopyBuffer readiness handling
- L3 numeric-first surface scores

Proof:
- indicator handles cached
- data building state does not fake readiness
- L3 warmup reaches completion
- no trade language

## Stage 6 — Layer 4 Bucket Ranking

Build:
- global Top 10
- Top 5 per major bucket
- Top 5 per minor bucket
- active L4 set

Proof:
- major/minor hierarchy correct
- L4 consumes committed L3 snapshot only
- L4 warmup reaches completion
- buckets with fewer than five symbols are marked complete with available count

## Stage 7 — Market Board

Build:
- clean numeric-first board
- account/exposure included
- best 3/5/10 upload suggestions
- excluded candidates with reasons
- retry/schedule status

Proof:
- board is atomic
- board references L3/L4 snapshot IDs
- no child/dossier set mismatch allowed
- trade permission false

## Stage 8 — Layer 5 Deep Review

Build:
- active L4 set deep scheduler
- L5 every 5 minutes for active set
- auto-deep only for major-bucket leaders by default
- manual deep available for selected symbols

Proof:
- no full-universe deep loop
- L5 status numeric-first
- missing/degraded data visible
- no entry/stop/target/trade signal

## Stage 9 — Dossiers

Build:
- numeric-first symbol dossiers
- clean sections
- required missing fields shown loudly
- optional missing fields summarized
- irrelevant unavailable fields hidden from operator text

Proof:
- dossier uses Market Board/L4 snapshot identity
- no repeated diagnostic wall
- account exposure included
- trade permission false

## Stage 10 — Efficiency + Regression + Locks

Build:
- stress tests
- lock files
- regression tests
- performance budget reports

Proof:
- hundreds of symbols handled through cached/sliced refresh cycles
- no timer queue abuse
- no unnecessary file writes
- no route drift
- compile clean

## Stage 99 — HUD deferred

HUD remains out of scope until core system is stable and locked.
