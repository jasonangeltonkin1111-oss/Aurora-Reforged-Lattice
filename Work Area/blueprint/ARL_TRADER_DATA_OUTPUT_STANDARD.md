# ARL Trader Data Output Standard

Run: ARL-RUN006  
Scope: Blueprint additive reference  
Status: Must be referenced by every future output implementation run.

---

## One-Line Law

```text
Operator-facing outputs must show trader data, not metadata.
```

---

## File Split

```text
MarketBoard_Current.txt
  operator command surface

Symbol_Trader_Pack_Current.txt
  full per-symbol trader data

Symbol_Dossier_Current.txt
  selected-symbol human deep review

Symbol_Current.json
  complete structured symbol truth

Manifest_Current.json
  publication/currentness/source/readback truth

Debug_Current.json
  verbose route/source/owner diagnostics
```

---

## Trader Data Priority

Text outputs must prioritize:

```text
account exposure
trade history
market state
spread/friction
ATR/range
momentum/pressure
liquidity/structure
ranking context
deep scores
recent bars
recent closed trades
setup fit
operator read
```

---

## Metadata Placement

These do not belong in normal text output:

```text
artifact_family
schema_version
source_identity_token
route_temp_path
route_final_path
route_last_good_path
duplicate_route_diagnostic
mirror_contract
proof_boundary
fake_hash
compile_hash
taxonomy wall
old run-number chains
repeated source-owner blocks
```

They belong in manifest/debug/JSON.

---

## Numeric-First Rule

Every quality claim must have a number where possible.

Good:

```text
momentum_score: 49.30
momentum_read: balanced
```

Bad:

```text
momentum: balanced
```

Labels may support numbers.

Labels may not replace numbers.

---

## Text Length Rule

Text output may be detailed, but not noisy.

Show:

```text
first two recent closed bars
first two recent closed trades
summaries of larger arrays
```

Keep full arrays in JSON.

---

## Permission Rule

Trader output may say:

```text
CHECK_NOW
WATCH
GUARDED
AVOID
```

It may not say:

```text
BUY
SELL
ENTER
TAKE TRADE
```

until future evidence and permission boundaries authorize it.

Default:

```text
trade_permission: FALSE
signal_permission: FALSE
execution_permission: FALSE
```
