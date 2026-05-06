# Truth Seeker Strategy Card Schema

**Created:** 2026-04-26  
**Purpose:** Mandatory schema for every future strategy, method, label, or research candidate admitted into the Truth Seeker roadmap.

## Root Law

No strategy or operator-facing strategy label is accepted without a card. No card is accepted without MT5 data fit, layer fit, contradiction handling, logging, validation, acceptance criteria, and rejection criteria.

A card may be `advisory only`, `paper-review candidate`, `future semi-auto candidate`, or `full-auto locked`. Current roadmap default is **advisory only / full-auto locked**.

## Required Card Fields

| # | Field | Required content |
|---:|---|---|
| 1 | Card ID | Stable unique ID. |
| 2 | Strategy/method name | Human-readable name. |
| 3 | Source family | Book source, academic paper/source, practitioner source, Aurora existing file/function. |
| 4 | Source confidence | `strong academic`, `practitioner strong`, `useful but unproven`, `weak inspiration`, `reject`. |
| 5 | Trade horizon fit | `scalp`, `intraday`, `restricted swing`, `multi-horizon`, `not suitable`. |
| 6 | Regime fit | expansion trend, compression, range/rotation, breakout attempt, breakout failure, trend pullback, exhaustion/overextension, illiquid/dirty, news shock/disorder, transition/mixed. |
| 7 | Session fit | Asia, London, New York, London/New York overlap, pre-session, session open, session body, late session, rollover, Friday risk. |
| 8 | MT5 data required | current tick, tick history, OHLC, spread, symbol properties, sessions, swap/margin, indicator handle, file/log history, external data required. |
| 9 | Layer ownership | L3 cheap proxy, L4 ranking contribution, L5 selective deep calculation, L6 interpretation, logging only, reject. |
| 10 | Formula / rule definition | Exact measurable rule, formula, threshold family, or “not measurable yet”. |
| 11 | Input support flags | Which inputs are present, stale, unavailable, proxy, conflicting, or external. |
| 12 | Unavailable-data behavior | downgrade, hide, log-only, defer, reject, or dependency-blocked. |
| 13 | False-confidence risks | Where the method can lie, overfit, double count, or look cleaner than reality. |
| 14 | Contradiction conditions | Conflicts with regime/session/friction/volatility/geometry/other strategies. |
| 15 | Ranking use | Whether it influences rank, explains rank, penalizes rank, or is log-only. |
| 16 | Strategy-label use | Exact labels allowed, downgraded, removed, or forbidden. |
| 17 | Geometry requirements | Invalidation, room, spread-to-room, structure distance, time-to-invalidity, no-chase rules. |
| 18 | Logging requirements | Feature logs, rank reason logs, contradiction logs, hydration/availability logs. |
| 19 | Outcome labels needed | MFE/MAE, expiry result, false confidence, missed opportunity, conflict quality, top-rank usefulness. |
| 20 | Validation method | backtest, walk-forward, forward review, live-output comparison, paper review. |
| 21 | Anti-overfitting safeguards | OOS split, walk-forward, purging/embargo where relevant, parameter stability, regime/session segmentation. |
| 22 | Prop-firm constraints | drawdown, news/rollover, weekend, max-hold, risk-of-ruin, copy/execution latency notes. |
| 23 | Full-auto status | advisory only, paper-review candidate, future semi-auto candidate, full-auto locked. |
| 24 | Current Aurora implementation status | Implemented correctly, partial, misplaced, label-only, duplicate, missing card, missing from Aurora, reject, future-test candidate. |
| 25 | Existing files/functions touched later | Exact Aurora files/functions/cards/logs, or `not found yet`. |
| 26 | Acceptance criteria | Measurable condition for accepting the card/method. |
| 27 | Rejection criteria | Exact condition that kills or downgrades it. |
| 28 | Notes / unresolved risks | Open uncertainties and next discriminating test. |

## Strategy Label Completion Requirement

Audit all operator-facing labels, including but not limited to:

`scalp-clean`, `tradable`, `opportunity`, `continuation`, `pullback`, `breakout`, `reversal`, `fakeout`, `reclaim`, `range rotation`, `compression`, `expansion`, `trend`, `momentum`, `mean reversion`, `value reversion`, `overextension`, `exhaustion`, `volatility opportunity`, `high confidence`, `primary read`, `primary opportunity`, `primary risk`, `next check`, `SIAM fit`, `flow`, `wave`, `pressure`, `style`, `effect`.

For each label, future workers must find source support, Aurora formula/evidence, layer owner, MT5 data fit, horizon/regime/session/geometry/conflict requirements, logging/outcome labels, acceptance criteria, and rejection criteria.

A label without a valid card becomes one of:

- `DOWNGRADED_TO_REVIEW_ONLY`
- `LOG_ONLY`
- `HIDDEN_UNTIL_VALIDATED`
- `MERGED_AS_DUPLICATE`
- `REJECTED_AS_FLUFF`

## Card Statuses

| Status | Meaning |
|---|---|
| `CARD_DRAFT` | Concept identified, not accepted. |
| `CARD_READY_FOR_CROSSWALK` | Source definition is clear enough to map to Aurora. |
| `CARD_READY_FOR_VALIDATION` | MT5 data/layer/logging/contradiction plan exists. |
| `CARD_ACCEPTED_ADVISORY_ONLY` | May appear as advisory/review support, not execution. |
| `CARD_REJECTED` | Fails data, evidence, layer, risk, or validation requirements. |
| `CARD_MERGED_DUPLICATE` | Duplicates another card and must not create label bloat. |
| `CARD_FULL_AUTO_LOCKED` | Any future execution usage is locked behind a separate roadmap. |
