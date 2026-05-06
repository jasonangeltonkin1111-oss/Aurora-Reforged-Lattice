# Truth Seeker Method Extraction Ledger

**Created:** 2026-04-26  
**Purpose:** Tracks every extracted, partial, missing, duplicated, rejected, and future-test method from books, research, and Aurora-internal evidence.

## Ledger Statuses

| Status | Meaning |
|---|---|
| `EXTRACTED_AND_VALIDATED` | Method has card, Aurora evidence, logs, outcome review, and validation proof. |
| `EXTRACTED_NOT_VALIDATED` | Method has card/evidence but lacks sufficient outcome validation. |
| `PARTIAL_EXTRACTION` | Concept exists but misses formula, layer fit, logging, conflict handling, horizon, or validation. |
| `LABEL_ONLY` | Label/wording exists without measurable rule/evidence. |
| `DUPLICATE` | Same method already exists under a stronger canonical name. |
| `CONTRADICTS_EXISTING_METHOD` | Concept conflicts with an existing method and needs discriminating test or rejection. |
| `MISSING_CARD` | Concept/label exists but no strategy/method card exists. |
| `RESEARCH_MORE` | Source understanding is insufficient. |
| `MT5_DATA_BLOCKED` | Required data is unavailable or not trustworthy in MT5. |
| `TOO_HEAVY_FOR_LAYER` | Method may be valid only at L5/L6/deep, not broad L3/L4. |
| `REJECTED` | Fails evidence, data, risk, or roadmap boundary. |
| `FUTURE_TEST_CANDIDATE` | Worth testing after logging/dataset/outcome support exists. |

## Movement Law

No method may move from idea to implementation without:

- method card
- source family and source confidence
- Aurora EA crosswalk row
- MT5 data check
- layer-fit decision
- logging plan
- contradiction plan
- validation plan
- acceptance criteria
- rejection criteria
- no-full-auto status

## Required Ledger Table

| Method ID | Method / label | Source family | Source item | Crosswalk status | Ledger status | Aurora proof location | Missing card? | MT5 data fit | Layer fit | Logging need | Outcome labels | Validation path | Duplicate/conflict | Next action | Acceptance criteria | Rejection criteria | Full-auto status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| TS-METHOD-000 | Placeholder | TBD | TBD | I | `FUTURE_TEST_CANDIDATE` | Not audited yet | yes | TBD | TBD | yes | yes | paper/forward review | TBD | build card after source audit | measurable + loggable | no measurable rule | full-auto locked |

## Duplicate Handling

If two labels express the same idea, future workers must choose a canonical label/card and mark the weaker one `DUPLICATE` or `MERGED_AS_DUPLICATE`. Do not let Aurora gain fake intelligence by multiplying synonyms.

## Rejection Handling

Rejected methods stay in the ledger. Rejection is useful training data for AI Forex GPT because it prevents repeated indicator shopping, repeated book-authority claims, and repeated discretionary labels.
