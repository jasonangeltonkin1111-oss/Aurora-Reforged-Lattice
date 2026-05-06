# ARL Migration Register

## Purpose

This file tracks what ARL may mine from ASC / Archives.

Nothing in Archives is active ARL authority by default.

## Classification labels

| Label | Meaning |
|---|---|
| KEEP_AS_HISTORY | Historical only |
| MINE_FOR_CONTRACTS | Useful design law, rewrite cleanly |
| MINE_FOR_TESTS | Known failure should become test |
| MIGRATION_CANDIDATE | Possible code/schema to inspect deeply later |
| REJECT_OR_DEFER | Do not carry forward now |
| UNKNOWN | Not inspected |

---

## M001 — ASC Market Board sample

Source:
Uploaded `Market Board(133).txt`

Classification:
MINE_FOR_CONTRACTS + MINE_FOR_TESTS

Useful:
- Ranking split: bucket-local Top 5 vs diversified overall Top 10.
- Review authority separated from trade permission.
- Missingness states remain explicit.
- Board row includes scores, ranks, exposure, correlation, trace, and deep analysis boundary.

Problems to fix:
- Too much proof-boundary text in operator output.
- Board-child alignment and top5 sync uncertainty.
- Publication can be pending while output body appears rich.
- Labels can dominate numbers.

ARL action:
Rewrite as concise numeric-first board with snapshot ids, publish status, active L4 set, and upload suggestions.

Do not copy directly.

---

## M002 — ASC CADSGD Dossier sample

Source:
Uploaded `CADSGD(70).txt`

Classification:
MINE_FOR_CONTRACTS + MINE_FOR_TESTS

Useful:
- Numeric L3/L4/L5 stack.
- Publication health.
- Section status.
- Board baseline relation.
- Missing/degraded status.

Problems to fix:
- Diagnostic repetition.
- Optional unavailable fields pollute operator output.
- Too much prose.
- Trade permission repeated too often.

ARL action:
Create clean numeric-first dossier scaffold. Required missing fields are visible; optional missing fields summarized.

Do not copy directly.

---

## M003 — ASC EURUSD Symbol Data Pack sample

Source:
Uploaded `EURUSD_SYMBOL_DATA_PACK(56).txt`

Classification:
MINE_FOR_CONTRACTS + MIGRATION_CANDIDATE later

Useful:
- Atomic publication contract.
- Temp/readback/promote/no-change/retained final.
- Numeric rule.
- Writer composes existing owner truth only.
- Tick/spread/OHLC/ATR refresh contracts.

Problems to fix:
- L3/L4 owner gap due to runtime state not bound to composer.
- Route context verbose.
- Flat transition deprecated language not relevant to ARL.

ARL action:
Use as atomic publication and per-symbol contract inspiration. Solve L3/L4 transport from the start.

Do not copy directly.

---

## M004 — ASC Dossier system

Classification:
MIGRATION_CANDIDATE later

Useful:
- Section composer concept.
- Section status.
- Publication health.
- Human-readable review output.

Risk:
- Large include graph.
- Verbose diagnostics.
- Old route assumptions.

ARL action:
Rebuild structure from scratch; mine sections after ARL dossier skeleton is stable.

---

## M005 — ASC Dispatcher

Classification:
REJECT_OR_DEFER

Reason:
Old dispatcher was too large and carried budget/route complexity.

ARL action:
Do not migrate. Build small scheduler slices.

---

## M006 — ASC HUD

Classification:
REJECT_OR_DEFER

Reason:
User explicitly excluded HUD until core works.

ARL action:
No HUD folder in early scaffold.

---

## M007 — ISS-X DeepSpec Harvester

Classification:
MIGRATION_CANDIDATE later

Useful:
- Broker/symbol spec harvesting.
- Sessions.
- Tick freshness.
- Margin/profit probes.

Risk:
- Need compile proof.
- Need runtime cost proof across many symbols.
- Need output schema simplification.

ARL action:
Review around Layer 2 phase only. Do not import in scaffold.
