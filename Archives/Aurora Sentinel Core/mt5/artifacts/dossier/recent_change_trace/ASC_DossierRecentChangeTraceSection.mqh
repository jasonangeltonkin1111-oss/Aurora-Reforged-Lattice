#ifndef __ASC_DOSSIER_RECENT_CHANGE_TRACE_SECTION_MQH__
#define __ASC_DOSSIER_RECENT_CHANGE_TRACE_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierRecentChangeTraceSection(const string latest_meaningful_change,
                                                const string previous_meaningful_change,
                                                const string state_transition_notes,
                                                const string selection_transition_notes,
                                                const string publication_transition_notes,
                                                const string deep_analysis_transition_notes,
                                                const bool owner_truth_available,
                                                const bool transition_context_available,
                                                ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 6);
   values[0] = latest_meaningful_change;
   values[1] = previous_meaningful_change;
   values[2] = state_transition_notes;
   values[3] = selection_transition_notes;
   values[4] = publication_transition_notes;
   values[5] = deep_analysis_transition_notes;

   status_out.section_name = "recent_change_trace";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 6 - status_out.populated_fields;
   status_out.continuity_used = !owner_truth_available;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !transition_context_available)
      status_out.posture = "fallback";
   if(!transition_context_available)
      status_out.posture = "degraded";
   status_out.note = StringFormat("owner_truth_available=%s transition_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  transition_context_available ? "yes" : "no");

   string section = "\n===============================================================================\nCHANGE TRACE\n===============================================================================\n\n";
   section += StringFormat("Latest Meaningful Change: %s\n", latest_meaningful_change);
   section += StringFormat("Previous Meaningful Change: %s\n", previous_meaningful_change);
   section += StringFormat("State Transition Notes: %s\n", state_transition_notes);
   section += StringFormat("Selection Transition Notes: %s\n", selection_transition_notes);
   section += StringFormat("Publication Transition Notes: %s\n", publication_transition_notes);
   section += StringFormat("Deep Analysis Transition Notes: %s\n", deep_analysis_transition_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n";
   return section;
  }

#endif
