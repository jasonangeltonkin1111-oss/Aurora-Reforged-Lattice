#ifndef __ASC_DOSSIER_SEMI_AUTO_READINESS_SECTION_MQH__
#define __ASC_DOSSIER_SEMI_AUTO_READINESS_SECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"

string ASC_BuildDossierSemiAutoReadinessSection(const string deployability_class,
                                                const string opportunity_status,
                                                const string readiness_class,
                                                const string horizon_class,
                                                const string allowed_style,
                                                const string review_posture,
                                                const string primary_blocker,
                                                const string downgrade_reason,
                                                const string why_not_top_rank_ready,
                                                const string tradability_posture_carry,
                                                const string execution_usefulness_carry,
                                                const bool owner_truth_available,
                                                ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 11);
   values[0] = deployability_class;
   values[1] = opportunity_status;
   values[2] = readiness_class;
   values[3] = horizon_class;
   values[4] = allowed_style;
   values[5] = review_posture;
   values[6] = primary_blocker;
   values[7] = downgrade_reason;
   values[8] = why_not_top_rank_ready;
   values[9] = tradability_posture_carry;
   values[10] = execution_usefulness_carry;

   status_out.section_name = "semi_auto_readiness";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 11 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = owner_truth_available ? "success" : "skipped";
   status_out.note = "consumer-only Layer-6 readiness classes remain distinct and non-owning";

   string section = "------------------------------------------------------------------------------\n";
   section += "Semi-Auto Readiness\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Deployability Class: %s\n", deployability_class);
   section += StringFormat("Opportunity Status: %s\n", opportunity_status);
   section += StringFormat("Readiness Class: %s\n", readiness_class);
   section += StringFormat("Horizon Class: %s\n", horizon_class);
   section += StringFormat("Allowed Style: %s\n", allowed_style);
   section += StringFormat("Review Posture: %s\n", review_posture);
   section += StringFormat("Primary Blocker: %s\n", primary_blocker);
   section += StringFormat("Downgrade Reason: %s\n", downgrade_reason);
   section += StringFormat("Why Not Top-Rank Ready: %s\n", why_not_top_rank_ready);
   section += StringFormat("Current Usability Carry: %s\n", tradability_posture_carry);
   section += StringFormat("Execution Usefulness Carry: %s\n", execution_usefulness_carry);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
