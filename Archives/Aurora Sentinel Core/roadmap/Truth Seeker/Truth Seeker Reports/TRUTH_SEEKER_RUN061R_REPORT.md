# RUN061R REPORT — Market Board Portfolio Projection + Publication Safety Hardening

Decision: PASS SOURCE PATCH / LIVE UNPROVEN.

Summary:
- Source package was readable and compile root was present.
- RUN060R patch claims were verified in current source.
- A compile-safety gap was found: Market Board called ASC_PortfolioAggregateProofTokens(snapshot,"market_board") while the portfolio owner only exposed the longer aggregate-counter signature.
- RUN061R repaired that gap by adding a bounded overload inside ASC_PortfolioExposureSnapshot.mqh.
- Market Board publication safety was hardened with explicit minimum skeleton, fail-soft, file-write-status, portfolio/history section status, and GlobalTop10-not-touched tokens.
- Portfolio Truth Snapshot now has distinct Open Positions, Pending Orders, and Recent Closed Trades sections.
- History unavailable is labelled as unavailable and not converted into zero closed trades.
- FunctionResults remain aggregate-only.
- GlobalTop10 source/publication/archive/manifest/renewal/ranking/selection logic was not modified.

Changed files:
- mt5/artifacts/ASC_MarketBoardWriter.mqh
- mt5/portfolio/ASC_PortfolioExposureSnapshot.mqh
- mt5/core/ASC_Version.mqh
- roadmap/Truth Seeker/TRUTH_SEEKER_ACTIVE_ROADMAP_LOG.md
- roadmap/Truth Seeker/TRUTH_SEEKER_RUN061R_REPORT.md

Proof status:
- Compile: not claimed.
- Live/runtime: not claimed post-patch.
- Static source check: repaired visible aggregate proof signature mismatch and avoided GlobalTop10 touch.
- Next proof: RUN062R must run fresh compile/live output after this patch.
