# GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN110R / PRE-RUN111 TOP5PERBUCKET LIVE-PROOF READINESS LOCK — FINAL STATIC COMPILE-RISK SCAN, SOURCE-INTEGRATION AUDIT, PACKAGE CONTRACT, AND LIVE TEST INSTRUCTIONS

RUN TYPE: PRE-LIVE READINESS / STATIC COMPILE-RISK SCAN / SOURCE AUDIT / TARGETED PATCH / CONTROL UPDATE / NO-LIVE

NEXT LIVE TEST: RUN111R unless RUN110R discovers compile-blocking source risk

PROOF BOUNDARY: `top5_per_bucket_source_ready_for_RUN111_live_proof`

COMPILE CLAIM: not claimed; no MetaEditor output provided in this package.

LIVE CLAIM: not claimed.

OUTPUT CLAIM: source/control/report package only.

PATCHED:
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_Constants.mqh`
- `mt5/core/ASC_Version.mqh`
- `mt5/logging/ASC_FunctionResults.mqh`
- `mt5/artifacts/ASC_ScannerStatusWriter.mqh`
- `roadmap/Truth Seeker/TRUTH_SEEKER_RUN110R_TOP5_PER_BUCKET_PRELIVE_READINESS_REPORT.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`

PROTECTED: FileIO atomic contract, artifact root, GlobalTop10 rank/order/formula, Market Board order, L3 score, L4 rank, Dossier/Current Focus truth ownership, HUD read-only law, scan/write/read lane law, heartbeat cadence, strategy/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP.

# 2. OPERATOR SNAPSHOT

| Check | Result |
|---|---|
| source patched | yes |
| compile-risk scan completed | yes, static only |
| live path contract locked | yes |
| service reachability verified | yes |
| family/bucket/child contract locked | yes |
| actionability safety locked | yes |
| timing/performance locked | yes |
| RUN111 live proof ready | yes, subject to MetaEditor compile |
| biggest remaining risk | no MetaEditor compile proof and no runtime-generated `Dossiers/Top5PerBucket/` output yet |
| protected areas not touched | FileIO, HUD, L3/L4 formula owners, Market Board ordering, GlobalTop10 formula/order, strategy/execution, heartbeat/lane law |

# 3. INPUT ZIP / FILE INTAKE SUMMARY

| Input | Type | Intake Result |
|---|---|---|
| `Aurora Sentinel Core(371).zip` | source/control changed-files package | extracted and inspected |
| root | `Aurora Sentinel Core/` | valid root found; no rootless package defect |
| file count | 300 files | source/control package, not runtime output |
| runtime artifacts | not present | not treated as defect because this is a source/control package |
| nested roots | none requiring alternate package authority | root preserved |
| RUN106R report | roadmap evidence | found |
| RUN107R report | roadmap evidence | found |
| RUN108R report | roadmap evidence | found |
| RUN109R report | immediate authority | found and read first |
| patched source | RUN109R baseline source | inspected directly; report claims not accepted without source evidence |

# 4. RUN109R ABSORPTION

| RUN109R Item | Verified In Source? | RUN110 Risk | RUN110 Action |
|---|---:|---|---|
| stale run id centralization | yes, `ASC_SourceRunId()` consumed in manifests/child identity | source header still RUN109 until package identity advances | bumped source identity to RUN110 |
| safe child filename | yes, `ASC_Top5BucketSafeFileName(...)` exists before child path use | okay | no behavior change |
| queue bounds guard | partial, child writer guarded | bucket manifest/service still had mismatch indexing exposure | added shared queue alignment guard and service/bucket guards |
| child path guard | yes | okay | no change |
| actionability basis | yes | okay | preserved |
| Scanner Status proof token hardening | yes | RUN109 proof wording would make RUN111 search less direct | advanced tokens to RUN110 pre-live readiness wording |
| dynamic sub-family readiness contract | yes | okay | preserved writer inactive |
| no promoted current claim | yes | family may still say partial/degraded/queued only | preserved no promoted output claim |
| no compile/live proof claim | yes | okay | preserved |

# 5. ROADMAP AUTHORITY CHECK

Authority order was followed: operator prompt first; RUN109R report and patched source second; RUN108R/RUN107R/RUN106R reports next; active roadmap/control and current source package after that. Older context was treated as support only. `TRUTH_SEEKER_ROADMAP.md` remains roadmap authority, but RUN110 did not broaden scope beyond Top5PerBucket pre-live readiness.

# 6. INTERNET RESEARCH CONVERSION TABLE

| Research Area | Source | Finding | RUN110 Readiness Constraint | Patch / Acceptance Impact |
|---|---|---|---|---|
| `FileOpen` subfolder / `FILE_COMMON` / sandbox | Official MQL5 FileOpen + File Functions docs | files are sandboxed under terminal `MQL5\Files`/tester files unless `FILE_COMMON`; write opens create subfolders | keep existing server-root/FileIO contract; do not invent a new artifact root | no FileIO rewrite; locked expected `Upcomers-Server/Dossiers/Top5PerBucket/...` paths |
| `FileFlush` / `FileClose` currentness timing | Official MQL5 FileFlush/FileClose docs | unflushed data can appear later; frequent `FileFlush` may slow operation; `FileClose` forces write of remaining data | avoid hot-loop flush additions; leave atomic writer as the currentness owner | no hot-loop flush patch; proof remains source-ready until runtime package is inspected |
| `EventSetTimer` / `OnTimer` queue behavior | Official MQL5 EventSetTimer/OnTimer docs | timer events are serialized; if a Timer event is queued/processing, a new one is not queued | keep one child/write beat and yield for UI/budget pressure | preserved one-child budget and added guard failure as blocked state, not a loop |
| MQL5 declarations/arrays/StringFormat | Official MQL5 function/file docs and language behavior evidence | array size mismatches and format conversion risks should be avoided before live proof | avoid raw queue indexing after mismatch; reduce `%I64d` datetime formatting exposure | added shared queue alignment helper; replaced child publication id `StringFormat` with concatenation |
| `SymbolInfoSession*` / `SymbolInfoTick` actionability wording | Official MQL5 symbol/session/tick docs | tick/session truth belongs to upstream market-state/snapshot owners, not rank output | Top5PerBucket must not convert L4 rank into signal/actionability | preserved `closed_symbols_actionable=false`, `trade_signal=false`, `execution_change=false`, and actionability basis |

# 7. FINAL STATIC COMPILE-RISK SCAN

| Static Compile Risk | Evidence | Patch Needed | Patch |
|---|---|---:|---|
| undeclared helpers | Top5 helpers appear before service call; new `ASC_Top5BucketQueueArraysAligned` inserted before use | yes | added helper before `ASC_Top5BucketSignature` |
| helper order before use | helper definitions precede service/write use | no | verified |
| duplicate helper names | grep found one queue alignment helper | no | verified |
| wrong parameter count: `ASC_BuildCanonicalDossierPayload(...)` | active signature has 12 parameters; Top5 child call passes 12 | no | verified |
| wrong parameter count: `ASC_WritePublicationPayloadAtomic(...)` | active signature has 6 parameters; Top5 calls pass 6 | no | verified |
| oversized `StringFormat` | no large Top5 format blocks added | no | verified |
| datetime `StringFormat` risk | child publication id used `%I64d` | yes | replaced with `IntegerToString((long)now_utc)` concatenation |
| implicit unknown-to-string | no new unknown helper conversion found | no | verified |
| stale hardcoded run id | source identity now `RUN110R`; source ids use `ASC_SourceRunId()` | yes | bumped version/proof identity |
| array out-of-range risk | bucket manifest and service indexed queue arrays after only child guard | yes | added `ASC_Top5BucketQueueArraysAligned(...)` and service/bucket guards |
| queue array size mismatch handling | child guard existed; service/bucket gap remained | yes | centralized guard and blocked service safely |
| path empty handling | family/bucket/child path checks present | no | verified |
| `StringSetCharacter` usage validity | safe slug/file helpers use character replacement only | no | verified |
| `ArrayResize` failure where critical | `rows_out` growth unchecked | yes | checked resize return in Top5 row builder |
| brace/scope bugs | simple brace count balanced after patch | no | verified |
| enum/string mismatch | introduced guard uses existing `ASC_RC_INVALID_ARGUMENT` | yes | avoided nonexistent result code |
| required token array sizing | child required token extension is sized to 12 and uses 12 slots | no | verified |
| no FileIO signature changes | `ASC_FileIO.mqh` untouched | no | verified |
| no HUD/execution includes touched | HUD and strategy/execution untouched | no | verified |

# 8. SERVICE REACHABILITY AUDIT

| Service Reachability Item | Source Evidence | Safe? | Patch |
|---|---|---:|---|
| service hook exists | `ASC_RunWriteLane(...)` calls `ASC_ServiceTop5PerBucketFamily(...)` | yes | none |
| write-side duty position | service runs when GlobalTop10 batch is not active | yes | none |
| UI priority yield | `ui_priority_active` branch returns after setting `write_dirty` | yes | none |
| near-budget yield | `ASC_WriteLaneNearBudget(...)` branch returns and preserves dirty work | yes | none |
| cadence due trigger | initial due when last served is zero; later due after cadence seconds | yes | none |
| first-run trigger | `top5_bucket_last_served_utc <= 0` | yes | none |
| queue continuation trigger | cursor < queue size continues child writes | yes | none |
| no infinite loop | one-child budget and return on queue remaining | yes | none |
| no starvation | GlobalTop10 gets priority; Top5PerBucket resumes when top10 inactive | yes | none |
| queue mismatch service safety | previously service could index arrays after child guard failure | yes after patch | added service-level queue guard and blocked state |

# 9. LIVE OUTPUT PATH CONTRACT LOCK

| Live Path | Source Owner | Expected In RUN111? | Pass / Fail Rule |
|---|---|---:|---|
| `Upcomers-Server/Dossiers/Top5PerBucket/_family_manifest.txt` | `ASC_Top5BucketWriteFamilyManifest` | yes | pass if exists and contains family tokens |
| `Upcomers-Server/Dossiers/Top5PerBucket/<bucket_slug>/_bucket_manifest.txt` | `ASC_Top5BucketWriteBucketManifest` | yes, for active buckets | pass if at least one active bucket exists and manifest contains bucket tokens |
| `Upcomers-Server/Dossiers/Top5PerBucket/<bucket_slug>/<symbol>.txt` | `ASC_Top5BucketWriteChild` | yes, if L4 bucket top5 rows exist | pass if child files include child identity tokens |
| `Upcomers-Server/Scanner Status.txt` | `ASC_ScannerStatusWriter` | yes | pass if RUN110/Top5 proof tokens present |
| `Upcomers-Server/Artifact Bundle Manifest.txt` | dispatcher package summary path | yes | pass if source/run and Top5 proof boundary visible |
| `Upcomers-Server/Workbench/logs/function_results.log` | `ASC_FunctionResults` | yes | pass if Top5 service rows appear |
| `Upcomers-Server/Workbench/logs/heartbeat_telemetry.log` | heartbeat telemetry owner | yes | pass if no stall/slowdown evidence |
| `Upcomers-Server/Market Board.txt` | existing Market Board writer | yes | pass if rank/order unchanged and source exists |
| `Upcomers-Server/Dossiers/GlobalTop10/_family_manifest.txt` | existing GlobalTop10 family writer | yes | pass if still present; Top5 must not break it |

# 10. FAMILY / BUCKET / CHILD CONTRACT LOCK

| Contract Surface | Required Tokens Ready? | Source Evidence | Patch |
|---|---:|---|---|
| family manifest | yes | `ASC_Top5BucketWriteFamilyManifest` emits required family tokens | proof boundary updated to RUN110 |
| bucket manifest | yes | `ASC_Top5BucketWriteBucketManifest` emits required bucket tokens | added queue alignment guard before bucket queue iteration |
| child Dossier | yes | `ASC_Top5BucketWriteChild` appends Top5PerBucket identity section | preserved; source run now RUN110 |
| dynamic sub-family readiness | yes | `dynamic_sub_family_readiness=` + `sub_family_writer_active=false` | preserved |
| no promoted current | yes | family state remains queued/partial/degraded/empty_source; live currentness not claimed | preserved |

# 11. ACTIONABILITY / CLOSED-SYMBOL SAFETY LOCK

| Safety Rule | Source Evidence | Safe? | Patch |
|---|---|---:|---|
| L4 bucket rank is not actionability | `bucket_rank_source=MarketBoard/L4` plus actionability basis | yes | none |
| Closed Confirmed retained/not-actionable | `ASC_Top5BucketActionability` returns closed not actionable | yes | none |
| Uncertain/Unknown not actionable | actionability helper returns uncertain/unknown not actionable | yes | none |
| stale/degraded not current/actionable | actionability helper checks stale/degraded | yes | none |
| Open Confirmed still not trade signal | `open_confirmed_candidate_not_trade_signal` | yes | none |
| no BUY/SELL / lot / SL/TP | Top5 touched files contain no execution calls | yes | none |
| manifests expose safety | family/bucket/child tokens include safety booleans | yes | none |

# 12. PERFORMANCE / TIMING LOCK

| Timing Rule | Source Evidence | Safe? | Patch |
|---|---|---:|---|
| one child/write beat | `ASC_TOP5_BUCKET_MAX_CHILD_QUEUE_PER_BEAT 1` | yes | none |
| no one-beat full family dump | loop bounded by one child | yes | none |
| UI priority yield | service returns during UI priority | yes | none |
| near-budget yield | service returns near write budget | yes | none |
| no heartbeat cadence change | no timer/cadence owner touched | yes | none |
| no lane law change | service remains write-lane side duty | yes | none |
| no FileIO rewrite | FileIO untouched | yes | none |
| no hot-loop FileFlush | no flush changes | yes | none |
| partial/degraded allowed | family state supports partial/degraded/blocked | yes | added blocked guard state |
| no immediate repeated rebuild churn | cadence + queue cursor prevents hot rebuild churn | yes | none |

# 13. PROOF SURFACE LOCK

| Proof Surface | Expected Token | Source Ready? | RUN111 Check |
|---|---|---:|---|
| FunctionResults | `run110_top5_per_bucket_prelive_readiness_proof=present` | yes | grep function_results log |
| Scanner Status | `RUN110 Top5PerBucket PreLive Readiness Source Patch` | yes | grep Scanner Status |
| Artifact Bundle Manifest | `artifact_family_id=top5_per_bucket` / proof boundary | yes | inspect manifest |
| family manifest | `artifact_family_id=top5_per_bucket` | yes | inspect `_family_manifest.txt` |
| bucket manifests | `bucket_rank_source=MarketBoard/L4` | yes | inspect each `_bucket_manifest.txt` |
| child Dossier headers | `Top5PerBucket Child Identity` | yes | inspect child files |
| actionability | `closed_symbols_actionable=false` | yes | grep all Top5 files |
| safety | `trade_signal=false` / `execution_change=false` | yes | grep all Top5 files |

# 14. RUN111 LIVE TEST PROMPT SEED

| RUN111 Instruction | Why | Evidence Needed |
|---|---|---|
| compile/run after applying RUN110 package | RUN110 is source-only | MetaEditor compile output only if failure; runtime zip if success |
| if compile fails, stop and repair compile blockers | source-ready claim is invalid if compile blocks | exact compile errors |
| if fresh output exists, treat compile/run as practically proven | no live output can exist without compile/run | fresh `Upcomers-Server` runtime package |
| recursively inspect runtime zip | avoid missed-file/audit failure | full file tree and tokens |
| confirm `Dossiers/Top5PerBucket/` family | core proof target | family manifest, bucket manifests, children |
| confirm logs | prove service path reached | function_results and heartbeat telemetry |
| confirm no HUD/heartbeat slowdown | timing lock must survive live | telemetry and optional screenshots/video |
| confirm no closed-symbol actionable overclaim | safety lock | grep safety tokens |
| patch source if live evidence shows source gap | live proof outranks static readiness | changed-files package if needed |

RUN111 required package:
- full `Upcomers-Server` runtime output zip
- compile errors only if compile fails
- optional screenshots/video timing if HUD/latency issue is visible

# 15. PATCH CANDIDATE MATRIX

| Candidate | Reason | Decision |
|---|---|---|
| shared Top5PerBucket queue alignment helper | bucket manifest/service could index mismatched queue arrays | patched |
| service-level mismatch guard | child guard alone did not stop service from indexing `top5_bucket_queue_slugs[qi]` | patched |
| bucket manifest mismatch guard | manifest loop used symbols/slugs/ranks together | patched |
| `rows_out` resize check | critical source row build output could silently fail | patched |
| publication id datetime `StringFormat` | avoid `%I64d` formatting risk before compile proof | patched |
| FileIO changes | not needed and forbidden without direct proof | not touched |
| HUD changes | forbidden | not touched |
| L3/L4 formula changes | forbidden | not touched |

# 16. PATCH TABLE

| File | Patch | Reason | Behavior Drift |
|---|---|---|---|
| `mt5/runtime/ASC_Dispatcher.mqh` | added `ASC_Top5BucketQueueArraysAligned(...)` | central queue mismatch guard | no rank/formula/order change |
| `mt5/runtime/ASC_Dispatcher.mqh` | added bucket manifest guard | prevent mismatched queue array indexing | safer failure only |
| `mt5/runtime/ASC_Dispatcher.mqh` | added service guard with blocked state | prevent child guard failure from being followed by unsafe indexing | safer failure only |
| `mt5/runtime/ASC_Dispatcher.mqh` | checked Top5 row `ArrayResize` | avoid silent output resize failure | safer failure only |
| `mt5/runtime/ASC_Dispatcher.mqh` | replaced child publication id `StringFormat` | reduce datetime formatting compile risk | no output contract change |
| `mt5/core/ASC_Constants.mqh` | updated Top5 proof boundary | lock RUN110 source-ready boundary | token-only |
| `mt5/core/ASC_Version.mqh` | bumped RUN110 identity and constants | package identity | token-only |
| `mt5/logging/ASC_FunctionResults.mqh` | updated Top5 proof token wording | RUN111 grep readiness | token-only |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | updated Top5 proof token wording | RUN111 grep readiness | token-only |
| roadmap/control/report | updated RUN110 evidence | package traceability | no runtime behavior |

# 17. SOURCE FILES TOUCHED

- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_Constants.mqh`
- `mt5/core/ASC_Version.mqh`
- `mt5/logging/ASC_FunctionResults.mqh`
- `mt5/artifacts/ASC_ScannerStatusWriter.mqh`
- `roadmap/Truth Seeker/TRUTH_SEEKER_RUN110R_TOP5_PER_BUCKET_PRELIVE_READINESS_REPORT.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`

# 18. PROTECTED AREAS NOT TOUCHED

- `mt5/io/ASC_FileIO.mqh`
- `mt5/hud/`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `mt5/candidate_filtering/ASC_SelectionFilter.mqh`
- `mt5/shortlist_selection/`
- strategy/semi-auto/execution owners
- GlobalTop10 rank/order/formula
- Market Board order/formula
- heartbeat cadence and lane law

# 19. REGRESSION GUARD

| Guard | Result |
|---|---|
| no FileIO atomic rewrite | pass |
| no artifact root change | pass |
| no GlobalTop10 formula/order change | pass |
| no Market Board order change | pass |
| no L3 score change | pass |
| no L4 rank change | pass |
| no Dossier truth ownership drift | pass |
| no Current Focus truth ownership drift | pass |
| no HUD work | pass |
| no strategy/execution | pass |
| no BUY/SELL | pass |
| no OrderSend / CTrade | pass |
| no lot sizing | pass |
| no SL/TP | pass |
| no heartbeat cadence change | pass |
| no scan/write/read lane law change | pass |

# 20. TRUE ROADMAP PROGRESS UPDATE

RUN110R closes the pre-live readiness gap between RUN109R source hardening and RUN111R live proof. It does not claim compile or runtime output proof. It does lock: source identity, proof tokens, output paths, actionability safety, service reachability, and queue mismatch safety.

# 21. NEXT_PROMPT_SEED

RUN111R / TOP5PERBUCKET LIVE PROOF — APPLY RUN110 PACKAGE, COMPILE/RUN, THEN UPLOAD FULL `Upcomers-Server` runtime output zip. First inspect compile status if failed; otherwise recursively inspect `Dossiers/Top5PerBucket`, Scanner Status, Artifact Bundle Manifest, function_results, heartbeat_telemetry, Market Board, and GlobalTop10 manifest. Prove family manifest, bucket manifests, child Dossiers, safety tokens, one-child/write-beat evidence, and no slowdown. Patch source only if live evidence exposes a source gap. Do not claim promoted current unless source and live artifacts prove it.

# 22. FINAL DECISION

PASS — RUN110R patched the remaining source-obvious pre-live queue/indexing readiness risk, locked RUN111 proof requirements, preserved protected areas, and leaves RUN111R as the next live proof target subject to MetaEditor compile.
