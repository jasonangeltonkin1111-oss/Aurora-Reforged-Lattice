# MT5 Include Boundary Plan

`ARL_Core.mq5` includes the entire scaffold to make missing include paths visible early.

Future implementation should keep these boundaries:

- core files may be included everywhere.
- runtime may depend on core, telemetry, and module status contracts.
- io may depend on core only.
- layer modules may depend on upstream layer contracts, not downstream outputs.
- Market Board and Dossiers consume snapshots; they do not calculate hidden truth.
- permission boundary may be consumed everywhere, but it grants nothing.

No module may include HUD because HUD is not part of the current scaffold.

## ARL-RUN007 Include Boundary Check

The active include authority is `Work Area/mt5/ARL_Core.mq5` plus files under `Work Area/mt5/`.

Rules for future runs:
- include paths must remain relative to `ARL_Core.mq5` unless a deliberate include-boundary change is documented;
- every include must resolve before claiming compile readiness;
- direct include migration from `Archives/` is forbidden;
- archive code may inform a rewrite, but active owner files must be patched in `Work Area/mt5/`.
