# ASC Symbol Files and Publication

## Purpose

ASC publishes rolling truth by owned layers.
The symbol file is the canonical operator-facing continuity surface.
Dossiers and summaries consume layer-owned truth blocks.

## Publication law

Layer-owned publication order is:
1. Layer 1 market-state block
2. Layer 2 open-symbol packet block
3. Layer 3 eligibility block
4. Layer 4 shortlist / top-set block
5. Layer 5 deep packet block
6. dossier/summary compose surfaces later

Each block is owned by its layer.
A later block must not rewrite earlier-layer meaning.

## Layer 1 publication block

Must be compact and fast.
Fields include:
- status
- status note
- last checked at
- next check at
- next check reason
- tick/session evidence summary
- confidence/uncertainty markers

This block is the first atomic publish target at boot.

## Layer 2 publication block

Layer 2 writes only when the symbol is eligible for packet truth.
Fields include:
- bid/ask/spread
- day high/day low
- point/digits
- static tradability packet
- last built at
- last-good preserved markers

Display-fast focused updates do not imply file writes at the same speed.

## Layer 3 publication block

Fields include:
- filter readiness
- eligible / ineligible / pending
- reason code
- cheap characterization
- last evaluated at
- assigned main bucket

## Layer 4 publication block

Fields include:
- selected / not selected
- bucket position
- hold-window timing
- spill/fill context when applicable
- shortlist basis
- last evaluated at

## Layer 5 publication block

Fields include:
- promoted deep rank
- deep packet freshness
- per-rank cadence metadata
- timeframe packet timestamps
- last-good deep continuity markers

## Dossier law

The dossier is not allowed to become the birthplace of lower-layer truth.
It is a composed operator surface that consumes layer-owned blocks already produced by runtime.

## Compose cadence law

Only the most relevant promoted symbols should get frequent dossier compose/hydration writes.
Default doctrine:
- non-promoted symbols: state-transition or slow summary cadence only
- promoted Layer 5 symbols: selective rolling compose allowed
- focused HUD movement: still not a reason for same-speed writes

## Atomic write law

Every symbol publication remains temp-to-final atomic with `.last-good` protection.
A later layer may fail while earlier last-good truth remains visible.

## Summary law

The summary is late, selective, and secondary.
It must not outrun symbol-file truth.
Summary sections should prefer:
- runtime posture
- open/closed/uncertain counts
- shortlist/top-set posture
- promoted deep set posture

Not:
- full universe dumps
- writer-side ranking math
- render-time re-derivation of scanner truth
