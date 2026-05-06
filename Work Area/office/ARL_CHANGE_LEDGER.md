# ARL Change Ledger

## Change format

Each change must include:
- Date
- Run
- Files changed
- Change type
- Reason
- Risks
- Tests required
- Lock impact

---

## 2026-05-06 — ARL-RUN001 Office Pack Created

Run:
ARL-RUN001-OFFICE-PACK

Files created:
- README.md
- ARL_OFFICE_INDEX.md
- ARL_DECISIONS.md
- ARL_CHANGE_LEDGER.md
- ARL_ROADMAP.md
- ARL_BUILD_PLAN.md
- ARL_REFRESH_TIMING_MODEL.md
- ARL_ATOMIC_PUBLICATION_MODEL.md
- ARL_ACCOUNT_EXPOSURE_REQUIREMENTS.md
- ARL_RESEARCH_LEDGER.md
- ARL_MIGRATION_REGISTER.md
- ARL_RISK_LEDGER.md
- ARL_ACCEPTANCE_TESTS.md
- ARL_LOCK_POLICY.md
- ARL_OUTPUT_SCAFFOLD_SAMPLES.md
- ARL_OPEN_QUESTIONS.md

Change type:
Planning / office foundation.

Reason:
User requested a downloadable office file set to keep roadmap and change records before Codex begins scaffold work.

Risks:
- Office prose may become stale if not updated.
- Too many office files can become bureaucracy if not enforced.
- Future agents may skip mandatory reads.

Tests required:
- Confirm files are added to Git.
- Future prompt must require reading office files first.
- First Codex scaffold run must update CHANGE_LEDGER and DECISIONS if it changes scope.

Lock impact:
No source locks created yet.

---

## 2026-05-06 — ARL-RUN005 Work Area Foundation Alignment

Run:
ARL-RUN005-WORK-AREA-FOUNDATION-ALIGNMENT

Files changed:
- mt5/ARL_Core.mq5
- mt5/core/ARL_Version.mqh
- mt5/README.md
- mt5/MT5_VERSION_POLICY.md
- office/ARL_CHANGE_LEDGER.md
- office/ARL_DECISIONS.md
- office/ARL_RESEARCH_LEDGER.md
- office/ARL_RISK_LEDGER.md
- office/ARL_ACCEPTANCE_TESTS.md
- office/ARL_BUILD_PLAN.md
- office/ARL_OPEN_QUESTIONS.md
- roadmap/ARL_RUN_PROTOCOL.md
- roadmap/ARL_GPT_ZIP_WORKFLOW.md
- roadmap/ARL_TESTING_STRATEGY.md
- roadmap/ARL_CODEX_PROMPT_RULES.md
- blueprint/ARL_SOURCE_TRUTH_AUTHORITY.md
- blueprint/ARL_ATOMIC_PUBLICATION_BLUEPRINT.md
- blueprint/ARL_RETRY_AND_SCHEDULING_BLUEPRINT.md
- ARL_RUN005_REPORT.md

Change type:
Maintenance / source-truth alignment / documentation hardening.

Reason:
The uploaded Work Area zip had compiled scaffold evidence from the user, but product identity was internally inconsistent: `ARL_Core.mq5` declared `#property version "1.004"` while `core/ARL_Version.mqh`, the EA description, and MT5 README still reported `0.0.4`. That is a source-of-truth failure even before runtime logic exists.

Risks:
- Live internet research was requested but unavailable in this chat environment, so official-source research could not be freshly verified here.
- MetaEditor compile was not available in this environment, so compile proof was not upgraded.
- `ARL_Core.ex5` was present in the upload but was not modified; binary compile state cannot be verified here.

Tests required:
- Open `Work Area/mt5/ARL_Core.mq5` in MetaEditor and compile.
- Confirm EA properties show `#property version` as `1.004`.
- Confirm startup print from `ARL_VersionLine()` reports `1.004`.
- Confirm no HUD/trading/signal/execution/risk permission was added.
- Confirm output zip excludes Archives.

Lock impact:
No module lock created. This run aligns source identity and process records only.

## 2026-05-06 — ARL-RUN007 Pre-Work Unification Alignment

Run id: `ARL-RUN007-PRE-WORK-UNIFICATION-ALIGNMENT`.

Purpose: unify Work Area source records before implementation starts.

Changed/added records:
- aligned MT5 product run identity to `ARL-RUN007` while keeping product version `1.004`;
- recorded Git summary/description standard with proper header plus deep structured description;
- confirmed RUN006 trader-data reference files are present in the uploaded Work Area package;
- strengthened trader-data-first law across office, roadmap, and blueprint references;
- recorded archive policy: `Archives/` are Git-only inheritance evidence and must not be included in uploaded Work Area zips;
- added RUN007 report and run plan.

Version impact: `1.004` retained because no runtime behavior, trading, signal, execution, HUD, or strategy formulas were added.

Proof boundary: static include scan and duplicate-function scan may be recorded by this run. No compile proof exists unless MetaEditor compile output is supplied.
