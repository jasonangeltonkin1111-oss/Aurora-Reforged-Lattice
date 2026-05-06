# GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN112R / DOSSIER OUTPUT REDUCTION + TOP5 DEPTH PARITY + CADENCE/PERFORMANCE DESIGN AUDIT — STOP ROUTINE ROOT SYMBOL DOSSIERS, KEEP GLOBALTOP10/TOP5PERBUCKET, FIX TOP5 DEEP HYDRATION, ADD STAGING/ARCHIVE PLAN, AND MAKE PERFORMANCE A PERMANENT SIDE AUDIT

RUN TYPE: DESIGN AUDIT / SOURCE-READINESS / PERFORMANCE-EFFICIENCY PLAN / NO-LIVE / NO-SOURCE-PRODUCT-PATCH

DECISION: AUTHORIZE — future source work is safe if split into policy gate, Top5 depth parity/staging, telemetry reduction, then live proof.

PROOF BOUNDARY: `dossier_output_reduction_top5_depth_cadence_design_authorized`

COMPILE CLAIM: not claimed.

LIVE CLAIM: not claimed beyond inspected RUN111R report evidence and operator screenshot evidence supplied in the prompt.

SOURCE PATCH: none to MT5 product source. Control/report files only.

PROTECTED: FileIO atomic contract, artifact root, GlobalTop10 rank/order/formula, Top5PerBucket rank/order, Market Board order, L3 score, L4 rank, Dossier/Current Focus truth ownership, HUD read-only law, scan/write/read lane law, heartbeat cadence, strategy/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP.

---

# 2. OPERATOR SNAPSHOT

| Item | Status |
|---|---|
| Top5PerBucket live-present | yes — RUN111R report proves folder/family/bucket/children existed live |
| Top5 child size concern | yes — operator screenshots and RUN111R report show Top5 children around 114–119 KB |
| GlobalTop10 depth comparison | yes — RUN111R report shows GlobalTop10 children around 452–512 KB |
| root all-symbol dossier noise confirmed | yes — screenshot evidence shows many ordinary root `Dossiers/<symbol>.txt` shells/noise files, mostly 3–4 KB |
| proposed root all-symbol disable | yes — authorize default `selected_and_families_only`, with diagnostic/legacy modes off by default |
| proposed cadence model | yes — Market Board 1m publish, L3 10m, L4 20m, GlobalTop10 5m, Top5PerBucket 10m |
| logging/performance audit included | yes |
| source patched | no — report/control only |
| next run target | RUN113R / Dossier publication policy gate + cadence source patch |
| protected areas not touched | FileIO, HUD, rank/formula, strategy/execution, heartbeat/lane law |

---

# 3. INPUT ZIP / FILE INTAKE SUMMARY

| Input | Type | Evidence | Treatment |
|---|---|---|---|
| `Aurora Sentinel Core(373).zip` | source/control/report package | extracted root: `Aurora Sentinel Core/`; source/control package with `mt5/`, `roadmap/Truth Seeker/`, archive docs present | treated as current source/control package |
| runtime live output tree | not present in zip | no `Dossiers/`, no `Market Board.txt`, no `Scanner Status.txt`, no `Artifact Bundle Manifest.txt`, no live logs under output tree | not called a defect; screenshot/RUN111R report used as runtime evidence |
| RUN111R report | report/control authority | present at required path | treated as primary report evidence after operator prompt |
| RUN111R patched source | source evidence | `ASC_Dispatcher.mqh`, `ASC_Constants.mqh`, `ASC_Version.mqh` present | inspected for patch-readiness and dependency map |
| nested roots | source root only | no runtime-output nested root found | no live filesystem counts verified directly |

---

# 4. RUN111R ABSORPTION

| RUN111R Finding | Evidence | Meaning | RUN112 Design Action |
|---|---|---|---|
| Top5PerBucket folder exists | RUN111R rows show `Dossiers/Top5PerBucket/` live present | family output path is real | preserve family path |
| family manifest exists | RUN111R reports `_family_manifest.txt`, 3.6 KB | family-level proof surface exists | extend proof tokens/cadence, do not replace |
| bucket manifests exist | six `_bucket_manifest.txt` files reported | per-bucket proof exists | keep per-bucket manifests; add staging/archive later |
| child Dossiers exist | 39 actual files vs 28 manifest target | writer works but stale extras existed | child cleanup already patched; RUN116 must live-prove |
| child count mismatch patched | RUN111R patched active child cleanup in dispatcher | active folders can be cleaned before new batch | replace delete-first with archive/stage-safe policy in RUN114 if needed |
| FunctionResults proof tokens patched | RUN111R patched aggregate token injection | aggregate observability improved | preserve aggregate proof; reduce spam later |
| Top5 child file size ~115 KB | RUN111R report and screenshot evidence | Top5 not GlobalTop10-depth | patch writer to use real completed deep payload for rank #1–#3 |
| GlobalTop10 child file size ~450–500 KB | RUN111R report and screenshot evidence | GlobalTop10 deep hydration path works | reuse GlobalTop10 deep composer/publisher path, not new Dossier engine |
| family state partial/promoted false | RUN111R family manifest rows: `partial`, `bucket_family_promoted=false` | honest currentness; no fake promoted-current | add staging/archive before promoted-current claim |
| no staging/archive Top5 per bucket yet | RUN111R says staging/archive boundaries absent | direct folders are vulnerable to partial/current confusion | implement bucket-level staging first |
| root all-symbol dossiers still written | screenshot: many 3–4 KB ordinary root files | file churn/noise is real | gate routine all-symbol queue off by default |
| timing watch remains | RUN111R mentions 22s heavy Top10/deep beat and write pressure rows | cadence must avoid long timer beats | preserve one-child/write-beat, near-budget yield, UI priority yield |

---

# 5. ROADMAP AUTHORITY CHECK

The active roadmap frames Dossier work as folder completion, hydration classes, and stall-proof publication, not a Dossier rewrite. It recognizes GlobalTop10 deep Dossiers and root/current Dossier deep paths as working, and forbids new Dossier systems, new publication paths, new writer engines, new runtime lanes, broad L5/L6 hydration, HUD computation, and file-size padding. RUN112R therefore authorizes only gating and reuse of existing composer/deep paths.

---

# 6. INTERNET RESEARCH CONVERSION TABLE

| Research Area | Source | Finding | RUN112 Design Constraint | Implementation Impact |
|---|---|---|---|---|
| FileOpen subfolder / FILE_COMMON / sandbox behavior | Official MQL5 `FileOpen` docs | Files open under terminal/tester `MQL5\\Files`, or shared `Terminal\\Common\\Files` when `FILE_COMMON` is used | Keep artifact paths under existing `FILE_COMMON` server-root; no artifact root redesign | RUN113/RUN114 must use existing atomic helpers and path contracts |
| FileFlush / FileClose durability and speed | Official file docs | Close/flush pushes buffered data; frequent flush can hurt speed | Avoid more per-symbol/per-heartbeat flush loops; reduce file count/churn | File-output reduction is valid performance work; no FileIO rewrite |
| OnTimer / EventSetTimer queue behavior | Official MQL5 timer/runtime docs | One timer per program; if Timer event is queued/processing, another Timer event is not added | Long write/deep beats can skip timer opportunities | Keep heartbeat cadence; bounded queues/yields only |
| FileMove/FileDelete/FolderCreate/FolderClean/FolderDelete | Official MQL5 file/folder docs | File move/delete/folder ops exist; folder delete requires empty folder | Top5 staging/archive must be narrow; no broad root cleanup | Add per-bucket staging/archive; retain old root dossiers first |
| SymbolInfoSessionTrade / SymbolInfoSessionQuote / SymbolInfoTick | Official MQL5 symbol docs | session/tick functions expose session/tick state, but currentness/actionability must be validated | Top5 rank is not actionability; L1/L2 owns open/current truth | Keep `closed_symbols_actionable=false`; no trade signal overclaim |

Reference URLs: https://www.mql5.com/en/docs/files/fileopen ; https://www.mql5.com/en/docs/event_handlers/ontimer ; https://www.mql5.com/en/docs/eventfunctions/eventsettimer ; https://www.mql5.com/en/docs/runtime/running ; https://www.mql5.com/en/docs/files/filemove ; https://www.mql5.com/en/docs/files/filedelete ; https://www.mql5.com/en/docs/files/foldercreate ; https://www.mql5.com/en/docs/files/folderclean ; https://www.mql5.com/en/docs/files/folderdelete

---

# 7. TOP5PERBUCKET DEPTH PARITY AUDIT

| Cause Candidate | Source Evidence | Likely? | Future Patch |
|---|---|---:|---|
| Top5 child writer builds deferred pseudo-deep payload | `ASC_Top5BucketWriteChild()` creates `deferred_deep`, sets `deep_payload_deferred: yes`, `deep_completed: no`, and appends `deep_pending=true` | high | RUN114: rank #1–#3 must use completed deep result/path before claiming full depth |
| Hydration label does not match body depth | constants define `BUCKET5_RANK1_3_L0_L6`, but writer still appends pending/deferred deep | high | only mark L0–L6 when actual deep truth exists |
| GlobalTop10 completed deep path exists | dispatcher deep trigger path uses `frozen_request_origin == "global_top10_batch"`, actual `deep_result`, and `ASC_DossierPayloadHasFreshDeepTruth()` | high | reuse this pattern; no new truth owner |
| GlobalTop10 deferred path exists but live files are large | `ASC_TOP10_RUN_FULL_DEFER_HEAVY_DEEP_CHILDREN=false`; RUN111R files 452–512 KB | high | preserve GlobalTop10 as reference implementation |
| Mode flag alone is not enough | Top5 passes deep override and `has_deep_result=true`, but the deep result is deliberately deferred | high | depth must require real `ASC_DeepSelectiveAnalysisResult` payload |
| Required tokens validate pending identity, not completed deep | Top5 required tokens include `deep_pending=true` | high | split token contracts for rank #1–#3 completed vs rank #4–#5 pending |
| Deep availability is budget-gated | GlobalTop10 has one-child/deferred recovery safeguards | high | Top5 full depth must be queued, one child per beat, with yield |

## Depth Decision

| Question | Decision |
|---|---|
| Should Top5 rank #1–#3 become true GlobalTop10-depth dossiers? | yes, only through existing completed deep-result/Dossier composer path |
| Should Top5 rank #4–#5 stay L0–L4 + deep_pending? | yes |
| Should all Top5 children become full deep? | no |
| Timing cost | up to 18 deep-entitled children per 10-minute Top5 cycle; queue/yield required |

---

# 8. TOP5PERBUCKET STAGING / ARCHIVE DESIGN

| Option | Pros | Cons | Timing Cost | Recommended? |
|---|---|---|---:|---:|
| A. family-level `_staging` + `archive` only | simple; one promotion boundary | bucket partials still ambiguous | medium | no |
| B. per-bucket `_staging` + `archive` | isolates membership changes; stale extras archived by bucket; supports last-good | more paths/counters | medium | yes |
| C. both family and bucket staging/archive | strongest consistency | highest complexity/write load | high | later only |
| D. direct folders only + cleanup | simplest and already patched | delete-before-proof and no last-good | low | no except fallback |

First safe implementation: per-bucket `_staging` + `archive`. Write next cycle into `Top5PerBucket/<bucket>/_staging/<cycle_id>/`, validate tokens, promote/refresh active bucket files, and archive old active children. Do not delete old root dossiers. Family manifest reports mixed truth honestly until full promotion is proven.

---

# 9. ROOT ALL-SYMBOL DOSSIER OUTPUT AUDIT

| Root Dossier Writer Path | Source Owner | Trigger | Needed After Families? | Risk If Disabled |
|---|---|---|---:|---|
| `ASC_BuildDossierShellArtifact()` | `ASC_DossierWriter.mqh` | broad queue shell writes | no by default | low if selected/family exceptions remain |
| `ASC_BuildDossierArtifact()` | `ASC_DossierWriter.mqh` | broad queue hydrated writes | no by default | medium: status/ledger counts need policy labels |
| Dossier pending queue service | `ASC_Dispatcher.mqh` | drains closed/open/L3/L4 root queues | no routine all-symbol output | medium: must preserve selected/current/families |
| Current Focus root publish | dispatcher current focus path | operator-selected/viewed symbol | yes | high |
| selected-symbol support Dossier copy-down | Dossier contract in current/deep paths | selected derivative/support artifact | yes if dependency exists | medium |
| explicit Deep Analysis pair/root write | dispatcher deep focus path | manual/selected/global top10 deep trigger | yes | high |
| GlobalTop10 child path | dispatcher GlobalTop10 functions | 5m family refresh | yes | high |
| Top5PerBucket child path | dispatcher Top5 helpers | family child refresh | yes | high |
| HUD read paths | HUD/read-model | reads current focus/board/artifacts | unclear direct root dependency | medium; audit only in RUN113 |
| Scanner Status / Manifest | status/manifest writers | proof surfaces | yes as proof, not root write owner | low if tokens added |
| continuity/last-good | FileIO/publication + ledger | preserves prior artifacts | yes | low if legacy files retained |

Decision: disable routine all-symbol root Dossier writes by default in RUN113R. Keep selected/current, Current Focus, explicit deep, GlobalTop10, Top5PerBucket, and legacy files retained.

---

# 10. DOSSIER PUBLICATION POLICY DESIGN

| Policy Token | Meaning | Source Owner | Future Patch |
|---|---|---|---|
| `dossier_publication_mode=selected_and_families_only` | routine output limited to selected/current and family artifacts | constants/runtime/dispatcher | RUN113 |
| `root_all_symbol_dossiers_enabled=false` | broad queue does not publish root all-symbol files by default | dispatcher queue service | RUN113 |
| `globaltop10_dossiers_enabled=true` | GlobalTop10 family remains active | dispatcher | RUN113 token only |
| `top5_per_bucket_dossiers_enabled=true` | Top5PerBucket family remains active | dispatcher | RUN113 token; RUN114 depth/staging |
| `current_focus_enabled=true` | Current Focus/root selected remains active | dispatcher/current focus | RUN113 |
| `selected_symbol_dossier_enabled=true` | selected root/support Dossier remains active | dispatcher/Dossier contract | RUN113 |
| `diagnostic_all_symbol_dossiers_enabled=false` | debug all-symbol mode available but off | constants/controls later | RUN113 constant |
| `legacy_all_symbol_dossiers_retained=true` | old files are not deleted | cleanup policy | RUN113 token |
| `legacy_root_dossier_cleanup_pending=true` | cleanup deferred until proof | roadmap/status | RUN113 token |

---

# 11. CADENCE / REFRESH MODEL DESIGN

| Component | Compute Cadence | File Publish Cadence | Reason | Risk |
|---|---:|---:|---|---|
| Market Board | latest committed L4, no publish-only recompute | 60 sec | fresh board file without rank churn | must label compute age |
| L3 Candidate Filtering | 600 sec | consumed after compute | less churn | slower candidate refresh; urgent exception needed |
| L4 Shortlist/Top ranking | 1200 sec | board/families republish committed rows | stable membership | regime shift delay; forced/open exception needed |
| GlobalTop10 children | existing L4 snapshot | 300 sec | preserve proven deep family | heavy deep beats possible |
| Top5PerBucket children | L4 snapshot + rank #1–#3 deep queue | 600 sec | parity without flood | up to 18 deep children per cycle |
| L1/L2 | fast/bounded current law | current surfaces | open/closed truth remains current | must not wait on L3/L4 |
| Scanner Status / Manifest | aggregate status | 60 sec or dirty | proof without spam | manifest size growth |
| FunctionResults | aggregate/state transition | sampled/aggregate | reduce log churn | under-proofing if overdone |

Exceptions: first-run warmup labels partial truth; forced/manual refresh may bypass cadence but still queue/yield; open-state urgent refresh remains L1/L2-owned; UI priority and near-budget yield all side duties; no heartbeat cadence change.

Current source note: L3/L4 are currently 300/600 seconds; Top5 cadence is 300 seconds; GlobalTop10 is already 300 seconds. RUN113 should set L3=600, L4=1200, Top5=600, GlobalTop10 unchanged.

---

# 12. TELEMETRY / LOGGING LOAD AUDIT

| Log / Telemetry Surface | Current Purpose | Load Risk | Keep / Reduce / Sample / Rotate |
|---|---|---|---|
| FunctionResults | proof rows/decision trace | high — RUN111R was ~5.3 MB | keep aggregate; reduce repeated unchanged rows |
| heartbeat_telemetry | heartbeat/budget proof | medium/high — RUN111R was ~1.6 MB | keep bounded samples; rotate later |
| Scanner Status | operator proof/status | medium | compact aggregate tokens |
| Artifact Bundle Manifest | artifact state/proof | medium/high — RUN111R ~152 KB | avoid duplicate child detail |
| Dossier/family manifests | family proof | necessary | keep; add cadence/policy/depth tokens |
| HUD telemetry | HUD performance proof | medium if HUD touched | sample only when HUD changed/UI active |
| Top5 proof tokens | safety/count proof | necessary | aggregate + manifests, not FunctionResults spam |
| GlobalTop10 proof tokens | deep family proof | necessary | keep existing proof |

Rules: keep aggregate proof, avoid per-symbol spam, avoid per-heartbeat giant unchanged rows, preserve live proof, consider rotation later, no new logging subsystem.

---

# 13. PERMANENT PERFORMANCE / EFFICIENCY SIDE AUDIT TEMPLATE

| Performance Area | Check | Patch If |
|---|---|---|
| file writes / file count | count new/changed artifact files and repeated rewrites | routine output creates noise or stale files |
| file size growth | compare GlobalTop10/Top5/root/manifest/log sizes | size/body/hydration labels mismatch |
| log size growth | FunctionResults and heartbeat growth | repeated unchanged rows bloat logs |
| heartbeat elapsed vs budget | max/median/near-budget/yield tokens | heavy write/deep beat monopolizes timer |
| timer pressure | no long loops/all-family dumps | OnTimer risk increases |
| queue remaining | continuation and stuck cursor | pending remains without proof/expiry |
| object/HUD churn if HUD touched | changed labels/objects/repaint count | unchanged UI text rewrites objects |
| root all-symbol writes | policy mode/root write count | routine root writes restart |
| Dossier/family write count | family/selected/root counts | family work duplicates root work |
| Market Board publish cadence | publish age vs compute age | publish refresh recomputes L4 |
| L3/L4 cadence | constants/state/proof tokens | cadence drifts from 10m/20m |
| deep analysis workload | completed/pending/deferred children | deep queue floods |
| stale/extra cleanup | manifests vs active children | extras remain or last-good lost |
| compile-risk from large `StringFormat` | touched code format calls | argument mismatch risk appears |
| array/queue bounds | array/cursor alignment | queue state can misalign |
| no broad rewrites | touched owners only | FileIO/HUD/rank/strategy drift appears |

Permanent rule: include this in every future audit run, code edit run, live proof run, and prompt seed.

---

# 14. PATCH CANDIDATE MATRIX

| Candidate | Value | Risk | Run |
|---|---|---|---|
| Add publication mode constants/state/proof tokens | high | low/medium | RUN113R |
| Gate broad all-symbol root queue | high | medium | RUN113R |
| Preserve selected/current/family exceptions | required | high if missed | RUN113R |
| Change L3 300→600 and L4 600→1200 | high | medium | RUN113R |
| Change Top5 300→600 | high | low | RUN113R |
| Top5 rank #1–#3 completed deep path | high | high | RUN114R |
| Top5 per-bucket staging/archive | high | medium | RUN114R |
| FunctionResults sampling/reduction | medium/high | medium | RUN115R |
| heartbeat telemetry compacting | medium | medium | RUN115R |

---

# 15. IMPLEMENTATION PLAN

| Run | Type | Target | Acceptance | Risk |
|---|---|---|---|---|
| RUN113R | source patch | Dossier publication policy gate + cadence constants/state/proof | selected/current/families enabled; routine root off; tokens present; no deletion | selected/HUD dependency miss |
| RUN114R | source patch | Top5 rank #1–#3 depth parity + per-bucket staging/archive | rank #1–#3 completed deep or explicit pending; rank #4–#5 L0–L4 pending; staging/archive tokens | deep workload/timer pressure |
| RUN115R | source patch | telemetry/logging reduction + performance hardening | aggregate proof retained; unchanged spam reduced | under-proofing |
| RUN116R | live proof | root churn reduction, Top5 depth, cadence, performance | root routine files stop growing; families present; depth/body match; cadence tokens prove model | live variability |

---

# 16. PROTECTED AREAS NOT TOUCHED

No RUN112R MT5 source patch touched FileIO, HUD, L3/L4 rank formulas, Market Board order, GlobalTop10 formula/order, strategy/execution, heartbeat cadence, BUY/SELL, OrderSend/CTrade, lot sizing, SL, or TP.

---

# 17. REGRESSION GUARD

| Guard | RUN112 Verdict |
|---|---|
| FileIO atomic contract | protect; existing atomic writer only |
| artifact root | protect; no root move |
| GlobalTop10 rank/order/formula | protect |
| Top5PerBucket rank/order | protect; consume L4 only |
| Market Board order | protect; publish cadence only |
| L3 score | protect; cadence only |
| L4 rank | protect; cadence only |
| Dossier/Current Focus truth ownership | protect; selected exception required |
| HUD read-only law | protect; dependency audit only |
| scan/write/read lane law | protect; no new lane |
| heartbeat cadence | protect; no timer interval change |
| strategy/execution | protect; no trade logic |
| BUY/SELL / OrderSend / CTrade / lots / SL / TP | forbidden; not touched |

---

# 18. TRUE ROADMAP PROGRESS UPDATE

RUN112R advances the roadmap from “Top5PerBucket exists but partially proven” to “Top5PerBucket + root-output reduction + cadence/performance repair are authorized as a safe staged patch sequence.” It does not close RUN111R carry-forward proof debt. RUN116R remains required to prove post-patch cleanup, proof tokens, actual child counts, no stale extras, depth parity, cadence behavior, and performance improvement.

---

# 19. NEXT_PROMPT_SEED

```text
GIT HEADER

TRUTH SEEKER ROADMAP — RUN113R / DOSSIER PUBLICATION POLICY GATE + CADENCE SOURCE PATCH — DISABLE ROUTINE ROOT ALL-SYMBOL DOSSIERS BY DEFAULT, KEEP SELECTED/CURRENT + GLOBALTOP10 + TOP5PERBUCKET, ADD POLICY PROOF TOKENS, AND SET CADENCE CONSTANTS

RUN TYPE: SOURCE PATCH / NO-LIVE / COMPILE-READINESS
READ FIRST:
1. RUN112R design report.
2. RUN111R live proof report.
3. mt5/runtime/ASC_Dispatcher.mqh Dossier queue service, Current Focus, GlobalTop10, Top5PerBucket hooks.
4. mt5/core/ASC_Constants.mqh cadence/policy constants.
5. mt5/core/ASC_RuntimeState.mqh state fields.
6. mt5/artifacts/ASC_DossierWriter.mqh and dossier contracts.
7. Scanner Status / Artifact Bundle Manifest / FunctionResults proof token owners.

PRIMARY TARGET:
Implement `dossier_publication_mode=selected_and_families_only` and set routine root all-symbol Dossier queue off by default without deleting legacy files.

ACCEPTANCE:
- root all-symbol routine Dossier writes gated off by default;
- selected/current/root selected Dossier remains enabled;
- Current Focus remains enabled;
- GlobalTop10 remains enabled at 5m;
- Top5PerBucket remains enabled, cadence becomes 10m;
- Market Board publish policy remains 1m;
- L3 cadence becomes 10m;
- L4 cadence becomes 20m;
- no root file deletion;
- policy tokens appear in Scanner Status/Manifest/FunctionResults aggregate proof;
- no FileIO/HUD/rank/formula/strategy/execution drift.

FORBIDDEN:
FileIO rewrite, HUD work unless direct dependency audit only, GlobalTop10 formula/order, Top5 rank/order, Market Board order, L3 score, L4 rank formula, strategy/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP, heartbeat cadence change.

PERMANENT PERFORMANCE SIDE AUDIT:
Include file-count/write-count, log growth, heartbeat/timer pressure, queue remaining, root all-symbol write count, family write count, Market Board/L3/L4 cadence, deep workload, stale/extra cleanup, StringFormat compile-risk, and array bounds checks.
```

---

# 20. FINAL DECISION

AUTHORIZE — the audit supports disabling routine root all-symbol Dossier publication by default while preserving selected/current, Current Focus, GlobalTop10, Top5PerBucket, proof surfaces, continuity, and trading safety, provided RUN113/RUN114/RUN115/RUN116 remain split and bounded exactly as planned.
