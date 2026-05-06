# ASC Five Layer System

## Purpose

This document defines the canonical five-layer system of Aurora Sentinel Scanner (ASC).

Its job is to make the ordered truth-construction model explicit, narrow, and enforceable.
The five layers are not branding language.
They are real ownership boundaries.
They determine:
- what kind of truth is being built
- what inputs are allowed
- what outputs may be published
- what cadence rights exist
- what downstream work may become eligible
- what remains forbidden even when nearby data already exists

The rebuild depends on this staying clear.
If the layers blur, ASC drifts back into a shapeless runtime that solves architecture inside pulses instead of inside design.

## Runtime implementation posture lock (current)

This file defines full five-layer doctrine, but current runtime implementation maturity is explicitly bounded:
- **Layer 1 Market State:** active runtime truth
- **Layer 2 Open Symbol Snapshot:** active runtime truth
- **Layer 3 Candidate Filtering:** active runtime truth
- **Layer 4 Shortlist Selection:** active runtime truth
- **Layer 5 Deep Selective Analysis:** scaffold only in runtime (future authority layer)

Layer 4 doctrine is now runtime-owned and active.
Layer 5 doctrine remains binding future law and must not be interpreted as an auto-active runtime claim.

---

## Core doctrine

Binding references:
- `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`
- `08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md`

### Ordered progression law
ASC constructs scanner truth in an ordered progression:

1. Layer 1 — Market State
2. Layer 2 — Open Symbol Snapshot
3. Layer 3 — Candidate Filtering
4. Layer 4 — Shortlist Selection
5. Layer 5 — Deep Selective Analysis

Layers 1-4 are the automatic preparation engine.
Layer 5 is HUD-armed and may continue semi-automatically once lawfully armed within admitted promoted scope.

This order is real.
A later layer may consume earlier truth.
A later layer may not silently recreate lower-layer truth just because it is due or because the needed fields seem nearby.

### Scan -> atomic commit -> consume law
Each layer follows the same structural progression:

1. acquire or derive its owned truth
2. stabilize that truth inside the layer’s owned runtime state
3. atomically commit publishable outputs when the layer’s publish conditions are met
4. allow downstream consumers to use the committed result under their own rules

This law exists to prevent mixed-cycle ambiguity.
ASC must not behave like a system where downstream layers consume half-formed upstream state merely because it already exists in memory.

### Single-owner law
Each layer owns one distinct truth domain.
If a truth domain appears to have two primary owners, the design is wrong until corrected.

### Narrowness law
A layer must remain narrow enough that its runtime identity stays intelligible.
A layer may not justify widening merely because it already touches adjacent fields.
Ownership creep is treated as architectural drift.

### Downstream eligibility law
When a layer finishes work, it may create downstream eligibility.
It does not create downstream entitlement.
That means a completed layer output may dirty a later layer, but the later layer must still earn its own admission under governor and cadence law.
Layer progression remains ownership-first, not page-driven.

### Consumer-surface law
HUD, dossiers, summaries, SIAM / Aurora, and other operator surfaces are not layers.
They are consumer surfaces.
They consume already owned truth or explicitly permitted tactical direct reads.
They do not gain lower-layer rights merely because they display the outputs.

### Signal-ownership law
ASC is a truth-producing scanner.
It never owns final trade signals.

ASC may produce only scanner-owned truth such as:
- market-state truth
- packet truth
- eligibility truth
- shortlist truth
- deep evidence
- bounded structural interpretation

ASC may not produce:
- final directional trade call
- execution verdict
- final signal classification
- entry command
- order instruction

SIAM / Aurora is downstream of ASC.
SIAM / Aurora consumes ASC truth and may produce:
- directional bias
- setup interpretation
- invalidation framing
- signal classification
- trade narrative
- execution-ready interpretation

### SIAM-consumption contract
SIAM / Aurora may consume only lawful committed ASC truth in layer order:
1. Layer 1 market-state truth
2. Layer 2 open-symbol snapshot truth
3. Layer 3 candidate filtering truth
4. Layer 4 shortlist / promotion truth
5. Layer 5 deep-analysis truth for promoted symbols only

From that consumed ASC truth, SIAM / Aurora may derive:
- bias
- setup quality
- invalidation logic
- trigger interpretation
- signal readiness
- signal classification
- risk framing

### Stage 1 doctrine-tier law
The Stage 1 doctrine freeze distinguishes three tiers and future work must preserve the distinction.


### Stage 3 control-surface law
Stage 3 freezes the trader-control distinction for layer-owned systems.

**Hard law**
- trader controls may configure lawful service scope and consumer output only
- trader controls may not grant new ownership to any layer
- Deep Analysis timeframe/bars/ATR/spread/tick settings configure Layer 5 service only
- no menu control may turn ASC into a signal engine

**Required product contract**
- menu/settings must expose explicit safety classes
- Layer 5 completeness must remain inspectable per enabled timeframe
- analyst-facing output modes remain consumer projection only

**Future expansion option**
- richer templates/presets
- additional timeframe families by later blueprint update
- downstream interpretation controls for SIAM-owned products only


**Hard law**
- signal ownership boundaries
- SIAM consumption boundaries
- Layer 3 neutrality and gate purity
- Layer 4 shortlist authority with attention-priority framing
- Layer 5 promoted-set-only + explicit-trigger + downstream-handoff direction

**Required product contract**
- operator/control/index surfaces must describe ASC as scanner truth producer, not signal engine
- product surfaces may show shortlist, promotion basis, deep evidence, and explicit handoff posture without pretending ASC already produced a signal
- downstream consumer wording must preserve SIAM / Aurora as interpretation authority

**Future expansion option**
- exact SIAM handoff field schema
- exact Market Board / Dossier / Current Focus interpretation-field contracts
- exact menu/settings additions for downstream interpretation products
- any later automation beyond currently admitted scope

---

## What a layer is

A layer is a bounded truth-construction owner.

Every layer must define:
- purpose
- owned truth
- upstream inputs
- runtime class
- publication rights
- freshness posture
- degraded behavior
- what it may not do
- what downstream layer it can dirty next

A layer is valid only when those boundaries are explicit.

---

## What a layer is not

A layer is not:
- a folder convenience
- a HUD page category
- a temporary build step name
- a generic compute bucket
- permission to perform any adjacent work that happens to be useful

If an implementation uses the word “layer” without mapping it to a real ownership boundary, that implementation is out of contract.

---

## Cross-layer laws

### Law 1 — Earlier truth first
No later layer may define truth that logically depends on an earlier layer while the earlier truth remains absent, ambiguous, or unowned.

### Law 2 — No backfill inversion
If Layer 4 notices that an upstream field is missing, Layer 4 does not get to compute that upstream field itself.
It may surface invalidity, remain blocked, or request upstream service through dirty routing, but it may not absorb upstream ownership.

### Law 3 — No downstream drag
A lower layer finishing work does not automatically drag all later layers into the same heartbeat.
Layer completion produces eligibility, not pile-on permission.

### Law 4 — Publication is layer-owned
Each layer may publish only its own artifact blocks.
A later layer may reference earlier layer results.
It may not rewrite earlier layer meaning.

### Law 5 — Layer state must be inspectable
Each layer must have visible runtime state that can answer:
- ready
- pending
- stale
- degraded
- blocked
- invalid
- recently committed

These states may be implemented differently per layer, but their posture must remain inspectable.

### Law 6 — Failure must stay local first
A failure in a later layer must not erase already-committed lower-layer truth.
Lower-layer last-good visibility must remain intact unless the lower layer itself became invalid.

---

## Layer interaction map

### Layer 1 -> Layer 2
Layer 1 provides market-state truth.
Layer 2 may only operate meaningfully after Layer 1 has determined whether a symbol is unknown, open confirmed, closed confirmed, or uncertain.
Layer 2 remains blocked unless Layer 1 has reached real warmup/readiness posture from Layer 1-owned evidence.
Layer 1 completion requires all of the following before broad Layer 2 widening is lawful:
- truthful market-state classification ownership is established
- state-driven next-due scheduling posture exists per symbol
- readiness/warmup ownership exists and is inspectable from Layer 1 truth
- first committed Layer 1 truth publication is landed with honest partial/full posture
Layer 1 completion may create downstream eligibility, but it does not auto-complete or auto-entitle Layer 2+ work.
Partial Layer 1 outputs alone must not be used to infer downstream widening entitlement.

### Layer 2 -> Layer 3
Layer 2 provides bounded packet truth for symbols admitted to snapshot service.
Layer 3 consumes that packet truth together with Layer 1 state to determine cheap eligibility.

### Layer 3 -> Layer 4
Layer 3 provides candidate status and bucket assignment.
Layer 4 consumes Layer 3 survivors to determine which symbols earn shortlist promotion.

### Layer 4 -> Layer 5
Layer 4 provides promoted-set truth and Layer 5 eligibility/readiness posture.
Layer 5 consumes only that admitted set and performs deeper selective analysis after lawful HUD Analyse / Deep Analysis arm.
Visibility alone is not activation.

Layer 4 hands off attention priority, inspection priority, and promotion priority only.
It does not hand off final signal ownership.

Layer 4 ownership is explicit:
- shortlist promotion entry/exit
- shortlist ranking
- hold behavior
- shortlist state and shortlist-context summary truth
- selection reason
- selection bucket
- correlation score used for shortlist/board summary posture

Layer 5 ownership is explicit:
- deeper rolling symbol intelligence
- multi-timeframe deep analysis
- deep continuity for admitted promoted members

Summary surfaces (including Market Board) must stop at Layer 4 shortlist summary depth and must not publish Layer 5 payload internals.

Strict Layer 5 decision order applies:
1. symbol must be in Layer 4 promoted set (hard gate)
2. service mode must be explicit HUD Analyse / Deep Analysis arm for that selected symbol
3. rank-sensitive cadence may schedule only within admitted symbols and never widen scope
4. demotion removes active entitlement immediately; only bounded continuity view may remain where explicitly allowed

Deep Analysis page-open/view is not a trigger and must not be interpreted as execution evidence.
Current Focus remains a selected-symbol consumer artifact and must follow selected-symbol context independently of whether Layer 5 was armed.

### Layer 5 -> Consumer surfaces
Layer 5 may enrich promoted symbols further, but it does not become the author of the whole scanner.
Its outputs join the committed truth stack and are then consumed by HUD, dossiers, summaries, and downstream operator surfaces.

Layer 5 is the last scanner-owned packet before SIAM / Aurora interpretation.
Scanner-owned output ends at deep evidence, deep context, and bounded structural interpretation.
Any final signal interpretation downstream of that handoff belongs to SIAM / Aurora, not ASC.

---

## Layer 1 — Market State

### Purpose
Layer 1 determines the live market-state posture of the symbol universe.
Its first responsibility is not richness.
Its first responsibility is truthfully answering whether symbols are open, closed, uncertain, or unknown.

### Owns
- universe-linked market-state classification
- open / closed / uncertain / unknown state
- broad market-state coverage progression
- cheap first-pass scan readiness
- confirmation checks for ambiguous or recently transitioning cases
- market-state freshness scheduling
- earliest boot readiness for the scanner

### Does not own
- open-symbol packet enrichment
- filter eligibility
- shortlist competition
- deep analysis
- dossier composition
- HUD authority

### Primary runtime class
- Scan

### Secondary bounded class
- Snapshot / Read only for minimal confirmation evidence where architecture explicitly allows it

### Inputs
- broker symbol universe
- direct market-watch observables
- limited session/availability context where appropriate
- previously committed Layer 1 continuity state as support only

### Outputs
- market-state block for each symbol
- last checked time
- next scheduled recheck time
- next-check reason
- confidence / ambiguity posture
- Layer 1 readiness contribution state

### State posture
Layer 1 must be able to mark a symbol as:
- unknown
- open confirmed
- closed confirmed
- uncertain
- stale
- degraded

Unknown and Uncertain are honest market-state outputs, not design failures.

### Layer 1 readiness law
ASC startup is won or lost by Layer 1.
Layer 1 is the boot gate because later work has no honest meaning until broad market-state truth exists.

Warmup exit must therefore depend primarily on Layer 1 readiness rather than on downstream enrichments.
Readiness is not declared from HUD richness, dossier fullness, or Layer 2 packet density.
Layer 1 readiness ownership includes truthful state coverage, state-driven scheduling posture, and inspectable partial/ready/degraded/stale posture.

### Publish law
Layer 1 must publish first.
It is the earliest canonical truth block and the first meaningful artifact for most symbols.
Publication must distinguish partial cycle posture from full cycle posture; partial publication is lawful but must never masquerade as full coverage.

### Invalid designs
- Layer 1 acting like a hidden filter
- Layer 1 slowed to tiny timid throughput and sold as performance discipline
- Layer 1 performing shortlist logic in the name of convenience
- Layer 1 waiting for HUD hydration before claiming readiness
- claiming Layer 1 completion merely because broad scanning exists, heartbeat is 1 second, packet targets exist, or partial artifacts are present without true state-engine ownership

---

## Layer 2 — Open Symbol Snapshot

### Purpose
Layer 2 builds a bounded current-state packet for symbols that have earned snapshot attention through Layer 1 truth and runtime posture.

Layer 2 is the open-subset expander.
It turns raw market availability into useful current packet truth without widening into later-layer ranking or deep analysis.

### Owns
- current packet fields for admitted symbols
- open-symbol packet freshness
- bid / ask / spread packet capture
- day-range and static tradability packet fields where assigned
- last-good continuity for Layer 2-owned packet outputs
- focused-symbol tactical refresh where explicitly authorized

### Does not own
- universe-wide state acquisition
- candidate filtering
- shortlist policy
- deep analysis
- dossier authorship

### Primary runtime class
- Snapshot / Read

### Secondary bounded class
- Persistence / Write only after packet readiness is reached and only for Layer 2-owned committed outputs

### Inputs
- Layer 1 market-state truth
- direct packet source fields for admitted symbols
- prior committed Layer 2 continuity state as support only

### Outputs
- Layer 2 packet block
- packet freshness markers
- last built time
- continuity / degraded markers for packet-owned fields

### Admission posture
Layer 2 should focus on the open subset or other explicitly admitted subset.
It must not widen into a broad-universe same-speed refresh loop.

### Focus law
Layer 2 may support focused-symbol tactical refresh for owned packet fields only.
That tactical right does not authorize Layer 3, Layer 4, or Layer 5 work.

### Invalid designs
- Layer 2 refreshing every visible symbol at focus-page speed
- Layer 2 acting like a shortlist engine
- Layer 2 using missing upstream ownership as a reason to invent it
- Layer 2 dragging broad write waves into every read pulse

---

## Layer 3 — Candidate Filtering

### Purpose
Layer 3 consumes earlier truth and decides which symbols remain eligible for further consideration under cheap filtering doctrine.

Layer 3 is the gate.
It is not the shortlist.
It is not a proxy ranking engine.

### Owns
- candidate eligibility state
- cheap rule evaluation
- gate reason codes
- filter freshness state
- bucket assignment for surviving candidates where architecture assigns that role
- dirty-to-clean transitions for filter state

### Does not own
- market-state acquisition
- broad packet enrichment
- selection authority
- deep analysis
- dossier composition

### Primary runtime class
- Calculation / Gate

### Secondary bounded class
- Persistence / Write only for Layer 3-owned results after evaluation is complete

### Inputs
- Layer 1 market-state truth
- Layer 2 packet truth
- previously committed Layer 3 state where useful for stability and transition handling

### Outputs
- eligible / ineligible / pending / degraded state
- reason codes
- assigned main bucket for survivors
- blocker classification where applicable
- downstream inspection-readiness posture
- last evaluated time

### Doctrine
Layer 3 must stay cheap, gate-pure, and honest.
It may use existing truth.
It may determine eligibility, blocking reasons, downstream readiness for inspection, and bounded diagnostic failures.
It may not imply trade direction, setup attractiveness, or signal quality.
It may not rescue itself by widening into heavy reads or deep historical pulls.

### Invalid designs
- Layer 3 performing ranking and calling it filtering
- Layer 3 pulling deep history to compensate for missing cheap inputs
- Layer 3 composing shortlist-like outputs directly

---

## Layer 4 — Shortlist Selection

### Purpose
Layer 4 selects a bounded promoted set from Layer 3 survivors.

This is the first layer that changes which symbols receive privileged downstream attention.
That makes it logically heavy even when the raw computation is not large.

### Owns
- shortlist authority
- promotion entry and exit
- top-per-bucket rules
- spill / fill logic
- anti-churn behavior
- hold-window logic
- selected-set state transitions
- shortlist invalidity / material-shift posture

### Does not own
- broad symbol discovery
- open-symbol packet refresh
- cheap filter evaluation
- deep analysis itself
- dossier authorship

### Primary runtime class
- Promotion / Selection

### Secondary bounded class
- Persistence / Write only for selection results once the selection event is complete

### Inputs
- Layer 3 survivor set
- Layer 3 bucket assignments and gate results
- previously committed Layer 4 state for hold behavior and stability evaluation

### Outputs
- selected / not selected
- position within bucket or selected set where defined
- hold posture
- shortlist basis metadata
- promotion-basis metadata
- promotion-denial reason where applicable
- last shortlist evaluation time
- invalid / material-shift / stable state markers

### Doctrine
Layer 4 should usually be calm.
It is not supposed to wake up every time upstream truth twitches.
It exists to produce a stable promoted set, not a permanently churning leaderboard.

Layer 4 ranking semantics are attention priority, inspection priority, and promotion priority only.
Layer 4 does not declare the “best trade”.
Layer 4 does not own final signal strength.

Layer 4 summary calculations (including shortlist-context regime/ATR/correlation summaries used by board-grade surfaces) must stay bounded and lightweight:
- bounded timeframe count
- bounded history depth
- no deep rolling packet ownership transfer

### Invalid designs
- shortlist rebuild because a HUD page opened
- shortlist rebuild because hold expired even though nothing material changed
- Layer 4 serving as a live recalculation loop every pulse
- Layer 4 widening into deep-analysis service itself

---

## Layer 5 — Deep Selective Analysis

### Purpose
Layer 5 maintains deeper rolling truth only for the promoted set selected by Layer 4.

Layer 5 is intentionally narrow.
It exists to enrich the chosen few, not to widen back into the full symbol universe.

### Owns
- deep packet freshness for promoted symbols
- rank-sensitive deep service policy
- deeper timeframe or analysis packets where architecture assigns them
- deep continuity markers and degraded state for promoted deep outputs

### Does not own
- broad discovery
- candidate filtering
- shortlist authority
- global persistence policy
- dossier authorship for the entire scanner

### Primary runtime class
- Deep Analysis

### Secondary bounded class
- Persistence / Write only for Layer 5-owned deep outputs after admitted deep work completes

### Inputs
- Layer 4 selected/promoted set
- earlier committed truth from Layers 1 through 4 as needed
- prior committed Layer 5 continuity state for stability support only

### Outputs
- deep packet blocks for promoted symbols
- rank / cadence metadata where required
- last refreshed time
- stale / degraded / last-good continuity posture for deep outputs
- analyst-handoff / SIAM-handoff readiness posture

### Doctrine
Layer 5 must remain selective.
If Layer 5 widens into broad service, the architecture has broken.

Layer 5 owns deep evidence, deep context, and bounded structural interpretation only.
It is the last scanner-owned packet before downstream analyst / SIAM interpretation.
Layer 5 must end in a downstream interpretation handoff direction, not in scanner-owned signal output.
The final handoff field schema is future work and is not frozen in this Stage 1 pass.

Layer 5 calculations are explicitly the deeper/heavier lane.
Layer 5 may use richer timeframe depth and rolling preservation under Layer 5 doctrine, but this must not back-propagate heavy requirements into Layer 4 summary lanes.

Stage 3 control doctrine further freezes that trader controls over timeframe enablement, bars requested, ATR, spread, tick windows, and analyst-facing output modes are Layer 5 configuration only. Those controls must never alter Layer 4 shortlist authority, final signal ownership, or downstream SIAM interpretation ownership.

### Entitlement state machine and trigger law
Layer 5 entitlement posture must be explicit and inspectable as:
- `NOT_ENTITLED`
- `PROMOTED_NOT_ARMED`
- `HUD_ARMED`
- `ACTIVE`
- `ACTIVE_RANK_SCHEDULED`
- `DEMOTED_CONTINUITY_ONLY`
- `EXPIRED_NOT_ENTITLED`

State transitions must follow promotion/admission law, explicit trigger law, and demotion law.
Rank changes may alter cadence scheduling inside admitted scope, but never admission itself.

Dirty/write trigger expectations by entitlement state:
- `NOT_ENTITLED`: dirty entitlement-change consumers and clear queue tokens; no deep-build writes
- `PROMOTED_NOT_ARMED`: dirty on-demand eligibility/readiness only; optional admission metadata write
- `HUD_ARMED`: dirty deep-work queue and downstream eligibility-pending; write only after material deep change
- `ACTIVE`: dirty active deep execution status only; write only after material deep change
- `ACTIVE_RANK_SCHEDULED`: dirty scheduler ordering metadata; write cadence metadata only
- `DEMOTED_CONTINUITY_ONLY`: dirty continuity/degraded surfaces and cancel active jobs; bounded continuity marker write only
- `EXPIRED_NOT_ENTITLED`: dirty continuity-clear posture; optional expiry marker write only

### Invalid designs
- deep service for every open symbol
- deep refresh triggered by page visibility alone
- Layer 5 quietly assuming selection authority because promoted data is already nearby
- heartbeat/layer progression reinterpreted into one tiny once-per-second packet
- HUD visibility treated as Layer 5 execution authority

---

## Layer state model

Every layer must define a visible state model suitable to its role.
The exact internal names may vary, but the architecture must preserve these postures where relevant:

- not admitted
- pending
- building
- ready
- committed
- stale
- degraded
- blocked
- invalid

Not every layer needs every state at all times, but each layer must be inspectable enough that the runtime can explain what is happening without resorting to guesswork.

---

## Publication order

ASC publication order follows the layer order.
The canonical publication stack is:

1. Layer 1 market-state block
2. Layer 2 open-symbol snapshot block
3. Layer 3 candidate filtering block
4. Layer 4 shortlist selection block
5. Layer 5 deep selective analysis block
6. consumer-surface compositions after those committed blocks exist

This order exists because operator trust depends on lower truth landing before richer downstream surfaces attempt to summarize it.

---

## Degraded behavior by layer

### Layer 1 degraded posture
If Layer 1 is degraded, the system must show uncertainty honestly.
It must not pretend readiness it has not earned.

### Layer 2 degraded posture
If Layer 2 is degraded, the system may continue to show last-good packet continuity where allowed, but it must surface packet staleness or degradation clearly.

### Layer 3 degraded posture
If Layer 3 is degraded, shortlist eligibility must remain pending or stale rather than silently guessed.

### Layer 4 degraded posture
If Layer 4 is degraded, the system may keep the last committed shortlist visible with clear stale or hold posture, but must not silently promote new members without a valid selection event.

### Layer 5 degraded posture
If Layer 5 is degraded, earlier layers remain valid.
Deep truth may show stale or degraded state without erasing already-committed upstream truth.

---

## Build-sequence implications

The five-layer system also defines the correct implementation order.
ASC should be built outward from lower truth toward richer truth:

1. Layer 1 first
2. Layer 2 next
3. Layer 3 after Layer 2 truth is stable
4. Layer 4 after Layer 3 survivor truth is stable
5. Layer 5 only after Layer 4 selection authority is stable

If implementation starts by widening Layer 4 or Layer 5 before the earlier layers are trustworthy, the build sequence is wrong.

---

## Invalid global patterns

The following are architecturally invalid regardless of implementation convenience:

- a later layer rebuilding lower-layer truth because the needed data is nearby
- HUD visibility authorizing lower-layer or later-layer service
- dossier composition used as the birthplace of layer truth
- multi-layer blended pulses treated as normal steady-state behavior
- deep-analysis widening into universe-scale refresh
- shortlist selection treated as a constant every-pulse maintenance act
- lower-layer ambiguity hidden behind richer downstream wording

---

## Stage 4 field-contract completion lock

Stage 4 completes the field-contract doctrine for Layers 1 through 5 and freezes the ASC-to-SIAM handoff boundary.

If any earlier wording in this file or in subordinate consumer docs is vaguer than the field-contract doctrine below, the Stage 4 doctrine wins.

### Doctrine tier lock

#### Hard law
- Every layer must publish one explicit field contract with named required fields, explicit optional enrichments, and explicit degraded / stale / unavailable posture.
- Required fields may not be suppressed by output-mode convenience, UI brevity, or partial-build optimism.
- Optional enrichments may enrich consumer understanding, but they must never become hidden prerequisites for lawful minimum publication.
- Future expansion fields must remain clearly labeled so roadmap ideas do not masquerade as current product law.
- Observed truth and interpreted truth must not be silently fused where both exist, especially in Layer 5.
- ASC may hand SIAM bounded directional posture and readiness framing only through the lawful handoff contract; ASC must not issue the final signal, execution verdict, or trade command.

#### Required product contract
- Layer 1 publishes complete market-state contract fields.
- Layer 2 publishes complete open-symbol packet contract fields.
- Layer 3 publishes complete neutral gate contract fields.
- Layer 4 publishes complete attention-shortlist contract fields.
- Layer 5 publishes the full ordered deep-analysis subsection contract plus the final SIAM / analyst handoff block.
- Consumer artifacts must preserve mandatory fields even when rendering compactly.

#### Future expansion option
Later work may add:
- richer diagnostics
- richer continuity telemetry
- richer optional evidence families
- richer handoff enrichments
- schema versioning / contract hashes

Future expansion may not weaken Hard Law or erase the required minimum field contracts.

## Canonical field-contract map (Stage 4 authority)

### Layer 1 — Market State
Layer 1 publishes observed market-state truth only.
It must always expose:
- classification state
- classification code
- operator-safe classification reason
- freshness posture
- confidence posture
- next-check / recheck posture
- degraded / failure / uncertain posture

It may additionally expose bounded explanation, confirmation notes, and recovery metadata.
It must not expose shortlist logic, attraction logic, or deep-analysis implication.

### Layer 2 — Open Symbol Snapshot
Layer 2 publishes observed packet truth only.
It must always expose:
- bid
- ask
- spread
- spread percentage or explicit unsupported posture
- tick age
- packet freshness
- continuity / degraded posture
- day-range packet posture
- tradability / specification packet posture

It may additionally expose bounded rolling packet metrics and compact packet diagnostics.
It must not expose ranking, promotion, or deep-analysis meaning.

### Layer 3 — Candidate Filtering
Layer 3 publishes neutral eligibility truth only.
It must always expose:
- `eligibility_state`
- `eligibility_code`
- `eligibility_reason`
- `block_type` where blocked or degraded posture exists
- `retry_posture`
- bounded diagnostic failures
- survivor bucket assignment where applicable
- next useful step

It may additionally expose downstream readiness posture and compact support diagnostics.
It must not expose trade direction, setup attractiveness, or signal-quality implication.

### Layer 4 — Shortlist Selection
Layer 4 publishes attention-priority shortlist truth only.
It must always expose:
- `selection_state`
- attention priority / shortlist rank framing
- shortlist posture
- shortlist reason
- bucket context
- promotion basis or denial reason
- what must change to enter or re-enter
- hold / stability / churn posture
- correlation / exposure posture
- shortlist freshness / stability posture

It may additionally expose stable attention-order context and cross-bucket comparison metadata.
It must not claim signal superiority, best-trade ownership, or final trade ranking.

### Layer 5 — Deep Selective Analysis
Layer 5 publishes promoted-symbol deep evidence and bounded interpretation only.
It must always expose the ordered subsections:
1. `deep_analysis_overview`
2. `timeframe_settings`
3. `bar_pack`
4. `ohlc_by_enabled_timeframe`
5. `bar_interpretation`
6. `recent_tick_activity`
7. `live_spread_rollover`
8. `preservation_state`
9. `microstructure_notes`
10. `advanced_context`
11. `decision_support`
12. `siam_analyst_handoff`

Layer 5 must distinguish:
- observed truth: direct evidence such as OHLC, ATR, spread, tick, levels, copied/missing counts, freshness, and continuity
- interpreted truth: bounded scanner-owned interpretation such as compression, expansion, alignment, conflict, invalidation posture, and scenario posture

Layer 5 ends in handoff direction only.
It must not become the final signal engine.

## Canonical SIAM / analyst handoff boundary

ASC may hand SIAM / analyst only the lawful handoff contract created from committed Layer 1 through Layer 5 truth.

### Required handoff fields
The final handoff block must expose at minimum:
- `directional_posture`
- `alignment_posture`
- `volatility_posture`
- `friction_posture`
- `invalidation_reference`
- `constructive_reference`
- `danger_reference`
- `watch_next_reference`
- `analyst_readiness_state`
- `signal_interpretation_allowed`

### Handoff prohibition law
The handoff block must never contain:
- final trade verdict
- buy / sell command
- execution command
- order instruction
- final signal ownership
- hidden signal score presented as conclusion

### Handoff meaning law
The handoff block exists so SIAM / analyst can continue from lawful ASC truth without recomputing the scanner or confusing evidence with final interpretation.


## Stage 5 cross-file consolidation lock

This file now acts as the cross-file doctrine anchor for the whole Stage 1–5 stack.

### Hard law
- ASC / EA is the truth producer and does not own the final trade signal.
- SIAM / Aurora is downstream interpretation authority and consumes lawful Layer 1–5 truth in order.
- Layer 3 owns only eligibility / block / retry / survivor truth and remains direction-neutral.
- Layer 4 owns attention-priority shortlist selection and does not rank “best trade”.
- Layer 5 is promoted-only, explicit-trigger, deep evidence ending in analyst / SIAM handoff rather than final signal ownership.
- Market Board, Dossier, Current Focus, HUD, and menu/settings are consumer/control surfaces only and must not become hidden truth owners.

### Required product contract
Cross-file wording for the active blueprint stack must preserve all of the following:
- Market Board stops at Layer 4 depth.
- Dossier is the full per-symbol intelligence artifact.
- Current Focus is the singleton selected-symbol working artifact.
- menu/settings configure lawful service/output only.
- consumer surfaces may expose Layer 5 readiness or handoff posture only if they do not reinterpret it into a final trade verdict.

### Future expansion option
Later implementation may enrich presentation, schema detail, or downstream SIAM wiring, but it must not alter the ownership map above unless a deliberate doctrine pass explicitly reopens it.


## Final standard

The ASC layer system must remain understandable under pressure.
That means:
- each layer has one real job
- each layer publishes only its own truth
- each layer can fail locally without collapsing the whole stack
- later layers never gain permission to rewrite earlier truth
- downstream consumers do not become hidden authors

The standard is not merely that the scanner produces outputs.
The standard is that the path by which those outputs came into existence remains explicit, bounded, and trustworthy.
