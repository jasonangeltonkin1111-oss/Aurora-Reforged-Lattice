# ARL Trader Data Sample Reference Ledger

Run: ARL-RUN006  
Scope: Additive ledger only  
Purpose: Records that the ARL trader-data sample files are mandatory references for future output design.

---

## Mandatory Reference Files Added In RUN006

```text
Work Area/blueprint/ARL_TRADER_DATA_OUTPUT_STANDARD.md
Work Area/blueprint/ARL_MARKET_BOARD_TRADER_DATA_STANDARD.md
Work Area/blueprint/ARL_SYMBOL_TRADER_PACK_BLUEPRINT.md
Work Area/blueprint/ARL_DOSSIER_TRADER_DATA_BLUEPRINT.md
Work Area/blueprint/samples/MarketBoard_TraderData.sample.txt
Work Area/blueprint/samples/Symbol_Trader_Pack.sample.txt
Work Area/blueprint/samples/Symbol_Dossier_TraderData.sample.txt
Work Area/blueprint/schemas/symbol_trader_pack.schema.md
Work Area/roadmap/ARL_TRADER_DATA_BUILD_GUIDE.md
Work Area/roadmap/acceptance/ACCEPTANCE_TRADER_DATA_OUTPUTS.md
Work Area/roadmap/runs/ARL_RUN006_TRADER_DATA_REFERENCE_PLAN.md
```

---

## Future Run Requirement

Before changing any of these areas:

```text
Market Board
Symbol Data Pack
Symbol Trader Pack
Symbol Dossier
Symbol_Current JSON
Dossier output
MarketBoard output
L3/L4/L5 output payloads
Account exposure output
Trade history output
```

the run must read and follow the RUN006 trader-data references.

---

## Correction Logged

Earlier samples were too metadata-oriented and too thin on per-symbol trader data.

Corrected rule:

```text
Do not make operator-facing files metadata-heavy.
Make them trader-data-rich.
Move metadata to manifest/debug/json.
```

---

## Protected Principle

```text
ASC-level intelligence, ARL-level cleanliness.
```

This means:

- keep trading-useful detail
- remove metadata walls
- keep numerical score stacks
- preserve per-symbol depth
- keep text readable
- put full proof/debug in JSON/manifest/debug files

## ARL-RUN007 Presence Check

Uploaded Work Area package contains the RUN006 trader-data reference files listed by this ledger, including:

- `blueprint/ARL_TRADER_DATA_OUTPUT_STANDARD.md`
- `blueprint/ARL_MARKET_BOARD_TRADER_DATA_STANDARD.md`
- `blueprint/ARL_SYMBOL_TRADER_PACK_BLUEPRINT.md`
- `blueprint/ARL_DOSSIER_TRADER_DATA_BLUEPRINT.md`
- `blueprint/samples/MarketBoard_TraderData.sample.txt`
- `blueprint/samples/Symbol_Trader_Pack.sample.txt`
- `blueprint/samples/Symbol_Dossier_TraderData.sample.txt`
- `blueprint/schemas/symbol_trader_pack.schema.md`
- `roadmap/ARL_TRADER_DATA_BUILD_GUIDE.md`
- `roadmap/acceptance/ACCEPTANCE_TRADER_DATA_OUTPUTS.md`
- `roadmap/runs/ARL_RUN006_TRADER_DATA_REFERENCE_PLAN.md`

If a future source package lacks any of these, the run must log a contradiction and either restore the references or explicitly quarantine trader-data implementation.
