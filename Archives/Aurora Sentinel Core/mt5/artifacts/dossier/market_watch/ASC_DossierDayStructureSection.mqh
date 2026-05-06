#ifndef __ASC_DOSSIERDAYSTRUCTURESECTION_MQH__
#define __ASC_DOSSIERDAYSTRUCTURESECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierDayStructureSection(const string day_open,
                                          const string day_high,
                                          const string day_low,
                                          const string daily_change_pct,
                                          const string day_range,
                                          const string day_range_pct,
                                          const string intraday_range_position,
                                          const string market_direction_snapshot,
                                          const string price_action_snapshot)
  {
   string section = "";
   ASC_DossierAppendSubgroupHeader(section, "Day Structure");
   section += StringFormat("Daily Open: %s\n", day_open);
   section += StringFormat("Daily High: %s\n", day_high);
   section += StringFormat("Daily Low: %s\n", day_low);
   section += StringFormat("Daily Change %%: %s\n", daily_change_pct);
   section += StringFormat("Day Range: %s\n", day_range);
   section += StringFormat("Day Range %%: %s\n", day_range_pct);
   section += StringFormat("Intraday Range Position: %s\n", intraday_range_position);
   section += StringFormat("Market Direction Snapshot: %s\n", market_direction_snapshot);
   section += StringFormat("Price Action Snapshot: %s\n\n", price_action_snapshot);
   return section;
  }

#endif
