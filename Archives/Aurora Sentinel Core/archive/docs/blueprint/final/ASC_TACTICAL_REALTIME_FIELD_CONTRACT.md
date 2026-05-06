# ASC Tactical Realtime Field Contract

## Purpose

This contract defines one canonical tactical-field matrix for realtime operator surfaces.
It binds HUD rendering rights, Board/Dossier/Current Focus usage boundaries, symbol scope, refresh cadence class, and persistence write policy in one place.

This file is normative for:
- HUD tactical strips and overlays
- Board/Dossier/Current Focus tactical snapshot inclusion
- persistence trigger guards for tactical-vs-structural publication behavior

---

## Contract A — Tactical field matrix (canonical)

All tactical realtime fields must be declared in this matrix.
Undeclared fields are non-admissible for tactical display or tactical snapshot publication. Tactical fields are selected-symbol-only on symbol pages unless a row explicitly grants aggregate utility context.

| Field name | Allowed surfaces (HUD page(s), Board, Dossier, Current Focus) | Symbol scope | Refresh cadence class | Persistence write policy |
|---|---|---|---|---|
| `server_time` | HUD: Overview/Home global clock utility; HUD: Symbol Overview tactical strip; HUD: Symbol Aspect Detail tactical mini-strip; Board: forbidden; Dossier: allowed as snapshot timestamp context; Current Focus: allowed | Aggregate on Overview/Home utility, selected-symbol context on symbol pages | `cadence_t0_tick` | Forbidden for tactical churn writes; allowed only as embedded timestamp inside structural artifact publication |
| `selected_bid` | HUD: Symbol Overview tactical strip; HUD: Symbol Aspect Detail tactical mini-strip; Board: forbidden; Dossier: allowed in live snapshot block; Current Focus: allowed | Selected-symbol only | `cadence_t0_tick` | Forbidden for direct tactical writes; may persist only through normal Layer 2 structural landing |
| `selected_ask` | HUD: Symbol Overview tactical strip; HUD: Symbol Aspect Detail tactical mini-strip; Board: forbidden; Dossier: allowed in live snapshot block; Current Focus: allowed | Selected-symbol only | `cadence_t0_tick` | Forbidden for direct tactical writes; may persist only through normal Layer 2 structural landing |
| `selected_spread` | HUD: Symbol Overview tactical strip; HUD: Symbol Aspect Detail tactical mini-strip; Board: forbidden; Dossier: allowed in live snapshot block; Current Focus: allowed | Selected-symbol only | `cadence_t0_tick` | Forbidden for direct tactical writes; may persist only through normal Layer 2 structural landing |
| `selected_daily_change_pct` | HUD: Symbol Overview tactical strip; HUD: Symbol Aspect Detail tactical mini-strip; Board: allowed as compact context line; Dossier: allowed; Current Focus: allowed | Selected-symbol only for HUD/Current Focus; aggregate card usage allowed on Board only from landed structural snapshot | `cadence_t1_fast` | Tactical direct-write forbidden; Board/Dossier persistence allowed only from landed structural snapshot |
| `selected_tick_age_seconds` | HUD: Symbol Overview tactical strip; HUD: Symbol Aspect Detail tactical mini-strip; Board: allowed as freshness qualifier; Dossier: allowed in live snapshot block; Current Focus: allowed | Selected-symbol only for tactical stream; aggregate freshness labels on Board must be derived summaries, not raw multi-symbol streams | `cadence_t0_tick` | Tactical direct-write forbidden; structural freshness state publication allowed |
| `selected_spread_pct` | HUD: Symbol Overview tactical strip; HUD: Symbol Aspect Detail tactical mini-strip; Board: allowed in execution-quality context; Dossier: allowed; Current Focus: allowed | Selected-symbol only for tactical stream; aggregate Board use only via structural summaries | `cadence_t1_fast` | Tactical direct-write forbidden; structural publication allowed under materiality thresholds |

---

## Contract B — Cadence classes

Cadence classes are display-service classes, not persistence-write classes. Tactical repaint may later move toward sub-second classes only in admitted strip-only regions; faster display cadence must not grant structural rebuild rights.

- `cadence_t0_tick`: per-tick/per-beat tactical immediacy for selected-symbol strip values.
- `cadence_t1_fast`: fast but calmer than per-tick; suitable for compact tactical context values.
- `cadence_structural_only`: no tactical direct stream; value appears only when structurally published.

If a field is not explicitly assigned one of the classes above in Contract A, it must be treated as `cadence_structural_only`.

### Contract B.1 — Cadence-to-UI-region mapping (hard map)

Cadence classes are admissible only in the UI regions below:

| Cadence class | Overview / Home | Main Groups | Sub-Groups | Symbol Overview | Symbol Aspect Detail |
|---|---|---|---|---|---|
| `cadence_t0_tick` | global utility clock cell only (optional) | forbidden | forbidden | symbol tactical strip only | aspect tactical mini-strip/header strip only |
| `cadence_t1_fast` | forbidden | forbidden | forbidden | symbol tactical strip support cells only | aspect tactical mini-strip support cells only |
| `cadence_structural_only` | structural cards/rows/status only | structural cards/rows/status only | structural cards/rows/status only | structural cards/rows/status only | structural cards/rows/detail panels only |

Hard guards:
- `cadence_t0_tick` and `cadence_t1_fast` are strip-only classes and are non-admissible in structural card trees.
- Tactical cadence classes may not hydrate Board-style aggregate symbol grids.
- Any page-region not listed above is forbidden for tactical cadence rendering.

---

## Contract C — Persistence binding

1. Tactical refresh never grants tactical write rights.
2. Tactical field motion alone is non-material for publication triggers.
3. Tactical values may appear inside Board/Dossier/Current Focus only when sourced from lawful landed structural snapshots or explicitly permitted selected-symbol tactical read paths.
4. Any attempt to publish per-tick tactical field changes as artifact writes is forbidden.
5. Tactical responsiveness tuning must never escalate persistence cadence class, write frequency, or publication trigger thresholds.

### Contract C.1 — Structural rebuild prohibition during tactical motion

The following transitions are forbidden:
- tactical strip update -> page-model rebuild
- tactical strip update -> structural card-tree rebuild
- tactical tick arrival -> structural list re-sort/re-pagination
- tactical strip update -> board recomposition
- tactical strip update -> hierarchy regeneration
- tactical strip update -> persistence cadence escalation
- tactical freshness tick -> page-model reconstruction

Allowed tactical transition behavior:
- strip-cell text/value repaint
- strip-local badge/freshness repaint
- strip-local source-label repaint

Any structural rebuild must be caused by structural artifact/version change, not tactical cadence activity.
Future EA implementation may not use fast tactical field cadence as evidence that structural layers should be published or recomputed at the same cadence.

---

## Contract D — Surface binding and honesty law

- HUD must source-label tactical fields distinctly from structural fields.
- Board must not display non-selected-symbol realtime tactical streams.
- Dossier and Current Focus may include tactical snapshot values, but must preserve freshness/degraded posture honesty.
- Missing tactical field availability must be shown honestly as unavailable/degraded, not inferred.
- Non-selected-symbol tactical values are hard-forbidden from symbol tactical strips. A symbol strip may show only currently selected symbol tactical fields.

---

## Enforcement checklist

- Matrix coverage check: every tactical field in code/docs maps to one row in Contract A.
- Surface scope check: no field appears on disallowed surfaces.
- Symbol scope check: selected-symbol-only fields never become implicit aggregate streams.
- Cadence-policy check: refresh cadence class never bypasses persistence write guards.
- Publication check: write triggers reject tactical-only churn.
- Transition check: tactical updates never trigger structural card-tree rebuilds.
- Strip isolation check: symbol tactical strip payload identity always equals currently selected symbol id.
- Responsiveness-without-escalation check:
  1. induce high-frequency tactical ticks on selected symbol;
  2. confirm strip repaint latency stays within page budget;
  3. confirm no structural artifact write-rate increase;
  4. confirm no persistence cadence class mutation in logs/telemetry;
  5. confirm structural publication cadence remains unchanged.
