# HUD Operator Surface Law

## Purpose

The HUD is an operator surface.
It is not a second scanner engine.

## Always-on HUD law

The always-on HUD must stay calm, cheap, and readable.
Its job is to answer:
- what time is it now
- what mode is ASC in
- what is Layer 1 posture
- how many symbols are open / closed / uncertain / unknown
- what are the main buckets doing
- what is the shortlist/top-set posture

It must not behave like a broad render-time calculation engine.

## Focused-symbol HUD law

When the operator enters a symbol page, the HUD may paint live movement for that symbol only.
That focused-symbol fast surface may show:
- ticking server time
- bid
- ask
- spread
- day change
- current market-state note

This fast surface is:
- symbol-scoped
- display-only
- dispatcher-admitted
- reversible on focus exit

It is not:
- global packet refresh permission
- whole-bucket refresh permission
- persistence permission
- Layer 3/4/5 compute permission

## Layout law

The HUD must:
- consume already prepared truth
- keep object count bounded
- prefer retained objects and property diffs
- redraw only when object state changed materially
- avoid synchronous object-heavy scans in hot paths

## Page law

### Main pages
- overview
- main buckets
- shortlist posture
- promoted-set posture

These pages should be calm and summary-first.

### Focus pages
- symbol packet page
- symbol market-state page
- later stat/deep pages

These pages may activate focused-symbol fast paint, but only for their owned fields.

## Wording law

The HUD should speak operator language.
It should not expose raw internal control jargon when simpler truthful wording exists.

## Anti-patterns

Do not let the HUD:
- recompute bucket truth on click
- force full dossier rebuild on open
- trigger deep history pulls merely because a detail page is visible
- keep fast focus mode alive after focus moved elsewhere
