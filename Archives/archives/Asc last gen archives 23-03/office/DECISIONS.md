# Decisions

## Locked decisions

- the active office root is `office/`
- the office layer must stay small
- the active MT5 build surface is `mt5_runtime_flat/`
- MT5 runtime deployment remains flat for fast file navigation
- server identity only; no account contamination in storage
- storage root is `AuroraSentinel/<Clean Server Name>/`
- exactly two server subfolders: `Symbol Universe` and `Dev`
- dossiers must use human-readable functional names
- internal mechanic names must not leak into dossier, HUD, or menu wording
- startup restores and repairs; it must not blindly wipe and rebuild
- atomic temp-to-final persistence with `.last-good` protection is mandatory
- continuity restore may use `.last-good` fallback when the primary file is missing or invalid, but that fallback must be logged honestly
- one EA timer is the runtime control spine; all cadence diversity is internal dispatcher truth
- the runtime must dispatch narrow lanes of work rather than blending all due layers in one pass
- per pulse ASC may admit at most 3 light lanes or exactly 1 heavy lane
- warmup exit is Layer-1-owned only and must not be keyed off explorer hydration or dossier existence
- Layer 1 owns whole-universe market-state truth first; everything else waits until Layer 1 readiness is honestly earned
- Layer 2 owns selective open-symbol packet truth and last-good continuity only
- Layer 3 remains cheap eligibility only and must not become a score engine
- Layer 4 owns the bounded top-5-per-main-bucket operator set, including honest spill/fill behavior for sparse buckets
- Layer 5 owns rank-sensitive deep refresh for the promoted set only
- focused symbol HUD movement is display-fast only and must not authorize broad recomputation or same-speed persistence
- dossiers and summaries are consumer surfaces built from layer-owned truth blocks
- ranking, strategy logic, execution logic, and account logic remain blocked

## Archive-derived control decisions

Preserve:
- task board
- decision log
- master/work log
- SHA ledger
- stage-gated control

Reject as active office shape:
- handoff sprawl
- HQ state sprawl
- wave packet clutter
- one tiny file per minor control change
