---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# Operator Terms

- Market State: whether a symbol is open, closed, stale, unavailable, or unknown.
- Broker Specs: broker-provided symbol constraints and cost facts.
- Surface Ranking: fast numeric rank using cheap metrics.
- Bucket Ranking: Global Top 10, top 5 per major bucket, top 5 per minor bucket.
- Deep Review: expensive same-symbol detail after selection.
- Active L4 Set: deduplicated set of all Global Top 10 + major top 5 + minor top 5 symbols.
- Upload Suggestion: best 3/5/10 review list, not a trading signal.
- Exposure Guarded: account already has open/pending exposure for the symbol.
