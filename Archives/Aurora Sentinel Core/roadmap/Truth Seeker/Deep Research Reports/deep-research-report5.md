# Aurora Truth Seeker Final Synthesis Audit

## Executive verdict

The current system-of-record is **not dirty in the sense of wholesale design collapse**, but it is **not clean enough to be treated as broadly proven**. The strongest conclusion from the uploaded repo is this: **the true runtime baseline is the current RUN074R source tree, while the strongest live evidence still comes from the pre-patch RUN065R output package and therefore cannot be stretched to prove the later RUN066R–RUN074R source edits**. In other words, the repo has become better at naming proof debt than at actually retiring it.

The audit standard used here is conservative by design. Requirements that are treated as “complete” need a traceable verification path; technical debt needs to be managed as planning and risk input rather than as a vague clean-up bucket; release/readiness discipline should evolve from prior incidents and include rollback thinking; telemetry must remain bounded to avoid cardinality and write-churn risk; and MQL5 file, timer, and trade/history APIs create hard boundaries that should not be blurred by wording or optimistic interpretation. Those external standards make several local flaws load-bearing rather than cosmetic. entity["organization","NASA","US aerospace agency"], the entity["organization","Software Engineering Institute","Carnegie Mellon, Pittsburgh, PA, US"], entity["organization","OpenTelemetry","observability project"], entity["organization","Amazon Web Services","cloud platform"], entity["organization","Google Cloud","Google cloud platform"], and entity["company","MetaQuotes","trading platform vendor"] all support that stance. citeturn1search5turn1search13turn1search4turn1search12turn2search11turn1search2turn1search10turn3search17turn0search8turn3search3turn3search4turn3search1turn3search11turn3search5

The repo’s **best qualities** are real: there is a genuine temp/validate/promote publication pattern in `ASC_FileIO.mqh`; later source work does preserve proof classes such as `source_patched_live_unproven`, `pre_patch_live_proven_post_patch_unproven`, and `scenario_absent_untested`; Current Focus has explicit same-symbol non-downgrade protection; deep-trigger publication treats the support copy-down as non-blocking; L3/L4/L5 surfaces now state support-only boundaries more honestly than earlier Truth Seeker phases; and GlobalTop10 appears intentionally fenced from opportunistic edits. Those are meaningful strengths.

The **most dangerous remaining weaknesses** are concentrated rather than diffuse: low-level FileIO success is still overstated because `ASC_WriteTextFile` and `ASC_AppendTextFile` do not check write/flush/close outcomes; the compile-path core law says Aurora is “not a trade selector” while the Market Board writer still emits “Best Pick Now” and says ordinary trade-picking authority stays on the Market Board; dispatcher/orchestration has become too large to audit confidently as one file; proof debt is distributed across reports, constants, version macros, manifest text, and the active log instead of one canonical ledger; and the control pack has become ritualised enough that workers can obey the wrong historical sentence while technically remaining inside the same document set. Those are structural trust issues, not style issues. citeturn1search4turn1search12turn2search11turn2search19turn1search2turn1search10turn3search17turn0search8turn3search3

A final limitation matters: **Deep Research Reports 1–4 were not present as standalone uploaded report files inside the accessible materials**. I therefore synthesised the final position from the current source tree, the Truth Seeker control files, the RUN065R–RUN074R report set present in the repo, and the prior uploaded repo snapshots. That is enough to produce a high-confidence flaw ledger and repair blueprint, but it is not the same as reconciling four separate previously written audit deliverables.

## Baseline and synthesis

The current baseline is **RUN074R source state** as identified in `mt5/core/ASC_Version.mqh`, with the active authority folder clearly pointed at `roadmap/Truth Seeker/`. The clean reading order is present in `README.md`, `MASTER_INDEX.md`, and `CHAT_CONTINUATION_GUIDE.md`. The active package also explicitly says RUN066R–RUN075R are source-only and pushes the next live checkpoint to RUN076R. That part is coherent.

What is **working** is the repo’s proof-language and boundary-language. L3 says candidate ranking support only; L4 says shortlist priority ordering only; L5 says deep selected-symbol analysis only; Current Focus is explicitly mirror-only; the file layer uses a shared-file sandbox model consistent with MQL5 file APIs; and the portfolio/history code distinguishes open positions, pending orders, and closed history in ways that align with the trade/history API boundaries in the MQL5 reference. citeturn3search17turn0search6turn3search1turn3search11turn3search5

What is **fragile** is almost entirely in the seams: publication honesty at the very lowest write calls, semantic tension between “support only” layers and a command-oriented Market Board, suffix-heavy proof text that is accurate but operationally dense, and the fact that source-only truth is now better instrumented than runtime truth. What is **false or misleading** is narrower but serious: a worker could still misread old active-log history as current live-proof authority; a future operator could mistake “Current Focus” for a separate artifact when the compile path defines it as root `Dossier.txt`; and the board’s wording still implies action authority beyond what the system’s core law says Aurora should be. What is **missing** is a canonical ownership map, a canonical proof-debt ledger file, a canonical failure-mode ledger, and a single authoritative scenario-coverage matrix showing what has and has not been observed live.

### Report agreement table

**Note:** standalone Deep Research Reports 1–4 were not present as separate uploaded files. The table below therefore maps findings against the four requested audit scopes using the current source and in-repo Truth Seeker reports.

| Finding | Report 1 | Report 2 | Report 3 | Report 4 | Final decision |
|---|---|---|---|---|---|
| Truth Seeker package is the active authority, not legacy docs | yes | partial | partial | partial | Agree; active authority is cleanly pointed, but historical text still lives inside active controls |
| RUN065R provides limited live proof only for the pre-patch source state | yes | yes | partial | partial | Agree; this is the single most important proof-boundary rule |
| Current source baseline is RUN074R and is live-unproven | yes | yes | yes | yes | Agree |
| Temp/validate/promote publication exists in FileIO | partial | yes | partial | n/a | Agree |
| Low-level write/flush/close outcome checking is still incomplete | partial | yes | n/a | n/a | Agree |
| Current Focus is mirror-only and not a truth owner | partial | partial | yes | partial | Agree |
| L3/L4/L5 now declare support-only boundaries explicitly | partial | partial | yes | yes | Agree |
| Market Board still risks over-claiming authority | partial | yes | yes | yes | Agree; this is not fully resolved |
| Non-zero open-position and pending-order scenarios remain untested live | partial | yes | yes | partial | Agree |
| GlobalTop10 should remain protected from opportunistic edits | partial | yes | yes | partial | Agree |
| Control pack is repetitive and ritualised | yes | partial | partial | partial | Agree |
| Ownership / failure-mode / proof-debt ledgers are still fragmented | yes | yes | yes | yes | Agree |

### What is working

The strongest “do not casually disturb” pieces are these. `ASC_FileIO.mqh` already implements directory creation, temp-path writes, token-contract readback, promote-on-success, continuity fallback, and pair-publication rollback handling. `ASC_Dispatcher.mqh` treats selected-symbol deep publication as a root-first verified write with non-blocking derivative copy-down. `ASC_CurrentFocusWriter.mqh` and its dispatcher helpers guard against same-symbol downgrade. `ASC_SelectionFilter.mqh`, `ASC_ShortlistSelectionEngine.mqh`, and `ASC_DeepSelectiveAnalysisEngine.mqh` now emit explicit `trade_permission=false` and `entry_signal=false` boundaries. The portfolio/history code also respects the basic distinction the MQL5 trade/history APIs make between current positions, current orders, and selected historical records. citeturn3search17turn0search8turn3search3turn3search1turn3search11turn3search5

### What is fragile

The runtime can still publish with “success” semantics that are stronger than the underlying file call guarantees. MQL5 explicitly documents that file opens can fail, that `FileFlush` affects speed when used frequently, and that timer events and trade/history APIs sit on strict boundaries. That means a repo that centralises publication in a careful file layer is doing the right thing in principle, but it also means that **unchecked low-level write results are not a small gap**. They undermine the very seam that later reports are relying on. citeturn3search17turn0search8turn3search9turn3search10turn3search4

### What is false or misleading

The most serious semantic falsehood is local, not academic: `ASC_CORE.MD` says Aurora is “not a trade selector”, yet `ASC_MarketBoardWriter.mqh` still builds an “Operator Command Surface”, emits “Best Pick Now”, and states that ordinary trade-picking authority stays on the Market Board. Even if this is intended as operator guidance rather than automated execution, the wording creates a real contradiction between the system law and the artifact law.

### What is missing

What is missing is not more terminology. It is **singularity**. One canonical proof-debt ledger file is missing. One canonical ownership map is missing. One canonical scenario-coverage table is missing. One canonical failure-mode ledger is missing. Because they are missing, the same truth is distributed across active log history, run reports, version macros, manifest lines, and compile-path constants.

## Master ledgers

The ledger below prioritises flaws the way an architecture review should: by architectural risk, misread risk, adjacency to regression, and cost of continuing debt. That is consistent with SEI guidance on managing technical debt as part of risk and planning, with NASA-style requirements-to-verification thinking, and with AWS operational readiness guidance that checklists should evolve from prior incidents rather than become ceremonial. citeturn1search4turn1search12turn1search5turn1search13turn2search11turn2search19

### Master flaw ledger

| Flaw ID | Domain | Severity | Evidence | Why it matters | Future fix |
|---|---|---:|---|---|---|
| MF-01 | File publication honesty | 5 | `ASC_WriteTextFile` and `ASC_AppendTextFile` only gate on `FileOpen` handle success; they do not inspect write/flush/close outcomes | The repo’s strongest safety story depends on publication truth; unchecked low-level calls can make a “clean” promote chain less honest than it looks | Add explicit outcome capture for write, flush, close, and append paths; propagate reason codes into FunctionResults and manifest summaries |
| MF-02 | System law contradiction | 5 | `ASC_CORE.MD` says “not a trade selector”; `ASC_MarketBoardWriter.mqh` emits “Best Pick Now” and “ordinary trade-picking” authority | This is the clearest source/control contradiction in the repo and can infect roadmap, artifact wording, and future strategy work | Make one law win: either downgrade board wording to advisory-only or explicitly revise the core law |
| MF-03 | Dispatcher monolith | 5 | `ASC_Dispatcher.mqh` is ~11k lines and owns orchestration, selected-symbol sync, manifest logic, top10 batch logic, deep-trigger publication, and more | Large mixed-owner files are hard to audit, easy to regress, and hostile to crisp ownership boundaries | Extract publication state machines and selected-symbol sync helpers without changing logic first |
| MF-04 | Control-pack ritualisation | 4 | Source-only rules, live-proof rules, and handoff rules repeat across README, active log, manifest, acceptance standard, run template, worker guide, and version macros | Repetition increases worker error risk and turns control text into a second maintenance burden | Collapse repeated rules into one canonical control spine and downgrade the rest to references |
| MF-05 | Historical debris inside active controls | 4 | Active docs still contain searchable historical checkpoints such as RUN050/RUN060 acceptance material | Context exists, but so does misread risk; future workers can obey stale text inside “active” files | Move historical acceptance gates into archived annexes or clearly mark them as historical blocks |
| MF-06 | Version-file bloat | 4 | `ASC_Version.mqh` contains roughly 180 historical run macros across many past runs | Version identity has become a report archive; that increases compile-path noise and audit burden | Slim `ASC_Version.mqh` to current identity + current proof checkpoint + minimal preserved constants |
| MF-07 | Proof-debt fragmentation | 4 | Proof classes appear in reports, active log, manifest, constants, and version text, but no single canonical ledger exists | The repo is good at naming proof debt but poor at storing it in one place | Create a canonical proof-debt ledger file and make all other surfaces reference it |
| MF-08 | Scenario coverage gap | 4 | RUN065R reports non-zero open-position and pending-order scenarios as absent/untested; Current Focus selected-symbol mirror can still be runtime-unobserved | The repo carries several truth claims about fail-soft behaviour that remain plausible but unobserved | Add scenario coverage matrix and make RUN076R tests explicitly exercise them |
| MF-09 | Market Board hidden compute risk | 4 | Board writer computes pick, backup, avoid-now, danger-watch, and command commentary beyond mere projection | Projection code is drifting toward decision authority | Move action-authority meaning upstream or explicitly confine board wording to advisory summaries |
| MF-10 | Current Focus naming ambiguity | 3 | `ASC_CURRENT_FOCUS_FILE` is `Dossier.txt`; Current Focus is a mirror role, not a separate file | The naming model is internally coherent but operator-facing semantics are easy to misread | Rename the concept more clearly in controls and manifests or explain the alias once in the front door |
| MF-11 | Runtime state bloat | 3 | `ASC_RuntimeState` carries roughly 287 fields | State sprawl is not automatically broken, but it makes regression harder and ownership blurrier | Split write-lane, top10 batch, and current-focus state into nested structs |
| MF-12 | Failure-mode ledger absent | 3 | Failure handling exists in code, but there is no dedicated failure-mode ledger file | Hidden failure cascades are harder to audit when they are only inferable from code | Add a formal failure-mode ledger after proof debt is centralised |
| MF-13 | Continuity metadata is thin | 3 | Continuity/retained-last-good paths exist, but durable lineage for “what exactly was retained and from when” is weak | Retained output can still be misread as current even when labelled generically | Add explicit retained publication id / previous successful publish UTC / lineage tokens |
| MF-14 | FunctionResults proof remains source-heavy | 3 | RUN074R adds bounded aggregate tokens, but no post-patch live proof exists for the new seam | The repo improved boundedness but not runtime retirement of debt | Verify row presence, line size, and cardinality under live conditions before extending observability further |
| MF-15 | Roadmap lacks a single owner-map file | 3 | Ownership is spread across laws, roadmap, reports, constants, and source comments | Ownership truth is present, but retrieval cost is too high | Add a compact canonical owner-map file before any strategy expansion |

### Master proof-debt ledger

| Proof debt | Status | Evidence | Risk if ignored | Future proof needed |
|---|---|---|---|---|
| Market Board publication and portfolio detail after RUN065R wording/seam patches | pre_patch_live_proven_post_patch_unproven | RUN065R report plus later source-only patches | Later wording/seam edits can be mistakenly treated as already proven | RUN076R board publish + readback + FunctionResults confirmation |
| FunctionResults bounded contradiction proof line | source_patched_live_unproven | RUN074R source only | Aggregate observability may exist in source but not reliably in live output | Live log row presence, bounded size, no spam growth |
| Current Focus selected-symbol mirror closure | source_supported_runtime_unobserved | source guards and RUN073R source-only report | Mirror correctness may be assumed without a selected-symbol live case | Live selected-symbol passive mirror case |
| Same-symbol non-downgrade protection | source_supported_runtime_unobserved | source logic in Current Focus and dispatcher | Future edits can break preservation without obvious compile failure | Live richer-root / poorer-incoming same-symbol case |
| Non-zero open positions scenario | scenario_absent_untested | RUN065R report | Exposure/honesty wording may fail under real active exposure | Live board and dossier proof with actual open positions |
| Non-zero pending orders scenario | scenario_absent_untested | RUN065R report | Future exposure semantics can be misread or mislabeled | Live board and dossier proof with pending orders |
| L3 support-only tokens in runtime output | source_patched_live_unproven | current source tokens | The source improvement may not appear consistently in artifacts/logs | Live FunctionResults + artifact surface proof |
| L4 support-only and exposure/correlation boundaries | source_patched_live_unproven | current source tokens | Rank can still be misread if runtime output does not surface the tokens cleanly | Live board and dossier proof |
| L5 support-only and partial-data boundaries | source_patched_live_unproven | current source tokens | Deep analysis can still look fresher or more decisive than it is | Live Dossier selected-symbol proof with partial and complete data cases |
| Dossier contradiction surface | source_patched_live_unproven | RUN071R+ source | Contradiction taxonomy may exist only on paper | Live selected-symbol dossier with contradiction rows |
| Market Board contradiction surface | source_patched_live_unproven | RUN072R+ source | Board compression may still hide contradictions in runtime | Live board output with mixed evidence |
| GlobalTop10 current/archive family protection after adjacent dispatcher edits | pre_patch_live_proven_post_patch_unproven | RUN065R output + later protected-but-unproven source state | “Untouched” is weaker than “re-proven” when adjacent orchestration changed | RUN076R family current/archive/staging verification |
| FileIO honest outcome reporting | source_supported_runtime_unobserved | FileIO structure exists but lowest-level result checks are incomplete | Repo can continue overstating publish confidence | Live fault-injection or controlled failure evidence after code repair |

### Master contradiction ledger

| Contradiction risk | Surfaces | Current detection | Missing detection | Future fix |
|---|---|---|---|---|
| Core law says not a trade selector, board says Best Pick Now | `ASC_CORE.MD`, Market Board | none formal | semantic contradiction detection absent | Resolve wording/law conflict and add explicit contradiction category |
| Root `Dossier.txt` is Current Focus, but naming implies separate artifact | constants, manifest, operator understanding | partial textual explanation | front-door alias detection missing | Add one canonical alias rule in front-door docs and output manifest |
| Support-only L3/L4/L5 vs board command authority | board, dossier, logs | partial token boundaries | no cross-surface semantic guard | Add artifact-level semantic consistency check |
| Current vs retained-last-good | board, dossier, current focus, manifest | partial continuity labels | lineage depth weak | Add previous-success lineage tokens |
| Current vs archive GlobalTop10 | current family, archive slots, manifest | category-only/advisory | no stronger alignment ledger | Add current/archive family coverage ledger |
| Active exposure vs closed history | board, dossier, portfolio snapshot | token-level split exists | scenario-led live proof absent | Verify with live open, pending, and recent-close states |
| Source-supported vs runtime-observed | reports, manifest, logs, artifacts | strong taxonomy exists | no single debt ledger | Centralise proof classes |
| Source-only controls vs searchable old live checkpoints in active docs | active log, acceptance standard | partial contextual headers | no “historical block” bannering | Archive or hard-label older gates |
| Selected-symbol deeper dossier vs board authority | board, current focus, dossier | text boundary exists | no contradiction if wording drifts later | Add selected-symbol-vs-board semantic guard |
| Publish continuity vs publish success | FunctionResults, manifest, file layer | partial | no low-level IO truth capture | Add explicit write/flush/close/promote outcome fields |

## Protection and disposition

The repo already contains several things that should be protected from opportunistic “improvement”. That is consistent with operational-review practice: a review is supposed to surface actions and guardrails, not turn every audit into a redesign. It is also consistent with single-source-of-truth thinking: derived surfaces should not silently become new owners. citeturn2search19turn2search11turn2search10turn2search2turn2search6

### Protected subsystem table

| Subsystem | Why protected | What must not change | Regression test later |
|---|---|---|---|
| GlobalTop10 current/archive/staging family | It was explicitly protected across RUN065R–RUN074R and already has live evidence in the pre-patch package | Do not alter current/archive family logic, selection, or manifest choreography during unrelated repairs | Family manifest alignment, child count, archive-slot promotion |
| L3 score formula | Current work is about truth meaning, not score redesign | Do not change score weights/thresholds while proof debt is still open | Compare row meaning tokens and candidate ordering |
| L4 ranking and tie-breakers | Same reason; explainability before formula change | Do not change rank order logic during seam repairs | Compare top-ten membership and rank order |
| L5 CopyRates/CopyTicks loop scope and timeframe set | Strategy-edge validity is not proven enough for expansion | Do not expand loops/timeframes while proof debt remains open | Verify partial/full support tokens only |
| Current Focus same-symbol non-downgrade guard | It protects richer same-symbol truth from being overwritten by poorer payloads | Do not remove or weaken same-symbol preservation | Richer-root vs poorer-incoming live case |
| FileIO temp/validate/promote structure | The pattern itself is sound and worth preserving | Do not broad-rewrite publication flow before low-level honesty is repaired | Temp failure, token failure, promote failure, continuity cases |
| HUD consumer-only posture | Core law correctly keeps HUD out of truth ownership | Do not move truth compute into HUD | Static grep and runtime parity checks |
| Portfolio/history semantic split | The open/pending/history distinction is correct in concept | Do not merge closed history into active exposure semantics | Live open+pending+closed mixed-state proof |

### Kill / hold / fix table

| Item | Decision | Reason | Next action |
|---|---|---|---|
| Historical run archive inside active controls | kill | It increases worker misread risk | Split active controls from archive material |
| Repeated source-only rule text across many files | kill | Same rule is maintained in too many places | Consolidate into one canonical rule surface |
| Strategy expansion | hold | Proof debt is too high | No strategy enlargement until RUN076R+ proof closes key debts |
| Formula/rank/selection changes | hold | Current priority is truth honesty, not edge redesign | Freeze until post-proof repair phase |
| GlobalTop10 changes | hold | Protected and not the current failure center | Leave untouched unless live proof falsifies it |
| Broad FileIO rewrite | hold | Existing structure is valuable; only low-level honesty needs first repair | Narrow patch only |
| FileIO low-level outcome capture | fix | Highest-value repair with low conceptual drift | Make it RUN077 after proof |
| Board semantic boundary | fix | Core-law contradiction is too visible to carry | Fix wording/law conflict early |
| Dispatcher decomposition | fix | Auditability and regression risk require it | Extract helpers after proof |
| Canonical proof-debt ledger | fix | Repo has classes but no single ledger | Create one authoritative ledger file |

### Future roadmap repair table

| Roadmap file/section | Problem | Repair needed | Priority |
|---|---|---|---|
| `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | Too large, historical, and searchable in misleading ways | Split into active-head file plus archived historical ledger | critical |
| `TRUTH_SEEKER_ROADMAP.md` | Strong phase spine, but missing canonical owner/proof-debt/failure-mode appendices | Add three appendices: owner map, proof-debt ledger, failure-mode ledger | high |
| `TRUTH_SEEKER_ACCEPTANCE_STANDARD.md` | Historical RUN051–RUN060 gate still lives inside active standard | Move old gates to archived annex; leave only current standards active | high |
| `TRUTH_SEEKER_WORKER_GUIDE.md` | Repeats source-only rules already covered elsewhere | Reduce to execution guidance and references | medium |
| `TRUTH_SEEKER_RUN_TEMPLATE.md` | Carries too much policy text for what should be a template | Slim to required report structure and pointer links | medium |
| `TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | Contains useful rule addendum but not a single scenario coverage matrix | Add scenario coverage / observed-vs-unobserved matrix | high |
| `TRUTH_SEEKER_PHASE_INDEX.md` | Does not foreground owner-map and failure-ledger dependency enough | Insert an explicit “owner-map and failure-ledger before strategy extension” rule | medium |
| Front-door docs (`README.md`, `MASTER_INDEX.md`, `CHAT_CONTINUATION_GUIDE.md`) | They do not explain the `Dossier.txt` Current Focus alias upfront | Add one crisp alias statement | medium |
| Run-report practice | Report quality is high but archive weight is too heavy in active repo | Keep reports, but move old report summaries out of active control surfaces | medium |

### Future code repair table

| Source file/domain | Problem | Repair needed | Risk | Priority |
|---|---|---|---|---|
| `mt5/io/ASC_FileIO.mqh` | Low-level write/flush/close outcomes not checked | Capture and propagate write/flush/close success/failure and append-path truth | low-medium drift, high value | critical |
| `mt5/runtime/ASC_Dispatcher.mqh` | Monolithic orchestration/publication/state logic | Extract publication helper/state-machine modules without logic drift | medium | critical |
| `mt5/artifacts/ASC_MarketBoardWriter.mqh` | Board wording conflicts with core law and risks hidden authority | Reframe command surface or revise core law; keep ordering logic protected | medium | critical |
| `mt5/artifacts/ASC_CurrentFocusWriter.mqh` + dispatcher Current Focus path | Naming and mirror semantics are hard to follow | Clarify alias and mirror contract; preserve same-symbol guard | low | high |
| `mt5/artifacts/dossier/ASC_DossierComposer.mqh` | Selected-symbol richer surface is real but semantically dense | Simplify contradiction/proof boundary wording and retained/current labels | low | high |
| `mt5/logging/ASC_FunctionResults.mqh` | Bounded observability exists but proof debt ledger is externalised | Add one canonical proof-debt reference and runtime verification hooks only after live proof | low | medium |
| `mt5/core/ASC_RuntimeState.mqh` | State sprawl | Break state into nested structs by lane/family | medium | medium |
| `mt5/core/ASC_Constants.mqh` | Alias and contradiction constants are dispersed | Centralise owner/alias/contradiction contract constants | low | medium |
| `mt5/core/ASC_Version.mqh` | Historical macro archive inside compile path | Reduce to current identity + one preserved compatibility block | low | medium |
| Portfolio/history surfaces | Scenario coverage weak, semantics strong | Add explicit scenario counters and live-proof hooks, not new semantics | low | medium |

## Forward plan

The most defensible sequence is **not** “keep patching because the roadmap says so.” It is:

**first** prove the current source honestly,  
**then** repair the two most dangerous seams,  
**then** slim the control pack,  
**then** decide whether any strategy-edge expansion deserves to continue.

That ordering follows both operational-readiness logic and bounded-observability logic: test the live behavior of the exact current state, do not treat source-supported text as runtime proof, and keep logs aggregate enough to remain trustworthy and cheap. citeturn2search11turn2search19turn1search2turn1search10turn0search8turn3search4

### Next 10 code-edit run plan

**Assumption:** these runs begin **after** a non-edit RUN076R proof checkpoint.

| Run | Purpose | Files/domains | Acceptance criteria | Forbidden drift |
|---|---|---|---|---|
| RUN077 | FileIO outcome honesty | `ASC_FileIO.mqh`, narrow callsites | Write/flush/close/append outcomes captured; continuity vs failure honest; no publish-flow redesign | no new artifact family, no board/HUD/rank logic change |
| RUN078 | Dispatcher decomposition phase 1 | `ASC_Dispatcher.mqh`, helper extracts | Publication helper extraction complete; signatures stable; no path drift | no new timer/lane, no logic rewrite |
| RUN079 | Board semantic boundary repair | `ASC_MarketBoardWriter.mqh`, `ASC_CORE.MD` or equivalent law source | “Best Pick” semantics no longer contradict core law | no rank formula or top10 membership change |
| RUN080 | Current Focus / root Dossier alias cleanup | front-door docs, constants, Current Focus helpers | Alias explained once and consistently; mirror-only role preserved | no selected-symbol flow redesign |
| RUN081 | Canonical proof-debt ledger introduction | roadmap/control package, manifest references | One authoritative ledger file exists and is referenced everywhere else | no history purge that loses evidence |
| RUN082 | Ownership and contradiction registry centralisation | constants/types/control package | One compact owner map and contradiction registry created | no new strategy logic |
| RUN083 | Continuity / retained-last-good lineage hardening | FileIO + artifact headers + manifest | Retained output clearly shows prior publication lineage | no broad publication rewrite |
| RUN084 | FunctionResults budget hardening after proof feedback | logging + dispatcher finish detail only if RUN076R shows need | Aggregate-only observability preserved; churn reduced if needed | no per-symbol/per-trade expansion |
| RUN085 | Active control-pack slimming | active log, acceptance, template, worker guide, version | Historical material moved out of active control spine | no truth deletion from archive |
| RUN086 | Post-proof strategy gate preparation | roadmap/control only | Strategy work remains blocked unless proof debt closure criteria satisfied | no indicator/strategy formula implementation |

### Future live proof plan

| Proof domain | What to test | Required output | Pass condition | Fail condition |
|---|---|---|---|---|
| File publication atomicity | temp write, readback validate, promote, continuity paths | FunctionResults rows + artifact timestamps + manifest state | All outcomes classified honestly; no false success | Any failed write still looks like clean publish |
| Market Board baseline publish | normal board generation | `Market Board.txt`, manifest, FunctionResults | Fresh board exists; minimum skeleton valid; publish status matches log | Missing board or mismatched status |
| Market Board with open positions | active exposure case | Board + portfolio section + log rows | Open positions shown as active exposure only | Closed history or pending orders are conflated with active exposure |
| Market Board with pending orders | future exposure case | Board + portfolio section + log rows | Pending orders shown as future exposure only | Pending orders disappear into history or active exposure text |
| Current Focus passive mirror | selected-symbol no-deep case | root `Dossier.txt` mirror output + readback verification | Same-symbol mirror works; no cross-symbol overwrite | Missing root, wrong symbol, or downgrade overwrite |
| Deep-trigger selected-symbol write | selected-symbol deep case | root dossier + support copy-down + readback | Root verified; support copy-down failure is non-blocking and logged honestly | Root not verified or support failure blocks survival |
| GlobalTop10 current/archive/staging | family currentness and archive slot behaviour | current children, archive slots, family manifest | Family alignment preserved; no count drift | Missing current child, archive mismatch, or stale manifest |
| L3/L4/L5 support-only boundaries | live runtime projection | FunctionResults + Market Board + Dossier | `trade_permission=false` / `entry_signal=false` survive to outputs | Support-only tokens disappear or are contradicted by wording |
| Continuity / retained-last-good labelling | stale or failed publish case | artifact headers + manifest + logs | Retained output clearly labelled with lineage | Retained output looks current/clean |
| Log boundedness | FunctionResults + heartbeat | file sizes, row counts, aggregate proof lines | Aggregate outputs remain bounded and comprehensible | High-cardinality or explosive growth returns |

### Prompt-seed table

| Next actual code run | Must read first | Must fix | Must not touch | Acceptance criteria |
|---|---|---|---|---|
| RUN077 | this final audit; RUN074R report; `ASC_FileIO.mqh`; manifest | low-level write/flush/close honesty | GlobalTop10, rank/score, board ordering, HUD | file outcome truth is explicit and compile-safe |
| RUN078 | RUN076R proof results; dispatcher publication helpers | dispatcher decomposition only | timer cadence, lane policy, strategy logic | helper extraction with logic parity |
| RUN079 | this final audit; `ASC_CORE.MD`; `ASC_MarketBoardWriter.mqh` | board/core semantic contradiction | formulas, selection logic, Top10 membership | no law contradiction remains |
| RUN080 | front door docs; constants; Current Focus helpers | Dossier/Current Focus alias clarity | same-symbol guard and mirror role | alias is unambiguous and mirror-only boundary preserved |

### The exact next prompt seed after the audit series

The immediate next prompt should be a **non-edit proof run**, not another speculative patch run.

```text
RUN076R — LIVE PROOF CHECKPOINT / WHOLE-SYSTEM PROOF-DEBT RETIREMENT TEST

THIS IS A LIVE PROOF RUN.
THIS IS NOT A ROADMAP REDESIGN RUN.
DO NOT BROADEN SOURCE.
DO NOT PATCH UNLESS A FRESH COMPILE OR OUTPUT FAILURE FORCES A NARROW REPAIR.
DO NOT CLAIM PROOF FOR ANY SOURCE STATE OTHER THAN THE EXACT CURRENT SOURCE PACKAGE SUPPLIED.

PURPOSE:
Prove or falsify the current RUN074R source state after the 5-report audit series.

MUST READ FIRST:
- Final synthesis audit report from the 5-report series
- roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md
- roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md
- roadmap/Truth Seeker/TRUTH_SEEKER_RUN065R_REPORT.md
- roadmap/Truth Seeker/TRUTH_SEEKER_RUN071R_REPORT.md
- roadmap/Truth Seeker/TRUTH_SEEKER_RUN072R_REPORT.md
- roadmap/Truth Seeker/TRUTH_SEEKER_RUN073R_REPORT.md
- roadmap/Truth Seeker/TRUTH_SEEKER_RUN074R_REPORT.md
- mt5/io/ASC_FileIO.mqh
- mt5/runtime/ASC_Dispatcher.mqh
- mt5/artifacts/ASC_MarketBoardWriter.mqh
- mt5/artifacts/ASC_CurrentFocusWriter.mqh
- mt5/artifacts/dossier/ASC_DossierComposer.mqh
- mt5/logging/ASC_FunctionResults.mqh
- mt5/core/ASC_Version.mqh

REQUIRED INPUTS:
- Full current Aurora Sentinel Core zip
- MetaEditor compile output for the exact current source
- Fresh runtime output package from the exact current source
- FunctionResults log
- Heartbeat telemetry log
- Market Board.txt
- Artifact Bundle Manifest.txt
- Dossier.txt if selected symbol exists
- GlobalTop10 current + archive family outputs

PRIMARY QUESTIONS:
1. Does the exact current source compile cleanly?
2. Does FileIO publication behave honestly under runtime observation?
3. Does Market Board still publish cleanly?
4. Are non-zero open-position and pending-order scenarios now observable?
5. Does Current Focus passive mirror work when selected symbol exists?
6. Does deep-trigger selected-symbol publication verify root truth and preserve non-blocking support copy-down?
7. Do L3/L4/L5 support-only boundaries survive to live outputs?
8. Does FunctionResults emit the RUN074R bounded contradiction/proof line without spam regression?
9. Are retained/continuity cases clearly labelled?
10. Is GlobalTop10 current/archive/staging still aligned?

MANDATORY RULES:
- If compile or runtime falsifies a seam, record the exact failure and stop broad redesign.
- If a narrow source repair is unavoidable, isolate it and classify all proof as pre-patch-only.
- Do not reopen formulas, ranking, Top10 selection, HUD, strategy logic, or broad FileIO redesign.

REQUIRED TABLES:
- Compile proof table
- Publication truth table
- Market Board proof table
- Non-zero open exposure table
- Non-zero pending exposure table
- Current Focus mirror table
- Deep-trigger pair proof table
- GlobalTop10 family alignment table
- FunctionResults boundedness table
- Retained/continuity table
- Proof-debt retirement table

FINAL OUTPUT:
- Executive verdict
- Proven now
- Still unproven
- Falsified seams
- Narrow repair needed or not
- Exact next code-edit prompt seed if repair is needed
```

### Open questions and limitations

The final synthesis is high confidence on architecture, control, ownership, proof-debt, and publication-seam findings. It is lower confidence on any claim that would require the missing standalone Deep Research Reports 1–4 or fresh compile/runtime proof for the exact RUN074R tree. The largest unresolved question is therefore simple: **does the exact current source actually behave as honestly as its latest proof language says it should?** Until RUN076R, that question remains open.