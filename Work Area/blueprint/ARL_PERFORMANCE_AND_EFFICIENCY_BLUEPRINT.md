---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Performance and Efficiency Blueprint

The performance target is not microseconds for the whole system.

The target is no wasted work.

## Efficiency Principles

- Do not recalculate unchanged data.
- Do not deep-calc every symbol.
- Do not retry confirmed states.
- Do not write unchanged public files.
- Do not create indicator handles repeatedly.
- Do not publish partial ranking as complete.
- Do not run heavy work inside a single timer handler.
- Slice work by due module and budget.

## Active Set

After Layer 4 publishes:

```text
active_l4_set =
  GlobalTop10
  ∪ MajorBucketTop5
  ∪ MinorBucketTop5
```

Deduplicate by exact broker symbol.

Layer 2 and Layer 5 frequent refreshes apply only to this set.

## Full Universe Work

Layer 3 remains full-universe every 20 minutes after warmup.

Layer 4 remains snapshot-based every 20 minutes, offset 5 minutes after Layer 3.

## No-Change Publishing

If payload material signature did not change:

```text
skip_public_write=true
manifest_status=UNCHANGED_SKIPPED
```

This keeps disk I/O low.

## Performance Metrics

ARL must track:

```text
last_cycle_ms
work_budget_ms
symbols_processed_this_cycle
symbols_remaining
modules_deferred
writes_attempted
writes_skipped_unchanged
readback_failures
retry_queue_size
indicator_building_count
```
