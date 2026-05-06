# ARL Mandatory Read Index

This is the office-controlled mandatory-read spine for serious Aurora Reforged Lattice work.

No serious GPT, Codex, or automation-agent run should patch before reading these files or explicitly reporting which required file was absent.

## Mandatory Read Order

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

## Run Intake Form

Every serious prompt/run must state:

| Field | Required Value |
|---|---|
| Run ID | Example: `ARL-RUN008` |
| Mode | Audit, Research, Debug, Patch, Prompt Build, Roadmap Revision, Edge Validation, or combined scoped mode |
| Source package | Uploaded zip or Git branch/commit being audited |
| Active root | Must identify `Work Area/` unless explicitly changing root law |
| Files to read | Must include this mandatory-read index |
| Allowed files | Exact files/folders allowed for patch |
| Forbidden files | Exact files/folders forbidden for patch |
| Research required? | Yes/no and topic list |
| Compile required? | Yes/no and why |
| Runtime required? | Yes/no and why |
| Expected package name | Exact zip name |
| Version decision rule | Bump only if source behavior changes |

## Patch Ledger Rule

Every run must update the correct ledgers:

- `office/ARL_CHANGE_LEDGER.md` for changed files;
- `office/ARL_DECISIONS.md` for decisions made or reinforced;
- `office/ARL_RESEARCH_LEDGER.md` if research was performed;
- `office/ARL_RISK_LEDGER.md` if risks were found or changed;
- acceptance tests when acceptance criteria changed.

## Acceptance Before Lock

No module can be locked until:

- source was inspected;
- compile passed if source changed;
- output contract passed if it is an output module;
- runtime smoke passed if it is a runtime module;
- no permission leak exists;
- regression risk is recorded.

## Prompt Master Rule

Every prompt must tell the downstream agent exactly what to read first. No prompt may say only “continue work.” No prompt may allow “inspect repo and decide” without this mandatory-read list.

## Git Message Rule

Every prompt must include:

- Git Summary block;
- Git Description block;
- expected version impact;
- evidence requirements.
