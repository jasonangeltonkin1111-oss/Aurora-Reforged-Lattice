# Layer 0 to Layer 2 Polish and Hydration Truth

## Why this lane exists

The new cycle mainly targets Layers 3–6, but Layers 0–2 still feed every downstream result.
If hydration, freshness, or execution truth is dirty here, the ranking layers inherit the dirt.

## Layer focus

### Layer 0

Polish only.
Keep identity/classification stable and truthful.
Admit only work that improves downstream reliability.

### Layer 1

Polish only.
Improve wake/sleep cadence and market-state truth where it materially affects ordinary dossier and open-symbol entitlement quality.

### Layer 2

This is the highest-value upstream polish lane.
Improve:

- quote freshness truth
- spread stability truth
- tick-age sanity
- session/tradeability continuity
- hydration readiness for ordinary dossier and ranking layers

## What this lane must not do

- no Layer 0–2 redesign for its own sake
- no broad identity or classification rewrite
- no speculative broker-truth churn without evidence
- no hidden shift of ownership away from existing Layer 0–2 owners

## Likely primary code owners

- `mt5/market_state/ASC_MarketStateEngine.mqh`
- `mt5/open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh`
- `mt5/symbols/ASC_ClassificationBridge.mqh`
- `mt5/symbols/ASC_SymbolSpecification.mqh`
- `mt5/artifacts/ASC_OpenSymbolSnapshotWriter.mqh` only where readout truth must reflect lawful upstream truth

## Success conditions

- Layer 2 freshness and execution truth are cleaner and more stable
- ordinary dossier hydration has a better lawful substrate
- Layer 3 and Layer 4 inputs become less noisy

## Failure conditions

- upstream polish turns into redesign
- classification or identity truth destabilizes
- runtime cost rises without downstream truth gain
