# AURORA TRUTH SEEKER RUNTIME PUBLICATION AUDIT

## Executive verdict

The current publication and logging baseline is **partly hardened, but not clean**.

At source level, the system already has several strong safeguards: a temp-write path exists; most writer-owned artifacts enforce required-token validation before promotion; Market Board publication is explicitly fail-soft around portfolio/history sections; GlobalTop10 has a staged family flow with archive-before-promote discipline; and selected-symbol Current Focus writes do exact post-write readback on the root path. Those are real strengths in the current codebase.

The audit does **not** support a “publication-safe everywhere” claim. The major reasons are these:

1. **The root FileIO contract is only partially verified.** It does temp write, optional token validation, and promote, but it does **not** generically do exact post-promote target readback, it cannot observe `FileClose()` failure, and some copy/promote paths pass **no required tokens at all**, meaning promotion can succeed without content-level validation at the destination (`mt5/io/ASC_FileIO.mqh:355-516`, `528-556`; `mt5/runtime/ASC_Dispatcher.mqh:4275-4288`).  
2. **“Pair publication” is not the active write path for Current Focus.** The pair helper exists but is unused, and even if used it is not truly atomic across both files; the active deep/current-focus path writes the root Dossier first, verifies that, and only then does a non-blocking support copy-down (`mt5/io/ASC_FileIO.mqh:570-651`; `mt5/runtime/ASC_Dispatcher.mqh:8450-8483`, `8707-8718`, `9212-9226`).  
3. **Manifest truth is stale in critical places.** Active roadmap controls say the next live checkpoint is **RUN076R**, but runtime manifest strings still emit **RUN050** as the next live-proof target and still defer multiple seams “to RUN050” (`roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md:1-13`, `59-76`; `roadmap/Truth Seeker/TRUTH_SEEKER_WORKER_GUIDE.md:58-69`; `roadmap/Truth Seeker/TRUTH_SEEKER_RUN_TEMPLATE.md:23-37`, `40-49`, `74-107`; `mt5/runtime/ASC_Dispatcher.mqh:5820-5857`, `6374-6415`).  
4. **FunctionResults is required at bootstrap, but later file-write failures are effectively untracked.** Bootstrap treats log creation as a hard dependency; afterwards, runtime append calls are made and their result is ignored at the state/manifest level (`mt5/runtime/ASC_Bootstrap.mqh:175-252`; `mt5/runtime/ASC_Dispatcher.mqh:7888-7903`; `mt5/AuroraSentinelCore.mq5:184-191`).  
5. **Retained last-good artifacts are not self-labelling in the file that survives.** Continuity often means the old file remains in place under the live path; the continuity label appears in FunctionResults/manifest logic, not inside the retained artifact body itself (`mt5/io/ASC_FileIO.mqh:394-413`, `438-448`, `463-516`).  
6. **The log design avoids per-trade spam in the audited publication paths, but it still has volume risk because a FunctionResults row is appended every timer beat and a separate heartbeat TSV row is appended every beat as well.** Prometheus and OpenTelemetry both warn against high-cardinality telemetry and recommend structured logs with bounded dimensions rather than unbounded event/detail explosion. The source follows the “no per-trade/per-symbol proof spam” intent in the audited publication lanes, but it does not follow a “change-only” or “quiet heartbeat” discipline. citeturn0search1turn0search10turn0search11turn0search2turn4search0turn4search1

The correct system reading is therefore:

- **Market Board publication safety:** materially improved and mostly fail-soft.  
- **Current Focus / root Dossier publication safety:** strong for the primary root path because it does exact readback, but not pair-atomic.  
- **GlobalTop10 family publication:** disciplined, but its final live promotion path uses a weaker copy contract than the selected-symbol root publish path.  
- **Manifest truth:** not clean, because proof-target language is stale and some visibility claims are state-derived instead of filesystem-derived.  
- **FunctionResults / heartbeat logging:** aggregate-oriented in the places that matter most, but still capable of heavy churn and silent append-failure blind spots.

This audit used MQL5 file, timer, and trade-history semantics as the baseline standard: file operations are sandboxed; `FileOpen()` can fail with `INVALID_HANDLE`; overwrite semantics for `FileMove()` depend on `FILE_REWRITE`; `FileFlush()` forces buffered data to disk but frequent use can affect speed; timer events are not queued indefinitely if one is already pending; `PositionsTotal()`, `OrdersTotal()`, and `HistorySelect()` have distinct semantics that must not be conflated. Those standards turn directly into audit questions about whether the source surfaces the right failures and distinguishes open positions, pending orders, and history context honestly. citeturn1search15turn1search16turn1search1turn1search2turn1search3turn0search3turn2search0turn2search1turn3search0turn3search1turn3search2

A final limitation matters: **Deep Research Report 1 was not present in the uploaded zip**, so this report could only absorb the current source, controls, and included Truth Seeker reports.

## Audit standards and current baseline

The practical audit standard here is not “does the code look careful”; it is “does the source behave like a publication system that can survive partial dependency loss, Windows/MQL file semantics, timer pressure, and observability cost without lying about what is current”. That is why the key questions in this report are: whether required artifacts still publish when optional sections degrade; whether write success really means durable/promoted/verified success; whether retained outputs are visibly retained; whether manifests describe the filesystem honestly; and whether logs remain structured and bounded rather than drifting into hidden proof bloat. citeturn1search15turn1search16turn1search1turn2search0turn4search0turn0search1turn0search10

The current true source baseline is **RUN068R-era source** with the active control rule “RUN066R through RUN075R are source-only and the next live checkpoint is RUN076R” (`roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md:1-13`, `59-106`). The runtime publication baseline is:

- **Essential-first write lane:** Open Symbol Snapshot and Market Board are treated as essential surfaces before the dossier queue, and their first-baseline failures can defer dossier publishing (`mt5/runtime/ASC_Dispatcher.mqh:10094-10133`, `10143-10227`, `10793-10802`).  
- **Selected-symbol Current Focus root path:** Current Focus is the root `Dossier.txt`, not a separate `Current Focus.txt` file (`mt5/core/ASC_Constants.mqh:6-11`; `mt5/artifacts/ASC_CurrentFocusWriter.mqh:288-295`).  
- **Per-symbol dossier path:** ordinary symbol dossiers live under `Dossiers\<canonical>.txt` (`mt5/artifacts/dossier/ASC_DossierContracts.mqh:14-19`).  
- **GlobalTop10 family path:** current family under `Dossiers\GlobalTop10`, staging under `_staging`, archive under timestamped archive slots (`mt5/runtime/ASC_Dispatcher.mqh:3306-3348`, `3826-3899`, `3955-4011`, `4247-4349`).  
- **FunctionResults bootstrap contract:** log path creation and bootstrap-marker/header emission are treated as startup-critical (`mt5/runtime/ASC_Bootstrap.mqh:175-252`).

## Artifact publication map

### Artifact publication map

| Artifact | Composer owner | Writer owner | FileIO path | Manifest path | Required/optional |
|---|---|---|---|---|---|
| Market Board | `ASC_BuildMarketBoardArtifact` in `mt5/artifacts/ASC_MarketBoardWriter.mqh:2258-2684` | `ASC_WriteCompanionBoard` in `mt5/artifacts/ASC_MarketBoardWriter.mqh:2179-2218` | `ASC_WritePublicationArtifact -> ASC_WritePublicationPayloadAtomic -> ASC_WriteTextFileAtomic` | `Artifact Bundle Manifest.txt` active-board fields in `mt5/runtime/ASC_Dispatcher.mqh:6471-6503` | **Required essential** |
| Open Symbol Snapshot | `ASC_BuildOpenSymbolSnapshotArtifact` in `mt5/artifacts/ASC_OpenSymbolSnapshotWriter.mqh:22-157` | same function | `ASC_WritePublicationArtifact -> ASC_WritePublicationPayloadAtomic -> ASC_WriteTextFileAtomic` | `Artifact Bundle Manifest.txt` bundle/open-snapshot fields | **Required essential** |
| Artifact Bundle Manifest | `ASC_WriteArtifactBundleManifest` in `mt5/runtime/ASC_Dispatcher.mqh:6448-6977` | same function | `ASC_WritePublicationArtifact -> ASC_WritePublicationPayloadAtomic -> ASC_WriteTextFileAtomic` | self | **Required downstream** |
| Scanner Status | `ASC_WriteScannerStatusArtifact` in `mt5/artifacts/ASC_ScannerStatusWriter.mqh:103-202` | same function | `ASC_WritePublicationArtifact -> ASC_WritePublicationPayloadAtomic -> ASC_WriteTextFileAtomic` | none; state only | **Optional supporting** |
| Ordinary symbol Dossier | `ASC_BuildCanonicalDossierPayload` in `mt5/artifacts/dossier/ASC_DossierComposer.mqh:3196-4588` | `ASC_BuildDossierArtifact` in `mt5/artifacts/ASC_DossierWriter.mqh:197-315` | `ASC_WritePublicationPayloadAtomic -> ASC_WriteTextFileAtomic` | bundle counts only; no per-file manifest | **Required family, queued per symbol** |
| Root Dossier / Current Focus | `ASC_BuildCanonicalDossierPayload` | `ASC_RunDeepFocusTriggerWrite` / `ASC_RunViewedCurrentFocusWrite` in `mt5/runtime/ASC_Dispatcher.mqh:8416-8942`, `9044-9254` | `ASC_WritePublicationPayloadAtomic`, then explicit exact readback with `ASC_VerifyPublicationPayloadReadback` | `Artifact Bundle Manifest.txt` via `Current Focus Proof:` | **Required for selected/deep path** |
| Selected-symbol support Dossier copy | verified root payload re-used; no separate composer | dispatcher copy-down after verified root publish (`mt5/runtime/ASC_Dispatcher.mqh:8707-8718`, `9212-9226`) | `ASC_WritePublicationPayloadAtomic` | no direct per-file manifest | **Optional support** |
| GlobalTop10 staging child dossier | `ASC_BuildCanonicalDossierPayload` via selected/deep writer | top10 child write path in dispatcher (`mt5/runtime/ASC_Dispatcher.mqh:8252-8399`, `8720-8752`) | `ASC_WritePublicationPayloadAtomic` with post-write exact readback | staging `_family_manifest.txt` | **Required once batch admitted** |
| GlobalTop10 live child dossier | no re-compose; copy-from-staging | family promotion in dispatcher (`mt5/runtime/ASC_Dispatcher.mqh:4275-4349`) | `ASC_CopyTextFileAtomic -> ASC_WritePublicationPayloadAtomic` with **empty required tokens** | current `_family_manifest.txt` plus bundle summary | **Required once family promoted** |
| GlobalTop10 family manifest | `ASC_Top10RunFullBuildFamilyManifest` in `mt5/runtime/ASC_Dispatcher.mqh:3833-3855` | `ASC_Top10RunFullWriteFamilyManifest` in `mt5/runtime/ASC_Dispatcher.mqh:3857-3899` | `ASC_WritePublicationPayloadAtomic` | `_family_manifest.txt` | **Required for family integrity** |
| FunctionResults log | record bodies composed in `mt5/logging/ASC_FunctionResults.mqh`, append in `mt5/logging/ASC_Logging.mqh:116-154` | `ASC_RecordResult` and `OnTimer()` (`mt5/runtime/ASC_Dispatcher.mqh:7888-7903`; `mt5/AuroraSentinelCore.mq5:184-191`) | `ASC_AppendTextFile` | mentioned in bundle manifest evidence lines | **Required at bootstrap; expected later but non-blocking** |
| Heartbeat telemetry log | formatted in `ASC_LogHeartbeatTelemetry` (`mt5/runtime/ASC_Dispatcher.mqh:7905-7975`) | same | `ASC_AppendTextFile` | none | **Optional but continuously written** |

### Blocker cascade table

| Dependency | Can fail? | Currently blocks what? | Should block? | Risk | Future fix |
|---|---:|---|---:|---|---|
| Portfolio snapshot composition | yes | does **not** block Market Board; board publishes fail-soft statuses (`ASC_MarketBoardWriter.mqh:967-1003`, `2627-2648`) | no | Low blocking risk, moderate honesty risk | keep fail-soft; improve status precision |
| Portfolio history / `HistorySelect()` | yes | does **not** block Market Board; becomes history unavailable/partial (`ASC_PortfolioExposureSnapshot.mqh:558-665`; `ASC_MarketBoardWriter.mqh:2631-2637`) | no | Users can misread “published” as fully populated | explicit retained/unavailable labelling in artifact body |
| GlobalTop10 current/live family | yes | does **not** block Market Board; independent batch path | no | cross-surface confusion if board looks current while Top10 family is stale | manifest should filesystem-check current family before claiming visibility |
| Open Symbol Snapshot failure | yes | can defer dossier lane **only when there is no last-good L2 baseline** (`ASC_Dispatcher.mqh:10118-10127`) | conditional yes | startup can stall dossier hydration behind essentials | keep first-baseline gate, but surface it more clearly |
| Market Board failure | yes | can defer dossier lane **only when there is no last-good board baseline** (`ASC_Dispatcher.mqh:10212-10227`, `10793-10802`) | conditional yes | startup blocker cascade is deliberate but coarse | preserve gate; add explicit “baseline_missing_blocks_dossiers” state |
| Manifest failure | yes | keeps manifest pending and write-dirty; does not stop already-published artifacts (`ASC_Dispatcher.mqh:10816-10836`) | no | operator can see working artifacts but stale/missing manifest | add explicit manifest-degraded banner in scanner status |
| FunctionResults bootstrap failure | yes | blocks runtime startup (`ASC_Bootstrap.mqh:175-252`; `AuroraSentinelCore.mq5:148-159`) | yes | no publication at all if bootstrap log cannot be established | preserve hard gate |
| FunctionResults runtime append failure | yes | blocks nothing; failure is not promoted into runtime state | no | silent observability loss | track append outcome in runtime state/manifest |
| Current Focus root publish/readback failure | yes | blocks selected/deep current-focus success (`ASC_Dispatcher.mqh:8493-8516`, `8621-8665`, `8754-8817`, `9175-9209`) | yes | selected-symbol truth can lie if root path is not verified | preserve hard gate |
| Current Focus support-copy failure | yes | blocks nothing; explicitly non-blocking after verified root publish (`ASC_Dispatcher.mqh:8707-8718`, `9212-9226`) | no | support dossier can lag behind live root | keep non-blocking, but surface support-copy lag |
| GlobalTop10 staging manifest failure | yes | blocks family promotion (`ASC_Dispatcher.mqh:4247-4266`) | yes | protects current family from partial replacement | preserve |
| GlobalTop10 promote-manifest failure | yes | blocks declaring promoted family complete (`ASC_Dispatcher.mqh:4323-4342`) | yes | protects family integrity but leaves old family live | preserve |

The blocking design is therefore **not random**. The write lane is intentionally “essentials first, dossiers later”, which is sensible when there is no last-good baseline. The problem is not the existence of gating; it is that the gating is only partly surfaced and unevenly verified. That matters because timer-driven systems should keep state transitions explicit: MQL5’s timer queue will not keep stacking timer events while one is pending, so hidden heavyweight work or silent logging failures can directly distort the operator’s view of freshness and progress. citeturn2search0turn2search1turn2search4

### FileIO safety table

| File stage | Source behavior | Risk | Evidence | Future fix |
|---|---|---|---|---|
| Open/create | `ASC_WriteTextFile` and append helpers use `FileOpen(... FILE_COMMON)` and fail on `INVALID_HANDLE` | good basic guard | `mt5/io/ASC_FileIO.mqh:79-95`, `153-166` | keep |
| Write to temp | artifact writes go through temp path via `ASC_WriteTextFileAtomic` | good baseline | `mt5/io/ASC_FileIO.mqh:355-383` | keep |
| Write completeness | `ASC_WriteTextFile` uses `FileWriteString` but does **not** compare bytes written to expected length | false clean success possible before later validation | `mt5/io/ASC_FileIO.mqh:79-100` | check `FileWriteString` return like append path does |
| Flush | `ASC_WriteTextFile` checks `FileFlush()` and treats failure as write failure | good | `mt5/io/ASC_FileIO.mqh:95-99` | keep |
| Close | `FileClose()` is called but cannot be verified; no explicit post-close state | close-level failure cannot be surfaced directly | `mt5/io/ASC_FileIO.mqh:99`, `183`, `219`, `304` | compensate with exact target readback after promote |
| Temp validation | required-token validation reads temp file back and searches for token set | useful but only token-based, not full exact-payload verification | `mt5/io/ASC_FileIO.mqh:405-448` | add exact temp payload comparison for wrapped artifacts |
| Promote | `FileMove(... FILE_REWRITE)` used for overwrite promotion | correct overwrite primitive for MQL5 | `mt5/io/ASC_FileIO.mqh:463-471`; MQL5 overwrite semantics require `FILE_REWRITE`. citeturn1search16turn0search6 | keep |
| Post-promote verification | generic path checks destination existence only; no generic exact target-content readback | promote can look clean without exact target proof | `mt5/io/ASC_FileIO.mqh:473-516` | add generic exact-target readback option |
| Empty-token copy paths | if `required_tokens` is empty, token validation is skipped entirely | weak promotion proof on copy/mirror flows | `mt5/io/ASC_FileIO.mqh:405-448`; `mt5/runtime/ASC_Dispatcher.mqh:4275-4288` | require minimal token set even for copied artifacts |
| Pair write | helper exists but is unused; helper itself is not truly all-or-nothing across both files | “pair safety” can be over-claimed | `mt5/io/ASC_FileIO.mqh:570-651`; no call sites found in current source | either remove the claim or rebuild as real pair contract |

The crucial boundary is this: **temp → validate → promote is implemented, but not uniformly to the same proof depth**. For wrapped writer-owned artifacts it is “temp write + token validation + promote + destination existence check”. For selected Current Focus root and staged Top10 child paths, source adds stronger exact-readback checks on top. For copied family promotions and some continuity paths, the proof is weaker. That means the correct source classification is **implemented but uneven**, not “missing” and not “fully trustworthy everywhere”. MQL5’s file model supports this kind of staged handling, but it does not make it safe automatically; the code still has to check the right postconditions. citeturn1search15turn1search1turn1search2turn1search16turn0search3

## Manifest truth and logging risk

### Manifest honesty table

| Manifest claim | Actual source/output evidence | Honest/misleading | Risk | Future fix |
|---|---|---|---|---|
| `next_live_proof_target=RUN050` and multiple `deferred_to_run050` strings | active controls say next live checkpoint is RUN076R, not RUN050 | **misleading** | operator/control contradiction leaks into runtime artifact | replace RUN050-era strings in runtime manifest source |
| `function_results_log_runtime_proof=bootstrap_marker_written_source_observed_needs_output_package_proof` | value comes from bootstrap state flags, not current file existence/readback | **partial** | manifest can overstate current log visibility after later append failures or deletion | add real file existence/size/header probe at manifest time |
| `function_results_log_existence=source observed bootstrap marker write...` | again state-derived from bootstrap only | **partial** | weakens manifest-as-system-of-record | re-probe current file |
| `global_top10=visible` in cross-artifact witness | derived from runtime state counters and verify counters, not live directory re-scan at manifest write time (`cross_top10_visible`) | **partial** | stale/deleted current family can be reported as visible | recheck current family directory and manifest file |
| `current_focus_expectation=dossier_derivative_expected` | matches source: Current Focus contract points to `Dossier.txt` root path | **honest** | low | keep |
| `active board/current focus publication ids` | manifest uses actual file reads via `ASC_TryGetActivePublicationArtifactDetails` | **mostly honest** | low | keep |
| `manifest=source_writer_current_manifest` | self-referential but explicitly qualified | **honest enough** | low | keep wording explicit |
| `runtime_log_proof_status=runtime_observed` when bootstrap marker succeeded | this is still tied to bootstrap marker, not ongoing append health | **partial** | log health can decay while manifest still sounds healthy | distinguish bootstrap-observed from steady-state-healthy |

The most serious honesty problem is the stale proof-target language. The active control layer is clear: source-only lane now defers live proof until RUN076R. Yet the runtime manifest source still hardcodes RUN050-era proof language, including `next_live_proof_target=RUN050` and several “deferred_to_run050” boundaries. That is exactly the sort of stale control debt that makes a system-of-record look cleaner than it is. citeturn4search0turn4search1turn1search15turn2search0

### Retained / last-good table

| Artifact | Retained status exists? | Clearly labelled? | Risk if stale | Future fix |
|---|---:|---:|---|---|
| Market Board | yes, in FunctionResults/manifest | no, not inside retained live file | reader can treat old board body as current | inject retained/continuity banner on kept-live path or produce sidecar status |
| Ordinary symbol Dossier | yes, via continuity result state | no, retained file stays under live dossier path | stale dossier can look current if only the file is read | add in-file continuity witness or sidecar freshness marker |
| Root Dossier / Current Focus | yes, state + FunctionResults detail | no, retained root `Dossier.txt` itself is not rewritten to say “retained” | selected-symbol operator surface can misread old truth as current | add explicit retained witness outside or inside root path |
| Current Focus support Dossier copy | support failure is surfaced only as non-blocking message | not in copied file | selected support copy can lag root silently | add support-copy freshness alignment token |
| Open Symbol Snapshot | yes, continuity branch exists | not in retained file | open-symbol surface can appear current | add retained witness in body |
| Scanner Status | yes, continuity branch exists | not in retained file | lower risk, but still stale-as-current risk | add continuity line |
| GlobalTop10 current family | current family manifest exists | family manifest is labelled, children themselves are not retained-labelled | child files at live path can be old but still look current | add family-generation stamp to every child or sidecar family id |

### FunctionResults bloat table

| Proof area | Current logging style | Spam risk | Evidence | Future fix |
|---|---|---|---|---|
| Heartbeat result | one FunctionResults row appended every timer beat | **high volume, low cardinality** | `mt5/AuroraSentinelCore.mq5:184-191` | make success heartbeat rows change-only or cadence-batched |
| Heartbeat telemetry | one wide TSV append every timer beat | **high volume** | `mt5/runtime/ASC_Dispatcher.mqh:7905-7975`, `11157` | reduce field width or sample cadence |
| Market Board publication | aggregate row, not per-symbol/per-trade | low cardinality but large row body | `ASC_MarketBoardWriter.mqh:2624-2670` | keep aggregate design; shorten repeated detail |
| Open Symbol Snapshot publication | aggregate row | low-moderate | `ASC_OpenSymbolSnapshotWriter.mqh:142-156` | keep |
| Manifest publication | single large aggregate row with many proof fields | moderate-high width | `ASC_Dispatcher.mqh:6920-6969` | split stable fields from run-specific diagnostic detail |
| Dossier ordinary publish | success rows largely **suppressed** to file | low | `ASC_Dispatcher.mqh:10550` | keep |
| Top10 batch decision success | success rows generally **suppressed** to file; errors go through | low | `ASC_Dispatcher.mqh:4491-4502` | keep |
| Deep/current-focus selected path | event-based rows with long detail | moderate | `ASC_Dispatcher.mqh:8490-8516`, `8754-8881` | keep event-based model; compress support strings |

This is the right place to separate two different risks. The source **does not** show the dangerous thing the operator wanted to avoid in this lane: there is no audited evidence of per-trade or per-closed-deal publication spam being introduced into FunctionResults by Market Board publication. That part of the guard is holding. What the source **does** show is a different risk: a one-row-per-second FunctionResults heartbeat plus a one-row-per-second heartbeat TSV, both of which can create large logs even with bounded dimensions. Prometheus and OpenTelemetry guidance treats this as a real cost problem even when the fields are structured, because backend/storage cost depends not only on cardinality but also on event volume and attribute width. citeturn0search1turn0search10turn0search11turn0search2turn4search0turn4search1

### Heartbeat / performance risk table

| Runtime path | Potential churn | Evidence | Risk | Future fix |
|---|---|---|---|---|
| `OnTimer()` final FunctionResults append | every beat | `mt5/AuroraSentinelCore.mq5:184-191` | steady log growth; append failure ignored | track append result and reduce success cadence |
| `ASC_LogHeartbeatTelemetry()` | every beat wide TSV | `mt5/runtime/ASC_Dispatcher.mqh:7905-7975`, `11157` | separate large log file; no retry/state update | add bounded cadence or rolling summary |
| Manifest composition | very large string build when pending | `mt5/runtime/ASC_Dispatcher.mqh:6448-6977` | CPU/string churn during write lane | simplify manifest payload and remove stale legacy blocks |
| Dossier presence refresh | payload reads across many files | `mt5/runtime/ASC_Dispatcher.mqh:11141-11155` and surrounding queue counters | can add read pressure in large universes | keep bounded sweep and measure separately |
| Top10 family promotion | batch child copy loop + verification + manifests | `mt5/runtime/ASC_Dispatcher.mqh:4218-4374` | burst IO during family replacement | preserve family discipline; improve copy verification, not batch scope |
| Current Focus deep/root verification | full root readback and semantic checks | `mt5/runtime/ASC_Dispatcher.mqh:8450-8881`, `9197-9209` | acceptable cost for selected-symbol lane, but not for broad lane | preserve lane isolation |

### Publication failure mode table

| Failure mode | Current protection | Weakness | Severity | Future fix |
|---|---|---|---|---|
| Temp write fails to open/create | returns error | good | Medium | keep |
| Temp write partially writes payload | only some paths prove by later token readback | `ASC_WriteTextFile` does not check returned byte count | High | enforce byte-count check |
| Flush fails | guarded | close still unverifiable | Medium | combine with post-promote exact readback |
| Promote overwrite fails | guarded by `FileMove` return and existence fallback | generic proof stops at file existence | High | exact target readback after promote |
| Promote succeeds but destination content is wrong | only selected Current Focus and Top10 staging child do exact readback | board/dossier/manifest/snapshot/scanner don’t | High | add generic exact-target readback mode |
| Continuity retains stale artifact under live path | continuity result exists | retained file itself is not visibly marked as retained | High | retained sidecar or in-file continuity banner |
| FunctionResults append fails after bootstrap | no state/manifest update | silent observability loss | High | update runtime state on every append outcome |
| Heartbeat TSV append fails | return ignored | silent telemetry loss | Medium | record failure streak and surface in scanner/manifest |
| GlobalTop10 live-family copy uses empty required-token set | copy path still stages temp file | no content token readback on copied payload | High | require minimal token set on copy |
| Pair publication partially succeeds | helper exists | helper is unused and not truly pair-atomic anyway | Medium | either remove “pair-atomic” notion or implement it properly |
| Stale proof-target strings in manifest | none | active controls and runtime manifest disagree | High | scrub RUN050-era proof-target strings from runtime source |
| Essential-first gating hides why dossiers are deferred | gating exists | operator-facing reason is too scattered | Medium | explicit blocked-by-essential-baseline witness |

### Do-not-break guard table

| Protected subsystem | Why protected | What must not be changed | Audit finding |
|---|---|---|---|
| Market Board fail-soft skeleton | preserves required board output when optional sections degrade | do not make portfolio/history/Top10 optional sections hard-gate file creation | current source correctly keeps fail-soft boundary |
| GlobalTop10 staged family flow | avoids partial current-family replacement | do not shortcut staging/archive/verify/promote discipline | structure is worth preserving, though copy verification is too weak |
| Current Focus root-as-Dossier contract | active selected-symbol truth path depends on it | do not invent a new Current Focus artifact family casually | current source and controls agree root path is `Dossier.txt` |
| FunctionResults aggregate publication semantics | avoids per-trade spam in this lane | do not add per-trade/per-symbol proof rows to publication flows | current source mostly respects this |
| Essential-first startup gating | prevents dossiers outrunning missing first baselines | do not remove first-baseline gating without replacement proof model | gating is intentional and useful |
| Heartbeat governance | timer is the system’s control loop | do not move broad heavy publication into uncontrolled paths | current design remains heartbeat-governed |
| File sandbox/common-file path discipline | required by MQL5 runtime model | do not bypass `FILE_COMMON`/sandbox assumptions in publication paths | current source stays inside sandbox expectations |
| Selected-path exact readback | strongest publish proof in current source | do not weaken Current Focus root readback or Top10 staging child readback | these are the best publication proofs in the repo today |

## Future fixes, do-not-break rules, and report handoff

### High-risk publication paths

The highest-risk publication paths are not the ones with the most code. They are the ones where the source claims or implies more proof than it actually verifies.

The first is **generic artifact promotion through `ASC_WritePublicationPayloadAtomic`**. It is stronger than a naive “write directly to live file” path, but it is still not a full proof cycle because it does not do generic exact target readback after `FileMove()`. The selected Current Focus path and the staged Top10 child path prove that the codebase already knows how to do stronger verification; it simply does not apply that standard uniformly.

The second is **GlobalTop10 live-family promotion**. It preserves staging, verification, archive, and manifest ordering, which is good. But the final child copy into the live family uses `ASC_CopyTextFileAtomic()` with an empty required-token set, so the final promotion step is weaker than the stronger selected-symbol root write path.

The third is **manifest evidence lines for FunctionResults and proof targets**. The current runtime manifest can still sound authoritative while relying on bootstrap flags rather than real-time file checks, and while still pointing to RUN050 instead of RUN076R.

### Hidden blocker risks

The most important hidden cascade is the **first-baseline essential gate**. If Open Symbol Snapshot or Market Board fails before a last-good baseline exists, the dossier lane can be deferred. That is not a bug by itself. The risk is that the system can look like a dossier/backlog problem when the real cause is missing essential-first baseline proof. The fix is not to remove the gate; it is to make the gate explicit.

A second hidden cascade exists in the **selected-symbol root/current-focus path**. Because Current Focus is the root `Dossier.txt`, a root-path failure is not just a “current focus miss”; it is a selected-symbol live-root truth miss. The support dossier copy is optional, but the root publish/readback is not.

A third hidden cascade is **observability decay**. Bootstrap requires FunctionResults, but later append failures are invisible at the state/manifest level. That means publication can continue while the proof spine silently disappears.

### File creation risks

The main file-creation risks are:

- short-write ambiguity in `ASC_WriteTextFile`;
- no generic exact target readback after promote;
- empty-token copy validation in some promotion paths;
- no self-labelling of retained artifacts;
- possible over-reliance on state counters instead of filesystem probes in manifest visibility lines.

These are all source-level risks. None of them justify rewriting the publication architecture. They justify **narrow verification hardening inside existing owners**.

### Manifest truth risks

The current manifest source is carrying historical proof-contract language that is now out of date. The strongest example is the persistent RUN050 proof target inside runtime manifest strings after the active controls have clearly moved the live checkpoint to RUN076R. That is exactly the kind of control drift that makes operators lose trust in a manifest even if the file-creation mechanics are decent.

The second manifest truth problem is that some evidence lines are **state-derived, not probe-derived**. That is acceptable when clearly labelled as such. It is not acceptable when the wording sounds like present-tense filesystem truth.

### FunctionResults and logging risks

FunctionResults is **not** showing the bad pattern that originally triggered concern in this lane: the audited publication paths did not regress into per-trade/per-symbol proof spam. That guard is real and should be protected.

However, the broader logging picture is still risky because the system currently combines:

- one FunctionResults append per timer beat,
- one heartbeat telemetry TSV append per beat,
- wide detail strings in publication rows,
- ignored append-failure outcomes after bootstrap.

That combination is enough to create large logs and weak steady-state observability even without high-cardinality dimensions. The right future fix is **bounded cadence and better stateful append health**, not per-trade suppression logic.

### Top 20 future code fixes

1. In `mt5/io/ASC_FileIO.mqh`, make `ASC_WriteTextFile()` check the returned `FileWriteString()` byte count, like `ASC_AppendTextFile()` already does.  
2. Add a generic **exact destination readback** option after `FileMove()` in `ASC_WritePublicationPayloadAtomic()`.  
3. Make copied publication flows require a **minimal required-token set**, especially GlobalTop10 live-family child promotion.  
4. Replace RUN050-era proof-target strings inside runtime manifest builders with the current control truth.  
5. Distinguish **bootstrap log observed** from **steady-state log healthy** in runtime state and manifest wording.  
6. Update runtime state on **every FunctionResults append attempt**, not just at bootstrap.  
7. Update runtime state on **heartbeat telemetry append failure** and surface that in Scanner Status and Manifest.  
8. Add an explicit **“blocked by missing essential baseline”** witness when dossiers are deferred behind Market Board/Open Symbol Snapshot first-baseline failure.  
9. Add a filesystem recheck for **current GlobalTop10 family visibility** when writing the bundle manifest.  
10. Add a filesystem recheck for **FunctionResults file existence and size** when writing the bundle manifest.  
11. Add a retained/continuity witness that survives on the **live artifact path itself**, not only in FunctionResults.  
12. For Current Focus, surface whether the **support dossier copy is lagging** the verified root `Dossier.txt`.  
13. Either remove the unused pair helper or rework it into a **real pair contract** with all-or-nothing semantics and clear ownership.  
14. Shorten repeated detail payloads in Manifest and Market Board FunctionResults finish strings.  
15. Make success heartbeat FunctionResults rows **change-only or cadence-batched** instead of one-per-second forever.  
16. Make heartbeat telemetry logging configurable or cadence-bounded so large universes do not guarantee huge telemetry files.  
17. Add one explicit **artifact generation id / family generation id** into every GlobalTop10 child so “current family” is visible on each file, not only in the family manifest.  
18. Add a narrow helper for **manifest probe truth class** so lines clearly say “state-derived” versus “filesystem-probed”.  
19. Add a minimal **publication failure ledger** structure in runtime state so repeated append/promote/verify failures can be surfaced compactly without log spam.  
20. After the five audits are complete, do one narrow post-audit pass that aligns **active controls, runtime manifest wording, and proof-debt classes** so the control plane stops contradicting itself.

### Top 20 do-not-touch rules

1. Do not remove Market Board’s fail-soft skeleton requirement.  
2. Do not let portfolio/history/GlobalTop10 optional sections become hard blockers for Market Board file creation.  
3. Do not invent a separate `Current Focus.txt` family unless the operator explicitly changes the contract.  
4. Do not weaken exact readback on the selected/deep root Current Focus path.  
5. Do not weaken exact readback on staged GlobalTop10 child writes.  
6. Do not collapse GlobalTop10 staging, archive, verify, and promote into a single-step overwrite.  
7. Do not add per-trade or per-closed-deal FunctionResults publication rows.  
8. Do not move publication work out of the heartbeat-governed lane into uncontrolled side paths.  
9. Do not remove first-baseline essential gating without replacing it with an equally honest baseline contract.  
10. Do not rewrite FileIO broadly; the problem is proof depth, not total absence of a publication framework.  
11. Do not let writers become new truth owners; keep them as projection/publish owners.  
12. Do not let the manifest claim stronger runtime proof than the filesystem or output package actually supports.  
13. Do not treat retained live-path artifacts as inherently current.  
14. Do not use runtime state counters as a substitute for filesystem probes when wording implies present-tense visibility.  
15. Do not add high-cardinality telemetry dimensions to solve publication diagnostics.  
16. Do not silence required error rows in FunctionResults.  
17. Do not suppress all heartbeat observability; reduce cadence intelligently instead.  
18. Do not patch GlobalTop10 ranking/selection logic inside a publication-safety cleanup.  
19. Do not merge selected-symbol deep publication proof with ordinary dossier publication proof; they are different trust levels.  
20. Do not close proof debt with source language alone; publication and logging truth still need a later live checkpoint.

### Report 3 handoff

Report 3 should inspect **publication truth versus contradiction/alignment surfaces**, starting in this order:

1. `mt5/runtime/ASC_Dispatcher.mqh` manifest-building lines around `ASC_ManifestFunctionResultsLogEvidenceLine`, `ASC_ManifestCurrentFocusProofLine`, `ASC_ManifestCrossArtifactAlignmentLine`, and `ASC_ManifestPhase2AOpenProofLedgerLine`.  
2. `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` and any contradiction/proof-scope helper constants used to label retained/current/runtime-unobserved states.  
3. `mt5/artifacts/ASC_MarketBoardWriter.mqh`, `mt5/artifacts/ASC_CurrentFocusWriter.mqh`, and `mt5/artifacts/dossier/ASC_DossierComposer.mqh` for whether visible surface labels match the actual publication and ownership boundaries.  
4. Current Truth Seeker control files that still embed RUN050-era proof language, especially `TRUTH_SEEKER_RUN_TEMPLATE.md`, `TRUTH_SEEKER_WORKER_GUIDE.md`, and `TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`.  
5. The proof-debt mapping between `source_supported_runtime_unobserved`, `pre_patch_live_proven_post_patch_unproven`, `retained_last_good`, and `stale_claim`, with special attention to whether runtime artifacts or controls still overstate what is current.

The first research target for Report 3 should be this question: **when an artifact is retained, stale, source-supported-only, or state-derived, does every operator-facing surface say that in the same way, or do some surfaces still sound current/clean?**