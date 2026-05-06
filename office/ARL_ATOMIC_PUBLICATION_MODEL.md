# ARL Atomic Publication Model

## Purpose

This file defines how ARL writes outputs safely.

## Core law

No public file may be directly overwritten with half-built content.

Public outputs must be composed, validated, written to temp, checked, promoted, and manifested.

## Atomic write sequence

```text
1. Compose payload in memory.
2. Validate required tokens/fields.
3. Generate payload signature/hash.
4. Compare with current material payload if current exists.
5. If materially unchanged, skip public write and update heartbeat/manifest only.
6. Write to final_path.tmp.
7. Flush and close temp file if public artifact.
8. Read back temp and validate required token/field set.
9. Promote temp to current file.
10. Write manifest row.
11. Archive changed snapshot only if material content changed.
```

## Required fields for every public artifact

```text
system=ARL
artifact_family=
artifact_name=
schema_version=
producer=
cycle_id=
snapshot_id=
source_snapshot_id=
generated_utc=
publish_started_utc=
publish_finished_utc=
publish_result=
publish_reason=
trade_permission=false
```

## Snapshot families

| Family | Example |
|---|---|
| account | Account_Current.json |
| status | Status_Current.json |
| universe | Universe_Current.json |
| l3 | L3_SurfaceRank_Current.json |
| l4 | L4_GroupRank_Current.json |
| market_board | MarketBoard_Current.txt/json |
| symbol | Symbols/<symbol>/Symbol_Current.json |
| dossier | Symbols/<symbol>/Dossier_Current.txt |
| retry_queue | RetryQueue_Current.json |
| manifest | Manifest_Current.json |

## L3 publication

Surface Ranking writes:

```text
L3_SurfaceRank_Staging.json
```

Promote only if:
- processed_count == expected_rank_eligible_count
- all rows have required numeric fields
- snapshot_id present
- scoring_version present
- no row has unknown exact symbol
- no required score is missing

Promoted outputs:
```text
L3_SurfaceRank_Current.json
L3_SurfaceRank_Current.txt
L3_CommitManifest_Current.json
```

## L4 publication

Bucket Ranking consumes only:
```text
L3_SurfaceRank_Current.json
```

Bucket Ranking writes:
```text
L4_GroupRank_Staging.json
```

Promote only if:
- l4_consumed_l3_snapshot_id matches current L3 snapshot id
- Global Top 10 created or marked insufficient population
- every major bucket complete or available_count_below_target
- every minor bucket complete or available_count_below_target
- active_l4_set built and deduplicated
- all rows reference exact broker symbol

Promoted outputs:
```text
L4_GroupRank_Current.json
MarketBoard_Current.txt
MarketBoard_Current.json
L4_CommitManifest_Current.json
```

## No-change rule

If new payload equals current material payload:
- do not rewrite current
- update manifest heartbeat if needed
- do not reset artifact age incorrectly

## Last-good rule

A retained last-good file may support continuity but must not be marked current.

## Failure rule

If temp write/readback/promote fails:
- current file remains unchanged
- manifest records failure
- status output shows failure
- no partial file becomes current
