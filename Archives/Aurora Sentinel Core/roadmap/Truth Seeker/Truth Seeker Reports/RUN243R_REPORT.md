# RUN243R Report — SDP Route Starvation + Proof Token Contract Repair

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN243R / SDP ROUTE STARVATION + PROOF TOKEN CONTRACT REPAIR — RESTORE SYMBOL DATA PACK PUBLICATION AFTER RUN241 TOP10 YIELD HARDENING
MODE: DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN243R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN243R.zip
SOURCE BASELINE: RUN241R + RUN242R LIVE FAILURE EVIDENCE
NEXT LIVE TEST: RUN244R
FINAL DECISION: TEST FIRST
```

## Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN243R |
| primary mode | DEBUG |
| secondary mode | PATCH |
| live run? | no |
| runtime/output artifacts expected? | no new runtime output |
| source editing allowed? | yes, exact blocker repair only |
| generated output editing allowed? | no |
| generated output cleanup allowed? | no |
| FileIO rewrite allowed? | no |
| final path mutation allowed? | no |
| flat-root SDP re-enable allowed? | no |
| public SDP staging re-enable allowed? | no |
| L3 behavior/gate change allowed? | no |
| L4 ranking/order/formula change allowed? | no |
| membership source change allowed? | no |
| HUD patch allowed? | no |
| Dossier architecture patch allowed? | no |
| Market Board broad redesign allowed? | no |
| strategy/signal/trade/risk patch allowed? | no |
| next live test | RUN244R |
| production-ready claim allowed? | no |
| edge claim allowed? | no |
| signal/trade permission allowed? | no |

## Evidence Rank

- RUN242 live output evidence is Class 2 intake evidence: it proves the supplied report/log claims existed, not runtime truth beyond that window.
- RUN243 source inspection is Class 3 evidence: active source owners were inspected and patched.
- No MetaEditor compile output was produced in this run.
- No Experts log, Journal log, or RUN244 live output exists from this run.
- Highest defensible claim: source-level blocker repair applied; compile/runtime/live proof remains outstanding.

## RUN242 Failure Absorption Table

| RUN242 Failure | Runtime Evidence | Source Owner Candidate | Severity | RUN243 Action |
|---|---|---|---|---|
| Symbol Data Packs folder absent | server export / file listing | `mt5/runtime/ASC_Dispatcher.mqh` SDP route services | critical | removed Top10 active gate around SDP mirror route services; routes now admitted and self-defer on due/budget |
| Scanner Status fails 97 times | FunctionResults | `ASC_ScannerStatusWriter.mqh` / `ASC_ArtifactTextHelpers.mqh` | critical | aligned emitted checklist heading to required token |
| missing token `Runtime Proof Bundle Capture Checklist` | FunctionResults | `ASC_RuntimeCaptureChecklistBlock()` emitted heading | critical | emitted `Runtime Proof Bundle Capture Checklist:` exactly |
| helper emits `Runtime Capture Checklist:` | source/report | `ASC_ArtifactTextHelpers.mqh` | critical | replaced old heading; checklist content preserved |
| Manifest fails 5 times | FunctionResults | Dispatcher manifest writer / helper | critical | aligned helper decision mapping token |
| missing token `proof_bundle_decision_mapping=` | FunctionResults | `ASC_ProofBundleDecisionMappingLine()` | critical | added exact required machine token |
| helper emits `proof_bundle_decision=` | source/report | `ASC_ArtifactTextHelpers.mqh` | critical | retained as secondary only after required mapping token |
| Top10 batch active at cursor 5/10 | heartbeat | `ASC_RunWriteLane()` Top10 service gate | high | decoupled SDP route mirror admission from Top10 active state |
| heartbeat max 7144ms | heartbeat | `ASC_Dispatcher.mqh` / side-duty | high | preserved RUN241 cap; no broad rewrite |
| no compile/Experts/Journal | missing evidence | evidence gap | high | RUN244 required after MetaEditor compile |

## Patched Files

| File | Patch |
|---|---|
| `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` | `ASC_RuntimeCaptureChecklistBlock()` now emits `Runtime Proof Bundle Capture Checklist:`; `ASC_ProofBundleDecisionMappingLine()` now emits `proof_bundle_decision_mapping=...` before the legacy `proof_bundle_decision=...` line. |
| `mt5/runtime/ASC_Dispatcher.mqh` | `ASC_RunWriteLane()` now admits GlobalTop10 and Top5PerBucket SDP mirror publication services even while Top10 batch state is active; the services keep their own due/budget gates. Added `run243_sdp_route_mirror_gate=allowed` diagnostic. |
| `mt5/core/ASC_Version.mqh` | advanced active run/package identity to RUN243R and seeded RUN244R live proof. |
| office/control docs | updated status, work log, decisions, change ledger, active roadmap, and output manifest. |

## Hard Boundaries Preserved

- No generated Symbol Data Packs were edited, created, deleted, renamed, cleaned, or regenerated.
- No generated Dossiers, Market Board, Scanner Status, Manifest, FunctionResults, Experts, or Journal evidence was edited.
- No FileIO rewrite was made.
- No final route mutation was made.
- No flat-root SDP or public staging SDP was re-enabled.
- No L3 gate, L4 ranking/order/formula, membership source, HUD, Dossier architecture, Market Board redesign, strategy, signal, trade, or risk logic was changed.

## Static Verification Performed

- Grep confirmed `Runtime Proof Bundle Capture Checklist` is now both required and emitted.
- Grep confirmed `proof_bundle_decision_mapping=` is now both required and emitted.
- Grep confirmed SDP mirror publication calls are no longer wrapped by the old `if(!top10_batch_active)` gate in `ASC_RunWriteLane()`.
- Diff review confirmed the patch is limited to the exact blocker files plus control/report files.

## Remaining Falsifiers for RUN244R

RUN244R must fail this patch if any of these remain true after compile/live proof:

1. MetaEditor compile fails.
2. FunctionResults still reports missing `Runtime Proof Bundle Capture Checklist`.
3. FunctionResults still reports missing `proof_bundle_decision_mapping=`.
4. `run243_sdp_route_mirror_gate=allowed` never appears while Top10 is active/yielding.
5. Symbol Data Pack route family still never attempts publication in the live window.
6. Symbol Data Packs folder remains absent after the route is due and source snapshots exist.
7. Heartbeat remains materially over budget without a clear deferred reason.
8. Any generated output was mutated by source patch packaging.

```text
FINAL SUMMARY

RUN243R patched the two proven proof-token contract mismatches and the proven SDP mirror route starvation gate introduced by the Top10 active/yield hardening path.

The repair is source-only. It does not prove compile success, runtime correctness, live stability, artifact publication, trading edge, or production readiness.

Decision: TEST FIRST.
Strongest next move: run MetaEditor compile, then RUN244R live retest with FunctionResults, Scanner Status, Manifest, Symbol Data Packs folder/file listing, heartbeat telemetry, Experts log, and Journal log supplied read-only.
```
