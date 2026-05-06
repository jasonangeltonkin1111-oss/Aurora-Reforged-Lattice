# ARL Git Summary and Description Standard

ARL commit messages must be useful to a future auditor. A tiny vague summary is weak. A giant pasted final answer is also weak. The summary is the header. The description is the deep record.

## Git Summary

Use this format:

```text
AURORA REFORGED LATTICE — ARL-RUN### / PRIMARY PURPOSE + SECONDARY PURPOSE
```

The summary should be a proper header. It should identify the system, run, and highest-level change. Do not make it tiny or vague. Do not put the whole description into the summary.

## Git Description

Use this structure:

```text
MODE:
<mode>

SUMMARY:
<deep paragraph explaining the run>

WHY:
<problem, contradiction, gap, or risk solved>

WHAT CHANGED:
- <specific change>

FILES ADDED:
- <path>

FILES CHANGED:
- <path>

FILES INSPECTED BUT NOT CHANGED:
- <path>

BOUNDARIES:
- <what was explicitly not changed>

VERSION IMPACT:
<version decision>

EVIDENCE:
<zip/source audit, research, static validation, compile/runtime if actually done>

RISKS:
<remaining risks>

NEXT:
<strongest next move>
```

## Rules

- Description should be deep and detailed.
- Do not paste entire ChatGPT final answers.
- Do not include sandbox download links.
- Do not include web citations in commit messages.
- Do not claim compile/runtime/live proof unless actually produced.
- Do not hide version impact.
- Do not omit boundaries.

## Why This Standard Exists

External Git guidance commonly separates a short subject from a body that explains what and why. ARL keeps that principle, but uses a stronger structured description because the repo carries safety, source-truth, and proof-boundary requirements.
