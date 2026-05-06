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
