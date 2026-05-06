## 2026-04-25 — Run-structure supersession note

The old four-run-per-doc structure is superseded from the Doc 16 final closeout forward. Remaining docs use two internet/source/code/office runs only, with no per-doc live-test run. Live testing, compile/runtime proof, artifact/log proof, calibration/validation proof, and trading-edge proof are deferred to the final integrated live test at the end of Doc 18 unless a later office decision explicitly narrows this rule. Deferred proof must be carried as a proof-hold, not claimed as closure evidence.

## Run 4 final polish / closeout result — 2026-04-25

Doc 14 Run 4 performed the final closeout hardening pass against the Run 3 live-evidence base.

### Run 3 evidence retained
- `Artifact Bundle Manifest.txt` contained `Proof Class Ledger:`.
- `Artifact Bundle Manifest.txt` contained `Checkpoint Evidence:`.
- `Artifact Bundle Manifest.txt` contained `Evidence Boundary:`.
- Required-token validation was live-supported by successful manifest publication logs.
- The manifest did not claim compile proof or calibration/validation proof.

### Final source polish landed
Run 4 patched only the Artifact Bundle Manifest wording helpers in `mt5/runtime/ASC_Dispatcher.mqh`:
- `ASC_ManifestProofClassLedgerLine()`
- `ASC_ManifestCheckpointEvidenceLine()`
- `ASC_ManifestEvidenceBoundaryLine()`

The patch:
- removes duplicate/wordy proof labels;
- keeps compact operator-readable key/value proof fields;
- preserves `compile_proof=not_observed_by_manifest`;
- preserves `calibration_validation=not_claimed_by_manifest`;
- preserves `run3_required=MetaEditor_compile_plus_MT5_artifact_log_screenshot_proof`;
- preserves the required-token list and token names.

### Version
`mt5/core/ASC_Version.mqh` now reports:
- `Stage2-Doc14-Run4-ProofCloseoutPolish`

### Closeout boundary
Doc 14 is closed with compile-hold disclosed:
- Source and office closeout is complete.
- Run 3 live proof remains the artifact proof base.
- MetaEditor compile proof remains missing because compile tooling was not available in this environment.
- The next MT5-side verification should still capture compile proof and one regenerated manifest/log screenshot, but this does not block starting Doc 15 because the missing proof is explicitly disclosed rather than overclaimed.

### Non-regression boundary
Run 4 did not edit ranking, HUD, dossier-law restoration, write-lane throughput, Top10 mechanics, deep analysis, classification, trade logic, or broad dispatcher scheduling.

# Batch Testing Protocol and Checkpoints

## Doc 14 active purpose — Run 1 source/control hardening

This document is the checkpoint and proof-discipline layer for the active roadmap family.
It does not create a new roadmap, runtime layer, ranking formula, HUD redesign, Top10 mechanic, or trade-selection rule.

Doc 14 exists because recent runs proved that source work can land while compile proof, live proof, calibration proof, and operator-visible artifact proof remain different unfinished burdens.
Future runs must make that separation obvious before editing and before claiming closure.

## Current run structure for remaining roadmap docs

The prior four-run pattern is superseded by office decision from the Doc 16 final closeout forward.

1. **Run 1 — Internet/source/code/office run**
   - read the actual active roadmap doc and source owners;
   - use focused internet research where it improves source/control truth;
   - admit code edits only for a bounded owner-proven seam;
   - sync office/control truth and proof-holds.
2. **Run 2 — Internet/source/code/office closeout run**
   - harden the remaining source/control seam if one exists;
   - close source/control only if dependencies, known limitations, proof-holds, and final Doc 18 acceptance-test obligations are explicit;
   - do not claim compile/live/calibration/validation/trading-edge proof.

No remaining doc receives a per-doc live-test run by default. Live proof is deferred to the final integrated live test at the end of Doc 18.
## Proof classes that every run must use

Every meaningful claim must be tagged with one of these classes:

- **source-landed** — the file change exists in current source/control files.
- **static-inspected** — call sites, includes, owners, constants, validation tokens, and obvious syntax risks were inspected without compile execution.
- **compile-proven** — MetaEditor or equivalent compile output proves the current source builds.
- **artifact-visible** — generated artifacts or office/control surfaces visibly show the intended change.
- **runtime-proven** — fresh live logs, artifacts, and runtime behavior agree with the intended behavior.
- **calibrated / validated** — comparative evidence shows the change is usefully better, safer, or better bounded.
- **held / unproven** — evidence is missing, mixed, stale, or insufficient for closure.

No run may collapse these classes into one vague word such as “done”.

## Mandatory audit template for every future run

Every future worker report must include the following audit blocks before final verdict:

### 1. Truth Delta

State:

- what changed since the previous pass;
- what stayed unchanged;
- what improved;
- what regressed;
- what was suspected but disproven;
- what remains unproven.

### 2. Proof Class

For each important claim, mark the strongest available proof class from the taxonomy above.

### 3. Dominant Risk Stack

State:

- dominant risk;
- secondary risk;
- false seam rejected;
- protected solved seam;
- likely regression trap.

### 4. Evidence Ledger

State whether each evidence family was read or unavailable:

- source zip / repo files;
- runtime zip / live output pack;
- compile log;
- live artifacts;
- logs;
- screenshots;
- internet sources.

### 5. Patch Admission Decision

Every code/doc edit must state:

- why the edit is admitted;
- exact owner file;
- exact function, branch, helper, or doc section;
- exact minimal change;
- what is forbidden;
- what must not regress.

### 6. Batch Test Checkpoint

State:

- test now or wait;
- acceptable batch size;
- exact artifacts required for next live proof;
- exact logs required;
- exact screenshots required where applicable;
- what evidence closes the batch.

### 7. Performance Side-Check

State:

- whether timing, heartbeat, write lane, read lane, artifact size, or publish frequency was touched;
- whether HUD latency or write pressure could regress;
- which performance metric the next live proof must capture.

### 8. Next Prompt Intelligence

State:

- next exact doc/run;
- exact owner chain for the next pass;
- exact evidence required next;
- exact traps to forbid next;
- exact solved seams to protect next.

## Internet-run standard for Runs 2, 3, and 4

Run 1 must not use internet research.
Runs 2, 3, and 4 may use internet support where useful, but must obey this standard:

- official / primary sources first;
- high-quality infrastructure, product, status, data-quality, validation, observability, or MQL/MetaTrader references before generic content;
- separate research findings from current source truth;
- state which research actually changed the patch or proof burden;
- reject weak sources explicitly when they do not change the pass;
- avoid research padding;
- compare research directly to current source wording or logic;
- produce a research-to-source matrix when research influences edits;
- convert research into one bounded source/control change, not a broad redesign;
- cite sources in the final worker response for any externally grounded claim;
- keep research aligned with the exact active doc seam.

## Code-edit quality standard

A source patch is admitted only after the worker identifies the real current owner chain.
Before changing compile-path files, the worker must inspect:

- current live file, not archive copy;
- include chain where relevant;
- call sites and signatures;
- constants and path helpers;
- required-token / validation lists;
- version define when compile-path source changes;
- compile risk;
- runtime proof burden;
- performance side-effects;
- changed-files-only package layout.

A source patch must not:

- edit stale archive files as authority;
- fan out across nearby files just because names look related;
- make broad speculative rewrites;
- weaken board authority, dossier support law, Top10 family law, or one-truth ownership;
- hide performance cost.

## Batch testing doctrine

The operator does **not** test every tiny commit.
Testing occurs after a meaningful bounded batch, unless immediate proof is required by risk.

### A batch may accumulate when

- edits are source-only or office-only within the same seam family;
- no compile-path signatures, includes, or path helpers changed;
- no live runtime behavior is being claimed closed;
- no timing/write/read/HUD/performance surface was touched;
- protected solved seams have explicit regression fences.

### Immediate compile or live test is required when

- compile-path signatures, includes, constants, validation tokens, or path helpers change;
- runtime-facing artifact publication changes;
- write lane, read lane, heartbeat, dispatcher scheduling, or HUD interaction changes;
- ranking formulas, shortlist ordering, deep analysis, Top10 mechanics, or dossier ownership changes;
- a live contradiction was patched;
- the pass wants to claim runtime-proven or calibrated/validated status.

### Too risky to batch

Do not batch without immediate proof when the patch touches:

- ranking/scoring behavior;
- Market Board authority;
- root `Dossier.txt` / Current Focus target resolution;
- `Dossiers/<symbol>.txt` ordinary dossier family ownership;
- `Dossiers/GlobalTop10/` stage/current/archive/preserve mechanics;
- atomic file publication helpers;
- dispatcher heartbeat/write/read scheduling;
- HUD latency-sensitive handlers;
- deep selective analysis execution path.

## Lane-specific checkpoint requirements

### Compile-path source changes

Required evidence before closure:

- MetaEditor compile log;
- touched include/call-site inspection;
- version label check;
- no archive/stale authority edits;
- post-compile runtime proof if behavior is runtime-facing.

### Runtime-facing artifact changes

Required evidence before closure:

- fresh `Artifact Bundle Manifest.txt` where relevant;
- fresh `Market Board.txt` where board wording/authority is involved;
- fresh root `Dossier.txt` for Current Focus / selected-symbol support proof;
- fresh `Dossiers/<symbol>.txt` samples for ordinary dossier family proof;
- fresh `Dossiers/GlobalTop10/` manifests/children where Top10 support families are involved;
- fresh logs proving the claimed path ran.

### Performance-touching changes

Required evidence before closure:

- compose and publish timings;
- write queue timing;
- heartbeat telemetry;
- symbol count / server context;
- HUD click or page latency proof when HUD responsiveness is at risk;
- before/after comparison if performance improvement is claimed.

### Ranking / strategy-quality changes

Required evidence before closure:

- before/after board outputs;
- before/after candidate or shortlist sets;
- friction-aware comparison;
- regime split where behavior differs materially;
- out-of-sample or time-split evidence where available;
- explicit falsifier that can reject the claimed improvement.

### Layer 5 / Layer 6 support changes

Required evidence before closure:

- before/after support surfaces;
- overload reduction or prioritization improvement evidence;
- proof that board authority remains intact;
- proof that support surfaces did not become command authority.

## Checkpoint verdict language

Every run must end with exactly one next-move checkpoint:

- **NEXT RUN ADMITTED** — current run source/control burden is met and the next run is the right move.
- **RE-RUN REQUIRED** — current run is internally inconsistent, missing required edits, or contradicted by source/control evidence.
- **STILL BLOCKED** — required evidence is unavailable and no honest bounded patch can be made.

For Doc 14 Run 1, the expected next checkpoint is **DOC 14 RUN 2 NEXT** if the protocol hardening lands cleanly.

## What not to do

- do not call support-only improvement edge proof;
- do not call one clean screenshot validation;
- do not skip falsifiers;
- do not claim live proof from source edits;
- do not call Doc 13 fully closed while compile and fresh runtime closeout proof are absent;
- do not create a new roadmap while this active roadmap family remains open;
- do not reopen solved lanes unless the active doc proves a direct contradiction.

## Run 1 REDO — source-level proof-reporting seam landed (2026-04-25)

Run 1 was redone because the earlier Run 1 hardened office/protocol wording only. That was insufficient for Doc 14: the proof protocol must also improve a compile-path reporting surface when a safe source seam exists.

### Source seam

Owner: `mt5/runtime/ASC_Dispatcher.mqh` / `ASC_WriteArtifactBundleManifest()`.

Problem: `Artifact Bundle Manifest.txt` had rich operational fields, but did not provide one compact proof-class ledger or checkpoint evidence line separating:
- Source-Level Landed
- Artifact-Level Visible
- Runtime-Proven
- Calibrated / Validated
- pending/deferred/blocked/live-closeout readiness

### Patch

The manifest now writes:
- `Proof Class Ledger:` — source owner, artifact visibility, runtime-proven posture, and explicit no-calibration claim.
- `Checkpoint Evidence:` — current checkpoint classification plus board/dossier/manifest/overall status and missing/hold reason.

Both lines are required manifest tokens.

### Proof posture

- Source patch: landed.
- Static inspection: done.
- MetaEditor compile: not run here.
- Live runtime proof: not claimed.
- Calibration/validation: not claimed.

### Run 2 requirement

Internet-harden the proof taxonomy and observability wording against official/primary sources. Admit only one bounded source/control improvement if research proves one.

### Run 3 requirement

MetaEditor compile and live MT5 proof must show `Artifact Bundle Manifest.txt` contains truthful `Proof Class Ledger:` and `Checkpoint Evidence:` lines across normal, pending/deferred, partial, and aligned artifact-family states.

### Run 4 requirement

Use Run 3 live evidence by default for closeout polish. Do not demand another live run unless Run 3 evidence is missing/contradictory or Run 4 changes runtime behavior.

## Run 2 — internet-hardened evidence boundary standard (2026-04-25)

Run 2 hardened the Run 1 manifest proof/reporting patch against external testing, V&V, observability, provenance, and status-wording references.

### Research-supported conclusion

Run 1 got the main proof taxonomy right:
- `Source-Level Landed`
- `Artifact-Level Visible`
- `Runtime-Proven`
- `Calibrated / Validated`

The weak seam was not a missing ranking or product feature. The weak seam was that manifest readback can look stronger than it is unless the manifest also states what evidence it cannot provide.

### Run 2 source standard

`Artifact Bundle Manifest.txt` must now include:
- `Proof Class Ledger:` — compact proof-class posture.
- `Checkpoint Evidence:` — checkpoint state, artifact statuses, and missing/hold reason.
- `Evidence Boundary:` — explicit scope boundary separating:
  - `compile_proof`
  - `live_runtime_proof`
  - `artifact_readback`
  - `calibration_validation`
  - `run3_required`
  - `hold_reason`

### Required-token standard

The manifest required-token list is now 16 tokens and must require `Evidence Boundary:`. If the line disappears, manifest publication validation must fail rather than silently publishing a weaker proof artifact.

### Run 3 live-test burden

Doc 14 Run 3 must MetaEditor-compile and live-prove:
- `Proof Class Ledger:` appears.
- `Checkpoint Evidence:` appears.
- `Evidence Boundary:` appears.
- The `Evidence Boundary:` line truthfully reports:
  - compile proof is not produced by manifest readback;
  - live runtime proof is Run 3 required unless blocked/deferred by actual runtime state;
  - artifact readback scope matches the board/current-focus family state;
  - calibration/validation is not claimed by the manifest.
- Test at least these states when possible:
  - aligned active board/current-focus family;
  - selected-symbol child pending;
  - pending/deferred batch;
  - bundle failure/blocked state;
  - ordinary artifact-visible-ready state.

### Run 4 closeout default

Doc 14 Run 4 should use Run 3 live evidence by default. It should not ask for a new live run unless:
- Run 3 evidence is missing;
- Run 3 evidence contradicts source/control truth;
- Run 4 changes runtime behavior.

## Run 3 live proof result — 2026-04-25

Doc 14 Run 3 inspected a fresh Upcomers-Server runtime pack and found the proof/reporting lines live in `Artifact Bundle Manifest.txt`:

- `Proof Class Ledger:` present.
- `Checkpoint Evidence:` present.
- `Evidence Boundary:` present.

Live evidence boundary result:

- `compile_proof=not_observed_by_manifest` — correct; the manifest does not pretend to be a compiler.
- `calibration_validation=not_claimed_by_manifest` — correct; no calibration/validation closure is claimed from manifest readback.
- `run3_required=MetaEditor_compile_plus_MT5_artifact_log_screenshot_proof` — correct; the standard remains visible.
- `live_runtime_proof=deferred_until_pending_batch_clears` — correct for the observed pending dossier/manifest state.
- `artifact_readback=lawful_split_role_only` — correct for the observed Market Board baseline plus selected-symbol root `Dossier.txt` support split.
- `hold_reason=` matched the visible split-role reason and did not convert retained/current-focus support into false current board authority.

Observed states:

- Active board and focus artifacts were readable.
- Lawful split-role family alignment was observed.
- Pending/deferred batch state was observed.
- GlobalTop10 current `promoted_complete` and staging/archive manifests were observed.
- Cadence hold / preserved child-family state was observed.
- No blocked/failure state, selected-symbol child-pending state, or same-publication artifact-visible-ready state was naturally observed.

Compile status:

- MetaEditor compile was not available in this environment and no compile log was supplied. Run 3 therefore cannot honestly claim compile closure.

Patch result:

- No source patch was admitted. Office/control files only were updated.

Run 4 default:

- Run 4 should perform final polish/closeout hardening from this evidence by default.
- Run 4 must not demand a new live run by default unless the operator requires the missing MetaEditor compile proof, the evidence is contradicted, or Run 4 changes runtime behavior.
