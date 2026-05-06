# Current Focus Recovery and Deep-Packet Restoration Roadmap

## Status

This document is a recovery roadmap for restoring Current Focus after the recent Market Board lane.

It exists because Current Focus has regressed into a dossier-like shell while deep-selected-symbol truth is not arriving cleanly. The active recovery target is:
- restore Current Focus as a selected-symbol tactical packet
- restore deep-first precedence
- remove duplicate and conflicting visible blocks
- repair the deep-trigger to dossier/current-focus pair path
- stop further Current Focus feature expansion until trust is restored

---

## Why this roadmap exists

The current artifact evidence shows four linked failures:

### 1. Deep packet is not landing
Current Focus is publishing while reporting deep analysis unavailable, deep tactical snapshot unavailable, deep structure/liquidity unavailable, deep session timing unavailable, deep score context unavailable, deep microstructure unavailable, and no timeframe analytical summary.

### 2. Selected-symbol meaning is muddy
Current Focus can still publish while showing `Selected Symbol Status: Not Selected` and `Current Bundle Status: View Sync External`.

### 3. Visible section duplication exists
Observed output can contain duplicated Trader Context and duplicated Change Trace sections.

### 4. The bundle manifest points to a split-path failure
Current Focus view-sync is succeeding while trigger status reports `deep_pair_failed_runtime_path`. Deep-trigger cumulative publish/success remain zero while selected-symbol view-sync continues.

That means this is not just missing data. It is a deep-path failure masked by a weaker shell/view-sync publication path.

---

## Final recovery objective

After this roadmap is complete, Current Focus must behave like this:
- selected-symbol only
- deep-first when lawful Layer 5 truth exists
- atomic and pair-safe
- never silently downgraded from completed deep packet into generic view shell
- never duplicated by section-family append drift
- never mixed from two contradictory score sources
- when deep truth is absent, published as a compact honest pre-deep packet instead of a giant pseudo-deep dossier shell

The intended product feeling is:

**Current Focus = active selected-symbol tactical packet**

not:

**Current Focus = bloated dossier copy with missing deep content and duplicated context blocks**

---

## Non-negotiable recovery rules

### Rule 1 - Current Focus is not a generic dossier shell
If deep truth is absent, fallback must be compact, honest, clearly pre-deep, and still selected-symbol lawful.

### Rule 2 - deep truth outranks view-sync shell truth
If a lawful completed Layer 5 result exists for the selected symbol, that result must be the primary Current Focus authority. View-sync must not overwrite or dilute it.

### Rule 3 - one visible section family, one truth source
Trader Context, Change Trace, and similar visible blocks may not land twice.

### Rule 4 - no mixed-source score conflicts
The same Current Focus file may not present two contradictory score sets unless explicitly labeled as an intentional comparison, which it is not.

### Rule 5 - no new Current Focus features before recovery is complete
Do not stack more features onto Current Focus until deep-first authority, section integrity, and selected-symbol law are restored.

### Rule 6 - preserve layer ownership
Layer 5 remains deep selected-symbol intelligence owner. Current Focus remains a consumer artifact.

---

## Forensic failure model

Highest-probability failure sequence:
1. explicit deep trigger is requested
2. deep packet composition or pair publication fails on runtime path
3. ordinary view-sync external still succeeds
4. Current Focus continues to land from the weaker dossier/view path
5. the file shows selected-symbol / deep-unavailable shell output
6. composer/writer branches append extra context blocks, causing duplicate Trader Context and Change Trace families

This creates two linked failure classes:

### Failure class A - deep path failure
Layer 5 packet does not reach Current Focus even though selected-symbol flow continues.

### Failure class B - surface composition corruption
Fallback/view packet is overgrown, duplicated, and mixed-source.

Both must be fixed. A deep-path repair alone is not enough, and a cosmetic cleanup alone is not enough.

---

## Validation law for every pass

Every pass in this roadmap must be validated using:
- compile-clean MT5 result or no-new-compile-regression proof
- Current Focus artifact before/after comparison
- bundle manifest before/after comparison
- one real selected symbol as validation anchor
- explicit check for duplicate visible blocks after each surface/composer change

No pass is complete just because code changed. Artifact proof is required.

---

## Recovery sequence

This roadmap is intentionally split into many narrow prompts. Each prompt solves one bounded problem.

# PHASE 0 - FORENSIC TRUTH

## Prompt 0 - forensic diagnosis only
Goal:
- map the exact breakpoints in deep trigger service, deep packet composition, dossier/current-focus pair publish, external view-sync fallback, and visible section duplication

Must answer:
- Is deep actually not being built?
- Is deep built but rejected at composition time?
- Is pair publish failing after build?
- Is Current Focus being overwritten by view-sync afterward?
- Which exact code path emits duplicated Trader Context and Change Trace?
- Which truth owner produced the conflicting score sets?

Success condition:
- precise file/function-level failure map, no code changes yet

---

# PHASE 1 - STOP THE DEEP-PATH FAILURE

## Prompt 1 - deep trigger to pair publish restoration only
Goal:
- repair the explicit deep runtime path so completed deep analysis can lawfully reach dossier + Current Focus again

Focus:
- explicit deep trigger queue/service
- deep build completion state
- pair publish attempt admission
- runtime failure family `deep_pair_failed_runtime_path`

Success condition:
- the system can once again produce a completed deep result that reaches the pair publication path

## Prompt 2 - deep result composition / dossier deep-override restoration only
Goal:
- if deep trigger runs but composition still fails, repair canonical deep-packet composition

Focus:
- completed deep-analysis truth inclusion
- dossier deep-override mode
- completed Layer 5 block admission
- prevention of fallback-only shell composition when completed deep truth exists

Success condition:
- completed deep result can be composed into the canonical selected-symbol packet instead of collapsing to not-yet-available

---

# PHASE 2 - RE-ESTABLISH CURRENT FOCUS PRODUCT MEANING

## Prompt 3 - Current Focus deep-first authority only
Goal:
- restore precedence so lawful deep truth outranks generic view-sync shell truth

Required behavior:
- completed deep truth for selected symbol publishes to Current Focus as primary authority
- ordinary view-sync must not overwrite it afterward
- retained last-good deep truth may survive if fresh deep rebuild is unavailable, but generic shell truth must not silently replace it

Success condition:
- Current Focus behaves as a deep-first consumer surface again

## Prompt 4 - selected-symbol law restoration only
Goal:
- resolve the contradiction where Current Focus publishes a symbol packet while showing `Selected Symbol Status: Not Selected`

Focus:
- selected symbol storage / resolution
- selected-symbol gating for Current Focus publication
- difference between view-sync external and selected-symbol internal authority

Success condition:
- Current Focus clearly knows whether it is publishing for the selected symbol, and the visible packet reflects that truth correctly

---

# PHASE 3 - SURFACE COMPOSITION CLEANUP

## Prompt 5 - duplicate section family removal only
Goal:
- remove duplicate visible section families such as Trader Context and Change Trace

Focus:
- section registry / append path
- composer branches where both fallback and primary sections are appended

Success condition:
- each visible section family lands once, in one authoritative place

## Prompt 6 - conflicting score-source cleanup only
Goal:
- eliminate mixed-source visible score conflicts inside Current Focus

Focus:
- Trader Context score source
- branches using stale/fallback score carry while others use live committed truth
- one authoritative score path per visible family

Success condition:
- Current Focus shows one coherent score truth set, not two contradictory ones

---

# PHASE 4 - FALLBACK PRODUCT REPAIR

## Prompt 7 - compact pre-deep Current Focus fallback only
Goal:
- if deep truth is not available, publish a clean compact pre-deep packet instead of a giant dossier-like shell

Pre-deep packet should include only:
- selected symbol identity
- live market/watch truth
- shortlist posture / board meaning summary
- compact tactical carry
- one honest deep-pending note

Must not include:
- duplicated context blocks
- fake deep-detail scaffolding that adds no operator value
- visible noise that makes the file feel broken

Success condition:
- even without deep truth, Current Focus still reads like a compact tactical packet

## Prompt 8 - wording and operator-surface cleanup only
Goal:
- once deep-first behavior and surface integrity are restored, clean operator-facing wording

Focus:
- remove dev-language leakage where visible
- tighten repeated unavailable phrasing
- preserve honesty while improving clarity
- keep Current Focus distinct from dossier and Market Board

Success condition:
- Current Focus reads like a trader packet again, not a technical dump

---

# PHASE 5 - DOSSIER / CURRENT FOCUS HANDSHAKE

## Prompt 9 - dossier/current-focus handshake hardening only
Goal:
- ensure dossier and Current Focus cooperate without overwriting or leaking partial truth into each other

Focus:
- dossier-first duplication rules
- selected-symbol duplication timing
- handoff between canonical dossier payload and Current Focus copy
- retained/continuity rules for pair write behavior

Success condition:
- the dossier/current-focus pair behaves as one coherent selected-symbol publication family with lawful precedence

## Prompt 10 - bundle manifest / publication-health truth cleanup only
Goal:
- align manifest and publication-health reporting to the repaired behavior

Focus:
- Current Focus trigger status wording
- view-sync status wording
- deep-trigger counters and outcomes wording
- publication health notes in visible Current Focus output

Success condition:
- operational evidence files correctly describe what the system is actually doing after repair

---

# PHASE 6 - FINAL HARDENING

## Prompt 11 - compile/live proof hardening only
Goal:
- final compile/integration hardening pass for the recovery lane

Must verify:
- no duplicate visible sections
- deep-first Current Focus authority restored
- selected-symbol law restored
- one authoritative score set per visible family
- compact fallback packet when deep unavailable
- dossier/current-focus pair remains atomic and lawful
- no hidden regressions in Market Board or dossier writer behavior caused by the recovery lane

Success condition:
- Current Focus is trustworthy again

---

## Product contract after recovery

### Current Focus when deep is available
It must show:
- selected symbol confirmed
- completed deep overview
- tactical snapshot
- structure / liquidity summary
- session timing summary
- score context summary
- microstructure summary
- timeframe alignment summary
- deep freshness and continuity truth
- one coherent trader-context / change-trace view

### Current Focus when deep is unavailable
It must show:
- selected symbol confirmed
- live market/watch truth
- shortlist/board posture
- compact tactical carry
- one explicit note that deep packet is pending
- no fake completed deep structure
- no giant repeated unavailable blocks unless required by contract

---

## File-impact expectation

Primary likely code areas:
- `Aurora Sentinel Core/mt5/runtime/*`
- `Aurora Sentinel Core/mt5/artifacts/*`
- `Aurora Sentinel Core/mt5/deep_selective_analysis/*`
- any current-focus / dossier composer path that appends section families

Expected likely owners to inspect first:
- dispatcher / selected-symbol reconcile path
- deep selective analysis engine / result builder
- dossier composer
- Current Focus writer / duplication path
- publication bundle / manifest status helpers

Not admitted unless strictly required:
- Market Board redesign
- HUD redesign
- new Current Focus feature families
- new ranking-model expansion
- layer ownership redesign

---

## Stop conditions

Do not continue to the next prompt if any of these remain true:
- `deep_pair_failed_runtime_path` remains the primary Current Focus trigger failure without narrower diagnosis
- Current Focus still shows `Selected Symbol Status: Not Selected` while publishing a symbol packet
- duplicate Trader Context or Change Trace families remain
- conflicting score sets remain visible in one Current Focus file
- Current Focus still feels like a dossier shell instead of a selected-symbol packet

---

## Final target state

When this roadmap is complete:
- Current Focus is restored as the selected-symbol tactical packet
- deep-first precedence is back
- view-sync shell output no longer masks deep-path failure
- duplicate/contradictory visible sections are gone
- fallback is compact and honest
- dossier/current-focus pair publication is coherent again
- the operator can trust Current Focus as a real working surface

No further Current Focus feature expansion should be admitted until this state is achieved.
