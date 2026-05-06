# TRUTH SEEKER RUN125R LIVE PROOF / TOP5 PARITY REPAIR REPORT

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN125R / EXTREME LIVE PROOF AFTER COMPILE SUCCESS — AUDIT FRESH RUNTIME OUTPUT FOR CLAIM EVIDENCE, TOP5 LIFECYCLE, ROOT DOSSIER REDUCTION, MARKET BOARD TRADER-CHAT PACKET, SELECTED/CURRENT DATA, CADENCE, PERFORMANCE, AND BUGS

Decision: HOLD_REPAIR_REQUIRED. Live output proves RUN124B compile/runtime practical operation, but Top5PerBucket produced half-truth artifacts relative to GlobalTop10. Source patch landed; post-patch compile/live proof remains required.

## 2. OPERATOR SNAPSHOT

| Item | Status |
|---|---|
| compile/run status | runtime_output_exists_compile_practically_proven from fresh Upcomers-Server output |
| runtime zip inspected | yes |
| RUN124B compile blockers repaired | yes by source inspection: version macros in ASC_Version, constants not duplicated, ASC_RC_INVALID_STATE present |
| Claim Evidence visible | yes on Scanner Status / Market Board / Artifact Manifest surfaces |
| Dossier section evidence visible | yes on inspected child dossiers |
| Market Board trader-chat packet visible | yes |
| Market Board-to-Dossier lookup proof | yes but Top5 depth parity broken pre-patch |
| family Dossier availability proof | yes, Top5 manifest child count 28/28 and GlobalTop10 manifest present |
| Top5 lifecycle proof | partial: active family promoted, but rank4/5 permanent deep-pending and 3 crypto quote unavailable exposed defect |
| root Dossier reduction proof | yes: only Dossiers/ETHUSD.txt and Dossiers/GECEUR.txt root ordinary files in runtime zip; no broad all-symbol root spam observed |
| selected/current proof | no selected/current Current Focus file in runtime package; manifest says no selected symbol active |
| Current Focus proof | unavailable / not applicable in this runtime output |
| cadence proof | current live still RUN124B 20-minute Top5 cadence; patched to 600 seconds for next live |
| performance acceptable | bounded concern: 20MB function_results log, 2.1MB heartbeat telemetry, repeated manifest writes |
| source patched | yes |
| final status | HOLD_REPAIR_REQUIRED |
| next run | RUN126R live proof after patch |
| protected areas not touched | FileIO, HUD, rank formulas, L3/L4 formulas, Market Board ordering, strategy/execution, heartbeat cadence, lane law |

## 3. INPUT ZIP / LIVE OUTPUT INTAKE SUMMARY

| Input | Root | Files | Finding |
|---|---|---:|---|
| Aurora Sentinel Core(388).zip | Aurora Sentinel Core | 317 | source package inspected and patched |
| Upcomers-Server(115).zip | Upcomers-Server | 127 | fresh runtime output inspected recursively |
| nested Upcomers root | none found | 0 | no nested Upcomers-Server/Upcomers-Server path found |

## 4. COMPILE / RUNTIME REALITY

| Proof Item | Evidence | Status | Action |
|---|---|---|---|
| runtime output exists | Scanner Status 84,268 bytes, Market Board 514,770 bytes, logs updated 2026-04-29 06:06 UTC | runtime_output_exists_compile_practically_proven | no compile-repair prompt generated |
| runtime boot observed | active artifacts show Source Run ID RUN124B and promoted outputs | runtime_boot_observed | continue live audit |
| compile transcript | not provided | unknown_requires_operator_review | not requested because runtime output exists |
| compile errors | operator reported none | no compile_failed_operator_errors | patch live source gap only |

## 5. ROADMAP AUTHORITY CHECK

RUN124B is treated as compile repair baseline. RUN124R/RUN123R are treated as Claim Evidence and readiness baselines. Fresh runtime output outranked report claims. The operator's reported live defect in Top5PerBucket became the primary RUN125R target.

## 6. EXTERNAL AUTHORITY RESEARCH CONVERSION TABLE

| Research Area | Source Type | Source | Finding | Converted Constraint | Patch / Audit Impact |
|---|---|---|---|---|---|
| Timer cadence/performance | Official MQL5 docs | EventSetTimer / program running event queue | Timer events do not stack and event handlers are processed sequentially | Avoid long write lanes and repeated artifact churn inside timer pressure | Top5 10-minute cadence patch kept heartbeat unchanged and reused existing deep owner queue rather than increasing timer frequency |
| File churn | Official MQL5 docs | FileFlush | Frequent flushing can affect operation speed | Audit proof/log/file churn before adding more proof spam | Did not add broad FileIO writes; marked manifest/log churn as carry-forward |
| Quote currentness | Official MQL5 docs | SymbolInfoTick | Tick structure contains price and last tick time when successful | Bid/Ask currentness must map to runtime quote/tick surfaces, not file size alone | Separated crypto unavailable quote defect from rank4/5 small-file/deep-pending defect |

## 7. RUN124B COMPILE REPAIR VALIDATION

| RUN124B Repair Item | Source Evidence | Runtime / Compile Evidence | Verdict |
|---|---|---|---|
| duplicate RUN113/RUN114/RUN116 macros removed from constants | ASC_Constants.mqh no current run identity duplicate found | runtime output written by RUN124B | pass |
| ASC_Version remains run identity owner | ASC_Version.mqh contains RUN125R current run after patch | n/a post-patch | pass |
| ASC_RC_INVALID_STATE typed | ASC_ResultCodes.mqh has ASC_RC_INVALID_STATE = 1003 | no runtime compile failure reported | pass |
| dispatcher result-code callsites | no live compile failure; source inspected | runtime output exists | pass |
| Claim Evidence helper compile issue | Claim Evidence appears in output | runtime output exists | pass |

## 8. LIVE OUTPUT PACKAGE INVENTORY

| Artifact / Log | Actual Path | Size | Modified Time | Source Token | Currentness | Verdict |
|---|---|---:|---|---|---|---|
| Scanner Status.txt | Scanner Status.txt | 84268 | 2026-04-29 06:05:51 UTC | RUN124B | current/promoted or log | found |
| Artifact Bundle Manifest.txt | Artifact Bundle Manifest.txt | 156494 | 2026-04-29 06:05:30 UTC | RUN124B | current/promoted or log | found |
| Market Board.txt | Market Board.txt | 514770 | 2026-04-29 06:05:29 UTC | RUN124B | current/promoted or log | found |
| Workbench/logs/function_results.log | Workbench/logs/function_results.log | 20151728 | 2026-04-29 06:06:00 UTC | RUN124B | current/promoted or log | found |
| Workbench/logs/heartbeat_telemetry.log | Workbench/logs/heartbeat_telemetry.log | 2197812 | 2026-04-29 06:05:59 UTC | RUN124B | current/promoted or log | found |
| Dossiers/Top5PerBucket/_family_manifest.txt | Dossiers/Top5PerBucket/_family_manifest.txt | 13076 | 2026-04-29 06:03:27 UTC | RUN124B | current/promoted or log | found |
| Dossiers/Top5PerBucket/_staging/_staging_manifest.txt | Dossiers/Top5PerBucket/_staging/_staging_manifest.txt | 1412 | 2026-04-29 06:03:28 UTC | RUN124B | current/promoted or log | found |
| Dossiers/GlobalTop10/_family_manifest.txt | Dossiers/GlobalTop10/_family_manifest.txt | 13242 | 2026-04-29 06:00:47 UTC | RUN124B | current/promoted or log | found |
| Open Symbol Snapshot.txt | Open Symbol Snapshot.txt | 25408 | 2026-04-29 06:05:28 UTC | unknown | current/promoted or log | found |
| Current Focus.txt | missing | 0 | missing | n/a | missing | missing |
| Dossier.txt | missing | 0 | missing | n/a | missing | missing |

## 9. CLAIM EVIDENCE LIVE PROOF

| Claim Evidence Surface | Required Tokens Present? | Evidence | Verdict |
|---|---:|---|---|
| claim_evidence_enabled=true | yes | Scanner/Market/Manifest combined search | present |
| claim_evidence_schema= | yes | Scanner/Market/Manifest combined search | present |
| claim_section_level_enabled=true | yes | Scanner/Market/Manifest combined search | present |
| claim_dossier_section_count= | yes | Scanner/Market/Manifest combined search | present |
| claim_market_board_lookup_enabled=true | yes | Scanner/Market/Manifest combined search | present |
| claim_trader_chat_packet_enabled=true | yes | Scanner/Market/Manifest combined search | present |
| claim_family_dossier_availability_enabled=true | yes | Scanner/Market/Manifest combined search | present |
| claim_evidence_per_symbol_rows=false | yes | Scanner/Market/Manifest combined search | present |
| claim_evidence_section_spam_avoided=true | yes | Scanner/Market/Manifest combined search | present |

## 10. DOSSIER SECTION-LEVEL CLAIM EVIDENCE LIVE PROOF

| Dossier Section | Claim Evidence Present? | Claim Owner | Currentness / Actionability | Verdict |
|---|---:|---|---|---|
| Publication & Integrity | yes | Dossier composer | current/prepared review only | pass |
| Market State Timing | yes | Market State owner | open/closed/currentness explicit | pass |
| Quote Snapshot | yes | Market Watch/Open Symbol Snapshot owner | 3 crypto Top5 files unavailable; others live/stale/degraded explicit | partial |
| Candidate Gate Status | yes | Candidate Filtering owner | ranked not actionable | pass |
| Shortlist Core | yes | Shortlist Selection owner | L4 rank context only | pass |
| Deep Activation & Coverage | yes where deep attached; rank4/5 pre-patch pending | Deep Selective Analysis owner | rank4/5 half-truth defect patched | hold until RUN126R |

## 11. MARKET BOARD TRADER-CHAT PACKET LIVE PROOF

| Market Board / Packet Token | Present? | Meaning | Verdict |
|---|---:|---|---|
| market_board_to_dossier_lookup_enabled=true | yes | lookup policy emitted | pass |
| market_board_rank_is_not_trade_signal=true | yes | signal safety | pass |
| packet_type=market_board_trader_chat_context | yes | trader-chat packet emitted | pass |
| packet_rank_source=committed_l4_snapshot | yes | rank source explicit | pass |
| packet_actionability_requires_selected_current_refresh=true | yes | actionability separation | pass |
| packet_next_live_proof=RUN125R | yes | planned live proof boundary | pass |

## 12. MARKET BOARD TO DOSSIER LOOKUP LIVE PROOF

| Board Symbol | Source Surface | Expected Dossier Path | Exists / Pending | Verdict |
|---|---|---|---|---|
| Top5 bucket symbols | Top5PerBucket manifests and child files | Dossiers/Top5PerBucket/<bucket>/<symbol>.txt | 28 active children found | lookup exists; depth parity broken pre-patch |
| GlobalTop10 symbols | GlobalTop10 manifest and child files | Dossiers/GlobalTop10/<symbol>.txt | GlobalTop10 children found | pass |
| selected/current | Manifest | Current Focus / selected Dossier | no selected symbol active | honest unavailable |

## 13. FAMILY DOSSIER AVAILABILITY LIVE PROOF

| Family | Availability Claim | Child Files | Missing / Pending | Verdict |
|---|---|---:|---|---|
| Top5PerBucket | promoted_current; target 28, written 28, pending 0 | 28 | none by manifest | family present but rank4/5 depth policy defective |
| GlobalTop10 | promoted_degraded_first_publish; manifest present | 16 files observed including retained extras | retained extras require freshness interpretation | stronger deep parity than Top5 |

## 14. TOP5 LIFECYCLE LIVE PROOF

| Top5 Proof Area | Expected | Live Evidence | Verdict |
|---|---|---|---|
| active set exactness | active children match family manifest | 28/28 written | pass |
| small files | no permanent half-truth if GlobalTop10-style parity expected | 10 files ~125–128KB, all rank4/5 | fail pre-patch |
| quote unavailable | Bid/Ask should be honest and owner-explained | AAVEUSD.nx, ADAUSD.nx, DOGEUSD.nx unavailable | carry-forward quote owner investigation |
| staging | idle/cleared after promote | staging manifest only, no mirrored child files | pass |
| archive | previous snapshots retained | archive folder present in package tree where available | pass/carry-forward |
| cadence | 10-minute requested | source was 1200s; patched to 600s | patched |
| deep parity | Top5 should match GlobalTop10 style | pre-patch ranks 4/5 never queued deep | patched |

### Top5 unavailable Bid/Ask files

| Bucket | File | Size | Rank | Bid | Ask | Deep Payload | Rank4/5 Pending |
|---|---|---:|---:|---|---|---|---|
| crypto | AAVEUSD.nx.txt | 479096 | unknown | unavailable | unavailable | yes | no |
| crypto | ADAUSD.nx.txt | 465656 | unknown | unavailable | unavailable | yes | no |
| crypto | DOGEUSD.nx.txt | 467708 | 1 | unavailable | unavailable | yes | no |

### Top5 small / incomplete files

| Bucket | File | Size | Rank | Bid | Ask | Deep Payload | Rank4/5 Pending |
|---|---|---:|---:|---|---|---|---|
| crypto | ALGOUSD.nx.txt | 128054 | 4 | 0.11352 | 0.11398 | no | yes |
| crypto | APEUSD.nx.txt | 127744 | 5 | 0.149 | 0.159 | no | yes |
| fx | AUDCAD.txt | 126710 | 5 | 0.98039 | 0.98043 | no | yes |
| fx | SGDJPY.txt | 126844 | 4 | 124.997 | 125.013 | no | yes |
| indices | DJCUSD.c.txt | 126812 | 4 | 49253.45 | 49254.65 | no | yes |
| indices | GECEUR.c.txt | 125812 | 5 | 24107.63 | 24118.73 | no | yes |
| metals | XAGAUD.txt | 125252 | 4 | 103.048 | 103.110 | no | yes |
| metals | XAGEUR.txt | 125934 | 5 | 63.090 | 63.147 | no | yes |
| stocks | 1024.xhkg.txt | 128184 | 4 | 43.07 | 43.10 | no | yes |
| stocks | 1038.xhkg.txt | 125422 | 5 | 66.16 | 66.27 | no | yes |

### Every active Top5 child inspected

| Bucket | File | Size | Rank | Bid | Ask | Deep Payload | Rank4/5 Pending |
|---|---|---:|---:|---|---|---|---|
| crypto | AAVEUSD.nx.txt | 479096 | unknown | unavailable | unavailable | yes | no |
| crypto | ADAUSD.nx.txt | 465656 | unknown | unavailable | unavailable | yes | no |
| crypto | ALGOUSD.nx.txt | 128054 | 4 | 0.11352 | 0.11398 | no | yes |
| crypto | APEUSD.nx.txt | 127744 | 5 | 0.149 | 0.159 | no | yes |
| crypto | DOGEUSD.nx.txt | 467708 | 1 | unavailable | unavailable | yes | no |
| energy | UKOIL.c.txt | 488744 | unknown | 110.478 | 110.526 | yes | no |
| energy | USOIL.c.txt | 483476 | unknown | 101.381 | 101.437 | yes | no |
| energy | XNGUSD.txt | 462908 | unknown | 2.745 | 2.789 | yes | no |
| fx | AUDCAD.txt | 126710 | 5 | 0.98039 | 0.98043 | no | yes |
| fx | AUDNZD.txt | 468876 | unknown | 1.22144 | 1.22145 | yes | no |
| fx | NZDCAD.txt | 468720 | unknown | 0.80262 | 0.80265 | yes | no |
| fx | SGDJPY.txt | 126844 | 4 | 124.997 | 125.013 | no | yes |
| fx | USDCZK.txt | 479402 | 1 | 20.8121 | 20.8148 | yes | no |
| indices | AXCAUD.c.txt | 502464 | unknown | 8683.12 | 8690.32 | yes | no |
| indices | CHCUSD.c.txt | 514320 | 3 | 15608.01 | 15615.11 | yes | no |
| indices | DJCUSD.c.txt | 126812 | 4 | 49253.45 | 49254.65 | no | yes |
| indices | GECEUR.c.txt | 125812 | 5 | 24107.63 | 24118.73 | no | yes |
| indices | JPCJPY.c.txt | 516790 | 1 | 59434.00 | 59443.00 | yes | no |
| metals | GAUCNH.txt | 506926 | unknown | 1010.512 | 1010.629 | yes | no |
| metals | GAUUSD.txt | 495178 | unknown | 147.7998 | 147.8136 | yes | no |
| metals | XAGAUD.txt | 125252 | 4 | 103.048 | 103.110 | no | yes |
| metals | XAGEUR.txt | 125934 | 5 | 63.090 | 63.147 | no | yes |
| metals | XAUAUD.txt | 503952 | unknown | 6418.61 | 6419.34 | yes | no |
| stocks | 101.xhkg.txt | 464608 | unknown | 9.16 | 9.18 | yes | no |
| stocks | 1024.xhkg.txt | 128184 | 4 | 43.07 | 43.10 | no | yes |
| stocks | 1038.xhkg.txt | 125422 | 5 | 66.16 | 66.27 | no | yes |
| stocks | 358.xhkg.txt | 478196 | unknown | 38.31 | 38.34 | yes | no |
| stocks | 688.xhkg.txt | 477582 | unknown | 13.16 | 13.18 | yes | no |

## 15. ROOT DOSSIER REDUCTION LIVE PROOF

| Root Dossier Category | Count | Fresh? | Expected? | Verdict |
|---|---:|---:|---:|---|
| legacy/root ordinary files | 2 | yes | selected/legacy only | pass |
| new routine root symbol files | 0 observed beyond ETHUSD/GECEUR | no broad spam | yes | pass |
| selected/current root file | 0 | no selected symbol active | acceptable | pass |
| GlobalTop10 child files | 16 observed | yes/retained mix | yes | pass |
| Top5PerBucket child files | 28 | yes | yes | partial due depth parity |
| diagnostic all-symbol files | 0 | n/a | no | pass |

## 16. SELECTED/CURRENT + CURRENT FOCUS LIVE PROOF

| Selected-Symbol Surface | Exists? | Fresh? | Root Policy Interaction | Verdict |
|---|---:|---:|---|---|
| selected/current root Dossier | no | no selected active | root policy preserved | not applicable |
| Current Focus | no | manifest says no selected symbol active | independent of root all-symbol | honest unavailable |
| Dossier composer | yes via family dossiers | prepared review only | no actionability leak | pass |
| Deep Analysis/manual refresh | source path exists | not directly triggered in runtime | separate from prepared artifacts | carry-forward |
| HUD dependency | not tested | n/a | read-only law untouched | protected |

## 17. CADENCE / QUEUE / PERFORMANCE LIVE AUDIT

| Performance Proof | Evidence | Status | Patch Needed |
|---|---|---|---|
| Market Board publish 60s | multiple active board writes | visible | no |
| L3 compute 600s | source/proof tokens retained | visible | no |
| L4 compute 1200s | source/proof tokens retained | visible | no |
| GlobalTop10 refresh 300s | manifest/source evidence | stronger parity than Top5 | no |
| Top5PerBucket refresh | live/source was 1200s | too slow by operator instruction | patched to 600s |
| Top5 child queue | one-child/write-beat partials | rank4/5 permanent deep pending | patched to queue ranks 1–5 |
| function_results log size | 20,151,728 bytes | churn risk | carry-forward |
| heartbeat telemetry log size | 2,197,812 bytes | acceptable but watch | carry-forward |
| repeated manifest writes | manifest writes repeated ~2s in function log | timer pressure/file churn risk | carry-forward safe throttle |
| root Dossier reduction | no broad root spam | preserved | no |

## 18. ACTIONABILITY / SIGNAL SAFETY LIVE AUDIT

| Surface | Signal Leakage Risk | Evidence | Verdict |
|---|---|---|---|
| Market Board | rank mistaken as trade | rank_is_not_trade_signal token present | pass |
| Top5 prepared dossiers | prepared availability mistaken as actionability | actionability requires current market state/selected refresh | pass |
| unavailable quotes | unavailable mistaken as bad trade | unavailable is evidence state, not signal | pass |
| source patch | accidental execution change | no OrderSend/CTrade/SL/TP/lot changes | pass |

## 19. CODE CLEANUP + PERFORMANCE IMPROVEMENT MODULE

| Performance Area | Live / Source Evidence | Bottleneck / Risk | Safe Patch Available? | Patch / Carry Forward |
|---|---|---|---:|---|
| Top5 cadence | 1200s source/live | too slow to recover family truth | yes | patched to 600s |
| Top5 rank4/5 depth | 10 small files, rank4/5 permanent pending | half-truth parity defect | yes | queue ranks 1–5 through existing deep owner |
| file churn | manifest repeated writes | timer pressure | yes but separate | carry-forward no-change manifest throttle |
| log churn | 20MB FunctionResults | proof spam | yes but separate | carry-forward throttle/ring policy |
| FileIO | no direct failure | rewrite risk | no | untouched |

## 20. BUG HUNTING + DEBUG + CODE QUALITY MODULE

| Debug Area | File / Surface | Risk | Evidence | Patch / Guard |
|---|---|---|---|---|
| macro redefinitions | ASC_Constants/ASC_Version | compile blocker recurrence | no active duplicate run identity in constants | guarded |
| invalid result codes | ASC_ResultCodes | compile blocker recurrence | ASC_RC_INVALID_STATE present | guarded |
| Top5 half-truth | ASC_Dispatcher / Top5 children | rank4/5 small permanent files | 10 small files all rank4/5 | patched |
| crypto quote unavailable | Top5 Quote Snapshot | false currentness | 3 crypto files unavailable despite GlobalTop10 DOGE fresh | carry-forward quote owner check |
| proof contradictions | Top5 files | rank4/5 expected L0-L4 while user expects identical to Top10 | source policy caused mismatch | patched |
| performance bottleneck | logs/manifest | queue/timer pressure | 20MB function log and repeated writes | carry-forward |
| protected drift | FileIO/HUD/L3/L4/execution | architecture break | untouched | pass |

## 21. ADAPTIVE MT5 THROUGHPUT MODULE

| Adaptiveness Area | Current Behavior | Better Behavior | Patch Now? |
|---|---|---|---:|
| cadence adaptation | Top5 1200s static | Top5 600s per operator while heartbeat unchanged | yes |
| queue budget | rank1–3 only deep queue | rank1–5 uses same deep owner queue | yes |
| snapshot signatures | present but repeated writes continue | no-change publish skip | carry-forward |
| stale/no-change skips | partial proof counters exist | strengthen around manifest/log spam | carry-forward |
| selected-symbol priority | not active in runtime | preserve selected path | no |
| log/proof throttling | 20MB function log | throttle duplicate proof rows | carry-forward |
| artifact batching | Top5 one-child/write-beat | keep bounded but no permanent half-truth | yes |

## 22. PATCH CANDIDATE MATRIX

| Candidate | Evidence | Risk | Decision |
|---|---|---|---|
| Top5 20→10 min cadence | operator request + source 1200s | low | patch |
| Queue Top5 ranks 4/5 for deep | 10 small rank4/5 files vs GlobalTop10 large files | medium but owner-preserving | patch |
| FileIO rewrite | no direct FileIO failure | high | reject |
| HUD work | no direct HUD failure | high | reject |
| L3/L4 formula change | no formula defect | forbidden | reject |
| Quote owner repair | 3 crypto unavailable, needs focused source proof | medium | carry-forward RUN126R if still reproduced |

## 23. PATCH TABLE

| File | Patch | Reason | Behavior Drift |
|---|---|---|---|
| mt5/core/ASC_Constants.mqh | Top5 cadence 1200→600; rank4/5 deep pending policy false; hydration class rank4/5 L0-L6 | operator requested 10 min and parity | no formula/order drift |
| mt5/runtime/ASC_Dispatcher.mqh | Queue ranks 1–5 through existing deep owner; added rank parsing and proof tokens; deep attached branch now records bucket_rank | remove Top5 half-truth gap | bounded writer/deep queue behavior only |
| mt5/artifacts/ASC_ScannerStatusWriter.mqh | required Top5 cadence token 600 | scanner proof alignment | proof token only |
| mt5/core/ASC_Version.mqh | RUN125R version/proof macros | meaningful source patch | version identity only |

## 24. SOURCE FILES TOUCHED

| File |
|---|
| mt5/core/ASC_Constants.mqh |
| mt5/runtime/ASC_Dispatcher.mqh |
| mt5/artifacts/ASC_ScannerStatusWriter.mqh |
| mt5/core/ASC_Version.mqh |
| roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md |
| roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md |
| roadmap/Truth Seeker/TRUTH_SEEKER_RUN125R_LIVE_PROOF_CLAIM_EVIDENCE_TOP5_ROOT_MARKETBOARD_PERFORMANCE_REPORT.md |

## 25. PROTECTED AREAS NOT TOUCHED

FileIO atomic contract, artifact root, GlobalTop10 rank/order/formula, Top5PerBucket rank/order, Market Board order, L3 score, L4 rank formula, Dossier/Current Focus truth ownership, selected-symbol live data path, HUD, scan/write/read lane law, heartbeat cadence, strategy/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP, broad deletion, legacy root cleanup.

## 26. ACCEPTANCE DECISION

| Acceptance Criterion | Evidence | Status | If Open |
|---|---|---|---|
| compile/run practical proof exists | runtime files/logs exist | pass | none |
| RUN124B compile blockers repaired | source/runtime inspected | pass | none |
| Claim Evidence visible | Scanner/Market/Manifest tokens | pass | none |
| Market Board packet visible | Market Board packet tokens | pass | none |
| Top5 lifecycle works | 28/28 active but rank4/5 deep pending | hold | verify RUN126R |
| root reduction preserved | no broad root spam | pass | none |
| selected/current preserved | no selected active | n/a | verify next selected run |
| cadence proof visible | 1200s live, 600s patched | hold | verify RUN126R output |
| performance acceptable | log/file churn risk | bounded | carry-forward |
| no signal leakage | tokens and source guard | pass | none |
| protected areas untouched | source touched limited | pass | none |

Decision option: HOLD_REPAIR_REQUIRED.

## 27. NEXT ROADMAP PLAN

| Next Run | Type | Target | Live? | Acceptance |
|---|---|---|---:|---|
| RUN126R | live proof after source patch | prove Top5 rank1–5 deep parity, 10-minute cadence, crypto Bid/Ask owner behavior, log churn | yes | all Top5 children either deep-attached or honest pending only while queue active; no permanent small rank4/5 files |

## 28. PROMPT EVOLUTION / LIVE PROOF RULES

Permanent NEXT_PROMPT_SEED rule added: When the operator asks for next prompt and does not mention compile errors, assume compile is working and generate the intended run prompt. Do not switch back to compile repair unless compile errors are explicitly provided.

## 29. REGRESSION GUARD

| Guard | Verdict |
|---|---|
| no FileIO atomic rewrite | pass |
| no artifact root change | pass |
| no GlobalTop10 formula/order change | pass |
| no Top5 rank/order change | pass |
| no Market Board order change | pass |
| no L3 score change | pass |
| no L4 formula change | pass |
| no Dossier/Current Focus ownership drift | pass |
| no selected-symbol block | pass |
| no HUD compute | pass |
| no strategy/execution | pass |
| no heartbeat cadence change | pass |
| no lane law change | pass |
| no broad deletion | pass |

## 30. TRUE ROADMAP PROGRESS UPDATE

RUN125R live audit succeeded in finding a real source/system mismatch: Top5PerBucket was not identical to GlobalTop10. It intentionally produced permanent rank4/5 L0-L4 deep-pending children while GlobalTop10 used full deep queue verification. The patch removes that asymmetry by sending all Top5 ranks 1–5 through the existing deep owner queue and shortening Top5 refresh to 10 minutes. This is progress, but not a PASS until post-patch live output proves the repair.

## 31. NEXT_PROMPT_SEED

- next run: RUN126R
- first files/output to read: Upcomers-Server/Dossiers/Top5PerBucket recursively, Top5 family manifest, Market Board, Scanner Status, FunctionResults, heartbeat telemetry, GlobalTop10 overlap symbols, Open Symbol Snapshot
- primary target: prove Top5 rank1–5 parity and 10-minute cadence; investigate any crypto Bid/Ask unavailable mismatch versus GlobalTop10
- source owners: ASC_Dispatcher, ASC_Constants, ASC_ScannerStatusWriter, ASC_Version; quote owner only if defect persists with source proof
- evidence needed: every Top5 file size, bid/ask, tick age, deep_payload_available, rank4/5 pending/attached, queue reason, family manifest child counts, no staging mirror, no root spam
- forbidden drift: FileIO rewrite, HUD work, rank/order/formula changes, strategy/execution, heartbeat/lane law changes, broad deletion
- permanent performance side audit: log/file churn, no-change manifest rewrites, proof duplicate guards, timer pressure
- next live remains: RUN126R

## 32. FINAL DECISION

HOLD. RUN125R proved compile/runtime practical operation and exposed a real Top5 source gap. Source patch landed for Top5 parity and 10-minute refresh, but post-patch compile/live output is still required before declaring RUN125 live-proven.
