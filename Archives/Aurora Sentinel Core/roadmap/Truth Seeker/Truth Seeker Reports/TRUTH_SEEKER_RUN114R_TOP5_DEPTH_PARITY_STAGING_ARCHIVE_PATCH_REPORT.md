# TRUTH SEEKER RUN114R — TOP5PERBUCKET DEPTH PARITY + STAGING/ARCHIVE SOURCE PATCH REPORT

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN114R / TOP5PERBUCKET DEPTH PARITY + STAGING/ARCHIVE SOURCE PATCH — MAKE TOP5 RANK 1–3 MATCH GLOBALTOP10-STYLE DEEP DOSSIERS, KEEP RANK 4–5 DEEP_PENDING, ADD FAMILY/BUCKET STAGING-ARCHIVE CONTRACTS, AND PATCH SAFE PERFORMANCE CLEANUP

RUN TYPE: SOURCE PATCH / TOP5 DEPTH PARITY / STAGING-ARCHIVE / PERFORMANCE CLEANUP / CONTROL UPDATE / NO-LIVE

PROOF BOUNDARY: `top5_depth_parity_staging_archive_source_patched_live_unproven`

COMPILE CLAIM: not claimed; MetaEditor compile evidence was not supplied or produced in this source-patch environment.

LIVE CLAIM: not claimed; RUN114R did not request live output.

## 2. OPERATOR SNAPSHOT

| Field | Result |
|---|---|
| source patched | yes |
| Top5 100KB root cause identified | yes |
| Top5 rank #1–#3 depth parity patched | yes — rank #1–#3 now queues existing Deep Selective Analysis owner and overwrites child through the canonical Dossier composer when completed |
| Top5 rank #4–#5 deep_pending preserved | yes |
| staging/archive patched | yes — child writes stage then promote; previous active children are copied to archive without delete |
| performance cleanup patched | yes — rank #4–#5 deep attempts are gated; manifest/proof tokens identify skip state |
| RUN113 root Dossier policy preserved | yes |
| file deletion performed | no RUN114 delete path added; Top5 stale-child cleanup changed to archive-copy/no-delete contract |
| biggest remaining risk | static-only source verification; rank #1–#3 deep attachment requires live deep-owner scheduling proof |
| next run target | RUN115R / telemetry-logging reduction + Top5/root dossier performance hardening |
| protected areas not touched | FileIO atomic contract, artifact root, GlobalTop10 formula/order, Top5 rank/order, Market Board order, L3/L4 formulas, HUD, strategy/execution, heartbeat/lane law |

## 3. INPUT ZIP / FILE INTAKE SUMMARY

| Input | Intake Result | Notes |
|---|---|---|
| `Aurora Sentinel Core(375).zip` | extracted | single active source/control root: `Aurora Sentinel Core/` |
| package type | source/control package | contains `mt5/`, `roadmap/`, root control docs, and archive material |
| nested roots | inspected | no second source root selected |
| runtime output | not present as live output package | screenshots/operator statement used as evidence for file-size symptom |
| RUN113R report/source | present | read and absorbed before patch |
| RUN111R live proof report | present | used to understand Top5 live family proof and file-size symptom |
| RUN112R design report | present | used as depth/cadence design authority |

## 4. RUN113R ABSORPTION

| RUN113R Item | Verified In Source? | Must Preserve? | RUN114 Action |
|---|---:|---:|---|
| root all-symbol Dossier gate | yes | yes | preserved |
| selected/current preserved | yes | yes | untouched |
| Current Focus preserved | yes | yes | untouched |
| GlobalTop10 preserved | yes | yes | untouched |
| Top5PerBucket preserved | yes | yes | patched only family writer/depth contract |
| cadence constants | yes | yes | unchanged: Top5 remains 600s |
| proof tokens | yes | yes | extended with RUN114 tokens |
| performance side audit template | yes | yes | kept active |
| no file deletion | yes | yes | RUN114 converts Top5 stale cleanup to archive-copy/no-delete |
| no FileIO/HUD/formula/rank/execution drift | yes | yes | protected |

## 5. ROADMAP AUTHORITY CHECK

Operator instruction outranked report assumptions: Top5 files were live-present but shallow. RUN113 source was preserved as the output-reduction baseline. RUN111/RUN112 were used as supporting evidence, not authority to change rank/order/formulas.

## 6. INTERNET RESEARCH CONVERSION TABLE

| Research Area | Source | Finding | RUN114 Source Constraint | Patch Impact |
|---|---|---|---|---|
| FileOpen subfolders / sandbox | Official MQL5 `FileOpen` / file docs | file names can contain subfolders; MQL5 file operations are sandbox-controlled | use existing server-root/FileIO contracts; do not change artifact root | Top5 uses existing path contracts and atomic helper |
| FileFlush/FileClose durability/speed | Official MQL5 `FileFlush` docs | frequent flushing can affect operation speed | reduce churn rather than rewrite FileIO | no FileIO rewrite; bounded child promotion only |
| FileMove/FileDelete/FolderCreate/FolderClean/FolderDelete | Official MQL5 file/folder docs | delete/clean are destructive or path-sensitive | no broad destructive cleanup | Top5 stale active children are archive-copied, not deleted |
| OnTimer/EventSetTimer | Official MQL5 timer docs | timers are event-driven and should not be overloaded by long work | preserve heartbeat/cadence and one-child write-beat | rank #1–#3 queues deep owner; rank #4–#5 does not start deep work |
| StringFormat/helper declarations | current MQL5 source patterns | large formatters increase compile risk | use small helper functions and concatenated tokens | no large variadic `StringFormat` proof block added |

## 7. TOP5 VS GLOBALTOP10 DEPTH COMPARISON

| Feature | GlobalTop10 Child | Top5PerBucket Child | Difference | Patch |
|---|---|---|---|---|
| child writer | deep trigger writes completed payload to staging then promotes | queued Top5 writer composed pseudo deep-pending payload directly | Top5 never attached real deep result | rank #1–#3 now queues existing deep owner with `top5_per_bucket:` origin |
| Dossier composer call | `ASC_BuildCanonicalDossierPayload(..., ASC_DOSSIER_MODE_DEEP_OVERRIDE, true, deep_result, ...)` | same composer, but with artificial `deferred_deep` | composer path same; payload source not same | completed deep path now writes Top5 child when deep owner returns |
| deep result object | real `ASC_DeepSelectiveAnalysisResult` | initialized deferred placeholder | root cause of shallow size | fixed for rank #1–#3 post deep-owner completion |
| staging | GlobalTop10 has staging/current/archive | Top5 direct active child write | no Top5 staging boundary | Top5 child writes to `_staging/<bucket>/` then promotes active |
| archive | GlobalTop10 archives prior current family | Top5 deleted stale child files | destructive cleanup + no archive | Top5 cleanup now archive-copies previous active children and does not delete |
| rank/order | uses existing overall Top10 order | uses existing bucket rank from L4/Market Board | both consumer-only | unchanged |
| manifest | family manifest | family + bucket manifests | Top5 lacked depth/staging tokens | tokens added |

## 8. TOP5 100KB ROOT CAUSE

| Root Cause Candidate | Source Evidence | Likely? | Patch |
|---|---|---:|---|
| shallow Dossier mode | Top5 used `ASC_DOSSIER_MODE_DEEP_OVERRIDE`, so not pure shallow mode | no | no mode change |
| no Deep Selective Analysis payload copied | Top5 passed `deferred_deep` with `deep_completed: no` | yes | rank #1–#3 queues existing deep owner |
| rank #1–#3 marked deep eligible but not populated | hydration class said L0-L6 while payload appended `deep_pending=true` | yes | split honest pending vs attached tokens |
| composer receives empty/default deep result | source initializes `ASC_DeepInitResult(deferred_deep)` | yes | completed deep branch added |
| required tokens validate shallow payload | required token included `deep_pending=true` | yes | attached branch requires `deep_pending=false` + attached tokens |
| rank #4–#5 intentional L0–L4 | hydration class says deep pending | yes | preserved |
| queue writes before deep data available | Top5 writer is one-child writer, not deep engine | yes | queues deep owner without blocking |
| GlobalTop10 separate deep path not reused | Top10 origin branch already owns deep child write | yes | RUN114 adds Top5 origin branch to same completed composer flow |

## 9. TOP5 DEPTH PARITY PATCH

| Rank Class | Current Behavior | RUN114 Behavior | Proof Token |
|---|---|---|---|
| rank #1–#3 | L0–L4 + deferred pseudo-deep payload | writes honest pending child, queues existing deep owner, then completed deep branch overwrites child via canonical composer | `top5_rank_1_3_deep_attempted=`, `top5_rank_1_3_deep_attached=` |
| rank #4–#5 | L0–L4 + deep_pending | unchanged and explicitly gated from deep attempts | `top5_rank_4_5_deep_pending=true` |
| all bucket children | direct active write | stage then promote to active | `top5_staging_enabled=true`, `top5_promote_after_validate=true` |

## 10. TOP5 STAGING / ARCHIVE PATCH

| Staging/Archive Feature | Patch Now? | Source Owner | Risk |
|---|---:|---|---|
| family `_staging/` path token | yes | Dispatcher Top5 helpers/manifest | low |
| family `archive/` path token | yes | Dispatcher Top5 helpers/manifest | low |
| bucket `_staging/<bucket>/` child write | yes | `ASC_Top5BucketWriteChild` | medium; live proof needed |
| bucket archive copy | yes | Top5 cleanup helper | medium; no delete means stale active extras may remain until future cleanup policy |
| destructive cleanup | no | protected | avoided |

## 11. TOP5 REFRESH / TIMING SAFETY

| Timing Rule | Source Evidence | Patch / Guard |
|---|---|---|
| Top5 cadence remains 600s | `ASC_TOP5_BUCKET_CADENCE_SEC=600` | unchanged |
| one-child/write-beat remains | `ASC_TOP5_BUCKET_MAX_CHILD_QUEUE_PER_BEAT=1` | unchanged |
| rank #1–#3 deep bounded | single existing deep trigger field; queue only if idle | no all-bucket L5 dump |
| rank #4–#5 gated | branch only queues if `bucket_rank <= 3` | performance cleanup |
| UI/near-budget yield | service checks UI priority and write-budget before work | unchanged |
| heartbeat/lane law | no timer or lane constants touched | preserved |

## 12. PROOF SURFACE PATCH

| Proof Surface | Token | Source Patch |
|---|---|---|
| FunctionResults aggregate | `top5_depth_parity_state=`, `run114_safe_cleanup_patch=` | Dispatcher policy tokens |
| Scanner Status | same policy tokens | Scanner Status writer |
| family manifest | staging/archive/depth tokens | Top5 family manifest |
| bucket manifest | bucket staging/archive readiness | Top5 bucket manifest |
| child Dossier pending | `deep_pending=true`, queue reason, expected size class | Top5 child writer |
| child Dossier attached | `deep_pending=false`, attached tokens | completed deep Top5 branch |

## 13. SAFE PERFORMANCE CLEANUP PATCH

| Performance Cleanup Candidate | Source Evidence | Patch? | Why Safe |
|---|---|---:|---|
| avoid rank #4–#5 deep attempt | Top5 ranks are already known in queue | yes | prevents unnecessary heavy deep owner work; preserves deep_pending truth |
| avoid repeated direct active writes without staging | direct write path existed | yes | staging/promotion gives clearer validation boundary |
| avoid file deletion churn | Top5 stale cleanup used `FileDelete` | yes | archive-copy/no-delete avoids destructive cleanup and preserves evidence |
| reduce manifest spam | not fully safe without live telemetry | no | deferred to RUN115 |

## 14. PERMANENT PERFORMANCE / EFFICIENCY SIDE AUDIT

Performance remains a mandatory side patch. RUN114 landed a real cleanup by gating rank #4–#5 deep work and converting stale cleanup away from delete churn. RUN115 should target telemetry/log volume and manifest rewrite pressure.

## 15. DEPENDENCY SAFETY CHECK

| Dependency | Risk | Source Guard |
|---|---|---|
| GlobalTop10 | accidental formula/order change | no GlobalTop10 ranking/formula touched |
| Top5PerBucket rank/order | accidental rerank | queue source unchanged; only write/depth behavior patched |
| Market Board order | accidental board mutation | no Market Board owner touched |
| Current Focus | deep origin stealing selected symbol | Top5 origin now treated like batch-owned and does not set HUD selected symbol |
| selected/current Dossier | explicit deep branch drift | Top5 origin returns before selected/current pair write |
| root all-symbol gate | re-enabled root churn | RUN113 constants preserved |
| HUD | read-only law | no HUD files touched |
| FunctionResults | proof token bloat | bounded token additions only |
| Scanner Status | missing proof | policy helper extended |
| continuity/last-good | archive semantics incomplete | archive-copy readiness added; no destructive cleanup |
| explicit Deep Analysis | selected symbol flow | untouched for non-Top5 origins |

## 16. PATCH CANDIDATE MATRIX

| Candidate | Decision | Reason |
|---|---|---|
| direct full deep inside Top5 writer | rejected | would create a second deep owner and overload one-beat queue |
| reuse existing deep trigger owner | accepted | aligns with GlobalTop10-style composer path |
| make rank #4–#5 full deep | rejected | unnecessary load and contrary to requested pending policy |
| physical delete stale Top5 files | rejected | no file deletion boundary |
| FileIO rewrite | rejected | forbidden and unnecessary |

## 17. PATCH TABLE

| File | Patch |
|---|---|
| `mt5/core/ASC_Constants.mqh` | RUN114 constants and proof tokens |
| `mt5/core/ASC_Version.mqh` | version/current run bumped to RUN114R |
| `mt5/runtime/ASC_Dispatcher.mqh` | Top5 staging/archive helpers, Top5 deep origin, child pending/attached tokens, rank #1–#3 queue, rank #4–#5 gate, archive-copy cleanup |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | RUN114 Scanner Status policy tokens |
| roadmap/control files | report/log/manifest updated |

## 18. SOURCE FILES TOUCHED

- `mt5/core/ASC_Constants.mqh`
- `mt5/core/ASC_Version.mqh`
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/artifacts/ASC_ScannerStatusWriter.mqh`
- `roadmap/Truth Seeker/TRUTH_SEEKER_RUN114R_TOP5_DEPTH_PARITY_STAGING_ARCHIVE_PATCH_REPORT.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`

## 19. PROTECTED AREAS NOT TOUCHED

FileIO atomic contract, artifact root, GlobalTop10 rank/order/formula, Top5 rank/order, Market Board order, L3 score, L4 rank formula, Dossier/Current Focus truth ownership, HUD, strategy/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP, heartbeat cadence, scan/write/read lane law.

## 20. STATIC COMPILE-SAFETY TABLE

| Static Compile Check | Result | Action |
|---|---|---|
| identifier length | pass by inspection | used compact helper names |
| helper declared before use | pass by local ordering for Top5 writer branch; MQL source still requires MetaEditor proof | live compile still required |
| huge `StringFormat` | pass | used concatenation for new tokens |
| FileIO signature change | pass | none |
| wrong Dossier composer args | pass | reused existing call signature |
| array required-token bounds | pass by inspection | resized before added tokens |
| rank/order formulas | pass | no ranking owner touched |
| destructive file calls added | pass | no new delete; Top5 cleanup converted to archive-copy |

## 21. REGRESSION GUARD

No FileIO rewrite, artifact root change, GlobalTop10 formula/order change, Top5 rank/order change, Market Board order change, L3/L4 formula change, Dossier/Current Focus ownership drift, HUD work, strategy/execution, heartbeat cadence change, lane law change, or RUN114 file deletion.

## 22. TRUE ROADMAP PROGRESS UPDATE

RUN114R closes the source-level Top5 depth parity gap: shallow Top5 files were expected from pending payloads, and rank #1–#3 now has a path to completed deep payloads through the existing deep owner. RUN115 should reduce telemetry/logging/file-churn pressure and verify Top5 archive/staging live behavior.

## 23. NEXT_PROMPT_SEED

RUN115R / TELEMETRY-LOGGING REDUCTION + TOP5/ROOT DOSSIER PERFORMANCE HARDENING. Read RUN114 report/source first, then inspect FunctionResults/Scanner Status/manifest write frequency. Patch low-risk log/manifest churn only; preserve depth parity, rank/order, formulas, FileIO contract, HUD, strategy/execution, heartbeat/lane law, and no deletion.

## 24. FINAL DECISION

PASS — source patch landed, Top5 100KB root cause identified, rank #1–#3 depth parity routed through the existing deep owner, rank #4–#5 pending preserved, staging/archive source support added, performance cleanup landed, and protected areas remained untouched. Compile/live proof is not claimed.
