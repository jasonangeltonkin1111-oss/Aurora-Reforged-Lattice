---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Product Vision

Aurora Reforged Lattice is a lightweight market-truth engine for MT5.

It must help the operator answer:

1. Which symbols are alive and usable right now?
2. Which symbols have broker/spec data clean enough for review?
3. Which symbols rank best on fast surface metrics?
4. Which symbols lead globally, per major bucket, and per minor bucket?
5. Which symbols deserve deep review now?
6. Which candidates should be uploaded/reviewed as best 3, best 5, or best 10?
7. Which candidates should be excluded due to exposure, stale data, closed market, or poor friction?
8. What data is missing, stale, partial, optional, or irrelevant?

ARL is not a black-box trading bot.

ARL is not a signal seller.

ARL is not a prop-firm deployment claim.

ARL is a review system that turns broker/platform facts, market-state facts, ranking facts, account facts, and deep-review facts into clean operator-facing files.

## Final Product Personality

The final product must feel:

- fast
- calm
- numeric
- clean
- strict
- honest about uncertainty
- resistant to fake completeness
- useful for operator decision support

## Final Product Anti-Goals

ARL must not become:

- a giant dispatcher
- a HUD-first system
- a route maze
- a placeholder factory
- a report-writing monster
- a hidden signal system
- a source-of-truth blur
- an archive copy of ASC
