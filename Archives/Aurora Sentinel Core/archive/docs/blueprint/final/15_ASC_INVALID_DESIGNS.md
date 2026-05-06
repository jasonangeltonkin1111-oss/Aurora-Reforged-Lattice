# ASC Invalid Designs

## Purpose

This document defines the canonical kill-list of invalid designs for Aurora Sentinel Scanner (ASC).

The goal of this file is not to add new architecture.
The goal is to make explicit which design patterns are forbidden because they reliably create drift, false progress, restart pressure, hidden starvation, ownership collapse, or operator deception.

ASC should not merely describe what is preferred.
It should also state clearly what is not allowed to survive.

---

## Core doctrine

### Invalid-design law
If a pattern violates ownership, cadence integrity, persistence trust, HUD truthfulness, or architectural clarity, that pattern is invalid even if it appears to produce useful short-term output.

### Blueprint-precedence law
Code must follow blueprint.
It must never redefine blueprint by convenience, local patch pressure, or code-first reinterpretation.
If a future implementation contradicts doctrine, the implementation is wrong — not the doctrine.

### Reading-order law
Skipping lawful reading order before editing is invalid because it breaks source authority and encourages architecture drift.

### Product-vocabulary law
Violating canonical product vocabulary on operator-facing surfaces is invalid.
A technically working implementation that leaks layer numbers, stage numbers, internal variable naming, or other engineering shorthand into visible surfaces is still wrong.

### Board-and-dossier law
Violating Market Board law or Symbol Dossier law is invalid even if files are produced.
Output shape alone is not compliance.

### Local usefulness is not a defense
A design may feel convenient or temporarily effective and still be invalid.
The question is not whether it produced a momentary gain.
The question is whether it preserves a trustworthy system.

### Invalid patterns must be removed, not normalized
When an invalid design is discovered, the preferred response is:
- expose it
- isolate it
- replace it
- document the correction if needed

The preferred response is not to quietly build more policy around it until it looks intentional.

---

## Category A — Runtime invalid designs

### 1. Blended heartbeat monolith
A single heartbeat tries to do broad scan, packet refresh, shortlist rebuild, persistence landing, and HUD/render work together as if they were all just “due work.”

Why invalid:
- destroys pulse identity
- creates timer obesity
- hides starvation
- encourages opportunistic runtime creep

Required response:
- restore one-major-lane-per-heartbeat discipline
- separate work classes cleanly

---

### 2. Universal budget superstition
One generic budget is treated as sufficient to govern all work classes fairly.

Why invalid:
- cheap broad scan and heavy deep analysis do not have the same cost shape
- persistence pressure is different from render pressure
- fairness becomes fake because unlike work is modeled as equivalent

Required response:
- use class-aware work credits and mode-aware admission

---

### 3. Light pulse that secretly becomes heavy
A pulse begins as cheap work and quietly expands into heavy work because the runtime discovers more opportunities while already inside the lane.

Why invalid:
- destroys credit honesty
- hides cost spikes
- breaks admission clarity

Required response:
- force early yield and re-admission for heavy work

---

### 4. Backlog denial through visible motion
The system looks active because counters change, pages move, or logs scroll, while protected structural work is actually starving.

Why invalid:
- creates false calm
- hides real risk behind cosmetic activity

Required response:
- detect starvation by class and protected guarantee, not by vague visible activity

---

### 5. Permanent recovery mode as normal runtime
Recovery behavior becomes the standing operating model because the base runtime cannot maintain truth cleanly.

Why invalid:
- normal law is never truly restored
- runtime remains in disguised emergency posture
- architecture weakness is hidden instead of repaired

Required response:
- restore bounded recovery and fix the normal runtime instead of normalizing emergency behavior

---

## Category B — Layer invalid designs

### 6. Layer 1 timid-throughput dogma
Layer 1 broad market-state scanning is artificially shrunk into tiny weak batches and presented as performance discipline.

Why invalid:
- starves warmup
- leaves too much of the universe unknown for too long
- slows the entire scanner for the wrong reason

Required response:
- preserve large cheap Layer 1 batches when the work class remains genuinely cheap

---

### 7. Layer 1 richness creep
Layer 1 starts absorbing packet, filtering, shortlist, or deep-analysis work because it already sees the whole universe.

Why invalid:
- Layer 1 loses cheap broad identity
- downstream ownership becomes meaningless

Required response:
- prune Layer 1 back to market-state ownership and bounded confirmation only

---

### 8. Layer 2 widening into universe-scale service
Layer 2 stops behaving like an admitted open-subset expander and drifts toward broad universe refresh.

Why invalid:
- duplicates Layer 1 pressure
- destroys subset advantage
- increases contention unnecessarily

Required response:
- restore subset admission and packet-bounded service

---

### 9. Layer 3 hidden ranking
Layer 3 candidate filtering begins scoring, ordering, or otherwise acting like a disguised shortlist engine.

Why invalid:
- blurs the boundary between gate and selection
- raises cost and interpretive ambiguity

Required response:
- keep Layer 3 cheap, reason-coded, and eligibility-only

---

### 10. Layer 4 rebuild hunger
Layer 4 wakes too often and treats ordinary upstream motion as shortlist-changing importance.

Why invalid:
- churns the selected set
- destabilizes Layer 5 cadence
- erodes operator trust

Required response:
- require invalidity or material shift before rebuild

---

### 11. Hold-expiry-as-selection-trigger
The shortlist rebuilds simply because a hold window ended.

Why invalid:
- time passage becomes fake cause
- churn appears without real challenge

Required response:
- hold expiry removes one block against rebuild; it does not create rebuild entitlement on its own

---

### 12. Layer 5 universe creep
Layer 5 deep service expands beyond the promoted set because the data seems useful or resources appear available.

Why invalid:
- destroys the reason Layer 5 is allowed to be expensive
- undermines earlier layers
- expands scope without authority

Required response:
- restrict Layer 5 active service to the current promoted set only

---

### 13. Deep authority leak
Layer 5 or deep outputs start quietly influencing shortlist membership without explicit architectural redesign.

Why invalid:
- Layer 4 authority becomes ambiguous
- causality becomes hard to inspect

Required response:
- keep promotion authority in Layer 4 unless blueprint is explicitly changed

---

## Category C — Persistence invalid designs

### 14. Persistence as side-effect residue
Truth is computed and then files are written whenever convenient, without explicit publication discipline.

Why invalid:
- memory truth and landed truth drift apart
- consumers lose a trustworthy commit boundary

Required response:
- treat persistence as a governed work class with explicit publish thresholds and atomic landing

---

### 15. Same-speed write contamination
Persistence tries to publish at the same pace that tactical or fast-moving screen values change.

Why invalid:
- creates write frenzy
- destroys calm atomic publication
- increases pressure for little structural value

Required response:
- separate persistence cadence from tactical display cadence

---

### 16. Dossier-first truth creation
Dossiers, summaries, or other human-readable surfaces become the place where scanner truth is born.

Why invalid:
- reverses truth ownership
- makes recovery and lineage weaker
- lets presentation outrun structure

Required response:
- require layer-owned structural truth to land first; dossiers consume it later

---

### 17. Family confusion
Structural truth, runtime telemetry, last-good continuity, HUD support, and human-readable compositions are mixed with weak or absent family boundaries.

Why invalid:
- consumers cannot tell what they are reading
- restore trust becomes dangerous
- stale truth can masquerade as current truth

Required response:
- preserve explicit artifact families and family-aware consumer rules

---

### 18. Last-good freshness fraud
Last-good continuity is shown without clear metadata or posture, causing stale preserved truth to look freshly landed.

Why invalid:
- continuity becomes deception
- operator trust erodes

Required response:
- mark continuity explicitly and preserve stale/degraded posture honestly

---

### 19. Staged/promoted blur
The system cannot clearly distinguish staged artifacts from canonical promoted artifacts.

Why invalid:
- consumers may bind to half-landed state
- publication integrity weakens

Required response:
- preserve explicit staging and promotion states with canonical-path trust only after promotion

---

## Category D — HUD invalid designs

### 20. HUD as hidden scheduler
Opening or viewing a page silently authorizes runtime work outside governor policy.

Why invalid:
- navigation becomes a hidden control plane
- performance becomes page-dependent and erratic

Required response:
- keep HUD consumer-only and route any lawful tactical work through governor admission

---

### 21. HUD as second engine
The HUD re-derives or recomputes structural truth in render/hydration paths.

Why invalid:
- duplicates logic
- blurs ownership
- makes drift hard to detect

Required response:
- structural HUD surfaces consume landed truth or approved support artifacts only

---

### 22. Tactical liveliness masking structural staleness
Fast selected-symbol movement on screen creates the impression that structural shortlist, packet, or deep truth is also current when it is not.

Why invalid:
- operator reads visual liveliness as global freshness
- stale structural truth hides behind tactical motion

Required response:
- preserve explicit structural vs tactical source labeling and stale signaling

---

### 23. Focus grants entitlement
A selected or focused symbol receives deeper service, broader packet refresh, or selection privilege merely because the operator is looking at it.

Why invalid:
- attention becomes authority
- runtime scope becomes navigation-driven

Required response:
- focus may elevate only explicitly approved tactical surfaces

---

### 24. Transition freeze overreach
HUD transition locks/freeze behavior becomes long or opaque enough to hide stale state or block important structural updates.

Why invalid:
- visual smoothness starts overriding truthfulness
- freeze behavior becomes a hidden starvation engine

Required response:
- keep transition control brief, explicit, and subordinate to structural truth

---

## Category E — Schema/versioning invalid designs

### 25. File exists therefore trusted
Artifacts are trusted simply because a file is present.

Why invalid:
- presence gets confused with freshness, coherence, and completeness
- stale or mixed-cycle surfaces can masquerade as current truth

Required response:
- require metadata-first trust with explicit freshness, coherence, continuity, and completeness posture

---

### 26. No lineage, no causality
Artifacts do not record what upstream committed states they used.

Why invalid:
- mixed-cycle bugs become hard to detect
- downstream trust becomes guesswork

Required response:
- preserve upstream lineage references and generation/coherence metadata

---

### 27. Silent schema drift
Artifact shape changes over time without version metadata changing or without compatibility posture being clear.

Why invalid:
- restore and consumer failures become subtle and dangerous

Required response:
- version schemas explicitly and make compatibility posture knowable

---

### 28. Payload-only trust
Consumers ignore metadata and treat visible values as sufficient.

Why invalid:
- posture such as stale, partial, continuity-backed, or mixed-cycle gets erased

Required response:
- require consumers to read family, owner, freshness, continuity, and coherence metadata first

---

## Category F — Module/system invalid designs

### 29. Entry-file obesity
The EA entry file begins to own runtime meaning, layer logic, or persistence decisions.

Why invalid:
- MT5 lifecycle hookup becomes the real architecture center
- causality becomes opaque

Required response:
- keep the entrypoint thin and delegating only

---

### 30. Helper-sprawl architecture
Vague utility/helper files accumulate and become the real location of cross-domain logic.

Why invalid:
- ownership disappears into convenience glue
- architecture hollows out

Required response:
- keep helpers narrow, domain-owned, and pruned aggressively

---

### 31. Cross-domain convenience reach
Modules jump across boundaries to pull or mutate state they should receive through bounded interfaces.

Why invalid:
- dependency direction collapses
- debugging becomes harder
- side effects become harder to trace

Required response:
- restore bounded interfaces and domain-respecting dependencies

---

### 32. Persistence invents truth
Persistence code reconstructs upstream truth because it already has field access during write preparation.

Why invalid:
- landing and truth construction boundaries collapse
- payloads can diverge from real owners

Required response:
- persistence lands owned payloads; it does not derive them

---

### 33. Diagnostics/testsupport contamination
Diagnostics or test scaffolding become required for production logic to function.

Why invalid:
- production purity weakens
- runtime meaning becomes dependent on non-runtime domains

Required response:
- keep diagnostics and testsupport strictly subordinate and non-essential to production truth

---

## Category G — Process invalid designs

### 34. Patch-loop architecture
Architecture is repeatedly solved inside local fixes instead of being updated explicitly in blueprint and office.

Why invalid:
- contradictions accumulate
- code and docs drift apart
- restart pressure returns

Required response:
- treat meaningful architecture change as an explicit blueprint/office event

---

### 35. Placeholder canon
Core blueprint files are created as vague outlines, TODO dumps, or soft suggestion notes instead of complete design law.

Why invalid:
- implementation must reinterpret architecture mid-flight
- hidden contradictions survive longer

Required response:
- keep canon files complete, decisive, and ownership-explicit

---

### 36. Archive inheritance by inertia
Legacy names, structures, or behaviors are preserved simply because they existed before.

Why invalid:
- old clutter enters the rebuild without re-earning its place
- the new architecture begins compromised

Required response:
- treat archives as evidence only and rebuild meaning-first

---

### 37. Local hack normalization
A shortcut that “works for now” becomes permanent structure without ever being re-evaluated against blueprint law.

Why invalid:
- temporary debt becomes hidden architecture
- future work builds on unstable assumptions

Required response:
- either formalize the change explicitly or remove the hack

---


## Stage 5 consolidation hardening

The following drift patterns are now explicitly invalid across all active front-door, office, and blueprint files:

1. **ASC as final signal owner**
   - invalid because scanner truth and downstream interpretation ownership collapse into one surface

2. **Layer 3 directional language**
   - invalid because the neutral gate starts pretending to be setup analysis

3. **Layer 4 as best-trade ranking**
   - invalid because attention priority gets rewritten into trade superiority

4. **Layer 5 as full-universe deep service**
   - invalid because promoted-only deep analysis loses its selectivity boundary

5. **Market Board as signal dashboard**
   - invalid because a Layer 1–4 consumer board starts impersonating a trade verdict surface

6. **Current Focus implies automatic deep completion**
   - invalid because a selected-symbol working artifact is mistaken for proof that Layer 5 has already run

7. **Menu/settings as signal-engine backdoor**
   - invalid because operator configuration starts reassigning ownership instead of configuring lawful service

8. **Consumer surfaces as hidden truth owners**
   - invalid because HUD, Board, Dossier, or Current Focus starts becoming the place where truth is silently created

When any of these appear, correction is required immediately rather than being normalized as wording convenience.


## Invalid-design triage doctrine

When an invalid design is found, triage should answer:
- what ownership law it violates
- what runtime/persistence/HUD trust it damages
- whether it is local or systemic
- whether it requires immediate removal, bounded containment, or blueprint change
- what consumer or operator confusion it creates if left alive

Invalid patterns should not be debated endlessly once clearly identified.
The standard response is correction.

---

## Relationship to other blueprint files

This file does not replace the positive architecture files.
It works with them.

Those files explain:
- what ASC is
- how it should behave
- who owns what
- how runtime, layers, persistence, HUD, schema, and modules should work

This file explains:
- what patterns are not allowed to survive

Both are necessary.

---

## Final standard

ASC is protected not only by what it builds, but also by what it refuses.

A design is invalid when it:
- collapses ownership
- blends unlike work into false unity
- turns visibility into authority
- lets persistence lose its trust boundary
- lets continuity pretend to be freshness
- lets consumer surfaces become truth owners
- lets convenience outrun architecture

The standard is not merely to avoid obvious bugs.
The standard is to remove patterns that make future bugs, drift, and restart loops structurally likely.
