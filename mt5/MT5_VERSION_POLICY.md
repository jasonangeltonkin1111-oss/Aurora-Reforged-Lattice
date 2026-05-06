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
ARL-RUN005: add runtime heartbeat/status writer
ARL-RUN006: implement account snapshot scaffold
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
