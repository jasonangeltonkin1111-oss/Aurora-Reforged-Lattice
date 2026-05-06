#ifndef __ASC_DOSSIERMARKETSTATECORESECTION_MQH__
#define __ASC_DOSSIERMARKETSTATECORESECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierMarketStateCoreSection(const string market_status,
                                              const string tradeability_status,
                                              const string session_status,
                                              const string open_closed_uncertain,
                                              const string open_closed_uncertain_reason,
                                              const bool state_uncertain_or_degraded,
                                              const bool tradeability_available,
                                              ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 5);
   values[0] = market_status;
   values[1] = tradeability_status;
   values[2] = session_status;
   values[3] = open_closed_uncertain;
   values[4] = open_closed_uncertain_reason;

   status_out.section_name = "market_state_core";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 5 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || state_uncertain_or_degraded || !tradeability_available)
      status_out.posture = "fallback";
   if(state_uncertain_or_degraded && !tradeability_available)
      status_out.posture = "degraded";
   status_out.note = StringFormat("state_uncertain_or_degraded=%s tradeability_available=%s",
                                  state_uncertain_or_degraded ? "yes" : "no",
                                  tradeability_available ? "yes" : "no");

   string state_token = ASC_DossierNormalizeTokenText(open_closed_uncertain);
   bool market_state_blocks_actionability = state_uncertain_or_degraded || !tradeability_available || state_token == "closed" || state_token == "closed confirmed" || state_token == "uncertain" || state_token == "unknown";
   string market_state_currentness = ASC_DossierCurrentnessFromEvidence(!market_state_blocks_actionability,
                                                                       false,
                                                                       state_uncertain_or_degraded,
                                                                       status_out.missing_fields > 0,
                                                                       !tradeability_available,
                                                                       state_token == "closed" || state_token == "closed confirmed",
                                                                       state_token == "unknown" || state_token == "uncertain");

   string section = "------------------------------------------------------------------------------\n";
   section += "State Overview\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Market Status: %s\n", market_status);
   section += StringFormat("Tradability Status: %s\n", tradeability_status);
   section += StringFormat("Session Status: %s\n", session_status);
   section += StringFormat("Open / Closed / Uncertain: %s\n", open_closed_uncertain);
   section += StringFormat("Open / Closed / Uncertain Reason: %s\n", open_closed_uncertain_reason);
   section += ASC_DossierCurrentnessActionabilityTaxonomyLine() + "\n";
   section += ASC_DossierActionabilityImpactLine("market_state",
                                                 market_state_currentness,
                                                 "ASC_MarketStateEngine",
                                                 open_closed_uncertain_reason,
                                                 "next_market_state_check",
                                                 market_state_blocks_actionability) + "\n";
   section += "market_state_owner=ASC_MarketStateEngine | market_state_currentness=" + market_state_currentness + " | market_state_actionability_block=" + (market_state_blocks_actionability ? "true" : "false") + " | market_state_next_check=next_market_state_check | market_state_uncertain_blocks_actionability=" + ((state_token == "uncertain" || state_uncertain_or_degraded) ? "true" : "false") + " | market_state_unknown_blocks_actionability=" + (state_token == "unknown" ? "true" : "false") + "\n";
   section += ASC_DossierSectionClaimEvidenceLine(status_out,
                                               "market_state_core",
                                               "ASC_MarketStateEngine",
                                               open_closed_uncertain_reason,
                                               "next_market_state_check",
                                               "market_state_core_currentness_actionability_claim_evidence") + "\n";
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
