#ifndef __ASC_SYMBOL_SPECIFICATION_MQH__
#define __ASC_SYMBOL_SPECIFICATION_MQH__

#include "../core/ASC_Types.mqh"

string ASC_SymbolSpecHumanizeEnum(const string raw_name)
  {
   string value = raw_name;
   if(StringLen(value) <= 0)
      return "unavailable";

   int prefix = StringFind(value, "::");
   if(prefix >= 0)
      value = StringSubstr(value, prefix + 2);

   int cut = StringFind(value, "SYMBOL_");
   if(cut >= 0)
      value = StringSubstr(value, cut + 7);
   if(StringFind(value, "SECTOR_") == 0)
      value = StringSubstr(value, 7);
   if(StringFind(value, "INDUSTRY_") == 0)
      value = StringSubstr(value, 9);

   string output = "";
   bool new_word = true;
   for(int i = 0; i < StringLen(value); i++)
     {
      string ch = StringSubstr(value, i, 1);
      if(ch == "_" || ch == "-")
        {
         output += " ";
         new_word = true;
         continue;
        }

      string lower = ch;
      StringToLower(lower);
      if(new_word)
        {
         string upper = lower;
         StringToUpper(upper);
         output += upper;
         new_word = false;
        }
      else
        {
         output += lower;
        }
     }

   StringReplace(output, "Cfd", "CFD");
   StringReplace(output, "Usd", "USD");
   StringReplace(output, "Eur", "EUR");
   StringReplace(output, "Gbp", "GBP");
   StringReplace(output, "Jpy", "JPY");
   return output;
  }

string ASC_SymbolSpecificationCalcModeText(const long calculation_mode)
  {
   return ASC_SymbolSpecHumanizeEnum(EnumToString((ENUM_SYMBOL_CALC_MODE)calculation_mode));
  }

string ASC_SymbolSpecificationSwapModeText(const long swap_mode)
  {
   return ASC_SymbolSpecHumanizeEnum(EnumToString((ENUM_SYMBOL_SWAP_MODE)swap_mode));
  }

void ASC_SymbolSpecificationReset(ASC_SymbolSpecification &spec,const string symbol)
  {
   spec.symbol = symbol;
   spec.last_refreshed_utc = 0;
   spec.trade_mode = 0;
   spec.execution_mode = 0;
   spec.calculation_mode = 0;
   spec.filling_mode = 0;
   spec.expiration_mode = 0;
   spec.order_mode = 0;
   spec.chart_mode = 0;
   spec.spread_float_mode = 0;
   spec.digits = 0;
   spec.point = 0.0;
   spec.tick_size = 0.0;
   spec.tick_value = 0.0;
   spec.contract_size = 0.0;
   spec.volume_min = 0.0;
   spec.volume_max = 0.0;
   spec.volume_step = 0.0;
   spec.stop_distance_points = 0;
   spec.freeze_distance_points = 0;
   spec.swap_mode = 0;
   spec.swap_long = 0.0;
   spec.swap_short = 0.0;
   spec.margin_initial = 0.0;
   spec.margin_maintenance = 0.0;
   spec.margin_currency = "";
   spec.profit_currency = "";
   spec.has_trade_mode = false;
   spec.has_execution_mode = false;
   spec.has_calculation_mode = false;
   spec.has_filling_mode = false;
   spec.has_expiration_mode = false;
   spec.has_order_mode = false;
   spec.has_chart_mode = false;
   spec.has_spread_float_mode = false;
   spec.has_digits = false;
   spec.has_point = false;
   spec.has_tick_size = false;
   spec.has_tick_value = false;
   spec.has_contract_size = false;
   spec.has_volume_min = false;
   spec.has_volume_max = false;
   spec.has_volume_step = false;
   spec.has_stop_distance_points = false;
   spec.has_freeze_distance_points = false;
   spec.has_swap_mode = false;
   spec.has_swap_long = false;
   spec.has_swap_short = false;
   spec.has_margin_initial = false;
   spec.has_margin_maintenance = false;
   spec.has_margin_currency = false;
   spec.has_profit_currency = false;
  }

void ASC_BrokerDescriptorsReset(ASC_BrokerDescriptors &descriptors)
  {
   descriptors.sector = "";
   descriptors.industry = "";
   descriptors.isin = "";
   descriptors.trust_posture = "unavailable";
   descriptors.has_sector = false;
   descriptors.has_industry = false;
   descriptors.has_isin = false;
  }

string ASC_BrokerDescriptorTrustPosture(const ASC_BrokerDescriptors &descriptors)
  {
   if(descriptors.has_sector || descriptors.has_industry || descriptors.has_isin)
      return "broker-supplied";
   return "unavailable";
  }

struct ASC_SymbolSessionSummary
  {
   string posture;
   string windows;
   bool available;
   datetime last_refreshed_utc;
  };

void ASC_SymbolSessionSummaryReset(ASC_SymbolSessionSummary &summary)
  {
   summary.posture = "unavailable";
   summary.windows = "unavailable";
   summary.available = false;
   summary.last_refreshed_utc = 0;
  }

string ASC_SymbolSessionCompactText(const ASC_SymbolSessionSummary &summary)
  {
   if(!summary.available)
      return "unavailable";
   if(StringLen(summary.windows) <= 0 || summary.windows == "unavailable")
      return summary.posture;
   return summary.posture + " | " + summary.windows;
  }

string ASC_BrokerDescriptorsCompactText(const ASC_BrokerDescriptors &descriptors)
  {
   string text = "";
   if(descriptors.has_sector)
      text += "sector " + descriptors.sector;
   if(descriptors.has_industry)
     {
      if(StringLen(text) > 0)
         text += " | ";
      text += "industry " + descriptors.industry;
     }
   if(descriptors.has_isin)
     {
      if(StringLen(text) > 0)
         text += " | ";
      text += "ISIN " + descriptors.isin;
     }
   if(StringLen(text) <= 0)
      text = "unavailable";
   return text;
  }

string ASC_SymbolSpecificationMoneyText(const bool available,const double value)
  {
   return available ? DoubleToString(value, 2) : "unavailable";
  }

string ASC_SymbolSpecificationValueText(const bool available,const double value,const int digits)
  {
   return available ? DoubleToString(value, digits) : "unavailable";
  }

string ASC_SymbolSpecificationIntegerText(const bool available,const long value)
  {
   return available ? IntegerToString((int)value) : "unavailable";
  }

string ASC_SymbolSpecificationText(const bool available,const string value)
  {
   return (available && StringLen(value) > 0) ? value : "unavailable";
  }

void ASC_SymbolSpecificationRead(const string symbol,ASC_SymbolSpecification &spec)
  {
   ASC_SymbolSpecificationReset(spec, symbol);
   if(StringLen(symbol) <= 0)
      return;

   spec.has_trade_mode = SymbolInfoInteger(symbol, SYMBOL_TRADE_MODE, spec.trade_mode);
   spec.has_execution_mode = SymbolInfoInteger(symbol, SYMBOL_TRADE_EXEMODE, spec.execution_mode);
   spec.has_calculation_mode = SymbolInfoInteger(symbol, SYMBOL_TRADE_CALC_MODE, spec.calculation_mode);
   spec.has_filling_mode = SymbolInfoInteger(symbol, SYMBOL_FILLING_MODE, spec.filling_mode);
   spec.has_expiration_mode = SymbolInfoInteger(symbol, SYMBOL_EXPIRATION_MODE, spec.expiration_mode);
   spec.has_order_mode = SymbolInfoInteger(symbol, SYMBOL_ORDER_MODE, spec.order_mode);
   spec.has_chart_mode = SymbolInfoInteger(symbol, SYMBOL_CHART_MODE, spec.chart_mode);
   spec.has_spread_float_mode = SymbolInfoInteger(symbol, SYMBOL_SPREAD_FLOAT, spec.spread_float_mode);
   spec.has_digits = SymbolInfoInteger(symbol, SYMBOL_DIGITS, spec.digits);
   spec.has_point = SymbolInfoDouble(symbol, SYMBOL_POINT, spec.point);
   spec.has_tick_size = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE, spec.tick_size);
   spec.has_tick_value = SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE, spec.tick_value);
   spec.has_contract_size = SymbolInfoDouble(symbol, SYMBOL_TRADE_CONTRACT_SIZE, spec.contract_size);
   spec.has_volume_min = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN, spec.volume_min);
   spec.has_volume_max = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX, spec.volume_max);
   spec.has_volume_step = SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP, spec.volume_step);
   spec.has_stop_distance_points = SymbolInfoInteger(symbol, SYMBOL_TRADE_STOPS_LEVEL, spec.stop_distance_points);
   spec.has_freeze_distance_points = SymbolInfoInteger(symbol, SYMBOL_TRADE_FREEZE_LEVEL, spec.freeze_distance_points);
   spec.has_swap_mode = SymbolInfoInteger(symbol, SYMBOL_SWAP_MODE, spec.swap_mode);
   spec.has_swap_long = SymbolInfoDouble(symbol, SYMBOL_SWAP_LONG, spec.swap_long);
   spec.has_swap_short = SymbolInfoDouble(symbol, SYMBOL_SWAP_SHORT, spec.swap_short);
   spec.has_margin_initial = SymbolInfoDouble(symbol, SYMBOL_MARGIN_INITIAL, spec.margin_initial);
   spec.has_margin_maintenance = SymbolInfoDouble(symbol, SYMBOL_MARGIN_MAINTENANCE, spec.margin_maintenance);
   spec.has_margin_currency = SymbolInfoString(symbol, SYMBOL_CURRENCY_MARGIN, spec.margin_currency);
   spec.has_profit_currency = SymbolInfoString(symbol, SYMBOL_CURRENCY_PROFIT, spec.profit_currency);
   spec.last_refreshed_utc = TimeGMT();
  }

void ASC_BrokerDescriptorsRead(const string symbol,ASC_BrokerDescriptors &descriptors)
  {
   ASC_BrokerDescriptorsReset(descriptors);
   if(StringLen(symbol) <= 0)
      return;

   long sector = 0;
   long industry = 0;
   descriptors.has_sector = SymbolInfoInteger(symbol, SYMBOL_SECTOR, sector);
   descriptors.has_industry = SymbolInfoInteger(symbol, SYMBOL_INDUSTRY, industry);
   descriptors.has_isin = SymbolInfoString(symbol, SYMBOL_ISIN, descriptors.isin) && StringLen(descriptors.isin) > 0;

   if(descriptors.has_sector)
      descriptors.sector = ASC_SymbolSpecHumanizeEnum(EnumToString((ENUM_SYMBOL_SECTOR)sector));
   if(descriptors.has_industry)
      descriptors.industry = ASC_SymbolSpecHumanizeEnum(EnumToString((ENUM_SYMBOL_INDUSTRY)industry));

   descriptors.trust_posture = ASC_BrokerDescriptorTrustPosture(descriptors);
  }

void ASC_SymbolSessionSummaryRead(const string symbol,ASC_SymbolSessionSummary &summary)
  {
   ASC_SymbolSessionSummaryReset(summary);
   if(StringLen(symbol) <= 0)
      return;

   datetime now_value = TimeTradeServer();
   if(now_value <= 0)
      now_value = TimeCurrent();
   if(now_value <= 0)
      return;

   MqlDateTime now_tm;
   TimeToStruct(now_value, now_tm);
   ENUM_DAY_OF_WEEK today = (ENUM_DAY_OF_WEEK)now_tm.day_of_week;
   int now_seconds = (now_tm.hour * 3600) + (now_tm.min * 60) + now_tm.sec;

   bool any_session = false;
   bool is_open = false;
   bool saw_break = false;
   string windows = "";

   for(uint session_index = 0; session_index < 10; session_index++)
     {
      datetime from_value = 0;
      datetime to_value = 0;
      if(!SymbolInfoSessionTrade(symbol, today, session_index, from_value, to_value))
         break;

      any_session = true;
      MqlDateTime from_tm;
      MqlDateTime to_tm;
      TimeToStruct(from_value, from_tm);
      TimeToStruct(to_value, to_tm);
      int from_seconds = (from_tm.hour * 3600) + (from_tm.min * 60) + from_tm.sec;
      int to_seconds = (to_tm.hour * 3600) + (to_tm.min * 60) + to_tm.sec;
      bool inside = false;
      if(from_seconds == to_seconds)
         inside = true;
      else if(from_seconds < to_seconds)
         inside = (now_seconds >= from_seconds && now_seconds < to_seconds);
      else
         inside = (now_seconds >= from_seconds || now_seconds < to_seconds);

      if(inside)
         is_open = true;
      if(any_session && !inside && windows != "" && session_index > 0)
         saw_break = true;

      if(StringLen(windows) > 0)
         windows += ", ";
      windows += StringFormat("%02d:%02d-%02d:%02d", from_tm.hour, from_tm.min, to_tm.hour, to_tm.min);
     }

   if(!any_session)
      return;

   summary.available = true;
   summary.windows = (StringLen(windows) > 0 ? windows : "unavailable");
   if(is_open)
      summary.posture = "open";
   else if(saw_break)
      summary.posture = "break";
   else
      summary.posture = "closed";
   summary.last_refreshed_utc = TimeGMT();
  }

int ASC_SymbolSpecificationFindCacheIndex(const string symbol,string &cache_symbols[])
  {
   for(int i = 0; i < ArraySize(cache_symbols); i++)
     {
      if(cache_symbols[i] == symbol)
         return i;
     }
   return -1;
  }

string g_asc_symbol_spec_cache_symbols[];
ASC_SymbolSpecification g_asc_symbol_spec_cache[];
string g_asc_broker_descriptor_cache_symbols[];
ASC_BrokerDescriptors g_asc_broker_descriptor_cache[];
string g_asc_session_summary_cache_symbols[];
ASC_SymbolSessionSummary g_asc_session_summary_cache[];

bool ASC_GetSymbolSpecification(const string symbol,ASC_SymbolSpecification &spec,bool force_refresh=false)
  {
   if(StringLen(symbol) <= 0)
     {
      ASC_SymbolSpecificationReset(spec, symbol);
      return false;
     }

   int index = ASC_SymbolSpecificationFindCacheIndex(symbol, g_asc_symbol_spec_cache_symbols);
   if(index < 0)
     {
      index = ArraySize(g_asc_symbol_spec_cache_symbols);
      ArrayResize(g_asc_symbol_spec_cache_symbols, index + 1);
      ArrayResize(g_asc_symbol_spec_cache, index + 1);
      g_asc_symbol_spec_cache_symbols[index] = symbol;
      ASC_SymbolSpecificationReset(g_asc_symbol_spec_cache[index], symbol);
      force_refresh = true;
     }

   if(force_refresh || g_asc_symbol_spec_cache[index].last_refreshed_utc <= 0)
      ASC_SymbolSpecificationRead(symbol, g_asc_symbol_spec_cache[index]);

   spec = g_asc_symbol_spec_cache[index];
   return true;
  }

bool ASC_GetBrokerDescriptors(const string symbol,ASC_BrokerDescriptors &descriptors,bool force_refresh=false)
  {
   if(StringLen(symbol) <= 0)
     {
      ASC_BrokerDescriptorsReset(descriptors);
      return false;
     }

   int index = ASC_SymbolSpecificationFindCacheIndex(symbol, g_asc_broker_descriptor_cache_symbols);
   if(index < 0)
     {
      index = ArraySize(g_asc_broker_descriptor_cache_symbols);
      ArrayResize(g_asc_broker_descriptor_cache_symbols, index + 1);
      ArrayResize(g_asc_broker_descriptor_cache, index + 1);
      g_asc_broker_descriptor_cache_symbols[index] = symbol;
      ASC_BrokerDescriptorsReset(g_asc_broker_descriptor_cache[index]);
      force_refresh = true;
     }

   if(force_refresh || StringLen(g_asc_broker_descriptor_cache[index].trust_posture) <= 0)
      ASC_BrokerDescriptorsRead(symbol, g_asc_broker_descriptor_cache[index]);

   descriptors = g_asc_broker_descriptor_cache[index];
   return true;
  }

bool ASC_GetSymbolSessionSummary(const string symbol,ASC_SymbolSessionSummary &summary,bool force_refresh=false)
  {
   if(StringLen(symbol) <= 0)
     {
      ASC_SymbolSessionSummaryReset(summary);
      return false;
     }

   int index = ASC_SymbolSpecificationFindCacheIndex(symbol, g_asc_session_summary_cache_symbols);
   if(index < 0)
     {
      index = ArraySize(g_asc_session_summary_cache_symbols);
      ArrayResize(g_asc_session_summary_cache_symbols, index + 1);
      ArrayResize(g_asc_session_summary_cache, index + 1);
      g_asc_session_summary_cache_symbols[index] = symbol;
      ASC_SymbolSessionSummaryReset(g_asc_session_summary_cache[index]);
      force_refresh = true;
     }

   if(force_refresh || g_asc_session_summary_cache[index].last_refreshed_utc <= 0)
      ASC_SymbolSessionSummaryRead(symbol, g_asc_session_summary_cache[index]);

   summary = g_asc_session_summary_cache[index];
   return true;
  }

bool ASC_NormalizeRequestedTradeVolume(const ASC_SymbolSpecification &spec,
                                       const double requested_volume,
                                       double &normalized_volume)
  {
   normalized_volume = 0.0;
   if(requested_volume <= 0.0)
      return false;
   if(!spec.has_volume_min || !spec.has_volume_max || !spec.has_volume_step || spec.volume_step <= 0.0)
      return false;

   double clamped = requested_volume;
   if(clamped < spec.volume_min)
      clamped = spec.volume_min;
   if(clamped > spec.volume_max)
      clamped = spec.volume_max;

   double steps = MathRound((clamped - spec.volume_min) / spec.volume_step);
   normalized_volume = spec.volume_min + (steps * spec.volume_step);
   if(normalized_volume < spec.volume_min)
      normalized_volume = spec.volume_min;
   if(normalized_volume > spec.volume_max)
      normalized_volume = spec.volume_max;
   normalized_volume = NormalizeDouble(normalized_volume, 8);
   return true;
  }

bool ASC_CalculateMoneyRisk(const ENUM_ORDER_TYPE order_type,
                            const string symbol,
                            const double volume,
                            const double entry_price,
                            const double stop_price,
                            double &money_risk)
  {
   money_risk = 0.0;
   if(StringLen(symbol) <= 0 || volume <= 0.0 || entry_price <= 0.0 || stop_price <= 0.0)
      return false;

   double profit = 0.0;
   if(!OrderCalcProfit(order_type, symbol, volume, entry_price, stop_price, profit))
      return false;

   money_risk = MathAbs(profit);
   return (money_risk > 0.0 || entry_price == stop_price);
  }

bool ASC_CalculateMarginRequirement(const ENUM_ORDER_TYPE order_type,
                                    const string symbol,
                                    const double volume,
                                    const double price,
                                    double &margin_required)
  {
   margin_required = 0.0;
   if(StringLen(symbol) <= 0 || volume <= 0.0 || price <= 0.0)
      return false;
   return OrderCalcMargin(order_type, symbol, volume, price, margin_required);
  }

#endif
