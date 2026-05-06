# AURORA FAILURE PATTERNS GUIDEBOOK

Run: ARL-RUN009G  
Status: Mandatory for all serious ARL work

---

## Purpose

This guidebook stores failures ARL must never repeat.

A failure pattern is not a shame list.  
It is a protection system.

---

## Failure Pattern 1 — Stale Output Looked Current

### Symptom
A file exists and looks valid, but it was stale, partial, retained-last-good, or mismatched.

### Prevention
- atomic publication,
- manifest currentness,
- readback status,
- snapshot IDs,
- stale field count,
- no fake ready labels.

### Falsifier
If a file says current while manifest/readback/snapshot status says otherwise, the system fails.

---

## Failure Pattern 2 — Metadata Drowned Trader Data

### Symptom
Operator-facing text became route/proof/schema/source walls instead of market/trader information.

### Prevention
- trader text = trader data,
- metadata = JSON/manifest/debug,
- Symbol Trader Pack mandatory.

### Falsifier
If a trader cannot answer why a symbol is worth checking, output fails.

---

## Failure Pattern 3 — Route Duplication

### Symptom
A fix created a second writer/path/owner instead of repairing the existing owner.

### Prevention
- owner-file law,
- no duplicate routes,
- route migration requires test/rollback.

### Falsifier
Two modules publish same truth without a documented owner transfer.

---

## Failure Pattern 4 — Hidden Source-of-Truth Drift

### Symptom
Office, roadmap, blueprint, MT5 source, and Git messages disagree.

### Prevention
- mandatory-read index,
- source authority ladder,
- contradiction ledger,
- version alignment.

### Falsifier
Product version or run ID differs across ARL_Core and ARL_Version without explanation.

---

## Failure Pattern 5 — Giant Dispatcher Pressure

### Symptom
One loop/dispatcher tries to do everything, causing slow updates, blocked timer events, and hidden skipped work.

### Prevention
- light OnTimer,
- scheduler due slices,
- bounded work budget,
- runtime metrics.

### Falsifier
OnTimer performs full scan/ranking/output build.

---

## Failure Pattern 6 — Compile Fix Created New Path

### Symptom
Instead of fixing broken owner file, a new path was added to bypass compile errors.

### Prevention
- repair owner module,
- no bypass path,
- compile repair scope.

### Falsifier
Compile fix adds new duplicate module/writer without owner migration.

---

## Failure Pattern 7 — Optional Missing Data Degraded Useful Output

### Symptom
Irrelevant missing fields made useful sections look broken.

### Prevention
- required vs optional vs irrelevant missing classification,
- optional missing summarized,
- irrelevant hidden from operator text.

### Falsifier
Missing broker country/ISIN blocks an FX trader review without a real reason.

---

## Failure Pattern 8 — Guide / Log Sprawl

### Symptom
Every run adds another doctrine/log file instead of improving the same living brain.

### Prevention
- Brain Update Protocol,
- guidebook promotion only for durable lessons,
- run details stay in reports.

### Falsifier
A new guide file repeats an existing guide without new decision value.

---

## Failure Pattern 9 — Archive Source Infection

### Symptom
Old archive source gets copied into active Work Area as if it were current truth.

### Prevention
- Archives are inheritance evidence only,
- extract lessons,
- no direct archive copy.

### Falsifier
Archive file appears in active source without migration decision and tests.

---

## Failure Pattern 10 — Fake Proof Language

### Symptom
The report says “proved,” “ready,” or “working” without compile/runtime/live evidence.

### Prevention
- evidence ladder,
- proof-language guide,
- compile/runtime/live separation.

### Falsifier
A run claims runtime proof without runtime logs/output.
