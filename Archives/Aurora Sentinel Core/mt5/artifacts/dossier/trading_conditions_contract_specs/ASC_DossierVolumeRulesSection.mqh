#ifndef __ASC_DOSSIERVOLUMERULESSECTION_MQH__
#define __ASC_DOSSIERVOLUMERULESSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierTradingConditionsVolumeRulesSection(const string minimum_volume,
                                                           const string maximum_volume,
                                                           const string volume_step,
                                                           const string stops_level,
                                                           const string freeze_level,
                                                           const string position_rule_notes,
                                                           const bool packet_values_available,
                                                           const bool stop_freeze_completeness_available,
                                                           ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 6);
   values[0] = minimum_volume;
   values[1] = maximum_volume;
   values[2] = volume_step;
   values[3] = stops_level;
   values[4] = freeze_level;
   values[5] = position_rule_notes;

   status_out.section_name = "trading_conditions_volume_rules";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 6 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !packet_values_available || !stop_freeze_completeness_available)
      status_out.posture = "fallback";
   if(!packet_values_available && !stop_freeze_completeness_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("packet_values_available=%s stop_freeze_completeness_available=%s",
                                  packet_values_available ? "yes" : "no",
                                  stop_freeze_completeness_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Volume Rules\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Minimum Volume: %s\n", minimum_volume);
   section += StringFormat("Maximum Volume: %s\n", maximum_volume);
   section += StringFormat("Volume Step: %s\n", volume_step);
   section += StringFormat("Stops Level: %s\n", stops_level);
   section += StringFormat("Freeze Level: %s\n", freeze_level);
   section += StringFormat("Position Rule Notes: %s\n", position_rule_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n";
   return section;
  }

#endif
