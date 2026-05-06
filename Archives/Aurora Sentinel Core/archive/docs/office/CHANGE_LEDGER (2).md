## 2026-04-25 — DOC 16 FINAL / run-structure transition + source-visible closeout boundary

Changed:
- `mt5/core/ASC_Version.mqh`
  - version bumped to `Stage2-Doc16-Final-BacklogCloseout`.
  - added `ASC_ROADMAP_RUN_STRUCTURE`.
  - added `ASC_ROADMAP_FINAL_LIVE_TEST_DOC`.
  - added `ASC_ROADMAP_DOC16_CLOSEOUT_BOUNDARY`.
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/16_EXEC_BACK.md`
  - replaced stale Doc 16 Run 3/Run 4 obligations with the operator-approved two-run structure and Doc 18 final integrated live-test deferral.
  - added final Doc 16 closeout run history and proof-hold carry-forward.
- `office/ROADMAP_STATUS.md` and `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`
  - recorded Doc 16 closure, new two-run doctrine, Doc 18 final live-test deferral, Doc 17 next, and proof-holds.
- `office/DECISIONS.md`, `office/WORK_LOG.md`, `office/CHANGE_LEDGER.md`, `office/OFFICE_CANON.md`
  - recorded source/control closure decision, proof limits, protected non-edits, and run-structure transition.
- Roadmap protocol docs 01/04/14/15 were given supersession notes where directly affected by old run/live-test expectations.

Not changed:
- No ranking, L3/L4 scoring, L5/L6 deep analysis, ordinary dossier hydration, write-lane mechanics, HUD, Top10 mechanics, classification, FileIO behavior, trade logic, broad dispatcher scheduling, archive authority, staging/promote/archive meaning, or Doc 17 implementation work.

Proof status:
- Static inspection only; MetaEditor compile and MT5 live runtime were not run.
- No validation, calibration, trading-edge proof, or final integrated closure proof claimed.

Verdict:
- DOC 16 CLOSED WITH PROOF-HOLD CARRIED. DOC 17 MAY START.

## 2026-04-25 — DOC 16 RUN 2 / backlog dependency hardening patch

Files changed:
- `mt5/core/ASC_Version.mqh`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/16_EXEC_BACK.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`

Source changes:
- Bumped version label to `Stage2-Doc16-Run2-BacklogDependencyHardening`.
- Added `ASC_ROADMAP_DOC16_CLOSURE_BLOCKER`.
- Added `ASC_ROADMAP_DOC16_PROOF_BOUNDARY`.

Doc/control changes:
- Added explicit B1–B11 dependency/closure matrix to actual Doc 16.
- Recorded Run 2 internet research basis, Run 1 correctness, bounded seam patched, protected non-edits, proof-hold carry-forward, and Run 3/Run 4 burdens.

No behavior changes:
- No ranking, HUD, Top10 mechanics, deep analysis, dossier hydration, write-lane behavior, FileIO behavior, classification, trade logic, or dispatcher scheduling changed.

Proof posture:
- Static inspection only; no MetaEditor compile and no live MT5 proof claimed.

## 2026-04-25 — DOC 16 RUN 1 / Execution Backlog authority patch

Changed files:
- `mt5/core/ASC_Version.mqh`
- `office/OFFICE_CANON.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/00_READ_ME_FIRS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/16_EXEC_BACK.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`

Source delta:
- `ASC_VERSION_LABEL` changed from `Stage2-Doc15-Run4-Top10CadencePolish` to `Stage2-Doc16-Run1-ExecutionBacklogAuthority`.
- Added source-visible Doc 16 authority constants for file, title, and scope.

Office/control delta:
- Recorded Doc 16 Run 1 start/completion, actual Doc 16 file read, Doc 15 proof-hold carry-forward, source seam, protected non-edits, and Run 2/3/4 burdens.
- Corrected Doc 16 filename authority from longer alias wording to the actual file present in this source pack: `16_EXEC_BACK.md`.

Not changed:
- No ranking formulas, L3/L4 scoring, L5/L6 deep analysis, ordinary dossier hydration, write-lane throughput mechanics, HUD layout/performance, Top10 count/ranking/diversification/stage/promote/archive lifecycle, classification, trade logic, broad dispatcher scheduling, or FileIO mechanics.

Proof status:
- Static source inspection only.
- MetaEditor compile not run.
- No live runtime proof claimed.

## 2026-04-25 — DOC 15 RUN 4 / GlobalTop10 5-minute cadence polish

Changed files:
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_Version.mqh`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/15_CALI_VALI_AND_CLOS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/10_LAYE_EXEC_ADJU_RANK_AND_DIVE.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/12_LAYE_SUPP_COMP_CONT_AND_CHAN.md`

Source delta:
- `ASC_TOP10_RUN_FULL_CADENCE_SEC` changed from `600` to `300` seconds.
- Top10 cadence reason text now reports 5-minute cadence.
- Version bumped to `Stage2-Doc15-Run4-Top10CadencePolish`.

Not changed:
- L4 shortlist/board authority cadence remains 600 seconds.
- No Top10 count, ranking, diversification, stage/promote/archive lifecycle, archive retention, HUD layout, deep path, classification, trade logic, or write-lane redesign changed.

Proof status:
- Static source inspection only.
- MetaEditor compile not run.
- No live runtime proof or calibration/validation proof claimed.
- Doc 15 closed with proof-hold disclosed; next pass may begin only while carrying compile/log/live proof requirements forward.

## 2026-04-25 — DOC 15 RUN 1 / validation wording boundary source change

Changed:
- `mt5/io/ASC_FileIO.mqh`
  - `ASC_ReadAndValidatePayload()` now reports success as `readback_token_contract_satisfied` instead of `validated`.
  - `ASC_ReadAndValidatePayloadAgainstExpected()` now reports success as `readback_token_contract_satisfied` instead of `validated`.
  - Single-artifact promote success reason now says `reason=temp write readback_token_contract_satisfied and promoted`.
  - Pair-artifact promote success reason now says `reason=pair publish readback_token_contract_satisfied and promoted`.
- `mt5/core/ASC_Version.mqh`
  - `ASC_VERSION_LABEL` bumped to `Stage2-Doc15-Run1-ValidationBoundary`.
- Office/control files updated to record Doc 15 Run 1 source seam, boundary improvement, no-live/no-compile posture, and next-run proof burden.

Not changed:
- No artifact ownership, ranking, scoring, deep analysis, HUD, GlobalTop10 mechanics, publication mechanics, path helpers, required-token contracts, or scheduler behavior.

Proof status:
- Static source inspection only.
- MetaEditor compile not run.
- No live runtime proof, calibration proof, validation proof, or closure proof claimed.

## 2026-04-25 — DOC 14 RUN 4 / final manifest proof-line polish

Changed files:
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_Version.mqh`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/14_BATC_TEST_PROT_AND_CHEC.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`

Source files changed:
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_Version.mqh`

Runtime/source delta:
- Polished the Artifact Bundle Manifest proof-line wording only.
- `Proof Class Ledger:` now uses compact lower-case proof keys and avoids the old double-label pattern `Source-Level Landed=source_owner=...`.
- `Checkpoint Evidence:` now uses compact `board=`, `dossier=`, `manifest=`, `overall=`, and `hold_reason=` fields.
- `Evidence Boundary:` preserves the exact compile/calibration/run3 boundary tokens while shortening internal values.
- Required-token validation remains at 16 tokens and still requires `Proof Class Ledger:`, `Checkpoint Evidence:`, and `Evidence Boundary:`.

Version:
- Bumped from `Stage2-Doc14-Run2-ProofStandardHardening` to `Stage2-Doc14-Run4-ProofCloseoutPolish`.

Not changed:
- No ranking formulas, L3/L4 scoring, L5/L6 deep analysis, ordinary dossier hydration, write-lane throughput mechanics, HUD layout/performance, Top10 cadence/stage/promote/archive mechanics, classification engine, trade logic, or broad dispatcher scheduling changed.
- No runtime output files were edited as authority.

Proof / closeout:
- Run 3 live artifact proof remains the proof base for token presence and successful manifest publication.
- MetaEditor compile proof remains missing and is recorded as an external limitation.
- Doc 14 is closed with compile-hold disclosed; Doc 15 may start after this verdict.

## 2026-04-25 — DOC 14 RUN 3 / live proof office sync

Changed files:
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/14_BATC_TEST_PROT_AND_CHEC.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`

Source files changed:
- None.

Proof result:
- Fresh runtime `Artifact Bundle Manifest.txt` contained `Proof Class Ledger:`, `Checkpoint Evidence:`, and `Evidence Boundary:`.
- Manifest wording did not overclaim compile proof or calibration/validation proof.
- Manifest correctly held live proof as deferred while pending dossiers/manifest state remained visible.
- Required-token validation is live-supported by successful manifest publish logs with temp write validated/promoted and no manifest publication errors.

Not changed:
- Ranking formulas, L3/L4 scoring, L5/L6 deep analysis, ordinary dossier hydration, write-lane throughput mechanics, HUD layout/performance, Top10 cadence/stage/promote/archive mechanics, classification, trade logic, and broad dispatcher scheduling.

Version:
- No source version bump. Source remains `Stage2-Doc14-Run2-ProofStandardHardening` because Run 3 changed only office/control truth.

Next:
- Doc 14 Run 4 should polish/close using this Run 3 evidence by default, but compile closure still requires MetaEditor compile evidence if strict Run 3 proof is demanded.
## 2026-04-25 — DOC 13 RUN 2 / surface-truth hardening + provenance vocabulary

### Changed files
- `mt5/artifacts/ASC_ArtifactTextHelpers.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_Version.mqh`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/13_OPER_ARTI_ALIG_AND_SURF_TRUT.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`

### Runtime/source delta
- RUN 1 surface-truth helper wording was hardened from generic freshness wording into explicit surface-role wording.
- `stale`, `continuity`, and `preserved` now say retained/last-good/prior-current and explicitly deny fresh-current authority.
- Added shared provenance wording for generated-at, promoted/current, source-owner, and non-authority family roles.
- Market Board, Dossier integrity notes, and GlobalTop10 manifests now carry the shared provenance line.

### Not changed
- No ordinary dossier hydration repair.
- No write-frequency or heartbeat change.
- No ranking-engine change.
- No support-surface ownership change.
- No live proof or final closeout claim.

## 2026-04-25 — DOC 13 RUN 1 / surface-truth wording contract

### Changed files
- `mt5/artifacts/ASC_ArtifactTextHelpers.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_Version.mqh`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/13_OPER_ARTI_ALIG_AND_SURF_TRUT.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`

### Runtime/source delta
- Added a shared surface-truth helper that separates artifact freshness state from command/support authority.
- Added a shared family-role meaning line for `current`, `preserved`, `staging`, and `archive`.
- Market Board now prints the surface-truth line immediately after Board State.
- Dossier publication integrity now carries the same surface-truth readback in its integrity notes.
- GlobalTop10 family manifests now explain current/preserved/staging/archive role meaning.

### Not changed
- No ranking-engine rewrite.
- No HUD redesign.
- No GlobalTop10 product redesign.
- No Market Board ownership change.
- No Dossier / Current Focus ownership change.
- No archive/cadence scheduler change.
- No live proof claimed.

﻿## 2026-04-25 — Top10 Snapshot / Cadence RUN 2 internet hardening

### Changed files
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_Version.mqh`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/10_LAYE_EXEC_ADJU_RANK_AND_DIVE.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/12_LAYE_SUPP_COMP_CONT_AND_CHAN.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`

### Runtime delta
- Factored GlobalTop10 child verification into reusable payload/path/directory helpers.
- Replaced partial archive-slot skip behavior with complete-slot validation and partial-slot promotion blocking.
- Added prior live-family validation before archive copy.
- Added archive-family readback verification and archive manifest publication.
- Added staging manifest publication before promote.
- Added live-family readback verification and current-family manifest publication before stale prior children are removed.
- Preserved RUN 1 cadence and staging intent; no broad HUD/Top10 redesign.

### Not claimed
- No live archive success.
- No live 10-minute cadence stability proof.
- No live preservation proof.
- No live staging/promote proof.

﻿## 2026-04-23 — Doc 09 + Doc 10 + Doc 12 convergence RUN 3 / GlobalTop10 staging + archive + promote repair

### Runtime / source edits
- updated `mt5/io/ASC_FileIO.mqh`
- updated `mt5/runtime/ASC_Dispatcher.mqh`
- updated `mt5/core/ASC_Version.mqh`

### Office / roadmap edits
- updated `office/ROADMAP_STATUS.md`
- updated `office/WORK_LOG.md`
- updated `office/CHANGE_LEDGER.md`
- updated `office/DECISIONS.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/09_LAYE_EARL_EMER_TRAD_LIFT_AND.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/10_LAYE_EXEC_ADJU_RANK_AND_DIVE.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/12_LAYE_SUPP_COMP_CONT_AND_CHAN.md`

### Exact change record
- GlobalTop10 batch artifact path now targets a staging family instead of the live child family
- added archive publication from prior committed live family into the 10-minute archive slot
- added family-level staging promotion into live after successful verification
- blocked destructive replacement if promotion/archive cannot be completed lawfully
- diagnostics now show live/staging/archive directories explicitly
- version label advanced to the RUN 3 source-fix state

## 2026-04-23 — Doc 09 + Doc 10 + Doc 12 convergence RUN 2 / internet hardening + Top10 archive design-hardening

### Runtime / source edits
- updated `mt5/candidate_filtering/ASC_SelectionFilter.mqh`
- updated `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh`
- updated `mt5/runtime/ASC_Dispatcher.mqh`
- updated `mt5/core/ASC_Version.mqh`

### Office / roadmap edits
- updated `office/ROADMAP_STATUS.md`
- updated `office/WORK_LOG.md`
- updated `office/CHANGE_LEDGER.md`
- updated `office/DECISIONS.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/09_LAYE_EARL_EMER_TRAD_LIFT_AND.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/10_LAYE_EXEC_ADJU_RANK_AND_DIVE.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/12_LAYE_SUPP_COMP_CONT_AND_CHAN.md`

### Exact change record
- Doc 09: tightened RUN 1 `building` carry posture so it no longer survives on improving shape alone; it now also requires stronger directional support plus acceptable friction/liquidity quality and lower execution-friction drag
- Doc 10: tightened RUN 1 execution-relief replacement so cleaner challengers must also demonstrate minimum execution-friction improvement and a minimum liquidity-quality floor before replacing an incumbent
- Doc 12: changed verification-critical manifest reserve behavior from permanent served-history triggers to bounded recent-service windows for Top10 and Current Focus proof lanes
- Top10 archive design-hardening: added compile-path helpers for archive root, 10-minute cadence slot, and design-target snapshot directory, and surfaced them in dispatcher diagnostics without activating live archive publication yet
- version label advanced to the combined RUN 2 internet-hardening state
- office truth now explicitly records that the combined lane respects the merged HUD H1/H2/H4/H5/H6 / PR #520 source baseline without reopening the HUD lane in this pass

### Why this was the right bounded move
RUN 2 is supposed to harden the method basis, not redo RUN 1 and not fake RUN 3. The research-supported contradictions were now narrow enough that one compile-path hardening seam per doc plus one archive-prep seam was the lawful move.

## 2026-04-23 — Doc 09 + Doc 10 + Doc 12 convergence RUN 1 / git-source convergence

### Runtime / source edits
- updated `mt5/candidate_filtering/ASC_SelectionFilter.mqh`
- updated `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh`
- updated `mt5/runtime/ASC_Dispatcher.mqh`
- updated `mt5/core/ASC_Version.mqh`

### Office / roadmap edits
- updated `office/ROADMAP_STATUS.md`
- updated `office/WORK_LOG.md`
- updated `office/CHANGE_LEDGER.md`
- updated `office/DECISIONS.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/09_LAYE_EARL_EMER_TRAD_LIFT_AND.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/10_LAYE_EXEC_ADJU_RANK_AND_DIVE.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/12_LAYE_SUPP_COMP_CONT_AND_CHAN.md`

### Exact change record
- Doc 09: added a bounded `building` carry posture escape for improving candidates that are not stale, not restricted, and not carrying dominant drag, so Layer 3 does not flatten every burst candidate into the same guarded posture
- Doc 10: extended the one-slot shortlist replacement gate with a bounded execution-relief branch so a cleaner execution challenger can replace a still-lawful incumbent when board advantage is real without reopening broad churn
- Doc 12: tightened manifest reserve logic so startup flood / backlog pressure no longer suppresses verification-critical manifest republishes when top-10/current-focus proof is already active
- left Market Board authority, dossier/current-focus consumer-only law, HUD product shape, and deep-path ownership unchanged
- bumped the version label to mark the combined RUN 1 convergence state

### Why this was the right bounded move
The runtime pack proved one remaining high-leverage seam in each active doc, and the recent commit chain showed the earlier passes had already solved the broader structural seams. The honest next step was one bounded patch per doc, not a fourth redesign cycle.

## 2026-04-23 — Doc 12 RUN 3 / compile-repair hold

### Runtime / source edits
- updated `mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- updated `mt5/core/ASC_Version.mqh`

### Office / roadmap edits
- updated `office/ROADMAP_STATUS.md`
- updated `office/WORK_LOG.md`
- updated `office/CHANGE_LEDGER.md`
- updated `office/DECISIONS.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/12_LAYE_SUPP_COMP_CONT_AND_CHAN.md`

### Exact change record
- removed the unresolved `ASC_L6_ALLOWED_STYLE_REVIEW_ONLY` compile dependency from the Layer 6 support-priority summary path
- replaced it with bounded `review` / `watch` posture detection from already-carried text fields
- added the missing `ASC_L6ReviewDeltaStateTransitionNote(...)` helper
- added the missing `ASC_L6ReviewDeltaDeepTransitionNote(...)` helper
- left dispatcher/runtime-state ownership and Market Board authority unchanged
- bumped the version label to mark the RUN 3 compile-repair-hold state

### Why this was the right bounded move
The supplied compiler output proved a narrow Doc 12 seam. Repairing that seam was mandatory before any honest live-closeout attempt. No broader rewrite was justified without fresh compile or runtime evidence.

## 2026-04-23 — Doc 12 RUN 2 / change-contest co-ordering tightening

### Runtime / source edits
- updated `mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- updated `mt5/core/ASC_Version.mqh`

### Office / roadmap edits
- updated `office/ROADMAP_STATUS.md`
- updated `office/WORK_LOG.md`
- updated `office/CHANGE_LEDGER.md`
- updated `office/DECISIONS.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/12_LAYE_SUPP_COMP_CONT_AND_CHAN.md`

### Exact change record
- moved Layer 6 review-delta derivation earlier so current-focus summary composition can consume latest-change truth directly
- added `Latest Meaningful Change` to the selected-symbol Layer 6 first-read summary block
- added `Still Contested Now` to the selected-symbol Layer 6 first-read summary block
- kept existing RUN 1 family-sync source repair unchanged; no new GlobalTop10 family-sync patch was admitted in RUN 2
- bumped version label to mark the RUN 2 source state

### Why this was the right bounded move
External decision-support and uncertainty-communication guidance favored a first-read summary that tells the operator what matters most, what changed, and what remains contested without forcing a multi-section mental merge. The chosen patch strengthens that exact ordering without stealing Market Board authority or inventing a second owner path.


## 2026-04-23 — Doc 12 RUN 4 / manifest-sync hardening hold

### Runtime / source edits
- updated `mt5/runtime/ASC_Dispatcher.mqh`
- updated `mt5/core/ASC_Version.mqh`

### Office / roadmap edits
- updated `office/ROADMAP_STATUS.md`
- updated `office/WORK_LOG.md`
- updated `office/CHANGE_LEDGER.md`
- updated `office/DECISIONS.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/12_LAYE_SUPP_COMP_CONT_AND_CHAN.md`

### Exact change record
- left the Run 3 compile-repair seam untouched; no new dossier-owner rewrite was admitted
- patched the GlobalTop10 batch-completion branch so it now sets `l1_publish_pending_manifest = true` and `write_dirty = true` after child-family completion
- preserved Market Board authority and selected-symbol support-only law
- bumped the version label to mark the RUN 4 manifest-sync hold

### Why this was the right bounded move
The supplied live evidence showed the runtime could complete child-family refresh and later selected-symbol proof, but the shipped manifest remained stuck at an earlier unproven snapshot. That is a bounded verification seam. Forcing a manifest republish at child-family batch completion is the smallest honest repair that addresses the contradiction without reopening solved ownership lanes.

## 2026-04-25 — TOP10 SNAPSHOT / CADENCE REPAIR — RUN 1

### Runtime / source edits
- updated `mt5/runtime/ASC_Dispatcher.mqh`
- updated `mt5/hud/ASC_HUD_Manager.mqh`
- updated `mt5/core/ASC_Version.mqh`

### Office / roadmap edits
- updated `office/ROADMAP_STATUS.md`
- updated `office/WORK_LOG.md`
- updated `office/CHANGE_LEDGER.md`
- updated `office/DECISIONS.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/10_LAYE_EXEC_ADJU_RANK_AND_DIVE.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/12_LAYE_SUPP_COMP_CONT_AND_CHAN.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`

### Exact change record
- previous archive behavior is recorded as not live-proven and not complete enough for family-level proof.
- previous cadence behavior is recorded as too loose because refresh admission could restart from source divergence/manual action without a hard 10-minute due law.
- RUN 1 adds dispatcher-owned 600-second cadence admission and keeps the live `Dossiers/GlobalTop10` family as the last confirmed complete family during staging.
- RUN 1 adds staging verification before archive/promotion and hardens archive copy success so partial/missing prior live children block promotion.
- RUN 1 changes HUD manual Run Full Top 10 to respect cadence rather than becoming hidden recompute spam.
- lifecycle logs now expose due/not-due, staging start/completion, archive eligibility, archive success/failure, promote success/failure, and live-family preservation.

### Not changed
- no Market Board authority rewrite.
- no dossier/current-focus ownership expansion.
- no broad HUD redesign.
- no broad Layer 3 / Layer 4 / Layer 6 redesign.

## 2026-04-25 — TOP10 SNAPSHOT / CADENCE REPAIR — RUN 3 HOLD

### Runtime / source edits
- none

### Office / roadmap edits
- updated `office/ROADMAP_STATUS.md`
- updated `office/WORK_LOG.md`
- updated `office/CHANGE_LEDGER.md`
- updated `office/DECISIONS.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/10_LAYE_EXEC_ADJU_RANK_AND_DIVE.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/12_LAYE_SUPP_COMP_CONT_AND_CHAN.md`

### Exact change record
- recorded that RUN 3 cannot honestly close from the uploaded package because the mandatory fresh live evidence pack is absent
- recorded that compile proof is not available in this environment and no MetaEditor compile log was supplied
- recorded that source inspection still shows Run 1 / Run 2 lifecycle wiring for cadence, staging, archive, manifests, and promotion
- recorded that no narrow runtime patch is admitted without fresh live contradiction

### Why this was the right bounded move
The lane requires live proof, not source optimism. The package supports a source/method status update only. Closing the lane without real archive files, manifests, logs, and HUD/Board/current/archive sync evidence would overclaim.

## 2026-04-25 — DOC 13 RUN 3 / Dossier explicit surface-line live-proof fix

Changed files:
- `mt5/artifacts/dossier/publication_integrity/ASC_DossierPublicationIntegritySection.mqh`
  - Added explicit `Surface Truth:` and `Surface Provenance:` publication-health lines.
  - Counted the two new fields in publication integrity population telemetry.
- `mt5/artifacts/dossier/ASC_DossierComposer.mqh`
  - Builds surface truth/provenance strings from shared Doc 13 helpers before composing publication health.
  - Requires `Surface Truth:` and `Surface Provenance:` tokens for non-closed Dossier payloads.
- `mt5/core/ASC_Version.mqh`
  - Version label bumped to `Stage2-Doc13-Run3-LiveProofFix`.
- Office status/log/decision files updated for honest RUN 3 proof state.

Reason:
- Live Market Board and GlobalTop10 manifests proved Run 2 surface/provenance visibility, but live root Dossier/Current Focus lacked explicit surface-line labels. The patch keeps existing integrity notes and adds unambiguous operator-visible lines.

Not changed:
- No ranking, scoring, Top10 cadence/archive mechanics, HUD rendering, write-lane throughput, dossier-law restoration, classification, or trade logic.

## 2026-04-25 — Doc 13 Run 4 root Dossier / Current Focus naming patch

- Source: `ASC_CURRENT_FOCUS_FILE` comment now states root `Dossier.txt` is the selected-symbol Current Focus surface and no separate `Current Focus.txt` is required.
- Source: `ASC_CurrentFocusContract()` artifact name now reports `Root Dossier / Current Focus`; protected readback source/reason strings now identify root Dossier / Current Focus.
- Source version bumped from `Stage2-Doc13-Run3-LiveProofFix` to `Stage2-Doc13-Run4-RootDossierFocusNaming`.
- Office: control docs now record the naming law and the honest Run 4 hold caused by missing MetaEditor/fresh runtime proof in this environment.
- Not changed: Market Board authority, dossier/deep composition, GlobalTop10 cadence/promote/archive mechanics, ranking formulas, HUD layout/performance, write-lane throughput, classification, or Doc 14 scope.

## 2026-04-25 — DOC 14 RUN 1 / proof protocol and batch checkpoint hardening

### Runtime / source edits
- none; no compile-path source change was admitted.

### Office / roadmap edits
- updated `office/OFFICE_CANON.md`
- updated `office/ROADMAP_STATUS.md`
- updated `office/WORK_LOG.md`
- updated `office/CHANGE_LEDGER.md`
- updated `office/DECISIONS.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/04_RUNT_PROO_AND_VALI_BASE.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/14_BATC_TEST_PROT_AND_CHEC.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/18_FILE_OWNE_AND_EDIT_BOUN.md`
- updated `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`

### Exact change record
- converted Doc 14 into the mandatory future-run audit/proof/checkpoint protocol.
- added explicit proof classes: source-landed, static-inspected, compile-proven, artifact-visible, runtime-proven, calibrated/validated, held/unproven.
- added the mandatory truth delta, proof class, dominant risk stack, evidence ledger, patch admission, batch-test checkpoint, performance side-check, and next-prompt intelligence blocks.
- added internet-run standards for Runs 2–4 without performing internet research in Run 1.
- added code-edit quality rules requiring real current files, owner-chain trace, call-site/include/validation/path/version inspection, and changed-files-only packaging.
- added batch testing doctrine defining when a batch may wait and when immediate compile/live proof is required.
- recorded Doc 13 as parked/proof-held, not reopened and not fully closed.

### Why this was the right bounded move
The highest-leverage Doc 14 seam was not runtime behavior; it was proof discipline. The patch strengthens future edit and proof decisions without touching ranking, board authority, dossier support law, Top10 mechanics, write-lane throughput, HUD behavior, deep analysis, classification, or dispatcher scheduling.

## 2026-04-25 — DOC 14 RUN 1 REDO

Changed:
- `mt5/runtime/ASC_Dispatcher.mqh`
  - Added `ASC_ManifestProofClassLedgerLine()`.
  - Added `ASC_ManifestCheckpointEvidenceLine()`.
  - Added `Proof Class Ledger:` and `Checkpoint Evidence:` lines to `ASC_WriteArtifactBundleManifest()`.
  - Added both new manifest lines to required-token validation so missing proof/checkpoint wording fails the manifest payload contract.
- `mt5/core/ASC_Version.mqh`
  - Bumped version to `Stage2-Doc14-Run1-ProofReporting`.
- Office/control files updated to record the Run 1 redo, prior office-only insufficiency, source seam, patch scope, proof limits, and next-run requirements.

Not changed:
- Ranking formulas, L3/L4 scoring, L5/L6 deep analysis, ordinary dossier hydration, write-lane throughput mechanics, HUD layout/performance, Top10 cadence/stage/promote/archive mechanics, classification, trade logic, and broad dispatcher scheduling.

Proof:
- Source-level/static inspection only in this environment.
- No MetaEditor compile proof and no fresh MT5 runtime/live artifact proof claimed.

## 2026-04-25 — DOC 14 RUN 2 / proof-standard evidence boundary hardening

Changed files:
- `mt5/runtime/ASC_Dispatcher.mqh`
  - Added `ASC_ManifestEvidenceBoundaryLine()`.
  - Added `Evidence Boundary:` to the Artifact Bundle Manifest body.
  - Expanded required manifest tokens from 15 to 16 by requiring `Evidence Boundary:`.
  - The new line separates `compile_proof`, `live_runtime_proof`, `artifact_readback`, `calibration_validation`, `run3_required`, and `hold_reason`.
- `mt5/core/ASC_Version.mqh`
  - Bumped version to `Stage2-Doc14-Run2-ProofStandardHardening`.
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/14_BATC_TEST_PROT_AND_CHEC.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`

Research-supported seam:
- Run 1 separated proof classes but the manifest did not explicitly state which evidence was outside manifest scope. Run 2 hardens the missing-evidence boundary without changing ranking, HUD, dossier, Top10, deep-analysis, classification, trade, or broad scheduling behavior.

Proof status:
- MetaEditor compile not run.
- MT5 live runtime not run.
- Source/static check only.

## 2026-04-25 — DOC 15 RUN 2 / validation terminology source hardening

Changed:
- `mt5/io/ASC_FileIO.mqh`
  - Reworded required-token failure reason from generic validation failure to token-contract failure.
  - Reworded temp readback operation labels from `operation=validate_temp` to `operation=readback_token_contract` and renamed local FileIO helper/reason identifiers away from validate/validation wording.
  - Reworded pair temp readback operation labels from `operation=pair_validate_temp` to `operation=pair_readback_token_contract`.
  - Reworded pair missing-token failure from generic validation failure to token-contract failure.
- `mt5/core/ASC_Version.mqh`
  - Bumped source label to `Stage2-Doc15-Run2-ValidationTerminologyHardening`.
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/15_CALI_VALI_AND_CLOS.md`
  - Added Run 2 research/source patch record and Run 3/Run 4 proof burdens.
- `office/ROADMAP_STATUS.md`, `office/WORK_LOG.md`, `office/CHANGE_LEDGER.md`, `office/DECISIONS.md`, `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`
  - Synced Doc 15 Run 2 status, research basis, source seam, protected seams, and proof limits.

Not changed:
- No ranking, HUD, GlobalTop10 lifecycle, deep analysis, dossier hydration law, write-lane throughput mechanics, classification, trade logic, or broad dispatcher scheduling.
- No live runtime artifact was generated and no compile proof was claimed.

## 2026-04-25 — DOC 15 RUN 3 / office-only live proof hold

Changed:
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/15_CALI_VALI_AND_CLOS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/ROADMAP_STATUS.md`

Not changed:
- No compile-path source files.
- No version define.
- No FileIO helper signatures or call sites.
- No required-token arrays.
- No ranking/HUD/Top10/deep/dossier-law/write-throughput mechanics.

Reason:
- Uploaded runtime artifacts preserved manifest proof boundaries but did not include the required FileIO logs or compile transcript needed to prove the Doc 15 Run 3 live wording contract.
- Missing evidence does not justify a source patch.
