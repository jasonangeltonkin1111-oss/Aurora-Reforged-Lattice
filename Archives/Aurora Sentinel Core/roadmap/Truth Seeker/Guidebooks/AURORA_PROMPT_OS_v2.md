# AURORA PROMPT OS v2

Purpose: make Aurora/Codex runs modular, bounded, evidence-ranked, and hard to drift. Activate only the modules needed for the current run.

## Core truth law

- Source truth first: active source/control files outrank prompts, reports, memory, generated output, screenshots, package names, archives, and Git history.
- AI inference proves nothing by itself.
- A patch proves only that files changed. Compile, runtime, live behavior, edge, and trading safety require their own evidence.
- Generated runtime output is read-only evidence unless a run explicitly scopes runtime output capture. It must not be edited or packaged as proof.
- Review/data surfaces never create trade, signal, execution, risk, or prop-firm permission.

## Evidence ladder

0. Claim, idea, intuition, or desired outcome  
1. AI inference  
2. User report, screenshot, pasted text, generated output, or old report  
3. Direct active source/control inspection  
4. Static validation, grep, schema validation, linter, or compile transcript  
5. Backtest with known settings/data/cost model  
6. Out-of-sample, walk-forward, or robustness test  
7. Forward demo  
8. Small live  
9. Multi-broker, multi-session, multi-regime live  
10. Production-proven with failure logs and operating bounds

Never claim above the strongest evidence actually present.

## Modules

| Module | Use when | Forbidden drift |
|---|---|---|
| M0_CORE_TRUTH | Every serious run | fake proof, vague authority |
| M1_SOURCE_BASELINE | Identity/source/control work | patching before source owner inspection |
| M2_RESEARCH_ROUTER | Tooling, API, broker, platform, or prompt-agent facts may have changed | ornamental research |
| M3_EVIDENCE_QUARANTINE | Old reports/prompts/logs conflict with source | letting evidence become authority |
| M4_COMPILE_RISK_SNIFFER | Static/compile-sensitive edits | claiming clean compile without transcript |
| M5_REFRESH_ENGINE | Refresh/family/lifecycle behavior | gates, timer lowering, broad rewrites |
| M6_PUBLICATION_FILEIO | File publication/path/readback issues | FileIO mutation without explicit scope |
| M7_FAMILY_TRUTH_TRANSPORT | Main/Lite/Dossier/SDP parity | Lite independent truth |
| M8_DATA_HYDRATION_STATUS | Missingness/completeness/status fields | fake values or writer-owned market-data calls |
| M9_SIAM_REVIEW_SELECTOR | Siam upload/review workflow | review-to-trade permission |
| M10_L3_L4_BOUNDARY | L3/L4 context/explanation | formula/rank/order/membership drift |
| M11_PERMISSION_SAFETY | Every trading-adjacent run | permission leaks |
| M12_LIVE_COMPILE_PROOF | Compile/live proof runs only | source features during proof unless escalated |
| M13_PROMPT_SYSTEM | Prompt/doctrine/run-sheet work | bloated essays without enforcement |
| M14_ROADMAP_CONTROL | Roadmap/office/manifest alignment | stale control authority |
| M15_EDGE_VALIDATION | Any edge/strategy/profit claim | optimizing before falsification |
| M16_PACKAGE_REPORT | Every deliverable package | whole repo dumps or generated-output proof |

## Research router

Use official/current sources when facts can change: OpenAI/Codex behavior, MT5/MQL5 rules, broker/prop-firm rules, platform behavior, API behavior, product/tooling constraints, or any external claim. Convert research into code constraints, acceptance tests, logs, falsifiers, or kill conditions. Delete decorative research.

## Source inspection router

Before editing, identify:
- owner file;
- current source identity;
- current control authority;
- data owner;
- consumer files;
- forbidden ownership leaks;
- smallest safe patch surface.

If owner is unclear, HOLD.

## Patch engine

A valid patch must state:
- exact scope;
- files changed;
- behavior intentionally changed or not changed;
- evidence ceiling;
- acceptance tests;
- falsifiers;
- rollback/next-run seed.

Patch the smallest owner. Do not repair one failure by creating a new hidden owner.

## Bug-sniffer lenses

Always scan for source-of-truth drift, stale data, missingness lies, file I/O mutation, long-path/package risk, duplicate owners, silent failures, compile-risk signatures, runtime permission leaks, review-to-trade drift, broker/session assumptions, repainting, and fake proof.

## Static validation

Use static validation appropriate to scope: grep contracts, file existence, forbidden-token scan, changed-file diff, package contents, and compile-risk sniffing. Static checks do not prove live behavior.

## Self-audit

Before final output, attack the weakest load-bearing premise. If the premise is unsupported, classify it as UNPROVEN and seed the cheapest falsifying test.

## Report/package law

Reports must separate facts, assumptions, unknowns, risks, falsifiers, unproven claims, and final decision. Packages must be changed-files-only unless explicitly scoped otherwise. Preserve original paths under `Aurora Sentinel Core/`.

## Decision law

Use exactly one final decision when the run requires it:
- TEST FIRST: bounded work completed, proof still required.
- HOLD: source truth, authority, or safety is unresolved.
- KILL: premise is false or scope violation occurred.

PROCEED is allowed only when the run prompt explicitly permits it and evidence supports it.
