# ARL Research Ledger

## Purpose

Research is mandatory, but it must not become cosmetic doctrine.

Every research item must become:
- implementation rule
- test
- falsifier

## Triple-layer research rule

Every serious ARL research-backed change must include:

1. External source finding
2. ASC/archive lesson
3. ARL implementation rule

Then:
- test
- falsifier
- affected module

---

## R001 — Timer / scheduler constraints

External source:
MQL5 `OnTimer` documentation states that timer events are generated after activation with `EventSetTimer`, that each EA has its own timer, and that if a Timer event is already queued or processing, a new Timer event is not added to the queue. The docs also note high-resolution timer events are constrained in real time by hardware limits.

Source:
https://www.mql5.com/en/docs/event_handlers/ontimer
https://www.mql5.com/en/docs/eventfunctions/eventsettimer

ASC/archive lesson:
ASC accumulated large dispatcher pressure and breathing/publish timing complexity.

ARL implementation rule:
OnTimer must be a small scheduler tick, not a giant dispatcher. Work must be sliced, due-based, and bounded by budget.

Test:
Force a heavy symbol universe and verify heartbeat remains alive while work is deferred safely.

Falsifier:
OnTimer performs full L1-L5 work in one pass or misses scheduled Timer events because it runs too long.

Affected:
runtime, scheduler, heartbeat.

---

## R002 — File flushing and publication

External source:
MQL5 `FileFlush` writes buffered file data to disk, but frequent calls may affect speed.

Source:
https://www.mql5.com/en/docs/files/fileflush

ASC/archive lesson:
ASC had atomic intent, temp/readback/promote/no-change concepts, and current/retained/staging distinctions, but operator files became verbose and sync-prone.

ARL implementation rule:
Only public artifacts use flush/readback/promote. Internal noise must not flush every micro-update.

Test:
Write status/board through temp path, readback, promote, and verify current file is unchanged on failure.

Falsifier:
A partial temp payload is visible as current.

Affected:
io, publication, manifest.

---

## R003 — File move / promote behavior

External source:
MQL5 `FileMove` moves/renames files and requires rewrite flags if the destination exists.

Source:
https://www.mql5.com/en/docs/files/filemove

ASC/archive lesson:
Route and current/retained/staging handling became complicated.

ARL implementation rule:
ARL FilePublisher must own promotion behavior centrally. Writers do not directly move public files.

Test:
Attempt publish with existing current file and verify replacement only through FilePublisher.

Falsifier:
Any module calls FileMove directly outside FilePublisher.

Affected:
io, all writers.

---

## R004 — Indicator readiness

External source:
MQL5 `iATR` returns an indicator handle; `CopyBuffer` returns copied data count or `-1`, and if data is not ready/built/downloaded it can return `-1` while initiating build/download.

Source:
https://www.mql5.com/en/docs/indicators/iatr
https://www.mql5.com/en/docs/series/copybuffer

ASC/archive lesson:
Old outputs could show unavailable/partial indicators but became noisy.

ARL implementation rule:
Indicator modules must use READY / BUILDING / PARTIAL / FAILED, never fake zeros. Indicator handles must be cached and released.

Test:
Start ATR on a not-yet-built symbol/timeframe and confirm BUILDING appears before READY.

Falsifier:
ATR = 0.0 with READY status after CopyBuffer failure.

Affected:
indicators, Layer 3, Layer 5.

---

## R005 — Account info

External source:
MQL5 provides `AccountInfoInteger`, `AccountInfoDouble`, and `AccountInfoString` for account properties including account login, leverage, and trade permission flags.

Source:
https://www.mql5.com/en/docs/account/accountinfointeger

ASC/archive lesson:
Execution/account reality was present in ASC board language but must become mandatory and cleaner in ARL.

ARL implementation rule:
Account snapshot is mandatory before Market Board READY. Samples must mask account identifiers.

Test:
Board cannot publish READY without account snapshot or explicit account_unavailable status.

Falsifier:
Board publishes upload suggestions while account/exposure state is absent.

Affected:
account, market board, dossiers.

---

## R006 — ASC Market Board lessons

External source:
Uploaded ASC Market Board sample.

ASC/archive lesson:
Keep:
- ranking split
- bucket-local vs global Top 10 distinction
- scoring grammar
- explicit missingness
- review vs trade permission separation
- exposure/correlation context

Drop/compress:
- repeated proof-boundary prose
- route diagnostics unless contradiction exists
- operator-facing long taxonomies
- labels without numeric fields

ARL implementation rule:
Market Board must be numeric-first, snapshot-bound, and concise.

Test:
Board row shows global/major/minor rank, scores, account exposure, snapshot ids, and publish status.

Falsifier:
Board row uses qualitative labels without numeric backing.

Affected:
market board, Layer 4.

---

## R007 — ASC dossier lessons

External source:
Uploaded CADSGD dossier sample.

ASC/archive lesson:
Keep:
- numeric L3/L4/L5 score stack
- publication health
- section status
- board baseline relation
- no-trade boundary

Drop/compress:
- repeated diagnostic blocks
- repeated trade_permission=false inside every small block
- optional unavailable fields that do not affect review
- route diagnostics unless contradiction exists

ARL implementation rule:
Dossier must be numeric-first with required/optional missing split.

Test:
Dossier shows required_missing_count and optional_missing_count separately.

Falsifier:
Optional broker metadata missing marks the entire dossier degraded.

Affected:
dossiers.

---

## R008 — ASC SDP atomic and owner-gap lessons

External source:
Uploaded EURUSD Symbol Data Pack sample.

ASC/archive lesson:
Keep:
- temp/readback/promote/no-change/retained-final concepts
- numeric rule
- writer composes only existing owner truth
- one operator file per symbol

Fix:
- L3/L4 fields must be transported into per-symbol outputs through committed snapshots, not left unknown due to compose callsite gaps.

ARL implementation rule:
Dossiers and symbol files must consume committed L3/L4 snapshots by `snapshot_id` and `exact_broker_symbol`.

Test:
Every visible Market Board symbol has matching per-symbol rank context.

Falsifier:
Per-symbol dossier shows L3/L4 unknown while board row has L3/L4 current.

---

## 2026-05-06 — ARL-RUN005 Research Status

Status:
LIVE INTERNET RESEARCH BLOCKED IN THIS CHAT ENVIRONMENT.

Required research topics requested:
- MQL5 `#property version` / EA description display
- MQL5 `input group` behavior
- MQL5 timer queue behavior
- MQL5 file publication functions and atomic publication limits
- MQL5 relative include behavior
- MQL5 account/position/order/history separation
- MQL5 `CopyBuffer` / indicator handle readiness
- Git commit-message practices
- release/versioning practices
- retry/backoff practices
- observability/health metrics principles

Evidence rank:
No fresh external-source evidence was produced inside RUN005 because web browsing was unavailable. Prior known doctrine and previous run notes may guide constraints, but they do not upgrade proof.

Coding constraints retained despite blocked research:
- Do not claim compile/runtime behavior from documentation alone.
- Keep timer work slices light until MetaEditor/runtime evidence proves otherwise.
- Keep file publication as temp/write/readback/promote until tested.
- Keep account, positions, orders, and deal history as separate source owners.
- Treat indicator values as unavailable until handles and buffers prove readiness.
- Keep Git/office as change-history owner; do not create a changelog source module.

Acceptance test:
A future research-capable run must refresh official/primary sources and convert each finding into coding constraints, documentation constraints, acceptance tests, and falsifiers before implementing runtime IO/scheduler/account/indicator behavior.

Falsifier:
Any future run claims official research proof without cited sources or without converting research into tests and constraints.
