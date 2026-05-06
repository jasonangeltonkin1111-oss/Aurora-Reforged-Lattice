# Ordinary Dossier Law Restoration

## Why this lane exists

The ordinary dossier family is still the largest open correctness seam.
Open-symbol ordinary dossiers are not yet landing lawfully at scale.
That blocks future upgrade work because it corrupts the ordinary product surface.

## Canonical law for this lane

- closed market symbol dossier in `Dossiers/` -> Layer 0–2 only
- open market symbol dossier in `Dossiers/` -> Layer 0–4
- explicit deep / Global Top 10 / run-full / selected-symbol deep -> Layer 0–6 only when lawfully triggered

## What this lane must do

1. Resolve the publication-owner contradiction first: decide and prove how ordinary `Dossiers/` publication is lawfully produced while deep-trigger ownership stays protected.
2. Restore lawful ordinary dossier hydration for open symbols.
3. Keep closed ordinary dossiers at L0–2 without unnecessary bloat.
4. Preserve the distinction between ordinary and explicit-deep families.
5. Prevent shell-only open dossiers from becoming the steady-state result.
6. Make the ordinary dossier family truthful, stable, and scalable.

## What this lane must not do

- do not weaken or redesign deep selected-symbol logic
- do not collapse ordinary and deep dossier families together
- do not let ordinary L0–4 work overwrite lawful L0–6 deep outputs
- do not reintroduce the older deep-to-ordinary regression problem
- do not solve shell files by faking content or faking readiness

## Likely primary code owners

- `mt5/runtime/ASC_Dispatcher.mqh`
- `mt5/core/ASC_RuntimeState.mqh`
- `mt5/io/ASC_FileIO.mqh`
- `mt5/io/ASC_PublicationState.mqh`
- `mt5/artifacts/ASC_DossierWriter.mqh`
- `mt5/artifacts/ASC_ArtifactTextHelpers.mqh`
- directly called ordinary dossier composition helpers only if truly owner-linked

## Likely runtime evidence to inspect

- ordinary dossier folder size distribution
- open vs closed dossier family counts
- manifest wording around dossier publication path
- function results around dossier refresh admission
- heartbeat telemetry around dossier sweep and write pressure

## Success conditions

- the ordinary publication owner/path is explicitly identified and runtime-proven instead of being assumed
- open entitled symbols land as lawful ordinary L0–4 dossiers
- closed symbols remain lawful ordinary L0–2 dossiers
- shell-only open dossiers stop being the common outcome
- deep paths remain untouched and lawful
- no deep dossier regresses to weaker ordinary output

## Failure conditions

- open symbols still settle as tiny shells
- deep or current-focus paths regress
- ordinary dossiers become lawless mixed/deep copies
- throughput worsens materially while fixing dossier law
