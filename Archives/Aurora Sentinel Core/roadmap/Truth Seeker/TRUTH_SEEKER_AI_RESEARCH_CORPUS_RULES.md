# Truth Seeker AI Research Corpus Rules

**Created:** 2026-04-26  
**Purpose:** Defines how source-library concepts, Aurora logs, strategy cards, research, and future AI Forex GPT datasets connect safely.

## Advisory-Only Boundary

AI Forex GPT may explain, compare, summarize, classify, calibrate language, and suggest research candidates. It may not place trades, size positions, set stops/targets, close trades, manage positions, bypass operator confirmation, or create hidden execution paths.

## Corpus Components

Future AI corpus work may use:

- Source Library Index
- Strategy Card Schema and completed method cards
- Book-to-Aurora Crosswalk
- Method Extraction Ledger
- Aurora feature logs
- Dossier hydration logs
- rank reason logs
- contradiction logs
- strategy outcome labels
- market regime/session context
- forward-review notes
- rejected-method ledger
- operator annotations
- paper-review and live-output comparison notes

## Corpus Contamination Risks

| Risk | Required control |
|---|---|
| Book-as-proof contamination | Store source confidence separately from Aurora validation. |
| Screenshot-only false certainty | Mark source as title-only until uploaded/read. |
| Duplicate labels | Link to canonical method card. |
| Fluff labels | Mark log-only, review-only, hidden, or rejected. |
| Overfit features | Require OOS/walk-forward/forward-review fields. |
| MT5 proxy confusion | Mark true data vs broker-derived/proxy/external. |
| Black-box confidence | Require feature/version/calibration/explanation. |
| Full-auto creep | Keep execution fields locked and advisory-only. |

## AI-Ready Record Minimum

An AI-training/review record is not eligible unless it has:

1. symbol and timestamp
2. broker/server/source context
3. horizon/regime/session
4. features with names and availability flags
5. rank reasons and penalties
6. contradiction flags
7. strategy card IDs considered
8. method status from ledger
9. Dossier/Current Focus/Market Board references where available
10. outcome labels after expiry/review
11. rejection/uncertainty notes
12. operator annotation if available
13. no-execution/no-full-auto status

## Research-to-AI Pipeline

1. Source concept enters Source Library Index.
2. Concept gets crosswalk row against current Aurora EA zip/source.
3. Concept gets method/strategy card or rejection.
4. Method gets ledger status.
5. Logging/outcome fields are defined.
6. Forward review proves whether the card helps or lies.
7. AI can summarize and compare only after the record is explicit.
8. AI confidence remains advisory unless a future separate autonomy roadmap unlocks stricter levels.

## Language Rules

Allowed:

- `academically supported candidate`
- `research-backed test lane`
- `practitioner-inspired candidate`
- `Aurora-log validated`
- `advisory confidence`
- `paper-review candidate`

Forbidden unless Aurora logs actually prove it:

- `proven strategy`
- `guaranteed edge`
- `AI decides`
- `full-auto ready`
- `confirmed profitable`
- `order-flow confirmed` when only MT5 proxy data exists
