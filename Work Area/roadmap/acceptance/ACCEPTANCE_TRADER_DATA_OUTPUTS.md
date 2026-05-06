# Acceptance — Trader Data Outputs

Run: ARL-RUN006  
Scope: Additive acceptance file only

---

## Required Outputs

The implementation is not accepted until ARL can publish:

```text
MarketBoard_Current.txt
Symbol_Trader_Pack_Current.txt
Symbol_Dossier_Current.txt
Symbol_Current.json
Manifest_Current.json
```

Debug file is optional until verbose diagnostics are implemented.

---

## Market Board Acceptance

Market Board must include:

```text
operator command surface
account summary
account exposure summary
account trade history summary
global top 10
top 5 per major bucket
top 5 per minor bucket
best 3 / 5 / 10 to check now
guarded / avoided symbols
retry + schedule status
permission boundary
```

Must not include full metadata walls.

---

## Symbol Trader Pack Acceptance

A Symbol Trader Pack passes only if it includes:

```text
quick trader snapshot
account + symbol exposure
symbol trade history
recent closed trades first two only
market state
broker cost/friction
ATR/range/volatility
momentum/pressure/tick flow
liquidity/structure
ranking context
deep scores
recent closed bars first two only
setup fit
final trader read
permission boundary
```

---

## Dossier Acceptance

Dossier must include:

```text
selected symbol summary
rank context
symbol exposure
symbol trade history summary
L1/L2/L3/L4/L5 trader data
analyst-style execution/liquidity/momentum/setup-fit blocks
final trader read
```

The dossier may be more narrative than the trader pack, but it may not omit core trader facts.

---

## Fail Conditions

Fail if:

```text
metadata dominates trader data
symbol trade history is missing
open/pending exposure is missing
recent bars are missing
recent closed trades are missing
spread-to-ATR is missing
rank context is missing
setup fit is missing
final trader read is vague
trade permission is implied
JSON/debug loses metadata removed from text
```

---

## Lock Condition

A trader-data output module may be locked only after:

```text
static validation passes
compile passes if source changed
sample output contains required fields
readback confirms public artifact
no metadata wall leaks into operator text
no trade/signal/execution permission appears
```
