# ARL Testing Strategy

## Testing ladder

A claim may only rise as high as the evidence supports.

| Level | Evidence | What it proves |
|---:|---|---|
| 0 | idea / plan | nothing about source behavior |
| 1 | AI reasoning | possible approach only |
| 2 | uploaded report/output | evidence of a report/output |
| 3 | direct source inspection | what source appears to do |
| 4 | static/schema validation | structure/token/contract compatibility |
| 5 | compile result | syntax/build compatibility |
| 6 | runtime smoke test | observed runtime path works in sample conditions |
| 7 | stress/runtime regression | broader runtime stability |
| 8 | demo/live evidence | observed market/runtime behavior |
| 9 | multi-broker/multi-regime evidence | stronger operational confidence |
| 10 | production logs over time | known behavior inside observed boundaries |

## Required test types

### Static tests
- file exists where expected
- required includes present
- no forbidden route names
- no HUD includes before HUD phase
- no trade permission leaks
- no duplicate writer route

### Output contract tests
- required fields present
- numeric-first values present
- snapshot IDs consistent
- required missing reasons present
- optional missing summarized
- no stale file marked current

### Compile tests
- run after active MQL5 source changes
- do not claim runtime correctness
- log warnings as risks

### Runtime smoke tests
- status file writes
- account snapshot writes
- Market Watch universe loads
- atomic readback works

### Warmup tests
- L3 complete before L4
- L4 complete before board ready
- open symbols stop open/closed retry
- closed symbols schedule next open

### Regression tests
- locked modules remain unchanged
- old output contracts still valid
- no new alternate routes
- no route rewrites without migration record

## Test result format

```text
TEST:
SCOPE:
INPUT:
EXPECTED:
OBSERVED:
PASS/FAIL:
EVIDENCE:
NEXT ACTION:
```

---

## RUN005 Testing Addendum — Minimum Foundation Checks

Before any runtime implementation run proceeds, confirm:

1. Version parity: `#property version`, EA description, `ARL_PRODUCT_VERSION`, README, and office ledger agree.
2. Compile proof: MetaEditor compile output exists for `Work Area/mt5/ARL_Core.mq5`.
3. Runtime proof: startup log prints the same version from `ARL_VersionLine()`.
4. No-permission proof: no HUD/trade/signal/execution/risk path was added.
5. Packaging proof: output zip preserves `Work Area/` structure and excludes Archives.

## ARL-RUN007 Testing Addendum

Static tests for this run:

- include scan: every `#include` in `mt5/ARL_Core.mq5` resolves under `Work Area/mt5/`;
- duplicate-function scan: no duplicate active function definitions across `.mq5/.mqh` files;
- version scan: `#property version` equals `ARL_PRODUCT_VERSION`;
- boundary scan: no HUD, trade execution, buy/sell signal, or order-send route is introduced;
- packaging scan: output zip excludes `Archives/`.

Compile test may only be claimed with MetaEditor output.
Runtime test may only be claimed with runtime logs/output.
