#ifndef __ASC_DOSSIER_GEOMETRY_WORKBENCH_SECTION_MQH__
#define __ASC_DOSSIER_GEOMETRY_WORKBENCH_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"

string ASC_BuildDossierGeometryWorkbenchSection(const string geometry_validity_posture,
                                                const string primary_geometry_candidate,
                                                const string alternate_geometry_candidate,
                                                const string entry_path,
                                                const string invalidation_path,
                                                const string target_path,
                                                const string timebox_posture,
                                                const string execution_burden,
                                                const string review_burden,
                                                const string timing_posture,
                                                const string geometry_reason_summary,
                                                const string blocker_or_insufficiency,
                                                const string geometry_resolution_note,
                                                const bool visible,
                                                ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 13);
   values[0] = geometry_validity_posture;
   values[1] = primary_geometry_candidate;
   values[2] = alternate_geometry_candidate;
   values[3] = entry_path;
   values[4] = invalidation_path;
   values[5] = target_path;
   values[6] = timebox_posture;
   values[7] = execution_burden;
   values[8] = review_burden;
   values[9] = timing_posture;
   values[10] = geometry_reason_summary;
   values[11] = blocker_or_insufficiency;
   values[12] = geometry_resolution_note;

   status_out.section_name = "semi_auto_geometry_workbench";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 13 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = visible ? "success" : "skipped";
   status_out.note = "consumer-only Layer-6 geometry workbench remains bounded and non-owning";

   string section = "";
   section += "Geometry Workbench\n";
   section += "----------------------------------------\n";
   section += StringFormat("Geometry Validity Posture: %s\n", geometry_validity_posture);
   section += StringFormat("Primary Geometry Candidate: %s\n", primary_geometry_candidate);
   section += StringFormat("Alternate Geometry Candidate: %s\n", alternate_geometry_candidate);
   section += StringFormat("Entry Path: %s\n", entry_path);
   section += StringFormat("Invalidation Path: %s\n", invalidation_path);
   section += StringFormat("Target Path: %s\n", target_path);
   section += StringFormat("Timebox Posture: %s\n", timebox_posture);
   section += StringFormat("Execution Burden: %s\n", execution_burden);
   section += StringFormat("Review Burden: %s\n", review_burden);
   section += StringFormat("Timing Posture: %s\n", timing_posture);
   section += StringFormat("Geometry Reason: %s\n", geometry_reason_summary);
   section += StringFormat("Blocker / Insufficiency: %s\n", blocker_or_insufficiency);
   section += StringFormat("Geometry Resolution Note: %s\n", geometry_resolution_note);
   section += "\n";
   return section;
  }

#endif
