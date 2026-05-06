# RUN260R_REPORT — Manifest + Scanner Status Required-Token Poison Completion

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN260R / MANIFEST + SCANNER STATUS REQUIRED-TOKEN POISON COMPLETION WITH MANDATORY INTERNET RESEARCH — REPAIR RUN259 HALF-PATCH, REMOVE ACTIVE STALE RUN160/RUN253 REQUIRED TOKENS, CONVERT OFFICIAL MQL5/SRE/DATA-CONTRACT RESEARCH INTO ACCEPTANCE TESTS, AND DO NOT START MAIN/LITE UNTIL CORE PROOF SURFACES ARE CLEAN
MODE: RESEARCH + DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN260R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN260R.zip
SOURCE BASELINE: RUN259R heartbeat/Manifest/Deep-trigger repair package
EXPECTED DECISION: TEST FIRST

## 2. FINAL SUMMARY

RUN260R performed mandatory internet/external research before patching and converted it into source constraints, acceptance tests, telemetry requirements, falsifiers, and forbidden patch patterns.

The RUN259 contradiction was confirmed. The RUN259 report claimed stale Manifest/Scanner required-token poison was patched, but direct RUN259 source inspection found active required-token entries still carrying legacy RUN157/RUN158/RUN159/RUN160/RUN253 future-live law and stale-live-context tokens.

RUN260R surgically patched only required-token/body alignment surfaces:
- `mt5/runtime/ASC_Dispatcher.mqh`: Manifest stable current body fields were upgraded to RUN260 schema identity and permission boundary fields, and active stale required-token entries were replaced with stable emitted tokens.
- `mt5/artifacts/ASC_ScannerStatusWriter.mqh`: Scanner Status now emits compact stable current source/version/timestamp/schema/role/permission/poison-guard tokens, and active stale required-token entries were replaced with emitted stable tokens.
- `mt5/core/ASC_Version.mqh`: source run identity moved to RUN260R and next-source/live sequence moved to RUN261/RUN262/RUN263.
- Brain Guidebook doctrine was strengthened only where it prevents recurrence: serious runtime/proof/file/timer/lineage/retry/backoff patch runs must convert external research into enforceable constraints/tests/falsifiers before patching.

No Main/Lite architecture, archive topology, FileIO, final paths, generated output, L3/L4 ranking/membership/formula, HUD, Dossier architecture, strategy, signal, trade, execution, or risk logic was changed.

Active required-token arrays in the touched Manifest and Scanner Status write paths no longer contain the searched stale active required-token patterns: `RUN160`, `RUN159`, `RUN158`, `RUN157`, `RUN253`, `RUN242`, `next_live_run`, `legacy_phase8_status`, `bucket_fill_source_readiness`, or `legacy_run160`.

Manifest RUN260 stable replacement-token parity passes source inspection. Scanner Status RUN260 stable replacement-token parity passes source inspection. Compile was not run in this environment and no MetaEditor transcript was supplied, so no compile-clean proof is claimed.

Main/Lite can proceed only after operator compile check or exact compile errors. Recommended next run if compile is clean: RUN261R Main/Lite mirror contract repair. If compile fails: compile repair only.

Final decision: TEST FIRST.

## 3. Mode Declaration

| Declaration | Answer |
|---|---|
| current run | RUN260R |
| primary mode | RESEARCH + DEBUG + PATCH |
| source baseline | RUN259R package |
| internet research required? | yes, performed before patch |
| patch allowed before research ledger? | no |
| source patch allowed? | yes, required-token poison completion only |
| Main/Lite patch allowed? | no |
| archive topology patch allowed? | no |
| GlobalTop10 route rewrite allowed? | no |
| FileIO rewrite allowed? | no |
| final path mutation allowed? | no |
| generated output editing allowed? | no |
| L3/L4 mutation allowed? | no |
| HUD patch allowed? | no |
| strategy/signal/trade/risk patch allowed? | no |
| compile transcript required if compile succeeds? | no |
| compile errors required if compile fails? | yes |
| final serious decision | TEST FIRST |

## 4. Evidence Ladder

| Evidence | Class | What It Proves | What It Does Not Prove |
|---|---:|---|---|
| AI reasoning | 1 | Planning and risk analysis only | Source truth, compile, runtime, edge, live safety |
| RUN259R report text | 3 | What RUN259R claimed inside package evidence | That the source actually matches the claim |
| Direct RUN259R source inspection | 3 | Active required-token array contents and patched source text | Compile cleanliness or live refresh correctness |
| Mandatory internet/external research | supporting constraint | External behavior constraints for patch design/tests | Aurora source correctness or runtime success |
| Static source checks in this run | 3 | Required-token array stale-pattern absence, index assignment, obvious string literal risk | MetaEditor compile proof |
| MetaEditor compile transcript | not supplied | Not available | Cannot claim class-4 compile proof |
| Runtime/live proof | not supplied | Not available | Cannot claim heartbeat/live refresh/Main-Lite/archive proof |

## 5. Mandatory Internet / External Research Conversion Ledger

| Source URL / Citation | Research Lane | Finding | Aurora Risk | Converted Coding Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|---|
| https://www.mql5.com/en/docs/event_handlers/ontimer | MQL5 timer/event behavior | Timer events are queued per program and a new Timer event is not added if one is already queued or processing. | Repeated validation poison can occupy the timer lane and starve refresh. | Required-token validation must be cheap, deterministic, and must not loop/retry heavily inside the timer path. | Manifest/Scanner required-token lists contain only emitted stable tokens and do not create repeated missing-token failures. | FunctionResults or writer state repeatedly reports the same missing token while refresh stops. |
| https://www.mql5.com/en/docs/event_handlers | MQL5 event behavior | Events are handled one after another; infinite loops in event handlers are strongly discouraged. | Long handlers plus validation failures can silently discard later events. | Degraded truthful status is preferred over blocking refresh or broad handler rewrites. | No broad OnTimer/handler rewrite was made; patch only changes token/body alignment. | Patch changes event architecture, handler cadence, route membership, or hidden loops. |
| https://www.mql5.com/en/docs/files/fileopen | MQL5 file behavior | FileOpen failure is observable by invalid handle / sandbox constraints. | Missing output can be misread as proof if errors are not exposed. | Do not infer proof from absent files; token failure must expose missing token or write reason. | Existing missing-token telemetry remains intact; no FileIO rewrite or generated-output edit. | Patch deletes/cleans files or hides writer error state as proof. |
| https://www.mql5.com/en/docs/files/filemove | MQL5 file promotion behavior | FileMove returns false on failure and rewrite rules matter. | Promotion failure adjacent to validation can produce stale active surfaces. | Do not mutate final paths or promotion semantics in this run. | Diff shows no FileMove/final path mutation. | FileMove flags, final paths, or promotion flow changed. |
| https://www.mql5.com/en/docs/files/filedelete | MQL5 file deletion behavior | FileDelete returns false on failure and operates inside sandbox paths. | Cleanup/deletion can destroy evidence and fake a clean state. | No generated evidence deletion or folder cleanup allowed. | Package contains no generated dumps and no FileDelete changes. | Any generated output edited/deleted as proof. |
| https://www.mql5.com/en/docs/check/getlasterror and https://www.mql5.com/en/docs/common/resetlasterror | MQL5 error capture | Error code capture should follow reset/call/fetch discipline. | Adjacent FileIO validation may lose true failure reason. | Preserve existing writer error propagation; do not suppress missing-token reason. | No last-error/file telemetry suppression introduced. | Missing-token or file error reason becomes `success`/blank/no-op. |
| https://sre.google/sre-book/monitoring-distributed-systems/ | SRE monitoring | Monitoring must expose symptoms and causes; low-noise actionable signals matter. | Scanner/Manifest can become noisy proof theater while hiding true missing-token cause. | Required-token failure must identify exact missing token and stay operator-actionable. | Stale required tokens removed; stable current proof fields remain visible. | Status reports complete while active required tokens are stale or absent from body. |
| https://sre.google/sre-book/addressing-cascading-failures/ | SRE cascading failure | Overload and cascading failure require limiting amplification sources. | Repeated validation failure can amplify heartbeat overload. | Treat stale required-token poison as a recurring failure source, not cosmetic prose. | Required-token poison removed from active arrays before Main/Lite. | Same stale token can still fail every refresh. |
| https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ | Retry/backoff reliability | Retries can worsen overload if unbounded. | Retrying poisoned validation can steal timer budget. | Do not add retry loops; make validation pass/fail deterministically on emitted stable fields. | No retry/backoff/file queue logic changed; required tokens now match emitted stable fields. | Patch adds retry loop, sleep, heavy scan, or repeated validation lane. |
| https://docs.open-metadata.org/latest/how-to-guides/data-contracts/spec | Data contracts | Contracts specify schema/quality expectations that must be enforceable. | Manifest/Scanner Status without stable schema fields becomes untestable. | Stable contract fields required: source id/version, timestamp, schema/role, proof completeness, permission false. | RUN260 body and required tokens include stable schema/role/timestamp/permission fields. | Any active required token is a legacy future-run claim instead of a current contract field. |
| https://openlineage.io/docs/spec/facets/ | Lineage/provenance | Run/job/dataset facets carry contextual metadata about what ran and outputs. | Artifact surfaces lose provenance and can be mistaken for current truth. | Keep source_run_id/source_version/artifact role/schema visible. | Manifest and Scanner Status stable source/version/schema/role fields present. | Artifact lacks current source/version/schema role after patch. |
| https://www.w3.org/TR/prov-overview/ | Provenance | Provenance captures entities, activities, people, derivation, versioning, and trust assessment. | Old future-run claims can masquerade as current proof. | Legacy context may exist only as non-required history; current proof requires stable provenance fields. | Active required arrays contain current stable fields only for patched poison slots. | Legacy live-contract token remains active required validation. |

Research is supporting constraint only. It does not prove Aurora works.

## 6. RUN259 Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| RUN259R Manifest stale-token poison patched | RUN259R source still had old RUN158/RUN159/RUN160/RUN253 required tokens active | RUN259R report | `ASC_Dispatcher.mqh` required_tokens | 3 | 3 | source code | RUN260R replaced active stale required tokens with stable emitted current tokens | yes until fixed |
| RUN259R Scanner Status token risk patched | Scanner Status still had stale RUN157/RUN158/RUN159/RUN160/RUN253 required tokens active | RUN259R report | `ASC_ScannerStatusWriter.mqh` required_tokens | 3 | 3 | source code | RUN260R replaced active stale required tokens with emitted stable current tokens | yes until fixed |
| RUN259R research requirement satisfied | RUN259R did not enforce a visible pre-patch research-to-tests gate strongly enough to prevent half-patch recurrence | RUN259R report | doctrine + current user mandate | 3 | 3 | doctrine + source inspection | RUN260R performed mandatory internet research and patched guidebook recurrence gate | yes until fixed |

## 7. Required-Token Source Audit

| File | Token / Pattern | Current Role Before RUN260 | Required? Before | Emitted By Body? | Stable Current? | RUN260 Action |
|---|---|---|---:|---:|---:|---|
| `ASC_Dispatcher.mqh` | `RUN158R Displayed-Symbol Reprint / Queue Progress Manifest:` | section label used as active required token | yes | yes | no | replaced with `displayed_symbol_set_source=L4_snapshot` |
| `ASC_Dispatcher.mqh` | `run158r_displayed_symbol_5min_reprint_queue_progress_telemetry=true` | old run-labeled required token | yes | yes via helper | no | replaced with `displayed_symbol_set_not_rank_owner=true` |
| `ASC_Dispatcher.mqh` | `legacy_run159r...RUN160...RUN253R=true` | stale live-contract required token | yes | yes via legacy helper | no | replaced with `source_run_id=` |
| `ASC_Dispatcher.mqh` | `bucket_fill_source_readiness=legacy_closed_for_RUN160...RUN253R` | stale required token | yes | yes via legacy helper | no | replaced with `source_version=` |
| `ASC_Dispatcher.mqh` | `legacy_run160_live_contract...RUN253R=true` | stale required token | yes | yes via legacy helper | no | replaced with permission/source/schema stable current tokens |
| `ASC_Dispatcher.mqh` | `legacy_phase8_status=...RUN159...RUN160...RUN253R` | stale required token | yes | yes via legacy helper | no | replaced with `required_token_policy=stable_current_fields_only` |
| `ASC_ScannerStatusWriter.mqh` | `claim_evidence_live_unproven_until_RUN253=true` | stale live-checkpoint required token | yes | yes | no | replaced with `claim_evidence_runtime_visibility` |
| `ASC_ScannerStatusWriter.mqh` | `current_live_proof_run=RUN253R` | stale current-live required token | yes | yes | no | replaced with `source_version=` |
| `ASC_ScannerStatusWriter.mqh` | `run157r_speed_truth_fill...` | old run-labeled required token | yes | yes via helper | no | replaced with `guidebooks_do_not_create_live_proof=true` |
| `ASC_ScannerStatusWriter.mqh` | `legacy_phase8_status=...RUN157/RUN158/RUN159...RUN160...RUN253R` | stale required token | yes | yes via helper | no | replaced with scanner status role/schema/policy tokens |
| `ASC_ScannerStatusWriter.mqh` | `legacy_run159r...RUN160...RUN253R=true` | stale required token | yes | yes via helper | no | replaced with `source_version=` |
| `ASC_ScannerStatusWriter.mqh` | `bucket_fill_source_readiness=legacy_closed_for_RUN160...RUN253R` | stale required token | yes | yes via helper | no | replaced with `generated_utc=` |
| `ASC_ScannerStatusWriter.mqh` | `legacy_run160_upload_contract_current_RUN253...` | stale required token | yes | yes via helper | no | replaced with permission false stable tokens |
| `ASC_ScannerStatusWriter.mqh` | `legacy_run_label_policy=old_phase_and_run_labels_are_legacy_current_live_proof_RUN253R` | stale required token | yes | yes | no | replaced with `required_token_policy=stable_current_fields_only` |
| `ASC_Constants.mqh` | legacy RUN157/RUN158/RUN159 constants | non-required historical helper constants | no active required after RUN260 | yes, legacy context only | no current proof | left as non-required historical context |
| `ASC_Version.mqh` | RUN259 identity | source identity | n/a | n/a | stale after patch | updated to RUN260R |

## 8. Manifest Token Parity Table

| Required Token | Emitted In Manifest Body? | Stable Current? | PASS / FAIL |
|---|---:|---:|---|
| `source_run_id=` | yes | yes | PASS |
| `source_version=` | yes | yes | PASS |
| `generated_utc=` | yes | yes | PASS |
| `manifest_schema_version=` | yes | yes | PASS |
| `artifact_bundle_manifest_role=` | yes | yes | PASS |
| `proof_complete=false` | yes | yes | PASS |
| `signal_permission=false` | yes | yes | PASS |
| `trade_permission=false` | yes | yes | PASS |
| `execution_permission=false` | yes | yes | PASS |
| `risk_permission=false` | yes | yes | PASS |
| `required_token_poison_guard=RUN260R_stale_legacy_tokens_non_required` | yes | yes | PASS |
| `required_token_policy=stable_current_fields_only` | yes | yes | PASS |

Hard-fail scan result for active Manifest required-token assignments: no case-insensitive matches for `RUN160`, `RUN159`, `RUN158`, `RUN157`, `RUN253`, `RUN242`, `next_live_run`, `legacy_phase8_status`, `bucket_fill_source_readiness`, or `legacy_run160`.

## 9. Scanner Status Token Parity Table

| Required Token | Emitted In Scanner Status Body? | Stable Current? | PASS / FAIL |
|---|---:|---:|---|
| `source_run_id=` | yes | yes | PASS |
| `source_version=` | yes | yes | PASS |
| `generated_utc=` / status timestamp | yes | yes | PASS |
| `scanner_status_role=current` | yes | yes | PASS |
| `scanner_status_schema_version=RUN260R_scanner_status_contract_v1` | yes | yes | PASS |
| `signal_permission=false` | yes | yes | PASS |
| `trade_permission=false` | yes | yes | PASS |
| `execution_permission=false` | yes | yes | PASS |
| `risk_permission=false` | yes | yes | PASS |
| `required_token_poison_guard=RUN260R_stale_legacy_tokens_non_required` | yes | yes | PASS |
| `required_token_policy=stable_current_fields_only` | yes | yes | PASS |

Hard-fail scan result for active Scanner Status required-token assignments: no case-insensitive matches for `RUN160`, `RUN159`, `RUN158`, `RUN157`, `RUN253`, `RUN242`, `next_live_run`, `legacy_phase8_status`, `bucket_fill_source_readiness`, or `legacy_run160`.

## 10. Patch Scope Applied

| File | Change |
|---|---|
| `mt5/runtime/ASC_Dispatcher.mqh` | Manifest RUN260 schema line, explicit source identity/schema fields, full no-permission boundary, stable poison guard/policy, stale required-token replacements. |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | Scanner Status stable compact source/version/timestamp/schema/role/permission body line and stale required-token replacements. |
| `mt5/core/ASC_Version.mqh` | RUN260 identity, package name, next run sequence, evidence ceiling and boundary constants. |
| `roadmap/Truth Seeker/Guidebooks/AURORA_GUIDEBOOK_INDEX.md` | Added narrow runtime proof research conversion gate. |
| `roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md` | Added required-token research-to-test coding gate and falsifier. |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN260R_REPORT.md` | This report. |

## 11. Static Compile-Risk Check

| Compile Risk | PASS / FAIL | Notes |
|---|---|---|
| required_tokens array size still matches highest used index | PASS | Dispatcher Manifest array: 203 assigned indexes 0-202. Scanner Status array: 435 assigned indexes 0-434. |
| no duplicate index accidentally overwrites another token | PASS | No duplicate assigned indexes detected in touched required-token arrays. |
| no out-of-range index | PASS | Highest touched Manifest index 202 within 203; highest Scanner Status index 434 within 435. |
| no missing semicolon | PASS by text inspection | New/modified lines end with semicolon where required. |
| no broken string literal | PASS by crude static quote-balance check | Touched files have zero odd-quote lines. |
| no accidental token concatenation | PASS | New emitted token lines are explicit newline-terminated body additions. |
| no removed variable needed elsewhere | PASS by scope | No variable or function removed. |
| no route logic mutation | PASS | No route membership/ranking logic changed. |
| no FileIO mutation | PASS | No FileOpen/FileMove/FileDelete/promotion/final path changes. |
| no final path mutation | PASS | No path constants or route final paths changed. |
| no Main/Lite mutation | PASS | No Main/Lite architecture files or layout changed. |
| no archive topology mutation | PASS | No archive route/layout logic changed. |
| no L3/L4 mutation | PASS | No scoring, formula, membership, ordering, cadence mutation. |
| no HUD mutation | PASS | HUD not touched. |
| no trade/signal/risk mutation | PASS | Only no-permission proof tokens added; no execution logic added. |

## 12. Brain Guidebook / Doctrine Patch Result

Guidebook patch was applied because the existing rule did not prevent RUN259 recurrence strongly enough.

| File | Result |
|---|---|
| `AURORA_GUIDEBOOK_INDEX.md` | Added RUN260R Runtime Proof Research Conversion Gate. |
| `AURORA_CODING_BRAIN_GUIDEBOOK.md` | Added RUN260R Coding Brain Patch for required-token validators and active/body parity falsifier. |
| `AURORA_TRADING_BRAIN_GUIDEBOOK.md` | Read/checked. No patch needed; no trade/signal/risk logic touched. |

No ornamental doctrine added: each new paragraph prevents a known recurrence failure.

## 13. Roadmap After RUN260

| Run | Purpose | Why |
|---|---|---|
| compile repair only | if operator compile fails | exact compile errors outrank roadmap sequence |
| RUN261R | Main/Lite mirror contract repair | Lite must mirror Main route/folder/symbol/epoch exactly after proof surfaces are clean |
| RUN262R | Lite archive topology repair | Archive must become family-snapshot timestamp folder, not per-symbol scatter |
| RUN263R | bounded live proof | prove heartbeat, refresh, Main/Lite, archive after source gates |

Do not proceed to Main/Lite if compile fails or if any stale active required-token poison reappears.

## 14. Package Validation Table

| Check | PASS / FAIL | Notes |
|---|---|---|
| package name exactly `TRUTH_SEEKER_RUN260R.zip` | PASS | Created exact name. |
| changed files only | PASS | Package contains only changed source/control/report files. |
| original folder layout preserved | PASS | All files nested under `Aurora Sentinel Core/...`. |
| no generated output dumps packaged | PASS | No runtime/generated evidence included. |
| no `_2`, `(1)`, `_copy`, `final`, `fixed`, `updated`, `new`, `CHANGED_FILES_WINDOWS_SAFE`, `REPORT_ONLY_WINDOWS_SAFE` suffix | PASS | Clean package name. |
| no production-ready claim | PASS | Decision is TEST FIRST. |
| no edge/signal/trade/execution/risk permission | PASS | Permission tokens remain false. |

## 15. Final Decision

TEST FIRST.

Strongest next move: operator compiles RUN260R. If compile is clean, proceed to RUN261R Main/Lite mirror contract repair. If compile fails, stop and repair exact compile errors only.
