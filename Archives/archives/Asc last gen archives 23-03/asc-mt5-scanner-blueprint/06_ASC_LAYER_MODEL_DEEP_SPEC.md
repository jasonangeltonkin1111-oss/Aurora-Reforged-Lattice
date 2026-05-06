# ASC Layer Model Deep Spec

## Layer 1 — Market State Detection
- whole-universe first-pass acquisition
- internal states: Open / Closed / Uncertain / Unknown
- boot confirmation rechecks
- schedule-driven maintenance
- compact atomic Layer 1 publication

## Layer 2 — Open Symbol Snapshot
- selective current packet for open symbols only
- last-good continuity
- focused-symbol fast packet reads allowed
- no broad fast refresh because the HUD is open

## Layer 3 — Candidate Filtering
- cheap eligibility only
- consumes Layer 1 + Layer 2 truth
- no ranking
- no heavy history
- no shortlist competition

## Layer 4 — Shortlist Selection
- bounded top-5-per-main-bucket authority
- honest spill/fill behavior when a bucket has fewer than 5 members
- anti-churn and hold windows
- final promoted-set authority for Layer 5 entry

## Layer 5 — Deep Selective Analysis
- rank-sensitive promoted-set refresh only
- default cadence:
  - rank 1 = 5s
  - rank 2 = 10s
  - rank 3 = 15s
  - rank 4 = 20s
  - rank 5 = 25s
- no broad-universe deep churn

## Focus law

Focus is not a separate layer.
It is a bounded request that may elevate only already-owned fields for the currently focused object.
