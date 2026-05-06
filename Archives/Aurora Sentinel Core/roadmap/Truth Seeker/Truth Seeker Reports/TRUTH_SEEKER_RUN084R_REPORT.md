RUN084R STATUS:
GlobalTop10 / Market Board alignment signature and stale-current guard source patch run. Next live test is RUN090R.

CURRENT BASELINE:
RUN059 / commit 796a8b6 plus RUN060R through RUN083R patched source/control and RUN080R live evidence is the active authority unless current source proves otherwise.

RUN083R RESULT TO VERIFY:
RUN083R added dossier queue anti-stall observability and Scanner Status proof tokens. RUN084R must preserve that queue proof while moving to the next live-proven failure: GlobalTop10 current-family mismatch versus fresh Market Board diversified Top10.

RUN084R PURPOSE:
Patch the smallest lawful source owner path so Market Board and GlobalTop10 share a compact alignment identity, GlobalTop10 records the board epoch/signature it was derived from, mismatch/stale-current states are labelled honestly, and RUN090 output can prove alignment without rank/order/formula changes.

PROOF BOUNDARY:
RUN084R is source-patched-live-unproven until RUN090R or later. Do not claim compile/live/runtime/output proof.

# GIT HEADER SUMMARY

```text
TRUTH SEEKER ROADMAP — RUN084R / SOURCE PATCH — GLOBALTOP10 + MARKET BOARD ALIGNMENT SIGNATURE + STALE-CURRENT GUARD
INTERNET RESEARCH REQUIRED: COMPLETED
CODE EDIT RUN: YES
LIVE TEST RUN: NO
NEXT LIVE TEST: RUN090R
DECISION: PASS — SOURCE PATCHED, LIVE UNPROVEN

PATCHED:
- mt5/runtime/ASC_Dispatcher.mqh
- mt5/artifacts/ASC_ScannerStatusWriter.mqh
- mt5/core/ASC_Version.mqh
- roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md
- roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md
- roadmap/Truth Seeker/TRUTH_SEEKER_RUN084R_REPORT.md

PROTECTED:
- GlobalTop10 ranking/order/formula
- Top3/Top5/Top10 formulas
- L3 score/weights/thresholds
- L4 rank/order/tie-breakers
- Market Board order/ranking
- FileIO
- HUD
- FunctionResults schema/per-symbol spam
- DossierWriter/Composer
- DeepSelective formulas
- strategy/execution/trade management

PROOF BOUNDARY:
- Source patched only.
- No MetaEditor compile proof claimed.
- No live/runtime/output proof claimed.
- RUN090R must prove artifact/log/status behavior.
```

# SOURCE / ROADMAP INTAKE TABLE

| Check | Result | Evidence path | Decision |
|---|---|---|---|
| Source package found | yes | `/mnt/data/Aurora Sentinel Core(326).zip` | continue |
| Compile root found | yes | `mt5/AuroraSentinelCore.mq5` | continue |
| RUN083R report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN083R_REPORT.md` | continue |
| RUN083R patched source verified | yes | `ASC_Dispatcher.mqh`, `ASC_RuntimeState.mqh`, `ASC_ScannerStatusWriter.mqh`, `ASC_Version.mqh` | continue |
| RUN082R report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN082R_REPORT.md` | continue |
| RUN080R live failure evidence found | partial | operator supplied in RUN084R header; no RUN080R report file found | use as repair authority |
| roadmap(7) package found | yes | `roadmap/Truth Seeker/*` | continue |
| Active phase identified | yes | active RUN084R source-hardening lane, next live RUN090R | continue |
| Dispatcher found | yes | `mt5/runtime/ASC_Dispatcher.mqh` | patched owner |
| RuntimeState found | yes | `mt5/core/ASC_RuntimeState.mqh` | inspected, no edit needed |
| Market Board writer found | yes | `mt5/artifacts/ASC_MarketBoardWriter.mqh` | inspected/protected |
| GlobalTop10 owner found | yes | `mt5/runtime/ASC_Dispatcher.mqh` | patched owner |
| Scanner Status writer found | yes | `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | patched evidence surface |
| FunctionResults owner found | yes | `mt5/logging/ASC_FunctionResults.mqh` | no schema/spam edit |
| DossierWriter/Composer found | yes | `mt5/artifacts/ASC_DossierWriter.mqh`; `mt5/artifacts/dossier/ASC_DossierComposer.mqh` | read-only/protect |
| FileIO found | yes | `mt5/io/ASC_FileIO.mqh` | read-only/protect |
| HUD found | yes | `mt5/hud/ASC_HUD_Manager.mqh` | read-only/protect |

# RESEARCH CONVERSION TABLE

| Research item | Finding | Source repair constraint | Patch/check target | RUN090 acceptance test | Forbidden misuse |
|---|---|---|---|---|---|
| MQL5 OnTimer/EventSetTimer | Timer work is event-driven through the existing EA timer; avoid creating extra timer lanes for metadata proof. | Alignment proof must be cheap metadata inside existing cadence/service path. | `ASC_Dispatcher.mqh` | FunctionResults detail has one compact aggregate token; no new lane. | no new timer, blocking loop, or all-symbol recompute |
| MQL5 FileFlush/FileOpen/FileMove | Flush/write churn can affect operation speed; keep existing atomic writer/FileIO path. | Do not rewrite FileIO or add extra flush/write churn. | `ASC_WritePublicationPayloadAtomic` callers only | Changed files exclude FileIO; manifest/children use existing writer. | no FileIO rewrite |
| Provenance / manifest identity | Provenance should identify what artifact was derived from what source/activity. | GlobalTop10 must record derived-from Market Board signature/epoch. | family manifest + child payload | RUN090 grep: `Derived From Board Signature`, `derived_from_board_signature`. | no formula/rank change |
| Risk-based smoke/regression | Test the highest-impact proof seam quickly. | RUN090 must validate status/artifact/log tokens, not rerun broad audits. | Scanner Status + manifest + FunctionResults | compare current board signature vs derived signature. | no broad live/test spam |
| Stale-current dashboard semantics | Current surfaces must label stale/mismatch when source has moved. | Clean-current requires matching signatures; mismatches become pending refresh/mismatch. | `alignment_status`, stale-current guard strings | Scanner Status shows mismatch/pending instead of clean current when signatures differ. | no hiding unknown/uncertain risk |

# RUN083R FINISH-STATE VERIFICATION TABLE

| RUN083R finish item | Present? | Gap? | RUN084R patch decision |
|---|---:|---|---|
| Scanner Status exposes dossier_queue_state | yes | none | preserved |
| Scanner Status exposes dossier_queue_cursor | yes | line exists as Dossier Queue Cursor | preserved |
| attempted/success/failure/stall/recovered counts | yes | none | preserved |
| FunctionResults detail carries compact queue tokens | yes | not edited | preserved |
| avoids FunctionResults schema drift | yes | no schema edit | preserved |
| avoids FileIO edits | yes | no FileIO edit | preserved |
| avoids HUD edits | yes | no HUD edit | preserved |
| avoids formula/rank/order edits | yes | no formula owner edited | preserved |
| preserves RUN082 deferred L5 labels | yes | tokens still present | preserved |
| remains source_patched_live_unproven | yes | no live proof claimed | preserved |

# ALIGNMENT OWNER MAP TABLE

| Alignment item | Owner file/function | Current behavior | Gap | Patch decision |
|---|---|---|---|---|
| Market Board visible Top10 source | `ASC_Dispatcher.mqh` / `ASC_Top10RunFullBuildSnapshot` | reads lawful diversified rank 1-10 symbols | no formula change needed | protected |
| Market Board signature/epoch | `ASC_Dispatcher.mqh` / new `ASC_Top10RunFullBoardSignature` | previously only symbol signature | explicit board epoch/build/run missing | patched |
| GlobalTop10 family signature | `ASC_Top10RunFullBuildFamilyManifest` | carried source signature | not explicitly board-derived | patched |
| GlobalTop10 derived_from_board signature | family manifest + child payload | missing explicit field | proof gap | patched |
| alignment_status | Runtime state + manifest | runtime status existed; manifest lacked explicit token | artifact proof gap | patched |
| stale-current label | Reconcile cadence hold | stale existed but less decisive | mismatch/pending label needed | patched |
| Scanner Status proof | `ASC_ScannerStatusWriter.mqh` | no board/top10 signature comparison lines | proof gap | patched |
| FunctionResults proof | `ASC_Top10RunFullBatchTrace` | aggregate batch trace existed | lacked signature pair | patched by aggregate detail only |

# MARKET BOARD SIGNATURE TABLE

| Signature item | Source field | Included? | Why |
|---|---|---:|---|
| Board epoch | `market_board_last_publish_utc` fallback to board publish/shortlist/L4 pass | yes | proves source timing/epoch |
| Visible Top10 order | `ASC_Top10RunFullSnapshotSignature` | yes | proves diversified Top10 identity without recalculation |
| Build identity | `ASC_VERSION_LABEL` | yes | binds proof to source version |
| Run identity | `ASC_TRUTH_SEEKER_CURRENT_RUN` | yes | binds proof to RUN084R |
| Formula/rank values | existing `rank` only | no new formula | avoids selection drift |

# GLOBALTOP10 DERIVED-FROM TABLE

| Family/child item | New proof field | Meaning | RUN090 evidence |
|---|---|---|---|
| `_family_manifest.txt` | `Board Signature` | board-derived signature used for family | grep manifest |
| `_family_manifest.txt` | `Derived From Board Signature` | exact board signature family claims as source | compare to Scanner Status |
| `_family_manifest.txt` | `alignment_status` | clean current requires signature match | grep manifest |
| child payload | `derived_from_board_signature` | child derived-from proof | grep child |
| child payload | `source_epoch_utc` | source epoch carried to child | grep child |
| child payload | `stale_current_guard` | child cannot self-claim clean current | grep child |

# ALIGNMENT STATUS TABLE

| Status | Meaning | Allowed use | Forbidden misuse |
|---|---|---|---|
| `aligned_cadence_hold` | current family derived signature matches current board signature while cadence holds | clean current claim allowed | may not ignore child publication failures |
| `alignment_mismatch_pending_refresh` | Market Board signature moved while retained GlobalTop10 is still old | label retained family as stale/pending | may not call clean current |
| `cadence_refresh_queued` | refresh admitted for new board truth | pending refresh | may not force formula/order |
| `refresh_in_progress` | staging child family in progress | pending proof | may not delete useful prior live family |
| `completed_stale_vs_current_shortlist` | completed from older source versus current source | stale/degraded proof | may not hide mismatch |
| `source_unavailable` | no lawful snapshot | unknown/unavailable | may not fabricate alignment |

# SCANNER STATUS / FUNCTIONRESULTS EVIDENCE TABLE

| Evidence token | Current behavior | Patch decision | Spam risk |
|---|---|---|---|
| Scanner Status alignment status | missing | added one line | low |
| Scanner Status alignment reason | missing | added one line | low |
| Scanner Status board signature | missing | added one line | low |
| Scanner Status derived signature | missing | added one line | low |
| Scanner Status family cursor | partial elsewhere | added compact line | low |
| FunctionResults batch trace | aggregate only | appended board/derived signatures | low; no per-symbol rows |

# RUN083 / RUN082 REGRESSION GUARD TABLE

| Prior repair | Still intact? | Evidence |
|---|---:|---|
| RUN083 dossier_queue_state | yes | `ASC_ScannerStatusWriter.mqh` still writes state |
| RUN083 cursor/attempt/success/failure | yes | existing lines preserved |
| RUN083 stall/recovered/last symbol/reason | yes | existing lines preserved |
| RUN082 deferred pending labels | yes | `deep_hydration_pending`, `deep_completed: no` still present |
| RUN082 terminal degraded labels | yes | existing deferred terminal helpers unchanged |
| RUN081 budget guard | yes | `RUN081R_GLOBALTOP10_CHILD_DEEP_DEFER` still present |

# PROTECTED FORMULA / ORDER DRIFT TABLE

| Protected area | Touched? | Drift? | Evidence |
|---|---:|---:|---|
| GlobalTop10 formula/order | no | no | snapshot rank collection untouched except signature wrapper |
| Top3/Top5/Top10 formulas | no | no | no shortlist/score formula edit |
| L3 score | no | no | no L3 file edit |
| L4 rank/order | no | no | no L4 formula file edit |
| Market Board order | no | no | MarketBoardWriter not edited |
| FileIO | no | no | FileIO not edited |
| HUD | no | no | HUD not edited |
| FunctionResults schema | no | no | FunctionResults file not edited |

# PATCH CANDIDATE MATRIX

| File | Candidate patch | Why needed | Risk | Chosen/rejected |
|---|---|---|---|---|
| `ASC_Dispatcher.mqh` | board signature + derived-from guard | GlobalTop10 owner already holds family manifest/path/cadence | low/moderate | chosen |
| `ASC_MarketBoardWriter.mqh` | emit separate board signature | tempting but risks board rendering churn/order surface | medium | rejected/protected |
| `ASC_RuntimeState.mqh` | new fields | possible but existing fields sufficient | compile risk | rejected |
| `ASC_ScannerStatusWriter.mqh` | expose proof tokens | RUN090 artifact proof needed | low | chosen |
| `ASC_FunctionResults.mqh` | schema/token expansion | not necessary; aggregate detail can be extended upstream | schema/spam risk | rejected |
| `ASC_FileIO.mqh` | write path changes | not needed | high | rejected/protected |
| HUD | surface label | forbidden | high | rejected/protected |

# PATCH TABLE

| File | Function/area | Patch made | Why truthful | Compile-risk note |
|---|---|---|---|---|
| `mt5/runtime/ASC_Dispatcher.mqh` | `ASC_Top10RunFullBoardSignature` | added compact board epoch + visible Top10 + build/run signature | compares exact board/top10 identity, not ranking | uses existing string/datetime helpers |
| `mt5/runtime/ASC_Dispatcher.mqh` | family manifest builder | added Board Signature, Derived From Board Signature, alignment_status, stale_current_guard | manifest now states its source truth | required tokens expanded only |
| `mt5/runtime/ASC_Dispatcher.mqh` | cadence hold logic | mismatch becomes `alignment_mismatch_pending_refresh` | prevents stale-current clean claim | status string only |
| `mt5/runtime/ASC_Dispatcher.mqh` | deferred child payload | adds derived_from/source_epoch/alignment/stale guard tokens | child carries source proof cheaply | no deep loop added |
| `mt5/runtime/ASC_Dispatcher.mqh` | FunctionResults detail source | batch trace appends current/derived signatures | one aggregate token, no schema row | no FunctionResults schema edit |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | status output | added alignment status/reason/signature/cursor lines | RUN090 can prove from artifact | required tokens expanded only |
| `mt5/core/ASC_Version.mqh` | version identity | RUN084R label/run/proof macros | control identity updated | macro-only |

# STATIC COMPILE-SAFETY TABLE

| Check | Result | Evidence |
|---|---|---|
| New helper names unique | pass | grep shows only RUN084R helper definitions/calls |
| Existing GlobalTop10 snapshot order untouched | pass | rank loop unchanged |
| FileIO untouched | pass | no FileIO diff |
| HUD untouched | pass | no HUD diff |
| FunctionResults schema untouched | pass | no FunctionResults file diff |
| Required tokens consistent | pass | manifest and Scanner Status tokens expanded |
| No live proof claimed | pass | report/proof boundary states source-patched-live-unproven |

# PROOF-DEBT UPDATE TABLE

| Proof item | Before RUN084R | After RUN084R | RUN090 proof action |
|---|---|---|---|
| Market Board signature | implicit symbol signature only | explicit board signature/epoch/build/run | compare Scanner Status to manifest |
| GlobalTop10 derived-from | source signature, not explicit board field | `Derived From Board Signature` + child token | grep family and child payload |
| stale-current guard | weaker stale cadence status | `alignment_mismatch_pending_refresh` | force/observe board move before top10 refresh |
| FunctionResults proof | batch trace without signature pair | compact signature pair in existing detail | inspect aggregate log row |
| Scanner Status proof | queue only | queue + alignment proof | inspect Scanner Status |
| live proof | absent | still absent | RUN090 |

# NEXT_PROMPT_SEED TABLE

| Next run | Must read first | Primary target | Known proof debt | Must not do |
|---|---|---|---|---|
| RUN085R | RUN084R report; active log; manifest; `ASC_Dispatcher.mqh`; Scanner Status output owner | next highest source-hardening proof seam after alignment identity | RUN084R source-patched-live-unproven; RUN090 must prove signatures | no live request; no formula/order/rank/FileIO/HUD/strategy; no FunctionResults spam |

# FINAL DECISION TABLE

| Decision item | Result |
|---|---|
| Decision | PASS |
| Source patch | yes |
| Live proof | no |
| Compile proof | no |
| Output proof | no |
| Next live checkpoint | RUN090R |
| Changed-files zip required | yes |

# FINAL SUMMARY

```text
RUN:
RUN084R

DECISION:
PASS — source patch landed; live proof remains pending until RUN090R.

RUN TYPE:
- code edit: yes
- live output requested: no
- compile/live proof claimed: no
- next live checkpoint: RUN090R

RUN083R ABSORPTION:
- RUN083R report read: yes
- RUN083R patched source verified: yes
- queue tokens preserved: yes
- remaining proof debt: runtime/live/output proof still pending until RUN090R

ALIGNMENT VERDICT:
- Market Board signature: added compact board epoch + visible Top10 + build/run signature
- GlobalTop10 derived-from signature: added to family manifest and child payloads
- alignment_status: added to family manifest and Scanner Status
- stale/current guard: clean current now requires matching signatures
- mismatch handling: mismatch labelled alignment_mismatch_pending_refresh / stale-current, not clean current
- formula/order drift: none

EVIDENCE VERDICT:
- Scanner Status tokens: added
- FunctionResults tokens: aggregate detail only; no schema drift
- family manifest tokens: added
- child tokens: added
- RUN090 proof value: can compare Scanner Status current board signature to family/child derived_from_board_signature

PROTECTED AREAS:
- RUN083 dossier queue tokens: preserved
- RUN082 deferred L5 labels: preserved
- GlobalTop10 formula: untouched
- L3 score: untouched
- L4 rank/order: untouched
- Market Board order: untouched
- FileIO: untouched
- HUD: untouched
- FunctionResults spam/schema: no schema edit; aggregate token only
- strategy/execution: untouched

PATCHES:
- ASC_Dispatcher.mqh / GlobalTop10 family manifest — board signature, derived-from signature, alignment_status, stale_current_guard — no formula/order drift
- ASC_Dispatcher.mqh / cadence hold — mismatch becomes pending_refresh/stale-current — no formula/order drift
- ASC_Dispatcher.mqh / deferred child payload — derived_from_board_signature/source_epoch/alignment guard tokens — no deep loop drift
- ASC_Dispatcher.mqh / batch trace — aggregate current/derived signature proof — no schema/per-symbol spam
- ASC_ScannerStatusWriter.mqh / Scanner Status — alignment status/reason/current board/derived signature lines — artifact proof only
- ASC_Version.mqh / version identity — RUN084R source-patched-live-unproven identity

PROOF STATUS:
- Source: patched
- Static compile-safety: inspected only
- Compile: not claimed
- Live: not claimed
- Output: not claimed
- Post-patch proof: pending RUN090R

NEXT_PROMPT_SEED:
- next run: RUN085R
- first files/output to read: RUN084R report, active log, output manifest, ASC_Dispatcher.mqh, ASC_ScannerStatusWriter.mqh, ASC_Version.mqh
- primary target: next source-hardening proof seam without reopening alignment formula/order
- proof debt to preserve: RUN084R alignment signature; RUN083 queue tokens; RUN082 deferred L5 labels
- forbidden drift: no rank/score/order/FileIO/HUD/strategy/execution/FunctionResults schema spam

ZIP:
changed-files package produced with original folder layout.
```
