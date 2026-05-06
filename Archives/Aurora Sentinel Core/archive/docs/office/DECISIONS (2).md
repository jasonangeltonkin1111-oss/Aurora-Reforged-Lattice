## 2026-04-25 — DOC 16 FINAL decision: close source/control, defer live proof to Doc 18

Decision:
Close Doc 16 as source/control complete under the operator's new two-run structure, with proof-holds carried to the Doc 18 final integrated live test.

Rationale:
- Doc 16 already has actual file/title/scope source identity and a B1–B11 dependency/closure matrix.
- Internet research supports explicit known-limitations disclosure, traceability from backlog item to acceptance evidence, and staged/deferred verification when the deferred proof gate is named and controlled.
- The old Doc 16 Run 3/Run 4 wording became a stale process seam after the operator superseded per-doc live testing.

Admitted patch:
- Bump `ASC_VERSION_LABEL` to `Stage2-Doc16-Final-BacklogCloseout`.
- Add compact source-visible constants for the two-run doctrine, Doc 18 final integrated live test, and Doc 16 closeout boundary.
- Sync office/control truth and Doc 16 run history.

Rejected patches:
- No ranking, L3/L4 scoring, L5/L6 deep analysis, ordinary dossier hydration, write-lane mechanics, HUD, Top10 mechanics, classification, FileIO behavior, trade logic, broad dispatcher scheduling, Doc 17 implementation work, or Doc 15 rerun.

Proof boundary:
- No MetaEditor compile, live runtime proof, calibration proof, validation proof, trading-edge proof, or final integrated proof is claimed.
- Doc 18 final integrated live test must prove the carried compile/runtime/log/artifact/cadence proof-holds before closure language can advance beyond source/control.

## 2026-04-25 — DOC 16 RUN 2 decision: patch closure-blocker/proof-boundary wording, not runtime mechanics

Decision:
Patch one bounded Doc 16 seam: source-visible backlog dependency and closure-blocker language.

Rationale:
- Internet research supports explicit done criteria, dependency visibility, release/readiness evidence, traceability, and risk/blocker disclosure before closure claims.
- Run 1 correctly made actual Doc 16 identity source-visible and avoided runtime mechanics.
- The remaining weakness was that Doc 16 authority constants did not yet explicitly block future overclaiming from source-landed status to runtime-proven or closure-ready status.

Admitted patch:
- Add compact source-visible Doc 16 closure/proof-boundary constants in `mt5/core/ASC_Version.mqh`.
- Add explicit B1–B11 dependency/closure matrix in actual Doc 16.
- Sync office/control truth.

Rejected patches:
- No ranking formula, L3/L4 scoring, L5/L6 deep analysis, ordinary dossier hydration, write-lane throughput mechanics, HUD, Top10 mechanics, classification, FileIO behavior, trade logic, or broad dispatcher scheduling.
- No Doc 17 start.
- No Doc 15 rerun.

Proof boundary:
- No MetaEditor compile, runtime proof, calibration proof, validation proof, or closure proof is claimed from Run 2.
- Superseded by final closeout: no Doc 16 Run 3 remains; source identity/runtime build proof moves to Doc 18 final integrated live test.

## 2026-04-25 — DOC 16 RUN 1 decision: patch source identity for actual Execution Backlog authority

Decision: admit one bounded compile-path source patch in `mt5/core/ASC_Version.mqh` and office/control filename-authority corrections.

Reason:
- The actual Doc 16 roadmap file in this pack is `16_EXEC_BACK.md`, titled **Execution Backlog**.
- Office/control still contained longer alias wording for Doc 16, and compile-path build identity still pointed at Doc 15 after Doc 16 became active.
- Doc 16 is backlog / closure-dependency control only, so a functional runtime patch would be fake scope unless a direct source contradiction appeared.
- The lawful source seam is build identity and source-visible Doc 16 authority constants, not ranking, HUD, Top10 mechanics, deep analysis, dossier law, or trade logic.

Accepted change:
- Bump `ASC_VERSION_LABEL` to `Stage2-Doc16-Run1-ExecutionBacklogAuthority`.
- Add source-visible constants for actual Doc 16 authority file, title, and scope.
- Correct office/control references to the actual shortened Doc 16 filename where this pass touched authority lists.

Rejected changes:
- No ranking, L3/L4, L5/L6, HUD, Top10 lifecycle/count/ranking/diversification, ordinary dossier hydration, classification, FileIO publication mechanics, trade logic, or broad dispatcher scheduling edits.
- No fake compile proof, live proof, calibration proof, or validation proof.

Next proof burden:
- Run 2 must internet-harden backlog/closure-dependency/proof-class wording.
- Superseded by final closeout: no Doc 16 Run 3/Run 4 remains; proof-holds move to Doc 18 final integrated live test.

## 2026-04-25 — Decision: close Doc 15 with proof-hold after bounded GlobalTop10 cadence patch

### Decision
Close Doc 15 source/control work with proof-hold disclosed and admit Doc 16 as the next roadmap doc.

### Why
- Run 3 supplied useful manifest-boundary evidence but did not supply compile/log proof.
- Run 4 found a real compile-path source seam requested by the operator: GlobalTop10 full-child automatic refresh cadence was still `600` seconds / 10 minutes.
- The exact owner was `mt5/runtime/ASC_Dispatcher.mqh`; the cadence is stored as seconds in `ASC_TOP10_RUN_FULL_CADENCE_SEC` and evaluated by `ASC_Top10RunFullCadenceDue(...)`.
- Changing that constant to `300` seconds plus matching owner-path reason text satisfies the bounded micro-task without reopening ranking, diversification, stage/promote/archive mechanics, HUD, or deep analysis.

### Boundaries
- This is not validation/calibration proof.
- This is not a live runtime proof claim.
- MetaEditor compile remains required externally.
- Next live verification must include compile transcript, function/heartbeat logs, root Scanner Status, root Market Board, and a fresh GlobalTop10 cadence cycle.

### Rejected options
- Do not change L4 shortlist/board authority cadence: it is a separate 600-second authority cadence and was not the operator's requested micro-task.
- Do not redesign Top10 lifecycle: stage/promote/archive mechanics remain protected.
- Do not rerun Doc 14 or start Doc 16 inside this pass.

## 2026-04-25 — DOC 15 RUN 1 decision: patch FileIO validation wording boundary

Decision: admit one bounded compile-path source patch in `mt5/io/ASC_FileIO.mqh`.

Reason:
- Doc 15 must stop source-landed/runtime-visible/readback evidence from being over-read as calibration, validation, or closure.
- The FileIO atomic publication path is a central evidence source because its reason strings appear in logs and artifact publication state.
- Generic success wording `validated` / `validated and promoted` was too strong for what the owner actually proves.
- The owner proves payload readback, required-token presence, expected-payload equality, and promotion success. It does not prove strategy validation, calibration, edge contribution, or roadmap closure.

Accepted change:
- Replace success wording with `readback_token_contract_satisfied` while leaving function names, signatures, mechanics, required-token checks, path helpers, and promotion logic unchanged.

Rejected changes:
- No rename of existing functions or validation variables because that would create compile churn without improving operator truth.
- No ranking/scoring/deep/HUD/Top10/dossier-law changes.
- No fake compile, live, calibration, validation, or closure proof.

Next proof burden:
- Run 2 must internet-harden the validation/calibration terminology and decide whether one additional source-visible closure-boundary line is needed.
- Run 3 must live-test log/artifact wording under real MT5 publication.
- Run 4 must close/polish from Run 3 evidence by default.

## 2026-04-25 — DOC 14 RUN 4 decision: close with bounded manifest wording polish

Decision: admit one final source polish seam and close Doc 14 with the compile-proof limitation disclosed.

Reason:
- Run 3 already live-proved the required proof lines in `Artifact Bundle Manifest.txt` and showed manifest publish logs at `state=ok`.
- The remaining code seam was not logic; it was operator readability. The old line `Source-Level Landed=source_owner=...` was too easy to read as duplicate proof language.
- The lawful fix is source-text composition only inside the Artifact Bundle Manifest helper functions.

Accepted bounded changes:
- Compact `Proof Class Ledger:` wording.
- Compact `Checkpoint Evidence:` wording and clearer `hold_reason=`.
- Compact `Evidence Boundary:` internal artifact/live values while preserving `compile_proof=not_observed_by_manifest`, `calibration_validation=not_claimed_by_manifest`, and `run3_required=MetaEditor_compile_plus_MT5_artifact_log_screenshot_proof`.
- Version bump to `Stage2-Doc14-Run4-ProofCloseoutPolish`.

Rejected changes:
- No required-token renaming.
- No rank/scoring/HUD/Top10/deep/dossier-law/mechanics edits.
- No fake compile proof.
- No new live run by default, because the patch does not change runtime behavior or required-token identity.

Closeout:
- Doc 14 is closed with the compile proof still disclosed as missing/external.
- Doc 15 may start next; the next MT5 operator verification should still capture MetaEditor compile plus one regenerated `Artifact Bundle Manifest.txt` screenshot/log check.

## 2026-04-25 — DOC 14 RUN 3 decision: office-only live proof hold, no source patch

Decision:
- Do not admit a compile-path source patch in Doc 14 Run 3.
- Update office/control files only.

Reason:
- Fresh live manifest output already contains `Proof Class Ledger:`, `Checkpoint Evidence:`, and `Evidence Boundary:`.
- The manifest evidence boundary does not overclaim compile proof, calibration/validation proof, or full live closeout.
- The observed live state is a truthful hold/deferred state: pending dossiers/manifest remain present, Market Board baseline is preserved, and Current Focus/root `Dossier.txt` carries selected-symbol deep support as a lawful split-role surface.
- MetaEditor compile tooling is unavailable in this environment and no compile log was supplied, so compile closure cannot be claimed honestly.

Consequence:
- Doc 14 Run 3 is evidence-useful but not strict compile-closed.
- Doc 14 can move to Run 4 final polish/closeout hardening using Run 3 artifact evidence by default only if the missing compile proof is accepted as an external-environment limitation; otherwise Run 3 compile proof must be rerun in MetaEditor.
- No ranking, HUD, dossier-law, Top10, deep-analysis, classification, trade, write-throughput, or broad scheduling seam is reopened.
## 2026-04-25 — Decision: admit DOC 13 RUN 2 internet-hardened wording/provenance patch

### Decision
Admit one bounded compile-path patch for Doc 13 RUN 2: harden shared operator-surface wording so retained/stale/preserved/staging/archive truth cannot be read as fresh current promoted authority.

### Why
- W3C provenance guidance supports exposing production/source context so users can judge quality, reliability, and trustworthiness.
- Lineage/status communication patterns support separating current state, degraded state, historical/archive evidence, and candidate/staged outputs.
- RUN 1 wording landed the right owner path but still used wording that could be too soft: `current surface may be last-known lawful truth` could still sound operator-current rather than retained.

### What was chosen
- Make the shared helper state explicit surface roles.
- Add one shared provenance line and reuse it in Market Board, Dossier integrity notes, and GlobalTop10 manifests.
- Leave runtime mechanics untouched.

### Why other options were rejected
- No dossier-law restoration: this run is Doc 13 wording/provenance only.
- No write-lane throughput repair: no live evidence was supplied and this is not the active lane.
- No ranking or Top10 product redesign: surface wording must not move authority.
- No live closeout: source edits do not prove runtime visibility.

### Next proof burden
RUN 3 must compile and live-prove the wording/provenance contract across the visible artifact family, including retained/stale/degraded/staging/archive cases.

## 2026-04-25 — Decision: land Doc 13 surface-truth wording before internet/live proof

Admit a bounded source patch for Doc 13 RUN 1.

Reason: git history shows the source now has stronger Top10 preserve/stage/archive/promote and family-manifest mechanics, but operator-facing wording still needed a shared contract so `fresh`, `degraded`, `stale`, `ready`, `current`, `preserved`, `staging`, and `archive` cannot be read as competing truth owners.

Decision boundaries:
- Market Board remains the authority surface for ordinary trade-picking and diversified overall ranking.
- Dossier and Current Focus remain support/derived surfaces.
- GlobalTop10 family manifests are observability/provenance surfaces, not new truth owners.
- Staging is explicitly not operator-current until verified/promoted.
- Archive is evidence of prior snapshot state, not current ranking authority.
- No live closure can be claimed from this source/control-only package.

RUN 2 must internet-harden the wording against freshness/provenance/stale-view best practices.
RUN 3 must live-prove that the new surface truth appears across Market Board, Dossier/Current Focus derived surfaces, GlobalTop10 children, manifests, and logs under real preserve/stage/promote/archive behavior.
RUN 4 is reserved for final hardening or closeout after live proof.

﻿## 2026-04-25 — Decision: Top10 RUN 2 hardens archive/promote law before live proof

### Decision
HARDEN NOW.

### Reason
Internet method review supports RUN 1's preserve/stage/verify/promote direction, but warns against partial publication and weak archive success semantics. RUN 1's archive slot skip check was too fragile because any existing archive child could suppress archive writing for the whole slot.

### Accepted bounded changes
- Archive success must require a complete verified archive family, not one existing file.
- A partial archive slot blocks promotion rather than being treated as success.
- The prior live family must verify before archive.
- Archive and current promoted families must verify after write.
- Staging/archive/current family manifests are allowed as observability markers only; they do not become truth owners.

### Rejected changes
- No broad GlobalTop10 redesign.
- No HUD redesign.
- No Layer 3/4 scoring formula changes.
- No dossier/current-focus ownership change.
- No live-success claim until RUN 3 evidence exists.

﻿## 2026-04-23 — Decision: repair the GlobalTop10 owner path now instead of waiting for another audit pass

### Decision
Admit direct source edits now. Fix the owner-path contradiction inside the dispatcher/file-io compile path.

### Why
- live proof showed the current GlobalTop10 family was still being written in place during refresh
- archive logic was still only surfaced diagnostically and not publishing a real snapshot family
- leaving that seam open would keep current truth vulnerable to partial rebuilds and visible operator desync during Run Full Top10

### What was chosen
- keep the live child family as the last confirmed complete family
- stage new child artifacts under `_staging`
- archive the previous live family on the lawful 10-minute slot before replacement
- promote staged children into live only after verification succeeds
- leave live family unchanged if verification or archive/promotion fails

### Why other options were rejected
- no broad HUD redesign
- no broad architecture rewrite
- no fake office-only closeout while the product seam remained live

### Next proof burden
Fresh live runtime must now prove that archive files are actually written, current live children remain stable during refresh, and promotion happens only after the staged family completes.

## 2026-04-23 — Decision: admit RUN 2 internet hardening for Docs 09 / 10 / 12 and Top10 archive source prep

### Decision
Admit code edits now. Patch exactly one bounded compile-path hardening seam for Doc 09, one for Doc 10, one for Doc 12, and one bounded Top10 archive source-prep seam.

### Why
- web research supported the remaining contradictions rather than weakening them
- Doc 09 still needed a stricter distinction between improving carry and noise leakage
- Doc 10 still needed transaction-cost / turnover realism beyond the first execution-relief branch
- Doc 12 still needed freshness protection that was strong **and** bounded, rather than permanent once a served lane existed
- the requested Top10 archive system needed lawful owner-path preparation before any live proof run
- the merged HUD PR / office history is now part of current source truth and must not be silently lost from the control narrative

### What was chosen
- tighten Layer 3 `building` carry requirements using already-owned score fields
- tighten Layer 4 execution-relief replacement with friction-improvement and liquidity-quality requirements
- time-bound manifest reserve criticality for exercised proof lanes
- add archive-root / cadence-slot / design-target helpers for GlobalTop10 archive preparation and expose them in diagnostics only

### Why other options were rejected
- no broad Layer 3 rewrite
- no broad shortlist redesign
- no permanent reserve escalation based on stale served-history alone
- no live archive scheduling activation in RUN 2
- no HUD redesign reopening

### Next proof burden
RUN 3 must prove the tightened seams live and must show whether GlobalTop10 archival can publish on the lawful owner path every 10 minutes without desynchronising Market Board / HUD / child-family truth.

## 2026-04-23 — Decision: admit one bounded source seam per doc in the combined 09/10/12 convergence lane

### Decision
Admit code edits now. Patch exactly one bounded compile-path seam for Doc 09, one for Doc 10, and one for Doc 12 inside the combined RUN 1 git/source convergence lane.

### Why
- the fresh runtime pack still shows real remaining weakness in all three docs
- the recent commit chain shows the earlier broader seams were already landed
- the remaining contradiction is now narrower than the original doc lanes:
  - Doc 09 = over-guarding / under-admission realism
  - Doc 10 = replacement realism under anti-churn discipline
  - Doc 12 = manifest / verification freshness under startup pressure
- leaving these seams untouched until RUN 2 would force the later research pass to reason over known source weakness instead of a cleaner source baseline

### Constraints preserved
- no Market Board ownership move
- no dossier/current-focus ownership move
- no broad HUD redesign
- no Global Top 10 product redesign
- no broad architecture redesign
- no live-closeout claim in this pass

### Consequence
The source is now stronger for all three docs, but the lane remains open. RUN 2 must harden the method basis and RUN 3 must later prove the behavior live.

## 2026-04-23 — Doc 12 RUN 3 compile-gate decision

### Decision
Do **not** pretend this is a live-closeout pass yet. Treat it as a **compile-repair hold** because the supplied compile output proved the current Doc 12 source state was broken.

### Why
- `ASC_DossierComposer.mqh` failed at the Run 2 Layer 6 change/contest carry seam.
- The failure was narrow and source-local, not evidence of a broad Layer 6 ownership failure.
- No fresh live artifact pack was included in the provided zip, so even a clean source repair would still not justify a live-closeout claim inside this pass.

### What was chosen
- repair the exact compile seam in `ASC_DossierComposer.mqh`
- do not reopen dispatcher / runtime-state logic broadly
- update office truth so the next admitted move is a real compile re-check followed by live proof only if compile is clean

### What was patched
- removed the unresolved `ASC_L6_ALLOWED_STYLE_REVIEW_ONLY` reference from the support-priority summary path
- added `ASC_L6ReviewDeltaStateTransitionNote(...)`
- added `ASC_L6ReviewDeltaDeepTransitionNote(...)`
- left all solved family-sync ownership paths unchanged

### Why other options were rejected
- not a broad HUD pass: compile evidence did not justify it
- not a new family-sync rewrite: the known problem here was compile breakage, not fresh alignment failure evidence
- not a live-closeout claim: no fresh compile-clean proof or runtime pack was available in this pass

### Next proof burden
The next pass must:
- recompile the repaired source
- verify the compile gate is actually clean
- then run the bounded live proof for the Layer 6 three-line summary and the already-landed family-sync / child-family alignment path

## 2026-04-23 — Doc 12 RUN 2 seam choice

### Decision
Keep **Doc 12** as the active main-roadmap lane and admit one bounded RUN 2 source patch in the true Layer 6 owner.

### Why
- External decision-support guidance supports prioritizing actionable, workflow-fit information rather than presenting multiple equally weighted support lines.
- Uncertainty communication research supports stating uncertainty and change explicitly; that does not inherently reduce trust and can preserve trust when evidence later changes.
- RUN 1 already patched the GlobalTop10 family-sync source seam and exposed source identity / alignment state. After audit, that seam no longer lacked an obvious additional RUN 2 source patch.
- The remaining highest-leverage weakness was first-read ordering: Layer 6 had change truth and contradiction truth, but did not carry them together in the selected-symbol summary block.

### What was chosen
- **Doc 12 core seam:** change / contest co-ordering tightening in `ASC_DossierComposer.mqh`
- **Family-sync follow-up seam:** no new source patch admitted in RUN 2; existing RUN 1 repair remains the live-proof burden
- **Verification seam:** no new logging class admitted in RUN 2 because existing shortlist-source / child-family / alignment carry was already sufficient for decisive RUN 3 proof

### What was patched
- review snapshot / delta is now built before Layer 6 current-focus summary composition
- the selected-symbol current-focus summary now carries:
  - `Latest Meaningful Change`
  - `Still Contested Now`
- those lines reuse existing owner truth and do not create a hidden second analysis path

### Why other options were rejected
- not another GlobalTop10 family-sync source expansion: the system already carries source pass, source signature, alignment status, and alignment reason
- not a HUD redesign: the research-backed weakness was support ordering, not layout
- not a Market Board rewrite: board authority remains upstream and protected
- not office-only: the selected-symbol summary block itself needed to change for RUN 3 to prove the right thing live

### Next proof burden
The next pass must run the patched source live and prove:
- the selected-symbol Layer 6 summary now shows `Support Priority Now`, `Latest Meaningful Change`, and `Still Contested Now` together
- the already-landed GlobalTop10 family alignment lines still expose shortlist-source vs child-family truth directly
- a shortlist-family change queues and refreshes the child family instead of leaving the old family looking current
- dropped child artifacts no longer linger as if current truth
- Market Board authority and dossier/current-focus support-only law remain intact


## 2026-04-23 — Doc 12 RUN 4 live-pack decision

### Decision
Do **not** close Doc 12 yet. Treat this as a **manifest-sync hardening hold** because the supplied live pack proved one narrow runtime verification seam and this environment still cannot produce honest MetaEditor compile proof.

### Why
- The Layer 6 three-line selected-symbol summary is present live, so that seam is no longer the blocker.
- Runtime logs show GlobalTop10 child-family refresh activity and aligned completion, so the core family-sync owner path is materially stronger than the frozen manifest alone suggests.
- The contradiction is that `Artifact Bundle Manifest.txt` remained at an early unproven snapshot while later Market Board / Current Focus / GlobalTop10 child artifacts kept changing.
- Without a fresh compile re-check and fresh post-patch live rerun, closing Doc 12 would still overclaim.

### What was chosen
- patch one exact dispatcher seam that forces manifest republish after GlobalTop10 child-family completion
- do not reopen dossier-owner logic broadly
- do not reinterpret the stale manifest as proof that the underlying family-sync runtime path failed wholesale
- update office truth so the next admitted move is compile re-check plus one fresh live rerun

### What was patched
- `ASC_Dispatcher.mqh` now marks the manifest dirty and the write lane active when a GlobalTop10 child-family batch drains to completion
- `ASC_Version.mqh` now labels the source as `Stage2-Doc12-Run4-ManifestSyncHold`

### Why other options were rejected
- not a broad HUD pass: the live contradiction was publish verification freshness, not layout ownership
- not a new Layer 6 summary rewrite: the summary is already visible live in the selected-symbol dossier
- not an office-only pass: the live pack proved a real source seam worth patching immediately

### Next proof burden
The next pass must:
- run a real MetaEditor compile re-check on the updated source
- produce a fresh live pack after the patch
- verify the manifest timestamp and payload now advance after GlobalTop10 child-family completion and selected-symbol proof landing
- then judge whether Doc 12 can close honestly

## 2026-04-25 — Decision: GlobalTop10 must be cadence-owned, not click-owned

### Decision
GlobalTop10 refresh is now governed by a 10-minute dispatcher cadence. Manual HUD actions may request visibility/current truth, but they may not bypass cadence and launch a hidden full-family recompute when the cycle is not due.

### Why
The latest runtime evidence showed the Top10 family could change too often and archive publication was not proven as a real family writer. A lawful snapshot system needs stable cycles: preserve current live family, build staging, verify staging, archive the prior confirmed family, and promote only after successful family-level proof.

### Rejected options
- Direct live-family rebuild was rejected because it can expose partial or mixed-age truth.
- Archive-by-label without actual files was rejected because it creates false proof.
- Manual click bypass was rejected because it turns operator action into hidden recompute spam.
- Broad HUD redesign was rejected because the seam is lifecycle/cadence ownership, not layout.

### Next proof burden
RUN 2 must harden the cadence/archive/promote method with external research. RUN 3 must compile-check and live-prove the actual 10-minute cadence, archive folder/file creation, staging-to-live promotion, and failure preservation behavior.

## 2026-04-25 — Decision: Top10 RUN 3 cannot close without live evidence

### Decision
Do **not** close the Top10 snapshot / cadence / archive lane from the uploaded RUN 3 package.

### Why
- The package does not include the required fresh runtime artifacts, logs, archive folders/files, or HUD screenshots.
- This environment cannot run an honest MetaEditor compile gate, and no compile log was supplied.
- Source inspection shows the intended Run 1 / Run 2 mechanics are present, but source presence is not live proof.

### What was rejected
- rejecting false closure: no claim of 10-minute cadence success, manual cadence hold, archive write success, or preserve-stage-promote success was made
- rejecting speculative code edits: no fresh live contradiction was present to justify runtime changes
- rejecting office-only closure: office files were updated only to record the hold and next proof burden

### Next proof burden
Run the EA in MT5 after a real MetaEditor compile, then provide the fresh artifact pack proving:
- cadence due / not-due and manual Run Full Top10 behavior
- current family preservation during staging
- staging verification and promote order
- real archive directory/file write and archive readback
- staging/archive/current manifests
- function/heartbeat logs carrying reconstructable lifecycle context
- HUD Top10 / Market Board / current children / archive family sync

## 2026-04-25 — DOC 13 RUN 3 decision

Decision: **PATCHED NARROW SEAM; RUN 4 REQUIRED NEXT**.

Facts:
- MetaEditor compile could not be run in this environment.
- Live Market Board displayed `Surface Truth`, `Family Meaning`, and `Surface Provenance`.
- Live GlobalTop10 current/staging/archive manifests displayed family role/state/provenance and clear staging/archive non-authority wording.
- Live root `Dossier.txt` / Current Focus did not display explicit `Surface Truth:` / `Surface Provenance:` lines.

Decision:
- Admit only the Dossier publication-health seam: print explicit Surface Truth and Surface Provenance lines and make them required tokens for non-closed Dossier payloads.

Rejected:
- No Doc 14 start, no new roadmap, no ranking upgrades, no HUD work, no write-lane throughput repair, no GlobalTop10 cadence redesign, no deep-analysis rewrite.

Next:
- DOC 13 RUN 4 must run real MetaEditor compile and fresh live regeneration to prove the patched Dossier/Current Focus output.

## 2026-04-25 — Doc 13 Run 4 root Dossier / Current Focus naming decision

Decision: root `Dossier.txt` is the active selected-symbol Current Focus surface. A separate `Current Focus.txt` output is not required by current product law. The existing `ASC_CurrentFocusWriter.mqh` name is retained as a compatibility/source-owner name because the contract target resolves through `ASC_CURRENT_FOCUS_FILE` to root `Dossier.txt`. Future workers must interpret `Dossier / Current Focus` proof language as root `Dossier.txt` / selected-symbol Current Focus surface unless fresh source proves a second active output.

Boundaries: this decision does not move Market Board authority, does not create a second truth owner, does not restore ordinary dossier law, does not rewrite GlobalTop10 cadence, and does not start Doc 14.

## 2026-04-25 — Decision: Doc 14 Run 1 is office/protocol-only unless a compile-path proof helper seam is proven

Decision:
- Activate Doc 14 as the current roadmap doc.
- Park Doc 13 as proof-held: source/control improved, root `Dossier.txt` / Current Focus naming seam patched, but not fully closed without MetaEditor compile and fresh MT5 runtime closeout proof.
- Treat Doc 14 Run 1 as git/source + office protocol hardening only; no internet research and no live proof claim.
- Admit office/control edits now because the existing Doc 14 protocol was too thin to enforce future proof discipline.
- Do not admit compile-path source edits in this pass because no source-level proof/reporting helper seam was proven.

Protected seams:
- Market Board remains authority.
- Root `Dossier.txt` remains selected-symbol Current Focus support surface.
- `Dossiers/<symbol>.txt` remains per-symbol dossier family.
- `Dossiers/GlobalTop10/` remains GlobalTop10 support/deep family.
- Staging is candidate truth, archive is evidence, retained last-good is not fresh truth.
- No ranking, HUD, write-lane, Top10, classification, deep-analysis, dispatcher, or trade-logic changes are admitted by Doc 14 Run 1.

Next decision burden:
- Doc 14 Run 2 must internet-harden the protocol using official/primary/high-quality sources and must show exactly which research changes source/control wording.

## 2026-04-25 — DOC 14 RUN 1 REDO decision: manifest proof-class/checkpoint seam admitted

Decision: admit one bounded compile-path source patch in the Artifact Bundle Manifest owner.

Rationale:
- Doc 14 is about proof discipline, not trading behavior.
- `Artifact Bundle Manifest.txt` is the most useful batch-test evidence surface because it already gathers publication bundle, Market Board, Current Focus/root Dossier, active artifact readback, Top10 batch, and write-performance state.
- The gap was not missing mechanics; it was missing compact proof-class and checkpoint language that tells the operator whether a pass is source-landed, artifact-visible, runtime-proven, or still held.

Boundary:
- Patch only proof/reporting text and manifest validation tokens.
- Do not alter ranking, deep analysis, Top10 lifecycle mechanics, dossier hydration ownership, write-lane throughput, HUD, classification, or trade behavior.

Run doctrine:
- Run 2 must internet-harden the proof taxonomy and observability language.
- Run 3 must compile/live-test the manifest lines.
- Run 4 must polish/close using Run 3 evidence by default, with no automatic fresh live run unless evidence is missing/contradictory or Run 4 changes runtime behavior.

## 2026-04-25 — DOC 14 RUN 2 decision: add manifest Evidence Boundary line

Decision:
- Admit one bounded source/control patch for Doc 14 Run 2.
- Add an `Evidence Boundary:` line to the Artifact Bundle Manifest instead of changing ranking, HUD, Top10, dossier law, deep analysis, classification, trade logic, or dispatcher scheduling.

Reason:
- Internet research supported the distinction between verification, validation, observability evidence, provenance context, and runtime status.
- Run 1 proof ledger and checkpoint line were directionally correct, but the manifest still needed a direct statement that compile proof, live runtime proof, and calibration are not produced by manifest readback alone.

Owner:
- Source owner: `mt5/runtime/ASC_Dispatcher.mqh` / `ASC_WriteArtifactBundleManifest()`.
- Office owner: Doc 14 batch-test protocol and runtime proof baseline.

Consequence:
- Run 3 must compile and live-prove `Proof Class Ledger:`, `Checkpoint Evidence:`, and `Evidence Boundary:` across real MT5 artifact states.
- Run 4 should close/polish from Run 3 evidence by default and should not demand new live evidence unless Run 3 is missing/contradictory or Run 4 changes runtime behavior.

## 2026-04-25 — DOC 15 RUN 2 decision: FileIO validation wording must remain token-contract wording

Decision:
- Treat FileIO publication readback and required-token checks as readback/token-contract evidence, not validation, calibration, closure, or trading-edge proof.

Reason:
- Internet research on software V&V and testing terminology supports a strict split: verification/checking can confirm local requirements/contracts, while validation requires intended-use/context evidence. Provenance/readback/observability evidence can support trust and diagnosis but must not be reported as validation proof by itself.

Bounded source consequence:
- `mt5/io/ASC_FileIO.mqh` may report token-contract/readback-token-contract success or failure.
- It must not report generic validation success/failure for publication-token checks unless a later validated evidence class is explicitly introduced and proven.

Protected consequence:
- This decision does not authorize ranking, HUD, Top10, deep-analysis, dossier-law, throughput, classification, trade logic, or broad scheduler edits.

Run 3 burden:
- Live-test the wording in actual MT5 logs/artifacts after external compile and publication cycles.

## 2026-04-25 — DOC 15 RUN 3 decision: hold strict live proof, do not patch source

Decision:
- Do not admit a compile-path source patch in Doc 15 Run 3.
- Admit office/control updates only.

Reason:
- The actual Doc 15 roadmap requires honest closure boundaries and explicitly forbids treating source edits, office text, or support artifacts as calibration/validation/closure proof.
- The uploaded live artifact pack proves the Artifact Bundle Manifest still carries the correct proof-boundary lines, including `compile_proof=not_observed_by_manifest` and `calibration_validation=not_claimed_by_manifest`.
- The uploaded pack does not include MetaEditor compile output, `Workbench/logs/function_results.log`, or heartbeat telemetry. Therefore the required FileIO success/failure wording cannot be live-proven.
- Source inspection already shows the Run 1/Run 2 FileIO helper names and reason strings are present in the active source owner. The current gap is live evidence capture, not a proven source contradiction.

Rejected changes:
- No ranking rewrite.
- No HUD redesign.
- No GlobalTop10 cadence/promote/archive mechanics change.
- No dossier-law restoration change.
- No deep-analysis change.
- No broad logging schema redesign.
- No validation/calibration/closure claim.

Next:
- Run 4 may polish/close office wording using the Run 3 evidence only if it explicitly carries the compile/log proof hold.
- If strict Doc 15 live wording proof is required before Run 4, rerun Run 3 with MetaEditor compile transcript plus `Workbench/logs/function_results.log` containing FileIO publication success/failure reason lines.
