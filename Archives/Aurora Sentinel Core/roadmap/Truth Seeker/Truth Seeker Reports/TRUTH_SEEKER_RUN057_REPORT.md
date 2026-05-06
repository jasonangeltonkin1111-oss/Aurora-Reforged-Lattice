# TRUTH SEEKER RUN057 REPORT — Formula and Metric Source-of-Truth Freshness Repair

## Decision
SOURCE PATCH LANDED / LIVE PROOF HELD TO RUN060.

## What failed
RUN057 verified RUN056 source-side cross-artifact boundaries, then found that L3/L4/L5 metric proof still exposed meaning/no-trade/no-entry tokens, but not a complete compact metric source-of-truth map. Edge-relevant scores and summaries could still be read as clean without owner, input source, freshness, sample/timeframe/tick-window, validity, falsifier, and artifact projection tokens.

## What was patched
- L3 candidate proof now emits compact metric-domain/purpose/owner/input/freshness/sample/validity/falsifier/projection tokens through `ASC_SelectionFilterProofToken`.
- L4 shortlist proof now emits compact metric-domain/purpose/owner/input/freshness/sample/timeframe/validity/falsifier/projection tokens through `ASC_ShortlistMetricProofToken`, and preserves ATR summary support tokens without changing shortlist formulas.
- ATR summary now exposes support-token helpers for sample/freshness/validity/falsifier using its existing CopyRates + day-range fallback contract.
- L5 deep support tokens now include metric domain, purpose, owner, input source, tick-window status, validity status, and falsifier while preserving RUN055 support posture tokens.
- Dispatcher aggregate FunctionResults rows now include compact L3/L4 metric proof tokens without per-symbol proof spam.
- Version and roadmap controls now identify RUN057 as source-only.

## Files changed
- mt5/candidate_filtering/ASC_SelectionFilter.mqh
- mt5/shortlist_selection/ASC_ATRSummaryEngine.mqh
- mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh
- mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh
- mt5/runtime/ASC_Dispatcher.mqh
- mt5/core/ASC_Version.mqh
- roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md
- roadmap/Truth Seeker/TRUTH_SEEKER_RUN057_REPORT.md

## Proof status
- Compile: not run; no MetaEditor output supplied.
- Live: not run; RUN060 remains the next live checkpoint.
- Runtime: not run; no fresh post-patch MT5 output supplied.
- Source: patched and static-balanced for braces/quotes in changed files.

## Regression guard
RUN057 changed no score formula, rank formula, top-list selection, Market Board selection/order, HUD, Dossier semantic model, Current Focus semantic model, FileIO, refresh cadence, strategy, indicator, or heavy metric recalculation loop.

## Remaining proof gap
Source-only patch. MetaEditor compile, live MT5 runtime output, post-patch FunctionResults rows, and artifact projection proof remain unproven until RUN060.

## NEXT_RUN
RUN058 can be authorized only for performance/cadence/stale-output hardening if the roadmap continues source hardening. RUN060 remains mandatory for fresh MetaEditor compile/live/output proof.
