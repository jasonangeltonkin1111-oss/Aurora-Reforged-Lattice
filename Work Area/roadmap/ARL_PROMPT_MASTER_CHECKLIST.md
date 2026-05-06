# ARL Prompt Master Checklist

Use this checklist before sending any downstream GPT, Codex, or agent prompt.

## Required Prompt Header

- Run number stated.
- Mode stated.
- Source package stated.
- Active root stated as `Work Area/` unless intentionally changed.
- Expected output package name stated.
- Report path stated.

## Mandatory Read List

The prompt must tell the downstream agent to read:

1. `AGENTS.md`
2. `Work Area/WORK_AREA_INDEX.md`
3. `Work Area/GPT_CODEX_README.md`
4. `Work Area/office/ARL_MANDATORY_READ_INDEX.md`
5. The rest of the mandatory-read index in order.

No prompt may say only “continue work.” That is how drift enters.

## Mandatory Workflow Clauses

- Force zip/source audit first.
- Force research second when the run is serious or external facts matter.
- Force Git check after research, not before zip audit.
- Force Archives to remain Git-only inheritance evidence.
- Force owner-file patching.
- Force version decision.
- Force compile/static/runtime honesty.
- Force report and zip.
- Force Git Summary and Git Description output.

## Allowed / Forbidden Scope

Every prompt must list:

- allowed files/folders;
- forbidden files/folders;
- no HUD/trading/signals/execution unless explicitly authorized;
- no direct archive migration;
- no new routes unless the owner map is updated and the old route is retired.

## Evidence Requirements

The prompt must require:

- source files inspected;
- research citations in report when research is used;
- compile output only if compile was actually run;
- runtime output only if runtime was actually run;
- no live/edge/profit/prop-firm claims without evidence.

## Git Blocks

Every prompt must include these blocks:

```text
GIT SUMMARY
AURORA REFORGED LATTICE — ARL-RUN### / PRIMARY PURPOSE + SECONDARY PURPOSE
```

```text
GIT DESCRIPTION
MODE:
SUMMARY:
WHY:
WHAT CHANGED:
FILES ADDED:
FILES CHANGED:
FILES INSPECTED BUT NOT CHANGED:
BOUNDARIES:
VERSION IMPACT:
EVIDENCE:
RISKS:
NEXT:
```
