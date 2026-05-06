# ASC EA Menu and Settings Contract

**Canonical contract path:** `blueprint/final/ASC_MENU_AND_SETTINGS_CONTRACT.md`  
**Canonical path lock:** Treat this filename/path as locked; do not create or reference alternate menu/settings contract filenames.

## Purpose

This file freezes the lawful trader control surface for Aurora Sentinel Scanner (ASC).

Stage 3 completes the control doctrine for:
- canonical menu sections
- trader-safe vs dangerous vs disabled controls
- Deep Analysis service configuration
- timeframe enablement and bars-per-timeframe rules
- ATR / spread / tick window controls
- analyst-facing output modes
- explicit forbidden menu powers

This contract exists so future work cannot use the menu/settings surface as a backdoor around layer ownership.

---

## Stage 3 doctrine tier lock

### Hard law
The menu/settings surface:
- is a configuration surface only
- is subordinate to `blueprint/final/`
- may configure service scope and consumer output only within already lawful ownership
- must never grant ASC signal-engine powers
- must never move truth birth from the owning layer into the menu, HUD, or writer layer

### Required product contract
The product must expose:
- one canonical section model
- a safety class for every control
- explicit control ownership and non-ownership
- inspectable Deep Analysis completeness posture
- inspectable bars/timeframes/ATR/spread/tick configuration posture in analyst-facing artifacts

### Future expansion option
Later work may add:
- more timeframe families only by blueprint update
- more optional analyst-facing blocks
- richer presets and templates
- per-broker or per-asset profile bundles

Future expansion may not violate Hard Law.

---

## Core law

### Settings are control surfaces, not hidden architecture
Controls may change bounded runtime behavior and analyst-facing projection.
They may not redefine layer ownership, signal ownership, publication authorship, or admissibility law.

### No hidden constants drift
Every admitted operator control must map to:
- one named field
- one named enum/profile
- one explicit runtime or publication behavior

No module-local literal may silently override an active operator setting.

### Operator wording over developer wording
Menu labels must use operator-safe product language.
Raw engine terms are forbidden outside diagnostics-only surfaces.

### Safety classes are mandatory
Every control must be classified as exactly one of:
- `safe_runtime` — may be changed during active runtime without violating law
- `dangerous_reconfigure` — materially changes service/resource/comparability posture and must be pause/restart/freeze-gated
- `future_disabled` — visible only as a disabled planned control with explicit `not active` wording
- `system_owned` — observed truth or engine internals; never a trader input

### Menu is subordinate to blueprint law
If a proposed control conflicts with any active blueprint law, the control is invalid until blueprint law is changed first.

---

## Canonical menu section model (locked)

All operator-facing controls must live under exactly one of these sections.

1. HUD & Display  
2. Market Board  
3. Current Focus  
4. Dossier  
5. Market State  
6. Open Symbol Snapshot  
7. Selection Filter  
8. Shortlist Context  
9. Deep Analysis  
10. Advanced Controls  
11. Reserved / Future Scaffolds  

No extra section family is admissible without blueprint update.

---

## Section ownership and anti-drift rules

### 1) HUD & Display
**For**
- layout density
- source-badge visibility
- stale/degraded/continuity warning visibility
- page grouping and presentation preferences

**Must never control**
- layer cadence rights
- write ownership
- shortlist membership
- Deep Analysis entitlement
- signal issuance

**Default safety class**
- mostly `safe_runtime`
- any attempt to hide mandatory warnings is invalid, not merely dangerous

### 2) Market Board
**For**
- compact board presentation preferences
- row-count/display limits for already-published rows
- optional board columns that are already lawfully published
- grouping/sorting of already-landed board truth

**Must never control**
- board write cadence
- shortlist authority
- deep payload creation
- force-add / force-promote behavior
- any signal dashboard behavior

**Default safety class**
- display-only controls are `safe_runtime`
- any write-affecting board control is `dangerous_reconfigure` or non-admissible

### 3) Current Focus
**For**
- selected-symbol working-view presentation
- optional visibility of already-owned deep posture blocks
- compact vs full selected-symbol analyst brief projection

**Must never control**
- selected-symbol pinning outside lawful symbol-selection rules
- dossier write ownership
- non-promoted Deep Analysis entitlement
- signal verdicts

### 4) Dossier
**For**
- analyst-facing dossier output mode
- optional block visibility for already-owned fields
- printed OHLC depth limit within the configured maximum
- compact vs evidence-pack projection

**Must never control**
- dossier truth birth
- persistence ordering
- hidden section suppression for mandatory state metadata
- directional or execution conclusions

### 5) Market State
**For**
- bounded operator controls already admitted by Layer 1 law
- display/profile settings for market-state visibility
- lawful timing profiles already permitted by Layer 1 contracts

**Must never control**
- fabricated market-open truth
- suppression of degraded/stale posture
- signal ownership

### 6) Open Symbol Snapshot
**For**
- selected-symbol tactical display preferences
- tactical field visibility
- lawful selected-symbol snapshot cadence profiles already admitted elsewhere

**Must never control**
- global tactical widening to all symbols
- structural commit ownership
- hidden per-symbol execution logic

### 7) Selection Filter
**For**
- bounded threshold/profile controls already declared by filter doctrine
- enable/disable of optional filter families already made lawful elsewhere

**Must never control**
- new scoring math invented only in the menu
- bypass promotion
- hidden signal-quality scoring
- final trade suitability verdicts

### 8) Shortlist Context
**For**
- shortlist-context display density
- context block visibility for already-published shortlist summaries
- compact regime / ATR / correlation summary visibility where already lawfully published

**Must never control**
- shortlist membership authority
- promotion ranking ownership
- hidden weighting overrides
- deep-analysis scope widening

### 9) Deep Analysis
**For**
- lawful Layer 5 service configuration
- timeframe enablement
- bars-per-timeframe targets
- ATR / spread / tick controls
- analyst-facing deep output mode

**Must never control**
- promotion admission
- final trade direction
- execution verdict
- order placement
- global always-on deep scanning
- hidden signal-engine behavior

### 10) Advanced Controls
**For**
- bounded resource and governor-adjacent controls already admitted by runtime law
- guarded budgets and ceilings
- rare operator reconfiguration with explicit safety labeling

**Must never control**
- ownership jumps
- silent write-path rewiring
- signal issuance
- hidden layer bypasses

### 11) Reserved / Future Scaffolds
**For**
- disabled placeholders only

**Must never control**
- any active runtime behavior
- any implied ownership grant

---

## Deep Analysis control contract (Stage 3 completion)

Deep Analysis controls are lawful **service configuration** only.
They configure how Layer 5 attempts promoted-symbol enrichment.
They do **not** change scanner signal ownership, shortlist authority, or SIAM ownership.

### A. Canonical timeframe list (locked)
The canonical Deep Analysis timeframe set is:

- `M1`
- `M5`
- `M15`
- `H1`
- `H4`
- `D1`

Custom ad hoc timeframe names or arbitrary broker-specific sets are not admissible in Stage 3.
A future blueprint pass may widen the list explicitly.

### B. Timeframe enablement contract
Each canonical timeframe must have an explicit enable/disable control.

Required controls:
- `deep_tf_m1_enabled`
- `deep_tf_m5_enabled`
- `deep_tf_m15_enabled`
- `deep_tf_h1_enabled`
- `deep_tf_h4_enabled`
- `deep_tf_d1_enabled`

Law:
- enablement changes affect only Layer 5 service scope
- disabled timeframes are lawful and must be published as `not_enabled`
- partial timeframe completion is lawful when some enabled timeframes complete and others do not
- enabled timeframes are **best-effort with explicit sufficiency posture**, not silent all-or-nothing magic
- a timeframe is not valid merely because it is enabled; it must still satisfy bar sufficiency rules
- disabling a timeframe must not retroactively imply that earlier-layer scanner truth changed

Safety class:
- normal enable/disable = `safe_runtime`
- changing the canonical timeframe list itself = not admissible in menu; blueprint-only

### C. Bars-per-timeframe contract
Each enabled timeframe must define:
- `bars_requested`
- `minimum_bars_required`
- `bars_copied`
- `bars_missing`
- `sufficiency_posture`

Required controls:
- `deep_bars_m1_requested`
- `deep_bars_m5_requested`
- `deep_bars_m15_requested`
- `deep_bars_h1_requested`
- `deep_bars_h4_requested`
- `deep_bars_d1_requested`

Related floor controls or profiles:
- either one shared minimum-bars policy profile or explicit per-timeframe minimum fields
- Stage 3 admits explicit per-timeframe minimum fields in doctrine when needed for inspectability

Law:
- `bars_requested` is the operator target
- `minimum_bars_required` is the doctrinal floor for validity
- `bars_copied` is the actual retrieved count
- `bars_missing = max(0, bars_requested - bars_copied)` for publication purposes
- `sufficiency_posture` must be one of:
  - `not_enabled`
  - `pending`
  - `sufficient`
  - `degraded_but_publishable`
  - `insufficient_invalid`
  - `unavailable`
- if `bars_copied >= minimum_bars_required`, publication may be lawful even when fewer than requested bars were copied; this is `degraded_but_publishable` unless the service defines it as fully sufficient
- if `bars_copied < minimum_bars_required`, that timeframe block is `insufficient_invalid`
- a symbol-level Deep Analysis artifact may still publish with mixed timeframe posture as long as invalid or missing timeframe blocks are explicit
- no timeframe block may silently appear complete when bar sufficiency failed

Safety class:
- within declared ceilings = `safe_runtime`
- raising requested bars beyond governor-safe ceilings = `dangerous_reconfigure`

### D. Missing bars and completion law
Missingness must be classified explicitly.

Publication-safe missingness:
- timeframe disabled by operator
- symbol/timeframe pending fetch
- requested bars unavailable but minimum sufficiency still met
- broker history gap acknowledged with degraded posture

Invalid completion:
- enabled timeframe published without copied-count disclosure
- enabled timeframe published as normal when below minimum bars
- silent substitution from another timeframe
- silent carry-forward of old OHLC block without continuity labeling

### E. ATR control contract
Required controls:
- `deep_atr_enabled`
- `deep_atr_period`
- `deep_atr_scope_mode` = `shared` or `per_timeframe`

Optional per-timeframe fields if `per_timeframe` is admitted in implementation:
- `deep_atr_period_m1`
- `deep_atr_period_m5`
- `deep_atr_period_m15`
- `deep_atr_period_h1`
- `deep_atr_period_h4`
- `deep_atr_period_d1`

Law:
- ATR is a Deep Analysis enrichment control, not a signal engine
- Stage 3 permits shared ATR settings by default and per-timeframe ATR only when explicitly surfaced
- ATR may be optional for publication at symbol level
- if ATR is enabled for a timeframe and required input bars are insufficient, ATR posture must be explicit as `unavailable` or `insufficient`
- ATR absence must not invalidate all Deep Analysis unless a later contract explicitly marks ATR mandatory for a named output mode

Safety class:
- period changes within bounded range = `safe_runtime`
- scope-mode change affecting comparability = `dangerous_reconfigure`

### F. Spread control contract
Required controls:
- `deep_spread_enabled`
- `deep_spread_window_size`
- `deep_spread_min_samples`

Required spread output fields when enabled:
- `spread_samples_collected`
- `spread_min`
- `spread_max`
- `spread_mean`
- `spread_current`
- `spread_window_size`
- `spread_sufficiency_posture`

Law:
- spread controls configure rolling Layer 5 evidence only
- spread statistics are optional enrichment, not signal output
- if enabled but minimum samples are not met, publish as `degraded_but_publishable` or `unavailable` with explicit sample counts
- no spread block may imply stable live friction when the sample floor failed

### G. Tick control contract
Required controls:
- `deep_tick_enabled`
- `deep_tick_window_length`
- `deep_tick_min_samples`

Required tick output fields when enabled:
- `tick_samples_collected`
- `tick_window_length`
- `tick_last_seen_at`
- `tick_activity_summary`
- `tick_sufficiency_posture`

Law:
- tick controls configure recent-activity evidence only
- they do not create order-timing or trigger authority
- if tick data is incomplete, the block may publish only with explicit insufficiency/degraded posture
- incomplete tick windows must never be used to imply final entry timing ownership

### H. Analyst-facing output control contract
These controls are consumer-facing only.

Required controls:
- `deep_output_mode` = `full_evidence_pack` or `compact_analyst_brief`
- `deep_show_full_ohlc_bars`
- `deep_max_ohlc_bars_printed`
- `deep_show_atr_block`
- `deep_show_spread_stats`
- `deep_show_tick_stats`
- `deep_show_support_resistance_levels`
- `deep_show_scenario_block`
- `deep_show_handoff_block`

Law:
- output mode changes how Layer 5 truth is presented to analysts/traders
- output mode must never manufacture new truth or signal conclusions
- hiding a block is lawful only for optional blocks; mandatory identity/freshness/completeness metadata remains visible
- `deep_show_handoff_block` may expose analyst/SIAM handoff direction only; it must not emit SIAM-owned signal conclusions

---

## Forbidden menu powers (explicit anti-drift law)

The menu/settings surface must never directly control:
- final trade direction
- long/short verdict
- execution verdict
- entry command
- order placement logic
- order sizing or broker execution instructions outside lawful separate future doctrine
- hidden shortlist authority
- hidden promotion weighting that bypasses Layer 4 contract
- hidden signal-quality scoring
- unauthorized layer ownership jumps
- silent deep-analysis auto-run across the full universe
- any setting that makes ASC present itself as the final signal engine

Any control attempting one of these powers is non-admissible even if technically easy to implement.

Stage 5 clarification:
- no menu control may reframe Market Board as a signal dashboard
- no menu control may make Current Focus imply completed Deep Analysis
- no menu control may reinterpret Layer 5 handoff posture into final signal ownership

---

## Runtime and publication mapping law

Every admitted control must map to one of these ownership targets only:

| Control family | Lawful owner target |
|---|---|
| HUD & Display | HUD projection only |
| Market Board / Current Focus / Dossier display controls | Family 4 consumer projection only |
| Market State controls | Layer 1 bounded service/display profile only |
| Open Symbol Snapshot controls | Layer 2 selected-symbol tactical profile only |
| Selection Filter controls | Layer 3 bounded threshold/profile only |
| Shortlist Context controls | Layer 4 summary/context projection only |
| Deep Analysis controls | Layer 5 service configuration and Layer 5 consumer projection only |
| Advanced Controls | bounded runtime/governor/resource profile only |
| Reserved / Future Scaffolds | disabled placeholder only |

No control may map directly to SIAM / Aurora interpretation ownership.

---

## Validation checklist

Any new or changed setting/menu control must provide evidence for:
1. canonical section placement
2. safety class
3. lawful owner target
4. explicit runtime or publication mapping
5. forbidden-power review
6. mandatory metadata visibility review
7. tier classification (`Hard law`, `Required product contract`, or `Future expansion option`)

A control that fails any checklist item is non-admissible.

---

## Freeze-gate integration rule

Stage 0A/0B and later control-surface passes must treat this file as the canonical Stage 3 menu/settings doctrine.
No pass may claim trader-control completion while leaving timeframe/bars/ATR/spread/tick/output/forbidden-power law ambiguous.
