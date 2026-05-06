# ASC Engineering Guidelines

## Purpose

This document defines the canonical engineering guidelines for Aurora Sentinel Scanner (ASC).

The final architecture only remains useful if implementation behavior stays inside it.
That means engineering discipline must not be treated as optional style.
It is part of the runtime safety system.

These guidelines exist to make future implementation cleaner, more stable, and harder to corrupt through convenience, drift, or patch-loop thinking.

---

## Core doctrine

### Engineering-serves-architecture law
Implementation exists to realize the final blueprint.
It does not exist to quietly renegotiate it through convenience.

When code and architecture diverge, the default assumption is:
- code drift happened
- the blueprint must be checked
- any architecture change must be explicit and documented

### Clarity-over-cleverness law
ASC should prefer code that is explicit, inspectable, and easy to reason about under pressure.
Clever compression that hides ownership, timing, or data posture is a liability.

### One-owner-per-concern law
Every major runtime concern should have one primary owner in code.
If two modules appear to own the same truth or the same control decision, the design is wrong until corrected.

### Hostile-to-drift law
ASC engineering must assume drift is always possible.
The codebase should therefore make drift visible early by:
- keeping boundaries explicit
- naming ownership clearly
- centralizing posture vocabularies
- avoiding convenience shortcuts that hide layer or family identity

### Compile-safety-and-runtime-continuity law
Changes should preserve both:
- compile safety
- runtime continuity

A change that compiles but destroys architectural guarantees is not safe.
A change that protects architecture in theory but casually breaks runtime continuity is also not safe.

---

## Naming doctrine

### Meaning-based naming
Names should describe ownership and role.
They should not describe history, mood, or temporary implementation phase.

Prefer names like:
- `ASC_Control_Governor`
- `ASC_Layer2_OpenSymbolSnapshot`
- `ASC_Persistence_Atomic`
- `ASC_HUD_Transitions`

Avoid names like:
- `pass2_fix`
- `new_scheduler`
- `temporary_layer4`
- `final_real_final`

### Stable vocabulary
The codebase should use a stable vocabulary for:
- work classes
- lane identities
- layer states
- artifact families
- freshness posture
- degraded posture
- continuity posture
- coherence posture

These vocabularies should not be re-invented locally inside multiple modules.

### Operator wording vs engineering wording
Engineering names should remain precise.
Operator-facing labels may be friendlier.
The system should never simplify engineering names so far that ownership becomes unclear.

### Prefix discipline
Active MT5 implementation files should use consistent `ASC_` prefixing so repo ownership remains obvious and searchability remains strong.

---

## Boundary doctrine

### Module boundaries must be real
A file or module boundary is meaningful only if it protects ownership.
If a helper can casually reach into any domain and mutate anything, boundaries are decorative and therefore invalid.

### Layer boundaries are sacred
No layer may silently absorb the job of another layer just because the data is nearby.
This must hold in code, not just in documents.

### Artifact-family boundaries must stay explicit
Structural truth artifacts, runtime telemetry, last-good continuity support, HUD support surfaces, and human-readable compositions must remain distinct in code paths and data posture.

### Presentation is downstream
HUD and other operator surfaces may consume truth.
They may not become hidden truth owners.

### Persistence lands; it does not invent
Persistence code may build payloads from already-owned truth and land them safely.
It must not compute upstream meaning because it already has field access.

---

## File and module hygiene doctrine

### Thin files with clear ownership
Files should remain small enough that their ownership stays obvious.
A file that handles multiple unrelated responsibilities is a drift warning.

### Avoid vague utility dumps
Utility files become dangerous when they absorb unrelated helpers from multiple domains.
A helper should exist only when:
- it has clear ownership
- it serves one real domain
- it does not erase dependency direction

### Shared helpers need scrutiny
A shared helper is allowed only if:
- the behavior truly belongs below multiple consumers
- it does not smuggle cross-domain knowledge upward
- it does not let later layers mutate earlier truths indirectly

### Delete dead scaffolding
Transitional code, abandoned helpers, stale experiments, and superseded scaffolding should be removed when no longer needed.
ASC should not preserve dead code as emotional insurance.

---

## Dependency doctrine

### Lower-to-higher flow
Dependencies should generally flow from foundational domains upward into richer behavior and finally presentation.
This should be visible both in imports/includes and in who is allowed to call whom.

### No upward convenience reach
A lower-level module must not import a higher-level module just to get convenient access to a value it should receive through a bounded interface.

### No cross-layer backfill
Layer 4 and Layer 5 code must not directly rebuild Layer 1, Layer 2, or Layer 3 ownership just because they have access to symbols or packets.

### Bounded interface preference
Cross-domain interaction should prefer:
- narrow interfaces
- explicit payload structures
- clear result contracts
- inspectable side effects

Over:
- shared mutable sprawl
- deep implicit reach-through
- undocumented state mutation

---

## State doctrine

### State must be explicit
Important runtime posture should be represented through explicit state structures or enums rather than scattered booleans and improvised flags.

### Posture names must be centralized
Freshness, completeness, degraded, continuity, and coherence vocabularies should come from shared type definitions rather than per-file reinterpretation.

### Hidden coupling is forbidden
If two modules depend on one another’s internal state shape without an explicit contract, the code is fragile even if it currently works.

### State mutation must be attributable
The code should make it possible to answer:
- who changed this state
- why it changed
- under what mode/lane context it changed
- what downstream eligibility it created

---

## Function design doctrine

### Functions should do one bounded thing
A function should have one dominant purpose.
If a function scans, filters, writes, logs, updates HUD state, and changes shortlist posture in one pass, the design is wrong.

### Function names should expose side-effect class
Names should signal whether a function:
- computes
- validates
- builds payloads
- lands artifacts
- mutates runtime state
- renders HUD objects

### Side effects must stay visible
A function that mutates important state or lands artifacts should not hide those effects behind innocent names like `UpdateStuff` or `HandleData`.

### Return values must tell the truth
Bounded result objects are preferred over vague success/failure booleans when more nuance matters, especially for:
- publication outcomes
- degraded states
- stale vs fresh posture
- blocked vs pending behavior

---

## Error and degradation doctrine

### Failure must be representable
The code should represent failure and degradation explicitly rather than collapsing everything into generic error flags.

### Different failure classes should stay distinct
Examples:
- upstream truth missing
- artifact staging failed
- promotion failed
- stale but still usable
- continuity-backed only
- blocked pending dependency

### No silent downgrade
If the system falls back to last-good continuity, stale truth, or reduced functionality, that must remain explicit in code posture and consumer-visible outputs.

### Recovery should be architecture-aware
Recovery code should restore support surfaces carefully without pretending to re-earn live truth automatically.

---

## Logging and telemetry doctrine

### Logs must help future audits
Logs should be useful for later inspection, not just for immediate debugging.
They should help answer:
- what changed
- why it changed
- what lane or mode owned the work
- what artifact landed or failed
- what degraded boundary was crossed

### Logs should be structured enough to matter
Prefer bounded, interpretable log structure over walls of noisy print statements.

### Telemetry must reflect truth, not vanity
Telemetry exists to reveal runtime posture, not to make the system look active.
If telemetry hides starvation, mixed-cycle risk, or degraded landing, it is deceptive.

### Logging must not become a runtime parasite
Instrumentation is important.
It must remain bounded enough that it does not become the cause of the next performance or clarity collapse.

---

## Persistence engineering doctrine

### Build payloads before landing
Code should clearly separate:
- building artifact payloads
- validating payload posture
- performing atomic landing
- updating lineage and continuity metadata

### Structural truth lands before composition
Layer truth must land before dependent summary or HUD support compositions are published.

### No write-at-display-speed contamination
HUD tactical movement must not drag persistence code into same-speed writes.

### Family-aware handling only
Artifact code must always know which family it is operating on.
Generic “save file” helpers that erase family posture are unsafe.

---

## HUD engineering doctrine

### HUD code stays downstream
HUD code may request sources, interpret state for display, and update objects.
It must not become a shortcut path for lower-layer computation.

### Render paths must stay light
HUD rendering should prefer retained objects, bounded updates, and stable page models over brute-force rebuilds.

### Focus overlays must remain reversible
Entering focus may elevate bounded tactical behavior.
Exiting focus must remove that elevation cleanly.

### Transition helpers must stay honest
Visual smoothing helpers must never become hidden data-freshness fraud or starvation engines.

---

## Governor engineering doctrine

### Governor decisions must be inspectable
Code should make it possible to explain:
- why a lane was chosen
- why another lane yielded
- why a mode changed
- why forced service happened
- why starvation was or was not declared

### Credits must be class-aware in code
A generic budget counter is not enough.
The implementation must preserve class-specific work-credit semantics.

### Admission shortcuts are forbidden
No layer or helper should be able to bypass the governor because it “already knows” its work is small.
That is how blended runtime drift begins.

---

## Testability doctrine

### Code should be testable by design
Functions and modules should be shaped so that scenario testing, fake inputs, and state validation are possible without giant integration-only reliance.

### Test support must remain separate
Production logic should not depend on test scaffolding.
Test hooks may exist, but they must not become hidden production infrastructure.

### Build for inspection
The code should preserve enough explicit state and result posture that tests can assert:
- fresh vs stale
- selected vs not selected
- coherent vs mixed-cycle
- promoted vs not entitled
- pending vs blocked vs degraded

---

## Change-management doctrine

### Small coherent changes are preferred
Future implementation should favor changes that are:
- bounded
- ownership-respecting
- easy to review
- easy to revert if needed

### A patch may repair implementation, not secretly rewrite architecture
If a patch requires architecture change, that change must be documented explicitly in blueprint/office before or alongside implementation.

### Staged completion is acceptable
It is acceptable to leave a domain incomplete if its boundaries are preserved and its state is honest.
It is not acceptable to fake completeness by cross-wiring unfinished domains together.

### Change logs matter
Meaningful repo changes should leave useful traces in office and commit history so future work can distinguish:
- intended evolution
- emergency repair
- abandoned direction

---

## Anti-drift doctrine

### Watch for these symptoms
Engineering drift is often visible as:
- vague helper growth
- entrypoint obesity
- hidden side effects
- cross-layer convenience imports
- write paths inventing truth
- HUD paths requesting broader service than allowed
- per-file reinterpretation of posture vocabularies
- duplicated logic across layer and consumer surfaces

### Respond by pruning or refactoring early
When drift appears, the preferred response is:
- reassert ownership
- split modules cleanly
- delete dead scaffolding
- tighten interfaces
- document the boundary if needed

### Do not normalize local hacks
A local shortcut that “works for now” often becomes permanent architecture debt.
ASC should assume shortcuts are sticky and therefore treat them seriously.

---

## Common failure patterns

### Pattern 1 — Convenience glue takeover
A helper or bridge module starts accumulating real logic because it is centrally reachable.

Result:
- ownership disappears
- debugging gets harder
- architecture hollows out

### Pattern 2 — Hidden side-effect functions
Functions with soft names mutate critical state, land artifacts, and trigger downstream work invisibly.

Result:
- causality becomes hard to inspect
- testing becomes weak

### Pattern 3 — Vague status flags
Many local booleans replace clear posture enums and contracts.

Result:
- state meaning drifts by file
- debugging becomes interpretive

### Pattern 4 — Patch-loop architecture
Implementation keeps solving architecture through local fixes instead of updating shared contracts.

Result:
- repeated restarts
- contradictory modules
- trust collapse

### Pattern 5 — Instrumentation sprawl
Logs, counters, and debug helpers expand without discipline.

Result:
- noise rises
- performance risk rises
- real signals get buried

---

## Implementation obligations

Any future MT5 implementation of ASC must:
- use stable ownership-based names
- preserve explicit domain and layer boundaries
- keep state vocabularies centralized and inspectable
- keep side effects visible and attributable
- separate payload building from landing
- keep HUD, persistence, and layers in their correct downstream/upstream posture
- preserve class-aware governor admission discipline
- log meaningful changes and failure posture honestly
- keep production logic independent from testsupport and diagnostics
- prune dead scaffolding instead of collecting it

If an implementation cannot explain who owns a piece of logic, what state it mutates, and why it lives in that file, that implementation is incomplete.

---

## Final standard

ASC engineering is correct when the code stays clear enough that architecture remains stronger than convenience.

That means engineering must be:
- ownership-explicit
- naming-disciplined
- dependency-aware
- side-effect-honest
- compile-safe
- runtime-safe
- testable
- hostile to drift, helper sprawl, and patch-loop thinking

The standard is not merely that the code works today.
The standard is that the code remains structurally trustworthy as the system grows.