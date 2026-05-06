# GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN106R / TOP5 PER BUCKET ARTIFACT FAMILY DESIGN AUDIT — GLOBALTOP10-SIBLING DOSSIER FAMILY PLAN, DYNAMIC BROKER BUCKET DISCOVERY, QUEUED CHILD HYDRATION, MANIFEST/PROMOTION CONTRACT, AND TIMING BUDGET DESIGN

RUN TYPE: DESIGN AUDIT / IMPLEMENTATION PLAN / NO-LIVE / NO-SOURCE-FAMILY-CREATION

NEXT RUN: RUN107R / TOP5 PER BUCKET FAMILY SOURCE CONTRACT + SKELETON IMPLEMENTATION

PROOF BOUNDARY: `top5_per_bucket_design_authorized_source_unpatched_live_package_partial_runtime_outputs_missing`

COMPILE CLAIM: not claimed

LIVE CLAIM: not claimed beyond uploaded package inventory. The requested `Upcomers-Server/` runtime output tree was not present in this zip.

OUTPUT CLAIM: claimed only for source/control/report inspection and this design report.

PATCHED: control/report only.

PROTECTED: FileIO atomic contract, GlobalTop10 rank/order/formula, Market Board order, L3 score, L4 rank, Current Focus/Dossier truth ownership, HUD read-only law, scan/write/read lane law, heartbeat cadence, strategy/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP.

---

# 2. OPERATOR SNAPSHOT

The operator wants prepared deep Dossier children for bucket-local Top 5 symbols because HUD navigation is currently too slow for practical packet review. The right design is a sibling artifact family beside GlobalTop10, not a new rank/truth engine.

**Decision:** AUTHORIZE RUN107R skeleton implementation.

**Hard evidence gap:** the uploaded zip did not contain the expected live runtime `Upcomers-Server/` tree, so live Market Board/log/GlobalTop10 runtime file absorption is partial only. The source tree does contain the Market Board bucket Top 5 logic and the GlobalTop10 family machinery.

---

# 3. INPUT ZIP / LIVE PACKAGE INVENTORY

| Artifact / Log | Actual Path | Size | Modified Time | Source Run | Relevant To Top5PerBucket |
|---|---|---:|---|---|---|
| Market Board runtime artifact | `Upcomers-Server/Market Board.txt` | not found | not found | absent from uploaded zip | Required live source evidence missing. |
| Artifact Bundle Manifest runtime artifact | `Upcomers-Server/Artifact Bundle Manifest.txt` | not found | not found | absent from uploaded zip | Runtime bundle state missing. |
| Scanner Status runtime artifact | `Upcomers-Server/Scanner Status.txt` | not found | not found | absent from uploaded zip | Runtime status missing. |
| Open Symbol Snapshot runtime artifact | `Upcomers-Server/Open Symbol Snapshot.txt` | not found | not found | absent from uploaded zip | Runtime snapshot missing. |
| function_results | `Upcomers-Server/Workbench/logs/function_results.log` | not found | not found | absent from uploaded zip | Runtime proof rows missing. |
| heartbeat_telemetry | `Upcomers-Server/Workbench/logs/heartbeat_telemetry.log` | not found | not found | absent from uploaded zip | Runtime timing rows missing. |
| GlobalTop10 runtime folder | `Upcomers-Server/Dossiers/GlobalTop10/` | not found | not found | absent from uploaded zip | Runtime family missing. |
| GlobalTop10 family manifest | `Upcomers-Server/Dossiers/GlobalTop10/_family_manifest.txt` | not found | not found | absent from uploaded zip | Runtime manifest missing. |
| Root Dossier runtime files | `Upcomers-Server/Dossiers/*.txt` | not found | not found | absent from uploaded zip | Runtime dossier inventory unavailable. |
| Dossiers folder | `Upcomers-Server/Dossiers/` | not found | not found | absent from uploaded zip | Runtime dossier family unavailable. |
| Existing Top5PerBucket/BucketTop5 folder | recursive search | not found | not found | absent | Confirms no current family in uploaded tree. |
| Market Board source owner | `mt5/artifacts/ASC_MarketBoardWriter.mqh` | 142,758 bytes | 2026-04-28 06:41 | source | Contains bucket Top 5 construction and section writing. |
| Scanner Status source | `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | 61,944 bytes | 2026-04-28 07:45 | source | Existing status/proof surface for future family counters. |
| Roadmap authority | `roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md` | present | 2026-04-27 | control | Active roadmap authority. |

**Inventory verdict:** do not claim live proof. Proceed with a source-authorized implementation plan only.

---

# 4. ROADMAP AUTHORITY CHECK

`TRUTH_SEEKER_ROADMAP.md` says the current repair path is not a Dossier rewrite; it is hydration-class classification, publication queue/resume proof, manifest/log coverage, and preservation of existing Dossier/Current Focus/deep paths. It also preserves the scanner/advisory boundary and forbids `OrderSend`, `CTrade.Buy`, `CTrade.Sell`, automated execution, automated lot sizing, and SL/TP placement.

RUN106R respects that authority: no source family created, no execution changes, no ranking formula changes, no live/compile proof claimed.

---

# 5. INTERNET RESEARCH CONVERSION TABLE

| Research Area | Source | Finding | Top5PerBucket Constraint | Design Impact |
|---|---|---|---|---|
| FileOpen subfolder/FileCommon sandbox | Official MQL5 FileOpen/File Functions documentation | File names can contain subfolders; writing can create missing subfolders; file work is restricted to terminal/common file sandboxes. | Keep `Dossiers/Top5PerBucket/` under existing server root. Do not invent a new artifact root. | The family can be created through normal FileIO pathing, but only inside the current sandbox doctrine. |
| FileMove/FileDelete/FileFlush/FileClose | Official MQL5 file documentation / AlgoBook file close notes | Open files should be closed because open handles may block access; promotion/delete/flush must be done through the existing file discipline. | No FileIO rewrite. Reuse existing atomic copy/delete/validate wrappers. | Mirror GlobalTop10 staging/current/archive instead of direct ad-hoc writes. |
| OnTimer/EventSetTimer | Official MQL5 OnTimer/EventSetTimer docs | Each program has one timer queue; if a timer event is already queued or processing, a new timer event is not added. | Long child hydration can block timer cadence and worsen HUD sluggishness. | Bound Top5PerBucket to write-lane side duty, one child per beat initially, with UI-priority yield. |
| SymbolInfoSessionTrade / SymbolInfoSessionQuote | Official MQL5 market info docs | Trading/quote session functions expose beginning/end times for sessions. | Closed/uncertain names cannot be marked actionable. | Child headers and manifests must expose session/tradeability posture. |
| SymbolInfoTick | Official MQL5 market info docs | `SymbolInfoTick` returns current prices and last price update time in `MqlTick`. | Stale tick data cannot become prepared/actionable wording. | Use existing L1/L2 tick freshness state; do not create a new tick truth engine. |

---

# 6. MARKET BOARD BUCKET SOURCE AUDIT

## Source facts

- `ASC_BoardBuildBucketTopRows(...)` filters by canonical main bucket, requires `bucket_shortlisted`, requires `bucket_rank > 0`, sorts ascending by `bucket_rank`, and truncates to five.
- `ASC_BoardAppendBucketTopFive(...)` writes `<Bucket> — Top 5`, with Open Markets, Candidates, Bucket Top-5 Ready, Promoted, Session, bucket truth trace, and symbol blocks.
- `ASC_BoardBuildMainBucketSectionOrder(...)` uses preferred bucket ids `fx`, `indices`, `stocks`, `metals`, `energy`, `crypto`, `rates`, `volatility`, `commodities`, `funds_etfs`, `unknown`, but only appends bucket sections that have rows.
- Stock family Top 5 sections are separately supported via sub-bucket rank availability and `filter.result_state == PASS`.

| Bucket / Family | Top5 Present? | Open Markets | Candidates | Ready Count | Promoted Count | Top Symbols | Notes |
|---|---:|---:|---:|---:|---:|---|---|
| Forex / `fx` | source-supported | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | Top-level bucket candidate for first implementation. |
| Indices | source-supported | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | Top-level bucket candidate. |
| Stocks | source-supported | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | Top-level bucket candidate; sub-families defer. |
| Metals | source-supported | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | Top-level bucket candidate. |
| Energy | source-supported | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | Top-level bucket candidate. |
| Crypto | source-supported | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | Top-level bucket candidate. |
| Rates/Volatility/Commodities/Funds/Unknown | source-supported if rows exist | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | Include dynamically only if source rows exist. |
| Stocks / US Stocks, HK Stocks, Europe Stocks, ETF/ETP | source-supported | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | Defer to RUN109; not first implementation. |
| Empty buckets | source-supported as no rows | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | none | Write manifest only; no fake children. |
| `packet_pending`, `blocked_by_warmup`, `unavailable_market_watch` | source/status semantics supported | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | runtime unavailable | Must become partial/degraded/not-actionable wording, not clean signals. |

**Verdict:** Market Board/L4 already owns bucket-local rank truth. Top5PerBucket must consume this source and must not recalculate Top 5.

---

# 7. GLOBALTOP10 FAMILY MODEL AUDIT

| GlobalTop10 Feature | Existing Behavior | Source Owner | Reuse For Top5PerBucket? | Risk |
|---|---|---|---:|---|
| family path | `Dossiers/GlobalTop10` under `state.server_root` | `ASC_Dispatcher.mqh` | yes, sibling path | low |
| staging path | `GlobalTop10/_staging/<publication_id>` | `ASC_Dispatcher.mqh` | yes | medium with bucket subfolders |
| archive path | `GlobalTop10/archive/<timestamp>` | `ASC_Dispatcher.mqh` | yes | medium |
| family manifest | `_family_manifest.txt` with state/signature/children/currentness | `ASC_Dispatcher.mqh` | yes | low |
| child dossier writing | staged child path then validate | `ASC_Dispatcher.mqh` + Dossier writer | yes | medium |
| child source identity | GlobalTop10 child identity + board signature | dispatcher/composer | yes, add bucket/rank identity | medium |
| deep hydration entitlement | L0-L6 with deferred L5 guard | dispatcher/composer/deep owner | partially | high if all 30+ children deep at once |
| promotion state | stage complete → archive live → promote staging → write live manifest | dispatcher/FileIO wrappers | yes | medium |
| partial/degraded state | explicit labels for degraded/deferred cases | dispatcher/status | yes | low |
| timing/queue behavior | cadence 300s, cursor/inflight/batch state, UI-priority/near-budget deferral | dispatcher/runtime state | yes with separate namespace | medium |
| readback/validation | required token readback for child/family completeness | dispatcher/FileIO wrappers | yes | medium |

**Verdict:** GlobalTop10 is the correct structural model, but Top5PerBucket needs its own state namespace and bucket manifests to avoid corrupting GlobalTop10 semantics.

---

# 8. TOP5PERBUCKET FAMILY CONTRACT DESIGN

| Contract Item | Decision | Reason | Source Owner |
|---|---|---|---|
| family name | `Top5PerBucket` | clear GlobalTop10 sibling | constants/runtime helper |
| path | `Dossiers/Top5PerBucket/` | no artifact root change | dispatcher path helper |
| first scope | top-level main buckets only | safest first implementation | dispatcher |
| sub-buckets | defer to RUN109 | source supports them, but timing proof needed | dispatcher/Market Board source |
| bucket slug | canonical bucket id sanitized | stable and dynamic | classification/source helper |
| child filename | `rank##_symbol.txt` | operator-readable rank identity | dispatcher helper |
| `_family_manifest` fields | state, source signature, bucket count, child target/written/pending/failed, promoted/partial/degraded, last symbol/error, safety tokens | family-level integrity | dispatcher |
| `_bucket_manifest` fields | bucket id/name, source signature, rank list, open/closed/uncertain/stale counts, target/written/pending/failed | fast bucket review | dispatcher |
| current/staging/archive | mirror GlobalTop10 | avoids partial live family | dispatcher/FileIO wrappers |
| partial wording | `staging_partial`, `current_partial`, `deep_pending`, `retained_last_good`, `promoted_degraded` | prevents fake complete wording | dispatcher/status |
| child hydration class | Option C | best utility without all-child deep dump | dispatcher/composer |
| source identity | board pass UTC, shortlist pass UTC, bucket id/name, bucket rank, runtime/canonical symbol, source signature | traceability | dispatcher |
| Market Board signature | bucket top5 signature + board publication/epoch | avoid board-child mismatch | dispatcher/Market Board helper |
| selected/current symbol | no effect | Current Focus remains separate | none |
| empty buckets | manifest only | no fake child files | dispatcher |
| closed/uncertain/stale | not actionable | safety | L1/L2 state projection |
| bucket membership change | forced rebuild on bucket Top5 signature change | existing source-change logic already recognizes this class | dispatcher |

---

# 9. HYDRATION ENTITLEMENT DECISION

| Option | Pros | Cons | Timing Risk | Truth Risk | Recommended? |
|---|---|---|---|---|---:|
| A — all children `TOP_BUCKET5_L0_L6` | richest complete family | likely 30+ deep children; high timer/HUD pressure | high | medium | no |
| B — all children L0-L4 plus deep pending | fast broad files | leaders may not be deep immediately | low/medium | low | fallback |
| C — rank #1–#3 deep first, #4–#5 L0-L4 pending | best practical packet utility with bounded load | more manifest complexity | medium | low if explicit | yes |

**Recommendation:** Option C. RUN108 should deep-hydrate bucket ranks #1–#3 first and mark #4–#5 as `deep_pending` until the queue catches up.

---

# 10. TIMING / QUEUE / BUDGET DESIGN

| Queue Item | Design Decision | Budget Rule | Proof Token |
|---|---|---|---|
| candidate discovery | snapshot committed shortlist rows only | no new scan | `bucket_count=` |
| family build | enqueue from bucket signature | cadence 300s or material signature change | `top5_per_bucket_family_state=` |
| child target | top-level buckets × up to 5 | no sub-family multiplication in RUN108 | `bucket_child_target_count=` |
| max child writes/heartbeat | 1 child per write beat initially | 2 only after live timing proof | `bucket_child_written_count=` |
| max ms/heartbeat | use write-lane budget/near-budget guard; target side slice <=20–35ms | no heartbeat cadence change | `top5_per_bucket_queue_remaining=` |
| UI priority | defer family side duty during UI-priority window | HUD first | `ui_priority_side_reduced=yes` |
| write-lane purity | service only in write lane | no scan/read mutation | `scan_write_read_law_preserved=true` |
| retry | bounded child retry then degraded | no infinite retry loop | `bucket_child_failed_count=` |
| partial | staging partial allowed; live current only after validation/degraded manifest | no fake complete | `bucket_family_partial=` |
| stale current | retain previous current on failed staging | do not delete current prematurely | `bucket_family_promoted=false` |
| archive | archive current before promote | same model as GlobalTop10 | `bucket_family_promoted=` |
| refresh | initial 300s | same as GlobalTop10 5-minute cadence | `next_refresh_sec=300` |
| forced rebuild | bucket Top5 signature changed | no rank formula change | `rebuild_reason=bucket_top5_signature_changed` |
| closed trigger | update actionability posture only | no actionable closed names | `closed_symbols_actionable=false` |

---

# 11. CLOSED / OPEN / ACTIONABLE SAFETY

| Safety Rule | Required Behavior | Proof |
|---|---|---|
| Open Confirmed required | actionable only when existing L1/L2 gates support open/tradeable ordinary consumption | child header + manifest counts |
| Closed Confirmed | retained only as not-actionable | `closed_symbols_actionable=false` |
| Unknown/Uncertain | never actionable | `uncertain_symbols_actionable=false` |
| Tick freshness | copied from existing state | `tick_freshness=` |
| session/tradeability | visible in manifest/header | `session_status=`, `tradeability_status=` |
| Market Board wording | no trade list/entry priority claims | `trade_signal=false` |
| child posture | include family, bucket rank, source signature, actionability, hydration state | child top header tokens |

---

# 12. MANIFEST / LOGGING / PROOF DESIGN

| Proof Surface | Required Fields | Why |
|---|---|---|
| `_family_manifest.txt` | family state, source signature, bucket count, child target/written/pending/failed, promoted/partial/degraded, last error/symbol, safety tokens | one-glance family integrity |
| `_bucket_manifest.txt` | bucket id/name, rank list, child counters, actionability counts, source signature | fast bucket-local review |
| function_results line | branch/result/counters/queue/last error/protected tokens | machine-readable proof |
| heartbeat_telemetry | side-duty ms, budget yield, queue remaining, UI-priority defer | timing proof |
| Scanner Status | family state and queue/degraded summary | operator status |
| Artifact Bundle Manifest | current/staging/archive alignment | publication integrity |
| Market Board reference | source signature and bucket count | source traceability |
| child top header | family role, bucket id/name/rank, source signature, actionability, hydration state | prevents child-vs-board contradiction |

Required tokens:

```text
top5_per_bucket_family_state=
bucket_count=
bucket_child_target_count=
bucket_child_written_count=
bucket_child_pending_count=
bucket_child_failed_count=
bucket_family_promoted=
bucket_family_partial=
bucket_family_degraded=
bucket_manifest_written=
top5_per_bucket_queue_remaining=
top5_per_bucket_last_symbol=
top5_per_bucket_last_error=
closed_symbols_actionable=false
rank_formula_change=false
trade_signal=false
execution_change=false
```

---

# 13. SOURCE OWNER MAP

| Responsibility | Existing Owner | New Code Needed? | Preferred Patch File | Forbidden Owner |
|---|---|---:|---|---|
| bucket list discovery | Market Board/shortlist/classification rows | yes | `ASC_Dispatcher.mqh` helper | HUD |
| top5 extraction | bucket rank fields / Market Board logic | yes | dispatcher/shared helper | new rank formula |
| child enqueue | GlobalTop10-like runtime queue | yes | `ASC_RuntimeState.mqh`, `ASC_Dispatcher.mqh` | Market Board writer |
| child composition | Dossier writer/composer | context only | `ASC_DossierWriter.mqh`, `ASC_DossierComposer.mqh` | new truth engine |
| family manifest | GlobalTop10 manifest pattern | yes | `ASC_Dispatcher.mqh` | FileIO rewrite |
| bucket manifest | new simple manifest composer | yes | `ASC_Dispatcher.mqh` | HUD |
| staging/current/archive | GlobalTop10 promotion pattern | yes | `ASC_Dispatcher.mqh` using wrappers | direct filesystem rewrite |
| function_results proof | existing recorder | yes | `ASC_Dispatcher.mqh` | Dossier sections |
| Scanner Status proof | existing status writer | yes | `ASC_ScannerStatusWriter.mqh` | Market Board writer |
| Artifact Manifest proof | existing dispatcher manifest | yes | `ASC_Dispatcher.mqh` | Dossier composer |
| timing/queue state | runtime state | yes | `ASC_RuntimeState.mqh` | HUD |
| open/closed safety | L1/L2 state | projection only | dispatcher | new session engine |
| Current Focus non-ownership | existing Current Focus law | no | none | Top5PerBucket |
| HUD later consumption | read-only future | no in RUN107/108 | future HUD pass | truth ownership |

---

# 14. IMPLEMENTATION PHASE PLAN

| Run | Type | Target | Acceptance | Risk |
|---|---|---|---|---|
| RUN107R | source contract + skeleton | constants/path helpers/state/signature helpers/manifest skeleton/status tokens | compile-safe skeleton; no family promotion; no rank/order/formula change | low/medium |
| RUN108R | queued child writing | top-level bucket queue, bounded write budget, manifests, Option C hydration | one child per beat; honest partial/degraded manifests; current retained on failure | medium |
| RUN109R | hardening/sub-family readiness | dynamic stock sub-families if timing allows, archive polish, compile-risk scan | sub-families only with proof; live proof checklist ready | medium |

Next live proof: after RUN109R readiness only.

---

# 15. REGRESSION GUARD

| Protected Area | Guard |
|---|---|
| FileIO atomic contract | Reuse existing wrappers; no rewrite. |
| Market Board order | Consume source rows/signature only. |
| GlobalTop10 formula/order | Do not touch rank/snapshot logic. |
| L3 score | No score edits. |
| L4 rank order | No formula/order edits. |
| Dossier writer ownership | Compose only; no rank truth. |
| Current Focus ownership | No Top5PerBucket influence. |
| HUD read-only law | No HUD work. |
| Strategy/execution | No strategy or execution edits. |
| BUY/SELL / OrderSend / CTrade | Forbidden. |
| lot sizing / SL / TP | Forbidden. |
| heartbeat cadence | unchanged. |
| scan/write/read lane law | write-lane side duty only. |

---

# 16. TRUE ROADMAP PROGRESS UPDATE

Added this run:

- confirmed source-level bucket Top5 owner exists;
- confirmed GlobalTop10 source pattern is reusable;
- confirmed live runtime outputs were absent from uploaded zip;
- selected top-level buckets first;
- selected Option C hydration;
- created RUN107R/RUN108R/RUN109R plan.

Not claimed:

- no MT5 source patch;
- no Top5PerBucket family created;
- no compile proof;
- no live proof;
- no runtime child/manifest proof.

---

# 17. NEXT_PROMPT_SEED

```text
GIT HEADER

TRUTH SEEKER ROADMAP — RUN107R / TOP5 PER BUCKET FAMILY SOURCE CONTRACT + SKELETON IMPLEMENTATION
SOURCE PATCH RUN
ZIP-FIRST WORKFLOW REQUIRED
READ RUN106R TOP5 PER BUCKET DESIGN REPORT FIRST
NO LIVE OUTPUT REQUEST
NO COMPILE/LIVE CLAIM WITHOUT EVIDENCE
NO FULL CHILD HYDRATION YET
NO TOP5PERBUCKET CURRENT FAMILY PROMOTION IN RUN107R
NO RANK FORMULA CHANGE
NO MARKET BOARD ORDER CHANGE
NO GLOBALTOP10 FORMULA/ORDER CHANGE
NO L3/L4 SCORE/RANK CHANGE
NO STRATEGY/EXECUTION CHANGE
NO HUD WORK
NO FILEIO REWRITE
NO HEARTBEAT CADENCE CHANGE
NO SCAN/WRITE/READ LANE CHANGE

FIRST FILES TO READ:
1. roadmap/Truth Seeker/TRUTH_SEEKER_RUN106R_TOP5_PER_BUCKET_FAMILY_DESIGN_REPORT.md
2. roadmap/Truth Seeker/TRUTH_SEEKER_ROADMAP.md
3. mt5/runtime/ASC_Dispatcher.mqh
4. mt5/core/ASC_RuntimeState.mqh
5. mt5/core/ASC_Types.mqh
6. mt5/core/ASC_Constants.mqh
7. mt5/artifacts/ASC_DossierWriter.mqh
8. mt5/artifacts/dossier/ASC_DossierComposer.mqh
9. mt5/artifacts/ASC_MarketBoardWriter.mqh
10. mt5/artifacts/ASC_ScannerStatusWriter.mqh
11. mt5/io/ASC_FileIO.mqh read-only unless direct proof

PRIMARY TARGET:
Add Top5PerBucket source contract/skeleton only: path helpers, state fields, source signature model, manifest payload skeleton, function_results/status tokens, and no promoted family creation yet.

ACCEPTANCE:
- compile-safe source edits only;
- no new rank formula;
- no child hydration dump;
- no family promotion;
- required tokens present in source strings;
- GlobalTop10 untouched except read-only pattern reuse;
- control/report updated;
- changed-files zip preserves folder layout.
```

---

# 18. FINAL DECISION

AUTHORIZE — the design is clear enough for RUN107R to implement a bounded source contract/skeleton safely, because Market Board source already exposes bucket Top 5 truth and GlobalTop10 source already provides the structural family model; implementation must stay proof-honest because the uploaded zip lacked the expected runtime live output tree.
