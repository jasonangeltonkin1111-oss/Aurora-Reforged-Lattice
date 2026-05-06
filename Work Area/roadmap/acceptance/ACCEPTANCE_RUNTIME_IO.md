# Acceptance Runtime Io

Runtime/IO acceptance: heartbeat, scheduler, status writer, atomic publisher, manifest, no direct overwrite, no HUD, trade_permission=false.

## Required result format

```text
TEST:
EXPECTED:
OBSERVED:
PASS/FAIL:
EVIDENCE:
NEXT ACTION:
```


---

## ARL-RUN009 acceptance expansion

TEST:
Compile `Work Area/mt5/ARL_Core.mq5` in MetaEditor.
EXPECTED:
No errors; product version visible as `1.005`.
OBSERVED:
Not available in this patch environment.
PASS/FAIL:
Pending.
EVIDENCE:
MetaEditor output required.
NEXT ACTION:
Compile before runtime attachment.

TEST:
Attach EA in MT5 demo terminal with file writes enabled.
EXPECTED:
Timer starts; `Status_Current.json` and `Manifest_Current.json` publish under MT5 Common Files sandbox; all permission flags remain false.
OBSERVED:
Not available in this patch environment.
PASS/FAIL:
Pending.
EVIDENCE:
Runtime terminal files/logs required.
NEXT ACTION:
Run runtime smoke after compile.

TEST:
No-change skip with fixed payload.
EXPECTED:
Second identical payload returns `NO_CHANGE_SKIP` and does not promote a new current file.
OBSERVED:
Not available in this patch environment.
PASS/FAIL:
Pending.
EVIDENCE:
Runtime test harness or fixed-payload call required.
NEXT ACTION:
Add a tiny test harness only if needed after compile.
