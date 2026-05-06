# ARL Trader Data Build Guide

Run: ARL-RUN006  
Scope: Additive roadmap guide only  
Status: Must be read before building or modifying trader-facing output files.

---

## Purpose

This roadmap guide defines how ARL should build trader-data outputs without falling back into either failure:

```text
Failure A: ASC-style metadata walls hiding trader value.
Failure B: Oversimplified clean samples that lose per-symbol trading intelligence.
```

ARL must preserve the useful trading intelligence but present it cleanly.

---

## Build Priority

Trader-data output must be built in this order:

```text
1. Account + exposure snapshot
2. Symbol trade history snapshot
3. Market state
4. Broker friction/specs
5. Indicator/bar/tick coverage
6. L3 surface data
7. L4 board context
8. L5 deep review
9. Symbol Trader Pack
10. Dossier
11. Market Board integration
12. JSON/manifest/debug split
```

Do not build a pretty dossier before the symbol data pipeline exists.

---

## Source Ownership

```text
account/ owns account and exposure facts.
universe/ owns symbol identity and folder/file presence.
layer1_market_state/ owns open/closed/tick/session state.
layer2_symbol_specs/ owns broker specs and friction.
indicators/ owns indicator handles, bars, ticks, ATR and coverage status.
layer3_surface_rank/ owns surface score and rank eligibility.
layer4_bucket_rank/ owns global/major/minor ranking context and active set.
layer5_deep_review/ owns deep scores and setup-fit inputs.
market_board/ owns operator command surface.
dossiers/ owns human-readable selected-symbol review.
io/ owns publication.
telemetry/debug own verbose diagnostics.
```

If a value belongs to another owner, do not recompute it.

Consume it through a snapshot.

---

## No Cosmetic Module Rule

Any module used for trader data must answer:

```text
What trader decision does this data improve?
What source owns it?
What file consumes it?
What output field proves it exists?
What test fails if it breaks?
```

If no answer exists, the module is cosmetic and must be deleted, merged, or deferred.

---

## Trader Output Build Milestones

### Milestone 1 — Account + Symbol Exposure

Must output:

```text
open positions on symbol
pending orders on symbol
floating PnL on symbol
symbol exposure code
symbol exposure load score
```

### Milestone 2 — Symbol Trade History

Must output:

```text
lookback days
closed trades count
net PnL
wins/losses
win rate
avg win/loss
largest win/loss
last trade PnL
last trade age
first two recent closed trades
```

### Milestone 3 — Market + Friction

Must output:

```text
open/closed state
tick age
session state
spread points
spread bps
spread-to-ATR
ATR values
volume min/step
stops/freeze levels
friction score
```

### Milestone 4 — Bars/Ticks

Must output:

```text
bars requested
bars copied
first two closed bars in text
recent ticks used
upticks/downticks/flats
tick bias score
spread samples used
avg/max spread
spread stability score
```

### Milestone 5 — Rank + Deep Review

Must output:

```text
global rank
major bucket rank
minor bucket rank
board score
surface score
deep score
setup-fit scores
liquidity/momentum/pressure/structure/risk numbers
```

### Milestone 6 — Final Trader Read

Must output:

```text
CHECK_NOW / WATCH / GUARDED / AVOID
reason
main caution
review permission
trade permission false
```

---

## Metadata Placement

Do not remove metadata from the system.

Move it to the right place.

```text
Text files:
  trader data

JSON files:
  full structured data

Manifest files:
  publication/source/currentness/readback/version

Debug files:
  routes, owners, duplicate route diagnostics, contradiction details
```

---

## Required Future Tests

Every future implementation must test:

```text
1. Trader pack exists for each active symbol.
2. Trader pack contains account exposure.
3. Trader pack contains symbol trade history.
4. Trader pack shows first two closed bars only.
5. Trader pack shows first two recent closed trades only.
6. Market Board references trader-pack availability.
7. Dossier does not become thinner than trader pack.
8. Metadata walls do not leak into operator text.
9. No trade/signal/execution permission appears.
10. JSON/manifest/debug retain the metadata not shown in text.
```

---

## Strongest Build Rule

```text
Do not build Market Board beauty before per-symbol trader data exists.
```

A Market Board without rich per-symbol data is a hollow board.
