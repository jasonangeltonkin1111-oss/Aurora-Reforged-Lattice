---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Permission Boundary Blueprint

ARL is review-only unless separately proven and authorized.

## Required Permission Block

Every main operator artifact must include:

```text
Review Permission: TRUE
Trade Permission: FALSE
Signal Permission: FALSE
Execution Permission: FALSE
Risk Permission: FALSE
```

## Forbidden Output Language

Do not output:

- buy now
- sell now
- enter here
- stop here
- target here
- trade ready
- execution approved
- prop firm safe
- guaranteed
- proven edge

## Allowed Output Language

Use:

- review candidate
- upload candidate
- high surface rank
- deep review complete
- exposure guarded
- friction guarded
- excluded from upload suggestion
- no trade permission
- requires operator review

## Review vs Trade

Review permission means the data file can be studied.

Trade permission means nothing unless explicitly built, tested, proven, and authorized later.

Current ARL scope: review only.
