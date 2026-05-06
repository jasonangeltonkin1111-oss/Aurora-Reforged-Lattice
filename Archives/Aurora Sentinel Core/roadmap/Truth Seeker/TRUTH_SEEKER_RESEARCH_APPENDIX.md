# Truth Seeker Research Appendix

**Updated:** 2026-04-26  
**Purpose:** Research requirements for every future phase/run. Research must become code-audit questions and roadmap constraints, not generic education.

## Current Research Sources Used To Harden This Package

- **MQL5 FileOpen / File Functions** — https://www.mql5.com/en/docs/files/fileopen and https://www.mql5.com/en/docs/files  
  Roadmap conversion: file publication must respect the MQL5 file sandbox and existing terminal/common files paths; future fixes must improve the current IO/publication owner rather than creating uncontrolled output paths.
- **MQL5 FileMove** — https://www.mql5.com/en/docs/files/filemove  
  Roadmap conversion: atomic-style temp → validate → promote remains the publication model; move/copy behavior must stay inside sanctioned file areas.
- **MQL5 FileFlush** — https://www.mql5.com/en/docs/files/fileflush  
  Roadmap conversion: flushing valuable publication checkpoints is useful, but frequent flushes can hurt speed; logging and Dossier writes need batching/throttling.
- **MQL5 EventSetTimer / OnTimer / runtime event queue** — https://www.mql5.com/en/docs/eventfunctions/eventsettimer and https://www.mql5.com/en/docs/runtime/running  
  Roadmap conversion: timers/events are serialized and duplicate timer events are not queued while one is pending/processing; Dossier queue work must be bounded and resumable instead of giant blocking writes.
- **MQL5 EventSetMillisecondTimer** — https://www.mql5.com/en/docs/eventfunctions/eventsetmillisecondtimer  
  Roadmap conversion: shorter timers increase handler frequency; heartbeat work needs strict budgets.
- **MQL5 CopyBuffer / Technical Indicators** — https://www.mql5.com/en/docs/series/copybuffer and https://www.mql5.com/en/docs/indicators  
  Roadmap conversion: indicator lanes need handle/readiness/cache/memory rules; broad L3/L4 loops must not casually add CopyBuffer work.
- **MQL5 CopyTicks** — https://www.mql5.com/en/docs/series/copyticks  
  Roadmap conversion: tick-history access can synchronize data and may wait in EAs/scripts; deep tick analysis stays selected/top10 only.
- **MQL5 SymbolInfoTick** — https://www.mql5.com/en/docs/marketinformation/symbolinfotick  
  Roadmap conversion: current tick and update time are broad freshness primitives for L1/L2; stale tick must not create clean confidence.
- **BIS FX volume/volatility/spreads research** — https://www.bis.org/publ/work93.pdf  
  Roadmap conversion: spread, volatility, and volume/liquidity conditions are linked; scalping rank must account for spread/freshness/friction, not only direction-like features.
- **Investopedia bid-ask spread** — https://www.investopedia.com/terms/b/bid-askspread.asp  
  Roadmap conversion: spread is transaction cost and a liquidity proxy; use spread %, spread-to-ATR, and spread-to-room diagnostics.
- **NIST log management guidance** — https://nvlpubs.nist.gov/nistpubs/legacy/sp/nistspecialpublication800-92.pdf  
  Roadmap conversion: high log volume and inconsistent fields are a real management/performance risk; logs must be structured and bounded.
- **Google SRE monitoring guidance** — https://sre.google/sre-book/monitoring-distributed-systems/ and https://sre.google/workbook/monitoring/  
  Roadmap conversion: monitoring should prioritize useful symptoms, structured events, and operator-actionable evidence; do not spam logs with noise.
- **Backtest overfitting / validation research** — https://www.davidhbailey.com/dhbpapers/backtest-prob.pdf  
  Roadmap conversion: strategy/edge expansion needs outcome review hooks and anti-overfit discipline before labels become trusted.

## Mandatory Research Question Format

Every future research item must answer:

1. What does it measure?
2. What claim does it validate?
3. What data is required?
4. Which layer owns it?
5. What runtime cost does it create?
6. What false-confidence risk does it create?
7. What existing Aurora feature overlaps it?
8. What logging proof is required?
9. What artifact proof is required?
10. What acceptance criteria would prove it helped?
11. Decision: reject, defer, add as test, or add as repair.

## Required Research Areas By Phase

### Platform / MQL5 Performance

- File sandbox, `FileOpen`, `FileMove`, `FileFlush`, `FileClose`, folder creation, file existence, temp/promote behavior.
- Timer/heartbeat event behavior, duplicate event drop/non-queue behavior, and handler budget implications.
- Indicator handles, `CopyBuffer`, buffer indexing, handle readiness, memory allocation, and caching.
- Tick access through `CopyTicks` and synchronization/wait behavior.
- Current tick access through `SymbolInfoTick` for broad freshness checks.
- Symbol properties and session/tradeability properties.
- File IO and logging cost patterns.

### Dossier Folder / Publication Research

Future Dossier repair runs must research and convert into code-audit questions:

- How existing writer/publication paths write root Dossier, per-symbol Dossiers, and GlobalTop10 Dossiers.
- How temp → validate → promote is currently implemented.
- Where publication can stall or leave shell files.
- Whether a cursor/queue/resume concept already exists.
- Whether write budget telemetry already exists.
- Whether manifest tracks per-symbol completion/stall states.
- Whether Current Focus and Market Board read from completed Dossier truth or stale partial truth.

### Logging Performance and Evidence

- Structured event format and stable field naming.
- Change-only, batched, summary, and throttled logging.
- Avoiding high-volume per-symbol spam every tick.
- Capturing missing-data/stale-data/false-confidence events.
- Capturing queue/backlog/stall telemetry.
- Capturing outcome review hooks without becoming a trading decision system.

### Formula and Indicator Truth

- ATR and ATR% for volatility/range, not direction.
- Spread %, spread-to-ATR, spread percentile, and spread-to-room for execution cost.
- Bollinger width, Keltner squeeze, Donchian range/boundaries for compression/breakout context.
- ADX, MA slope, ROC for trend/momentum quality.
- VWAP, z-score, range location, Bollinger position for value/reversion context.
- Multi-timeframe conflict handling.

### Market Microstructure / Execution Quality

- Spread as transaction cost and liquidity proxy.
- Tick freshness and stale quote risk.
- Session liquidity differences and overlap behavior.
- Rollover/low-liquidity spread widening risk.
- Slippage proxy possibilities without pretending to know actual fill quality.

### Strategy / Horizon Research

- Scalping evidence: immediate movement, fresh tick, low friction, session fit.
- Intraday evidence: session path, M15/M30/H1 context, same-day expiry.
- Restricted swing evidence: H4/D1 structure, 2-day max, Wednesday cutoff, no weekend carry.
- Strategy family permissions by regime: continuation, pullback, range rotation, breakout, failed-break, reversal, value reversion.

### Validation and Anti-Overfit

- Walk-forward / out-of-sample thinking.
- Backtest overfitting and multiple testing risk.
- Feature/rank logs that enable later manual or automated review.
- Outcome hooks that evaluate whether top-ranked symbols were useful inspection candidates.

## Method Admission Filter

No new method may enter roadmap implementation unless it answers:

1. What trade horizon does it support?
2. What regime does it work in?
3. What session/timing context does it require?
4. What data is required?
5. What layer owns it?
6. What runtime cost does it create?
7. What false-confidence risk does it create?
8. What contradiction behavior does it need?
9. How will it be logged?
10. How will later review prove whether it improved symbol selection?
11. What acceptance proof is required?

## Weak Sources Rule

Marketing/guru strategy pages may be used only as weak inspiration. They cannot justify formula, strategy, or ranking authority. Prefer official platform docs, formula references, practitioner execution material, and validation/overfit research.


## Final Academic / AI / MT5 Research Expansion

### Final hardening research source table

| Domain | Source / URL | Roadmap conversion |
|---|---|---|
| Currency momentum / carry | Burnside et al., “Carry Trade and Momentum in Currency Markets” — https://www.tse-fr.eu/sites/default/files/medias/stories/SEMIN_11_12/POLITICAL_ECONOMY/burnside.pdf | Momentum/carry are research-supported method families, but need validation, risk notes, transaction-cost review, and cannot justify live execution alone |
| Economic momentum | Dahlquist & Hasseltoft, “Economic Momentum and Currency Returns” — https://ideas.repec.org/a/eee/jfinec/v136y2020i1p152-167.html | Momentum lane must distinguish economic/cross-sectional/time-series/intraday variants and log horizon-specific outcomes |
| Carry unwind / volatility risk | “Currency Carry Trades, Position-unwinding Risk...” — https://papers.ssrn.com/sol3/Delivery.cfm/SSRN_ID2798723_code1484193.pdf?abstractid=2287287 | Carry context must include volatility/unwind/crash-risk guard and is not a scalp entry signal |
| FX microstructure / order flow | Evans / FX order-flow literature examples — https://ideas.repec.org/a/eee/inecon/v80y2010i1p58-71.html | Retail MT5 must mark tick/spread/quote activity as proxy evidence unless true order-flow data exists |
| Data snooping / overfit | Bailey et al. backtest overfitting material — https://www.davidhbailey.com/dhbpapers/backtest-prob.pdf | Backtest is not enough; require walk-forward/OOS/forward-review and multiple-testing caution |
| MT5 current tick | MQL5 SymbolInfoTick — https://www.mql5.com/en/docs/marketinformation/symbolinfotick | Broad L1/L2 freshness can use current tick/time safely, but stale/failed tick cannot create confidence |
| MT5 tick history | MQL5 CopyTicks — https://www.mql5.com/en/docs/series/copyticks | Deep tick analysis must stay selected/top10 because synchronization/history reads can be expensive |
| MT5 indicators | MQL5 CopyBuffer and BarsCalculated — https://www.mql5.com/en/docs/series/copybuffer and https://www.mql5.com/en/docs/series/barscalculated | Indicator expansion needs handle/readiness/cache rules and must not enter broad loops casually |
| MT5 file/timer model | MQL5 FileFlush, OnTimer, EventSetTimer — https://www.mql5.com/en/docs/files/fileflush / https://www.mql5.com/en/docs/event_handlers/ontimer / https://www.mql5.com/en/docs/eventfunctions/eventsettimer | Logging/publication must be bounded; frequent flushing and timer overload can slow runtime |
| MT5 Strategy Tester | MQL5 testing docs — https://www.mql5.com/en/docs/runtime/testing | Tester evidence must account for tick generation, spread simulation, function limitations, and broker data differences |
| AI governance | NIST AI RMF — https://nvlpubs.nist.gov/nistpubs/ai/nist.ai.100-1.pdf and NIST AI RMF Playbook — https://airc.nist.gov/airmf-resources/playbook/manage/ | AI readiness requires validity/reliability, explainability, monitoring, drift response, rollback/decommission, and operator review |
| Financial AI kill switch | MAS AI risk management information paper — https://www.mas.gov.sg/-/media/mas-media-library/publications/monographs-or-information-paper/imd/2024/information-paper-on-ai-risk-management-final.pdf | Future high-risk AI/autonomy needs kill-switch style controls; not part of current live execution |


The following source categories must guide future strategy/AI phases. Research is converted into roadmap constraints, not live trade authority.

### Academic FX / Strategy Evidence Sources To Prefer

- Currency momentum: cross-sectional currency momentum, time-series momentum, economic momentum, transaction costs, horizon definitions.
- Carry trade: interest-rate differential, volatility risk, carry unwinding, crash/skew risk, why carry is context/risk for scalp-first systems.
- Value / mean reversion: PPP/value literature, z-score/range-location logic, retail FX VWAP caveats.
- Trend following / breakout: trend-strength vs direction distinction, breakout-confirmation rules, compression-expansion failure handling.
- FX microstructure/order flow: academic order-flow work, but retail MT5 implementation must treat tick/quote/spread activity as proxies unless true order-flow data exists.
- Transaction costs and liquidity: spread, slippage, volatility, quote freshness, and liquidity regime.
- Technical trading rule validation: data-snooping, overfitting, reality-check methods, out-of-sample verification.
- Walk-forward validation: time-series train/test split, rolling windows, forward-review, broker/session/regime performance.
- Model monitoring: feature drift, model drift, confidence calibration, explainability, rollback, kill switch.

### Current source examples added by final hardening

- Burnside, Eichenbaum, Kleshchelski, and Rebelo, “Carry Trade and Momentum in Currency Markets” — currency carry and momentum are empirical strategy families, but their apparent profitability has competing explanations and risk/peso-problem concerns.
- Dahlquist and Hasseltoft, “Economic Momentum and Currency Returns” — currency momentum can be studied as a return factor, but must be horizon-specific and tested separately from carry/value.
- Brunnermeier/Nagel/Pedersen-style carry unwind risk literature and newer carry-unwinding papers — carry is exposed to volatility/crash/unwind risk and cannot be treated as clean scalp entry logic.
- Evans/Lyons FX microstructure/order-flow research — order flow is academically meaningful, but retail MT5 usually supplies tick/quote/spread proxies, not true interbank order flow.
- White / Bailey / technical-rule validation literature — repeated strategy trials create data-snooping and backtest-overfitting risk.
- NIST AI RMF / NIST AI RMF Playbook — AI outputs need governance, monitoring, explainability, validity/reliability, drift response, and decommission/kill-switch conditions.
- MAS AI risk management guidance — mission-critical AI in finance can require kill-switch style controls.
- MQL5 SymbolInfoTick / CopyTicks / CopyBuffer / BarsCalculated / FileFlush / OnTimer / EventSetTimer / Strategy Tester docs — MT5 data access and event model constrain what can run broad vs selected/top10/deep.

### Required research questions for every strategy family

1. What academic or practitioner evidence supports testing the method?
2. What horizon is the evidence about?
3. What market type is the evidence about?
4. What regime does it require?
5. What session/timing context does it require?
6. What MT5 data is required?
7. Is the MT5 data true data or proxy data?
8. What layer can afford the method?
9. What runtime cost does it create on 60 / 200 / 1,200 symbols?
10. What transaction-cost sensitivity exists?
11. What contradiction flags are required?
12. What geometry fields are required?
13. What outcome labels prove or reject it?
14. What backtest/walk-forward/forward-review evidence is required?
15. What is the kill/rejection condition?

### Full-auto governance research boundary

Future full-auto research may study execution APIs, risk guards, kill switches, and prop-firm compliance only inside a separate future execution roadmap. Truth Seeker may prepare dataset, evidence, validation, and advisory surfaces only.

## Source Library / Academic Crosswalk Research Rules

Future source-library runs must research each family enough to convert source material into roadmap requirements, not generic education.

### Required research conversions

| Research family | Roadmap conversion |
|---|---|
| Adaptive markets / regime adaptation | Strategy cards must include regime fit, decay risk, and revalidation trigger. |
| Random walk / efficient markets / anti-overconfidence | No pattern/indicator claim is trusted without objective OOS/forward evidence. |
| Evidence-based technical analysis | Technical labels require precise objective rules and statistical/testable definitions. |
| Financial ML | Feature datasets need no-lookahead labels, purging/embargo where relevant, feature/version governance, and advisory-only AI. |
| Market microstructure | Spread, tick age, liquidity, transaction cost, slippage, and quote freshness must shape rank/permission. |
| Auction / market profile | Acceptance/rejection/value ideas become measurable candidates only; no fake order-flow claims. |
| Systematic / quant | Walk-forward, OOS, parameter stability, and reject criteria are mandatory. |
| Technical analysis / price action | Price-action/candle/pattern labels are weak candidates until outcome-validated. |
| Volatility / options / tail risk | Volatility expansion/compression and tail-risk warnings must include ruin/prop-firm constraints. |
| Behavioral / decision science | Confidence language, decision journaling, and overconfidence guards must be explicit. |
| MT5/MQL5 | Data availability and runtime cost decide layer fit. |

### Research output required

Every research section must answer:

1. What testable method candidate does this source justify?
2. What false-confidence risk does it create?
3. What MT5 data is required?
4. What layer is lawful?
5. What logs/outcome labels are required?
6. What would reject it?
7. What language is allowed before Aurora validation?
