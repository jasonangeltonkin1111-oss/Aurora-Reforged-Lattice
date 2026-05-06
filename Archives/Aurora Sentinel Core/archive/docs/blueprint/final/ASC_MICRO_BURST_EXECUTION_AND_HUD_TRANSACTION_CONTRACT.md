# ASC Micro-Burst Execution and HUD Transaction Contract

## Purpose

This contract exists to bind:
- supervisory heartbeat cadence
- intra-beat micro-burst execution
- lane-focused packet completion
- HUD transaction ownership
- future implementation anti-drift boundaries

This file is the canonical owner of scheduler-vs-execution boundaries, single-lane focused execution law, Layer 1-4 automatic vs Layer 5 HUD-arm doctrine, closed-symbol wake/recheck posture, and HUD transaction completion-bounded yield behavior.

---

## Contract A — Scheduler boundary vs execution boundary

Definitions:
- **beat**: the 1-second supervisory scheduler pulse used to select dominant lane ownership and enforce guard checks.
- **burst**: a short execution burst inside the currently admitted lane while ownership remains valid.
- **packet**: a bounded unit of lane-owned work with explicit completion/exit criteria.
- **retry loop**: repeated bounded retrieval/validation/hydration attempts within the same lane-owned packet when quality gates are not yet satisfied.
- **yield cause**: an explicit reason to relinquish current execution ownership (guard breach, protected preemption, packet completion, bounded retry exhaustion, or transaction handoff).

Heartbeat is the scheduler boundary.
Heartbeat is not the minimum compute boundary.

---

## Contract B — Intra-beat micro-burst execution law

Within a beat, the active lane may execute repeated micro-bursts while ownership, guard posture, and packet scope remain valid.
Repeated retrieval, validation, and hydration retries are lawful inside the active lane and may occur inside the same beat.

Interpretation drift is forbidden:
- active-lane execution must not be collapsed into a single tiny once-per-second packet by misreading heartbeat as compute quantum;
- supervisory cadence must not be used as fake throttling against truthful packet completion.

Single-lane means focused ownership, not artificial slowing.
Companion work may run only when negligible, non-competing, and unable to dilute active packet completion.

---

## Contract C — Packet completion and retry doctrine

A lane-owned packet may exit only for one of these lawful reasons:
1. packet complete;
2. honest uncertain/degraded state emitted because required truth could not be fully confirmed;
3. bounded retry exhaustion reached with explicit failure/degraded posture;
4. protected supervisory preemption (for example integrity/write-protection obligations or HUD transaction ownership handoff).

Retries exist to preserve truth quality and ownership honesty, not to create fake delay.
A retry loop must remain bounded, inspectable, and scoped to its admitted packet.

---

## Contract D — Layer automation and invocation law

Layer automation ownership is fixed:
- Layer 1 = automatic
- Layer 2 = automatic
- Layer 3 = automatic
- Layer 4 = automatic
- Layer 5 = HUD-armed / selected-symbol scoped / semi-auto once armed

Layer 5 is not default broad automatic rotation.
Symbol-page visibility alone is not enough to arm Layer 5.
Analyse / Deep Analysis is the lawful arm action.

Once lawfully armed, Layer 5 may continue semi-automatically only within the admitted selected/promoted scope.
Semi-auto continuation must never widen into scanner-global background deep service.

---

## Contract E — HUD transaction ownership law

A HUD transition/reload transaction is a bounded render-ownership interval for one visible page/region.
During this transaction:
- competing heavy non-HUD lanes must yield until HUD transaction completion when HUD transaction ownership is lawfully acquired;
- HUD computes visible objects only;
- HUD updates retained objects and changed visible objects only;
- HUD redraws exactly once at transaction end.

This pause is completion-bounded and transaction-scoped, not fixed-sleep-based.
HUD transaction ownership is a render-stability law, not hidden scheduler authority.

---

## Contract F — Closed-symbol wake and recheck doctrine

Closed symbols are not entitled to dumb constant broad refresh spam.
Closed symbols should carry explicit wake/recheck scheduling posture to support truthful re-entry checks without global churn.

Wake posture is a lawful scheduling aid, not false certainty, and must not be represented as active deep entitlement.
Closed-symbol wake metadata may guide future admission checks but may not self-admit execution lanes.

---

## Contract G — Anti-drift interpretation law

The following reinterpretations are forbidden:
- “single lane” = slow lane
- “balanced” = diluted active packet completion
- “heartbeat” = only one tiny packet of work
- “HUD visibility” = authority to recalculate structure
- “tactical liveliness” = permission to escalate writes
- “Layer 5 semi-auto” = scanner-global background deep service

Scheduler timing and execution timing are separate by contract.
HUD visibility is not runtime compute authority.
Render smoothness is never permission to mask stale/degraded truth posture.

---

## Implementation anti-drift standard

Future EA/runtime implementation is INVALID if it:
- converts scheduler pulse into artificial work throttling;
- moves structural calculations into HUD render path;
- auto-runs Layer 5 globally;
- allows page visibility to grant hidden runtime authority;
- turns tactical strip motion into structural rebuild/write churn.

Any implementation that violates these ownership boundaries is architecturally invalid even if UI output appears smooth.
