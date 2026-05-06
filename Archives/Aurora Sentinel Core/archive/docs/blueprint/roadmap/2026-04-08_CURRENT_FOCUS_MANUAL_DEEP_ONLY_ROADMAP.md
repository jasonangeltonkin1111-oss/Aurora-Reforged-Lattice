# Current Focus Manual Deep-Only Roadmap

## Status

This roadmap supersedes the multi-lane Current Focus recovery direction.

Current Focus is no longer being treated as a continuously refreshed selected-symbol artifact.
That model has proven too brittle and has consumed a full day in downgrade/overwrite regressions.

The active product model is now:
- **Market Board** = always-on scanner / shortlist / overview surface
- **Current Focus** = manual Deep Analysis surface only

Current Focus must change only when explicit Deep Analysis is requested.
Ordinary selected-symbol view-sync must stop writing it.

---

## Why this roadmap exists

Recent commits introduced and then repeatedly hardened a multi-lane Current Focus path:
- deep trigger writes rich Current Focus
- ordinary view-sync still re-runs later
- preserved-dossier / retained-pair / shell-fallback / canonical-recompose branches remain active
- a later shallow `focus-view-*` path can still beat the rich deep file

Observed live failure:
- Deep Analysis succeeds
- Current Focus becomes a rich ~330 KB deep file
- ~3 seconds later it reverts to a shallow ~53 KB file

This means the deep path itself is not the main problem.
The problem is that **ordinary background Current Focus writing is still alive**.

---

## Final product contract

### Market Board
- always-on
- continuously updated
- scanner / shortlist / market overview truth

### Current Focus
- written only by explicit Deep Analysis
- remains on the last explicit deep-analysis result until the next explicit deep request
- no ordinary selected-symbol background writer may overwrite it
- no shallow `focus-view-*` packet may replace it
- dossier may remain only as debug/supporting artifact for now

---

## Core law

**Current Focus is no longer a multi-lane surface.**

Once a Deep Analysis write succeeds for symbol X:
- Current Focus is authoritative for symbol X
- no ordinary view-sync path may rewrite it
- no shell fallback may rewrite it
- no canonical shallow recomposition may rewrite it
- no dossier/current-focus pair refresh may rewrite it outside explicit Deep Analysis

---

## Non-negotiable rules

### Rule 1 - Deep trigger is the sole Current Focus writer
Only explicit Deep Analysis service may publish Current Focus.

### Rule 2 - ordinary selected-symbol view-sync does not write Current Focus
Ordinary selected-symbol refresh may update internal state if needed, but it must not publish Current Focus.

### Rule 3 - Current Focus is sticky
After explicit Deep Analysis completes, Current Focus remains until the next explicit Deep Analysis request.

### Rule 4 - dossier is debug-only for this lane
Dossier may remain for debug/evidence, but dossier logic must not decide whether trader-facing Current Focus gets downgraded.

### Rule 5 - no shell fallback publication to Current Focus
If deep is not requested, Current Focus is left untouched.
Do not publish compact fallback packets into Current Focus from ordinary view-sync.

### Rule 6 - Market Board remains untouched unless strictly required
This lane is not a Market Board redesign lane.

---

## Prompt count

This roadmap will be executed in **5 prompts total**.

---

## Prompt sequence

### Prompt 1 - disable ordinary Current Focus writer path
Goal:
- stop ordinary selected-symbol / view-sync flow from publishing Current Focus

Focus:
- `ASC_RunViewedCurrentFocusWrite(...)`
- any scheduler/dispatcher path that admits ordinary Current Focus write work
- `current_focus_view_pending` behavior only as it relates to file publication

Success condition:
- ordinary background Current Focus publication path is disabled or turned into a no-write path

---

### Prompt 2 - make Deep Analysis the sole Current Focus publisher
Goal:
- ensure Current Focus is written only by explicit Deep Analysis flow

Focus:
- `ASC_RunDeepFocusTriggerWrite(...)`
- any helper used to write Current Focus from deep-trigger service
- ensure no other runtime path claims publication authority over Current Focus

Success condition:
- successful Deep Analysis is the only path that can publish/update Current Focus

---

### Prompt 3 - remove dossier/pair dependency from Current Focus survival
Goal:
- Current Focus survival must not depend on retained dossier/current-focus pair verification

Focus:
- Current Focus protection logic
- downgrade/preservation helpers
- remove reliance on dossier-first pair proof for preserving already-good Current Focus

Success condition:
- if Current Focus already contains lawful deep truth, it survives directly without needing dossier pair verification

---

### Prompt 4 - convert dossier to debug/support role for this lane
Goal:
- keep dossier only as debug/evidence artifact and ensure it no longer drives trader-facing Current Focus behavior

Focus:
- remove dossier-readback as a driver for Current Focus overwrite decisions
- remove Current Focus/dossier circular selection/header truth where relevant
- preserve dossier only where useful for debug and forensic evidence

Success condition:
- trader-facing Current Focus behavior is independent from dossier downgrade logic

---

### Prompt 5 - final hardening / compile / live-proof pass
Goal:
- verify the simplified model holds end to end

Must prove:
- Market Board still works
- Deep Analysis still produces rich Current Focus
- no later ordinary path rewrites Current Focus
- no 330 KB -> 53 KB regression remains
- compile/runtime consistency is preserved

Success condition:
- Current Focus is stable again under the manual deep-only model

---

## Codex instructions

Every Codex pass in this lane must read this roadmap first:

`Aurora Sentinel Core/blueprint/roadmap/2026-04-08_CURRENT_FOCUS_MANUAL_DEEP_ONLY_ROADMAP.md`

Codex must follow the active product contract in this roadmap and must not reintroduce multi-lane Current Focus behavior.

---

## Stop conditions

Do not proceed to the next prompt if any of the following remain true:
- ordinary selected-symbol view-sync still publishes Current Focus
- a shallow `focus-view-*` payload can still replace a rich deep Current Focus file
- Current Focus survival still depends on dossier/current-focus retained pair verification
- Current Focus can still change without explicit Deep Analysis

---

## Final target state

When this roadmap is complete:
- Market Board remains the always-on product
- Current Focus becomes a manual, sticky Deep Analysis file
- no background Current Focus lane remains
- no shallow overwrite path remains
- dossier is optional debug/support only
- the operator can trust Current Focus again
