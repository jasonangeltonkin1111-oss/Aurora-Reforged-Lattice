# ASC Work Class Model

## Purpose

This document defines the canonical work classes of Aurora Sentinel Scanner (ASC).

Its job is to make one principle unambiguous:

> ASC performance is governed more by work-class separation than by symbol-count reduction.

The historical failure pattern was not primarily that ASC touched too many symbols.
The deeper failure was that the runtime repeatedly mixed unlike work into the same pulse:
- broad market scanning
- packet construction
- filtering and shortlist recomputation
- persistence landing
- HUD rendering
- exploratory refresh behavior

That mixture created timer obesity, queue pressure, weak cadence identity, false backlog, delayed truth landing, HUD lag, and restart-loop behavior.

The rebuild therefore treats work classes as a first-class architectural law.

---

## Core doctrine

### Work class law
Every meaningful unit of runtime activity belongs to one canonical work class.

A work class defines:
- what kind of work is being performed
- what data ownership it depends on
- what cadence posture it is allowed to use
- what interference cost it creates
- what other classes it may or may not accompany
- what must happen before and after it

A work class is not a loose category.
It is a scheduling, ownership, and interference boundary.

### Separation law
ASC must preserve clear separation between unlike work classes.

The runtime must not pretend that all due work is morally equivalent.
A cheap read pulse, a shortlist rebuild, an atomic write landing, and a HUD paint are not the same kind of event and must not be admitted as if they are.

### Performance correction law
ASC does **not** optimize primarily by touching fewer symbols.
That is the wrong doctrine.

ASC optimizes by:
- keeping cheap broad work cheap
- keeping expensive narrow work selective
- preventing multiple expensive classes from colliding in the same heartbeat
- allowing large cheap batches where the work class justifies it
- landing truth atomically rather than smearing partial state across the runtime

### One-major-class-per-heartbeat law
Each heartbeat has one dominant major work class.

Minor companion work is permitted only when all of the following are true:
- it belongs to an explicitly allowed companion class
- it does not alter the dominant class identity of the pulse
- it fits within the heartbeat budget without stretching the pulse into obesity
- it does not trigger new downstream work opportunistically

If these conditions are not met, the companion work must wait.

---

## Canonical work classes

ASC recognizes seven canonical work classes:

1. Scan
2. Snapshot / Read
3. Calculation / Gate
4. Promotion / Selection
5. Deep Analysis
6. Persistence / Write
7. HUD / Render

These are architectural classes.
The implementation may use narrower internal subtypes, but all subtypes must map cleanly back to one of these canonical classes.

---

## Class 1 — Scan

### Purpose
Scan work acquires cheap broad market-state coverage across the universe or across a clearly defined large subset.

### Typical examples
- Layer 1 full-universe market-state passes
- scheduled market-open confirmation checks
- broad symbol availability refresh
- cheap open/closed/uncertain/unknown refresh routing

### Owns
- broad acquisition of market-state evidence
- cheap pass coverage expansion
- first-pass classification readiness
- scan-side freshness movement
- broad queue feed for later owned work

### Does not own
- packet enrichment
- candidate filtering
- shortlist policy
- deep analysis
- broad write landing
- HUD object rebuilds

### Cost posture
Scan is designed to be cheap per symbol and safe to batch broadly.

This means:
- large broker universes are allowed to be scanned in large cheap batches
- a broker with fewer symbols than the scan batch target may process the full set
- timid artificially tiny broad-scan batches are not a performance virtue

### Canonical examples of valid scan posture
- 200-symbol cheap Layer 1 pass on a large broker
- full-set pass on a smaller broker when the class remains cheap
- confirmation scan lane after a market-state transition window

### Invalid scan posture
- broad scan lane that silently performs shortlist recomputation
- broad scan lane that composes dossiers while scanning
- broad scan lane that tries to land heavy persistence for every touched symbol in the same beat

---

## Class 2 — Snapshot / Read

### Purpose
Snapshot / Read work builds or refreshes bounded current-state packets from already admitted symbols or artifacts.

### Typical examples
- Layer 2 open-symbol packet build
- focused-symbol direct read refresh
- persisted artifact hydration for a specific surface
- bounded read-side recovery loads

### Owns
- current packet capture for admitted symbols
- field refresh of owned packet truth
- focused-symbol tactical reads where explicitly authorized
- controlled read-side hydration from landed artifacts

### Does not own
- broad universe discovery
- shortlist competition
- deep analytical expansion beyond the admitted packet scope
- broad dossier compose

### Cost posture
Snapshot / Read is narrower than scan and more expensive per unit than raw broad state acquisition.
It therefore benefits from subset control.

### Valid posture
- Layer 2 refresh over the current open subset
- focused-symbol bid/ask direct read for tactical HUD display
- hydration of a single committed artifact family for presentation

### Invalid posture
- reading every open symbol at focus-page speed just because one symbol is selected
- turning a packet refresh into a hidden filter pass
- reading persisted truth and recomputing ranking inside the same lane

---

## Class 3 — Calculation / Gate

### Purpose
Calculation / Gate work consumes upstream truth and determines cheap eligibility, readiness, or classification outcomes.

### Typical examples
- Layer 3 cheap filter evaluation
- candidate gate result updates
- bucket assignment for surviving candidates
- bounded reason-code recomputation after dirty upstream change

### Owns
- cheap rule evaluation
- gate result publication rights for its own outputs
- reason code generation
- bucket assignment where architecture assigns that role
- dirty-to-clean transition for cheap eligibility state

### Does not own
- market-state acquisition
- broad packet building
- shortlist competition logic
- deep history pulls
- write-policy invention

### Cost posture
Calculation / Gate is usually lighter than deep analysis but heavier than cheap broad scanning.
It should consume already available truth and avoid pulling new expensive inputs opportunistically.

### Valid posture
- recalc candidate eligibility because Layer 2 packet changed materially
- recompute bucket assignment because cheap input state changed

### Invalid posture
- calculation lane that starts history pulls to rescue missing inputs
- filter lane that quietly starts ranking or scoring like Layer 4
- gate lane that widens into dossier composition

---

## Class 4 — Promotion / Selection

### Purpose
Promotion / Selection work decides which already-qualified candidates are promoted into a bounded shortlist or operator-visible selected set.

### Typical examples
- Layer 4 top-per-bucket rebuild
- spill/fill resolution
- material-shift-driven shortlist refresh
- anti-churn hold evaluation

### Owns
- shortlist authority
- promotion ordering and entry/exit decisions
- bucket competition logic
- stability rules such as hold windows and anti-churn behavior
- selected-set state transitions

### Does not own
- broad state acquisition
- cheap packet refresh loops
- deep analysis itself
- dossier authoring

### Cost posture
Promotion / Selection is logically heavy even when its raw computational cost is moderate.
It changes downstream attention, downstream cadence, and downstream artifact priority.
Because of that, it must be treated as a major class and kept calm.

### Valid posture
- rebuild because shortlist is invalid
- rebuild because material candidate change exceeded defined thresholds
- hold-aware review when a real selection event is due

### Invalid posture
- rebuild because hold window expired even though nothing materially changed
- rebuild because a HUD page is opened
- rebuild every pulse merely because fresh Layer 3 truth exists

---

## Class 5 — Deep Analysis

### Purpose
Deep Analysis maintains high-detail rolling truth for the already promoted set only.

### Typical examples
- Layer 5 promoted-set refresh waves
- rank-sensitive deep packet refresh
- timeframe packet maintenance for promoted symbols
- deep freshness repair for admitted promoted members

### Owns
- high-cost selective enrichment
- deep packet freshness for the promoted set
- deeper timeframe refresh cadence inside the admitted deep scope
- rank-sensitive service policy

### Does not own
- universe-wide scanning
- basic eligibility determination
- shortlist authority
- broad persistence policy

### Cost posture
Deep Analysis is expensive and narrow.
It must remain bounded by the selected set.
It is never a license to widen back into the universe.

### Valid posture
- deep refresh for currently promoted symbols only
- rank-sensitive service wave under governor admission

### Invalid posture
- expanding deep analysis to every open symbol because resources look available
- deep lane triggered by focus visibility alone
- deep lane combined with broad write wave in the same dominant pulse

---

## Class 6 — Persistence / Write

### Purpose
Persistence / Write lands truth safely and atomically into the artifact system.

### Typical examples
- atomic temp-to-final symbol artifact publish
- last-good preservation update
- write queue landing for ready committed blocks
- write-audit and commit lineage landing

### Owns
- atomic landing discipline
- temp-write then promote behavior
- last-good continuity where required
- landed/degraded/pending visibility for artifacts
- artifact family integrity

### Does not own
- upstream truth invention
- shortlist policy
- HUD rendering logic
- broad market reads

### Cost posture
Writes are often smaller in raw CPU cost than analysis, but they carry high interference value.
They change what downstream consumers can trust.
Because of that, Persistence / Write is a protected work class.

### Valid posture
- brief atomic landing pause after a committed layer output is ready
- write lane servicing bounded ready artifacts
- calm selective persistence for promoted or state-transition-relevant outputs

### Invalid posture
- using write lanes as a dumping ground for half-ready truth
- broad same-speed write waves for every cheap read change
- hiding persistence backlog behind optimistic HUD wording

---

## Class 7 — HUD / Render

### Purpose
HUD / Render presents already prepared truth or explicitly authorized tactical direct reads to the operator.

### Typical examples
- always-on overview repaint from committed truth
- focused-symbol tactical plane refresh
- HUD page transition hydration
- object property diffs for retained HUD elements

### Owns
- visual presentation
- page-level composition from approved sources
- direct tactical display where architecture explicitly allows it
- render discipline and object update policy

### Does not own
- lower-layer recomputation rights
- shortlist rebuild authority
- deep analysis authority
- persistence promotion rights

### Cost posture
HUD / Render is deceptively dangerous.
Even when visual work seems small, repeated render-side opportunism can drag packet reads, calculations, and writes into the same pulse.
HUD must therefore remain a consumer surface, not an authorizing engine.

### Valid posture
- repaint from committed structural truth
- show direct focused-symbol bid/ask under tactical HUD rules
- freeze briefly during transition while a dedicated hydration path settles

### Invalid posture
- clicking a page causes broad filter recomputation
- focused page visibility triggers deep history pulls
- HUD redraw widens into persistence work without a separate admitted write class

---

## Dominant class and companion class rules

### Dominant class rule
Every heartbeat must declare one dominant class.
That dominant class determines:
- the pulse identity
- budget posture
- allowed companions
- first-yield conditions
- what cannot be smuggled into the beat

### Allowed companion principle
A companion class may share the heartbeat only if it is:
- materially smaller than the dominant class
- bounded in advance
- incapable of recursively triggering further work
- explicitly allowed by class policy

### Companion examples that may be valid
- Scan dominant + tiny control bookkeeping
- Snapshot / Read dominant + bounded telemetry update
- Persistence / Write dominant + tiny landing audit marker
- HUD / Render dominant + tiny approved tactical direct read

### Companion examples that are invalid
- Scan dominant + shortlist rebuild + dossier compose
- HUD dominant + packet refresh + gate recompute + write landing
- Deep Analysis dominant + broad scan maintenance + full artifact flush

---

## Allowed and forbidden mixing matrix

### Generally allowed pairings when bounded
- Scan + tiny control bookkeeping
- Snapshot / Read + tiny control bookkeeping
- Calculation / Gate + tiny telemetry bookkeeping
- Persistence / Write + tiny audit bookkeeping
- HUD / Render + explicitly authorized tactical direct read

### Generally forbidden pairings as dominant combinations
- Scan + Promotion / Selection
- Scan + Persistence / Write wave
- Snapshot / Read + Promotion / Selection unless the promotion input is already independently ready and the pairing is explicitly staged
- HUD / Render + Calculation / Gate
- HUD / Render + Promotion / Selection
- HUD / Render + Deep Analysis
- Promotion / Selection + Deep Analysis in one dominant beat
- Deep Analysis + broad Persistence / Write wave

### Why this matrix exists
These combinations are forbidden not because they are impossible, but because they erase cadence identity and create restart-prone ambiguity.

---

## Class ownership by layer

### Layer 1 — Market State
Primary class:
- Scan

Secondary bounded class:
- Snapshot / Read only where needed for minimal confirmation evidence

Forbidden layer drift:
- Layer 1 must not become a hidden filter or shortlist engine

### Layer 2 — Open Symbol Snapshot
Primary class:
- Snapshot / Read

Secondary bounded class:
- Persistence / Write only through separate landed publication rights after packet readiness

Forbidden layer drift:
- Layer 2 must not rank, shortlist, or widen into deep-analysis behavior

### Layer 3 — Candidate Filtering
Primary class:
- Calculation / Gate

Secondary bounded class:
- Persistence / Write only for its own result publication after evaluation is complete

Forbidden layer drift:
- Layer 3 must not perform deep history pulls or promotion decisions

### Layer 4 — Shortlist Selection
Primary class:
- Promotion / Selection

Secondary bounded class:
- Persistence / Write only for selected-set publication after the selection event completes

Forbidden layer drift:
- Layer 4 must not start acting like a broad refresh loop

### Layer 5 — Deep Selective Analysis
Primary class:
- Deep Analysis

Secondary bounded class:
- Persistence / Write only for deep artifact landing after an admitted deep refresh wave

Forbidden layer drift:
- Layer 5 must never widen back into universe-scale scanning or act as selection authority

### HUD
Primary class:
- HUD / Render

Secondary bounded class:
- Snapshot / Read only for explicitly permitted tactical direct reads

Forbidden drift:
- HUD may not grant itself rights to Calculation / Gate, Promotion / Selection, or Deep Analysis merely because a page is visible

---

## Throughput budget versus cost budget

### Throughput budget
Throughput budget answers:
- how many units of this class may be processed in the pulse or wave
- how wide the class may sweep
- how many symbols or artifacts may be touched

Throughput budget is class-sensitive.
A cheap broad scan may legitimately process many symbols.
A deep analysis wave may legitimately process very few.

### Cost budget
Cost budget answers:
- how much time and interference the admitted class is allowed to consume
- when the class must yield
- what companion work is still safe
- when the governor must downgrade or defer the class

### Doctrine
ASC must never pretend that one universal symbol-count budget is enough.
A budget that works for broad market-state scanning is not an honest budget for deep analysis or atomic writes.

Class-aware budgeting is mandatory.

---

## Dirty routing law

Dirty routing exists so ASC can route work to the correct class without collapsing everything into “do all due work now.”

A dirty event must specify:
- what changed
- which class owns the next required action
- which downstream classes are now eligible later
- what is explicitly **not** authorized yet

### Example
A Layer 2 packet change may dirty:
- Layer 3 Calculation / Gate

It does **not** automatically authorize:
- immediate Layer 4 shortlist rebuild
- immediate Layer 5 deep refresh
- immediate broad dossier rewrite

Those later classes must still earn admission under their own rules.

---

## Starvation and fairness by class

### Starvation law
ASC must detect starvation by class, not just by total backlog size.

A system may look busy while still starving a protected class.
For example:
- scan service appears healthy
- HUD remains active
- but committed write landings are repeatedly deferred

That is a class-specific failure even if aggregate activity looks high.

### Fairness law
Fairness does not mean equal pulse count for all classes.
Fairness means:
- each class gets the service frequency its role requires
- protected classes do not get drowned by noisier classes
- expensive classes do not permanently dominate cheap continuity classes

### Protected classes
The governor must usually protect at least these classes from chronic starvation:
- Persistence / Write
- Scan during warmup and market-state recovery
- Snapshot / Read for focused tactical truth when explicitly prioritized

---

## Failure patterns this file is designed to prevent

### Pattern 1 — Blended pulse illusion
Everything due gets admitted together under the excuse that each piece is individually small.

Result:
- pulse obesity
- timing drift
- hidden backlog
- unstable cadence identity

### Pattern 2 — Symbol-count superstition
The runtime touches too few symbols and mistakes caution for performance.

Result:
- slow Layer 1 readiness
- stale market-state truth
- fake stability built on starvation

### Pattern 3 — HUD authority creep
HUD visibility begins authorizing upstream packet, filter, shortlist, or deep work.

Result:
- operator navigation becomes a hidden scheduler
- performance becomes page-dependent and erratic

### Pattern 4 — Persistence as residue
Writes are treated as leftovers to do whenever time happens to remain.

Result:
- truth exists in memory but not in trustable landed artifacts
- stale last-good continuity
- ambiguous operator surfaces

### Pattern 5 — Selection churn masquerading as freshness
Promotion / Selection is run too often merely because upstream truth moved.

Result:
- unstable shortlist
- unnecessary downstream deep refresh churn
- broken operator trust

---

## Implementation obligations

Any future MT5 implementation of ASC must:
- tag or map each runnable unit to one canonical work class
- expose dominant class identity per heartbeat in telemetry
- keep class-aware budgets explicit
- preserve class boundaries under pressure
- refuse silent class widening inside helper functions or convenience paths
- surface when a class is pending, deferred, degraded, or starved

If an implementation cannot clearly state what class a unit belongs to, that unit is not yet ready to exist.

---

## Final standard

ASC must become a system where the runtime rhythm remains intelligible.

That requires work classes that are:
- explicit
- bounded
- non-overlapping
- class-aware in budget policy
- hard to mix accidentally

The standard is not merely “the system runs.”
The standard is that the system remains clear enough that runtime pressure does not dissolve architectural boundaries.
