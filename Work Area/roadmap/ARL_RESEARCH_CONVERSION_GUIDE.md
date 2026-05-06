# ARL Research Conversion Guide

Run: ARL-RUN009G  
Status: Mandatory for serious research

---

## Purpose

This guide defines how research becomes build law.

Research that does not become a constraint, acceptance test, falsifier, or brain update is weak.

---

## Required Table

```text
Source:
Finding:
Evidence rank:
Why it matters:
Risk prevented:
ARL constraint:
Owner file/module:
Implementation impact:
Acceptance test:
Falsifier:
Brain update needed? yes/no:
Destination guidebook section:
```

---

## Minimum Research Quality Gate

For serious ARL work:

```text
1. At least one primary source for platform/API behavior where relevant.
2. At least one archive lesson for inherited ASC/Aurora areas where relevant.
3. Every research finding must have a test or falsifier.
4. No passive citation-only notes.
5. Research must change either code, docs, acceptance criteria, or brain guidebook.
```

---

## Research Rejection

Reject a research item if:

```text
it is interesting but not actionable
it repeats existing guidebook law
it does not prevent a failure
it does not improve implementation
it does not create a test
it is too vague to falsify
```

---

## Research Output Placement

Research details go in:

```text
Work Area/reports/ARL_RUN###_REPORT.md
Work Area/office/ARL_RESEARCH_LEDGER.md
Work Area/brain/AURORA_RESEARCH_BRAIN_GUIDEBOOK.md if durable
```

Do not scatter research across random docs.
