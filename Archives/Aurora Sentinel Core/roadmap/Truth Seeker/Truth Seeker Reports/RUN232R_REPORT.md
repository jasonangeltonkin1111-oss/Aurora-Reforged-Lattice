# GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN232R / LAYER 3 CANDIDATE FILTERING DEEP SOURCE AUDIT — INSPECT GATES, DENOMINATORS, CLOSED/DEFERRED STATES, CRYPTO-LOCK RISK, AND REPAIR STALE MARKET BOARD LIVE-PROOF TOKEN IF STILL PRESENT  
MODE: AUDIT + DEBUG  
TRUTH FURNACE REQUIRED  
REPORT: RUN232R_REPORT.md  
PACKAGE: TRUTH_SEEKER_RUN232R.zip  
NEXT LIVE TEST: RUN238R  
DECISION: TEST FIRST

---

# FINAL SUMMARY

RUN232R was completed as a source audit/debug run only. No new live output was requested. No generated Symbol Data Packs, Dossiers, Manifest, Scanner Status, FunctionResults, Experts, or Journal evidence was edited or packaged.

The stale Market Board RUN130 live-proof contradiction was found in active `mt5/artifacts/ASC_MarketBoardWriter.mqh` and repaired only in the allowed locations:
- `packet_next_live_proof=RUN130R` -> `packet_next_live_proof=RUN238R`
- `claim_evidence_live_unproven_until_RUN130=true` -> `claim_evidence_live_unproven_until_RUN238=true`

L3 Candidate Filtering truth owner was identified as `mt5/candidate_filtering/ASC_SelectionFilter.mqh`. L3 consumes L1 Market State and L2 Open Symbol Snapshot truth, then L4 consumes L3 through `mt5/shortlist_selection/ASC_ShortlistSelectionEngine.mqh`. Market Board, Symbol Data Packs, Dossier, Current Focus, and HUD are consumers only and must not own L3 truth.

L3 currently does several things correctly: it has source-owned evaluation fields, reason codes, disqualifiers, dependency text, source lineage, L1/L2 revision fields, and explicit falsehood-boundary/proof tokens stating no trade permission, no entry signal, no execution permission, no final-rank authority, and no edge proof.

L3 is missing the load-bearing visibility required before L3 improvement work: it has PASS/PENDING/FAIL only, and does not expose explicit CLOSED / DEFERRED / NOT_DUE / UNKNOWN candidate states, per-bucket denominators, closed/deferred/not-due counts, unknown counts, first-failure distributions, or bucket_candidate_ready yes/limited/no outputs.

Weekend crypto-only output is plausible under normal session conditions, but not yet fully bounded by L3. L1 has open/closed/unknown/uncertain state counts and due overlays, but L3 currently collapses non-open symbols into PENDING with `market_not_open`. That is not the same as proving non-crypto buckets are lawfully closed/deferred and not silently excluded.

L3 first-failure reasons are source-visible at per-symbol evaluation level through `reason_code`, `reason_summary`, `disqualifiers`, `dependencies_text`, and `next_required_step`, but they are not aggregated into a first_failure_reason_distribution that Siam, L4, or operator surfaces can use to diagnose the full universe.

No L3 feature patch was made. No L3 gate/scoring/ranking/member/path/FileIO/HUD/Dossier broad rewrite was made. The only source patch was the allowed Market Board RUN130->RUN238 stale-token repair. Control/report files were updated to record RUN232R status.

Compile proof was not supplied and was not claimed. Runtime/live proof was not produced in RUN232R and was not claimed. Production readiness, edge, signal, trade, execution, and risk permission are explicitly not granted.

Exact next move: RUN233R / Layer 3 data-quality gates + bucket denominators patch, scoped to add explainable candidate-filtering visibility without changing L4 formulas/ranking and without trade permission.

FINAL DECISION: TEST FIRST

---

# 0. MODE LOCK

| Declaration | Required Answer | RUN232R Observed |
|---|---|---|
| current run | RUN232R | RUN232R |
| primary mode | AUDIT | AUDIT |
| secondary mode | DEBUG | DEBUG |
| live run? | no | no |
| runtime/output artifacts expected? | no new runtime output | none requested, none generated, none packaged |
| source editing allowed? | only stale RUN130->RUN238 Market Board proof-token repair if still present | only `ASC_MarketBoardWriter.mqh` token repair applied |
| L3 feature patch allowed? | no | no L3 patch |
| L3 instrumentation patch allowed? | only tiny if directly required | none |
| generated output editing allowed? | no | no |
| FileIO rewrite allowed? | no | no |
| path mutation allowed? | no | no |
| L4 scoring/formula change allowed? | no | no |
| L3 scoring/gate change allowed? | no | no |
| membership source change allowed? | no | no |
| HUD patch allowed? | no | no |
| Market Board patch allowed? | only stale RUN130 proof-token repair | yes, only this |
| Dossier broad rewrite allowed? | no | no |
| strategy/signal/trade/risk patch allowed? | no | no |
| next live test | RUN238R | RUN238R |
| production-ready claim allowed? | no | no |
| edge claim allowed? | no | no |
| signal/trade permission allowed? | no | no |
| final decision | PROCEED / HOLD / KILL / TEST FIRST | TEST FIRST |

# 1. EVIDENCE LADDER

| Evidence Class | Available In RUN232R? | What It Proves | What It Does NOT Prove |
|---:|---:|---|---|
| 0 claim/idea | yes | scope intent only | no source truth |
| 1 AI reasoning | yes | audit interpretation only | no compile/runtime/live proof |
| 2 user report/screenshots | limited prior context only | report existence/context | no current source proof |
| 3 direct source inspection | yes | active source/control/report content in uploaded repo | no compile/runtime/live proof |
| 4 compile output | no | not available | no syntax/build claim |
| 5 backtest | no | not applicable | no edge/profit claim |
| 6 OOS/walk-forward | no | not applicable | no robustness claim |
| 7 forward demo | no | not in RUN232R | no live proof |
| 8 small live | no | not in RUN232R | no live readiness |
| 9 multi-broker live | no | not available | no production boundary |
| 10 production proven | no | not available | no permanence/readiness |

Evidence ceiling: Class 3 for source inspection. Compile, runtime, live, production, edge, trade, and execution claims are forbidden.

# 2. NO-LIVE-OUTPUT BOUNDARY

RUN232R did not request, generate, edit, clean, rename, delete, package, or use new runtime output. Prior RUN217R-RUN231R reports were read-only intake only. Generated folders remain non-authoritative evidence, not source truth.

# 3. REQUIRED READ ORDER RESULT

| Read Item Group | Result | Notes |
|---|---|---|
| RUN217R-RUN231R reports | read | RUN231/RUN230/RUN229/RUN228 preservation claims used as source/control intake; RUN227 remains bounded live evidence only |
| uploaded Siam/trader-chat reports | not separately present as active report files beyond existing repo reports | no fake content inferred |
| Brain Guidebooks | read | Index/Coding/Trading brain rules converted below |
| Front door/control docs | read where present | README, MASTER_INDEX, continuation guide, roadmap/office files inspected |
| Active L3/L4/L1/L2 source | read | owner and handoff identified |
| MarketBoardWriter | read and minimally patched | only RUN130->RUN238 stale token repair |
| generated output evidence | not used as source truth | not mutated or packaged |

# 4. RUN231 SAFETY GATE BEFORE L3 AUDIT

| RUN231 Safety Item | Expected | Observed | PASS / HOLD / FAIL | Action |
|---|---|---|---|---|
| package was source/control only | yes | RUN231 report states source/control only | PASS | continue audit |
| generated output excluded | yes | RUN231 report states no output mutation | PASS | continue audit |
| Siam Dossier Request Block source-present | yes | `ASC_BoardSiamDossierRequestBlock()` present in `ASC_MarketBoardWriter.mqh:2134-2168` | PASS | preserve |
| Top10 Numeric Matrix source-present | yes | `ASC_BoardTop10NumericMatrixBlock()` present in `ASC_MarketBoardWriter.mqh:2227-2240` | PASS | preserve |
| top-1 command bias downgraded | yes | matrix/request wording says review/request and not trade signal | PASS | preserve |
| FileIO untouched | yes | no RUN232 diff in `mt5/io/ASC_FileIO.mqh` | PASS | preserve |
| final paths untouched | yes | no RUN232 diff in path/family writers | PASS | preserve |
| L3/L4 formulas untouched | yes | no RUN232 diff in L3/L4 source | PASS | preserve |
| HUD untouched | yes | no RUN232 diff in HUD source | PASS | preserve |
| Dossier broad rewrite avoided | yes | no RUN232 diff in Dossier writer | PASS | preserve |
| RUN230 duplicate resolver preserved | yes | no RUN232 diff in resolver/route logic | PASS | preserve |
| RUN229 membership lineage preserved | yes | no RUN232 diff in lineage/source pack logic | PASS | preserve |
| RUN228 topology cleanup preserved | yes | no RUN232 diff in topology/path cleanup | PASS | preserve |
| compile proof supplied | optional | none supplied | INFO | no compile claim |
| RUN238 remains next live proof | yes | Market Board stale token repaired to RUN238 | PASS | TEST FIRST due source patch |
| stale RUN130 live-proof tokens absent | yes | present in MarketBoardWriter before patch; repaired in allowed locations | PASS AFTER PATCH | package patched file |

Scope note: A broad grep still finds legacy RUN130 wording in `ASC_ScannerStatusWriter.mqh`. RUN232R was explicitly scoped to repair Market Board RUN130 tokens only, so ScannerStatus cleanup is recorded as context debt, not patched.

# 5. L3 IDENTITY AND SOURCE-OWNER AUDIT

| L3 Area | Source Owner Candidate | Source File | Observed Owner? | PASS / HOLD / FAIL | Notes |
|---|---|---|---:|---|---|
| Candidate Filtering entry point | ASC_SelectionFilter | `mt5/candidate_filtering/ASC_SelectionFilter.mqh:2332-2583`, `2602-2635` | yes | PASS | `ASC_SelectionFilterEvaluate()` and `ASC_SelectionFilterBuildSummary()` own evaluation and summary |
| L3 input source | L1/L2 structs | `ASC_SelectionFilter.mqh:4-5`, `ASC_MarketStateEngine.mqh:9-104`, `ASC_OpenSymbolSnapshotEngine.mqh:25-231` | yes | PASS | includes Market State and Open Symbol Snapshot engines |
| L3 output struct | SelectionFilter evaluation/committed state | `ASC_SelectionFilter.mqh:14-148`, `150-237` | yes | PASS | carries reason, scores, lineage, L1/L2 revisions |
| pass/fail/deferred state | SelectionFilter | `ASC_SelectionFilter.mqh:7-12` | partial | HOLD SEED | enum has PASS/PENDING/FAIL only; no explicit CLOSED/DEFERRED/NOT_DUE/UNKNOWN |
| first failure reason | SelectionFilter | `ASC_SelectionFilter.mqh:97-109`, `2332-2583` | yes per symbol | PARTIAL | reason_code visible per evaluation; no aggregate distribution |
| per-bucket denominator owner | missing | no owner found in L3 source | no | FAIL -> RUN233 | must add L3-owned bucket counters |
| weekend/closed state owner | L1 Market State consumed by L3 | `ASC_MarketStateEngine.mqh:9-23`, `ASC_SelectionFilter.mqh:2385-2395` | partial | PARTIAL | L1 owns state; L3 collapses non-open to pending market_not_open |
| data-health dependency | L2/L3 | `ASC_SelectionFilter.mqh:837-875`, `917-960` | yes partial | PARTIAL | rich tokens exist; not aggregated by bucket/reason |
| L4 handoff | ShortlistSelectionEngine | `ASC_ShortlistSelectionEngine.mqh:33-104`, `2518-2670` | yes | PASS | L4 consumes L3 row/filter, not vice versa |
| artifact visibility | MarketBoard / SDP / Dossier | `ASC_MarketBoardWriter.mqh:2134-2240`, `3089-3110` | partial | PARTIAL | visible top10 matrix exists; full-universe L3 denominator not visible |

Required conclusion: L3 truth is owned by `ASC_SelectionFilter`. L4 and artifacts consume L3. Source-owned fields include result state, reason code, disqualifiers, dependencies, scores, evidence intake, lineage, and L1/L2 revisions. Missing fields: explicit closed/deferred/not_due/unknown states, per-bucket denominators, first-failure distribution, bucket_candidate_ready, and weekend/non-crypto boundary summaries.

# 6. L3 INPUT CONTRACT AUDIT

| L3 Input | Source Owner | Required? | Present? | Missingness Handling | Risk |
|---|---|---:|---:|---|---|
| symbol identity | L0/L1 classification state | yes | yes | empty symbol -> not applicable/dependency blocked | low |
| asset_class / bucket | ClassificationBridge via L1 classification | yes | yes | unresolved -> PENDING `classification_unresolved` | low-medium: no bucket denominator |
| market_state open/closed/uncertain/unknown | L1 | yes | yes | non-open -> PENDING `market_not_open`; unknown/uncertain -> dependency blocked | medium: closed/deferred not distinct |
| tradeability/session status | L1/L2 symbol packet | yes | yes | trade mode unavailable/restricted -> PENDING | medium: wording must remain data-quality only |
| quote snapshot | L2 packet | yes for live candidate | yes | unavailable/continuity/stale -> PENDING or scoring-first carry | medium-high if PASS-with-drag hidden |
| tick age | L2 packet | yes for freshness | yes | invalid/too old -> PENDING/stale or carry | medium |
| spread/spread percent | L2 packet | yes for friction | yes | cap: crypto 1.50%, other 0.35% | medium: constants need future research/test, not tuned blindly |
| specs hydration | L2/spec owner | useful | yes | unavailable/stale/degraded -> PENDING or carry | medium |
| session hydration | L2/session owner | useful | partial | not a separate L3 denominator | medium |
| section coherence | RUN222 fields | useful | not direct in L3 | no L3 gate/distribution found | medium-high |
| crypto health | RUN224 | crypto only | not L3 direct | matrix says unknown in Market Board | medium |
| duplicate route context | RUN230 | downstream context | not L3 input | no L3 dependency | low |
| existing positions/orders | portfolio/exposure | if used | not L3 | L4/board surface area, not candidate filter | low for L3, high if mixed later |
| ATR/volatility summaries | ATRSummaryEngine/L4 | if used | L3 has ATR-relative support fields; summary engines are L4-side | scoring support only | medium |
| regime summaries | RegimeSummaryEngine/L4 | if used | L4-side | not L3 gate owner | low for L3 |
| liquidity/friction summaries | LiquidityFrictionSummaryEngine/L4 | if used | L3 has spread/liquidity scores; summary engine L4-side | partial | medium |

Hard truth: L3 must not pass a symbol using fake-ready data, and it mostly avoids this with reason codes and evidence tokens. But the scoring-first carry path can produce PASS with drag after degraded inputs, so RUN233 must make that state explicit in outputs and denominators.

# 7. L3 GATE / FAILURE REASON AUDIT

| Gate | Source Location | Pass Condition | Fail Condition | Deferred Condition | First Failure Reason Visible? | Classification / Risk |
|---|---|---|---|---|---:|---|
| market open gate | `ASC_SelectionFilter.mqh:2385-2395` | L1 state is open | none; uses pending | non-open -> PENDING `market_not_open` | yes | IMPLEMENTED / TOO BLUNT |
| tradeability gate | `ASC_SelectionFilter.mqh:2453-2475` | valid trade mode FULL | restricted/unavailable -> pending | pending | yes | IMPLEMENTED / wording risk |
| quote freshness gate | `ASC_SelectionFilter.mqh:2420-2452` | L2 fresh/aging + tick age sane | none; pending | pending stale/unavailable | yes | IMPLEMENTED |
| spread/friction gate | `ASC_SelectionFilter.mqh:2509-2521` | spread sane under cap | none; pending | spread_out_of_bounds | yes | IMPLEMENTED / constants need validation |
| tick activity gate | `ASC_SelectionFilter.mqh:2442-2452`, score fields `43-94` | valid recent tick | stale/invalid -> pending/carry | pending | yes | PARTIAL |
| data-health gate | `ASC_SelectionFilter.mqh:837-875`, `917-960` | clean/supported packet | stale/degraded tokens exist | pending/carry | partial | PARTIAL; no distribution |
| specs/session missingness gate | `ASC_SelectionFilter.mqh:2476-2508` | spec acceptable/post-warmup ok | unavailable/stale/degraded -> pending/carry | pending | yes | PARTIAL; no bucket denominator |
| section coherence gate | no direct L3 source owner found | none | none | none | no | MISSING -> RUN233 research/constraint |
| crypto-specific gate | L3 spread cap only; MB matrix crypto health unknown | crypto spread cap differs | none | none | no | PARTIAL; do not make universal |
| exposure/open-pending gate | L4/board/exposure surface, not L3 | not L3 | not L3 | not L3 | no | REJECTED for L3 until owner defined |
| warmup/not-due gate | `ASC_SelectionFilter.mqh:2498-2508`; L1 due fields in MarketState | post-warmup hydration ok | none | hydration pending | yes | PARTIAL; no not_due counter |

# 8. L3 DENOMINATOR / BUCKET COVERAGE AUDIT

| Required L3 Counter | Source-Present? | Current Owner | Visible To Outputs? | Risk If Missing | RUN233 Need |
|---|---:|---|---:|---|---|
| candidate_universe_count | partial | `ASC_SelectionFilterSummary.assessed_symbols` | limited | universe not clearly tied to bucket/state | formalize |
| bucket_universe_count | no | none | no | bucket invisibility | add |
| open_confirmed_count | partial | L1 summary | not L3-owned | false no-candidates | project into L3 denominator |
| closed_confirmed_count | partial | L1 summary | not L3-owned | crypto-lock risk | add L3 projection |
| uncertain_count | partial | L1 summary | not L3-owned | hidden uncertainty | add |
| unknown_count | partial | L1 summary | not L3-owned | silent missing data | add |
| not_due_count | partial | L1 due class | not L3-owned | false failure | add |
| deferred_until_open_count | no | none | no | weekend false failure | add |
| data_health_limited_count | partial | L3 evidence intake per symbol | no aggregate | over-filtering hidden | add |
| candidate_pass_count | yes | L3 summary | partial | no pass denominator by bucket | keep + bucketize |
| candidate_fail_count | yes | L3 summary | partial | fail not separated from pending causes | bucketize |
| candidate_deferred_count | no explicit | none | no | no defer denominator | add |
| first_failure_reason_distribution | no | none | no | poor debugging | add |
| bucket_candidate_ready | no | none | no | Siam cannot judge bucket | add yes/limited/no |

Required conclusion: Aurora currently knows L1 session state and L3 per-symbol candidate posture, but it does not yet expose enough L3-owned denominator proof to prove why only crypto appears on a weekend. RUN238 can only prove not-locked-to-crypto if RUN233 adds full-universe bucket/state/reason counters before RUN238.

# 9. WEEKEND / NON-CRYPTO LOCK RISK AUDIT

| Risk | Source Evidence | PASS / HOLD / FAIL | Notes |
|---|---|---|---|
| non-crypto symbols silently excluded | L3 summary loops all L1 cached symbols `ASC_SelectionFilter.mqh:2602-2635`, but no bucket denominators | HOLD SEED | source likely assesses full cached universe; output proof not enough |
| closed markets treated as failures | non-open -> PENDING, not FAIL `2385-2395` | PASS/PARTIAL | not failed, but also not explicit closed/deferred |
| not-due symbols treated as missing | L1 due fields exist; L3 has no not_due counter | PARTIAL | must expose not_due separately |
| crypto-only board lacks boundary | Market Board request block has active_bucket_count/crypto_only_reason but from visible top10 only | PARTIAL | not full-universe proof |
| active_bucket_count is missing or hidden | present in Market Board request block | PARTIAL | top10-visible only, not L3 denominator |
| closed_bucket_count missing | no L3 field found | FAIL -> RUN233 | needed |
| next_open_market_recheck_due missing | L1 per-symbol next_due exists | PARTIAL | no L3 aggregate / bucket surface |
| weekend boundary not visible | no L3 weekend_boundary field | FAIL -> RUN233 | needed |
| L3 pass/fail only sees open crypto | source loops all L1 cached symbols | PASS/PARTIAL | likely no source-level crypto lock, but no denominator proof |
| RUN238 weekday/non-crypto proof checklist missing | RUN233 seed needed | HOLD SEED | add acceptance test before RUN238 |

RUN233 candidate fields: `session_scope_context`, `active_bucket_count`, `active_buckets`, `closed_bucket_count`, `closed_buckets`, `deferred_bucket_count`, `deferred_buckets`, `single_bucket_warning`, `crypto_only_reason`, `not_locked_to_crypto`, `non_crypto_bucket_state_summary`, `next_open_market_recheck_due`, `weekend_boundary`.

# 10. L3 SOURCE-TRUTH FAILURE MODES

| Failure Mode | Present? | Evidence | Severity | RUN233 Patch Needed? |
|---|---:|---|---|---:|
| writer computes L3 truth | mostly no; partial projection risk | Market Board matrix says read-only source values, but computes visible active bucket from top10 | medium | yes: source label boundaries |
| L3 uses stale L2 data without warning | partial | stale/continuity reasons exist; scoring-first carry can PASS with drag | high | yes |
| L3 collapses closed/deferred/fail into one bucket | partial | PASS/PENDING/FAIL enum only; closed -> PENDING | high | yes |
| L3 hides missing specs/session | partial | per-symbol reasons exist, no aggregate | medium | yes |
| L3 over-penalizes stale stable specs/session | unknown | constants/carry behavior not runtime tested | medium | research/test |
| L3 treats crypto-specific health as universal | no direct proof | crypto-specific spread cap only; crypto health unknown in matrix | medium | guardrail |
| L3 lacks per-bucket denominators | yes | no bucket counters found | high | yes |
| L3 lacks first-failure distribution | yes | no distribution found | high | yes |
| L3 passes candidates without data-health boundary | partial | proof tokens exist; PASS-with-drag must be visible | high | yes |
| L3 implies trade readiness | no direct permission; wording risk | falsehood token forbids trade/entry/execution; fields include scalp_tradable/intraday_tradable | medium | wording fence |
| L3 feeds L4 without snapshot/lineage | partial-good | committed state carries source revisions/lineage | medium | improve visible lineage/counter handoff |

# 11. MULTI-DOMAIN RESEARCH LATTICE

Research does not prove Aurora works. It converts into constraints, tests, logs, and falsifiers.

| Research Lane | Source / Authority | Finding | Converted RUN232/RUN233 Constraint | Falsifier |
|---|---|---|---|---|
| MQL5 / MT5 source mechanics | MQL5 `SymbolInfoTick`, `SymbolInfoSessionQuote`, `SymbolInfoSessionTrade`, `CopyTicks`, `CopyRates`, `TimeCurrent`, `TimeTradeServer`, `TimeGMT` official docs | tick/session/history/time APIs have separate meanings; tick time and session time cannot be collapsed into fake open/ready | L3 must keep market state, quote freshness, tick age, session status, and history availability separate | any candidate passes with unknown/stale tick/session state and no boundary reason |
| Data quality frameworks | IBM and Collibra data-quality dimensions | completeness, validity, timeliness, consistency, uniqueness, and provenance are separate quality dimensions | add L3 denominator contract: universe, bucket counts, missingness, first-failure distribution, source owner | pass_count shown without universe/open/closed/unknown/deferred counts |
| Risk data aggregation / lineage | BIS/BCBS 239 risk data aggregation and reporting principles | risk reports need accurate, complete, timely, clear information and aggregation discipline | L3->L4 handoff must include source owner, coverage counts, and reason distributions | L4/Market Board ranks symbols without explaining candidate coverage |
| Decision systems / triage | NIST AI RMF risk-management framing | systems need context, measurement, and treatment of risks rather than opaque decision outputs | Candidate Filtering is triage/review readiness, not trade readiness; first failure reason is mandatory | L3 uses rank-like words without falsehood boundary/no-trade labels |
| Secure SDLC / source-control discipline | NIST SSDF SP 800-218; FDA software validation principles | recurrence prevention and objective evidence require root-cause changes and traceable validation | RUN233 must be small, owner-scoped, measurable, and validated by compile + RUN238 output | broad rewrite, output mutation, or no acceptance checklist |
| Protected lattice / threat model | Aurora guidebooks + source-truth doctrine | stitching systems requires lawful boundaries and no hidden ownership leaks | define L1/L2/L3/L4/artifact boundary contracts before patching | writer computes L3 or L3 mutates L4 ranking/trade permission |

# 12. BRAIN GUIDEBOOK / TWO-BRAIN CHECK

| Guidebook | Read? | Key Rule Extracted | Converted RUN232 Constraint | RUN233 Patch Implication |
|---|---:|---|---|---|
| `AURORA_GUIDEBOOK_INDEX.md` | yes | index/brain law must be consulted before source decisions | no source-owner assumption without file inspection | RUN233 prompt must require guidebook check again |
| `AURORA_CODING_BRAIN_GUIDEBOOK.md` | yes | active source files outrank roadmap prose; patch owners surgically | no L3 patch until owner/contract known | touch L3 owner and consumer surfaces only as needed |
| `AURORA_TRADING_BRAIN_GUIDEBOOK.md` | yes | scanner truth is review input, not trade permission | no candidate-readiness -> trade-readiness collapse | all new L3 fields must say review/data-readiness, not signal |

## Brain 1 — Builder Answers

- L3 owner: `ASC_SelectionFilter.mqh`.
- L3 already does correctly: per-symbol evaluation, reason code, dependencies, source lineage, falsehood boundary, L1/L2 intake, review-only posture.
- Missing but safe to patch in RUN233: denominator structs/counters, bucket counts, explicit closed/deferred/not_due/unknown projections, first_failure_reason_distribution, bucket_candidate_ready.
- Needed counters/fields: universe/open/closed/unknown/uncertain/not_due/deferred/pass/fail/pending/data_health_limited by bucket and overall.
- RUN233 source touch candidates: `mt5/candidate_filtering/ASC_SelectionFilter.mqh`, likely a consumer projection in `ASC_ShortlistSelectionEngine.mqh` or board/SDP visibility only if owner fields exist first; control/report files.
- Files to remain untouched in RUN233 unless direct proof requires otherwise: FileIO, HUD, Dossier broad writers, L4 formulas/ranking, path/family writers, generated outputs.

## Brain 2 — Auditor Answers

- Hidden crypto-lock can happen when only visible top10 buckets are counted and closed non-crypto buckets are not surfaced.
- Closed/deferred states can be hidden by collapsing all non-open states into generic PENDING.
- L3 can look cleaner while lying if PASS/PENDING/FAIL counts are shown without universe and bucket denominators.
- L3 can become a signal engine if `scalp_tradable`, `intraday_tradable`, or `entry_readiness_score` are promoted without no-trade fences.
- L4 handoff can break if RUN233 changes formulas/ranking instead of adding L3 metadata.
- Generated output can be corrupted if audit tries to patch evidence instead of source. RUN232 did not do this.

# 13. PROTECTED LATTICE / BOUNDARY CONTRACT

| Boundary | System A | System B | Lawful Interface | Source Of Truth | Allowed Crossing | Forbidden Crossing | Acceptance Criteria | HOLD / KILL Condition |
|---|---|---|---|---|---|---|---|---|
| L1 Market State ↔ L3 Candidate Filtering | open/closed truth | candidate gate | state + due/defer reason | L1 owner | market status/reason/due time | fake open | closed/deferred visible | crypto-lock or hidden non-open states |
| L2 Open Symbol Snapshot ↔ L3 | quote/spec/tick truth | filter input | data-health facts | L2 owner | freshness/friction/spec/session facts | stale fake-ready | missingness visible | fake candidate |
| L3 ↔ L4 | candidates | shortlist ranking | pass/defer/fail + reason | L3 owner | candidate set + support fields | trade signal/rank formula mutation | L4 receives explainable inputs | hidden filter |
| L3 ↔ Market Board/SDP | filter truth | artifact surfaces | counters/labels only | L3 owner | denominators and labels | writer computes hidden L3 | source labels visible | writer owns L3 |
| weekend crypto-only ↔ future weekday universe | session state | publication coverage | bounded evidence | L1/L3 | closed/deferred states | silent non-crypto absence | not_locked_to_crypto known/unknown | hidden lock |
| candidate readiness ↔ trade permission | data readiness | trading decision | data review only | Trading Brain boundary | review readiness | buy/sell/entry | permission false | signal wording |

# 14. STATIC COMPILE-RISK SWEEP

Touched source file: `mt5/artifacts/ASC_MarketBoardWriter.mqh` only.

| Static Check | Result | Evidence | Patch Needed? |
|---|---|---|---:|
| stale RUN130 token removed | PASS | no RUN130 token remains in MarketBoardWriter | no |
| RUN238 token inserted safely | PASS | `packet_next_live_proof=RUN238R`; `claim_evidence_live_unproven_until_RUN238=true` | no |
| string quote/escape risk | PASS | literal token replacement only; no syntax shape changed | no |
| required-token mismatch risk | PASS | required token and emitted packet both use RUN238R | no |
| Market Board output wording risk | PASS/PARTIAL | no broad board rewrite; live-proof wording corrected only | no RUN232 change |
| no broad board rewrite | PASS | diff limited to stale tokens | no |
| no L3/L4 formula mutation | PASS | no L3/L4 files touched | no |
| no FileIO/path mutation | PASS | no FileIO/path files touched | no |
| no signal/trade wording | PASS | no trade/signal permission added | no |

Compile proof was not supplied; therefore syntax safety is not claimed above Evidence Class 3 static inspection.

# 15. PRESERVATION CHECK

| Protected Law / Feature | Expected | Source Evidence | PASS / HOLD / FAIL |
|---|---|---|---|
| RUN231 Siam Dossier Request Block | preserved | `ASC_MarketBoardWriter.mqh:2134-2168` untouched except global token repair elsewhere | PASS |
| RUN231 Top10 Numeric Matrix | preserved | `ASC_MarketBoardWriter.mqh:2227-2240` | PASS |
| RUN231 top-1 command downgrade | preserved | matrix/request wording says not trade signal / review flow | PASS |
| RUN230 duplicate resolver fields | preserved | no RUN232 diff in duplicate resolver/route logic | PASS |
| RUN230 no filesystem guessing | preserved | no FileIO/path patch | PASS |
| RUN229 membership lineage fields | preserved | no membership source patch | PASS |
| RUN228 public flat-root disable/dev-only | preserved | no topology/path source patch | PASS |
| RUN228 public staging disable/dev-only | preserved | no topology/path source patch | PASS |
| RUN228 archive truth labeling | preserved | no archive labeling patch | PASS |
| GlobalTop10 final path | preserved | no final route path patch | PASS |
| Top5PerBucket final path | preserved | no final route path patch | PASS |
| internal atomic temp/validate/promote safety | preserved | FileIO untouched | PASS |
| RUN217-RUN226 data/proof fields | preserved | no data/proof field rewrite | PASS |
| FileIO | untouched | no diff | PASS |
| L4 rank/order/formula | untouched | no diff | PASS |
| HUD | untouched | no diff | PASS |
| generated output evidence | untouched | excluded | PASS |
| no signal/trade permission | preserved | falsehood boundaries intact | PASS |
| RUN238 remains next live proof | preserved | MarketBoard tokens repaired to RUN238 | PASS |

# 16. CONTRADICTION LEDGER

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| Control says next live proof is RUN238 | Market Board said RUN130 | RUN231/RUN232 prompt/control | `ASC_MarketBoardWriter.mqh` before patch | 3 | 3 | active source needed repair | repaired RUN130->RUN238 in MarketBoardWriter | TEST FIRST |
| Weekend crypto-only can be lawful | L3 may silently hide non-crypto denominator | session logic and L1 state | missing L3 counters | 3 | 3 | missing counters create uncertainty | seed RUN233 denominator patch | yes before proof claim |
| L3 first reasons exist | Siam/L4 cannot see distribution | `ASC_SelectionFilterEvaluation` | missing aggregate fields | 3 | 3 | both true | seed first_failure_reason_distribution | no source blocker; patch needed |
| L3 does not grant trade permission | L3 has `scalp_tradable`, `intraday_tradable`, `entry_readiness_score` wording | falsehood token | field names | 3 | 3 | falsehood token outranks if surfaced correctly | keep review-only fences; avoid signal wording | no, but guard RUN233 |
| RUN232 audit only | stale token patch made | mode lock | allowed exception | 3 | 3 | allowed exception | decision TEST FIRST | no |
| MarketBoard RUN130 repaired | ScannerStatus still has legacy RUN130 wording | MarketBoardWriter grep | ScannerStatus grep | 3 | 3 | scope outranks urge to overpatch | record context debt; do not patch in RUN232 | no L3 audit pause, but seed future hygiene |

# 17. RUN233 PATCH SCOPE SEED

TRUTH SEEKER ROADMAP — RUN233R / LAYER 3 DATA-QUALITY GATES + BUCKET DENOMINATORS — ADD EXPLAINABLE CANDIDATE FILTERING VISIBILITY WITHOUT TRADE PERMISSION  
MODE: RESEARCH + PATCH  
LIVE: no  
PACKAGE: TRUTH_SEEKER_RUN233R.zip

PURPOSE:
- patch L3 only after RUN232 audit identifies source owners
- add per-bucket denominator counters if missing
- add pass/fail/deferred/not_due/closed/unknown counts
- add first_failure_reason distribution
- add bucket_candidate_ready yes/limited/no
- add weekend/non-crypto closed/deferred visibility
- preserve RUN231 Market Board request/matrix
- preserve RUN230 duplicate resolver
- preserve RUN229 lineage
- preserve RUN228 topology cleanup
- preserve RUN217-RUN226 data/proof fields
- do not change L4 formula/ranking
- do not add signal/trade permission
- do not edit generated output
- no FileIO rewrite
- next live proof remains RUN238R

Exact RUN233 source-owner boundaries:
1. Primary owner: `mt5/candidate_filtering/ASC_SelectionFilter.mqh`.
2. Consumer visibility only after owner fields exist: Market Board / Symbol Data Pack / Scanner Status if needed.
3. Forbidden in RUN233: L4 formula/ranking changes, FileIO rewrite, path mutation, HUD compute, Dossier broad rewrite, generated output mutation, strategy/trade/risk logic.
4. Acceptance: compile clean plus generated RUN238 evidence later must show full-universe and per-bucket counts proving whether crypto-only output is session-lawful or a hidden lock.

# 18. PACKAGE VALIDATION TABLE

| Package Item | Required | Observed | PASS / FAIL |
|---|---|---|---|
| zip filename | `TRUTH_SEEKER_RUN232R.zip` | `TRUTH_SEEKER_RUN232R.zip` | PASS |
| preserve root | `Aurora Sentinel Core/...` | yes | PASS |
| include RUN232 report | yes | `roadmap/Truth Seeker/Truth Seeker Reports/RUN232R_REPORT.md` | PASS |
| include changed source only | yes | `mt5/artifacts/ASC_MarketBoardWriter.mqh` | PASS |
| include changed control files | yes if updated | roadmap/office status files | PASS |
| exclude generated outputs | yes | no generated output folders included | PASS |
| exclude whole repo | yes | changed files only | PASS |
| no FileIO | untouched | not packaged | PASS |
| no HUD | untouched | not packaged | PASS |
| no L3/L4 source patch | yes | not packaged | PASS |

# 19. FINAL DECISION

TEST FIRST
