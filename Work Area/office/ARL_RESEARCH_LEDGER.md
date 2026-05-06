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

## 2026-05-06 — ARL-RUN007 Mandatory External Research

Research was performed before patching and converted into constraints.

| Topic | Primary source | ARL constraint | Affected area | Acceptance test | Falsifier |
|---|---|---|---|---|---|
| MQL5 program properties | MQL5 Program Properties documentation | `#property version` and `description` belong in the main `.mq5`; included-file properties are ignored; description length must stay controlled. | `mt5/ARL_Core.mq5`, `mt5/core/ARL_Version.mqh`, version policy | Main `.mq5` version equals version constant; no included-file property reliance. | Version/description truth only exists in an included file or stale main property remains. |
| MQL5 input groups | MQL5 Input Variables documentation | `input group` is visual organization and must not be used as hidden logic/proof. | `mt5/ARL_Core.mq5`, input standards | Inputs are grouped for operator readability only. | Group labels become source-of-truth logic or hidden routing. |
| MQL5 timer lifecycle | MQL5 OnTimer/EventSetTimer/EventKillTimer documentation | Timer setup belongs in init and timer cleanup belongs in deinit when runtime is implemented. | runtime scheduler/heartbeat | Future runtime uses explicit timer lifecycle and logs timer state. | Timer is started without cleanup or status visibility. |
| MQL5 file I/O | MQL5 FileOpen/FileWrite/FileFlush/FileMove/FileDelete/FileIsExist docs | Atomic publication must stage/write/flush/verify/promote; file presence alone is not proof. | `mt5/io`, atomic publication blueprint | Future writer reports write, flush, move, existence/readback state. | Current files are overwritten silently or FileFlush/readback status is absent. |
| MQL5 account/trade history | MQL5 AccountInfo*, PositionsTotal, OrdersTotal, HistorySelect, HistoryDealsTotal docs | Account exposure, open positions, pending orders, and closed deals are separate truth lanes. | account, Market Board, dossiers, symbol trader pack | Per-symbol trader pack includes exposure and recent closed trades separately. | Closed trade history is inferred from open positions or omitted. |
| MQL5 indicators / readiness | MQL5 iATR, CopyBuffer, BarsCalculated docs | Indicator handles and buffer reads need readiness checks; CopyBuffer can return unavailable/partial data. | indicators, L3/L5 future modules | Future indicator modules validate handle, BarsCalculated, CopyBuffer return count, and release handles. | ATR/range data is accepted without readiness or return-count checks. |
| Git commit messages | Git commit documentation | Use short title plus blank line plus deeper body; ARL adapts with detailed structured body because user wants depth. | office, roadmap, report | RUN007 Git summary/description template exists. | Commit body is tiny/noisy or lacks why/boundaries/evidence. |
| Retry/backoff and observability | General engineering principle from scheduler/status-output practice | Retries must expose attempts, next due time, failure reason, and backoff state; no silent retry storms. | runtime, telemetry, roadmap | Future scheduler/status output exposes cadence and retry health. | Refresh stalls without due/backoff/error visibility. |

Research rejected as ornamental if it did not become one of: constraint, affected file, acceptance test, or falsifier.

---

## 2026-05-06 — ARL-RUN008 Research Addendum

Run:
ARL-RUN008-INDEX-GPT-CODEX-AGENT-GUIDE-SYSTEM

Research topic:
Codex/agent instruction behavior, repository instruction-file conventions, Git message best-practice constraints, and documentation architecture patterns for repo maps and contributor guides.

Findings converted into ARL requirements:

1. Codex/agent behavior requirement:
   - Create root `AGENTS.md` because Codex reads project instructions before work and can use repo-specific guidance for commands, tests, and expectations.
   - Acceptance test: `AGENTS.md` exists at repository root and points to Work Area mandatory-read files.
   - Falsifier: future agent starts from repo without a root instruction file or without mandatory read order.

2. Repository instruction convention requirement:
   - Treat `AGENTS.md` as a README-like file for coding agents, with setup/workflow, code/project conventions, constraints, and done/verification rules.
   - Acceptance test: `AGENTS.md` includes active root, archive boundary, mandatory read list, patch rules, safety boundaries, evidence honesty, and output rules.
   - Falsifier: instructions are vague enough that an agent can bypass office/roadmap/blueprint/MT5 owner files.

3. Git commit-message requirement:
   - Keep a clear summary/header and a detailed body explaining what changed and why.
   - Acceptance test: `roadmap/ARL_GIT_SUMMARY_DESCRIPTION_STANDARD.md` defines Git Summary and Git Description sections.
   - Falsifier: commits use a tiny vague subject or paste the full ChatGPT final answer into the message.

4. Documentation architecture requirement:
   - Add a Work Area index, mandatory-read index, roadmap-level agent guide, prompt-master checklist, output reference index, and MT5 implementation guide so agents do not have to infer folder authority.
   - Acceptance test: each created guide maps owner files and says what cannot be claimed or changed.
   - Falsifier: future prompt says only “continue work” or allows “inspect repo and decide” without a mandatory read list.

Proof boundary:
Research informs guide constraints only. It does not prove MT5 compile, runtime behavior, trading edge, execution safety, or prop-firm readiness.


---

## 2026-05-06 — ARL-RUN009 Mandatory External Research

Research was performed before patching and converted into implementation constraints, tests, and falsifiers. Primary/official MQL5 sources were used first.

| Topic | Source | ARL coding constraint | File affected | Acceptance test | Falsifier |
|---|---|---|---|---|---|
| Timer queue / `EventSetTimer` | MQL5 EventSetTimer / OnTimer docs | One timer per program; timer events do not stack while a timer event is queued/processing; `OnTimer` must stay bounded. | `mt5/ARL_Core.mq5`, `runtime/ARL_Heartbeat.mqh`, `runtime/ARL_Scheduler.mqh`, `telemetry/ARL_StatusWriter.mqh` | `OnTimer()` calls only heartbeat, scheduler/status publication, and metrics. | Symbol loops, scans, ranking, dossier writing, or blocking work inside `OnTimer`. |
| File sandbox / `FILE_COMMON` | MQL5 FileOpen docs | Public runtime output must use relative sandbox paths; `FILE_COMMON` publishes to common terminal files; no absolute path ownership. | `io/ARL_Paths.mqh`, `io/ARL_FilePublisher.mqh` | Paths are relative under `Aurora Reforged Lattice\Default\Current`. | Absolute terminal/user path hard-coded as current output route. |
| Flush/close/readback | MQL5 FileFlush / FileClose / FileReadString / FileSize docs | Write temp, flush/close, read back, compare payload, then promote. | `io/ARL_FilePublisher.mqh` | No success status without temp and final readback match. | File presence or temp existence treated as current proof. |
| Promote semantics | MQL5 FileMove docs | Promotion may use `FileMove(..., FILE_COMMON|FILE_REWRITE)` inside sandbox; do not claim OS-level crash-proof atomicity. | `io/ARL_FilePublisher.mqh`, report | Report states staged-write/readback/promote limitation honestly. | Report claims full OS-level atomic proof from MQL5 docs alone. |
| Error handling | MQL5 GetLastError / ResetLastError docs | Reset before critical file/timer calls and report `GetLastError()` on failure; `GetLastError()` does not reset itself. | `io/ARL_FilePublisher.mqh`, `telemetry/ARL_ErrorLedger.mqh`, `ARL_Core.mq5` | Failure result includes last error where available. | Error path returns success or drops last error. |
| Program properties | MQL5 #property docs | `#property version` and `description` must be in main `.mq5`; included file constants do not control EA property display. | `mt5/ARL_Core.mq5`, `core/ARL_Version.mqh` | `#property version` equals `ARL_PRODUCT_VERSION`. | Version truth only changed in included `.mqh`. |
| Structured commit messages | GitHub docs / conventional structured practice | Use a short searchable summary plus deep structured body; do not paste chat transcript. | Git summary/report records | Commit description includes mode, summary, why, changed files, evidence, risks, next. | Vague commit message or full chat transcript pasted as Git body. |
| Observability metrics | Reliability practice | Status must expose latency/work metrics, write status, errors, and permission boundaries. | `telemetry/ARL_RuntimeMetrics.mqh`, `telemetry/ARL_StatusWriter.mqh` | Status contains heartbeat, scheduler tick count, last/max cycle ms, publication results, permission false fields. | Status says healthy without write/readback/error visibility. |

### Prompt-master research improvement note

Future prompt-master runs must force research to become engineering law, not a bibliography. Each source must produce exactly four usable outputs: coding constraint, affected owner file, acceptance test, and falsifier. If a finding cannot change code, tests, logs, boundaries, or a decision, it is ornamental and should be deleted or moved to background context.

Future chats should also separate:
1. official/primary source facts;
2. engineering inference from those facts;
3. ARL-specific coding decision;
4. proof boundary still missing.

For runtime/file-IO work, future research must explicitly check version-specific MQL5 function signatures before patching. This prevents “research-looking” answers that still produce compile-risk code.
