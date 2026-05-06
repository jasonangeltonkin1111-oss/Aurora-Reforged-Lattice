# RUN240 REPORT — Per-symbol execution facts projection owner map + safe SDP status

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN240 / PER-SYMBOL EXECUTION FACTS PROJECTION OWNER MAP + SAFE SDP/DOSSIER STATUS — SOURCE PATCH ONLY, NO LIVE RUN, NO COMPILE-ONLY RUN, NO ROUTE REWRITE, NO PATH/FILEIO/TIMING/PUBLISHING-CADENCE/GATE/MARKETBOARD-RANKING/DOSSIER-SDP-ENGINE REWRITE/HUD/STRATEGY/SIGNAL/EXECUTION/RISK CHANGES; MOVED TRADE-READINESS FORWARD BY SAFELY PROJECTING SOURCE-OWNED QUOTE/SPREAD/ATR/SPREAD-TO-ATR/SESSION/OHLC EXECUTION FACTS OR OWNER/REASON/NEXT-STEP STATUS INTO PER-SYMBOL SDP CONTEXT WITHOUT WRITER-OWNED MARKET-DATA CALCULATION OR TRADE PERMISSION
MODE: AUDIT + DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN240_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN240.zip
SOURCE BASELINE: Latest user-supplied Aurora Sentinel Core source zip after RUN239.
FINAL DECISION: TEST FIRST

## 2. FINAL SUMMARY

RUN240 is a bounded source patch, not a live test and not a compile-only proof.

The patch adds per-symbol execution fact owner/readiness projection to Symbol Data Pack composition. Each SDP can now expose whether quote, spread, ATR, spread-to-ATR, session, OHLC, and recent candle context is hydrated, limited, unavailable, or unknown, and it exposes owner/reason/next step when incomplete.

Dossier projection was inspected but skipped because SDP is the safer uploaded review target and Dossier mutation would be broader. This is a correct HOLD boundary for Dossier, not a failure of the run.

No route/path/FileIO/timing/publishing cadence/Market Board ranking/order/formula/HUD/strategy/signal/execution/risk changes were made. Trade, signal, execution, and risk permission remain false.

## 3. Mode lock

| Declaration | Result |
|---|---|
| current run | RUN240 |
| phase | Per-symbol execution facts projection foundation |
| mode | AUDIT + DEBUG + PATCH |
| source patch required | yes |
| live run allowed | no |
| compile-only run allowed | no |
| main job | safe per-symbol execution facts projection / owner map |
| route work allowed | no |
| writer-owned market-data calculation allowed | no |
| trade/signal/execution/risk permission change allowed | no |
| final decision | TEST FIRST |

## 4. Evidence ladder

| Evidence | Rank | Finding |
|---|---:|---|
| User prompt / intended RUN240 scope | 2 | Per-symbol execution facts projection required without routes, fake facts, or writer-owned market data. |
| Direct source inspection | 3 | SDP composer already has existing quote/spread/ATR/OHLC/session source-owned readers and composition body. Dossier has separate market-watch sections but broader composer surface. |
| Static validation | 4 | Touched source files have balanced braces, parentheses, brackets, and string quotes. Direct writer/composer market-data API call patterns were not added. |
| Compile output | n/a | Not run by instruction. |
| Runtime/live output | n/a | Not run by instruction. |

## 5. SDP execution facts owner map

Patched `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh`.

Added `ASC_SymbolDataPackRun240PerSymbolExecutionFactsProjectionText()` and helper functions. The block emits:

- `SYMBOL_EXECUTION_FACTS_OWNER_MAP_BEGIN/END`
- `symbol_execution_facts_owner_map_version=RUN240_v1`
- owner lines for quote, spread, ATR, spread-to-ATR, session, OHLC, and recent candles
- transport availability lines
- `writer_calculates_execution_facts=false`
- `market_data_calls_added_in_writer=false`
- `copyrates_added_in_writer=false`
- `copybuffer_added_in_writer=false`
- `iATR_added_in_writer=false`
- permission fields false

## 6. Dossier execution facts owner map

Dossier projection was skipped.

Reason: Dossier already contains market-watch quote, volatility/friction, trading conditions, and session sections, but adding a new cross-section readiness block there would be broader and riskier than the SDP insertion. RUN240’s safest useful target is the uploaded Symbol Data Pack path.

Dossier status: owner gap documented, not patched.

## 7. Per-symbol execution facts readiness summary

Added `SYMBOL_EXECUTION_FACTS_READINESS_BEGIN/END` to SDP body.

The block reports:

- overall `symbol_execution_facts_status=ready/limited/unavailable/unknown`
- quote status, age, bid/ask/last when source-owned and ready
- spread status and spread points when source-owned and ready
- ATR M5/M15 status and values when source-owned and ready
- spread-to-ATR M5/M15 ratio only when spread and ATR facts are source-owned and available
- session status and blocker reason
- OHLC and recent M5/M15 candle readiness
- `symbol_execution_facts_blocks_trade=true`
- `symbol_execution_facts_blocks_diagnostic_review=false`
- all permissions false

No fake numeric values are inserted. Missing facts emit `unavailable` and next-step text.

## 8. Projection decision

SDP projection: completed.

Dossier projection: skipped with owner/risk gap.

Reason: SDP composer already owns the per-symbol review packet body and can safely add a status block before existing quote/spread/OHLC/ATR sections. Dossier projection can be revisited later after SDP runtime proof.

## 9. Completion path integration

Market Board completion path was not edited in RUN240 because that would touch Market Board ownership after RUN238/RUN239 and was not required for safe SDP projection.

Per-symbol completion context is now carried inside SDP via `symbol_execution_facts_next_step` and `execution_fact_next_step`.

## 10. No-route / no-break wall

No route files were changed.

Not touched:

- SymbolDataPackRouting
- Dossier route writers
- GlobalTop10 route behavior
- Top5PerBucket route behavior
- FileIO/path behavior
- timing/cadence
- Market Board ranking/order/formula
- HUD
- strategy/signal/execution/risk

## 11. Preservation check

| Prior run | Preservation result |
|---|---|
| RUN227 | Preserved; scanner/artifact manifest fields not touched. |
| RUN228 | Preserved; board-child alignment diagnostic not touched. |
| RUN229 | Preserved; identity/duplicate route diagnostic not touched. |
| RUN230 | Preserved; stale RUN293-RUN303 quarantine not touched. |
| RUN231 | Preserved; top5 bucket count diagnostic not touched. |
| RUN233 | Preserved; root surface repair not touched. |
| RUN235 | Preserved; Market Board currentness/review authority not touched. |
| RUN236 | Preserved; publication resilience not weakened. |
| RUN237 | Preserved; completion path not weakened. |
| RUN238 | Preserved; board-level execution facts readiness not touched. |
| RUN239 | Preserved; L3/L4 readiness not touched. |

## 12. Static checks table

| Check | Result |
|---|---|
| active source inspected | PASS |
| RUN240 version identity present | PASS |
| SDP execution facts owner inspected | PASS |
| Dossier execution facts owner inspected | PASS |
| SYMBOL_EXECUTION_FACTS_OWNER_MAP block added or skipped with owner gap | PASS — added to SDP, Dossier skipped with owner/risk gap |
| SYMBOL_EXECUTION_FACTS_READINESS block added or skipped with owner gap | PASS — added to SDP, Dossier skipped with owner/risk gap |
| per-symbol projection decision documented | PASS |
| completion path updated for per_symbol_execution_facts if needed | PASS — SDP local next step added; Market Board completion path not edited |
| missing per-symbol execution facts have owner/reason/next step | PASS |
| no fake numeric values inserted | PASS |
| no writer-owned market data calculation added | PASS |
| no new direct SymbolInfoTick/CopyRates/CopyBuffer/iATR/session calls in writer/composer | PASS — no direct call-pattern additions; only existing source-owned SDP readers are called |
| missing execution facts block trade not file visibility | PASS |
| trade/signal/execution/risk remain false | PASS |
| RUN236 publication resilience preserved | PASS |
| RUN237 completion path preserved | PASS |
| RUN238 execution facts readiness preserved | PASS |
| RUN239 L3/L4 readiness preserved | PASS |
| no route files changed | PASS |
| no route topology changed | PASS |
| no route membership changed | PASS |
| no FileIO behavior changed | PASS |
| no path changes | PASS |
| no timing/cadence changes | PASS |
| no Market Board ranking/order changes | PASS |
| no broad Dossier/SDP engine rewrite | PASS |
| no HUD changes | PASS |
| no strategy/signal/execution/risk changes | PASS |
| generated output not edited/packaged | PASS |
| prior RUN227-RUN239 work preserved | PASS |
| braces/parentheses/brackets balanced for touched source | PASS |
| string quotes balanced for touched source | PASS |
| function signatures checked | PASS — helper signatures local and bounded |
| package paths Windows-safe | PASS |

## 13. Contradiction ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which source outranks? | Resolution | Pause required? |
|---|---|---|---|---:|---:|---|---|---|
| Main goal is trade-readiness | No trade permission can be granted yet | User RUN240 prompt | User RUN240 prompt + source boundary | 2 | 2 | Both stand | Project readiness facts only; permission stays false | No |
| Per-symbol execution facts are needed | Writer-owned market-data calculation is forbidden | User RUN240 prompt | User RUN240 prompt | 2 | 2 | Both stand | Use existing SDP source-owned readers; no writer direct API calls | No |
| SDP projection is valuable | SDP engine/route drift is dangerous | User RUN240 prompt | Source inspection / prior route break history | 2 | 3 | Source/risk boundary outranks broad change | Add local composer status block only; no route/writer rewrite | No |
| Dossier projection is valuable | Dossier engine/route drift is dangerous | User RUN240 prompt | Direct source inspection | 2 | 3 | Source/risk boundary outranks optional Dossier change | Skip Dossier; document owner/risk gap | No |
| ATR/spread/session/OHLC facts must appear | Fake values are forbidden | User RUN240 prompt | User RUN240 prompt | 2 | 2 | Both stand | Emit real source values only when ready; otherwise unavailable/reason/next step | No |
| Missing execution facts block trade | Missing execution facts must not hide files | User RUN240 prompt | RUN236/RUN237 publication doctrine | 2 | 3 | Current source/control doctrine wins | SDP block says blocks trade=true, diagnostic_review=false | No |
| More source batching before live reduces interruption | Source batch risk grows | User instruction | Engineering risk | 2 | 1 | User instruction with source boundaries | Keep patch bounded and avoid route surfaces | No |
| Route resolution still needed later | Route work is forbidden in RUN240 | User prompt | User prompt + source risk | 2 | 2 | RUN240 boundary wins | No route work; seed later work only | No |

## 14. Changed files list

- `mt5/core/ASC_Version.mqh`
- `mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `office/ROADMAP_STATUS.md`
- `office/WORK_LOG.md`
- `office/CHANGE_LEDGER.md`
- `office/DECISIONS.md`
- `roadmap/Truth Seeker/Truth Seeker Reports/RUN240_REPORT.md`

## 15. Acceptance tests

Source acceptance passed within static limits:

- RUN240 identity present.
- SDP execution facts owner/readiness added.
- Dossier skipped with owner/risk gap.
- Missing execution facts include owner/reason/next step.
- No fake quote/spread/ATR/session/OHLC values.
- No new direct writer/composer market-data API calls.
- Missing execution facts block trade, not diagnostic review.
- Permissions remain false.
- No route/path/FileIO/timing/ranking/HUD/strategy/signal/execution/risk changes.

Runtime acceptance remains pending by instruction.

## 16. RUN241 seed

RUN241 / PER-SYMBOL L3-L4 CONTEXT OR LIVE CHECKPOINT PREP — choose based on RUN240 review. If SDP execution projection compiles cleanly and the batch is large enough, prepare the next batched live checkpoint. If another source layer is still safe and useful before live, add per-symbol L3/L4 context without route surgery.

## 17. Package validation

Package target: `TRUTH_SEEKER_RUN240.zip`.

Package contents: changed source/control files and RUN240 report only.

Excluded: full repo dump, generated runtime output, evidence folders, manually edited live output.

## 18. Final decision

TEST FIRST.

This patch is source-clean by static inspection, but it is not compile proof, runtime proof, live safety, trade readiness, or edge proof.
