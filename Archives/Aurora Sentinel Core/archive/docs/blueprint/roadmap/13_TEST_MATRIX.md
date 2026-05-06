# ASC Test Matrix

## Purpose

This document defines the canonical test matrix for Aurora Sentinel Scanner (ASC).

Its job is to turn the roadmap and final blueprint into a concrete validation grid that answers:
- what must be tested
- when it must be tested
- what evidence counts as a pass
- what failures block progression or acceptance

ASC is not a system that can be trusted through vague confidence language.
It needs a test matrix strong enough to distinguish:
- compile success from architectural success
- visible activity from truthful behavior
- isolated success from integrated resilience

This file exists so the rebuild cannot hide behind partial demonstrations or “seems stable” judgments.

---

## Core doctrine

### Test-matrix-is-trust discipline law
The test matrix is not a box-checking exercise.
It is one of the main mechanisms that prevents ASC from drifting back into:
- patch-loop optimism
- UI proof-by-motion
- restart optimism
- family confusion
- scope creep hidden inside “working enough” behavior

### Tests must follow ownership and stage law
Tests must reflect the architecture and the roadmap.
A test is valid only if it respects:
- ownership boundaries
- source-of-truth rules
- runtime class law
- stage dependency order
- artifact-family trust posture

### Pass means evidence, not confidence
A scenario passes only when the required evidence exists.
A pass is not:
- “looked fine this time”
- “didn’t obviously break”
- “screen updated as expected”
- “the code compiles so it must work”

### Failure is informative
A failed test is not embarrassment.
It is signal about whether the weakness is in:
- implementation
- sequencing
- acceptance claims
- or the architecture itself

---

## Matrix structure

The ASC test matrix is organized across four axes:

1. **Test domain** — what class of system behavior is being tested
2. **Stage relevance** — when the test becomes required
3. **Evidence type** — what observable proof is required
4. **Pass/fail posture** — what outcome means pass, conditional pass, or fail

This prevents the matrix from becoming a flat checklist with weak context.

---

## Test domains

The matrix should cover at least the following domains:

### A. Repository and structural tests
These validate:
- active repo shape
- domain/file placement
- authority-path clarity
- archive demotion posture

### B. Foundational type/state tests
These validate:
- centralized posture vocabularies
- shared state contracts
- artifact metadata types
- identity and registry posture

### C. Runtime control tests
These validate:
- one-major-lane-per-heartbeat
- mode posture
- credits and stop conditions
- starvation detection
- congestion behavior
- forced-service posture

### D. Layer tests
These validate:
- ownership per layer
- allowed inputs/outputs
- freshness/degraded posture
- no cross-layer truth invention
- lawful committed publication per layer

### E. Artifact/persistence tests
These validate:
- family boundaries
- atomic landing
- metadata application
- last-good behavior
- restore trust posture
- publish-threshold behavior

### F. HUD/operator tests
These validate:
- source-aware structural pages
- bounded tactical overlays
- stale/degraded/continuity-backed signaling
- no hidden scheduling authority
- transition/focus behavior

### G. Recovery tests
These validate:
- restart humility
- restore posture correctness
- revalidation requirements
- continuity support without freshness fraud

### H. Pressure/performance tests
These validate:
- wide-universe behavior
- high open-symbol count behavior
- mixed dirty-routing pressure
- publication pressure
- runtime stability under load

### I. Acceptance tests
These validate:
- end-to-end architectural integrity under realistic conditions
- office acceptance evidence alignment
- conditional acceptance versus full acceptance posture

---

## Evidence types

Every test scenario should specify what evidence is required.
Typical evidence classes include:

### 1. Structural evidence
Examples:
- file exists in correct domain
- type is centralized
- dependency direction is preserved
- layer/module ownership is explicit

### 2. Runtime evidence
Examples:
- lane ownership per beat is inspectable
- mode transition occurred for the right reason
- stale/degraded state surfaced honestly
- a layer remained bounded under pressure

### 3. Artifact evidence
Examples:
- canonical artifact landed
- metadata spine present and meaningful
- temp-to-final promotion occurred lawfully
- last-good posture distinguishable from fresh landed truth

### 4. Operator-surface evidence
Examples:
- HUD field clearly belongs to structural or tactical source class
- stale or continuity-backed truth is visibly marked
- focused symbol receives bounded tactical overlay without widening scope

### 5. Recovery evidence
Examples:
- restored artifact marked as requiring revalidation
- continuity-backed structural truth does not impersonate fresh truth
- restart path preserves humility rather than fake-normal behavior

### 6. Stress evidence
Examples:
- wide-universe Layer 1 remains broad and cheap
- congestion mode protects structural truth
- deep service remains promoted-only under pressure
- publication remains calm under tactical movement

---

## Pass / conditional pass / fail posture

### Pass
A test passes when:
- required evidence is present
- architectural rules remain intact
- no disallowed side effects appear
- failure/degraded posture, if applicable, remains honest

### Conditional pass
A test may be conditionally passed only when:
- core behavior is correct
- a bounded non-catastrophic weakness remains
- the weakness is explicitly documented
- the remaining risk does not invalidate the current stage gate

Conditional pass must never be used to hide structural failure.

### Fail
A test fails when:
- required evidence is missing
- the architecture boundary is violated
- trust posture is ambiguous or deceptive
- the stage gate being tested can no longer be claimed honestly

---

## Stage relevance map

### Stage 0 — Repo reset tests
Required domains:
- repository and structural tests

Key checks:
- active repo surfaces are unambiguous
- archives are demoted to evidence only
- blueprint/roadmap/office/mt5 paths are clear
- no shadow-active paths remain

### Stage 1 — Foundation/type tests
Required domains:
- foundational type/state tests
- structural tests

Key checks:
- posture vocabularies are centralized
- state records are explicit enough for later stages
- artifact metadata language exists centrally
- foundational MT5 domains exist lawfully

### Stage 2 — Runtime control tests
Required domains:
- runtime control tests
- structural tests

Key checks:
- one heartbeat owner exists
- lane ownership is inspectable
- modes are real
- credits are class-aware
- dirty-routing does not self-admit

### Stage 3 — Layer 1 tests
Required domains:
- Layer 1 tests
- runtime control tests
- artifact/persistence tests for Layer 1 landing

Key checks:
- broad cheap scan is real
- Open/Closed/Uncertain/Unknown posture is honest
- readiness is grounded in Layer 1 truth
- Layer 1 committed artifact lands lawfully

### Stage 4 — Layer 2 tests
Required domains:
- Layer 2 tests
- runtime control tests
- artifact/persistence tests for Layer 2 landing

Key checks:
- admitted subset packet service is real
- packet freshness/continuity posture is explicit
- focused tactical packet rights are bounded
- Layer 2 committed artifact lands lawfully

### Stage 5 — Layer 3 tests
Required domains:
- Layer 3 tests
- runtime control tests
- artifact/persistence tests for Layer 3 landing

Key checks:
- cheap gate logic is real
- reason codes are bounded and explainable
- bucket assignment is not selection
- Layer 3 committed artifact lands lawfully

### Stage 6 — Layer 4 tests
Required domains:
- Layer 4 tests
- runtime control tests
- artifact/persistence tests for Layer 4 landing

Key checks:
- shortlisted/promoted membership is real
- hold/material-shift posture is executable
- hold expiry alone does not trigger rebuild
- Layer 4 committed artifact lands lawfully

### Stage 7 — Layer 5 tests
Required domains:
- Layer 5 tests
- runtime control tests
- artifact/persistence tests for Layer 5 landing

Key checks:
- promoted-only deep service is real
- rank-sensitive cadence stays bounded inside promoted scope
- no focus entitlement bug exists
- Layer 5 committed artifact lands lawfully

### Stage 8 — Persistence/artifact tests
Required domains:
- artifact/persistence tests
- recovery tests
- runtime control tests for persistence override behavior

Key checks:
- artifact families are real
- atomic landing works
- metadata spine is meaningful
- last-good and restore posture are explicit

### Stage 9 — HUD/operator tests
Required domains:
- HUD/operator tests
- artifact/persistence tests
- runtime control tests

Key checks:
- structural pages consume landed truth
- tactical overlays remain bounded
- source posture is visible
- HUD does not become hidden scheduler


### Stage 9 HUD checklist lanes (required)
The following six checklist lanes are mandatory for Stage 9 HUD/operator validation and must be run with explicit evidence:

1. **Page hierarchy completeness**
   - all 5 canonical pages exist and transitions preserve canonical lineage
2. **Control placement stability and anti-drift**
   - control zones remain in contract order and no hidden/duplicated navigation paths emerge
3. **Symbol action button placement/visibility compliance**
   - symbol actions appear only on symbol pages with lawful visibility/enable behavior
4. **Tactical field scope/cadence/persistence-boundary compliance**
   - tactical fields remain selected-symbol scoped, cadence-bounded, and persistence-boundary safe
5. **Render invalidation and transition-budget compliance**
   - invalidation policy and transition lock/freeze budgets remain bounded and truth-safe
6. **Broker-dynamic page behavior compliance**
   - broker-profile-aware density/paging behavior stays presentation-only and does not mutate hierarchy truth

### Stage 10 — Acceptance tests
Required domains:
- all domains above
- pressure/performance tests
- recovery tests
- acceptance tests

Key checks:
- wide-universe behavior is valid
- congestion/starvation behavior is truthful
- restart/recovery remains humble
- office acceptance evidence matches real behavior

---

## Test scenario classes

The matrix should cover at least the following scenario classes.

### 1. Normal-flow scenarios
These validate expected steady-state behavior under lawful conditions.

Examples:
- warmup progresses normally
- packet truth refreshes for open symbols
- shortlist remains stable when nothing material changes
- promoted deep service stays inside scope

### 2. Degraded-flow scenarios
These validate honesty under weakened conditions.

Examples:
- stale Layer 2 packet posture remains visible
- degraded shortlist remains marked
- continuity-backed deep truth remains distinguishable

### 3. Interrupted-flow scenarios
These validate behavior under disruption.

Examples:
- interrupted artifact landing
- restart between staging and promotion
- partial restore with revalidation required

### 4. Pressure scenarios
These validate structural survival under stress.

Examples:
- large broker universe during warmup
- many open symbols under packet pressure
- persistence backlog with tactical overlays active
- promoted deep backlog under congestion

### 5. Boundary-violation scenarios
These validate that disallowed behavior remains blocked.

Examples:
- page visibility should not trigger Layer 4 rebuild
- focus should not grant non-promoted deep entitlement
- hold expiry alone should not rebuild shortlist
- Layer 3 should not widen into ranking

---

## Canonical test groups

### Group A — Structural repository tests
Examples:
- only one active blueprint authority path exists
- archives are not used as active runtime surface
- office and mt5 domains are in the correct roles

Pass evidence:
- repo tree and active-path logic match Stage 0 law

### Group B — Foundational contract tests
Examples:
- freshness/degraded/coherence vocabularies are centralized
- artifact metadata contracts are shared, not duplicated
- symbol registry identity surface exists

Pass evidence:
- foundational files and contracts match Stage 1 law

### Group C — Heartbeat/governor tests
Examples:
- every beat has one dominant owner
- credit exhaustion causes lawful yield
- dirty work does not self-admit
- congestion mode narrows nonessential work

Pass evidence:
- runtime traces/telemetry show lawful governor behavior

### Group D — Layer 1 tests
Examples:
- broad scan remains broad and cheap
- Unknown/Uncertain posture is preserved honestly
- readiness advances through Layer 1 coverage rather than UI richness

Pass evidence:
- symbol state samples, readiness posture, and Layer 1 artifacts match Stage 3 law

### Group E — Layer 2 tests
Examples:
- packet service stays subset-driven
- tactical selected-symbol reads remain bounded
- continuity-backed packet posture is explicit

Pass evidence:
- packet artifacts, freshness markers, and tactical/structural split match Stage 4 law

### Group F — Layer 3 tests
Examples:
- eligibility remains cheap and explainable
- reason codes exist
- bucket assignment does not become selection

Pass evidence:
- filter artifacts and runtime traces match Stage 5 law

### Group G — Layer 4 tests
Examples:
- shortlist authority belongs only to Layer 4
- hold and dirty-held posture work meaningfully
- hold expiry alone does not cause rebuild

Pass evidence:
- shortlist artifacts and selection traces match Stage 6 law

### Group H — Layer 5 tests
Examples:
- deep service stays promoted-only
- rank-sensitive cadence does not widen scope
- demoted symbols lose active deep entitlement

Pass evidence:
- deep artifacts and service traces match Stage 7 law

### Group I — Persistence/artifact tests
Examples:
- staging/promote flow is atomic
- family boundaries are interpretable
- last-good is distinct from fresh landed truth
- restore trust posture is explicit

Pass evidence:
- landed artifacts and metadata show Stage 8 law in practice

### Group J — HUD/operator tests
Examples:
- structural pages hydrate from landed truth
- tactical overlays remain narrow
- source posture is visible
- stale structure is not hidden behind tactical motion

Pass evidence:
- page behavior and source-state inspection match Stage 9 law
- all six Stage 9 HUD checklist lanes are executed with explicit pass/fail evidence
- any conditional pass records bounded risk, lane owner, and closure condition

### Group K — Recovery tests
Examples:
- restart after partial landing remains honest
- continuity-backed truth is not displayed as fully fresh
- live revalidation occurs where required

Pass evidence:
- restore traces and operator surfaces preserve humility

### Group L — Wide-universe and pressure tests
Examples:
- Layer 1 still scales broadly
- Layer 2 remains subset-driven under wide scope
- selection remains calm under upstream churn
- deep service remains bounded under congestion

Pass evidence:
- runtime traces under pressure remain blueprint-consistent

---

## Acceptance evidence model

For important scenarios, the test record should capture at least:
- scenario name
- domain/group
- stage relevance
- setup conditions
- expected lawful behavior
- actual observed behavior
- artifacts/logs/telemetry examined
- pass / conditional pass / fail result
- follow-up required if not full pass

This should be structured enough that later audits can understand what was actually proven.

---

## Required evidence by domain

### Runtime control evidence
Should include things such as:
- heartbeat owner traces
- mode changes with reasons
- credit use / yield points
- starvation or congestion signals

### Layer evidence
Should include things such as:
- state/posture examples
- committed artifact samples
- proof that later-layer behavior did not leak backward

### Persistence evidence
Should include things such as:
- staging/promote sequence outcome
- metadata posture on actual artifacts
- continuity and restore-trust examples

### HUD evidence
Should include things such as:
- source classification per major visible surface
- structural vs tactical examples
- stale/degraded/continuity-backed UI examples

### Recovery evidence
Should include things such as:
- restart behavior traces
- restore posture decisions
- live revalidation evidence where required

---

## Blocking versus non-blocking failures

### Blocking failures
A failure is blocking when it:
- violates ownership
- hides stale/degraded/continuity posture deceptively
- allows hidden scheduler/UI authority
- weakens atomic artifact trust materially
- makes restart/recovery posture dishonest
- breaks wide-universe architectural validity

Blocking failures stop stage advancement or acceptance.

### Non-blocking failures
A failure may be non-blocking only when it:
- is local and bounded
- does not weaken architectural truth materially
- is explicitly documented
- does not mislead consumers or the operator

Non-blocking failures should still be tracked, not ignored.

---

## Conditional-pass doctrine

A scenario may be conditionally passed only when:
- the architectural rule survives
- the remaining weakness is bounded
- the missing evidence or limitation is documented clearly
- the current roadmap gate still remains honest

Conditional pass must never be used to smuggle a stage forward when its core ownership or trust boundary is still weak.

---

## Common test-matrix failure patterns

### Pattern 1 — Compile-only validation
The code compiles, and this is treated as sufficient validation.

Result:
- architectural weaknesses survive untouched

### Pattern 2 — UI proof-by-motion
A moving screen is treated as evidence that source truth is strong.

Result:
- stale/degraded/continuity ambiguity remains hidden

### Pattern 3 — Isolated pass, integrated fail
Each domain looks acceptable alone, but cross-domain pressure breaks the architecture.

Result:
- acceptance happens too early

### Pattern 4 — Restore optimism
Restart/recovery scenarios are under-tested because normal flow looks clean.

Result:
- continuity-backed truth impersonates live truth later

### Pattern 5 — Wide-universe avoidance
The system is validated only on easy symbol counts and calm conditions.

Result:
- broker-scale reality reveals weaknesses too late

---

## Matrix maintenance doctrine

The test matrix is not static paperwork.
It must evolve when:
- a stage is completed
- a new blocking failure class is discovered
- architecture changes explicitly
- acceptance evidence reveals a missing scenario class

However, updates must remain explicit and tied to blueprint/office reality.
The matrix must not drift into a vague log of anxieties.

---

## Relationship to office tracking

`office/ROADMAP_STATUS.md`, `WORK_LOG.md`, and `CHANGE_LEDGER.md` should reference test-matrix outcomes where relevant.

The office role is not to replace the matrix.
The office role is to reflect:
- what matrix groups were run
- what passed
- what failed
- what remains blocking

If office acceptance posture ignores the matrix, office is lying.

---

## Minimum required matrix for Stage 10 acceptance

Before Stage 10 can be honestly closed, the matrix should include passed or explicitly conditionally passed evidence for:
- runtime control
- all five truth layers
- persistence/artifacts
- HUD/operator surface
- restart/recovery posture
- wide-universe and pressure behavior
- office acceptance alignment

Anything less is not full acceptance.

---

## Final standard

The ASC test matrix is correct when it makes it difficult to confuse visible activity, compile success, or subjective confidence with real architectural proof.

That means the matrix must be:
- domain-complete
- stage-aware
- evidence-based
- blocking when trust boundaries fail
- honest about conditional passes
- strong enough to audit later

The standard is not that tests exist.
The standard is that the right failures are hard to hide and the right passes are hard to fake.