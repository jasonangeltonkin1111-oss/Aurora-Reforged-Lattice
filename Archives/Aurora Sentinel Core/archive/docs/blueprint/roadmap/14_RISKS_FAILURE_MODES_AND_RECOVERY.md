# ASC Risks, Failure Modes, and Recovery

## Purpose

This document defines the canonical risk, failure-mode, and recovery framework for Aurora Sentinel Scanner (ASC).

Its job is to make explicit:
- what kinds of failure still matter even after the rebuild
- how those failures usually present
- how to detect them early
- which recoveries are lawful
- which “recoveries” are actually just disguised deception or drift

ASC is not protected merely by having a good design.
It is protected by recognizing how good designs still fail under pressure, interruption, ambiguity, and local convenience.

This file exists so risk handling becomes structural rather than improvised.

---

## Core doctrine

### Failure-mode visibility law
A failure mode that is not named clearly tends to be rediscovered too late and repaired too locally.

ASC must therefore explicitly track not only bugs, but also architectural failure modes such as:
- ownership collapse
- cadence drift
- artifact trust erosion
- UI authority creep
- restore optimism
- scope widening under pressure

### Recovery-is-not-permission law
Recovery exists to restore lawful truth posture.
It does not grant permission to:
- invent missing truth
- hide stale/degraded state
- widen scope without authority
- preserve invalid structure because the system looks calmer that way

### Honest weakness beats fake normality
If the system is weak, stale, degraded, blocked, or continuity-backed, ASC must prefer showing that honestly rather than impersonating normality.

### Risk must be tied to architecture
Risks should not be listed as vague anxieties.
Each meaningful risk should be tied back to:
- the law it threatens
- the symptom it creates
- the domains it affects
- the recovery posture that is valid

---

## Risk categories

ASC should recognize at least the following major risk families:

1. Runtime control risks
2. Layer-truth risks
3. Persistence/artifact risks
4. HUD/operator risks
5. Recovery/restore risks
6. Scale/pressure risks
7. Process/governance risks

These categories help keep detection and response specific.

---

## Category 1 — Runtime control risks

### Risk: blended heartbeat regression
#### Description
The runtime begins mixing too many unlike classes into the same beat again.

#### Typical symptoms
- timer obesity
- noisy partial progress everywhere
- weak lane identity
- “busy” runtime with poor actual structural advancement

#### Why it matters
This is one of the fastest ways for ASC to decay back into the old pattern.

#### Detection signals
- unclear dominant-lane telemetry
- repeated broad mixed work in one beat
- credits that no longer meaningfully limit scope
- rising hidden starvation despite visible activity

#### Lawful response
- restore one-major-lane-per-heartbeat discipline
- tighten admission/yield rules
- reduce opportunistic companion work

#### Invalid response
- just increase timer frequency
- just shrink every budget globally
- let the UI or layers self-schedule to “compensate”

---

### Risk: starvation hidden behind calmness
#### Description
Protected work is repeatedly deferred while the system appears visually calm or lightly active.

#### Typical symptoms
- artifacts age too long before landing
- Layer 1 readiness stalls during warmup
- promoted deep freshness falls behind while screen activity continues

#### Why it matters
This creates false confidence while trust boundaries decay.

#### Detection signals
- class-specific deferred counts rising
- landing age crossing thresholds
- stale posture rising in protected domains
- wide gaps between runtime truth and landed truth

#### Lawful response
- use starvation detection and forced-service posture
- let cosmetic or optional work yield first
- preserve honest stale/degraded signaling

#### Invalid response
- hiding the issue with smoother HUD movement
- widening into broader mixed beats to “catch up”

---

### Risk: mode theater
#### Description
Runtime modes exist in name but do not materially change control posture.

#### Typical symptoms
- Warmup behaves like Normal
- Congestion does not actually narrow optional work
- Focus behaves like hidden scheduler authority

#### Detection signals
- mode changes with no observable admission differences
- no meaningful shift in credits, lane priority, or yielding

#### Lawful response
- reconnect mode transitions to real control consequences
- validate each mode against its intended purpose

#### Invalid response
- adding more mode labels without improving behavior

---

## Category 2 — Layer-truth risks

### Risk: Layer 1 starvation or richness creep
#### Description
Layer 1 either becomes too weak to establish broad truth, or too rich to remain cheap.

#### Typical symptoms
- Unknown stays high too long
- warmup exits on thin foundations
- Layer 1 starts carrying packet/filter logic

#### Detection signals
- weak broad coverage progression
- Layer 1 files/functions touching later-layer semantics
- readiness metrics tied to later outputs

#### Lawful response
- restore broad cheap scan posture
- remove later-layer semantics from Layer 1
- keep readiness grounded in Layer 1 truth only

#### Invalid response
- excuse weak Layer 1 with calmer pacing rhetoric

---

### Risk: Layer 2 widening or tactical takeover
#### Description
Layer 2 expands beyond its admitted subset or focus overlays begin controlling packet cadence too broadly.

#### Typical symptoms
- packet service feels universe-wide
- selected-symbol behavior drags broad packet work
- packet freshness becomes expensive rather than bounded

#### Detection signals
- too many symbols serviced at tactical cadence
- focus changing broad packet work volumes
- packet fields appearing in layers that should only consume them

#### Lawful response
- restore subset-first packet service
- isolate tactical overlay from structural packet cadence
- reassert Layer 2 ownership boundaries

#### Invalid response
- making tactical packet writes structural just because they are visible

---

### Risk: Layer 3 hidden ranking
#### Description
Filtering begins behaving like selection or expensive scoring.

#### Typical symptoms
- reason codes become story-like
- bucket assignment starts implying rank/selection
- filtering cost rises sharply

#### Detection signals
- filter logic needs deep inputs
- shortlist-like semantics appear before Layer 4
- local broad recompute becomes common

#### Lawful response
- prune Layer 3 back to cheap explainable gating
- push true selection back to Layer 4

#### Invalid response
- accept heavier filtering because it “improves quality” without preserving architecture

---

### Risk: shortlist churn or hold abuse
#### Description
Layer 4 either changes too often or hides behind hold too aggressively.

#### Typical symptoms
- selected set reshapes on minor movement
- hold expiry triggers rebuilds by itself
- invalid shortlist remains visible too long

#### Detection signals
- frequent shortlist publication with weak material change
- no meaningful Dirty-Held / Invalid distinction
- time-driven rebuilds with little real challenge

#### Lawful response
- restore material-shift thresholds
- preserve hold as continuity aid, not invalidity shield
- enforce “hold expiry alone is not a trigger”

#### Invalid response
- increasing hold windows indefinitely to suppress churn cosmetically

---

### Risk: Layer 5 universe creep or authority leak
#### Description
Deep service widens beyond promoted scope or begins influencing who should be promoted.

#### Typical symptoms
- non-promoted symbols receive active deep service
- focus drives deep entitlement
- deep outputs start implicitly shaping selection

#### Detection signals
- Layer 5 service traces include non-promoted symbols
- deep logic shows up in selection paths
- UI focus changes deep scope

#### Lawful response
- reassert promoted-set-only scope
- preserve selection authority in Layer 4 only
- keep deep service bounded and rank-sensitive inside scope only

#### Invalid response
- using deeper data as justification for quiet selection drift

---

## Category 3 — Persistence and artifact risks

### Risk: persistence as residue
#### Description
Truth is computed but published inconsistently or opportunistically.

#### Typical symptoms
- memory truth looks stronger than landed truth
- structural consumers rely on ad hoc reads
- artifact age rises without strong reasons

#### Detection signals
- repeated pending publication posture
- wide gaps between runtime state and committed artifacts
- pressure causing writes to be skipped casually

#### Lawful response
- restore persistence as a governed work class
- protect key landings with override posture where appropriate
- enforce publish thresholds and atomic landing

#### Invalid response
- pushing even more consumer surfaces onto in-memory truth

---

### Risk: family confusion
#### Description
Artifact families blur together, making trust posture ambiguous.

#### Typical symptoms
- operator surfaces cannot tell structural truth from telemetry or continuity support
- restore logic treats unlike files similarly
- family names exist but do not affect behavior

#### Detection signals
- artifacts missing family/owner clarity
- consumers flattening source classes
- restore paths ignoring family distinctions

#### Lawful response
- restore explicit family-aware publication and consumption
- keep metadata actionable rather than decorative

#### Invalid response
- solving the confusion with more filenames but unchanged behavior

---

### Risk: continuity fraud
#### Description
Last-good continuity is shown or consumed as though it were fresh landed truth.

#### Typical symptoms
- stale values appear normal after restart
- continuity-backed symbols look fully current
- consumers do not know when freshness was actually earned

#### Detection signals
- weak `uses_last_good` / continuity markers
- UI or logs presenting continuity-backed state without qualification
- restore flows skipping live revalidation where required

#### Lawful response
- keep continuity posture explicit in metadata and UI
- preserve stale/degraded markers alongside last-good support

#### Invalid response
- hiding continuity state to make the system feel smoother

---

### Risk: mixed-cycle ambiguity
#### Description
Artifacts are built from mismatched upstream states but appear coherent.

#### Typical symptoms
- summaries or views show combinations that do not belong to one clean committed generation
- recovery surfaces appear internally contradictory

#### Detection signals
- weak lineage/coherence metadata
- consumers ignoring coherence posture
- staging/promote flows not preserving generation clarity

#### Lawful response
- strengthen lineage/coherence fields and consumer trust rules
- surface mixed-cycle posture honestly when it exists

#### Invalid response
- flattening artifacts into one “latest” surface without proving coherence

---

## Category 4 — HUD and operator risks

### Risk: HUD as hidden scheduler
#### Description
Operator navigation begins shaping runtime work outside lawful governor admission.

#### Typical symptoms
- page changes alter broad runtime behavior
- focus creates unexpected packet/filter/deep activity
- performance depends heavily on what page is open

#### Detection signals
- view actions correlate with unexpected control changes
- HUD code paths trigger runtime work without explicit admission
- focus state lingers after leaving a page

#### Lawful response
- restore HUD as consumer only
- route bounded tactical overlays through explicit governor-aware paths
- keep focus narrow and reversible

#### Invalid response
- accepting page-dependent behavior because it “feels responsive”

---

### Risk: source ambiguity in the UI
#### Description
The operator cannot tell what kind of truth is being shown.

#### Typical symptoms
- structural and tactical values look identical
- stale or continuity-backed structural truth appears fully current
- runtime control posture is confused with symbol truth

#### Detection signals
- field source class not inspectable
- no visible distinction between structural and tactical surfaces
- stale/degraded markers absent where needed

#### Lawful response
- preserve source-aware HUD typing and signaling
- keep structural/tactical split explicit

#### Invalid response
- relying on user familiarity to interpret ambiguous fields

---

### Risk: transition deception
#### Description
Freeze/lock behavior improves visual calmness at the cost of truthfulness.

#### Typical symptoms
- stale state lingers visually too long
- updates are hidden during transitions beyond bounded intent

#### Detection signals
- long freeze intervals
- transition behavior masking real stale/degraded posture
- user cannot tell whether the page is waiting or merely calm

#### Lawful response
- keep transition behavior short, explicit, and truth-safe

#### Invalid response
- extending transition behavior to hide structural roughness

---

## Category 5 — Recovery and restore risks

### Risk: restore optimism
#### Description
The system treats restored state as more trustworthy than it has earned.

#### Typical symptoms
- quick restart looks “normal” before live revalidation
- continuity-backed artifacts appear current
- operator is not warned that the system is still re-earning truth

#### Detection signals
- restore trust posture too permissive
- missing revalidation markers
- no visible distinction between fresh restart and continuity-backed state

#### Lawful response
- preserve restore humility
- require live revalidation where architecture says it is needed
- keep continuity-backed state visibly distinct

#### Invalid response
- prioritizing the appearance of normality over truthful posture

---

### Risk: recovery becomes permanent runtime shape
#### Description
Recovery behaviors never really give way to normal clean runtime behavior.

#### Typical symptoms
- system stays in quasi-recovery posture too often
- repair logic becomes permanent glue for weak normal flow
- restart/recovery code starts compensating for normal runtime flaws

#### Detection signals
- frequent recovery-mode persistence in normal sessions
- repair code invoked as routine rather than exception
- growing dependency on continuity-backed state to look healthy

#### Lawful response
- fix the normal runtime law
- keep recovery bounded and explicit

#### Invalid response
- normalizing recovery complexity as just “how the system works now”

---

## Category 6 — Scale and pressure risks

### Risk: wide-universe collapse
#### Description
The architecture works only on small/easy brokers and collapses or distorts on larger universes.

#### Typical symptoms
- Layer 1 becomes timid
- Layer 2 widens too much or slows too far
- pressure causes layers to blur roles

#### Detection signals
- broad scan progression degrades sharply at larger symbol counts
- optional work crowds out protected work under realistic broker scale
- control posture becomes more cosmetic than structural under load

#### Lawful response
- reassert large cheap Layer 1 behavior
- keep Layer 2 subset-driven
- strengthen congestion/starvation policy under scale

#### Invalid response
- quietly shrinking the problem by processing too little and calling it performance

---

### Risk: tactical pressure contaminates structural cadence
#### Description
Fast-moving operator-visible surfaces begin dictating structural work or publication cadence.

#### Typical symptoms
- writes follow display speed
- structural pages redraw too broadly because tactical fields move
- selected-symbol interest alters broader service unfairly

#### Detection signals
- publication spikes while only tactical values changed
- structural redraws correlate with fast overlays rather than structural changes

#### Lawful response
- preserve tactical/structural split in both runtime and UI
- keep calm publication discipline

#### Invalid response
- letting the display become the main clock of the system

---

## Category 7 — Process and governance risks

### Risk: patch-loop relapse
#### Description
Implementation friction starts being solved through local architecture rewrites again.

#### Typical symptoms
- helpers absorb new responsibilities quietly
- roadmap stages are skipped because the system “mostly works”
- office evidence trails reality
- final blueprint stops being the real authority in practice

#### Detection signals
- commits solving architecture without blueprint/office updates
- increasing mismatch between docs and runtime
- repeated local exceptions becoming permanent behavior

#### Lawful response
- stop widening
- surface the discrepancy explicitly in blueprint/office
- repair the correct authority surface first

#### Invalid response
- normalizing the workaround because it reduced immediate pain

---

### Risk: acceptance theater
#### Description
The system is treated as finished because it looks smoother, richer, or more organized, not because hardening evidence exists.

#### Typical symptoms
- broad confidence language with weak concrete validation
- UI quality treated as proof of runtime truth
- known weaknesses underreported

#### Detection signals
- office status ahead of actual test matrix evidence
- vague acceptance claims with little cross-domain proof

#### Lawful response
- tie acceptance strictly to evidence
- distinguish conditional acceptance from real acceptance

#### Invalid response
- using confidence language to bridge evidence gaps

---

## Recovery principles

When a meaningful failure mode is detected, lawful recovery should generally follow these principles.

### 1. Isolate the failure class
Decide whether the issue is primarily:
- control
- layer truth
- artifact trust
- UI/source posture
- restore posture
- process/governance

### 2. Preserve truthfulness first
Before trying to look normal again, preserve honest signaling:
- stale
- degraded
- pending
- blocked
- continuity-backed
- requires revalidation

### 3. Restore lawful structure, not just output
The target of recovery is not simply getting output back.
The target is restoring lawful ownership, cadence, and trust posture.

### 4. Contain before widening
A local containment that preserves truth is usually better than a broad quick fix that erodes architecture.

### 5. Update the right authority surface
If the failure reveals blueprint weakness, update blueprint/office explicitly.
If it reveals implementation weakness, fix implementation without silently redefining the architecture.

---

## Recovery postures

ASC should generally recognize the following recovery postures.

### A. Containment posture
Used when a failure is active and the main need is to prevent it from infecting other domains.

Typical actions:
- reduce optional work
- isolate a failing family or layer
- preserve stale/degraded honesty

### B. Repair posture
Used when the failing domain can be corrected without broad architectural ambiguity.

Typical actions:
- rerun bounded publish/repair flow
- restore lawful state transitions
- re-establish explicit source posture

### C. Revalidation posture
Used when persisted or continuity-backed truth exists, but live trust must be re-earned.

Typical actions:
- mark restore trust explicitly
- trigger bounded live checks
- keep UI/operator surfaces humble until revalidation completes

### D. Escalation posture
Used when the failure suggests architecture drift, not just a local defect.

Typical actions:
- stop claiming stage completion or acceptance
- update office risk/posture honestly
- surface blueprint or roadmap correction if required

---

## Detection signals matrix

ASC should actively watch for signals such as:
- unknown posture not reducing during warmup
- packet freshness falling behind too often
- shortlist churn without strong materiality
- promoted deep scope widening unexpectedly
- artifact landing age growing too far
- continuity-backed truth appearing as if fresh
- page/focus changes correlating with hidden runtime work
- wide-universe behavior degrading into timid starvation or blended pulses
- office claims outrunning actual evidence

These signals should trigger investigation before they become normal.

---

## Blocking versus non-blocking risks

### Blocking risks
A risk is blocking when it materially threatens:
- ownership law
- source truthfulness
- artifact trust boundaries
- restore humility
- scale-valid runtime control
- honest acceptance posture

Blocking risks prevent stage completion or final acceptance.

### Non-blocking risks
A risk may be non-blocking only when it:
- is tightly bounded
- is visible and documented
- does not materially weaken architecture truth
- does not mislead the operator or downstream consumers

Non-blocking does not mean ignored.
It means not stage-stopping yet.

---

## Relationship to the test matrix

This file and `13_TEST_MATRIX.md` work together.

- the **test matrix** defines what must be validated and how evidence is judged
- this **risk/failure/recovery file** defines what the main dangers are, how they present, and what lawful responses look like

If a major recurring risk is not represented in the test matrix, the matrix is incomplete.
If the matrix reports a major failure but office/risk posture does not reflect it, governance is weak.

---

## Relationship to office tracking

`office/ROADMAP_STATUS.md`, `WORK_LOG.md`, and `CHANGE_LEDGER.md` should reflect meaningful active risks honestly.

That includes:
- which risks are currently active
- which remain blocking
- which have been reduced or resolved
- what recovery posture is in effect if the system is not yet in normal healthy behavior

If office hides meaningful active risks, the rebuild starts lying to itself again.

---

## Common meta-failure patterns

### Pattern 1 — risk naming without action
The file exists, the risk is named, but no detection or response posture changes.

Result:
- risk tracking becomes decorative

### Pattern 2 — recovery becomes style instead of law
The system always appears to be “recovering” without ever restoring normal lawful behavior.

Result:
- emergency posture becomes the new default

### Pattern 3 — drift normalization
Known small violations are repeatedly tolerated because they seem individually harmless.

Result:
- architecture decays by accumulation

### Pattern 4 — fear-driven overcorrection
A real risk triggers a broad panic response that widens scope or breaks other laws.

Result:
- local recovery causes systemic damage

### Pattern 5 — acceptance with unresolved blockers
The system is treated as accepted while active blocking risks remain materially unresolved.

Result:
- trust in acceptance collapses

---

## Final standard

ASC risk/failure/recovery posture is correct when the rebuild can say:

> we know how this system is still most likely to fail, we know how to recognize it early, and we know how to recover without lying.

That means this framework must leave ASC with:
- named risk families tied to architecture
- observable failure symptoms and detection signals
- lawful recovery postures
- a strict distinction between honest recovery and deceptive fake-normal behavior
- office/test-matrix alignment on active risk posture

The standard is not that risks are listed.
The standard is that risks are made hard to ignore, hard to mislabel, and hard to “recover” from dishonestly.