# ARL Module Lock Sequence

A module can only be locked after proof.

## Lock eligibility

A module may be locked only after:

```text
static inspection passed
output contract passed
compile passed if source exists
runtime smoke passed if runtime behavior exists
no route drift found
office ledger updated
acceptance file satisfied
```

## Lock file location

Locks live outside roadmap:

```text
locks/LOCK_<MODULE>.md
```

## Required lock contents

```text
Module:
Locked version:
Owner files:
Inputs:
Outputs:
What it owns:
What it must never own:
Acceptance tests passed:
Known dependencies:
Known risks:
Allowed future changes:
Forbidden changes:
Breakage symptoms:
Rollback rule:
```

## Lock sequence

Recommended order:

```text
1. Runtime heartbeat/status
2. Atomic publication
3. Account snapshot/exposure
4. Market Watch universe
5. Layer 1 market state
6. Layer 2 symbol specs
7. Indicator registry/ATR
8. Layer 3 surface ranking
9. Layer 4 bucket ranking
10. Market Board
11. Layer 5 deep review scheduler
12. Dossier base
13. Efficiency/regression contracts
```

## Lock-breaking rule

A locked module may only be changed if the prompt names:

```text
why lock must change
exact owner file
dependency requiring change
test preserving old behavior
rollback plan
office ledger update
```

No silent lock breaks.
