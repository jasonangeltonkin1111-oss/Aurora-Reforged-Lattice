# RUN215R_REPORT

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN215R / LIVE FINAL-ROUTE RECONCILIATION + SIAM DATA-PURITY PROOF — VERIFY RUN211/RUN213/RUN214 SOURCE-CONTROL GATES IN REAL OUTPUT
MODE: LIVE EVIDENCE REVIEW + DEBUG
DECISION: HOLD
REPORT: RUN215R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN215R.zip
```

```text
FINAL SUMMARY

- RUN215R inspected supplied live generated runtime evidence from Upcomers-Server and kept output evidence read-only and unmodified.
- RUN215R proved live, within the supplied Upcomers server / crypto-weekend evidence boundary, that Symbol Data Pack GlobalTop10 final route folders populated with 10 child files and Top5PerBucket/crypto final route folders populated with 5 child files.
- RUN215R proved live that generated Symbol Data Pack child files contain RUN207 Siam data-purity fields across all 15 inspected final route child files: tick/spread validity flags, invalid reasons, CopyTicks requested/returned/cap/truncation fields, last_price_available/status/raw, and absence_state/reason.
- RUN215R found no zero-sample spread numeric-zero violation in supplied final route child files; no `last: 0.0000000000` case was found without last_price_available/status/raw semantics.
- RUN215R proved partial durable proof propagation: final_readback/final_fallback tokens and route_lifecycle_reason are visible in Artifact Bundle Manifest and Scanner Status; FunctionResults carries many path/failure records but did not expose route_lifecycle_reason in the inspected supplied log.
- RUN215R did not prove full reconciliation observability because exact reconciliation_* fields were absent from the inspected durable surfaces; only generic expected/found/skipped tokens and proof-bundle status were visible.
- RUN215R did not receive MetaEditor compile output, Experts log, Journal log, or broker/server/session context note beyond the Upcomers-Server folder naming and runtime timestamps, so compile proof and broader broker/session proof remain absent.
- RUN215R found the runtime proof bundle itself says proof_bundle_complete=false with a missing-surface blocker around globaltop10_archive/dossiers. This blocks PROCEED.
- RUN215R applied no source patch and did not edit generated evidence.
- Exact next move: HOLD. Run a controlled RUN216R evidence-completion retest or evidence supplement that supplies MetaEditor compile output, Experts/Journal logs if available, broker/server/session note, GlobalTop10 archive evidence or lawful not-applicable proof, and exact reconciliation_* durable fields. Do not patch source unless the completed evidence proves a source owner defect.
```

## Section 0 — Mode Lock

| Declaration | Required Answer | RUN215R Result |
|---|---|---|
| current run | RUN215R | RUN215R |
| primary mode | LIVE EVIDENCE REVIEW | LIVE EVIDENCE REVIEW |
| secondary mode | DEBUG | DEBUG |
| live run? | yes | yes, generated Upcomers-Server runtime evidence supplied |
| generated output evidence expected? | yes | yes |
| generated output editing allowed? | no | no edits performed |
| source patch allowed? | no | no source patch applied |
| production-ready claim allowed? | no | no claim made |
| edge claim allowed? | no | no claim made |
| signal/trade permission allowed? | no | no permission found/issued |
| final decision | PROCEED / HOLD / KILL / TEST FIRST | HOLD |

## Section 1 — Required Read Order / Context Intake

All required source/control/report/guidebook files in the supplied source zip were present except: none.

`ASC_Version.mqh` shows compile-visible identity as RUN214R final source gate and next live proof as RUN215R. Evidence ceiling: source/control inspection is Class 3 unless compile output is supplied.

## Section 2 — Live Evidence Intake Table

| Evidence Item | Supplied? | Path / Source | Evidence Rank | Usable For | Limitation |
|---|---:|---|---:|---|---|
| TRUTH_SEEKER_RUN214R / active source state | yes | Aurora Sentinel Core zip | 3 | source baseline | no runtime proof by itself |
| MetaEditor compile output | no | not supplied | n/a | none | no compile proof |
| GlobalTop10 final route folder | yes | Upcomers-Server/Symbol Data Packs/GlobalTop10 | 7/8 | final route publication proof | broker/session bounded |
| Top5PerBucket/Crypto final route folder | yes | Upcomers-Server/Symbol Data Packs/Top5PerBucket/crypto | 7/8 | final bucket publication proof | crypto/weekend bounded |
| staging folders | yes | Upcomers-Server/Symbol Data Packs/_staging/... | 7/8 | staging candidate proof | not current final truth |
| archive folders | partial | Top5 dossier archive supplied; GlobalTop10 archive absent | 7/8 | archive/continuity proof | incomplete |
| generated GlobalTop10 child files | yes | 10 files | 7/8 | RUN207 fields + route proof | bounded |
| generated Top5PerBucket/Crypto child files | yes | 5 files | 7/8 | RUN207 fields + bucket proof | bounded |
| Artifact Bundle Manifest | yes | Upcomers-Server/Artifact Bundle Manifest.txt | 7/8 | bundle/proof visibility | says proof bundle incomplete |
| Scanner Status | yes | Upcomers-Server/Scanner Status.txt | 7/8 | lifecycle/proof visibility | says proof bundle incomplete |
| FunctionResults | yes | Upcomers-Server/Workbench/logs/function_results.log | 7/8 | function-level log evidence | route_lifecycle_reason absent in inspected log |
| Experts log | no | not supplied | n/a | none | no terminal Experts proof |
| Journal log | no | not supplied | n/a | none | no platform Journal proof |
| broker/server/session context | partial | Upcomers-Server name + runtime timestamps | 7/8 | interpretation | no explicit broker note supplied |

## Section 3 — Compile Check

| Compile Check | Result | Evidence | Meaning |
|---|---|---|---|
| compile succeeded | unproven | no MetaEditor compile output supplied | cannot claim RUN214 source compiles |
| errors count | unknown | not supplied | compile blockers may still exist |
| warnings count | unknown | not supplied | warning state unproven |
| touched files referenced | unknown | not supplied | no compiler path evidence |
| undefined helper risk | not cleared | no compile output | remains unproven |
| struct field mismatch risk | not cleared | no compile output | remains unproven |
| StringFormat/string literal risk | not cleared | no compile output | remains unproven |
| implicit conversion warnings | not cleared | no compile output | remains unproven |

Runtime output proves an EA produced files after the source-control chain, but it does **not** replace compile proof.

## Section 4 — Multi-Domain Research Ledger

Research supports evidence review only. It does not prove Aurora works.

| Research Lane | Source / Authority | Finding | Converted RUN215 Evidence Check | Falsifier |
|---|---|---|---|---|
| MQL5 / MT5 file mechanics | MetaQuotes MQL5 FileOpen/FileClose/File functions docs | File APIs are explicit open/write/close/find/delete/move operations; readback and promotion must be observable, not assumed. | Require final path, temp path, readback/fallback state, and durable lifecycle reason. | Final folder empty while status says verified. |
| MQL5 runtime/error mechanics | MetaQuotes GetLastError/ResetLastError and timer/event docs | Runtime errors and timer execution are separate from compile success. | Do not claim runtime correctness from compile/source alone; inspect logs/status. | Generic success without error code / first failure reason. |
| Data-quality semantics | Data engineering missingness discipline | Missing data must be explicit; zero must not mean no sample. | Check no_sample semantics, validity flags, last_price_available/status/raw, CopyTicks cap/truncation. | sample_count=0 with numeric min/max/avg zero. |
| Secure SDLC/evidence preservation | NIST SSDF SP 800-218 root cause practice | Root cause should be recorded; evidence must not be mutated to hide defects. | Read-only evidence, exact failure capture, no output edits. | Edited generated files or “fixed” evidence package. |
| Observability / SRE | Google SRE Workbook monitoring guidance | Useful status needs service-level signals, logs, and first failure visibility. | Check lifecycle reason, counters, first failure reason across Manifest/Scanner Status/FunctionResults. | Only generic success/failure is visible. |
| Protected lattice | Aurora doctrine + source/output boundary | Source, generated output, staging, archive, and membership must not leak authority. | Final route is current truth; staging/archive are supporting evidence only. | Staging/archive counted as final current truth. |
| Prompt/execution control | RUN214 checklist | Exact package name and evidence ceiling prevent fake proof. | Package exactly TRUTH_SEEKER_RUN215R.zip; no suffix; no source patch. | Suffixed package or patched evidence. |

## Section 5 — Brain Guidebook / Two-Brain Check

| Guidebook | Read? | Key Rule Extracted | Converted RUN215 Evidence Check | Falsifier |
|---|---:|---|---|---|
| AURORA_GUIDEBOOK_INDEX.md | yes | RUN215 is the live proof boundary; generated evidence is read-only. | Inspect generated files; do not edit or clean output. | Evidence mutation or source proof inflated into live proof. |
| AURORA_CODING_BRAIN_GUIDEBOOK.md | yes | Compile-visible identity and checklist must align before live proof. | Check ASC_Version and required control files; request compile output. | Runtime/status identifies stale run or no compile proof claimed as compile proof. |
| AURORA_TRADING_BRAIN_GUIDEBOOK.md | yes | Publication proof is not edge or trade permission. | Search for signal/trade/permission wording; keep verdict data-only. | Any buy/sell/entry/lot/SLTP permission. |

### Brain 1 — Builder Answers

| Question | Answer |
|---|---|
| What live files prove final route publication? | Final child files in Symbol Data Packs/GlobalTop10 and Symbol Data Packs/Top5PerBucket/crypto plus family/bucket manifests. |
| What live files prove final readback? | Artifact Bundle Manifest and Scanner Status contain final_readback_verified/final_readback_reason tokens. |
| What live files prove fallback state? | Artifact Bundle Manifest and Scanner Status contain final_fallback_state/final_fallback_reason tokens; observed state is not_attempted where final readback succeeded. |
| What live files prove reconciliation observability? | Only partial generic expected/found/skipped and proof-bundle status; exact reconciliation_* fields were not found. |
| What live files prove RUN207 data-purity semantics? | 15 final-route Symbol Data Pack child files contain all required RUN207 fields. |
| What live evidence is enough for bounded proof? | Enough to prove current final folder population and child data-purity field presence for supplied Upcomers crypto/global evidence; not enough for compile or full reconciliation proof. |

### Brain 2 — Auditor Answers

| Risk Question | Auditor Finding |
|---|---|
| What could fake final folder success? | Staging/archive copied into final or stale extras. Folder timestamps and manifests support current publication, but expected-symbol reconciliation exact fields are incomplete. |
| What could hide stale child files? | Missing canonical latest/superseded markers and incomplete reconciliation fields. |
| What could hide archive/delete failure? | Proof bundle says globaltop10_archive missing; delete/archive proof is incomplete. |
| What could show staging success but final failure? | Final folders are populated, so not observed here; still needs readback field by route. |
| What could show source fields but missing generated output fields? | RUN207 fields are present in generated children, so this specific risk is cleared for supplied children. |
| What could make compact proof diverge from raw proof? | FunctionResults lacks route_lifecycle_reason in inspected log; compact/raw propagation is not fully proven across all durable surfaces. |
| What could create signal/trade permission? | Status prose contains negative boundary vocabulary around entry/buy/sell, but SDP children contain no forbidden permission wording. |
| What could overgeneralize crypto/weekend evidence? | Crypto-only open behavior cannot prove weekday forex/metals/indices/stocks behavior. |

## Section 6 — Final Route Folder Population Check

| Route / Bucket | Folder Supplied? | File Count | Expected Source / Context | PASS / HOLD / FAIL | Notes |
|---|---:|---:|---|---|---|
| GlobalTop10 final | yes | 10 | source-owned GlobalTop10 membership | PASS | 10 child files present. |
| Top5PerBucket/Crypto final | yes | 5 | source-owned crypto bucket membership | PASS | 5 child files present. |
| Top5PerBucket/other buckets final | no / not applicable in supplied evidence | 0 | no supplied non-crypto bucket context | HOLD | Cannot prove other buckets. |
| staging GlobalTop10 | yes | 10 | staging candidate only | PASS | Not counted as final truth. |
| staging Top5PerBucket/Crypto | yes | 5 | staging candidate only | PASS | Not counted as final truth. |
| archive GlobalTop10 | no | 0 | continuity evidence only | HOLD | Runtime proof bundle reports missing globaltop10_archive. |
| archive Top5PerBucket/Crypto | yes | 4 | continuity evidence only | PASS | Dossier archive present; SDP archive not supplied. |

## Section 7 — Final Readback / Fallback Check

| Proof Field / Token | Expected | Found? | Surface | Value / Example | PASS / HOLD / FAIL |
|---|---|---:|---|---|---|
| final_readback_state | yes/equivalent | partial | Manifest / Scanner Status | final_readback_verified=true, final_readback_reason=readback_verified | PASS |
| final_readback_verified | yes | yes | Manifest / Scanner Status | count=4 each | PASS |
| final_readback_reason | yes if failure/defer/success | yes | Manifest / Scanner Status | readback_verified | PASS |
| final_fallback_state | yes | yes | Manifest / Scanner Status | not_attempted | PASS |
| final_fallback_reason | yes if fallback/failure/defer | yes | Manifest / Scanner Status | not_attempted | PASS |
| final_target_path | yes | yes | Manifest / Scanner Status / FunctionResults | final_path tokens visible | PASS |
| staging_path | yes if fallback/staging proof | partial | Manifest / Scanner Status | temp/staging context visible, fallback not used | HOLD |
| first_failure_reason | yes if failure | partial | Manifest / Scanner Status / FunctionResults | counts visible, exact route mapping incomplete | HOLD |

## Section 8 — Route Lifecycle Reason Observability Check

| Surface | route_lifecycle_reason Present? | Compact Prefix Present? | Raw Reason Present? | Critical Tokens Present? | PASS / HOLD / FAIL |
|---|---:|---:|---:|---:|---|
| Scanner Status | yes (4) | partial | yes | partial | HOLD |
| FunctionResults | no | no | no | partial path/failure tokens only | HOLD |
| Artifact Bundle Manifest | yes (2) | partial | yes | partial | HOLD |
| Experts log | not supplied | no | no | no | HOLD |
| Journal log | not supplied | no | no | no | HOLD |

Critical-token note: Manifest/Scanner Status contain route and lifecycle text, but exact expected compact fields such as final_readback= and final_fallback= were not consistently present as compact tokens. FunctionResults did not expose route_lifecycle_reason in the inspected supplied log.

## Section 9 — Reconciliation Observability Check

| Reconciliation Field | Expected | Found? | Surface | Value / Example | PASS / HOLD / FAIL |
|---|---|---:|---|---|---|
| reconciliation_route | yes | no | inspected surfaces | absent exact token | HOLD |
| reconciliation_bucket | yes | no | inspected surfaces | absent exact token | HOLD |
| reconciliation_state | yes | no | inspected surfaces | absent exact token | HOLD |
| reconciliation_current_truth_source | yes | no | inspected surfaces | absent exact token | HOLD |
| reconciliation_expected_count | yes | no | inspected surfaces | absent exact token | HOLD |
| reconciliation_found_final_count | yes | no | inspected surfaces | absent exact token | HOLD |
| reconciliation_expected_symbols | yes / summary | partial | manifests | membership lists visible in family/bucket manifests | HOLD |
| reconciliation_unexpected_symbols | yes / summary | no exact token | inspected surfaces | absent exact token | HOLD |
| reconciliation_archived_count | yes | no exact token | inspected surfaces | archive status partial only | HOLD |
| reconciliation_deleted_count | yes | no exact token | inspected surfaces | absent exact token | HOLD |
| reconciliation_skipped_count | yes | no exact token | inspected surfaces | skipped tokens visible but not reconciliation_* | HOLD |
| reconciliation_first_failure_reason | yes if failure/defer | no exact token | inspected surfaces | first_failure_reason visible elsewhere | HOLD |
| reconciliation_final_path | yes | partial | Manifest / Scanner Status / FunctionResults | final_path visible | HOLD |
| reconciliation_archive_path | yes if archive relevant | partial | Manifest / Scanner Status | archive_path/guard messages visible | HOLD |

Verdict: reconciliation observability is not clean enough. File presence is strong. Exact reconciliation proof schema is incomplete.

## Section 10 — RUN207 Siam Data-Purity Output Check

| RUN207 Field / Rule | Expected In Output? | Found? | Example File | PASS / HOLD / FAIL | Notes |
|---|---:|---:|---|---|---|
| tick_window_60s_valid | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| tick_window_60s_invalid_reason | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| tick_window_300s_valid | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| tick_window_300s_invalid_reason | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| spread_window_60s_valid | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| spread_window_60s_invalid_reason | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| spread_window_300s_valid | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| spread_window_300s_invalid_reason | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| spread_min_points_60s | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| spread_max_points_60s | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| spread_avg_points_60s | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| copy_ticks_requested_limit | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| copy_ticks_return_count | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| copy_ticks_cap_hit | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| copy_ticks_truncation_state | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| last_price_available | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| last_price_status | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| last_price_raw | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| absence_state | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |
| absence_reason | yes | 15/15 | AAVEUSD.nx / route children | PASS | final route children inspected |

| no-sample spread min/max/avg | no numeric zero when sample_count=0 | no violations found | all final route children | PASS | zero-sample numeric-zero violation list: none |
| last=0 semantic repair | last_price_available/status/raw required | no violations found | all final route children | PASS | raw zero had semantic fields where observed |

## Section 11 — Duplicate Route / Asset Identity Observation

| Symbol | GlobalTop10 File? | Top5PerBucket File? | route_family visible? | bucket/asset visible? | Conflict Risk |
|---|---:|---:|---:|---:|---|
| AAVEUSD.nx | yes | yes | yes | Global route bucket not_applicable; Top5 bucket Crypto | Medium: duplicate route consumers need canonical route authority. |
| ALGOUSD.nx | yes | yes | yes | Global route bucket not_applicable; Top5 bucket Crypto | Medium |
| APEUSD.nx | yes | yes | yes | Global route bucket not_applicable; Top5 bucket Crypto | Medium |
| DASHUSD.nx | yes | no | yes | Global route bucket not_applicable | Low/medium |
| EOSUSD.nx | yes | no | yes | Global route bucket not_applicable | Low/medium |
| LTCJPY.nx | yes | no | yes | Global route bucket not_applicable | Low/medium |
| MELUSD.nx | yes | no | yes | Global route bucket not_applicable | Low/medium |
| TRPUSD.nx | yes | no | yes | Global route bucket not_applicable | Low/medium |
| TRXUSD.nx | yes | no | yes | Global route bucket not_applicable | Low/medium |
| XMRUSD.nx | yes | no | yes | Global route bucket not_applicable | Low/medium |
| ADAUSD.nx | no | yes | yes | Top5 bucket Crypto | Low/medium |
| ATOMUSD.nx | no | yes | yes | Top5 bucket Crypto | Low/medium |

Observation: duplicate route instances are not fatal, but Siam consumers need explicit canonical authority and route identity. Do not infer signal from duplicate route presence.

## Section 12 — No Signal / Trade Boundary Check

| Surface | Forbidden Signal/Trade Text Found? | Context | PASS / FAIL |
|---|---:|---|---|
| Symbol Data Pack child files | no permission wording found | SDP aggregate has no forbidden action/permission hits; safety boundary says no direction/signal/broker action | PASS |
| Manifest / Scanner Status / FunctionResults | negative boundary vocabulary found | Terms such as buy/sell/entry appear in restrictive context: trade_permission=false, entry_signal=false, no_entry_output=true, no_direction_output=true | PASS |
| reports/logs | negative boundary vocabulary found | FunctionResults/Heartbeat include entry_signal=false style context | PASS |

No trade, signal, execution, lot sizing, SL/TP, edge, or production readiness permission is granted by RUN215R.

## Section 13 — Weekend / Session Boundary

RUN215 live evidence timestamps are 2026-05-02 evening UTC, a weekend period. Crypto evidence is usable; weekday forex/metals/indices/stocks proof is not established.

| Market Context | Evidence | Meaning | Limitation |
|---|---|---|---|
| crypto open | Crypto .nx symbols generated and populated | usable crypto route/data-purity evidence | broker/server bounded |
| forex closed | no supplied weekday forex live set | closed state not a scanner failure | not proven |
| metals/indices/stocks closed | no supplied weekday non-crypto evidence | closed state not a scanner failure | not proven |
| stocks/indices closed | no supplied weekday non-crypto evidence | closed state not a scanner failure | not proven |

## Section 14 — Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| RUN214 says RUN215 must prove final route population | GlobalTop10 and Top5PerBucket/crypto folders are populated | RUN214 report / source-control | RUN215 generated folders | 3 | 7/8 | Live output outranks source plan | Population passes for supplied routes | no |
| RUN214 says route_lifecycle_reason should reach durable surfaces | FunctionResults inspected log lacks route_lifecycle_reason | RUN214 source/control report | RUN215 FunctionResults log | 3 | 7/8 | Live log outranks source claim for that surface | HOLD until FunctionResults proof is added/fixed | yes |
| RUN215 expects reconciliation_* proof fields | Exact reconciliation_* fields absent | RUN215 prompt/checklist | RUN215 durable surfaces | 2/3 | 7/8 | Live surfaces outrank prompt expectation | HOLD; request exact durable schema or source patch if confirmed absent | yes |
| Proof bundle should be complete for PROCEED | Runtime manifest/status say proof_bundle_complete=false / missing globaltop10_archive | RUN215 decision rule | Manifest/Scanner Status | 2/3 | 7/8 | Live manifest/status outrank | HOLD until archive surface supplied or marked lawful N/A | yes |
| Compile/source identity should be valid | MetaEditor compile output absent | RUN215 checklist | supplied files | 2/3 | n/a | Missing evidence controls | No compile proof claim | yes |

## Section 15 — Patch / Next-Run Rule

No source patch was applied. Current evidence does not justify editing generated output or patching source inside RUN215. Next move is evidence completion first. If completed evidence confirms missing FunctionResults route_lifecycle_reason or reconciliation_* schema, seed a separate DEBUG/PATCH run against the directly proven owners only.

Allowed next owners if proven: ASC_SymbolDataPackWriter.mqh, ASC_Dispatcher.mqh, ASC_ScannerStatusWriter.mqh, ASC_FunctionResults.mqh, Manifest owner/writer, ASC_Version.mqh, office/control/report/guidebooks.

Forbidden without new authorization/evidence: FileIO rewrite, path doctrine mutation, membership/ranking/formula change, HUD, Market Board, strategy/signal/trade/risk logic, generated output editing.

## Section 16 — Package Law

Package created exactly as `TRUTH_SEEKER_RUN215R.zip`; no suffix. Existing package path was overwritten/deleted before creation. Generated output evidence copies are binary copied unchanged from supplied upload into the package evidence folder.

## Section 17 — Package Validation Table

| Package Rule | Result | Evidence |
|---|---|---|
| exact package name | PASS | TRUTH_SEEKER_RUN215R.zip |
| no suffix | PASS | no `_2`, `_copy`, `final`, `fixed`, `updated`, `new` |
| report included | PASS | roadmap/Truth Seeker/Truth Seeker Reports/RUN215R_REPORT.md |
| selected live evidence included unchanged | PASS | Upcomers-Server selected manifests, logs, and route child files copied as bytes |
| source/control files included only if patch applied | PASS | no source patch files included beyond report |
| generated output edited | PASS | no generated output edited |
| whole repo dump excluded | PASS | source repo not bundled wholesale |

## Section 18 — Evidence Ladder

| Claim | Highest Evidence Class Available | Result |
|---|---:|---|
| Active source/control files contain RUN214 final source gate identity | 3 | proven from supplied source zip |
| Compile succeeds | n/a | unproven; compile output absent |
| EA generated runtime files | 7/8 bounded | proven from supplied generated evidence |
| Final route folders populated | 7/8 bounded | proven for GlobalTop10 and Top5PerBucket/crypto |
| RUN207 fields appear in child files | 7/8 bounded | proven for 15 final-route child files |
| Full reconciliation observability | 7/8 bounded | not proven; exact schema missing |
| Production readiness | n/a | not claimed |
| Trading edge / signal permission | n/a | not claimed |

## Final Decision

HOLD

Strongest next move: complete or rerun live evidence under RUN216R with compile output, Experts/Journal logs if available, explicit broker/server/session note, GlobalTop10 archive proof or lawful not-applicable reason, and exact reconciliation_* / route_lifecycle_reason propagation across Manifest, Scanner Status, FunctionResults, and any manifest-facing surfaces. Only patch source after the completed evidence proves the owner defect.
