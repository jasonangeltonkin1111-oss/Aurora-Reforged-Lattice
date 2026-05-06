# RUN262R_REPORT — Lite Archive Topology Repair

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN262R / LITE ARCHIVE TOPOLOGY REPAIR WITH MANDATORY INTERNET RESEARCH — MAKE SYMBOL DATA PACK ARCHIVE MIRROR MAIN DOSSIER FAMILY-SNAPSHOT ARCHIVE SHAPE WITHOUT MAKING ARCHIVE CURRENT TRUTH
MODE: RESEARCH + AUDIT + DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN262R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN262R.zip
SOURCE BASELINE: RUN261R Main/Lite mirror contract repair
EXPECTED DECISION: TEST FIRST
```

```text
FINAL SUMMARY

RUN262R is complete as a changed-files-only source package.

Mandatory internet research was performed before patching and converted into source constraints, acceptance tests, observability requirements, and falsifiers.

The weakest premise was rejected: Lite archive topology cannot be repaired by moving, deleting, or cleaning generated folders. Archive topology must be source-owned and produced lawfully by the active writer.

Direct source inspection found Main Dossier archive topology is family-snapshot shaped:
- GlobalTop10 Main archive writes into `Dossiers/GlobalTop10/archive/<timestamp>/...` and writes `_family_manifest.txt` inside that timestamp folder.
- Top5PerBucket Main archive writes into `Dossiers/Top5PerBucket/archive/<timestamp>/<bucket>/...` and writes `_archive_manifest.txt` at `Dossiers/Top5PerBucket/archive/<timestamp>/_archive_manifest.txt`.

Direct source inspection found Lite Symbol Data Pack timestamped history diverged from Main for Top5PerBucket. The old Lite helper wrote bucket-first history as `Symbol Data Packs/archive/Top5PerBucket/<bucket>/<timestamp>/...`, which scatters a family refresh across bucket timestamp folders instead of creating one family timestamp folder with bucket children.

Patched Lite archive source owners:
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh`
- `mt5/core/ASC_Version.mqh`
- Brain Guidebooks
- `roadmap/Truth Seeker/Truth Seeker Reports/RUN262R_REPORT.md`

Exact Lite archive helper changes:
- `ASC_SymbolDataPackTimestampedHistorySlotLabel(...)` now mirrors Main archive cadence with `YYYYMMDD_HHMM` 10-minute slots rather than per-second labels.
- Added `ASC_SymbolDataPackTimestampedHistorySnapshotFolderForRoute(...)` as the family snapshot folder owner.
- `ASC_SymbolDataPackTimestampedHistoryFolderForRoute(...)` now returns `Symbol Data Packs/archive/GlobalTop10/<timestamp>` for GlobalTop10 and `Symbol Data Packs/archive/Top5PerBucket/<timestamp>/<bucket>` for Top5PerBucket.
- `ASC_SymbolDataPackTimestampedHistoryManifestPathForRoute(...)` now writes the manifest at family snapshot level: `Symbol Data Packs/archive/<family>/<timestamp>/_archive_manifest.txt`.
- Archive envelope/manifest and active SDP payloads now expose RUN262 topology contract fields, source run/version labels, family snapshot scope, and non-current truth boundaries.

Preserved:
- `_previous_state_cache` remains separate under `Symbol Data Packs/_previous_state_cache/...`.
- Archive remains non-current truth and is explicitly not membership/ranking/Siam/current-route truth.
- FileIO unchanged.
- current/final/staging route paths unchanged.
- Dispatcher membership/rank logic unchanged.
- L3/L4, HUD, strategy, signal, trade, and risk logic untouched.
- Generated output untouched.

RUN263R bounded live proof may proceed next if MetaEditor compile is clean. Still unproven until live: actual on-disk archive refresh shape, all-symbol family snapshot count, archive manifest presence at runtime, heartbeat non-starvation, and runtime Main/Lite current parity after RUN261/RUN262.

FINAL DECISION: TEST FIRST
```

## 1. Mode Declaration

| Declaration | Answer |
|---|---|
| current run | RUN262R |
| primary mode | RESEARCH + AUDIT + DEBUG + PATCH |
| source baseline | RUN261R |
| internet research required? | yes, mandatory before patch |
| patch allowed before research ledger? | no |
| source patch allowed? | yes, Lite archive topology only |
| live test allowed? | no |
| FileIO rewrite allowed? | no |
| final path mutation allowed? | no |
| generated output editing allowed? | no |
| output folder cleanup/deletion allowed? | no |
| L3/L4 mutation allowed? | no |
| HUD patch allowed? | no |
| strategy/signal/trade/risk patch allowed? | no |
| compile transcript required if compile succeeds? | no |
| compile errors required if compile fails? | yes |
| final serious decision | TEST FIRST |

## 2. Evidence Ladder

| Evidence Item | Class | Use |
|---|---:|---|
| AI reasoning | 1 | Navigation only; proves nothing by itself. |
| User-supplied RUN262 prompt and uploaded source package | 2/3 | Prompt states scope; extracted source files establish active inspection base. |
| Direct source inspection | 3 | Establishes Main archive topology, Lite divergence, and exact patched owners. |
| Mandatory internet research | 3 for constraints only | Constrains MQL5 file behavior, provenance labels, contract visibility, retry/observability/timer boundaries. Does not prove Aurora works. |
| Static grep/diff checks | 3 | Confirms intended source changes and forbidden files untouched. |
| MetaEditor compile transcript | unavailable | No class-4 compile proof generated in this non-live source run. |
| Runtime/live output | unavailable | No live proof allowed in RUN262R. |

## 3. Mandatory Internet / External Research Conversion Ledger

| Source URL / Citation | Research Lane | Finding | Aurora Risk | Converted Coding Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|---|
| https://www.mql5.com/en/docs/files | MQL5 file behavior | MQL5 file operations are sandboxed and folder behavior depends on sanctioned file functions. | Folder surgery can hide source truth and create platform-specific false proof. | Repair source writer topology only; do not clean, delete, or move generated archives. | Package contains source/report/control files only; no generated output mutation. | Any generated archive/file cleanup is used as proof. |
| https://www.mql5.com/en/docs/files/fileopen | MQL5 FileOpen | File names can contain subfolders and write mode can create missing subfolders. | A created folder can be mistaken for current route truth. | Folder existence is not membership/rank/refresh proof; archive remains provenance only. | Payload/manifest retain non-current truth labels and no folder truth authority. | Lite derives membership/rank from archive folders. |
| https://www.mql5.com/en/docs/files/filemove | MQL5 FileMove | Move/rename has operational failure states. | Fixing archive by moving existing history can silently fail or distort provenance. | Do not use rename/move as repair; produce lawful topology from writer helpers. | Diff shows FileIO unchanged and no generated folder movement. | Patch mutates promotion/move logic or edits existing output. |
| https://www.mql5.com/en/docs/files/filedelete | MQL5 FileDelete | Delete operations can fail and destroy evidence. | Cleanup-as-repair destroys history and fakes success. | Output cleanup/deletion forbidden. | Package has no generated output deletions or edited runtime evidence. | Any generated evidence is deleted/rewritten to make shape look clean. |
| https://www.mql5.com/en/docs/check/getlasterror and https://www.mql5.com/en/docs/common/resetlasterror | MQL5 error visibility | Last errors must be surfaced/reset deliberately around risky calls. | Archive write failure becomes invisible. | Preserve existing writer atomic failure reasons; do not add unobserved FileIO behavior. | Existing `ASC_WritePublicationPayloadAtomic(...)` path remains owner of write status/reason. | New FileIO calls ignore failure/error state. |
| https://docs.open-metadata.org/latest/how-to-guides/data-contracts/spec | Data contracts | Data contracts make structure, semantics, quality, SLA/status, and ownership expectations explicit. | Archive topology drifts while outputs still look valid. | Add stable RUN262 archive topology contract fields to payload/envelope/manifest. | Required tokens enforce `sdp_archive_topology_contract_version`, topology shape, manifest scope, and current-truth false field. | Active SDP payload lacks RUN262 topology fields. |
| https://openlineage.io/docs/spec/facets/ | Lineage/facets | Lineage metadata uses stable facets attached to run/job/input/output context. | Archive provenance is buried as prose and cannot be audited. | Archive manifest/envelope must expose route family, snapshot id, publish UTC, source run, and source version. | Manifest/envelope include `archive_source_run_id` and `archive_source_version_label`. | Archive history lacks source run/version and snapshot scope. |
| https://www.w3.org/TR/prov-overview/ | Provenance | Provenance describes entities, activities, and production context used to assess quality/reliability/trust. | History is inflated into current truth. | Archive is labelled provenance/history only: not current, not membership, not ranking, not Siam/current-route reconciliation. | Manifest/envelope retain non-current truth labels. | Any archive/staging/cache route becomes current authority. |
| https://sre.google/sre-book/monitoring-distributed-systems/ | SRE monitoring | Useful monitoring must expose errors and partial failure modes, not just happy-state output. | Archive failure or topology drift becomes invisible. | Keep observable writer reason/status and add contract-visible topology labels. | Manifest and child envelope expose topology/scope; failure still returns writer reason. | Archive write fails silently or reports generic success. |
| https://sre.google/sre-book/addressing-cascading-failures/ | SRE cascading failures | Retries can amplify overload and destabilize systems. | Full-family archive retry loops can starve heartbeat. | Do not add retry loops or full-family catch-up; keep archive side-duty bounded. | Dispatcher unchanged; no scheduler/heartbeat rewrite. | Patch adds broad per-tick archive loop. |
| https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ | Bounded retries/backoff | Retries/backoff/jitter are resilience tools; retries can amplify load when careless. | Archive repair creates periodic spikes or retry storms. | Metadata/path helper repair only; no retry expansion. | No timer/dispatcher/FileIO changes. | Patch changes retry cadence, timer behavior, or bulk archive workload. |
| https://www.mql5.com/en/docs/event_handlers/ontimer and https://www.mql5.com/en/docs/event_handlers | MQL5 timer/event behavior | A program has a timer event queue; heavy timer handlers can cause missed/deferred timer work. | Archive writing starves RUN259/RUN260 heartbeat breathing. | Do not change timer lanes or add heavy per-symbol timer loops. | Dispatcher unchanged; patch limited to Lite writer path helpers and labels. | Heartbeat/timer scheduling is changed to force archive repair. |

## 4. RUN261 Baseline Accepted

| RUN261R Baseline Item | Accepted / Preserved in RUN262R |
|---|---|
| changed-files-only package law | accepted and preserved |
| no generated output included | accepted and preserved |
| no FileIO/final path/L3/L4/HUD/trade logic touched | accepted and preserved |
| Main/Lite mirror contract fields added by RUN261R | preserved |
| `main_lite_contract_version=RUN261R_main_lite_mirror_v1` | preserved |
| `lite_is_slave=true` and route/bucket/symbol/rank parity fields | preserved |
| source snapshot/publication epoch and expected/written count fields | preserved |
| folder/archive/staging truth fields false | preserved |
| archive topology explicitly deferred to RUN262R | now repaired in source topology only |
| RUN263R bounded live proof after RUN261R/RUN262R | still next if compile clean |

## 5. Main Archive Topology Audit

| Main Archive Family | Source Owner | Current Main Path Shape | Snapshot Folder Level | Contains All Symbols In One Refresh? | Manifest? | Non-current Truth Labels |
|---|---|---|---|---:|---:|---|
| GlobalTop10 | `mt5/runtime/ASC_Dispatcher.mqh` — `ASC_Top10ArchiveSnapshotDirectory(...)`, `ASC_Top10RunFullArchiveLiveFamily(...)`, `ASC_Top10RunFullWriteFamilyManifest(...)` | `Dossiers/GlobalTop10/archive/<YYYYMMDD_HHMM>/<symbol dossier files>` | route/family timestamp folder | yes, source writes all completed GlobalTop10 symbols into same `archive_dir` | `_family_manifest.txt` in timestamp folder | `archive_not_current_truth=true`, `archive_not_membership_source=true`, `archive_not_ranking_source=true`, `archive_not_siam_canonical_selection=true`, `archive_not_current_route_reconciliation_source=true` |
| Top5PerBucket | `mt5/runtime/ASC_Dispatcher.mqh` — `ASC_Top5BucketFamilyArchiveDirectory(...)`, `ASC_Top5BucketArchiveDirectory(...)`, `ASC_Top5BucketFamilyArchiveManifestPath(...)`, `ASC_Top5BucketWriteArchiveManifest(...)` | `Dossiers/Top5PerBucket/archive/<YYYYMMDD_HHMM>/<bucket>/<symbol dossier files>` | family timestamp folder, then bucket child | yes, family archive dir is timestamp-first and bucket directories are children | `_archive_manifest.txt` at `Dossiers/Top5PerBucket/archive/<timestamp>/_archive_manifest.txt` | `archive_not_current_truth=true`, `archive_not_membership_source=true`, `archive_not_ranking_source=true`, `archive_not_siam_canonical_selection=true`; Top5 payload also exposes `top5_archive_not_current_truth=true` |

Required answers:

1. Main archives GlobalTop10 at a route/family timestamp folder under `Dossiers/GlobalTop10/archive/<timestamp>/`.
2. Main archives Top5PerBucket at `Dossiers/Top5PerBucket/archive/<timestamp>/<bucket>/`, with the family manifest at timestamp level.
3. The timestamp folder is route/family level, not per-symbol. Top5 bucket folders are below the timestamp.
4. A single timestamp folder is intended to hold all symbols for that route/family refresh.
5. `_archive_manifest.txt` is written at the Top5 family timestamp folder level. GlobalTop10 uses `_family_manifest.txt` at timestamp folder level.
6. Archive non-current truth is marked by explicit labels saying archive is not current truth, membership source, ranking source, Siam canonical selection, or current route reconciliation source.
7. Lite should mirror the Main Dossier archive source owner shape exposed by `ASC_Dispatcher.mqh`, while keeping Lite content depth shallower.

## 6. Lite Archive Topology Audit

| Lite Archive Family | Current Source Owner | Current Lite Path Shape Before RUN262R | Problem | Desired Mirror Shape |
|---|---|---|---|---|
| GlobalTop10 | `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | `Symbol Data Packs/archive/GlobalTop10/<timestamp>/<symbol SDP files>` | acceptable route-level snapshot family shape, but timestamp used per-second labels rather than Main 10-minute slot cadence | `Symbol Data Packs/archive/GlobalTop10/<YYYYMMDD_HHMM>/<symbol SDP files>` |
| Top5PerBucket | `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | `Symbol Data Packs/archive/Top5PerBucket/<bucket>/<timestamp>/<symbol SDP files>` | bucket-first scatter; one family refresh is split across bucket timestamp folders and does not mirror Main | `Symbol Data Packs/archive/Top5PerBucket/<YYYYMMDD_HHMM>/<bucket>/<symbol SDP files>` |
| previous_state_cache | `ASC_SymbolDataPackPreviousStateCacheFolderForRoute(...)` | `Symbol Data Packs/_previous_state_cache/GlobalTop10/...` and `Symbol Data Packs/_previous_state_cache/Top5PerBucket/<bucket>/...` | no repair required; must remain continuity/cache only | unchanged, separate from timestamped history |
| timestamped_history manifest | `ASC_SymbolDataPackTimestampedHistoryManifestPathForRoute(...)` | followed the same folder helper, so Top5 manifest could land bucket-level | manifest did not live at family snapshot level for Top5 | `Symbol Data Packs/archive/<family>/<timestamp>/_archive_manifest.txt` |

## 7. Patch Scope Applied

| File | Patch Applied | Scope Boundary |
|---|---|---|
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | Changed Lite timestamped-history topology helpers to timestamp-first family snapshot; added snapshot-folder helper; moved manifest path to family snapshot level; added RUN262 archive topology/source labels and required checks. | Lite archive topology only. No FileIO rewrite. No current/final route mutation. |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | Added RUN262 archive topology contract constants. | Contract labels only; no runtime membership/rank authority. |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh` | Added active SDP payload fields exposing RUN262 archive topology contract. | Payload labels only; no route/rank/formula change. |
| `mt5/core/ASC_Version.mqh` | Advanced visible source identity to RUN262R and next proof to RUN263R. | Version/control metadata only. |
| Brain Guidebooks | Added RUN262 archive law amendments. | Doctrine-to-test guardrails only; no source behavior. |
| `RUN262R_REPORT.md` | Added this report. | Report only. |

## 8. Static Acceptance Tests

| Test | Required Result | RUN262R Static Result |
|---|---|---|
| Lite GlobalTop10 archive mirrors Main route snapshot topology | PASS | PASS — `archive/GlobalTop10/<timestamp>` remains route snapshot folder. |
| Lite Top5PerBucket archive uses one timestamp folder per family refresh | PASS | PASS — Top5 helper now uses `archive/Top5PerBucket/<timestamp>/<bucket>`. |
| Top5 buckets live inside timestamp folder if Main does that | PASS | PASS — bucket child appended after snapshot folder. |
| Archive manifest path is family-snapshot-level | PASS | PASS — manifest helper uses `ASC_SymbolDataPackTimestampedHistorySnapshotFolderForRoute(...)`. |
| previous_state_cache remains separate | PASS | PASS — `_previous_state_cache` helpers unchanged. |
| `archive_current_truth=false` remains | PASS | PASS — `sdp_archive_current_truth_source=false` added; existing archive non-current labels retained. |
| `archive_not_membership_source=true` remains | PASS | PASS. |
| `archive_not_ranking_source=true` remains | PASS | PASS. |
| current/final paths unchanged | PASS | PASS — no current/final path helper mutation. |
| FileIO unchanged | PASS | PASS — `mt5/io/ASC_FileIO.mqh` diff count = 0. |
| no generated output edited/deleted | PASS | PASS — diff/package contains no generated output. |
| no Main/Lite membership/rank mutation | PASS | PASS — Dispatcher membership/rank sources unchanged. |
| no L3/L4/HUD/trade changes | PASS | PASS — no related files touched. |

## 9. Next Live Acceptance Tests

| Runtime Check | Target |
|---|---|
| SDP GlobalTop10 archive snapshot | one timestamp folder containing all GlobalTop10 SDP files for the refresh |
| SDP Top5PerBucket archive snapshot | one timestamp folder containing bucket folders and all SDP files |
| archive manifest | present at snapshot folder level |
| archive labels | non-current, not membership, not ranking, not Siam/current-route truth |
| previous_state_cache | separate under `_previous_state_cache` and not current truth |
| current/final SDP routes | unchanged from RUN261 contract paths |
| Main/Lite current parity | checked from RUN261 mirror contract fields |
| heartbeat | no archive-induced starvation or timer backlog |

## 10. Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| “Archive repaired” | Lite Top5 archive still used bucket-first timestamp scatter. | Prior/expected roadmap claim shape | Direct source inspection of `ASC_SymbolDataPackWriter.mqh` pre-RUN262 | 2 | 3 | Direct source inspection outranks roadmap/claim. | Patched writer helpers to timestamp-first family snapshot shape. | No, after patch; live proof still required. |
| “Archive can be current proof” | Archive is non-current truth/history only. | Weak premise | User law, Main manifest labels, SDP archive labels | 1 | 2/3 | User law + source labels outrank premise. | Preserved and expanded non-current truth labels. | No, because patch did not make archive authority. |
| “Fix by deleting old archive folders” | Generated evidence mutation is forbidden and proves nothing about active writer topology. | Tempting repair shortcut | User law + MQL5 file behavior research + package law | 1 | 2/3 | Source-owned repair law outranks cleanup shortcut. | No generated output edited/deleted; patch changes source helpers. | No. |
| “Lite archive can differ from Main” | User Main/Lite law requires structural mirror; only content depth may differ. | Legacy Lite behavior | User law + RUN261 mirror contract + Main source topology | 1/3 for legacy behavior | 2/3 | User law and Main source topology outrank legacy Lite behavior. | Lite Top5 now mirrors Main timestamp-first family snapshot topology. | No, after patch; runtime proof remains pending. |

## 11. Package Validation Table

| Validation | Result | Notes |
|---|---|---|
| Package name | PASS | `TRUTH_SEEKER_RUN262R.zip` |
| Changed-files only | PASS | Package contains source/control/report files only. |
| Original folder layout preserved | PASS | All paths begin `Aurora Sentinel Core/...`. |
| Forbidden suffix absent | PASS | No `_2`, `(1)`, `_copy`, `final`, `fixed`, `updated`, `new`, `CHANGED_FILES_WINDOWS_SAFE`, or `REPORT_ONLY_WINDOWS_SAFE`. |
| Generated output excluded | PASS | No runtime output folders/files included. |
| FileIO unchanged | PASS | `ASC_FileIO.mqh` untouched. |
| Dispatcher unchanged | PASS | No Main membership/rank/current route mutation. |
| Constants unchanged | PASS | `ASC_Constants.mqh` untouched. |
| Guidebooks updated | PASS | RUN262 source-truth/archive law added. |
| Report included | PASS | `RUN262R_REPORT.md` included. |

## 12. Final Decision

FINAL DECISION: TEST FIRST

Reason: mandatory internet research was performed and converted; Main archive topology was identified; Lite archive topology was patched cleanly in the active SDP writer; previous_state_cache remained separate; FileIO/current/final routes/generated output/L3/L4/HUD/trade logic were untouched. The next strongest move is MetaEditor compile, then RUN263R bounded live proof if compile is clean.
