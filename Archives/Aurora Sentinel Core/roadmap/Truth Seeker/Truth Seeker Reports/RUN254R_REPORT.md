# GIT HEADER SUMMARY
```text
TRUTH SEEKER ROADMAP — RUN254R / WHOLE-SYSTEM FAILURE MAP AUDIT AFTER RUN253 LIVE PROOF — DIAGNOSE REFRESH DEATH, MAIN/LITE SPLIT-BRAIN, PUBLICATION STARVATION, IDENTITY DRIFT, AND ROADMAP REPAIR ORDER BEFORE ANY PATCH
MODE: AUDIT + RESEARCH + ROADMAP PLANNING
TRUTH FURNACE REQUIRED
REPORT: RUN254R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN254R.zip
SOURCE BASELINE: RUN252R unless active source/package evidence proves a later baseline
LIVE EVIDENCE BASELINE: RUN253R live proof / latest uploaded runtime evidence
FINAL DECISION: HOLD
```

# FINAL SUMMARY
```text
RUN254R inspected the uploaded source package and the uploaded Upcomers-Server runtime evidence as read-only evidence. No source code was patched. No generated runtime output was edited, cleaned, deleted, or renamed.

The weakest premise is dead: the next run must not patch the “obvious thing.” The first hard gate is deployment/runtime identity. The inspected source package identifies itself as RUN252R / RUN252R-SiamDataPurityReadabilitySemanticsCleanup, but the uploaded Scanner Status, Market Board, and Manifest runtime surfaces identify the active runtime writer as RUN249R. That is a source/runtime identity contradiction, not a cosmetic label issue.

RUN253/live evidence was supplied as the Upcomers-Server export and was usable only inside its observed window. Compile proof was not supplied as a MetaEditor transcript. User statements that the EA compiled remain Evidence Class 2; they do not prove deployed identity.

“No refresh” is partially proven and more precisely classified as publication starvation / stale current surfaces while logs continued. Market Board, Scanner Status, Manifest, and Open Symbol Snapshot have current-surface publication times around 2026.05.03 22:34 UTC, while FunctionResults and heartbeat telemetry continue through approximately 2026.05.03 22:51 UTC. This is not full EA death based on supplied evidence.

Main/Lite mismatch is proven inside the uploaded runtime evidence. Dossier GlobalTop10 has zero final files and four staging children; Symbol Data Packs/GlobalTop10 is absent. Top5PerBucket Main Dossier final children are partial and do not match Lite SDP final children: crypto 3 vs 5, energy 1 vs 3, fx 2 vs 3, indices 0 vs 5.

GlobalTop10 failure is proven for the uploaded runtime package: Market Board shows 10 GlobalTop10 rows, but Dossiers/GlobalTop10 has no final child files and Symbol Data Packs/GlobalTop10 is absent. Top5 parity failure is proven. Heartbeat starvation is proven for the observed runtime identity: 180 of 250 heartbeat rows exceeded 2000ms, 176 exceeded 5000ms, and max elapsed_ms was 8866.0ms.

File promotion/path proof is insufficient for the failing routes. Source FileIO has temp/write/readback/promote structure and captures FileMove error codes, but the runtime evidence does not provide per-route FileMove/FileDelete proof sufficient to explain why final GlobalTop10 and Main/Lite parity failed.

Archive/cache stayed mostly non-current by labels and paths, but previous-state cache evidence was absent. Siam fields appear in some RUN249-generated output surfaces, but RUN252 semantic field activation cannot be proven because the runtime evidence is RUN249R.

Research changed the roadmap by forcing identity gates, timer budget gates, file-operation proof, contract-first Main/Lite parity, lineage/provenance fields, and recurrence tests before any patch. Prompt/Brain Guidebook improvements are required but not patched in RUN254R.

What must be fixed first: prove/deploy the correct compiled EX5 and terminal data path, then run a bounded breathing-cycle proof. What must not be touched yet: HUD, L3/L4 ranking/formulas, trade/signal logic, broad Dispatcher rewrite, FileIO rewrite, Siam polish, and generated-output cleanup.

Exact next run recommendation: RUN255R identity/deploy proof repair. The run must prove source package -> compiled EX5 -> active terminal -> output root -> generated source_run_id alignment before any route or parity patch.

Remaining unproven: MetaEditor compile cleanliness for RUN252R/RUN253R source, active terminal include-tree identity, whether RUN252 source would fix any observed failure if actually deployed, exact FileMove/FileOpen failure cause for missing final routes, and any production/trading readiness.
```

# SECTION 0 — MODE LOCK
| Declaration | Answer |
|---|---|
| current run | RUN254R |
| primary mode | AUDIT |
| secondary mode | RESEARCH + ROADMAP PLANNING |
| source patch allowed? | no |
| generated output editing allowed? | no |
| generated output cleanup/deletion/renaming allowed? | no |
| roadmap planning allowed? | yes |
| live proof supplied? | yes: Upcomers-Server export |
| source truth claim allowed? | only from direct package/source inspection |
| compile proof claim allowed? | no MetaEditor transcript supplied |
| runtime proof claim allowed? | only for observed Upcomers-Server evidence window |
| full-system fix claim allowed? | no |
| next prompt after report | roadmap implementation prompt after report review |
| final decision | HOLD |

Evidence ceiling used: user statements/pasted summaries = Class 2; direct source/package inspection = Class 3; runtime logs/generated artifacts = operational evidence only inside the observed terminal/export/session/time window; external research = constraints/tests/falsifiers only; AI inference = Class 1 and proves nothing by itself.

# SECTION 1 — FIRST PRINCIPLE / WEAKEST PREMISE
The premise “patch the obvious thing next” is rejected. The failure is systemic until the identity gate is reconciled. If RUN252 source is not the source that produced the runtime files, then route-patch conclusions based on RUN249 evidence can easily patch the wrong owner. The real first danger is not GlobalTop10 itself; it is the possibility that the terminal is running stale code while the roadmap assumes current code.

# SECTION 2 — EVIDENCE INTAKE TABLE
| Evidence Item | Status | Evidence Class | Notes |
|---|---:|---:|---|
| `README.md` | present | 3 | size=2144 |
| `MASTER_INDEX.md` | present | 3 | size=1858 |
| `CHAT_CONTINUATION_GUIDE.md` | present | 3 | size=1724 |
| `FRONT_DOOR_CHECKLIST.md` | present | 3 | size=1560 |
| `ASC_CORE.MD` | present | 3 | size=50518 |
| `office/ROADMAP_STATUS.md` | present | 3 | size=1340 |
| `office/WORK_LOG.md` | present | 3 | size=1737 |
| `office/CHANGE_LEDGER.md` | present | 3 | size=2443 |
| `office/DECISIONS.md` | present | 3 | size=1663 |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | present | 3 | size=1544 |
| `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | present | 3 | size=1259 |
| `roadmap/Truth Seeker/Guidebooks/AURORA_GUIDEBOOK_INDEX.md` | present | 3 | size=24479 |
| `roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md` | present | 3 | size=37913 |
| `roadmap/Truth Seeker/Guidebooks/AURORA_TRADING_BRAIN_GUIDEBOOK.md` | present | 3 | size=22937 |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN245R_REPORT.md` | present | 3 | size=33915; RUN253 report absent in source package if listed missing |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN246R_REPORT.md` | present | 3 | size=26165; RUN253 report absent in source package if listed missing |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN247R_REPORT.md` | present | 3 | size=15323; RUN253 report absent in source package if listed missing |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN248R_REPORT.md` | present | 3 | size=27774; RUN253 report absent in source package if listed missing |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN249R_REPORT.md` | present | 3 | size=16294; RUN253 report absent in source package if listed missing |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN250R_REPORT.md` | present | 3 | size=30829; RUN253 report absent in source package if listed missing |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN251R_REPORT.md` | present | 3 | size=32410; RUN253 report absent in source package if listed missing |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN252R_REPORT.md` | present | 3 | size=27986; RUN253 report absent in source package if listed missing |
| `roadmap/Truth Seeker/Truth Seeker Reports/RUN253R_REPORT.md` | missing | 3 | size=0; RUN253 report absent in source package if listed missing |
| `mt5/AuroraSentinelCore.mq5` | present | 3 | size=15869 |
| `mt5/runtime/ASC_Dispatcher.mqh` | present | 3 | size=1014064 |
| `mt5/runtime/ASC_Bootstrap.mqh` | present | 3 | size=19977 |
| `mt5/runtime/ASC_RuntimeClock.mqh` | present | 3 | size=135 |
| `mt5/core/ASC_Version.mqh` | present | 3 | size=145290 |
| `mt5/core/ASC_Constants.mqh` | present | 3 | size=80986 |
| `mt5/core/ASC_Types.mqh` | present | 3 | size=4940 |
| `mt5/core/ASC_RuntimeState.mqh` | present | 3 | size=50498 |
| `mt5/logging/ASC_FunctionResults.mqh` | present | 3 | size=121767 |
| `mt5/io/ASC_FileIO.mqh` | present | 3 | size=34476 |
| `mt5/market_state/ASC_MarketStateEngine.mqh` | present | 3 | size=66365 |
| `mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` | present | 3 | size=121478 |
| `mt5/candidate_filtering/ASC_SelectionFilter.mqh` | present | 3 | size=163824 |
| `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh` | present | 3 | size=152849 |
| `mt5/shortlist_selection/ASC_ATRSummaryEngine.mqh` | present | 3 | size=7995 |
| `mt5/shortlist_selection/ASC_RegimeSummaryEngine.mqh` | present | 3 | size=2114 |
| `mt5/shortlist_selection/ASC_LiquidityFrictionSummaryEngine.mqh` | present | 3 | size=1968 |
| `mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh` | present | 3 | size=188238 |
| `mt5/artifacts/ASC_DossierWriter.mqh` | present | 3 | size=19928 |
| `mt5/artifacts/ASC_DossierComposer.mqh` | missing | 3 | size=0 |
| `mt5/artifacts/ASC_DossierContracts.mqh` | missing | 3 | size=0 |
| `mt5/artifacts/ASC_CurrentFocusWriter.mqh` | present | 3 | size=17643 |
| `mt5/artifacts/ASC_MarketBoardWriter.mqh` | present | 3 | size=195284 |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | present | 3 | size=163800 |
| `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` | present | 3 | size=129011 |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | present | 3 | size=134379 |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackRouting.mqh` | present | 3 | size=11467 |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh` | present | 3 | size=151836 |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | present | 3 | size=80745 |
| `mt5/hud/ASC_HUD_Manager.mqh` | present | 3 | size=774044 |
| `Upcomers-Server/Scanner Status.txt` | present | 7 within observed runtime window | size=252680; min_date=2026.05.03 22:31:46; max_date=2026.05.03 22:39:25 |
| `Upcomers-Server/Market Board.txt` | present | 7 within observed runtime window | size=652108; min_date=2026.03.17 14:02:51; max_date=2026.05.03 22:34:24 |
| `Upcomers-Server/Artifact Bundle Manifest.txt` | present | 7 within observed runtime window | size=249370; min_date=2026.05.03 22:31:46; max_date=2026.05.04 00:34:24 |
| `Upcomers-Server/Open Symbol Snapshot.txt` | present | 7 within observed runtime window | size=43446; min_date=2026.05.03 22:34:27; max_date=2026.05.03 22:34:39 |
| `Upcomers-Server/Workbench/logs/function_results.log` | present | 7 within observed runtime window | size=12927328; min_date=2026.05.03 22:31:46; max_date=2026.05.03 23:11:50 |
| `Upcomers-Server/Workbench/logs/heartbeat_telemetry.log` | present | 7 within observed runtime window | size=4556416; min_date=2026.05.03 22:31:47; max_date=2026.05.03 23:11:50 |
| MetaEditor compile output after RUN252/RUN253 | missing | unavailable | User says compile happened, but no transcript was supplied. |
| Experts log / Journal log | missing | unavailable | Cannot prove crash/no-crash from terminal logs. |

# SECTION 3 — INTERNET / EXTERNAL RESEARCH CONVERSION LEDGER
| Source URL / Citation | Research Lane | Finding | Aurora Failure Risk | Converted Audit Constraint | Roadmap Rule | Falsifier |
|---|---|---|---|---|---|---|
| https://help.openai.com/en/articles/6654000-prompt-engineering-guide | OpenAI prompting | Put instructions first, be specific, show desired format, reduce fluff, and use precise output requirements. | Mega-prompts can sound strict while still permitting hidden assumptions or unparseable output. | RUN prompts must declare mode, evidence ceiling, exact allowed/forbidden scope, and required output tables before context. | No patch prompt may say “fix everything”; every fix must have owner, acceptance test, and falsifier. | Prompt lacks explicit owner/test/decision tables. |
| https://help.openai.com/en/articles/10032626-prompt-engineering-best-practices-for-chatgpt | OpenAI prompting | Clear, specific prompts with enough context reduce ambiguity; iteration is expected. | RUN chains may stack vague doctrine instead of enforceable checks. | Prompt self-check must reject missing evidence and unresolved ambiguity. | Brain Guidebooks must convert doctrine into durable test rules. | Report contains claims without evidence rank. |
| https://www.mql5.com/en/docs/event_handlers/ontimer | MQL5 timer/event behavior | Timer events are event-queue driven; if a Timer event is queued or processing, another Timer event is not added. | Heavy work inside timer can starve refresh/publish lanes while logs still continue. | Heartbeat audit must measure elapsed_ms, skipped work, deferred work, and stale artifact timestamps. | Cheap status/manifest proof must publish before deep lanes. | Heartbeat rows exceed budget while status artifacts stop refreshing. |
| https://www.mql5.com/en/docs/event_handlers | MQL5 event handlers | MQL5 programs react through defined event handlers. | Wrong handler/lane assumptions can misclassify EA death vs publication starvation. | Classify full EA death only if Experts/Journal or event cessation proves it. | Logs continuing while artifacts stale = publication starvation unless crash evidence outranks. | FunctionResults/heartbeat continue after artifact timestamps stop. |
| https://www.mql5.com/en/docs/files/fileopen | MQL5 file behavior | FileOpen returns a handle or INVALID_HANDLE; path/sandbox behavior must be explicit. | Writer can silently fail if path/sandbox/handle assumptions are wrong. | FileOpen failure must log target path and GetLastError. | No “published” claim without final file evidence. | Final absent and no FileOpen error proof exists. |
| https://www.mql5.com/en/docs/files/filemove | MQL5 file behavior | FileMove has explicit source/destination flags and returns success/failure. | Staging can exist while final promotion silently fails. | FileMove promotion must log source, destination, FILE_REWRITE policy, bool, and error code. | Route repair must inspect staging→final promotion before touching membership/ranking. | Staging files exist but final files absent. |
| https://www.mql5.com/en/docs/files/filedelete | MQL5 file behavior | FileDelete returns whether deletion succeeded. | Cleanup/archive can be counted as success when delete failed. | Delete/archive cleanup must log target, result, and error code. | No destructive cleanup in audit run. | Archive/delete success inferred without return/error proof. |
| https://www.mql5.com/en/docs/check/getlasterror | MQL5 error handling | GetLastError returns last runtime error. | Missing error capture prevents root-cause isolation. | Failure branches must capture GetLastError immediately. | File-operation proof table required before FileIO-adjacent patch. | Failure branch has no error code in logs. |
| https://www.mql5.com/en/docs/common/resetlasterror | MQL5 error handling | ResetLastError clears previous error state. | Stale errors can pollute file-operation diagnosis. | ResetLastError before file operations being diagnosed. | Never use old error state as current proof. | Error code observed without reset boundary. |
| https://sre.google/sre-book/monitoring-distributed-systems/ | SRE reliability | Monitor latency, traffic, errors, and saturation; symptoms need service-level signals. | Heartbeat alone can hide stale outputs. | Aurora heartbeat table must include latency/budget, output refresh, error/failure state, and queue saturation equivalents. | Breathing cycle cannot be called healthy from one artifact. | Logs alive but output SLA missed. |
| https://sre.google/sre-book/addressing-cascading-failures/ | SRE reliability | Overload can create cascading failure and secondary symptoms that look like root cause. | Retry/deep/archive work can amplify timer overload. | Separate root-cause lane from secondary symptoms with owner tables. | Reduce failure class before adding feature surface. | Retry/deep work rises while status publish starves. |
| https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ | SRE reliability | Retries need timeouts/backoff/jitter to avoid amplifying overload. | Artifact rescue/retry can become storm load. | Retry/backoff must be bounded and visible in telemetry. | No rescue loop without next_due and skip counters. | Retry attempts recur every beat under budget pressure. |
| https://docs.open-metadata.org/v1.12.x/how-to-guides/data-contracts/spec | Data contracts | Data contracts define schema/quality/semantics/SLA expectations. | Main/Lite parity is untestable without a contract. | Create Main Dossier↔Lite SDP contract before patching route logic. | Contract first, patch second. | Lite publishes different count/symbol set than Main with no blocker. |
| https://docs.open-metadata.org/v1.12.x/api-reference/data-contracts | Data contracts | Contracts include entity relationships and testable expectations. | Route layout drift can be called acceptable without measurable expectations. | Artifact SLA table must define producer, consumer, count, required fields, failure state, blocker. | No parity claim without exact count/symbol/rank checks. | Counts differ but parity claim passes. |
| https://openlineage.io/docs/spec/facets/ | Lineage/provenance | Facets attach extensible metadata to lineage entities. | Generated artifacts can lose route/run/source identity. | Require source_run_id, route_family, source_snapshot_id, publication_epoch, producer, state. | Archive/cache/staging must be marked non-current. | Artifact lacks state/provenance fields. |
| https://openlineage.io/docs/spec/facets/run-facets/ | Lineage/provenance | Run facets describe metadata about a particular run. | RUN249 output can be mistaken for RUN252 proof. | Deployment identity gate must compare source run, compile run, runtime run, artifact run. | Stop downstream conclusions if run IDs diverge. | source says RUN252, runtime says RUN249. |
| https://openlineage.io/docs/spec/facets/job-facets/ | Lineage/provenance | Job facets describe job/source identity. | Producer/job identity drift can hide which owner emitted an artifact. | Every artifact family must expose producer/job owner. | Patch owner only after producer is known. | Artifact missing producer/owner field. |
| https://www.w3.org/TR/prov-overview/ | Lineage/provenance | PROV models entities, activities, and agents to explain provenance. | Archive/current/cache lineage ambiguity can turn history into truth. | Report must separate entity/artifact, activity/publication, agent/producer. | Current truth cannot be derived from archive/cache. | Archive file used as membership source. |
| https://csrc.nist.gov/pubs/sp/800/218/final | Secure development / recurrence | SSDF emphasizes secure, repeatable development practices and vulnerability/defect mitigation. | Patch stacking can repair symptoms without recurrence tests. | Each patch run needs root cause, regression trap list, and evidence aligned package/report. | Small bounded patches only after exact owner. | Patch changes route+FileIO+semantics+HUD in one run. |

# SECTION 4 — CURRENT KNOWN FAILURE CLAIMS TESTED
| Claim | Current Evidence Class | Result | Must Prove By / Evidence Used |
|---|---:|---|---|
| No refresh happens anymore | 2 -> 7 for supplied evidence | Partially proven as stale current surfaces while logs continue | Market Board/Scanner/Manifest/OSS around 22:34 vs FunctionResults/Heartbeat through 22:51 |
| Lite is not identical to Main | 2 -> 7 | Proven for uploaded runtime package | Folder/file comparison: Main Dossier vs Lite SDP route/layout/symbol/count |
| Runtime evidence may be old RUN249 identity | 2 -> 7 | Proven | Scanner/Board/Manifest source_run_id=RUN249R vs source package RUN252R |
| Heartbeat starvation remains | 2 -> 7 | Proven | Heartbeat telemetry elapsed_ms max 8866, 180 rows >2000ms, 176 rows >5000ms |
| GlobalTop10 final route is missing | 2 -> 7 | Proven | Dossiers/GlobalTop10 final=0, staging=4; SDP/GlobalTop10 absent |
| Top5 parity is broken | 2 -> 7 | Proven | bucket file-count/symbol comparison |
| Archive/cache may be ambiguous | 2 -> 7 partial | Partially proven | Archive exists; previous_state_cache absent; labels suggest non-current but consumer proof absent |
| Siam fields may exist in source but not generated output | 2 -> 7 partial | Runtime has some Siam fields, but from RUN249 identity | term search found section_coherence/siam_review/session_scope in outputs; cannot prove RUN252 activation |
| Source deploy identity may be wrong | 2 -> 7 | Proven as mismatch; exact deploy cause unproven | source ASC_Version RUN252R vs runtime source_run_id RUN249R |

# SECTION 5 — FULL-SYSTEM FAILURE MAP
| Failure Domain | Symptom | Evidence Found | Evidence Rank | Likely Owner | Possible Root Cause | What Outranks This? | Patch Later? | Roadmap Priority |
|---|---|---|---:|---|---|---|---:|---|
| Compile/deploy identity | runtime surfaces claim older run | source RUN252R vs runtime RUN249R | 3 vs 7 | ASC_Version / compile/deploy process / terminal data path | old EX5 running or wrong output root exported | MetaEditor transcript + Experts identity + terminal data path proof | yes | 0 |
| Terminal data folder / output path identity | export may not match active Files path | no terminal path proof supplied | 2/7 | operator deploy/export process | wrong terminal folder or stale exported root | Experts log path + terminal data folder note | yes | 0 |
| OnTimer heartbeat / lane scheduling | heartbeats continue with heavy budget pressure | 237/250 rows over 880ms; max 8866ms | 7 | ASC_Dispatcher / RuntimeClock | deep trigger monopolizes timer/persistence lane | fresh compile/run with timing proof | yes | 1 |
| Artifact keepalive / rescue | status surfaces stop refreshing while logs continue | status/board/manifest timestamps stop ~22:34, logs continue ~22:51 | 7 | ASC_Dispatcher keepalive/rescue | status refresh starved by heavy/deferred work or not due gates | fresh RUN252+ aligned live proof | yes | 1 |
| Market Board refresh | visible board stale relative to heartbeat | Market Board Generated At 22:34:24; log continues 22:51 | 7 | ASC_MarketBoardWriter + Dispatcher | publish skipped/starved/not due under write pressure | new aligned runtime evidence | yes | 1 |
| Scanner Status refresh | stale relative to heartbeat | Scanner Status Updated At 22:34:41; log continues 22:51 | 7 | ASC_ScannerStatusWriter + Dispatcher | keepalive cadence not winning under budget pressure | new aligned runtime evidence | yes | 1 |
| Artifact Bundle Manifest refresh | stale / only intermittent writes | FunctionResults has 7 manifest writes only | 7 | ASC_WriteArtifactBundleManifest | manifest gating/dependency/publish budget | per-write operation proof | yes | 1 |
| Open Symbol Snapshot refresh | stale relative to logs | OSS around 22:34:40; log continues | 7 | ASC_OpenSymbolSnapshotEngine + Dispatcher | snapshot write not repeating or not due; identity mismatch blocks RUN252 conclusion | fresh aligned run | yes | 1 |
| FunctionResults logging | continues after artifacts stale | 860 rows to 22:51:57 | 7 | ASC_FunctionResults | logging lane alive, not proof of artifact health | Experts/Journal + artifact mtimes | no patch first | evidence |
| GlobalTop10 Dossier final route | final folder empty; staging has 4 | Dossiers/GlobalTop10 final=0; staging=4 | 7 | ASC_Dispatcher + ASC_DossierWriter + FileIO | promotion blocked/stalled; batch cursor incomplete; budget exhaustion | FileMove proof + aligned source identity | yes | 2 |
| GlobalTop10 SDP final route | folder absent | Symbol Data Packs/GlobalTop10 missing | 7 | ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication + SDP writer | not due/dependency blocked/no promoted snapshot | aligned source identity + route telemetry | yes | 2 |
| Top5 Dossier final route per bucket | partial children | Main final crypto 3, energy 1, fx 2, indices 0 | 7 | ASC_DossierWriter / Dispatcher Top5 route | queue/promotion incomplete under budget pressure | bucket route logs and FileMove proof | yes | 4 |
| Top5 SDP final route per bucket | Lite has more children than Main | Lite crypto 5, energy 3, fx 3, indices 5 | 7 | ASC_SymbolDataPackWriter + top5 mirror service | Lite writer not slaved to Main final current truth | contract test after identity gate | yes | 3 |
| Main/Lite parity contract | split-brain | counts/symbols differ and Lite has buckets Main lacks | 7 | Dossier contracts + SDP contracts/routing/writer | no enforceable Main→Lite current route contract | contract table + current snapshot id | yes | 3 |
| Archive timestamped history | archive exists but cannot prove nonblocking | SDP archive folders present; Dossier Top5 archive present | 7 | SDP writer / Dossier route | history writes may consume budget or confuse truth | archive current/non-current consumer test | yes | 5 |
| Previous-state cache | absent in supplied evidence | Symbol Data Packs/_previous_state_cache missing | 7 | SDP continuity/cache owner | cache route not emitted or export excluded | fresh folder listing | maybe | 5 |
| File promotion/staging/final movement | staging exists but final absent | GlobalTop10 staging 4, final 0 | 7 | ASC_FileIO + route writer callers | promotion failing or never reached | FileMove bool/error per route | yes | 2 |
| Deep selective analysis / deep trigger budget | deep trigger dominates elapsed_ms | deep_analysis_trigger_ms max 8866; 179 >2000 | 7 | ASC_DeepSelectiveAnalysisEngine / Dispatcher trigger | heavy deep work inside timer/persistence lane | profiling in aligned run | yes | 6 |
| Presence sweep / archive history budget | not observed as active cost in heartbeat | presence_sweep_ms max 0 | 7 | Dispatcher side duties | not primary in supplied evidence | aligned run with all columns | no first | 6 |
| Dossier canonical truth | Main current incomplete | Main missing children while Lite complete-ish | 7 | Dossier writer/contracts | Main not established before Lite mirror | contract test | yes | 3 |
| Current Focus derivative truth | not supplied/verified | no Current Focus evidence inspected | unavailable | ASC_CurrentFocusWriter | not in evidence or not selected | fresh output package | no | later |
| HUD consumer-only boundary | HUD not implicated | HUD source read-only; no evidence HUD wrote truth | 3 | ASC_HUD_Manager | not root owner based on evidence | source/runtime proof of HUD mutation | no | forbidden |
| Siam semantic fields in generated output | present but old identity | term hits in RUN249 output; RUN252 cannot be proven | 7 + identity fail | SDP Composer/Writer/MarketBoard/Status writers | compiled source not deployed | identity aligned output | yes later | 7 |
| No-sample invariant | not directly tested | no_sample term not found in non-archive outputs | 7 partial | artifact writers | RUN252 semantic field not deployed or not emitted | aligned RUN252 output | later | 7 |
| No signal/trade permission boundary | boundary preserved | outputs contain review-only/no trade language; no trade module evidence | 7 | all writers/HUD | none observed | source grep + live output | no | always |
| Runtime report/package truth | RUN253 report absent; evidence export separate | source reports through RUN252 only; live package evidence supplied | 3/7 | reporting/package process | report not created in source package before RUN254 | RUN253 report if supplied | yes | 0 |

# SECTION 6 — DEPLOYMENT / IDENTITY GATE
| Identity Surface | Expected | Observed | PASS / HOLD / FAIL |
|---|---|---|---|
| ASC_Version.mqh source run ID | RUN252R or later active baseline | `RUN252R` / `RUN252R-SiamDataPurityReadabilitySemanticsCleanup` | PASS for source package |
| MetaEditor compile output date/time | after latest source | not supplied | HOLD |
| terminal Experts source identity | matches compiled source | not supplied | HOLD |
| Scanner Status source_run_id | RUN252R or later if RUN252 was deployed | - Source Run ID: RUN249R | FAIL |
| Market Board source_run_id | RUN252R or later if RUN252 was deployed | not observed | FAIL |
| Manifest source_run_id | RUN252R or later if RUN252 was deployed | not observed | FAIL |
| FunctionResults source_run_id | RUN252R or later if RUN252 was deployed | not observed | FAIL |
| generated artifact version markers | match compiled source | Scanner/Board/Manifest show RUN249R; source package RUN252R | FAIL |
| terminal data path | matches exported folder | not supplied | HOLD |
| output package evidence folder | matches actual MT5 Files path | not supplied | HOLD |

Identity gate verdict: FAIL/HOLD. Runtime evidence is valid evidence of an observed RUN249 runtime/export, not proof of RUN252 behavior. Downstream source-owner conclusions must pause until the terminal’s compiled EX5 and output root are proven aligned.

# SECTION 7 — REFRESH BREATHING-CYCLE AUDIT
| Surface | First Timestamp | Latest Timestamp | Refresh Interval / Gap | Heartbeat Continued? | Status |
|---|---|---|---|---:|---|
| HeartbeatTelemetry | 2026.05.03 22:31:47 | 2026.05.03 23:11:50 | observed from file content only | n/a | alive log |
| FunctionResults | 2026.05.03 22:31:46 | 2026.05.03 23:11:50 | observed from file content only | n/a | alive log |
| Scanner Status | 2026.05.03 22:31:46 | 2026.05.03 22:39:25 | observed from file content only | yes | stale vs logs |
| Market Board | 2026.03.17 14:02:51 | 2026.05.03 22:34:24 | observed from file content only | yes | stale vs logs |
| Manifest | 2026.05.03 22:31:46 | 2026.05.04 00:34:24 | observed from file content only | n/a | stale vs logs |
| Open Symbol Snapshot | 2026.05.03 22:34:27 | 2026.05.03 22:34:39 | observed from file content only | yes | stale vs logs |
| Dossiers/GlobalTop10 | staging files observed around export; no final | final absent | no current final refresh | yes | final promotion failure |
| Dossiers/Top5PerBucket | partial final | partial final | family_manifest next_due 22:41:50; final incomplete | yes | partial/stale |
| SDP/GlobalTop10 | folder absent | folder absent | no current final refresh | yes | absent |
| SDP/Top5PerBucket | final files exist | final files exist | not aligned to Main | yes | split-brain |
| Archive history | present under Top5 routes | present | currentness non-authoritative by path/labels | unknown | non-current but budget risk unresolved |
| Previous cache | absent | absent | not observed | unknown | missing evidence |

Classification: publication starvation / route promotion failure / Main-Lite split-lane failure under a failed identity gate. Not full EA death because FunctionResults and heartbeat telemetry continue after current artifact timestamps stop.

# SECTION 8 — MAIN / LITE CONTRACT AUDIT
| Contract Item | Main Dossier Expected | Lite SDP Expected | Observed Main | Observed Lite | Match? | Failure Owner | Roadmap Fix Class |
|---|---|---|---|---|---:|---|---|
| GlobalTop10 folder exists | yes or blocker | yes or same blocker | final folder exists but contains 0 final files; staging=4 | SDP/GlobalTop10 folder absent | no | Dispatcher/Dossier writer/SDP mirror | identity first, then route isolation |
| GlobalTop10 final count | 10 or blocker | 10 or same blocker | 0 final; staging 4 | absent | no | promotion + mirror dependency | route repair after identity |
| GlobalTop10 symbol set | committed snapshot | same committed snapshot | Market Board has 10 rows: EURUSD, UKOIL.c, XAUAUD, AUDCHF, XNGUSD, XPDUSD, JPCJPY.c, DJCUSD.c, AAVEUSD.nx, ALGOUSD.nx; Dossier final 0 | SDP absent | no | committed snapshot vs final publish | contract + route test |
| GlobalTop10 rank/order | source-owned | same source-owned | visible only on Market Board | absent | no | L4/Dispatcher publication bridge | do not alter L4 ranking |
| Top5 crypto | same bucket source | same bucket source | 3: AAVEUSD.nx, ALGOUSD.nx, ATOMUSD.nx | 5: AAVEUSD.nx, ADAUSD.nx, ALGOUSD.nx, APEUSD.nx, ATOMUSD.nx | no | Dossier/SDP route contract | Main→Lite mirror enforcement |
| Top5 energy | same bucket source | same bucket source | 1: USOIL.c | 3: UKOIL.c, USOIL.c, XNGUSD | no | Dossier/SDP route contract | Main→Lite mirror enforcement |
| Top5 fx | same bucket source | same bucket source | 2: EURUSD, GBPUSD | 3: EURUSD, GBPUSD, USDJPY | no | Dossier/SDP route contract | Main→Lite mirror enforcement |
| Top5 indices | same bucket source | same bucket source | 0: none | 5: DJCUSD.c, JPCJPY.c, NACUSD.c, RUSS2000.c, SPCUSD.c | no | Dossier/SDP route contract | Main→Lite mirror enforcement |
| Top5 metals | same bucket source | same bucket source | 0: none | 0: none | yes | Dossier/SDP route contract | Main→Lite mirror enforcement |
| Top5 stocks | same bucket source | same bucket source | 0: none | 0: none | yes | Dossier/SDP route contract | Main→Lite mirror enforcement |
| source_snapshot_id | same | same | present in some manifests/rows but not reconciled across final children | present in Lite files but not reconciled | no | contracts/provenance | require snapshot parity check |
| publication_epoch | same or lawful mirrored child epoch | same | missing/incomplete for missing routes | missing/incomplete | no | writer/provenance | add route epoch test |
| blocker reason | same root blocker if blocked | same root blocker | partial/degraded queue status | absent/not_due/dependency statements | no | manifest/status writer | one blocker owner per route |
| archive/current truth labels | not current truth | not current truth | labels present in several files | labels present in several files | partial | artifact text helpers / writers | verify consumers ignore archive/cache |

# SECTION 9 — PUBLICATION LANE / OWNER AUDIT
| Lane | Source Owner | Inputs | Outputs | Budget / Trigger | Failure Mode | Evidence |
|---|---|---|---|---|---|---|
| Market Board | ASC_MarketBoardWriter + Dispatcher | committed L4/GlobalTop10 rows | Market Board.txt | publish cadence/status writer | stale vs logs | Generated 22:34:24; log continues to 22:51 |
| Scanner Status | ASC_ScannerStatusWriter + Dispatcher | runtime state/proof fields | Scanner Status.txt | status cadence/keepalive | stale vs logs | Updated 22:34:41; source_run_id RUN249R |
| Manifest | ASC_WriteArtifactBundleManifest | artifact route states | Artifact Bundle Manifest.txt | manifest write route | stale/intermittent writes | FunctionResults has only 7 manifest writes |
| Open Symbol Snapshot | ASC_OpenSymbolSnapshotEngine + writer | open symbol/tick data | Open Symbol Snapshot.txt | L2/OSS cadence | stale relative logs | file around 22:34; logs to 22:51 |
| Dossier GlobalTop10 | ASC_Dispatcher + ASC_DossierWriter | top10 completed/current snapshot | Dossiers/GlobalTop10/*.txt | batch/stage/promote | staging present, final absent | 4 staging files; 0 final |
| SDP GlobalTop10 | ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication + SDP Writer | completed globaltop10 snapshot / promoted Dossier dependency | Symbol Data Packs/GlobalTop10/*.txt | not_due / dependency / budget | folder absent | Manifest says globaltop10_not_due/dependency; folder absent |
| Dossier Top5PerBucket | ASC_DossierWriter + Dispatcher | top5 bucket queue | Dossiers/Top5PerBucket/<bucket> | queue/stage/promote | partial family | family_manifest target 16, written 11, active final incomplete |
| SDP Top5PerBucket | ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication + SDP Writer | top5 queue/snapshot | Symbol Data Packs/Top5PerBucket/<bucket> | mirror route | Lite not slaved to Main final | Lite has 16 files; Main final visible subset differs |
| Archive history | Dossier/SDP archive route owners | previous current children | archive folders | post-promote history | may consume budget/ambiguous truth | archive present; not current labels found |
| Previous cache | SDP continuity owner | last-good/cache state | _previous_state_cache | continuity route | not observed | folder missing in export |
| Deep trigger | Dispatcher + ASC_DeepSelectiveAnalysisEngine | deep selective analysis | deep payload/trigger telemetry | timer/persistence lane | dominates heartbeat cost | deep_analysis_trigger_ms max 8866 |
| Presence sweep | Dispatcher side duties | route presence checks | telemetry/status | bounded side duty | not primary observed | presence_sweep_ms max 0 |

# SECTION 10 — HEARTBEAT / TIMER STARVATION AUDIT
| Metric | Observed | Prior Bad Class | Owner / Lane | Meaning | Roadmap Implication |
|---|---:|---:|---|---|---|
| heartbeat elapsed | max=8866.0; last=5660.0; >880=237; >2000=180; >5000=176 | bad if >880 budget, critical if >5000 | Dispatcher/persistence/deep lanes | Timer budget is repeatedly exceeded | Restore cheap publish/status breathing before heavy route repairs |
| deep trigger | max=8866.0; last=5660.0; >880=211; >2000=179; >5000=176 | bad if >880 budget, critical if >5000 | Dispatcher/persistence/deep lanes | Timer budget is repeatedly exceeded | Restore cheap publish/status breathing before heavy route repairs |
| top5 deep child payload | max=1263.0; last=0.0; >880=6; >2000=0; >5000=0 | bad if >880 budget, critical if >5000 | Dispatcher/persistence/deep lanes | Timer budget is repeatedly exceeded | Restore cheap publish/status breathing before heavy route repairs |
| deferred remaining | max=1036.0; last=4.0; >880=51; >2000=0; >5000=0 | bad if >880 budget, critical if >5000 | Dispatcher/persistence/deep lanes | Timer budget is repeatedly exceeded | Restore cheap publish/status breathing before heavy route repairs |
| skipped due budget | max=1036.0; last=4.0; >880=51; >2000=0; >5000=0 | bad if >880 budget, critical if >5000 | Dispatcher/persistence/deep lanes | Timer budget is repeatedly exceeded | Restore cheap publish/status breathing before heavy route repairs |
| globaltop10 child work | max=10.0; last=4.0; >880=0; >2000=0; >5000=0 | bad if >880 budget, critical if >5000 | Dispatcher/persistence/deep lanes | Timer budget is repeatedly exceeded | Restore cheap publish/status breathing before heavy route repairs |
| dossier writes | max=2.0; last=0.0; >880=0; >2000=0; >5000=0 | bad if >880 budget, critical if >5000 | Dispatcher/persistence/deep lanes | Timer budget is repeatedly exceeded | Restore cheap publish/status breathing before heavy route repairs |
| budget_state | budget_pressure 237 / within_budget 13 | high | Dispatcher | most beats exceed budget | no semantic/HUD work before budget fix |
| active lane mix | persistence 243 / scan 7 | skewed | Dispatcher lane scheduler | persistence dominates after warmup | isolate publish/deep duties |
| publication skipped count | not fully exposed as standalone stable field | unknown | publication lanes | observability gap | add explicit skipped counts per artifact family |

Heartbeat classification: heavy deep work blocking/polluting status publication, with persistent publication starvation. Not healthy. Not merely a warmup spike. No reliable RUN252 inference until identity is fixed.

# SECTION 11 — FILE I/O / PROMOTION AUDIT
| Operation | Expected Proof | Observed Proof | Gap | Risk | Roadmap Fix |
|---|---|---|---|---|---|
| FileOpen/write staging | path + handle result + error on failure | ASC_FileIO has ASC_WriteTextFile temp write; runtime lacks per-route open proof for failed GlobalTop10 | FileOpen failure not visible in final route evidence | silent staging/final failure | add route-level operation proof before route patch |
| FileClose finalizes write | close/flush implied or logged | FileFlush/FileClose present in source | return/result not individually logged | write may be assumed successful | log temp write state and readback result |
| FileMove promotion | source + dest + FILE_REWRITE + bool + error | ASC_WritePublicationPayloadAtomic captures promote_error and reason | missing route-level evidence for absent GlobalTop10 final | staging mistaken as current or final failure unexplained | instrument promotion outcomes per family/child |
| FileDelete cleanup | target + bool + error | source uses FileDelete in cleanup and SDP writer captures delete_error in one area | not consistently visible in runtime evidence | cleanup may silently fail or delete wrong target | no destructive cleanup; add delete proof only where needed |
| archive move/copy | source + archive target + bool/error | archive folders present | cannot prove nonblocking or failure outcome | archive/history may consume timer or be read as current | archive must be after current publish and nonblocking |
| final folder listing | current evidence snapshot | manual folder listing shows final missing/mismatch | no route-owned listing file for all families | report may infer from partial export | create bounded route inventory in next evidence package |
| staging folder listing | current evidence snapshot | Dossier GlobalTop10 staging has 4 files | no staging manifest found for GlobalTop10 final resolution | staging could be mistaken as final | staging never current truth |
| folder creation | explicit or FileOpen-created | source ensures directory tree in FileIO | runtime folder absence for SDP/GlobalTop10 not explained | missing folder may mean writer never ran or path wrong | route writer must emit target path and folder ensure result |

# SECTION 12 — DATA CONTRACT / ARTIFACT SLA AUDIT
| Artifact Family | Producer | Consumer | Current Truth? | Required Refresh SLA | Required Count | Required Fields | Failure State | Blocker Owner |
|---|---|---|---:|---|---:|---|---|---|
| Scanner Status | ASC_ScannerStatusWriter | operator/report | yes | cheap keepalive; prove timestamp progresses during run | 1 | source_run_id, publication_utc, state, blockers, heartbeat summary | stale status with logs alive | Dispatcher/status writer |
| Market Board | ASC_MarketBoardWriter | Siam/user | yes | operator surface must refresh while heartbeat alive | 1 | source_run_id, generated_at, route rows, no-signal boundary | stale board/degraded board | Dispatcher/board writer |
| Manifest | ASC_WriteArtifactBundleManifest | report/integrity | yes | must update after material artifact route changes | 1 | family state, counts, blockers, paths, proof bundle | dependency missing/stale | Dispatcher manifest owner |
| Open Symbol Snapshot | ASC_OpenSymbolSnapshotEngine | downstream scanner | yes | snapshot SLA aligned to L2 refresh | open symbols | source_run_id, snapshot id, freshness | stale/missing | OSS engine |
| Dossiers/GlobalTop10 | Dossier writer/Dispatcher | canonical Main | yes | 10 or blocker | 10 | source_snapshot_id, rank, route_family, final/current state | final missing/staging only | Dossier route owner |
| SDP/GlobalTop10 | SDP writer/Dispatcher | Lite/Siam | mirror | same as Main | 10 | same snapshot, mirror marker, blocker parity | folder absent | SDP mirror owner |
| Dossiers/Top5PerBucket | Dossier writer | canonical Main | yes | per bucket | 0-5 | bucket, rank, snapshot, blocker | partial final | Dossier Top5 route |
| SDP/Top5PerBucket | SDP writer | Lite/Siam | mirror | same as Main | 0-5 | mirror of Main + allowed depth delta | split-brain | SDP Top5 mirror |
| Archive timestamped history | writers | history only | no | nonblocking after current write | n/a | not_current_truth, archive epoch | ambiguous/current confusion | archive owner |
| Previous cache | SDP continuity | continuity only | no | replacement only | n/a | not_current_truth, source final | missing | SDP continuity owner |

# SECTION 13 — PROVENANCE / LINEAGE AUDIT
| Artifact | source_run_id | build/version | route_family | source_snapshot_id | publication_epoch | producer | current/final/staging/archive/cache | PASS/HOLD/FAIL |
|---|---|---|---|---|---|---|---|---|
| Scanner Status | RUN249R | RUN249R-CompileRepairBeforeSiamSemantics | scanner_status | present in text fragments | 2026.05.03 22:34:41 | ASC_ScannerStatusWriter/Dispatcher | current | FAIL vs source RUN252R |
| Market Board | RUN249R | RUN249R-CompileRepairBeforeSiamSemantics | globaltop10 surface rows | l4_rev_68_pass_1777847658_commit_1777847658 | 2026.05.03 22:34:24 | ASC_MarketBoardWriter | current/degraded | FAIL vs source RUN252R |
| Manifest | RUN249R observed in text | RUN249 family | artifact bundle | mixed/partial | around 22:34:40 | ASC_WriteArtifactBundleManifest | current manifest | FAIL vs source RUN252R |
| FunctionResults | not every row has source_run_id; runtime rows RUN249 context | RUN249 runtime context | logs | n/a | 22:31:46 to 22:51:57 | ASC_FunctionResults | runtime log | HOLD identity |
| HeartbeatTelemetry | RUN249 context by package surfaces | RUN249 runtime context | heartbeat | n/a | 22:31:47 to 22:51:50 | ASC_Dispatcher | runtime log | HOLD identity |
| Dossiers/GlobalTop10 final | missing | missing | globaltop10 | missing | missing | Dossier writer | final/current absent | FAIL |
| Dossiers/GlobalTop10 staging | RUN249 context in files | RUN249 | globaltop10 | likely same snapshot but not reconciled | staging only | Dossier writer | staging | HOLD non-current |
| SDP/GlobalTop10 | missing | missing | globaltop10_mirror | missing | missing | SDP writer | final absent | FAIL |
| Top5PerBucket Dossiers | RUN249 context | RUN249 | top5_per_bucket | l4_rev=11... in manifest | partial | Dossier writer | current partial | FAIL parity |
| Top5PerBucket SDP | RUN249 context | RUN249 | top5perbucket_mirror | present but not reconciled | present | SDP writer | current Lite | FAIL parity |

# SECTION 14 — REPORT / PROMPT / BRAIN IMPROVEMENT AUDIT
| Prompt/Brain Area | Current Weakness | Evidence | Improvement Needed | Durable Rule | Falsifier |
|---|---|---|---|---|---|
| Research conversion | Research can be ornamental if not tied to owners/tests | Prior reports have research but runtime still split | Research ledger must name file owner, acceptance test, telemetry, falsifier | No URL + no converted constraint + no falsifier = rejected | research paragraph has no test |
| Prompt clarity | Large prompts can bury earliest gate | RUN254 needed identity gate despite many route patches | Mode lock + first broken gate + forbidden scopes at top | Earliest broken gate outranks desired feature | prompt asks route patch before identity proof |
| Evidence ladder | Compile/live claims can be overstated | RUN252 report says compile outstanding; user says compile happened but transcript missing | Require evidence class beside each proof claim | Class 2 compile claim cannot become Class 4 | compile clean claimed without transcript |
| Main/Lite contract | Lite can become separate architecture | Lite has buckets/files Main lacks | Main→Lite contract table before any Lite patch | Lite is mirror/slave only; payload depth may differ | Lite count/symbol differs from Main |
| Refresh SLA | One-shot publication mistaken for breathing | surfaces at 22:34, logs to 22:51 | SLA table per artifact family | No breathing claim without repeated timestamp movement | heartbeat alive but status stale |
| File I/O proof | Staging/final failure lacks operation proof | GlobalTop10 staging 4, final 0 | FileOpen/FileMove/FileDelete proof table before FileIO-adjacent patch | No final file, no success claim | final absent after claimed publish |
| Timer/heartbeat proof | Deep work can starve status | max heartbeat 8866, deep trigger same | heartbeat table with lane cost and deferred counts | cheap status before deep lanes | deep > budget and status stale |
| Roadmap sequencing | Patch stacking skipped identity proof | RUN249 runtime vs RUN252 source | Phase 0 identity before route/parity | No phase depends on unproven runtime recovery | RUN252 fields expected in RUN249 output |
| Two-Brain Check | Builder can overfit to obvious route bug | identity contradiction found | Builder/Auditor synthesis required | Auditor vetoes unproven owner | roadmap patches GlobalTop10 before deploy proof |
| No-ornament rule | Doctrine grows without changing tests | multiple long reports; system still breaks | Delete/merge/convert doctrine to test | Every retained rule must prevent a failure | rule cannot be tied to failure/test |
| Package law | zip naming drift/report-only suffix risk | user explicitly forbids suffixes | exact zip name only; overwrite existing | TRUTH_SEEKER_RUNxxxR.zip exact | suffix exists |
| No-trade boundary | Ranking can be misread as signal | outputs include review-only language | Keep no-signal token in every operator surface | No trade/signal permission in repair prompts | buy/sell/entry permission appears |

# SECTION 15 — TWO-BRAIN CHECK
## Brain 1 — Builder
- Actually broken: deployment/source identity first, then publication breathing, then GlobalTop10/Top5 route promotion, then Main/Lite mirror contract.
- Smallest repair sequence: prove deployed EX5/output root identity; run bounded breathing proof; patch cheap status/manifest refresh if stale under correct identity; isolate GlobalTop10 final promotion; then enforce Main→Lite parity.
- Probable source owners: `ASC_Dispatcher.mqh` for scheduler, keepalive, GlobalTop10 and SDP service calls; `ASC_MarketBoardWriter.mqh` and `ASC_ScannerStatusWriter.mqh` for status surfaces; `ASC_FileIO.mqh` for atomic promotion proof; `ASC_SymbolDataPackWriter/Composer/Routing/Contracts` for Lite mirror; `ASC_DossierWriter.mqh` for Main Dossier publication.
- Before Main/Lite parity: identity and breathing must be proven. Before Siam/data-quality improvements: route publication and parity must breathe.
- Next patch/run should be RUN255R identity/deploy proof repair, not a feature patch.

## Brain 2 — Auditor
- Wrong-owner risk: runtime evidence is RUN249R; patching RUN252 Dispatcher based on RUN249 runtime could chase ghosts.
- Hidden deployment failure: lack of MetaEditor transcript, Experts source identity, and terminal data path can make stale output look like a code defect.
- Lite secret truth risk: Lite currently has more Top5 symbols than Main in several buckets; if accepted, Lite becomes a second truth architecture.
- False heartbeat improvement risk: outputs can stop publishing and heartbeat can look “stable” because work is skipped; refresh SLA must be checked.
- Archive/cache truth risk: archive/staging paths can be mistaken as current when finals are absent.
- FileIO mutation risk: rewriting FileIO now can break routes that already write; instrument and isolate before changing it.
- L3/L4 regression risk: visible Market Board Top10 proves upstream ranking produced rows; do not mutate ranking/formulas to fix publication.
- Fake proof risk: RUN252 fields cannot be verified from RUN249 outputs.

## Merged safest roadmap
Pause downstream patching. First repair proof-of-identity and output-root alignment. Then retest breathing. Only then isolate route/promotion and parity. The lattice stitch is source package ↔ compiled EX5 ↔ active terminal ↔ output root ↔ artifact lineage. Right now that stitch is broken.

# SECTION 16 — CONTRADICTION LEDGER
| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Roadmap Impact | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|---|
| Source baseline is RUN252R | Runtime artifacts say RUN249R | ASC_Version.mqh | Scanner Status / Market Board / Manifest | 3 | 7 for observed runtime | Both true in own domains; runtime outranks for live behavior, source outranks package content | Prove compile/deploy/output root identity | Phase 0 first | yes |
| Compile clean claim exists via user context | Compile output missing | User statement | No MetaEditor transcript in package | 2 | unavailable | No Class 4 proof | Supply compile transcript or rerun compile | Do not claim compile proof | yes |
| Heartbeat alive | Artifacts stale | heartbeat/function logs | artifact timestamps/folders | 7 | 7 | Both: not full EA death; publication starvation | Breathing-cycle repair after identity | yes |
| Main Dossier missing/partial | Lite SDP present/more complete | folder listing | folder listing | 7 | 7 | Both: split-brain | Contract-first parity after identity | Phase 3 | yes |
| Market Board Top10 visible | GlobalTop10 final absent | Market Board matrix rows | Dossiers/GlobalTop10 final folder | 7 | 7 | Both: board visibility does not prove final route | Isolate publication lane | Phase 2 | yes |
| Staging exists | Final absent | Dossiers/GlobalTop10/_staging | Dossiers/GlobalTop10 final | 7 | 7 | Final current proof outranks staging | Promotion proof required | Phase 2 | yes |
| Archive exists | Archive is not current truth | archive folders | not_current labels/path law | 7 | 3/7 | Final current files outrank archive | Verify consumers ignore archive/cache | Phase 5 | maybe |
| RUN252 fields in source | generated output from RUN249 | source files | runtime source_run_id | 3 | 7 | Runtime identity blocks RUN252 semantic proof | Align source then regenerate | Phase 7 later | yes |
| Report/roadmap claims route recovery expected | folder evidence shows route failure | reports/source plans | runtime folder listing | 3 | 7 | Runtime evidence outranks roadmap prose | Do not patch from roadmap alone | Phase 0/1 | yes |
| No refresh | Some logs continue | user claim/runtime perception | FunctionResults/heartbeat | 2 | 7 | Logs prove EA/logging alive; not full refresh | Classify as publication starvation | Phase 1 | yes |
| No signal boundary | Ranking rows show candidates | Market Board rows | No-trade/review-only tokens | 7 | 7 | No-trade tokens + scope outrank user interpretation | Keep boundary | Always | no |

# SECTION 17 — ROADMAP DESIGN OUTPUT
| Phase | Purpose | Failure Class Addressed | Source Owners | Allowed Scope | Forbidden Scope | Acceptance Test | Required Evidence | Decision After Phase |
|---|---|---|---|---|---|---|---|---|
| Phase 0 | Evidence / identity correction | source/runtime identity drift | ASC_Version, compile/deploy process, terminal output root | prove compiled EX5, source_run_id, Experts identity, terminal Files path | route logic, FileIO rewrite, generated cleanup | source RUN ID equals runtime artifact RUN ID in fresh outputs | MetaEditor transcript, Experts/Journal identity line, fresh Scanner/Board/Manifest with RUN255/active ID | HOLD if mismatch; TEST FIRST if aligned |
| Phase 1 | Breathing cycle restoration | stale current surfaces while logs continue | Dispatcher, ScannerStatusWriter, MarketBoardWriter, Manifest, OSS | cheap keepalive/status/manifest refresh only | GlobalTop10 heavy repair, Lite parity, Siam polish | Scanner Status/Market Board/Manifest/OSS timestamps progress during >15min run while heartbeat logs continue | fresh runtime files + heartbeat + FunctionResults | TEST FIRST |
| Phase 2 | Publication lane isolation | GlobalTop10 final route missing | Dispatcher, DossierWriter, FileIO proof points | trace admission, staging, validation, FileMove promotion, blockers | L3/L4 ranking/formula changes, FileIO rewrite | GlobalTop10 final has 10 or explicit blocker with error owner | folder listing + route telemetry + operation proof | TEST FIRST |
| Phase 3 | Main/Lite contract enforcement | Lite split-brain | Dossier contracts, SDP contracts/routing/writer | contract test and mirror only after Main truth | Lite independent membership/rank/path behavior | Lite symbols/counts/ranks match Main or same blocker | Main/Lite parity report per route | TEST FIRST |
| Phase 4 | Top5PerBucket parity | bucket mismatch | Dossier Top5 route, SDP Top5 mirror | bucket-by-bucket parity and lawful absence states | GlobalTop10 route changes, L4 formula edits | each bucket Main/Lite match or shared blocker | bucket manifests + folder listings | TEST FIRST |
| Phase 5 | Archive/cache nonblocking integrity | archive/history/cache ambiguity | Dossier/SDP archive/cache owners | label non-current; bound archive work; verify consumers ignore it | deleting live evidence, using archive as current | archive never becomes membership/current source | archive/cache labels + consumer proof | TEST FIRST |
| Phase 6 | Heartbeat/deep-lane budget hardening | timer starvation | Dispatcher, DeepSelectiveAnalysisEngine, side duties | defer/preflight deep trigger; cap side lanes; explicit backoff | semantic/UI/HUD changes | heartbeat max under budget except known bounded spikes; status still refreshes | heartbeat telemetry with lane costs | TEST FIRST |
| Phase 7 | Siam readability/data-purity verification | RUN252 fields not proven live | SDP Composer/Writer, MarketBoard, ScannerStatus | verify fields in fresh aligned output | route/heartbeat/FileIO changes | section_coherence/session_scope/duplicate_route/no-sample fields appear under aligned source_run_id | fresh generated artifacts | TEST FIRST |
| Phase 8 | Roadmap/control/brain guidebook hardening | prompt/brain recurrence | guidebooks, run template, office files | apply durable rules discovered here | ornamental doctrine, code patch | guidebooks contain identity gate, contract, SLA, FileIO proof, heartbeat table rules | source diff + report | PROCEED to live retest |
| Phase 9 | Bounded live retest | prove repairs | no code owners; runtime evidence only | fresh live run + package evidence | trade/signal permission | breathing cycle, routes, parity, lineage pass under observed window | compile + logs + generated files + folder listings | TEST FIRST / HOLD based on proof |

# SECTION 18 — NEXT RUN RECOMMENDATION
| Candidate Next Run | Purpose | Why This First? | Why Not Others? | Evidence Needed | Decision |
|---|---|---|---|---|---|
| RUN255R identity/deploy proof repair | prove source package -> compiled EX5 -> active terminal -> output root -> generated source_run_id | Earliest broken gate; current runtime says RUN249R while source says RUN252R | All route/parity patches can patch wrong owner until identity is proven | MetaEditor compile transcript, Experts identity, terminal Files path, fresh Scanner/Board/Manifest source_run_id | RECOMMENDED |
| RUN255R refresh breathing-cycle patch | restore cheap status/board/manifest/OSS refresh | Needed after identity if stale persists | Unsafe before proving active source/output root | aligned heartbeat + stale surface proof | DEFER UNTIL IDENTITY |
| RUN255R Main/Lite contract patch | make Lite mirror Main exactly | Needed after Main routes breathe | Unsafe while Main final routes absent and identity failed | Main final route proof + contract table | DEFER |
| RUN255R GlobalTop10 route repair | fix final route promotion/mirror | GlobalTop10 is broken in supplied evidence | Unsafe before identity and core breathing proof | aligned route telemetry + staging/final FileMove proof | DEFER |
| RUN255R heartbeat budget repair | bound deep trigger / timer cost | Heartbeat starvation is real | May mask stale deployment; should follow or combine only with identity proof, not route logic | aligned heartbeat telemetry | DEFER AFTER IDENTITY |
| HOLD / request evidence | pause all code patching | identity contradictory and compile proof missing | not a dead end; exact proof run exists | compile + identity + terminal path evidence | ACTIVE DECISION: HOLD |

# SECTION 19 — PROTECTED LATTICE / BOUNDARY CONTRACTS
| Stitch | Boundary | Allowed Data / Proof Crossing | Forbidden Leak | Detection | Kill / Rollback Condition |
|---|---|---|---|---|---|
| Source package ↔ compiled EX5 | compile/deploy identity | ASC_Version run ID, compile transcript, Experts identity | runtime proof from stale EX5 | source_run_id mismatch | HOLD; redeploy/recompile proof only |
| Active terminal ↔ exported evidence | terminal Files path | path note, folder listing, fresh timestamps | old export root used as current | terminal path mismatch/multiple roots | HOLD; correct export root |
| Heartbeat/logs ↔ artifact freshness | breathing cycle | timestamps, heartbeat IDs, write counts | logging alive treated as artifact alive | logs continue after artifact stale | Phase 1 repair before routes |
| Main Dossier ↔ Lite SDP | mirror contract | same snapshot, route, symbols, rank, blocker | Lite independent membership/rank | Lite count/symbol differs from Main | stop Lite patch; enforce contract |
| Staging/archive/cache ↔ current truth | lineage/currentness | non-current labels, state, epoch | archive/staging as membership source | consumer reads non-current path | KILL design if generated output becomes source truth |
| Research ↔ code | converted constraint | owner/test/falsifier | ornamental source citation | no acceptance test | reject research item |
| HUD ↔ upstream truth | consumer-only | display current upstream fields | HUD computes/writes final truth | HUD owns shortlist/current focus | KILL HUD-as-brain drift |

# SECTION 20 — PACKAGE VALIDATION TABLE
| Package Rule | Result |
|---|---|
| Exact package name | TRUTH_SEEKER_RUN254R.zip |
| Existing same-name package overwritten/deleted first | yes in packaging script |
| No suffix/copy/final/fixed naming | yes |
| Original folder layout preserved | yes |
| RUN254R_REPORT.md included | yes |
| Selected unchanged live evidence included | yes |
| Compile output included if supplied | not supplied |
| Experts/Journal logs included if supplied | not supplied |
| Generated evidence mutated | no |
| Source/control files patched | no |
| Whole repo dump excluded | yes |
| Unrelated terminal junk excluded | yes |

# SECTION 21 — FINAL DECISION
HOLD

Reason: the audit produced a ranked roadmap, but source/runtime identity is contradictory and MetaEditor compile proof is missing. The next move is not a route patch. It is RUN255R identity/deploy proof repair. Once the terminal proves it is running the intended source and writing to the inspected output root, the roadmap can safely move into breathing-cycle repair and then route/parity work.