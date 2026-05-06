## 2026-04-25 — Doc 15 FileIO owner-boundary note

`mt5/io/ASC_FileIO.mqh` owns atomic file write/readback/promotion reason text. It may report required-token/readback/equality contract satisfaction, but it must not imply calibration, trading-edge validation, or roadmap closure. Doc 15 Run 1 changed success wording to `readback_token_contract_satisfied` while preserving function signatures, required-token checks, path helpers, promotion mechanics, and caller contracts.

# File Owner and Edit Boundaries

## Purpose

This file maps owner files for the active roadmap family.
It is corrected by the 2026-04-23 roadmap truth pass.

## Runtime boundary

The active runtime model stops at Layer 6.
Docs 13–18 are roadmap / control docs only.
Any source wording that implies a runtime layer after Layer 6 is invalid active-model wording and should be treated as a cleanup target when the touched owner chain justifies it.

## Layer owners

### Layer 3 likely owners

- `mt5/candidate_filtering/ASC_SelectionFilter.mqh`

### Layer 4 likely owners

- `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh`
- `mt5/shortlist_selection/ASC_CorrelationSummaryEngine.mqh`
- `mt5/shortlist_selection/ASC_LiquidityFrictionSummaryEngine.mqh`
- `mt5/shortlist_selection/ASC_RegimeSummaryEngine.mqh`
- `mt5/shortlist_selection/ASC_ATRSummaryEngine.mqh`

### Layer 5 likely owners

- `mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh`

### Layer 6 likely owners

- `mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `mt5/artifacts/dossier/operator_snapshot/ASC_DossierOperatorSnapshotSection.mqh`
- `mt5/artifacts/dossier/trader_context/ASC_DossierTraderContextSection.mqh`
- `mt5/artifacts/dossier/deep_selective_analysis/ASC_DossierDeepAnalystSIAMHandoffSection.mqh`
- `mt5/artifacts/dossier/recent_change_trace/ASC_DossierRecentChangeTraceSection.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`

## Protected surfaces

- `mt5/artifacts/ASC_MarketBoardWriter.mqh` remains upstream board authority and must not be demoted into a support consumer path.
- `mt5/hud/ASC_HUD_Manager.mqh` remains consumer-only unless a lane explicitly proves otherwise.

## Edit discipline rule

Read the true owner first.
Do not fan out across nearby files just because they look related.
Only expand the read/edit set when the current owner chain proves a dependency.

## Doc 14 edit-quality hardening — 2026-04-25

Future workers must identify the exact owner chain before editing.
The minimum owner trace for a source patch is:

1. current compile-path file being edited;
2. direct caller or composer/dispatcher path that uses it;
3. include or dependency that could break compile;
4. required-token, validation, path-helper, or version file affected by the edit;
5. live artifact/log evidence needed to prove it.

Office/control patches must identify the doc section being changed and the status files that must mirror it.
Archive files and historical roadmap copies remain evidence only; they are never edited as current authority unless the active pass is explicitly an archive-maintenance pass.

Doc 14 also forbids broad fan-out edits during proof-protocol work.
If the seam is audit/test discipline, the normal owner chain is office/control first; compile-path source is touched only when a real proof/reporting helper seam is proven.
