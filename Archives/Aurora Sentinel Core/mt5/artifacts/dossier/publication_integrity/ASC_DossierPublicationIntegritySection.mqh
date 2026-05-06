#ifndef __ASC_DOSSIERPUBLICATIONINTEGRITYSECTION_MQH__
#define __ASC_DOSSIERPUBLICATIONINTEGRITYSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"
#include "../../ASC_ArtifactTextHelpers.mqh"


string ASC_BuildDossierPublicationIntegritySection(const string publication_status,
                                                   const string last_published,
                                                   const string last_good_fallback,
                                                   const string current_bundle_status,
                                                   const string continuity_mode,
                                                   const string missing_delayed_areas,
                                                   const string integrity_notes,
                                                   const string surface_truth_line,
                                                   const string surface_provenance_line,
                                                   ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 9);
   values[0] = publication_status;
   values[1] = last_published;
   values[2] = last_good_fallback;
   values[3] = current_bundle_status;
   values[4] = continuity_mode;
   values[5] = missing_delayed_areas;
   values[6] = integrity_notes;
   values[7] = surface_truth_line;
   values[8] = surface_provenance_line;

   status_out.section_name = "publication_integrity";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 9 - status_out.populated_fields;
   status_out.continuity_used = (StringFind(continuity_mode, "Retained") >= 0
                                 || StringFind(continuity_mode, "degraded") >= 0
                                 || StringFind(continuity_mode, "stale") >= 0
                                 || StringFind(continuity_mode, "delayed") >= 0);
   status_out.posture = "success";
   if(status_out.missing_fields > 0)
      status_out.posture = "fallback";
   if(status_out.continuity_used || StringFind(current_bundle_status, "Partial") >= 0)
      status_out.posture = "degraded";
   status_out.note = (StringLen(missing_delayed_areas) > 0 && missing_delayed_areas != "none")
                     ? "integrity has known delayed areas"
                     : "integrity values are fully populated";
   if(status_out.continuity_used)
      status_out.note = "integrity continuity posture is active";

   string section = "\n===============================================================================\n";
   section += "PUBLICATION HEALTH\n";
   section += "===============================================================================\n\n";
   section += StringFormat("Publication Status: %s\n", publication_status);
   section += StringFormat("Last Published: %s\n", last_published);
   section += StringFormat("Last Good Fallback: %s\n", last_good_fallback);
   section += StringFormat("Current Bundle Status: %s\n", current_bundle_status);
   section += StringFormat("Continuity Mode: %s\n", continuity_mode);
   section += StringFormat("Missing / Delayed Areas: %s\n", missing_delayed_areas);
   section += StringFormat("Integrity Notes: %s\n", integrity_notes);
   section += StringFormat("Surface Truth: %s\n", surface_truth_line);
   section += surface_provenance_line + "\n";
   section += "Claim Evidence: " + ASC_ClaimEvidenceStarterPolicyLine() + "\n";
   section += "Claim Evidence Detail: " + ASC_ClaimEvidenceLine(status_out.continuity_used ? "retained_last_good" : (status_out.missing_fields > 0 ? "unavailable_source_missing" : "available_current"),
                                                               "dossier_publication_integrity",
                                                               "ASC_DossierComposer/ASC_DossierPublicationIntegritySection",
                                                               status_out.continuity_used ? "continuity_or_degraded_publication_context_active" : (status_out.missing_fields > 0 ? "one_or_more_publication_integrity_fields_missing" : "publication_integrity_fields_populated"),
                                                               "next_dossier_publication_or_selected_symbol_refresh",
                                                               status_out.continuity_used ? "retained" : (status_out.missing_fields > 0 ? "not_current" : "current"),
                                                               status_out.missing_fields > 0,
                                                               status_out.missing_fields > 0 ? "inspect_source" : "none",
                                                               status_out.missing_fields > 0 ? "medium" : "high",
                                                               "dossier_publication_integrity_claim_evidence") + "\n";
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n";
   return section;
  }

#endif
