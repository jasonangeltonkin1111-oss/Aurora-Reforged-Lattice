# RUN271R Report — Board↔Dossier↔SDP Sync Safety Gate

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN271R / BOARD↔DOSSIER↔SDP SYNC SAFETY GATE — ROOTED ON RUN226R REVERTED SOURCE, HIGH RUN NUMBER PRESERVED, MARKET BOARD AUTHORITY DOWNGRADED WHEN CHILD ROUTES DO NOT MATCH CURRENT BOARD SNAPSHOT, SIAM-SAFE DOSSIER REQUEST BLOCK ADDED, L3/L4 FORMULAS UNTOUCHED
MODE: RESEARCH + AUDIT + DEBUG + PATCH
TRUTH FURNACE REQUIRED
REPORT: RUN271R_REPORT.md
PACKAGE: TRUTH_SEEKER_RUN271R.zip
SOURCE BASELINE: uploaded RUN226R reverted working source
FINAL DECISION: TEST FIRST
```

## Section 0 — Mode Lock

| Declaration | Answer |
|---|---|
| current run | RUN271R |
| mode | RESEARCH + AUDIT + DEBUG + PATCH |
| active source root | RUN226R reverted working source |
| new rebuild lane | RUN271R+ |
| RUN227 reuse allowed? | no |
| live test allowed? | no, supplied runtime evidence inspected only |
| generated output editing allowed? | no |
| source patch allowed? | yes, tiny bounded board-sync safety only |
| L3 formula change allowed? | no |
| L4 formula change allowed? | no |
| L3/L4 membership/rank/order change allowed? | no |
| Top5 Main/Lite parity repair allowed? | no, audit only and seed RUN272R |
| FileIO/final path mutation allowed? | no |
| archive/cache/staging mutation allowed? | no |
| HUD hidden truth allowed? | no |
| trade/signal/execution/risk permission allowed? | no |
| final decision | TEST FIRST |

## Evidence Ceiling

| Evidence | Rank | What it can prove here |
|---|---:|---|
| User prompt and prior run narrative | 2 | Scope, intended failure pattern, and required boundaries. |
| Uploaded source inspection | 3 | Current active files and exact patched source contents. |
| Static text/brace/signature checks in this environment | 4-lite | Structural risk reduction only; not MetaEditor compile proof. |
| Supplied runtime evidence folders/logs | 7/8 only for their observed session window | Runtime contradiction/context only, not new source truth and not RUN271 proof. |
| Internet research | 1→constraints | External constraints, acceptance tests, and falsifiers only. |

No MetaEditor compile transcript and no fresh RUN271 runtime output were supplied. Therefore RUN271R cannot be called proven, live-safe, production-ready, or prop-firm safe.

## Mandatory Reads / Source Owner Findings

Read scope completed against the uploaded package:

- Brain Guidebooks: index, coding brain, trading brain.
- Control files: active roadmap log, package manifest, roadmap status, work log, change ledger, decisions.
- Reports: RUN270R and RUN226R were present and read. RUN227R report was not present in the uploaded package, so RUN227 remains historical/user-reported evidence only in this pass.
- Runtime evidence: `evidence/Upcomers-Server` and stale `evidence/RUN263R` were inspected without editing.
- Source owners: Version, EA shell, Dispatcher, Market Board writer, Scanner Status writer, FunctionResults, Dossier writer/composer, SDP writer/composer/routing, FileIO.

Important source-owner correction: the requested path `mt5/artifacts/ASC_DossierComposer.mqh` does not exist in this uploaded source. The real composer path present in source is `mt5/artifacts/dossier/ASC_DossierComposer.mqh`. This was treated as a read-only owner and not patched.

## Mandatory Research Conversion Ledger

| Gate | Source URL | Finding | Aurora Risk | Converted Constraint | Acceptance Test | Falsifier |
|---|---|---|---|---|---|---|
| timer queue | https://www.mql5.com/en/docs/event_handlers/ontimer and https://www.mql5.com/en/docs/event_handlers | MQL5 timer events are single-queue/serialized; a new Timer event is not added when one is already queued or processing, and queue overflow can discard events. | A board-child proof loop that scans child folders every beat can starve refresh and fake heartbeat health. | RUN271R sync gate must be cheap, string/signature based, and must not add child-folder scans or retry loops. | Static source inspection shows the new gate derives from existing Market Board/Top5 committed signatures only. | Any new folder walk, deep child readback loop, or retry loop in Market Board writer kills the run. |
| file publication | https://www.mql5.com/en/docs/files/fileopen, https://www.mql5.com/en/docs/files/filemove, https://www.mql5.com/en/docs/check/getlasterror, https://www.mql5.com/en/docs/common/resetlasterror | File open/move failures are explicit outcomes and error state must be reset/read intentionally; file existence alone is not lineage proof. | Market Board can look current while Dossier/SDP routes are stale, absent, retained, or from another snapshot. | Board authority must downgrade unless final committed child-route signature matches current board snapshot proof. No FileIO rewrite without direct FileIO failure. | Runtime Market Board must emit board_authority, board_child_sync_status, blocking, request_count, request/blocker reason, and permissions. | If child signatures are absent/mismatched but board_authority remains clean or request_count > 0, RUN271R fails. |
| retry/backoff | https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/ and https://sre.google/sre-book/monitoring-distributed-systems/ | Retries can amplify overload; useful monitoring exposes latency, traffic/work, errors, and saturation. | Rechecking all children every heartbeat can worsen heartbeat over-budget behavior and hide saturation. | RUN271R must not add retry amplification. It may expose sync status/blocker in Board and FunctionResults only. | Static diff shows no new timer scheduling, folder scanning, FileIO mutation, or retries. | Any repeated child scan or retry-on-every-beat behavior causes HOLD before RUN272R. |
| lineage/contracts | https://docs.open-metadata.org/latest/how-to-guides/data-contracts/spec, https://openlineage.io/docs/spec/facets/, https://www.w3.org/TR/prov-overview/ | Data contracts and lineage require explicit ownership/facets/provenance; contract status can be active/violated and provenance tracks derivation. | Operator hype can turn visible Board rows into command truth even when child-route lineage disagrees. | Board authority is a contract state: clean/limited/degraded. It is not a visual claim. Dossier request is review-only and permissions remain false. | Market Board output contains Siam-Safe Dossier Request Block and Cross-Artifact Alignment Boundary reports violated/blocked when sync is not matched. | If Market Board tells Siam to request trade-decision dossiers while lineage is unknown/mismatched/pending, RUN271R fails. |

## Failure Verified / Weak Premise Attacked

Weak load-bearing premise: **a fresh-looking Market Board can safely act command-ready even when child routes are not proven to match the current board snapshot.**

That premise is rejected. Board visibility is not lineage proof. RUN271R makes visible Board authority conditional on existing source-owned Top5 committed signature alignment. This does not fix Top5 Main/Lite parity. It only prevents the Board from overclaiming while parity remains unproven or mismatched.

## Patch Summary

### `mt5/artifacts/ASC_MarketBoardWriter.mqh`

Added a bounded safety gate that derives from existing board/Top5 signature state:

- `ASC_BoardChildSyncStatus(...)`
- `ASC_BoardChildSyncBlocking(...)`
- `ASC_BoardChildSyncBlockerReason(...)`
- `ASC_BoardAuthorityState(...)`
- `ASC_BoardRecommendedDossierRequestCount(...)`
- `ASC_BoardRecommendedDossierSymbols(...)`
- `ASC_BoardDossierRequestReason(...)`
- `ASC_BoardAppendSiamSafeDossierRequestBlock(...)`

Output semantics added to Market Board and FunctionResults:

```text
board_authority=clean/limited/degraded
board_child_sync_status=matched/mismatched/pending/unknown
board_child_sync_blocking=true/false
recommended_dossier_request_count=0/3/5/10
recommended_dossier_symbols=
request_reason=
request_blocker_reason=
top1_trade_bias_blocked=true
trade_permission=false
signal_permission=false
execution_permission=false
risk_permission=false
prop_firm_permission=false
```

Behavior changed:

- If child sync is not `matched`, Board authority becomes `degraded`.
- If child sync is not `matched`, recommended dossier request count is `0`.
- If child sync is blocked, command language is downgraded from best-pick command posture to blocked/watch context.
- Cross-Artifact Alignment Boundary now reports `alignment_status=violated`, `claim_status=blocked`, and `behavior_change=board_child_sync_safety_gate` when sync is not matched.
- Required-token validation was extended so the Siam-safe block cannot silently disappear.

### `mt5/core/ASC_Version.mqh`

Updated compile-visible identity/control labels to RUN271R and explicitly set the next lane to RUN272R Top5 Main/Lite parity repair. RUN227 is not reused as an active rebuild identity.

## Boundaries Preserved

Not touched:

- L3 formula logic.
- L4 formula logic.
- L3/L4 membership, rank, or order logic.
- Top5 Main/Lite parity repair.
- FileIO/final path doctrine.
- archive/cache/staging topology.
- HUD hidden truth.
- Dossier/SDP composer architecture.
- strategy/signal/trade/execution/risk/prop-firm logic.
- generated runtime outputs/evidence.

## Static Checks Performed

- Changed source files before docs: `ASC_MarketBoardWriter.mqh`, `ASC_Version.mqh` only.
- Market Board writer brace balance passed after patch.
- Market Board writer parentheses balance passed after stripping strings/comments.
- Required new tokens were found in source.
- No MetaEditor compile available in this environment.

Static checks reduce syntax-risk only. They do not prove compile success, runtime correctness, artifact publication, or live safety.

## Acceptance Tests for RUN271R

1. MetaEditor compile must complete with zero errors.
2. Run a bounded non-live/development refresh proof.
3. Force or observe a case where child sync is absent, pending, unknown, or mismatched.
4. Market Board must emit:
   - `board_authority=degraded`
   - `board_child_sync_blocking=true`
   - `recommended_dossier_request_count=0`
   - `top1_trade_bias_blocked=true`
   - all permission fields false.
5. Command block must say Best Pick is blocked until board-child sync is matched.
6. FunctionResults finish row must include the same board-child sync fields.
7. No L3/L4 rank/order/membership diffs allowed.
8. No generated outputs edited by hand.

## Falsifiers

RUN271R fails if any of these occurs:

- Board child sync is `mismatched`, `pending`, or `unknown`, but Board emits `board_authority=clean`.
- Board child sync is not matched, but `recommended_dossier_request_count` is greater than zero.
- Market Board asks Siam for trade-decision dossiers while child sync proof is absent/mismatched.
- Market Board emits best-pick command language while child sync is blocked.
- Any L3/L4 formula, rank/order/membership, FileIO, HUD, Dossier/SDP architecture, strategy, signal, execution, or risk file changes are discovered.
- MetaEditor compile fails.

## RUN272R Seed Only — Not Patched Here

Top5 Main↔Lite parity remains the next real repair lane. RUN272R must inspect the committed Top5 family owner and repair Main/Lite child parity without changing L3/L4 formulas or making Lite an independent truth owner.

## Decision

TEST FIRST
