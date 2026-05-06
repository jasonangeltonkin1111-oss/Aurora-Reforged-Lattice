# ARL Immediate Build Plan

## Purpose

This file defines the next build slice after this office pack.

## Next recommended Codex run

Run name:
ARL-RUN002 — Source Scaffold Only

Mode:
PROMPT BUILD / PATCH SCAFFOLD

Allowed:
- Create folder layout.
- Create minimal header files.
- Create contract placeholders.
- Create no-op safe structs/enums where useful.
- Create tests folder placeholders.
- Create locks folder.

Forbidden:
- No HUD.
- No EA trading.
- No execution.
- No entry/stop/target.
- No full formulas.
- No copied ASC source.
- No route rewrites.
- No alternate writers.
- No runtime file output until runtime proof run.
- No private account data in repo.

## Target scaffold

```text
mt5/
  ARL_Core.mq5
  core/
  runtime/
  io/
  telemetry/
  account/
  layer1_market_state/
  layer2_symbol_specs/
  layer3_surface_rank/
  layer4_group_rank/
  layer5_deep_review/
  indicators/
  dossiers/
  permission/
tests/
  static/
  compile/
  runtime/
  output_contracts/
locks/
```

## Required office update after Codex run

Codex must update:
- `office/ARL_CHANGE_LEDGER.md`
- `office/ARL_DECISIONS.md` if scope changes
- `office/ARL_RISK_LEDGER.md` if new risks are found
- `office/ARL_ACCEPTANCE_TESTS.md` if tests change

## Acceptance for ARL-RUN002

- Folder structure exists.
- No HUD folder.
- No trading/execution files.
- No old ASC source copied directly.
- No compile/live proof claimed.
- Office files read and referenced in report.
- Change ledger updated.

---

## ARL-RUN005 Build Plan Addendum — Foundation Alignment

Purpose:
Align Work Area source identity and process records after the MT5 scaffold compiled externally.

Allowed:
- Fix version identity drift.
- Tighten office/Git ownership of change history.
- Tighten no-HUD/no-trade boundaries.
- Tighten acceptance tests.

Forbidden:
- HUD.
- Trading.
- Signals.
- Execution.
- Strategy formulas.
- Runtime publication implementation.
- Direct ASC source copy.

Version impact:
Keep EA product version at `1.004` because this run is maintenance/source-record alignment only.

Next implementation lane:
After compile confirmation, implement the smallest runtime proof slice: heartbeat/status file publication with atomic write/readback, still no trading and no HUD.

## ARL-RUN007 Build Plan Addendum — Pre-Work Unification

Objective: make the current Work Area coherent before behavior implementation begins.

Order:
1. audit uploaded Work Area zip first;
2. research official/primary sources and convert findings into constraints/tests/falsifiers;
3. re-audit against research constraints;
4. compare Git Work Area state after research;
5. inspect Archives only as Git inheritance evidence when needed;
6. patch owner files only;
7. run static include and duplicate-function checks;
8. compile only if MetaEditor is available;
9. package changed/additional Work Area files, excluding Archives.

This run must not add trading, signals, execution, HUD, strategy formulas, or direct ASC archive migration.
