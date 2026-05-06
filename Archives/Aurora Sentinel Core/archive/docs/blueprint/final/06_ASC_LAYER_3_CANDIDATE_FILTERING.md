# ASC Layer 3 Candidate Filtering

## Purpose

This document defines the canonical design of Layer 3 in Aurora Sentinel Scanner (ASC).

Layer 3 is the candidate-filtering owner.
Its job is to consume earlier committed truth and answer the next narrow question honestly:

> which symbols remain eligible for further consideration under cheap filtering doctrine?

Layer 3 exists to reduce the admitted open-symbol field into a cleaner survivor set without prematurely deciding who deserves promotion.

Layer 3 is the gate.
It is not the shortlist.
It is not a ranking engine.
It is not a disguised deep-analysis surface.

Current runtime posture lock:
- Layer 3 Candidate Filtering is the strongest active selection truth in runtime today.
- Layer 4 and Layer 5 remain scaffold-only and must not be implied by Layer 3 wording.

---

## Core doctrine

Binding reference: `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`.

### Cheap-gate law
Layer 3 is automatic and must remain cheap enough to evaluate survivors calmly and repeatedly when upstream truth changes materially.

Its role is to apply bounded, current-state-aware filtering using already available truth.
It must not rescue itself by pulling heavy new inputs whenever cheap inputs are missing or noisy.

### Consume-don't-rebuild law
Layer 3 consumes earlier committed Layer 1 and Layer 2 truth only.
It does not recreate them.
If required upstream truth is missing, stale, degraded, or not yet admitted, Layer 3 must remain pending, blocked, stale-aware, or degraded as appropriate.
It may not silently rebuild upstream ownership for convenience.

### Eligibility-not-ranking law
Layer 3 determines candidate eligibility posture.
It does not determine final promotion priority.
Layer 3 output creates downstream eligibility only, not automatic Layer 4/5 pile-on entitlement.
It may assign survivors into architecture-defined main buckets.
It may not transform that bucketing into hidden shortlist ranking.

### Gate-purity and neutrality law
Layer 3 is gate-pure.
It determines eligibility, blocking reasons, downstream readiness for inspection, and bounded diagnostic failures.
It may classify block types.
It may not imply trade direction, setup attractiveness, or signal quality.

### Reasons-must-exist law
Layer 3 must be able to explain why a symbol is:
- eligible
- ineligible
- pending
- degraded
- blocked

Layer 3 outputs are invalid if they cannot state a bounded reason.

### Cheap-present-state law
Layer 3 should prefer cheap present-state logic over richer but heavier logic.
If a rule requires deep history, complex statistical expansion, or heavy multi-timeframe reconstruction, that rule does not belong in Layer 3.

### Dirty-routing law
Layer 3 should usually wake because upstream committed truth changed materially or because a bounded reevaluation is due for symbols already in scope.
It must not become a broad recompute reflex that runs simply because the runtime is alive.

---

## What Layer 3 owns

Layer 3 owns:
- candidate eligibility state
- eligible / ineligible / pending / degraded / blocked posture
- cheap gating logic
- gate reason codes
- filter freshness state
- dirty-to-clean transition handling for filter results
- main-bucket assignment for survivors where architecture assigns that role
- blocker taxonomy where architecture assigns it
- downstream inspection-readiness posture
- bounded diagnostic failure exposure
- Layer 3 committed filtering artifact block
- Layer 3 stale / degraded visibility

Layer 3 owns gate truth itself.
It does not merely provide hints to Layer 4.

---

## What Layer 3 does not own

Layer 3 does not own:
- market-state acquisition
- open-symbol packet construction
- shortlist promotion authority
- promotion ordering
- hold-window rules
- deep selective analysis
- dossier composition
- HUD composition
- directional trade posture
- setup attractiveness
- signal-quality judgment
- global persistence policy beyond its own committed artifact block

If Layer 3 starts behaving like selection, deep analysis, or signal interpretation, the architecture is drifting.

---

## Primary runtime class

Layer 3 primary runtime class:
- **Calculation / Gate**

Layer 3 secondary bounded class:
- **Persistence / Write** only after a valid Layer 3 evaluation completes and only for Layer 3-owned results

Layer 3 must remain a calculation layer.
It must not disguise read-heavy or promotion-heavy work inside filter service.

---

## Layer 3 inputs

Layer 3 may consume:
- Layer 1 market-state truth
- Layer 2 current packet truth
- Layer 1 and Layer 2 freshness/degraded posture
- prior committed Layer 3 state where useful for transition handling or stability
- bounded architecture-defined normalization context if it remains cheap

Layer 3 must not require Layer 4 or Layer 5 outputs to decide basic gate posture.

---

## Layer 3 outputs

Layer 3 produces the canonical candidate-filtering block for symbols admitted to gate evaluation.
Its outputs may include:
- eligibility state
- reason code
- reason summary
- main bucket assignment for survivors where assigned
- blocker classification where applicable
- downstream inspection-readiness posture
- evaluation freshness markers
- last evaluated time
- stale / degraded / blocked posture
- continuity markers where architecture explicitly permits them

Layer 3 outputs must be compact, interpretable, and cheap to publish.

---

## Admission doctrine

### Layer 3 depends on committed upstream truth
Layer 3 is meaningful only after Layer 1 and Layer 2 have produced sufficient committed truth for the symbol.

At minimum, Layer 3 normally expects:
- Layer 1 market-state posture
- Layer 2 packet truth or an explicit Layer 2 inability state

### Layer 3 should prefer the admitted active field
Layer 3 is not a universe-wide first-pass surface.
Its natural field is the set of symbols for which Layer 1 and Layer 2 have made gate evaluation meaningful.

### Pending and blocked are valid outcomes
If upstream truth is not yet ready, Layer 3 should use pending or blocked posture rather than inventing eligibility from partial evidence.

---

## Eligibility doctrine

### Eligible
Eligible means the symbol passed the current cheap-gate law and may proceed to downstream inspection.
Eligible is not a trade endorsement.
It is only lawful survivor truth.

### Ineligible
Ineligible means the symbol failed one or more cheap gating rules and should not proceed downstream right now.

### Pending
Pending means required upstream truth is not yet sufficiently admitted for a lawful gate decision.

### Blocked
Blocked means the symbol cannot proceed because a gate precondition failed or a structural precondition is missing.
Blocked is not the same as ineligible.

### Blocker taxonomy
When Layer 3 reports blocked posture, the blocker class should remain narrow and explainable.
Canonical blocker classes are:
- **structural block** — required structural admission condition is absent or violated
- **temporary block** — symbol may recover on later refresh without architecture change
- **data-quality block** — input truth is insufficient, inconsistent, stale, or degraded beyond lawful gate use
- **market-quality block** — current market conditions fail bounded eligibility quality gates

This taxonomy exists to strengthen diagnosis.
It does not create ranking or direction authority.

### Degraded
Degraded means Layer 3 is producing bounded honesty under weakened conditions.
It must not quietly present degraded gate truth as normal-quality truth.

### Stale
Stale means the last committed Layer 3 truth may still be visible, but its freshness posture no longer supports calm blind trust.

---

## Rule-design doctrine

### Cheap only
Layer 3 rules must be cheap enough to run as a real gate layer.
Acceptable ingredients usually include:
- Layer 1 market-state posture
- Layer 2 packet sanity
- packet freshness
- spread/tradability sanity where assigned
- simple bounded marketability checks
- simple bucket-assignment logic where assigned

### What Layer 3 must avoid
Layer 3 must avoid rules that require:
- deep history pulls
- multi-timeframe heavy reconstruction
- expensive ranking composition
- deep statistical packets
- manual operator interpretation embedded into runtime logic

### Why this matters
If Layer 3 becomes heavy, it destroys the architectural handoff between:
- packet building
- cheap gating
- shortlist selection
- deep selective analysis

That handoff is one of the main protections against runtime sprawl.

---

## Reason-code doctrine

### Every gate outcome must be explainable
Layer 3 should maintain bounded reason codes or equivalent structured reasoning for its outputs.

Typical outcome families include:
- passed
- failed market-state requirement
- failed packet freshness requirement
- failed spread/tradability requirement
- blocked by missing upstream packet
- degraded due to stale upstream truth
- pending evaluation

### Reason codes must remain narrow
Reason codes should explain the gate outcome.
They should not become hidden diagnostic novels or pseudo-ranking stories.

### Why reason codes matter
Reason codes support:
- runtime inspection
- operator trust
- stable debugging
- controlled downstream invalidation

If Layer 3 cannot explain itself, Layer 4 will become harder to trust.

---

## Bucket-assignment doctrine

### Layer 3 may assign main buckets
Layer 3 may assign survivors into architecture-defined main buckets when that classification is cheap and structurally useful downstream.

### Bucket assignment is not selection
Bucket assignment may help organize survivors for later Layer 4 processing.
It must not silently become a shortlist or a disguised ranking system.

Layer 3 may determine whether a symbol is ready for downstream inspection.
It may not imply that the symbol is attractive, favored, or signal-ready in the trading sense.

### Bucket assignment must remain cheap
If bucketing requires deep history or expensive multi-layer reconstruction, it no longer belongs in Layer 3.

---

## Freshness doctrine

### Layer 3 freshness matters
Because Layer 3 consumes current upstream truth, its gate results must carry freshness posture.
Layer 3 must be able to explain:
- when the result was last evaluated
- whether the upstream truth it consumed was fresh enough
- whether the filter result itself is still fresh enough to support later selection

### Freshness does not require constant recompute
Layer 3 should not rerun on every heartbeat just because its results age over time.
It should rerun when:
- upstream truth changed materially
- a bounded refresh policy says reevaluation is due
- recovery/degradation logic requires reevaluation

### Stale awareness
A stale Layer 3 result may remain visible as a last-known gate posture, but it must not be mistaken for fresh truth.

---

## Dirty-routing doctrine

### What should dirty Layer 3
Layer 3 should become dirty primarily when:
- Layer 1 market-state changed materially
- Layer 2 packet changed materially
- packet freshness/degraded posture crossed a gate-relevant threshold
- a bounded filter-refresh rule specifically requires reevaluation

### What should not dirty Layer 3 automatically
Layer 3 should not automatically wake because:
- a HUD page was opened
- a dossier was read
- Layer 4 selection changed
- Layer 5 deep packets updated
- the runtime simply completed a heartbeat

### Dirty routing must stay narrow
Layer 3 should reevaluate the affected symbols or bucket-relevant population, not opportunistically widen into a broad recompute wave unless the architecture explicitly requires it.

---

## Scheduling doctrine

### Layer 3 is event-sensitive, not pulse-hungry
Layer 3 is usually best served by dirty routing plus bounded sweep rules.
Layer 3 may be serviced in focused packets and must not be constrained to tiny timid beat-sized work.
It should not be treated like a permanent every-beat maintenance engine.

### Bounded sweep law
A bounded sweep may be used to:
- repair stale gate posture
- clean up pending candidates
- recover from restart/reconnection continuity gaps
- verify that dirty routing has not left dead zones

But bounded sweeps must remain selective and secondary.
They are not a license for universe-wide perpetual filter churn.

### Reevaluate only what earned reevaluation
Layer 3 should prefer symbol-selective or subset-selective reevaluation when upstream changes are local.
Global reevaluation should require a real reason.

---

## Layer 3 artifact block

Layer 3 owns the candidate-filtering artifact block.
That block should be compact, inspectable, and atomically landed.

It should contain at minimum:
- eligibility state
- reason code or equivalent structured reason
- main bucket assignment where assigned
- last evaluated time
- freshness / stale / degraded posture

### Artifact law
Layer 3 artifacts exist so later layers and operator surfaces can consume gate truth without reconstructing it ad hoc.

### Calm publication law
Layer 3 should publish its results when evaluation completes.
It must not create noisy write churn because upstream packet fields are moving tactically.

### Atomic publication
Layer 3 publication must follow temp-to-final atomic landing discipline.
A failed later layer must not erase already committed Layer 3 truth.

---

## Degraded behavior

Layer 3 must fail honestly.

### If upstream truth is insufficient
Layer 3 should use pending, blocked, or degraded posture rather than guessing eligibility.

### If prior filter truth exists
Layer 3 may preserve last-good committed results where architecture permits, but must mark stale or degraded posture clearly when those results are no longer fully current.

### If writes fail
Layer 3 should preserve last-good committed filtering truth where allowed, while surfacing landed-state ambiguity and freshness posture honestly.

### If gate rules cannot run cheaply anymore
The design is wrong.
Layer 3 must not quietly absorb heavyweight logic just to preserve feature scope.

---

## Downstream implications

When Layer 3 commits new or materially changed filtering truth, it may create downstream eligibility.
That downstream effect is inspection readiness only.
It is not a directional hint and not an early signal classification.

Typical downstream effects:
- Layer 4 may become eligible to reconsider shortlist state
- bucket-level structural views may need refresh
- survivor/ineligible counts may change

Layer 3 does **not** automatically authorize:
- immediate Layer 4 rebuild in the same beat
- immediate Layer 5 deep refresh
- dossier compose wave
- operator-surface expansion beyond normal consumption

Layer 3 creates eligibility, not pile-on permission.

---

## Common failure patterns

### Pattern 1 — Hidden ranking creep
Layer 3 starts scoring, ordering, or behaving like a pre-shortlist engine.

Result:
- Layer 4 loses clear authority
- filtering becomes harder to explain
- runtime cost rises

### Pattern 2 — Heavy-input rescue
Layer 3 reacts to thin upstream truth by pulling more and more expensive data.

Result:
- gate cost rises
- class identity breaks
- later layers lose their reason to exist

### Pattern 3 — Broad recompute addiction
Layer 3 reevaluates far too much far too often simply because some upstream truth changed somewhere.

Result:
- runtime churn
- poor locality
- unnecessary pressure on writes and downstream selection

### Pattern 4 — No-reason opacity
Symbols flip eligible/ineligible but the system cannot explain why.

Result:
- operator trust weakens
- debugging degrades
- Layer 4 becomes suspect

### Pattern 5 — Bucketing becomes ranking
Main-bucket assignment quietly becomes a substitute for shortlist priority.

Result:
- Layer 3 and Layer 4 boundaries blur
- selection authority becomes ambiguous

---

Future implementation may not turn Layer 3 into either a fake calm starved gate or a page-visibility-triggered recalculation loop.

## Implementation obligations

Any future MT5 implementation of Layer 3 must:
- consume Layer 1 and Layer 2 committed truth rather than recreating it
- keep gate logic cheap, explicit, and gate-pure
- maintain structured reason codes or equivalent bounded explanations
- distinguish eligible, ineligible, pending, blocked, stale, and degraded posture clearly
- classify blockers with the canonical narrow taxonomy where blocked posture exists
- keep main-bucket assignment separate from shortlist authority
- expose downstream inspection-readiness without implying trade direction or setup quality
- use dirty routing and bounded sweeps instead of perpetual broad recompute
- publish Layer 3 artifacts atomically
- surface freshness and degraded posture honestly
- refuse hidden ranking, heavy-history, deep-analysis creep, or signal-language drift

If an implementation cannot explain why a symbol is currently eligible, ineligible, pending, or blocked, that implementation is incomplete.

---

## Stage 4 Layer 3 field-contract completion

This section completes the Layer 3 field contract.
If earlier wording is less explicit, this section wins.

### Doctrine tiers

#### Hard law
Layer 3 is a neutral gate.
It must not express trade direction, signal quality, attractiveness, or hidden shortlist preference.

#### Required product contract
Every Layer 3 publication must expose one complete and inspectable gate contract with state, code, reason, blocker taxonomy, retry posture, and next useful step.

#### Future expansion option
Future work may add richer blocker diagnostics, richer cheap normalization context, or richer survivor-bucket metadata.
Those remain optional unless later promoted into required law.

### Required Layer 3 fields

#### Eligibility core
- `symbol`
- `eligibility_state`
- `eligibility_code`
- `eligibility_reason`

`eligibility_state` must stay inside Layer 3 neutral families such as:
- `eligible`
- `ineligible`
- `pending`
- `blocked`
- `degraded`
- `stale`

#### Block taxonomy
- `block_type`
- `block_reason`

Canonical `block_type` families remain:
- `structural_block`
- `temporary_block`
- `data_quality_block`
- `market_quality_block`

If no block exists, Layer 3 should publish `none` or equivalent explicit non-block posture rather than leave the family ambiguous.

#### Retry and readiness posture
- `retry_posture`
- `next_useful_step`
- `downstream_readiness_state` where architecture retains readiness language

#### Diagnostics
- `diagnostic_failures`
- `evaluation_observed_at`
- `evaluation_published_at`
- `evaluation_freshness_state`

#### Survivor context
- `survivor_bucket` where the symbol is eligible
- `survivor_bucket_reason` where bucket assignment exists

### Optional Layer 3 enrichments
Optional enrichments may include:
- cheap threshold detail
- bounded normalized packet references
- richer blocker notes
- retry timing hints

Optional enrichments must never mutate gate neutrality.

### Always-visible consumer minimum
Any consumer rendering of Layer 3 must always show:
- eligibility state
- eligibility code
- operator-safe eligibility reason
- block type when blocked or degraded
- retry posture
- next useful step
- survivor bucket when eligible

### Neutrality reinforcement
`eligibility_reason`, `survivor_bucket`, and `next_useful_step` must remain neutral.
They may explain why the symbol passed or failed the gate and what bounded scanner action is sensible next.
They must not imply bullishness, bearishness, best-setup status, or final signal quality.

## Final standard

Layer 3 is correct when it turns earlier committed truth into honest, cheap, explainable eligibility and block truth without drifting into ranking, deep analysis, signal suggestion, or recompute sprawl.

That means Layer 3 must be:
- cheap
- explainable
- event-sensitive
- bucket-capable but not rank-capable
- gate-pure and neutral
- freshness-aware
- atomically committed
- hostile to hidden heaviness
- strict about upstream ownership

The standard is not that Layer 3 reduces symbol count.
The standard is that Layer 3 produces trustworthy eligibility truth that Layer 4 can consume without ambiguity.

