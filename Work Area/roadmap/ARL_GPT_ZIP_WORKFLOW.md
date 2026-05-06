# ARL GPT Zip Workflow

This file defines how GPT must work after Codex creates the MT5 scaffold.

## Required workflow

```text
1. User uploads latest source zip.
2. GPT extracts and audits the zip.
3. GPT identifies active source owner files.
4. GPT performs mandatory deep research.
5. GPT separately audits Git/current repo state when available.
6. GPT compares:
   - uploaded zip
   - Git state
   - office records
   - roadmap
   - blueprint
   - Archives evidence
7. GPT logs contradictions.
8. GPT patches only the owner files.
9. GPT performs debug/static checks.
10. GPT compile-checks when source changed and compile environment is available.
11. GPT creates a zip preserving folder layout.
12. GPT reports changed files and evidence rank.
```

## Why this order exists

The old system drifted because prompts sometimes jumped straight from idea to patch.

ARL must never patch before:
- current source is inspected
- research is done
- Git/source state is compared
- owner files are known

## Contradiction handling

If uploaded zip and Git disagree:

```text
active uploaded zip = working source for this repair pass
Git = external reference unless user says Git is source baseline
office ledger must record the mismatch
```

If roadmap and source disagree:

```text
source outranks roadmap
roadmap must be updated or marked stale
```

If archive and source disagree:

```text
active source outranks archive
archive is evidence only
```

## Patch rule

Fix the original owner.

Do not create:
- bypass writer
- duplicate route
- shadow module
- new path because old one is broken
- parallel truth lane

## Packaging rule

Return changed files in a zip preserving repo folder layout.

Do not flatten files.

---

## RUN005 Workflow Patch — Work Area and Archives

`Work Area/` is the active uploadable root. Uploaded zips should not contain `Archives/`.

Archives are Git-only inheritance evidence and may be mined only for:
- owner maps
- known failure modes
- useful output structures
- migration candidates
- test cases

Archives must not be copied directly into active Work Area source.

If web browsing is unavailable, GPT must say research is blocked and continue only with evidence it actually has.
