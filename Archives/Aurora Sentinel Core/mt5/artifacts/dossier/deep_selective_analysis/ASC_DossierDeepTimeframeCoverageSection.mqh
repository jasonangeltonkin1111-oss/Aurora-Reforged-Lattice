#ifndef __ASC_DOSSIER_DEEP_TIMEFRAME_COVERAGE_SECTION_MQH__
#define __ASC_DOSSIER_DEEP_TIMEFRAME_COVERAGE_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierDeepTimeframeCoverageSection(const string enabled_timeframes,
                                                    const string bars_per_timeframe,
                                                    const string coverage_sufficiency,
                                                    const string missing_timeframes,
                                                    const string coverage_notes,
                                                    const bool owner_truth_available,
                                                    const bool timeframe_bar_context_available,
                                                    ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 5);
   values[0] = enabled_timeframes;
   values[1] = bars_per_timeframe;
   values[2] = coverage_sufficiency;
   values[3] = missing_timeframes;
   values[4] = coverage_notes;

   status_out.section_name = "deep_timeframe_coverage";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 5 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !timeframe_bar_context_available)
      status_out.posture = "fallback";
   if(!timeframe_bar_context_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s timeframe_bar_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  timeframe_bar_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Timeframe Coverage\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Enabled Timeframes: %s\n", enabled_timeframes);
   section += StringFormat("Bars per Timeframe: %s\n", bars_per_timeframe);
   section += StringFormat("Coverage Sufficiency: %s\n", coverage_sufficiency);
   section += StringFormat("Missing Timeframes: %s\n", missing_timeframes);
   section += StringFormat("Coverage Notes: %s\n", coverage_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
