# ASC Stage 10 — Hardening and Acceptance

## Purpose

This document defines Stage 10 of the Aurora Sentinel Scanner (ASC) rebuild roadmap.

Stage 10 is the hardening-and-acceptance stage.
Its job is to prove that the rebuilt system can preserve architectural truth under realistic runtime pressure, restart conditions, broker scale, artifact continuity constraints, and operator-visible use.

If Stages 0 through 9 build the lawful system, Stage 10 answers the final operational question:

> can ASC remain trustworthy when the environment stops being cooperative?

This stage exists because a system can look correct in slices while still failing under cross-domain stress, restart friction, artifact ambiguity, or UI/runtime contention.
Hardening is where the rebuild earns the right to be called durable rather than merely well-described.

---

## Stage objective

Stage 10 establishes the final hardening, validation, and acceptance program for the rebuilt ASC.

It defines and/or executes:
- end-to-end architectural validation across runtime, layers, artifacts, HUD, and recovery posture
- failure-mode testing under degraded/stale/restart conditions
- large-broker and wide-universe pressure validation
- cadence and starvation validation under realistic mixed load
- restart/restore trust validation
- operator-surface truthfulness validation
- acceptance criteria for declaring the rebuild structurally ready

The goal is not to add new architecture.
The goal is to verify that the existing architecture holds under pressure.

---

## Why Stage 10 matters

Without Stage 10, the rebuild risks several false-positive outcomes:
- all blueprint files exist, but runtime pressure still causes blended pulses
- all layers publish, but restore trust remains weak under restart
- HUD looks clean, but source separation collapses during real navigation
- persistence works in normal flow, but fails noisily under staging/promotion interruptions
- shortlist/deep logic behaves well in calm conditions but becomes unstable under congestion

Stage 10 matters because it is where the rebuild stops being judged by intention and starts being judged by resilience.

If Stage 10 is weak:
- old restart-loop patterns can return under stress
- fake calm can hide starvation again
- UI smoothness can still outrun truth
- acceptance can be declared on a system that remains fragile in the exact ways that matter most

---

## Stage 10 dependency position

Stage 10 depends on:
- Stage 0 repo reset being complete
- Stage 1 foundation/types being complete enough to support consistent inspection and validation
- Stage 2 dispatcher/governor spine being real
- Stages 3 through 7 truth layers being real and lawfully owned
- Stage 8 persistence/artifact system being real
- Stage 9 HUD/operator surfaces being real and source-aware
- final blueprint lawbook being complete and authoritative
- office tracking being accurate enough to compare acceptance evidence against roadmap reality

Stage 10 is the prerequisite for:
- declaring the rebuild structurally ready
- trusting future implementation widening to stay within a hardened shape
- treating the new system as the true active ASC rather than an unfinished prototype

---

## Stage 10 scope

Stage 10 includes:
- hardening the integrated system against realistic operational conditions
- validating acceptance gates across runtime, layers, artifacts, HUD, and restore posture
- proving the system preserves its architecture under pressure
- defining what counts as accepted, conditionally accepted, or not accepted yet
- ensuring office evidence aligns with the actual hardening outcome

Stage 10 does **not** include:
- inventing new core architecture to rescue weak validation
- widening scope to new feature ambitions
- treating hardening as a place to hide a late architecture rewrite
- using temporary demo behavior as acceptance evidence

If major architecture change is required at this stage, that must be surfaced explicitly rather than quietly patched in under the label of hardening.

---

## Stage 10 deliverables

Stage 10 should deliver the following outcomes.

### 1. End-to-end validation becomes real
The rebuilt ASC should now be testable as one coherent system rather than as disconnected stage slices.

### 2. Acceptance criteria become executable
The rebuild should now have a clear acceptance standard that can answer:
- what is proven
- what remains weak
- what blocks acceptance
- what evidence supports acceptance

### 3. Stress/failure posture becomes visible
The system should now demonstrate how it behaves under:
- runtime pressure
- starvation risk
- congestion
- restart/recovery
- artifact landing failure or delay
- stale/degraded upstream truth
- operator interaction changes

### 4. Office acceptance posture becomes honest
`office/ROADMAP_STATUS.md`, `WORK_LOG.md`, and `CHANGE_LEDGER.md` should now be able to reflect the difference between:
- architecturally complete
- runtime-hardened
- not yet accepted

---

## Acceptance domains

Stage 10 should validate at least the following domains.

### A. Runtime control acceptance
The dispatcher/governor spine must prove that:
- one-major-lane-per-heartbeat remains real under pressure
- class-aware credits still matter in mixed conditions
- starvation detection is not cosmetic
- congestion mode meaningfully protects structural truth
- focus overlays do not seize runtime authority

### B. Truth-stack acceptance
Layers 1 through 5 must prove that:
- ownership boundaries survive realistic runtime conditions
- later layers do not backfill lower-layer truth
- selection and deep authority remain separated
- freshness/degraded posture remains honest under load

### C. Persistence/artifact acceptance
The artifact system must prove that:
- atomic landing remains safe under repeated publication
- family boundaries remain interpretable
- last-good continuity remains distinguishable from fresh truth
- restore trust posture remains meaningful
- metadata is strong enough to prevent mixed-cycle confusion

### D. HUD/operator acceptance
The operator surface must prove that:
- structural pages consume landed truth lawfully
- tactical overlays stay bounded
- source posture remains visible
- stale/degraded/continuity-backed state remains honest
- page/focus/transition behavior does not become hidden runtime authority

### E. Recovery acceptance
The system must prove that:
- restart/reconnect/revalidation posture remains humble and explicit
- restore does not impersonate live truth
- last-good support helps without committing freshness fraud

---

## Acceptance philosophy

### Acceptance is architectural, not cosmetic
ASC is accepted only if the architecture still holds when conditions stop being ideal.
A good-looking screen or a green compile result is not enough.

### Acceptance requires cross-domain coherence
A domain that passes in isolation is not enough if the combined system still fails to preserve:
- ownership
- cadence law
- persistence trust
- source truthfulness
- restore humility

### Acceptance is evidence-based
Every acceptance claim should point to concrete evidence, not to confidence language.

---

## Hardening categories

Stage 10 should harden ASC across several categories.

### 1. Pressure hardening
Validate behavior under:
- large symbol universes
- high open-symbol counts
- increased dirty-routing volume
- multiple pending artifact families
- focus overlay activity during structural load

### 2. Recovery hardening
Validate behavior under:
- restart after previously landed truth exists
- partial artifact continuity conditions
- degraded/stale restore posture
- interrupted landing/promotion flows

### 3. Operator hardening
Validate behavior under:
- page switching
- selected-symbol changes
- structural/tactical source mixing pressure
- transition lock/freeze timing stress

### 4. Truthfulness hardening
Validate that the system does not hide:
- stale truth
- degraded truth
- continuity-backed truth
- partial or blocked layer posture
- mixed-cycle or weak restore posture

### 5. Cadence hardening
Validate that:
- calm publication remains calm
- deep work does not widen
- shortlist remains stable when it should
- Layer 1 still progresses honestly under pressure

---

## Large-broker doctrine in Stage 10

### Wide-universe validation must now happen
The rebuild is explicitly intended to remain valid on brokers with large symbol universes.
Stage 10 should therefore validate behavior under wide-universe conditions, not just small comfortable symbol sets.

### What should be proven
At minimum, the system should demonstrate that:
- Layer 1 broad scans remain broad and cheap rather than collapsing into timid starvation
- Layer 2 remains subset-driven even when the universe is large
- filtering remains cheap and local when possible
- shortlist and deep stages do not widen simply because the universe is large

If the architecture only works on small easy universes, it is not accepted yet.

---

## Restart and restore doctrine in Stage 10

### Restore must now be judged in practice
Stage 10 should test and validate whether artifacts and last-good continuity actually support truthful recovery rather than merely looking good on paper.

### What should be proven
At minimum, the system should demonstrate that:
- restored truth is labeled according to trust posture
- live truth is re-earned where required
- last-good continuity helps but does not impersonate freshness
- structural pages can show restore posture honestly after restart

### Recovery humility is required
If the system “looks normal immediately” after restart but has not re-earned the right to say so, acceptance must fail.

---

## Starvation and congestion doctrine in Stage 10

### Starvation must be tested, not assumed solved
Stage 10 should validate that starvation detection is meaningful under real mixed conditions, for example:
- Layer 1 warmup pressure
- persistence landing backlog
- deep-service backlog inside the promoted set
- tactical focus overlays coexisting with structural pressure

### Congestion response must preserve structural truth
Under congestion, the system should still show:
- protected structural work survives
- cosmetic or optional work yields first
- stale/degraded posture rises honestly rather than being hidden

If the system becomes deceptively calm under pressure, acceptance must fail.

---

## Operator-truth doctrine in Stage 10

### The screen must now be judged as part of truth, not just UX
Stage 10 should validate that the operator-facing experience still preserves:
- source visibility
- structural vs tactical truth separation
- honest stale/degraded signaling
- bounded focus behavior
- bounded transition behavior

### The operator must not need inside knowledge to interpret basic posture
If only the developer can tell whether a visible field is current, tactical, stale, or continuity-backed, the HUD is not accepted yet.

---

## Acceptance gates

Stage 10 is complete only when all of the following are true.

### Gate 1 — Runtime spine survives mixed conditions
The dispatcher/governor still preserves major-lane ownership, class-aware credits, and mode posture under realistic stress.

### Gate 2 — Layer ownership survives integration
Layers 1 through 5 still own their correct truths and do not silently absorb one another under pressure.

### Gate 3 — Artifact trust is durable
Atomic landing, family boundaries, metadata, last-good posture, and restore posture remain meaningful in real runs.

### Gate 4 — HUD remains downstream
The operator surface consumes truth lawfully and does not become a hidden scheduler or truth engine.

### Gate 5 — Restart/recovery stays humble
The system does not impersonate live truth too early after restart or disruption.

### Gate 6 — Wide-universe behavior remains valid
The system still behaves in a blueprint-consistent way on larger brokers and wider admitted sets.

### Gate 7 — Office evidence matches reality
Acceptance claims in office files match the actual validation evidence and known remaining weaknesses.

---

## Acceptance evidence

Stage 10 completion should be evidenced by a combination of:
- structured validation results across the acceptance domains
- realistic runtime observations under mixed conditions
- failure/recovery traces where applicable
- office status updates tied to concrete outcomes
- known limitations listed explicitly if conditional acceptance is being considered

Acceptance evidence should not rely on vague phrases like:
- “seems stable”
- “looks good”
- “probably fine now”

Evidence must remain concrete enough that future work can audit it.

---

## Conditional acceptance doctrine

### Conditional acceptance may exist, but must be explicit
If the system is close but not fully hardened, Stage 10 may allow a clearly labeled conditional acceptance posture.

### Conditional acceptance must state
- what is accepted
- what remains unproven
- what risks remain active
- what specific evidence is still missing

Conditional acceptance is not permission to quietly call the system finished.
It is a structured interim posture only.

---

## Failure doctrine in Stage 10

### Hardening failure must be treated as signal, not embarrassment
If a domain fails hardening, the response should be:
- isolate the failure class
- identify whether the issue is implementation, sequencing, or architecture
- record the failure explicitly in office tracking
- correct the right surface deliberately

### Hardening is not a place for silent architecture rewrites
If Stage 10 reveals that the design itself is wrong, that must be surfaced explicitly as a blueprint/office change.
It must not be hidden in “small acceptance fixes.”

---

## What Stage 10 must not do

### 1. No acceptance theater
Do not declare the system accepted because documents exist, pages look smooth, or the runtime is busy.

### 2. No scope widening disguised as hardening
Do not introduce major new features because acceptance work found a rough edge.

### 3. No restore optimism
Do not treat restart recovery as accepted while restored artifacts still blur live truth and continuity-backed truth.

### 4. No UI proof-by-motion
Do not treat a lively screen as proof that the truth stack is strong.

### 5. No hidden known weaknesses
Do not let office tracking imply full readiness while known structural risks remain unspoken.

### 6. No pressure denial
Do not accept the system if wide-universe behavior, congestion behavior, or starvation posture is still mostly unproven.

---

## Stage 10 implementation approach

The preferred progression inside Stage 10 is:

1. define the explicit acceptance matrix and evidence model
2. validate runtime control under mixed pressure
3. validate layer integration and truth-boundary survival
4. validate artifact landing, metadata, continuity, and restore posture
5. validate HUD/operator truthfulness and bounded tactical behavior
6. validate restart/recovery humility
7. validate wide-universe and high-pressure conditions
8. record final acceptance or conditional acceptance posture in office

### Why this order matters
Control and truth boundaries come first.
Artifacts and restore posture prove durability.
HUD truthfulness proves lawful presentation.
Wide-universe pressure proves the system is not only correct in easy conditions.

---

## Common failure patterns Stage 10 must prevent

### Pattern 1 — Acceptance theater
The rebuild is declared ready because everything exists, not because it has survived realistic integrated conditions.

Result:
- old fragilities reappear later
- office trust weakens

### Pattern 2 — Smooth UI, weak truth
The HUD looks convincing, but structural sources, restore posture, or stale signaling remain weak.

Result:
- operator trust is built on presentation rather than truth

### Pattern 3 — Stress denial
The system is accepted without proving behavior on larger universes, higher open-symbol counts, or realistic dirty/persistence pressure.

Result:
- deployment reality exposes weaknesses immediately

### Pattern 4 — Recovery optimism
Restart or reconnect paths appear acceptable because the system repaints quickly, even though restore trust remains weak.

Result:
- continuity-backed truth impersonates live truth

### Pattern 5 — Hidden unresolved drift
Known boundary leaks, authority creep, or family confusion remain active but are not carried into acceptance status honestly.

Result:
- the acceptance label becomes misleading

---

## Stage 10 invalid completions

Stage 10 is **not** complete if any of the following are true:
- acceptance is declared without explicit evidence across runtime, layers, artifacts, HUD, and restore posture
- wide-universe behavior is still mostly speculative
- starvation/congestion posture has not been meaningfully tested
- restart/recovery still blurs continuity-backed truth with live truth
- the HUD still risks acting like a hidden scheduler or second engine
- known structural weaknesses remain materially active but underreported
- office acceptance posture does not match the real validation state

---

## Relationship to later work

Stage 10 is the last roadmap stage because it is the point where the rebuild should stop hiding behind partial-stage logic and stand as one integrated system.

That does not mean no future work can happen.
It means future work should now occur against a hardened accepted baseline rather than against a still-unproven architecture.

If future work still needs to ask whether the foundations are trustworthy, Stage 10 was incomplete.

---

## Final standard

Stage 10 is correct when ASC can truthfully say:

> this rebuild is not only well-designed and implemented, but has survived the kinds of pressure that used to make the old system decay.

That means Stage 10 must leave ASC with:
- runtime control that remains lawful under stress
- layer boundaries that survive integration
- artifact trust that survives landing and restore pressure
- HUD/operator surfaces that remain downstream and truthful
- explicit evidence for acceptance rather than confidence language
- no hidden reliance on smooth presentation, restart optimism, or easy-case assumptions

The standard is not that the system looks finished.
The standard is that the system has now earned trust under pressure.