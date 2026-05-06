# Working Stage Ledger

## Active stage

**Stage name:** Dispatcher-first blueprint correction pass

**Date:** 2026-03-23

## What changed in doctrine

### 1. Runtime control shape
The repo no longer treats the heartbeat as a broad blended work wave.
The active doctrine is now:
- one EA timer
- one internal schedule wheel
- narrow lane dispatch
- 3 light lanes max or 1 heavy lane per pulse

### 2. Layer 1 posture
Layer 1 is now the explicit boot gate.
Its readiness is based on Layer 1 acquisition truth only.
Prepared explorer hydration and dossier existence no longer define warmup exit in doctrine.

### 3. Layer 4 posture
Layer 4 is now defined as the bounded top-5-per-main-bucket authority rather than a generic shortlist cap surface.

### 4. Layer 5 posture
Layer 5 is now defined as rank-sensitive promoted-set maintenance only.
Default cadences are:
- rank 1 = 5s
- rank 2 = 10s
- rank 3 = 15s
- rank 4 = 20s
- rank 5 = 25s

### 5. HUD posture
The HUD now has a clearer split between:
- calm always-on summary posture
- focused-symbol fast paint
- slower selective persistence

## Active risks still open

- runtime code still reflects the old blended-heartbeat shape
- explorer/runtime ownership leakage still exists in the live implementation
- dossier cadence is still ahead of the new layer-owned publication doctrine
- current Layer 4 code does not yet match the new top-5-per-main-bucket doctrine

## Immediate next implementation target

Refactor the runtime so the code matches the newly locked blueprint before widening later-layer behavior any further.
