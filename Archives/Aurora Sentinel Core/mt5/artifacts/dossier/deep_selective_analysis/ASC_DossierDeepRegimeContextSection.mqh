#ifndef __ASC_DOSSIER_DEEP_REGIME_CONTEXT_SECTION_MQH__
#define __ASC_DOSSIER_DEEP_REGIME_CONTEXT_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierDeepRegimeContextSection(const string market_regime,
                                                const string volatility_regime,
                                                const string liquidity_regime,
                                                const string session_regime,
                                                const string context_quality,
                                                const string context_notes,
                                                const bool owner_truth_available,
                                                const bool regime_context_available,
                                                ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 6);
   values[0] = market_regime;
   values[1] = volatility_regime;
   values[2] = liquidity_regime;
   values[3] = session_regime;
   values[4] = context_quality;
   values[5] = context_notes;

   status_out.section_name = "deep_regime_context";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 6 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !regime_context_available)
      status_out.posture = "fallback";
   if(!regime_context_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s regime_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  regime_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Regime & Context\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Market Regime: %s\n", market_regime);
   section += StringFormat("Volatility Regime: %s\n", volatility_regime);
   section += StringFormat("Liquidity Regime: %s\n", liquidity_regime);
   section += StringFormat("Session Regime: %s\n", session_regime);
   section += StringFormat("Context Quality: %s\n", context_quality);
   section += StringFormat("Context Notes: %s\n", context_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
