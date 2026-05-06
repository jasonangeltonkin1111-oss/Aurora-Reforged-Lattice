---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Source Truth Authority

Blueprint defines the target. It does not prove the target exists.

## Authority Ladder

1. Current active `mt5/` source files
2. Compile output and static validation
3. Runtime output with readback proof
4. Tests and regression artifacts
5. `locks/` for proven frozen modules
6. `office/` ledgers and decisions
7. `roadmap/` build plan
8. `blueprint/` desired product spec
9. `Archives/` inheritance evidence

## Practical Rule

If blueprint and source conflict, active source plus tests wins.

If source and roadmap conflict, source plus tests wins.

If archive and blueprint conflict, blueprint wins unless source/test evidence proves otherwise.

## Archive Rule

Archive files can be mined for:

- known failures
- useful output sections
- field names
- formulas to investigate
- migration candidates
- test cases

Archive files cannot be treated as:

- active source
- active doctrine
- compile proof
- runtime proof
- signal proof
- trading permission
- current architecture authority

---

## RUN005 Addendum — Work Area Upload Authority

For GPT repair passes, `Work Area/` is the active uploadable root.

Authority rule:
- Uploaded Work Area source is the repair baseline for that run.
- Git is the external comparison source unless the user explicitly declares Git as the baseline.
- Archives are inheritance evidence only.
- Office and Git own change history.
- MT5 source owns current product identity only.

Version identity rule:
Current product identity must agree across `ARL_Core.mq5`, `core/ARL_Version.mqh`, MT5 README, office ledger, and any active product metadata.
