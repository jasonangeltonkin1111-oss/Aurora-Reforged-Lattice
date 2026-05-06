# Forensic Dossier / Runtime Doctrine Audit (2026-04-17)

Scope: live compile-path audit only, no external sources.

## 1. EXECUTIVE VERDICT
The load-bearing problem family is **owner-path collision plus over-gated hydration/admission**: baseline dossier depth is still conditional on shortlist/legal-survivor gates; selected-symbol baseline and deep-trigger lanes still compete over root dossier lifecycle; and HUD preflight gating can block lawful explicit deep queueing before runtime can apply downgrade-label logic.

## 2. FACTS
- Runtime law in `ASC_CORE.MD` defines 1Hz heartbeat and `Scan -> Write -> Read` breathing with HUD consumer-only ownership.
- Dossier queue classification is computed in dispatcher by `ASC_DossierHydrationQueueClassForSymbol(...)`.
- Open-symbol `L3`/`L4` hydration entitlement currently requires:
  - open + resolved + non-stale + non-degraded + lawful L2 packet,
  - committed L3 source ready + PASS,
  - and for L4: committed L4 source ready + `lawful_survivor` + lawful shortlist membership.
- If those entitlement conditions are not met, queue class falls back to open-base or closed-reduced behavior.
- Dossier write lane services queue classes in order and writes either shell (`ASC_BuildDossierShellArtifact`) or continuation (`ASC_BuildDossierArtifact`) depending on mode.
- Composer gates visible sections by:
  - `include_l3_section = ordinary_l34_visible` (open-only via `ASC_ConsumerAllowsOrdinaryL34`),
  - `include_l4_section = shortlist_l4_available && include_l3_section`.
- Closed-mode payload bypasses L3/L4/L5 and must pass minimum integrity threshold.
- Minimum payload integrity check enforces size threshold (`2500` closed, `5000` non-closed) and token checks.
- HUD `Run Full` (`act_deep`) currently runs `ASC_HudDeepPreflightEntitled(...)` before runtime queueing.
- HUD preflight entitlement uses `ASC_DeepSymbolEntitled(...)` and blocks on failure before `ASC_HudEmitCurrentFocusFromDeepTrigger(...)` queues runtime trigger.
- Deep engine entitlement function can return explicit partial entitlement states for historical-only, degraded, continuity-backed, or closed/not-open contexts.
- Runtime selected-symbol reconciliation queues baseline Current Focus write (`view_queued`) when readback is not current, unless deep trigger ownership is active for same symbol.
- Runtime deep path (`ASC_RunDeepFocusTriggerWrite`) composes one payload in deep override mode, writes selected-symbol primary (`Current Focus` contract path), verifies it, then copy-down writes Dossiers path from primary readback.
- Deep path still enforces publishability checks (`ASC_DossierPayloadHasPublishableDeepTruth(...)`) and retained-pair verification semantics.
- Recent commit stream (since 2026-04-16) includes: HUD preflight gate addition, multiple deep-path repairs, selected-symbol copy-down alignment, and same-symbol protection broadening in Current Focus writer.

## 3. ASSUMPTIONS
- The intended product law in the request treats **open baseline = always lawful L0-L4 surface** (with labels for degraded/provisional), while current code treats L3/L4 as admission-gated.
- The active runtime build includes these exact files without hidden compile-path overrides.
- “Tiny/pre-deep/fallback-like root dossier” refers mainly to root selected-symbol file (`Current Focus` contract path) being rewritten by baseline lane after deep lane.

## 4. BREATHING / LANE AUDIT
- Heartbeat/lane architecture is still explicit and structurally lawful (scan/write lane selection, budget checks, queue rebuilds).
- Dossier hydration queue service is write-lane bounded and retries are cadence-driven (urgent lower-layer retry vs slower stable refresh).
- Lane-fit break: selected-symbol baseline write lane and deep-trigger lane are both active writers to selected-symbol root lifecycle (even with ownership guards), so selected-symbol “steady-state” still depends on race/order/backoff and recheck timing.
- Starvation/fight points observed:
  - Current Focus write can be deferred by backoff or scan pressure while state remains queued.
  - Dossier queue service can be deferred on write budget exhaustion and requeued.
  - Deep trigger has explicit priority when pending, but post-success baseline reconciliation can re-arm writes later.

## 5. BASELINE DOSSIERS AUDIT
Why closed/open law does not behave as simple closed=L0-2 and open=L0-4:
- Open L3/L4 are currently **entitlement-based**, not baseline-guaranteed.
- Exact gating chain for open L4 baseline includes:
  - lawful open packet (non-stale/non-degraded),
  - committed L3 PASS,
  - committed L4 lawful survivor + lawful membership.
- If these fail, queue class downgrades to open-base or closed-reduced behavior.
- Composer independently suppresses L4 if shortlist carry fields are not available.
- Therefore open baseline frequently lands as L0-2 or L0-3-like even when symbol is open, because L3/L4 are treated as entitlement outcomes rather than baseline-with-labels.

Lawful vs wrongful blockers (against requested product law):
- Lawful for **labels**: stale/degraded/continuity/pending signals.
- Wrongful for **existence/depth veto** (per requested law): shortlist/lawful-survivor/pass gates controlling whether open baseline may contain L4 structure at all.

## 6. SELECTED-SYMBOL AUDIT
Current runtime behavior on selection:
- HUD selection queues runtime selected-symbol sync (`ASC_HudQueueViewedCurrentFocusSync`) by setting `current_focus_view_pending` + symbol.
- Dispatcher reconciliation checks artifact readback/freshness and either:
  - accepts already-current readback, or
  - queues baseline Current Focus write.
- This is primarily a **baseline selected-symbol publication lane**, not a deep preparation lane.
- Meaningful L5/L6 prep is only armed by explicit deep trigger (`act_deep`), and HUD now pre-gates that request with entitlement checks before queueing.

What prevents selection from acting as meaningful background L5/L6 prep:
- No automatic deep-prep on selection path.
- Deep trigger queueing is manual and now HUD-preflight-blockable.
- Baseline reconciliation path focuses on readback alignment and baseline publish states, not deep precompute staging.

## 7. RUN FULL AUDIT
After Run Full click:
1. HUD `act_deep` validates context and entitlement via preflight.
2. If preflight passes, HUD queues deep trigger in runtime.
3. Dispatcher deep lane resolves symbol, builds deep result, composes canonical deep-override dossier payload.
4. Writes selected-symbol primary file, verifies readback, then copy-down writes Dossiers path and verifies.

Remaining gates/choke points:
- HUD preflight entitlement can block request before runtime queueing.
- Deep compose requires `ASC_DossierPayloadHasPublishableDeepTruth(...)` alignment with deep result fields.
- Retained continuity path has stricter direct protected readback requirement when `ASC_DeepHasOrdinaryCompletedSupport(...)` is required.
- Any copy-down verification failure marks partial publish failure.

Wrongful-veto candidates (vs requested law):
- HUD preflight entitlement as hard front-door veto (instead of allowing runtime to queue and label downgraded outcomes).
- Publishability verification coupling to strict deep-result textual alignment may convert a lawful downgraded deep publish into failure status rather than surviving with explicit degraded labeling.

## 8. ROOT DOSSIER OWNERSHIP AUDIT
Who owns root `Dossier.txt` over time:
- Baseline selected-symbol lane writes root via Current Focus writer path.
- Deep trigger path writes root first as selected-symbol primary and then copies to Dossiers.

Where downgrade/overwrite still occurs:
- Baseline selected-symbol lane remains continuously requeueable via reconciliation (`view_queued`) and can republish after deep run.
- Current mitigation now preserves richer same-symbol deep-authored payloads via `ASC_CurrentFocusPayloadHasProtectedRichDeepSurface`, but downgrade blocking in `ASC_CurrentFocusShouldBlockSameSymbolDowngrade` still keys on completed-deep lifecycle checks for some branches.

Assessment:
- Same-symbol rich preservation improved, but steady-state owner tension remains: baseline lane still has regular write authority and depends on preservation heuristics rather than a strict post-deep ownership mode boundary.

## 9. RECENT GIT REGRESSION MAP
Window audited: commits since ~2026-04-16.

Helpful repairs:
- `8dff671`: single-path deep publish + copy-down alignment in dispatcher.
- `382cbd9`: broadened same-symbol rich protection in Current Focus writer.
- `5d9796a` / `fffccf1`: deep compose/verification choke-point hardening.

Neutral churn:
- message/notice wording changes around HUD full-analysis notices.
- some office/doc/version updates tied to above passes.

Likely harmful doctrine drift:
- `3dccd5c`: HUD deep preflight entitlement gate added as hard front-door block for `act_deep`, shifting veto power into HUD trigger surface.
- Any earlier changes that tied open baseline L4 hydration to committed/lawful-survivor/membership gates (present in current dispatcher queue classifier) are direct contributors to baseline doctrine drift.

## 10. LOAD-BEARING FLAWS
1) **Baseline open-depth entitlement coupling**
- Flaw: open baseline L4 depends on shortlist/legal-survivor/pass chain.
- Why: queue classifier promotes to L4 only after these gates.
- Breakage: open dossiers remain base/L3 in many lawful-open scenarios.
- Naive-fix risk: removing all gates without preserving truthful labels could fake certainty.

2) **HUD front-door deep veto**
- Flaw: HUD preflight blocks Run Full before runtime queue.
- Why: `act_deep` requires `ASC_HudDeepPreflightEntitled` success.
- Breakage: explicit selected-symbol lane cannot even start for downgrade-labeled lawful attempts.
- Naive-fix risk: bypassing all checks could allow cross-symbol/invalid context armings.

3) **Selected-symbol dual steady-state writer pressure**
- Flaw: baseline reconciliation lane and deep lane both retain root write authority over time.
- Why: baseline queue remains active by sync/readback logic; deep ownership is transient.
- Breakage: rich root can still be challenged by later baseline writes unless heuristics catch it.
- Naive-fix risk: hard-disabling baseline writes could break legitimate selected-symbol refresh continuity.

4) **Strict publishability verification as survival gate**
- Flaw: deep payload verification demands strong structural alignment and may fail downgraded-but-useful payloads.
- Why: compose/write path enforces publishable deep truth checks and retained/direct proof constraints.
- Breakage: Run Full can end in failure states instead of retaining labeled downgraded dossier.
- Naive-fix risk: weakening verification too far could accept malformed/partial artifacts.

## 11. ROADMAP PLAN
Stage 1 (Owner-path and veto boundary correction)
- Scope: dispatcher + HUD deep trigger admission seam only.
- Goal: move Run Full admissibility authority fully into runtime queue/compose path; HUD remains trigger-only.
- Keep: symbol-context sanity checks, request freezing, anti-cross-symbol protections.
- Avoid: shortlist/ranking/HUD rendering rewrites.

Stage 2 (Baseline hydration doctrine normalization)
- Scope: dossier queue classifier + composer section inclusion gates.
- Goal: enforce closed=L0-2 and open=L0-4 baseline structure, with degraded/pending labels instead of depth vetoes.
- Keep: stale/degraded/continuity labels and cadence discipline.
- Avoid: deep engine redesign.

Stage 3 (Selected-symbol steady-state ownership hardening)
- Scope: current-focus baseline overwrite policy and reconcile write admission.
- Goal: after deep success for same symbol, baseline lane must preserve authoritative rich root unless true symbol-context change or freshness-invalidated replacement is proven.
- Keep: retries/backoff, readback verification.
- Avoid: duplicate writer paths.

Stage 4 (Verification semantics refinement)
- Scope: deep publishability/readback checks.
- Goal: distinguish malformed payload failure from lawful downgraded deep payload; downgraded outcomes should survive with explicit integrity labels.
- Keep: temp->validate->promote and symbol/pair alignment proofs.
- Avoid: weakening integrity to accept incomplete garbage.

## 12. FIRST PASS RECOMMENDATION
Best first repair pass: **remove HUD hard preflight entitlement veto from `act_deep` and let runtime own final entitlement/downgrade decisioning**.

Why first:
- It restores product-law ownership boundary fastest (HUD trigger/read only).
- It unblocks explicit selected-symbol lane from being denied before runtime can label lawful partial/degraded outcomes.
- It is narrow and low-regression compared with baseline hydration redesign.

Must NOT touch in first pass:
- shortlist/ranking formulas,
- broad dossier queue classifier redesign,
- deep computation internals,
- market board ownership logic.
