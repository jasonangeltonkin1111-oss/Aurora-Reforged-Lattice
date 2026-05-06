# ARL Run Protocol

Every ARL run must be explicit, bounded, and evidence-ranked.

## Required run header

```text
RUN:
MODE:
SOURCE BASELINE:
SCOPE:
ALLOWED FILES:
FORBIDDEN FILES:
RESEARCH REQUIRED:
COMPILE REQUIRED:
LIVE REQUIRED:
OUTPUT:
ACCEPTANCE TESTS:
LEDGER UPDATES:
FINAL DECISION:
```

## Modes

Use exactly one primary mode:
- ROADMAP
- BLUEPRINT
- CODEX_SCAFFOLD
- AUDIT
- RESEARCH
- PATCH
- DEBUG
- COMPILE_REPAIR
- RUNTIME_PROOF
- LOCK_PASS

## Default permissions

Unless explicitly authorized:

```text
trade_permission=false
signal_permission=false
execution_permission=false
risk_permission=false
hud_permission=false
```

## Source-pass workflow for GPT

When GPT receives a source zip:

```text
1. Extract and audit uploaded zip.
2. Identify active source owners.
3. Research official/external sources.
4. Audit Git/current repo state.
5. Compare zip vs Git vs roadmap vs blueprint vs Archives.
6. Log contradictions.
7. Patch only owner files.
8. Run static/debug checks.
9. Compile check when possible/required.
10. Zip changed files with original layout.
11. Update office ledgers.
```

## Codex scaffold workflow

Codex may create:
- folder structure
- source scaffold files
- no-op compile-safe placeholders
- README/module boundary docs

Codex may not:
- implement formulas
- add trading logic
- add HUD
- copy ASC source directly
- create alternate routes
- claim compile/live proof without actual evidence

## Final decision labels

Use one:
- PROCEED
- HOLD
- KILL
- TEST FIRST

Most early ARL work defaults to `TEST FIRST`.

---

## RUN005 Protocol Patch — Research Honesty and Version Parity

If internet research is required but unavailable, the run must not pretend it was completed. It may continue only with local/source/Git analysis and must mark external research as blocked.

Every source run must run a version parity check:

```text
mt5/ARL_Core.mq5 #property version
mt5/ARL_Core.mq5 #property description version text
mt5/core/ARL_Version.mqh ARL_PRODUCT_VERSION
mt5/README.md Version
Office change ledger version impact
```

A maintenance run may keep the EA version unchanged when it does not alter active product behavior. A behavior-changing source run must explicitly decide whether the a.bcd version advances.
