# Phase 02 — Runtime, IO, Account

## Purpose

Build the nervous system and account truth first.

## Modules

```text
mt5/core/
mt5/runtime/
mt5/io/
mt5/telemetry/
mt5/account/
```

## Required outputs

```text
Status_Current.json
Account_Current.json
Manifest_Current.json
```

## Acceptance

- heartbeat works
- scheduler slices work
- atomic writer works
- account snapshot works
- exposure snapshot separates open positions, pending orders, and closed history
- trade permission false
