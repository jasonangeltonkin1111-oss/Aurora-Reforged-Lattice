# AURORA CODING BRAIN GUIDEBOOK

Run: ARL-RUN009G  
Status: Mandatory for source / MT5 / runtime / code work

---

## Purpose

This guidebook stores durable coding and engineering lessons for ARL.

It exists to prevent the old ASC failure pattern:

```text
fix one thing,
create another route,
break compile,
hide source truth,
patch around the owner,
then drown in scaffolds.
```

---

## Coding Prime Law

```text
Patch the owner file.
Do not create a parallel route.
Do not bypass the source of truth.
Do not claim proof above evidence.
```

---

## Owner-File Law

Every behavior must have exactly one clear owner.

Examples:

```text
Version identity -> mt5/core/ARL_Version.mqh
EA lifecycle -> mt5/ARL_Core.mq5
Timer heartbeat -> mt5/runtime/ARL_Heartbeat.mqh
Scheduler ticks -> mt5/runtime/ARL_Scheduler.mqh
Atomic publication -> mt5/io/ARL_FilePublisher.mqh
Status output -> mt5/telemetry/ARL_StatusWriter.mqh
Manifest output -> mt5/io/ARL_PublicationManifest.mqh
Permission boundary -> mt5/permission/ARL_NoTradePermissionBoundary.mqh
```

If behavior belongs to an owner, repair that owner.  
Do not add an emergency duplicate.

---

## No Duplicate Route Law

Forbidden unless explicitly justified:

```text
second status writer
second manifest writer
parallel file publisher
shadow path
bypass output
emergency fallback writer
hidden compute path
```

A route change requires:

```text
old owner
new owner
reason
migration test
rollback rule
lock impact
```

---

## Compile Proof Law

Compile success proves only:

```text
syntax
include compatibility
basic type/function availability
```

Compile success does not prove:

```text
runtime correctness
atomic publication success
trading edge
live safety
prop-firm safety
scheduler safety
file integrity
```

Do not overclaim.

---

## Runtime Proof Law

Runtime proof requires actual runtime output/log evidence.

A status file existing is not enough unless:
- path is known,
- content is read back,
- timestamp/currentness is checked,
- manifest agrees,
- no stale fallback is being shown as current.

---

## MQL5 Timer Law

`OnTimer()` must stay light.

It may call:

```text
heartbeat tick
scheduler tick
bounded due-work slice
```

It must not do:

```text
full universe scan
full ranking pass
dossier generation
Market Board build
unbounded loops
heavy file writes
```

Heavy work must be sliced and scheduled.

---

## File Publication Law

Public artifacts must use:

```text
compose payload
validate payload
write temp
flush/close if needed
readback
promote current
update manifest
skip unchanged
```

Direct overwrite of public files is a failure risk.

---

## Version Law

ARL uses `a.bcd`.

```text
a = phase
b = major edit inside phase
c = minor edit inside major
d = run/build count inside lane
```

Version identity must align across:

```text
ARL_Core.mq5 #property version
ARL_Version.mqh
MT5_VERSION_POLICY.md
office ledgers
run report
Git Description
```

No changelog `.mqh`.

Git + office own change history.

---

## No Cosmetic Module Law

Every module must have:

```text
owner
purpose
inputs
outputs
forbidden ownership
future implementation lane
acceptance test
failure mode prevented
```

If a module does not earn its place:
- DELETE,
- MERGE,
- or DEFER.

Do not keep modules because they sound intelligent.

---

## Permission Boundary Law

Until future evidence and explicit permission changes:

```text
trade_permission=false
signal_permission=false
execution_permission=false
hud_permission=false
```

No source file may imply buy/sell/entry authority.

---

## Future Coding Brain Sections

Add durable lessons here as implementation begins:

```text
Runtime IO lessons
Account/trade-history lessons
Market Watch/universe lessons
Layer 1 market-state lessons
Layer 2 broker-spec lessons
Layer 3 ranking lessons
Layer 4 grouping lessons
Layer 5 deep-review lessons
Market Board output lessons
Symbol Trader Pack output lessons
Dossier output lessons
```

---

## Runtime IO Lesson — Compile Clean Is Not Publication Proof

A runtime writer is not real because its module exists or compiles.

For every output writer, verify the full living chain:

```text
OnInit initializes owner state
EventSetTimer succeeds
OnTimer calls the owner path
input gate allows writes
publisher writes temp
publisher reads temp back
publisher promotes temp to current
publisher reads current back
payload/report names final path, temp path, and file mode
operator can find the file on disk
```

If any link is missing, the correct state is TEST FIRST, not ready.
