# Current Runtime Baseline and Must-Fix Seams

## Why this file exists

This file freezes the real live starting point for the new cycle.
It is the anti-fantasy baseline.
Future passes must compare against this file instead of arguing from memory.

## Live runtime baseline captured from the current bundle

### Dossier family distribution

- Total dossier files observed: **1201**
- Tiny shell dossier files observed: **212**
- Ordinary closed-band dossiers observed: **948**
- Ordinary open-band dossiers observed: **40**
- Deep dossier files observed: **1**

### Runtime posture hints from logs and manifest

- Open-symbol entitled count observed: **253**
- Retention-only count observed: **948**
- Dossier sweep symbol count observed: **1201**
- Write-lane, dossier-sweep, and final-gate pressure are still visible in runtime telemetry.
- Live manifest currently states: **explicit Deep Analysis trigger is the sole Dossier publisher; ordinary view-sync publication is disabled**.
- This means the first execution batch cannot safely assume the ordinary dossier publisher is already active; the publication-owner contradiction must be resolved first.
- Global Top 10 deep path appears healthy.
- Board authority appears healthy.
- Deep/root/current-focus path appears healthy.

## Canonical dossier law for this roadmap

The product law for the ordinary dossier family is:

- closed market symbol in `Dossiers/` -> lawful **Layer 0–2**
- open market symbol in `Dossiers/` -> lawful **Layer 0–4**
- explicit deep / Global Top 10 / run-full / deep trigger -> lawful **Layer 0–6**

### What is specifically wrong now

The main ordinary dossier family is not yet landing this law at scale.
Too many open symbols are still only tiny shell files instead of lawful L0–4 ordinary dossiers.

## Must-fix seams

### MF1 — ordinary dossier law restoration

Restore lawful ordinary dossier behavior so open symbols do not settle as tiny shell files.

### MF2 — deep non-regression guards

Protect already-working deep paths from being downgraded by ordinary or baseline work.

### MF3 — write-lane / dossier-sweep / publish pressure

Reduce runtime time spent burning budget on dossier sweep, write queue pressure, and publish/final-gate friction.

### MF4 — upstream hydration truth

Improve Layer 0–2 hydration and execution truth where it feeds ordinary dossier quality and Layer 3/4 ranking accuracy.

### MF5 — ranking truth upgrade

Improve ranking realism so strong-looking but late/dirty/less executable symbols stop getting over-rewarded.

## What this file does not admit

- No claim that the solution is a redesign.
- No claim that hard gates are the answer.
- No claim that deep path logic should be reopened from zero.
- No claim that performance can be improved by weakening truth.

## Closure condition for this baseline file

Closed only if future audits continue using this baseline honestly and replace it only with fresher evidence, not with wishful summaries.
