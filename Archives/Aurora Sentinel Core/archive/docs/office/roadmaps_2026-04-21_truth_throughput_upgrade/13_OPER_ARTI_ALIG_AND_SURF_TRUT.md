# Operator Artifact Alignment and Surface Truth
## DOC 13 RUN 2 — internet hardening + bounded source patch landed (2026-04-25)

### Pass classification
- RUN 2 of 4.
- Internet hardening + bounded compile-path patch + office sync.
- No live test in this pass.
- No fresh runtime-output closure claimed.

### Research-supported hardening
Doc 13 RUN 2 used internet research to tighten operator-facing status and provenance vocabulary.
The strongest research signal was that surface trust depends on provenance, lineage, explicit status state, and timely uncertainty communication:
- provenance must expose production/source context so quality, reliability, and trustworthiness can be judged;
- lineage/status patterns must separate current, degraded, staged/candidate, and historical/archive states;
- uncertainty should be visible at the time the operator is reading the surface, without turning support surfaces into authority.

### RUN 2 source patch
Landed a narrow compile-path patch:
- `ASC_ArtifactTextHelpers.mqh`
  - hardened `ASC_ArtifactSurfaceFreshnessBoundaryLine(...)` into explicit surface-role wording;
  - added `ASC_ArtifactSurfaceProvenanceLine()`;
  - hardened `ASC_ArtifactFamilyRoleMeaningLine()` so preserved/staging/archive cannot read as current authority.
- `ASC_MarketBoardWriter.mqh`
  - Market Board now prints shared provenance wording after family-role meaning.
- `ASC_DossierComposer.mqh`
  - publication integrity notes now carry shared provenance wording after surface-truth wording.
- `ASC_Dispatcher.mqh`
  - GlobalTop10 family manifests now carry shared provenance wording.
- `ASC_Version.mqh`
  - version bumped to `Stage2-Doc13-Run2-SurfaceTruthHardening`.

### Weak RUN 1 wording corrected
RUN 1 correctly landed the shared helper and usage path, but wording such as `current surface may be last-known lawful truth while refresh catches up` could still be misread as current authority.
RUN 2 hardens this by using explicit roles:
- `current-promoted`
- `current-promoted-with-caution`
- `retained-last-good`
- `continuity-last-good`
- `preserved-prior-current`
- `unclassified`

### Law protected
This patch does **not** create another truth owner.
- Market Board remains the authority surface for ordinary trade-picking and diversified overall ranking.
- Dossier and Current Focus remain support/derived surfaces.
- GlobalTop10 children and manifests remain derived/provenance surfaces.
- Staging remains candidate truth until verified/promoted.
- Archive remains prior-snapshot evidence, not current authority.
- Retained last-good truth is lawful continuity, not fresh renewed truth.

### Why Doc 13 is still not live-closed
The uploaded package did not include fresh runtime outputs, logs, screenshots, current/archive files, or live proof.
RUN 2 therefore proves research-supported source hardening only.
It does not prove the operator sees the wording in live MT5 or that preserve/stage/promote/archive cycles carry it correctly under runtime pressure.

### RUN 3 must prove
RUN 3 must compile and live-prove:
- Market Board shows `Surface Truth`, family meaning, and `Surface Provenance` correctly.
- Dossier and Current Focus paths show publication-integrity surface truth/provenance correctly.
- GlobalTop10 family manifests show family-role meaning and provenance correctly.
- Current family remains visible during staging.
- Archive manifests/files represent prior snapshot evidence, not current authority.
- Stale/degraded/preserved states are not presented as fresh current authority.
- Shell-only dossier posture, retained last-good truth, staging-not-promoted truth, and degraded/partial publication are visible when applicable.
- No Market Board, Dossier, Current Focus, HUD, or GlobalTop10 owner drift appears.
- No meaningful HUD/write-pressure regression appears while proving the wording.

### RUN 4 reserved for
RUN 4 is reserved for final hardening/closeout after RUN 3 live proof, including any narrow correction proven by live evidence.


## DOC 13 RUN 1 — git/source seam landed (2026-04-25)

### Pass classification
- RUN 1 of 4.
- Git/source audit + bounded code patch + office sync.
- No internet research in this pass.
- No live test in this pass.
- No fresh runtime-output closure claimed.

### Source seam chosen

The highest-leverage Doc 13 seam was **surface truth wording identity** across operator artifacts.

Recent source/history already moved GlobalTop10 toward a lawful preserve/stage/archive/promote family model, but operator surfaces still needed a shared visible contract for:
- `fresh` vs `degraded` vs `stale` artifact state
- command-ready vs support-only/guarded authority
- current vs preserved vs staging vs archive family roles
- current truth vs last-good lawful truth while refresh/promotion catches up

Without this, a surface can be technically lawful but still operator-misleading.

### RUN 1 source patch

Landed a narrow compile-path patch:
- `ASC_ArtifactTextHelpers.mqh`
  - added shared surface freshness/authority readback
  - added shared family-role meaning line
- `ASC_MarketBoardWriter.mqh`
  - Market Board now prints `Surface Truth:` after `Board State:`
  - Market Board now states family-role meaning near the top of the artifact
- `ASC_DossierComposer.mqh`
  - Publication integrity notes now include the same surface-truth contract
- `ASC_Dispatcher.mqh`
  - GlobalTop10 family manifests now explain current/preserved/staging/archive meaning
- `ASC_Version.mqh`
  - version bumped to `Stage2-Doc13-Run1-SurfaceTruth`

### Law protected

This patch does **not** create another truth owner.

- Market Board remains the authority surface for ordinary trade-picking and diversified overall ranking.
- Dossier and Current Focus remain support/derived surfaces.
- GlobalTop10 children and manifests remain derived/provenance surfaces.
- Staging is not operator-current until verification and promotion succeed.
- Archive is prior-snapshot evidence, not current authority.

### Why Doc 13 is not live-closed

The uploaded package did not include fresh runtime outputs, logs, screenshots, current/archive files, or live proof.

Therefore RUN 1 only proves source wiring landed. It does not prove the operator sees the new wording in live MT5 or that the wording stays coherent during failure/preserve/stage/promote/archive cycles.

### RUN 2 must harden

RUN 2 must use internet research to harden:
- freshness/provenance/stale-view wording
- current vs last-good/retained wording
- staging/archive vocabulary
- operator-facing uncertainty wording
- acceptance criteria for live proof

### RUN 3 must prove

RUN 3 must compile and live-prove:
- Market Board shows `Surface Truth` correctly.
- Dossier/Current Focus derived surfaces show publication-integrity surface truth correctly.
- GlobalTop10 family manifests show family-role meaning.
- Current family remains visible during staging.
- Archive manifests/files represent prior snapshot evidence, not current authority.
- Stale/degraded/preserved states are not presented as fresh current authority.
- No Market Board, Dossier, Current Focus, HUD, or GlobalTop10 owner drift appears.

### RUN 4 reserved for

RUN 4 is reserved for final hardening/closeout after RUN 3 live proof, including any narrow correction proven by live evidence.

## Purpose

This doc governs artifact-alignment doctrine after Layer 6.
It is a forward roadmap/control doc, not a runtime layer doc.

## Corrected boundary

- The runtime model stops at Layer 6.
- This doc does not create Layer 7.
- Dossier, Current Focus, and other selected-symbol support surfaces remain support consumers.
- Market Board authority remains upstream and protected.

## Corrected doctrine

Artifact alignment work must not overclaim strategy strength from support improvements.
This doc should treat the following as support-only unless later validation proves otherwise:

- cleaner support wording
- better contradiction ordering
- cleaner change-trace presentation
- tighter selected-symbol handoff phrasing
- clearer freshness/source/family identity wording

## What this doc is for

- alignment of operator-facing support surfaces
- preservation of one-truth ownership
- support usefulness without owner drift
- honest current/preserved/staging/archive surface identity

## RUN 3 — live proof + bounded Dossier/Current Focus explicit-line seam

Status: **RUN 3 patched a narrow live-proven seam; RUN 4 remains required.**

Live proof read:
- Market Board: passed for `Surface Truth`, `Family Meaning`, and `Surface Provenance`.
- GlobalTop10 manifests: passed for current/staging/archive role/state/provenance and non-authority wording.
- Current / staging / archive states: observed in the live Upcomers package.
- Preserved/stale cadence-hold posture: observed in Artifact Bundle Manifest wording.
- Degraded/partial/shell: not naturally observed in this package.
- Dossier / Current Focus: deep support and support-only role remained intact, but explicit `Surface Truth:` / `Surface Provenance:` lines were absent live.

Patch:
- Publication Health now prints explicit `Surface Truth:` and `Surface Provenance:` lines.
- Non-closed Dossier payload required tokens now include those two lines.
- Version label: `Stage2-Doc13-Run3-LiveProofFix`.

Run 4 reservation:
- Real MetaEditor compile.
- Fresh live regeneration of Market Board, Dossier/Current Focus, and GlobalTop10 manifests.
- Confirm no old deep-focus preserved payload can hide Doc 13 surface/provenance lines after fresh publish.
- Final polish/closeout only if fresh compile and live proof pass.

## RUN 4 — final closeout hardening / root Dossier Current Focus naming alignment

### Result

RUN 4 found and patched a narrow naming/product-law seam: older `Dossier / Current Focus` wording could still be read as requiring a separate `Current Focus.txt` output. Current compile-path law resolves the active Current Focus target to root `Dossier.txt`.

### Product-law correction

- Root `Dossier.txt` = active selected-symbol Current Focus surface.
- `Dossiers/<symbol>.txt` = per-symbol dossier family.
- `Dossiers/GlobalTop10/` = GlobalTop10 support/deep family.
- `ASC_CurrentFocusWriter.mqh` remains an active compatibility/source-owner name for protected selected-symbol root-dossier publication/readback logic; it does not, by itself, prove a separate Current Focus file.

### Patch

- `ASC_CURRENT_FOCUS_FILE` comment now states root `Dossier.txt` is the selected-symbol Current Focus surface and that no separate `Current Focus.txt` is required.
- `ASC_CurrentFocusContract()` artifact label now says `Root Dossier / Current Focus`.
- Protected readback source/reason strings now identify root Dossier / Current Focus.
- Office/control files now record the corrected naming law.

### Proof posture

MetaEditor compile and fresh MT5 runtime output were not available in this environment. Therefore Doc 13 is not honestly closed by this pass. RUN 4 must be re-run where MetaEditor compile and fresh runtime artifacts can prove the source-level patch live.

### Required re-run proof

- MetaEditor compile passes.
- Fresh Market Board shows `Surface Truth`, `Family Meaning`, and `Surface Provenance`.
- Fresh root `Dossier.txt` / Current Focus surface shows explicit `Surface Truth:` and `Surface Provenance:` lines.
- Fresh GlobalTop10 manifests show family role, family state, source pass UTC, source signature, child count, family meaning, and surface provenance.
- Runtime logs/performance counters show no Doc 13 wording-induced write pressure or heartbeat regression.

### Verdict

DOC 13 RUN 4 RE-RUN REQUIRED. Source/control seam patched; compile/live closeout remains unproven.
