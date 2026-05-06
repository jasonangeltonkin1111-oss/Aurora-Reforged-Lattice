# ASC Layer 1 Market State

## Purpose

This document defines the canonical design of Layer 1 in Aurora Sentinel Scanner (ASC).

Layer 1 is the market-state owner.
It is the boot gate of the scanner.
Its job is to answer the first question honestly and at scale:

> what is the current market-state posture of the broker symbol universe?

Layer 1 does not exist to be rich.
It exists to be broad, cheap, timely, and trustworthy.

If Layer 1 is weak, the whole scanner becomes confused.
If Layer 1 is slow, later layers become artificially starved.
If Layer 1 is ambiguous, later layers inherit false confidence.

That is why Layer 1 is first.

---

## Core doctrine

Binding reference: `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`.

### Layer 1 boot-gate law
Layer 1 is the true boot gate of ASC.

The scanner must not pretend later-layer readiness before Layer 1 has established sufficient market-state truth across the universe.
Warmup exit is therefore primarily a Layer 1 question, not a dossier question, not a HUD question, and not a Layer 2 enrichment question.

### Broad-cheap law
Layer 1 must remain cheap enough to operate broadly.
It is allowed to touch many symbols in one service wave because its unit of work is intentionally narrow.
Layer 1 broad packets may be serviced through repeated intra-beat micro-bursts.
The 1-second heartbeat is supervisory cadence, not Layer 1 minimal work quantum.

This is a critical doctrine:
ASC does **not** become performant by starving Layer 1 into tiny timid batches.
ASC becomes performant when Layer 1 remains a cheap class and is prevented from mixing with heavier classes in the same beat.

### State-before-richness law
The first obligation of Layer 1 is state truth, not packet richness.
It must determine whether a symbol is:
- open
- closed
- uncertain
- unknown

Only after that broad state truth exists do later layers gain honest meaning.

### Coverage-before-detail law
Layer 1 prefers broad truthful coverage over narrow excessive detail.
When tradeoffs exist, Layer 1 must choose:
- whole-universe visibility first
- confidence improvement second
- fine explanatory detail third

### Confirmation law
Layer 1 may use bounded confirmation logic for ambiguous cases, recent transitions, or restoration uncertainty.
Confirmation is allowed to refine state truth.
Confirmation is **not** permission to turn Layer 1 into a heavy read engine.

### No-hidden-filter law
Layer 1 must not perform Layer 3 work.
It may identify market-state truth and readiness.
It may not start acting like an eligibility filter, a ranking engine, or a shortlist precursor merely because it sees the whole universe first.

---

## What Layer 1 owns

Layer 1 owns:
- symbol-universe market-state coverage
- unknown / open confirmed / closed confirmed / uncertain classification
- first-pass market-state freshness
- confirmation service for ambiguous or transition-prone symbols
- Layer 1 readiness tracking
- Layer 1 next-check scheduling
- broad scan service posture
- closed/open recheck timing discipline
- recovery-state re-entry into truthful market-state classification
- Layer 1 committed market-state artifact block

Layer 1 owns market-state truth itself.
It does not merely contribute hints.

---

## What Layer 1 does not own

Layer 1 does not own:
- open-symbol packet enrichment
- candidate filtering
- shortlist selection
- deep selective analysis
- dossier composition
- operator-surface composition
- broad persistence policy beyond its own artifact block
- global scheduling law
- downstream cadence decisions

If Layer 1 starts absorbing these roles, the architecture is drifting.

---

## Primary runtime class

Layer 1 primary runtime class:
- **Scan**

Layer 1 secondary bounded class:
- **Snapshot / Read** only when minimal confirmation evidence is required and explicitly admitted

Layer 1 must never become dominated by heavy reads.
Its identity is broad market-state scanning.

---

## Layer 1 inputs

Layer 1 may consume:
- broker symbol universe membership
- market-watch observable symbol state
- direct live-price availability signals where applicable
- limited broker/session availability context where architecture permits it
- previously committed Layer 1 continuity state as support only
- restart/recovery context where needed to seed honest re-entry

Layer 1 must not depend on later-layer truth to decide its own primary classification.

## Layer 1 evidence hierarchy (canonical)

Layer 1 may only classify symbols from evidence planes inside this priority-aware hierarchy:

1. **Synchronization posture (hard blocking)**
   - If synchronization posture indicates the scanner cannot currently trust live symbol observables, Layer 1 must not force open/closed certainty.
2. **Trade permission / trade mode posture (hard blocking)**
   - If trade-permission truth indicates trading is not currently admissible for the symbol context, Layer 1 must treat this as blocking evidence against open certainty until conflicting conditions clear.
3. **Trade-session posture (primary structural evidence)**
   - Session-open/session-closed posture is a primary classifier input and may establish confirmed open/closed posture when consistent with other hard planes.
4. **Latest tick freshness (primary live corroboration)**
   - Fresh live tick presence can confirm active openness; stale or absent tick freshness can create uncertainty when session posture alone is insufficient.
5. **Continuity/prior committed Layer 1 state (supporting only)**
   - Continuity may support decisions and schedule prioritization, but must never be treated as blind truth against current conflicting evidence.

Evidence-handling law:
- Hard-blocking planes must block false certainty.
- Supporting planes may stabilize scheduling and confidence notes.
- Conflicting or stale planes must resolve to **Uncertain** or **Unknown** rather than fabricated **Open Confirmed**/**Closed Confirmed** claims.

---

## Layer 1 outputs

Layer 1 produces the first committed truth block for symbols.
Its canonical outputs include:
- market-state classification
- status note / reason summary
- last checked time
- next scheduled check time
- next-check reason
- confidence / ambiguity posture
- confirmation count or confirmation posture where relevant
- stale / degraded posture where relevant
- Layer 1 readiness contribution markers

These outputs form the first truthful artifact surface for most symbols.

---

## Canonical state model

Layer 1 must support these canonical market-state values:
- **Unknown**
- **Open Confirmed**
- **Closed Confirmed**
- **Uncertain**

Operator surfaces may display shorter labels (**Open**, **Closed**, **Unknown**, **Uncertain**) when the confirmed/uncertain distinction remains semantically intact.

These may be supplemented by additional control posture such as:
- pending
- stale
- degraded
- blocked
- recently transitioned
- awaiting confirmation

But the primary market-state meaning must remain clear and operator-safe.

### Unknown
- **Meaning:** no trustworthy first-pass market-state decision has been earned yet.
- **Entry conditions:** startup symbol not yet assessed, recovery reset without current confirming evidence, or prior evidence invalidated before replacement.
- **Why it exists:** prevents fake early certainty during boot/recovery.
- **Certainty class:** intentionally uncommitted.

### Open Confirmed
- **Meaning:** current evidence supports an open/tradable posture with no active blocking conflict.
- **Entry conditions:** session/permission/tick evidence aligns without unresolved hard-plane contradiction.
- **Why it exists:** separates true open confidence from mere temporary optimism.
- **Certainty class:** positive confirmed state.

### Closed Confirmed
- **Meaning:** current evidence supports non-open posture with no unresolved hard-plane contradiction.
- **Entry conditions:** session/permission/trade-mode evidence confirms closed or unavailable posture and no stronger conflicting live evidence remains unresolved.
- **Why it exists:** prevents stale-open carryover and preserves calm wake/recheck discipline.
- **Certainty class:** negative confirmed state.

### Uncertain
- **Meaning:** evidence exists but is conflicting, transition-sensitive, stale, or otherwise insufficient for confirmed open/closed truth.
- **Entry conditions:** hard-plane conflicts, transition ambiguity, freshness breakdown, or bounded confirmation not yet converged.
- **Why it exists:** protects truth honesty when conditions are real but inconclusive.
- **Certainty class:** explicitly unresolved, evidence-backed uncertainty.

## State-transition doctrine

Layer 1 transitions must remain evidence-driven and inspectable:

- **Unknown -> Open Confirmed / Closed Confirmed** may occur only after first-pass evidence clears hard-blocking contradictions.
- **Unknown -> Uncertain** is required when first-pass evidence is present but conflicting or too weak for confirmation.
- **Open Confirmed <-> Closed Confirmed** requires fresh contradictory evidence with resolution, not inferred flips from stale continuity alone.
- **Open Confirmed -> Uncertain** and **Closed Confirmed -> Uncertain** are mandatory when prior confirmation degrades under conflict, stale freshness, or session-transition ambiguity.
- **Uncertain -> Open Confirmed / Closed Confirmed** requires bounded confirmation convergence to one confirmed posture.
- **Any confirmed/uncertain state -> Unknown** is reserved for restart/recovery invalidation where prior state is no longer trustworthy and no current evidence can be relied on yet.

Transition honesty law:
- Layer 1 must not force open/closed certainty when evidence planes conflict.
- Conflicts must remain visible as uncertainty until resolved or explicitly invalidated.

## Layer 1 service modes

Layer 1 operates differently depending on runtime mode.

### 1. Boot warmup mode
Purpose:
- establish broad first-pass truth across the universe quickly
- reduce unknown state aggressively
- reach minimum trustworthy coverage for scanner admission

Behavior:
- prefer wide cheap scans
- minimize interference from later classes
- schedule confirmation only where truly needed
- prioritize coverage over explanation detail

### 2. Recovery mode
Purpose:
- restore truthful market-state posture after restart, degradation, reconnect, or artifact discontinuity

Behavior:
- reuse committed continuity only as support, never as blind truth
- aggressively revalidate uncertain or transition-sensitive symbols
- prevent stale persisted optimism from masquerading as live state

### 3. Steady-state maintenance mode
Purpose:
- maintain market-state truth calmly after readiness has been achieved

Behavior:
- use scheduled rechecks
- keep closed symbols on calm cadence
- service transition-prone symbols more actively
- maintain confidence without re-running boot intensity unnecessarily

### 4. Transition watch mode
Purpose:
- watch symbols near open/close boundaries or signs of market-state change

Behavior:
- use bounded confirmation and nearer-term rechecks
- remain symbol-selective rather than re-triggering full-universe instability

### 5. Degraded mode
Purpose:
- preserve honest state signaling when evidence quality or service continuity is weakened

Behavior:
- surface uncertainty rather than guess
- protect last-good lower-trust continuity where permitted
- avoid fake readiness

---

## Readiness doctrine

### Why Layer 1 readiness matters
Later layers should not be allowed to behave as though the scanner understands the universe when Layer 1 still does not.

Layer 1 readiness therefore acts as the earliest meaningful admission threshold for the system.

### Readiness is not perfection
Layer 1 readiness does not mean every symbol is maximally understood.
It means the scanner has achieved enough broad truthful market-state coverage that later bounded work can proceed honestly.

### Readiness must be computed from Layer 1 truth
Layer 1 readiness must depend primarily on Layer 1-owned state such as:
- proportion of the universe that has received valid first-pass classification
- reduction of unknown posture to acceptable bounds
- coverage of priority symbol groups or key market buckets where defined
- acceptable ambiguity bounds for startup

Readiness must not depend on:
- Layer 2 packet enrichment completion
- dossier hydration completion
- HUD view completion
- later-layer artifact richness

### Readiness posture classes
Layer 1 readiness posture must be inspectable as:
- **Partial posture**: meaningful assessed coverage exists, but readiness thresholds are not yet met
- **Ready posture**: Layer 1 truth coverage and scheduling posture are sufficient for honest downstream eligibility creation
- **Degraded posture**: readiness may have been achieved previously, but current evidence/service quality is weakened and truth confidence is reduced
- **Stale posture**: published Layer 1 truth age has exceeded freshness expectations and requires explicit stale signaling

These posture classes are Layer 1-owned truth postures, not HUD richness proxies.

### Warmup exit law
Warmup may end when Layer 1 has reached defined readiness thresholds.
It must not remain hostage to downstream conveniences.

---

## Broad scan doctrine

### Large cheap batches are valid
Because Layer 1 work is intentionally narrow, Layer 1 may process large cheap batches.

Examples of valid posture:
- approximately 200 symbols in a cheap broad pass on a large broker
- full-set pass on a smaller broker if the class remains cheap
- compressed priority-first wide service during startup

### Tiny timid throughput is not a virtue
Artificially tiny Layer 1 batches create false calm while starving the whole scanner.
This is a design failure, not a performance achievement.

### Broad scan must stay cheap
Large batches are valid only if Layer 1 remains narrow.
If a scan pulse starts mixing packet enrichment, filtering, selection, dossier work, or heavy persistence, the class is no longer cheap and the design has broken.

---

## Confirmation doctrine

### Why confirmation exists
A symbol may be ambiguous because of:
- open/close transitions
- temporary lack of decisive evidence
- restart recovery ambiguity
- conflicting hints from cheap observables

Layer 1 may use confirmation logic to improve classification confidence.

### Confirmation must stay bounded
Confirmation is a refinement path, not a second hidden engine.
It must be:
- symbol-selective
- limited in repeat count
- tied to a next-check reason
- subordinate to overall Layer 1 cadence discipline

### Confirmation should not become obsession
A small set of difficult symbols must not monopolize Layer 1 service indefinitely.
If ambiguity persists, Layer 1 must be allowed to retain uncertain posture honestly and move on.

### Example bounded posture
Valid examples include:
- up to a small configured number of confirmation attempts during boot for unresolved cases
- nearer-term follow-up on likely opening symbols
- calmer maintenance confirmation after transition windows

## Retry and convergence doctrine

Retry exists to improve truth quality, not to manufacture delay.

Layer 1 retry law:
- retries must be bounded and reasoned
- unknown/uncertain symbols may receive tighter revisit windows than confirmed symbols
- repeated non-resolution must preserve uncertainty honestly rather than force a false confirmation
- unresolved symbols must continue carrying explicit reason posture

Convergence separation law:
- **confirmation retries** resolve ambiguous evidence for a specific symbol state decision
- **normal maintenance rechecks** preserve freshness of already confirmed posture
- **wake scheduling** is calm closed-symbol re-entry checking and is not equivalent to uncertainty retry pressure

---

## Scheduling doctrine

### Layer 1 must schedule by state posture
Next-due scheduling is state-class law, not best-effort suggestion.

Canonical next-due posture:
- **Unknown**: highest-priority follow-up until first trustworthy classification is earned
- **Uncertain**: near-term bounded confirmation cadence with explicit reason tracking
- **Open Confirmed**: normal maintenance recheck cadence
- **Closed Confirmed**: calmer wake/recheck cadence, not constant broad refresh spam

Per-symbol scheduling must always carry:
- next-due time posture
- next-due reason posture
- state-linked cadence class/posture

State-driven scheduling exists because unresolved truth requires nearer confirmation, while confirmed closed truth requires calm wake discipline.
Unknown symbols must not be abandoned indefinitely.

### Transition sensitivity
Symbols near likely state changes may deserve tighter next-check cadence than stable closed symbols.
But this must remain selective and reasoned.

### Scheduler honesty
Layer 1 must always know why a symbol is scheduled next.
Next-check reasoning should be visible in runtime state or artifact metadata.
Future EA implementation may not use scheduler calmness language to justify weakening Layer 1 broad truthful coverage.

## Layer 1 completion standard

Layer 1 is complete only when it can prove all of the following in machine-usable state:
- broad classification coverage exists across the active universe using the canonical state model
- every symbol has explicit next-due posture (time + reason + state-driven scheduling posture)
- readiness is computable from Layer 1-owned truth and inspectable as partial/ready/degraded/stale posture
- partial vs full cycle posture is inspectable and publication-state honest
- publication rules explicitly prevent partial coverage from being represented as full completion
- downstream eligibility can be created honestly from Layer 1 truth without implying downstream entitlement

Layer 1 is **not complete** when broad scans exist without trustworthy state ownership, when next-due posture is fake/default-only, when readiness is inferred from downstream fullness, or when publication hides unknown/uncertain posture.

## Next-due scheduling ownership

Layer 1 owns next-due posture directly.
Per symbol, Layer 1 must expose:
- next_due_utc
- next_due_reason
- due scheduling class (open/closed/uncertain/unknown)

Scheduling classes are mandatory:
- **Open**: regular recheck cadence while preserving broad service
- **Closed**: calm recheck cadence; no refresh spam
- **Uncertain**: bounded near-term confirmation cadence; uncertainty must remain explicit if unresolved
- **Unknown**: highest priority until first valid classification is earned

## Warmup and readiness exit criteria

Warmup exits only when Layer 1-owned readiness thresholds are actually met.
At minimum:
- unknown posture is reduced to configured acceptable bounds
- uncertain posture is bounded within startup tolerance
- assessed coverage has crossed Layer 1 completion floor

Warmup must not exit because Layer 2+ surfaces merely look populated.

## Publish-cycle completion law

A **partial Layer 1 publish cycle** is allowed when a meaningful assessed subset exists and posture is emitted honestly as partial/stale/degraded as needed.

A **full Layer 1 publish cycle** requires:
- due set serviced to completion for the active cycle
- summary posture marked complete
- readiness/degraded/stale posture explicitly published

Partial cycles remain partial.
They may not be reworded as full completion to unlock downstream widening.

## Downstream eligibility after real Layer 1 completion

Completed Layer 1 may dirty downstream eligibility.
It does not guarantee immediate Layer 2/3/4/5 execution.
Governor admission, write guards, and later-layer ownership laws still apply.

## Layer 1 scope fence (anti-creep law)

Layer 1 must remain narrow and must not absorb adjacent ownership:
- must not provide Layer 2 packet richness ownership
- must not perform Layer 3 filtering ownership
- must not perform Layer 4 shortlist ownership
- must not perform Layer 5 selective-analysis ownership
- must not grant HUD any runtime compute authority

Any attempt to claim Layer 1 completion while silently widening into these owners is architectural drift.

---

## Layer 1 artifact block

Layer 1 owns the first committed symbol artifact block.
That block should be compact, stable, and fast to land.

It should contain at minimum:
- market-state classification
- status note
- last checked time
- next check time
- next-check reason
- confidence / ambiguity posture
- stale or degraded markers where relevant

### Layer 1 artifact law
Layer 1 artifacts should land early and calmly.
They are more important than richer downstream composition because they represent the first trustworthy scanner truth.

### Atomic publication
Layer 1 publication must follow atomic landing discipline.
A failed later layer must not erase already landed Layer 1 truth.

---

## Degraded behavior

Layer 1 must fail honestly.

### If evidence is weak
Use uncertain or unknown.
Do not silently guess open or closed.

### If writes fail
Preserve last-good committed Layer 1 truth where architecture allows, but surface staleness or degraded posture clearly.

### If service is delayed
Layer 1 must surface stale posture rather than pretending fresh state.

### If restart occurs
Layer 1 may reuse continuity as support but must re-earn live truth.

---

## Operator-surface implications

Layer 1 should give the operator a trustworthy view of universe posture.
That includes:
- counts of open / closed / uncertain / unknown
- readiness posture
- degraded posture where relevant
- next-check logic in explainable form where surfaced

HUD and summaries may consume Layer 1 outputs.
They may not reinterpret Layer 1 ownership or replace it with page-driven logic.

---

## Dirty routing rights

When Layer 1 commits new or materially changed market-state truth, it may dirty downstream service.

Typical downstream effects:
- symbol becomes eligible or ineligible for Layer 2 packet service
- readiness posture changes for higher layers
- universe posture summaries require refresh

Layer 1 does **not** automatically authorize:
- immediate Layer 2 full refresh
- immediate Layer 3 filtering everywhere
- immediate shortlist rebuild
- dossier compose wave

Layer 1 creates eligibility, not pile-on permission.

---

## Common failure patterns

### Pattern 1 — Slow starvation sold as discipline
Layer 1 is shrunk to tiny throughput and the system praises itself for being calm.

Result:
- warmup drags
- unknown state lingers
- later layers starve
- scanner truth lags the market

### Pattern 2 — Layer 1 richness creep
Layer 1 begins capturing more and more packet or eligibility detail in the name of efficiency.

Result:
- Layer 1 cost rises
- broad service quality collapses
- class identity blurs

### Pattern 3 — Confirmation obsession
A few hard symbols repeatedly consume Layer 1 attention while broad coverage suffers.

Result:
- wide readiness degrades
- ambiguity concentrates service unfairly

### Pattern 4 — Fake readiness
Warmup exits because dashboards or downstream surfaces look populated, even though Layer 1 itself has not earned sufficient coverage.

Result:
- downstream truth rests on weak foundations
- operator confidence becomes false

### Pattern 5 — Persisted optimism
Restart/recovery trusts old Layer 1 state too strongly without live revalidation.

Result:
- symbols look open or closed based on stale continuity rather than current truth

---

## Implementation obligations

Any future MT5 implementation of Layer 1 must:
- keep broad scan service cheap and explicit
- expose readiness metrics grounded in Layer 1 state
- record next-check reason per symbol or equivalent control posture
- distinguish open / closed / uncertain / unknown clearly
- preserve confirmation as bounded logic
- prevent Layer 1 from silently widening into Layer 2 or Layer 3 behavior
- publish Layer 1 artifacts atomically
- surface stale and degraded posture honestly

If an implementation cannot explain why a symbol is currently scheduled, that implementation is incomplete.

---

## Stage 4 Layer 1 field-contract completion

This section completes the Layer 1 field contract.
If earlier wording is less explicit, this section wins.

### Doctrine tiers

#### Hard law
Layer 1 is market-state truth only.
It must not rank, filter, shortlist, imply setup quality, or pre-own deep-analysis meaning.

#### Required product contract
Every Layer 1 publication must expose one compact but complete market-state contract with required fields, freshness, confidence, and recheck posture.

#### Future expansion option
Future work may add richer confirmation telemetry, richer venue/session explanation, or richer transition diagnostics.
Those fields remain optional unless later promoted into required law.

### Required Layer 1 fields

#### Identity and classification
- `symbol`
- `market_state`
- `market_state_code`
- `market_state_reason`

`market_state` must use the lawful Layer 1 state family only:
- `open_confirmed`
- `closed_confirmed`
- `uncertain`
- `unknown`

#### Freshness posture
- `observed_at`
- `published_at`
- `freshness_state`
- `freshness_age_seconds` or equivalent operator-safe age field

#### Confidence posture
- `confidence_state`
- `confidence_reason`

Confidence must remain about market-state truth only.
It must not imply trade quality.

#### Recheck and scheduling posture
- `next_recheck_at` or equivalent countdown field
- `recheck_reason`
- `recheck_priority` or equivalent bounded scheduling posture

#### Degraded / failure / uncertain posture
- `degraded_state`
- `degraded_reason`
- `failure_state` where acquisition or confirmation failed
- `failure_code` where a machine-safe code exists

### Optional Layer 1 enrichments
Optional enrichments may include:
- bounded confirmation notes
- transition notes
- recovery / restart lineage notes
- session or venue explanation notes
- previous-state reference

Optional enrichments must never replace the required fields.

### Always-visible consumer minimum
Any consumer rendering of Layer 1 must always show:
- symbol
- market state
- operator-safe reason
- freshness posture
- confidence posture
- next recheck posture
- degraded / uncertain warning when present

Compact surfaces may abbreviate wording, but they may not hide these minimums.

### Failure / degraded / uncertain behavior
If Layer 1 cannot lawfully confirm open or closed posture, it must publish `uncertain` or `unknown` with explicit degraded or failure posture.
It must not emit optimistic certainty just to keep downstream layers moving.

## Final standard

Layer 1 is correct when it gives ASC a broad truthful universe posture quickly enough that the rest of the scanner can proceed without lying.

That means Layer 1 must be:
- broad
- cheap
- state-first
- readiness-driven
- confirmation-bounded
- atomically committed
- honest under degradation

The standard is not that Layer 1 looks active.
The standard is that Layer 1 creates a trustworthy first foundation for everything that follows.
