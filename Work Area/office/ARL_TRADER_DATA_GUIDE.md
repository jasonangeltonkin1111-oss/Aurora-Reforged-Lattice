# ARL Trader Data Guide

Run: ARL-RUN006  
Scope: Additive reference guide only  
Authority: Must be read by future GPT/Codex runs before changing Market Board, Symbol Trader Pack, Dossier, Symbol_Current JSON, or related output schemas.  
Status: Reference law. No MT5 source changes in this pack.

---

## Purpose

ARL operator-facing files must prioritize **trader data**, not system metadata.

The previous sample direction was corrected by the user:

> Metadata is not the target. Trader data is the target.

This guide exists to prevent ARL from repeating the ASC problem where strong trading intelligence was buried under artifact metadata, route diagnostics, proof-boundary walls, and repeated system-state blocks.

ARL must preserve the strong trading intelligence, while moving heavy metadata into manifest/debug files.

---

## Core Rule

```text
Operator-facing text files = trader data first.

Manifest/debug/json files = metadata, proof, routes, owners, schemas, verbose diagnostics.
```

Trader files must answer:

```text
What is the symbol doing?
How tradable is it right now?
Where does it rank?
What is the friction?
What is the account exposure?
What is recent trade history?
What are the recent bars/ticks saying?
What is the setup fit?
What should the operator check now?
```

They must not drown the operator in:

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
identity diagnostic repeats
old run-number chains
```

Those belong in Manifest_Current.json, Debug_Current.json, office logs, and Git.

---

## Required Operator-Facing Files

ARL must eventually produce these trader-facing outputs:

```text
MarketBoard_Current.txt
Symbol_Trader_Pack_Current.txt
Symbol_Dossier_Current.txt
```

And these machine/proof outputs:

```text
MarketBoard_Current.json
Symbol_Current.json
Manifest_Current.json
Debug_Current.json
```

The text files are for the trader/operator.

The JSON/manifest/debug files are for source truth, audit, regression, and troubleshooting.

---

## Output Roles

### MarketBoard_Current.txt

Role:

```text
Operator battle board.
```

It should show:

- command surface
- best pick now
- backup pick
- avoid/guarded symbols
- immediate rotation
- global top 10
- top 5 per major bucket
- top 5 per minor bucket
- best 3/5/10 to check now
- account summary
- exposure summary
- trade history summary
- retry/schedule status
- permission boundary

It must not become a per-symbol encyclopedia.

---

### Symbol_Trader_Pack_Current.txt

Role:

```text
Complete per-symbol trader data pack.
```

It should show the full tradability picture for one symbol:

- quick trader snapshot
- account + symbol trade history
- open/pending exposure
- market state
- broker friction
- ATR/range/volatility
- momentum/pressure/tick flow
- liquidity/structure
- recent closed bars
- setup fit
- final trader read

This is the missing layer the assistant previously underbuilt.

---

### Symbol_Dossier_Current.txt

Role:

```text
Human-readable selected-symbol deep review.
```

The dossier may summarize the trader pack, but it must not replace the full per-symbol trader pack.

The dossier is for focused reading.

The trader pack is for full data extraction and AI/Siam review.

---

## Metadata Handling

Minimal metadata allowed in text outputs:

```text
symbol
generated time
product version
run id
snapshot id
review/trade permission
```

Heavy metadata goes to:

```text
Manifest_Current.json
Debug_Current.json
office/
Git commits
```

If an operator needs the metadata, it should be accessible elsewhere, not printed in every text block.

---

## Non-Negotiable Trader Data

Every per-symbol trader output must include:

```text
1. Symbol identity
2. Account exposure on that symbol
3. Symbol trade history
4. Market state
5. Broker cost/friction
6. Volatility/range
7. Momentum/pressure
8. Liquidity/structure
9. Ranking context
10. Deep review scores
11. Recent closed bars — first two only in text
12. Recent closed trades — first two only in text
13. Setup fit
14. Final trader read
15. Permission boundary
```

---

## Bars and Trades Display Rule

Text files should show:

```text
Recent closed bars: first two only
Recent closed trades: first two only
```

Full arrays belong in JSON, not text.

Reason:

```text
Text must remain readable.
JSON can be complete.
```

---

## Account and Trade History Rule

Account info is mandatory.

Symbol-specific trade history is mandatory.

Do not only show account balance/equity.

Show:

```text
open positions on symbol
pending orders on symbol
floating PnL on symbol
closed trades lookback
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

If unavailable, show the reason.

Do not silently omit.

---

## Setup Fit Rule

ARL must distinguish between:

```text
Review candidate
Scalp candidate
Intraday candidate
Swing candidate
Guarded candidate
Avoid candidate
```

No file may imply trade permission.

Trader read may say:

```text
CHECK_NOW
WATCH
GUARDED
AVOID
```

But never:

```text
BUY
SELL
ENTRY NOW
TAKE TRADE
```

until future evidence and permission boundaries explicitly allow it.

---

## Acceptance Standard

A trader-data output passes only if a trader can answer:

```text
Why is this symbol worth checking?
What is the cost/friction?
Is the market open and fresh?
Is there existing exposure?
What happened in recent symbol trade history?
What do bars/ticks say?
What is the setup fit?
What should I do with it now: check, watch, guard, or avoid?
```

If not, the file is too weak.
