# AURORA PROMPT MASTER BRAIN GUIDEBOOK

Run: ARL-RUN009G  
Status: Mandatory for prompt-master chats

---

## Purpose

This guidebook is for prompt-master chats.

A prompt-master chat does not primarily edit files.  
It builds the next run prompt, checks Git/Archives, carries context, prevents drift, and tells the downstream GPT/Codex chat what to read and what to do.

---

## Prompt Master Prime Law

```text
A prompt-master chat must not build a serious ARL prompt from memory alone.
```

Before building a serious prompt, the prompt-master must:
1. identify the requested run,
2. check latest Git state if Git access exists,
3. inspect Git Archives relevant to the run scope,
4. extract archive lessons into constraints,
5. include mandatory-read files,
6. include audit-first order,
7. include research-before-patch order,
8. include Git check after research,
9. include report location under Work Area/reports/,
10. include Git Summary and Git Description,
11. include version decision rules,
12. include allowed and forbidden scope,
13. include acceptance tests and falsifiers,
14. include packaging rules.

---

## Prompt Master vs Implementation Agent

```text
Prompt Master:
  checks Git/Archives,
  designs prompt,
  sets scope,
  carries archive findings,
  prevents drift.

Implementation agent:
  audits zip,
  researches,
  patches Work Area,
  tests,
  packages files.
```

The other chat may not have Git or Archives access.  
Therefore, the prompt-master must put relevant archive findings inside the prompt.

---

## Mandatory Prompt Sections

Every serious ARL prompt must include:

```text
GIT SUMMARY
GIT DESCRIPTION
MODE
SOURCE PACKAGE
CURRENT KNOWN GIT STATE
ARCHIVE FINDINGS TO CARRY INTO THIS RUN
MANDATORY RUN ORDER
MANDATORY READ LIST
RESEARCH REQUIREMENT
FILES ALLOWED
FILES FORBIDDEN
PATCH SCOPE
VERSION DECISION
ACCEPTANCE TESTS
FALSIFIERS
REPORT LOCATION
OUTPUT PACKAGE
FINAL ANSWER FORMAT
```

No vague “continue the work” prompts.

---

## Archive Inspection Rule

For serious prompts, inspect Git Archives relevant to the work.

Examples:

```text
Runtime IO prompt:
  inspect old file publication/status/manifest/archive patterns.

Trader-output prompt:
  inspect old Market Board, Dossier, Symbol Data Pack examples.

Guidebook prompt:
  inspect old doctrine/extraction/ledger/guide patterns.

Account/trade-history prompt:
  inspect old account/exposure/trade-history outputs if available.
```

Then add an `ARCHIVE FINDINGS TO CARRY INTO THIS RUN` section.

---

## Report Location Rule

Every prompt must put reports under:

```text
Work Area/reports/ARL_RUN###_REPORT.md
```

Not loose in Work Area root.

---

## Git Summary / Description Rule

Prompt must provide both:

```text
GIT SUMMARY
AURORA REFORGED LATTICE — ARL-RUN### / PRIMARY PURPOSE + SECONDARY PURPOSE
```

and detailed:

```text
GIT DESCRIPTION
MODE
SUMMARY
WHY
WHAT CHANGED
FILES ADDED
FILES CHANGED
BOUNDARIES
VERSION IMPACT
EVIDENCE
RISKS
NEXT
```

Summary = proper header.  
Description = deep detail.

---

## Drift Detection

A prompt is drifting if it:
- forgets Work Area root,
- forgets reports folder,
- omits mandatory-read list,
- omits research,
- checks Git before zip audit/research in implementation runs,
- forgets Archives are Git-only,
- allows new routes,
- allows direct archive copy,
- omits version decision,
- omits falsifiers,
- omits Git Summary / Git Description.

Stop and rewrite if drift appears.

---

## Prompt Master Final Check

Before giving the prompt, ask:

```text
Can another chat execute this without my memory?
Does it know what to read?
Does it know what not to touch?
Does it know where report goes?
Does it know how to handle Git/Archives?
Does it know how to prove or not prove success?
```

If no, the prompt is not ready.
