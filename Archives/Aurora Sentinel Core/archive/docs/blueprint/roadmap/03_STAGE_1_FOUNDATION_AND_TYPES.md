# ASC Stage 1 — MT5 Foundation Opening and Compile-Safe Scaffold

## Purpose

Stage 1 opens the active MT5 implementation surface and lands the first compile-oriented EA scaffold with foundational write/HUD/logging rails present from the start, without widening into scanner-layer hydration or Stage 2 governor work.

This stage is where ASC stops being blueprint-only for implementation and becomes a real MT5 module tree with code-owned runtime publication homes.

---

## Stage 1 now explicitly means

1. Active MT5 implementation surface exists at `Aurora Sentinel Core/mt5/`.
2. Grouped MT5 module structure exists (`core/`, `runtime/`, `io/`, `logging/`, `artifacts/`, `menu/`, `symbols/`, `tests/`).
3. Runtime publication homes are code-owned (not repo proof files).
4. Workbench scaffolding exists for `temp/`, `failed/`, and `logs/` under runtime ownership.
5. Compile-oriented EA shell exists (`AuroraSentinelCore.mq5`) and boots Stage 1 scaffolds.
6. Runtime-owned bounded testing writes are admissible from Stage 1 for `Market Board.txt`, `Current Focus.txt`, and `Dossiers/*.txt` (with truthful placeholder content allowed).
7. HUD consumer scaffold homes are admissible from Stage 1 and may start structurally thin.
8. Bounded dev/workbench logging scaffold is mandatory from Stage 1 and records function, scope/symbol, success/failure, failure reason, and target path where relevant.
9. No fake operator-output proof files are used for completion claims.

---

## Stage 1 includes

- compile-safe EA entry shell and include graph
- runtime posture/types/results/constants scaffolding
- server-root + artifact path ownership scaffolding
- directory bootstrap helpers for runtime homes
- function-result and dev/workbench logging scaffolding
- runtime-owned bounded testing write scaffold for Market Board / Current Focus / Dossier
- menu/settings placeholder models aligned to blueprint contracts
- symbol normalization + classification bridge placeholders
- retention of Stage 1 schema validators as drift-check surfaces

## Stage 1 does not include

- full scanner layer implementation
- Layer 1 truth hydration completion
- Stage 2 dispatcher/governor completion
- rich HUD/operator implementation completion
- trade execution logic
- static repo-side operator artifacts used as fake runtime proof

---

## Runtime publication-home law (Stage 1)

The following homes must be owned in code-facing path modules and bootstrap state:

- server root
- `Market Board.txt`
- `Current Focus.txt`
- `Dossiers/`
- `Workbench/temp/`
- `Workbench/failed/`
- `Workbench/logs/`

These are runtime publication homes only. Stage 1 may wire and publish bounded testing outputs from runtime ownership, but must not fabricate repo-side operator-output text files as proof. Early placeholder sections are allowed only when clearly marked truthful placeholders (`not yet observed`, `unavailable`, `awaiting later layer`, `not applicable`) and designed for in-place replacement by later layers.

---

## Stage 1 implementation evidence (opening pass)

Required code surfaces:

- `mt5/AuroraSentinelCore.mq5`
- `mt5/core/*`
- `mt5/runtime/*`
- `mt5/io/*`
- `mt5/logging/*`
- `mt5/artifacts/*`
- `mt5/menu/*`
- `mt5/symbols/*`
- `mt5/tests/README.md`

Retained drift/contract evidence surfaces:

- `stage1/ASC_STAGE1_FOUNDATION_TYPES.json`
- `stage1/ASC_STAGE1_MENU_SETTINGS_SCHEMA.json`
- `stage1/validate_stage1_foundation.py`

---

## Exit posture for Stage 1

Stage 1 is complete only when:

- MT5 scaffold tree exists and is coherent,
- EA shell + includes are compile-oriented,
- runtime publication/workbench homes are code-owned,
- artifact/menu/symbol placeholders are bounded and truthful,
- office/roadmap surfaces reflect this as implementation opening, not runtime-complete scanner behavior.
