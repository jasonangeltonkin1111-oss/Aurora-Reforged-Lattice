# MT5 Source Header Standard

Every `.mqh` module should keep a compact source header with:

- owner
- purpose
- inputs
- outputs
- forbidden ownership
- scaffold/runtime status

Do not paste long doctrine into source files.

Source files should be clear enough for future GPT/Codex passes to patch the correct owner without creating duplicate routes.

## Anti-cosmetic rule

If a module has no future runtime contract, no output contract, no acceptance test, and no real ownership boundary, it should be removed or merged.

## ARL-RUN007 Source Header Standard

Source headers may identify the latest source-alignment run, but must not become historical ledgers.

Required header fields for active MT5 source:
- product/module name;
- current run that last aligned or changed the source file;
- current status;
- purpose;
- forbidden ownership.

Forbidden:
- changelog blocks in `.mqh` source;
- old run history copied into source;
- archive migration history inside source;
- proof claims without compile/runtime evidence.
