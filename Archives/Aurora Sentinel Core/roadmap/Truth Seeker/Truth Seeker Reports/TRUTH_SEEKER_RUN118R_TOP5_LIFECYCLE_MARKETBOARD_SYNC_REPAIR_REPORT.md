# TRUTH SEEKER RUN118R — TOP5 LIFECYCLE + MARKET BOARD SYNC REPAIR REPORT

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN118R / TOP5PERBUCKET ACTIVE-SET PRUNE + STAGING CLEAR + 20-MIN MARKET BOARD SYNC.

Run type: live-gap source repair / code edit / performance cleanup / control update / no-live.

Proof boundary: `top5_lifecycle_marketboard_sync_source_patched_live_unproven`.

## 2. OPERATOR SNAPSHOT

| Item | Verdict |
|---|---|
| source patched | yes |
| Top5 cadence corrected to 20 min | yes — constants moved to 1200 sec |
| Market Board / Top5 snapshot sync patched | yes — proof tokens added and source uses committed L4 / Market Board row source only |
| active stale child repair patched | yes — Top5-only archive-then-remove active cleanup after staging validation |
| staging clear/idle state patched | yes — staging is no longer promoted mirror; successful publish clears child files |
| archive lifecycle patched | yes — previous active is archived before active replace |
| trader chat Market Board-to-Dossier proof added | yes |
| selected symbol live data preserved | yes — Current Focus, selected Dossier, Deep Analysis owners untouched |
| performance cleanup patched | yes — unchanged snapshot/cadence rebuild skip preserved and cadence widened to L4 1200 sec |
| root all-symbol dossier reduction preserved | yes |
| file deletion performed | source patch allows Top5-only active/staging child cleanup after archive/promote; no broad deletion |
| biggest remaining risk | live proof needed to confirm MQL5 file deletion/copy behavior on the broker terminal filesystem |
| next live proof target | RUN119R live proof of exact active set, staging idle, archive, and Market Board sync |
| protected areas not touched | FileIO, HUD, rank/order/formula, L3/L4 scoring, strategy/execution, heartbeat/lane law |

## 3. INPUT ZIP / LIVE OUTPUT INTAKE SUMMARY

| Input | Type | Status |
|---|---|---|
| `Aurora Sentinel Core(380).zip` | source/control package | extracted and inspected |
| `Upcomers-Server(114).zip` | runtime output | not present inside uploaded package in this chat; operator statement used as live-gap evidence |
| RUN117/RUN116/RUN115/RUN114/RUN113 reports | source reports | present and inspected by path/name |
| active source owners | MQL5 source | inspected and patched |

## 4. UPDATED RUN117 LIVE GAP ABSORPTION

| Live Finding | Evidence | Meaning | RUN118 Action |
|---|---|---|---|
| Top5 active bucket files exist | operator supplied runtime summary | family exists | preserve family |
| Top5 `_staging` bucket files also exist | operator supplied runtime summary | staging acting as mirror | stage-only child writes and clear after promote |
| Top5 archive timestamp folders exist | operator supplied runtime summary | archive began materializing | convert to previous-active archive-on-promote |
| manifest target 20 vs active around 43 | operator supplied runtime summary | stale active children retained | Top5-only archive-then-remove active children |
| rank #1–#3 deep-sized | operator supplied runtime summary | depth parity mostly solved | do not alter deep rank policy |
| rank #4–#5 shallow/deep_pending | operator supplied runtime summary | expected policy | preserved |
| root Dossier reduction appears successful | operator supplied runtime summary | do not restore all-symbol root spam | constants untouched |
| GlobalTop10 exists | operator supplied runtime summary | must preserve | no formula/order/cadence change |
| Market Board exists | operator supplied runtime summary | source-of-workflow | add sync proof tokens |
| FunctionResults proof tokens exist | prior source/report | must extend not remove | FunctionResults detail extended |
| Top5 timing must be 20 minutes | operator authority | 600 sec was wrong | constants moved to 1200 sec |

## 5. ROADMAP AUTHORITY CHECK

Operator statement took priority over prior RUN117 marker-only repair. RUN118R converted the live evidence into a service-layer repair without touching FileIO, HUD, formulas, strategy, execution, or heartbeat/lane law.

## 6. INTERNET RESEARCH CONVERSION TABLE

| Research Area | Source | Finding | RUN118 Repair Constraint | Patch Impact |
|---|---|---|---|---|
| File sandbox / `FILE_COMMON` | Official MQL5 FileOpen/File Functions docs | MQL5 file work is confined to terminal/common files; write opens can create subfolders | keep all file paths inside existing common-file helpers and server root | no FileIO rewrite |
| File move/copy/delete | Official MQL5 FileMove/FileDelete/Folder docs | file operations are scoped by local/shared folder flags; folder delete requires empty folders | delete only Top5 child files after archive, never broad folders | Top5-only stale active prune + staging clear |
| File durability | Official MQL5 FileFlush/FileClose docs | `FileClose` flushes eventually; frequent `FileFlush` may affect speed | do not add per-child flush churn; keep atomic writer helpers | performance-safe |
| Timer queue | Official MQL5 EventSetTimer/OnTimer docs | timer events do not queue if one is already pending/processing | reduce write churn; do not cause repeated Top5 rebuilds | Top5 cadence aligned to 1200 sec |
| StringFormat / compile safety | Official MQL5 StringFormat docs | format placeholders must match parameters | bounded strings and simple concatenation preferred | no giant format rewrites |

## 7. MARKET BOARD / TOP5 SNAPSHOT SYNC AUDIT

| Sync Item | Source Evidence | Current Risk | Patch |
|---|---|---|---|
| Market Board bucket Top5 source | `ASC_Top5BucketBuildRows` consumes publication shortlist or committed L4 rows | Top5 can look independently refreshed if cadence differs | Top5 cadence now 1200 sec |
| L4 committed snapshot | `committed_l4_*` fields | proof was implicit | snapshot ids emitted |
| Top5 row build source | existing L4 rows only | no formula issue | preserved |
| bucket signature | `ASC_Top5BucketSignature` | source identity lacked board/l4 proof tokens | sync tokens added |
| Market Board file publish cadence | constants = 60 sec | could be confused with membership refresh | proof says republish uses committed L4 |
| L4 compute cadence | constants = 1200 sec | correct | preserved |
| Top5 build cadence | was 600 sec | wrong | changed to 1200 sec |
| source_run_id / snapshot id | Version + manifest | insufficient | market/l4/top5 snapshot tokens added |
| child Dossier identity | child payload | proof lacked lookup policy | lookup path added |
| manifest symbols list | bucket/family manifest | active extras not exposed | active actual/stale counts added |
| active child files | runtime live gap | stale extras persisted | archive-then-remove active patch |

## 8. TOP5 TIMING / CADENCE PATCH

| Component | Old Cadence | New Cadence | Patch |
|---|---:|---:|---|
| Top5PerBucket membership | 600 | 1200 | `ASC_TOP5_PER_BUCKET_REFRESH_CADENCE_SEC`, `ASC_TOP5_BUCKET_CADENCE_SEC` |
| `top5_per_bucket_refresh_cadence_sec` | 600 | 1200 | Scanner/manifest token updated |
| `top5_membership_refresh_cadence_sec` | absent | 1200 | added |
| Market Board publish | 60 | 60 | preserved |
| L4 shortlist refresh | 1200 | 1200 | preserved |
| GlobalTop10 | 300 | 300 | preserved |

## 9. TOP5 STAGING LIFECYCLE REPAIR

| Lifecycle Step | Current Source Behavior | Correct Behavior | Patch |
|---|---|---|---|
| active stable while building | child promoted immediately | stage first, promote after validation | `ASC_Top5BucketWriteChild` now stages only |
| staging target | `_staging/<bucket>` | temporary only | staging manifest says clear-after-promote |
| validate staged family | weak/implicit | required before active replace | `ASC_Top5BucketStageFamilyComplete` |
| archive old active | marker/copy only | previous active archived before replace | `ASC_Top5BucketArchiveAndDeleteActiveChildren` |
| active replace/prune | stale extras retained | exact active set | archive-then-remove + promote |
| promote staged | per child immediate | final family operation | `ASC_Top5BucketPromoteStagedFamily` |
| clear staging | no | yes after success | `ASC_Top5BucketClearStagingChildren` |
| failure state | unclear | retain failed staging for debug | final staging phase distinguishes failure |

## 10. ACTIVE SET EXACTNESS / STALE CHILD PRUNE

| Bucket | Target Children | Active Children | Stale Extras | Patch |
|---|---:|---:|---:|---|
| canonical Top5 bucket dirs | manifest target | counted at runtime | counted as `actual-target` | archive then remove from active after stage validation |

Tokens added: `top5_active_child_target_count`, `top5_active_child_actual_count`, `top5_active_stale_child_count`, `top5_active_stale_children_archived`, `top5_active_set_exact`, `top5_active_prune_policy=archive_then_remove_from_active`, `top5_no_broad_file_deletion=true`.

## 11. STAGING CLEAR / IDLE STATE

| Staging State | When Used | Expected Files | Patch |
|---|---|---|---|
| refresh | batch in progress | child files under `_staging/<bucket>` | stage-only writes |
| cleared_after_promote | successful finalization | no child files; manifest may remain | staging cleanup helper |
| failed_retained_for_debug | validation/promotion failure | retained staged payloads | finalization failure branch |

## 12. ARCHIVE LIFECYCLE REPAIR

| Archive Requirement | Source Evidence | Patch |
|---|---|---|
| archive materialized | RUN117 marker writer | preserved |
| archive previous active | active children copied before deletion | added active archive-then-remove helper |
| archive only after new target validation | stage validation gate | added finalize sequence |
| skip duplicate churn | cadence/snapshot gate | Top5 1200 sec cadence and existing duplicate-decision skip retained |
| no broad deletion | helper only visits canonical Top5 bucket/staging dirs | protected |

## 13. TRADER CHAT WORKFLOW PROOF CONTRACT

| Market Board Symbol | Bucket | Expected Dossier Path | Exists / Pending | Verdict |
|---|---|---|---|---|
| bucket Top5 symbols | bucket slug | `Top5PerBucket/<bucket>/<symbol>.txt` | manifest tokenized | source proof added |
| GlobalTop10 symbols | global | `GlobalTop10/<symbol>.txt` | unchanged | preserved |

## 14. SELECTED SYMBOL LIVE DATA PATH

| Selected-Symbol Data Path | Source Evidence | Preserved? | Patch |
|---|---|---:|---|
| Current Focus | owner file untouched | yes | none |
| selected/current root Dossier | constants still enabled | yes | none |
| Dossier composer | untouched | yes | none |
| Deep Analysis trigger | existing Top5 rank 1–3 queue preserved | yes | no formula change |
| Market Board selection path | board writer untouched | yes | lookup proof only |
| HUD dependency | HUD untouched | yes | none |

## 15. PROOF SURFACE PATCH

| Proof Surface | Token | Patch |
|---|---|---|
| FunctionResults | cadence/snapshot/active/staging/lookup tokens | extended decision detail |
| Scanner Status | `top5_per_bucket_refresh_cadence_sec=1200` | token updated |
| Artifact Bundle Manifest | indirect via version/control unchanged | not directly patched |
| Top5 family manifest | all RUN118 sync/lifecycle tokens | extended |
| Top5 bucket manifests | snapshot/lookup tokens | extended |
| staging manifest | `staging_state=cleared_after_promote` | patched |
| archive manifest | phase/reason now receives final lifecycle result | patched call path |
| child Dossier identity | stage-only write still carries identity | preserved |

## 16. SAFE PERFORMANCE CLEANUP PATCH

| Performance Cleanup Candidate | Source Evidence | Patch? | Why Safe |
|---|---|---:|---|
| avoid Top5 rebuild before committed L4 cadence | old cadence 600 vs L4 1200 | yes | membership now aligns to L4; no formula/order change |
| skip archive duplicate churn | existing cadence/decision skip | yes | archive only in finalize path after stage validation |
| skip staging permanent mirror | live gap | yes | staging cleared after promote |
| avoid deep attempts for rank #4–#5 | existing policy | preserved | no extra L5 load |
| throttle counts to manifest/finalize | source patch | yes | counts only in Top5 service manifest/proof path |

## 17. PERMANENT PERFORMANCE / EFFICIENCY SIDE AUDIT

Performance side patch is real: Top5 no longer rebuilds at 10-minute cadence against a 20-minute committed L4 authority; child promotion is batched after validation, staging is cleared, and active stale file accumulation is bounded.

## 18. PATCH CANDIDATE MATRIX

| Candidate | Decision | Reason |
|---|---|---|
| service-layer Top5 cadence | patched | safe and required |
| stage-only child writes | patched | fixes mirror/current confusion |
| archive-then-remove active stale | patched | Top5-only cleanup allowed |
| FileIO rewrite | rejected | not required |
| HUD work | rejected | not dependency blocker |
| ranking/order changes | rejected | forbidden |

## 19. PATCH TABLE

| File | Patch |
|---|---|
| `mt5/core/ASC_Constants.mqh` | Top5 cadence 1200, RUN118 cleanup marker, proof boundary |
| `mt5/core/ASC_Version.mqh` | RUN118 identity and next live RUN119R |
| `mt5/runtime/ASC_Dispatcher.mqh` | stage-only writes, validate/finalize, archive/prune active, clear staging, sync proof tokens |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | Top5 cadence proof token 1200 |
| active roadmap log | RUN118 entry |
| output package manifest | RUN118 package entry |
| RUN118 report | this report |

## 20. SOURCE FILES TOUCHED

- `mt5/core/ASC_Constants.mqh`
- `mt5/core/ASC_Version.mqh`
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/artifacts/ASC_ScannerStatusWriter.mqh`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_RUN118R_TOP5_LIFECYCLE_MARKETBOARD_SYNC_REPAIR_REPORT.md`

## 21. PROTECTED AREAS NOT TOUCHED

FileIO atomic contract, artifact root, GlobalTop10 rank/order/formula, Market Board order, L3 score, L4 formula, Current Focus truth ownership, HUD, strategy/execution, heartbeat cadence, scan/write/read lane law, legacy root cleanup.

## 22. STATIC COMPILE-SAFETY TABLE

| Static Compile Check | Result | Action |
|---|---|---|
| undeclared helpers | no obvious issue | helpers added before use |
| wrong parameter count | no obvious issue | existing helper signatures preserved |
| huge `StringFormat` | avoided | concatenation used for proof strings |
| unknown-to-string | bounded | `ASC_TextOrUnavailable` used |
| path-empty file operation | guarded | path checks added |
| broad destructive calls | avoided | no folder clean/delete; child-file delete only after archive |
| recursive logging | avoided | no helper calls FunctionResults except decision point |
| cadence mismatch | repaired | 1200 sec Top5 |

Compile proof is not claimed.

## 23. REGRESSION GUARD

| Guard | Verdict |
|---|---|
| FileIO rewrite | no |
| artifact root change | no |
| GlobalTop10 formula/order | no |
| Top5 rank/order | no |
| Market Board order | no |
| L3/L4 formula | no |
| Dossier/Current Focus truth ownership | no |
| HUD | no |
| strategy/execution | no |
| heartbeat/lane law | no |
| broad file deletion | no |
| legacy root cleanup | no |

## 24. TRUE ROADMAP PROGRESS UPDATE

RUN118R converts the Top5PerBucket family from marker-level archive/staging observability into a real lifecycle: stage, validate, archive previous active, promote exact target, clear staging, and prove sync against committed L4/Market Board snapshot cadence.

## 25. NEXT_PROMPT_SEED

RUN119R should live-test exact Top5 active-set count, `_staging` idle/cleared state, archive child counts, `market_board_to_top5_dossier_sync=true`, and lookup path availability for trader-chat selected symbols.

## 26. FINAL DECISION

PASS — source patch landed for Top5 20-minute cadence, Market Board/L4 sync proof, active stale child handling, staging clear/idle semantics, archive lifecycle, trader-chat lookup proof, selected-symbol preservation, and a safe performance cleanup; compile/live proof is not claimed.
