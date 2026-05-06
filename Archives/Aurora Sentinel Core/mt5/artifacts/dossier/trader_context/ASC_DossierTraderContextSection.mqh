#ifndef __ASC_DOSSIER_TRADER_CONTEXT_SECTION_MQH__
#define __ASC_DOSSIER_TRADER_CONTEXT_SECTION_MQH__

string ASC_BuildDossierTraderContextSection(const string risk_context,
                                            const string execution_constraints,
                                            const int open_trade_conflict,
                                            const int pending_order_conflict,
                                            const string watchlist_priority,
                                            const string what_changed_recently,
                                            const string what_needs_recheck)
  {
   string section = "";
   section += StringFormat("Risk Context: %s\n", risk_context);
   section += StringFormat("Execution Constraints: %s\n", execution_constraints);
   section += StringFormat("Open Trade Conflict: %d\n", open_trade_conflict);
   section += StringFormat("Pending Order Conflict: %d\n", pending_order_conflict);
   section += StringFormat("Watchlist Priority: %s\n", watchlist_priority);
   section += StringFormat("What Changed Recently: %s\n", what_changed_recently);
   section += StringFormat("What Needs Recheck: %s\n", what_needs_recheck);
   return section;
  }

#endif
