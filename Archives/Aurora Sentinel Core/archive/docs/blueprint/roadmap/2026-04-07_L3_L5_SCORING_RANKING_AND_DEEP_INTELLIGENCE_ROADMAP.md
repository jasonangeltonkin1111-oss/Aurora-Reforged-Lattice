# L3-L5 Scoring, Ranking, and Deep Intelligence Roadmap

## Status

This document is a **roadmap / proposed doctrine revision** for the scanner-intelligence stack.
It does **not** silently override current live doctrine.
It exists to define a clean upgrade path from the current Layer 3 gate-heavy posture toward a **scoring-first, ranking-first, selected-symbol-deepening** posture that matches the operator's current intraday/scalp requirements.

## Purpose

The operator requirement has changed in a specific way:

- no new market-intelligence blocking gates
- no new trade-opportunity hard-fail logic inside Layers 3-5
- ranking is allowed
- scoring is allowed
- top-5-per-bucket selection must become smarter and richer
- Layer 5 must become the rich per-symbol intelligence surface when Deep Analysis is pressed
- Layer 2 must remain clean and must not absorb Layer 3-5 ownership

This roadmap therefore redefines the upgrade target as:

**ASC remains a truth-producing scanner, but Layers 3-5 move from hard gate emphasis toward scored opportunity interpretation, ranked attention allocation, and selected-symbol deep intelligence.**

---

## Non-negotiable upgrade rules

### Rule 1 - no new blocking logic in market intelligence
Layers 3-5 must not be widened into new hard-fail or hard-block decision logic.
Raw truth may still expose weak conditions, dead conditions, bad friction, poor timing, low energy, or stale opportunity quality.
But those conditions become **score penalties, posture reductions, and ranking consequences**, not new trade-opportunity veto systems.

### Rule 2 - ranking is the selection mechanism
The shortlist should become smarter by ranking richer opportunity context rather than by widening hard filters.
The practical result is:
- weaker symbols naturally sink
- stronger symbols naturally rise
- top-5-per-bucket becomes score-led
- stale / dead / high-friction names can remain visible but score poorly

### Rule 3 - Layer 2 stays pure
Layer 2 remains the bounded owner of broker / packet / snapshot / session / spec truth only.
It may continue to own raw observables already inside Layer 2 law, such as:
- bid / ask / spread
- spread percentage
- tick age / packet freshness
- day-range packet carry
- session carry
- contract / permissions / volume / margin / swap carry

Layer 2 must **not** absorb:
- structure interpretation
- liquidity interpretation
- regime classification
- setup classification
- opportunity scoring
- shortlist ranking logic
- deep-analysis interpretation

All derived intelligence begins in Layer 3 or later.

### Rule 4 - Layer 5 becomes the rich selected-symbol engine
When the operator presses Deep Analysis, Layer 5 must become the selected symbol's rich intelligence owner.
That means:
- every Deep Analysis press can request a fresh deep refresh cycle
- deep output cannot behave like a one-time static write
- Current Focus must remain selected-symbol lawful
- Current Focus must refresh atomically for the active selected symbol only
- the HUD must show richer live tactical state while remaining consumer-only

### Rule 5 - no layer mixing
- Layer 3 owns scored candidate interpretation
- Layer 4 owns ranking / shortlist / top-5-per-bucket selection
- Layer 5 owns rich deep selected-symbol intelligence

No layer may casually absorb the next layer's job just because nearby fields already exist.

---

## Target layer model after revision

## Layer 2 - unchanged ownership boundary
Layer 2 remains the upstream raw-truth packet family.
Its job is to provide clean current-state observables for downstream consumption.

Layer 2 remains limited to:
- quote truth
- packet freshness truth
- day-structure raw packet truth
- broker trading conditions / permissions / contract truth
- sessions / swap / margin truth

Layer 2 may expose more raw carry fields if they are still raw and observable.
It must not become the owner of derived trade-opportunity interpretation.

## Layer 3 - candidate scoring engine
Layer 3 is revised from a gate-centric posture into a **candidate scoring and context synthesis layer**.
It still consumes earlier truth cheaply and broadly, but its downstream effect becomes score-driven rather than block-driven.

Layer 3 should own:
- score components
- low-cost derived opportunity fields
- machine-readable setup context
- attention posture
- score penalties
- candidate context summaries
- per-symbol score snapshots for shortlist use

Layer 3 should stop trying to become a hard blocker for intraday opportunity quality.
Instead, it should answer:
- how alive is this symbol right now?
- how usable is the current motion?
- how strong is current short-horizon pressure?
- how attractive is the symbol versus peers?

### Layer 3 feature families
Layer 3 should compute the following scored families from Layer 1 + Layer 2 truth:

1. **Price engine score family**
   - recent log returns
   - momentum 5 / 10 / 20
   - short-horizon directional consistency
   - acceleration / deceleration posture

2. **Microstructure score family**
   - tick count window
   - uptick / downtick balance
   - buy-pressure proxy
   - sell-pressure proxy
   - tick-speed posture
   - spread-change posture

3. **Volatility transition score family**
   - ATR relative posture
   - ATR baseline ratio
   - compression / expansion / spike state
   - tradable-burst probability posture

4. **Structure score family**
   - swing high / low context
   - break-of-structure posture
   - higher-high / lower-low posture
   - range / transition / directional posture
   - distance to relevant structural levels

5. **Liquidity score family**
   - recent high / low proximity
   - session high / low proximity
   - sweep / reclaim posture
   - rejection-cluster proximity

6. **Session and time-context score family**
   - Asia / London / New York posture
   - minutes since session open
   - overlap posture
   - session expansion timing posture

7. **Execution friction score family**
   - spread penalty
   - spread-percent penalty
   - slippage-risk proxy penalty
   - low-liquidity penalty

### Layer 3 outputs
Layer 3 should publish:
- `candidate_score_total`
- `price_engine_score`
- `microstructure_score`
- `volatility_score`
- `structure_score`
- `liquidity_score`
- `session_score`
- `friction_penalty`
- `attention_posture`
- `setup_family_bias` (continuation / breakout-build / reversal / rotation / weak)
- short operator-safe summary text

### Layer 3 implementation rule
Layer 3 remains cheap and broad.
It may summarize and score.
It must not become deep-history heavy.
It must not become the final signal engine.

---

## Layer 4 - shortlist ranking and top-5-per-bucket revision
Layer 4 becomes the ranking authority.
It should consume Layer 3 score packs and turn them into cleaner shortlist selection truth.

Layer 4 should own:
- rank ordering
- bucket-local ranking
- global ranking carry
- top-5-per-bucket selection
- shortlist stability / anti-churn logic
- score-led hold behavior
- correlation / exposure context for shortlist display

### Core revision
The shortlist should no longer feel like a narrow survivor list driven by gate posture.
It should feel like a **ranked opportunity board** driven by scored context.

### Layer 4 target scoring model
Layer 4 should build at least these ranking views:
- `composite_rank_score`
- `continuation_rank_score`
- `breakout_rank_score`
- `reversal_rank_score`
- `opportunity_quality_score`

The main shortlist can still publish one canonical rank, but it should be derived from a richer ranking spine rather than a crude pass/fail survivor list.

### Top-5-per-bucket revision
Per bucket, Layer 4 should maintain:
- rank 1-5 overall within bucket
- score spacing between members
- setup-family tag per member
- friction-aware ranking carry
- session-aware ranking carry
- structural and liquidity context carry

That means the visible top-5-per-bucket becomes materially more useful to a downstream analyzer.

### Layer 4 stability model
Anti-churn remains allowed, but it should now be score-led.
Examples:
- hysteresis between near-equal ranks
- hold behavior when score deltas are tiny
- stability posture based on score persistence, not blunt gating

### Layer 4 outputs
Layer 4 should publish:
- canonical shortlist rank
- bucket rank
- composite rank score
- setup-family label
- score breakdown summary
- stability / hold posture
- shortlist reason rewritten in scoring language
- promotion context in attention-priority language

---

## Layer 5 - deep selected-symbol intelligence
Layer 5 becomes the rich per-symbol intelligence lane for the currently selected symbol when Deep Analysis is explicitly triggered.

### Core doctrine after revision
Layer 5 remains explicit-trigger and selected-symbol lawful.
But once armed, it becomes the owner of rich intraday intelligence for that symbol.

### Layer 5 must provide
1. **Deep Analysis refresh on every press**
   - pressing Deep Analysis again must request a fresh deep run
   - repeated use must refresh current symbol intelligence, not only replay old output

2. **Rich timeframe intelligence**
   For M1, M5, M15, H1:
   - compact OHLC packs
   - recent return structure
   - momentum stacks
   - volatility posture
   - regime posture
   - structure posture
   - liquidity-zone relation

3. **Deep microstructure block**
   - short-window tick activity
   - buy/sell pressure proxy
   - tick-speed shifts
   - spread-roll behavior
   - burst / fade posture

4. **Deep structure block**
   - live swing map
   - BOS posture
   - nearest break levels
   - distance-to-targetable liquidity
   - continuation vs rejection posture

5. **Deep session and timing block**
   - current session
   - minutes since session open
   - expansion window posture
   - timing quality for scalp / intraday use

6. **Deep scoring block**
   - deep continuation score
   - deep breakout score
   - deep reversal score
   - friction-adjusted opportunity score
   - score explanation text

7. **Deep analyst handoff block**
   Layer 5 still stops short of final signal ownership.
   But it should hand downstream analysis a rich machine-readable packet for trade interpretation.

### Layer 5 Current Focus law
Layer 5 deep output must duplicate lawfully into Current Focus for the selected symbol only.
That duplication must remain:
- atomic
- pair-safe
- selected-symbol-correct
- refreshable
- non-hijackable by unrelated symbols

### Layer 5 HUD law
The HUD remains consumer-only, but it should show faster tactical refresh of:
- bid
- ask
- spread
- tick freshness
- deep status
- current-focus alignment status
- latest deep score posture

---

## Field ownership map

### Raw observable carry - Layer 2
- bid / ask / spread / spread %
- tick age / packet age / freshness
- day high / low / open / range
- session status / hours
- contract / permissions / margin / swap

### Cheap derived opportunity fields - Layer 3
- momentum
- log returns
- tick-pressure proxies
- volatility transition states
- structure distances
- liquidity distances
- session timing posture
- friction penalties
- component scores

### Ranked attention truth - Layer 4
- shortlist ordering
- bucket ordering
- top-5-per-bucket truth
- stability / hold posture
- composite ranking outputs

### Rich selected-symbol intelligence - Layer 5
- multi-timeframe deep packet
- deep score family
- deep structure / liquidity / timing context
- current-focus deep duplication
- repeated deep refresh service

---

## Implementation roadmap

## Phase 0 - doctrine and contract revision
Write the field contracts first.
The core change is conceptual:
- move L3 language from gate-heavy to score-heavy
- move L4 language from survivor-list to rank-authority
- move L5 language from scaffold-only posture toward rich selected-symbol deep intelligence

## Phase 1 - Layer 3 score-pack build
Target files will likely include candidate-filtering and runtime score-carry owners.
Build:
- component score fields
- friction penalties
- setup-family posture
- attention posture
- operator-safe summaries

## Phase 2 - Layer 4 shortlist revision
Revise shortlist ranking to consume Layer 3 score packs.
Implement:
- bucket top-5 rank spine
- composite ranking formula
- setup-family carry
- score-led hold behavior

## Phase 3 - Layer 5 deep packet expansion
Build the rich deep packet for selected-symbol use.
Implement:
- multi-timeframe deep fields
- deep scoring families
- deep structure / liquidity / session interpretation
- richer analyst handoff block

## Phase 4 - Current Focus and repeated Deep Analysis refresh
Implement:
- repeat-press refresh behavior
- selected-symbol-only atomic pair refresh
- deep/current-focus alignment proofs
- non-hijack selected-symbol refresh law

## Phase 5 - HUD and artifact consumption
Consumer surfaces should be updated to read the new truth, not invent local substitutes.
Targets likely include:
- HUD
- Current Focus writer
- dossier writers
- Market Board / shortlist summaries where admitted

## Phase 6 - score calibration and pruning
After real runtime review:
- prune dead fields
- tighten weights
- remove noisy score families
- keep only fields that materially improve ranking quality

---

## Practical file-impact expectation

The roadmap implies likely future changes in these areas:
- `mt5/candidate_filtering/*`
- `mt5/shortlist_selection/*`
- `mt5/deep_selective_analysis/*`
- `mt5/runtime/*`
- `mt5/hud/*`
- `mt5/artifacts/*`
- selected blueprint / roadmap docs describing Layers 3-5

Layer 2 files should only change where raw field carry needs to be stabilized or exposed more cleanly.
They must not be used to smuggle in Layer 3-5 ownership.

---

## Final target state

When this roadmap is complete, ASC should behave like this:

- Layer 2 tells the truth about what the broker and packet currently say.
- Layer 3 turns that truth into scored intraday opportunity context.
- Layer 4 ranks symbols cleanly and produces a stronger top-5-per-bucket shortlist.
- Layer 5 gives the selected symbol a rich deep intelligence packet every time Deep Analysis is used.
- Current Focus stays lawful, atomic, selected-symbol-only, and refreshable.
- The HUD remains consumer-only but feels materially more alive and useful for tactical review.

That is the intended upgrade path.
It keeps the layers clean.
It avoids new gates.
It makes scoring and ranking the selection language.
And it makes Deep Analysis the rich symbol-intelligence surface the operator actually wants.
