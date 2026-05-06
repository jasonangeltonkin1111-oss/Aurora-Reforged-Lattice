#ifndef __ASC_ARTIFACT_TEXT_HELPERS_MQH__
#define __ASC_ARTIFACT_TEXT_HELPERS_MQH__

#include "../symbols/ASC_ClassificationAuthority.mqh"
#include "../symbols/ASC_SymbolSpecification.mqh"
#include "../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"
#include "../core/ASC_Constants.mqh"
#include "../core/ASC_Version.mqh"

string ASC_ArtifactServerName()
  {
   string server_name = AccountInfoString(ACCOUNT_SERVER);
   if(StringLen(server_name) <= 0)
      return "Unknown Server";
   return server_name;
  }

string ASC_ArtifactFormatUtc(const datetime value)
  {
   if(value <= 0)
      return "Not yet observed";
   return TimeToString(value, TIME_DATE | TIME_SECONDS);
  }


string ASC_RuntimeIdentityProofCleanValue(const string raw_value,const string fallback_value = "unavailable")
  {
   string value = raw_value;
   StringTrimLeft(value);
   StringTrimRight(value);
   if(StringLen(value) <= 0)
      value = fallback_value;
   StringReplace(value, "\r", " ");
   StringReplace(value, "\n", " ");
   return value;
  }

string ASC_RuntimeIdentityProofBlock(const string artifact_writer,
                                     const string server_root,
                                     const string route_family,
                                     const datetime publish_utc = 0)
  {
   string terminal_data_path = ASC_RuntimeIdentityProofCleanValue(TerminalInfoString(TERMINAL_DATA_PATH));
   string terminal_commondata_path = ASC_RuntimeIdentityProofCleanValue(TerminalInfoString(TERMINAL_COMMONDATA_PATH));
   string output_root_path = terminal_commondata_path;
   if(StringLen(output_root_path) > 0 && output_root_path != "unavailable")
      output_root_path += "\\Files";
   if(StringLen(server_root) > 0)
      output_root_path += "\\" + server_root;

   string block = "SOURCE_RUNTIME_IDENTITY_PROOF_BEGIN\n";
   block += "identity_proof_version=RUN252_v1\n";
   block += "source_run_id=" + ASC_SourceRunId() + "\n";
   block += "source_version_label=" + ASC_SourceVersionLabel() + "\n";
   block += "source_version_date=" + string(ASC_VERSION_DATE) + "\n";
   block += "output_package_name=" + string(ASC_TRUTH_SEEKER_OUTPUT_PACKAGE_NAME) + "\n";
   block += "compiled_program_name=" + ASC_RuntimeIdentityProofCleanValue(MQLInfoString(MQL_PROGRAM_NAME)) + "\n";
   block += "terminal_data_path=" + terminal_data_path + "\n";
   block += "terminal_commondata_path=" + terminal_commondata_path + "\n";
   block += "output_root_path=" + output_root_path + "\n";
   block += "server_profile=" + ASC_RuntimeIdentityProofCleanValue(AccountInfoString(ACCOUNT_SERVER), "UnknownServer") + "\n";
   block += "chart_symbol=" + ASC_RuntimeIdentityProofCleanValue(Symbol()) + "\n";
   block += "chart_period=" + IntegerToString((int)Period()) + "\n";
   block += "artifact_writer=" + ASC_RuntimeIdentityProofCleanValue(artifact_writer) + "\n";
   block += "artifact_publish_utc=" + ASC_ArtifactFormatUtc((publish_utc > 0) ? publish_utc : TimeGMT()) + "\n";
   block += "route_family=" + ASC_RuntimeIdentityProofCleanValue(route_family, "root") + "\n";
   block += "identity_chain_status=unproven\n";
   block += "identity_chain_blocks_publication_repair=true\n";
   block += "route_change_performed=false\n";
   block += "path_change_performed=false\n";
   block += "fileio_final_path_change_performed=false\n";
   block += "trade_permission=false\n";
   block += "signal_permission=false\n";
   block += "execution_permission=false\n";
   block += "risk_permission=false\n";
   block += "SOURCE_RUNTIME_IDENTITY_PROOF_END\n";
   return block;
  }


string ASC_RuntimeBoolText(const bool value)
  {
   return value ? "true" : "false";
  }

string ASC_RuntimeCsvOrNone(const string raw_value)
  {
   string value = raw_value;
   StringTrimLeft(value);
   StringTrimRight(value);
   if(StringLen(value) <= 0)
      return "none";
   return value;
  }

string ASC_RootArtifactBreathingProofBlock(const string surface_name,
                                           const datetime heartbeat_utc,
                                           const datetime scanner_status_last_attempt_utc,
                                           const datetime scanner_status_last_success_utc,
                                           const datetime market_board_last_attempt_utc,
                                           const datetime market_board_last_success_utc,
                                           const datetime artifact_manifest_last_attempt_utc,
                                           const datetime artifact_manifest_last_success_utc,
                                           const datetime open_symbol_snapshot_last_attempt_utc,
                                           const datetime open_symbol_snapshot_last_success_utc,
                                           const int stale_surface_count,
                                           const string stale_surfaces,
                                           const bool keepalive_rescue_due,
                                           const string keepalive_rescue_reason,
                                           const string write_lane_alive)
  {
   string block = "ROOT_ARTIFACT_BREATHING_PROOF_BEGIN\n";
   block += "root_artifact_breathing_version=RUN252_v1\n";
   block += "source_run_id=" + ASC_SourceRunId() + "\n";
   block += "surface=" + ASC_RuntimeIdentityProofCleanValue(surface_name, "root") + "\n";
   block += "heartbeat_utc=" + ASC_ArtifactFormatUtc(heartbeat_utc) + "\n";
   block += "scanner_status_last_attempt_utc=" + ASC_ArtifactFormatUtc(scanner_status_last_attempt_utc) + "\n";
   block += "scanner_status_last_success_utc=" + ASC_ArtifactFormatUtc(scanner_status_last_success_utc) + "\n";
   block += "market_board_last_attempt_utc=" + ASC_ArtifactFormatUtc(market_board_last_attempt_utc) + "\n";
   block += "market_board_last_success_utc=" + ASC_ArtifactFormatUtc(market_board_last_success_utc) + "\n";
   block += "artifact_manifest_last_attempt_utc=" + ASC_ArtifactFormatUtc(artifact_manifest_last_attempt_utc) + "\n";
   block += "artifact_manifest_last_success_utc=" + ASC_ArtifactFormatUtc(artifact_manifest_last_success_utc) + "\n";
   block += "open_symbol_snapshot_last_attempt_utc=" + ASC_ArtifactFormatUtc(open_symbol_snapshot_last_attempt_utc) + "\n";
   block += "open_symbol_snapshot_last_success_utc=" + ASC_ArtifactFormatUtc(open_symbol_snapshot_last_success_utc) + "\n";
   block += "stale_surface_count=" + IntegerToString(MathMax(0, stale_surface_count)) + "\n";
   block += "stale_surfaces=" + ASC_RuntimeCsvOrNone(stale_surfaces) + "\n";
   block += "keepalive_rescue_due=" + ASC_RuntimeBoolText(keepalive_rescue_due) + "\n";
   block += "keepalive_rescue_reason=" + ASC_RuntimeIdentityProofCleanValue(keepalive_rescue_reason, "none") + "\n";
   block += "write_lane_alive=" + ASC_RuntimeIdentityProofCleanValue(write_lane_alive, "unknown") + "\n";
   block += "deep_work_allowed_to_delay_root_artifacts=false\n";
   block += "fake_complete=false\n";
   block += "route_change_performed=false\n";
   block += "path_change_performed=false\n";
   block += "fileio_final_path_change_performed=false\n";
   block += "trade_permission=false\n";
   block += "signal_permission=false\n";
   block += "execution_permission=false\n";
   block += "risk_permission=false\n";
   block += "ROOT_ARTIFACT_BREATHING_PROOF_END\n";
   return block;
  }

string ASC_PublicationForwardProgressProofBlock(const string family,
                                                const string route_family,
                                                const int expected_count,
                                                const int queued_count,
                                                const int attempted_count,
                                                const int written_count,
                                                const int readback_confirmed_count,
                                                const int pending_count,
                                                const int failed_count,
                                                const datetime last_attempt_utc,
                                                const datetime last_success_utc,
                                                const datetime last_failure_utc,
                                                const string last_failure_reason,
                                                const string resume_cursor,
                                                const string next_pending_symbol,
                                                const string queue_state,
                                                const bool stale_replan_required,
                                                const bool stall_detected,
                                                const string stall_owner,
                                                const string stall_reason,
                                                const string next_safe_repair_gate)
  {
   string block = "PUBLICATION_FORWARD_PROGRESS_PROOF_BEGIN\n";
   block += "publication_forward_progress_version=RUN252_v1\n";
   block += "family=" + ASC_RuntimeIdentityProofCleanValue(family, "unknown") + "\n";
   block += "route_family=" + ASC_RuntimeIdentityProofCleanValue(route_family, "unknown") + "\n";
   block += "expected_count=" + IntegerToString(MathMax(0, expected_count)) + "\n";
   block += "queued_count=" + IntegerToString(MathMax(0, queued_count)) + "\n";
   block += "attempted_count=" + IntegerToString(MathMax(0, attempted_count)) + "\n";
   block += "written_count=" + IntegerToString(MathMax(0, written_count)) + "\n";
   block += "readback_confirmed_count=" + IntegerToString(MathMax(0, readback_confirmed_count)) + "\n";
   block += "pending_count=" + IntegerToString(MathMax(0, pending_count)) + "\n";
   block += "failed_count=" + IntegerToString(MathMax(0, failed_count)) + "\n";
   block += "last_attempt_utc=" + ASC_ArtifactFormatUtc(last_attempt_utc) + "\n";
   block += "last_success_utc=" + ASC_ArtifactFormatUtc(last_success_utc) + "\n";
   block += "last_failure_utc=" + ASC_ArtifactFormatUtc(last_failure_utc) + "\n";
   block += "last_failure_reason=" + ASC_RuntimeIdentityProofCleanValue(last_failure_reason, "none") + "\n";
   block += "resume_cursor=" + ASC_RuntimeIdentityProofCleanValue(resume_cursor, "unavailable") + "\n";
   block += "next_pending_symbol=" + ASC_RuntimeIdentityProofCleanValue(next_pending_symbol, "unavailable") + "\n";
   block += "queue_state=" + ASC_RuntimeIdentityProofCleanValue(queue_state, "unknown") + "\n";
   block += "stale_replan_required=" + ASC_RuntimeBoolText(stale_replan_required) + "\n";
   block += "stall_detected=" + ASC_RuntimeBoolText(stall_detected) + "\n";
   block += "stall_owner=" + ASC_RuntimeIdentityProofCleanValue(stall_owner, "none") + "\n";
   block += "stall_reason=" + ASC_RuntimeIdentityProofCleanValue(stall_reason, "none") + "\n";
   block += "next_safe_repair_gate=" + ASC_RuntimeIdentityProofCleanValue(next_safe_repair_gate, "RUN253_PUBLICATION_COMPLETION_REPAIR") + "\n";
   block += "fake_complete=false\n";
   block += "route_change_performed=false\n";
   block += "path_change_performed=false\n";
   block += "fileio_final_path_change_performed=false\n";
   block += "trade_permission=false\n";
   block += "signal_permission=false\n";
   block += "execution_permission=false\n";
   block += "risk_permission=false\n";
   block += "PUBLICATION_FORWARD_PROGRESS_PROOF_END\n";
   return block;
  }


string ASC_Run253CompletionStatus(const int expected_count,const int written_count,const int readback_confirmed_count,const int pending_count,const int failed_count)
  {
   if(expected_count <= 0)
      return "pending";
   if(failed_count > 0 && readback_confirmed_count <= 0)
      return "failed";
   if(pending_count > 0 || written_count < expected_count || readback_confirmed_count < written_count)
      return "partial";
   if(readback_confirmed_count >= expected_count && failed_count <= 0)
      return "complete";
   return "partial";
  }

string ASC_Run253ParityStatus(const int main_expected,const int main_readback,const int lite_expected,const int lite_readback,const string main_snapshot,const string lite_snapshot)
  {
   if(main_expected <= 0 || lite_expected <= 0)
      return "unproven";
   if(main_snapshot != lite_snapshot)
      return "mismatched";
   if(main_readback >= main_expected && lite_readback >= lite_expected && main_expected == lite_expected)
      return "matched";
   return "partial";
  }

string ASC_Run253PublicationCompletionLedgerBlock(const string family,
                                                  const string route_family,
                                                  const string snapshot_id,
                                                  const int expected_child_count,
                                                  const int queued_child_count,
                                                  const int attempted_child_count,
                                                  const int written_child_count,
                                                  const int readback_confirmed_child_count,
                                                  const int pending_child_count,
                                                  const int failed_child_count,
                                                  const int stale_replan_count,
                                                  const string queue_state,
                                                  const string queue_resume_cursor,
                                                  const string last_attempted_symbol,
                                                  const string last_written_symbol,
                                                  const string next_pending_symbol,
                                                  const string pending_symbols,
                                                  const string failed_symbols,
                                                  const string failure_reasons,
                                                  const string last_yield_reason,
                                                  const datetime next_retry_utc)
  {
   string status = ASC_Run253CompletionStatus(expected_child_count, written_child_count, readback_confirmed_child_count, pending_child_count, failed_child_count);
   string block = "PUBLICATION_COMPLETION_LEDGER_BEGIN\n";
   block += "publication_completion_ledger_version=RUN253_v1\n";
   block += "family=" + ASC_RuntimeIdentityProofCleanValue(family, "unknown") + "\n";
   block += "route_family=" + ASC_RuntimeIdentityProofCleanValue(route_family, "unknown") + "\n";
   block += "snapshot_id=" + ASC_RuntimeIdentityProofCleanValue(snapshot_id, "unavailable") + "\n";
   block += "expected_child_count=" + IntegerToString(MathMax(0, expected_child_count)) + "\n";
   block += "queued_child_count=" + IntegerToString(MathMax(0, queued_child_count)) + "\n";
   block += "attempted_child_count=" + IntegerToString(MathMax(0, attempted_child_count)) + "\n";
   block += "written_child_count=" + IntegerToString(MathMax(0, written_child_count)) + "\n";
   block += "readback_confirmed_child_count=" + IntegerToString(MathMax(0, readback_confirmed_child_count)) + "\n";
   block += "pending_child_count=" + IntegerToString(MathMax(0, pending_child_count)) + "\n";
   block += "failed_child_count=" + IntegerToString(MathMax(0, failed_child_count)) + "\n";
   block += "stale_replan_count=" + IntegerToString(MathMax(0, stale_replan_count)) + "\n";
   block += "queue_state=" + ASC_RuntimeIdentityProofCleanValue(queue_state, "unknown") + "\n";
   block += "queue_resume_cursor=" + ASC_RuntimeIdentityProofCleanValue(queue_resume_cursor, "unavailable") + "\n";
   block += "last_attempted_symbol=" + ASC_RuntimeIdentityProofCleanValue(last_attempted_symbol, "none") + "\n";
   block += "last_written_symbol=" + ASC_RuntimeIdentityProofCleanValue(last_written_symbol, "none") + "\n";
   block += "next_pending_symbol=" + ASC_RuntimeIdentityProofCleanValue(next_pending_symbol, "none") + "\n";
   block += "pending_symbols=" + ASC_RuntimeIdentityProofCleanValue(pending_symbols, "none") + "\n";
   block += "failed_symbols=" + ASC_RuntimeIdentityProofCleanValue(failed_symbols, "none") + "\n";
   block += "failure_reasons=" + ASC_RuntimeIdentityProofCleanValue(failure_reasons, "none") + "\n";
   block += "last_yield_reason=" + ASC_RuntimeIdentityProofCleanValue(last_yield_reason, "none") + "\n";
   block += "next_retry_utc=" + ASC_ArtifactFormatUtc(next_retry_utc) + "\n";
   block += "completion_status=" + status + "\n";
   block += "completion_blocks_trade=true\ncompletion_blocks_review=false\nfake_complete=false\nroute_change_performed=false\npath_change_performed=false\nfileio_final_path_change_performed=false\ntrade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   block += "PUBLICATION_COMPLETION_LEDGER_END\n";
   return block;
  }

string ASC_Run253ShellFirstPublicationStatusBlock(const string family,
                                                  const string snapshot_id,
                                                  const bool all_expected_shells_attempted,
                                                  const bool all_expected_shells_written,
                                                  const bool deep_payload_allowed,
                                                  const string deep_payload_defer_reason,
                                                  const string pending_shell_symbols,
                                                  const string missing_shell_symbols,
                                                  const string failed_shell_symbols,
                                                  const datetime next_shell_retry_utc)
  {
   string block = "SHELL_FIRST_PUBLICATION_STATUS_BEGIN\n";
   block += "shell_first_publication_status_version=RUN253_v1\n";
   block += "family=" + ASC_RuntimeIdentityProofCleanValue(family, "unknown") + "\n";
   block += "snapshot_id=" + ASC_RuntimeIdentityProofCleanValue(snapshot_id, "unavailable") + "\n";
   block += "shell_before_deep_payload=true\n";
   block += "all_expected_shells_attempted=" + ASC_RuntimeBoolText(all_expected_shells_attempted) + "\n";
   block += "all_expected_shells_written=" + ASC_RuntimeBoolText(all_expected_shells_written) + "\n";
   block += "deep_payload_allowed=" + ASC_RuntimeBoolText(deep_payload_allowed) + "\n";
   block += "deep_payload_defer_reason=" + ASC_RuntimeIdentityProofCleanValue(deep_payload_defer_reason, "none") + "\n";
   block += "pending_shell_symbols=" + ASC_RuntimeIdentityProofCleanValue(pending_shell_symbols, "none") + "\n";
   block += "missing_shell_symbols=" + ASC_RuntimeIdentityProofCleanValue(missing_shell_symbols, "none") + "\n";
   block += "failed_shell_symbols=" + ASC_RuntimeIdentityProofCleanValue(failed_shell_symbols, "none") + "\n";
   block += "next_shell_retry_utc=" + ASC_ArtifactFormatUtc(next_shell_retry_utc) + "\n";
   block += "review_allowed_when_shell_partial=true\ntrade_allowed_when_shell_partial=false\nfake_complete=false\nroute_change_performed=false\npath_change_performed=false\nfileio_final_path_change_performed=false\ntrade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   block += "SHELL_FIRST_PUBLICATION_STATUS_END\n";
   return block;
  }

string ASC_Run253FamilyFairnessStatusBlock(const string last_family_served,const string next_family_due,const bool deep_payload_deferred_for_shells)
  {
   string block = "FAMILY_FAIRNESS_STATUS_BEGIN\n";
   block += "family_fairness_version=RUN253_v1\n";
   block += "shell_quota_per_beat=1\n";
   block += "deep_payload_quota_per_beat=bounded_after_shells\n";
   block += "family_progress_order=root_surfaces,globaltop10_main,globaltop10_lite,top5_main,top5_lite,deep_payload\n";
   block += "starvation_guard_active=true\n";
   block += "globaltop10_main_starvation_guard=true\n";
   block += "globaltop10_lite_starvation_guard=true\n";
   block += "top5_main_starvation_guard=true\n";
   block += "top5_lite_starvation_guard=true\n";
   block += "last_family_served=" + ASC_RuntimeIdentityProofCleanValue(last_family_served, "unknown") + "\n";
   block += "next_family_due=" + ASC_RuntimeIdentityProofCleanValue(next_family_due, "unknown") + "\n";
   block += "deep_payload_deferred_for_shells=" + ASC_RuntimeBoolText(deep_payload_deferred_for_shells) + "\n";
   block += "retry_storm_guard_active=true\n";
   block += "fake_complete=false\ntrade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   block += "FAMILY_FAIRNESS_STATUS_END\n";
   return block;
  }

string ASC_Run253GlobalTop10PublicationCompletionRepairBlock(const string main_owner,
                                                             const string lite_owner,
                                                             const string source_owner,
                                                             const string snapshot_id,
                                                             const int expected_child_count,
                                                             const int main_written_count,
                                                             const int main_readback_count,
                                                             const int lite_written_count,
                                                             const int lite_readback_count,
                                                             const int main_pending_count,
                                                             const int lite_pending_count,
                                                             const int main_failed_count,
                                                             const int lite_failed_count,
                                                             const string same_snapshot_status,
                                                             const string same_symbol_set_status)
  {
   string completion = ASC_Run253CompletionStatus(expected_child_count, MathMin(main_written_count, lite_written_count), MathMin(main_readback_count, lite_readback_count), MathMax(main_pending_count, lite_pending_count), MathMax(main_failed_count, lite_failed_count));
   string block = "GLOBALTOP10_PUBLICATION_COMPLETION_REPAIR_BEGIN\n";
   block += "globaltop10_publication_completion_version=RUN253_v1\n";
   block += "main_dossier_owner=" + ASC_RuntimeIdentityProofCleanValue(main_owner, "unknown") + "\n";
   block += "lite_sdp_owner=" + ASC_RuntimeIdentityProofCleanValue(lite_owner, "unknown") + "\n";
   block += "source_symbol_set_owner=" + ASC_RuntimeIdentityProofCleanValue(source_owner, "unknown") + "\n";
   block += "source_snapshot_id=" + ASC_RuntimeIdentityProofCleanValue(snapshot_id, "unavailable") + "\n";
   block += "expected_child_count=" + IntegerToString(MathMax(0, expected_child_count)) + "\n";
   block += "main_dossier_written_count=" + IntegerToString(MathMax(0, main_written_count)) + "\n";
   block += "main_dossier_readback_confirmed_count=" + IntegerToString(MathMax(0, main_readback_count)) + "\n";
   block += "lite_sdp_written_count=" + IntegerToString(MathMax(0, lite_written_count)) + "\n";
   block += "lite_sdp_readback_confirmed_count=" + IntegerToString(MathMax(0, lite_readback_count)) + "\n";
   block += "main_pending_count=" + IntegerToString(MathMax(0, main_pending_count)) + "\n";
   block += "lite_pending_count=" + IntegerToString(MathMax(0, lite_pending_count)) + "\n";
   block += "main_failed_count=" + IntegerToString(MathMax(0, main_failed_count)) + "\n";
   block += "lite_failed_count=" + IntegerToString(MathMax(0, lite_failed_count)) + "\n";
   block += "same_snapshot_required=true\nsame_symbol_set_required=true\n";
   block += "same_snapshot_status=" + ASC_RuntimeIdentityProofCleanValue(same_snapshot_status, "unproven") + "\n";
   block += "same_symbol_set_status=" + ASC_RuntimeIdentityProofCleanValue(same_symbol_set_status, "unproven") + "\n";
   block += "completion_status=" + completion + "\n";
   block += "completion_blocks_trade=true\ncompletion_blocks_review=false\nfake_complete=false\nroute_change_performed=false\npath_change_performed=false\nfileio_final_path_change_performed=false\ntrade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   block += "GLOBALTOP10_PUBLICATION_COMPLETION_REPAIR_END\n";
   return block;
  }

string ASC_Run253Top5PerBucketPublicationCompletionRepairBlock(const string bucket_source_owner,
                                                               const string child_source_owner,
                                                               const string snapshot_id,
                                                               const int expected_bucket_count,
                                                               const int expected_children_per_bucket,
                                                               const int expected_total_child_count,
                                                               const int main_written_count,
                                                               const int main_readback_count,
                                                               const int lite_written_count,
                                                               const int lite_readback_count,
                                                               const int pending_bucket_count,
                                                               const int pending_child_count,
                                                               const int failed_child_count,
                                                               const string missing_main_children,
                                                               const string missing_lite_children,
                                                               const string failed_children,
                                                               const string failure_reasons,
                                                               const string queue_state,
                                                               const string resume_cursor,
                                                               const string next_pending_bucket,
                                                               const string next_pending_symbol,
                                                               const string main_lite_parity_status)
  {
   string completion = ASC_Run253CompletionStatus(expected_total_child_count, MathMin(main_written_count, lite_written_count), MathMin(main_readback_count, lite_readback_count), pending_child_count, failed_child_count);
   string block = "TOP5PERBUCKET_PUBLICATION_COMPLETION_REPAIR_BEGIN\n";
   block += "top5_publication_completion_version=RUN253_v1\n";
   block += "bucket_source_owner=" + ASC_RuntimeIdentityProofCleanValue(bucket_source_owner, "unknown") + "\n";
   block += "child_source_owner=" + ASC_RuntimeIdentityProofCleanValue(child_source_owner, "unknown") + "\n";
   block += "snapshot_id=" + ASC_RuntimeIdentityProofCleanValue(snapshot_id, "unavailable") + "\n";
   block += "expected_bucket_count=" + IntegerToString(MathMax(0, expected_bucket_count)) + "\n";
   block += "expected_children_per_bucket=" + IntegerToString(MathMax(0, expected_children_per_bucket)) + "\n";
   block += "expected_total_child_count=" + IntegerToString(MathMax(0, expected_total_child_count)) + "\n";
   block += "main_dossier_written_count=" + IntegerToString(MathMax(0, main_written_count)) + "\n";
   block += "main_dossier_readback_confirmed_count=" + IntegerToString(MathMax(0, main_readback_count)) + "\n";
   block += "lite_sdp_written_count=" + IntegerToString(MathMax(0, lite_written_count)) + "\n";
   block += "lite_sdp_readback_confirmed_count=" + IntegerToString(MathMax(0, lite_readback_count)) + "\n";
   block += "pending_bucket_count=" + IntegerToString(MathMax(0, pending_bucket_count)) + "\n";
   block += "pending_child_count=" + IntegerToString(MathMax(0, pending_child_count)) + "\n";
   block += "failed_child_count=" + IntegerToString(MathMax(0, failed_child_count)) + "\n";
   block += "missing_main_children=" + ASC_RuntimeIdentityProofCleanValue(missing_main_children, "none") + "\n";
   block += "missing_lite_children=" + ASC_RuntimeIdentityProofCleanValue(missing_lite_children, "none") + "\n";
   block += "failed_children=" + ASC_RuntimeIdentityProofCleanValue(failed_children, "none") + "\n";
   block += "failure_reasons=" + ASC_RuntimeIdentityProofCleanValue(failure_reasons, "none") + "\n";
   block += "queue_state=" + ASC_RuntimeIdentityProofCleanValue(queue_state, "unknown") + "\n";
   block += "resume_cursor=" + ASC_RuntimeIdentityProofCleanValue(resume_cursor, "unavailable") + "\n";
   block += "next_pending_bucket=" + ASC_RuntimeIdentityProofCleanValue(next_pending_bucket, "none") + "\n";
   block += "next_pending_symbol=" + ASC_RuntimeIdentityProofCleanValue(next_pending_symbol, "none") + "\n";
   block += "same_snapshot_required=true\nsame_symbol_set_required=true\n";
   block += "main_lite_parity_status=" + ASC_RuntimeIdentityProofCleanValue(main_lite_parity_status, "unproven") + "\n";
   block += "completion_status=" + completion + "\n";
   block += "completion_blocks_trade=true\ncompletion_blocks_review=false\nfake_complete=false\nroute_change_performed=false\npath_change_performed=false\nfileio_final_path_change_performed=false\ntrade_permission=false\nsignal_permission=false\nexecution_permission=false\nrisk_permission=false\n";
   block += "TOP5PERBUCKET_PUBLICATION_COMPLETION_REPAIR_END\n";
   return block;
  }

string ASC_ArtifactPublicationState(const bool is_degraded,const bool is_stale)
  {
   if(is_degraded)
      return "degraded";
   if(is_stale)
      return "stale";
   return "fresh";
  }

string ASC_ArtifactFreshnessLabel(const bool is_degraded,const bool is_stale)
  {
   if(is_degraded)
      return "Degraded";
   if(is_stale)
      return "Delayed";
   return "Fresh";
  }


string ASC_Top5SnapshotNormalizeSymbol(const string symbol_raw)
  {
   string symbol = symbol_raw;
   StringTrimLeft(symbol);
   StringTrimRight(symbol);
   if(StringLen(symbol) <= 0)
      return "unavailable";

   string normalized = symbol;
   StringToUpper(normalized);

   int dot = StringFind(normalized, ".");
   if(dot > 0)
     {
      string suffix = StringSubstr(normalized, dot + 1);
      if(StringLen(suffix) > 0 && StringLen(suffix) <= 5)
         normalized = StringSubstr(normalized, 0, dot);
     }

   return normalized;
  }

string ASC_Top5SnapshotNormalizeSlug(const string slug_raw)
  {
   string slug = slug_raw;
   StringTrimLeft(slug);
   StringTrimRight(slug);
   StringToLower(slug);
   if(StringLen(slug) <= 0)
      return "unknown";
   return slug;
  }

string ASC_Top5SnapshotCompactList(const string &symbols[],const string &slugs[],const int &ranks[],const bool normalize_symbols)
  {
   string text = "";
   int count = MathMin(ArraySize(symbols), MathMin(ArraySize(slugs), ArraySize(ranks)));
   for(int i = 0; i < count; i++)
     {
      if(StringLen(symbols[i]) <= 0)
         continue;
      if(StringLen(text) > 0)
         text += ",";
      string symbol_token = normalize_symbols ? ASC_Top5SnapshotNormalizeSymbol(symbols[i]) : ASC_TextOrUnavailable(symbols[i]);
      text += ASC_Top5SnapshotNormalizeSlug(slugs[i]) + "#" + IntegerToString(ranks[i]) + ":" + symbol_token;
     }
   if(StringLen(text) <= 0)
      return "empty";
   return text;
  }

string ASC_Top5SnapshotSignatureFromArrays(const datetime source_pass_utc,
                                           const string &symbols[],
                                           const string &slugs[],
                                           const int &ranks[],
                                           const bool normalize_symbols)
  {
   return "top5_per_bucket|source_pass=" + ASC_ArtifactFormatUtc(source_pass_utc)
          + "|queue=" + ASC_Top5SnapshotCompactList(symbols, slugs, ranks, normalize_symbols)
          + "|build=" + ASC_VERSION_LABEL
          + "|run=" + ASC_TRUTH_SEEKER_CURRENT_RUN
          + "|symbol_identity=" + (normalize_symbols ? "broker_suffix_normalized" : "exact_broker_symbol");
  }

string ASC_Top5BoardSyncVerdict(const string board_signature,
                                const string committed_signature,
                                const string family_state,
                                const int target_count,
                                const int active_actual_count,
                                const int staging_child_count,
                                const int queue_remaining,
                                const int pending_count,
                                const bool board_publish_pending)
  {
   string family = family_state;
   StringTrimLeft(family);
   StringTrimRight(family);
   StringToLower(family);

   if(StringLen(committed_signature) <= 0 || committed_signature == "unavailable")
      return "not_yet_committed";
   if(board_publish_pending)
      return "not_yet_committed";
   if(queue_remaining > 0 || pending_count > 0)
      return "queue_pending";
   if(staging_child_count > 0)
      return "alignment_pending_refresh";
   if(family != "promoted_current")
      return "cadence_hold";
   if(target_count <= 0)
      return "not_yet_committed";
   if(active_actual_count != target_count)
      return "snapshot_mismatch";
   if(board_signature != committed_signature)
      return "snapshot_mismatch";
   return "sync";
  }

string ASC_Top5BoardSyncToken(const string sync_status)
  {
   return (sync_status == "sync") ? "true" : "false";
  }

string ASC_ClaimEvidenceSchemaToken()
  {
   return "claim_status|claim_subject|claim_source_owner|claim_reason|claim_next_check|claim_currentness|claim_actionability_block|claim_operator_action|claim_confidence|claim_evidence_token";
  }

string ASC_ClaimEvidenceLine(const string claim_status,
                             const string claim_subject,
                             const string claim_source_owner,
                             const string claim_reason,
                             const string claim_next_check,
                             const string claim_currentness,
                             const bool claim_actionability_block,
                             const string claim_operator_action,
                             const string claim_confidence,
                             const string claim_evidence_token)
  {
   string line = "claim_status=" + ASC_TextOrUnavailable(claim_status);
   line += " | claim_subject=" + ASC_TextOrUnavailable(claim_subject);
   line += " | claim_source_owner=" + ASC_TextOrUnavailable(claim_source_owner);
   line += " | claim_reason=" + ASC_TextOrUnavailable(claim_reason);
   line += " | claim_next_check=" + ASC_TextOrUnavailable(claim_next_check);
   line += " | claim_currentness=" + ASC_TextOrUnavailable(claim_currentness);
   line += " | claim_actionability_block=" + (claim_actionability_block ? "true" : "false");
   line += " | claim_operator_action=" + ASC_TextOrUnavailable(claim_operator_action);
   line += " | claim_confidence=" + ASC_TextOrUnavailable(claim_confidence);
   line += " | claim_evidence_token=" + ASC_TextOrUnavailable(claim_evidence_token);
   return line;
  }

string ASC_ClaimEvidenceStarterPolicyLine()
  {
   return "claim_evidence_enabled=true | claim_evidence_schema=" + ASC_ClaimEvidenceSchemaToken()
          + " | unavailable_is_failure=false | retained_is_current=false | pending_is_unavailable=false | stale_is_clean=false | diagnostic_is_actionable=false | ranked_is_trade_signal=false";
  }

string ASC_ArtifactSurfaceFreshnessBoundaryLine(const string publication_state,
                                                const bool command_authority_ready)
  {
   string state = publication_state;
   StringTrimLeft(state);
   StringTrimRight(state);
   StringToLower(state);
   if(StringLen(state) <= 0)
      state = "unresolved";

   string authority = command_authority_ready ? "command-ready" : "support-only-or-guarded";
   string prefix = "artifact_state=" + state + " | authority=" + authority;
   if(state == "fresh")
      return prefix + " | surface_role=current-promoted"
             + " | meaning=fresh current promoted truth; read as active surface baseline";
   if(state == "degraded")
      return prefix + " | surface_role=current-promoted-with-caution"
             + " | meaning=visible promoted surface, but source quality is degraded;"
             + " do not upgrade to clean/fresh truth";
   if(state == "stale")
      return prefix + " | surface_role=retained-last-good"
             + " | meaning=lawful retained truth, not fresh current truth;"
             + " wait for generated/promoted replacement before treating as renewed";
   if(state == "continuity")
      return prefix + " | surface_role=continuity-last-good"
             + " | meaning=last-good surface preserved through refresh/promotion gap;"
             + " not proof of a new current reading";
   if(state == "preserved")
      return prefix + " | surface_role=preserved-prior-current"
             + " | meaning=prior complete surface retained during hold/staging/failure;"
             + " staging/archive cannot masquerade as promoted truth";
   return prefix + " | surface_role=unclassified"
          + " | meaning=surface state is unresolved; treat as support-only until provenance verifies";
  }

string ASC_ArtifactSurfaceProvenanceLine()
  {
   return "Surface Provenance: generated-at identifies artifact write time; promoted/current identifies"
          + " the active visible family; source-owner remains the upstream scanner owner;"
          + " retained/staging/archive are not fresh promoted authority; "
          + ASC_BuildSourceArtifactIdentityToken() + ".";
  }

string ASC_ArtifactFamilyRoleMeaningLine()
  {
   return "Family Meaning: current=promoted complete visible family;"
          + " preserved=prior current retained as last-good, not renewed truth;"
          + " staging=candidate family only until verified/promoted;"
          + " archive=immutable prior snapshot evidence, never current authority.";
  }


string ASC_ArtifactProofScopeMeaning(const string proof_scope)
  {
   string scope = proof_scope;
   StringTrimLeft(scope);
   StringTrimRight(scope);
   StringToLower(scope);

   if(scope == ASC_PROOF_SCOPE_SOURCE_SUPPORTED)
      return "source contains support, but runtime/output proof still must be observed separately";
   if(scope == ASC_PROOF_SCOPE_RUNTIME_OBSERVED)
      return "runtime/output observation exists for the stated scenario and artifact surface";
   if(scope == ASC_PROOF_SCOPE_SOURCE_PATCHED_LIVE_UNPROVEN)
      return "source patch landed, but no compile/live/output proof is claimed for the patch yet";
   if(scope == ASC_PROOF_SCOPE_PRE_PATCH_LIVE_PROVEN_POST_PATCH_UNPROVEN)
      return "pre-patch output proved the old surface while the later source patch remains unproven";
   if(scope == ASC_PROOF_SCOPE_SCENARIO_ABSENT_UNTESTED)
      return "scenario was absent in available evidence and must not be treated as passed or clean";
   if(scope == ASC_PROOF_SCOPE_RETAINED_LAST_GOOD)
      return "last-good evidence is retained continuity, not fresh current truth";
   if(scope == ASC_PROOF_SCOPE_UNAVAILABLE)
      return "data is unavailable and must not be promoted into clean truth";
   if(scope == ASC_PROOF_SCOPE_PARTIAL)
      return "data is partial and must carry limitation wording";
   if(scope == ASC_PROOF_SCOPE_CURRENT)
      return "current promoted artifact family, subject to its stated freshness/proof class";
   if(scope == ASC_PROOF_SCOPE_ARCHIVE)
      return "archive evidence only; never current promoted authority";
   return "unclassified proof scope; treat as support-only until owner evidence clarifies it";
  }

string ASC_ArtifactContradictionCategoryMeaning(const string category)
  {
   string c = category;
   StringTrimLeft(c);
   StringTrimRight(c);
   StringToLower(c);

   if(c == ASC_CONTRADICTION_MARKET_BOARD_VS_DOSSIER_MISMATCH)
      return "shared field disagreement between Market Board projection and selected-symbol Dossier truth";
   if(c == ASC_CONTRADICTION_CURRENT_FOCUS_VS_DOSSIER_MISMATCH)
      return "legacy selected-symbol alias mirror differs from its selected-symbol Dossier source";
   if(c == ASC_CONTRADICTION_SCORE_VS_RANK_MISMATCH)
      return "candidate score context and shortlist rank explanation do not reconcile cleanly";
   if(c == ASC_CONTRADICTION_STALE_SOURCE_PROJECTION)
      return "artifact surface projects a field from stale or retained source state";
   if(c == ASC_CONTRADICTION_SOURCE_SUPPORTED_NOT_RUNTIME_OBSERVED)
      return "source supports the field or path, but runtime/output evidence has not observed it";
   if(c == ASC_CONTRADICTION_PRE_PATCH_LIVE_PROVEN_POST_PATCH_UNPROVEN)
      return "live evidence predates a source patch, so post-patch proof remains open";
   if(c == ASC_CONTRADICTION_DEEP_ANALYSIS_OVERCLAIM)
      return "deep selected-symbol analysis wording exceeds available support posture";
   if(c == ASC_CONTRADICTION_PORTFOLIO_HISTORY_ACTIVE_EXPOSURE_CONFUSION)
      return "history/context fields risk being read as active or future exposure";
   if(c == ASC_CONTRADICTION_GLOBALTOP10_CURRENT_ARCHIVE_CONFUSION)
      return "current GlobalTop10 family and archive evidence are not clearly separated";
   if(c == ASC_CONTRADICTION_BOARD_TOP_SYMBOL_MISSING_CHILD
      || c == ASC_CONTRADICTION_BOARD_SIGNATURE_CHILD_SIGNATURE_MISMATCH
      || c == ASC_CONTRADICTION_CHILD_PARTIAL_BUT_BOARD_COMPLETE
      || c == ASC_CONTRADICTION_DOSSIER_SOURCE_RUN_MISMATCH
      || c == ASC_CONTRADICTION_DOSSIER_SECTION_INCOMPLETE_BUT_CHILD_COMPLETE
      || c == ASC_CONTRADICTION_DEEP_PENDING_BUT_BOARD_IMPLIES_DEEP_COMPLETE
      || c == ASC_CONTRADICTION_RETAINED_CHILD_MARKED_CURRENT
      || c == ASC_CONTRADICTION_STALE_DOSSIER_MARKED_CURRENT)
      return "high_advisory";
   if(c == ASC_CONTRADICTION_UNAVAILABLE_AS_CLEAN_TRUTH)
      return "unavailable data risks being displayed as clean present truth";
   if(c == ASC_CONTRADICTION_RETAINED_LAST_GOOD_AS_CURRENT)
      return "retained last-good continuity risks being read as fresh current truth";
   if(c == ASC_CONTRADICTION_TRADE_PERMISSION_FALSEHOOD_MISSING)
      return "surface lacks explicit wording that the artifact is not granting trade permission";
   if(c == ASC_CONTRADICTION_ENTRY_SIGNAL_FALSEHOOD_MISSING)
      return "surface lacks explicit wording that the artifact is not an entry signal";
   if(c == ASC_CONTRADICTION_BOARD_TOP_SYMBOL_MISSING_CHILD)
      return "Market Board top-list symbol has no matching GlobalTop10 child artifact identity";
   if(c == ASC_CONTRADICTION_BOARD_RANK_CHILD_RANK_MISMATCH)
      return "Market Board rank and GlobalTop10 child rank disagree";
   if(c == ASC_CONTRADICTION_BOARD_SYMBOL_CHILD_SYMBOL_MISMATCH)
      return "Market Board symbol and GlobalTop10 child symbol disagree";
   if(c == ASC_CONTRADICTION_BOARD_SIGNATURE_CHILD_SIGNATURE_MISMATCH)
      return "GlobalTop10 child does not carry the Market Board signature it claims to derive from";
   if(c == ASC_CONTRADICTION_CHILD_CURRENTNESS_WEAKER_THAN_BOARD)
      return "GlobalTop10 child currentness is weaker than the board-level currentness claim";
   if(c == ASC_CONTRADICTION_CHILD_PARTIAL_BUT_BOARD_COMPLETE)
      return "GlobalTop10 child is partial while the surrounding board/family wording can be read as complete";
   if(c == ASC_CONTRADICTION_DOSSIER_SYMBOL_MISMATCH)
      return "Dossier symbol identity differs from its child/board symbol context";
   if(c == ASC_CONTRADICTION_DOSSIER_SOURCE_RUN_MISMATCH)
      return "Dossier source run identity differs from the active artifact family source run";
   if(c == ASC_CONTRADICTION_DOSSIER_SECTION_INCOMPLETE_BUT_CHILD_COMPLETE)
      return "Dossier section completeness is incomplete while the child/family can be read as complete";
   if(c == ASC_CONTRADICTION_DEEP_PENDING_BUT_BOARD_IMPLIES_DEEP_COMPLETE)
      return "Market Board/family wording can imply deep confirmation while Dossier deep section is pending or degraded";
   if(c == ASC_CONTRADICTION_RETAINED_CHILD_MARKED_CURRENT)
      return "retained GlobalTop10 child continuity risks being treated as fresh current";
   if(c == ASC_CONTRADICTION_STALE_DOSSIER_MARKED_CURRENT)
      return "stale Dossier continuity risks being treated as fresh current";
   return "unclassified advisory contradiction category";
  }

string ASC_ArtifactContradictionSeverity(const string category)
  {
   string c = category;
   StringTrimLeft(c);
   StringTrimRight(c);
   StringToLower(c);

   if(c == ASC_CONTRADICTION_UNAVAILABLE_AS_CLEAN_TRUTH
      || c == ASC_CONTRADICTION_RETAINED_LAST_GOOD_AS_CURRENT
      || c == ASC_CONTRADICTION_TRADE_PERMISSION_FALSEHOOD_MISSING
      || c == ASC_CONTRADICTION_ENTRY_SIGNAL_FALSEHOOD_MISSING
      || c == ASC_CONTRADICTION_PORTFOLIO_HISTORY_ACTIVE_EXPOSURE_CONFUSION)
      return "high_advisory";
   if(c == ASC_CONTRADICTION_MARKET_BOARD_VS_DOSSIER_MISMATCH
      || c == ASC_CONTRADICTION_CURRENT_FOCUS_VS_DOSSIER_MISMATCH
      || c == ASC_CONTRADICTION_SCORE_VS_RANK_MISMATCH
      || c == ASC_CONTRADICTION_DEEP_ANALYSIS_OVERCLAIM)
      return "medium_advisory";
   return "low_advisory";
  }

string ASC_ArtifactContradictionBoundaryLine(const string category)
  {
   return "Contradiction Advisory: category=" + category
          + " | severity=" + ASC_ArtifactContradictionSeverity(category)
          + " | meaning=" + ASC_ArtifactContradictionCategoryMeaning(category)
          + " | status=" + ASC_ALIGNMENT_ADVISORY_ONLY_LABEL
          + " | publication=" + ASC_ALIGNMENT_NON_BLOCKING_LABEL
          + " | trading=" + ASC_ALIGNMENT_NO_TRADE_SIGNAL_LABEL
          + " | ranking=" + ASC_ALIGNMENT_NO_SCORE_RANK_CHANGE_LABEL;
  }

string ASC_ArtifactFieldAlignmentBoundaryLine(const string field_group,
                                              const string source_owner,
                                              const string projection_surface,
                                              const string proof_scope)
  {
   return "Field Alignment: group=" + field_group
          + " | owner=" + source_owner
          + " | projection=" + projection_surface
          + " | proof_scope=" + proof_scope
          + " | proof_meaning=" + ASC_ArtifactProofScopeMeaning(proof_scope)
          + " | status=" + ASC_ALIGNMENT_ADVISORY_ONLY_LABEL
          + " | publication=" + ASC_ALIGNMENT_NON_BLOCKING_LABEL
          + " | trading=" + ASC_ALIGNMENT_NO_TRADE_SIGNAL_LABEL;
  }

string ASC_ArtifactAlignmentContractLine(const string artifact_family_id,
                                         const string artifact_role,
                                         const string board_signature,
                                         const string derived_from_board_signature,
                                         const string child_rank,
                                         const string child_symbol,
                                         const string child_hydration_state,
                                         const string child_currentness_state,
                                         const string dossier_symbol,
                                         const string dossier_section_completeness_state,
                                         const string deep_section_state,
                                         const string alignment_status,
                                         const int alignment_contradiction_count,
                                         const string worst_alignment_contradiction,
                                         const bool requires_operator_review)
  {
   return "RUN092 Alignment Contract: artifact_family_id=" + ASC_TextOrUnavailable(artifact_family_id)
          + " | artifact_role=" + ASC_TextOrUnavailable(artifact_role)
          + " | source_run_id=" + ASC_SourceRunId()
          + " | source_identity_token=" + ASC_SourceIdentityToken()
          + " | artifact_schema_version=" + ASC_ArtifactSchemaVersion()
          + " | board_signature=" + ASC_TextOrUnavailable(board_signature)
          + " | derived_from_board_signature=" + ASC_TextOrUnavailable(derived_from_board_signature)
          + " | child_rank=" + ASC_TextOrUnavailable(child_rank)
          + " | child_symbol=" + ASC_TextOrUnavailable(child_symbol)
          + " | child_hydration_state=" + ASC_TextOrUnavailable(child_hydration_state)
          + " | child_currentness_state=" + ASC_TextOrUnavailable(child_currentness_state)
          + " | dossier_symbol=" + ASC_TextOrUnavailable(dossier_symbol)
          + " | dossier_section_completeness_state=" + ASC_TextOrUnavailable(dossier_section_completeness_state)
          + " | deep_section_state=" + ASC_TextOrUnavailable(deep_section_state)
          + " | alignment_status=" + ASC_TextOrUnavailable(alignment_status)
          + " | alignment_contradiction_count=" + IntegerToString(MathMax(0, alignment_contradiction_count))
          + " | worst_alignment_contradiction=" + ASC_TextOrUnavailable(worst_alignment_contradiction)
          + " | requires_operator_review=" + (requires_operator_review ? "true" : "false")
          + " | trade_signal=false | execution_change=false | rank_order_formula_change=false";
  }

string ASC_ArtifactRun092ContradictionClassCatalogLine()
  {
   return "RUN092 Alignment Contradiction Classes: board_top_symbol_missing_child,board_rank_child_rank_mismatch,board_symbol_child_symbol_mismatch,board_signature_child_signature_mismatch,child_currentness_weaker_than_board,child_partial_but_board_complete,dossier_symbol_mismatch,dossier_source_run_mismatch,dossier_section_incomplete_but_child_complete,deep_pending_but_board_implies_deep_complete,retained_child_marked_current,stale_dossier_marked_current | status=detectable_source_vocabulary | blocking=false | operator_review_required_when_count_positive=true";
  }

string ASC_ArtifactRun093MirrorContradictionClassCatalogLine()
  {
   return "RUN093 Current Focus Mirror Contradiction Classes: selected_symbol_none_but_current_focus_current,selected_symbol_known_but_current_focus_missing,current_focus_symbol_mismatch,current_focus_source_run_mismatch,selected_dossier_source_run_mismatch,current_focus_newer_than_source_dossier_unproven,current_focus_richer_than_source_dossier_unproven,current_focus_thinner_than_source_dossier_without_degradation,source_dossier_partial_but_current_focus_complete,deep_pending_but_current_focus_complete,retained_current_focus_marked_current,stale_current_focus_marked_current,current_focus_truth_owner_drift,mirror_relation_missing,selected_symbol_none_not_failure_missing | status=detectable_source_vocabulary | blocking=false | operator_review_required_when_count_positive=true";
  }

string ASC_DossierCompletenessStateFromPosture(const string posture,const int missing_fields,const bool ran,const bool continuity_used)
  {
   string p = posture;
   StringTrimLeft(p);
   StringTrimRight(p);
   StringToLower(p);
   if(!ran)
      return "absent";
   if(p == "not_applicable")
      return "not_applicable";
   if(StringFind(p, "scaffold") >= 0)
      return "scaffold_only";
   if(continuity_used || StringFind(p, "degraded") >= 0 || StringFind(p, "fallback") >= 0)
      return "degraded";
   if(missing_fields > 0 || StringFind(p, "partial") >= 0 || StringFind(p, "pending") >= 0)
      return "partial";
   if(p == "success" || p == "complete" || p == "current")
      return "complete";
   return "runtime_unproven_until_" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN;
  }

string ASC_ArtifactRun093MirrorContractLine(const string selected_symbol,
                                           const string selected_symbol_state,
                                           const string selected_dossier_symbol,
                                           const string current_focus_symbol,
                                           const string mirror_state,
                                           const string dossier_section_completeness_state,
                                           const string deep_section_state,
                                           const string stale_or_retained_boundary,
                                           const int mirror_contradiction_count,
                                           const string worst_mirror_contradiction,
                                           const bool requires_operator_review)
  {
   return "RUN093 Current Focus Mirror Contract: source_run_id=" + ASC_SourceRunId()
          + " | source_identity_token=" + ASC_SourceIdentityToken()
          + " | artifact_schema_version=" + ASC_ArtifactSchemaVersion()
          + " | selected_symbol=" + ASC_TextOrUnavailable(selected_symbol)
          + " | selected_symbol_state=" + ASC_TextOrUnavailable(selected_symbol_state)
          + " | selected_dossier_symbol=" + ASC_TextOrUnavailable(selected_dossier_symbol)
          + " | selected_dossier_source_run=" + ASC_SourceRunId()
          + " | current_focus_symbol=" + ASC_TextOrUnavailable(current_focus_symbol)
          + " | current_focus_source_run=" + ASC_SourceRunId()
          + " | mirror_source_artifact=selected_symbol_dossier"
          + " | mirror_relation=" + ASC_CURRENT_FOCUS_MIRROR_RELATION_SELECTED_SYMBOL_DOSSIER
          + " | mirror_state=" + ASC_TextOrUnavailable(mirror_state)
          + " | mirror_state_taxonomy=" + ASC_CURRENT_FOCUS_MIRROR_STATE_TAXONOMY
          + " | same_symbol_mirror=" + ASC_CURRENT_FOCUS_SAME_SYMBOL_READBACK_REQUIRED_TRUE
          + " | richer_same_symbol_protection=" + ASC_CURRENT_FOCUS_RICHER_SAME_SYMBOL_PAYLOAD_PRESERVED_TRUE
          + " | current_focus_truth_owner=false | current_focus_derivative_only=" + ASC_CURRENT_FOCUS_DERIVATIVE_ONLY_TRUE
          + " | selected_symbol_none_not_failure=" + ASC_CURRENT_FOCUS_SELECTED_SYMBOL_NONE_NOT_FAILURE_TRUE
          + " | dossier_section_completeness_state=" + ASC_TextOrUnavailable(dossier_section_completeness_state)
          + " | dossier_section_completeness_taxonomy=" + ASC_DOSSIER_SECTION_COMPLETENESS_TAXONOMY
          + " | deep_section_state=" + ASC_TextOrUnavailable(deep_section_state)
          + " | deep_section_state_taxonomy=" + ASC_DEEP_SECTION_STATE_TAXONOMY
          + " | stale_or_retained_boundary=" + ASC_TextOrUnavailable(stale_or_retained_boundary)
          + " | mirror_contradiction_count=" + IntegerToString(MathMax(0, mirror_contradiction_count))
          + " | worst_mirror_contradiction=" + ASC_TextOrUnavailable(worst_mirror_contradiction)
          + " | requires_operator_review=" + (requires_operator_review ? "true" : "false")
          + " | file_exists_is_mirror_proof=false | non_empty_file_is_mirror_proof=false | retained_last_good_is_current=false | stale_is_current=false | partial_is_complete=false | trade_signal=false | execution_change=false | rank_order_formula_change=false";
  }

string ASC_ArtifactHumanizeLabel(const string raw_value)
  {
   string source = raw_value;
   StringTrimLeft(source);
   StringTrimRight(source);
   if(StringLen(source) <= 0)
      return "Unresolved";

   string output = "";
   bool new_word = true;
   for(int i = 0; i < StringLen(source); i++)
     {
      string ch = StringSubstr(source, i, 1);
      if(ch == "_" || ch == "-" || ch == ".")
        {
         output += " ";
         new_word = true;
         continue;
        }

      string lowered = ch;
      StringToLower(lowered);
      if(new_word)
        {
         string uppered = lowered;
         StringToUpper(uppered);
         output += uppered;
         new_word = false;
        }
      else
        {
         output += lowered;
        }
     }

   StringReplace(output, "Fx", "FX");
   StringReplace(output, "Usd", "USD");
   StringReplace(output, "Eur", "EUR");
   StringReplace(output, "Gbp", "GBP");
   StringReplace(output, "Jpy", "JPY");
   StringReplace(output, "Us Stocks", "US Stocks");
   StringReplace(output, "Hk Stocks", "HK Stocks");
   StringReplace(output, "Uk Stocks", "UK Stocks");
   StringReplace(output, "Adr", "ADR");
   StringReplace(output, "Etf", "ETF");
   StringReplace(output, "Etp", "ETP");
   StringReplace(output, "Reit", "REIT");

   return output;
  }

string ASC_MainBucketOperatorNameFromId(const string bucket_id)
  {
   string canonical_bucket_id = bucket_id;
   StringTrimLeft(canonical_bucket_id);
   StringTrimRight(canonical_bucket_id);
   StringToLower(canonical_bucket_id);

   if(!ASC_ClassificationIsSupportedMainBucketId(canonical_bucket_id))
      canonical_bucket_id = ASC_ClassificationMainBucketIdFromName(bucket_id);
   if(!ASC_ClassificationIsSupportedMainBucketId(canonical_bucket_id))
      canonical_bucket_id = "unknown";

   string from_classification = ASC_ClassificationMainBucketName(canonical_bucket_id);
   if(from_classification == "FX")
      return "Forex";
   return from_classification;
  }

bool ASC_TextEndsWith(const string value,const string suffix)
  {
   int value_len = StringLen(value);
   int suffix_len = StringLen(suffix);
   if(suffix_len <= 0 || value_len < suffix_len)
      return false;
   return (StringSubstr(value, value_len - suffix_len, suffix_len) == suffix);
  }

string ASC_CandidateBucketOperatorText(const string candidate_bucket)
  {
   if(StringLen(candidate_bucket) <= 0)
      return "Unassigned";

   string base_bucket = candidate_bucket;
   string posture = "Standard";
   if(ASC_TextEndsWith(base_bucket, "_priority"))
     {
      base_bucket = StringSubstr(base_bucket, 0, StringLen(base_bucket) - 9);
      posture = "Priority Survivor";
     }
   else if(ASC_TextEndsWith(base_bucket, "_guarded"))
     {
      base_bucket = StringSubstr(base_bucket, 0, StringLen(base_bucket) - 8);
      posture = "Guarded Survivor";
     }
   else if(ASC_TextEndsWith(base_bucket, "_watch"))
     {
      base_bucket = StringSubstr(base_bucket, 0, StringLen(base_bucket) - 6);
      posture = "Watch Survivor";
     }

   string bucket_name = ASC_MainBucketOperatorNameFromId(base_bucket);
   if(bucket_name == "Unknown / Needs Review")
      bucket_name = ASC_ArtifactHumanizeLabel(base_bucket);
   return bucket_name + " (" + posture + ")";
  }

string ASC_ArtifactTradeModeText(const long trade_mode)
  {
   if(trade_mode == SYMBOL_TRADE_MODE_DISABLED)   return "disabled";
   if(trade_mode == SYMBOL_TRADE_MODE_LONGONLY)   return "long only";
   if(trade_mode == SYMBOL_TRADE_MODE_SHORTONLY)  return "short only";
   if(trade_mode == SYMBOL_TRADE_MODE_CLOSEONLY)  return "close only";
   if(trade_mode == SYMBOL_TRADE_MODE_FULL)       return "full";
   return "unavailable";
  }

string ASC_ArtifactExecutionModeText(const long execution_mode)
  {
   if(execution_mode == SYMBOL_TRADE_EXECUTION_REQUEST)  return "request";
   if(execution_mode == SYMBOL_TRADE_EXECUTION_INSTANT)  return "instant";
   if(execution_mode == SYMBOL_TRADE_EXECUTION_MARKET)   return "market";
   if(execution_mode == SYMBOL_TRADE_EXECUTION_EXCHANGE) return "exchange";
   return "unavailable";
  }

string ASC_ValueOrUnavailable(const bool available,const double value,const int digits)
  {
   return available ? DoubleToString(value, digits) : "unavailable";
  }

string ASC_TextOrUnavailable(const string value)
  {
   return (StringLen(value) > 0) ? value : "unavailable";
  }


// RUN236 publication resilience: required-token validation remains active, but
// missing non-write/data sections are emitted as truthful status so publication
// visibility is not suppressed by a diagnostic/data gap.
string ASC_PublicationResilienceSanitizeToken(const string token_raw)
  {
   string token = token_raw;
   StringReplace(token, "\r", " ");
   StringReplace(token, "\n", " ");
   StringReplace(token, "|", "/");
   StringTrimLeft(token);
   StringTrimRight(token);
   return (StringLen(token) > 0 ? token : "unavailable_token");
  }

string ASC_PublicationResilienceMissingTokenList(const string text,
                                                 const string &required_tokens[],
                                                 int &missing_count_out,
                                                 string &first_missing_out)
  {
   missing_count_out = 0;
   first_missing_out = "none";
   string missing_list = "";

   for(int i = 0; i < ArraySize(required_tokens); i++)
     {
      string token = required_tokens[i];
      if(StringLen(token) <= 0)
         continue;
      if(StringFind(text, token) >= 0)
         continue;

      string sanitized = ASC_PublicationResilienceSanitizeToken(token);
      if(missing_count_out == 0)
         first_missing_out = sanitized;
      if(StringLen(missing_list) > 0)
         missing_list += ";";
      missing_list += sanitized;
      missing_count_out++;
     }

   if(missing_count_out <= 0)
      return "none";
   return missing_list;
  }

string ASC_PublicationResilienceStatusFromMissingCount(const int missing_count)
  {
   if(missing_count <= 0)
      return "complete";
   return "complete_with_degraded_sections";
  }

string ASC_PublicationResilienceBlock(const string text,
                                      const string &required_tokens[],
                                      const string artifact_scope,
                                      const string owner_summary,
                                      const string reason_summary,
                                      const bool retry_due_next_refresh)
  {
   int missing_count = 0;
   string first_missing = "none";
   string missing_list = ASC_PublicationResilienceMissingTokenList(text,
                                                                  required_tokens,
                                                                  missing_count,
                                                                  first_missing);
   string publication_status = ASC_PublicationResilienceStatusFromMissingCount(missing_count);
   string data_quality_status = (missing_count <= 0 ? "review_only_no_missing_required_tokens_observed" : "degraded");
   string retry_due = (retry_due_next_refresh ? "true" : "false");

   string block = "\nPUBLICATION_RESILIENCE_BEGIN\n";
   block += "publication_resilience_version=RUN236_v1\n";
   block += "publication_resilience_scope=" + ASC_TextOrUnavailable(artifact_scope) + "\n";
   block += "publication_status=" + publication_status + "\n";
   block += "data_quality_status=" + data_quality_status + "\n";
   block += "publication_blocks_operator_visibility=false\n";
   block += "publication_failure_is_file_write_only=true\n";
   block += "missing_data_blocks_trade=true\n";
   block += "missing_data_blocks_file_publication=false\n";
   block += "validation_deleted=false\n";
   block += "validation_mode=status_not_suppressor\n";
   block += "required_token_failure_policy=emit_missing_token_status_not_suppress_file\n";
   block += "missing_required_for_publication=" + missing_list + "\n";
   block += "missing_required_for_review=" + missing_list + "\n";
   block += "missing_required_for_trade=" + missing_list + "\n";
   block += "missing_owner_summary=" + ASC_TextOrUnavailable(owner_summary) + "\n";
   block += "missing_reason_summary=" + ASC_TextOrUnavailable(reason_summary) + "\n";
   block += "missing_token_count=" + IntegerToString(MathMax(0, missing_count)) + "\n";
   block += "first_missing_token=" + first_missing + "\n";
   block += "retry_due_next_refresh=" + retry_due + "\n";
   block += "file_write_failure_reason=none_before_write\n";
   block += "trade_permission=false\n";
   block += "signal_permission=false\n";
   block += "execution_permission=false\n";
   block += "risk_permission=false\n";
   block += "PUBLICATION_RESILIENCE_END\n";
   return block;
  }

// RUN227 root proof surface restore: shared proof-bundle helper lines used by
// ScannerStatusWriter and Dispatcher. These helpers are text-only contracts;
// they do not mutate output files, close proof, or create runtime authority.
string ASC_MissingRuntimeSurfaceClassificationLine()
  {
   return "missing_runtime_surface_classification=missing_runtime_surface"
          + " | runtime_surface_classification=source_patch_runtime_unproven"
          + " | runtime_surface_classification_reason=source_patch_only_compile_and_live_runtime_pending"
          + " | missing_runtime_surface=runtime_capture_not_supplied_in_source_run"
          + " | required_surfaces=compile_output,experts_log,journal_log,broker_server_session_note,final_route_surfaces,staging_route_surfaces,archive_route_surfaces,manifest,scanner_status,function_results"
          + " | optional_surfaces=operator_screenshots,manual_notes"
          + " | deferred_surfaces=runtime_output_package_review"
          + " | lawful_not_applicable_surfaces=signals,trades,execution,risk,prop_firm_permission"
          + " | unknown_policy_surfaces=none"
          + " | missing_required_count=runtime_unproven"
          + " | missing_optional_count=runtime_unproven"
          + " | first_missing_required_surface=runtime_capture_not_supplied_in_source_run"
          + " | first_failure_reason=source_patch_only_compile_requires_metaeditor_rerun"
          + " | proof_bundle_complete=false"
          + " | runtime_surface_required_tokens_present=unknown_until_writer_contract_check"
          + " | runtime_surface_missing_tokens=runtime_capture_not_supplied_in_source_run"
          + " | proof_policy_only_no_fake_pass_no_output_mutation=true";
  }

string ASC_ProofBundleDecisionMappingLine()
  {
   return "proof_bundle_decision_mapping=source_patch_runtime_unproven_to_TEST_FIRST"
          + " | proof_bundle_decision_mapping_reason=source_patch_only_compile_and_live_runtime_pending"
          + " | proof_bundle_complete=false"
          + " | proof_bundle_required_complete=false"
          + " | proof_bundle_optional_complete=false"
          + " | proof_bundle_first_failure_reason=runtime_capture_not_supplied_in_source_run"
          + " | proof_bundle_decision=compile_repair_then_rerun_metaeditor"
          + " | proof_bundle_policy_boundary=proof_policy_only_no_fake_pass_no_output_mutation";
  }

string ASC_RuntimeCaptureChecklistBlock()
  {
   string block = "Runtime Proof Bundle Capture Checklist: compile_output=required_after_patch";
   block += " | runtime_capture_checklist_alias=Runtime Capture Checklist";
   block += " | UPLOAD_ROOT_REQUIRED=server_root_or_export_root";
   block += " | experts_log=required_for_live_proof";
   block += " | journal_log=required_for_live_proof";
   block += " | broker_server_session_note=required_for_live_proof";
   block += " | final_route_surfaces=required_read_only_in_live_proof";
   block += " | staging_route_surfaces=required_read_only_in_live_proof";
   block += " | archive_route_surfaces=required_read_only_in_live_proof";
   block += " | manifest_scanner_function_results=required_read_only_in_live_proof";
   block += " | no_output_mutation=true";
   block += " | no_signal_trade_execution_risk_permission=true";
   block += "\n";
   return block;
  }

string ASC_BoardPublishOutcomeClass(const string publish_result)
  {
   string outcome = publish_result;
   StringTrimLeft(outcome);
   StringTrimRight(outcome);
   StringToLower(outcome);

   if(StringLen(outcome) <= 0)
      return "unresolved";
   return outcome;
  }

string ASC_BoardBaselineAdvanceState(const string publish_result)
  {
   string outcome = ASC_BoardPublishOutcomeClass(publish_result);
   if(outcome == "fresh")
      return "advanced";
   if(outcome == "unchanged"
      || outcome == "continuity"
      || outcome == "skipped"
      || outcome == "pending"
      || outcome == "degraded"
      || outcome == "failure")
      return "preserved";
   return "unresolved";
  }

string ASC_BoardBaselineAdvanceReason(const string publish_result,
                                      const string skip_reason)
  {
   string outcome = ASC_BoardPublishOutcomeClass(publish_result);
   if(outcome == "fresh")
      return "new Market Board baseline promoted for this bundle";
   if(outcome == "unchanged")
      return "recompute confirmed no material board change; last promoted board baseline was retained";
   if(outcome == "continuity")
      return "continuity publish retained the prior last-good board baseline";
   if(outcome == "skipped")
      return StringFormat("new board promote was skipped; last confirmed board baseline remains active | skip_reason=%s",
                          ASC_TextOrUnavailable(skip_reason));
   if(outcome == "pending")
      return "current bundle is still awaiting explicit board baseline confirmation";
   if(outcome == "degraded")
      return "current bundle is degraded; last confirmed board baseline remains active";
   if(outcome == "failure")
      return "current board promote failed; any surviving board baseline must come from prior last-good state";
   return "board baseline advance reason is unresolved";
  }

string ASC_BoardPublishReasonTrace(const string publish_result,
                                   const string refresh_trigger,
                                   const string skip_reason)
  {
   string outcome = ASC_BoardPublishOutcomeClass(publish_result);
   string trigger = ASC_TextOrUnavailable(refresh_trigger);
   string skip = ASC_TextOrUnavailable(skip_reason);
   string baseline = ASC_BoardBaselineAdvanceState(publish_result);

   if(outcome == "fresh")
      return StringFormat("trigger=%s | outcome=fresh | baseline=%s | decision=new_board_baseline_promoted",
                          trigger,
                          baseline);
   if(outcome == "unchanged")
      return StringFormat("trigger=%s | outcome=unchanged | baseline=%s | decision=no_material_change_baseline_retained | skip_reason=%s",
                          trigger,
                          baseline,
                          skip);
   if(outcome == "continuity")
      return StringFormat("trigger=%s | outcome=continuity | baseline=%s | decision=last_good_board_baseline_retained",
                          trigger,
                          baseline);
   if(outcome == "skipped")
      return StringFormat("trigger=%s | outcome=skipped | baseline=%s | decision=board_promote_skipped | skip_reason=%s",
                          trigger,
                          baseline,
                          skip);
   if(outcome == "pending")
      return StringFormat("trigger=%s | outcome=pending | baseline=%s | decision=awaiting_board_confirmation | skip_reason=%s",
                          trigger,
                          baseline,
                          skip);
   if(outcome == "degraded")
      return StringFormat("trigger=%s | outcome=degraded | baseline=%s | decision=backoff_or_degraded_hold | skip_reason=%s",
                          trigger,
                          baseline,
                          skip);
   if(outcome == "failure")
      return StringFormat("trigger=%s | outcome=failure | baseline=%s | decision=publish_failed | skip_reason=%s",
                          trigger,
                          baseline,
                          skip);
   return StringFormat("trigger=%s | outcome=%s | baseline=%s | skip_reason=%s",
                       trigger,
                       outcome,
                       baseline,
                       skip);
  }

string ASC_TruthLabelApproximation(const bool has_value,const string value)
  {
   if(!has_value || StringLen(value) <= 0)
      return "unavailable";
   return value + " (estimate)";
  }

string ASC_TruthLabelPlaceholderSummary(const bool has_value,const string value)
  {
   if(!has_value || StringLen(value) <= 0)
      return "unavailable";
   return value + " (summary)";
  }

string ASC_BrokerDescriptorTrustPostureLabel(const string trust_posture)
  {
   string posture = trust_posture;
   StringToLower(posture);
   if(posture == "broker-supplied")
      return "broker-supplied (unverified)";
   return "unavailable";
  }

string ASC_BrokerDescriptorSummaryLabel(const ASC_BrokerDescriptors &descriptors)
  {
   string summary = ASC_BrokerDescriptorsCompactText(descriptors);
   if(summary == "unavailable")
      return "unavailable";
   return summary + " | trust posture " + ASC_BrokerDescriptorTrustPostureLabel(descriptors.trust_posture);
  }

string ASC_SectionMetadataBlock(const string publication_state,
                                const string state_reason,
                                const string source_age_ms,
                                const string continuity_state,
                                const datetime last_refreshed_at)
  {
   string block = "";
   block += "State: " + ASC_TextOrUnavailable(publication_state) + "\n";
   block += "Source Note: " + ASC_TextOrUnavailable(state_reason) + "\n";
   block += "Source Age (ms): " + ASC_TextOrUnavailable(source_age_ms) + "\n";
   block += "Continuity: " + ASC_TextOrUnavailable(continuity_state) + "\n";
   block += "Refreshed (UTC): " + ASC_ArtifactFormatUtc(last_refreshed_at) + "\n";
   return block;
  }

string ASC_SelectionReasonToOperatorText(const string reason)
  {
   if(reason == "market-state disqualifier" || reason == "market is not open" || reason == "market_not_open")
      return "market is closed; awaiting the next open window";
   if(reason == "classification dependency" || reason == "classification unresolved" || reason == "classification_unresolved")
      return "awaiting resolved classification";
   if(reason == "freshness dependency" || reason == "upstream data stale" || reason == "upstream_stale")
      return "awaiting fresh market snapshot";
   if(reason == "upstream data degraded" || reason == "upstream_degraded")
      return "market-state inputs are degraded";
   if(reason == "confidence disqualifier" || reason == "market-state confidence is too low" || reason == "confidence_too_low")
      return "market-state confidence is too low";
   if(reason == "corroboration dependency" || reason == "market watch is unavailable" || reason == "market_watch_unavailable")
      return "awaiting live market watch snapshot";
   if(reason == "market_watch_continuity")
      return "market watch is continuity-backed";
   if(reason == "market_watch_stale")
      return "market watch freshness is not yet acceptable";
   if(reason == "trading_permission_unavailable")
      return "trade mode owner truth is unavailable";
   if(reason == "trading_permission_restricted")
      return "trade mode is currently restricted; score carry stays guarded";
   if(reason == "trading_permission_blocked")
      return "trade mode is currently restricted";
   if(reason == "specification_unavailable")
      return "awaiting broker specification readiness";
   if(reason == "specification_stale")
      return "specification owner truth is stale";
   if(reason == "specification_degraded")
      return "specification owner truth is degraded";
   if(reason == "spread_out_of_bounds")
      return "spread is above the preferred carry range";
   if(reason == "candidate-filter dependencies satisfied" || reason == "candidate checks satisfied")
      return "candidate scoring inputs are ready";
   if(reason == "candidate_checks_satisfied" || reason == "gate_checks_satisfied")
      return "candidate scoring inputs are ready";
   if(StringLen(reason) <= 0)
      return "selection reason unavailable";
   return reason;
  }

int ASC_CountOpenPositionsForSymbol(const string symbol)
  {
   int count = 0;
   for(int i = 0; i < PositionsTotal(); i++)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
         continue;
      if(PositionGetString(POSITION_SYMBOL) == symbol)
         count++;
     }
   return count;
  }

int ASC_CountPendingOrdersForSymbol(const string symbol)
  {
   int count = 0;
   for(int i = 0; i < OrdersTotal(); i++)
     {
      ulong ticket = OrderGetTicket(i);
      if(ticket == 0)
         continue;
      if(OrderGetString(ORDER_SYMBOL) != symbol)
         continue;
      ENUM_ORDER_STATE state = (ENUM_ORDER_STATE)OrderGetInteger(ORDER_STATE);
      if(state == ORDER_STATE_PLACED || state == ORDER_STATE_PARTIAL)
         count++;
     }
   return count;
  }

int ASC_TotalOpenTrades()
  {
   return PositionsTotal();
  }

int ASC_TotalPendingOrders()
  {
   int count = 0;
   for(int i = 0; i < OrdersTotal(); i++)
     {
      ulong ticket = OrderGetTicket(i);
      if(ticket == 0)
         continue;
      ENUM_ORDER_STATE state = (ENUM_ORDER_STATE)OrderGetInteger(ORDER_STATE);
      if(state == ORDER_STATE_PLACED || state == ORDER_STATE_PARTIAL)
         count++;
     }
   return count;
  }

double ASC_OpenPendingConflictValue(const string symbol,int &open_positions,int &pending_orders)
  {
   open_positions = ASC_CountOpenPositionsForSymbol(symbol);
   pending_orders = ASC_CountPendingOrdersForSymbol(symbol);
   return (double)(open_positions + pending_orders);
  }

string ASC_ConflictCountsText(const int open_positions,const int pending_orders)
  {
   return IntegerToString(open_positions) + "/" + IntegerToString(pending_orders);
  }

string ASC_CorrelationConflictInterpretation(const double correlation_score,
                                             const int open_positions,
                                             const int pending_orders)
  {
   if(open_positions > 0 && pending_orders > 0)
      return "open and pending orders already exist on this symbol";
   if(open_positions > 0)
      return "open position already exists on this symbol";
   if(pending_orders > 0)
      return "pending order already exists on this symbol";
   if(correlation_score >= 0.70)
      return "high correlation concentration";
   if(correlation_score >= 0.40)
      return "moderate correlation concentration";
   return "low correlation concentration";
  }

string ASC_CorrelationExposureInterpretation(const double correlation_score,
                                             const int open_positions,
                                             const int pending_orders)
  {
   int conflict_total = open_positions + pending_orders;
   if(conflict_total >= 2)
      return "Exposure crowded";
   if(conflict_total == 1)
      return "Exposure watch";
   if(correlation_score >= 0.70)
      return "Exposure crowded";
   if(correlation_score >= 0.40)
      return "Exposure watch";
   return "Exposure contained";
  }

string ASC_CorrelationPeerWithValue(const string symbol,const double value)
  {
   string peer = symbol;
   if(StringLen(peer) <= 0)
      peer = "n/a";
   return peer + " " + DoubleToString(value, 2);
  }

string ASC_CorrelationConflictInterpretationState(const bool correlation_available,
                                                  const double correlation_score,
                                                  const int open_positions,
                                                  const int pending_orders)
  {
   if(open_positions > 0 && pending_orders > 0)
      return "open and pending orders already exist on this symbol";
   if(open_positions > 0)
      return "open position already exists on this symbol";
   if(pending_orders > 0)
      return "pending order already exists on this symbol";
   if(!correlation_available)
      return "correlation not computed in the ordinary Layer-4 hot path";
   if(correlation_score >= 0.70)
      return "high correlation concentration";
   if(correlation_score >= 0.40)
      return "moderate correlation concentration";
   return "low correlation concentration";
  }

string ASC_CorrelationExposureInterpretationState(const bool correlation_available,
                                                  const double correlation_score,
                                                  const int open_positions,
                                                  const int pending_orders)
  {
   int conflict_total = open_positions + pending_orders;
   if(conflict_total >= 2)
      return "Exposure crowded";
   if(conflict_total == 1)
      return "Exposure watch";
   if(!correlation_available)
      return "Exposure held by direct conflicts only";
   if(correlation_score >= 0.70)
      return "Exposure crowded";
   if(correlation_score >= 0.40)
      return "Exposure watch";
   return "Exposure contained";
  }

string ASC_CorrelationCompactLine(const string anchor_symbol,
                                  const double average_score,
                                  const string high_a_symbol,
                                  const double high_a_score,
                                  const string high_b_symbol,
                                  const double high_b_score,
                                  const string low_a_symbol,
                                  const double low_a_score,
                                  const string low_b_symbol,
                                  const double low_b_score)
  {
   bool has_peer_support = (high_a_symbol != "n/a" || high_b_symbol != "n/a" || low_a_symbol != "n/a" || low_b_symbol != "n/a");
   string correlation_value = has_peer_support ? DoubleToString(average_score, 2) : "unavailable";
   string high_line = has_peer_support
                      ? (ASC_CorrelationPeerWithValue(high_a_symbol, high_a_score) + ", " + ASC_CorrelationPeerWithValue(high_b_symbol, high_b_score))
                      : "n/a";
   string low_line = has_peer_support
                     ? (ASC_CorrelationPeerWithValue(low_a_symbol, low_a_score) + ", " + ASC_CorrelationPeerWithValue(low_b_symbol, low_b_score))
                     : "n/a";
   return StringFormat("True Market Correlation %s | Closest Peers %s | Farthest Peers %s",
                       correlation_value,
                       high_line,
                       low_line);
  }

struct ASC_ArtifactAccountSnapshot
  {
   double balance;
   double equity;
   double free_margin;
   double used_margin;
   double margin_level;
   double open_risk_estimate;
   int open_trades;
   int pending_orders;
   bool balance_available;
   bool equity_available;
   bool free_margin_available;
   bool used_margin_available;
   bool margin_level_available;
   bool open_risk_available;
   bool open_risk_partial;
   string exposure_note;
  };

string ASC_PositionDirectionText(const ENUM_POSITION_TYPE position_type)
  {
   if(position_type == POSITION_TYPE_BUY)
      return "buy";
   if(position_type == POSITION_TYPE_SELL)
      return "sell";
   return "unavailable";
  }

string ASC_OrderDirectionText(const ENUM_ORDER_TYPE order_type)
  {
   if(order_type == ORDER_TYPE_BUY || order_type == ORDER_TYPE_BUY_LIMIT || order_type == ORDER_TYPE_BUY_STOP || order_type == ORDER_TYPE_BUY_STOP_LIMIT)
      return "buy";
   if(order_type == ORDER_TYPE_SELL || order_type == ORDER_TYPE_SELL_LIMIT || order_type == ORDER_TYPE_SELL_STOP || order_type == ORDER_TYPE_SELL_STOP_LIMIT)
      return "sell";
   return "unavailable";
  }

double ASC_EstimatePositionRiskValue(const string symbol,
                                     const double volume,
                                     const double open_price,
                                     const double stop_loss,
                                     bool &available)
  {
   available = false;
   if(StringLen(symbol) <= 0 || volume <= 0.0 || open_price <= 0.0 || stop_loss <= 0.0)
      return 0.0;

   double tick_size = 0.0;
   double tick_value = 0.0;

   ASC_Layer2Packet packet;
   bool has_layer2_packet = ASC_Layer2TryGetPacketBySymbol(symbol, packet);
   if(has_layer2_packet && packet.valid_tick_size && packet.valid_tick_value)
     {
      tick_size = packet.tick_size;
      tick_value = packet.tick_value;
     }
   else
     {
      if(!SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE, tick_size))
         return 0.0;
      if(!SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE, tick_value))
         return 0.0;
     }

   if(tick_size <= 0.0 || tick_value <= 0.0)
      return 0.0;

   double price_distance = MathAbs(open_price - stop_loss);
   if(price_distance <= 0.0)
      return 0.0;

   available = true;
   return (price_distance / tick_size) * tick_value * volume;
  }

void ASC_BuildAccountSnapshot(ASC_ArtifactAccountSnapshot &snapshot)
  {
   snapshot.balance = AccountInfoDouble(ACCOUNT_BALANCE);
   snapshot.equity = AccountInfoDouble(ACCOUNT_EQUITY);
   snapshot.free_margin = AccountInfoDouble(ACCOUNT_MARGIN_FREE);
   snapshot.used_margin = AccountInfoDouble(ACCOUNT_MARGIN);
   snapshot.margin_level = AccountInfoDouble(ACCOUNT_MARGIN_LEVEL);
   snapshot.open_trades = ASC_TotalOpenTrades();
   snapshot.pending_orders = ASC_TotalPendingOrders();
   snapshot.open_risk_estimate = 0.0;
   snapshot.balance_available = true;
   snapshot.equity_available = true;
   snapshot.free_margin_available = true;
   snapshot.used_margin_available = true;
   snapshot.margin_level_available = (snapshot.used_margin > 0.0);
   snapshot.open_risk_available = (snapshot.open_trades == 0);
   snapshot.open_risk_partial = false;
   snapshot.exposure_note = "No active account exposure.";

   bool missing_stop_or_specs = false;

   for(int i = 0; i < PositionsTotal(); i++)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
         continue;

      string symbol = PositionGetString(POSITION_SYMBOL);
      double volume = PositionGetDouble(POSITION_VOLUME);
      double open_price = PositionGetDouble(POSITION_PRICE_OPEN);
      double stop_loss = PositionGetDouble(POSITION_SL);

      bool risk_available = false;
      double risk_value = ASC_EstimatePositionRiskValue(symbol, volume, open_price, stop_loss, risk_available);
      if(risk_available)
        {
         snapshot.open_risk_estimate += risk_value;
         snapshot.open_risk_available = true;
        }
      else
        {
         missing_stop_or_specs = true;
        }
     }

   if(snapshot.open_trades > 0 || snapshot.pending_orders > 0)
      snapshot.exposure_note = "Account has active trade exposure.";
   if(snapshot.pending_orders > 0 && snapshot.open_trades <= 0)
      snapshot.exposure_note = "Account has pending-order exposure only.";
   if(snapshot.open_trades > 0 && snapshot.pending_orders > 0)
      snapshot.exposure_note = "Account has open-trade and pending-order exposure.";

   if(missing_stop_or_specs)
     {
      snapshot.open_risk_partial = true;
      if(snapshot.open_risk_available)
         snapshot.exposure_note += " Open risk estimate excludes positions without a usable stop or pricing spec.";
      else
         snapshot.exposure_note += " Open risk estimate is unavailable because one or more positions lack a usable stop or pricing spec.";
     }
  }


string ASC_TraderChatAggregateTokens()
  {
   return "trader_chat_packet_enabled=true | retrieval_pack_enabled=true | market_board_to_dossier_workflow_enabled=true | selected_current_required_for_actionability=true | trader_chat_packet_per_symbol_rows=false | trader_chat_packet_proof_spam_avoided=true";
  }


string ASC_Phase5HorizonTaxonomySourceReady()
  {
   return "phase5_horizon_taxonomy_source_ready=true | horizon_taxonomy=" + ASC_PHASE5_HORIZON_TAXONOMY;
  }

string ASC_Phase5PermissionVocabularySourceReady()
  {
   return "phase5_permission_vocabulary_source_ready=true | permission_taxonomy=" + ASC_PHASE5_PERMISSION_STATE_TAXONOMY + " | blocker_taxonomy=" + ASC_PHASE5_BLOCKER_LIMITER_TAXONOMY;
  }

string ASC_Phase5SetupModeVocabularySourceReady()
  {
   return "phase5_setup_mode_vocabulary_source_ready=true | setup_mode_taxonomy=" + ASC_PHASE5_SETUP_MODE_TAXONOMY;
  }

string ASC_Phase5SafetyBoundaryVocabularySourceReady()
  {
   return "phase5_safety_boundary_vocabulary_source_ready=true | safety_boundary_taxonomy=" + ASC_PHASE5_SAFETY_BOUNDARY_TAXONOMY;
  }

string ASC_Phase5EdgeGateVocabularySourceReady()
  {
   return "phase5_siam_edge_gate_vocabulary_source_ready=true | edge_gate_taxonomy=" + ASC_PHASE5_EDGE_GATE_TAXONOMY;
  }

string ASC_Phase5NoSignalBoundaryText()
  {
   return "Review context only. Ranking is not trade permission. Dossier freshness and sync are required before interpretation. Horizon context is not entry timing. Setup mode is review vocabulary, not a signal. Sample-insufficient evidence caps confidence. Spread/friction risk blocks permission context. Correlation cluster requires review. Missing dossier blocks deep review.";
  }

string ASC_Phase5ExecutionBoundaryTokens()
  {
   return "phase5_execution_enabled=false | phase5_buy_sell_output=false | no_entry_output=true | no_direction_output=true | no_order_output=true | no_lot_output=true | no_sl_tp_output=true | scanner_context_only=true";
  }

string ASC_Phase5PermissionGuardTokens()
  {
   return "rank_is_not_permission=true | dossier_required_for_permission_context=true | sync_required_for_permission_context=true | selected_current_required_for_actionability=true | sample_insufficient_caps_confidence=true | spread_risk_blocks_permission_context=true | correlation_cluster_review_required=true | missing_dossier_blocks_deep_review=true";
  }

string ASC_Phase5PermissionOutputStateTaxonomyLine()
  {
   return "phase5_permission_output_states=" + ASC_PHASE5_PERMISSION_OUTPUT_STATE_TAXONOMY;
  }

string ASC_Phase5StrategyPermissionGateTaxonomyLine()
  {
   return "phase5_strategy_permission_gates=" + ASC_PHASE5_STRATEGY_PERMISSION_GATE_TAXONOMY;
  }

string ASC_Phase5StrategyPermissionSystemSourceReadyLine()
  {
   return ASC_PHASE5_PERMISSION_SYSTEM_SOURCE_READY
          + " | permission_system_live_proof=false"
          + " | strategy_execution_enabled=false"
          + " | permission_context_only=true"
          + " | " + ASC_Phase5PermissionOutputStateTaxonomyLine()
          + " | " + ASC_Phase5StrategyPermissionGateTaxonomyLine();
  }

string ASC_Phase5StrategyPermissionGateSummaryLine()
  {
   return "Strategy Permission Gate Summary: sync_gate=required | dossier_presence_gate=required | dossier_role_freshness_gate=required | currentness_tick_evidence_gate=required | sample_sufficiency_gate=limits_confidence | spread_friction_gate=can_block | correlation_cluster_gate=review_required | setup_mode_gate=review_vocabulary_only | horizon_context_gate=context_only | no_signal_boundary_gate=always_active";
  }

string ASC_Phase5StrategyPermissionBoundaryLine()
  {
   return "Strategy Permission Boundary: " + ASC_PHASE5_PERMISSION_CONTEXT_ONLY_TEXT
          + " | " + ASC_PHASE5_PERMISSION_GATE_BOUNDARY_TEXT
          + " | " + ASC_Phase5ExecutionBoundaryTokens();
  }

string ASC_Phase5StrategyPermissionStateLine()
  {
   return "permission_context_default=permission_review_only | ready_state_requires_all_gates=true | blocked_states=sync_mismatch,missing_dossier,role_mismatch,stale_dossier,spread_risk,currentness_unproven | limited_states=sample_insufficient,correlation_cluster | pending_state=permission_pending_refresh | insufficient_state=permission_insufficient_evidence | rank_attention_only=true";
  }

string ASC_Phase5SiamEdgeGateLine()
  {
   return "siam_edge_debt_gated=true | board_dossier_alignment_gate=permission_blocked_sync_mismatch | missing_dossier_gate=permission_blocked_missing_dossier | role_freshness_gate=permission_blocked_role_mismatch_or_stale_dossier | fakeout_bait_gate=setup_mode_insufficient_evidence | pullback_context=permission_review_pullback_preferred | crypto_friction_gate=permission_blocked_spread_risk | sample_gate=permission_limited_sample_insufficient | correlation_gate=permission_limited_correlation_cluster | pending_expiry_gate=future_roadmap_only | rank_compression_guard=rank_is_not_permission";
  }

string ASC_Phase5SourceReadyProofLine()
  {
   return ASC_Phase5HorizonTaxonomySourceReady()
          + " | " + ASC_Phase5SetupModeVocabularySourceReady()
          + " | " + ASC_Phase5PermissionVocabularySourceReady()
          + " | " + ASC_Phase5SafetyBoundaryVocabularySourceReady()
          + " | " + ASC_Phase5EdgeGateVocabularySourceReady()
          + " | " + ASC_Phase5ExecutionBoundaryTokens()
          + " | " + ASC_Phase5PermissionGuardTokens()
          + " | " + ASC_Phase5StrategyPermissionSystemSourceReadyLine();
  }


string ASC_Phase6RegimeContextVocabularySourceReady()
  {
   return "phase6_regime_context_vocabulary_source_ready=true | regime_context_taxonomy=" + ASC_PHASE6_REGIME_CONTEXT_TAXONOMY;
  }

string ASC_Phase6StrategySetupVocabularySourceReady()
  {
   return "phase6_strategy_setup_vocabulary_source_ready=true | strategy_setup_taxonomy=" + ASC_PHASE6_STRATEGY_SETUP_TAXONOMY;
  }

string ASC_Phase6CompatibilityStateVocabularySourceReady()
  {
   return "phase6_regime_compatibility_states_source_ready=true | compatibility_state_taxonomy=" + ASC_PHASE6_COMPATIBILITY_STATE_TAXONOMY;
  }

string ASC_Phase6BlockerLimiterVocabularySourceReady()
  {
   return "phase6_regime_blocker_limiter_source_ready=true | blocker_limiter_taxonomy=" + ASC_PHASE6_BLOCKER_LIMITER_TAXONOMY;
  }

string ASC_Phase6SafetyBoundaryVocabularySourceReady()
  {
   return "phase6_safety_boundary_source_ready=true | safety_boundary_taxonomy=" + ASC_PHASE6_SAFETY_BOUNDARY_TAXONOMY;
  }

string ASC_Phase6SafetyBoundaryLine()
  {
   return "Phase 6 Regime Compatibility Boundary: "
          + string(ASC_PHASE6_SOURCE_READY_TOKEN)
          + " | " + ASC_PHASE6_STRATEGY_REQUIRES_REGIME_TOKEN
          + " | setup_label_requires_regime_support=true"
          + " | " + ASC_PHASE6_CONFLICT_BLOCKS_PERMISSION_TOKEN
          + " | " + ASC_PHASE6_REGIME_LABEL_NOT_SIGNAL_TOKEN
          + " | review_context_only=true | no_execution=true | phase6_execution_enabled=false";
  }

string ASC_Phase6PermissionGateExtensionLine()
  {
   return "Phase 6 Permission Gate Extension: " + ASC_PHASE6_PERMISSION_GATE_EXTENSION;
  }

string ASC_Phase6CompatibilityRulesLine()
  {
   return "Phase 6 Compatibility Rules: " + ASC_PHASE6_COMPATIBILITY_RULES;
  }

string ASC_Phase6RegimeGateWiringSummaryLine()
  {
   return string(ASC_PHASE6_GATE_WIRING_SOURCE_READY_TOKEN)
          + " | " + ASC_PHASE6_LIVE_PROOF_CLAIM_FALSE_TOKEN
          + " | " + ASC_PHASE6_REGIME_LABEL_NOT_SIGNAL_TOKEN
          + " | " + ASC_PHASE6_STRATEGY_REQUIRES_REGIME_TOKEN
          + " | " + ASC_PHASE6_SETUP_REQUIRES_REGIME_TOKEN
          + " | " + ASC_PHASE6_CONFLICT_BLOCKS_PERMISSION_TOKEN
          + " | " + ASC_PHASE6_UNKNOWN_REGIME_BLOCKS_CLEAN_PERMISSION_TOKEN
          + " | " + ASC_PHASE6_STALE_REGIME_PENDING_REFRESH_TOKEN
          + " | " + ASC_PHASE6_CURRENTNESS_UNPROVEN_LIMITS_PERMISSION_TOKEN
          + " | " + ASC_PHASE6_SAMPLE_INSUFFICIENT_CAPS_CONFIDENCE_TOKEN
          + " | " + ASC_PHASE6_LOW_LIQUIDITY_LIMITS_STRATEGY_TOKEN;
  }


string ASC_Phase6SourceLockSummaryLine()
  {
   return string(ASC_PHASE6_SOURCE_LOCKED_TOKEN)
          + " | " + ASC_PHASE6_LIVE_PROOF_REQUIRED_TOKEN
          + " | " + ASC_PHASE6_REGIME_GATE_SURFACE_READY_TOKEN
          + " | " + ASC_PHASE6_SOURCE_LOCK_STATUS_TOKEN
          + " | " + ASC_PHASE6_SOURCE_ONLY_CLOSE_ALLOWED_TOKEN
          + " | " + ASC_PHASE6_EXECUTION_DISABLED_TOKEN
          + " | " + ASC_PHASE6_RUN140_CONTRACT_TOKEN
          + " | " + ASC_PHASE6_LIVE_PROOF_CLAIM_FALSE_TOKEN;
  }

string ASC_Phase6Run140LiveContractSummaryLine()
  {
   return "RUN140 Phase 6 Live Contract: source_identity_visible=true | scanner_status_gate_visibility=required | market_board_gate_visibility=required | dossier_permission_context_gate_visibility=required | unknown_stale_currentness_conflict_sample_liquidity_gates_must_block_or_limit_clean_permission=true | no_signal_boundary_must_remain=true | phase5_permission_gates_must_remain=true | performance_log_spam_must_not_increase=true | rank_order_formula_unchanged_required=true";
  }

string ASC_Phase6RegimeUnknownGateLine()
  {
   return "Phase 6 Gate 1 Regime Unknown: " + string(ASC_PHASE6_GATE_UNKNOWN_LINE);
  }

string ASC_Phase6RegimeStaleCurrentnessGateLine()
  {
   return "Phase 6 Gate 2 Stale / Currentness: " + string(ASC_PHASE6_GATE_STALE_CURRENTNESS_LINE);
  }

string ASC_Phase6StrategyContradictsRegimeGateLine()
  {
   return "Phase 6 Gate 3 Strategy / Setup Contradicts Regime: " + string(ASC_PHASE6_GATE_STRATEGY_CONFLICT_LINE);
  }

string ASC_Phase6BreakoutRangeChopGateLine()
  {
   return "Phase 6 Gate 4 Breakout vs Chop/Range: " + string(ASC_PHASE6_GATE_BREAKOUT_RANGE_CHOP_LINE);
  }

string ASC_Phase6ContinuationPullbackGateLine()
  {
   return "Phase 6 Gate 5 Continuation / Pullback: " + string(ASC_PHASE6_GATE_CONTINUATION_PULLBACK_LINE);
  }

string ASC_Phase6ReversalValueReversionGateLine()
  {
   return "Phase 6 Gate 6 Reversal / Value-Reversion: " + string(ASC_PHASE6_GATE_REVERSAL_VALUE_REVERSION_LINE);
  }

string ASC_Phase6LowLiquidityEventRiskGateLine()
  {
   return "Phase 6 Gate 7 Low Liquidity / Event Risk: " + string(ASC_PHASE6_GATE_LOW_LIQUIDITY_EVENT_RISK_LINE);
  }

string ASC_Phase6SampleInsufficientGateLine()
  {
   return "Phase 6 Gate 8 Sample Insufficient: " + string(ASC_PHASE6_GATE_SAMPLE_INSUFFICIENT_LINE);
  }

string ASC_Phase6NoSignalRegimeBoundaryGateLine()
  {
   return "Phase 6 Gate 9 No-Signal Boundary: " + string(ASC_PHASE6_GATE_NO_SIGNAL_LINE);
  }

string ASC_Phase6RegimeGateSurfaceBlock()
  {
   return ASC_Phase6RegimeGateWiringSummaryLine()
          + "\n" + ASC_Phase6RegimeUnknownGateLine()
          + "\n" + ASC_Phase6RegimeStaleCurrentnessGateLine()
          + "\n" + ASC_Phase6StrategyContradictsRegimeGateLine()
          + "\n" + ASC_Phase6BreakoutRangeChopGateLine()
          + "\n" + ASC_Phase6ContinuationPullbackGateLine()
          + "\n" + ASC_Phase6ReversalValueReversionGateLine()
          + "\n" + ASC_Phase6LowLiquidityEventRiskGateLine()
          + "\n" + ASC_Phase6SampleInsufficientGateLine()
          + "\n" + ASC_Phase6NoSignalRegimeBoundaryGateLine()
          + "\nPhase 6 Gate 10 Phase 5 Preservation: phase5_permission_gates_preserved=true | rank_is_not_permission=true | permission_context_is_not_trade_authorization=true";
  }

string ASC_Phase6SourceReadyProofLine()
  {
   return string(ASC_PHASE6_SOURCE_READY_TOKEN)
          + " | " + ASC_Phase6RegimeContextVocabularySourceReady()
          + " | " + ASC_Phase6StrategySetupVocabularySourceReady()
          + " | " + ASC_Phase6CompatibilityStateVocabularySourceReady()
          + " | " + ASC_Phase6BlockerLimiterVocabularySourceReady()
          + " | " + ASC_Phase6SafetyBoundaryVocabularySourceReady()
          + " | " + ASC_PHASE6_STRATEGY_REQUIRES_REGIME_TOKEN
          + " | setup_label_requires_regime_support=true"
          + " | " + ASC_PHASE6_CONFLICT_BLOCKS_PERMISSION_TOKEN
          + " | " + ASC_PHASE6_REGIME_LABEL_NOT_SIGNAL_TOKEN
          + " | " + ASC_PHASE6_GATE_WIRING_SOURCE_READY_TOKEN
          + " | " + ASC_PHASE6_LIVE_PROOF_CLAIM_FALSE_TOKEN
          + " | " + ASC_Phase6SourceLockSummaryLine()
          + " | phase6_live_proof=false";
  }

string ASC_Phase6DossierPermissionContextLine()
  {
   return ASC_Phase6SafetyBoundaryLine()
          + " | " + ASC_Phase6SourceReadyProofLine()
          + " | " + ASC_Phase6RegimeGateWiringSummaryLine()
          + " | " + ASC_Phase6SourceLockSummaryLine()
          + " | " + ASC_Phase6Run140LiveContractSummaryLine()
          + " | " + ASC_Phase6PermissionGateExtensionLine()
          + " | " + ASC_Phase6CompatibilityRulesLine()
          + " | gate_surface_block=see_scanner_status_market_board_permission_surfaces";
  }
string ASC_Phase7SessionStateVocabularySourceReady()
  {
   return string(ASC_PHASE7_SESSION_AWARENESS_SOURCE_READY_TOKEN) + " | session_state_taxonomy=" + ASC_PHASE7_SESSION_STATE_TAXONOMY;
  }

string ASC_Phase7TimingQualityVocabularySourceReady()
  {
   return string(ASC_PHASE7_TIMING_QUALITY_SOURCE_READY_TOKEN) + " | timing_quality_taxonomy=" + ASC_PHASE7_TIMING_QUALITY_TAXONOMY;
  }

string ASC_Phase7QuoteTickFreshnessVocabularySourceReady()
  {
   return "phase7_quote_tick_freshness_source_ready=true | quote_tick_freshness_taxonomy=" + ASC_PHASE7_QUOTE_TICK_FRESHNESS_TAXONOMY;
  }

string ASC_Phase7PermissionReviewImpactVocabularySourceReady()
  {
   return "phase7_permission_review_impact_source_ready=true | permission_review_impact_taxonomy=" + ASC_PHASE7_PERMISSION_REVIEW_IMPACT_TAXONOMY;
  }

string ASC_Phase7SafetyBoundaryVocabularySourceReady()
  {
   return "phase7_safety_boundary_source_ready=true | safety_boundary_taxonomy=" + ASC_PHASE7_SAFETY_BOUNDARY_TAXONOMY;
  }

string ASC_Phase7SourceReadyProofLine()
  {
   return ASC_Phase7SessionStateVocabularySourceReady()
          + " | " + ASC_Phase7TimingQualityVocabularySourceReady()
          + " | " + ASC_Phase7QuoteTickFreshnessVocabularySourceReady()
          + " | " + ASC_Phase7PermissionReviewImpactVocabularySourceReady()
          + " | " + ASC_Phase7SafetyBoundaryVocabularySourceReady()
          + " | " + ASC_PHASE7_SESSION_LABEL_NOT_SIGNAL_TOKEN
          + " | " + ASC_PHASE7_TIMING_LABEL_NOT_ENTRY_TOKEN
          + " | " + ASC_PHASE7_SESSION_EVIDENCE_REQUIRED_TOKEN
          + " | " + ASC_PHASE7_TIMING_QUALITY_REQUIRED_TOKEN
          + " | " + ASC_PHASE7_EXECUTION_ENABLED_TOKEN
          + " | " + ASC_PHASE7_SOURCE_ONLY_PROOF_BOUNDARY;
  }

string ASC_Phase7ReviewOnlyBoundaryLine()
  {
   return "Phase 7 Session/Timing Boundary: " + string(ASC_PHASE7_SESSION_TIMING_BOUNDARY_TEXT)
          + " | session_context_is_review_only=true | timing_context_is_review_only=true | no_execution=true | no_buy_sell=true | no_entry_output=true | rank_order_formula_unchanged_required=true";
  }

string ASC_Phase7PermissionGateExtensionLine()
  {
   return "Phase 7 Permission Gate Extension: " + string(ASC_PHASE7_PERMISSION_GATE_EXTENSION);
  }

string ASC_Phase7SessionBlockLimitGateLine()
  {
   return "Phase 7 Session Gate Wiring: "
          + string(ASC_PHASE7_SESSION_BLOCK_LIMIT_GATE_TAXONOMY)
          + " | clean_permission_context_blocked_or_limited_when_session_unknown_unavailable_missing_closed_uncertain_pending_or_transition=true";
  }

string ASC_Phase7TimingBlockLimitGateLine()
  {
   return "Phase 7 Timing Gate Wiring: "
          + string(ASC_PHASE7_TIMING_BLOCK_LIMIT_GATE_TAXONOMY)
          + " | clean_permission_context_blocked_or_limited_when_timing_unknown_stale_expired_currentness_unproven_pending_conflict_or_tick_missing=true";
  }

string ASC_Phase7CleanReviewContextRuleLine()
  {
   return "Phase 7 Clean Review Context Rule: "
          + string(ASC_PHASE7_REVIEW_CONTEXT_CLEANNESS_RULE)
          + " | session_timing_layer_extends_phase5_phase6_gates=true | replaces_phase5_phase6_gates=false";
  }

string ASC_Phase7NoEntryBoundaryRuleLine()
  {
   return "Phase 7 No-Entry Boundary: "
          + string(ASC_PHASE7_NO_ENTRY_BOUNDARY_RULE)
          + " | no_buy_sell=true | no_sl_tp_lot=true | order_send_allowed=false";
  }

string ASC_Phase7Run143GateWiringTokenLine()
  {
   return string(ASC_PHASE7_RUN143_SOURCE_PATCH_TOKEN);
  }

string ASC_Phase7SourceLockSummaryLine()
  {
   return string(ASC_PHASE7_SESSION_TIMING_SOURCE_LOCKED_TOKEN)
          + " | " + ASC_PHASE7_LIVE_PROOF_REQUIRED_TOKEN
          + " | " + ASC_PHASE7_SESSION_TIMING_GATE_SURFACE_READY_TOKEN
          + " | " + ASC_PHASE7_SESSION_LABEL_NOT_SIGNAL_TOKEN
          + " | " + ASC_PHASE7_TIMING_LABEL_NOT_ENTRY_TOKEN
          + " | " + ASC_PHASE7_SESSION_TIMING_CONTEXT_REVIEW_ONLY_TOKEN
          + " | " + ASC_PHASE7_UNKNOWN_SESSION_BLOCKS_CLEAN_PERMISSION_TOKEN
          + " | " + ASC_PHASE7_CLOSED_SESSION_BLOCKS_CLEAN_PERMISSION_TOKEN
          + " | " + ASC_PHASE7_STALE_TIMING_BLOCKS_CLEAN_PERMISSION_TOKEN
          + " | " + ASC_PHASE7_EXPIRED_TIMING_BLOCKS_CLEAN_PERMISSION_TOKEN
          + " | " + ASC_PHASE7_CURRENTNESS_UNPROVEN_LIMITS_SESSION_TIMING_TOKEN
          + " | " + ASC_PHASE7_QUOTE_TICK_MISSING_LIMITS_TIMING_CONTEXT_TOKEN
          + " | " + ASC_PHASE7_TIMING_CONFLICT_BLOCKS_CLEAN_PERMISSION_TOKEN
          + " | " + ASC_PHASE7_EXECUTION_ENABLED_TOKEN
          + " | " + ASC_PHASE7_SOURCE_LOCK_STATUS_TOKEN
          + " | " + ASC_PHASE7_RUN144_SOURCE_PATCH_TOKEN
          + " | " + ASC_PHASE7_RUN144_PROOF_BOUNDARY;
  }

string ASC_Phase7Run145LiveContractSummaryLine()
  {
   return string(ASC_PHASE7_RUN145_LIVE_CONTRACT_TOKEN)
          + " | expected_runtime_files=Scanner_Status,Market_Board,Top5PerBucket,GlobalTop10,Dossiers,Current_Focus"
          + " | evidence_contract=" + ASC_PHASE7_RUN145_LIVE_EVIDENCE_CONTRACT
          + " | pass_requires_session_timing_gates_visible=true"
          + " | pass_requires_no_signal_no_entry_no_execution=true"
          + " | hold_if_phase7_tokens_absent_or_hud_reenabled_or_artifacts_missing=true"
          + " | fail_if_rank_formula_execution_fileio_heartbeat_or_hud_object_drift=true";
  }

string ASC_Phase7CloseoutGateChecklistLine()
  {
   return "Phase 7 Closeout Gate Checklist: session_unknown_unavailable_closed_uncertain_pending_transition=live_testable | timing_stale_expired_currentness_unproven_quote_tick_missing_timing_conflict=live_testable | observed_time_server_time_tick_time_distinction_required_RUN145=true | proof_compact_no_per_symbol_spam=true";
  }

string ASC_Phase7GateWiringAggregateLine()
  {
   return ASC_Phase7Run143GateWiringTokenLine()
          + " | " + ASC_Phase7SourceLockSummaryLine()
          + " | " + ASC_Phase7Run145LiveContractSummaryLine()
          + " | " + ASC_Phase7CloseoutGateChecklistLine()
          + " | " + ASC_Phase7SessionBlockLimitGateLine()
          + " | " + ASC_Phase7TimingBlockLimitGateLine()
          + " | " + ASC_Phase7CleanReviewContextRuleLine()
          + " | " + ASC_Phase7NoEntryBoundaryRuleLine();
  }

string ASC_Phase7SessionTimingGateSurfaceBlock()
  {
   return ASC_Phase7SourceReadyProofLine()
          + "\n" + ASC_Phase7SessionBlockLimitGateLine()
          + "\n" + ASC_Phase7TimingBlockLimitGateLine()
          + "\n" + ASC_Phase7CleanReviewContextRuleLine()
          + "\n" + ASC_Phase7NoEntryBoundaryRuleLine()
          + "\nPhase 7 Gate 1 Session Evidence: session_unknown/session_unavailable/session_broker_schedule_missing => session_evidence_required_for_review; clean permission context blocked or limited."
          + "\nPhase 7 Gate 2 Session Closed: session_closed_confirmed => permission_blocked_session_closed; review context only, not advice."
          + "\nPhase 7 Gate 3 Session Uncertain/Pending/Transition: session_uncertain/session_pending_refresh/session_transition_window => limited or pending review context."
          + "\nPhase 7 Gate 4 Timing Stale/Expired/Currentness: timing_stale/timing_expired/timing_currentness_unproven/timing_pending_refresh => limited, blocked, or pending review context."
          + "\nPhase 7 Gate 5 Tick Missing/Timing Conflict: quote_tick_missing/quote_time_unavailable/timing_conflict => timing_quality_required_for_review; clean context withheld."
          + "\nPhase 7 Gate 6 Safety Boundary: session_label_is_not_signal=true | timing_label_is_not_entry=true | session_context_is_review_only=true | timing_context_is_review_only=true | no_execution=true"
          + "\nPhase 7 Closeout Source Lock: " + ASC_Phase7SourceLockSummaryLine()
          + "\nRUN145 Phase 7 Live Contract: " + ASC_Phase7Run145LiveContractSummaryLine();
  }

string ASC_Phase7DossierPermissionContextLine()
  {
   return ASC_Phase7ReviewOnlyBoundaryLine()
          + " | " + ASC_Phase7SourceReadyProofLine()
          + " | " + ASC_Phase7PermissionGateExtensionLine()
          + " | " + ASC_Phase7SessionBlockLimitGateLine()
          + " | " + ASC_Phase7TimingBlockLimitGateLine()
          + " | " + ASC_Phase7CleanReviewContextRuleLine()
          + " | " + ASC_Phase7NoEntryBoundaryRuleLine()
          + " | " + ASC_Phase7SourceLockSummaryLine()
          + " | " + ASC_Phase7Run145LiveContractSummaryLine()
          + " | gate_surface_block=see_scanner_status_market_board_permission_surfaces";
  }

string ASC_Phase8CandidateFilteringInputStateVocabularySourceReady()
  {
   return "candidate_filtering_input_states_source_ready=true | input_state_taxonomy=" + string(ASC_PHASE8_CF_INPUT_STATE_TAXONOMY);
  }

string ASC_Phase8CandidateFilteringBlockerStateVocabularySourceReady()
  {
   return "candidate_filtering_blocker_states_source_ready=true | blocker_state_taxonomy=" + string(ASC_PHASE8_CF_BLOCKER_STATE_TAXONOMY);
  }

string ASC_Phase8CandidateFilteringReviewStateVocabularySourceReady()
  {
   return "candidate_filtering_review_states_source_ready=true | review_state_taxonomy=" + string(ASC_PHASE8_CF_REVIEW_STATE_TAXONOMY);
  }

string ASC_Phase8CandidateFilteringSafetyBoundaryVocabularySourceReady()
  {
   return "candidate_filtering_safety_boundary_source_ready=true | safety_boundary_taxonomy=" + string(ASC_PHASE8_CF_SAFETY_BOUNDARY_TAXONOMY);
  }

string ASC_Phase8CandidateFilteringSourceReadyLine()
  {
   return string(ASC_PHASE8_CF_SOURCE_READY_TOKEN)
          + " | " + ASC_PHASE8_CF_GATES_SOURCE_READY_TOKEN
          + " | " + ASC_PHASE8_CF_SURFACE_READY_TOKEN
          + " | " + ASC_PHASE8_CF_LIVE_PROOF_REQUIRED_TOKEN
          + " | " + ASC_PHASE8_CF_RUN150_REPAIR_CONTRACT_TOKEN
          + " | " + ASC_PHASE8_CF_REPORT_ONLY_FORBIDDEN_WHEN_PATCHABLE_TOKEN
          + " | " + ASC_PHASE8_CF_CONTEXT_READY_TOKEN
          + " | " + ASC_PHASE8_CF_INPUTS_REQUIRE_FRESHNESS_TOKEN
          + " | " + ASC_PHASE8_CF_INPUTS_HAVE_FRESHNESS_STATE_TOKEN
          + " | " + ASC_PHASE8_CF_BLOCKER_REQUIRED_TOKEN
          + " | " + ASC_Phase8CandidateFilteringInputStateVocabularySourceReady()
          + " | " + ASC_Phase8CandidateFilteringBlockerStateVocabularySourceReady()
          + " | " + ASC_Phase8CandidateFilteringReviewStateVocabularySourceReady()
          + " | " + ASC_Phase8CandidateFilteringSafetyBoundaryVocabularySourceReady();
  }

string ASC_Phase8CandidateFilteringReviewBoundaryLine()
  {
   return string(ASC_PHASE8_CF_BOUNDARY_TEXT)
          + " | " + ASC_PHASE8_CF_SCORE_NOT_SIGNAL_TOKEN
          + " | " + ASC_PHASE8_CF_RANK_NOT_SIGNAL_TOKEN
          + " | " + ASC_PHASE8_CF_REVIEW_NOT_PERMISSION_TOKEN
          + " | " + ASC_PHASE8_CF_CANDIDATE_NOT_TRADE_TOKEN
          + " | " + ASC_PHASE8_CF_CONTEXT_NOT_EXECUTION_TOKEN
          + " | " + ASC_PHASE8_CF_REVIEW_ONLY_TOKEN
          + " | " + ASC_PHASE8_CF_EXECUTION_ENABLED_TOKEN;
  }

string ASC_Run157SpeedTruthFillOwnerMapLine()
  {
   return string(ASC_RUN157_REPAIR_SCOPE_TOKEN)
          + " | " + ASC_RUN157_REFRESH_OWNER_MAP_TOKEN
          + " | " + ASC_RUN157_L4_SNAPSHOT_EPOCH_TOKEN
          + " | " + ASC_RUN157_L4_MEMBERSHIP_STATIC_UNTIL_TOKEN
          + " | " + ASC_RUN157_TOP5_EPOCH_TOKEN
          + " | " + ASC_RUN157_GLOBALTOP10_EPOCH_TOKEN
          + " | " + ASC_RUN157_TOP5_GLOBALTOP10_EPOCH_MATCH_TOKEN
          + " | " + ASC_RUN157_L4_STATIC_INFO_INDEPENDENT_TOKEN
          + " | " + ASC_RUN157_DISPLAYED_SET_SOURCE_TOKEN
          + " | " + ASC_RUN157_L2_DISPLAYED_REFRESH_OWNER_TOKEN
          + " | " + ASC_RUN157_L5_DISPLAYED_REFRESH_OWNER_TOKEN
          + " | " + ASC_RUN157_L6_DISPLAYED_REFRESH_OWNER_TOKEN
          + " | " + ASC_RUN157_BUCKET_FILL_PROGRESS_OWNER_TOKEN
          + " | " + ASC_RUN157_BUCKET_FILL_TARGET_MET_LIVE_REQUIRED_TOKEN
          + " | " + ASC_RUN157_PHASE8_LIVE_UNPROVEN_TOKEN;
  }

string ASC_Run157GuidebookBoundaryLine()
  {
   return string(ASC_RUN157_GUIDEBOOK_BRAIN_FOUNDATION_TOKEN)
          + " | " + ASC_RUN157_GUIDEBOOK_SOURCE_LIVE_SEPARATION_TOKEN
          + " | " + ASC_RUN157_TRADING_BRAIN_NO_SIGNAL_TOKEN
          + " | guidebooks_are_distilled_lessons_not_run_logs=true | scanner_not_signal_law_preserved=true";
  }


int ASC_Run158AgeSeconds(const datetime stamp_utc, const datetime now_utc)
  {
   if(stamp_utc <= 0 || now_utc <= 0 || now_utc < stamp_utc)
      return -1;
   return (int)(now_utc - stamp_utc);
  }

string ASC_Run158UtcOrUnavailable(const datetime stamp_utc)
  {
   if(stamp_utc <= 0)
      return "unavailable";
   return ASC_ArtifactFormatUtc(stamp_utc);
  }

string ASC_Run158DisplayedSetDefinitionLine()
  {
   return string(ASC_RUN158_REPAIR_SCOPE_TOKEN)
          + " | " + ASC_RUN158_DISPLAYED_SET_SOURCE_TOKEN
          + " | " + ASC_RUN158_DISPLAYED_SET_COMPONENTS_TOKEN
          + " | " + ASC_RUN158_DISPLAYED_SET_NOT_RANK_OWNER_TOKEN
          + " | " + ASC_RUN158_DISPLAYED_SET_CONTEXT_ONLY_TOKEN
          + " | " + ASC_RUN158_DISPLAYED_SET_NO_REORDER_TOKEN
          + " | " + ASC_RUN158_DISPLAYED_INFO_REPRINT_ONLY_TOKEN;
  }

string ASC_Run158DisplayedRefreshLawLine()
  {
   return string(ASC_RUN158_DISPLAYED_INFO_REFRESH_TOKEN)
          + " | " + ASC_RUN158_L2_DISPLAYED_REFRESH_TOKEN
          + " | " + ASC_RUN158_L2_DISPLAYED_NOT_FULL_UNIVERSE_TOKEN
          + " | " + ASC_RUN158_L5_DISPLAYED_REFRESH_TOKEN
          + " | " + ASC_RUN158_L5_DEFER_HEAVY_BUDGET_TOKEN
          + " | " + ASC_RUN158_L6_DISPLAYED_EVIDENCE_REFRESH_TOKEN
          + " | " + ASC_RUN158_L6_PROOF_NOT_HIDDEN_TOKEN
          + " | " + ASC_RUN158_DISPLAYED_INFO_NOT_HIDDEN_TOKEN;
  }

string ASC_Run158QueueProgressLawLine()
  {
   return string(ASC_RUN158_BUCKET_FILL_PROGRESS_TELEMETRY_TOKEN)
          + " | " + ASC_RUN158_DISPLAYED_PROGRESS_TELEMETRY_TOKEN
          + " | " + ASC_RUN158_QUEUE_PRIORITY_TOKEN
          + " | " + ASC_RUN158_NO_DIRTY_LOOP_TOKEN
          + " | " + ASC_RUN158_DISPLAYED_INFO_NO_CHANGE_SKIP_TOKEN
          + " | " + ASC_RUN158_PHASE8_LIVE_UNPROVEN_TOKEN
          + " | " + ASC_RUN158_NEXT_LIVE_TOKEN;
  }

string ASC_Run158DisplayedRefreshTelemetryLine(const int displayed_total,
                                               const int displayed_current,
                                               const int displayed_pending,
                                               const int displayed_stale,
                                               const int displayed_missing,
                                               const datetime last_refresh_utc,
                                               const datetime now_utc,
                                               const bool refresh_due)
  {
   int total = MathMax(0, displayed_total);
   int current = MathMax(0, displayed_current);
   int pending = MathMax(0, displayed_pending);
   int stale = MathMax(0, displayed_stale);
   int missing = MathMax(0, displayed_missing);
   int age_seconds = ASC_Run158AgeSeconds(last_refresh_utc, now_utc);
   datetime next_due = (last_refresh_utc > 0 ? (datetime)(last_refresh_utc + ASC_RUN158_DISPLAYED_INFO_REFRESH_SEC) : (datetime)0);
   double progress = (total > 0 ? (100.0 * (double)current / (double)total) : 0.0);

   return StringFormat("displayed_symbol_info_states=info_age_seconds,stale,refresh_pending,refresh_progressing,refresh_complete,not_available,not_hidden | displayed_symbols_total=%d | displayed_symbols_info_current=%d | displayed_symbols_info_pending=%d | displayed_symbols_info_stale=%d | displayed_symbols_info_missing=%d | displayed_symbols_info_refresh_due_count=%d | displayed_symbols_refresh_progress_percent=%.1f | displayed_symbol_info_last_refresh_utc=%s | displayed_symbol_info_next_due_utc=%s | displayed_symbol_info_age_seconds=%d | displayed_symbol_info_refresh_due=%s | displayed_symbol_info_refresh_pending=%s | displayed_symbol_info_refresh_progressing=%s | displayed_symbol_info_refresh_complete=%s | displayed_symbol_info_not_available=%s | displayed_symbol_info_not_hidden=true | displayed_symbol_info_no_change_skip_active=true | displayed_symbol_info_reprint_only_not_selection=true",
                       total,
                       current,
                       pending,
                       stale,
                       missing,
                       (refresh_due ? total : 0),
                       progress,
                       ASC_Run158UtcOrUnavailable(last_refresh_utc),
                       ASC_Run158UtcOrUnavailable(next_due),
                       age_seconds,
                       (refresh_due ? "true" : "false"),
                       (pending > 0 ? "true" : "false"),
                       ((pending > 0 || refresh_due) ? "true" : "false"),
                       (total > 0 && current >= total && missing == 0 && stale == 0 ? "true" : "false"),
                       (total <= 0 ? "true" : "false"));
  }

string ASC_Run158BucketFillTelemetryLine(const int buckets_total,
                                         const int buckets_visible,
                                         const int buckets_pending,
                                         const int buckets_stalled,
                                         const datetime started_utc,
                                         const datetime now_utc)
  {
   int total = MathMax(0, buckets_total);
   int visible = MathMax(0, buckets_visible);
   int pending = MathMax(0, buckets_pending);
   int stalled = MathMax(0, buckets_stalled);
   int elapsed_seconds = ASC_Run158AgeSeconds(started_utc, now_utc);
   double fill_percent = (total > 0 ? (100.0 * (double)visible / (double)total) : 0.0);
   bool target_measurable = (started_utc > 0 && now_utc >= started_utc && total > 0);
   bool target_met = (target_measurable && visible >= total && elapsed_seconds >= 0 && elapsed_seconds <= ASC_RUN156_BUCKET_FILL_TARGET_SEC);
   bool target_missed = (target_measurable && visible < total && elapsed_seconds > ASC_RUN156_BUCKET_FILL_TARGET_SEC);
   bool in_progress = (target_measurable && !target_met && !target_missed && (pending > 0 || visible < total));
   bool not_yet_hydrated = (total > 0 && visible <= 0 && pending > 0);

   return StringFormat("bucket_fill_target_seconds=%d | bucket_fill_window_start_utc=%s | bucket_fill_elapsed_seconds=%d | buckets_total=%d | buckets_with_visible_info=%d | buckets_pending=%d | buckets_stalled=%d | bucket_fill_percent=%.1f | bucket_fill_target_measurable=%s | bucket_fill_target_met=%s | bucket_fill_target_missed=%s | bucket_fill_in_progress=%s | bucket_fill_not_yet_hydrated=%s | bucket_fill_run_ended_before_completion=runtime_value_pending | bucket_fill_progressing=%s | queue_progressing=%s | queue_stalled=%s | fill_in_progress_not_missing=true | not_yet_hydrated_not_source_gap=true | run_ended_before_completion_not_source_failure=true",
                       ASC_RUN156_BUCKET_FILL_TARGET_SEC,
                       ASC_Run158UtcOrUnavailable(started_utc),
                       elapsed_seconds,
                       total,
                       visible,
                       pending,
                       stalled,
                       fill_percent,
                       (target_measurable ? "true" : "false"),
                       (target_met ? "true" : "false"),
                       (target_missed ? "true" : "false"),
                       (in_progress ? "true" : "false"),
                       (not_yet_hydrated ? "true" : "false"),
                       (pending > 0 && stalled == 0 ? "true" : "false"),
                       (pending > 0 && stalled == 0 ? "true" : "false"),
                       (stalled > 0 ? "true" : "false"));
  }

string ASC_Run158L2L5L6DisplayedRefreshLine(const datetime l2_refresh_utc,
                                             const datetime l5_refresh_utc,
                                             const datetime l6_refresh_utc,
                                             const datetime now_utc,
                                             const int l5_pending_count,
                                             const int l6_pending_count)
  {
   int l2_age = ASC_Run158AgeSeconds(l2_refresh_utc, now_utc);
   int l5_age = ASC_Run158AgeSeconds(l5_refresh_utc, now_utc);
   int l6_age = ASC_Run158AgeSeconds(l6_refresh_utc, now_utc);
   bool l2_due = (l2_age < 0 || l2_age >= ASC_RUN158_DISPLAYED_INFO_REFRESH_SEC);
   bool l5_due = (l5_age < 0 || l5_age >= ASC_RUN158_DISPLAYED_INFO_REFRESH_SEC);
   bool l6_due = (l6_age < 0 || l6_age >= ASC_RUN158_DISPLAYED_INFO_REFRESH_SEC);

   return StringFormat("l2_displayed_refresh_seconds=%d | l2_displayed_refresh_due=%s | l2_displayed_refresh_pending=%s | l2_displayed_refresh_progressing=%s | l2_displayed_refresh_complete=%s | l2_displayed_quote_currentness_age_seconds=%d | l2_displayed_quote_stale=%s | l2_displayed_quote_missing=%s | l2_displayed_symbol_select_required=budgeted_only | l2_displayed_refresh_not_full_universe=true | l5_displayed_refresh_seconds=%d | l5_displayed_refresh_due=%s | l5_displayed_refresh_pending=%s | l5_displayed_refresh_available=where_existing_or_selected | l5_displayed_refresh_deferred_heavy_budget=true | l6_displayed_evidence_refresh_seconds=%d | l6_displayed_evidence_refresh_due=%s | l6_displayed_gate_state_age_seconds=%d | l6_displayed_gate_state_stale=%s | l6_displayed_proof_not_hidden=true",
                       ASC_RUN158_DISPLAYED_INFO_REFRESH_SEC,
                       (l2_due ? "true" : "false"),
                       (l2_due ? "true" : "false"),
                       (l2_due ? "true" : "false"),
                       (!l2_due ? "true" : "false"),
                       l2_age,
                       (l2_age >= ASC_RUN158_DISPLAYED_INFO_REFRESH_SEC ? "true" : "false"),
                       (l2_age < 0 ? "true" : "false"),
                       ASC_RUN158_DISPLAYED_INFO_REFRESH_SEC,
                       (l5_due ? "true" : "false"),
                       (l5_pending_count > 0 || l5_due ? "true" : "false"),
                       ASC_RUN158_DISPLAYED_INFO_REFRESH_SEC,
                       (l6_due ? "true" : "false"),
                       l6_age,
                       (l6_age >= ASC_RUN158_DISPLAYED_INFO_REFRESH_SEC ? "true" : "false"));
  }


string ASC_Run159BucketFillSourceReadinessLine()
  {
   return string(ASC_RUN159_REPAIR_SCOPE_TOKEN)
          + " | " + ASC_RUN159_BUCKET_FILL_SOURCE_READY_TOKEN
          + " | " + ASC_RUN159_BUCKET_FILL_TARGET_MEASURABLE_TOKEN
          + " | " + ASC_RUN159_BUCKET_FILL_TARGET_MET_RUNTIME_ONLY_TOKEN
          + " | " + ASC_RUN159_BUCKET_FILL_TARGET_MISSED_RUNTIME_ONLY_TOKEN
          + " | " + ASC_RUN159_BUCKET_FILL_RUNTIME_FIELDS_TOKEN
          + " | " + ASC_RUN159_BUCKET_FILL_HONEST_BLOCKER_TOKEN
          + " | " + ASC_RUN159_SOURCE_NOT_LIVE_PROOF_TOKEN;
  }

string ASC_Run159Run160LiveContractLine()
  {
   return string(ASC_RUN159_RUN160_CONTRACT_TOKEN)
          + " | " + ASC_RUN159_RUN160_NO_REPORT_ONLY_TOKEN
          + " | " + ASC_RUN159_RUN160_SAFE_PATCH_TOKEN
          + " | " + ASC_RUN159_RUN160_CAPTURE_TOKEN
          + " | " + ASC_RUN159_RUN160_ACCEPTANCE_TOKEN
          + " | " + ASC_RUN159_RUN160_HOLD_FAIL_TOKEN;
  }

string ASC_Run159ProtectedBoundaryLine()
  {
   return string(ASC_RUN159_GUIDEBOOK_DISTILLED_TOKEN)
          + " | " + ASC_RUN159_NO_FORMULA_ORDER_DRIFT_TOKEN
          + " | " + ASC_RUN159_NO_FILEIO_HEARTBEAT_DRIFT_TOKEN
          + " | " + ASC_RUN159_NO_SIGNAL_EXECUTION_DRIFT_TOKEN
          + " | " + ASC_RUN159_NO_HEAVY_SCAN_TOKEN
          + " | " + ASC_RUN159_NO_FLUSH_LOOP_TOKEN
          + " | " + ASC_RUN159_PHASE8_LIVE_UNPROVEN_TOKEN
          + " | " + ASC_RUN159_PHASE9_BLOCKED_TOKEN
          + " | " + ASC_RUN159_NEXT_LIVE_TOKEN;
  }

string ASC_Run159SpeedTruthFillCloseoutBlock()
  {
   string block = "RUN159 Speed + Truth-Fill Source Closeout / RUN160 Live Contract\n";
   block += "- bucket_fill_source_readiness: " + ASC_Run159BucketFillSourceReadinessLine() + "\n";
   block += "- run160_live_contract: " + ASC_Run159Run160LiveContractLine() + "\n";
   block += "- protected_boundaries: " + ASC_Run159ProtectedBoundaryLine() + "\n";
   return block;
  }

string ASC_Phase8CandidateFilteringInputStateLine()
  {
   return string(ASC_PHASE8_CF_MISSING_INPUT_STATE_TOKEN)
          + " | " + ASC_PHASE8_CF_PENDING_REFRESH_STATE_TOKEN
          + " | " + ASC_PHASE8_CF_STALE_INPUT_STATE_TOKEN
          + " | " + ASC_PHASE8_CF_UNAVAILABLE_INPUT_STATE_TOKEN
          + " | " + ASC_PHASE8_CF_CONFLICT_STATE_TOKEN
          + " | " + ASC_PHASE8_CF_CURRENTNESS_UNPROVEN_STATE_TOKEN;
  }

string ASC_Phase8CandidateFilteringBlockLimitLine()
  {
   return string(ASC_PHASE8_CF_MISSING_LIMITS_REVIEW_TOKEN)
          + " | " + ASC_PHASE8_CF_STALE_LIMITS_REVIEW_TOKEN
          + " | " + ASC_PHASE8_CF_UNAVAILABLE_LIMITS_REVIEW_TOKEN
          + " | " + ASC_PHASE8_CF_CURRENTNESS_LIMITS_REVIEW_TOKEN
          + " | " + ASC_PHASE8_CF_CONFLICT_LIMITS_REVIEW_TOKEN
          + " | " + ASC_PHASE8_CF_SAMPLE_LIMITS_REVIEW_TOKEN
          + " | " + ASC_PHASE8_CF_SPREAD_FRICTION_LIMITS_REVIEW_TOKEN
          + " | " + ASC_PHASE8_CF_SESSION_LIMITS_REVIEW_TOKEN
          + " | " + ASC_PHASE8_CF_REVIEW_READY_REQUIRES_EVIDENCE_TOKEN;
  }

string ASC_Phase8CandidateFilteringExplicitReviewStateGateLine()
  {
   return "candidate_filtering_review_state_gate=explicit"
          + StringFormat(" | review_states=%s", ASC_PHASE8_CF_REVIEW_STATE_TAXONOMY)
          + " | cf_review_ready_requires_evidence=true"
          + " | cf_review_limited_when_stale_or_sample_insufficient=true"
          + " | cf_review_pending_when_unavailable_or_currentness_unproven=true"
          + " | cf_review_blocked_when_missing_conflicting_or_session_blocked=true"
          + " | cf_review_not_applicable_when_market_closed=true"
          + " | cf_review_unknown_when_owner_truth_absent=true";
  }

string ASC_Phase8CandidateFilteringRun150ContractLine()
  {
   return "RUN150 live + research + source repair contract: live_audit_required=true | official_mql5_research_required=true | safe_patch_required_if_patchable_gap_exists=true | changed_files_zip_required_if_patched=true | report_only_forbidden_when_patchable=true | hold_only_if_unsafe_unavailable_compile_or_protected_blocker=true";
  }

string ASC_Phase8CandidateFilteringNoExecutionLine()
  {
   return string(ASC_PHASE8_CF_NO_BUY_SELL_TOKEN)
          + " | " + ASC_PHASE8_CF_NO_ENTRY_TOKEN
          + " | " + ASC_PHASE8_CF_NO_ORDER_TOKEN
          + " | no_sl_tp_lot=true | ordersend_ctrade_added=false | strategy_execution_enabled=false";
  }

string ASC_Phase8CandidateFilteringNoDriftLine()
  {
   return string(ASC_PHASE8_CF_NO_FORMULA_DRIFT_TOKEN)
          + " | " + ASC_PHASE8_CF_NO_RANK_DRIFT_TOKEN
          + " | market_board_order_changed=false | top5perbucket_order_changed=false | globaltop10_order_changed=false | fileio_atomic_contract_changed=false | heartbeat_cadence_changed=false | hud_reenabled=false | " + ASC_PHASE8_CF_NO_PER_SYMBOL_SPAM_TOKEN;
  }

string ASC_Phase8CandidateFilteringGateSurfaceBlock()
  {
   return ASC_Phase8CandidateFilteringSourceReadyLine()
          + "\n" + ASC_Phase8CandidateFilteringReviewBoundaryLine()
          + "\n" + ASC_Phase8CandidateFilteringInputStateLine()
          + "\n" + ASC_Phase8CandidateFilteringBlockLimitLine()
          + "\n" + ASC_Phase8CandidateFilteringExplicitReviewStateGateLine()
          + "\n" + ASC_Phase8CandidateFilteringNoExecutionLine()
          + "\n" + ASC_Phase8CandidateFilteringRun150ContractLine()
          + "\n" + ASC_Phase8CandidateFilteringNoDriftLine()
          + "\nPhase 8 Candidate Filtering Rule 1: cf_input_missing/cf_input_stale/cf_input_unavailable/cf_input_pending_refresh/cf_input_currentness_unproven cannot produce clean review-ready context."
          + "\nPhase 8 Candidate Filtering Rule 2: candidate score and rank support review only; they are not permission, signals, entries, or execution instructions."
          + "\nPhase 8 Candidate Filtering Rule 3: Phase 5 permission, Phase 6 regime, and Phase 7 session/timing gates remain upstream context limiters.";
  }


string ASC_RuntimeProofBundleFirstMissingReason(const bool scanner_status_present,
                                                const bool market_board_current_present,
                                                const bool market_board_archive_present,
                                                const bool top5_current_present,
                                                const bool top5_staging_present,
                                                const bool top5_archive_present,
                                                const bool globaltop10_current_present,
                                                const bool globaltop10_archive_present,
                                                const bool dossier_present,
                                                const bool selected_symbol_present,
                                                const bool current_focus_present,
                                                const bool functionresults_present,
                                                const bool heartbeat_telemetry_present,
                                                const bool artifact_manifest_present,
                                                const bool stale_tmp_proof_present,
                                                const bool phase5_gate_surface_present,
                                                const bool phase6_gate_surface_present,
                                                const bool phase7_gate_surface_present,
                                                const bool phase8_gate_surface_present)
  {
   if(!scanner_status_present) return "scanner_status_missing";
   if(!market_board_current_present) return "market_board_current_missing";
   if(!market_board_archive_present) return "market_board_archive_missing";
   if(!top5_current_present) return "top5_current_missing";
   if(!top5_staging_present) return "top5_staging_missing";
   if(!top5_archive_present) return "top5_archive_missing";
   if(!globaltop10_current_present) return "globaltop10_current_missing";
   if(!globaltop10_archive_present) return "globaltop10_archive_missing";
   if(!dossier_present) return "dossier_missing";
   if(selected_symbol_present && !current_focus_present) return "current_focus_missing_for_selected_symbol";
   if(!functionresults_present) return "functionresults_missing";
   if(!heartbeat_telemetry_present) return "heartbeat_telemetry_missing";
   if(!artifact_manifest_present) return "artifact_manifest_missing";
   if(!stale_tmp_proof_present) return "stale_tmp_or_cleanup_proof_missing";
   if(!phase5_gate_surface_present) return "phase5_gate_surface_missing";
   if(!phase6_gate_surface_present) return "phase6_gate_surface_missing";
   if(!phase7_gate_surface_present) return "phase7_gate_surface_missing";
   if(!phase8_gate_surface_present) return "phase8_gate_surface_missing";
   return "none";
  }

int ASC_RuntimeProofBundleMissingSurfaceCount(const bool scanner_status_present,
                                               const bool market_board_current_present,
                                               const bool market_board_archive_present,
                                               const bool top5_current_present,
                                               const bool top5_staging_present,
                                               const bool top5_archive_present,
                                               const bool globaltop10_current_present,
                                               const bool globaltop10_archive_present,
                                               const bool dossier_present,
                                               const bool selected_symbol_present,
                                               const bool current_focus_present,
                                               const bool functionresults_present,
                                               const bool heartbeat_telemetry_present,
                                               const bool artifact_manifest_present,
                                               const bool stale_tmp_proof_present,
                                               const bool phase5_gate_surface_present,
                                               const bool phase6_gate_surface_present,
                                               const bool phase7_gate_surface_present,
                                               const bool phase8_gate_surface_present)
  {
   int missing = 0;
   if(!scanner_status_present) missing++;
   if(!market_board_current_present) missing++;
   if(!market_board_archive_present) missing++;
   if(!top5_current_present) missing++;
   if(!top5_staging_present) missing++;
   if(!top5_archive_present) missing++;
   if(!globaltop10_current_present) missing++;
   if(!globaltop10_archive_present) missing++;
   if(!dossier_present) missing++;
   if(selected_symbol_present && !current_focus_present) missing++;
   if(!functionresults_present) missing++;
   if(!heartbeat_telemetry_present) missing++;
   if(!artifact_manifest_present) missing++;
   if(!stale_tmp_proof_present) missing++;
   if(!phase5_gate_surface_present) missing++;
   if(!phase6_gate_surface_present) missing++;
   if(!phase7_gate_surface_present) missing++;
   if(!phase8_gate_surface_present) missing++;
   return missing;
  }

string ASC_RuntimeProofBundleMissingSurfaceList(const bool scanner_status_present,
                                                const bool market_board_current_present,
                                                const bool market_board_archive_present,
                                                const bool top5_current_present,
                                                const bool top5_staging_present,
                                                const bool top5_archive_present,
                                                const bool globaltop10_current_present,
                                                const bool globaltop10_archive_present,
                                                const bool dossier_present,
                                                const bool selected_symbol_present,
                                                const bool current_focus_present,
                                                const bool functionresults_present,
                                                const bool heartbeat_telemetry_present,
                                                const bool artifact_manifest_present,
                                                const bool stale_tmp_proof_present,
                                                const bool phase5_gate_surface_present,
                                                const bool phase6_gate_surface_present,
                                                const bool phase7_gate_surface_present,
                                                const bool phase8_gate_surface_present)
  {
   string list = "";
   if(!scanner_status_present) list += "scanner_status,";
   if(!market_board_current_present) list += "market_board_current,";
   if(!market_board_archive_present) list += "market_board_archive,";
   if(!top5_current_present) list += "top5_current,";
   if(!top5_staging_present) list += "top5_staging,";
   if(!top5_archive_present) list += "top5_archive,";
   if(!globaltop10_current_present) list += "globaltop10_current,";
   if(!globaltop10_archive_present) list += "globaltop10_archive,";
   if(!dossier_present) list += "dossiers,";
   if(selected_symbol_present && !current_focus_present) list += "current_focus_for_selected_symbol,";
   if(!functionresults_present) list += "functionresults,";
   if(!heartbeat_telemetry_present) list += "heartbeat_telemetry,";
   if(!artifact_manifest_present) list += "artifact_bundle_manifest,";
   if(!stale_tmp_proof_present) list += "stale_tmp_proof,";
   if(!phase5_gate_surface_present) list += "phase5_gate_surface,";
   if(!phase6_gate_surface_present) list += "phase6_gate_surface,";
   if(!phase7_gate_surface_present) list += "phase7_gate_surface,";
   if(!phase8_gate_surface_present) list += "phase8_gate_surface,";
   if(StringLen(list) <= 0)
      return "none";
   return StringSubstr(list, 0, StringLen(list) - 1);
  }

string ASC_RuntimeProofBundleDecisionState(const string first_missing_reason,
                                           const int missing_count)
  {
   if(missing_count <= 0 || first_missing_reason == "none")
      return string(ASC_RUN152_DECISION_PASS_READY);
   if(first_missing_reason == "functionresults_missing")
      return string(ASC_RUN152_DECISION_HOLD_MISSING_LOGS);
   if(first_missing_reason == "heartbeat_telemetry_missing")
      return string(ASC_RUN152_DECISION_HOLD_MISSING_TELEMETRY);
   if(StringFind(first_missing_reason, "phase") >= 0)
      return string(ASC_RUN152_DECISION_HOLD_MISSING_PHASE_GATE_SURFACE);
   return string(ASC_RUN152_DECISION_HOLD_MISSING_SURFACE);
  }

string ASC_RuntimeProofBundleCompletenessLine(const bool scanner_status_present,
                                              const bool market_board_current_present,
                                              const bool market_board_archive_present,
                                              const bool top5_current_present,
                                              const bool top5_staging_present,
                                              const bool top5_archive_present,
                                              const bool globaltop10_current_present,
                                              const bool globaltop10_archive_present,
                                              const bool dossier_present,
                                              const bool selected_symbol_present,
                                              const bool current_focus_present,
                                              const bool functionresults_present,
                                              const bool heartbeat_telemetry_present,
                                              const bool artifact_manifest_present,
                                              const bool stale_tmp_proof_present,
                                              const bool phase5_gate_surface_present,
                                              const bool phase6_gate_surface_present,
                                              const bool phase7_gate_surface_present,
                                              const bool phase8_gate_surface_present)
  {
   string missing_required_surfaces = "";
   string missing_optional_surfaces = "";
   string lawful_not_applicable_surfaces = "";
   string deferred_surfaces = "";
   string unknown_policy_surfaces = "";
   int missing_required_count = 0;
   int missing_optional_count = 0;
   int lawful_not_applicable_count = 0;
   int unknown_policy_count = 0;

   if(!scanner_status_present) { missing_required_count++; missing_required_surfaces += "scanner_status,"; }
   if(!market_board_current_present) { missing_required_count++; missing_required_surfaces += "market_board_current,"; }
   if(!top5_current_present) { missing_required_count++; missing_required_surfaces += "top5perbucket_final,"; }
   if(!globaltop10_current_present) { missing_required_count++; missing_required_surfaces += "globaltop10_final,"; }
   if(!functionresults_present) { missing_required_count++; missing_required_surfaces += "function_results,"; }
   if(!heartbeat_telemetry_present) { missing_required_count++; missing_required_surfaces += "heartbeat,"; }
   if(!artifact_manifest_present) { missing_required_count++; missing_required_surfaces += "manifest,"; }
   if(!stale_tmp_proof_present) { missing_required_count++; missing_required_surfaces += "stale_tmp_proof,"; }
   if(!phase5_gate_surface_present) { missing_required_count++; missing_required_surfaces += "phase5_gate_surface,"; }
   if(!phase6_gate_surface_present) { missing_required_count++; missing_required_surfaces += "phase6_gate_surface,"; }
   if(!phase7_gate_surface_present) { missing_required_count++; missing_required_surfaces += "phase7_gate_surface,"; }
   if(!phase8_gate_surface_present) { missing_required_count++; missing_required_surfaces += "phase8_gate_surface,"; }

   if(!market_board_archive_present) { missing_optional_count++; missing_optional_surfaces += "market_board_archive,"; }
   if(!top5_staging_present) { missing_optional_count++; missing_optional_surfaces += "top5perbucket_staging,"; }
   if(!top5_archive_present) { missing_optional_count++; missing_optional_surfaces += "top5perbucket_archive,"; }
   if(!globaltop10_archive_present) { missing_optional_count++; missing_optional_surfaces += "globaltop10_archive,"; }
   missing_optional_count++; missing_optional_surfaces += "compile_output,";
   missing_optional_count++; missing_optional_surfaces += "experts_log,";
   missing_optional_count++; missing_optional_surfaces += "journal_log,";
   missing_optional_count++; missing_optional_surfaces += "broker_server_session_note,";

   if(selected_symbol_present && !current_focus_present)
     {
      missing_required_count++;
      missing_required_surfaces += "current_focus,";
     }
   if(!selected_symbol_present)
     {
      lawful_not_applicable_count++;
      lawful_not_applicable_surfaces += "current_focus_no_selected_symbol,";
     }

   if(!dossier_present)
     {
      deferred_surfaces += "dossiers_separate_artifact_family_policy,";
     }

   if(StringLen(missing_required_surfaces) > 0)
      missing_required_surfaces = StringSubstr(missing_required_surfaces, 0, StringLen(missing_required_surfaces) - 1);
   else
      missing_required_surfaces = "none";

   if(StringLen(missing_optional_surfaces) > 0)
      missing_optional_surfaces = StringSubstr(missing_optional_surfaces, 0, StringLen(missing_optional_surfaces) - 1);
   else
      missing_optional_surfaces = "none";

   if(StringLen(lawful_not_applicable_surfaces) > 0)
      lawful_not_applicable_surfaces = StringSubstr(lawful_not_applicable_surfaces, 0, StringLen(lawful_not_applicable_surfaces) - 1);
   else
      lawful_not_applicable_surfaces = "none";

   if(StringLen(deferred_surfaces) > 0)
      deferred_surfaces = StringSubstr(deferred_surfaces, 0, StringLen(deferred_surfaces) - 1);
   else
      deferred_surfaces = "none";

   if(StringLen(unknown_policy_surfaces) > 0)
      unknown_policy_surfaces = StringSubstr(unknown_policy_surfaces, 0, StringLen(unknown_policy_surfaces) - 1);
   else
      unknown_policy_surfaces = "none";

   bool required_complete = (missing_required_count == 0 && unknown_policy_count == 0);
   bool optional_complete = (missing_optional_count == 0);
   bool complete = (required_complete && optional_complete && unknown_policy_count == 0);
   string first_missing_required_surface = (missing_required_surfaces == "none" ? "none" : missing_required_surfaces);
   if(StringFind(first_missing_required_surface, ",") >= 0)
      first_missing_required_surface = StringSubstr(first_missing_required_surface, 0, StringFind(first_missing_required_surface, ","));

   string first_failure_reason = "none";
   if(missing_required_count > 0)
      first_failure_reason = first_missing_required_surface + "_missing_required";
   else if(unknown_policy_count > 0)
      first_failure_reason = "unknown_policy_surface";
   else if(missing_optional_count > 0)
      first_failure_reason = "optional_or_diagnostic_surface_missing";
   else if(deferred_surfaces != "none")
      first_failure_reason = "deferred_surface_policy_present";

   int total_missing_surface_count = missing_required_count + missing_optional_count + unknown_policy_count;
   string all_missing_surfaces = "";
   if(missing_required_surfaces != "none") all_missing_surfaces += missing_required_surfaces + ",";
   if(missing_optional_surfaces != "none") all_missing_surfaces += missing_optional_surfaces + ",";
   if(unknown_policy_surfaces != "none") all_missing_surfaces += unknown_policy_surfaces + ",";
   if(StringLen(all_missing_surfaces) > 0)
      all_missing_surfaces = StringSubstr(all_missing_surfaces, 0, StringLen(all_missing_surfaces) - 1);
   else
      all_missing_surfaces = "none";

   string decision_state = ASC_RuntimeProofBundleDecisionState(first_failure_reason, total_missing_surface_count);
   string line = string(ASC_RUN151_PROOF_BUNDLE_REQUIRED_TOKEN);
   line += " | proof_bundle_policy_version=RUN225R_v1";
   line += " | proof_bundle_complete=" + (complete ? "true" : "false");
   line += " | proof_bundle_required_complete=" + (required_complete ? "true" : "false");
   line += " | proof_bundle_optional_complete=" + (optional_complete ? "true" : "false");
   line += " | proof_bundle_missing_required_count=" + IntegerToString(missing_required_count);
   line += " | proof_bundle_missing_optional_count=" + IntegerToString(missing_optional_count);
   line += " | proof_bundle_lawful_not_applicable_count=" + IntegerToString(lawful_not_applicable_count);
   line += " | proof_bundle_unknown_policy_count=" + IntegerToString(unknown_policy_count);
   line += " | proof_bundle_first_missing_required_surface=" + first_missing_required_surface;
   line += " | proof_bundle_missing_required_surfaces=" + missing_required_surfaces;
   line += " | proof_bundle_missing_optional_surfaces=" + missing_optional_surfaces;
   line += " | proof_bundle_lawful_not_applicable_surfaces=" + lawful_not_applicable_surfaces;
   line += " | proof_bundle_deferred_surfaces=" + deferred_surfaces;
   line += " | proof_bundle_unknown_policy_surfaces=" + unknown_policy_surfaces;
   line += " | proof_bundle_first_failure_reason=" + first_failure_reason;
   line += " | proof_bundle_policy_boundary=proof_policy_only_no_fake_pass_no_output_mutation";
   line += " | proof_bundle_incomplete_reason=" + first_failure_reason;
   line += " | proof_bundle_first_missing_surface=" + (first_missing_required_surface == "none" ? first_failure_reason : first_missing_required_surface);
   line += " | proof_bundle_missing_surface_count=" + IntegerToString(total_missing_surface_count);
   line += " | proof_bundle_missing_surface_list=" + all_missing_surfaces;
   line += " | proof_bundle_decision_state=" + decision_state;
   line += " | evidence_package_blocker=" + (required_complete ? "false" : "true");
   line += " | proof_surface_scanner_status=" + (scanner_status_present ? "supplied|required" : "missing_required|required");
   line += " | proof_surface_market_board_current=" + (market_board_current_present ? "supplied|required" : "missing_required|required");
   line += " | proof_surface_market_board_archive=" + (market_board_archive_present ? "supplied|optional" : "missing_optional|optional");
   line += " | proof_surface_top5perbucket_final=" + (top5_current_present ? "supplied|required" : "missing_required|required");
   line += " | proof_surface_top5perbucket_staging=" + (top5_staging_present ? "supplied|optional" : "missing_optional|optional");
   line += " | proof_surface_top5perbucket_archive=" + (top5_archive_present ? "supplied|optional" : "missing_optional|optional");
   line += " | proof_surface_globaltop10_final=" + (globaltop10_current_present ? "supplied|required" : "missing_required|required");
   line += " | proof_surface_globaltop10_archive=" + (globaltop10_archive_present ? "supplied|optional" : "missing_optional|optional");
   line += " | proof_surface_dossiers=" + (dossier_present ? "supplied|deferred_artifact_family" : "deferred|separate_artifact_family_policy");
   line += " | proof_surface_current_focus=" + (selected_symbol_present ? (current_focus_present ? "supplied|required_when_selected" : "missing_required|required_when_selected") : "lawful_not_applicable|no_selected_symbol");
   line += " | proof_surface_manifest=" + (artifact_manifest_present ? "supplied|required" : "missing_required|required");
   line += " | proof_surface_function_results=" + (functionresults_present ? "supplied|required" : "missing_required|required");
   line += " | proof_surface_heartbeat=" + (heartbeat_telemetry_present ? "supplied|required" : "missing_required|required");
   line += " | proof_surface_compile_output=missing_optional|external_compile_evidence_not_supplied";
   line += " | proof_surface_experts_log=missing_optional|diagnostic_optional_not_supplied";
   line += " | proof_surface_journal_log=missing_optional|diagnostic_optional_not_supplied";
   line += " | proof_surface_broker_server_session_note=missing_optional|interpretation_context_not_supplied";
   line += " | scanner_status_required=true | scanner_status_present=" + (scanner_status_present ? "true" : "false");
   line += " | market_board_required=true | market_board_current_present=" + (market_board_current_present ? "true" : "false") + " | market_board_archive_present=" + (market_board_archive_present ? "true" : "false");
   line += " | top5_per_bucket_required=true | top5_current_present=" + (top5_current_present ? "true" : "false") + " | top5_staging_present=" + (top5_staging_present ? "true" : "false") + " | top5_archive_present=" + (top5_archive_present ? "true" : "false");
   line += " | globaltop10_required=true | globaltop10_current_present=" + (globaltop10_current_present ? "true" : "false") + " | globaltop10_archive_present=" + (globaltop10_archive_present ? "true" : "false");
   line += " | dossier_required=deferred_separate_artifact_family | dossier_present=" + (dossier_present ? "true" : "false");
   line += " | current_focus_required=selected_symbol_present_only | selected_symbol_present=" + (selected_symbol_present ? "true" : "false") + " | current_focus_present_or_not_applicable=" + ((!selected_symbol_present || current_focus_present) ? "true" : "false");
   line += " | functionresults_required=true | functionresults_present=" + (functionresults_present ? "true" : "false");
   line += " | heartbeat_telemetry_required=true | heartbeat_telemetry_present=" + (heartbeat_telemetry_present ? "true" : "false");
   line += " | artifact_manifest_required=true | artifact_manifest_present=" + (artifact_manifest_present ? "true" : "false");
   line += " | stale_tmp_proof_required=true | stale_tmp_proof_present=" + (stale_tmp_proof_present ? "true" : "false");
   line += " | phase5_gate_surface_required=true | phase5_gate_surface_present=" + (phase5_gate_surface_present ? "true" : "false");
   line += " | phase6_gate_surface_required=true | phase6_gate_surface_present=" + (phase6_gate_surface_present ? "true" : "false");
   line += " | phase7_gate_surface_required=true | phase7_gate_surface_present=" + (phase7_gate_surface_present ? "true" : "false");
   line += " | phase8_gate_surface_required=true | phase8_gate_surface_present=" + (phase8_gate_surface_present ? "true" : "false");
   line += " | " + string(ASC_RUN152_PROOF_COMPLETE_TRUE_RULE_TOKEN);
   line += " | " + string(ASC_RUN152_EVIDENCE_BLOCKER_CONDITIONAL_TOKEN);
   line += " | " + string(ASC_RUN152_FIRST_MISSING_HARDENED_TOKEN);
   line += " | " + string(ASC_RUN152_MISSING_COUNT_HARDENED_TOKEN);
   line += " | " + string(ASC_RUN152_MISSING_LIST_HARDENED_TOKEN);
   line += " | " + string(ASC_RUN151_MISSING_SURFACE_HOLD_NOT_FAIL_TOKEN);
   return line;
  }

string ASC_Phase8CandidateFilteringSurfaceReadinessLine(const bool scanner_status_ready,
                                                        const bool market_board_ready,
                                                        const bool dossier_ready,
                                                        const bool top5_ready,
                                                        const bool globaltop10_ready,
                                                        const bool logs_ready,
                                                        const bool review_state_ready,
                                                        const bool input_gates_ready,
                                                        const bool blocker_gates_ready,
                                                        const bool safety_boundary_ready)
  {
   bool surface_ready = (scanner_status_ready && market_board_ready && dossier_ready && top5_ready && globaltop10_ready && logs_ready && review_state_ready && input_gates_ready && blocker_gates_ready && safety_boundary_ready);
   string line = "phase8_candidate_filtering_surface_ready=" + (surface_ready ? "true" : "false");
   line += " | phase8_candidate_filtering_scanner_status_ready=" + (scanner_status_ready ? "true" : "false");
   line += " | phase8_candidate_filtering_market_board_ready=" + (market_board_ready ? "true" : "false");
   line += " | phase8_candidate_filtering_dossier_ready=" + (dossier_ready ? "true" : "false");
   line += " | phase8_candidate_filtering_top5_ready=" + (top5_ready ? "true" : "false");
   line += " | phase8_candidate_filtering_globaltop10_ready=" + (globaltop10_ready ? "true" : "false");
   line += " | phase8_candidate_filtering_logs_ready=" + (logs_ready ? "true" : "false");
   line += " | phase8_candidate_filtering_review_state_live_testable=" + (review_state_ready ? "true" : "false");
   line += " | phase8_candidate_filtering_input_gates_live_testable=" + (input_gates_ready ? "true" : "false");
   line += " | phase8_candidate_filtering_blocker_gates_live_testable=" + (blocker_gates_ready ? "true" : "false");
   line += " | phase8_candidate_filtering_safety_boundary_live_testable=" + (safety_boundary_ready ? "true" : "false");
   line += " | phase8_live_ready_requires_required_runtime_surfaces=true | phase8_false_ready_guard=true | " + string(ASC_RUN152_PHASE8_READINESS_TOKEN);
   return line;
  }

string ASC_RoadmapTwoLaneAuditBoundaryLine()
  {
   string line = string(ASC_RUN153_TWO_LANE_AUDIT_REQUIRED_TOKEN);
   line += " | " + string(ASC_RUN153_SOURCE_LANE_REQUIRED_TOKEN);
   line += " | " + string(ASC_RUN153_LIVE_LANE_REQUIRED_TOKEN);
   line += " | " + string(ASC_RUN153_SOURCE_NOT_LIVE_PROOF_TOKEN);
   line += " | " + string(ASC_RUN153_LIVE_REQUIRES_RUNTIME_EVIDENCE_TOKEN);
   line += " | " + string(ASC_RUN153_NO_INFLATED_PROGRESS_TOKEN);
   line += " | " + string(ASC_RUN153_PHASE8_STATUS_TOKEN);
   line += " | " + string(ASC_RUN153_PHASE9_STATUS_TOKEN);
   line += " | " + string(ASC_RUN153_AUDIT_RUNTIME_COMPACT_TOKEN);
   line += " | " + string(ASC_RUN153_NO_AUDIT_WALL_TOKEN);
   line += " | " + string(ASC_RUN153_PROOF_BUNDLE_CLOSEOUT_TOKEN);
   line += " | " + string(ASC_RUN153_PHASE8_FINAL_CHECK_TOKEN);
   line += " | " + string(ASC_RUN153_RUN155_READINESS_TOKEN);
   line += " | " + string(ASC_RUN153_NO_FORMULA_ORDER_DRIFT_TOKEN);
   return line;
  }

string ASC_Run154PreflightLockLine()
  {
   string line = string(ASC_RUN154_REPAIR_SCOPE_TOKEN);
   line += " | " + string(ASC_RUN154_RUN155_PREFLIGHT_REQUIRED_TOKEN);
   line += " | " + string(ASC_RUN154_PROOF_BUNDLE_REQUIRED_FOR_LIVE_PASS_TOKEN);
   line += " | " + string(ASC_RUN154_MISSING_MANDATORY_SURFACE_BLOCKS_PASS_TOKEN);
   line += " | " + string(ASC_RUN154_SOURCE_NOT_LIVE_PROOF_TOKEN);
   line += " | " + string(ASC_RUN154_LIVE_REQUIRES_RUNTIME_EVIDENCE_TOKEN);
   line += " | " + string(ASC_RUN154_REPORT_ONLY_FORBIDDEN_IF_PATCHABLE_TOKEN);
   line += " | " + string(ASC_RUN154_SAFE_PATCH_REQUIRED_WHEN_PATCHABLE_TOKEN);
   line += " | " + string(ASC_RUN154_PHASE8_LIVE_REQUIRES_COMPLETE_BUNDLE_TOKEN);
   line += " | " + string(ASC_RUN154_OPERATOR_PACKAGE_LOCK_TOKEN);
   return line;
  }

string ASC_Run154Phase9StartLockLine()
  {
   string line = string(ASC_RUN154_PHASE9_START_BLOCKED_TOKEN);
   line += " | " + string(ASC_RUN154_PHASE8_LIVE_DECISION_REQUIRED_TOKEN);
   line += " | " + string(ASC_RUN154_PHASE8_SOURCE_READY_NOT_COMPLETE_TOKEN);
   line += " | " + string(ASC_RUN154_PHASE8_LIVE_PROVEN_ONLY_AFTER_RUN155_TOKEN);
   line += " | " + string(ASC_RUN153_PHASE8_STATUS_TOKEN);
   line += " | " + string(ASC_RUN153_PHASE9_STATUS_TOKEN);
   return line;
  }

string ASC_Run155OperatorPackageInstructionLine()
  {
   return string(ASC_RUN154_OPERATOR_PACKAGE_SURFACES_TOKEN)
          + " | screenshots_optional=true | missing_required_surface_impact=HOLD_not_PASS | selected_none_current_focus_not_applicable=true | disabled_by_policy_not_missing_failure=true";
  }

string ASC_Run155LiveContractSeedBlock()
  {
   string block = "RUN155 Live + Research + Source Repair Contract Seed\n";
   block += "- run155_preflight_item=proof_bundle_complete_line | required_evidence=proof_bundle_complete/first_missing/missing_count/missing_list/decision_state | impact=PASS_if_true_else_HOLD\n";
   block += "- run155_preflight_item=complete_runtime_root_upload | required_evidence=server_root_or_export_root_with_required_paths | impact=HOLD_if_incomplete\n";
   block += "- run155_preflight_item=scanner_status_market_board_top5_globaltop10 | required_evidence=current_archive_staging_manifests_as_applicable | impact=HOLD_if_missing\n";
   block += "- run155_preflight_item=dossiers_current_focus_manifest | required_evidence=Dossiers plus Dossier.txt only when selected_symbol_present | impact=HOLD_if_missing_required_not_applicable_if_selected_none\n";
   block += "- run155_preflight_item=functionresults_heartbeat_phase_gates | required_evidence=Workbench/logs/function_results.log,Workbench/logs/heartbeat_telemetry.log,Phase5_6_7_8_gate_tokens | impact=HOLD_if_missing\n";
   block += "- run155_preflight_item=candidate_filtering_surfaces | required_evidence=input_state,blocker_state,review_state,safety_boundary,no_signal_no_execution | impact=HOLD_if_missing_FAIL_if_signal_leakage\n";
   block += "- run155_preflight_item=performance_timer_pressure | required_evidence=heartbeat_duration,budget_state,functionresults_aggregate,proof_bundle_compactness | impact=PATCH_if_safe_HOLD_if_unsafe\n";
   block += "- run155_preflight_lock=" + ASC_Run154PreflightLockLine() + "\n";
   block += "- run155_operator_package_instruction=" + ASC_Run155OperatorPackageInstructionLine() + "\n";
   block += "- next_phase_gate=" + ASC_Run154Phase9StartLockLine() + "\n";
   block += "- run155_live_outcome_rule=PASS_updates_live_lane_only_with_complete_runtime_evidence_HOLD_preserves_phase8_live_held_FAIL_on_signal_or_protected_drift | source_lane_updates_only_with_patch_evidence | live_percent_never_changes_without_runtime_evidence\n";
   block += "- " + string(ASC_RUN151_RUN155_CONTRACT_TOKEN) + " | " + string(ASC_RUN152_RUN155_PREFLIGHT_TOKEN) + " | " + string(ASC_RUN151_NEXT_LIVE_RUN_TOKEN) + " | " + string(ASC_RUN151_PROOF_BOUNDARY) + "\n";
   return block;
  }


string ASC_Run156SpeedTruthFillContractLine()
  {
   string line = string(ASC_RUN156_REPAIR_SCOPE_TOKEN);
   line += " | " + string(ASC_RUN156_RUN155_HOLD_ABSORBED_TOKEN);
   line += " | " + string(ASC_RUN156_OPERATOR_CLARIFICATION_ABSORBED_TOKEN);
   line += " | " + string(ASC_RUN156_SLOW_FILL_PRIMARY_BLOCKER_TOKEN);
   line += " | " + string(ASC_RUN156_FILL_STATE_CLASSIFICATION_TOKEN);
   line += " | " + string(ASC_RUN156_FILL_IN_PROGRESS_NOT_MISSING_TOKEN);
   line += " | " + string(ASC_RUN156_RUN_ENDED_NOT_SOURCE_FAILURE_TOKEN);
   line += " | " + string(ASC_RUN156_NOT_YET_HYDRATED_NOT_SOURCE_GAP_TOKEN);
   line += " | " + string(ASC_RUN156_QUEUE_PROGRESSING_NOT_STALLED_TOKEN);
   line += " | " + string(ASC_RUN156_MISSING_ALONE_NOT_SOURCE_BUG_TOKEN);
   return line;
  }

string ASC_Run156L4SyncFastInfoLine()
  {
   string line = string(ASC_RUN156_L4_SYNC_LAW_TOKEN);
   line += " | " + string(ASC_RUN156_L4_SHARED_EPOCH_TOKEN);
   line += " | " + string(ASC_RUN156_L4_STATIC_MEMBERSHIP_TOKEN);
   line += " | " + string(ASC_RUN156_DISPLAYED_INFO_REFRESH_TOKEN);
   line += " | " + string(ASC_RUN156_L2_DISPLAYED_REFRESH_TOKEN);
   line += " | " + string(ASC_RUN156_L5_DISPLAYED_REFRESH_TOKEN);
   line += " | " + string(ASC_RUN156_L6_DISPLAYED_REFRESH_TOKEN);
   line += " | " + string(ASC_RUN156_TOP5_INFO_REPRINT_TOKEN);
   line += " | " + string(ASC_RUN156_GLOBALTOP10_INFO_REPRINT_TOKEN);
   line += " | " + string(ASC_RUN156_FAST_INFO_REFRESH_LAW_TOKEN);
   line += " | " + string(ASC_RUN156_STATIC_MEMBERSHIP_FRESH_INFO_DISTINCTION_TOKEN);
   return line;
  }

string ASC_Run156BucketFillTargetLine()
  {
   string line = string(ASC_RUN156_BUCKET_FILL_TARGET_TOKEN);
   line += " | " + string(ASC_RUN156_BUCKET_FILL_PROGRESS_FIELDS_TOKEN);
   line += " | bucket_fill_elapsed_seconds=runtime_value_pending";
   line += " | buckets_total=runtime_value_pending";
   line += " | buckets_with_visible_info=runtime_value_pending";
   line += " | buckets_pending=runtime_value_pending";
   line += " | buckets_stalled=runtime_value_pending";
   line += " | l4_membership_age_seconds=runtime_value_pending";
   line += " | displayed_symbol_info_age_seconds=runtime_value_pending";
   return line;
  }

string ASC_Run156ProtectedBoundaryLine()
  {
   string line = string(ASC_RUN156_HUD_INSTANT_CONSUMER_DEFERRED_TOKEN);
   line += " | " + string(ASC_RUN156_NO_FORMULA_ORDER_DRIFT_TOKEN);
   line += " | " + string(ASC_RUN156_NO_FILEIO_HEARTBEAT_DRIFT_TOKEN);
   line += " | " + string(ASC_RUN156_NO_SIGNAL_EXECUTION_DRIFT_TOKEN);
   line += " | " + string(ASC_RUN156_NO_HEAVY_SCAN_TOKEN);
   line += " | " + string(ASC_RUN156_NO_FLUSH_LOOP_TOKEN);
   line += " | " + string(ASC_RUN156_PHASE8_LIVE_UNPROVEN_TOKEN);
   line += " | " + string(ASC_RUN156_PHASE9_BLOCKED_TOKEN);
   line += " | " + string(ASC_RUN156_NEXT_LIVE_TOKEN);
   return line;
  }

string ASC_Run156SpeedTruthFillContractBlock()
  {
   string block = "RUN156 Speed + Truth-Fill Contract Seed\n";
   block += "- fill_state_classification: " + ASC_Run156SpeedTruthFillContractLine() + "\n";
   block += "- l4_sync_fast_info: " + ASC_Run156L4SyncFastInfoLine() + "\n";
   block += "- bucket_fill_target: " + ASC_Run156BucketFillTargetLine() + "\n";
   block += "- protected_boundaries: " + ASC_Run156ProtectedBoundaryLine() + "\n";
   return block;
  }

string ASC_SetupModeLabelPullback()              { return "setup_mode_pullback"; }
string ASC_SetupModeLabelRetest()                { return "setup_mode_retest"; }
string ASC_SetupModeLabelBreakout()              { return "setup_mode_breakout"; }
string ASC_SetupModeLabelRejection()             { return "setup_mode_rejection"; }
string ASC_SetupModeLabelNoTrade()               { return "setup_mode_no_trade"; }
string ASC_SetupModeLabelInsufficientEvidence()  { return "setup_mode_insufficient_evidence"; }

string ASC_PermissionBlockedSyncMismatch()           { return "permission_blocked_sync_mismatch"; }
string ASC_PermissionBlockedMissingDossier()         { return "permission_blocked_missing_dossier"; }
string ASC_PermissionBlockedRoleMismatch()           { return "permission_blocked_role_mismatch"; }
string ASC_PermissionReviewPullbackPreferred()       { return "permission_review_pullback_preferred"; }
string ASC_PermissionBlockedBreakoutContextWeak()    { return "permission_blocked_breakout_context_weak"; }
string ASC_PermissionLimitedSampleInsufficient()     { return "permission_limited_sample_insufficient"; }
string ASC_PermissionBlockedSpreadRisk()             { return "permission_blocked_spread_risk"; }
string ASC_PermissionLimitedCorrelationCluster()     { return "permission_limited_correlation_cluster"; }
string ASC_PermissionFuturePendingExpiryRequired()   { return "permission_future_pending_expiry_required"; }

string ASC_Phase5DossierPermissionContextLine()
  {
   return "Phase 5 Permission Context Boundary: " + ASC_Phase5NoSignalBoundaryText()
          + " | " + ASC_Phase5SourceReadyProofLine()
          + " | " + ASC_Phase5StrategyPermissionGateSummaryLine()
          + " | " + ASC_Phase5StrategyPermissionStateLine()
          + " | " + ASC_Phase5SiamEdgeGateLine();
  }

#endif
