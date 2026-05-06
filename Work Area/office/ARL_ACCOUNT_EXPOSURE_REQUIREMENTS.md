# ARL Account and Exposure Requirements

## Purpose

Account state is mandatory in ARL.

Ranking without account exposure can push symbols that already carry risk.

## Account snapshot fields

Required local runtime fields:

```text
account_login
account_company
account_server
account_name
account_currency
account_leverage
account_balance
account_equity
account_profit
account_margin
account_free_margin
account_margin_level
account_trade_allowed
account_trade_expert
account_margin_mode
```

## Public repo safety

Samples committed to Git must mask:
- account_login
- account_name
- account_server if private
- terminal paths
- machine paths
- broker account identifiers
- trade ticket numbers if sensitive

## Exposure snapshot fields

```text
open_positions_count
pending_orders_count
closed_deals_lookback_days
closed_deals_count
closed_deals_profit
symbol_open_position_count
symbol_pending_order_count
symbol_closed_deals_count_lookback
symbol_recent_closed_pnl
symbol_exposure_load_score
symbol_exposure_state
```

## Separation law

Open positions, pending orders, and closed history are different.

Do not merge them into one "trades" count.

## Market Board impact

Board must show:
- account summary
- open/pending conflict per visible candidate
- upload suggestion adjustment based on exposure

## Dossier impact

Each dossier must show:
- account snapshot summary
- exposure for that symbol
- recent closed history for that symbol
- exposure warning
