# RUN220R REPORT — DATA PURITY SUMMARY V1

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN220R / DATA PURITY SUMMARY V1 — ADD MACHINE-READABLE SIAM REVIEW BLOCK WITHOUT SIGNAL OR TRADE PERMISSION
MODE: AUDIT + PATCH
DECISION: TEST FIRST
REPORT: RUN220R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN220R.zip
```

```text
FINAL SUMMARY

- RUN220R requested no live/output files and used no generated runtime output as active evidence.
- RUN219R was absorbed: duplicate route context fields are source-present in Composer and protected by Writer required-token validation.
- DATA PURITY SUMMARY root cause found: active Symbol Data Pack Composer emitted RUN207/RUN218/RUN219 source-owned data-purity fields in the body, but emitted no final machine-readable summary block for Siam review.
- Source/control patch applied: Composer now emits a final DATA PURITY SUMMARY block; Writer required-token validation protects the block and hard false permission fields; Version/control/report/guidebook files advanced to RUN220R/RUN221R while RUN227R remains next live proof.
- Implemented summary fields include source_run, build, route_family, route_bucket, route_bucket_name, asset_class, bucket, symbol_family, classification_source, canonical_symbol_id, duplicate_route_instance, route_context_role, canonical_scope_for_siam_review, tick/spread validity, CopyTicks cap/truncation state, last-price status/availability, absence state/reason, OHLC/recent sequence readiness, critical_purity_errors_count, critical_purity_errors, ready_for_siam_review, ready_for_siam_reason, and hard false permission flags.
- Intentionally conservative placeholders: symbol_specs_hydrated, session_facts_hydrated, atr_facts_hydrated, vwap_facts_hydrated, and indicator_facts_hydrated remain unknown in RUN220R instead of fake true. RUN221R owns specs/session missingness refinement.
- ready_for_siam_review is data-review only. It does not create signal readiness, trade readiness, execution permission, risk permission, prop-firm permission, production readiness, or edge proof.
- All trade/signal/execution/risk/prop-firm permissions remain false in the summary and are protected by required-token validation.
- RUN219 duplicate context was preserved; RUN218 asset identity was preserved; RUN217 exact reconciliation observability was not touched; RUN207 data-purity semantics were summarized without changing their owners; RUN206 no-delete safety was not touched.
- Untouched: generated output evidence, generated Symbol Data Packs, generated Dossiers, generated Manifest/Scanner/FunctionResults evidence, Experts/Journal logs, ASC_FileIO.mqh, route path constants, GlobalTop10 membership source, Top5PerBucket membership source, L3/L4 rank/order/formula, HUD, Market Board, strategy/signal/trade/risk logic, specs/session hydration implementation, section coherence implementation, crypto health gates, and proof-bundle policy.
- Still unproven until MetaEditor compile and RUN227 live proof: compile success, runtime payload emission, actual DATA PURITY SUMMARY visibility in generated child files, parser behavior, and live data-readiness classification.
- Exact next move: RUN221R specs + session hydration flags and missingness summary.

DECISION: TEST FIRST
```

## SECTION 0 — Mode Lock

| Declaration | RUN220R Answer |
|---|---|
| current run | RUN220R |
| primary mode | AUDIT |
| secondary mode | PATCH |
| live run? | no |
| runtime/output artifacts expected? | no |
| RUN215 output used? | read-only report/control summary only |
| source editing allowed? | yes, DATA PURITY SUMMARY v1 source patch only |
| data/Dossier cleanliness side job allowed? | yes, minor grouping/readability/truthness only |
| live output editing allowed? | no |
| FileIO editing allowed? | no |
| next live proof | RUN227R |
| production-ready claim allowed? | no |
| edge claim allowed? | no |
| signal/trade permission allowed? | no |
| final decision | TEST FIRST |

## Evidence Ladder

| Evidence Item | Class | RUN220R Use |
|---|---:|---|
| User prompt / Siam pressure test | 2 | scope and expected blocker only |
| RUN219-RUN206 reports/control files | 2-3 for report/control content; RUN215 bounded live claims remain historical only | intake and preservation checks |
| Direct active source inspection | 3 | patch authority and evidence ceiling |
| MetaEditor compile output | 4 | not supplied; no compile proof claimed |
| RUN220 runtime/live proof | n/a | forbidden in this run |

## No-Live-Output Boundary

| Boundary | Result |
|---|---|
| Generated Symbol Data Packs requested? | no |
| Generated Dossiers requested? | no |
| Generated Manifest/Scanner/FunctionResults evidence requested? | no |
| Experts/Journal logs requested? | no |
| Generated output edited/packaged? | no |
| FileIO/path/membership/ranking/HUD/Market Board/trade logic touched? | no |

## RUN219 Absorption Check

| RUN219 Item | Expected | Observed | PASS / HOLD / FAIL | Patch Needed? |
|---|---|---|---|---:|
| package filename | TRUTH_SEEKER_RUN219R.zip | RUN219 report/manifest records exact package | PASS | no |
| changed-files-only shape | yes | manifest records changed-files-only and exclusions | PASS | no |
| RUN219 report present | yes | present | PASS | no |
| ASC_Version identity | RUN219R | source showed RUN219R before patch | PASS | yes, advance to RUN220R |
| next source run | RUN220R | source/control pointed to RUN220R | PASS | yes, advance to RUN221R |
| next live proof | RUN227R | preserved in source/control | PASS | no |
| canonical_symbol_id field source-present | yes | Composer Duplicate / Parallel Route Context | PASS | no |
| duplicate_route_instance field source-present | conservative unknown | Composer emits unknown | PASS | no |
| route_context_role field source-present | yes | Composer route helper | PASS | no |
| route_context_authority field source-present | yes | route_context_only_not_trade_or_selection_authority | PASS | no |
| parallel_route_family field source-present | conservative unknown | Composer emits unknown | PASS | no |
| canonical_scope_for_siam_review field source-present | yes | Composer route helper | PASS | no |
| duplicate_inference_policy | no_filesystem_stale_scan_no_suffix_guessing | protected by Writer token | PASS | no |
| duplicate_context_boundary prevents trade/rank authority | yes | protected by Writer token | PASS | no |
| RUN218 asset identity preserved | yes | Composer Asset / Classification Identity remains | PASS | no |
| RUN217 reconciliation fields preserved | yes | Writer reconciliation source not edited except token list expansion | PASS | no |
| RUN207 data-purity semantics preserved | yes | Quote/tick/spread fields summarized only | PASS | no |
| generated output excluded | yes | no output paths included in package | PASS | no |
| RUN220 seed present | yes | active roadmap/template had RUN220 seed | PASS | yes, replace with RUN221 seed |

## Siam / Trader-Chat DATA PURITY SUMMARY Absorption

| Siam Requirement | Current Evidence | Source Owner Candidate | RUN220 Decision |
|---|---|---|---|
| DATA PURITY SUMMARY block exists | missing by source inspection | Composer | IMPLEMENTED |
| ready_for_siam_review is machine-readable | missing by source inspection | Composer | IMPLEMENTED as data-review only |
| critical_purity_errors_count exists | missing by source inspection | Composer | IMPLEMENTED conservatively |
| route + asset identity summarized | RUN218/RUN219 source-present | Composer | IMPLEMENTED |
| duplicate route context summarized | RUN219 source-present | Composer | IMPLEMENTED |
| no-sample / spread validity summarized | RUN207 source-present | Composer/Contracts | IMPLEMENTED |
| last_price status summarized | RUN207 source-present | Composer/Contracts | IMPLEMENTED |
| CopyTicks cap/truncation summarized | RUN207 source-present | Composer/Contracts | IMPLEMENTED |
| absence state summarized | RUN207 source-present | Composer/Contracts | IMPLEMENTED |
| OHLC/recent sequence readiness summarized | source-owned body functions present | Composer | PARTIAL; readiness only |
| specs/session hydration flags included | scheduled RUN221 | Composer | QUARANTINED as unknown placeholders |
| ATR/VWAP/indicator flags included | later/future truth boundary | Composer | QUARANTINED as unknown placeholders |
| signal/trade permissions explicitly false | required | Composer / Trading Brain | IMPLEMENTED and token-protected |

## Primary Root-Cause Answers

1. The block belongs near the end of the Symbol Data Pack body so Siam can parse one final truth index after all source sections exist.
2. End placement is stronger than early placement because it behaves as a final review summary, not a replacement for raw proof sections.
3. Safe summary fields are the existing source/run/build markers, route fields, RUN218 identity fields, RUN219 duplicate fields, RUN207 quote/tick/spread/CopyTicks/last/absence fields, and body-readiness checks for OHLC/recent sequences.
4. RUN207 safe fields include no-sample validity/invalid reasons, tick/spread validity, CopyTicks cap/truncation, last_price_available/status/raw, absence_state, and absence_reason.
5. RUN218 safe fields include asset_class, bucket, symbol_family, classification_source, and provenance/boundary semantics.
6. RUN219 safe fields include canonical_symbol_id, duplicate_route_instance, route_context_role, route_context_authority, parallel_route_family, canonical_scope_for_siam_review, and duplicate boundary policy.
7. ready_for_siam_review can be computed conservatively if it is explicitly named and bounded as data-review only.
8. ready_for_siam_review=no when critical identity/route/duplicate/no-sample/last-price/source-boundary truth is missing.
9. ready_for_siam_review=limited when critical truth exists but non-critical/future hydration remains unknown.
10. ready_for_siam_review=yes only when critical errors are zero and no non-critical/future hydration unknown remains.
11. critical_purity_errors_count can be computed from current source-owned fields without broad architecture.
12. Unknown future fields are emitted as unknown, not false precision.
13. specs/session hydration can be summarized as unknown without implementing RUN221.
14. ATR/VWAP/indicator hydration can remain unknown without implementing new indicator logic.
15. The smallest patch is a Composer summary helper + Writer required-token expansion + version/control/report updates.

## Field Contract

| Field Family | RUN220 Implementation |
|---|---|
| source identity | `source_run`, `build` |
| route context | `route_family`, `route_bucket`, `route_bucket_name` |
| asset identity | `asset_class`, `bucket`, `symbol_family`, `classification_source` |
| duplicate context | `canonical_symbol_id`, `duplicate_route_instance`, `route_context_role`, `canonical_scope_for_siam_review` |
| RUN207 validity | tick/spread window validity, CopyTicks cap/truncation, last price, absence |
| body readiness | `ohlc_summary_ready`, `recent_candle_sequences_ready` |
| future hydration | specs/session/ATR/VWAP/indicator = unknown |
| error summary | `critical_purity_errors_count`, `critical_purity_errors` |
| review gate | `ready_for_siam_review`, `ready_for_siam_reason` |
| hard permissions | signal/trade/execution/risk/prop_firm all false |
| boundary | `data_review_only_not_signal_not_trade` |

## ready_for_siam_review Policy

| Value | RUN220 Meaning |
|---|---|
| yes | critical fields present, no critical errors, no non-critical unknowns; data-review only |
| limited | critical fields present but non-critical/future hydration/duplicate exactness/body readiness is unknown or partial |
| no | critical identity, route, duplicate boundary, no-sample semantics, last-price semantics, or source identity is missing |

Critical errors implemented: `missing_asset_class`, `missing_bucket`, `missing_route_family`, `missing_canonical_symbol_id`, `missing_duplicate_context_boundary`, `missing_last_price_semantics`, `missing_no_sample_semantics`, `unknown_source_identity`.

Quarantined as policy-only because the patch hard-codes all permissions false and does not scan arbitrary generated text: `signal_or_trade_permission_present`, `fake_numeric_zero_risk`.

## Source Inspection Table

| Source Area | File | What Verified | PASS / HOLD / FAIL | Patch Needed? |
|---|---|---|---|---:|
| summary block emission | ASC_SymbolDataPackComposer.mqh | no DATA PURITY SUMMARY existed; one payload composer owner exists | PASS | yes |
| source/run/build identity | ASC_Version / Composer | current run/build macros available | PASS | yes, advance |
| route context fields | Composer/Routing | family route and bucket context available | PASS | yes, summarize |
| RUN218 identity fields | Composer | asset/bucket/symbol_family/provenance available | PASS | yes, summarize |
| RUN219 duplicate fields | Composer | canonical/duplicate/scope fields available | PASS | yes, summarize |
| RUN207 validity fields | Composer/Contracts | no_sample/last/CopyTicks/absence fields available | PASS | yes, summarize |
| ohlc/recent sequence readiness | Composer | source-owned body functions available | PASS | partial readiness only |
| specs/session placeholders | Composer | safe unknown placeholders possible | PASS | yes |
| permission boundary | Composer/Trading Brain | all permissions can be forced false | PASS | yes |
| required-token validation | Writer | token list can be expanded additively | PASS | yes |
| output schema compatibility | Writer/Composer | additive block, no old fields removed | PASS | no destructive patch |

## Patch Scope Table

| File | Status | Reason |
|---|---|---|
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh | patched | direct summary owner |
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh | patched | required-token protection |
| mt5/core/ASC_Version.mqh | patched | compile-visible identity/package/next-run control |
| ASC_SymbolDataPackContracts.mqh | inspected, untouched | fields already source-owned |
| ASC_SymbolDataPackRouting.mqh | inspected, untouched | route helpers sufficient |
| ASC_FileIO.mqh | untouched | forbidden; not needed |
| Dispatcher/Scanner/FunctionResults | untouched | RUN217 preservation only |
| Dossier/Current Focus | untouched | no implementation scope |

## DATA / DOSSIER CLEANLINESS AND TRUTHNESS CHECK

| Cleanliness Item | In Scope For RUN220? | Action | Forbidden Drift |
|---|---:|---|---|
| DATA PURITY SUMMARY | yes | added final key=value block | no signal/trade readiness |
| Siam parser readability | yes | consistent grouped summary fields | no hidden computation |
| identity summary | yes | included RUN218 fields | no route/asset confusion |
| duplicate context summary | yes | included RUN219 fields | no trade canonical |
| data-readiness summary | yes | readiness=data review only | no strategy permission |
| Dossier readability | no implementation | backlog only | no broad Dossier rewrite |
| specs/session summary | placeholders only | unknown until RUN221 | no hydration implementation |
| section coherence | no implementation | scheduled RUN222 | not implemented |
| debug/body split | no implementation | scheduled RUN223 | not implemented |
| crypto health gates | no implementation | scheduled RUN224 | not implemented |

## Multi-Domain Research Ledger

| Research Lane | Source / Authority | Finding | Converted RUN220 Constraint | Falsifier |
|---|---|---|---|---|
| MQL5 strings | Official MQL5 StringLen/StringFind/StringConcatenate docs | string assembly and token search are standard mechanics | additive key=value text and required-token validation only | compile String* mismatch or missing token |
| MQL5 files | Official MQL5 FileMove/File functions docs | file operations are sandboxed and rewrite behavior is explicit | no FileIO/path patch in RUN220 | any FileIO/path change in package |
| Data quality | IBM/Collibra/common DQ dimensions | completeness, validity, consistency, traceability, explicit missingness matter | summary fields must expose identity, validity, missingness, and readiness | summary hides unknowns or claims fake true |
| Secure SDLC | source-control discipline | bounded root-cause patch beats broad rewrite | Composer + Writer + Version only for source patch | broad rewrite or evidence mutation |
| Threat model/protected lattice | Aurora Brain/Trading Brain | data-readiness cannot cross into trade-readiness | all permission fields false and token-protected | trade/signal wording appears |
| Observability/SRE | compact health-summary practice | machine-readable health needs count and reason | `critical_purity_errors_count` + `ready_for_siam_reason` | Siam still must manually infer critical state |
| Prompt/execution control | Truth Furnace protocol | exact scope, package, next run, one decision | RUN221 seeded, RUN227 preserved, TEST FIRST | control points to live too early |

## Brain Guidebook / Two-Brain Check

| Guidebook | Read? | Key Rule Extracted | Converted RUN220 Constraint | Patch Needed? |
|---|---:|---|---|---:|
| AURORA_GUIDEBOOK_INDEX.md | yes | guidebooks are mandatory run law | report includes Brain check | yes, amendment |
| AURORA_CODING_BRAIN_GUIDEBOOK.md | yes | summary blocks copy source truth, not invent it | only existing fields summarized; unknown placeholders | yes, amendment |
| AURORA_TRADING_BRAIN_GUIDEBOOK.md | yes | clean data is not trade permission | false permission fields required | yes, amendment |

### Brain 1 — Builder

Smallest source patch: add one Composer summary helper, call it once near the payload end, expand Writer required tokens, advance Version/control. Fields summarized from existing source-owned facts: RUN207/RUN218/RUN219 plus source identity and route context. Fields remaining unknown: specs/session/ATR/VWAP/indicator hydration. Untouched files: FileIO, path constants, membership/ranking/HUD/Market Board/trade/risk owners.

### Brain 2 — Auditor

Primary failure mode: `ready_for_siam_review` could sound like trade readiness. Mitigation: exact field name, hard boundary, permission fields false, Trading Brain amendment, and required-token validation. Secondary risks: fake hydration, double-counted errors, hidden missingness, broad Composer bloat, token mismatch, output mutation, and owner drift. Mitigation: unknown placeholders, compact critical list, additive block only, no output files included.

## Boundary Contract / Protected Lattice

| Boundary | System A | System B | Lawful Interface | Source Of Truth | Allowed Crossing | Forbidden Crossing | Acceptance Criteria | HOLD / KILL Condition |
|---|---|---|---|---|---|---|---|---|
| source facts ↔ summary block | Composer fields | DATA PURITY SUMMARY | summarization only | existing source-owned fields | key=value summary | hidden recomputation | summary matches source | fake derived truth |
| data-readiness ↔ trade-readiness | Siam review | trading decision | data review only | Trading Brain boundary | ready_for_siam_review | signal/trade ready | all permissions false | trade wording |
| implemented facts ↔ placeholders | current source | future runs | explicit unknown | source owners | missingness labels | fake hydration | no hidden assumptions | fake true |
| duplicate context ↔ summary | RUN219 fields | summary | copied scope | Composer | context labels | trade canonical | route_context_only | hidden selector |
| asset identity ↔ summary | RUN218 fields | summary | copied identity | ClassificationBridge/Composer | asset/bucket fields | route as asset | asset survives GlobalTop10 | identity missing |
| data cleanliness ↔ truth accuracy | readability | factual proof | grouping only | source owner | cleaner summary | removing raw proof | easier audit | proof hidden |

## Static Compile-Risk Sweep

| Static Check | Result | Evidence | Patch Needed? |
|---|---|---|---:|
| missing include risk | low | Composer already indirectly includes Version through Contracts/Routing path; existing macros were already used | no |
| undefined helper/accessor risk | medium | new helpers use existing Contract structs/functions and ClassificationBridge helpers | compile required |
| duplicate function/macro risk | low | new helper names are RUN220-specific | no |
| string quote/escape risk | low | balanced braces/parentheses; key=value lines use `\n` | compile required |
| StringFormat argument mismatch risk | none introduced | no StringFormat added | no |
| enum/route mismatch risk | low | existing route enum/helper used | no |
| bool/string conversion risk | low | bools converted via ASC_SymbolDataPackBoolText | no |
| required-token expansion risk | medium | token array expanded 88 -> 126 | compile/runtime token proof required |
| output schema compatibility risk | low | additive final block; no old fields removed | no |
| readiness wording risk | controlled | exact `ready_for_siam_review` only | no |
| fake hydration risk | controlled | future hydration fields unknown | no |
| critical error count risk | medium | conservative source-field count; live behavior unproven | RUN227 proof |
| RUN219 duplicate context regression risk | low | existing block untouched and summarized | no |
| RUN218 asset identity regression risk | low | existing block untouched and summarized | no |
| RUN217 reconciliation field regression risk | low | reconciliation source untouched | no |
| RUN207 data-purity regression risk | low | source fields read/summarized only | no |
| signal/trade wording risk | controlled | permissions false and boundary token-protected | no |

No compile proof is claimed because no MetaEditor output was supplied.

## RUN206 / RUN207 / RUN217 / RUN218 / RUN219 / RUN215 Preservation Check

| Protected Law | Expected | Source Evidence | PASS / HOLD / FAIL |
|---|---|---|---|
| RUN206 empty expected-set no-delete | preserved | Writer reconciliation logic not rewritten | PASS |
| no_committed_membership_no_delete | preserved | membership cleanup not touched | PASS |
| RUN217 exact reconciliation fields | preserved | reconciliation owners not patched except token list area | PASS |
| RUN218 asset_class/bucket/symbol_family | preserved | Asset block remains and summary copies it | PASS |
| RUN218 classification provenance | preserved | classification_source remains and summary copies it | PASS |
| RUN219 canonical_symbol_id | preserved | duplicate block remains and summary copies it | PASS |
| RUN219 duplicate route context | preserved | duplicate block remains and summary copies it | PASS |
| RUN219 no hidden selection/trade authority | preserved | summary adds false permission fields | PASS |
| final route publication behavior from RUN215 | preserved | FileIO/path/routing publication not changed | PASS |
| RUN207 no_sample semantics | preserved | invalid reasons read only | PASS |
| RUN207 tick/spread window_valid fields | preserved | fields read only | PASS |
| RUN207 CopyTicks cap/truncation | preserved | fields read only | PASS |
| RUN207 last_price availability/status/raw | preserved | status/availability summarized | PASS |
| RUN207 absence_state/absence_reason | preserved | fields summarized | PASS |
| Top5PerBucket route_bucket_name=Crypto clean | preserved | existing route_bucket_name logic reused | PASS |
| no signal/trade permission | preserved | all permissions false | PASS |
| RUN227 remains next live proof | preserved | Version/control keep RUN227 | PASS |

## Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| ready_for_siam_review can help Siam | ready_for_siam_review could be mistaken as trade readiness | user/Siam pressure | Trading Brain guidebook | 2 | 3 | Trading Brain boundary | field is explicitly data-review only and permissions false | no |
| ATR/VWAP/indicator sections exist in body | hydration summary could claim true without dedicated proof | Composer body | RUN220 field contract | 3 | 3 | conservative safety | emit unknown, defer refinement | no |
| summary counts zero critical errors | missing future hydration may still exist | Composer policy | RUN221 backlog | 3 | 3 | RUN220 policy | future hydration unknown makes limited, not no | no |

## Patch Ledger

| File | Change |
|---|---|
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh | added purity helpers and final DATA PURITY SUMMARY emission |
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh | expanded required token array from 88 to 126 and added summary tokens |
| mt5/core/ASC_Version.mqh | advanced RUN220 identity/package/next-source-run macros |
| office/*.md | prepended RUN220 status/work/change/decision records |
| roadmap/Truth Seeker/*.md | updated active roadmap, roadmap, package manifest, run template |
| Guidebooks | added RUN220 coding/trading/index amendments |
| RUN220R_REPORT.md | created |

## Package Validation Table

| Check | Result |
|---|---|
| exact package name | TRUTH_SEEKER_RUN220R.zip |
| changed files only | yes |
| original folder layout preserved | yes |
| RUN220R_REPORT included | yes |
| generated runtime output excluded | yes |
| generated Symbol Data Packs excluded | yes |
| generated Dossiers excluded | yes |
| generated Manifest/Scanner/FunctionResults evidence excluded | yes |
| Experts/Journal logs excluded | yes |
| whole repo excluded | yes |
| forbidden suffix absent | yes |

## Exact RUN221 Prompt Seed

```text
TRUTH SEEKER ROADMAP — RUN221R / SPECS + SESSION HYDRATION FLAGS AND MISSINGNESS SUMMARY — MAKE BROKER SPEC AND SESSION READINESS EXPLICIT WITHOUT FAKE HYDRATION
MODE: AUDIT + PATCH
LIVE: no
PACKAGE: TRUTH_SEEKER_RUN221R.zip
PURPOSE:
- improve DATA PURITY SUMMARY and Symbol Data Pack body by adding explicit broker specs/session hydration flags and missingness lists
- do not fake actual specs/session values if source owner is not present
- expose symbol_specs_hydrated and session_facts_hydrated truthfully
- add missing_specs and missing_session_facts where applicable
- preserve RUN220 DATA PURITY SUMMARY
- preserve RUN219 duplicate context
- preserve RUN218 asset identity
- preserve RUN217 reconciliation observability
- preserve RUN207 data-purity fields
- preserve RUN206 no-delete safety
- no generated output request
- no output mutation
- no FileIO/path/membership/ranking/HUD/Market Board/trade logic change
- include data/Dossier cleanliness side job only as minor grouping/readability protection
```
