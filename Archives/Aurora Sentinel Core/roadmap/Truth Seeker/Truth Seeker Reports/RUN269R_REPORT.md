GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN269R / POST-REVERT COMMIT AUTOPSY + SAFE REDO ROADMAP — CURRENT UPLOADED RUN268R BASELINE INSPECTED FIRST, GIT MAIN SOURCE IDENTITY FOUND ALIGNED, LATEST GIT REVERT FOUND TO AFFECT OLD RUN227 REPORT ONLY, SUSPECT REPAIR CHAIN QUARANTINED FOR SAFE PHASED REBUILD
MODE: RESEARCH + AUDIT + DEBUG + ROADMAP PLANNING
TRUTH FURNACE REQUIRED
REPORT: RUN269R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN269R.zip
SOURCE BASELINE: uploaded/current reverted working baseline first; Git main secondary unless proven identical
GIT REPO: jasonangeltonkin1111-oss/Aurora-Sentinel-Scanner
FINAL DECISION: HOLD

---

FINAL SUMMARY

RUN269R inspected the uploaded/current reverted package first. The direct source identity is RUN268R, not fresh RUN269R runtime proof. Git main also reports RUN268R in `ASC_Version.mqh`, so source identity appears aligned at the version-file level. The latest visible Git commit `0796c6e6e17c26e8e00febdea7339028c3eba17c` reverts an old `RUN227R_REPORT.md`; it is not a rollback of the suspect MQL source chain.

The hard danger is not one isolated bad commit. The suspect failure pattern is stacked proof/scheduler/admission logic across RUN250R–RUN268R without a fresh compile + bounded live proof gate between each layer. The system likely became heavier and more self-gating while trying to prove itself: route rescue, keepalive, manifest token laws, Main/Lite mirror fields, archive topology, side-duty backoff, publication admission counters, and blocker truth all accumulated mainly around `ASC_Dispatcher.mqh`, `ASC_ScannerStatusWriter.mqh`, and Symbol Data Pack files.

The current reverted baseline is therefore source-known but runtime-unproven. No MetaEditor compile output, active compiled EX5 identity, active terminal identity, current output root, or fresh runtime artifacts were supplied for this exact source state. Stale RUN263 evidence exists in the package, but it cannot prove current RUN268R runtime behavior.

The safe rebuild road is not to replay old commits. First freeze the exact current source, compile it, attach it, and run a bounded breathing smoke that proves source identity, terminal/output-root identity, heartbeat refresh, Scanner Status, Market Board, Manifest, FunctionResults, and final route readback. Only after that can one tiny repair be authorized.

Recommended next run: `RUN270R / BASELINE LOCK + BREATHING SMOKE FROM REVERTED WORKING SOURCE`.

Decision: HOLD.

---

# 1. Mode Lock

| Declaration | Required Answer |
|---|---|
| current run | RUN269R |
| primary mode | RESEARCH + AUDIT + DEBUG + ROADMAP PLANNING |
| patch mode | no patch unless explicitly authorized after audit |
| source baseline | uploaded/current reverted working baseline first |
| Git baseline | Git main only after local/package baseline inspection |
| live test allowed | no |
| generated output editing allowed | no |
| source patch allowed | no; report creation only |
| broad route rewrite allowed | no |
| FileIO rewrite allowed | no |
| Dispatcher broad rewrite allowed | no |
| Main/Lite broad rewrite allowed | no |
| HUD patch allowed | no |
| L3/L4/ranking/formula patch allowed | no |
| signal/trade/risk patch allowed | no |
| final decision must be exactly one of | PROCEED / HOLD / KILL / TEST FIRST |

# 2. Evidence Ladder Applied

| Evidence | Class | RUN269R Use | Ceiling / Limitation |
|---|---:|---|---|
| AI inference | 1 | hypothesis generation only | proves nothing |
| User report of crashes, no refresh, hydration failure, split-brain, repeated revert | 2 | scope and failure symptoms | not source/runtime proof |
| Uploaded package direct source inspection | 3 | current baseline identity and source risk mapping | does not prove compile/runtime/live behavior |
| GitHub source/commit inspection | 3 | compare main/recent commit history and file-level diffs | Git history is evidence, not active terminal truth |
| Compile output | missing | compile gate | cannot claim compile clean |
| Fresh runtime/live output for uploaded source | missing | runtime gate | cannot claim current stability, refresh, or parity |
| Stale RUN263 evidence inside package | 7/8 bounded historical evidence | evidence of an older observed session | cannot prove current RUN268R reverted baseline |

# 3. Current Baseline Truth Table

| Surface | Observed Run Identity | Evidence | Authority Status |
|---|---|---|---|
| uploaded/current local package | `ASC_VERSION_LABEL="RUN268R-FinalSourceGateBeforeRun269LiveProof"`; `ASC_TRUTH_SEEKER_CURRENT_RUN="RUN268R"`; package identity `TRUTH_SEEKER_RUN268R.zip` | direct file inspection of `mt5/core/ASC_Version.mqh` | primary source baseline for this audit |
| Git main | `ASC_TRUTH_SEEKER_CURRENT_RUN="RUN268R"` in `Aurora Sentinel Core/mt5/core/ASC_Version.mqh` | GitHub file fetch | secondary; version identity aligned with uploaded package, but Git still does not prove active terminal/EX5 |
| latest Git commit | `0796c6e6e17c26e8e00febdea7339028c3eba17c`; reverts old `RUN227R_REPORT.md` | GitHub commit inspection | evidence only; not a source-chain rollback |
| active MT5 compiled EX5 | unknown | no operator-supplied compile/EX5/terminal identity proof | unresolved; cannot claim current runtime truth |
| runtime output root | unknown for current source | no fresh RUN268R/RUN269R runtime evidence supplied | unresolved; stale RUN263 evidence quarantined |

# 4. Current Source Inspection Notes

| Area | Direct Finding | Risk Meaning |
|---|---|---|
| `ASC_Version.mqh` | RUN268R declares decision `PROCEED`, but evidence ceiling says class3 source/package + research only, no MetaEditor compile and no fresh runtime/live output proof. | The PROCEED claim cannot be upgraded into runtime stability. It is a source-gate claim only. |
| `AuroraSentinelCore.mq5` | OnInit/OnDeinit/heartbeat identity logging exists; timer is set in OnInit and killed in OnDeinit. | Good concept, but not proof that the attached EX5 is the same source or that runtime output refreshed. |
| `ASC_Dispatcher.mqh` | 18,516 lines; contains RUN250 artifact-refresh rescue, RUN265 presence sweep backoff, manifest admission rows, route counters, archive/staging false-truth declarations, and many side-duty guard fields. | High concentration of scheduler/publication/proof logic; broad replay is dangerous. |
| `ASC_ScannerStatusWriter.mqh` | Emits identity and SDP proof fields, but required-token array still includes hundreds of required tokens, including legacy/live/proof-bundle tokens. | Manifest token poison may have been reduced, but Scanner Status token poison remains a live risk. |
| Symbol Data Pack writer/composer/contracts | Main/Lite mirror fields and archive topology/provenance fields exist. | Source claims mirror law; runtime parity still unproven. |
| `ASC_FileIO.mqh` | Present and not identified as direct failure owner in inspected evidence. | FileIO must stay read-only unless direct write/move/delete failure is proven. |
| Brain Guidebooks | Present and current; they reinforce no FileIO/no final path mutation, source-gates before runtime claims, and no trading permission. | Guidebooks support restraint, not broad patching. |

# 5. Git Commit Map

| Run / Commit | Observed SHA / Range | Git Finding | Authority |
|---|---|---|---|
| latest visible commit | `0796c6e6e17c26e8e00febdea7339028c3eba17c` | Reverts old `RUN227R_REPORT.md`; does not revert MQL source chain. | evidence only |
| RUN268R | `4f138ee` | final source gate/report/control identity layer | source evidence only |
| RUN267R | `fb2f554` | route admission counter/blocker truth layer | source evidence only |
| RUN266R | `69f6642` | manifest body parity / publication admission layer | source evidence only |
| RUN265R | `c702cad` | scheduler/presence sweep/side-duty guard layer | source evidence only |
| RUN263R | `0233daa` | runtime evidence intake, source excerpts, drift/metrics files | stale bounded evidence only |
| RUN262R | `ab06e8f` | Lite archive topology layer | source evidence only |
| RUN261R | `f4a266e` | Main/Lite mirror contract layer | source evidence only |
| RUN260R | `c1f791f` | manifest/scanner status required-token poison cleanup | source evidence only |
| RUN259R | `8cc063a` | heartbeat/manifest/deep-trigger repair | source evidence only |
| RUN255R | `6303d53` | identity/deployment telemetry | source evidence only |
| RUN252R | `0a1d9e6` | Siam/readiness semantic cleanup | source evidence only |
| RUN251R | `bbf9d85` | keepalive invariant hardening and telemetry | source evidence only |
| RUN250R | `29d61ad` | artifact refresh + GlobalTop10 recovery | source evidence only |
| RUN249R | `fa38f2b` | compile repair before RUN250 chain | inheritance evidence |

# 6. Commit Autopsy Table

| Run / Commit | Files Changed | Intended Benefit | Actual Risk | Runtime Failure It Could Cause | Keep / Redo / Redesign / Delete / Quarantine | Required Falsifier Before Reapply |
|---|---|---|---|---|---|---|
| RUN250R | Dispatcher, MarketBoard, ScannerStatus, SDP writer/composer, constants/version/control/report | artifact refresh + GlobalTop10 publication recovery; keepalive/rescue; deep-trigger preflight | heavy rescue logic enters timer/publication lane before proving core refresh | heartbeat starvation, no refresh, route outputs stuck in staging/degraded state | QUARANTINE + REDESIGN | With heavy lanes blocked, Scanner Status, Market Board, Manifest, FunctionResults, and heartbeat must refresh repeatedly beyond warmup. |
| RUN251R | same RUN250 cluster plus report/control | source invariant hardening, forward-progress telemetry, Top5 parity telemetry | telemetry can become another admission gate instead of cheap observation | stale/dead surfaces despite “proof” fields | QUARANTINE + REDO SAFELY | Telemetry must be bounded, cheap, non-blocking, and unable to delay final child publication. |
| RUN252R | ScannerStatus/SDP/composer/version/control/report | Siam readiness/coherence/absence semantic cleanup | readability labels can become hidden readiness law that suppresses output | hydration failure or misleading “not ready” state while route should still publish partials | REDO SAFELY later | Missing/partial data must publish explicit blocker state, not suppress the route. |
| RUN254R | report/control/audit layer from observed history | whole-system failure audit | audit conclusions may outrank current files if reused blindly | wrong baseline chosen after revert | KEEP AS EVIDENCE ONLY | Every RUN254 claim must be rechecked against current files before reuse. |
| RUN255R | `AuroraSentinelCore.mq5`, Dispatcher, Version, Guidebooks, report/evidence inventory | identity/deployment telemetry | low code risk, but can still give false confidence if not captured from active EX5 | source says RUN255/RUN268, terminal may run different EX5 | REDO SAFELY | OnInit, heartbeat, artifact source_run_id, compiled file, terminal data path, output root all match exact package. |
| RUN259R | Dispatcher, ScannerStatus, SDP, constants/version/control/guidebooks | heartbeat breathing, manifest poison, deep-trigger starvation repair | partial breathing repair mixed with route/deep-trigger logic | retry amplification, dead refresh, silent deferred routes | QUARANTINE + REDESIGN | Degraded deep lane cannot prevent core outputs from refreshing and final routes from exposing exact blocker. |
| RUN260R | ScannerStatus, Dispatcher, Version, control/guidebooks | required-token poison cleanup | token cleanup may be incomplete; Scanner Status still carries huge legacy required-token array | generated body marked incomplete forever or writer suppresses completion | REDESIGN | Static token-body parity: every required token emitted exactly once or marked not_applicable by law. |
| RUN261R | SDP contracts/writer/composer, Dispatcher, ScannerStatus, Version, control/guidebooks | Main/Lite mirror contract; Lite slave | mirror fields can become claims without readback proof; Lite may still calculate health independently | Main/Lite split-brain, Lite pass while Main blocked | REDESIGN | Per-cycle parity: route family, bucket, symbol set, rank/order, snapshot, blocker, expected/written counts match Main/source plan. |
| RUN262R | SDP writer/composer/contracts, Dispatcher, ScannerStatus, Version, control/guidebooks | Lite archive topology; separate previous_state_cache | archive/staging/cache can leak into current truth if not strictly proven | stale folder truth becomes membership/rank source | REDO SAFELY MUCH LATER | Current/final publication stable first; archive must declare provenance-only and never determine current membership/rank. |
| RUN265R | Dispatcher, RuntimeState, Constants, Version, control/guidebooks/report | scheduler guards; presence sweep due/backoff/cooldown; side-duty preflight | correct idea but too much scheduler law after unstable baseline | timer lane spends budget proving/retrying instead of publishing core artifacts | REDESIGN | Presence sweep and side duties show due/backoff status but cannot run before core refresh surfaces. |
| RUN266R | Dispatcher, Version, control/guidebooks/report | Manifest body parity and publication admission | admission may block final publication based on late/stale counters | final route absent with “pending” or fake blocker | REDESIGN | If final route is missing, manifest exposes owner, blocker, expected/written, retry due, latest error, and source snapshot; no fake complete. |
| RUN267R | Dispatcher, Version, control/guidebooks/report | actual route counters and blocker truth | counters may be independently calculated or stale | false pass/fail, route admission lies, Main/Lite count mismatch | REDESIGN | Counters must come from writer-owned post-write/readback results, not folder guesses. |
| RUN268R | Version, control/report/source-gate layer | final source gate before live proof | source gate says PROCEED without compile/live proof after a broken chain | user treats source-gate pass as runtime stability | KEEP AS EVIDENCE ONLY | Compile + bounded live proof must upgrade evidence before any rebuild patch. |

# 7. Failure-Class Autopsy

| Failure Class | Finding | Status | Falsifier Required |
|---|---|---|---|
| 1. Deployment/source identity drift | Source and Git version identity align to RUN268R, but active EX5/terminal/output-root identity is unknown. | OPEN | Fresh runtime output carries same run identity, compiled file identity, terminal paths, and output root as the exact source package. |
| 2. Refresh death / heartbeat starvation | MQL5 timer events are not backlog proof; heavy OnTimer work can mean future timer events are not queued. Dispatcher contains many side-duty/proof/admission lanes. | OPEN | Core artifacts refresh repeatedly while heavy lanes are blocked/degraded. |
| 3. Hydration failure | Readiness/coherence/proof fields may require data before writers can lawfully emit output. | OPEN | Artifacts publish hydrated/partial/missing/blocker states without suppressing whole route publication. |
| 4. Manifest poison / required-token mismatch | Manifest body parity improved, but Scanner Status still has a large required-token array with legacy/proof tokens. | OPEN | Required-token static parity proves every token is emitted exactly once or lawfully not_applicable. |
| 5. Publication admission false gate | Admission rows exist, but runtime proof of actual writer-owned post-write counters is missing. | OPEN | Final route absence always reports route owner, blocker, expected/written, retry due, source snapshot, and latest write/promotion error. |
| 6. Main/Lite split-brain | Mirror-law fields exist, but no fresh Main-vs-Lite parity table exists. | OPEN | Lite matches Main/source plan on route family, bucket, symbols, rank/order, snapshot, blocker, expected/written count every publish cycle. |
| 7. Archive/cache/staging truth leak | Source declares archive/staging false-truth fields, but no current runtime readback proves this boundary. | OPEN | All current outputs state truth from source-owned committed plan; archive/cache/staging never determine membership/rank. |
| 8. Proof surface overload | The proof surfaces became large and central enough to plausibly starve publication. | OPEN | Proof fields are cheap, bounded, and demonstrably cannot delay core artifact refresh. |

# 8. Main/Lite Law Audit

| Law | Current Source Finding | Proof Status | Risk |
|---|---|---|---|
| Main = Dossiers | Dossier writers/composers and route publication paths are present. | source-inspected only | no fresh final readback |
| Lite = Symbol Data Packs | SDP writer/composer/contracts/routing are present. | source-inspected only | no fresh parity proof |
| Lite is slave mirror of Main/source plan | Source contains mirror/provenance fields such as source snapshot, expected/written counts, blocker fields, archive/staging false-truth declarations. | source claim only | source fields can lie if counters are late/stale/independent |
| Identical route family/bucket/symbol/rank/order/epoch/blocker/count | Not proven from fresh runtime. | unproven | split-brain remains possible |
| Content depth may differ only | Intended law exists in guidebooks/reports. | unproven | enrichment may drift into independent truth |
| Lite may not calculate own truth | No direct runtime proof supplied. | unproven | must be tested before any Lite rebuild |

# 9. Research Conversion Ledger

| Problem Gate | Source URL / Citation | Finding | Aurora Risk | Converted Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|---|
| refresh heartbeat | MQL5 OnTimer: https://www.mql5.com/en/docs/event_handlers/ontimer ; MQL5 Event Handling: https://www.mql5.com/en/docs/event_handlers | Timer events are event-queue based; if a Timer event is already queued/processing, a new one is not added. | Heavy route/proof work inside heartbeat can make the EA look dead without a backlog proving every missed tick. | Core refresh surfaces must run first and stay cheap; heavy route work must defer/degrade. | 10–15 minute bounded smoke proves heartbeat, Scanner Status, Market Board, Manifest, FunctionResults refresh beyond warmup while heavy lanes are blocked. | Any core surface stays stale while side-duty/deep/proof work runs. |
| hydration | OpenMetadata Data Contracts: https://docs.open-metadata.org/latest/features/data-contracts ; W3C PROV Overview: https://www.w3.org/TR/prov-overview/ | Contracts/provenance must expose expectations and origins. | New readiness laws can suppress publication when data is partial. | Hydration state must be explicit: hydrated/partial/missing/blocker. Route must still publish partial blocker state. | Force/observe missing data; final route emits partial state and blocker owner. | Output disappears or “complete=false” gives no owner/blocker. |
| Manifest | MQL5 FileOpen: https://www.mql5.com/en/docs/files/fileopen ; FileMove: https://www.mql5.com/en/docs/files/filemove ; GetLastError/ResetLastError docs | File operations must check handles/bool results and error codes. | Manifest can claim failure or completion without writer/promotion owner. | No guessed write success; every final route absence exposes writer/promoter owner and last error. | Static token-body parity plus write/readback/promotion result lines. | Missing final route with no owner/error/count/snapshot. |
| GlobalTop10 | MQL5 OnTimer + Google SRE cascading failures: https://sre.google/sre-book/addressing-cascading-failures/ | Cascading failures grow through overload/positive feedback. | GlobalTop10 rescue can amplify load and starve core outputs. | GlobalTop10 child refresh cannot force heavy L5/L6/deep work in heartbeat. | Dossier GlobalTop10 final count and blocker readback remain visible while deep lane is degraded. | Staging exists but final route absent with no blocker/error. |
| Top5PerBucket | AWS Builders Library timeouts/retries/backoff/jitter: https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ | Retries/backoff/jitter prevent small failures from becoming retry storms. | Bucket retries/presence sweeps can flood timer cycles. | Per-bucket work must be capped, due-timed, jittered/backed off, and non-core. | Skipped-before-build, next-due, backoff, last-error fields are visible while core surfaces refresh. | Whole heartbeat stalls or repeated bucket retry has no due/backoff. |
| Symbol Data Pack Lite | OpenLineage Facets: https://openlineage.io/docs/spec/facets/ ; OpenMetadata contracts | Lineage facets attach run/job/dataset metadata; contracts define expectations. | Lite can become an independent truth owner. | Lite must carry Main/source snapshot, route family, rank/order, blocker, expected/written counts; content depth only may differ. | Main-vs-Lite parity table after each publish cycle. | Lite publishes a bucket/symbol/rank absent from Main/source plan. |
| Main/Lite parity | W3C PROV Overview + OpenLineage Facets | Provenance supports trust by showing production lineage. | Split-brain hides behind matching-looking files. | Every output declares source_run_id, source_version, source_snapshot_id, route family, expected/written counts, publication epoch. | Parity readback table proves same source snapshot and blocker state. | Lite pass while Main blocked, or unrelated epochs. |
| archive/cache/staging | MQL5 FileMove/FileDelete docs; W3C PROV | Move/delete operations require bool/error checks; provenance must distinguish current from history. | Archive/staging/folder presence leaks into membership/rank truth. | Archive/cache/staging are provenance only; final/current readback is the only route output truth. | Delete/stale archive scenario still publishes source-owned current route truth or explicit blocker. | Folder/archive membership used to infer current rank/symbol set. |
| deployment identity | OpenLineage source code/version facets + MQL5 identity logging via `__FILE__`, `__DATETIME__`, Terminal paths | Runtime lineage needs source/version/run identity. | User may run old EX5 while source package is new. | OnInit, heartbeat, artifacts, output root, package identity, and compiled file must align. | Fresh runtime shows same run/source/version/compiled file/output root across logs and artifacts. | Any mismatch between source, EX5, terminal, or artifact source_run_id. |

# 10. Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| User says reverted working baseline | Uploaded/current source reports RUN268R | user report | direct `ASC_Version.mqh` inspection | 2 | 3 | direct source for source identity | Current uploaded baseline is RUN268R; stability remains unproven. | yes |
| Git main says RUN268R | latest Git commit reverts old RUN227 report | Git main version file | latest commit diff/message | 3 | 3 | both true in different surfaces | Latest revert did not roll back suspect source chain. | yes |
| RUN268R report/control says PROCEED | RUN268R evidence ceiling says no compile/live proof | `ASC_Version.mqh` run decision | `ASC_Version.mqh` evidence ceiling | 3 | 3 | evidence ceiling outranks decision label | Treat PROCEED as source-gate only. | yes |
| Source version RUN268R | active compiled EX5 identity unknown | source file | missing operator evidence | 3 | missing | source proves only source, not runtime | RUN270 must capture compile/EX5/terminal identity. | yes |
| Stale RUN263 runtime evidence exists | current RUN268R runtime behavior unknown | package evidence folders | no fresh output | 7/8 historical | missing current | current source/runtime proof required | Quarantine stale evidence. | yes |
| Main/Lite mirror fields exist | Main/Lite runtime parity unknown | source inspection | missing runtime readback | 3 | missing | source claim cannot prove runtime parity | Need parity table from fresh publish cycle. | yes |
| Manifest body parity improved | Scanner Status required-token poison risk remains | Dispatcher inspection | ScannerStatusWriter inspection | 3 | 3 | stricter/remaining risk wins | Static parity audit required before reapplying token law. | yes |
| Archive/staging false-truth fields exist | archive/staging leak not disproven live | source inspection | missing runtime proof | 3 | missing | source claim insufficient | Runtime readback must prove current/final truth. | yes |
| Report says no patch/final source gate | source chain contains many prior behavior changes | RUN268 report/control | Git/source diff map | 3 | 3 | source diff map wins for risk | Do not replay chain blindly. | yes |
| Compile clean may have been claimed earlier | no compile output supplied here | old reports/user context | missing MetaEditor output | 2/3 | missing | compile output required | Cannot claim compile clean. | yes |

# 11. Keep / Redo / Redesign / Delete / Quarantine Ledger

| Classification | Item | Reason |
|---|---|---|
| KEEP AS EVIDENCE | RUN268R source-gate/report/control identity | Useful history, not runtime proof. |
| KEEP CONCEPT | RUN255R deployment identity telemetry | Correct failure target: source/package/EX5/terminal/output-root drift. Must be proven live. |
| KEEP CONCEPT | Guidebook boundary laws | Prevent FileIO/final path/HUD/L3/L4/trading drift. |
| KEEP | FileIO read-only boundary | No direct FileIO failure proven. |
| REDO SAFELY | Minimal identity proof | Must be one tiny bounded run if current baseline lacks runtime identity. |
| REDO SAFELY | Core-first heartbeat guard | Only after baseline smoke proves where refresh dies. |
| REDO SAFELY | Dossier final publication blocker readback | Dossiers/Main first, no Lite yet. |
| REDESIGN | RUN250 GlobalTop10 rescue / keepalive | Too entangled with heartbeat/deep route work. |
| REDESIGN | RUN259/RUN265 scheduler and side-duty logic | Must be rebuilt as non-core, capped, due-timed, and post-refresh. |
| REDESIGN | RUN260 required-token law | Token arrays must be generated/verified from emitted body, not manually expanded. |
| REDESIGN | RUN266/RUN267 route admission counters | Must consume writer-owned readback results only. |
| REDESIGN | RUN261 Main/Lite mirror contract | Rebuild only after Main final routes are stable. |
| REDO LATER | RUN262 archive topology | Archive/cache/staging only after current/final route stability. |
| DELETE | Fake pass / fake complete / admission without owner/error | These create false proof surfaces. |
| DELETE | Required tokens not emitted by body | This is poison. |
| DELETE | Archive/folder/staging membership inference | Violates current truth ownership. |
| QUARANTINE | stale RUN263 runtime evidence | Historical only; not current proof. |
| QUARANTINE | all suspect source layers RUN250–RUN268 | Do not replay. Rebuild one capability at a time after proof gates. |

# 12. New Safe Rebuild Roadmap

## Phase A — Baseline Lock

Goal: prove the exact current reverted source can compile, attach, breathe, and publish core current surfaces before any repair.

Allowed:
- package exact current source state;
- record hashes of `AuroraSentinelCore.mq5`, `ASC_Version.mqh`, `ASC_Dispatcher.mqh`, `ASC_ScannerStatusWriter.mqh`, Dossier/SDP/FileIO owners;
- MetaEditor compile output;
- attach to terminal;
- 10–15 minute bounded smoke;
- capture OnInit/heartbeat identity, output root, Scanner Status, Market Board, Manifest, FunctionResults, final Dossier route listings.

Forbidden:
- source edits;
- generated output edits;
- route rescue patches;
- FileIO rewrite;
- Main/Lite enrichment;
- archive/cache/staging changes.

Pass condition: source identity, compiled identity, terminal identity, output root, heartbeat, and core surfaces all align and refresh.

## Phase B — Identity Proof Only

Only if Phase A shows missing/mismatched identity. Add minimal identity line(s), no route logic.

## Phase C — Refresh Breathing Guard

Only after identity is proven. Ensure core artifacts refresh first and heavy duties defer.

## Phase D — Main Final Publication Stability

Repair Dossiers/GlobalTop10 and Dossiers/Top5PerBucket only. No Lite yet. No archive yet.

## Phase E — Lite Slave Mirror Minimal

Mirror Main route family, bucket, symbol set, rank/order, source snapshot, blocker reason, expected/written counts. Content depth minimal.

## Phase F — Hydration / Data Completeness

Add hydrated/partial/missing/blocker states gradually. Missing data must not suppress route output.

## Phase G — Archive / Previous Cache

Only after current/final routes prove stable. Archive remains provenance/history, never current truth.

## Phase H — Siam Readability

Polish labels/readability only after refresh, hydration, and Main/Lite parity are proven.

# 13. First Next-Run Prompt Seed

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN270R / BASELINE LOCK + BREATHING SMOKE FROM REVERTED WORKING SOURCE — FREEZE EXACT CURRENT RUN268R SOURCE, COMPILE, ATTACH, CAPTURE IDENTITY/OUTPUT ROOT/HEARTBEAT/CORE ARTIFACT REFRESH, AND PROVE OR FALSIFY BASELINE BEFORE ANY PATCH
MODE: COMPILE GATE + BOUNDED LIVE PROOF + DEBUG READBACK
TRUTH FURNACE REQUIRED
REPORT: RUN270R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN270R.zip
SOURCE BASELINE: exact current reverted/uploaded RUN268R working source from RUN269R, not Git main unless hash-identical
DECISION TARGET: PROCEED / HOLD / TEST FIRST / KILL

PRIMARY PURPOSE

Do not patch. Freeze and prove the current reverted source state first.

Required evidence:
1. exact source hashes for key files;
2. MetaEditor compile output unchanged;
3. OnInit identity lines;
4. heartbeat identity lines;
5. terminal data/common paths;
6. output root;
7. Scanner Status, Market Board, Manifest, FunctionResults refresh timestamps over 10–15 minutes;
8. Dossiers/GlobalTop10 and Dossiers/Top5PerBucket final route presence/readback;
9. Symbol Data Pack Lite presence only as read-only observation, not repair target;
10. no generated output edits.

If crash/no refresh occurs, stop and report exact first failure surface. No repair patch in RUN270R unless separately authorized after proof capture.
```

# 14. Package Validation

| Package Rule | Result | Notes |
|---|---|---|
| exact zip name `TRUTH_SEEKER_RUN269R.zip` | PASS | created as changed-files-only package |
| changed files only | PASS | includes RUN269R report only |
| preserve `Aurora Sentinel Core/...` layout | PASS | report path preserved |
| no generated runtime evidence added | PASS | stale/generated evidence excluded from package |
| no source patch included | PASS | no MQL/control/source edits included |
| no forbidden suffix | PASS | no `_2`, `_copy`, `final`, `fixed`, `updated`, `new`, `CHANGED_FILES_WINDOWS_SAFE`, or `REPORT_ONLY_WINDOWS_SAFE` suffix |

# 15. Final Decision

HOLD

Reason: the current source baseline is identified, and Git main version identity appears aligned, but active compiled EX5 identity, terminal identity, output root, compile proof, fresh runtime refresh, hydration, Main/Lite parity, and route publication behavior remain unproven for the reverted working baseline. The next move is not a patch. It is RUN270R baseline lock + breathing smoke.
