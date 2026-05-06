# RUN217R_REPORT

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN217R / RECONCILIATION OBSERVABILITY REPAIR — MAKE EXACT RECONCILIATION FIELDS DURABLE WITHOUT TOUCHING OUTPUT EVIDENCE
MODE: DEBUG + PATCH
DECISION: TEST FIRST
REPORT: RUN217R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN217R.zip
```

```text
FINAL SUMMARY

- No live/output files were requested or used in RUN217R. RUN215 evidence was absorbed only through read-only report/control summaries; generated runtime output evidence was not edited, cleaned, renamed, deleted, regenerated, or packaged.
- RUN216 was absorbed: RUN217R remains a source/control run, RUN227R remains the next live proof, and the DATA / DOSSIER CLEANLINESS AND TRUTHNESS CHECK stays minor proof-readability only.
- Exact reconciliation observability root cause found by source inspection: ASC_SymbolDataPackWriter.mqh generated reconciliation details, but durable surfaces mostly carried them as nested route_lifecycle_reason/final_set_reconcile prose; FunctionResults had no dedicated reconciliation proof row; Top5PerBucket had bucket-level details but no aggregate exact reconciliation_* contract block.
- Source/control patch applied: ASC_SymbolDataPackWriter.mqh now builds a normalized reconciliation field block with exact reconciliation_* keys, including reconciliation_expected_symbols_summary and reconciliation_unexpected_symbols_summary; ASC_Dispatcher.mqh now emits exact reconciliation proof blocks to Manifest-facing status lines and records dedicated FunctionResults reconciliation rows at cycle reconciliation; ASC_ScannerStatusWriter.mqh now emits exact reconciliation proof blocks in Scanner Status; ASC_Version.mqh and control files were advanced to RUN217R/RUN218R.
- Durable surfaces now receive exact reconciliation_* fields by source inspection: Scanner Status, Artifact Bundle Manifest-facing runtime status/proof lines, and FunctionResults rows created by ASC_SymbolDataPackReconciliationObservability.
- Untouched: generated live/runtime output evidence, Symbol Data Packs, Dossiers, generated Manifest/Scanner/FunctionResults evidence, Experts/Journal logs, ASC_FileIO.mqh, route path constants, membership source, rank/order/formula logic, Composer/Contracts RUN207 data-purity semantics, DossierWriter, CurrentFocusWriter, HUD, Market Board, strategy/signal/trade/risk logic.
- RUN206 safety was preserved: empty expected-set still returns a no-delete deferred proof block with no enumeration/delete path.
- RUN207 data-purity semantics were preserved: Composer/Contracts semantics were not changed.
- Final route publication behavior was preserved by source path: write/fallback/final route owners were not rewritten; only proof formatting/propagation was patched.
- Still unproven until MetaEditor compile and RUN227 live proof: compile success, runtime behavior, actual durable output visibility, FunctionResults row write, exact field parsing under broker path values, proof_bundle_complete policy, and production/live readiness.
- Exact next move: RUN218R GlobalTop10 asset-identity purity.

DECISION: TEST FIRST
```

## SECTION 0 — MODE LOCK

| Declaration | Required Answer | RUN217R Answer |
|---|---|---|
| current run | RUN217R | RUN217R |
| primary mode | DEBUG | DEBUG |
| secondary mode | PATCH | PATCH |
| live run? | no | no |
| runtime/output artifacts expected? | no | no |
| RUN215 output used? | read-only evidence summary only | yes, report/control intake only |
| source editing allowed? | exact reconciliation observability repair only | yes |
| data/Dossier cleanliness side job allowed? | minor grouping/readability/proof-clarity only | yes, proof grouping only |
| live output editing allowed? | no | no |
| FileIO editing allowed? | no | no |
| next live proof | RUN227R | RUN227R |
| production-ready claim allowed? | no | no |
| edge/signal/trade/execution/risk permission allowed? | no | no |

## Evidence Ladder

| Evidence Item | Class | RUN217R Use |
|---|---:|---|
| User prompt / trader-chat reports | 2 | Scope authority and RUN217 constraints |
| Direct source/package inspection | 3 | Patch basis and source truth ceiling |
| MetaEditor compile output | 4 | Not supplied; no compile proof claimed |
| RUN215 generated output/logs | 7/8 bounded | Absorbed via RUN215 report only; not mutated |

## RUN216 Absorption Check

| RUN216 Item | Expected | Observed | PASS / HOLD / FAIL | Patch Needed? |
|---|---|---|---|---:|
| package filename | TRUTH_SEEKER_RUN216R.zip | manifest says TRUTH_SEEKER_RUN216R.zip | PASS | no |
| changed-files-only shape | yes | RUN216 manifest lists control/report/version/guidebooks only | PASS | no |
| RUN216 report present | yes | present | PASS | no |
| ASC_Version identity | RUN216R | active source was RUN216R before patch | PASS | yes, advance to RUN217R |
| next source run | RUN217R | RUN216 pointed to RUN217R | PASS | yes, advance to RUN218R after patch |
| next live proof | RUN227R | RUN227R | PASS | no |
| RUN216–RUN226 source corridor present | yes | present in report/control/guidebooks | PASS | no |
| data/Dossier cleanliness law present | yes | present | PASS | no |
| generated output excluded | yes | excluded by manifest/report | PASS | no |
| source implementation owners untouched | yes | RUN216 did not patch implementation owners | PASS | no |
| RUN217 seed present | yes | present | PASS | no |

## RUN215 Failure Absorption

| RUN215 Finding | Evidence Source | Evidence Rank | RUN217 Meaning | Patch Target Candidate |
|---|---|---:|---|---|
| final GlobalTop10 folder populated | RUN215 report | 7/8 bounded | preserve publication behavior | no publication rewrite |
| final Top5PerBucket/Crypto folder populated | RUN215 report | 7/8 bounded | preserve publication behavior | no publication rewrite |
| RUN207 fields emitted | RUN215 report | 7/8 bounded | preserve data-purity fields | Composer/Contracts read-only |
| exact reconciliation_* fields absent | RUN215 report | 7/8 bounded | primary blocker | Writer/Dispatcher/Scanner/FunctionResults/Manifest proof path |
| route_lifecycle_reason partial propagation | RUN215 report | 7/8 bounded | preserve but do not confuse with exact keys | Dispatcher/status proof block |
| FunctionResults lacked route_lifecycle_reason | RUN215 report | 7/8 bounded | add dedicated row | Dispatcher FunctionResult row |
| proof_bundle_complete=false | RUN215 report | 7/8 bounded | RUN225 unless same owner | not patched beyond exact fields |

## Primary Root-Cause Questions

| Question | Answer |
|---|---|
| Where are reconciliation fields generated? | ASC_SymbolDataPackWriter.mqh, inside ASC_SymbolDataPackPruneUnexpectedFinalChildrenForRoute. |
| Are they only in reason_out? | Before RUN217, yes: the detailed proof traveled as reason_out / final_set_reconcile text. |
| Does Dispatcher capture writer reconciliation reason? | Yes, but nested into state.symbol_data_pack_*_last_reason as final_set_reconcile text. |
| Does compact proof strip details? | Compact proof preserves raw reason later, but durable verification can miss exact fields if only compact/generic tokens are inspected. |
| Does Scanner Status receive route_lifecycle_reason but not exact fields? | Before patch, yes. After patch, Scanner Status emits exact proof blocks. |
| Does FunctionResults receive generic success/failure but not detailed reason text? | Before patch, no dedicated reconciliation FunctionResult row existed. After patch, cycle reconciliation records one. |
| Manifest owner? | ASC_WriteArtifactBundleManifest in Dispatcher; patched with explicit proof lines. |
| Field names present but not exact? | RUN206/RUN210/RUN215 history showed old names and nested fields; RUN217 adds summary keys and explicit durable fields. |
| String length/trimming risk? | RUN217 uses normalized key=value proof blocks and compact summary fields, but compile/live proof remains pending. |
| Smallest safe patch? | Keep writer as source owner, add exact field block, project it into Scanner Status, Manifest-facing lines, and FunctionResults row. |

## Exact Field Contract

| Field | Durable Source Inspection Result |
|---|---|
| reconciliation_route | Writer block + Scanner/Manifest/FunctionResults proof block |
| reconciliation_bucket | Writer block + Scanner/Manifest/FunctionResults proof block |
| reconciliation_state | Writer block + Scanner/Manifest/FunctionResults proof block |
| reconciliation_current_truth_source | membership_snapshot in all proof blocks |
| reconciliation_expected_count | Writer block + durable proof block |
| reconciliation_found_final_count | Writer block + durable proof block |
| reconciliation_expected_symbols_summary | added in writer and durable proof blocks |
| reconciliation_unexpected_symbols_summary | added in writer and durable proof blocks |
| reconciliation_archived_count | Writer block + durable proof block |
| reconciliation_deleted_count | Writer block + durable proof block |
| reconciliation_skipped_count | Writer block + durable proof block |
| reconciliation_first_failure_reason | Writer block + durable proof block |
| reconciliation_final_path | Writer block + durable proof block |
| reconciliation_archive_path | Writer block + durable proof block |

## Source Inspection Table

| Source Area | File | What Verified | PASS / HOLD / FAIL | Patch Needed? |
|---|---|---|---|---:|
| reconciliation generation | ASC_SymbolDataPackWriter.mqh | reason_out generated exact core keys but lacked summary aliases and normalized field builder | PASS | yes |
| no-delete deferral | ASC_SymbolDataPackWriter.mqh | empty expected set still returns before enumeration/delete | PASS | no |
| reason_out path | ASC_SymbolDataPackWriter.mqh | proof was local/nested | HOLD | yes |
| dispatcher capture | ASC_Dispatcher.mqh | captures reconciliation but nested in route_lifecycle_reason | HOLD | yes |
| compact prefix | ASC_Dispatcher.mqh | compact does not delete raw detail, but exact durable block absent | HOLD | yes |
| scanner status emission | ASC_ScannerStatusWriter.mqh | route_lifecycle_reason present; exact block absent | HOLD | yes |
| FunctionResults emission | ASC_FunctionResults.mqh / Dispatcher | no dedicated reconciliation row | HOLD | yes in Dispatcher only |
| Manifest-facing owner | ASC_Dispatcher.mqh | Manifest includes SDP runtime lines; exact proof lines absent | HOLD | yes |
| proof bundle interaction | ASC_Dispatcher.mqh | RUN217 does not fake proof_bundle_complete | PASS | no |
| route-specific behavior | Writer/Dispatcher | GlobalTop10 and Top5 covered; Top5 aggregate needed | HOLD | yes |
| RUN207 preservation | Composer/Contracts | read-only | PASS | no |
| final publication preservation | Writer/Dispatcher | write path not rewritten | PASS | no |

## Patch Scope Table

| File | Patch |
|---|---|
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh | Added proof value sanitizer and canonical reconciliation field block; added summary aliases; preserved no-delete safety. |
| mt5/runtime/ASC_Dispatcher.mqh | Added durable proof block helper, Manifest-facing explicit proof lines, FunctionResults reconciliation row, Top5 aggregate exact block. |
| mt5/artifacts/ASC_ScannerStatusWriter.mqh | Added Scanner Status proof extraction/block helpers and exact fields in SDP proof lines. |
| mt5/core/ASC_Version.mqh | Advanced RUN217 identity and RUN218 seed. |
| office/control/report files | Updated RUN217 status/package and RUN218 seed. |

## DATA / DOSSIER CLEANLINESS AND TRUTHNESS CHECK

| Cleanliness Item | In Scope For RUN217? | Action | Forbidden Drift |
|---|---:|---|---|
| reconciliation proof grouping | yes | grouped exact key=value proof block | no hidden failures |
| Scanner Status readability | yes | exact fields added beside route lifecycle reason | raw proof preserved |
| FunctionResults readability | yes | dedicated reconciliation row and first failure reason | no generic success replacement |
| Manifest proof readability | yes | explicit GlobalTop10/Top5 reconciliation proof lines | no fake bundle complete |
| Dossier readability | no implementation | backlog only | no broad Dossier rewrite |
| Symbol Data Pack body cleanliness | no implementation | RUN207 preserved | no composer rewrite |
| DATA PURITY SUMMARY | no implementation | scheduled later | not implemented early |
| debug/body split | no implementation | scheduled later | not implemented early |

## Multi-Domain Research Ledger

| Research Lane | Source / Authority | Finding | Converted RUN217 Constraint | Falsifier |
|---|---|---|---|---|
| MQL5 file enumeration | Official MQL5 FileFindFirst/FileFindNext docs | File enumeration uses a search handle and returns file names from a filter. | Do not mutate FileIO/path constants; only use existing writer reconciliation owner for counts. | MetaEditor/runtime shows enumeration proof broke or no fields emitted. |
| MQL5 diagnostics | Official MQL5 GetLastError/ResetLastError docs | Error details must be captured near failing API calls. | Preserve first failure reason and do not replace failure with generic success. | FunctionResults/Scanner shows success without first failure. |
| Observability/SRE | OpenTelemetry structured logging docs | Structured key/value logs are easier to filter and correlate than prose blobs. | Emit exact reconciliation_* key=value fields, not only route_lifecycle prose. | Durable surfaces lack exact keys. |
| Secure SDLC/source control | Bounded patch discipline | Patches should be scoped to the root-cause owner and avoid evidence mutation. | No generated output mutation; no FileIO/membership/rank/HUD/trade drift. | Package contains generated output or forbidden owners. |
| Protected lattice | Truth-owner boundary | Writer owns reconciliation; durable surfaces consume proof. | No filesystem-as-membership truth, no HUD/Market Board truth ownership. | Proof starts computing membership outside writer/source-owned state. |
| Prompt/execution control | RUN217 prompt authority | RUN227 remains next live proof; RUN218 is next source run. | Control files seed RUN218 and keep no-live boundary. | Any control file points to live before RUN227. |

## Brain Guidebook / Two-Brain Check

| Guidebook | Read? | Key Rule Extracted | Converted RUN217 Constraint | Patch Needed? |
|---|---:|---|---|---:|
| AURORA_GUIDEBOOK_INDEX.md | yes | RUN216–RUN226 source only; RUN227 live | keep RUN217 no-live and seed RUN218 | yes control |
| AURORA_CODING_BRAIN_GUIDEBOOK.md | yes | Cleanliness must preserve truth and avoid output mutation | proof grouping only | yes source proof grouping |
| AURORA_TRADING_BRAIN_GUIDEBOOK.md | yes | Clean data is not signal permission | add no signal/trade/execution tokens | yes proof tokens |

Builder answer: smallest patch is writer canonical proof block plus durable consumers in Scanner Status, Manifest-facing lines, and FunctionResults rows. Files left untouched include FileIO, routing constants, membership/ranking/formula, Composer/Contracts semantics, Dossier/Current Focus, HUD, Market Board, and trade/risk logic.

Auditor answer: fake reconciliation success can come from generic OK rows, nested blobs, missing first failure reason, path values with spaces, proof_bundle_complete confusion, or output mutation. RUN217 counters this with exact fields, first failure reason, no fake bundle completion, and package exclusion.

## Boundary Contract / Protected Lattice

| Boundary | System A | System B | Lawful Interface | Source Of Truth | Allowed Crossing | Forbidden Crossing | Acceptance Criteria | HOLD / KILL Condition |
|---|---|---|---|---|---|---|---|---|
| Writer reconciliation state ↔ durable surfaces | Writer | Scanner/FunctionResults/Manifest | exact key=value proof | writer counters/state | reconciliation_* fields | generic success replacing proof | fields visible by source path | proof swallowed |
| route lifecycle ↔ reconciliation proof | route_lifecycle_reason | reconciliation_* block | compact plus exact | Writer/Dispatcher | route/bucket/state/failure | raw reason deletion | compact and exact survive | field loss |
| source patch ↔ RUN215 evidence | active source | generated output | evidence intake only | source files | findings | output mutation | output untouched | any evidence edit |
| final/staging/archive ↔ proof counts | route folders | proof status | counts only | writer/reconcile owner | found/archived/deleted/skipped | filesystem as membership truth | source-owned expected set | filesystem-derived membership truth |
| data cleanliness ↔ proof accuracy | readability | truth fields | grouping only | source proof owner | clearer sections | deleting proof | easier audit | hidden failure |
| data-health ↔ signal boundary | data readiness | trading interpretation | negative/factual labels | Trading Brain | not_permission | buy/sell/readiness trade | no signal text | trade permission |

## Static Compile-Risk Sweep

| Static Check | Result | Evidence | Patch Needed? |
|---|---|---|---:|
| missing include risk | WATCH | Dispatcher already includes writer and FunctionResults through existing path; no MetaEditor proof | no |
| undefined helper risk | WATCH | New helpers defined before use in same files; no compile output | no |
| duplicate function/macro risk | PASS by grep | names unique in touched files | no |
| string quote/escape risk | WATCH | path string escaping inspected; compile pending | no |
| StringFormat mismatch risk | PASS | no new high-risk multi-arg StringFormat except simple aggregate line | no |
| enum/route mismatch risk | PASS | existing route enum untouched | no |
| bool/string conversion risk | PASS | explicit ternaries used | no |
| reason length/truncation risk | WATCH | summary keys reduce parser burden but live output pending | no |
| exact field typo risk | PASS by grep | required exact names present | no |
| compact/raw divergence risk | WATCH | compact retained; exact block added | no |
| output evidence mutation risk | PASS | no generated folders touched | no |
| reconciliation safety regression risk | WATCH | no-delete branch preserved; compile/live pending | no |
| RUN207 data-purity regression risk | PASS | Composer/Contracts read-only | no |
| signal/trade wording risk | PASS | proof blocks include false permissions only | no |

## RUN206 / RUN207 / RUN215 Preservation Check

| Protected Law | Expected | Source Evidence | PASS / HOLD / FAIL |
|---|---|---|---|
| RUN206 empty expected-set no-delete | preserved | early return before FileFindFirst/FileDelete | PASS |
| no_committed_membership_no_delete | preserved | first_failure_reason retained | PASS |
| final route publication behavior from RUN215 | preserved | write/fallback paths untouched | PASS |
| RUN207 no_sample semantics | preserved | Composer/Contracts read-only | PASS |
| RUN207 tick/spread window_valid fields | preserved | Composer/Contracts read-only | PASS |
| RUN207 CopyTicks cap/truncation fields | preserved | Composer/Contracts read-only | PASS |
| RUN207 last_price availability/status/raw | preserved | Composer/Contracts read-only | PASS |
| RUN207 absence_state/absence_reason | preserved | Composer/Contracts read-only | PASS |
| no signal/trade permission | preserved | false permission tokens added | PASS |
| RUN227 remains next live proof | preserved | ASC_Version/control | PASS |

## Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| RUN215 proved route publication | RUN215 lacked exact reconciliation_* fields | RUN215 report | RUN215 report | 7/8 bounded | 7/8 bounded | neither conflicts; both true | preserve publication, patch observability only | TEST FIRST |
| Source had reconciliation prose | Durable surfaces lacked exact keys | Writer source / RUN215 report | RUN215 report | 3 | 7/8 bounded | live evidence outranks source intent | add exact durable proof blocks | TEST FIRST |
| route_lifecycle_reason visible | reconciliation_* absent | RUN215 report | RUN215 report | 7/8 bounded | 7/8 bounded | exact-key requirement outranks generic route reason | do not treat route_lifecycle_reason as enough | TEST FIRST |
| proof_bundle_complete=false | RUN217 exact fields patched | RUN215 report / source | source patch | 7/8 bounded | 3 | RUN215 remains blocker for RUN225 | RUN217 does not fake bundle complete | TEST FIRST |

## Patch Ledger

| File | Change | Reason | Forbidden Scope Avoided |
|---|---|---|---|
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh | canonical reconciliation field block and summary aliases | exact field source owner | no path/FileIO/membership rewrite |
| mt5/runtime/ASC_Dispatcher.mqh | durable proof helper, Manifest lines, FunctionResults reconciliation rows, Top5 aggregate exact proof | make proof durable outside nested prose | no cadence/rank/HUD/trade rewrite |
| mt5/artifacts/ASC_ScannerStatusWriter.mqh | exact Scanner Status proof block | make Scanner Status searchable by exact keys | no writer ownership leak |
| mt5/core/ASC_Version.mqh | RUN217 identity / RUN218 seed | control alignment | no live jump |
| office/control/report files | RUN217 status/package/RUN218 seed | package authority | no generated evidence |

## Package Validation Table

| Check | Result |
|---|---|
| package name exact | TRUTH_SEEKER_RUN217R.zip |
| changed files only | yes |
| original folder layout | yes |
| RUN217 report included | yes |
| generated output excluded | yes |
| whole repo excluded | yes |
| forbidden suffix avoided | yes |
| compile proof claimed | no |
| runtime/live proof claimed | no |
| production/trading edge claimed | no |

## Exact RUN218 Prompt Seed

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN218R / GLOBALTOP10 ASSET-IDENTITY PURITY — KEEP ROUTE FAMILY GLOBAL WHILE PRESERVING ASSET_CLASS, BUCKET, AND SYMBOL_FAMILY
MODE: AUDIT + PATCH
LIVE: no
PACKAGE: TRUTH_SEEKER_RUN218R.zip
PURPOSE:
- patch source so GlobalTop10 Symbol Data Packs do not erase market identity
- route_family remains globaltop10_mirror
- route_bucket may remain not_applicable for route context
- asset_class / bucket / symbol_family must be explicit and source-owned
- preserve RUN217 exact reconciliation observability
- preserve RUN207 data-purity fields
- preserve RUN206 no-delete safety
- no generated output request
- no output mutation
- no FileIO/path/membership/ranking/HUD/Market Board/trade logic change
- include data/Dossier cleanliness side job only as minor grouping/readability protection
```
