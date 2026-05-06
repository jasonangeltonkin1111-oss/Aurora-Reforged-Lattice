# RUN251R Report — Source Invariant Hardening After RUN250 Compile-Clean

## GIT HEADER SUMMARY

```text
TRUTH SEEKER ROADMAP — RUN251R / SOURCE INVARIANT HARDENING AFTER RUN250 COMPILE-CLEAN — LOCK ARTIFACT REFRESH, GLOBALTOP10 FORWARD PROGRESS, DOSSIER/SDP PARITY, AND NO-STALL PROOF BEFORE LIVE
MODE: AUDIT + DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN251R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN251R.zip
SOURCE BASELINE: RUN250R COMPILE-CLEAN SOURCE STATE
NEXT RUN: RUN252R SIAM DATA-PURITY / READABILITY SEMANTICS CLEANUP
NEXT LIVE TEST: RUN253R
DECISION: TEST FIRST
```

## Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN251R |
| primary mode | AUDIT |
| secondary mode | DEBUG + PATCH |
| live run? | no |
| runtime/output artifacts expected? | no new runtime output |
| source editing allowed? | yes, source-invariant hardening only |
| generated output editing allowed? | no |
| generated output cleanup allowed? | no |
| FileIO rewrite allowed? | no |
| final path mutation allowed? | no |
| current route membership change allowed? | no |
| folder-derived membership truth allowed? | no |
| archive-as-current-truth allowed? | no |
| flat-root SDP re-enable allowed? | no |
| public SDP staging re-enable allowed? | no |
| Siam semantic cleanup allowed? | no; seed RUN252R |
| L3 behavior/gate change allowed? | no |
| L4 ranking/order/formula change allowed? | no |
| HUD patch allowed? | no |
| Dossier architecture rewrite allowed? | no |
| strategy/signal/trade/risk patch allowed? | no |
| next source run | RUN252R |
| next live test | RUN253R |
| production-ready claim allowed? | no |
| edge claim allowed? | no |
| signal/trade permission allowed? | no |
| final serious decision | TEST FIRST |

## Evidence Ladder

| Evidence Item | Class | What It Proves | What It Does Not Prove |
|---|---:|---|---|
| User-reported RUN250 compile clean | 4 | RUN250 syntax/build compatibility was reportedly clean before RUN251 edits. | RUN251 compile, runtime behavior, artifact refresh, GlobalTop10 publication, SDP parity, live readiness, edge. |
| Direct RUN251 source inspection | 3 | Current source shape, ownership boundaries, patch locations, preserved paths. | Compile success, runtime success, live publication success. |
| Static local text checks | 4-lite | Touched files have balanced braces/parentheses/brackets in text and new helper references are visible. | MetaEditor semantic compile, MQL5 type resolution, runtime behavior. |
| Official/external research | constraint evidence | MQL5/SRE constraints for timer queue, file operations, function-call contracts, error handling, overload/retry behavior. | Aurora source correctness or live proof. |
| RUN253 future live test | not performed | Nothing yet. | Everything runtime-facing remains unproven. |

## No-Live / No-Output Boundary

RUN251R did not request, generate, edit, clean, rename, package, or reinterpret generated runtime evidence as source truth. Prior Upcomers evidence was read-only intake. Generated Symbol Data Packs, Dossiers, Market Board, Scanner Status, Manifests, FunctionResults runtime evidence, Experts logs, and Journal logs were excluded.

## Required Read Order / Context Debts

| Area | Status |
|---|---|
| RUN244R-RUN250R reports | Read for continuity and preservation law. |
| Prior Upcomers runtime evidence | Present under `evidence/Upcomers-Server`; treated read-only only. |
| Brain Guidebooks | Read and converted into constraints: no fake proof, no signal/trade permission, L4 transparency is not edge proof. |
| README / MASTER_INDEX / CHAT_CONTINUATION_GUIDE / FRONT_DOOR_CHECKLIST / ASC_CORE | Read. ASC remains upstream scanner/truth-production, not trade selector. |
| Office/control files | Read and updated. |
| `mt5/AuroraSentinelCore.mq5` | Read. Compile entry preserved. |
| `mt5/runtime/ASC_Dispatcher.mqh` | Primary source owner inspected and patched. |
| `mt5/core/ASC_Version.mqh` | Control identity patched. |
| Constants / Types / RuntimeState / FunctionResults | Inspected for owner/state/signature risk. |
| Dossier / SDP / artifact writers | Inspected for boundary. No writer-owned ranking/membership added. |
| `mt5/io/ASC_FileIO.mqh` | Read-only; untouched. |
| Deep selective analysis / L3 / L4 / HUD | Read-only; untouched. |
| `mt5/artifacts/ASC_DossierComposer.mqh` and `ASC_DossierContracts.mqh` at prompt-listed root paths | Absent at those exact paths; dossier files exist under `mt5/artifacts/dossier/`. Context debt recorded; no fake content. |

## Internet / External Research Conversion Ledger

| Source URL / Citation | Research Lane | Finding | Aurora Risk | Converted Coding Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|---|
| https://www.mql5.com/en/docs/event_handlers/ontimer | MQL5 OnTimer | Timer events are serialized; if a Timer event is already queued/processing, a new one is not added. | Heavy heartbeat work can starve keepalive while logs still appear alive. | Cheap core keepalive must be scheduled before expensive work; no infinite heartbeat work; preflight before deep/route work. | Source shows core keepalive stale guard and budget-preflight telemetry. | Next live shows heartbeat continues while Market Board/Scanner/Manifest/Snapshot age silently grows without reason. |
| https://www.mql5.com/en/docs/event_handlers | MQL5 Event Handling | Handler signatures must match exactly; events are processed one after another. | New helpers or call contract drift can compile-break or stall event flow. | No touched function signatures unless callsites/declarations match; new helpers are local and referenced after prototype/definition. | Static helper-reference sweep and MetaEditor compile. | MetaEditor reports undeclared identifier/wrong parameter count. |
| https://www.mql5.com/en/docs/files/fileopen | MQL5 FileOpen | FileOpen failure and folder/path conditions matter at operation boundary. | Missing output route can be misdiagnosed as data failure when writer/admission never reached file operation. | Keep paths source-owned and log blocker/admission state; do not infer truth from folders. | Missing GlobalTop10 SDP path has source-owned reason after next live. | Route absent and no source-owned blocker/failure reason. |
| https://www.mql5.com/en/docs/files/filemove | MQL5 FileMove | FileMove returns bool; promotion/move success must not be guessed. | Staged files may be mistaken for final publication. | Promotion/write telemetry must capture false returns and avoid fake final. | Dossier final missing has promotion/blocker reason. | Staging exists, final absent, status claims success. |
| https://www.mql5.com/en/docs/basis/function/call | MQL5 function-call contracts | Calls are checked by argument number/type and declarations. | Helper/call mismatch can recreate RUN249 compile failures. | New helper has stable signature; no existing public signature changed. | MetaEditor compile clean after RUN251. | Wrong parameter count/undeclared helper errors. |
| https://www.mql5.com/en/docs/check/getlasterror and https://www.mql5.com/en/docs/common/resetlasterror | MQL5 error handling | Reset before operation and read error after failure; GetLastError does not reset by itself. | Promotion/write failure can be hidden by stale error state. | Failure telemetry should capture reason/error at operation boundary; RUN251 adds blocker state without rewriting FileIO. | Next live logs exact write/promotion blocker or error owner. | File operation fails but reason remains unavailable/guessed. |
| https://sre.google/sre-book/addressing-cascading-failures/ | SRE cascading failure | Overload can snowball when resources are exhausted and recovery paths compete with core service. | Deep trigger, GlobalTop10, archive, and presence sweep can amplify heartbeat pressure. | Prefer graceful degraded truth and cheap keepalive over heavy catch-up. | Stale surfaces get degraded keepalive scheduling, not silent starvation. | Recovery work prevents core artifacts from refreshing. |
| https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ | SRE retries/backoff | Poor timeout/retry choices can amplify outages; retries must be bounded/reasoned. | A stuck Top10 child can create retry storm or endless running cursor. | Retry count, next retry due, blocker owner, inflight age, batch age must be visible and bounded. | Source emits `globaltop10_child_retry_count` and `globaltop10_child_next_retry_due`. | Cursor remains stuck without retry/blocker/due telemetry. |

## RUN250 Compile-Clean Safety Gate

| RUN250 Item | Expected | Observed | PASS / HOLD / FAIL | Action |
|---|---|---|---|---|
| user supplied compile result | compile clean | User supplied compile-clean status for RUN250 | PASS with ceiling | Class 4 compile evidence only; RUN251 compile now outstanding. |
| RUN250 source identity | current | `ASC_Version.mqh` initially held RUN250R identity before patch | PASS | Preserve and advance to RUN251R. |
| artifact keepalive/rescue code | present | RUN250 keepalive existed, but Scanner Status was not explicitly stale-surface gated | PASS with gap | Hardened. |
| deep-trigger preflight guard | present | Pre-build guard before deep selective analysis existed | PASS | Preserved. |
| GlobalTop10 batch watchdog/recovery | present | Existing watchdog/retry/degraded path existed, but ambiguous `running` state could remain | PASS with gap | Hardened with explicit blocked states. |
| GlobalTop10 SDP committed snapshot fallback | present | Existing completed/fallback snapshot logic existed | PASS with gap | Added empty-snapshot and source-owned blocker reason. |
| Top5 Dossier/SDP parity telemetry | present | Existing route-count telemetry existed | PASS with gap | Added same-snapshot/proof-only parity tokens. |
| RUN246 GlobalTop10 repair | preserved | Markers and source-owned membership retained | PASS | Preserve. |
| RUN247 archive contract split | preserved | Archive not-current-truth law retained | PASS | Preserve. |
| RUN248 heartbeat telemetry intent | preserved | Keepalive/heartbeat telemetry retained | PASS | Preserve. |
| RUN249 compile repair | preserved | No telemetry scope regression introduced knowingly | PASS pending compile | Compile required. |
| FileIO untouched | yes | `mt5/io/ASC_FileIO.mqh` not edited | PASS | Preserve. |
| L3/L4 untouched | yes | L3/L4 files not edited | PASS | Preserve. |

## Source Invariant Audit

| Invariant | Source Owner | Current Source Evidence | Gap | Patch Needed? |
|---|---|---|---|---:|
| core artifact keepalive cannot be starved | `ASC_Dispatcher` | RUN250 keepalive existed for Market Board/Open Symbol Snapshot/Manifest. | Scanner Status not explicit in stale-surface gate; degraded contract not complete enough. | yes |
| deep trigger preflight happens before expensive build | `ASC_Dispatcher` / DeepSelectiveAnalysis | RUN250 pre-build guard present before `ASC_BuildDeepSelectiveAnalysisResult`. | No new source gap isolated. | no |
| GlobalTop10 batch cannot remain running forever without blocker | `ASC_Dispatcher` | Watchdog/retry state existed. | Deep-owner wait/retry-spacing could leave status too close to endless running. | yes |
| GlobalTop10 cursor has timeout/progress guard | `ASC_Dispatcher` | Cursor/inflight/retry state existed. | Need forward-progress invariant line on regular trace. | yes |
| GlobalTop10 Dossier promotion logs exact failure | Dispatcher / Dossier | Existing promotion path has blocker and route diagnostics. | No FileIO rewrite; source-owned reason must remain visible. | preserve |
| GlobalTop10 SDP has fallback/blocked reason | Dispatcher / SDP | Snapshot fallback present. | Empty source snapshot and dependency wording needed stronger source-owned blocker. | yes |
| Top5 Dossier/SDP parity visible per bucket | Dispatcher / Dossier / SDP | Existing route-count parity telemetry present. | Same-source-snapshot/proof-only boundary not explicit. | yes |
| archive history write cannot block current truth | SDP Writer / Dispatcher | Archive law and budget/route lifecycle exist. | No RUN251 source gap requiring patch. | no |
| stale active proof labels cannot mislead RUN253 | Version/helpers/status | Old tokens exist in historical/control surfaces. | Semantic cleanup belongs to RUN252, not RUN251 broad rewrite. | classify |
| no signal/trade permission leaks | all surfaces | Guidebooks and ASC core enforce no signal/trade permission. | No leak introduced. | no |

## Artifact Refresh Keepalive Hardening

Patched owner: `mt5/runtime/ASC_Dispatcher.mqh`.

Changes:
- Added Scanner Status to `ASC_Run250ArtifactKeepaliveRescueDue` stale-surface detection.
- Added keepalive telemetry declaring `Market_Board,Scanner_Status,Artifact_Bundle_Manifest,Open_Symbol_Snapshot`.
- Added `artifact_keepalive_budget_preflight=cheap_schedule_only`.
- Added `artifact_keepalive_fake_complete=false`.

Acceptance status: source now guarantees Scanner Status cannot be omitted from the core stale-surface keepalive law without an explicit source-visible reason. Runtime proof remains pending RUN253R.

## GlobalTop10 Forward-Progress Hardening

Patched owner: `mt5/runtime/ASC_Dispatcher.mqh`.

Changes:
- Added `ASC_Run251GlobalTop10ForwardProgressTrace`.
- Added `ASC_Run251RecordGlobalTop10ForwardProgress`.
- Added trace tokens: `globaltop10_forward_progress_state`, `globaltop10_forward_progress_reason`, `globaltop10_inflight_age_ms`, `globaltop10_batch_age_ms`, `globaltop10_child_retry_count`, `globaltop10_child_next_retry_due`, `globaltop10_blocker_owner`, `globaltop10_batch_cursor`, `globaltop10_not_folder_derived=true`, `globaltop10_route_membership_source=committed_l4_or_publication_shortlist_snapshot`, `globaltop10_sdp_dossier_dependency_state=source_snapshot_projection`.
- Converted deep-owner wait state to `blocked_waiting_deep_owner` with owner-pending/active/symbol reason.
- Converted retry-spacing state to `blocked_retry_due` with `child_retry_due`.
- Added forward-progress tick and retry-queued records.

Acceptance status: source should no longer leave `running cursor=N/10` without blocker/retry/due telemetry. Runtime proof remains pending.

## GlobalTop10 Dossier + SDP Route Invariant Hardening

Patched owner: `mt5/runtime/ASC_Dispatcher.mqh` at SDP GlobalTop10 mirror route boundary.

Changes:
- Strengthened no-snapshot reason to include source-owned route membership and dependency state.
- Added empty-source-snapshot block: `deferred_empty_globaltop10_snapshot`.
- Preserved `globaltop10_not_folder_derived=true` and committed L4/publication snapshot membership source.
- Did not change route paths, FileIO, final promotion paths, or membership/ranking owners.

Acceptance status: missing `Symbol Data Packs/GlobalTop10` after next live should have a source-owned reason instead of folder guessing.

## Top5 Dossier / SDP Parity Hardening

Patched owner: `mt5/runtime/ASC_Dispatcher.mqh` Top5 SDP route telemetry.

Changes:
- Preserved existing per-bucket route-count observability tokens.
- Added `top5_parity_same_snapshot_required=true`.
- Added `top5_parity_blocks_proof_not_current_truth=true`.

Acceptance status: next live can explain Top5 Dossier/SDP split without changing Top5 ranking/order/membership.

## Deep-Trigger / Presence-Sweep / Archive Budget Invariant

| Question | Source Finding | RUN251 Action |
|---|---|---|
| Deep-trigger preflight before expensive build? | RUN250 pre-build guard exists immediately before deep selective analysis build. | Preserved. |
| Expensive build cap/yield? | Not rewritten in RUN251; deep build remains exact owner boundary. | Deferred unless exact owner proof needed. |
| Presence sweep defer before expensive enumeration? | Existing budget/defer patterns inspected; no safe RUN251 patch isolated without broadening scope. | Preserved. |
| Archive history budget before write? | Archive nonblocking law inspected; FileIO untouched. | Preserved. |
| Failure/defer visible? | Existing telemetry present; RUN251 improves GlobalTop10 blocker side. | Preserved/hardened where exact owner found. |
| Can core keepalive be blocked? | Keepalive stale-surface contract hardened; Scheduler remains cheap/degraded. | Hardened. |

## Stale Active Proof Text Cleanup Classification

| Token | Found In Active Source? | Future-Facing Output? | Validator? | Runtime Blocker? | Action |
|---|---:|---:|---:|---:|---|
| RUN141 | yes, historical/report/control references | no | possible historical marker | no | Do not rewrite in RUN251; RUN252 semantic cleanup if active-output dangerous. |
| RUN145 | yes, historical/report/control references | no | possible historical marker | no | Same. |
| RUN150 | yes, historical/report/control references | low | possible historical marker | no | Same. |
| RUN155 | yes, historical/report/control references | low | possible historical marker | no | Same. |
| RUN160 | yes, older active token surfaces | possible | validator/continuity token | no | Seed RUN252 classification; no broad RUN251 rewrite. |
| RUN125 live proof text | yes in historical/roadmap text | possible if surfaced | historical proof text | no | Seed RUN252; no historical report rewrite. |
| phase8/phase9 | yes in roadmap/status semantics | yes-ish | semantic label | no | RUN252 target. |
| command/signal wording | no unsafe leak introduced | no | no-signal boundary retained | no | Preserve no-signal/no-trade wording. |

## Preservation Check

| Protected Area | Expected | PASS / HOLD / FAIL |
|---|---|---|
| RUN246 GlobalTop10 repair marker | preserved | PASS |
| RUN247 archive contract split | preserved | PASS |
| RUN248 heartbeat telemetry intent | preserved | PASS |
| RUN249 compile repair | preserved | PASS pending compile |
| RUN250 artifact refresh repair | preserved and hardened | PASS |
| Market Board Top10 remains consumer-only | yes | PASS |
| GlobalTop10 membership source | committed L4/publication snapshot only | PASS |
| SDP writer membership ownership | no | PASS |
| Dossier writer ranking ownership | no | PASS |
| Top5 SDP route | preserved | PASS |
| archive not-current-truth law | preserved | PASS |
| FileIO | untouched | PASS |
| final paths | unchanged | PASS |
| flat-root SDP | not re-enabled | PASS |
| public SDP staging | not re-enabled | PASS |
| L3 gates | unchanged | PASS |
| L4 ranking/order/formula | unchanged | PASS |
| HUD | untouched | PASS |
| generated output evidence | untouched | PASS |
| no signal/trade permission | preserved | PASS |

## Static Compile-Risk Sweep

| File | Static Check | Result | Patch Needed? |
|---|---|---|---:|
| `ASC_Dispatcher.mqh` | no undeclared helper/state refs obvious from local text | New helper has prototype/definition; calls occur after record-helper definition. | no |
| `ASC_Dispatcher.mqh` | no wrong parameter counts obvious from touched helper calls | New calls match helper signature by local text inspection. | no |
| `ASC_Dispatcher.mqh` | keepalive helper compiles | Braces/parentheses/brackets balanced; MetaEditor not run. | no local patch |
| `ASC_Dispatcher.mqh` | GlobalTop10 forward progress helper compiles | Prototype added before trace use; record helper defined before service calls. | no local patch |
| `ASC_Dispatcher.mqh` | Top5 parity telemetry compiles | String token append only. | no |
| `ASC_Dispatcher.mqh` | deep-trigger/preflight guards compile | Existing guard preserved. | no |
| `ASC_Dispatcher.mqh` | archive budget guard compiles | Existing archive law preserved; no FileIO/archive rewrite. | no |
| `ASC_FunctionResults.mqh` | signatures compile if touched | Not touched. | no |
| `ASC_RuntimeState.mqh` | fields compile if touched | Not touched; RUN251 reused existing state fields only. | no |
| `ASC_Constants.mqh` | constants compile if touched | Not touched. | no |
| `ASC_Version.mqh` | run identity updated | RUN251R identity/package/seed added. | no local patch |
| all touched files | no FileIO rewrite | PASS | no |
| all touched files | no final path mutation | PASS | no |
| all touched files | no L3/L4 behavior mutation | PASS | no |
| all touched files | no signal/trade wording | PASS | no |

MetaEditor compile was not rerun in this environment. Compile proof for RUN251R is outstanding.

## Two-Brain Check

### Brain 1 — Builder

- Remaining invariant gaps after RUN250: Scanner Status was not explicitly included in keepalive stale-surface detection; GlobalTop10 could still look like endless `running` without enough blocker/retry/due state; GlobalTop10 SDP no/empty source snapshot reasons needed stronger source-owned dependency language; Top5 parity needed same-source-snapshot/proof-only clarity.
- Smallest safe patch: Dispatcher-only telemetry/state hardening plus Version/control/report updates.
- Artifact refresh starvation prevention: cheap keepalive scheduling now names all four core surfaces and fake-complete=false.
- GlobalTop10 endless-running prevention: batch trace and key wait/retry branches now expose forward-progress state, blocker owner, cursor, inflight/batch age, retry count, and next retry due.
- Source-owned membership preservation: all new tokens state committed L4/publication snapshot and not-folder-derived truth.
- Deferred work: RUN252 Siam semantic cleanup; RUN253 live proof.

### Brain 2 — Auditor

- Aurora can look refreshed while hiding broken GlobalTop10 if only Market Board refreshes; RUN251 added GlobalTop10 forward-progress trace but live proof is still required.
- Fake Top10 completion can occur if staged/folder files are treated as final; RUN251 preserved not-folder-derived and source-owned snapshot law.
- Staging-as-final can happen at promotion boundary; RUN251 did not rewrite FileIO but improved blocker/dependency telemetry.
- Deep-trigger work can silently drop if deferred after expensive build; RUN250 pre-build guard remains the main defense.
- Retry storms can hide under `running`; RUN251 exposes retry count/due/blocker.
- Top5 SDP route can break if writer owns membership; RUN251 did not add writer-owned membership.
- Archive can become current truth if used for route membership; RUN251 preserved archive not-current-truth law.
- Generated output mutation was avoided.
- Trade/signal wording did not leak into patched surfaces.

## Protected Lattice / Boundary Contract

| Stitch | Boundary | Allowed Crossing | Forbidden Crossing | Error Detection | Rollback/Kill Condition |
|---|---|---|---|---|---|
| Timer heartbeat + artifact keepalive | Dispatcher scheduling only | cheap stale-surface schedule/degraded truth | fake proof complete or heavy keepalive work | keepalive telemetry and stale surface reason | HOLD if keepalive requires FileIO rewrite/final path mutation |
| GlobalTop10 batch + Dossier/SDP routes | committed L4/publication snapshot | source-owned membership/order/signature/blocker telemetry | folder listings, staged-as-final, writer-owned ranking | forward-progress trace and route blocker reasons | KILL if repair requires folder-derived truth |
| Deep trigger + heartbeat budget | preflight before expensive work | defer/next due/reason telemetry | silent expensive build after budget expiry | deep preflight logs | HOLD if owner cannot be isolated |
| Archive + current truth | archive as history only | archive lifecycle diagnostics | archive-derived current membership | not-current-truth law | KILL if archive must become current truth |
| Siam semantics + source invariants | RUN252 only | labels/readability/absence-state cleanup | ranking/gate/trade logic | RUN252 report/compile | HOLD if semantics require behavior mutation |

## Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| RUN250 compiled clean | RUN251 runtime/live proof is unproven | user report | evidence ladder/source boundary | 4 for RUN250 compile only | 3/current source + no runtime proof | Source boundary outranks broad readiness | Treat compile clean narrowly; RUN251 compile/live still required | no, TEST FIRST |
| Artifact keepalive exists | It could omit Scanner Status stale-surface law | RUN250 source | RUN251 source inspection | 3 | 3 | Current source inspection | Patched Scanner Status stale check | no |
| Market Board Top10 can exist | GlobalTop10 artifacts can be missing/stalled | prior runtime failure premise/report | source audit | 2/3 | 3 | Source audit controls repair | Add forward-progress/blocker telemetry | no |
| GlobalTop10 state says running | No completed route exists | runtime premise/source state | source audit | 2/3 | 3 | Source audit | Replace ambiguous wait/retry states with explicit blockers | no |
| Top5 SDP works | Top5 Dossier partial can still occur | prior failure premise | source audit | 2/3 | 3 | Source audit | Add parity same-snapshot/proof-only observability | no |
| Deep trigger deferred | Expensive work may already have spent seconds | prior runtime premise | RUN250 source guard | 2/3 | 3 | Source guard | Preserve pre-build guard; no further patch without exact owner | no |
| Archive history exists | Archive must not be current truth | source doctrine | source doctrine | 3 | 3 | Doctrine boundary | Preserve archive not-current-truth law | no |
| Old RUN labels remain | RUN251/RUN253 truth must be current | active text scan | version/control patch | 3 | 3 | Current active version/control | Classify and seed RUN252; no broad historical rewrite | no |
| Generated output could be cleaned to look better | Generated output mutation is forbidden | temptation/user outcome pressure | package law | 1 | 3 | Package law/source truth | Excluded all generated evidence | no |

## Patch Ledger

| File | Patch |
|---|---|
| `mt5/runtime/ASC_Dispatcher.mqh` | Added Scanner Status keepalive stale detection; added core keepalive surface/fake-complete telemetry; added RUN251 GlobalTop10 forward-progress trace/record helpers; converted deep-owner wait and retry-spacing states to explicit blockers; added GlobalTop10 SDP no/empty snapshot blocker telemetry; hardened Top5 parity tokens. |
| `mt5/core/ASC_Version.mqh` | Advanced current identity/package to RUN251R; added RUN251 scope/boundary/patch/evidence macros; seeded RUN252R and RUN253R. |
| `office/ROADMAP_STATUS.md` | Updated RUN251 status, boundaries, proof ceiling, next gates. |
| `office/WORK_LOG.md` | Logged read order, research conversion, source owners, patches, validations. |
| `office/CHANGE_LEDGER.md` | Recorded exact changed files and protected areas. |
| `office/DECISIONS.md` | Recorded accepted/rejected decisions and final TEST FIRST. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | Updated active handoff to RUN252R and RUN253R. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | Updated package manifest/exclusions for RUN251R. |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN251R_REPORT.md` | Created full report. |

## Package Validation Table

| Check | Result |
|---|---|
| Exact package name | `TRUTH_SEEKER_RUN251R.zip` |
| Changed files only | yes |
| Root preserved | `Aurora Sentinel Core/...` |
| RUN251R report included | yes |
| Generated runtime output excluded | yes |
| Generated Symbol Data Packs/Dossiers excluded | yes |
| Experts/Journal logs excluded | yes |
| Whole repo dump excluded | yes |
| No forbidden suffix | yes |

## RUN252R / RUN253R Seed

### RUN252R Seed

TRUTH SEEKER ROADMAP — RUN252R / SIAM DATA-PURITY READABILITY SEMANTICS CLEANUP — TIER READINESS, SESSION SCOPE, DUPLICATE ROUTE, ABSENCE STATES, AND STALE LABELS WITHOUT SIGNAL PERMISSION  
MODE: DEBUG + PATCH  
LIVE: no  
PACKAGE: TRUTH_SEEKER_RUN252R.zip  
REPORT: RUN252R_REPORT.md  
NEXT LIVE TEST: RUN253R

Purpose:
- perform Siam-facing semantic cleanup after RUN251 source invariant hardening;
- enforce visible Internet / External Research Conversion Ledger with exact source URLs/citations;
- add tiered readiness;
- add section coherence statuses;
- add session scope;
- add duplicate route / canonical-for-current-task labels;
- correct absence states;
- remove/replace stale active proof labels if still active;
- preserve no-signal/no-trade boundary;
- no L3/L4 formula/ranking change;
- no FileIO/final path change;
- no generated output mutation.

### RUN253R Seed

LIVE proof after RUN250/RUN251/RUN252 source repairs. RUN253 must test artifact refresh, GlobalTop10 Dossier final publication, GlobalTop10 SDP publication, Top5 Dossier/SDP parity, deep-trigger budget behavior, archive nonblocking behavior, heartbeat recovery, and Experts/Journal crash/freeze state. No production readiness or trading permission unless evidence actually supports it.

## FINAL SUMMARY

```text
RUN251R completed as a source/control hardening pass only.

No live/output files were requested or edited. Generated Symbol Data Packs, Dossiers, Market Board, Scanner Status, Manifest, FunctionResults runtime evidence, Experts logs, Journal logs, and prior Upcomers evidence remained read-only and were excluded from the package.

User-reported RUN250 compile-clean status was accepted as Evidence Class 4 for compile status only. RUN251R added source patches after that report, so MetaEditor compile proof for RUN251R remains outstanding.

Internet/external research sources used: official MQL5 OnTimer, Event Handling, FileOpen, FileMove, function-call, GetLastError, ResetLastError documentation, plus Google SRE cascading-failure guidance and AWS Builders Library timeout/retry/backoff guidance.

Research-to-code constraints created: timer/heartbeat work must stay bounded; expensive work needs preflight before build/enumeration/write pressure; file move/write outcomes must not be guessed; call signatures must stay matched; failed file/promotion paths need source-owned error/blocker telemetry; retries must be bounded and observable; degraded truth is allowed, fake completion is not.

Source owners inspected included Dispatcher, Version, Constants, RuntimeState, FunctionResults, Dossier writer/composer/contracts where present, Symbol Data Pack contracts/routing/composer/writer, artifact helpers, Market Board writer, Scanner Status writer, FileIO read-only, Deep Selective Analysis read-only, L3/L4 selection owners read-only, HUD read-only, Brain Guidebooks, front-door/control files, and RUN244R-RUN250R reports.

Source/control patch applied: `ASC_Dispatcher.mqh` now explicitly includes Scanner Status in core artifact keepalive stale-surface detection; keepalive telemetry declares all core surfaces and fake-complete=false; GlobalTop10 now emits RUN251 forward-progress invariant telemetry with blocker owner, inflight age, batch age, retry count, next retry due, cursor, source-owned membership, and not-folder-derived proof; deep-owner wait and retry-spacing branches now set explicit blocked states instead of leaving ambiguous endless running; GlobalTop10 SDP now reports source-owned blocker/dependency state when no committed/fallback snapshot exists and blocks empty source snapshots truthfully; Top5 parity telemetry now states same-snapshot requirement and proof-only blocking.

Artifact keepalive invariants were hardened. GlobalTop10 forward-progress invariants were hardened. GlobalTop10 Dossier/SDP route invariants were hardened at the Dispatcher/SDP route telemetry boundary. Top5 Dossier/SDP parity observability was hardened. Deep-trigger preflight and archive/presence nonblocking laws were inspected and preserved; no new deep/archive behavior was broadened. Stale active proof labels were classified and seeded for RUN252 semantic cleanup rather than broad rewritten in RUN251.

RUN246/RUN247/RUN248/RUN249/RUN250 protections were preserved. FileIO, final paths, L3 gates, L4 ranking/order/formula, HUD, Dossier architecture, strategy/signal/trade/risk logic, and generated output remained untouched.

Static brace/paren/bracket checks passed on touched source files. MetaEditor compile was not rerun here; compile proof is outstanding. Runtime/live proof, artifact refresh proof, GlobalTop10 final publication proof, SDP proof, Top5 parity proof, deep-trigger budget proof, archive nonblocking proof, production readiness, trading edge, and signal/trade permission remain unproven until RUN253 live evidence after RUN252 semantic cleanup.

Next move: RUN252R Siam data-purity/readability semantics cleanup, then RUN253R live proof.

Final serious decision: TEST FIRST.
```
