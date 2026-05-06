# MT5 Version Policy

ARL uses `core/ARL_Version.mqh` for current product identity only.

It may expose:
- product name
- semantic version
- ARL run id
- build channel
- build date
- source state
- git commit hint

It must not become a changelog.

## Where change history belongs

- `office/ARL_CHANGE_LEDGER.md`
- `office/ARL_DECISIONS.md`
- Git commit history
- GitHub compare/diff view
- release notes if needed later

## Commit-message recommendation

Use compact, searchable commit subjects:

```text
ARL-RUN004: add MT5 source scaffold
ARL-RUN005: align Work Area version identity and source records
ARL-RUN006: add runtime heartbeat/status writer
```

Keep each commit body structured:

```text
Mode:
Scope:
Changed:
Forbidden:
Tests:
Evidence:
Next:
```

This avoids ASC-style sloppy change history without pushing a changelog into MT5 source.

## ARL-RUN007 Version Decision

Product version remains `1.004`.

Reason: RUN007 aligns source identity, office records, roadmap rules, blueprint references, and trader-data reference law. It does not add runtime behavior, trading logic, signals, execution, HUD, strategy formulas, file publication, or direct ASC archive migration.

MT5 identity fields are allowed to record `ARL-RUN007` as the current source-record alignment run while the product version remains `1.004`. A future run must bump to `1.005` or the next correct `a.bcd` value only when active MT5 behavior changes.

Acceptance:
- `ARL_Core.mq5` `#property version` equals `1.004`.
- `ARL_PRODUCT_VERSION` equals `1.004`.
- `ARL_PRODUCT_RUN_ID` equals `ARL-RUN007`.
- Git/office own change history; MT5 source does not become a changelog.


---

## ARL-RUN009 Version Decision

Product version advances from `1.004` to `1.005`.

Reason:
RUN009 implements active MT5 runtime behavior: heartbeat state, bounded scheduler ticks, status publication, manifest publication, staged file writing, readback validation, no-change skip support, and runtime metrics.

Required identity fields:
- `#property version` = `1.005`
- EA description includes `Version 1.005 | ARL-RUN009 | runtime IO foundation`
- `ARL_PRODUCT_VERSION` = `1.005`
- `ARL_PRODUCT_RUN_ID` = `ARL-RUN009`
- `ARL_PRODUCT_CHANNEL` = `RUNTIME_IO_FOUNDATION`
- `ARL_PRODUCT_STATE` = `RUNTIME_IO_FOUNDATION_NO_TRADING`

Proof boundary:
Version advancement records behavior implementation. It does not prove compile success, runtime publication success, trading safety, signal validity, edge, or prop-firm readiness.
