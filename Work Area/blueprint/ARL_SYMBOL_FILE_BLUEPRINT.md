---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Symbol File Blueprint

Each Market Watch symbol gets a folder and a current machine-readable file.

## Runtime Output Layout

```text
ARL_Output/
  Current/
    Account_Current.json
    MarketBoard_Current.txt
    MarketBoard_Current.json
    Status_Current.json
    Manifest_Current.json

  Symbols/
    EURUSD/
      Symbol_Current.json
      Dossier_Current.txt
      Rolling_Metrics.json

  Buckets/
    Major_FOREX_Current.json
    Minor_FOREX_EXOTICS_Current.json

  History/
    MarketBoard/
    Account/
    Symbols/

  Logs/
    ErrorLedger_Current.txt
    FunctionResults_Current.txt
```

## Symbol Current Required Fields

```text
symbol
canonical_symbol
exact_broker_symbol
major_bucket
minor_bucket
market_state
broker_specs
surface_ranking
bucket_ranking
deep_review_status
account_exposure
missing_data_summary
last_updated_utc
source_snapshot_ids
schema_version
```

## All-Symbol Folder Rule

During warmup, ARL must create/update a folder for every selected Market Watch symbol.

A symbol folder can exist with:

```text
symbol_status=NOT_READY
reason=waiting_market_state
```

But it must not silently vanish.

## ARL-RUN007 Symbol File Separation

Per-symbol output must split readable trader review from machine truth:

- `Symbol_Current.json` owns structured symbol truth and full arrays.
- `Symbol_Trader_Pack.txt` owns readable per-symbol trader data.
- `Symbol_Dossier.txt` owns selected-symbol narrative review.
- `Manifest_Current.json` owns source/publication/readback proof.
- `Debug_Current.json` owns verbose diagnostics and route details.

Text files show the first two recent closed bars and first two recent closed trades only. Full arrays belong in JSON.
