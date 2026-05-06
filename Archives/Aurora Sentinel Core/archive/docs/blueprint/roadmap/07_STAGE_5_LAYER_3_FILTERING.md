# ASC Stage 5 — Layer 3 Filtering

## Purpose

This document defines Stage 5 of the Aurora Sentinel Scanner (ASC) rebuild roadmap.

Stage 5 is the Layer 3 candidate-filtering stage.
Its job is to convert broad market-state truth plus current packet truth into an honest, cheap, explainable survivor set.

If Stage 3 answers what the universe is doing and Stage 4 answers what the active packet truth looks like, Stage 5 answers the next lawful question:

> which admitted symbols remain eligible for further consideration under cheap gating doctrine?

This stage exists because ASC needs a real gate layer before it can lawfully select a shortlist.
Without it, selection logic either becomes arbitrary or quietly pulls filtering into the wrong domains.

---

## Stage objective

Stage 5 establishes lawful Layer 3 runtime behavior inside the governed runtime spine.

It defines and/or implements:
- executable candidate-filter state
- cheap gate evaluation based on committed Layer 1 + Layer 2 truth
- eligible / ineligible / pending / blocked / degraded posture
- structured reason-code posture
- main-bucket assignment for survivors where architecture assigns it
- Layer 3 freshness posture
- Layer 3 committed artifact publication
- dirty-routing outputs from Layer 3 into later shortlist eligibility without granting shortlist execution yet

The goal is not to rank symbols.
The goal is to make candidate eligibility real, inspectable, and cheap.

---

## Why Stage 5 matters

Without Stage 5, later stages are forced into one of two bad shapes:
- shortlist logic starts deciding directly from raw packet truth, which collapses the gate/selection boundary
- packet/HUD/deep code begins acting like a hidden filter because no explicit eligibility owner exists

Stage 5 matters because it creates the formal survivor layer.

If Stage 5 is weak:
- Layer 4 cannot distinguish filtering from selection
- later operator surfaces lose explainability
- cheap gate reasons become implicit instead of explicit
- runtime cost rises because candidate reduction is no longer cleanly owned
- shortlist churn pressure rises because upstream filtering truth is unstable

---

## Stage 5 dependency position

Stage 5 depends on:
- Stage 0 repo reset being complete
- Stage 1 shared types/state/contracts being complete enough for filtering reason, bucket, and freshness posture
- Stage 2 dispatcher/governor spine being real enough to lawfully admit Layer 3 work
- Stage 3 Layer 1 market-state truth being trustworthy
- Stage 4 Layer 2 packet truth being trustworthy enough to support cheap filtering
- final blueprint files for Layer 3, runtime law, artifact doctrine, and invalid designs already being authoritative

Stage 5 is the prerequisite for:
- Stage 6 Layer 4 shortlist selection
- explainable candidate/survivor posture in later HUD and summaries
- stable shortlist input structure

---

## Stage 5 scope

Stage 5 includes:
- implementing executable Layer 3 filter state for admitted symbols
- implementing cheap gate logic using committed Layer 1 + Layer 2 truth
- implementing explicit reason-code posture
- implementing eligible / ineligible / pending / blocked / degraded / stale posture
- implementing main-bucket assignment for survivors where architecture assigns it
- implementing Layer 3 freshness posture
- implementing lawful Layer 3 committed artifact publication
- implementing dirty-routing outputs toward later shortlist eligibility

Stage 5 does **not** include:
- shortlist membership selection
- rank ordering inside buckets beyond what cheap bucket assignment lawfully requires
- deep-analysis logic
- rich dossier/report generation
- broad persistence-family richness beyond what Layer 3 publication requires

---

## Stage 5 deliverables

Stage 5 should deliver the following outcomes.

### 1. Layer 3 filter state becomes real
The active MT5 surface must now have real Layer 3 runtime records/state capable of tracking:
- candidate gate posture
- gate freshness
- last evaluated time
- reason-code posture
- pending/blocked/degraded state
- main-bucket assignment for survivors where assigned

### 2. Cheap gate service exists
The runtime must be able to lawfully evaluate candidate eligibility using already committed upstream truth rather than pulling new expensive inputs.

### 3. Eligibility posture becomes executable
Layer 3 must be able to classify symbols into states such as:
- Eligible
- Ineligible
- Pending
- Blocked
- Degraded
- Stale

These states must be inspectable and structurally usable by later stages.

### 4. Reason codes become real
The scanner must be able to explain why a symbol is passing, failing, waiting, or degraded at the filter layer.

### 5. Layer 3 committed artifact block lands
Layer 3 filtering truth must become lawfully committable so later shortlist and consumer stages do not depend on provisional filter logic.

---

## Core implementation targets

Stage 5 will primarily engage:
- `mt5/include/asc/layers/ASC_Layer3_CandidateFiltering.mqh`
- `mt5/include/asc/layers/ASC_Layers_PublicationBridge.mqh`
- `mt5/include/asc/core/ASC_Core_RuntimeState.mqh`
- `mt5/include/asc/runtime/ASC_Runtime_DirtyRouting.mqh`
- `mt5/include/asc/control/ASC_Control_Governor.mqh`
- supporting artifact/persistence scaffolding only as much as lawful Layer 3 landing requires

Layer 3 ownership must stay visible and bounded.

---

## Admission doctrine in Stage 5

### Layer 3 depends on committed upstream truth
Stage 5 must make it real that Layer 3 is not a discovery surface.
It is admitted based on already committed Layer 1 + Layer 2 truth.

### Default admitted candidate field
The default Layer 3 candidate field should be symbols for which:
- Layer 1 has established actionable market-state posture
- Layer 2 has produced sufficient packet truth, or a truthful inability state exists that still matters to filtering posture

### Pending and blocked are real outcomes
Stage 5 must preserve the rule that not every symbol needs immediate forced eligibility classification.
If upstream truth is not ready enough, Pending or Blocked posture is lawful and preferable to fake precision.

---

## Cheap-gate doctrine in Stage 5

### Layer 3 must stay cheap
Stage 5 must make it structurally real that Layer 3 is a cheap filter layer, not a hidden shortlist engine and not a deep-analysis surface.

### Valid Layer 3 ingredients
The stage may use cheap ingredients such as:
- Layer 1 market-state posture
- Layer 2 packet sanity and freshness posture
- bounded spread/tradability sanity where assigned
- simple bucket classification rules where assigned
- other explicitly cheap present-state checks

### Invalid Layer 3 ingredients
Stage 5 must avoid rules that require:
- deep history pulls
- expensive multi-timeframe reconstruction
- broad statistical ranking
- downstream shortlist semantics
- rich narrative interpretation embedded in runtime logic

If Layer 3 needs heavy evidence to function, the stage is drifting.

---

## Eligibility doctrine in Stage 5

### Eligible
The symbol passes Layer 3 cheap gating and may later become a legitimate candidate for shortlist consideration.
This is not the same thing as being selected.

### Ineligible
The symbol fails one or more Layer 3 cheap gate conditions under current committed truth.
This must be explainable.

### Pending
The symbol is in scope for filtering, but evaluation has not yet completed or a lawful bounded wait remains.

### Blocked
The symbol cannot be honestly evaluated because a required dependency or control condition is absent.

### Degraded
Layer 3 can expose only weakened eligibility posture because the upstream truth or filter freshness posture is degraded.

### Stale
The last filter result remains visible, but it is no longer fresh enough to be treated as current without qualification.

These states must not be collapsed into simple pass/fail shortcuts.

---

## Reason-code doctrine in Stage 5

### Reason codes must become executable now
Stage 5 must create real structured reason codes or equivalent bounded result reasons.
The purpose is not verbosity.
The purpose is structural explainability.

### Reason codes should explain gate outcome, not tell stories
Examples may include:
- passed
- failed market-state requirement
- failed packet freshness requirement
- failed packet sanity requirement
- blocked by missing packet
- degraded by stale upstream truth
- pending evaluation

### Reason codes should remain bounded
They must be detailed enough to support later debugging and operator trust, but not so sprawling that Layer 3 becomes a narrative engine.

---

## Bucket-assignment doctrine in Stage 5

### Bucket assignment may begin here
Where architecture assigns bucket classification to Layer 3, Stage 5 should make that executable.

### Bucketing is not ranking
The stage must preserve the rule that bucket assignment is allowed as cheap classification, but bucket assignment is not shortlist ranking and not promotion authority.

### Bucketing must remain cheap
If bucket assignment begins to behave like heavy scoring or quasi-selection, Stage 5 failed.

---

## Freshness doctrine in Stage 5

### Filter freshness must become real now
Stage 5 must create actual Layer 3 freshness posture rather than leaving filter age implicit.
The runtime should be able to answer:
- when the gate result was last evaluated
- whether the upstream truth used was fresh enough for that result
- whether the filter result is stale, degraded, or still current enough for later consumption

### Freshness does not require constant rerun
Stage 5 should preserve the doctrine that Layer 3 is event-sensitive and dirty-driven, not pulse-hungry.
Rerun because of material upstream change or bounded refresh policy, not because “the timer fired.”

---

## Scheduling doctrine in Stage 5

### Dirty-routing plus bounded sweep
Layer 3 should now be structurally positioned as a dirty-driven layer with bounded sweep/repair capability rather than a full-scope every-beat filter surface.

### Reevaluate what earned reevaluation
If a local packet change affected a local candidate subset, Stage 5 should make it possible to keep reevaluation local.
Broad recompute must require a real reason.

### Bounded sweep is allowed, broad churn is not
Layer 3 may need bounded sweep behavior for:
- stale candidate cleanup
- restart/recovery repair later
- ensuring dirty-routing did not miss dead zones

But this must remain secondary to local dirty-driven reevaluation.

---

## Layer 3 artifact/publication doctrine in Stage 5

### Layer 3 must land committed filter truth
Stage 5 should produce the third real layer-owned artifact block of the rebuild.

### Minimum Layer 3 artifact content
At minimum, the Layer 3 structural block should support:
- eligibility posture
- reason code or equivalent bounded reason
- main-bucket assignment where assigned
- last evaluated time
- freshness/stale/degraded posture

### Publication must remain lawful
The stage does not need the full richness of later persistence-family support, but it does need lawful Layer 3 publication discipline so later shortlist work can consume filter truth structurally.

### Layer 3 must not publish because packet fields flicker
Packet movement alone should not cause noisy write churn.
Layer 3 publication should follow meaningful filter evaluation, not cosmetic upstream motion.

---

## Dirty-routing doctrine in Stage 5

### Layer 3 creates later shortlist eligibility
When Layer 3 commits materially changed filtering truth, it may make later shortlist work eligible.
Typical future effects include:
- Layer 4 becoming eligible to assess selected-set integrity or material shift
- bucket-level structural views needing refresh later
- survivor counts changing for later consumers

### Stage 5 must not auto-run Layer 4
Stage 5 must be especially careful not to smuggle shortlist behavior into filter success paths.
The rule remains:
Layer 3 completion creates eligibility, not pile-on execution.

---

## Interaction with Stage 2 governor

### Layer 3 lives under the governor
Stage 5 must not let filtering self-schedule because gate logic feels “small enough.”
All Layer 3 service must remain governor-admitted.

### Cheap does not mean unbounded
Layer 3 should be cheaper than later stages, but it is still a real work class with bounded credits and stop conditions.

### Event-sensitive does not mean invisible
The governor must still be able to see when Layer 3 is due, dirty, stale, or starved.
If filtering happens only through helper side effects, Stage 5 failed.

---

## Evidence of success in Stage 5

A healthy Stage 5 should allow the system to demonstrate things like:
- admitted candidates now have real eligibility posture
- Layer 3 can explain why a symbol is eligible or not
- bucket assignment exists without pretending to be shortlist ranking
- local packet changes can create local filter reevaluation eligibility
- committed Layer 3 truth can be consumed later without re-deriving filter logic elsewhere

These are better signs of success than simply showing a shorter symbol list.

---

## What Stage 5 must not do

### 1. No Layer 4 smuggling
Do not implement shortlist membership or implicit ranking inside filtering logic.

### 2. No deep evidence rescue
Do not pull heavy history or deep-analysis inputs into Layer 3 just because they make filtering look smarter.

### 3. No narrative creep
Do not let reason codes become rich prose or operator-facing explanation engines.

### 4. No broad recompute addiction
Do not let every upstream movement trigger universe-wide filter churn.

### 5. No packet-owner drift
Do not let Stage 5 rebuild packet truth instead of consuming it.

### 6. No write-flicker contamination
Do not let Layer 3 publish constantly because upstream current fields are moving frequently.

---

## Stage 5 implementation approach

The preferred progression inside Stage 5 is:

1. implement executable Layer 3 state records and transitions
2. implement cheap gate evaluation against committed Layer 1 + Layer 2 truth
3. implement eligibility posture states
4. implement structured reason-code posture
5. implement main-bucket assignment where assigned
6. implement Layer 3 freshness tracking
7. implement Layer 3 publication bridge and committed artifact block
8. verify dirty-routing outputs without Layer 4 self-admission

### Why this order matters
Filter state comes first.
Cheap gating makes it live.
Reason and bucket posture make it intelligible.
Freshness makes it trustworthy.
Publication makes it consumable.

---

## Stage 5 quality gates

Stage 5 is complete only when all of the following are true:

### Gate 1 — Layer 3 filter truth exists as runtime reality
The scanner can actually classify admitted candidates under lawful runtime service.

### Gate 2 — Cheap gate service is real
Layer 3 behaves as a cheap gating layer rather than a hidden ranking or deep-analysis surface.

### Gate 3 — Eligibility posture is explicit
Eligible/Ineligible/Pending/Blocked/Degraded/Stale posture is real and inspectable.

### Gate 4 — Reason posture is bounded and real
The system can explain Layer 3 results without narrative sprawl.

### Gate 5 — Bucket assignment stays cheap and separate from selection
Bucketing exists where assigned without collapsing into shortlist authority.

### Gate 6 — Layer 3 committed truth lands lawfully
Later stages can consume filter truth structurally rather than improvising it.

### Gate 7 — No later-layer drift exists
Layer 3 has not absorbed selection or deep-analysis semantics.

---

## Evidence required for Stage 5 completion

Stage 5 completion should be evidenced by:
- real executable Layer 3 state and gate logic
- structured reason-code posture
- bucket assignment where architecture assigns it
- explicit filter freshness posture
- lawful Layer 3 committed publication
- office tracking showing Stage 5 completion honestly
- later shortlist work being able to consume real filter truth instead of guessing survivor posture

A list of “interesting” symbols is not enough.
The evidence must show bounded owned Layer 3 filter truth.

---

## What Stage 5 makes newly admissible

Once Stage 5 is complete, the following become admissible:
- Stage 6 Layer 4 shortlist selection against real survivor truth
- structural candidate/survivor views later consuming committed Layer 3 truth
- explainable shortlist eligibility because the gate layer now exists

What does **not** become automatically admissible:
- deep-analysis logic before shortlist authority exists
- treating bucket assignment as if selection is already solved
- allowing filtering to grow heavy because shortlist work is still unfinished

---

## Common failure patterns Stage 5 must prevent

### Pattern 1 — Hidden ranking creep
Layer 3 starts scoring or ordering candidates as if selection already exists.

Result:
- Layer 4 boundary weakens
- filtering cost rises
- shortlist authority becomes ambiguous

### Pattern 2 — Heavy-input rescue
Filter logic pulls expensive extra data because the cheap gate feels too thin.

Result:
- Layer 3 loses its cheap identity
- later stages become redundant or distorted

### Pattern 3 — Broad filter churn
Small upstream movement causes too much candidate reevaluation too often.

Result:
- runtime pressure rises
- locality is lost
- publication noise increases

### Pattern 4 — Reason opacity
Symbols flip gate posture but the system cannot explain why.

Result:
- operator trust weakens
- later shortlist decisions become harder to trust

### Pattern 5 — Bucketing becomes selection
Bucket assignment quietly becomes a pre-shortlist ranking engine.

Result:
- filter and shortlist boundaries collapse
- later architecture becomes muddled

---

## Stage 5 invalid completions

Stage 5 is **not** complete if any of the following are true:
- Layer 3 filter truth is still mostly implicit or ad hoc
- eligibility posture is oversimplified into pass/fail only
- reason codes do not exist or are too vague to support trust
- bucket assignment behaves like ranking
- committed Layer 3 truth does not land lawfully
- filtering still rebuilds packet or market-state truth instead of consuming it
- later stages would still need to invent survivor posture themselves

---

## Relationship to later stages

Stage 5 does not deliver shortlist authority yet.
It delivers the survivor truth that shortlist authority depends on.

That means later stages should rely on Stage 5 for:
- real cheap eligibility posture
- structured reason codes
- bucket assignment where assigned
- freshness-aware committed Layer 3 truth

If later stages still have to invent who the survivors are or why they survived, Stage 5 was incomplete.

---

## Final standard

Stage 5 is correct when ASC can truthfully answer the next scanner question inside the governed runtime:

> which admitted symbols remain eligible for further consideration under cheap gating doctrine?

That means Stage 5 must leave ASC with:
- real Layer 3 executable filter truth
- cheap lawful gate service
- explicit eligibility posture
- bounded reason-code posture
- bucket assignment without selection drift
- lawful committed Layer 3 publication
- no shortlist or deep-analysis role creep

The standard is not that Layer 3 narrows the list.
The standard is that Layer 3 now owns trustworthy survivor truth strongly enough that the shortlist stage can begin without ambiguity.