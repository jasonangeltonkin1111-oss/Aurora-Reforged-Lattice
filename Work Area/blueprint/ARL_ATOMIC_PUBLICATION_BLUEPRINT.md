---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Atomic Publication Blueprint

Every public artifact must be written through one publication owner.

## Public Artifacts

- `Status_Current.json`
- `Account_Current.json`
- `MarketBoard_Current.txt`
- `MarketBoard_Current.json`
- `L3_SurfaceRank_Current.json`
- `L4_GroupRank_Current.json`
- `Symbol_Current.json`
- `Dossier_Current.txt`
- `Manifest_Current.json`

## Atomic Pattern

```text
1. compose payload in memory
2. validate required fields
3. calculate payload signature/hash
4. compare with current material signature
5. if unchanged: skip write and update heartbeat/manifest status only
6. write temp file
7. flush/close temp file for public artifact
8. readback temp file
9. validate readback
10. promote temp -> current
11. update manifest
12. archive only if materially changed
```

## Publication States

```text
NOT_STARTED
STAGED
VALIDATED
UNCHANGED_SKIPPED
PROMOTED_CURRENT
READBACK_FAILED
VALIDATION_FAILED
WRITE_FAILED
PROMOTE_FAILED
RETAINED_LAST_GOOD
```

## Currentness Law

File existence is not freshness.

Non-empty file is not proof.

Last-good is not current.

Staging is not current.

Archive is not current.

Only promoted current with matching snapshot and readback can be current.

## ASC Lesson

ASC already carried temp/readback/promote/no-change/last-good concepts. ARL keeps those concepts but makes them universal, simpler, and mandatory for all public outputs.

---

## RUN005 Addendum — Publication Proof Boundary

RUN005 did not implement runtime publication.

Future atomic publication work must prove:
- temp file write
- flush or close behavior appropriate to the file contract
- readback validation
- promote/move to current
- manifest update
- no-change skip behavior
- last-good preservation on failure

No runtime publication claim is valid until logs/files show the full sequence.

## ARL-RUN007 Atomic Publication Constraint

Future file publication must stage, write, flush, verify/read back where practical, promote, and report status.

File existence alone is not proof. Manifest/readback truth must identify source file, current file, write result, flush result, move/promote result, and last error when present.
