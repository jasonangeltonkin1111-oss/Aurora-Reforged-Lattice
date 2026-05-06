#ifndef __ASC_PORTFOLIO_EXPOSURE_SNAPSHOT_MQH__
#define __ASC_PORTFOLIO_EXPOSURE_SNAPSHOT_MQH__

#define ASC_PORTFOLIO_RECENT_CLOSED_TRADE_DEFAULT_LIMIT 20

struct ASC_PortfolioPositionDetail
  {
   ulong ticket;
   string symbol;
   string type_text;
   double volume;
   double entry_price;
   double stop_loss;
   double take_profit;
   double current_price;
   double current_bid;
   double current_ask;
   double profit;
   datetime open_time;
   long magic;
   string comment;
   double risk_estimate;
   bool tick_available;
   bool risk_available;
  };

struct ASC_PortfolioOrderDetail
  {
   ulong ticket;
   string symbol;
   string type_text;
   double volume;
   double order_price;
   double stop_loss;
   double take_profit;
   double current_price;
   double current_bid;
   double current_ask;
   datetime setup_time;
   datetime expiration_time;
   long magic;
   string comment;
   bool tick_available;
  };

struct ASC_PortfolioClosedTradeDetail
  {
   ulong deal_ticket;
   ulong order_ticket;
   ulong entry_order_ticket;
   long position_id;
   string symbol;
   string deal_type_text;
   string entry_text;
   double volume;
   datetime entry_time;
   double entry_price;
   datetime close_time;
   double close_price;
   double stop_loss;
   double take_profit;
   double profit;
   double commission;
   double swap;
   double net_result;
   long magic;
   string comment;
   long close_reason;
   string history_status;
   string source_quality;
   string entry_reconstruction_status;
   string paired_entry_status;
   string stop_loss_source;
   string take_profit_source;
  };

struct ASC_PortfolioExposureSnapshot
  {
   datetime built_utc;
   int open_trade_count;
   int pending_order_count;
   int recent_closed_trade_count;
   int recent_closed_trade_limit;
   string history_snapshot_status;
   string history_truth_source;
   string history_window;
   string history_quality;
   string history_note;
   double account_balance;
   double account_equity;
   double account_margin;
   double account_free_margin;
   double account_margin_level;
   double open_risk_estimate;
   bool open_risk_available;
   bool open_risk_partial;
   string snapshot_status;
   string truth_source;
   string note;
   ASC_PortfolioPositionDetail positions[];
   ASC_PortfolioOrderDetail orders[];
   ASC_PortfolioClosedTradeDetail recent_closed_trades[];
  };

string ASC_PortfolioPositionTypeText(const ENUM_POSITION_TYPE position_type)
  {
   if(position_type == POSITION_TYPE_BUY)
      return "buy";
   if(position_type == POSITION_TYPE_SELL)
      return "sell";
   return "unknown";
  }

string ASC_PortfolioOrderTypeText(const ENUM_ORDER_TYPE order_type)
  {
   if(order_type == ORDER_TYPE_BUY)
      return "buy";
   if(order_type == ORDER_TYPE_SELL)
      return "sell";
   if(order_type == ORDER_TYPE_BUY_LIMIT)
      return "buy_limit";
   if(order_type == ORDER_TYPE_SELL_LIMIT)
      return "sell_limit";
   if(order_type == ORDER_TYPE_BUY_STOP)
      return "buy_stop";
   if(order_type == ORDER_TYPE_SELL_STOP)
      return "sell_stop";
   if(order_type == ORDER_TYPE_BUY_STOP_LIMIT)
      return "buy_stop_limit";
   if(order_type == ORDER_TYPE_SELL_STOP_LIMIT)
      return "sell_stop_limit";
   if(order_type == ORDER_TYPE_CLOSE_BY)
      return "close_by";
   return EnumToString(order_type);
  }

string ASC_PortfolioDealTypeText(const ENUM_DEAL_TYPE deal_type)
  {
   if(deal_type == DEAL_TYPE_BUY)
      return "buy";
   if(deal_type == DEAL_TYPE_SELL)
      return "sell";
   return EnumToString(deal_type);
  }

string ASC_PortfolioDealEntryText(const ENUM_DEAL_ENTRY entry_type)
  {
   if(entry_type == DEAL_ENTRY_IN)
      return "in";
   if(entry_type == DEAL_ENTRY_OUT)
      return "out";
   if(entry_type == DEAL_ENTRY_INOUT)
      return "inout";
   if(entry_type == DEAL_ENTRY_OUT_BY)
      return "out_by";
   return EnumToString(entry_type);
  }

bool ASC_PortfolioDealEntryIsClosedTrade(const ENUM_DEAL_ENTRY entry_type)
  {
   return (entry_type == DEAL_ENTRY_OUT || entry_type == DEAL_ENTRY_OUT_BY || entry_type == DEAL_ENTRY_INOUT);
  }

string ASC_PortfolioTimeText(const datetime value)
  {
   if(value <= 0)
      return "unavailable";
   return TimeToString(value, TIME_DATE | TIME_SECONDS);
  }

string ASC_PortfolioDoubleText(const double value,const int digits)
  {
   if(value <= 0.0)
      return "unavailable";
   return DoubleToString(value, digits);
  }

bool ASC_PortfolioEstimateRisk(const string symbol,
                               const double volume,
                               const double entry_price,
                               const double stop_loss,
                               double &risk_out)
  {
   risk_out = 0.0;
   if(StringLen(symbol) <= 0 || volume <= 0.0 || entry_price <= 0.0 || stop_loss <= 0.0)
      return false;

   double tick_size = 0.0;
   double tick_value = 0.0;
   if(!SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE, tick_size))
      return false;
   if(!SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE, tick_value))
      return false;
   if(tick_size <= 0.0 || tick_value <= 0.0)
      return false;

   risk_out = (MathAbs(entry_price - stop_loss) / tick_size) * tick_value * volume;
   return (risk_out > 0.0);
  }

void ASC_PortfolioResetSnapshot(ASC_PortfolioExposureSnapshot &snapshot)
  {
   snapshot.built_utc = TimeGMT();
   snapshot.open_trade_count = 0;
   snapshot.pending_order_count = 0;
   snapshot.recent_closed_trade_count = 0;
   snapshot.recent_closed_trade_limit = ASC_PORTFOLIO_RECENT_CLOSED_TRADE_DEFAULT_LIMIT;
   snapshot.history_snapshot_status = "not_requested";
   snapshot.history_truth_source = "unknown";
   snapshot.history_window = "latest_20";
   snapshot.history_quality = "unknown";
   snapshot.history_note = "recent closed trade history not built yet";
   snapshot.account_balance = 0.0;
   snapshot.account_equity = 0.0;
   snapshot.account_margin = 0.0;
   snapshot.account_free_margin = 0.0;
   snapshot.account_margin_level = 0.0;
   snapshot.open_risk_estimate = 0.0;
   snapshot.open_risk_available = true;
   snapshot.open_risk_partial = false;
   snapshot.snapshot_status = "available";
   snapshot.truth_source = "broker_positions_orders_history";
   snapshot.note = "portfolio snapshot built from broker positions, active pending orders, and recent closed trade history context";
   ArrayResize(snapshot.positions, 0);
   ArrayResize(snapshot.orders, 0);
   ArrayResize(snapshot.recent_closed_trades, 0);
  }


bool ASC_PortfolioExtractBracketPriceFromComment(const string comment,const string marker,double &price_out)
  {
   price_out = 0.0;
   if(StringLen(comment) <= 0 || StringLen(marker) <= 0)
      return false;

   string token = "[" + marker + " ";
   int start = StringFind(comment, token);
   if(start < 0)
      return false;
   start += StringLen(token);
   int end = StringFind(comment, "]", start);
   if(end <= start)
      return false;

   string raw = StringSubstr(comment, start, end - start);
   StringTrimLeft(raw);
   StringTrimRight(raw);
   double parsed = StringToDouble(raw);
   if(parsed <= 0.0)
      return false;

   price_out = parsed;
   return true;
  }

bool ASC_PortfolioFindHistoryOrderForPosition(const long position_id,
                                               ulong &entry_order_ticket,
                                               double &entry_price,
                                               double &stop_loss,
                                               double &take_profit)
  {
   entry_order_ticket = 0;
   entry_price = 0.0;
   stop_loss = 0.0;
   take_profit = 0.0;
   if(position_id <= 0)
      return false;

   bool found = false;
   datetime earliest_entry_time = 0;
   datetime latest_stop_time = 0;
   datetime latest_take_time = 0;
   int total_orders = HistoryOrdersTotal();
   for(int i = 0; i < total_orders; i++)
     {
      ulong order_ticket = HistoryOrderGetTicket(i);
      if(order_ticket == 0)
         continue;

      long order_position_id = HistoryOrderGetInteger(order_ticket, ORDER_POSITION_ID);
      if(order_position_id != position_id)
         continue;

      found = true;
      datetime order_time = (datetime)HistoryOrderGetInteger(order_ticket, ORDER_TIME_DONE);
      if(order_time <= 0)
         order_time = (datetime)HistoryOrderGetInteger(order_ticket, ORDER_TIME_SETUP);

      double order_price = HistoryOrderGetDouble(order_ticket, ORDER_PRICE_OPEN);
      if(order_price > 0.0 && (entry_order_ticket == 0 || earliest_entry_time <= 0 || (order_time > 0 && order_time < earliest_entry_time)))
        {
         entry_order_ticket = order_ticket;
         entry_price = order_price;
         earliest_entry_time = order_time;
        }

      double order_sl = HistoryOrderGetDouble(order_ticket, ORDER_SL);
      if(order_sl > 0.0 && (latest_stop_time <= 0 || order_time >= latest_stop_time))
        {
         stop_loss = order_sl;
         latest_stop_time = order_time;
        }

      double order_tp = HistoryOrderGetDouble(order_ticket, ORDER_TP);
      if(order_tp > 0.0 && (latest_take_time <= 0 || order_time >= latest_take_time))
        {
         take_profit = order_tp;
         latest_take_time = order_time;
        }
     }

   return found;
  }

bool ASC_PortfolioFindEntryDealForPosition(const long position_id,
                                           const int close_index,
                                           datetime &entry_time,
                                           double &entry_price)
  {
   entry_time = 0;
   entry_price = 0.0;
   if(position_id <= 0)
      return false;

   for(int j = close_index - 1; j >= 0; j--)
     {
      ulong candidate_ticket = HistoryDealGetTicket(j);
      if(candidate_ticket == 0)
         continue;
      if(HistoryDealGetInteger(candidate_ticket, DEAL_POSITION_ID) != position_id)
         continue;
      ENUM_DEAL_ENTRY candidate_entry = (ENUM_DEAL_ENTRY)HistoryDealGetInteger(candidate_ticket, DEAL_ENTRY);
      if(candidate_entry != DEAL_ENTRY_IN)
         continue;
      entry_time = (datetime)HistoryDealGetInteger(candidate_ticket, DEAL_TIME);
      entry_price = HistoryDealGetDouble(candidate_ticket, DEAL_PRICE);
      return (entry_time > 0 || entry_price > 0.0);
     }
   return false;
  }

void ASC_PortfolioBuildRecentClosedTradeHistory(ASC_PortfolioExposureSnapshot &snapshot,const int max_closed_trades)
  {
   ArrayResize(snapshot.recent_closed_trades, 0);
   snapshot.recent_closed_trade_count = 0;
   snapshot.recent_closed_trade_limit = (max_closed_trades > 0 ? max_closed_trades : ASC_PORTFOLIO_RECENT_CLOSED_TRADE_DEFAULT_LIMIT);
   snapshot.history_window = "latest_20";
   snapshot.history_truth_source = "broker_history";
   snapshot.history_snapshot_status = "available";
   snapshot.history_quality = "complete";
   snapshot.history_note = "latest closed trades selected from broker history exit deals; closed history is context only, not active exposure";

   datetime to_time = TimeCurrent();
   if(to_time <= 0)
      to_time = TimeGMT();
   if(to_time <= 0)
     {
      snapshot.history_snapshot_status = "unavailable";
      snapshot.history_quality = "unavailable";
      snapshot.history_note = "history unavailable because current time could not be resolved";
      return;
     }

   if(!HistorySelect(0, to_time))
     {
      snapshot.history_snapshot_status = "unavailable";
      snapshot.history_quality = "unavailable";
      snapshot.history_note = "HistorySelect failed; recent closed trades must not be interpreted as zero";
      return;
     }

   int total_deals = HistoryDealsTotal();
   bool any_partial = false;
   for(int i = total_deals - 1; i >= 0 && snapshot.recent_closed_trade_count < snapshot.recent_closed_trade_limit; i--)
     {
      ulong deal_ticket = HistoryDealGetTicket(i);
      if(deal_ticket == 0)
         continue;

      ENUM_DEAL_ENTRY entry_type = (ENUM_DEAL_ENTRY)HistoryDealGetInteger(deal_ticket, DEAL_ENTRY);
      if(!ASC_PortfolioDealEntryIsClosedTrade(entry_type))
         continue;

      string symbol = HistoryDealGetString(deal_ticket, DEAL_SYMBOL);
      if(StringLen(symbol) <= 0)
         continue;

      int next = ArraySize(snapshot.recent_closed_trades);
      ArrayResize(snapshot.recent_closed_trades, next + 1);

      snapshot.recent_closed_trades[next].deal_ticket = deal_ticket;
      snapshot.recent_closed_trades[next].order_ticket = (ulong)HistoryDealGetInteger(deal_ticket, DEAL_ORDER);
      snapshot.recent_closed_trades[next].entry_order_ticket = 0;
      snapshot.recent_closed_trades[next].position_id = HistoryDealGetInteger(deal_ticket, DEAL_POSITION_ID);
      snapshot.recent_closed_trades[next].symbol = symbol;
      snapshot.recent_closed_trades[next].deal_type_text = ASC_PortfolioDealTypeText((ENUM_DEAL_TYPE)HistoryDealGetInteger(deal_ticket, DEAL_TYPE));
      snapshot.recent_closed_trades[next].entry_text = ASC_PortfolioDealEntryText(entry_type);
      snapshot.recent_closed_trades[next].volume = HistoryDealGetDouble(deal_ticket, DEAL_VOLUME);
      snapshot.recent_closed_trades[next].close_time = (datetime)HistoryDealGetInteger(deal_ticket, DEAL_TIME);
      snapshot.recent_closed_trades[next].close_price = HistoryDealGetDouble(deal_ticket, DEAL_PRICE);
      snapshot.recent_closed_trades[next].profit = HistoryDealGetDouble(deal_ticket, DEAL_PROFIT);
      snapshot.recent_closed_trades[next].commission = HistoryDealGetDouble(deal_ticket, DEAL_COMMISSION);
      snapshot.recent_closed_trades[next].swap = HistoryDealGetDouble(deal_ticket, DEAL_SWAP);
      snapshot.recent_closed_trades[next].net_result = snapshot.recent_closed_trades[next].profit + snapshot.recent_closed_trades[next].commission + snapshot.recent_closed_trades[next].swap;
      snapshot.recent_closed_trades[next].magic = HistoryDealGetInteger(deal_ticket, DEAL_MAGIC);
      snapshot.recent_closed_trades[next].comment = HistoryDealGetString(deal_ticket, DEAL_COMMENT);
      snapshot.recent_closed_trades[next].close_reason = HistoryDealGetInteger(deal_ticket, DEAL_REASON);
      snapshot.recent_closed_trades[next].history_status = "closed_history_context_only";
      snapshot.recent_closed_trades[next].source_quality = "partial";
      snapshot.recent_closed_trades[next].entry_reconstruction_status = "unavailable";
      snapshot.recent_closed_trades[next].paired_entry_status = "paired_entry_unavailable";
      snapshot.recent_closed_trades[next].entry_time = 0;
      snapshot.recent_closed_trades[next].entry_price = 0.0;
      snapshot.recent_closed_trades[next].stop_loss = 0.0;
      snapshot.recent_closed_trades[next].take_profit = 0.0;
      snapshot.recent_closed_trades[next].stop_loss_source = "unavailable";
      snapshot.recent_closed_trades[next].take_profit_source = "unavailable";

      datetime reconstructed_entry_time = 0;
      double reconstructed_entry_price = 0.0;
      if(ASC_PortfolioFindEntryDealForPosition(snapshot.recent_closed_trades[next].position_id,
                                               i,
                                               reconstructed_entry_time,
                                               reconstructed_entry_price))
        {
         snapshot.recent_closed_trades[next].entry_time = reconstructed_entry_time;
         snapshot.recent_closed_trades[next].entry_price = reconstructed_entry_price;
         snapshot.recent_closed_trades[next].entry_reconstruction_status = "complete";
         snapshot.recent_closed_trades[next].paired_entry_status = "paired_entry_found";
         snapshot.recent_closed_trades[next].source_quality = "complete";
        }
      else
        {
         snapshot.recent_closed_trades[next].source_quality = "partial";
         snapshot.recent_closed_trades[next].entry_reconstruction_status = "partial";
         snapshot.recent_closed_trades[next].paired_entry_status = "paired_entry_unavailable";
         any_partial = true;
        }

      ulong reconstructed_entry_order_ticket = 0;
      double reconstructed_order_entry_price = 0.0;
      double reconstructed_order_stop_loss = 0.0;
      double reconstructed_order_take_profit = 0.0;
      if(ASC_PortfolioFindHistoryOrderForPosition(snapshot.recent_closed_trades[next].position_id,
                                                  reconstructed_entry_order_ticket,
                                                  reconstructed_order_entry_price,
                                                  reconstructed_order_stop_loss,
                                                  reconstructed_order_take_profit))
        {
         snapshot.recent_closed_trades[next].entry_order_ticket = reconstructed_entry_order_ticket;
         if(snapshot.recent_closed_trades[next].entry_price <= 0.0 && reconstructed_order_entry_price > 0.0)
           {
            snapshot.recent_closed_trades[next].entry_price = reconstructed_order_entry_price;
            if(snapshot.recent_closed_trades[next].entry_reconstruction_status != "complete")
               snapshot.recent_closed_trades[next].entry_reconstruction_status = "partial";
           }
         if(reconstructed_order_stop_loss > 0.0)
           {
            snapshot.recent_closed_trades[next].stop_loss = reconstructed_order_stop_loss;
            snapshot.recent_closed_trades[next].stop_loss_source = "history_order_position_id";
           }
         if(reconstructed_order_take_profit > 0.0)
           {
            snapshot.recent_closed_trades[next].take_profit = reconstructed_order_take_profit;
            snapshot.recent_closed_trades[next].take_profit_source = "history_order_position_id";
           }
        }

      if(snapshot.recent_closed_trades[next].order_ticket > 0)
        {
         double close_order_sl = HistoryOrderGetDouble(snapshot.recent_closed_trades[next].order_ticket, ORDER_SL);
         double close_order_tp = HistoryOrderGetDouble(snapshot.recent_closed_trades[next].order_ticket, ORDER_TP);
         if(snapshot.recent_closed_trades[next].stop_loss <= 0.0 && close_order_sl > 0.0)
           {
            snapshot.recent_closed_trades[next].stop_loss = close_order_sl;
            snapshot.recent_closed_trades[next].stop_loss_source = "history_close_order";
           }
         if(snapshot.recent_closed_trades[next].take_profit <= 0.0 && close_order_tp > 0.0)
           {
            snapshot.recent_closed_trades[next].take_profit = close_order_tp;
            snapshot.recent_closed_trades[next].take_profit_source = "history_close_order";
           }
        }

      double comment_sl = 0.0;
      if(snapshot.recent_closed_trades[next].stop_loss <= 0.0
         && ASC_PortfolioExtractBracketPriceFromComment(snapshot.recent_closed_trades[next].comment, "sl", comment_sl))
        {
         snapshot.recent_closed_trades[next].stop_loss = comment_sl;
         snapshot.recent_closed_trades[next].stop_loss_source = "deal_comment_trigger";
        }

      double comment_tp = 0.0;
      if(snapshot.recent_closed_trades[next].take_profit <= 0.0
         && ASC_PortfolioExtractBracketPriceFromComment(snapshot.recent_closed_trades[next].comment, "tp", comment_tp))
        {
         snapshot.recent_closed_trades[next].take_profit = comment_tp;
         snapshot.recent_closed_trades[next].take_profit_source = "deal_comment_trigger";
        }

      if(snapshot.recent_closed_trades[next].entry_time <= 0 || snapshot.recent_closed_trades[next].entry_price <= 0.0)
        {
         if(snapshot.recent_closed_trades[next].entry_reconstruction_status == "complete")
            snapshot.recent_closed_trades[next].entry_reconstruction_status = "partial";
         snapshot.recent_closed_trades[next].paired_entry_status = "paired_entry_unavailable";
         snapshot.recent_closed_trades[next].source_quality = "partial";
         any_partial = true;
        }

      if(snapshot.recent_closed_trades[next].stop_loss <= 0.0 || snapshot.recent_closed_trades[next].take_profit <= 0.0)
        {
         snapshot.recent_closed_trades[next].source_quality = "partial";
         any_partial = true;
        }

      snapshot.recent_closed_trade_count = ArraySize(snapshot.recent_closed_trades);
     }

   if(snapshot.recent_closed_trade_count <= 0)
      snapshot.history_note = "history available; no recent closed trade exit deals detected in selected broker history";
   else if(any_partial)
     {
      snapshot.history_snapshot_status = "partial";
      snapshot.history_quality = "partial";
      snapshot.history_note = "recent closed trade history available with partial reconstructed entry fields; unavailable fields are labelled and not faked";
     }
  }

void ASC_PortfolioBuildExposureSnapshot(ASC_PortfolioExposureSnapshot &snapshot)
  {
   ASC_PortfolioResetSnapshot(snapshot);

   snapshot.account_balance = AccountInfoDouble(ACCOUNT_BALANCE);
   snapshot.account_equity = AccountInfoDouble(ACCOUNT_EQUITY);
   snapshot.account_margin = AccountInfoDouble(ACCOUNT_MARGIN);
   snapshot.account_free_margin = AccountInfoDouble(ACCOUNT_MARGIN_FREE);
   snapshot.account_margin_level = AccountInfoDouble(ACCOUNT_MARGIN_LEVEL);

   bool any_missing_risk = false;
   int position_total_observed = PositionsTotal();
   int order_total_observed = OrdersTotal();
   int skipped_position_read_count = 0;
   int skipped_order_read_count = 0;

   for(int i = 0; i < position_total_observed; i++)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
        {
         skipped_position_read_count++;
         continue;
        }

      int next = ArraySize(snapshot.positions);
      ArrayResize(snapshot.positions, next + 1);

      string symbol = PositionGetString(POSITION_SYMBOL);
      ENUM_POSITION_TYPE position_type = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
      snapshot.positions[next].ticket = ticket;
      snapshot.positions[next].symbol = symbol;
      snapshot.positions[next].type_text = ASC_PortfolioPositionTypeText(position_type);
      snapshot.positions[next].volume = PositionGetDouble(POSITION_VOLUME);
      snapshot.positions[next].entry_price = PositionGetDouble(POSITION_PRICE_OPEN);
      snapshot.positions[next].stop_loss = PositionGetDouble(POSITION_SL);
      snapshot.positions[next].take_profit = PositionGetDouble(POSITION_TP);
      snapshot.positions[next].current_price = PositionGetDouble(POSITION_PRICE_CURRENT);
      snapshot.positions[next].profit = PositionGetDouble(POSITION_PROFIT);
      snapshot.positions[next].open_time = (datetime)PositionGetInteger(POSITION_TIME);
      snapshot.positions[next].magic = PositionGetInteger(POSITION_MAGIC);
      snapshot.positions[next].comment = PositionGetString(POSITION_COMMENT);
      snapshot.positions[next].current_bid = 0.0;
      snapshot.positions[next].current_ask = 0.0;
      snapshot.positions[next].tick_available = false;
      snapshot.positions[next].risk_estimate = 0.0;
      snapshot.positions[next].risk_available = ASC_PortfolioEstimateRisk(symbol,
                                                                          snapshot.positions[next].volume,
                                                                          snapshot.positions[next].entry_price,
                                                                          snapshot.positions[next].stop_loss,
                                                                          snapshot.positions[next].risk_estimate);
      if(snapshot.positions[next].risk_available)
         snapshot.open_risk_estimate += snapshot.positions[next].risk_estimate;
      else
         any_missing_risk = true;

      MqlTick tick;
      if(SymbolInfoTick(symbol, tick))
        {
         snapshot.positions[next].tick_available = true;
         snapshot.positions[next].current_bid = tick.bid;
         snapshot.positions[next].current_ask = tick.ask;
        }
     }

   for(int i = 0; i < order_total_observed; i++)
     {
      ulong ticket = OrderGetTicket(i);
      if(ticket == 0)
        {
         skipped_order_read_count++;
         continue;
        }

      ENUM_ORDER_STATE state = (ENUM_ORDER_STATE)OrderGetInteger(ORDER_STATE);
      if(state != ORDER_STATE_PLACED && state != ORDER_STATE_PARTIAL)
         continue;

      int next = ArraySize(snapshot.orders);
      ArrayResize(snapshot.orders, next + 1);

      string symbol = OrderGetString(ORDER_SYMBOL);
      ENUM_ORDER_TYPE order_type = (ENUM_ORDER_TYPE)OrderGetInteger(ORDER_TYPE);
      snapshot.orders[next].ticket = ticket;
      snapshot.orders[next].symbol = symbol;
      snapshot.orders[next].type_text = ASC_PortfolioOrderTypeText(order_type);
      snapshot.orders[next].volume = OrderGetDouble(ORDER_VOLUME_CURRENT);
      snapshot.orders[next].order_price = OrderGetDouble(ORDER_PRICE_OPEN);
      snapshot.orders[next].stop_loss = OrderGetDouble(ORDER_SL);
      snapshot.orders[next].take_profit = OrderGetDouble(ORDER_TP);
      snapshot.orders[next].current_price = OrderGetDouble(ORDER_PRICE_CURRENT);
      snapshot.orders[next].setup_time = (datetime)OrderGetInteger(ORDER_TIME_SETUP);
      snapshot.orders[next].expiration_time = (datetime)OrderGetInteger(ORDER_TIME_EXPIRATION);
      snapshot.orders[next].magic = OrderGetInteger(ORDER_MAGIC);
      snapshot.orders[next].comment = OrderGetString(ORDER_COMMENT);
      snapshot.orders[next].current_bid = 0.0;
      snapshot.orders[next].current_ask = 0.0;
      snapshot.orders[next].tick_available = false;

      MqlTick tick;
      if(SymbolInfoTick(symbol, tick))
        {
         snapshot.orders[next].tick_available = true;
         snapshot.orders[next].current_bid = tick.bid;
         snapshot.orders[next].current_ask = tick.ask;
        }
     }

   ASC_PortfolioBuildRecentClosedTradeHistory(snapshot, ASC_PORTFOLIO_RECENT_CLOSED_TRADE_DEFAULT_LIMIT);

   snapshot.open_trade_count = ArraySize(snapshot.positions);
   snapshot.pending_order_count = ArraySize(snapshot.orders);
   bool portfolio_read_partial = (skipped_position_read_count > 0 || skipped_order_read_count > 0);
   if(portfolio_read_partial)
     {
      snapshot.snapshot_status = "partial";
      snapshot.note = StringFormat("portfolio snapshot partial: skipped_position_reads=%d skipped_order_reads=%d; base Market Board publication remains fail-soft",
                                   skipped_position_read_count,
                                   skipped_order_read_count);
     }
   snapshot.open_risk_available = (snapshot.open_trade_count == 0 || !any_missing_risk);
   snapshot.open_risk_partial = (snapshot.open_trade_count > 0 && any_missing_risk && snapshot.open_risk_estimate > 0.0);
   if(snapshot.open_trade_count > 0 && any_missing_risk && snapshot.open_risk_estimate <= 0.0)
      snapshot.open_risk_available = false;
   if(!portfolio_read_partial)
     {
      if(snapshot.open_trade_count <= 0 && snapshot.pending_order_count <= 0)
         snapshot.note = "no open or pending portfolio exposure detected; recent closed trades remain history/context only";
      else if(snapshot.open_trade_count > 0 && snapshot.pending_order_count > 0)
         snapshot.note = "open-trade and pending-order exposure detected; recent closed trades remain history/context only";
      else if(snapshot.open_trade_count > 0)
         snapshot.note = "open-trade exposure detected; recent closed trades remain history/context only";
      else
         snapshot.note = "pending-order exposure detected; recent closed trades remain history/context only";
     }
  }

string ASC_PortfolioSnapshotRefreshStatusToken(const ASC_PortfolioExposureSnapshot &snapshot)
  {
   if(snapshot.built_utc <= 0)
      return "runtime_unproven";
   return "build_scoped";
  }

string ASC_PortfolioSnapshotAgeToken(const ASC_PortfolioExposureSnapshot &snapshot)
  {
   if(snapshot.built_utc <= 0)
      return "unknown";
   datetime now_utc = TimeGMT();
   if(now_utc <= 0 || snapshot.built_utc > now_utc)
      return "unknown";
   if((now_utc - snapshot.built_utc) <= 5)
      return "fresh";
   return "stale";
  }

string ASC_PortfolioAggregateProofTokens(const ASC_PortfolioExposureSnapshot &snapshot,
                                         const int same_symbol_conflict_count,
                                         const int correlated_exposure_conflict_count,
                                         const int correlation_unavailable_conflict_count,
                                         const int portfolio_admission_blocked_count,
                                         const int portfolio_admission_reserved_count,
                                         const int portfolio_admission_qualified_count)
  {
   string status = snapshot.snapshot_status;
   if(StringLen(status) <= 0)
      status = "unavailable";
   string source = snapshot.truth_source;
   if(StringLen(source) <= 0)
      source = "unknown";
   string history_status = snapshot.history_snapshot_status;
   if(StringLen(history_status) <= 0)
      history_status = "unavailable";
   string history_source = snapshot.history_truth_source;
   if(StringLen(history_source) <= 0)
      history_source = "unknown";
   string history_window = snapshot.history_window;
   if(StringLen(history_window) <= 0)
      history_window = "unavailable";
   string history_quality = snapshot.history_quality;
   if(StringLen(history_quality) <= 0)
      history_quality = "unknown";

   return StringFormat("portfolio_snapshot_status=%s | portfolio_truth_source=%s | open_trade_count=%d | pending_order_count=%d | recent_closed_trade_count=%d | recent_closed_trade_limit=%d | history_snapshot_status=%s | history_truth_source=%s | history_window=%s | history_quality=%s | same_symbol_conflict_count=%d | correlated_exposure_conflict_count=%d | correlation_unavailable_conflict_count=%d | portfolio_admission_blocked_count=%d | portfolio_admission_reserved_count=%d | portfolio_admission_qualified_count=%d | proof_scope=aggregate | trade_permission=false | entry_signal=false | behavior_change=portfolio_history_context_only | runtime_observed=%s | source_supported=true | portfolio_refresh_status=%s | portfolio_snapshot_age=%s | portfolio_cost_scope=aggregate",
                       status,
                       source,
                       snapshot.open_trade_count,
                       snapshot.pending_order_count,
                       snapshot.recent_closed_trade_count,
                       snapshot.recent_closed_trade_limit,
                       history_status,
                       history_source,
                       history_window,
                       history_quality,
                       same_symbol_conflict_count,
                       correlated_exposure_conflict_count,
                       correlation_unavailable_conflict_count,
                       portfolio_admission_blocked_count,
                       portfolio_admission_reserved_count,
                       portfolio_admission_qualified_count,
                       snapshot.built_utc > 0 ? "true" : "false",
                       ASC_PortfolioSnapshotRefreshStatusToken(snapshot),
                       ASC_PortfolioSnapshotAgeToken(snapshot));
  }

bool ASC_PortfolioSnapshotHasOpenTradeForSymbol(const ASC_PortfolioExposureSnapshot &snapshot,const string symbol)
  {
   for(int i = 0; i < ArraySize(snapshot.positions); i++)
     {
      if(snapshot.positions[i].symbol == symbol)
         return true;
     }
   return false;
  }

bool ASC_PortfolioSnapshotHasPendingOrderForSymbol(const ASC_PortfolioExposureSnapshot &snapshot,const string symbol)
  {
   for(int i = 0; i < ArraySize(snapshot.orders); i++)
     {
      if(snapshot.orders[i].symbol == symbol)
         return true;
     }
   return false;
  }

void ASC_PortfolioConflictCountsForSymbol(const ASC_PortfolioExposureSnapshot &snapshot,
                                          const string symbol,
                                          int &open_positions,
                                          int &pending_orders)
  {
   open_positions = 0;
   pending_orders = 0;
   for(int i = 0; i < ArraySize(snapshot.positions); i++)
     {
      if(snapshot.positions[i].symbol == symbol)
         open_positions++;
     }
   for(int i = 0; i < ArraySize(snapshot.orders); i++)
     {
      if(snapshot.orders[i].symbol == symbol)
         pending_orders++;
     }
  }

void ASC_PortfolioAppendUniqueExposureSymbol(const string symbol,string &symbols[])
  {
   if(StringLen(symbol) <= 0)
      return;
   for(int i = 0; i < ArraySize(symbols); i++)
     {
      if(symbols[i] == symbol)
         return;
     }
   int next = ArraySize(symbols);
   ArrayResize(symbols, next + 1);
   symbols[next] = symbol;
  }

void ASC_PortfolioExposureSymbols(const ASC_PortfolioExposureSnapshot &snapshot,string &symbols[])
  {
   ArrayResize(symbols, 0);
   for(int i = 0; i < ArraySize(snapshot.positions); i++)
      ASC_PortfolioAppendUniqueExposureSymbol(snapshot.positions[i].symbol, symbols);
   for(int i = 0; i < ArraySize(snapshot.orders); i++)
      ASC_PortfolioAppendUniqueExposureSymbol(snapshot.orders[i].symbol, symbols);
  }

string ASC_PortfolioSymbolExposureSummaryText(const ASC_PortfolioExposureSnapshot &snapshot,const string symbol)
  {
   int open_positions = 0;
   int pending_orders = 0;
   ASC_PortfolioConflictCountsForSymbol(snapshot, symbol, open_positions, pending_orders);
   if(open_positions > 0 && pending_orders > 0)
      return StringFormat("portfolio_action=block | exposure_reason=same_symbol_open_and_pending | open_trade_count=%d | pending_order_count=%d | recent_closed_history_action=context_only", open_positions, pending_orders);
   if(open_positions > 0)
      return StringFormat("portfolio_action=block | exposure_reason=same_symbol_open | open_trade_count=%d | pending_order_count=0 | recent_closed_history_action=context_only", open_positions);
   if(pending_orders > 0)
      return StringFormat("portfolio_action=block | exposure_reason=same_symbol_pending | open_trade_count=0 | pending_order_count=%d | recent_closed_history_action=context_only", pending_orders);
   if(snapshot.open_trade_count + snapshot.pending_order_count > 0)
      return "portfolio_action=qualified | exposure_reason=no_same_symbol_exposure_but_account_has_portfolio_exposure | recent_closed_history_action=context_only";
   return "portfolio_action=allow | exposure_reason=active_exposure_clear | recent_closed_history_action=context_only";
  }

string ASC_PortfolioPositionDetailLine(const ASC_PortfolioPositionDetail &position)
  {
   return StringFormat("trade_ticket=%I64u | trade_symbol=%s | trade_type=%s | trade_volume=%.2f | trade_entry=%.5f | trade_sl=%s | trade_tp=%s | trade_current_price=%.5f | trade_bid=%s | trade_ask=%s | trade_profit=%.2f | trade_open_time=%s | trade_magic=%I64d | trade_comment=%s | risk_estimate=%s | status=active_exposure | exposure_status=active_exposure",
                       position.ticket,
                       position.symbol,
                       position.type_text,
                       position.volume,
                       position.entry_price,
                       ASC_PortfolioDoubleText(position.stop_loss, 5),
                       ASC_PortfolioDoubleText(position.take_profit, 5),
                       position.current_price,
                       position.tick_available ? DoubleToString(position.current_bid, 5) : "unavailable",
                       position.tick_available ? DoubleToString(position.current_ask, 5) : "unavailable",
                       position.profit,
                       ASC_PortfolioTimeText(position.open_time),
                       position.magic,
                       StringLen(position.comment) > 0 ? position.comment : "none",
                       position.risk_available ? DoubleToString(position.risk_estimate, 2) : "unavailable");
  }

string ASC_PortfolioOrderDetailLine(const ASC_PortfolioOrderDetail &order)
  {
   return StringFormat("order_ticket=%I64u | order_symbol=%s | order_type=%s | order_volume=%.2f | order_price=%.5f | order_sl=%s | order_tp=%s | order_current_price=%.5f | order_bid=%s | order_ask=%s | order_setup_time=%s | order_expiration=%s | order_magic=%I64d | order_comment=%s | status=future_exposure | exposure_status=future_exposure",
                       order.ticket,
                       order.symbol,
                       order.type_text,
                       order.volume,
                       order.order_price,
                       ASC_PortfolioDoubleText(order.stop_loss, 5),
                       ASC_PortfolioDoubleText(order.take_profit, 5),
                       order.current_price,
                       order.tick_available ? DoubleToString(order.current_bid, 5) : "unavailable",
                       order.tick_available ? DoubleToString(order.current_ask, 5) : "unavailable",
                       ASC_PortfolioTimeText(order.setup_time),
                       ASC_PortfolioTimeText(order.expiration_time),
                       order.magic,
                       StringLen(order.comment) > 0 ? order.comment : "none");
  }

string ASC_PortfolioClosedTradeDetailLine(const ASC_PortfolioClosedTradeDetail &trade)
  {
   return StringFormat("closed_deal_ticket=%I64u | closed_order_ticket=%I64u | entry_order_ticket=%I64u | closed_symbol=%s | closed_type=%s | closed_entry=%s | closed_volume=%.2f | entry_time=%s | entry_price=%s | close_time=%s | close_price=%.5f | closed_sl=%s | closed_sl_source=%s | closed_tp=%s | closed_tp_source=%s | closed_profit=%.2f | closed_commission=%.2f | closed_swap=%.2f | closed_net=%.2f | closed_magic=%I64d | closed_comment=%s | close_reason=%I64d | history_status=%s | source_quality=%s | entry_reconstruction_status=%s | paired_entry_status=%s | status=closed_history_context_only | active_exposure=false | candidate_blocker=false | exposure_status=closed_history_context_only",
                       trade.deal_ticket,
                       trade.order_ticket,
                       trade.entry_order_ticket,
                       trade.symbol,
                       trade.deal_type_text,
                       trade.entry_text,
                       trade.volume,
                       ASC_PortfolioTimeText(trade.entry_time),
                       ASC_PortfolioDoubleText(trade.entry_price, 5),
                       ASC_PortfolioTimeText(trade.close_time),
                       trade.close_price,
                       ASC_PortfolioDoubleText(trade.stop_loss, 5),
                       StringLen(trade.stop_loss_source) > 0 ? trade.stop_loss_source : "unavailable",
                       ASC_PortfolioDoubleText(trade.take_profit, 5),
                       StringLen(trade.take_profit_source) > 0 ? trade.take_profit_source : "unavailable",
                       trade.profit,
                       trade.commission,
                       trade.swap,
                       trade.net_result,
                       trade.magic,
                       StringLen(trade.comment) > 0 ? trade.comment : "none",
                       trade.close_reason,
                       trade.history_status,
                       trade.source_quality,
                       trade.entry_reconstruction_status,
                       trade.paired_entry_status);
  }

string ASC_PortfolioSectionStatusToken(const ASC_PortfolioExposureSnapshot &snapshot)
  {
   if(StringLen(snapshot.snapshot_status) <= 0)
      return "unavailable";
   if(snapshot.snapshot_status == "available" || snapshot.snapshot_status == "partial" || snapshot.snapshot_status == "unavailable")
      return snapshot.snapshot_status;
   return "partial";
  }

string ASC_PortfolioHistorySectionStatusToken(const ASC_PortfolioExposureSnapshot &snapshot)
  {
   if(snapshot.history_snapshot_status == "available" || snapshot.history_snapshot_status == "partial" || snapshot.history_snapshot_status == "unavailable" || snapshot.history_snapshot_status == "not_requested")
      return snapshot.history_snapshot_status;
   if(StringLen(snapshot.history_snapshot_status) <= 0)
      return "unavailable";
   return "partial";
  }

string ASC_PortfolioExposureDetailsText(const ASC_PortfolioExposureSnapshot &snapshot,const int max_rows)
  {
   string portfolio_section_status = ASC_PortfolioSectionStatusToken(snapshot);
   string history_section_status = ASC_PortfolioHistorySectionStatusToken(snapshot);
   string text = StringFormat("portfolio_snapshot_status=%s | portfolio_section_status=%s | open_trade_count=%d | pending_order_count=%d | recent_closed_trade_count=%d | recent_closed_trade_limit=%d | portfolio_truth_source=%s | history_snapshot_status=%s | history_section_status=%s | history_truth_source=%s | history_window=%s | history_quality=%s | built_utc=%s | proof_scope=aggregate | trade_permission=false | entry_signal=false | behavior_change=market_board_portfolio_detail_projection_hardening | note=%s | history_note=%s\n",
                              snapshot.snapshot_status,
                              portfolio_section_status,
                              snapshot.open_trade_count,
                              snapshot.pending_order_count,
                              snapshot.recent_closed_trade_count,
                              snapshot.recent_closed_trade_limit,
                              snapshot.truth_source,
                              snapshot.history_snapshot_status,
                              history_section_status,
                              snapshot.history_truth_source,
                              snapshot.history_window,
                              snapshot.history_quality,
                              ASC_PortfolioTimeText(snapshot.built_utc),
                              snapshot.note,
                              snapshot.history_note);
   text += StringFormat("account_balance=%.2f | account_equity=%.2f | account_margin=%.2f | account_free_margin=%.2f | account_margin_level=%.2f\n",
                        snapshot.account_balance,
                        snapshot.account_equity,
                        snapshot.account_margin,
                        snapshot.account_free_margin,
                        snapshot.account_margin_level);

   text += "\nOpen Positions\n";
   text += "open_positions_section_status=available | status_label=active_exposure | closed_history_context_only=false\n";
   if(ArraySize(snapshot.positions) <= 0)
      text += "open_trade_count=0 | open_positions_detail=none | section_failure=false\n";

   int emitted = 0;
   for(int i = 0; i < ArraySize(snapshot.positions) && emitted < max_rows; i++)
     {
      text += ASC_PortfolioPositionDetailLine(snapshot.positions[i]) + "\n";
      emitted++;
     }

   text += "\nPending Orders\n";
   text += "pending_orders_section_status=available | status_label=future_exposure | closed_history_context_only=false\n";
   if(ArraySize(snapshot.orders) <= 0)
      text += "pending_order_count=0 | pending_orders_detail=none | section_failure=false\n";

   for(int i = 0; i < ArraySize(snapshot.orders) && emitted < max_rows; i++)
     {
      text += ASC_PortfolioOrderDetailLine(snapshot.orders[i]) + "\n";
      emitted++;
     }
   int remaining = (snapshot.open_trade_count + snapshot.pending_order_count) - emitted;
   if(remaining > 0)
      text += StringFormat("portfolio_detail_overflow=%d | detail_policy=artifact_rows_capped\n", remaining);

   text += "\nRecent Closed Trades\n";
   text += "recent_closed_trades_section=CLOSED_HISTORY_CONTEXT | active_exposure=false | candidate_blocker=false | status_label=closed_history_context_only\n";
   if(snapshot.history_snapshot_status == "unavailable")
      text += "recent_closed_trade_history_unavailable=true | interpretation=not_zero_closed_trades | section_failure=false\n";
   else if(ArraySize(snapshot.recent_closed_trades) <= 0)
      text += "recent_closed_trade_count=0 | history_available=true | interpretation=zero_closed_trades_only_when_history_available\n";
   int history_emitted = 0;
   for(int i = 0; i < ArraySize(snapshot.recent_closed_trades) && history_emitted < snapshot.recent_closed_trade_limit; i++)
     {
      text += ASC_PortfolioClosedTradeDetailLine(snapshot.recent_closed_trades[i]) + "\n";
      history_emitted++;
     }
   int history_remaining = snapshot.recent_closed_trade_count - history_emitted;
   if(history_remaining > 0)
      text += StringFormat("recent_closed_trade_overflow=%d | detail_policy=latest_20_cap\n", history_remaining);
   return text;
  }

string ASC_PortfolioAggregateProofTokens(const ASC_PortfolioExposureSnapshot &snapshot,
                                         const string proof_context)
  {
   string context = proof_context;
   if(StringLen(context) <= 0)
      context = "market_board";
   return ASC_PortfolioAggregateProofTokens(snapshot, 0, 0, 0, 0, 0, 0)
          + " | portfolio_proof_context=" + context
          + " | portfolio_section_status=" + ASC_PortfolioSectionStatusToken(snapshot)
          + " | history_section_status=" + ASC_PortfolioHistorySectionStatusToken(snapshot)
          + " | artifact_failure_boundary=fail_soft"
          + " | behavior_change=market_board_portfolio_detail_projection_hardening";
  }

string ASC_PortfolioSelectedSymbolExposureDetailsText(const ASC_PortfolioExposureSnapshot &snapshot,const string symbol)
  {
   string text = ASC_PortfolioSymbolExposureSummaryText(snapshot, symbol) + "\n";
   bool any = false;
   for(int i = 0; i < ArraySize(snapshot.positions); i++)
     {
      if(snapshot.positions[i].symbol != symbol)
         continue;
      text += ASC_PortfolioPositionDetailLine(snapshot.positions[i]) + "\n";
      any = true;
     }
   for(int i = 0; i < ArraySize(snapshot.orders); i++)
     {
      if(snapshot.orders[i].symbol != symbol)
         continue;
      text += ASC_PortfolioOrderDetailLine(snapshot.orders[i]) + "\n";
      any = true;
     }
   bool history_any = false;
   for(int i = 0; i < ArraySize(snapshot.recent_closed_trades); i++)
     {
      if(snapshot.recent_closed_trades[i].symbol != symbol)
         continue;
      text += ASC_PortfolioClosedTradeDetailLine(snapshot.recent_closed_trades[i]) + "\n";
      history_any = true;
     }
   if(!any)
      text += "selected_symbol_active_portfolio_detail=none\n";
   if(!history_any)
      text += "selected_symbol_recent_closed_history=none | active_exposure=false | candidate_blocker=false\n";
   if(snapshot.history_snapshot_status == "unavailable")
      text += "selected_symbol_recent_closed_history_unavailable=true | interpretation=not_zero_closed_trades\n";
   return text;
  }

#endif
