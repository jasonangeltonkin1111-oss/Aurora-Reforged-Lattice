#ifndef __ASC_DOSSIERQUOTESNAPSHOTSECTION_MQH__
#define __ASC_DOSSIERQUOTESNAPSHOTSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierMarketWatchQuoteSnapshotSection(const string bid,
                                                       const string ask,
                                                       const string last,
                                                       const string spread,
                                                       const string spread_pct,
                                                       const string last_tick_time,
                                                       const string tick_age,
                                                       const string quote_freshness,
                                                       const string observed_time,
                                                       const string quote_continuity_status,
                                                       const string quote_unavailable_owner,
                                                       const string quote_unavailable_reason,
                                                       const string quote_unavailable_next_check,
                                                       const string quote_unavailable_symbol_select_state,
                                                       const string quote_unavailable_symbol_sync_state,
                                                       const string quote_unavailable_tick_success,
                                                       const string quote_unavailable_tick_last_error,
                                                       const string top5_quote_hydration_source,
                                                       const bool live_quote_available,
                                                       const bool continuity_backed,
                                                       const bool freshness_degraded_or_stale,
                                                       ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 10);
   values[0] = bid;
   values[1] = ask;
   values[2] = last;
   values[3] = spread;
   values[4] = spread_pct;
   values[5] = last_tick_time;
   values[6] = tick_age;
   values[7] = quote_freshness;
   values[8] = observed_time;
   values[9] = quote_continuity_status;

   status_out.section_name = "market_watch_quote_snapshot";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 10 - status_out.populated_fields;
   status_out.continuity_used = continuity_backed;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !live_quote_available || freshness_degraded_or_stale)
      status_out.posture = "fallback";
   if(continuity_backed || freshness_degraded_or_stale)
      status_out.posture = "degraded";
   if(!live_quote_available && !continuity_backed)
      status_out.posture = "skipped";
   status_out.note = StringFormat("live_quote_available=%s continuity_backed=%s freshness_degraded_or_stale=%s",
                                  live_quote_available ? "yes" : "no",
                                  continuity_backed ? "yes" : "no",
                                  freshness_degraded_or_stale ? "yes" : "no");

   bool quote_bid_ask_present = (bid != "unavailable" && ask != "unavailable" && StringLen(bid) > 0 && StringLen(ask) > 0);
   bool quote_blocks_actionability = !live_quote_available || continuity_backed || freshness_degraded_or_stale || !quote_bid_ask_present;
   string quote_currentness = ASC_DossierCurrentnessFromEvidence(live_quote_available && quote_bid_ask_present && !freshness_degraded_or_stale,
                                                               continuity_backed,
                                                               freshness_degraded_or_stale,
                                                               false,
                                                               !live_quote_available,
                                                               false,
                                                               !live_quote_available && !continuity_backed);

   string section = "------------------------------------------------------------------------------\n";
   section += "Quote Snapshot\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Bid: %s\n", bid);
   section += StringFormat("Ask: %s\n", ask);
   section += StringFormat("Last: %s\n", last);
   section += StringFormat("Spread: %s\n", spread);
   section += StringFormat("Spread %%: %s\n", spread_pct);
   section += StringFormat("Last Tick Time: %s\n", last_tick_time);
   section += StringFormat("Tick Age: %s\n", tick_age);
   section += StringFormat("Quote Freshness: %s\n", quote_freshness);
   section += StringFormat("Observed Time: %s\n", observed_time);
   section += StringFormat("Quote Continuity Status: %s\n", quote_continuity_status);
   section += "quote_owner=ASC_OpenSymbolSnapshotEngine | quote_currentness=" + quote_currentness + " | quote_tick_success=" + ASC_TextOrUnavailable(quote_unavailable_tick_success) + " | quote_tick_age_sec=" + ASC_TextOrUnavailable(tick_age) + " | quote_bid_ask_present=" + (quote_bid_ask_present ? "true" : "false") + " | quote_next_check=" + ASC_TextOrUnavailable(quote_unavailable_next_check) + " | quote_actionability_block=" + (quote_blocks_actionability ? "true" : "false") + "\n";
   section += ASC_DossierActionabilityImpactLine("quote",
                                                 quote_currentness,
                                                 "ASC_OpenSymbolSnapshotEngine",
                                                 (!live_quote_available ? quote_unavailable_reason : (freshness_degraded_or_stale ? "quote_stale_or_degraded" : "quote_owner_reported")),
                                                 quote_unavailable_next_check,
                                                 quote_blocks_actionability) + "\n";
   if(!live_quote_available || quote_unavailable_owner != "none")
     {
      section += StringFormat("quote_unavailable_owner=%s\n", ASC_TextOrUnavailable(quote_unavailable_owner));
      section += StringFormat("quote_unavailable_reason=%s\n", ASC_TextOrUnavailable(quote_unavailable_reason));
      section += StringFormat("quote_unavailable_next_check=%s\n", ASC_TextOrUnavailable(quote_unavailable_next_check));
      section += StringFormat("quote_unavailable_symbol_select_state=%s\n", ASC_TextOrUnavailable(quote_unavailable_symbol_select_state));
      section += StringFormat("quote_unavailable_symbol_sync_state=%s\n", ASC_TextOrUnavailable(quote_unavailable_symbol_sync_state));
      section += StringFormat("quote_unavailable_tick_success=%s\n", ASC_TextOrUnavailable(quote_unavailable_tick_success));
      section += StringFormat("quote_unavailable_tick_last_error=%s\n", ASC_TextOrUnavailable(quote_unavailable_tick_last_error));
      section += "quote_unavailable_actionability_block=true\n";
      section += StringFormat("top5_quote_hydration_source=%s\n", ASC_TextOrUnavailable(top5_quote_hydration_source));
     }
   section += ASC_DossierSectionClaimEvidenceLine(status_out,
                                               "market_watch_quote_snapshot",
                                               "ASC_OpenSymbolSnapshotEngine",
                                               (!live_quote_available ? ASC_TextOrUnavailable(quote_unavailable_reason) : (freshness_degraded_or_stale ? "quote_snapshot_stale_or_degraded" : (continuity_backed ? "continuity_backed_quote_snapshot" : "quote_snapshot_owner_reported"))),
                                               "next_open_symbol_snapshot_refresh",
                                               "quote_snapshot_claim_evidence") + "\n";
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
