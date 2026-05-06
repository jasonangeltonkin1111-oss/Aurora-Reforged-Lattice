# TRUTH SEEKER ROADMAP — RUN105B / HUD COMPILE BLOCKER REPAIR + DEEP STATIC DEBUG

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN105B / HUD COMPILE BLOCKER REPAIR + DEEP STATIC DEBUG — FIX MISSING HUD HELPERS, ENUM-TO-STRING SCOPE PROOF, CURRENT FOCUS LABEL EXTRACTION, AND FULL HUD WARPATH COMPILE-RISK AUDIT BEFORE LIVE PROOF

Run Type: HUD compile-blocker source patch / deep static debug / control update / no-live repair  
Decision: PASS  
Proof Boundary: `hud_compile_blockers_source_patched_compile_not_claimed_live_not_claimed_next_live_RUN106R`  
Compile Claim: not claimed  
Live Claim: not claimed

## 2. OPERATOR SNAPSHOT

| Field | Result |
|---|---|
| compile errors received | yes |
| source patched | yes |
| `ASC_HudExtractLabeledValue` fixed | yes |
| `ASC_HudRenderScopeName` fixed | yes |
| undeclared HUD helper sweep completed | yes |
| proof summary formatting audited | yes |
| RUN101–RUN104 HUD intent preserved | yes |
| compile proof claimed | no — no MetaEditor output exists in this run |
| next live proof | ready by source inspection, but RUN106R must begin with actual MetaEditor compile output |
| biggest remaining risk | only actual MetaEditor can confirm no compiler-specific issue remains after the static repair |

## 3. INPUT ZIP / FILE INTAKE SUMMARY

| Input | Inspection |
|---|---|
| `/mnt/data/Aurora Sentinel Core(353).zip` | extracted and inspected |
| Root selected | `Aurora Sentinel Core/...` |
| File count | 606 files |
| Directory count | 93 directories |
| Nested roots | no competing nested source root selected over `Aurora Sentinel Core/...` |
| Priority evidence | operator MetaEditor compile errors in prompt |
| Primary source | `mt5/hud/ASC_HUD_Manager.mqh` |
| Version/control files | `mt5/core/ASC_Version.mqh`, active log, output manifest |
| Reports read | RUN101R, RUN102R, RUN103R, RUN104R, RUN105R reports present and checked for HUD warpath intent |
| Live output | not required and not used |

## 4. COMPILE ERROR INTAKE TABLE

| Compile Error / Location | Cause Verified | Patch |
|---|---:|---|
| `ASC_HUD_Manager.mqh` old line 2925: undeclared `ASC_HudExtractLabeledValue` | yes | added compile-visible helper and prototype |
| `ASC_HUD_Manager.mqh` old line 2927: same missing helper cascade | yes | same helper now resolves label B fallback |
| `ASC_HUD_Manager.mqh` old line 2929: same missing helper cascade | yes | same helper now resolves label C fallback |
| unexpected comma / operator expected / unknown-to-string cascade | yes | vanished by defining missing string-return helper |
| `ASC_HUD_Manager.mqh` old line 13934: undeclared `ASC_HudRenderScopeName` | yes | added enum-to-string helper after `ASC_HudRenderScope` enum |
| `last_render_scope` operator expected / unknown-to-string cascade | yes | vanished by adding typed `ASC_HudRenderScope` parameter helper |

## 5. ROADMAP AUTHORITY CHECK

| Authority | Result |
|---|---|
| Operator compile errors | highest authority for RUN105B |
| RUN105R patched source | inspected as active source baseline |
| RUN104R baseline | preserved zero-file-read navigation/cache/view-model intent |
| RUN103R baseline | preserved object cache/redraw batching/skip counters |
| RUN102R baseline | preserved click ack, pending navigation, deferred render |
| RUN101R baseline | preserved HUD priority service and latency telemetry |
| Active roadmap/control | updated after source patch |

## 6. INTERNET RESEARCH CONVERSION TABLE

| Compile / Debug Issue | Official Finding | Source Constraint | File / Line Target | Patch Applied |
|---|---|---|---|---|
| missing helper declaration / definition | MQL5 functions are global-scope declarations/definitions; a call must resolve to a known function signature | add helpers at global scope before first use or prototype before use | `ASC_HUD_Manager.mqh` current 687 and 1708 | added `ASC_HudExtractLabeledValue(...)` prototype and definition |
| enum-to-string unknown return | MQL5 function calls evaluate to the return type of the declared function | render scope helper must return `string` and accept `ASC_HudRenderScope` | `ASC_HUD_Manager.mqh` current 169 | added `ASC_HudRenderScopeName(...)` with all enum members |
| high-risk variadic formatting | `StringFormat` uses format specifiers and variadic parameters; mismatch risk grows with large format blocks | prefer typed string assembly for proof telemetry | `ASC_HUD_Manager.mqh` current 7662 and 14997 | split leader trace and driver summary formatting |
| explicit number/string conversion | official conversion functions include string formatting and number-to-string conversion paths | convert integers explicitly before concatenating proof strings | HUD proof/trace builders | used `IntegerToString(...)` and existing `ASC_HudBoolText(...)` |
| object/name length caution | official chart-object docs state object names should not exceed 63 chars; previous RUN050A also proved identifier length caution matters | new helper names must stay short | new helper identifiers | helper identifiers remain under 63 chars |

## 7. ASC_HudExtractLabeledValue REPAIR

| Helper | Added / Fixed | Location | Return Type | Compile Risk Removed |
|---|---|---|---|---|
| `ASC_HudExtractLabeledValue(const string text,const string label)` | added | prototype near current line 687; definition near current line 1708 | `string` | missing helper at old lines 2925/2927/2929 |

Behavior:
- returns `""` on empty text, empty label, or no match
- uses `StringFind(text,label,0)`
- advances past the matched label
- skips `:`, `=`, spaces, and tabs
- extracts only to the next `\n`, `\r`, or `|`
- trims result with existing `ASC_HudTrim(...)`
- does not read files
- does not own truth

## 8. ASC_HudRenderScopeName REPAIR

| Enum Member | Render Scope Name | Covered? |
|---|---|---:|
| `ASC_HUD_SCOPE_NONE` | `none` | yes |
| `ASC_HUD_SCOPE_OVERVIEW` | `overview` | yes |
| `ASC_HUD_SCOPE_LIST` | `list` | yes |
| `ASC_HUD_SCOPE_SYMBOL_OVERVIEW` | `symbol_overview` | yes |
| `ASC_HUD_SCOPE_STAT_DETAIL` | `stat_detail` | yes |
| default fallback | `unknown` | yes |

Location: `ASC_HUD_Manager.mqh` current line 169, immediately after `enum ASC_HudRenderScope` and before first use at current line 13984.

## 9. UNDECLARED HUD HELPER SWEEP

| Helper Call | Definition Found? | Declared Before Use? | Patch Needed |
|---|---:|---:|---|
| `ASC_HudExtractLabeledValue` | yes after patch | yes, prototype before use | patched |
| `ASC_HudRenderScopeName` | yes after patch | yes, definition before use | patched |
| `ASC_HudThemeAccentCardA/B/C/D` | yes | yes, one-line color helpers before use | no |
| `ASC_HudThemeBgLayer2` | yes | yes, one-line color helper before use | no |
| broad `ASC_Hud*` call sweep | no unresolved compile blocker found beyond patched helpers | n/a | no additional patch |

## 10. HUD PROOF SUMMARY STRINGFORMAT AUDIT

| Formatter | Risk | Patch Needed | Patch |
|---|---|---:|---|
| `ASC_HudBuildHighFrequencyProofSummary(...)` | already split in RUN105R | no | preserved typed concatenation |
| `ASC_HudBuildLowFrequencyProofSummary(...)` | bounded builder with cache | no | preserved |
| `proof_last_cycle_driver_summary` | many boolean/string arguments in one `StringFormat` | yes | replaced with typed `driver_summary` string assembly |
| `leader_truth_audit.trace_summary` | long `StringFormat` with many `%d/%I64u/%s` placeholders | yes | replaced with typed `audit_trace` string assembly |
| remaining `StringFormat` scan | no line over 220 chars after patch | no | no extra patch |

## 11. IMPLICIT UNKNOWN / NUMBER TO STRING SWEEP

| File / Line | Risk | Patch |
|---|---|---|
| old 2925/2927/2929 | undeclared function made result type unknown before string assignment | added `ASC_HudExtractLabeledValue(...)` returning `string` |
| old 13934 | undeclared function made enum/string conversion unknown | added `ASC_HudRenderScopeName(...)` returning `string` |
| current 7662 trace summary | ulong/int/date mixed in one format block | typed string assembly with `IntegerToString(...)` and `TimeToString(...)` |
| current 14997 cycle driver summary | bool/string mixed in one format block | typed string assembly with `ASC_HudBoolText(...)` |

## 12. FULL HUD WARPATH STATIC DEBUG

| Static Debug Pattern | Finding | Patch |
|---|---|---|
| identifiers under 63 chars | new helper names under limit | no additional patch |
| helper definitions/prototypes | two missing helpers found and repaired | patched |
| duplicate helper names | none introduced | no |
| wrong parameter count | fixed calls now match exact helper signatures | patched |
| oversized `StringFormat` | two extra high-risk telemetry formatters split | patched |
| implicit unknown-to-string | reported cases fixed by typed helpers | patched |
| block-scoped variable leakage | no new leakage introduced | no |
| enum/string mismatch | render scope helper added | patched |
| cache state helper mismatch | not found | no |
| recursive render/cache/service loop | no new loop introduced | no |
| object/chart helper signature mismatch | no patch required | no |
| include-order break | no include changes | no |
| stale renamed helper references | patched missing helper references | patched |
| strategy/execution includes touched | no | protected |

## 13. HUD WARPATH INTENT PRESERVATION

| HUD Warpath Feature | Preserved? | Evidence |
|---|---:|---|
| RUN101 priority/telemetry | yes | `ASC_HudServicePriorityNavigation`, proof counters, and HF summaries preserved |
| RUN102 click/render decoupling | yes | click ack / deferred render path unchanged |
| RUN103 object/redraw optimization | yes | object cache, skip counters, redraw request/flush logic unchanged |
| RUN104 zero-file-read cache/view-model | yes | label extraction parses already-cached text only; no file read added |
| HUD read-only law | yes | helper extracts labels from display text and owns no truth |
| FileIO untouched | yes | no FileIO source rewrite |
| rank/order/formula untouched | yes | no L3/L4/Top10 formula or order patch |

## 14. DEEP SYSTEM DEBUG PREP

| System Debug Area | Current Evidence | Risk | Next Proof |
|---|---|---|---|
| HUD compile blockers | source repaired | MetaEditor still unproven | RUN106R compile transcript first |
| HUD telemetry integrity | render scope and proof summary builders patched | live values unproven | HUD proof logs under navigation load |
| FunctionResults/heartbeat log interaction | not edited | carry-forward proof debt | inspect function_results + heartbeat telemetry in next live package |
| object/redraw counters | preserved | live object queue pressure unknown | record object create/update/delete/redraw counters |
| zero-file-read counters | preserved | must prove no nav file reads live | collect `hud_nav_file_reads`, CF/dossier/board read counters |
| closed-market Top10 issue | not edited | carry-forward market-state proof debt | verify closed-market Top10 labels from live output |
| recursive file audit rule | control preserved | package mismatch can reoccur | recursively list every live output zip before claims |
| currentness/source_run proof | version updated | runtime output unproven | confirm source identity token in artifacts |
| no-spam/performance | proof summaries split | terminal log volume unknown | inspect log sizes/counts next live proof |

## 15. PATCH CANDIDATE MATRIX

| Candidate | Decision | Reason |
|---|---|---|
| `mt5/hud/ASC_HUD_Manager.mqh` | patched | direct compile blockers and proof formatting risks live here |
| `mt5/core/ASC_Version.mqh` | patched | meaningful source change requires version/run identity update |
| active roadmap log | patched | control ledger must reflect repair run |
| output manifest | patched | package identity must reflect changed files |
| FileIO | not touched | no direct compile proof required FileIO change |
| runtime dispatcher | not touched | no direct compile proof required runtime change |
| artifacts / L3 / L4 / L5 / strategy | not touched | protected by prompt |

## 16. PATCH TABLE

| File | Patch | Reason | Drift |
|---|---|---|---|
| `mt5/hud/ASC_HUD_Manager.mqh` | added `ASC_HudRenderScopeName(...)` | fix missing render-scope helper | none |
| `mt5/hud/ASC_HUD_Manager.mqh` | added `ASC_HudExtractLabeledValue(...)` | fix missing Current Focus label extractor | none |
| `mt5/hud/ASC_HUD_Manager.mqh` | split `proof_last_cycle_driver_summary` format block | reduce variadic formatting compile risk | none |
| `mt5/hud/ASC_HUD_Manager.mqh` | split leader trace summary format block | reduce variadic formatting compile risk | none |
| `mt5/core/ASC_Version.mqh` | bumped run/version to RUN105B | source identity update | none |
| active log / manifest | prepended RUN105B entries | control update | none |
| RUN105B report | created | audit/report requirement | none |

## 17. SOURCE FILES TOUCHED

- `mt5/hud/ASC_HUD_Manager.mqh`
- `mt5/core/ASC_Version.mqh`
- `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md`
- `roadmap/Truth Seeker/TRUTH_SEEKER_RUN105B_HUD_COMPILE_REPAIR_REPORT.md`

## 18. PROTECTED AREAS NOT TOUCHED

- `mt5/io/ASC_FileIO.mqh`
- artifact writers
- runtime dispatcher
- L3 Candidate Filtering formula owners
- L4 Shortlist rank/order owners
- L5 Deep Selective Analysis owners
- strategy/semi-auto/execution owners
- BUY/SELL / OrderSend / CTrade / lot sizing / SL/TP
- GlobalTop10 formula/order
- Market Board order
- Current Focus/Dossier/Market Board truth ownership

## 19. STATIC COMPILE-SAFETY TABLE

| Compile Error / Risk | Fixed? | Evidence |
|---|---:|---|
| old line 2925 missing `ASC_HudExtractLabeledValue` | yes | helper prototype current 687; definition current 1708 |
| old line 2927 missing `ASC_HudExtractLabeledValue` | yes | same helper resolves fallback call |
| old line 2929 missing `ASC_HudExtractLabeledValue` | yes | same helper resolves fallback call |
| old line 13934 missing `ASC_HudRenderScopeName` | yes | helper definition current 169; call current 13984 |
| undeclared `ASC_Hud*` helper remains | no direct blocker found | sweep only showed already-defined theme helpers missed by grep classifier |
| giant HUD `StringFormat` risk remains | no line over 220 chars after patch | driver and leader trace split |
| unknown-to-string risk remains | no reported pattern left by source inspection | typed helpers added |
| object/chart helper signature mismatch | not found | no object/chart patch applied |
| file accessor signature mismatch | not found | no FileIO patch applied |
| strategy/execution includes touched | no | protected files untouched |

## 20. REGRESSION GUARD

| Guard | Result |
|---|---:|
| no strategy/execution | yes |
| no BUY/SELL / OrderSend / CTrade | yes |
| no lot sizing | yes |
| no SL/TP | yes |
| no GlobalTop10 rank/order/formula change | yes |
| no L3 score formula change | yes |
| no L4 rank formula/order change | yes |
| no Market Board order change | yes |
| no FileIO rewrite | yes |
| no HUD truth ownership | yes |
| HUD remains read-only consumer | yes |
| no hidden truth compute inside HUD | yes |
| no broad Dossier rewrite | yes |
| no broad L5/L6 all-symbol hydration | yes |
| no Current Focus writer ownership drift | yes |
| no Market Board writer ownership drift | yes |

## 21. TRUE ROADMAP PROGRESS UPDATE

RUN105B repairs the compile gate created by RUN105R. The HUD warpath can now proceed to RUN106R by source inspection, but RUN106R must not claim live proof until actual MetaEditor compile output exists and live HUD telemetry is collected.

## 22. NEXT_PROMPT_SEED

Next run: RUN106R / HUD LIVE PROOF READINESS + METAEDITOR COMPILE + NAVIGATION PERFORMANCE CAPTURE  
First files to read: `mt5/hud/ASC_HUD_Manager.mqh`, `mt5/core/ASC_Version.mqh`, RUN105B report, active roadmap log, output manifest.  
Primary target: compile first, then live HUD navigation proof.  
Evidence needed: MetaEditor compile output, terminal log, function_results/heartbeat logs if emitted, HUD proof summary lines, output package recursive file listing.  
Proof debt to preserve: zero-file-read navigation counters, object/redraw counters, Current Focus cache state, source identity token, closed-market Top10 carry-forward.  
Forbidden drift: FileIO, rank/order/formula, Market Board order, Current Focus/Dossier/Market Board ownership, strategy/execution, BUY/SELL, OrderSend/CTrade, lot sizing, SL/TP.

## 23. FINAL DECISION

PASS — the reported compile blockers are repaired by source inspection, the helper sweep and high-risk formatter sweep are clean enough for the next MetaEditor compile/live proof run, and HUD performance intent from RUN101R–RUN104R is preserved.
