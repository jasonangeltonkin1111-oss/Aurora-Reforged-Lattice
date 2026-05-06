#ifndef __ASC_LAYER2_OPEN_SYMBOL_SNAPSHOT_MQH__
#define __ASC_LAYER2_OPEN_SYMBOL_SNAPSHOT_MQH__

#include "../core/ASC_Constants.mqh"
#include "../market_state/ASC_MarketStateEngine.mqh"
#include "../symbols/ASC_SymbolSpecification.mqh"

enum ASC_Layer2Freshness
  {
   ASC_L2_FRESH = 0,
   ASC_L2_AGING = 1,
   ASC_L2_STALE = 2,
   ASC_L2_DEGRADED = 3,
   ASC_L2_CONTINUITY = 4
  };

enum ASC_L2HydrationFamily
  {
   ASC_L2_HYDRATION_READY = 0,
   ASC_L2_HYDRATION_SLOW_INCOMPLETE = 1,
   ASC_L2_HYDRATION_LIVE_QUOTE_INCOMPLETE = 2,
   ASC_L2_HYDRATION_LIVE_ANALYTIC_INCOMPLETE = 3
  };

struct ASC_Layer2Packet
  {
   string symbol;
   bool admitted;
   bool tactical_only;
   bool has_packet;
   bool has_last_good;
   bool continuity_backed;
   bool is_stale;
   bool is_degraded;
   ASC_Layer2Freshness freshness;
   datetime last_built_utc;
   datetime last_good_utc;
   datetime next_due_utc;
   string next_due_reason;
   datetime spec_last_built_utc;
   datetime spec_next_due_utc;
   string spec_next_due_reason;
   int packet_age_sec;
   int spec_age_sec;
   // L2-live cadence fields (quote/day-structure/volatility-friction-liquidity posture).
   datetime tick_time_utc;
   int digits;
   long trade_mode;
   double point;
   double bid;
   double ask;
   double spread_points;
   double last_price;
   double spread_abs;
   double spread_pct;
   double day_open;
   double day_high;
   double day_low;
   double day_range_points;
   double day_range_pct;
   double daily_change_pct;
   double day_range_position_pct;
   double atr_points;
   double atr_pct;
   double spread_to_atr;
   bool valid_bid;
   bool valid_ask;
   bool valid_spread;
   bool valid_tick_time;
   bool valid_day_range;
   bool valid_day_open;
   bool valid_daily_change_pct;
   bool valid_day_range_position;
   bool valid_last_price;
   bool valid_spread_pct;
   bool valid_atr_points;
   bool valid_atr_pct;
   bool valid_spread_to_atr;
   // L2-slow cadence fields (broker/spec/session/swap/margin metadata).
   bool has_specification;
   bool spec_is_stale;
   bool spec_is_degraded;
   bool valid_contract_size;
   bool valid_volume_min;
   bool valid_volume_max;
   bool valid_volume_step;
   bool valid_tick_size;
   bool valid_tick_value;
   bool valid_stop_distance;
   bool valid_trade_mode;
   bool valid_execution_mode;
   bool valid_calculation_mode;
   bool valid_filling_mode;
   bool valid_expiration_mode;
   bool valid_gtc_mode;
   bool valid_order_mode;
   bool valid_spread_type;
   bool valid_freeze_distance;
   bool valid_margin_currency;
   bool valid_profit_currency;
   bool valid_quote_session_status;
   bool valid_trade_session_status;
   bool valid_swap_mode;
   bool valid_swap_long;
   bool valid_swap_short;
   bool valid_swap_monday;
   bool valid_swap_tuesday;
   bool valid_swap_wednesday;
   bool valid_swap_thursday;
   bool valid_swap_friday;
   bool valid_margin_mode;
   bool valid_margin_hedged;
   bool valid_buy_initial_margin;
   bool valid_buy_maintenance_margin;
   bool valid_sell_initial_margin;
   bool valid_sell_maintenance_margin;
   bool valid_buy_initial_margin_rate;
   bool valid_buy_maintenance_margin_rate;
   bool valid_sell_initial_margin_rate;
   bool valid_sell_maintenance_margin_rate;
   double contract_size;
   double volume_min;
   double volume_max;
   double volume_step;
   double tick_size;
   double tick_value;
   double min_stop_distance;
   long execution_mode;
   long calculation_mode;
   long filling_mode;
   long expiration_mode;
   long gtc_mode;
   long order_mode;
   long spread_type_mode;
   long swap_mode;
   long margin_mode;
   string margin_currency;
   string profit_currency;
   string quote_session_status;
   string trade_session_status;
   string quote_session_hours;
   string trade_session_hours;
   string session_notes;
   double swap_long;
   double swap_short;
   double swap_monday;
   double swap_tuesday;
   double swap_wednesday;
   double swap_thursday;
   double swap_friday;
   string swap_posture;
   string swap_notes;
   double freeze_distance;
   double margin_hedged;
   double buy_initial_margin;
   double buy_maintenance_margin;
   double sell_initial_margin;
   double sell_maintenance_margin;
   double buy_initial_margin_rate;
   double buy_maintenance_margin_rate;
   double sell_initial_margin_rate;
   double sell_maintenance_margin_rate;
   string margin_posture;
   string margin_notes;
   string market_watch_state_reason;
   string quote_posture;
   string quote_unavailable_owner;
   string quote_unavailable_reason;
   datetime quote_unavailable_next_check_utc;
   bool quote_unavailable_symbol_select_state;
   bool quote_unavailable_symbol_sync_state;
   bool quote_unavailable_tick_success;
   int quote_unavailable_tick_last_error;
   string top5_quote_hydration_source;
   string freshness_posture;
   string continuity_posture;
   string day_direction_snapshot;
   string day_price_action_snapshot;
   string day_structure_posture;
   string day_structure_reason;
   string volatility_state;
   string friction_state;
   string liquidity_state;
   string volatility_liquidity_reason;
   string specification_posture;
   string permission_posture;
   string volume_posture;
   string broker_validation_posture;
   string specification_contract_notes;
   datetime quote_observed_utc;
   string specification_state_reason;
   ASC_L2HydrationFamily hydration_family;
   string hydration_reason_code;
   string hydration_gate_code;
   int slow_completion_retry_count;
   bool slow_hard_absence_confirmed;
   int live_quote_micro_retry_attempts;
   int live_quote_micro_retry_elapsed_ms;
   string changed_fields;
   int admission_epoch;
   ulong revision;
  };

struct ASC_Layer2Summary
  {
   datetime pass_utc;
   int tracked_symbols;
   int admitted_symbols;
   int tactical_symbols;
   int due_symbols;
   int fresh_count;
   int aging_count;
   int stale_count;
   int degraded_count;
   int continuity_count;
   int spec_ready_count;
   int spec_stale_count;
   int spec_degraded_count;
   int spec_due_count;
   int hydration_ready_count;
   int hydration_slow_incomplete_count;
   int hydration_live_quote_incomplete_count;
   int hydration_live_analytic_incomplete_count;
   int hydration_blocked_warmup_count;
   int hydration_blocked_post_warmup_repair_queue_count;
   datetime next_due_utc;
   string next_due_reason;
   int next_due_count;
   bool has_structural_delta;
   ulong latest_revision;
  };

ASC_Layer2Packet g_asc_l2_cache[];
ASC_Layer2Summary g_asc_l2_latest_summary;
bool g_asc_l2_has_summary = false;
string g_asc_l2_top5_overlay_symbols[];
datetime g_asc_l2_top5_overlay_requested_utc = 0;
ulong g_asc_l2_top5_overlay_generation = 0;

int ASC_L2FindIndexBySymbol(const string symbol);
void ASC_L2EvaluatePacket(ASC_Layer2Packet &packet,const datetime now_utc,const int admitted_symbols);
bool ASC_Layer2TryGetPacketBySymbol(const string symbol,ASC_Layer2Packet &packet);
bool ASC_L2PacketHasLawfulSnapshot(const ASC_Layer2Packet &packet);
bool ASC_L2SlowCompletionPending(const ASC_Layer2Packet &packet);

ulong g_asc_l2_revision = 0;
int g_asc_l2_last_changed_symbols = 0;
int g_asc_l2_admission_epoch = 0;

string ASC_L2FreshnessToText(const ASC_Layer2Freshness freshness)
  {
   switch(freshness)
     {
      case ASC_L2_FRESH:      return "fresh";
      case ASC_L2_AGING:      return "aging";
      case ASC_L2_STALE:      return "stale";
      case ASC_L2_DEGRADED:   return "degraded";
      case ASC_L2_CONTINUITY: return "continuity";
     }
   return "degraded";
  }

string ASC_L2FreshnessToOperatorText(const ASC_Layer2Freshness freshness)
  {
   switch(freshness)
     {
      case ASC_L2_FRESH:      return "Fresh";
      case ASC_L2_AGING:      return "Aging";
      case ASC_L2_STALE:      return "Stale";
      case ASC_L2_DEGRADED:   return "Degraded";
      case ASC_L2_CONTINUITY: return "Continuity-backed";
     }
  return "Degraded";
  }

string ASC_L2HydrationFamilyToText(const ASC_L2HydrationFamily family)
  {
   switch(family)
     {
      case ASC_L2_HYDRATION_READY:                  return "ready";
      case ASC_L2_HYDRATION_SLOW_INCOMPLETE:        return "slow_incomplete";
      case ASC_L2_HYDRATION_LIVE_QUOTE_INCOMPLETE:  return "live_quote_incomplete";
      case ASC_L2_HYDRATION_LIVE_ANALYTIC_INCOMPLETE:return "live_analytic_incomplete";
     }
  return "ready";
  }


bool ASC_L2IsTop5OverlayTarget(const string symbol)
  {
   string target = ASC_TrimUpper(symbol);
   if(StringLen(target) <= 0)
      return false;

   for(int i = 0; i < ArraySize(g_asc_l2_top5_overlay_symbols); i++)
     {
      if(g_asc_l2_top5_overlay_symbols[i] == target)
         return true;
     }
   return false;
  }

void ASC_L2SetTop5OverlayTargets(const string &symbols[],const int count,const datetime now_utc)
  {
   string normalized[];
   ArrayResize(normalized, 0);

   int limit = MathMin(MathMax(0, count), 5);
   for(int i = 0; i < limit; i++)
     {
      string target = ASC_TrimUpper(symbols[i]);
      if(StringLen(target) <= 0)
         continue;

      bool duplicate = false;
      for(int j = 0; j < ArraySize(normalized); j++)
        {
         if(normalized[j] == target)
           {
            duplicate = true;
            break;
           }
        }
      if(duplicate)
         continue;

      int next = ArraySize(normalized);
      ArrayResize(normalized, next + 1);
      normalized[next] = target;
     }

   bool changed = (ArraySize(normalized) != ArraySize(g_asc_l2_top5_overlay_symbols));
   if(!changed)
     {
      for(int i = 0; i < ArraySize(normalized); i++)
        {
         if(normalized[i] != g_asc_l2_top5_overlay_symbols[i])
           {
            changed = true;
            break;
           }
        }
     }

   ArrayResize(g_asc_l2_top5_overlay_symbols, ArraySize(normalized));
   for(int i = 0; i < ArraySize(normalized); i++)
      g_asc_l2_top5_overlay_symbols[i] = normalized[i];

   g_asc_l2_top5_overlay_requested_utc = now_utc;
   if(changed)
      g_asc_l2_top5_overlay_generation++;

   for(int i = 0; i < ArraySize(g_asc_l2_top5_overlay_symbols); i++)
     {
      int packet_index = ASC_L2FindIndexBySymbol(g_asc_l2_top5_overlay_symbols[i]);
      if(packet_index < 0)
         continue;

      if(!g_asc_l2_cache[packet_index].admitted && !g_asc_l2_cache[packet_index].tactical_only)
         continue;

      g_asc_l2_cache[packet_index].next_due_utc = now_utc;
      g_asc_l2_cache[packet_index].next_due_reason = "bucket-top5-overlay";
      g_asc_l2_cache[packet_index].spec_next_due_utc = now_utc;
      if(StringLen(g_asc_l2_cache[packet_index].spec_next_due_reason) <= 0
         || StringFind(g_asc_l2_cache[packet_index].spec_next_due_reason, "bucket-top5-overlay") < 0)
         g_asc_l2_cache[packet_index].spec_next_due_reason = "bucket-top5-overlay-spec";
     }
  }

int ASC_L2ProcessTop5OverlayTargets(const datetime now_utc,const int admitted_symbols,const int budget)
  {
   if(budget <= 0)
      return 0;

   int processed = 0;
   for(int i = 0; i < ArraySize(g_asc_l2_top5_overlay_symbols); i++)
     {
      if(processed >= budget)
         break;

      int packet_index = ASC_L2FindIndexBySymbol(g_asc_l2_top5_overlay_symbols[i]);
      if(packet_index < 0)
         continue;

      ASC_Layer2Packet packet = g_asc_l2_cache[packet_index];
      if(!packet.admitted && !packet.tactical_only)
         continue;

      bool resolution_needed = (!ASC_L2PacketHasLawfulSnapshot(packet)
                                || packet.hydration_gate_code == "blocked_by_warmup"
                                || packet.hydration_gate_code == "blocked_by_post_warmup_repair_queue"
                                || !packet.valid_bid
                                || !packet.valid_ask
                                || !packet.valid_spread
                                || ASC_L2SlowCompletionPending(packet));
      if(packet.next_due_utc > now_utc && !resolution_needed)
         continue;
      if(resolution_needed)
        {
         packet.next_due_utc = now_utc;
         packet.next_due_reason = "bucket-top5-overlay-fast-resolution";
         packet.spec_next_due_utc = now_utc;
         packet.spec_next_due_reason = "bucket-top5-overlay-fast-resolution";
        }

      ASC_L2EvaluatePacket(packet, now_utc, admitted_symbols);
      g_asc_l2_cache[packet_index] = packet;
      processed++;
     }
   return processed;
  }

bool ASC_L2TryGetTop5OverlayPacket(const string symbol,const ulong min_revision,ASC_Layer2Packet &packet)
  {
   string target = ASC_TrimUpper(symbol);
   if(!ASC_L2IsTop5OverlayTarget(target))
      return false;
   if(!ASC_Layer2TryGetPacketBySymbol(target, packet))
      return false;
   if(!packet.admitted && !packet.tactical_only)
      return false;
   if(packet.revision < min_revision)
      return false;
   if(!(ASC_L2PacketHasLawfulSnapshot(packet) || packet.continuity_backed || packet.has_last_good || packet.hydration_gate_code == "blocked_by_warmup"))
      return false;
   return true;
  }

int ASC_L2PacketTraceAgeSeconds(const ASC_Layer2Packet &packet,const datetime now_utc = 0)
  {
   if(packet.quote_observed_utc <= 0)
      return -1;

   datetime effective_now = (now_utc > 0 ? now_utc : TimeGMT());
   if(effective_now <= packet.quote_observed_utc)
      return 0;
   return (int)(effective_now - packet.quote_observed_utc);
  }

string ASC_L2PacketTraceIdentity(const ASC_Layer2Packet &packet,const datetime now_utc = 0)
  {
   int age_sec = ASC_L2PacketTraceAgeSeconds(packet, now_utc);
   string age_text = (age_sec >= 0 ? IntegerToString(age_sec) + "s" : "n/a");
   string gate_code = (StringLen(packet.hydration_gate_code) > 0 ? packet.hydration_gate_code : "none");
   string reason_code = (StringLen(packet.hydration_reason_code) > 0 ? packet.hydration_reason_code : "none");
   return StringFormat("l2_packet_rev=%I64u freshness=%s hydration=%s gate=%s reason=%s continuity=%s age=%s",
                       packet.revision,
                       ASC_L2FreshnessToText(packet.freshness),
                       ASC_L2HydrationFamilyToText(packet.hydration_family),
                       gate_code,
                       reason_code,
                       packet.continuity_backed ? "yes" : "no",
                       age_text);
  }

bool ASC_L2SlowRequiredFieldsComplete(const ASC_Layer2Packet &packet)
  {
   bool broker_core_ready = (packet.valid_contract_size
                             && packet.valid_tick_size
                             && packet.valid_tick_value
                             && packet.valid_volume_min
                             && packet.valid_volume_max
                             && packet.valid_volume_step);
   bool permission_core_ready = (packet.valid_trade_mode
                                 && packet.valid_execution_mode
                                 && packet.valid_order_mode);
   bool session_core_ready = (packet.valid_quote_session_status
                              && packet.valid_trade_session_status);
   bool swap_core_ready = (packet.valid_swap_mode
                           && packet.valid_swap_long
                           && packet.valid_swap_short);
   bool margin_core_ready = (packet.valid_margin_mode
                             && packet.valid_margin_currency
                             && packet.valid_profit_currency);
   return (broker_core_ready
           && permission_core_ready
           && session_core_ready
           && swap_core_ready
           && margin_core_ready);
  }

bool ASC_L2SlowCompletionPending(const ASC_Layer2Packet &packet)
  {
   if(!packet.has_specification)
      return true;
   return !ASC_L2SlowRequiredFieldsComplete(packet);
  }

string ASC_L2SlowHydrationReasonCode(const ASC_Layer2Packet &packet)
  {
   if(!packet.has_specification)
      return "spec_owner_missing";
   if(packet.slow_hard_absence_confirmed)
      return "spec_owner_hard_absence_confirmed";
   if(!packet.valid_trade_mode || !packet.valid_execution_mode || !packet.valid_order_mode)
      return "permissions_not_filled";
   if(!packet.valid_quote_session_status || !packet.valid_trade_session_status)
      return "session_template_missing";
   if(!packet.valid_swap_mode || !packet.valid_swap_long || !packet.valid_swap_short)
      return "swap_profile_missing";
   if(!packet.valid_margin_mode || !packet.valid_margin_currency || !packet.valid_profit_currency)
      return "margin_metadata_missing";
   if(packet.spec_is_degraded)
      return "spec_owner_degraded";
   if(packet.spec_is_stale)
      return "spec_owner_stale";
   return "slow_ready";
  }

string ASC_L2LiveQuoteHydrationReasonCode(const ASC_Layer2Packet &packet)
  {
   if(packet.continuity_backed)
      return "continuity_backed_only";
   if(!packet.has_packet)
      return "quote_snapshot_not_live";
   if(!packet.valid_bid || !packet.valid_ask)
      return "quote_snapshot_not_live";
   if(!packet.valid_spread)
      return "spread_invalid";
   if(!packet.valid_tick_time)
      return "tick_time_missing";
   return "live_quote_ready";
  }

string ASC_L2LiveAnalyticHydrationReasonCode(const ASC_Layer2Packet &packet)
  {
   if(!packet.valid_day_range || !packet.valid_day_open)
      return "day_structure_not_ready";
   if(!packet.valid_atr_points || !packet.valid_atr_pct)
      return "atr_not_ready";
   if(packet.volatility_state == "Unavailable" || packet.volatility_state == "Pending")
      return "volatility_helper_not_ready";
   if(packet.liquidity_state == "Unavailable" || packet.liquidity_state == "Pending")
      return "liquidity_helper_not_ready";
  return "live_analytic_ready";
  }

void ASC_L2FinalizeHydrationObservability(ASC_Layer2Packet &packet,const datetime now_utc)
  {
   packet.hydration_family = ASC_L2_HYDRATION_READY;
   packet.hydration_reason_code = "ready";
   packet.hydration_gate_code = "none";

   string slow_reason = ASC_L2SlowHydrationReasonCode(packet);
   if(slow_reason != "slow_ready")
     {
      packet.hydration_family = ASC_L2_HYDRATION_SLOW_INCOMPLETE;
      packet.hydration_reason_code = slow_reason;
     }
   else
     {
      string quote_reason = ASC_L2LiveQuoteHydrationReasonCode(packet);
      if(quote_reason != "live_quote_ready")
        {
         packet.hydration_family = ASC_L2_HYDRATION_LIVE_QUOTE_INCOMPLETE;
         packet.hydration_reason_code = quote_reason;
        }
      else
        {
         string analytic_reason = ASC_L2LiveAnalyticHydrationReasonCode(packet);
         if(analytic_reason != "live_analytic_ready")
           {
            packet.hydration_family = ASC_L2_HYDRATION_LIVE_ANALYTIC_INCOMPLETE;
            packet.hydration_reason_code = analytic_reason;
           }
        }
     }

   if(packet.hydration_family != ASC_L2_HYDRATION_READY)
     {
      ASC_Layer1PassSummary l1_summary;
      bool has_l1_summary = ASC_Layer1TryGetLatestSummary(l1_summary);
      bool warmup_blocked = (!has_l1_summary || !l1_summary.warmup_ready);
      if(warmup_blocked)
         packet.hydration_gate_code = "blocked_by_warmup";
      else if((packet.next_due_utc > now_utc)
              || (packet.spec_next_due_utc > now_utc)
              || packet.next_due_reason == "repair-refresh"
              || packet.spec_next_due_reason == "specification-field-retry"
              || packet.spec_next_due_reason == "specification-read-retry")
         packet.hydration_gate_code = "blocked_by_post_warmup_repair_queue";
     }
  }

string ASC_L2SpecificationFreshnessToOperatorText(const ASC_Layer2Packet &packet)
  {
   if(!packet.has_specification)
      return "Unavailable";
   if(packet.spec_is_degraded)
      return "Degraded";
   if(packet.spec_is_stale)
      return "Stale";
   return "Fresh";
  }

bool ASC_L2TradeabilityTruthAvailable(const ASC_Layer2Packet &packet)
  {
   return (packet.valid_trade_mode || packet.valid_execution_mode || packet.valid_order_mode);
  }

string ASC_L2TradeabilityToOperatorText(const ASC_Layer2Packet &packet)
  {
   if(!ASC_L2TradeabilityTruthAvailable(packet))
      return "unavailable";

   if(packet.valid_trade_mode)
     {
      if(packet.trade_mode == SYMBOL_TRADE_MODE_DISABLED)
         return "restricted";
      if(packet.trade_mode == SYMBOL_TRADE_MODE_CLOSEONLY)
         return "close-only";
     }

   return "tradable";
  }

string ASC_L2SpecificationReasonToOperatorText(const ASC_Layer2Packet &packet)
  {
   string reason = packet.specification_state_reason;
   if(StringLen(reason) > 0)
      return reason;

   if(!packet.has_specification)
      return "specification unavailable";
   if(packet.spec_is_degraded)
      return "specification degraded";
   if(packet.spec_is_stale)
      return "specification stale";
  return "specification available";
  }

bool ASC_L2TryReadLiveQuoteSnapshot(const string symbol,
                                    double &point_value,
                                    double &bid_value,
                                    double &ask_value,
                                    long &quote_time_raw,
                                    bool &has_point,
                                    bool &has_bid,
                                    bool &has_ask,
                                    bool &has_quote_time,
                                    bool &tick_success_out,
                                    int &tick_last_error_out,
                                    bool &symbol_select_state_out,
                                    bool &symbol_sync_state_out)
  {
   tick_success_out = false;
   tick_last_error_out = 0;
   symbol_select_state_out = false;
   symbol_sync_state_out = false;

   long symbol_selected_raw = 0;
   if(SymbolInfoInteger(symbol, SYMBOL_SELECT, symbol_selected_raw))
      symbol_select_state_out = (symbol_selected_raw != 0);
   symbol_sync_state_out = SymbolIsSynchronized(symbol);

   MqlTick latest_tick;
   ResetLastError();
   bool has_latest_tick = SymbolInfoTick(symbol, latest_tick);
   tick_success_out = has_latest_tick;
   if(!has_latest_tick)
      tick_last_error_out = GetLastError();

   has_point = SymbolInfoDouble(symbol, SYMBOL_POINT, point_value);
   has_bid = SymbolInfoDouble(symbol, SYMBOL_BID, bid_value);
   has_ask = SymbolInfoDouble(symbol, SYMBOL_ASK, ask_value);
   if((!has_bid || bid_value <= 0.0) && has_latest_tick && latest_tick.bid > 0.0)
     {
      has_bid = true;
      bid_value = latest_tick.bid;
     }
   if((!has_ask || ask_value <= 0.0) && has_latest_tick && latest_tick.ask > 0.0)
     {
      has_ask = true;
      ask_value = latest_tick.ask;
     }

   has_quote_time = SymbolInfoInteger(symbol, SYMBOL_TIME, quote_time_raw);
   if((!has_quote_time || quote_time_raw <= 0) && has_latest_tick && latest_tick.time > 0)
     {
      has_quote_time = true;
      quote_time_raw = (long)latest_tick.time;
     }

   bool has_positive_point = (has_point && point_value > 0.0);
   bool has_valid_bid = (has_bid && bid_value > 0.0);
   bool has_valid_ask = (has_ask && ask_value > 0.0);
   bool has_tick_time = (has_quote_time && quote_time_raw > 0);
   return (has_valid_bid && has_valid_ask && has_positive_point && has_tick_time && ask_value >= bid_value);
  }

bool ASC_L2TryReadLiveQuoteWithMicroRetry(const string symbol,
                                          const datetime now_utc,
                                          double &point_value,
                                          double &bid_value,
                                          double &ask_value,
                                          long &quote_time_raw,
                                          bool &has_point,
                                          bool &has_bid,
                                          bool &has_ask,
                                          bool &has_quote_time,
                                          bool &tick_success_out,
                                          int &tick_last_error_out,
                                          bool &symbol_select_state_out,
                                          bool &symbol_sync_state_out,
                                          int &attempts_out,
                                          int &elapsed_ms_out)
  {
   attempts_out = 0;
   elapsed_ms_out = 0;
   ulong started_us = GetMicrosecondCount();
   int max_attempts = MathMax(1, ASC_L2_LIVE_MICRO_RETRY_MAX_ATTEMPTS);
   int window_ms = MathMax(1, ASC_L2_LIVE_MICRO_RETRY_WINDOW_MS);

   while(attempts_out < max_attempts)
     {
      attempts_out++;
      if(ASC_L2TryReadLiveQuoteSnapshot(symbol,
                                        point_value,
                                        bid_value,
                                        ask_value,
                                        quote_time_raw,
                                        has_point,
                                        has_bid,
                                        has_ask,
                                        has_quote_time,
                                        tick_success_out,
                                        tick_last_error_out,
                                        symbol_select_state_out,
                                        symbol_sync_state_out))
        {
         elapsed_ms_out = (int)((GetMicrosecondCount() - started_us) / 1000);
         return true;
        }

      ulong elapsed_us = GetMicrosecondCount() - started_us;
      elapsed_ms_out = (int)(elapsed_us / 1000);
      if(elapsed_ms_out >= window_ms)
         break;
      if(quote_time_raw > 0 && (long)now_utc >= quote_time_raw)
         continue;
     }
   return false;
  }

string ASC_L2BidAskPresenceToOperatorText(const bool has_packet,
                                         const bool has_lawful_snapshot,
                                         const ASC_Layer2Packet &packet)
  {
   if(!has_packet)
      return "Unavailable";
   if(has_lawful_snapshot)
      return "Present (live)";
   if(packet.continuity_backed)
      return "Retained last-good only";
   if(packet.valid_bid && packet.valid_ask)
      return "Present (snapshot incomplete)";
   if(packet.valid_bid)
      return "Partial (bid only)";
   if(packet.valid_ask)
      return "Partial (ask only)";
   return "Unavailable";
  }

void ASC_L2BuildMarketWatchQuoteProjection(const bool has_packet,
                                           const bool has_lawful_snapshot,
                                           const ASC_Layer2Packet &packet,
                                           const int fallback_digits,
                                           double &spread_abs_out,
                                           string &bid_text_out,
                                           string &ask_text_out,
                                           string &last_text_out,
                                           string &spread_text_out,
                                           string &spread_pct_text_out,
                                           string &packet_age_text_out,
                                           string &freshness_text_out,
                                           string &last_tick_time_text_out,
                                           string &observed_time_text_out,
                                           string &continuity_text_out,
                                           bool &freshness_degraded_or_stale_out)
  {
   spread_abs_out = 0.0;
   bid_text_out = "unavailable";
   ask_text_out = "unavailable";
   last_text_out = "unavailable";
   spread_text_out = "unavailable";
   spread_pct_text_out = "unavailable";
   packet_age_text_out = "unavailable";
   freshness_text_out = "Unavailable";
   last_tick_time_text_out = ASC_ArtifactFormatUtc(0);
   observed_time_text_out = ASC_ArtifactFormatUtc(0);
   continuity_text_out = "Unavailable";
   freshness_degraded_or_stale_out = false;

   if(!has_packet)
      return;

   int quote_digits = (packet.digits > 0 ? packet.digits : fallback_digits);
   string continuity_posture = (StringLen(packet.continuity_posture) > 0)
                               ? packet.continuity_posture
                               : (packet.continuity_backed ? "Continuity-backed" : "Live");
   freshness_text_out = ASC_L2FreshnessToOperatorText(packet.freshness);
   packet_age_text_out = (packet.packet_age_sec >= 0) ? IntegerToString(packet.packet_age_sec) + "s" : "unavailable";
   last_tick_time_text_out = ASC_ArtifactFormatUtc(packet.tick_time_utc > 0 ? packet.tick_time_utc : 0);
   observed_time_text_out = ASC_ArtifactFormatUtc(packet.quote_observed_utc > 0 ? packet.quote_observed_utc : packet.last_built_utc);
   continuity_text_out = continuity_posture;
   if(StringLen(packet.market_watch_state_reason) > 0)
      continuity_text_out += " | " + packet.market_watch_state_reason;
   freshness_degraded_or_stale_out = (packet.freshness == ASC_L2_STALE
                                      || packet.freshness == ASC_L2_DEGRADED
                                      || packet.freshness == ASC_L2_CONTINUITY);

   if(!has_lawful_snapshot)
      return;

   spread_abs_out = packet.valid_spread ? packet.spread_abs : 0.0;
   bid_text_out = DoubleToString(packet.bid, quote_digits);
   ask_text_out = DoubleToString(packet.ask, quote_digits);
   last_text_out = packet.valid_last_price ? DoubleToString(packet.last_price, quote_digits) : "unavailable";
   spread_text_out = DoubleToString(spread_abs_out, quote_digits);
   if(packet.valid_spread_pct)
      spread_pct_text_out = DoubleToString(packet.spread_pct, 3) + "%";
  }

int ASC_L2FindIndexBySymbol(const string symbol)
  {
   for(int i = 0; i < ArraySize(g_asc_l2_cache); i++)
     {
      if(g_asc_l2_cache[i].symbol == symbol)
         return i;
     }
   return -1;
  }

int ASC_L2UniverseScale(const int admitted_symbols)
  {
   if(admitted_symbols >= 600)
      return 3;
   if(admitted_symbols >= 150)
      return 2;
  return 1;
  }

int ASC_L2DynamicPacketBudget(const int admitted_symbols)
  {
   if(admitted_symbols <= 0)
      return 4;
   if(admitted_symbols <= 50)
      return 20;
   if(admitted_symbols <= 200)
      return 40;
   if(admitted_symbols <= 600)
      return MathMax(48, ASC_L2_PACKET_BUDGET_PER_HEARTBEAT);
   return MathMax(64, ASC_L2_PACKET_BUDGET_PER_HEARTBEAT + (ASC_L2_PACKET_BUDGET_PER_HEARTBEAT / 2));
  }

void ASC_L2ScheduleNextDue(ASC_Layer2Packet &packet,const datetime now_utc,const int seconds,const string reason)
  {
   int due_sec = ASC_ClampInt(seconds, 1, 3600);
   packet.next_due_utc = now_utc + due_sec;
   packet.next_due_reason = reason;
  }

void ASC_L2InitPacket(ASC_Layer2Packet &packet,const string symbol)
  {
   packet.symbol = symbol;
   packet.admitted = false;
   packet.tactical_only = false;
   packet.has_packet = false;
   packet.has_last_good = false;
   packet.continuity_backed = false;
   packet.is_stale = true;
   packet.is_degraded = true;
   packet.freshness = ASC_L2_DEGRADED;
   packet.last_built_utc = 0;
   packet.last_good_utc = 0;
   packet.next_due_utc = 0;
   packet.next_due_reason = "awaiting-admission";
   packet.spec_last_built_utc = 0;
   packet.spec_next_due_utc = 0;
   packet.spec_next_due_reason = "awaiting-admission";
   packet.packet_age_sec = 0;
   packet.spec_age_sec = ASC_L2_SPEC_DEGRADED_AGE_SEC + 1;
   packet.tick_time_utc = 0;
   packet.digits = 0;
   packet.trade_mode = 0;
   packet.point = 0.0;
   packet.bid = 0.0;
   packet.ask = 0.0;
   packet.spread_points = 0.0;
   packet.last_price = 0.0;
   packet.spread_abs = 0.0;
   packet.spread_pct = 0.0;
   packet.day_open = 0.0;
   packet.day_high = 0.0;
   packet.day_low = 0.0;
   packet.day_range_points = 0.0;
   packet.day_range_pct = 0.0;
   packet.daily_change_pct = 0.0;
   packet.day_range_position_pct = 0.0;
   packet.atr_points = 0.0;
   packet.atr_pct = 0.0;
   packet.spread_to_atr = 0.0;
   packet.valid_bid = false;
   packet.valid_ask = false;
   packet.valid_spread = false;
   packet.valid_tick_time = false;
   packet.valid_day_range = false;
   packet.valid_day_open = false;
   packet.valid_daily_change_pct = false;
   packet.valid_day_range_position = false;
   packet.valid_last_price = false;
   packet.valid_spread_pct = false;
   packet.valid_atr_points = false;
   packet.valid_atr_pct = false;
   packet.valid_spread_to_atr = false;
   packet.has_specification = false;
   packet.spec_is_stale = true;
   packet.spec_is_degraded = true;
   packet.valid_contract_size = false;
   packet.valid_volume_min = false;
   packet.valid_volume_max = false;
   packet.valid_volume_step = false;
   packet.valid_tick_size = false;
   packet.valid_tick_value = false;
   packet.valid_stop_distance = false;
   packet.valid_trade_mode = false;
   packet.valid_execution_mode = false;
   packet.valid_calculation_mode = false;
   packet.valid_filling_mode = false;
   packet.valid_expiration_mode = false;
   packet.valid_gtc_mode = false;
   packet.valid_order_mode = false;
   packet.valid_spread_type = false;
   packet.valid_freeze_distance = false;
   packet.valid_margin_currency = false;
   packet.valid_profit_currency = false;
   packet.valid_quote_session_status = false;
   packet.valid_trade_session_status = false;
   packet.valid_swap_mode = false;
   packet.valid_swap_long = false;
   packet.valid_swap_short = false;
   packet.valid_swap_monday = false;
   packet.valid_swap_tuesday = false;
   packet.valid_swap_wednesday = false;
   packet.valid_swap_thursday = false;
   packet.valid_swap_friday = false;
   packet.valid_margin_mode = false;
   packet.valid_margin_hedged = false;
   packet.valid_buy_initial_margin = false;
   packet.valid_buy_maintenance_margin = false;
   packet.valid_sell_initial_margin = false;
   packet.valid_sell_maintenance_margin = false;
   packet.valid_buy_initial_margin_rate = false;
   packet.valid_buy_maintenance_margin_rate = false;
   packet.valid_sell_initial_margin_rate = false;
   packet.valid_sell_maintenance_margin_rate = false;
   packet.contract_size = 0.0;
   packet.volume_min = 0.0;
   packet.volume_max = 0.0;
   packet.volume_step = 0.0;
   packet.tick_size = 0.0;
   packet.tick_value = 0.0;
   packet.min_stop_distance = 0.0;
   packet.execution_mode = 0;
   packet.calculation_mode = 0;
   packet.filling_mode = 0;
   packet.expiration_mode = 0;
   packet.gtc_mode = 0;
   packet.order_mode = 0;
   packet.spread_type_mode = 0;
   packet.swap_mode = 0;
   packet.margin_mode = 0;
   packet.margin_currency = "";
   packet.profit_currency = "";
   packet.quote_session_status = "Unavailable";
   packet.trade_session_status = "Unavailable";
   packet.quote_session_hours = "unavailable";
   packet.trade_session_hours = "unavailable";
   packet.session_notes = "session unavailable";
   packet.swap_long = 0.0;
   packet.swap_short = 0.0;
   packet.swap_monday = 0.0;
   packet.swap_tuesday = 0.0;
   packet.swap_wednesday = 0.0;
   packet.swap_thursday = 0.0;
   packet.swap_friday = 0.0;
   packet.swap_posture = "Unavailable";
   packet.swap_notes = "swap unavailable";
   packet.freeze_distance = 0.0;
   packet.margin_hedged = 0.0;
   packet.buy_initial_margin = 0.0;
   packet.buy_maintenance_margin = 0.0;
   packet.sell_initial_margin = 0.0;
   packet.sell_maintenance_margin = 0.0;
   packet.buy_initial_margin_rate = 0.0;
   packet.buy_maintenance_margin_rate = 0.0;
   packet.sell_initial_margin_rate = 0.0;
   packet.sell_maintenance_margin_rate = 0.0;
   packet.margin_posture = "Unavailable";
   packet.margin_notes = "margin unavailable";
   packet.market_watch_state_reason = "awaiting-admission";
   packet.quote_posture = "unavailable";
   packet.quote_unavailable_owner = "ASC_OpenSymbolSnapshotEngine";
   packet.quote_unavailable_reason = "awaiting_admission";
   packet.quote_unavailable_next_check_utc = 0;
   packet.quote_unavailable_symbol_select_state = false;
   packet.quote_unavailable_symbol_sync_state = false;
   packet.quote_unavailable_tick_success = false;
   packet.quote_unavailable_tick_last_error = 0;
   packet.top5_quote_hydration_source = "ASC_OpenSymbolSnapshotEngine/SymbolInfoTick+SymbolInfoDouble";
   packet.freshness_posture = "degraded";
   packet.continuity_posture = "Unavailable";
   packet.day_direction_snapshot = "Unavailable";
   packet.day_price_action_snapshot = "Unavailable";
   packet.day_structure_posture = "unavailable";
   packet.day_structure_reason = "day structure unavailable";
   packet.volatility_state = "Unavailable";
   packet.friction_state = "Unavailable";
   packet.liquidity_state = "Unavailable";
   packet.volatility_liquidity_reason = "volatility/liquidity unavailable";
   packet.specification_posture = "Unavailable";
   packet.permission_posture = "Unavailable";
   packet.volume_posture = "Unavailable";
   packet.broker_validation_posture = "Unavailable";
   packet.specification_contract_notes = "specification unavailable";
   packet.quote_observed_utc = 0;
   packet.specification_state_reason = "awaiting-admission";
   packet.hydration_family = ASC_L2_HYDRATION_SLOW_INCOMPLETE;
   packet.hydration_reason_code = "spec_owner_missing";
   packet.hydration_gate_code = "blocked_by_warmup";
   packet.slow_completion_retry_count = 0;
   packet.slow_hard_absence_confirmed = false;
   packet.live_quote_micro_retry_attempts = 0;
   packet.live_quote_micro_retry_elapsed_ms = 0;
   packet.changed_fields = "none";
   packet.admission_epoch = 0;
   packet.revision = 0;
  }

bool ASC_L2PacketHasLawfulSnapshot(const ASC_Layer2Packet &packet)
  {
   if(!packet.has_packet)
      return false;
   if(packet.continuity_backed)
      return false;
   if(!packet.valid_bid || !packet.valid_ask)
      return false;
   if(!packet.valid_spread)
      return false;
   if(!packet.valid_tick_time)
      return false;
   return true;
  }

bool ASC_L2PacketHasLawfulDayRange(const ASC_Layer2Packet &packet)
  {
   if(!packet.has_packet && !packet.has_last_good)
      return false;
   if(!packet.valid_day_range)
      return false;
   if(packet.day_high < packet.day_low)
      return false;
   return true;
  }

string ASC_L2ChangedFieldSubset(const ASC_Layer2Packet &before_packet,const ASC_Layer2Packet &after_packet)
  {
   string fields = "";
   if(before_packet.freshness != after_packet.freshness)
      fields += "freshness,";
   if(before_packet.packet_age_sec != after_packet.packet_age_sec)
      fields += "tick_age,";
   if(before_packet.tick_time_utc != after_packet.tick_time_utc)
      fields += "tick_time,";
   if(before_packet.continuity_backed != after_packet.continuity_backed)
      fields += "continuity,";
   if(before_packet.valid_bid != after_packet.valid_bid || MathAbs(before_packet.bid - after_packet.bid) > 0.0)
      fields += "bid,";
   if(before_packet.valid_ask != after_packet.valid_ask || MathAbs(before_packet.ask - after_packet.ask) > 0.0)
      fields += "ask,";
   if(before_packet.valid_spread != after_packet.valid_spread || MathAbs(before_packet.spread_points - after_packet.spread_points) > 0.0)
      fields += "spread,";
   if(before_packet.valid_day_range != after_packet.valid_day_range
      || MathAbs(before_packet.day_high - after_packet.day_high) > 0.0
      || MathAbs(before_packet.day_low - after_packet.day_low) > 0.0
      || MathAbs(before_packet.day_range_points - after_packet.day_range_points) > 0.0)
      fields += "day_range,";
   if(before_packet.market_watch_state_reason != after_packet.market_watch_state_reason)
      fields += "state_reason,";
   if(before_packet.live_quote_micro_retry_attempts != after_packet.live_quote_micro_retry_attempts)
      fields += "live_quote_micro_retry_attempts,";
   if(before_packet.live_quote_micro_retry_elapsed_ms != after_packet.live_quote_micro_retry_elapsed_ms)
      fields += "live_quote_micro_retry_elapsed_ms,";
   if(before_packet.hydration_family != after_packet.hydration_family)
      fields += "hydration_family,";
   if(before_packet.hydration_reason_code != after_packet.hydration_reason_code)
      fields += "hydration_reason,";
   if(before_packet.hydration_gate_code != after_packet.hydration_gate_code)
      fields += "hydration_gate,";
   if(before_packet.slow_hard_absence_confirmed != after_packet.slow_hard_absence_confirmed)
      fields += "slow_absence,";
   if(before_packet.next_due_utc != after_packet.next_due_utc)
      fields += "next_due,";
   if(before_packet.has_specification != after_packet.has_specification)
      fields += "spec_status,";
   if(before_packet.spec_is_stale != after_packet.spec_is_stale || before_packet.spec_is_degraded != after_packet.spec_is_degraded)
      fields += "spec_freshness,";
   if(before_packet.spec_next_due_utc != after_packet.spec_next_due_utc)
      fields += "spec_next_due,";
   if(before_packet.valid_contract_size != after_packet.valid_contract_size
      || MathAbs(before_packet.contract_size - after_packet.contract_size) > 0.0)
      fields += "contract_size,";
   if(before_packet.valid_volume_min != after_packet.valid_volume_min
      || MathAbs(before_packet.volume_min - after_packet.volume_min) > 0.0)
      fields += "volume_min,";
   if(before_packet.valid_volume_max != after_packet.valid_volume_max
      || MathAbs(before_packet.volume_max - after_packet.volume_max) > 0.0)
      fields += "volume_max,";
   if(before_packet.valid_volume_step != after_packet.valid_volume_step
      || MathAbs(before_packet.volume_step - after_packet.volume_step) > 0.0)
      fields += "volume_step,";
   if(before_packet.valid_tick_size != after_packet.valid_tick_size
      || MathAbs(before_packet.tick_size - after_packet.tick_size) > 0.0)
      fields += "tick_size,";
   if(before_packet.valid_tick_value != after_packet.valid_tick_value
      || MathAbs(before_packet.tick_value - after_packet.tick_value) > 0.0)
      fields += "tick_value,";
   if(before_packet.valid_stop_distance != after_packet.valid_stop_distance
      || MathAbs(before_packet.min_stop_distance - after_packet.min_stop_distance) > 0.0)
      fields += "min_stop_distance,";
   if(before_packet.trade_mode != after_packet.trade_mode || before_packet.valid_trade_mode != after_packet.valid_trade_mode)
      fields += "trade_mode,";
   if(before_packet.execution_mode != after_packet.execution_mode || before_packet.valid_execution_mode != after_packet.valid_execution_mode)
      fields += "execution_mode,";
   if(before_packet.margin_currency != after_packet.margin_currency || before_packet.valid_margin_currency != after_packet.valid_margin_currency)
      fields += "margin_currency,";
   if(before_packet.profit_currency != after_packet.profit_currency || before_packet.valid_profit_currency != after_packet.valid_profit_currency)
      fields += "profit_currency,";

   if(StringLen(fields) <= 0)
      return "none";
   if(StringSubstr(fields, StringLen(fields) - 1, 1) == ",")
      fields = StringSubstr(fields, 0, StringLen(fields) - 1);
   return fields;
  }

bool ASC_L2MaterialChanged(const ASC_Layer2Packet &before_packet,const ASC_Layer2Packet &after_packet)
  {
   double point_size = after_packet.point;
   if(point_size <= 0.0)
      point_size = before_packet.point;
   if(point_size <= 0.0)
      point_size = 0.00001;

   double bid_shift_points = MathAbs(after_packet.bid - before_packet.bid) / point_size;
   double ask_shift_points = MathAbs(after_packet.ask - before_packet.ask) / point_size;
   double spread_shift_points = MathAbs(after_packet.spread_points - before_packet.spread_points);
   bool has_significant_quote_shift = (bid_shift_points >= 2.0 || ask_shift_points >= 2.0 || spread_shift_points >= 1.0);

   double previous_range_points = before_packet.day_range_points;
   double current_range_points = after_packet.day_range_points;
   bool has_significant_range_shift = MathAbs(current_range_points - previous_range_points) >= (2.0 * point_size);

   if(before_packet.admitted != after_packet.admitted)
      return true;
   if(before_packet.tactical_only != after_packet.tactical_only)
      return true;
   if(before_packet.has_packet != after_packet.has_packet)
      return true;
   if(before_packet.valid_bid != after_packet.valid_bid)
      return true;
   if(before_packet.valid_ask != after_packet.valid_ask)
      return true;
   if(before_packet.valid_spread != after_packet.valid_spread)
      return true;
   if(before_packet.valid_tick_time != after_packet.valid_tick_time)
      return true;
   if(before_packet.valid_day_range != after_packet.valid_day_range)
      return true;
   if(before_packet.continuity_backed != after_packet.continuity_backed)
      return true;
   if(before_packet.freshness != after_packet.freshness)
      return true;
   if(before_packet.is_stale != after_packet.is_stale)
      return true;
   if(before_packet.is_degraded != after_packet.is_degraded)
      return true;
   if(before_packet.has_specification != after_packet.has_specification)
      return true;
   if(before_packet.spec_is_stale != after_packet.spec_is_stale)
      return true;
   if(before_packet.spec_is_degraded != after_packet.spec_is_degraded)
      return true;
   if(before_packet.valid_contract_size != after_packet.valid_contract_size)
      return true;
   if(before_packet.valid_volume_min != after_packet.valid_volume_min)
      return true;
   if(before_packet.valid_volume_max != after_packet.valid_volume_max)
      return true;
   if(before_packet.valid_volume_step != after_packet.valid_volume_step)
      return true;
   if(before_packet.valid_tick_size != after_packet.valid_tick_size)
      return true;
   if(before_packet.valid_tick_value != after_packet.valid_tick_value)
      return true;
   if(before_packet.valid_stop_distance != after_packet.valid_stop_distance)
      return true;
   if(before_packet.valid_trade_mode != after_packet.valid_trade_mode)
      return true;
   if(before_packet.valid_execution_mode != after_packet.valid_execution_mode)
      return true;
   if(before_packet.valid_margin_currency != after_packet.valid_margin_currency)
      return true;
   if(before_packet.valid_profit_currency != after_packet.valid_profit_currency)
      return true;
   if(MathAbs(before_packet.contract_size - after_packet.contract_size) > 0.0)
      return true;
   if(MathAbs(before_packet.volume_min - after_packet.volume_min) > 0.0)
      return true;
   if(MathAbs(before_packet.volume_max - after_packet.volume_max) > 0.0)
      return true;
   if(MathAbs(before_packet.volume_step - after_packet.volume_step) > 0.0)
      return true;
   if(MathAbs(before_packet.tick_size - after_packet.tick_size) > 0.0)
      return true;
   if(MathAbs(before_packet.tick_value - after_packet.tick_value) > 0.0)
      return true;
   if(MathAbs(before_packet.min_stop_distance - after_packet.min_stop_distance) > 0.0)
      return true;
   if(before_packet.trade_mode != after_packet.trade_mode)
      return true;
   if(before_packet.execution_mode != after_packet.execution_mode)
      return true;
   if(before_packet.margin_currency != after_packet.margin_currency)
      return true;
   if(before_packet.profit_currency != after_packet.profit_currency)
      return true;
   if(has_significant_quote_shift)
      return true;
   if(has_significant_range_shift)
      return true;
   return false;
  }

string ASC_L2EvidenceRecheckState(const ASC_Layer2Packet &packet,const datetime now_utc)
  {
   if(StringLen(packet.symbol) <= 0 || !packet.admitted)
      return "not_applicable";

   bool quote_due = (packet.next_due_utc <= 0 || packet.next_due_utc <= now_utc);
   bool spec_due = (packet.spec_next_due_utc <= 0 || packet.spec_next_due_utc <= now_utc);
   bool retry_reason = (StringFind(packet.next_due_reason, "repair") >= 0
                        || StringFind(packet.next_due_reason, "retry") >= 0
                        || StringFind(packet.spec_next_due_reason, "retry") >= 0
                        || StringFind(packet.spec_next_due_reason, "repair") >= 0);

   if(packet.continuity_backed || packet.freshness == ASC_L2_CONTINUITY || packet.freshness == ASC_L2_STALE || packet.spec_is_stale)
      return "stale_but_recoverable";
   if(packet.is_degraded || packet.freshness == ASC_L2_DEGRADED || (packet.spec_is_degraded && packet.slow_hard_absence_confirmed))
      return "dependency_blocked";
   if(!packet.has_packet)
      return quote_due ? "refresh_due" : "refresh_pending";
   if(retry_reason)
      return (quote_due || spec_due) ? "refresh_due" : "retry_scheduled";
   if(!packet.valid_bid || !packet.valid_ask || !packet.valid_tick_time || packet.point <= 0.0)
      return (quote_due || spec_due) ? "refresh_due" : "insufficient_now";
   if(!packet.has_specification && spec_due)
      return "refresh_due";
   if(!packet.has_specification)
      return "refresh_pending";
   if(quote_due || spec_due)
      return "refresh_due";

   return "recovered_to_supported";
  }

string ASC_L2EvidenceRecheckBridgeDetail(const ASC_Layer2Packet &packet,const datetime now_utc)
  {
   return "l2_evidence_recheck_bridge=present"
          + StringFormat(" | l2_evidence_recheck_state=%s", ASC_L2EvidenceRecheckState(packet, now_utc))
          + StringFormat(" | l2_next_due_reason=%s", packet.next_due_reason)
          + StringFormat(" | l2_spec_next_due_reason=%s", packet.spec_next_due_reason)
          + StringFormat(" | l2_live_quote_micro_retry_attempts=%d", packet.live_quote_micro_retry_attempts)
          + StringFormat(" | l2_slow_completion_retry_count=%d", packet.slow_completion_retry_count)
          + " | l2_existing_cadence_only=yes"
          + " | l2_unavailable_not_permanent_gate=yes"
          + " | l2_no_heavy_refresh_loop=yes";
  }


string ASC_L2ResolverLifecycleSummaryDetail(const datetime now_utc)
  {
   int warmup_pending = 0;
   int retry_pending = 0;
   int symbol_not_selected = 0;
   int tick_missing = 0;
   int tick_stale = 0;
   int spec_unavailable = 0;
   int retained_last_good = 0;
   int persistent_unavailable = 0;
   int due_now = 0;
   int attempted = 0;
   datetime next_due = 0;
   string next_due_reason = "not_applicable";

   for(int i = 0; i < ArraySize(g_asc_l2_cache); i++)
     {
      ASC_Layer2Packet packet = g_asc_l2_cache[i];
      if(StringLen(packet.symbol) <= 0)
         continue;
      if(!packet.admitted && !packet.tactical_only)
        {
         symbol_not_selected++;
         continue;
        }

      bool quote_due = (packet.next_due_utc <= 0 || packet.next_due_utc <= now_utc);
      bool spec_due = (packet.spec_next_due_utc <= 0 || packet.spec_next_due_utc <= now_utc);
      if(quote_due || spec_due)
         due_now++;
      if(packet.last_built_utc > 0 || packet.spec_last_built_utc > 0)
         attempted++;
      if(packet.hydration_gate_code == "blocked_by_warmup")
         warmup_pending++;
      else if(packet.hydration_gate_code == "blocked_by_post_warmup_repair_queue")
         retry_pending++;
      if(packet.hydration_reason_code == "live_quote_bid_ask_missing"
         || packet.hydration_reason_code == "live_quote_time_missing"
         || packet.hydration_family == ASC_L2_HYDRATION_LIVE_QUOTE_INCOMPLETE)
         tick_missing++;
      if(packet.freshness == ASC_L2_STALE || packet.is_stale)
         tick_stale++;
      if(!packet.has_specification || packet.hydration_reason_code == "spec_owner_missing")
         spec_unavailable++;
      if(packet.continuity_backed || packet.freshness == ASC_L2_CONTINUITY || packet.has_last_good)
         retained_last_good++;
      if(packet.slow_hard_absence_confirmed || (packet.is_degraded && packet.slow_completion_retry_count >= ASC_L2_SLOW_BOOTSTRAP_RETRY_CAP))
         persistent_unavailable++;
      if(packet.next_due_utc > 0 && (next_due == 0 || packet.next_due_utc < next_due))
        {
         next_due = packet.next_due_utc;
         next_due_reason = packet.next_due_reason;
        }
      if(packet.spec_next_due_utc > 0 && (next_due == 0 || packet.spec_next_due_utc < next_due))
        {
         next_due = packet.spec_next_due_utc;
         next_due_reason = packet.spec_next_due_reason;
        }
     }

   string resolver_status = "not_due";
   if(due_now > 0 && attempted > 0)
      resolver_status = "attempted";
   else if(due_now > 0)
      resolver_status = "due";
   else if(retry_pending > 0 || warmup_pending > 0)
      resolver_status = "still_pending";

   string unavailable_state = "no_gap_found";
   if(warmup_pending > 0)
      unavailable_state = "warmup_pending";
   else if(retry_pending > 0)
      unavailable_state = "retry_pending";
   else if(persistent_unavailable > 0)
      unavailable_state = "persistent_unavailable";
   else if(tick_missing > 0)
      unavailable_state = "tick_missing";
   else if(tick_stale > 0)
      unavailable_state = "tick_stale";
   else if(spec_unavailable > 0)
      unavailable_state = "spec_unavailable";
   else if(symbol_not_selected > 0)
      unavailable_state = "symbol_not_selected";

   string downstream_authority = (persistent_unavailable > 0) ? "degraded" : ((warmup_pending > 0 || retry_pending > 0 || tick_missing > 0 || tick_stale > 0 || spec_unavailable > 0) ? "limited" : "clean");
   string artifact_projection = (downstream_authority == "clean") ? "allowed" : "qualified";
   string expiry_policy = (warmup_pending > 0) ? "warmup_only" : (persistent_unavailable > 0 ? "broker_unavailable" : "cadence_retry");

   return StringFormat("resolver_domain=open_symbol_snapshot | unavailable_state=%s | resolver_owner=l2_open_symbol_snapshot | resolver_status=%s | retry_due_utc=%s | last_attempt_utc=%s | attempt_count=%d | expiry_policy=%s | downstream_authority=%s | artifact_projection=%s | warmup_pending=%d | retry_pending=%d | symbol_not_selected=%d | tick_missing=%d | tick_stale=%d | spec_unavailable=%d | retained_last_good=%d | persistent_unavailable=%d | due_now=%d | next_due_reason=%s | behavior_change=no",
                       unavailable_state,
                       resolver_status,
                       ASC_ArtifactFormatUtc(next_due),
                       ASC_ArtifactFormatUtc(now_utc),
                       attempted,
                       expiry_policy,
                       downstream_authority,
                       artifact_projection,
                       warmup_pending,
                       retry_pending,
                       symbol_not_selected,
                       tick_missing,
                       tick_stale,
                       spec_unavailable,
                       retained_last_good,
                       persistent_unavailable,
                       due_now,
                       next_due_reason);
  }

void ASC_L2ApplyCadence(ASC_Layer2Packet &packet,const datetime now_utc,const int admitted_symbols)
  {
   int scale = ASC_L2UniverseScale(admitted_symbols);
   if(packet.freshness == ASC_L2_FRESH)
      ASC_L2ScheduleNextDue(packet, now_utc, MathMax(1, ASC_L2_RECHECK_OPEN_SEC * scale), "open-subset-maintenance");
   else if(packet.freshness == ASC_L2_AGING)
      ASC_L2ScheduleNextDue(packet, now_utc, ASC_L2_RECHECK_AGING_SEC, "aging-refresh");
   else
      ASC_L2ScheduleNextDue(packet, now_utc, ASC_L2_RECHECK_REPAIR_SEC, "repair-refresh");
  }

void ASC_L2FinalizeSpecificationPacket(ASC_Layer2Packet &packet)
  {
   packet.specification_posture = "Unavailable";
   packet.permission_posture = "Unavailable";
   packet.volume_posture = "Unavailable";
   packet.broker_validation_posture = "Unavailable";
   packet.specification_contract_notes = packet.specification_state_reason;

   if(packet.has_specification && !packet.spec_is_degraded && !packet.spec_is_stale)
      packet.specification_posture = "Ready";
   else if(packet.has_specification && packet.spec_is_stale)
      packet.specification_posture = "Stale";
   else if(packet.has_specification)
      packet.specification_posture = "Degraded";

   bool permission_ready = (packet.valid_trade_mode
                            || packet.valid_execution_mode
                            || packet.valid_filling_mode
                            || packet.valid_expiration_mode
                            || packet.valid_order_mode);
   if(permission_ready)
     {
      if(packet.valid_trade_mode && packet.trade_mode == SYMBOL_TRADE_MODE_DISABLED)
         packet.permission_posture = "Restricted";
      else if(packet.valid_trade_mode && packet.trade_mode == SYMBOL_TRADE_MODE_CLOSEONLY)
         packet.permission_posture = "Close-only";
      else
         packet.permission_posture = "Tradable";
     }

   bool volume_ready = (packet.valid_volume_min && packet.valid_volume_max && packet.valid_volume_step);
   if(volume_ready)
      packet.volume_posture = "Ready";
   else if(packet.valid_volume_min || packet.valid_volume_max || packet.valid_volume_step)
      packet.volume_posture = "Partial";

   bool broker_ready = (packet.valid_contract_size
                        && packet.valid_tick_size
                        && packet.valid_tick_value
                        && packet.valid_calculation_mode);
   if(broker_ready)
      packet.broker_validation_posture = "Validated";
   else if(packet.has_specification)
      packet.broker_validation_posture = "Partial";
  }

string ASC_L2SessionRangeText(const datetime from_sec,const datetime to_sec)
  {
   if(from_sec < 0 || to_sec < 0)
      return "unavailable";

   int from_minutes = (int)(from_sec / 60);
   int to_minutes = (int)(to_sec / 60);
   if(from_minutes < 0)
      from_minutes = 0;
   if(to_minutes < 0)
      to_minutes = 0;

   bool full_day_window = (from_minutes == 0 && to_minutes == 0);
   if(full_day_window)
      return "00:00-23:59";

   if(to_minutes <= from_minutes)
      to_minutes = (24 * 60) - 1;

   int from_h = from_minutes / 60;
   int from_m = from_minutes % 60;
   int to_h = to_minutes / 60;
   int to_m = to_minutes % 60;
   if(to_h > 23)
     {
      to_h = 23;
      to_m = 59;
     }

   return StringFormat("%02d:%02d-%02d:%02d", from_h, from_m, to_h, to_m);
  }

void ASC_L2FinalizeSessionsSwapMarginPacket(ASC_Layer2Packet &packet)
  {
   packet.quote_session_status = "Unavailable";
   packet.trade_session_status = "Unavailable";
   packet.quote_session_hours = "unavailable";
   packet.trade_session_hours = "unavailable";
   packet.session_notes = "session unavailable";
   packet.swap_posture = "Unavailable";
   packet.swap_notes = "swap unavailable";
   packet.margin_posture = "Unavailable";
   packet.margin_notes = "margin unavailable";

   datetime q_from = 0, q_to = 0, t_from = 0, t_to = 0;
   MqlDateTime now_parts;
   TimeToStruct(TimeCurrent(), now_parts);
   ENUM_DAY_OF_WEEK dow = (ENUM_DAY_OF_WEEK)now_parts.day_of_week;
   bool has_quote_session = SymbolInfoSessionQuote(packet.symbol, dow, 0, q_from, q_to);
   bool has_trade_session = SymbolInfoSessionTrade(packet.symbol, dow, 0, t_from, t_to);
   packet.valid_quote_session_status = has_quote_session;
   packet.valid_trade_session_status = has_trade_session;
   if(has_quote_session)
     {
      packet.quote_session_status = "Scheduled";
      packet.quote_session_hours = ASC_L2SessionRangeText(q_from, q_to);
     }
   if(has_trade_session)
     {
      packet.trade_session_status = "Scheduled";
      packet.trade_session_hours = ASC_L2SessionRangeText(t_from, t_to);
     }
   if(has_quote_session || has_trade_session)
      packet.session_notes = "session schedule sourced from symbol session owner";

   packet.valid_swap_mode = SymbolInfoInteger(packet.symbol, SYMBOL_SWAP_MODE, packet.swap_mode);
   packet.valid_swap_long = SymbolInfoDouble(packet.symbol, SYMBOL_SWAP_LONG, packet.swap_long);
   packet.valid_swap_short = SymbolInfoDouble(packet.symbol, SYMBOL_SWAP_SHORT, packet.swap_short);
   packet.valid_swap_monday = SymbolInfoDouble(packet.symbol, SYMBOL_SWAP_MONDAY, packet.swap_monday);
   packet.valid_swap_tuesday = SymbolInfoDouble(packet.symbol, SYMBOL_SWAP_TUESDAY, packet.swap_tuesday);
   packet.valid_swap_wednesday = SymbolInfoDouble(packet.symbol, SYMBOL_SWAP_WEDNESDAY, packet.swap_wednesday);
   packet.valid_swap_thursday = SymbolInfoDouble(packet.symbol, SYMBOL_SWAP_THURSDAY, packet.swap_thursday);
   packet.valid_swap_friday = SymbolInfoDouble(packet.symbol, SYMBOL_SWAP_FRIDAY, packet.swap_friday);
   if(packet.valid_swap_mode || packet.valid_swap_long || packet.valid_swap_short)
     {
      packet.swap_posture = "Ready";
      packet.swap_notes = "swap sourced from symbol properties";
     }

   packet.margin_mode = (long)AccountInfoInteger(ACCOUNT_MARGIN_MODE);
   packet.valid_margin_mode = true;
   packet.valid_margin_hedged = SymbolInfoDouble(packet.symbol, SYMBOL_MARGIN_HEDGED, packet.margin_hedged);
   packet.valid_buy_initial_margin = SymbolInfoDouble(packet.symbol, SYMBOL_MARGIN_INITIAL, packet.buy_initial_margin);
   packet.valid_buy_maintenance_margin = SymbolInfoDouble(packet.symbol, SYMBOL_MARGIN_MAINTENANCE, packet.buy_maintenance_margin);
   packet.valid_sell_initial_margin = SymbolInfoDouble(packet.symbol, SYMBOL_MARGIN_INITIAL, packet.sell_initial_margin);
   packet.valid_sell_maintenance_margin = SymbolInfoDouble(packet.symbol, SYMBOL_MARGIN_MAINTENANCE, packet.sell_maintenance_margin);
   double buy_init_rate = 0.0, buy_maint_rate = 0.0;
   if(SymbolInfoMarginRate(packet.symbol, ORDER_TYPE_BUY, buy_init_rate, buy_maint_rate))
     {
      if(buy_init_rate > 0.0)
        {
         packet.buy_initial_margin_rate = buy_init_rate;
         packet.valid_buy_initial_margin_rate = true;
        }
      if(buy_maint_rate > 0.0)
        {
         packet.buy_maintenance_margin_rate = buy_maint_rate;
         packet.valid_buy_maintenance_margin_rate = true;
        }
     }
   double sell_init_rate = 0.0, sell_maint_rate = 0.0;
   if(SymbolInfoMarginRate(packet.symbol, ORDER_TYPE_SELL, sell_init_rate, sell_maint_rate))
     {
      if(sell_init_rate > 0.0)
        {
         packet.sell_initial_margin_rate = sell_init_rate;
         packet.valid_sell_initial_margin_rate = true;
        }
      if(sell_maint_rate > 0.0)
        {
         packet.sell_maintenance_margin_rate = sell_maint_rate;
         packet.valid_sell_maintenance_margin_rate = true;
        }
     }

   bool directional_symbol_margin_exposed = (packet.valid_buy_initial_margin
                                             && packet.valid_sell_initial_margin
                                             && packet.valid_buy_maintenance_margin
                                             && packet.valid_sell_maintenance_margin);
   bool mirrored_symbol_margin = directional_symbol_margin_exposed
                                 && packet.buy_initial_margin == packet.sell_initial_margin
                                 && packet.buy_maintenance_margin == packet.sell_maintenance_margin;
   bool has_margin_rate_coefficients = (packet.valid_buy_initial_margin_rate
                                        || packet.valid_buy_maintenance_margin_rate
                                        || packet.valid_sell_initial_margin_rate
                                        || packet.valid_sell_maintenance_margin_rate);

   if(packet.valid_margin_mode || packet.valid_margin_hedged || packet.valid_buy_initial_margin || packet.valid_buy_maintenance_margin)
     {
      packet.margin_posture = "Ready";
      packet.margin_notes = "margin sourced from account mode + symbol margin properties";
      if(directional_symbol_margin_exposed)
        {
         if(mirrored_symbol_margin)
            packet.margin_notes += " | broker exposes mirrored symbol-level buy/sell values; directional split is unavailable";
         else
            packet.margin_notes += " | broker exposes directional buy/sell symbol-level margin values";
        }
      else
         packet.margin_notes += " | directional split is not fully exposed by symbol-level margin properties";

     if(has_margin_rate_coefficients)
        packet.margin_notes += " | per-order margin-rate coefficients are tracked separately and are not remapped into symbol-level per-lot margin display fields";
     }
  }

void ASC_L2RetainSlowFieldDouble(ASC_Layer2Packet &packet,bool &valid_field,double &value_field,const bool before_valid,const double before_value)
  {
   if(valid_field || !before_valid)
      return;
   valid_field = true;
   value_field = before_value;
   packet.specification_state_reason = "specification sticky retention reused previously verified slow field";
  }

void ASC_L2RetainSlowFieldLong(ASC_Layer2Packet &packet,bool &valid_field,long &value_field,const bool before_valid,const long before_value)
  {
   if(valid_field || !before_valid)
      return;
   valid_field = true;
   value_field = before_value;
   packet.specification_state_reason = "specification sticky retention reused previously verified slow field";
  }

void ASC_L2RetainSlowFieldString(ASC_Layer2Packet &packet,bool &valid_field,string &value_field,const bool before_valid,const string before_value)
  {
   if(valid_field || !before_valid)
      return;
   valid_field = true;
   value_field = before_value;
   packet.specification_state_reason = "specification sticky retention reused previously verified slow field";
  }

void ASC_L2ApplySlowStickyRetention(ASC_Layer2Packet &packet,const ASC_Layer2Packet &before_packet)
  {
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_contract_size, packet.contract_size, before_packet.valid_contract_size, before_packet.contract_size);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_volume_min, packet.volume_min, before_packet.valid_volume_min, before_packet.volume_min);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_volume_max, packet.volume_max, before_packet.valid_volume_max, before_packet.volume_max);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_volume_step, packet.volume_step, before_packet.valid_volume_step, before_packet.volume_step);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_tick_size, packet.tick_size, before_packet.valid_tick_size, before_packet.tick_size);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_tick_value, packet.tick_value, before_packet.valid_tick_value, before_packet.tick_value);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_stop_distance, packet.min_stop_distance, before_packet.valid_stop_distance, before_packet.min_stop_distance);
   ASC_L2RetainSlowFieldLong(packet, packet.valid_trade_mode, packet.trade_mode, before_packet.valid_trade_mode, before_packet.trade_mode);
   ASC_L2RetainSlowFieldLong(packet, packet.valid_execution_mode, packet.execution_mode, before_packet.valid_execution_mode, before_packet.execution_mode);
   ASC_L2RetainSlowFieldLong(packet, packet.valid_order_mode, packet.order_mode, before_packet.valid_order_mode, before_packet.order_mode);
   ASC_L2RetainSlowFieldString(packet, packet.valid_margin_currency, packet.margin_currency, before_packet.valid_margin_currency, before_packet.margin_currency);
   ASC_L2RetainSlowFieldString(packet, packet.valid_profit_currency, packet.profit_currency, before_packet.valid_profit_currency, before_packet.profit_currency);

   ASC_L2RetainSlowFieldString(packet, packet.valid_quote_session_status, packet.quote_session_status, before_packet.valid_quote_session_status, before_packet.quote_session_status);
   ASC_L2RetainSlowFieldString(packet, packet.valid_trade_session_status, packet.trade_session_status, before_packet.valid_trade_session_status, before_packet.trade_session_status);
   if(StringLen(packet.quote_session_hours) <= 0 || packet.quote_session_hours == "unavailable")
      packet.quote_session_hours = before_packet.quote_session_hours;
   if(StringLen(packet.trade_session_hours) <= 0 || packet.trade_session_hours == "unavailable")
      packet.trade_session_hours = before_packet.trade_session_hours;
   if(StringLen(packet.session_notes) <= 0 || packet.session_notes == "session unavailable")
      packet.session_notes = before_packet.session_notes;

   ASC_L2RetainSlowFieldLong(packet, packet.valid_swap_mode, packet.swap_mode, before_packet.valid_swap_mode, before_packet.swap_mode);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_swap_long, packet.swap_long, before_packet.valid_swap_long, before_packet.swap_long);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_swap_short, packet.swap_short, before_packet.valid_swap_short, before_packet.swap_short);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_swap_monday, packet.swap_monday, before_packet.valid_swap_monday, before_packet.swap_monday);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_swap_tuesday, packet.swap_tuesday, before_packet.valid_swap_tuesday, before_packet.swap_tuesday);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_swap_wednesday, packet.swap_wednesday, before_packet.valid_swap_wednesday, before_packet.swap_wednesday);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_swap_thursday, packet.swap_thursday, before_packet.valid_swap_thursday, before_packet.swap_thursday);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_swap_friday, packet.swap_friday, before_packet.valid_swap_friday, before_packet.swap_friday);
   if(packet.swap_posture == "Unavailable")
      packet.swap_posture = before_packet.swap_posture;
   if(packet.swap_notes == "swap unavailable")
      packet.swap_notes = before_packet.swap_notes;

   if(!packet.valid_margin_mode && before_packet.valid_margin_mode)
     {
      packet.valid_margin_mode = true;
      packet.margin_mode = before_packet.margin_mode;
     }
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_margin_hedged, packet.margin_hedged, before_packet.valid_margin_hedged, before_packet.margin_hedged);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_buy_initial_margin, packet.buy_initial_margin, before_packet.valid_buy_initial_margin, before_packet.buy_initial_margin);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_buy_maintenance_margin, packet.buy_maintenance_margin, before_packet.valid_buy_maintenance_margin, before_packet.buy_maintenance_margin);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_sell_initial_margin, packet.sell_initial_margin, before_packet.valid_sell_initial_margin, before_packet.sell_initial_margin);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_sell_maintenance_margin, packet.sell_maintenance_margin, before_packet.valid_sell_maintenance_margin, before_packet.sell_maintenance_margin);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_buy_initial_margin_rate, packet.buy_initial_margin_rate, before_packet.valid_buy_initial_margin_rate, before_packet.buy_initial_margin_rate);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_buy_maintenance_margin_rate, packet.buy_maintenance_margin_rate, before_packet.valid_buy_maintenance_margin_rate, before_packet.buy_maintenance_margin_rate);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_sell_initial_margin_rate, packet.sell_initial_margin_rate, before_packet.valid_sell_initial_margin_rate, before_packet.sell_initial_margin_rate);
   ASC_L2RetainSlowFieldDouble(packet, packet.valid_sell_maintenance_margin_rate, packet.sell_maintenance_margin_rate, before_packet.valid_sell_maintenance_margin_rate, before_packet.sell_maintenance_margin_rate);
   if(packet.margin_posture == "Unavailable")
      packet.margin_posture = before_packet.margin_posture;
   if(packet.margin_notes == "margin unavailable")
      packet.margin_notes = before_packet.margin_notes;

   packet.has_specification = (packet.valid_contract_size
                               || packet.valid_volume_min
                               || packet.valid_volume_max
                               || packet.valid_volume_step
                               || packet.valid_tick_size
                               || packet.valid_tick_value
                               || packet.valid_stop_distance
                               || packet.valid_freeze_distance
                               || packet.valid_trade_mode
                               || packet.valid_execution_mode
                               || packet.valid_calculation_mode
                               || packet.valid_filling_mode
                               || packet.valid_expiration_mode
                               || packet.valid_gtc_mode
                               || packet.valid_order_mode
                               || packet.valid_spread_type
                               || packet.valid_margin_currency
                               || packet.valid_profit_currency);
  }

void ASC_L2FinalizeStickySlowPosture(ASC_Layer2Packet &packet)
  {
   if(packet.valid_quote_session_status || packet.valid_trade_session_status)
      packet.session_notes = "session schedule sourced from symbol session owner (sticky retained when needed)";

   if(packet.valid_swap_mode || packet.valid_swap_long || packet.valid_swap_short)
     {
      packet.swap_posture = "Ready";
      if(packet.swap_notes == "swap unavailable")
         packet.swap_notes = "swap sourced from symbol properties (sticky retained when needed)";
     }

   if(packet.valid_margin_mode || packet.valid_margin_hedged || packet.valid_buy_initial_margin || packet.valid_buy_maintenance_margin)
     {
      packet.margin_posture = "Ready";
      if(packet.margin_notes == "margin unavailable")
         packet.margin_notes = "margin sourced from account mode + symbol margin properties (sticky retained when needed)";
     }
  }

void ASC_L2EvaluateSpecification(ASC_Layer2Packet &packet,const datetime now_utc)
  {
   ASC_Layer2Packet before_slow = packet;
   bool slow_completion_pending = ASC_L2SlowCompletionPending(packet);
   bool spec_due = (packet.spec_next_due_utc <= 0 || packet.spec_next_due_utc <= now_utc || slow_completion_pending);
   if(!spec_due)
     {
      if(packet.spec_last_built_utc > 0)
         packet.spec_age_sec = (int)MathMax(0, now_utc - packet.spec_last_built_utc);
      packet.spec_is_stale = (packet.spec_age_sec > ASC_L2_SPEC_STALE_AGE_SEC);
      packet.spec_is_degraded = (packet.spec_age_sec > ASC_L2_SPEC_DEGRADED_AGE_SEC);
      if(packet.slow_hard_absence_confirmed)
         packet.specification_state_reason = "specification hard-absence confirmed: owner does not expose all required slow fields";
      else if(ASC_L2SlowCompletionPending(packet))
         packet.specification_state_reason = "specification bootstrap incomplete: awaiting required slow fields";
      else if(!packet.has_specification)
         packet.specification_state_reason = "specification unavailable: required trading-condition fields are missing";
      else if(packet.spec_is_degraded)
         packet.specification_state_reason = "specification degraded: cached values are beyond degraded age";
      else if(packet.spec_is_stale)
         packet.specification_state_reason = "specification stale: cached values are aging toward refresh";
      else
         packet.specification_state_reason = "specification cached from symbol specification owner";
      ASC_L2FinalizeSessionsSwapMarginPacket(packet);
      ASC_L2ApplySlowStickyRetention(packet, before_slow);
      ASC_L2FinalizeStickySlowPosture(packet);
      ASC_L2FinalizeSpecificationPacket(packet);
      return;
     }

   ASC_SymbolSpecification spec;
   bool spec_loaded = ASC_GetSymbolSpecification(packet.symbol, spec, true);

   packet.valid_contract_size = (spec_loaded && spec.has_contract_size && spec.contract_size > 0.0);
   if(packet.valid_contract_size)
      packet.contract_size = spec.contract_size;

   packet.valid_volume_min = (spec_loaded && spec.has_volume_min && spec.volume_min > 0.0);
   if(packet.valid_volume_min)
      packet.volume_min = spec.volume_min;

   packet.valid_volume_max = (spec_loaded && spec.has_volume_max && spec.volume_max > 0.0);
   if(packet.valid_volume_max)
      packet.volume_max = spec.volume_max;

   packet.valid_volume_step = (spec_loaded && spec.has_volume_step && spec.volume_step > 0.0);
   if(packet.valid_volume_step)
      packet.volume_step = spec.volume_step;

   packet.valid_tick_size = (spec_loaded && spec.has_tick_size && spec.tick_size > 0.0);
   if(packet.valid_tick_size)
      packet.tick_size = spec.tick_size;

   packet.valid_tick_value = (spec_loaded && spec.has_tick_value && spec.tick_value > 0.0);
   if(packet.valid_tick_value)
      packet.tick_value = spec.tick_value;

   double point_value = packet.point;
   if(spec_loaded && spec.has_point && spec.point > 0.0)
      point_value = spec.point;
   if(point_value > 0.0)
      packet.point = point_value;

   if(spec_loaded && spec.has_digits && spec.digits > 0)
      packet.digits = (int)spec.digits;

   packet.valid_stop_distance = (spec_loaded && spec.has_stop_distance_points && point_value > 0.0 && spec.stop_distance_points >= 0);
   if(packet.valid_stop_distance)
      packet.min_stop_distance = spec.stop_distance_points * point_value;

   packet.valid_trade_mode = (spec_loaded && spec.has_trade_mode);
   if(packet.valid_trade_mode)
      packet.trade_mode = spec.trade_mode;

   packet.valid_execution_mode = (spec_loaded && spec.has_execution_mode);
   if(packet.valid_execution_mode)
      packet.execution_mode = spec.execution_mode;

   packet.valid_calculation_mode = (spec_loaded && spec.has_calculation_mode);
   if(packet.valid_calculation_mode)
      packet.calculation_mode = spec.calculation_mode;

   packet.valid_filling_mode = (spec_loaded && spec.has_filling_mode);
   if(packet.valid_filling_mode)
      packet.filling_mode = spec.filling_mode;

   packet.valid_expiration_mode = (spec_loaded && spec.has_expiration_mode);
   if(packet.valid_expiration_mode)
      packet.expiration_mode = spec.expiration_mode;

   long gtc_mode_value = 0;
   packet.valid_gtc_mode = SymbolInfoInteger(packet.symbol, SYMBOL_ORDER_GTC_MODE, gtc_mode_value);
   if(packet.valid_gtc_mode)
      packet.gtc_mode = gtc_mode_value;

   packet.valid_order_mode = (spec_loaded && spec.has_order_mode);
   if(packet.valid_order_mode)
      packet.order_mode = spec.order_mode;

   packet.valid_spread_type = (spec_loaded && spec.has_spread_float_mode);
   if(packet.valid_spread_type)
      packet.spread_type_mode = spec.spread_float_mode;

   packet.valid_freeze_distance = (spec_loaded && spec.has_freeze_distance_points && point_value > 0.0 && spec.freeze_distance_points >= 0);
   if(packet.valid_freeze_distance)
      packet.freeze_distance = spec.freeze_distance_points * point_value;

   packet.valid_margin_currency = (spec_loaded && spec.has_margin_currency && StringLen(spec.margin_currency) > 0);
   if(packet.valid_margin_currency)
      packet.margin_currency = spec.margin_currency;

   packet.valid_profit_currency = (spec_loaded && spec.has_profit_currency && StringLen(spec.profit_currency) > 0);
   if(packet.valid_profit_currency)
      packet.profit_currency = spec.profit_currency;

   packet.has_specification = (packet.valid_contract_size
                               || packet.valid_volume_min
                               || packet.valid_volume_max
                               || packet.valid_volume_step
                               || packet.valid_tick_size
                               || packet.valid_tick_value
                               || packet.valid_stop_distance
                               || packet.valid_freeze_distance
                               || packet.valid_trade_mode
                               || packet.valid_execution_mode
                               || packet.valid_calculation_mode
                               || packet.valid_filling_mode
                               || packet.valid_expiration_mode
                               || packet.valid_gtc_mode
                               || packet.valid_order_mode
                               || packet.valid_spread_type
                               || packet.valid_margin_currency
                               || packet.valid_profit_currency);
   packet.spec_last_built_utc = now_utc;
   packet.spec_age_sec = 0;
   packet.spec_is_stale = false;
   packet.spec_is_degraded = !packet.has_specification;
   if(packet.has_specification)
     {
      packet.spec_next_due_utc = now_utc + ASC_L2_SPEC_RECHECK_SEC;
      packet.spec_next_due_reason = "specification-maintenance";
      packet.specification_state_reason = "specification refreshed from symbol specification owner";
     }
   else if(spec_loaded)
     {
      packet.spec_next_due_utc = now_utc + ASC_L2_RECHECK_REPAIR_SEC;
      packet.spec_next_due_reason = "specification-field-retry";
      packet.specification_state_reason = "specification unavailable: required trading-condition fields were not supplied";
     }
   else
     {
      packet.spec_next_due_utc = now_utc + ASC_L2_RECHECK_REPAIR_SEC;
      packet.spec_next_due_reason = "specification-read-retry";
      packet.specification_state_reason = "specification owner read failed";
     }
   ASC_L2FinalizeSessionsSwapMarginPacket(packet);
   ASC_L2ApplySlowStickyRetention(packet, before_slow);
   ASC_L2FinalizeStickySlowPosture(packet);

   bool slow_pending_after = ASC_L2SlowCompletionPending(packet);
   if(slow_pending_after)
     {
      packet.slow_completion_retry_count++;
      bool hard_absence_confirmed = (packet.slow_completion_retry_count >= ASC_L2_SLOW_BOOTSTRAP_RETRY_CAP
                                     && spec_loaded);
      packet.slow_hard_absence_confirmed = hard_absence_confirmed;
      if(hard_absence_confirmed)
        {
         packet.spec_next_due_utc = now_utc + ASC_L2_SPEC_RECHECK_SEC;
         packet.spec_next_due_reason = "specification-hard-absence-maintenance";
         packet.specification_state_reason = "specification partially unavailable: owner/API does not expose all required slow fields";
        }
      else
        {
         packet.spec_next_due_utc = now_utc + ASC_L2_RECHECK_REPAIR_SEC;
         packet.spec_next_due_reason = "specification-bootstrap-retry";
         packet.specification_state_reason = "specification bootstrap incomplete: retrying required slow fields";
        }
     }
   else
     {
      packet.slow_completion_retry_count = 0;
      packet.slow_hard_absence_confirmed = false;
      packet.specification_state_reason = (packet.specification_state_reason == "specification sticky retention reused previously verified slow field")
                                          ? "specification sticky retention maintained required slow fields"
                                          : packet.specification_state_reason;
     }

   packet.spec_is_degraded = slow_pending_after && !packet.slow_hard_absence_confirmed;
   ASC_L2FinalizeSpecificationPacket(packet);
  }

void ASC_L2FinalizeQuoteSnapshotPacket(ASC_Layer2Packet &packet,const datetime now_utc)
  {
   packet.quote_observed_utc = now_utc;
   packet.freshness_posture = ASC_L2FreshnessToText(packet.freshness);
   packet.continuity_posture = packet.continuity_backed ? "Continuity-backed" : "Live";

   packet.last_price = 0.0;
   packet.spread_abs = 0.0;
   packet.spread_pct = 0.0;
   packet.valid_last_price = false;
   packet.valid_spread_pct = false;

   if(packet.has_packet && !packet.continuity_backed && packet.valid_bid && packet.valid_ask && packet.valid_spread && packet.point > 0.0)
     {
      packet.last_price = (packet.bid + packet.ask) * 0.5;
      packet.spread_abs = packet.spread_points * packet.point;
      packet.valid_last_price = true;
      if(packet.bid > 0.0)
        {
         packet.spread_pct = (packet.spread_abs / packet.bid) * 100.0;
         packet.valid_spread_pct = true;
        }
      packet.quote_posture = "live";
     }
   else if(packet.has_packet && packet.continuity_backed)
      packet.quote_posture = "continuity-backed";
   else
     {
      packet.quote_posture = "unavailable";
      packet.continuity_posture = "Unavailable";
     }
  }

void ASC_L2FinalizeDayStructurePacket(ASC_Layer2Packet &packet)
  {
   packet.daily_change_pct = 0.0;
   packet.day_range_position_pct = 0.0;
   packet.valid_daily_change_pct = false;
   packet.valid_day_range_position = false;
   packet.day_direction_snapshot = "Unavailable";
   packet.day_price_action_snapshot = "Unavailable";
   packet.day_structure_posture = "pending";
   packet.day_structure_reason = "day_structure_pending_inputs";

   if(!packet.valid_day_range || packet.day_high < packet.day_low)
     {
      if(packet.quote_posture == "continuity-backed")
         packet.day_structure_reason = "continuity-backed quote without lawful day range";
      return;
     }

   packet.day_structure_posture = "ready";
   packet.day_structure_reason = "derived from Layer-2 day-open/high/low snapshot";

   double reference_price = 0.0;
   if(packet.valid_bid && packet.bid > 0.0)
      reference_price = packet.bid;
   else
     {
      double day_close_value = iClose(packet.symbol, PERIOD_D1, 0);
      if(day_close_value > 0.0)
         reference_price = day_close_value;
     }

   if(packet.valid_day_open && packet.day_open > 0.0 && reference_price > 0.0)
     {
      packet.daily_change_pct = ((reference_price - packet.day_open) / packet.day_open) * 100.0;
      packet.valid_daily_change_pct = true;
      if(packet.daily_change_pct > 0.05)
         packet.day_direction_snapshot = "Up from daily open";
      else if(packet.daily_change_pct < -0.05)
         packet.day_direction_snapshot = "Down from daily open";
      else
         packet.day_direction_snapshot = "Flat vs daily open";
     }

   if(packet.day_range_points > 0.0 && reference_price > 0.0)
     {
      double raw_position = ((reference_price - packet.day_low) / packet.day_range_points) * 100.0;
      packet.day_range_position_pct = MathMax(0.0, MathMin(100.0, raw_position));
      packet.valid_day_range_position = true;
      if(packet.day_range_position_pct >= 90.0)
         packet.day_price_action_snapshot = "Upper extreme";
      else if(packet.day_range_position_pct >= 67.5)
         packet.day_price_action_snapshot = "Upper range";
      else if(packet.day_range_position_pct <= 10.0)
         packet.day_price_action_snapshot = "Lower extreme";
      else if(packet.day_range_position_pct <= 32.5)
         packet.day_price_action_snapshot = "Lower range";
      else
         packet.day_price_action_snapshot = "Mid range";
     }
  }

void ASC_L2FinalizeVolatilityLiquidityPacket(ASC_Layer2Packet &packet)
  {
   packet.atr_points = 0.0;
   packet.atr_pct = 0.0;
   packet.spread_to_atr = 0.0;
   packet.valid_atr_points = false;
   packet.valid_atr_pct = false;
   packet.valid_spread_to_atr = false;
   packet.volatility_state = "Pending";
   packet.friction_state = "Pending";
   packet.liquidity_state = "Pending";
   packet.volatility_liquidity_reason = "volatility_liquidity_pending_inputs";

   int atr_bars_used = 0;
   double atr_points = 0.0;
   const int atr_period = 14;
   MqlRates rates[];
   int required_bars = atr_period + 1;
   int copied = CopyRates(packet.symbol, PERIOD_D1, 0, required_bars, rates);
   if(copied >= required_bars && packet.point > 0.0)
     {
      double tr_sum = 0.0;
      int samples = 0;
      for(int i = 0; i < atr_period; i++)
        {
         double high_price = rates[i].high;
         double low_price = rates[i].low;
         double prev_close = rates[i + 1].close;
         if(high_price <= 0.0 || low_price <= 0.0 || prev_close <= 0.0)
            continue;

         double range_hl = high_price - low_price;
         double range_hc = MathAbs(high_price - prev_close);
         double range_lc = MathAbs(low_price - prev_close);
         double true_range = MathMax(range_hl, MathMax(range_hc, range_lc));
         if(true_range <= 0.0)
            continue;
         tr_sum += true_range;
         samples++;
        }
      atr_bars_used = samples;
      if(samples >= atr_period)
         atr_points = (tr_sum / samples) / packet.point;
     }

   if(atr_points > 0.0)
     {
      packet.atr_points = atr_points;
      packet.valid_atr_points = true;
     }
   else if(packet.valid_day_range && packet.day_range_points > 0.0 && packet.freshness == ASC_L2_FRESH)
     {
      packet.atr_points = packet.day_range_points;
      packet.valid_atr_points = true;
      atr_bars_used = 1;
     }
   double reference_price = 0.0;
   if(packet.valid_bid && packet.bid > 0.0)
      reference_price = packet.bid;
   else if(packet.valid_day_open && packet.day_open > 0.0)
      reference_price = packet.day_open;
   else if(packet.valid_day_range && packet.day_high > 0.0 && packet.day_low > 0.0)
      reference_price = (packet.day_high + packet.day_low) * 0.5;

   if(packet.valid_atr_points && packet.point > 0.0 && reference_price > 0.0)
     {
      packet.atr_pct = ((packet.atr_points * packet.point) / reference_price) * 100.0;
      packet.valid_atr_pct = (packet.atr_pct > 0.0);
     }
   if(packet.valid_atr_points && packet.valid_spread && packet.atr_points > 0.0)
     {
      packet.spread_to_atr = packet.spread_points / packet.atr_points;
      packet.valid_spread_to_atr = (packet.spread_to_atr >= 0.0);
     }

   if(packet.freshness == ASC_L2_CONTINUITY || packet.freshness == ASC_L2_STALE || packet.freshness == ASC_L2_DEGRADED)
      packet.volatility_state = "Guarded";
   else if(packet.valid_atr_pct && packet.atr_pct >= 1.00)
      packet.volatility_state = "Expansion";
   else if(packet.valid_atr_pct && packet.atr_pct <= 0.20)
      packet.volatility_state = "Compression";
   else if(packet.valid_atr_pct)
      packet.volatility_state = "Balanced";

   double spread_pct = packet.valid_spread_pct ? packet.spread_pct : -1.0;
   if(spread_pct < 0.0 && packet.valid_spread && reference_price > 0.0 && packet.point > 0.0)
      spread_pct = ((packet.spread_points * packet.point) / reference_price) * 100.0;
   if(spread_pct >= 0.0)
     {
      if(packet.valid_spread_to_atr)
        {
         if(spread_pct <= 0.060 && packet.spread_to_atr <= 0.35)
           {
            packet.friction_state = "Controlled";
            packet.liquidity_state = "Strong";
           }
         else if(spread_pct <= 0.150 && packet.spread_to_atr <= 0.75)
           {
            packet.friction_state = "Elevated";
            packet.liquidity_state = "Moderate";
           }
         else
           {
            packet.friction_state = "High";
            packet.liquidity_state = "Weak";
           }
        }
      else
        {
         packet.friction_state = (spread_pct <= 0.080) ? "Controlled" : "Elevated";
         packet.liquidity_state = (spread_pct <= 0.060) ? "Strong" : (spread_pct <= 0.150 ? "Moderate" : "Weak");
        }
     }

   if(packet.valid_atr_points && atr_bars_used >= atr_period)
      packet.volatility_liquidity_reason = "derived from Layer-2 daily ATR(14) and spread posture";
   else if(packet.valid_atr_points)
      packet.volatility_liquidity_reason = "derived from fresh day-range fallback ATR proxy and spread posture";
   else
      packet.volatility_liquidity_reason = "atr_not_ready_pending_inputs";
  }

void ASC_L2ApplyLiveAnalyticStickyRetention(ASC_Layer2Packet &packet,const ASC_Layer2Packet &before_packet,const datetime now_utc)
  {
   if(!packet.has_last_good || before_packet.last_good_utc <= 0)
      return;

   int sticky_max_age = MathMax(1, ASC_L2_LIVE_ANALYTIC_STICKY_MAX_AGE_SEC);
   int seconds_since_last_good = (int)MathMax(0, now_utc - before_packet.last_good_utc);
   if(seconds_since_last_good > sticky_max_age)
      return;

   bool retained_day = false;
   if(!packet.valid_day_open && before_packet.valid_day_open)
     {
      packet.valid_day_open = true;
      packet.day_open = before_packet.day_open;
      retained_day = true;
     }
   if(!packet.valid_day_range && before_packet.valid_day_range)
     {
      packet.valid_day_range = true;
      packet.day_high = before_packet.day_high;
      packet.day_low = before_packet.day_low;
      packet.day_range_points = before_packet.day_range_points;
      packet.day_range_pct = before_packet.day_range_pct;
      retained_day = true;
     }
   if(!packet.valid_daily_change_pct && before_packet.valid_daily_change_pct)
     {
      packet.valid_daily_change_pct = true;
      packet.daily_change_pct = before_packet.daily_change_pct;
      retained_day = true;
     }
   if(!packet.valid_day_range_position && before_packet.valid_day_range_position)
     {
      packet.valid_day_range_position = true;
      packet.day_range_position_pct = before_packet.day_range_position_pct;
      retained_day = true;
     }
   if(packet.day_direction_snapshot == "Unavailable")
      packet.day_direction_snapshot = before_packet.day_direction_snapshot;
   if(packet.day_price_action_snapshot == "Unavailable")
      packet.day_price_action_snapshot = before_packet.day_price_action_snapshot;
   if(retained_day)
     {
      packet.day_structure_posture = "ready";
      packet.day_structure_reason = "day_structure_sticky_retained_last_good";
     }

   bool retained_atr = false;
   if(!packet.valid_atr_points && before_packet.valid_atr_points)
     {
      packet.valid_atr_points = true;
      packet.atr_points = before_packet.atr_points;
      retained_atr = true;
     }
   if(!packet.valid_atr_pct && before_packet.valid_atr_pct)
     {
      packet.valid_atr_pct = true;
      packet.atr_pct = before_packet.atr_pct;
      retained_atr = true;
     }
   if(!packet.valid_spread_to_atr && before_packet.valid_spread_to_atr)
     {
      packet.valid_spread_to_atr = true;
      packet.spread_to_atr = before_packet.spread_to_atr;
      retained_atr = true;
     }

   if(packet.volatility_state == "Pending" && before_packet.volatility_state != "Unavailable")
      packet.volatility_state = before_packet.volatility_state;
   if(packet.friction_state == "Pending" && before_packet.friction_state != "Unavailable")
      packet.friction_state = before_packet.friction_state;
   if(packet.liquidity_state == "Pending" && before_packet.liquidity_state != "Unavailable")
      packet.liquidity_state = before_packet.liquidity_state;
   if(retained_atr)
      packet.volatility_liquidity_reason = "atr_sticky_retained_last_good";
  }

void ASC_L2EvaluatePacket(ASC_Layer2Packet &packet,const datetime now_utc,const int admitted_symbols)
  {
   ASC_Layer2Packet before_packet = packet;

   long digits_value = 0;
   long trade_mode_value = 0;
   double point_value = 0.0;
   double bid_value = 0.0;
   double ask_value = 0.0;
   double day_open_value = 0.0;
   double day_high_value = 0.0;
   double day_low_value = 0.0;
   long quote_time_raw = 0;

   bool has_digits = SymbolInfoInteger(packet.symbol, SYMBOL_DIGITS, digits_value);
   bool has_trade_mode = SymbolInfoInteger(packet.symbol, SYMBOL_TRADE_MODE, trade_mode_value);
   bool has_point = false;
   bool has_bid = false;
   bool has_ask = false;
   day_open_value = iOpen(packet.symbol, PERIOD_D1, 0);
   bool has_day_open = (day_open_value > 0.0);
   bool has_day_high = SymbolInfoDouble(packet.symbol, SYMBOL_BIDHIGH, day_high_value);
   bool has_day_low = SymbolInfoDouble(packet.symbol, SYMBOL_BIDLOW, day_low_value);
   if((!has_day_high || day_high_value <= 0.0))
     {
      double bar_day_high = iHigh(packet.symbol, PERIOD_D1, 0);
      if(bar_day_high > 0.0)
        {
         day_high_value = bar_day_high;
         has_day_high = true;
        }
     }
   if((!has_day_low || day_low_value <= 0.0))
     {
      double bar_day_low = iLow(packet.symbol, PERIOD_D1, 0);
      if(bar_day_low > 0.0)
        {
         day_low_value = bar_day_low;
         has_day_low = true;
        }
     }
   bool has_quote_time = false;
   bool quote_tick_success = false;
   int quote_tick_last_error = 0;
   bool quote_symbol_selected = false;
   bool quote_symbol_synchronized = false;

   int micro_retry_attempts = 0;
   int micro_retry_elapsed_ms = 0;
   bool has_price = ASC_L2TryReadLiveQuoteWithMicroRetry(packet.symbol,
                                                          now_utc,
                                                          point_value,
                                                          bid_value,
                                                          ask_value,
                                                          quote_time_raw,
                                                          has_point,
                                                          has_bid,
                                                          has_ask,
                                                          has_quote_time,
                                                          quote_tick_success,
                                                          quote_tick_last_error,
                                                          quote_symbol_selected,
                                                          quote_symbol_synchronized,
                                                          micro_retry_attempts,
                                                          micro_retry_elapsed_ms);
   packet.live_quote_micro_retry_attempts = micro_retry_attempts;
   packet.live_quote_micro_retry_elapsed_ms = micro_retry_elapsed_ms;
   packet.quote_unavailable_tick_success = quote_tick_success;
   packet.quote_unavailable_tick_last_error = quote_tick_last_error;
   packet.quote_unavailable_symbol_select_state = quote_symbol_selected;
   packet.quote_unavailable_symbol_sync_state = quote_symbol_synchronized;
   packet.quote_unavailable_owner = "ASC_OpenSymbolSnapshotEngine";
   packet.quote_unavailable_reason = "pending_quote_evaluation";
   packet.top5_quote_hydration_source = "ASC_OpenSymbolSnapshotEngine/SymbolInfoTick+SymbolInfoDouble";

   datetime quote_clock_now = TimeCurrent();
   if(quote_clock_now <= 0)
      quote_clock_now = now_utc;

   int packet_age_sec = ASC_L2_DEGRADED_AGE_SEC + 1;
   bool quote_clock_aligned = true;
   if(has_quote_time && quote_time_raw > 0)
     {
      packet_age_sec = (int)(quote_clock_now - (datetime)quote_time_raw);
      if(packet_age_sec < 0)
        {
         quote_clock_aligned = false;
         packet_age_sec = ASC_L2_DEGRADED_AGE_SEC + 1;
        }
     }
   else if(packet.has_last_good && packet.last_good_utc > 0)
     {
      packet_age_sec = (int)(now_utc - packet.last_good_utc);
      if(packet_age_sec < 0)
         packet_age_sec = ASC_L2_DEGRADED_AGE_SEC + 1;
     }

   packet.packet_age_sec = packet_age_sec;
   packet.digits = has_digits ? (int)digits_value : packet.digits;
   packet.trade_mode = has_trade_mode ? trade_mode_value : packet.trade_mode;
   packet.point = has_point ? point_value : packet.point;

   if(has_price && quote_clock_aligned)
     {
      packet.bid = bid_value;
      packet.ask = ask_value;
      packet.spread_points = (ask_value - bid_value) / point_value;
      packet.valid_bid = true;
      packet.valid_ask = true;
      packet.valid_spread = (packet.spread_points >= 0.0);
      packet.valid_tick_time = true;
      datetime projected_tick_utc = now_utc;
      if(packet_age_sec > 0 && now_utc > (datetime)packet_age_sec)
         projected_tick_utc = (datetime)(now_utc - packet_age_sec);
      packet.tick_time_utc = projected_tick_utc;
      packet.has_packet = true;
      packet.has_last_good = true;
      packet.last_good_utc = now_utc;
      packet.last_built_utc = now_utc;
      packet.continuity_backed = false;
      packet.quote_unavailable_owner = "none";
      packet.quote_unavailable_reason = "quote_available";
      packet.market_watch_state_reason = (micro_retry_attempts > 1)
                                         ? StringFormat("live quote observed after micro-retry attempts=%d elapsed_ms=%d",
                                                        micro_retry_attempts,
                                                        micro_retry_elapsed_ms)
                                         : "live quote observed";
      if(packet_age_sec <= ASC_L2_FRESH_AGE_SEC)
         packet.freshness = ASC_L2_FRESH;
      else if(packet_age_sec <= ASC_L2_AGING_AGE_SEC)
         packet.freshness = ASC_L2_AGING;
      else if(packet_age_sec <= ASC_L2_STALE_AGE_SEC)
         packet.freshness = ASC_L2_STALE;
      else
         packet.freshness = ASC_L2_DEGRADED;
      packet.is_stale = (packet.freshness == ASC_L2_STALE || packet.freshness == ASC_L2_DEGRADED);
      packet.is_degraded = (packet.freshness == ASC_L2_DEGRADED);
     }
   else
     {
      packet.has_packet = packet.has_last_good;
      packet.continuity_backed = packet.has_last_good;
      if(!quote_clock_aligned)
         packet.market_watch_state_reason = "quote timestamp is ahead of the server clock; live quote withheld until clock-aligned refresh";
      packet.valid_bid = false;
      packet.valid_ask = false;
      packet.valid_spread = false;
      packet.valid_tick_time = false;
      if(!packet.has_last_good)
         packet.tick_time_utc = 0;
      packet.valid_day_range = false;
      packet.valid_day_open = false;
      packet.day_open = 0.0;
      packet.freshness = packet.has_last_good ? ASC_L2_CONTINUITY : ASC_L2_DEGRADED;
      packet.is_stale = true;
      packet.is_degraded = true;
      packet.last_built_utc = now_utc;
      if(!quote_symbol_selected)
         packet.quote_unavailable_reason = "symbol_not_selected_in_market_watch";
      else if(!quote_symbol_synchronized)
         packet.quote_unavailable_reason = "symbol_not_synchronized";
      else if(!quote_tick_success)
         packet.quote_unavailable_reason = "symbolinfotick_failed_error_" + IntegerToString(quote_tick_last_error);
      else if(!has_point || point_value <= 0.0)
         packet.quote_unavailable_reason = "symbol_point_unavailable";
      else if(!has_bid || bid_value <= 0.0)
         packet.quote_unavailable_reason = "bid_unavailable";
      else if(!has_ask || ask_value <= 0.0)
         packet.quote_unavailable_reason = "ask_unavailable";
      else if(!has_quote_time || quote_time_raw <= 0)
         packet.quote_unavailable_reason = "tick_time_unavailable";
      else if(!quote_clock_aligned)
         packet.quote_unavailable_reason = "quote_timestamp_ahead_of_server_clock";
      else if(ask_value < bid_value)
         packet.quote_unavailable_reason = "ask_below_bid_invalid_quote";
      else
         packet.quote_unavailable_reason = "live_quote_unavailable_after_micro_retry";

      if(packet.has_last_good)
         packet.market_watch_state_reason = StringFormat("continuity-backed from last good quote after micro-retry attempts=%d elapsed_ms=%d owner=%s reason=%s",
                                                         micro_retry_attempts,
                                                         micro_retry_elapsed_ms,
                                                         packet.quote_unavailable_owner,
                                                         packet.quote_unavailable_reason);
      else
         packet.market_watch_state_reason = StringFormat("live quote unavailable after micro-retry attempts=%d elapsed_ms=%d owner=%s reason=%s",
                                                         micro_retry_attempts,
                                                         micro_retry_elapsed_ms,
                                                         packet.quote_unavailable_owner,
                                                         packet.quote_unavailable_reason);
     }

   packet.valid_day_open = (has_day_open && day_open_value > 0.0);
   packet.day_open = packet.valid_day_open ? day_open_value : 0.0;
   bool has_valid_day_range = (has_day_high && has_day_low && day_high_value > 0.0 && day_low_value > 0.0 && day_high_value >= day_low_value);
   packet.valid_day_range = has_valid_day_range;
   if(has_valid_day_range)
     {
      packet.day_high = day_high_value;
      packet.day_low = day_low_value;
      packet.day_range_points = MathMax(0.0, packet.day_high - packet.day_low);
      double day_range_price_base = packet.valid_bid ? packet.bid : (packet.day_open > 0.0 ? packet.day_open : packet.day_high);
      packet.day_range_pct = (day_range_price_base > 0.0) ? (packet.day_range_points / day_range_price_base) * 100.0 : 0.0;
     }
   else
     {
      packet.day_high = 0.0;
      packet.day_low = 0.0;
      packet.day_range_points = 0.0;
      packet.day_range_pct = 0.0;
     }

   ASC_L2FinalizeQuoteSnapshotPacket(packet, now_utc);
   ASC_L2FinalizeDayStructurePacket(packet);
   ASC_L2FinalizeVolatilityLiquidityPacket(packet);
   ASC_L2ApplyLiveAnalyticStickyRetention(packet, before_packet, now_utc);
   ASC_L2ApplyCadence(packet, now_utc, admitted_symbols);
   packet.quote_unavailable_next_check_utc = packet.next_due_utc;
   ASC_L2EvaluateSpecification(packet, now_utc);
   ASC_L2FinalizeHydrationObservability(packet, now_utc);
   packet.changed_fields = ASC_L2ChangedFieldSubset(before_packet, packet);

   if(ASC_L2MaterialChanged(before_packet, packet))
     {
      g_asc_l2_revision++;
      packet.revision = g_asc_l2_revision;
      g_asc_l2_last_changed_symbols++;
     }
  }

void ASC_L2RebuildSummary(const datetime now_utc)
  {
   ASC_Layer2Summary summary;
   summary.pass_utc = now_utc;
   summary.tracked_symbols = ArraySize(g_asc_l2_cache);
   summary.admitted_symbols = 0;
   summary.tactical_symbols = 0;
   summary.due_symbols = 0;
   summary.fresh_count = 0;
   summary.aging_count = 0;
   summary.stale_count = 0;
   summary.degraded_count = 0;
   summary.continuity_count = 0;
   summary.spec_ready_count = 0;
   summary.spec_stale_count = 0;
   summary.spec_degraded_count = 0;
   summary.spec_due_count = 0;
   summary.hydration_ready_count = 0;
   summary.hydration_slow_incomplete_count = 0;
   summary.hydration_live_quote_incomplete_count = 0;
   summary.hydration_live_analytic_incomplete_count = 0;
   summary.hydration_blocked_warmup_count = 0;
   summary.hydration_blocked_post_warmup_repair_queue_count = 0;
   summary.next_due_utc = 0;
   summary.next_due_reason = "open-subset-maintenance";
   summary.next_due_count = 0;
   summary.has_structural_delta = (g_asc_l2_last_changed_symbols > 0);
   summary.latest_revision = g_asc_l2_revision;

   for(int i = 0; i < ArraySize(g_asc_l2_cache); i++)
     {
      ASC_Layer2Packet packet = g_asc_l2_cache[i];
      if(!packet.admitted && !packet.tactical_only)
         continue;

      if(packet.admitted)
         summary.admitted_symbols++;
      if(packet.tactical_only)
         summary.tactical_symbols++;

      if(packet.next_due_utc <= 0 || packet.next_due_utc <= now_utc)
         summary.due_symbols++;

      switch(packet.freshness)
        {
         case ASC_L2_FRESH:      summary.fresh_count++; break;
         case ASC_L2_AGING:      summary.aging_count++; break;
         case ASC_L2_STALE:      summary.stale_count++; break;
         case ASC_L2_DEGRADED:   summary.degraded_count++; break;
         case ASC_L2_CONTINUITY: summary.continuity_count++; break;
        }

      if(packet.has_specification && !packet.spec_is_stale && !packet.spec_is_degraded)
         summary.spec_ready_count++;
      else if(packet.spec_is_degraded)
         summary.spec_degraded_count++;
      else
         summary.spec_stale_count++;

      if(packet.spec_next_due_utc <= 0 || packet.spec_next_due_utc <= now_utc)
         summary.spec_due_count++;

      switch(packet.hydration_family)
        {
         case ASC_L2_HYDRATION_READY: summary.hydration_ready_count++; break;
         case ASC_L2_HYDRATION_SLOW_INCOMPLETE: summary.hydration_slow_incomplete_count++; break;
         case ASC_L2_HYDRATION_LIVE_QUOTE_INCOMPLETE: summary.hydration_live_quote_incomplete_count++; break;
         case ASC_L2_HYDRATION_LIVE_ANALYTIC_INCOMPLETE: summary.hydration_live_analytic_incomplete_count++; break;
        }

      if(packet.hydration_gate_code == "blocked_by_warmup")
         summary.hydration_blocked_warmup_count++;
      else if(packet.hydration_gate_code == "blocked_by_post_warmup_repair_queue")
         summary.hydration_blocked_post_warmup_repair_queue_count++;

      if(packet.next_due_utc <= 0)
        {
         summary.next_due_utc = 0;
         summary.next_due_reason = "repair-refresh";
         summary.next_due_count = 0;
         break;
        }

      if(summary.next_due_utc == 0 || packet.next_due_utc < summary.next_due_utc)
        {
         summary.next_due_utc = packet.next_due_utc;
         summary.next_due_reason = packet.next_due_reason;
         summary.next_due_count = 1;
        }
      else if(packet.next_due_utc == summary.next_due_utc)
        {
         summary.next_due_count++;
        }
     }

   g_asc_l2_latest_summary = summary;
   g_asc_l2_has_summary = true;
  }

void ASC_Layer2Reset()
  {
   ArrayResize(g_asc_l2_cache, 0);
   g_asc_l2_revision = 0;
   g_asc_l2_last_changed_symbols = 0;
   g_asc_l2_admission_epoch = 0;
   g_asc_l2_has_summary = false;
   ArrayResize(g_asc_l2_top5_overlay_symbols, 0);
   g_asc_l2_top5_overlay_requested_utc = 0;
   g_asc_l2_top5_overlay_generation = 0;
  }

void ASC_Layer2ScanSlice(const datetime now_utc,
                         const int cursor,
                         const int packet_budget,
                         const string tactical_symbol,
                         int &next_cursor,
                         int &processed_packets,
                         int &remaining_due,
                         int &admitted_symbols,
                         int &changed_symbols,
                         ASC_FunctionResult &result)
  {
   ASC_FunctionResultBegin(result, "ASC_Layer2OpenSymbolSnapshot", "ASC_Layer2ScanSlice", "admitted-open-subset");

   int l1_total = ASC_Layer1CachedSymbolCount();
   g_asc_l2_admission_epoch++;
   if(g_asc_l2_admission_epoch <= 0)
      g_asc_l2_admission_epoch = 1;

   string open_symbols[];
   ArrayResize(open_symbols, 0);
   for(int i = 0; i < l1_total; i++)
     {
      ASC_Layer1SymbolState l1_state;
      if(!ASC_Layer1GetCachedSymbol(i, l1_state) || StringLen(l1_state.symbol) <= 0)
         continue;
      if(l1_state.state != ASC_L1_OPEN)
         continue;

      int open_next = ArraySize(open_symbols);
      ArrayResize(open_symbols, open_next + 1);
      open_symbols[open_next] = l1_state.symbol;

      int existing_index = ASC_L2FindIndexBySymbol(l1_state.symbol);
      if(existing_index < 0)
        {
         ASC_Layer2Packet packet;
         ASC_L2InitPacket(packet, l1_state.symbol);
         int next = ArraySize(g_asc_l2_cache);
         ArrayResize(g_asc_l2_cache, next + 1);
         g_asc_l2_cache[next] = packet;
         existing_index = next;
        }

      g_asc_l2_cache[existing_index].admitted = true;
      g_asc_l2_cache[existing_index].tactical_only = false;
      g_asc_l2_cache[existing_index].admission_epoch = g_asc_l2_admission_epoch;
     }

   for(int i = 0; i < ArraySize(g_asc_l2_cache); i++)
     {
      bool still_open = (g_asc_l2_cache[i].admission_epoch == g_asc_l2_admission_epoch);
      if(!still_open)
         g_asc_l2_cache[i].admitted = false;
      if(g_asc_l2_cache[i].symbol != tactical_symbol)
         g_asc_l2_cache[i].tactical_only = false;
     }

   if(StringLen(tactical_symbol) > 0)
     {
      int tactical_index = ASC_L2FindIndexBySymbol(tactical_symbol);
      if(tactical_index < 0)
        {
         ASC_Layer2Packet packet;
         ASC_L2InitPacket(packet, tactical_symbol);
         int next = ArraySize(g_asc_l2_cache);
         ArrayResize(g_asc_l2_cache, next + 1);
         g_asc_l2_cache[next] = packet;
         tactical_index = next;
        }
      if(!g_asc_l2_cache[tactical_index].admitted)
         g_asc_l2_cache[tactical_index].tactical_only = true;
     }

   int total = ArraySize(g_asc_l2_cache);
   int local_cursor = cursor;
   if(local_cursor < 0)
      local_cursor = 0;
   if(total > 0 && local_cursor >= total)
      local_cursor = local_cursor % total;

   int dynamic_budget = ASC_L2DynamicPacketBudget(ArraySize(open_symbols));
   int budget = ASC_ClampInt(packet_budget, 1, dynamic_budget);
   budget = MathMin(dynamic_budget + 5, MathMax(budget, ArraySize(g_asc_l2_top5_overlay_symbols)));
   int traversed = 0;
   int probe = local_cursor;
   g_asc_l2_last_changed_symbols = 0;
   processed_packets = 0;

   int admitted_count_now = 0;
   for(int i = 0; i < total; i++)
     {
      if(g_asc_l2_cache[i].admitted)
         admitted_count_now++;
     }

   processed_packets += ASC_L2ProcessTop5OverlayTargets(now_utc, admitted_count_now, budget);

   while(total > 0 && traversed < total && processed_packets < budget)
     {
      ASC_Layer2Packet packet = g_asc_l2_cache[probe];
      bool eligible = (packet.admitted || packet.tactical_only);
      bool due_now = (packet.next_due_utc <= 0 || packet.next_due_utc <= now_utc);
      bool tactical_due = (packet.symbol == tactical_symbol && StringLen(tactical_symbol) > 0);
      bool forced_tactical = (tactical_due && processed_packets <= 0);

      if(eligible && (due_now || forced_tactical))
        {
         ASC_L2EvaluatePacket(packet, now_utc, admitted_count_now);
         g_asc_l2_cache[probe] = packet;
         processed_packets++;
        }

      probe++;
      if(probe >= total)
         probe = 0;
      traversed++;
     }

   next_cursor = probe;
   ASC_L2RebuildSummary(now_utc);
   changed_symbols = g_asc_l2_last_changed_symbols;

   remaining_due = 0;
   admitted_symbols = g_asc_l2_latest_summary.admitted_symbols;
   for(int i = 0; i < ArraySize(g_asc_l2_cache); i++)
     {
      ASC_Layer2Packet packet = g_asc_l2_cache[i];
      if(!packet.admitted && !packet.tactical_only)
         continue;
      if(packet.next_due_utc <= 0 || packet.next_due_utc <= now_utc)
         remaining_due++;
     }

   string detail = StringFormat("processed=%d admitted=%d remaining_due=%d changed=%d cursor_in=%d cursor_out=%d tactical=%s",
                                processed_packets,
                                admitted_symbols,
                                remaining_due,
                                changed_symbols,
                                cursor,
                                next_cursor,
                                tactical_symbol);
   detail += " | " + ASC_L2ResolverLifecycleSummaryDetail(now_utc);

   ASC_FunctionResultFinish(result,
                            ASC_RESULT_OK,
                            ASC_RC_OK,
                            detail,
                            "runtime:open_symbol_snapshot");
  }

bool ASC_Layer2TryGetSummary(ASC_Layer2Summary &summary)
  {
   if(!g_asc_l2_has_summary)
      return false;
   summary = g_asc_l2_latest_summary;
   return true;
  }

bool ASC_Layer2TryGetPacketBySymbol(const string symbol,ASC_Layer2Packet &packet)
  {
   int index = ASC_L2FindIndexBySymbol(symbol);
   if(index < 0)
      return false;
   packet = g_asc_l2_cache[index];
   return true;
  }

bool ASC_Layer2TryGetPacketByIndex(const int index,ASC_Layer2Packet &packet)
  {
   if(index < 0 || index >= ArraySize(g_asc_l2_cache))
      return false;
   packet = g_asc_l2_cache[index];
   return true;
  }

bool ASC_Layer2TryGetFirstAdmittedPacket(ASC_Layer2Packet &packet)
  {
   for(int i = 0; i < ArraySize(g_asc_l2_cache); i++)
     {
      if(g_asc_l2_cache[i].admitted)
        {
         packet = g_asc_l2_cache[i];
         return true;
        }
     }
   return false;
  }

int ASC_Layer2TrackedSymbolCount()
  {
   return ArraySize(g_asc_l2_cache);
  }

int ASC_Layer2ChangedSinceRevision(const ulong revision)
  {
   int changed = 0;
   for(int i = 0; i < ArraySize(g_asc_l2_cache); i++)
     {
      ASC_Layer2Packet packet = g_asc_l2_cache[i];
      if(!packet.admitted)
         continue;
      if(packet.revision > revision)
         changed++;
     }
   return changed;
  }

ulong ASC_Layer2LatestRevision()
  {
   return g_asc_l2_revision;
  }

bool ASC_Layer2BuildChangedSubsetBlock(const ulong min_revision,
                                       string &subset_block,
                                       int &emitted,
                                       int &admitted_total,
                                       ulong &latest_revision)
  {
   subset_block = "";
   emitted = 0;
   admitted_total = 0;
   latest_revision = g_asc_l2_revision;

   for(int i = 0; i < ArraySize(g_asc_l2_cache); i++)
     {
      ASC_Layer2Packet packet = g_asc_l2_cache[i];
      if(!packet.admitted)
         continue;
      admitted_total++;

      if(packet.revision <= min_revision)
         continue;

      emitted++;
      bool lawful_snapshot = ASC_L2PacketHasLawfulSnapshot(packet);
      bool lawful_day_range = ASC_L2PacketHasLawfulDayRange(packet);
      string bid_text = lawful_snapshot ? DoubleToString(packet.bid, 5) : "unavailable";
      string ask_text = lawful_snapshot ? DoubleToString(packet.ask, 5) : "unavailable";
      string spread_text = lawful_snapshot && packet.valid_spread ? DoubleToString(packet.spread_abs, 5) : "unavailable";
      string spread_pct_text = lawful_snapshot && packet.valid_spread_pct ? DoubleToString(packet.spread_pct, 3) : "unavailable";
      string age_text = packet.valid_tick_time ? IntegerToString(packet.packet_age_sec) + " sec" : "unavailable";
      string day_high_text = lawful_day_range ? DoubleToString(packet.day_high, 5) : "unavailable";
      string day_low_text = lawful_day_range ? DoubleToString(packet.day_low, 5) : "unavailable";
      string day_range_text = lawful_day_range ? DoubleToString(packet.day_range_points, 1) : "unavailable";
      string day_change_text = packet.valid_daily_change_pct ? DoubleToString(packet.daily_change_pct, 2) : "unavailable";
      string contract_size_text = packet.valid_contract_size ? DoubleToString(packet.contract_size, 2) : "unavailable";
      string tick_size_text = packet.valid_tick_size ? DoubleToString(packet.tick_size, 6) : "unavailable";
      string tick_value_text = packet.valid_tick_value ? DoubleToString(packet.tick_value, 6) : "unavailable";
      string stop_distance_text = packet.valid_stop_distance ? DoubleToString(packet.min_stop_distance, 5) : "unavailable";
      string volume_min_text = packet.valid_volume_min ? DoubleToString(packet.volume_min, 2) : "unavailable";
      string volume_max_text = packet.valid_volume_max ? DoubleToString(packet.volume_max, 2) : "unavailable";
      string volume_step_text = packet.valid_volume_step ? DoubleToString(packet.volume_step, 2) : "unavailable";
      string trade_mode_text = packet.valid_trade_mode ? IntegerToString((int)packet.trade_mode) : "unavailable";
      string execution_mode_text = packet.valid_execution_mode ? IntegerToString((int)packet.execution_mode) : "unavailable";
      string margin_currency_text = packet.valid_margin_currency ? packet.margin_currency : "unavailable";
      string profit_currency_text = packet.valid_profit_currency ? packet.profit_currency : "unavailable";
      string continuity_text = StringLen(packet.continuity_posture) > 0 ? packet.continuity_posture : (packet.continuity_backed ? "continuity-backed" : "fresh-read");
      string changed_fields = StringLen(packet.changed_fields) > 0 ? packet.changed_fields : "none";
      string next_due_text = (packet.next_due_utc > 0)
                             ? TimeToString(packet.next_due_utc, TIME_DATE | TIME_SECONDS)
                             : "unavailable";
      subset_block += StringFormat("- %s | freshness=%s | bid=%s | ask=%s | spread=%s | spread_pct=%s | tick_age=%s | day_high=%s | day_low=%s | day_range_points=%s | day_change_pct=%s | contract_size=%s | tick_size=%s | tick_value=%s | stop_distance=%s | volume_min=%s | volume_max=%s | volume_step=%s | trade_mode=%s | execution_mode=%s | margin_currency=%s | profit_currency=%s | continuity=%s | state=%s | changed=%s | next_due=%s (%s)\n",
                                   packet.symbol,
                                   StringLen(packet.freshness_posture) > 0 ? packet.freshness_posture : ASC_L2FreshnessToText(packet.freshness),
                                   bid_text,
                                   ask_text,
                                   spread_text,
                                   spread_pct_text,
                                   age_text,
                                   day_high_text,
                                   day_low_text,
                                   day_range_text,
                                   day_change_text,
                                   contract_size_text,
                                   tick_size_text,
                                   tick_value_text,
                                   stop_distance_text,
                                   volume_min_text,
                                   volume_max_text,
                                   volume_step_text,
                                   trade_mode_text,
                                   execution_mode_text,
                                   margin_currency_text,
                                   profit_currency_text,
                                   continuity_text,
                                   packet.market_watch_state_reason,
                                   changed_fields,
                                   next_due_text,
                                   packet.next_due_reason);
      subset_block += StringFormat("  live_quote_retry=attempts:%d elapsed_ms:%d\n",
                                   packet.live_quote_micro_retry_attempts,
                                   packet.live_quote_micro_retry_elapsed_ms);
      subset_block += StringFormat("  hydration=%s | reason=%s | gate=%s | spec_reason=%s\n",
                                   ASC_L2HydrationFamilyToText(packet.hydration_family),
                                   packet.hydration_reason_code,
                                   packet.hydration_gate_code,
                                   packet.specification_state_reason);
     }

   return (admitted_total > 0);
  }

#endif
