# ASC Execution Backlog

## Purpose

This document defines the canonical execution-backlog model for Aurora Sentinel Scanner (ASC).

Its job is to turn the roadmap into an operational work queue without letting the rebuild decay into:
- idea sprawl
- premature feature jumping
- patch-loop improvisation
- hidden blocked work pretending to be active progress

The backlog is not the architecture.
It is not the roadmap.
It is the controlled execution surface that answers:

> what work is lawful to do now, what is not yet admissible, and why?

This file exists so day-to-day implementation stays subordinate to the final blueprint and roadmap instead of quietly replacing them.

---

## Core doctrine

### Backlog-is-subordinate law
The backlog is subordinate to:
1. `blueprint/final/`
2. `blueprint/roadmap/`
3. active office truth about current status

That means the backlog may:
- break roadmap stages into actionable work packages
- sequence near-term implementation tasks
- identify blockers and dependencies
- carry bounded hardening debt

It may not:
- invent new architecture silently
- bypass stage gates because an item feels small
- turn blocked future work into active work by relabeling it

### Admissibility law
A backlog item is valid only if it is admissible under the current roadmap stage and dependency reality, using canonical definitions from `02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`.

File-local delta: items that are merely useful, easy, UI-attractive, archive-derived, or short-term friction reducers are still non-admissible when gates are unmet.

### Pre-implementation freeze admissibility gate
Before any MT5 rebuild implementation item can be marked `active`, the Stage 0A freeze gate and Stage 0B final integration checkpoint must be passed.

The backlog must carry explicit freeze/integration evidence links aligned to Stage 0A and Stage 0B gate criteria (see `02A_STAGE_0A_PRE_IMPLEMENTATION_FREEZE.md` and `02B_STAGE_0B_FINAL_INTEGRATION_ACCEPTANCE.md`).

Any implementation item opened before these gates pass must be classed as `non-admissible / rejected`.


### Backlog-is-not-an-idea-dump law
The backlog must remain a disciplined execution queue, not a graveyard of every thought the project has ever had.

If the backlog becomes too broad, two failures follow:
- real stage work loses priority clarity
- non-admissible work starts appearing “almost active”

### Blocked must mean blocked
If a task depends on unfinished upstream stage work, it must remain explicitly blocked.
It must not be allowed to masquerade as “in progress soon.”

### No runtime-substitute backlog law
Backlog items that manufacture static Board/Current Focus/Dossier files as stage evidence must be classed `rejected`.
Contracts and path doctrine are admissible in blueprint/roadmap work; operator artifact content is runtime-owned and cannot be simulated as completion proof.

### Fewer active items, stronger progress law
ASC should prefer a smaller number of coherent active items over a large number of shallow concurrent items.
This reduces drift, context scattering, and hidden dependency violations.

---

## What the execution backlog is for

The execution backlog exists to:
- translate roadmap stages into bounded work packages
- keep current implementation priorities explicit
- show which items are blocked and why
- distinguish active work from future work cleanly
- make office tracking more honest and easier to maintain
- reduce the temptation to solve architecture through opportunistic local patches

The backlog should make it easier to do the right next thing than the exciting wrong thing.

---

## What the execution backlog is not for

The backlog is **not** for:
- storing every speculative idea
- preserving archive nostalgia tasks that have not re-earned relevance
- tracking architecture law better stored in `blueprint/final/`
- replacing stage descriptions in `blueprint/roadmap/`
- hiding blocking weaknesses behind “future enhancement” labels

If a task belongs in the blueprint, office, or risk file instead, it should live there instead.

---

## Relationship to other files

### Relationship to `blueprint/final/`
`blueprint/final/` defines what ASC is allowed to become.
The backlog may only propose work that remains lawful under that design.

### Relationship to `blueprint/roadmap/`
The roadmap defines stage order, gates, and dependency law.
The backlog should decompose those stages into concrete actionable items.

### Relationship to `office/`
`office/` records the live operational truth:
- what stage is active
- what decisions were made
- what changed
- what remains blocked

The backlog should align with office status rather than compete with it.

If backlog reality and office reality diverge, execution clarity collapses quickly.

---

## Canonical backlog classes

The execution backlog should separate items into explicit classes.

### Class 1 — Active stage work
These are items that:
- belong to the current roadmap stage
- are admissible now
- have satisfied upstream dependencies
- should be actively worked

### Class 2 — Next-ready work
These are items that:
- are not active yet
- become admissible immediately after current active stage items land
- do not require architecture reinterpretation to start

### Class 3 — Blocked work
These are items that:
- are meaningful and expected
- cannot lawfully begin yet
- are blocked by missing stage completion, dependency, or evidence

Blocked work must carry an explicit blocker reason.

### Class 4 — Hardening debt
These are items that:
- do not redefine architecture
- improve robustness, inspection, or acceptance posture
- may remain pending until their stage becomes active or until acceptance hardening begins

### Class 5 — Future-scope work
These are items that may be useful later but are not admissible under the current roadmap horizon.
They must remain clearly separated from active or next-ready work.

### Class 6 — Non-admissible / rejected work
These are items that:
- violate the final blueprint
- recreate invalid designs
- depend on disallowed scope widening
- should not be allowed back into the queue without explicit architecture change

This class matters because rejection memory is important.

---

## Backlog item schema

Every meaningful backlog item should carry enough structure that execution does not become interpretive.

At minimum, each item should define:
- `id`
- `title`
- `class`
- `current_stage`
- `owner_domain`
- `objective`
- `why_now`
- `dependencies`
- `blockers`
- `definition_of_done`
- `evidence_required`
- `forbidden_widening`
- `status`

Optional but useful fields may include:
- `risk_link`
- `test_matrix_link`
- `office_reference`
- `acceptance_relevance`

The point is not bureaucracy.
The point is making the item specific enough that execution stays lawful.

---

## Status vocabulary

The backlog should use a bounded status vocabulary.

### `active`
Currently being worked and admissible now.

### `next_ready`
Not yet active, but admissible as soon as the current active item or slice completes.

### `blocked`
Meaningful item, but not admissible yet because a dependency, stage gate, or evidence requirement is unmet.

### `deferred`
Admissible in principle, but intentionally postponed for a more important lawful item.

### `hardening_pending`
Not a stage-sequencing blocker right now, but must be resolved during hardening or acceptance.

### `rejected`
Known invalid item that should not be reintroduced without explicit blueprint change.

### `done`
Completed with required evidence satisfied.

These statuses should not be reinterpreted casually.

---

## Prioritization doctrine

### Stage priority outranks feature attractiveness
The current roadmap stage determines the highest lawful work priority.
Not all useful work is equally admissible.

### Blocker removal outranks cosmetic enrichment
If one blocked structural item is preventing clean downstream progress, it often outranks multiple cosmetic or convenience improvements.

### Structural truth outranks consumer polish
Work that strengthens:
- runtime law
- layer ownership
- artifact trust
- restore honesty

should usually outrank:
- richer page polish
- more reports
- extra convenience behaviors

### Hardening debt becomes priority when its stage arrives
Hardening debt should not be allowed to pollute earlier-stage focus, but it also must not be forgotten once hardening/acceptance becomes active.

---

## WIP discipline

### Active work should stay narrow
ASC should prefer a very small set of simultaneously active items.
Too many active items increase the chance of:
- cross-domain leakage
- stage skipping
- half-done slices in many places
- fatigue-driven local hacks

### One coherent slice beats many scattered slices
The backlog should encourage finishing one lawful slice strongly rather than touching five slices weakly.

### WIP must remain stage-aligned
If current active items span too many roadmap stages without explicit reason, the backlog is probably becoming unlawful.

---

## Blocker doctrine

### Blockers must be named explicitly
A blocked item should say exactly why it is blocked.
Examples:
- upstream stage not complete
- missing shared type/state contract
- acceptance evidence absent
- artifact family trust not yet real
- current stage does not admit this work yet

### Blocked items must not be disguised
Avoid vague labels like:
- “later maybe”
- “waiting a bit”
- “not urgent”

Those hide dependency truth.

### Blockers can be healthy
A visible blocker is not a project failure.
It is a sign that the backlog is preserving stage law honestly.

---

## Definition-of-done doctrine

### Done must be evidence-based
A backlog item is done only when its declared evidence exists.
This should usually include some combination of:
- structural completion
- lawful runtime behavior
- artifact evidence
- test matrix coverage
- office/status updates where applicable

### Done is not “code written”
Items must not be closed merely because:
- code exists
- the screen changed
- a file landed
- it seems directionally improved

### Done must preserve boundaries
If an item “works” only because it widened into neighboring ownership, it is not done.
It is drift.

---

## Forbidden-widening doctrine

Every major backlog item should explicitly state what it is **not** allowed to widen into.

Examples:
- a Layer 2 item must not widen into filtering
- a HUD item must not widen into runtime scheduling
- a persistence item must not widen into truth invention
- a shortlist item must not widen into deep-analysis service

This matters because scope creep often appears first as “just one more useful thing while we’re here.”

---

## Backlog slices by stage

The backlog should generally mirror the roadmap in the following way.

### Stage 0 backlog slices
Examples:
- establish active repo root domains
- create final blueprint canon
- create roadmap canon
- declare archive demotion

### Stage 0B backlog slices
Examples:
- run final integration acceptance checkpoint
- fail/clear hard gates for runtime-heartbeat-memory-write coherence
- fail/clear hard gates for artifact-page-menu coherence
- verify present-vs-future scope consistency
- verify bridge-law consistency
- verify office/front-door and repo-reality alignment

### Stage 1 backlog slices
Examples:
- centralize posture enums
- declare core state records
- define artifact metadata types
- define symbol registry posture

### Stage 2 backlog slices
Examples:
- create runtime-manager entry spine
- implement major-lane ownership
- implement class-aware credits
- add starvation/congestion posture
- expose heartbeat telemetry

### Stage 3 backlog slices
Examples:
- implement Layer 1 state transitions
- implement broad scan service
- implement readiness posture
- implement next-check reasons
- land Layer 1 artifacts

### Stage 4 backlog slices
Examples:
- implement Layer 2 packet state
- implement admitted subset packet refresh
- implement packet freshness/continuity
- implement focused-symbol tactical packet overlay rights
- land Layer 2 artifacts

### Stage 5 backlog slices
Examples:
- implement Layer 3 gate state
- implement reason codes
- implement bucket assignment
- implement filter freshness posture
- land Layer 3 artifacts

### Stage 6 backlog slices
Examples:
- implement shortlist state transitions
- implement hold/material-shift posture
- enforce hold-expiry non-trigger rule
- land Layer 4 artifacts

### Stage 7 backlog slices
Examples:
- implement promoted-only deep state
- implement rank-sensitive cadence
- implement deep freshness/continuity
- land Layer 5 artifacts

### Stage 8 backlog slices
Examples:
- implement artifact family builders
- implement atomic landing
- implement last-good posture
- implement restore trust posture
- validate layer-owned publication paths

### Stage 9 backlog slices
Examples:
- implement source-aware structural pages
- implement board/dossier/current-focus contract hydration
- enforce board/dossier/current-focus write-discipline
- implement bounded tactical overlays
- implement stale/degraded visual posture
- implement focus release and transition lock behavior

### Stage 10 backlog slices
Examples:
- run end-to-end acceptance scenarios
- validate wide-universe behavior
- validate restart humility
- resolve blocking hardening debt
- record acceptance posture in office

---

## Hardening-debt doctrine

### Hardening debt should be explicit, not floating
Some items do not block a stage immediately but will matter for Stage 10 acceptance.
These must be tracked as hardening debt rather than left to memory.

### Hardening debt is not a license to defer architecture fixes
If an item weakens core ownership or trust boundaries now, it is not hardening debt.
It is a current blocker.

### Examples of valid hardening debt
- more exhaustive wide-universe scenario coverage
- richer telemetry inspection helpers
- additional non-blocking acceptance scenarios
- bounded polish that does not alter architecture

---

## Future-scope doctrine

### Future scope should exist, but stay quarantined
Some useful ambitions may exist beyond the current rebuild horizon.
These should be tracked only if they are:
- clearly outside the current stage horizon
- not likely to confuse active priorities
- not being used to pressure premature widening now

### Future scope must not contaminate active backlog
Future items should never appear more urgent than lawful current-stage work just because they are exciting.

---

## Rejected-work doctrine

### Rejected items should be remembered
The backlog should preserve a rejected/non-admissible section for work such as:
- HUD-driven scheduler behavior
- Layer 5 universe-wide deep service
- dossier-first truth transport
- MT5 rebuild coding before Stage 0A/0B gate completion
- hold-expiry-triggered shortlist rebuilds
- generic universal budget replacing class-aware credits

### Why this matters
Projects forget why bad ideas were rejected and then reinvent them months later.
A rejection memory surface reduces that risk.

---

## Relationship to the test matrix and risk file

A backlog item should be able to point to:
- the relevant test-matrix group(s) that will validate it
- the relevant risk/failure mode(s) it reduces or must avoid creating

This keeps implementation tied to:
- proof
- failure awareness
- acceptance reality

If the backlog is disconnected from risk and validation, it becomes execution theater.

---

## Relationship to office files

The backlog should work together with office files as follows:

### `office/ROADMAP_STATUS.md`
Reflects which stage is active and what backlog class currently dominates.

### `office/WORK_LOG.md`
Records what backlog item(s) were actually worked and what evidence was produced.

### `office/CHANGE_LEDGER.md`
Records meaningful changes resulting from backlog execution.

### `office/DECISIONS.md`
Records any explicit decision that changes backlog admissibility or priority because of a blueprint/roadmap-level call.

If these fall out of sync, the backlog becomes less trustworthy quickly.

---

## Common backlog failure patterns

### Pattern 1 — Idea swamp
The backlog becomes a mixed list of:
- current work
- future wishes
- rejected ideas
- unresolved architecture
- random reminders

Result:
- no one can tell what is actually lawful to do next

### Pattern 2 — Blocked work pretending to be active
Tasks that depend on incomplete upstream stages appear in the active queue anyway.

Result:
- patch-loop pressure rises
- hidden dependency violations spread

### Pattern 3 — Cosmetic work outranking structural work
The backlog promotes visible polish ahead of blocking structural work because the visible payoff feels better.

Result:
- truth weakens while appearance improves

### Pattern 4 — Too many active slices
Many concurrent items scatter execution across stages and domains.

Result:
- nothing becomes truly complete
- ownership blurs

### Pattern 5 — Done without evidence
Tasks are closed because code landed, not because the item’s definition of done was satisfied.

Result:
- office progress becomes inflated
- hardening debt gets hidden

### Pattern 6 — Rejected ideas forgotten
Known invalid ideas return because the backlog failed to preserve why they were rejected.

Result:
- old failure patterns re-enter the rebuild through convenience

---



## Menu/settings contract implementation sequencing tasks

The following canonical backlog sequence is required to implement the EA menu/settings law without drift:

1. **S1-MENU-BASELINE (Stage 1, active/next-ready by stage status)**
   - establish canonical section schema for all operator-safe menu sections
   - attach safety class + runtime owner + artifact owner mapping fields
   - wire anti-drift precedence declaration into settings schema

2. **S7-DEEP-CONTROLS-WIRING (Stage 7, blocked until Stage 7 active)**
   - wire timeframe toggles, bars-per-timeframe, indicator toggles/values, tick window length, spread rollover length to Layer 5 runtime state
   - enforce safe/dangerous transitions and declared precedence clamps
   - publish control provenance in deep artifacts

3. **S8-ARTIFACT-KNOBS-WIRING (Stage 8, blocked until Stage 8 active)**
   - wire board/dossier/current-focus refresh posture, inclusion toggles, and verbosity boundaries to persistence/publication flow
   - enforce optional-vs-mandatory section boundaries
   - emit section-level publication state metadata for knob outcomes

4. **S8-ANTI-DRIFT-VALIDATION (Stage 8 hardening debt or active)**
   - add drift checks proving no hidden constants bypass active operator settings
   - add declared-precedence override evidence in diagnostics/log artifacts

5. **S10-ACCEPTANCE-EVIDENCE (Stage 10 acceptance)**
   - acceptance scenarios covering safe vs dangerous controls
   - acceptance scenarios covering board/dossier/current-focus publication knob behavior
   - acceptance scenarios proving anti-drift precedence compliance

These items must carry blockers and evidence links explicitly; no item may be promoted to `active` before stage admissibility is satisfied.

## Backlog maintenance doctrine

The execution backlog should be updated when:
- a stage becomes active or completes
- a blocker is resolved or newly discovered
- an item moves from future-scope to next-ready lawfully
- a hardening-debt item becomes acceptance-relevant
- an item is rejected explicitly based on blueprint/risk/acceptance truth

However, maintenance must remain deliberate.
The backlog must not become a live stream of every passing thought.

---

## Minimum required backlog quality before acceptance

Before Stage 10 can honestly close, the execution backlog should show at least:
- no major active items that contradict completed-stage claims
- all known blocking hardening items either resolved or explicitly blocking acceptance
- rejected invalid patterns preserved in memory
- next future work clearly separated from accepted baseline work

Anything less means execution clarity remains too weak to trust the accepted baseline.

---

## Final standard

The ASC execution backlog is correct when it makes the lawful next move clearer than the exciting wrong move.

That means the backlog must be:
- subordinate to blueprint and roadmap law
- explicit about admissibility and blockers
- small and disciplined in active scope
- evidence-based in completion
- strong enough to quarantine future scope and rejected work
- aligned with office, risk, and test reality

The standard is not that tasks are listed.
The standard is that the queue itself protects the rebuild from drifting back into improvisation.
---

## Mandatory pre-EA execution queue (non-skippable)

Before any MT5 rebuild implementation item is set `active`, backlog must contain and complete these items in order:

1. `S0A-FREEZE-CLOSURE`
   - class: active stage work
   - current_stage: 0A
   - definition_of_done: Stage 0A closure evidence register rows completed with exact file references and contradictions explicit.

2. `S0B-INTEGRATION-GATES`
   - class: active stage work
   - current_stage: 0B
   - definition_of_done: Gate 1–6 pass/fail rows complete; menu/settings canonical path singularity verified in evidence.

3. `S1-FOUNDATION-OPENING-PACKET`
   - class: next_ready (becomes active only after S0A/S0B done)
   - current_stage: 1
   - definition_of_done: artifact-first foundation outputs + office synchronization evidence logged.

Any backlog ordering that opens Stage 1+ work before items 1 and 2 are `done` is non-admissible.

## Backlog anti-drift checks (required per update)

Every backlog update pass must verify and log:
- canonical owner file for each touched work item,
- reference-only files impacted,
- required co-edit files,
- explicit blocked future-scope items kept quarantined,
- proof that archive evidence was not used as present runtime completion proof.


## 2026-03-26 Stage 1 opening backlog alignment

- Active Stage 1 work must include real `mt5/` scaffold creation and compile-oriented EA entry wiring.
- Non-admissible class still includes static repo-side Board/Current Focus/Dossier proof-file generation.
- Stage 2 items remain blocked until Stage 1 opening scaffold evidence is landed and synchronized in office controls.


2026-03-29 note: Layer 4 shortlist runtime publication is active. Remaining work is hardening and validation; Layer 5 stays command-only.
