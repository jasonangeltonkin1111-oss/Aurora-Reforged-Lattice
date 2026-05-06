# ARL Open Questions

## Purpose

This file tracks items that must be resolved before they become source law.

## Q001 — Universe mode

Question:
Should ARL begin with Market Watch only or all broker symbols?

Current recommendation:
Market Watch only for first stable build.

Reason:
Faster, controlled, less symbol classification noise.

Default:
MARKET_WATCH_ONLY.

## Q002 — Exact major/minor bucket list

Question:
What final bucket taxonomy should be used for:
- FOREX
- CRYPTO
- METALS
- INDICES
- COMMODITIES
- STOCKS

Current recommendation:
Create a bucket taxonomy file in ARL-RUN002 or ARL-RUN003.

## Q003 — Account privacy mode

Question:
Should runtime local outputs show full account login by default or use a setting?

Current recommendation:
Local runtime can include full account only if `ARL_PRIVATE_OUTPUT_MODE=true`.
Repo samples must mask.

## Q004 — Layer 5 active set width

Question:
Should L5 run on full active L4 set, or only major leaders + manual, while still refreshing L2 for the active set?

Current user direction:
Layer 5 every 5 minutes, only for what is inside Layer 4.

Current recommendation:
For first build:
- L5 scheduler sees active_l4_set.
- Auto-heavy deep calculations run only on major-bucket leaders.
- Lighter L5 status refresh can update all active_l4_set.
- Manual deep may request any active symbol.

Needs final confirmation before formulas.

## Q005 — Output format

Question:
Should Market Board and Dossier be TXT only, JSON only, or both?

Current recommendation:
Both:
- JSON = machine/contract authority
- TXT = operator read
TXT must be generated from JSON, not separate truth.

## Q006 — Runtime archive retention

Question:
How many historical snapshots should local runtime keep?

Current recommendation:
Keep current always.
Archive only materially changed MarketBoard/Dossiers.
Use size/time cap later.

## Q007 — First compile checkpoint

Question:
Should ARL-RUN002 scaffold compile or only create folder/files?

Current recommendation:
ARL-RUN002 = scaffold only.
ARL-RUN003 = minimal compile/status proof.

---

## RUN005 Open Questions

1. Can a future research-capable run refresh official MQL5/Git/retry/observability sources and cite them directly?
2. Does MetaEditor compile still pass after version identity alignment?
3. Should `ARL_Core.ex5` be excluded from future upload zips unless intentionally preserved as a known compiled artifact?
4. Should RUN006 implement heartbeat/status publication, or should it first perform a pure compile-repair/validation pass in MetaEditor?
