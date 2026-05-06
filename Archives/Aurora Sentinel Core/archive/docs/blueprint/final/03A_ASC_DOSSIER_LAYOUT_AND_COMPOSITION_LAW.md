# ASC DOSSIER LAYOUT AND COMPOSITION LAW
Status: Canonical
Scope: Dossier layout ownership, composition boundaries, and migration guardrails

## 1. Purpose
This file governs dossier layout migration preparation.
It freezes ownership boundaries for layout/composition work without changing visible dossier product contract.

## 2. Dossier Layout Ownership Law
- Dossier visible scaffold ownership is explicit and centralized in dossier contract/scaffold owner files.
- Section order, subgroup order, and operator-visible field labels are contract surfaces, not ad hoc writer-body choices.
- Migration passes may move renderer placement, but may not drift visible scaffold contract.

## 3. Dossier Composer Law
- Composer owns dossier section sequencing and scaffold/body assembly order.
- Composer is a projection/orchestration layer only.
- Composer may call section render/build paths; it may not become a second monolith or a derivation engine.

## 4. Writer-Thin Target Law
- `ASC_DossierWriter.mqh` remains compile-reachable during migration.
- Writer target role is compatibility wrapper: context acquisition, composer call, and final publish bridge.
- Writer must not remain long-term central owner of dossier structure.
- Writer thinning beyond compatibility role is a later phase target.

## 5. Section-Folder Ownership Law
- Future section folders may own section rendering boundaries.
- Folderization must preserve one owner path per section/subgroup.
- Folderization must not create duplicate truth derivation paths.

## 5A. Common Presentation Helper Law
- Shared dossier presentation helpers belong in a common dossier helper file.
- Common helpers may own separators, block-header helpers, label/value line helpers, and section-status presentation helpers.
- Common helpers must not become hidden domain-truth owners.

## 5B. Top-Surface Section-Family Law
- Top Header, Operator Snapshot, and Publication & Integrity are dossier section families, not central writer-only inline assembly.
- These top-surface section-family files are projection/render owners only; they may format already-available owner-backed inputs.
- Publication honesty and continuity/fallback wording must remain explicit and unchanged by section-family extraction.
- No top-surface section-family file may become a hidden owner of upstream truth.

## 5C. Symbol Identity Section-Family Law
- Symbol Identity is a dossier family, not central writer-only inline assembly.
- Identity Core, Classification Authority, and Symbol Metadata are projection/render section families only.
- Advanced classification remains authoritative.
- Broker/supporting descriptors remain supporting evidence only and may not overtake authority in fallback wording.
- Symbol Identity section-family files may not become hidden classification owners and do not authorize classification-engine redesign.

## 5D. L1/L2 Projection Section-Family Law
- Market State, Market Watch, Trading Conditions & Contract Specs, and Sessions/Swap/Margin are dossier projection families, not central writer-only inline assembly.
- Their subgroup section files project owner-backed truth only; they do not redesign or replace upstream engines.
- Freshness, continuity-backed posture, degraded/stale posture, and unavailable/missingness wording must remain explicit and honest.
- Family extraction does not authorize upstream scanner/state/snapshot/spec/session/swap/margin engine redesign.

## 5E. L3/L4 Summary Section-Family Law
- Candidate Filtering and Shortlist Selection are dossier summary families, not central writer-only inline assembly.
- Their subgroup section files summarize and project owner-backed Layer 3/Layer 4 truth only.
- Dossier summary families may not become hidden filter/shortlist/hold/correlation engines.
- Summary honesty (pass/fail/pending, unavailable/deferred/degraded posture) must remain explicit.
- Family extraction does not authorize Layer 3/Layer 4 engine redesign.

## 6. Deep Selective Analysis Shell-vs-Heavy Law
- Normal dossier publish always carries the stable Deep Selective Analysis shell.
- Heavy deep payload is not part of the normal dossier visible contract.
- Heavy payload split ownership belongs to a later explicit shell/payload phase.
- This law pass freezes contract posture only; it does not require implementation split in this phase.

## 7. Prohibition on Writer-Centralized Derivation
- Writer/composer surfaces may not centralize upstream derivation.
- Upstream engines remain truth owners for market state, filtering, shortlist, and deep-analysis evidence.
- Dossier sections may project owner truth, but may not re-derive authoritative engine truth.

## 8. Frozen Scaffold Migration Rule
- During migration, visible dossier scaffold order/labels/section structure remain frozen.
- Any migration pass that changes scaffold shape is out of scope unless an explicit product-contract phase admits it.

## 6A. Deep Selective Analysis Family Extraction Law (Phase 6)
- Deep Selective Analysis dossier subgroup renderers are owned by the dossier deep section-family folder under `mt5/artifacts/dossier/deep_selective_analysis/`.
- Composer remains the sequencing owner and policy caller; deep subgroup files remain projection/render owners only.
- Explicit policy gates own shell-vs-fresh-payload-vs-preserved-payload admission decisions.
- This extraction phase does not authorize Layer 5 engine, entitlement, trigger, shortlist, or promotion redesign.

## 8A. Terminal Section-Family Law (Phase 7)
- Trader Context and Recent Change Trace are dossier terminal families, not central writer/composer inline-only assembly.
- Terminal section-family files project owner-backed inputs only; they do not become trade-selection, risk, or transition engines.
- Terminal family extraction does not authorize semantic redesign of Trader Context or Recent Change Trace.
- Composer remains the section sequence owner and calls terminal family renderers directly.

## 8B. Writer-Thinning Completion Law (Phase 8)
- Dossier architecture completion posture is now active: writer is compatibility-only wrapper, composer is orchestration/order owner, common is shared presentation helper owner, and dossier family files own visible section rendering.
- Upstream engines remain truth owners; dossier architecture completion does not authorize runtime/engine redesign.
- Publication path, scaffold contract, section order, subgroup order, field labels, and operator-facing wording remain frozen.

## 9. Consolidation and Repo-Truth Audit Law
- Phase labels in dossier migration history are historical tracking markers and must not be treated as proof of isolated single-pass closure.
- Dossier ownership truth is determined by active code at HEAD: writer compatibility wrapper, contract/scaffold owners, composer orchestration/projection owner, and family rendering owners.
- Consolidation/debug passes may correct dossier-local ownership drift and stale narration, but may not change visible dossier contract or publication mechanics.
