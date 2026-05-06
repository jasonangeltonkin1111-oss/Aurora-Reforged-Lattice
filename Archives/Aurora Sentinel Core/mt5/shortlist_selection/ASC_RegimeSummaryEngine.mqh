#ifndef __ASC_REGIME_SUMMARY_ENGINE_MQH__
#define __ASC_REGIME_SUMMARY_ENGINE_MQH__

#include "../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"
#include "ASC_ATRSummaryEngine.mqh"

string ASC_SummaryRegimeLabel(const ASC_Layer2Packet &packet)
  {
   if(packet.freshness == ASC_L2_STALE || packet.freshness == ASC_L2_DEGRADED || packet.freshness == ASC_L2_CONTINUITY)
      return "Guarded";
   if(!ASC_SummaryAtrReady(packet))
      return "Unavailable";
   if(packet.bid <= 0.0 || packet.day_range_pct <= 0.0)
      return "Unavailable";

   double spread_atr = ASC_SummarySpreadAtr(packet);
   double atr_value = ASC_SummaryAtrValue(packet);
   if(atr_value <= 0.0)
      return "Unavailable";

   double atr_pct = ((atr_value * packet.point) / packet.bid) * 100.0;
   if(atr_pct <= 0.0)
      return "Unavailable";

   bool spread_support_ready = (spread_atr >= 0.0);
   if(!spread_support_ready)
      spread_atr = 0.65;

   if(packet.day_range_pct >= (atr_pct * 1.20) && spread_atr <= 0.60)
      return "Expansion";
   if(packet.day_range_pct <= (atr_pct * 0.55) || spread_atr >= 1.10)
      return "Compression";
   return "Balanced";
  }

string ASC_SummaryContextQuality(const ASC_Layer2Packet &packet)
  {
   if(packet.freshness == ASC_L2_DEGRADED || packet.freshness == ASC_L2_STALE)
      return "Weak";
   if(packet.freshness == ASC_L2_CONTINUITY)
      return "Guarded";
   if(!ASC_SummaryAtrReady(packet))
      return "Unavailable";

   double spread_pct = (packet.bid > 0.0) ? ((packet.spread_points * packet.point) / packet.bid) * 100.0 : -1.0;
   double spread_atr = ASC_SummarySpreadAtr(packet);
   if(spread_atr < 0.0 || spread_pct < 0.0)
      return "Guarded";
   if(packet.day_range_pct <= 0.0 || !ASC_L2PacketHasLawfulDayRange(packet))
      return "Unavailable";
   if(spread_pct <= 0.050 && spread_atr <= 0.30 && packet.day_range_pct >= 0.35)
      return "Strong";
   if(spread_pct <= 0.150 && spread_atr <= 0.70 && packet.day_range_pct >= 0.20)
      return "Balanced";
   if(spread_pct <= 0.300 && spread_atr <= 1.10)
      return "Guarded";
   return "Guarded";
  }

#endif
