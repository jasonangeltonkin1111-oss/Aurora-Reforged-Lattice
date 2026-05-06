# ASC Trader Control Registry (Canonical)

## Purpose

This file is the canonical trader-control registry for ASC.
It records which controls are trader-facing, which are dangerous reconfiguration controls, which are disabled future scaffolds, and which remain system-owned.

This registry is subordinate to:
- `blueprint/final/ASC_MENU_AND_SETTINGS_CONTRACT.md`
- `blueprint/final/08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md`
- `blueprint/final/11_ASC_HUD_AND_OPERATOR_SURFACE.md`

---

## Class law

- **Class A — Trader-Facing Control**: lawful, bounded, operator-facing control. Equivalent safety class is usually `safe_runtime`.
- **Class B — Advanced Trader Control**: operator-facing but guarded. Usually `dangerous_reconfigure` or a narrow advanced profile.
- **Class C — Future Disabled Scaffold**: visible only as a disabled `not active` placeholder.
- **Class D — System-Owned**: output truth or engine internals; never exposed as trader input.

---

## Active MT5 control registry

### 1) HUD & Display
- `Hud Enabled` — **Class A**
- `Hud Density Mode` — **Class A**
- `Hud Show Source Labels` — **Class A**
- `Hud Show Freshness Warnings` — **Class A**
- `Hud Show Continuity Warnings` — **Class A**
- `Hud Show Degraded Warnings` — **Class A**
- `Hud Rows Override` — **Class B** (resource-sensitive layout override)

### 2) Market Board
- `Board Top N` — **Class A**
- `Board Show Freshness` — **Class A**
- `Board Show Classification` — **Class A**
- `Board Show Shortlist Context` — **Class A**
- `Board Display Mode` (`compact` / `standard`) — **Class A**

### 3) Current Focus
- `Current Focus Display Mode` (`compact_brief` / `full_working_view`) — **Class A**
- `Current Focus Show Deep Posture` — **Class A**
- `Current Focus Show Freshness` — **Class A**
- `Current Focus Show Classification` — **Class A**

### 4) Dossier
- `Dossier Output Mode` (`compact_analyst_brief` / `full_evidence_pack`) — **Class A**
- `Dossier Show Full OHLC Bars` — **Class A**
- `Dossier Max OHLC Bars Printed` — **Class B**
- `Dossier Show ATR Block` — **Class A**
- `Dossier Show Spread Stats` — **Class A**
- `Dossier Show Tick Stats` — **Class A**
- `Dossier Show Support Resistance` — **Class A**
- `Dossier Show Scenario Block` — **Class A**
- `Dossier Show Analyst Handoff Block` — **Class A**

### 5) Market State
- `L1 Tick Freshness Sec` — **Class B**
- `L1 Stale Age Sec` — **Class B**
- `L1 Recheck Profile` — **Class B**
- `L1 Confirmation Retry Cap` — **Class B**

### 6) Open Symbol Snapshot
- `Snapshot Show Bid Ask` — **Class A**
- `Snapshot Show Spread` — **Class A**
- `Snapshot Show Tick Age` — **Class A**
- `Snapshot Display Cadence Profile` — **Class B**

### 7) Selection Filter
- `Filter Profile` — **Class B**
- `Filter Threshold Profile` — **Class B**
- `Optional Filter Family Visibility` — **Class A**

### 8) Shortlist Context
- `Shortlist Context Display Mode` — **Class A**
- `Shortlist Show Regime Summary` — **Class A**
- `Shortlist Show ATR Summary` — **Class A**
- `Shortlist Show Correlation Summary` — **Class A**

### 9) Deep Analysis
#### Timeframe enablement
- `Deep TF M1 Enabled` — **Class A**
- `Deep TF M5 Enabled` — **Class A**
- `Deep TF M15 Enabled` — **Class A**
- `Deep TF H1 Enabled` — **Class A**
- `Deep TF H4 Enabled` — **Class A**
- `Deep TF D1 Enabled` — **Class A**

#### Bars per timeframe
- `Deep TF M1 Bars Requested` — **Class A**
- `Deep TF M5 Bars Requested` — **Class A**
- `Deep TF M15 Bars Requested` — **Class A**
- `Deep TF H1 Bars Requested` — **Class A**
- `Deep TF H4 Bars Requested` — **Class A**
- `Deep TF D1 Bars Requested` — **Class A**
- `Deep Minimum Bars Policy` — **Class B** (shared floor or guarded per-timeframe floor profile)

#### ATR
- `Deep ATR Enabled` — **Class A**
- `Deep ATR Period` — **Class A**
- `Deep ATR Scope Mode` (`shared` / `per_timeframe`) — **Class B**

#### Spread
- `Deep Spread Enabled` — **Class A**
- `Deep Spread Window Size` — **Class A**
- `Deep Spread Minimum Samples` — **Class A**

#### Tick
- `Deep Tick Enabled` — **Class A**
- `Deep Tick Window Length` — **Class A**
- `Deep Tick Minimum Samples` — **Class A**

#### Analyst-facing output controls
- `Deep Output Mode` (`full_evidence_pack` / `compact_analyst_brief`) — **Class A**
- `Deep Show Full OHLC Bars` — **Class A**
- `Deep Max OHLC Bars Printed` — **Class B**
- `Deep Show ATR Block` — **Class A**
- `Deep Show Spread Stats` — **Class A**
- `Deep Show Tick Stats` — **Class A**
- `Deep Show Support Resistance Levels` — **Class A**
- `Deep Show Scenario Block` — **Class A**
- `Deep Show Analyst Handoff Block` — **Class A**

### 10) Advanced Controls
- `Scan Budget Symbols` — **Class B**
- `L1 Packet Target` — **Class B**
- `L1 Burst Max Per Heartbeat` — **Class B**
- `Write Budget Artifacts` — **Class B**
- `Write Starvation Beats` — **Class B**
- `Partial Write Min Assessed` — **Class B**
- `L1 Partial Write Beats` — **Class B**

### 11) Reserved / Future Scaffolds
- `Aurora Signal Controls` — **Class C**
- `Semi Auto Controls` — **Class C**
- `Full Auto Controls` — **Class C**
- `Custom Timeframe Sets` — **Class C**

---

## System-owned controls (not trader inputs)

The following remain **Class D** system-owned outputs:
- market open/closed observed outcomes
- selected symbol identity
- current shortlist composition
- promoted symbol count
- deep entitlement state
- bars copied per timeframe
- bars missing per timeframe
- timeframe sufficiency posture
- ATR/spread/tick sample counts actually observed
- publication freshness / degraded / continuity posture
- analyst/SIAM downstream conclusions

These are observed or produced truth.
They are not operator configuration.

---

## Explicit forbidden trader powers

No trader control may directly:
- force promotion into shortlist
- force Deep Analysis on a non-promoted symbol
- set final trade direction
- set long/short verdict
- place orders
- inject hidden signal scores
- turn Market Board into a signal dashboard
- make Current Focus imply automatic Deep Analysis completion
- override mandatory stale/degraded/continuity visibility

Any such item belongs outside the active registry and is non-admissible until a future doctrine pass explicitly admits it.
