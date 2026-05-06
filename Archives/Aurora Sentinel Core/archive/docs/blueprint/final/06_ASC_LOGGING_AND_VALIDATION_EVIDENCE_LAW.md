# ASC LOGGING AND VALIDATION EVIDENCE LAW
Status: Canonical
Scope: Structured evidence, non-spam logging, runtime proofs, validation doctrine

## 1. Purpose

Logging exists to prove what happened.

It does not exist to:
- flood the journal
- narrate every tiny helper step
- create performance drag
- bury real failures in noise

This document defines a lightweight but evidence-rich logging system.

---

## 2. Logging Law

The system must produce enough evidence to answer:

- Did the heartbeat run?
- Which lane ran?
- What did it attempt?
- What succeeded?
- What degraded?
- What failed?
- What fell back to continuity?
- What was skipped and why?
- What symbol count or section count was involved?
- What artifact landed?
- What selected-symbol alignment state exists?
- What bundle integrity state exists?

If logs cannot answer those questions, logging is insufficient.

---

## 3. Non-Spam Law

Logging must remain compact.

Forbidden:
- repeated per-tick line spam
- every helper function dumping lines
- identical duplicate messages
- raw diagnostic flooding in normal operation
- heavy formatting that slows the EA

Allowed:
- compact per-beat summary
- compact per-lane summary
- compact artifact outcome summary
- compact degraded/failure detail on change
- structured evidence lines

---

## 4. Required Logging Classes

### 4.1 Heartbeat Summary
Must show:
- beat id / cycle id
- start/end posture
- total duration
- warmup / steady posture
- major lane admission summary

### 4.2 Lane Summary
For each admitted lane:
- lane name
- admission status
- symbols or units processed
- duration
- success/degraded/failure posture
- key stats

### 4.3 Scanner / Coverage Summary
Must show:
- symbols scanned
- symbols refreshed
- open/closed/uncertain counts
- freshness posture
- next-check scheduling posture

### 4.4 Dossier Hydration Summary
Must show:
- symbol
- sections attempted
- sections ok
- sections degraded
- sections fallback
- sections missing
- fields populated count
- continuity used or not

### 4.5 Publication Bundle Summary
Must show:
- artifact family
- scope/symbol
- validation outcome
- promote outcome
- rollback outcome
- continuity used
- final result

### 4.6 Selected-Symbol / Current Focus Integrity Summary
Must show:
- selected symbol
- canonical dossier symbol
- Current Focus symbol
- publication id/bundle alignment
- mismatch or aligned posture

### 4.7 Market Board Publish Summary
Must show:
- publish admitted or skipped
- summary readiness
- shortlist/correlation readiness state
- bundle outcome

### 4.8 Degraded / Failure Detail Summary
Must show:
- exact reason
- owner/lane
- scope
- whether continuity preserved truth
- whether retry/defer occurred

---

## 5. Validation Evidence Law

Validation must be visible in logs.

Must show:
- what was validated
- what failed validation
- which required anchors/tokens were missing
- whether validation blocked publish
- whether last-good continuity was used instead

---

## 6. Freshness / Continuity Evidence Law

Logs must distinguish:
- fresh truth
- stale truth
- preserved last-good truth
- unavailable truth
- skipped truth
- deferred truth

A system that only logs “ok/fail” is not sufficient.

---

## 7. Operator vs Recovery Logs

The logging design may support multiple levels:
- compact normal runtime evidence
- richer recovery evidence
- targeted failure detail

But even recovery logging must remain bounded and grouped.

---

## 8. Required Log Dimensions

At minimum, compact evidence should be able to carry:
- beat number
- lane name
- symbol or scope
- count processed
- fields/sections count
- duration
- freshness posture
- continuity posture
- success state
- failure/degraded reason
- target artifact path where relevant

---

## 9. Validation Harness Law

Logging is not enough on its own.
The system also needs repeatable validation/proof checks for:

- classification sanity
- dossier structure integrity
- dossier hydration completeness
- Current Focus alignment
- Market Board integrity
- publication rollback behavior
- continuity fallback behavior
- no dev-language leakage
- selected-symbol synchronization
- heartbeat/lane discipline

---

## 10. Final Rule

A live system is only trustworthy if it can prove what it did without drowning itself in noise.

Logging must be:
- compact
- truthful
- grouped
- actionable
- cheap enough to run continuously
