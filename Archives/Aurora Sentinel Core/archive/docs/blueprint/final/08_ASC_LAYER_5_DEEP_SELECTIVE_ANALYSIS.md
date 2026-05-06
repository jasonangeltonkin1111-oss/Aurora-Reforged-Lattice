# ASC Layer 5 Deep Selective Analysis

## Runtime implementation posture lock (current)

Layer 5 in this file is canonical future doctrine.
Current runtime implementation posture is **scaffold only** for Layer 5:
- no live deep-analysis authority claims are admissible
- no active/admissible deep runtime posture claims are admissible
- operator surfaces must use explicit non-active wording until Layer 5 is explicitly implemented

This document remains normative for future Layer 5 implementation admission.

## Purpose

This document defines the canonical design of Layer 5 in Aurora Sentinel Scanner (ASC).

Layer 5 is the deep-selective-analysis owner.
Its job is to consume the promoted set from Layer 4 and answer the next bounded question honestly:

> for the symbols that have earned privileged attention, what deeper rolling truth should ASC maintain now?

Layer 5 exists to enrich the selected few.
It does not exist to widen back into the whole universe.
It does not exist to become a second scanner hidden behind richer language.

Layer 5 is the deep selective layer.
It is not discovery.
It is not packet construction.
It is not candidate filtering.
It is not shortlist authority.

---

## Core doctrine

### Global-vs-on-demand separation law
Layers 1 through 4 are the global continuous engine of ASC using operator-facing product naming:
- Market Status
- Open Symbol Snapshot
- Selection Filter
- Shortlist

These layers are allowed to run continuously across the symbol universe under the governed runtime model.

Deep Analysis is different.
It must not run globally, must not auto-run across the full universe, and must not be treated as a normal heartbeat-loop entitlement.
Its cost shape is separate precisely because its activation law is separate.

### Promoted-set-only law
Layer 5 may operate only on the currently promoted set admitted by Layer 4.

This is its central boundary.
If Layer 5 widens into non-promoted symbols under normal runtime, the architecture has broken.

### Deep-is-narrow law
Layer 5 is allowed to be more expensive than earlier layers precisely because it is narrow.
Its privilege comes from selectivity.
Its cost is justified only because its scope is constrained.

### On-demand activation law
Layer 5 is HUD-armed for selected symbol context.
Analyse / Deep Analysis is the canonical arm action.
That activation must apply only to the chosen symbol and remain isolated from global processing.

Deep Analysis must not:
- run automatically merely because runtime is alive
- run across all symbols as a background entitlement
- degrade global runtime performance by leaking back into the broad heartbeat path
- auto-run merely because a symbol page is open

HUD attention may request Deep Analysis.
It may not silently turn Deep Analysis into a universe-wide service.

### HUD-arm and semi-auto continuation law
Layer 5 is armed only through lawful HUD Analyse / Deep Analysis request.
Opening a symbol page alone does not auto-run Layer 5.
Once armed, Layer 5 may continue semi-automatically for that selected/promoted symbol or admitted promoted set.
Semi-auto continuation must not widen scope beyond admitted promoted symbols.

### Enrichment-not-authority law
Layer 5 enriches promoted members.
It does not decide which symbols deserve promotion.
It may expose deep truth about promoted symbols.
It may not quietly turn that truth into hidden selection authority.

### Scanner-handoff law
Layer 5 is the last scanner-owned packet before downstream interpretation.
It owns deep evidence, deep context, and bounded structural interpretation only.
It does not own final directional trade calls, execution verdicts, final signal classification, entry commands, or order instructions.

### Rank-sensitive service law
Layer 5 may use rank-sensitive or priority-sensitive service cadence inside the admitted promoted set.
This is allowed because not every promoted symbol needs the same deep-service frequency.

But rank-sensitive service must remain within Layer 5’s admitted scope.
It must not be used as a justification to widen service to non-promoted symbols.

### Deep-does-not-outrun-foundation law
Layer 5 depends on the validity of earlier layers.
If Layer 1 through Layer 4 are stale, invalid, degraded, or absent in ways that break trust, Layer 5 must not pretend to be authoritative just because its own fields look rich.

### Calmness-through-selectivity law
Layer 5 should be active only where its depth adds real value.
It must not become a constant broad heavy wave that overshadows the foundational layers.

---

## Stage 3 Deep Analysis control contract

Stage 3 freezes the lawful control surface for Layer 5.
These controls configure **how Deep Analysis attempts promoted-symbol enrichment**.
They do not alter admission ownership, shortlist ownership, or signal ownership.

### Doctrine tiers

**Hard law**
- control changes affect only Layer 5 service configuration and consumer projection
- custom ad hoc timeframe families are not admitted in this stage
- enabled timeframes are best-effort but must publish explicit sufficiency posture
- missing or insufficient bars must remain inspectable
- ATR / spread / tick controls are evidence controls, not signal controls
- analyst-facing output modes are consumer projection only

**Required product contract**
- canonical timeframe list
- explicit enable/disable per timeframe
- explicit requested/copied/missing/sufficiency fields per enabled timeframe
- explicit ATR / spread / tick sample sufficiency posture
- explicit handoff-block visibility controls without SIAM-owned conclusions

**Future expansion option**
- additional timeframe families
- richer indicator families
- more output presets
- per-asset-class profile bundles

### Canonical timeframe list
The canonical Deep Analysis timeframe list is locked to:
- `M1`
- `M5`
- `M15`
- `H1`
- `H4`
- `D1`

### Timeframe enablement law
Each timeframe must have explicit enable/disable posture.
Disabled timeframes are lawful and must publish as `not_enabled`.

Partial timeframe completion is lawful.
Deep Analysis does not become invalid merely because some enabled timeframe blocks are still pending or degraded.
It becomes invalid only where a specific enabled timeframe falls below its declared minimum sufficiency and the artifact hides that fact.

### Bars-per-timeframe law
For every enabled timeframe, Layer 5 must surface:
- `bars_requested`
- `minimum_bars_required`
- `bars_copied`
- `bars_missing`
- `sufficiency_posture`

Canonical sufficiency posture values:
- `not_enabled`
- `pending`
- `sufficient`
- `degraded_but_publishable`
- `insufficient_invalid`
- `unavailable`

`bars_requested` is the operator target.
`minimum_bars_required` is the validity floor.
`bars_copied` is the actual retrieved count.
`bars_missing` is the explicit shortfall against requested depth.

A timeframe block may publish as `degraded_but_publishable` when requested depth was missed but minimum sufficiency was met.
A timeframe block is `insufficient_invalid` when copied bars remain below minimum sufficiency.

### ATR / spread / tick evidence law
Layer 5 may expose trader controls for:
- ATR enablement, period, and shared-vs-per-timeframe scope
- rolling spread enablement, window size, and minimum samples
- recent tick enablement, window length, and minimum samples

These controls configure evidence collection only.
They do not grant:
- directional verdict rights
- trigger timing authority
- execution ownership
- hidden signal scoring

### Analyst-facing output law
The trader may configure output projection such as:
- `full_evidence_pack` vs `compact_analyst_brief`
- whether OHLC bars are printed
- maximum OHLC bars printed
- whether ATR / spread / tick / support-resistance / scenario / handoff blocks are shown

These controls affect consumer projection only.
They must never manufacture new truth or suppress mandatory freshness/completeness metadata.

---

## What Layer 5 owns

Layer 5 owns:
- deep packet truth for promoted symbols
- deeper rolling analysis state for promoted symbols
- rank-sensitive deep-service cadence within the promoted set
- deep freshness state
- deep continuity / last-good posture for Layer 5-owned fields where architecture permits it
- deep stale / degraded visibility
- Layer 5 committed deep artifact block
- deep submode posture for promoted members where assigned
- analyst-handoff / SIAM-handoff readiness posture

Layer 5 owns deep truth itself.
It does not merely decorate other layers.

---

## What Layer 5 does not own

Layer 5 does not own:
- universe-wide discovery
- market-state acquisition
- open-symbol packet construction
- candidate filtering
- shortlist membership authority
- dossier authorship for the entire scanner
- HUD composition
- final directional trade call
- execution verdict
- final signal classification
- entry command
- order instruction
- menu-owned signal steering
- hidden output-mode signal scoring
- global persistence policy beyond its own committed artifact block
- lower-layer truth repair

If Layer 5 starts widening into any of these roles, the architecture is drifting.

---

## Primary runtime class

Layer 5 primary runtime class:
- **Deep Analysis**

Layer 5 secondary bounded class:
- **Persistence / Write** only after admitted deep work completes and only for Layer 5-owned outputs

Layer 5 must remain a deep-analysis layer.
It must not disguise broad scanning, selection, or presentation logic as deep service.

---

## Layer 5 inputs

Layer 5 may consume:
- Layer 4 selected/promoted set
- Layer 1 through Layer 4 committed truth as support context
- promoted-member packet truth from earlier layers
- architecture-defined deeper source inputs needed for promoted analysis
- prior committed Layer 5 continuity state as support only
- bounded rank or priority posture assigned by Layer 4 or architecture-defined promotion state

Layer 5 must not require itself to decide who belongs in the promoted set.
That decision must already exist upstream.

---

## Layer 5 outputs

Layer 5 produces the canonical deep-analysis block for promoted symbols.
Its outputs may include:
- deep packet or deep analysis fields assigned by architecture
- promoted deep freshness state
- deep rank or service-priority metadata where assigned
- last refreshed time
- stale / degraded posture
- continuity / last-good markers where applicable
- deep subpacket freshness markers where architecture defines multiple deep surfaces
- analyst-handoff / SIAM-handoff readiness posture

Layer 5 outputs must remain rich enough to justify their existence and bounded enough to land calmly.

---

## Admission doctrine

### Admission depends on Layer 4
Layer 5 is meaningful only for symbols currently admitted by Layer 4’s selected set.
If a symbol is not promoted, Layer 5 has no normal-service authority over it.

### Promotion loss removes deep entitlement
If a symbol leaves the promoted set, Layer 5 may preserve prior committed continuity history where architecture allows, but it loses ongoing deep-service entitlement.

### Recovery exceptions must stay explicit
If architecture later allows limited recovery handling for recently demoted or transitioning members, that handling must remain explicit, bounded, and temporary.
It must not become quiet scope creep.

### Strict entitlement decision order
Layer 5 entitlement must evaluate in this strict order and stop on first failing gate:

1. symbol must be in the current Layer 4 promoted set (**hard gate**)
2. service mode must be explicit HUD Analyse / Deep Analysis arm for that selected symbol
3. rank-sensitive cadence may schedule **within admitted symbols only** and must never widen scope
4. demotion immediately removes active entitlement; only bounded continuity-view remains where explicitly allowed

No later gate may override an earlier gate failure.
Rank, focus, UI urgency, or stale pressure may influence service timing only after promotion admission is true.

### Entitlement state machine and triggers
Layer 5 entitlement must stay inspectable through explicit states with explicit transition triggers.

#### State A — `NOT_ENTITLED`
- meaning: symbol is not in promoted set; no active deep service rights
- enter when: symbol never promoted, promotion revoked, or promoted-set snapshot no longer contains symbol
- dirty trigger on entry: clear active deep-service queues/tokens for symbol; emit entitlement-change dirty flag for Layer 5 consumers
- write trigger on entry: none required for new deep build; only optional bounded continuity marker write if previously committed deep truth exists

#### State B — `PROMOTED_NOT_ARMED`
- meaning: symbol is promoted and admitted, but no lawful Analyse arm has been issued
- enter when: symbol newly appears in promoted set or prior arm is revoked
- dirty trigger on entry: mark symbol eligible for on-demand deep request routing; do not enqueue automatic deep build
- write trigger on entry: optional entitlement metadata write (promoted=true, armed=false, active=false) without deep recompute

#### State C — `HUD_ARMED`
- meaning: symbol is promoted and has a lawful HUD Analyse / Deep Analysis arm request
- enter when: valid Analyse arm arrives while symbol remains promoted and eligible
- dirty trigger on entry: enqueue Layer 5 deep-work build/refresh for that symbol; mark downstream consumer eligibility as pending
- write trigger on entry: none until deep work produces material structural change

#### State D — `ACTIVE`
- meaning: symbol is promoted, armed, and currently in active deep service
- enter when: HUD_ARMED work admission begins
- dirty trigger on entry/change: update active deep work status and bounded retry posture
- write trigger on entry/change: none until deep work produces material structural change

#### State E — `ACTIVE_RANK_SCHEDULED`
- meaning: symbol remains active and is currently scheduled under rank-sensitive cadence inside admitted scope
- enter when: active symbol receives tiered cadence assignment inside promoted set
- dirty trigger on entry/change: update Layer 5 scheduler queue ordering/next-refresh budget for admitted symbols only
- write trigger on entry/change: write cadence metadata only (rank/tier/next_due), never scope/admission expansion

#### State F — `DEMOTED_CONTINUITY_ONLY`
- meaning: symbol lost promotion; no ongoing deep service; last-good deep block may remain viewable with explicit continuity posture
- enter when: symbol leaves promoted set from any promoted/armed/active state
- dirty trigger on entry: cancel deep refresh jobs; dirty only continuity/degradation surfaces and entitlement-change consumers
- write trigger on entry: bounded continuity/degraded marker write if last-good deep block exists; never start new deep rebuild

#### State G — `EXPIRED_NOT_ENTITLED`
- meaning: continuity window closed or continuity unavailable; symbol fully returns to non-entitled posture
- enter when: continuity TTL/window expires or continuity policy disallows further visibility
- dirty trigger on entry: clear continuity-visible flags
- write trigger on entry: optional final tombstone/expiry marker; no deep content writes

Allowed high-level transitions:
- `NOT_ENTITLED -> PROMOTED_NOT_ARMED`
- `PROMOTED_NOT_ARMED -> HUD_ARMED`
- `HUD_ARMED -> ACTIVE`
- `ACTIVE -> ACTIVE_RANK_SCHEDULED`
- `ACTIVE_RANK_SCHEDULED -> ACTIVE` (cadence class downgrade/change)
- `PROMOTED_NOT_ARMED|HUD_ARMED|ACTIVE|ACTIVE_RANK_SCHEDULED -> DEMOTED_CONTINUITY_ONLY`
- `DEMOTED_CONTINUITY_ONLY -> EXPIRED_NOT_ENTITLED`
- `EXPIRED_NOT_ENTITLED -> PROMOTED_NOT_ARMED` (only via new promotion event)

Forbidden transitions:
- `NOT_ENTITLED -> ACTIVE` without fresh promotion admission and Analyse arm
- `PROMOTED_NOT_ARMED -> ACTIVE` without Analyse arm
- any visible-only or focus-only trigger to `HUD_ARMED`
- any `DEMOTED_* -> ACTIVE_*` without re-promotion and new Analyse arm
- any state change that treats rank changes as admission changes

---

## Deep-scope doctrine

### Deep scope must be intentional
Layer 5 should own only the deeper analysis surfaces that truly belong at the promoted-set level.
That may include:
- richer timeframe packets
- deeper rolling structure
- promoted-only analytical fields
- deeper stability or context measures

What matters is not the exact field list here.
What matters is the boundary:
Layer 5 owns deeper promoted-set truth, not general-purpose universe truth.

### Deep scope must not absorb everything useful
A field is not automatically a Layer 5 field merely because it is useful or more sophisticated.
If a field belongs naturally to Layer 2 or Layer 3, it must stay there.

### Deep scope must remain operationally worthwhile
Layer 5 should exist only for depth that materially improves promoted-set understanding.
It must not become a prestige layer full of expensive but directionless data.

---

## Rank-sensitive cadence doctrine

### Why rank-sensitive cadence exists
Not every promoted symbol requires the same deep-service frequency.
A selected set often contains members of different practical relevance.
Layer 5 may therefore prioritize deeper refresh cadence by rank or equivalent service tier.

### Rank-sensitive service must remain bounded
Rank-sensitive cadence may influence:
- how often a promoted member receives deep refresh
- which deep subpackets are refreshed sooner
- how deep backlog is serviced under pressure

Rank-sensitive cadence may not influence:
- shortlist membership authority
- rights for non-promoted symbols
- permission to bypass persistence calmness

### Rank-sensitive cadence should not become frantic
Even the highest-priority promoted member should not drag Layer 5 into continuous pulse-hungry behavior that overwhelms the rest of the runtime.
Layer 5 remains bounded by governor law.

### Example posture
Architecture may later define service postures such as:
- higher rank = more frequent deep refresh
- lower rank = calmer deep refresh

The exact numbers may evolve later.
The law that survives is:
**cadence may differ by promoted priority, but scope must remain promoted-set only.**

---

## Freshness doctrine

### Freshness is central to deep truth
Because Layer 5 produces richer rolling truth, it must always know whether its outputs are:
- fresh
- aging
- stale
- degraded
- continuity-backed
- pending refresh

### Freshness is not uniformity
Different deep subpackets may have different service cadence.
That is acceptable as long as Layer 5 exposes freshness posture honestly and does not blur old and new deep truth into one ambiguous surface.

### Deep freshness must remain inspectable
The system should be able to explain:
- when a promoted symbol’s deep truth was last refreshed
- which parts are fresher or staler if the deep block has internal tiers
- whether the shown deep truth is newly refreshed or last-good continuity-backed

---

## Scheduling doctrine

### Layer 5 should be promoted-wave driven
Layer 5 service is best understood as promoted-set refresh waves rather than constant everywhere activity.

### Service should respect rank, backlog, and governor posture
Layer 5 should schedule deep work based on:
- current promoted membership
- rank-sensitive cadence or service tier
- stale/degraded pressure inside the promoted set
- available deep-service budget under the governor

### Layer 5 should not wake for cosmetic reasons
Layer 5 should not wake because:
- a detail page was opened
- a dossier was read
- a heartbeat happened
- a non-promoted symbol looks interesting
- a tactical HUD field changed

### Calmness is achieved by narrowness
A healthy Layer 5 may be active, but its activity should remain contained because its scope is small and justified.

### Anti-drift enforcement
- Layer 5 semi-auto must never be reinterpreted as scanner-global background entitlement.
- visibility/focus alone is not activation.
- HUD is not the compute owner; it is the arm/request surface.

---

## Focus doctrine

### Focus does not grant deep entitlement
A focused symbol page does not create Layer 5 rights for a symbol that is not currently promoted.

### Focus may elevate only already-owned deep surfaces
If a symbol is promoted and already eligible for Layer 5 service, focus may later justify:
- faster consumption of already-available deep truth
- bounded tactical refresh of Layer 5-owned surfaces where architecture explicitly allows it

But even then, focus does not authorize:
- widening to non-promoted symbols
- hidden shortlist changes
- write-at-display-speed behavior

### Structural vs tactical deep truth
Layer 5 should preserve the distinction between:
- structural committed deep truth
- tactical presentation of already-admitted deep truth for the focused promoted symbol

These may coexist.
They must not become one ambiguous channel.

---

## Layer 5 artifact block

Layer 5 owns the deep-analysis artifact block for promoted symbols.
That block should be inspectable, bounded, and atomically landed.

It should contain at minimum:
- deep analysis or deep packet fields assigned by architecture
- deep freshness posture
- last refreshed time
- stale / degraded posture
- continuity markers where applicable
- rank or service-tier metadata where assigned

### Artifact law
The Layer 5 artifact exists so operator surfaces and downstream compositions can consume deep truth without recomputing it ad hoc.

### Deep Analysis subsection model (mandatory)
Every Layer 5 deep block must expose this ordered subsection model:
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

These subsections are structural requirements, not optional prose headings.

### Mandatory data minimums
Layer 5 deep truth is non-compliant unless it contains at minimum:
- actual OHLC bars for every enabled timeframe
- bars-per-timeframe counts for each enabled timeframe
- recent tick window with default span of 5 minutes
- rolling spread window with minimum span of 1 minute

If data is missing, Layer 5 must surface explicit missingness and publication posture rather than collapsing the subsection.

### Preservation law for rolling deep state
Layer 5 must preserve valid rolling tick/spread recordings when rebuilding deeper context.

#### Reset-forbidden conditions
Layer 5 must not destructively reset rolling tick/spread history when:
- input data is temporarily missing but last-good rolling data is still valid under continuity policy
- a deep rebuild is partial and only deeper fields are missing
- symbol remains promoted and entitlement is active or continuity-eligible

#### Reset-allowed conditions
Layer 5 may reset rolling tick/spread state only when:
- symbol identity changed or canonical symbol mapping changed
- data-window corruption/integrity checks fail and retention would be misleading
- continuity TTL is explicitly expired and policy requires retirement
- explicit operator or system recovery action requests a reset

Any reset must be recorded with reason and timestamp in `preservation_state`.

### Calm publication law
Layer 5 should publish after admitted deep refresh work completes.
It must not create same-speed write churn merely because deep values or tactical views are changing rapidly.

### Atomic publication
Layer 5 publication must follow temp-to-final atomic landing discipline.
A failure in composition or HUD must not erase already committed deep truth.

---

## Continuity doctrine

### Why continuity exists
Deep truth may be more expensive to refresh and therefore more vulnerable to becoming stale between service waves.
Layer 5 continuity exists so the system can preserve last-good deep visibility where architecture permits it.

### Continuity must stay honest
A continuity-backed deep packet must be visibly distinct from a freshly rebuilt deep packet.
Continuity is not permission to present old deep truth as newly current.

### Controlled continuity
Layer 5 may preserve last-good values for assigned deep fields where:
- the field meaning remains stable enough to show safely
- stale or degraded posture is made explicit
- downstream consumers can distinguish continuity from fresh rebuild

---

## Degraded behavior

Layer 5 must fail honestly.

### If deep inputs are temporarily unavailable
Layer 5 may preserve last-good committed deep truth where allowed, but must surface stale, degraded, or continuity-backed posture clearly.

### If promoted membership changes
Layer 5 must not keep presenting a demoted symbol as actively entitled to fresh deep service.
Previously committed deep truth may remain visible in controlled ways, but active entitlement is gone.

### If writes fail
Layer 5 should preserve last-good committed deep truth where allowed, while surfacing landing and freshness ambiguity honestly.

### If deep scope becomes too wide
The design is wrong.
Layer 5 must not quietly absorb broader scanner responsibilities just to preserve feature ambition.

---

## Future-required handoff direction

Layer 5 must terminate in a downstream interpretation handoff.
The canonical direction is an **analyst handoff packet / SIAM handoff packet** sourced from lawful Layer 1–5 truth.

Stage 1 freezes the direction only:
- the handoff belongs downstream of scanner-owned deep truth
- ASC ends at deep evidence, deep context, and bounded structural interpretation
- SIAM / Aurora consumes that handoff and may derive bias, invalidation, trigger interpretation, signal readiness, signal classification, and risk framing
- the exact handoff field schema is not frozen in this pass

## Bridge lifecycle binding reference

Canonical bridge lifecycle table section: `blueprint/final/ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md` -> **"Shared bridge lifecycle table (canonical)"**.

Local Layer 5 constraints:
- Deep Analysis may emit bridge-candidate output only for currently promoted, symbol-scoped admissions.
- Bridge eligibility remains fail-closed on provenance, freshness/staleness, entitlement, and mode/governor posture.
- Demotion or expiry removes active bridge entitlement; only bounded continuity visibility may remain when explicitly allowed.

Anti-duplication note: **If bridge table changes, only canonical source is edited.**

## Downstream implications

When Layer 5 commits new or materially changed deep truth, it may create downstream eligibility.
That downstream eligibility is for interpretation handoff and consumer enrichment.
It is not scanner-owned signal issuance.

Typical downstream effects:
- promoted deep surfaces may refresh structurally
- operator summaries for promoted members may improve
- downstream composition priority may change where architecture assigns it

Layer 5 does **not** automatically authorize:
- shortlist rebuild
- universe-wide packet refresh
- dossier compose wave at the same pace as deep refresh
- page-driven widening into new promoted candidates

Layer 5 creates richer truth, not upstream authority.

---

## Common failure patterns

### Pattern 1 — Universe creep
Layer 5 starts deep-serving symbols outside the promoted set because resources seem available or because the data is interesting.

Result:
- scope explodes
- runtime cost rises sharply
- earlier-layer architecture becomes pointless

### Pattern 2 — Deep authority leak
Layer 5 outputs quietly begin determining who should be selected without explicit architectural rules.

Result:
- Layer 4 authority blurs
- causality becomes hard to inspect
- promotion logic becomes unstable

### Pattern 3 — Focus entitlement bug
A focused symbol gets deep service merely because the operator is looking at it, even though it is not promoted.

Result:
- navigation becomes a hidden scheduler
- scope widens unpredictably

### Pattern 4 — Same-speed write contamination
Deep refresh cadence starts dragging persistence cadence upward so that artifacts try to land as fast as tactical views move.

Result:
- write pressure rises
- calm publication is lost
- deep service becomes noisy and expensive

### Pattern 5 — Prestige-data sprawl
Layer 5 keeps accumulating more and more expensive deep fields because they look impressive, not because they improve promoted-set understanding in a bounded way.

Result:
- deep cost rises
- clarity falls
- Layer 5 becomes a dumping ground for ambition

---

## Implementation obligations

Any future MT5 implementation of Layer 5 must:
- restrict active deep service to the Layer 4 promoted set
- keep deep scope explicit and bounded
- distinguish structural committed deep truth from tactical consumption of already-admitted deep surfaces
- expose deep freshness and last-refresh metadata clearly
- preserve controlled last-good continuity where assigned
- use rank-sensitive cadence only inside the promoted set
- prevent Layer 5 from seizing selection authority or widening into broad service
- terminate scanner-owned output in an analyst / SIAM handoff direction rather than a final signal command
- publish Layer 5 artifacts atomically
- keep persistence cadence separate from tactical or fast-changing deep consumption
- surface stale and degraded posture honestly

If an implementation cannot explain why a symbol is currently receiving deep service, that implementation is incomplete.

---

## Stage 4 Layer 5 field-contract completion

This section completes the Layer 5 field contract, the observed-vs-interpreted truth split, and the final SIAM / analyst handoff contract.
If earlier wording is less explicit, this section wins.

### Doctrine tiers

#### Hard law
Layer 5 remains promoted-symbol deep evidence plus bounded structural interpretation only.
It ends in analyst / SIAM handoff direction.
It must never become the final signal engine.

#### Required product contract
Every lawful completed Layer 5 block must expose the ordered subsection contract below, including mandatory observed truth, mandatory interpreted truth boundaries, continuity posture, and the final handoff block.

#### Future expansion option
Future work may add richer levels, richer pattern interpretation, richer multi-session context, or richer handoff enrichments.
Those remain optional unless later promoted into required law.

### Observed truth vs interpreted truth law

#### Observed truth
Observed truth is direct scanner-owned evidence.
Examples include:
- enabled timeframe list
- bars requested / copied / missing
- OHLC values
- ATR values
- spread statistics
- tick statistics
- reference levels
- freshness timestamps
- continuity timestamps
- preservation / reset metadata

Observed truth must remain machine-inspectable and must never be silently rewritten into narrative form only.

#### Interpreted truth
Interpreted truth is bounded scanner-owned interpretation built from observed truth.
Examples include:
- compression posture
- expansion posture
- alignment or misalignment posture
- conflict posture
- invalidation posture
- scenario posture
- constructive / danger / watch-next references

Interpreted truth must remain clearly labeled as interpretation.
It must not masquerade as raw evidence or final signal verdict.

### Ordered Layer 5 subsection contract (mandatory)

#### 1. `deep_analysis_overview`
Required:
- `symbol`
- `analysis_state`
- `analysis_completeness_state`
- `analysis_scope`
- `promoted_state`
- `entitlement_state`
- `output_mode`
- `observed_at`
- `published_at`
- `analysis_freshness_state`
- `analysis_degraded_state`
- `analysis_degraded_reason`

Optional:
- compact overview notes
- service-tier note
- deep refresh lineage note

#### 2. `timeframe_settings`
Required:
- `enabled_timeframes`
- `bars_requested_by_timeframe`
- `minimum_bars_required_by_timeframe`
- `bars_copied_by_timeframe`
- `bars_missing_by_timeframe`
- `sufficiency_posture_by_timeframe`

Optional:
- timeframe display labels
- timeframe priority notes
- per-timeframe failure notes

#### 3. `bar_pack`
Required:
- `atr_enabled`
- `atr_period` where ATR is enabled
- `atr_value_by_timeframe` where available
- `rolling_atr_value_by_timeframe` where retained
- `range_reference_by_timeframe` where architecture exposes it
- `bar_pack_state`

Optional:
- true-range notes
- bounded volatility normalization notes

#### 4. `ohlc_by_enabled_timeframe`
Required:
- actual OHLC visibility for every enabled timeframe
- canonical bar list or bounded visible subset for every enabled timeframe
- `ohlc_visibility_mode`
- `visible_bar_count_by_timeframe`
- `missing_bar_reason_by_timeframe` where incomplete

Actual OHLC evidence is mandatory doctrine.
Compact consumer views may summarize it, but the lawful deep block must still contain it.

#### 5. `bar_interpretation`
Required interpreted fields:
- `structure_posture_by_timeframe`
- `alignment_posture`
- `conflict_posture`
- `compression_expansion_posture`
- `scenario_posture`
- `invalidation_posture`

Optional:
- support / resistance interpretation notes
- reference level narratives
- scenario-form explanation

#### 6. `recent_tick_activity`
Required:
- `tick_window_seconds`
- `tick_count`
- `tick_rate`
- `up_tick_count`
- `down_tick_count`
- `flat_tick_count`
- `tick_range`
- `tick_sufficiency_posture`
- `tick_freshness_state`

Optional:
- burst notes
- micro-pause notes
- tick imbalance notes

#### 7. `live_spread_rollover`
Required:
- `spread_window_seconds`
- `spread_current`
- `spread_mean`
- `spread_median`
- `spread_min`
- `spread_max`
- `spread_percentile_posture` where retained
- `spread_sufficiency_posture`
- `spread_freshness_state`

Optional:
- rollover or widening notes
- friction trend notes

#### 8. `preservation_state`
Required:
- `continuity_state`
- `last_good_available`
- `last_good_timestamp`
- `reset_state`
- `reset_reason`
- `preservation_expiry_state`

Optional:
- continuity lineage notes
- preservation TTL notes
- integrity-check notes

#### 9. `microstructure_notes`
Required:
- `microstructure_state`
- `microstructure_reason`

Optional:
- broker-friction note
- quote-step note
- execution-friction note

#### 10. `advanced_context`
Required:
- `reference_levels` or explicit `not_available`
- `range_boundaries` or explicit `not_available`
- `volatility_posture`
- `friction_posture`

Optional:
- support / resistance families
- session interaction notes
- structure-overlap notes

#### 11. `decision_support`
Required:
- `constructive_reference`
- `danger_reference`
- `watch_next_reference`
- `decision_support_state`

Optional:
- bounded scenario bullets
- next-check suggestion
- operator briefing note

#### 12. `siam_analyst_handoff`
Required:
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

Optional:
- bounded handoff summary
- analyst continuity note
- handoff missingness note

### Lawful completion states

#### Completed deep block
A Layer 5 block is lawfully completed only when:
- all 12 ordered subsections exist
- every enabled timeframe has requested / copied / missing / sufficiency posture
- actual OHLC evidence exists or explicit missingness is published for every enabled timeframe
- tick and spread subsections publish both statistics and sufficiency posture
- preservation state is explicit
- the SIAM / analyst handoff block is present
- degraded posture is honest where any subsection is partial

#### Partial / degraded / continuity / unavailable states
Layer 5 must publish explicit posture rather than collapsing into silence:
- `partial` — some mandatory subsection content exists but one or more required fields are missing
- `degraded` — required evidence is present only through stale or weakened quality posture
- `continuity` — prior lawful deep truth is being surfaced under explicit continuity rules
- `unavailable` — no lawful deep block can be published yet

### Handoff prohibition law
The `siam_analyst_handoff` block must never contain:
- final trade verdict
- buy / sell command
- execution command
- order instruction
- final signal ownership
- hidden signal score presented as the conclusion


## Stage 5 consolidation hardening

### Cross-file completion law
Layer 5 completion means:
- the symbol was lawfully promoted first
- the deep block was explicitly triggered or otherwise lawfully admitted
- the deep evidence packet was built with honest completeness / degraded / continuity posture
- the resulting packet may be handed to analyst / SIAM interpretation downstream

Layer 5 completion does **not** mean:
- ASC issued the final signal
- Market Board gained Layer 5 depth
- Current Focus or a HUD page-open implies Deep Analysis has already completed
- Layer 5 widened into a universe-scale background service
- menu/settings may force non-lawful deep authority

### Handoff-ending law
The `siam_analyst_handoff` block is the termination boundary of scanner-owned deep analysis.
It is not a hidden execution panel, not a final trade verdict, and not a license for consumer surfaces to relabel ASC as the signal owner.


## Final standard

Layer 5 is correct when it enriches the current promoted set with deeper rolling truth in a way that is selective, inspectable, hostile to scope creep, and explicitly downstream-facing toward interpretation handoff rather than scanner-owned signal output.

That means Layer 5 must be:
- promoted-set only
- deep but narrow
- rank-sensitive without widening
- freshness-aware
- continuity-aware
- atomically committed
- calm through selectivity
- hostile to authority leaks
- handoff-directed rather than signal-owning

The standard is not that Layer 5 produces impressive data.
The standard is that Layer 5 produces trustable deeper truth for the selected few without undermining the boundaries that make the whole scanner coherent.

