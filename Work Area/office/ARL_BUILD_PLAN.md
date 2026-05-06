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
