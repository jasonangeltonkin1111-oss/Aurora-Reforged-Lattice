#ifndef __ASC_DOSSIERMARGINSECTION_MQH__
#define __ASC_DOSSIERMARGINSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierMarginSection(const string margin_mode,
                                     const string margin_hedged,
                                     const string margin_buy_initial,
                                     const string margin_buy_maintenance,
                                     const string margin_sell_initial,
                                     const string margin_sell_maintenance,
                                     const string margin_notes,
                                     const bool account_context_available,
                                     const bool broker_spec_margin_detail_available,
                                     ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 7);
   values[0] = margin_mode;
   values[1] = margin_hedged;
   values[2] = margin_buy_initial;
   values[3] = margin_buy_maintenance;
   values[4] = margin_sell_initial;
   values[5] = margin_sell_maintenance;
   values[6] = margin_notes;

   status_out.section_name = "margin";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 7 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !account_context_available || !broker_spec_margin_detail_available)
      status_out.posture = "fallback";
   if(!account_context_available && !broker_spec_margin_detail_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("account_context_available=%s broker_spec_margin_detail_available=%s",
                                  account_context_available ? "yes" : "no",
                                  broker_spec_margin_detail_available ? "yes" : "no");

   string section = "------------------------------------------------------------------------------\n";
   section += "Margin\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Margin Mode: %s\n", margin_mode);
   section += StringFormat("Margin Hedged: %s\n", margin_hedged);
   section += StringFormat("Margin Buy Initial: %s\n", margin_buy_initial);
   section += StringFormat("Margin Buy Maintenance: %s\n", margin_buy_maintenance);
   section += StringFormat("Margin Sell Initial: %s\n", margin_sell_initial);
   section += StringFormat("Margin Sell Maintenance: %s\n", margin_sell_maintenance);
   section += StringFormat("Margin Notes: %s\n", margin_notes);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n";
   return section;
  }

#endif
