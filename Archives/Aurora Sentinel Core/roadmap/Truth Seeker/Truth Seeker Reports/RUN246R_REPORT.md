# GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN246R / GLOBALTOP10 FINAL ROUTE PUBLICATION RESTORATION — RESTORE DOSSIER AND SYMBOL DATA PACK GLOBALTOP10 FINAL ARTIFACTS WITHOUT BREAKING TOP5PERBUCKET
MODE: DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN246R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN246R.zip
SOURCE BASELINE: RUN245R GLOBALTOP10 ROOT-CAUSE AUDIT
NEXT RUN: RUN247R ARCHIVE CONTRACT REPAIR
NEXT LIVE TEST: RUN250R
FINAL DECISION: TEST FIRST

# FINAL SUMMARY

RUN246R did not request, generate, edit, clean, rename, delete, package, or use live/runtime output files as source truth. The patch was based on RUN245R report intake and direct active source inspection only.

Exact GlobalTop10 Dossier promotion root cause confirmed: `mt5/runtime/ASC_Dispatcher.mqh::ASC_Top10RunFullPromoteStagingFamily` staged children through the resolved runtime/canonical artifact context, but promotion copied staged-to-final children using the raw shortlist symbol plus a blank canonical path argument. With broker/runtime names such as `.nx`, that creates a source/promote key mismatch and can leave `_staging` populated while `Dossiers/GlobalTop10` remains empty.

Exact GlobalTop10 Symbol Data Pack root cause confirmed: `ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication` reads membership from `state.top10_run_full_last_completed_symbols`. That completed-symbol snapshot is only lawful after the GlobalTop10 Dossier family promotes and verifies. When Dossier promotion fails, GlobalTop10 SDP correctly has no source-owned membership snapshot and cannot reach the writer without faking membership from folders.

Exact Manifest upload-root token repair applied: `ASC_WriteArtifactBundleManifest` now emits `UPLOAD_ROOT_REQUIRED=server_root_or_export_root` plus upload-root policy/resolution/source fields, matching the required-token contract without deleting validation or faking proof-complete path evidence.

Exact source/control patch applied: `ASC_Dispatcher.mqh` now resolves GlobalTop10 promotion, stale-final cleanup, staging cleanup, and queued target telemetry through `ASC_TryResolveGlobalTop10ArtifactContext`, which derives runtime/canonical artifact identity from active L1 symbol state before building staged/final paths. It also adds bounded GlobalTop10 route telemetry and explicit SDP dependency telemetry. `ASC_Version.mqh` and control/report files were advanced to RUN246R/RUN247R/RUN250R identity.

The GlobalTop10 staged/final key mismatch was repaired for the promotion copy path. Blank canonical path arguments in GlobalTop10 promotion were repaired. GlobalTop10 SDP can now reach the writer once the committed source-owned completed-symbol snapshot exists after Dossier promotion; it still cannot and must not infer membership from folders, staging, archive, or generated output.

Top5PerBucket source paths and route logic were not changed. FileIO, final route constants, flat-root SDP, public SDP staging, L3 gates, L4 ranking/order/formula, HUD, Dossier architecture, Market Board architecture, generated output, and strategy/signal/trade/risk logic remained untouched. Archive contract was classified and deferred to RUN247R; timestamped archive history was not patched in RUN246R.

MetaEditor compile was not rerun in this environment. Compile proof remains outstanding. Runtime/live proof remains outstanding until RUN250R after RUN246R, RUN247R, RUN248R, and RUN249R source gates. No production-readiness, edge, signal, trade, execution, risk, or prop-firm permission is claimed.

Exact next move: RUN247R archive contract repair — separate previous-state cache from real timestamped archive history without touching current truth.

# Evidence Ladder

| Claim | Strongest Evidence | Evidence Class | Ceiling |
|---|---|---:|---|
| RUN245 identified GlobalTop10 final absence/staging presence | RUN245R report intake | 2/3 | report/source intake only |
| `ASC_Dispatcher.mqh` owns GlobalTop10 promote and SDP mirror admission | direct source inspection | 3 | source truth only |
| Blank canonical path args existed in promote path | direct source inspection | 3 | source truth only |
| Manifest required token was missing from emitted body | direct source inspection | 3 | source truth only |
| Patch compiles clean | not available | 0 | outstanding |
| Patch publishes GlobalTop10 live files | not available | 0 | RUN250 required |
| Trading edge or trade permission | not evaluated | 0 | forbidden |

# No-Live-Output Boundary

| Boundary | RUN246R Result |
|---|---|
| New runtime output requested | no |
| Generated Dossiers edited | no |
| Generated Symbol Data Packs edited | no |
| Market Board / Scanner Status / Manifest runtime evidence edited | no |
| FunctionResults / Experts / Journal logs edited | no |
| Generated output used as current source truth | no |
| Source patch allowed | yes, exact Dispatcher GlobalTop10/Manifest owner only |

# RUN245 Absorption Table

| RUN245 Finding | Evidence Source | Source Owner Candidate | Severity | RUN246 Action |
|---|---|---|---|---|
| Market Board Top10 exists | RUN245 report/runtime intake | MarketBoard / Dispatcher | info | preserved; no board patch |
| Top5PerBucket crypto Dossiers final exist | RUN245 report/runtime intake | Dossier route | positive | preserved; no Top5 path mutation |
| Top5PerBucket crypto SDPs final exist | RUN245 report/runtime intake | SDP route | positive | preserved; no Top5 writer mutation |
| Dossiers/GlobalTop10 final empty | RUN245 report/runtime intake | Dispatcher promote | critical | repaired promote path context |
| Dossiers/GlobalTop10/_staging has staged `.nx` files | RUN245 report/runtime intake | Dispatcher staging/promote | critical | aligned promote lookup to resolved runtime/canonical artifact context |
| Symbol Data Packs/GlobalTop10 absent | RUN245 report/runtime intake | Dispatcher SDP mirror | critical | restored upstream prerequisite and made dependency explicit |
| RUN243 diagnostic absent in runtime | RUN245 report/runtime intake | runtime/source parity | high | added RUN246 marker for later proof |
| staged children use canonical/broker artifact key | RUN245 + source inspection | Dispatcher staging writer | high | promotion now uses same resolved artifact context |
| promotion copies with blank canonical path arguments | source inspection | Dispatcher promote | critical | patched |
| Manifest upload-root required token not emitted | source inspection | Dispatcher manifest writer | high | patched emitter/validator contract |

# GlobalTop10 Dossier Promotion Root Cause

| GlobalTop10 Dossier Chain | Function / Source Region | Expected | Observed | PASS / HOLD / FAIL | Patch |
|---|---|---|---|---|---|
| staged write admission | `ASC_RunDeepFocusTriggerWrite` / batch writer path | staged children are source-owned | staging path already uses selected runtime + canonical context | PASS | preserve |
| staged filename key | `ASC_GlobalTop10BatchArtifactPath` callsite | same key used by promote | writer path is resolved; promote path was raw symbol + blank canonical | FAIL | added resolver and used runtime/canonical identity in promote |
| promote source path | `ASC_Top10RunFullPromoteStagingFamily` | nonblank correct staging path | blank canonical context | FAIL | patched |
| promote destination path | same function | final `Dossiers/GlobalTop10` unchanged | final directory unchanged; filename context fragile | FAIL before patch | path directory preserved; artifact identity resolved |
| promote expected count | same function | source batch count | source count preserved | PASS | no count/rank mutation |
| promote validation | `ASC_Top10RunFullFamilyCompleteInDirectory` | validate promoted final children | existing readback retained | PASS | no validation weakening |
| promote failure telemetry | `ASC_RecordTop10BatchDecision` | emits reason if blocked | existed but lacked context marker | PASS after patch | added context/runtime/canonical reason and RUN246 marker |
| final route path | `ASC_GlobalTop10LiveDirectory` | unchanged | unchanged | PASS | none |
| Top5 comparison | no Top5 source touched | working path preserved | no Top5 diffs | PASS | none |

# GlobalTop10 Symbol Data Pack Route Restoration

| GlobalTop10 SDP Chain | Function / Source Region | Expected | Observed | PASS / HOLD / FAIL | Patch |
|---|---|---|---|---|---|
| route admission | `ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication` | admitted when committed snapshot ready | route depends on `top10_run_full_last_completed_symbols` | PASS | preserve source-owned admission |
| membership source | same | committed source snapshot | no folder-derived membership | PASS | explicit telemetry retained |
| Dossier dependency | same | lawful and observable | dependency was real but under-explained | PASS after patch | added `sdp_dossier_dependency_state=requires_promoted_globaltop10_snapshot` |
| skip reason | same | explicit if skipped | no-snapshot reason existed but lacked dependency marker | PASS after patch | patched reason |
| write attempt telemetry | SDP status line + manifest trace | emitted | status line exists | PASS after patch | added route attempted/published/status/reason in GlobalTop10 trace |
| final route path | SDP routing contracts | `Symbol Data Packs/GlobalTop10` | unchanged | PASS | no route path edit |
| final expected count | runtime state | 10 unless lawful reason | source total retained | PASS | no count/rank mutation |
| validation/readback | SDP writer contracts | strict | unchanged | PASS | none |
| Top5 comparison | Top5 SDP route | working path preserved | no Top5 diffs | PASS | none |

# Manifest Upload-Root Token Contract

| Question | RUN246 Answer |
|---|---|
| Where is `UPLOAD_ROOT_REQUIRED=server_root_or_export_root` required? | `ASC_WriteArtifactBundleManifest` required-token list. |
| Where should upload-root proof be emitted? | Manifest body in the same function before validation. |
| Is server/export root known? | `state.server_root` is available as the source-owned runtime root posture. |
| Can the body emit truthfully? | yes: emit policy token plus known/unknown resolution state; do not fake path proof. |
| Was validation weakened? | no. Required token retained. |

Patched emitted fields:

```text
UPLOAD_ROOT_REQUIRED=server_root_or_export_root
upload_root_policy=server_root_or_export_root
upload_root_resolution_state=known|unknown
upload_root_path_source=ASC_RuntimeState.server_root
```

# GlobalTop10 Telemetry Contract

| Field | Status |
|---|---|
| `globaltop10_route_attempted` | added to batch trace |
| `globaltop10_dossier_stage_attempted` | added to manifest telemetry line |
| `globaltop10_dossier_staged_count` | added |
| `globaltop10_dossier_promote_attempted` | represented through route/batch status and promote decision rows |
| `globaltop10_dossier_promoted_count` | added as committed count after promotion |
| `globaltop10_dossier_promote_status` | added |
| `globaltop10_dossier_promote_reason` | added |
| `globaltop10_sdp_route_attempted` | added |
| `globaltop10_sdp_published_count` | added |
| `globaltop10_sdp_route_status` | added |
| `globaltop10_sdp_route_reason` | added |
| `globaltop10_committed_snapshot_available` | added |
| `globaltop10_publication_shortlist_ready` | added |
| `globaltop10_expected_count` | added |
| `globaltop10_final_count` | added in manifest telemetry |
| `globaltop10_staging_count` | added in manifest telemetry |
| `globaltop10_route_membership_source` | added as committed L4/publication shortlist snapshot |
| `globaltop10_not_folder_derived=true` | added |
| `run246_globaltop10_repair_marker=active` | added |

# Top5PerBucket Preservation Check

| Top5 Protected Area | Expected | Source Evidence | PASS / HOLD / FAIL |
|---|---|---|---|
| `Dossiers/Top5PerBucket/crypto` final path | unchanged | no Top5 path source changed | PASS |
| `Symbol Data Packs/Top5PerBucket/crypto` final path | unchanged | no SDP routing contract changed | PASS |
| Top5 expected count | 5 unless lawful state | no count logic changed | PASS |
| Top5 route membership source | committed source snapshot | no membership owner changed | PASS |
| Top5 writer not ranking owner | yes | no writer changed | PASS |
| Top5 archive/current behavior | unchanged until RUN247 | no archive contract rewrite | PASS |
| Top5 telemetry | preserved | no Top5 telemetry edits | PASS |
| no Top5 formula/rank change | yes | L3/L4 files untouched | PASS |

# Archive Contract Deferred To RUN247

| Archive Area | Current Family | Correct Future Family | Patch Now? | RUN247 Requirement |
|---|---|---|---:|---|
| SDP `_archive/.../*.previous` | previous_state_cache | keep as continuity cache | no | separate from history |
| SDP timestamped history | missing/unknown | timestamped_archive_history | no | add in RUN247 |
| Dossier archive | partial/unknown | timestamped_archive_history | no | align in RUN247 |
| archive as current truth | forbidden | never current truth | no | enforce |

RUN246R did not add timestamped archive history and did not make archive membership/current truth.

# Multi-Domain Research Lattice

| Research Lane | Source / Authority | Finding | Converted RUN246 Constraint | Falsifier |
|---|---|---|---|---|
| MQL5 file/folder behavior | MQL5 Reference — FileOpen / file sandbox / FileMove | file operations are sandboxed; overwrite/move requires explicit behavior | keep FileIO and final paths unchanged; do not fake folder-derived membership; leave promotion atomic helper intact | patch rewrites FileIO or infers Top10 from folders |
| MQL5 timer/event behavior | MQL5 Reference — OnTimer | timer events queue; long work can starve future timer processing | bounded telemetry only; no blocking promotion loops | new infinite loop or unbounded per-symbol spam |
| Reliability/SRE | Google SRE cascading failure guidance | retries must not cascade into hammering | emit reasons and keep existing cadence/yield controls | repeated manifest/promotion storm without due/backoff |
| Data governance/lineage | W3C PROV-DM | provenance improves quality/reliability/trust by identifying source/activity/entity lineage | route membership source label must be source-owned and not folder-derived | writer computes membership or folders become truth |
| Protected lattice / boundary surgery | Aurora guidebooks + active source | staging/final, board/artifacts, manifest validator/emitter boundaries must stay explicit | patch only boundary mismatch; do not move ownership | HUD/Market Board/Dossier writer becomes hidden rank owner |

# Brain Guidebook / Two-Brain Check

| Guidebook | Read? | Key Rule Extracted | Converted RUN246 Constraint | Patch Needed? |
|---|---:|---|---|---:|
| `AURORA_GUIDEBOOK_INDEX.md` | yes | final gates must repair active control drift and ranking transparency is not permission | update control identity; no trade permission | yes |
| `AURORA_CODING_BRAIN_GUIDEBOOK.md` | yes | source-owned truth and static gate before live proof | inspect Dispatcher owner first; no FileIO/final path/ranking drift | yes |
| `AURORA_TRADING_BRAIN_GUIDEBOOK.md` | yes | live/data proof is not signal or trade permission | no buy/sell/entry/risk/prop-firm claim | no trade patch |

## Brain 1 — Builder

- Broken path: `ASC_Top10RunFullPromoteStagingFamily` used raw symbols and blank canonical path arguments for staged/final copy.
- Smallest safe patch: resolve runtime/canonical artifact context through active L1 state and reuse existing path builders.
- Restore without membership change: keep source arrays and counts unchanged; only repair artifact key used by promotion and cleanup.
- Preserve Top5PerBucket: do not touch Top5 route, writers, formulas, or contracts.
- Later proof: RUN250 must show GlobalTop10 Dossier final files, GlobalTop10 SDP final files, manifest token pass, and no heartbeat starvation.
- Untouched: FileIO, final route constants, L3/L4, HUD, generated output, strategy/trade/risk.

## Brain 2 — Auditor

- Staging can look like truth if final promotion fails; report now marks staging as not current truth.
- Folders can tempt membership inference; telemetry says `globaltop10_not_folder_derived=true`.
- SDP writer must not calculate rank; membership remains `state.top10_run_full_last_completed_symbols`.
- Top5 can break if shared routes mutate; no Top5 route files changed.
- Flat-root/public staging can reappear if routing is broadened; not changed.
- Manifest failure can be hidden by deleting token; token retained and emitted truthfully.
- Heartbeat can block if loops expand; no loops added.
- Generated output mutation would fake proof; none edited.
- Signal/trade wording can leak from “Top10”; report keeps no-permission boundary.

# Protected Lattice / Boundary Contract

| Boundary | System A | System B | Lawful Interface | Source Of Truth | Allowed Crossing | Forbidden Crossing | Acceptance Criteria | HOLD / KILL Condition |
|---|---|---|---|---|---|---|---|---|
| Market Board Top10 ↔ GlobalTop10 artifacts | board signature | Dossier/SDP routes | committed snapshot | Dispatcher/L4 | route publication request | board as writer/rank owner | same source IDs | split truth remains |
| GlobalTop10 staging ↔ final | staged children | final route | validate/promote | Dispatcher/Dossier writer | staged payload + validation | staging as current truth | final files promote | staging-only truth |
| Dossier GlobalTop10 ↔ SDP GlobalTop10 | dossier route | SDP route | shared committed snapshot | Dispatcher/L4 | source-owned membership | SDP computes membership | route parity | split source |
| Manifest validator ↔ emitter | required upload root | emitted body | stable key token | Dispatcher/runtime state | upload-root policy/status | fake proof complete | token matched | token fail remains |
| Top5 working route ↔ GlobalTop10 repair | Top5 final outputs | GlobalTop10 patch | no shared regression | existing Top5 source | preservation only | Top5 mutation | Top5 unchanged | Top5 broken |
| archive cache ↔ archive history | `.previous` cache | timestamped history | separate families | future RUN247 | classification only | archive as truth | deferred cleanly | archive patched early |
| source patch ↔ generated evidence | active source | runtime output | future proof only | source files | checklist | output mutation | evidence untouched | generated edit |
| data review ↔ trade permission | scanner data | trade action | no-permission boundary | Trading Brain law | review labels | buy/sell/entry | permission false | signal wording |

# Static Compile-Risk Sweep

| File | Static Check | Result | Patch Needed? |
|---|---|---|---:|
| `ASC_Dispatcher.mqh` | GlobalTop10 promote source path nonblank | patched through resolver | yes |
| `ASC_Dispatcher.mqh` | GlobalTop10 promote destination path unchanged | final directory builder unchanged | no |
| `ASC_Dispatcher.mqh` | GlobalTop10 staging/final key alignment | runtime/canonical context reused | yes |
| `ASC_Dispatcher.mqh` | GlobalTop10 SDP admission reaches writer | reachable once completed snapshot exists | yes, upstream prerequisite restored |
| `ASC_Dispatcher.mqh` | Manifest upload-root token emitted | patched | yes |
| `ASC_Dispatcher.mqh` | no blocking loops introduced | no loops added | no |
| `ASC_DossierWriter.mqh` | no broad architecture change | untouched | no |
| `ASC_SymbolDataPackWriter.mqh` | consumer-only | untouched | no |
| `ASC_SymbolDataPackRouting.mqh` | final route path unchanged | untouched | no |
| `ASC_FunctionResults.mqh` | telemetry signatures compile if touched | untouched | no |
| `ASC_Version.mqh` | run identity updated | RUN246/RUN247/RUN250 aligned | yes |
| all touched files | no FileIO rewrite | confirmed | no |
| all touched files | no L3/L4 behavior mutation | confirmed | no |
| all touched files | no signal/trade wording | confirmed | no |

MetaEditor compile was not rerun. Compile proof remains outstanding.

# Preservation Check

| Protected Area | Expected | PASS / HOLD / FAIL |
|---|---|---|
| RUN240 token repairs | preserved | PASS |
| RUN241 heartbeat hardening | preserved | PASS |
| RUN243 SDP route decoupling | preserved | PASS |
| RUN244 compile-path repairs | preserved | PASS |
| Market Board Top10 | consumer-only preserved | PASS |
| Top5PerBucket Dossier final route | unchanged | PASS |
| Top5PerBucket SDP final route | unchanged | PASS |
| GlobalTop10 final route path | unchanged | PASS |
| public flat-root SDP | not re-enabled | PASS |
| public SDP staging | not re-enabled | PASS |
| internal staging | not current truth | PASS |
| FileIO validation strictness | preserved | PASS |
| membership source | committed L4/Dispatcher only | PASS |
| SDP writer | consumer/projection only | PASS |
| Dossier writer | writer/composer only, not rank owner | PASS |
| L3 gates | unchanged | PASS |
| L4 ranking/order/formula | unchanged | PASS |
| HUD | untouched | PASS |
| generated output evidence | untouched | PASS |
| archive | not contract-patched; classified only | PASS |
| no signal/trade permission | preserved | PASS |

# Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| Market Board Top10 exists | GlobalTop10 final artifacts absent | RUN245 report | RUN245 report | 2/3 | 2/3 | neither; both can coexist | patch artifact route, not board | no after source patch; RUN250 proof required |
| GlobalTop10 staged files exist | final route empty | RUN245 report | RUN245 report | 2/3 | 2/3 | neither | source inspection confirmed promote key mismatch risk | RUN250 required |
| Top5 works | GlobalTop10 fails | RUN245 report | RUN245 report/source | 2/3 | 2/3 | source owner isolates route-specific fault | patch GlobalTop10 only | no |
| RUN243 diagnostic exists in source | runtime showed zero hits | source/RUN245 report | RUN245 runtime intake | 3 | 2 | source proves code exists; runtime does not prove it executed | add RUN246 marker for later parity proof | RUN250 required |
| Manifest requires upload-root token | body did not emit token | source required list | source emitted body | 3 | 3 | same source conflict | emit token without deleting requirement | no |
| folders show staged files | membership should be source-owned | runtime/report | guidebooks/source law | 2/3 | 3 | source law outranks folder temptation | no folder-derived membership | no |
| `.previous` looks like archive | `.previous` is continuity cache | RUN245/user prompt | archive contract law | 2 | 3 | contract law | defer timestamped history to RUN247 | no |
| source patch applied | compile clean not proven | source diff | no compile output | 3 | 0 | source diff only | MetaEditor compile required | yes, TEST FIRST |
| clean data could imply trading | trading permission forbidden | user workflow | Trading Brain | 1/2 | 3 | Trading Brain | no signal/trade wording | no |

# Patch Ledger

| File | Change | Why | Boundary |
|---|---|---|---|
| `mt5/runtime/ASC_Dispatcher.mqh` | added `ASC_TryResolveGlobalTop10ArtifactContext` | resolves runtime/canonical artifact identity from active L1 source state | source-owned path context only |
| `mt5/runtime/ASC_Dispatcher.mqh` | patched GlobalTop10 promotion copy source/destination paths | repairs blank canonical/staged-final key mismatch | no final path mutation |
| `mt5/runtime/ASC_Dispatcher.mqh` | patched stale-final and staging cleanup path context | prevents cleanup using wrong artifact key after promotion | no membership/rank mutation |
| `mt5/runtime/ASC_Dispatcher.mqh` | patched queued target telemetry path | future logs show source-owned staged target path | telemetry only |
| `mt5/runtime/ASC_Dispatcher.mqh` | emitted upload-root manifest contract fields | fixes required-token/emitter mismatch | validation preserved |
| `mt5/runtime/ASC_Dispatcher.mqh` | added compact GlobalTop10 route telemetry | later RUN250 can prove attempted/staged/promoted/skipped states | bounded telemetry only |
| `mt5/runtime/ASC_Dispatcher.mqh` | added SDP dependency state/reason | makes mirror dependency observable | writer remains projection only |
| `mt5/core/ASC_Version.mqh` | advanced run/package/next-run identity | aligns source/control truth | control only |
| office/control/report files | updated RUN246/RUN247 handoff | prevents roadmap drift | control/report only |

# Package Validation Table

| Package Law | Result |
|---|---|
| Exact package filename | `TRUTH_SEEKER_RUN246R.zip` |
| Changed source/control/report files only | yes |
| Repo-relative folder layout preserved | yes |
| Expected root preserved | `Aurora Sentinel Core/...` |
| Includes RUN246R report | yes |
| Excludes generated runtime output evidence | yes |
| Excludes generated Dossiers/SDPs | yes |
| Excludes logs / whole repo dump | yes |
| No forbidden suffix | yes |

# Exact RUN247 Prompt Seed

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN247R / ARCHIVE CONTRACT REPAIR — SEPARATE PREVIOUS-STATE CACHE FROM REAL TIMESTAMPED ARCHIVE HISTORY WITHOUT TOUCHING CURRENT TRUTH
MODE: DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN247R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN247R.zip
SOURCE BASELINE: RUN246R GLOBALTOP10 FINAL ROUTE PUBLICATION RESTORATION
NEXT LIVE TEST: RUN250R
EXPECTED DECISION: TEST FIRST

PURPOSE:
- classify and repair archive contract after GlobalTop10 route restoration.
- keep `.previous` files as previous_state_cache only.
- add or restore real timestamped archive history for Dossier and Symbol Data Pack route families.
- archive only successful final publications.
- never use archive as current membership truth.
- never let archive drive ranking, selection, route membership, or Siam canonical current task.
- preserve final paths.
- preserve FileIO atomic safety.
- preserve RUN246 GlobalTop10 recovery.
- add archive proof fields:
  archive_family=previous_state_cache|timestamped_history
  archive_timestamp
  archive_source_route
  archive_source_snapshot_id
  archive_retention_policy
  archive_write_status
  archive_not_current_truth=true
- no generated output mutation.
- no signal/trade permission.
```
