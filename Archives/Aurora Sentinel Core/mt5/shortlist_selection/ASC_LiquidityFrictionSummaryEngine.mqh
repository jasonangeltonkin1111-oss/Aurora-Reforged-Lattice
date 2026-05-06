#ifndef __ASC_LIQUIDITY_FRICTION_SUMMARY_ENGINE_MQH__
#define __ASC_LIQUIDITY_FRICTION_SUMMARY_ENGINE_MQH__

#include "../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"
#include "ASC_ATRSummaryEngine.mqh"

double ASC_SummarySpreadPct(const ASC_Layer2Packet &packet)
  {
   if(!packet.valid_spread || packet.point <= 0.0)
      return -1.0;
   double spread_abs = packet.spread_points * packet.point;
   double reference_price = packet.bid;
   if(reference_price <= 0.0 && packet.valid_day_open)
      reference_price = packet.day_open;
   if(reference_price <= 0.0 || spread_abs < 0.0)
      return -1.0;
   return (spread_abs / reference_price) * 100.0;
  }

string ASC_SummaryLiquidityLabel(const ASC_Layer2Packet &packet)
  {
   if(packet.freshness == ASC_L2_CONTINUITY)
      return "Guarded";
   double spread_pct = ASC_SummarySpreadPct(packet);
   double spread_atr = ASC_SummarySpreadAtr(packet);
   if(spread_pct < 0.0)
      return "Unavailable";
   if(packet.freshness == ASC_L2_STALE || packet.freshness == ASC_L2_DEGRADED)
      return "Weak";
   if(spread_atr < 0.0)
     {
      if(spread_pct <= 0.060)
         return "Strong";
      if(spread_pct <= 0.150)
         return "Moderate";
      return "Weak";
     }
   if(spread_pct <= 0.060 && spread_atr <= 0.35)
      return "Strong";
   if(spread_pct <= 0.150 && spread_atr <= 0.75)
      return "Moderate";
   return "Weak";
  }

string ASC_SummaryFrictionClass(const ASC_Layer2Packet &packet)
  {
   if(packet.freshness == ASC_L2_CONTINUITY)
      return "Elevated";
   double spread_pct = ASC_SummarySpreadPct(packet);
   double spread_atr = ASC_SummarySpreadAtr(packet);
   if(spread_pct < 0.0)
      return "Unavailable";
   if(spread_atr < 0.0)
      return spread_pct <= 0.080 ? "Controlled" : "Elevated";
   if(spread_pct <= 0.060 && spread_atr <= 0.35)
      return "Controlled";
   if(spread_pct <= 0.150 && spread_atr <= 0.75)
      return "Elevated";
   return "High";
  }

#endif
