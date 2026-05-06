# ASC Persistence and Artifact Families

## Purpose

This document defines the canonical persistence model and artifact-family structure of Aurora Sentinel Scanner (ASC).

Persistence is not residue.
It is not whatever happens after runtime work “finishes.”
It is one of the trust boundaries of the scanner.

ASC may hold truth in memory for short periods, but truth becomes operationally durable only when it lands in the correct artifact family under explicit atomic rules, freshness visibility, and last-good continuity policy.

This file exists to make that landing model explicit.

Tactical realtime field write permissions and cadence separation are normatively bound to `ASC_TACTICAL_REALTIME_FIELD_CONTRACT.md`.

---

## Core doctrine

### Persistence-is-structural law
Persistence is part of the operating system of ASC.
If truth cannot land safely, consistently, and inspectably, then the upstream layer is not complete.

### Artifact-family law
Not all files are the same kind of thing.
ASC must separate artifacts by family so that:
- ownership stays clear
- consumers know what they are reading
- freshness expectations stay honest
- recovery behavior remains explainable
- operator surfaces do not accidentally depend on the wrong class of output

### Layer-owned-publication law
Each layer owns the publication of its own truth block.
A later layer may consume earlier artifacts.
A later layer may not rewrite earlier layer meaning.

### Atomic-landing law
Important artifact publication must use atomic landing discipline.
The canonical pattern is:
1. prepare candidate output
2. write temp artifact
3. validate landing conditions where required
4. promote temp artifact to canonical path
5. preserve last-good state where the artifact family requires it
6. update landed-state and freshness metadata

A write is not considered complete merely because bytes were emitted somewhere.

### Last-good continuity law
Some artifact families must preserve last-good continuity so the scanner can remain usable under bounded degradation.
That continuity exists to preserve trustable visibility.
It must never be used to fake freshness.

### Calm-publication law
Persistence cadence is not display cadence.
ASC must not attempt to write artifacts at the same speed that tactical fields move on screen.
Publication must remain calm, selective, and architecture-led.

### Dossier-is-not-transport law
Dossiers, summaries, and similar operator-facing compositions are not allowed to become the birthplace of scanner truth.
They are consumer surfaces.
They are built from already-owned layer truth and supporting artifact families.

### Runtime-publication-only law for operator artifacts
Board, Current Focus, and Dossiers are runtime-published artifacts.
Blueprint/roadmap/stage files may define contracts, schema, and path doctrine only.
Static repo-side scaffold files are forbidden as substitutes for runtime publication evidence.


### Publication-bundle family law
Market Board, Current Focus, Open Symbol Snapshot, and the Dossier set land as one publication bundle for each write pass.

### Shared-header law
Each published Market Board, Current Focus, Open Symbol Snapshot, and Dossier artifact must begin with:
- `Publication Id:`
- `Publication UTC:`

### Bundle-manifest law
The publication owner writes one authoritative manifest artifact named `Artifact Bundle Manifest.txt`.

### Manifest minimum content
The manifest must state:
- `Publication Id`
- `Publication UTC`
- `Market Board status`
- `Current Focus status`
- `Open Symbol Snapshot status`
- `Dossier count attempted`
- `Dossier count succeeded`
- `Dossier count failed`
- overall bundle status

### Manifest ordering law
The manifest is written last for the pass.

### Failure-truth law
Last-good artifacts may remain when a write fails, but the manifest for the current pass must report the current pass truth.

### One-promote-path law
Direct-to-final writes outside the common atomic promote path are not allowed.

### Publication logging truth law
When publication write or promote fails, logging must include bundle identity, artifact family, operation name, temp path, final path, error code, retained-last-good result, and short reason text.
When publication succeeds, logging should confirm write/promote completion with the same artifact path pairing.

---

## What persistence owns

The persistence system owns:
- artifact family boundaries
- atomic landing discipline
- temp-to-final promotion behavior
- last-good preservation where assigned
- landed / pending / failed / degraded visibility for artifact publication
- artifact freshness metadata at the persistence boundary
- write retry posture where architecture permits it
- artifact-family calmness and selective publication policy
- restore-read trust posture from landed artifacts
- write auditability and lineage metadata

Persistence owns landing and continuity.
It does not own truth invention.

---

## What persistence does not own

Persistence does not own:
- market-state truth definition
- packet truth definition
- filter truth definition
- shortlist authority
- deep-analysis authority
- HUD presentation wording
- discretionary architecture changes

If persistence begins inventing upstream meaning, the architecture is drifting.

---

## Canonical artifact families

ASC should separate artifacts into clear families.
The exact folder layout may evolve later, but the family boundaries must survive.

### Family 1 — Layer transport artifacts
These are the canonical landed truth blocks produced by Layers 1 through 5.

Examples:
- Layer 1 market-state block
- Layer 2 open-symbol snapshot block
- Layer 3 candidate-filtering block
- Layer 4 shortlist-selection block
- Layer 5 deep-analysis block

Role:
- machine-usable structural truth
- downstream consumption without re-derivation
- recovery support
- operator-surface hydration support

These are the most important persistence family because they carry the actual scanner truth stack.

### Family 2 — Runtime control and telemetry artifacts
These artifacts describe runtime posture rather than symbol truth.

Examples:
- governor mode state
- heartbeat telemetry snapshots
- starvation flags
- backlog/queue posture summaries
- runtime counters
- landing diagnostics

Role:
- runtime inspection
- debugging
- health visibility
- operator/system audit support

These must not be confused with the scanner’s symbol truth itself.

### Family 3 — Recovery and continuity artifacts
These artifacts preserve restart/recovery continuity and support re-entry into trustworthy operation.

Examples:
- last-good preserved blocks where assigned
- recovery checkpoints
- landing continuity metadata
- safe restore support markers

Role:
- bounded continuity under degradation
- restart assistance
- explicit separation between fresh truth and last-good support

These artifacts support trust.
They must never masquerade as newly current truth.

### Family 4 — Human-readable operator artifacts
These artifacts are built for human consumption rather than primary transport.

Examples:
- symbol dossiers
- scanner summaries
- operator-readable reports
- promoted-set overviews

Role:
- interpretive or presentation-friendly surfaces
- condensed operational visibility
- human-readable structure on top of landed truth

These artifacts consume truth.
They do not originate it.

### Family 5 — HUD support artifacts
These artifacts support structural HUD hydration where direct tactical reads are not appropriate or where persisted structure is the correct source.

Examples:
- prepared structural overview surfaces
- committed bucket/shortlist structural support blocks
- safe HUD hydration inputs derived from landed layer truth

Role:
- stable HUD consumption
- separation between fast tactical views and structural committed views
- calmer page hydration

These artifacts remain secondary to the underlying layer transport truth.

### Family 6 — Audit and lineage artifacts
These artifacts preserve write history, lineage, and publication traceability.

Examples:
- artifact lineage markers
- publication version records
- write outcome logs
- minimal integrity or landing audits where assigned

Role:
- explainability
- investigation support
- recovery confidence
- detection of mixed-cycle ambiguity

These must remain useful and bounded.
They must not become uncontrolled log sprawl.

---

## Publication order doctrine

ASC publication order must respect the truth hierarchy.
The canonical order is:

1. Layer 1 market-state artifact block
2. Layer 2 open-symbol snapshot artifact block
3. Layer 3 candidate-filtering artifact block
4. Layer 4 shortlist-selection artifact block
5. Layer 5 deep-analysis artifact block
6. human-readable or HUD-support compositions built from the landed blocks above

This order exists because richer surfaces must not outrun foundational truth.
A summary that appears before the underlying layer block lands is not trustworthy.

### Human-readable artifact law
Among the downstream human-readable artifacts, operator-facing families are especially important:
- the Market Board (major-group view)
- subgroup context embedded in the canonical Market Board rows (no separate board artifact)
- the per-symbol dossier file at `Dossiers/<SYMBOL>.txt`
- the Current Focus singleton view

These are not truth-birth surfaces.
They are downstream compositions built from already landed layer-owned and family-owned truth.

### Classification-derived grouping law (mandatory)
For board and dossier-facing grouping surfaces:
- grouping must derive only from broker/classification truth
- no fixed universal major-group assumptions are allowed
- synthetic fill, fake membership, and fake counts are forbidden even when template layout would otherwise look sparse
- board artifacts must adapt truthfully to sparse universes and stock-heavy universes, including explicit availability posture when bucket coverage is thin

### Sub-group board requirement for large universes
When universe size and subgroup depth materially affect selection quality, subgroup detail must remain visible inside the canonical Market Board rows.
It must not require a second board artifact.

### Operator-visible naming model (two-layer, mandatory)
ASC must preserve two naming layers:

1. **Internal schema identifiers allowed**
   - Schema/runtime keys can remain technical (for example: `all_markets_top_10`, `artifact_family`, `shortlist_correlation_ready`).
2. **Operator-visible naming must be trader-safe**
   - Operator-facing section headings and filenames must use canonical trader-safe names, not internal runtime jargon.

Canonical operator-visible names:
- `Market Board`
- `Current Focus`
- `Dossiers/<SYMBOL>.txt`

### Operator-visible heading prohibition list
Do not use the following in operator-visible headings/titles:
- layer/stage jargon: `Layer 1`–`Layer 5`, `Stage`, `Phase`, `Pipeline`
- internal runtime wording: `runtime`, `telemetry`, `governor`, `artifact_family`, `schema_version`, `transport`, `hydration`, `packet`

### Market Board doctrine
The Market Board is the trader-facing selection board at server scope.
It must not collapse into a thin text dump.
Where published, it must support per-symbol three-line card composition carrying:
- identity and posture
- execution quality
- selection context

That downstream board must be rich enough that lawful symbol selection can happen without opening every dossier first.

At summary level, friction must be a compact execution-quality classification derived from spread, spread percentage, tick freshness, and session liquidity conditions.
Allowed operator-facing friction values are:
- Low
- Moderate
- High
- Severe

At summary level, correlation must remain compact and human-readable.
It exists to prevent over-concentration and conflict and must consider, where lawful and available:
- current open trades
- pending orders
- symbol grouping overlap
- currency exposure overlap for FX
- asset-class exposure overlap
- sector or theme exposure where applicable

Allowed summary-level correlation classifications are:
- Low conflict
- Moderate overlap
- High overlap
- Blocked

All-Markets Top 10 visibility is gated.
It is operator-visible only when Shortlist correlation readiness is true.
When withheld, the board must include this exact operator-visible failure-state wording:
- `All-Markets Top 10 withheld: candidate-summary correlation support is unavailable.`


### Board section contract inside Family 4 (mandatory)
For the canonical Market Board artifact, persistence must enforce section-level payload expectations:

- `account_and_risk_snapshot` is mandatory and must include:
  - `balance`, `equity`, `free_margin`, `used_margin`, `margin_level`
  - `open_trades`, `pending_orders`, `open_risk_estimate`, `exposure_note`
- `excluded_or_already_active` is mandatory and each row must include:
  - `symbol`, `status`, `direction`, `entry`, `stop`, `target`, `stop_size`
  - optional operator-facing style label is allowed for pending orders (for example Unicorn-style), but explicit operational meaning in `status` is mandatory

### Board refresh cadence and publication posture (mandatory)
Persistence must carry section-aware cadence and continuity behavior rather than one flat board timestamp:

- selection sections (`top_3_per_bucket`, `top_5_per_bucket`): refresh each board publish cycle
- account/risk snapshot section: refresh each board publish cycle, with explicit stale age when data feed is late
- excluded/already-active section: refresh each board publish cycle from trade/order state
- `all_markets_top_10`: compact and correlation-gated; publish only when shortlist correlation readiness is true

Section-level publication posture must remain explicit (`fresh`, `stale`, `degraded`, `continuity`, `failure`) with reason metadata where relevant.
No board section may silently disappear on failure.

### Symbol dossier doctrine
The symbol dossier is the deep intelligence file for one symbol.
It is a downstream composed artifact that should gather the richest lawful per-symbol view without becoming the birthplace of truth.

Dossier composition is section-contract based.
A valid dossier must include all mandatory sections below and may not flatten Deep Analysis into a single undifferentiated blob.

#### Mandatory dossier sections and source-family contracts
1. **Operator Snapshot**
   - required fields: `symbol`, `canonical_symbol`, `publish_time_utc`, `scanner_mode`, `dossier_publication_state`
   - source family: Family 4 composition from Family 1 + Family 2
2. **Account and Trade Context**
   - required fields: `balance`, `equity`, `free_margin`, `used_margin`, `margin_level`, `open_trades`, `pending_orders`, `open_risk_estimate`, `exposure_note`
   - source family: Family 2, continuity-backed by Family 3 where assigned
3. **Selection**
   - required fields: `selection_state`, `selection_reason`, `selection_rank`, `selection_bucket`, `correlation_score`, `correlation_top`, `correlation_high`, `correlation_low`, `correlation_conflict_interpretation`
   - source family: Family 1 Layer 4 shortlist truth
   - correlation line is mandatory and must include score + top/high/low + conflict interpretation
4. **Live Market**
   - required fields: `bid`, `ask`, `spread`, `spread_pct`, `tick_age_ms`, `market_status`, `market_status_reason`
   - source family: Family 1 Layer 1 + Family 2 freshness telemetry
5. **Trading Conditions**
   - required fields: `broker_spec_summary`, `min_stop_distance`, `lot_step`, `contract_size`, `trading_session_state`, `session_liquidity_posture`, `friction_classification`
   - source family: Family 1 structural specs + Family 2 session telemetry
6. **Classification**
   - required fields: `asset_class`, `group`, `subgroup`, `regime`, `classification_confidence`
   - source family: Family 1 Layer 3/4 outputs
7. **Market Context**
   - required fields: `day_open`, `day_high`, `day_low`, `prev_day_high`, `prev_day_low`, `vwap`, `atr`, `context_summary`
   - source family: Family 1 market-state/derived analytics
8. **Deep Analysis**
   - mandatory structured subsections: `thesis`, `levels_and_invalidation`, `scenario_paths`, `risk_controls`, `evidence_and_confidence`
   - required Stage 3 control metadata when Deep Analysis is armed or published: `output_mode`, `enabled_timeframes`, `timeframe_completeness`, `bars_requested`, `minimum_bars_required`, `bars_copied`, `bars_missing`, `sufficiency_posture`
   - required optional-evidence metadata when enabled: `atr_settings`, `atr_posture`, `spread_settings`, `spread_statistics`, `spread_sufficiency_posture`, `tick_settings`, `tick_statistics`, `tick_sufficiency_posture`
   - source family: Family 1 Layer 5 deep-analysis truth
9. **Aurora Signal / Semi-Auto / Full Auto scaffolds**
   - required fields: `aurora_signal_state`, `semi_auto_state`, `full_auto_state`, `activation_guardrails`, `non_active_state_wording`
   - source family: Family 4 composition with readiness dependencies from Family 1/2
   - each scaffold is mandatory and must state explicit non-active wording when inactive
10. **Dossier Status + Last Actions/Proof**
    - required fields: `dossier_status`, `status_reason`, `last_actions`, `proof_lines`, `publication_state`, `last_successful_publish_at`
    - source family: Family 6 audit/lineage + Family 4 rendering

#### Freshness, degraded, and continuity law for dossier sections
- Every dossier section must carry section-level metadata: `publication_state`, `state_reason`, `source_age_ms`, `continuity_state`, `last_refreshed_at`.
- Default expectation is fresh-on-publish for every section.
- Continuity use is lawful only when explicitly labeled as `continuity` with last-good source/timestamp.
- Stale/degraded states must carry explicit reason metadata and must not masquerade as fresh.

#### Failure visibility and optionality law
- No mandatory section may be dropped silently.
- On failure, the section remains present with explicit `failure` state and named missing fields/components.
- Required fields listed above are mandatory unless a field is intrinsically non-applicable; in that case, use operator-safe value-state wording (`not applicable`, `not yet observed`, `unavailable`, `last confirmed value`, `awaiting next refresh`) instead of omission.
- Optional extensions (for example `operator_note`, `condition_notes`, `taxonomy_version`, `higher_timeframe_note`, `operator_appendix`, `next_recovery_step`) may enrich but never replace mandatory fields.

---

## Layer transport artifact doctrine

### Purpose
Layer transport artifacts are the primary persisted truth carriers of ASC.
They must be:
- compact enough to land calmly
- explicit enough to support downstream consumption
- versioned and freshness-aware
- owned by exactly one layer

### Ownership
Every layer transport artifact must declare:
- owning layer
- artifact family
- write conditions
- required freshness posture metadata
- whether last-good continuity applies
- primary consumers

### Layer transport artifacts must remain machine-truth first
They are allowed to be human-readable too, but their first job is correct transport and continuity of scanner truth.

---

## Runtime control artifact doctrine

### Control artifacts are not truth artifacts
Runtime control and telemetry artifacts must remain clearly separate from symbol truth artifacts.
The system must not make the operator guess whether they are reading scanner truth or runtime posture.

### Good control artifacts answer questions like
- what mode is the governor in
- which lane owned recent beats
- what class is starving
- what artifact family is awaiting landing
- what degraded boundary has been crossed

These artifacts support control clarity, not scanner selection decisions.

---

## Recovery artifact doctrine

### Recovery artifacts support re-entry, not blind trust
A recovery artifact may help ASC resume intelligently after restart or disruption.
It may not allow the system to skip revalidation where live truth is required.

### Recovery artifacts should make explicit
- what was last known good
- when it was last landed
- whether it is continuity support or fresh truth
- what still needs live revalidation

### Recovery artifacts must preserve humility
Persisted continuity can be useful.
It is not permission to claim present truth without re-earning it.

---

## Human-readable artifact doctrine

### Human-readable artifacts are consumer surfaces
Dossiers, summaries, and other operator-facing compositions must be built from landed layer truth and supporting families.
They must never become the runtime’s hidden transport layer.

### Human-readable artifacts should prefer
- stable wording
- explicit freshness posture
- current selected-set and mode posture
- structural truth already committed elsewhere

### Human-readable artifacts should avoid
- re-deriving scanner truth during read time
- embedding hidden ranking logic
- outrunning the underlying transport artifacts
- publishing faster than structural truth can honestly support

---

## HUD support artifact doctrine

### HUD support artifacts serve structure, not tactical speed
These artifacts exist so the HUD can hydrate calm structural views from landed truth.
They should not attempt to replace tactical direct reads for fast-moving selected-symbol fields.

### Hybrid HUD law at the artifact boundary
ASC must preserve the distinction between:
- structural committed truth for stable HUD surfaces
- tactical direct reads for explicitly allowed fast-moving views

HUD support artifacts belong to the first category.
They are not a disguised same-speed market feed.

---

## Audit and lineage doctrine

### Why lineage matters
ASC must be able to answer:
- which version of a layer block landed
- what upstream layer state it depended on
- whether a human-readable artifact is mixed-cycle or coherent
- whether a stale view is last-good continuity or newly refreshed truth

### Audit artifacts should stay bounded
Auditability is necessary.
Log sprawl is not.
Audit and lineage surfaces must remain purposeful and inspectable rather than becoming a dumping ground for every runtime event.

---

## Atomic write doctrine

### Canonical landing sequence
The canonical atomic landing sequence is:
1. gather the layer-owned or family-owned publishable state
2. build the candidate artifact payload
3. write to a temp path or equivalent staging surface
4. verify that staging succeeded where required
5. promote to the canonical artifact path atomically
6. update last-good preservation if required
7. update lineage and landed-state metadata
8. mark prior pending state as resolved

### Atomic means consumer trust is protected
A consumer should see either:
- the prior committed artifact
- or the new committed artifact

A consumer should not have to reason about half-landed structural truth.

### Atomic does not require frenzy
Atomic discipline protects integrity.
It does not justify constant high-frequency writes.

---

## Publish-threshold doctrine

### Why thresholds exist
Not every internal state twitch deserves an artifact landing.
Publish thresholds exist so persistence remains meaningful rather than noisy.

### Threshold questions
Every artifact family should answer:
- what change is material enough to publish
- whether time-based calm publication applies
- whether state transition alone justifies landing
- whether landing is best-effort or required
- what freshness age makes landing mandatory

### Typical landing reasons
A landing may be justified because:
- a layer completed a meaningful new committed block
- a state transition occurred
- freshness/degraded posture crossed a material threshold
- recovery required continuity stabilization
- a protected family reached maximum allowed landing age

### What should not usually justify landing
- cosmetic field flicker
- tactical display movement alone
- speculative downstream interest
- page visibility alone

---

## Last-good doctrine

### Why last-good exists
Last-good preservation exists so the scanner remains usable when the newest publish attempt fails, when fresh truth is delayed, or when a family is permitted to show continuity-backed state.

### Last-good must remain explicit
A last-good artifact must never be ambiguous with a freshly landed artifact.
Metadata and consumer rules must preserve that distinction.

### Not every family needs last-good equally
Layer transport families often deserve stronger last-good protection than temporary HUD support artifacts.
The architecture may vary by family, but it must be explicit.

### Last-good is a support surface, not a permission slip
Last-good continuity helps preserve trust.
It must not be used to disguise structural staleness as current truth.

---

## Retry and failure doctrine

### Persistence must fail honestly
When landing fails, the system must know:
- which family failed
- whether the prior committed artifact remains usable
- whether last-good protection was preserved
- whether the family is now pending, degraded, or failed
- whether retry is required now or later

### Retry posture must be bounded
Retries may be allowed where architecture defines them.
Retry policy must remain bounded and family-sensitive.
The scanner must not enter uncontrolled write loops.

### Failure classification
Persistence should distinguish cases such as:
- staging failed
- promotion failed
- metadata update failed
- continuity preservation failed
- family left pending

This improves recovery and debugging.

---

## Recovery and restore doctrine

### Restore reads must know what they are reading
When ASC restores from artifacts, it must know whether an artifact is:
- fresh committed truth
- stale committed truth
- last-good continuity support
- partial or invalid family state

### Restore should be family-aware
Different families may have different restore trust posture.
For example:
- Layer 1 last-good may support warm restart visibility but still require live revalidation
- human-readable summaries may be safe to show as stale until rebuilt
- tactical HUD views should usually not be restored as if they were live feeds

### Recovery must preserve humility
Restore is a support mechanism.
It must not turn persisted optimism into present-tense claims.

---

## Consumer doctrine

### Consumers must know artifact family
Any consumer of ASC persistence should know:
- which family it is reading
- what freshness guarantees that family carries
- whether the artifact is current, stale, degraded, or last-good continuity-backed
- whether it is structural truth or presentation-friendly composition

### Consumers must not silently fuse families
A HUD page or operator summary must not blur:
- structural layer truth
- runtime telemetry
- last-good continuity support
- tactical direct reads

These must remain interpretable.

---

## Calmness doctrine

### Persistence calmness is a feature
The scanner should land meaningful truth calmly and predictably.
Noisy persistence degrades:
- performance
- auditability
- operator trust
- recovery clarity

### Calmness is not starvation
Calm publication does not mean leaving important families pending indefinitely.
The governor must still protect bounded landing age and atomic safety for important families.

### The target balance
ASC should prefer:
- landing when truth is meaningful
- landing before guarantees expire
- avoiding same-speed noise
- preserving family identity under pressure

---

## Common failure patterns

### Pattern 1 — Dossier transport inversion
Human-readable dossiers become the hidden source of truth instead of consuming layer-owned structural artifacts.

Result:
- truth ownership blurs
- recovery becomes fragile
- operator surfaces outrun real structure

### Pattern 2 — Same-speed write contamination
Artifacts attempt to land as fast as tactical or fast-moving values change.

Result:
- write pressure rises
- calmness is lost
- atomic landing becomes noisy and expensive

### Pattern 3 — Family confusion
Runtime telemetry, layer truth, last-good support, and operator compositions are mixed together with weak boundaries.

Result:
- consumers do not know what they are reading
- restore posture becomes dangerous
- stale truth masquerades as current

### Pattern 4 — Last-good ambiguity
A consumer cannot tell whether the artifact is freshly landed or merely preserved continuity.

Result:
- trust erosion
- debugging difficulty
- wrong downstream behavior

### Pattern 5 — Landing as residue
Truth is computed correctly in memory but publication is repeatedly deferred as “later.”

Result:
- runtime and persisted truth diverge
- the scanner looks alive but is not trustably landed

---

## Implementation obligations

Any future MT5 implementation of ASC persistence must:
- separate artifacts into explicit families
- preserve one owning layer or owner per structural artifact block
- use atomic temp-to-final landing for important artifacts
- expose landed, pending, stale, degraded, failed, and last-good posture honestly
- preserve last-good continuity only where explicitly assigned
- keep dossier and summary artifacts downstream of landed layer truth
- keep persistence cadence separate from tactical display cadence
- preserve lineage metadata sufficient to detect mixed-cycle ambiguity
- support restore reads with family-aware trust posture
- refuse family confusion and write-frenzy drift

If an implementation cannot explain what family an artifact belongs to, that implementation is incomplete.

---


## Stage 5 artifact-family consolidation note

### Hard law
- Layer-owned transport truth remains upstream of all operator artifacts.
- Market Board, Dossier, and Current Focus are consumer artifacts only.
- Consumer artifacts may never become hidden truth owners, signal dashboards, or substitutes for layer-owned publication evidence.

### Required product contract
- Artifact-family wording must stay consistent with the board/dossier/current-focus contract and the symbol-information spine.
- Publication metadata must make it obvious whether Layer 5 is complete, partial, degraded, continuity-backed, or unavailable.
- Current Focus must follow selected-symbol context without implying automatic deep-service completion.

### Future expansion option
Later implementation may enrich layout, manifests, or section presentation, but not artifact ownership or depth ceilings.


## Final standard

ASC persistence is correct when it lands scanner truth in the right artifact families with atomic integrity, explicit freshness posture, last-good honesty, and calm publication discipline.

That means persistence must be:
- family-explicit
- layer-owned where structural truth is concerned
- atomic
- lineage-aware
- continuity-capable without freshness fraud
- restore-aware
- calm without becoming residue
- hostile to dossier inversion and write frenzy

The standard is not that files exist.
The standard is that landed artifacts remain trustworthy enough that operators, HUD surfaces, and recovery logic can consume them without confusion.
---

## Artifact doctrine hardening addendum (Board, Dossier, Current Focus)

This addendum is normative and takes precedence when more generic persistence wording is ambiguous.

### Market Board required-role law
Market Board is a Family 4 human-readable consumer artifact for **inspection priority**, not a signal board.

Required persistence truths:
1. Market Board must publish as a compact cross-symbol inspection surface.
2. Market Board stops at Layer 4 depth.
3. Market Board may show only compact deep-readiness posture, never Layer 5 payload internals.
4. Market Board must preserve distinct sections for:
   - Leading Three
   - Full Five
   - Passed Filter, Outside Shortlist
   - Account and Risk Snapshot
   - Excluded / Already Active
5. Board-level freshness, shortlist posture, correlation/exposure posture, and withheld-section truth must remain visible.

### Dossier-as-intelligence law
Dossier is the full per-symbol intelligence artifact in Family 4.

Required persistence truths:
- it must remain useful with or without deep-analysis completion
- it must expose section-level publication metadata
- it must expose failure, degraded, stale, and continuity posture explicitly
- it may consume Layer 1-5 truth when available
- it does not originate truth and must not become a signal surface

### Current Focus single-file replacement law
Current Focus is exactly one visible Family 4 working artifact at any time.

Required persistence truths:
- it follows selected-symbol context
- symbol switch rewrites the same canonical file in place
- it must not remain silently pinned to an older symbol
- it may closely mirror dossier depth for the selected symbol
- it remains distinct from dossier because it is the current working artifact, not the archival per-symbol artifact

### Publication-state matrix law per artifact
Market Board, Dossier, and Current Focus must all surface the canonical publication states:
- `pending`
- `fresh`
- `stale`
- `degraded`
- `continuity`
- `failure`



### Stage 3 Deep Analysis publication law
When Dossier or Current Focus carries Deep Analysis, the artifact must make the control/completeness contract inspectable.

Required publication truths for each enabled timeframe:
- requested bars
- minimum required bars
- copied bars
- missing bars
- sufficiency posture

Required publication truths for enabled ATR / spread / tick blocks:
- control settings used
- sample counts collected
- explicit sufficiency posture
- `not_enabled` vs `pending` vs `unavailable` distinction

Output mode may change projection density, but it must not suppress:
- symbol identity
- freshness
- continuity/degraded/failure posture
- timeframe completeness posture
- handoff-direction posture where the handoff block is shown

### Role-separation persistence law
- Market Board publication must remain Layer 1–4 consumer publication only; it must not publish Deep Analysis payloads as if board depth extended beyond Layer 4.
- Dossier publication may carry the full per-symbol intelligence packet, including lawful Layer 5 completion where present.
- Current Focus publication is the singleton selected-symbol working artifact and may mirror lawful dossier depth for that symbol, but its existence alone does not prove Deep Analysis completion.
- No artifact family may let menu/settings, page-open, or consumer convenience create upstream truth that the layer-owned transport artifacts did not produce.
Persistence and publication code must preserve these roles:
- Market Board = what to inspect now
- Dossier = full per-symbol intelligence artifact
- Current Focus = currently selected-symbol working artifact

No publication family may silently fuse or swap those roles.
