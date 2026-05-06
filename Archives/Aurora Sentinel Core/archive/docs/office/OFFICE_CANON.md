## 2026-04-25 — Run-structure override canon

The old four-run-per-doc structure is superseded for the remaining roadmap docs.

Current run law:
- Each remaining doc uses two internet/source/code/office runs only.
- There are no git-only runs.
- There is no per-doc live-test run for Doc 16, Doc 17, or intermediate closeout.
- Live testing is deferred to the final integrated live test at the end of Doc 18.
- Source/control closure may be recorded only when proof-holds, known limitations, dependencies, and final Doc 18 acceptance-test obligations are explicit.
- Deferred proof is not compile proof, runtime proof, calibration proof, validation proof, or trading-edge proof.

This override does not authorize ranking, HUD, dossier-law implementation, Top10 mechanics, deep-analysis, FileIO behavior, write-lane, classification, trade logic, or broad dispatcher changes outside the active doc's direct owner seam.

# ASC Office Canon

## Purpose

`office/` is the only live documentation and control surface for the new upgrade cycle.
It does **not** own runtime behavior.
It describes:

- active roadmap family
- active lane and checkpoint posture
- work log, change ledger, and bounded decisions
- proof expectations
- what may and may not be edited during each lane

## Ownership boundary

- Runtime truth owner: compile-path `mt5/` code.
- Office owner: planning truth, checkpoint truth, protection rules, test batching rules, and honest proof posture.
- Runtime artifacts and logs are behavioral evidence, not planning authority.
- Historical roadmap families are evidence only once they are superseded.

## Core law

If office wording conflicts with compile-path MT5 code, **office must be corrected immediately**.
Office/control wording never overrides live compile-path truth.

## Active office files

- `office/OFFICE_CANON.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/00_READ_ME_FIRST.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/01_MASTER_UPGRADE_ROADMAP.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/02_CURRENT_RUNTIME_BASELINE_AND_MUST_FIX_SEAMS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/03_PROTECTED_SOLVED_SEAMS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/04_RUNTIME_PROOF_AND_VALIDATION_BASELINE.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/05_ORDINARY_DOSSIER_LAW_RESTORATION.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/06_DEEP_PATH_NON_REGRESSION_AND_PUBLICATION_GUARDS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/07_WRITE_LANE_DOSSIER_SWEEP_AND_THROUGHPUT.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/08_LAYER0_TO_LAYER2_POLISH_AND_HYDRATION_TRUTH.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/09_LAYER3_EARLY_EMERGENCE_TRADABILITY_LIFT_AND_DECAY.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/10_LAYER4_EXECUTION_ADJUSTED_RANKING_AND_DIVERSIFICATION.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/11_LAYER5_DEEP_CONTRADICTION_FAILURE_AND_PATH_QUALITY.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/12_LAYER6_SUPPORT_COMPRESSION_CONTRADICTION_AND_CHANGE_TRACKING.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/13_OPERATOR_ARTIFACT_ALIGNMENT_AND_SURFACE_TRUTH.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/14_BATCH_TESTING_PROTOCOL_AND_CHECKPOINTS.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/15_CALIBRATION_VALIDATION_AND_CLOSURE.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/16_EXEC_BACK.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/17_PROM_OPER_RULE.md`
- `office/roadmaps_2026-04-21_truth_throughput_upgrade/18_FILE_OWNE_AND_EDIT_BOUN.md`

## Active roadmap family

The active roadmap family is:

- `office/roadmaps_2026-04-21_truth_throughput_upgrade/`

Its purpose is **not** broad redesign.
Its purpose is:

- restore lawful ordinary dossier behavior at scale
- protect solved deep and Global Top 10 paths from regression
- improve throughput and runtime efficiency
- improve truth quality and ranking quality across Layers 0–6
- keep board authority and support-artifact law intact
- batch testing instead of panic-testing every commit

## Product law to preserve

- Market Board remains ordinary command authority.
- Dossier and Current Focus remain support artifacts.
- Selected-symbol deep support must not replace board authority.
- Same-symbol non-downgrade remains intact.
- Atomic publication and truthful bundle identity remain intact.
- No second analysis path may be introduced.
- No second owner path may be introduced.
- Scoring/ranking upgrades must remain ranking-led, not gate-led.

## Proof language law

The following proof classes are distinct and must never be blurred:

- Source-Level Landed
- Artifact-Level Visible
- Runtime-Proven
- Calibrated / Validated

No runtime-facing lane may claim closure from source edits alone.
No calibration lane may claim closure from theory-only confidence.

## Root Dossier / Current Focus naming law — 2026-04-25

- Root `Dossier.txt` is the active selected-symbol Current Focus surface.
- `Dossiers/<symbol>.txt` remains the per-symbol dossier family artifact.
- `Dossiers/GlobalTop10/` remains the GlobalTop10 support/deep family.
- Legacy source names such as `ASC_CurrentFocusWriter.mqh` are compatibility/readback names only unless they explicitly write another target path.
- Worker chats must not chase a separate required `Current Focus.txt` file when the compile path resolves `ASC_CURRENT_FOCUS_FILE` to root `Dossier.txt`.

## Run audit and checkpoint law — 2026-04-25

Every roadmap run must separate source/control truth, compile proof, artifact visibility, live runtime proof, and calibration.
Worker reports must include a truth delta, proof-class classification, evidence ledger, patch admission decision, batch-test checkpoint, performance side-check, and next-prompt intelligence.

Run 1 of each roadmap doc is git/source only and must not use internet research.
Runs 2, 3, and 4 may use internet support where useful, may make code edits when a bounded seam is proven, and must still keep proof classes separate.

Doc 13 is source/control improved but held for compile and fresh MT5 runtime closeout proof; it must not be called fully closed until that evidence exists.
Doc 14 is the active proof-discipline doc and remains inside the current roadmap family.

## Doc 16 authority correction — 2026-04-25

- Actual active Doc 16 file in this source pack: `office/roadmaps_2026-04-21_truth_throughput_upgrade/16_EXEC_BACK.md`.
- Title from the file: **Execution Backlog**.
- Any longer alias such as `16_EXECUTION_BACKLOG.md` is non-authoritative unless a future source pack actually contains it.
- Doc 16 is a backlog / closure-dependency control doc; it does not authorize ranking, HUD, dossier-law, Top10 mechanics, deep analysis, or trade-logic edits by itself.
