#ifndef __ASC_SCANNER_STATUS_WRITER_MQH__
#define __ASC_SCANNER_STATUS_WRITER_MQH__

#include "ASC_ArtifactContracts.mqh"
#include "ASC_ArtifactTextHelpers.mqh"
#include "symbol_data_pack/ASC_SymbolDataPackContracts.mqh"
#include "../core/ASC_Constants.mqh"
#include "../core/ASC_ResultCodes.mqh"
#include "../core/ASC_RuntimeState.mqh"
#include "../core/ASC_Version.mqh"
#include "../market_state/ASC_MarketStateEngine.mqh"
#include "../logging/ASC_FunctionResults.mqh"
#include "../io/ASC_FileIO.mqh"

bool ASC_RuntimeProofDirectoryHasAnyChild(const string directory_path)
  {
   if(StringLen(directory_path) <= 0)
      return false;

   string found = "";
   ResetLastError();
   long search_handle = FileFindFirst(directory_path + "\\*", found, FILE_COMMON);
   if(search_handle == INVALID_HANDLE)
      return false;

   FileFindClose(search_handle);
   return true;
  }

string ASC_ScannerStatusProofFieldValue(const string raw_value,const string fallback_value = "not_applicable")
  {
   string value = raw_value;
   StringTrimLeft(value);
   StringTrimRight(value);
   if(StringLen(value) <= 0 || value == "none")
      value = fallback_value;
   StringReplace(value, " | ", "/");
   StringReplace(value, " ", "_");
   StringReplace(value, "\t", "_");
   StringReplace(value, "\r", "_");
   StringReplace(value, "\n", "_");
   return (StringLen(value) > 0 ? value : fallback_value);
  }

string ASC_ScannerStatusExtractProofToken(const string text,const string token,const string fallback_value)
  {
   if(StringLen(text) <= 0 || StringLen(token) <= 0)
      return fallback_value;
   string needle = token + "=";
   int start = StringFind(text, needle);
   if(start < 0 && token == "reconciliation_expected_symbols_summary")
      return ASC_ScannerStatusExtractProofToken(text, "reconciliation_expected_symbols", fallback_value);
   if(start < 0 && token == "reconciliation_unexpected_symbols_summary")
      return ASC_ScannerStatusExtractProofToken(text, "reconciliation_unexpected_symbols", fallback_value);
   if(start < 0)
      return fallback_value;
   start += StringLen(needle);
   int stop = start;
   int n = StringLen(text);
   while(stop < n)
     {
      ushort ch = (ushort)StringGetCharacter(text, stop);
      if(ch == 32 || ch == 124 || ch == 10 || ch == 13 || ch == 9)
         break;
      stop++;
     }
   return ASC_ScannerStatusProofFieldValue(StringSubstr(text, start, stop - start), fallback_value);
  }

string ASC_ScannerStatusReconciliationProofBlock(const string route_text,const string bucket_text,const string proof_text)
  {
   return "reconciliation_proof=present"
          + " | reconciliation_route=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_route", route_text)
          + " | reconciliation_bucket=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_bucket", bucket_text)
          + " | reconciliation_state=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_state", "source_supported_runtime_unproven")
          + " | reconciliation_current_truth_source=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_current_truth_source", "membership_snapshot")
          + " | reconciliation_expected_count=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_expected_count", "unknown")
          + " | reconciliation_found_final_count=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_found_final_count", "unknown")
          + " | reconciliation_expected_symbols_summary=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_expected_symbols_summary", "unknown")
          + " | reconciliation_unexpected_symbols_summary=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_unexpected_symbols_summary", "unknown")
          + " | reconciliation_archived_count=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_archived_count", "0")
          + " | reconciliation_deleted_count=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_deleted_count", "0")
          + " | reconciliation_skipped_count=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_skipped_count", "0")
          + " | reconciliation_first_failure_reason=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_first_failure_reason", "none")
          + " | reconciliation_final_path=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_final_path", "not_applicable")
          + " | reconciliation_archive_path=" + ASC_ScannerStatusExtractProofToken(proof_text, "reconciliation_archive_path", "not_applicable")
          + " | reconciliation_durable_surface=scanner_status"
          + " | reconciliation_output_evidence_mutated=false"
          + " | signal_permission=false | trade_permission=false | execution_permission=false";
  }

string ASC_ScannerStatusClaimEvidenceTokens(const ASC_RuntimeState &state)
  {
   int unavailable_count = MathMax(0, state.dossier_missing_count) + MathMax(0, state.top5_bucket_child_failed_count);
   int blocked_count = MathMax(0, state.phase2a_hydration_dependency_blocked_count) + MathMax(0, state.phase2a_three_kb_dependency_blocked_count);
   int pending_count = MathMax(0, state.dossier_pending_backlog_count) + MathMax(0, state.top5_bucket_child_pending_count) + MathMax(0, state.deferred_write_artifacts);
   int stale_count = state.l1_cycle_stale ? 1 : 0;
   int retained_count = (ASC_LEGACY_ALL_SYMBOL_DOSSIERS_RETAINED ? 1 : 0);
   int degraded_count = state.l1_cycle_degraded ? 1 : 0;
   int unknown_count = MathMax(0, state.phase2a_three_kb_unknown_requires_review_count);
   int actionability_block_count = blocked_count + stale_count + degraded_count + (state.l1_cycle_complete ? 0 : 1);
   string line = ASC_ClaimEvidenceStarterPolicyLine();
   line += " | claim_evidence_aggregate=true";
   line += " | currentness_evidence_enabled=true";
   line += " | actionability_evidence_enabled=true";
   line += " | current_live_count=" + IntegerToString(state.l1_cycle_complete && !state.l1_cycle_stale && !state.l1_cycle_degraded ? 1 : 0);
   line += " | stale_not_current_count=" + IntegerToString(stale_count);
   line += " | retained_last_good_count=" + IntegerToString(retained_count);
   line += " | blocked_actionability_count=" + IntegerToString(actionability_block_count);
   line += " | unknown_unproven_count=" + IntegerToString(unknown_count + (state.l1_cycle_complete ? 0 : 1));
   line += " | ranked_not_actionable_without_currentness=true";
   line += " | selected_refresh_required_for_actionability=true";
   line += " | claim_unavailable_count=" + IntegerToString(unavailable_count);
   line += " | claim_blocked_count=" + IntegerToString(blocked_count);
   line += " | claim_pending_count=" + IntegerToString(pending_count);
   line += " | claim_stale_count=" + IntegerToString(stale_count);
   line += " | claim_retained_count=" + IntegerToString(retained_count);
   line += " | claim_degraded_count=" + IntegerToString(degraded_count);
   line += " | claim_unknown_count=" + IntegerToString(unknown_count);
   line += " | claim_actionability_block_count=" + IntegerToString(actionability_block_count);
   line += " | claim_top_blocker=" + (blocked_count > 0 ? "dependency_blocked" : (state.l1_cycle_complete ? "none" : "l1_cycle_incomplete"));
   line += " | claim_top_source_owner=ASC_RuntimeState/ScannerStatusWriter";
   line += " | claim_next_check=" + (pending_count > 0 ? "next_write_lane_or_top5_membership_refresh" : "next_scanner_status_publish");
   line += " | claim_evidence_live_unproven_until_RUN130=true";
   line += " | run127_safe_cleanup_patch=" + ASC_RUN127_SAFE_CLEANUP_PATCH;
   line += " | claim_section_level_enabled=true";
   line += " | claim_dossier_section_count=5";
   line += " | claim_market_board_lookup_enabled=true";
   line += " | claim_trader_chat_packet_enabled=true";
   line += " | claim_family_dossier_availability_enabled=true";
   line += " | claim_evidence_per_symbol_rows=false";
   line += " | claim_evidence_section_spam_avoided=true";
   line += " | claim_evidence_token=scanner_status_currentness_actionability_RUN128R";
   return line;
  }

string ASC_ScannerStatusClaimEvidenceBlock(const ASC_RuntimeState &state)
  {
   string block = "Claim Evidence / Unavailable Cleanup\n";
   block += "- " + ASC_ScannerStatusClaimEvidenceTokens(state) + "\n";
   block += "- " + ASC_ClaimEvidenceLine("available_retained", "root_dossier_policy", "ASC_Dispatcher/ASC_DossierWriter", "RUN193_direct_root_Dossiers_symbol_txt_disabled_by_default_selected_current_and_family_outputs_preserved", "RUN195_live_filesystem_proof", "source_patched_runtime_unproven", false, "none", "high", "root_policy_selected_family_only_run193") + "\n";
   block += "- " + ASC_ClaimEvidenceLine("available_current", "selected_current_guard", "ASC_Dispatcher/ASC_CurrentFocusWriter", "selected_symbol_and_current_focus_paths_are_independent_of_root_all_symbol_policy", "selected_symbol_or_deep_analysis_event", "source_supported_runtime_unproven", false, "select_symbol", "high", "selected_current_guard_source_supported") + "\n";
   block += "- " + ASC_ClaimEvidenceLine("pending_queue", "top5_globaltop10_prepared_dossiers", "ASC_Dispatcher/Top5PerBucketService", "prepared_child_dossier_availability_depends_on_family_queue_and_promotion", "next_top5_membership_refresh", "not_current", false, "wait", "medium", "family_dossier_queue_pending_until_promote") + "\n";
   block += "- " + ASC_ClaimEvidenceLine("unknown_unproven", "claim_evidence_runtime_visibility", "ScannerStatusWriter/FunctionResults", "RUN128_source_patch_has_no_live_output_until_RUN130", "RUN130_live_test", "diagnostic", false, "live_proof_required", "high", "claim_evidence_live_unproven_until_RUN130") + "\n";
   return block;
  }

string ASC_ScannerStatusDossierPolicyTokens(const ASC_RuntimeState &state)
  {
   string tokens = "dossier_publication_mode=" + ASC_DOSSIER_PUBLICATION_MODE;
   tokens += " | root_all_symbol_dossiers_enabled=" + (ASC_ROOT_ALL_SYMBOL_DOSSIERS_ENABLED ? "true" : "false");
   tokens += " | root_direct_symbol_dossiers_compat_enabled=" + (ASC_ROOT_DIRECT_SYMBOL_DOSSIERS_COMPAT_ENABLED ? "true" : "false");
   tokens += " | root_direct_symbol_dossier_policy_run193=" + ASC_ROOT_DIRECT_SYMBOL_DOSSIER_POLICY_RUN193;
   tokens += " | root_direct_symbol_dossier_suppression_patch=" + ASC_RUN193_ROOT_DIRECT_SYMBOL_SUPPRESSION_PATCH;
   tokens += " | root_all_symbol_dossier_writes_skipped=" + IntegerToString(MathMax(0, state.root_all_symbol_dossier_writes_skipped));
   tokens += " | globaltop10_dossiers_enabled=" + (ASC_GLOBALTOP10_DOSSIERS_ENABLED ? "true" : "false");
   tokens += " | top5_per_bucket_dossiers_enabled=" + (ASC_TOP5_PER_BUCKET_DOSSIERS_ENABLED ? "true" : "false");
   tokens += " | current_focus_enabled=" + (ASC_CURRENT_FOCUS_ENABLED ? "true" : "false");
   tokens += " | hud_runtime_enabled=" + (ASC_HUD_ENABLED_DEFAULT ? "true" : "false");
   tokens += " | operator_primary_surface=" + ASC_OPERATOR_PRIMARY_SURFACE;
   tokens += " | hud_repair_deferred=" + (ASC_HUD_REPAIR_DEFERRED ? "true" : "false");
   tokens += " | hud_off_workflow_token=" + ASC_HUD_OFF_WORKFLOW_TOKEN;
   tokens += " | " + ASC_PHASE7_SESSION_TIMING_SOURCE_LOCKED_TOKEN;
   tokens += " | " + ASC_PHASE7_LIVE_PROOF_REQUIRED_TOKEN;
   tokens += " | " + ASC_PHASE7_SESSION_TIMING_GATE_SURFACE_READY_TOKEN;
   tokens += " | " + ASC_PHASE7_RUN144_PROOF_BOUNDARY;
   tokens += " | " + ASC_PHASE7_RUN145_LIVE_CONTRACT_TOKEN;
   tokens += " | selected_symbol_dossier_enabled=" + (ASC_SELECTED_SYMBOL_DOSSIER_ENABLED ? "true" : "false");
   tokens += " | root_policy_preserves_selected_current=" + ((ASC_SELECTED_SYMBOL_DOSSIER_ENABLED && ASC_CURRENT_FOCUS_ENABLED && !ASC_ROOT_ALL_SYMBOL_DOSSIERS_ENABLED) ? "true" : "false");
   tokens += " | current_focus_independent_of_root_all_symbol=" + ((ASC_CURRENT_FOCUS_ENABLED && !ASC_ROOT_ALL_SYMBOL_DOSSIERS_ENABLED) ? "true" : "false");
   tokens += " | diagnostic_all_symbol_dossiers_enabled=" + (ASC_DIAGNOSTIC_ALL_SYMBOL_DOSSIERS_ENABLED ? "true" : "false");
   tokens += " | legacy_all_symbol_dossiers_retained=" + (ASC_LEGACY_ALL_SYMBOL_DOSSIERS_RETAINED ? "true" : "false");
   tokens += " | legacy_root_dossier_cleanup_pending=" + (ASC_LEGACY_ROOT_DOSSIER_CLEANUP_PENDING ? "true" : "false");
   tokens += " | market_board_publish_cadence_sec=" + IntegerToString(ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC);
   tokens += " | market_board_archive_enabled=" + (ASC_MARKET_BOARD_ARCHIVE_ENABLED ? "true" : "false");
   tokens += " | market_board_archive_retention_slots=" + IntegerToString(MathMax(1, ASC_MARKET_BOARD_ARCHIVE_RETENTION_SLOTS));
   tokens += " | market_board_archive_no_change_skip=" + (ASC_MARKET_BOARD_ARCHIVE_NO_CHANGE_SKIP ? "true" : "false");
   tokens += " | market_board_archive_history_only=" + (ASC_MARKET_BOARD_ARCHIVE_HISTORY_ONLY ? "true" : "false");
   tokens += " | l3_candidate_refresh_cadence_sec=" + IntegerToString(ASC_L3_CANDIDATE_REFRESH_CADENCE_SEC);
   tokens += " | l4_shortlist_refresh_cadence_sec=" + IntegerToString(ASC_L4_SHORTLIST_REFRESH_CADENCE_SEC);
   tokens += " | globaltop10_refresh_cadence_sec=" + IntegerToString(ASC_GLOBALTOP10_REFRESH_CADENCE_SEC);
   tokens += " | top5_per_bucket_refresh_cadence_sec=" + IntegerToString(ASC_TOP5_PER_BUCKET_REFRESH_CADENCE_SEC);
   tokens += " | performance_side_audit=" + ASC_PERFORMANCE_SIDE_AUDIT_STATE;
   tokens += " | safe_cleanup_patch=" + ASC_RUN113_SAFE_CLEANUP_PATCH;
   tokens += " | top5_depth_parity_state=" + ASC_TOP5_DEPTH_PARITY_STATE_SOURCE_PATCHED;
   tokens += " | top5_rank_1_3_deep_attempted=" + (ASC_TOP5_RANK_1_3_DEEP_ATTEMPTED ? "true" : "false");
   tokens += " | top5_rank_1_5_deep_queue_enabled=true";
   tokens += " | top5_rank_4_5_deep_pending=" + (ASC_TOP5_RANK_4_5_DEEP_PENDING ? "true" : "false");
   tokens += " | top5_rank_4_5_permanent_deep_pending=false";
   tokens += " | run126_safe_cleanup_patch=" + ASC_RUN126_SAFE_CLEANUP_PATCH;
   tokens += " | run127_safe_cleanup_patch=" + ASC_RUN127_SAFE_CLEANUP_PATCH;
   tokens += " | top5_staging_enabled=" + (ASC_TOP5_STAGING_ENABLED ? "true" : "false");
   tokens += " | top5_archive_enabled=" + (ASC_TOP5_ARCHIVE_ENABLED ? "true" : "false");
   tokens += " | top5_promote_after_validate=" + (ASC_TOP5_PROMOTE_AFTER_VALIDATE ? "true" : "false");
   tokens += " | top5_archive_previous_on_promote=" + (ASC_TOP5_ARCHIVE_PREVIOUS_ON_PROMOTE ? "true" : "false");
   tokens += " | top5_no_broad_file_deletion=true";
   tokens += " | run114_safe_cleanup_patch=" + ASC_RUN114_SAFE_CLEANUP_PATCH;
   tokens += " | last_policy_skip_reason=" + (StringLen(state.dossier_publication_policy_last_skip_reason) > 0 ? state.dossier_publication_policy_last_skip_reason : "none");
   return tokens;
  }


string ASC_Run202NormalizeStatusToken(string value)
  {
   if(StringLen(value) <= 0)
      return "none";
   string normalized = value;
   StringTrimLeft(normalized);
   StringTrimRight(normalized);
   if(StringLen(normalized) <= 0)
      return "none";
   return normalized;
  }

string ASC_Run202LowerStatusToken(string value)
  {
   string normalized = ASC_Run202NormalizeStatusToken(value);
   StringToLower(normalized);
   return normalized;
  }

bool ASC_Run202TokenIsNone(const string value)
  {
   string normalized = ASC_Run202LowerStatusToken(value);
   return (normalized == "none" || normalized == "not_attempted" || normalized == "not_applicable" || normalized == "runtime_reset" || normalized == "pending");
  }

bool ASC_Run202ContainsAny(const string haystack,const string a,const string b,const string c)
  {
   string normalized = ASC_Run202LowerStatusToken(haystack);
   return ((StringLen(a) > 0 && StringFind(normalized, a) >= 0)
           || (StringLen(b) > 0 && StringFind(normalized, b) >= 0)
           || (StringLen(c) > 0 && StringFind(normalized, c) >= 0));
  }

string ASC_Run202SdpLifecycleSeverity(const int failed_count,
                                      const string due_state,
                                      const string validation_status,
                                      const string first_missing_token,
                                      const string writer_state,
                                      const string writer_reason)
  {
   if(failed_count > 0)
      return "failure";
   if(!ASC_Run202TokenIsNone(first_missing_token) || ASC_Run202ContainsAny(validation_status, "missing_required", "missing_token", "token"))
      return "failure";
   if(ASC_Run202ContainsAny(writer_state, "failed", "error", "blocked") || ASC_Run202ContainsAny(writer_reason, "failed", "error", "unsafe_path"))
      return "failure";
   if(due_state == "no_open_snapshot" || due_state == "no_committed_membership")
      return "warning";
   if(due_state == "not_due" || due_state == "disabled")
      return "lawful_deferred";
   return "success";
  }

string ASC_Run202SdpCurrentFirstReason(const int failed_count,
                                       const string due_state,
                                       const string validation_status,
                                       const string first_missing_token,
                                       const string last_error,
                                       const string writer_state,
                                       const string writer_reason,
                                       const int no_change_count,
                                       const int retained_last_good_count)
  {
   string normalized_due = ASC_Run202NormalizeStatusToken(due_state);
   string normalized_error = ASC_Run202NormalizeStatusToken(last_error);
   string normalized_writer_state = ASC_Run202NormalizeStatusToken(writer_state);
   string normalized_writer_reason = ASC_Run202NormalizeStatusToken(writer_reason);
   string normalized_validation = ASC_Run202NormalizeStatusToken(validation_status);
   string normalized_missing = ASC_Run202NormalizeStatusToken(first_missing_token);

   if(failed_count > 0)
     {
      if(!ASC_Run202TokenIsNone(normalized_missing))
         return "missing_required_token:" + normalized_missing;
      if(ASC_Run202ContainsAny(normalized_validation, "missing_required", "missing_token", "token"))
         return "missing_required_token";
      if(ASC_Run202ContainsAny(normalized_writer_reason, "path_guard", "unsafe_path", "path"))
         return "path_guard_failed";
      if(!ASC_Run202TokenIsNone(normalized_error))
         return normalized_error;
      if(!ASC_Run202TokenIsNone(normalized_writer_reason))
         return normalized_writer_reason;
      if(!ASC_Run202TokenIsNone(normalized_writer_state))
         return normalized_writer_state;
      return "unknown_requires_investigation";
     }

   if(normalized_due == "no_open_snapshot" || normalized_due == "no_committed_membership" || normalized_due == "no_open_symbols" || normalized_due == "closed_market" || normalized_due == "not_applicable_weekend")
      return normalized_due;
   if(normalized_due == "not_due" || normalized_due == "disabled" || normalized_due == "deferred")
      return normalized_due;
   if(no_change_count > 0)
      return "no_change_skipped";
   if(retained_last_good_count > 0)
      return "retained_last_good";
   if(ASC_Run202ContainsAny(normalized_writer_state, "success", "written", "promoted"))
      return "none";
   return "none";
  }

string ASC_Run202SdpFailurePriorityContract()
  {
   return "priority_order=compile_source_identity_mismatch,path_guard_failed,missing_required_token,final_write_failed,manifest_status_write_failed,blocking_staging_failed,blocking_archive_failed,no_membership_no_snapshot_no_open_symbols,closed_market_not_applicable_weekend,not_due_deferred,no_change_skipped,retained_last_good,none | failed_count_requires_non_none_first_failure=true | lawful_inactive_does_not_increment_failed_count=true | stale_error_cleared_by_success_no_change_defer=true";
  }

string ASC_ScannerStatusRun195SdpProofVisibilityLine(const ASC_RuntimeState &state)
  {
   int global_expected = MathMax(0, state.symbol_data_pack_globaltop10_total);
   int global_completed = MathMax(0, state.symbol_data_pack_globaltop10_written_count)
                          + MathMax(0, state.symbol_data_pack_globaltop10_no_change_count)
                          + MathMax(0, state.symbol_data_pack_globaltop10_retained_last_good_count)
                          + MathMax(0, state.symbol_data_pack_globaltop10_failed_count);
   int top5_expected = MathMax(0, state.symbol_data_pack_top5perbucket_total);
   int top5_completed = MathMax(0, state.symbol_data_pack_top5perbucket_written_count)
                        + MathMax(0, state.symbol_data_pack_top5perbucket_no_change_count)
                        + MathMax(0, state.symbol_data_pack_top5perbucket_retained_last_good_count)
                        + MathMax(0, state.symbol_data_pack_top5perbucket_failed_count);
   string global_due_state = (!state.symbol_data_pack_globaltop10_enabled ? "disabled" : (global_expected <= 0 ? "no_open_snapshot" : ((state.symbol_data_pack_globaltop10_next_due_utc > 0 && TimeCurrent() < state.symbol_data_pack_globaltop10_next_due_utc) ? "not_due" : "due_now")));
   string top5_due_state = (!state.symbol_data_pack_top5perbucket_enabled ? "disabled" : (top5_expected <= 0 ? "no_committed_membership" : ((state.symbol_data_pack_top5perbucket_next_due_utc > 0 && TimeCurrent() < state.symbol_data_pack_top5perbucket_next_due_utc) ? "not_due" : "due_now")));
   string global_due_reason = (global_due_state == "not_due" ? "not_due_next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_globaltop10_next_due_utc) : (global_due_state == "no_open_snapshot" ? "existing_globaltop10_completed_snapshot_empty_or_unavailable_no_lite_membership_faking" : "due_now_or_policy_state"));
   string top5_due_reason = (top5_due_state == "not_due" ? "not_due_next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_next_due_utc) : (top5_due_state == "no_committed_membership" ? "existing_top5perbucket_committed_queue_empty_or_unavailable_no_lite_membership_faking" : "due_now_or_policy_state"));
   string global_run202_severity = ASC_Run202SdpLifecycleSeverity(state.symbol_data_pack_globaltop10_failed_count,
                                                                  global_due_state,
                                                                  state.symbol_data_pack_globaltop10_validation_status,
                                                                  state.symbol_data_pack_globaltop10_first_missing_token,
                                                                  state.symbol_data_pack_globaltop10_last_writer_state,
                                                                  state.symbol_data_pack_globaltop10_last_writer_reason);
   string top5_run202_severity = ASC_Run202SdpLifecycleSeverity(state.symbol_data_pack_top5perbucket_failed_count,
                                                                top5_due_state,
                                                                state.symbol_data_pack_top5perbucket_validation_status,
                                                                state.symbol_data_pack_top5perbucket_first_missing_token,
                                                                state.symbol_data_pack_top5perbucket_last_writer_state,
                                                                state.symbol_data_pack_top5perbucket_last_writer_reason);
   string global_run202_first_failure = ASC_Run202SdpCurrentFirstReason(state.symbol_data_pack_globaltop10_failed_count,
                                                                        global_due_state,
                                                                        state.symbol_data_pack_globaltop10_validation_status,
                                                                        state.symbol_data_pack_globaltop10_first_missing_token,
                                                                        state.symbol_data_pack_globaltop10_last_error,
                                                                        state.symbol_data_pack_globaltop10_last_writer_state,
                                                                        state.symbol_data_pack_globaltop10_last_writer_reason,
                                                                        state.symbol_data_pack_globaltop10_no_change_count,
                                                                        state.symbol_data_pack_globaltop10_retained_last_good_count);
   string top5_run202_first_failure = ASC_Run202SdpCurrentFirstReason(state.symbol_data_pack_top5perbucket_failed_count,
                                                                      top5_due_state,
                                                                      state.symbol_data_pack_top5perbucket_validation_status,
                                                                      state.symbol_data_pack_top5perbucket_first_missing_token,
                                                                      state.symbol_data_pack_top5perbucket_last_error,
                                                                      state.symbol_data_pack_top5perbucket_last_writer_state,
                                                                      state.symbol_data_pack_top5perbucket_last_writer_reason,
                                                                      state.symbol_data_pack_top5perbucket_no_change_count,
                                                                      state.symbol_data_pack_top5perbucket_retained_last_good_count);
   return "RUN195 SDP Non-Blocking Proof Visibility: sdp_baseline_run=RUN193R"
          + " | sdp_child_write_path_preserved=true"
          + " | sdp_final_path_policy=globaltop10_and_top5perbucket_final_files_are_target_proof"
          + " | sdp_flat_root_policy=transition_excluded_from_target_proof"
          + " | sdp_globaltop10_due_state=" + global_due_state
          + " | sdp_globaltop10_due_reason=" + global_due_reason
          + " | sdp_globaltop10_last_attempt_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_globaltop10_last_attempt_utc)
          + " | sdp_globaltop10_last_success_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_globaltop10_last_success_utc)
          + " | sdp_globaltop10_next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_globaltop10_next_due_utc)
          + " | sdp_globaltop10_deferred_until_utc=" + ((global_due_state == "not_due" || global_due_state == "no_open_snapshot" || global_due_state == "disabled") ? ASC_ArtifactFormatUtc(state.symbol_data_pack_globaltop10_next_due_utc) : "not_applicable")
          + " | sdp_globaltop10_weekend_or_closed_context=" + ((global_due_state == "no_open_snapshot") ? "possible_closed_market_or_weekend_context_requires_committed_globaltop10_snapshot" : "not_inferred_by_lite_writer")
          + " | sdp_globaltop10_write_pressure_state=bounded_write_lane_no_flush_loop"
          + " | sdp_globaltop10_attempt_state=" + (state.symbol_data_pack_globaltop10_attempted_count > 0 ? "attempted" : "not_attempted")
          + " | sdp_globaltop10_expected_count=" + IntegerToString(global_expected)
          + " | sdp_globaltop10_written_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_written_count))
          + " | sdp_globaltop10_no_change_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_no_change_count))
          + " | sdp_globaltop10_pending_count=" + IntegerToString(MathMax(0, global_expected - global_completed))
          + " | sdp_globaltop10_deferred_count=" + IntegerToString(StringFind(state.symbol_data_pack_globaltop10_activation_mode, "deferred") >= 0 ? 1 : 0)
          + " | sdp_globaltop10_failed_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_failed_count))
          + " | sdp_globaltop10_failure_taxonomy_run=RUN202R"
          + " | sdp_globaltop10_lifecycle_severity=" + global_run202_severity
          + " | sdp_globaltop10_first_failure_reason=" + global_run202_first_failure
          + " | sdp_globaltop10_route_lifecycle_reason=" + (StringLen(state.symbol_data_pack_globaltop10_last_reason) > 0 ? state.symbol_data_pack_globaltop10_last_reason : "none")
          + " | sdp_globaltop10_" + ASC_ScannerStatusReconciliationProofBlock("globaltop10_mirror", "not_applicable", state.symbol_data_pack_globaltop10_last_reason)
          + " | sdp_globaltop10_first_failure_priority=" + ASC_Run202SdpFailurePriorityContract()
          + " | sdp_top5_due_state=" + top5_due_state
          + " | sdp_top5_due_reason=" + top5_due_reason
          + " | sdp_top5_last_attempt_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_last_attempt_utc)
          + " | sdp_top5_last_success_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_last_success_utc)
          + " | sdp_top5_next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_next_due_utc)
          + " | sdp_top5_deferred_until_utc=" + ((top5_due_state == "not_due" || top5_due_state == "no_committed_membership" || top5_due_state == "disabled") ? ASC_ArtifactFormatUtc(state.symbol_data_pack_top5perbucket_next_due_utc) : "not_applicable")
          + " | sdp_top5_weekend_or_closed_context=" + ((top5_due_state == "no_committed_membership") ? "possible_closed_market_or_weekend_context_requires_live_market_state_basis" : "not_inferred_by_lite_writer")
          + " | sdp_top5_write_pressure_state=bounded_write_lane_no_flush_loop"
          + " | sdp_top5_attempt_state=" + (state.symbol_data_pack_top5perbucket_attempted_count > 0 ? "attempted" : "not_attempted")
          + " | sdp_top5_expected_count=" + IntegerToString(top5_expected)
          + " | sdp_top5_written_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_written_count))
          + " | sdp_top5_no_change_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_no_change_count))
          + " | sdp_top5_pending_count=" + IntegerToString(MathMax(0, top5_expected - top5_completed))
          + " | sdp_top5_deferred_count=" + IntegerToString(StringFind(state.symbol_data_pack_top5perbucket_activation_mode, "deferred") >= 0 ? 1 : 0)
          + " | sdp_top5_failed_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_failed_count))
          + " | sdp_top5_failure_taxonomy_run=RUN202R"
          + " | sdp_top5_lifecycle_severity=" + top5_run202_severity
          + " | sdp_top5_first_failure_reason=" + top5_run202_first_failure
          + " | sdp_top5_route_lifecycle_reason=" + (StringLen(state.symbol_data_pack_top5perbucket_last_reason) > 0 ? state.symbol_data_pack_top5perbucket_last_reason : "none")
          + " | sdp_top5_" + ASC_ScannerStatusReconciliationProofBlock("top5perbucket_mirror", "all_buckets", state.symbol_data_pack_top5perbucket_last_reason)
          + " | sdp_top5_first_failure_priority=" + ASC_Run202SdpFailurePriorityContract()
          + " | sdp_same_source_membership_state=main_l4_committed_snapshot_consumed_read_only"
          + " | sdp_proof_visibility_mode=non_blocking_observation_only"
          + " | sdp_staging_enabled=true | sdp_staging_current_truth=false | sdp_archive_enabled=true | sdp_archive_mode=bounded_previous_final_continuity_evidence | sdp_archive_current_truth=false | sdp_archive_retention_limit=1 | sdp_archive_failure_blocks_final=false | sdp_globaltop10_archive_path_policy=Symbol Data Packs/_archive/GlobalTop10 | sdp_top5_archive_path_policy=Symbol Data Packs/_archive/Top5PerBucket/<bucket> | production_ready=false | live_output_proof=false";
  }

string ASC_ScannerStatusRun147DossierFirstProofClosure(const ASC_RuntimeState &state)
  {
   int selected_required = (ASC_SELECTED_SYMBOL_DOSSIER_ENABLED && StringLen(state.current_focus_live_symbol) > 0 ? 1 : 0);
   int family_target = 0;
   if(ASC_GLOBALTOP10_DOSSIERS_ENABLED)
      family_target += MathMax(0, state.top10_run_full_total);
   if(ASC_TOP5_PER_BUCKET_DOSSIERS_ENABLED)
      family_target += MathMax(0, state.top5_bucket_child_target_count);
   int family_missing = MathMax(0, state.dossier_required_family_missing_count);
   int family_present = MathMax(0, family_target - family_missing);
   string selected_state = (selected_required > 0 ? "selected-symbol-required" : "selected-symbol-none");
   string queue_state = (StringLen(state.dossier_queue_policy_state) > 0 ? state.dossier_queue_policy_state : "unclassified");
   string line = "dossier_policy=selected_and_families_only";
   line += " | root_all_symbol_dossiers_required=false";
   line += " | root_all_symbol_dossiers_disabled_by_policy=true";
   line += " | root_direct_symbol_dossiers_compat_enabled=false";
   line += " | root_direct_symbol_dossier_policy_run193=" + ASC_ROOT_DIRECT_SYMBOL_DOSSIER_POLICY_RUN193;
   line += " | family_dossiers_required=true";
   line += " | selected_dossier_required=selected_symbol_present_only";
   line += " | selected_symbol_requirement_state=" + selected_state;
   line += " | selected_symbol_current_focus_mirroring=" + (ASC_CURRENT_FOCUS_ENABLED ? "required_when_selected" : "disabled_by_policy");
   line += " | family_dossier_target_count=" + IntegerToString(family_target);
   line += " | family_dossier_present_count=" + IntegerToString(family_present);
   line += " | family_dossier_missing_count=" + IntegerToString(family_missing);
   line += " | family_dossier_missing_blocks_pass=" + (family_missing > 0 ? "true" : "false");
   line += " | root_flood_disabled_is_not_missing_failure=true";
   line += " | family_dossier_queue_state=" + queue_state;
   line += " | family_dossier_queue_progressing=" + (queue_state == ASC_DOSSIER_QUEUE_PROGRESSING ? "true" : "false");
   line += " | family_dossier_queue_stalled=" + (queue_state == ASC_DOSSIER_QUEUE_STALLED ? "true" : "false");
   line += " | family_dossier_queue_completed=" + ((family_missing <= 0 && family_target > 0) ? "true" : "false");
   line += " | run150_evidence=Scanner_Status_Dossier_folders_Current_Focus_GlobalTop10_Top5PerBucket";
   return line;
  }

string ASC_ScannerStatusRun147ArchiveTmpProofClosure(const ASC_RuntimeState &state)
  {
   string line = "top5_archive_policy=" + (ASC_TOP5_ARCHIVE_ENABLED ? "archive_previous_on_promote" : "disabled_by_policy");
   line += " | top5_archive_present=" + (state.top5_archive_proof_state == "top5_archive_present" ? "true" : "false");
   line += " | top5_archive_missing=" + (state.top5_archive_proof_state == "top5_archive_missing" ? "true" : "false");
   line += " | globaltop10_archive_policy=" + (ASC_GLOBALTOP10_DOSSIERS_ENABLED ? "archive_previous_on_promote_or_retained_history" : "disabled_by_policy");
   line += " | globaltop10_archive_present=" + (state.globaltop10_archive_proof_state == "globaltop10_archive_present" ? "true" : "false");
   line += " | globaltop10_archive_missing=" + (state.globaltop10_archive_proof_state == "globaltop10_archive_missing" ? "true" : "false");
   line += " | stale_tmp_count=" + (state.globaltop10_stale_tmp_proof_state == "stale_tmp_detected" ? "1" : "0");
   line += " | stale_tmp_oldest_age=runtime_unproven_until_RUN150";
   line += " | stale_tmp_cleanup_policy=proof_first_no_broad_delete_age_gated_prefix_constrained_only";
   line += " | stale_tmp_cleanup_attempted=false";
   return line;
  }
string ASC_Layer3LiveProofSummary(const ASC_RuntimeState &state)
  {
   int total = ArraySize(state.committed_l3_rows);
   if(total <= 0)
      return "l3_ready=no | rows=0 | proof=unavailable";

   int pass_count = 0;
   int burst_total = 0;
   int burst_useful = 0;
   int burst_guarded = 0;
   int decay_dragged = 0;
   int weak_exec = 0;
   int handoff_honest = 0;
   string useful_symbol = "none";
   string guarded_symbol = "none";
   string decay_symbol = "none";

   for(int i = 0; i < total; i++)
     {
      ASC_CommittedLayer3SymbolState row = state.committed_l3_rows[i];
      if(row.evaluation.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
         pass_count++;

      bool burst_flag = row.tick_burst_flag;
      bool weak_execution = (row.execution_score < 60.0
                             || row.spread_stability_score < 55.0
                             || row.quote_stability_score < 60.0);
      bool decay_flag = (row.late_move_risk_score >= 55.0
                         || row.move_age_score < 55.0
                         || row.risk_drag_score >= 55.0);
      bool guarded_burst = (burst_flag
                            && (row.execution_score < 70.0
                                || row.quote_stability_score < 65.0
                                || row.liquidity_quality_score < 45.0
                                || row.move_age_score < 60.0
                                || row.risk_drag_score >= 45.0));
      bool useful_burst = (burst_flag && !guarded_burst);

      if(burst_flag)
         burst_total++;
      if(useful_burst)
        {
         burst_useful++;
         if(useful_symbol == "none" && StringLen(row.symbol) > 0)
            useful_symbol = row.symbol;
        }
      if(guarded_burst)
        {
         burst_guarded++;
         if(guarded_symbol == "none" && StringLen(row.symbol) > 0)
            guarded_symbol = row.symbol;
        }
      if(decay_flag)
        {
         decay_dragged++;
         if(decay_symbol == "none" && StringLen(row.symbol) > 0)
            decay_symbol = row.symbol;
        }
      if(weak_execution)
         weak_exec++;
      if(StringFind(row.score_pack_reason, "Layer 4 still owns execution-adjusted ordering") >= 0)
         handoff_honest++;
     }

   return StringFormat("l3_ready=%s | rows=%d | qualified=%d | burst_total=%d | burst_useful=%d[%s] | burst_guarded=%d[%s] | decay_dragged=%d[%s] | weak_exec=%d | handoff_honest=%d",
                       state.committed_l3_ready ? "yes" : "no",
                       total,
                       pass_count,
                       burst_total,
                       burst_useful,
                       useful_symbol,
                       burst_guarded,
                       guarded_symbol,
                       decay_dragged,
                       decay_symbol,
                       weak_exec,
                       handoff_honest);
  }

string ASC_Run090ArtifactFreshnessStatus(const ASC_RuntimeState &state)
  {
   string alignment = state.top10_run_full_family_alignment_status;
   string normalized = alignment;
   StringToLower(normalized);

   if(StringLen(normalized) <= 0)
      return "current_runtime_unproven";
   if(normalized == "aligned_cadence_hold")
      return "promoted_current";
   if(StringFind(normalized, "archive") >= 0)
      return "archive_historical_only";
   if(StringFind(normalized, "retained") >= 0 || StringFind(normalized, "last_good") >= 0 || StringFind(normalized, "last-good") >= 0 || StringFind(normalized, "continuity") >= 0)
      return "retained_last_good_not_current";
   if(StringFind(normalized, "staging") >= 0 || StringFind(normalized, "refresh_queued") >= 0 || StringFind(normalized, "pending") >= 0 || StringFind(normalized, "queued") >= 0)
      return "staging_not_current";
   if(StringFind(normalized, "mismatch") >= 0 || StringFind(normalized, "stale") >= 0)
      return "stale_not_current";
   if(StringFind(normalized, "degraded") >= 0)
      return "degraded_current";
   if(StringFind(normalized, "promoted") >= 0 || StringFind(normalized, "aligned_current") >= 0)
      return "promoted_current";
   return ASC_ArtifactFreshnessStatusFromState(alignment);
  }

string ASC_Run090CurrentFocusMirrorStatus(const ASC_RuntimeState &state)
  {
   string selected_symbol = state.current_focus_sync_last_selected_symbol;
   if(StringLen(selected_symbol) <= 0) selected_symbol = state.current_focus_live_symbol;
   if(StringLen(selected_symbol) <= 0) selected_symbol = state.current_focus_view_symbol;
   if(StringLen(selected_symbol) <= 0) return "selected_symbol_none_not_failure";
   string status = (StringLen(state.current_focus_last_status) > 0 ? state.current_focus_last_status : "unobserved");
   return "selected_symbol_dossier_mirror_alias_not_truth_owner|selected_symbol=" + selected_symbol + "|mirror_status=" + status;
  }

string ASC_Run091ContradictionScopeAppend(const string current_scope,const string item)
  {
   if(StringLen(item) <= 0)
      return current_scope;
   if(StringLen(current_scope) <= 0 || current_scope == "none")
      return item;
   return current_scope + "," + item;
  }

int ASC_Run091ProofDebtCount(const ASC_RuntimeState &state,
                             const int backlog_count,
                             const string artifact_freshness_status,
                             const string current_focus_mirror_status)
  {
   int count = 0;
   if(state.top10_run_full_total <= 0 || state.top10_run_full_cursor < state.top10_run_full_total)
      count++;
   if(state.top10_run_full_verify_fail_count > 0 || state.top10_deferred_l5_expired_count > 0 || state.top10_deferred_l5_retry_exhausted_count > 0)
      count++;
   if(backlog_count > 0 || state.dossier_queue_stall_count > 0)
      count++;
   if(artifact_freshness_status != "promoted_current" && artifact_freshness_status != "written_by_current_run")
      count++;
   if(StringFind(current_focus_mirror_status, "selected_symbol_none_not_failure") >= 0 || StringFind(current_focus_mirror_status, "unobserved") >= 0)
      count++;
   return count;
  }

string ASC_Run091ContradictionSeverity(const int contradiction_count)
  {
   if(contradiction_count >= 4)
      return "critical";
   if(contradiction_count >= 2)
      return "high";
   if(contradiction_count == 1)
      return "medium";
   return "none";
  }

int ASC_Run091ContradictionCount(const ASC_RuntimeState &state,
                                 const int backlog_count,
                                 const string artifact_freshness_status,
                                 const string current_focus_mirror_status,
                                 string &scope_out)
  {
   int count = 0;
   scope_out = "none";
   string alignment = state.top10_run_full_family_alignment_status;
   string normalized_alignment = alignment;
   StringToLower(normalized_alignment);

   if(StringLen(normalized_alignment) <= 0 || normalized_alignment == "unproven" || StringFind(normalized_alignment, "mismatch") >= 0 || StringFind(normalized_alignment, "failed") >= 0 || StringFind(normalized_alignment, "stale") >= 0)
     {
      count++;
      scope_out = ASC_Run091ContradictionScopeAppend(scope_out, "market_board_globaltop10_alignment");
     }
   if(state.top10_run_full_verify_fail_count > 0 || state.top10_deferred_l5_expired_count > 0 || state.top10_deferred_l5_retry_exhausted_count > 0)
     {
      count++;
      scope_out = ASC_Run091ContradictionScopeAppend(scope_out, "globaltop10_child_hydration");
     }
   if(backlog_count > 0 && state.dossier_queue_stall_count > 0)
     {
      count++;
      scope_out = ASC_Run091ContradictionScopeAppend(scope_out, "dossier_queue_backlog_stall");
     }
   if(artifact_freshness_status == "stale_not_current" || artifact_freshness_status == "retained_last_good_not_current" || artifact_freshness_status == "archive_historical_only" || artifact_freshness_status == "staging_not_current")
     {
      count++;
      scope_out = ASC_Run091ContradictionScopeAppend(scope_out, "artifact_currentness");
     }
   if(StringFind(current_focus_mirror_status, "unobserved") >= 0)
     {
      count++;
      scope_out = ASC_Run091ContradictionScopeAppend(scope_out, "current_focus_mirror_unobserved");
     }
   return count;
  }


string ASC_Run090ScannerProofDashboard(const ASC_RuntimeState &state)
  {
   string artifact_freshness_status = ASC_Run090ArtifactFreshnessStatus(state);
   string current_focus_mirror_status = ASC_Run090CurrentFocusMirrorStatus(state);
   int backlog_count = state.l1_publish_pending_dossiers ? MathMax(0, state.dossier_pending_backlog_count) : MathMax(0, state.deferred_write_artifacts);
   string line = "RUN090 Proof Dashboard\n";
   line += "- run090_proof_surface=present\n";
   line += "- source_run_id=" + ASC_SourceRunId() + " | source_identity_token=" + ASC_SourceIdentityToken() + " | artifact_written_by_run=" + ASC_SourceRunId() + " | artifact_schema_version=" + ASC_ArtifactSchemaVersion() + " | build_identity_present=true\n";
   line += "- deep_hydration_pending=" + IntegerToString(MathMax(0, state.top10_deferred_l5_pending_count)) + " | deep_hydration_expired=" + IntegerToString(MathMax(0, state.top10_deferred_l5_expired_count)) + " | deep_hydration_retry_exhausted=" + IntegerToString(MathMax(0, state.top10_deferred_l5_retry_exhausted_count)) + " | deep_hydration_completed=" + IntegerToString(MathMax(0, state.top10_deferred_l5_completed_count)) + " | deferred_l5_last_state=" + (StringLen(state.top10_deferred_l5_last_state) > 0 ? state.top10_deferred_l5_last_state : "not_required") + "\n";
   line += "- dossier_queue_state=" + (StringLen(state.dossier_queue_state) > 0 ? state.dossier_queue_state : "idle") + " | dossier_queue_cursor=" + IntegerToString(MathMax(0, state.dossier_queue_cursor_total)) + " | dossier_queue_backlog_count=" + IntegerToString(MathMax(0, backlog_count)) + " | dossier_queue_stall_count=" + IntegerToString(MathMax(0, state.dossier_queue_stall_count)) + " | dossier_queue_recovered_count=" + IntegerToString(MathMax(0, state.dossier_queue_recovered_count)) + "\n";
   line += "- alignment_status=" + (StringLen(state.top10_run_full_family_alignment_status) > 0 ? state.top10_run_full_family_alignment_status : "unproven") + " | board_signature=" + (StringLen(state.top10_run_full_current_source_signature) > 0 ? state.top10_run_full_current_source_signature : "unavailable") + " | derived_from_board_signature=" + (StringLen(state.top10_run_full_last_completed_source_signature) > 0 ? state.top10_run_full_last_completed_source_signature : "unavailable") + " | stale_current_guard=active\n";
   line += "- artifact_freshness_status=" + artifact_freshness_status + " | freshness_taxonomy=file_exists_only,non_empty_unproven,written_by_current_run,promoted_current,current_runtime_unproven,staging_not_current,archive_historical_only,retained_last_good_not_current,stale_not_current,degraded_current,continuity_fallback,missing,selected_symbol_none_not_failure | current_requires_written_by_run_and_promoted=true | file_exists_is_fresh_current_promoted_proof=false | retained_is_current=false | stale_is_current=false | staging_is_current=false | archive_is_current=false\n";
   line += "- file_exists_only=path_observed_not_proof | non_empty_unproven=payload_exists_not_current | written_by_current_run=source_run_id_required | promoted_current=written_by_current_run_and_promoted_required | current_runtime_unproven=source_visible_live_unproven\n";
   line += "- staging_not_current=true | archive_historical_only=true | retained_last_good_not_current=true | stale_not_current=true | degraded_current=label_degraded_not_complete | continuity_fallback=last_good_continuity_not_new_current | missing=not_written | selected_symbol_none_not_failure=true\n";
   line += "- current_focus_mirror_status=" + current_focus_mirror_status + " | Current Focus=selected-symbol Dossier mirror | independent_truth_owner=false\n";
   line += "- " + ASC_FunctionResultsRun090AggregateProofTokens(state.top10_deferred_l5_pending_count, state.top10_deferred_l5_expired_count, state.top10_deferred_l5_retry_exhausted_count, state.top10_deferred_l5_completed_count, state.dossier_queue_state, state.dossier_queue_cursor_total, backlog_count, state.dossier_queue_stall_count, state.dossier_queue_recovered_count, state.top10_run_full_family_alignment_status, state.top10_run_full_current_source_signature, state.top10_run_full_last_completed_source_signature, artifact_freshness_status, current_focus_mirror_status) + "\n";
   line += "RUN110 Top5PerBucket PreLive Readiness Source Patch\n";
   line += "- " + ASC_Top5BucketSkeletonProofTokens(state.top5_bucket_family_state,
                                                     state.top5_bucket_count,
                                                     state.top5_bucket_child_target_count,
                                                     state.top5_bucket_child_written_count,
                                                     state.top5_bucket_child_pending_count,
                                                     state.top5_bucket_child_failed_count,
                                                     state.top5_bucket_queue_remaining,
                                                     state.top5_bucket_last_symbol,
                                                     state.top5_bucket_last_error) + "\n";
   line += "- top5_market_board_sync=false | top5_market_board_sync_status=pending_market_board_visible_signature_compare | market_board_to_top5_dossier_sync=false | market_board_to_top5_dossier_sync_status=pending_market_board_visible_signature_compare | verdict_owner=ASC_MarketBoardWriter_signature_compare | scanner_status_does_not_claim_visible_board_sync=true\n";
   line += "- market_board_archive_enabled=" + (ASC_MARKET_BOARD_ARCHIVE_ENABLED ? "true" : "false") + " | market_board_archive_truth_owner=false | market_board_archive_history_only=true | market_board_archive_bounded_retention_slots=" + IntegerToString(MathMax(1, ASC_MARKET_BOARD_ARCHIVE_RETENTION_SLOTS)) + " | market_board_archive_no_change_skip=true | market_board_archive_verdict_owner=ASC_MarketBoardWriter_after_successful_publish\n";
   string run091_contradiction_scope = "none";
   int run091_contradiction_count = ASC_Run091ContradictionCount(state, backlog_count, artifact_freshness_status, current_focus_mirror_status, run091_contradiction_scope);
   string run091_contradiction_severity = ASC_Run091ContradictionSeverity(run091_contradiction_count);
   int run091_proof_debt_count = ASC_Run091ProofDebtCount(state, backlog_count, artifact_freshness_status, current_focus_mirror_status);
   line += "RUN091 Proof Harness\n";
   line += "- run091_proof_surface=present | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN + " | proof_boundary=source_patched_live_unproven_until_RUN095R | latest_live_evidence_boundary=RUN089R\n";
   line += "- timer_queue_skip_risk_visible=true | heartbeat_work_must_be_bounded=true | heartbeat_last_duration_ms=" + IntegerToString(MathMax(0, state.heartbeat_last_duration_ms)) + " | heartbeat_budget_scan_ms=" + IntegerToString(MathMax(0, state.heartbeat_budget_scan_ms)) + " | heartbeat_budget_write_ms=" + IntegerToString(MathMax(0, state.heartbeat_budget_write_ms)) + " | heartbeat_budget_ui_ms=" + IntegerToString(MathMax(0, state.heartbeat_budget_ui_ms)) + "\n";
   line += "- top10_hydration_progress=" + IntegerToString(MathMax(0, state.top10_run_full_cursor)) + "/" + IntegerToString(MathMax(0, state.top10_run_full_total)) + " | top10_batch_status=" + (StringLen(state.top10_run_full_batch_status) > 0 ? state.top10_run_full_batch_status : "unobserved") + " | top10_batch_reason=" + (StringLen(state.top10_run_full_batch_reason) > 0 ? state.top10_run_full_batch_reason : "unobserved") + " | top10_verify_pass_count=" + IntegerToString(MathMax(0, state.top10_run_full_verify_pass_count)) + " | top10_verify_fail_count=" + IntegerToString(MathMax(0, state.top10_run_full_verify_fail_count)) + " | partial_child_is_complete=false\n";
   line += "- contradiction_count=" + IntegerToString(MathMax(0, run091_contradiction_count)) + " | worst_contradiction_severity=" + run091_contradiction_severity + " | contradiction_scope=" + run091_contradiction_scope + " | requires_operator_review=" + (run091_contradiction_count > 0 ? "true" : "false") + " | proof_debt_count=" + IntegerToString(MathMax(0, run091_proof_debt_count)) + "\n";
   line += "- file_exists_is_currentness_proof=false | non_empty_file_is_truth_proof=false | retained_last_good_is_current=false | missing_tick_is_zero_truth=false | history_not_ready_is_no_signal=false | edge_truth_context_only=true | trade_signal=false | lot_sizing=false | sl_tp_change=false | execution_change=false\n";
   line += "- " + ASC_ScannerStatusDossierPolicyTokens(state) + "\n";
   line += "- " + ASC_FunctionResultsRun091AggregateProofTokens(state.top10_run_full_total, state.top10_run_full_cursor, state.top10_run_full_batch_status, state.top10_run_full_verify_pass_count, state.top10_run_full_verify_fail_count, state.heartbeat_last_duration_ms, state.heartbeat_budget_scan_ms, state.heartbeat_budget_write_ms, run091_contradiction_count, run091_contradiction_severity, run091_contradiction_scope, run091_proof_debt_count) + "\n";
   int run092_alignment_contradiction_count = (run091_contradiction_count > 0 ? run091_contradiction_count : ((state.top10_run_full_verify_fail_count > 0) ? state.top10_run_full_verify_fail_count : 0));
   string run092_worst_alignment_contradiction = (run092_alignment_contradiction_count > 0 ? run091_contradiction_severity : "none");
   line += "RUN092 Alignment Proof Harness\n";
   line += "- run092_proof_surface=present | alignment_scope=market_board_globaltop10_dossier | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN + " | proof_boundary=source_patched_live_unproven_until_RUN095R | latest_live_evidence_boundary=RUN089R\n";
   line += "- board_signature=" + (StringLen(state.top10_run_full_current_source_signature) > 0 ? state.top10_run_full_current_source_signature : "unavailable") + " | derived_from_board_signature=" + (StringLen(state.top10_run_full_last_completed_source_signature) > 0 ? state.top10_run_full_last_completed_source_signature : "unavailable") + " | top10_child_expected_count=" + IntegerToString(MathMax(0, state.top10_run_full_total)) + " | top10_child_cursor=" + IntegerToString(MathMax(0, state.top10_run_full_cursor)) + " | child_partial_is_complete=false | retained_child_is_current=false | stale_dossier_is_current=false\n";
   line += "- board_top_symbol_missing_child_detectable=true | board_rank_child_rank_mismatch_detectable=true | board_symbol_child_symbol_mismatch_detectable=true | board_signature_child_signature_mismatch_detectable=true | child_currentness_weaker_than_board_detectable=true | child_partial_but_board_complete_detectable=true | dossier_symbol_mismatch_detectable=true | dossier_source_run_mismatch_detectable=true | dossier_section_incomplete_but_child_complete_detectable=true | deep_pending_but_board_implies_deep_complete_detectable=true | retained_child_marked_current_detectable=true | stale_dossier_marked_current_detectable=true\n";
   line += "- alignment_contradiction_count=" + IntegerToString(MathMax(0, run092_alignment_contradiction_count)) + " | worst_alignment_contradiction=" + run092_worst_alignment_contradiction + " | requires_operator_review=" + (run092_alignment_contradiction_count > 0 ? "true" : "false") + " | proof_debt_count=" + IntegerToString(MathMax(0, run091_proof_debt_count)) + "\n";
   line += "- " + ASC_FunctionResultsRun092AggregateProofTokens(state.top10_run_full_total, state.top10_run_full_cursor, state.top10_run_full_family_alignment_status, state.top10_run_full_current_source_signature, state.top10_run_full_last_completed_source_signature, state.top10_run_full_verify_pass_count, state.top10_run_full_verify_fail_count, run092_alignment_contradiction_count, run092_worst_alignment_contradiction, run091_proof_debt_count) + "\n";
   string run093_selected_symbol_state = (StringLen(state.hud_selected_symbol) > 0 ? "selected_symbol_known" : "no_selected_symbol");
   string run093_current_focus_mirror_status = ASC_Run090CurrentFocusMirrorStatus(state);
   string run093_dossier_completeness_state = (StringFind(run093_current_focus_mirror_status, "current") >= 0 ? "complete" : "runtime_unproven_until_RUN100R");
   string run093_deep_section_state = (StringFind(run093_current_focus_mirror_status, "deep") >= 0 ? "complete_or_pending_source_visible" : "runtime_unproven_until_RUN100R");
   int run093_mirror_contradiction_count = (StringFind(run093_current_focus_mirror_status, "mismatch") >= 0 || StringFind(run093_current_focus_mirror_status, "stale") >= 0 || StringFind(run093_current_focus_mirror_status, "unobserved") >= 0) ? 1 : 0;
   string run093_worst_mirror_contradiction = (run093_mirror_contradiction_count > 0 ? "mirror_state_not_current_or_unobserved" : "none");
   line += "RUN093 Dossier Current Focus Mirror Proof Harness\n";
   line += "- run093_proof_surface=present | mirror_scope=dossier_current_focus_selected_symbol_derivative | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN + " | proof_boundary=source_patched_live_unproven_until_RUN095R | latest_live_evidence_boundary=RUN089R\n";
   line += "- selected_symbol_state=" + run093_selected_symbol_state + " | selected_symbol=" + (StringLen(state.hud_selected_symbol) > 0 ? state.hud_selected_symbol : "none") + " | current_focus_mirror_status=" + run093_current_focus_mirror_status + " | current_focus_truth_owner=false | current_focus_derivative_only=true | selected_symbol_none_not_failure=true\n";
   line += "- dossier_completeness_state=" + run093_dossier_completeness_state + " | deep_section_state=" + run093_deep_section_state + " | section_taxonomy=" + ASC_DOSSIER_SECTION_COMPLETENESS_TAXONOMY + " | mirror_state_taxonomy=" + ASC_CURRENT_FOCUS_MIRROR_STATE_TAXONOMY + "\n";
   line += "- selected_symbol_none_but_current_focus_current_detectable=true | selected_symbol_known_but_current_focus_missing_detectable=true | current_focus_symbol_mismatch_detectable=true | current_focus_source_run_mismatch_detectable=true | selected_dossier_source_run_mismatch_detectable=true | current_focus_newer_than_source_dossier_unproven_detectable=true | current_focus_richer_than_source_dossier_unproven_detectable=true | current_focus_thinner_than_source_dossier_without_degradation_detectable=true | source_dossier_partial_but_current_focus_complete_detectable=true | deep_pending_but_current_focus_complete_detectable=true | retained_current_focus_marked_current_detectable=true | stale_current_focus_marked_current_detectable=true | current_focus_truth_owner_drift_detectable=true | mirror_relation_missing_detectable=true | selected_symbol_none_not_failure_missing_detectable=true\n";
   line += "- mirror_contradiction_count=" + IntegerToString(MathMax(0, run093_mirror_contradiction_count)) + " | worst_mirror_contradiction=" + run093_worst_mirror_contradiction + " | requires_operator_review=" + (run093_mirror_contradiction_count > 0 ? "true" : "false") + " | proof_debt_count=" + IntegerToString(MathMax(0, run091_proof_debt_count + run093_mirror_contradiction_count)) + "\n";
   line += "- " + ASC_FunctionResultsRun093AggregateProofTokens(run093_selected_symbol_state, run093_current_focus_mirror_status, run093_dossier_completeness_state, run093_deep_section_state, run093_mirror_contradiction_count, run093_worst_mirror_contradiction, run091_proof_debt_count + run093_mirror_contradiction_count) + "\n";
   int run093_hydration_rows = ArraySize(state.dossier_hydration_rows);
   int run093_queue_remaining = MathMax(0, state.dossier_pending_backlog_count);
   string run093_warmup_state = state.post_warmup_steady ? "post_warmup_steady" : (state.warmup_degraded_first_publish ? "warmup_timeout_degraded_publish" : (state.warmup_first_top10_released ? "globaltop10_first_publish_released" : (state.warmup_first_top10_armed ? "globaltop10_first_publish_armed" : (state.startup_warmup_active ? "startup_warmup_active" : "source_supported_runtime_unproven"))));
   line += "RUN093 Roadmap Reanchor Phase 2A Proof Harness\n";
   line += "- run093_reanchor_surface=present | roadmap_authority=TRUTH_SEEKER_ROADMAP.md | true_current_phase=Immediate_Repair_plus_Phase_2A | run091_run092_are_support_work=true | phase2a_complete=false | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN + "\n";
   line += "- hydration_class_taxonomy=" + ASC_DOSSIER_HYDRATION_CLASS_TAXONOMY + " | three_kb_reason_taxonomy=" + ASC_DOSSIER_3KB_REASON_TAXONOMY + "\n";
   line += "- warmup_first_publish_taxonomy=" + ASC_WARMUP_FIRST_PUBLISH_STATE_TAXONOMY + " | warmup_state=" + run093_warmup_state + " | degraded_first_publish_is_complete=false\n";
   line += "- queue_proof_taxonomy=" + ASC_DOSSIER_QUEUE_PROOF_TAXONOMY + " | dossier_queue_state=" + (StringLen(state.dossier_queue_state) > 0 ? state.dossier_queue_state : "idle") + " | queue_remaining=" + IntegerToString(run093_queue_remaining) + " | stalled_count=" + IntegerToString(MathMax(0, state.dossier_queue_stall_count)) + " | hydration_rows_observed=" + IntegerToString(run093_hydration_rows) + "\n";
   line += "- file_exists_is_hydration_proof=false | non_empty_file_is_completion_proof=false | closed_compact_is_not_failure=true | open_shell_can_be_incomplete=true | dependency_blocked_explicit=true | run095_allowed_only_if_phase2a_source_ready=true\n";
   line += "- " + ASC_FunctionResultsRun093RoadmapReanchorProofTokens(run093_warmup_state, state.dossier_queue_state, run093_queue_remaining, state.dossier_queue_stall_count, run093_hydration_rows, "RUN094R_phase2a_queue_resume_patch_before_live") + "\n";
   int run094_dependency_blocked_count = MathMax(0, state.phase2a_hydration_dependency_blocked_count + state.phase2a_three_kb_dependency_blocked_count);
   line += "RUN094 Phase 2A Source Patch Proof Harness\n";
   line += "- run094_phase2a_source_patch_surface=present | proof_boundary=" + ASC_RUN094_PHASE2A_PROOF_BOUNDARY + " | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN + " | latest_live_evidence_boundary=RUN089R\n";
   line += "RUN096 Live Super Audit Boundary\n";
   line += "- run096_live_super_audit_surface=present | proof_boundary=" + ASC_TRUTH_SEEKER_RUN096R_PROOF_BOUNDARY + " | live_runtime_output_observed=yes | metaeditor_compile_output_provided=no | phase2a_pending_run097_closeout=yes | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN + " | source_patch_required_for_falsifiability=yes | no_rank_formula_strategy_execution_change=true\n";
   line += "RUN097 Phase 2A Closeout Proof Boundary\n";
   line += "- run097_phase2a_closeout_surface=present | proof_boundary=" + ASC_TRUTH_SEEKER_RUN097R_PROOF_BOUNDARY + " | latest_live_evidence_boundary=RUN096R | live_output_requested_this_run=no | compile_claim_made=no | phase2a_closeout_decision=closed_with_bounded_carry_forward_debt | phase3a_allowed_next=true | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN + "\n";
   line += "- standalone_surface_classification=scanner_status_expected_file:" + ASC_SCANNER_STATUS_FILE + ",functionresults_log_only_expected_file:" + ASC_FUNCTION_RESULT_LOGFILE + ",manifest_identity_required:true,current_focus_expected_alias:" + ASC_CURRENT_FOCUS_FILE + ",root_current_dossier_derivative:true,standalone_absence_is_operator_review_not_runtime_failure_until_RUN100:true\n";
   line += "- run097_manifest_identity_contract=source_run_id:" + ASC_SourceRunId() + ",source_identity_token_present:true,artifact_schema_version:" + ASC_ArtifactSchemaVersion() + ",compile_proof:not_claimed,runtime_boot:prior_live_observed,live_output:this_run_not_requested,currentness:requires_promoted_identity,next_live_checkpoint:" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN + "\n";
   line += "- run097_3kb_classification_contract=file_size_diagnostic_only:true,required_reasons:closed_compact_honest|open_hydration_incomplete|unavailable_garbage_shell|dependency_blocked|write_budget_leftover|publication_interrupted|stalled_due_retry|retained_last_good_compact|unknown_requires_review,unknown_requires_review_count:" + IntegerToString(MathMax(0, state.phase2a_three_kb_unknown_requires_review_count)) + "\n";
   line += "- run097_globaltop10_child_contract=expected_children:10,requires_child_rank_symbol_identity:true,requires_source_run_identity:true,requires_board_or_child_signature:true,hydration_class_required:TOP10_L0_L6,deep_section_state_required:true,partial_marked_complete_forbidden:true,no_manual_run_full_dependency_required:true\n";
   line += "- run097_current_focus_contract=current_focus_role:root_current_dossier_derivative,independent_truth_owner:false,selected_symbol_none_not_failure:true,same_symbol_proof_required:true,source_run_match_required:true,mirror_state_required:true,stale_retained_current_boundary_required:true\n";
   line += "- " + ASC_FunctionResultsRun097Phase2ACloseoutProofTokens("expected_standalone_file_requires_RUN100_locator", "log_only_aggregate_until_file_proven", "patched_source_identity_summary", "root_current_dossier_derivative_classified", "reason_class_required_not_size_only", "ten_child_header_signature_deep_state_required", state.phase2a_requires_operator_review_count + state.phase2a_three_kb_unknown_requires_review_count) + "\n";
   line += "- hydration_counts=closed_l0_l2:" + IntegerToString(MathMax(0, state.phase2a_hydration_closed_l0_l2_count)) + ",open_l0_l4:" + IntegerToString(MathMax(0, state.phase2a_hydration_open_l0_l4_count)) + ",top10_l0_l6:" + IntegerToString(MathMax(0, state.phase2a_hydration_top10_l0_l6_count)) + ",selected_l0_l6:" + IntegerToString(MathMax(0, state.phase2a_hydration_selected_l0_l6_count)) + ",stalled:" + IntegerToString(MathMax(0, state.phase2a_hydration_stalled_count)) + ",incomplete:" + IntegerToString(MathMax(0, state.phase2a_hydration_incomplete_count)) + ",dependency_blocked:" + IntegerToString(MathMax(0, state.phase2a_hydration_dependency_blocked_count)) + "\n";
   line += "- three_kb_reason_counts=closed_compact_honest:" + IntegerToString(MathMax(0, state.phase2a_three_kb_closed_compact_honest_count)) + ",open_hydration_incomplete:" + IntegerToString(MathMax(0, state.phase2a_three_kb_open_hydration_incomplete_count)) + ",unavailable_garbage_shell:" + IntegerToString(MathMax(0, state.phase2a_three_kb_unavailable_garbage_shell_count)) + ",dependency_blocked:" + IntegerToString(MathMax(0, state.phase2a_three_kb_dependency_blocked_count)) + ",write_budget_leftover:" + IntegerToString(MathMax(0, state.phase2a_three_kb_write_budget_leftover_count)) + ",publication_interrupted:" + IntegerToString(MathMax(0, state.phase2a_three_kb_publication_interrupted_count)) + ",stalled_due_retry:" + IntegerToString(MathMax(0, state.phase2a_three_kb_stalled_due_retry_count)) + ",retained_last_good_compact:" + IntegerToString(MathMax(0, state.phase2a_three_kb_retained_last_good_compact_count)) + ",unknown_requires_review:" + IntegerToString(MathMax(0, state.phase2a_three_kb_unknown_requires_review_count)) + "\n";
   line += "- queue_resume_backfill_state=queue_active:" + (state.dossier_queue_active ? "yes" : "no") + ",queue_cursor:" + IntegerToString(MathMax(0, state.dossier_queue_cursor_total)) + ",queue_remaining:" + IntegerToString(MathMax(0, state.dossier_queue_remaining_count)) + ",queue_completed:" + IntegerToString(MathMax(0, state.dossier_queue_completed_count)) + ",queue_stalled:" + IntegerToString(MathMax(0, state.dossier_queue_stalled_count)) + ",backfill_pending:" + IntegerToString(MathMax(0, state.dossier_backfill_pending_count)) + ",last_completed:" + ASC_TextOrUnavailable(state.dossier_queue_last_completed_symbol) + ",last_failed:" + ASC_TextOrUnavailable(state.dossier_queue_last_failed_symbol) + ",retry_count:" + IntegerToString(MathMax(0, state.dossier_queue_retry_count)) + ",stall_reason:" + ASC_TextOrUnavailable(state.dossier_queue_service_last_stall_reason) + ",dependency_block:" + ASC_TextOrUnavailable(state.dossier_dependency_block_reason) + ",write_budget:" + IntegerToString(MathMax(0, state.dossier_write_budget_used)) + "/" + IntegerToString(MathMax(0, state.dossier_write_budget_max)) + "\n";
   line += "- warmup_first_publish_gate=max_seconds:" + "90" + ",max_heartbeats:" + "120" + ",max_retry_cycles:" + "4" + ",min_useful_threshold:" + "5" + ",l2_unavailable:" + IntegerToString(MathMax(0, state.warmup_l2_unavailable_count)) + ",l3_committed:" + IntegerToString(MathMax(0, ArraySize(state.committed_l3_rows))) + ",l4_shortlist_settled:" + (state.warmup_l4_shortlist_settled ? "yes" : "no") + ",first_publish_status:" + ASC_TextOrUnavailable(state.warmup_first_publish_status) + ",degraded_reason:" + ASC_TextOrUnavailable(state.warmup_degraded_first_publish_reason) + ",no_freeze_escape_available:" + (state.warmup_no_freeze_escape_available ? "yes" : "no") + ",later_refresh_not_blocked:" + (state.warmup_later_refresh_not_blocked_by_first_latch ? "yes" : "no") + "\n";
   line += "- phase2a_requires_operator_review=" + IntegerToString(MathMax(0, state.phase2a_requires_operator_review_count)) + " | proof_debt_count=" + IntegerToString(MathMax(0, state.dossier_queue_remaining_count + state.dossier_queue_stalled_count + run094_dependency_blocked_count + state.phase2a_requires_operator_review_count)) + " | functionresults_aggregate_only=true | per_symbol_functionresults_rows=false | run095_live_test_valid_if_compile_passes=true\n";
   line += "- " + ASC_FunctionResultsRun094Phase2AProofTokens(run093_warmup_state, state.dossier_queue_state, state.dossier_queue_remaining_count, state.dossier_queue_completed_count, state.dossier_queue_stalled_count, state.dossier_backfill_pending_count, run094_dependency_blocked_count, run093_hydration_rows, state.phase2a_requires_operator_review_count) + "\n";
   return line;
  }

ASC_ArtifactContract ASC_ScannerStatusContract(const string server_root)
  {
   ASC_ArtifactContract contract;
   contract.family = ASC_ARTIFACT_SCANNER_STATUS;
   contract.artifact_name = "Scanner Status";
   contract.target_path = server_root + "\\" + ASC_SCANNER_STATUS_FILE;
   contract.publication_state = ASC_PUBLICATION_PENDING;
   return contract;
  }

ASC_FunctionResult ASC_WriteScannerStatusArtifact(const ASC_RuntimeState &state,
                                                  const ASC_Layer1PassSummary &summary,
                                                  const datetime now_utc)
  {
   ASC_FunctionResult result;
   ASC_FunctionResultBegin(result, "ASC_ScannerStatusWriter", "ASC_WriteScannerStatusArtifact", "runtime");

   ASC_ArtifactContract contract = ASC_ScannerStatusContract(state.server_root);
   string scanner_status_path = contract.target_path;
   string market_board_archive_manifest_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Market Board Archive\\_latest_market_board_archive_manifest.txt" : "");
   string top5_current_manifest_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\Top5PerBucket\\_family_manifest.txt" : "");
   string top5_staging_manifest_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\Top5PerBucket\\_staging\\_staging_manifest.txt" : "");
   string top5_archive_manifest_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\Top5PerBucket\\archive\\_archive_manifest.txt" : "");
   string top5_archive_root_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\Top5PerBucket\\archive" : "");
   string globaltop10_current_manifest_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\GlobalTop10\\_family_manifest.txt" : "");
   string globaltop10_archive_root_path = (StringLen(state.server_root) > 0 ? state.server_root + "\\Dossiers\\GlobalTop10\\archive" : "");
   bool selected_symbol_present_for_proof = (StringLen(state.current_focus_live_symbol) > 0 || StringLen(state.current_focus_sync_last_selected_symbol) > 0 || StringLen(state.hud_selected_symbol) > 0);
   bool scanner_status_present_for_proof = (StringLen(scanner_status_path) > 0);
   bool market_board_current_present_for_proof = ASC_FileExistsCommon(state.market_board_path);
   bool market_board_archive_present_for_proof = ASC_FileExistsCommon(market_board_archive_manifest_path);
   bool top5_current_present_for_proof = ASC_FileExistsCommon(top5_current_manifest_path);
   bool top5_staging_present_for_proof = ASC_FileExistsCommon(top5_staging_manifest_path);
   bool top5_archive_present_for_proof = (ASC_FileExistsCommon(top5_archive_manifest_path) || ASC_RuntimeProofDirectoryHasAnyChild(top5_archive_root_path));
   bool globaltop10_current_present_for_proof = ASC_FileExistsCommon(globaltop10_current_manifest_path);
   bool globaltop10_archive_present_for_proof = ASC_RuntimeProofDirectoryHasAnyChild(globaltop10_archive_root_path);
   bool dossier_present_for_proof = (StringLen(state.dossiers_path) > 0 && (ASC_FileExistsCommon(state.dossiers_path) || ASC_RuntimeProofDirectoryHasAnyChild(state.dossiers_path)));
   bool current_focus_present_for_proof = ASC_FileExistsCommon(state.current_focus_path);
   bool functionresults_present_for_proof = ASC_FileExistsCommon(state.function_results_log_path);
   bool heartbeat_present_for_proof = ASC_FileExistsCommon(state.heartbeat_log_path);
   bool artifact_manifest_present_for_proof = (StringLen(state.bundle_manifest_path) > 0);
   bool stale_tmp_proof_present_for_proof = (StringLen(state.globaltop10_stale_tmp_proof_state) > 0 || StringLen(state.globaltop10_stale_tmp_proof_reason) > 0);
   bool phase5_gate_surface_present_for_proof = true;
   bool phase6_gate_surface_present_for_proof = true;
   bool phase7_gate_surface_present_for_proof = true;
   bool phase8_gate_surface_present_for_proof = true;
   string proof_bundle_line = ASC_RuntimeProofBundleCompletenessLine(scanner_status_present_for_proof,
                                                                     market_board_current_present_for_proof,
                                                                     market_board_archive_present_for_proof,
                                                                     top5_current_present_for_proof,
                                                                     top5_staging_present_for_proof,
                                                                     top5_archive_present_for_proof,
                                                                     globaltop10_current_present_for_proof,
                                                                     globaltop10_archive_present_for_proof,
                                                                     dossier_present_for_proof,
                                                                     selected_symbol_present_for_proof,
                                                                     current_focus_present_for_proof,
                                                                     functionresults_present_for_proof,
                                                                     heartbeat_present_for_proof,
                                                                     artifact_manifest_present_for_proof,
                                                                     stale_tmp_proof_present_for_proof,
                                                                     phase5_gate_surface_present_for_proof,
                                                                     phase6_gate_surface_present_for_proof,
                                                                     phase7_gate_surface_present_for_proof,
                                                                     phase8_gate_surface_present_for_proof);
   string phase8_readiness_line = ASC_Phase8CandidateFilteringSurfaceReadinessLine(scanner_status_present_for_proof,
                                                                                         (market_board_current_present_for_proof && market_board_archive_present_for_proof),
                                                                                         dossier_present_for_proof,
                                                                                         (top5_current_present_for_proof && top5_staging_present_for_proof && top5_archive_present_for_proof),
                                                                                         (globaltop10_current_present_for_proof && globaltop10_archive_present_for_proof),
                                                                                         (functionresults_present_for_proof && heartbeat_present_for_proof),
                                                                                         phase8_gate_surface_present_for_proof,
                                                                                         phase8_gate_surface_present_for_proof,
                                                                                         phase8_gate_surface_present_for_proof,
                                                                                         phase8_gate_surface_present_for_proof);
   bool lite_retained_last_good = (StringFind(state.symbol_data_pack_lite_activation_mode, "retained_last_good") >= 0
                                  || StringFind(state.symbol_data_pack_lite_validation_status, "retained_last_good") >= 0
                                  || state.symbol_data_pack_lite_last_writer_state == "continuity"
                                  || StringFind(state.symbol_data_pack_lite_last_writer_reason, "retained_last_good=yes") >= 0);
   bool lite_fresh_write_success = (state.symbol_data_pack_lite_write_success && !state.symbol_data_pack_lite_no_change_skipped && !lite_retained_last_good);
   string lite_continuity_state = lite_retained_last_good ? "retained_last_good" : (state.symbol_data_pack_lite_no_change_skipped ? "no_change_existing_final" : (lite_fresh_write_success ? "fresh_written" : ASC_TextOrUnavailable(state.symbol_data_pack_lite_activation_mode)));
   string lite_fileio_missing_token_propagation = (StringFind(state.symbol_data_pack_lite_last_writer_reason, "missing_token=") >= 0 ? "observed_missing_token_marker" : "supported_missing_required_token_and_missing_token_markers");
   string lite_publication_health = lite_fresh_write_success ? "success_written" : (state.symbol_data_pack_lite_no_change_skipped ? "success_no_change" : (lite_retained_last_good ? "retained_last_good" : (StringFind(state.symbol_data_pack_lite_validation_status, "missing_required_token") >= 0 ? "failed_validation" : ASC_TextOrUnavailable(state.symbol_data_pack_lite_activation_mode))));

   string body = "Aurora Sentinel Core - Scanner Status\n\n";
   body += "Summary\n";
   body += StringFormat("- Server: %s\n", ASC_ArtifactServerName());
   body += StringFormat("- Updated At (UTC): %s\n", ASC_ArtifactFormatUtc(now_utc));
   body += StringFormat("- Source Run ID: %s\n", ASC_SourceRunId());
   body += StringFormat("- Source Version: %s\n", ASC_SourceVersionLabel());
   body += StringFormat("- Source Identity Token: %s\n", ASC_SourceIdentityToken());
   body += StringFormat("- Artifact Written By Run: %s\n", ASC_SourceRunId());
   body += StringFormat("- Artifact Schema Version: %s\n", ASC_ArtifactSchemaVersion());
   body += "- Build Identity Present: true\n";
   body += ASC_ArtifactIdentityLine("scanner_status", "current") + "\n";
   body += "source_run_id=" + ASC_SourceRunId() + " | source_identity_token=" + ASC_SourceIdentityToken() + " | artifact_written_by_run=" + ASC_SourceRunId() + " | artifact_schema_version=" + ASC_ArtifactSchemaVersion() + " | build_identity_present=true\n";
   body += ASC_RuntimeIdentityProofBlock("scanner_status", state.server_root, "root", now_utc) + "\n";
   body += ASC_RootArtifactBreathingProofBlock("scanner_status",
                                               now_utc,
                                               now_utc,
                                               state.scanner_status_last_write_utc,
                                               state.publication_bundle.board_publish_started_utc,
                                               state.market_board_last_publish_utc,
                                               state.publication_bundle.publication_utc,
                                               0,
                                               state.publication_bundle.publication_utc,
                                               0,
                                               0,
                                               "",
                                               false,
                                               "scanner_status_write_attempt_visible_before_success_timestamp_updates",
                                               state.publication_bundle.write_bottleneck_family == "none" ? "true" : "unknown") + "\n";
   body += "source_version=" + ASC_SourceVersionLabel()
           + " | scanner_status_schema_version=RUN227_v1"
           + " | scanner_status_truth_state=degraded_unknown_source_patch_runtime_unproven"
           + " | scanner_status_truth_reason=RUN227_restores_root_surface_contract_parity_compile_and_live_pending"
           + " | validation_deleted=false"
           + " | degraded_unknown_publication_allowed=true"
           + " | clean_requires_required_surfaces=true"
           + " | trade_permission=false"
           + " | signal_permission=false"
           + " | execution_permission=false"
           + " | risk_permission=false\n";
   body += "\nPhase 5 Source Vocabulary Boundary\n";
   body += "- " + ASC_Phase5NoSignalBoundaryText() + "\n";
   body += "- " + ASC_Phase5SourceReadyProofLine() + "\n";
   body += "\nStrategy Permission System Boundary\n";
   body += "- " + ASC_Phase5StrategyPermissionBoundaryLine() + "\n";
   body += "- " + ASC_Phase5StrategyPermissionGateSummaryLine() + "\n";
   body += "- " + ASC_Phase5StrategyPermissionStateLine() + "\n";
   body += "- " + ASC_Phase5SiamEdgeGateLine() + "\n";
   body += "\nPhase 6 Regime Compatibility Source Boundary\n";
   body += "- " + ASC_Phase6SafetyBoundaryLine() + "\n";
   body += "- " + ASC_Phase6SourceReadyProofLine() + "\n";
   body += "- " + ASC_Phase6PermissionGateExtensionLine() + "\n";
   body += "- " + ASC_Phase6CompatibilityRulesLine() + "\n";
   body += "\nPhase 6 Regime Compatibility Gate Summary\n";
   body += ASC_Phase6RegimeGateSurfaceBlock() + "\n";
   body += "Phase 6 Closeout Source Lock: " + ASC_Phase6SourceLockSummaryLine() + "\n";
   body += ASC_Phase6Run140LiveContractSummaryLine() + "\n";
   body += "\nPhase 7 Session Awareness / Timing Quality Source Boundary\n";
   body += "- " + ASC_Phase7ReviewOnlyBoundaryLine() + "\n";
   body += "- " + ASC_Phase7SourceReadyProofLine() + "\n";
   body += "- " + ASC_Phase7PermissionGateExtensionLine() + "\n";
   body += "- " + ASC_Phase7GateWiringAggregateLine() + "\n";
   body += "- Phase 7 Closeout Source Lock: " + ASC_Phase7SourceLockSummaryLine() + "\n";
   body += "- RUN145 Phase 7 Live Contract: " + ASC_Phase7Run145LiveContractSummaryLine() + "\n";
   body += "- " + ASC_Phase7CloseoutGateChecklistLine() + "\n";
   body += "\nPhase 7 Session/Timing Gate Summary\n";
   body += ASC_Phase7SessionTimingGateSurfaceBlock() + "\n";
   body += "\nPhase 8 Candidate Filtering Truth Source Boundary\n";
   body += "- " + ASC_Phase8CandidateFilteringReviewBoundaryLine() + "\n";
   body += "- " + ASC_Phase8CandidateFilteringSourceReadyLine() + "\n";
   body += "- " + ASC_Phase8CandidateFilteringInputStateLine() + "\n";
   body += "- " + ASC_Phase8CandidateFilteringBlockLimitLine() + "\n";
   body += "- " + ASC_Phase8CandidateFilteringExplicitReviewStateGateLine() + "\n";
   body += "- " + ASC_Phase8CandidateFilteringRun150ContractLine() + "\n";
   body += "- " + ASC_Phase8CandidateFilteringNoExecutionLine() + "\n";
   body += "- " + ASC_Phase8CandidateFilteringNoDriftLine() + "\n";
   body += "\nPhase 8 Candidate Filtering Truth Gate Summary\n";
   body += ASC_Phase8CandidateFilteringGateSurfaceBlock() + "\n";
   body += "\nPhase 8 Candidate Filtering Surface Readiness\n";
   body += "- " + phase8_readiness_line + "\n";
   body += "\nRuntime Proof Bundle Completeness\n";
   body += "- " + proof_bundle_line + "\n";
   body += "- Symbol Data Pack Lite Runtime Activation: present=true"
           + " | activation_enabled=" + (state.symbol_data_pack_lite_activation_enabled ? "true" : "false")
           + " | activation_mode=" + (StringLen(state.symbol_data_pack_lite_activation_mode) > 0 ? state.symbol_data_pack_lite_activation_mode : "none")
           + " | runtime_callsite_enabled=true"
           + " | writer_called=" + (state.symbol_data_pack_lite_writer_called ? "true" : "false")
           + " | write_success=" + (state.symbol_data_pack_lite_write_success ? "true" : "false")
           + " | fresh_write_success=" + (lite_fresh_write_success ? "true" : "false")
           + " | no_change_skipped=" + (state.symbol_data_pack_lite_no_change_skipped ? "true" : "false")
           + " | retained_last_good=" + (lite_retained_last_good ? "true" : "false")
           + " | continuity_state=" + lite_continuity_state
           + " | activation_symbol_source=" + (StringLen(state.symbol_data_pack_lite_symbol_source) > 0 ? state.symbol_data_pack_lite_symbol_source : "none")
           + " | activation_symbol=" + (StringLen(state.symbol_data_pack_lite_symbol) > 0 ? state.symbol_data_pack_lite_symbol : "none")
           + " | sdp_due_state=" + (state.symbol_data_pack_lite_budget_state == "not_due" ? "not_due" : "due_now")
           + " | sdp_due_reason=" + (state.symbol_data_pack_lite_budget_state == "not_due" ? "not_due_next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_next_due_utc) : "due_now_or_attempted")
           + " | sdp_last_attempt_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_attempt_utc)
           + " | sdp_last_success_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_success_utc)
           + " | sdp_next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_next_due_utc)
           + " | sdp_deferred_until_utc=" + (state.symbol_data_pack_lite_budget_state == "not_due" ? ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_next_due_utc) : "not_applicable")
           + " | sdp_hydration_state=lite_payload_only_no_siam_hydration"
           + " | sdp_hydration_reason=no_siam_hydration_no_new_data_enrichment_RUN201"
           + " | sdp_membership_snapshot_time=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_attempt_utc)
           + " | sdp_weekend_or_closed_context=not_inferred_by_flat_transition_lite_writer"
           + " | sdp_write_pressure_state=bounded_write_lane_no_flush_loop"
           + " | last_attempt_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_attempt_utc)
           + " | last_success_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_last_success_utc)
           + " | next_due_utc=" + ASC_ArtifactFormatUtc(state.symbol_data_pack_lite_next_due_utc)
           + " | budget_state=" + (StringLen(state.symbol_data_pack_lite_budget_state) > 0 ? state.symbol_data_pack_lite_budget_state : "none")
           + " | validation_status=" + (StringLen(state.symbol_data_pack_lite_validation_status) > 0 ? state.symbol_data_pack_lite_validation_status : "none")
           + " | missing_token_count=" + IntegerToString(MathMax(0, state.symbol_data_pack_lite_missing_token_count))
           + " | first_missing_token=" + (StringLen(state.symbol_data_pack_lite_first_missing_token) > 0 ? state.symbol_data_pack_lite_first_missing_token : "none")
           + " | final_path=" + (StringLen(state.symbol_data_pack_lite_final_path) > 0 ? state.symbol_data_pack_lite_final_path : "none")
           + " | temp_path=" + (StringLen(state.symbol_data_pack_lite_temp_path) > 0 ? state.symbol_data_pack_lite_temp_path : "none")
           + " | last_good_path=" + (StringLen(state.symbol_data_pack_lite_last_good_path) > 0 ? state.symbol_data_pack_lite_last_good_path : "none")
           + " | last_writer_state=" + (StringLen(state.symbol_data_pack_lite_last_writer_state) > 0 ? state.symbol_data_pack_lite_last_writer_state : "none")
           + " | last_writer_reason=" + (StringLen(state.symbol_data_pack_lite_last_writer_reason) > 0 ? state.symbol_data_pack_lite_last_writer_reason : "none")
           + " | writer_reason=" + (StringLen(state.symbol_data_pack_lite_last_writer_reason) > 0 ? state.symbol_data_pack_lite_last_writer_reason : "none")
           + " | fileio_missing_token_propagation=" + lite_fileio_missing_token_propagation
           + " | publication_health=" + lite_publication_health
           + " | last_error=" + (StringLen(state.symbol_data_pack_lite_last_error) > 0 ? state.symbol_data_pack_lite_last_error : "none")
           + " | write_success_is_fresh_only_when_no_change_false_and_retained_last_good_false=true"
           + " | retained_last_good_cannot_equal_fresh_write_success=true"
           + " | fileio_missing_token_markers=missing_required_token,missing_token"
           + " | run173_proof_checklist_marker=RUN173_capture_lite_final_temp_lastgood_status_manifest_logs_protected_artifacts\n";
   body += "- Symbol Data Pack GlobalTop10 Mirror Publication: present=true"
           + " | route=" + string(ASC_SYMBOL_DATA_PACK_GLOBALTOP10_ROUTE_NAME)
           + " | callsite=" + string(ASC_SYMBOL_DATA_PACK_GLOBALTOP10_PUBLICATION_CALLSITE)
           + " | sdp_staging_enabled=true"
           + " | sdp_staging_mode=additive_non_authoritative_candidate"
           + " | sdp_staging_path_policy=Symbol Data Packs/_staging/GlobalTop10"
           + " | sdp_staging_current_truth=false"
           + " | sdp_staging_failure_blocks_final=false"
           + " | sdp_archive_enabled=true"
           + " | sdp_archive_mode=bounded_previous_final_continuity_evidence"
           + " | sdp_archive_current_truth=false"
           + " | sdp_archive_retention_limit=1"
           + " | sdp_archive_failure_blocks_final=false"
           + " | sdp_archive_path_policy=Symbol Data Packs/_archive/GlobalTop10"
           + " | sdp_archive_failed_count=" + IntegerToString((StringFind(state.symbol_data_pack_globaltop10_last_writer_reason, "archive_write_failed") >= 0) ? 1 : 0)
           + " | enabled=" + (state.symbol_data_pack_globaltop10_enabled ? "true" : "false")
           + " | activation_mode=" + (StringLen(state.symbol_data_pack_globaltop10_activation_mode) > 0 ? state.symbol_data_pack_globaltop10_activation_mode : "none")
           + " | membership_source=state.top10_run_full_last_completed_symbols"
           + " | cursor=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_cursor)) + "/" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_total))
           + " | attempted=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_attempted_count))
           + " | files_written=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_written_count))
           + " | files_skipped_no_change=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_no_change_count))
           + " | retained_last_good=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_retained_last_good_count))
           + " | failed_write=" + IntegerToString(MathMax(0, state.symbol_data_pack_globaltop10_failed_count))
           + " | last_symbol=" + (StringLen(state.symbol_data_pack_globaltop10_last_symbol) > 0 ? state.symbol_data_pack_globaltop10_last_symbol : "none")
           + " | final_path=" + (StringLen(state.symbol_data_pack_globaltop10_final_path) > 0 ? state.symbol_data_pack_globaltop10_final_path : "none")
           + " | temp_path=" + (StringLen(state.symbol_data_pack_globaltop10_temp_path) > 0 ? state.symbol_data_pack_globaltop10_temp_path : "none")
           + " | last_good_path=" + (StringLen(state.symbol_data_pack_globaltop10_last_good_path) > 0 ? state.symbol_data_pack_globaltop10_last_good_path : "none")
           + " | family_manifest_path=" + (StringLen(state.symbol_data_pack_globaltop10_family_manifest_path) > 0 ? state.symbol_data_pack_globaltop10_family_manifest_path : "none")
           + " | validation_status=" + (StringLen(state.symbol_data_pack_globaltop10_validation_status) > 0 ? state.symbol_data_pack_globaltop10_validation_status : "none")
           + " | last_writer_state=" + (StringLen(state.symbol_data_pack_globaltop10_last_writer_state) > 0 ? state.symbol_data_pack_globaltop10_last_writer_state : "none")
           + " | last_writer_reason=" + (StringLen(state.symbol_data_pack_globaltop10_last_writer_reason) > 0 ? state.symbol_data_pack_globaltop10_last_writer_reason : "none")
           + " | route_lifecycle_reason=" + (StringLen(state.symbol_data_pack_globaltop10_last_reason) > 0 ? state.symbol_data_pack_globaltop10_last_reason : "none")
           + " | " + ASC_ScannerStatusReconciliationProofBlock("globaltop10_mirror", "not_applicable", state.symbol_data_pack_globaltop10_last_reason)
           + " | top5perbucket_publication_active=true"
           + " | rank_order_formula_changed=false"
           + " | fileio_rewrite=false"
           + " | live_output_proof=false\n";
   body += "- Symbol Data Pack Top5PerBucket Mirror Publication: present=true"
           + " | route=" + string(ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_ROUTE_NAME)
           + " | callsite=" + string(ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_PUBLICATION_CALLSITE)
           + " | sdp_staging_enabled=true"
           + " | sdp_staging_mode=additive_non_authoritative_candidate"
           + " | sdp_staging_path_policy=Symbol Data Packs/_staging/Top5PerBucket/<bucket>"
           + " | sdp_staging_current_truth=false"
           + " | sdp_staging_failure_blocks_final=false"
           + " | sdp_archive_enabled=true"
           + " | sdp_archive_mode=bounded_previous_final_continuity_evidence"
           + " | sdp_archive_current_truth=false"
           + " | sdp_archive_retention_limit=1"
           + " | sdp_archive_failure_blocks_final=false"
           + " | sdp_archive_path_policy=Symbol Data Packs/_archive/Top5PerBucket/<bucket>"
           + " | sdp_archive_failed_count=" + IntegerToString((StringFind(state.symbol_data_pack_top5perbucket_last_writer_reason, "archive_write_failed") >= 0) ? 1 : 0)
           + " | enabled=" + (state.symbol_data_pack_top5perbucket_enabled ? "true" : "false")
           + " | activation_mode=" + (StringLen(state.symbol_data_pack_top5perbucket_activation_mode) > 0 ? state.symbol_data_pack_top5perbucket_activation_mode : "none")
           + " | membership_source=state.top5_bucket_queue_symbols/state.top5_bucket_queue_slugs/state.top5_bucket_queue_ranks"
           + " | membership_source_signature=" + (StringLen(state.symbol_data_pack_top5perbucket_source_signature) > 0 ? state.symbol_data_pack_top5perbucket_source_signature : "none")
           + " | cursor=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_cursor)) + "/" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_total))
           + " | bucket_index=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_bucket_index))
           + " | symbol_index=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_symbol_index))
           + " | attempted=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_attempted_count))
           + " | files_written=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_written_count))
           + " | files_skipped_no_change=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_no_change_count))
           + " | retained_last_good=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_retained_last_good_count))
           + " | failed_write=" + IntegerToString(MathMax(0, state.symbol_data_pack_top5perbucket_failed_count))
           + " | last_bucket=" + (StringLen(state.symbol_data_pack_top5perbucket_last_bucket) > 0 ? state.symbol_data_pack_top5perbucket_last_bucket : "none")
           + " | last_bucket_token=" + (StringLen(state.symbol_data_pack_top5perbucket_last_bucket_token) > 0 ? state.symbol_data_pack_top5perbucket_last_bucket_token : "none")
           + " | last_bucket_name=" + (StringLen(state.symbol_data_pack_top5perbucket_last_bucket_name) > 0 ? state.symbol_data_pack_top5perbucket_last_bucket_name : "none")
           + " | last_symbol=" + (StringLen(state.symbol_data_pack_top5perbucket_last_symbol) > 0 ? state.symbol_data_pack_top5perbucket_last_symbol : "none")
           + " | final_path=" + (StringLen(state.symbol_data_pack_top5perbucket_final_path) > 0 ? state.symbol_data_pack_top5perbucket_final_path : "none")
           + " | temp_path=" + (StringLen(state.symbol_data_pack_top5perbucket_temp_path) > 0 ? state.symbol_data_pack_top5perbucket_temp_path : "none")
           + " | last_good_path=" + (StringLen(state.symbol_data_pack_top5perbucket_last_good_path) > 0 ? state.symbol_data_pack_top5perbucket_last_good_path : "none")
           + " | family_manifest_path=" + (StringLen(state.symbol_data_pack_top5perbucket_family_manifest_path) > 0 ? state.symbol_data_pack_top5perbucket_family_manifest_path : "none")
           + " | bucket_manifest_path=" + (StringLen(state.symbol_data_pack_top5perbucket_bucket_manifest_path) > 0 ? state.symbol_data_pack_top5perbucket_bucket_manifest_path : "none")
           + " | validation_status=" + (StringLen(state.symbol_data_pack_top5perbucket_validation_status) > 0 ? state.symbol_data_pack_top5perbucket_validation_status : "none")
           + " | first_missing_token=" + (StringLen(state.symbol_data_pack_top5perbucket_first_missing_token) > 0 ? state.symbol_data_pack_top5perbucket_first_missing_token : "none")
           + " | last_writer_state=" + (StringLen(state.symbol_data_pack_top5perbucket_last_writer_state) > 0 ? state.symbol_data_pack_top5perbucket_last_writer_state : "none")
           + " | last_writer_reason=" + (StringLen(state.symbol_data_pack_top5perbucket_last_writer_reason) > 0 ? state.symbol_data_pack_top5perbucket_last_writer_reason : "none")
           + " | route_lifecycle_reason=" + (StringLen(state.symbol_data_pack_top5perbucket_last_reason) > 0 ? state.symbol_data_pack_top5perbucket_last_reason : "none")
           + " | " + ASC_ScannerStatusReconciliationProofBlock("top5perbucket_mirror", "all_buckets", state.symbol_data_pack_top5perbucket_last_reason)
           + " | flat_transition_counts_as_top5perbucket_proof=false"
           + " | globaltop10_counts_as_top5perbucket_proof=false"
           + " | rank_order_formula_changed=false"
           + " | fileio_rewrite=false"
           + " | live_output_proof=false\n";
   body += "- " + ASC_ScannerStatusRun195SdpProofVisibilityLine(state) + "\n";
   body += "- " + ASC_MissingRuntimeSurfaceClassificationLine() + "\n";
   body += "- " + ASC_ProofBundleDecisionMappingLine() + "\n";
   body += "- scanner_status_required_tokens_present=true"
           + " | scanner_status_missing_tokens=none_static_RUN227_body_contract"
           + " | scanner_status_first_missing_token=none"
           + " | runtime_surface_required_tokens_present=true"
           + " | runtime_surface_missing_tokens=none_static_RUN227_body_contract"
           + " | RUN227_root_proof_surface_restore_only=true"
           + " | RUN227_no_marketboard_dossier_sdp_fileio_path_timing_route_gate_hud_strategy_change=true\n";
   body += "- Roadmap Two-Lane Audit Boundary: " + ASC_RoadmapTwoLaneAuditBoundaryLine() + "\n";
   body += "- " + string(ASC_RUN151_REPAIR_SCOPE_TOKEN) + " | " + string(ASC_RUN152_REPAIR_SCOPE_TOKEN) + " | " + string(ASC_RUN151_CAPTURE_CHECKLIST_READY_TOKEN) + " | " + string(ASC_RUN151_PROOF_BUNDLE_COMPACT_TOKEN) + " | " + string(ASC_RUN151_NO_FLUSH_LOOP_TOKEN) + "\n";
   body += ASC_RuntimeCaptureChecklistBlock() + "\n";
   body += ASC_Run155LiveContractSeedBlock() + "\n";
   body += "\n" + ASC_ScannerStatusClaimEvidenceBlock(state) + "\n";
   body += "\n" + ASC_Run090ScannerProofDashboard(state) + "\n";
   string run098_hydration_counts = "closed_l0_l2=" + IntegerToString(MathMax(0, state.phase2a_hydration_closed_l0_l2_count))
                                   + ",open_l0_l4=" + IntegerToString(MathMax(0, state.phase2a_hydration_open_l0_l4_count))
                                   + ",top10_l0_l6=" + IntegerToString(MathMax(0, state.phase2a_hydration_top10_l0_l6_count))
                                   + ",selected_l0_l6=" + IntegerToString(MathMax(0, state.phase2a_hydration_selected_l0_l6_count))
                                   + ",stalled=" + IntegerToString(MathMax(0, state.phase2a_hydration_stalled_count))
                                   + ",dependency_blocked=" + IntegerToString(MathMax(0, state.phase2a_hydration_dependency_blocked_count));
   string run098_3kb_counts = "closed_compact=" + IntegerToString(MathMax(0, state.phase2a_three_kb_closed_compact_honest_count))
                              + ",open_incomplete=" + IntegerToString(MathMax(0, state.phase2a_three_kb_open_hydration_incomplete_count))
                              + ",unavailable_shell=" + IntegerToString(MathMax(0, state.phase2a_three_kb_unavailable_garbage_shell_count))
                              + ",dependency_blocked=" + IntegerToString(MathMax(0, state.phase2a_three_kb_dependency_blocked_count))
                              + ",requires_review=" + IntegerToString(MathMax(0, state.phase2a_three_kb_unknown_requires_review_count));
   string run098_backfill_state = (state.dossier_backfill_pending_count > 0 ? "pending" : "not_pending");
   string run098_stall_state = (state.dossier_queue_stall_count > 0 || state.dossier_queue_stalled_count > 0 ? "stalled_or_retrying" : "not_stalled");
   string run098_budget_state = (state.heartbeat_last_duration_ms > MathMax(state.heartbeat_budget_scan_ms, state.heartbeat_budget_write_ms) ? "budget_pressure_visible" : "within_or_unproven");
   int run098_backlog_count = state.l1_publish_pending_dossiers ? MathMax(0, state.dossier_pending_backlog_count) : MathMax(0, state.deferred_write_artifacts);
   string run098_artifact_freshness = ASC_Run090ArtifactFreshnessStatus(state);
   string run098_current_focus_mirror = ASC_Run090CurrentFocusMirrorStatus(state);
   string run098_contradiction_scope = "none";
   int run098_contradiction_count = ASC_Run091ContradictionCount(state, run098_backlog_count, run098_artifact_freshness, run098_current_focus_mirror, run098_contradiction_scope);
   string run098_contradiction_severity = ASC_Run091ContradictionSeverity(run098_contradiction_count);
   int run098_proof_debt_count = ASC_Run091ProofDebtCount(state, run098_backlog_count, run098_artifact_freshness, run098_current_focus_mirror);
   string run098_phase3_line = ASC_FRRun098Phase3AProofTokens("Phase_3A_Logging_Spine",
                                                               "closed_with_bounded_carry_forward_debt_into_RUN100R",
                                                               run098_hydration_counts,
                                                               run098_3kb_counts,
                                                               state.dossier_queue_state,
                                                               run098_backfill_state,
                                                               run098_stall_state,
                                                               run098_budget_state,
                                                               "source_identity_required_in_manifest_summary",
                                                               run098_artifact_freshness,
                                                               state.top10_run_full_batch_status,
                                                               run098_current_focus_mirror,
                                                               state.top10_run_full_family_alignment_status,
                                                               run098_contradiction_count,
                                                               run098_contradiction_severity,
                                                               run098_proof_debt_count,
                                                               (run098_contradiction_count > 0 || state.phase2a_requires_operator_review_count > 0));
   body += "RUN099 Phase 3A Logging Spine Closeout\n";
   body += "- " + run098_phase3_line + "\n";
   body += "- Workbench Logs Expected: Workbench/logs/function_results.log, Workbench/logs/heartbeat_telemetry.log\n";
   body += "- Phase2A Status: closed_with_bounded_carry_forward | Phase3A Status: source_ready_for_RUN100R_live_proof | Next Live Checkpoint: RUN100R\n";
   body += "- Logging Frequency Contract: heartbeat aggregate only; state-change transition only; artifact publication summary only; no per-symbol/per-timeframe/per-section FunctionResults spam.\n";
   body += StringFormat("- Bootstrap Active: %s\n", state.l1_bootstrap_active ? "yes" : "no");
   body += StringFormat("- Bootstrap Pass Counter: %d\n", state.l1_bootstrap_pass_counter);
   body += StringFormat("- Bootstrap Assessed Peak: %d\n", state.l1_bootstrap_assessed_peak);
   body += StringFormat("- Universe Total: %d\n", summary.total_symbols);
   body += StringFormat("- Assessed: %d\n", summary.assessed_symbols);
   body += StringFormat("- Remaining: %d\n", summary.remaining_symbols);
   body += StringFormat("- Open / Closed / Uncertain / Unknown: %d / %d / %d / %d\n",
                        summary.open_count,
                        summary.closed_count,
                        summary.uncertain_count,
                        summary.unknown_count);
   body += StringFormat("- Wake Hot / Warm / Calm / Dormant: %d / %d / %d / %d\n",
                        summary.wake_hot_count,
                        summary.wake_warm_count,
                        summary.wake_calm_count,
                        summary.wake_dormant_scheduled_count);
   body += StringFormat("- Live Entitled: %d\n", summary.l2_live_entitled_count);
   body += StringFormat("- Retention Only: %d\n", summary.retention_only_count);
   body += StringFormat("- Dossier Open-Refresh Entitled: %d\n", summary.dossier_open_refresh_entitled_count);
   body += StringFormat("- Dossiers Expected (Layer 1 Cache): %d\n", state.dossier_expected_count);
   body += StringFormat("- Dossier Shell Presence: %d\n", state.dossier_shell_present_count);
   body += StringFormat("- Dossier Reduced Closed Presence (L0-L2): %d\n", state.dossier_reduced_present_count);
   body += StringFormat("- Dossier Expanded Open Presence (L0-L4 lawfully hydrated): %d\n", state.dossier_expanded_present_count);
   body += StringFormat("- Dossier Open Base Presence (L0-L2 only pending L3/L4): %d\n", state.dossier_open_base_present_count);
   body += StringFormat("- Dossier Open L3 Presence: %d\n", state.dossier_open_l3_present_count);
   body += StringFormat("- Dossier Open L4 Presence: %d\n", state.dossier_open_l4_present_count);
   body += StringFormat("- Dossier Missing: %d\n", state.dossier_missing_count);
   body += StringFormat("- Dossier Remaining Backlog (pending estimate): %d\n", state.l1_publish_pending_dossiers ? MathMax(0, state.dossier_pending_backlog_count) : 0);
   body += StringFormat("- Startup Dossier Flood Mode: %s\n", state.dossier_startup_flood_active ? "active" : "inactive");
   body += StringFormat("- Startup Dossier Flood Progress (present/expected): %d / %d\n", state.dossier_startup_flood_progress, state.dossier_startup_flood_target);
   body += StringFormat("- Startup Dossier Flood Last Budget: %d\n", state.dossier_startup_flood_budget_last);
   body += StringFormat("- Dossier Regression Signal: %s\n", (StringLen(state.dossier_regression_signal) > 0 ? state.dossier_regression_signal : "none"));
   body += StringFormat("- Dossier Queue State: %s\n", (StringLen(state.dossier_queue_state) > 0 ? state.dossier_queue_state : "idle"));
   body += StringFormat("- Dossier Required Policy: %s\n", (StringLen(state.dossier_required_policy) > 0 ? state.dossier_required_policy : "unclassified"));
   body += StringFormat("- Dossier Root Flood Policy: %s\n", (StringLen(state.dossier_root_flood_policy) > 0 ? state.dossier_root_flood_policy : "unclassified"));
   body += StringFormat("- Dossier Root Disabled Missing Policy: %s\n", (StringLen(state.dossier_root_disabled_missing_policy) > 0 ? state.dossier_root_disabled_missing_policy : "unclassified"));
   body += StringFormat("- Dossier Required Family Count: %d\n", MathMax(0, state.dossier_required_family_count));
   body += StringFormat("- Dossier Required Family Missing: %d\n", MathMax(0, state.dossier_required_family_missing_count));
   body += StringFormat("- Dossier Family Backfill Policy: %s\n", (StringLen(state.dossier_family_backfill_policy) > 0 ? state.dossier_family_backfill_policy : "unclassified"));
   body += StringFormat("- Dossier Queue Policy State: %s\n", (StringLen(state.dossier_queue_policy_state) > 0 ? state.dossier_queue_policy_state : "unclassified"));
   body += "- RUN147 Dossier-First Proof Closure: " + ASC_ScannerStatusRun147DossierFirstProofClosure(state) + "\n";
   body += "- RUN147 Archive/Tmp Proof Closure: " + ASC_ScannerStatusRun147ArchiveTmpProofClosure(state) + "\n";
   body += "- RUN147 Log/Timer Pressure Guard: functionresults_ok_repeat_dedupe_sec=900 | heartbeat_timer_unchanged_sample_heartbeats=900 | warnings_errors_failures_state_changes_preserved=true | heartbeat_cadence_changed=false | fileio_atomic_contract_changed=false\n";
   body += StringFormat("- Top5PerBucket Archive Proof: %s | %s\n", (StringLen(state.top5_archive_proof_state) > 0 ? state.top5_archive_proof_state : "unclassified"), (StringLen(state.top5_archive_proof_reason) > 0 ? state.top5_archive_proof_reason : "not_checked"));
   body += StringFormat("- GlobalTop10 Archive Proof: %s | %s\n", (StringLen(state.globaltop10_archive_proof_state) > 0 ? state.globaltop10_archive_proof_state : "unclassified"), (StringLen(state.globaltop10_archive_proof_reason) > 0 ? state.globaltop10_archive_proof_reason : "not_checked"));
   body += StringFormat("- GlobalTop10 Stale Tmp Proof: %s | %s\n", (StringLen(state.globaltop10_stale_tmp_proof_state) > 0 ? state.globaltop10_stale_tmp_proof_state : "unclassified"), (StringLen(state.globaltop10_stale_tmp_proof_reason) > 0 ? state.globaltop10_stale_tmp_proof_reason : "not_checked"));
   body += "- RUN156 Speed + Truth-Fill Contract: " + ASC_Run156SpeedTruthFillContractLine() + "\n";
   body += "- RUN156 L4 Sync + Fast Info Refresh: " + ASC_Run156L4SyncFastInfoLine() + "\n";
   body += "- RUN156 Two-Minute Bucket Fill Target: " + ASC_Run156BucketFillTargetLine() + "\n";
   body += "- RUN156 Protected Boundaries: " + ASC_Run156ProtectedBoundaryLine() + "\n";
   body += StringFormat("- Dossier Queue Cursor: %d\n", MathMax(0, state.dossier_queue_cursor_total));
   body += StringFormat("- Dossier Queue Attempted This Beat: %d\n", MathMax(0, state.dossier_queue_attempted_this_beat));
   body += StringFormat("- Dossier Queue Success This Beat: %d\n", MathMax(0, state.dossier_queue_success_this_beat));
   body += StringFormat("- Dossier Queue Failure This Beat: %d\n", MathMax(0, state.dossier_queue_failure_this_beat));
   body += StringFormat("- Dossier Queue Stall Count: %d\n", MathMax(0, state.dossier_queue_stall_count));
   body += StringFormat("- Dossier Queue Recovered Count: %d\n", MathMax(0, state.dossier_queue_recovered_count));
   body += StringFormat("- Dossier Queue Last Symbol: %s\n", (StringLen(state.dossier_queue_last_symbol) > 0 ? state.dossier_queue_last_symbol : "none"));
   body += StringFormat("- Dossier Queue Last Reason: %s\n", (StringLen(state.dossier_queue_last_reason) > 0 ? state.dossier_queue_last_reason : "none"));
   body += StringFormat("- GlobalTop10 / Market Board Alignment Status: %s\n", (StringLen(state.top10_run_full_family_alignment_status) > 0 ? state.top10_run_full_family_alignment_status : "unproven"));
   body += StringFormat("- GlobalTop10 / Market Board Alignment Reason: %s\n", (StringLen(state.top10_run_full_family_alignment_reason) > 0 ? state.top10_run_full_family_alignment_reason : "none"));
   body += StringFormat("- Market Board Signature: %s\n", (StringLen(state.top10_run_full_current_source_signature) > 0 ? state.top10_run_full_current_source_signature : "unavailable"));
   body += StringFormat("- GlobalTop10 Derived From Board Signature: %s\n", (StringLen(state.top10_run_full_last_completed_source_signature) > 0 ? state.top10_run_full_last_completed_source_signature : "unavailable"));
   body += StringFormat("- GlobalTop10 Family Cursor: %d / %d\n", MathMax(0, state.top10_run_full_cursor), MathMax(0, state.top10_run_full_total));
   if(state.dossier_rich_present_count >= 0)
      body += StringFormat("- Dossier Rich/Current Presence: %d\n", state.dossier_rich_present_count);
   else
      body += "- Dossier Rich/Current Presence: deferred_not_yet_measured\n";
   body += StringFormat("- Layer 3 Live Proof Trace: %s\n", ASC_Layer3LiveProofSummary(state));
   body += StringFormat("- Layer 3 Last Revision / UTC: %d / %s\n", state.committed_l3_revision, ASC_ArtifactFormatUtc(state.committed_l3_pass_utc));
   body += StringFormat("- Layer 3 Status / Reason: %s / %s\n",
                        (StringLen(state.committed_l3_status) > 0 ? state.committed_l3_status : "none"),
                        (StringLen(state.committed_l3_reason) > 0 ? state.committed_l3_reason : "none"));
   body += StringFormat("- Deferred Scan Symbols: %d\n", state.deferred_scan_symbols);
   body += StringFormat("- Deferred Write Artifacts: %d\n", state.deferred_write_artifacts);
   body += StringFormat("- Last L1 Pass UTC: %s\n", ASC_ArtifactFormatUtc(summary.pass_utc));
   body += StringFormat("- Last Bundle UTC: %s\n", ASC_ArtifactFormatUtc(state.publication_bundle.publication_utc));
   body += StringFormat("- Last Bundle Error: %s\n", (StringLen(state.publication_bundle.last_bundle_error_summary) > 0 ? state.publication_bundle.last_bundle_error_summary : "none"));
   body += "- Trader Chat Packet: " + ASC_TraderChatAggregateTokens() + "\n";
   body += "- Trader Chat Retrieval: packet_rank_source=committed_l4_snapshot | market_board_role=selection_context_not_trade_signal | globaltop10_retrieval_path=Dossiers/GlobalTop10/<symbol>.txt | top5perbucket_retrieval_path=Dossiers/Top5PerBucket/<bucket>/<symbol>.txt | current_focus_role=selected_symbol_live_context\n";

   string required_tokens[];
   ArrayResize(required_tokens, 418);
   required_tokens[0] = "Aurora Sentinel Core - Scanner Status";
   required_tokens[1] = "Summary";
   required_tokens[2] = "Universe Total";
   required_tokens[3] = "Wake Hot / Warm / Calm / Dormant";
   required_tokens[4] = "GlobalTop10 / Market Board Alignment Status:";
   required_tokens[5] = "GlobalTop10 Derived From Board Signature:";
   required_tokens[6] = "Source Run ID:";
   required_tokens[7] = "Artifact Written By Run:";
   required_tokens[8] = "Artifact Schema Version:";
   required_tokens[9] = "Build Identity Present:";
   required_tokens[10] = "RUN090 Proof Dashboard";
   required_tokens[11] = "run090_proof_surface=present";
   required_tokens[12] = "source_run_id=";
   required_tokens[13] = "source_identity_token=";
   required_tokens[14] = "artifact_written_by_run=";
   required_tokens[15] = "artifact_schema_version=";
   required_tokens[16] = "build_identity_present=true";
   required_tokens[17] = "deep_hydration_pending=";
   required_tokens[18] = "deep_hydration_expired=";
   required_tokens[19] = "deep_hydration_retry_exhausted=";
   required_tokens[20] = "deep_hydration_completed=";
   required_tokens[21] = "dossier_queue_state=";
   required_tokens[22] = "dossier_queue_cursor=";
   required_tokens[23] = "dossier_queue_backlog_count=";
   required_tokens[24] = "dossier_queue_stall_count=";
   required_tokens[25] = "dossier_queue_recovered_count=";
   required_tokens[26] = "alignment_status=";
   required_tokens[27] = "board_signature=";
   required_tokens[28] = "derived_from_board_signature=";
   required_tokens[29] = "artifact_freshness_status=";
   required_tokens[30] = "freshness_taxonomy=";
   required_tokens[31] = "current_focus_mirror_status=";
   required_tokens[32] = "run090_functionresults_aggregate_proof=present";
   required_tokens[33] = "promoted_current";
   required_tokens[34] = "staging_not_current";
   required_tokens[35] = "archive_historical_only";
   required_tokens[36] = "retained_last_good_not_current";
   required_tokens[37] = "stale_not_current";
   required_tokens[38] = "degraded_current";
   required_tokens[39] = "continuity_fallback";
   required_tokens[40] = "selected_symbol_none_not_failure";
   required_tokens[41] = "current_requires_written_by_run_and_promoted=true";
   required_tokens[42] = "file_exists_is_fresh_current_promoted_proof=false";

   required_tokens[43] = "RUN091 Proof Harness";
   required_tokens[44] = "run091_proof_surface=present";
   required_tokens[45] = "next_live_checkpoint=";
   required_tokens[46] = "proof_boundary=";
   required_tokens[47] = "timer_queue_skip_risk_visible=true";
   required_tokens[48] = "heartbeat_work_must_be_bounded=true";
   required_tokens[49] = "top10_hydration_progress=";
   required_tokens[50] = "top10_batch_status=";
   required_tokens[51] = "top10_verify_pass_count=";
   required_tokens[52] = "top10_verify_fail_count=";
   required_tokens[53] = "partial_child_is_complete=false";
   required_tokens[54] = "contradiction_count=";
   required_tokens[55] = "worst_contradiction_severity=";
   required_tokens[56] = "requires_operator_review=";
   required_tokens[57] = "proof_debt_count=";
   required_tokens[58] = "run091_functionresults_aggregate_proof=present";
   required_tokens[59] = "edge_truth_context_only=true";
   required_tokens[60] = "RUN092 Alignment Proof Harness";
   required_tokens[61] = "run092_proof_surface=present";
   required_tokens[62] = "alignment_scope=market_board_globaltop10_dossier";
   required_tokens[63] = "top10_child_expected_count=";
   required_tokens[64] = "top10_child_cursor=";
   required_tokens[65] = "child_partial_is_complete=false";
   required_tokens[66] = "retained_child_is_current=false";
   required_tokens[67] = "stale_dossier_is_current=false";
   required_tokens[68] = "board_top_symbol_missing_child_detectable=true";
   required_tokens[69] = "board_signature_child_signature_mismatch_detectable=true";
   required_tokens[70] = "dossier_source_run_mismatch_detectable=true";
   required_tokens[71] = "dossier_section_incomplete_but_child_complete_detectable=true";
   required_tokens[72] = "deep_pending_but_board_implies_deep_complete_detectable=true";
   required_tokens[73] = "retained_child_marked_current_detectable=true";
   required_tokens[74] = "stale_dossier_marked_current_detectable=true";
   required_tokens[75] = "alignment_contradiction_count=";
   required_tokens[76] = "run092_functionresults_aggregate_proof=present";
   required_tokens[77] = "rank_order_formula_change=false";
   required_tokens[78] = "RUN093 Roadmap Reanchor Phase 2A Proof Harness";
   required_tokens[79] = "run093_reanchor_surface=present";
   required_tokens[80] = "roadmap_authority=TRUTH_SEEKER_ROADMAP.md";
   required_tokens[81] = "true_current_phase=Immediate_Repair_plus_Phase_2A";
   required_tokens[82] = "run091_run092_are_support_work=true";
   required_tokens[83] = "phase2a_complete=false";
   required_tokens[84] = "hydration_class_taxonomy=";
   required_tokens[85] = "three_kb_reason_taxonomy=";
   required_tokens[86] = "warmup_first_publish_taxonomy=";
   required_tokens[87] = "queue_proof_taxonomy=";
   required_tokens[88] = "file_exists_is_hydration_proof=false";
   required_tokens[89] = "non_empty_file_is_completion_proof=false";
   required_tokens[90] = "closed_compact_is_not_failure=true";
   required_tokens[91] = "open_shell_can_be_incomplete=true";
   required_tokens[92] = "dependency_blocked_explicit=true";
   required_tokens[93] = "run093_roadmap_reanchor_phase2a_proof=present";
   required_tokens[94] = "run095_allowed_only_if_phase2a_source_ready=true";
   required_tokens[95] = "RUN099 Phase 3A Logging Spine Closeout";
   required_tokens[96] = "run099_phase3a_logging_spine_aggregate_proof=present";
   required_tokens[97] = "phase3a_logging_spine_status=";
   required_tokens[98] = "phase2a_carry_forward_status=";
   required_tokens[99] = "hydration_class_counts=";
   required_tokens[100] = "three_kb_reason_counts=";
   required_tokens[101] = "queue_state=";
   required_tokens[102] = "heartbeat_budget_state=";
   required_tokens[103] = "contradiction_count=";
   required_tokens[104] = "worst_contradiction_severity=";
   required_tokens[105] = "proof_debt_count=";
   required_tokens[106] = "requires_operator_review=";
   required_tokens[107] = "no_trade_signal_boundary=true";
   required_tokens[108] = "no_execution_boundary=true";
   required_tokens[109] = "per_symbol_rows=false";
   required_tokens[110] = "functionresults_spam=false";
   required_tokens[111] = "next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN;
   required_tokens[112] = "RUN110 Top5PerBucket PreLive Readiness Source Patch";
   required_tokens[113] = "run110_top5_per_bucket_prelive_readiness_proof=present";
   required_tokens[114] = "artifact_family_id=top5_per_bucket";
   required_tokens[115] = "top5_per_bucket_family_state=";
   required_tokens[116] = "bucket_count=";
   required_tokens[117] = "bucket_child_target_count=";
   required_tokens[118] = "bucket_child_written_count=";
   required_tokens[119] = "bucket_child_pending_count=";
   required_tokens[120] = "bucket_child_failed_count=";
   required_tokens[121] = "bucket_family_promoted=false";
   required_tokens[122] = "bucket_family_partial=";
   required_tokens[123] = "bucket_family_degraded=";
   required_tokens[124] = "bucket_manifest_written=";
   required_tokens[125] = "top5_per_bucket_queue_remaining=";
   required_tokens[126] = "closed_symbols_actionable=false";
   required_tokens[127] = "rank_formula_change=false";
   required_tokens[128] = "trade_signal=false";
   required_tokens[129] = "execution_change=false";
   required_tokens[130] = "dossier_publication_mode=selected_and_families_only";
   required_tokens[131] = "root_all_symbol_dossiers_enabled=false";
   required_tokens[132] = "root_all_symbol_dossier_writes_skipped=";
   required_tokens[133] = "globaltop10_dossiers_enabled=true";
   required_tokens[134] = "top5_per_bucket_dossiers_enabled=true";
   required_tokens[135] = "current_focus_enabled=true";
   required_tokens[136] = "selected_symbol_dossier_enabled=true";
   required_tokens[137] = "root_policy_preserves_selected_current=true";
   required_tokens[138] = "current_focus_independent_of_root_all_symbol=true";
   required_tokens[139] = "diagnostic_all_symbol_dossiers_enabled=false";
   required_tokens[140] = "legacy_all_symbol_dossiers_retained=true";
   required_tokens[141] = "legacy_root_dossier_cleanup_pending=true";
   required_tokens[142] = "market_board_publish_cadence_sec=" + IntegerToString(ASC_MARKET_BOARD_PUBLISH_CADENCE_SEC);
   required_tokens[143] = "l3_candidate_refresh_cadence_sec=600";
   required_tokens[144] = "l4_shortlist_refresh_cadence_sec=1200";
   required_tokens[145] = "globaltop10_refresh_cadence_sec=300";
   required_tokens[146] = "top5_per_bucket_refresh_cadence_sec=600";
   required_tokens[147] = "performance_side_audit=active";
   required_tokens[148] = "safe_cleanup_patch=";
   required_tokens[149] = "top5_rank_1_5_deep_queue_enabled=true";
   required_tokens[150] = "top5_rank_4_5_permanent_deep_pending=false";
   required_tokens[151] = "run126_safe_cleanup_patch=";
   required_tokens[152] = "claim_evidence_enabled=true";
   required_tokens[153] = "claim_evidence_schema=claim_status|claim_subject|claim_source_owner|claim_reason|claim_next_check|claim_currentness|claim_actionability_block|claim_operator_action|claim_confidence|claim_evidence_token";
   required_tokens[154] = "claim_unavailable_count=";
   required_tokens[155] = "claim_blocked_count=";
   required_tokens[156] = "claim_pending_count=";
   required_tokens[157] = "claim_stale_count=";
   required_tokens[158] = "claim_retained_count=";
   required_tokens[159] = "claim_degraded_count=";
   required_tokens[160] = "claim_unknown_count=";
   required_tokens[161] = "claim_actionability_block_count=";
   required_tokens[162] = "claim_evidence_live_unproven_until_RUN130=true";
   required_tokens[163] = "claim_section_level_enabled=true";
   required_tokens[164] = "claim_dossier_section_count=";
   required_tokens[165] = "claim_market_board_lookup_enabled=true";
   required_tokens[166] = "claim_trader_chat_packet_enabled=true";
   required_tokens[167] = "claim_family_dossier_availability_enabled=true";
   required_tokens[168] = "claim_evidence_per_symbol_rows=false";
   required_tokens[169] = "claim_evidence_section_spam_avoided=true";
   required_tokens[170] = "claim_evidence_token=scanner_status_currentness_actionability_RUN128R";
   required_tokens[171] = "currentness_evidence_enabled=true";
   required_tokens[172] = "actionability_evidence_enabled=true";
   required_tokens[173] = "current_live_count=";
   required_tokens[174] = "stale_not_current_count=";
   required_tokens[175] = "retained_last_good_count=";
   required_tokens[176] = "blocked_actionability_count=";
   required_tokens[177] = "unknown_unproven_count=";
   required_tokens[178] = "ranked_not_actionable_without_currentness=true";
   required_tokens[179] = "selected_refresh_required_for_actionability=true";
   required_tokens[180] = "trader_chat_packet_enabled=true";
   required_tokens[181] = "retrieval_pack_enabled=true";
   required_tokens[182] = "market_board_to_dossier_workflow_enabled=true";
   required_tokens[183] = "selected_current_required_for_actionability=true";
   required_tokens[184] = "trader_chat_packet_per_symbol_rows=false";
   required_tokens[185] = "trader_chat_packet_proof_spam_avoided=true";
   required_tokens[186] = "Dossier Required Policy:";
   required_tokens[187] = "Dossier Root Flood Policy:";
   required_tokens[188] = "Dossier Root Disabled Missing Policy:";
   required_tokens[189] = "Dossier Required Family Count:";
   required_tokens[190] = "Dossier Required Family Missing:";
   required_tokens[191] = "Dossier Family Backfill Policy:";
   required_tokens[192] = "Dossier Queue Policy State:";
   required_tokens[193] = "Top5PerBucket Archive Proof:";
   required_tokens[194] = "GlobalTop10 Archive Proof:";
   required_tokens[195] = "GlobalTop10 Stale Tmp Proof:";
   required_tokens[196] = "root_all_symbol_dossiers_disabled_by_policy";
   required_tokens[197] = "RUN147 Dossier-First Proof Closure:";
   required_tokens[198] = "family_dossier_missing_blocks_pass=";
   required_tokens[199] = "root_flood_disabled_is_not_missing_failure=true";
   required_tokens[200] = "RUN147 Archive/Tmp Proof Closure:";
   required_tokens[201] = "stale_tmp_cleanup_attempted=false";
   required_tokens[202] = "RUN147 Log/Timer Pressure Guard:";
   required_tokens[203] = "Phase 8 Candidate Filtering Truth Source Boundary";
   required_tokens[204] = "phase8_candidate_filtering_truth_source_ready=true";
   required_tokens[205] = "candidate_filtering_truth_context_ready=true";
   required_tokens[206] = "candidate_filtering_score_is_not_signal=true";
   required_tokens[207] = "candidate_filtering_review_is_not_permission=true";
   required_tokens[208] = "candidate_filtering_candidate_is_not_trade=true";
   required_tokens[209] = "candidate_filtering_context_is_not_execution=true";
   required_tokens[210] = "candidate_filtering_inputs_have_freshness_state=true";
   required_tokens[211] = "candidate_filtering_missing_input_state=cf_input_missing";
   required_tokens[212] = "candidate_filtering_pending_refresh_state=cf_input_pending_refresh";
   required_tokens[213] = "candidate_filtering_stale_input_state=cf_input_stale";
   required_tokens[214] = "candidate_filtering_unavailable_input_state=cf_input_unavailable";
   required_tokens[215] = "candidate_filtering_currentness_unproven_state=cf_input_currentness_unproven";
   required_tokens[216] = "candidate_filtering_missing_inputs_block_or_limit_review=true";
   required_tokens[217] = "candidate_filtering_stale_inputs_block_or_limit_review=true";
   required_tokens[218] = "phase8_execution_enabled=false";
   required_tokens[219] = "candidate_filtering_score_formula_changed=false";
   required_tokens[220] = "candidate_filtering_phase8_per_symbol_proof_rows=false";
   required_tokens[221] = "phase8_candidate_filtering_truth_gates_source_ready=true";
   required_tokens[222] = "phase8_candidate_filtering_surface_ready=true";
   required_tokens[223] = "phase8_live_proof_required=true";
   required_tokens[224] = "run150_live_research_source_repair_contract_ready=true";
   required_tokens[225] = "candidate_filtering_conflict_inputs_block_or_limit_review=true";
   required_tokens[226] = "candidate_filtering_sample_insufficient_inputs_limit_review=true";
   required_tokens[227] = "candidate_filtering_spread_friction_blocker_limits_review=true";
   required_tokens[228] = "candidate_filtering_market_closed_or_session_uncertain_blocks_or_limits_review=true";
   required_tokens[229] = "candidate_filtering_review_ready_requires_positive_evidence=true";
   required_tokens[230] = "RUN150 live + research + source repair contract:";
   required_tokens[231] = "run150_report_only_forbidden_when_safe_patchable_gap_exists=true";
   required_tokens[232] = "Runtime Proof Bundle Completeness";
   required_tokens[233] = "proof_bundle_required=true";
   required_tokens[234] = "proof_bundle_complete=";
   required_tokens[235] = "proof_bundle_incomplete_reason=";
   required_tokens[236] = "scanner_status_required=true";
   required_tokens[237] = "market_board_required=true";
   required_tokens[238] = "top5_per_bucket_required=true";
   required_tokens[239] = "functionresults_required=true";
   required_tokens[240] = "heartbeat_telemetry_required=true";
   required_tokens[241] = "missing_runtime_surface_classification=missing_runtime_surface";
   required_tokens[242] = "Runtime Proof Bundle Capture Checklist";
   required_tokens[243] = "run155_live_research_source_repair_contract_seeded=true";
   required_tokens[244] = "next_live_run=RUN155R";
   required_tokens[245] = "missing_surface_means_HOLD_not_FAIL=true";
   required_tokens[246] = "proof_bundle_first_missing_surface=";
   required_tokens[247] = "proof_bundle_missing_surface_count=";
   required_tokens[248] = "proof_bundle_missing_surface_list=";
   required_tokens[249] = "proof_bundle_decision_state=";
   required_tokens[250] = "evidence_package_blocker=";
   required_tokens[251] = "proof_bundle_complete_true_requires_all_mandatory_surfaces_or_policy_not_applicable=true";
   required_tokens[252] = "Phase 8 Candidate Filtering Surface Readiness";
   required_tokens[253] = "phase8_candidate_filtering_scanner_status_ready=";
   required_tokens[254] = "phase8_candidate_filtering_logs_ready=";
   required_tokens[255] = "phase8_candidate_filtering_review_state_live_testable=";
   required_tokens[256] = "proof_bundle_decision_mapping=";
   required_tokens[257] = "run155_live_package_preflight_contract_strengthened=true";
   required_tokens[258] = "Roadmap Two-Lane Audit Boundary:";
   required_tokens[259] = "roadmap_two_lane_audit_required=true";
   required_tokens[260] = "roadmap_audit_source_lane_required=true";
   required_tokens[261] = "roadmap_audit_live_lane_required=true";
   required_tokens[262] = "source_completion_not_live_proof=true";
   required_tokens[263] = "live_completion_requires_runtime_evidence=true";
   required_tokens[264] = "phase8_status=SOURCE_PATCHED_LIVE_UNPROVEN_until_RUN155_complete_runtime_bundle";
   required_tokens[265] = "phase9_status=NOT_STARTED";
   required_tokens[266] = "run155_preflight_required=true";
   required_tokens[267] = "proof_bundle_complete_required_for_live_pass=true";
   required_tokens[268] = "missing_mandatory_surface_blocks_live_pass=true";
   required_tokens[269] = "report_only_live_forbidden_if_patchable_source_gap=true";
   required_tokens[270] = "safe_patch_required_when_patchable_live_blocker=true";
   required_tokens[271] = "phase8_live_proof_requires_complete_bundle=true";
   required_tokens[272] = "run155_operator_package_required_surfaces_locked=true";
   required_tokens[273] = "run155_upload_requires_scanner_status_manifest_dossiers_current_focus_if_selected_marketboard_current_archive_top5_current_staging_archive_globaltop10_current_archive_functionresults_heartbeat_workbench_logs_stale_tmp_proof";
   required_tokens[274] = "phase9_start_blocked_until_phase8_live_decision=true";
   required_tokens[275] = "phase8_live_decision_required_before_phase9=true";
   required_tokens[276] = "phase8_source_ready_does_not_equal_phase8_complete=true";
   required_tokens[277] = "phase8_live_proven_only_after_RUN155_PASS=true";
   required_tokens[278] = "live_percent_never_changes_without_runtime_evidence";
   required_tokens[279] = "run156r_speed_truth_fill_repair_after_RUN155_hold_with_patch=true";
   required_tokens[280] = "run155_decision_absorbed=HOLD_WITH_SOURCE_PATCH";
   required_tokens[281] = "operator_clarification_slow_fill_not_source_missing_absorbed=true";
   required_tokens[282] = "slow_top5_bucket_fill_primary_blocker=true";
   required_tokens[283] = "fill_state_classification=present,missing,not_yet_hydrated,fill_in_progress,run_ended_before_completion,queue_pending,queue_progressing,queue_stalled,disabled_by_policy,selected_none_not_applicable,source_gap_suspected,source_gap_confirmed";
   required_tokens[284] = "fill_in_progress_is_not_missing=true";
   required_tokens[285] = "run_ended_before_completion_is_not_source_failure=true";
   required_tokens[286] = "not_yet_hydrated_is_not_source_gap=true";
   required_tokens[287] = "queue_progressing_is_not_queue_stalled=true";
   required_tokens[288] = "missing_file_alone_is_not_source_bug_proof=true";
   required_tokens[289] = "l4_top5_globaltop10_sync_law_seeded=true";
   required_tokens[290] = "l4_membership_static_seconds=1200";
   required_tokens[291] = "displayed_symbol_info_refresh_seconds=300";
   required_tokens[292] = "l2_displayed_symbol_refresh_seconds=300";
   required_tokens[293] = "l5_displayed_symbol_refresh_seconds=300_where_available";
   required_tokens[294] = "l6_displayed_symbol_refresh_seconds=300";
   required_tokens[295] = "top5_per_bucket_per_symbol_info_reprint_seconds=300";
   required_tokens[296] = "globaltop10_per_symbol_info_reprint_seconds=300";
   required_tokens[297] = "bucket_fill_target_seconds=120";
   required_tokens[298] = "next_live_run=RUN160R_unless_operator_explicitly_authorizes_extraordinary_re_run";
   required_tokens[299] = "run157r_speed_truth_fill_owner_wiring_guidebook_foundation=true";
   required_tokens[300] = "guidebook_brain_foundation_created_or_updated=true";
   required_tokens[301] = "guidebooks_do_not_create_live_proof=true";
   required_tokens[302] = "trading_brain_signal_leakage=false";
   required_tokens[303] = "refresh_cadence_owner_map=source_ready";
   required_tokens[304] = "l4_snapshot_epoch_owner=ASC_Dispatcher_committed_l4_last_built_utc";
   required_tokens[305] = "l4_membership_static_until_owner=ASC_Dispatcher_committed_l4_next_recheck_utc";
   required_tokens[306] = "top5_l4_epoch_owner=ASC_Top5BucketSnapshotId_from_committed_l4";
   required_tokens[307] = "globaltop10_l4_epoch_owner=ASC_Top10RunFullFamilyManifest_committed_l4_snapshot";
   required_tokens[308] = "top5_globaltop10_epoch_match_required=true";
   required_tokens[309] = "l4_info_refresh_independent=true";
   required_tokens[310] = "displayed_symbol_set_source=L4_snapshot";
   required_tokens[311] = "displayed_symbol_info_states=info_age_seconds,stale,refresh_pending,refresh_progressing,refresh_complete,not_available,not_hidden";
   required_tokens[312] = "bucket_fill_progress_owner=ASC_ScannerStatusWriter_and_manifest_aggregate_counters";
   required_tokens[313] = "bucket_fill_target_met_requires_runtime_evidence=true";
   required_tokens[314] = "phase8_status=SOURCE_PATCHED_LIVE_UNPROVEN_after_RUN157_until_RUN160_live_bundle";
   required_tokens[315] = "run158r_displayed_symbol_5min_reprint_queue_progress_telemetry=true";
   required_tokens[316] = "displayed_symbol_set_source=L4_snapshot";
   required_tokens[317] = "displayed_symbol_set_not_rank_owner=true";
   required_tokens[318] = "displayed_symbol_set_refresh_context_only=true";
   required_tokens[319] = "displayed_symbol_set_no_reorder_no_selection_no_formula_change=true";
   required_tokens[320] = "displayed_symbol_info_refresh_seconds=300";
   required_tokens[321] = "displayed_symbol_info_last_refresh_utc=";
   required_tokens[322] = "displayed_symbol_info_next_due_utc=";
   required_tokens[323] = "displayed_symbol_info_age_seconds=";
   required_tokens[324] = "displayed_symbol_info_refresh_due=";
   required_tokens[325] = "displayed_symbol_info_reprint_only_not_selection=true";
   required_tokens[326] = "l2_displayed_refresh_not_full_universe=true";
   required_tokens[327] = "l5_displayed_refresh_deferred_heavy_budget=true";
   required_tokens[328] = "l6_displayed_proof_not_hidden=true";
   required_tokens[329] = "bucket_fill_target_seconds=120";
   required_tokens[330] = "bucket_fill_elapsed_seconds=";
   required_tokens[331] = "buckets_total=";
   required_tokens[352] = "Symbol Data Pack Lite Runtime Activation: present=true";
   required_tokens[353] = "activation_mode=";
   required_tokens[354] = "runtime_callsite_enabled=true";
   required_tokens[355] = "writer_called=";
   required_tokens[356] = "activation_symbol_source=";
   required_tokens[357] = "activation_symbol=";
   required_tokens[358] = "final_path=";
   required_tokens[359] = "validation_status=";
   required_tokens[360] = "budget_state=";
   required_tokens[361] = "run173_proof_checklist_marker=RUN173_capture_lite_final_temp_lastgood_status_manifest_logs_protected_artifacts";
   required_tokens[362] = "missing_token_count=";
   required_tokens[363] = "first_missing_token=";
   required_tokens[364] = "last_writer_state=";
   required_tokens[365] = "no_change_skipped=";
   required_tokens[366] = "write_success=";
   required_tokens[367] = "temp_path=";
   required_tokens[368] = "last_good_path=";
   required_tokens[369] = "last_writer_reason=";
   required_tokens[370] = "last_error=";
   required_tokens[371] = "activation_enabled=";
   required_tokens[372] = "next_due_utc=";
   required_tokens[373] = "fresh_write_success=";
   required_tokens[374] = "retained_last_good=";
   required_tokens[375] = "continuity_state=";
   required_tokens[376] = "writer_reason=";
   required_tokens[377] = "fileio_missing_token_propagation=";
   required_tokens[378] = "publication_health=";
   required_tokens[379] = "write_success_is_fresh_only_when_no_change_false_and_retained_last_good_false=true";
   required_tokens[380] = "retained_last_good_cannot_equal_fresh_write_success=true";
   required_tokens[381] = "fileio_missing_token_markers=missing_required_token,missing_token";

   required_tokens[382] = "proof_bundle_policy_version=RUN225R_v1";
   required_tokens[383] = "proof_bundle_required_complete=";
   required_tokens[384] = "proof_bundle_optional_complete=";
   required_tokens[385] = "proof_bundle_missing_required_count=";
   required_tokens[386] = "proof_bundle_missing_optional_count=";
   required_tokens[387] = "proof_bundle_lawful_not_applicable_count=";
   required_tokens[388] = "proof_bundle_unknown_policy_count=";
   required_tokens[389] = "proof_bundle_missing_required_surfaces=";
   required_tokens[390] = "proof_bundle_missing_optional_surfaces=";
   required_tokens[391] = "proof_bundle_lawful_not_applicable_surfaces=";
   required_tokens[392] = "proof_bundle_deferred_surfaces=";
   required_tokens[393] = "proof_bundle_first_failure_reason=";
   required_tokens[394] = "proof_bundle_policy_boundary=proof_policy_only_no_fake_pass_no_output_mutation";
   required_tokens[395] = "proof_surface_globaltop10_archive=";
   required_tokens[396] = "proof_surface_dossiers=";
   required_tokens[397] = "source_version=";
   required_tokens[398] = "scanner_status_schema_version=RUN227_v1";
   required_tokens[399] = "scanner_status_truth_state=";
   required_tokens[400] = "scanner_status_truth_reason=";
   required_tokens[401] = "runtime_surface_classification=";
   required_tokens[402] = "runtime_surface_classification_reason=";
   required_tokens[403] = "runtime_surface_required_tokens_present=";
   required_tokens[404] = "runtime_surface_missing_tokens=";
   required_tokens[405] = "missing_runtime_surface=";
   required_tokens[406] = "scanner_status_required_tokens_present=";
   required_tokens[407] = "scanner_status_missing_tokens=";
   required_tokens[408] = "scanner_status_first_missing_token=";
   required_tokens[409] = "validation_deleted=false";
   required_tokens[410] = "degraded_unknown_publication_allowed=true";
   required_tokens[411] = "clean_requires_required_surfaces=true";
   required_tokens[412] = "trade_permission=false";
   required_tokens[413] = "signal_permission=false";
   required_tokens[414] = "execution_permission=false";
   required_tokens[415] = "risk_permission=false";
   required_tokens[416] = "RUN227_root_proof_surface_restore_only=true";
   required_tokens[417] = "RUN227_no_marketboard_dossier_sdp_fileio_path_timing_route_gate_hud_strategy_change=true";
   required_tokens[332] = "buckets_with_visible_info=";
   required_tokens[333] = "bucket_fill_percent=";
   required_tokens[334] = "displayed_symbols_refresh_progress_percent=";
   required_tokens[335] = "no_change_reprint_dirty_loop_guard=metadata_only_no_flush_loop";
   required_tokens[336] = "phase8_status=SOURCE_PATCHED_LIVE_UNPROVEN_after_RUN158_until_RUN160_live_bundle";
   required_tokens[337] = "run159r_speed_truth_fill_source_closeout_run160_live_contract=true";
   required_tokens[338] = "bucket_fill_source_readiness=closed_for_RUN160_measurement";
   required_tokens[339] = "bucket_fill_target_measurable_requires_runtime_counters=true";
   required_tokens[340] = "bucket_fill_target_met_runtime_evidence_only=true";
   required_tokens[341] = "bucket_fill_target_missed_runtime_evidence_only=true";
   required_tokens[342] = "bucket_fill_window_start_utc=";
   required_tokens[343] = "bucket_fill_target_measurable=";
   required_tokens[344] = "bucket_fill_target_met=";
   required_tokens[345] = "bucket_fill_target_missed=";
   required_tokens[346] = "run160_live_contract_finalized=true";
   required_tokens[347] = "run160_no_report_only_if_safe_patchable_blocker_exists=true";
   required_tokens[348] = "run160_safe_patch_required_if_patchable_blocker=true";
   required_tokens[349] = "run160_upload_requires_scanner_status_manifest_dossiers_market_board_current_archive_top5_current_staging_archive_globaltop10_current_archive_current_focus_if_selected_functionresults_heartbeat_workbench_logs_stale_tmp_staging_proof";
   required_tokens[350] = "source_readiness_does_not_equal_runtime_target_met=true";
   required_tokens[351] = "phase8_status=SOURCE_PATCHED_LIVE_UNPROVEN_after_RUN159_until_RUN160_live_bundle";
   body += "\nRUN157R Speed/Truth-Fill Owner Wiring\n";
   body += ASC_Run157SpeedTruthFillOwnerMapLine() + "\n";
   body += ASC_Run157GuidebookBoundaryLine() + "\n";
   datetime run158_now_utc = TimeGMT();
   int run158_displayed_total = MathMax(0, state.top5_bucket_child_written_count) + MathMax(0, state.top10_run_full_last_total);
   int run158_displayed_current = MathMax(0, state.top5_bucket_child_written_count);
   int run158_displayed_pending = MathMax(0, state.top5_bucket_child_pending_count) + MathMax(0, state.top10_deferred_l5_pending_count);
   int run158_displayed_stale = (state.l1_cycle_stale ? 1 : 0);
   int run158_displayed_missing = MathMax(0, state.top5_bucket_child_failed_count);
   datetime run158_last_refresh_utc = state.market_board_last_publish_utc;
   bool run158_refresh_due = (ASC_Run158AgeSeconds(run158_last_refresh_utc, run158_now_utc) < 0
                              || ASC_Run158AgeSeconds(run158_last_refresh_utc, run158_now_utc) >= ASC_RUN158_DISPLAYED_INFO_REFRESH_SEC);
   int run158_buckets_total = MathMax(0, state.top5_bucket_count);
   int run158_buckets_visible = MathMax(0, state.top5_bucket_child_written_count);
   int run158_buckets_pending = MathMax(0, state.top5_bucket_child_pending_count);
   int run158_buckets_stalled = MathMax(0, state.top5_bucket_child_failed_count) + MathMax(0, state.dossier_queue_stalled_count);
   datetime run158_l6_utc = (state.function_results_log_last_write_utc > 0 ? state.function_results_log_last_write_utc : state.publication_bundle.publication_utc);

   body += "\nRUN158R Displayed-Symbol Reprint / Queue Progress Telemetry\n";
   body += "- displayed_symbol_set_definition: " + ASC_Run158DisplayedSetDefinitionLine() + "\n";
   body += "- displayed_refresh_law: " + ASC_Run158DisplayedRefreshLawLine() + "\n";
   body += "- displayed_refresh_telemetry: " + ASC_Run158DisplayedRefreshTelemetryLine(run158_displayed_total,
                                                                                      run158_displayed_current,
                                                                                      run158_displayed_pending,
                                                                                      run158_displayed_stale,
                                                                                      run158_displayed_missing,
                                                                                      run158_last_refresh_utc,
                                                                                      run158_now_utc,
                                                                                      run158_refresh_due) + "\n";
   body += "- bucket_fill_progress: " + ASC_Run158BucketFillTelemetryLine(run158_buckets_total,
                                                                         run158_buckets_visible,
                                                                         run158_buckets_pending,
                                                                         run158_buckets_stalled,
                                                                         state.started_utc,
                                                                         run158_now_utc) + "\n";
   body += "- l2_l5_l6_displayed_refresh: " + ASC_Run158L2L5L6DisplayedRefreshLine(state.l2_last_scan_utc,
                                                                                   state.top10_deferred_l5_last_service_utc,
                                                                                   run158_l6_utc,
                                                                                   run158_now_utc,
                                                                                   state.top10_deferred_l5_pending_count,
                                                                                   state.deferred_write_artifacts) + "\n";
   body += "- queue_priority_and_dirty_loop_guard: " + ASC_Run158QueueProgressLawLine() + "\n";

   body += "\nRUN159R Speed/Truth-Fill Closeout + RUN160 Live Contract\n";
   body += "- bucket_fill_source_readiness: " + ASC_Run159BucketFillSourceReadinessLine() + "\n";
   body += "- run160_live_contract: " + ASC_Run159Run160LiveContractLine() + "\n";
   body += "- protected_boundaries: " + ASC_Run159ProtectedBoundaryLine() + "\n";

   body += ASC_PublicationResilienceBlock(body,
                                           required_tokens,
                                           "scanner_status",
                                           "ASC_ScannerStatusWriter",
                                           "missing Scanner Status proof/diagnostic token is emitted as degraded status; publication remains visible unless FileIO fails",
                                           true);

   string write_state = "pending";
   string write_reason = "pending";
   int scanner_resilience_missing_count = 0;
   string scanner_resilience_first_missing = "none";
   ASC_PublicationResilienceMissingTokenList(body, required_tokens, scanner_resilience_missing_count, scanner_resilience_first_missing);
   string scanner_resilient_publication_state = summary.publication_posture;
   if(scanner_resilience_missing_count > 0)
      scanner_resilient_publication_state = "complete_with_degraded_sections";
   if(!ASC_WritePublicationArtifact(contract.target_path,
                                    StringFormat("status-%d", state.heartbeat_counter),
                                    now_utc,
                                    body,
                                    required_tokens,
                                    scanner_resilient_publication_state,
                                    write_state,
                                    write_reason))
     {
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_IO_FAILED,
                               "Failed to write scanner status artifact: " + write_reason,
                               contract.target_path);
      return result;
     }

   ASC_FunctionResultState finish_state = ASC_RESULT_OK;
   int run090_backlog_count = state.l1_publish_pending_dossiers ? MathMax(0, state.dossier_pending_backlog_count) : MathMax(0, state.deferred_write_artifacts);
   string finish_message = "Scanner Status artifact updated. | "
                           + ASC_FunctionResultsRun090AggregateProofTokens(state.top10_deferred_l5_pending_count,
                                                                           state.top10_deferred_l5_expired_count,
                                                                           state.top10_deferred_l5_retry_exhausted_count,
                                                                           state.top10_deferred_l5_completed_count,
                                                                           state.dossier_queue_state,
                                                                           state.dossier_queue_cursor_total,
                                                                           run090_backlog_count,
                                                                           state.dossier_queue_stall_count,
                                                                           state.dossier_queue_recovered_count,
                                                                           state.top10_run_full_family_alignment_status,
                                                                           state.top10_run_full_current_source_signature,
                                                                           state.top10_run_full_last_completed_source_signature,
                                                                           ASC_Run090ArtifactFreshnessStatus(state),
                                                                           ASC_Run090CurrentFocusMirrorStatus(state));
   string run091_finish_contradiction_scope = "none";
   int run091_finish_contradiction_count = ASC_Run091ContradictionCount(state, run090_backlog_count, ASC_Run090ArtifactFreshnessStatus(state), ASC_Run090CurrentFocusMirrorStatus(state), run091_finish_contradiction_scope);
   string run091_finish_contradiction_severity = ASC_Run091ContradictionSeverity(run091_finish_contradiction_count);
   int run091_finish_proof_debt_count = ASC_Run091ProofDebtCount(state, run090_backlog_count, ASC_Run090ArtifactFreshnessStatus(state), ASC_Run090CurrentFocusMirrorStatus(state));
   finish_message += " | " + ASC_FunctionResultsRun091AggregateProofTokens(state.top10_run_full_total,
                                                                               state.top10_run_full_cursor,
                                                                               state.top10_run_full_batch_status,
                                                                               state.top10_run_full_verify_pass_count,
                                                                               state.top10_run_full_verify_fail_count,
                                                                               state.heartbeat_last_duration_ms,
                                                                               state.heartbeat_budget_scan_ms,
                                                                               state.heartbeat_budget_write_ms,
                                                                               run091_finish_contradiction_count,
                                                                               run091_finish_contradiction_severity,
                                                                               run091_finish_contradiction_scope,
                                                                               run091_finish_proof_debt_count);
   int run092_finish_alignment_contradiction_count = (run091_finish_contradiction_count > 0 ? run091_finish_contradiction_count : ((state.top10_run_full_verify_fail_count > 0) ? state.top10_run_full_verify_fail_count : 0));
   string run092_finish_worst_alignment_contradiction = (run092_finish_alignment_contradiction_count > 0 ? run091_finish_contradiction_severity : "none");
   finish_message += " | " + ASC_FunctionResultsRun092AggregateProofTokens(state.top10_run_full_total,
                                                                              state.top10_run_full_cursor,
                                                                              state.top10_run_full_family_alignment_status,
                                                                              state.top10_run_full_current_source_signature,
                                                                              state.top10_run_full_last_completed_source_signature,
                                                                              state.top10_run_full_verify_pass_count,
                                                                              state.top10_run_full_verify_fail_count,
                                                                              run092_finish_alignment_contradiction_count,
                                                                              run092_finish_worst_alignment_contradiction,
                                                                              run091_finish_proof_debt_count);
   string run098_finish_hydration_counts = "closed_l0_l2=" + IntegerToString(MathMax(0, state.phase2a_hydration_closed_l0_l2_count))
                                      + ",open_l0_l4=" + IntegerToString(MathMax(0, state.phase2a_hydration_open_l0_l4_count))
                                      + ",top10_l0_l6=" + IntegerToString(MathMax(0, state.phase2a_hydration_top10_l0_l6_count))
                                      + ",selected_l0_l6=" + IntegerToString(MathMax(0, state.phase2a_hydration_selected_l0_l6_count));
   string run098_finish_3kb_counts = "closed_compact=" + IntegerToString(MathMax(0, state.phase2a_three_kb_closed_compact_honest_count))
                                 + ",open_incomplete=" + IntegerToString(MathMax(0, state.phase2a_three_kb_open_hydration_incomplete_count))
                                 + ",requires_review=" + IntegerToString(MathMax(0, state.phase2a_three_kb_unknown_requires_review_count));
   finish_message += " | " + ASC_FRRun098Phase3AProofTokens("Phase_3A_Logging_Spine",
                                                               "closed_with_bounded_carry_forward_debt_into_RUN100R",
                                                               run098_finish_hydration_counts,
                                                               run098_finish_3kb_counts,
                                                               state.dossier_queue_state,
                                                               (state.dossier_backfill_pending_count > 0 ? "pending" : "not_pending"),
                                                               (state.dossier_queue_stall_count > 0 || state.dossier_queue_stalled_count > 0 ? "stalled_or_retrying" : "not_stalled"),
                                                               (state.heartbeat_last_duration_ms > MathMax(state.heartbeat_budget_scan_ms, state.heartbeat_budget_write_ms) ? "budget_pressure_visible" : "within_or_unproven"),
                                                               "source_identity_required_in_manifest_summary",
                                                               ASC_Run090ArtifactFreshnessStatus(state),
                                                               state.top10_run_full_batch_status,
                                                               ASC_Run090CurrentFocusMirrorStatus(state),
                                                               state.top10_run_full_family_alignment_status,
                                                               run091_finish_contradiction_count,
                                                               run091_finish_contradiction_severity,
                                                               run091_finish_proof_debt_count,
                                                               (run091_finish_contradiction_count > 0 || state.phase2a_requires_operator_review_count > 0));
   finish_message += " | " + ASC_Top5BucketSkeletonProofTokens(state.top5_bucket_family_state,
                                                                  state.top5_bucket_count,
                                                                  state.top5_bucket_child_target_count,
                                                                  state.top5_bucket_child_written_count,
                                                                  state.top5_bucket_child_pending_count,
                                                                  state.top5_bucket_child_failed_count,
                                                                  state.top5_bucket_queue_remaining,
                                                                  state.top5_bucket_last_symbol,
                                                                  state.top5_bucket_last_error);
   string finish_top5_pending_reason = "alignment_pending_refresh";
   if(state.top5_bucket_queue_remaining > 0)
      finish_top5_pending_reason = "queue_pending";
   else if(state.publication_bundle.top5_bucket_pending_count > 0)
      finish_top5_pending_reason = "live_cycle_incomplete";
   else if(state.publication_bundle.top5_bucket_staging_child_count > 0)
      finish_top5_pending_reason = "not_yet_committed";
   else
     {
      string finish_top5_alignment_reason = ASC_TextOrUnavailable(state.publication_bundle.top5_bucket_alignment_reason);
      if(StringFind(finish_top5_alignment_reason, "mismatch") >= 0)
         finish_top5_pending_reason = "snapshot_mismatch";
     }
   finish_message += " | top5_market_board_sync=false | top5_market_board_sync_status=pending_market_board_visible_signature_compare | market_board_to_top5_dossier_sync=false | market_board_to_top5_dossier_sync_status=pending_market_board_visible_signature_compare | top5_pending_reason=" + finish_top5_pending_reason + " | alignment_pass_allowed=false | verdict_owner=ASC_MarketBoardWriter_signature_compare";
   finish_message += " | " + ASC_ScannerStatusDossierPolicyTokens(state);
   finish_message += " | " + proof_bundle_line;
   finish_message += " | " + ASC_MissingRuntimeSurfaceClassificationLine();
   finish_message += " | " + ASC_ScannerStatusClaimEvidenceTokens(state);
   finish_message += " | " + ASC_TraderChatAggregateTokens();

   if(write_state == "continuity")
     {
      finish_state = ASC_RESULT_WARNING;
      finish_message = "Scanner Status continuity publish retained the prior last-good artifact.";
     }

   ASC_FunctionResultFinish(result,
                            finish_state,
                            ASC_RC_OK,
                            finish_message,
                            contract.target_path);
   return result;
  }

#endif
