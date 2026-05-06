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
