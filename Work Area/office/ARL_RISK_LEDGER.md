# ARL Risk Ledger

## Risk format

Each risk must include:
- Risk
- Cause
- Severity
- Likelihood
- Detection
- Mitigation
- Test / falsifier

---

## RISK-001 — Archive infection

Risk:
Old ASC/Archive files become active authority.

Cause:
Direct copying instead of mining.

Severity:
High.

Likelihood:
High if not controlled.

Detection:
Active source contains copied ASC route/dispatcher/HUD code without migration record.

Mitigation:
Archives are evidence only. Use migration register.

Test / falsifier:
Any Codex run copies old ASC files directly into active `mt5/` without migration approval.

---

## RISK-002 — Half-ready L3/L4 warmup

Risk:
System declares READY before Surface Ranking and Bucket Ranking are complete.

Cause:
Warmup publishes board before full snapshot commit.

Severity:
High.

Likelihood:
High based on ASC history.

Detection:
MarketBoard shows current while L3 or L4 snapshot status is incomplete/pending.

Mitigation:
READY requires L3_COMPLETE + L4_COMPLETE + board atomic publish.

Test / falsifier:
Force partial L3 and verify board cannot promote as READY.

---

## RISK-003 — Staging/current confusion

Risk:
Staging, retained, or pending output is read as current.

Cause:
Publication status not enforced.

Severity:
High.

Likelihood:
Medium.

Detection:
Output body exists but publish_result != promoted_current.

Mitigation:
Every public artifact must include publish_result and snapshot state.

Test / falsifier:
Temp/staging artifact appears as MarketBoard_Current.

---

## RISK-004 — Optional unavailable spam

Risk:
Dossier marks useful review as degraded because irrelevant optional metadata is absent.

Cause:
Required and optional missing fields not separated.

Severity:
Medium.

Likelihood:
High.

Detection:
FX symbol dossier degraded because ISIN/country metadata unavailable.

Mitigation:
Required/optional/irrelevant field classification.

Test / falsifier:
CADSGD-like FX dossier remains review-ready even if broker country/ISIN absent.

---

## RISK-005 — Over-refresh / retry storm

Risk:
System retries confirmed open/closed symbols unnecessarily.

Cause:
No state-specific retry scheduler.

Severity:
High.

Likelihood:
Medium.

Detection:
Retry queue grows for symbols already confirmed open or scheduled closed.

Mitigation:
Only unknown states retry. Open stops retries. Closed schedules next open.

Test / falsifier:
Confirmed open symbol remains in open/closed retry queue.

---

## RISK-006 — Indicator fake readiness

Risk:
ATR or indicator data shows zero/ready when CopyBuffer failed or is building.

Cause:
No indicator readiness status.

Severity:
High.

Likelihood:
Medium.

Detection:
ATR=0 with status READY after CopyBuffer returns -1/partial.

Mitigation:
Indicator status = READY / BUILDING / PARTIAL / FAILED.

Test / falsifier:
No fake zero readiness allowed.

---

## RISK-007 — Account exposure ignored

Risk:
Board recommends symbols already carrying exposure.

Cause:
Account module absent or optional.

Severity:
High.

Likelihood:
Medium.

Detection:
Upload suggestion includes symbol with open/pending conflict without warning/exclusion.

Mitigation:
Account snapshot mandatory before board READY.

Test / falsifier:
Board publishes BEST_3 without exposure state.

---

## RISK-008 — New route proliferation during fixes

Risk:
Fixes create bypasses and alternate paths instead of repairing owners.

Cause:
Panic repair behavior.

Severity:
High.

Likelihood:
High historically.

Detection:
New writer/path/helper created while owner module remains broken.

Mitigation:
Lock policy and no-new-route law.

Test / falsifier:
Patch creates alternate output to avoid fixing original owner.

---

## RISK-009 — Numeric labels become cosmetic

Risk:
Labels like Strong/Expanding appear without numeric backing.

Cause:
Old style carried forward.

Severity:
Medium.

Likelihood:
High.

Detection:
Operator file contains label without score/threshold/timeframe/source.

Mitigation:
Numeric-first output style.

Test / falsifier:
Any operator score label lacks numeric value.

---

## RISK-010 — Public privacy leak

Risk:
Account number, terminal path, server path, or trade history committed to Git.

Cause:
Runtime output copied into repo.

Severity:
High.

Likelihood:
Medium.

Detection:
Repo search finds unmasked account_login, terminal path, or trade tickets.

Mitigation:
Samples mask private fields. Runtime outputs stay local.

Test / falsifier:
Committed sample contains real account login.

---

## RISK-RUN005-001 — Product identity drift

Status:
Mitigated by RUN005 alignment, pending compile/runtime confirmation.

Risk:
Different files reported `1.004` and `0.0.4`, which would create false operator confidence and make Git/office/source records disagree.

Control:
`#property version`, EA description, `ARL_PRODUCT_VERSION`, MT5 README, version policy, and office ledger must be checked together on every source run.

Falsifier:
A grep over active Work Area source/docs finds stale active product version strings after the run, excluding sample numeric data such as `0.042`.

---

## RISK-RUN005-002 — Fake external research proof

Status:
Open.

Risk:
Mandatory internet research was requested, but the current chat environment did not provide live web browsing. Pretending research was performed would poison the evidence ladder.

Control:
RUN005 report must state external research was blocked and must not claim official-source proof.

Falsifier:
The report claims fresh official-source research or cites uncited web facts as if verified during the run.

## RISK-RUN007-001 — Pre-work record drift before implementation

Risk: office, roadmap, blueprint, and MT5 source can disagree before implementation starts, causing future GPT/Codex runs to build from the wrong source of truth.

Mitigation: RUN007 aligns Work Area root authority, archive policy, RUN006 trader-data reference law, Git message standard, and version identity.

Falsifier: a grep after RUN007 finds active docs that treat `Archives/` as uploadable source, hide RUN006 absence/presence, or report a product version/run identity inconsistent with `ARL_Core.mq5` and `ARL_Version.mqh`.

Decision pressure: if this risk reappears during implementation, pause and fix records before adding behavior.

## RISK-RUN007-002 — Trader data drowned by metadata

Risk: operator text files become metadata walls instead of battle-board trader data.

Mitigation: RUN006 trader-data references are now mandatory for Market Board, Symbol Trader Pack, and Dossier work.

Falsifier: text output contains verbose route/proof/debug metadata while account exposure, trade history, market state, costs, volatility, ranking context, recent bars, or recent closed trades are thin or missing.

---

## RISK-030 — Agent drift before read-before-edit spine

Risk:
Future GPT, Codex, or automation-agent runs edit from stale assumptions, skip office/roadmap/blueprint/MT5 owner files, copy from Archives, or create duplicate source routes.

Cause:
No single mandatory instruction spine was visible at repository root and Work Area root before RUN008.

Severity:
High.

Likelihood:
High without prompt enforcement.

Detection:
- Agent patches source before listing mandatory files read.
- Commit has vague summary or fake proof language.
- Work Area zip includes Archives.
- New route/writer appears instead of owner-file repair.

Mitigation:
RUN008 adds `AGENTS.md`, `WORK_AREA_INDEX.md`, `GPT_CODEX_README.md`, `office/ARL_MANDATORY_READ_INDEX.md`, roadmap agent/prompt/Git standards, blueprint output reference index, and MT5 agent implementation guide.

Test / falsifier:
A future serious run can begin without reading `AGENTS.md` and `ARL_MANDATORY_READ_INDEX.md`, or can patch MT5 behavior without reading MT5 owner/version/include files.


---

## RISK-031 — RUN009 publication can still fail without MetaEditor/runtime proof

Risk:
The staged write/readback/promote source may still have MQL5 compile or runtime edge cases that static inspection cannot prove.

Cause:
This environment did not provide MetaEditor or an attached MT5 terminal.

Severity:
High until compile and runtime proof exist.

Likelihood:
Medium.

Detection:
- MetaEditor compile errors.
- `Status_Current.json` or `Manifest_Current.json` absent after attaching EA.
- Publication result reports failed temp write, readback mismatch, or promote failure.

Mitigation:
Run MetaEditor compile first. Then attach EA in demo terminal and verify timer, status output, manifest output, final readback, and no permission leakage.

Test / falsifier:
Any compile failure, missing status/manifest file, status success without readback, or true trade/signal/execution/HUD permission invalidates RUN009 acceptance.

## RISK-032 — No-change skip cannot be proven by normal heartbeat output alone

Risk:
`Status_Current.json` includes heartbeat count and timestamps, so normal timer cycles materially change the payload and may not trigger no-change skip.

Cause:
Heartbeat/status truth fields are intentionally current and changing.

Mitigation:
Test no-change skip with a fixed payload through `ARL_FilePublisher_Publish()` or with a runtime cycle where the composed payload is intentionally unchanged.

Falsifier:
A report claims no-change skip was runtime-proven merely because status files appeared.


---

## RISK-033 — RUN010R static repair still lacks MetaEditor compile proof

Risk:
The repaired source can still fail in MetaEditor because static quote/brace checks cannot prove MQL5 compiler acceptance.

Cause:
This execution environment does not include MetaEditor or an attached MT5 terminal.

Severity:
High until compile proof exists.

Detection:
Run MetaEditor compile on `Work Area/mt5/ARL_Core.mq5` and record the exact compiler output.

Mitigation:
Treat RUN010R as source repair only. Next run must compile first before runtime smoke testing.

Falsifier:
Any claim that RUN010R compiled successfully without exact MetaEditor output.

## RISK-034 — Runtime IO source/office contradiction remains around OnTimer publication

Risk:
Office records from RUN009 describe timer-connected status/manifest publication, but active `ARL_Core.mq5` still only ticks heartbeat and scheduler in `OnTimer()` after RUN010R because this repair run did not expand runtime behavior.

Cause:
RUN010R scope was compile repair and path/string/include-property alignment, not runtime lifecycle expansion.

Severity:
Medium to high before runtime smoke.

Detection:
After compile passes, inspect or patch lifecycle wiring deliberately, then verify `Status_Current.json` and `Manifest_Current.json` from terminal runtime.

Mitigation:
Log the contradiction and do not claim runtime output readiness until lifecycle wiring and file output are proven.

Falsifier:
`Status_Current.json` / `Manifest_Current.json` are claimed as runtime outputs while `OnTimer()` does not call the status writer or another proved publication path.
