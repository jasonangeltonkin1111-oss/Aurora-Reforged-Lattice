# TRUTH SEEKER RUN064 REPORT — PORTFOLIO PRE-LIVE READINESS + RECENT CLOSED TRADES HISTORY EXTENSION

```text
GIT HEADER
TRUTH SEEKER ROADMAP — RUN064 / PORTFOLIO PRE-LIVE READINESS + RECENT CLOSED TRADES HISTORY EXTENSION
PORTFOLIO MINI-PHASE RUN061–RUN065
RUN064 IS SOURCE / READINESS ONLY
NO LIVE TEST IN RUN064
RUN065 IS NEXT LIVE TEST
NO FAKE COMPILE CLAIM
NO FAKE LIVE CLAIM
NO FAKE RUNTIME CLAIM
```

FULL TRUTH SEEKER ROADMAP PROGRESS:
Approximately 13–19% complete / conservative early-stage before RUN064.

CURRENT FOUNDATION / PROOF-CONTRACT LANE:
Approximately 96–97% source/log-audited after RUN060/RUN061/RUN062/RUN063, but RUN061/RUN062/RUN063/RUN064 portfolio patches remain live-unproven until RUN065.

RUN063 RESULT TO RESPECT:
RUN063 source-closed the portfolio/L4/artifact alignment lane. It verified portfolio snapshot ownership, FunctionResults aggregate proof readiness, bucket-local labels, L4 admission behavior, Market Board/Dossier/Current Focus projection paths, and patched snapshot reuse/cost seams in artifact helpers and Layer 4. RUN063 did not live-prove the new behavior. RUN065 remains the live proof checkpoint.

RUN064 PURPOSE:
Add or verify recent closed-trade history truth, default latest 20 closed trades, as Market Board portfolio history context and optional selected-symbol Dossier/Current Focus context. Then finalize RUN065 pre-live package readiness, pass/fail/block criteria, and upload checklist.

NEXT LIVE CHECKPOINT:
RUN065 is the next planned live proof checkpoint for portfolio exposure and recent closed-trade history.

NO FAKE PROOF CLAIM:
RUN064 must not claim the portfolio or closed-trade history patches are live-proven. Existing output only proves the prior state that produced it, not new RUN061/RUN062/RUN063/RUN064 code.

## 1. SOURCE / REPORT INTAKE

| Check | Result | Evidence path | Decision |
|---|---|---|---|
| Source package found | yes | `/mnt/data/Aurora Sentinel Core(286).zip` extracted to `Aurora Sentinel Core/` | continue |
| Recursive .mqh count | 99 | `mt5/portfolio/ASC_PortfolioExposureSnapshot.mqh`, `mt5/runtime/ASC_Dispatcher.mqh` | continue |
| Recursive .mq5 count | 1 | `mt5/AuroraSentinelCore.mq5` | continue |
| Compile root found | yes | `mt5/AuroraSentinelCore.mq5` | continue |
| Roadmap root found | yes | `roadmap/Truth Seeker/` | continue |
| RUN061 report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN061_REPORT.md` | continue |
| RUN062 report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN062_REPORT.md` | continue |
| RUN063 report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN063_REPORT.md` | continue |
| RUN001-RUN061 report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN001_TO_RUN061_FORENSIC_VERIFICATION_REPORT.md` | continue |
| RUN061/RUN062/RUN063 source state found | yes | active patched source plus reports | continue |
| Latest live output found | no | none supplied in this package | continue/partial |
| FunctionResults found | no fresh output log supplied | source owner `mt5/logging/ASC_FunctionResults.mqh` present | continue/partial |

## 2. RUN061 / RUN062 / RUN063 PATCH VERIFICATION

| Patch claim | Verified in source? | Owner file/function | RUN064 implication |
|---|---|---|---|
| Canonical open/pending portfolio snapshot owner | yes | `ASC_PortfolioExposureSnapshot.mqh` / `ASC_PortfolioBuildExposureSnapshot` | preserve and extend, no duplicate owner |
| Open positions detail fields | yes | `ASC_PortfolioPositionDetailLine` | Market Board already can render full open trade details |
| Pending orders detail fields | yes | `ASC_PortfolioOrderDetailLine` | Market Board already can render pending order details |
| Aggregate portfolio proof tokens | yes | `ASC_PortfolioAggregateProofTokens`, `ASC_Dispatcher.mqh` | extend with history tokens only |
| Market Board portfolio section | yes | `ASC_MarketBoardWriter.mqh` calls `ASC_PortfolioExposureDetailsText` | helper extension reaches Market Board |
| Dossier selected-symbol exposure | yes | `ASC_DossierComposer.mqh` calls `ASC_PortfolioSelectedSymbolExposureDetailsText` | helper extension reaches Dossier |
| Current Focus mirror path | source-supported | Current Focus mirrors Dossier content path | no direct writer patch required |
| Snapshot reuse/cost hardening | yes | artifact helpers and L4 snapshot-with-snapshot functions | preserve no duplicate owner |

## 3. DEEP RESEARCH CONVERSION

| Research item | Source used | Engineering finding | Source-owner question | Patch constraint | Artifact/proof requirement | RUN065 live test |
|---|---|---|---|---|---|---|
| Open positions | Official MQL5 position functions | Positions are selected by ticket/index, then read via PositionGet* | Does snapshot own open trade detail? | preserve existing owner | open_trade_count and full SL/TP/entry/profit detail | open trade appears with details |
| Pending orders | Official MQL5 order functions | Orders are not positions; active pending order list is separate | Does snapshot own pending detail? | preserve pending owner | pending_order_count and order setup/expiration/SL/TP | pending order appears with details |
| History selection | Official `HistorySelect` docs | HistorySelect builds order/deal lists; HistoryDealsTotal and HistoryOrdersTotal read selected lists | Is there a history owner? | add inside portfolio snapshot only | history_snapshot_status not zero-on-failure | history unavailable is not treated as zero |
| Deal properties | Official deal properties docs | Exit deals expose close time/price/profit/commission/swap and `DEAL_POSITION_ID`; entry reconstruction requires pairing | Does source fake entry? | label partial when pair missing | entry_reconstruction_status and source_quality | closed trades show partial/unavailable honestly |
| Order history properties | Official order properties docs | Historical order can supply ORDER_SL/ORDER_TP where available | Can SL/TP be projected? | read only via deal order ticket | closed_sl/closed_tp or unavailable | SL/TP fields present/labelled |
| Account support | Official AccountInfoDouble docs | balance/equity/margin/free margin/margin level are account properties | Is account summary still emitted? | no rewrite | account line in Market Board | Market Board account summary exists |
| Symbol/risk support | Official SymbolInfoTick/SymbolInfoDouble docs | tick/risk fields are best-effort; unavailable must not be faked | Does history patch add tick loops? | no CopyRates/CopyTicks, no broad symbol loop | none for history | no history-induced tick loop |
| Portfolio concentration | Engineering rule | open is active exposure; pending is future exposure; closed history is context | Are closed trades blockers? | closed history never enters `ASC_PortfolioExposureSymbols` | `candidate_blocker=false` history label | closed-only symbol is not blocked |
| Observability | Structured logging / cardinality guidance | per-trade rows would be high-cardinality proof spam | Are FunctionResults aggregate only? | aggregate tokens only | recent_closed_trade_count/limit/status tokens | no per-trade FunctionResults rows |
| Release readiness | Test reporting references | pass/fail/block needs expected vs actual evidence | Is RUN065 checklist exact? | update report/control | package checklist + test plan | RUN065 uploads prove/falsify source |

## 4. RECENT CLOSED TRADE OWNER AUDIT

| History truth item | Owner file | Owner function | Source API/state | Gap | Patch decision |
|---|---|---|---|---|---|
| Default latest 20 closed trades | `ASC_PortfolioExposureSnapshot.mqh` | `ASC_PortfolioBuildRecentClosedTradeHistory` | `HistorySelect`, `HistoryDealsTotal`, reverse deal walk | missing pre-RUN064 | patched |
| Deal ticket/order ticket/symbol | same | same | `HistoryDealGetInteger/String` | missing pre-RUN064 | patched |
| Close time/price/profit/commission/swap/net | same | same | `DEAL_TIME`, `DEAL_PRICE`, `DEAL_PROFIT`, `DEAL_COMMISSION`, `DEAL_SWAP` | missing pre-RUN064 | patched |
| Entry reconstruction | same | `ASC_PortfolioFindEntryDealForPosition` | `DEAL_POSITION_ID`, `DEAL_ENTRY_IN` | missing pre-RUN064 | patched with partial label |
| SL/TP from order history | same | history builder | `HistoryOrderGetDouble(ORDER_SL/ORDER_TP)` | missing pre-RUN064 | patched best-effort |
| Closed history non-blocker | same | `ASC_PortfolioSymbolExposureSummaryText`, `ASC_PortfolioExposureSymbols` | active arrays only | required explicit label | patched |

## 5. RECENT CLOSED TRADE FIELD COMPLETENESS

| Field | Captured? | Reconstructed? | Artifact projected? | Source quality | Patch decision |
|---|---:|---:|---:|---|---|
| deal ticket | yes | no | yes | complete | patched |
| order ticket | yes | no | yes | complete when available | patched |
| symbol | yes | no | yes | complete | patched |
| type/direction | yes | no | yes | complete | patched |
| volume | yes | no | yes | complete | patched |
| entry/open time | best-effort | yes by paired entry deal | yes | complete/partial | patched |
| entry price | best-effort | yes by paired entry deal | yes | complete/partial | patched |
| close time | yes | no | yes | complete | patched |
| close price | yes | no | yes | complete | patched |
| stop loss | best-effort | from order history | yes | available/unavailable | patched |
| take profit | best-effort | from order history | yes | available/unavailable | patched |
| profit | yes | no | yes | complete | patched |
| commission | yes | no | yes | complete when broker supplies | patched |
| swap | yes | no | yes | complete when broker supplies | patched |
| net result | yes | calculated from profit+commission+swap | yes | complete when components supplied | patched |
| magic/comment | yes | no | yes | available/unavailable | patched |
| close reason | yes numeric | no | yes | complete | patched |
| history status/source quality | yes | no | yes | explicit | patched |
| paired entry status | yes | no | yes | explicit | patched |

## 6. HISTORY QUALITY / LIMITATION AUDIT

| History item | Source status | Limitation | Required label | Patch decision |
|---|---|---|---|---|
| `HistorySelect` failure | possible | broker/platform may fail history query | `history_snapshot_status=unavailable`; not zero | patched |
| Entry reconstruction | conditional | no single exit deal reliably carries original entry | `entry_reconstruction_status=partial` | patched |
| SL/TP history | conditional | order history may show zero/no SL/TP | `unavailable` value text | patched |
| Latest 20 limit | enforced | reverse selected deal list until 20 exit deals | `history_window=latest_20` | patched |
| Closed history as exposure | forbidden | closed trades are not active risk | `active_exposure=false`, `candidate_blocker=false` | patched |

## 7. MARKET BOARD PORTFOLIO HISTORY AUDIT

| Section | Open positions | Pending orders | Recent closed trades | Gap | Patch decision |
|---|---|---|---|---|---|
| Account/Risk portfolio section | already rendered | already rendered | now rendered via helper | closed missing pre-RUN064 | patched helper; no board redesign |
| Detail cap | active exposure capped by max rows | active exposure capped by max rows | closed capped latest 20 | history limit missing | patched |
| Labelling | `exposure_status=open_trade` | `exposure_status=pending_order` | `exposure_status=closed_history_context` | closed status missing | patched |

## 8. DOSSIER / CURRENT FOCUS HISTORY AUDIT

| Selected-symbol history truth | Dossier projection | Current Focus projection | Gap | Patch decision |
|---|---|---|---|---|
| selected open/pending exposure | present via `ASC_PortfolioSelectedSymbolExposureDetailsText` | mirror-supported | none | preserved |
| selected recent closed history | now present when symbol matches recent history | mirror-supported through Dossier content | missing pre-RUN064 | patched helper |
| no selected history | explicit none line | mirror-supported | ambiguity risk | patched |
| history unavailable | explicit unavailable/not-zero line | mirror-supported | zero-false risk | patched |

## 9. FUNCTIONRESULTS PORTFOLIO/HISTORY PROOF AUDIT

| Proof token | Owner file/function | Present? | Aggregate only? | Gap | Patch decision |
|---|---|---:|---:|---|---|
| portfolio_snapshot_status | `ASC_PortfolioAggregateProofTokens` | yes | yes | none | preserved |
| portfolio_truth_source | same | yes | yes | none | preserved |
| open_trade_count | same | yes | yes | none | preserved |
| pending_order_count | same | yes | yes | none | preserved |
| recent_closed_trade_count | same | yes | yes | missing pre-RUN064 | patched |
| recent_closed_trade_limit=20 | same | yes | yes | missing pre-RUN064 | patched |
| history_snapshot_status | same | yes | yes | missing pre-RUN064 | patched |
| history_truth_source | same | yes | yes | missing pre-RUN064 | patched |
| history_window=latest_20 | same | yes | yes | missing pre-RUN064 | patched |
| history_quality | same | yes | yes | missing pre-RUN064 | patched |
| behavior_change=portfolio_history_context_only | same | yes | yes | needed precision | patched |
| no per-trade rows | source path | yes | yes | spam risk controlled | patched by aggregate-only design |

## 10. L4 CLOSED-HISTORY NON-BLOCKER AUDIT

| Rule | Current source behavior | Required behavior | Gap | Patch decision |
|---|---|---|---|---|
| Open trade blocks same-symbol clean candidacy | active arrays only | block/reserve | none | preserved |
| Pending order blocks same-symbol clean candidacy | active arrays only | block/reserve | none | preserved |
| Correlation checks use open/pending exposure symbols | `ASC_PortfolioExposureSymbols` includes positions/orders only | no closed history symbols | none | preserved |
| Closed-only symbol is not active exposure | closed history array excluded from exposure symbols | context only | needed explicit labels | patched |
| Correlation unavailable remains not clean | L4 existing portfolio/correlation semantics | not clean | no RUN064 formula change | preserved |

## 11. RUN065 LIVE PACKAGE CHECKLIST

| Upload item | Required? | Why | Pass/fail/block use |
|---|---:|---|---|
| RUN065 source zip | yes | verify source identity | block if missing |
| MetaEditor compile output | yes if available | compile proof | fail if compile errors |
| fresh MT5 output package | yes | runtime proof | block if absent for live proof |
| `Workbench/logs/function_results.log` | yes | aggregate proof row | fail if missing tokens |
| Market Board | yes | open/pending/closed projection | fail if history section missing |
| selected Dossier | yes | selected-symbol portfolio/history truth | fail if selected history drops |
| Current Focus | yes | Dossier mirror | fail if mirror drops truth |
| Artifact Bundle Manifest | yes | publication integrity | fail if stale/missing |
| Scanner Status/Open Symbol Snapshot/GlobalTop10 | yes if produced | L4/exposure proof context | partial if absent |
| Screenshots | optional | supporting evidence only | never primary proof |

## 12. RUN065 PASS / FAIL / BLOCK CRITERIA

| Status | Criteria | Evidence required |
|---|---|---|
| PASS | compile succeeds; open/pending/recent closed latest 20 appear; closed history labelled context; FunctionResults aggregate tokens exist; no per-trade spam | source zip, compile output, Market Board, Dossier, Current Focus, function_results.log |
| FAIL | compile fails; closed history missing; closed history treated as active blocker; history unavailable interpreted as zero; aggregate proof missing | compile errors or output mismatch |
| BLOCK | source/output package corrupt or critical required files absent | unreadable source/output or missing compile root |

## 13. PORTFOLIO/HISTORY FAILURE TABLE

| Finding ID | Failure type | Owner file | Owner function | Evidence | Expected behavior | Actual behavior | Severity | Patch decision |
|---|---|---|---|---|---|---|---:|---|
| RUN064-F01 | history_snapshot_missing | `ASC_PortfolioExposureSnapshot.mqh` | snapshot owner | no `HistorySelect`/closed history support pre-patch | latest 20 closed trades | absent | 5 | patched |
| RUN064-F02 | functionresults_history_token_gap | same | `ASC_PortfolioAggregateProofTokens` | no `recent_closed_trade_count` tokens pre-patch | aggregate history tokens | absent | 4 | patched |
| RUN064-F03 | closed_trade_missing_from_market_board | helper path | `ASC_PortfolioExposureDetailsText` | Market Board used helper but helper lacked history | closed history context visible | absent | 5 | patched |
| RUN064-F04 | closed_trade_missing_from_dossier | helper path | `ASC_PortfolioSelectedSymbolExposureDetailsText` | selected-symbol helper lacked history | selected symbol history context | absent | 4 | patched |
| RUN064-F05 | history_unavailable_treated_zero | snapshot owner | history build | no history status existed | unavailable must not equal zero | ambiguous | 5 | patched |
| RUN064-F06 | entry_reconstruction_overclaim | snapshot owner | entry pairing | single exit deal cannot prove entry alone | partial label if pair missing | unsupported pre-patch | 4 | patched |

## 14. PATCH CANDIDATE MATRIX

| Candidate file | Patch type | Why needed | Compile risk | Runtime risk | Chosen/rejected |
|---|---|---|---|---|---|
| `mt5/portfolio/ASC_PortfolioExposureSnapshot.mqh` | source owner extension | owns portfolio truth | medium | bounded history query | chosen |
| `mt5/artifacts/ASC_MarketBoardWriter.mqh` | direct board edit | board uses helper already | medium | redundant | rejected |
| `mt5/artifacts/dossier/ASC_DossierComposer.mqh` | direct dossier edit | selected helper already used | medium | redundant | rejected |
| `mt5/runtime/ASC_Dispatcher.mqh` | direct token edit | aggregate helper already used | medium | redundant | rejected |
| `mt5/core/ASC_Version.mqh` | identity update | meaningful code change | low | none | chosen |
| roadmap/control reports | status update | RUN064/run065 proof lock | none | none | chosen |

## 15. PATCH TABLE

| File | Function/area | Patch made | Why truthful | Compile-safety note |
|---|---|---|---|---|
| `mt5/portfolio/ASC_PortfolioExposureSnapshot.mqh` | structs/snapshot | added `ASC_PortfolioClosedTradeDetail`, history fields, default latest 20 | closed trades now first-class history context | brace/paren static balance checked |
| same | `ASC_PortfolioBuildRecentClosedTradeHistory` | added `HistorySelect` + reverse exit-deal collection | reads broker history without execution or trade management | no CopyRates/CopyTicks, no per-symbol loop |
| same | `ASC_PortfolioFindEntryDealForPosition` | reconstructs entry via same `DEAL_POSITION_ID` when available | avoids fake entry claims | partial label on miss |
| same | `ASC_PortfolioAggregateProofTokens` | added history aggregate tokens | FunctionResults remains aggregate-only | no log schema change |
| same | `ASC_PortfolioExposureDetailsText` | Market Board helper now prints account/open/pending/recent closed | board gets history without redesign | existing writer call preserved |
| same | `ASC_PortfolioSelectedSymbolExposureDetailsText` | selected symbol now includes matching recent closed history | Dossier/Current Focus path gets bounded context | existing composer call preserved |
| `mt5/core/ASC_Version.mqh` | version identity | updated to RUN064 + RUN064 scope/boundary/proof boundary | source identity matches patch | macro-only |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | active log | added RUN064 status and RUN065 checklist | control truth updated | docs-only |
| `roadmap/Truth Seeker/TRUTH_SEEKER_RUN001_TO_RUN061_FORENSIC_VERIFICATION_REPORT.md` | forensic addendum | added RUN064 unverified proof debt | proof debt not hidden | docs-only |
| `roadmap/Truth Seeker/TRUTH_SEEKER_RUN064_REPORT.md` | report | added this report | RUN064 audit evidence | docs-only |

## 16. BEHAVIOR DRIFT TABLE

| Forbidden drift | Checked? | Drift found? | Evidence |
|---|---:|---:|---|
| strategy expansion | yes | no | no indicators/strategies added |
| trade execution/management | yes | no | no OrderSend/modify/close calls added |
| score/rank formula rewrite | yes | no | L4 formula untouched |
| closed trades as blockers | yes | no | closed history excluded from `ASC_PortfolioExposureSymbols` |
| Market Board redesign | yes | no | helper-only projection |
| HUD work | yes | no | no HUD files edited |
| FileIO rewrite | yes | no | no FileIO edits |
| heavy CopyRates/CopyTicks loop | yes | no | none added |
| per-trade FunctionResults spam | yes | no | aggregate tokens only |

## 17. RUN065 TEST PLAN

| Scenario | Required setup | Required output | Pass condition | Fail condition |
|---|---|---|---|---|
| Open trade detection | at least one open trade if possible | Market Board + Dossier | trade ticket, symbol, entry, SL, TP, profit visible | missing/clean candidate |
| Pending order detection | at least one pending order if possible | Market Board + Dossier | order ticket, price, SL, TP, setup/expiration visible | missing/clean candidate |
| Recent closed latest 20 | account with recent closed history | Market Board | latest closed history rows with count/limit 20 | closed rows absent |
| Selected-symbol closed history | select symbol with recent close if possible | Dossier + Current Focus | matching closed history context appears | context dropped |
| Closed-only non-blocker | closed trade symbol with no open/pending | GlobalTop10/Market Board | not blocked solely by closed history | closed history blocks candidate |
| High-correlation active exposure | open/pending correlated symbol | Top10/Market Board | reserved/blocked/qualified, not clean | clean diversified candidate |
| FunctionResults aggregate proof | fresh function_results.log | log row | aggregate tokens present, no per-trade rows | missing/spam |
| History failure semantics | history unavailable scenario if occurs | artifacts/log | unavailable not zero | zero closed implied |

## 18. REMAINING FLAWS

| Flaw | Domain | Severity | Why it remains | Next action |
|---|---|---:|---|---|
| RUN064 closed-history patch is not compile-proven | compile | 5 | no MetaEditor available in this environment | RUN065 compile output |
| RUN064 closed-history patch is not live-proven | runtime | 5 | RUN064 is no-live source/readiness | RUN065 live output |
| Entry reconstruction depends on broker history completeness | history | 3 | MT5 has orders/deals history, no direct closed-position object | RUN065 verify partial/complete labels |
| SL/TP may be unavailable from broker history | history | 3 | historical order may not carry useful SL/TP | RUN065 confirm labels |

## 19. NEXT RUN DECISION

| RUN064 outcome | Next run | Why |
|---|---|---|
| PASS SOURCE PATCH / LIVE UNPROVEN | RUN065 | live proof must verify compile, Market Board, Dossier, Current Focus, FunctionResults aggregate row, open/pending/closed history, and L4 active exposure semantics |

```text
RUN:
RUN064

DECISION:
PASS SOURCE PATCH / LIVE UNPROVEN — proceed to RUN065 live proof.

DEEP RESEARCH:
- completed/failed: completed
- official MQL5 position/order/history docs used: PositionsTotal/PositionGetTicket/PositionGet*, OrdersTotal/OrderGetTicket/OrderGet*, HistorySelect/HistoryDealGet*/HistoryOrderGet*, deal/order property docs
- portfolio/history engineering used: open/pending active exposure; closed trades history/context; no direct closed-position object assumed
- testing/observability research used: pass/fail/block evidence tables; aggregate proof tokens to avoid high-cardinality per-trade logs
- source checks created from research: history owner, latest_20, entry reconstruction label, history unavailable not zero, aggregate tokens, no closed-history blockers

PORTFOLIO/HISTORY READINESS VERDICT:
- open positions: source-supported before RUN064, preserved
- pending orders: source-supported before RUN064, preserved
- recent closed trades latest 20: patched source-side in portfolio snapshot owner
- Market Board: source-supported via `ASC_PortfolioExposureDetailsText`
- Dossier: source-supported via selected-symbol helper
- Current Focus: source-supported through Dossier mirror path
- FunctionResults aggregate proof: patched helper tokens, runtime proof deferred
- L4 closed-history non-blocker: preserved by keeping closed history out of exposure symbols and labelling context-only
- RUN065 package readiness: checklist locked

TOP FINDINGS:
- RUN064-F01 `ASC_PortfolioExposureSnapshot.mqh` — history_snapshot_missing — severity 5 — patched — Market Board could not show latest 20 closed trades before this.
- RUN064-F02 `ASC_PortfolioAggregateProofTokens` — functionresults_history_token_gap — severity 4 — patched — RUN065 needs aggregate history proof without per-trade spam.
- RUN064-F03 Market Board helper — closed_trade_missing_from_market_board — severity 5 — patched — operator needs open/pending/closed portfolio truth together.
- RUN064-F04 selected-symbol helper — closed_trade_missing_from_dossier — severity 4 — patched — selected Dossier/Current Focus needed bounded history context.
- RUN064-F05 history builder — history_unavailable_treated_zero risk — severity 5 — patched — failure now labels unavailable, not zero.
- RUN064-F06 entry reconstruction — entry_reconstruction_overclaim risk — severity 4 — patched — missing paired entry is partial, not faked.

PATCHES:
- `ASC_PortfolioExposureSnapshot.mqh` / history structs and builder — latest 20 closed trade context — no strategy/rank/HUD/FileIO/execution drift.
- `ASC_PortfolioExposureSnapshot.mqh` / aggregate proof helper — history tokens — aggregate-only, no per-trade spam.
- `ASC_PortfolioExposureSnapshot.mqh` / artifact detail helpers — Market Board/Dossier/Current Focus source path — no broad redesign.
- `ASC_Version.mqh` — RUN064 identity — source boundary corrected.
- roadmap/report files — RUN064 and RUN065 proof debt — no proof hidden.

PROOF STATUS:
- New RUN064 patch live proof: not claimed
- Source: patched
- Outputs: not supplied / not generated
- RUN065 required: compile + fresh output package

RUN065:
- required setup: source zip, compile root, fresh terminal run with open/pending/recent closed history if possible
- required uploads: compile output, function_results.log, Market Board, selected Dossier, Current Focus, manifest/status outputs
- pass: all portfolio/history artifacts and aggregate tokens match expected behavior
- fail: closed history missing/faked/used as blocker or aggregate proof missing/spammy
- block: source/output unreadable or compile root absent

REMAINING FAILURES:
- compile/live proof absent — RUN065 must prove or falsify
- paired entry/SL/TP may be partial by broker history — RUN065 must verify labels

NEXT RUN:
RUN065 live proof checkpoint.

ZIP:
changed-files package produced for RUN064.
```
