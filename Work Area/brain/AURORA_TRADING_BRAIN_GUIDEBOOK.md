# AURORA TRADING BRAIN GUIDEBOOK

Run: ARL-RUN009G  
Status: Mandatory for trader-data, Market Board, Symbol Trader Pack, Dossier, ranking, and operator-output work

---

## Purpose

This guidebook stores durable lessons about what trader-facing ARL outputs must show.

It exists because ASC had useful trading intelligence buried under metadata walls, while early ARL samples were too thin on per-symbol trader data.

The correct path is:

```text
ASC-level intelligence.
ARL-level cleanliness.
Trader data first.
Metadata somewhere else.
```

---

## Prime Trader Output Law

```text
Operator-facing text files must show trader data, not metadata.
```

Metadata belongs in:

```text
Manifest_Current.json
Debug_Current.json
Symbol_Current.json
office/
Git commits
reports/
```

---

## Output Role Law

```text
Market Board = operator battle board.
Symbol Trader Pack = full per-symbol trader truth.
Dossier = readable selected-symbol deep review.
Symbol_Current.json = complete structured machine truth.
Manifest_Current.json = publication/source/readback truth.
Debug_Current.json = route/source/diagnostic microscope.
```

Do not force one file to do all jobs.

---

## Market Board Law

Market Board must help answer:

```text
What should I check now?
What is the best pick?
What is the backup?
What should be guarded or avoided?
Which buckets are strongest?
What does account exposure say?
What does recent account history say?
```

It must include:

```text
operator command surface
global top 10
top 5 per major bucket
top 5 per minor bucket
best 3 / 5 / 10 to check now
guarded / avoided symbols
account summary
account exposure summary
account trade history summary
retry/schedule status
permission boundary
```

---

## Symbol Trader Pack Law

This is the missing layer that must not be underbuilt.

Every Symbol Trader Pack must include:

```text
quick trader snapshot
account + symbol exposure
symbol trade history
recent closed trades first two only
market state + cost
ATR/range/volatility
momentum + microstructure
liquidity + structure
recent closed bars first two only
setup fit
final trader read
permission boundary
```

If it does not include symbol trade history, it fails.

If it does not include spread/ATR/friction, it fails.

If it does not include recent bars, it fails.

If it is mostly metadata, it fails.

---

## Dossier Law

Dossier is the readable review, not the full warehouse.

It should include:

```text
selected symbol summary
account + symbol exposure
symbol trade history summary
market state + friction
ranking context
deep review scores
analyst execution
analyst liquidity / position
analyst momentum / microstructure
setup fit
recent closed bars first two only
recent closed trades first two only
final trader read
```

---

## Bars and Trades Text Rule

Text files show only:

```text
first two recent closed bars
first two recent closed trades
```

Full arrays go to JSON.

This keeps text readable while preserving complete data elsewhere.

---

## No Entry Language Law

Forbidden until future explicit permission:

```text
BUY
SELL
ENTER
TAKE TRADE
SIGNAL CONFIRMED
EXECUTE
```

Allowed review states:

```text
CHECK_NOW
WATCH
GUARDED
AVOID
```

---

## Trader Data Required Fields

Future implementations must eventually provide:

```text
spread_points
spread_bps
spread_to_atr
ATR M5/M15/H1
tick_age_seconds
range position
distance to high/low
momentum score
pressure score
burst score
liquidity score
sweep risk score
structure score
continuation score
reversal risk score
scalp fit
intraday fit
swing fit
clean review score
exposure load score
symbol trade history
```

---

## Overfitting / Edge Warning

Trader-data outputs are not proof of edge.

They are review tools.

A ranking system becomes an edge claim only after falsification, out-of-sample testing, live/demo evidence, broker-cost handling, slippage/spread reality, and prop-rule safety are addressed.

Until then:

```text
Review intelligence only.
No trade permission.
```
