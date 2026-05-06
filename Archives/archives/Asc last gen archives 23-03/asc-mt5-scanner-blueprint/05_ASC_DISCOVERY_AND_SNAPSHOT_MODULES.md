# ASC Discovery and Snapshot Modules

## Purpose

Discovery and packet modules retrieve truth.
They do not decide shortlist competition or deep-analysis rank.

## Universe law

ASC must define its universe explicitly.
It should not stay vague between:
- all server symbols
- Market Watch symbols

Recommended operator-first doctrine:
- default universe = Market Watch
- optional broader universe mode only when explicitly chosen

## Layer 1 discovery modules

### Universe discovery
- `SymbolsTotal(...)`
- `SymbolName(...)`
- optional symbol-selection/synchronization checks

### Market-state discovery
- `SymbolInfoTick(...)`
- `SymbolInfoSessionTrade(...)`
- synchronization state

## Layer 2 packet module

Layer 2 owns the current open-symbol packet.
That packet should include only cheap current fields such as:
- bid
- ask
- spread
- day high / day low
- point / digits
- static tradability packet

## Focused-symbol packet mode

When the operator opens a symbol page, Layer 2 may temporarily elevate packet reads for that symbol only.
That is display-fast packet reading.
It is not blanket packet refresh for the whole open universe.

## Last-good law

Layer 2 should preserve last-good packet values when a refresh fails.
Closed or non-open symbols should not fake fresh packet truth.
