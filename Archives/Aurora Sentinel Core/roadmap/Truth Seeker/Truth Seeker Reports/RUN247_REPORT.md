# RUN247_REPORT — Exact Per-Symbol L3/L4 Runtime Join Into SDP + Review-Gate Prep

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN247 / EXACT PER-SYMBOL L3-L4 RUNTIME JOIN INTO SDP + REVIEW-GATE PREP — SOURCE PATCH ONLY, NO LIVE RUN, NO COMPILE-ONLY RUN, NO ROUTE REWRITE, NO PATH/FILEIO/PUBLISHING-TOPOLOGY/MARKETBOARD-RANKING/L3-L4-FORMULA/MEMBERSHIP/DOSSIER-SDP-ENGINE REWRITE/HUD/STRATEGY/SIGNAL/EXECUTION/RISK CHANGES; CONTINUE AFTER RUN246 BY BINDING EXISTING SOURCE-OWNED L3/L4 RUNTIME/PUBLICATION SHORTLIST ROWS INTO PER-SYMBOL SDP CONTEXT USING SAFE SYMBOL-KEY MATCHING SO SDPS CAN CARRY ACTUAL L3 SCORE/RANK/QUALITY, L4 MEMBERSHIP/RANK/BUCKET-RANK/ROLE/SIGNATURE STATUS WHERE AVAILABLE; PREPARE REVIEW-ONLY SIAM READINESS CLASSIFICATION WITHOUT GRANTING TRADE/SIGNAL/EXECUTION/RISK PERMISSION
MODE: AUDIT + DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN247_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN247.zip
SOURCE BASELINE: Latest user-supplied Aurora Sentinel Core source zip after RUN246
FINAL DECISION: TEST_FIRST

## 2. FINAL SUMMARY

RUN247 completed as a bounded source patch, not a live proof, not compile proof, and not trade-readiness proof.

The main wound was real: RUN246 made the Symbol Data Pack say where L3/L4 should come from, but the SDP composer still hardcoded L3/L4 transport unavailable. RUN247 adds a narrow runtime-state bridge so the dispatcher can pass existing `ASC_RuntimeState` L3/L4 rows into SDP publication without route surgery, formula changes, membership changes, ranking changes, FileIO/path work, or permission changes.

The patch emits `SYMBOL_L3_L4_RUNTIME_JOIN_MAP`, upgrades `SYMBOL_L3_L4_OWNER_MAP` and `SYMBOL_L3_L4_CONTEXT` to `RUN247_v1`, and adds `SIAM_SYMBOL_REVIEW_READINESS` as review-only status. Joined values are transported only from source-owned runtime rows. Missing or ambiguous joins remain explicit gaps.

## 3. Mode Lock

| Declaration | Result |
|---|---|
| current run | RUN247 |
| mode | AUDIT + DEBUG + PATCH |
| run size | major targeted source run |
| source patch required | yes |
| live run allowed | no |
| compile-only run allowed | no |
| route work allowed | no |
| path/FileIO change allowed | no |
| formula/membership/ranking changes allowed | no |
| final permission change allowed | no |
| decision | TEST_FIRST |

## 4. Evidence Ladder

| Claim | Evidence class | Notes |
|---|---:|---|
| Active uploaded zip inspected | 3 | Source files were extracted and inspected directly. |
| Source patch completed | 3 | Changed files are present in working tree and package. |
| Static balance checks passed for touched source | 4 | Braces/parentheses/brackets and quote balance were checked for touched files. |
| Compile success | 0 | Not performed in RUN247. |
| Runtime output hydration | 0 | Not performed in RUN247. |
| Live safety/trade readiness/edge | 0 | Forbidden to claim. |

## 5. L3/L4 Runtime Owner Map

Source owners found:

- `ASC_RuntimeState.committed_l3_rows[]` stores `ASC_CommittedLayer3SymbolState`.
- `ASC_RuntimeState.publication_shortlist_rows[]` stores `ASC_ShortlistSymbolSummary` for publication shortlist context.
- `ASC_RuntimeState.committed_l4_rows[]` stores `ASC_CommittedLayer4SymbolState` with `summary` and source lineage.

RUN247 adds `SYMBOL_L3_L4_RUNTIME_JOIN_MAP` to every SDP payload. Runtime-state-aware publication emits actual match state. Legacy compose paths emit an explicit unavailable map instead of silently failing payload validation.

## 6. SDP Join Design

The dispatcher now calls `ASC_SymbolDataPackTryPublishAtomicForRouteWithRuntimeState()` for both GlobalTop10 and Top5PerBucket SDP publication. That wrapper prepares temporary RUN247 compose overrides from `ASC_RuntimeState`, calls the existing writer path, then clears overrides.

This avoids route rewrites and avoids changing generated output naming, path construction, FileIO, or publication topology.

## 7. Symbol-Key Matching Rules

Allowed keys:

- exact broker symbol from `ASC_NormalizeSymbol(symbol).raw_symbol`;
- canonical symbol from `ASC_NormalizeSymbol(symbol).canonical_symbol`;
- source-owned row symbol/canonical fields.

Forbidden keys:

- folder name;
- filename residue;
- fuzzy matching;
- stale generated-output scan;
- inferred suffix authority.

Ambiguity handling: if more than one row matches, status becomes `ambiguous`, matched values are not silently selected, and ambiguity symbols are emitted.

## 8. Transported L3 Fields Summary

RUN247 transports only source-owned L3 fields when a non-ambiguous `committed_l3_rows` join exists:

- `l3_transport_available`
- `l3_score_transport_available`
- `l3_quality_transport_available`
- `symbol_l3_status`
- `symbol_l3_score` from `ASC_CommittedLayer3SymbolState.score_net` only when `score_pack_ready`
- `symbol_l3_quality` from `score_posture/attention_posture`
- `symbol_l3_source_revision`
- `symbol_l3_snapshot_id`
- `symbol_l3_match_key`

`symbol_l3_rank` remains `unavailable` because no source-owned L3 rank field was found in the active structure. That is intentional: no fake rank.

## 9. Transported L4 Fields Summary

RUN247 transports only source-owned L4/shortlist fields when a non-ambiguous publication or committed L4 row exists:

- `l4_transport_available`
- `l4_membership_transport_available`
- `l4_rank_transport_available`
- `l4_signature_transport_available=partial` when row context exists but exact per-symbol signature comparison is not source-owned
- `symbol_l4_member`
- `symbol_l4_rank`
- `symbol_l4_bucket_rank`
- `symbol_l4_global_rank`
- `symbol_l4_role`
- `symbol_l4_source_revision`
- `symbol_l4_snapshot_id`
- `symbol_l4_match_key`

Signature/rank-order/set matches stay `unknown` unless exact source-owned comparison exists. No fake signature match was introduced.

## 10. Review Readiness Prep Summary

`SIAM_SYMBOL_REVIEW_READINESS` was added as review-only classification:

- `ready_for_siam_review=yes/limited/no`
- `ready_for_siam_trade=no`
- `recommended_siam_action=upload_review/recheck_after_refresh/source_gap`
- all trade/signal/execution/risk permissions remain false.

This is not a trade gate. It is only a file usefulness classifier.

## 11. Remaining Blockers

- Compile proof is pending.
- Runtime proof is pending.
- Published SDP output must be checked later to verify joined symbols show the expected runtime rows.
- Exact per-symbol signature comparison remains unavailable/partial unless a source-owned signature owner is later exposed.
- L3 rank remains unavailable because active source did not expose a distinct source-owned L3 rank field.

## 12. No-Route / No-Break Wall

No route files were edited. No FileIO/path files were edited. No Market Board ranking/order/formula owners were edited. No L3/L4 formula or membership logic was changed. No HUD/strategy/signal/execution/risk files were edited.

## 13. Preservation Check

RUN235-RUN246 surfaces were preserved by additive transport only. RUN246 execution facts remain unchanged. RUN247 touches only SDP composer/writer runtime transport, dispatcher callsites, version/control/report files.

## 14. Static Checks Table

| Check | Result |
|---|---|
| active source inspected | PASS |
| RUN247 version identity present | PASS |
| L3/L4 runtime row owners found | PASS |
| SDP composer join point found | PASS |
| SYMBOL_L3_L4_RUNTIME_JOIN_MAP added or mapped | PASS |
| SYMBOL_L3_L4_OWNER_MAP upgraded to RUN247_v1 | PASS |
| SYMBOL_L3_L4_CONTEXT upgraded to RUN247_v1 | PASS |
| L3 transport improved or exact join gap emitted | PASS |
| L4 transport improved or exact join gap emitted | PASS |
| source-owned symbol-key matching used | PASS |
| ambiguous joins handled safely | PASS |
| no fake L3 score inserted | PASS |
| no fake L3 rank inserted | PASS |
| no fake L4 membership inserted | PASS |
| no fake L4 rank inserted | PASS |
| no fake signature match inserted | PASS |
| no writer-owned L3/L4 calculation added | PASS |
| no route files changed | PASS |
| no route topology changed | PASS |
| no route membership changed | PASS |
| no FileIO behavior changed | PASS |
| no path changes | PASS |
| no Market Board ranking/order changes | PASS |
| no L3 formula change | PASS |
| no L4 formula change | PASS |
| no membership logic change | PASS |
| no broad Dossier/SDP engine rewrite | PASS |
| no HUD changes | PASS |
| no strategy/signal/execution/risk changes | PASS |
| final trade/signal/execution/risk remain false | PASS |
| generated output not edited/packaged | PASS |
| prior RUN235-RUN246 work preserved | PASS |
| braces/parentheses/brackets balanced for touched source | PASS for touched source files |
| string quotes balanced for touched source | PASS for touched source files |
| function signatures checked and callsites updated if changed | PASS, two dispatcher callsites updated |
| package paths Windows-safe | PASS |

## 15. Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which source outranks? | Resolution | Pause required? |
|---|---|---|---:|---:|---:|---|---|---|
| Trader chat needs real L3/L4 values | Fake rank/membership is forbidden | User prompt | RUN247 law/source boundary | 2 | 3 | Source boundary | Transport only source-owned rows, otherwise unknown/gap | No |
| SDP needs per-symbol L3/L4 join | Dossier/SDP engine rewrite is forbidden | User prompt | RUN247 law/source boundary | 2 | 3 | Source boundary | Runtime override bridge, no broad rewrite | No |
| Joining by symbol is needed | Fuzzy/filename matching is forbidden | User prompt | RUN247 law/source boundary | 2 | 3 | Source boundary | exact/canonical source-owned keys only | No |
| L4 membership should resolve | Membership logic must not change | User prompt | active source ownership | 2 | 3 | active source | copy `shortlisted/bucket_shortlisted`, do not decide membership | No |
| Signature match is needed | Fake signature match is forbidden | User prompt | active source boundary | 2 | 3 | active source | mark partial/unknown, no fake true/false | No |
| Review readiness can improve | Trade permission remains forbidden | User prompt | permission law | 2 | 3 | permission law | add review-only readiness, trade=no | No |
| Source batching continues | Live/compile proof remains pending | workflow | evidence ladder | 2 | 4 | evidence ladder | final decision TEST_FIRST | No |
| Runtime rows may exist upstream | SDP composer may not safely receive them | source inspection | source architecture | 3 | 3 | source bridge | pass runtime state at writer callsite only | No |

## 16. Changed Files List

- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `roadmap/Truth Seeker/Truth Seeker Reports/RUN247_REPORT.md`
- `mt5/core/ASC_Version.mqh`
- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh`

## 17. Acceptance Tests

Source acceptance passes by inspection. Runtime acceptance is explicitly deferred. Later live/runtime proof must verify:

- SDPs show `SYMBOL_L3_L4_RUNTIME_JOIN_MAP`.
- Matched symbols show source-owned L3/L4 facts where available.
- Missing/ambiguous joins show exact reason.
- all permission fields remain false.

## 18. RUN248 Seed

RUN248 / FINAL REVIEW GATE OR EXACT COMPILE REPAIR — if RUN247 compiles cleanly later and SDP L3/L4 join is source-resolved, prepare final review-only Siam gate. If compile/static issues appear, repair exact compile/signature issue only. No route surgery. No trade permission.

## 19. Package Validation

Package name: `TRUTH_SEEKER_RUN247.zip`

Included changed source/control/report files only. No generated output folders, evidence folders, full repo dump, or manually edited live output included.

## 20. Final Decision

TEST_FIRST. The source bridge is the correct river, but it is still unproven until compile and runtime output confirm the new SDP fields hydrate without permission leaks.
