# RUN263R_REPORT.md

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN263R / GIT + LIVE OUTPUT DEEP AUDIT AFTER RUN262R SOURCE PACKAGE — SOURCE-OF-TRUTH DRIFT FOUND, MANIFEST REQUIRED-TOKEN CONTRACT FAILURE FOUND, HEARTBEAT BREATHING STILL OVER BUDGET, SDP/LITE AND GLOBALTOP10 PROOF ABSENT
MODE: AUDIT + DEBUG
TRUTH FURNACE REQUIRED
REPORT: RUN263R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN263R.zip
SOURCE BASELINE: Uploaded RUN262R Lite archive topology package + GitHub main check
FINAL DECISION: HOLD
```

```text
FINAL SUMMARY

RUN263R cannot proceed as a passed live proof.

Git was checked. GitHub main is not at RUN262R. GitHub main reports RUN261R as current source, while the uploaded package and runtime artifacts report RUN262R. A search for a RUN262R Lite archive topology commit returned no commit and no RUN262 branch. This is a source-of-truth drift problem before any deeper runtime claim.

The uploaded source package itself is RUN262R-LiteArchiveTopologyRepair. The live output identity mostly matches that uploaded package: heartbeat rows report source_run_id=RUN262R and source_version=RUN262R-LiteArchiveTopologyRepair. That proves only the supplied output window, not Git deployment truth.

The EA hard crash is not proven because Experts/Journal crash excerpts were not supplied. The supplied runtime logs prove something different and still serious: the EA was alive enough to write FunctionResults, heartbeat, Scanner Status, Market Board, Open Symbol Snapshot, and Top5 Dossiers during the observed window, but it was not breathing cleanly and core publication was failing.

Live duration is insufficient for RUN263R’s requested 15-20 minute proof. The supplied logs cover roughly 2026.05.04 08:17:05 to 08:19:01 UTC, about two minutes.

The earliest exact blocker is Artifact Bundle Manifest publication. FunctionResults shows 4 Manifest write failures with missing_token=no_change_reprint_dirty_loop_guard=metadata_only_no_flush_loop. Source inspection of the uploaded RUN262 package finds that exact token only as an active required token in mt5/runtime/ASC_Dispatcher.mqh, not as emitted output. That is a source contract mismatch, not FileIO proof, not archive proof, and not a reason to rewrite the whole EA.

Heartbeat breathing is improved versus older 5s+ heartbeat evidence but still fails the budget discipline. Observed heartbeat elapsed_ms max=1886, average=1218.5, rows over 880ms=18/22, rows over 2000ms=0, rows over 5000ms=0. Side-duty is worse than heartbeat summary shows: side_duty_ms max=6733, rows over 2000ms=4, rows over 5000ms=1. Deep trigger is not staying cheap: deep_analysis_trigger_ms max=1705 and published=true on 8 rows instead of deferred. Top5 deep child payload max=1337. Presence sweep attempted on all 22 sampled rows and completed on 0.

Refresh continuation is partial only. FunctionResults and heartbeat continue. Scanner Status and Open Symbol Snapshot refresh inside the short window. Market Board appears once. Artifact Bundle Manifest never publishes. Symbol Data Packs are absent. Dossiers/GlobalTop10 is absent. Dossiers/Top5PerBucket exists only partly, with crypto and energy children plus empty bucket manifests for fx and indices.

RUN261 Main/Lite mirror cannot be proven because Symbol Data Packs are absent. RUN262 Lite archive topology cannot be proven because the Lite archive tree is absent. GlobalTop10 cannot be proven because Main GlobalTop10 is absent. The no operational-permission boundary appears preserved in sampled output, but this is not a readiness claim.

Exact next run recommendation: RUN264R source-of-truth + Manifest contract repair first. Sync or commit RUN262R so Git/source/deployment identity are not split, then patch only mt5/runtime/ASC_Dispatcher.mqh::ASC_WriteArtifactBundleManifest so the required Manifest token contract and emitted Manifest body align. Do not touch FileIO, final paths, L3/L4, HUD, route membership, ranking, archive topology, or operational logic. After that, rerun a bounded live test and only then judge heartbeat, SDP, GlobalTop10, and archive gates.

FINAL DECISION: HOLD
```

## Mode Declaration

| Declaration | Observed |
|---|---|
| current run | RUN263R audit package |
| primary mode | AUDIT |
| secondary mode | DEBUG |
| source baseline | Uploaded RUN262R package plus GitHub main check |
| live test evidence supplied? | yes, bounded output window only |
| source patch applied? | no |
| generated output edited? | no |
| output cleanup used as proof? | no |
| Git checked? | yes |
| internet research performed? | no — web access unavailable and user explicitly allowed Git/no-internet context |
| final decision | HOLD |

## Evidence Ladder

| Evidence | Class | Use |
|---|---:|---|
| GitHub main `ASC_Version.mqh` fetched through connector | 3 | proves Git main currently reports RUN261R |
| Uploaded RUN262 source package inspection | 3 | proves package source identity and active Manifest required token location |
| Supplied runtime logs/artifacts | 7/8 bounded | proves only the observed terminal/output window |
| User report that EA crashed | 2 | credible symptom report, but no Experts/Journal crash proof supplied |
| AI inference | 1 | used only to connect inspected evidence; proves nothing alone |

## Git / Source-of-Truth Audit

| Check | Result | Decision |
|---|---|---|
| GitHub repo | `jasonangeltonkin1111-oss/Aurora-Sentinel-Scanner` | checked |
| Git default branch | `main` | checked |
| Git main current run | RUN261R from fetched `ASC_Version.mqh` | HOLD |
| Uploaded source package current run | RUN262R | PASS for package identity |
| Runtime output source_run_id | RUN262R | PASS for uploaded output window |
| RUN262R commit found in Git search | no | HOLD |
| RUN262 branch found | no | HOLD |

**Contradiction:** Git main does not match the supplied/deployed RUN262 identity. This does not prove the terminal ran wrong source, because runtime output says RUN262. It proves the repo is not synchronized with the package/live evidence.

## Uploaded Source Identity

| Field | Observed |
|---|---|
| ASC_VERSION_LABEL | `RUN262R-LiteArchiveTopologyRepair` |
| ASC_TRUTH_SEEKER_CURRENT_RUN | `RUN262R` |
| ASC_TRUTH_SEEKER_OUTPUT_PACKAGE_NAME | `TRUTH_SEEKER_RUN262R.zip` |
| ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN | `RUN263R_BOUNDED_LIVE_PROOF_AFTER_RUN261_RUN262` |

## Runtime Evidence Inventory Summary

| Evidence | Observed |
|---|---:|
| Output files supplied | 30 |
| FunctionResults rows | 283 |
| Heartbeat sampled rows | 22 |
| Runtime window first | 2026.05.04 08:17:05 |
| Runtime window last | 2026.05.04 08:19:01 |
| Symbol Data Packs folder | absent |
| Dossiers/GlobalTop10 folder | absent |
| Artifact Bundle Manifest final | absent |
| Dossiers/Top5PerBucket final symbol files | {'crypto': 5, 'energy': 3, 'fx': 0, 'indices': 0}; fx/indices have bucket manifests only |

## Identity / Source-Run Check

| Surface | Expected | Observed | Decision |
|---|---|---|---|
| Uploaded source | RUN262R | RUN262R / RUN262R-LiteArchiveTopologyRepair | PASS |
| Git main | RUN262R if Git is source truth | RUN261R from connector fetch | HOLD |
| heartbeat | RUN262R | {'RUN262R': 22} | PASS for output window |
| Market Board | RUN262R | RUN262R | PASS |
| Scanner Status | RUN262R | RUN262R | PASS with legacy poison caveat |
| FunctionResults | RUN262R | detail rows include RUN262R aggregate identity | PASS for output window |

## Heartbeat Breathing Check

| Metric | Observed | Target | Decision |
|---|---:|---:|---|
| total heartbeat sampled rows | 22 | enough for bounded run | HOLD: short window |
| elapsed_ms max | 1886 | not recurring over budget | HOLD |
| elapsed_ms average | 1218.5 | near budget | HOLD |
| elapsed_ms rows > 880ms | 18/22 | materially reduced | HOLD |
| elapsed_ms rows > 2000ms | 0 | rare/near 0 | PASS bounded |
| elapsed_ms rows > 5000ms | 0 | 0 | PASS bounded |
| side_duty_ms max | 6733 | bounded | FAIL |
| side_duty rows > 5000ms | 1 | 0 | FAIL |
| deep_analysis_trigger_ms max | 1705 | cheap/deferred | FAIL |
| deep trigger published/deferred | {('false', 'false', 'false'): 14, ('true', 'true', 'false'): 8} | expensive work deferred under pressure | FAIL |
| top5_deep_child_payload_ms max | 1337 | bounded | HOLD/FAIL |
| archive_history_write_ms max | 1023 | bounded/nonblocking | HOLD |
| presence sweep completed | {('true', 'false', 'true'): 22} | should complete sometimes | FAIL |
| scanner_status_write | yes in heartbeat rows | yes | PASS |
| functionresults_write | yes in heartbeat rows | yes | PASS |

## Manifest / Scanner Status Token Cleanness

| Surface | Finding | Decision |
|---|---|---|
| FunctionResults | 4 Manifest failures: missing_token=`no_change_reprint_dirty_loop_guard=metadata_only_no_flush_loop` | FAIL |
| Uploaded RUN262 source | token exists once as required token in `mt5/runtime/ASC_Dispatcher.mqh` | FAIL |
| Output root | no final Artifact Bundle Manifest file found | FAIL |
| Scanner Status | publishes, but still contains legacy RUN160/RUN253 wording | HOLD / semantic poison |

### Exact Manifest Failure Rows

| Timestamp UTC | Function | State | Code | Detail |
|---|---|---|---|---|
| 2026.05.04 08:17:31 | ASC_WriteArtifactBundleManifest | state=error | code=2001 | `detail=Failed to publish Artifact Bundle Manifest: required token contract failed missing_token=no_change_reprint_dirty_loop_guard=metadata_only_no_flush_loop / claim_evidence_stat` |
| 2026.05.04 08:17:44 | ASC_WriteArtifactBundleManifest | state=error | code=2001 | `detail=Failed to publish Artifact Bundle Manifest: required token contract failed missing_token=no_change_reprint_dirty_loop_guard=metadata_only_no_flush_loop / claim_evidence_stat` |
| 2026.05.04 08:18:04 | ASC_WriteArtifactBundleManifest | state=error | code=2001 | `detail=Failed to publish Artifact Bundle Manifest: required token contract failed missing_token=no_change_reprint_dirty_loop_guard=metadata_only_no_flush_loop / claim_evidence_stat` |
| 2026.05.04 08:18:28 | ASC_WriteArtifactBundleManifest | state=error | code=2001 | `detail=Failed to publish Artifact Bundle Manifest: required token contract failed missing_token=no_change_reprint_dirty_loop_guard=metadata_only_no_flush_loop / claim_evidence_stat` |


### Source Evidence For Missing Token

Occurrences of `no_change_reprint_dirty_loop_guard=metadata_only_no_flush_loop` in uploaded RUN262 source: 1

- `mt5/runtime/ASC_Dispatcher.mqh:10829`: `required_tokens[142] = "no_change_reprint_dirty_loop_guard=metadata_only_no_flush_loop";`


```text
10817:    required_tokens[130] = "displayed_symbol_set_source=L4_snapshot";
10818:    required_tokens[131] = "displayed_symbol_set_not_rank_owner=true";
10819:    required_tokens[132] = "displayed_symbol_info_refresh_seconds=300";
10820:    required_tokens[133] = "displayed_symbol_info_last_refresh_utc=";
10821:    required_tokens[134] = "displayed_symbol_info_next_due_utc=";
10822:    required_tokens[135] = "displayed_symbol_info_age_seconds=";
10823:    required_tokens[136] = "displayed_symbol_info_refresh_due=";
10824:    required_tokens[137] = "l2_displayed_refresh_not_full_universe=true";
10825:    required_tokens[138] = "l5_displayed_refresh_deferred_heavy_budget=true";
10826:    required_tokens[139] = "l6_displayed_proof_not_hidden=true";
10827:    required_tokens[140] = "bucket_fill_percent=";
10828:    required_tokens[141] = "displayed_symbols_refresh_progress_percent=";
10829:    required_tokens[142] = "no_change_reprint_dirty_loop_guard=metadata_only_no_flush_loop";
10830:    required_tokens[143] = "source_run_id=";
10831:    required_tokens[144] = "source_version=";
10832:    required_tokens[145] = "generated_utc=";
10833:    required_tokens[146] = "manifest_schema_version=";
10834:    required_tokens[147] = "artifact_bundle_manifest_role=";
10835:    required_tokens[148] = "proof_complete=false";
10836:    required_tokens[149] = "signal_permission=false";
10837:    required_tokens[150] = "trade_permission=false";
10838:    required_tokens[151] = "execution_permission=false";
10839:    required_tokens[152] = "risk_permission=false";
10840:    required_tokens[153] = "source_identity_token=";
10841:    required_tokens[154] = "artifact_schema_version=";
```

## Refresh Continuation Check

| Surface | First / Latest Evidence | Source Run ID | Decision |
|---|---|---|---|
| FunctionResults | 2026.05.04 08:17:05 → 2026.05.04 08:19:01 | RUN262R detail rows | PASS bounded |
| heartbeat | 2026.05.04 08:17:07 → 2026.05.04 08:19:00 | {'RUN262R': 22} | PASS bounded but over budget |
| Scanner Status | 2026.05.04 08:18:58 UTC | RUN262R | PASS bounded |
| Market Board | 2026.05.04 08:17:31 UTC | RUN262R | HOLD: one observed publish |
| Open Symbol Snapshot | 2026.05.04 08:18:28 UTC | source id not cleanly extracted | PASS bounded |
| Manifest | absent; 4 logged failures | n/a | FAIL |
| Dossiers/GlobalTop10 | absent | n/a | FAIL/HOLD |
| Symbol Data Packs/GlobalTop10 | absent | n/a | FAIL/HOLD |
| Symbol Data Packs/Top5PerBucket | absent | n/a | FAIL/HOLD |

## Main/Lite Mirror Contract Check

Cannot be proven. Main/Lite parity requires Main Dossiers and Lite Symbol Data Packs. Supplied evidence has Top5 Dossiers only and no Symbol Data Packs tree.

| Route | Main Present? | Lite Present? | Decision |
|---|---:|---:|---|
| GlobalTop10 | no | no | HOLD |
| Top5PerBucket | partial | no | HOLD |

## Archive Topology Check

Cannot be proven for RUN262 Lite topology because Lite archive output is absent.

| Archive Family | Observed | Decision |
|---|---|---|
| SDP GlobalTop10 archive | absent | HOLD |
| SDP Top5PerBucket archive | absent | HOLD |
| SDP archive manifest | absent | HOLD |
| SDP previous_state_cache | absent | HOLD |
| Main Dossier archive | `Dossiers/Top5PerBucket/archive/20260504_0810/_archive_manifest.txt` | observed but not Lite proof |

## No Operational Permission Boundary

Sampled output did not prove any operational permission was added. This remains a bounded data-review-only observation, not readiness.

## Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| Git/source baseline is RUN262R | Git main reports RUN261R | User prompt/package expectation | GitHub fetched `ASC_Version.mqh` | 2/3 | 3 | Git fetch for repo state; package for uploaded source state | sync/commit RUN262 or declare package as source truth | yes |
| EA crashed | Logs continue to write through 08:19:01 | User report | FunctionResults/heartbeat/runtime artifacts | 2 | 7/8 bounded | Runtime artifacts for observed window | need Experts/Journal for crash proof | yes |
| Manifest poison repaired | Live Manifest fails on missing required token | RUN260/RUN262 report history | FunctionResults + source grep | 3 | 7/8 + 3 | Runtime + source inspection | patch Manifest emitter/required-token contract | yes |
| Heartbeat breathing repaired | side_duty hits 6733ms and deep trigger publishes expensive work | prior source repair reports | heartbeat telemetry | 3 | 7/8 bounded | runtime telemetry | isolate side-duty/deep trigger after Manifest repair | yes |
| RUN261 Main/Lite contract can be judged | Lite Symbol Data Packs absent | RUN261 report | output folder inventory | 3 | 7/8 bounded | output inventory | cannot judge parity until Lite writes | yes |
| RUN262 Lite archive topology can be judged | Lite archive absent | RUN262 report | output folder inventory | 3 | 7/8 bounded | output inventory | cannot judge archive until Lite writes | yes |

## Next Run Decision Matrix

| RUN263 Finding | Next Run | Reason |
|---|---|---|
| Git main behind uploaded source | RUN264R source-of-truth/deployment sync | repo cannot be trusted as current source truth |
| Manifest required-token failure | RUN264R Manifest contract repair | earliest exact blocker; final Manifest absent |
| heartbeat still over budget | after Manifest repair, bounded heartbeat isolation | do not patch broad breathing until earliest publication blocker is fixed |
| Symbol Data Packs absent | after Manifest/source sync, route publication retest | cannot judge Lite contract or archive yet |
| Dossiers/GlobalTop10 absent | after Manifest/source sync, route publication retest | cannot judge Main/Lite GlobalTop10 yet |
| evidence window too short | repeat live proof | two minutes is not RUN263 proof |

## Package Validation Table

| Package Rule | Status |
|---|---|
| exact filename `TRUTH_SEEKER_RUN263R.zip` | PASS |
| report included | PASS |
| derived evidence inventories included | PASS |
| selected logs included | PASS |
| whole repo included | NO |
| source patched | NO |
| generated evidence edited | NO |
| internet research ledger included | NO — unavailable/not performed |

## Final Decision

HOLD

Strongest next move: fix the source-of-truth split and the exact Manifest token mismatch first. Patch only the earliest proven blocker.
