# Work Log

## 2026-03-23 — Dispatcher-first architecture rewrite pass

Performed a full blueprint and office correction pass based on:
- repo/runtime inspection
- HUD/problem screenshots
- uploaded CHM/manual pack presence
- official MQL5 reference cross-checks on timer/event behavior, symbol/session APIs, history access, array allocation, chart redraw/object cost, and focused-symbol display constraints

### Main outcomes
- redefined ASC around one dispatcher timer and an internal schedule wheel
- locked lane doctrine: 3 light lanes max or 1 heavy lane per pulse
- tightened Layer 1 into the true startup gate
- upgraded Layer 4 doctrine to top-5-per-main-bucket ownership
- upgraded Layer 5 doctrine to rank-sensitive promoted-set cadence
- tightened HUD doctrine around focused-symbol fast paint vs persistence cadence
- tightened symbol files and dossiers around layer-owned publication blocks
- updated root blueprint, deep build pack, and office control files to reflect the new architecture target

### Important honesty note
This pass updates doctrine and control truth only.
It does not yet refactor the live MT5 runtime code to match the new dispatcher/lane model.
That implementation rewrite remains the next required pass.
