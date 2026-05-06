# ASC HUD Page Hierarchy and Product Contract

## Purpose

This document defines the final-law HUD product contract for ASC page hierarchy.

It freezes:
- mandatory page set
- per-page source boundaries
- per-page control law
- transition grammar
- layout density constraints
- performance and render invalidation constraints

This contract is downstream of `11_ASC_HUD_AND_OPERATOR_SURFACE.md`, `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`, and `ASC_TACTICAL_REALTIME_FIELD_CONTRACT.md` and is authoritative for page-level admissibility.
Symbol section-family architecture is additionally bound by `ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`.

Page-level render/freeze wording must not contradict completion-bounded HUD transaction ownership law.

---

## Mandatory page set (exact)

ASC HUD must implement exactly these page families as first-class product pages:
1. Overview / Home
2. Main Groups
3. Sub-Groups
4. Symbol Overview
5. Symbol Aspect Detail

No additional peer page families may be treated as canonical without explicit blueprint amendment.

## Symbol-context section navigation lock

When the operator is inside a selected-symbol context, HUD must expose a persistent symbol section navigation row with exact labels:
- `Overview`
- `Market Watch`
- `Specification`
- `Layer 3`
- `Layer 4`
- `Layer 5`
- `Layer 6`
- `Layer 7`

This row is section navigation inside symbol context; it does not redefine top-level HUD page families.

---

## Global HUD page law

### Ownership law
- HUD owns page presentation, navigation, and render discipline.
- Layer/runtime/persistence surfaces own scanner truth.
- Page visibility never grants scanner authority.

### Source law
- Every field must be explicitly classed as Structural or Tactical.
- Tactical reads are selected-symbol scoped only.
- Structural and Tactical values must never be merged into one unlabeled field.
- Layer 1 status surfaces (market state, freshness, next check) may appear on pages only when sourced from lawful committed Layer 1 truth or lawful continuity posture.
- Page labels must present these values as operator-safe product wording, not runtime/internal jargon.

### Control law
- HUD controls remain symbol-scoped action surfaces under `ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md`.
- No scanner-global loop controls are admissible in page controls.

### Performance baseline
- No full-page brute-force rerender on normal heartbeat ticks.
- HUD transaction computes visible page/region only; invisible pages/regions must not be eagerly rebuilt during active transaction.
- Renders must be retained-object and bounded-diff.
- Invalidation must be field/row/card scoped unless page model changes.
- Completion-bounded pause governs competing heavy work during lawful HUD transaction ownership.

### Tactical update budget (page-by-page hard budget)
Tactical budgets cap redraw scope and transaction impact. Tactical cadence must remain strip-local and never become structural rebuild authority.

| Page | Tactical invalidation rule | Max redraw domain | Structural rebuild permission |
|---|---|---|---|
| Overview / Home | optional utility clock cell only; no list/card tactical invalidation | utility clock widget only | forbidden on tactical ticks |
| Main Groups | tactical invalidation forbidden | none | forbidden |
| Sub-Groups | tactical invalidation forbidden | none | forbidden |
| Symbol Overview | strip-only invalidation for selected-symbol tactical cells/badges | tactical strip row + strip-local status badges | forbidden unless structural artifact version changes |
| Symbol Aspect Detail | strip-only invalidation for category header mini-strip/freshness timer cells | active aspect header strip + strip-local badges/timers | forbidden unless structural artifact version changes |

Hard guards:
- Tactical updates must not invalidate structural cards, group rows, aspect detail trees, or pagination models.
- Tactical bursts must degrade by coalescing strip repaints, never by widening redraw domains.
- Persistence cadence class may not be escalated to satisfy tactical responsiveness.

### Cadence-class to page-region map (explicit)
`cadence_t0_tick` and `cadence_t1_fast` are admissible only in narrowly bounded tactical UI regions:

| Page | `cadence_t0_tick` allowed regions | `cadence_t1_fast` allowed regions |
|---|---|---|
| Overview / Home | optional global utility clock cell | forbidden |
| Main Groups | forbidden | forbidden |
| Sub-Groups | forbidden | forbidden |
| Symbol Overview | symbol tactical strip core cells (bid/ask/spread/time/freshness) | symbol tactical strip support cells only |
| Symbol Aspect Detail | aspect tactical mini-strip/header strip core cells | aspect tactical mini-strip/header support cells only |

Any non-listed region is tactical-cadence forbidden and must remain structural cadence only.

---

## Control Placement Contract

### Global control zones (all HUD pages)
Every canonical HUD page must reserve the same control-zone scaffold so controls remain predictable across transitions:
1. **Top navigation zone** — primary hierarchy movement entry points only.
2. **Contextual breadcrumb/title zone** — current page identity and hierarchy lineage.
3. **Quick actions zone** — page-local and symbol-scoped actions only (symbol action buttons are symbol-page-only and never render on Overview/Home, Main Groups, or Sub-Groups).
4. **Health/status strip zone** — stale/degraded/continuity, runtime posture, and lawful structural progress/preparation signals.
5. **Optional pager zone** — list/window paging when row density exceeds page contract bounds.

Zone order must remain stable (top navigation -> breadcrumb/title -> quick actions -> health/status -> optional pager).
Pages may hide unused zones, but they may not repurpose one zone into another without doctrine change.

### Per-page control allocation rules
- **Overview / Home**
  - Top navigation: may route to Main Groups and approved symbol-pick entry.
  - Symbol action buttons: forbidden on this page (no Deep Analysis / Aurora Signal / Semi-Auto / Full Auto controls).
  - Breadcrumb/title: root title only; no synthetic deeper crumbs.
  - Quick actions: refresh-view, source legend, stale/degraded drawer toggles.
  - Health/status strip: required and scanner-posture focused.
  - Optional pager: only for overflow summary lists.
- **Main Groups**
  - Top navigation: hierarchy movement to Overview/Home and Sub-Groups.
  - Symbol action buttons: forbidden on this page (no Deep Analysis / Aurora Signal / Semi-Auto / Full Auto controls).
  - Breadcrumb/title: must include Overview -> Main Groups lineage.
  - Quick actions: structural sort/view/filter controls only.
  - Health/status strip: required group freshness/degradation posture.
  - Optional pager: allowed for long group lists.
- **Sub-Groups**
  - Top navigation: hierarchy movement to Main Groups, Overview/Home, Symbol Overview.
  - Symbol action buttons: forbidden on this page (no Deep Analysis / Aurora Signal / Semi-Auto / Full Auto controls).
  - Breadcrumb/title: must include full lineage chain.
  - Quick actions: subgroup expand/collapse/select and structural sort only.
  - Health/status strip: required subgroup freshness/degradation posture.
  - Optional pager: allowed for subgroup row virtualization/paging.
- **Symbol Overview**
  - Top navigation: hierarchy movement back to Sub-Groups/Main Groups/Overview.
  - Symbol action buttons: allowed only per symbol action matrix; Deep Analysis may be active, Aurora Signal / Semi-Auto / Full Auto remain non-active placeholders.
  - Breadcrumb/title: must include selected symbol identity.
  - Quick actions: symbol-scoped controls admitted by action-surface contract and aspect drilldown.
  - Health/status strip: required source-plane and tactical freshness posture.
  - Optional pager: only for bounded structural card/list overflow.
- **Symbol Aspect Detail**
  - Top navigation: hierarchy-safe return to Symbol Overview and approved ancestors.
  - Symbol action buttons: allowed only per symbol action matrix; Deep Analysis may be active, Aurora Signal / Semi-Auto / Full Auto remain non-active placeholders.
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

### Symbol action placement rule (hard guard)
- Symbol action buttons (Deep Analysis, Aurora Signal, Semi-Auto, Full Auto) are admissible only on Symbol Overview and Symbol Aspect Detail.
- Overview/Home, Main Groups, and Sub-Groups must not render symbol action buttons in any zone (including hidden drawers/modals).
- If selected-symbol context is stale or ineligible, button state must remain visible but blocked with reason wording from `ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md`.

### Anti-drift laws
- No duplicated navigation paths that express the same destination with different hierarchy meaning.
- No control migration between zones unless this contract and owning doctrine files are updated together.
- No scanner-global action controls are admissible in HUD zones; HUD quick actions remain symbol-scoped or page-local.
- No hidden fallback controls outside declared zones.
- No page-specific exception that weakens symbol action-surface constraints.
- Non-symbol and symbol pages must not leak engineering internals as operator-visible labels (for example packet target, micro-burst, dirty route, cadence class, queue token, or cursor markers).

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


## Bridge lifecycle binding reference

Canonical bridge lifecycle table section: `blueprint/final/ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md` -> **"Shared bridge lifecycle table (canonical)"**.

Local HUD hierarchy constraints:
- HUD quick actions remain page-local or symbol-scoped and must never become scanner-global execution rights.
- Aurora Signal, Semi-Auto, and Full Auto remain placeholder-only (not active) until explicit future doctrine promotion.
- Revoked/ineligible states must be shown honestly in HUD status surfaces; no hidden fallback execution paths are admissible.

Anti-duplication note: **If bridge table changes, only canonical source is edited.**

## Fixed Symbol Aspect Categories Contract

### Canonical category set (exact, ordered)
Symbol Aspect Detail must implement exactly these aspect categories as first-class selectors:
1. Market Action
2. Trading Conditions
3. Market Context
4. Deep Analysis
5. Account/Trade Context (when relevant)
6. Publication/Result Status

No additional peer aspect categories may be introduced without blueprint amendment.

### Category field law and density defaults
| Category | Mandatory fields | Forbidden fields | Structural vs tactical allowance | Default density mode |
|---|---|---|---|---|
| Market Action | selected symbol, timeframe, last committed structural action-state label, structural timestamp, tactical mini-strip (bid/ask/spread/server time) with source badge | account balance/equity/order book, deep rationale payload blobs, scanner-global controls | Mixed: structural header + bounded selected-symbol tactical strip only | row |
| Trading Conditions | spread class, session/liquidity posture, volatility regime marker, freshness/degraded marker, structural publish timestamp | discretionary narrative paragraphs, unlabeled tactical-only cells, broker account mutation controls | Structural-first; tactical allowed only as compact corroboration values for selected symbol | row |
| Market Context | regime/context summary, group/sub-group lineage, structural confidence/posture flags, continuity status | tick-by-tick tape walls, deep artifact internals, execution controls | Structural only in default view; tactical forbidden by default | card |
| Deep Analysis | deep eligibility state, last deep run id/time, bounded rationale summary bullets, promoted/deployability posture, continuity/degraded status | raw full deep payload dump, hidden rerun-on-open triggers, non-selected-symbol deep artifacts | Structural only; tactical not allowed except freshness timers | detail panel |
| Account/Trade Context (when relevant) | position side/size (if open), avg entry, unrealized P/L class, risk posture tag, publication timestamp, missingness reason when unavailable | credential/account identifiers, broker secrets, mutation controls (modify/close/place), unrelated symbol orders | Structural only; tactical forbidden unless explicitly promoted by separate contract | row |
| Publication/Result Status | publication status, last result state, artifact lineage/version, stale/degraded/continuity indicators, error/warning summary counts | raw logs beyond bounded excerpts, stack traces in default panel, tactical market stream fields | Structural only; tactical forbidden | card |

### Collapse, expand, and pagination defaults
- Category panels default to collapsed, except the active selected category panel.
- Within the active category panel, only the first 6 rows (row mode) or first 4 cards (card mode) render expanded by default.
- Detail panel mode defaults to summary-first with evidence subsections collapsed.
- Evidence or table blocks must paginate at 12 rows per page (hard max 20).
- Expanding one heavy evidence block should auto-collapse sibling heavy blocks in the same category.
- Pagination state is per category and resets on symbol switch.

### Explicit anti-dump readability constraints
- Aspect Detail must not render more than 2 expanded heavy blocks at once.
- Any field value longer than 220 characters must be clamped with "show more" disclosure.
- Default render budget for a category view is <= 45 visible data cells before pagination/collapse.
- Raw JSON/text payloads are forbidden in default view; only bounded summaries with opt-in drilldown are admissible.
- Tactical mini-strip is capped at one compact row and may not duplicate inside each subsection.
- Tab/category switch must complete with retained-object reuse and without full-page dump/rerender.

---

## Page contract 1 — Overview / Home

### Purpose and ownership
- Purpose: show scanner-wide posture summary for operator orientation.
- Ownership: HUD presentation only; source truth owned by landed runtime/layer artifacts.

### Allowed controls and button families
- page navigation buttons
- refresh-view (non-authoritative, view-level rehydrate)
- source legend toggle
- stale/degraded detail drawer toggle

Not allowed: symbol-action execution controls, deep-trigger controls, shortlist-write controls.

### Source map by field
Structural fields:
- runtime mode posture
- active lane posture and governor mode posture
- preparation progress/fill posture
- freshness/assessed/remaining/readiness progress surfaces where structurally owned
- queue/backlog/continuity/degraded posture where structurally owned
- heartbeat health/status summary
- layer freshness/status summaries
- shortlist/promoted counts
- artifact continuity/degradation indicators

Tactical fields:
- none mandatory
- optional global clock display only if explicitly classed as tactical display utility (not scanner truth)

### Real-time fields allowed
- UI clock tick display (if implemented)
- freshness age counters derived from structural timestamps

### Explicit forbidden content
- per-symbol bid/ask/spread streams
- deep-analysis trigger buttons
- shortlist membership mutation controls
- any hidden scheduler or admission controls
- treating background progress surfaces as tactical market streams

Missing progress fields must be shown honestly as unavailable/not-yet-published rather than invented.

### Next-page transitions
- Overview / Home -> Main Groups
- Overview / Home -> Symbol Overview (only via explicit symbol pick flow)

### Layout grammar (card/row density rules)
- desktop: 2–3 primary summary columns, max 12 primary cards above fold
- row lists: max 8 summary rows per card before overflow drilldown
- no tactical ticker ribbons on this page

### Performance constraints and render invalidation rules
- invalidate only changed summary cards/rows
- transition freeze/reload control must remain brief under healthy conditions and is bounded by transaction completion, not fixed-delay sleep.
- no symbol-grid rerender if only runtime posture changed
- tactical budget: utility clock (if present) invalidates only its own cell with max redraw domain = utility clock widget

---

## Page contract 2 — Main Groups

### Purpose and ownership
- Purpose: present primary grouping buckets for structural scanner navigation.
- Ownership: grouping truth remains upstream; HUD owns arrangement and interaction.

### Allowed controls and button families
- group selection buttons
- sort/view mode toggles (structural metrics only)
- filter chips that operate on structural published fields
- back/home navigation

Not allowed: scanner-global run/pause control, deep runtime toggles, tactical streaming panel controls.

### Source map by field
Structural fields:
- group name/id
- group counts and composition metrics
- group freshness/degradation state
- group-level shortlist/promoted aggregates

Tactical fields:
- none

### Real-time fields allowed
- age/freshness counters
- optional delayed heartbeat indicator badge

### Explicit forbidden content
- selected-symbol bid/ask/spread
- per-symbol execution action stack
- direct deep artifacts beyond summary eligibility markers

### Next-page transitions
- Main Groups -> Sub-Groups
- Main Groups -> Overview / Home
- Main Groups -> Symbol Overview (via explicit symbol selection inside a group)

### Layout grammar (card/row density rules)
- groups rendered as cards or rows, max 20 visible group items before paging/virtualization
- large-universe threshold: > 40 group rows requires virtualization/paging; > 120 requires deterministic paging
- per-group card shows max 6 key metrics
- nested subgroup panels must not open inline beyond one depth level
- no synthetic group cards/placeholders may be injected to satisfy grid symmetry

### Performance constraints and render invalidation rules
- group-row/card local invalidation only
- sorting/filtering reorders retained objects; no full control rebuild
- update cadence for structural refresh aligned to landed artifact cadence, not tick cadence
- tactical budget: none (tactical cadence classes are forbidden on this page)
- background progress surfaces may render only from lawful structural/control sources and must not grant runtime admission authority.

---

## Page contract 3 — Sub-Groups

### Purpose and ownership
- Purpose: expose second-level grouping and narrow operator navigation to symbol sets.
- Ownership: subgroup truth from structural artifacts; HUD owns hierarchical drilldown behavior.

### Allowed controls and button families
- subgroup expand/collapse
- subgroup select
- structural metric sort
- breadcrumb navigation

Not allowed: tactical symbol stream toggles, shortlist/deep mutation controls.

### Source map by field
Structural fields:
- subgroup name/id
- subgroup symbol count and coverage metrics
- subgroup status/freshness indicators
- subgroup shortlist/promoted composition summaries

Tactical fields:
- none

### Real-time fields allowed
- freshness age counters

### Explicit forbidden content
- direct symbol bid/ask/spread
- deep-analysis payload detail
- symbol action execution controls

### Next-page transitions
- Sub-Groups -> Symbol Overview
- Sub-Groups -> Main Groups
- Sub-Groups -> Overview / Home

### Layout grammar (card/row density rules)
- hierarchical rows: max 2 visible hierarchy levels on screen
- max 30 visible subgroup rows with virtualization/paging beyond that
- large-universe threshold: > 80 subgroup rows requires virtualization/paging; > 240 requires deterministic paging with subgroup prioritization
- symbol previews in subgroup row limited to top 5 symbols (hard max 8)
- subgroup overflow ordering must remain structural (promoted/freshness/pin priority), never template-fill order

### Performance constraints and render invalidation rules
- expand/collapse invalidates affected subtree only
- subgroup metric update invalidates row-level nodes only
- subgroup-to-symbol transition lock must remain brief under healthy conditions and is bounded by transaction completion, not fixed-delay sleep.
- tactical budget: none (tactical cadence classes are forbidden on this page)
- non-symbol pages must not gain tactical stream rights from background progress visibility.

---

## Page contract 4 — Symbol Overview

### Purpose and ownership
- Purpose: provide symbol-level structural truth with bounded tactical overlay for selected symbol.
- Ownership: symbol truth remains layer/persistence owned; HUD owns composition and source labeling.

### Allowed controls and button families
- symbol selection/navigation
- symbol-scoped action buttons admitted by action-surface contract
- source-mode legend and visibility toggles
- aspect drilldown buttons

Not allowed: scanner-global execution loops, non-selected-symbol tactical stream controls.

### Source map by field
Structural fields:
- symbol identity and classification
- packet/filter/shortlist/promoted structural status
- last structural publication timestamps
- continuity/stale/degraded markers

Tactical fields (selected symbol only):
- current bid
- current ask
- current spread
- server time
- explicitly assigned additional tactical fields (if approved upstream)

### Real-time fields allowed
- selected-symbol bid/ask/spread/server time
- selected-symbol tactical freshness age

### Explicit forbidden content
- tactical fields for non-selected symbols
- hidden deep-trigger side effects on page open
- unlabeled blend of tactical and structural values in single metric cell

### Next-page transitions
- Symbol Overview -> Symbol Aspect Detail
- Symbol Overview -> Sub-Groups
- Symbol Overview -> Main Groups
- Symbol Overview -> Overview / Home

### Layout grammar (card/row density rules)
- top frame: symbol header + source badges always visible
- structural cards and tactical strip must be visually separated
- tactical strip max 1 row high; no multi-row ticker wall
- max 10 structural cards before secondary tabs/accordion

### Performance constraints and render invalidation rules
- tactical updates invalidate tactical strip fields only
- structural artifact updates invalidate corresponding structural cards only
- symbol switch transition freeze is bounded by transaction completion with source badges locked during swap; fixed-delay sleeps are forbidden.
- tactical budget hard cap: strip-only invalidation with max redraw domain = tactical strip row + strip-local badges
- tactical tick, fast cadence, or freshness timer change must not trigger structural card-tree rebuild/re-sort/re-pagination
- symbol strip payload must be bound to current selected symbol id; non-selected-symbol tactical values are forbidden
- page-model rebuild may occur only on structural page-model change, never on strip motion alone.

---

## Page contract 5 — Symbol Aspect Detail

### Purpose and ownership
- Purpose: show deepened aspect-level structural detail for the selected symbol with explicit source posture.
- Ownership: aspect truth owned upstream; HUD owns sectioning and readability.

### Allowed controls and button families
- aspect tab/section selectors
- symbol-scoped action controls explicitly admissible by contract
- back-to-symbol-overview navigation
- source breakdown toggles

Not allowed: bulk multi-symbol action controls, scanner-wide tactical mode toggles.

### Source map by field
Structural fields:
- category-scoped mandatory fields from the Fixed Symbol Aspect Categories Contract
- aspect-specific packet/filter/selection/deep records
- eligibility/decision basis fields as published structurally
- structural lineage timestamps and version markers

Tactical fields (selected symbol only, narrow):
- only category-allowed tactical fields from the Fixed Symbol Aspect Categories Contract
- current bid/ask/spread/server time when contextually attached to aspect header

### Real-time fields allowed
- selected-symbol tactical mini-strip (optional)
- freshness timers for displayed aspect artifacts

### Explicit forbidden content
- tactical-only pages that suppress structural basis
- deep recomputation triggered by tab switch
- runtime admission overrides exposed as UI controls

### Next-page transitions
- Symbol Aspect Detail -> Symbol Overview
- Symbol Aspect Detail -> Sub-Groups
- Symbol Aspect Detail -> Overview / Home

### Layout grammar (card/row density rules)
- each aspect category must honor its fixed default density mode (card/row/detail panel) from the Fixed Symbol Aspect Categories Contract
- aspect sections use 1 primary column + optional side metadata rail
- no more than 14 visible detail rows per section before pagination/collapse
- evidence tables default collapsed beyond first 8 rows
- category pages must enforce anti-dump caps (<= 45 visible cells before forced pagination/collapse)

### Performance constraints and render invalidation rules
- tab switch should reuse retained objects; avoid full page reconstruction
- aspect-section updates invalidate section scope only
- tactical mini-strip invalidation independent from aspect structural region
- tactical budget hard cap: mini-strip/header-strip only with max redraw domain = active aspect header strip + strip-local badges/timers
- tactical cadence events must not trigger aspect structural tree rebuild or category pagination resets
- symbol tactical mini-strip must consume selected-symbol payload only; foreign-symbol tactical values are forbidden
- completion-bounded pause during lawful HUD transaction ownership may yield competing heavy non-HUD work, but must not imply hidden freshness authority.

---

## Admissibility and drift control

A HUD implementation is non-compliant if it:
- omits any mandatory page family
- introduces canonical peer pages without blueprint amendment
- places forbidden content on a page
- allows unlabeled structural/tactical blending
- uses page visibility as implicit authority expansion
- violates invalidation granularity and repeatedly brute-force rerenders
- allows tactical cadence activity to trigger structural card-tree rebuilds
- leaks non-selected-symbol tactical values into symbol tactical strips
- requires fixed-delay sleeps for smoothness
- widens redraw domain because a strip moves fast
- mistakes background progress surfaces for tactical market streams

Any exception requires explicit blueprint update and roadmap linkage.

### Tactical responsiveness verification checklist (without persistence-cadence escalation)
1. Drive synthetic high-frequency selected-symbol ticks and confirm tactical strip repaint remains strip-bounded on Symbol Overview and Symbol Aspect Detail.
2. Verify Overview/Home, Main Groups, and Sub-Groups do not start tactical redraw loops.
3. Confirm no tactical event triggers structural card-tree rebuild/re-sort/re-pagination on any page.
4. Confirm persistence write cadence and publication trigger frequency remain at structural cadence during tactical bursts.
5. Confirm telemetry/logs show no persistence-cadence class escalation while tactical responsiveness targets remain satisfied.
