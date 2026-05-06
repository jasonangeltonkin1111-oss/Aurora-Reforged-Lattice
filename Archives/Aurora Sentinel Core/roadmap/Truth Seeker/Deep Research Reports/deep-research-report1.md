# Aurora Truth Seeker Whole-System Architecture and Proof-Debt Audit

## Executive verdict

The repository is **architecturally more coherent than its control plane**, but the control plane is **not clean enough to serve as a trustworthy single source of roadmap truth**.

The strongest baseline finding is this: **the current compile-path code baseline in the uploaded zip is RUN065R, not RUN066**. `mt5/core/ASC_Version.mqh` still declares `ASC_TRUTH_SEEKER_CURRENT_RUN "RUN065R"` and `ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN "RUN066R"`. That means any later report claiming RUN066 code/state is authoritative is **not reflected in the source currently uploaded**.

The cleanest architectural pattern is also the most important one: compile-path ownership is mostly lawful. The dispatcher remains the orchestration owner, FileIO still uses an atomic temp → readback → promote style, L3/L4/L5 proof-token seams exist in source, Current Focus is explicitly implemented as a derivative of root `Dossier.txt`, and L5 deep analysis is still selected-symbol/on-demand rather than broad-universe by default. Those are good system-shape signals.

The dirtiest control finding is that **the active roadmap/control package has forked into multiple partially overlapping realities**:

- front-door files (`README.md`, `MASTER_INDEX.md`, `CHAT_CONTINUATION_GUIDE.md`) point to the Truth Seeker control chain,
- `AGENTS.md` points workers back toward older/non-matching control surfaces,
- `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` does not cleanly represent the later R-branch runs,
- `TRUTH_SEEKER_RUN_TEMPLATE.md` and `TRUTH_SEEKER_ACCEPTANCE_STANDARD.md` still anchor live-proof gates to RUN050/RUN060-era semantics,
- `TRUTH_SEEKER_RUN065_REPORT.md` and `TRUTH_SEEKER_RUN066_REPORT.md` describe code states that are **not in the uploaded compile-path source**.

Using entity["organization","NIST","US standards agency"] guidance on software acceptance and configuration management, entity["company","Microsoft","software company"] operational-readiness/testing guidance, and official entity["company","MetaQuotes","developer of mql5"] MQL5 reference material, the right audit questions are: does each claim trace to a requirement or acceptance criterion, can each change be traced to a real source seam, are release gates current and quantified, and are runtime-observed claims kept separate from source-supported claims. By that standard, Aurora’s **source architecture is ahead of its roadmap hygiene**, and its **proof debt is still being carried in confusing ways**. citeturn1search1turn1search3turn1search11turn1search19turn0search1turn0search4turn0search13turn0search17turn0search2turn0search5

**Executive verdict:** **partial system cleanliness, dirty roadmap governance, substantial proof debt, and a misleadingly fragmented report lineage.**

**What is clean**

The front-door trio `README.md`, `MASTER_INDEX.md`, and `CHAT_CONTINUATION_GUIDE.md` agree on the active Truth Seeker folder and on compile-path `mt5/` supremacy. Core architectural boundaries are also mostly preserved in code: dispatcher orchestration, writer composition, selected-only deep analysis, and atomic publication all remain recognisable and bounded.

**What is dirty**

The active log is not a reliable whole-system ledger. `AGENTS.md` contradicts the new front door. The active control package still contains stale RUN050/RUN060 live-proof instructions. The folder also contains a stale duplicate package file, `roadmap/Truth Seeker.zip`, which omits later reports and can mislead a worker into an older state. Most seriously, RUN065 and RUN066 reports describe patches that are not present in the uploaded compile-path source.

**What is partial**

L3/L4/L5 proof-token work is present in source, but there is no current source-backed evidence package in this zip proving those seams live. Market Board and portfolio publication have report-backed live evidence, but only narrowly and with post-patch reproof debt still open. Current Focus is correctly represented in code as a root-Dossier derivative, but fresh selected-symbol proof is absent from the current system-of-record bundle.

**What must not be touched**

Do not touch ranking formulas, shortlist selection logic, GlobalTop10 selection/order logic, HUD truth ownership, FileIO architecture, new engines/modules/runtime lanes, or any execution/trade-management logic on the strength of these controls alone. The architecture problems here are mostly **control cleanliness and proof lineage problems**, not a mandate for broad behavioural rewrites.

**What must be fixed later**

After the five audits are complete, the first fixes should be control-surface reconciliation, report-to-source reconciliation, version/log cleanup, and an explicit merged baseline register. Only then should the team close proof debt on GlobalTop10 and selected deep-pair publication.

## Baseline and evidence model

### Current true baseline

The current uploaded zip says the live source baseline is:

- **Version identity:** RUN065R
- **Current run in code:** `RUN065R`
- **Next live proof in code:** `RUN066R`
- **Current campaign in code:** `Campaign1_Foundation_Repair`

That is the highest-confidence baseline because it sits in compile-path source, not in commentary docs.

### What is actually live-proven, only source-patched, or still carried as debt

| Audit question | Answer from the uploaded zip |
|---|---|
| What is the current true baseline? | **RUN065R compile-path source**. Later report files exist, but they are not merged into current source. |
| What work is live-proven? | Narrow, report-backed live evidence exists for pre-patch Market Board publication, portfolio snapshot sections, FunctionResults aggregate portfolio proof, and one observed GlobalTop10 current/archive/staging family state in `TRUTH_SEEKER_RUN065R_REPORT.md`. |
| What work is source-patched but live-unproven? | L3 candidate proof tokens, L4 shortlist proof tokens, L5 support/ticks/rates tokens, Market Board wording repair, and several portfolio/report-branch claims. |
| What work is partial-pass only? | Current Focus selected-symbol proof, selected/root deep Dossier pair proof, pending-order non-zero scenarios, same-symbol/high-correlation exclusion scenarios, and cross-artifact alignment. |
| What proof debt is still carried forward? | Missing post-patch compile proof, missing fresh selected-symbol package proof, missing merged branch ledger, stale control-gate text, and unresolved report/source contradictions. |
| Is the roadmap still clean after revert, redo, and RUN065R? | **No.** Source shape is serviceable, but the roadmap/control layer is fragmented and internally inconsistent. |
| Are stale live-proof instructions still embedded in active controls? | **Yes.** RUN050/RUN060-era acceptance and template gates remain active in control files. |
| Are old reports or roadmap entries contradicting the current operator rule? | **Yes.** The repository still carries changed-files-zip ritual, stale live checkpoint language, and detached post-RUN065R reports that are not source-real. |

For MT5-specific boundary checking, the official MQL5 reference is the right standard: file APIs govern write/readback/promote seams, timer APIs define runtime-event boundaries, positions/orders/history APIs define broker-state evidence boundaries, and `CopyRates`/`CopyTicks` define historical/live market-data acquisition boundaries. That is why source support and runtime proof must be separated here rather than blended. citeturn0search2turn0search5

## Full inventory

### Full inventory table

| Area | Files found | Missing/partial | Audit decision |
|---|---|---|---|
| Front-door controls | `README.md`, `MASTER_INDEX.md`, `CHAT_CONTINUATION_GUIDE.md`, `ASC_CORE.MD`, `FRONT_DOOR_CHECKLIST.md`, `AGENTS.md` | `AGENTS.md` is inconsistent with the rest of the front door | **Partial** |
| Truth Seeker control package | 14 control files under `roadmap/Truth Seeker/` | Several controls are stale or branch-confused | **Partial** |
| Truth Seeker run reports | 21 run reports, including RUN051–055, RUN060R–065R, RUN062–065, RUN066, and a forensic 001–061 report | Not all reports are reflected in source or active log | **Dirty** |
| Compile-path MT5 code | 100 files under `mt5/` | No compile output/log in zip; source only | **Partial but usable** |
| Portfolio owner domain | `mt5/portfolio/ASC_PortfolioExposureSnapshot.mqh` exists and is referenced by report lineage | Not foregrounded in control docs or mandatory spot-check list | **Partial / under-documented** |
| Historical archives | 94 archive/docs files | Historical only; not active authority | **Clean as archive, risky if misread** |
| Aurora EA reference corpus | 321 files under `Aurora EA/` | Reference-heavy; not compile-path truth for ASC | **Clean as evidence, not authority** |
| Duplicate packaged roadmap | `roadmap/Truth Seeker.zip` exists beside active folder | Zip contains only control files + RUN051–055, omits later R-runs | **Dirty / misleading duplicate** |
| Git history / provenance | No `.git` metadata in uploaded zip | Prevents independent verification of “git forensic” claims | **Missing** |
| Runtime proof package inside current zip | No fresh MetaEditor compile output or live output package bundled with this zip | Means runtime proof must be read from reports, not reverified here | **Missing** |

### Inventory interpretation

The inventory is **broadly complete for source audit** and **insufficient for fresh live-proof closure**. The code is present. The control package is present. The report history is present. What is not present is the one thing that would cleanly close proof debt: a fresh, baseline-matching compile/live/output package.

## Roadmap cleanliness

### Roadmap cleanliness table

| Roadmap area | Current claim | Evidence found | Clean/dirty/partial | Why |
|---|---|---|---|---|
| Front-door authority chain | Truth Seeker folder is active; `mt5/` code is runtime authority | `README.md`, `MASTER_INDEX.md`, `CHAT_CONTINUATION_GUIDE.md` agree | **Clean** | These three files are aligned and sensible. |
| Worker operating law | Workers should read current active controls first | `AGENTS.md` still points to `blueprint/`, `mt5/blueprint/`, and `office/` paths not aligned with new front door | **Dirty** | It violates the stop-gate idea in `CHAT_CONTINUATION_GUIDE.md`. |
| Active roadmap log | First-read progress ledger and current run authority | `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` contains old and new runs, but omits clean representation of RUN060R–RUN066 | **Dirty** | It is append-heavy, incomplete, and not authoritative enough for current branching. |
| Phase index | Fixed dependency order and read order | `TRUTH_SEEKER_PHASE_INDEX.md` is coherent at doctrine level | **Partial** | Good doctrine; weak linkage to actual later run lineage and portfolio branch reality. |
| Roadmap body | Whole-system phase model | `TRUTH_SEEKER_ROADMAP.md` broadly matches architecture law and phase intent | **Partial** | Conceptually sound, but operationally outpaced by later report branches. |
| Acceptance standard | Current live-proof acceptance gates | `TRUTH_SEEKER_ACCEPTANCE_STANDARD.md` still centres RUN051–RUN060 and RUN060 pass/fail/block gates | **Dirty** | Active acceptance language is stale relative to RUN065R baseline. |
| Run template | Future worker template | `TRUTH_SEEKER_RUN_TEMPLATE.md` still says RUN050 is the next live checkpoint and repeatedly requires changed-files zips | **Dirty** | It is not clean after later revert/redo/R-branch history. |
| Laws file | Operating laws and no-new-path doctrine | `TRUTH_SEEKER_LAWS.md` is generally aligned with source shape | **Partial-clean** | Good doctrine, but still packaging-centred and not reconciled to report branch confusion. |
| Worker guide | Report quality and proof-debt visibility | `TRUTH_SEEKER_WORKER_GUIDE.md` still references RUN050 final-report expectations | **Partial** | Useful reporting doctrine, stale checkpoint references. |
| Output package manifest | Records run/package state | `TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` mixes a RUN060 post-hardening contract with a RUN065R addendum | **Partial-dirty** | It preserves history but does not retire stale gate language. |
| Current Focus representation | Current Focus is Dossier derivative | Code: `ASC_CURRENT_FOCUS_FILE "Dossier.txt"` and `ASC_CurrentFocusContract()` target root Dossier/current focus path | **Clean in code, partial in controls** | Correct in source, but not prominent enough in control surfaces. |
| Market Board representation | Compressed L3/L4-facing surface; no hidden L5 ownership | `ASC_MarketBoardWriter.mqh` and roadmap both preserve this idea | **Partial-clean** | Directionally correct, but wording/proof seams are still fragile. |
| L3/L4/L5 representation | Source-backed proof seams exist but require runtime proof | `ASC_SelectionFilter.mqh`, `ASC_ShortlistSelectionEngine.mqh`, `ASC_DeepSelectiveAnalysisEngine.mqh` contain these tokens | **Partial** | Source supports claims; runtime proof is still missing. |
| GlobalTop10 representation | Working/protected and correctly classified | Reports conflict; current source still contains deep-compose verifier seam cited by RUN066 | **Dirty** | Representation is not stable enough to call clean. |

### Report contradiction table

| Report/control file | Claim | Contradicting evidence | Severity | Recommendation |
|---|---|---|---|---|
| `AGENTS.md` | Active control surfaces include blueprint/office chains | Front-door files say Truth Seeker package is first authority and old office paths are not active roadmap authority | Critical | Reconcile or demote `AGENTS.md`; do not leave both active. |
| `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | First-read current ledger | Later run families are not cleanly logged as current baseline; RUN066 is absent as a source state while its report exists | Critical | Rebuild the active log as a single merged baseline ledger. |
| `TRUTH_SEEKER_RUN_TEMPLATE.md` | RUN050 is next live checkpoint; changed-files zip is standard tail requirement | Current source says RUN065R with RUN066R next; current audit instruction forbids code-edit/zip behaviour | Critical | Replace run-number-specific template text with run-agnostic gating. |
| `TRUTH_SEEKER_ACCEPTANCE_STANDARD.md` | RUN051–RUN060 acceptance gate is active | Current source/version/report chain has moved beyond that branch | High | Retire stale gate blocks or mark historical-only. |
| `TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | RUN060 proof contract remains present alongside RUN065R addendum | No retirement/reconciliation rule between them | High | Split historical contracts from active contract, or add an explicit supersession table. |
| `TRUTH_SEEKER_RUN065_REPORT.md` | Duplicate RUN054 macros were removed and version advanced to RUN065/RUN066 | Current `ASC_Version.mqh` still contains duplicate RUN054 macros and still declares RUN065R | Critical | Mark RUN065 as detached/unmerged, not current baseline. |
| `TRUTH_SEEKER_RUN066_REPORT.md` | `ASC_DossierComposer.mqh` was patched and version advanced to RUN066 | Current `ASC_DossierComposer.mqh` still contains exact `StringFind(section_text, deep_result.block_text)` check and version is still RUN065R | Critical | Treat RUN066 as non-merged evidence; do not read it as live baseline. |
| `TRUTH_SEEKER_RUN065R_REPORT.md` | RUN064R report was absent in the inspected package | Current zip contains `TRUTH_SEEKER_RUN064R_REPORT.md` | Medium | Preserve package-context note, but never generalise that statement to the current system-of-record. |
| `roadmap/Truth Seeker.zip` | Packaged Truth Seeker control state inside active folder | Zip includes only RUN051–055-era package content and omits later R branch reports | High | Remove from active folder or relabel as historical snapshot. |
| `mt5/core/ASC_Version.mqh` | Current baseline is coherent and singular | Duplicate RUN054 macro triplets and unresolved branch reports undermine that coherence | High | Clean macro debt and add a merged-baseline comment block. |
| `TRUTH_SEEKER_RUN065R_REPORT.md` vs `TRUTH_SEEKER_RUN065_REPORT.md` | Next run is RUN066R vs RUN066 | Multiple next-run branches are simultaneously present | High | Create explicit branch resolution: accepted branch, rejected branch, detached branch. |

## Proof debt and gaps

### Proof-debt table

| Feature/domain | Status class | Evidence | Risk if misread | Later fix needed |
|---|---|---|---|---|
| Front-door source authority | live_proven | Compile-path code and front-door docs agree on `mt5/` supremacy | Low | Keep, do not dilute. |
| `AGENTS.md` authority | stale_claim | File points to older/non-matching control surfaces | Worker follows the wrong front door | Reconcile or archive. |
| L3 candidate filtering proof tokens | source_supported_runtime_unobserved | `ASC_SelectionFilter.mqh` contains `trade_permission=false`, `entry_signal=false`, `l3_to_l4_authority`, etc. | Candidate score may be over-read as runtime-proven | Fresh FunctionResults/artifact proof. |
| L4 shortlist proof tokens | source_supported_runtime_unobserved | `ASC_ShortlistSelectionEngine.mqh` contains `l4_meaning`, `why_not_higher`, `correlation_status`, `top_list_authority` | Shortlist reasoning may be treated as live-proven | Fresh shortlist/artifact proof. |
| L5 deep support tokens | source_supported_runtime_unobserved | `ASC_DeepSelectiveAnalysisEngine.mqh` contains `l5_support_posture`, `trade_permission=false`, `entry_signal=false`, `CopyTicks`, `CopyRates` selected-only logic | Deep section may be over-read as current runtime evidence | Fresh selected-symbol proof package. |
| Current Focus contract | source_supported_runtime_unobserved | `ASC_CURRENT_FOCUS_FILE` is `Dossier.txt`; `ASC_CurrentFocusContract()` targets root dossier/current focus | Worker expects a separate file and misclassifies absence as failure | Promote this rule into active controls. |
| Market Board portfolio/publication safety | pre_patch_live_proven_post_patch_unproven | RUN065R report says fresh output proved pre-patch file generation and sections; wording patch followed | Patched wording gets treated as already live-proven | Narrow reproof on current source. |
| FunctionResults portfolio aggregate proof | pre_patch_live_proven_post_patch_unproven | RUN065R report shows aggregate rows, no per-closed-trade spam | Aggregate semantics may be misread after later patches | Fresh log from current source. |
| GlobalTop10 current family | contradicted_claim | RUN065R says pass/current/promoted_complete; RUN066 report says missing_or_unverified and deep compose failure; current source still carries suspect verifier seam | False confidence about current family health | Deep-pair path audit and new live proof. |
| Selected/root Dossier deep pair | scenario_absent_untested | RUN065R package had `selected_symbol=none`; no selected-path proof in current baseline | Current Focus and selected Dossier may appear “supported” without runtime exercise | Force selected-symbol scenario proof. |
| Dossier deep verifier | source_supported_runtime_unobserved | Current source still requires full `deep_result.block_text` substring in `ASC_DossierPayloadHasFreshDeepTruth()` | Legitimate composed payloads may be rejected or later reports may be misread as merged | Audit after report series; do not assume RUN066 patch is present. |
| Active roadmap log completeness | stale_claim | Missing clean representation of later branch runs | Operator may think log is current when it is not | Rebuild active ledger. |
| Run065 report code state | contradicted_claim | Report says duplicate macros removed and version advanced; source disproves both | Worker may trust an unmerged patch | Mark detached/unmerged. |
| Run066 report code state | contradicted_claim | Report says composer patched and version RUN066; source disproves both | Worker may chase wrong “current” baseline | Mark detached/unmerged. |
| Version macro hygiene | stale_claim | Duplicate RUN054 macro triplets remain in `ASC_Version.mqh` | Compile cleanliness and trustworthiness are weakened | Normalise version file after audits. |
| FunctionResults proof constants | stale_claim | Source still contains many RUN030/RUN050-era strings/macros | Runtime diagnostics can carry obsolete checkpoint semantics | Refactor to run-agnostic taxonomy. |
| Portfolio owner documentation | unknown | Real source owner exists, but controls under-represent it | Audit scope misses a real owner | Add portfolio ownership map. |
| Cross-artifact alignment | partial-pass only | Roadmap/laws describe it; fresh current proof package for selected path is absent | Surfaces may silently diverge | Dedicated proof run after control cleanup. |
| Pending-order non-zero scenarios | scenario_absent_untested | Latest authoritative evidence bundle cited zero pending orders | Separation logic may be correct only in zero case | Add scenario proof. |
| Same-symbol/high-correlation exclusion | source_supported_runtime_unobserved | Reports discuss it; no clean current live evidence in baseline zip | Exposure logic may be overclaimed | Focused portfolio/selection proof audit. |

### Roadmap gap table

| Gap | Why it matters | Source/control evidence | Suggested future fix |
|---|---|---|---|
| No merged branch policy for R vs non-R runs | The repository now carries parallel histories that look equally official | RUN060R–065R and RUN062–065 and RUN066 all coexist | Add a branch-resolution ledger: merged, detached, superseded, rejected. |
| No authoritative “baseline truth matrix” | Workers cannot tell which report state is actually in code | Version says RUN065R; later reports say RUN065/RUN066 states | Create one machine-readable baseline summary file. |
| Portfolio owner not foregrounded in roadmap controls | A real owner can be missed in future audits | `mt5/portfolio/ASC_PortfolioExposureSnapshot.mqh` is central in reports, marginal in controls | Add it to source-owner maps and mandatory spot checks. |
| No acceptance rule for report validity against source | Detached reports currently look authoritative | RUN065/RUN066 reports are not reflected in code | Define: a report is active only if active log + version + source agree. |
| No explicit failure-mode ledger for control drift | Current system carries roadmap drift without a named class | Active log, template, acceptance, manifest all drift together | Add a control-plane failure-mode ledger. |
| No explicit selected-symbol proof gate in current control front door | Current Focus and selected Dossier can remain “not applicable” too easily | RUN065R classified Current Focus not applicable because `selected_symbol=none` | Make selected-path proof a named requirement. |
| No live-proof retirement mechanism | Old RUN050/RUN060 instructions linger as if still active | Acceptance/template/manifest still carry old checkpoint language | Add superseded-by fields and historical sections. |
| No git-absence handling policy for forensic reports | “Git forensic” language becomes overclaiming when `.git` is absent | RUN066 uses git-forensic framing but zip has no git metadata | Add explicit source-only forensic language. |
| No ownership map for report/control files themselves | Control docs can contradict each other without a designated owner | README, AGENTS, active log, template, acceptance all drift independently | Nominate a control-package owner and a reconciliation rule. |
| No explicit proof-boundary taxonomy for runtime vs report-derived evidence | Report-backed live proof and fresh live proof are easily conflated | Many reports correctly warn, but controls do not consolidate the rule | Add a standard proof class ledger. |

### Ritualisation and bloat table

| Symptom | Evidence | Risk | Suggested simplification |
|---|---|---|---|
| Run-number ritual embedded in compile-path macros | `ASC_FunctionResults.mqh` still carries many RUN030/RUN050 strings | Runtime/support strings become archaeology instead of current truth | Convert to stable taxonomies; move run numbers to reports only. |
| Append-only active log | Later runs are bolted onto a long ledger with inconsistent chronology | Current run state becomes ambiguous | Rebuild the log as a canonical current summary with an archived appendix. |
| Parallel report branches | RUN065, RUN065R, RUN066 coexist without merge status | Workers may pick the wrong line of truth | Add “branch state” header to every report. |
| Duplicate packaged roadmap inside active folder | `roadmap/Truth Seeker.zip` sits next to live files | Worker may open stale package and miss later changes | Remove from active folder or relocate to archive. |
| Changed-files-zip ritual in active template | Template repeatedly mandates zips and absolute-last-line link behaviour | Encourages process ceremony over system truth | Keep only when the operator explicitly requests packaging. |
| Stale live checkpoint language | RUN050/RUN060 gates remain active in controls | Misstates what still needs proof | Replace with a current checkpoint register. |
| Progress percentages repeated without reconciliation | “12–18%” and similar labels recur across files and version macros | Gives a false sense of precision and encourages rote repetition | Replace with milestone classes and open-proof lists. |

## Deferred fixes and handoff

### Future fix candidate table

| Candidate fix | Target file/domain | Why wait until after 5 reports | Priority |
|---|---|---|---|
| Reconcile front-door controls into one authoritative chain | `AGENTS.md`, `README.md`, `MASTER_INDEX.md`, `CHAT_CONTINUATION_GUIDE.md` | Needs all audit findings, not just audit 1 | Critical |
| Rebuild active log as a merged baseline ledger | `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | Must incorporate findings from all five audits | Critical |
| Create baseline truth matrix | new control file or top of active log | Avoids repeated branch confusion after all audits settle source truth | Critical |
| Retire or relabel detached reports | `TRUTH_SEEKER_RUN065_REPORT.md`, `TRUTH_SEEKER_RUN066_REPORT.md`, similar | Need full research series before deciding archive vs merge vs reject | Critical |
| Clean `ASC_Version.mqh` macro debt | `mt5/core/ASC_Version.mqh` | Should be done once branch truth is final, not before | High |
| Refactor stale proof constants | `mt5/logging/ASC_FunctionResults.mqh` | Needs a final proof taxonomy after all audits | High |
| Add portfolio owner map to controls | roadmap/control files | Must reflect final ownership picture after later audits | High |
| Clarify Current Focus contract in controls | roadmap/control files | Better done once selected-path audit is complete | High |
| Resolve deep compose verifier status | `mt5/artifacts/dossier/ASC_DossierComposer.mqh` and deep-trigger path | Needs audit 2 focus and later proof decisions | High |
| Add explicit report-validity rule | acceptance/template/log | Depends on whole report-chain reconciliation | High |
| Replace stale RUN050/RUN060 gate text | acceptance/template/manifest/worker guide | Do once there is an agreed current checkpoint map | High |
| Add control-plane failure-mode ledger | risk/register or new control file | Best after all five audits identify recurring failure classes | Medium |
| Remove duplicate Truth Seeker packaged zip from active area | `roadmap/Truth Seeker.zip` | Safe once archive strategy is agreed | Medium |
| Add selected-symbol proof matrix | acceptance/log/report template | Needs audit 2–3 scenario mapping | Medium |
| Add explicit git-absence policy for forensics | report template / worker guide | Do after handling all detached forensic claims | Medium |

### Top 20 flaws and weaknesses

1. `AGENTS.md` contradicts the active front-door chain and still points to outdated/non-matching control surfaces.
2. `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` is not a trustworthy current-state ledger for the later R-branch history.
3. `TRUTH_SEEKER_RUN_TEMPLATE.md` still frames RUN050 as the next live checkpoint.
4. `TRUTH_SEEKER_ACCEPTANCE_STANDARD.md` still treats RUN051–RUN060 gates as active control law.
5. `TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` mixes historical and current package contracts without a retirement rule.
6. `roadmap/Truth Seeker.zip` duplicates and freezes an older control package inside the active roadmap folder.
7. `ASC_Version.mqh` still contains duplicate RUN054 macro triplets.
8. `TRUTH_SEEKER_RUN065_REPORT.md` describes a code state not present in current source.
9. `TRUTH_SEEKER_RUN066_REPORT.md` describes a code state not present in current source.
10. The repository lacks a formal distinction between merged, detached, historical, and rejected reports.
11. The portfolio owner is real in code but underrepresented in control files.
12. Current Focus is correctly implemented in code but not cleanly surfaced in the control package.
13. GlobalTop10 status is unstable across reports and cannot be called clean.
14. Compile-path logging constants still carry too many obsolete run-number-specific strings.
15. The control package overuses checkpoint ritual instead of maintaining one current proof register.
16. Progress percentages are repeated but do not resolve actual branch state.
17. There is no explicit report-validity rule tying report claims to version file and active log.
18. Selected-symbol proof remains too easy to skip under `selected_symbol=none`.
19. Git-forensic framing appears in a zip with no `.git` metadata.
20. The roadmap package is becoming circular: control files increasingly document the controls rather than the actual current system state.

### Top 20 missing proofs

1. Fresh post-RUN065R compile proof from current source.
2. Fresh post-RUN065R live output proving the narrow wording patch.
3. Selected-symbol Current Focus proof when a symbol is actually selected.
4. Selected/root Dossier deep-pair proof on the current baseline.
5. Current-baseline GlobalTop10 renewal proof.
6. Current-baseline GlobalTop10 archive/promote proof.
7. Current-baseline GlobalTop10 child verification proof rows.
8. L3 proof tokens observed in fresh FunctionResults or artifacts.
9. L4 proof tokens observed in fresh FunctionResults or artifacts.
10. L5 support/rates/ticks proof observed in fresh selected-symbol outputs.
11. Fresh cross-artifact agreement between Dossier, Market Board, Current Focus, manifest, and logs.
12. Current-vs-retained/archive classification proof on a new package.
13. Pending-order non-zero scenario proof.
14. Same-symbol open exposure exclusion proof.
15. High-correlation exclusion proof.
16. History-unavailable scenario proof on the current baseline.
17. Closed-history partial SL/TP provenance proof on the current baseline.
18. Proof that detached report claims have either been merged or rejected.
19. Proof that the active log is once again authoritative.
20. Proof that obsolete RUN050/RUN060 gate strings no longer leak into active control interpretation.

### Top 20 future improvement pointers

1. Define a **single authoritative baseline file** that states current run, merged reports, detached reports, and next proof run.
2. Demote or repair `AGENTS.md` immediately after the five-audit series.
3. Collapse run-number-specific acceptance gates into a generic proof taxonomy.
4. Add portfolio ownership to the mandatory source-owner map.
5. Add a “report validity” header to every future report.
6. Add a “merged / detached / historical” status field to every existing report.
7. Separate historical package contracts from active package law.
8. Remove duplicate packaged control zips from active folders.
9. Move stale run strings out of compile-path logging constants.
10. Make Current Focus derivative rules explicit in front-door controls.
11. Require a selected-symbol scenario in every deep/current-focus proof package.
12. Require a GlobalTop10 current-family scenario in every deep-path proof package.
13. Add a dedicated control-drift ledger to the risk register.
14. Replace soft progress percentages with milestone classes plus open-proof lists.
15. Require the active log, version file, and final report to agree before a run can be called complete.
16. Add a no-git / source-only forensic classification when `.git` is absent.
17. Keep FileIO, dispatcher ownership, and deep selected-only boundaries intact while cleaning control debt.
18. Create a proof-boundary map that distinguishes source-supported, report-observed, live-observed, and post-patch-unproven states.
19. Add a fresh-current-package checklist that cannot be satisfied by historical or detached evidence.
20. End the pattern of using reports as de facto source truth when source files do not reflect them.

### Report 2 handoff

The next deep research audit should inspect the **selected-symbol / GlobalTop10 deep-pair path first**, because that is where the most damaging contradiction sits.

Start with these files and questions:

1. **`mt5/artifacts/dossier/ASC_DossierComposer.mqh`**  
   Inspect `ASC_DossierPayloadHasFreshDeepTruth()`. Determine whether the exact `deep_result.block_text` substring requirement is genuinely over-strict, what stable tokens already exist, and whether this seam can block both selected Dossier and GlobalTop10 child publication.

2. **`mt5/runtime/ASC_Dispatcher.mqh`**  
   Inspect the full deep-trigger path, especially `ASC_RunDeepFocusTriggerWrite` and any GlobalTop10 child publication/verification path. Build a precise owner call chain from deep-result build → dossier compose → write/verify → current/staging/archive decisions.

3. **`mt5/artifacts/ASC_DossierWriter.mqh` and `mt5/artifacts/ASC_CurrentFocusWriter.mqh`**  
   Verify whether Current Focus is faithfully downstream of root Dossier in all selected-symbol cases, or whether there are hidden divergence paths.

4. **`mt5/portfolio/ASC_PortfolioExposureSnapshot.mqh`**  
   Because this owner sits at the centre of RUN060R–RUN065 but is underrepresented in controls, map exactly which Market Board, Dossier, Current Focus, and shortlist decisions consume it.

5. **`mt5/core/ASC_Version.mqh` and `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`**  
   Build a merged/unmerged matrix of RUN065, RUN065R, RUN066, and any intervening report claims.

The primary aim of Report 2 should be to answer one tight question: **is the selected/globaltop10 deep compose path actually broken in the current RUN065R source baseline, or only in a detached later branch/report history?**

### Open questions and limitations

This audit is based on the uploaded source zip as system-of-record. The zip does **not** include `.git` metadata, and it does **not** include a fresh matching live-output package for rerun-free closure. That means the strongest conclusions are about **source state, control cleanliness, and report/source contradictions**, while live-proof conclusions remain limited to what the repository’s own reports claim rather than what can be independently re-executed here.