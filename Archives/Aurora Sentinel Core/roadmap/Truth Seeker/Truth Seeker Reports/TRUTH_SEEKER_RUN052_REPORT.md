# RUN052 / LAYER 3 CANDIDATE FILTERING TRUTH REPAIR

## 1. GIT HEADER SUMMARY

GIT HEADER
TRUTH SEEKER ROADMAP — RUN052 / LAYER 3 CANDIDATE FILTERING TRUTH REPAIR — PROVENANCE / FRESHNESS / SCORE-MEANING / L3-TO-L4 AUTHORITY
ZIP-FIRST WORKFLOW
ROADMAP-FIRST REQUIRED
ACTIVE ROADMAP LOG READ FIRST
RUN051 REPORT READ FIRST
SOURCE PACKAGE READ
INTERNET RESEARCH USED AS ENGINEERING INPUT
NO LIVE TEST IN RUN052
RUN060 IS NEXT LIVE TEST
NO COMPILE CLAIM WITHOUT METAEDITOR OUTPUT
NO RUNTIME CLAIM WITHOUT FRESH OUTPUT
SOURCE AUDIT FIRST
CODE EDIT REQUIRED IF L3 SOURCE / PROOF / ARTIFACT GAP IS FOUND
OFFICE / CONTROL UPDATE REQUIRED
CHANGED-FILES ZIP REQUIRED IF FILES CHANGE
NO VERSION-ONLY UPDATE
NO OFFICE-ONLY SUCCESS
NO AUDIT-ONLY SUCCESS IF SOURCE GAP EXISTS
NO STRATEGY EXPANSION IMPLEMENTATION
NO NEW INDICATOR IMPLEMENTATION
NO SCORE FORMULA CHANGE
NO RANK FORMULA CHANGE
NO TOP 3 / TOP 5 / TOP10 SELECTION CHANGE
NO MARKET BOARD SELECTION CHANGE
NO MARKET BOARD ORDERING CHANGE
NO MARKET BOARD WORDING REWRITE
NO HUD WORK
NO DOSSIER SEMANTIC REWRITE
NO CURRENT FOCUS SEMANTIC REWRITE
NO FILEIO REWRITE
NO HEAVY REFRESH LOOP
NO PER-SYMBOL PROOF SPAM
NO BROAD DISPATCHER REWRITE
NO L4/L5/L6 PATCH

## 2. START ROADMAP STATUS

FULL TRUTH SEEKER ROADMAP PROGRESS:
Approximately 12–18% complete / conservative early-stage before RUN052.

CURRENT FOUNDATION / PROOF-CONTRACT LANE:
Approximately 92–94% source-supported after RUN050B/RUN051, pending RUN060 live proof.

RUN051 RESULT TO RESPECT:
RUN051 built a Layer 3–6 failure map and patched control/audit scaffolds only. It did not run compile or live proof. RUN051 identified Layer 3 candidate score/provenance as a major truth risk, but did not repair the Layer 3 runtime owner.

RUN052 PURPOSE:
Repair Layer 3 Candidate Filtering truth weaknesses: provenance, freshness, unavailable/closed/degraded handling, candidate-score meaning, artifact/log proof, and L3-to-L4 authority handoff.

NEXT LIVE CHECKPOINT:
RUN060 is the next planned fresh MT5 compile/live/output proof checkpoint.

NO LIVE PROOF CLAIM:
RUN052 must not claim compile, live, runtime, or post-patch runtime proof unless MetaEditor/fresh MT5 evidence is supplied.

## 3. ZIP / SOURCE INTAKE SUMMARY

Source package inspected: `Aurora Sentinel Core(269).zip`. RUN051 report and active roadmap log were present in `roadmap/Truth Seeker/`. RUN052 source audit focused on the active Layer 3 owner and direct runtime/L4/artifact/log consumers.

## 4. INTERNET RESEARCH USED

| Research question | Source used | Finding | Concrete RUN052 source question | Patch constraint | Acceptance test | Rejected misuse |
|---|---|---|---|---|---|---|
| How does MQL5 expose latest tick truth? | Official MQL5 `SymbolInfoTick` docs | The function returns current prices in `MqlTick` and returns false on failure. | Does L3 ever treat missing tick/lawful snapshot as clean candidate truth? | Missing/non-lawful tick support must map to unavailable/recoverable proof, not clean. | L3 detail includes `l3_dependency_status=missing/tick_stale` and `l3_freshness=unavailable/stale`. | Do not add new tick polling loop. |
| How are quote/trade sessions exposed? | Official MQL5 `SymbolInfoSessionTrade` / `SymbolInfoSessionQuote` docs | Session APIs expose quote/trade session times for symbol/day. | Does L3 project closed/session unavailable as tradable-now? | Closed/session state must remain non-clean proof; no entry permission claim. | L3 detail includes `session_closed`, `closed`, `trade_permission=false`. | Do not rewrite session engine. |
| How should timer cadence be understood? | Official MQL5 `OnTimer` / `EventSetTimer` docs | Timer events are driven by timer setup/handler, not file output existence. | Is L3 freshness due-driven instead of file-existence-driven? | Keep RUN050B cadence separation; only proof tokens added. | Function-result detail keeps `refresh_domain`, `refresh_status`, `last_refresh_utc`, `next_due_utc`. | Do not create heavy refresh loop. |
| How should file proof be bounded? | Official MQL5 `FileWrite` / `FileFlush` docs | File functions write/flush handles; excessive hot-path proof writes would be risky. | Does RUN052 require FileIO churn? | No FileIO rewrite; use existing function-result detail fields. | No new file writer or schema column. | Do not add per-symbol proof spam. |
| What makes defect reports actionable? | Defect-reporting standards / bug-report guidance | Expected vs actual, severity, owner, status, and evidence make defects actionable. | Does RUN052 report lead with findings, expected/actual behavior, owner, status? | Report tables must be finding-led, not file-list-led. | L3 truth failure table includes expected/actual/severity/patch decision. | Do not dump file lists as proof. |
| How should source review avoid checklist-only audit? | Static/source-review guidance | Review must trace owner, root cause, variants, and consumer impact. | Are owner functions and consumers traced? | Patch smallest owner; do not broad rewrite. | Owner/consumer trace table names functions and consumers. | Do not do architecture redesign. |
| How should logs remain useful without spam? | Structured logging / observability guidance | Structured fields are more searchable; high-cardinality/unbounded details can become costly/noisy. | Can L3 proof use compact machine tokens? | Use detail-field tokens on summary rows; no per-symbol rows. | Function-result detail includes stable tokens only. | Do not emit symbol/timestamp explosion. |

## 5. RUN051 SUMMARY QUALITY CORRECTION

| RUN051 summary weakness | Why it was weak | RUN052 reporting fix |
|---|---|---|
| Control-summary heavy | It proved the roadmap scaffold more than function-level L3 repair. | RUN052 traces owner functions and patches `ASC_SelectionFilter.mqh`. |
| Failure map not converted | L3 score/provenance risk was named but not repaired. | RUN052 adds compact L3 proof tokens and authority/freshness labels. |
| File-list-led tendency | It hid truth findings under broad administration. | RUN052 final summary is finding-led and decision-led. |
| Runtime owner not patched | Candidate Filtering owner remained with proof-token gap. | RUN052 patches L3 owner detail and runtime commit proof. |

## 6. RUN051 L3 FINDING VERIFICATION

| RUN051 L3 finding | Verified in source? | Owner file/function | RUN052 action |
|---|---|---|---|
| Candidate score/provenance can be misread as trade permission. | Yes, score summary had helpful prose but lacked required machine tokens. | `ASC_SelectionFilterPopulateScorePack`, `ASC_SelectionFilterEvidenceIntakeDetail` | Patched `l3_meaning`, `trade_permission=false`, `entry_signal=false`. |
| Score can feed L4 without enough authority clarity. | Yes, L4 receives `ranking_filter`; L3 source lineage lacked compact authority token. | `ASC_CommitLayer3SelectionState`, L4 `ASC_ShortlistBuildSummarySet` consumer | Patched L3 source lineage/detail with `l3_to_l4_authority`. |
| Stale/unavailable/degraded handling needs stronger proof. | Yes, evidence intake exists, but tokens were not the preferred compact set. | `ASC_SelectionFilterEvidenceIntakeState/Detail` | Added authority/freshness/dependency/candidate/recovery tokens. |
| L3 output must remain ranking/candidate truth, not entry signal. | Yes. Source intent existed, but not machine-readable. | `ASC_SelectionFilterPopulateScorePack`, runtime detail | Added explicit `candidate_ranking_support_only`, `trade_permission=false`, `entry_signal=false`. |

## 7. L3 OWNER / CONSUMER TRACE

| L3 truth item | Owner file | Owner function | Input source | Consumer | Artifact/log projection | Failure if wrong |
|---|---|---|---|---|---|---|
| Candidate evaluation state | `ASC_SelectionFilter.mqh` | `ASC_SelectionFilterEvaluate` | L1 state + L2 packet | Dispatcher, L4 | Dossier/Market Board/Current Focus via committed rows; function-results detail | Pending/clean/blocked meaning can be overstated. |
| Score pack | `ASC_SelectionFilter.mqh` | `ASC_SelectionFilterPopulateScorePack` | L2 quote, day range, ATR, spread, session data | L4 ranking | Score summary/reason | Candidate score can look like trade signal. |
| Evidence-intake state | `ASC_SelectionFilter.mqh` | `ASC_SelectionFilterEvidenceIntakeState` | L1/L2 freshness, continuity, spec state | Dispatcher, L4 | Function-results detail | Stale/unavailable can be read as clean. |
| Compact proof tokens | `ASC_SelectionFilter.mqh` | `ASC_SelectionFilterProofToken` | Final L3 outcome + intake state | Dispatcher, logs, L4 source lineage | Function-results detail | Missing machine-readable audit boundary. |
| Committed L3 handoff | `ASC_Dispatcher.mqh` | `ASC_CommitLayer3SelectionState` | L3 evaluation rows | L4 + artifacts | `committed_l3_reason`, `source_lineage`, function results | L4 can consume L3 without authority status. |

## 8. L3 INPUT FRESHNESS AUDIT

| Input | Owner | Freshness known? | Stale/unavailable/closed handling | Gap | Patch decision |
|---|---|---|---|---|---|
| L1 market state | `ASC_MarketStateEngine.mqh` | Yes via state/stale/degraded fields | Closed/unknown/uncertain map non-clean in L3 | Needed compact `l3_freshness`/authority token | Patched in L3 detail. |
| L2 lawful snapshot | `ASC_OpenSymbolSnapshotEngine.mqh` | Yes via packet freshness/tick/spec flags | Missing snapshot maps unavailable recoverable | Needed compact dependency token | Patched. |
| Tick time/age | L2 packet | Yes via `valid_tick_time`, `packet_age_sec` | Tick stale causes pending/stale | Needed `tick_stale` proof | Patched. |
| Trade mode/spec | L2 packet | Yes via valid/spec stale/degraded flags | Restricted/unavailable maps pending/guarded | Needed trade permission false token | Patched. |
| Dossier/file output | Artifact writers/FileIO | Not an L3 freshness source | Must not determine L3 freshness | No source bug found | Held; no FileIO change. |

## 9. L3 PROVENANCE AUDIT

| Candidate field | Provenance available? | Fresh/retained/degraded distinction? | L4 receives it? | Artifact receives it? | Patch decision |
|---|---|---|---|---|---|
| `evidence_intake_state` | Yes | Partial | Yes via filter row | Yes through committed row | Strengthened detail tokens. |
| `score_net` | Source owner known | Not directly encoded in score | Yes | Yes | Added score meaning qualifier. |
| `source_lineage` | Yes | Weak before patch | Yes | Indirectly | Added authority/freshness/dependency/L3-to-L4 tokens. |
| `score_pack_summary` | Yes | Weak as machine proof | Yes | Yes | Added `candidate_ranking_support_only` token. |
| `result_state` | Yes | Outcome known | Yes | Yes | Recomputed detail after final outcome. |

## 10. L3 SCORE-MEANING AUDIT

| Score/status field | Current meaning | Misread risk | Required qualifier | Patch decision |
|---|---|---|---|---|
| `score_net` | Ranking/candidate support | Could be read as entry/trade permission | `l3_meaning=candidate_ranking_support_only` | Patched. |
| `entry_readiness_score` | Component score | Name can imply entry signal | `entry_signal=false` | Patched in proof/summary. |
| `scalp_tradable` | L3-style fit convenience label | Could be overread | `trade_permission=false` | Patched proof boundary. |
| `result_state=PASS` | L3 candidate intake state | Could be read as permission | `l3_to_l4_authority` and downstream ownership text | Patched. |

## 11. HIDDEN GATE AUDIT

| Gate/blocker | Hard gate or scoring input? | Source evidence | Risk | Patch/hold |
|---|---|---|---|---|
| Market closed | Pending/non-clean | `market_not_open` outcome | False tradable-now if unlabeled | Patched `closed/session_closed` tokens. |
| Missing L2 packet | Pending/recoverable | `market_watch_unavailable` and intake unavailable | Could look clean if score carries | Patched. |
| Stale/degraded upstream | Pending/weak carry | stale/degraded outcomes and score penalties | Could look like clean rank | Patched. |
| Spread cap | Scoring-first guarded carry | `spread_out_of_bounds`; carry penalty possible | Could become hidden veto if overdone | Held, no formula change. |
| Trade mode FULL | Scoring/carry influence | `ASC_SelectionFilterTradeModeAllowsEntry` | Could be confused with actual trade permission | Patched `trade_permission=false`. |

## 12. UNAVAILABLE / CLOSED / UNCERTAIN HANDLING AUDIT

| State | Current L3 behavior | Clean or non-clean? | Recoverable? | Artifact/log proof | Patch decision |
|---|---|---|---|---|---|
| Fresh live | Pass/eligible if other inputs satisfied | Clean | Not applicable | Proof detail | Patched clean token. |
| Stale retained | Pending/weak carry with penalty | Non-clean | Recoverable | Detail + function result | Patched stale/recoverable token. |
| Unavailable | Pending/recoverable unavailable | Non-clean | Recoverable | Detail + function result | Patched unavailable token. |
| Closed market | Pending, await open transition | Non-clean | Recoverable by session/open transition | Detail + function result | Patched closed/session token. |
| Uncertain market | Dependency blocked | Non-clean | Not recoverable by L3 alone | Detail | Patched uncertain token. |
| Degraded packet | Pending/weak | Non-clean | Recoverable | Detail | Patched degraded token. |
| Continuity-backed | Degraded/retained | Non-clean | Recoverable | Detail | Patched retained token. |

## 13. L3-TO-L4 AUTHORITY HANDOFF AUDIT

| L3 field consumed by L4 | Freshness/provenance carried? | Risk to ranking | Patch decision |
|---|---|---|---|
| `linked_l3.evaluation` | Yes but not compact enough | L4 can rank from stale/limited L3 without obvious audit token | Patched source lineage/detail. |
| `score_net` | Score but not authority token | Rank-without-source-quality ambiguity | Patched. |
| `evidence_intake_state` | Yes | Needs handoff translation | Patched `l3_to_l4_authority`. |
| `source_ready` | Boolean only | Too coarse | Held L4 behavior; patched richer L3 lineage. |

## 14. OUTPUT PROJECTION RISK AUDIT

| L3 claim | Dossier projection | Market Board projection | Current Focus projection | Risk | Patch decision |
|---|---|---|---|---|---|
| Candidate qualified | Reads committed L3 | Reads shortlist/L3 context | Reads selected symbol L3 | May be overread as trade permission | Patched L3 tokens; no artifact wording rewrite. |
| Score summary | Projected through rows | Projected indirectly | Projected indirectly | Score can imply signal | Patched summary token. |
| Evidence intake | Projected as text/detail | Projected indirectly | Projected indirectly | Non-clean source hidden | Patched detail token. |
| L3-to-L4 handoff | Indirect | Indirect | Indirect | L4 authority ambiguity | Patched source lineage/detail. |

## 15. FUNCTION-RESULTS L3 PROOF AUDIT

| Proof need | Current row/detail token | Gap | Spam risk | Patch decision |
|---|---|---|---|---|
| Candidate meaning | Weak prose | Missing machine token | Low if summary row | Patched. |
| Trade permission false | Missing as compact token | Misread risk | Low | Patched. |
| Freshness/provenance | Evidence intake only | Not preferred tokens | Low | Patched. |
| Dependency status | Partial text | Not stable token | Low | Patched. |
| L3-to-L4 authority | Missing | Authority handoff gap | Low | Patched. |
| Per-symbol proof | Not present | No need | High if added | Rejected. |

## 16. L3 TRUTH FAILURE TABLE

| Finding ID | Failure type | Owner file | Owner function | Source evidence | Expected behavior | Actual behavior | False output risk | Severity | Patch decision |
|---|---|---|---|---|---|---|---|---:|---|
| L3-F01 | candidate_score_misread_as_trade_permission | `ASC_SelectionFilter.mqh` | `ASC_SelectionFilterPopulateScorePack` | Score summary carried numeric readiness/entry wording | Score must state candidate/ranking support only | No compact token | Score read as signal | 5 | Patched. |
| L3-F02 | missing_provenance, missing_freshness | `ASC_SelectionFilter.mqh` | `ASC_SelectionFilterEvidenceIntakeDetail` | Evidence state existed without preferred token set | Detail must expose authority/freshness/dependency | Too broad/implicit | Stale/retained source hidden | 5 | Patched. |
| L3-F03 | l3_to_l4_authority_gap | `ASC_Dispatcher.mqh` | `ASC_CommitLayer3SelectionState` | L4 consumes L3 row, source lineage lacked authority token | Handoff carries authority status | Boolean/source revision too coarse | Rank source quality unclear | 5 | Patched. |
| L3-F04 | weak_auditability | `ASC_SelectionFilter.mqh` | `ASC_SelectionFilterEvaluate` | Detail assignment occurred before final outcome | Detail must reflect final outcome | Result-sensitive token would be stale | Wrong proof state | 4 | Patched by moving assignment after final outcome. |

## 17. PATCH CANDIDATE MATRIX

| Candidate file | Patch type | Why needed | Compile risk | Runtime risk | Chosen/rejected |
|---|---|---|---|---|---|
| `ASC_SelectionFilter.mqh` | L3 token helpers/detail | Owner of candidate truth | Medium | Low | Chosen. |
| `ASC_Dispatcher.mqh` | Committed proof/source lineage | Owner of L3 commit + function result | Medium | Low | Chosen. |
| `ASC_Types.mqh` | New fields | Could store tokens structurally | High | Medium | Rejected; existing details enough. |
| `ASC_FunctionResults.mqh` | Schema/helper changes | Could centralize tokens | Medium | Medium | Rejected; no schema change needed. |
| Artifact writers | Qualifier wording | Could project tokens directly | Medium | Medium | Rejected; no active misleading artifact source proven. |
| `ASC_Version.mqh` | Run identity | Meaningful code change landed | Low | None | Chosen. |

## 18. PATCH TABLE

| File | Function/area | Patch made | Why truthful | Compile-safety note |
|---|---|---|---|---|
| `mt5/candidate_filtering/ASC_SelectionFilter.mqh` | New compact helper functions | Added authority/freshness/dependency/candidate/recovery/L3-to-L4 token helpers and `ASC_SelectionFilterProofToken`. | Converts hidden/implicit truth to stable proof tokens. | String helpers only; no formula change. |
| `mt5/candidate_filtering/ASC_SelectionFilter.mqh` | `ASC_SelectionFilterEvidenceIntakeDetail` | Added proof token and corrected claim-evidence status input. | Detail now records exact L3 meaning/provenance/freshness. | Existing detail string path; no new columns. |
| `mt5/candidate_filtering/ASC_SelectionFilter.mqh` | `ASC_SelectionFilterEvaluate` | Moved evidence-detail assignment after final outcome/scoring carry. | Prevents stale proof token derived before final L3 state. | Reordered detail assignment only. |
| `mt5/candidate_filtering/ASC_SelectionFilter.mqh` | Score pack summary/reason | Added candidate-only/trade-permission false/entry-signal false language. | Prevents score-as-permission misread. | No weights or formulas changed. |
| `mt5/runtime/ASC_Dispatcher.mqh` | L3 source lineage + result detail | Added compact proof and L3-to-L4 authority tokens. | L4 handoff now carries authority status. | Existing strings only; no scheduler/rank change. |
| `mt5/core/ASC_Version.mqh` | Version identity | Updated RUN052 scope/boundary/proof boundary. | Compile-path identity matches patch. | Preprocessor strings only. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | Active log | Prepended RUN052 result. | Current roadmap state reflects source repair. | Markdown only. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_RUN052_REPORT.md` | Report | Added this report. | Preserves finding-led audit. | Markdown only. |

## 19. BEHAVIOR DRIFT TABLE

| Forbidden drift | Checked? | Drift found? | Evidence |
|---|---:|---:|---|
| Score formula change | Yes | No | Only strings/detail helpers changed. |
| Rank formula change | Yes | No | L4 formula untouched. |
| Top-list selection change | Yes | No | No Top 3/5/10 code changed. |
| Market Board selection/order/wording rewrite | Yes | No | Market Board writer untouched. |
| HUD work | Yes | No | HUD files untouched. |
| Dossier semantic rewrite | Yes | No | Dossier writer untouched. |
| Current Focus semantic rewrite | Yes | No | Current Focus writer untouched. |
| FileIO rewrite | Yes | No | FileIO untouched. |
| Heavy refresh loop | Yes | No | Scheduler/cadence logic unchanged. |
| Per-symbol proof spam | Yes | No | Summary/detail strings only, no new per-symbol function-result rows. |
| Strategy/indicator expansion | Yes | No | No indicator/strategy logic added. |

## 20. FUTURE EDGE CANDIDATES

| Candidate improvement | Why useful | Why not implemented now | Falsifier/test | Scheduled run |
|---|---|---|---|---|
| Add richer tick-pressure evidence | Could improve early scalp ranking quality | New indicator/strategy expansion forbidden in RUN052 | Backtest/live audit proves current microstructure family lacks differentiation | Future edge phase after proof lane. |
| L4 authority-weighted ranking adjustment | Could reduce stale-rank lies | Rank formula change forbidden | Fresh output shows L4 promotes degraded L3 as clean | RUN053/RUN054 audit only unless authorized. |
| Artifact projection token surfacing | Could make operator surfaces clearer | Artifact semantic rewrite forbidden unless active misleading source proven | RUN060 output shows artifacts overstate L3 meaning | RUN060 follow-up. |
| More granular session quality model | Could improve session-aware ranking | Strategy/formula drift forbidden | Session false positives proven across regimes | Future research lane. |

## 21. REMAINING FLAWS

| Flaw | Domain | Severity | Why it remains | Scheduled run |
|---|---|---:|---|---|
| No MetaEditor compile proof | Proof | 5 | RUN052 has no supplied MetaEditor output. | RUN060 |
| No post-patch runtime output proof | Proof | 5 | RUN052 is source-only. | RUN060 |
| L4 rank reason/authority consumption still needs deep repair audit | L4 | 5 | L4 behavior intentionally untouched. | RUN053 |
| Artifact projection needs fresh output verification | Artifacts | 4 | Writers untouched pending runtime evidence. | RUN060/follow-up |

## 22. NEXT RUN DECISION

| RUN052 outcome | Next run | Why |
|---|---|---|
| L3 proof-token gap patched; no live proof claimed | RUN053 | Layer 4 must now be audited for shortlist rank-reason and authority consumption without changing rank formula unless source contract contradiction proves it. |
| Source proof lane still runtime-unproven | RUN060 | Fresh MetaEditor compile/live/output proof remains the planned checkpoint. |

## 23. FINAL SUMMARY

RUN:
RUN052 / Layer 3 Candidate Filtering truth repair.

DECISION:
AUTHORIZE RUN053. RUN052 found and patched a real L3 proof-token and authority-handoff gap while preserving score/rank/selection/HUD/artifact/FileIO boundaries. RUN060 remains the next live proof checkpoint.

TOP FINDINGS:
- L3-F01 `ASC_SelectionFilterPopulateScorePack` — candidate_score_misread_as_trade_permission — severity 5 — patched — score summaries now say candidate/ranking support only, not trade permission or entry signal.
- L3-F02 `ASC_SelectionFilterEvidenceIntakeDetail` — missing_provenance / missing_freshness — severity 5 — patched — L3 detail now includes compact authority, freshness, dependency, candidate-state, recovery, and L3-to-L4 authority tokens.
- L3-F03 `ASC_CommitLayer3SelectionState` — l3_to_l4_authority_gap — severity 5 — patched — committed L3 lineage/function-result detail now carries L3-to-L4 authority proof.
- L3-F04 `ASC_SelectionFilterEvaluate` — weak_auditability — severity 4 — patched — evidence detail now builds after final outcome/scoring carry instead of before final state settles.

PATCHES:
- `ASC_SelectionFilter.mqh` / helper + detail path — added compact L3 proof tokens — behavior drift status: no formula/rank/selection change.
- `ASC_Dispatcher.mqh` / committed L3 proof path — added L3 score meaning and L3-to-L4 authority tokens — behavior drift status: no scheduler/heavy refresh/log schema change.
- `ASC_Version.mqh` / run identity — updated to RUN052 — behavior drift status: preprocessor metadata only.
- Active roadmap/report files — recorded RUN052 source repair and proof boundary — behavior drift status: control/report only.

PROOF STATUS:
- Compile: Not claimed; MetaEditor output not supplied.
- Live: Not claimed; RUN052 is not a live run.
- Runtime: Not claimed; no fresh post-patch MT5 output supplied.
- Source: Source-supported patch completed in L3 owner and runtime proof path.

REMAINING FAILURES:
- L4 rank-reason/authority consumption still needs deep source audit — scheduled RUN053.
- Post-patch compile/live/function-results/artifact proof still absent — scheduled RUN060.

NEXT RUN:
RUN053 — Layer 4 Shortlist Selection truth repair / rank-reason and L3 authority-consumption audit.

ZIP:
Changed-files zip required and supplied.
