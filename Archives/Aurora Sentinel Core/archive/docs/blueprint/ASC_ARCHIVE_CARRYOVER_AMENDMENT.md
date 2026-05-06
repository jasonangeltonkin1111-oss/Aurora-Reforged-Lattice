# ASC Archive Carryover Amendment

## Status
Drafted from the most recent archived ASC generation and the clarified carryover requirements in this chat.

## Purpose
This amendment exists to preserve hard-won operator, HUD, dossier, publication, and output-shape rules from the archived system while the new MT5 include/code system is rebuilt.

It is **not** a drastic redesign.
It is a carryover-and-gap-filling document so the new system does not regress into generic developer language, weak output shape, scattered publication, or broken operator surfaces.

---

## 1) Source posture for this amendment

### 1.1 Order of authority for this amendment
1. Current user carryover requirements stated in this chat
2. Most recent archived ASC blueprint and runtime behavior that clearly encode prior intent
3. Archived supporting implementation details where they do not conflict with current carryover intent

### 1.2 Non-goal
This amendment does **not** authorize a fresh architecture rewrite.
It only preserves and tightens missing or easily-lost doctrine that must be woven into the new system.

---

## 2) Operator language law

### 2.1 Hard ban on developer-facing jargon in operator surfaces
The EA face must not show ugly internal-development wording.
This includes, but is not limited to:
- layer
- step
- market_truth
- prepared truth
- reserved
- provisional
- build-wave phrasing
- vague engineering placeholders
- debug-style state wording leaking into HUD, summary, or dossier face

### 2.2 Allowed internal language
Inside code, functions, files, structs, and logs may use precise responsibility-based engineering names.
Internal naming should remain explicit and readable.

That means:
- internal names should tell the operator/developer what the function actually owns
- internal names should not be vague or messy
- debug output should identify the actual function or responsibility clearly
- internal clarity is allowed
- external ugliness is not

### 2.3 Face-language doctrine
Operator-facing wording must be:
- clean
- compact
- human-readable
- market/operator oriented
- free of architecture jargon

### 2.4 Translation doctrine
If internal architecture wording exists, it must be translated before it reaches:
- HUD
- summary
- dossiers
- operator-visible publication surfaces

---

## 3) Capability ownership still stands, but face translation is mandatory

The archived ordered capability model remains structurally useful and should stay preserved internally:
- Market State Detection
- Open Symbol Snapshot
- Candidate Filtering
- Shortlist Selection
- Deep Selective Analysis

But this does **not** give permission to expose numbered capability/layer wording directly on the operator face.

Internal ordered ownership may stay.
Visible operator language must stay translated.

---

## 4) Publication law

### 4.1 Truth ownership
The runtime owns truth blocks.
Later surfaces consume truth.
They do not invent it.

### 4.2 Publication order remains owned by capability
The effective publication order remains:
1. market-state block
2. open-symbol packet block
3. filter/eligibility block
4. shortlist/top-set block
5. deep packet block
6. composed downstream surfaces later

### 4.3 Dossier and summary are downstream surfaces
The dossier is not the birthplace of lower-layer truth.
The summary is not the birthplace of lower-layer truth.
They must consume already-owned runtime truth.

### 4.4 Writer discipline
Writers format and publish.
Writers do not perform opportunistic ranking math, inference, or hidden recomputation.

### 4.5 Atomic discipline
All publication remains atomic:
- temp
- validate
- promote
- preserve last-good where applicable

If a later surface fails, earlier visible truth must remain intact.

---

## 5) Required output shape for the rebuilt system

### 5.1 Exactly two primary output forms
The rebuilt system must preserve these two primary operator-facing output forms:

#### A. Server summary file
One summary file inside the broker/server folder.
It uses the **server name only**.
No account-based duplication.
No account identity in path shape.

#### B. Symbol dossiers
One folder containing one file per symbol.
These are the dossiers.

### 5.2 Path doctrine
Storage identity is broker/server level.
Not account level.

Expected posture:
- one server folder per broker/server name
- one summary file in that server folder
- one symbol-universe/dossier area under that same server-owned tree
- one dossier file per symbol

### 5.3 Naming doctrine
Use server-name-only identity for the output root and summary naming.
Do not leak account-based naming into the publication identity.

---

## 6) Summary file doctrine

### 6.1 Summary purpose
The summary is the broker/server level operator snapshot.
It must be useful, selective, and calm.
It must not become a universe dump.

### 6.2 Summary contents
The summary must preserve:
- runtime posture
- open / closed / uncertain context
- shortlist/top-set posture
- promoted/deeper-set posture where applicable
- bucketed market map visibility

### 6.3 Selection doctrine
The summary must preserve the bucketed shortlist shape:
- **Top 5 per bucket** as the canonical bucket view
- then **Top 10 overall** as the cross-bucket promoted operator set

### 6.4 Important doctrine for Top 5 and Top 10
This means:
- the bucket view remains bucket-faithful first
- the overall promoted set is derived after bucket-level bounded selection
- overall Top 10 must not destroy bucket identity
- bucket scarcity must be handled honestly
- sparse buckets are allowed to remain sparse
- the system may spill/fill honestly, but must not fake membership or flatten real grouping truth

### 6.5 Summary must remain downstream
The summary must not outrun symbol truth.
It must not recompute ranking at write time.
It must not become a hidden second engine.

### 6.6 Summary cadence
Summary publication is selective and later than raw owned truth blocks.
It should update when the underlying owned state justifies it, not because the HUD is open.

---

## 7) Dossier doctrine

### 7.1 Dossier purpose
The dossier is the per-symbol operator file.
It must be useful, rich, clear, and ordered for actual reading.

### 7.2 Dossier posture
The dossier must consume runtime-owned truth already produced elsewhere.
It must not invent missing fields just because a file is being written.

### 7.3 Dossier face order
The dossier must start with an immediately useful operator summary.
Do not bury the important current state deep inside the file.

The top area must quickly answer:
- is the market open or closed
- is the symbol in session
- is a tick present
- how fresh is the tick
- current bid / ask / spread when appropriate
- snapshot state
- filter state
- shortlist state
- why it is currently where it is

### 7.4 Dossier structure carryover
The rebuilt dossier should preserve a clean high-value structure with three practical blocks:
1. broker/specification truth
2. OHLC/history truth
3. calculations / derived metrics

The operator summary sits above those sections as a readable front door.

### 7.5 Dossier richness law
Do not regress dossiers into useless shells.
The dossier should preserve valuable current packet truth, classification truth, state continuity markers, and readable reasons.

### 7.6 Dossier cadence law
Dossier writes stay selective.
Focused viewing is not permission for same-speed file writes.
Fast on-screen symbol hydration may exist, but file writes remain bounded and atomic.

---

## 8) HUD doctrine

### 8.1 HUD purpose
The HUD is an operator surface, not a maintenance engine.

### 8.2 Hard HUD bans
The HUD must not:
- show internal layer or step jargon
- show "market_truth" style wording
- show "prepared truth" wording
- show filler states like "reserved" on the face
- perform hidden maintenance work during render
- re-derive scanner truth on redraw

### 8.3 Allowed HUD function
The HUD may:
- consume already-prepared truth
- present overview -> main buckets -> sub-buckets -> symbols -> symbol detail -> stat detail
- selectively live-paint focused-symbol fields directly from live symbol access where explicitly allowed

### 8.4 Focus/live-paint doctrine
Focused symbol display may update selective live fields quickly, such as:
- server time / clock
- bid
- ask
- spread
- daily change
- similar current display fields

But:
- this is display hydration, not blanket fast file writing
- this does not authorize full-universe redraw compute
- this does not authorize hidden downstream analysis expansion

### 8.5 Smoothness doctrine
HUD smoothness is prioritized over decorative complexity.
A short bounded transition lock/freeze is acceptable for better page switching feel.

---

## 9) Grouping and bucket doctrine

### 9.1 Bucketed market map remains mandatory
The system must preserve bucket-driven organization.
This is not optional cosmetic grouping.

### 9.2 Main bucket doctrine
The operator-facing high-level buckets remain the core market map:
- FX
- Indices
- Metals
- Energy
- Crypto
- Stocks

Additional valid families may exist only if grounded in real classification truth.

### 9.3 Sub-bucket doctrine
Sub-buckets remain dynamic and classification-driven.
They must not be faked.
They must not flatten meaningful structure.

### 9.4 Bucket visibility doctrine
- Open-only mode may hide buckets with no open members
- Buckets that do not exist for a server should stay hidden
- Dynamic membership must remain truthful to broker/classification reality

### 9.5 Classification law
Classification remains authoritative and translation-safe.
Suffix stripping, normalization, canonical mapping, and primary-bucket resolution must stay conservative and explicit.

---

## 10) Timing and cadence doctrine to preserve during rebuild

### 10.1 No drastic system rewrite through this amendment
This amendment preserves timing intent without authorizing broad architectural upheaval.

### 10.2 Core cadence principle
Owned truth lands first.
Composed surfaces come later.
Display-fast is not the same as write-fast.

### 10.3 Selective write law
- raw owned blocks may publish when their owned truth changes
- summary is later and selective
- dossier compose is selective
- focus does not authorize same-speed file churn

### 10.4 Shortlist/deeper cadence carryover
The promoted/deeper set may keep rank-sensitive faster maintenance than the broad universe, but this remains bounded and downstream of shortlist admission.

### 10.5 Atomic pause doctrine
When a write/publish block is committed, it is acceptable for other work to pause briefly so atomic promotion completes cleanly.

---

## 11) Debug and logging doctrine

### 11.1 Internal clarity required
Debug and logs should name the actual responsibility clearly.
The operator/developer should know what function or subsystem is acting.

### 11.2 External cleanliness required
That internal clarity must not leak ugly engineering phrasing onto operator surfaces.

### 11.3 Logging value doctrine
Logs should help future audit runs quickly determine:
- what changed
- what published
- what failed promotion
- what stayed last-good
- what cadence or gate blocked progress

---

## 12) Specific carryover decisions for the new system

### 12.1 Keep
Keep these doctrines from archive carryover:
- ordered capability ownership internally
- atomic publication discipline
- summary as late/selective surface
- dossier as downstream composed surface
- server-name-only output identity
- bucketed market map
- sub-bucket navigation
- filter and shortlist boundedness
- focused-symbol live display as selective exception, not blanket expansion

### 12.2 Tighten
Tighten these for the new system:
- no layer/step/dev jargon on operator face
- no market_truth wording on HUD
- no prepared truth wording on HUD
- summary explicitly carries Top 5 per bucket plus Top 10 overall
- dossier face order starts with immediate operator summary
- summary and dossiers must remain useful, not hollow

### 12.3 Reject
Reject these regressions:
- account-based output duplication
- summary as giant dump
- dossier as birthplace of truth
- HUD render path doing maintenance work
- vague debug naming
- ugly operator wording
- drastic rewrite disguised as carryover work

---

## 13) Build integration instruction

When weaving this into the new system:
- preserve the new system’s direction
- do not violently revert architecture
- insert these rules as hard carryover constraints
- where archive and current intent conflict, prefer the cleaner current operator doctrine
- where archive and current intent agree, preserve explicitly

---

## 14) Immediate implementation checklist for the next code pass

1. Re-establish server-level output path ownership
2. Re-establish one summary file in the server folder
3. Re-establish one dossier file per symbol in the symbol folder tree
4. Enforce operator-surface language cleanup
5. Preserve summary as Top 5 per bucket plus Top 10 overall
6. Preserve dossier as downstream composed operator file
7. Preserve atomic publish with last-good safety
8. Preserve HUD as pure consumer/render surface
9. Preserve selective focused-symbol live paint without blanket write expansion
10. Preserve classification-driven grouping and suffix-safe identity

---

## 15) Final doctrine sentence

The new system should feel like a cleaner continuation of the best archived ASC work — not a reset that forgets the operator craft, output discipline, dossier value, and market-map quality that already took countless hours to refine.


## 16) Archive inheritance classification canon

Archive inheritance decisions are formally classified in:
- `blueprint/ASC_ARCHIVE_INHERITANCE_CLASSIFICATION.md`

This canon locks domain-by-domain inherit/reject posture for HUD, menu/settings, board/dossier, and runtime cadence so carryover integration remains explicit and auditable.
