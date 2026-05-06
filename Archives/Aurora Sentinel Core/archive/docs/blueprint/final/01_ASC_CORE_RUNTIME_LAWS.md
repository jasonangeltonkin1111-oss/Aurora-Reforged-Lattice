# ASC CORE RUNTIME LAWS
Status: Canonical
Scope: Heartbeat, breathing, lanes, ownership boundaries, timing discipline

## 1. Purpose

This document defines the non-negotiable runtime laws for Aurora Sentinel Core.

Aurora Sentinel Core is:
- an upstream scanner and truth-production system
- not a signal engine
- not a trade selector
- not a UI-owned system
- not a bundle of disconnected modules

The runtime exists to:
- observe broker/server reality
- normalize and validate symbol truth
- maintain lawful timing and pacing
- publish truthful downstream artifacts
- preserve operator trust through explicit continuity and integrity behavior

---

## 2. Heartbeat Law

The heart remains **1 beat per second**.

This does not mean the system must be slow.
It means all major work remains governed by a clear heartbeat contract.

Heartbeat law requires:
- one explicit governing beat
- lawful lane admission per beat
- bounded work per lane
- explicit scanner/write/read rhythm
- honest warmup vs steady-state posture
- no uncontrolled work explosion hidden inside render or publication paths

The heart is governance.
The heart is not an arbitrary slowdown mechanism.

---

## 3. Breathing Law

The system breathes as:

**Scan -> Write -> Read**

Meaning:

### Scan
Upstream truth generation:
- symbol state checks
- market-state checks
- snapshot refresh
- classification resolution
- shortlist/filter/deep owner refresh where lawfully due

### Write
Artifact production and atomic landing:
- dossier
- Current Focus
- Market Board
- summary/supporting artifacts
- continuity-preserving promote/rollback handling

### Read
Consumer surfaces read prepared truth:
- HUD
- browse-state
- symbol pages
- summary pages
- selected-symbol display surfaces

Read is consumer-only.
Read is not an ownership phase.

---

## 4. Lane Law

The runtime must remain lane-governed.

Primary lanes include:

- Runtime orchestration lane
- Market-state lane
- Open-symbol snapshot lane
- Candidate-filtering lane
- Shortlist-selection lane
- Deep-selective-analysis lane
- Artifact publication lane
- HUD/read-consumer lane
- Logging/evidence lane

Each lane must have:
- one owner
- a bounded admission rule
- a bounded budget rule
- a freshness rule
- a logging/evidence posture
- explicit interaction boundaries with other lanes

No lane may silently become a second owner of another lane’s truth.

---

## 5. Ownership Boundary Law

The runtime must obey:

- **Dispatcher owns orchestration**
- **Engines own truth**
- **Writers own artifact composition**
- **HUD owns zero truth**

### Dispatcher owns:
- heartbeat admission
- lane sequencing
- selected-symbol synchronization
- write timing
- bundle admission
- pacing decisions
- pair-publish routing
- continuity-aware write orchestration

### Engines own:
- market state
- open symbol snapshot
- filter/eligibility truth
- shortlist truth
- deep analysis truth
- classification truth inputs and resolution

### Writers own:
- artifact composition
- section ordering
- operator-facing section projection
- publish contract usage
- continuity-safe artifact projection

### HUD owns:
- display
- navigation
- consumption of prepared truth
- no hidden truth generation
- no silent truth mutation
- no ownership leakage

---

## 6. No Hidden Compute In Render Law

Render/UI code must not:
- compute market truth
- recalculate shortlist logic
- recompute symbol state
- redefine selected-symbol truth
- reclassify symbols
- synthesize hidden summaries not produced upstream

HUD and read surfaces may:
- paginate
- browse
- present
- map labels
- display already-prepared truth

They may not become invisible engines.

---

## 7. Selected-Symbol Ownership Law

Selected symbol must have one owner chain only.

Selected-symbol truth must not be simultaneously owned by:
- HUD
- dossier writer
- Current Focus writer
- deep analysis trigger path
- random helper files

Selected-symbol synchronization belongs to runtime orchestration.

Current Focus and selected-symbol dossier publication must derive from that single owner chain.

---

## 8. Warmup vs Steady-State Law

Warmup and steady-state must be treated differently but honestly.

### Warmup
The system may:
- prioritize coverage
- defer non-essential secondary enrichments
- surface partial readiness truthfully
- avoid false “complete” posture

### Steady-state
The system must:
- maintain freshness
- recheck on lawful cadence
- preserve continuity
- avoid unnecessary churn
- maintain high artifact integrity

The system may not pretend warmup is complete when owner-backed truth is still incomplete.

---

## 9. Throughput Law

The system must be capable of fast market-state coverage and lawful artifact production without violating ownership or timing law.

Layer 1 must feel fast.
Coverage must scale by broker/server universe size.

However:
- throughput must not create ghost ownership
- throughput must not silently skip integrity rules
- throughput must not force fake smoothness through dishonest state reuse
- throughput must remain bounded and measurable

---

## 10. Missingness Law

Missingness must remain explicit.

A field may be absent only for real reasons such as:
- broker did not provide it
- symbol is not open or not tradable
- owner has not lawfully produced it yet
- freshness invalidated it
- validation rejected it
- continuity fallback preserved last-good truth instead

No artifact or HUD surface may look “finished” while silently masking missing truth.

---

## 11. Operator Language Law

No trader-facing surface may leak developer language.

Forbidden on operator surfaces:
- layer numbers
- packet
- future expansion
- queued trigger
- sync pending/internal phrasing
- owner/module names
- raw dev identifiers
- underscores/dev keys
- scaffold/dev contract labels

Allowed language is operator-facing only.

---

## 12. Runtime Truth Hierarchy

The runtime truth hierarchy is:

1. upstream engines
2. validated canonical artifact composition
3. derivative artifact projection
4. read-only consumer surfaces

Truth does not flow upward from HUD or derivative artifacts.

---

## 13. Failure Honesty Law

The runtime may degrade.
The runtime may fallback.
The runtime may preserve last-good.
The runtime may delay a section.

But it must always do so honestly.

Never:
- fake readiness
- stamp fake success
- hide rollback
- hide continuity fallback
- disguise unresolved truth as stable truth

---

## 14. Final Runtime Rule

The system is one interlinked organism.

No phase or patch may optimize:
- dossier
- HUD
- Market Board
- Current Focus
- publication
- timing
- classification
- logging

in isolation while violating the laws above.

Correctness comes before optimization.
Truth ownership comes before polish.
Operator trust comes before appearance.
