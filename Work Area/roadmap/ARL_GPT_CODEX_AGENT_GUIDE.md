# ARL GPT / Codex Agent Guide

This roadmap-level guide defines how GPT zip-patch runs and Codex repository runs must operate.

## Serious Run Mode

Declare the primary run mode before work:

- AUDIT
- RESEARCH
- DEBUG
- PATCH
- PROMPT BUILD
- ROADMAP REVISION
- EDGE VALIDATION
- LIVE EVIDENCE REVIEW

A run may combine modes only when the scope is explicit. Do not silently change mode mid-run.

## Required Order

1. Zip/source audit.
2. Mandatory-read file pass.
3. External research when required.
4. Second audit after research.
5. Git check after zip audit and research.
6. Additive or owner-file patch.
7. Static validation.
8. Compile only when source behavior changed and MetaEditor is available.
9. Runtime only when explicitly in scope.
10. Report and package.

## GPT Zip Workflow vs Codex Workflow

| Workflow | What It Can Do | Required Guardrail |
|---|---|---|
| GPT zip patch | Inspect uploaded packages, edit files, create changed-files package, write reports. | Must audit zip before patch and preserve layout. |
| Codex repo workflow | Navigate repo, edit files, run commands/tests where available, and produce diffs/PRs. | Must read `AGENTS.md` and project owner files before editing. |

Codex can read and edit code and run checks, but it must still obey ARL source authority, no-route-drift, version, and proof rules.

## Read Before Edit

Read:

- `AGENTS.md`
- `Work Area/WORK_AREA_INDEX.md`
- `Work Area/GPT_CODEX_README.md`
- `Work Area/office/ARL_MANDATORY_READ_INDEX.md`

Then continue through the mandatory list.

## Archive Boundary

No archive upload. No direct archive copy. No inheritance without explicit research, owner-file conversion, and acceptance criteria.

## Bypass Route Ban

Do not solve bugs by adding a second route, second writer, second owner, or shadow output path. Repair the owner path.

## Compile/Test Requirements

- Documentation-only run: static validation is enough.
- MT5 source behavior changed: compile attempt required when MetaEditor is available.
- Runtime behavior changed: runtime smoke evidence required before readiness language.
- Output contract changed: sample/schema/contract validation required.

## Output Requirements

Every serious run must produce:

- report;
- changed-files zip preserving layout;
- files added/changed list;
- files inspected but not changed list when useful;
- version decision;
- compile/runtime statement;
- remaining risks;
- next strongest move.
