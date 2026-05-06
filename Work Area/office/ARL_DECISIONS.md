# ARL Decisions

## Decision format

Each decision must include:
- Date
- Decision
- Reason
- Evidence / source
- Affected files/modules
- Reversal condition

---

## D001 — Start ARL as a clean second-generation rebuild

Date: 2026-05-06

Decision:
Aurora Reforged Lattice is a clean rebuild that preserves the high-level ASC design but does not directly inherit ASC source authority.

Reason:
ASC has useful architecture and dossier/board DNA, but also accumulated route drift, verbose diagnostics, stale/retained output risks, board-child sync issues, HUD bloat, and repair-on-repair complexity.

Evidence / source:
- Uploaded Market Board sample shows useful currentness and review authority concepts but also shows board/child alignment complexity and top5 sync uncertainty.
- Uploaded CADSGD dossier shows useful numeric deep review, publication health, and section status, but is too verbose for ARL operator output.
- Uploaded EURUSD SDP shows atomic publication concepts and L3/L4 owner-gap problems that ARL must solve by design.

Affected:
All ARL planning and migration.

Reversal condition:
Only if a later source inspection proves a specific ASC module can be migrated safely after simplification, compile proof, runtime proof, and lock registration.

---

## D002 — No HUD until core works

Date: 2026-05-06

Decision:
HUD is excluded from all early ARL phases.

Reason:
The old system carried HUD complexity too early. ARL must first prove runtime, account, market state, specs, ranking, board publication, and dossiers.

Affected:
Roadmap, build plan, migration register.

Reversal condition:
HUD may be reconsidered only after ARL core publishes stable outputs and passes compile/runtime/output contract tests.

---

## D003 — Major/minor bucket means hierarchy, not forex-pair major/minor

Date: 2026-05-06

Decision:
Major bucket = broad class. Minor bucket = subgroup inside that class.

Examples:
- Major: FOREX, CRYPTO, METALS, INDICES, COMMODITIES, STOCKS
- Minor: FOREX_EXOTICS, FOREX_MAJORS, CRYPTO_ALTCOINS, CRYPTO_MAJOR_COINS, METALS_GOLD_SILVER, INDICES_US, STOCKS_TECH

Reason:
Earlier wording risked confusing bucket hierarchy with forex-pair vocabulary.

Affected:
Layer 4 / Bucket Ranking, Market Board, Dossier samples, bucket schema.

Reversal condition:
None. This is locked as naming law unless user explicitly changes the taxonomy.

---

## D004 — Internal layer names may exist, but operator outputs must use plain meanings

Date: 2026-05-06

Decision:
Internal code may use Layer 1-5, but final operator-facing output should use readable names:
- Market State
- Broker & Symbol Specs
- Surface Ranking
- Bucket Ranking
- Deep Review

Reason:
User specifically requested that dev language not leak into final product meaning.

Affected:
Market Board, Dossiers, samples, output contracts.

Reversal condition:
Only if operator output has both readable labels and optional internal trace fields in debug JSON.

---

## D005 — L3/L4 warmup must reach completion before READY

Date: 2026-05-06

Decision:
Warmup cannot declare READY until Layer 3 / Surface Ranking and Layer 4 / Bucket Ranking publish complete committed snapshots.

Reason:
ASC samples showed danger of current-looking outputs while board/child alignment or promote status remained pending.

Affected:
Warmup contract, Scheduler, Market Board, acceptance tests.

Reversal condition:
None. Half-ready ranking is forbidden.

---

## D006 — Ready cadence

Date: 2026-05-06

Decision:
After warmup READY:
- L3 / Surface Ranking: every 20 minutes, universe-wide.
- L4 / Bucket Ranking: every 20 minutes, offset 5 minutes after L3.
- L2 / Broker & Symbol Specs: every 1 minute for active L4 set.
- L5 / Deep Review: every 5 minutes for active L4 set.
- L1 / Market State: event/schedule-based, retry only unknowns, schedule closed markets to next open.

Reason:
Prevents heavy full-universe recomputation while keeping active candidates fresh.

Affected:
Refresh Timing Model, Scheduler, Warmup, L3/L4 snapshot contract.

Reversal condition:
Runtime evidence proves the cadence misses key updates or is too heavy.

---

## D007 — Numeric-first output

Date: 2026-05-06

Decision:
Operator outputs must be numeric-first. Labels are optional support.

Reason:
Old dossiers used useful numbers but too many qualitative labels. ARL should preserve scores and reduce wording.

Affected:
Market Board sample, Dossier sample, numeric style guide, output contracts.

Reversal condition:
Only if the user requests a more narrative operator mode after numeric mode is proven.

---

## D008 — Account and exposure are mandatory

Date: 2026-05-06

Decision:
ARL must include account info, open positions, pending orders, and closed/deal history lookback in the board and dossiers.

Reason:
Ranking without account exposure is unsafe and can suggest symbols already carrying risk.

Affected:
Account module, Market Board, Dossiers, upload suggestion logic.

Reversal condition:
None. Account exposure is mandatory for review workflow.

---

## D009 — Fix owner modules, do not create bypass routes

Date: 2026-05-06

Decision:
If a behavior breaks, fix the owning module. Do not create duplicate routes, bypass writers, shadow outputs, or emergency alternate files.

Reason:
ASC repair cycles accumulated route drift. ARL must prevent that from the start.

Affected:
Lock policy, migration register, future patch prompts.

Reversal condition:
A new route may only be created with explicit route-change record, tests, rollback plan, and user approval.

---

## D007 — Work Area is the active uploadable source root

Date: 2026-05-06

Decision:
`Work Area/` is the active source root for zip-first GPT repair passes. Archives must not be included in uploaded Work Area zips.

Reason:
The archive tree is too large for repeated upload workflows and must not pollute the current active source package. Archives are inheritance evidence only and should be read from Git when needed.

Evidence / source:
ARL-RUN005 uploaded zip inspection confirmed `Work Area/` as the only root and confirmed no `Archives/` folder inside the uploaded package.

Affected files/modules:
GPT zip workflow, source-truth authority, run protocol, packaging rules.

Reversal condition:
Only if the user explicitly changes the source-baseline workflow.

---

## D008 — Current EA product version remains 1.004 after RUN005

Date: 2026-05-06

Decision:
Keep active EA product version at `1.004` for ARL-RUN005. Do not bump to `1.005`.

Reason:
RUN005 corrected identity drift and office/process records but did not add active product behavior, trading, signals, execution, HUD, strategy formulas, or runtime publication logic.

Evidence / source:
The changed MT5 source fields only align `#property version`, `#property description`, `ARL_PRODUCT_VERSION`, and README identity.

Affected files/modules:
`mt5/ARL_Core.mq5`, `mt5/core/ARL_Version.mqh`, `mt5/README.md`, `mt5/MT5_VERSION_POLICY.md`.

Reversal condition:
If a later run changes active MT5 behavior, version may advance by the a.bcd rule.

## D009 — RUN007 pre-work unification keeps product version 1.004

Decision: keep ARL product version at `1.004` for RUN007.

Why: RUN007 is a source-record, office, roadmap, blueprint, and reference-law alignment pass. It does not implement runtime publication, trading, signals, execution, HUD, strategy formulas, or direct ASC archive migration.

Constraint: MT5 source identity may state `ARL-RUN007` as the current source alignment run, but Git/office remain the history owners. MT5 source must not become a changelog.

Falsifier: if a future diff shows active MT5 behavior was changed in RUN007 beyond identity/header alignment, this decision is invalid and the product version must be bumped to the next correct `a.bcd` value.

## D010 — Git messages must be detailed but structured

Decision: use a proper Git summary plus deep structured description.

Git summary format:
`AURORA REFORGED LATTICE — ARL-RUN### / PRIMARY PURPOSE + SECONDARY PURPOSE`

Git description must include: mode, summary, why, what changed, files added, files changed, inspected-but-not-changed files, boundaries, version impact, evidence, risks, and next move.

Why: tiny messages lose traceability; pasted full ChatGPT reports create noise. The correct middle path is a clean header and deep description.
