# ARL Codex Prompt Rules

## Codex role now

Codex builds the MT5 scaffold only.

GPT later fleshes out the system through zip upload workflow.

## Codex may create

```text
mt5/ folder layout
empty or no-op compile-safe .mq5/.mqh files
README/module ownership docs
include-boundary comments
TODO stubs
```

## Codex must not create

```text
trading logic
signal logic
entry/stop/target logic
risk execution
HUD
ranking formulas
deep-review formulas
direct ASC source copies
alternate writer routes
legacy dispatcher port
```

## Required Codex scaffold behavior

Every scaffold source file should include a header comment:

```text
ARL scaffold file.
Active implementation pending GPT research/source pass.
Related roadmap:
Related blueprint:
Office logs:
Trading permission: false.
HUD permission: false.
```

## Codex output expectations

After scaffold creation, Codex must report:

```text
files created
folders created
no active logic added
no HUD added
no execution logic added
no direct ASC migration
compile claim only if actually compiled
```

## Prompt safety line

Every Codex prompt should contain:

```text
Do not invent proof. Do not claim compile, runtime, edge, or live readiness unless directly evidenced.
```

---

## RUN005 Prompt Rule Patch — No Fake Research, No Fake Proof

Codex/GPT prompts must require proof language discipline:

- Compile success requires actual compiler output.
- Runtime success requires runtime log/output evidence.
- Internet research requires actual source access and citations.
- If source access is blocked, say blocked.
- Do not use old assistant summaries as primary proof.
- Do not paste giant ChatGPT answers into Git commit messages.

Recommended Git commit shape:

```text
ARL-RUN005: align Work Area version identity and source records

Mode:
Scope:
Files changed:
Evidence:
Compile result:
Runtime result:
Version impact:
No-trade/no-HUD confirmation:
Next run:
```

## ARL-RUN007 Git Summary and Description Rule

Codex/Git prompts must request:

```text
GIT SUMMARY:
AURORA REFORGED LATTICE — ARL-RUN### / PRIMARY PURPOSE + SECONDARY PURPOSE

GIT DESCRIPTION:
MODE:
<mode>

SUMMARY:
<deep paragraph>

WHY:
<problem/gap solved>

WHAT CHANGED:
- bullet list

FILES ADDED:
- paths

FILES CHANGED:
- paths

FILES INSPECTED BUT NOT CHANGED:
- paths if useful

BOUNDARIES:
- no HUD
- no trading
- no signals
- no execution
- no direct archive migration
- no fake proof

VERSION IMPACT:
<version decision>

EVIDENCE:
<zip audit, source inspection, research, compile/runtime if available>

RISKS:
<remaining risks>

NEXT:
<strongest next move>
```

The summary must be a proper header. The description must be detailed, not tiny, and must not paste the full final ChatGPT report.
