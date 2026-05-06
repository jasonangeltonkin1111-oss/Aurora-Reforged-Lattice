# Aurora Reforged Lattice Agent Instructions

These instructions are for GPT, Codex, automation agents, and human operators making repository changes. They exist to prevent drift, stale-source edits, fake proof, and accidental trading-system expansion.

## Active Root

`Work Area/` is the active source root.

Treat the current uploaded `Work Area/` package as the first source to audit in a GPT zip workflow. Treat the repository `Work Area/` tree as the Git comparison source after zip audit and research.

## Archives

`Archives/` are inheritance evidence only.

- Do not include `Archives/` in Work Area zip outputs.
- Do not copy archive source directly into active ARL source.
- Read archive files from Git only when a future run explicitly authorizes inheritance research.
- Archive code cannot outrank current active `Work Area/` source.

## Mandatory Read Before Editing

Read these files in order before any serious patch:

1. `Work Area/WORK_AREA_INDEX.md`
2. `AGENTS.md`
3. `Work Area/GPT_CODEX_README.md`
4. `Work Area/office/ARL_MANDATORY_READ_INDEX.md`
5. `Work Area/office/ARL_OFFICE_INDEX.md`
6. `Work Area/office/ARL_CHANGE_LEDGER.md`
7. `Work Area/office/ARL_DECISIONS.md`
8. `Work Area/office/ARL_RESEARCH_LEDGER.md`
9. `Work Area/office/ARL_RISK_LEDGER.md`
10. `Work Area/roadmap/ARL_ROADMAP_INDEX.md`
11. `Work Area/roadmap/ARL_RUN_PROTOCOL.md`
12. `Work Area/roadmap/ARL_GPT_ZIP_WORKFLOW.md`
13. `Work Area/roadmap/ARL_NO_ROUTE_DRIFT_RULES.md`
14. `Work Area/roadmap/ARL_GPT_CODEX_AGENT_GUIDE.md`
15. `Work Area/roadmap/ARL_PROMPT_MASTER_CHECKLIST.md`
16. `Work Area/roadmap/ARL_GIT_SUMMARY_DESCRIPTION_STANDARD.md`
17. `Work Area/blueprint/ARL_BLUEPRINT_INDEX.md`
18. `Work Area/blueprint/ARL_SOURCE_TRUTH_AUTHORITY.md`
19. `Work Area/blueprint/ARL_TRADER_DATA_OUTPUT_STANDARD.md` if present
20. `Work Area/blueprint/ARL_SYMBOL_TRADER_PACK_BLUEPRINT.md` if present
21. `Work Area/blueprint/ARL_OUTPUT_REFERENCE_INDEX.md`
22. `Work Area/mt5/MT5_MODULE_OWNERSHIP.md`
23. `Work Area/mt5/MT5_VERSION_POLICY.md`
24. `Work Area/mt5/MT5_INCLUDE_BOUNDARY_PLAN.md`
25. `Work Area/mt5/MT5_AGENT_IMPLEMENTATION_GUIDE.md`

If any file is absent, log it in the run report and continue with the nearest available owner. Do not invent that it was read.

## Audit First Always

No patching before source audit.

A serious run must first confirm:

- active root is `Work Area/`;
- `Archives/` are not inside the uploaded Work Area zip;
- office, roadmap, blueprint, and mt5 folders exist;
- RUN006 trader-data reference files exist or are explicitly missing;
- RUN007 unification records exist or are explicitly missing;
- product version identity is checked;
- existing guide/index files are inventoried;
- stale references, duplicate guidance, contradictions, and missing mandatory-read files are logged.

## Research Required

Research is mandatory for serious code, MT5, architecture, runtime, file I/O, account, indicator, ranking, output, Git process, or agent workflow changes.

Research must become concrete requirements:

- guide requirement;
- file to create or update;
- acceptance test;
- falsifier.

No ornamental research. If research does not change a rule, test, or safety boundary, it does not belong in the run.

## Git Check Timing

Git check comes after zip audit and research.

When Git conflicts with the uploaded zip, log a contradiction. Do not silently resolve it. Current active source inspection outranks old reports, memory, and prior chat summaries. Compile/runtime evidence outranks planning prose.

## Patch Rules

Patch owner files only.

- No duplicate routes.
- No bypass writers.
- No cosmetic modules.
- No broad rewrites when a link/addendum is enough.
- Preserve folder layout.
- Package changed Work Area files only unless a full package is explicitly justified.

## Safety Boundaries

Unless a future run explicitly authorizes a later phase, do not add:

- HUD;
- trading;
- signals;
- execution;
- strategy formulas;
- prop-firm readiness claims;
- direct ASC/archive migration.

## Version Law

ARL uses `a.bcd` product versioning.

Align these if product behavior changes:

- `Work Area/mt5/ARL_Core.mq5`;
- `Work Area/mt5/core/ARL_Version.mqh`;
- `Work Area/mt5/MT5_VERSION_POLICY.md`;
- office records;
- roadmap records;
- run report.

Documentation-only guide/index runs do not bump product version.

## Evidence Honesty

- Compile proof requires actual compile output.
- Runtime proof requires runtime logs/output.
- Live proof requires live evidence.
- Backtest proof is not live proof.
- A report is evidence of a report, not proof that runtime state is true.
- If compile was not run, say compile was not run.
- If runtime was not tested, say runtime was not tested.

## Git Summary and Description

Use a proper Git summary header and a deep structured Git description.

Do not paste entire ChatGPT final answers into commit messages. Do not include sandbox links or citations in commit messages.

## Output

Every serious run outputs:

- run report;
- changed-files package preserving layout;
- change ledger update;
- decision update when a decision was made;
- research ledger update when research was performed;
- risk ledger update when risks were found or changed.

Exclude binaries and Archives unless a future task explicitly authorizes otherwise.

## RUN006 Trader-Data Law

RUN006 trader-data references must be read before output work. Operator-facing output must prioritize trader-useful truth first. Metadata belongs in JSON/manifest/debug records, not in the top of human trader text unless it directly affects the trading decision.
