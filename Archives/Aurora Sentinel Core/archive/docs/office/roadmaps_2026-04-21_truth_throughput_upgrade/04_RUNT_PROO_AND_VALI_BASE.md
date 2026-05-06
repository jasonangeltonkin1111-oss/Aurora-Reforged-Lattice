## 2026-04-25 — Run-structure supersession note

The old four-run-per-doc structure is superseded from the Doc 16 final closeout forward. Remaining docs use two internet/source/code/office runs only, with no per-doc live-test run. Live testing, compile/runtime proof, artifact/log proof, calibration/validation proof, and trading-edge proof are deferred to the final integrated live test at the end of Doc 18 unless a later office decision explicitly narrows this rule. Deferred proof must be carried as a proof-hold, not claimed as closure evidence.


## 2026-04-25 — Doc 15 clarification: FileIO readback is not calibration/validation proof

Doc 15 Run 1 hardened the source wording used by FileIO atomic publication. A successful temp write/readback/required-token/equality check is now reported as `readback_token_contract_satisfied`, not generic `validated` proof. This means artifact publication logs can support source/runtime readback evidence only; they do not prove calibration, trading-edge validation, or roadmap closure without the comparative evidence required by this baseline.

# Runtime Proof and Validation Baseline

## Purpose

This file defines what counts as proof for the new upgrade cycle.
It exists to stop source-only optimism and to keep upgrades honest.

## Proof classes

### Source-Level Landed

A code or office change exists in the live files.
This is necessary but often not sufficient.

### Artifact-Level Visible

A runtime-generated artifact or office/control file visibly reflects the intended change.
Still not enough for runtime closure when live behavior matters.

### Runtime-Proven

Logs, artifacts, and live runtime behavior all agree that the lane is functioning as intended.

### Calibrated / Validated

Comparative evidence shows the upgraded behavior is not only present, but usefully better or better-bounded.

## Lane-specific proof expectations

- ordinary dossier law restoration -> Runtime-Proven
- deep non-regression guards -> Runtime-Proven
- throughput improvement -> Runtime-Proven, then Calibrated where tuning is involved
- Layer 0–2 polish -> Runtime-Proven
- Layer 3 / Layer 4 scoring and ranking upgrades -> Calibrated / Validated
- Layer 5 / Layer 6 support-truth upgrades -> Calibrated / Validated
- operator artifact alignment -> Runtime-Proven
- closure -> only after prerequisite lanes are honestly classified

## Mandatory evidence families

For runtime-facing lanes, use at least:

- fresh runtime bundle / manifest
- fresh board output
- fresh ordinary dossier family samples
- fresh current-focus/deep samples where relevant
- fresh `function_results.log`
- fresh `heartbeat_telemetry.log`
- screenshot evidence where operator-visible behavior matters

## Comparative validation rule

Scoring/ranking/deep-support upgrades must not close on single-run screenshots alone.
They require comparison against a prior run or a prior baseline pack.

## Honesty rule

If the evidence is mixed:

- classify mixed
- classify partial
- name the surviving contradiction
- do not call the lane done

## Doc 14 proof-class hardening — 2026-04-25

Doc 14 makes proof language mandatory across every future run.
The proof classes are now operational, not decorative:

- **source-landed** is not compile proof.
- **static-inspected** is not compile proof.
- **compile-proven** is not live proof.
- **artifact-visible** is not full runtime proof unless logs and runtime behavior agree.
- **runtime-proven** is not calibration unless comparative evidence exists.
- **calibrated / validated** requires before/after, regime/time/friction context where strategy quality is claimed.
- **held / unproven** must be used whenever evidence is missing, stale, mixed, or indirect.

Future reports must include an evidence ledger that states which proof families were actually read and which were unavailable.
Closure wording must name the strongest proof class achieved and the strongest proof class still missing.

## Batch checkpoint proof rule

A batch can wait for live testing only while its changes remain bounded and non-closure is stated honestly.
A batch must stop and demand immediate proof when compile-path behavior, runtime artifacts, performance-sensitive scheduling, ranking, Top10 mechanics, HUD interaction, or dossier/Current Focus ownership changes are touched.
