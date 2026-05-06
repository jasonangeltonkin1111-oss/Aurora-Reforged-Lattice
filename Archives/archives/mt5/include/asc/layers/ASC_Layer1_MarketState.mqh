#ifndef ASC_LAYER1_MARKET_STATE_MQH
#define ASC_LAYER1_MARKET_STATE_MQH

#include "../config/ASC_Config_Defaults.mqh"
#include "../core/ASC_Core_RuntimeState.mqh"

ASC_MarketStateRecord g_asc_layer1_records[];
datetime g_asc_layer1_last_scan_log_at = 0;

struct ASC_Layer1SessionWindow
  {
   bool HasData;
   bool OpenNow;
   bool OpenFromCurrentDay;
   bool OpenFromPreviousCarry;
   int SessionCount;
   int MatchedIndex;
   int MatchedStartSeconds;
   int MatchedEndSeconds;
   ENUM_DAY_OF_WEEK MatchedDay;
  };

struct ASC_Layer1TickEvidence
  {
   bool HasTick;
   bool HasUsablePrice;
   bool Fresh;
   bool Stale;
   int AgeSeconds;
  };

struct ASC_Layer1ScanDiagnostics
  {
   int TradeAndQuoteOpenCount;
   int TradeOnlyOpenCount;
   int QuoteOnlyOpenCount;
   int TickFallbackOpenCount;
   int FreshConflictCount;
   int SessionDataMissingCount;
   int LoggedDecisionCount;
  };

int ASC_TimeSecondsOfDay(const datetime value)
  {
   MqlDateTime time_parts;
   ZeroMemory(time_parts);
   if(!TimeToStruct(value, time_parts))
      return 0;
   return time_parts.hour * 3600 + time_parts.min * 60 + time_parts.sec;
  }

ENUM_DAY_OF_WEEK ASC_TimeDayOfWeek(const datetime value)
  {
   MqlDateTime time_parts;
   ZeroMemory(time_parts);
   if(!TimeToStruct(value, time_parts))
      return SUNDAY;
   return (ENUM_DAY_OF_WEEK)time_parts.day_of_week;
  }

datetime ASC_Layer1BrokerNow()
  {
   datetime broker_now = TimeTradeServer();
   if(broker_now <= 0)
      broker_now = TimeCurrent();
   if(broker_now <= 0)
      broker_now = TimeLocal();
   return broker_now;
  }

ENUM_DAY_OF_WEEK ASC_Layer1PreviousDayOfWeek(const ENUM_DAY_OF_WEEK day)
  {
   if(day == SUNDAY)
      return SATURDAY;
   return (ENUM_DAY_OF_WEEK)((int)day - 1);
  }

void ASC_Layer1ResetSessionWindow(ASC_Layer1SessionWindow &window)
  {
   window.HasData              = false;
   window.OpenNow              = false;
   window.OpenFromCurrentDay   = false;
   window.OpenFromPreviousCarry = false;
   window.SessionCount         = 0;
   window.MatchedIndex         = -1;
   window.MatchedStartSeconds  = -1;
   window.MatchedEndSeconds    = -1;
   window.MatchedDay           = SUNDAY;
  }

bool ASC_Layer1ReadSessionWindow(const string symbol,
                                 const bool trade_sessions,
                                 const ENUM_DAY_OF_WEEK day,
                                 const int session_index,
                                 datetime &from_time,
                                 datetime &to_time)
  {
   if(trade_sessions)
      return SymbolInfoSessionTrade(symbol, day, session_index, from_time, to_time);

   return SymbolInfoSessionQuote(symbol, day, session_index, from_time, to_time);
  }

bool ASC_Layer1IsCurrentDaySessionOpen(const int now_seconds,
                                       const int start_seconds,
                                       const int end_seconds)
  {
   if(start_seconds <= end_seconds)
      return (now_seconds >= start_seconds && now_seconds <= end_seconds);

   return (now_seconds >= start_seconds);
  }

bool ASC_Layer1IsPreviousCarrySessionOpen(const int now_seconds,
                                          const int start_seconds,
                                          const int end_seconds)
  {
   if(start_seconds <= end_seconds)
      return false;

   return (now_seconds <= end_seconds);
  }

void ASC_Layer1CollectSessionWindow(const string symbol,
                                    const bool trade_sessions,
                                    const datetime now,
                                    ASC_Layer1SessionWindow &window)
  {
   ASC_Layer1ResetSessionWindow(window);

   ENUM_DAY_OF_WEEK current_day  = ASC_TimeDayOfWeek(now);
   ENUM_DAY_OF_WEEK previous_day = ASC_Layer1PreviousDayOfWeek(current_day);
   int now_seconds = ASC_TimeSecondsOfDay(now);

   for(int session_index = 0; session_index < 16; session_index++)
     {
      datetime from_time = 0;
      datetime to_time   = 0;
      if(!ASC_Layer1ReadSessionWindow(symbol, trade_sessions, current_day, session_index, from_time, to_time))
         break;

      window.HasData = true;
      window.SessionCount++;

      int start_seconds = ASC_TimeSecondsOfDay(from_time);
      int end_seconds   = ASC_TimeSecondsOfDay(to_time);

      if(ASC_Layer1IsCurrentDaySessionOpen(now_seconds, start_seconds, end_seconds))
        {
         window.OpenNow            = true;
         window.OpenFromCurrentDay = true;
         window.MatchedIndex       = session_index;
         window.MatchedStartSeconds = start_seconds;
         window.MatchedEndSeconds   = end_seconds;
         window.MatchedDay         = current_day;
         return;
        }
     }

   for(int session_index = 0; session_index < 16; session_index++)
     {
      datetime from_time = 0;
      datetime to_time   = 0;
      if(!ASC_Layer1ReadSessionWindow(symbol, trade_sessions, previous_day, session_index, from_time, to_time))
         break;

      window.HasData = true;
      window.SessionCount++;

      int start_seconds = ASC_TimeSecondsOfDay(from_time);
      int end_seconds   = ASC_TimeSecondsOfDay(to_time);

      if(ASC_Layer1IsPreviousCarrySessionOpen(now_seconds, start_seconds, end_seconds))
        {
         window.OpenNow                = true;
         window.OpenFromPreviousCarry  = true;
         window.MatchedIndex           = session_index;
         window.MatchedStartSeconds    = start_seconds;
         window.MatchedEndSeconds      = end_seconds;
         window.MatchedDay             = previous_day;
         return;
        }
     }
  }

void ASC_Layer1CollectTickEvidence(const string symbol,
                                   const datetime now,
                                   ASC_Layer1TickEvidence &evidence)
  {
   evidence.HasTick         = false;
   evidence.HasUsablePrice  = false;
   evidence.Fresh           = false;
   evidence.Stale           = false;
   evidence.AgeSeconds      = -1;

   MqlTick tick;
   ZeroMemory(tick);
   if(!SymbolInfoTick(symbol, tick))
      return;

   evidence.HasTick = true;
   evidence.HasUsablePrice = (tick.bid > 0.0 || tick.ask > 0.0 || tick.last > 0.0);

   datetime tick_time = (datetime)tick.time;
   if(tick_time <= 0 && tick.time_msc > 0)
      tick_time = (datetime)(tick.time_msc / 1000);

   if(tick_time <= 0)
      return;

   int age_seconds = (int)(now - tick_time);
   if(age_seconds < 0)
      age_seconds = 0;

   evidence.AgeSeconds = age_seconds;

   if(!evidence.HasUsablePrice)
      return;

   evidence.Fresh = (age_seconds <= ASC_LAYER1_TICK_FRESH_SECONDS);
   evidence.Stale = (!evidence.Fresh && age_seconds <= ASC_LAYER1_STALE_TICK_SECONDS);
  }

string ASC_Layer1BoolText(const bool value)
  {
   return value ? "yes" : "no";
  }

string ASC_Layer1MarketStateText(const ASC_MarketStatePosture value)
  {
   switch(value)
     {
      case ASC_MARKET_STATE_OPEN:      return "open";
      case ASC_MARKET_STATE_CLOSED:    return "closed";
      case ASC_MARKET_STATE_UNCERTAIN: return "watch";
      default:                         return "unknown";
     }
  }

bool ASC_Layer1DecisionNeedsLog(const ASC_MarketStateRecord &previous_record,
                                const ASC_MarketStateRecord &current_record,
                                const datetime now)
  {
   bool diagnostic_path = (current_record.DecisionPath == "tick_fallback_open"
                           || current_record.DecisionPath == "fresh_tick_overrides_closed_sessions"
                           || current_record.MarketState == ASC_MARKET_STATE_UNCERTAIN
                           || current_record.MarketState == ASC_MARKET_STATE_UNKNOWN);

   if(!diagnostic_path)
      return false;

   if(previous_record.MarketState != current_record.MarketState)
      return true;

   if(previous_record.DecisionPath != current_record.DecisionPath)
      return true;

   if(previous_record.LastDecisionLogAt <= 0)
      return true;

   return ((int)(now - previous_record.LastDecisionLogAt) >= ASC_LAYER1_DECISION_LOG_THROTTLE_SECONDS);
  }

void ASC_Layer1LogDecision(const ASC_MarketStateRecord &record)
  {
   PrintFormat("[ASC][L1][DECISION] symbol=%s state=%s path=%s trade_session=%s/%s quote_session=%s/%s tick=%s price=%s tick_age=%d reason=%s",
               record.Identity.RawBrokerSymbol,
               ASC_Layer1MarketStateText(record.MarketState),
               record.DecisionPath,
               record.HasTradeSessionData ? "present" : "missing",
               record.TradeSessionOpen ? "open" : "closed",
               record.HasQuoteSessionData ? "present" : "missing",
               record.QuoteSessionOpen ? "open" : "closed",
               record.HasTick ? "present" : "missing",
               record.HasUsablePrice ? "usable" : "empty",
               record.TickAgeSeconds,
               record.StatusReason);
  }

void ASC_Layer1LogScanSummary(const ASC_RootRuntimeState &state,
                              const ASC_Layer1ScanDiagnostics &diagnostics,
                              const datetime now)
  {
   bool due_for_summary = (g_asc_layer1_last_scan_log_at <= 0
                           || (int)(now - g_asc_layer1_last_scan_log_at) >= ASC_LAYER1_SCAN_LOG_INTERVAL_SECONDS);

   bool anomaly_present = (diagnostics.TickFallbackOpenCount > 0
                           || diagnostics.FreshConflictCount > 0
                           || state.Layer1.UncertainCount > 0
                           || state.Layer1.UnknownCount > 0);

   if(!due_for_summary && !anomaly_present)
      return;

   PrintFormat("[ASC][L1][SCAN] total=%d open=%d closed=%d watch=%d unknown=%d trade_and_quote_open=%d trade_only_open=%d quote_only_open=%d tick_fallback_open=%d fresh_conflicts=%d session_missing=%d scan_ms=%d",
               state.Layer1.TotalSymbols,
               state.Layer1.OpenCount,
               state.Layer1.ClosedCount,
               state.Layer1.UncertainCount,
               state.Layer1.UnknownCount,
               diagnostics.TradeAndQuoteOpenCount,
               diagnostics.TradeOnlyOpenCount,
               diagnostics.QuoteOnlyOpenCount,
               diagnostics.TickFallbackOpenCount,
               diagnostics.FreshConflictCount,
               diagnostics.SessionDataMissingCount,
               state.Layer1.LastScanDurationMilliseconds);

   g_asc_layer1_last_scan_log_at = now;
  }

ASC_SymbolIdentity ASC_Layer1BuildIdentity(const string symbol,
                                           const string server_name)
  {
   return ASC_ResolveSymbolIdentity(symbol, server_name);
  }

void ASC_Layer1ResolveRecord(const string symbol,
                             const datetime now,
                             ASC_MarketStateRecord &record)
  {
   ASC_Layer1SessionWindow trade_window;
   ASC_Layer1SessionWindow quote_window;
   ASC_Layer1TickEvidence tick_evidence;

   ASC_Layer1CollectSessionWindow(symbol, true, now, trade_window);
   ASC_Layer1CollectSessionWindow(symbol, false, now, quote_window);
   ASC_Layer1CollectTickEvidence(symbol, now, tick_evidence);

   long trade_mode = SymbolInfoInteger(symbol, SYMBOL_TRADE_MODE);

   record.HasTradeSessionData = trade_window.HasData;
   record.TradeSessionOpen    = trade_window.OpenNow;
   record.HasQuoteSessionData = quote_window.HasData;
   record.QuoteSessionOpen    = quote_window.OpenNow;
   record.HasTick             = tick_evidence.HasTick;
   record.HasUsablePrice      = tick_evidence.HasUsablePrice;
   record.TickAgeSeconds      = tick_evidence.AgeSeconds;
   record.DecisionPath        = "";

   bool session_open     = (trade_window.OpenNow || quote_window.OpenNow);
   bool has_any_session  = (trade_window.HasData || quote_window.HasData);
   bool dual_session_data = (trade_window.HasData && quote_window.HasData);
   bool fresh_live_tick  = tick_evidence.Fresh;
   bool stale_live_tick  = tick_evidence.Stale;

   if(session_open)
     {
      record.MarketState = ASC_MARKET_STATE_OPEN;

      if(fresh_live_tick)
        {
         record.Freshness    = ASC_FRESHNESS_FRESH;
         record.Completeness = ASC_COMPLETENESS_COMPLETE;

         if(trade_window.OpenNow && quote_window.OpenNow)
           {
            record.DecisionPath = "trade_and_quote_session_open";
            record.StatusReason = "Trade and quote sessions are open at broker time and a fresh live tick confirms the symbol is active.";
           }
         else if(trade_window.OpenNow)
           {
            record.DecisionPath = "trade_session_open";
            record.StatusReason = "The trade session is open at broker time and a fresh live tick confirms the symbol is active.";
           }
         else
           {
            record.DecisionPath = "quote_session_open";
            record.StatusReason = "The quote session is open at broker time and a fresh live tick confirms the symbol is active even though trade-session availability is narrower.";
           }

         return;
        }

      record.Completeness = ASC_COMPLETENESS_PARTIAL;

      if(stale_live_tick)
        {
         record.Freshness = ASC_FRESHNESS_STALE;
         if(trade_window.OpenNow && quote_window.OpenNow)
            record.DecisionPath = "open_session_stale_tick";
         else if(trade_window.OpenNow)
            record.DecisionPath = "trade_session_open_stale_tick";
         else
            record.DecisionPath = "quote_session_open_stale_tick";

         record.StatusReason = "A broker session is open now and the last usable tick is stale, so the symbol remains Open while freshness is degraded until a newer quote arrives.";
         return;
        }

      record.Freshness = ASC_FRESHNESS_PENDING_REFRESH;
      if(trade_window.OpenNow && quote_window.OpenNow)
         record.DecisionPath = "open_session_pending_tick";
      else if(trade_window.OpenNow)
         record.DecisionPath = "trade_session_open_pending_tick";
      else
         record.DecisionPath = "quote_session_open_pending_tick";

      record.StatusReason = "A broker session is open now, so the symbol remains Open even though a fresh usable tick has not arrived yet.";
      return;
     }

   if(fresh_live_tick)
     {
      if(has_any_session)
        {
         record.MarketState  = ASC_MARKET_STATE_OPEN;
         record.Freshness    = ASC_FRESHNESS_FRESH;
         record.Completeness = ASC_COMPLETENESS_PARTIAL;
         record.DecisionPath = "fresh_tick_overrides_closed_sessions";
         record.StatusReason = "Fresh live tick evidence overrides currently closed broker session reports, so the symbol stays Open while the session conflict remains visible for review.";
         return;
        }

      record.MarketState  = ASC_MARKET_STATE_OPEN;
      record.Freshness    = ASC_FRESHNESS_FRESH;
      record.Completeness = ASC_COMPLETENESS_COMPLETE;
      record.DecisionPath = "tick_fallback_open";
      record.StatusReason = "Broker session data was unavailable, so a fresh live tick with a usable quote lawfully keeps the symbol Open.";
      return;
     }

   if(has_any_session)
     {
      if(dual_session_data)
        {
         /*
          * Both the trade and quote sessions report closed. However, continuous
          * markets (like FX or certain indices) often have overlapping or
          * irregular sessions, and stale or delayed quotes can still imply the
          * symbol is trading even when the primary session flags report
          * closed. Previously this logic would blindly classify the symbol
          * as Closed whenever both sessions were closed, which resulted in
          * false CLOSED postures for symbols that were actually available.
          *
          * To reduce these false negatives we treat symbols with any recent
          * tick evidence (fresh or stale) as Uncertain instead of Closed
          * whenever both sessions report closed.  This elevates the symbol
          * into a Market Watch posture so operators can see that there is
          * conflicting evidence rather than mistakenly assuming the market is
          * closed.  Only when there is no tick evidence at all do we mark
          * the symbol as Closed.
          */
         if(record.HasTick)
           {
            record.MarketState  = ASC_MARKET_STATE_UNCERTAIN;
            record.Freshness    = stale_live_tick ? ASC_FRESHNESS_STALE : ASC_FRESHNESS_PENDING_REFRESH;
            record.Completeness = ASC_COMPLETENESS_PARTIAL;
            record.DecisionPath = "sessions_closed_with_tick";
            record.StatusReason = "Trade and quote sessions report closed, but live tick evidence exists; posture marked as Market Watch to avoid false closed state.";
            return;
           }

         // No tick evidence at all; retain closed posture.
         record.MarketState  = ASC_MARKET_STATE_CLOSED;
         record.Freshness    = stale_live_tick ? ASC_FRESHNESS_STALE : ASC_FRESHNESS_PENDING_REFRESH;
         record.Completeness = ASC_COMPLETENESS_COMPLETE;
         record.DecisionPath = "trade_and_quote_session_closed";
         record.StatusReason = "Trade and quote sessions are both closed at broker time, and no tick evidence was present to contradict that posture.";
         return;
        }

      record.MarketState  = ASC_MARKET_STATE_UNCERTAIN;
      record.Freshness    = stale_live_tick ? ASC_FRESHNESS_STALE : ASC_FRESHNESS_PENDING_REFRESH;
      record.Completeness = ASC_COMPLETENESS_PARTIAL;
      record.DecisionPath = "single_session_source_closed";
      record.StatusReason = "Only one broker session source is available and it is closed now, so the symbol stays on watch until fresh live evidence confirms the posture.";
      return;
     }

   if(stale_live_tick)
     {
      record.MarketState  = ASC_MARKET_STATE_UNCERTAIN;
      record.Freshness    = ASC_FRESHNESS_STALE;
      record.Completeness = ASC_COMPLETENESS_PARTIAL;
      record.DecisionPath = "stale_tick_without_sessions";
      record.StatusReason = "Only stale live tick evidence was available and session data was unavailable, so the symbol stays on watch.";
      return;
     }

   if(trade_mode == SYMBOL_TRADE_MODE_DISABLED)
     {
      record.MarketState  = ASC_MARKET_STATE_CLOSED;
      record.Freshness    = ASC_FRESHNESS_PENDING_REFRESH;
      record.Completeness = ASC_COMPLETENESS_PARTIAL;
      record.DecisionPath = "trade_mode_disabled";
      record.StatusReason = "Trade mode is disabled and no session or fresh live tick evidence contradicted that closed posture.";
      return;
     }

   record.MarketState  = ASC_MARKET_STATE_UNKNOWN;
   record.Freshness    = ASC_FRESHNESS_PENDING_REFRESH;
   record.Completeness = ASC_COMPLETENESS_BLOCKED;
   record.DecisionPath = "no_lawful_evidence";
   record.StatusReason = "Trade session, quote session, and live tick evidence were all unavailable, so the symbol remains unknown.";
  }

void ASC_Layer1ResetSummary(ASC_RootRuntimeState &state,
                            const datetime now)
  {
   state.Layer1.TotalSymbols                   = 0;
   state.Layer1.OpenCount                      = 0;
   state.Layer1.ClosedCount                    = 0;
   state.Layer1.UncertainCount                 = 0;
   state.Layer1.UnknownCount                   = 0;
   state.Layer1.FreshCount                     = 0;
   state.Layer1.StaleCount                     = 0;
   state.Layer1.PendingRefreshCount            = 0;
   state.Layer1.DegradedCount                  = 0;
   state.Layer1.ResolvedClassificationCount    = 0;
   state.Layer1.UnknownClassificationCount     = 0;
   state.Layer1.FxCount                        = 0;
   state.Layer1.IndexCount                     = 0;
   state.Layer1.MetalsCount                    = 0;
   state.Layer1.EnergyCount                    = 0;
   state.Layer1.CryptoCount                    = 0;
   state.Layer1.StockCount                     = 0;
   state.Layer1.CompleteCount                  = 0;
   state.Layer1.PartialCount                   = 0;
   state.Layer1.BlockedCount                   = 0;
   state.Layer1.LastScanDurationMilliseconds   = 0;
   state.Layer1.LastScanAt                     = now;
  }

void ASC_Layer1AccumulateSummary(ASC_RootRuntimeState &state,
                                 const ASC_MarketStateRecord &record)
  {
   ASC_MarketStatePosture market_state = record.MarketState;
   ASC_FreshnessPosture freshness = record.Freshness;
   ASC_CompletenessPosture completeness = record.Completeness;

   state.Layer1.TotalSymbols++;
   switch(market_state)
     {
      case ASC_MARKET_STATE_OPEN:      state.Layer1.OpenCount++; break;
      case ASC_MARKET_STATE_CLOSED:    state.Layer1.ClosedCount++; break;
      case ASC_MARKET_STATE_UNCERTAIN: state.Layer1.UncertainCount++; break;
      default:                         state.Layer1.UnknownCount++; break;
     }

   switch(freshness)
     {
      case ASC_FRESHNESS_FRESH:           state.Layer1.FreshCount++; break;
      case ASC_FRESHNESS_STALE:           state.Layer1.StaleCount++; break;
      case ASC_FRESHNESS_PENDING_REFRESH: state.Layer1.PendingRefreshCount++; break;
      case ASC_FRESHNESS_DEGRADED:        state.Layer1.DegradedCount++; break;
      default:                            break;
     }

   switch(completeness)
     {
      case ASC_COMPLETENESS_COMPLETE: state.Layer1.CompleteCount++; break;
      case ASC_COMPLETENESS_PARTIAL:  state.Layer1.PartialCount++; break;
      case ASC_COMPLETENESS_BLOCKED:  state.Layer1.BlockedCount++; break;
      default:                        break;
     }

   if(record.Identity.ClassificationResolved)
     {
      state.Layer1.ResolvedClassificationCount++;
      if(record.Identity.AssetClass == "FX")
         state.Layer1.FxCount++;
      else if(record.Identity.AssetClass == "INDEX")
         state.Layer1.IndexCount++;
      else if(record.Identity.AssetClass == "METALS")
         state.Layer1.MetalsCount++;
      else if(record.Identity.AssetClass == "ENERGY")
         state.Layer1.EnergyCount++;
      else if(record.Identity.AssetClass == "CRYPTO")
         state.Layer1.CryptoCount++;
      else if(record.Identity.AssetClass == "STOCK")
         state.Layer1.StockCount++;
     }
   else
     {
      state.Layer1.UnknownClassificationCount++;
     }
  }

bool ASC_Layer1EnsureRecordArray(const int total_symbols)
  {
   if(ArraySize(g_asc_layer1_records) == total_symbols)
      return true;
   return ArrayResize(g_asc_layer1_records, total_symbols) == total_symbols;
  }

bool ASC_Layer1Scan(ASC_RootRuntimeState &state)
  {
   uint scan_started_at = GetTickCount();

   datetime now = ASC_Layer1BrokerNow();
   if(now <= 0)
      now = TimeLocal();

   int total_symbols = SymbolsTotal(false);
   if(total_symbols < 0)
      total_symbols = 0;

   if(!ASC_Layer1EnsureRecordArray(total_symbols))
      return false;

   ASC_Layer1ScanDiagnostics diagnostics;
   ZeroMemory(diagnostics);

   ASC_Layer1ResetSummary(state, now);

   for(int i = 0; i < total_symbols; i++)
     {
      string symbol = SymbolName(i, false);
      ASC_MarketStateRecord previous_record = g_asc_layer1_records[i];
      ASC_MarketStateRecord record = previous_record;

      record.Identity = ASC_Layer1BuildIdentity(symbol, state.Runtime.Identity.ServerName);
      ASC_Layer1ResolveRecord(symbol, now, record);
      record.ObservedAt = now;

      if(record.TradeSessionOpen && record.QuoteSessionOpen)
         diagnostics.TradeAndQuoteOpenCount++;
      else if(record.TradeSessionOpen)
         diagnostics.TradeOnlyOpenCount++;
      else if(record.QuoteSessionOpen)
         diagnostics.QuoteOnlyOpenCount++;

      if(!record.HasTradeSessionData && !record.HasQuoteSessionData)
         diagnostics.SessionDataMissingCount++;

      if(record.DecisionPath == "tick_fallback_open")
         diagnostics.TickFallbackOpenCount++;
      if(record.DecisionPath == "fresh_tick_conflict_closed_sessions"
         || record.DecisionPath == "sessions_closed_with_tick")
         diagnostics.FreshConflictCount++;

      if(diagnostics.LoggedDecisionCount < ASC_LAYER1_MAX_DECISION_LOGS_PER_SCAN
         && ASC_Layer1DecisionNeedsLog(previous_record, record, now))
        {
         ASC_Layer1LogDecision(record);
         record.LastDecisionLogAt = now;
         diagnostics.LoggedDecisionCount++;
        }

      ASC_Layer1AccumulateSummary(state, record);
      g_asc_layer1_records[i] = record;
     }

   state.Layer1.LastScanDurationMilliseconds          = (int)(GetTickCount() - scan_started_at);

   state.Runtime.LifecycleState.WarmupSatisfied        = (state.Layer1.TotalSymbols > 0);
   state.Runtime.LifecycleState.StructuralFreshness    = ASC_FRESHNESS_FRESH;
   state.Runtime.LifecycleState.StructuralCompleteness = ASC_COMPLETENESS_PARTIAL;

   ASC_Layer1LogScanSummary(state, diagnostics, now);
   return true;
  }

#endif // ASC_LAYER1_MARKET_STATE_MQH
