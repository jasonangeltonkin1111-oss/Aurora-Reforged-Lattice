# ASC Front-Door Checklist

## Mandatory pre-checks

1. Compile root verified: `mt5/AuroraSentinelCore.mq5`.
2. Ownership/behavior claims verified in compile-path MT5 files.
3. `roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md` has been read first in the current Truth Seeker pass.
4. The active roadmap lane is under `roadmap/Truth Seeker/`.
5. Old Doc 16 / Doc 17 / Doc 18 continuation is not being treated as active authority.
6. Scope is one pass type and one bounded lane.
7. The pass does not rely on `archive/docs/`, stale office roadmaps, or `mt5/office/` for active control truth.
8. Stale roadmap wording is not being mistaken for current product direction.
9. Code edits are backed by a named audit seam, internet research, and compile-path file/function trace.
10. No compile/live proof is claimed without actual compile/live evidence.

## Hard blockers

- Any active doc pointing at a missing or retired path.
- Any active doc treating `mt5/office/` as the live office surface.
- Any active doc claiming roadmap authority from superseded roadmap folders.
- Office/control wording that overstates completion not supported by current active files.
- Scope drift into runtime, HUD, strategy, ranking, indicator, or owner logic before the active phase authorizes it.
- Reuse of stale artifact/product naming as if it were current roadmap authority.
- Office-only or version-only churn on a run that requires a source truth patch.

## GO

Proceed only when the active entry chain is internally consistent and points only to live intended files.
