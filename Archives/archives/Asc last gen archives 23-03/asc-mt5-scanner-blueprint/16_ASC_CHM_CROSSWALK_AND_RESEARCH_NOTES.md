# ASC CHM Crosswalk and Research Notes

## What was available in the zip

The uploaded archive included these compiled help manuals:
- `mql5.chm`
- `mql5book.chm`
- `neuronetworksbook.chm`

## Environment limitation

This environment could inspect the presence of the CHM files but could not directly unpack them into readable topic pages here.
So the practical method was:
1. inspect the archive and active blueprint directly
2. inspect the current MT5 foundation code
3. cross-map the required MQL5 topics to the official online MQL5 reference
4. update the deep pack only where that cross-check materially changed doctrine

## Relevant CHM knowledge families for ASC

### `mql5.chm`
Most relevant for:
- event model
- timer rules
- symbol/session APIs
- history access
- chart object/redraw behavior
- date/time utilities
- file APIs

### `mql5book.chm`
Most relevant for:
- practical MQL5 programming idioms
- event handling patterns
- runtime structure
- state/persistence examples

### `neuronetworksbook.chm`
Not central for current ASC foundation.
It remains out of scope unless ASC later adds ML research modules.

## Key researched topics now shaping the blueprint

- `EventSetTimer` / `EventSetMillisecondTimer`: one timer per EA, timer events coalesce when handlers run long
- `OnTick`: chart-symbol specific, not whole-universe control
- `OnChartEvent`: interaction hook, not scheduler replacement
- `SymbolInfoTick`: focused current packet access
- `SymbolInfoSessionTrade`: session-window scheduling support
- `SymbolsTotal`: explicit universe choice matters
- `SymbolIsSynchronized`: boot acquisition should respect synchronization state
- `CopyRates`: deep history belongs to selective later layers
- `ArrayResize`: reserve memory when dynamic growth is frequent
- `ObjectsTotal` / `ChartRedraw`: HUD object churn and redraw pressure are real costs
- `TimeTradeServer` / `GetTickCount`: useful for honest live clock and pulse-cost tracking
- `OnBookEvent`: too dangerous for broad-universe HUD subscription by default

## Resulting doctrine changes

This CHM/web crosswalk materially reinforced these design choices:
- one dispatcher timer, not many timers
- short bounded pulses, not giant blended heartbeats
- Layer 1 as the real boot gate
- focused-symbol fast HUD paint only for the current symbol
- rank-sensitive Layer 5 refresh only for the promoted set
