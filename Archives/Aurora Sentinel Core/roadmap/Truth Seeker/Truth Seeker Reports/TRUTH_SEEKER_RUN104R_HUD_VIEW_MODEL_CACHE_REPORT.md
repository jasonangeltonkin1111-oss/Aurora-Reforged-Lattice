# TRUTH SEEKER ROADMAP — RUN104R / HUD VIEW-MODEL + CACHE + NO FILE READS DURING NAVIGATION

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN104R / HUD VIEW-MODEL + CACHE + NO FILE READS DURING NAVIGATION — PREPARED HUD DATA, NAVIGATION-SAFE READ MODEL, CURRENT FOCUS CACHE HARDENING, AND ZERO BLOCKING FILE PULLS ON ORDINARY PAGE CHANGES

## 2. OPERATOR SNAPSHOT

| Field | Result |
|---|---|
| User-reported latency | About 4 minutes for major bucket → minor bucket → symbol page navigation |
| Source patched | yes |
| Ordinary navigation file reads removed/deferred | yes — render-facing `ASC_HudReadCurrentFocusCached()` is now navigation-safe/cache-only |
| Current Focus cache hardened | yes |
| View-model/cache boundary added/hardened | yes — RUN104R display-only view-model fields + builder |
| Symbol detail hot path improved | yes — deep Current Focus fields use prepared VM fields after cache warm |
| Biggest remaining HUD bottleneck | Actual live proof is still absent; RUN105 must measure real click-to-render and cache hit/miss under terminal load |
| Next HUD target | RUN105R HUD performance closeout + live-proof readiness |
| Protected areas not touched | FileIO, rank/order/formula, Market Board order, Current Focus/Dossier/Market Board truth ownership, strategy/execution |
| Expected performance effect | Ordinary page changes no longer call Current Focus file read or modify-time check from render paths; cache miss shows stale/deferred posture and warms after render |

## 3. INPUT ZIP / FILE INTAKE SUMMARY

| Input | Inspection |
|---|---|
| `Aurora Sentinel Core(351).zip` | Extracted and inspected under one root: `Aurora Sentinel Core/...` |
| Source files | `mt5/hud/ASC_HUD_Manager.mqh`, version, runtime, artifacts, control files inspected |
| Reports present | RUN101R, RUN102R, RUN103R reports present |
| Live output files | No new live-proof output used for RUN104 |
| Nested roots | No competing source root chosen over `Aurora Sentinel Core/...` |

## 4. RUN103R ABSORPTION

| RUN103 Item | Verified In Source? | Remaining Gap | RUN104 Action |
|---|---:|---|---|
| cache-first object shell detection | yes | none for RUN104 | preserved |
| miss-only `ObjectFind()` | yes | none for RUN104 | preserved |
| cached object type for page-local hide | yes | none for RUN104 | preserved |
| text/style/visibility skip counters | yes | none for RUN104 | preserved |
| redraw request/flush/suppression counters | yes | none for RUN104 | preserved |
| object cache hit/miss telemetry | yes | none for RUN104 | preserved |
| object readback/find/delete telemetry | yes | none for RUN104 | preserved |
| render scope / render reason / mutation count | yes | none for RUN104 | preserved |
| hidden runtime selected-symbol sync classified | yes | sync not same as file read | preserved |
| object lifecycle patch preserved | yes | none | preserved |
| remaining read-model/file-read debt | yes | Current Focus read accessor still read files | patched |

## 5. ROADMAP AUTHORITY CHECK

Operator latency report remains authority. RUN104 follows RUN103 object optimization by cutting file/read-model debt from ordinary navigation.

## 6. INTERNET RESEARCH CONVERSION TABLE

| Research Area | Source | Finding | HUD View-Model / Cache Constraint | Patch / Audit Impact |
|---|---|---|---|---|
| MQL5 file sandbox / FileOpen | MQL5 File Functions / FileOpen docs | MQL5 file work is sandbox-controlled; file work is still file I/O and should not be hidden in hot UI paths | Do not pull artifact files during ordinary page changes | Current Focus file reads moved to explicit/manual/background accessor |
| FileFlush / FileClose | MQL5 FileFlush docs | Frequent flush calls may affect speed; file freshness/durability should be handled outside fast UI navigation | Cache freshness labels must be separate from truth ownership | RUN104 adds stale/deferred/manual-required cache posture |
| Chart object queue | MQL5 ObjectCreate/ObjectSet docs | Chart object operations enqueue commands; success can mean queued, not completed | Continue RUN103 cached object shell/skip strategy | RUN103 preserved; RUN104 avoids adding object churn |
| Synchronous readback | MQL5 object readback behavior docs | Synchronous checks can wait for chart queue | Avoid readback/file checks in render hot path | Current Focus modify-time check removed from render accessor |
| Timer work | MQL5 EventSetTimer docs | Timer events are not queued if one is present/processing | Background cache warm must be bounded and after UI render | Deferred Current Focus refresh occurs after priority render |
| ChartRedraw batching | MQL5 ChartRedraw docs | Redraw should remain grouped after object updates | Do not force redraw for cache miss | RUN103 redraw batching preserved |

## 7. PROMPT EVOLUTION / HUD PERFORMANCE PROMPT UPGRADE

| RUN103/RUN104 Prompt Weakness | Evidence | New Rule For RUN105 | Expected Improvement |
|---|---|---|---|
| Object optimization is not enough if render still reads files | `ASC_HudReadCurrentFocusCached()` could call `ASC_ReadTextFile()` | Every HUD run must grep all render-called accessors for file I/O | Prevent hidden 4-minute stalls |
| File reads and text parsing were not fully separated | Current Focus parsing happened inside deep render sections | Every HUD run must map file reads + large text parsing by navigation action | Faster symbol-to-symbol switching |
| Freshness and truth ownership can be confused | HUD cache can display stale truth | Every HUD run must label stale/deferred display as display-only | Avoid HUD becoming truth owner |
| Cache miss can block | Before RUN104, cache miss could trigger file read | Cache miss must show placeholder/stale posture and defer | Operator gets instant page movement |
| Object cache can hide stale UI risk | RUN103 optimizes object reuse | RUN105 must verify stale labels update correctly | Faster but truthful UI |
| Formula/rank drift risk | HUD runs touch large file | RUN105 must repeat protected-area grep | No accidental strategy drift |

## 8. HUD FILE READ / READ-MODEL OWNER MAP

| Read / View-Model Function | Source Owner | Reads File? | Parses Large Text? | Used During Ordinary Navigation? | Patch Candidate |
|---|---|---:|---:|---:|---|
| `ASC_HudReadCurrentFocusText` | HUD | yes after RUN104 only manual accessor | yes after manual/background | no ordinary nav | patched |
| `ASC_HudReadCurrentFocusCached` | HUD | no after RUN104 | no file read; uses cache | yes | patched |
| `ASC_HudCurrentFocusPath` | HUD | no | no | helper only | preserved |
| `ASC_HudCurrentFocusValue` | HUD | no | label scan | reduced through VM fields | partially patched |
| `ASC_HudQueueViewedCurrentFocusSync` | HUD/runtime | no direct file read in click handler | no | deferred after render | preserved |
| `ASC_HudEmitCurrentFocusFromDeepTrigger` | HUD/artifact writer path | artifact writer path | allowed deep trigger | no ordinary nav | preserved |
| render sections calling cached Current Focus | HUD | no after RUN104 | uses VM fields for common deep data | yes | patched |
| Market Board read/refresh paths | runtime/artifacts | runtime owns | possible outside HUD | no ordinary nav | audit only |
| Dossier read paths | runtime/artifacts | runtime owns | possible outside HUD | no ordinary nav | audit only |
| Open Symbol Snapshot read paths | runtime cache | no HUD file read found | no | runtime cache | preserved |
| view-model assembly inside render | HUD | no | no file read | yes | patched |
| symbol detail page builders | HUD | no after RUN104 | Current Focus common fields VM-backed | yes | patched |
| bucket/sub-bucket list builders | HUD | no file read found | no | yes | preserved |
| selected-symbol detail panels | HUD | no after RUN104 | reduced | yes | patched |
| lower detail controls | HUD | no file read found | no | yes | preserved |

## 9. ORDINARY NAVIGATION FILE-READ AUDIT

| Navigation Action | File Read Possible? | Large Parse Possible? | Source Evidence | Patch Needed |
|---|---:|---:|---|---|
| major bucket page open | no | no | runtime cache/list render | no |
| sub-bucket page open | no | no | runtime cache/list render | no |
| symbol list page open | no | no | prepared symbol indices | no |
| symbol detail entry | no after patch | reduced/cache-only | `ASC_HudReadCurrentFocusCached()` is cache-only | patched |
| symbol next/prev | no after patch | reduced/cache-only | same | patched |
| symbol detail section change | no after patch | reduced/cache-only | same | patched |
| back/forward page | no after patch | no file read | nav VM builder | patched |
| small-screen page controls | no | no | list paging | no |
| top 3/top 5/top10 quick browsing | no HUD artifact file read | no | shortlist cache | no |

## 10. CURRENT FOCUS CACHE HARDENING

| Current Focus Path | Before | After RUN104 | Navigation Safety |
|---|---|---|---|
| `ASC_HudReadCurrentFocusCached` | checked file modify time and could call `ASC_ReadTextFile` | cache-only, no file checks/reads | safe |
| `ASC_HudReadCurrentFocusFileCached` | did not exist | explicit file-reading accessor for manual/background | not used by ordinary render |
| cache state | implicit stale bool | `fresh/stale/missing/refresh_deferred/manual_refresh_required` strings | visible proof |
| cache miss | could block | placeholder/deferred posture | safe |
| background warm | mixed with read accessor | after priority render | safer |

## 11. HUD VIEW-MODEL / CACHE BOUNDARY

| View-Model Field | Exists? | RUN104 Patch | Truth Ownership Risk |
|---|---:|---|---|
| current page type | yes | `view_model_page_type` | display-only |
| current bucket | yes | `view_model_bucket` | display-only |
| current sub-bucket | yes | `view_model_sub_bucket` | display-only |
| selected symbol | yes | `view_model_selected_symbol` | display-only |
| selected symbol display name | yes | `view_model_selected_display_name` | display-only |
| selected market state label | yes | `view_model_market_state_label` | runtime label only |
| actionable posture label | yes | `view_model_actionable_posture_label` | not strategy |
| currentness label | yes | `view_model_currentness_label` | display-only |
| current focus cached summary | yes | `view_model_current_focus_summary` | display-only |
| market board cached summary | yes | `view_model_market_board_summary` | display-only |
| proof/cache freshness posture | yes | `view_model_cache_posture` | display-only |
| view_model_version | yes | `RUN104R_NAV_SAFE_VM` | none |
| view_model_last_built_ms | yes | telemetry | none |
| view_model_cache_hit/miss | yes | telemetry | none |
| view_model_dirty_reason | yes | telemetry | none |

## 12. DEFERRED CACHE WARM / BACKGROUND SERVICE

| Deferred Cache Warm Requirement | Source Support | RUN104 Patch |
|---|---|---|
| bounded work per heartbeat / priority service | timer queue docs | one Current Focus background read only after priority render |
| no full universe read | source grep | no HUD sweep added |
| no Dossier sweep from HUD | source grep | no Dossier HUD read added |
| no Market Board parse in click handler | source grep | no Market Board HUD read added |
| no Current Focus file read in click handler | patched accessor | yes |
| manual refresh explicit | `ASC_HudReadCurrentFocusText` routes manual accessor | yes |
| skip/stale posture visible | cache state/posture fields | yes |

## 13. SYMBOL PAGE / DETAIL PANEL HOT PATH

| Symbol Detail Section | Reads File? | Parses Current Focus Text? | Cache Safe? | Patch |
|---|---:|---:|---:|---|
| overview | no | no | yes | none |
| market watch/specs/trading conditions | no | no | yes | none |
| candidate filtering | no | no | yes | none |
| shortlist context | no | no | yes | none |
| deep analysis | no after patch | VM-backed common fields | yes | patched |
| trader context | no after patch | VM-backed common fields | yes | patched |
| structure/sweep/geometry | no after patch | sweep/bias VM-backed | yes | patched |
| lower detail buttons | no | no | yes | preserved |
| current focus fields | no in ordinary nav | background/manual only | yes | patched |

## 14. MARKET BOARD / DOSSIER READ PATH AUDIT

| Artifact | HUD Read Path | Ordinary Nav Uses It? | Patch / Boundary |
|---|---|---:|---|
| Market Board | refresh request only; runtime/artifact writer owns file | no | preserved |
| Dossier | writer/runtime paths; HUD does not directly sweep | no | preserved |
| Current Focus | HUD cache accessor | yes before; no file read after patch | patched |
| Open Symbol Snapshot | runtime state/packets | yes as runtime cache | preserved |

## 15. TELEMETRY EXTENSION

| Telemetry Field | Present Before | RUN104 Need | Patch |
|---|---:|---|---|
| hud_nav_file_reads | no | prove zero nav file reads | added |
| hud_nav_current_focus_reads | no | prove zero nav CF reads | added |
| hud_nav_dossier_reads | no | prove zero | added |
| hud_nav_market_board_reads | no | prove zero | added |
| hud_nav_large_parse_count | no | track hot-path parse debt | added |
| hud_nav_cache_hit_count | no | cache proof | added |
| hud_nav_cache_miss_count | no | cache proof | added |
| hud_nav_cache_deferred_count | no | deferred proof | added |
| hud_background_cache_read_count | no | background proof | added |
| hud_manual_cache_read_count | no | manual proof | added |
| hud_view_model_hit_count | no | VM proof | added |
| hud_view_model_miss_count | no | VM proof | added |
| hud_view_model_build_ms | no | VM timing proof | added |
| hud_view_model_dirty_reason | no | dirty reason proof | added |
| hud_cache_stale_display_count | no | stale display proof | added |
| hud_cache_placeholder_display_count | no | placeholder proof | added |

## 16. PATCH CANDIDATE MATRIX

| Candidate | Decision |
|---|---|
| Replace render-facing Current Focus read with cache-only accessor | patched |
| Add explicit background/manual file read accessor | patched |
| Add display-only view-model | patched |
| Rewrite FileIO | rejected |
| Touch Market Board rank/order | rejected |
| Strategy/execution changes | rejected |

## 17. PATCH TABLE

| File | Patch |
|---|---|
| `mt5/hud/ASC_HUD_Manager.mqh` | Added navigation-safe Current Focus cache accessor, file-read accessor split, cache state/posture, display-only view-model fields, VM builders, telemetry. |
| `mt5/core/ASC_Version.mqh` | Advanced to RUN104R identity/proof boundary. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` | RUN104R PASS entry. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md` | RUN104R changed-files manifest. |
| `roadmap/Truth Seeker/TRUTH_SEEKER_RUN104R_HUD_VIEW_MODEL_CACHE_REPORT.md` | Created this report. |

## 18. SOURCE FILES TOUCHED

- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_RUN104R_HUD_VIEW_MODEL_CACHE_REPORT.md`

## 19. PROTECTED AREAS NOT TOUCHED

FileIO, GlobalTop10 rank/order/formula, L3 score, L4 rank/order, Market Board order, Current Focus/Dossier/Market Board truth ownership, strategy/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP.

## 20. HUD PERFORMANCE ACCEPTANCE UPDATE

| HUD Acceptance Target | RUN103 Source State | RUN104 Source State | RUN105 Target | Proof Method |
|---|---|---|---|---|
| ordinary navigation performs zero file reads | not proven | source-designed zero | live proof | telemetry counters |
| symbol tab switching zero file reads | not proven | source-designed zero | live proof | telemetry counters |
| symbol-to-symbol no full parse | debt present | common fields VM-backed/cache-only | prove latency | telemetry + logs |
| cache miss deferred | not present | present | live proof | stale/deferred labels |
| manual/deep may queue heavy work after ack | present/deferred | preserved | live proof | click timing |
| view-model/cache hit counted | absent | present | live proof | proof summary |
| deferred cache warm bounded | not explicit | one Current Focus read after priority render | verify | timer logs |
| object lifecycle/redraw preserved | yes | yes | live proof | object/redraw counters |

## 21. STATIC COMPILE-SAFETY TABLE

| Static Compile Check | Result | Action |
|---|---|---|
| identifiers under 63 chars | pass by visual/static scan | kept concise |
| no giant `StringFormat` | pass | telemetry added as second StringFormat line |
| wrong parameter count | no obvious mismatch | compile still required |
| block-scoped variable used outside | no obvious mismatch | compile still required |
| missing helper declarations | checked; added `ASC_HudDeepBiasSummary` prototype | compile still required |
| include-order break | no include changed | compile still required |
| file accessor signature mismatch | explicit prototype/definition checked | compile still required |
| cache state helper mismatch | string states only | compile still required |
| recursive cache warm/render/service loop | no recursive render call added | compile still required |
| unbounded pending refresh state | deferred cleared after background read | compile still required |
| duplicate function names | none found | compile still required |
| strategy/execution includes touched | no | protected |

## 22. REGRESSION GUARD

No strategy/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP, rank/order/formula, Market Board order, FileIO rewrite, Dossier rewrite, or truth-owner drift was introduced. HUD remains a read-only display/cache consumer.

## 23. TRUE ROADMAP PROGRESS UPDATE

RUN104R materially advances the HUD performance warpath by cutting the hidden file-read path after RUN101 priority service, RUN102 event/render decoupling, and RUN103 object/redraw optimization.

## 24. RUN105R NEXT_PROMPT_SEED

RUN105R must close the HUD warpath with performance proof readiness: read RUN104 report/source first, verify telemetry compiles, run static grep for ordinary navigation file reads, validate stale/deferred cache labels, and prepare exact live proof checklist for click-to-ack, click-to-render, cache hit/miss, file reads, object churn, redraw count, and symbol-to-symbol navigation.

## 25. FINAL DECISION

PASS — RUN104R source-patched the navigation-safe cache/view-model boundary, removed Current Focus file-read calls from ordinary render/navigation accessor, preserved RUN102/RUN103 optimizations, extended telemetry, protected truth owners, and seeded RUN105R.
