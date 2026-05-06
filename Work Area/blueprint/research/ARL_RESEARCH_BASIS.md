---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Research Basis

This file records the research converted into blueprint constraints.

## MT5 Timer Constraint

MQL5 programs have their own event queues and timer events do not stack if a timer event is already queued or being processed. ARL therefore requires a small heartbeat and scheduler, not a giant dispatcher.

## MT5 File Constraint

MQL5 file operations are sandboxed. Public outputs must use temp/write/readback/promote, and FileFlush must be used carefully because frequent flushing can affect program speed.

## MT5 Indicator Constraint

CopyBuffer can return -1 while data is being built or downloaded. Indicator modules must expose READY / BUILDING / PARTIAL / FAILED and must not fake zero values.

## Market Watch Constraint

SymbolsTotal(true) returns selected Market Watch symbols. ARL uses controlled Market Watch universe first, not all broker symbols by default.

## Account Constraint

MQL5 exposes account values through AccountInfoDouble/Integer/String. ARL account exposure is mandatory from the beginning.

## Retry Constraint Beyond MT5

Backoff with jitter reduces retry storms. ARL retries unknown/transient states with bounded backoff and jitter; confirmed open/closed states do not retry.
