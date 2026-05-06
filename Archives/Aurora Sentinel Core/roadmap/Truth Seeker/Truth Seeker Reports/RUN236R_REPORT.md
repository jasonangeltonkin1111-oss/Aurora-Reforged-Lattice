# RUN236R REPORT — Board-Dossier-SDP-L3-L4 Sync Bridge

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN236R / BOARD-DOSSIER-SDP-L3-L4 SYNC BRIDGE — VERIFY ONE SNAPSHOT ID, ONE MEMBERSHIP SOURCE, AND ONE REVIEW CONTEXT ACROSS SIAM SURFACES
MODE: AUDIT + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN236R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN236R.zip
NEXT SOURCE GATE: RUN237R
NEXT LIVE TEST: RUN238R
SERIOUS DECISION: TEST FIRST

PRIMARY PURPOSE:
Patch active source/control only so the post-RUN228 through RUN235 source corridor becomes one synchronized Siam-facing truth chain.

PATCH RESULT:
- Added RUN236 sync bridge constants and version closeout.
- Added additive sync fields to L4 shortlist summaries.
- Projected committed L4 snapshot/member source through Dispatcher, Market Board, Symbol Data Packs, Scanner Status, and FunctionResults context.
- Preserved Market Board and SDP as consumers only.
- Preserved Dossier/Current Focus as derivative surfaces; Board request surface now carries dossier request sync labels.
- Did not mutate generated output evidence.
- Did not touch FileIO, HUD, path doctrine, L3 gate behavior, or L4 ranking/formula behavior.
- Did not add signal/trade/execution/risk/prop-firm permission.

EVIDENCE CEILING:
Evidence Class 3 source inspection and source patch only. No compile output supplied. No runtime/live proof in RUN236R.
```

```text
FINAL SUMMARY

RUN236R completed as a bounded AUDIT + PATCH source run.

No live/output files were requested, regenerated, edited, cleaned, renamed, deleted, or packaged. RUN227–RUN235 evidence remained read-only intake only.

Exact source/control patch applied:
- Added `ASC_SYNC_BRIDGE_*` constants in `mt5/core/ASC_Constants.mqh`.
- Bumped active run/version metadata in `mt5/core/ASC_Version.mqh` from RUN235R to RUN236R and seeded RUN237R.
- Added additive `sync_*` fields to `ASC_ShortlistSymbolSummary` and helper projection/proof tokens in `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh`.
- Projected the Dispatcher committed L4 snapshot ID and membership source into committed rows, SDP publish calls, L4 FunctionResults detail, and status helper lines in `mt5/runtime/ASC_Dispatcher.mqh`.
- Added RUN236 sync labels to Market Board Siam dossier request, Top10 matrix, and symbol blocks in `mt5/artifacts/ASC_MarketBoardWriter.mqh`.
- Added sync contract includes and composer/writer parameter threading for Symbol Data Packs in `mt5/artifacts/symbol_data_pack/*`.
- Added Scanner Status sync projection lines and finish-message proof context in `mt5/artifacts/ASC_ScannerStatusWriter.mqh`.
- Updated office/control/guidebook files and created `RUN236R_REPORT.md`.

One snapshot ID is now source-projected through L4/Dispatcher/Market Board/SDP/Scanner Status/FunctionResults context when committed rows exist. One membership source is now projected as `committed_l4_rows/publication_shortlist_rows` for the committed source chain.

Market Board remains consumer-only. SDP remains consumer-only. Dossier and Current Focus remain derivative and were not converted into hidden ranking owners. The Dossier request surface is covered through the Market Board Siam request block; direct Dossier/Current Focus internal sync labels remain a RUN238/RUN237 verification item if needed.

Surface status:
- Aligned source-present: L4 committed rows, Dispatcher committed snapshot, Market Board projections, SDP projection contract, Scanner Status projection.
- Partial source-present: Dossier request context via Board, FunctionResults context via Dispatcher/Scanner Status finish messages.
- Pending runtime proof: all generated surface emission until compile and RUN238 live output.
- Conflict: none found in inspected active source.
- Unknown: any generated runtime artifact state, because RUN236R did not request or inspect new live output.

RUN235, RUN233, RUN231, RUN230, RUN229, and RUN228 preservation checks remain source-pass within Evidence Class 3. FileIO, HUD, generated output evidence, final path constants, L3 behavior, and L4 ranking/formula behavior remained untouched.

Unproven until supplied compile/RUN238 live proof:
- MetaEditor compile cleanliness.
- Actual emitted Market Board/SDP/Dossier request/Scanner Status/FunctionResults sync field parity.
- Actual generated file absence of split snapshot IDs or hidden writer-owned ranking.
- Runtime path publication and package law in live evidence.

Exact next move: RUN237R final source gate before RUN238 live proof.

SERIOUS DECISION: TEST FIRST
```

## 0. Mode Lock

| Declaration | Required Answer | Observed |
|---|---|---|
| current run | RUN236R | RUN236R |
| primary mode | AUDIT | AUDIT |
| secondary mode | PATCH | PATCH |
| live run? | no | no |
| runtime/output artifacts expected? | no new runtime output | none requested |
| source editing allowed? | yes, sync/projection fixes only | yes |
| generated output editing allowed? | no | no generated evidence touched |
| FileIO rewrite allowed? | no | `mt5/io/ASC_FileIO.mqh` untouched |
| path mutation allowed? | no | path constants/routes untouched |
| L3 behavior change allowed? | no | no gate logic touched |
| L4 ranking/order/formula behavior change allowed? | no | no ranking/formula logic changed |
| membership source change allowed? | no | source label preserved as committed L4/publication rows |
| HUD patch allowed? | no | `mt5/hud/ASC_HUD_Manager.mqh` untouched |
| Market Board broad redesign allowed? | no | additive sync labels only |
| Dossier broad rewrite allowed? | no | Dossier writer untouched |
| Current Focus broad rewrite allowed? | no | Current Focus writer untouched |
| strategy/signal/trade/risk patch allowed? | no | no permission added |
| next live test | RUN238R | RUN238R |
| production-ready claim allowed? | no | no readiness claim |
| edge claim allowed? | no | no edge claim |
| signal/trade permission allowed? | no | permission fields false |
| final serious decision | PROCEED / HOLD / KILL / TEST FIRST | TEST FIRST |

## Evidence Ladder

| Claim | Evidence Class | Evidence Held | Limit |
|---|---:|---|---|
| RUN236 source files were patched | 3 | direct active source edits in extracted repo | no compile proof |
| RUN236 generated output was untouched | 3 | changed-files diff shows source/control/report/guidebook only | does not prove external user copies untouched |
| L4/Dispatcher snapshot projection exists in source | 3 | `ASC_ShortlistRun236ApplySyncBridge` plus Dispatcher commit projection | no runtime emission proof |
| SDP sync fields can be composed from committed context | 3 | Writer/composer signatures and dispatcher call threading | no live file proof |
| Market Board remains consumer-only | 3 | additive display labels only; no rank formula patch | no runtime UI proof |
| Compile cleanliness | below 4 | static sweep only | MetaEditor output required |
| Runtime/live correctness | none | no live run in scope | RUN238 required |
| Trading edge/permission | none | intentionally absent | not allowed |

## No-Live-Output Boundary

RUN236R did not request, inspect, generate, clean, edit, rename, delete, or package generated runtime/live output evidence. Generated Symbol Data Packs, Dossiers, Scanner Status output files, FunctionResults output files, manifests, Experts logs, and Journal logs were excluded.

## RUN235 Safety Gate

| RUN235 Safety Item | Expected | Observed | PASS / HOLD / FAIL | Action |
|---|---|---|---|---|
| package was source/control only | yes | RUN235 report/control indicates source/control scope | PASS | preserve |
| generated output excluded | yes | no generated output required for RUN236 | PASS | preserve |
| L4 owner patched | ASC_ShortlistSelectionEngine | RUN235 L4 fields present in shortlist engine | PASS | build additive sync only |
| Dispatcher L4 snapshot stamping added | yes | `l4_run235_snapshot_id` present in Dispatcher commit | PASS | reuse as sync ID |
| Market Board projection enriched | yes | Board consumes L4 snapshot and membership labels | PASS | add RUN236 sync labels |
| L4 ranking/order/formula behavior unchanged | yes | no ranking formula edits made in RUN236 | PASS | preserve |
| correlation/exposure fake precision avoided | yes | existing quarantine/source labels preserved | PASS | preserve |
| FileIO untouched | yes | no diff in `ASC_FileIO.mqh` | PASS | preserve |
| final paths untouched | yes | no route/path constants edited | PASS | preserve |
| HUD untouched | yes | no diff in HUD file | PASS | preserve |
| Dossier broad rewrite avoided | yes | `ASC_DossierWriter.mqh` untouched | PASS | request labels via Board only |
| RUN233 L3 denominators preserved | yes | `ASC_SelectionFilter.mqh` untouched | PASS | preserve |
| RUN231 Market Board blocks preserved | yes | additive sync labels only | PASS | preserve |
| RUN230 duplicate resolver preserved | yes | duplicate route context preserved and passed through SDP | PASS | preserve |
| RUN229 lineage preserved | yes | membership source fields preserved and reused | PASS | preserve |
| RUN228 topology cleanup preserved | yes | final routes/staging policy untouched | PASS | preserve |
| compile proof supplied | optional | not supplied | HOLD for proof only | RUN237/compile needed |
| RUN238 remains next live proof | yes | version/control files seed RUN237 then RUN238 | PASS | preserve |

## Sync Bridge Objective

The source chain now treats L4 committed rows as the membership/ranking source, Dispatcher as committed snapshot propagator, and writer surfaces as projections only. RUN236R does not introduce a new ranking run or new membership owner.

Required chain:

`L3 Candidate Filtering -> L4 Shortlist Selection -> Dispatcher committed snapshot -> Market Board -> Symbol Data Packs -> Dossier request context -> Scanner Status / FunctionResults proof context -> RUN238 evidence checklist`

## Required Sync Field Contract

| Field | RUN236 Source Status |
|---|---|
| sync_bridge_version | `RUN236R_v1` constant and projected |
| sync_bridge_owner | `ASC_Dispatcher_committed_snapshot_bridge` constant and projected |
| sync_snapshot_id | projected from committed L4 snapshot ID where available; `unknown`/pending otherwise |
| sync_membership_source | projected from L4 membership source where available |
| sync_l3_source | `ASC_SelectionFilter/RUN233R_v1` |
| sync_l4_source | `ASC_ShortlistSelectionEngine/RUN235R_v1` |
| sync_market_board_source | Market Board consumes committed snapshot |
| sync_sdp_source | SDP consumes committed snapshot |
| sync_dossier_request_source | Dossier request consumes committed snapshot |
| sync_status_surface_source | ScannerStatus/FunctionResults projection |
| sync_alignment_status | aligned/partial/unknown based on available source context |
| sync_alignment_reason | compact reason emitted with status |
| sync_pending_surfaces | RUN238 live surface verification pending |
| sync_conflict_surfaces | none unless detected later |
| sync_boundary | `source_snapshot_projection_only_not_signal_not_trade` |
| sync_*_permission | false |

## Surface-Sync Audit Table

| Surface | Current Source | Snapshot ID Present? | Membership Source Present? | L3 Context Present? | L4 Context Present? | Risk | Patch Needed? |
|---|---|---:|---:|---:|---:|---|---:|
| L3 summary | ASC_SelectionFilter | n/a | n/a | owner | n/a | hidden denominator drift | no |
| L4 rows | ASC_ShortlistSelectionEngine | yes after Dispatcher commit | yes | yes | owner | pre-commit unknown snapshot | yes additive |
| Dispatcher committed_l4_rows | ASC_Dispatcher | yes | yes | yes | yes | split commit if not propagated | yes additive |
| publication_shortlist_rows | ASC_Dispatcher/state | expected via committed rows | expected | yes | yes | live parity unproven | no direct rewrite |
| Market Board | ASC_MarketBoardWriter | yes source-projected | yes source-projected | yes | yes | board overclaim | yes additive |
| Symbol Data Packs | SDP Composer/Writer | yes via dispatcher call threading | yes | yes | yes | stale/missing sync | yes additive |
| Dossier request surfaces | Board request / Dossier law | partial via Board request | partial | yes | yes | hidden request list | Board additive only |
| Current Focus | ASC_CurrentFocusWriter | pending direct label | pending direct label | pending | pending | hidden selected truth | no broad patch |
| Scanner Status | ASC_ScannerStatusWriter | yes source-projected | yes source-projected | yes | yes | missing proof surface | yes additive |
| FunctionResults | Dispatcher / ScannerStatus finish message | partial source-projected | partial | yes | yes | generic proof only | Dispatcher additive |

### Surface Conclusion

Aligned source-present: L4 committed rows, Dispatcher commit, Market Board, SDP composer/writer contract, Scanner Status.

Partial source-present: Dossier request context through Board; FunctionResults via Dispatcher and Scanner Status finish messages.

Pending: direct Dossier/Current Focus internal labels if RUN237 decides they are required; all generated runtime surface proof until RUN238.

Conflict risk found: none in active source. Runtime conflict remains unproven until RUN238.

## Board / SDP / Dossier Source-of-Truth Rules

| Rule | RUN236 Enforcement |
|---|---|
| Market Board may display committed snapshot fields | Added display/projection fields only |
| Market Board must not calculate ranking | No ranking/order formula edited |
| SDP may project committed snapshot fields | Composer/writer now accept sync source fields |
| SDP must not compute membership | No SDP rank/rescore logic added |
| Dossier/Current Focus remain derivative | DossierWriter and CurrentFocusWriter untouched |
| Scanner Status/FunctionResults expose proof fields | Added compact sync context without runtime proof claim |
| Writers compose; engines own computation | preserved |

## Primary Root-Cause Answers

1. The committed L4 snapshot ID is created in `ASC_Dispatcher.mqh` as `l4_run235_snapshot_id` during L4 commit.
2. The same snapshot ID is available to Market Board through shortlist rows.
3. The same snapshot ID is now available to SDP writer/composer through Dispatcher publish-call threading.
4. The same snapshot ID is available to Dossier request surfaces through the Market Board Siam Dossier Request Block; direct DossierWriter label remains pending unless needed.
5. L3 summary/version/source is available as `RUN233R_v1` and L4 handoff fields.
6. L4 source/version is available as `ASC_ShortlistSelectionEngine/RUN235R_v1` and RUN235 L4 fields.
7. No writer-side independent membership reconstruction was introduced.
8. No writer was patched to scan generated folders as truth.
9. Market Board display patch does not calculate or alter rank/order.
10. Dossier request surface remains Board-derived; no separate top list added.
11. Current Focus was not patched; it remains derivative pending live/source verification.
12. Smallest safe patch was additive sync fields and propagation through existing source paths.
13. RUN238 must verify actual emitted parity across Market Board, SDP, Dossier request, Scanner Status, and FunctionResults.

## Allowed Patch Scope Used

Touched source files:

- `mt5/core/ASC_Constants.mqh`
- `mt5/core/ASC_Version.mqh`
- `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh`
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `mt5/artifacts/ASC_ScannerStatusWriter.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh`

Read-only/untouched by diff:
- `mt5/io/ASC_FileIO.mqh`
- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/market_state/ASC_MarketStateEngine.mqh`
- `mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh`
- `mt5/candidate_filtering/ASC_SelectionFilter.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/ASC_CurrentFocusWriter.mqh`
- `mt5/logging/ASC_FunctionResults.mqh`

## Sync Patch Policy Result

| Policy | Result |
|---|---|
| Find existing committed snapshot ID | Found in Dispatcher RUN235 commit path |
| Make it available through existing source paths | Done for L4 rows, Board, SDP, Scanner/FunctionResults context |
| Add compact fields only | Done |
| Avoid massive duplicated payload blocks | Done |
| Use unknown/partial/pending when unsafe | Done |
| Do not change order/membership | Preserved |
| Do not calculate writer scores | Preserved |
| Do not touch generated output | Preserved |

## Data / Dossier Cleanliness and Truthness Check

| Cleanliness Item | In Scope For RUN236? | Action | Forbidden Drift |
|---|---:|---|---|
| one snapshot ID | yes | projected or pending | no fake snapshot |
| one membership source | yes | projected source label | no writer ownership |
| Board / SDP / Dossier alignment labels | yes | source-owned labels only | no ranking compute |
| L3/L4 context consistency | yes | compact sync labels | no behavior changes |
| Scanner/FunctionResults proof clarity | yes | compact sync proof context | no runtime proof claim |
| Dossier readability | only source labels | Board request labels; DossierWriter untouched | no canonical drift |
| Current Focus readability | only if safe | untouched/pending | no HUD truth |
| RUN238 checklist | yes | exact live proof items seeded | no early live claim |

## Research Lattice Ledger

| Research Lane | Source / Authority | Finding | Converted RUN236 Constraint | Falsifier |
|---|---|---|---|---|
| Data lineage / provenance | W3C PROV-O and PROV-DM | Provenance needs entity/activity/agent context so data can be assessed for trust/reliability | Add snapshot ID, membership source, owner/source labels | Any surface emits value without source/snapshot label |
| Data quality / governance | DAMA/IBM and GOV.UK data quality dimensions | Consistency/completeness/validity must be monitored, not assumed | Add alignment/pending/conflict fields | `aligned` emitted while pending/conflict surfaces exist |
| Risk data aggregation / consistency | BCBS 239 risk aggregation principles | Aggregated data must be materially complete and exceptions explained | One committed shortlist source; explicit pending surfaces | Board/SDP/Dossier show different top-list source IDs |
| Secure SDLC / source-control discipline | NIST SSDF SP 800-218 | Source/config changes belong in version control; generated artifacts are not source authority | bounded source patch, no generated evidence mutation, changed-files package | generated runtime output included or edited |
| Protected lattice / threat model | Aurora guidebooks + source-of-truth doctrine | Boundaries prevent hidden truth owners | L3/L4/Board/SDP/Dossier boundary fields | Writer calculates rank/membership |
| Prompt/execution control | Truth Seeker run law | A source run cannot claim live proof | RUN237 final source gate and RUN238 live evidence checklist | RUN236 final claims compile/live/production readiness |

## Brain Guidebook / Two-Brain Check

| Guidebook | Read? | Key Rule Extracted | Converted RUN236 Constraint | Patch Needed? |
|---|---:|---|---|---:|
| AURORA_GUIDEBOOK_INDEX.md | yes | research must become tests/constraints | research ledger converted to sync fields and RUN238 falsifiers | yes |
| AURORA_CODING_BRAIN_GUIDEBOOK.md | yes | writers compose; token expansion must match composer output | added SDP tokens only after composer emits every route | yes |
| AURORA_TRADING_BRAIN_GUIDEBOOK.md | yes | data quality labels are not trade permission | permission fields false across sync bridge | yes |

### Brain 1 — Builder

- Smallest safe bridge: reuse Dispatcher committed L4 snapshot ID and add additive sync projection fields.
- Surfaces already carrying context: L4 rows, Dispatcher, Market Board RUN235 fields.
- Surfaces needing projection: SDP, Scanner Status, FunctionResults context, Board sync labels.
- Surfaces pending: direct DossierWriter/CurrentFocusWriter labels unless RUN237 proves need.
- Dispatcher owns snapshot propagation; writers only display/publish supplied labels.
- FileIO, HUD, L3 gate logic, L4 ranking/formula, generated evidence, and final paths remain untouched.

### Brain 2 — Auditor

- Fake alignment risk: emitting `aligned` without snapshot/member source. Guard: `partial/unknown/pending` allowed.
- Writer truth-owner risk: SDP or Board recomputes ranking. Guard: no rank formula edits.
- Generated folder truth risk: using output folders as membership authority. Guard: no generated output read/patch added.
- Ranking mutation risk: touching L4 ordering/formula. Guard: additive fields only.
- Hidden mismatch risk: Board/SDP/Dossier source labels absent. Guard: sync labels and RUN238 seeds.
- Trade wording risk: review context mistaken as signal. Guard: permission fields false.

## Protected Lattice / Boundary Contract

| Boundary | System A | System B | Lawful Interface | Source Of Truth | Allowed Crossing | Forbidden Crossing | Acceptance Criteria | HOLD / KILL Condition |
|---|---|---|---|---|---|---|---|---|
| L3 ↔ L4 | candidate filter | shortlist selection | source-owned handoff labels | L3/L4 owners | summary/version/status | behavior mutation | handoff visible | hidden filter |
| L4 ↔ Dispatcher | shortlist rows | committed snapshot | commit/snapshot ID | Dispatcher/L4 | snapshot source | source replacement | one committed ID | split commit |
| Dispatcher ↔ Board | committed snapshot | board display | consumer projection | Dispatcher/L4 | source labels | board ranks | board consumer-only | board truth owner |
| Dispatcher ↔ SDP | committed snapshot | symbol data packs | consumer projection | Dispatcher/L4 | sync fields | SDP ranks | SDP consumer-only | writer truth owner |
| Dispatcher ↔ Dossier | committed snapshot | dossier request context | request labels only | Dispatcher/L4/Dossier law | context labels | dossier ranks | no hidden list | dossier truth leak |
| source ↔ runtime evidence | active source | generated output | future proof only | source files | checklist | output mutation | evidence untouched | generated edit |
| data review ↔ trade permission | review context | trading decision | no-permission boundary | Trading Brain law | review labels | buy/sell/entry permission | permission false | signal wording |

## Static Compile-Risk Sweep

| Static Check | Result | Evidence | Patch Needed? |
|---|---|---|---:|
| missing include risk | mitigated | added Constants include to Shortlist and SDP contracts | yes |
| undefined struct/field risk | mitigated | fields added to `ASC_ShortlistSymbolSummary` before use | yes |
| duplicate helper/macro risk | no obvious duplicate | RUN236 helper names unique by grep | no |
| function signature mismatch risk | mitigated | SDP writer/composer signatures and Dispatcher calls aligned | yes |
| StringFormat argument mismatch risk | no new StringFormat-heavy sync field added except existing snapshot ID | static pass only | no |
| array bounds risk | guarded | status helpers check ArraySize before row access | yes |
| struct copy/default initialization risk | acceptable pending compile | local row copies used only for projection labels | no |
| required-token mismatch risk | mitigated | SDP required tokens expanded only after composer emits tokens | yes |
| sync field bloat risk | bounded | compact debug/header lines only | no |
| Board writer truth ownership risk | no | display-only additions | no |
| SDP writer truth ownership risk | no | consumes passed source labels | no |
| Dossier hidden ranking risk | no new risk | DossierWriter untouched; Board request labels only | no |
| L3 behavior mutation risk | no | L3 source untouched | no |
| L4 formula/ranking mutation risk | no | formula/order logic untouched | no |
| FileIO/path mutation risk | no | FileIO and route paths untouched | no |
| signal/trade wording risk | controlled | permissions false; review-only boundary | no |

Compile proof: NOT CLAIMED. MetaEditor output was not supplied.

## Preservation Check

| Protected Law / Feature | Expected | Source Evidence | PASS / HOLD / FAIL |
|---|---|---|---|
| RUN235 L4 transparency fields | preserved | `ASC_ShortlistSelectionEngine.mqh` fields retained | PASS |
| RUN235 correlation/exposure quarantine | preserved | existing policy fields untouched | PASS |
| RUN235 L4 ranking behavior unchanged | preserved | no formula/order edits | PASS |
| RUN233 L3 denominator fields | preserved | `ASC_SelectionFilter.mqh` untouched | PASS |
| RUN233 L3 bucket rows | preserved | ScannerStatus L3 block retained | PASS |
| RUN231 Siam Dossier Request Block | preserved | Board block retained and enriched | PASS |
| RUN231 Top10 Numeric Matrix | preserved | Matrix retained and enriched | PASS |
| RUN231 top-1 command downgrade | preserved | no command bias added | PASS |
| RUN230 duplicate resolver fields | preserved | duplicate route context still threaded | PASS |
| RUN230 no filesystem guessing | preserved | no generated folder truth added | PASS |
| RUN229 membership lineage fields | preserved | membership fields retained | PASS |
| RUN228 public flat-root disable/dev-only | preserved | routing contracts untouched | PASS |
| RUN228 public staging disable/dev-only | preserved | writer staging policy untouched | PASS |
| RUN228 archive truth labeling | preserved | archive logic untouched | PASS |
| GlobalTop10 final path | preserved | route path code untouched | PASS |
| Top5PerBucket final path | preserved | route path code untouched | PASS |
| internal atomic temp/validate/promote safety | preserved | FileIO/write flow untouched | PASS |
| RUN217–RUN226 data/proof fields | preserved | no removal in touched proof blocks found | PASS |
| FileIO | untouched | no diff | PASS |
| HUD | untouched | no diff | PASS |
| generated output evidence | untouched | not included in diff/package | PASS |
| no signal/trade permission | preserved | permission false | PASS |
| RUN238 remains next live proof | preserved | version/control seeds | PASS |

## RUN238 Evidence Seed

RUN238 must verify emitted runtime/live fields:

- `sync_bridge_version=RUN236R_v1`
- `sync_snapshot_id`
- `sync_membership_source`
- `sync_l3_source`
- `sync_l4_source`
- `sync_market_board_source`
- `sync_sdp_source`
- `sync_dossier_request_source`
- `sync_status_surface_source`
- `sync_alignment_status`
- `sync_alignment_reason`
- `sync_pending_surfaces`
- `sync_conflict_surfaces`
- `sync_boundary=source_snapshot_projection_only_not_signal_not_trade`
- `sync_trade_permission=false`
- `sync_signal_permission=false`
- `sync_execution_permission=false`
- `sync_risk_permission=false`
- Market Board, SDP, Dossier request, Scanner Status, and FunctionResults use compatible snapshot/source labels.
- No writer computes ranking/membership.
- No generated folder is used as source truth.
- No buy/sell/entry/SL/TP/lot/execute permission wording appears.

RUN238 must also re-check RUN228 topology cleanup, RUN229 lineage, RUN230 duplicate resolver, RUN231 Board blocks/matrix, RUN233 L3 denominators, RUN235 L4 transparency, compile cleanliness, and no generated evidence mutation.

## Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| RUN236 can project sync IDs source-side | Compile/live emission not yet proven | active source | missing MetaEditor/RUN238 output | 3 | 0/none | source outranks missing proof only for source presence | RUN237 compile gate + RUN238 live proof | TEST FIRST |
| Dossier request sync exists via Board | Direct DossierWriter labels not added | Board source | DossierWriter untouched | 3 | 3 | both true; Board request surface covered, direct Dossier pending | RUN237 decide if direct labels needed | no, pending only |
| Scanner/FunctionResults context source-present | Runtime files not inspected | Dispatcher/ScannerStatus source | no generated output | 3 | 0/none | source for presence only | RUN238 emission check | TEST FIRST |

No active source conflict required HOLD or KILL.

## Patch Ledger

| File | Patch |
|---|---|
| `mt5/core/ASC_Constants.mqh` | Added RUN236 sync bridge constants |
| `mt5/core/ASC_Version.mqh` | Bumped run metadata to RUN236R and seeded RUN237R/RUN238R |
| `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh` | Added additive sync fields/helpers/proof token projection |
| `mt5/runtime/ASC_Dispatcher.mqh` | Applied sync bridge after L4 snapshot commit, threaded SDP sync params, added FunctionResults/status sync context |
| `mt5/artifacts/ASC_MarketBoardWriter.mqh` | Added sync labels to Siam request block, Top10 matrix, and symbol blocks |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | Added RUN236 sync line and finish-message projection |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh` | Added Constants include for sync bridge constants |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh` | Added sync fields to SDP payload |
| `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh` | Added sync params and required token parity |
| control/report/guidebooks | Added RUN236 closeout and RUN237 seed |

## Package Validation Table

| Package Rule | Result |
|---|---|
| exact zip name `TRUTH_SEEKER_RUN236R.zip` | required |
| changed files only | yes |
| repo-relative layout preserved | yes |
| expected root `Aurora Sentinel Core/...` | yes |
| includes RUN236R_REPORT.md | yes |
| excludes generated output evidence | yes |
| excludes generated Symbol Data Packs | yes |
| excludes generated Dossiers | yes |
| excludes manifests/scanner/function result runtime evidence | yes |
| excludes Experts/Journal logs | yes |
| excludes whole repo | yes |

## Exact RUN237 Prompt Seed

```text
TRUTH SEEKER ROADMAP — RUN237R / FINAL SOURCE GATE BEFORE RUN238 LIVE PROOF — VERIFY FULL RUN228–RUN236 CORRIDOR, COMPILE RISK, PACKAGE LAW, AND EXACT LIVE EVIDENCE CHECKLIST
MODE: AUDIT + DEBUG
LIVE: no
PACKAGE: TRUTH_SEEKER_RUN237R.zip
PURPOSE:
- final source/control gate before RUN238 live proof
- verify RUN228 topology cleanup
- verify RUN229 lineage
- verify RUN230 duplicate resolver
- verify RUN231 Market Board blocks/matrix
- verify RUN233 L3 denominators
- verify RUN235 L4 transparency/correlation context
- verify RUN236 sync bridge
- verify no FileIO/path/HUD/Dossier broad rewrite drift
- verify no L3/L4 behavior/ranking/formula mutation
- verify all package law and source-control files
- build exact RUN238 live evidence checklist
- no generated output request
- no output mutation
- no signal/trade permission
```

## Final Decision

TEST FIRST
