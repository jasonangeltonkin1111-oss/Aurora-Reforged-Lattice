## 2026-04-25 — Doc 15 Run 4 supersession note: GlobalTop10 cadence interval reduced

Doc 15 Run 4 reduced the GlobalTop10 full-child automatic refresh cadence from 10 minutes to 5 minutes in `mt5/runtime/ASC_Dispatcher.mqh`. The family-sync law remains unchanged: staging is candidate truth, archive is evidence, current stays the last confirmed complete family until verify/promote succeeds, and no second truth owner is introduced.

﻿## RUN 2 Top10 cadence/archive hardening — family-sync contract strengthened before live proof

### Research-backed correction
RUN 1 correctly moved GlobalTop10 toward preserve/stage/archive/promote, but the archive safety contract was still under-specified. A partially present archive slot could be treated as already written, which is unsafe for immutable time-slot history and would weaken live observability.

### What changed now
- GlobalTop10 child verification is reusable across staging, live, and archive directories.
- Archive eligibility validates the prior live family before copying.
- Archive slot skip requires a complete verified slot; partial slots block promotion.
- Archive copy is followed by archive-family readback verification.
- Staging, archive, and promoted current families now write `_family_manifest.txt` with role, state, source pass, signature, child count, and children.
- Promote verifies the current live family after copy and before old dropped symbols are removed.

### What remains unproven
RUN 2 does not prove live success. RUN 3 must show actual archive files, manifest files, no hidden cadence bypass, current-family preservation during staging, and successful promote/readback under runtime conditions.

﻿## RUN 3 source repair — GlobalTop10 archive publication moved from design-target posture to compile-path owner logic

### What changed now
- GlobalTop10 child writes now stage under `_staging` rather than overwriting live children directly
- prior committed live children are archived into the 10-minute slot before replacement
- staged children are promoted into the live family only after successful verification
- if verification/promotion/archive fails, live family stays intact and runtime reports the block instead of silently rebuilding current truth in place

### Why this matters for Doc 12
This turns the archive/family-sync seam from “diagnostic preparation only” into real owner-path behavior, while keeping one-truth publication discipline intact.

## RUN 2 internet hardening addendum — verification freshness must be protected but time-bounded

### Research-backed hardening outcome
RUN 1 was directionally right to stop startup/backlog pressure from starving verification-critical manifest republishes.
RUN 2 hardens the seam by removing the permanent "served once" trigger. Verification reserve now stays critical only while the exercised proof lane is recent enough to matter.

### What changed now
- Top10 reserve criticality now uses a bounded recent-service window
- Current Focus reserve criticality now uses a bounded recent-service window
- forced downstream / manual / active batch / deep-trigger cases remain verification-critical as before

### Why this is the correct bounded move
This preserves one-truth freshness for the lanes the operator actually exercised while avoiding a permanently elevated reserve posture after the proof lane is no longer current.

### Top10 archive design-hardening added now
RUN 2 also records the lawful owner-path design target for a 10-minute GlobalTop10 archive family:
- archive root under the existing GlobalTop10 child family
- 10-minute cadence-slot naming
- diagnostic visibility before any live activation

### RUN 3 proof burden sharpened
RUN 3 must prove that manifest freshness catches up when Top10 / Current Focus lanes are actively exercised, and that archive cadence can be proven without creating a second truth owner.

## RUN 1 convergence addendum — verification freshness under startup pressure

### What the latest runtime pack proved
The fresh runtime pack did **not** support treating Doc 12 as a pure summary/family-sync lane anymore.
The selected-symbol three-line Layer 6 summary is present live, but verification freshness still lagged while runtime pressure remained high:

- large dossier missing count
- large remaining backlog
- deferred write artifact load
- `dossier_cursor_stall` signal
- startup flood still active

The shipped `Artifact Bundle Manifest.txt` therefore remained older than later board/dossier/child-family truth.
That is a real verification-surface contradiction, not harmless background noise.

### What RUN 1 patched
- patched `mt5/runtime/ASC_Dispatcher.mqh`
- tightened `ASC_DossierManifestReserveNeeded(...)` so startup flood / backlog pressure no longer suppresses manifest reservation when verification-critical downstream proof is already active
- verification-critical cases now include active or recently-served top-10/current-focus proof paths and forced downstream refresh conditions

### Why this is bounded and lawful
- it does **not** create a second truth owner
- it does **not** redesign Layer 6 summaries
- it does **not** rewrite Market Board ownership
- it only stops verification truth from being starved by blanket reserve suppression during startup pressure

### What remains open
Doc 12 is still not honestly closed.

### What RUN 2 must harden
- whether this reserve behavior is the right balance between write pressure and verification truth
- whether the verification-critical triggers are method-complete
- whether any manifest / child-family / current-focus freshness wording should be clarified for operator truth without overclaiming closure

### What RUN 3 must prove
- after a fresh run, manifest freshness must catch up in the exercised top-10/current-focus lane
- stale verification posture should no longer persist after verification-critical downstream updates
- Layer 6 support usefulness and one-truth family law must remain intact

# Layer 6 — Support Compression, Contradiction, Change Tracking, and Prioritization

## RUN 3 compile-gate reality

RUN 3 did **not** honestly become a live-closeout pass.
The supplied compiler output proved a narrow source break inside `ASC_DossierComposer.mqh`, so the admitted move was a bounded compile repair only.

### Exact compile seam proven

- unresolved `ASC_L6_ALLOWED_STYLE_REVIEW_ONLY`
- missing `ASC_L6ReviewDeltaStateTransitionNote(...)`
- missing `ASC_L6ReviewDeltaDeepTransitionNote(...)`

### What RUN 3 changed

- replaced the unresolved constant-style check with bounded review/watch posture detection from already-carried Layer 6 text fields
- added the missing review-delta state-transition helper
- added the missing review-delta deep-transition helper
- left family-sync owner paths, dispatcher ownership, and Market Board authority unchanged

### What RUN 3 did not prove

- no fresh compile-clean pass was captured in this environment
- no fresh live artifact/log pack was present in the provided zip
- therefore Doc 12 remains open until compile is rechecked clean and the bounded live proof is run

## Purpose

This doc governs Layer 6 runtime support logic.
Doc 12 remains the active main-roadmap source lane.

## What Layer 6 is trying to do

Layer 6 should compress selected-symbol support into faster operator readouts that surface:

- what matters most now
- what changed materially
- what remains contested
- what contradiction deserves top placement
- what should be reviewed next

## Corrected strategy truth

- Layer 6 is **support / prioritization logic**.
- Layer 6 is **not edge-bearing by itself**.
- Better summaries or cleaner change traces do not prove better edge.
- Layer 6 may improve overload reduction and operator usefulness, but it must not create a second truth owner.

## What changed in understanding

Earlier Doc 12 wording was too narrow.
It correctly covered change tracking and contradiction compression, but the newest live evidence proved a direct operator-surface burden that now belongs here too:

- the committed shortlist/HUD Top 10 truth advanced to a newer family
- `Dossiers/GlobalTop10` still reflected an older completed child family
- the old child family could therefore sit there looking current unless the runtime explicitly detected and refreshed it

That is not “just office sync”.
That is a Layer-6-adjacent one-truth usefulness problem because support families must not look current when they are older than the active shortlist family they are supposed to represent.

## Original Doc 12 source sequence

### C1 — change tracking

The entry pass correctly tightened Layer 6 change-trace carry so selected-symbol support could say what changed without stealing authority from Layer 4 or Layer 5.

### C2 — contradiction compression

The continuation pass correctly tightened contradiction compression so Layer 6 could say which tension mattered most without pretending to resolve it as a board-level command.

## What remained missing after C1/C2

Three material seams still remained:

1. **Support-priority honesty**
   - Layer 6 still needed a tighter “what matters most now” line.
   - Contradiction and change were present, but the operator still lacked a compact first-priority readout.

2. **Family-sync honesty**
   - GlobalTop10 child-family freshness was not enforced against the current committed shortlist family after a later shortlist change.
   - That allowed stale child artifacts to survive as if current truth.

3. **Change/contest co-ordering honesty**
   - Selected-symbol Layer 6 already knew how to describe latest meaningful change and strongest active contradiction.
   - Those two truths were split across different bands, which weakened first-read usefulness at the exact moment a human needs to know both what changed and what still remains contested.

## Active seam now explicit

The active bounded Doc 12 source seam is now:

- **support-priority tightening plus family-sync honesty plus change/contest co-ordering**

This seam must improve ordering and one-truth usefulness without:

- creating a second truth path
- stealing authority from the Market Board
- downgrading same-symbol support continuity
- inventing any runtime layer after Layer 6
- broadening into a HUD redesign or a product-role rewrite

## RUN 1 source continuation pass landed

### Layer 6 core seam chosen

**Support Priority Now** inside the true Layer 6 owner.

### Why it won

- It stays inside `ASC_DossierComposer.mqh`, the real Layer 6 owner.
- It directly advances the original Doc 12 purpose: compress what matters most now.
- It improves operator usefulness without pretending to issue trade authority.

### What changed

- added a bounded `Support Priority Now` line in the Layer 6 current-focus summary owner
- the line now prioritizes geometry failure, degraded geometry, the active blocker, review-only posture, or the strongest contradiction before falling back to the next revisit trigger
- the line explicitly preserves board authority and keeps Layer 6 in consumer-only posture

## RUN 1 previous-work deepening seam landed

### Exact contradiction proven

The latest runtime evidence proved a real family-sync contradiction:

- the publication shortlist / committed Layer 4 family changed at a newer runtime pass
- the Market Board reflected the newer family
- `Dossiers/GlobalTop10` still contained an older completed child family

### Exact seam class

- **stale child family with consume-source mismatch**

### Exact owner path

- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_RuntimeState.mqh`

### What changed

- the runtime now records the current committed shortlist family source pass + signature
- the runtime now records the last completed GlobalTop10 child-family source pass + signature
- the dispatcher now compares those families when no child batch is active
- when they diverge, it marks the child family stale, deletes dropped stale children, and queues a lawful refresh of the current family
- the child family therefore no longer gets to sit silently as if it were still current truth

## RUN 1 verification / logging seam landed

### What changed

- explicit GlobalTop10 shortlist source UTC and signature are now written to runtime state and manifest output
- explicit GlobalTop10 child-family source UTC and signature are now written to runtime state and manifest output
- explicit child-family alignment status and reason are now written to runtime state and manifest output
- batch trace now carries alignment status, not just queue progress

### Why this matters

The next live pack can now answer the real question directly:

- is the child family aligned to the active committed shortlist family, or not?

That makes future proof more honest and stops the mismatch from hiding behind generic “completed 10/10” language.

## RUN 2 internet reality audit result

### What research supports

- Decision-support outputs work better when they prioritize **actionable, workflow-fit information** instead of flooding the user with equally weighted items.
- Cache-aside and distributed-consistency guidance supports explicit freshness handling, source identity, and scheduled refresh behavior when serving cached or derived views.
- Observability guidance supports **uniform correlation attributes** across signals so mismatches can be traced back to a shared identity.
- Provenance guidance supports carrying verifiable information describing **where, when, and how** an artifact was produced.
- Uncertainty communication research supports explicitly saying uncertainty up front; doing so does not inherently destroy trust, and can preserve trust better when evidence later changes.

### What research warns against

- alert-fatigue / decision-support clutter that overwhelms the operator with low-yield or poorly timed information
- stale derived views that look current because freshness identity is hidden
- eventual-consistency surfaces that do not tell the consumer which snapshot they are actually reading
- vague uncertainty language that admits ambiguity but does not explain what changed or what still remains contested

### What current Doc 12 logic already matched before this pass

- support compression was already bounded and consumer-only
- contradiction compression already existed
- change tracing already existed
- GlobalTop10 family-source / child-family verification already existed from RUN 1
- Market Board authority remained protected

### What current Doc 12 logic still lacked before this pass

- the selected-symbol **first-read** summary still did not carry latest meaningful change and live contest together
- that forced the operator to mentally merge the change-trace band with the contradiction band
- the system therefore had the ingredients for better Layer 6 honesty, but not the best bounded ordering yet

## RUN 2 seam chosen

### Seam type

**B. contradiction / change co-ordering tightening**

### Exact seam

Tighten the Layer 6 current-focus summary so the operator can see, in the same first-read block:

- what matters most now
- what changed most recently
- what still remains contested

### Why this seam won

- it is directly research-backed by decision-support and uncertainty-communication guidance
- it stays inside the true Layer 6 owner
- it does not reopen path ownership, board ownership, or HUD layout
- it strengthens the exact summary block that RUN 3 must prove live

### Compile-path owner path

- `mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `mt5/core/ASC_Version.mqh`

### What changed now

- review-snapshot delta is now built before the Layer 6 current-focus summary block is composed
- the current-focus summary now carries `Latest Meaningful Change`
- the current-focus summary now carries `Still Contested Now`
- those lines reuse existing owner-truth rather than inventing a new support-analysis path

## Family-sync follow-up judgment after RUN 2 research

### Does the Run 1 family-sync contradiction still reveal an under-specified source seam?

**No additional source patch was justified in RUN 2.**

### Why

- the current source path already records shortlist-source identity, child-family source identity, and alignment state
- the remaining burden is now runtime proof, not another speculative source expansion
- further family-sync edits in this pass would have risked sprawl without new externally supported leverage

## What remains open

Doc 12 is still not live-closed.
The next pass must prove all of the following in runtime evidence:

- the new `Support Priority Now` line appears on the selected-symbol Layer 6 surface
- the new `Latest Meaningful Change` line appears in that same first-read summary block
- the new `Still Contested Now` line appears in that same first-read summary block
- a shortlist-family change now queues and refreshes the GlobalTop10 child family
- dropped stale child artifacts no longer survive as if current truth
- the manifest exposes family alignment truth directly
- Market Board authority remains intact
- dossier/current-focus remain support-only

## Honest current posture

- Doc 12 is stronger than before, but still not complete.
- The one-truth family-sync seam remains source-patched and must now be runtime-proven.
- The RUN 2 Layer 6 summary ordering seam is now source-patched and must now be runtime-proven.
- Docs 09 and 10 remain parked, not closed.
- Docs 13–15 and 18 remain untouched at 0% and must not be inflated.


## RUN 4 live-pack reality audit result

### What fresh live evidence proved
- `Dossier.txt` carries the selected-symbol Layer 6 three-line summary live: `Support Priority Now`, `Latest Meaningful Change`, and `Still Contested Now`.
- runtime logs show the GlobalTop10 child-family path is not merely theoretical; the batch can run, drain, and reach `alignment=aligned` under live pressure.
- the selected-symbol dossier/current-focus path can also land later than the frozen manifest snapshot.

### What fresh live evidence contradicted
- the supplied `Artifact Bundle Manifest.txt` remained frozen at `2026.04.23 17:53:24 UTC` while later child-family / Market Board / selected-symbol artifacts and logs continued landing after `18:08 UTC`.
- this means the manifest, as shipped in this pack, can under-report already-landed proof and leave the operator staring at an older unproven state.

### Exact seam chosen in RUN 4
- **Seam type:** bounded verification / publication-sync seam
- **Compile-path owner:** `mt5/runtime/ASC_Dispatcher.mqh`
- **Exact seam:** GlobalTop10 child-family batch completion updated runtime alignment truth but did not force a manifest republish immediately afterward.

### What changed now
- the GlobalTop10 batch-completion branch now sets `l1_publish_pending_manifest = true` and `write_dirty = true` before returning.
- this keeps the repair inside the dispatcher publish/verification owner and avoids reopening Market Board or dossier ownership.

### Honest current posture after RUN 4
- Layer 6 summary carry: live-proven
- family-sync owner path: materially strengthened by live logs
- manifest freshness: source-patched, but not yet re-proven live
- Doc 12 closeout: still blocked pending real compile re-check plus fresh post-patch live evidence

## 2026-04-25 — Top10 family-sync cadence/archive RUN 1 source repair

The latest runtime packs showed a bounded family-sync contradiction: GlobalTop10 child membership could align, but archive publication and cadence law were not proven as a real 10-minute snapshot system. The previous archive path had helper names, but source proof was insufficient for a real archive family contract.

RUN 1 source repair now records the intended support-channel truth more strictly:
- current live `Dossiers/GlobalTop10` is the last confirmed complete family.
- new cycles build in staging rather than live.
- cadence admission is 600 seconds.
- manual HUD actions cannot unlawfully bypass cadence.
- stage verification happens before archive/promotion.
- archive success requires actual prior live child copies and expected-count alignment.
- promotion logs success/failure and leaves prior live family active on failure.

Doc 12 is still not closed. This is source repair only. RUN 2 must harden the method with research and RUN 3 must live-prove cadence, archive files, staging verification, promotion, and failure preservation.

## 2026-04-25 — Top10 family-sync RUN 3 hold note

The GlobalTop10 family-sync seam remains **not live-closed**. Source inspection still shows preserve/stage/archive/promote and manifest wiring, but the uploaded RUN 3 package did not include the fresh manifest/log/archive/HUD evidence needed to prove family synchronization in runtime. No Layer 6 support logic or dossier/current-focus ownership path was reopened in this hold.
