# ASC PUBLICATION CONTINUITY AND INTEGRITY LAW
Status: Canonical
Scope: Atomic publication, validation, continuity, rollback, artifact truth landing

## 1. Purpose

This document defines how artifact publication must work so that:
- downstream artifacts remain trustworthy
- partial writes do not masquerade as success
- last-good continuity is preserved safely
- timestamps remain honest
- validation blocks bad publishes
- rollback behavior is visible and evidence-rich

---

## 2. Publication Law

All artifact publication must follow:

**temp -> validate -> promote**

No exceptions.

This applies to:
- dossier
- Current Focus
- Market Board
- supporting symbol artifacts
- summary artifacts where applicable

---

## 3. Temp Law

The system must first write a candidate payload to a temporary path.

Temp write must:
- be complete
- be binary-safe where required
- preserve exact payload content
- not alter the live artifact until validation succeeds

---

## 4. Validation Law

Validation must occur before promotion.

Validation must check:
- payload exists
- payload is complete
- payload contains required canonical anchors/tokens
- payload is not truncated
- artifact family expectations are satisfied
- symbol identity is coherent for symbol artifacts
- selected-symbol identity is coherent for Current Focus where applicable

Validation failure must block promotion.

---

## 5. Promote Law

Promotion must occur only after validation succeeds.

Promotion must:
- replace live artifact atomically where possible
- preserve last-good appropriately
- stamp success metadata only on true promotion success
- never claim success before promote is complete

---

## 6. Last-Good Continuity Law

If fresh publication fails but last-good exists, the system may preserve continuity by using last-good.

Continuity fallback must:
- be explicit
- not be disguised as fresh publish success
- preserve the distinction between fresh and retained truth
- update continuity posture honestly

Last-good is a safety mechanism, not a truth laundering mechanism.

---

## 7. Honesty of Timestamps Law

Fields like:
- Generated
- Last Successful Publish
- Last Published
- Last Good Fallback
- Artifact Revision

must remain honest.

Do not stamp:
- promote time on failed validation
- fresh success time on continuity reuse
- artifact revision increments on non-landed publish

---

## 8. Bundle Integrity Law

When pair or grouped publication occurs, the system must preserve bundle integrity.

Examples:
- selected-symbol dossier + Current Focus
- board + summary families where contract requires cohesion

Bundle posture must clearly express:
- all succeeded
- partial success
- partial failure
- fallback used
- deferred or skipped companion artifact

---

## 9. Failure Law

Publication failure must remain explicit.

Possible explicit outcomes:
- success
- degraded success
- continuity fallback used
- validation blocked
- promote failed
- rollback used
- skipped by policy
- deferred by timing/breathing law

No silent publish collapse is allowed.

---

## 10. Rollback Law

If promote or validation fails in a way that threatens artifact integrity:
- rollback must preserve live truth
- rollback reason must be logged
- operator artifact must not be partially corrupted

Rollback is protective, not optional.

---

## 11. Artifact Family Law

### Dossier
Canonical symbol truth artifact.
Must not land partially.

### Current Focus
Selected-symbol derivative artifact.
Must align with selected-symbol dossier truth.

### Market Board
Compact market summary artifact.
Must not claim deep or shortlist truth it does not lawfully possess.

---

## 12. Integrity Surface Law

The dossier and related artifacts must surface integrity truth explicitly.

Examples:
- Publication Status
- Last Published
- Last Good Fallback
- Current Bundle Status
- Continuity Mode
- Missing / Delayed Areas
- Integrity Notes

These fields are mandatory for operator trust.

---

## 13. Logging Law for Publication

Publication logging must include compact evidence for:
- artifact family
- symbol or scope
- temp write result
- validation result
- promote result
- rollback result
- continuity result
- final target path
- bundle result
- timing outcome

No publication success may be claimed without evidence.

---

## 14. Final Rule

Artifacts are only trustworthy if their landing path is trustworthy.

A beautiful artifact with dishonest publication behavior is a broken product.
