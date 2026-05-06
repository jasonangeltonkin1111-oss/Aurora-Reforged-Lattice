# ASC Write Trigger and Publication Matrix

## Purpose

This contract binds artifact publication to explicit state/materiality/freshness triggers so writes occur when warranted and remain bounded.

Tactical realtime field cadence/write boundaries are normatively bound to `ASC_TACTICAL_REALTIME_FIELD_CONTRACT.md`.
Scheduler-vs-execution timing and HUD transaction ownership boundaries are normatively bound to `ASC_MICRO_BURST_EXECUTION_AND_HUD_TRANSACTION_CONTRACT.md`.

---

## Contract G — Publication trigger matrix

Publication requires a valid trigger, a materiality reason, freshness compliance, and guard-passing state.

Micro-burst work does not imply micro-write behavior. Tactical strip motion is non-material unless structural state changed. HUD transaction completion is not itself a structural publication trigger. Layer 5 arm request is not itself a deep publish event. Layer 5 completion may create publish eligibility only when material and guard-compliant.

| Artifact family | State trigger | Materiality threshold | Freshness threshold | Publication action |
|---|---|---|---|---|
| Layer 1 market-state surfaces | Coverage delta or regime/status change | Any regime change is material; minor metric drift may batch | Must be newer than prior landed state and inside Layer 1 freshness budget | Atomic publish on next write lane |
| Layer 2 open-symbol snapshot | Open-symbol set change or symbol packet delta above noise floor | Symbol entry/exit is always material; packet micro-noise may defer | Packet age must satisfy snapshot SLA | Publish changed subset; keep unchanged members untouched |
| Layer 3 candidate filtering outputs | Candidate pass/fail set changed | Candidate membership change is material | Filter outputs must be computed from non-stale inputs | Publish filter surface + provenance stamp |
| Layer 4 shortlist selection | Ranked shortlist membership/order changed | Membership change is material; minor score-only drift may batch | Upstream inputs must be fresh within lane contract | Publish shortlist atomically with version increment |
| Layer 5 deep selective analysis | Promoted symbol deep packet changed beyond advisory epsilon | Promotion status or recommendation-class change is material | Deep packet freshness must satisfy promoted-set policy | Publish per-symbol deep artifacts for changed promoted set |
| Governor/telemetry state surfaces | Mode, starvation flag, congestion posture, degradation posture changes | Any state flip is material | Must represent current beat decision context | Publish control-state update |

### Layer 1 publication eligibility detail (mandatory)

Layer 1 publication must distinguish four lawful outcomes:

1. **Partial scan publication eligible**
   - meaningful assessed subset exists
   - cycle is still partial
   - publication state is explicit (`partial`, `stale`, or `degraded`)
   - no wording may imply full-cycle completion or full-universe coverage
2. **Full cycle completion publication**
   - due posture is serviced for active cycle
   - Layer 1 summary marks complete and readiness/degraded posture
   - publication state may be `fresh` (or `degraded` if truth quality requires)
3. **Stale/degraded/continuity publication**
   - write still lands when failure or lag makes fresh impossible
   - state reason and age/degradation posture are mandatory
   - continuity cannot be presented as new fresh truth
4. **Readiness-significant publication**
   - Layer 1 readiness posture materially changes (for example partial -> ready, ready -> degraded, or stale recovery to ready)
   - readiness transition reason must be published explicitly
   - readiness publication must not be delayed until unrelated downstream artifacts update

Cadence honesty law:
- Fast Layer 1 scan behavior does not imply reckless publication cadence.
- Publication remains trigger/materiality/freshness guarded even when scan service is fast.
- Tactical liveliness or retry churn must not widen write cadence into storms.

These outcomes keep write discipline bounded while preventing fake completeness and write storms.

---

## Contract H — Write trigger classes

| Trigger class | Description | Can force write lane? |
|---|---|---|
| Protected landing-age breach | Ready payload waited beyond protected max age | Yes |
| Structural state transition | Mode/degraded/recovery/posture transition requiring explicit visibility | Yes |
| Material artifact delta | Content changed beyond family-specific materiality threshold | Usually (subject to queue pressure) |
| Freshness expiry rollover | Existing landed artifact crosses stale/degraded boundary | Yes, for state-flag publication |
| Cosmetic/non-material drift | Changes below materiality threshold | No |

---

## Contract I — Publication guards and denial conditions

A candidate write is denied (or deferred) when any denial condition is true.

| Guard group | Must be true to publish | Deny/defer when |
|---|---|---|
| Ownership guard | Persistence lane owns the beat or forced-write override is active | Write attempted from read/HUD/utility context |
| Atomicity guard | Temp->final promotion and rollback path are available | Atomic promotion path missing or unsafe |
| Freshness guard | Inputs are within artifact-family freshness envelope | Inputs already stale beyond allowed envelope |
| Materiality guard | Change exceeds family materiality threshold or state flag must change | No material change and no required state transition |
| Honesty guard | Pending/stale/degraded status can be emitted with write | Publish would mask degraded/unknown posture |

### Never-publish shortcuts

Never allowed:
- publishing from HUD repaint hooks,
- treating in-memory T0/T1 cache as landed artifact truth,
- self-confirming writes that skip ownership and atomicity guards,
- suppressing stale/degraded flags to keep a "clean" surface.
- visual-only state change treated as publishable structural delta.
- selected-symbol tactical repaint treated as publishable structural delta.
- page transition state treated as publishable structural delta.
- retry metadata churn treated as publishable structural delta.

Future implementation must not escalate persistence cadence merely because a field is displayed at fast cadence in HUD.

---

## Contract J — Atomic publication doctrine for Board, Current Focus, and Dossiers

Market Board, Current Focus, and per-symbol Dossiers must publish with the same non-negotiable atomic sequence:
1. write temp artifact
2. validate schema/state/freshness posture and required section presence
3. atomically promote temp artifact to canonical path
4. emit truthful publication-state output (`fresh`, `stale`, `degraded`, `continuity`, or `failure`) with reason metadata

Continuity and last-good law:
- If fresh publish fails, last-good continuity may remain visible only with explicit continuity labeling and source age/timestamp.
- No silent write failure is allowed.
- Publication-state output must truthfully represent per-surface outcome for Market Board, Current Focus, and Dossiers.

Current Focus switch safety law:
- Rewriting singleton Current Focus for a newly selected symbol must not destructively reset valid per-symbol dossier deep-analysis last-good data.
- Symbol dossiers remain persistent deep-history owners regardless of Current Focus replacement events.

Essentials-first backlog law:
- `Market Board` and `Current Focus` are the essentials-first publication pair and must complete before dossier cursor advancement.
- If write budget exhausts mid-cycle, the next write beat must resume from the correct essential or dossier cursor instead of silently skipping the unfinished essential artifact.
- Full-universe dossier publication may lawfully span multiple write beats, but the visible backlog state must stay truthful until the dossier cursor reaches zero remaining backlog.
