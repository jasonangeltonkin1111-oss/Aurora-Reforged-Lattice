# ASC HUD and Operator Surface

## Purpose

This document defines the canonical HUD and operator-surface model of Aurora Sentinel Scanner (ASC).

The HUD is the operator-visible expression of scanner state.
It is not a second engine.
It is not a hidden scheduler.
It is not a justification for bypassing the layer model.

Its job is to present already-owned truth clearly, calmly, and honestly, while allowing narrowly bounded tactical immediacy where the architecture explicitly permits it.

This file exists to make that contract explicit.

Tactical realtime field rights, scope, cadence classes, and persistence boundaries are normatively bound to `ASC_TACTICAL_REALTIME_FIELD_CONTRACT.md`.
Micro-burst execution, scheduler-vs-execution timing, and HUD transaction ownership are normatively bound to `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`.

---

## Symbol action surface contract binding

HUD/operator behavior is explicitly bound to `ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md`.
Page hierarchy and per-page product law are explicitly bound to `ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md`.
Shared symbol section-family architecture is explicitly bound to `ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`.

Enforcement in present ASC ownership:
- Layer 6 (Semi-Auto) and Layer 7 (Full Auto) remain scaffold-only
- HUD controls are symbol-scoped action surfaces, never scanner-global loops
- post-Deep-Analysis handoff must use explicit bridge input/output/eligibility semantics
- any future Layer 7 workflow collapse remains future doctrine only and is non-admissible now

If a HUD control path violates this contract, that path is architecturally invalid.

## Control Placement Contract

### Global control zones (all HUD pages)
Every canonical HUD page must reserve the same control-zone scaffold so controls remain predictable across transitions:
1. **Top navigation zone** — primary hierarchy movement entry points only.
2. **Contextual breadcrumb/title zone** — current page identity and hierarchy lineage.
3. **Quick actions zone** — page-local and symbol-scoped actions only.
4. **Health/status strip zone** — stale/degraded/continuity and runtime posture signals.
5. **Optional pager zone** — list/window paging when row density exceeds page contract bounds.

Zone order must remain stable (top navigation -> breadcrumb/title -> quick actions -> health/status -> optional pager).
Pages may hide unused zones, but they may not repurpose one zone into another without doctrine change.

### Per-page control allocation rules
- **Overview / Home**
  - Top navigation: may route to Main Groups and approved symbol-pick entry.
  - Breadcrumb/title: root title only; no synthetic deeper crumbs.
  - Quick actions: refresh-view, source legend, stale/degraded drawer toggles.
  - Health/status strip: required and scanner-posture focused.
  - Optional pager: only for overflow summary lists.
- **Main Groups**
  - Top navigation: hierarchy movement to Overview/Home and Sub-Groups.
  - Breadcrumb/title: must include Overview -> Main Groups lineage.
  - Quick actions: structural sort/view/filter controls only.
  - Health/status strip: required group freshness/degradation posture.
  - Optional pager: allowed for long group lists.
- **Sub-Groups**
  - Top navigation: hierarchy movement to Main Groups, Overview/Home, Symbol Overview.
  - Breadcrumb/title: must include full lineage chain.
  - Quick actions: subgroup expand/collapse/select and structural sort only.
  - Health/status strip: required subgroup freshness/degradation posture.
  - Optional pager: allowed for subgroup row virtualization/paging.
- **Symbol Overview**
  - Top navigation: hierarchy movement back to Sub-Groups/Main Groups/Overview.
  - Breadcrumb/title: must include selected symbol identity.
  - Quick actions: symbol-scoped controls admitted by action-surface contract and aspect drilldown.
  - Health/status strip: required source-plane and tactical freshness posture.
  - Optional pager: only for bounded structural card/list overflow.
- **Symbol Aspect Detail**
  - Top navigation: hierarchy-safe return to Symbol Overview and approved ancestors.
  - Breadcrumb/title: must include full symbol + aspect path.
  - Quick actions: aspect selectors, source toggles, symbol-scoped controls admitted by contract.
  - Health/status strip: required aspect freshness/degradation posture.
  - Optional pager: allowed for evidence/detail-table overflow.

### Back/forward semantics and hierarchy-safe navigation
- Back and forward actions must replay prior page lineage state, not infer a new hierarchy branch.
- Back from a deeper page returns to its immediate canonical parent unless explicit cross-link navigation was taken.
- Forward may restore only previously visited admissible pages; it must not fabricate unvisited hierarchy states.
- Breadcrumb clicks are canonical hierarchy jumps and must clear incompatible forward-stack entries.
- Symbol context must persist across back/forward only when both source and destination pages lawfully admit that symbol scope.

### Anti-drift laws
- No duplicated navigation paths that express the same destination with different hierarchy meaning.
- No control migration between zones unless this contract and owning doctrine files are updated together.
- No scanner-global action controls are admissible in HUD zones; HUD quick actions remain symbol-scoped or page-local.
- No hidden fallback controls outside declared zones.
- No page-specific exception that weakens symbol action-surface constraints.

### Acceptance checks (control-zone stability)
A HUD change is admissible only if these checks pass across all canonical page transitions:
1. Zone scaffold remains present in canonical order with no zone-role swaps.
2. Back/forward and breadcrumb transitions preserve hierarchy-safe lineage.
3. Quick actions remain page-local or symbol-scoped and never escalate to scanner-global authority.
4. Health/status strip remains source-honest during transition locks/freezes.
5. Optional pager appears only on overflow pages and disappears without layout drift when overflow resolves.
6. No duplicate navigation controls emerge after transition hydration.

### Classification-driven hierarchy generation and large-universe law
- Main Groups and Sub-Groups must be generated from committed classification truth only (layer/persistence owned structural artifacts).
- HUD must not synthesize group trees from tactical streams, viewport guesses, or stale in-memory remnants when classification truth is absent.
- Navigation branches are admissible only when their owning classification node exists in committed structural truth for the active snapshot/version.
- When a Main Group exists but has zero admissible Sub-Groups, keep the Main Group row visible and render a bounded “not available”/“no sub-groups published” state inside the page body; do not fabricate child nodes.
- When no Main Groups exist for the active snapshot/version, render an empty-state body and suppress deeper breadcrumb/navigation targets.
- “Not available” messaging is for missing content inside an admitted node, not a license to render fake hierarchy entries.

#### Absent-structure display rules (hide vs show)
1. Hide navigation targets when the underlying node does not exist in classification truth.
2. Show explicit unavailable states when the node exists but its owned payload is absent, delayed, blocked, or degraded.
3. Never show clickable ghost pages solely to preserve breadcrumb depth symmetry.
4. Back/forward history may restore previously visited admissible nodes only; it must not resurrect nodes absent in the current classification snapshot.

#### Large-universe thresholds and prioritization
- Main Groups: if committed rows > 40, enable virtualization or paging; if > 120, paging is mandatory with deterministic sort.
- Sub-Groups: if committed rows > 80, enable virtualization or paging; if > 240, paging is mandatory with deterministic sort + subgroup priority ordering.
- Symbol preview cells inside Sub-Groups must remain bounded (default top 5, hard max 8) and must not trigger eager full-subgroup hydration.
- Subgroup prioritization under overflow must be structural and explicit (e.g., promoted exposure, freshness confidence, operator pin state), never random fill-order.
- Overflow strategy must preserve operator continuity: stable row identity keys, stable scroll anchors, and no reorder jitter on non-structural ticks.

#### Anti-synthetic-fill law
- No synthetic group filling, fake subgroup placeholders, or template-padding cards are admissible.
- Layout templates must shrink/expand around real data; missingness must be shown as missingness, not counterfeit content.
- If a layout slot has no lawful structural record, that slot remains absent.

#### Broker-profile-aware density presets
- HUD may apply broker-profile-aware density presets (compact/standard/spacious) only as presentation policy; presets must never alter hierarchy truth, eligibility, or ordering law.
- Preset selection inputs may include broker symbol universe size, average subgroup fan-out, and platform render budget posture.
- Compact mode is admissible only when readability guards remain satisfied (status badges legible, blocked reasons readable, no control overlap).
- Density switching must be reversible at runtime without page-model rebuild and without changing admitted navigation branches.
- Performance guard: density preset changes must operate through retained-object relayout and must not trigger scanner/runtime authority escalation.

---


## Fixed Symbol Aspect Categories and Readability Law

## Stage 3 control-surface alignment

HUD and other operator surfaces must consume the canonical Stage 3 menu/settings doctrine.

Required visible menu section families:
- HUD & Display
- Market Board
- Current Focus
- Dossier
- Market State
- Open Symbol Snapshot
- Selection Filter
- Shortlist Context
- Deep Analysis
- Advanced Controls
- Reserved / Future Scaffolds

HUD may expose controls from these sections only within their lawful role.
HUD must never let page visibility become a shortcut around ownership boundaries.

Deep Analysis controls shown in HUD must be framed as:
- promoted-symbol service configuration
- completeness inspection
- analyst-facing output projection

HUD must not present those controls as:
- promotion authority
- signal controls
- execution controls
- order controls


### Canonical category set (exact)
When rendering Symbol Aspect Detail, ASC HUD must expose these categories in fixed order:
1. Market Action
2. Trading Conditions
3. Market Context
4. Deep Analysis
5. Account/Trade Context (when relevant)
6. Publication/Result Status

Categories are product-contract objects, not ad-hoc UI tabs.
No peer category additions are admissible without doctrine and product-contract amendment.

### Mandatory and forbidden field doctrine by category
- **Market Action**
  - Mandatory: selected symbol/timeframe identity, structural action-state label, structural publication timestamp, bounded tactical mini-strip (bid/ask/spread/server time) with explicit tactical source label.
  - Forbidden: account mutation controls, full deep payload blobs, scanner-global controls.
  - Allowance: mixed structural + bounded tactical for selected symbol only.
  - Default density: row.
- **Trading Conditions**
  - Mandatory: spread class, session/liquidity posture, volatility regime marker, freshness/degraded marker, structural publish timestamp.
  - Forbidden: unlabeled tactical-only streams, discretionary narrative dumps, account mutation controls.
  - Allowance: structural-first; tactical corroboration only when explicitly labeled and selected-symbol scoped.
  - Default density: row.
- **Market Context**
  - Mandatory: regime/context summary, group/sub-group lineage, structural posture/confidence flags, continuity status.
  - Forbidden: tick-wall/tape dumps, deep internals, execution controls.
  - Allowance: structural only in default view.
  - Default density: card.
- **Deep Analysis**
  - Mandatory: deep eligibility state, last deep run id/time, bounded rationale summary, promoted/deployability posture, continuity/degraded status.
  - Forbidden: raw full deep payload dumps, hidden rerun-on-open side effects, non-selected-symbol deep artifacts.
  - Allowance: structural only (except freshness timers).
  - Default density: detail panel.
- **Account/Trade Context (when relevant)**
  - Mandatory: position side/size (if open), avg entry, unrealized P/L class, risk posture tag, publication timestamp, explicit missingness reason when unavailable.
  - Forbidden: credentials/secrets, broker identifiers, trade mutation controls, unrelated symbol orders.
  - Allowance: structural only unless separately contracted.
  - Default density: row.
- **Publication/Result Status**
  - Mandatory: publication/result state, artifact lineage/version, stale/degraded/continuity markers, bounded warning/error summary counts.
  - Forbidden: raw logs as default content, stack traces in default panel, tactical market stream fields.
  - Allowance: structural only.
  - Default density: card.

### Collapse/expand and pagination defaults
- Active category expands by default; non-active categories remain collapsed.
- Row mode expands first 6 rows by default; card mode expands first 4 cards; detail panel shows summary-first with evidence collapsed.
- Evidence/table blocks paginate at 12 rows per page (hard max 20).
- Expanding a heavy evidence block auto-collapses sibling heavy blocks in the same category.
- Pagination state is category-local and resets on symbol change.

### Anti-dump constraints (hard guards)
- Default category render must remain <= 45 visible data cells before forced pagination/collapse.
- No more than 2 heavy evidence blocks may be expanded simultaneously.
- Field values over 220 characters must clamp with explicit reveal controls.
- Raw JSON/text payload walls are forbidden in default view.
- Tactical mini-strip may appear once per category view (single compact row only).
- Category switches must reuse retained objects; full-page dump/rerender is non-admissible.

---

## Core doctrine

### HUD-is-consumer law
The HUD is a consumer surface.
Its primary role is to consume:
- already-owned structural truth
- lawful selected-symbol tactical fields
- lawful background progress/state surfaces
- approved runtime control posture
- approved structural support artifacts

The HUD does not own scanner truth.
It does not originate market-state classification, shortlist membership, deep-analysis authority, or persistence policy.
HUD may consume Layer 1 state, freshness, and next-check posture where those fields are lawfully published.

### Not-a-second-scanner law
The HUD must not become a second scanner engine hidden behind visual logic.
Opening a page, hovering a symbol, or navigating the interface must not silently re-authorize lower-layer computation that the runtime governor has not admitted.

### Structural-vs-tactical law
ASC HUD behavior must preserve a clear distinction between:
- **structural committed truth**
- **tactical direct immediacy**

Structural truth comes from landed layer-owned artifacts and approved structural support surfaces.
Tactical immediacy comes from explicitly allowed direct reads for fast-moving selected-symbol fields.

These two planes may coexist.
They must not blur into one ambiguous feed.

### Display-cadence-is-not-persistence-cadence law
A value may update quickly on screen without implying that it should be written to persistence at the same rate.
The HUD must not drag the persistence system into same-speed write behavior.

### Tactical-strip isolation law (hard guard)
Symbol tactical strips and mini-strips are selected-symbol-only surfaces.
Non-selected-symbol tactical payloads are non-admissible in those strips under all circumstances (including transition windows, preload, and fallback state).

### Tactical-does-not-rebuild-structure law
Tactical cadence activity (`cadence_t0_tick`, `cadence_t1_fast`) may repaint strip-local regions only.
It must not trigger:
- structural card-tree rebuild
- structural list reorder/re-pagination
- hierarchy model regeneration

### Page-visibility-does-not-grant-authority law
The fact that a page is visible does not, by itself, authorize:
- Layer 2 packet rebuild for unrelated symbols
- Layer 3 filtering churn
- Layer 4 shortlist rebuild
- Layer 5 deep service for a non-promoted symbol
- broad artifact flushes

Visibility is not authority.

### Symbol-context continuity law (mandatory)
When HUD is in symbol context:
- persistent top symbol action row is required
- persistent bottom symbol section row is required
- selected symbol context must persist across section switches
- Current Focus ownership must follow the selected symbol context and must not remain stuck on a prior symbol
- Dossier remains the per-symbol intelligence artifact for that same symbol; HUD focus must not silently substitute Current Focus for dossier ownership
- symbol selection changes must be visible enough that the operator can tell Current Focus has moved to a new symbol

HUD page-open/view actions remain consumer behavior and must not silently escalate into runtime ownership changes.

### Deep Analysis page-open non-implication law
Opening a symbol page does not grant Deep Analysis entitlement, and changing Deep Analysis display/output controls does not arm Deep Analysis by itself.
Opening or navigating to a Deep Analysis page/section does not imply that a deep run has executed.
Only explicit command path trigger for the selected symbol may arm/run Deep Analysis.

### Layer 4 discoverability law (HUD-facing)
Bucket/sub-group/symbol navigation must optimize operator discovery, not manual hunting.
Leading Three and Full Five membership visibility is mandatory in shortlist-aware HUD journeys.
Structural lineage remains visible, but lineage must not force operator detours that hide shortlist relevance.

### Calmness law
The HUD should feel clear, alive, and stable.
It should not feel noisy, over-eager, or architecturally hungry.
Operator trust rises when the HUD shows what the system actually knows rather than pretending it can know everything instantly.

---

## What the HUD owns

The HUD owns:
- visual presentation
- layout and page structure
- retained object policy
- wording and operator-facing labels
- source labeling between structural and tactical surfaces
- page hydration behavior
- transition lock/freeze behavior where assigned
- object update discipline
- visual stale/degraded signaling
- bounded tactical display behavior for explicitly allowed fields

The HUD owns presentation.
It does not own the meaning of scanner truth.

---

## What the HUD does not own

The HUD does not own:
- market-state truth
- packet truth
- filtering truth
- shortlist truth
- deep truth
- governor mode policy
- persistence policy
- selection authority
- deep-service entitlement

If the HUD begins granting itself these roles, the architecture is drifting.

---

## Canonical HUD planes

### Plane 1 — Structural plane
The structural plane is the main committed surface of the HUD.
It consumes:
- landed layer artifacts
- approved structural support artifacts
- runtime control posture artifacts where appropriate

The structural plane is used for:
- scanner overview
- counts and posture summaries
- bucket views
- shortlist state
- promoted-set state
- committed symbol truth pages

The structural plane should be calm, interpretable, and persistence-backed where appropriate.

### Plane 2 — Tactical plane
The tactical plane is the narrowly bounded immediacy surface.
It consumes:
- explicitly permitted direct reads
- already-admitted selected-symbol fields
- bounded focus overlays

The tactical plane is used for things like:
- ticking server time
- focused-symbol bid
- focused-symbol ask
- focused-symbol spread
- other explicitly assigned fast-moving selected-symbol fields

The tactical plane is not a grant of broader runtime authority.

### Plane-separation rule
Every HUD field or section should be traceable to one of these planes.
A field that cannot be classified is a design risk.

### Cadence-to-page-region binding
- `cadence_t0_tick` allowed regions: Overview/Home utility clock (optional), Symbol Overview tactical strip, Symbol Aspect Detail tactical mini-strip/header strip.
- `cadence_t1_fast` allowed regions: Symbol Overview tactical strip support cells, Symbol Aspect Detail tactical mini-strip support cells.
- Main Groups and Sub-Groups admit no tactical cadence regions.
- Any region not explicitly listed above is tactical-cadence forbidden.

---

## Source-of-truth doctrine

### Structural source rules
Structural HUD surfaces should read from:
- landed layer-owned truth artifacts
- approved structural support artifacts
- committed runtime control artifacts where appropriate

### Tactical source rules
Tactical HUD surfaces should read from:
- direct read paths explicitly approved by the blueprint
- currently selected symbol scope only where architecture assigns that right

### The HUD must know what source it is showing
The operator surface should never force the operator to guess whether a value is:
- fresh direct tactical data
- recently committed structural truth
- stale structural truth
- last-good continuity support

Source posture must remain inspectable in architecture and implementation.

---

## Page model doctrine

### Overview pages
Overview pages should emphasize scanner posture rather than tactical twitch.
Typical examples include:
- runtime overview
- Layer 1 universe posture
- bucket summaries
- shortlist posture
- promoted-set posture

Overview pages belong primarily to the structural plane.

### Symbol pages
Symbol pages may combine:
- committed structural truth for the symbol
- bounded tactical fields for the currently selected symbol

That combination is allowed only when the architectural source boundary remains clear.

### Detail pages
Detail pages may expose richer committed structure such as:
- packet detail
- filter detail
- shortlist membership basis
- deep promoted truth for promoted members

Detail pages must still respect the rule that visibility does not grant new runtime authority.

### Navigation pages
Navigation and selection surfaces may change what the operator is viewing.
They must not silently rewrite the scheduler.

---

## Tactical responsiveness verification checklist (no persistence escalation)

Use this checklist whenever tactical responsiveness changes are introduced:
1. Confirm per-page tactical redraw stays within strip-only or utility-clock-only domains (by page contract).
2. Confirm tactical events never trigger structural card-tree rebuilds or hierarchy reconstruction.
3. Confirm symbol strip payload identity always equals current selected symbol id (no foreign-symbol leaks).
4. Confirm persistence/publication cadence remains structural and unchanged during tactical burst tests.
5. Confirm tactical responsiveness targets are met via repaint coalescing/retained-object reuse, not persistence-cadence escalation.

---

## Focus doctrine

### Focus is narrow
A focused symbol or selected page may justify limited tactical elevation.
That elevation exists so the operator can perceive important fast-moving selected-symbol truth without waiting for calm persistence cycles.

### What focus may elevate
Focus may elevate only what the architecture explicitly allows, such as:
- selected-symbol tactical Layer 2 fields
- selected-symbol tactical HUD render cadence
- already-admitted deep structural consumption for a promoted symbol
- Current Focus visibility and selected-symbol working posture for the active symbol

### What focus may not elevate
Focus may not justify:
- Layer 4 shortlist rebuild
- Layer 5 deep service for a non-promoted symbol
- broad packet refresh for unrelated symbols
- same-speed persistence landing
- rewriting Market Board into a signal dashboard
- turning Current Focus into hidden multi-symbol history

## Visible-only compute and render-transaction law

HUD compute during render transaction must be visible-only:
- HUD computes only what is visible on the current page and visible region.
- Invisible pages/regions must not be eagerly rebuilt during transaction.
- HUD transaction may acquire temporary exclusive UI ownership.
- Competing heavy non-HUD lanes must yield until render transaction completes when HUD transaction ownership is active.
- HUD uses retained objects and changed visible objects only where possible.
- Redraw occurs exactly once at end of transaction.
- Transaction pause is completion-bounded, not arbitrary delay-based.

HUD render ownership is a transaction discipline, not hidden execution authority.

---

### HUD-triggered deep-activation law
HUD interaction may explicitly request on-demand Deep Analysis for one selected symbol where architecture allows that path.
That request must stay isolated from global processing and must not widen Deep Analysis into a normal always-on service.

The HUD may therefore trigger depth.
It may not quietly grant global runtime authority.

- global recalculation because one symbol is visible

### Focus must remain reversible
When focus changes or ends, tactical elevation must relax cleanly.
The HUD must not leave hidden fast-mode behavior running after the operator moved elsewhere.

---

## Transition doctrine

### Why transition control exists
Page changes, symbol changes, and mode changes can create temporary visual instability if the HUD repaints too aggressively from mixed sources.
A bounded transition policy may therefore be used to preserve visual clarity.

### Transition lock / freeze behavior
The HUD may use bounded transition freeze or lock behavior to:
- avoid mixed-frame/object churn
- let a visible-object hydration cycle settle
- prevent flicker during page swaps
- preserve intelligible visual state during source changes
- pause competing heavy work when lawful HUD transaction ownership requires it

Transition freeze/lock exists for visual stability and is bounded by transaction completion.

### Transition control must stay bounded
Transition protection must be:
- completion-bounded by transaction outcome
- explicit in purpose
- subordinate to runtime truth
- incapable of becoming a hidden starvation engine

A transition freeze that silently blocks structural updates for too long is a design failure.

### Transition control is visual, not epistemic
The HUD may freeze visual movement briefly.
It must not pretend that frozen visuals mean fresh underlying truth or imply freshness beyond source posture.

---

## Render doctrine

### Retained-object law
HUD rendering should prefer retained objects and bounded property diffs over repeated broad rebuilds.
The UI should update what changed materially rather than rebuild everything by habit.

### Object-count law
Object count must remain bounded and intentional.
The HUD must not turn visual convenience into runaway object sprawl.

### Material-change render law
A structural HUD surface should generally redraw because:
- the underlying committed source changed materially
- the operator changed page/symbol/mode
- stale/degraded posture changed materially
- a bounded tactical field update is due

Tactical strip motion must remain strip-local and must not trigger full page rebuild, page-model reconstruction, board recomposition, or hierarchy regeneration.
Page transitions should rebuild only current visible object graph. Retained-object and bounded-property-diff discipline is mandatory.

### What should not usually trigger full redraw
- timer pulses alone
- minor invisible state movement
- unrelated symbol changes
- tactical movement in a field not shown on the current page

### Rendering must not pull hidden compute
Render logic must not quietly drag packet rebuilds, filter reruns, shortlist recomputation, or deep-analysis service into the same path.
Future EA implementation is invalid if HUD render path becomes a second engine or hidden scheduler.

---

## Wording doctrine

### Operator language first
The HUD should speak in clear operator language rather than exposing internal mechanic jargon when simpler truthful language exists.
Operator-visible labels must remain trader-safe and must not expose engineering internals as product language.
Forbidden operator-visible jargon includes terms such as `packet target`, `micro-burst`, `dirty route`, `scheduler pulse`, `queue token`, `cadence class`, and `retry exhausted`.
Operator-safe wording should prefer market-state and timing labels such as Open/Closed/Uncertain/Unknown, Last Checked/Next Check, Freshness/Delayed/Degraded, Confidence, and Status Note.

### Honesty over polish
If the system is stale, degraded, pending, blocked, or using last-good support, the HUD must say so in operator-safe wording.

Touched symbol-facing HUD and artifact surfaces must also:
- label broker descriptors with explicit trust posture (`broker-supplied (unverified)` or `unavailable`)
- label approximation and placeholder summary fields explicitly when stronger model support is not available
- keep freshness and uncertainty visible even when repetitive wording is reduced
Visual smoothness must not come at the cost of lying.

### No-permanent-pending law
Operator-facing outputs must not use permanent "Pending" as a resting state.
Allowed operator-visible states are:
- actual value
- not yet observed
- unavailable
- not applicable
- last confirmed value
- awaiting next refresh

"Pending", "Reserved", and "Placeholder" may appear only as bounded transient engineering posture where truly necessary.
They must not persist indefinitely in HUD, summary, or dossier surfaces.

### Wording should preserve architectural distinctions
The operator does not need internal code names, but the HUD should still preserve essential distinctions such as:
- current vs stale
- structural vs tactical
- selected vs promoted vs merely visible
- committed vs continuity-backed
- Layer 1-only truth vs deeper-layer truth not yet published

---

## Stale and degraded signaling doctrine

### Visibility of weakness is required
When structural truth is stale or degraded, the HUD must make that visible.
It must not silently keep repainting old data as if it were fresh.

### Tactical movement does not hide stale structure
A fast-moving selected-symbol bid/ask does not make stale shortlist truth any less stale.
The HUD must not let tactical liveliness visually erase structural weakness.

### Signaling should remain calm
Stale/degraded visibility should be clear without becoming theatrical or noisy.
The goal is operator trust, not panic decoration.

---

## HUD support artifact doctrine

### HUD support artifacts serve structure
Where the HUD uses prepared support artifacts, those artifacts must be understood as structural committed inputs.
They help hydrate calm pages.
They do not replace tactical direct reads.

### HUD support artifacts must remain downstream
A support artifact exists because structural truth was already landed elsewhere.
The HUD must not treat support artifacts as hidden transport truth superior to the layer-owned blocks they derive from.

---

## Relation to the governor

### The governor admits runtime work, not the HUD
The HUD may request or expose focus state.
The governor decides whether any tactical refresh or related service is admitted.

### HUD must remain subordinate to mode posture
If the system is in congestion, recovery, or degraded mode, the HUD must respect that posture.
It may not behave as though cosmetic smoothness outranks protected structural guarantees.

### Focus must yield under protected pressure
If protected structural work is starving, tactical HUD extras must yield before core guarantees break.

---

## Relation to persistence

### Structural HUD should prefer landed truth
Structural HUD surfaces should normally consume landed truth or approved support artifacts.
This improves clarity, auditability, and recovery discipline.

### Tactical HUD should not drag write cadence upward
Fast tactical views may read more quickly.
They must not force the persistence system to publish at the same rate.

### The HUD must respect artifact-family boundaries
The HUD should know whether it is reading:
- structural layer transport truth
- runtime control posture
- last-good continuity support
- human-readable composed surfaces
- tactical direct read values

Those boundaries must remain interpretable.

---

## Common failure patterns

### Pattern 1 — HUD as hidden scheduler
Opening or viewing pages starts authorizing runtime work outside normal governor policy.

Result:
- page-dependent performance
- unstable causality
- structural starvation

### Pattern 2 — Second-engine drift
The HUD begins recomputing or re-deriving scanner truth during render or hydration paths.

Result:
- duplicated logic
- blurred ownership
- hard-to-debug drift

### Pattern 3 — Tactical contamination
Fast-moving selected-symbol fields begin to dictate structural page or persistence cadence.

Result:
- noisy writes
- unstable redraw behavior
- false sense of universal freshness

### Pattern 4 — Source ambiguity
The operator cannot tell whether a value is fresh tactical truth, stale structural truth, or last-good continuity support.

Result:
- trust erosion
- wrong operator interpretation
- poor recovery clarity

### Pattern 5 — Transition freeze overreach
A visual transition lock grows large enough to block meaningful updates or disguise stale state.

Result:
- visual smoothness at the cost of truth
- hidden starvation risk

---

## Implementation obligations

Any future MT5 implementation of the HUD must:
- preserve the structural/tactical split explicitly
- consume landed structural truth for stable surfaces
- use direct tactical reads only where architecture allows
- keep page visibility from granting hidden compute authority
- use bounded transition freeze/lock behavior only for visual stability
- prefer retained objects and bounded property updates
- surface stale, degraded, pending, blocked, and continuity-backed posture honestly
- keep focus overlays narrow and reversible
- respect governor mode posture and protected-class yield rules
- refuse second-engine drift and same-speed persistence contamination

If an implementation cannot explain what source family a visible HUD field comes from, that implementation is incomplete.

---


## Stage 5 operator-surface consolidation note

### Hard law
- The HUD is never a truth owner, signal engine, shortlist owner, or deep-completion authority.
- Page-open, focus, or symbol visibility does not imply Layer 5 completion.
- HUD surfaces may show Market Board, Dossier, Current Focus, and handoff readiness only as consumer views of already-owned truth.

### Required product contract
- Operator wording must preserve the distinctions between shortlist attention, deep readiness, deep completion, and downstream SIAM / analyst interpretation.
- Any visible handoff or readiness label must make clear that ASC stops at evidence plus bounded handoff, not final signal ownership.
- HUD wording must not let Market Board read like a signal dashboard or let Current Focus read like automatic deep completion.

### Future expansion option
Later UI refinement may improve presentation density or navigation convenience without changing ownership, authority, or source-family boundaries.


## Final standard

ASC HUD is correct when it presents scanner truth clearly enough that the operator can trust what they are seeing without the interface secretly rewriting how the scanner works.

That means the HUD must be:
- consumer-first
- structurally grounded
- tactically narrow where immediacy is allowed
- honest about freshness and weakness
- visually calm
- source-explicit
- governor-subordinate
- hostile to second-engine drift

The standard is not that the screen looks lively.
The standard is that the screen remains a truthful operator surface rather than an alternative runtime authority.
