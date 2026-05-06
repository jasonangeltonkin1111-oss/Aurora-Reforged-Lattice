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
