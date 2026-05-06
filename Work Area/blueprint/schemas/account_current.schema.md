---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# Account Current Schema

This is a blueprint schema description, not a formal JSON Schema file yet.

## Required Metadata

- `schema_version`
- `generated_utc`
- `source`
- `snapshot_id` where applicable
- `status`
- `permissions` where operator relevance exists

## Required Validation Rules

- Required fields must not silently default.
- Missing required fields must produce a missing reason.
- Optional missing fields must be counted.
- Irrelevant missing fields must not degrade operator output.
- Numeric fields must use stable decimal formatting.
- Permission fields must remain false unless later explicitly authorized and proven.
