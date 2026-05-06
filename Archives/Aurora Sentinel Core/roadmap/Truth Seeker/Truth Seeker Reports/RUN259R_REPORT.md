# GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN259R / HEARTBEAT BREATHING REPAIR USING PREFETCHED GIT FORENSIC FINDINGS — FIX AURORA NERVOUS SYSTEM FIRST, THEN PLAN MAIN/LITE AND ARCHIVE REPAIR RUNS  
MODE: RESEARCH + DEBUG + PATCH  
TRUTH FURNACE REQUIRED  
REPORT: RUN259R_REPORT.md  
PACKAGE: TRUTH_SEEKER_RUN259R.zip  
SOURCE BASELINE: RUN255R identity telemetry source unless active package proves later baseline  
LIVE EVIDENCE BASELINE: latest uploaded Upcomers-Server evidence showing initial publish, stale refresh continuation, heartbeat over-budget, runtime/source identity contradiction, Main/Lite concern, and Lite archive topology concern  
EXPECTED DECISION: TEST FIRST

# FINAL SUMMARY

RUN259R patched the earliest broken gate: Aurora’s heartbeat/Manifest/Deep-trigger nervous system. This run did not patch Main/Lite mirror broadly and did not patch archive topology broadly.

RUN255 identity is accepted as the active source baseline before this patch because `ASC_Version.mqh` identified as RUN255R. However, the uploaded runtime `function_results.log` identifies as RUN238 and contains no RUN255 identity hits. That is a deployment/runtime evidence contradiction, not proof that RUN259 is live.

Heartbeat starvation is proven in the uploaded runtime window: 77 heartbeat rows, budget 880 ms, 73 rows over budget, 5 rows over 2000 ms, 4 rows over 5000 ms, max elapsed 24654 ms, average elapsed 2043.43 ms. `scanner_status_write=no` appears on all parsed rows while `functionresults_write=yes` appears on all parsed rows. `top10_ms` reaches 24654 ms. `side_duty_ms` reaches 24809 ms, but source inspection found the telemetry was measuring the whole lane as side duty; this was patched.

Manifest poison is source-proven and patched. Active Dispatcher Manifest validation contained stale required tokens including old `next_live_run`/RUN160/RUN242 laws. The Manifest body now emits stable current fields: `manifest_schema_version=`, `artifact_bundle_manifest_role=`, `generated_utc=`, `source_run_id=`, `source_version=`, and `proof_complete=false` degraded boundary. Scanner Status active required-token risk was also patched.

Deep trigger / GlobalTop10 starvation is source-proven as a likely failure class and patched. The GlobalTop10 deferred Deep child path previously called the canonical Dossier payload builder even in the defer path. RUN259R replaces that with a cheap degraded child marker, allows pending deferred Deep labels as degraded route truth, and accepts state-owned deferred children without heavy readback. This does not fake Deep Analysis completion.

Core breathing repair was applied. Top10 batch side work now yields when core L1/L2/Manifest publish work is pending, so Market Board / Scanner Status / Manifest / FunctionResults surfaces can breathe before heavy route work.

Main/Lite mismatch was not broadly patched. Uploaded evidence has visible AAVEUSD Dossier/SDP files for GlobalTop10 and Top5 crypto, but it is not a full parity proof. RUN260R is required for Main/Lite mirror contract repair.

Lite archive topology was not patched. The prefetched Git finding points to RUN247R / `ASC_SymbolDataPackWriter.mqh` as the likely topology drift source, but RUN259R deliberately stops before archive rewrite. RUN261R is required for Lite archive topology repair.

Changed files: `ASC_Dispatcher.mqh`, `ASC_ScannerStatusWriter.mqh`, `ASC_Constants.mqh`, `ASC_Version.mqh`, three Brain Guidebooks, office/control files, active roadmap log, output package manifest, and this report.

Not touched: generated runtime evidence, output folders, FileIO, final paths, L3/L4 ranking/order/formula/membership, HUD, Dossier architecture, broad SDP architecture, strategy/signal/trade/risk logic.

Compile proof status: no MetaEditor compile transcript was available in this environment. This package requires operator compile. If compile is clean, that is user-reported compile status unless transcript is supplied. If compile fails, stop and repair from exact errors.

Decision: TEST FIRST.

# Mode Declaration

| Declaration | Answer |
|---|---|
| current run | RUN259R |
| primary mode | RESEARCH + DEBUG + PATCH |
| source patch allowed | yes, bounded heartbeat/Manifest/Deep-trigger/core-refresh only |
| Git access expected | no; used prefetched Git findings |
| generated output editing | no |
| folder cleanup/deletion | no |
| FileIO rewrite | no |
| final path mutation | no |
| L3/L4 ranking/formula/membership change | no |
| HUD patch | no |
| trading/signal/risk patch | no |
| Main/Lite broad patch | no |
| archive topology broad patch | no |
| final decision | TEST FIRST |

# Evidence Ladder

| Evidence | Rank | Use |
|---|---:|---|
| AI inference | 1 | Hypothesis only. |
| User/prefetched findings/screenshots | 2-3 as supplied | Directional Git/runtime context; active source can contradict it. |
| Uploaded runtime logs/artifacts | 2/7 for observed session | Proves only the uploaded observed window and its identity. |
| Direct source inspection | 3 | Used for source-owner and patch authority. |
| Static local checks | 3-4 limited | Brace/text/diff checks only, not MetaEditor compile. |
| MetaEditor compile | unavailable | Required next. |
| Fresh RUN259 live output | unavailable | Required after compile and follow-up repair sequence. |

# Prefetched Git Forensic Findings Used

| Finding | Used How | Active Source Result |
|---|---|---|
| RUN247R likely introduced/confirmed Lite archive topology drift | Deferred to RUN261R | Not patched in RUN259R. |
| RUN248R key heartbeat/deep-trigger suspect | Guided Dispatcher inspection | Source confirmed defer path still called expensive builder and Top10 ran before core surfaces. |
| RUN246R GlobalTop10 dependency sensitive | Preserved Lite non-independence law | Did not make Lite source owner. |
| Current active identity RUN255R | Source baseline | `ASC_Version.mqh` confirmed RUN255R before patch. |
| Exact RUN160 token not found in prior simple search | Contradicted by active source inspection | Dispatcher did contain active stale RUN160/next-live required token law. Source outranks prior search. |
| RUN248 constants exist but insufficient | Confirmed | Bug class is ordering/call path, not missing constants. |
| Scanner Status old proof wording may confuse | Patched only active required-token risk | Scanner Status validation tokens repaired. |

# Internet Research Conversion Ledger

| Source URL / Citation | Finding | Aurora Risk | Coding Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|
| https://www.mql5.com/en/docs/event_handlers/ontimer | OnTimer events are timer-driven and are not a backlog rescue for long-running handler work. | Long Top10/deep/archive work can starve recurring refresh. | Heavy work must be sliced/deferred before expensive construction. | Deferred path does not call heavy builders. | Heartbeat still has recurring >5000 ms rows after warmup. |
| https://www.mql5.com/en/docs/event_handlers | Event handlers run through the terminal event system. | One long handler blocks later event processing. | Core status writes must happen before heavy side work. | Scanner/Board/Manifest/FunctionResults refresh beyond first window. | Core surfaces freeze while logs continue. |
| https://www.mql5.com/en/docs/files/fileopen | FileOpen returns invalid handle on failure and operates in sandbox paths. | File write assumptions can fake publication. | File success must be observable through writer status/error. | Manifest/Scanner failures report missing token or write error. | Silent failure/no error state. |
| https://www.mql5.com/en/docs/files/filemove | FileMove returns false on failure. | Promotion can fail silently if not logged. | Promotion result/error must be tracked. | No route marked current without successful promotion state. | Current route claim with failed/unknown move. |
| https://www.mql5.com/en/docs/files/filedelete | FileDelete returns false on failure. | Cleanup/deletion can hide evidence or fail silently. | No folder cleanup as proof. | Package excludes generated output edits. | Generated evidence deletion/cleanup used as proof. |
| https://www.mql5.com/en/docs/check/getlasterror and https://www.mql5.com/en/docs/common/resetlasterror | Error code must be read/reset deliberately. | File failures become invisible. | File operation error paths must expose code/reason. | FunctionResults or writer reason includes failure reason. | Repeated missing publication with no reason. |
| https://sre.google/sre-book/monitoring-distributed-systems/ | Golden signals include latency, errors, traffic, saturation. | Heartbeat can look alive while saturated. | Heartbeat telemetry must expose latency, errors, saturation/work count. | Report includes elapsed/top10/side-duty/deferred counts. | Logs continue but no latency/saturation fields. |
| https://sre.google/sre-book/addressing-cascading-failures/ | Load shedding/backoff prevents cascading overload. | Every-beat retry storms amplify failure. | Deep/top10 retries must defer/backoff and not monopolize heartbeat. | Retry skipped/defer reasons visible. | Same heavy work retried every beat without backoff. |
| https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ | Retries can be selfish and worsen overload. | Manifest/deep retries can choke timer lane. | Retry/defer must be bounded and visible. | `publication_retry_skipped_count` and due fields visible in next live. | Retry count grows while core surfaces freeze. |
| https://docs.open-metadata.org/latest/how-to-guides/data-contracts/spec | Data contracts define schema/quality/semantics. | Main/Lite can drift without explicit contract. | RUN260 must define route family, symbol set, epoch, producer/consumer. | Dossier and SDP symbols/layout/epoch match or emit blocker. | Lite publishes partial silent output. |
| https://openlineage.io/docs/spec/facets/ | Lineage facets capture structured run/job/dataset context. | Outputs lose provenance and source snapshot. | Manifest/artifacts must carry source_run_id/source_version/snapshot/epoch. | RUN262 artifacts show matched source identity and epoch. | Artifact lacks source_run_id/snapshot/epoch. |
| https://www.w3.org/TR/prov-overview/ | PROV models entities, activities, agents, and derivation. | Archive/current truth can be confused. | Archive must be explicitly non-current; current truth must come from source-owned route plan. | Archive folders not used as membership source. | Code derives membership from archive/folder listing. |

# Runtime Evidence Summary

| Claim | Evidence | Status |
|---|---|---|
| RUN255 identity in active source | `ASC_Version.mqh` before patch | Confirmed source baseline. |
| RUN255 identity in uploaded runtime | `function_results.log` | Not confirmed; runtime shows RUN238 and zero RUN255 hits. |
| Initial publish happens | Uploaded AAVEUSD Dossier/SDP files | Confirmed for limited visible surfaces. |
| Refresh continuation unhealthy | Heartbeat telemetry | Confirmed. |
| Heartbeat over budget | 73/77 rows over 880 ms, max 24654 ms | Confirmed. |
| Deep trigger spends seconds before defer | Runtime fields absent; top10_ms reaches 24654 ms and source defer path called heavy builder | Source-proven likely class, runtime indirect. |
| Manifest failing from token mismatch | FunctionResults missing_token rows and Dispatcher required-token mismatch | Confirmed. |
| GlobalTop10 blocks behind deep pending | Source confirms deep pending can block Top10 service; patched degraded route truth path | Source-proven risk. |
| Main/Lite mismatch real | User/prefetched context; uploaded evidence limited | Deferred to RUN260R. |
| Lite archive topology differs | Prefetched Git/runtime context; uploaded archive listing absent | Deferred to RUN261R. |

# Manifest Poison Audit

| Token / Field | Required By | Emitted By | Runtime Failure? | Current/Stale | Patch |
|---|---|---|---:|---|---|
| `next_live_run=RUN160R_unless...` | Dispatcher Manifest required token | Not current Manifest body | yes/source risk | stale | Replaced with `displayed_symbols_refresh_progress_percent=` stable emitted field. |
| `next_live_run=RUN242R` | Dispatcher Manifest required token | Not current degraded body | source risk | stale | Replaced with `generated_utc=`. |
| RUN242 runtime/proof tokens | Dispatcher Manifest required tokens | Not stable current body | source risk | stale | Replaced with `source_run_id=`, `source_version=`, `manifest_schema_version=`, `artifact_bundle_manifest_role=`, `proof_complete=false`. |
| Scanner Status `next_live_run=RUN253R...` | Scanner Status required token | Not stable emitted body | source risk | stale/future-run | Replaced with `current_live_proof_run=RUN253R`. |
| Constants `next_live_run=` macros | Artifact helper body text | Legacy output context | source risk | stale/confusing | Converted to legacy successor-run context without active `next_live_run=` field. |

# Deep Trigger / Heartbeat Audit

| Issue | Source Owner | Finding | Patch |
|---|---|---|---|
| Deferred GlobalTop10 child still heavy | `ASC_Dispatcher.mqh / ASC_PublishGlobalTop10DeferredDeepChild` | Defer path called `ASC_BuildCanonicalDossierPayload`. | Replaced with cheap degraded marker payload. |
| Pending deferred Deep not accepted | `ASC_GlobalTop10PayloadCarriesDeferredDeepLabel` | Accepted only terminal deferred labels. | Added pending/deep_pending/deep_enrichment_deferred labels as degraded route truth. |
| Heavy readback after state-owned deferred write | `ASC_ServiceTop10RunFullBatch` | Verification could re-read heavy child. | State-owned `top10-deferred-` child accepted as degraded route truth without heavy readback. |
| Top10 work before core surfaces | `ASC_RunWriteLane` | Top10 service ran before core Board/Manifest/Scanner could breathe. | Top10 yields when L1/L2/Manifest pending. |
| side_duty_ms false saturation | heartbeat telemetry assembly | Measured whole heartbeat lane. | Timed post-lane side duties separately and summed true side duty only. |

# Core Breathing Repair

Core surfaces remain source-owned. RUN259R does not change final paths or FileIO. The breathing repair makes heavy Top10/deep side work yield while core publish work is pending, and makes Manifest validation depend on emitted current stable fields rather than stale run-specific future tokens.

Next live proof must verify: Scanner Status refresh, Market Board refresh, Manifest refresh, FunctionResults refresh, heartbeat rows under budget, and zero stale-token Manifest failures.

# Main/Lite Contract Audit and RUN260 Plan

| Route/Bucket | Main Dossier Count | Lite SDP Count | Symbol Match? | Rank/Order Match? | Source Owner | Patch Now? | RUN260 Plan |
|---|---:|---:|---|---|---|---|---|
| GlobalTop10 | 1 symbol + family manifest in uploaded evidence | 1 symbol | Limited match for AAVEUSD only | Not fully proven | Dossier writer + SDP routing/writer | no | Make Lite consume Main family plan/snapshot and emit same route/symbol set or family blocker. |
| crypto | 1 symbol + bucket manifest | 1 symbol | Limited match for AAVEUSD only | Not fully proven | Top5 bucket plan + SDP writer | no | Enforce bucket folder/symbol/rank parity. |
| energy | 0 | 0 | Not enough evidence | Not enough evidence | Same | no | Verify source snapshot, not folder-derived output. |
| fx | 0 | 0 | Not enough evidence | Not enough evidence | Same | no | Verify source snapshot, not folder-derived output. |
| indices | 0 | 0 | Not enough evidence | Not enough evidence | Same | no | Verify source snapshot, not folder-derived output. |

RUN260R purpose: Main/Lite mirror contract repair. Lite must mirror Main layout, symbols, epoch, source snapshot, rank/order where relevant, and blocker truth. Lite must not become an independent truth owner.

# Archive Topology Audit and RUN261 Plan

| Archive Family | Main Topology | Lite Topology | Match? | Source Owner | RUN261 Plan |
|---|---|---|---|---|---|
| GlobalTop10 | Not present in uploaded archive evidence | Not present in uploaded archive evidence | Unproven in package | Dossier archive owner + SDP writer | Inspect source and create one family snapshot folder per refresh. |
| Top5PerBucket | Not present in uploaded archive evidence | Not present in uploaded archive evidence | Unproven in package | Dossier archive owner + SDP writer | Mirror Main family snapshot topology. |
| previous_state_cache | Not present in uploaded evidence | Not present in uploaded evidence | Unproven in package | `ASC_SymbolDataPackWriter.mqh` | Keep separate from timestamped history. |
| timestamped_history | Prefetched finding says Main-style family snapshot expected | Prefetched finding says Lite per-symbol scatter likely | Suspected mismatch | `ASC_SymbolDataPackWriter.mqh` | Convert Lite history to family-refresh timestamp folders without current-truth ownership. |

RUN261R purpose: Lite archive topology repair. Archive remains historical evidence only, never membership source.

# Patch Scope Applied

| File | Patch |
|---|---|
| `mt5/runtime/ASC_Dispatcher.mqh` | Manifest stable tokens/body; cheap deferred GlobalTop10 child; degraded Deep acceptance; Top10 core-breathing defer; side-duty telemetry fix. |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | Stable emitted validation tokens replacing stale future-run required tokens. |
| `mt5/core/ASC_Constants.mqh` | Deprecated `next_live_run=` macro text into legacy context tokens. |
| `mt5/core/ASC_Version.mqh` | RUN259 identity/package/next sequence macros. |
| Brain Guidebooks and control files | Durable RUN259 laws and run handoff. |

# Static / Source Acceptance Tests

| Test | Result |
|---|---|
| Active `next_live_run=` required tokens removed from touched MT5 source | PASS |
| Exact stale RUN160 future-run token absent from touched MT5 source | PASS |
| Manifest required tokens now match emitted stable body fields | PASS by source inspection |
| Deferred GlobalTop10 child path no longer calls canonical Dossier builder | PASS by source inspection |
| Pending deferred Deep is labeled degraded, not complete | PASS |
| Top10 side work yields when core publish surfaces pending | PASS by source inspection |
| FileIO unchanged | PASS; not in changed file list |
| Final paths unchanged | PASS; no path-owner mutation |
| L3/L4 ranking/order/formula/membership unchanged | PASS; no L3/L4 files changed |
| HUD unchanged | PASS; no HUD files changed |
| Generated runtime evidence unchanged | PASS; package excludes evidence |
| Trade/signal/risk logic unchanged | PASS |
| Brace balance on touched source files | PASS |
| MetaEditor compile | NOT RUN |

# Roadmap Plan Before Next Live Test

| Run | Purpose | Why Before Live? | Allowed Scope | Acceptance |
|---|---|---|---|---|
| RUN259R | Heartbeat/Manifest/Deep-trigger breathing repair | System must breathe before mirror/archive proof | Dispatcher, Scanner Status, Constants, Version, guidebooks/control | Source patch produced; compile next. |
| RUN260R | Main/Lite mirror contract repair | User law requires identical route/bucket/symbol/epoch layout before live proof | SDP/Dossier contract/routing/writer only if source-owned | Lite mirrors Main or emits family-level blocker. |
| RUN261R | Lite archive topology repair | Archive must be one family snapshot folder per refresh | SDP archive writer/topology only | Lite archive topology matches Main; archive not current truth. |
| RUN262R live | Bounded live proof | Needs compile + source repairs first | Runtime evidence only | Heartbeat < budget after warmup, Manifest no stale-token failures, core surfaces refresh, route parity/archive proven. |

# Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Rank A | Rank B | Outranks | Resolution | Pause? |
|---|---|---|---|---:|---:|---|---|---|
| Active source is RUN255R | Runtime evidence is RUN238R | `ASC_Version.mqh` | uploaded `function_results.log` | 3 | 7 for old observed session | Both in different domains | Patch source to RUN259; require fresh compile/live proof. | TEST FIRST |
| Identity loop can be exited | Uploaded runtime still stale identity | Prefetched finding/source | runtime log | 3 | 7 for observed window | Runtime proves old uploaded session stale | Do not do report-only identity loop; patch source but require fresh proof. | TEST FIRST |
| Nothing refreshes | Initial AAVEUSD artifacts exist | user wording | uploaded files | 2 | 7 observed | Uploaded files | System publishes initial burst but refresh continuation unhealthy. | no |
| Refresh works | 73/77 heartbeat rows over budget | artifact existence | heartbeat log | 2 | 7 observed | heartbeat log | Breathing repair required. | TEST FIRST |
| Manifest current | Stale required tokens exist | expectation | Dispatcher source | 1/2 | 3 | source | Replace stale tokens with stable emitted fields. | TEST FIRST |
| Deep guard works | Deferred path called heavy canonical builder | prior constant existence | Dispatcher source | 3 | 3 | source call path | Patch defer path before live proof. | TEST FIRST |
| Lite mirrors Main | User reports mismatch / evidence incomplete | expectation | user/prefetched + limited upload | 1 | 2/3 | insufficient for full proof | Defer to RUN260 with exact contract. | no broad RUN259 patch |
| Archive fixed | Prefetched finding says Lite topology drift | assumption | prefetched Git finding | 1 | 3 supplied | prefetched unless contradicted | Defer to RUN261. | no broad RUN259 patch |
| Patch Main/Lite now | Heartbeat unhealthy | user desire | heartbeat log/source | 2 | 7/3 | heartbeat/source | Breathe first, mirror next. | yes for Main/Lite |

# Package Validation Table

| Check | Result |
|---|---|
| Exact package name required | `TRUTH_SEEKER_RUN259R.zip` |
| Changed files only | yes |
| Original folder layout preserved | yes |
| Whole repo included | no |
| Generated evidence included | no |
| Generated evidence edited | no |
| FileIO/final path mutation | no |
| L3/L4/HUD/trading mutation | no |
| Report included | yes |
| Compile proof included | no |
| Fresh live proof included | no |

# Final Decision

TEST FIRST
