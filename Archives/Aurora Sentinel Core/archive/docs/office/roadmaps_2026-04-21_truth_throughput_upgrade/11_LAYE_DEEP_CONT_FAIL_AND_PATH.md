# Layer 5 — Deep Contradiction, Failure, and Path Quality

## Purpose

This doc governs Layer 5 runtime support logic.
It is reopened by the 2026-04-23 strategy reality audit.

## What Layer 5 is trying to do

Layer 5 should expose contradictions, failure modes, and path-quality differences more clearly for the selected symbol.
It should improve support usefulness without stealing authority from the Market Board.

## Corrected strategy truth

- Layer 5 is **support / diagnostic logic**.
- Layer 5 is **not edge-bearing by itself**.
- Layer 5 becomes strategically valuable only if its contradiction, failure, and path-quality output is later shown to be discriminative rather than decorative.

## What changed in understanding

Earlier roadmap wording was too close to treating richer deep analysis as if it automatically strengthened trading edge.
That is not justified.
Richer path explanation can still be support-only.

## Method constraints now explicit

Layer 5 must not claim success from:

- longer prose
- more contradiction labels
- more family descriptions
- clearer handoff language alone
- naming a primary fit when the top two fits are still effectively contested

Layer 5 should be treated as successful only when later validation shows that its support output helps separate stronger from weaker paths in a repeatable way.

## RUN 1 — git/history audit result

### Why Doc 11 is still correctly reopened

Yes.
Layer 5 could no longer be treated as settled proven edge logic after the roadmap correction.
It now has to carry stricter source honesty:

- contradiction / failure / path-quality support
- plausible edge-contributing support logic at most
- not edge-proven
- still requiring stronger source honesty and later live validation

### What the original source sequence tried to do

- **F1** tried to tighten partial-coverage honesty
- **F2** tried to tighten failure / invalidation visibility
- **F3** tried to tighten primary-vs-alternate path split visibility
- the emergency recovery pass repaired a compile break without changing the intended Layer 5 role

### What history still left missing

F1/F2/F3 made Layer 5 richer, but they still left one method-honesty gap:
**how strong the primary path claim really is when the top two fits are close**.

That gap matters because Layer 5 is a support layer.
If the lead fit is only marginally ahead, the output must say that explicitly instead of letting the operator over-read a narrative winner.

## RUN 1 seam chosen

### Seam type

**C. Path-quality discrimination tightening**

### Exact seam

Path-quality honesty inside the true Layer 5 owner: export the fit-gap and state whether the primary path is clearly separated, contested-but-usable, only a narrow advantage, or near-tied.

### Why this seam won

- It stays inside Doc 11 and does not drift into Layer 4 owner logic.
- It does not turn Layer 5 into Layer 6 support compression.
- It directly answers the reopened method-truth problem: richer deep support must say when its path-quality claim is weak, not just when it is rich.

## RUN 1 patch landed

### Compile-path owners touched

- `mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh`
- `mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `mt5/core/ASC_Version.mqh`

### What was patched

- added `siam_fit_gap_score`
- added `siam_fit_gap_posture`
- added `path_quality_summary`
- projected those lines into:
  - Layer 5 decision support
  - cross-timeframe summary
  - tactical refresh snapshot
  - SIAM tactical readback
  - dossier deep readback / placeholder carry

### What this patch now says explicitly

Layer 5 must now state whether its primary path is:

- clearly separated
- contested but usable
- only a narrow advantage
- effectively near-tied

That keeps the selected-symbol deep readback more honest when ambiguity is still live.

## What was not changed

- no Layer 4 owner logic
- no Layer 6 source logic
- no HUD redesign
- no Market Board ownership move
- no dossier/current-focus ownership move
- no second truth owner
- no hidden second analysis path

## What RUN 2 must investigate

The internet run must research whether the new contested-path / fit-gap honesty is method-aligned.
It should stay bounded to:

- ambiguity carry vs premature confidence
- model/path discrimination honesty
- support-layer confidence framing
- how much path separation is enough to describe a primary read as materially stronger rather than merely louder

## What RUN 3 must prove

The live run must prove all of the following before Doc 11 can close honestly:

- the new fit-gap and path-quality honesty lines actually appear in deep-support outputs
- near-tied path states read as contested rather than as a false clean winner
- the output improves operator understanding of fragility / incompleteness / conflict
- Market Board authority remains intact
- dossier and Current Focus remain support-only consumers

## Current honest status

Doc 11 is **source-landed for RUN 1 only**.
It is **not** internet-complete.
It is **not** runtime-closed.
It is **not** edge-proven.


## RUN 2 — internet reality audit result

### Why Doc 11 is still correctly reopened

Yes.
RUN 1 made Layer 5 more honest about path separation, but external method guidance still pressures a second weakness:
the failure path was still too narrative.
It named broad failure ideas, but it did not surface the current break triggers concretely enough for a support layer that claims to help the operator reason under uncertainty.

### What the internet run researched

- contradiction / competing-path framing
- actionable invalidation and diagnostic support
- ambiguity and confidence language
- support-layer usefulness for decision-makers

### What the research supported

- transparency about uncertainty protects integrity and reduces the risk of unsupported conclusions
- competing explanations should be judged with diagnostic / disconfirming evidence rather than by reinforcing only the favored story
- uncertainty and evidence quality should be summarized in a form that is directly useful to decision-makers
- concrete externalized uncertainty language is safer than vague confidence language that sounds stronger than the evidence

### What the research warned against

- ambiguous probability or confidence wording that different readers interpret differently
- support output that sounds decisive while hiding what would actually break the current read
- narrative confidence without a concrete failure path
- overclaiming trust gains from polish alone; honest uncertainty does not automatically improve trust, but it also does not reliably destroy it

## RUN 2 seam chosen

### Seam type

**B. Failure / invalidation clarity tightening**

### Exact seam

Failure-path wording inside the true Layer 5 owner now has to carry concrete invalidation triggers.
The deep packet should say what currently breaks the path first, not only that the path could fail in a general way.

### Why this seam won

- It is directly backed by external uncertainty / decision-support guidance.
- It stays inside Layer 5 support truth and does not drift into Layer 4 ranking authority.
- It does not turn Layer 5 into Layer 6 compression logic.
- It converts a narrative weakness into a more diagnostic and operator-usable support readback.

## RUN 2 patch landed

### Compile-path owners touched

- `mt5/deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh`
- `mt5/artifacts/dossier/ASC_DossierComposer.mqh`
- `mt5/core/ASC_Version.mqh`

### What was patched

- added `invalidation_trigger_summary`
- rewrote `failure_invalidation_summary` so it now anchors to the leading trigger instead of generic failure prose
- projected the new trigger line into:
  - Layer 5 decision support
  - cross-timeframe summary
  - tactical refresh snapshot
  - dossier SIAM tactical readback
  - dossier placeholder carry while deep output is unavailable

### What this patch now says explicitly

Layer 5 now states:

- what breaks the current read first
- what secondary invalidation pressure is next if present
- how the primary path loses authority under current conditions

That makes failure surfacing more concrete without letting Layer 5 decide for the operator.

## What was not changed

- no Layer 4 owner logic
- no Layer 6 source logic
- no HUD redesign
- no Market Board ownership move
- no dossier/current-focus ownership move
- no second truth owner
- no hidden second analysis path
- no HUD/read-path side seam was touched in this run

## What RUN 3 must prove

The live run must prove all of the following before Doc 11 can close honestly:

- the new invalidation-trigger and rewritten failure-path lines actually appear in deep-support outputs
- the added trigger wording reads as concrete support truth rather than decorative prose
- the clearer failure path improves operator understanding of fragility / incompleteness / conflict
- Market Board authority remains intact
- dossier and Current Focus remain support-only consumers

## Current honest status

Doc 11 is **source-landed for RUN 1 and RUN 2**.
It is **not** runtime-closed.
It is **not** edge-proven.


## RUN 3 — live closeout result

### Live evidence reviewed
- fresh `Artifact Bundle Manifest.txt`
- fresh `Scanner Status.txt`
- fresh `Market Board.txt`
- fresh root `Dossier.txt`
- representative `Dossiers/GlobalTop10/*.txt`
- fresh `function_results.log`
- fresh `heartbeat_telemetry.log`
- supplied HUD screenshots covering Global Top 10 pages and the file timestamps

### What the live pack proved

#### A. Path-quality honesty appears live
Yes.
The live dossier and representative Global Top 10 outputs now carry fit-gap posture and path-contest wording directly in readback.
Near-tied or narrow-split reads remain contested instead of sounding like hidden final decisions.

#### B. Failure / invalidation clarity appears live
Yes.
`invalidation_trigger_summary` is present live.
`failure_invalidation_summary` now points to concrete break conditions rather than vague generic caution language.

#### C. Ambiguity / confidence honesty improved live
Yes.
The live readback still carries ambiguity where the top path remains close to the alternate.
The deep output now reads as support-only guidance, not as forced certainty.

#### D. Market Board ownership stayed lawful
Yes.
The live Market Board still states command authority explicitly.
The selected-symbol dossier states that ordinary trade-picking baseline and diversified overall authority stay with the Market Board while the selected-symbol dossier adds explicit deep support only.

#### E. No-regression posture
No Layer 4 or Layer 6 ownership drift was proven in this live pack.
No second truth owner was exposed.
The board/current-focus split stayed lawful.

#### F. HUD / read-path side seam
Not admitted in this pass.
The operator-reported slowness remains a legitimate future concern, but this live pack did not isolate one narrow selected-symbol read-path seam that was required to prove or close Doc 11.

### Closeout verdict
Doc 11 now closes honestly.

### Why it closes
The reopened Layer 5 problem was not “make the prose richer.”
It was “make support truth more honest about path strength, contest, and break triggers, then prove that wording appears live without stealing board authority.”
RUN 3 satisfies that requirement.

### What Doc 11 does not claim even after close
- Layer 5 is still not edge-proven
- Layer 5 is still support / diagnostic logic only
- this closeout does not solve broader HUD performance by itself
- later docs may still reopen adjacent areas for their own reasons
