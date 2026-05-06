# Official MQL5 Research Notes For ARL Roadmap

These notes are planning constraints, not proof that ARL source works.

## Timer / scheduler

Official MQL5 docs state each program has one timer and if a Timer event is already queued or being processed, a new Timer event is not added. This supports ARL's small `OnTimer()` + scheduler slice design.

Source: https://www.mql5.com/en/docs/event_handlers/ontimer

## File publishing

`FileFlush()` saves buffered file data but frequent calls can affect speed. `FileMove()` supports move/rename with rewrite flags. This supports ARL's temp/write/readback/promote model and no-change skips.

Sources:
- https://www.mql5.com/en/docs/files/fileflush
- https://www.mql5.com/en/docs/files/filemove

## Indicators

`CopyBuffer()` can return `-1` when data is not ready and initiates data building/downloading. This supports explicit indicator statuses: READY, BUILDING, PARTIAL, FAILED.

Source: https://www.mql5.com/en/docs/series/copybuffer

## Account/history

`HistorySelect()` creates lists of orders and deals for a selected server-time period. This supports separate open positions, pending orders, and closed/deal history handling.

Source: https://www.mql5.com/en/docs/trading/historyselect
