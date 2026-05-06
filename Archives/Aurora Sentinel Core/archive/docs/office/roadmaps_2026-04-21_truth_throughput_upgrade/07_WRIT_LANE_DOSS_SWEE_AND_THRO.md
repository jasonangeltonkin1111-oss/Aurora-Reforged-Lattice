# Write-Lane, Dossier-Sweep, and Throughput Improvement

## Why this lane exists

The logs show the runtime still spends too much energy on write-lane pressure, dossier sweep cost, and publish/final-gate friction.
This lane is where efficiency becomes a first-class upgrade goal.

## Performance objective of this lane

Make the system able to process more symbols lawfully in shorter time without weakening truth.

## What this lane must improve

1. ordinary dossier hydration throughput for open symbols
2. write queue pressure
3. dossier sweep overhead
4. final-gate / publish wait friction
5. unnecessary repeated work inside the write/persist cycle
6. budget usage balance between scan truth and publication truth

## What this lane must not do

- do not fake performance by weakening ordinary dossier content law
- do not fake performance by suppressing rightful deep behavior
- do not starve scan truth to make the logs look quieter
- do not hide backlog with misleading counters or wording

## Likely primary code owners

- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_RuntimeState.mqh`
- `mt5/io/ASC_FileIO.mqh`
- `mt5/io/ASC_PublicationState.mqh`
- `mt5/runtime/ASC_Bootstrap.mqh`
- `mt5/runtime/ASC_DirectorySetup.mqh` only if path/setup overhead is genuinely implicated

## Performance metrics to track

- open-symbol dossier hydration completion ratio
- write queue milliseconds
- dossier sweep milliseconds
- heartbeat over-budget rate
- time-to-lawful ordinary dossier for open symbols
- publish deferral reasons
- final-gate waiting reasons

## Success conditions

- more open entitled symbols finish lawful ordinary dossiers in the same or less time
- write-lane pressure is materially reduced
- dossier sweep becomes less dominant
- throughput gains are real without truth loss

## Failure conditions

- throughput improves only because truth content was weakened
- deep or board paths regress
- scan quality materially degrades
- the system becomes faster but less truthful
