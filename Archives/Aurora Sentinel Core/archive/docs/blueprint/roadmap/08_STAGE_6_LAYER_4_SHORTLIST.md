# ASC Stage 6 — Layer 4 Shortlist

## Purpose

This document defines Stage 6 of the Aurora Sentinel Scanner (ASC) rebuild roadmap.

Stage 6 is the Layer 4 shortlist stage.
Its job is to turn Layer 3 survivor truth into a stable, bounded, explainable selected set.

If Stage 5 answers which symbols remain eligible, Stage 6 answers the next lawful question:

> which survivors deserve promotion into the current selected set?

This stage exists because ASC needs a real selection authority before it can lawfully begin promoted-only deep analysis, promoted-set operator surfaces, or promoted-set persistence priorities.
Without it, downstream privilege either becomes arbitrary or leaks backward into filtering and packet logic.

---

## Stage objective

Stage 6 establishes lawful Layer 4 runtime behavior inside the governed runtime spine.

It defines and/or implements:
- executable shortlist state
- selected-set membership authority
- top-per-bucket selection where architecture assigns it
- spill/fill posture where architecture assigns it
- hold-window posture
- invalid / material-shift / stable / dirty-held shortlist posture
- shortlist freshness posture
- lawful Layer 4 committed artifact publication
- dirty-routing outputs from Layer 4 into later promoted-set deep-analysis eligibility without granting that deep work yet

The goal is not to make the scanner busy.
The goal is to make the promoted set authoritative, stable, and inspectable.

---

## Why Stage 6 matters

Without Stage 6, the scanner has survivors but no legitimate promotion authority.
That creates two recurring bad shapes:
- filtering logic begins acting like selection
- deep analysis or UI logic begins choosing who matters most

Stage 6 matters because it creates the first runtime layer that changes downstream privilege.
That makes it logically heavier than earlier layers even when the raw computation is not large.

If Stage 6 is weak:
- the promoted set churns excessively
- Layer 5 scope becomes unstable
- operator trust in selection weakens
- hold behavior becomes vague or abusive
- bucket logic becomes interpretive rather than structural

---

## Stage 6 dependency position

Stage 6 depends on:
- Stage 0 repo reset being complete
- Stage 1 shared types/state/contracts being complete enough for shortlist, hold, material-shift, and selection posture
- Stage 2 dispatcher/governor spine being real enough to lawfully admit Layer 4 work
- Stage 3 Layer 1 truth being trustworthy
- Stage 4 Layer 2 packet truth being trustworthy
- Stage 5 Layer 3 survivor truth being real, explainable, and fresh enough to support lawful selection
- final blueprint files for Layer 4, governor law, artifact doctrine, HUD doctrine, and invalid designs already being authoritative

Stage 6 is the prerequisite for:
- Stage 7 Layer 5 deep promoted-set analysis
- trustworthy promoted-set operator surfaces later
- promoted-only persistence and composition priorities later

---

## Stage 6 scope

Stage 6 includes:
- implementing executable Layer 4 shortlist state and transitions
- implementing lawful selected-set membership authority
- implementing top-per-bucket selection where assigned
- implementing spill/fill posture where assigned
- implementing hold-window behavior
- implementing Stable / Dirty-Held / Invalid / Material-Shift / Pending / Degraded / Stale shortlist posture
- implementing shortlist freshness posture
- implementing lawful Layer 4 committed artifact publication
- implementing dirty-routing outputs toward later promoted deep-analysis eligibility

Stage 6 does **not** include:
- Layer 5 deep-analysis logic
- promoted deep packet generation
- rich dossier generation
- full promoted-set HUD pages beyond future admissibility
- hidden rescoring of the whole universe

---

## Stage 6 deliverables

Stage 6 should deliver the following outcomes.

### 1. Layer 4 shortlist state becomes real
The active MT5 surface must now have real Layer 4 runtime records/state capable of tracking:
- selected-set membership
- shortlist freshness posture
- shortlist state posture
- hold posture
- material-shift posture
- invalid/degraded/stale posture
- bucket position or selected position where assigned
- last evaluated time

### 2. Shortlist authority becomes executable
Layer 4 must become the clear owner of who is selected and who is not.
No other layer or consumer surface may be allowed to quietly own that choice.

### 3. Stable selected-set behavior exists
Stage 6 must also lock the trader-facing Market Board as a selection board rather than a casual shortlist dump.
Where Stage 6 publishes shortlist-facing board structure, each symbol must be representable as a three-line structured card:
- Line 1: rank / symbol / market status / session / main group / trade status
- Line 2: bid / ask / spread / spread percentage / tick age / friction
- Line 3: ATR / regime / VWAP / day change / correlation profile

The required support fields include session, spread percentage, friction, ATR, regime, VWAP, day change, correlation, and trade status.
The board must support symbol selection without forcing dossier-first navigation.

Stage 6 must also make board ranking behavior explicit.
Top symbols must come from lawful shortlist output.
Ranking must be deterministic and consistent and may use only:
- eligibility
- market condition
- execution quality
- selection context

Ranking must not use:
- random ordering
- unstable heuristics
- incomplete fields

Active trades, pending orders, and exclusion flags must be handled explicitly rather than through accidental ordering.
Top Overall must be derived from grouped shortlist output rather than from a separate all-symbol ranking pass.

The selected set should now behave as a controlled, bounded authority surface rather than as a constantly twitching reaction to every upstream change.

### 4. Hold/material-shift posture becomes real
Stage 6 must make hold and materiality structurally real rather than leaving them as conceptual ideas.

### 5. Layer 4 committed artifact block lands
Shortlist truth must become lawfully committable so later Layer 5 and structural consumers do not depend on provisional selection state.

---

## Core implementation targets

Stage 6 will primarily engage:
- `mt5/include/asc/layers/ASC_Layer4_ShortlistSelection.mqh`
- `mt5/include/asc/layers/ASC_Layers_PublicationBridge.mqh`
- `mt5/include/asc/core/ASC_Core_RuntimeState.mqh`
- `mt5/include/asc/runtime/ASC_Runtime_DirtyRouting.mqh`
- `mt5/include/asc/control/ASC_Control_Governor.mqh`
- supporting artifact/persistence scaffolding only as much as lawful Layer 4 landing requires

Layer 4 ownership must stay visible and bounded.

---

## Admission doctrine in Stage 6

### Layer 4 depends on Layer 3 survivor truth
Stage 6 must make it real that Layer 4 is not a discovery surface and not a first-pass eligibility surface.
It is admitted based on already committed Layer 3 survivor truth.

### Layer 4 should usually be calm
The shortlist should not be rebuilt constantly.
Selection is a real authority event, not a generic every-beat maintenance action.

### Missing or invalid shortlist is a real case
Stage 6 should preserve the idea that the shortlist may legitimately be:
- missing and pending creation
- invalid and needing repair
- stable and requiring no immediate change
- dirty-held under meaningful pressure

The system must not pretend selection is always trivially available.

---

## Selection-authority doctrine in Stage 6

### Layer 4 becomes the sole selected-set authority
The stage must make it executable that Layer 4 alone owns membership decisions for the selected/promoted set.

### Why this matters
If any other domain starts deciding membership implicitly, then:
- selection reasoning blurs
- Layer 5 scope becomes unstable
- operator trust declines

### Selection must stay bounded
Stage 6 should produce a bounded selected set rather than treating selection as “all survivors with nicer wording.”
The exact selection size or per-bucket rules may be architecture-defined, but boundedness must be real.

---

## Top-per-bucket doctrine in Stage 6

### Buckets can now become selection context
Where architecture assigns top-per-bucket selection to Layer 4, Stage 6 should make that executable.

### Top-per-bucket is not global swarm logic
The stage should favor bounded representative selection rather than turning the shortlist into an endlessly re-sorted global pool.

### Buckets are a structure, not an excuse for hidden scoring sprawl
If top-per-bucket selection requires Layer 4 to become a giant rank engine, Stage 6 drifted.

---

## Spill/fill doctrine in Stage 6

### Why spill/fill exists
If some buckets lack enough valid survivors, the selected set may need explicit spill/fill behavior so the shortlist remains structurally usable.

### Spill/fill must remain explicit
Stage 6 should define/implement spill/fill as a bounded selection rule, not as arbitrary ad hoc replacement.

### Spill/fill must not destroy stability
Spill/fill is a structural completion rule, not a reason for endless churn.

---

## Hold doctrine in Stage 6

### Hold must become real now
Stage 6 must make hold-window posture executable rather than leaving it as an idea.

### Why hold exists
Once a lawful shortlist is built, some continuity protection is useful so small upstream motion does not immediately churn the selected set.

### Hold protects continuity, not invalidity
Stage 6 must preserve the rule that hold may resist churn but may not defend a structurally invalid shortlist forever.

### Dirty-Held posture must become real
If meaningful upstream challenge appears during hold, the shortlist should be able to enter Dirty-Held posture:
- current shortlist stays visible
- the system knows pressure exists
- later review may become due if that pressure persists or grows

---

## Material-shift doctrine in Stage 6

### Materiality must become executable now
The stage must preserve that Layer 4 wakes for meaningful challenge, not for generic motion.

### Material shift should include cases such as
- a promoted member becomes ineligible
- a bucket loses valid representation
- strong challengers emerge across defined thresholds
- shortlist freshness/trust drops too far
- initial shortlist creation is required

### Material shift must be stronger than ordinary upstream motion
Stage 6 must not allow harmless Layer 3 churn to count as automatic shortlist rebuild entitlement.

---

## Hold-expiry doctrine in Stage 6

### Hold expiry alone must not trigger rebuild
This rule must become executable now, not deferred to later interpretation.

Hold expiry means only:
- one barrier to rebuild has been removed

It does **not** mean:
- the shortlist must now be recomputed automatically

If Stage 6 gets this wrong, constant shortlist churn returns immediately.

---

## Shortlist posture doctrine in Stage 6

Stage 6 should make the following shortlist states real and inspectable where relevant:
- Stable
- Dirty-Held
- Invalid
- Material-Shift
- Pending
- Degraded
- Stale

### Why this matters
Selection is not just a list.
It is a stateful authority surface.
The runtime and later consumers need to know not only who is selected, but also how trustworthy and current the shortlist is.

---

## Freshness doctrine in Stage 6

### Shortlist freshness must become real now
The runtime should be able to answer:
- when the shortlist was last meaningfully evaluated
- whether upstream survivor truth remains trustworthy enough
- whether the shortlist is stale, degraded, or still stable

### Freshness should not shadow Layer 3 cadence
Shortlist freshness should not be tied to every small filter update.
Selection authority needs calmer thresholds than gate freshness.

---

## Scheduling doctrine in Stage 6

### Layer 4 should be event-driven
Stage 6 should make Layer 4 structurally event-driven around:
- initial shortlist creation
- invalid shortlist repair
- material-shift review
- dirty-held persistence review
- bounded refresh/repair cases

### Layer 4 should not be pulse-hungry
The stage must resist the design where shortlist logic becomes a constant maintenance loop simply because survivor truth keeps moving.

### Calmness is a success signal
A healthy Layer 4 is often quiet.
Frequent shortlist motion is usually a sign of threshold weakness, upstream instability, or role drift.

---

## Layer 4 artifact/publication doctrine in Stage 6

### Layer 4 must land committed shortlist truth
Stage 6 should produce the fourth real layer-owned artifact block of the rebuild.

### Minimum Layer 4 artifact content
At minimum, the Layer 4 structural block should support:
- selected/not-selected posture
- selected-set membership truth
- position/bucket role where assigned
- hold posture
- shortlist state posture
- last evaluated time
- freshness/stale/degraded/invalid markers

### Publication must remain lawful
The stage does not need the full richness of later persistence-family support, but it does need lawful Layer 4 publication discipline so later Layer 5 work can consume shortlist truth structurally.

### Layer 4 must not republish cosmetic motion constantly
Publication should follow real selection events or meaningful shortlist state changes, not nervous micro-motion.

---

## Dirty-routing doctrine in Stage 6

### Layer 4 creates promoted-set deep eligibility
When Layer 4 commits materially changed shortlist truth, it may make later promoted-set deep-analysis work eligible.
Typical future effects include:
- Stage 7 Layer 5 becoming eligible to service promoted members
- selected-set structural views becoming refreshable later
- promoted composition priorities changing later

### Stage 6 must not auto-run Layer 5
Stage 6 must be especially careful not to smuggle deep-analysis work into shortlist success paths.
The rule remains:
Layer 4 completion creates eligibility, not pile-on execution.

---

## Interaction with Stage 2 governor

### Layer 4 lives under the governor
Stage 6 must not let shortlist selection self-schedule because the scanner “wants” a fresh promoted set.
Layer 4 remains a governed work class.

### Logical heaviness matters
Even if shortlist computation is not huge, it is logically heavy because it changes downstream privilege.
The governor must still treat it as a serious event.

### Layer 4 should usually be deferred unless needed
The stage should preserve the idea that many beats may pass without lawful shortlist work, and that this can be healthy.

---

## Evidence of success in Stage 6

A healthy Stage 6 should allow the system to demonstrate things like:
- the scanner now has a real selected set with bounded authority
- the system can explain why a symbol is selected or not selected
- hold and dirty-held posture behave meaningfully
- material shift is distinguishable from routine upstream movement
- the selected set stays stable when nothing important changed
- committed Layer 4 truth can be consumed later without inventing selection elsewhere

These are better signs of success than simply seeing a list of “top symbols.”

---

## What Stage 6 must not do

### 1. No Layer 5 smuggling
Do not implement deep-analysis behavior in the shortlist stage.

### 2. No ranking-universe drift
Do not let shortlist logic become an endlessly re-sorted all-symbol ranking engine.

### 3. No time-based rebuild entitlement
Do not let the passing of time alone create rebuild permission.

### 4. No hold abuse
Do not let hold defend an invalid shortlist indefinitely.

### 5. No filter-owner drift
Do not let shortlist logic start redefining what it means to be eligible instead of consuming Layer 3 survivor truth.

### 6. No publish-churn masquerading as freshness
Do not let small shortlist motion create noisy artifact churn.

---

## Stage 6 implementation approach

The preferred progression inside Stage 6 is:

1. implement executable Layer 4 shortlist state and transitions
2. implement selected-set membership authority
3. implement top-per-bucket selection and spill/fill where assigned
4. implement hold and dirty-held posture
5. implement material-shift and invalidity detection
6. implement shortlist freshness posture
7. implement Layer 4 publication bridge and committed artifact block
8. verify dirty-routing outputs without Layer 5 self-admission

### Why this order matters
Shortlist state comes first.
Selection authority makes it live.
Hold/materiality make it stable.
Freshness makes it trustworthy.
Publication makes it consumable.

---

## Stage 6 quality gates

Stage 6 is complete only when all of the following are true:

### Gate 1 — Layer 4 shortlist truth exists as runtime reality
The scanner can actually hold and maintain a lawful selected set.

### Gate 2 — Layer 4 is the sole selection authority
No other domain needs to guess or invent promoted membership.

### Gate 3 — Hold/materiality posture is real
Hold and material-shift are executable and inspectable rather than conceptual only.

### Gate 4 — Hold expiry alone does not trigger rebuild
This rule must be structurally enforced.

### Gate 5 — The shortlist is stable when nothing meaningful changed
The selected set is calm by default rather than twitchy by habit.

### Gate 6 — Layer 4 committed truth lands lawfully
Later Stage 7 work can consume selected-set truth structurally.

### Gate 7 — No later-layer drift exists
Layer 4 has not absorbed deep-analysis semantics.

---

## Evidence required for Stage 6 completion

Stage 6 completion should be evidenced by:
- real executable Layer 4 shortlist state and selection logic
- explicit hold/material-shift posture
- explicit invalid/stable/dirty-held shortlist posture
- lawful Layer 4 committed publication
- office tracking showing Stage 6 completion honestly
- later deep-analysis work being able to consume real promoted membership without inventing it

A visible “top list” is not enough.
The evidence must show bounded owned Layer 4 selection authority.

---

## What Stage 6 makes newly admissible

Once Stage 6 is complete, the following become admissible:
- Stage 7 Layer 5 deep promoted-set analysis against real promoted membership
- structural promoted-set views later consuming committed Layer 4 truth
- lawful promoted-only downstream priorities later in persistence and HUD work

What does **not** become automatically admissible:
- widening shortlist logic into deep or dossier behavior
- treating the selected set as if it never needs freshness or hold posture
- allowing UI/focus/deep outputs to redefine promoted membership

---

## Common failure patterns Stage 6 must prevent

### Pattern 1 — Constant shortlist churn
Small upstream movement causes the selected set to reshape too often.

Result:
- Layer 5 churn
- operator trust drops
- publication noise rises

### Pattern 2 — Hold-expiry rebuild bug
The shortlist rebuilds because the hold timer ended, not because reality changed enough.

Result:
- time-based fake causality
- unnecessary selection events

### Pattern 3 — Hold abuse
The shortlist remains frozen even when it is now clearly invalid.

Result:
- false stability
- delayed repair
- misleading promoted-set truth

### Pattern 4 — Filtering-selection collapse
Layer 4 starts redefining survivor truth rather than consuming it.

Result:
- Layer 3 and Layer 4 boundaries blur
- later debugging becomes harder

### Pattern 5 — Deep authority leak
Deep outputs or UI attention start influencing membership before Stage 7 exists or outside explicit blueprint rules.

Result:
- selection authority weakens
- causality becomes ambiguous

---

## Stage 6 invalid completions

Stage 6 is **not** complete if any of the following are true:
- Layer 4 shortlist truth is still mostly implicit or ad hoc
- hold/materiality posture is absent or cosmetic
- hold expiry still functions like automatic rebuild permission
- the selected set churns without real challenge
- committed Layer 4 truth does not land lawfully
- Layer 4 has already absorbed deep-analysis semantics
- later stages would still need to invent promoted membership themselves

---

## Relationship to later stages

Stage 6 does not deliver deep promoted truth yet.
It delivers the promoted membership authority that deep promoted truth depends on.

That means later stages should rely on Stage 6 for:
- real selected-set membership truth
- hold/material-shift posture
- stable/invalid/dirty-held shortlist posture
- freshness-aware committed Layer 4 truth

If later stages still have to invent who is promoted or why the selected set changed, Stage 6 was incomplete.

---

## Final standard

Stage 6 is correct when ASC can truthfully answer the next scanner question inside the governed runtime:

> which survivors deserve promotion into the current selected set?

That means Stage 6 must leave ASC with:
- real Layer 4 executable shortlist truth
- sole selection authority in Layer 4
- hold/material-shift posture that is real and inspectable
- a stable selected set when nothing meaningful changed
- lawful committed Layer 4 publication
- no deep-analysis or UI authority creep

The standard is not that Layer 4 produces a list.
The standard is that Layer 4 now owns trustworthy promoted membership strongly enough that the deep-analysis stage can begin without ambiguity.

2026-03-29 note: Layer 4 shortlist runtime publication is active. Remaining work is hardening and validation; Layer 5 stays command-only.
