---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Output Style Guide

Final output must be clean enough for human review and structured enough for machine parsing.

## Operator Files

Operator-facing files:

- `MarketBoard_Current.txt`
- `Dossier_Current.txt`

Must be:

- short
- numeric-first
- no repeated proof walls
- no developer-only taxonomy spam
- no giant unavailable lists
- no raw route diagnostics unless contradiction exists
- no hidden trade permission language

## Machine Files

Machine-facing files:

- `MarketBoard_Current.json`
- `Symbol_Current.json`
- `Account_Current.json`
- `L3_SurfaceRank_Current.json`
- `L4_GroupRank_Current.json`
- `Manifest_Current.json`

May include:

- full field status
- exact timestamps
- owner names
- missing reasons
- retry states
- schema versions
- hashes/signatures
- diagnostic codes

## Language Rule

Final product should prefer:

```text
Market State
Broker Specs
Surface Ranking
Bucket Ranking
Deep Review
```

It should not force operators to read:

```text
L1
L2
L3
L4
L5
```

Layer codes may appear in JSON and trace sections only.

## Missing Data Rule

- Required missing data: visible and blocking.
- Optional missing data: summarized.
- Irrelevant missing data: hidden from operator text, retained in JSON/debug if useful.

## Permission Language

Every operator file must include exactly one clear permission block near the top or bottom:

```text
Review Permission: TRUE
Trade Permission: FALSE
Signal Permission: FALSE
Execution Permission: FALSE
Risk Permission: FALSE
```

Do not repeat this on every section unless an explicit contradiction exists.
