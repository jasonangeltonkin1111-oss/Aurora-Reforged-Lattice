# ASC Stage 3 — Layer 1 Market State

## Purpose

Stage 3 builds the first real scanner truth domain inside Aurora Sentinel Core.
Layer 1 must answer the broad question:

> is this symbol open, closed, uncertain, or still unknown?

It must do so cheaply, broadly, and honestly.

---

## Scope in this stage

Layer 1 includes:
- broad market-state scanning
- open / closed / uncertain / unknown posture
- observed-at timestamps
- honest reasons for the current posture
- landed output into the pre-existing dossier scaffold
- summary counts that reflect the current Layer 1 pass

Layer 1 does **not** include:
- Layer 2 richness
- classification buckets
- shortlist logic
- deep analysis
- HUD redesign
- menu work

---

## Runtime boundary inherited from Stage 2

Stage 3 is not allowed to invent its own execution rhythm.
Layer 1 must live inside the governed heartbeat and lane system established earlier.

That means Layer 1 must obey all of the following:
- one major lane per heartbeat
- bounded sub-lane admission only
- wide but bounded scan slices
- cursor-based continuation across beats
- no mixed scan/write/display heavy pulse
- publication happening through atomic write windows rather than inline scan-side dumping

If Layer 1 appears to work only by widening pulses, restarting from the front repeatedly, or writing directly during heavy scan work, the implementation is invalid.

---

## Output doctrine for Stage 3

Layer 1 must land into the scaffold created earlier.
That means:
- each dossier gets truthful Layer 1 content
- later layer homes remain present but honest about not being implemented
- the summary reflects Layer 1 counts without pretending bucket or shortlist truth exists yet

Layer 1 may not invent later-layer values simply because a dossier is being written.

---

## Boundary reminders

### Classification
Must come later and must be based on archive truth.
No invented classification system is allowed here.

### HUD
The existing HUD may consume Layer 1 counts, but Stage 3 does not authorize a redesign.
Later HUD work must use archive HUD evidence as inheritance.

### Menu
Not part of Stage 3.

---

## Practical success condition

Stage 3 is materially real when the runtime can lawfully show, for broker symbols:
- current Layer 1 posture
- why that posture was assigned
- when it was observed
- that the result landed visibly into the dossier/summary output tree
