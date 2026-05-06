# ARL Lock Policy

## Purpose

This file defines how ARL stops working modules from breaking again.

## Lock principle

Once a module is proven, it becomes protected.

Protected means future work must not casually change its ownership, outputs, routes, or public contract.

## Lock file format

Each locked module gets:

```text
locks/LOCK_<MODULE_NAME>.md
```

Required fields:
- Module
- Locked version
- Owner files
- What it owns
- What it must never own
- Inputs
- Outputs
- Acceptance tests passed
- Evidence level
- Allowed future changes
- Forbidden future changes
- Dependencies
- Breakage symptoms
- Rollback rule
- Last reviewed

## Lock requirements

A module can be locked only after:
- source inspection
- compile/static validation if code exists
- output contract test
- runtime smoke test where applicable
- no trade permission leak
- no route mutation
- change ledger updated

## Fixing locked modules

A locked module can be changed only if the patch names:
- why lock must change
- exact owner file
- exact dependency change
- tests protecting old behavior
- rollback plan
- user-approved scope if route behavior changes

## No-new-route law

If behavior belongs to an existing owner, fix the owner.

Forbidden:
- bypass writer
- duplicate output path
- emergency parallel route
- shadow helper
- alternative current file
- unlogged migration path

Allowed only with route-change approval:
- new public artifact family
- new active route
- new writer owner
- ownership transfer

## Route-change record

If a route must change, record:

```text
route_change_id=
old_owner=
new_owner=
old_path=
new_path=
reason=
tests=
rollback=
user_approval=
```

Without this record, route change is invalid.

## ARL-RUN007 Lock Policy Addendum

Locked for implementation starts:

- `Work Area/` is active root.
- `Archives/` are Git-only inheritance evidence.
- Git/office own change history.
- MT5 source owns product identity, not changelog history.
- RUN006 trader-data reference law is mandatory for operator-facing output design.
- No route rewrites or duplicate owner modules may be created to avoid editing the real owner file.
