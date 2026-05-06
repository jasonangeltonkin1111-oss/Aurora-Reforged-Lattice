# ASC Explorer HUD and Navigation

## Purpose

The explorer is the visual consumer of ASC runtime truth.
Its job is to let the operator move quickly from market posture to focused symbol truth without dragging runtime back into whole-world recomputation.

## Navigation spine

The canonical movement path is:
1. Overview
2. Main Buckets
3. Bucket / group surface
4. Symbol list
5. Focused symbol packet
6. Focused deep/stat surface if the symbol earned it

## Ownership boundary

The explorer may:
- read runtime-owned prepared truth
- switch pages
- change focus
- request bounded focus-fast refresh for the current symbol
- request bounded layout rebuild when the chart changes materially

The explorer may not:
- own universe scanning
- rebuild classification on click
- authorize whole-universe refresh because a page is visible
- pull deep history directly from render code

## Main-bucket law

The first operator surface should remain compressed and readable.
Main buckets are the first surface.
Sub-buckets and symbol lists come later.

## Top-set law

Once Layer 4 is active, the explorer should present the promoted operator surface as top 5 per main bucket.
When a bucket has fewer than 5 valid members:
- keep the bucket visibly distinct
- fill remaining visible slots from the next eligible bucket
- mark spill/fill honestly

## Focused symbol live paint law

When the operator is inside a focused symbol page, the explorer may show fast-moving market-watch-like fields for that symbol only.
This should feel alive without turning the whole scanner into a one-second global repaint.

## Page hierarchy law

### Summary pages
Need:
- posture first
- counts first
- bucket first
- shortlist first

### Symbol pages
Need:
- symbol identity
- market state
- packet movement
- promotion state
- why the symbol matters now

### Deep pages
Need:
- only for symbols that earned Layer 5 attention
- rank-sensitive freshness labels
- no fake fields for non-promoted symbols

## Performance law

The explorer must prefer:
- retained objects
- cached property writes
- stable layout metrics
- explicit invalidation
- no synchronous heavy object scans in hot paths

## Anti-patterns

Do not let navigation become:
- a debug console
- a classifier trigger
- a hidden scheduler bypass
- a dossier writer
