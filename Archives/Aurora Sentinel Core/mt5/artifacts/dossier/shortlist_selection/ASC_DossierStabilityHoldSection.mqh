#ifndef __ASC_DOSSIERSTABILITYHOLDSECTION_MQH__
#define __ASC_DOSSIERSTABILITYHOLDSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierShortlistStabilityHoldSection(const string hold_status,
                                                      const string stability_status,
                                                      const string replacement_pressure,
                                                      const string selection_continuity,
                                                      const string shortlist_notes,
                                                      const bool owner_truth_available,
                                                      const bool hold_continuity_context_available,
                                                      ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 5);
   values[0] = hold_status;
   values[1] = stability_status;
   values[2] = replacement_pressure;
   values[3] = selection_continuity;
   values[4] = shortlist_notes;

   status_out.section_name = "shortlist_stability_hold";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 5 - status_out.populated_fields;
   status_out.continuity_used = (StringFind(selection_continuity, "continuity-backed") >= 0);
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !owner_truth_available || !hold_continuity_context_available)
      status_out.posture = "fallback";
   if(status_out.continuity_used)
      status_out.posture = "degraded";
   if(!hold_continuity_context_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("owner_truth_available=%s hold_continuity_context_available=%s",
                                  owner_truth_available ? "yes" : "no",
                                  hold_continuity_context_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Shortlist Stability & Pressure\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Authority Hold: %s\n", hold_status);
   section += StringFormat("Stability / Bucket: %s\n", stability_status);
   section += StringFormat("Replacement Pressure: %s\n", replacement_pressure);
   section += StringFormat("Selection Continuity: %s\n", selection_continuity);
   section += StringFormat("Shortlist Notes: %s\n", shortlist_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
