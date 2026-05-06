#ifndef __ASC_DOSSIER_OPPORTUNITY_PATHS_SECTION_MQH__
#define __ASC_DOSSIER_OPPORTUNITY_PATHS_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"

string ASC_BuildDossierOpportunityPathsSection(const string primary_live_path,
                                               const string alternate_live_path,
                                               const string current_opportunity_status,
                                               const string path_stage_posture,
                                               const string horizon_posture,
                                               const string why_preserved,
                                               const string blocker_now,
                                               const string what_would_confirm,
                                               const string what_would_weaken,
                                               const string what_invalidates_or_demotes,
                                               const string revisit_trigger_summary,
                                               const string expiry_hint,
                                               const bool owner_truth_available,
                                               ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 12);
   values[0] = primary_live_path;
   values[1] = alternate_live_path;
   values[2] = current_opportunity_status;
   values[3] = path_stage_posture;
   values[4] = horizon_posture;
   values[5] = why_preserved;
   values[6] = blocker_now;
   values[7] = what_would_confirm;
   values[8] = what_would_weaken;
   values[9] = what_invalidates_or_demotes;
   values[10] = revisit_trigger_summary;
   values[11] = expiry_hint;

   status_out.section_name = "semi_auto_opportunity_paths";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 12 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = owner_truth_available ? "success" : "skipped";
   status_out.note = "consumer-only Layer-6 opportunity path readback fed from the dormant packet chain";

   string section = "------------------------------------------------------------------------------\n";
   section += "Opportunity Paths\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Primary Live Path: %s\n", primary_live_path);
   section += StringFormat("Alternate Live Path: %s\n", alternate_live_path);
   section += StringFormat("Current Opportunity Status: %s\n", current_opportunity_status);
   section += StringFormat("Path Stage Posture: %s\n", path_stage_posture);
   section += StringFormat("Horizon Posture: %s\n", horizon_posture);
   section += StringFormat("Why Preserved: %s\n", why_preserved);
   section += StringFormat("What Blocks Cleaner Deployment Now: %s\n", blocker_now);
   section += StringFormat("What Would Confirm: %s\n", what_would_confirm);
   section += StringFormat("What Would Weaken: %s\n", what_would_weaken);
   section += StringFormat("What Invalidates / Demotes: %s\n", what_invalidates_or_demotes);
   section += StringFormat("Revisit Trigger Summary: %s\n", revisit_trigger_summary);
   section += StringFormat("Expiry Hint: %s\n", expiry_hint);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
