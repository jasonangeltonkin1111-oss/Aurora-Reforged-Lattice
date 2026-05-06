# Aurora Reforged Lattice — Roadmap Folder

**Date:** 2026-05-06  
**Pack:** ARL_ROADMAP_PACK_RUN001  
**Status:** Planning authority only. Not source truth. Not compile proof. Not live proof.

This `roadmap/` folder explains **how Aurora Reforged Lattice gets built**.

It does not define the final product appearance. That belongs in `blueprint/`.

It does not contain active MT5 source. That belongs in `mt5/`.

It does not record every decision/change after the fact. That belongs in `office/`.

It does not override working source or tests.

## Authority boundary

Roadmap files may define:
- build sequence
- run scope
- acceptance tests
- research requirements
- migration rules
- repair rules
- Codex prompt rules
- GPT zip-audit workflow

Roadmap files may not claim:
- source truth
- compile proof
- runtime proof
- live proof
- trading edge
- signal permission
- execution readiness
- prop-firm readiness

## Folder relationship

```text
office/    = record of decisions, changes, locks, risks, ledgers
roadmap/   = how to build ARL
blueprint/ = what finished ARL should look like
mt5/       = active implementation source
tests/     = proof and regression layer
locks/     = proven module freeze records
Archives/  = inheritance evidence only
```

## Mandatory rebuild workflow

For GPT-led source passes after Codex creates the MT5 scaffold:

```text
1. Audit uploaded zip.
2. Perform mandatory deep research.
3. Audit Git/current repo state separately.
4. Analyze how research + archive knowledge applies.
5. Patch only the correct owner files.
6. Debug and compile-check when source changed.
7. Package the changed files/folder layout into a zip.
8. Update office ledgers.
```

Codex’s immediate role is narrower:

```text
Codex builds the MT5 scaffold only.
GPT later fleshes out the system using zip upload, research, audit, compile/debug, and packaging.
```

## Non-negotiables

- No HUD until core system is proven.
- No trading/execution logic during scaffold phase.
- No direct ASC source migration.
- No new route creation when fixing an existing owner.
- No fake proof.
- No roadmap claim outranks active `mt5/` source + tests.
