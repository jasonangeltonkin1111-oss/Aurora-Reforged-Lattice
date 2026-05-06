# ASC Stage 9 — HUD and Operator Surface

## Purpose

This document defines Stage 9 of the Aurora Sentinel Scanner (ASC) rebuild roadmap.

Stage 9 is the HUD-and-operator-surface stage.
Its job is to turn the already-landed structural truth stack into a lawful operator-visible surface with a bounded tactical overlay where the architecture explicitly permits it.


Reframing law: Stage 9 is **not** the first-HUD authorization stage.
HUD consumer scaffold homes are opened earlier as Stage 1 foundation rails and are progressively hydrated by Layers 1–5 plus persistence maturity.

If Stage 8 makes the truth stack durably landed, Stage 9 answers the next lawful question:

> how should the operator see ASC truth clearly, calmly, and honestly without the interface becoming a second engine?

This stage exists because operator surfaces become dangerous when they outrun truth ownership, invent hidden scheduling rights, or blur structural and tactical sources into one ambiguous feed.

---

## Stage objective

Stage 9 establishes lawful HUD/operator behavior on top of the landed artifact system and bounded tactical read rights.

It defines and/or implements:
- structural HUD surfaces backed by landed truth
- source-aware page hydration
- bounded tactical selected-symbol overlays
- structural vs tactical source separation in visible surfaces
- retained-object render discipline
- bounded transition lock/freeze behavior
- honest stale/degraded/continuity-backed signaling
- focus behavior that remains subordinate to runtime and selection law

The goal is not to make the screen busy.
The goal is to make the screen trustworthy.

---

## Why Stage 9 matters

Without Stage 9, the scanner may have a lawful truth stack and lawful artifacts, but the operator surface still risks falling into one of several bad shapes:
- view paths begin reconstructing truth ad hoc
- page visibility becomes a hidden runtime scheduler
- stale structural truth hides behind tactical movement
- operator trust erodes because the source of visible fields is unclear
- transition smoothing starts overriding truthfulness

Stage 9 matters because it is the point where ASC proves that the interface can stay downstream of architecture.

If Stage 9 is weak:
- HUD begins competing with the governor
- tactical rights widen through convenience
- source ambiguity makes debugging and recovery harder
- the operator sees motion, but not trustworthy meaning

---

## Stage 9 dependency position

Stage 9 depends on:
- Stage 0 repo reset being complete
- Stage 1 shared types/state/contracts being complete enough for HUD state, source typing, focus posture, stale/degraded signaling, and page layout records
- Stage 2 dispatcher/governor spine being real enough to govern tactical overlays and prevent UI-led runtime authority
- Stages 3 through 7 having produced real layer-owned truth
- Stage 8 persistence/artifact work being real enough that structural HUD surfaces can consume landed truth lawfully
- final blueprint files for HUD/operator surface, persistence/artifacts, runtime law, work classes, and invalid designs already being authoritative

Stage 9 is the prerequisite for:
- full hardening/acceptance against operator-facing behavior
- later rich summaries and human-readable compositions that depend on lawful HUD source posture
- end-to-end validation that ASC is not merely structurally correct in code but also truthful in presentation

---

## Stage 9 contract constraints (symbol action surfaces)

Stage 9 must enforce `blueprint/final/ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md` as an active constraint.
Stage 9 must enforce `blueprint/final/ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md` as the page-level HUD product law.
Stage 9 must enforce `blueprint/final/ASC_MENU_AND_SETTINGS_CONTRACT.md` as the EA settings/menu law for operator-facing controls.

Required constraints for this stage:
- Layer 6 (Semi-Auto) and Layer 7 (Full Auto) remain scaffold-only and non-runtime
- HUD controls must be symbol-scoped action surfaces, never scanner-global loops
- any post-Deep-Analysis action path must pass through explicit handoff bridge semantics (inputs/outputs/eligibility)
- future Layer 7 workflow-collapse ideas remain placeholders and are not admissible implementation scope in Stage 9

A Stage 9 completion claim is invalid if it introduces scanner-global action behavior under HUD/operator convenience framing.

## Stage 9 symbol action button matrix (implementation requirement)

Stage 9 HUD implementation must realize the symbol action matrix with the following columns:
- button
- page location
- visibility condition
- enabled condition
- current behavior
- future behavior
- forbidden scopes

Required Stage 9 matrix posture:
- **Deep Analysis** is the only working advanced action now.
- **Aurora Signal**, **Semi-Auto**, and **Full Auto** are symbol-scoped placeholders with explicit non-active wording.
- Symbol action buttons appear only on symbol pages (Symbol Overview, Symbol Aspect Detail).
- Symbol action buttons never appear on Overview/Home, Main Groups, or Sub-Groups.
- stale/ineligible/provenance-blocked symbol context must show explicit blocked wording and fail closed.

## Bridge lifecycle binding reference

Canonical bridge lifecycle table section: `blueprint/final/ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md` -> **"Shared bridge lifecycle table (canonical)"**.

Local Stage 9 HUD/operator constraints:
- HUD surfaces may consume bridge outcomes only as symbol-scoped operator affordances and status signals.
- Placeholder action states remain visibly non-active; Stage 9 must not introduce hidden execution rights.
- Revocation/blocked posture must remain explicit in HUD messaging and control-state behavior.

Anti-duplication note: **If bridge table changes, only canonical source is edited.**

## Control Placement Contract

### Global control zones (all HUD pages)
Every canonical HUD page must reserve the same control-zone scaffold so controls remain predictable across transitions:
1. **Top navigation zone** — primary hierarchy movement entry points only.
2. **Contextual breadcrumb/title zone** — current page identity and hierarchy lineage.
3. **Quick actions zone** — page-local and symbol-scoped actions only (symbol action buttons are symbol-page-only).
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

## Stage 9 scope

Stage 9 includes:
- completing rich structural HUD pages backed by landed truth
- implementing source-aware HUD field typing and hydration posture
- implementing bounded tactical selected-symbol overlays where architecture allows them
- implementing explicit structural vs tactical visual separation
- implementing retained-object and bounded-diff rendering posture
- implementing bounded transition lock/freeze behavior for clarity during page/symbol shifts
- implementing stale/degraded/pending/continuity-backed signaling in operator-safe form
- implementing focus overlay behavior without granting hidden runtime authority

Stage 9 does **not** include:
- treating Stage 9 as first permission for any HUD existence
- making the HUD a runtime scheduler
- introducing new truth ownership into the UI layer
- introducing settings labels or descriptions that violate operator-facing wording law
- widening tactical rights beyond the selected symbol and explicitly assigned fields
- using the HUD to backfill missing artifact or layer logic
- redefining selection, filtering, or persistence policy inside page code

---

## Stage 9 deliverables

Stage 9 should deliver the following outcomes.

### 1. Structural HUD surfaces become real
The active MT5 surface must now support real structural operator pages backed by landed truth, such as:
- scanner/runtime overview posture
- Layer 1 universe posture
- shortlist/promoted-set structural posture
- symbol structural detail sourced from landed truth

### 2. Tactical overlay becomes lawful and narrow
Stage 9 HUD work must translate engineering posture into honest operator wording.
Permanent `Pending`, `Reserved`, or `Placeholder` output is invalid.
Preferred operator-visible states are actual value, not yet observed, unavailable, not applicable, last confirmed value, and awaiting next refresh.

If the HUD triggers Deep Analysis, that activation must be explicit, symbol-specific, and isolated from global runtime processing.
HUD convenience must not widen deep runtime scope.
When symbol context is stale or ineligible, action controls must remain blocked with explicit reason wording rather than silent disable-only behavior.

The HUD must now be able to display bounded tactical current fields for the selected symbol where architecture allows them, without turning those reads into broad runtime rights.

Stage 9 menu/control work must classify controls as runtime-safe vs dangerous and maintain explicit runtime mapping so HUD convenience cannot create hidden constants drift.

### 3. Source separation becomes visible
The operator surface must now be able to distinguish, structurally and visually, between:
- structural committed truth
- tactical direct reads
- stale or degraded structure
- continuity-backed structure

### 4. Render discipline becomes real
The HUD must now render through retained objects and bounded updates rather than brute-force rebuild habits.

### 5. Transition behavior becomes bounded and explicit
Page/symbol transitions may now use brief bounded freeze/lock behavior to avoid mixed-frame or hydration confusion, but this must remain truth-safe.

---

## Core implementation targets

Stage 9 will primarily engage:
- `mt5/include/asc/hud/ASC_HUD_Manager.mqh`
- `mt5/include/asc/hud/ASC_HUD_Pages.mqh`
- `mt5/include/asc/hud/ASC_HUD_Render.mqh`
- `mt5/include/asc/hud/ASC_HUD_Layout.mqh`
- `mt5/include/asc/hud/ASC_HUD_Focus.mqh`
- `mt5/include/asc/hud/ASC_HUD_Transitions.mqh`
- `mt5/include/asc/hud/ASC_HUD_Sources.mqh`
- supporting read interfaces from layer/persistence surfaces only as much as lawful source selection requires

HUD ownership must stay visible and bounded.

---

## Structural-plane doctrine in Stage 9

### Structural HUD must now become real
Stage 9 should make it executable that most calm overview and structural symbol surfaces consume landed truth rather than live ad hoc recompute paths.

### Structural surfaces should prefer
- landed layer transport artifacts
- approved structural support artifacts
- lawful runtime control posture artifacts where relevant

### Structural surfaces should not depend on
- provisional in-memory truth with no commit boundary
- page-driven hidden recompute
- tactical overlays pretending to be structural truth

This is the main reason Stage 8 had to come first.

---

## Tactical-plane doctrine in Stage 9

### Tactical overlay begins here as a bounded visual right
Stage 9 should make it executable that a selected symbol may show fast-moving tactical fields where architecture allows them.
Typical examples include:
- server time
- selected-symbol bid
- selected-symbol ask
- selected-symbol spread
- other explicitly allowed Layer 2-owned tactical fields

### Tactical overlay remains narrow
This stage must preserve that tactical rights do not imply:
- packet refresh for unrelated symbols
- filter reruns
- shortlist rebuild
- deep-service entitlement for non-promoted symbols
- same-speed persistence landing

### Tactical is not structural
A field shown through tactical overlay must not be allowed to quietly impersonate structural committed truth.

---

## Source-of-truth doctrine in Stage 9

### Every visible field should now have a source class
Stage 9 should make it structurally possible to answer for any major visible HUD field:
- is this structural committed truth
- is this tactical direct truth
- is this stale structural truth
- is this continuity-backed structural truth
- is this runtime control posture rather than symbol truth

### Source ambiguity is unacceptable
If the operator or implementation cannot tell what source class a field belongs to, Stage 9 is incomplete.

### Source typing should become part of the HUD system itself
Do not rely on operator memory or future docs to preserve source distinctions.
The HUD layer must carry that distinction structurally.

---

## Page model doctrine in Stage 9

### Structural overview pages should come first
Stage 9 should prioritize calm high-value structural pages before richer decorative views.

Examples include:
- runtime/health overview
- Layer 1 universe posture overview
- shortlist/promoted-set overview
- symbol structural detail page

### Symbol/detail pages may combine structural and tactical only lawfully
A symbol page may show:
- committed structural packet/filter/selection/deep truth
- bounded tactical selected-symbol fields

But the source boundary must remain visible.

### Navigation does not grant compute rights
Changing page or selected symbol is a view action.
It may influence which lawful source is shown.
It may not become a blanket permission slip for new structural work.

---

## Focus doctrine in Stage 9

### Focus is now visible but still narrow
Stage 9 should make focus behavior real as an operator-surface overlay, not as a hidden architecture rewrite.

### Focus may lawfully influence
- which symbol’s tactical overlay is shown
- which structural symbol detail page is hydrated
- bounded tactical refresh posture for the selected symbol

### Focus may not influence
- who is shortlisted
- who is promoted
- which non-promoted symbols receive deep service
- whether broad packet or filter work is admitted
- whether persistence publication accelerates to match display cadence

### Focus must remain reversible
When selection changes, the focus overlay must cleanly release rather than leaving hidden special-cadence behavior behind.

---

## Transition doctrine in Stage 9

### Transition smoothing may now become real
Stage 9 should make it possible to use brief bounded transition lock/freeze behavior to improve visual clarity when:
- switching pages
- switching selected symbols
- moving between structural surfaces with different hydration requirements

### Transition control must stay bounded
The stage must preserve that transition freeze/lock:
- is short
- has a clear reason
- does not hide stale state for long
- does not suppress meaningful updates beyond its bounded role

### Transition control is visual only
A frozen view is not fresher truth.
Stage 9 must not allow transition behavior to blur that distinction.

---

## Render discipline doctrine in Stage 9

### Retained-object rendering should now become real
The HUD should now move toward retained objects and bounded property updates rather than broad redraw storms.

### Why this matters
Render behavior affects:
- performance
- clarity
- source stability
- how tempting it becomes to rebuild too much data on each pulse

### Material-change rendering only
Stage 9 should favor rendering because:
- the underlying structural source changed materially
- the selected page/symbol changed
- a lawful tactical field update is due
- stale/degraded signaling changed materially

It should avoid redrawing simply because the timer exists.

---

## Visual honesty doctrine in Stage 9

### Stale/degraded posture must now become operator-visible
If structural truth is stale, degraded, pending, blocked, or continuity-backed, the HUD must now make that visible in operator-safe language.

### Tactical movement must not hide structural weakness
A moving bid/ask does not make stale shortlist truth less stale.
Stage 9 must preserve this distinction visually.

### Honesty outranks cosmetic smoothness
The HUD should feel clean, but not at the cost of source truthfulness.

---

## Interaction with Stage 8 artifact system

### Stage 9 depends on real landed truth
Structural pages should now consume the artifact system as their primary structural source.
This should be one of the clearest demonstrations that Stage 8 was worthwhile.

### HUD must respect family boundaries
The stage should preserve operator-surface awareness of whether a source is:
- layer transport truth
- runtime control posture
- continuity/recovery support
- tactical direct read

### Consumer does not become author
The HUD may read structural artifacts.
It may not start acting like a better source than the artifacts themselves.

---

## Interaction with Stage 2 governor

### HUD remains governor-subordinate
Stage 9 must preserve that any tactical overlay behavior still lives under runtime law.
The HUD cannot simply choose to pull more runtime because the operator is looking at something.

### Focus must yield under protected structural pressure
If protected structural work is starving, tactical extras must remain bounded and yield appropriately.

### UI cannot become the scheduler
This must remain structurally impossible, not just discouraged.

---

## Evidence of success in Stage 9

A healthy Stage 9 should allow the system to demonstrate things like:
- structural pages can be hydrated from landed truth without recomputing it ad hoc
- the selected symbol can show bounded tactical current fields without widening scope
- the operator can tell when data is structural, tactical, stale, degraded, or continuity-backed
- switching pages/symbols remains visually calm without hiding source truth
- the UI no longer needs to “cheat” to feel alive

These are better signs of success than simply having more pages or prettier visuals.

---

## What Stage 9 must not do

### 1. No HUD-as-scheduler behavior
Do not let page visibility or navigation silently authorize runtime work outside normal governor admission.

### 2. No second-engine drift
Do not let the HUD reconstruct market-state, packet, filter, shortlist, or deep truth in view code.

### 3. No source ambiguity
Do not let visible fields blur structural, tactical, stale, or continuity-backed posture together.

### 4. No transition overreach
Do not let freeze/lock behavior become long enough to hide meaningful updates or stale state.

### 5. No same-speed publication contamination
Do not let tactical display demands drive structural artifact landing cadence.

### 6. No focus entitlement bug
Do not let focused non-promoted symbols gain deep service or broader packet authority through UI attention.

---

## Stage 9 implementation approach

The preferred progression inside Stage 9 is:

1. implement source-aware HUD field/page typing
2. implement structural page hydration from landed truth
3. implement retained-object render posture and material-change redraw rules
4. implement bounded tactical selected-symbol overlays
5. implement stale/degraded/continuity-backed signaling
6. implement focus behavior and clean release posture
7. implement bounded transition lock/freeze behavior
8. verify that navigation never grants hidden runtime authority

### Stage 9 HUD compliance checklist lanes
Stage 9 execution and completion evidence must maintain the following checklist lanes as explicit tracked lanes (each lane must be pass/fail auditable, not implied):

1. **Page hierarchy completeness lane**
   - verifies all 5 canonical pages are present and hierarchy-lawful (Overview/Home, Main Groups, Sub-Groups, Symbol Overview, Symbol Aspect Detail)
2. **Control placement stability + anti-drift lane**
   - verifies zone-order stability, no zone-role swaps, and anti-drift law compliance across page transitions
3. **Symbol action button placement/visibility lane**
   - verifies symbol action buttons are symbol-page-only, visibility/enable conditions are contract-compliant, and forbidden pages remain button-free
4. **Tactical field scope/cadence/persistence-boundary lane**
   - verifies tactical fields remain selected-symbol scoped, cadence-bounded, and cannot cross persistence/structural ownership boundaries
5. **Render invalidation + transition-budget lane**
   - verifies retained-object invalidation discipline, bounded redraw windows, and lock/freeze transition budgets remain truth-safe
6. **Broker-dynamic page behavior lane**
   - verifies broker-profile-aware density/paging behavior stays presentation-only and does not alter hierarchy admissibility or ownership posture

A Stage 9 claim is incomplete if any checklist lane is missing, untracked, or only described narratively without test evidence.

### Why this order matters
Source typing comes first.
Structural hydration makes the HUD honest.
Render discipline keeps it stable.
Tactical overlays make it operationally useful.
Transition/focus refine the experience without rewriting the architecture.

---

## Stage 9 quality gates

Stage 9 is complete only when all of the following are true:

### Gate 1 — Structural HUD surfaces are real
The HUD can consume landed structural truth without recomputing it ad hoc.

### Gate 2 — Tactical overlay is bounded
Selected-symbol tactical fields exist without widening structural rights.

### Gate 3 — Source separation is inspectable
The system can tell whether visible fields are structural, tactical, stale, or continuity-backed.

### Gate 4 — Stale/degraded honesty is real
The HUD visibly preserves structural weakness rather than hiding it behind movement.

### Gate 5 — Focus remains narrow and reversible
UI selection changes do not leave hidden special runtime behavior behind.

### Gate 6 — Transition behavior stays bounded and truth-safe
Freeze/lock behavior improves clarity without becoming a starvation or deception engine.

### Gate 7 — HUD remains downstream of architecture
The HUD has not become a hidden scheduler or second truth engine.

---

## Evidence required for Stage 9 completion

Stage 9 completion should be evidenced by:
- real HUD modules in the MT5 surface
- real structural hydration from landed truth
- explicit source-aware HUD typing/posture
- bounded tactical selected-symbol overlays
- explicit stale/degraded/continuity-backed visual posture
- office tracking showing Stage 9 completion honestly
- later acceptance/hardening work being able to test operator surfaces against real source contracts

A live-looking screen is not enough.
The evidence must show lawful trustworthy operator surfaces.

---

## What Stage 9 makes newly admissible

Once Stage 9 is complete, the following become admissible:
- Stage 10 hardening and acceptance against real operator-visible behavior
- fuller end-to-end validation that ASC is architecturally truthful in presentation as well as in runtime/persistence
- later richer human-readable compositions that can now align with proven source contracts

What does **not** become automatically admissible:
- letting the HUD grow new truth ownership because the surfaces now exist
- letting tactical overlays expand beyond their allowed scope
- treating visual smoothness as proof that runtime law no longer matters

---

## Common failure patterns Stage 9 must prevent

### Pattern 1 — HUD scheduler leak
Pages and focus states begin to control runtime service indirectly.

Result:
- page-dependent performance
- hidden priority inversions
- structural starvation

### Pattern 2 — Second-engine drift
The HUD re-derives or recomputes truth because it feels convenient during page hydration.

Result:
- duplicated logic
- source ambiguity
- harder debugging

### Pattern 3 — Tactical masking
Fast-moving tactical overlays make stale structural truth appear fresh enough.

Result:
- operator misreads the system
- stale structural posture hides behind motion

### Pattern 4 — Transition deception
Freeze/lock behavior creates visual smoothness at the cost of truthfulness.

Result:
- stale or delayed state is hidden
- operator trust weakens

### Pattern 5 — Source blur
The interface can no longer say what class of truth a visible field belongs to.

Result:
- recovery and debugging get harder
- trust posture collapses

---

## Stage 9 invalid completions

Stage 9 is **not** complete if any of the following are true:
- structural pages still depend on ad hoc recompute instead of landed truth
- tactical overlays widen packet/deep/runtime scope beyond explicit rights
- source posture is still ambiguous in the UI
- stale/degraded structure can be visually mistaken for fresh truth too easily
- focus state still behaves like scheduler authority
- transition smoothing hides too much truth or blocks updates too long
- the HUD has effectively become a second engine

---

## Relationship to later stages

Stage 9 does not yet complete the full hardening/acceptance program.
It delivers the lawful operator-visible layer that hardening and acceptance will test.

That means later stages should rely on Stage 9 for:
- source-truthful structural HUD surfaces
- bounded tactical overlays
- visible stale/degraded/continuity posture
- proof that the UI can stay downstream of architecture

If later stages still have to guess whether the operator surface is sourcing truth lawfully, Stage 9 was incomplete.

---

## Final standard

Stage 9 is correct when ASC can truthfully answer the next operator-facing question:

> how should the operator see scanner truth clearly, calmly, and honestly without the interface becoming a second engine?

That means Stage 9 must leave ASC with:
- real structural HUD surfaces backed by landed truth
- bounded tactical selected-symbol overlays
- source-aware visible truth classes
- honest stale/degraded/continuity signaling
- bounded transition behavior
- no hidden scheduler drift and no second-engine ownership creep

The standard is not that the screen looks alive.
The standard is that the screen is now a lawful consumer of scanner truth rather than an alternative authority.
