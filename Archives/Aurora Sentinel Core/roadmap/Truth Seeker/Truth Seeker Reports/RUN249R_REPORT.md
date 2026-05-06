# RUN249R Report — Compile Repair Before Siam Semantics

GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN249R / RUN248 COMPILE REPAIR BEFORE SIAM SEMANTICS — FIX DISPATCHER TELEMETRY SCOPE AND TOP5 SDP MIRROR SIGNATURE MISMATCH WITHOUT FEATURE EXPANSION  
MODE: DEBUG + PATCH  
TRUTH FURNACE REQUIRED  
REPORT: RUN249R_REPORT.md  
PACKAGE: TRUTH_SEEKER_RUN249R.zip  
SOURCE BASELINE REQUESTED: RUN248R HEARTBEAT / DEEP-PAYLOAD / PRESENCE-SWEEP HARDENING  
SOURCE BASELINE OBSERVED IN UPLOAD: active control/version files already contain RUN249R Siam semantic cleanup state  
NEXT RUN: RUN250R SIAM DATA-PURITY / READABILITY SEMANTICS CLEANUP OR SOURCE-TRUTH RECONCILIATION  
NEXT LIVE TEST: RUN251R  
DECISION: TEST FIRST

## Executive Summary

RUN249R was treated as a compile-repair run only. The user-supplied MetaEditor errors identified two compile-contract defects in `mt5/runtime/ASC_Dispatcher.mqh`:

1. `telemetry` was referenced inside `ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication()` but that function did not receive an `ASC_HeartbeatTelemetry &telemetry` parameter.
2. `ASC_RunWriteLane()` called `ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication()` with six arguments while the callee accepted only five.

The repair aligned the Top5PerBucket mirror service signature with the already-patched GlobalTop10 mirror service and the existing callsite. No generated output files were edited. No Symbol Data Packs, Dossiers, Market Board runtime files, Scanner Status runtime files, Manifest runtime files, FunctionResults logs, Experts logs, or Journal logs were touched.

MetaEditor compile was not available in this environment. This patch removes the visible source-level mismatch, but clean compile remains outstanding.

## Section 0 — Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN249R |
| primary mode | DEBUG |
| secondary mode | PATCH |
| reason | compile repair after RUN248/RUN249 control contradiction |
| live run? | no |
| runtime/output artifacts expected? | no |
| source editing allowed? | yes, compile repair only |
| generated output editing allowed? | no |
| generated output cleanup allowed? | no |
| FileIO rewrite allowed? | no |
| final path mutation allowed? | no |
| current route membership change allowed? | no |
| archive-as-current-truth allowed? | no |
| GlobalTop10 route behavior patch allowed? | no, preserved |
| archive contract rewrite allowed? | no, preserved |
| heartbeat scheduler redesign allowed? | no, preserved |
| Siam semantic cleanup allowed? | no new semantic cleanup in this run |
| L3 behavior/gate change allowed? | no |
| L4 ranking/order/formula change allowed? | no |
| HUD patch allowed? | no |
| Dossier architecture rewrite allowed? | no |
| strategy/signal/trade/risk patch allowed? | no |
| next source run | RUN250R |
| next live test | RUN251R |
| production-ready claim allowed? | no |
| edge claim allowed? | no |
| signal/trade permission allowed? | no |
| final serious decision | TEST FIRST |

## Evidence Ceiling

| Evidence Item | Class | What It Supports | What It Does Not Support |
|---|---:|---|---|
| User-pasted MetaEditor errors | 4 | The listed compile blockers occurred in the user's compile attempt | Does not prove all other compile errors are absent |
| Direct source inspection in this run | 3 | The observed Dispatcher signature/callsite mismatch existed in the upload | Does not prove MetaEditor compile clean |
| Static grep/diff checks after patch | 3 | The targeted source mismatch was textually repaired | Does not prove compiler acceptance |
| MetaEditor compile output | not supplied | none | Clean compile remains outstanding |
| Runtime/live proof | not run | none | No heartbeat/archive/runtime/readability/live proof |

## Required Read Order Result

All required files listed in the RUN249R prompt were present and inspected at least for owner/boundary relevance. `ASC_DossierWriter.mqh`, `ASC_FileIO.mqh`, `ASC_SelectionFilter.mqh`, `ASC_ShortlistSelectionEngine.mqh`, and `ASC_HUD_Manager.mqh` were treated as read-only boundary owners.

## Internet / External Research Conversion Ledger

| Source URL / Citation | Finding | Aurora Risk | Converted Compile Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|
| https://www.mql5.com/en/docs/basis/function/call | MQL5 checks the number and type of arguments passed to a function at execution/compile contract level. | A six-argument call to a five-parameter function blocks compile. | `ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication` must accept the telemetry parameter already passed by `ASC_RunWriteLane`, or the callsite must be reduced. | MetaEditor no longer reports wrong parameter count at the Top5 mirror callsite. | MetaEditor still reports wrong parameter count for the same function. |
| https://www.mql5.com/en/docs/basis/variables/local | A local variable's scope is limited to the function where it is declared. Variables must be declared before use. | Referencing `telemetry` inside Top5 service without a local declaration or parameter blocks compile. | Use the same `ASC_HeartbeatTelemetry &telemetry` parameter pattern already used by the GlobalTop10 mirror service. | MetaEditor no longer reports undeclared identifier `telemetry` at the listed Top5 lines. | MetaEditor still reports undeclared `telemetry` in `ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication`. |
| https://www.mql5.com/en/docs/event_handlers/ontimer | Timer events do not stack when a Timer event is already queued or being processed. | Removing RUN248 defer/yield telemetry to force compile would hide timer pressure and damage heartbeat proof. | Do not delete RUN248 archive telemetry fields or budget/defer guards. Preserve telemetry and pass the telemetry object into the Top5 service. | Static diff shows no heartbeat scheduler redesign and no deletion of archive telemetry block. | RUN248 defer/cap/telemetry fields are removed or heartbeat scheduling is rewritten. |
| https://www.mql5.com/en/docs/files/fileopen and https://www.mql5.com/en/docs/files/filemove | MQL5 file operations are sandboxed and FileMove has strict parameters and overwrite behavior. | A compile repair must not guess file success, mutate FileIO, or rewrite archive/final-path behavior. | No FileIO, final path, archive contract, or generated output edit in RUN249R. | Diff excludes `mt5/io/ASC_FileIO.mqh` and generated evidence folders. | Any FileIO/final path/generated evidence mutation appears in the package. |

Research does not prove source correctness. It only constrained the repair: match function contracts, respect variable scope, preserve timer/yield intent, and avoid FileIO/output mutation.

## Compile Error Target Table

| Compile Blocker | File / Line From User | Root Suspect | Expected Owner | Patch Direction | Result |
|---|---|---|---|---|---|
| `telemetry` undeclared | `ASC_Dispatcher.mqh:15937` | variable out of scope | Dispatcher Top5 SDP mirror service | pass correct telemetry object by reference | patched |
| `telemetry` undeclared | `ASC_Dispatcher.mqh:15938` | variable out of scope | Dispatcher Top5 SDP mirror service | same | patched |
| `telemetry` undeclared | `ASC_Dispatcher.mqh:15939` | variable out of scope | Dispatcher Top5 SDP mirror service | same | patched |
| `telemetry` undeclared | `ASC_Dispatcher.mqh:15941` | variable out of scope | Dispatcher Top5 SDP mirror service | same | patched |
| `telemetry` undeclared | `ASC_Dispatcher.mqh:15944` | variable out of scope | Dispatcher Top5 SDP mirror service | same | patched |
| `telemetry` undeclared | `ASC_Dispatcher.mqh:15945` | variable out of scope | Dispatcher Top5 SDP mirror service | same | patched |
| `telemetry` undeclared | `ASC_Dispatcher.mqh:15948` | variable out of scope | Dispatcher Top5 SDP mirror service | same | patched |
| wrong parameter count | `ASC_Dispatcher.mqh:16290` | callsite/callee mismatch | Top5 SDP mirror service | align callee signature with six-argument callsite | patched |

## Telemetry Scope Repair

| Required Question | Answer |
|---|---|
| What function contains the undeclared `telemetry` references? | `ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication()` |
| Is there a telemetry struct/object nearby with a different name? | The canonical object type is `ASC_HeartbeatTelemetry`; `ASC_RunWriteLane()` already has an in-scope `telemetry` object and passes it to GlobalTop10. |
| Did RUN248 intend runtime state, heartbeat builder, local buffer, FunctionResults, or pass-by-reference struct? | The code mirrors GlobalTop10 archive-history telemetry and writes into the heartbeat telemetry struct by reference. |
| Was `telemetry` declared in another function but not this one? | Yes. It is in the write-lane/heartbeat path and already passed to `ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication()`. |
| Should this block use an existing local variable name instead? | No other local variable in the Top5 function owns these fields. |
| Should a local telemetry object be declared here? | No. A local object would not feed heartbeat telemetry output. Passing by reference preserves owner flow. |
| Are the fields log/header fields or runtime state fields? | They are heartbeat telemetry fields describing archive-history attempt/save/defer/failure/nonblocking state. |
| Can the repair preserve RUN248 telemetry without changing behavior? | Yes. Add `ASC_HeartbeatTelemetry &telemetry` to the Top5 service signature. |
| Does the fix compile without broad Dispatcher signature changes? | It removes the visible mismatch. MetaEditor compile is still required for proof. |

## Patch Applied

Only this source compile contract changed:

```mql5
bool ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication(ASC_RuntimeState &state,
                                                             const datetime now_utc,
                                                             const ulong beat_start_us,
                                                             const int beat_budget_ms,
                                                             ASC_HeartbeatTelemetry &telemetry,
                                                             string &yield_reason)
```

The existing callsite already matched this six-argument contract:

```mql5
ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication(state, now_utc, beat_start_us, beat_budget_ms, telemetry, yield_reason);
```

The repair intentionally follows the existing GlobalTop10 mirror publication pattern, which already accepted `ASC_HeartbeatTelemetry &telemetry` and used the same archive-history telemetry fields.

## Top5 SDP Mirror Signature Repair

| Check | Result |
|---|---|
| Declaration/definition inspected | yes |
| All callsites inspected | one active callsite in `ASC_RunWriteLane()` |
| Callsite/callee after patch | both six arguments |
| Extra argument removed? | no; would destroy RUN248 telemetry intent |
| GlobalTop10 behavior changed? | no |
| Top5 route membership changed? | no |
| FileIO/final path touched? | no |
| Archive contract rewritten? | no |
| Siam semantic cleanup performed? | no new semantic cleanup |

## Contradiction Ledger

| Claim A | Claim B | Source for A | Source for B | Evidence Rank A | Evidence Rank B | Which Outranks / Why | Resolver | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| RUN249R should be compile repair before Siam semantics, based on RUN248 baseline. | Uploaded active control/version files already identify RUN249R as Siam semantic cleanup and RUN250R as live proof. | User prompt | `ASC_Version.mqh`, office/control files, existing `RUN249R_REPORT.md` | 2/4 for reported compile errors | 3 for direct source/control inspection | Current source/control proves the uploaded package is not a clean RUN248 baseline. User compile errors still outrank source optimism for the listed blockers. | RUN250R must reconcile whether Siam cleanup is already present before further semantic work. No reversion attempted without RUN248 source truth. | Roadmap/source-truth caution yes; compile repair allowed. |
| Top5 service should accept five params. | Top5 callsite passes six params and body references `telemetry`. | Compiler error / current signature | Dispatcher callsite and function body | 4/3 | 3 | Body + callsite show RUN248 intended telemetry flow. Five-param signature is the broken contract. | Add telemetry reference parameter to Top5 service. | No after patch, compile retest required. |

## Boundary Verification

| Boundary | Status |
|---|---|
| Generated Symbol Data Packs edited | no |
| Generated Dossiers edited | no |
| Market Board runtime evidence edited | no |
| Scanner Status runtime evidence edited | no |
| Manifest runtime evidence edited | no |
| FunctionResults runtime logs edited | no |
| FileIO rewritten | no |
| final paths mutated | no |
| current route membership changed | no |
| GlobalTop10 route behavior changed | no |
| archive contract rewritten | no |
| heartbeat scheduler redesigned | no |
| L3 gates changed | no |
| L4 rank/order/formula changed | no |
| HUD changed | no |
| Dossier architecture changed | no |
| strategy/signal/trade/risk changed | no |

## Static Validation Performed

| Validation | Result | Evidence Ceiling |
|---|---|---|
| `grep` for Top5 service references | one function definition, one callsite, one callsite label constant | source inspection only |
| Signature/callsite parameter alignment | six-argument callsite now matches six-parameter callee | source inspection only |
| Undeclared `telemetry` root cause | Top5 body now receives `ASC_HeartbeatTelemetry &telemetry` | source inspection only |
| Package scope review | changed-files package excludes generated runtime artifacts | package inspection only |
| MetaEditor compile | not available / not run | outstanding |

## Two-Brain Check

| Brain | Constraint Converted | Result |
|---|---|---|
| Coding Brain | Source owner and function contract must be repaired directly; no fake proof from static inspection. | Applied. Compile proof still required. |
| Trading Brain | Data/telemetry cleanliness and compile repair do not create signal, trade, risk, prop-firm, edge, or production permission. | Preserved. |

## Changed Files

| File | Change | Boundary |
|---|---|---|
| `mt5/runtime/ASC_Dispatcher.mqh` | Added `ASC_HeartbeatTelemetry &telemetry` to the Top5PerBucket SDP mirror publication service signature. | compile-contract repair only |
| `mt5/core/ASC_Version.mqh` | Aligned active run identity to RUN249R compile repair / RUN250R Siam cleanup / RUN251R live proof. | compile-visible control only |
| `office/ROADMAP_STATUS.md` | Updated active status to RUN249R compile repair and recorded source-baseline contradiction. | control only |
| `office/WORK_LOG.md` | Recorded compile repair, contradiction, and static validation. | control only |
| `office/CHANGE_LEDGER.md` | Recorded changed files and protected boundaries. | control only |
| `office/DECISIONS.md` | Recorded decisions, rejected scopes, and compile-proof boundary. | control only |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | Updated handoff to RUN250R Siam/source-truth reconciliation before RUN251R live proof. | control only |
| `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | Updated exact package contents for RUN249R compile repair. | manifest only |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN249R_REPORT.md` | Replaced prior RUN249R semantic report with compile-repair report matching current user scope. | report only |

## What Remains Unproven

- Clean MetaEditor compile.
- Absence of additional compile errors outside the two supplied blockers.
- Runtime heartbeat behavior.
- Archive-history runtime behavior.
- Symbol Data Pack publication behavior.
- Siam readability semantics.
- Live output correctness.
- Production readiness.
- Any trading edge, signal, execution, risk, or prop-firm permission.

## Next Move

Copy the changed files into the active MT5 compile tree and run MetaEditor compile. If compile is clean, RUN250R should reconcile the existing Siam semantic source state against the intended RUN250R scope before any live proof. RUN251R remains the next live test unless explicitly overridden.

## Final Decision

TEST FIRST.
