# ARL-RUN006 — Trader Data Reference Plan

Mode: ROADMAP + BLUEPRINT ADDITIVE REFERENCE  
Source: User correction after reviewing ASC Market Board, Symbol Data Packs, and Dossiers.  
Scope: Add new reference guide and sample files only.  
No current files changed.

---

## User Correction

The user clarified:

```text
The Market Board structure was mostly fine.
The real missing part was per-symbol trader data.
The user does not want metadata.
The user wants trader data.
```

---

## RUN006 Objective

Create permanent reference files that future work must read before building or changing trader-facing outputs.

---

## Files Added

```text
office/ARL_TRADER_DATA_GUIDE.md
office/ARL_TRADER_DATA_SAMPLE_REFERENCE_LEDGER.md
roadmap/ARL_TRADER_DATA_BUILD_GUIDE.md
roadmap/acceptance/ACCEPTANCE_TRADER_DATA_OUTPUTS.md
roadmap/runs/ARL_RUN006_TRADER_DATA_REFERENCE_PLAN.md
blueprint/ARL_TRADER_DATA_OUTPUT_STANDARD.md
blueprint/ARL_MARKET_BOARD_TRADER_DATA_STANDARD.md
blueprint/ARL_SYMBOL_TRADER_PACK_BLUEPRINT.md
blueprint/ARL_DOSSIER_TRADER_DATA_BLUEPRINT.md
blueprint/samples/MarketBoard_TraderData.sample.txt
blueprint/samples/Symbol_Trader_Pack.sample.txt
blueprint/samples/Symbol_Dossier_TraderData.sample.txt
blueprint/schemas/symbol_trader_pack.schema.md
```

---

## Build Impact

This run does not change source behavior.

Future implementation runs must use these references to build:

```text
account exposure
symbol trade history
symbol trader pack
dossier trader data
market board trader references
JSON/manifest/debug split
```

---

## Forbidden In RUN006

```text
No MT5 source changes
No current file edits
No HUD
No trading
No signal logic
No execution
No formula finalization
No archive copy
```

---

## Decision

TEST FIRST.

These files define what must be tested later; they do not prove implementation.
