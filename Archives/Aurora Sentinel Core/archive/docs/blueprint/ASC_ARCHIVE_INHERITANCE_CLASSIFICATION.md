# ASC Archive Inheritance Classification

## Status
Integrated canon for deciding what archive behavior is inherited into active ASC blueprint doctrine.

## Purpose
Classify archive inheritance by domain using three outcomes only:
- **Preserve as structural law**
- **Visual inspiration only**
- **Reject as old debt**

## Evidence anchors (archive truth)
- `archives/Chat.md` (reset motive: HUD degradation, roadmap mixing, heartbeat/breathing failures, and explicit call for archive-informed blueprint completion).
- `archives/MAPS/unclassified/Hud design.txt` (AFS HUD split, pending-reason visibility, progress visibility requirements).
- `archives/Asc Archive/mt5/ASC_UI.mqh` (concrete historical HUD/menu object model and section toggles).
- `archives/Asc Archive/blueprint/RUNTIME_RULES.md` (timer-led cadence and bounded runtime law).
- `archives/Asc Archive/blueprint/SUMMARY_SCHEMA.md` (summary/publication shape and anti-fake-output rules).
- `archives/Asc last gen archives 23-03/asc-mt5-scanner-blueprint/09_ASC_SYMBOL_DOSSIER_CONTRACT.md` (dossier is downstream composed surface).
- `archives/Asc last gen archives 23-03/asc-mt5-scanner-blueprint/10_ASC_SUMMARY_AND_PUBLICATION_CONTRACT.md` (summary is late/selective and must not outrun symbol truth).

---

## Domain classification

### 1) HUD

**Preserve as structural law**
- HUD is a consumer/display surface, not a heavy compute engine.
- HUD must distinguish known-now vs pending states and show explicit pending causes.
- HUD must preserve operator-truth visibility (progress/readiness), not decorative ambiguity.

**Visual inspiration only**
- Legacy panel placement, section ordering, and label/button aesthetics from `ASC_UI.mqh`.
- Legacy string styling and compact/full toggle presentation patterns.

**Reject as old debt**
- Any HUD behavior that implies scanner ownership, write-side ownership, or hidden recomputation.
- Any HUD update pattern that causes runtime stall, heavy per-frame object churn, or cadence collapse.

### 2) Menu / Settings

**Preserve as structural law**
- Settings must remain grouped by runtime ownership domains (runtime, universe, buckets, market, conditions, history, indicators, publication, UI, actions).
- Operator controls must expose real runtime contracts, not synthetic convenience state.

**Visual inspiration only**
- Accordion/toggle menu treatment and button-per-setting interaction shape from `ASC_UI.mqh`.

**Reject as old debt**
- Bloated menu surfaces that leak internal development language directly to operator face.
- Menu growth that outruns canonical runtime contract ownership.

### 3) Board / Dossier

**Preserve as structural law**
- Dossier is downstream composed output; truth is authored upstream by runtime layers.
- Dossier ordering must foreground immediate operator utility and current state clarity.
- Summary/dossier publication is selective, truthful, and downstream of symbol truth.

**Visual inspiration only**
- Legacy dossier section naming and narrative formatting style where it improves readability without changing ownership.

**Reject as old debt**
- Dossier/board surfaces acting as hidden truth engines or recomputing ranking at write time.
- Full-universe dump behavior pretending to be operator summary value.

### 4) Runtime cadence

**Preserve as structural law**
- Timer-led bounded orchestration, startup restore-first posture, and no heavy scanner work on tick.
- Publication order discipline: owned truth first, summary later, downstream surfaces last.
- Cadence honesty: display-fast does not authorize write-fast.

**Visual inspiration only**
- Legacy status wording patterns that are useful for operator readability after translation cleanup.

**Reject as old debt**
- Cadence mixing where HUD/menu activity drives scanner authority.
- Tick-driven universe-wide rescans and any publication cadence that outruns upstream truth readiness.

---

## Integration links
This canon is integrated by reference from:
- `blueprint/ASC_ARCHIVE_CARRYOVER_AMENDMENT.md`
- `blueprint/roadmap/00_ROADMAP_OVERVIEW.md`
- `office/CHANGE_LEDGER.md`
