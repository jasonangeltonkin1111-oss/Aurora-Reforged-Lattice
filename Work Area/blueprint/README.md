---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# Aurora Reforged Lattice Blueprint

`blueprint/` defines what the finished Aurora Reforged Lattice product must look like.

It is not the build plan. That belongs in `roadmap/`.

It is not a record ledger. That belongs in `office/`.

It is not implementation truth. That belongs in `mt5/`, once source exists and tests prove it.

## Core Purpose

Aurora Reforged Lattice is a lightweight, numeric-first, layer-based MT5 market-truth system.

The final product must:

- scan a controlled symbol universe efficiently
- classify symbols into major and minor buckets
- confirm market state and broker constraints
- compute fast surface rankings
- create complete bucket/global rankings
- run deep review only where justified
- publish atomic, consistent output files
- maintain account/exposure awareness
- preserve review-only permission boundaries
- avoid HUD/UI bloat until the core is proven

## Non-Negotiables

1. No HUD in the core product until the source, timing, files, rankings, and dossiers are proven.
2. No trade, signal, execution, or risk permission by default.
3. Numeric values come first. Labels are optional support only.
4. Layer 3 and Layer 4 must reach complete warmup before the Market Board claims readiness.
5. Layer 4 must consume only committed Layer 3 snapshots.
6. Dossiers must preserve board baseline identity and add same-symbol detail only.
7. Missing data must be classified as required, optional, or irrelevant.
8. Old ASC/Aurora archives are evidence only, not active authority.
9. Every final output must be atomic, snapshot-linked, and readback-verifiable.
10. Account and exposure context are mandatory.

## Folder Role

```text
blueprint/ = final product target
roadmap/  = how to build it
office/   = decisions, change logs, risk, locks
mt5/      = active source truth once built
tests/    = proof layer
Archives/ = inheritance evidence only
```
