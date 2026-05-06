# ASC HUD, MARKET BOARD, CURRENT FOCUS AND OPERATOR SURFACES
Status: Canonical
Scope: Consumer-only law, operator vocabulary, surface integrity, selected-symbol derivative law

## 1. Purpose

This document defines the laws for all operator-facing surfaces:
- HUD
- Market Board
- Current Focus
- dossier-facing derived reads
- summary surfaces

The core law is:

**surfaces consume truth; they do not own truth**

---

## 2. HUD Law

The HUD is a consumer-only surface.

HUD may:
- browse
- paginate
- navigate
- switch pages
- display selected symbol
- show prepared state and prepared text
- present operator-facing labels

HUD may not:
- reclassify symbols
- compute market state
- compute shortlist
- compute deep analysis
- rebuild hidden symbol truth
- silently own selected-symbol state

---

## 3. Prepared Read Model Law

HUD and other consumer surfaces must read from prepared view models or prepared artifact truth.

Prepared state must be created outside render paths.

Render must stay focused on:
- placement
- text display
- interaction display
- state consumption

Not on:
- hidden truth production
- ownership duplication
- engine logic

---

## 4. Current Focus Law

Current Focus is a strict derivative of canonical selected-symbol dossier truth.

It is not:
- a second dossier writer
- a custom symbol-truth author
- a special-case intelligence output

It is:
- the selected-symbol operator convenience artifact
- a derived projection of canonical dossier truth
- bound to selected-symbol integrity checks

Required behaviors:
- selected symbol must have one owner chain
- Current Focus must align with canonical selected-symbol dossier truth
- symbol mismatch must be visible
- publication mismatch must be visible
- replacement on selected-symbol change must be explicit and lawful

---

## 5. Market Board Law

Market Board is a compact truthful summary surface.

It must:
- summarize canonical truth
- group symbols lawfully
- reflect real broker-supported buckets only
- use shortlist/correlation truth only when owner-backed
- remain compact without becoming thin

It must not:
- improvise deep-analysis claims
- fake correlation readiness
- override upstream classification/grouping
- become a silent truth owner

---

## 6. Operator Vocabulary Law

Operator surfaces must use trader-readable language only.

Allowed:
- Market State
- Market Watch
- Open Symbol Snapshot
- Candidate Filtering
- Shortlist Selection
- Deep Selective Analysis
- Market Board
- Current Focus
- Freshness
- Confidence
- Integrity
- Notes
- Risk
- Opportunity
- Constraint

Forbidden:
- layer numbers in visible copy
- packet
- trigger queued
- future expansion
- sync pending/internal wording
- dev abbreviations
- raw module/function names
- underscore-style labels
- developer placeholder headings

---

## 7. Selected-Symbol Surface Integrity Law

Whenever a selected symbol is shown, surfaces must preserve:

- selected-symbol identity
- canonical symbol identity
- publication alignment
- freshness posture
- continuity posture

Any mismatch between selected symbol, Current Focus, and canonical dossier must be detectable and visible through logging/evidence.

---

## 8. Surface Completeness Law

A surface must not appear more complete than the truth that supports it.

If upstream truth is missing:
- the surface must show explicit missingness
- the surface must not invent narrative replacement
- the surface must not show unsupported polish text

---

## 9. HUD Smoothness Law

HUD performance matters.

The system should support:
- quick page changes
- smooth symbol switching
- low object churn
- bounded redraw behavior
- responsive bottom navigation / paging controls
- display correctness without render-side truth recomputation

Smoothness must never be purchased by lying about truth freshness.

---

## 10. Market Board Content Law

Market Board must support:
- meaningful grouping
- concise per-symbol rows
- truthful top bucket representation
- top 3 / top 5 / top 10 laws where enabled
- correlation context only when ready
- account/exposure context where owner-backed

Market Board must not duplicate the full dossier.
It is summary, not replacement.

---

## 11. Current Focus Content Law

Current Focus should retain:
- selected symbol identity
- high-value top-of-dossier truth
- current selected-symbol deep/read context
- continuity and publication alignment posture

It must remain consistent with the canonical dossier and not drift into a separate authored personality.

---

## 12. Final Rule

All operator surfaces exist to make owned truth readable.

No operator surface may become an invisible engine.
No operator surface may leak developer framing.
No operator surface may outgrow the truth contract that supports it.
