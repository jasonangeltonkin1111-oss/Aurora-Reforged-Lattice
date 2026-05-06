# ASC DATA OWNERSHIP AND CANONICAL FIELD CONTRACT
Status: Canonical
Scope: Owner map, field law, truth sourcing, section responsibilities

## 1. Purpose

This document defines:
- which module owns which class of truth
- which artifact consumes which truth
- how canonical symbol fields must map to owners
- how missingness, freshness, and confidence must be preserved

No field may exist in the dossier or other operator-facing artifacts unless it is:
- owner-backed
- validated
- freshness-aware
- confidence-aware
- missingness-aware

---

## 2. Core Ownership Map

### Dispatcher / Runtime Orchestration
Owns:
- heartbeat governance
- lane admission
- selected-symbol synchronization
- artifact write timing
- pair publication routing
- pacing and orchestration
- continuity-aware write entry
- bundle state admission

Does not own:
- market truth
- shortlist truth
- deep analysis truth
- dossier section truth

---

### Classification Owner
Owns:
- symbol normalization
- canonical symbol identity
- broker alias resolution
- advanced classification match
- main bucket
- sub-group
- asset class
- sector / industry where classification-owned
- classification confidence
- classification resolution state
- classification review state

Classification is foundational truth.
Broker metadata may support classification but may not silently override advanced classification.

---

### Market State Owner
Owns:
- market open / closed / uncertain state
- tradeability posture
- session posture
- state freshness
- state confidence
- next due check
- bid/ask presence
- state notes
- state continuity where applicable

---

### Open Symbol Snapshot Owner
Owns:
- bid / ask / last
- spread / spread %
- tick age
- quote freshness
- daily open/high/low
- daily change %
- day range / day range %
- ATR and ATR %
- friction and liquidity posture
- contract specs
- volume rules
- broker trade permissions
- swap and margin inputs
- quote continuity posture

---

### Candidate Filtering Owner
Owns:
- filter state
- eligibility state
- reason summary
- decision posture
- disqualifiers
- dependencies
- next required step
- gate-level checks
- cheap filter truth

---

### Shortlist Selection Owner
Owns:
- shortlist membership
- shortlist rank
- priority score
- promotion posture
- hold state
- replacement pressure
- shortlist continuity
- correlation summary
- exposure conflict status
- shortlist notes

---

### Deep Selective Analysis Owner
Owns:
- deep analysis availability
- trigger legality
- deep analysis freshness
- timeframe coverage
- OHLC structure
- price map
- microstructure context
- regime/context analysis
- related/conflict symbols
- trade framing support
- SIAM / analyst handoff content
- deep preservation truth

---

### Dossier Writer
Owns:
- section ordering
- operator-facing projection
- lawful composition of canonical artifact
- continuity-safe artifact write preparation
- field projection formatting
- artifact-only notes derived from owner-backed truth

Does not own:
- source truth
- classifier decisions
- filter logic
- shortlist logic
- deep analytical logic

---

### Current Focus Writer
Owns:
- derivative projection of canonical selected-symbol dossier truth
- selected-symbol artifact landing
- current-focus-specific integrity wrapping

Does not own:
- separate symbol truth model

---

### Market Board Writer
Owns:
- compact summary projection of owned upstream truth
- bucket/group summary presentation
- correlation display only when truly available
- account/exposure summary presentation where owner-backed

Does not own:
- shortlist logic
- market-state logic
- deep analysis logic
- classification logic

---

### HUD / Consumer Surfaces
Own:
- browse
- render
- paginate
- operator navigation
- selected-symbol page consumption

Do not own:
- truth generation
- silent recalculation
- section authoring
- hidden ownership

---

## 3. Canonical Field Contract Requirements

Every canonical field must define:

- Field name
- Owner module
- Source rule
- Readiness rule
- Freshness rule
- Confidence rule
- Missingness rule
- Continuity rule
- Publication inclusion rule

No exceptions.

---

## 4. Field Contract Classes

### Identity Class
Examples:
- Symbol
- Display Name
- Broker Symbol Name
- Canonical Symbol
- Asset Type
- Instrument Family
- Classification fields

Owner:
- classification owner
- broker symbol metadata where classification doctrine permits

---

### State Class
Examples:
- Market Status
- Tradeability Status
- Session Status
- State Freshness
- State Confidence
- Open / Closed / Uncertain

Owner:
- market-state engine

---

### Snapshot Class
Examples:
- Bid / Ask / Last
- Spread
- Daily High / Low / Open
- Daily Change %
- ATR
- Spread / ATR
- Liquidity posture
- Volatility posture

Owner:
- open-symbol snapshot engine

---

### Contract-Spec Class
Examples:
- Contract Size
- Tick Size
- Tick Value
- Volume Step
- Stops Level
- Freeze Level
- Trade Mode
- Execution Mode
- Filling Mode

Owner:
- open-symbol snapshot / broker-spec owner path

---

### Filter Class
Examples:
- Filter State
- Eligibility Status
- Reason Summary
- Disqualifiers
- Dependencies
- Sorting Inputs

Owner:
- candidate filtering engine

---

### Shortlist Class
Examples:
- Shortlist Status
- Rank
- Priority Score
- Hold Status
- Correlation Score
- Exposure Conflict Status

Owner:
- shortlist selection engine

---

### Deep Class
Examples:
- Deep Analysis Status
- Coverage Status
- Timeframe Coverage
- OHLC Structure
- Price Map
- Regime & Context
- Handoff Summary

Owner:
- deep selective analysis engine

---

### Integrity / Publication Class
Examples:
- Publication Status
- Last Successful Publish
- Bundle Status
- Continuity Mode
- Last Good Fallback
- Integrity Notes

Owner:
- publication / runtime orchestration / artifact write contract path

---

## 5. Field Truth Rules

### 5.1 No Narrative-Only Fields
A field may not exist just because it “sounds helpful.”
It must map to:
- owner-backed truth
- a lawful artifact-only projection of owner-backed truth
- or explicit missingness

### 5.2 No Duplicate Authors
If a field is owned upstream, the writer may project it.
The writer may not become a second source.

### 5.3 Confidence and Freshness Must Travel With Truth
A field without freshness or confidence context may become misleading.

### 5.4 Missingness Must Stay Explicit
Missingness is better than fake completion.

### 5.5 Continuity Must Be Visible
If a field comes from last-good preserved truth rather than fresh truth, that posture must remain explicit.

---

## 6. Canonical Artifact Hierarchy

Canonical symbol truth artifact:
- Dossier

Strict selected-symbol derivative:
- Current Focus

Compact market summary:
- Market Board

Read-only consumer surfaces:
- HUD pages
- operator navigation screens

The above hierarchy may not be inverted.

---

## 7. Final Rule

No blueprint, code pass, or artifact rewrite may loosen the field contract.

The field contract is the bridge between:
- engine truth
- artifact truth
- operator trust
