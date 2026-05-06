#ifndef __ASC_DOSSIER_DEEP_TRADE_FRAMING_SUPPORT_SECTION_MQH__
#define __ASC_DOSSIER_DEEP_TRADE_FRAMING_SUPPORT_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierDeepTradeFramingSupportSection(const string directional_bias_support,
                                                      const string continuation_support,
                                                      const string reversal_risk,
                                                      const string breakout_support,
                                                      const string fade_risk,
                                                      const string invalidation_context,
                                                      const string trade_framing_notes,
                                                      const bool owner_truth_available,
                                                      const bool trade_framing_context_available,
                                                      ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 7);
   values[0] = directional_bias_support;
   values[1] = continuation_support;
   values[2] = reversal_risk;
   values[3] = breakout_support;
   values[4] = fade_risk;
   values[5] = invalidation_context;
   values[6] = trade_framing_notes;

   status_out.section_name = "deep_trade_framing_support";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 7 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !trade_framing_context_available)
      status_out.posture = "fallback";
   if(!trade_framing_context_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s trade_framing_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  trade_framing_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Trade Framing\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Directional Bias Support: %s\n", directional_bias_support);
   section += StringFormat("Continuation Support: %s\n", continuation_support);
   section += StringFormat("Reversal Risk: %s\n", reversal_risk);
   section += StringFormat("Breakout Support: %s\n", breakout_support);
   section += StringFormat("Fade Risk: %s\n", fade_risk);
   section += StringFormat("Invalidation Context: %s\n", invalidation_context);
   section += StringFormat("Trade Framing Notes: %s\n", trade_framing_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
