# ASC Symbol Information Spine Contract

## Purpose

This contract locks one shared symbol information architecture for:
- HUD symbol context pages
- Symbol Dossier
- Current Focus
- Market Board and summary surfaces
- future expansion scaffold homes (engineering-owned)

This file is normative for information ownership, section naming, and cross-surface mapping.
It is a specification lock, not a full feature implementation order.


Role-separation note:
- **Market Board** is a compact cross-symbol inspection surface and does not own the full symbol section families.
- **Dossier** is the full per-symbol intelligence artifact and consumes the section families at fullest lawful depth.
- **Current Focus** is the singleton selected-symbol working artifact and may mirror dossier depth closely, but remains a distinct consumer surface.
- None of these surfaces is a truth birthplace or signal engine.

Binding references:
- `11_ASC_HUD_AND_OPERATOR_SURFACE.md`
- `ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md`
- `ASC_BOARD_DOSSIER_CURRENT_FOCUS_CONTRACT.md`
- `ASC_SCOPE_BOUNDARY_AND_ADMISSIBILITY_MAP.md`

---



## Stage 3 Deep Analysis spine addendum

Where Dossier or Current Focus exposes Deep Analysis, the symbol-information spine must preserve the control/completeness split.

Mandatory Deep Analysis completeness family when Deep Analysis is present:
- `output_mode`
- `timeframe_enablement`
- `timeframe_completeness`
- `bars_requested`
- `minimum_bars_required`
- `bars_copied`
- `bars_missing`
- `sufficiency_posture`

Mandatory optional-evidence families when enabled:
- ATR settings + ATR posture
- spread settings + spread statistics + spread sufficiency posture
- tick settings + tick statistics + tick sufficiency posture

Forbidden spine drift:
- hiding insufficiency by collapsing enabled timeframes into one generic `history ok` line
- omitting copied/missing counts for enabled timeframes
- treating output mode as truth ownership
- turning handoff blocks into ASC-owned final signal blocks

## Stage 4 layer-contract and handoff spine addendum

This addendum completes the symbol-information mapping for the finished Layer 1 through Layer 5 field contracts.

### Doctrine tier lock

#### Hard law
- Symbol-context consumers must preserve required layer fields even when rendering compactly.
- Optional enrichments must remain visibly optional and must not become hidden hard law.
- Future expansion placeholders must stay labeled as future.
- Layer 5 must preserve the observed-truth vs interpreted-truth split in consumer mapping.
- The final handoff block remains a downstream handoff aid, not an ASC-owned final signal panel.

#### Required product contract
Where symbol-context surfaces expose Layer 1 through Layer 5 truth, they must map the following minimum field families:

- **Layer 1 / Overview**
  - market state
  - market-state reason
  - freshness posture
  - confidence posture
  - next recheck posture
  - degraded / uncertain warning

- **Layer 2 / Market Watch**
  - bid / ask / spread
  - spread percentage posture
  - tick age
  - packet freshness
  - packet continuity / degraded posture
  - day-range posture
  - tradability posture

- **Layer 3 / Selection Filter**
  - eligibility state
  - eligibility code
  - eligibility reason
  - block type where applicable
  - retry posture
  - next useful step
  - survivor bucket where applicable

- **Layer 4 / Shortlist Context**
  - selection state
  - attention-priority rank framing
  - shortlist posture
  - shortlist reason
  - promotion basis or denial reason
  - what changes to enter
  - hold / stability posture
  - exposure / correlation warning where applicable

- **Layer 5 / Deep Analysis**
  - all 12 mandatory subsection homes
  - observed evidence families
  - interpreted-truth families
  - preservation / continuity posture
  - SIAM / analyst handoff block

#### Future expansion option
Later work may add richer visuals, alternate compact summaries, and richer subsection notes, but the required families above must remain visible or inspectably available.

### Layer 5 subsection mapping rule
Dossier and Current Focus must preserve the ordered Layer 5 subsection model exactly:
1. `deep_analysis_overview`
2. `timeframe_settings`
3. `bar_pack`
4. `ohlc_by_enabled_timeframe`
5. `bar_interpretation`
6. `recent_tick_activity`
7. `live_spread_rollover`
8. `preservation_state`
9. `microstructure_notes`
10. `advanced_context`
11. `decision_support`
12. `siam_analyst_handoff`

No symbol-context surface may collapse `siam_analyst_handoff` into a final signal box or hide mandatory completeness posture behind cosmetic compactness.

## Shared symbol section families (exact)

Every symbol-context surface must map data into these exact families, in this exact order:
1. **Overview**
2. **Market Watch**
3. **Specification**
4. **Selection Filter**
5. **Shortlist Context**
6. **Deep Analysis**
7. **Future Expansion**
8. **Future Expansion**

No alternative section taxonomy is admissible for symbol-context outputs.

---

## Section contract matrix

| Section family | Purpose | Exact question answered | Owning layer / owner family | HUD shows | Dossier shows | Current Focus shows | Board/Summary may show | Placeholder posture now | Operator-safe wording | Engineering-only wording (forbidden in operator view) |
|---|---|---|---|---|---|---|---|---|---|---|
| Overview | establish symbol identity + scanner posture anchor | “What symbol is this and what is its current scanner posture?” | Layer 1 market-state + classification identity owner | compact identity header and posture lines | full identity lineage and posture note | compact selected-symbol posture | compact badge/count context only; board never becomes per-symbol owner | never empty; show bounded missingness | `not yet available`, `unavailable`, `awaiting next refresh` | runtime struct keys, internal enum names |
| Market Watch | selected-symbol live watch and freshness | “What is current quote/freshness state for this symbol?” | Layer 2 open-symbol snapshot owner + tactical selected-symbol strip contract | selected-symbol quote strip and freshness only | richer quote/freshness packet and continuity notes | compact quote/freshness snapshot | board-level aggregate freshness only (no per-symbol stream) | if packet absent: explicit pending admission and no synthetic zero quote values | `awaiting open-symbol snapshot`, `unavailable` | packet internals, cache field names |
| Specification | broker/trading specification truth | “What constraints/specs apply to this symbol?” | symbol specification and classification contract owner | most useful trader-safe constraints only | full specification section with explicit missingness | compact headline constraint posture | none required except summary availability flag | allowed `not applicable` per symbol/server | `not applicable`, `unavailable` | raw symbol property ids |
| Selection Filter | candidate filter eligibility truth | “Has this symbol passed selection filter and why?” | Layer 3 selection filter owner (active runtime owner) | section home with explicit current state | full section home with reasons and dependencies | one-line posture plus next-step summary | board may show compact per-symbol filter truth and aggregate counts | active runtime truth | `Passed Candidate Filtering`, `Pending Candidate Filtering`, `Failed Candidate Filtering`, `awaiting next refresh` | gate internals, debug flags |
| Shortlist Context | shortlist membership context | “Is this symbol shortlisted and in what context?” | Layer 4 shortlist owner (future runtime owner) | section home with shortlist scaffold state/reason summary | section home with shortlist scaffold fields and lineage | compact selected-symbol shortlist scaffold summary | board may show scaffold-only summary line items | scaffold only in current runtime | `awaiting section activation`, `not yet available`, `unavailable` | shortlist ranking internals |
| Deep Analysis | deep selective analysis context | “What deep posture is available for this symbol?” | Layer 5 deep analysis owner (future runtime owner) | section home + scaffold eligibility posture | rich section home reserved for deep subsections when admitted | compact selected-symbol deep posture, which may summarize dossier depth for the active symbol | board may show posture tag only; board must not expose deep internals | scaffold only in current runtime | `awaiting section activation`, `not yet available`, `unavailable` | deep payload internals |
| Future Expansion | reserved semi-automatic bridge home | “What is reserved for future Layer 6 behavior?” | future owner; non-admissible runtime now | non-interactive placeholder | non-interactive placeholder | non-interactive placeholder | none | scaffold only | `future scaffold (not active)` | future runtime tokens |
| Future Expansion | reserved full-automation bridge home | “What is reserved for future Layer 7 behavior?” | future owner; non-admissible runtime now | non-interactive placeholder | non-interactive placeholder | non-interactive placeholder | none | scaffold only | `future scaffold (not active)` | future workflow internals |

---

## Layout law lock (symbol context)

Inside symbol context, HUD layout must obey this structure:
1. **Top header strip**: symbol + compact state + compact key posture.
2. **Persistent symbol action row (top)**: `Deep Analysis`, `Aurora Signal`, `Semi-Auto`, `Full Auto`, `Sync`; visible only when a symbol is selected.
3. **Main content page**: exactly one symbol section family page at a time.
4. **Persistent symbol section navigation row (bottom)** with exact buttons:
   - `Overview`
   - `Market Watch`
   - `Specification`
   - `Selection Filter`
   - `Shortlist Context`
   - `Deep Analysis`
   - `Future Expansion`
   - `Future Expansion`

The bottom symbol section navigation row is mandatory in symbol context and must preserve selected symbol context across section switches.
Current Focus must follow that selected symbol context and be rewritten in place on symbol switch.
Deep Analysis page-open alone is not evidence of deep execution; explicit trigger path is required.

---

## Information duplication law

The same symbol fact must have one canonical home.
Cross-page repetition is allowed only when context requires compact reference.

Canonical homes:
- identity/posture anchor -> Overview
- quote/freshness details -> Market Watch
- specification constraints -> Specification
- filter/shortlist/deep/future -> Selection/Shortlist/Deep/Future section homes

Page role law (non-optional):
- **Overview** is the shortest page and must carry only current high-value symbol posture.
- **Market Watch** is the live/current page and must carry dynamic quote/freshness/session posture.
- **Specification** is the broker contract/rules page and must carry dynamic specification constraints.
- **Selection Filter** is the gate-result page and must remain distinct from shortlist/deep-analysis outcomes.

---

## Dynamic field law (broker/symbol variability)

Surfaces must be schema-stable but field-flexible:
- keep section homes stable,
- omit non-applicable low-value fields,
- never fabricate values,
- always emit truthful missingness posture.

Allowed missingness words:
- `not yet available`
- `unavailable`
- `not applicable`
- `awaiting section activation`
- `awaiting next refresh`

Broker descriptor law:
- broker descriptors must be labeled with explicit trust posture (`broker-supplied (unverified)` or `unavailable`)
- descriptor text must not imply external verification when only broker metadata is available
- descriptor absence must remain explicit and must not be backfilled with synthetic values

Approximation and placeholder law:
- touched ATR/regime/liquidity/friction/context summaries must be labeled as approximation or placeholder summary when deeper model support is unavailable
- readability cleanup may reduce duplicate metadata lines, but freshness and uncertainty indicators must remain visible

---

## Surface role split

- **HUD**: concise operator navigation and decision context; selected-symbol-first.
- **Dossier**: richest symbol surface with explicit section lineage and the full per-symbol intelligence packet.
- **Current Focus**: compact selected-symbol executive summary mapped to the same section families.
  - ownership lock: singleton selected-symbol working file, not trigger-owned-only.
  - anti-drift: Current Focus selection does not itself prove Layer 5 completion.
- **Board/Summaries**: aggregate scanner posture and only compact references into symbol section families.
  - anti-drift: Market Board stops at Layer 4 depth and must not become a Deep Analysis or signal dashboard.

---



## Stage 5 consolidation note

### Hard law
- Symbol-context consumers must preserve the difference between observed truth, interpreted truth, deep readiness, deep completion, and downstream handoff.
- Dossier and Current Focus may present lawful Layer 5 output only when it actually exists.
- Board-level consumer surfaces must not present Layer 5 or final-signal ownership.

### Required product contract
- Compact surfaces must keep enough metadata for a reader to tell whether Deep Analysis is absent, partial, degraded, continuity-backed, or complete.
- Any handoff-facing text must preserve that SIAM / Aurora remains downstream interpretation authority.

### Future expansion option
Later implementation may add richer visual summaries or convenience views without changing the role split above.


## Implementation alignment notes (bounded, this pass)

This architecture pass is specification-first.
Implementation alignment in this pass is bounded to naming/contract synchronization only:
- HUD symbol section labels must use the locked section-family wording in button rows and section titles.
- Dossier and Current Focus section headings must stay in the same eight-family order.
- Board/Summary files may reference the section families as compact hooks only and must not duplicate full symbol-page payloads.
- Future Expansion homes remain scaffold-only with explicit non-active wording.

No broader runtime layer activation is authorized by this contract.

---

## Mini debug session checklist (must pass before closing a symbol-architecture pass)

1. Every symbol page has one clear role and one owning section family.
2. Persistent top action row and persistent bottom section navigation row are both locked and scoped to selected-symbol context.
3. HUD, Dossier, Current Focus, and Board/Summary mappings all point to the same eight-family section spine.
4. Repeated shallow multi-page duplication is removed from the architecture contract; canonical field homes are explicit.
5. Future Expansion scaffold homes are present with truthful non-active wording and no fabricated payload claims.
6. Blueprint, office records, and touched active code naming are synchronized for the section-family contract.

---

## Present-stage admissibility

Current admissible runtime truth in this contract:
- Overview (active)
- Market Watch (active where market-watch packet exists)
- Specification (partially active, bounded by available symbol properties)
- Selection Filter is active runtime truth (Layer 3 owner).
- Shortlist Context remains explicit scaffold until Layer 4 runtime authority is admitted.
- Deep Analysis remains explicit scaffold until Layer 5 runtime authority is admitted.
- Future Expansion homes remain explicit scaffold unless separately admitted.

No operator-visible layer/stage/phase/pipeline wording is admissible on symbol surfaces; no capability may be implied active if it is still scaffold-only.

---

## Acceptance checks (for any future implementation pass)

1. All symbol surfaces use the exact 8 section families.
2. Top action row and bottom section navigation row are present in symbol context contract behavior.
3. Section ownership and missingness posture are explicit.
4. Operator-safe wording contains no engineering/internal leakage.
5. Future Expansion remains scaffold-only unless explicitly promoted by blueprint.
