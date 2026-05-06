#ifndef __ASC_DOSSIEROPERATORSNAPSHOTSECTION_MQH__
#define __ASC_DOSSIEROPERATORSNAPSHOTSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"

bool ASC_DossierSnapshotValueAvailable(const string value)
  {
   string text = ASC_TextOrUnavailable(value);
   if(text == "Unavailable")
      return false;

   string lower = text;
   StringToLower(lower);
   if(StringFind(lower, "unavailable") >= 0
      || StringFind(lower, "awaiting") >= 0
      || StringFind(lower, "not yet") >= 0)
      return false;
   return true;
  }

string ASC_DossierSelectionReasonLine(const string primary_opportunity,
                                      const string primary_read,
                                      const string primary_constraint)
  {
   if(ASC_DossierSnapshotValueAvailable(primary_opportunity))
      return "attention driver: " + primary_opportunity;
   if(ASC_DossierSnapshotValueAvailable(primary_read))
      return "attention driver: " + primary_read;
   if(ASC_DossierSnapshotValueAvailable(primary_constraint))
      return "attention driver is currently guarded by: " + primary_constraint;
   return "attention driver is pending updated selection context";
  }

string ASC_DossierMainCautionLine(const string primary_constraint,
                                  const string primary_risk,
                                  const string selection_reason)
  {
   if(ASC_DossierSnapshotValueAvailable(primary_constraint)
      && StringFind(selection_reason, primary_constraint) < 0)
      return "primary limitation: " + primary_constraint;
   if(ASC_DossierSnapshotValueAvailable(primary_risk)
      && StringFind(selection_reason, primary_risk) < 0)
      return "primary limitation: " + primary_risk;
   if(ASC_DossierSnapshotValueAvailable(primary_constraint))
      return "primary limitation remains active and should frame sizing/timing";
   return "primary limitation is pending refreshed risk context";
  }

string ASC_DossierAnalystConclusionLine(const string primary_read,
                                        const string selection_reason,
                                        const string main_caution)
  {
   string read_text = ASC_DossierSnapshotValueAvailable(primary_read)
                      ? primary_read
                      : "current read is guarded";
   return StringFormat("%s | %s | %s",
                       read_text,
                       selection_reason,
                       main_caution);
  }


string ASC_BuildDossierOperatorSnapshotSection(const string primary_read,
                                               const string primary_risk,
                                               const string primary_opportunity,
                                               const string primary_constraint,
                                               const string primary_next_check,
                                               const string one_line_summary,
                                               const bool continuity_sensitive,
                                               ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 6);
   values[0] = primary_read;
   values[1] = primary_risk;
   values[2] = primary_opportunity;
   values[3] = primary_constraint;
   values[4] = primary_next_check;
   values[5] = one_line_summary;

   status_out.section_name = "operator_snapshot";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 6 - status_out.populated_fields;
   status_out.continuity_used = continuity_sensitive;
   status_out.posture = "success";
   if(status_out.missing_fields > 0)
      status_out.posture = "fallback";
   if(status_out.continuity_used)
      status_out.posture = "degraded";
   status_out.note = (status_out.missing_fields > 0)
                     ? "operator snapshot has one or more unavailable values"
                     : "operator snapshot is ready";

   string section = "\n===============================================================================\n";
   section += "OPERATOR SNAPSHOT\n";
   section += "===============================================================================\n\n";
   string selection_reason = ASC_DossierSelectionReasonLine(primary_opportunity,
                                                            primary_read,
                                                            primary_constraint);
   string main_caution = ASC_DossierMainCautionLine(primary_constraint,
                                                    primary_risk,
                                                    selection_reason);
   string analyst_conclusion = ASC_DossierAnalystConclusionLine(primary_read,
                                                                selection_reason,
                                                                main_caution);
   section += StringFormat("Primary Read: %s\n", primary_read);
   section += StringFormat("Primary Risk: %s\n", primary_risk);
   section += StringFormat("Primary Opportunity: %s\n", primary_opportunity);
   section += StringFormat("Primary Constraint: %s\n", primary_constraint);
   section += StringFormat("Primary Next Check: %s\n", primary_next_check);
   section += "\n";
   section += StringFormat("Analyst Conclusion: %s\n", analyst_conclusion);
   section += StringFormat("Selection Reason: %s\n", selection_reason);
   section += StringFormat("Main Caution: %s\n", main_caution);
   section += "\n";
   section += StringFormat("One-Line Summary: %s\n", one_line_summary);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n";
   return section;
  }

#endif
