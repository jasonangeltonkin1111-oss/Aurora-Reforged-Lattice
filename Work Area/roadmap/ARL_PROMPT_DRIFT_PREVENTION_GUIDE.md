# ARL Prompt Drift Prevention Guide

Run: ARL-RUN009G  
Status: Mandatory for prompt-master and implementation-run prompts

---

## Purpose

Prompt drift is how long projects rot.

This guide lists the signs and corrections.

---

## Prompt Drift Signs

A prompt is drifting if it:

```text
forgets Work Area is active root
forgets reports go in Work Area/reports/
forgets Archives are Git-only
forgets mandatory read order
forgets external research
forgets Git check after research
forgets prompt-master archive inspection
forgets RUN006 trader-data law
forgets Brain Guidebook update check
forgets Git Summary / Git Description
forgets version decision
forgets acceptance tests/falsifiers
allows vague broad rewrites
allows new routes
allows direct archive copy
allows HUD/trading/signals/execution by accident
claims proof without evidence
```

---

## Immediate Correction

If drift appears:

```text
stop
restate active root
restate mandatory reads
restate source authority
restate exact scope
restate forbidden scope
restate report path
restate output package
restate evidence requirement
```

Then rebuild the prompt.

---

## Scope Compression Rule

If a prompt feels too broad, reduce it to the nearest owner slice.

Examples:

```text
Bad:
  build runtime/account/L1/L2/ranking outputs

Good:
  implement atomic status publication only
```

```text
Bad:
  improve all trader outputs

Good:
  implement Symbol Trader Pack schema and one text sample output only
```

---

## No “Continue Work” Rule

Forbidden prompt:

```text
Continue from the last run and fix what is needed.
```

Required prompt:

```text
Run ID
Mode
Mandatory reads
Source baseline
Allowed files
Forbidden files
Research
Git/Archive checks
Acceptance tests
Report/package
```

---

## Prompt Final Gate

Before sending, ask:

```text
Can a different chat execute this without hidden context?
```

If not, rewrite.
