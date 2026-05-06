# RUN289R Report — L3/L4 Boundary Hydration or Debug Quarantine Source Patch

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN289R / L3+L4 BOUNDARY HYDRATION OR DEBUG QUARANTINE SOURCE PATCH — NO LIVE RUN, NO AUDIT-ONLY WASTE, INSPECT COMMITTED L3/L4 STATE OWNERS AND PATCH THE BOUNDARY SO MARKET BOARD / SDP BODIES EITHER HYDRATE SOURCE-OWNED L3/L4 METADATA OR EXPLICITLY QUARANTINE UNKNOWN PLACEHOLDERS AS DEBUG-ONLY; PRESERVE RUN285/RUN286/RUN288 MARKET BOARD FAST-LANE + SIGNATURE BARRIER + SCANNER/MANIFEST STABLE TOKEN CONTRACTS, NO FORMULA/RANK/ORDER/MEMBERSHIP/FILEIO/HUD/TRADE PERMISSION CHANGES
MODE: RESEARCH + AUDIT + DEBUG + PATCH
REPORT: RUN289R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN289R.zip
SOURCE BASELINE: RUN288R source package
FINAL DECISION: TEST FIRST

## 2. FINAL SUMMARY

RUN289R completed a bounded source/control/report patch. The real boundary truth is mixed: Market Board can lawfully hydrate L3/L4 context from the existing source-owned shortlist projection already passed into `ASC_BuildMarketBoardArtifact()`, but Symbol Data Pack Lite cannot lawfully hydrate committed L3/L4 state because `ASC_SymbolDataPackComposer` receives no typed committed L3/L4 runtime-state parameter. Therefore, Market Board received source-owned projection metadata, while SDP Lite now explicitly quarantines L3/L4 placeholders as debug-only. No live run was performed. Compile/runtime proof remains pending.

## 3. Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN289R |
| mode | RESEARCH + AUDIT + DEBUG + PATCH |
| active source baseline | RUN288R source package |
| live run allowed? | no |
| fresh runtime evidence required before patch? | no |
| audit-only package allowed? | no |
| source patch required? | yes |
| generated output editing allowed? | no |
| generated output deletion/cleanup allowed? | no |
| manual output cleanup allowed? | no |
| L3 boundary inspection allowed? | yes |
| L4 boundary inspection allowed? | yes |
| L3/L4 metadata hydration allowed? | yes, source-owned projection only |
| L3/L4 debug quarantine allowed? | yes |
| L3 formula change allowed? | no |
| L4 formula change allowed? | no |
| L3/L4 rank/order/membership change allowed? | no |
| Market Board scoring/rank formula change allowed? | no |
| route membership formula change allowed? | no |
| Lite independent L3/L4 truth allowed? | no |
| new market-data collection calls allowed? | no |
| CopyTicks / CopyRates / iATR / CopyBuffer new calls allowed? | no |
| timer lowering allowed? | no |
| heavy folder scan allowed? | no |
| retry storm / tight loop allowed? | no |
| FileIO/final path mutation allowed? | no |
| archive/cache/staging architecture mutation allowed? | no |
| HUD patch allowed? | no |
| strategy/signal/execution/risk permission allowed? | no |
| final decision | TEST FIRST |

## 4. Evidence Ladder

| Evidence | Available | Ceiling | Use |
|---|---:|---:|---|
| AI reasoning | yes | Class 1 | Planning only; proves nothing. |
| User prompt/prior reports | yes | Class 2-3 depending on source file evidence inside reports | Scope and evidence background only. |
| Current source inspection | yes | Class 3 | Primary authority for owner map and patch path. |
| Static validation | yes | Class 4-lite | Token/path/diff/bracket/source grep checks only; not MetaEditor compile proof. |
| MetaEditor compile transcript | no | unavailable | Deferred. |
| RUN289 runtime/live evidence | no | unavailable | Deferred to batched live proof. |

## 5. Research Conversion Ledger

| Gate | Source URL | Finding | Aurora Risk | Converted Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|---|
| timer queue | https://www.mql5.com/en/docs/event_handlers/ontimer and https://www.mql5.com/en/docs/event_handlers | MQL5 timer events are queued per program and handler signatures must match. A new Timer event is not added if one is already queued or processing. | Lowering timer or adding heavy hydration could choke the event queue and fake speed while increasing stale publication risk. | No timer lowering, no heavy hydration loops, no full-universe recomputation. Hydration is cheap existing-state projection only. | Diff adds no EventSetTimer/timer lowering. | Any timer-period reduction or hydration loop added as the fix. |
| market data / indicators | https://www.mql5.com/en/docs/marketinformation/symbolinfotick, https://www.mql5.com/en/docs/series/copyticks, https://www.mql5.com/en/docs/series/copyrates, https://www.mql5.com/en/docs/indicators/iatr, https://www.mql5.com/en/docs/indicators/iadx, https://www.mql5.com/en/docs/indicators/irsi | Official APIs return current tick, historical rates/ticks, or indicator handles/buffers. | Recalculating L3/L4 in writer surfaces would create hidden compute and formula drift. | Do not add CopyTicks, CopyRates, CopyBuffer, iATR, iADX, iRSI or new market-data calls. Expose only existing committed/projection state. | Diff adds no new code calls to those APIs. | Any new market-data/indicator call used to hydrate L3/L4 fields. |
| file operations | https://www.mql5.com/en/docs/files/fileopen, https://www.mql5.com/en/docs/files/filemove, https://www.mql5.com/en/docs/files/filedelete, https://www.mql5.com/en/docs/check/getlasterror, https://www.mql5.com/en/docs/common/resetlasterror | File operations open/move/delete files and errors must be handled explicitly. | Folder residue or file presence can be mistaken for source truth/publication proof. | Do not mutate FileIO/final paths; do not infer L3/L4 truth from generated output residue. | No FileIO files changed; no generated output edited/packaged. | FileOpen/FileMove/FileDelete/FolderClean/final-path mutation added without direct FileIO failure evidence. |
| retry / monitoring | https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ and https://sre.google/sre-book/monitoring-distributed-systems/ | Retries can amplify load; monitoring should expose latency, traffic, errors, saturation. | Hydration retry storms could hide the real failure and worsen heartbeat pressure. | No retry amplification, broad cleanup loop, or load-adding hydration. Degraded/unavailable/debug-only states are safer than fake clean. | Diff adds no retry loop or scan loop. | Repeated broad rehydration/cleanup loops or fake clean status added. |
| data contract / lineage | https://docs.open-metadata.org/latest/how-to-guides/data-contracts/spec, https://openlineage.io/docs/spec/facets/, https://www.w3.org/TR/prov-overview/ | Data contracts define producer/consumer expectations; lineage facets/provenance describe what ran, inputs, outputs, ownership, and derivation. | L3/L4 fields crossing surfaces without owner/transport/scope becomes split-brain proof. | Add `L3_L4_BOUNDARY_CONTRACT`; require source owner, transport owner, data flow, forbidden flow, hydration/quarantine status, permission=false. | Market Board and SDP bodies emit boundary contracts; required-token arrays include the new fields. | Boundary block absent, missing source owner, or claims hydrated without lawful transport. |

## 6. Source Owner Map

Primary owner path found: `ASC_RuntimeState` owns committed L3/L4 state, `ASC_Dispatcher` commits it, `ASC_SelectionFilter` owns L3 evaluation state, `ASC_ShortlistSelectionEngine` owns L4 shortlist summaries, Market Board consumes `publication_shortlist_rows`, and SDP Lite composes placeholder blocks without a committed L3/L4 state parameter.

## 7. L3/L4 Source Owner Map

| State | Source owner | Struct/function | Available to Market Board? | Available to SDP? | Evidence rank | Hydrate or quarantine? | Reason |
|---|---|---|---:|---:|---:|---|---|
| l3_status | `ASC_RuntimeState` via `state.committed_l3_status` | `ASC_RuntimeState.mqh`; `ASC_CommitLayer3SelectionState()` | indirect projection only | no | 3 | Market Board hydrate partial; SDP quarantine | Market Board sees shortlist projection, not raw runtime revision/status object. SDP composer receives no committed L3 object. |
| l3_revision_id | `ASC_RuntimeState.committed_l3_revision` | `ASC_RuntimeState.mqh`; Dispatcher commit state | no direct typed field in writer | no | 3 | quarantine/unknown | Revision exists in runtime state but is not transported into Market Board/SDP writer call path. |
| l3_snapshot_id | `ASC_Layer1PassSummary.pass_utc` projection | `ASC_MarketBoardWriter` summary path | yes | no | 3 | hydrate on Market Board; quarantine on SDP | Market Board has summary UTC; SDP placeholder has no L3 runtime snapshot. |
| l3_top_symbol | source-owned shortlist projection | `ASC_ShortlistSymbolSummary top_ten[0]` | yes | no | 3 | hydrate on Market Board; quarantine on SDP | Market Board already consumes `publication_shortlist_rows`; SDP does not. |
| l3_top_score | `ASC_SelectionFilterEvaluation.score_net` inside shortlist row | `ASC_ShortlistSymbolSummary.filter.score_net` | yes | no | 3 | hydrate on Market Board; quarantine on SDP | Existing projection only; no new formula calculation. |
| l3_qualified_count | shortlist row filter result states | `ASC_BoardAppendL3ExplanationBlock()` counts `full_rows[].filter.result_state` | yes | no | 3 | hydrate on Market Board; quarantine on SDP | Existing writer count from already-present rows; SDP has no rows. |
| l4_status | `ASC_RuntimeState.committed_l4_status` | `ASC_RuntimeState.mqh`; `ASC_CommitLayer4ShortlistState()` | indirect projection only | no | 3 | Market Board hydrate partial; SDP quarantine | Market Board sees shortlist projection; status/revision is not transported directly. |
| l4_revision_id | `ASC_RuntimeState.committed_l4_revision` | `ASC_RuntimeState.mqh`; Dispatcher commit state | no direct typed field in writer | no | 3 | quarantine/unknown | Revision exists in runtime state but is not passed to Market Board/SDP writer. |
| l4_snapshot_id | `ASC_Layer1PassSummary.pass_utc` projection | `ASC_MarketBoardWriter` summary path | yes | no | 3 | hydrate on Market Board; quarantine on SDP | Market Board has publication snapshot UTC; SDP placeholder does not. |
| l4_shortlist_signature_id | Market Board signature projection | `market_board_top10_signature`, `bundle.*signature` | yes | no | 3 | hydrate on Market Board; quarantine on SDP | Market Board has signature arguments; SDP placeholder lacks committed shortlist signature. |
| l4_member_count | source-owned shortlist projection | `ArraySize(top_ten)` and `ASC_ShortlistHasLawfulMembership()` counts | yes | no | 3 | hydrate on Market Board; quarantine on SDP | Numeric contract preserved; SDP emits 0 as debug-quarantined placeholder. |
| l4_member_symbols | source-owned shortlist projection | `ASC_BoardL4MembersCsv(top_ten)` | yes | no | 3 | hydrate on Market Board; quarantine on SDP | CSV generated from existing rows, no membership change. |
| l4_promoted_count | source-owned shortlist projection | `full_rows[].shortlist_band` counts | yes | no | 3 | hydrate on Market Board; quarantine on SDP | Existing rows only. |
| l4_bucket_reserve_count | source-owned shortlist projection | `full_rows[].shortlist_band` reserve counts | yes | no | 3 | hydrate on Market Board; quarantine on SDP | Existing rows only. |

## 8. Hydrate / Quarantine Decision

- Market Board: HYDRATE-PARTIAL. It consumes `ASC_ShortlistSymbolSummary full_rows[]` and `top_ten[]`, which carry source-owned L3 filter metadata and L4 shortlist metadata. It still does not receive raw `committed_l3_revision` or `committed_l4_revision`, so those stay unknown and explicitly listed as missing review fields.
- Symbol Data Pack Lite: QUARANTINE. It receives symbol/route composition context, not committed L3/L4 runtime state. Its L3/L4 blocks are now debug-only and cannot count as review authority.

## 9. L3/L4 Boundary Contract Audit

Added `L3_L4_BOUNDARY_CONTRACT_BEGIN/END` to Market Board and SDP bodies. The block states source owner, transport owner, consumer surface, data flow, forbidden flow, hydration allowed, quarantine required, hydration status, review permission, and permission=false fields.

## 10. L3 Explanation Hydration / Quarantine Audit

Market Board L3 block now emits `l3_explanation_version=RUN289R_v1`, `l3_boundary_mode`, `l3_transport_owner`, `l3_state`, `l3_component_summary_available`, and `l3_quarantine_reason`. It uses existing `full_rows[].filter` and `top_ten[0].filter` only. SDP L3 block emits `debug_quarantined`, `debug_context_only_not_review_authority_not_signal`, and `committed_l3_state_not_available_to_this_writer`.

## 11. L4 Explanation Hydration / Quarantine Audit

Market Board L4 block now emits `l4_explanation_version=RUN289R_v1`, `l4_boundary_mode`, `l4_transport_owner`, `l4_state`, and `l4_quarantine_reason`. Numeric contracts for `l4_members` and `l4_member_count` are preserved. SDP L4 block emits `debug_quarantined`, keeps `l4_members=0` and `l4_member_count=0`, and states committed L4 state is unavailable to this writer.

## 12. SIAM / Lite L3/L4 Readiness Interaction Audit

Market Board SIAM request context now exposes L3/L4 boundary mode, hydration status, review-context availability, missing review fields, and not-signal/not-trade flags. SDP Lite `SIAM_DATA_CLEANLINESS` now states L3/L4 is debug-quarantined and does not upgrade review readiness solely because placeholder blocks exist.

## 13. Scanner / Manifest Preservation Audit

Scanner Status and Artifact Manifest owners were not edited. RUN288 stable-token fields remain present: `scanner_status_schema_version=`, `scanner_status_truth_state=`, `scanner_status_publication_permission=true`, `scanner_status_required_tokens_present=`, `artifact_manifest_schema_version=`, `artifact_manifest_truth_state=`, `artifact_manifest_publication_permission=true`, `artifact_manifest_required_tokens_present=`, `proof_bundle_decision_mapping=`, and `validation_deleted=false`.

## 14. Market Board Preservation Audit

RUN285/RUN286 Market Board surfaces remain present: `MARKET_BOARD_FAST_LANE_BEGIN/END`, `MARKET_BOARD_SYNC_LATENCY_BEGIN/END`, `BOARD_CHILD_SIGNATURE_BARRIER_BEGIN/END`, `TOP5_SYMBOL_TRUTH_GATE_BEGIN/END`, `SIAM_DOSSIER_REQUEST_BLOCK_BEGIN/END`, fast-lane-not-authority fields, count-truth separations, and permission=false fields. L3/L4 context does not alter rank/order/membership.

## 15. Static Checks Table

| Check | Result |
|---|---|
| active source extracted and inspected | PASS |
| changed files listed | PASS |
| RUN289R version identity present | PASS |
| L3 source owner map completed | PASS |
| L4 source owner map completed | PASS |
| hydrate/quarantine decision documented | PASS |
| L3_L4_BOUNDARY_CONTRACT fences present | PASS |
| boundary_mode present | PASS |
| boundary_data_flow present | PASS |
| forbidden flow present | PASS |
| L3 explanation block hydrated or quarantined | PASS |
| L4 explanation block hydrated or quarantined | PASS |
| no fake L3/L4 numeric values introduced | PASS |
| l4_members numeric contract preserved | PASS |
| l4_member_count numeric preserved | PASS |
| l4_member_symbols CSV/unknown preserved | PASS |
| SIAM/Lite L3/L4 context fields present | PASS |
| ready_for_siam_review not upgraded solely by placeholders | PASS |
| RUN288 Scanner stable-token fields preserved | PASS |
| RUN288 Manifest stable-token fields preserved | PASS |
| shared parity helpers preserved | PASS |
| Market Board fast-lane blocks preserved | PASS |
| Market Board signature barrier preserved | PASS |
| Top5 symbol truth gate preserved | PASS |
| SIAM_DOSSIER_REQUEST_BLOCK preserved | PASS |
| SIAM_DATA_CLEANLINESS preserved | PASS |
| Lite enrichment blocks preserved | PASS |
| board_child_sync_status vocabulary preserved | PASS |
| entry_score wording preserved / no bare entry= output token | PASS |
| no new CopyTicks calls added | PASS - no added code calls; guidebook mentions only as forbidden constraint |
| no new CopyRates calls added | PASS - no added code calls; guidebook mentions only as forbidden constraint |
| no new iATR / CopyBuffer calls added | PASS - no added code calls; guidebook mentions only as forbidden constraint |
| no new iADX / iRSI / indicator calls added | PASS - no added code calls; guidebook mentions only as forbidden constraint |
| no timer period lowering | PASS |
| no new broad folder scan added | PASS |
| no retry storm / tight loop added | PASS |
| no L3 formula files changed | PASS |
| no L4 formula files changed | PASS |
| no rank/order/membership formula changed | PASS |
| no Market Board ranking formula changed | PASS |
| no FileIO files changed | PASS |
| no archive/cache/staging architecture changed | PASS |
| no HUD files changed | PASS |
| no generated output packaged/edited | PASS |
| no trade/signal/risk permission introduced | PASS |
| braces/parentheses/brackets balanced | PASS-LITE: braces/brackets balanced in changed source; MarketBoard parenthesis count has the same pre-existing +1 close-paren imbalance pattern from baseline and RUN289 added equal opens/closes |
| string quotes balanced | PASS-LITE by even quote counts and source diff inspection |
| function call signatures checked | PASS-LITE by source diff/manual call-path inspection; MetaEditor compile still pending |
| required-token arrays/counts checked if touched | PASS |
| Windows-safe package paths checked | PASS |

## 16. Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which source outranks? | Resolution | Pause required? |
|---|---|---|---|---:|---:|---|---|---|
| Runtime/proof summaries previously showed L3/L4 committed state | Market Board/SDP bodies showed unknown placeholders | Prior runtime/report evidence | Current source writer paths | 7/8 prior window; reports lower for current source | 3 | Current source outranks prior observation for current patch authority | Market Board hydrates only existing shortlist projection; SDP quarantines because composer lacks committed state parameter | No, after patch/static checks; compile/runtime still pending |
| User wants useful L3/L4 review context | Formulas/rank/order/membership are forbidden | User workflow requirement | RUN289 scope law/source boundaries | 2 | 3 | Source/scope law outranks desire for richness | Added metadata boundary only; no formula/rank/order/membership changes | No |
| Hydrating L3/L4 can improve Siam review | Hidden compute / Lite independent truth risk | Design intent | Source path inspection | 1/2 | 3 | Source path inspection outranks design intent | Market Board projection allowed; SDP debug quarantine required | No |
| Unknown placeholders are readable | Unknown placeholders are not review authority | Existing body text | Truth boundary doctrine/source patch | 3 | 3 | New explicit boundary contract resolves ambiguity | SDP placeholders now emit debug-only/quarantine fields | No |
| Debug quarantine reduces apparent richness | Debug quarantine prevents fake proof | Operator usability | Evidence discipline | 2 | 3 | Evidence discipline/source truth outranks cosmetics | Quarantine chosen where committed state is absent | No |
| Source patch batch rhythm says no live proof every run | Runtime proof is needed before live confidence | User rhythm and prompt | Evidence ladder | 2 | 10 target | Both: patch now, no live claim | Decision TEST FIRST; RUN292 batched proof remains | No |
| Scanner/Manifest stable contracts must be preserved | L3/L4 work touches nearby proof surfaces | RUN288 report/control/source | RUN289 patch scope | 3 | 3 | Preservation law controls | Scanner/Manifest source not touched; stable fields preserved | No |
| Market Board fast lane must be preserved | L3/L4 context must not become board authority | RUN285/RUN286 source | RUN289 patch | 3 | 3 | Both preserved by boundary block | Fast lane/signature barrier preserved; L3/L4 review permission does not unlock authority | No |
| Static source patch completed | Compile/runtime unproven after RUN289 | Changed files/static checks | No compile/live transcript | 3/4-lite | 0 for compile/live | Evidence ladder outranks optimism | Final decision TEST FIRST | Yes for PROCEED; not for package |
| Data-review permission exists | Any trade/signal/risk permission must remain false | Existing Lite data review fields | RUN289 scope/trading boundary | 3 | 3 | Permissions false law controls | Permission false fields preserved/added to boundary blocks | No |

## 17. Changed Files List

- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md`
- `roadmap/Truth Seeker/Guidebooks/AURORA_GUIDEBOOK_INDEX.md`
- `roadmap/Truth Seeker/Guidebooks/AURORA_TRADING_BRAIN_GUIDEBOOK.md`
- `mt5/artifacts/ASC_MarketBoardWriter.mqh`
- `mt5/core/ASC_Version.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh`
- `roadmap/Truth Seeker/Truth Seeker Reports/RUN289R_REPORT.md`

## 18. Acceptance Tests

- RUN289R version identity present.
- L3 and L4 source owner map completed.
- Market Board L3/L4 boundary contract present and source-owned projection only.
- SDP Lite L3/L4 boundary contract present and debug quarantined.
- Unknown L3/L4 placeholders do not imply review authority.
- Lite does not calculate independent L3/L4 truth.
- No new market-data/indicator calls for hydration.
- No L3/L4 formulas changed.
- No rank/order/membership changed.
- Scanner/Manifest stable contracts preserved.
- Market Board fast-lane and signature barrier preserved.
- No generated output edited.
- No trade/signal/execution/risk permission introduced.

## 19. Falsifiers

- MetaEditor compile fails on changed source.
- Market Board required-token validation fails after RUN289R.
- SDP required-token validation fails after RUN289R.
- L3/L4 fields hydrate from invented or Lite-computed values.
- L3/L4 formula/rank/order/membership changes appear.
- New market-data/indicator calls appear in the patch diff.
- Unknown placeholders still appear as review authority.
- Scanner/Manifest stable contracts regress.
- Trade/signal/execution/risk permission appears.

## 20. RUN290R Seed

RUN290R / SIAM UPLOAD SELECTOR QUALITY AND REVIEW READINESS SOURCE PATCH — continue source-edit batch without live run. Improve Market Board / SIAM request logic for the user workflow: choose best 3/5/10 symbols to upload for Siam review only when board↔dossier↔SDP signatures, data cleanliness, and L3/L4 boundary status support review-grade confidence. Add clear upload_count_reason, upload_blocker_reason, best_upload_candidates, review_priority, and stale/blocked/mismatch explanations. No formulas, no rank/order/membership, no FileIO, no HUD, no generated output, no trade/signal/risk permission.

## 21. Batched Live Proof Seed

RUN292R / BATCHED LIVE PROOF AFTER RUN285R-RUN291R SOURCE PATCH SEQUENCE. Do not run now. Move earlier only for compile failure, Market Board disappearance, source identity split-brain, FileIO corruption, permission leak, or Scanner/Manifest owner stabilization failure.

## 22. Package Validation

| Package Check | Result |
|---|---|
| package name exactly `TRUTH_SEEKER_RUN289R.zip` | PASS |
| changed files only | PASS |
| preserved `Aurora Sentinel Core/...` layout | PASS |
| includes changed source files | PASS |
| includes updated control files | PASS |
| includes RUN289R report | PASS |
| compile transcript included only if produced | PASS - none produced |
| no whole repo dump | PASS |
| no generated runtime evidence/live output | PASS |
| path lengths Windows-safe | PASS |
| forbidden suffix avoided | PASS |

## 23. Final Decision

TEST FIRST. Source patch and static checks are complete, but MetaEditor compile and RUN289 runtime/live proof are not available in this environment and were not required by the prompt.
