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
