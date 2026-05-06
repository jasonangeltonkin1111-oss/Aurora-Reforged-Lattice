# ARL Acceptance Tests

## Purpose

This file defines tests required before module locks.

## Global forbidden claims

No run may claim:
- live trading readiness
- strategy edge
- prop-firm safety
- execution safety
- compile proof
- runtime proof

unless the evidence exists.

## Global required checks

Every source run must check:
- No HUD unless explicitly scoped later.
- No trading/execution/entry/stop/target logic.
- No copied ASC source without migration record.
- No new alternate routes.
- Office files updated.
- Change ledger updated.

---

## TEST-001 — Atomic status publish

Scope:
Runtime / FilePublisher.

Pass condition:
- Writes temp file.
- Validates temp.
- Promotes to current.
- Manifest records success.
- Current file remains intact if temp validation fails.

Falsifier:
Partial temp content appears in current output.

---

## TEST-002 — Warmup completion gate

Scope:
Warmup / Scheduler.

Pass condition:
READY requires:
- account ready
- universe ready
- market state classified
- specs classified
- L3 complete
- L4 complete
- board atomic publish success

Falsifier:
READY with L3 or L4 incomplete.

---

## TEST-003 — L3 snapshot commit

Scope:
Surface Ranking.

Pass condition:
L3 current promotes only complete snapshot with:
- snapshot_id
- scoring_version
- processed_count
- eligible_count
- required numeric fields
- exact broker symbols

Falsifier:
Layer 4 consumes L3 staging/in-progress file.

---

## TEST-004 — L4 snapshot commit

Scope:
Bucket Ranking.

Pass condition:
L4 current promotes only if:
- consumes committed L3 snapshot
- Global Top 10 complete or insufficient population stated
- Top 5 per major bucket complete or available_count_below_target
- Top 5 per minor bucket complete or available_count_below_target
- active_l4_set deduped

Falsifier:
Major/minor bucket output uses forex-pair major/minor meaning instead of hierarchy.

---

## TEST-005 — Ready cadence

Scope:
Scheduler.

Pass condition:
After READY:
- L3 every 20 minutes
- L4 every 20 minutes, 5 minute offset
- L2 every 1 minute for active L4 set
- L5 every 5 minutes for active L4 set

Falsifier:
L5 runs full universe by default.

---

## TEST-006 — Market State retry law

Scope:
Market State.

Pass condition:
- Confirmed open stops open/closed retries.
- Confirmed closed schedules next open if known.
- Unknown uses bounded backoff.
- Retry exhaustion marks degraded, not fake closed/open.

Falsifier:
Confirmed open symbol remains in retry queue.

---

## TEST-007 — Account exposure requirement

Scope:
Account / Market Board.

Pass condition:
Board READY requires account snapshot or explicit account_unavailable status.
Open positions and pending orders counted separately.
Exposure affects upload suggestion.

Falsifier:
Upload suggestion ignores open/pending conflict.

---

## TEST-008 — Indicator readiness

Scope:
Indicators / ATR.

Pass condition:
- handle created once
- CopyBuffer partial/-1 becomes BUILDING/PARTIAL/FAILED
- no fake ATR zero with READY
- handle released on deinit

Falsifier:
ATR=0 with READY after failed CopyBuffer.

---

## TEST-009 — Numeric-first output

Scope:
Market Board / Dossier.

Pass condition:
Every qualitative label has numeric value or is optional display-only.
Scores show timeframe/source/freshness where relevant.

Falsifier:
"Strong" or "Expanding" appears alone with no score.

---

## TEST-010 — Dossier missingness cleanup

Scope:
Dossier.

Pass condition:
Required missing fields visible.
Optional missing fields summarized.
Irrelevant missing fields hidden from operator view and available only in debug JSON.

Falsifier:
FX dossier degraded because ISIN/country missing.

---

## TEST-011 — No route bypass repair

Scope:
All patches.

Pass condition:
Fix modifies owner file/module.

Falsifier:
Patch creates new parallel writer or output to bypass owner defect without approved route-change record.

---

## TEST-012 — Lock qualification

Scope:
All modules.

Pass condition:
Module can be locked only after:
- compile pass if source exists
- output contract pass
- runtime smoke pass where applicable
- no protected-route mutation
- no trade permission leak
- lock file created

Falsifier:
Module marked done without lock file or test evidence.

---

## TEST-006 — Version identity parity

Scope:
MT5 source identity and office records.

Pass condition:
- `mt5/ARL_Core.mq5` `#property version` matches `mt5/core/ARL_Version.mqh` `ARL_PRODUCT_VERSION`.
- EA description uses the same version string.
- MT5 README uses the same version string.
- Office ledger records whether the run was a behavior bump or maintenance alignment.

Falsifier:
Any active identity file reports a different current version.

---

## TEST-007 — No-trade / no-HUD scaffold preservation

Scope:
Whole Work Area package.

Pass condition:
- No HUD module is added.
- No trade, signal, execution, stop, target, lot, order-send, or prop-firm permission path is added.
- `InpARL_AllowTrading` remains false by default and startup rejects true in scaffold mode.

Falsifier:
A source grep finds trading/execution/HUD behavior outside explicit no-permission boundary text.

---

## TEST-008 — Research proof honesty

Scope:
Run reports and office research ledger.

Pass condition:
- If live web research is unavailable, the run says so.
- No uncited internet claim is treated as fresh evidence.
- Future research-capable runs cite official/primary sources and convert findings into constraints/tests/falsifiers.

Falsifier:
Report says external research was completed when no live source access existed.

## ARL-RUN007 Acceptance Addendum

Minimum acceptance before first real implementation run:

1. `Work Area/` is the only active uploaded source root.
2. Uploaded package excludes `Archives/`.
3. Git current Work Area state is checked after research.
4. RUN006 trader-data reference files are confirmed present or absence is logged.
5. `ARL_Core.mq5` version and `ARL_Version.mqh` version agree.
6. Product version decision is recorded in MT5 policy and office decisions.
7. Git summary/description standard is documented.
8. Trader-data-first law is referenced by office, roadmap, and blueprint.
9. MT5 remains no-HUD/no-trade/no-signal/no-execution.
10. Include scan finds no missing includes.
11. Duplicate-function scan finds no duplicate active function definitions.
12. No cosmetic module risk is left unreported.
13. Compile is reported only if MetaEditor output exists.
14. Output package excludes Archives.
15. `Work Area/ARL_RUN007_REPORT.md` exists.
