# ARL Research To Implementation Protocol

Research is mandatory for serious ARL work.

Research is not allowed to remain cosmetic.

## Mandatory sequence

Every source-changing GPT pass must do:

```text
1. Audit uploaded zip.
2. Research official/external sources.
3. Audit Git/current repo state.
4. Analyze how research applies.
5. Patch owner files.
6. Debug/compile check.
7. Package zip.
8. Update office ledgers.
```

## Research quality rule

Every research item must become one of:

```text
coding constraint
acceptance test
falsifier
risk entry
migration decision
```

If it does not change code, tests, risk, or decisions, it is probably ornamental.

## Research ledger row

```text
Research source:
Finding:
Evidence quality:
ARL implication:
Code constraint:
Test:
Falsifier:
Affected files:
Decision:
```

## Triple-layer check

Every serious implementation decision must check:

```text
1. Official/external source
2. ASC/archive lesson
3. ARL owner contract
```

Example:

```text
Official source:
CopyBuffer may return -1 when data is not ready.

ASC lesson:
Old outputs sometimes projected unavailable/placeholder truth too noisily or too confidently.

ARL rule:
Indicator module must expose READY/BUILDING/PARTIAL/FAILED and never mark zero ATR as READY after CopyBuffer failure.

Test:
Force fresh ATR handle on cold symbol/timeframe and verify BUILDING before READY.
```

## Preferred source hierarchy

1. Official MetaQuotes/MQL5 docs for MT5 behavior
2. Current active ARL source
3. Uploaded zip source
4. Git current source
5. Archive/ASC evidence
6. AI reasoning

AI reasoning is never proof.
