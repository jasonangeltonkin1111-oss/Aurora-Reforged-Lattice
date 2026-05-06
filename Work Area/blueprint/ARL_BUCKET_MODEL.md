---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Bucket Model

Major/minor bucket means hierarchy, not instrument nickname.

## Major Bucket

A broad market class.

Examples:

- `FOREX`
- `CRYPTO`
- `METALS`
- `INDICES`
- `COMMODITIES`
- `STOCKS`
- `FUNDS`
- `RATES`
- `VOLATILITY`
- `UNKNOWN`

## Minor Bucket

A subgroup inside a major bucket.

Examples:

```text
FOREX
  FOREX_MAJORS
  FOREX_MINORS
  FOREX_EXOTICS
  FOREX_CROSSES

CRYPTO
  CRYPTO_MAJOR_COINS
  CRYPTO_ALTCOINS
  CRYPTO_CROSSES

METALS
  METALS_GOLD_SILVER
  METALS_PRECIOUS
  METALS_OTHER

INDICES
  INDICES_US
  INDICES_EU
  INDICES_ASIA
  INDICES_GLOBAL

COMMODITIES
  COMMODITIES_ENERGY
  COMMODITIES_AGRICULTURE
  COMMODITIES_SOFTS

STOCKS
  STOCKS_US
  STOCKS_EU
  STOCKS_TECH
  STOCKS_BANKS
  STOCKS_ENERGY
  STOCKS_HEALTHCARE
```

## Bucket Fields

Every symbol must expose:

```text
major_bucket=
minor_bucket=
bucket_confidence_score=
bucket_source=
bucket_reason=
bucket_resolution_status=
```

## Unknown Policy

If classification cannot be resolved:

```text
major_bucket=UNKNOWN
minor_bucket=UNKNOWN
bucket_confidence_score=0.00
bucket_reason=classification_unresolved
```

Unknown symbols may be listed in diagnostics, but they cannot silently enter ranked groups as if classification were clean.
