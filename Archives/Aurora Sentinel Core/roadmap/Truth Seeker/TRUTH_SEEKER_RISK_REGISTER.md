# Truth Seeker Risk Register

**Updated:** 2026-04-27

## Compile Risk Zones

| Zone | Risk | Guard |
|---|---|---|
| `mt5/AuroraSentinelCore.mq5` | Compile root breakage | Avoid unless phase explicitly needs root wiring |
| `mt5/core/*` | Type/state breakage | Read-only unless adding proven fields with full dependency review |
| `mt5/runtime/*` | Heartbeat/scheduling breakage | Patch only after runtime audit and queue/budget proof |
| `mt5/io/*` | Publication/atomic write regression | Preserve existing temp/validate/promote path; no parallel IO |
| `mt5/artifacts/ASC_DossierWriter.mqh` and `mt5/artifacts/dossier/*` | Dossier truth mismatch or writer-owned computation | Writers compose only; hydrate from existing truth owners |
| `mt5/artifacts/ASC_CurrentFocusWriter.mqh` | Selected-symbol derivative mismatch | Must remain Dossier derivative, not independent truth |
| `mt5/artifacts/ASC_MarketBoardWriter.mqh` | Compression hiding blockers | Must not imply more truth than Dossier/rank owners have |
| `mt5/candidate_filtering/ASC_SelectionFilter.mqh` | L3 broad-loop breakage | Surgical edits; no heavy calls |
| `mt5/shortlist_selection/*` | Ranking/Top 10 regression | Reason-code-first; avoid broad weight churn |
| `mt5/deep_selective_analysis/*` | Heavy selected-symbol logic breakage | Keep selected/on-demand; cache handles if indicators added |
| `mt5/hud/*` | UI speed/display regression | HUD read-only; no compute |
| `mt5/logging/*` | Log volume/performance regression | Change-only, throttled, structured logs |

## Dossier Folder Risks

| Risk | Description | Guard |
|---|---|---|
| Thin open-symbol Dossiers | Open/eligible symbols remain 3 KB shells | PHASE 2A classifies shells and completes existing queue |
| False 3 KB panic | Closed/inactive compact files are mistaken for bugs | Classify `CLOSED_L0_L2` and prove honest compact truth |
| File-size fake proof | Large file treated as true regardless of content | File size is diagnostic only; inspect sections/layers/logs |
| Unavailable padding | Garbage placeholders are written to inflate size | Count unavailable fields; downgrade/hide/log; no padding |
| Writer stall/backlog | Rotation never completes for 1,200 symbols | Cursor, queue remaining, retry/stall reason, write budget telemetry |
| Publication interruption | Temp file or last-good path leaves shells | Preserve atomic temp → validate → promote and resume proof |
| All-symbol L5/L6 explosion | Deep analysis generated for every symbol | L5/L6 only Top10/selected/deep-entitled |
| Dossier rewrite temptation | Future worker creates a parallel system | Existing-path-only law; no new Dossier/publication system |

## False-Edge Risks

| Risk | Description | Roadmap Response |
|---|---|---|
| Rank treated as trade signal | High rank read as entry permission | Rank type + horizon permission + conflict badge |
| ATR used as direction | ATR measures volatility, not bullish/bearish direction | Formula truth phase and support labels |
| VWAP misuse in FX/CFD | Tick volume may not equal centralized volume | L5 test only with volume caveat |
| ADX misuse | ADX trend strength can be non-directional | L5 test; combine with directional evidence |
| Compression overclaim | Tight range does not guarantee breakout | Regime permission + failure risk |
| Strategy label fluff | Pullback/continuation/reversal labels without measurable evidence | L6 cleanup + outcome logs |
| Overfitting | Testing many ideas creates false confidence | Outcome review + anti-overfit discipline |

## Performance Risks

| Risk | Guard |
|---|---|
| CopyTicks broad-universe calls | Selected-symbol/deep only; broad layers use lighter primitives |
| CopyBuffer indicator handles in L3/L4 | No broad heavy loops; handles cached/readiness checked if ever admitted |
| Timer/heartbeat event backlog | Keep per-heartbeat work bounded; no giant blocking Dossier write |
| FileFlush overuse | Flush valuable checkpoints, not every tiny log line |
| HUD string parsing/rebuilds | Prepared view model, changed-only redraw |
| Artifact bloat | Decision-quality only; no unavailable padding |
| Logging bloat | Change-only logs; batch/throttle where safe |
| Full-universe deep calculations | Forbidden |
| Correlation rebuild churn | Cache and refresh cadence |

## Do-Not-Touch-Early Zones

- Execution/trade placement logic.
- New modules/engines/folders/runtime lanes.
- Core runtime heartbeat before Dossier completion/logging phases prove exact seam.
- HUD internals before truth read-model exists.
- Broad ranking weights before rank reason proof exists.
- New indicators before logging/contradiction/performance guards exist.
- Old roadmap docs except to mark cancellation/control status in Phase 0.

## Regression Prevention Model

- No code patch without pre-patch source seam identification.
- No code patch without acceptance criteria.
- No code patch without compile-risk classification.
- No patch may create new code paths by default.
- No patch may break include order, owner relationships, or compile root dependencies.
- No patch may remove useful artifact fields unless thinning is authorized.
- No patch may convert mixed evidence into clean confidence.
- No patch may move heavy calculations into broad loops, writers, HUD, logging, or file IO.
- No patch may make Market Board, Current Focus, HUD, logging, or writers truth owners.
- No patch may add indicators without handle/cache/performance strategy.
- No patch may add logs so heavy runtime slows.
- No patch may expand strategy labels without measurable evidence.
- No patch may update only version/admin files unless explicitly control-only.
- No patch may leave download zip link hidden in report middle.


## Academic / AI / Strategy Growth Risks

| Risk | Description | Guard |
|---|---|---|
| Academic-proof false confidence | A paper or blog is treated as live proof | Academic evidence only opens a test lane; never live execution |
| Data snooping | Many rules/features are tried until one looks good | Pre-register method family, features, horizon, and rejection condition before trust |
| Indicator shopping | Indicators are added because they sound profitable | Formula/input truth, method library gate, logging proof, and validation required |
| Backtest illusion | Historical profit is mistaken for durable edge | Walk-forward, OOS, forward-review, spread/slippage, broker/session/regime checks |
| Black-box AI | Model score appears without explainable reasons | Versioned features, reason codes, calibration, drift checks, rollback, operator review |
| Full-auto creep | Advisory label silently becomes order logic | No `OrderSend`/`CTrade`/auto sizing/SL/TP/close unless separate future roadmap |
| Execution path creep | Trade API enters scanner roadmap | Locked now; only future full-auto branch can discuss execution after operator unlock |
| Strategy bloat | Too many methods slow or confuse Aurora | Method library has rejection/defer conditions; complexity must earn learning leverage |
| Feature logging bloat | Dataset logging slows scanner/HUD | Stable fields, change-only summaries, batch/throttle, selected/top10 deep work |
| Broker-specific data risk | Results overfit one broker/server/symbol feed | Broker/server fields and broker-specific validation required |
| Prop-firm rule risk | Strategy conflicts with challenge rules | Prop-firm overlay and operator-confirmation requirement before trust |
| Proxy mislabel risk | MT5 tick/spread proxies are called true order flow/volume | Use “flow proxy” / “execution activity proxy”; mark tick volume proxy |
| Carry misuse | Carry is treated as scalp entry signal | Carry is risk/context unless validated for a non-scalp horizon |
| Geometry creep | Invalidation/room becomes hidden entry logic | Geometry supports permission/classification only |

## Source Library / Book Extraction Risks

| Risk | Failure mode | Control |
|---|---|---|
| False book authority | Book title or respected author is treated as edge proof | Books generate candidates only; Aurora logs validate |
| Screenshot-only certainty | Worker claims extraction from title evidence | Mark screenshot/title-only sources uncertain |
| Partial extraction | Prior Aurora ledgers/cards miss formula/logging/validation | Crosswalk every concept against current EA zip |
| Missing strategy cards | Labels survive without cards | No strategy label without card or downgrade |
| Copyright/text dump | Long book passages enter roadmap | Concept extraction only, no long verbatim passages |
| Academic/practitioner contradiction | Sources disagree and conflict is hidden | Classify conflict and require discriminating test |
| Strategy bloat | More labels create fake intelligence | Merge duplicates; ledger rejected/duplicate statuses |
| Duplicate method | Same idea exists under multiple names | Canonical method card and duplicate merge |
| Non-MT5 data | Method needs unavailable order flow/external data | Reject, defer, or mark external-data required |
| Discretionary method | Human-only pattern cannot be measured | Downgrade to review-only or reject |
| AI corpus contamination | AI trains on unvalidated/fluff labels | Store source confidence, card status, validation status, rejection state |
| Full-auto creep | Research lane silently becomes execution lane | Advisory-only AI boundary and execution-term search |

## RUN075R Warmup / First Publish Risks

| Risk | Description | Guard |
|---|---|---|
| Infinite first-publish wait | Warmup gate prevents GlobalTop10 from ever publishing | Max warmup seconds, max heartbeat count, max retry cycles, and degraded timeout release are mandatory |
| Silent L2 unavailable in first Top10 | First batch looks complete while L2 unavailable/partial fields remain | First publish waits for L2 minimum threshold or labels `degraded_first_publish` with unavailable count |
| Timer starvation | Heavy warmup work causes timer events to be skipped/ignored | Bounded per-heartbeat cohorts; no heavy loops; keep event handlers short |
| FileIO churn | Retrying/publishing creates excessive writes/flushes/moves | No FileIO rewrite; no extra flush frequency; no existence-only proof |
| Noisy status language | `Disturbed`, `Rebalancing`, and `Partial` remain default after warmup | Post-warmup default is `Steady`; warning words require active trigger |
| Top10 formula drift | Warmup fix accidentally changes rank/order/formula | Treat GlobalTop10 selection/ranking as read-only; gate timing only |
| Strategy expansion too early | Deep research reports are misread as authority to add indicators/strategies now | Reports feed proof-debt and method-card gates only; expansion held until stabilization live proof |
