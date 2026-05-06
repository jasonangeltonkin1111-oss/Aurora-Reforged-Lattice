#ifndef __ASC_DOSSIERPRICECONTRACTSECTION_MQH__
#define __ASC_DOSSIERPRICECONTRACTSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierTradingConditionsPriceContractSection(const string digits,
                                                             const string point,
                                                             const string contract_size,
                                                             const string tick_size,
                                                             const string tick_value,
                                                             const string spread_type,
                                                             const string calculation_mode,
                                                             const string contract_notes,
                                                             const bool packet_values_available,
                                                             const bool spec_values_available,
                                                             ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 8);
   values[0] = digits;
   values[1] = point;
   values[2] = contract_size;
   values[3] = tick_size;
   values[4] = tick_value;
   values[5] = spread_type;
   values[6] = calculation_mode;
   values[7] = contract_notes;

   status_out.section_name = "trading_conditions_price_contract";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 8 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !packet_values_available || !spec_values_available)
      status_out.posture = "fallback";
   if(!packet_values_available && !spec_values_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("packet_values_available=%s spec_values_available=%s",
                                  packet_values_available ? "yes" : "no",
                                  spec_values_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Contract Specs\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Digits: %s\n", digits);
   section += StringFormat("Point: %s\n", point);
   section += StringFormat("Contract Size: %s\n", contract_size);
   section += StringFormat("Tick Size: %s\n", tick_size);
   section += StringFormat("Tick Value: %s\n", tick_value);
   section += StringFormat("Spread Type: %s\n", spread_type);
   section += StringFormat("Calculation Mode: %s\n", calculation_mode);
   section += StringFormat("Contract Notes: %s\n", contract_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
