# ASC Stage 8 — Persistence and Artifacts

## Purpose

This document defines Stage 8 of the Aurora Sentinel Scanner (ASC) rebuild roadmap.

Stage 8 is the persistence-and-artifacts stage.
Its job is to harden the already-existing truth stack from Layers 1 through 5 into a lawful artifact system with atomic landing, family-aware publication, lineage, continuity posture, and restore-safe structural trust.


Reframing law: Stage 8 is **not** the first-write authorization stage.
Runtime-owned bounded testing writes for `Market Board.txt`, `Current Focus.txt`, and `Dossiers/*.txt` are opened earlier as Stage 1 foundation rails and are progressively hydrated by Layers 1–5.

If Stages 3 through 7 make truth real in runtime, Stage 8 makes that truth durable, inspectable, and safely consumable.

This stage exists because truth that lives only in memory is not yet fully trustworthy for structural operator surfaces, recovery, or downstream composition.
ASC needs a real landed artifact system before it can claim durable scanner state.

---

## Stage objective

Stage 8 establishes the persistence and artifact system against real layer-owned truth.

It defines and/or implements:
- family-aware artifact boundaries
- atomic temp-to-final landing
- layer-owned artifact publication across Layers 1 through 5
- last-good continuity posture where assigned
- lineage/coherence/metadata spine application in real artifact flows
- publish-threshold posture
- restore-aware trust posture for landed artifacts
- family-specific landing and failure posture
- calm publication discipline across the truth stack

The goal is not to create more truth or authorize first-write existence.
The goal is to make existing truth durable without corrupting ownership or cadence.

---

## Why Stage 8 matters

Without Stage 8, the truth stack remains incomplete in several dangerous ways:
- runtime truth and landed truth can drift apart
- HUD and later consumer surfaces are pushed toward ad hoc read behavior
- recovery posture is weak or speculative
- continuity support is informal instead of explicit
- mixed-cycle ambiguity becomes harder to detect
- layers may publish opportunistically or inconsistently

Stage 8 matters because it turns the truth stack into a trustworthy artifact system rather than a loose collection of in-memory states and incidental writes.

---

## Stage 8 dependency position

Stage 8 depends on:
- Stage 0 repo reset being complete
- Stage 1 shared types/state/contracts being complete enough for metadata, lineage, freshness, continuity, coherence, and landing posture
- Stage 2 dispatcher/governor spine being real enough to support lawful persistence admission and override posture
- Stages 3 through 7 having produced real layer-owned truth across Layers 1–5
- final blueprint files for persistence/artifact families, schema/versioning, runtime law, HUD doctrine, and invalid designs already being authoritative

Stage 8 is the prerequisite for:
- Stage 9 HUD/operator surfaces consuming structural truth safely
- recovery hardening in later stages
- trustworthy summaries/compositions later
- end-to-end acceptance that depends on durable truth rather than transient runtime state

---

## Stage 8 scope

Stage 8 includes:
- implementing canonical artifact families in the MT5 surface
- implementing atomic landing discipline
- implementing lawful layer publication flow from Layers 1–5 into their structural artifact families
- implementing metadata spine attachment to real artifacts
- implementing last-good continuity posture where assigned
- implementing family-aware failure/retry posture
- implementing restore trust posture and family-aware restore logic scaffolding
- implementing publish-threshold posture across families
- implementing calm publication discipline

Stage 8 does **not** include:
- rich final HUD page implementation
- treating Stage 8 as the first moment Board/Current Focus/Dossier outputs are allowed to exist
- broad dossier/report generation as a primary deliverable
- letting consumer surfaces redefine artifact families
- using persistence to derive new truth not already owned by layers

---

## Stage 8 deliverables

Stage 8 should deliver the following outcomes.

### 1. Artifact families become real runtime surfaces
The active MT5 surface must now have real family-aware artifact handling for at least:
- layer transport artifacts
- runtime control/telemetry artifacts where assigned
- recovery/continuity artifacts where assigned
- structural HUD-support artifact posture where needed later
- audit/lineage surfaces where assigned

### 2. Layers 1–5 can land real committed truth
Stage 8 must also make room for the operator-facing composed artifact families:
- Market Board canonical artifact (trader-facing selection board)
- Symbol dossier as the deep intelligence file

These families remain downstream of landed layer truth.
They must not become places where missing upstream truth is invented.

Grouping and classification posture for these composed artifacts is mandatory:
- grouping derives from broker/classification truth only
- no fixed universal major/sub-group assumptions
- no synthetic fill/fake membership/fake counts to satisfy layout templates
- board outputs adapt truthfully to sparse and stock-heavy universes with explicit availability posture
- dossier classification sections must expose resolved/unresolved truth honestly
- subgroup depth remains visible inside canonical board rows when it materially affects selection quality in large universes

Where lawful and available, dossier composition must support identity, market status reasoning, live snapshot, spread percentage, friction, broker specification, trading sessions, day and prior-day levels, VWAP, ATR, regime, grouping/classification, correlation, readiness state, and deep analysis state.

Each already-implemented layer must be able to hand off its owned committed truth into a lawful artifact publication path.

### 3. Atomic landing becomes executable
Artifacts must be able to move through a real staging/promote flow rather than being written directly as unstructured side effects.

### 4. Metadata spine becomes real on actual artifacts
Identity, freshness, continuity, coherence, lineage, landing, and restore posture must become part of real artifact publication rather than remaining abstract documentation.

### 5. Last-good continuity becomes explicit where assigned
Continuity support should now be real where the architecture allows it, and clearly distinguishable from fresh landed truth.

### 6. Restore posture becomes structurally meaningful
The system should now be able to tell, per family/artifact, whether something is safe to consume as current, only safe to show as stale/continuity-backed, or requires live revalidation.


### 7. Board section schema and cadence become enforceable
Stage 8 must implement board section-level publication behavior for the canonical Market Board artifact:

- mandatory `account_and_risk_snapshot` section with fields:
  - balance, equity, free margin, used margin, margin level
  - open trades, pending orders, open risk estimate, exposure note
- mandatory `excluded_or_already_active` section with fields:
  - symbol, status, direction, entry, stop, target, stop size
  - optional operator-facing Unicorn-style label for pending orders is allowed, but explicit operational status remains mandatory
- section-level publication state/failure/continuity metadata must be persisted and visible
- section refresh cadence must be explicit and enforced each board cycle for required sections
- All-Markets Top 10 must remain compact and correlation-gated exactly as already established
- board grouping must remain classification-truth-derived with no fabricated rows/counts to simulate completeness

---

## Core implementation targets

Stage 8 will primarily engage:
- `mt5/include/asc/persistence/ASC_Persistence_Manager.mqh`
- `mt5/include/asc/persistence/ASC_Persistence_Atomic.mqh`
- `mt5/include/asc/persistence/ASC_Persistence_Families.mqh`
- `mt5/include/asc/persistence/ASC_Persistence_LastGood.mqh`
- `mt5/include/asc/persistence/ASC_Persistence_Lineage.mqh`
- `mt5/include/asc/persistence/ASC_Persistence_Restore.mqh`
- `mt5/include/asc/persistence/ASC_Persistence_PublishThresholds.mqh`
- `mt5/include/asc/artifacts/ASC_Artifacts_Schema.mqh`
- `mt5/include/asc/artifacts/ASC_Artifacts_Metadata.mqh`
- `mt5/include/asc/artifacts/ASC_Artifacts_Serialize.mqh`
- `mt5/include/asc/artifacts/ASC_Artifacts_Validate.mqh`
- `mt5/include/asc/artifacts/ASC_Artifacts_Builders_Layers.mqh`
- later runtime/control hooks only as much as lawful persistence admission/override requires

Persistence/artifact ownership must stay visible and bounded.

---

## Family-boundary doctrine in Stage 8

### Family boundaries must become executable now
Stage 8 must make it real that not all files are the same kind of thing.
At minimum, the system should now distinguish:
- layer transport truth
- runtime control/telemetry surfaces
- continuity/recovery support surfaces
- structural consumer-support surfaces where explicitly assigned
- audit/lineage surfaces

### Why this matters
If family boundaries remain weak here:
- consumers will not know what they are reading
- restore logic will become risky
- stale or continuity-backed truth can masquerade as current truth
- dossier/UI paths will be tempted to become truth transport

### Dossiers remain downstream
Stage 8 must preserve the rule that human-readable compositions are consumers of landed truth, not the birthplace of it.

---

## Layer-publication doctrine in Stage 8

### Layer-owned publication must become real now
Stage 8 should make it executable that Layers 1–5 publish only their own structural truth blocks.

### Publication order must respect the truth stack
Publication should continue to respect the architectural order:
1. Layer 1
2. Layer 2
3. Layer 3
4. Layer 4
5. Layer 5
6. downstream structural consumer support surfaces after the above exist

### Publication must not rewrite ownership
A later layer or artifact family may consume earlier layer outputs.
It must not rewrite their meaning during publication.

---

## Atomic landing doctrine in Stage 8

### Atomic landing must become executable now
Stage 8 should make the canonical landing sequence real:
1. gather publishable owned truth
2. build payload + metadata
3. write to temp/staging path
4. validate staging as required
5. promote to canonical path
6. preserve last-good where required
7. update lineage/landing metadata
8. resolve pending posture

### Why this matters
A structural consumer should see either:
- the previous committed artifact
- or the new committed artifact

It should not have to reason about half-landed structural truth.

### Atomic does not mean frantic
Atomic integrity protects trust.
It does not justify same-speed high-frequency writes.

---

## Metadata spine doctrine in Stage 8

### Metadata must now attach to real artifacts
Stage 1 and the final blueprint established the metadata language.
Stage 8 must make it real on actual published artifacts.

At minimum, artifacts should now carry:
- identity/family/owner/scope
- schema version
- freshness posture
- completeness posture
- continuity markers
- coherence/mixed-cycle posture
- lineage/upstream references
- landing state
- restore trust posture

### Metadata is not optional decoration
If an artifact exists but cannot describe its freshness, continuity, and coherence posture, Stage 8 is incomplete.

---

## Publish-threshold doctrine in Stage 8

### Publish thresholds must become executable now
Stage 8 must prevent publication from degenerating into “write whenever something moved.”

Each important family should now have explicit posture around:
- what change is material enough to land
- what may wait
- what freshness age forces landing
- what state transitions justify landing
- what is best-effort versus required

### Why this matters
Without thresholds:
- write churn rises
- tactical movement contaminates structural publication
- artifact trust becomes noisy instead of calm

---

## Last-good doctrine in Stage 8

### Last-good must become explicit now
Where the architecture assigns last-good continuity, Stage 8 should make it real rather than incidental.

### Last-good must remain distinguishable
Consumers must be able to tell whether an artifact is:
- freshly landed current truth
- continuity-backed support
- stale but still visible
- degraded or restore-only

### Last-good is not fake freshness
Stage 8 must strongly preserve that continuity support never becomes a stealth way to claim freshness.

---

## Restore doctrine in Stage 8

### Restore trust posture must begin to matter now
Stage 8 should establish the actual family-aware restore posture needed later by recovery and consumer stages.

Artifacts should now be able to carry enough posture that the system can determine whether they are:
- safe to consume as current structural truth
- safe to show as stale/continuity-backed only
- requiring live revalidation before structural trust
- not suitable for current presentation

### Restore is humility, not optimism
Persisted truth can support recovery.
It must not automatically become present-tense truth after restart.

---

## Failure and retry doctrine in Stage 8

### Persistence failure must become structured now
Stage 8 should make it possible to distinguish cases such as:
- staging failed
- promotion failed
- metadata update failed
- continuity preservation failed
- family left pending
- retry scheduled or abandoned

### Retries must stay bounded
The persistence system must not enter uncontrolled write loops.


## Stage 8 artifact behavior knob integration law

Stage 8 must implement lawful artifact behavior knobs from `blueprint/final/ASC_MENU_AND_SETTINGS_CONTRACT.md` for Board, Dossier, and Current Focus publication surfaces.

Required Stage 8 behavior:
- refresh posture knobs map to publish-threshold and enqueue posture (never direct uncontrolled write loops)
- inclusion toggles affect optional sections only; mandatory sections and mandatory metadata remain non-optional
- verbosity boundaries change operator-facing composition density only and may not remove freshness/source/continuity/degraded truth markers
- dangerous persistence/publication knobs require guarded application and explicit metadata about acceptance, deferral, or clamp

Artifact mapping must remain explicit:
- Board knobs -> board family section cadence + section-level state/failure/continuity metadata
- Dossier knobs -> dossier section inclusion/verbosity flags with mandatory deep schema integrity preserved
- Current Focus knobs -> compact summary publication behavior without promoting full deep payload ownership to focus surface

Anti-drift rule (Stage 8 mandatory):
- no hidden family-local constant may override active operator publication knobs outside declared precedence order from the EA menu/settings contract
Retry posture should be family-aware and bounded.

### Failure posture must stay visible
A failed or degraded landed artifact must not quietly look healthy to later consumers.

---

## Calm-publication doctrine in Stage 8

### Calmness is a structural goal
Stage 8 should make structural publication calm, selective, and family-aware.

### Calmness does not mean starvation
Important families must still land before guarantees expire.
Stage 8 must therefore balance:
- calm publication cadence
- bounded landing age
- protected atomic integrity

### No write-at-display-speed contamination
Fast tactical or fast-changing views must not drag the artifact system into the same cadence.
This must become structurally true now.

---

## Dirty-routing doctrine in Stage 8

### Artifact publication does not create upstream authority
When publication completes, it may make later consumer surfaces eligible.
It must not send hidden authority backward into layer logic or selection logic.

### Stage 8 must not become a truth engine
Persistence may land owned truth.
It may not invent or reinterpret truth because it has access to payload fields.

---

## Interaction with Stage 2 governor

### Persistence remains a governed work class
Stage 8 must preserve that publication and landing remain under governor law.

### Write override posture becomes real here
The conceptual persistence override doctrine from Stage 2 should now become concretely useful for protected landing points.

### Artifact landing must remain bounded
Even when write pressure exists, Stage 8 must preserve calm bounded landing rather than same-speed broad flush behavior.

---

## Evidence of success in Stage 8

A healthy Stage 8 should allow the system to demonstrate things like:
- Layers 1–5 can now land real committed artifacts
- artifact families are distinguishable in structure and metadata
- last-good continuity is explicit where used
- structural consumers no longer need to guess whether an artifact is fresh, stale, continuity-backed, or mixed-cycle
- publication remains calmer than tactical display movement
- restore posture is becoming real rather than speculative

These are better signs of success than simply seeing more files appear.

---

## What Stage 8 must not do

### 1. No dossier-transport inversion
Do not let human-readable surfaces become the real transport layer for scanner truth.

### 2. No persistence truth invention
Do not let artifact code compute upstream meaning because the fields are present.

### 3. No family confusion
Do not mix telemetry, layer truth, continuity support, and consumer compositions into one ambiguous file class.

### 4. No same-speed publication
Do not let tactical movement or packet/deep churn force equally fast artifact landing.

### 5. No metadata theater
Do not attach schema metadata superficially while leaving coherence/continuity/restore posture functionally meaningless.

### 6. No restore optimism
Do not let restored artifacts impersonate live truth without the trust posture explicitly allowing it.

---

## Stage 8 implementation approach

The preferred progression inside Stage 8 is:

1. implement family-aware artifact builders and metadata spine attachment
2. implement atomic landing mechanics
3. implement lawful publication flow for Layer 1 through Layer 5 blocks
4. implement publish-threshold posture
5. implement last-good continuity handling where assigned
6. implement lineage/coherence/landing posture updates
7. implement restore trust posture scaffolding
8. verify governor-controlled persistence admission and override behavior

### Why this order matters
Builders and metadata make artifacts meaningful.
Atomic landing makes them trustworthy.
Thresholds and continuity make them honest under pressure.
Restore posture makes them usable after interruption.

---

## Stage 8 quality gates

Stage 8 is complete only when all of the following are true:

### Gate 1 — Artifact families are real
The artifact system can distinguish structural families rather than treating all files as interchangeable outputs.

### Gate 2 — Layers 1–5 land committed truth lawfully
Each existing truth layer can publish owned truth through the persistence system.

### Gate 3 — Atomic landing is real
Important artifacts use a real temp-to-final landing model or equivalent atomic discipline.

### Gate 4 — Metadata spine is meaningful on actual artifacts
Freshness, continuity, coherence, lineage, landing, and restore posture are not merely theoretical.

### Gate 5 — Last-good is explicit where assigned
Continuity-backed artifacts are clearly distinguishable from fresh landed truth.

### Gate 6 — Restore posture is structurally useful
The system can now reason about whether an artifact is safe to consume as current, only safe as continuity-backed, or requires revalidation.

### Gate 7 — Publication remains calm and family-aware
The stage does not collapse into write-at-display-speed behavior or file-family confusion.

### Gate 8 — Persistence remains downstream of owned truth
The persistence system has not become a shadow truth engine.

---

## Evidence required for Stage 8 completion

Stage 8 completion should be evidenced by:
- real persistence/artifact modules in the MT5 surface
- real layer-owned artifact publication for Layers 1–5
- explicit metadata posture on actual artifacts
- explicit last-good and restore trust posture where assigned
- lawful atomic landing behavior
- office tracking showing Stage 8 completion honestly
- later consumer work being able to consume landed truth without improvising its own trust model

The mere presence of files is not enough.
The evidence must show trustworthy landed artifact behavior.

---

## What Stage 8 makes newly admissible

Once Stage 8 is complete, the following become admissible:
- Stage 9 HUD/operator surface implementation against real landed structural truth
- richer structural consumer surfaces against lawful artifact families
- later recovery/hardening work against real restore posture instead of speculation

What does **not** become automatically admissible:
- allowing human-readable composition to redefine truth transport
- treating persistence as fully solved if families still blur or restore posture is weak
- using the artifact system as justification to widen tactical or UI-driven behavior

---

## Common failure patterns Stage 8 must prevent

### Pattern 1 — Truth in memory, files as residue
The runtime computes correct layer truth, but publication is inconsistent or secondary.

Result:
- structural consumers remain weak
- recovery posture remains fragile

### Pattern 2 — Family confusion
Different artifact kinds are mixed together with weak boundaries.

Result:
- consumers cannot interpret trust posture correctly
- stale truth can masquerade as current

### Pattern 3 — Same-speed write contamination
Tactical movement or fast-changing deeper fields drive broad publication churn.

Result:
- write pressure rises
- calm publication is lost

### Pattern 4 — Last-good ambiguity
Continuity-backed truth is visible, but metadata/posture is too weak to distinguish it from fresh truth.

Result:
- trust erosion
- restore misuse

### Pattern 5 — Metadata without force
Artifacts carry metadata fields, but consumers and restore logic still effectively ignore them.

Result:
- schema theater instead of trust discipline

---

## Stage 8 invalid completions

Stage 8 is **not** complete if any of the following are true:
- Layers 1–5 still mostly publish by incidental writes or ad hoc file patterns
- artifact families are still functionally ambiguous
- atomic landing is absent or weak
- continuity support is ambiguous with fresh landed truth
- restore posture remains mostly speculative
- metadata exists but does not materially affect trust/consumer posture
- persistence has become a shadow truth engine
- later HUD/consumer stages would still need to invent their own artifact trust model

---

## Relationship to later stages

Stage 8 does not yet deliver final HUD/operator experience.
It delivers the lawful landed truth and artifact trust model that those later consumer stages will rely on.

That means later stages should rely on Stage 8 for:
- real layer-owned committed artifacts
- family-aware artifact structure
- explicit freshness/continuity/coherence/restore posture
- calm lawful publication and landing

If later consumer stages still have to guess whether a structural artifact is trustworthy, Stage 8 was incomplete.

---

## Final standard

Stage 8 is correct when ASC can now truthfully say:

> the scanner’s structural truth stack is not only real in runtime, but durably landed in a lawful artifact system.

That means Stage 8 must leave ASC with:
- real family-aware artifacts
- lawful atomic landing for layer-owned truth
- meaningful metadata and lineage posture
- explicit last-good continuity where assigned
- real restore trust posture
- calm publication discipline
- no dossier inversion, no persistence truth invention, and no write-at-display-speed drift

The standard is not that files exist.
The standard is that landed artifacts are now trustworthy enough for structural consumers, recovery posture, and later operator surfaces to depend on them without ambiguity.
---

## Stage 8 focused implementation addendum (Board, Dossier, Current Focus)

### Required implementation lane A — Market Board section guarantees
Stage 8 implementation must enforce the following board composition contract:
- always publish `top_3_per_bucket`
- always publish `top_5_per_bucket`
- publish `all_markets_top_10` only after correlation readiness is satisfied

Acceptance evidence:
- board artifact examples showing required sections
- explicit readiness-gated behavior for all-markets top 10
- failure/degraded visibility when readiness dependency is not met

### Required implementation lane B — Dossier full intelligence lifecycle
Stage 8 must treat dossier as full symbol intelligence artifact and attach explicit lifecycle states:
- `pending`
- `fresh`
- `stale`
- `degraded`
- `continuity`
- `failure`

Acceptance evidence:
- dossier publication includes lifecycle/publication state
- missingness/failure components are explicit
- continuity-backed dossier cannot be labeled fresh

### Required implementation lane C — Current Focus singleton replacement
Stage 8 must enforce Current Focus as a singleton artifact surface:
- exactly one canonical Current Focus file
- symbol switch performs strict in-place rewrite/replacement of same canonical file
- no visible multi-file Current Focus drift

Current Focus composition requirements:
- profile must be **shorter than dossier, richer than board**
- minimum required sections:
  - operator snapshot
  - selection + correlation line
  - compact deep-analysis outcome summary
  - current risk/exposure context
  - publication status
- prohibited in Current Focus:
  - full archival history
  - full dossier-depth duplication
- explicit archive relation:
  - per-symbol dossiers remain preserved archival/deep-intelligence files
  - Current Focus remains single-file convenience for current symbol handoff

Acceptance evidence:
- filesystem/control-path check proving singleton behavior
- switch event check proving replacement semantics
- artifact inspection check proving required minimum section set and bounded profile posture

### Required implementation lane D — Operator-safe naming enforcement
Stage 8 must add visible-surface filename validation against banned dev-language tokens.

Minimum banned set:
- `tmp`, `test`, `debug`, `wip`, `draft`, `vnext`, `scratch`, `placeholder`, `new`, `old`, `final_final`

Acceptance evidence:
- validation check output over visible artifact surfaces
- explicit fail reason when banned names appear

### Required implementation lane E — Publication-state matrix unification
Stage 8 must enforce one publication-state matrix across board, dossier, and current focus:
- `pending`
- `fresh`
- `stale`
- `degraded`
- `continuity`
- `failure`

Acceptance evidence:
- schema/enum alignment checks across all three surfaces
- no divergent operator-facing states in canonical outputs
