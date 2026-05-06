RUN085R STATUS:
Build/source/artifact identity proof hardening source patch run. Next live test is RUN090R.

CURRENT BASELINE:
RUN059 / commit 796a8b6 plus RUN060R through RUN084R patched source/control and RUN080R live evidence is the active authority unless current source proves otherwise.

RUN084R RESULT TO VERIFY:
RUN084R added Market Board / GlobalTop10 alignment signature proof and stale-current guard labels. RUN085R preserves that alignment proof while strengthening source/build/artifact identity across the main output families.

RUN085R PURPOSE:
Patch the smallest lawful source owner paths so GlobalTop10, Market Board, Dossier, Scanner Status, and FunctionResults expose compact source/run/artifact identity proof for RUN090, without broad manifest rewrite, FileIO rewrite, formula/rank/order drift, or log spam.

PROOF BOUNDARY:
RUN085R is source-patched-live-unproven until RUN090R or later. Do not claim compile/live/runtime/output proof.

## SOURCE / ROADMAP INTAKE TABLE

| Check | Result | Evidence path | Decision |
|---|---|---|---|
| Source package found | yes | `/mnt/data/Aurora Sentinel Core(327).zip` | continue |
| Compile root found | yes | `mt5/AuroraSentinelCore.mq5` | continue |
| RUN084R report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN084R_REPORT.md` | continue |
| RUN084R patched source verified | yes | `ASC_Dispatcher.mqh`, `ASC_ScannerStatusWriter.mqh`, `ASC_Version.mqh` | continue |
| RUN083R report found | yes | `roadmap/Truth Seeker/TRUTH_SEEKER_RUN083R_REPORT.md` | continue |
| RUN080R live failure evidence found | partial | operator header pasted evidence; no report file in package | use as repair authority |
| roadmap(7) package found | yes | `roadmap/Truth Seeker/*` | continue |
| Active phase identified | yes | Campaign1 foundation/proof-contract lane | continue |
| Dispatcher found | yes | `mt5/runtime/ASC_Dispatcher.mqh` | patched identity only |
| Version found | yes | `mt5/core/ASC_Version.mqh` | patched identity owner |
| Market Board writer found | yes | `mt5/artifacts/ASC_MarketBoardWriter.mqh` | patched identity only |
| GlobalTop10 owner found | yes | `mt5/runtime/ASC_Dispatcher.mqh` | patched identity only |
| Scanner Status writer found | yes | `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | patched identity only |
| DossierWriter found | yes | `mt5/artifacts/ASC_DossierWriter.mqh` | inspected, no direct patch needed |
| DossierComposer found | yes | `mt5/artifacts/dossier/ASC_DossierComposer.mqh`, top header section | patched alias wording and top-header identity |
| Selected-symbol Dossier legacy alias writer found | yes | `mt5/artifacts/ASC_CurrentFocusWriter.mqh` | treated as backward-compatible alias only; no independent artifact assumption |
| FunctionResults owner found | yes | `mt5/logging/ASC_FunctionResults.mqh` | patched aggregate identity only |
| FileIO found | yes | `mt5/io/ASC_FileIO.mqh` | read-only/protected |
| HUD found | yes | `mt5/hud/ASC_HUD_Manager.mqh` | read-only/protected |

## INTERNET RESEARCH CONVERSION TABLE

| Research item | Finding | Source repair constraint | Patch/check target | RUN090 acceptance test | Forbidden misuse |
|---|---|---|---|---|---|
| MQL5 OnTimer / EventSetTimer | Timer events belong to the EA timer and are expected to be set from init-style paths; heavy work inside timer cadence risks heartbeat starvation. | Identity proof must be precomposed cheap text only; no new runtime lane/timer workload. | `ASC_Version.mqh`, existing writers only | grep identity tokens without heartbeat lane change | no heavy CopyRates/CopyTicks or blocking loop |
| MQL5 FileOpen / FileFlush / FileMove | File APIs already define sandboxed open/move behavior; FileFlush is useful but frequent calls can affect speed. | Add metadata to existing payloads; do not rewrite FileIO or increase flush churn. | writers only; `ASC_FileIO.mqh` protected | changed-files zip excludes FileIO | no FileIO rewrite, no extra flush policy |
| Artifact provenance/build identity | Provenance binds artifact to source/build metadata and should be visible to consumers without invented hashes. | Emit source run/version/schema/written-by/build-present/fake-hash boundary. | `ASC_Version.mqh`, artifacts | RUN090 grep: `source_run_id`, `artifact_written_by_run`, `build_identity_present` | no fake source hash or compile hash |
| Risk-based smoke/regression testing | Smoke tests should verify the critical path quickly after changes; regression checks ensure existing behavior remains intact. | RUN090 should grep the highest-risk artifact families first. | report/control proof-debt | RUN090 grep Scanner Status, Market Board, GlobalTop10, Dossier, FunctionResults | no broad test expansion before source identity proof |
| Dashboard/status stale/retained semantics | Status consumers need visible freshness/provenance so stale/retained surfaces do not masquerade as current. | retained/stale artifacts must carry identity boundary and not be called newly current. | Market Board, GlobalTop10 manifest, Dossier, Scanner Status | compare identity + stale/current labels | no retained artifact called current without written-by-run identity |

## RUN084R FINISH-STATE VERIFICATION TABLE

| RUN084R finish item | Present? | Gap? | RUN085R patch decision |
|---|---:|---|---|
| Market Board / GlobalTop10 signature logic | yes | no formula gap | preserve |
| GlobalTop10 family manifest Board Signature | yes | no | preserve |
| Derived From Board Signature | yes | no | preserve |
| Child payload derived_from_board_signature | yes | no | preserve |
| alignment_status | yes | no | preserve |
| stale_current_guard | yes | no | preserve |
| Scanner Status alignment lines | yes | missing source/run identity | patched Scanner Status identity |
| FunctionResults compact alignment proof | yes | missing source/run identity suffix | patched aggregate suffix only |
| Formula/rank/order changes avoided | yes | no drift found | protected |
| FileIO/HUD edits avoided | yes | no | protected |
| log spam/schema drift avoided | yes | no | aggregate-only patch |
| source_patched_live_unproven retained | yes | no | preserved |

## IDENTITY OWNER MAP TABLE

| Artifact family | Owner file/function | Current identity proof | Gap | Patch decision |
|---|---|---|---|---|
| Scanner Status | `ASC_WriteScannerStatusArtifact` | alignment proof only | missing compact source/build/run tokens | patched |
| Market Board | `ASC_BuildMarketBoardArtifact` | board surface + provenance line | missing exact grep tokens | patched |
| GlobalTop10 family manifest | `ASC_Top10RunFullBuildFamilyManifest` | board/derived signatures | missing exact source/build/run tokens | patched |
| GlobalTop10 child files | deferred child payload in Dispatcher | deferred L5 + derived signature | missing exact source/build/run tokens | patched |
| Dossier | top header section | schema/version present | missing exact source/build/run tokens | patched |
| Selected-symbol Dossier alias | legacy writer path | same root `Dossier.txt` path | old naming can look independent | documented as alias only; no independent proof target |
| FunctionResults | `ASC_FunctionResultFinish` | proof row/class fields | missing aggregate source identity | patched suffix only |
| Output package manifest/control | roadmap files | run reports | missing RUN085R entry | patched |

## SOURCE IDENTITY TOKEN TABLE

| Token | Meaning | Owner | RUN090 evidence |
|---|---|---|---|
| `source_run_id=RUN085R` | source run that wrote the artifact text | `ASC_Version.mqh` helper | grep major artifacts |
| `source_identity_token=RUN085R|...` | compact source/run/proof-boundary fingerprint; not a hash | `ASC_Version.mqh` | grep artifacts/log detail |
| `artifact_written_by_run=RUN085R` | writer run identity for current emission | `ASC_Version.mqh` helper | grep output payloads |
| `artifact_schema_version=ASC_ARTIFACT_SCHEMA_V1` | stable artifact-schema marker | `ASC_Version.mqh` | grep output payloads |
| `build_identity_present=true` | compact build/source identity is exposed | `ASC_Version.mqh` | grep output payloads |
| `fake_hash=false` / `compile_hash=not_claimed` | prevents fake compile/source hash claim | `ASC_Version.mqh` | grep version helper line |

## ARTIFACT FAMILY IDENTITY TABLE

| Artifact family | Identity fields | Owner | RUN090 evidence |
|---|---|---|---|
| Scanner Status | source run/version/token/written-by/schema/build-present | `ASC_ScannerStatusWriter.mqh` | `Scanner Status` grep |
| Market Board | artifact family line + exact grep tokens | `ASC_MarketBoardWriter.mqh` | `Market Board` grep |
| GlobalTop10 family | artifact family line + exact grep tokens + signatures | `ASC_Dispatcher.mqh` | `_family_manifest.txt` grep |
| GlobalTop10 children | artifact family line + exact grep tokens + deferred L5 labels | `ASC_Dispatcher.mqh` | child dossier grep |
| Dossier | top-header artifact family line + exact grep tokens | `ASC_DossierTopHeaderSection.mqh` | `Dossier.txt` grep |
| FunctionResults | aggregate detail suffix only | `ASC_FunctionResults.mqh` | function_results.log grep |

## RETAINED / STALE IDENTITY TABLE

| State | Required identity behavior | Forbidden misuse |
|---|---|---|
| current | must carry current source/run token and written-by-run identity | may not rely on old retained payload identity |
| retained last-good | must stay visibly retained/stale/degraded when retained | may not be called newly current |
| staging/archive | may exist as evidence only | may not masquerade as promoted current |
| selected-symbol Dossier alias | must be treated as root Dossier selected-symbol surface | must not be treated as independent file/artifact family |

## FUNCTIONRESULTS / SCANNER STATUS EVIDENCE TABLE

| Evidence token | Current behavior | Patch decision | Spam risk |
|---|---|---|---|
| `functionresults_aggregate_identity=source_run_id=` | appended to existing result detail | patched | low; no new rows/schema |
| `Source Run ID:` | Scanner Status visible summary line | patched | none |
| `source_run_id=` | exact grep line in Scanner Status | patched | none |
| alignment status/signatures | RUN084R preserved | no change | none |
| queue state/cursor/stall tokens | RUN083R preserved | no change | none |

## RUN084 / RUN083 / RUN082 REGRESSION GUARD TABLE

| Prior repair | Still intact? | Evidence |
|---|---:|---|
| RUN084 board/GlobalTop10 signature | yes | `Board Signature`, `Derived From Board Signature`, `alignment_status`, `stale_current_guard` retained |
| RUN083 queue evidence | yes | Scanner Status queue fields retained |
| RUN082 deferred L5 labels | yes | child payload still has pending/completed/expired/retry labels |

## PROTECTED FORMULA / ORDER DRIFT TABLE

| Protected area | Touched? | Drift? | Evidence |
|---|---:|---:|---|
| GlobalTop10 formula/order | no formula edit | no | identity payload only |
| L3 score | no | no | no L3 formula owner patched |
| L4 rank/order | no | no | no shortlist rank owner patched |
| Market Board order | no | no | header/provenance lines only |
| FileIO | no | no | not in changed files |
| HUD | no | no | not in changed files |
| FunctionResults schema | no schema edit | no | detail suffix only; no fields/rows added |
| strategy/execution | no | no | no execution files touched |

## PATCH CANDIDATE MATRIX

| File | Candidate patch | Why needed | Risk | Chosen/rejected |
|---|---|---|---|---|
| `ASC_Version.mqh` | central identity helper | shared vocabulary | low | chosen |
| `ASC_ScannerStatusWriter.mqh` | source identity lines | status must prove source | low | chosen |
| `ASC_MarketBoardWriter.mqh` | source identity lines | board output must be grepable | low | chosen |
| `ASC_Dispatcher.mqh` | GlobalTop10 manifest/child identity | family/child ambiguity | medium | chosen, metadata only |
| `ASC_DossierTopHeaderSection.mqh` | Dossier identity in top header | Dossier provenance gap | low | chosen |
| `ASC_FunctionResults.mqh` | aggregate identity suffix | log provenance gap | medium | chosen, no schema/rows |
| `ASC_FileIO.mqh` | possible write metadata | would increase churn/risk | high | rejected |
| HUD | possible visible wording cleanup | protected and not identity owner | high | rejected |

## PATCH TABLE

| File | Function/area | Patch made | Why truthful | Compile-risk note |
|---|---|---|---|---|
| `mt5/core/ASC_Version.mqh` | run identity | bumped to RUN085R and added `ASC_BuildSourceArtifactIdentityToken()` / `ASC_ArtifactIdentityLine()` | explicit no-fake-hash/no-compile-hash boundary | helper-only; no runtime lane |
| `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` | surface provenance | appended shared identity token to provenance line | every reused provenance line exposes source/run | include-only risk low |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | Scanner Status | added source/run/schema/written-by/build-present lines and required tokens | RUN090 can grep status output | metadata only |
| `mt5/artifacts/ASC_MarketBoardWriter.mqh` | Market Board header | added artifact identity line and exact grep line | board output tied to current run | no order/rank logic touched |
| `mt5/runtime/ASC_Dispatcher.mqh` | GlobalTop10 manifest/child | added family/child identity exact grep tokens and required tokens | output families tied to source run | metadata only |
| `mt5/artifacts/dossier/top_header/ASC_DossierTopHeaderSection.mqh` | Dossier top header | added Dossier identity line and exact grep line | Dossier carries source/written-by proof | header metadata only |
| `mt5/artifacts/dossier/ASC_DossierComposer.mqh` | legacy alias wording | changed visible mirror boundary wording to selected-symbol Dossier semantics | prevents independent artifact assumption | string-only |
| `mt5/logging/ASC_FunctionResults.mqh` | result finish | appended aggregate identity suffix | source identity in logs without new rows/schema | no schema change |
| `mt5/core/ASC_Constants.mqh` | alias comment | states legacy alias is not independent artifact | prompt/source guard | comment only |
| roadmap files | control/report | RUN085R report/log/manifest added | auditability | docs only |

## STATIC COMPILE-SAFETY TABLE

| Check | Result | Evidence |
|---|---|---|
| Compile root present | pass | `mt5/AuroraSentinelCore.mq5` exists |
| FileIO unchanged | pass | no FileIO patch |
| HUD unchanged | pass | no HUD patch |
| FunctionResults schema unchanged | pass | struct/log keys unchanged; detail suffix only |
| Ranking/scoring owners untouched | pass | no L3/L4/Top10 formula owner patch |
| Required token arrays updated where new required payload tokens were added | pass | Scanner Status + GlobalTop10 family/child required tokens updated |
| Compile proof claimed | no | source-only proof boundary retained |

## PROOF-DEBT UPDATE TABLE

| Proof item | Before RUN085R | After RUN085R | RUN090 proof action |
|---|---|---|---|
| Source-to-output identity | weak | compact token exposed | grep every major output |
| GlobalTop10 family identity | alignment only | alignment + source identity | grep manifest |
| GlobalTop10 child identity | derived signature only | derived signature + source identity | grep child files |
| Dossier identity | schema/header only | schema + source identity | grep Dossier |
| Scanner Status identity | alignment only | alignment + source identity | grep Scanner Status |
| FunctionResults identity | no aggregate run token | aggregate suffix | grep log |
| Compile/live proof | absent | still absent | RUN090 live checkpoint |

## NEXT_PROMPT_SEED TABLE

| Next run | Must read first | Primary target | Known proof debt | Must not do |
|---|---|---|---|---|
| RUN086R | RUN085R report, changed files, RUN084R report | next narrow proof-hardening seam before RUN090 | compile/live/output still unproven | no formula/rank/order/FileIO/HUD/strategy drift |
| Prompt master guard | RUN085R report | never treat the legacy selected-symbol alias as an independent artifact; say Dossier / selected-symbol Dossier only | legacy names remain in old source/UI paths | do not create new independent artifact target |

## FINAL DECISION TABLE

| Field | Decision |
|---|---|
| RUN | RUN085R |
| Decision | PASS — source patched, live unproven |
| Code edit | yes |
| Live output requested | no |
| Compile/live proof claimed | no |
| Next live checkpoint | RUN090R |
| Zip required | yes |

```text
FINAL SUMMARY
RUN085R patched compact build/source/artifact identity proof across the lawful metadata owners.
GlobalTop10 / Market Board alignment signatures from RUN084R remain intact.
Dossier queue evidence from RUN083R remains intact.
Deferred L5 honesty labels from RUN082R remain intact.
No rank, score, formula, Market Board order, FileIO, HUD, strategy, or execution logic was changed.
FunctionResults received only an aggregate detail suffix; no schema drift and no per-symbol spam.
The legacy selected-symbol alias is now treated as Dossier-only semantics, not an independent artifact family.
RUN085R remains source_patched_live_unproven until RUN090R.
```
