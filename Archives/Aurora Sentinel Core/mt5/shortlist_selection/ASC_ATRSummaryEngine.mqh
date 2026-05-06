#ifndef __ASC_ATR_SUMMARY_ENGINE_MQH__
#define __ASC_ATR_SUMMARY_ENGINE_MQH__

#include "../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"

struct ASC_SummaryAtrCacheEntry
  {
   string symbol;
   datetime computed_utc;
   datetime source_packet_utc;
   bool ready;
   double atr_points;
   int bars_used;
  };

ASC_SummaryAtrCacheEntry g_asc_summary_atr_cache[];

int ASC_SummaryAtrCacheFind(const string symbol)
  {
   for(int i = 0; i < ArraySize(g_asc_summary_atr_cache); i++)
     {
      if(g_asc_summary_atr_cache[i].symbol == symbol)
         return i;
     }
   return -1;
  }

double ASC_SummaryComputeDailyAtrPoints(const string symbol,const double point_value,const int period,int &bars_used)
  {
   bars_used = 0;
   if(StringLen(symbol) <= 0 || point_value <= 0.0 || period < 2)
      return 0.0;

   MqlRates rates[];
   ArraySetAsSeries(rates, true);
   int required = period + 2;
   int copied = CopyRates(symbol, PERIOD_D1, 0, required, rates);
   if(copied < period + 1)
      return 0.0;

   double tr_sum = 0.0;
   int samples = 0;
   for(int i = 1; i <= period; i++)
     {
      if(i + 1 >= copied)
         break;

      double high = rates[i].high;
      double low = rates[i].low;
      double prev_close = rates[i + 1].close;
      if(high <= 0.0 || low <= 0.0 || prev_close <= 0.0 || high < low)
         continue;

      double tr = MathMax(high - low, MathMax(MathAbs(high - prev_close), MathAbs(low - prev_close)));
      if(tr <= 0.0)
         continue;
      tr_sum += tr;
      samples++;
     }

   bars_used = samples;
   if(samples < period)
      return 0.0;
   double atr_price = tr_sum / samples;
   if(atr_price <= 0.0)
      return 0.0;
   return atr_price / point_value;
  }

bool ASC_SummaryAtrReady(const ASC_Layer2Packet &packet)
  {
   if(packet.point <= 0.0 || StringLen(packet.symbol) <= 0)
      return false;

   int cache_index = ASC_SummaryAtrCacheFind(packet.symbol);
   datetime now_utc = TimeGMT();
   bool cache_fresh = false;
   if(cache_index >= 0)
     {
      ASC_SummaryAtrCacheEntry cache_entry = g_asc_summary_atr_cache[cache_index];
      cache_fresh = (cache_entry.computed_utc > 0
                     && (now_utc - cache_entry.computed_utc) <= 300
                     && cache_entry.source_packet_utc >= packet.last_built_utc);
      if(cache_fresh)
         return cache_entry.ready;
     }

   int bars_used = 0;
   double atr_points = ASC_SummaryComputeDailyAtrPoints(packet.symbol, packet.point, 14, bars_used);
   bool atr_ready = (atr_points > 0.0 && bars_used >= 14);

   if(cache_index < 0)
     {
      cache_index = ArraySize(g_asc_summary_atr_cache);
      ArrayResize(g_asc_summary_atr_cache, cache_index + 1);
      g_asc_summary_atr_cache[cache_index].symbol = packet.symbol;
     }

   g_asc_summary_atr_cache[cache_index].computed_utc = now_utc;
   g_asc_summary_atr_cache[cache_index].source_packet_utc = packet.last_built_utc;
   g_asc_summary_atr_cache[cache_index].ready = atr_ready;
   g_asc_summary_atr_cache[cache_index].atr_points = atr_points;
   g_asc_summary_atr_cache[cache_index].bars_used = bars_used;

   if(!atr_ready && ASC_L2PacketHasLawfulDayRange(packet) && packet.day_range_points > 0.0 && packet.freshness == ASC_L2_FRESH)
     {
      g_asc_summary_atr_cache[cache_index].ready = true;
      g_asc_summary_atr_cache[cache_index].atr_points = packet.day_range_points;
      g_asc_summary_atr_cache[cache_index].bars_used = 1;
      return true;
     }

   if(!g_asc_summary_atr_cache[cache_index].ready)
      return false;
   return true;
  }

double ASC_SummaryAtrValue(const ASC_Layer2Packet &packet)
  {
   if(!ASC_SummaryAtrReady(packet))
      return 0.0;
   int cache_index = ASC_SummaryAtrCacheFind(packet.symbol);
   if(cache_index < 0)
      return 0.0;
   return g_asc_summary_atr_cache[cache_index].atr_points;
  }


string ASC_SummaryAtrSampleStatusToken(const ASC_Layer2Packet &packet)
  {
   int cache_index = ASC_SummaryAtrCacheFind(packet.symbol);
   if(cache_index < 0)
      return "unknown";
   ASC_SummaryAtrCacheEntry cache_entry = g_asc_summary_atr_cache[cache_index];
   if(cache_entry.ready && cache_entry.bars_used >= 14)
      return "sufficient";
   if(cache_entry.ready && cache_entry.bars_used > 0)
      return "partial";
   return "insufficient";
  }

string ASC_SummaryAtrFreshnessStatusToken(const ASC_Layer2Packet &packet)
  {
   int cache_index = ASC_SummaryAtrCacheFind(packet.symbol);
   datetime now_utc = TimeGMT();
   if(cache_index < 0)
      return "unknown";
   ASC_SummaryAtrCacheEntry cache_entry = g_asc_summary_atr_cache[cache_index];
   if(cache_entry.source_packet_utc < packet.last_built_utc)
      return "stale";
   if(cache_entry.computed_utc <= 0)
      return "unknown";
   if((now_utc - cache_entry.computed_utc) > 300)
      return "stale";
   if(packet.freshness == ASC_L2_CONTINUITY)
      return "retained";
   if(packet.freshness == ASC_L2_DEGRADED)
      return "degraded";
   if(packet.freshness == ASC_L2_STALE)
      return "stale";
   if(packet.freshness == ASC_L2_AGING)
      return "partial";
   if(packet.freshness == ASC_L2_FRESH)
      return "fresh";
   return "unknown";
  }

string ASC_SummaryAtrValidityStatusToken(const ASC_Layer2Packet &packet)
  {
   string freshness = ASC_SummaryAtrFreshnessStatusToken(packet);
   string sample = ASC_SummaryAtrSampleStatusToken(packet);
   if(freshness == "fresh" && sample == "sufficient")
      return "valid";
   if(sample == "partial" || freshness == "partial" || freshness == "retained")
      return "limited";
   if(freshness == "degraded" || freshness == "stale")
      return "degraded";
   if(sample == "insufficient")
      return "unavailable";
   return "unknown";
  }

string ASC_SummaryAtrFalsifierToken(const ASC_Layer2Packet &packet)
  {
   string freshness = ASC_SummaryAtrFreshnessStatusToken(packet);
   string sample = ASC_SummaryAtrSampleStatusToken(packet);
   if(freshness == "stale" || freshness == "retained" || freshness == "degraded")
      return "stale_input";
   if(sample == "insufficient" || sample == "partial")
      return "insufficient_sample";
   if(!ASC_SummaryAtrReady(packet))
      return "unavailable_dependency";
   return "not_applicable";
  }

string ASC_SummaryAtrMetricProofToken(const ASC_Layer2Packet &packet)
  {
   // RUN057: compact metric-validity proof only; no ATR formula, cadence, or strategy behavior changes.
   bool ready = ASC_SummaryAtrReady(packet);
   string sample = ASC_SummaryAtrSampleStatusToken(packet);
   string freshness = ASC_SummaryAtrFreshnessStatusToken(packet);
   string validity = ASC_SummaryAtrValidityStatusToken(packet);
   string falsifier = ASC_SummaryAtrFalsifierToken(packet);
   string artifact_projection = ready ? ((validity == "valid") ? "allowed" : "qualified") : "blocked";
   string input_source = (sample == "sufficient") ? "copyrates" : ((sample == "partial") ? "mixed" : "l1_l2_live");
   return "metric_domain=atr_summary | metric_purpose=context_only | trade_permission=false | entry_signal=false | metric_owner=ASC_ATRSummaryEngine.ASC_SummaryAtrReady | input_source=" + input_source
          + " | freshness_status=" + freshness
          + " | sample_status=" + sample
          + " | timeframe_coverage=" + ((sample == "sufficient") ? "complete" : ((sample == "partial") ? "partial" : "missing"))
          + " | tick_window_status=not_applicable | validity_status=" + validity
          + " | falsifier=" + falsifier
          + " | artifact_projection=" + artifact_projection
          + " | behavior_change=no";
  }

bool ASC_SummarySpreadAtrReady(const ASC_Layer2Packet &packet)
  {
   if(!packet.valid_spread)
      return false;
   double atr = ASC_SummaryAtrValue(packet);
   if(atr <= 0.0)
      return false;
   return true;
  }

double ASC_SummarySpreadAtr(const ASC_Layer2Packet &packet)
  {
   if(!ASC_SummarySpreadAtrReady(packet))
      return -1.0;
   double atr = ASC_SummaryAtrValue(packet);
   return packet.spread_points / atr;
  }

#endif
