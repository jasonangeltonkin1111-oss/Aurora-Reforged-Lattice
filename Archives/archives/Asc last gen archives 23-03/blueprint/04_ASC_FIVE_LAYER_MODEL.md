# ASC Ordered Capability Model

## Purpose

This document keeps the ASC processing order explicit while moving active canon toward capability-first naming.
The sequence must stay visible for debugging, ownership, and future implementation order.

## Ordered capability stack

1. **Market State Detection**
2. **Open Symbol Snapshot**
3. **Candidate Filtering**
4. **Shortlist Selection**
5. **Deep Selective Analysis**

Internal schema/search keys may still preserve stable architecture identifiers where needed, but active canonical language should prefer the capability names above.

## Cross-capability law

The five capabilities are ordered.
They must not collapse into one giant function.
Each capability owns:
- its meaning
- its cadence rights
- its publication blocks
- its insertion point in the runtime sequence
- its focus-safe refresh rights

A later capability may consume earlier truth.
It may not silently rebuild lower-layer truth merely because it is due.

## Capability 1 — Market State Detection

### Purpose
Determine whether each symbol is open, closed, uncertain, or unknown and decide when it should be checked again.

### Owns
- universe-linked market-state truth
- live tick reality check
- session-schedule use for recheck timing
- synchronization awareness for newly discovered symbols
- next open/closed recheck scheduling
- compact Layer 1 publication blocks
- boot confirmation rechecks for unresolved symbols

### Does not own
- open-symbol packets
- candidate filtering
- shortlist competition
- deep selective analysis
- broad dossier compose waves

### Runtime law
- live tick evidence first
- broker session schedule second
- restored persisted state as support only
- closed symbols do not get pointless fast checks forever
- boot may use up to 3 confirmation rechecks for unresolved/opening cases
- later maintenance is schedule-driven and calmer

### Layer 1 warmup and readiness law
- boot and recovery enter `ASC_RUNTIME_WARMUP` until a minimum Layer 1 readiness threshold is met
- warmup readiness is computed from current Layer 1 truth only
- readiness requires a configured minimum share of first-pass assessments plus coverage of the compressed priority-set-1 buckets
- prepared explorer hydration is not the warmup exit key
- once Layer 1 readiness is met, runtime may admit later layers even if lower-priority symbols still await non-Layer-1 work

## Capability 2 — Open Symbol Snapshot

### Purpose
Capture a controlled packet of current open-symbol truth without widening into later-layer compute.

### Owns
- Layer 2 packet fields for open symbols
- current bid/ask/spread/day-range/static tradability fields
- last-good continuity for Layer 2-owned fields
- focus-safe fast packet reads for the currently focused symbol only
- honest ineligible/degraded wording when Layer 2 cannot refresh

### Does not own
- market-state truth ownership
- whole-universe fast refresh loops
- candidate filtering
- shortlist competition
- deep selective analysis
- blanket fast refresh of all open symbols because the HUD is open

### Activation posture
- runs only after Layer 1 truth exists for the symbol
- background Layer 2 cadence stays bounded and selective
- focused-symbol live paint may elevate only display reads for that symbol

## Capability 3 — Candidate Filtering

### Purpose
Reduce the open universe to symbols worth further attention using cheap checks only.

### Owns
- validity gate
- cheap tradability gate
- cheap characterization
- explicit gate-result publication, reason codes, and filter-evaluated timestamps
- main-bucket assignment for survivors

### Does not own
- ranking
- score composition
- heavy history work
- shortlist authority
- HUD-side bucket rebuilding

### Doctrine
Layer 3 consumes only Layer 1 and Layer 2 truth.
It may use market-open status, tick continuity, snapshot continuity, packet sanity, cheap tradability gates, and bounded spread normalization context.
It must not rank, score, infer direction, or act as a proxy shortlist engine.

## Capability 4 — Shortlist Selection

### Purpose
Choose the bounded operator set from Layer 3 survivors.

### Owns
- main-bucket competition
- top-5-per-main-bucket authority
- spill/fill rule when a bucket has fewer than 5 valid members
- anti-churn and hold-window controls
- final selected-set authority for Layer 5 entry
- shortlist publication and operator-facing shortlist surfaces

### Does not own
- broad discovery
- blanket focus permission to recompute every candidate on redraw
- deep-analysis math itself

### Doctrine
Layer 4 is no longer just a generic shortlist cap surface.
It owns the promoted operator set.
That means:
- top 5 per main bucket
- stable competition rules
- calm-down behavior after selection
- minimum hold window before churny replacement

## Capability 5 — Deep Selective Analysis

### Purpose
Maintain high-detail rolling analytics only for the final selected set from Shortlist Selection.

### Owns
- rank-sensitive refresh cadence for the promoted set
- deeper history/timeframe packets for promoted symbols only
- deep-analysis publication blocks
- future stat-detail focus elevation for deep-analysis-owned fields only

### Rank-sensitive cadence law
Default promoted-set cadence:
- rank 1 = every 5 seconds
- rank 2 = every 10 seconds
- rank 3 = every 15 seconds
- rank 4 = every 20 seconds
- rank 5 = every 25 seconds

These cadences apply only to the current promoted set and sit under dispatcher admission.

### Does not own
- broad-universe scanning
- cheap first-pass filtering
- permission for HUD redraws to trigger history pulls directly

## Focus law

Focused exploration is not a separate capability.
It is a bounded runtime request that each capability may honor only for fields it already owns.
That means:
- Market State Detection may only elevate market-state-owned fields
- Open Symbol Snapshot may elevate the focused symbol’s packet-owned fields
- Candidate Filtering may elevate only its own gate visibility
- Shortlist Selection may elevate only shortlist-owned views
- Deep Selective Analysis may elevate only deep fields for already selected symbols

Focus does not authorize inactive downstream work early.
