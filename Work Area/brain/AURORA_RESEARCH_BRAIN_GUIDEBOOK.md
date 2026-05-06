# AURORA RESEARCH BRAIN GUIDEBOOK

Run: ARL-RUN009G  
Status: Mandatory for any serious ARL research, code, architecture, runtime, MT5, output, risk, or prompt-building work

---

## Purpose

This guidebook turns research into implementation intelligence.

Research is not a ritual.  
Research is not citation theater.  
Research is not “I looked it up.”

Research must become:

```text
Source -> Finding -> Constraint -> Owner -> Test -> Falsifier -> Brain update
```

If it does not affect the system, it is ornamental.

---

## Research Conversion Table

Every serious run must use this table for meaningful research.

```text
Source:
Finding:
Evidence rank:
Why it matters:
Risk prevented:
ARL constraint:
Owner file/module:
Implementation impact:
Acceptance test:
Falsifier:
Brain update needed? yes/no
Destination guidebook section:
```

---

## Evidence Rank Guide

Use the strongest real evidence available.

```text
0 = idea / claim
1 = AI reasoning
2 = user report / screenshot / pasted output
3 = direct source inspection
4 = compile/static validation
5 = known backtest result
6 = out-of-sample / walk-forward / robustness
7 = forward demo
8 = small live
9 = multi-broker/multi-regime live
10 = production-proven with logs and boundaries
```

Do not claim above the evidence rank.

---

## Primary Source Preference

For platform behavior, use primary sources first:

```text
MQL5 official documentation
Git official documentation
OpenAI official documentation
broker/platform official docs where relevant
```

Use secondary sources only when they add implementation context and are not contradicted by primary docs.

---

## Archive Evidence Handling

Git Archives are inheritance evidence.

They may provide:
- old patterns,
- old fields,
- old mistakes,
- migration candidates,
- failure examples,
- anti-patterns.

They may not:
- outrank active Work Area source,
- be copied directly into active source,
- be treated as current truth,
- be included in upload zips.

Archive lessons must be converted into constraints/tests/falsifiers.

---

## No Ornamental Research Rule

Delete research if it only:

```text
sounds smart
adds citations without changing action
summarizes broadly
repeats known ideas
adds doctrine without tests
```

Keep research if it:

```text
prevents failure
changes implementation
creates acceptance criteria
adds falsifier
clarifies ownership
reduces runtime/compile/source risk
improves trader-data quality
improves prop/risk safety
```

---

## Required Research Types By Work

### Runtime / IO

Research must cover:
- timer event behavior,
- file sandbox,
- atomic write mechanics,
- readback,
- error handling,
- scheduler pressure.

### Account / trade history

Research must cover:
- account APIs,
- positions,
- orders,
- deals,
- HistorySelect boundaries,
- server time vs local time,
- closed-trade reconstruction risk.

### Indicator / bars / ticks

Research must cover:
- handle creation,
- CopyBuffer readiness,
- CopyRates/CopyTicks behavior,
- not-ready states,
- series synchronization risk.

### Trader outputs

Research must cover:
- what fields improve operator decisions,
- metadata separation,
- JSON/text role split,
- missing/degraded handling.

### Prompts / agents

Research must cover:
- mandatory read order,
- repo instructions,
- Git/Archive access asymmetry,
- prompt drift prevention,
- proof-language discipline.

---

## Research Must End With Tests

Every research constraint needs:

```text
acceptance test
falsifier
owner file
```

Otherwise it is not ready for implementation.
