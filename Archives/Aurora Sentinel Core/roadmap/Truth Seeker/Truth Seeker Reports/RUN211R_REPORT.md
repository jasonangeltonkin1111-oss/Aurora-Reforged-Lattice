# RUN211R_REPORT.md

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN211R / SOURCE DEBUG FROM RUN210 READ-ONLY EVIDENCE — FIX SDP FINAL ROUTE PUBLICATION AND RECONCILIATION OBSERVABILITY WITHOUT TOUCHING LIVE OUTPUT DATA
MODE: DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN211R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN211R.zip
DECISION: TEST FIRST
```

```text
FINAL SUMMARY

RUN210 output was used as read-only evidence intake only and was not modified, regenerated, cleaned, renamed, deleted, or packaged.

Source root cause found: RUN210 proved the Symbol Data Pack composer/payload semantics alive in flat/staging/archive outputs, but active source did not defensibly prove final route publication after staging because the route writer had no post-promote final readback verification or staging-to-final recovery path. A second root cause was observability: reconciliation proof text was appended to route lifecycle state, but Manifest/Scanner Status/FunctionResults primarily emitted writer_reason/last_writer_reason and could swallow final_set_reconcile details.

Source/control patch applied: ASC_SymbolDataPackWriter.mqh now verifies final route readback after final publish, exposes final_readback/fallback diagnostics, and performs a bounded fallback from already validated staging candidate to the same final route path if primary final write/readback fails. ASC_Dispatcher.mqh now forwards route_lifecycle_reason into Manifest runtime status and FunctionResults log rows. ASC_ScannerStatusWriter.mqh now exposes route lifecycle/reconciliation reason fields in Scanner Status. ASC_Version.mqh was advanced to RUN211R. Control/report files were updated.

Changed files: mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh, mt5/runtime/ASC_Dispatcher.mqh, mt5/artifacts/ASC_ScannerStatusWriter.mqh, mt5/core/ASC_Version.mqh, roadmap/Truth Seeker/Truth Seeker Reports/RUN211R_REPORT.md, roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md, roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md, office/ROADMAP_STATUS.md, office/WORK_LOG.md, office/CHANGE_LEDGER.md, office/DECISIONS.md.

Untouched: RUN210 runtime output evidence, generated Symbol Data Pack files, generated Dossier files, generated Manifest/Scanner/FunctionResults runtime evidence, Experts/Journal logs, FileIO, final/staging/archive path constants, membership/ranking/formula logic, HUD, Market Board, strategy/signal/trade/risk logic, and RUN207 data-purity semantics.

Still unproven until MetaEditor compile and next live retest: compile success, runtime behavior, final GlobalTop10 route population, final Top5PerBucket/crypto route population, fallback behavior if needed, reconciliation field visibility in Manifest/Scanner Status/FunctionResults, and broker/session-specific repeatability.

RUN207 data-purity semantics were preserved. RUN206 reconciliation safety was preserved and made more observable; empty expected-set no-delete logic was not changed.

Exact next move: compile the RUN211R source package, then run a bounded RUN212R live retest that checks final route folders plus reconciliation_route/reconciliation_bucket/reconciliation_state/reconciliation_expected_count/reconciliation_found_final_count/reconciliation_first_failure_reason on Manifest, Scanner Status, and FunctionResults. Final serious decision: TEST FIRST.
```

## SECTION 0 — MODE LOCK

| Declaration | Required Answer | RUN211R Answer |
|---|---|---|
| current run | RUN211R | RUN211R |
| primary mode | DEBUG | DEBUG |
| secondary mode | PATCH | PATCH |
| live run? | no | no |
| runtime/output artifacts expected? | no new runtime output | no new runtime output |
| RUN210 output used? | yes, read-only evidence intake only | yes |
| source editing allowed? | yes, only if root cause is proven by source + RUN210 evidence | yes |
| live output editing allowed? | no | no |
| production-ready claim allowed? | no | no |
| edge claim allowed? | no | no |
| signal/trade permission allowed? | no | no |
| final serious decision | PROCEED / HOLD / KILL / TEST FIRST | TEST FIRST |

## Evidence Ladder

| Evidence | Class | Used For | Ceiling |
|---|---:|---|---|
| User RUN211R prompt | 2 | scope/boundary/request | request evidence only |
| RUN210 generated output/report | 7/8 within observed broker/server/session | symptoms and negative proof | no source proof by itself |
| Direct source/package inspection | 3 | root-cause source debugging | no compile/runtime proof |
| MetaEditor compile output | unavailable | none | not claimed |

## RUN210 Read-Only Evidence Summary

| RUN210 Finding | Evidence Source | Evidence Rank | Meaning | Source Debug Relevance |
|---|---|---:|---|---|
| RUN207 fields emitted in flat/staging/archive payloads | RUN210 report/output evidence | 7/8 | data-purity output path partly alive | Composer fields likely work; preserve |
| zero-sample windows output no_sample | RUN210 report/output evidence | 7/8 | fake zero defect improved | keep intact |
| last_price_available/status/raw emitted | RUN210 report/output evidence | 7/8 | last price semantics improved | keep intact |
| CopyTicks cap/truncation labels emitted | RUN210 report/output evidence | 7/8 | cap semantics improved | keep intact |
| final GlobalTop10 route folder empty | RUN210 report/output evidence | 7/8 | final route publication failed/not promoted/not retained | debug writer/routing/dispatcher |
| final Top5PerBucket/crypto route folder empty | RUN210 report/output evidence | 7/8 | final bucket publication failed/not promoted/not retained | debug writer/routing/dispatcher |
| staging folders contain payloads | RUN210 report/output evidence | 7/8 | staging write path alive | final promote/readback needs hard proof |
| archive folders contain previous payloads | RUN210 report/output evidence | 7/8 | archive path alive | archive is not final truth |
| reconciliation proof fields absent | Manifest/Scanner/FunctionResults from RUN210 | 7/8 | observability path missing | route lifecycle reason was swallowed |
| no source patch applied in RUN210 | RUN210 report | 3/7 | evidence-only run | RUN211 may patch source |

## Root-Cause Answers

1. Flat/staging/archive can exist while final route folders are empty because staging and archive are independent helper writes and are not proof of final current publication.
2. Final route writer is called in source for GlobalTop10 and Top5PerBucket, but it lacked durable final readback/fallback proof after staging success.
3. Final route path constants were not changed; no direct proof showed path constants wrong.
4. Staging written but final missing is consistent with final promotion/write/readback failure or later reconciliation deleting unexpected children.
5. Reconciliation safety delete guard remains source-present; empty expected set still defers deletion.
6. Expected membership remains source-owned and was not moved.
7. Dispatcher calls final route family services, but observable proof was incomplete.
8. Flat legacy root is not final route proof.
9. Final route folders are expected to populate through bounded family cycles, not from archive/staging counts.
10. Weekend/session/no-membership can defer publication, but RUN210 staging/archive payloads show route work happened, so final route exactness still failed.
11. Reconciliation proof fields were absent because final_set_reconcile text lived in route last_reason but surfaces emitted writer_reason/last_writer_reason.
12. Proof fields were generated locally by writer/reconcile code but not reliably forwarded to observer surfaces.
13. Generic success/failure fields could hide reconciliation details.
14. FunctionResults log used writer_reason only for route family rows.
15. Manifest/Scanner Status did not consume route lifecycle/reconciliation state strongly enough.
16. Source owner deciding final route publication remains dispatcher + SDP writer using existing GlobalTop10/Top5 source-owned snapshots.

## Multi-Domain Research Ledger

| Research Lane | Source / Authority | Finding | Converted Source Constraint | Falsifier |
|---|---|---|---|---|
| MQL5 file enumeration | Official MQL5 FileFindFirst/FileFindNext/FileFindClose docs | Enumeration returns names from sandbox and search handles must be closed. | Cleanup/reconciliation must expose route/bucket/found/expected/unexpected/archive/delete fields and close handles. | Missing reconciliation fields or unclosed enumeration path. |
| MQL5 file publication | Official MQL5 FileOpen/FileWrite/FileClose/FileMove/FILE_REWRITE docs family | File writes/promotions require explicit path handling and error visibility. | Final publish must verify readback and keep GetLastError-derived first failure visible. | Final folder empty while status claims clean success. |
| MQL5 errors | Official MQL5 GetLastError/ResetLastError docs | GetLastError does not reset automatically; ResetLastError before checked calls. | Failure reasons must not be generic when file operations fail. | Generic success/failure hides final route failure. |
| MQL5 timer cadence | Official MQL5 OnTimer/EventSetTimer docs | Timer events are periodic EA events; missed/queued behavior cannot prove output exactness alone. | Do not infer route correctness from one due/cadence status; check final files and logs. | Status says due/complete but route folder empty. |
| Secure SDLC | Evidence-preservation discipline | Submitted runtime evidence must remain immutable. | RUN210 output is intake-only and excluded from package. | Any generated output file modified or packaged. |
| Threat modeling | Boundary contracts | Evidence/source/final/staging/archive/membership/logging boundaries must not leak ownership. | No output edits, no path mutation, no membership source change. | Patch derives membership from filesystem or archive. |
| Observability/SRE | Durable proof fields | Current truth and first failure reason must be visible externally. | Emit route_lifecycle_reason to Manifest, Scanner Status, and FunctionResults. | reconciliation_* still absent next live run. |
| Data-quality semantics | RUN207 evidence | no_sample/last/cap/absence are factual data-purity fields, not signal fields. | Do not change Composer/Contracts data-purity semantics. | Field missing/regressed or signal wording added. |

## Brain Guidebook / Two-Brain Check

| Guidebook | Read? | Key Rule Extracted | Converted Source Constraint | Falsifier |
|---|---:|---|---|---|
| AURORA_GUIDEBOOK_INDEX.md | yes | Guidebooks are required serious-run intake. | Report includes guidebook/two-brain check. | report omits guidebook intake |
| AURORA_CODING_BRAIN_GUIDEBOOK.md | yes | Patch active owners surgically and protect source truth. | Writer/Dispatcher/Scanner only; no FileIO/path/rank/membership mutation. | broad rewrite or forbidden source touched |
| AURORA_TRADING_BRAIN_GUIDEBOOK.md | yes | Data infrastructure is not trade permission. | No signal/trade/execution/risk logic or wording. | output implies trading readiness |

### Brain 1 — Builder

- Smallest final-route patch: add final readback verification and bounded staging-candidate fallback inside the existing SDP writer.
- Smallest proof patch: forward route_lifecycle_reason, which carries final_set_reconcile details, to Manifest/Scanner Status/FunctionResults.
- Responsible source owners: ASC_SymbolDataPackWriter.mqh and ASC_Dispatcher.mqh, with Scanner Status as observer.
- RUN207 fields preserved: no_sample, last_price_available/status/raw, copy_ticks cap/truncation, absence_state/reason.
- RUN210 evidence files remain read-only and excluded.

### Brain 2 — Auditor

- Output mutation risk blocked by package law and no generated evidence edits.
- Valid-child deletion risk controlled by unchanged empty expected-set no-delete guard.
- Path mutation risk avoided; no final/staging/archive constants changed.
- Flat/staging/archive payload generation preserved; Composer/Contracts untouched.
- Reconciliation swallow risk patched by route_lifecycle_reason propagation.
- Membership/ranking source unchanged.
- No signal/trade permission added.
- Broad rewrite avoided.

## Boundary Contract / Protected Lattice

| Boundary | System A | System B | Lawful Interface | Source Of Truth | Allowed Crossing | Forbidden Crossing | Acceptance Criteria | HOLD / KILL Condition |
|---|---|---|---|---|---|---|---|---|
| RUN210 evidence ↔ RUN211 source patch | live output files | active source files | evidence intake only | output is evidence, source is patch target | findings/counters/paths | editing output data | output untouched | any output mutation |
| staging ↔ final route folders | staging candidate | final current route folder | promotion/publication path | source writer/dispatcher | valid payload promotion | staging counted as final | final folder populated next live | path mutation/fake final |
| archive ↔ final truth | archive previous | final current | continuity evidence only | final folder/source membership | previous-copy evidence | archive as current truth | archive not used as final | archive counted as final |
| membership ↔ expected set | L4/Dossier | SDP reconciliation | source-owned membership | existing snapshots | expected symbols | filesystem-derived membership | expected set source-owned | expected set from output folders |
| writer reason ↔ proof surfaces | writer/reconcile | FunctionResults/Scanner/Manifest | reason propagation | source logger/status | route/bucket/count/failure fields | generic success hiding failure | fields visible next live | proof swallowed |
| data-purity fields ↔ Siam | SDP payload | Siam reader | factual data only | Aurora source | no_sample/last/cap/absence facts | signal/trade readiness | fields preserved | signal wording |

## Source Inspection Table

| Source Area | File | What Was Verified | PASS / HOLD / FAIL | Patch Needed? |
|---|---|---|---|---:|
| final route path resolution | ASC_SymbolDataPackWriter.mqh | GlobalTop10/Top5 target helpers already resolve route folders | PASS | no |
| final route write/promotion | ASC_SymbolDataPackWriter.mqh | final write existed but lacked final readback/fallback proof | HOLD→PATCHED | yes |
| dispatcher callsite | ASC_Dispatcher.mqh | family services called but proof surfaces used writer_reason | HOLD→PATCHED | yes |
| membership expected set | Dispatcher state snapshots | existing snapshot membership used; not changed | PASS | no |
| reconciliation no-delete guard | ASC_SymbolDataPackWriter.mqh | empty expected set defers with no_committed_membership_no_delete | PASS | no |
| reconciliation proof generation | ASC_SymbolDataPackWriter.mqh | proof strings generated | PASS | no |
| proof propagation | Dispatcher / Scanner | route lifecycle/reconcile reason not emitted strongly enough | FAIL→PATCHED | yes |
| data-purity fields | Composer / Contracts | RUN207 fields source-present and live-observed | PASS | no |
| FileIO | ASC_FileIO.mqh | read-only only; no rewrite required | PASS | no |

## Patch Ledger

| File | Change | Reason | Risk Control |
|---|---|---|---|
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh | Added final readback verification and bounded validated-staging-to-final fallback; added final_readback/fallback diagnostics. | RUN210 staging/archive alive but final route empty. | no path/FileIO/membership/Composer changes |
| mt5/runtime/ASC_Dispatcher.mqh | Emitted route_lifecycle_reason in runtime status and FunctionResults rows. | Reconciliation proof was swallowed from observer surfaces. | no cadence/rank/HUD/trade changes |
| mt5/artifacts/ASC_ScannerStatusWriter.mqh | Added route_lifecycle_reason and SDP route lifecycle proof fields. | Scanner Status lacked reconciliation_* visibility. | observer-only patch |
| mt5/core/ASC_Version.mqh | Advanced compile-visible run identity to RUN211R. | package/control alignment. | no runtime logic |
| control/report files | Recorded RUN211R boundary, patch, and next retest. | auditability. | no generated outputs |

## Static Compile-Risk Sweep

| Static Check | Result | Evidence | Patch Needed? |
|---|---|---|---:|
| missing include risk | PASS | Writer already includes FileIO where verification/fallback helpers live. | no |
| undefined helper risk | PASS | ASC_VerifyPublicationPayloadReadback and ASC_CopyTextFileAtomic exist in ASC_FileIO.mqh. | no |
| duplicate function/macro risk | PASS | no new functions/macros added. | no |
| string quote/escape risk | PASS | primitive quote/brace/paren balance checked. | no |
| StringFormat argument mismatch risk | PASS | no new StringFormat calls added. | no |
| enum/route mismatch risk | PASS | existing route enum usage unchanged. | no |
| bool/string conversion risk | PASS | ternary string conversions used for bool text. | no |
| reason string length/truncation risk | HOLD | route_lifecycle_reason can be long when reconciliation detail lists many buckets. | next live check should verify surfaces do not truncate critical fields |
| final path mutation risk | PASS | no path constants changed. | no |
| output evidence mutation risk | PASS | no generated output edited. | no |
| reconciliation safety regression risk | PASS | prune/delete logic unchanged. | no |
| RUN207 data-purity regression risk | PASS | Composer/Contracts untouched. | no |
| signal/trade wording risk | PASS | no signal/trade/risk logic or permission added. | no |

No MetaEditor compile output was supplied; compile proof is not claimed.

## Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| Route mirror source path exists | RUN210 final route folders empty | source inspection | RUN210 output/report | 3 | 7/8 | RUN210 output outranks source intention for runtime symptom | add final readback/fallback and retest | TEST FIRST |
| Reconciliation fields source-present | Manifest/Scanner/FunctionResults lack reconciliation fields | source inspection | RUN210 output/report | 3 | 7/8 | RUN210 output outranks source-local proof | propagate route_lifecycle_reason to observer surfaces | TEST FIRST |
| Staging/archive payloads exist | final current route is empty | RUN210 output/report | RUN210 output/report | 7/8 | 7/8 | both true in different route families | never count staging/archive as final | TEST FIRST |

## Output Evidence Non-Mutation Statement

No RUN210 runtime output data was edited, renamed, regenerated, deleted, cleaned, or packaged. No generated Symbol Data Pack, Dossier, Manifest, Scanner Status, FunctionResults, Experts, or Journal file was modified.

## Package Validation Table

| Check | Result |
|---|---|
| package name exactly TRUTH_SEEKER_RUN211R.zip | PASS |
| changed files only | PASS |
| original folder layout preserved | PASS |
| RUN211R_REPORT.md included | PASS |
| RUN210 runtime output excluded | PASS |
| generated Symbol Data Packs excluded | PASS |
| generated Dossiers excluded | PASS |
| generated Manifest/Scanner/FunctionResults evidence excluded | PASS |
| Experts/Journal logs excluded | PASS |
| whole repo excluded | PASS |

## Next Live Retest Seed

RUN212R must compile first, then run live and verify:

1. `Symbol Data Packs/GlobalTop10` has current expected children.
2. `Symbol Data Packs/Top5PerBucket/crypto` has current expected children.
3. `final_readback_verified=true` appears for route writes or failure/fallback reason is explicit.
4. `route_lifecycle_reason` appears in Manifest, Scanner Status, and FunctionResults.
5. `reconciliation_route`, `reconciliation_bucket`, `reconciliation_state`, `reconciliation_expected_count`, `reconciliation_found_final_count`, and `reconciliation_first_failure_reason` are visible after family cycle completion.
6. RUN207 no_sample/last/cap/absence semantics remain present.
7. No signal/trade/execution/risk permission appears.

Final serious decision: **TEST FIRST**.
