---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Operator Workflow Blueprint

## Final Workflow

1. Start ARL.
2. Warmup runs.
3. Market Board publishes when L3/L4 completion is real.
4. Operator checks:
   - Global Top 10
   - major bucket top 5
   - minor bucket top 5
   - account exposure
   - best 3/5/10 upload list
   - exclusions
5. Operator uploads selected Market Board / Dossier files to external review if needed.
6. Layer 5 refreshes active candidates every 5 minutes.
7. Dossiers update for active candidates.
8. Operator never treats ranking as trade permission.

## Operator Output Must Answer

```text
What is best now?
Why numerically?
What is excluded?
What is stale?
What is missing?
What has account exposure?
What should be uploaded?
When is the next refresh?
```

## No HUD

HUD is explicitly deferred.

The final product must work through files first:

- Market Board
- Symbol files
- Dossiers
- Manifests
- Logs

HUD can only come after the core is proven and locked.
