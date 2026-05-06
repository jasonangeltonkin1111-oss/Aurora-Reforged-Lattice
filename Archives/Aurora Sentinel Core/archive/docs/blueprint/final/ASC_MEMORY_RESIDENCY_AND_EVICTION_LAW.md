# ASC Memory Residency and Eviction Law

## Purpose

This contract defines runtime memory tiers, eviction triggers, continuity handoff behavior, and dirty-routing admission boundaries so in-memory state never masquerades as published truth.

---

## Contract D — Dirty-routing ownership and non-self-admission law

Dirty routing may create eligibility, but no lane may self-admit by claiming local dirty state alone.

### Who may dirty whom

| Source domain | May dirty | Why | May not dirty directly |
|---|---|---|---|
| Layer 1 scan state | Layer 2 snapshot queues, freshness posture, coverage posture | Upstream observation changed | Layer 4/5 entitlement directly |
| Layer 2 snapshot/packet state | Layer 3 filter queues, packet freshness posture | Packet substrate changed | HUD structural truth surface directly |
| Layer 3 filter state | Layer 4 shortlist candidate queues | Gate output changed | Persistence publication ownership directly |
| Layer 4 shortlist state | Layer 5 eligibility/readiness posture queues | Promotion set changed | Layer 1 acquisition state and Layer 5 automatic active execution entitlement |
| Layer 5 deep state | Artifact publication candidates, advisory freshness posture | Deep packet changed | Layer 1/2 structural acquisition lanes |
| Persistence outcomes | Consume/HUD freshness flags, last-good visibility posture | Landed truth changed | Upstream scan/calculation recompute ownership |
| HUD/focus input | Tactical read eligibility only (if policy allows) | Operator-immediacy path | Structural dirty routes for Layer 1-5 |

### Never-self-admits rule

The following never self-admit as dominant-lane owners without governor selection:
- HUD/render paths,
- focus page visibility,
- telemetry update loops,
- artifact writer convenience callbacks,
- any lane attempting to claim ownership solely because it is already running.

Layer 5 active service may be armed only by lawful HUD Analyse / Deep Analysis request for selected-symbol context.
Page visibility alone may not dirty or self-admit Layer 5 active execution.

---

## Contract E — Memory residency tiers

| Tier | Name | Contents | Durability expectation | Eligible consumers |
|---|---|---|---|---|
| T0 | Ephemeral working set | Beat-local scan/calculation intermediates | Disposable at beat end | Owning sublane only |
| T1 | Rolling runtime cache | Recent packet/filter/selection cache for bounded reuse, selected-symbol tactical strip cache, Layer 5 armed symbol context, retry metadata, closed-symbol wake/recheck metadata, and HUD transaction-local presentation state | Recomputable; not source truth | Governor-admitted runtime lanes |
| T2 | Commit-ready staging | Validated payloads awaiting atomic publish | Must survive until publish/abort decision | Persistence lane only |
| T3 | Landed artifact truth | Final artifacts + last-good lineage | Canonical until superseded | Downstream consume/HUD/recovery |

### Residency invariants

- T0/T1 data is never presented as landed structural truth.
- T2 is write-owned; read lanes may not mutate it.
- T3 is the only authoritative surface for structural consume paths.
- Tactical/HUD-visible rolling state is lawful consumer-support state, not landed structural truth, and must not become a second source of structural authority.
- Future EA implementation may not use HUD-local state as justification for upstream recompute authority.

---

## Contract F — Eviction triggers and continuity handoff

### Eviction triggers

| Trigger | Tier affected | Required action |
|---|---|---|
| Credit exhaustion or beat close | T0 | Drop ephemeral intermediates not promoted to T1/T2 |
| Freshness expiry threshold crossed | T1 | Mark stale, evict or recompute on next lawful admission |
| Newer commit-ready payload supersedes old staging | T2 | Replace staged payload atomically; keep audit marker |
| Successful publish to final artifact | T2 | Clear staged payload after publish verification |
| Memory pressure/cap breach | T1 first, then non-protected T2 candidates | Evict least-recently-needed caches; never bypass publish integrity |
| Recovery restart or continuity break | T0/T1 and invalid T2 | Reset invalid transient state; preserve T3 + last-good contract |

### Continuity handoff behavior

On restart/recovery/degraded entry:
1. Preserve T3 landed truth and last-good lineage.
2. Invalidate unsafe T0/T1/T2 state unless checksum/ownership proves safe reuse.
3. Rebuild eligibility via dirty routing from trusted anchors (T3 + fresh Layer 1 observations).
4. Re-enter normal lane rotation only after recovery floor is met.

