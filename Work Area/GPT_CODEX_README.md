# GPT / Codex README for ARL Work Area

This file is the plain-English start page for agents before touching Aurora Reforged Lattice.

## The First Danger

The easiest way to break ARL is to guess. Do not guess the repo structure. Do not trust old chat memory. Do not build from Archives. Read the owner files first.

## Workflow

1. Audit the uploaded zip/source package.
2. Confirm `Work Area/` is active root.
3. Confirm `Archives/` are not inside the Work Area package.
4. Read the mandatory files in `office/ARL_MANDATORY_READ_INDEX.md`.
5. Research before serious code, architecture, runtime, file I/O, output, Git, or agent-workflow changes.
6. Check Git only after zip audit and research.
7. Patch owner files only.
8. Validate paths, boundaries, changed files, and version impact.
9. Report honestly.
10. Package changed files only.

## Compile and Testing Honesty

- Documentation-only runs do not require compile.
- MT5 source behavior changes require compile attempt when MetaEditor is available.
- Static validation proves only file/path/content checks.
- Compile success proves syntax/build compatibility only.
- Runtime proof requires runtime logs/output.
- Live proof requires live evidence.

## Packaging Rules

- Preserve the original folder layout.
- Exclude `Archives/`.
- Exclude binaries unless a future task explicitly asks for them.
- Include root `AGENTS.md` only when it changed.
- Do not package a full repo when changed-files-only is enough.

## No-Route-Drift Rules

Fix the owner file. Do not create a second writer, bypass route, duplicate registry, cosmetic module, or shadow source of truth.

## Trader-Data Law

RUN006 sample and blueprint files are mandatory references for output work. Human trader text should show actionable trader data first. JSON, manifest, and debug files own metadata and diagnostics.

## Version Law

Product version follows `a.bcd`. Documentation/guide runs keep the product version unchanged unless MT5 source behavior changes.

## Git Message Standard

Use:

- a proper Git Summary header;
- a deep structured Git Description;
- no sandbox links;
- no citations;
- no full pasted ChatGPT answer;
- no fake proof claims.
