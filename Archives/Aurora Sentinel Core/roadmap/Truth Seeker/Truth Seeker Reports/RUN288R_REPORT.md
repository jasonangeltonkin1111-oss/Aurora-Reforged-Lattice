# RUN288R Report — Scanner Status + Artifact Manifest Stable Required-Token Contract Canonicalization

## 1. GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN288R / SCANNER STATUS + ARTIFACT MANIFEST STABLE REQUIRED-TOKEN CONTRACT CANONICALIZATION — NO LIVE RUN, NO AUDIT-ONLY WASTE, REMOVE OR ALIAS BRITTLE DISPLAY-HEADING REQUIRED TOKENS, CENTRALIZE EMITTED-FIELD PARITY FOR SCANNER STATUS AND ARTIFACT MANIFEST, PRESERVE RUN285/RUN286/RUN287 MARKET BOARD FAST-LANE + SIGNATURE BARRIER + TOKEN-PARITY HELPERS, NO FORMULA/RANK/ORDER/MEMBERSHIP/FILEIO/HUD/TRADE PERMISSION CHANGES
MODE: RESEARCH + AUDIT + DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN288R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN288R.zip
SOURCE BASELINE: RUN287R source package rooted on RUN286R Market Board signature barrier, RUN285 Scanner/Manifest token repair, RUN283 active identity lock, RUN282 exact live-defect repair, and RUN280 compile-clean lineage; RUN287R is source-patched but compile/runtime-unproven
GIT REPO: jasonangeltonkin1111-oss/Aurora-Sentinel-Scanner
EXPECTED DECISION: TEST FIRST

## 2. FINAL SUMMARY

RUN288R completed a bounded source/control/report patch on the uploaded RUN287R package. The weak premise was confirmed: RUN287 added useful parity helpers, but Scanner Status still hard-required many display/prose tokens and Artifact Manifest still hard-required many heading tokens. RUN288R canonicalized those hard validation arrays into compact stable machine-field contracts, preserved validation, preserved cheap body-token parity helpers, and left display headings as readable body text only.

No live run was performed. No generated output was edited, deleted, cleaned, regenerated, or packaged. No timer lowering, heavy folder scan, retry storm, FileIO/final-path mutation, formulas, rank/order/membership, HUD, strategy/signal/execution/risk, or trade permission change was made.

Decision: TEST FIRST. Source/static checks pass in this environment, but MetaEditor compile and runtime/live proof remain pending.

## 3. Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN288R |
| mode | RESEARCH + AUDIT + DEBUG + PATCH |
| active source baseline | RUN287R source package |
| live run allowed? | no |
| fresh runtime evidence required before patch? | no |
| audit-only package allowed? | no |
| source patch required? | yes |
| generated output editing allowed? | no |
| generated output deletion/cleanup allowed? | no |
| Scanner Status stable-token canonicalization allowed? | yes |
| Artifact Manifest stable-token canonicalization allowed? | yes |
| required-token validation deletion allowed? | no |
| display-heading required-token purge/alias allowed? | yes |
| Market Board preservation allowed? | yes |
| timer lowering allowed? | no |
| heavy folder scan allowed? | no |
| L3/L4 formula/rank/order/membership change allowed? | no |
| FileIO/final path mutation allowed? | no |
| HUD patch allowed? | no |
| trade/signal/execution/risk permission allowed? | no |
| final decision | TEST FIRST |

## 4. Evidence Ladder

| Claim | Evidence Class | Status |
|---|---:|---|
| Active uploaded package contains RUN287R identity and RUN287 token helpers | 3 | Direct source inspection |
| Scanner Status old hard required-token array had 408 entries with display/prose debt | 3 | Direct source inspection/static inventory |
| Manifest old hard required-token array had 215 entries with display/prose debt | 3 | Direct source inspection/static inventory |
| RUN288R source patch changed exact owners only | 3 | Direct source diff |
| Braces/parentheses/brackets and token parity static checks pass | 4-lite | Local static validation only, not MetaEditor compile |
| RUN288R compiles clean | unavailable | No MetaEditor transcript supplied |
| RUN288R publishes live Scanner Status / Manifest / Market Board correctly | unavailable | No live run by instruction |

## 5. Research Conversion Ledger

| Gate | Source URL | Finding | Aurora Risk | Converted Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|---|
| timer queue | https://www.mql5.com/en/docs/event_handlers/ontimer and https://www.mql5.com/en/docs/event_handlers | Timer events are queued and skipped if an event is already queued/processing; event handlers must stay bounded. | Lowering timer or adding heavy validation loops can worsen heartbeat and publication pressure. | No timer lowering; no heavy validation loop; canonicalization is cheap body/token parity only. | No EventSetTimer/EventSetMillisecondTimer delta; no broad loop added. | Timer period lowered or new retry/tight loop added. |
| file operations | https://www.mql5.com/en/docs/files/fileopen, /filemove, /filedelete, /check/getlasterror, /common/resetlasterror | File operations and errors require explicit handling; file presence alone is not truth. | Mutating FileIO or treating file existence as proof would fake runtime publication. | Do not mutate FileIO; emit truthful status fields; defer live readback proof. | No FileIO owner changed; no FileOpen/FileMove/FileDelete delta in touched files. | FileIO/final paths changed without direct FileIO failure proof. |
| Windows path length | https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation | Traditional MAX_PATH is 260 characters unless long path support is explicitly enabled. | RUN281-style deep evidence paths can fail extraction on Windows. | Changed-files-only package; short report/control/source paths only; no deep evidence folders. | Package path length checked, max path under Windows-safe ceiling. | Deep evidence folder or long nested excerpt path included. |
| retry / monitoring | https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ and https://sre.google/sre-book/monitoring-distributed-systems/ | Retries can amplify load; monitoring must expose user-impacting truth and symptoms. | Retry amplification or fake-clean proof surfaces hide degraded output. | No retry storm; proof surfaces expose degraded/unknown/partial states truthfully. | No new retry loops; stable fields include truth_state/truth_reason/missing tokens. | Surface claims clean/complete while proof surfaces are missing. |
| data contract / lineage | https://docs.open-metadata.org/latest/how-to-guides/data-contracts/spec, https://openlineage.io/docs/spec/facets/, https://www.w3.org/TR/prov-overview/ | Contracts define expected structure/quality/status; lineage/provenance fields support reliability/trust assessment. | Prose headings as schema create brittle false blockers and poor lineage. | Hard required tokens prefer stable machine fields; include source_run_id/source_version/schema/truth fields. | Scanner/Manifest hard arrays contain only stable fields; headings removed from hard validation. | Heading/display token remains hard-required without alias/reason. |

## 6. Source Owner Map

| Owner | Role | RUN288R Action |
|---|---|---|
| `mt5/core/ASC_Version.mqh` | Compile-visible run identity and seeds | Updated to RUN288R and seeded RUN289R/RUN292R |
| `mt5/artifacts/ASC_ArtifactTextHelpers.mqh` | Shared parity helpers and proof lines | Preserved helpers; expanded stable contract fields |
| `mt5/artifacts/ASC_ScannerStatusWriter.mqh` | Scanner Status body + required-token validation | Canonicalized hard required tokens to stable fields |
| `mt5/runtime/ASC_Dispatcher.mqh` | Artifact Manifest body + required-token validation | Canonicalized hard required tokens to stable fields |
| `mt5/artifacts/ASC_MarketBoardWriter.mqh` | Market Board fast lane/signature barrier | Read/preserved; not changed |
| FileIO, HUD, L3/L4 formula owners, Dossier/SDP writers | Protected owners | Not changed |

## 7. RUN287 Residual Heading-Token Audit

| Surface | Required token count | stable fields | display headings | legacy markers | policy text | ambiguous | Action |
|---|---:|---:|---:|---:|---:|---:|---|
| Scanner Status old RUN287 array | 408 | 148 | 23 | 5 | 214 | 18 | Replaced hard validation array with 24 stable machine-field tokens; display/prose remains body readability only |
| Artifact Manifest old RUN287 array | 215 | 71 | 45 | 2 | 96 | 1 | Replaced hard validation array with 23 stable machine-field tokens; display/prose remains body readability only |

Representative old display/prose tokens included `Aurora Sentinel Core - Scanner Status`, `Summary`, `GlobalTop10 / Market Board Alignment Status:`, `Artifact Bundle Manifest`, `Market Board status:`, `Proof Class Ledger:`, and `Roadmap Two-Lane Audit Boundary:`. Those are readable headings, not stable schema gates.

## 8. Scanner Status Required-Token Inventory

| Type | Count Before | Count After | Action |
|---|---:|---:|---|
| stable machine fields | 148 | 24 | Kept only core stable schema/truth/parity/permission fields in hard validation |
| display headings | 23 | 0 | Removed from hard validation |
| legacy harness markers | 5 | 0 | Removed from hard validation; legacy body text can remain non-blocking |
| static policy text | 214 | 0 | Policy remains in body where emitted, not hard gate |
| malformed/ambiguous | 18 | 0 | Removed from hard validation |

Final Scanner Status hard required tokens:

```text
source_run_id=
source_version=
scanner_status_schema_version=
scanner_status_truth_state=
scanner_status_truth_reason=
scanner_status_publication_permission=true
scanner_status_required_tokens_present=
scanner_status_missing_tokens=
scanner_status_first_missing_token=
runtime_surface_classification=
runtime_surface_classification_reason=
runtime_surface_required_tokens_present=
runtime_surface_missing_tokens=
proof_bundle_capture_checklist_present=
proof_bundle_capture_checklist_status=
proof_bundle_capture_required_surfaces=
proof_bundle_capture_missing_surfaces=
validation_deleted=false
degraded_unknown_publication_allowed=true
clean_requires_required_surfaces=true
trade_permission=false
signal_permission=false
execution_permission=false
risk_permission=false
```

## 9. Scanner Status Stable-Token Canonicalization Audit

- Validation remains active through `ASC_WritePublicationArtifact` and pre-write `ASC_ArtifactRequiredTokenPresenceSummary`.
- `ASC_ScannerStatusRequiredTokenParityLine` now emits `source_run_id=`, `source_version=`, `scanner_status_schema_version=RUN288R_v1`, truth state/reason, missing-token fields, validation_deleted=false, degraded_unknown publication allowance, clean requirement, and false permission fields.
- Display headings remain body text only; they are not hard gates.
- Unknown/degraded publication remains truthful; clean is not granted by this patch.

## 10. Artifact Manifest Required-Token Inventory

| Type | Count Before | Count After | Action |
|---|---:|---:|---|
| stable machine fields | 71 | 23 | Kept core stable schema/truth/proof-bundle/parity/permission fields in hard validation |
| display headings | 45 | 0 | Removed from hard validation |
| legacy harness markers | 2 | 0 | Removed from hard validation; legacy body text can remain non-blocking |
| static policy text | 96 | 0 | Policy remains in body where emitted, not hard gate |
| malformed/ambiguous | 1 | 0 | Removed from hard validation |

Final Artifact Manifest hard required tokens:

```text
source_run_id=
source_version=
artifact_manifest_schema_version=
artifact_manifest_truth_state=
artifact_manifest_truth_reason=
artifact_manifest_publication_permission=true
artifact_manifest_required_tokens_present=
artifact_manifest_missing_tokens=
artifact_manifest_first_missing_token=
proof_bundle_decision_mapping=
proof_bundle_decision_mapping_reason=
proof_bundle_surface_count=
proof_bundle_surface_present_count=
proof_bundle_surface_missing_count=
proof_bundle_missing_surfaces=
proof_bundle_blocking_surfaces=
validation_deleted=false
degraded_partial_unknown_publication_allowed=true
complete_requires_required_surfaces=true
trade_permission=false
signal_permission=false
execution_permission=false
risk_permission=false
```

## 11. Artifact Manifest Stable-Token Canonicalization Audit

- Validation remains active through `ASC_WritePublicationArtifact` and pre-write `ASC_ArtifactRequiredTokenPresenceSummary`.
- `ASC_ArtifactManifestRequiredTokenParityLine` now emits `source_run_id=`, `source_version=`, `artifact_manifest_schema_version=RUN288R_v1`, truth state/reason, missing-token fields, validation_deleted=false, degraded/partial/unknown publication allowance, complete requirement, and false permission fields.
- `ASC_ProofBundleDecisionMappingLine` still emits proof-bundle surface count/present/missing/missing/blocking fields.
- Display headings remain body text only; they are not hard gates.
- Partial/unknown publication remains truthful; complete is not granted by this patch.

## 12. Shared Parity Helper Preservation Audit

| Helper | Status |
|---|---|
| `ASC_ArtifactRequiredTokenMissingList` | preserved |
| `ASC_ArtifactFirstMissingRequiredToken` | preserved |
| `ASC_ArtifactRequiredTokenPresenceSummary` | preserved |
| no FileIO / no folder scan / no validation deletion comment | preserved and tightened |
| Scanner Status usage | preserved |
| Artifact Manifest usage | preserved |

## 13. Market Board Preservation Audit

| Required Preservation Item | Status |
|---|---|
| `MARKET_BOARD_FAST_LANE_BEGIN/END` | preserved |
| `MARKET_BOARD_SYNC_LATENCY_BEGIN/END` | preserved |
| `BOARD_CHILD_SIGNATURE_BARRIER_BEGIN/END` | preserved |
| `TOP5_SYMBOL_TRUTH_GATE_BEGIN/END` | preserved |
| `SIAM_DOSSIER_REQUEST_BLOCK_BEGIN/END` | preserved |
| `SIAM_DATA_CLEANLINESS_BEGIN/END` | preserved |
| Lite enrichment blocks | preserved |
| L3/L4 explanation blocks | preserved |
| permission=false boundaries | preserved |
| Market Board source file | not changed |

## 14. Static Checks Table

| Check | Result |
|---|---|
| active source extracted and inspected | PASS |
| changed files listed | PASS |
| RUN288R version identity present | PASS |
| Scanner Status required-token inventory completed | PASS |
| Scanner Status display-heading required tokens classified | PASS |
| Scanner Status hard required tokens converted to stable fields or aliased | PASS |
| Scanner Status body fields listed | PASS |
| Scanner Status required-token list checked against emitted body | PASS |
| Scanner Status degraded/unknown state can publish | PASS, source-level only |
| Scanner Status validation remains active | PASS |
| Manifest required-token inventory completed | PASS |
| Manifest display-heading required tokens classified | PASS |
| Manifest hard required tokens converted to stable fields or aliased | PASS |
| Manifest body fields listed | PASS |
| Manifest required-token list checked against emitted body | PASS |
| Manifest degraded/partial/unknown state can publish | PASS, source-level only |
| Manifest validation remains active | PASS |
| shared parity helpers preserved | PASS |
| helper does not scan filesystem | PASS |
| helper does not mutate FileIO | PASS |
| Market Board fast-lane blocks preserved | PASS |
| Market Board signature barrier preserved | PASS |
| Top5 symbol truth gate preserved | PASS |
| SIAM_DOSSIER_REQUEST_BLOCK preserved | PASS |
| SIAM_DATA_CLEANLINESS preserved | PASS |
| Lite enrichment blocks preserved | PASS |
| L3_EXPLANATION preserved | PASS |
| L4_EXPLANATION preserved | PASS |
| board_child_sync_status vocabulary preserved | PASS |
| l4_members numeric preserved | PASS |
| entry_score wording preserved / no bare entry= output token | PASS |
| no new CopyTicks calls added | PASS |
| no new CopyRates calls added | PASS |
| no new iATR / CopyBuffer calls added | PASS |
| no timer period lowering | PASS |
| no new broad folder scan added | PASS |
| no retry storm / tight loop added | PASS |
| no L3 formula files changed | PASS |
| no L4 formula files changed | PASS |
| no rank/order/membership formula changed | PASS |
| no Market Board ranking formula changed | PASS |
| no FileIO files changed | PASS |
| no archive/cache/staging architecture changed | PASS |
| no HUD files changed | PASS |
| no generated output packaged/edited | PASS |
| no trade/signal/risk permission introduced | PASS |
| braces/parentheses/brackets balanced | PASS, static text check |
| string quotes balanced | PASS, static text check |
| function call signatures checked | PASS, source-level only |
| required-token arrays/counts checked if touched | PASS |
| Windows-safe package paths checked | PASS |

## 15. Contradiction Ledger

| Claim A | Claim B | Source A | Source B | Evidence Rank A | Evidence Rank B | Which source outranks? | Resolution | Pause required? |
|---|---|---|---|---:|---:|---|---|---|
| RUN287 added parity helpers | Many heading-style required tokens still remain | `ASC_ArtifactTextHelpers.mqh` | `ASC_ScannerStatusWriter.mqh`, `ASC_Dispatcher.mqh` | 3 | 3 | Both true; active source resolves | RUN288R preserves helpers and replaces hard arrays with stable fields | No; TEST FIRST remains |
| Display headings improve readability | Display headings are brittle schema | Body text | Required-token arrays | 3 | 3 | Stable contract law outranks display preference | Headings remain body-only, not hard gates | No |
| Scanner Status validation must stay active | Validation has caused publication failure | RUN288R prompt/control law | RUN284/RUN287 evidence context | 3 | 7/8 bounded for old runtime | Both true in scope | Validation hardened, not deleted | No; compile/runtime pending |
| Manifest validation must stay active | Required-token drift caused Manifest failure | RUN288R prompt/control law | RUN284/RUN287 evidence context | 3 | 7/8 bounded for old runtime | Both true in scope | Validation hardened, not deleted | No; compile/runtime pending |
| Proof surface should publish degraded/unknown | Proof surface must not fake clean | Helper parity lines | Truth Furnace/control law | 3 | 3 | Both true | Truth fields permit degraded/unknown and keep clean/complete requirements explicit | No |
| Source patch batch rhythm | No live proof after every run | User workflow + prompt | Prior live-proof pressure | 2/3 | 2/3 | Current prompt controls this run | No live run; RUN292R remains batch target | No |
| Market Board fast lane must be preserved | Scanner/Manifest canonicalization must not block Market Board | Market Board source | Scanner/Manifest source | 3 | 3 | Source boundaries | Market Board file untouched; blocks preserved | No |
| Static source patch | Compile/runtime unproven after RUN288 | Local static checks | No MetaEditor/live evidence | 4-lite | unavailable | Evidence ceiling controls claim | Decision TEST FIRST, not PROCEED | Yes for production/live claims |
| Data-review permission | Any trade/signal/risk permission | Scanner/Manifest body fields | Prop/risk boundary law | 3 | 3 | Permission boundary law | False permission fields preserved/added | No |

## 16. Changed Files List

```text
Aurora Sentinel Core/mt5/core/ASC_Version.mqh
Aurora Sentinel Core/mt5/artifacts/ASC_ArtifactTextHelpers.mqh
Aurora Sentinel Core/mt5/artifacts/ASC_ScannerStatusWriter.mqh
Aurora Sentinel Core/mt5/runtime/ASC_Dispatcher.mqh
Aurora Sentinel Core/roadmap/Truth Seeker/Guidebooks/AURORA_GUIDEBOOK_INDEX.md
Aurora Sentinel Core/roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md
Aurora Sentinel Core/roadmap/Truth Seeker/Guidebooks/AURORA_TRADING_BRAIN_GUIDEBOOK.md
Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md
Aurora Sentinel Core/roadmap/Truth Seeker/TRUTH_SEEKER_OUTPUT_PACKAGE_MANIFEST.md
Aurora Sentinel Core/office/ROADMAP_STATUS.md
Aurora Sentinel Core/office/WORK_LOG.md
Aurora Sentinel Core/office/CHANGE_LEDGER.md
Aurora Sentinel Core/office/DECISIONS.md
Aurora Sentinel Core/roadmap/Truth Seeker/Truth Seeker Reports/RUN288R_REPORT.md
```

## 17. Acceptance Tests

| Acceptance | Result |
|---|---|
| RUN288R version identity present | PASS |
| Scanner Status hard validation prefers stable machine fields | PASS |
| Scanner Status headings removed from hard validation | PASS |
| Scanner Status emitted body and required-token list parity checked | PASS, source/static |
| Scanner Status validation remains active | PASS |
| Manifest hard validation prefers stable machine fields | PASS |
| Manifest headings removed from hard validation | PASS |
| Manifest emitted body and required-token list parity checked | PASS, source/static |
| Manifest validation remains active | PASS |
| Shared parity helpers preserved | PASS |
| Helpers are cheap string/body validation only | PASS |
| Market Board fast-lane/signature barrier/Top5 truth gate preserved | PASS |
| SIAM/Lite/L3/L4 blocks preserved | PASS |
| No forbidden owner changed | PASS |
| Static checks pass | PASS |
| Package paths are Windows-safe | PASS |

## 18. Falsifiers

- MetaEditor compile reports errors in touched files.
- Runtime Scanner Status still fails required-token validation after RUN288R.
- Runtime Manifest still fails required-token validation after RUN288R.
- Scanner Status or Manifest emits clean/complete while required proof surfaces are missing/unknown.
- Any heading/display token remains a hard required-token gate without stable alias.
- Helper scans filesystem, writes files, mutates FileIO, disables validation, or creates runtime authority.
- Market Board fast-lane/signature barrier/Top5 truth gate disappears in next evidence.
- Any trade/signal/execution/risk permission appears.

## 19. RUN289R Seed

RUN289R / L3+L4 BOUNDARY HYDRATION OR DEBUG QUARANTINE SOURCE PATCH — continue source-edit batch without live run. Inspect where committed L3/L4 state exists and why Market Board/SDP bodies still show unknown placeholders. Either hydrate committed L3/L4 metadata through a source-owned boundary into Market Board/SDP bodies, or quarantine L3/L4 explanation blocks as debug-only until real state can cross. No formulas, no rank/order/membership, no FileIO, no HUD, no generated output, no trade/signal/risk permission.

## 20. Batched Live Proof Seed

RUN292R / BATCHED LIVE PROOF AFTER RUN285R-RUN291R SOURCE PATCH SEQUENCE remains the target. Move live proof earlier only if compile fails, Market Board disappears in supplied evidence, Scanner Status/Manifest owner cannot be stabilized, source identity split-brain recurs, FileIO corruption is proven, or a permission leak is proven.

## 21. Package Validation

| Package Law | Result |
|---|---|
| Package name exactly `TRUTH_SEEKER_RUN288R.zip` | PASS |
| Changed files only | PASS |
| Preserve `Aurora Sentinel Core/...` layout | PASS |
| Include changed source files | PASS |
| Include updated control files | PASS |
| Include RUN288R report | PASS |
| No whole repo dump | PASS |
| No generated runtime evidence | PASS |
| No live output | PASS |
| No deep evidence folders | PASS |
| No forbidden suffix | PASS |
| Windows-safe paths | PASS |

## 22. Final Decision

TEST FIRST.

The source patch is bounded and static checks pass, but compile/runtime/live proof remains pending. Do not claim production readiness, live safety, L3/L4 edge, or trade/signal/execution/risk permission from RUN288R.
