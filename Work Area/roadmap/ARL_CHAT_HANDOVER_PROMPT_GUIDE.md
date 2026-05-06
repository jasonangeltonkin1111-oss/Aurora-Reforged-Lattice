# ARL Chat Handover Prompt Guide

Run: ARL-RUN009G  
Status: Mandatory for new ChatGPT / prompt-master handover chats

---

## Purpose

This file tells a new ARL chat how to resume from a handover without drifting.

The first job is not to answer fast.  
The first job is to establish source truth.

---

## First Action After A Handover

When a user provides a handover, pasted report, zip, screenshot, compile log, or Git summary, do this:

```text
1. Identify what the user wants: audit, prompt, patch, debug, roadmap, research, explanation.
2. Confirm whether this is serious ARL work.
3. Read mandatory guide/index files if available.
4. Check Git state if Git access exists.
5. Check relevant Git Archives if the task scope needs archive lessons.
6. Separate evidence from assumptions.
7. Only then answer or build a prompt.
```

---

## Mandatory Read Order For Prompt-Master Chats

```text
Work Area/AGENTS.md
Work Area/WORK_AREA_INDEX.md
Work Area/GPT_CODEX_README.md
Work Area/office/ARL_MANDATORY_READ_INDEX.md
Work Area/brain/AURORA_BRAIN_GUIDEBOOK_INDEX.md
Work Area/brain/AURORA_PROMPT_MASTER_BRAIN_GUIDEBOOK.md
Work Area/brain/AURORA_RESEARCH_BRAIN_GUIDEBOOK.md
Work Area/brain/AURORA_FAILURE_PATTERNS_GUIDEBOOK.md
Work Area/roadmap/ARL_HANDOVER_INTAKE_CHECKLIST.md
Work Area/roadmap/ARL_PROMPT_MASTER_CHECKLIST.md
Work Area/roadmap/ARL_GIT_SUMMARY_DESCRIPTION_STANDARD.md
Work Area/roadmap/ARL_PROMPT_DRIFT_PREVENTION_GUIDE.md
Work Area/roadmap/ARL_EVIDENCE_AND_PROOF_LANGUAGE_GUIDE.md
```

If any are missing, say so and continue with uncertainty.

---

## Handover Truth Rule

A handover is evidence, not active source truth.

Authority order:

```text
active Work Area source
compile/runtime/log evidence
office records
roadmap/blueprint/brain
Git Archives as inheritance evidence
handover text
assistant memory
```

---

## Do Not Do This

Do not:
- assume latest run from memory,
- assume zip is current Work Area,
- assume compile passed because handover says it did,
- ignore report folder law,
- skip Git/Archive check when prompt-building,
- produce vague prompts,
- start coding from handover text alone.

---

## Required Output For Handover Analysis

When reviewing a handover, state:

```text
Known facts
Assumptions
Missing evidence
Contradictions
Strongest next move
```

For serious work, end with:
- proceed,
- hold,
- kill,
- or test first,
in natural language or formal decision label as appropriate.
