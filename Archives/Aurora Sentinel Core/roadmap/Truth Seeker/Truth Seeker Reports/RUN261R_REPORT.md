# RUN261R_REPORT — Main/Lite Mirror Contract Repair

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN261R / MAIN-LITE MIRROR CONTRACT REPAIR WITH MANDATORY INTERNET RESEARCH — MAKE SYMBOL DATA PACK LITE DUPLICATE MAIN DOSSIER ROUTE LAYOUT, BUCKETS, SYMBOL SET, RANK ORDER, REFRESH EPOCH, AND BLOCKER TRUTH WHILE CONTENT DEPTH ALONE DIFFERS
MODE: RESEARCH + AUDIT + DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN261R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN261R.zip
SOURCE BASELINE: RUN260R Manifest + Scanner Status required-token poison completion
EXPECTED DECISION: TEST FIRST
```

```text
FINAL SUMMARY

RUN261R is complete as a changed-files-only source package.

Mandatory internet research was performed before patching and converted into coding constraints, acceptance tests, telemetry requirements, falsifiers, and forbidden patch patterns.

The weakest premise was rejected: Lite cannot be fixed by merely publishing more files. Lite must mirror Main's source-owned family plan.

Direct source inspection found Main Dossier route/family truth is owned by Dispatcher/Dossier current publication lanes:
- GlobalTop10 Main plan comes from `ASC_Top10RunFullBuildSnapshot(...)`, `state.top10_run_full_last_completed_symbols`, and the committed shortlist/L4 recovery path.
- Top5PerBucket Main plan comes from `ASC_Top5BucketBuildRows(...)` into `state.top5_bucket_queue_symbols`, `state.top5_bucket_queue_slugs`, `state.top5_bucket_queue_ranks`, and related family/bucket manifest fields.

Direct source inspection found Lite already had partial Main-source consumption, but the child payload contract did not explicitly expose the full Main/Lite mirror law: route family parity, bucket parity, symbol parity, rank/order parity, expected/written counts, source snapshot, publication epoch, slave status, and blocker/degraded truth.

Patched source owners:
- `mt5/core/ASC_Version.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh`
- `mt5/runtime/ASC_Dispatcher.mqh`
- `roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md`
- `roadmap/Truth Seeker/Guidebooks/AURORA_GUIDEBOOK_INDEX.md`
- `roadmap/Truth Seeker/Truth Seeker Reports/RUN261R_REPORT.md`

Added contract behavior:
- `main_lite_contract_version=RUN261R_main_lite_mirror_v1`
- `lite_is_slave=true`
- Main/Lite route family, bucket, symbol, rank/order parity fields
- `source_snapshot_id` and `publication_epoch`
- `main_expected_count`, `lite_expected_count`, `lite_written_count`
- `mirror_status` and `mirror_blocker_reason`
- explicit `content_depth_difference_only=true`
- explicit no-folder/no-archive/no-staging truth fields
- required-token validation for those contract fields on every active SDP child payload
- Dispatcher blocker/deferred reasons now carry the same Main/Lite mirror contract fields when Main family plan is unavailable, empty, queue-invalid, or timer budget-deferred.

Lite still does not compute independent membership. Lite consumes:
- GlobalTop10: Main completed-symbol snapshot or committed shortlist/L4 recovery snapshot.
- Top5PerBucket: Main-owned `state.top5_bucket_queue_symbols/slugs/ranks`.

Preserved:
- Main Dossier ranking/membership unchanged.
- FileIO unchanged.
- Final paths unchanged.
- Archive topology unchanged and deferred to RUN262R.
- HUD unchanged.
- L3/L4 formula/ranking/membership unchanged.
- Strategy/signal/trade/risk logic untouched.
- Generated output untouched.

RUN262R is still required for archive topology repair. RUN263R remains the bounded live proof after RUN261R/RUN262R.

Remaining unproven until live: actual recurring runtime publication parity, exact on-disk Main/Lite child counts, exact symbol set parity, exact rank/order parity, blocker propagation in runtime output, and MetaEditor compile transcript-level proof.

FINAL DECISION: TEST FIRST
```

## 1. Mode Declaration

| Declaration | Answer |
|---|---|
| current run | RUN261R |
| primary mode | RESEARCH + AUDIT + DEBUG + PATCH |
| source baseline | RUN260R |
| internet research required? | yes, mandatory before patch |
| patch allowed before research ledger? | no |
| source patch allowed? | yes, Main/Lite mirror contract only |
| live test allowed? | no |
| archive topology patch allowed? | no, deferred to RUN262R |
| FileIO rewrite allowed? | no |
| final path mutation allowed? | no |
| generated output editing allowed? | no |
| output folder cleanup/deletion allowed? | no |
| L3/L4 ranking/order/formula/membership mutation allowed? | no |
| HUD patch allowed? | no |
| Dossier architecture rewrite allowed? | no |
| SDP broad architecture rewrite allowed? | no |
| strategy/signal/trade/risk patch allowed? | no |
| final serious decision | TEST FIRST |

## 2. Evidence Ladder

| Evidence Item | Class | Use |
|---|---:|---|
| AI reasoning | 1 | Navigation only; proves nothing by itself. |
| Uploaded/source package inspection | 3 | Establishes active source baseline and patched files. |
| Internet research | 3 for constraints only | Constrains contract, provenance, file/timer/reliability behavior; does not prove Aurora works. |
| Static source grep/token checks | 3 | Confirms contract text appears in intended source paths and forbidden files were not changed. |
| MetaEditor compile transcript | unavailable | No Class 4 compile proof supplied or generated in this run. |
| Runtime/live output | unavailable | No live proof allowed in RUN261R. |

## 3. Mandatory Internet / External Research Conversion Ledger

| Source URL / Citation | Research Lane | Finding | Aurora Risk | Converted Coding Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|---|
| https://docs.open-metadata.org/latest/how-to-guides/data-contracts/spec | Data contracts | Data contracts formalize producer/consumer agreement, structure, quality, and SLA/status expectations. | Main/Lite can visually drift while both appear valid. | SDP must expose a machine-readable mirror contract: producer/consumer role, route family, bucket, symbol, rank, snapshot, epoch, counts, and blocker status. | SDP child payload contains RUN261 mirror fields and writer required tokens enforce them. | Any SDP child lacks `main_lite_contract_version`, expected counts, rank parity, source snapshot, or blocker fields. |
| https://docs.open-metadata.org/v1.12.x/api-reference/data-contracts | Data contracts/API | Contract validation and status concepts make violations explicit rather than silent. | Partial Lite output silently passes. | Partial output must show `mirror_status` and `mirror_blocker_reason`; validation must reject missing contract tokens. | Missing RUN261 token causes writer payload validation failure instead of silent publication. | Writer required-token list is weakened, empty, or not emitted by active composer. |
| https://openlineage.io/docs/spec/facets/ | Lineage facets | Facets carry structured metadata with stable names and schema meaning. | Main/Lite lineage fields become ad-hoc prose. | Use stable RUN261 field names and a contract version. | Fields use fixed key names and `RUN261R_main_lite_mirror_v1`. | Contract names drift or are renamed without compatibility note. |
| https://openlineage.io/docs/spec/facets/run-facets/ | Run lineage | Run facets describe a specific execution/run instance. | Runtime publication epoch/snapshot cannot be tied to a refresh. | Expose `source_snapshot_id` and `publication_epoch`. | Payload includes both fields. | Payload cannot distinguish source snapshot/epoch from folder timestamp/archive. |
| https://openlineage.io/docs/spec/facets/job-facets/ | Job lineage | Job facets describe the producing process/job. | Lite may look like owner instead of consumer. | Expose `lite_is_slave=true` and `membership_source=main_committed_family_plan`. | Payload and reasons identify Lite as slave/projection. | Any code path labels SDP as rank/membership owner. |
| https://www.w3.org/TR/prov-overview/ | Provenance | Provenance is information about entities, activities, and people involved in producing data. | Archive/staging/cache can be mistaken for current truth. | Explicitly mark folder/archive/staging truth sources false. | Payload emits `folder_truth_source=false`, `archive_truth_source=false`, `staging_truth_source=false`. | Folder/current/archive scanning becomes membership source. |
| https://www.mql5.com/en/docs/files | MQL5 file sandbox | MQL5 files are scoped to sandbox/common folders. | Repair by deleting/moving folders can mask source truth and create platform-specific failures. | Do not repair parity by folder cleanup/deletion or FileIO rewrite. | Diff shows no FileIO changes and no generated output mutation. | Patch changes `ASC_FileIO.mqh`, deletes output, or derives truth from folders. |
| https://www.mql5.com/en/docs/files/fileopen | MQL5 FileOpen | FileOpen can create folders when writing. | Accidental folder creation could be mistaken for proof of membership. | Folder existence is never membership truth. | Contract says `folder_truth_source=false`; Lite consumes Main arrays. | Lite infers expected symbols/buckets from folders. |
| https://www.mql5.com/en/docs/files/filemove | MQL5 FileMove | Move/rename can fail and requires explicit handling. | Promotion/renaming repair could hide partial mirror failure. | Leave FileIO/promotion unchanged; expose blockers instead. | No FileIO/final path diffs. | Patch mutates move/promote path logic to fake parity. |
| https://www.mql5.com/en/docs/files/filedelete | MQL5 FileDelete | Delete returns false on failure and is scoped. | Cleanup-as-repair can destroy evidence and hide divergence. | No output cleanup/deletion. | Package contains source/report only, no generated output. | Any generated output deleted/edited as proof. |
| https://www.mql5.com/en/docs/check/getlasterror and https://www.mql5.com/en/docs/common/resetlasterror | MQL5 error visibility | Last error must be explicitly observed/reset around risky calls. | New writer behavior could hide FileIO failures. | Do not add new FileIO calls; preserve existing observable writer reasons. | No FileIO rewrite. | New calls ignore failure/error state. |
| https://www.mql5.com/en/docs/event_handlers/ontimer and https://www.mql5.com/en/docs/event_handlers | Timer/event behavior | Only one timer event queues per program; heavy loops can starve refresh. | Main/Lite mirror work could undo RUN259/RUN260 breathing repairs. | Keep existing one-child-per-beat/bounded write lanes; add metadata only. | Dispatcher still writes one SDP child per due lane and defers near budget. | Patch adds full-family per-tick rewrite loop. |
| https://sre.google/sre-book/monitoring-distributed-systems/ | SRE monitoring | Monitoring should answer what is broken and why. | Lite failure remains invisible. | Blocker/degraded reason must explain exact Main plan/budget/queue failure. | Deferred/blocked reasons include `mirror_status` and `mirror_blocker_reason`. | Failure reason says generic unavailable without source/blocker fields. |
| https://sre.google/sre-book/addressing-cascading-failures/ | Graceful degradation | Graceful degradation intentionally reduces work/quality with visible state. | Partial Lite can cascade into false confidence. | Partial Lite is degraded/blocked truth, not pass. | Contract exposes expected/written counts and blocker status. | Fewer Lite children than Main with no blocker/degraded field. |
| https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ | Bounded retries/backoff | Retries can amplify load; jitter/backoff spread pressure. | Mirror retry loop can starve heartbeat. | Preserve existing due/heartbeat/budget defers; do not force immediate full mirror catch-up. | Budget defers remain pending and explicit. | Patch retries all missing children immediately in one beat. |

## 4. RUN260 Baseline Accepted

RUN260R source identity was accepted as the baseline:

| Field | RUN260R Value Observed | RUN261R Action |
|---|---|---|
| `ASC_VERSION_LABEL` | `RUN260R-ManifestScannerStatusRequiredTokenPoisonCompletion` | advanced to RUN261R |
| `ASC_TRUTH_SEEKER_CURRENT_RUN` | `RUN260R` | advanced to RUN261R |
| `ASC_TRUTH_SEEKER_OUTPUT_PACKAGE_NAME` | `TRUTH_SEEKER_RUN260R.zip` | advanced to RUN261R |
| RUN260 scope | Manifest/Scanner Status required-token poison cleanup | preserved; not reopened |

## 5. Main Dossier Architecture Audit

Actual Dossier composer/contracts exist under `mt5/artifacts/dossier/`, not at the older requested flat paths. Active Main route/family execution was found in `mt5/runtime/ASC_Dispatcher.mqh` and Dossier/current folder constants.

| Main Route Family | Source Owner | Route Folder | Bucket Logic | Symbol Source | Rank/Order Source | Snapshot/Epoch Field | Current Status/Blocker Field |
|---|---|---|---|---|---|---|---|
| GlobalTop10 | `ASC_ServiceTop10RunFullPublication`, `ASC_Top10RunFullBuildSnapshot`, completed snapshot state | `Dossiers/GlobalTop10` via `ASC_GlobalTop10LiveDirectory(...)` | not bucketed | `state.top10_run_full_last_completed_symbols` or snapshot from `publication_shortlist_rows`/`committed_l4_rows` | rank 1..10 from snapshot placement / row rank | `state.top10_run_full_last_completed_source_signature`, board epoch/signature helpers | family alignment status/reason, child written/failed counts, manifest body |
| Top5PerBucket | `ASC_Top5BucketBuildRows`, `ASC_ServiceTop5BucketPublication`, queue/family manifest helpers | `Dossiers/Top5PerBucket/<bucket>` | `ASC_ClassificationEffectiveMainBucketId`, active bucket arrays | `state.top5_bucket_queue_symbols` | `state.top5_bucket_queue_ranks` | `ASC_Top5BucketSnapshotId(state)`, `ASC_Top5BucketExactSignature(state)` | `top5_bucket_active_*`, family/bucket manifest state, queue guard reason |

Required answers:

1. GlobalTop10 children are decided by source-owned completed-symbol snapshot or a lawful shortlist/L4 recovery snapshot.
2. Top5PerBucket children are decided by `ASC_Top5BucketBuildRows(...)` and stored in source-owned queue arrays.
3. GlobalTop10 symbols are carried by `state.top10_run_full_last_completed_symbols` / snapshot rows; Top5 symbols by `state.top5_bucket_queue_symbols`.
4. GlobalTop10 rank/order is carried by snapshot rank placement; Top5 rank/order by `state.top5_bucket_queue_ranks`.
5. Bucket membership is owned by `state.top5_bucket_queue_slugs` plus active bucket metadata.
6. Publication epoch/snapshot is exposed through GlobalTop10 source signature/board epoch and Top5 `ASC_Top5BucketSnapshotId(state)`.
7. Final route paths resolve through Main Dossier helpers/constants; not touched.
8. Blockers are recorded in family alignment status/reason, queue guard reason, and publication status/reason fields.
9. Yes, the plan can be shared with Lite without folder scraping; it is already in runtime state arrays.

## 6. Lite Symbol Data Pack Audit

| Lite Route Family | Current Source Owner | Current Symbol Source | Current Rank/Order Source | Current Folder Logic | Difference from Main | Patch Needed |
|---|---|---|---|---|---|---|
| GlobalTop10 | `ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication` + SDP writer/composer | `state.top10_run_full_last_completed_symbols` or `ASC_Top10RunFullBuildSnapshot` fallback | cursor+1 from source snapshot order | `Symbol Data Packs/GlobalTop10/<symbol>_SYMBOL_DATA_PACK.txt` | content is lighter; contract fields incomplete | add explicit mirror contract fields and required-token validation |
| Top5PerBucket | `ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication` + SDP writer/composer | `state.top5_bucket_queue_symbols/slugs/ranks` | `state.top5_bucket_queue_ranks` | `Symbol Data Packs/Top5PerBucket/<bucket>/<symbol>_SYMBOL_DATA_PACK.txt` | content is lighter; contract fields incomplete | add explicit mirror contract fields and blocker/degraded reason propagation |

Required answers:

1. Lite consumes Main/source-owned family state for both active routes.
2. Lite now exposes the same/lawfully mirrored snapshot/epoch fields in child payloads.
3. Lite now exposes expected counts and written count projection in child payloads/reasons.
4. Lite now emits blockers when Main family plan is unavailable, empty, queue-invalid, or budget-deferred.
5. Partial Lite output is no longer contract-silent; expected/written/blocker fields are visible.
6. Folder logic remains path projection only, not membership truth.
7. Lite does not rank/order independently; RUN261 threads Main rank/order values through Dispatcher.
8. Lite does not use archive/staging/current folder scanning as truth.
9. Family manifest path helpers exist, but RUN261 did not add broad manifest publication. Contract parity is enforced in active child payloads and runtime blocker reasons.
10. Exact owners patched: SDP contracts/composer/writer and Dispatcher callsites.

## 7. Main/Lite Contract Implemented

Implemented fields:

| Field | Implemented? | Location |
|---|---|---|
| `main_lite_contract_version=RUN261R_main_lite_mirror_v1` | yes | contracts/composer/writer/dispatcher reasons |
| `lite_is_slave=true` | yes | contracts/composer/writer/dispatcher reasons |
| `main_route_family`, `lite_route_family`, `route_family_match` | yes | composer payload |
| `main_bucket`, `lite_bucket`, `bucket_match` | yes | composer payload |
| `main_symbol`, `lite_symbol`, `symbol_match` | yes | composer payload |
| `main_rank`, `lite_rank`, `rank_order_match` | yes | composer payload, Dispatcher callsite values |
| `source_snapshot_id`, `publication_epoch` | yes | composer payload, Dispatcher callsite values |
| `main_expected_count`, `lite_expected_count`, `lite_written_count` | yes | composer payload, writer reason, Dispatcher callsite values |
| `mirror_status`, `mirror_blocker_reason` | yes | composer payload, writer reason, Dispatcher blocked/deferred reasons |
| `content_depth_difference_only=true` | yes | composer payload + required token |
| `membership_source=main_committed_family_plan` | yes | composer payload + required token |
| `folder_truth_source=false` | yes | composer payload + required token |
| `archive_truth_source=false` | yes | composer payload + required token |
| `staging_truth_source=false` | yes | composer payload + required token |

## 8. Current Folder Layout Law

Preserved target shape:

| Family | Main Current Shape | Lite Current Shape | RUN261 Status |
|---|---|---|---|
| GlobalTop10 | `Dossiers/GlobalTop10/<rank/symbol dossier files>` | `Symbol Data Packs/GlobalTop10/<matching symbol SDP files>` | contract projected; paths unchanged |
| Top5PerBucket | `Dossiers/Top5PerBucket/<bucket>/<symbol dossier files>` | `Symbol Data Packs/Top5PerBucket/<bucket>/<matching symbol SDP files>` | contract projected; paths unchanged |

File naming remains artifact-specific. Dossier names and SDP `_SYMBOL_DATA_PACK` names may differ, but symbol identity and route membership must match.

## 9. Patch Scope Applied

| File | Change |
|---|---|
| `mt5/core/ASC_Version.mqh` | Advanced active identity/package to RUN261R and added RUN261 scope/boundary/summary/evidence constants. |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | Added RUN261 mirror contract constants and archive-deferred/no-folder-truth rules. |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh` | Added mirror contract parameters and payload fields. |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | Added required tokens, threaded contract params through dry-run/publish path, and surfaced mirror fields in writer reason. |
| `mt5/runtime/ASC_Dispatcher.mqh` | Threaded Main-owned rank/count/snapshot values into Lite writes and added blocked/deferred mirror reasons. |
| Guidebook index/coding brain | Added durable Main/Lite mirror law. |
| `RUN261R_REPORT.md` | Added full report. |

Forbidden files/surfaces were not patched: FileIO, final path helpers, generated output, HUD, L3/L4 formula/ranking, strategy/signal/trade/risk.

## 10. Static Acceptance Tests

| Test | Required Result | PASS / FAIL |
|---|---|---|
| Lite consumes Main/source-owned family plan | yes | PASS |
| Lite does not compute independent membership | yes | PASS |
| Lite does not use folders/archive/staging as membership source | yes | PASS |
| GlobalTop10 expected count mirrors Main | yes | PASS — `total` threaded as Main/Lite expected count |
| Top5PerBucket expected bucket list mirrors Main | yes | PASS — source is `state.top5_bucket_queue_slugs` |
| Top5PerBucket symbol set mirrors Main | yes | PASS — source is `state.top5_bucket_queue_symbols` |
| Rank/order projected from Main/source plan | yes | PASS |
| Same source_snapshot_id exposed where available | yes | PASS |
| Same/lawfully mirrored publication_epoch exposed where available | yes | PASS |
| Partial Lite output emits blocker/degraded truth | yes | PASS |
| Missing Lite bucket when Main bucket exists is impossible or explicitly blocked | yes | PASS by Main queue guard + exact bucket projection |
| Main Dossier ranking/membership unchanged | yes | PASS |
| FileIO unchanged | yes | PASS |
| final paths unchanged | yes | PASS |
| archive topology unchanged/deferred | yes | PASS |
| HUD unchanged | yes | PASS |
| L3/L4 unchanged | yes | PASS |
| no signal/trade/risk language | yes | PASS |

## 11. Runtime Acceptance for Next Live Test

RUN263R must prove these at runtime after RUN262R archive topology repair or explicit operator override:

| Runtime Check | Target |
|---|---|
| GlobalTop10 Main count | 10 or explicit source-owned blocker |
| GlobalTop10 Lite count | same as Main or same blocker |
| GlobalTop10 symbol set | exact match |
| GlobalTop10 rank/order | exact match |
| Top5 crypto Main/Lite | exact match or same blocker |
| Top5 energy Main/Lite | exact match or same blocker |
| Top5 fx Main/Lite | exact match or same blocker |
| Top5 indices Main/Lite | exact match or same blocker |
| source_snapshot_id | same where emitted |
| publication_epoch | same or lawfully mirrored |
| Lite partial silent output | zero allowed |
| folder-derived membership | zero allowed |
| archive/current truth leak | zero allowed |
| signal/trade/risk permission | false |

## 12. Archive Deferred RUN262 Plan

RUN261 audited archive enough to plan, but did not patch archive topology.

| Archive Family | Current Main Shape | Current Lite Shape | Desired Shape | Source Owner | RUN262 Patch Plan |
|---|---|---|---|---|---|
| GlobalTop10 | Main has current family route and archive/history helpers under Dossier route | SDP has previous-state cache plus timestamped history helpers | one timestamp folder per route/family refresh containing all symbols | Dossier/Dispatcher source snapshot + SDP archive writer | create source-owned family snapshot archive topology without making archive current truth |
| Top5PerBucket | Main has bucket/family manifests and child queues | SDP timestamped path is per route/bucket/symbol slot | one timestamp folder per family refresh with bucket subfolders and all symbols | Top5 source queue arrays | mirror Main family snapshot archive shape for Lite after current/final parity proof |
| previous_state_cache | continuity fallback only | continuity fallback only | remain previous-final continuity, not membership truth | writer lifecycle | preserve; do not promote to current truth |
| timestamped_history | comparison evidence | comparison evidence | family-refresh snapshot history | route service + writer | bounded nonblocking archive write with explicit role labels |

## 13. Brain Guidebook / Doctrine Patch Result

Patched, non-ornamental rules added:

- Lite mirrors Main route layout, bucket folders, symbol set, rank/order, snapshot/epoch, and blocker truth.
- Lite content may be lighter, but structure and membership cannot drift.
- Writers cannot use current/final/staging/archive folders as membership source.
- Partial Lite output is failure unless explicitly degraded/blocked.
- Current/final mirror repair and archive topology repair remain separate gates.

## 14. Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| Lite mirrors Main | Prior observed runtime/source evidence showed partial/missing Lite output | User law / architecture intent | Source audit + prior live evidence context | 2 | 3 | Source/runtime evidence outranks intent | RUN261 adds explicit contract fields and blockers; RUN263 must prove runtime | TEST FIRST |
| Lite should publish independently | Lite is slave to Main | Possible tempting repair premise | User law + source-owned family plan | 1 | 3 | Source-owned Main plan wins | Lite continues consuming Main arrays/snapshot only | no, patched |
| Folders show truth | Source-owned family plan is truth | Existing folder layout temptation | Data contract/provenance research + source law | 1 | 3 | Source contract wins | Payload now says folder/archive/staging truth false | no, patched |
| Archive can fix mirror | Current/final mirror must be fixed first | RUN247/RUN262 archive context | RUN261 scope + source audit | 2 | 3 | Current source scope wins | Archive topology deferred to RUN262 | no, deferred |
| Main/Lite can wait until live | Source contract violation must be repaired before live | Momentum/live-test pressure | RUN261 prompt + source audit | 1 | 3 | Source contract wins | Patch contract now; live proof later | TEST FIRST |

## 15. Package Validation Table

| Validation | Result |
|---|---|
| Changed-files-only package | PASS |
| Preserved `Aurora Sentinel Core/...` layout | PASS |
| Package name exactly `TRUTH_SEEKER_RUN261R.zip` | PASS |
| No `_2`, copy, fixed, updated, new suffix | PASS |
| No generated output packaged | PASS |
| No FileIO/HUD/L3/L4/generated output diffs | PASS |
| RUN261 required-token count | PASS — 26 RUN261 mirror tokens added and composer emits them |
| Internet research ledger present | PASS |
| MetaEditor compile transcript | NOT SUPPLIED / NOT CLAIMED |
| Runtime/live proof | NOT RUN / NOT CLAIMED |

## 16. Final Decision

TEST FIRST
