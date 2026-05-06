# ASC Heartbeat Breathing Contract

## Purpose

This contract codifies per-heartbeat lane selection, precedence, forced-service, starvation relief, companion-work boundaries, and read-window vs write-window guardrails for ASC runtime.

This file extends, and does not replace:
- `01_ASC_CORE_RUNTIME_LAWS.md`
- `09_ASC_GOVERNOR_MODES_AND_STARVATION.md`
- `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`

---

## Contract A — Heartbeat lane decision matrix

Each heartbeat must select one dominant major lane in priority order, then evaluate forced-service overrides, then admit bounded companion work.

One dominant lane per beat is mandatory. The selected active lane may execute multiple micro-bursts inside that beat while guard and ownership conditions hold. Beat selection binds lane ownership; it does not define a minimum compute quantum.

| Precedence | Primary lane candidate | Admit when | Forced-service escalation | Starvation relief rule |
|---|---|---|---|---|
| 1 | Recovery/Integrity | Restart, continuity break, writer recovery, critical artifact invalid | Immediate admission until continuity floor is restored | May preempt all non-integrity lanes |
| 2 | Persistence/Write | Protected artifact family ready, temp->final promotion pending, last-good preservation pending | Force write lane when landing age breaches threshold | Write starvation cannot be deferred by HUD/focus extras |
| 3 | Layer 1 Scan | Warmup not ready, market-state freshness below floor, coverage drift expanding | Force scan lane when warmup coverage stalls across beats | Layer 1 starvation is protected in Warmup/Recovery |
| 4 | Layer 2/3 Calculation | Dirty routing indicates bounded packet/filter maintenance | Promote only local dirty slices first | Must not leapfrog protected write starvation |
| 5 | Layer 4/5 Promotion/Deep | Entitled shortlist/promotion work is due and protected classes are healthy | Force only when explicit entitlement-age threshold is crossed | Deep starvation is scoped to promoted/entitled set only |
| 6 | Consume/HUD | Structural truth is landed and freshness within display contract | Never force over protected write/scan obligations | HUD starvation is cosmetic unless explicitly tactical-entitled |

### Selection algorithm (per beat)

1. Compute eligible lanes from dirty routing + mode.
2. Apply forced-service checks for protected classes.
3. Select highest-precedence lane that is either forced or eligible without violating higher protected guarantees.
4. Assign credits for selected lane.
5. Admit only allowed companion work from Contract B.
6. End beat on credit exhaustion or guard-trigger breach.

---

## Contract B — Companion-work allow/deny table

Companion work is legal only when dominant-lane identity remains unambiguous and companion work is bounded. Companion work must remain negligible, must not dilute active packet completion, and must not be used to justify fake balance that weakens focused active-lane execution.

| Dominant lane | Allowed companion work (bounded) | Explicitly denied companion work |
|---|---|---|
| Recovery/Integrity | Minimal telemetry markers, required continuity checkpoints | Broad scan waves, deep enrichment, cosmetic HUD sweeps |
| Persistence/Write | Write-audit counters, promotion bookkeeping, checksum/atomics verification | Packet recompute, shortlist rebuild, broad HUD refresh |
| Layer 1 Scan | Tiny state counters, scan health telemetry, bounded symbol metadata touch | Layer 4 rebuild, Layer 5 deep analysis, write-wave expansion |
| Layer 2/3 Calculation | Dirty-bucket bookkeeping, bounded eligibility indexing | Unrelated universe refresh, broad write flush, cosmetic render bursts |
| Layer 4/5 Promotion/Deep | Promotion audit marker, bounded prerequisite read checks | Broad Layer 1/2 sweeps, write-storm behavior, HUD-owned recompute |
| Consume/HUD | Tactical direct read for focused symbol (if policy allows), render cache hydration | Structural recompute, persistence landing, admission ownership seizure |

---

## Contract C — Read window vs write window timing

ASC keeps read-phase and write-phase windows separated even when adjacent in the same short runtime interval.

| Window | Core objective | Open conditions | Close conditions | Guard conditions |
|---|---|---|---|---|
| Read window | Acquire/compute truth inputs without publication side effects | Dominant lane is scan/calculation/consume and no protected write force is active | Credits exhausted, guard breach, or write force trigger appears | No artifact-family publication side effects |
| Write window | Atomic landing and publication of already-computed truth | Dominant lane is persistence or forced write override is active | Protected landings complete or write credits exhausted | No broad recompute expansion inside write window |

### Timing law

- Read window may prepare dirty sets and commit-ready payloads.
- Read window may execute repeated acquisition/confirmation micro-burst retries while read ownership remains lawful.
- Micro-burst retries remain lawful inside read ownership and must stay bounded by lane guards.
- Write window may only publish payloads that passed commit guards.
- No broad recompute expansion is allowed inside write window.
- A beat may not oscillate repeatedly between read/write windows.
- If write force triggers during read window, read work yields and next beat admits write ownership.
- If HUD transaction ownership is lawfully acquired, competing heavy non-HUD lanes must yield until HUD transaction completes.

### Write guard conditions

Write publication is blocked unless all are true:
- owning artifact contract is satisfied,
- payload age is within freshness envelope for that family,
- atomic temp->final promotion path is available,
- degraded/stale state flags can be emitted honestly.

