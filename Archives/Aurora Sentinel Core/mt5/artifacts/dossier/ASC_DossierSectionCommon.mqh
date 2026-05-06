#ifndef __ASC_DOSSIER_SECTION_COMMON_MQH__
#define __ASC_DOSSIER_SECTION_COMMON_MQH__

#include "../ASC_ArtifactTextHelpers.mqh"

struct ASC_DossierSectionStatus
  {
   string section_name;
   bool ran;
   string posture;
   int populated_fields;
   int missing_fields;
   bool continuity_used;
   string note;
  };

void ASC_DossierAppendSectionHeader(string &body,const string section_title)
  {
   body += "\n===============================================================================\n";
   body += section_title + "\n";
   body += "===============================================================================\n\n";
  }

void ASC_DossierAppendSubgroupHeader(string &body,const string subgroup_title)
  {
   body += "------------------------------------------------------------------------------\n";
   body += subgroup_title + "\n";
   body += "------------------------------------------------------------------------------\n";
  }

string ASC_DossierLabelValueLine(const string label,const string value)
  {
   return StringFormat("%s %s\n", label, value);
  }

int ASC_DossierHeaderCountPopulatedFields(const string &values[])
  {
   int count = 0;
   for(int i = 0; i < ArraySize(values); i++)
      if(values[i] != "unavailable")
         count++;
   return count;
  }

string ASC_DossierSectionStatusCompactLine(const ASC_DossierSectionStatus &status)
  {
   string section_name = ASC_TextOrUnavailable(status.section_name);
   string posture = ASC_TextOrUnavailable(status.posture);
   string note = ASC_TextOrUnavailable(status.note);
   string continuity = status.continuity_used ? "yes" : "no";
   string ran = status.ran ? "yes" : "no";

   string completeness_state = ASC_DossierCompletenessStateFromPosture(status.posture, status.missing_fields, status.ran, status.continuity_used);
   return StringFormat("Section Status: name=%s | ran=%s | posture=%s | completeness_state=%s | completeness_taxonomy=%s | populated=%d | missing=%d | continuity=%s | partial_is_complete=false | scaffold_is_complete=false | degraded_requires_operator_context=%s | note=%s",
                       section_name,
                       ran,
                       posture,
                       completeness_state,
                       ASC_DOSSIER_SECTION_COMPLETENESS_TAXONOMY,
                       status.populated_fields,
                       status.missing_fields,
                       continuity,
                       status.continuity_used ? "true" : "false",
                       note);
  }


string ASC_DossierNormalizeTokenText(const string value)
  {
   string normalized = value;
   StringTrimLeft(normalized);
   StringTrimRight(normalized);
   StringToLower(normalized);
   if(StringLen(normalized) <= 0)
      return "unavailable";
   return normalized;
  }

string ASC_DossierCurrentnessFromEvidence(const bool live_current,
                                          const bool retained_last_good,
                                          const bool stale_or_degraded,
                                          const bool pending_or_partial,
                                          const bool blocked_dependency,
                                          const bool blocked_market_closed,
                                          const bool unknown_unproven)
  {
   if(live_current && !retained_last_good && !stale_or_degraded && !pending_or_partial && !blocked_dependency && !blocked_market_closed && !unknown_unproven)
      return "current_live";
   if(retained_last_good)
      return "retained_last_good";
   if(stale_or_degraded)
      return "stale_not_current";
   if(blocked_market_closed)
      return "blocked_market_closed";
   if(blocked_dependency)
      return "blocked_dependency";
   if(pending_or_partial)
      return "pending_next_check";
   if(unknown_unproven)
      return "unknown_unproven";
   return "diagnostic_only";
  }

string ASC_DossierActionabilityImpactLine(const string prefix,
                                          const string currentness_state,
                                          const string owner,
                                          const string reason,
                                          const string next_check,
                                          const bool actionability_block)
  {
   string line = prefix + "_owner=" + ASC_TextOrUnavailable(owner);
   line += " | " + prefix + "_currentness=" + ASC_TextOrUnavailable(currentness_state);
   line += " | " + prefix + "_actionability_block=" + (actionability_block ? "true" : "false");
   line += " | " + prefix + "_reason=" + ASC_TextOrUnavailable(reason);
   line += " | " + prefix + "_next_check=" + ASC_TextOrUnavailable(next_check);
   line += " | ranked_not_actionable_without_currentness=true";
   line += " | current_does_not_mean_trade=true";
   line += " | diagnostic_is_actionable=false";
   line += " | trade_signal=false";
   return line;
  }

string ASC_DossierCurrentnessActionabilityTaxonomyLine()
  {
   return "Currentness / Actionability Taxonomy: statuses=current_live,current_committed_snapshot,stale_not_current,retained_last_good,pending_next_check,blocked_dependency,blocked_market_closed,blocked_quote_unavailable,blocked_trade_disabled,blocked_session_closed,unknown_unproven,diagnostic_only,not_applicable,degraded_current | current_does_not_mean_trade=true | ranked_does_not_mean_actionable=true | retained_is_not_current=true | stale_is_not_clean=true | unavailable_requires_owner_reason_next_check=true | family_dossier_role=prepared_review_artifact | family_dossier_not_trade_signal=true | family_dossier_currentness_required=true | family_dossier_selected_refresh_required_for_actionability=true | globaltop10_retrieval_path=Dossiers/GlobalTop10/<symbol>.txt | top5perbucket_retrieval_path=Dossiers/Top5PerBucket/<bucket>/<symbol>.txt | selected_current_required_for_actionability=true | current_focus_role=selected_symbol_live_context";
  }


string ASC_DossierPhase5PermissionContextTaxonomyLine()
  {
   return "Phase 5 Permission Context Taxonomy: " + ASC_Phase5NoSignalBoundaryText()
          + " | " + ASC_Phase5SourceReadyProofLine()
          + " | " + ASC_Phase5StrategyPermissionGateSummaryLine()
          + " | " + ASC_Phase5StrategyPermissionStateLine()
          + " | " + ASC_Phase5SiamEdgeGateLine()
          + " | " + ASC_Phase6DossierPermissionContextLine()
          + " | " + ASC_Phase7DossierPermissionContextLine()
          + " | session_timing_freshness_required_before_clean_review_context=true"
          + " | " + ASC_Phase7GateWiringAggregateLine()
          + " | " + ASC_Phase7SourceLockSummaryLine()
          + " | " + ASC_Phase7Run145LiveContractSummaryLine()
          + " | " + ASC_Phase7CloseoutGateChecklistLine()
          + " | " + ASC_Phase6RegimeGateWiringSummaryLine()
          + " | " + ASC_Phase6SourceLockSummaryLine()
          + " | " + ASC_Phase6Run140LiveContractSummaryLine();
  }

string ASC_DossierSectionClaimEvidenceLine(const ASC_DossierSectionStatus &status,
                                           const string claim_subject,
                                           const string claim_source_owner,
                                           const string claim_reason,
                                           const string claim_next_check,
                                           const string claim_evidence_token)
  {
   string claim_status = "available_current";
   string claim_currentness = "current";
   bool claim_actionability_block = false;
   string claim_operator_action = "none";
   string claim_confidence = "medium";

   if(!status.ran)
     {
      claim_status = "blocked_not_run";
      claim_currentness = "unknown_not_observed";
      claim_actionability_block = true;
      claim_operator_action = "wait_for_owner_section";
      claim_confidence = "medium";
     }
   else if(status.continuity_used)
     {
      claim_status = "retained_last_good";
      claim_currentness = "retained_historical_not_current";
      claim_actionability_block = true;
      claim_operator_action = "wait_for_fresh_owner_update";
      claim_confidence = "high";
     }
   else if(status.posture == "degraded")
     {
      claim_status = "degraded_source";
      claim_currentness = "degraded_not_clean_current";
      claim_actionability_block = true;
      claim_operator_action = "wait_or_review_owner_reason";
      claim_confidence = "medium";
     }
   else if(status.posture == "skipped")
     {
      claim_status = "blocked_or_unavailable";
      claim_currentness = "not_current";
      claim_actionability_block = true;
      claim_operator_action = "wait_for_owner_unlock";
      claim_confidence = "medium";
     }
   else if(status.missing_fields > 0 || status.posture == "fallback")
     {
      claim_status = "pending_or_partial";
      claim_currentness = "partial_not_clean_current";
      claim_actionability_block = true;
      claim_operator_action = "wait_for_next_check";
      claim_confidence = "medium";
     }

   string line = "Claim Evidence: dossier_section_claim_evidence_enabled=true";
   line += " | claim_subject=" + ASC_TextOrUnavailable(claim_subject);
   line += " | section_status=" + ASC_TextOrUnavailable(status.posture);
   line += " | missing_fields=" + IntegerToString(MathMax(0, status.missing_fields));
   line += " | continuity_used=" + (status.continuity_used ? "true" : "false");
   line += " | section_is_trade_signal=false | diagnostic_is_actionable=false\n";
   line += "Claim Evidence Detail: ";
   line += ASC_ClaimEvidenceLine(claim_status,
                                 claim_subject,
                                 claim_source_owner,
                                 claim_reason,
                                 claim_next_check,
                                 claim_currentness,
                                 claim_actionability_block,
                                 claim_operator_action,
                                 claim_confidence,
                                 claim_evidence_token);
   return line;
  }
#endif
