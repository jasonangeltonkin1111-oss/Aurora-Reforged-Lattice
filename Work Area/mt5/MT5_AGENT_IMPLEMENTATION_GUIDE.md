# MT5 Agent Implementation Guide

This guide is for future MT5/MQL5 implementation agents. It does not authorize trading logic. It tells agents where the boundaries are before source work begins.

## Read First

Before editing MT5 source, read:

1. `Work Area/mt5/MT5_MODULE_OWNERSHIP.md`
2. `Work Area/mt5/MT5_VERSION_POLICY.md`
3. `Work Area/mt5/MT5_INCLUDE_BOUNDARY_PLAN.md`
4. `Work Area/mt5/MT5_SCAFFOLD_INDEX.md`
5. `Work Area/mt5/MT5_SOURCE_HEADER_STANDARD.md`
6. `Work Area/office/ARL_MANDATORY_READ_INDEX.md`
7. relevant roadmap acceptance file for the module being changed
8. relevant blueprint file for the output/behavior being changed

## Hard Bans Until Explicitly Authorized

Do not add:

- changelog `.mqh`;
- HUD;
- trading;
- signals;
- execution;
- strategy formulas;
- duplicate owner modules;
- bypass writers;
- direct archive source copy.

## Owner Modules Only

Each source truth must have one owner. If a module already owns a concern, patch that module. Do not add a parallel route.

## Include Preservation

Preserve include boundaries. Do not flatten includes, add circular dependencies, or import broad modules into narrow owners to “make it compile.” Fix ownership first.

## Every Module Must Earn Its Place

A module must prevent a known failure, expose an assumption, reduce source-truth ambiguity, reduce compile/runtime risk, improve output proof, or make acceptance testing clearer. If it only sounds impressive, delete or merge it.

## Compile Proof Rules

- Compile proof requires actual MetaEditor compiler output against current source.
- Compile success does not prove runtime behavior, edge, profitability, execution safety, or prop-firm readiness.
- If compile was not run, report `Compile not run`.
- If compile fails, report exact errors and repair owner files only.

## Runtime Proof Rules

Runtime proof requires logs/output from the current compiled EA. File existence alone is not runtime proof. Generated reports are not runtime truth unless tied to current runtime output.
