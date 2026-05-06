# ARL Migration Sequence

## Root law

Archives are inheritance evidence only.

Nothing from `Archives/` or old ASC becomes active ARL source unless a migration run promotes a specific item.

## Migration classes

| Class | Meaning | Action |
|---|---|---|
| KEEP_AS_HISTORY | old reports/run logs | never migrate directly |
| MINE_FOR_CONTRACTS | useful doctrine/architecture | rewrite into ARL contract |
| MINE_FOR_TESTS | old failure mode | convert into acceptance/regression test |
| MIGRATION_CANDIDATE | useful code/schema | inspect in dedicated migration run |
| REJECT_OR_DEFER | stale/ornamental/duplicate | do not carry forward |
| UNKNOWN | not inspected | no authority |

## Migration workflow

```text
1. Identify candidate.
2. Inspect source/report directly.
3. Identify what failure or capability it relates to.
4. Decide whether ARL needs it.
5. Rewrite smaller if needed.
6. Add tests before or with implementation.
7. Log in office/ARL_MIGRATION_REGISTER.md.
8. Never copy broad files blindly.
```

## ASC examples to mine carefully

Useful DNA:
- atomic publication temp/readback/promote/no-change
- Market Board ranking split
- Dossier numeric score stack
- L3/L4 source ownership warnings
- permission boundary language
- account/exposure awareness

Dangerous inheritance:
- giant dispatcher
- HUD early
- repeated diagnostics
- route shadowing
- placeholder/unavailable spam
- source/run identity drift
- board-child snapshot mismatch

## ISS-X DeepSpec

Treat as a migration candidate for broker/symbol specification harvesting only.

Do not import until:
- compile compatibility checked
- runtime cost checked
- JSON schema checked
- no trading side effect verified
- output ownership mapped to Layer 2
