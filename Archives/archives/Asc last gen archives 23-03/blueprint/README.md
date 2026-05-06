# ASC Blueprint

This folder is the active design canon for Aurora Sentinel Scanner.

## Current emphasis

The blueprint now centers on:
- one dispatcher timer with an internal schedule wheel
- lane-based bounded work instead of one blended heartbeat
- Layer 1 as the true boot gate
- Layer 4 top-5-per-main-bucket ownership
- Layer 5 rank-sensitive promoted-set cadence
- focused-symbol fast HUD paint split from persistence cadence
- dossiers and summaries as consumer surfaces built from layer-owned truth blocks

## Recommended read order
1. `01_ASC_SYSTEM_OVERVIEW.md`
2. `02_ASC_RUNTIME_AND_SCHEDULER.md`
3. `04_ASC_FIVE_LAYER_MODEL.md`
4. `05_ASC_FIELD_CADENCE_AND_REFRESH_POLICY.md`
5. `06_ASC_SYMBOL_FILES_AND_PUBLICATION.md`
6. `08_HUD_OPERATOR_SURFACE_LAW.md`
7. `12_ASC_EXPLORER_HUD_AND_NAVIGATION.md`
8. `15_ASC_DISPATCHER_AND_LANE_MODEL.md`
