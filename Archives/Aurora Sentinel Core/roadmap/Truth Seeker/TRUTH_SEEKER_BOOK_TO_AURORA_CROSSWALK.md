# Truth Seeker Book-to-Aurora Crosswalk

**Created:** 2026-04-26  
**Purpose:** Mandatory audit table that maps book/library/research concepts to actual Aurora implementation evidence.

## Root Law

Future workers must not say `missing` until they searched the current uploaded Aurora EA zip/source. They must not say `implemented` until they identify file/function/card/log proof.

## Aurora Status Classification

| Code | Status | Meaning |
|---|---|---|
| A | `IMPLEMENTED_CORRECTLY` | Concept exists, is measurable, in the correct layer, logged, and not misleading. |
| B | `PARTIAL_WEAK_EXTRACTION` | Concept exists but lacks formula clarity, support flags, conflict logic, horizon, logging, or validation. |
| C | `MISPLACED` | Concept exists but sits in the wrong layer or wrong owner file. |
| D | `LABEL_ONLY_FLUFF` | Wording exists without measurable evidence. |
| E | `DUPLICATED_CONFLICTING` | Same idea appears under conflicting names or meanings. |
| F | `MISSING_STRATEGY_CARD` | Concept exists in source or notes but no formal method/strategy card exists. |
| G | `MISSING_FROM_AURORA` | Useful concept is not represented in Aurora. |
| H | `REJECT_NOT_MT5_SAFE` | Unsupported by MT5 data, too heavy, vague, discretionary, overfit-prone, or unsuitable. |
| I | `FUTURE_TEST_CANDIDATE` | Potentially useful but requires dataset/logging/outcome validation first. |

## Required Crosswalk Table

Every book/research extraction run must update a table with these columns:

| Source / Book | Concept | Strategy family | Aurora current file/function/card | Current extraction status | Layer fit | MT5 data required | Scalp/intraday/swing fit | Regime/session fit | Missing formula? | Missing logging? | Missing contradiction handling? | Missing outcome label? | False-confidence risk | Roadmap phase | Future action | Acceptance criteria | Reject condition |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Example placeholder | Example concept | Example family | Not audited yet | `FUTURE_TEST_CANDIDATE` | L5/L6 candidate | OHLC/spread/log history | scalp/intraday TBD | TBD | yes | yes | yes | yes | pattern worship | PHASE X | build card only after source audit | measurable rule + logs | cannot define rule |

## Required Aurora EA Zip Inspection Areas

Future workers must inspect the current uploaded Aurora EA zip/source for these areas where present:

- `mt5/candidate_filtering/`
- `mt5/shortlist_selection/`
- `mt5/deep_selective_analysis/`
- `mt5/artifacts/`
- `mt5/artifacts/dossier/`
- `mt5/logging/`
- `mt5/runtime/`
- `mt5/core/`
- `mt5/hud/` as display consumer only
- `mt5/io/`
- `mt5/semi_auto_trading/`
- strategy cards and indicator-setting files
- Aurora source/index files
- blueprint/final docs defining strategy or scoring
- book extraction ledgers and source-set manifests

If the uploaded reference zip has documentation but no MT5 source files, state that clearly and map only to the available docs/cards/ledgers. Do not invent file/function proof.

## Crosswalk Workflow

1. Identify source family and concept.
2. Check whether the book/source was actually uploaded or title-only.
3. Search the Aurora EA zip for existing ledgers, module maps, family cards, strategy cards, labels, files, functions, logs, and output fields.
4. Classify current status A–I.
5. Decide card action: create, update, merge duplicate, downgrade, reject, or defer.
6. Map MT5 data availability and intended layer.
7. Define logging/outcome labels and validation path.
8. Update Method Extraction Ledger.
9. Add acceptance/rejection criteria.
10. Declare no execution/full-auto changes.
