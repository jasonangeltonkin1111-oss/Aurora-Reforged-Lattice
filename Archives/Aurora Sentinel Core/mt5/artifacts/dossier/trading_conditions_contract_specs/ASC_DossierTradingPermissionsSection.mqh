#ifndef __ASC_DOSSIERTRADINGPERMISSIONSSECTION_MQH__
#define __ASC_DOSSIERTRADINGPERMISSIONSSECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"


string ASC_BuildDossierTradingConditionsPermissionsSection(const string trade_mode,
                                                           const string execution_mode,
                                                           const string filling_mode,
                                                           const string expiration_mode,
                                                           const string gtc_mode,
                                                           const string orders_allowed,
                                                           const string trade_permission_status,
                                                           const string broker_validation_status,
                                                           const bool packet_values_available,
                                                           const bool permission_spec_freshness_available,
                                                           ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 8);
   values[0] = trade_mode;
   values[1] = execution_mode;
   values[2] = filling_mode;
   values[3] = expiration_mode;
   values[4] = gtc_mode;
   values[5] = orders_allowed;
   values[6] = trade_permission_status;
   values[7] = broker_validation_status;

   status_out.section_name = "trading_conditions_permissions";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 8 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || !packet_values_available || !permission_spec_freshness_available)
      status_out.posture = "fallback";
   if(!packet_values_available && !permission_spec_freshness_available)
      status_out.posture = "skipped";
   status_out.note = StringFormat("packet_values_available=%s permission_spec_freshness_available=%s",
                                  packet_values_available ? "yes" : "no",
                                  permission_spec_freshness_available ? "yes" : "no");

   string trade_permission_token = ASC_DossierNormalizeTokenText(trade_permission_status);
   string trade_mode_token = ASC_DossierNormalizeTokenText(trade_mode);
   bool trade_disabled = (StringFind(trade_permission_token, "disabled") >= 0 || StringFind(trade_mode_token, "disabled") >= 0 || StringFind(trade_mode_token, "close") >= 0);
   bool tradeability_blocks_actionability = !packet_values_available || !permission_spec_freshness_available || trade_disabled;
   string tradeability_currentness = ASC_DossierCurrentnessFromEvidence(packet_values_available && permission_spec_freshness_available && !trade_disabled,
                                                                      false,
                                                                      !permission_spec_freshness_available,
                                                                      status_out.missing_fields > 0,
                                                                      !packet_values_available,
                                                                      false,
                                                                      !packet_values_available);

   string section = "------------------------------------------------------------------------------\n";
   section += "Trading Permissions\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Trade Mode: %s\n", trade_mode);
   section += StringFormat("Execution Mode: %s\n", execution_mode);
   section += StringFormat("Filling Mode: %s\n", filling_mode);
   section += StringFormat("Expiration Mode: %s\n", expiration_mode);
   section += StringFormat("GTC Mode: %s\n", gtc_mode);
   section += StringFormat("Orders Allowed: %s\n", orders_allowed);
   section += StringFormat("Trade Permission Status: %s\n", trade_permission_status);
   section += StringFormat("Broker Validation Status: %s\n", broker_validation_status);
   section += "tradeability_state=" + ASC_TextOrUnavailable(trade_permission_status) + " | tradeability_owner=ASC_OpenSymbolSnapshotEngine/SymbolInfoInteger/SymbolInfoDouble | session_currentness=" + tradeability_currentness + " | blocked_trade_disabled=" + (trade_disabled ? "true" : "false") + " | tradeability_next_check=next_open_symbol_snapshot_refresh | session_actionability_block=" + (tradeability_blocks_actionability ? "true" : "false") + "\n";
   section += ASC_DossierActionabilityImpactLine("tradeability",
                                                 tradeability_currentness,
                                                 "ASC_OpenSymbolSnapshotEngine/SymbolInfoInteger/SymbolInfoDouble",
                                                 trade_permission_status,
                                                 "next_open_symbol_snapshot_refresh",
                                                 tradeability_blocks_actionability) + "\n";
   section += ASC_DossierSectionClaimEvidenceLine(status_out,
                                               "trading_conditions_permissions",
                                               "ASC_OpenSymbolSnapshotEngine/SymbolInfoInteger/SymbolInfoDouble",
                                               trade_permission_status,
                                               "next_open_symbol_snapshot_refresh",
                                               "tradeability_currentness_claim_evidence") + "\n";
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
