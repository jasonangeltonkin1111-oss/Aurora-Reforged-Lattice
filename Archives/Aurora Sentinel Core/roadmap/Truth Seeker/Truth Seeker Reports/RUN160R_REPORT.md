# RUN160R_REPORT

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN160R / SYMBOL DATA PACK LITE PHASE 1 — DEEP SOURCE AUDIT + SAFE ROUTING BLUEPRINT + ROADMAP RESET TO RUN170 LIVE

RUN TYPE: DEEP AUDIT / ROADMAP PATCH / GUIDEBOOK UPDATE / BLUEPRINT / NO LIVE

DECISION: PASS by source inspection, external authority research, roadmap/control patch, guidebook update, report creation, and package validation.

PRIMARY OUTPUT: RUN160 live was cancelled by operator direction and replaced with a protected RUN160R-RUN169R no-live Symbol Data Pack Lite blueprint/build sequence ending in RUN170R live proof.

## 2. OPERATOR SNAPSHOT

| Check | Result |
|---|---|
| RUN160 live cancelled by operator | yes |
| RUN170 set as next live | yes |
| roadmap updated | yes |
| active roadmap log updated | yes |
| guidebooks read | yes |
| guidebooks updated | yes |
| deep external research performed | yes |
| source owner audit completed | yes |
| copy-as-is candidates identified | yes |
| dumb-down/purify candidates identified | yes |
| L2 no bid/ask audit completed | yes |
| one-file-per-symbol law locked | yes |
| atomic publication blueprint completed | yes |
| cadence blueprint completed | yes |
| numeric-first law added | yes |
| Symbol Data Pack content blueprint completed | yes |
| Siam suggestions classified | yes |
| RUN161-RUN169 plan completed | yes |
| main-system numeric-first future debt added | yes |
| no main runtime behavior changed | yes |
| no formula/rank/order changed | yes |
| no FileIO rewrite | yes |
| no heartbeat cadence change | yes |
| no HUD work | yes |
| no signal/execution leakage | yes |
| package validation passed | yes |

## 3. INPUT ZIP / FILE INTAKE SUMMARY

| Input | Result |
|---|---|
| Uploaded source zip | `Aurora Sentinel Core(430).zip` |
| Root found | `Aurora Sentinel Core/...` |
| RUN159R package/report available | yes: `RUN159R_REPORT.md` |
| Active baseline used | RUN159R patched source/control |
| RUN158R/RUN157R/RUN156R/RUN155R reports read | yes |
| Guidebook index/Coding Brain/Trading Brain read | yes |
| Compile root found | yes: `mt5/AuroraSentinelCore.mq5` |
| Source path wrinkle | `ASC_ServerPaths.mqh` and `ASC_DirectorySetup.mqh` are under `mt5/runtime/`; `ASC_OpenSymbolSnapshotWriter.mqh` is under `mt5/artifacts/`, not `mt5/open_symbol_snapshot/` |
| Live output requested/used | no |

## 4. ROADMAP RESET / RUN170 LIVE CADENCE UPDATE

| Roadmap Update | File | Added / Updated? | Evidence | Risk |
|---|---|---|---|---|
| RUN160 live test cancelled by operator direction | TRUTH_SEEKER_ROADMAP.md / ACTIVE_ROADMAP_LOG | Updated | RUN160R reset section + log entry | stale RUN160 live expectation |
| RUN161R-RUN169R protected Lite sequence added | TRUTH_SEEKER_ROADMAP.md / ACTIVE_ROADMAP_LOG | Added | build cadence table | scope creep |
| RUN170R next scheduled live proof | TRUTH_SEEKER_ROADMAP.md / ACTIVE_ROADMAP_LOG / MANIFEST | Updated | manifest + report | old live cadence |
| Main numeric-first future debt | TRUTH_SEEKER_ROADMAP.md / Trading Brain | Added | future debt table | main-system bloat before Lite proof |
| One-file-per-symbol / no-direction Lite law | TRUTH_SEEKER_ROADMAP.md / Coding Brain | Added | Lite law section | hidden owner/action leakage |


## 5. GUIDEBOOK BRAIN READ / UPDATE

| Guidebook | Read? | Updated? | Durable Lesson Added | Anti-Bloat Check |
|---|---|---|---|---|
| AURORA_GUIDEBOOK_INDEX.md | yes | yes | RUN160R Lite guidebook expansion + sanitized factual boundary | durable lane only, no report paste |
| AURORA_CODING_BRAIN_GUIDEBOOK.md | yes | yes | parallel route-only subsystem, one-file pack, numeric-first, no lazy unavailable, official MQL5 constraints | lesson form only |
| AURORA_TRADING_BRAIN_GUIDEBOOK.md | yes | yes | words need numbers, static membership not fresh truth, stale quote risk, review-completeness boundary, losing-outcome diagnosis | sanitized banned action terms |


## 6. EXTERNAL AUTHORITY RESEARCH CONVERSION TABLE

| Research Area | Source Type | Finding | Converted Constraint | Blueprint / Roadmap Impact |
|---|---|---|---|---|
| CopyRates / MqlRates / Bars / SeriesInfoInteger | Official MQL5 Reference | CopyRates returns MqlRates history for symbol-period; Bars can return zero when timeseries is not formed or synchronized. | Lite OHLC wrapper must record copied count, requested count, SERIES_SYNCHRONIZED/Bars state, timeframe, current-vs-closed bar index, retry state, and hard absence only after bounded attempts. | RUN164R owner contract for OHLC/high-low wrapper. |
| SymbolInfoTick / MqlTick / SymbolInfoDouble / SymbolInfoInteger / SymbolSelect | Official MQL5 Reference | SymbolInfoTick returns current MqlTick or false; SymbolSelect controls Market Watch membership; SymbolIsSynchronized exposes selected-symbol terminal/server synchronization. | Lite quote section must print selected_state, synchronized_state, tick_success, last_error, tick_time, bid, ask, spread, and retry attempts before any absence label. | RUN163R quote/tick wrapper and L2 no-data proof. |
| CopyTicks / CopyTicksRange | Official MQL5 Reference | CopyTicks first call can trigger tick-database synchronization; EA/script calls can wait, and returned ticks include full price fields with flags indicating changed bid/ask/last/volume. | Lite tick stats must record request window, copied count, oldest/newest tick time, flags counts, bid/ask change counts, and sync_pending state. | RUN163R tick stats 60s/300s windows. |
| Indicator handles / CopyBuffer / iATR/iMA/iRSI/iMACD/iBands/iADX/iStdDev | Official MQL5 Reference | Indicator functions return handles, data may not be available immediately, CopyBuffer retrieves buffers, IndicatorRelease frees handles when no longer used. | Lite indicator module must cache handles, validate BarsCalculated/CopyBuffer counts, separate closed-bar from forming-preview values, and never recreate handles every beat. | RUN165R/RUN167R indicator lifecycle. |
| ATR formula / iATR behavior | Official MQL5 + Wilder/ATR authority | ATR must be a numeric volatility measure from true range; closed-bar ATR and forming-preview ATR must be labelled separately. | Lite ATR fields must include timeframe, period, closed_shift, samples, true_range formula, source=iATR or custom CopyRates, and freshness. | RUN165R volatility/pullback/range contract. |
| VWAP / anchored VWAP formulas | High-authority finance references | VWAP is cumulative price*volume divided by cumulative volume; typical price often uses (H+L+C)/3. Anchored VWAP resets from anchor time. | Lite VWAP must print anchor name/time, formula, volume source quality tick_volume/real_volume, sample bars, cumulative volume, and distance from VWAP numerically. | RUN166R VWAP wrapper. |
| D/W/M high-low extraction | Official MQL5 series docs + source owner audit | High/low facts require explicit period/shift and enough bars; current, previous, and two-back periods must not be guessed from current tick alone. | Lite high-low section must use CopyRates/iHigh/iLow with period/shift, copied count, bar open time, bar close status, and retry state. | RUN164R D1/W1/MN1 facts. |
| Spread-to-volatility normalization | Source audit + ATR formula | spread/ATR, spread/recent_range, and spread/daily_range are factual ratios, not quality calls unless thresholds and samples are printed. | Lite can print ratios; labels require thresholds and numbers beside them. | RUN165R/RUN168R numeric-first law. |
| EventSetTimer / OnTimer | Official MQL5 Reference | MQL5 timer events are not added when a Timer event is already queued or being processed; heavy timer handlers reduce throughput. | Lite must be lane-sliced and due-clocked; no heartbeat cadence change and no full-universe heavy work per beat. | RUN161R-RUN169R scheduling guard. |
| FileOpen / FileWriteString / FileFlush / FileClose / FileMove | Official MQL5 Reference | FileFlush persists buffers but frequent calls may affect speed; FileMove can promote temp output; existing ASC_FileIO already has readback-token/no-change/last-good behavior. | Lite must copy ASC_FileIO atomic pattern; no FileIO rewrite; flush only through existing writer path. | RUN162R atomic one-file publication. |
| FileFindFirst / FileFindNext / FileFindClose | Official MQL5 Reference + RUN155R source patch | Directory proof must distinguish folder existence from child evidence and close find handles. | Lite optional manifest/status must preserve child-count proof and avoid false-missing regression. | RUN162R/RUN168R proof guard. |
| Atomic writes / last-good / retries / telemetry | Software-engineering design consensus + existing ASC_FileIO | Safe publication writes temp, validates, promotes, preserves old good data on failure, and records reason telemetry. | Lite section state must support retry, last-good age, no-change hash, and atomic pack status. | All Lite phases. |


## 7. SOURCE OWNER AUDIT

| Source Area | File(s) | Current Responsibility | Copy As-Is? | Route From? | Needs New Lite Wrapper? | Risk |
|---|---|---|---|---|---|---|
| Main compile/runtime | mt5/AuroraSentinelCore.mq5; runtime/ASC_Dispatcher.mqh; runtime/ASC_Bootstrap.mqh; core RuntimeState/Constants/Types/Version | Timer, heartbeat dispatch, lanes, state, source identity, package status. | no | yes | yes | High: never alter heartbeat or lane behavior in RUN160R-RUN169R except explicitly scoped Lite skeleton after RUN161. |
| File/atomic publication | mt5/io/ASC_FileIO.mqh; runtime/ASC_ServerPaths.mqh; runtime/ASC_DirectorySetup.mqh; mt5/io/ASC_WorkbenchPaths.mqh | Directory creation, server root, workbench paths, atomic text write, token/readback/no-change/last-good. | yes pattern only | yes | yes | Medium: copy pattern, do not rewrite FileIO. |
| Artifact patterns | DossierWriter; dossier/Composer; dossier/SectionCommon; CurrentFocusWriter; MarketBoardWriter; ArtifactTextHelpers; ArtifactContracts; ScannerStatusWriter | Payload composition, required tokens, one-artifact contracts, continuity, proof blocks, compact status. | partial pattern only | yes | yes | Medium: strip Dossier/Board semantics and actionability words. |
| Data owners | MarketStateEngine; OpenSymbolSnapshotEngine; SymbolSpecification; ClassificationBridge; SelectionFilter; Shortlist engines; DeepSelectiveAnalysisEngine | L1 state, L2 quote/spec/session/day/ATR facts, classification, L3/L4 context, deep/timeseries evidence. | no | yes | yes | High: Lite route-only, no rank/formula ownership. |
| Logs/performance | logging/ASC_FunctionResults.mqh; logging/ASC_Logging.mqh; dispatcher heartbeat telemetry | Result rows, dedupe, pressure guards, heartbeat budget signals. | no | yes | maybe | Medium: avoid proof spam and flush loops. |
| HUD | mt5/hud/ASC_HUD_Manager.mqh | Operator UI, currently protected/deferred/off boundary. | no | read-only only | no | High: no HUD work, no re-enable. |


## 8. WHAT CAN BE COPIED AS-IS

| Copy Candidate | Existing File / Owner | Why Safe | What Must Be Stripped | Reuse Method |
|---|---|---|---|---|
| Atomic temp→validate→promote | mt5/io/ASC_FileIO.mqh ASC_WriteTextFileAtomic | Already supports token contract, readback, no-change skip, FileMove(FILE_REWRITE), retained last-good. | No new FileIO behavior, no forced flush loop. | Call existing writer from Lite writer. |
| Root/path creation | runtime/ASC_ServerPaths.mqh; ASC_DirectorySetup.mqh; io/ASC_WorkbenchPaths.mqh | Existing server-root/workbench path pattern is stable. | No broad path migration. | Add Lite folder/contract via artifact contract wrapper later. |
| One artifact per symbol | Dossier contract/writer pattern | Dossier already models symbol-scoped artifact output. | Strip Dossier product law and deep semantics. | Use `<SYMBOL>_SYMBOL_DATA_PACK.txt` contract. |
| Version/source identity | core/ASC_Version.mqh; constants; report control files | Run identity is already exposed for audit. | No source version bump in RUN160R unless source changed. | Report/control only in RUN160R. |
| Last-good/continuity | DossierWriter; CurrentFocusWriter; ASC_FileIO | Continuity pattern exists and keeps old rich artifact on failed/shell write. | Strip rich Dossier retention rules; keep last-good age/status. | Lite section map plus final pack publication. |
| Scanner Status compact proof | ASC_ScannerStatusWriter.mqh | Compact proof style is good for health/freshness map. | No proof spam per symbol every beat. | Optional internal status after RUN168R. |
| Classification fields | ClassificationBridge; SymbolSpecification | Route factual identity/classification only. | No rank/action interpretation. | Symbol Identity section. |
| Market state fields | MarketStateEngine | L1 state/cadence/retry/session posture already exists. | No downstream decision. | Market State / Session Facts section. |
| Quote/spec fields | OpenSymbolSnapshotEngine; SymbolSpecification | Existing L2 already captures bid/ask/spread/tick/session/spec with retry metadata. | Remove lazy word-only labels. | Quote/Tick, Spread, Specs-derived trace. |
| L4 membership context | ShortlistSelectionEngine | Membership context is useful as context only. | Strip rank-as-permission language. | L4 Membership Context section only. |
| No-action boundary wording | Worker guide / prior reports | Boundary language already separates scanner from action engine. | Avoid banned words inside Trading Brain. | Safety Boundary section. |


## 9. WHAT MUST BE DUMBED DOWN / PURIFIED

| Main-System Content | Risk In Lite Pack | Keep? | Purify How? | Numeric Basis Required |
|---|---|---|---|---|
| Advanced interpretation labels | Can leak judgement/actionability in Lite | modify | Keep only if paired with numeric threshold/source/freshness/sample count. | value + formula + threshold + timeframe + owner + sample_count |
| Regime/strategy wording | Can imply a market call without data basis | mostly no | Keep raw numeric regime ingredients only; no strategy phrasing. | numeric inputs and method |
| Candidate/review language | Can imply permission | main-only context | Lite may say `membership_context_only`; no permission wording. | membership epoch + rank source + age |
| Good/bad/favourable/ready labels | Actionability leakage | no | Replace with numeric ratio/health status. | ratio + threshold + reason |
| Friction state | Allowed only with burden numbers | yes with basis | Print spread, spread_pct, spread_atr_ratio, thresholds, samples. | spread_points/spread_pct/spread_atr/sample_count |
| Volatility state | Allowed only with ATR/range numbers | yes with basis | Print ATR, ATR%, range%, timeframe, period, closed/preview. | ATR_points/ATR_pct/period/shift |
| Freshness state | Allowed only with time numbers | yes with basis | Print observed time, age_sec, next_due, source owner. | timestamp + age_sec + next_due |
| Unavailable | Lazy if source can hydrate | modify | Use pending_retry/stale/retained_last_good/hard_absence_confirmed. | attempts + last_error + sync state + last_good_age |
| Trade/action terms | Creates execution leakage | no | Ban from Lite Pack sections and Trading Brain. | not applicable |


## 10. LAYER 2 NO BID/ASK / NO DATA FAILURE AUDIT

| L2 Failure Mode | Evidence In Source | Existing Guard? | Lite Pack Required Retry/Hydration Rule | Future Patch Owner |
|---|---|---|---|---|
| Symbol not selected in Market Watch | ASC_L2TryReadLiveQuoteSnapshot reads SYMBOL_SELECT; SymbolSelect docs confirm Market Watch selection matters. | Existing reason: symbol_not_selected_in_market_watch; no SymbolSelect repair path in Lite yet. | RUN163R must record selected_state and optionally schedule bounded selection/hydration proof before hard absence. | ASC_SymbolDataPackRouting / existing L2 owner. |
| Symbol not synchronized | ASC_L2TryReadLiveQuoteSnapshot stores SymbolIsSynchronized; reason symbol_not_synchronized. | Existing guard but artifact labels can still show generic absence. | Print synchronized_state, sync_pending, next_retry_due, last_good_age. | RUN163R quote hydration. |
| SymbolInfoTick failure | ASC_L2TryReadLiveQuoteSnapshot captures tick_success and GetLastError. | Existing reason includes error code. | Lite prints tick_success=false, last_error, attempts, elapsed_ms, next_due. | RUN163R tick/quote facts. |
| Bid/ask zero despite tick | Engine falls back from SymbolInfoDouble to MqlTick bid/ask, then reasons bid_unavailable/ask_unavailable. | Micro retry exists: max attempts/window from constants. | Lite keeps retry attempts and distinguishes true zero/empty book from pending hydration. | RUN163R L2 wrapper. |
| Quote time missing/ahead | Engine validates SYMBOL_TIME/MqlTick time and clock alignment. | Existing reason tick_time_unavailable/quote_timestamp_ahead. | Lite prints tick_time, server_time, age_sec, clock_aligned. | RUN163R health/freshness. |
| Market closed/session unavailable | MarketStateEngine owns L1; SymbolSpecification captures session status. | Existing state owner; L2 may still carry last-good. | Lite prints L1 state + session facts + last_good status instead of forcing blank. | RUN163/RUN168. |
| Full-universe scan starves displayed refresh | Dispatcher has L2 overlay and companion starvation constants. | Existing work from RUN157-RUN159; live unproven. | Lite must be due-clocked and not full-universe heavy per beat. | RUN161 scheduling. |
| Writer before hydration | Dossier shell can publish unavailable L2 fields; OpenSnapshotWriter path is artifacts/ASC_OpenSymbolSnapshotWriter.mqh, not open_symbol_snapshot folder. | Existing shell honesty; not enough for Lite. | Lite section state blocks final `complete` status until retry/last-good/hard absence is explicit. | RUN162/RUN168. |
| Data present in engine but not routed | OpenSymbolSnapshotEngine stores many numeric fields; writers may omit or compress. | Partial existing projection. | Lite must route fields one-to-one with owner trace. | RUN161/RUN163. |
| String/format/path issue | ASC_FileIO readback token and path parents guard publication. | Existing guard. | Lite contract must require symbol id, section ids, source owners, and publication id tokens. | RUN162. |
| Current/live shell hides last-good | Dossier shell retention exists for rich last-good; L2 has sticky analytic retention. | Existing but not Lite-specific. | Lite prints retained_last_good=true/false and age per family. | RUN168. |


Exact RUN161/RUN162 source paths for L2 values:
- `mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh` for `ASC_Layer2Packet`, `ASC_L2TryReadLiveQuoteSnapshot`, `ASC_L2TryReadLiveQuoteWithMicroRetry`, `ASC_L2EvaluatePacket`.
- `mt5/symbols/ASC_SymbolSpecification.mqh` for broker/spec/session/swap/margin facts.
- `mt5/market_state/ASC_MarketStateEngine.mqh` for L1 state and cadence truth.
- `mt5/artifacts/ASC_OpenSymbolSnapshotWriter.mqh` for existing open snapshot projection pattern.
- `mt5/artifacts/ASC_DossierWriter.mqh` and `mt5/artifacts/dossier/ASC_DossierComposer.mqh` for shell/continuity pitfalls to avoid.

Required retry/hydration states:
`selected_state`, `synchronized_state`, `tick_success`, `tick_last_error`, `quote_time`, `server_time`, `tick_age_sec`, `micro_retry_attempts`, `micro_retry_elapsed_ms`, `next_retry_due`, `last_good_present`, `last_good_age_sec`, `hard_absence_confirmed`, `source_owner`.

No-bid/no-ask last-good behavior:
- If fresh bid/ask exists: publish live values and reset last-good.
- If fresh bid/ask fails but last-good exists: publish retained value only with `retained_last_good=true`, age, source owner, failure reason, and next retry.
- If no fresh or retained value exists: publish pending/hydration failure reason, not generic absence.
- Hard absence requires selected=true, synchronized=true, tick call attempted, error/reason recorded, bounded retry exhausted, and session/broker state checked.

Proof to distinguish true broker absence vs slow hydration:
`SymbolSelect/SYMBOL_SELECT`, `SymbolIsSynchronized`, `SymbolInfoTick` result/error, bid/ask values from both `SymbolInfoDouble` and `MqlTick`, tick timestamp, session state, retry attempts/window, and last-good age.

## 11. ONE-FILE-PER-SYMBOL ATOMIC PUBLICATION BLUEPRINT

| Publication Requirement | Existing Pattern To Copy | Lite Design | Risk | RUN161/RUN162 Implementation Owner |
|---|---|---|---|---|
| one file per symbol | Dossier symbol-scoped artifact contract | `<SYMBOL>_SYMBOL_DATA_PACK.txt` only; internal sections recomposed into one text payload. | Tiny-file sprawl if each section writes separately. | RUN161/RUN162. |
| atomic publish | ASC_WriteTextFileAtomic | Write temp, readback token contract, FileMove(FILE_REWRITE), preserve last good on failure. | Broken pack if FileIO rewritten. | RUN162 writer. |
| required tokens | Dossier/manifest token contracts | Require pack title, symbol, publication id, owner trace, safety boundary, section freshness map. | False complete if tokens weak. | RUN162. |
| last-good continuity | Dossier/CurrentFocus retention; L2 sticky retention | Per section last_good_age; final pack can carry retained values with reason. | Stale data if age hidden. | RUN168. |
| no-change skip | ASC_PublicationPayloadMateriallyEqual | Content hash/material equality skip before write. | Write pressure if missing. | RUN162. |
| section freshness visible | Scanner Status/manifest proof style | Each section: last_refreshed, next_due, source owner, value status, retry, last_good. | Operator may trust stale facts. | RUN168. |
| optional internal manifest/status | Scanner Status compact style | Only if needed, not public per-section files. | Proof spam and folders. | RUN168/169. |


Atomic section state blueprint:
| Field | Required Meaning |
|---|---|
| section_name | stable section id and operator label |
| section_cadence | due-clock target for section |
| last_refreshed | UTC source refresh time |
| next_due | UTC next attempt time |
| source_owner | existing engine/API owner |
| value_status | live / retained_last_good / pending_retry / stale / hard_absence |
| retry_status | attempts, elapsed, last_error, next_retry_due |
| last_good_status | present, timestamp, age, source |
| content_hash | material change/no-change skip basis |
| atomic_pack_publish_status | pending / promoted / no_change / continuity / failed |

## 12. UPDATE CADENCE BLUEPRINT

| Section | Cadence | Existing Owner | New Lite Routing Need | Runtime Risk |
|---|---|---|---|---|
| Publication / Atomic Status | on changed section / no-change guard | ASC_FileIO/Dossier pattern | Lite writer/composer status | Low if no FileIO rewrite |
| Symbol Identity | slow / on identity change | ClassificationBridge + SymbolSpecification | route wrapper | Low |
| L4 Membership Context | L4 epoch / 20m current baseline context | ShortlistSelectionEngine | context-only route | Medium: must not own rank |
| Market State / Session Facts | 10-60s / L1 due state | MarketStateEngine + SymbolSpecification | route wrapper | Medium |
| Quote / Tick Snapshot | 10s | OpenSymbolSnapshotEngine | route + retry state | High: startup hydration |
| Spread / Friction Numbers | 10s | OpenSymbolSnapshotEngine + LiquidityFrictionSummary | numeric basis wrapper | Medium |
| Tick Stats | 10s 60s/300s windows | CopyTicks new wrapper | new Lite wrapper | Medium-high |
| M1 OHLC | 1m on close | CopyRates new wrapper | new Lite wrapper | Medium |
| M5 OHLC | 5m on close | CopyRates new wrapper | new Lite wrapper | Medium |
| M15 OHLC | 15m on close | CopyRates new wrapper | new Lite wrapper | Medium |
| M30 OHLC | 30m on close | CopyRates new wrapper | new Lite wrapper | Medium |
| H1 OHLC | 1h on close | CopyRates/Correlation uses H1 precedent | new Lite wrapper | Medium |
| H4 OHLC | 4h on close | CopyRates new wrapper | new Lite wrapper | Medium |
| D1 OHLC | daily; today/yesterday/two-back | OpenSnapshot + CopyRates | new Lite wrapper | Medium |
| W1 OHLC | weekly; current/prev/two-back | CopyRates new wrapper | new Lite wrapper | Medium |
| MN1 OHLC | monthly; current/prev | CopyRates new wrapper | new Lite wrapper | Medium |
| ATR / Volatility | timeframe close + optional preview | OpenSnapshot custom ATR; ATRSummaryEngine | new numeric wrapper | Medium |
| VWAP / Anchored VWAP | 10-60s | new formula wrapper | new Lite wrapper | Medium |
| Numeric Indicators | timeframe-dependent | MQL5 indicator handles | new handle wrapper | High: handle lifecycle |
| Freshness / Retry / Health | 10-60s | ScannerStatus/L2 metadata | new health composer | Medium |


## 13. NUMERIC-FIRST MAIN + LITE LAW

| Word / Label Type | Allowed In Lite? | Numeric Requirements | Main-System Future Debt |
|---|---:|---|---|
| friction state | yes, with basis | spread_points, spread_pct, spread_atr_ratio, threshold, samples, freshness | Market Board/Dossier friction labels need parity audit |
| volatility state | yes, with basis | ATR/timeframe/period/closed_shift, ATR_pct, range_pct, samples | Dossier volatility wording needs formula/timeframe |
| freshness state | yes, with basis | timestamp, age_sec, next_due, source owner | all currentness labels need numeric age |
| health state | yes, with basis | expected fields, complete fields, percent, blocker count | Scanner Status/manifest already partial; Dossier needs audit |
| membership context | yes, context only | L4 epoch, rank source, membership_age, formula owner | prevent rank-as-action reading |
| candidate/review wording | no in Lite except context-only | if retained: blocker counts and dependency reasons | main-only wording needs future audit |
| unavailable | only with reason | retry attempts, source status, last error, last-good age, hard absence proof | replace lazy labels |
| action/execution terms | no | none | never add to main scanner surfaces |

## 14. SYMBOL DATA PACK CONTENT BLUEPRINT

| Section | Purpose | Key Fields | Cadence | Existing Owner | New Wrapper Needed? |
|---|---|---|---|---|---|
| 1. Publication / Atomic Status | prove pack identity/publication state | publication_id, state, reason, temp/promote, no_change, hash | on changed section | ASC_FileIO | yes |
| 2. Symbol Identity | factual identity/classification | symbol, display_name, asset_class, classification_source, broker fields | slow | ClassificationBridge / SymbolSpecification | yes |
| 3. L4 Membership Context | context only | membership_epoch, bucket, rank_context, source_age, context_only=true | L4 epoch | ShortlistSelectionEngine | yes |
| 4. Market State / Session Facts | open/closed/session factual state | l1_state, session_status, last_checked, next_due, state_reason | 10-60s | MarketStateEngine | yes |
| 5. Quote / Tick Snapshot | bid/ask/last/tick truth | bid, ask, last, tick_time, tick_age, selected, synchronized, tick_success | 10s | OpenSymbolSnapshotEngine | yes |
| 6. Spread / Friction Numbers | spread burden only | spread_points, spread_pct, spread_min/max/avg, spread_atr_ratio | 10s | OpenSnapshot + LiquidityFriction | yes |
| 7. Recent Closed Candle Sequences | closed candle factual sequence | M1/M5/M15 closed candles: time/open/high/low/close/range/body | TF close | CopyRates wrapper | yes |
| 8. Multi-Timeframe OHLC Summary | compact OHLC by timeframe | M1,M5,M15,M30,H1,H4,D1,W1,MN1 values and bar status | TF close | CopyRates wrapper | yes |
| 9. D/W/M High-Low Facts | period high/low context | today/current week/month, prev/two-back highs/lows | period | CopyRates/iHigh/iLow | yes |
| 10. Yesterday / Two-Days-Ago Daily High-Low | daily reference levels | D1 shift 1/2 high, low, close, range, bar time | daily | CopyRates | yes |
| 11. Swing Structure Numeric Facts | raw structure distances | last_swing_high/low, bars_since, distance_points, method | TF-dependent | new wrapper | yes |
| 12. Range-Position Numeric Facts | where price sits in range | range_position_percent, source range, anchor period | 10-60s | OpenSnapshot + CopyRates | yes |
| 13. Pullback-Depth Numeric Facts | depth without action call | pullback_points, pullback_atr_ratio, reference swing, samples | TF-dependent | new wrapper | yes |
| 14. ATR / Volatility Facts | volatility numbers | ATR period/timeframe/closed_shift, ATR_points, ATR_pct, samples | TF close | OpenSnapshot/ATRSummary + wrapper | yes |
| 15. VWAP / Anchored VWAP Facts | average price anchors | session/today/yesterday/week/month VWAP, volume_source, samples | 10-60s | new wrapper | yes |
| 16. Numeric Indicator Facts | indicator facts only | MA/RSI/MACD/Bands/ADX/stddev/zscore numeric buffers | TF-dependent | indicator wrapper | yes |
| 17. Spread-To-Volatility Burden | cost vs movement | spread_atr, spread_range, spread_daily_range, thresholds | 10s | OpenSnapshot | yes |
| 18. Session / Rollover Windows | time risk context | quote/trade sessions, rollover window, minutes_to/from | slow/60s | SymbolSpecification | yes |
| 19. Economic Event Placeholder | future external slot | event_source=not_connected, event_count, next_event_time | manual/future | placeholder only | yes |
| 20. Freshness Map | section freshness ledger | section, last_refreshed, next_due, age, stale flag | 10-60s | new composer | yes |
| 21. Retry / Hydration Status | no lazy missing | section, attempts, last_error, sync state, next_retry, hard_absence | 10-60s | new composer + owners | yes |
| 22. Data Health Summary | completeness not action | complete_fields, expected_fields, percent, blockers | 10-60s | new composer | yes |
| 23. Owner Trace | source accountability | field, source owner, method, freshness, sample count | on publish | new composer | yes |
| 24. Safety Boundary | no actionability | factual_only=true, no hidden rank/truth owner, no execution fields | on publish | new composer | yes |


Global forbidden wording for every section:
`BUY`, `SELL`, `long`, `short`, `bullish`, `bearish`, `entry`, `stop loss`, `take profit`, `lot`, `trade permission`, `best pick`, `avoid`, `signal`, `breakout ready`, `reversal ready`, `setup quality`, `trade confidence`, `good trade`, `bad trade`, `high probability`, `directional bias`, `momentum direction`.

Sample section line contract:
`field_name=value | formula=... | timeframe=... | source_owner=... | freshness_age_sec=... | sample_count=... | value_status=live|retained_last_good|pending_retry|stale|hard_absence | retry_reason=...`

## 15. SIAM SUGGESTION ACCEPT / MODIFY / REJECT

| Suggestion | Accept / Modify / Reject | Reason | Lite Pack Rule |
|---|---|---|---|
| recent candle sequences | Accept | Closed candles are factual if timeframe/shift/copy count printed. | Use closed bars only; forming preview separately labelled. |
| swing facts | Accept | Raw highs/lows/distances help diagnosis without side call. | Numeric swing facts only. |
| range position | Accept | Percent inside a stated range is factual. | Print range anchor and formula. |
| pullback depth | Accept | Depth vs ATR/range is factual when source swing is explicit. | No setup wording. |
| spread-to-volatility burden | Accept | Cost burden is numeric and useful. | Print spread/ATR, spread/range, sample count. |
| session/rollover windows | Accept | Time windows are factual risk context. | No timing trigger language. |
| economic event placeholder | Accept | Placeholder avoids fake calendar integration. | Print not_connected/source_pending until source exists. |
| freshness/hydration/retry maps | Accept | Core to no-lazy-unavailable law. | Every missing field must map to reason/retry. |
| numeric indicator facts | Accept | Indicator values are factual if buffers/sample counts are explicit. | No side labels. |
| signal-grade | Modify | Actionability leakage. | Rename to analysis-grade factual data. |
| confidence | Modify | Can imply market conviction. | Use data_quality_confidence only. |
| danger flags | Modify | Can become advice. | Use numeric risk context only. |
| structure | Modify | May imply pattern call. | Raw swing/range facts only. |
| BUY/SELL/long/short/entry/SL/TP/lot/best pick/avoid | Reject | Forbidden actionability/execution leakage. | Ban from Lite Pack. |


## 16. MODULE / FILE BLUEPRINT FOR RUN161-RUN169

| Proposed File | Purpose | Why Needed | Alternative Existing Owner | Risk |
|---|---|---|---|---|
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh | Pack path, required tokens, section ids, constants. | Needed to lock one-file-per-symbol and safety boundary. | ASC_ArtifactContracts.mqh | Low if declarative. |
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackRouting.mqh | Route existing owner fields into Lite structs. | Prevents duplicate engines and centralizes owner trace. | OpenSnapshot/MarketState/Shortlist engines | Medium. |
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackSections.mqh | Small section builders and numeric formatting helpers. | Avoids a giant writer while keeping public one-file output. | Dossier section helpers | Medium. |
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh | Compose one text payload from section states. | Copies Dossier composer pattern without Dossier semantics. | DossierComposer | Medium. |
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh | Publish atomic pack through ASC_FileIO. | Needed for one-file publication. | DossierWriter | Medium. |
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackIndicators.mqh | Optional isolated handle/buffer lifecycle. | Only if RUN167 needs isolation. | MQL5 indicator APIs | Medium-high; optional. |


Module count rule:
Start with five compact files: Contracts, Routing, Sections, Composer, Writer. Add `ASC_SymbolDataPackIndicators.mqh` only if RUN167 proves handle/buffer isolation is safer than embedding.

## 17. RUN161-RUN169 BUILD PLAN

| Run | Phase | Purpose | Patch Scope | Exit Criteria |
|---|---|---|---|---|
| RUN161R | Lite Phase 2 | routing skeleton | contracts/composer/writer skeleton using existing owners only | source compiles by inspection; no full OHLC/indicator logic |
| RUN162R | Lite Phase 3 | atomic one-file publication | one file per symbol, temp/promote/last-good/no-change | source-ready atomic writer |
| RUN163R | Lite Phase 4 | quote/tick/spread 10s | L2/tick/spread facts + retry states | source-ready quote/tick facts |
| RUN164R | Lite Phase 5 | OHLC multi-timeframe | CopyRates/MqlRates, D/W/M highs/lows | source-ready OHLC wrapper |
| RUN165R | Lite Phase 6 | ATR/volatility/range/pullback | numeric facts only | source-ready volatility/range/pullback facts |
| RUN166R | Lite Phase 7 | VWAP/anchored VWAP | formula/volume quality | source-ready VWAP facts |
| RUN167R | Lite Phase 8 | numeric indicators | MA/RSI/MACD/Bands/ADX/stddev/z-score | source-ready indicator lifecycle |
| RUN168R | Lite Phase 9 | freshness/completeness/retry/health | no lazy unavailable, last-good, hydration | source-ready health maps |
| RUN169R | Lite Phase 10 | closeout/live contract | regression sweep + RUN170 contract | live-ready package |
| RUN170R | live proof | live + research + source repair | prove Lite Pack and patch blockers | pass/hold/fail with live evidence |


## 18. MAIN SYSTEM NUMERIC-FIRST FUTURE DEBT

| Main-System Future Debt | Trigger | Why Deferred Until After Lite | Required Later Evidence |
|---|---|---|---|
| Main Dossier word-only audit | After Lite live-proven baseline | Avoid destabilizing working Dossier during Lite skeleton/hydration build. | Table of every label with numeric basis/source/freshness/sample count. |
| Market Board numeric-basis parity | After Lite quote/OHLC/ATR/VWAP proven | Board ordering/formulas are protected during Lite build. | Board labels paired with spread/ATR/range/freshness values. |
| Current Focus factual parity | After Lite one-file pack proves currentness | Current Focus mirrors Dossier and must not gain a separate truth owner now. | Current Focus fields trace back to source owners. |
| Multi-timeframe formula research | After Lite OHLC/indicator wrappers pass source/live proof | Needs careful MQL5 history synchronization and closed-bar separation. | Formula docs, sample counts, closed/preview labels. |
| Strategy-calculation numeric review | After factual surfaces are stable | Avoid action-engine drift while data foundation is incomplete. | Formula/timeframe/freshness/sample-count evidence only. |


## 19. REGRESSION SAFETY PLAN

| Protected Area | Why Protected | Lite Interaction Allowed | Regression Test |
|---|---|---|---|
| Main Dossier | Working baseline and canonical final symbol truth. | Read/routed context only; no mutation. | Diff shows Dossier files unchanged; live output unchanged until RUN170. |
| Market Board | Trader-facing selection board and L4 order surface. | No Lite mutation; context only. | No MarketBoardWriter change. |
| Top5/GlobalTop10 | Protected membership/order formulas. | Context route only. | No rank/order/formula diff. |
| L3 score | Protected score formula. | No use as Lite score owner. | No SelectionFilter formula diff. |
| L4 rank | Protected ordering logic. | Membership context only. | No ShortlistSelection formula diff. |
| FileIO atomic contract | Critical publication integrity. | Call existing FileIO only. | No ASC_FileIO diff. |
| Heartbeat cadence | 1-second breathing cycle. | Due-clocked Lite lanes later; no cadence change. | No constants/OnTimer cadence change in RUN160R. |
| HUD | Deferred/off/protected. | Read-only audit only. | No HUD file change. |
| Execution/trading logic | Out of scope and forbidden. | None. | No semi_auto/order source change. |


## 20. ACTIONABILITY / SIGNAL SAFETY MODULE

| Lite Pack Field / Section | Signal Leakage Risk | Guard |
|---|---|---|
| L4 Membership Context | Rank could be misread as action permission. | Print context_only=true and membership_age; no action wording. |
| Range Position | Percent can imply side bias. | Print formula only, no interpretation label. |
| Pullback Depth | May imply setup quality. | Print depth ratio only. |
| VWAP Distance | May imply above/below action. | Print signed distance only, no call. |
| Indicator Facts | RSI/MACD can leak action labels. | Print raw values/buffers only. |
| Data Health Summary | Completeness can imply readiness. | Use data_completeness_percent only; not permission. |
| Safety Boundary | Must not become boilerplate hidden by pack length. | Final section repeats factual-only, no hidden owner. |


Allowed numeric terms:
`data_health_score`, `data_completeness_percent`, `freshness_status`, `range_position_percent`, `spread_atr_ratio`, `pullback_depth_atr_ratio`, `distance_from_vwap_points`, `ATR values`, `OHLC values`.

## 21. BUG HUNTING / SOURCE AUDIT MODULE

| Debug Area | File / Owner | Risk | Evidence | Future Patch Guard |
|---|---|---|---|---|
| Existing bars/ATR/ticks/spreads owners | OpenSnapshotEngine; ATRSummaryEngine; CorrelationSummaryEngine; DeepSelectiveAnalysisEngine | Duplicate calculations or inconsistent samples. | CopyRates in ATR/Correlation/Deep; L2 has custom ATR and spread ratios. | Centralize Lite wrappers with source owner trace. |
| Data exists but artifact omits it | OpenSnapshotEngine vs Dossier/MarketBoard writers | Fields present in cache but compressed away. | L2 packet has bid/ask/spread/tick/day/ATR/retry fields. | RUN161 route map one-to-one. |
| No bid/ask path | OpenSnapshotEngine | Generic absence hides Market Watch/sync/tick failure. | quote_unavailable_reason states; micro retry exists. | RUN163 prints all failure proof. |
| Retry/hydration gaps | L2 retry exists; timeseries/indicator wrappers not yet Lite-specific | Lazy unavailable could persist. | L2 has attempts; Bars docs require sync check. | RUN164/167 add bounded retries. |
| Last-good projection gaps | Dossier/CurrentFocus and L2 sticky retention | Stale carry may be hidden. | retained_last_good patterns exist. | RUN168 per-section last_good_age. |
| Unavailable/missing overuse | SymbolSpecification and Dossier composer | Words without numeric basis. | Many helpers return unavailable. | Numeric-first law and reason codes. |
| Indicator handle/buffer risk | MQL5 indicators | Handles created too often or buffers not ready. | Official docs say values need time and CopyBuffer. | RUN167 handle cache. |
| CopyRates history-loading risk | MQL5 series | Zero/partial bars when unsynchronized. | Bars docs and source CopyRates use. | RUN164 Bars/SeriesInfoInteger proof. |
| M1/M5/H1 cadence mismatch | New Lite OHLC | Wrong close detection or stale bars. | No existing Lite cadence. | RUN164 per-TF due clocks. |
| Atomic publish/no-change skip | ASC_FileIO | Excessive writes if bypassed. | no-change skip in ASC_WriteTextFileAtomic. | RUN162 use existing FileIO. |
| One-file composition risk | New Lite writer | Huge monolith or tiny-file sprawl. | Dossier composer pattern. | Compact modules, one public file. |
| Excessive file writes | Timer + FileFlush | Throughput pressure. | OnTimer non-stacking; FileFlush cost. | No heavy flush loop. |
| Guidebook bloat | Guidebook files | Run report pasted into durable docs. | RUN157 anti-bloat rules. | Durable lessons only. |
| Roadmap drift | Roadmap/log/manifest | RUN160 live expectation stale. | RUN160R reset patched. | RUN170 next live locked. |
| Actionability leakage | Report/source/Trading Brain | Terms could imply market action. | Trading Brain sanitized; Lite safety boundary. | Banned terms list enforced in Lite. |


## 22. PATCH CANDIDATE MATRIX

| Candidate | RUN | Patch Type | Why Not RUN160R |
|---|---|---|---|
| Lite contracts/router/composer skeleton | RUN161R | source | RUN160R is blueprint/control only |
| One-file pack writer using ASC_FileIO | RUN162R | source | needs contract skeleton first |
| Quote/tick/spread section routing | RUN163R | source | needs writer and section state |
| CopyRates OHLC wrapper | RUN164R | source | must not rush history sync wrappers |
| ATR/range/pullback facts | RUN165R | source | needs OHLC foundation |
| VWAP anchors | RUN166R | source | needs OHLC + volume quality |
| Indicator handle/cache | RUN167R | source | high lifecycle risk |
| Health/freshness/retry maps | RUN168R | source | needs all data families |
| RUN170 live proof checklist | RUN169R | control/source | after source closeout |

## 23. PATCH TABLE

| File | Status | Change | Risk Class |
|---|---|---|---|
| roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md | updated | RUN160R reset, Lite law, RUN161-RUN170 cadence, future debt | control only |
| roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md | updated | RUN160R log entry and next live reset | control only |
| roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md | updated | RUN160R changed files and protected areas | control only |
| roadmap/Truth Seeker/Guidebooks/AURORA_GUIDEBOOK_INDEX.md | updated | RUN160R guidebook expansion and factual boundary | guidebook only |
| roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md | updated | durable Lite implementation lessons | guidebook only |
| roadmap/Truth Seeker/Guidebooks/AURORA_TRADING_BRAIN_GUIDEBOOK.md | updated | durable factual-interpretation lessons; banned action terms removed | guidebook only |
| roadmap/Truth Seeker/Truth Seeker Reports/RUN160R_REPORT.md | created | master blueprint report | report only |


## 24. SOURCE / CONTROL / GUIDEBOOK FILES TOUCHED

Control/guidebook/report files touched:
- `roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `roadmap/Truth Seeker/Guidebooks/AURORA_GUIDEBOOK_INDEX.md`
- `roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md`
- `roadmap/Truth Seeker/Guidebooks/AURORA_TRADING_BRAIN_GUIDEBOOK.md`
- `roadmap/Truth Seeker/Truth Seeker Reports/RUN160R_REPORT.md`

Source files touched:
- none

Protected source files inspected but not edited:
- compile/runtime, FileIO/path, artifact patterns, data owners, logging, HUD read-only.

## 25. PACKAGE VALIDATION TABLE

| Package Check | Result | Evidence |
|---|---|---|
| zip exists | yes | /mnt/data/TRUTH_SEEKER_RUN160R_CHANGED_FILES_WINDOWS_SAFE.zip |
| zip size > 0 | yes | 159493 |
| file entries > 0 | yes | 7 |
| expected root preserved | yes | Aurora Sentinel Core/... |
| all patched files included | yes | 7 |
| roadmap included if updated | yes | Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md |
| guidebooks included if updated | yes | 3 guidebooks included |
| report included | yes | Aurora Sentinel Core/roadmap/Truth Seeker/Truth Seeker Reports/RUN160R_REPORT.md |
| report filename Windows-safe | yes | RUN160R_REPORT.md |
| max internal path length checked | yes | 86 |
| active roadmap log included if updated | yes | Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md |
| manifest included if updated | yes | Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md |
| extraction test passed | yes | /mnt/data/run160_extract_test |
| empty zip risk | no | verdict |
| rootless zip risk | no | verdict |
| Windows path-too-long risk | no | max 86 chars |

## 26. NEXT_PROMPT_SEED

```text
TRUTH SEEKER ROADMAP — RUN161R / SYMBOL DATA PACK LITE PHASE 2 — PARALLEL ROUTER + COMPOSER SKELETON USING EXISTING OWNERS ONLY

RUN161R must:
- read RUN160R report first.
- read all guidebooks.
- preserve roadmap reset to RUN170 live.
- preserve main system protected baseline.
- create minimal Symbol Data Pack contract/router/composer skeleton.
- route from existing owners only.
- do not implement full OHLC/indicator logic yet.
- preserve one-file-per-symbol law.
- preserve atomic publication blueprint.
- preserve numeric-first/no-direction doctrine.
- no live.
- next live remains RUN170R.
```

## 27. FINAL DECISION

PASS — RUN160R records the operator-cancelled RUN160 live proof, resets the roadmap to RUN170R live, updates roadmap/control/guidebook files, performs external authority research and real source-owner audit, locks the one-file-per-symbol atomic publication blueprint, defines retry/hydration/last-good/no-change and numeric-first laws, classifies Siam suggestions safely, creates RUN161R-RUN169R build plan, adds main-system numeric-first future debt, and changes no main runtime behavior, formula/rank/order, FileIO, heartbeat cadence, HUD, or execution logic.
