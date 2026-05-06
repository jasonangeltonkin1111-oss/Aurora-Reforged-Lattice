# RUN247R REPORT — Archive Contract Repair

## Git Header Summary

```text
TRUTH SEEKER ROADMAP — RUN247R / ARCHIVE CONTRACT REPAIR — SEPARATE PREVIOUS-STATE CACHE FROM REAL TIMESTAMPED ARCHIVE HISTORY WITHOUT TOUCHING CURRENT TRUTH
MODE: DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN247R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN247R.zip
SOURCE BASELINE: RUN246R GLOBALTOP10 FINAL ROUTE PUBLICATION RESTORATION
NEXT RUN: RUN248R HEARTBEAT / DEEP-PAYLOAD / PRESENCE-SWEEP HARDENING
NEXT LIVE TEST: RUN250R
FINAL DECISION: TEST FIRST
```

## 0. Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN247R |
| primary mode | DEBUG |
| secondary mode | PATCH |
| live run? | no |
| runtime/output artifacts expected? | no new runtime output |
| source editing allowed? | yes, archive contract repair only |
| generated output editing allowed? | no |
| generated output cleanup allowed? | no |
| FileIO rewrite allowed? | no |
| final path mutation allowed? | no |
| current route membership change allowed? | no |
| archive-as-current-truth allowed? | no |
| flat-root SDP re-enable allowed? | no |
| public SDP staging re-enable allowed? | no |
| GlobalTop10 route behavior patch allowed? | no, RUN246 preserved; only archive law labels added to manifests |
| Top5PerBucket route behavior patch allowed? | no, preserved; only archive law labels added to manifests |
| L3 behavior/gate change allowed? | no |
| L4 ranking/order/formula change allowed? | no |
| HUD patch allowed? | no |
| Dossier architecture rewrite allowed? | no |
| Siam semantic cleanup allowed? | no |
| strategy/signal/trade/risk patch allowed? | no |
| next source run | RUN248R |
| next live test | RUN250R |
| production-ready claim allowed? | no |
| edge claim allowed? | no |
| signal/trade permission allowed? | no |

Evidence ceiling remains Class 3 for source inspection and patch. Compile proof is not available in this environment. Runtime/live/archive proof is not available in RUN247R.

## 1. Required Read Order / Context Debt

| Item | Status | Notes |
|---|---:|---|
| RUN246R report | read | source baseline and RUN246 deferral confirmed |
| RUN245R report | read | GlobalTop10 route root-cause context |
| RUN244R report | read | compile-path repair context |
| RUN243R report | read | SDP route starvation and proof-token context |
| RUN242R report | read | live failure / publication context |
| RUN241R report | read | heartbeat/persistence starvation hardening context |
| RUN240R report | read | token-contract repair context |
| uploaded archive screenshot / archive evidence | context debt | no separate screenshot file supplied in this zip; evidence folder contained only `Open Symbol Snapshot.txt` |
| uploaded Siam/trader-chat report | context debt | no separate Siam/trader-chat report file supplied in this zip |
| Brain Guidebook index | read | present |
| Coding Brain Guidebook | read | present |
| Trading Brain Guidebook | read | present |
| README / MASTER_INDEX / continuation / front door | read | present |
| ASC_CORE.MD | read | present |
| office files | read | present |
| active roadmap / package manifest | read | present |
| compile root / Dispatcher / version / core contracts | read | present |
| `mt5/artifacts/ASC_DossierContracts.mqh` | context debt | root path absent; dossier contracts exist under `mt5/artifacts/dossier/ASC_DossierContracts.mqh` |
| `mt5/artifacts/ASC_DossierComposer.mqh` | context debt | root path absent; dossier composer exists under `mt5/artifacts/dossier/ASC_DossierComposer.mqh` |
| SDP contracts/routing/composer/writer | read | archive patch owner isolated here |
| ArtifactTextHelpers / FunctionResults / FileIO / L3 / L4 / HUD | read/read-only | no edits made to FileIO, L3, L4, or HUD |

## 2. RUN246 Safety Gate

| RUN246 Feature | Expected | Observed | PASS / HOLD / FAIL | Action |
|---|---:|---|---|---|
| `ASC_TryResolveGlobalTop10ArtifactContext` present | yes | present in `mt5/runtime/ASC_Dispatcher.mqh` | PASS | preserved |
| blank canonical promote args repaired | yes | GlobalTop10 promote path resolves runtime/canonical context before source/final path use | PASS | preserved |
| GlobalTop10 Dossier promote source/final path context repaired | yes | staged/final promote paths use resolved artifact context | PASS | preserved |
| GlobalTop10 SDP dependency telemetry present | yes | `sdp_dossier_dependency_state=requires_promoted_globaltop10_snapshot` present | PASS | preserved |
| `UPLOAD_ROOT_REQUIRED=server_root_or_export_root` emitted in Manifest | yes | emitted and required in Manifest contract | PASS | preserved |
| `run246_globaltop10_repair_marker=active` present | yes | present in promote failure/telemetry paths | PASS | preserved |
| Top5PerBucket route untouched | yes | no Top5 route behavior/ranking change; only archive law labels added to manifests | PASS | preserve |
| FileIO untouched | yes | `mt5/io/ASC_FileIO.mqh` unchanged versus uploaded package | PASS | preserve |
| L3/L4 unchanged | yes | `ASC_SelectionFilter.mqh` and `ASC_ShortlistSelectionEngine.mqh` unchanged versus uploaded package | PASS | preserve |
| compile proof supplied | optional | not supplied / not rerun here | OUTSTANDING | MetaEditor test required |

Hard gate result: RUN246 source was preserved. Archive repair was safe to proceed inside the declared scope.

## 3. Archive Family Classification

| Archive Area | Source Owner | Current Behavior Before RUN247 | Family Classification After RUN247 | Risk |
|---|---|---|---|---|
| SDP `_archive/.../*.previous` | `ASC_SymbolDataPackTryArchivePreviousFinalForRoute` | copied one pre-replacement final payload into `.previous`; no timestamp slot | previous_state_cache | old name could be misread as real archive history |
| SDP GlobalTop10 archive | `ASC_SymbolDataPackWriter.mqh` | previous-state only under `_archive/GlobalTop10` | previous cache moved to `_previous_state_cache/GlobalTop10`; timestamped history added under `archive/GlobalTop10/<snapshot>` | compile/runtime proof outstanding |
| SDP Top5PerBucket archive | `ASC_SymbolDataPackWriter.mqh` | previous-state only under `_archive/Top5PerBucket/<bucket>` | previous cache moved to `_previous_state_cache/Top5PerBucket/<bucket>`; timestamped history added under `archive/Top5PerBucket/<bucket>/<snapshot>` | compile/runtime proof outstanding |
| Dossier GlobalTop10 archive | `ASC_Top10RunFullArchiveLiveFamily` / Dispatcher | timestamp-slot live family archive under `Dossiers/GlobalTop10/archive/<slot>` | timestamped_history; law labels hardened | no rewrite made; runtime proof outstanding |
| Dossier Top5PerBucket archive | `ASC_Top5BucketArchiveAndDeleteActiveChildren` / Dispatcher | copies previous active children into timestamp slot before replacement | timestamped_history; law labels hardened | no rewrite made; runtime proof outstanding |
| Manifest archive proof | Dispatcher + SDP writer | partial labels; old SDP contract said timestamped history unavailable/deferred | present in source labels after RUN247 | proof appears only after compile/runtime publication |
| Archive retention policy | SDP writer / Dispatcher | SDP retention=1 previous only; Dossier timestamp slots | previous cache retention=single previous; timestamp history=no cleanup policy added | storage growth possible; not current truth risk controlled |
| Archive as current truth | inspected owners | no safe basis to let archive drive membership/ranking | forbidden by explicit source tokens | any future archive readback must remain evidence-only |

## 4. Required Conclusions

- Current previous-state cache before RUN247 was SDP `.previous` output.
- Real timestamped archive history already existed in Dossier GlobalTop10 and Dossier Top5PerBucket mechanics, but its labels were not strong enough.
- SDP timestamped history was missing/deferred before RUN247.
- The mixed/ambiguous fault was old SDP `_archive/.../*.previous`: it used archive-looking folders for continuity cache.
- The source owner that writes `.previous` behavior is `ASC_SymbolDataPackTryArchivePreviousFinalForRoute`.
- The source owner that now writes SDP timestamped history is `ASC_SymbolDataPackTryWriteTimestampedHistoryForRoute`.
- Route families needing historical archive support: SDP GlobalTop10 and SDP Top5PerBucket. Dossier GlobalTop10 and Dossier Top5PerBucket needed label hardening only.

## 5. Archive Contract Law Enforced in Source

Previous-state cache now declares:

```text
archive_family=previous_state_cache
archive_role=continuity_fallback_only
archive_retention_policy=single_previous_state_per_symbol_or_route
archive_not_current_truth=true
archive_not_membership_source=true
archive_not_ranking_source=true
archive_not_siam_canonical_selection=true
```

Timestamped archive history now declares:

```text
archive_family=timestamped_history
archive_role=historical_comparison_only_successful_publication_snapshot
archive_snapshot_id=<YYYYMMDD_HHMMSS>
archive_publish_utc=<UTC timestamp>
archive_route_family=<GlobalTop10 or Top5PerBucket>
archive_bucket=<bucket or not_applicable>
archive_source_route=<route source>
archive_symbol=<symbol>
archive_not_current_truth=true
archive_not_membership_source=true
archive_not_ranking_source=true
archive_not_siam_canonical_selection=true
archive_not_current_route_reconciliation_source=true
previous_state_cache_family_separate=true
```

## 6. Source Patch Summary

### SDP contract/composer

- Replaced old SDP archive contract labels that effectively said previous-only / timestamped unavailable.
- Added separate constants for `_previous_state_cache` and `archive`.
- Added archive reader policy that forbids current-truth, membership, ranking, Siam, or route-reconciliation authority.
- Added required tokens to SDP payload validation so future payloads must carry the archive-family split.

### SDP writer

- Kept previous-state cache nonblocking and continuity-only.
- Moved previous-state cache path to `Symbol Data Packs\_previous_state_cache\...`.
- Preserved legacy `archive_*` telemetry as a compatibility alias to previous-state cache, but added clear `previous_state_cache_*` fields.
- Added timestamped history path helpers, envelope writer, manifest writer, and nonblocking post-final-success history write.
- Timestamped history is attempted only after successful final publication/readback and skipped on no-material-change.
- Timestamped history failure does not block current final publication.

### Dispatcher / Dossier manifests

- Added archive law labels to GlobalTop10 family manifests.
- Added archive law labels to Top5PerBucket archive manifests and family manifest.
- Added Artifact Bundle Manifest archive contract law line.
- Did not rewrite Dossier archive mechanics.

## 7. Protected Boundaries Verified

| Boundary | Result |
|---|---|
| generated Symbol Data Packs edited | no |
| generated Dossiers edited | no |
| Market Board runtime output edited | no |
| Scanner Status / Manifest runtime output edited | no |
| FunctionResults runtime logs edited | no |
| FileIO source edited | no |
| final route constants/path doctrine rewritten | no |
| flat-root SDP re-enabled | no |
| public SDP staging re-enabled | no |
| current route membership changed | no |
| L3 behavior/gates changed | no |
| L4 ranking/order/formula changed | no |
| HUD patched | no |
| Dossier architecture rewritten | no |
| Siam semantic cleanup performed | no |
| strategy/signal/trade/risk logic patched | no |

## 8. Static Validation Performed

| Check | Result |
|---|---|
| changed-file scope versus uploaded package | intended source/control/report files only |
| RUN246 markers present after patch | PASS |
| stale SDP archive labels `previous_state_only`, `not_timestamped_archive`, `timestamped_sdp_archive_available=false`, `timestamped_sdp_archive_deferred_to_future_run=true` | none found in SDP source |
| FileIO changed | no |
| L3/L4 changed | no |
| HUD changed | no |
| compile proof | not available here |
| runtime/archive output proof | not available here |

## 9. Evidence Ladder

| Claim | Evidence Class | Status |
|---|---:|---|
| RUN246 markers are present in source | 3 | supported by direct source inspection |
| Old SDP `.previous` behavior was previous-state cache, not archive history | 3 | supported by direct source inspection |
| RUN247 source now separates cache/history families | 3 | supported by direct source patch inspection |
| FileIO, L3, L4, HUD were not modified | 3 | supported by package diff versus uploaded zip |
| Code compiles cleanly | unavailable | not claimed |
| Timestamped SDP archive writes successfully in MT5 | unavailable | not claimed |
| Runtime archive proof exists | unavailable | not claimed |
| Production readiness | unavailable | forbidden / not claimed |
| Trading edge, signal, trade, risk permission | unavailable | forbidden / not claimed |

## 10. Contradiction Ledger

| Claim A | Claim B | Source for A | Source for B | Evidence Rank A | Evidence Rank B | Resolution |
|---|---|---|---|---:|---:|---|
| `_archive/.../*.previous` is archive history | `.previous` is previous-state cache only | operator-visible output naming / screenshot context | active SDP writer behavior and RUN246 deferral | 2 | 3 | Source outranks output naming. RUN247 moved behavior to `_previous_state_cache` and added separate timestamped history. |
| Archive can support comparison history | Archive must never drive current truth | product requirement | archive law / source truth doctrine | 2 | 3 | Both can coexist only if history is evidence-only. RUN247 enforces `archive_not_current_truth=true` and related tokens. |
| Dossier archive needs rewrite | Dossier archive already has timestamp-slot mechanics | initial suspicion | Dispatcher archive helper inspection | 1/2 | 3 | No rewrite. Only labels hardened. |

## 11. Remaining Falsifiers

MetaEditor compile must prove:

- no syntax error from new SDP timestamped history helpers;
- no function signature mismatch around `ASC_WritePublicationPayloadAtomic` calls;
- no type issue around new bool/string contract expressions;
- no required-token array sizing issue.

RUN250 live proof must show, after RUN248R and RUN249R unless overridden:

- current final SDP files still publish to GlobalTop10 and Top5PerBucket routes;
- previous-state cache writes under `_previous_state_cache`, not archive history folders;
- timestamped SDP history creates successful snapshot folders under `Symbol Data Packs/archive/...`;
- timestamped history contains route family, bucket, snapshot id, source route, publish UTC, and no-current-truth law;
- archive failure does not block final current publication;
- no archive path is used as membership, ranking, Siam canonical selection, or route reconciliation truth.

## 12. Changed Files

```text
mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackContracts.mqh
mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackComposer.mqh
mt5/artifacts/symbol_data_pack/ASC_SymbolDataPackWriter.mqh
mt5/runtime/ASC_Dispatcher.mqh
mt5/core/ASC_Version.mqh
office/ROADMAP_STATUS.md
office/WORK_LOG.md
office/CHANGE_LEDGER.md
office/DECISIONS.md
roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md
roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md
roadmap/Truth Seeker/Truth Seeker Reports/RUN247R_REPORT.md
```

## 13. Final Decision

TEST FIRST
