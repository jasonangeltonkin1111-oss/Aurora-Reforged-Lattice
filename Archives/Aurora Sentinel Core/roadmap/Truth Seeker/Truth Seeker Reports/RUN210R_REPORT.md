# RUN210R_REPORT.md

## GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN210R / LIVE SDP DATA-PURITY + RECONCILIATION PROOF — VERIFY RUN206 STALE-CHILD SAFETY AND RUN207 SIAM SEMANTIC FIELDS IN REAL OUTPUT
MODE: LIVE EVIDENCE REVIEW + DEBUG
DECISION: HOLD
REPORT: RUN210R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN210R.zip

## SECTION 0 — MODE LOCK

| Declaration | Answer |
|---|---|
| current run | RUN210R |
| primary mode | LIVE EVIDENCE REVIEW |
| secondary mode | DEBUG |
| live run? | yes |
| runtime/output artifacts expected? | yes |
| source patch allowed? | only if live evidence exposes a safe patchable blocker |
| production-ready claim allowed? | no |
| edge claim allowed? | no |
| signal/trade permission allowed? | no |
| final serious decision | HOLD |

## SECTION 1 — REQUIRED READ ORDER RESULT

| Required file | Read? |
|---|---|
| roadmap/Truth Seeker/Truth Seeker Reports/RUN209R_REPORT.md | yes |
| roadmap/Truth Seeker/Truth Seeker Reports/RUN208R_REPORT.md | yes |
| roadmap/Truth Seeker/Truth Seeker Reports/RUN207R_REPORT.md | yes |
| roadmap/Truth Seeker/Truth Seeker Reports/RUN206R_REPORT.md | yes |
| roadmap/Truth Seeker/Truth Seeker Reports/RUN205R_REPORT.md | yes |
| roadmap/Truth Seeker/Guidebooks/AURORA_GUIDEBOOK_INDEX.md | yes |
| roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md | yes |
| roadmap/Truth Seeker/Guidebooks/AURORA_TRADING_BRAIN_GUIDEBOOK.md | yes |
| roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md | yes |
| roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md | yes |
| roadmap/Truth Seeker/TRUTH_SEEKER_RUN_TEMPLATE.md | yes |
| office/ROADMAP_STATUS.md | yes |
| office/WORK_LOG.md | yes |
| office/CHANGE_LEDGER.md | yes |
| office/DECISIONS.md | yes |
| mt5/core/ASC_Version.mqh | yes |
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh | yes |
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh | yes |
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh | yes |
| mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackRouting.mqh | yes |
| mt5/runtime/ASC_Dispatcher.mqh | yes |
| mt5/logging/ASC_FunctionResults.mqh | yes |
| mt5/artifacts/ASC_ScannerStatusWriter.mqh | yes |
| mt5/io/ASC_FileIO.mqh | yes |

## SECTION 2 — LIVE EVIDENCE INTAKE TABLE

| Evidence Item | Supplied? | Path / Source | Evidence Rank | Usable For | Limitation |
|---|---|---|---|---|---|
| TRUTH_SEEKER_RUN209R.zip or active source state | yes | Aurora Sentinel Core(513).zip | 3 | source/control baseline | no runtime proof by itself |
| MetaEditor compile output | no | not supplied | 0/unknown | none | no compile proof |
| generated SDP final folders | partial/failing | Symbol Data Packs/GlobalTop10 and Top5PerBucket exist but are empty; flat root has 5 legacy files | 7 | negative final-route proof | server/session bounded; exactness not proven |
| generated SDP staging folders | yes | Symbol Data Packs/_staging/GlobalTop10 and _staging/Top5PerBucket/crypto | 7 | payload/semantic field proof | staging is not current truth |
| generated SDP archive folders | yes | Symbol Data Packs/_archive/... | 7 | previous-file/cap/no_sample proof | archive is not current truth |
| Artifact Bundle Manifest | yes | Artifact Bundle Manifest.txt | 7 | bundle/publication context | no RUN206 reconciliation fields found |
| Scanner Status | yes | Scanner Status.txt | 7 | lifecycle/boundary context | no RUN206 reconciliation fields found |
| FunctionResults | yes | Workbench/logs/function_results.log | 7 | function-level runtime rows | no SDP reconciliation rows found |
| Experts log | no | not supplied | 0 | none | terminal expert behavior unproven |
| Journal log | no | not supplied | 0 | none | terminal/journal behavior unproven |
| broker/server/session context | partial | Upcomers-Server runtime root; crypto outputs observed on 2026-05-02 Saturday | 7 | interpretation | broker conditions/session bounded |

## SECTION 3 — COMPILE CHECK

| Compile Check | Result | Evidence | Meaning |
|---|---|---|---|
| compile succeeded | unknown | MetaEditor output not supplied | no compile proof |
| errors count | unknown | MetaEditor output not supplied | cannot claim clean compile |
| warnings count | unknown | MetaEditor output not supplied | cannot claim warning state |
| touched files referenced | unknown | MetaEditor output not supplied | runtime files imply a build executed, not clean compile |
| undefined helper risk | unclosed | no compile output | must remain TEST/HOLD debt |
| struct field mismatch risk | unclosed | no compile output | must remain TEST/HOLD debt |
| StringFormat/string literal risk | unclosed | no compile output | must remain TEST/HOLD debt |

## SECTION 4 — MULTI-DOMAIN RESEARCH LEDGER

| Research Lane | Source / Authority | Finding | Converted RUN210 Evidence Check | Falsifier |
|---|---|---|---|---|
| MQL5 / MT5 platform behavior | Official MQL5 OnTimer/EventSetTimer docs: https://www.mql5.com/en/docs/event_handlers/ontimer and https://www.mql5.com/en/docs/eventfunctions/eventsettimer | Timer events do not stack when a timer event is queued/processing. | Do not infer missed lifecycle/reconciliation events from one output only; inspect actual final/staging/archive/log evidence. | Logs claim completed reconciliation while final route folders contradict. |
| MQL5 file safety | Official MQL5 FileFindFirst/FileFindNext/FileFindClose docs: https://www.mql5.com/en/docs/files/filefindfirst, /filefindnext, /filefindclose | File enumeration is sandboxed and FileFindNext returns file names; handles must close. | RUN206 cleanup proof must expose route/bucket/found/expected/unexpected/archive/delete fields. | No reconciliation fields or final-route child files appear. |
| MQL5 tick semantics | Official SymbolInfoTick and MqlTick docs: https://www.mql5.com/en/docs/marketinformation/symbolinfotick and https://www.mql5.com/en/docs/constants/structures/mqltick | Current tick can include bid/ask/last fields; broker may not provide useful last for every symbol. | If last=0, output must include last_price_available/status/raw. | last 0 appears without availability/status/raw. |
| CopyTicks behavior | Official CopyTicks docs: https://www.mql5.com/en/docs/series/copyticks | Returned ticks are bounded by request/count and flags describe tick changes. | If return_count=requested_limit, cap/truncation fields must be visible. | return_count equals limit while cap/truncation missing or false. |
| Data-quality semantics | Data hygiene principle used by RUN207 guidebooks | Missingness must not masquerade as zero data. | sample_count=0 requires no_sample for min/max/avg. | sample_count=0 with 0.0000000000 min/max/avg. |
| Secure development / destructive safety | RUN206/Coding Brain destructive-action safety | Cleanup must not delete on empty/uncommitted expected set. | Look for no_committed_membership_no_delete and reconciliation counts. | empty expected set triggers archive/delete or fields absent. |
| SRE / observability | Observability discipline: explicit state/count/source fields | A successful cleanup must be externally observable, not inferred. | Require reconciliation fields in Manifest/Scanner Status/FunctionResults/final folders. | No observer surface shows reconciliation proof. |
| Trading/scanner boundary | Trading Brain guidebook | Data-purity fields are scanner hygiene only, not signal/edge/trade permission. | Search generated outputs/logs for affirmative trade/signal permission. | Any affirmative buy/sell/entry/execution/risk permission appears. |

## SECTION 5 — BRAIN GUIDEBOOK / TWO-BRAIN CHECK

| Guidebook | Read? | Key Rule Extracted | Converted RUN210 Evidence Check | Falsifier |
|---|---|---|---|---|
| AURORA_GUIDEBOOK_INDEX.md | yes | RUN210R evidence checklist must be exact and bounded; research is not proof. | Judge only supplied runtime files/logs for live proof. | Report claims live proof without output. |
| AURORA_CODING_BRAIN_GUIDEBOOK.md | yes | Final-folder reconciliation is destructive-risk code and needs expected/current/found/unexpected/archive/delete proof fields. | Demand reconciliation proof fields and final route exactness. | Fields missing or final route empty/stale. |
| AURORA_TRADING_BRAIN_GUIDEBOOK.md | yes | Data health is not signal/trade/prop-firm permission. | Search output for affirmative trade permission. | Clean fields converted into trade authorization. |

### Brain 1 — Builder answers

- RUN207 fields are proven in generated SDP payloads by `Symbol Data Packs/*.txt`, `_staging/GlobalTop10/*.txt`, `_staging/Top5PerBucket/crypto/*.txt`, and `_archive/**/*.previous.txt`.
- RUN206 reconciliation safety is **not proven**: required reconciliation fields were not found in Manifest, Scanner Status, or FunctionResults, and final SDP route folders are empty.
- First inspection symbols: GlobalTop10 expected `TRXUSD, BTCUSD, DASHUSD, TRPUSD, XMRUSD, EOSUSD, APEUSD, LTCJPY, ZECUSD, IOTAUSD`; Top5PerBucket/Crypto expected `BTCUSD, ETHEUR, ETHUSD, BTCEUR, XMRUSD`.
- Bounded live proof is enough only for emitted fields/no_sample/last_price/CopyTicks semantics in supplied generated files.
- Weekday/non-crypto proof remains unproven; this is Saturday crypto-heavy evidence only.

### Brain 2 — Auditor answers

- Final-set exactness can be faked by flat deprecated files or staging files being mistaken as current final route files.
- Stale children can hide if reconciliation observer fields are absent.
- Archive/delete failure can hide if FunctionResults lacks route-specific cleanup rows.
- `no_sample` can exist in source but fail in output; here it appears correctly in observed generated files.
- `last_price_status` can be absent if composer emission fails; here it appears in all generated SDP files inspected.
- CopyTicks cap fields can mislead if `return_count == requested_limit` but cap is false; here cap was true in all equal-limit cases found.
- Duplicate routes can confuse Siam because the same symbol can exist in GlobalTop10 and Top5PerBucket staging without an explicit canonical-for-Siam field.
- Data-quality text becomes signal permission if `valid/available/ready` is interpreted as buy/sell/entry/execution permission; no affirmative permission found.

## SECTION 6 — RUN207 DATA-PURITY FIELD OUTPUT CHECK

| RUN207 Field | Expected In Output? | Found? | Example File | PASS / HOLD / FAIL | Notes |
|---|---|---|---|---|---|
| tick_window_60s_valid | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| tick_window_60s_invalid_reason | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| tick_window_300s_valid | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| tick_window_300s_invalid_reason | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| spread_window_60s_valid | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| spread_window_60s_invalid_reason | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| spread_window_300s_valid | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| spread_window_300s_invalid_reason | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| spread_min_points_60s | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| spread_max_points_60s | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| spread_avg_points_60s | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| spread_min_points_300s | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| spread_max_points_300s | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| spread_avg_points_300s | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| copy_ticks_requested_limit | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| copy_ticks_return_count | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| copy_ticks_cap_hit | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| copy_ticks_truncation_state | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| last_price_available | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| last_price_status | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| last_price_raw | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| absence_state | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |
| absence_reason | yes | yes | Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | PASS | found in 69 generated SDP files |

## SECTION 7 — NO-SAMPLE ZERO CHECK

Observed `sample_count == 0` cases: 6. Failures: 0.

| File | ticks/window valid | spread_sample_count | spread_min | spread_max | spread_avg | Correct? |
|---|---|---|---|---|---|---|
| Symbol Data Packs/_staging/GlobalTop10/ATOMUSD.nx_SYMBOL_DATA_PACK.txt | false | 0 | no_sample | no_sample | no_sample | PASS |
| Symbol Data Packs/_staging/GlobalTop10/BTCUSD.nx_SYMBOL_DATA_PACK.txt | false | 0 | no_sample | no_sample | no_sample | PASS |
| Symbol Data Packs/_staging/Top5PerBucket/crypto/BTCUSD.nx_SYMBOL_DATA_PACK.txt | false | 0 | no_sample | no_sample | no_sample | PASS |
| Symbol Data Packs/_archive/GlobalTop10/ATOMUSD.nx_SYMBOL_DATA_PACK.previous.txt | false | 0 | no_sample | no_sample | no_sample | PASS |
| Symbol Data Packs/_archive/GlobalTop10/BTCUSD.nx_SYMBOL_DATA_PACK.previous.txt | false | 0 | no_sample | no_sample | no_sample | PASS |
| Symbol Data Packs/_archive/Top5PerBucket/crypto/BTCUSD.nx_SYMBOL_DATA_PACK.previous.txt | false | 0 | no_sample | no_sample | no_sample | PASS |

## SECTION 8 — LAST PRICE AVAILABILITY CHECK

Zero-last rows observed: 69. Failures: 0.

| File | last | last_price_available | last_price_status | last_price_raw | PASS / FAIL |
|---|---|---|---|---|---|
| Symbol Data Packs/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |
| Symbol Data Packs/BCHNUSD.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |
| Symbol Data Packs/DASHUSD.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |
| Symbol Data Packs/ETHUSD.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |
| Symbol Data Packs/TRXUSD.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |
| Symbol Data Packs/_staging/GlobalTop10/AAVEUSD.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |
| Symbol Data Packs/_staging/GlobalTop10/ALGOUSD.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |
| Symbol Data Packs/_staging/GlobalTop10/APEUSD.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |
| Symbol Data Packs/_staging/GlobalTop10/ATOMUSD.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |
| Symbol Data Packs/_staging/GlobalTop10/BCHNUSD.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |
| Symbol Data Packs/_staging/GlobalTop10/BTCJPY.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |
| Symbol Data Packs/_staging/GlobalTop10/BTCUSD.nx_SYMBOL_DATA_PACK.txt | 0.0000000000 | false | broker_not_supplying_last_price_zero_raw_retained | 0.0000000000 | PASS |

## SECTION 9 — COPYTICKS CAP / TRUNCATION CHECK

Equal limit rows observed: 6. Failures: 0.

| File | copy_ticks_requested_limit | copy_ticks_return_count | copy_ticks_cap_hit | copy_ticks_truncation_state | PASS / FAIL |
|---|---|---|---|---|---|
| Symbol Data Packs/_staging/GlobalTop10/BTCUSD.nx_SYMBOL_DATA_PACK.txt | 2000 | 2000 | true | cap_hit_possible_truncated_to_request_limit | PASS |
| Symbol Data Packs/_staging/Top5PerBucket/crypto/BTCEUR.nx_SYMBOL_DATA_PACK.txt | 2000 | 2000 | true | cap_hit_possible_truncated_to_request_limit | PASS |
| Symbol Data Packs/_staging/Top5PerBucket/crypto/BTCUSD.nx_SYMBOL_DATA_PACK.txt | 2000 | 2000 | true | cap_hit_possible_truncated_to_request_limit | PASS |
| Symbol Data Packs/_archive/GlobalTop10/BTCUSD.nx_SYMBOL_DATA_PACK.previous.txt | 2000 | 2000 | true | cap_hit_possible_truncated_to_request_limit | PASS |
| Symbol Data Packs/_archive/Top5PerBucket/crypto/BTCEUR.nx_SYMBOL_DATA_PACK.previous.txt | 2000 | 2000 | true | cap_hit_possible_truncated_to_request_limit | PASS |
| Symbol Data Packs/_archive/Top5PerBucket/crypto/BTCUSD.nx_SYMBOL_DATA_PACK.previous.txt | 2000 | 2000 | true | cap_hit_possible_truncated_to_request_limit | PASS |

## SECTION 10 — RUN206 RECONCILIATION LIVE CHECK

| Reconciliation Proof Field | Found? | Surface | Value / Example | PASS / HOLD / FAIL |
|---|---|---|---|---|
| reconciliation_route | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_bucket | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_state | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_current_truth_source | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_expected_count | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_found_final_count | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_expected_symbols | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_unexpected_symbols | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_archived_count | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_deleted_count | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_skipped_count | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_first_failure_reason | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_final_path | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |
| reconciliation_archive_path | no | Manifest/Scanner Status/FunctionResults | not found | HOLD |

## SECTION 11 — FINAL FOLDER EXACTNESS CHECK

| Route / Bucket | Expected Source | Expected Count | Final Files Found | Extra Files | Missing Files | PASS / HOLD / FAIL |
|---|---|---|---|---|---|---|
| GlobalTop10 | Dossiers/GlobalTop10/_family_manifest visible_top10 | 10 | 0 | none because route folder empty | TRXUSD.nx, BTCUSD.nx, DASHUSD.nx, TRPUSD.nx, XMRUSD.nx, EOSUSD.nx, APEUSD.nx, LTCJPY.nx, ZECUSD.nx, IOTAUSD.nx | FAIL |
| Top5PerBucket/Crypto | Dossiers/Top5PerBucket/crypto/_bucket_manifest symbols | 5 | 0 | none because route folder empty | BTCUSD.nx, ETHEUR.nx, ETHUSD.nx, BTCEUR.nx, XMRUSD.nx | FAIL |
| Top5PerBucket/other buckets | not supplied/current only crypto bucket visible | unknown | 0 | not assessed | not assessed | HOLD |
| Deprecated flat SDP root | not source-owned final route truth | not applicable | 5 | AAVEUSD.nx_SYMBOL_DATA_PACK.txt, BCHNUSD.nx_SYMBOL_DATA_PACK.txt, DASHUSD.nx_SYMBOL_DATA_PACK.txt, ETHUSD.nx_SYMBOL_DATA_PACK.txt, TRXUSD.nx_SYMBOL_DATA_PACK.txt | not applicable | HOLD / exclude from final truth |

### Dossier route observation

| Surface | Expected / Manifest Count | Files Found | Observation | Decision |
|---|---|---|---|---|
| Dossiers/GlobalTop10 | 10 | 10 | matches manifest visible_top10 set | PASS for Dossier only, not SDP final route |
| Dossiers/Top5PerBucket/crypto | 5 target / 2 written / 3 pending according to manifest | 6 | folder contains 6 files while bucket manifest expects five symbols; ETHUSD expected but not present, UNIUSD/TRXUSD extra relative to current manifest | HOLD |
| Symbol Data Packs/GlobalTop10 | 10 expected route files | 0 | route folder exists but is empty | FAIL |
| Symbol Data Packs/Top5PerBucket/crypto | 5 expected route files | 0 | route folder missing/empty | FAIL |

## SECTION 12 — DUPLICATE ROUTE / ASSET IDENTITY OBSERVATION

| Symbol | GlobalTop10 File? | Top5PerBucket File? | route_family visible? | bucket/asset visible? | Conflict Risk |
|---|---|---|---|---|---|
| AAVEUSD.nx | yes in staging | yes in staging | yes | yes | medium Siam-consumer risk; not fatal, not canonical permission |
| ALGOUSD.nx | yes in staging | yes in staging | yes | yes | medium Siam-consumer risk; not fatal, not canonical permission |
| APEUSD.nx | yes in staging | yes in staging | yes | yes | medium Siam-consumer risk; not fatal, not canonical permission |
| ATOMUSD.nx | yes in staging | yes in staging | yes | yes | medium Siam-consumer risk; not fatal, not canonical permission |
| BCHNUSD.nx | yes in staging | yes in staging | yes | yes | medium Siam-consumer risk; not fatal, not canonical permission |
| BTCUSD.nx | yes in staging | yes in staging | yes | yes | medium Siam-consumer risk; not fatal, not canonical permission |
| DASHUSD.nx | yes in staging | yes in staging | yes | yes | medium Siam-consumer risk; not fatal, not canonical permission |
| ETHUSD.nx | yes in staging | yes in staging | yes | yes | medium Siam-consumer risk; not fatal, not canonical permission |
| TRXUSD.nx | yes in staging | yes in staging | yes | yes | medium Siam-consumer risk; not fatal, not canonical permission |
| UNIUSD.nx | yes in staging | yes in staging | yes | yes | medium Siam-consumer risk; not fatal, not canonical permission |
| XMRUSD.nx | yes in staging | yes in staging | yes | yes | medium Siam-consumer risk; not fatal, not canonical permission |

## SECTION 13 — NO SIGNAL / TRADE BOUNDARY CHECK

| Surface | Forbidden Signal/Trade Text Found? | Context | PASS / FAIL |
|---|---|---|---|
| Symbol Data Pack child files | no | negative/boundary tokens only: no affirmative permission found | PASS |
| Market/Scanner artifacts | no | negative/boundary tokens only: trade permission | PASS |
| reports/logs | no | negative/boundary tokens only: no affirmative permission found | PASS |

## SECTION 14 — WEEKEND / SESSION BOUNDARY

| Market Context | Evidence | Meaning | Limitation |
|---|---|---|---|
| crypto open/active | Crypto SDP files and Dossiers observed on Saturday 2026-05-02 | usable bounded crypto/runtime evidence | not weekday proof |
| forex closed/not central in output | No weekday forex final proof supplied | not failure by itself | cannot generalize to forex universe |
| metals/indices/stocks closed/not central in output | No non-crypto current output assessed | not failure by itself | cannot generalize beyond supplied crypto-heavy run |

## SECTION 15 — CONTRADICTION LEDGER

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---|---|---|---|---|
| RUN207 fields exist in source/control | RUN207 fields appear in generated output | RUN207/RUN209 source reports | 69 generated SDP text files | 3 | 7 | runtime output outranks source; claim supported for generated files | Retain PASS for emitted fields | no for data-purity fields |
| RUN206 reconciliation safety should be observable | No reconciliation proof fields found and SDP final route folders are empty | RUN206/RUN209 source reports and guidebooks | Manifest/Scanner Status/FunctionResults/final folders | 3 | 7 | runtime output outranks report momentum | HOLD until route reconciliation emits proof and final folders contain expected files | yes |
| Top5PerBucket/Crypto expected five symbols | Dossier crypto folder contains six files and mismatches expected list | _bucket_manifest symbols field | Dossiers/Top5PerBucket/crypto folder | 7 | 7 | manifest is source-owned expected set; folder contradicts | Reconciliation/final cleanup proof required | yes |
| Flat SDP files exist | Flat root is deprecated transition evidence, not target topology proof | Generated flat root files | Coding Brain guidebook and payload topology_contract | 7 | 3 | runtime files prove existence only; guidebook/source topology defines authority | Exclude flat root from final-route exactness | yes |

## SECTION 16 — PATCH LEDGER

No source patch applied. The blocker is live evidence/proof failure, not a safe small code edit made inside RUN210R. A source patch would need a scoped follow-up after inspecting the active writer/reconciliation call path.

## SECTION 17 — REMAINING UNKNOWNS

- No MetaEditor compile proof supplied.
- No Experts or Journal logs supplied.
- RUN206 empty expected-set no-delete guard is not observable in supplied output.
- RUN206 reconciliation observer fields are missing from Manifest/Scanner Status/FunctionResults.
- SDP final route folders are empty while staging/archive carry payloads.
- Weekday/non-crypto behavior remains unproven.
- Top5PerBucket/Crypto Dossier folder does not match its current expected manifest.

## SECTION 18 — NEXT-RUN SEED

Next run should be a scoped DEBUG/PATCH or live retest depending on what you want next:

1. If patching: inspect only `ASC_SymbolDataPackWriter.mqh`, `ASC_SymbolDataPackComposer.mqh`, `ASC_SymbolDataPackContracts.mqh`, `ASC_SymbolDataPackRouting.mqh`, `ASC_Dispatcher.mqh`, `ASC_FunctionResults.mqh`, and `ASC_ScannerStatusWriter.mqh` to determine why route final folders are empty and why reconciliation proof fields are not emitted.
2. If retesting first: supply MetaEditor compile output, Experts, Journal, Manifest, Scanner Status, FunctionResults, and the entire `Symbol Data Packs/GlobalTop10` + `Symbol Data Packs/Top5PerBucket/crypto` final/staging/archive trees after a fresh run.

## FINAL SUMMARY

- RUN210 proved live that RUN207 data-purity semantic fields are emitted in generated Symbol Data Pack payloads across observed flat, staging, and archive files.
- RUN210 proved live that observed zero-sample spread windows output `no_sample`, not fake numeric zeros.
- RUN210 proved live that last-price unavailable broker fields are labeled with `last_price_available=false`, `last_price_status=broker_not_supplying_last_price_zero_raw_retained`, and `last_price_raw=0.0000000000`.
- RUN210 proved live that CopyTicks cap/truncation labels appear when `copy_ticks_return_count == copy_ticks_requested_limit`.
- RUN210 did **not** prove RUN206 reconciliation safety: required reconciliation proof fields were absent from Manifest, Scanner Status, and FunctionResults.
- RUN210 did **not** prove final SDP route exactness: `Symbol Data Packs/GlobalTop10` and `Symbol Data Packs/Top5PerBucket/crypto` final route folders were empty.
- RUN210 found no affirmative signal/trade/execution/risk/prop-firm permission; boundary wording was negative/restrictive.
- No source patch was applied.
- Remaining unproven: compile cleanliness, Experts/Journal terminal behavior, empty expected-set no-delete guard, route final publication, final membership reconciliation, weekday/non-crypto behavior.

FINAL SERIOUS DECISION: HOLD

Strongest next move: do a scoped DEBUG/PATCH on SDP route final publication + reconciliation observability only; do not touch FileIO, rank/order/formula, Market Board, HUD, or strategy/trade logic.
