## 2026-04-25 — Run-structure supersession note

The old four-run-per-doc structure is superseded from the Doc 16 final closeout forward. Remaining docs use two internet/source/code/office runs only, with no per-doc live-test run. Live testing, compile/runtime proof, artifact/log proof, calibration/validation proof, and trading-edge proof are deferred to the final integrated live test at the end of Doc 18 unless a later office decision explicitly narrows this rule. Deferred proof must be carried as a proof-hold, not claimed as closure evidence.


## 2026-04-25 — DOC 15 RUN 4 / final polish + GlobalTop10 5-minute cadence patch

Run 4 performed Doc 15 final polish / closeout hardening using Run 3 as the proof base while carrying its proof limitations honestly.

Source patch landed:
- `mt5/runtime/ASC_Dispatcher.mqh` is the compile-path owner for GlobalTop10 full-child refresh cadence through `ASC_TOP10_RUN_FULL_CADENCE_SEC` and `ASC_Top10RunFullCadenceDue(...)`.
- GlobalTop10 automatic full-child refresh cadence changed from `600` seconds / 10 minutes to `300` seconds / 5 minutes.
- Top10 cadence reason text changed from 10-minute wording to 5-minute wording in the same owner path.
- Version bumped to `Stage2-Doc15-Run4-Top10CadencePolish`.

What was not changed:
- No Top10 count, ranking formula, diversification logic, stage/promote/archive lifecycle, archive retention count, HUD layout, L3/L4 scoring, L5/L6 deep analysis, classification, trade logic, ordinary dossier hydration, or write-lane throughput redesign was changed.
- `ASC_L4_TARGET_RECHECK_OPEN_SEC` and `ASC_L4_RECHECK_OPEN_SEC` remain `600` seconds because the operator override targeted GlobalTop10 automatic refresh cadence only, not the underlying L4 shortlist/board authority cadence.

Proof posture:
- Static source inspection only in Run 4.
- MetaEditor compile was not run in this environment and no compile transcript was supplied.
- No new live runtime output was generated.
- Run 3 manifest evidence remains useful for proof-boundary visibility only; it did not prove fresh FileIO log wording, compile success, calibration, validation, or trading edge.

Doc 15 verdict:
- Doc 15 is closed for the source/control calibration-validation wording lane with proof-hold disclosed.
- Carry-forward proof remains required at the next MT5 verification point: MetaEditor compile, `Workbench/logs/function_results.log`, `Workbench/logs/heartbeat_telemetry.log`, root `Scanner Status.txt`, root `Market Board.txt`, and a fresh GlobalTop10 cycle proving 5-minute cadence behavior without stage/promote/archive regression.

## 2026-04-25 — DOC 15 RUN 2 / internet-hardened validation-terminology source patch

Run 2 performed internet hardening against official/primary software testing, V&V, provenance, and observability references. The research confirmed Run 1's main correction: a file write/readback/token-contract success must not be reported as calibration, validation, closure, or trading-edge proof.

Research-supported boundary:
- Verification/checking can show a work item or output satisfies specified requirements or a local contract.
- Validation requires evidence that the system or work item satisfies the intended user/use need in context.
- Calibration/validation proof for ASC remains a later evidence class and cannot be inferred from publication readback, token presence, manifest presence, or `state=ok` reason strings.
- Provenance/lineage/readback evidence can support trust assessment, but it is not itself validation proof.
- Observability evidence is runtime evidence only; it must not be promoted into calibrated/validated wording without the required comparative/live evidence.

Run 2 source seam patched:
- `mt5/io/ASC_FileIO.mqh` still used generic validation wording in failure/operation reason strings around required-token and temp readback checks.
- Those strings now say `required token contract failed`, `operation=readback_token_contract`, and `operation=pair_readback_token_contract` where applicable; internal helper names/reason variables were also changed from validate/validation wording to token-contract wording inside the same FileIO owner.
- Pair publish missing-token failure now says `pair publish token contract failed` instead of generic validation failure.
- Existing Run 1 success reasons remain readback/token-contract specific.
- Version bumped to `Stage2-Doc15-Run2-ValidationTerminologyHardening`.

What was not changed:
- No ranking, L3/L4 scoring, L5/L6 deep analysis, ordinary dossier hydration, write-lane throughput mechanics, HUD, GlobalTop10 cadence/promote/archive mechanics, classification, trade logic, or broad dispatcher scheduling.
- No FileIO behavior change beyond reason/operation wording.
- No schema redesign and no live proof claim.

Proof posture:
- Internet research + static source/control inspection only.
- MetaEditor compile not run.
- No live runtime proof claimed.
- No calibration/validation/closure proof claimed.

Run 3 live-test burden:
- Compile the MT5 source externally in MetaEditor.
- Run fresh MT5 publication cycles that exercise success, no-material-change, missing-token/readback failure if safely reproducible, and continuity retention.
- Capture logs/artifacts proving FileIO reason strings now distinguish readback/token-contract evidence from validation/calibration/closure.
- Confirm `state=ok` plus reason text cannot be read as calibrated/validated proof.

Run 4 closeout boundary:
- Use Run 3 evidence by default.
- Polish/close only wording/proof reporting unless Run 3 exposes a fresh contradiction.
- Do not require a new live run by default unless Run 4 changes runtime behavior or Run 3 evidence is missing/contradictory.


## 2026-04-25 — DOC 15 RUN 1 / validation-boundary source patch

Run 1 started from Doc 14 closed with compile-hold disclosed. Git/source audit found a source-level wording seam in `mt5/io/ASC_FileIO.mqh`: atomic publication success used generic `validated` wording after readback and required-token checks. That wording was too close to Doc 15's reserved validation/calibration meaning.

Patch landed:
- File publication success now reports `readback_token_contract_satisfied`.
- Single-artifact promotion now reports `reason=temp write readback_token_contract_satisfied and promoted`.
- Pair-artifact promotion now reports `reason=pair publish readback_token_contract_satisfied and promoted`.
- Version bumped to `Stage2-Doc15-Run1-ValidationBoundary`.

Boundary improved:
- Readback/token-contract success is now named as readback/token-contract success.
- It is not calibration.
- It is not validation of trading edge.
- It is not roadmap closure.
- It is not live proof unless produced in a fresh MT5 runtime run.

Not changed:
- No source behavior beyond wording.
- No ranking, L3/L4 scoring, L5/L6 deep analysis, dossier hydration, write-lane throughput, HUD, GlobalTop10 lifecycle, classification, trade logic, or scheduler mechanics.

Proof posture:
- Static source inspection only.
- MetaEditor compile not run.
- No live runtime proof claimed.
- No calibration/validation/closure proof claimed.

Next:
- Run 2 must internet-harden the terminology and closure rules against primary/official sources.
- Run 3 must live-test the log/artifact wording under MT5.
- Run 4 must polish/close from Run 3 evidence by default unless evidence is missing, contradictory, or source behavior changes.

# Calibration, Validation, and Closure

## Purpose

This file defines how the roadmap closes honestly.
It is reopened by the 2026-04-23 strategy reality audit because the earlier wording allowed false completion and under-specified proof.

## Corrected closure law

A doc is not honestly complete when later findings change the method truth.
A doc must be reopened if the audit changes any of the following:

- what the lane is actually trying to prove
- whether the lane is edge-contributing or support-only
- whether the lane still lacks a critical validation path

## Runtime-class split now explicit

- **Layer 3 / Layer 4:** plausible edge-contributing runtime logic
- **Layer 5 / Layer 6:** support / diagnostic / prioritization logic unless later validation proves stronger leverage

This split must control how evidence is interpreted.

## Required comparative evidence now explicit

To argue edge contribution, the closure path must include:

- cost-aware comparison
- slippage / impact realism
- regime-split comparison
- out-of-sample or time-split discipline
- explicit falsifiers

To argue support usefulness, the closure path must include:

- before/after support usefulness evidence
- overload-reduction or prioritization evidence
- proof that support improvements did not create owner drift or false edge claims

## What does not count as closure

- source edits alone
- office wording alone
- a cleaner summary
- a better-looking support surface
- a ranking change with no friction-aware comparison
- a later doc still reported as complete after the audit changed its method truth

## 2026-04-25 — DOC 15 RUN 3 / live artifact boundary audit, FileIO log proof held

Run 3 inspected the uploaded `Upcomers-Server` live artifact pack against Doc 15's calibration/validation/closure boundary requirements.

Observed evidence:
- `Artifact Bundle Manifest.txt` was present.
- Root `Dossier.txt` was present.
- `Dossiers/GlobalTop10/_family_manifest.txt` was present.
- `Dossiers/GlobalTop10/_staging/_family_manifest.txt` was present.
- `Dossiers/GlobalTop10/archive/*/_family_manifest.txt` archives were present.
- Manifest proof boundary lines were preserved:
  - `Proof Class Ledger:`
  - `Checkpoint Evidence:`
  - `Evidence Boundary:`
  - `compile_proof=not_observed_by_manifest`
  - `calibration_validation=not_claimed_by_manifest`

Missing evidence:
- MetaEditor compile transcript was not supplied and compile could not be run in the worker environment.
- `Workbench/logs/function_results.log` was not present.
- `Workbench/logs/heartbeat_telemetry.log` was not present.
- Root `Scanner Status.txt` was not present.
- Root `Market Board.txt` was not present.
- Fresh FileIO success wording was not live-proven from logs.
- Fresh FileIO failure wording was not naturally observed.

Run 3 decision:
- No source patch was admitted.
- The evidence gap is capture/packaging, not a proven source contradiction.
- No calibration proof, validation proof, trading-edge proof, or closure proof is claimed.

Run 4 boundary:
- Run 4 may be final polish/closeout only if it explicitly carries the compile/log proof limitation.
- If strict Run 3 live proof is required, rerun Run 3 with MetaEditor compile output and `Workbench/logs/function_results.log` included.
