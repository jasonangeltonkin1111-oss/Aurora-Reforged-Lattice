# Aurora Reforged Lattice

**Aurora Reforged Lattice** is the second-generation rebuild of the Aurora Sentinel trading-intelligence architecture.

It keeps the original system vision — scanner intelligence, bucket ranking, Market Board guidance, symbol dossiers, telemetry, and operator-assisted MT5 workflows — but rebuilds the foundation around stricter truth ownership, cleaner module boundaries, deterministic refresh behavior, atomic publication, explainable ranking, and safer operator visibility.

This repository begins as a clean source-of-truth foundation. It is **not** a live-trading approval, edge proof, compile proof, or prop-firm deployment claim.

---

## Purpose

Aurora Sentinel proved the shape of the system, but the old codebase accumulated too many repair layers, runtime seams, stale evidence paths, placeholder risks, source/version contradictions, and workflow drift.

Aurora Reforged Lattice exists to rebuild the same system design properly from the ground up.

The goal is not to create a different species of system.

The goal is to create a cleaner second form:

- same high-level trading-intelligence workflow
- cleaner internal contracts
- stricter source-of-truth ownership
- safer file publication
- more visible uncertainty
- better refresh integrity
- no hidden proof claims
- no silent placeholder confidence
- no execution permission without evidence

---

## Core Philosophy

The system is a **market-truth lattice**.

That means every output must be traceable to the correct owner, timestamp, evidence level, and refresh cycle. Scanner data, ranking context, dossier intelligence, Market Board recommendations, telemetry, and operator decisions are allowed to connect only through clear contracts.

A valid lattice has controlled boundaries.

A broken lattice becomes spaghetti.

Aurora Reforged Lattice is built to prevent that collapse.

---

## Design Lineage

Aurora Reforged Lattice inherits the **conceptual architecture** of Aurora Sentinel Core / Aurora Sentinel Scanner, including:

- MT5/MQL5-based trading-intelligence runtime
- Market Board workflow
- top-candidate scanning and ranking
- bucket-based opportunity grouping
- symbol dossier generation
- symbol data pack / review pack concepts
- L3/L4 style filtering and shortlist intelligence
- telemetry and heartbeat visibility
- operator-assisted decision support
- strict no-fake-proof discipline

It does **not** blindly inherit old implementation debt.

Old code and reports are inheritance evidence, not automatic authority.

---

## Current Status

**Repository status:** foundation initialized  
**Trading status:** no live-trading permission  
**Compile status:** unproven in this repository  
**Runtime status:** unproven in this repository  
**Edge status:** unproven  
**Prop-firm status:** not approved  

The old Aurora Sentinel audit lineage showed useful architecture, but also confirmed that source identity, report evidence, compile evidence, live evidence, and generated-output proof can drift if they are not controlled.

This repo starts clean so those contradictions are not carried forward as hidden poison.

---

## What This System Must Eventually Do

Aurora Reforged Lattice is intended to support this workflow:

1. Scan a broad symbol universe.
2. Group symbols into meaningful buckets.
3. Rank the strongest candidates per bucket.
4. Produce a Market Board that recommends which symbols are worth deeper review.
5. Generate per-symbol dossiers / review packs.
6. Expose freshness, missing data, uncertainty, and placeholder status honestly.
7. Help the operator decide which 3, 5, or 10 symbols should be uploaded/reviewed at that moment.
8. Support trade decision workflows only after evidence, testing, and permission boundaries are satisfied.

The system must never pretend incomplete information is complete.

---

## Non-Negotiable Engineering Laws

### 1. Source of Truth Ownership

Every important field must have one owner.

Examples:

- scanner facts are owned by scanner modules
- ranking scores are owned by ranking modules
- dossier text is owned by dossier composers
- trade state is owned by execution/risk modules
- UI/HUD may display truth, but must not secretly own truth

No hidden ownership leaks.

---

### 2. Deterministic Refresh Cycles

Refresh behavior must be inspectable and repeatable.

Every generated output should expose:

- producer
- timestamp
- refresh cycle
- freshness
- stale status
- partial/complete status
- missing-data reason where relevant

The operator should never need to guess whether a file is current.

---

### 3. Atomic Publication

Generated files must be written safely.

Preferred pattern:

1. write to staging/temp
2. verify written content where possible
3. promote to current
4. preserve status/error visibility
5. never silently overwrite truth with broken output

File presence alone is not proof.

---

### 4. Explainable Ranking

Every rank must be explainable.

A symbol should not be marked strong just because a number says so. The system must expose why it ranked, what data was used, what is missing, and whether the ranking is still fresh.

Ranking must be replayable enough to debug.

---

### 5. Honest Dossiers

Dossiers must not fake completeness.

If a section is missing, stale, broker-limited, placeholder-based, or waiting for a later refresh, the dossier must say so directly.

Unknown is acceptable.

Fake certainty is not.

---

### 6. No Silent Trading Permission

Review intelligence is not trade permission.

No module may imply live execution safety, prop-firm safety, signal validity, or trading edge unless the required evidence exists.

Backtest profit is not live proof.

Compile success is not strategy proof.

Generated reports are not runtime truth by themselves.

---

## Planned Architecture

```text
Aurora Reforged Lattice
|
|-- ARL Runtime
|   |-- clock
|   |-- scheduler
|   |-- heartbeat
|   |-- state registry
|   |-- telemetry
|
|-- ARL Scanner
|   |-- symbol universe
|   |-- bucket classification
|   |-- market-state collection
|   |-- freshness tracking
|
|-- ARL Ranking
|   |-- scoring inputs
|   |-- bucket ranking
|   |-- global ranking
|   |-- explainability payloads
|
|-- ARL MarketBoard
|   |-- top candidates
|   |-- per-bucket summaries
|   |-- upload recommendations
|   |-- missing-data visibility
|
|-- ARL Dossiers
|   |-- per-symbol review files
|   |-- section-level evidence status
|   |-- freshness and placeholder disclosure
|
|-- ARL Publication
|   |-- atomic file writes
|   |-- manifests
|   |-- readback/status proof
|
|-- ARL Execution Boundary
|   |-- no execution permission by default
|   |-- risk/prop-firm rules quarantined until proven
|   |-- live permission only after evidence upgrades
```

---

## First Build Order

The rebuild should not begin with trading logic.

Correct order:

1. Foundational law and contracts
2. Runtime skeleton
3. Logging and telemetry
4. Atomic file publication
5. Scanner skeleton
6. Bucket and ranking contracts
7. Market Board output
8. Dossier/review-pack output
9. Refresh integrity proof
10. Compile proof
11. Runtime proof
12. Demo/live evidence review
13. Execution/risk integration only after permission boundaries are proven

Starting with execution would rebuild the same failure pattern faster.

---

## Evidence Rules

Aurora Reforged Lattice follows an evidence-first development model.

Evidence strength increases roughly like this:

1. idea / claim
2. AI reasoning
3. user report / screenshot / pasted output
4. direct source inspection
5. compile/static validation
6. controlled backtest
7. out-of-sample / walk-forward robustness
8. forward demo
9. small live result
10. multi-broker / multi-session / multi-regime live evidence
11. production-proven behavior with logs and known boundaries

The system must never claim above the evidence it actually has.

---

## What This Repository Is Not

This repository is not:

- a get-rich trading bot
- a black-box signal seller
- a prop-firm cheat system
- a live-ready EA by default
- proof of profitable trading edge
- proof of execution safety
- proof that old Aurora outputs were correct

It is a clean rebuild foundation for a serious MT5 trading-intelligence system.

---

## Development Rule

Every module must earn its place.

A feature should exist only if it does at least one of these:

- prevents a known failure
- exposes a hidden assumption
- improves evidence quality
- reduces source-of-truth ambiguity
- reduces compile/runtime risk
- improves operator safety
- improves refresh integrity
- makes testing easier
- protects against fake proof

If it only sounds impressive, it does not belong.

---

## Repository Naming

**Aurora** preserves the original lineage.  
**Reforged** means the old form is being rebuilt under stricter discipline.  
**Lattice** means the system is a controlled structure of connected truth nodes, not a pile of scripts.

Short names:

- ARL
- Aurora Lattice
- Reforged Core

---

## Starting Position

The cleanest first milestone is not a trader.

The cleanest first milestone is:

> a small runtime that can publish one truthful status file with version, timestamp, source owner, freshness, and atomic write/readback status.

If that cannot be proven, nothing higher should be trusted yet.

---

## Final Principle

Aurora Reforged Lattice exists to make false confidence harder to create.

Truth first.  
Then speed.  
Then intelligence.  
Then trading.
