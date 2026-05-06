# Truth Seeker Laws

**Status:** Active roadmap law package.  
**Updated:** 2026-04-26  
**Authority:** Roadmap/control only. This file does not patch MT5 source, trading logic, compile roots, runtime paths, or version files.

## Roadmap Identity

Aurora Truth Seeker is the active roadmap for turning Aurora Sentinel Core into a better truth-production scanner for prop-firm scalp-first trading.

It is not a signal engine rewrite. It is not a new EA. It is not a reason to create new engines, new runtime lanes, new artifact families, new Dossier systems, or new logging systems.

The roadmap exists to improve truth quality, Dossier / Current Focus / Market Board consistency, symbol evidence coverage, rank explainability, contradiction detection, scalp / intraday / restricted-swing horizon permission, regime/session/timing/geometry truth, lightweight logging, runtime speed, HUD speed, and regression resistance.

Files are authority. Git history and old archives are evidence only. Runtime screenshots/output are evidence, not code authority. Future runs must read current files before changing anything.

## Law 0 — Existing-Path-Only / No-New-Code-Path Law

Every future implementation run must begin with this declaration:

> Edit existing code paths only. Do not create new files/modules/engines unless the operator explicitly overrides this, and default assumption is no.

Future fixes must improve the existing system, not bypass it.

### Allowed later, only when proven by source audit

- Improve existing functions inside the rightful owner file.
- Add small helper functions inside the existing rightful owner file only.
- Extend existing structs/enums only when source-compatible and dependency-reviewed.
- Improve existing writers without making them truth owners.
- Improve existing logging through the current logging owner/path only.
- Improve existing artifact sections without creating new artifact families.
- Improve existing queue/cadence/publication behavior through the current runtime, writer, and IO/publication owners.

### Forbidden by default

- New engine folder.
- New runtime lane.
- New truth owner.
- New writer-owned calculation path.
- New HUD calculation path.
- New parallel Dossier system.
- New publication path beside existing IO/publication owner.
- New ranking engine beside existing shortlist/ranking owner.
- New strategy engine beside existing interpretation owner.
- New logging subsystem beside the existing logging owner.
- New artifact family or hidden output folder.
- Include-order rewiring unless the active phase explicitly proves it is necessary.

### Dependency / mother-child protection

Future workers must preserve current include relationships, compile roots, child/mother ownership, dispatcher ownership, IO/publication ownership, and writer/engine separation. If a fix needs a dependency change, the run must stop and create a smaller dependency-proof run.

## Non-Negotiable Truth Laws

1. **No claim without evidence.** Every displayed trading claim must trace to data, formula, support flag, explicit insufficient-evidence state, or logged dependency block.
2. **No strategy without trade horizon.** Every strategy label must say whether it is scalp, intraday/day trade, restricted swing, mixed, blocked, or insufficient evidence.
3. **Scalp is primary.** Aurora’s first priority is fast, fresh, low-friction, session-aligned symbol selection.
4. **Intraday is secondary.** Intraday can use deeper structure and wider timing windows, but must remain same-day and avoid overnight assumptions.
5. **Swing is third and restricted.** Swing ideas are maximum 2 days, no entries later than Wednesday, and no weekend carry.
6. **No clean claim before contradiction scan.** Before Aurora says strong, clean, tradable, opportunity, high-confidence, Top 10-worthy, or selected, it must check for conflict.
7. **Regime controls strategy permission.** Continuation, pullback, range rotation, breakout, failed breakout/reclaim, reversal, and value-reversion labels must match regime evidence or display a conflict/block state.
8. **Session controls timing permission.** The same setup can be valid in London/New York overlap and weak during rollover. Session state must affect now-quality, rank meaning, and strategy expiry where applicable.
9. **Timing quality is edge truth.** A symbol can be good overall but bad right now. Aurora must distinguish now-quality from next-window quality.
10. **Speed is part of truth.** A slow signal is stale truth. Broad layers stay light; deep layers stay selective; HUD and writers stay consumer/composer only.
11. **Every edge idea needs a review path.** If it cannot be logged and reviewed later, it is not an edge claim yet.
12. **Every rank needs a reason.** No rank may exist without support reasons, penalties, conflicts, freshness/age state, and why-not-higher where applicable.
13. **Unavailable must not create confidence.** Unavailable, stale, placeholder, zero-default, or insufficient data cannot feed clean confidence.
14. **Artifacts must not disagree silently.** Dossier, Current Focus, Market Board, HUD, manifest, and logs must align or expose role differences/conflict.
15. **No heavy work in the wrong layer.** Layer 3/4 stay lightweight. Layer 5/6 own deeper confirmation. HUD and writers must not compute hidden truth.
16. **No beautiful noise survives.** Fields, labels, sections, and summaries that do not improve truth, ranking, contradiction detection, logging, operator decision quality, or review must be downgraded, hidden, removed, or moved to log-only.

## Dossier Hydration Class Law

The Dossier folder is an evidence product, not a file-size contest. File size is diagnostic only.

Future Dossier-folder repair must complete the existing Dossier publication queue; it must not create a new Dossier system.

| Class | Applies to | Expected truth |
|---|---|---|
| `CLOSED_L0_L2` | Closed, inactive, not tradeable, or not currently eligible symbols | Compact Layer 0–2 only; no L3–L6 claims; no unavailable padding; reason deeper layers are absent |
| `OPEN_L0_L4` | Open, tradeable, L3/L4-eligible symbols | Layer 0–4 hydrated; candidate/ranking truth; reason codes; freshness, friction, market state, quote/spec/session evidence; shortlist context where applicable |
| `TOP10_L0_L6` | Auto Top 10 symbols only | Layer 0–6 hydrated through existing Deep Selective Analysis / Dossier paths only |
| `SELECTED_L0_L6` | Selected/current-focus symbol only | Layer 0–6 hydrated through existing Deep Selective Analysis / Current Focus / Dossier paths only |
| `STALLED` | Symbol due for hydration but not completed | Expected vs actual layers, queue state, stall reason, retry state |
| `INCOMPLETE` | Partial or mismatched hydration | No full-truth claim; queue/backfill required |
| `DEPENDENCY_BLOCKED` | Missing broker/spec/quote/session dependency | Missing dependency shown and retry/downgrade state logged |

A 3 KB file can be acceptable only if it honestly represents compact Layer 0–2 truth and records the state reason. A 3 KB open/eligible Dossier is a failure unless the file and manifest/logs record a real reason such as dependency block, stalled queue, interrupted publication, or not-yet-completed backfill.

## 3 KB Dossier Diagnostic Law

Future workers must not treat every 3 KB file as a bug and must not treat every large file as truth.

| 3 KB cause | Status | Required roadmap response |
|---|---|---|
| Closed/inactive and honest Layer 0–2 compact truth | Not a bug | Retain compact file and log `CLOSED_L0_L2` |
| Open/eligible but hydration never completed | Bug/backlog/stall | Resume through existing publication queue |
| Writer padded unavailable shells | Bug/info garbage | Remove/downgrade padding and log unavailable count |
| Broker/spec/quote dependency missing | Dependency block | Log `DEPENDENCY_BLOCKED`, required missing input, retry rule |
| Write cycle ran out of budget/time | Scheduling/budget issue | Resume later with cursor and budget telemetry |
| Publication interrupted | Atomic publication/resume issue | Temp → validate → promote proof and retry |

## Layer and Artifact Boundary Law

- Layer 0–2: available for all symbols as identity, classification, market state, symbol/spec/session/quote truth.
- Closed symbols: Dossier should stop at Layer 0–2 unless continuity notes are needed.
- Open symbols: Dossier should include Layer 0–4 so all open symbols can be checked for candidate/ranking truth.
- Layer 5–6: only auto Top 10, selected, or Deep Analysis-entitled symbols.
- Dossier: canonical symbol truth artifact.
- Current Focus: selected-symbol derivative of Dossier truth, not an independent truth owner.
- Market Board: compressed selection board, not hidden truth owner.
- HUD: read-only consumer, not truth owner.
- Writers: compose truth, do not calculate hidden truth.
- Logging: records evidence, does not decide truth.

## Logging Evidence Law

Logging must make future edge improvements provable without slowing the scanner. Future implementation must use the existing logging owner/path only.

Logging must eventually capture, where applicable: formula inputs/outputs, support flags, unavailable/stale counts, quote freshness, spread/friction, rank inputs/penalties/reasons/movement, candidate and shortlist reason codes, contradiction severity, session/timing/horizon/regime permissions, Dossier hydration class, expected vs actual layer range, file size, section count, write timings, write budget, queue position, queue remaining, retry count, stall reason, temp/promote success, last-good fallback usage, Top 10 membership, Deep Analysis trigger, Current Focus sync, Market Board alignment, selected-symbol outcome review, and false-confidence detection events.

Logging must be change-only where possible, summary/batched where possible, throttled where necessary, structured enough for later review, lightweight enough for 60 / 200 / 1,200-symbol servers, and never a truth owner.

## Completion Queue Law

The Dossier folder completion problem must be fixed by completing existing publication work, not by creating a new publication system.

Future repair must consider only existing owner paths and should add/harden, inside rightful existing files only when proven: bounded per-heartbeat writing, chunked Dossier folder hydration, continuation cursor, resume after interruption, backfill queue for shell files, open-symbol priority, closed-symbol compact retention, Top 10/deep entitlement priority, manifest proof of pending/completed/stalled states, temp → validate → promote publication, write budget telemetry, symbol count telemetry, queue remaining count, last completed symbol, failed symbol retry reason, publication age, and hydration class per symbol.

Forbidden responses: one giant blocking write, HUD slowdown, broad L5/L6 computation, file-size padding, new Dossier writer, or new publication path.

## Trade Horizon Taxonomy

### SCALP — PRIMARY

Expected holding style: seconds to minutes; sometimes short multi-minute holds. Required evidence: fresh quote/tick state, acceptable spread and spread-to-room/spread-to-ATR context, tick activity or recent update cadence, immediate movement or near-window pressure, session fit, no severe contradiction, clear invalidation context, and low stale-risk.

### INTRADAY / DAY TRADE — SECONDARY

Expected holding style: minutes to hours, same-day only. Required evidence: M15/M30/H1 context where supported, session path, volatility regime, structure level, trend/range classification, timing window, intraday invalidation, no overnight dependency, and no unresolved major contradiction.

### RESTRICTED SWING — THIRD

Expected holding style: up to 2 days; no Friday/weekend carry; no new swing labels after Wednesday unless operator explicitly overrides. Required evidence: H4/D1 structure where supported, room to target before expiry, gap/weekend risk block, no scalp/intraday label pretending to be swing, explicit expiry and invalidation.

## Strategy / Edge Expansion Laws

Future edge expansion must improve truth, not decorate artifacts. Every new or repaired method must define what it measures, what claim it validates, data required, rightful layer, runtime cost, false-confidence risk, existing system overlap, contradiction behavior, logging proof, acceptance criteria, and reject/defer/add/test decision.

No indicator or strategy method may be added before Dossier hydration boundaries, logging evidence, and contradiction safeguards are available.

## Runtime Layer Law

| Layer | Purpose | Broad or Selective | Must Not Do |
|---|---|---|---|
| L0 | Identity/classification/metadata | Broad | Trade/strategy claims |
| L1 | Market state/open/closed/uncertain | Broad and fast | Heavy calculation |
| L2 | Market Watch/spec/session/quote truth | Broad for eligible symbols | Deep indicators |
| L3 | Candidate Filtering | Broad but lightweight | Heavy CopyTicks/CopyBuffer loops |
| L4 | Shortlist Selection / Top 10 ranking | Lightweight ranking | Deep strategy confirmation for all symbols |
| L5 | Deep Selective Analysis | Selected/Top10/on-demand | Broad all-symbol hydration |
| L6 | Strategy interpretation / trade framing support | Selected/Top10/deep-entitled | Entry execution or hidden trade decision |

## Practical Truth Perfection Standard

Aurora is improved only when a future run makes one of these better: fewer false clean claims, fewer shell/open-symbol Dossiers, stronger hydration class proof, stronger rank reason proof, stronger contradiction exposure, better horizon/session/regime permission, better review logging, better Dossier/Current Focus/Market Board alignment, less runtime/HUD drag, clearer no-new-path ownership, or smaller regression surface.

A run that only sounds smarter, adds fields without evidence, or creates a new system has failed.


## Academic / AI / Full-Auto Lockout Laws

### Law — Academic evidence is not live proof

Academic research can justify a test lane. It cannot justify live execution by itself. Academic evidence must be converted into a falsifiable method candidate with horizon, regime, session, geometry, conflict, logging, validation, and rejection rules.

### Law — No full auto now

Aurora may prepare for future autonomy but may not place, manage, or close live trades in the current roadmap.

Current roadmap forbids `OrderSend`, `OrderSendAsync`, `CTrade.Buy`, `CTrade.Sell`, automated entry, automated exit, automated lot sizing, automated SL/TP placement, automated position management, news auto-trading, hidden execution layers, and “AI decides trade” live execution.

### Law — No execution creep

No future Truth Seeker run may add `OrderSend`, `CTrade`, auto lots, auto SL/TP, auto close, hidden trade management, or any trade-execution path unless the operator explicitly opens a separate full-auto execution roadmap.

### Law — AI starts as analyst, not trader

AI may explain, classify, rank, summarize conflict, suggest review candidates, and support paper-intent labels. AI may not execute, size, manage, close, or silently transform advisory output into live orders.

### Law — Every strategy needs five dimensions

Every strategy label needs horizon, regime, session, geometry, and conflict context. A strategy label without those five dimensions is incomplete and must be downgraded, hidden, or marked review-only.

### Law — Every strategy needs an outcome review path

If a strategy cannot be logged and reviewed later, it is not an accepted strategy. Outcome labels are research evidence first, not permission to trade.

### Law — No black-box confidence

AI/model confidence must be explainable, calibrated, logged, versioned, and advisory until proven. Decorative confidence is forbidden.

### Law — Backtest is not enough

No method becomes trusted from backtest alone. It needs walk-forward, forward-review, live-output comparison, broker/server review, session/regime review, and operator review.

### Law — MT5 reality controls strategy design

If MT5 cannot provide the required data cheaply and truthfully at the intended layer, the method must be rejected, deferred, or moved deeper. Broad layers must remain light. Heavy tick/indicator work belongs only where selected/top10/deep entitlement and performance proof allow it.

### Law — Geometry supports permission, not entry

Geometry can improve trade-quality classification and strategy permission. It must not become hidden entry, exit, sizing, SL/TP, or position-management logic.

### Law — Full-auto is a future branch only

Full-auto is a future capability path, not a current implementation target. The current roadmap may prepare Level 0–2 and research toward Level 3 only. Level 4–6 require a separate future execution roadmap, explicit operator unlock, long forward proof, kill switch, risk guard, prop-firm compliance, broker validation, and no unresolved truth contradictions.

## Source Library / Book-to-Aurora Laws

### Law — Books are source material, not proof

Book files, book screenshots, public summaries, and practitioner claims may generate research questions and method candidates. They do not prove edge, strategy validity, or operator-facing confidence.

### Law — Screenshot-only titles are uncertain

If only screenshots or titles are provided, future workers may classify the title by source family and research public context. They must not claim the book was deeply read, fully extracted, or implemented.

### Law — Uploaded books are extracted conceptually and copyright-safely

If book files are uploaded, future workers may extract concepts, method ideas, source-family summaries, and card candidates. They must not reproduce long copyrighted passages or flatten book text into roadmap files.

### Law — Aurora EA zip reference is mandatory

Every strategy/book/academic expansion run must inspect the current uploaded Aurora EA zip/source before declaring a method missing, implemented, partial, duplicated, or rejected. Implementation claims require file/function/card/log proof.

### Law — No strategy without card

No strategy, method, or operator-facing strategy label may survive as a clean label without a strategy/method card that defines source family, source confidence, horizon, regime, session, MT5 data required, layer ownership, formula/rule, unavailable-data behavior, false-confidence risk, contradiction conditions, ranking use, label use, geometry, logging, outcome labels, validation, prop-firm constraints, full-auto status, implementation status, acceptance criteria, and rejection criteria.

### Law — No method without MT5 data fit

A method without reliable, affordable MT5 data at its intended layer must be rejected, deferred, or moved to a deeper/selective layer. Broad L3/L4 methods must remain light. Heavy tick/indicator/history work belongs only in selected/top10/deep-entitled paths after proof.

### Law — No proof without Aurora logs

Academic or practitioner support can justify a test. Trust requires Aurora logs, feature records, outcome labels, and forward/backtest/walk-forward review appropriate to the method.

### Law — No strategy-label bloat

Duplicate labels must be merged under canonical cards. Weak wording must become review-only, log-only, hidden-until-validated, or rejected.

### Law — AI corpus remains advisory

AI Forex GPT may use the source-library index, crosswalk, method cards, ledgers, logs, outcomes, rejections, and operator notes for explanation and research suggestions only. It may not create or bypass execution logic.


## Law 17 — Roadmap Progress Must Be Logged

Every future worker run must read `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` before any other roadmap/control file and must update it before final packaging.

No phase may be marked complete unless the active log records:

- files read
- internet research used, or explicit reason research was not needed for roadmap-control-only work
- files changed
- truth gap addressed
- compile proof status
- live proof status
- artifact proof status
- logging proof status
- remaining risks
- next valid run

If the active log is missing, stale, contradictory, or not updated, the run is incomplete.

This law exists to prevent roadmap drift, repeated work, skipped dependencies, old-roadmap regression, false proof claims, and worker chats losing the current phase/run state.
