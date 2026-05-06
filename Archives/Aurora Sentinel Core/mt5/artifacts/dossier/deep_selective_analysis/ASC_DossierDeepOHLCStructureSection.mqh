#ifndef __ASC_DOSSIER_DEEP_OHLC_STRUCTURE_SECTION_MQH__
#define __ASC_DOSSIER_DEEP_OHLC_STRUCTURE_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierDeepOHLCStructureSection(const string higher_timeframe_structure,
                                                const string trend_structure,
                                                const string range_expansion_structure,
                                                const string impulse_pullback_structure,
                                                const string break_reclaim_rejection_notes,
                                                const string ohlc_evidence_status,
                                                const string ohlc_evidence_block,
                                                const bool owner_truth_available,
                                                const bool ohlc_context_available,
                                                const int projected_timeframe_count,
                                                const int total_bars_projected,
                                                const bool full_ohlc_available,
                                                ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 6);
   values[0] = higher_timeframe_structure;
   values[1] = trend_structure;
   values[2] = range_expansion_structure;
   values[3] = impulse_pullback_structure;
   values[4] = break_reclaim_rejection_notes;
   values[5] = ohlc_evidence_status;

   status_out.section_name = "deep_ohlc_structure";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 6 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !ohlc_context_available)
      status_out.posture = "fallback";
   if(!ohlc_context_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s ohlc_context_available=%s timeframe_count=%d total_bars=%d full_ohlc_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  ohlc_context_available ? "yes" : "no",
                                  projected_timeframe_count,
                                  total_bars_projected,
                                  full_ohlc_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "OHLC Structure\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Higher-Timeframe Structure: %s\n", higher_timeframe_structure);
   section += StringFormat("Trend Structure: %s\n", trend_structure);
   section += StringFormat("Range / Expansion Structure: %s\n", range_expansion_structure);
   section += StringFormat("Impulse / Pullback Structure: %s\n", impulse_pullback_structure);
   section += StringFormat("Break / Reclaim / Rejection Notes: %s\n", break_reclaim_rejection_notes);
   section += StringFormat("OHLC Evidence Status: %s\n", ohlc_evidence_status);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
