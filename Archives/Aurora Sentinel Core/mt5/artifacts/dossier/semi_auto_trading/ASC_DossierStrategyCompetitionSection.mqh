#ifndef __ASC_DOSSIER_STRATEGY_COMPETITION_SECTION_MQH__
#define __ASC_DOSSIER_STRATEGY_COMPETITION_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"

string ASC_BuildDossierStrategyCompetitionSection(const string primary_family_now,
                                                  const string alternate_family_now,
                                                  const string family_confidence_posture,
                                                  const string directional_posture,
                                                  const string why_primary_leads,
                                                  const string why_alternate_remains_alive,
                                                  const string rejected_or_not_primary_now,
                                                  const string alternate_promotion_trigger,
                                                  const bool owner_truth_available,
                                                  ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 8);
   values[0] = primary_family_now;
   values[1] = alternate_family_now;
   values[2] = family_confidence_posture;
   values[3] = directional_posture;
   values[4] = why_primary_leads;
   values[5] = why_alternate_remains_alive;
   values[6] = rejected_or_not_primary_now;
   values[7] = alternate_promotion_trigger;

   status_out.section_name = "semi_auto_strategy_competition";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 8 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = owner_truth_available ? "success" : "skipped";
   status_out.note = "consumer-only Layer-6 competition board fed from the dormant packet chain";

   string section = "------------------------------------------------------------------------------\n";
   section += "Strategy Competition Board\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Primary Family Now: %s\n", primary_family_now);
   section += StringFormat("Alternate Family Now: %s\n", alternate_family_now);
   section += StringFormat("Family Confidence Posture: %s\n", family_confidence_posture);
   section += StringFormat("Directional Posture: %s\n", directional_posture);
   section += StringFormat("Why Primary Leads: %s\n", why_primary_leads);
   section += StringFormat("Why Alternate Remains Alive: %s\n", why_alternate_remains_alive);
   section += StringFormat("Rejected / Not-Primary Now: %s\n", rejected_or_not_primary_now);
   section += StringFormat("What Promotes Alternate: %s\n", alternate_promotion_trigger);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
