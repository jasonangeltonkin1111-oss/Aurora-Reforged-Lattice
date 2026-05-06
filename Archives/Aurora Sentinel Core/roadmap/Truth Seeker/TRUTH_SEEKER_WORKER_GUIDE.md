# Truth Seeker Worker Guide

**Created:** 2026-04-26  
**Updated:** 2026-04-27  
**Purpose:** Exact guide for future GPT/worker chats so the roadmap is followed without regression.

## Reading Order

Every worker run must read in this order:

1. `TRUTH_SEEKER_LAWS.md`
2. `TRUTH_SEEKER_PHASE_INDEX.md`
3. Active phase in `TRUTH_SEEKER_ROADMAP.md`
4. `TRUTH_SEEKER_RUN_TEMPLATE.md`
5. `TRUTH_SEEKER_ACCEPTANCE_STANDARD.md`
6. `TRUTH_SEEKER_RISK_REGISTER.md`
7. `TRUTH_SEEKER_RESEARCH_APPENDIX.md`
8. `TRUTH_SEEKER_SOURCE_LIBRARY_INDEX.md` when strategy/book/AI/research work is relevant

9. `TRUTH_SEEKER_STRATEGY_CARD_SCHEMA.md` when labels/methods are relevant
10. `TRUTH_SEEKER_BOOK_TO_AURORA_CROSSWALK.md` when source concepts are relevant
11. `TRUTH_SEEKER_METHOD_EXTRACTION_LEDGER.md` when method status is relevant
12. `TRUTH_SEEKER_AI_RESEARCH_CORPUS_RULES.md` when AI/dataset work is relevant
13. This file
14. Current root/control/source files named by the phase
15. Current runtime/output/screenshot evidence if provided

Do not skip ahead. Do not rely on memory as authority.

## Progress Reporting Semantics

Every worker report must separate the full roadmap from the current phase or lane. A high current-lane percentage is not full Truth Seeker roadmap completion.

Mandatory block for every future run:

```text
FULL TRUTH SEEKER ROADMAP PROGRESS:
<conservative percent or stage>

CURRENT PHASE / LANE PROGRESS:
<lane-specific percent and proof basis>

LIVE PROOF STATUS:
<compile/live/runtime/output proof state>

NEXT LIVE CHECKPOINT:
<run number>
```

Locked interpretation after RUN048:

- Full Truth Seeker roadmap progress is approximately 12–18% complete / conservative early-stage.
- Current foundation/proof-contract lane progress is approximately 90% source-supported before RUN050.
- RUN050 is the next live / compile / output proof checkpoint.
- Never report the current foundation/proof-contract lane as the full roadmap percentage.



## RUN066R-RUN075R Source-Only Worker Lock

RUN066R through RUN075R are source/code-edit and internet-research runs only. A worker must reject any stale instruction that tries to force live proof, MetaEditor proof, or fresh output proof before RUN076R unless the operator explicitly overrides in the current prompt.

Worker obligations for this source-only lane:

1. Read the prior run report before writing the next prompt or making edits.
2. Update the proof-debt ledger in the active log or run report.
3. Preserve `live_proven`, `source_patched_live_unproven`, `pre_patch_live_proven_post_patch_unproven`, `source_supported_runtime_unobserved`, `scenario_absent_untested`, `output_side_signal`, `held_for_future_live`, and `retired/no_longer_needed` distinctions.
4. Include `NEXT_PROMPT_SEED` in every final report.
5. Treat RUN076R as the next live checkpoint under the current operator rule.
6. Do not ask for Upcomers output, MetaEditor output, screenshots, or runtime packages during RUN066R-RUN075R.

## Deep Audit Standard

A future worker report must be table-heavy whenever it changes code/control files or closes proof debt. A report is not accepted if it only gives a short narrative summary.

Required audit/proof tables, where applicable:

| Required element | Worker obligation |
|---|---|
| Files read | List exact active log, roadmap/control, source, and evidence files. |
| Source audit | Name exact file/function/constant seams and the observed gap. |
| Internet research decision table | Map each source finding to file/function impact, patch decision, and rejected misuse. |
| Patch stress-test | Attack the patch before editing and record mitigation/result. |
| Patch candidate matrix | Show why each candidate file was chosen or rejected. |
| Patch table | Record exact file, area, patch, truth basis, and compile/runtime safety. |
| Proof ledger | Convert source support and runtime debt into accept/hold proof items. |
| Regression check | Explicitly preserve FileIO, log schema, runtime loops, scoring, ranking, selection, HUD, artifact semantics, and operator wording unless the run authorizes those areas. |
| Remaining flaws | Keep proof debt visible instead of burying it in progress percentages. |

## RUN050 Evidence Discipline

RUN050 must inspect current compile/live/output evidence and must not close the full roadmap. It may only prove or hold the current foundation/proof-contract lane.

RUN050 must distinguish:

| Evidence class | Required handling |
|---|---|
| Source-supported | Valid for source readiness only; not runtime proof by itself. |
| Runtime-observed | Requires current live/output package evidence. |
| Archive evidence | Historical evidence only unless the package is proven current. |
| Missing / unavailable / stale | Must remain visible and cannot be promoted to clean proof. |
| Blocked / not tested / deferred | Must be labeled honestly and carried forward. |

RUN050 final report must include live output intake, compile/live interpretation, manifest required-line proof, manifest token alignment, output artifact locators, current-vs-archive proof, `function_results.log` presence/header/row-key/proof-row-class/seam-detail/log-budget/repeated-row tables, Dossier/GlobalTop10/Current Focus hydration tables, Evidence Availability/Recovery/Recheck tables, Candidate/Shortlist/Market Board evidence intake tables, source-supported vs runtime-observed seams, behavior drift, phase status, full-roadmap vs current-lane progress, remaining roadmap domains, and next phase recommendation.

## Pre-Edit Stress Test

Before editing, the worker must attack the proposed patch with these questions:

| Risk question | Required result |
|---|---|
| Could this still allow a vague proof report? | Add exact report/proof table requirements or hold. |
| Could this still allow one misleading percentage? | Enforce dual-progress reporting. |
| Could this falsely close the full roadmap? | State current-lane-only validation and list remaining domains. |
| Could runtime proof be replaced by source support? | Require current output/log/artifact evidence. |
| Could archive files be used as current proof? | Require current-vs-archive classification. |
| Could log budget/no-spam proof be skipped? | Require row count, file size, repeated-row, and no-spam checks. |
| Could this become office-only fluff? | Tie each patch to a future proof decision or reject it. |
| Could runtime logic be touched unnecessarily? | Reject runtime edits unless explicitly authorized. |


## Active Roadmap Log Handling

Before any audit or edit, the worker must read `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` and restate:

- current campaign
- current phase/run
- last completed run
- blockers
- proof status
- full Truth Seeker roadmap progress
- current phase/lane progress
- next valid run

At the end of every run, the worker must update `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` with:

- files read
- files changed
- code/trading-logic changed yes/no
- full Truth Seeker roadmap progress
- current phase/lane progress
- compile proof status
- live proof status
- artifact proof status
- logging proof status
- findings and repairs
- blockers and regression risks
- next valid run

If the active log is not updated, the worker must not mark the run complete.


## Core Work Sequence

1. Read roadmap laws.
2. Read phase index.
3. Read active phase.
4. Read run template.
5. Read acceptance standard.
6. Read risk register.
7. Inspect source files.
8. Inspect runtime/output evidence.
9. Perform internet research for the phase subject.
10. Convert research into audit questions.
10A. For book/strategy/AI work, inspect the current Aurora EA zip/source and update source-library/crosswalk/card/ledger files before any strategy expansion.
11. Audit exact source seams.
12. Patch only proven gaps, inside existing owner paths only.
13. Update only required roadmap/control notes.
14. Package changed files only.
15. Put zip link as the absolute last line.

## No-New-Code-Path Rule

Default assumption is no new files/modules/engines.

Do not create new engines, runtime lanes, Dossier systems, logging systems, ranking systems, publication paths, artifact families, or hidden truth owners.

Allowed only if proven and phase-authorized: small helper functions inside existing rightful owner files, source-compatible struct/enum extension after dependency review, existing writer improvements that compose truth only, existing logging improvements through the existing logging owner/path, and existing IO/publication improvements through the existing IO/publication owner/path.

## How To Handle 3 KB Dossier Evidence

Never say “all 3 KB Dossiers are bugs.” Classify them.

| Evidence | Meaning | Action |
|---|---|---|
| 3 KB closed/inactive with honest Layer 0–2 truth | Acceptable compact Dossier | Keep compact; log `CLOSED_L0_L2` |
| 3 KB open/eligible symbol | Shell/backlog/stall | Repair existing queue/resume path |
| 3 KB with unavailable placeholders | Info garbage | Remove/downgrade; log unavailable count |
| 3 KB with missing broker/spec/quote | Dependency blocked | Log missing dependency and retry state |
| 3 KB after interrupted run | Publication/resume issue | Repair existing temp/promote/resume path |
| Large Top10/selected Dossier | Deep path likely working | Preserve; do not rewrite deep path |

File size is diagnostic only. The real proof is hydration class, section presence, layer boundary, manifest/log alignment, and no unavailable padding.

## Hydration Class Rules

- `CLOSED_L0_L2`: closed/inactive compact Dossier; Layer 0–2 only.
- `OPEN_L0_L4`: open/eligible Dossier; Layer 0–4 hydrated; often around 30–60 KB when evidence is present.
- `TOP10_L0_L6`: auto Top 10 deep Dossier; Layer 0–6 through existing deep path only.
- `SELECTED_L0_L6`: selected/current-focus deep Dossier; Layer 0–6 through existing deep/current-focus/Dossier path only.
- `STALLED`: should have hydrated but did not complete.
- `INCOMPLETE`: partial/hydration class mismatch.
- `DEPENDENCY_BLOCKED`: required broker/spec/quote/session data missing or stale.

## Dossier Completion Repair Principle

Fix incomplete Dossier folder hydration by completing the existing publication queue, not by creating a new publication system.

Future implementation should use existing owner paths and consider bounded per-heartbeat writing, continuation cursor, resume after interruption, backfill queue for shell files, open-symbol priority, closed-symbol compact retention, Top 10/deep entitlement priority, manifest proof of completed/pending/stalled states, write budget telemetry, queue remaining count, last completed symbol, failed symbol retry reason, publication age, and hydration class per symbol.

Do not run one giant blocking write. Do not slow HUD. Do not generate L5/L6 for every symbol.

## Logging Guide

Future logging improvements must stay existing-path, lightweight, and structured.

Prefer change-only logs, batched summaries, per-cycle summaries rather than per-tick spam, stable reason codes, stable hydration classes, section counts, unavailable/stale counts, queue telemetry, and write-budget telemetry.

Do not create a parallel logging system.

## What Not To Do

- Do not start strategy expansion before Dossier/logging/contradiction foundations exist.
- Do not rewrite the Dossier system because some files are 3 KB.
- Do not ignore that GlobalTop10 and root/current Dossiers already prove deep paths can work.
- Do not confuse artifact richness with edge proof.
- Do not use file size as the only success criterion.
- Do not add indicators before logging and contradiction safeguards exist.
- Do not touch dispatcher/IO/HUD internals unless the phase explicitly requires it.
- Do not broaden scope.
- Do not claim live proof without live output.
- Do not claim compile proof without compile output.

## Packaging Rule

Changed-files zip only. Preserve exact folder layout from repo root. Do not include the whole source tree. Do not include MT5 source edits unless the phase was a source patch run. Zip link must be the final line of the final reply.


## Academic Strategy / AI Worker Guide

Future workers must treat academic strategy evidence as a **test-lane generator**, not as proof.

### Required strategy audit sequence

1. Identify the strategy family.
2. Define horizon, regime, session, geometry, and conflict dimensions.
3. Identify exact MT5 data required.
4. Mark data as true, broker-derived, or proxy.
5. Identify the existing owner path before any source edit.
6. Define feature log fields and outcome labels.
7. Define validation method: backtest, walk-forward, forward-review, live-output comparison.
8. Define rejection condition.
9. Confirm no execution path is touched.
10. Confirm no black-box confidence is introduced.

### How to avoid false “proven strategy” wording

Use:

- “research-supported candidate”
- “test lane”
- “review-only label”
- “proxy evidence”
- “requires outcome validation”
- “advisory confidence”

Do not use:

- “proven buy/sell”
- “guaranteed edge”
- “AI decides”
- “confirmed profitable”
- “full-auto ready”
- “order-flow confirmed” when only MT5 tick/spread proxy exists

### AI advisory-only rule

AI may summarize Dossier/rank/geometry/conflict evidence and suggest paper-review candidates. AI must not place trades, size trades, set stops/targets, manage positions, or hide execution decisions behind operator surfaces.

### Full-auto creep check

Before finalizing any strategy/AI run, search changed files for execution terms and explain why any mentions are documentation-only:

- `OrderSend`
- `OrderSendAsync`
- `CTrade`
- `.Buy(`
- `.Sell(`
- `PositionOpen`
- `PositionClose`
- `auto lot`
- `auto SL`
- `auto TP`

If any source execution path changed during Truth Seeker, reject the run unless the operator explicitly opened a separate full-auto execution roadmap.

## Source Library / Book-to-Aurora Worker Guide

For any book, academic, strategy, indicator, or AI-method run:

1. Inspect current uploaded Aurora EA zip/source before status claims.
2. Inspect roadmap package and current source-library control files.
3. Separate uploaded book files from screenshot-only titles.
4. Use internet research to understand source family, but do not treat public summaries as full extraction.
5. Extract concepts only; do not copy long copyrighted source text.
6. Search for existing Aurora cards, labels, ledgers, source-set manifests, module maps, and implementation files.
7. Add/update Book-to-Aurora crosswalk rows.
8. Add/update method extraction ledger rows.
9. Create, update, merge, downgrade, reject, or defer method cards.
10. Map every accepted card to MT5 data, layer owner, logging, contradiction handling, validation, and rejection criteria.
11. Keep AI advisory-only and full-auto locked.

### Current reference limitation rule

If the provided Aurora reference zip contains blueprint/docs/cards/ledgers but no `.mq5`/`.mqh` MT5 source files, state that limitation. Use those files as implementation-reference evidence only. Do not claim compile-path or function-level implementation proof.

## RUN051+ SOURCE-OWNER TRACE DUTY

For Layer 3–6 work, every claim must identify owner file, owner function/area, input source, output consumer, artifact/log projection, and failure mode if stale, missing, contradictory, or overconfident.

Use the exact finding table format from the run template. Do not write vague findings such as `needs improvement`, `review logic`, `better truth`, or `could be stale`. A future worker must be able to patch the finding without guessing.

Layer 3 score/ranking support must never be reported as trade permission. Layer 4 rank/top-list membership must carry source authority and limitation proof. Layer 5 built/lawful status must be separated from fresh/decisive support. If no distinct Layer 6 contradiction owner exists, state that plainly and schedule it rather than pretending alignment is proven.

---

## RUN071R Worker Handoff Discipline Gate

Before editing source in a new source-only run, the worker must audit the immediately previous run report and available final handoff text for the required fenced `GIT HEADER SUMMARY` and `FINAL SUMMARY` codeblocks.

The worker must not close with a shallow changed-file list. The final response must expose what was patched, what was protected, proof status, and the next prompt seed. If changed files exist, the zip link must be the final line with no trailing text.

A missing final-response codeblock is a handoff regression even when the saved report contains the section.

---

## RUN075R Warmup Gate Worker Law

The next code worker must treat RUN075R as a roadmap/control update, not as a completed source repair.

Before patching, read `TRUTH_SEEKER_RUN075R_REPORT.md` and the five `deep-research-report*.md` files. The reports are now part of the roadmap evidence chain:

- Reports 1–3 govern architecture, publication, ownership, artifact alignment, and contradiction proof debt.
- Report 4 governs L3/L4/L5/L6 edge-truth limits and prevents premature strategy labels.
- Report 5 governs the master flaw/proof-debt/repair sequence and strategy expansion hold.

Warmup-gate workers must obey:

1. Do not redesign GlobalTop10.
2. Do not change score, rank, order, tie-breakers, Top10 membership formula, strategy, indicators, execution, HUD, or FileIO architecture.
3. Patch only bounded readiness/gating/status semantics required to prevent first-publish false completeness.
4. Add timeout/fail-open/degraded release before any gate can block output.
5. Prefer retry prioritization over heavy loops.
6. Treat post-warmup `Steady` as the default once warmup is complete and refresh is idle.
7. Treat `Disturbed`, `Rebalancing`, and `Partial` as active-state words that require actual refresh/degradation/threshold breach.
8. Treat `file exists` as the weakest possible file state; never use it alone as freshness/currentness/completeness proof.
