# ARL No Route Drift Rules

## Root law

If a module owns the behavior, fix that module.

Do not create another route to avoid fixing the owner.

## Forbidden repair patterns

```text
new writer created because old writer failed
new folder path created because old path was confusing
duplicate current file created
parallel Market Board route created
parallel Dossier route created
shadow snapshot created
emergency route without migration record
```

## Allowed route change

A route change is allowed only when all are present:

```text
old route owner
new route owner
reason
migration plan
compatibility impact
tests
rollback
office ledger update
```

## Detection tests

Search for:
- duplicate `Current` outputs
- two writers for one artifact
- two definitions of one path
- two ranking owner modules
- route helpers not referenced in contract
- old route still active after new route exists

## Decision rule

If route ownership is unclear:

```text
HOLD or TEST FIRST
```

## ARL-RUN007 Owner-File Repair Rule

When a flaw belongs to an existing owner, patch the owner file. Do not create a sibling route, duplicate helper, alternate composer, alternate scheduler, alternate writer, or shadow registry.

A new route is allowed only if the current owner truly cannot own the responsibility and the report explains:
- why the old owner cannot own it;
- what data crosses the new boundary;
- what must not cross;
- how the route is tested;
- how rollback works.
