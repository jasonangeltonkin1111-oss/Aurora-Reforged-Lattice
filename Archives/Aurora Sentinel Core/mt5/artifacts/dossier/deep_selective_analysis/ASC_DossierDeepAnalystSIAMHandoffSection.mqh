#ifndef __ASC_DOSSIER_DEEP_ANALYST_SIAM_HANDOFF_SECTION_MQH__
#define __ASC_DOSSIER_DEEP_ANALYST_SIAM_HANDOFF_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierDeepAnalystSiamHandoffSection(const string what_matters_most,
                                                     const string best_supporting_evidence,
                                                     const string biggest_warning,
                                                     const string what_is_still_missing,
                                                     const string what_to_check_next,
                                                     const string handoff_summary,
                                                     const bool owner_truth_available,
                                                     const bool handoff_context_available,
                                                     ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 6);
   values[0] = what_matters_most;
   values[1] = best_supporting_evidence;
   values[2] = biggest_warning;
   values[3] = what_is_still_missing;
   values[4] = what_to_check_next;
   values[5] = handoff_summary;

   status_out.section_name = "deep_analyst_siam_handoff";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 6 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !handoff_context_available)
      status_out.posture = "fallback";
   if(!handoff_context_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s handoff_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  handoff_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Analyst / SIAM Handoff\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("What Matters Most: %s\n", what_matters_most);
   section += StringFormat("Best Supporting Evidence: %s\n", best_supporting_evidence);
   section += StringFormat("Biggest Warning: %s\n", biggest_warning);
   section += StringFormat("What Is Still Missing: %s\n", what_is_still_missing);
   section += StringFormat("What To Check Next: %s\n", what_to_check_next);
   section += StringFormat("Handoff Summary: %s\n", handoff_summary);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
