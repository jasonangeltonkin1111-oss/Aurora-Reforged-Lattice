#ifndef __ASC_DOSSIER_PRESERVE_REVISIT_SECTION_MQH__
#define __ASC_DOSSIER_PRESERVE_REVISIT_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"

string ASC_BuildDossierPreserveRevisitSection(const string why_preserved,
                                              const string what_keeps_it_alive,
                                              const string what_would_strengthen,
                                              const string what_would_weaken,
                                              const string what_flips_the_call,
                                              const string revisit_trigger_summary,
                                              const string ambiguity_note,
                                              const string caution_note,
                                              const string next_review_posture,
                                              const bool owner_truth_available,
                                              ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 9);
   values[0] = why_preserved;
   values[1] = what_keeps_it_alive;
   values[2] = what_would_strengthen;
   values[3] = what_would_weaken;
   values[4] = what_flips_the_call;
   values[5] = revisit_trigger_summary;
   values[6] = ambiguity_note;
   values[7] = caution_note;
   values[8] = next_review_posture;

   status_out.section_name = "semi_auto_preserve_revisit";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 9 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = owner_truth_available ? "success" : "skipped";
   status_out.note = "consumer-only Layer-6 preserve/revisit lane stays bounded and non-owning";

   string section = "------------------------------------------------------------------------------\n";
   section += "Preserve and Revisit\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Why Preserved: %s\n", why_preserved);
   section += StringFormat("What Keeps It Alive: %s\n", what_keeps_it_alive);
   section += StringFormat("What Would Strengthen: %s\n", what_would_strengthen);
   section += StringFormat("What Would Weaken: %s\n", what_would_weaken);
   section += StringFormat("What Flips the Call: %s\n", what_flips_the_call);
   section += StringFormat("Revisit Trigger Summary: %s\n", revisit_trigger_summary);
   section += StringFormat("Ambiguity Note: %s\n", ambiguity_note);
   section += StringFormat("Caution Note: %s\n", caution_note);
   section += StringFormat("Next Review Posture: %s\n", next_review_posture);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
