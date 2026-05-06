# ARL Archive Mining Guide

Run: ARL-RUN009G  
Status: Mandatory when Git Archives are relevant to a run

---

## Purpose

This guide defines how to use Git Archives without infecting active ARL source.

---

## Archive Law

```text
Archives are inheritance evidence only.
```

Archives may be mined for:
- old failure modes,
- output field examples,
- migration candidates,
- source ownership warnings,
- anti-patterns,
- useful trading-data structures.

Archives may not:
- outrank active Work Area,
- be copied directly,
- be treated as active source,
- be included in Work Area zips,
- become hidden authority.

---

## Prompt-Master Archive Duty

Before writing a serious ARL prompt, the prompt master must inspect relevant Archives when the run scope is connected to old ASC/Aurora behavior.

The downstream chat may not have Git/Archives access.

Therefore, the prompt must carry:

```text
ARCHIVE FINDINGS TO CARRY INTO THIS RUN
```

---

## Archive Findings Format

```text
Archive file/pattern:
What it did well:
What it did badly:
ARL constraint:
Owner file/module:
Acceptance test:
Falsifier:
Migration candidate? yes/no
Direct copy allowed? no unless explicitly authorized
```

---

## Examples

### Runtime IO work

Inspect old:
- status publishing,
- file publication,
- manifest,
- last-good/no-change contracts.

Extract:
- atomic lessons,
- stale-current risks,
- route duplication risks.

Do not copy old code.

### Trader-output work

Inspect old:
- Market Board,
- Dossiers,
- Symbol Data Packs.

Extract:
- trader data fields,
- metadata bloat risks,
- per-symbol depth requirements.

Do not copy old output walls.

### Guidebook / research work

Inspect old:
- extraction ledgers,
- book protocols,
- blob organization,
- bridge protocols.

Extract:
- useful tracking concepts,
- sprawl anti-patterns.

Do not recreate random doctrine piles.

---

## Archive Contradiction Rule

If Archives conflict with current Work Area:

```text
current Work Area wins
log archive contradiction
extract lesson only
```
