# RUN189R REPORT — SYMBOL DATA PACK FAMILY TOPOLOGY MASTER PLAN

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN189R / SYMBOL DATA PACK FAMILY TOPOLOGY MASTER PLAN
RESULT: HOLD-WITH-SOURCE-CONTRACT-PATCH
SERIOUS DECISION: TEST FIRST
PACKAGE: TRUTH_SEEKER_RUN189R_CHANGED_FILES_WINDOWS_SAFE.zip

PATCHED:
- mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh
- mt5/core/ASC_Version.mqh
- roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md
- roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md
- roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md
- roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md
- office/ROADMAP_STATUS.md
- office/WORK_LOG.md
- office/CHANGE_LEDGER.md
- office/DECISIONS.md
- roadmap/Truth Seeker/Truth Seeker Reports/RUN189R_REPORT.md

NO LIVE TEST PERFORMED
NO COMPILE PROOF CLAIMED
NO RUNTIME PROOF CLAIMED
NO OUTPUT PROOF CLAIMED
NO LIVE PROOF CLAIMED
NO PRODUCTION-READY CLAIM
NO FILEIO / HUD / MARKET BOARD / TOP-LIST / RANK / FORMULA / HEARTBEAT CADENCE / STRATEGY / EXECUTION PATCH
```

## SECTION 0 — MODE / RUNWAY LOCK

| Declaration | Required Answer |
|---|---|
| current run | RUN189R |
| primary mode | ROADMAP REVISION |
| secondary mode | AUDIT |
| purpose | Symbol Data Pack family topology master plan before RUN195 live |
| previous run | RUN188R |
| previous decision | HOLD-WITH-SOURCE-PATCH |
| next live run | RUN195R |
| are RUN189–RUN194 live? | no |
| is RUN189 allowed to patch source logic? | only pure source-contract markers/constants if required |
| is topology implementation allowed in RUN189? | no, unless scope is tiny and contract-only |
| is FileIO rewrite allowed? | no |
| is heartbeat cadence change allowed? | no |
| is HUD repair allowed? | no |
| is Market Board/top-list/rank/formula patch allowed? | no |
| is strategy/execution allowed? | no |
| must official research ledger be visible? | yes |
| final serious decision must be exactly one of | PROCEED / HOLD / KILL / TEST FIRST |

## Evidence ceiling

| Claim Area | Highest Defensible Evidence Class | What It Means |
|---|---:|---|
| RUN188 flat SDP file existence | 2 | User/report evidence proves one observed file existed in the live package. It does not prove recurrence. |
| Active source topology | 3 | Direct source inspection proves current source contains flat SDP routing and Dossier family path functions. |
| RUN189 source-contract patch | 3 | Direct source inspection after patch proves contract markers exist. |
| Compile safety | 0 | No compile was run in RUN189. |
| Runtime / output / live proof | 0 | No live test was run in RUN189. |
| Production readiness | 0 | Not claimed. |

## SECTION 1 — REQUIRED READ ORDER STATUS

| # | Required Path | Status |
|---:|---|---|
| 1 | `roadmap/Truth Seeker/Truth Seeker Reports/RUN188R_REPORT.md` | FOUND |
| 2 | `roadmap/Truth Seeker/Truth Seeker Reports/RUN187R_REPORT.md` | FOUND |
| 3 | `roadmap/Truth Seeker/Truth Seeker Reports/RUN186R_REPORT.md` | FOUND |
| 4 | `roadmap/Truth Seeker/Truth Seeker Reports/RUN185R_REPORT.md` | FOUND |
| 5 | `roadmap/Truth Seeker/Truth Seeker Reports/RUN184R_REPORT.md` | FOUND |
| 6 | `roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md` | FOUND |
| 7 | `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | FOUND |
| 8 | `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | FOUND |
| 9 | `roadmap/Truth Seeker/Guidebooks/AURORA_GUIDEBOOK_INDEX.md` | FOUND |
| 10 | `roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md` | FOUND |
| 11 | `roadmap/Truth Seeker/Guidebooks/AURORA_TRADING_BRAIN_GUIDEBOOK.md` | FOUND |
| 12 | `office/ROADMAP_STATUS.md` | FOUND |
| 13 | `office/WORK_LOG.md` | FOUND |
| 14 | `office/CHANGE_LEDGER.md` | FOUND |
| 15 | `office/DECISIONS.md` | FOUND |
| 16 | `mt5/AuroraSentinelCore.mq5` | FOUND |
| 17 | `mt5/core/ASC_Version.mqh` | FOUND |
| 18 | `mt5/core/ASC_RuntimeState.mqh` | FOUND |
| 19 | `mt5/runtime/ASC_Dispatcher.mqh` | FOUND |
| 20 | `mt5/artifacts/ASC_DossierWriter.mqh` | FOUND |
| 21 | `mt5/artifacts/ASC_CurrentFocusWriter.mqh` | FOUND |
| 22 | `mt5/artifacts/ASC_MarketBoardWriter.mqh` | FOUND |
| 23 | `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | FOUND |
| 24 | `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` | FOUND |
| 25 | `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | FOUND |
| 26 | `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackRouting.mqh` | FOUND |
| 27 | `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh` | FOUND |
| 28 | `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | FOUND |

No required read-order file was absent. The run continued with source inspection and official research.

## SECTION 2 — OFFICIAL RESEARCH LEDGER

| Research Finding | Source URL / Citation | Authority Tier | Converted Constraint | RUN189 Impact |
|---|---|---:|---|---|
| MQL5 timer events do not stack for a program when a Timer event is already queued or processing. | https://www.mql5.com/en/docs/event_handlers/ontimer and https://www.mql5.com/en/docs/eventfunctions/eventsettimer | 1 | RUN190–RUN194 must reduce write pressure and avoid relying on catch-up timer behavior. | Topology must publish less redundant output, not assume delayed timer events will replay. |
| MQL5 supports one timer per program and timer setup is normally initialized through EventSetTimer/EventSetMillisecondTimer. | https://www.mql5.com/en/docs/eventfunctions/eventsettimer | 1 | Do not patch heartbeat cadence in this campaign. Solve by routing, gating, and suppression. | RUN189 protects heartbeat cadence from topology scope creep. |
| MQL5 file operations are constrained to the file sandbox: local MQL5\Files / tester files or FILE_COMMON shared files. | https://www.mql5.com/en/docs/files/fileopen and https://www.mql5.com/en/docs/files/fileisexist | 1 | All target paths must remain relative within the existing server-root/sandbox doctrine. | Mirrored `Symbol Data Packs\GlobalTop10` and `Symbol Data Packs\Top5PerBucket` are feasible if routed through existing sandboxed FileIO helpers. |
| FolderCreate creates a directory in the Files folder and accepts relative folder paths. | https://www.mql5.com/en/docs/files/foldercreate | 1 | Nested folder targets are feasible without rewriting FileIO if existing directory-tree helpers are used. | RUN190–RUN194 may add mirror routing while keeping FileIO protected. |
| FileWrite writes records to CSV/TXT-style files and returns bytes written. | https://www.mql5.com/en/docs/files/filewrite | 1 | Proof must inspect token-valid, non-zero, written outputs; FileWrite alone is not proof of artifact family correctness. | RUN195 must verify output content and manifests, not just successful call paths. |
| FileFlush writes buffered data but frequent calls may affect program operation speed. | https://www.mql5.com/en/docs/files/fileflush | 1 | Do not solve topology or recurrence by broad flush-loop repair. | RUN189 blocks FileIO/flush-loop scope creep under severe write pressure. |
| FileClose closes files opened by FileOpen; FileFlush is forced on close if unwritten data remains. | https://www.mql5.com/en/docs/files/fileclose and https://www.mql5.com/en/docs/files/fileflush | 1 | Preserve existing atomic write/close discipline. | No FileIO rewrite is warranted in RUN189. |
| FileMove moves/renames local/shared sandbox files and FILE_REWRITE allows replacement. | https://www.mql5.com/en/docs/files/filemove | 1 | Atomic temp-to-final promotion remains the correct protected FileIO layer. | RUN190–RUN194 should change route targets, not atomic write mechanics. |
| OpenAI prompt guidance favors instructions at the beginning, delimiters, specificity, and explicit output format/style. | https://help.openai.com/en/articles/6654000-best-practices-for-prompt-engineering-with-the-openai-api and https://help.openai.com/en/articles/4936848-how-do-i-create-a-good-prompt-for-an-ai-model | 1 | RUN189–RUN195 prompts must use exact run purpose, gates, prohibited scopes, outputs, and acceptance criteria. | This report uses explicit run gates and package requirements instead of vague “check everything” language. |

## SECTION 3 — FACTS / ASSUMPTIONS / UNKNOWNS / RISKS

| Item | Fact / Assumption / Unknown | Evidence | Risk | Required Action |
|---|---|---|---|---|
| Symbol Data Pack flat file exists. | Fact | RUN188 report/operator evidence: `Symbol Data Packs/EURUSD_SYMBOL_DATA_PACK.txt` was non-zero and token-valid once. | Misread as recurrence proof. | Carry forward as one observed write only. |
| Symbol Data Pack mirrored topology does not exist. | Fact | Active source has flat target folder/path in `ASC_SymbolDataPackWriter.mqh`; contracts were one-file-per-symbol before RUN189. | RUN195 cannot prove desired family topology until implemented. | Lock mirror contract in RUN189; implement RUN190–RUN194. |
| Dossiers Top10/Top5 topology exists. | Fact | Dispatcher has `Dossiers\GlobalTop10` and `Dossiers/Top5PerBucket` path helpers/constants. | SDP may diverge from Dossier membership if re-ranked independently. | SDP must mirror membership only; no rank/order/formula change. |
| Direct root Dossier symbol files exist. | Fact | `ASC_DossierContracts.mqh` targets `Dossiers\<symbol>.txt`. | Root symbol spam adds write pressure and confuses family authority. | Suppress root symbol spam after mirror readiness; do not confuse with selected/current dossier surface. |
| Direct root Dossier symbol files are waste risk. | Assumption with strong risk evidence | RUN188 write-lane pressure plus root symbol family duplication. | Unneeded writes may starve proof artifacts under timer queue rules. | Convert to suppression test in RUN193. |
| Write pressure is severe. | Fact | RUN188 report/operator evidence: 22s–25s beats against 880ms budget. | Timer events cannot catch up; recurring publication may fail silently. | Reduce redundant writes without FileIO/heartbeat changes. |
| RUN188 callsite priority patch requires future verification. | Fact | RUN188 was source patch only after incomplete runtime proof. | RUN188 patch may not preserve recurring proof. | Verify in RUN195 after topology corrections. |
| RUN195 is next live. | Fact by operator override | User explicitly blocked immediate post-RUN188 live test. | Premature live test would waste proof window. | RUN189–RUN194 prepare; RUN195 tests. |
| Topology patch cannot change rank/order/formula. | Fact by run boundary | User scope and source-protection rules. | Any rank/formula mutation corrupts proof. | Mirror existing membership only. |
| Topology patch cannot rewrite FileIO. | Fact by run boundary and official FileIO constraints. | FileIO rewrite would create broad regression risk. | Use existing atomic publication helpers. |

## SECTION 4 — TARGET TOPOLOGY CONTRACT

Required target:

```text
Aurora Sentinel Core\<Server>\
├─ Dossiers\
│  ├─ GlobalTop10\
│  │  ├─ <symbol>.txt
│  │  └─ _family_manifest.txt
│  └─ Top5PerBucket\
│     ├─ <bucket>\
│     │  ├─ <symbol>.txt
│     │  └─ _bucket_manifest.txt
│     └─ _family_manifest.txt
└─ Symbol Data Packs\
   ├─ GlobalTop10\
   │  ├─ <symbol>_SYMBOL_DATA_PACK.txt
   │  └─ _family_manifest.txt
   └─ Top5PerBucket\
      ├─ <bucket>\
      │  ├─ <symbol>_SYMBOL_DATA_PACK.txt
      │  └─ _bucket_manifest.txt
      └─ _family_manifest.txt
```

### RUN189 topology decision

| Question | Decision |
|---|---|
| Correct Symbol Data Pack family topology | Mirror Dossier family topology: `Symbol Data Packs\GlobalTop10` and `Symbol Data Packs\Top5PerBucket\<bucket>`. |
| Must SDP mirror Dossiers GlobalTop10 and Top5PerBucket? | Yes. It must mirror existing Dossier membership and order as a consumer. It must not compute rank/order/formula. |
| Handling flat `Symbol Data Packs\<symbol>_SYMBOL_DATA_PACK.txt` | Deprecated transition observation only. It cannot count as RUN195 topology proof. It may remain temporarily only if explicitly transition-labelled and suppressed once mirrors are ready. |
| Handling direct root `Dossiers\<symbol>.txt` | Treat direct root symbol spam as suppressible waste after mirror readiness. Do not delete or confuse the selected/current canonical dossier surface. Family children belong under `Dossiers\GlobalTop10` and `Dossiers\Top5PerBucket`. |
| Artifact source owners | Dossier writers/dispatcher own Dossier family; SDP Contracts/Routing/Composer/Writer own SDP family; FileIO owns atomic mechanics and remains protected. |
| Lite content boundary | Dossier-like lighter L0–L5 factual hydration only. No Layer 6, no heavy deep-only sections, no strategy/execution claims. |

## SECTION 5 — SOURCE OWNER MAP

| Artifact / Concern | Owner File(s) | Allowed Role | RUN189 Finding |
|---|---|---|---|
| SDP contract labels, target topology markers, content boundary | `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | Source-contract only in RUN189; routing/content changes in later scoped runs. | Patched with RUN189 contract markers. |
| SDP target paths and final writes | `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | Later route implementation only; no FileIO rewrite. | Active source targets flat folder. |
| SDP content composition | `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh` | Compose only from lawful upstream data; no hidden truth engine. | Protected from RUN189 logic change. |
| SDP route classification | `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackRouting.mqh` | Later route selector for GlobalTop10/Top5PerBucket mirror. | Protected from RUN189 logic change. |
| Dossier root/symbol contract | `mt5/artifacts/ASC_DossierContracts.mqh`, `ASC_DossierWriter.mqh` | Canonical Dossier surface; not SDP owner. | Direct root symbol target exists. |
| GlobalTop10 family paths | `mt5/runtime/ASC_Dispatcher.mqh` | Existing membership/path authority for Dossier children. | Mirror source for SDP GlobalTop10. |
| Top5PerBucket family paths | `mt5/runtime/ASC_Dispatcher.mqh`, `mt5/core/ASC_Constants.mqh` | Existing bucket membership/path authority for Dossier children. | Mirror source for SDP Top5PerBucket. |
| Atomic write mechanics | `mt5/io/ASC_FileIO.mqh` | Protected. | No RUN189 patch; no RUN190–RUN194 rewrite. |
| Status/proof surfaces | `ASC_ScannerStatusWriter.mqh`, dispatcher manifest/status functions | Token-valid proof fields only. | RUN195 must require full proof bundle. |
| Version/control identity | `mt5/core/ASC_Version.mqh` | Compile-visible run identity and proof boundary. | Patched. |

## SECTION 6 — SOURCE EVIDENCE SNAPSHOT

| File | Line | Evidence |
|---|---:|---|
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | 10 | `#define ASC_SYMBOL_DATA_PACK_FOLDER "Symbol Data Packs"` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | 79 | `string path = server_root + "\\" + string(ASC_SYMBOL_DATA_PACK_FOLDER) + "\\" + ASC_SymbolDataPackSafeFileToken(symbol) + string(ASC_SYMBOL_DATA_PACK_FILE_SUFFIX);` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | 16 | `#define ASC_SYMBOL_DATA_PACK_ONE_FILE_PER_SYMBOL "one_operator_file_per_symbol"` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | 148 | `+ " / file_rule=" + string(ASC_SYMBOL_DATA_PACK_ONE_FILE_PER_SYMBOL)` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | 1574 | `text += "/ one_file_per_symbol_contract / SymbolDataPackContracts / " + string(ASC_SYMBOL_DATA_PACK_ONE_FILE_PER_SYMBOL) + " / no per-health files /\n";` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | 45 | `#define ASC_SYMBOL_DATA_PACK_TARGET_TOPOLOGY "mirror_Dossiers_GlobalTop10_and_Dossiers_Top5PerBucket"` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | 15 | `string ASC_SymbolDataPackTargetFolder(const string server_root)` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | 24 | `string folder = ASC_SymbolDataPackTargetFolder(server_root);` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | 22 | `string ASC_SymbolDataPackTargetPath(const string server_root,const string symbol)` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | 32 | `string target_path = ASC_SymbolDataPackTargetPath(server_root, symbol);` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | 41 | `return ASC_SymbolDataPackTargetPath(server_root, symbol);` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | 151 | `string path = ASC_SymbolDataPackTargetPath(server_root, symbol);` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | 212 | `string target_path = ASC_SymbolDataPackTargetPath(server_root, symbol);` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | 248 | `string target_path = ASC_SymbolDataPackTargetPath(server_root, symbol);` |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | 276 | `return ASC_WritePublicationPayloadAtomic(target_path,` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 3912 | `string ASC_GlobalTop10LiveDirectory(const ASC_RuntimeState &state)` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 3921 | `string live_dir = ASC_GlobalTop10LiveDirectory(state);` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 3931 | `return ASC_GlobalTop10ArtifactPathForDirectory(ASC_GlobalTop10LiveDirectory(state), runtime_symbol, canonical_symbol);` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 4258 | `return ASC_GlobalTop10LiveDirectory(state);` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6760 | `ASC_GlobalTop10LiveDirectory(state),` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6852 | `string live_dir = ASC_GlobalTop10LiveDirectory(state);` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 9932 | `body += StringFormat("Global Top 10 live family directory: %s\n", ASC_TextOrUnavailable(ASC_GlobalTop10LiveDirectory(state)));` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 4847 | `string ASC_Top5BucketRootDirectory(const ASC_RuntimeState &state)` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 4909 | `string root = ASC_Top5BucketRootDirectory(state);` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 4917 | `string root = ASC_Top5BucketRootDirectory(state);` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 4941 | `string root = ASC_Top5BucketRootDirectory(state);` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 4949 | `string root = ASC_Top5BucketRootDirectory(state);` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 5062 | `body += "current_surface_path=" + ASC_TextOrUnavailable(ASC_Top5BucketRootDirectory(state)) + "\n";` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6348 | `ASC_RecordTop5BucketDecision(state, "top5_bucket_resize_reset_failed", ASC_RESULT_ERROR, ASC_RC_INVALID_STATE, resize_reason, ASC_Top5BucketRootDirectory(state));` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6367 | `ASC_RecordTop5BucketDecision(state, "top5_bucket_empty_source", manifest_ok ? ASC_RESULT_WARNING : ASC_RESULT_ERROR, manifest_ok ? ASC_RC_NOT_FOUND : ASC_RC_IO_FAILED, reason + " / " + manifest_reason, ASC_Top5BucketRootDirectory(state));` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6381 | `ASC_RecordTop5BucketDecision(state, "top5_bucket_queue_resize_failed", ASC_RESULT_ERROR, ASC_RC_INVALID_STATE, resize_reason, ASC_Top5BucketRootDirectory(state));` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6398 | `ASC_RecordTop5BucketDecision(state, "top5_bucket_active_resize_failed", ASC_RESULT_ERROR, ASC_RC_INVALID_STATE, resize_reason, ASC_Top5BucketRootDirectory(state));` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6445 | `ASC_Top5BucketRootDirectory(state));` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6462 | `ASC_RecordTop5BucketDecision(state, "top5_bucket_yield", ASC_RESULT_OK, ASC_RC_OK, "yield_for_ui_priority", ASC_Top5BucketRootDirectory(state));` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6468 | `ASC_RecordTop5BucketDecision(state, "top5_bucket_yield", ASC_RESULT_OK, ASC_RC_OK, "yield_near_write_budget", ASC_Top5BucketRootDirectory(state));` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6481 | `ASC_RecordTop5BucketDecision(state, "top5_bucket_queue_guard", ASC_RESULT_ERROR, ASC_RC_INVALID_ARGUMENT, queue_guard_reason, ASC_Top5BucketRootDirectory(state));` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6553 | `ASC_Top5BucketRootDirectory(state));` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 4931 | `string ASC_Top5BucketChildPath(const ASC_RuntimeState &state,const string bucket_slug,const string symbol)` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 5405 | `string child_path = ASC_Top5BucketChildPath(state, state.top5_bucket_queue_slugs[i], state.top5_bucket_queue_symbols[i]);` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6226 | `string child_path = ASC_Top5BucketChildPath(state, slug, selected.symbol);` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 6515 | `ASC_RecordTop5BucketDecision(state, "top5_bucket_child_write", child_ok ? ASC_RESULT_OK : ASC_RESULT_WARNING, child_ok ? ASC_RC_OK : ASC_RC_IO_FAILED, child_reason + " / " + family_reason, ASC_Top5BucketChildPath(state, slug, state.top5_bucket_queue_symbols[qi]));` |
| `mt5/runtime/ASC_Dispatcher.mqh` | 12103 | `string top5_child_path = ASC_Top5BucketChildPath(state, top5_slug, selected.symbol);` |
| `mt5/core/ASC_Constants.mqh` | 256 | `#define ASC_TOP5_BUCKET_PATH_FRAGMENT "Dossiers/Top5PerBucket"` |

## SECTION 7 — CONTRADICTION LEDGER

| Conflict | Claim A | Claim B | Source for A | Source for B | Evidence Rank A | Evidence Rank B | Which Outranks / Why | Resolution Required | Pause? |
|---|---|---|---|---|---:|---:|---|---|---|
| SDP topology | RUN188 proved a Symbol Data Pack can write. | Desired SDP mirror topology is not implemented. | RUN188 runtime report/operator evidence. | Active source `ASC_SymbolDataPackWriter.mqh`/Contracts inspection. | 2 | 3 | Active source outranks a single output observation for topology authority. | Implement mirror topology before RUN195. | TEST FIRST |
| Dossier root publication | Root Dossier symbol files are allowed by current contract. | Root symbol spam is now considered waste risk. | `ASC_DossierContracts.mqh`. | RUN189 topology decision and RUN188 write pressure. | 3 | 2/1 | Current source proves present behavior; planning defines new target but not runtime truth. | RUN193 must suppress safely without deleting selected/current dossier semantics. | TEST FIRST |
| Recurrence | One SDP file existed. | Recurrence after next_due was not proven. | RUN188 manifest/report. | RUN188 proof gap. | 2 | 2 | Same rank; absence of second due-window proof blocks recurrence claim. | RUN195 must capture recurrence after next_due. | TEST FIRST |
| Write pressure | More artifacts improve visibility. | Severe writes can starve timer-driven publication. | Operator/product intent. | RUN188 beat evidence + official MQL5 timer queue behavior. | 1/2 | 1 official + 2 runtime | Timer semantics and observed pressure outrank visibility desire. | Reduce duplicate writes; no catch-up assumption. | TEST FIRST |

## SECTION 8 — NO-ORNAMENT RULE APPLICATION

| Roadmap / Doctrine Item | Status | Reason |
|---|---|---|
| “Mirror SDP to Dossier family topology” | KEEP | Prevents family divergence and creates measurable RUN195 proof paths. |
| “Flat SDP root file is enough” | DELETE AS PROOF | Does not prove GlobalTop10/Top5PerBucket family topology or recurrence. |
| “Root Dossier symbol files everywhere” | CONVERT TO TEST | May be waste; must be suppressed only after mirror proof path exists. |
| “Rewrite FileIO to fix this” | DELETE | Solves wrong layer; high regression risk; official docs do not require it. |
| “Change heartbeat cadence” | DELETE | Scope-protected and not required; timer non-stacking demands less work, not cadence optimism. |
| “HUD/Market Board can backfill missing artifact truth” | DELETE | Violates owner boundaries; not needed for topology. |
| “Lite content should become another full Dossier” | MERGE / LIMIT | Keep Dossier-like factual structure, but exclude Layer 6 and heavy deep-only sections. |

## SECTION 9 — RUN190–RUN195 CAMPAIGN PLAN

| Run | Mode | Allowed Patch Area | Required Outcome | Protected Boundaries |
|---|---|---|---|---|
| RUN190R | SOURCE-CONTRACT + PATCH | SDP routing/writer path helpers only. | Add route-aware target path functions for `GlobalTop10` and `Top5PerBucket`, using existing FileIO. | No FileIO rewrite; no rank/order/formula change. |
| RUN191R | PATCH | GlobalTop10 SDP mirror publication. | Publish SDP children under `Symbol Data Packs\GlobalTop10` from existing GlobalTop10 membership only. | No new selection logic. |
| RUN192R | PATCH | Top5PerBucket SDP mirror publication. | Publish SDP children under `Symbol Data Packs\Top5PerBucket\<bucket>` from existing Top5 membership only. | No bucket/rank formula change. |
| RUN193R | PATCH | Root spam suppression and transition handling. | Suppress direct root SDP files and root Dossier symbol spam once mirrored family targets are ready; preserve selected/current dossier semantics. | No deletion of canonical selected Dossier/Current Focus behavior. |
| RUN194R | AUDIT + PATCH IF NEEDED | Proof bundle readiness, status tokens, manifests, version/control. | Static readiness package for RUN195 live with exact proof checklist. | No live test. No strategy/execution. |
| RUN195R | LIVE EVIDENCE REVIEW | No broad code patch during proof capture. | Prove mirrored SDP GlobalTop10 + Top5PerBucket recurrence, manifests, Scanner Status, and root-spam suppression under live runtime. | No production-ready claim unless evidence rank warrants it. |

## SECTION 10 — RUN195 PROOF CONTRACT

RUN195 must prove all of the following, or the decision remains TEST FIRST / HOLD:

| Proof Requirement | Required Evidence |
|---|---|
| GlobalTop10 SDP mirror exists | Non-zero files under `Symbol Data Packs\GlobalTop10\<symbol>_SYMBOL_DATA_PACK.txt` for current GlobalTop10 members plus `_family_manifest.txt`. |
| Top5PerBucket SDP mirror exists | Non-zero files under `Symbol Data Packs\Top5PerBucket\<bucket>\<symbol>_SYMBOL_DATA_PACK.txt` plus `_bucket_manifest.txt` and family manifest. |
| Recurrence after due time | At least two due windows or one initial publication plus one post-`next_due` token-valid update/continuity event. |
| Scanner Status restored | Required Scanner Status token contract present and valid. |
| Runtime proof bundle complete | Manifest, Scanner Status, function results/logs, heartbeat/budget evidence, and artifact path evidence all captured. |
| Root spam suppression | Direct root flat SDP and direct root Dossier symbol spam absent, suppressed, or explicitly transition-labelled as non-authoritative. |
| No rank/order/formula drift | Dossier and SDP family membership/order match existing top-list authority. |
| No FileIO/heartbeat scope drift | Diff proves FileIO and heartbeat cadence unchanged. |
| Write pressure improved | Beat/write-lane evidence shows reduced pressure or bounded yielding compared with RUN188’s 22s–25s failure window. |

## SECTION 11 — WRITE PRESSURE REDUCTION WITHOUT FILEIO OR HEARTBEAT REWRITE

Allowed pressure reductions:

1. Publish only mirrored family members, not full universe symbol files.
2. Suppress redundant direct root Dossier symbol files after mirror readiness.
3. Suppress or quarantine flat root SDP files as transition evidence only.
4. Use existing one-child/manifest rotation patterns instead of full family rewrite per beat.
5. Skip no-change child writes where payload/hash/freshness state is unchanged.
6. Keep manifests compact and proof-oriented.
7. Preserve existing atomic write FileIO; do not add aggressive FileFlush loops.
8. Keep Lite content factual and bounded; do not hydrate Layer 6 or heavy deep-only narrative.
9. Do not ask timer queue behavior to “catch up” after a 22s–25s write beat.
10. Validate recurrence after `next_due`, not merely first publication.

## SECTION 12 — SYMBOL DATA PACK LITE CONTENT BOUNDARY

### Include

- L0 identity and classification fields needed for operator context.
- Family membership provenance: GlobalTop10 or Top5PerBucket bucket/source/rank as consumed from existing authority.
- Market State posture, freshness, open/closed/uncertain/unknown facts.
- Market Watch quote facts: bid/ask/last/spread/spread %, tick age, quote freshness.
- Trading condition/spec facts if already available cheaply from upstream snapshots.
- Candidate/shortlist factual summaries already computed upstream.
- Bounded numeric OHLC/ATR/range/VWAP/indicator facts where already hydrated by lawful owners.
- Publication/integrity tokens: source owner, created time, next due, payload status, manifest link.

### Exclude

- Layer 6.
- Heavy deep-only sections.
- Strategy/execution recommendations.
- Trade direction claims.
- Semi-auto trading brain claims.
- Narrative opportunity paths.
- Large tick dumps.
- Any recomputation of shortlist rank/order/formula.
- Any HUD or Market Board-owned backfill.

## SECTION 13 — PATCH APPLIED IN RUN189

| File | Patch Type | Why It Was Legal |
|---|---|---|
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | Source-contract constants/comments only. | Real gap existed: source did not lock mirrored SDP family topology. No runtime route logic changed. |
| `mt5/core/ASC_Version.mqh` | Version/current-run/proof-boundary macros. | Control identity only; no runtime algorithm patch. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md` | Control roadmap update. | Required to lock RUN190–RUN195 campaign. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | Active log update. | Required audit trail. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | Output manifest update. | Required packaging truth. |
| `roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md` | Guidebook constraint update. | Prevents future Codex/source-patch drift. |
| `office/ROADMAP_STATUS.md` | Office status. | Required project control. |
| `office/WORK_LOG.md` | Office work log. | Required project control. |
| `office/CHANGE_LEDGER.md` | Office change ledger. | Required project control. |
| `office/DECISIONS.md` | Office decision log. | Required project control. |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN189R_REPORT.md` | Report. | Required run artifact. |

## SECTION 14 — PROTECTED FILES CONFIRMED NOT PATCHED

Protected areas not patched in RUN189:

- `mt5/io/ASC_FileIO.mqh`
- HUD files
- `ASC_MarketBoardWriter.mqh`
- shortlist/top-list/rank/order/formula engines
- candidate score logic
- heartbeat cadence logic
- strategy/execution/semi-auto logic
- old RUN177 live chain restoration
- Market Board logic
- FileIO atomic promotion implementation

## SECTION 15 — FINAL DECISION

TEST FIRST

Strongest next move: RUN190R should implement only route-aware Symbol Data Pack mirror path helpers and writer routing for `Symbol Data Packs\GlobalTop10` and `Symbol Data Packs\Top5PerBucket`, using existing FileIO and existing Dossier membership authority, with explicit diff proof that rank/order/formula, FileIO, heartbeat, HUD, Market Board, and strategy/execution were untouched.
