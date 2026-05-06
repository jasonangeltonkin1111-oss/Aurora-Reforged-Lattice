# ARL Work Area Index

`Work Area/` is the active source root for Aurora Reforged Lattice.

This index is the first Work Area file future GPT, Codex, and automation agents should read. It maps the active root and points each run toward the correct owner files before editing.

## Folder Authority Map

| Folder | Role | Authority Boundary |
|---|---|---|
| `office/` | Records, ledgers, decisions, risks, acceptance history, and change history. | Owns run records and governance. Does not prove runtime behavior. |
| `roadmap/` | How ARL is built, phased, tested, prompted, and locked. | Owns build sequence and run workflow. Does not outrank active source. |
| `blueprint/` | Final product specification, output contracts, trader-data standards, sample references, and source-truth maps. | Owns intended behavior. Does not prove implementation. |
| `mt5/` | Active MT5/MQL5 scaffold and future source implementation. | Owns active source behavior. Must be compile-tested when source behavior changes. |
| `reports/` | Historical run reports when stored under reports. | Evidence of prior work only. Does not outrank current source. |

## Archives

`Archives/` must not be inside Work Area zip outputs.

Archives are Git-only inheritance evidence. They may inform future migration only when explicitly authorized, audited, and converted through owner files. No direct archive copy is allowed.

## Mandatory Read Order

Read `office/ARL_MANDATORY_READ_INDEX.md` for the current mandatory list.

Minimum serious-run path:

1. `Work Area/WORK_AREA_INDEX.md`
2. `AGENTS.md`
3. `Work Area/GPT_CODEX_README.md`
4. `Work Area/office/ARL_MANDATORY_READ_INDEX.md`
5. Office ledgers
6. Roadmap workflow files
7. Blueprint authority/output files
8. MT5 ownership/version/include files

## Source Authority Ladder

1. Current active Work Area source files.
2. Static/compile output produced against current source.
3. Runtime logs/output produced from current source.
4. Office ledgers and decisions.
5. Roadmap build instructions.
6. Blueprint final-product specifications.
7. Git history and Archives as evidence.
8. Memory, prior chat summaries, screenshots, and reports unless independently verified.

A contradiction affecting source truth, compile path, runtime behavior, file I/O, output truth, version identity, or trading permission must pause approval until resolved.

## Output Packaging Law

Package changed/added Work Area files only, plus root-level control files such as `AGENTS.md` when they changed. Preserve folder layout. Exclude Archives and binaries unless explicitly justified.
