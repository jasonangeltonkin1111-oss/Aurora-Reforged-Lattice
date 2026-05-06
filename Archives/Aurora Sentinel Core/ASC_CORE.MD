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

# ASC DOSSIER CANONICAL PRODUCT LAW
Status: Canonical
Scope: Canonical dossier structure, product law, hydration law, operator-facing section contract

## 1. Purpose

The dossier is the canonical final symbol truth artifact.

It is not:
- a dev dump
- a random writer output
- a nice-to-have document
- a sidecar file
- a loosely formatted summary

It is:
- the final canonical symbol truth surface
- the most complete operator-facing artifact for a symbol
- the reference artifact from which Current Focus derives
- the artifact that crystallizes validated symbol truth into trader-readable structure

---

## 2. Dossier Laws

The dossier must be:

- clear
- grouped
- sub-grouped
- stable in structure
- filled lawfully section by section
- rich in operator-facing truth
- honest about freshness, confidence, and missingness
- free of dev-language leakage

The dossier scaffold must be written once and stabilized.
After that, sections are hydrated from owner-backed truth.

The dossier writer may compose.
It may not invent truth.

---

## 3. Hydration Law

The dossier must hydrate by owner-backed section.

Meaning:
- each subgroup reads from its lawful owner source
- each subgroup preserves freshness/confidence/missingness
- each subgroup may report degraded or fallback posture
- the writer does not become the hidden owner of upstream truth

The dossier must not become one giant intelligence module.

---

## 4. Canonical Dossier Template

===============================================================================
AURORA SENTINEL SCANNER — SYMBOL DOSSIER
===============================================================================

Generated:
Last Successful Publish:
Artifact Revision:
State Revision:
Continuity Status:
Freshness Status:
Selected Symbol Status:
Deep Analysis Status:

===============================================================================
OPERATOR SNAPSHOT
===============================================================================

Primary Read:
Primary Risk:
Primary Opportunity:
Primary Constraint:
Primary Next Check:

One-Line Summary:
[Compact trader-readable summary of what matters right now]

===============================================================================
PUBLICATION & INTEGRITY
===============================================================================

Publication Status:
Last Published:
Last Good Fallback:
Current Bundle Status:
Continuity Mode:
Missing / Delayed Areas:
Integrity Notes:

===============================================================================
SYMBOL IDENTITY [L0]
===============================================================================

------------------------------------------------------------------------------
Identity Core
------------------------------------------------------------------------------
Symbol:
Display Name:
Broker Symbol Name:
Asset Type:
Instrument Family:
Calculation Type:
Chart Mode:

------------------------------------------------------------------------------
Classification Authority
------------------------------------------------------------------------------
Advanced Classification Status:
Advanced Main Bucket:
Advanced Sub-Group:
Advanced Asset Class:
Advanced Classification Source:
Advanced Classification Confidence:

Broker Main Bucket:
Broker Sector:
Broker Industry:
Broker Exchange:
Broker Country:
Broker Classification Notes:

Resolved Main Bucket:
Resolved Sub-Group:
Resolved Asset Class:
Classification Resolution Rule:
Classification Conflict Status:
Classification Notes:

------------------------------------------------------------------------------
Symbol Metadata
------------------------------------------------------------------------------
Exchange:
Sector:
Industry:
Country:
ISIN:
Base Currency:
Quote Currency:
Margin Currency:
Digits:
Point:
Contract Profile Summary:

===============================================================================
MARKET STATE [L1]
===============================================================================

------------------------------------------------------------------------------
State Core
------------------------------------------------------------------------------
Market Status:
Tradeability Status:
Session Status:
Open / Closed / Uncertain:
Open / Closed / Uncertain Reason:

------------------------------------------------------------------------------
State Timing
------------------------------------------------------------------------------
Last Checked:
Next Check Due:
State Freshness:
State Confidence:
Bid / Ask Presence:
State Notes:

===============================================================================
MARKET WATCH [L2]
===============================================================================

------------------------------------------------------------------------------
Quote Snapshot
------------------------------------------------------------------------------
Bid:
Ask:
Last:
Spread:
Spread %:
Last Tick Time:
Tick Age:
Quote Freshness:
Observed Time:
Quote Continuity Status:

------------------------------------------------------------------------------
Day Structure
------------------------------------------------------------------------------
Daily Open:
Daily High:
Daily Low:
Daily Change %:
Day Range:
Day Range %:
Intraday Range Position:
Market Direction Snapshot:
Price Action Snapshot:

------------------------------------------------------------------------------
Volatility & Friction
------------------------------------------------------------------------------
ATR Value:
ATR %:
Spread / ATR:
Volatility Posture:
Friction Posture:
Liquidity Posture:
Market Watch Notes:

===============================================================================
TRADING CONDITIONS & CONTRACT SPECS [L2]
===============================================================================

------------------------------------------------------------------------------
Price & Contract
------------------------------------------------------------------------------
Digits:
Point:
Contract Size:
Tick Size:
Tick Value:
Spread Type:
Calculation Mode:
Contract Notes:

------------------------------------------------------------------------------
Trading Permissions
------------------------------------------------------------------------------
Trade Mode:
Execution Mode:
Filling Mode:
Expiration Mode:
GTC Mode:
Orders Allowed:
Trade Permission Status:
Broker Validation Status:

------------------------------------------------------------------------------
Volume Rules
------------------------------------------------------------------------------
Minimum Volume:
Maximum Volume:
Volume Step:
Stops Level:
Freeze Level:
Position Rule Notes:

===============================================================================
SESSIONS, SWAP & MARGIN [L2]
===============================================================================

------------------------------------------------------------------------------
Sessions
------------------------------------------------------------------------------
Quote Session Status:
Trade Session Status:
Quote Sessions:
Trade Sessions:
Session Notes:

------------------------------------------------------------------------------
Swap
------------------------------------------------------------------------------
Swap Type:
Swap Long:
Swap Short:
Swap Monday:
Swap Tuesday:
Swap Wednesday:
Swap Thursday:
Swap Friday:
Swap Notes:

------------------------------------------------------------------------------
Margin
------------------------------------------------------------------------------
Margin Mode:
Margin Hedged:
Margin Buy Initial:
Margin Buy Maintenance:
Margin Sell Initial:
Margin Sell Maintenance:
Margin Notes:

===============================================================================
CANDIDATE FILTERING [L3]
===============================================================================

------------------------------------------------------------------------------
Gate Status
------------------------------------------------------------------------------
Filter State:
Eligibility Status:
Gate Freshness:
Reason Summary:
Decision Confidence:

------------------------------------------------------------------------------
Blockers & Dependencies
------------------------------------------------------------------------------
Disqualifiers:
Dependencies:
Missing Confirmation:
Next Required Step:
Constraint Notes:

------------------------------------------------------------------------------
Sorting Inputs
------------------------------------------------------------------------------
Spread Gate:
Freshness Gate:
State Gate:
Liquidity Gate:
Volatility Gate:
Quality Gate:
Sorting Input Notes:

===============================================================================
SHORTLIST SELECTION [L4]
===============================================================================

------------------------------------------------------------------------------
Shortlist Core
------------------------------------------------------------------------------
Shortlist Status:
Shortlist Rank:
Priority Score:
Selection Posture:
Reason Summary:
Promotion Status:

------------------------------------------------------------------------------
Stability & Hold
------------------------------------------------------------------------------
Hold Status:
Stability Status:
Replacement Pressure:
Selection Continuity:
Shortlist Notes:

------------------------------------------------------------------------------
Correlation & Exposure
------------------------------------------------------------------------------
Correlation Score:
Highest Correlations:
Lowest Correlations:
Exposure Conflict Status:
Open / Pending Conflict Notes:
Portfolio Conflict Notes:

===============================================================================
DEEP SELECTIVE ANALYSIS [L5]
===============================================================================

------------------------------------------------------------------------------
Activation & Coverage
------------------------------------------------------------------------------
Deep Analysis Status:
Trigger Status:
Last Triggered:
Coverage Status:
Eligible for Deep Analysis:
Reason if Not Eligible:
Deep Analysis Continuity:
Preservation Status:

------------------------------------------------------------------------------
Timeframe Coverage
------------------------------------------------------------------------------
Enabled Timeframes:
Bars per Timeframe:
Coverage Sufficiency:
Missing Timeframes:
Coverage Notes:

------------------------------------------------------------------------------
OHLC Structure
------------------------------------------------------------------------------
Higher-Timeframe Structure:
Trend Structure:
Range / Expansion Structure:
Impulse / Pullback Structure:
Break / Reclaim / Rejection Notes:
OHLC Evidence Status:

------------------------------------------------------------------------------
Price Map
------------------------------------------------------------------------------
Nearest Support:
Nearest Resistance:
Key Reaction Zones:
Session Extremes:
Gap / Void / Imbalance Notes:
Price Map Notes:

------------------------------------------------------------------------------
Microstructure & Tick Context
------------------------------------------------------------------------------
Tick Evidence Status:
Spread Evidence Status:
Microstructure Notes:
Quote Stability:
Spread Stability:
Execution Friction:
Microstructure Risk Notes:

------------------------------------------------------------------------------
Regime & Context
------------------------------------------------------------------------------
Market Regime:
Volatility Regime:
Liquidity Regime:
Session Regime:
Context Quality:
Context Notes:

------------------------------------------------------------------------------
Correlation & External Context
------------------------------------------------------------------------------
Cross-Market Alignment:
Related Symbols:
Conflict Symbols:
Beta / Proxy Notes:
Correlation Context Notes:

------------------------------------------------------------------------------
Trade Framing Support
------------------------------------------------------------------------------
Directional Bias Support:
Continuation Support:
Reversal Risk:
Breakout Support:
Fade Risk:
Invalidation Context:
Trade Framing Notes:

------------------------------------------------------------------------------
Analyst / SIAM Handoff
------------------------------------------------------------------------------
What Matters Most:
Best Supporting Evidence:
Biggest Warning:
What Is Still Missing:
What To Check Next:
Handoff Summary:

===============================================================================
TRADER CONTEXT
===============================================================================

Risk Context:
Execution Constraints:
Open Trade Conflict:
Pending Order Conflict:
Watchlist Priority:
What Changed Recently:
What Needs Recheck:

===============================================================================
RECENT CHANGE TRACE
===============================================================================

Latest Meaningful Change:
Previous Meaningful Change:
State Transition Notes:
Selection Transition Notes:
Publication Transition Notes:
Deep Analysis Transition Notes:

---

## 5. Dossier Section Rules

### 5.1 Top block rule
The first block must immediately tell the operator:
- what symbol this is
- how fresh it is
- whether publication is good
- whether selected-symbol alignment is good
- whether deep analysis is available or preserved

### 5.2 Operator Snapshot rule
Operator Snapshot must be trader-readable first.
No engineering phrasing.

### 5.3 Publication & Integrity rule
Publication posture must remain honest.
If continuity or fallback is used, it must be visible.

### 5.4 Identity rule
Classification authority must remain explicit.
Advanced classification must remain authoritative.
Broker classification must remain supporting evidence only.

### 5.5 State/Snapshot rule
State and quote truth must remain upstream-owned and freshness-aware.

### 5.6 Deep section rule
Deep analysis may remain button-triggered,
but the dossier must still have the stable section shell for it.

---

## 6. Dossier Composition Rules

The dossier writer may:
- order sections
- format sections
- project owner truth
- attach artifact integrity posture
- preserve continuity state

The dossier writer may not:
- compute shortlist logic
- compute filter logic
- compute classification truth
- compute deep analytical truth
- silently replace missing owner truth with narrative guesswork

---

## 7. Missingness and Continuity Rules

If data is missing, the dossier must state it honestly.

Allowed reasons include:
- unavailable from broker
- not fresh enough
- not yet lawfully produced
- invalidated by validation
- preserved from last-good continuity path

The dossier must not hide these realities.

---

## 8. Language Rules

No dev-language leakage is allowed in dossier visible text.

Forbidden:
- packet
- layer identifiers in visible operator copy
- queued trigger
- future expansion
- unresolved engineering labels
- module names
- underscore names

Allowed:
- trader-facing wording only

---

## 9. Final Rule

The dossier is the canonical symbol truth product.

All future passes must preserve:
- its structure
- its honesty
- its owner-backed nature
- its operator readability

# ASC PUBLICATION CONTINUITY AND INTEGRITY LAW
Status: Canonical
Scope: Atomic publication, validation, continuity, rollback, artifact truth landing

## 1. Purpose

This document defines how artifact publication must work so that:
- downstream artifacts remain trustworthy
- partial writes do not masquerade as success
- last-good continuity is preserved safely
- timestamps remain honest
- validation blocks bad publishes
- rollback behavior is visible and evidence-rich

---

## 2. Publication Law

All artifact publication must follow:

**temp -> validate -> promote**

No exceptions.

This applies to:
- dossier
- Current Focus
- Market Board
- supporting symbol artifacts
- summary artifacts where applicable

---

## 3. Temp Law

The system must first write a candidate payload to a temporary path.

Temp write must:
- be complete
- be binary-safe where required
- preserve exact payload content
- not alter the live artifact until validation succeeds

---

## 4. Validation Law

Validation must occur before promotion.

Validation must check:
- payload exists
- payload is complete
- payload contains required canonical anchors/tokens
- payload is not truncated
- artifact family expectations are satisfied
- symbol identity is coherent for symbol artifacts
- selected-symbol identity is coherent for Current Focus where applicable

Validation failure must block promotion.

---

## 5. Promote Law

Promotion must occur only after validation succeeds.

Promotion must:
- replace live artifact atomically where possible
- preserve last-good appropriately
- stamp success metadata only on true promotion success
- never claim success before promote is complete

---

## 6. Last-Good Continuity Law

If fresh publication fails but last-good exists, the system may preserve continuity by using last-good.

Continuity fallback must:
- be explicit
- not be disguised as fresh publish success
- preserve the distinction between fresh and retained truth
- update continuity posture honestly

Last-good is a safety mechanism, not a truth laundering mechanism.

---

## 7. Honesty of Timestamps Law

Fields like:
- Generated
- Last Successful Publish
- Last Published
- Last Good Fallback
- Artifact Revision

must remain honest.

Do not stamp:
- promote time on failed validation
- fresh success time on continuity reuse
- artifact revision increments on non-landed publish

---

## 8. Bundle Integrity Law

When pair or grouped publication occurs, the system must preserve bundle integrity.

Examples:
- selected-symbol dossier + Current Focus
- board + summary families where contract requires cohesion

Bundle posture must clearly express:
- all succeeded
- partial success
- partial failure
- fallback used
- deferred or skipped companion artifact

---

## 9. Failure Law

Publication failure must remain explicit.

Possible explicit outcomes:
- success
- degraded success
- continuity fallback used
- validation blocked
- promote failed
- rollback used
- skipped by policy
- deferred by timing/breathing law

No silent publish collapse is allowed.

---

## 10. Rollback Law

If promote or validation fails in a way that threatens artifact integrity:
- rollback must preserve live truth
- rollback reason must be logged
- operator artifact must not be partially corrupted

Rollback is protective, not optional.

---

## 11. Artifact Family Law

### Dossier
Canonical symbol truth artifact.
Must not land partially.

### Current Focus
Selected-symbol derivative artifact.
Must align with selected-symbol dossier truth.

### Market Board
Compact market summary artifact.
Must not claim deep or shortlist truth it does not lawfully possess.

---

## 12. Integrity Surface Law

The dossier and related artifacts must surface integrity truth explicitly.

Examples:
- Publication Status
- Last Published
- Last Good Fallback
- Current Bundle Status
- Continuity Mode
- Missing / Delayed Areas
- Integrity Notes

These fields are mandatory for operator trust.

---

## 13. Logging Law for Publication

Publication logging must include compact evidence for:
- artifact family
- symbol or scope
- temp write result
- validation result
- promote result
- rollback result
- continuity result
- final target path
- bundle result
- timing outcome

No publication success may be claimed without evidence.

---

## 14. Final Rule

Artifacts are only trustworthy if their landing path is trustworthy.

A beautiful artifact with dishonest publication behavior is a broken product.

# ASC HUD, MARKET BOARD, CURRENT FOCUS AND OPERATOR SURFACES
Status: Canonical
Scope: Consumer-only law, operator vocabulary, surface integrity, selected-symbol derivative law

## 1. Purpose

This document defines the laws for all operator-facing surfaces:
- HUD
- Market Board
- Current Focus
- dossier-facing derived reads
- summary surfaces

The core law is:

**surfaces consume truth; they do not own truth**

---

## 2. HUD Law

The HUD is a consumer-only surface.

HUD may:
- browse
- paginate
- navigate
- switch pages
- display selected symbol
- show prepared state and prepared text
- present operator-facing labels

HUD may not:
- reclassify symbols
- compute market state
- compute shortlist
- compute deep analysis
- rebuild hidden symbol truth
- silently own selected-symbol state

---

## 3. Prepared Read Model Law

HUD and other consumer surfaces must read from prepared view models or prepared artifact truth.

Prepared state must be created outside render paths.

Render must stay focused on:
- placement
- text display
- interaction display
- state consumption

Not on:
- hidden truth production
- ownership duplication
- engine logic

---

## 4. Current Focus Law

Current Focus is a strict derivative of canonical selected-symbol dossier truth.

It is not:
- a second dossier writer
- a custom symbol-truth author
- a special-case intelligence output

It is:
- the selected-symbol operator convenience artifact
- a derived projection of canonical dossier truth
- bound to selected-symbol integrity checks

Required behaviors:
- selected symbol must have one owner chain
- Current Focus must align with canonical selected-symbol dossier truth
- symbol mismatch must be visible
- publication mismatch must be visible
- replacement on selected-symbol change must be explicit and lawful

---

## 5. Market Board Law

Market Board is a compact truthful summary surface.

It must:
- summarize canonical truth
- group symbols lawfully
- reflect real broker-supported buckets only
- use shortlist/correlation truth only when owner-backed
- remain compact without becoming thin

It must not:
- improvise deep-analysis claims
- fake correlation readiness
- override upstream classification/grouping
- become a silent truth owner

---

## 6. Operator Vocabulary Law

Operator surfaces must use trader-readable language only.

Allowed:
- Market State
- Market Watch
- Open Symbol Snapshot
- Candidate Filtering
- Shortlist Selection
- Deep Selective Analysis
- Market Board
- Current Focus
- Freshness
- Confidence
- Integrity
- Notes
- Risk
- Opportunity
- Constraint

Forbidden:
- layer numbers in visible copy
- packet
- trigger queued
- future expansion
- sync pending/internal wording
- dev abbreviations
- raw module/function names
- underscore-style labels
- developer placeholder headings

---

## 7. Selected-Symbol Surface Integrity Law

Whenever a selected symbol is shown, surfaces must preserve:

- selected-symbol identity
- canonical symbol identity
- publication alignment
- freshness posture
- continuity posture

Any mismatch between selected symbol, Current Focus, and canonical dossier must be detectable and visible through logging/evidence.

---

## 8. Surface Completeness Law

A surface must not appear more complete than the truth that supports it.

If upstream truth is missing:
- the surface must show explicit missingness
- the surface must not invent narrative replacement
- the surface must not show unsupported polish text

---

## 9. HUD Smoothness Law

HUD performance matters.

The system should support:
- quick page changes
- smooth symbol switching
- low object churn
- bounded redraw behavior
- responsive bottom navigation / paging controls
- display correctness without render-side truth recomputation

Smoothness must never be purchased by lying about truth freshness.

---

## 10. Market Board Content Law

Market Board must support:
- meaningful grouping
- concise per-symbol rows
- truthful top bucket representation
- top 3 / top 5 / top 10 laws where enabled
- correlation context only when ready
- account/exposure context where owner-backed

Market Board must not duplicate the full dossier.
It is summary, not replacement.

---

## 11. Current Focus Content Law

Current Focus should retain:
- selected symbol identity
- high-value top-of-dossier truth
- current selected-symbol deep/read context
- continuity and publication alignment posture

It must remain consistent with the canonical dossier and not drift into a separate authored personality.

---

## 12. Final Rule

All operator surfaces exist to make owned truth readable.

No operator surface may become an invisible engine.
No operator surface may leak developer framing.
No operator surface may outgrow the truth contract that supports it.

# ASC LOGGING AND VALIDATION EVIDENCE LAW
Status: Canonical
Scope: Structured evidence, non-spam logging, runtime proofs, validation doctrine

## 1. Purpose

Logging exists to prove what happened.

It does not exist to:
- flood the journal
- narrate every tiny helper step
- create performance drag
- bury real failures in noise

This document defines a lightweight but evidence-rich logging system.

---

## 2. Logging Law

The system must produce enough evidence to answer:

- Did the heartbeat run?
- Which lane ran?
- What did it attempt?
- What succeeded?
- What degraded?
- What failed?
- What fell back to continuity?
- What was skipped and why?
- What symbol count or section count was involved?
- What artifact landed?
- What selected-symbol alignment state exists?
- What bundle integrity state exists?

If logs cannot answer those questions, logging is insufficient.

---

## 3. Non-Spam Law

Logging must remain compact.

Forbidden:
- repeated per-tick line spam
- every helper function dumping lines
- identical duplicate messages
- raw diagnostic flooding in normal operation
- heavy formatting that slows the EA

Allowed:
- compact per-beat summary
- compact per-lane summary
- compact artifact outcome summary
- compact degraded/failure detail on change
- structured evidence lines

---

## 4. Required Logging Classes

### 4.1 Heartbeat Summary
Must show:
- beat id / cycle id
- start/end posture
- total duration
- warmup / steady posture
- major lane admission summary

### 4.2 Lane Summary
For each admitted lane:
- lane name
- admission status
- symbols or units processed
- duration
- success/degraded/failure posture
- key stats

### 4.3 Scanner / Coverage Summary
Must show:
- symbols scanned
- symbols refreshed
- open/closed/uncertain counts
- freshness posture
- next-check scheduling posture

### 4.4 Dossier Hydration Summary
Must show:
- symbol
- sections attempted
- sections ok
- sections degraded
- sections fallback
- sections missing
- fields populated count
- continuity used or not

### 4.5 Publication Bundle Summary
Must show:
- artifact family
- scope/symbol
- validation outcome
- promote outcome
- rollback outcome
- continuity used
- final result

### 4.6 Selected-Symbol / Current Focus Integrity Summary
Must show:
- selected symbol
- canonical dossier symbol
- Current Focus symbol
- publication id/bundle alignment
- mismatch or aligned posture

### 4.7 Market Board Publish Summary
Must show:
- publish admitted or skipped
- summary readiness
- shortlist/correlation readiness state
- bundle outcome

### 4.8 Degraded / Failure Detail Summary
Must show:
- exact reason
- owner/lane
- scope
- whether continuity preserved truth
- whether retry/defer occurred

---

## 5. Validation Evidence Law

Validation must be visible in logs.

Must show:
- what was validated
- what failed validation
- which required anchors/tokens were missing
- whether validation blocked publish
- whether last-good continuity was used instead

---

## 6. Freshness / Continuity Evidence Law

Logs must distinguish:
- fresh truth
- stale truth
- preserved last-good truth
- unavailable truth
- skipped truth
- deferred truth

A system that only logs “ok/fail” is not sufficient.

---

## 7. Operator vs Recovery Logs

The logging design may support multiple levels:
- compact normal runtime evidence
- richer recovery evidence
- targeted failure detail

But even recovery logging must remain bounded and grouped.

---

## 8. Required Log Dimensions

At minimum, compact evidence should be able to carry:
- beat number
- lane name
- symbol or scope
- count processed
- fields/sections count
- duration
- freshness posture
- continuity posture
- success state
- failure/degraded reason
- target artifact path where relevant

---

## 9. Validation Harness Law

Logging is not enough on its own.
The system also needs repeatable validation/proof checks for:

- classification sanity
- dossier structure integrity
- dossier hydration completeness
- Current Focus alignment
- Market Board integrity
- publication rollback behavior
- continuity fallback behavior
- no dev-language leakage
- selected-symbol synchronization
- heartbeat/lane discipline

---

## 10. Final Rule

A live system is only trustworthy if it can prove what it did without drowning itself in noise.

Logging must be:
- compact
- truthful
- grouped
- actionable
- cheap enough to run continuously

# ASC SYSTEM RECOVERY AND PRODUCT HARDENING ROADMAP
Status: Active Roadmap
Scope: Full-system upgrade order, phased execution, anti-drift sequencing

## 1. Mission

This roadmap exists to restore and harden the system as one interlinked organism.

It covers:
- authority reset
- ownership repair
- classification truth repair
- publication hardening
- dossier canonicalization
- Current Focus derivation
- Market Board repair
- HUD consumer-only hardening
- advanced logging evidence
- final validation

This is not a symptom-chasing roadmap.
This is a systems roadmap.

---

## 2. Ordering Law

Execution order matters.

Do not skip ahead because a downstream surface looks more visible.

The system must be repaired in the following order:

1. authority and ownership
2. canonical field contract
3. classification truth
4. publication integrity
5. dossier scaffold freeze
6. dossier owner-backed hydration
7. Current Focus derivation
8. Market Board truth repair
9. HUD consumer-only hardening
10. advanced logging/evidence
11. validation and proof

---

## 3. Phase 0 — Authority Reset

### Purpose
Lock active truth and kill drift.

### Must do
- identify active compile/runtime root
- identify authoritative owner files
- identify non-authoritative duplicate trees / legacy files
- identify selected-symbol owner chain
- identify artifact family ownership
- identify HUD read path
- identify publication path
- identify contradictions between blueprint, office, and code

### Deliverables
- active truth map
- owner map
- contradiction log
- legacy/drift quarantine list

### Definition of done
No uncertainty remains about who owns what.

---

## 4. Phase 1 — Canonical Field Contract Freeze

### Purpose
Map every dossier field to a lawful owner.

### Must do
For every canonical dossier field:
- assign owner
- define freshness rule
- define confidence rule
- define missingness rule
- define continuity rule
- define publication inclusion rule

### Deliverables
- field ownership matrix
- field readiness matrix
- missingness matrix

### Definition of done
No field exists without owner-backed law.

---

## 5. Phase 2 — Classification Truth Repair

### Purpose
Repair identity truth before trusting any downstream surface.

### Must do
- audit classification rows
- find obvious polluted mappings
- separate verified vs heuristic rows
- preserve conservative matching law
- repair asset-class / bucket errors
- ensure dynamic broker-aware grouping
- protect advanced classification authority over broker metadata

### Deliverables
- classification audit
- corrected classification source
- confidence/review-state doctrine

### Definition of done
Classification no longer poisons dossier, board, or HUD.

---

## 6. Phase 3 — Publication Hardening

### Purpose
Make artifact landing atomic, honest, and continuity-safe.

### Must do
- unify temp -> validate -> promote
- validate full payloads
- preserve last-good
- improve rollback paths
- make timestamps honest
- make bundle state explicit
- keep publication pacing bounded

### Deliverables
- hardened write pipeline
- validation checklist
- continuity and rollback evidence

### Definition of done
No false publish success can survive.

---

## 7. Phase 4 — Dossier Scaffold Freeze

### Purpose
Stabilize the dossier structure once.

### Must do
- freeze headings
- freeze subgroup order
- clean operator wording
- remove dev leakage
- preserve future hydration capacity
- lock the canonical template in doctrine

### Deliverables
- stable dossier scaffold
- canonical template doctrine

### Definition of done
Later passes hydrate rather than reinvent.

---

## 8. Phase 5 — Dossier Hydration by Owner

### Purpose
Hydrate the dossier from real owner modules.

### Must do
- split writer-side section ownership cleanly
- consume upstream owner fields only
- keep writer thin
- preserve missingness/freshness/confidence
- add compact section status telemetry

### Deliverables
- hydrated canonical dossier
- section-by-section owner-backed population
- section evidence summaries

### Definition of done
The dossier is rich, lawful, and not a monolithic fake-intelligence writer.

---

## 9. Phase 6 — Current Focus Derivation Repair

### Purpose
Make Current Focus a strict selected-symbol derivative.

### Must do
- enforce one selected-symbol owner chain
- derive Current Focus from canonical dossier truth
- preserve symbol/publication alignment checks
- replace cleanly on symbol switch
- log mismatches explicitly

### Deliverables
- aligned Current Focus derivative path
- selected-symbol integrity proof

### Definition of done
Current Focus is no longer a competing truth surface.

---

## 10. Phase 7 — Market Board Truth Repair

### Purpose
Make the board a compact truthful summary.

### Must do
- summarize only owned truth
- preserve bucket truth
- preserve shortlist/correlation readiness law
- support account/risk snapshot only where owner-backed
- remove unsupported hard-coded summary claims

### Deliverables
- truthful board projection
- bucket and shortlist integrity proof

### Definition of done
The board is useful and honest.

---

## 11. Phase 8 — HUD Consumer-Only Hardening

### Purpose
Make the HUD fast, clean, and strictly consumer-only.

### Must do
- remove hidden compute from render
- move browse-state preparation outside HUD
- preserve smooth page switching
- reduce churn/redraw noise
- remove dev-language leakage
- keep operator-facing page flow strong

### Deliverables
- clean consumer-only HUD
- operator language cleanup
- selected-symbol display integrity proof

### Definition of done
HUD becomes a fast truthful window, not a hidden engine.

---

## 12. Phase 9 — Advanced Logging and Evidence Upgrade

### Purpose
Create compact but powerful system evidence.

### Must do
- heartbeat summaries
- lane summaries
- dossier hydration summaries
- publication bundle summaries
- selected-symbol / Current Focus alignment summaries
- Market Board publish summaries
- degraded/failure evidence blocks

### Deliverables
- grouped structured logging
- non-spam runtime evidence
- recovery-friendly evidence posture

### Definition of done
The system can prove what worked and what failed without drowning in noise.

---

## 13. Phase 10 — Validation and Proof of Truth

### Purpose
Prove the system behaves lawfully.

### Must validate
- classification correctness samples
- dossier structure stability
- dossier hydration completeness
- Current Focus alignment
- Market Board integrity
- rollback and continuity behavior
- no dev-language leakage
- heartbeat/lane discipline
- selected-symbol correctness

### Deliverables
- validation checklist
- evidence report
- final readiness posture

### Definition of done
The system is not just patched; it is verified.

---

## 14. Anti-Drift Rules

Future passes must not:
- over-claim completion
- mark placeholder truth as complete
- let HUD own truth
- let writers become engines
- let broker metadata silently override advanced classification
- remove fields silently
- leak dev terms into operator surfaces
- skip field-owner mapping

---

## 15. Final Roadmap Rule

The system must be repaired as an interlinked whole.

Do not optimize one visible surface while breaking:
- truth ownership
- publication integrity
- classification trust
- selected-symbol integrity
- operator language law
- heartbeat/breathing law

Upstream truth owns.
Canonical dossier crystallizes.
Everything else reads.