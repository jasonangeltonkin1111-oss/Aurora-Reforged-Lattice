#ifndef __ASC_DOSSIERMARKETSTATETIMINGSECTION_MQH__
#define __ASC_DOSSIERMARKETSTATETIMINGSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierMarketStateTimingSection(const string last_checked,
                                                const string next_check_due,
                                                const string state_freshness,
                                                const string state_confidence,
                                                const string bid_ask_presence,
                                                const string state_notes,
                                                const bool freshness_degraded_or_stale,
                                                const bool confidence_available,
                                                ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 6);
   values[0] = last_checked;
   values[1] = next_check_due;
   values[2] = state_freshness;
   values[3] = state_confidence;
   values[4] = bid_ask_presence;
   values[5] = state_notes;

   status_out.section_name = "market_state_timing";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 6 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || freshness_degraded_or_stale || !confidence_available)
      status_out.posture = "fallback";
   if(freshness_degraded_or_stale && !confidence_available)
      status_out.posture = "degraded";
   status_out.note = StringFormat("freshness_degraded_or_stale=%s confidence_available=%s",
                                  freshness_degraded_or_stale ? "yes" : "no",
                                  confidence_available ? "yes" : "no");

   string timing_currentness = ASC_DossierCurrentnessFromEvidence(!freshness_degraded_or_stale && confidence_available && status_out.missing_fields <= 0,
                                                                  false,
                                                                  freshness_degraded_or_stale,
                                                                  status_out.missing_fields > 0,
                                                                  !confidence_available,
                                                                  false,
                                                                  !confidence_available);
   bool timing_actionability_block = (timing_currentness != "current_live" && timing_currentness != "current_committed_snapshot");

   string section = "------------------------------------------------------------------------------\n";
   section += "State Timing\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Last Checked: %s\n", last_checked);
   section += StringFormat("Next Check Due: %s\n", next_check_due);
   section += StringFormat("State Freshness: %s\n", state_freshness);
   section += StringFormat("State Confidence: %s\n", state_confidence);
   section += StringFormat("Bid / Ask Presence: %s\n", bid_ask_presence);
   section += StringFormat("State Notes: %s\n", state_notes);
   section += ASC_DossierActionabilityImpactLine("market_state",
                                                 timing_currentness,
                                                 "ASC_MarketStateEngine",
                                                 state_notes,
                                                 next_check_due,
                                                 timing_actionability_block) + "\n";
   section += "market_state_owner=ASC_MarketStateEngine | market_state_currentness=" + timing_currentness + " | market_state_next_check=" + ASC_TextOrUnavailable(next_check_due) + " | market_state_actionability_block=" + (timing_actionability_block ? "true" : "false") + "\n";
   section += ASC_DossierSectionClaimEvidenceLine(status_out,
                                               "market_state_timing",
                                               "ASC_MarketStateEngine",
                                               (freshness_degraded_or_stale ? "awaiting_next_market_state_check" : (!confidence_available ? "market_state_confidence_unavailable" : "market_state_timing_owner_reported")),
                                               "next_market_state_check",
                                               "market_state_timing_claim_evidence") + "\n";
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n";
   return section;
  }

#endif
