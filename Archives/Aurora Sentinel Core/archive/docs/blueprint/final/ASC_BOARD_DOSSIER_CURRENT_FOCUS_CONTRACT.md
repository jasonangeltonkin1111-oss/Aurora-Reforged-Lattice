# ASC Board, Dossier, and Current Focus Contract

## Purpose

This contract freezes the operator-artifact doctrine for the three trader-facing consumer artifacts that sit downstream of ASC truth production:

- **Market Board**
- **Dossier**
- **Current Focus**

It completes the Stage 2 product contract for those artifacts only.
It does **not** reopen runtime code, full menu/settings law, complete layer field schemas, or any signal-engine redesign.

Binding references:
- `03_ASC_FIVE_LAYER_SYSTEM.md`
- `08_ASC_LAYER_5_DEEP_SELECTIVE_ANALYSIS.md`
- `10_ASC_PERSISTENCE_AND_ARTIFACT_FAMILIES.md`
- `11_ASC_HUD_AND_OPERATOR_SURFACE.md`
- `ASC_SYMBOL_INFORMATION_SPINE_CONTRACT.md`
- `ASC_HUD_PAGE_HIERARCHY_AND_PRODUCT_CONTRACT.md`
- `ASC_SYMBOL_ACTION_SURFACE_CONTRACT.md`

---

## Stage 2 artifact tier classification

This file distinguishes three doctrine tiers so future passes do not harden every convenience idea into immutable law.

### Hard law
Hard law in this file is non-negotiable unless a later doctrine pass explicitly reopens it.

Hard law includes:
- ASC / EA remains the truth producer; these artifacts are consumers only.
- Market Board is an inspection-priority board and stops at Layer 4 depth.
- Dossier is the full per-symbol intelligence artifact.
- Current Focus is the singleton currently selected-symbol working artifact.
- None of the three artifacts may become the birthplace of shortlist authority, deep-truth authority, or final trade-signal authority.
- Market Board must not become a signal dashboard.
- Dossier and Current Focus must not become hidden truth owners.
- Current Focus must follow selected-symbol context and must not remain silently pinned to an older symbol.
- Deep Analysis page-open or dossier/current-focus viewing alone must not imply Layer 5 execution.
- Continuity, degraded, stale, and failure posture must remain visible rather than hidden.

### Required product contract
Required product contract in this file is mandatory for product completion, but exact field wording may evolve later as long as intent and role boundaries stay intact.

Required product contract includes:
- required sections and section order
- required top-level metadata
- required row/summary fields
- required publication-state metadata
- required continuity/failure visibility
- required deep-analysis posture wording classes
- required role separation between Market Board, Dossier, and Current Focus

### Future expansion option
Future expansion options are explicitly non-binding in this pass.

Future expansion options include:
- richer visual grouping or styling
- additional compact operator notes
- future dossier appendices
- expanded Current Focus convenience mirrors
- richer deep-analysis presentation detail after later schema passes
- future non-active scaffold surfaces beyond current operator need

Future expansion must never contradict the hard law or reassign truth ownership.

---

## Runtime ownership law (non-negotiable)

Board, Dossier, and Current Focus are runtime-published **consumer artifacts**.
They may compose, summarize, or present lawful committed truth, but they do not originate scanner truth.

They therefore must not:
- invent shortlist membership
- invent deep-analysis payload
- infer hidden signal verdicts
- silently substitute continuity for fresh truth
- become proof of runtime behavior when upstream truth does not support that claim

Stage-side static scaffold files, prompt text, screenshots, and office notes are not substitute publication evidence.

---

## Artifact role separation law

Future work must preserve this exact operator workflow:

1. Trader reads **Market Board**
2. Trader decides what deserves inspection now
3. Trader opens **Current Focus** and/or the symbol **Dossier**
4. SIAM / Aurora interprets exported ASC truth downstream
5. ASC artifacts remain truth-consumer surfaces, not signal engines

### Canonical role map

| Artifact | Canonical role | Main operator question answered | Depth ceiling in this pass | What it must never become |
|---|---|---|---|---|
| **Market Board** | board of what to inspect now | “Which symbols deserve attention first, and which are clean enough to inspect next?” | stops at Layer 4 depth; may show only compact deep-readiness posture | signal board, deep packet dump, hidden shortlist owner |
| **Dossier** | full per-symbol intelligence artifact | “What is the full scanner-owned intelligence picture for this symbol?” | may consume Layer 1-5 truth when available | truth birthplace, signal engine, temporary card substitute |
| **Current Focus** | singleton selected-symbol working artifact | “What is the currently selected symbol posture right now, and what is my working read on it?” | may closely mirror dossier depth for the selected symbol | hidden history set, silently pinned file, signal verdict board |

Any future wording or implementation that blurs these roles is non-compliant.

---

## Naming model (two-layer, mandatory)

ASC uses a strict two-layer naming model:

1. **Internal schema layer**
   - internal keys may remain technical
   - examples: `top_3_per_bucket`, `shortlist_state`, `publication_state`
2. **Operator-visible layer**
   - all visible titles, section names, and filenames must be trader-safe
   - internal schema keys must not leak into operator-facing text

Canonical operator-visible names:
- **Market Board**
- **Current Focus**
- **Dossiers/<SYMBOL>.txt**

Internal examples are mapping aids only and are forbidden in operator-facing filenames/headings.

---

## Trust posture and summary honesty law

All three artifacts must:
- distinguish observed scanner truth from interpreted downstream signal logic
- label broker-supplied descriptors as broker-supplied / unverified when appropriate
- expose freshness, stale, degraded, continuity, and failure posture honestly
- avoid synthetic certainty when a layer or subsection is absent
- keep Layer 5 posture honest: not armed / armed or pending / completed / continuity-backed / unavailable

---

## 1) Market Board contract

Canonical operator-visible name: **Market Board**

### Market Board purpose (hard law)
Market Board is the compact trader-facing **inspection board**.

It exists to answer:
- what deserves inspection now
- what has been promoted
- what is shortlisted
- what passed filter but is outside the shortlist
- what has low / moderate / high overlap
- what appears clean enough to inspect without opening every dossier first

It exists for:
- inspection priority
- shortlist visibility
- low-overlap next-look workflow
- risk/exposure awareness at board depth

It does **not** exist for:
- final signal issuance
- trade direction verdicts
- execution commands
- hidden deep-analysis publication
- replacing dossier/current-focus symbol intelligence

### Market Board depth ceiling (hard law)
Market Board stops at **Layer 4** depth.

It may consume committed truth from:
- Layer 1 market-state / posture truth
- Layer 2 market-watch freshness truth where lawfully available for board summaries
- Layer 3 candidate-filter truth
- Layer 4 shortlist / promotion truth

It may show only **compact deep-readiness posture** for a symbol.
It must **not** dump Layer 5 internals, bar packs, OHLC detail, scenario paths, tick windows, deep evidence blocks, or dossier-depth narrative.

### Required board sections (required product contract)
Every canonical Market Board publication must contain these sections in this order:

1. **Board Header**
2. **Board Posture and Freshness**
3. **Leading Three**
4. **Full Five**
5. **Passed Filter, Outside Shortlist**
6. **Account and Risk Snapshot**
7. **Excluded / Already Active**
8. **Board Notes / Withheld Sections**

`All-Markets Top Ten` remains conditional and may appear between **Full Five** and **Passed Filter, Outside Shortlist** only when its readiness gate is satisfied.

### Required Board Header fields
The board header must show:
- publication timestamp
- publication state
- scanner posture summary
- shortlist cycle / generation identity where available
- selected market universe scope
- explicit statement that the board is for inspection priority, not final signals

### Required board-level freshness/posture fields
The board must expose board-level posture before the operator reads rows:

- overall publication state
- freshness age or last refresh time
- shortlist availability posture
- correlation/exposure support posture
- deep-readiness posture summary at board level
- continuity / degraded / failure note when applicable

### Required bucket / top structure
The board must make board priority visible without forcing the trader to open every symbol artifact first.

Required structure:
- **Leading Three** = the first three inspection-priority symbols per visible board bucket
- **Full Five** = the first five inspection-priority symbols per visible board bucket
- **Passed Filter, Outside Shortlist** = symbols that passed Layer 3 but were not promoted into the active shortlist
- **All-Markets Top Ten** = optional cross-bucket compact inspection table only when readiness is lawful
- **Excluded / Already Active** = symbols intentionally not suitable for immediate fresh inspection because they are already engaged, blocked by exposure, or operationally excluded

Hard guards:
- Leading Three and Full Five are not duplicate authorities
- Leading Three must be a board convenience view derived from the same bucket ordering as Full Five
- Passed Filter, Outside Shortlist must remain visible as a distinct section so the board answers “what passed but is not currently promoted?”
- Excluded / Already Active must remain distinct from shortlist and passed-filter sections

### Required board row fields
Each symbol row/card in **Leading Three**, **Full Five**, **Passed Filter, Outside Shortlist**, and **All-Markets Top Ten** must include the following operator-facing field families in this order:

1. **Identity**
   - symbol
   - market status
   - group
   - subgroup
   - board rank / bucket rank
2. **Inspection Posture**
   - promotion state
   - shortlist state
   - passed-filter state
   - concise inspection reason
3. **Market Watch**
   - freshness
   - bid
   - ask
   - spread
   - spread percent
   - tick age
4. **Market Context**
   - day change
   - ATR
   - regime
   - liquidity / friction posture
   - one compact context-quality line
5. **Correlation / Exposure**
   - overlap class (`low`, `moderate`, `high`)
   - numeric overlap / correlation score
   - top high-overlap peers with values
   - top low-overlap peers with values
   - open-trade / pending-order conflict posture
   - one compact exposure interpretation
6. **Deep Readiness Posture** (compact only)
   - allowed visible values: `not armed`, `armed/pending`, `completed`, `continuity-backed`, `unavailable`
   - no internal Layer 5 payload fields

### Correlation / exposure visibility requirements
The board must make next-look overlap visible at row level and board level.

Required rules:
- every shortlist and passed-filter row must include a correlation / exposure line
- board-level notes must summarize low / moderate / high overlap mix across the active shortlist where possible
- overlap visibility must help the trader identify low-overlap next inspections
- when support inputs fail, the row must still carry explicit degraded wording rather than silently omit the line

### Account / risk snapshot requirements
**Account and Risk Snapshot** must expose:
- balance
- equity
- free margin
- used margin
- margin level
- open trades
- pending orders
- open risk estimate
- one compact exposure note

This section is required even when degraded.
Missing values must remain visible as degraded / continuity / failure, not blank.

### Excluded / already-active section requirements
**Excluded / Already Active** must expose one row per affected symbol with:
- symbol
- explicit status (`excluded`, `already active`, `pending order`, or equivalent trader-safe wording)
- direction when applicable
- entry when applicable
- stop when applicable
- target when applicable
- stop size when applicable
- one concise reason / posture note

This section exists so the trader can separate “worth inspection” from “already engaged / intentionally out.”

### Board Notes / withheld-section requirements
The board must explicitly say when a section is withheld.

Examples:
- `All-Markets Top Ten withheld: correlation/exposure support unavailable.`
- `Passed Filter, Outside Shortlist unavailable: shortlist lineage incomplete.`
- `Board continuity mode: using last good shortlist snapshot from <timestamp>.`

### Market Board anti-drift law
Market Board must not:
- present final directional calls
- rank symbols as “best trade”
- hide shortlist provenance
- hide passed-filter-but-not-promoted candidates
- hide overlap posture
- publish Layer 5 internals
- become the only place where a symbol can be understood

---

## 2) Dossier contract

Canonical operator-visible filename pattern: **`Dossiers/<SYMBOL>.txt`**

### Dossier purpose (hard law)
Dossier is the **full per-symbol intelligence artifact**.

It is the richest lawful scanner-owned view of one symbol.
It must remain useful:
- when only Layer 1-4 truth is available
- when Deep Analysis is pending
- when Deep Analysis completed
- when continuity is carrying parts of the symbol picture
- when one or more sections failed

Dossier is a **consumer artifact**, not the birthplace of truth.

### Dossier top-level role
Dossier exists to provide:
- archival per-symbol intelligence continuity
- full section-by-section scanner truth posture
- stale / degraded / failure visibility per section
- full visible continuity posture
- deep-analysis section detail when available
- explicit separation between observed scanner truth and downstream interpretation

### Required dossier top-level metadata
Every dossier must begin with top-level metadata containing:
- symbol
- canonical symbol
- publish time
- dossier publication state
- current section coverage summary
- deep-analysis posture summary
- continuity summary
- last successful publish time

### Required publication-state metadata per section
Every required dossier section must carry:
- `publication_state`
- `state_reason`
- `source_age_ms` or equivalent age field
- `continuity_state`
- `last_refreshed_at`
- `source_generation_id` when lawful and available
- `missing_components` when applicable

Silence is never an admissible substitute for missingness.

### Required dossier sections (required product contract)
The dossier must contain the following sections in this order:

1. **Overview**
2. **Market Watch**
3. **Specification**
4. **Selection Filter**
5. **Shortlist Context**
6. **Deep Analysis**
7. **Future Expansion — Aurora Signal**
8. **Future Expansion — Semi-Auto / Full Auto**
9. **Publication, Continuity, and Failure Record**

### 1. Overview
Purpose:
- establish symbol identity
- show current scanner posture
- show headline market-state and inspection posture

Required fields:
- symbol
- canonical symbol
- asset class / group / subgroup
- market status
- scanner posture summary
- freshness headline
- current inspection posture note

### 2. Market Watch
Purpose:
- show the currently observed market-watch truth for the symbol

Required fields:
- bid
- ask
- spread
- spread percent
- tick age
- freshness posture
- day change
- session / market-open posture
- market-watch state note

Observed-truth rule:
- this section presents observed or directly derived scanner truth only
- it must not blend in downstream interpreted signal language

### 3. Specification
Purpose:
- show broker/trading-condition truth and structural symbol constraints

Required fields:
- broker spec summary
- contract size
- lot step
- min stop distance
- trading session posture
- liquidity / friction posture
- missingness note when any structural field is absent

### 4. Selection Filter
Purpose:
- show Layer 3 gate truth for this symbol

Required fields:
- pass / fail / pending state
- gate reason summary
- blocker summary when not passed
- readiness-for-shortlist note
- section continuity / freshness note

Observed-vs-interpreted rule:
- this section reports eligibility truth and blocker truth
- it must not imply final trade quality

### 5. Shortlist Context
Purpose:
- show Layer 4 attention / inspection posture for the symbol

Required fields:
- shortlist state
- promotion state
- inspection priority / rank when shortlisted
- bucket placement
- promotion reason summary
- outside-shortlist note when the symbol passed filter but was not promoted
- correlation / overlap summary
- active overlap conflict note

Observed-vs-interpreted rule:
- shortlist rank is attention priority only
- it must not be described as best-trade authority

### 6. Deep Analysis
Purpose:
- show Layer 5 truth when it exists, and honest posture when it does not

Deep-analysis posture header is mandatory and must always classify the symbol as one of:
- `not armed`
- `armed/pending`
- `completed`
- `continuity-backed`
- `unavailable`

When Deep Analysis is available, the section must expose structured subsections rather than one flat blob.

Required subsections when available:
- deep-analysis overview
- timeframe settings
- bar-pack / OHLC coverage summary
- recent tick activity
- spread-rollover / microstructure posture
- advanced context / evidence summary
- decision-support context

Hard guards:
- dossier may consume Layer 5 truth but does not originate it
- dossier must stay useful even when this section is `not armed`, `armed/pending`, or `unavailable`
- absence of deep content must not collapse the rest of the dossier
- subsection-level failures must remain visible

### 7. Future Expansion — Aurora Signal
Purpose:
- reserve the future downstream handoff surface without pretending it is active now

Required fields:
- current state
- non-active wording
- activation guardrail note

### 8. Future Expansion — Semi-Auto / Full Auto
Purpose:
- reserve future expansion homes without granting current runtime authority

Required fields:
- semi-auto state
- full-auto state
- non-active wording
- activation guardrail note

### 9. Publication, Continuity, and Failure Record
Purpose:
- make dossier publication quality auditable to the operator

Required fields:
- dossier publication state
- status reason
- failed / degraded section list
- continuity-backed section list
- last successful publish time
- proof / last-action summary
- next recovery note when applicable

### Dossier failure visibility rules (hard law)
The dossier must:
- keep failed sections visible
- name missing components
- distinguish fresh from stale
- distinguish stale from degraded
- distinguish degraded from continuity-backed
- distinguish continuity-backed from completed fresh deep analysis

### Dossier continuity rules
Continuity is allowed, but only when explicit.

Required continuity behavior:
- section-level continuity markers must remain visible
- continuity must retain source timestamp / source generation where possible
- continuity in one section must not silently upgrade the whole dossier to fresh
- continuity-backed Deep Analysis must remain visibly continuity-backed

### Dossier observed-truth vs interpreted-truth distinction
Where interpretation-adjacent fields appear, the dossier must label them as scanner-side structural / evidence posture rather than final trade interpretation.

Dossier may present:
- evidence
- context
- blocker truth
- shortlist posture
- deep evidence summaries

Dossier must not present:
- final signal class
- final directional trade verdict
- execution instruction
- order command

---

## 3) Current Focus contract

Canonical operator-visible name: **Current Focus**

### Current Focus purpose (hard law)
Current Focus is the singleton **currently selected-symbol working artifact**.

It exists to give the operator one live working file for the symbol currently being inspected.
It may closely mirror dossier depth, but it serves a different role:

- Dossier = full per-symbol intelligence archive/view
- Current Focus = current working read for the selected symbol

### Singleton and selected-symbol law (hard law)
Current Focus must:
- exist as exactly one canonical visible file
- follow the currently selected symbol
- rewrite that same file in place when selected-symbol context changes
- never remain silently pinned to an older symbol
- make symbol identity obvious at the very top of the file

Historical preservation belongs to per-symbol dossiers, not to the visible Current Focus file.

### Current Focus top-level requirements
At the top of Current Focus, the artifact must always show:
- current selected symbol
- publish time
- publication state
- selected-symbol freshness summary
- shortlist / promotion posture summary
- deep-analysis posture summary
- explicit selected-symbol working note

### How closely Current Focus mirrors Dossier
Current Focus may closely mirror dossier depth for the selected symbol, especially when that symbol is under active inspection.
However, it remains distinct because it is optimized for current operator work rather than per-symbol archive completeness.

Required distinction:
- Dossier is the permanent per-symbol intelligence artifact
- Current Focus is the singleton selected-symbol working artifact
- Current Focus may summarize, compress, or foreground the most actionable scanner truth for the selected symbol
- Current Focus must not silently diverge from dossier truth ownership

### Minimum required Current Focus sections
Current Focus must contain at least these sections in this order:

1. **Selected Symbol Header**
2. **Overview**
3. **Market Watch**
4. **Selection Filter and Shortlist Context**
5. **Deep Analysis Posture**
6. **Risk / Exposure Context**
7. **Publication and Continuity Status**

### 1. Selected Symbol Header
Required fields:
- symbol
- canonical symbol where applicable
- selected-symbol confirmation note
- publish time
- publication state

### 2. Overview
Required fields:
- market status
- scanner posture summary
- freshness headline
- one working-note summary

### 3. Market Watch
Required fields:
- bid
- ask
- spread
- spread percent
- tick age
- market-watch freshness note

### 4. Selection Filter and Shortlist Context
Required fields:
- passed / failed / pending filter state
- shortlist / promotion state
- inspection priority when available
- concise reason summary
- overlap / correlation summary

### 5. Deep Analysis Posture
This section must always show one of the following states:
- `not armed`
- `armed/pending`
- `completed`
- `continuity-backed`
- `unavailable`

When deep output exists for the selected symbol, Current Focus may include compact deep-summary content.
When it does not, the section must still remain present with honest posture wording.

### 6. Risk / Exposure Context
Required fields:
- open trade / pending order posture for the selected symbol
- exposure / overlap note
- current account-risk context note relevant to this symbol

### 7. Publication and Continuity Status
Required fields:
- publication state
- state reason
- degraded / missing section list when applicable
- continuity note when applicable
- last successful publish time

### Current Focus anti-drift law
Current Focus must never become:
- a hidden history set
- a second dossier archive tree
- a signal verdict sheet
- a silent pin to an older symbol
- proof that Deep Analysis ran merely because the page/file is open

---

## 4) Cross-artifact separation summary

### Market Board
- board of what to inspect now
- compact cross-symbol inspection surface
- stops at Layer 4 depth
- shows overlap, shortlist, passed-filter-outside-shortlist, and account/exposure posture
- does not publish deep internals

### Dossier
- full per-symbol intelligence artifact
- richest lawful consumer view of one symbol
- can consume Layer 1-5 truth when available
- preserves continuity and failure visibility section by section
- remains useful even without deep output

### Current Focus
- singleton selected-symbol working artifact
- follows currently selected symbol
- may closely mirror dossier depth
- foregrounds current working posture and deep-analysis state for the selected symbol
- does not replace dossier archival role

---

## 5) Operator-safe naming law

Visible artifact filenames and headings must remain trader-safe and domain-descriptive.

### Banned dev-language tokens
The following tokens are banned in canonical visible artifact filenames and headings:
- `tmp`
- `test`
- `debug`
- `wip`
- `draft`
- `scratch`
- `placeholder`
- `new`
- `old`
- `final_final`

### Prohibited operator-visible heading vocabulary
Operator-visible headings must not use internal engineering vocabulary such as:
- `Layer 1`, `Layer 2`, `Layer 3`, `Layer 4`, `Layer 5`
- `runtime`
- `telemetry`
- `governor`
- `artifact_family`
- `schema_version`
- `packet`

These terms may exist in blueprint/spec documents, but not in operator-facing artifacts.

---

## 6) Publication-state matrix (all three artifacts)

Market Board, Dossier, and Current Focus must share this exact operator-visible publication-state matrix:
- `pending`
- `fresh`
- `stale`
- `degraded`
- `continuity`
- `failure`

No alternate canonical operator-visible state set is admissible.

---

## 7) Enforcement and evidence

Minimum enforcement for this contract must include:
- singleton-path checks for Current Focus
- role-separation checks between board/dossier/current-focus
- Market Board depth-ceiling checks blocking Layer 5 payload leakage
- dossier section-presence checks
- current-focus selected-symbol drift checks
- publication-state matrix checks
- continuity / failure visibility checks
- operator-heading validation checks against forbidden technical wording

This contract is satisfied only when runtime behavior and landed artifacts conform to these rules, not when documentation merely gestures at them.
