# ASC Market State Truth Model

## Purpose

Market State Detection must answer “is this symbol open enough now?” without faking certainty.
It is now also the explicit startup gate for the whole runtime.

## Final truth model

Do not reduce everything to only open/closed internally.
Use richer outcomes and map them to human labels later.

Suggested internal outcomes:
- `OPEN`
- `CLOSED`
- `UNCERTAIN`
- `UNKNOWN`

Public dossier/HUD wording may stay simpler, but the engine should keep the richer truth.

## Evidence families

### A — live tick evidence
Use `SymbolInfoTick()` and last tick time to detect whether recent market activity exists.

### B — broker session reference
Use `SymbolInfoSessionTrade()` to know broker-declared session windows and next expected open timing.

### C — synchronization awareness
Use `SymbolIsSynchronized()` to know whether newly discovered symbols are ready enough to trust.

### D — continuity context
Previous known status, last good checks, and next scheduled open support degraded decisions.

## Boot model

At startup Layer 1 should:
1. enumerate the defined universe
2. first-pass assess the whole universe
3. classify each symbol as Open / Closed / Uncertain / Unknown
4. run up to 3 confirmation rechecks only for unresolved/opening cases
5. publish compact Layer 1 truth atomically
6. only then admit Layer 2+

## Maintenance model

After boot:
- use schedule-driven maintenance
- do hourly schedule sweeps
- wake earlier near session boundaries
- keep clearly closed symbols calm
- do not let Layer 1 drag later layers in the same pulse by default

## Ownership boundary

Market State Detection owns:
- universe-linked per-symbol market-state truth
- tick freshness
- session-aware recheck timing
- synchronization-aware first pass
- honest uncertain/unknown outcomes
- compact Layer 1 publication

It does not own:
- Layer 2 packets
- filtering
- shortlist competition
- deep selective analysis
- dossier compose waves
