# RUN273R Report — RUN272 Validation Gate + Exact SIAM Fence Correction + Top5 Prune Safety Audit

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN273R / RUN272 VALIDATION GATE + SIAM REQUEST BLOCK EXACT-FENCE CORRECTION + TOP5 PRUNE SAFETY PROOF — RUN272 SOURCE INSPECTED FIRST, SIAM_SAFE FENCES FOUND WRONG FOR PARSER CONTRACT, EXACT SIAM_DOSSIER FENCES PATCHED, TOP5 PRUNE AUDITED STATIC-ONLY, SIAM CLEANLINESS AND L3/L4 HELD
MODE: RESEARCH + AUDIT + DEBUG + PATCH-IF-NECESSARY
TRUTH FURNACE REQUIRED
REPORT: RUN273R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN273R.zip
SOURCE BASELINE: uploaded Aurora Sentinel Core(590).zip, RUN272R package rooted on RUN226R reverted working source
FINAL DECISION: TEST FIRST
```

## Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN273R |
| mode | RESEARCH + AUDIT + DEBUG + PATCH-IF-NECESSARY |
| active source root | Uploaded RUN272R package rooted on RUN226R reverted base |
| RUN227 reuse allowed? | no |
| live test allowed? | no |
| generated output editing allowed? | no |
| source patch allowed? | yes, exact SIAM fence/field correction only in this run |
| Top5 parity broad rewrite allowed? | no |
| prune/delete behavior expansion allowed? | no |
| L3/L4 formula/rank/order/membership change allowed? | no |
| FileIO/final path mutation allowed? | no |
| archive/cache/staging architecture change allowed? | no |
| HUD patch allowed? | no |
| trade/signal/execution/risk permission allowed? | no |
| final decision | TEST FIRST |

## Evidence Ceiling

| Evidence | Rank | What It Proves | What It Does Not Prove |
|---|---:|---|---|
| User prompt / stated blockers | 2 | RUN273 target scope and suspected SIAM fence mismatch. | Does not prove source state. |
| Direct source inspection of uploaded zip | 3 | RUN272 source emitted `SIAM_SAFE_DOSSIER_REQUEST_BLOCK_*`; Top5/SDP prune logic exists as inspected. | Does not prove compile/runtime/live behavior. |
| Static grep/token inspection after patch | 4-lite | Required SIAM tokens now match the requested parser contract in source and body. | Not MetaEditor compile proof. |
| Internet research | constraint input | Converts known platform/reliability/data-contract risks into acceptance tests. | Does not prove Aurora source behavior. |
| MetaEditor compile transcript | unavailable | Not supplied / not run here. | RUN273 cannot claim compile proof. |
| Runtime evidence | not edited | Historical supplied evidence may inform questions only. | No fresh RUN273 runtime proof exists. |

## Mandatory Read Result

Read/inspected before patching:

- Brain Guidebooks: `AURORA_GUIDEBOOK_INDEX.md`, `AURORA_CODING_BRAIN_GUIDEBOOK.md`, `AURORA_TRADING_BRAIN_GUIDEBOOK.md`.
- Control files: active roadmap log, package manifest, roadmap status, work log, change ledger, decisions.
- Reports: `RUN272R_REPORT.md`, `RUN271R_REPORT.md`, `RUN270R_REPORT.md`, `RUN226R_REPORT.md`.
- Source owners: `ASC_Version.mqh`, `ASC_MarketBoardWriter.mqh`, `ASC_SymbolDataPackWriter.mqh`, `ASC_Dispatcher.mqh`, `ASC_FunctionResults.mqh`, `ASC_ScannerStatusWriter.mqh`, `ASC_FileIO.mqh`.
- Dossier, SDP composer/contracts/routing, L3/L4, HUD were treated read-only unless exact compile blocker demanded otherwise. No such compile blocker was patched.

## Research Ledger — Converted, Not Ornamental

| Gate | Source URL | Finding | Aurora Risk | Converted Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|---|
| timer queue | https://www.mql5.com/en/docs/event_handlers/ontimer and https://www.mql5.com/en/docs/event_handlers | MQL5 programs have per-chart event queues; handlers run sequentially; new Timer events are not added when a Timer is already queued/processing. | Heavy folder scans or destructive prune loops can make “timer alive” look true while work is skipped/backlogged. | No cleanup every heartbeat; prune/reconcile only at bounded family-cycle boundary after source-owned queue exists. | Runtime heartbeat must show cadence, due/deferred reason, latency/work/error/saturation and no repeated destructive cleanup loop. | Timer skips, stale board/sdp surfaces, or repeated prune attempts every heartbeat. |
| file delete/publication | https://www.mql5.com/en/docs/files/fileopen, https://www.mql5.com/en/docs/files/filemove, https://www.mql5.com/en/docs/files/filedelete, https://www.mql5.com/en/docs/check/getlasterror, https://www.mql5.com/en/docs/common/resetlasterror | MQL5 file work is sandboxed; `FileDelete`/`FileMove` return false on failure; `_LastError` must be reset/read explicitly. | Archive/delete could silently fail or leave current truth ambiguous if errors are not surfaced. | Archive-before-delete must expose state/reason/counts; deletion failure must degrade truth and stay visible. | FunctionResults/Scanner Status/Manifest show unexpected/archived/deleted/failed counts and delete failure reason. | A current Lite child disappears without archive proof, or a delete failure lacks visible error/reason. |
| retry/monitoring | https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ and https://sre.google/sre-book/monitoring-distributed-systems/ | Retries can amplify overload; SRE golden signals are latency, traffic, errors, saturation. | Repeated prune/reconcile on every heartbeat can create self-inflicted backlog while hiding saturation. | No retry amplification; degraded truth beats hidden cleanup; heartbeat must show work/budget/error/saturation. | Heartbeat telemetry and FunctionResults expose deferred vs failed vs success states and next due. | Cleanup keeps firing while core refresh surfaces stall. |
| data contract/lineage | https://docs.open-metadata.org/latest/how-to-guides/data-contracts/spec, https://openlineage.io/docs/spec/facets/, https://www.w3.org/TR/prov-overview/ | Data contracts make schema/semantics/quality explicit; lineage/provenance describes what ran, inputs, outputs, derivation, versioning. | SIAM block with wrong fences or weak lineage lets downstream parser trust ambiguous board truth. | Use exact stable SIAM fences/fields; Main/Lite parity must carry source/run/version/snapshot/signature/current-truth ownership. | Market Board body and required-token array both contain exact `SIAM_DOSSIER_REQUEST_BLOCK_BEGIN/END` and lineage fields. | Any `SIAM_SAFE_DOSSIER_REQUEST_BLOCK_*` token remains in active source or generated Market Board. |

## Weakest Load-Bearing Premise

RUN272 claimed the SIAM request block was parser-grade. That was false against the requested contract.

Direct source inspection found:

```text
ASC_MarketBoardWriter.mqh emitted: SIAM_SAFE_DOSSIER_REQUEST_BLOCK_BEGIN/END
Required parser-grade contract: SIAM_DOSSIER_REQUEST_BLOCK_BEGIN/END
```

That mismatch is enough to block Siam data-cleanliness work. If Siam or downstream tooling is looking for the exact `SIAM_DOSSIER_REQUEST_BLOCK_*` fences, RUN272 output can be clean-looking but parser-invisible. That is a classic false-river bug: the surface says “safe,” the contract says “not found.”

## Patch Ledger

| File | Change | Boundary |
|---|---|---|
| `mt5/artifacts/ASC_MarketBoardWriter.mqh` | Replaced emitted and required-token fences from `SIAM_SAFE_DOSSIER_REQUEST_BLOCK_BEGIN/END` to `SIAM_DOSSIER_REQUEST_BLOCK_BEGIN/END`; updated `siam_block_version` from `RUN272R_v1` to `RUN273R_v1`. | Exact SIAM parser fence/field correction only; no Market Board ranking/formula/authority rewrite. |
| `mt5/core/ASC_Version.mqh` | Updated compile-visible identity/package law to RUN273R and next source lane to RUN274 only after RUN273 compile/runtime proof. | Version/control identity only. |
| `roadmap/Truth Seeker/Guidebooks/AURORA_CODING_BRAIN_GUIDEBOOK.md` | Corrected acceptance constraint to exact `SIAM_DOSSIER_REQUEST_BLOCK_BEGIN/END`. | Guidebook/control only. |
| `roadmap/Truth Seeker/Guidebooks/AURORA_GUIDEBOOK_INDEX.md` | Added RUN273 amendment: exact SIAM fences are the parser contract; old `SIAM_SAFE` fences are invalid. | Guidebook/control only. |
| control/report files | Added RUN273 status, decisions, manifest, work log, change ledger, and report. | Documentation/control only. |

No changes were made to `ASC_SymbolDataPackWriter.mqh`, `ASC_Dispatcher.mqh`, `ASC_FileIO.mqh`, Dossier owners, L3/L4 owners, HUD, generated runtime evidence, or strategy/trade/risk code.

## Static Acceptance Tests

| Test | Result | Evidence |
|---|---|---|
| Old `SIAM_SAFE_DOSSIER_REQUEST_BLOCK` absent from active `mt5` source | PASS | grep after patch returned no active source hits. |
| Market Board body emits `SIAM_DOSSIER_REQUEST_BLOCK_BEGIN` | PASS | `ASC_MarketBoardWriter.mqh` body line patched. |
| Market Board body emits `SIAM_DOSSIER_REQUEST_BLOCK_END` | PASS | `ASC_MarketBoardWriter.mqh` body line patched. |
| Required-token array validates `SIAM_DOSSIER_REQUEST_BLOCK_BEGIN` | PASS | `required_tokens[27]` patched. |
| Required-token array validates `SIAM_DOSSIER_REQUEST_BLOCK_END` | PASS | `required_tokens[66]` patched. |
| Required-token/body `siam_block_version` parity | PASS | both use `RUN273R_v1`. |
| Version identity says RUN273R | PASS | `ASC_VERSION_LABEL`, `ASC_TRUTH_SEEKER_CURRENT_RUN`, package name updated. |
| MetaEditor compile proof | NOT AVAILABLE | Must be run outside this environment. |
| Runtime Market Board parse/readback proof | NOT AVAILABLE | Fresh generated output was not edited and no live run was performed. |

## Top5 / Lite Prune Safety Audit

### What is source-safe

- `ASC_SymbolDataPackArchiveAndDeleteUnexpectedFinalChild()` archives before deleting and surfaces archive/delete result in `reason_out`.
- Delete calls inside that helper use `ResetLastError()` then `FileDelete()`, and on failure append `error=<GetLastError>` to the reason.
- GlobalTop10 reconcile call passes `prune_empty_expected_set=false`, so empty expected GlobalTop10 does not wipe current children.
- Top5PerBucket reconcile passes `prune_empty_expected_set=true`, but only inside `ASC_SymbolDataPackReconcileTop5PerBucketFinalSets()` after it collects expected symbols from `state.top5_bucket_queue_symbols/slugs/ranks`.
- Top5PerBucket reconciliation emits durable counts: expected, found, unexpected, archived, deleted, skipped, failed, archive path, and `top5_no_broad_file_deletion=true`.
- Service cadence checks `next_due`, heartbeat budget, cursor, and queue guard before child publication/reconcile.

### What remains unproven / risky

- This is not compile-proven. Any MQL type/signature issue must be caught by MetaEditor.
- This is not runtime-proven. Counts could still be wrong under real Common Files path behavior.
- The Dispatcher Top5 active-family prune helper uses `ASC_DeleteFileIfExists()` which returns only bool and does not expose `GetLastError` itself. That helper was not changed because RUN273 scope forbids prune/delete behavior expansion.
- The Top5 active-family prune archives/deletes existing active children only after `ASC_Top5BucketStageFamilyComplete()` and before promote; this is a reasonable boundary, but it still needs runtime heartbeat budget proof.
- If archive write succeeds but delete fails, the source should degrade and show failure counts. This needs runtime proof with a forced delete failure or locked file scenario.

## Contradiction Ledger

| Claim A | Claim B | Source for A | Source for B | Evidence Rank A | Evidence Rank B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---:|---:|---|---|---|
| RUN272 SIAM block is parser-grade. | Source emits `SIAM_SAFE_DOSSIER_REQUEST_BLOCK_BEGIN/END`, not the requested `SIAM_DOSSIER_REQUEST_BLOCK_BEGIN/END`. | RUN272 report/control prose | `ASC_MarketBoardWriter.mqh` direct source inspection | 2/3 | 3 | Source outranks report prose. | Patched emitted body + required-token array to exact `SIAM_DOSSIER_REQUEST_BLOCK_*`. | TEST FIRST until compile/runtime readback proves it. |
| RUN273 should advance to Siam data cleanliness. | RUN273 has unresolved compile/runtime proof blockers from RUN272 and exact fence mismatch. | user desired next lane context | direct source inspection + scope lock | 2 | 3 | Source/scope outrank desire to advance. | Hold Siam cleanliness until RUN273 proof. | yes |
| Top5 prune is safe. | Static source shows bounded archive/delete path, but runtime heartbeat/error pressure is unproven. | RUN272 intent/report | source inspection + no runtime proof | 2/3 | 3/unknown | Source supports direction but not proof. | No prune expansion; require runtime checklist. | TEST FIRST |

## Protected Boundary Check

| Protected Area | Result |
|---|---|
| L3 formulas | PASS — untouched |
| L4 formulas | PASS — untouched |
| L3/L4 membership/rank/order | PASS — untouched |
| Market Board ranking formulas | PASS — untouched |
| HUD | PASS — untouched |
| FileIO/final paths | PASS — untouched |
| archive/cache/staging topology | PASS — untouched |
| Dossier owners | PASS — untouched |
| SDP composer/contracts/routing | PASS — untouched |
| generated runtime evidence | PASS — untouched |
| strategy/signal/trade/execution/risk/prop-firm logic | PASS — untouched |

## Runtime Validation Checklist Before RUN274

Do not start Siam data cleanliness until this proof exists:

1. MetaEditor clean compile transcript for RUN273R source.
2. Experts/Journal confirms active EA version/source run is RUN273R.
3. Fresh Market Board contains exact:
   - `SIAM_DOSSIER_REQUEST_BLOCK_BEGIN`
   - `SIAM_DOSSIER_REQUEST_BLOCK_END`
   - no `SIAM_SAFE_DOSSIER_REQUEST_BLOCK_*`
4. Market Board required-token validation reports success for SIAM block tokens.
5. FunctionResults contains Market Board write/readback success and no missing SIAM token.
6. Top5PerBucket Main/Lite runtime check across all canonical buckets:
   - bucket set matches;
   - symbol set matches;
   - rank/order matches;
   - source snapshot/signature matches;
   - Lite differs by content depth only.
7. Forced or observed empty Main Top5 bucket confirms Lite current child files are archived/deleted with visible counts and archive path.
8. Failure scenario check: if archive/delete fails, FunctionResults/Scanner Status/Manifest must show failed count/reason; no silent deletion.
9. Heartbeat telemetry confirms no repeated destructive cleanup loop, no runaway latency, no saturation, no stale core surfaces.
10. Generated output remains read-only evidence; do not manually clean folders as proof.

## Next Run Seed

```text
TRUTH SEEKER ROADMAP — RUN274R / SIAM DATA CLEANLINESS ONLY AFTER RUN273 COMPILE + RUNTIME PROOF — DO NOT START UNLESS RUN273 EXACT SIAM FENCES COMPILE AND MARKET BOARD READBACK PROVE CLEAN, THEN AUDIT SIAM PARSER FIELD STABILITY, DOSSIER REQUEST SYMBOL SET, TOP5 MAIN↔LITE LINEAGE, AND DATA CLEANLINESS WITHOUT TOUCHING L3/L4 FORMULAS
MODE: RESEARCH + AUDIT + DEBUG + PATCH-IF-NECESSARY
SOURCE BASELINE: RUN273R package only after compile/runtime proof
DECISION DEFAULT: TEST FIRST
```

## Final Decision

TEST FIRST

Strongest next move: compile RUN273R, then perform one bounded runtime capture focused on exact SIAM fence readback and Top5 Main↔Lite prune parity. No Siam cleanliness, no L3/L4, no HUD, no FileIO, no trading permission until that proof exists.
