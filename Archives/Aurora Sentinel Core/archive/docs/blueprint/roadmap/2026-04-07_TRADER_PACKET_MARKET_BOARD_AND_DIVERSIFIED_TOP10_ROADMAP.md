# Trader Packet, Market Board, and Diversified Top 10 Roadmap

## Status

This document is a **roadmap / proposed upgrade plan** for the next upgrade lane after the initial L3-L5 scoring/ranking/deep-intelligence passes.
It does **not** silently override current live doctrine.
It defines what should be upgraded next so the system becomes cleaner, stronger, and more useful for the operator's trader-chat workflow.

## Why this roadmap exists

The current system has already moved toward:
- Layer 3 score-pack carry
- Layer 4 ranking-first shortlist authority
- Layer 5 richer selected-symbol deep intelligence
- consumer integration across HUD / dossier / Market Board

That work was directionally correct, but the operator requirements have now sharpened further.
The next upgrade lane must solve three things together:

1. **The trader-chat decision packet must become cleaner and more powerful**
2. **The Market Board must become the real operator trade-picking board**
3. **The Top 10 overall must diversify away from high-correlation clustering**

Additionally, the operator has clarified an important presentation rule:
- broker metadata and account data must remain present
- but they should live **mostly on the Market Board**, not be sprayed equally across every operator-facing surface

---

## Final intended product posture

After this roadmap is complete, the system should feel like this:

- **Layer 2** remains raw broker / packet / spec / session truth only
- **Layer 3** adds the cheap tactical derived fields needed for intraday/scalp analysis
- **Layer 4** uses those fields to rank attention and produce stronger shortlist / bucket rankings
- **Layer 5** becomes the rich selected-symbol trader packet when Deep Analysis is used
- **Market Board** becomes the central trade-picking board for the operator
- **Dossier** remains the canonical symbol intelligence file, but cleaner and more trader-chat compatible
- **Current Focus** remains the selected-symbol deep packet duplicate for fast recall

This roadmap is therefore about **product refinement plus field refinement**, not another giant architecture rewrite.

---

## Non-negotiable rules

### Rule 1 - broker/account truth stays present
Broker metadata, account context, and execution-reality context are not optional.
They remain part of the product.

But they should now live **primarily on the Market Board**, because that is where the operator decides what is tradable now while staying aware of:
- current exposure
- existing open trades
- pending orders
- account pressure
- concentration risk
- execution environment

### Rule 2 - Market Board becomes the operator battle board
The Market Board must no longer feel like a generic artifact summary.
It must become the **trade-picking board**.

That means it should quickly answer:
- what is strongest now?
- what is strongest per bucket?
- what is strongest overall without duplicating the same correlated trade idea?
- what is unsafe due to correlation, exposure, or friction?
- what deserves the next Layer 5 deep request?

### Rule 3 - Top 10 overall must be diversified
The Top 10 overall must no longer be a naive list of the 10 highest ranked symbols if that list collapses into highly correlated variants of the same idea.

The Top 10 overall should become a **diversified opportunity board**.
That means:
- high raw rank still matters
- but correlation concentration must actively influence membership
- the board should prefer breadth of opportunity over redundant clustering
- extreme same-direction, same-theme, high-correlation crowding must be reduced

### Rule 4 - numeric truth becomes primary
The trader-chat packet should become more numeric-first and delta-first.

Text labels still matter for operator readability, but the primary truth should increasingly be:
- scores
- deltas
- percentages
- shifts
- normalized positions
- now-vs-previous comparisons

### Rule 5 - no new final signal ownership
This roadmap does **not** move the scanner into trade execution or final signal authorship.
It remains scanner / ranking / intelligence infrastructure only.

### Rule 6 - no layer mixing
- Layer 2 = raw truth
- Layer 3 = cheap derived tactical fields
- Layer 4 = ranking / shortlist / diversified board authority
- Layer 5 = rich selected-symbol trader packet
- Market Board / dossier / HUD / Current Focus = consumer surfaces only

---

## Core upgrade objective

The next lane should produce a system where:

- the Market Board is the first place the operator looks
- the board is cleaner and more decision-oriented
- the board carries account/exposure/execution reality clearly
- the board carries smarter ranked opportunities clearly
- the overall Top 10 is correlation-aware and diversified
- the dossier and Current Focus expose a richer trader-chat packet without losing canonical truth
- the new trader-chat-required fields are added cleanly and lawfully

---

## Product split: two views of the same truth

The product should now be treated as two views of one intelligence stack.

## View A - Market Board / operator reality board
This is the board for:
- account state
- broker/server context
- open/pending exposure
- conflict awareness
- execution conditions
- diversified ranked opportunities
- deciding which symbol to inspect next

## View B - trader packet / selected-symbol deep packet
This is the sharper trader-chat-oriented packet for:
- pressure shift
- momentum acceleration
- move age / decay
- liquidity proximity
- participation score
- execution score
- burst detection
- selected-symbol deep tactical readback

The system should support both views without duplicating ownership or muddying layer boundaries.

---

## Required field upgrades

## A. Pressure shift family
The current system needs a stronger sense of **change over time**, not just static state.

Target additions:
- `tick_bias_now`
- `tick_bias_prev_window`
- `tick_shift`
- `pressure_shift_score`
- `pressure_shift_posture`

Purpose:
- distinguish pressure building vs pressure fading
- improve short-horizon scalp opportunity quality
- improve shortlist ranking quality
- improve Layer 5 decision packet usefulness

## B. Momentum acceleration family
The current system already has directional and score-posture carry, but it needs explicit speed-of-move carry.

Target additions:
- `momentum_delta`
- `momentum_speed`
- `momentum_acceleration_score`
- `momentum_acceleration_posture`

Purpose:
- distinguish accelerating continuation from tired continuation
- improve ranking and move quality interpretation

## C. Move age / decay family
The current system needs a better way to express whether a move is fresh or aging.

Target additions:
- `time_since_last_impulse`
- `impulse_count_window`
- `move_age_score`
- `move_age_posture`

Purpose:
- distinguish fresh burst setups from exhausted moves
- improve trader-chat timing quality

## D. Liquidity proximity family
Distance to high/low exists in partial form, but it needs to become cleaner and more normalized.

Target additions:
- `position_in_range_pct`
- `distance_to_recent_high`
- `distance_to_recent_low`
- `liquidity_proximity_score`
- `liquidity_zone`
- `liquidity_proximity_posture`

Purpose:
- improve fast decision readability
- distinguish chase / sweep / fade / wait contexts

## E. Participation family
The system currently uses descriptive participation language, but it needs stronger quantified carry.

Target additions:
- `participation_score`
- `participation_delta`
- `participation_posture`

Purpose:
- quantify whether a move has enough participation to matter
- improve shortlist ranking and execution confidence context

## F. Execution quality family
Execution realism should become cleaner and easier to use on the board.

Target additions:
- `execution_score`
- `execution_penalty`
- `execution_posture`
- `spread_quality_score`
- `friction_quality_score`
- `liquidity_quality_score`

Purpose:
- avoid promoting attractive but poorly tradable ideas
- strengthen Market Board decision quality

## G. Microstructure burst family
The system needs a more explicit burst detector.

Target additions:
- `tick_burst_flag`
- `tick_burst_score`
- `tick_burst_posture`

Purpose:
- identify moments where short-horizon opportunity quality is truly alive

---

## Timeframe hierarchy revision

The system must stop treating all timeframes like equal-weight clutter.

Target hierarchy:
- **Trigger layer:** M1 + M5
- **Setup layer:** M15
- **Context layer:** H1
- **Extended context only when useful:** H4

This hierarchy should affect:
- Layer 3 tactical field construction
- Layer 4 shortlist ranking
- Layer 5 deep packet presentation
- Market Board summaries
- dossier summaries where appropriate

The goal is to make trader-chat interpretation faster and cleaner.

---

## Market Board revision plan

## Market Board mission after revision
The Market Board should become the central operator board for trade picking.

It should present three major zones clearly.

### Zone 1 - Environment / account / execution reality
This zone should carry:
- server / broker identity
- account snapshot
- open trades
- pending orders
- current exposure
- concentration notes
- execution environment / tradability notes
- conflicts already in force

This is where broker/account truth should mostly live.

### Zone 2 - Ranked opportunity board
This zone should carry:
- diversified Top 10 overall
- Top 5 per bucket
- clearer rank meaning
- setup-family meaning
- score stack
- execution quality
- participation quality
- liquidity proximity
- timing quality

This is the main symbol-selection zone.

### Zone 3 - Conflict / concentration / correlation control
This zone should carry:
- correlation clustering warnings
- exposure overlap warnings
- same-theme crowding notes
- execution friction warnings
- stale/fading move warnings

This zone explains why a symbol may be strong but still not deserve inclusion in the diversified Top 10.

---

## Diversified Top 10 overall revision

## Current issue
The Top 10 overall currently risks becoming a list of strongly ranked but highly correlated symbols.
For the operator, that is weaker than a board with broader opportunity diversity.

## New Top 10 principle
The Top 10 overall should become:

**the strongest diversified board of active opportunities, not merely the ten highest raw ranks.**

## New Top 10 selection model
The new Top 10 overall should be built using at least these factors:
- raw Layer 4 rank / shortlist score
- setup-family strength
- execution quality
- participation quality
- timing quality
- correlation concentration penalty
- same-bucket clustering control where appropriate
- exposure conflict awareness

## Diversification rules
The exact formula may evolve, but the board should enforce ideas like:
- avoid admitting multiple near-identical high-correlation symbols when one materially dominates the cluster
- reduce score or admission priority for redundant cluster followers
- prefer the strongest representative of a highly correlated cluster
- allow a second correlated symbol only when its independent score remains strong enough and clustering is still acceptable
- avoid same-theme saturation that makes the Top 10 less useful to the operator

## Example target behavior
If several Forex majors are all strongly correlated and expressing nearly the same directional theme:
- the board should prefer the strongest representatives
- weaker copies should sink out of the diversified Top 10
- those names may still remain strong inside their bucket Top 5

This distinction matters:
- **Top 5 per bucket** = strong within the bucket
- **Top 10 overall** = strongest diversified board across the whole market

That means the Top 10 overall should not simply mirror bucket leaders without correlation control.

---

## Dossier revision plan

The dossier should remain the canonical intelligence file.
But it needs to become cleaner and more compatible with the trader-chat packet style.

## Dossier goals after revision
- preserve canonical truth
- remain rich and verifiable
- reduce gate-heavy phrasing where newer score-first phrasing is more accurate
- expose score/delta/shift/participation/execution context more cleanly
- make Layer 5 deep packet more readable for tactical review

## Dossier L3 revision
Layer 3 dossier sections should shift from strongly gate-report language toward:
- score posture
- attention posture
- friction posture
- current weakness summary
- current strength summary
- next-needed evidence only where still truly relevant

## Dossier L4 revision
Layer 4 dossier sections should more clearly show:
- why the symbol is ranked where it is
- whether it is in bucket top-5
- whether it is in diversified Top 10 overall
- whether it was penalized by correlation concentration
- how stability/hold logic affected it

## Dossier L5 revision
Layer 5 dossier sections should become more explicitly trader-packet friendly:
- trigger layer view
- setup layer view
- context layer view
- tactical snapshot
- pressure shift
- momentum acceleration
- move age
- liquidity proximity
- participation
- execution quality
- burst posture

The dossier remains the canonical source, but it should become easier to read as a professional decision packet.

---

## Current Focus revision plan

Current Focus remains the selected-symbol duplicate of the rich Layer 5 packet.

The next upgrade lane should ensure:
- Current Focus projects the cleaner trader packet
- Current Focus includes the sharper decision packet summary
- Current Focus remains atomic and selected-symbol lawful
- repeated Deep Analysis refresh keeps Current Focus aligned

Current Focus should feel like:
- the active tactical packet
- not just a deep artifact clone with generic prose

---

## Layer ownership plan for this lane

## Layer 2
Still owns raw truth only:
- broker / packet / spec / session / account-adjacent raw carry where already lawful
- no derived trader scoring ownership

## Layer 3
Adds the new cheap tactical derived fields:
- pressure shift
- momentum acceleration
- move age
- liquidity proximity
- participation score
- execution score
- burst detection

Layer 3 remains cheap and broad.

## Layer 4
Uses those fields to improve:
- shortlist ranking
- bucket ranking
- diversified Top 10 overall membership
- anti-cluster correlation-aware overall board selection

## Layer 5
Uses the richer fields to produce the selected-symbol trader packet:
- clearer trigger/setup/context hierarchy
- cleaner deep packet summaries
- better tactical readback

---

## Implementation sequence

## Phase 0 - product contract revision
Before heavy code changes, define the product contracts clearly:
- what Market Board must show
- what dossier must show
- what Current Focus must show
- what Top 10 overall means
- what Top 5 per bucket means
- how correlation-aware overall selection differs from bucket-local ranking

## Phase 1 - Layer 3 field upgrade
Add the new cheap tactical derived families:
- pressure shift
- momentum acceleration
- move age
- liquidity proximity
- participation
- execution score
- burst detection

These must be producer-owned and compile-safe.

## Phase 2 - Layer 4 diversified ranking revision
Revise Layer 4 so it can build:
- bucket rankings as before
- diversified Top 10 overall as a separate overall board authority
- correlation concentration penalties / cluster control
- stronger reasoning for overall-board inclusion or exclusion

## Phase 3 - Market Board revision
Revise the Market Board layout and output:
- account/broker/execution zone
- diversified Top 10 overall zone
- Top 5 per bucket zones
- correlation/conflict zone
- cleaner symbol rows
- more numeric-first presentation

## Phase 4 - Dossier revision
Revise dossier sections so they reflect the new cleaner trader packet and the diversified board meaning.

## Phase 5 - Current Focus / Layer 5 readback refinement
Refine the selected-symbol packet so it becomes cleaner and more useful for trader-chat interpretation.

## Phase 6 - calibration and pruning
After runtime review:
- remove dead wording
- remove fields that add no ranking value
- tighten correlation-control behavior for Top 10 overall
- keep only the clearest, highest-value trader packet fields

---

## Practical output targets

After this roadmap, the operator should be able to:

### On Market Board
- see account reality quickly
- see diversified strongest overall opportunities quickly
- see top opportunities per bucket quickly
- avoid loading the Top 10 with correlation duplicates
- identify the best next symbol for deep review quickly

### In dossier
- understand why a symbol ranks where it does
- understand whether it missed Top 10 overall due to correlation concentration
- understand selected-symbol tactical quality more clearly

### In Current Focus
- read the selected-symbol trader packet fast
- understand pressure, acceleration, move age, liquidity, participation, execution, and burst posture clearly

---

## Final target state

When this roadmap is complete:

- Market Board becomes the operator trade-picking board
- broker/account data lives there prominently
- Top 5 per bucket remains strong and bucket-local
- Top 10 overall becomes diversified and correlation-aware
- dossier remains canonical but becomes cleaner and sharper
- Current Focus becomes the crisp active trader packet
- Layers 3-5 become more useful for trader-chat style analysis without becoming a final signal engine

That is the next intended upgrade path.
