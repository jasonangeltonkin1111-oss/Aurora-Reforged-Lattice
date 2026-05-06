# SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-09
## HUD SYMBOL DETAIL CARD BODY CONSTRUCTION + DETAIL PAGE HOT-PATH PRESSURE AUDIT / COMPILE-SAFETY ABSORPTION

Decision: HOLD — compile-safety blocker absorbed first; detail-card behavior patch held.
Proof boundary: `SPR09_compile_safety_absorption_source_patched_compile_not_claimed_live_not_claimed`

---

## 1. GIT HEADER SUMMARY

SPR-09 audited the symbol detail render seam after SPR-08 and found that `ASC_HudRenderSymbolDetailPage(...)` and `ASC_HudRenderStatDetailPage(...)` still construct many detail card/body strings before reaching the existing unchanged-label/ObjectSetString skip layer. However, the required SPR-08 compile-safety checkpoint found a current preprocessor compile-risk blocker in `ASC_Version.mqh`: a literal `\n#define ...` block embedded in the file instead of real newlines.

Per SPR-09 rules, that blocker was repaired first and the behavior optimization was held for the next patch. No HUD behavior, layout, wording, truth ownership, ranking, FileIO, artifact schema/path, heartbeat cadence, scan/write/read lane law, or ChartRedraw behavior was changed.

---

## 2. EXECUTIVE SUMMARY

- Real root was discovered before file access.
- SPR-02 through SPR-08 reports were found and read.
- SPR-08 tokens exist in source: `hud_text_build_skipped`, `hud_label_text_reused`, `hud_label_set_skipped_text`, `hud_row_text_cache_hit`, `hud_status_text_cache_hit`, `hud_clock_text_unchanged`, `hud_render_string_build_avoided`.
- HUD brace balance passed by static scan.
- `ASC_HudExtractLabeledValue(...)` has both prototype and definition before use.
- `ChartRedraw(0)` remains single/batched in `ASC_HudFlushPendingRedraw()`; no new redraw call was added.
- Compile-safety blocker found in `ASC_Version.mqh`: literal `\n` characters before `#define` directives.
- Patch applied: converted literal `\n` sequences to real newlines and updated version/run macros to SPR-09 compile-safety absorption.
- Detail-card/body cache behavior patch held, not applied.

---

## 3. ZIP / ROOT / FILE INTAKE SUMMARY

Discovery commands executed from extracted workspace:

```text
pwd
find . -maxdepth 6 -type f \( -name 'AuroraSentinelCore.mq5' -o -name 'ASC_Dispatcher.mqh' -o -name 'ASC_HUD_Manager.mqh' -o -name 'ASC_FunctionResults.mqh' -o -name 'ASC_FileIO.mqh' -o -name 'ASC_Version.mqh' -o -name 'TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md' -o -name '*SPR*' \) | sort
find . -type f -path '*Aurora Sentinel Core*' | head -300
find . -type f \( -iname '*SPR-02*' -o -iname '*SPR-03*' -o -iname '*SPR-04*' -o -iname '*SPR-05*' -o -iname '*SPR-06*' -o -iname '*SPR-07*' -o -iname '*SPR-08*' -o -iname '*HUD*' -o -iname '*DETAIL*' -o -iname '*CARD*' \) | sort
```

| Item | Discovered Path | Status |
|---|---|---|
| REPO_ROOT | `/mnt/data/spr09_work/Aurora Sentinel Core` | found |
| ASC_ROOT | `/mnt/data/spr09_work/Aurora Sentinel Core` | found |
| AuroraSentinelCore.mq5 | `mt5/AuroraSentinelCore.mq5` | found |
| ASC_Dispatcher.mqh | `mt5/runtime/ASC_Dispatcher.mqh` | found |
| ASC_HUD_Manager.mqh | `mt5/hud/ASC_HUD_Manager.mqh` | found |
| ASC_RuntimeState.mqh | `mt5/core/ASC_RuntimeState.mqh` | found |
| ASC_Constants.mqh | `mt5/core/ASC_Constants.mqh` | found |
| ASC_FunctionResults.mqh | `mt5/logging/ASC_FunctionResults.mqh` | found |
| ASC_FileIO.mqh | `mt5/io/ASC_FileIO.mqh` | found/read-only |
| ASC_Version.mqh | `mt5/core/ASC_Version.mqh` | found/patched |
| SPR-02 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR02_WRITE_LANE_TIME_SLICE_REPORT.md` | found |
| SPR-03 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR03_READBACK_MANIFEST_BACKFILL_PRESSURE_REPORT.md` | found |
| SPR-04 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR04_HUD_PRIORITY_CURRENT_FOCUS_CACHE_WARM_REPORT.md` | found |
| SPR-05 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR05_HUD_OBJECT_PROPERTY_CHURN_REDRAW_PRESSURE_REPORT.md` | found |
| SPR-06 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR06_VIEWPORT_LAYOUT_TRANSITION_RESET_STORM_REPORT.md` | found |
| SPR-07 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR07_HUD_PROOF_SUMMARY_HEARTBEAT_PROOF_PRESSURE_REPORT.md` | found |
| SPR-08 report/control | `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR08_HUD_RENDER_TEXT_UNCHANGED_LABEL_PRESSURE_REPORT.md` | found |

---

## 4. SPR-02 THROUGH SPR-08 BASELINE VERIFICATION

| Baseline Area | Verified? | Evidence |
|---|---:|---|
| SPR-02 write-lane budget/yield | yes | SPR-02 report found; dispatcher was read-only in SPR-09. |
| SPR-02 Dossier queue early-yield | yes | SPR-02 report states bounded Dossier queue early-yield and UI-priority write reduction. |
| SPR-02 FileIO untouched | yes | `ASC_FileIO.mqh` read-only in SPR-09. |
| SPR-03 side-duty yield | yes | SPR-03 report found; dispatcher read-only. |
| SPR-03 deferred readback/manifest/presence/scanner duties | yes | SPR-03 report found; no FileIO/artifact changes in SPR-09. |
| SPR-04 Current Focus priority cache-only | yes | HUD still contains priority cache-only posture/counters; no Current Focus writer/FileIO edit. |
| SPR-04 stale/pending/missing posture | yes | `current_focus_cache_posture` and deferred cache state paths retained. |
| SPR-05 object/redraw dedupe | yes | Object cache signature path and single batched `ChartRedraw(0)` retained. |
| SPR-06 viewport/layout/transition gating | yes | `ASC_HudViewportMaterialChange(...)` and transition/dirty gates retained. |
| SPR-07 proof emit-gating | yes | `hud_summary_build_skipped`, `hud_summary_lowfreq_only`, `proof_string_build_avoided`, `proof_emit_gate_blocked` retained. |
| SPR-08 ordinary text/unchanged label patch | yes | Required tokens present in HUD source. |
| FileIO rewrite absent | yes | `ASC_FileIO.mqh` not modified. |
| Artifact truth/schema/path unchanged | yes | Current Focus, Dossier, Market Board writers not modified. |
| Ranking/order/formulas unchanged | yes | No selection/filter/shortlist source files modified. |
| Lane/timer cadence unchanged | yes | Dispatcher and main EA not modified. |
| HUD redesign absent | yes | No HUD source behavior/layout edit was applied in SPR-09. |

---

## 5. SPR-08 COMPILE-SAFETY CHECKPOINT

| Check | Result | Evidence / Decision |
|---|---:|---|
| HUD brace balance | pass | Static brace scan returned balance `0`, minimum `0`. |
| SPR-08 helper/counter names declared before use | pass | SPR-08 counters are in `g_asc_hud`; label extractor has prototype and definition. |
| SPR-08 fields initialized/reset | pass | Counters reset in HUD reset path. |
| Undefined helper calls from SPR-08 | pass | `ASC_HudExtractLabeledValue` prototype/definition/use found. |
| Unknown-to-string risk in proof summary | pass | SPR-08 counters use explicit `IntegerToString` assembly. |
| Duplicate macros in `ASC_Version.mqh` | pass after patch | Literal newline blocker repaired; no duplicate current-run/version macro added. |
| ChartRedraw added by SPR-08 | pass | Only one `ChartRedraw(0)` remains in the batched flush path. |
| ObjectSetString skip uses hot ObjectGetString | pass | Unchanged-text skip uses local object cache signature, not object readback. |
| Same-second clock early return suppresses real state/freshness | pass by source boundary | Same-second clock/display-only skip is limited to clock/display-only fast path; tactical/data fingerprints remain separate. |
| Compile-risk blocker | found/repaired | `ASC_Version.mqh` contained literal `\n#define` block; converted to real newlines. |

Because a compile-risk blocker was found, SPR-09 stops before behavior optimization. Detail-body/card caching is seeded for the next run, not applied here.

---

## 6. INTERNET RESEARCH CONVERSION TABLE

| Research Finding | Source Constraint | File / Function Target | Patch Decision |
|---|---|---|---|
| Timer events are not queued if a Timer event is already queued or processing. | Keep per-heartbeat HUD/detail render work bounded. | `ASC_HUD_Manager.mqh` detail render seam | Supports detail body cache patch, but behavior patch held due compile-safety blocker. |
| Events are processed one after another in order of receipt. | Long HUD string-building can delay later chart/UI event handling. | `ASC_HudRenderSymbolDetailPage`, `ASC_HudRenderStatDetailPage` | Audit confirms next seam; patch held. |
| Object property setters are asynchronous chart commands. | Avoid unnecessary setter calls and avoid building text that will not be sent. | `ASC_HudEnsureLabel`, `ASC_HudSetLabelTextIfExists`, detail cards | Existing SPR-08 skip preserved; detail-specific pre-build skip remains next patch target. |
| ChartRedraw is forced redraw. | Do not add redraw calls to hide detail render cost. | `ASC_HudRequestRedraw`, `ASC_HudFlushPendingRedraw` | No new `ChartRedraw` added. |
| String helpers/StringFormat are real construction work in hot code. | Avoid large repeated string assembly in unchanged detail pages. | detail card/body builders | Next prompt should add cheap detail source fingerprint before building card bodies. |

---

## 7. SYMBOL DETAIL PAGE ENTRY / RENDER TRACE

| Detail Page Path | File / Function | Trigger | Uses Cache? | Builds Text? | Object Ops? | Patch Needed? |
|---|---|---|---:|---:|---:|---:|
| symbol detail entry | `ASC_HUD_Manager.mqh` / `ASC_HudClassifyControl`, `btn_symbol`, `btn_details` | click/navigation | partial | no | yes ack/object path | no direct SPR-09 patch |
| Prev/Next page controls | `ASC_HudPagePrev`, `ASC_HudPageNext` | footer pager | page/list navigation | no | yes via render | no direct SPR-09 patch |
| selected symbol detail overview | `ASC_HudRenderSymbolDetailPage` | symbol overview/detail render | uses prepared runtime caches | yes | yes via cards | next patch target |
| aspect/stat detail page | `ASC_HudRenderStatDetailPage` | selected section/detail render | uses runtime/Current Focus cache/view model | yes, heavy | yes via cards | next patch target |
| Current Focus posture | `ASC_HudReadCurrentFocusFileCached`, `cf_vm_*` values | non-priority background cache service | cache-only in priority | yes from cached VM | labels/cards | no priority file-read regression found |

---

## 8. DETAIL CARD / BODY TEXT BUILDER TRACE

| Detail Text Builder / Card | File / Function | Built Every Detail Render? | Source Revision/Fingerprint? | Safe to Cache? | Patch Decision |
|---|---|---:|---:|---:|---|
| selected symbol hero | `ASC_HudRenderSymbolDetailPage` / `sym_hero` | yes | tactical/detail fingerprint possible | yes | held due compile-safety blocker |
| symbol identity/state | `ASC_HudRenderSymbolDetailPage` / `sym_identity` | yes | selected symbol + section + L1/L2/shortlist | yes | held |
| market snapshot | `ASC_HudRenderSymbolDetailPage` / `sym_market` | yes | selected symbol + L2 packet | yes | held |
| selection snapshot | `ASC_HudRenderSymbolDetailPage` / `sym_tick` | yes | filter/shortlist packet | yes | held |
| shortlist summary | `ASC_HudRenderSymbolDetailPage` / `sym_pub` | yes | shortlist source/revision/count | yes | held |
| Overview section cards | `ASC_HudRenderStatDetailPage` / `stat_block_*` | yes | selected symbol + L1/L2/L3/L4 | yes | held |
| Market Watch section cards | `ASC_HudRenderStatDetailPage` / `stat_block_*` | yes | L2 packet/tick/freshness | yes if packet unchanged | held |
| Specification section cards | `ASC_HudRenderStatDetailPage` / `stat_block_*` | yes | symbol/spec context | yes | held |
| Selection Filter cards | `ASC_HudRenderStatDetailPage` / `stat_block_*` | yes | filter packet | yes | held |
| Shortlist Context cards | `ASC_HudRenderStatDetailPage` / `stat_block_*` | yes | shortlist source/revision/count/rank | yes | held |
| Deep Analysis cards | `ASC_HudRenderStatDetailPage` / `stat_block_*` + `cf_vm_*` | yes, heaviest | Current Focus cache metadata + VM fields + subpage | yes if cache/subpage unchanged | held |

---

## 9. DETAIL LABEL UPDATE PATH TRACE

| Detail Label Path | Trigger | Text Built First? | Skips ObjectSetString If Unchanged? | Patch Decision |
|---|---|---:|---:|---|
| `ASC_HudRenderCard` title/lines | every detail card render | yes | yes through object signature and SPR-08 label skip | next patch should skip earlier |
| `ASC_HudEnsureLabel` | generic label render | caller builds text first | yes via full signature | preserved |
| `ASC_HudSetLabelTextIfExists` | fast existing-label updates | caller builds text first | yes via cached text suffix | preserved |
| Deep subpage buttons | Deep Analysis section | yes | button signature skip | preserved |
| Footer/detail controls | page render/navigation | yes | button signature skip | preserved |

---

## 10. SYMBOL DETAIL DATA INVALIDATION TRACE

| Detail Invalidation Source | Trigger | Should Rebuild Detail Body? | Current Behavior | Patch Decision |
|---|---|---:|---|---|
| selected symbol change | symbol click / prev-next symbol workflow | yes | rebuilds body/cards | preserve; next patch must invalidate |
| selected symbol section change | detail section button | yes | rebuilds section body/cards | preserve; next patch must invalidate |
| deep subpage change | Deep Analysis subpage buttons | yes | rebuilds deep cards | preserve; next patch must invalidate |
| Current Focus cache modified/read state | deferred background cache service | affected deep/current focus cards only | rebuilds when render runs | next patch should fingerprint affected cards |
| L2 packet/tactical quote changes | live market watch cadence | affected market/execution cards | rebuilds | next patch should include tactical signature |
| shortlist revision/source/count | shortlist publication | affected selection/shortlist cards | rebuilds | next patch should include shortlist signature |
| viewport/layout geometry | chart resize/material layout change | yes if geometry changes | rebuilds | next patch must include x/y/w/viewport |

---

## 11. PATCH DECISION

Patch applied only to compile-safety blocker in `ASC_Version.mqh`.

Detail card/body caching was **not** applied because the SPR-08 compile-safety checkpoint found a compile-risk blocker first. The detail hot path is confirmed as patchable, but the requested rule requires compile-safety absorption before behavior optimization.

---

## 12. PATCH DETAILS IF PATCHED

Patched file:

- `mt5/core/ASC_Version.mqh`

Changes:

- Replaced literal `\n` characters embedded before `#define` directives with real newlines.
- Updated `ASC_VERSION_LABEL` to `SPR-09-HudDetailCompileSafetyAbsorption`.
- Updated current run macro to `SPR-09`.
- Updated next live proof macro to `SPR-09-final-live-proof-pending`.
- Added compact SPR-09 scope/boundary/proof/research/patch summary macros.

---

## 13. DETAIL BODY FINGERPRINT POLICY

Held for next source patch. Recommended smallest next patch:

- add a cheap detail-body source signature keyed by page, selected symbol, selected section, deep subpage, x/y/w/viewport, L1 tactical signature, L2 packet/tactical signature, shortlist source/revision/pass/count, and Current Focus cache metadata/view-model revision fields;
- if unchanged, skip detail body/card string construction and reuse already-rendered object text/signatures;
- if changed, rebuild from existing prepared truth/cache only;
- do not read files or make HUD a truth owner.

---

## 14. DETAIL CARD TEXT CACHE POLICY

Held for next source patch.

Cache only final display strings or skip entire already-rendered body when the visible detail source signature is unchanged. Do not cache raw trading truth as HUD authority.

---

## 15. PREV / NEXT DETAIL NAVIGATION POLICY

Held for next source patch.

Prev/Next or selected-symbol changes must invalidate the detail cache and force rebuild. Prior-symbol card strings must never be reused under a new symbol.

---

## 16. TELEMETRY ADDED / PRESERVED

Added:

- no HUD telemetry added in SPR-09 due compile-safety hold.
- SPR-09 version/proof macros added in `ASC_Version.mqh`.

Preserved:

- `hud_text_build_skipped`
- `hud_label_text_reused`
- `hud_label_set_skipped_text`
- `hud_row_text_cache_hit`
- `hud_status_text_cache_hit`
- `hud_clock_text_unchanged`
- `hud_render_string_build_avoided`
- SPR-05 object/redraw counters
- SPR-06 viewport/transition counters
- SPR-07 proof emit-gate counters

Next patch should add:

- `hud_detail_body_cache_hit=`
- `hud_detail_body_build_skipped=`
- `hud_detail_card_text_reused=`
- `hud_detail_label_set_skipped=`
- `hud_detail_source_unchanged=`
- `hud_detail_source_invalidated=`
- `hud_detail_nav_cache_miss=`

---

## 17. PROTECTED AREAS NOT TOUCHED

- trading logic: not touched
- ranking/order/formulas: not touched
- Market Board order: not touched
- Top3/Top5/Top10 order: not touched
- Dossier truth/schema/path: not touched
- Current Focus truth/schema/path: not touched
- FileIO atomic contract: not touched
- heartbeat cadence: not touched
- scan/write/read lane law: not touched
- HUD truth ownership: not changed
- HUD layout/operator wording: not changed
- ChartRedraw: not changed

---

## 18. COMPILE / TEST STATUS

- Static HUD brace check: pass.
- Static SPR-08 helper/counter scan: pass.
- Static version macro newline check: repaired.
- MetaEditor compile: unavailable in this environment; compile not claimed.
- Live/runtime proof: not run; not claimed.

---

## 19. CHANGED FILES

- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/SYSTEM_PERFORMANCE_REPAIR_SPR09_HUD_SYMBOL_DETAIL_CARD_BODY_HOT_PATH_REPORT.md`

---

## 20. NEXT PERFORMANCE PROMPT SEED

Next run should be **SPR-09B / HUD DETAIL BODY CACHE PATCH AFTER COMPILE-SAFETY ABSORPTION**.

Prompt seed:

```text
GIT HEADER

SYSTEM PERFORMANCE REPAIR MINI-ROADMAP — SPR-09B / HUD DETAIL BODY SOURCE FINGERPRINT + CARD BODY BUILD SKIP
ZIP-FIRST WORKFLOW REQUIRED
READ SPR-09 REPORT FIRST
DO NOT REDO SPR-09 VERSION NEWLINE REPAIR
VERIFY ASC_Version.mqh HAS NO LITERAL \n#define BLOCKS BEFORE PATCHING
PATCH ONLY ASC_HUD_Manager.mqh UNLESS A DIRECT COMPILE-SAFETY NEED EXISTS
NO HUD LAYOUT CHANGE
NO OPERATOR WORDING CHANGE
NO TRUTH / RANKING / ARTIFACT / FILEIO / LANE / TIMER CHANGE
NO CHARTREDRAW ADDED

Goal: implement the smallest safe detail-body source signature/cache gate so unchanged selected-symbol detail pages skip expensive card/body string construction before labels/cards are rebuilt.

Required behavior:
- selected symbol / selected section / deep subpage / geometry change invalidates detail cache.
- L1/L2/tactical/shortlist/Current Focus cache-view-model changes invalidate affected detail body.
- if unchanged, skip detail body/card string construction and increment compact proof counters.
- preserve SPR-02 through SPR-08 protections and the SPR-09 compile-safety fix.
- produce changed-files zip and report.
```
