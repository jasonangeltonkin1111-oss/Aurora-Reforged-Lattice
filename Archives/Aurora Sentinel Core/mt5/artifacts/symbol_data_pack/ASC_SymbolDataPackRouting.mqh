#ifndef __ASC_SYMBOL_DATA_PACK_ROUTING_MQH__
#define __ASC_SYMBOL_DATA_PACK_ROUTING_MQH__

#include "ASC_SymbolDataPackContracts.mqh"

// RUN161R route map only. These rows name existing Aurora truth owners and future fill runs.
// They do not calculate L1/L2/L3/L4/L5 values and do not publish files.

struct ASC_SymbolDataPackRouteDescriptor
  {
   string route_name;
   string existing_owner;
   bool implemented_in_run161;
   ASC_SymbolDataPackRouteState state;
   string future_run;
  };

void ASC_SymbolDataPackSetRoute(ASC_SymbolDataPackRouteDescriptor &descriptor,
                                const string route_name,
                                const string existing_owner,
                                const bool implemented_in_run161,
                                const ASC_SymbolDataPackRouteState state,
                                const string future_run)
  {
   descriptor.route_name = route_name;
   descriptor.existing_owner = existing_owner;
   descriptor.implemented_in_run161 = implemented_in_run161;
   descriptor.state = state;
   descriptor.future_run = future_run;
  }

string ASC_SymbolDataPackRouteLine(const string route_name,
                                   const string existing_owner,
                                   const bool implemented_in_run161,
                                   const ASC_SymbolDataPackRouteState state,
                                   const string future_run)
  {
   return "| " + route_name
          + " | " + existing_owner
          + " | " + (implemented_in_run161 ? "yes" : "no")
          + " | " + ASC_SymbolDataPackRouteStateText(state)
          + " | " + future_run
          + " |\n";
  }

string ASC_SymbolDataPackRoutingMapText()
  {
   string text = "| Route | Existing Owner | RUN161 Implemented? | Stub State | Future Run |\n";
   text += "|---|---|---:|---|---|\n";
   text += ASC_SymbolDataPackRouteLine("identity route", "ClassificationBridge + SymbolSpecification", true, ASC_SDP_ROUTE_READY, "RUN161R skeleton only");
   text += ASC_SymbolDataPackRouteLine("market state route", "MarketStateEngine", true, ASC_SDP_ROUTE_READY, "RUN163R factual fill");
   text += ASC_SymbolDataPackRouteLine("quote L2 route", "OpenSymbolSnapshotEngine + SymbolInfoTick", true, ASC_SDP_ROUTE_READY, "RUN163R factual fill");
   text += ASC_SymbolDataPackRouteLine("symbol spec route", "SymbolSpecification", true, ASC_SDP_ROUTE_REQUIRES_EXISTING_OWNER, "RUN163R");
   text += ASC_SymbolDataPackRouteLine("L4 membership context route", "L4 committed membership snapshot", true, ASC_SDP_ROUTE_REQUIRES_EXISTING_OWNER, "RUN162R/RUN163R");
   text += ASC_SymbolDataPackRouteLine("OHLC factual route", "CopyRates/MqlRates official timeseries wrapper", true, ASC_SDP_ROUTE_READY, "RUN164R factual fill");
   text += ASC_SymbolDataPackRouteLine("tick/spread factual route", "OpenSymbolSnapshotEngine + CopyTicks aggregate windows", true, ASC_SDP_ROUTE_READY, "RUN163R factual fill");
   text += ASC_SymbolDataPackRouteLine("ATR/volatility factual route", "CopyRates/MqlRates manual true range wrapper + OpenSymbolSnapshot spread ratios", true, ASC_SDP_ROUTE_READY, "RUN165R factual fill");
   text += ASC_SymbolDataPackRouteLine("VWAP/anchored VWAP factual route", "CopyRates/MqlRates M1 time-anchor wrapper", true, ASC_SDP_ROUTE_READY, "RUN166R factual fill");
   text += ASC_SymbolDataPackRouteLine("numeric indicator facts route placeholder", "future handle/buffer wrapper", false, ASC_SDP_ROUTE_PLANNED_RUN, "RUN167R");
   text += ASC_SymbolDataPackRouteLine("freshness/health route placeholder", "routing + writer health owner", false, ASC_SDP_LAST_GOOD_REQUIRED, "RUN168R");
   text += ASC_SymbolDataPackRouteLine("owner trace route", "this routing layer maps owners only", true, ASC_SDP_ROUTE_READY, "RUN161R skeleton only");
   return text;
  }

string ASC_SymbolDataPackL2FutureFieldTableText()
  {
   string text = "| L2 Field | Existing Owner | RUN161 Contract Added? | RUN163 Fill Plan |\n";
   text += "|---|---|---:|---|\n";
   text += "| symbol | OpenSymbolSnapshotEngine / caller symbol | yes | implemented in RUN163R quote snapshot |\n";
   text += "| quote_refresh_target_seconds | Symbol Data Pack contract | yes | implemented as 10s target |\n";
   text += "| quote_last_refresh_utc | TimeCurrent | yes | implemented on compose |\n";
   text += "| quote_age_seconds | TimeCurrent delta | yes | implemented on compose |\n";
   text += "| symbol_info_tick_success | SymbolInfoTick | yes | implemented true/false plus error code |\n";
   text += "| symbol_info_tick_error_code | GetLastError | yes | implemented when tick read fails |\n";
   text += "| bid | MqlTick.bid | yes | implemented if SymbolInfoTick succeeds |\n";
   text += "| ask | MqlTick.ask | yes | implemented if SymbolInfoTick succeeds |\n";
   text += "| last | MqlTick.last | yes | implemented if SymbolInfoTick succeeds |\n";
   text += "| spread_points | bid/ask plus SYMBOL_POINT | yes | implemented with divide-by-zero guard |\n";
   text += "| spread_price | ask minus bid | yes | implemented with zero bid/ask guard |\n";
   text += "| spread_percent | spread_price divided by bid | yes | implemented with divide-by-zero guard |\n";
   text += "| tick_time | MqlTick.time | yes | implemented source timestamp |\n";
   text += "| tick_age_seconds | TimeCurrent minus tick_time | yes | implemented with non-negative clamp |\n";
   text += "| market_watch_selected_state | SymbolInfoInteger SYMBOL_SELECT | yes | implemented read-only diagnostic |\n";
   text += "| symbol_synchronized_state | SymbolIsSynchronized | yes | implemented read-only diagnostic |\n";
   text += "| quote_hydration_state | route state resolver | yes | implemented ready/collecting/retrying/last-good/failure modes |\n";
   text += "| quote_retry_attempts | bounded compose attempt state | yes | implemented as bounded diagnostic, no loop |\n";
   text += "| quote_retry_due | 10s target clock contract | yes | implemented text state |\n";
   text += "| quote_last_good_bid | current verified bid or pending | yes | implemented without fake prior history |\n";
   text += "| quote_last_good_ask | current verified ask or pending | yes | implemented without fake prior history |\n";
   text += "| quote_last_good_time | current verified tick time or pending | yes | implemented without extra operator file |\n";
   text += "| hard_absence_reason | retry/hydration guard | yes | never hard absence until diagnostics prove it |\n";
   return text;
  }

string ASC_SymbolDataPackTickStatsFieldTableText()
  {
   string text = "| Tick Stat | Source / API / Owner | RUN163 Implemented? | Runtime Cost Guard |\n";
   text += "|---|---|---:|---|\n";
   text += "| tick_refresh_target_seconds | Symbol Data Pack contract | yes | 10s target only |\n";
   text += "| tick_window_immediate_seconds | contract | yes | 60s aggregate only |\n";
   text += "| tick_window_primary_seconds | contract | yes | 300s aggregate only |\n";
   text += "| ticks_last_60s / ticks_last_300s | CopyTicks COPY_TICKS_INFO | yes | max 2000 ticks, no raw tick output |\n";
   text += "| bid/ask change counts | MqlTick.flags | yes | aggregate counts only |\n";
   text += "| max/avg gap seconds | MqlTick.time deltas | yes | bounded 60s/300s windows |\n";
   text += "| sample counts | CopyTicks result filtering | yes | no tick spam |\n";
   text += "| hydration/retry/last-good age | routing state | yes | no lazy unavailable |\n";
   return text;
  }

string ASC_SymbolDataPackSpreadStatsFieldTableText()
  {
   string text = "| Spread Stat | Source / API / Owner | RUN163 Implemented? | Signal Safety Guard |\n";
   text += "|---|---|---:|---|\n";
   text += "| spread_refresh_target_seconds | Symbol Data Pack contract | yes | factual cost/liquidity only |\n";
   text += "| current spread points/price/percent | MqlTick bid/ask + SYMBOL_POINT | yes | no trade permission language |\n";
   text += "| 60s min/max/avg/sample count | CopyTicks aggregate | yes | immediate window only |\n";
   text += "| 300s min/max/avg/sample count | CopyTicks aggregate | yes | primary stable window |\n";
   text += "| widening vs 300s avg percent | current vs 300s average | yes | data health only |\n";
   text += "| hydration/retry/last-good age | routing state | yes | no fake complete state |\n";
   return text;
  }


string ASC_SymbolDataPackOhlcTimeframeContractTableText()
  {
   string text = "| Timeframe | Bars Default | Existing Owner/API | RUN164 Implemented? | Retry / Last-Good Guard |\n";
   text += "|---|---:|---|---:|---|\n";
   text += "| M1 | 500 | CopyRates/MqlRates | yes | partial copy/history loading retry; last closed bar age retained |\n";
   text += "| M5 | 500 | CopyRates/MqlRates | yes | partial copy/history loading retry; last closed bar age retained |\n";
   text += "| M15 | 500 | CopyRates/MqlRates | yes | MTF priority starts here; last-good age visible |\n";
   text += "| M30 | 250 | CopyRates/MqlRates | yes | due-only new-bar cadence |\n";
   text += "| H1 | 250 | CopyRates/MqlRates | yes | due-only new-bar cadence |\n";
   text += "| H4 | 250 | CopyRates/MqlRates | yes | due-only new-bar cadence |\n";
   text += "| D1 | 50 | CopyRates/MqlRates | yes | current period high/low may update while forming |\n";
   text += "| W1 | 50 | CopyRates/MqlRates | yes | current period high/low may update while forming |\n";
   text += "| MN1 | 24 | CopyRates/MqlRates | yes | 50-bar expansion candidate retained |\n";
   return text;
  }

string ASC_SymbolDataPackBarFailureModeTableText()
  {
   string text = "| Bar Failure Mode | Detection | Retry / Hydration Rule | Output State |\n";
   text += "|---|---|---|---|\n";
   text += "| history loading | CopyRates <= 0 and terminal Bars <= 0 | retry on next due target; do not prove absence yet | bar_state_history_loading |\n";
   text += "| partial copy | bars_received < bars_requested | show requested/received and retry due | bar_state_partial_copy |\n";
   text += "| broker limited | repeated shallow history can be mapped later by health run | keep visible received count | bar_state_broker_limited |\n";
   text += "| last-good fallback | last closed bar exists but refresh incomplete | retain last_good_bar_time and age | bar_state_last_good |\n";
   text += "| hard absence | only after source/history checks prove no series | future health proof required before use | bar_state_hard_absence_proven |\n";
   return text;
  }

string ASC_SymbolDataPackDueOnlyTimeframeTableText()
  {
   string text = "| Timeframe | Recalculate When | Current Forming Update? | Guard |\n";
   text += "|---|---|---:|---|\n";
   text += "| M1 | new M1 bar / due M1 cadence | yes | precision/freshness only |\n";
   text += "| M5 | new M5 bar / due M5 cadence | yes | precision/freshness only |\n";
   text += "| M15 | new M15 bar / due M15 cadence | yes | intraday context priority |\n";
   text += "| M30 | new M30 bar / due M30 cadence | yes | no 10s full refetch contract |\n";
   text += "| H1 | new H1 bar / due H1 cadence | yes | no every-beat recalculation |\n";
   text += "| H4 | new H4 bar / due H4 cadence | yes | no every-beat recalculation |\n";
   text += "| D1 | new D1 bar or current high/low change | yes | numeric high/low facts only |\n";
   text += "| W1 | new W1 bar or current high/low change | yes | numeric high/low facts only |\n";
   text += "| MN1 | new MN1 bar or current high/low change | yes | numeric high/low facts only |\n";
   return text;
  }

#endif
