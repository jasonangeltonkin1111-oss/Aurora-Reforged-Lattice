# ARL Evidence and Proof Language Guide

Run: ARL-RUN009G  
Status: Mandatory for reports, prompts, audits, and Git descriptions

---

## Purpose

This guide prevents fake proof.

---

## Allowed Language

Use precise evidence language:

```text
source inspected
static validation passed
compile passed
runtime smoke test passed
runtime not tested
compile not available
user-reported compile pass
Git checked
Archives inspected
research converted into constraints
```

---

## Forbidden Overclaims

Do not say:

```text
proved
ready
safe
working
trade-ready
live-safe
edge confirmed
robust
production-ready
```

unless evidence supports that exact claim.

---

## Evidence Ladder

```text
0 = idea / claim
1 = AI reasoning
2 = user report / screenshot / pasted text
3 = direct source inspection
4 = compile/static validation
5 = known backtest
6 = out-of-sample/walk-forward/robustness
7 = forward demo
8 = small live
9 = multi-broker/multi-regime live
10 = production-proven with logs/boundaries
```

---

## Common Corrections

Wrong:

```text
Compile passed, so runtime IO is proven.
```

Correct:

```text
Compile passed. Runtime IO remains untested until MT5 output/log evidence exists.
```

Wrong:

```text
The system is ready.
```

Correct:

```text
The system is ready for the next bounded test.
```

Wrong:

```text
This output is truthful.
```

Correct:

```text
The output passed readback/static validation under this test.
```

---

## Required Report Section

Every serious report must include:

```text
Evidence available
Evidence missing
Claims allowed
Claims forbidden
```

---

## Trading Edge Rule

No ranking, score, backtest, or sample output proves edge by itself.

Trading edge claims require:
- defined falsifier,
- cost model,
- broker/session segmentation,
- out-of-sample or robustness evidence,
- forward/demo evidence,
- live evidence for live claims.

Until then:

```text
UNPROVEN / TEST FIRST
```
