# ASC Layer 4 Shortlist Selection

## Runtime implementation posture lock (current)

Layer 4 is now active runtime truth for:
- shortlist membership
- shortlist rank
- shortlist score
- compact board/current-focus/dossier correlation publication tied to shortlist context

Layer 5 remains separate and command-only.
This document remains normative for active Layer 4 runtime ownership and future hardening.

## Purpose

This document defines the canonical design of Layer 4 in Aurora Sentinel Scanner (ASC).

Layer 4 is the shortlist-selection owner.
Its job is to consume Layer 3 survivor truth and answer the next bounded question honestly:

> which survivors deserve promotion into the current selected set?

Layer 4 is the first layer that changes downstream privilege.
Once a symbol is promoted here, it can receive:
- selected-set visibility
- promoted-set status
- downstream deep-analysis eligibility
- richer operator attention
- higher-value persistence and composition priority where architecture assigns that role

Because of that, Layer 4 is logically heavy even when the raw computation is modest.
It must be treated as a real authority surface, not a casual refresh step.

Layer 4 is the selector.
It is not broad discovery.
It is not packet refresh.
It is not candidate filtering.
It is not deep analysis.

---

## Core doctrine

Binding references:
- `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`
- `08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md`

### Selection-authority law
Layer 4 is automatic and owns shortlist promotion authority.
No other layer may silently decide who belongs in the promoted/selected set.

Layer 3 may define survivors.
Layer 5 may enrich promoted members.
HUD may display the set.
Dossiers may summarize it.
Only Layer 4 decides membership.

### Stable-shortlist law
Layer 4 exists to produce a stable selected set, not a constantly twitching leaderboard.
Its job is to preserve meaningful operator trust and downstream cadence discipline.

If the shortlist changes too easily, then:
- Layer 5 churn rises
- persistence churn rises
- operator trust falls
- the scanner becomes reactive noise instead of controlled structure

### Material-change law
Layer 4 should usually wake only when shortlist state is:
- invalid
- missing
- materially outdated
- or genuinely challenged by a meaningful upstream shift

Minor upstream movement is not enough.
Layer 4 must be protected from noise.

### Hold-window law
Layer 4 may use hold behavior to prevent churn after a valid selection event.
The hold window exists to preserve stability.
It does not exist to hide invalidity.

A hold window may delay replacement pressure.
It may not justify keeping an invalid shortlist alive indefinitely.

### Hold-expiry-is-not-a-trigger law
Hold expiry alone is not sufficient reason to rebuild the shortlist.

If nothing materially changed and the shortlist remains valid, hold expiry should not create artificial rebuild churn.
This rule exists specifically to stop Layer 4 from waking up just because time passed.

### Selection-is-not-ranking-doctrine-by-accident law
Layer 4 may use architecture-defined promotion logic to choose a bounded set.
It must not become an unlimited scoring universe that continuously reorders everything merely because more math could be done.

### Attention-priority framing law
Layer 4 ranking semantics are attention priority, inspection priority, and promotion priority.
Layer 4 chooses what deserves downstream attention.
It does not declare the “best trade”.
It does not own final signal strength.

### Calmness law
Layer 4 should usually be dormant.
It is not supposed to consume every pulse or shadow every Layer 3 change.
It should wake when real selection work exists.
Otherwise it should stay calm.

---

## What Layer 4 owns

Layer 4 owns:
- shortlist / selected-set membership authority
- entry and exit decisions for the selected set
- top-per-bucket enforcement where architecture assigns it
- spill / fill policy where buckets have insufficient survivors
- anti-churn stability rules
- hold-window posture
- shortlist invalidity posture
- shortlist material-shift posture
- selection freshness state
- promotion-basis disclosure where architecture assigns it
- promotion-denial reason disclosure where architecture assigns it
- selected-set stale / degraded visibility
- Layer 4 committed shortlist artifact block

Layer 4 owns the selected set itself.
It does not merely provide hints to Layer 5.

---

## What Layer 4 does not own

Layer 4 does not own:
- market-state acquisition
- open-symbol packet construction
- candidate filtering
- deep selective analysis
- dossier composition
- HUD composition
- final trade verdict
- signal strength authority
- global persistence policy beyond its own committed shortlist artifact block
- lower-layer truth repair

If Layer 4 starts rebuilding lower layers, performing deep service itself, or acting like the final signal engine, the architecture is drifting.

---

## Primary runtime class

Layer 4 primary runtime class:
- **Promotion / Selection**

Layer 4 secondary bounded class:
- **Persistence / Write** only after a valid selection event completes and only for Layer 4-owned outputs

Layer 4 must remain a selection authority layer.
It must not degrade into a permanent sorting treadmill.

---

## Layer 4 inputs

Layer 4 may consume:
- Layer 3 survivor set
- Layer 3 eligibility posture
- Layer 3 main-bucket assignments where architecture assigns them
- Layer 3 freshness / degraded posture
- prior committed Layer 4 shortlist state for hold, stability, invalidity, and material-change comparison
- bounded architecture-defined selection metrics that remain within Layer 4 scope

Layer 4 must not depend on Layer 5 outputs to determine basic promotion membership.
Deep enrichment may inform later operator understanding, but it must not become a hidden prerequisite for selection authority unless explicitly redesigned in blueprint.

---

## Layer 4 outputs

Layer 4 produces the canonical shortlist-selection block.
Its outputs may include:
- selected / not selected posture
- selected-set membership status
- bucket position or selected position where assigned
- selection basis metadata
- promotion basis metadata
- promotion denial reason where applicable
- hold posture
- shortlist state posture
- material-shift / invalid / stable markers
- last evaluated time
- selection freshness markers
- stale / degraded posture

Layer 4 outputs must remain interpretable enough that the operator and downstream logic can understand why the current selected set exists.

### Market-Board selection-board law
The Market Board is not a casual recap of scanner state.
It is the trader-facing selection board generated from lawful shortlisted truth.
Its purpose is to let the operator judge and select symbols without having to open each dossier first.

### Board-ranking law
Top symbols shown in the Market Board must be derived from lawful shortlist output.
The board is not allowed to invent its own competing selection engine after shortlist truth already exists.

Ranking must be deterministic and consistent.
If the same shortlist truth and same ranking inputs are present, the same visible ordering must result.

Lawful ranking inputs are limited to:
- eligibility
- market condition
- execution quality
- selection context

Those inputs support attention priority, inspection priority, and promotion priority only.
They do not constitute final signal strength or “best trade” authority.

Ranking must not use:
- random ordering
- unstable heuristics
- incomplete fields
- hidden downstream improvisation

Symbols with active trades, pending orders, or exclusion flags must be handled explicitly in visible ranking behavior.
They must not be left to accidental ordering side effects.
Where architecture keeps such symbols visible, their treatment must remain inspectable and stable.
Where architecture suppresses them, that suppression must also remain explicit.

Top Overall must be derived from the grouped shortlist output rather than from a separate all-symbol ranking pass.
That means the overall board is composed from already lawful promoted members and then ordered deterministically, not rebuilt from the full universe a second time.

Where Layer 4 supports board composition, each represented symbol must be shaped as a mandatory three-line structured card:

#### Line 1 — Identity and posture
- rank
- symbol
- market status
- session
- main group
- trade status

#### Line 2 — Execution quality
- bid
- ask
- spread
- spread percentage
- tick age
- friction

#### Line 3 — Selection context
- ATR
- regime
- VWAP
- day change
- correlation profile

#### Line 4 — Correlation and exposure posture (mandatory)
- fixed compact line for every symbol in Leading Three, Full Five, and All-Markets Top Ten
- must include overall conflict class, shortlist overlap posture, open-trade/pending-order conflict posture, and compact exposure interpretation
- if degraded/unavailable, line must still render with explicit failure/degraded reason (no omission allowed)
- canonical owner wording and strict field law: `blueprint/final/ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`

This structure is mandatory doctrine for the trader-facing Market Board surface.

### Required board support fields
The board must explicitly support, where lawful and available:
- session
- spread percentage
- friction
- ATR
- regime
- VWAP
- day change
- correlation
- trade status using operator-facing states such as open / pending / excluded

### Friction law
Friction is an execution-quality indicator.
It must be derived from:
- spread
- spread percentage
- tick freshness
- session liquidity / tradability posture where admitted

### Correlation law
Correlation posture is allowed only as a bounded shortlist-context input.
It does not convert Layer 4 into the final signal engine.

---

## Canonical shortlist posture states

Layer 4 must make shortlist posture inspectable.
At minimum, it should support the following architectural states where relevant:

- **Stable**
- **Dirty-Held**
- **Invalid**
- **Material-Shift**
- **Pending**
- **Degraded**
- **Stale**

### Stable
The current shortlist remains valid and no material replacement event is justified.

### Dirty-Held
A meaningful upstream change has been detected, but hold posture currently prevents immediate churn.
The shortlist remains visible, but the system knows pressure is accumulating.

### Invalid
The shortlist can no longer be trusted as a valid selected set.
Examples may include:
- missing required members
- broken bucket posture
- unusable upstream dependency state
- absent initial shortlist where one is required

### Material-Shift
Upstream survivor truth changed enough that the current shortlist deserves reconsideration under selection policy.
This is stronger than routine noise.

### Pending
A shortlist event is expected but not yet completed.
This may occur during startup or controlled rebuild.

### Degraded
Selection truth exists only in a weakened state because freshness, upstream trust, or landing continuity is impaired.

### Stale
The last committed shortlist is still visible, but it is no longer fresh enough to be treated as current without qualification.

---

## Selection-shape doctrine

### Bounded selected set
Layer 4 must produce a bounded selected set.
The scanner should not behave as though selection simply means “all survivors, but with nicer wording.”

### Top-per-bucket law
Where architecture uses main buckets, Layer 4 may enforce a bounded top-per-bucket doctrine.
This means:
- survivors compete within their bucket
- promotion capacity is limited per bucket
- a stable representative set is produced rather than a global swarm

### Spill / fill law
If a bucket lacks enough valid survivors, Layer 4 may use spill / fill policy where blueprint allows it.
That policy must be explicit.
It must not become an excuse for arbitrary replacement churn.

### Promotion basis must stay inspectable
Layer 4 may use architecture-defined promotion logic, but it must remain bounded and explainable.
If the system cannot explain why a member is in or out, selection trust erodes quickly.

Layer 4 may expose:
- promotion basis
- promotion denial reason
- what would need to change for a symbol to enter the shortlist
- churn / hold / entry / exit reasoning

These are shortlist-authority explanations.
They are not final signal claims.

---

## Material-change doctrine

### Why materiality matters
Without a materiality threshold, Layer 4 will wake too often.
That leads to:
- shortlist churn
- deep-set churn
- write churn
- operator instability

Layer 4 therefore needs a stricter trigger standard than Layer 3.

### Material shift means meaningful challenge
A material shift should mean that survivor truth changed enough to challenge the integrity or quality of the current selected set.
Examples may include:
- a promoted member becomes ineligible
- a bucket loses validity or representation
- one or more strong challengers emerge beyond defined replacement thresholds
- shortlist freshness or upstream trust falls below acceptable bounds
- startup/recovery requires first valid shortlist creation

### Material shift is stronger than freshness movement
Routine Layer 3 refreshes, small metric movements, or minor ordering noise should not automatically count as material shift.

### Materiality must be architecture-defined
The implementation may use specific thresholds later, but the architecture must preserve this rule:
Layer 4 wakes for meaningful challenge, not for generic motion.

---

## Hold doctrine

### Why hold exists
Once a valid selected set is created, immediate replacement pressure can create unnecessary churn.
Hold exists to preserve continuity and calm.

### Hold protects continuity, not falsehood
Hold may resist churn.
It may not defend a shortlist that is clearly invalid.
If a promoted member becomes structurally disqualified or the shortlist becomes invalid, hold must yield.

### Dirty-held posture
When meaningful change appears during hold, the shortlist may enter Dirty-Held posture.
That means:
- the current shortlist remains visible
- the system acknowledges that replacement pressure exists
- a later admitted selection event may be required if the pressure persists or strengthens

### Hold expiry alone changes nothing
The end of a hold window does not by itself require a shortlist rebuild.
It only removes one reason not to rebuild.
A real reason must still exist.

---

## Scheduling doctrine

### Layer 4 should be event-driven
Layer 4 should usually wake because:
- shortlist is missing or invalid
- a first valid shortlist must be created
- a material-shift condition was reached
- a dirty-held state persisted to the point that selection review is warranted
- recovery logic requires shortlist repair

### Layer 4 should not be pulse-hungry
Layer 4 should not wake because:
- a heartbeat happened
- a page was opened
- a hold window expired with no real change
- Layer 3 refreshed harmlessly
- Layer 5 completed deep service

### Calmness is a feature
A healthy Layer 4 is often quiet.
It should not appear constantly active just to look busy.

---

## Selection freshness doctrine

### Freshness matters, but not at Layer 3 cadence
Layer 4 results must remain fresh enough to be trusted.
But shortlist freshness should not be tied directly to every small upstream freshness movement.

### Freshness should follow authority posture
Layer 4 freshness should answer:
- when the shortlist was last meaningfully evaluated
- whether the survivor truth it depends on is still trustworthy enough
- whether the current shortlist remains stable, dirty-held, stale, degraded, or invalid

### A stale shortlist may still be visible
The system may keep a last committed shortlist visible with explicit stale posture.
What it must not do is quietly pretend that stale equals current.

---

## Downstream relation to Layer 5

### Layer 4 gates Layer 5
Layer 4 promotion creates Layer 5 eligibility/readiness posture, not automatic active deep service.
Layer 5 deep service is allowed only for the set that Layer 4 promotes and only after lawful Analyse / Deep Analysis arm.
Page visibility and symbol-page navigation do not authorize Layer 5.
That makes Layer 4 the gatekeeper of deep-analysis scope.

Layer 4 hands off attention priority and promotion priority only.
It does not hand off signal ownership.

### Selection calmness protects deep calmness
If Layer 4 churns, Layer 5 churns.
Therefore shortlist stability is a direct protection mechanism for the deep-analysis layer.

### Layer 5 may not retroactively seize selection authority
Deep outputs may be useful later, but they must not be allowed to quietly redefine Layer 4 membership without explicit architectural redesign.

---

## Layer 4 artifact block

Layer 4 owns the shortlist-selection artifact block.
That block should be compact, inspectable, and atomically landed.

It should contain at minimum:
- selection posture
- selected-set membership truth
- position or bucket role where assigned
- hold posture
- shortlist state posture
- last evaluated time
- freshness / stale / degraded / invalid markers

### Artifact law
The Layer 4 artifact exists so downstream systems and operator surfaces can consume selected-set truth without recomputing promotion logic ad hoc.

### Calm publication law
Layer 4 should publish after valid selection events.
It must not create noisy write churn by re-landing cosmetic shortlist motion every pulse.

### Atomic publication
Layer 4 publication must follow temp-to-final atomic landing discipline.
A failed later layer must not erase already committed Layer 4 truth.

---

## Degraded behavior

Layer 4 must fail honestly.

### If upstream truth is insufficient
Layer 4 should use pending, invalid, dirty-held, stale, or degraded posture as appropriate rather than inventing a fresh shortlist from weak foundations.

### If a previous shortlist exists
Layer 4 may preserve last-good committed shortlist truth where architecture permits, but must clearly mark stale or degraded posture when the set is no longer fully current.

### If writes fail
Layer 4 should preserve last-good committed shortlist truth where allowed, while surfacing landed-state and freshness ambiguity honestly.

### If selection logic becomes too wide or too frequent
The design is wrong.
Layer 4 must not quietly become a permanent ranking treadmill.

---

## Downstream implications

When Layer 4 commits new or materially changed shortlist truth, it may create downstream eligibility.

Typical downstream effects:
- Layer 5 may admit deep service for promoted members
- selected-set HUD views may refresh structurally
- promoted-symbol composition priority may change where architecture assigns that role

Layer 4 does **not** automatically authorize:
- immediate deep refresh for every promoted member in the same beat
- dossier compose wave
- broad artifact flush
- HUD-triggered tactical escalation outside normal rights

Layer 4 creates eligibility, not pile-on permission.
It does not create a final trade verdict.

---

## Common failure patterns

### Pattern 1 — Constant shortlist churn
Layer 4 rebuilds too often because small upstream motion is treated as meaningful challenge.

Result:
- unstable selected set
- Layer 5 churn
- write churn
- poor operator trust

### Pattern 2 — Hold misuse
Hold is used to protect an actually invalid shortlist.

Result:
- false stability
- delayed correction
- hidden structural weakness

### Pattern 3 — Hold-expiry trigger bug
The shortlist rebuilds merely because the hold timer ended.

Result:
- artificial churn
- needless deep-set reshaping
- time-driven rather than reason-driven selection

### Pattern 4 — Hidden ranking creep
Layer 4 expands into an overactive ranking universe rather than a bounded selector.

Result:
- unclear membership logic
- unstable authority boundary
- growing runtime cost

### Pattern 5 — Deep feedback authority leak
Layer 5 or operator surfaces quietly begin influencing Layer 4 membership outside explicit architectural rules.

Result:
- selection authority becomes ambiguous
- causality becomes hard to inspect

---

## Implementation obligations

Any future MT5 implementation of Layer 4 must:
- keep selected-set authority exclusively in Layer 4
- maintain inspectable shortlist posture states
- frame ranking semantics as attention priority / inspection priority / promotion priority only
- require meaningful invalidity or material shift before rebuild
- keep hold behavior explicit and bounded
- ensure hold expiry alone does not trigger rebuild
- preserve clear separation between bucketing, selection, deep service, and downstream signal interpretation
- expose promotion basis and denial reasoning where architecture assigns them
- publish Layer 4 artifacts atomically
- surface stale, degraded, dirty-held, and invalid posture honestly
- refuse constant-churn, hidden-ranking drift, or “best trade” language creep

If an implementation cannot explain why a symbol is currently selected or not selected, that implementation is incomplete.

---

Layer 4 must not be reinterpreted into a page-open-triggered shortlist churn loop.
Layer 4 must not quietly auto-start Layer 5 because promotion exists.

## Stage 4 Layer 4 field-contract completion

This section completes the Layer 4 field contract.
If earlier wording is less explicit, this section wins.

### Doctrine tiers

#### Hard law
Layer 4 is attention-priority shortlist authority only.
Rank means attention priority, not signal superiority, not expected-profit ranking, and not final trade ranking.

#### Required product contract
Every Layer 4 publication must expose one complete shortlist contract with selection state, attention rank framing, promotion basis, denial posture, hold/churn posture, exposure context, and freshness/stability posture.

#### Future expansion option
Future work may add richer cross-bucket comparison fields, richer portfolio overlap diagnostics, or richer shortlist narratives.
Those remain optional unless later promoted into required law.

### Required Layer 4 fields

#### Selection core
- `symbol`
- `selection_state`
- `attention_priority_rank`
- `shortlist_posture`
- `shortlist_reason`
- `bucket`

`selection_state` must remain within shortlist-neutral families such as:
- `selected`
- `not_selected`
- `pending`
- `held`
- `invalid`
- `degraded`
- `stale`

#### Promotion contract
- `promotion_basis`
- `promotion_basis_reason`
- `promotion_denial_reason` where not selected
- `what_changes_to_enter`

#### Hold / stability / churn contract
- `hold_state`
- `hold_reason`
- `stability_state`
- `churn_risk_state`

#### Correlation / exposure contract
- `correlation_posture`
- `exposure_posture`
- `concentration_warning` where applicable

#### Freshness / continuity contract
- `selection_observed_at`
- `selection_published_at`
- `selection_freshness_state`
- `selection_stability_window` or equivalent stability timing field

### Optional Layer 4 enrichments
Optional enrichments may include:
- alternate attention-order views
- bucket-cap pressure notes
- spill / fill explanation detail
- richer overlap notes

Optional enrichments must not recast Layer 4 as a signal engine.

### Always-visible consumer minimum
Any consumer rendering of Layer 4 must always show:
- selection state
- attention priority rank
- shortlist posture
- shortlist reason
- bucket
- promotion basis or denial reason
- what must change to enter
- hold / stability posture
- correlation / exposure warning when present
- freshness / stability posture

### Entry / hold / exit reasoning law
Layer 4 must be able to explain:
- why a symbol is in
- why it is being held
- why it is out
- what would materially change that posture

That explanation remains shortlist governance only.
It must not become final trade advice.

## Final standard

Layer 4 is correct when it turns Layer 3 survivors into a stable, bounded, explainable selected set that drives downstream attention without pretending to be the final signal engine.

That means Layer 4 must be:
- authoritative
- stable
- materially triggered
- hold-aware
- calm by default
- atomically committed
- inspectable under pressure
- attention-priority framed
- hostile to churn and hidden ranking creep

The standard is not that Layer 4 produces a list.
The standard is that Layer 4 produces a trustworthy promoted set that downstream layers and operator surfaces can rely on without second-guessing its legitimacy.

