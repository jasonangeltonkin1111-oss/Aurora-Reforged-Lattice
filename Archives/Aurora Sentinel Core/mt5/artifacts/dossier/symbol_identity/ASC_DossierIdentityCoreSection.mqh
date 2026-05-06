#ifndef __ASC_DOSSIERIDENTITYCORESECTION_MQH__
#define __ASC_DOSSIERIDENTITYCORESECTION_MQH__

#include "../ASC_DossierSectionCommon.mqh"

string ASC_DossierIdentityBrokerSuffixSource(const string broker_suffix)
  {
   if(broker_suffix == "none")
      return "exact_broker_symbol_parse";
   if(StringLen(broker_suffix) > 0 && StringFind(broker_suffix, "unavailable_owner=") != 0)
      return "exact_broker_symbol_parse";
   return "unknown";
  }

string ASC_DossierIdentityBrokerSuffixTransportAvailable(const string broker_suffix)
  {
   if(broker_suffix == "none")
      return "true";
   if(StringLen(broker_suffix) > 0 && StringFind(broker_suffix, "unavailable_owner=") != 0)
      return "true";
   return "false";
  }

string ASC_DossierIdentityStatusFromSuffix(const string exact_broker_symbol,
                                           const string canonical_symbol_id,
                                           const string broker_suffix)
  {
   if(StringLen(exact_broker_symbol) <= 0 || exact_broker_symbol == "Unavailable" ||
      StringLen(canonical_symbol_id) <= 0 || canonical_symbol_id == "Unavailable")
      return "unknown";
   if(ASC_DossierIdentityBrokerSuffixTransportAvailable(broker_suffix) == "true")
      return "resolved";
   return "partial";
  }

string ASC_DossierIdentityResolutionReason(const string status,const string broker_suffix)
  {
   if(status == "resolved" && broker_suffix == "none")
      return "source_owned_exact_broker_symbol_matches_canonical_symbol_no_suffix_present";
   if(status == "resolved")
      return "source_owned_exact_broker_symbol_and_canonical_symbol_allow_safe_suffix_parse";
   if(status == "partial")
      return "visible_and_canonical_identity_source_owned_broker_suffix_not_safely_parseable_without_guessing";
   return "source_identity_unresolved_or_missing";
  }


string ASC_BuildDossierIdentityCoreSection(const string symbol,
                                           const string display_name,
                                           const string broker_symbol_name,
                                           const string visible_symbol,
                                           const string canonical_symbol_id,
                                           const string exact_broker_symbol,
                                           const string broker_suffix,
                                           const string asset_type,
                                           const string instrument_family,
                                           const string calculation_type,
                                           const string chart_mode,
                                           const bool identity_partially_resolved,
                                           ASC_DossierSectionStatus &status_out)
  {
   string values[];
   ArrayResize(values, 7);
   values[0] = symbol;
   values[1] = display_name;
   values[2] = broker_symbol_name;
   values[3] = asset_type;
   values[4] = instrument_family;
   values[5] = calculation_type;
   values[6] = chart_mode;

   status_out.section_name = "identity_core";
   status_out.ran = true;
   status_out.populated_fields = ASC_DossierHeaderCountPopulatedFields(values);
   status_out.missing_fields = 7 - status_out.populated_fields;
   status_out.continuity_used = false;
   status_out.posture = "success";
   if(status_out.missing_fields > 0 || identity_partially_resolved)
      status_out.posture = "fallback";
   status_out.note = identity_partially_resolved
                     ? "identity is partially resolved; unresolved values remain explicit"
                     : "identity core is fully resolved from current owner-backed values";

   string identity_status = ASC_DossierIdentityStatusFromSuffix(exact_broker_symbol, canonical_symbol_id, broker_suffix);
   string identity_reason = ASC_DossierIdentityResolutionReason(identity_status, broker_suffix);

   string section = "------------------------------------------------------------------------------\n";
   section += "Core Identity\n";
   section += "------------------------------------------------------------------------------\n";
   section += StringFormat("Symbol: %s\n", symbol);
   section += StringFormat("Display Name: %s\n", display_name);
   section += StringFormat("Broker Symbol Name: %s\n", broker_symbol_name);
   section += "SYMBOL_IDENTITY_DIAGNOSTIC_BEGIN\n";
   section += "symbol_identity_diagnostic_version=RUN229_v1\n";
   section += "identity_mode=diagnostic_only_not_authority\n";
   section += "visible_symbol=" + visible_symbol + "\n";
   section += "canonical_symbol_id=" + canonical_symbol_id + "\n";
   section += "exact_broker_symbol=" + exact_broker_symbol + "\n";
   section += "broker_suffix=" + broker_suffix + "\n";
   section += "broker_suffix_source=" + ASC_DossierIdentityBrokerSuffixSource(broker_suffix) + "\n";
   section += "broker_suffix_transport_available=" + ASC_DossierIdentityBrokerSuffixTransportAvailable(broker_suffix) + "\n";
   section += "symbol_identity_status=" + identity_status + "\n";
   section += "identity_resolution_reason=" + identity_reason + "\n";
   section += "identity_next_step=" + ((identity_status == "resolved") ? "runtime_retest_must_confirm_identity_fields_in_published_dossier_no_trade_permission" : "bind_or_export_source_owned_exact_broker_symbol_and_canonical_symbol_before_suffix_resolution_no_filename_guessing") + "\n";
   section += "symbol_identity_reason=" + identity_reason + "\n";
   section += "identity_source_owner=DossierIdentityCoreSection_from_ASC_BuildDossierIdentityCore\n";
   section += "identity_blocks_trade=" + ((identity_status == "resolved") ? "false" : "true") + "\n";
   section += "identity_blocks_diagnostic_review=false\n";
   section += "symbol_trade_permission=false\n";
   section += "symbol_signal_permission=false\n";
   section += "symbol_execution_permission=false\n";
   section += "symbol_risk_permission=false\n";
   section += "SYMBOL_IDENTITY_DIAGNOSTIC_END\n";
   section += "DUPLICATE_ROUTE_DIAGNOSTIC_BEGIN\n";
   section += "duplicate_route_diagnostic_version=RUN229_v1\n";
   section += "duplicate_route_mode=diagnostic_only_not_route_rewrite\n";
   section += "symbol=" + visible_symbol + "\n";
   section += "visible_symbol=" + visible_symbol + "\n";
   section += "canonical_symbol_id=" + canonical_symbol_id + "\n";
   section += "exact_broker_symbol=" + exact_broker_symbol + "\n";
   section += "routes_present=unknown_owner_dossier_identity_core_has_no_parallel_route_index\n";
   section += "exists_in_globaltop10=unknown_owner_dossier_identity_core_has_no_parallel_route_index\n";
   section += "exists_in_top5perbucket=unknown_owner_dossier_identity_core_has_no_parallel_route_index\n";
   section += "canonical_route_for_overall_review=GlobalTop10_context_review_only_not_trade_permission\n";
   section += "canonical_route_for_bucket_review=Top5PerBucket_context_review_only_not_trade_permission\n";
   section += "canonical_route_for_current_workflow=selected_symbol_dossier_context\n";
   section += "duplicate_route_status=unknown\n";
   section += "duplicate_route_reason=dossier_identity_core_does_not_own_parallel_route_membership_no_scan_no_rewrite\n";
   section += "duplicate_route_source_owner=DossierIdentityCoreSection_diagnostic_only\n";
   section += "duplicate_route_blocks_trade=true\n";
   section += "duplicate_route_blocks_diagnostic_review=false\n";
   section += "route_rewrite_performed=false\n";
   section += "path_change_performed=false\n";
   section += "fileio_change_performed=false\n";
   section += "new_gate_added=false\n";
   section += "trade_permission=false\n";
   section += "signal_permission=false\n";
   section += "execution_permission=false\n";
   section += "risk_permission=false\n";
   section += "DUPLICATE_ROUTE_DIAGNOSTIC_END\n";
   section += StringFormat("Asset Type: %s\n", asset_type);
   section += StringFormat("Instrument Family: %s\n", instrument_family);
   section += StringFormat("Calculation Type: %s\n", calculation_type);
   section += StringFormat("Chart Mode: %s\n", chart_mode);
   section += ASC_DossierSectionStatusCompactLine(status_out) + "\n\n";
   return section;
  }

#endif
