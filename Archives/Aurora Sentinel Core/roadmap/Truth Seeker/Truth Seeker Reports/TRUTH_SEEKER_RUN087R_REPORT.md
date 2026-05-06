RUN087R STATUS:
Artifact freshness/currentness/staging/archive/retained truth hardening source patch run. Next live test is RUN090R.

CURRENT BASELINE:
RUN059 / commit 796a8b6 plus RUN060R through RUN086R patched source/control and RUN080R live evidence is the active authority unless current source proves otherwise.

RUN086R RESULT TO VERIFY:
RUN086R consolidated RUN090 proof surfaces through Scanner Status and FunctionResults aggregate proof. RUN087R must preserve those proof surfaces while strengthening artifact freshness/currentness truth so file existence cannot be mistaken for current promoted proof.

RUN087R PURPOSE:
Patch the smallest lawful source owner paths so major artifacts and aggregate proof surfaces clearly distinguish current/promoted/written-by-run from staging/archive/retained/stale/degraded states, without FileIO rewrite, FunctionResults spam, rank/order/formula changes, or strategy logic.

PROOF BOUNDARY:
RUN087R is source-patched-live-unproven until RUN090R or later. Do not claim compile/live/runtime/output proof.

```text
GIT HEADER SUMMARY
TRUTH SEEKER ROADMAP — RUN087R / SOURCE PATCH — ARTIFACT FRESHNESS + CURRENTNESS + STAGING/ARCHIVE/RETAINED TRUTH HARDENING BEFORE RUN090
RUN TYPE: SOURCE PATCH / CONTROL UPDATE
NEXT LIVE TEST: RUN090R
PROOF BOUNDARY: source_patched_live_unproven
COMPILE CLAIM: not claimed
LIVE CLAIM: not claimed
OUTPUT CLAIM: not claimed
PATCHED: shared artifact freshness boundary helper, Scanner Status RUN090 dashboard, FunctionResults aggregate proof helper, version/control/report files
PROTECTED: FileIO, HUD, GlobalTop10 rank/order/formula, L3 score, L4 rank/order, Market Board order, FunctionResults schema/cardinality, strategy/execution
```

## SOURCE / ROADMAP INTAKE TABLE

| Check | Result | Evidence path | Decision |
|---|---|---|---|
| Source package found | yes | `Aurora Sentinel Core(329).zip` extracted to repo root | continue |
| Compile root found | yes | `mt5/AuroraSentinelCore.mq5` | continue |
| RUN086R report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN086R_REPORT.md` | continue |
| RUN086R patched source verified | yes | `ASC_ScannerStatusWriter.mqh`, `ASC_FunctionResults.mqh`, `ASC_Version.mqh` | continue |
| RUN085R report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN085R_REPORT.md` | continue |
| RUN084R report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN084R_REPORT.md` | continue |
| RUN083R report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN083R_REPORT.md` | continue |
| RUN082R report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN082R_REPORT.md` | continue |
| RUN080R live failure evidence found | partial | active log/deep reports preserve RUN080 live failure evidence; standalone RUN080R report not present | use as repair authority |
| roadmap(7) package found | yes | `roadmap/Truth Seeker/` control package | continue |
| Active phase identified | yes | Campaign1 foundation/proof-contract lane toward RUN090R | continue |
| Version found | yes | `mt5/core/ASC_Version.mqh` | inspect/patch identity helpers |
| Dispatcher found | yes | `mt5/runtime/ASC_Dispatcher.mqh` | inspect/protect |
| RuntimeState found | yes | `mt5/core/ASC_RuntimeState.mqh` | inspect/protect |
| Scanner Status writer found | yes | `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | patched freshness proof |
| FunctionResults owner found | yes | `mt5/logging/ASC_FunctionResults.mqh` | patched aggregate only |
| Market Board writer found | yes | `mt5/artifacts/ASC_MarketBoardWriter.mqh` | protected; inherits shared boundary line |
| GlobalTop10 owner found | yes | `mt5/runtime/ASC_Dispatcher.mqh` | protected; inherits shared boundary line |
| DossierWriter found | yes | `mt5/artifacts/ASC_DossierWriter.mqh` | protected |
| DossierComposer found | yes | `mt5/artifacts/dossier/ASC_DossierComposer.mqh` | protected |
| CurrentFocus/mirror path found | yes | `mt5/artifacts/ASC_CurrentFocusWriter.mqh`, `ASC_Dispatcher.mqh` | protected; mirror boundary preserved |
| FileIO found | yes | `mt5/io/ASC_FileIO.mqh` | read-only/protect |
| HUD found | yes | `mt5/hud/` | read-only/protect |

## INTERNET RESEARCH CONVERSION TABLE

| Research item | Finding | Source repair constraint | Patch/check target | RUN090 acceptance test | Forbidden misuse |
|---|---|---|---|---|---|
| Official MQL5 file APIs | `FileIsExist` only checks existence; `FileFlush` writes buffered data but frequent flushing may affect speed; `FileMove` moves/renames a file. | Never equate file existence, non-empty file, or moved file with freshness/currentness unless source run and promoted/current boundary are present. | Shared freshness helper, Scanner Status, FunctionResults | grep `file_exists_is_fresh_current_promoted_proof=false` and `current_requires_written_by_run_and_promoted=true` | no FileIO rewrite; no flush churn increase |
| Official MQL5 timer APIs | Timer events are queue-based and not added if an existing Timer event is already queued/processing; OnTimer frequency can increase test/runtime load. | Freshness proof must remain cheap metadata, not a heavy new timer lane. | Scanner Status dashboard and aggregate FunctionResults only | one compact proof dashboard; no new runtime lane | no blocking loop, no heavy OnTimer work |
| Artifact publication / provenance | Provenance should bind artifact identity, source run, schema, currentness, and lifecycle state. | Current output must say whether it is promoted/current, staging, archive, retained, stale, degraded, or fallback. | `ASC_ArtifactIdentityLine` / new freshness boundary helper | grep taxonomy tokens from major artifact families | no fake source hash or compile hash |
| Risk-based smoke testing | Smoke tests should target high-risk proof debts first. | RUN090 needs stable grep tokens, not manual guessing. | Scanner Status required token list | required token validation includes exact freshness states | no strategy/library expansion before proof |
| Observability cardinality | Useful observability explains system state from telemetry, but high cardinality should stay bounded. | FunctionResults must remain aggregate-only, no per-symbol/per-timeframe proof spam. | `ASC_FunctionResultsRun090AggregateProofTokens` | single aggregate proof string includes taxonomy | no schema drift or row spam |

## RUN086R FINISH-STATE VERIFICATION TABLE

| RUN086R finish item | Present? | Gap? | RUN087R patch decision |
|---|---:|---|---|
| Scanner Status contains RUN090 Proof Dashboard | yes | exact taxonomy incomplete | patched |
| Scanner Status exposes source_run_id | yes | no | preserved |
| Scanner Status exposes deep hydration counts | yes | no | preserved |
| Scanner Status exposes dossier queue proof | yes | no | preserved |
| Scanner Status exposes alignment signatures | yes | no | preserved |
| Scanner Status exposes artifact_freshness_status | yes | status vocabulary too narrow | patched |
| Scanner Status says file exists is not proof | yes | no | preserved |
| FunctionResults aggregate helper exists | yes | exact taxonomy incomplete | patched aggregate only |
| FunctionResults schema stable | yes | no schema patch needed | protected |
| FunctionResults avoids per-symbol/per-trade/per-timeframe spam | yes | no | protected |
| RUN085 identity helpers preserved | yes | version identity updated to RUN087R with same helper shape | preserved |
| RUN084 alignment proof preserved | yes | no | protected |
| RUN083 queue proof preserved | yes | no | protected |
| RUN082 deferred L5 labels preserved | yes | no | protected |
| FileIO/HUD/formula/rank/order/strategy untouched | yes | no | protected |
| RUN086R remains source_patched_live_unproven | yes | now superseded by RUN087R source_patched_live_unproven | patched version boundary |

## FRESHNESS / CURRENTNESS OWNER MAP TABLE

| Artifact family | Owner file/function | Current freshness/currentness proof | Gap | Patch decision |
|---|---|---|---|---|
| Scanner Status | `ASC_ScannerStatusWriter.mqh` / `ASC_Run090ScannerProofDashboard` | RUN090 dashboard | exact taxonomy incomplete | patched |
| FunctionResults aggregate | `ASC_FunctionResults.mqh` / `ASC_FunctionResultsRun090AggregateProofTokens` | aggregate proof string | exact taxonomy incomplete | patched |
| GlobalTop10 family manifest | `ASC_Dispatcher.mqh` / `ASC_Top10RunFullBuildFamilyManifest` | `ASC_ArtifactIdentityLine` | shared line lacked full taxonomy | patched via shared helper |
| GlobalTop10 children | `ASC_Dispatcher.mqh` child writer | `ASC_ArtifactIdentityLine` | shared line lacked full taxonomy | patched via shared helper |
| Market Board | `ASC_MarketBoardWriter.mqh` | `ASC_ArtifactIdentityLine` | shared line lacked full taxonomy | patched via shared helper |
| Dossier | top header section | `ASC_ArtifactIdentityLine` | shared line lacked full taxonomy | patched via shared helper |
| Current Focus / selected-symbol Dossier mirror | Dossier payload + CurrentFocus mirror gate | mirror/truth-owner tokens | exact freshness inherited from dossier top header | protected + shared helper |
| Output package manifest/control | roadmap manifest | manifest lists package members | package-state honesty needed | patched addendum |

## FRESHNESS TAXONOMY TABLE

| State | Meaning | Required label | Forbidden misuse |
|---|---|---|---|
| file exists | path observed only | `file_exists_only` | cannot prove current/fresh/promoted |
| non-empty | bytes exist only | `non_empty_unproven` | cannot prove freshness |
| written-by-run | source run token present | `written_by_current_run` | cannot prove promotion alone |
| promoted current | written-by-run + promoted/current boundary | `promoted_current` | cannot be archive/staging/retained/stale |
| runtime current unproven | source supports currentness but no live output proof yet | `current_runtime_unproven` | cannot close proof debt |
| staging | pre-promotion output | `staging_not_current` | cannot be treated as promoted |
| archive | historical evidence | `archive_historical_only` | cannot be live proof |
| retained last-good | useful continuity artifact | `retained_last_good_not_current` | cannot be newly written current |
| stale | old/mismatched artifact | `stale_not_current` | cannot be current |
| degraded current | current but incomplete/degraded | `degraded_current` | cannot be called complete |
| continuity fallback | last-good fallback | `continuity_fallback` | cannot be new current |
| missing | no artifact | `missing` | cannot be proof |
| no selected symbol | not a failure alone | `selected_symbol_none_not_failure` | cannot imply Current Focus truth exists |

## ARTIFACT FAMILY FRESHNESS TABLE

| Artifact family | Freshness/currentness fields | Owner | RUN090 evidence |
|---|---|---|---|
| Scanner Status | `artifact_freshness_status`, taxonomy, false-boundary tokens | `ASC_ScannerStatusWriter.mqh` | grep dashboard |
| FunctionResults | same taxonomy in aggregate helper | `ASC_FunctionResults.mqh` | grep aggregate detail |
| GlobalTop10 family | shared Artifact Freshness line | `ASC_Dispatcher.mqh` via version helper | grep family manifest |
| GlobalTop10 children | shared Artifact Freshness line | `ASC_Dispatcher.mqh` via version helper | grep child payload |
| Market Board | shared Artifact Freshness line | `ASC_MarketBoardWriter.mqh` via version helper | grep board |
| Dossier | shared Artifact Freshness line in top header | dossier top header via version helper | grep dossier |
| Current Focus | selected-symbol Dossier mirror payload, not truth owner | dispatcher/current focus mirror path | grep root dossier/current focus |

## RETAINED / STALE / STAGING / ARCHIVE BOUNDARY TABLE

| Boundary | Required source behavior | RUN090 evidence |
|---|---|---|
| File exists | existence is not freshness/currentness/promoted proof | `file_exists_is_fresh_current_promoted_proof=false` |
| Current | requires source run + promoted/current state | `current_requires_written_by_run_and_promoted=true` |
| Retained | last-good continuity only | `retained_last_good_not_current` |
| Stale | not current | `stale_not_current` |
| Staging | not promoted | `staging_not_current` |
| Archive | historical only | `archive_historical_only` |
| Degraded | current only with degraded label | `degraded_current` |
| Continuity fallback | retained fallback, not new current | `continuity_fallback` |

## FUNCTIONRESULTS / SCANNER STATUS EVIDENCE TABLE

| Evidence token | Current behavior | Patch decision | Spam risk |
|---|---|---|---|
| `run090_functionresults_aggregate_proof=present` | one aggregate proof string | preserved | low |
| `artifact_freshness_status=` | emitted | widened exact taxonomy | low |
| `freshness_taxonomy=` | added | chosen | low |
| `promoted_current` | added | chosen | low |
| `staging_not_current` | added | chosen | low |
| `archive_historical_only` | added | chosen | low |
| `retained_last_good_not_current` | added | chosen | low |
| `stale_not_current` | added | chosen | low |
| `degraded_current` | added | chosen | low |
| `functionresults_rows_added=false` | preserved | protected | low |
| `per_symbol_rows=false` | preserved | protected | low |

## CURRENT FOCUS / SELECTED-SYMBOL DOSSIER MIRROR TABLE

| Condition | Required truth | Evidence | Patch decision |
|---|---|---|---|
| no selected symbol | not a failure by itself | `selected_symbol_none_not_failure` | preserved |
| selected symbol exists | Current Focus mirrors selected-symbol Dossier truth | `selected_symbol_dossier_mirror=true` | preserved |
| Current Focus payload exists | not independent truth owner | `current_focus_truth_owner=false` | preserved |
| retained focus payload | retained, not new current | shared freshness boundary + mirror status | patched via shared helper |
| stale/mismatched symbol | not current | existing downgrade gates + freshness tokens | protected |

## RUN086 / RUN085 / RUN084 / RUN083 / RUN082 REGRESSION GUARD TABLE

| Prior repair | Still intact? | Evidence |
|---|---:|---|
| RUN086 proof dashboard | yes | `RUN090 Proof Dashboard` preserved |
| RUN085 identity | yes | `source_run_id`, `source_identity_token`, `artifact_written_by_run`, `artifact_schema_version`, `build_identity_present` preserved |
| RUN084 alignment | yes | `alignment_status`, `board_signature`, `derived_from_board_signature`, `stale_current_guard` preserved |
| RUN083 queue | yes | `dossier_queue_state`, `cursor`, `backlog`, `stall`, `recovered` preserved |
| RUN082 deferred L5 | yes | `deep_hydration_pending/expired/retry_exhausted/completed` preserved |

## PROTECTED FORMULA / ORDER DRIFT TABLE

| Protected area | Touched? | Drift? | Evidence |
|---|---:|---:|---|
| GlobalTop10 formula | no | no | no ranking/scoring files changed |
| L3 score | no | no | `ASC_SelectionFilter.mqh` untouched |
| L4 rank/order | no | no | shortlist files untouched |
| Market Board order | no | no | no rank/order logic edit |
| FileIO | no | no | `ASC_FileIO.mqh` untouched |
| HUD | no | no | `mt5/hud/` untouched |
| FunctionResults schema/spam | no schema edit | no | helper string only; no row/schema constants changed |
| Strategy/execution | no | no | semi-auto/strategy/execution untouched |

## PATCH CANDIDATE MATRIX

| File | Candidate patch | Why needed | Risk | Chosen/rejected |
|---|---|---|---|---|
| `ASC_Version.mqh` | shared artifact freshness helper + RUN087R identity | touches all major artifacts through existing identity line | low, metadata text only | chosen |
| `ASC_ScannerStatusWriter.mqh` | exact taxonomy in RUN090 dashboard + required tokens | RUN090 grep pack needed | low | chosen |
| `ASC_FunctionResults.mqh` | exact taxonomy in aggregate helper | aggregate proof needed without spam | low | chosen |
| `ASC_Dispatcher.mqh` | direct Top10 manifest edit | inherited by helper; direct edit not needed | medium | rejected |
| `ASC_MarketBoardWriter.mqh` | direct board line edit | inherited by helper; avoid order risk | medium | rejected |
| `ASC_DossierComposer.mqh` | direct dossier redesign | not needed | medium | rejected |
| `ASC_CurrentFocusWriter.mqh` | direct mirror write edit | not needed; mirror boundary already present | medium | rejected |
| `ASC_FileIO.mqh` | publication rewrite | forbidden and unnecessary | high | rejected |
| HUD | surface edit | forbidden | high | rejected |

## PATCH TABLE

| File | Function/area | Patch made | Why truthful | Compile-risk note |
|---|---|---|---|---|
| `mt5/core/ASC_Version.mqh` | version macros | RUN087R identity and proof boundary | source identity now matches patch run | macro/string only |
| `mt5/core/ASC_Version.mqh` | `ASC_ArtifactFreshnessStatusFromState` | maps artifact lifecycle state to exact taxonomy | prevents existence/staging/archive/retained/stale ambiguity | string helper only |
| `mt5/core/ASC_Version.mqh` | `ASC_ArtifactFreshnessBoundaryLine` | emits required boundary tokens | one shared line reaches major artifacts | no runtime heavy work |
| `mt5/core/ASC_Version.mqh` | `ASC_ArtifactIdentityLine` | appends freshness line after identity line | preserves existing callers and adds truth boundary | newline string append |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | `ASC_Run090ArtifactFreshnessStatus` | returns exact taxonomy labels | RUN090 can grep clear states | string-only |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | dashboard + required tokens | added taxonomy and exact required tokens | dashboard cannot publish without the grep pack | fixed-size token array updated |
| `mt5/logging/ASC_FunctionResults.mqh` | aggregate proof helper | added exact taxonomy and boundary tokens | aggregate-only observability | no schema/row change |
| `TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | top entry | recorded RUN087R | control truth current | docs only |
| `TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | addendum | recorded changed files and package honesty | manifest cannot imply runtime currentness by file listing | docs only |
| `TRUTH_SEEKER_RUN087R_REPORT.md` | report | created run report | audit/proof continuity | docs only |

## STATIC COMPILE-SAFETY TABLE

| Check | Result | Evidence |
|---|---|---|
| Compile root exists | pass | `mt5/AuroraSentinelCore.mq5` |
| Helper includes available | pass | affected files include `ASC_Version.mqh` directly/indirectly |
| Fixed required token array size updated | pass | Scanner Status array changed 22 -> 30 |
| No FileIO edit | pass | `ASC_FileIO.mqh` unchanged |
| No HUD edit | pass | `mt5/hud/` unchanged |
| No formula/order/rank edit | pass | ranking/selection files unchanged |
| Compile proof claimed | no | not claimed |
| Live proof claimed | no | not claimed |

## PROOF-DEBT UPDATE TABLE

| Proof item | Before RUN087R | After RUN087R | RUN090 proof action |
|---|---|---|---|
| file existence boundary | present but narrow | explicit taxonomy and false proof line | grep Scanner Status/FunctionResults/artifacts |
| promoted current | ambiguous label variants | `promoted_current` exact token | grep |
| staging/archive/retained/stale/degraded | incomplete exact tokens | exact tokens present | grep |
| Current Focus mirror | mirror boundary present | preserved | verify selected-symbol mirror payload |
| compile | unproven | unproven | MetaEditor compile in RUN090 |
| live runtime | unproven | unproven | RUN090 live |
| output package | unproven | unproven | RUN090 output bundle proof |

## NEXT_PROMPT_SEED TABLE

| Next run | Must read first | Primary target | Known proof debt | Must not do |
|---|---|---|---|---|
| RUN088R | RUN087R report + changed source | continue remaining proof-surface gaps only if static gaps remain | no compile/live/output proof yet | no formula/rank/order/FileIO/HUD/strategy drift |
| RUN089R | RUN088R/RUN087R reports | final pre-RUN090 hardening only | source still live-unproven | no expansion |
| RUN090R | RUN087R-RUN089R reports + fresh live output | compile/runtime/output proof checkpoint | heartbeat, artifacts, freshness/currentness | no source proof claims without actual fresh output |

## FINAL DECISION TABLE

| Item | Decision |
|---|---|
| RUN087R decision | PASS |
| Source patch | yes |
| Office/control update | yes |
| Compile proof | not claimed |
| Live proof | not claimed |
| Output proof | not claimed |
| Changed-files zip | required |
| Next live checkpoint | RUN090R |

```text
FINAL SUMMARY
RUN:
RUN087R

DECISION:
PASS — source/control patch completed; live/compile/output proof deferred to RUN090R.

RUN TYPE:
- code edit: yes
- live output requested: no
- compile/live proof claimed: no
- next live checkpoint: RUN090R

RUN086R ABSORPTION:
- RUN086R report read: yes
- RUN086R patched source verified: yes
- proof dashboard preserved: yes
- aggregate FunctionResults preserved: yes
- remaining proof debt: MetaEditor compile, live runtime, fresh output package, and RUN090 grep proof

FRESHNESS / CURRENTNESS VERDICT:
- file exists: file_exists_only; not proof
- non-empty: non_empty_unproven; not proof
- written-by-run: written_by_current_run; required but not sufficient alone
- promoted current: promoted_current; requires written-by-run and promoted/current state
- staging: staging_not_current
- archive: archive_historical_only
- retained: retained_last_good_not_current
- stale: stale_not_current
- degraded current: degraded_current
- continuity fallback: continuity_fallback; not new current

ARTIFACT FAMILY VERDICT:
- Scanner Status: patched exact taxonomy and required tokens
- FunctionResults: patched aggregate-only taxonomy; no schema/row spam
- GlobalTop10 family: inherits shared Artifact Freshness line
- GlobalTop10 children: inherits shared Artifact Freshness line
- Market Board: inherits shared Artifact Freshness line; order untouched
- Dossier: inherits shared Artifact Freshness line in top header
- Current Focus: remains selected-symbol Dossier mirror, not truth owner

REGRESSION VERDICT:
- RUN086 proof dashboard: preserved
- RUN085 identity: preserved with RUN087R current identity
- RUN084 alignment: preserved
- RUN083 queue: preserved
- RUN082 deferred L5: preserved
- FunctionResults spam: no new rows/schema
- formula/order drift: none

PROTECTED AREAS:
- GlobalTop10 formula: untouched
- L3 score: untouched
- L4 rank/order: untouched
- Market Board order: untouched
- FileIO: untouched
- HUD: untouched
- FunctionResults schema/spam: untouched
- strategy/execution: untouched

PATCHES:
- ASC_Version.mqh / identity helpers — added shared freshness/currentness taxonomy boundary — behavior drift metadata only
- ASC_ScannerStatusWriter.mqh / RUN090 dashboard — added exact grep tokens and required token validation — behavior drift metadata only
- ASC_FunctionResults.mqh / aggregate proof helper — added exact freshness/currentness taxonomy to aggregate detail — behavior drift metadata only
- roadmap control/report files — updated RUN087R source/control truth — behavior drift none

PROOF STATUS:
- Source: patched
- Static compile-safety: inspected only
- Compile: not claimed
- Live: not claimed
- Output: not claimed
- Post-patch proof: source_patched_live_unproven until RUN090R

NEXT_PROMPT_SEED:
- next run: RUN088R
- first files/output to read: RUN087R report, ASC_Version.mqh, ASC_ScannerStatusWriter.mqh, ASC_FunctionResults.mqh, output package manifest
- primary target: remaining pre-RUN090 proof-surface gaps only if static source gap remains
- proof debt to preserve: no compile/live/output proof yet; RUN090 must prove freshness/currentness from fresh output
- forbidden drift: formula/rank/order/FileIO/HUD/strategy/FunctionResults schema spam

ZIP:
changed-files zip produced by worker package step
```
