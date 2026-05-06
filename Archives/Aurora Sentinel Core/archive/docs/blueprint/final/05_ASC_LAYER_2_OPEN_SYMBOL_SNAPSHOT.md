# ASC Layer 2 Open Symbol Snapshot

## Purpose

This document defines the canonical design of Layer 2 in Aurora Sentinel Scanner (ASC).

Layer 2 is the open-symbol snapshot owner.
Its job is to expand broad market-state truth into a bounded current-state packet for symbols that have earned snapshot service.

Layer 2 exists to answer the next honest question after Layer 1:

> for the symbols that matter now, what is the current usable packet of market-facing truth?

Layer 2 is not the shortlist.
It is not a ranking engine.
It is not a dossier engine.
It is not a hidden deep-analysis surface.

It is the bounded packet builder.

---

## Core doctrine

Binding references:
- `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`
- `ASC_TACTICAL_REALTIME_FIELD_CONTRACT.md`

### Open-subset expander law
Layer 2 is part of the automatic preparation engine.
Layer 2 operates on an admitted subset rather than on the full universe.
Its natural center of gravity is the current open subset, or another explicitly admitted near-open / transition-relevant subset defined by runtime posture.

This is the key performance doctrine of Layer 2:
- Layer 1 stays broad and cheap
- Layer 2 becomes faster and richer on the smaller admitted set
- Layer 2 does **not** widen back into universe-scale same-speed service

### Packet-not-judgment law
Layer 2 builds packet truth.
It does not decide candidate worthiness, shortlist promotion, or deep priority.
It may produce the fields that later layers consume.
It may not silently assume those later roles.

### Current-state law
Layer 2 owns current usable packet truth rather than heavy historical depth.
Its purpose is to capture the present packet cleanly enough that later cheap filtering can operate honestly.

### Last-good continuity law
Because Layer 2 truth is operationally important and can become temporarily unavailable or stale, Layer 2 must preserve controlled last-good continuity where architecture permits it.

That continuity exists to preserve trustable operator surfaces.
It does not exist to hide degradation.
If Layer 2 is stale or degraded, it must say so explicitly.

### Tactical-focus law
Layer 2 may support focused-symbol tactical reads for its own packet fields only.
That right exists so the operator can see fast-moving fields on the selected symbol.
It does not authorize Layer 3, Layer 4, Layer 5, or broad write churn.

### No-timid-drip law
Layer 2 may execute packet service through repeated intra-beat micro-bursts when lawful.
Layer 2 should be selective, but it must not become artificially timid.
Once the admitted subset is known, Layer 2 should service it with reasonable pace and breadth.
Slow drip-feed behavior that starves current packet freshness is not a virtue.
Layer 2 must not be slowed into fake calm tiny once-per-second service if the class remains narrow and lawful.

---

## What Layer 2 owns

Layer 2 owns:
- current packet truth for admitted symbols
- packet freshness state
- bid / ask / spread packet capture
- day high / day low or day-range packet fields where assigned
- point / digits and static tradability packet fields where assigned
- packet continuity and last-good posture for Layer 2-owned fields
- focused-symbol tactical refresh for Layer 2-owned fields when explicitly permitted
- Layer 2 committed packet artifact block
- Layer 2 degraded / stale visibility

Layer 2 owns packet truth itself.
It does not merely provide hints to other layers.

---

## What Layer 2 does not own

Layer 2 does not own:
- universe-wide market-state classification
- candidate filtering
- bucket assignment
- shortlist selection
- deep selective analysis
- dossier composition
- HUD composition beyond explicitly permitted tactical field refresh
- global persistence policy beyond its own committed artifact block
- downstream cadence policy

If Layer 2 starts absorbing these roles, the architecture is drifting.

---

## Primary runtime class

Layer 2 primary runtime class:
- **Snapshot / Read**

Layer 2 secondary bounded class:
- **Persistence / Write** only after packet readiness has been earned for the affected symbol and only for Layer 2-owned outputs

Layer 2 must remain a packet builder.
It must not smuggle filtering, promotion, or deep-analysis behavior into packet service.

---

## Layer 2 inputs

Layer 2 may consume:
- Layer 1 market-state truth
- direct current market-facing packet fields for admitted symbols
- symbol metadata needed for packet completeness where assigned
- prior committed Layer 2 continuity state as support only
- focused-symbol tactical read posture when explicitly authorized by HUD/runtime rules

Layer 2 must not require later-layer truth to build its primary packet.

---

## Layer 2 outputs

Layer 2 produces the canonical current-state packet block for admitted symbols.
Its outputs may include:
- bid
- ask
- spread
- point
- digits
- day high
- day low
- day range or equivalent daily posture fields where assigned
- static tradability packet fields where assigned
- packet freshness markers
- last built time
- stale / degraded posture
- last-good continuity markers where relevant

Layer 2 outputs must remain compact enough to land calmly and rich enough to support Layer 3 honestly.

---

## Admission doctrine

### Layer 2 depends on Layer 1
Layer 2 is not allowed to pretend packet truth on symbols whose Layer 1 posture is still unknown in an uncontrolled way.

Layer 1 tells the scanner whether the symbol is meaningfully in scope for current packet service.
Only then does Layer 2 gain honest admission.

### Default admitted subset
The default Layer 2 admitted subset is:
- symbols currently classified as open

Additional subsets may be allowed only when explicitly justified by runtime design, for example:
- recently transitioned symbols needing continuity repair
- focus-selected symbol under tactical read rights
- bounded recovery/hydration cases

### Admission is not universality
Because many brokers can expose large universes, Layer 2 must remain subset-driven.
It is allowed to be fast on the admitted subset precisely because it is not the same job as Layer 1.

---

## Packet doctrine

### Packet scope
Layer 2 packet scope is the smallest complete present-state packet that downstream cheap filtering and operator visibility require.

Layer 2 should prefer:
- current fields
- narrow completeness
- low ambiguity
- stable field meanings
- explicit freshness markers

Layer 2 should avoid:
- history-heavy enrichment
- opportunistic deep calculations
- attaching future ranking semantics to packet fields

### Packet completeness law
A packet should be complete enough to be useful and narrow enough to remain cheap.
If the packet is too thin, later cheap filtering becomes weak.
If the packet is too fat, Layer 2 loses its runtime identity and starts becoming a hidden Layer 5.

### Packet truth, not prose
Layer 2 packets should be machine-usable and operator-safe.
They are not narrative surfaces.
Richer prose belongs downstream in consumer surfaces.

### Packet validity law (mandatory)
Layer 2 packet fields are valid only when lawfully observed in the current refresh window.

- `bid` is valid only when a lawful observed bid exists.
- `ask` is valid only when a lawful observed ask exists.
- `spread` is valid only when derivable from lawful bid/ask and valid point size.
- `tick age` is valid only when a real quote timestamp exists.
- `day high/low/range` are valid only when lawfully observed and internally coherent (`high >= low`).
- freshness posture is valid only when based on real observation evidence.

If lawful observation fails, Layer 2 must publish explicit missingness/degraded/continuity posture and must not pass synthetic `0.00000` values as real market-watch truth.

---

## Freshness doctrine

### Freshness is central
Layer 2 owns current packet freshness.
That means Layer 2 must always know whether its packet is:
- fresh
- aging
- stale
- degraded
- continuity-backed
- pending rebuild

### Not all fields need equal cadence
Layer 2 may internally distinguish between:
- fast-moving current fields
- slower static packet fields
- rebuild-required fields after transition or recovery

But this must remain inside Layer 2 ownership.
It must not become a reason for later layers or HUD to start authorizing their own packet reconstruction.

### Freshness must be inspectable
Every admitted symbol should have enough metadata that the system can explain:
- when the packet was last built
- whether it is still fresh enough for its role
- whether the displayed packet includes last-good continuity assistance

---

## Tactical focused-symbol doctrine

### Why tactical reads exist
The operator may need near-live visibility into the focused symbol’s current packet fields.
Examples include:
- bid
- ask
- spread
- day change / day posture where assigned

Layer 2 may support that tactical plane.

### Tactical reads are narrow rights
Focused-symbol tactical refresh is allowed only for:
- the selected symbol
- Layer 2-owned packet fields
- bounded direct reads or refreshes that remain within Layer 2’s class identity

### Tactical reads do not authorize
Focused-symbol tactical reads do **not** authorize:
- refresh of all open symbols at the same speed
- Layer 3 recalculation because a page is open
- Layer 4 shortlist rebuild because a selected symbol is visible
- Layer 5 deep refresh because the operator wants richer detail
- broader Layer 2 universe service because a tactical symbol is visible
- write-every-tick behavior

### Structural vs tactical truth
Layer 2 must preserve the distinction between:
- **structural committed packet truth** used for stable runtime and persisted surfaces
- **tactical focused-symbol direct reads** used for immediacy on the selected symbol

Those two paths may coexist.
They must not become one ambiguous feed.

---

## Scheduling doctrine

### Subset-first scheduling
Layer 2 scheduling should prioritize the admitted subset rather than broad symbolic fairness across the whole universe.
The whole point of Layer 2 is that it operates after Layer 1 has narrowed the active field.

### Open symbols should move faster than closed ones
If a symbol is no longer meaningfully open/in-scope, Layer 2 should not continue spending current packet service on it like a live open symbol.
Its continuity state may still matter, but active packet refresh priority should reflect actual market posture.

### Focus can elevate only one symbol tactically
A focused symbol may temporarily receive more tactical service, but that must not flatten the rest of Layer 2 scheduling doctrine into focus-speed service everywhere.

### Recovery and repair service
Layer 2 may admit additional service for:
- packet continuity repair after restart
- selective stale packet repair
- recently changed market-state posture

But these must remain explicit submodes, not quiet permanent widening.

---

## Layer 2 artifact block

Layer 2 owns the current packet artifact block for admitted symbols.
That block should be clear, bounded, and atomically landed.

It should contain at minimum the assigned Layer 2 packet fields plus:
- packet freshness markers
- last built time
- stale / degraded posture
- continuity / last-good markers where applicable

### Artifact law
The Layer 2 artifact exists so downstream systems and operator surfaces can consume packet truth without needing to reconstruct it ad hoc.

### Artifact calmness law
Layer 2 artifacts must not be written at tactical display frequency merely because a focused symbol is moving quickly.
Tactical immediacy and persistence cadence are separate things.

### Atomic publication
Layer 2 publication must follow temp-to-final atomic landing discipline.
A failed later layer must not rewrite or erase already committed Layer 2 truth.

---

## Continuity doctrine

### Why continuity exists
Packet truth can become temporarily unavailable or stale due to scheduling, restart, recovery, transient data issues, or bounded service pressure.
Layer 2 continuity exists so the system can preserve last-good usability while still telling the truth about freshness.

### Continuity must stay honest
A continuity-backed packet must remain visibly distinct from a newly refreshed packet.
Continuity is not permission to present stale data as current.

### Controlled continuity
Layer 2 may preserve last-good values for assigned fields where:
- the field meaning remains stable enough to show safely
- the packet is clearly marked stale or degraded when appropriate
- the operator and downstream logic can distinguish continuity from fresh rebuild

---

## Degraded behavior

Layer 2 must fail honestly.

### If current reads are temporarily unavailable
Layer 2 may use last-good continuity where allowed, but must mark the packet as stale, degraded, continuity-backed, or pending refresh as appropriate.

### If packet freshness falls behind
Layer 2 must surface packet age and degraded posture rather than silently continue presenting the packet as current.

### If writes fail
The system should preserve last-good committed Layer 2 truth where allowed, but make landed state and freshness posture explicit.

### If a symbol leaves active scope
Layer 2 may stop active packet service while preserving committed continuity history appropriately.
It must not keep pretending the symbol is receiving live open-symbol service.

---

## Downstream implications

When Layer 2 commits new or materially changed packet truth, it may create eligibility for downstream work.

Typical downstream effects:
- Layer 3 becomes eligible to re-evaluate candidate gating
- operator structural views may need refresh
- continuity/degraded markers may update how the symbol is interpreted downstream

Layer 2 does **not** automatically authorize:
- immediate Layer 3 evaluation for every touched symbol in the same beat
- immediate Layer 4 shortlist rebuild
- immediate Layer 5 deep refresh
- dossier compose wave

Layer 2 creates eligibility, not pile-on permission.

---

## Common failure patterns

### Pattern 1 — Layer 2 widening into the universe
The system starts refreshing packet fields for far too many symbols at Layer 2 cadence.

Result:
- Layer 2 loses subset efficiency
- scheduler pressure rises
- Layer 1 and write lanes compete more often

### Pattern 2 — Layer 2 richness creep
The packet keeps expanding with heavier and heavier fields because the data is “useful anyway.”

Result:
- packet cost rises
- Layer 2 becomes a hidden deep-analysis surface
- Layer 3 loses its clean dependency boundary

### Pattern 3 — Tactical focus authority creep
Focused-symbol pages start authorizing extra packet, filtering, shortlist, or deep work beyond the selected symbol’s tactical fields.

Result:
- navigation becomes a hidden scheduler
- runtime becomes page-dependent and unstable

### Pattern 4 — Timid drip starvation
Layer 2 is technically selective but refreshes the admitted subset too slowly to remain operationally truthful.

Result:
- packets are always aging
- Layer 3 works on stale inputs
- HUD looks alive while truth lags

### Pattern 5 — Write-at-display-speed contamination
Because the focused symbol moves quickly, the runtime starts trying to persist packet truth at the same tactical pace.

Result:
- write pressure rises
- atomic calmness is lost
- persistence becomes noisy and expensive

---

## Implementation obligations

Any future MT5 implementation of Layer 2 must:
- consume Layer 1 truth as its admission gate
- keep packet scope explicit and bounded
- distinguish structural committed packet truth from tactical focused-symbol reads
- expose packet freshness and last-built metadata
- preserve controlled last-good continuity where assigned
- prevent Layer 2 from widening into filtering, selection, or deep analysis
- publish Layer 2 artifacts atomically
- keep persistence cadence separate from tactical display cadence
- surface stale and degraded posture honestly

If an implementation cannot explain whether a packet is fresh, stale, degraded, or continuity-backed, that implementation is incomplete.

---

## Stage 4 Layer 2 field-contract completion

This section completes the Layer 2 field contract.
If earlier wording is less explicit, this section wins.

### Doctrine tiers

#### Hard law
Layer 2 is packet truth only.
It must not rank, shortlist, imply attractiveness, or act as deep-analysis preview logic.

#### Required product contract
Every Layer 2 publication must expose the complete current-packet contract for admitted symbols, including freshness, continuity, and degraded posture.

#### Future expansion option
Future work may add more bounded rolling packet metrics, broker-specific packet enrichments, or richer packet diagnostics.
Those remain optional unless later promoted into required law.

### Required Layer 2 fields

#### Core quote packet
- `symbol`
- `bid`
- `ask`
- `spread`
- `spread_percent`

If percentage form is not supported for a symbol class, Layer 2 must expose explicit unsupported posture rather than omit the field family silently.

#### Freshness and continuity packet
- `tick_timestamp`
- `tick_age_ms` or `tick_age_seconds`
- `packet_observed_at`
- `packet_published_at`
- `packet_freshness_state`
- `packet_continuity_state`
- `degraded_state`
- `degraded_reason`

#### Day-range packet
- `day_high`
- `day_low`
- `day_range`
- `day_range_percent` where supported or explicit unsupported posture where not supported

#### Tradability / specification packet
- `digits`
- `point`
- `trade_allowed_state` or equivalent tradability posture
- `trade_mode` or equivalent broker specification posture
- `session_or_market_access_state` where architecture provides it

### Required packet diagnostics
Layer 2 must also expose:
- `packet_continuity_reason`
- `last_good_available`
- `last_good_timestamp` where continuity uses prior lawful packet truth
- `packet_failure_code` where acquisition failed
- `packet_failure_reason` where operator wording is needed

### Optional Layer 2 enrichments
Optional enrichments may include:
- short rolling spread mean / median / max
- short rolling quote-change count
- packet volatility micro-metrics
- bounded specification extras

These enrichments remain packet truth only and must not become ranking inputs by stealth at Layer 2 publication time.

### Always-visible consumer minimum
Any consumer rendering of Layer 2 must always show:
- bid
- ask
- spread
- spread percentage posture
- tick age
- packet freshness
- continuity / degraded posture
- day-range posture
- tradability posture

### Degraded behavior law
If current packet truth is missing or stale, Layer 2 may surface lawful last-good continuity only when continuity posture is explicit.
It must never present last-good packet truth as current live truth.

## Final standard

Layer 2 is correct when it expands active market-state truth into a bounded, current, usable packet for the admitted subset without collapsing into either timid starvation or uncontrolled widening.

That means Layer 2 must be:
- subset-driven
- packet-focused
- current-state oriented
- tactically responsive where explicitly allowed
- continuity-aware
- atomically committed
- honest about freshness
- hostile to role creep

The standard is not that Layer 2 shows numbers.
The standard is that Layer 2 produces trustable current packet truth that later layers can consume without confusion.
