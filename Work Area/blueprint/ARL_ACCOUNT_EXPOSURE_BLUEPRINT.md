---
system: Aurora Reforged Lattice
pack: ARL_BLUEPRINT_PACK_RUN003
mode: BLUEPRINT
status: final-product-specification-only
created_utc: 2026-05-06
authority_note: Blueprint defines desired final product behavior. It does not prove source behavior, compile success, runtime success, edge, signal validity, execution safety, or prop-firm deployability.
---

# ARL Account Exposure Blueprint

Account and exposure context are mandatory.

## Account Snapshot

```text
account_login_masked
account_server
account_company
account_currency
account_leverage
account_balance
account_equity
account_profit
account_margin
account_free_margin
account_margin_level
account_trade_allowed
expert_trade_allowed
margin_mode
```

## Exposure Snapshot

Open positions and pending orders are separate.

```text
open_positions_count
pending_orders_count
closed_deals_lookback_days
closed_deals_count
floating_pnl_total
symbol_exposure_map
```

## Per-Symbol Exposure

```text
symbol
open_position_count_symbol
pending_order_count_symbol
floating_pnl_symbol
recent_closed_deals_symbol
recent_closed_pnl_symbol
exposure_code
exposure_label
exposure_reason
```

## Exposure Codes

```text
0 = NONE
10 = CLOSED_HISTORY_ONLY
20 = PENDING_ORDER_EXISTS
30 = OPEN_POSITION_EXISTS
40 = OPEN_AND_PENDING
50 = EXPOSURE_UNKNOWN
```

## Public Repo Safety

Sample files must mask account number/name.

Runtime local files may show account number if the operator allows it.

Never commit real account numbers into Git.

## ARL-RUN007 Account Exposure Output Law

Account exposure is mandatory trader data, not optional metadata.

Future output must separate:
- account-level equity/balance/margin/free-margin/drawdown context;
- open positions by symbol;
- pending orders by symbol;
- recent closed deals by symbol;
- exposure warning/review adjustment.

Do not infer closed trade history from positions. Closed deals require history selection and deal inspection.
