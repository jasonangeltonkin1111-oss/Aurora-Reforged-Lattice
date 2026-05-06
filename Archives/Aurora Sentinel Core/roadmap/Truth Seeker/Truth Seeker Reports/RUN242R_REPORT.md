# RUN242R_REPORT.md

```text
GIT HEADER SUMMARY

TRUTH SEEKER ROADMAP — RUN242R / LIVE CRASH-FREEZE RETEST AFTER RUN240–RUN241 REPAIR — REGRESSION ROOT CAUSE AUDIT
MODE: LIVE EVIDENCE REVIEW + DEBUG
SOURCE BASELINE: RUN241R
EVIDENCE: Aurora Sentinel Core(553).zip + Upcomers-Server(140).zip
FINAL DECISION: HOLD
```

```text
FINAL SUMMARY

RUN242R live evidence does not pass. The Symbol Data Packs folder was not created within the supplied 14:10–14:13 evidence window because the active runtime did not publish any Symbol Data Pack files.

The strongest proven blocker is not a mystery freeze: Scanner Status publication is failing repeatedly because the required-token list expects `Runtime Proof Bundle Capture Checklist`, but the emitted helper writes `Runtime Capture Checklist:`. FunctionResults records this failure 97 times.

A second proven token-contract blocker exists in the Artifact Bundle Manifest: required token `proof_bundle_decision_mapping=` is expected, but the helper emits `proof_bundle_decision=...` instead. FunctionResults records this manifest failure 5 times.

The Symbol Data Pack route family is also delayed by runtime gating. In ASC_RunWriteLane, route-family SDP mirrors only run when `top10_batch_active` is false. During the supplied evidence the Top10 batch is still running and only reaches cursor 5/10 by 14:12:50, so the GlobalTop10/Top5PerBucket SDP services are not allowed to fire yet. That explains why the root `Symbol Data Packs` folder is absent while Dossiers and Market Board artifacts exist.

Heartbeat is improved from the RUN238 24s+ class, but it is not clean: max heartbeat is 7144ms, rows over budget are 18/23, rows over 2000ms are 3, rows over 5000ms are 3. Side duty still spikes to 7368ms, so starvation is reduced but not solved.

No compile output, Experts log, or Journal log was supplied inside the uploaded evidence, so compile proof and hard-crash classification remain missing. No source patch was applied in this audit.

Exact next move: patch only the token-name mismatches and the SDP route-family starvation gate, then run a bounded retest. Do not touch FileIO, final route paths, L3 gates, L4 ranking/order/formulas, HUD, strategy, or generated evidence.
```

## Evidence intake

| Evidence Item | Supplied? | Evidence Rank | Usable For | Limitation |
|---|---:|---:|---|---|
| RUN241R source package | yes | 3 | source owner inspection | no compile/runtime proof by itself |
| Runtime server export | yes | 7/8 | live output/log evidence | bounded to 2026-05-03 14:10–14:13 |
| MetaEditor compile output | no | — | compile proof | missing |
| Experts log | no | — | hard EA crash proof | missing |
| Journal log | no | — | MT5/platform crash proof | missing |
| heartbeat_telemetry.log | yes | 7/8 | starvation/queue evidence | no terminal crash proof |
| FunctionResults | yes | 7/8 | publication failures | bounded runtime window |
| Scanner Status file | no | — | status publication proof | absent because writer fails |
| Artifact Bundle Manifest | no | — | bundle proof | absent because writer fails |
| Market Board | yes | 7/8 | board publication proof | not enough to prove route family outputs |
| Symbol Data Packs route folder | no | 7/8 | route proof | absent |
| Dossier routes | partial | 7/8 | Dossier output proof | GlobalTop10 only staging children in supplied window |

## Root cause findings

### 1. Scanner Status is blocked by exact token mismatch

Runtime failure observed:

- `Failed to write scanner status artifact: required token contract failed missing_token=Runtime Proof Bundle Capture Checklist`
- Count: 97

Source conflict:

- Required in `mt5/artifacts/ASC_ScannerStatusWriter.mqh`: `Runtime Proof Bundle Capture Checklist`
- Emitted in `mt5/artifacts/ASC_ArtifactTextHelpers.mqh`: `Runtime Capture Checklist:`

This is a direct token contract mismatch. It is patchable and should be repaired surgically.

### 2. Manifest is blocked by exact token mismatch

Runtime failure observed:

- `Failed to publish Artifact Bundle Manifest: required token contract failed missing_token=proof_bundle_decision_mapping=`
- Count: 5

Source conflict:

- Required in `mt5/runtime/ASC_Dispatcher.mqh`: `proof_bundle_decision_mapping=`
- Emitted in `ASC_ProofBundleDecisionMappingLine()`: `proof_bundle_decision=...`

This is also a direct token contract mismatch. It is not FileIO corruption.

### 3. Symbol Data Packs did not create because route-family service is starved/deferred

Observed server export contains **zero** files under `Symbol Data Packs/`.

Observed route outputs instead:

- Dossiers/Top5PerBucket/crypto has 5 final children.
- Dossiers/GlobalTop10 has only `_staging` children for 5 symbols.
- Market Board exists.
- Open Symbol Snapshot exists.

Runtime trace:

- Last supplied heartbeat: `2026.05.03 14:12:50`
- Top10 batch status: `top10_batch_status=running | cursor=5/10 | inflight=none | retry=0 | alignment=refresh_in_progress | reason=completed symbol XMRUSD.nx (5/10) | current_board_signature=market_board_diversified_top10|board_epoch=2026.05.03 14:10:54|visible_top10=01:AAVEUSD.nx;02:APEUSD.nx;03:ALGOUSD.nx;04:DASHUSD.nx;05:XMRUSD.nx;06:EOSUSD.nx;07:MELUSD.nx;08:ATOMUSD.nx;09:BCHNUSD.nx;10:LTCEUR.nx;|build=RUN241R-HeartbeatPersistenceStarvationHardening|run=RUN241R | derived_from_board_signature=unavailable`
- GlobalTop10 child work count: `5`
- Queue remaining: `5`

Source gate:

```mql5
ASC_ServiceSymbolDataPackLiteRuntimeActivation(state, now_utc, beat_start_us, beat_budget_ms, yield_reason);
if(!top10_batch_active)
  {
   ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication(...);
   ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication(...);
  }
```

This means while Top10 batch is active, GlobalTop10 and Top5PerBucket SDP route mirrors are skipped. In the supplied live window, Top10 was still running at 5/10. So the Symbol Data Packs folder not appearing after 3 minutes is explained by source gating plus slow/incomplete Top10 family work.

### 4. Heartbeat hardening helped, but starvation remains

| Metric | RUN238 Baseline | RUN242 Observed | Verdict |
|---|---:|---:|---|
| max heartbeat ms | ~24654 | 7144 | improved, not clean |
| rows above budget | 73/77 | 18/23 | still high |
| rows above 1200ms | 47 | 11 | improved |
| rows above 2000ms | 5 | 3 | improved but not zero |
| rows above 5000ms | 4 | 3 | still failing target |
| side_duty_ms max | ~24809 | 7368 | improved but still dominates |
| top10_ms max | ~24654 | 410 | controlled |
| deferred_work_count max | ~1036 | 1036 | improves by end, starts high |

## Contradiction ledger

| Claim A | Claim B | Source A | Source B | Which Outranks? | Resolution | Pause Required? |
|---|---|---|---|---|---|---|
| RUN240/RUN241 repaired publication failures | Scanner Status still fails 97 times | Prior run premise | FunctionResults live log | live log outranks premise | patch exact emitted/required token mismatch | yes |
| Manifest proof is repaired | Manifest fails on `proof_bundle_decision_mapping=` | Source/run premise | FunctionResults live log + source helper | live log/source inspection outrank premise | align helper/required token | yes |
| Symbol Data Packs should create right away | No `Symbol Data Packs` folder exists | User expected behavior | server export + dispatcher gate | current export/source outrank expectation | service route mirrors despite active Top10, or prove due policy clearly | yes |
| Heartbeat starvation fixed | 7.1s heartbeat still appears | RUN241 purpose | heartbeat telemetry | telemetry outranks purpose | cap deep/side-duty spikes further | yes |

## Decision

HOLD.

This is not safe to call proceed. The system is alive enough to write Market Board, Open Symbol Snapshot, FunctionResults, heartbeat telemetry, and some Dossiers, but the core proof surfaces are failing token validation and the expected Symbol Data Packs route is not publishing in the supplied window.

## Exact next repair scope

1. In `ASC_ArtifactTextHelpers.mqh`, make the emitted checklist heading match required contracts, or relax required contracts to match emitted text. Best fix: emit `Runtime Proof Bundle Capture Checklist:` because both Scanner Status and Manifest expect proof-bundle language.
2. In `ASC_ProofBundleDecisionMappingLine()`, emit `proof_bundle_decision_mapping=` exactly, not only `proof_bundle_decision=`.
3. In `ASC_RunWriteLane`, do not fully suppress SDP route-family mirrors while `top10_batch_active` is true. Allow a tiny one-child SDP route service when membership snapshot exists and budget permits, or record explicit `sdp_route_deferred_due_top10_batch_active=true` in Scanner Status/heartbeat until it fires.
4. Keep FileIO, final paths, L3 gates, L4 ranking/order/formulas, HUD, strategy, and generated outputs untouched.
5. Retest with compile output + Experts + Journal + server export.
