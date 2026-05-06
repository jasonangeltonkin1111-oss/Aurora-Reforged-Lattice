# AURORA RUN SHEET TEMPLATE

Use this small sheet to replace bloated prompts. Fill only what matters.

## Header

- Run: `RUN###R`
- Mode: `AUDIT / DEBUG / PATCH / PROMPT BUILD / ROADMAP REVISION / EDGE VALIDATION / LIVE EVIDENCE REVIEW`
- Source baseline: `<package/Git/current source>`
- Report: `RUN###R_REPORT.md`
- Package: `TRUTH_SEEKER_RUN###R.zip`
- Final decision options: `<TEST FIRST / HOLD / KILL / PROCEED if explicitly allowed>`

## Active modules

| Module | Active? | Why | Patch allowed? |
|---|---:|---|---:|
| M0_CORE_TRUTH | yes | evidence discipline | no |
| M1_SOURCE_BASELINE |  |  |  |
| M2_RESEARCH_ROUTER |  |  |  |
| M3_EVIDENCE_QUARANTINE |  |  |  |
| M4_COMPILE_RISK_SNIFFER |  |  |  |
| M5_REFRESH_ENGINE |  |  |  |
| M6_PUBLICATION_FILEIO |  |  |  |
| M7_FAMILY_TRUTH_TRANSPORT |  |  |  |
| M8_DATA_HYDRATION_STATUS |  |  |  |
| M9_SIAM_REVIEW_SELECTOR |  |  |  |
| M10_L3_L4_BOUNDARY |  |  |  |
| M11_PERMISSION_SAFETY | yes | leak scan | scoped only |
| M12_LIVE_COMPILE_PROOF |  |  |  |
| M13_PROMPT_SYSTEM |  |  |  |
| M14_ROADMAP_CONTROL |  |  |  |
| M15_EDGE_VALIDATION |  |  |  |
| M16_PACKAGE_REPORT | yes | report/package | yes |

## Allowed patch surface

- `<file/path>` — `<allowed change>`

## Forbidden patch surface

- No formula/rank/order/membership drift.
- No FileIO mutation unless explicitly scoped.
- No HUD/strategy/signal/execution/risk/trade permission change unless explicitly scoped.
- No generated runtime output edit/package.
- No broad rewrites.

## Acceptance

- `<measurable condition>`

## Falsifiers

- `<condition that fails the run>`

## Static validation

- file existence/identity check;
- changed-file diff;
- forbidden-token scan;
- package contents check;
- compile/live only if scoped.

## Next run seed

`RUN###R / <scope> — <boundaries>`
