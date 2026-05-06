#ifndef __ASC_BOOTSTRAP_MQH__
#define __ASC_BOOTSTRAP_MQH__

#include "ASC_ServerPaths.mqh"
#include "ASC_DirectorySetup.mqh"
#include "../core/ASC_RuntimeState.mqh"
#include "../io/ASC_WorkbenchPaths.mqh"
#include "../logging/ASC_Logging.mqh"
#include "../artifacts/ASC_MarketBoardWriter.mqh"
#include "../artifacts/ASC_CurrentFocusWriter.mqh"
#include "../artifacts/ASC_DossierWriter.mqh"
#include "../menu/ASC_TraderControlRegistry.mqh"
#include "../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"



string ASC_CurrentFocusArtifactLiveSymbol(const string payload_text)
  {
   string live_symbol = ASC_TextExtractLabeledLineValue(payload_text, "Canonical Symbol:");
   if(StringLen(live_symbol) <= 0)
      live_symbol = ASC_TextExtractLabeledLineValue(payload_text, "Symbol:");
   return live_symbol;
  }

void ASC_RestoreCurrentFocusRuntimeTruth(ASC_RuntimeState &state)
  {
   if(StringLen(state.current_focus_path) <= 0)
      return;

   string payload = "";
   if(!ASC_ReadTextFile(state.current_focus_path, payload) || StringLen(payload) <= 0)
      return;

   string live_symbol = ASC_CurrentFocusArtifactLiveSymbol(payload);
   if(StringLen(live_symbol) <= 0)
      return;

   state.current_focus_live_symbol = live_symbol;
   if(StringLen(state.current_focus_last_status) <= 0 || state.current_focus_last_status == "idle")
      state.current_focus_last_status = "state_aligned";
   if(StringLen(state.current_focus_last_reason) <= 0)
      state.current_focus_last_reason = "state reset needed: Current Focus ownership restored from artifact readback during bootstrap";

   datetime modified_utc = 0;
   if(ASC_FileTryGetModifyUtc(state.current_focus_path, modified_utc) && modified_utc > 0)
      state.current_focus_last_served_utc = modified_utc;
  }

ASC_FunctionResult ASC_BootstrapRuntime(ASC_RuntimeState &state)
  {
   ASC_FunctionResult result;
   ASC_FunctionResultBegin(result, "ASC_Bootstrap", "ASC_BootstrapRuntime", "runtime");
   ASC_FunctionResultSetTruthBoundary(result, "runtime.bootstrap", "runtime_startup_restore");
   ASC_FunctionResultMarkSourceSupportedRuntimeUnproven(result);

   string server_root = ASC_ServerRootPath();
   if(!ASC_PrepareRuntimeFolders(server_root))
     {
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_BOOTSTRAP_FAILED,
                               "Unable to prepare runtime folders.",
                               server_root);
      state.posture = ASC_RUNTIME_DEGRADED;
      return result;
     }

   state.server_root = server_root;
   state.market_board_path = ASC_MarketBoardContract(server_root).target_path;
   state.current_focus_path = ASC_CurrentFocusContract(server_root).target_path;
   state.dossiers_path = server_root + "\\" + ASC_DOSSIER_FOLDER;
   state.bundle_manifest_path = server_root + "\\" + ASC_ARTIFACT_BUNDLE_MANIFEST_FILE;
   state.workbench_root = ASC_WorkbenchRoot(server_root);
   state.temp_path = ASC_WorkbenchTemp(server_root);
   state.failed_path = ASC_WorkbenchFailed(server_root);
   state.logs_path = ASC_WorkbenchLogs(server_root);
   state.function_results_log_path = state.logs_path + "\\" + ASC_FUNCTION_RESULT_LOGFILE;
   state.heartbeat_log_path = state.logs_path + "\\" + ASC_HEARTBEAT_LOGFILE;
   state.posture = ASC_RUNTIME_READY;
   state.mode = ASC_MODE_WARMUP;
   state.started_utc = TimeGMT();
   state.last_heartbeat_utc = state.started_utc;
   state.last_scan_utc = 0;
   state.last_write_utc = 0;
   state.last_tick_utc = 0;
   state.active_lane = ASC_LANE_SCAN;
   state.active_sublane = ASC_SUBLANE_L1_BROAD_SCAN;
   state.heartbeat_counter = 0;
   state.scan_cursor = 0;
   state.write_cursor = 0;
   state.scan_budget_symbols = g_asc_trader_controls.scan_budget_symbols;
   state.l1_packet_target = g_asc_trader_controls.l1_packet_target;
   state.l1_burst_max = g_asc_trader_controls.l1_burst_max_per_heartbeat;
   state.write_budget_artifacts = g_asc_trader_controls.write_budget_artifacts;
   state.beats_since_write = 0;
   state.deferred_scan_symbols = 0;
   state.deferred_write_artifacts = 0;
   state.l2_scan_cursor = 0;
   state.l2_packet_budget = ASC_L2_PACKET_BUDGET_PER_HEARTBEAT;
   state.l2_packet_completed = 0;
   state.l2_admitted_symbols = 0;
   state.l2_due_remaining = 0;
   state.l2_changed_symbols = 0;
   state.l2_last_scan_utc = 0;
   state.l2_next_due_utc = 0;
   state.l2_next_due_reason = "awaiting-admission";
   state.layer2_dirty = true;
   state.l2_publish_pending = false;
   state.l2_last_published_revision = 0;
   state.layer1_dirty = true;
   state.write_dirty = false;
   state.write_force = false;
   state.write_failure_streak = 0;
   state.write_cooldown_until_utc = 0;
   state.board_manual_refresh_pending = false;
   state.board_manual_refresh_inflight = false;
   state.board_manual_refresh_requested_utc = 0;
   state.board_manual_refresh_request_seq = 0;
   state.board_manual_refresh_trigger = "unobserved";
   state.board_manual_refresh_last_served_utc = 0;
   state.board_manual_refresh_last_status = "idle";
   state.board_manual_refresh_last_reason = "";
   state.forced_downstream_refresh_pending = false;
   state.forced_downstream_refresh_requested_utc = 0;
   state.forced_downstream_refresh_request_seq = 0;
   state.forced_downstream_refresh_scope = "idle";
   state.forced_downstream_refresh_symbol = "";
   state.forced_downstream_refresh_last_served_utc = 0;
   state.forced_downstream_refresh_last_status = "idle";
   state.forced_downstream_refresh_last_reason = "";
   state.deep_focus_trigger_pending = false;
   state.deep_focus_trigger_symbol = "";
   state.deep_focus_trigger_requested_utc = 0;
   state.deep_focus_trigger_last_served_utc = 0;
   state.deep_focus_trigger_last_status = "idle";
   state.deep_focus_last_symbol = "";
   state.deep_focus_last_reason = "";
   state.current_focus_view_pending = false;
   state.current_focus_view_symbol = "";
   state.current_focus_view_requested_utc = 0;
   state.current_focus_last_served_utc = 0;
   state.current_focus_last_status = "idle";
   state.current_focus_live_symbol = "";
   state.hud_selected_symbol = "";
   state.hud_selected_symbol_observed_utc = 0;
   state.essential_failure_streak = 0;
   state.essential_backoff_until_utc = 0;
   state.dossier_failure_streak = 0;
   state.dossier_backoff_until_utc = 0;
   state.publication_bundle.publication_id = "";
   state.publication_bundle.publication_utc = 0;
   state.publication_bundle.bundle_started_utc = 0;
   state.publication_bundle.bundle_finished_utc = 0;
   state.publication_bundle.board_lifecycle_state = "idle";
   state.publication_bundle.board_refresh_trigger = "unobserved";
   state.publication_bundle.board_refresh_requested_utc = 0;
   state.publication_bundle.board_refresh_consumed_utc = 0;
   state.publication_bundle.board_recompute_started_utc = 0;
   state.publication_bundle.board_recompute_finished_utc = 0;
   state.publication_bundle.board_publish_started_utc = 0;
   state.publication_bundle.board_publish_finished_utc = 0;
   state.publication_bundle.board_publish_result = "idle";
   state.publication_bundle.board_publish_skip_reason = "none";
   state.publication_bundle.market_board_status = "idle";
   state.publication_bundle.open_symbol_snapshot_status = "idle";
   state.publication_bundle.dossier_attempted_count = 0;
   state.publication_bundle.dossier_success_count = 0;
   state.publication_bundle.dossier_failure_count = 0;
   state.publication_bundle.overall_bundle_status = "idle";
   state.publication_bundle.last_bundle_error_summary = "";
   state.publication_shortlist_ready = false;
   state.publication_shortlist_pass_utc = 0;
   state.publication_shortlist_total = 0;
   ArrayResize(state.publication_shortlist_rows, 0);
   ASC_Layer2Reset();

   bool function_results_log_existed = FileIsExist(state.function_results_log_path, FILE_COMMON);
   if(!function_results_log_existed)
     {
      string header = ASC_FUNCTION_RESULTS_LOG_HEADER_LINE;
      ASC_FunctionResultSetHydrationClass(result, "run020_header_contract=" + ASC_FunctionResultsLogHeaderExpected());
      ASC_FunctionResultMarkSourceSupportedRuntimeUnproven(result);
      ResetLastError();
      if(!ASC_WriteTextFile(state.function_results_log_path, header))
        {
         state.function_results_log_write_attempted = true;
         state.function_results_log_write_succeeded = false;
         state.function_results_log_last_error = GetLastError();
         state.function_results_log_last_write_utc = TimeGMT();
         state.function_results_log_last_status = "header_write_failed";
         state.function_results_log_last_detail = "header_contract_write_failed";
         ASC_FunctionResultMarkUnavailableProof(result);
         ASC_FunctionResultFinish(result,
                                  ASC_RESULT_ERROR,
                                  ASC_RC_BOOTSTRAP_FAILED,
                                  "Unable to initialize function result log file.",
                                  state.function_results_log_path);
         state.posture = ASC_RUNTIME_DEGRADED;
         return result;
        }

      state.function_results_log_write_attempted = true;
      state.function_results_log_write_succeeded = true;
      state.function_results_log_last_error = 0;
      state.function_results_log_last_write_utc = TimeGMT();
      state.function_results_log_last_status = "header_written";
      state.function_results_log_last_detail = "header_contract=" + ASC_FunctionResultsLogHeaderExpected();
     }
   else
     {
      state.function_results_log_last_status = "existing_log_detected";
      state.function_results_log_last_detail = "existing_log_detected_bootstrap_marker_still_required";
     }

   ASC_FunctionResult log_contract_marker;
   ASC_FunctionResultBegin(log_contract_marker,
                           "ASC_Bootstrap",
                           "ASC_FunctionResultsLogContract",
                           "runtime");
   ASC_FunctionResultSetTruthBoundary(log_contract_marker,
                                      "runtime.bootstrap",
                                      "runtime_log_contract");
   ASC_FunctionResultSetHydrationClass(log_contract_marker, "not_applicable");
   ASC_FunctionResultSetProof(log_contract_marker,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_RUNTIME_LOG_REQUIRED,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_RUNTIME_OBSERVED);
   string log_contract_detail = function_results_log_existed
                                ? "function_results_contract_bootstrap_marker_existing_log"
                                : "function_results_contract_bootstrap_marker_header_created";
   log_contract_detail = ASC_ClaimEvidenceAppend(log_contract_detail,
                                                 ASC_CE_SRC_RT_UNPROVEN,
                                                 "runtime.bootstrap.contract_marker;claim_evidence_contract_source_support",
                                                 ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN030);
   ASC_FunctionResultFinish(log_contract_marker,
                            ASC_RESULT_OK,
                            ASC_RC_OK,
                            log_contract_detail,
                            state.function_results_log_path);

   int function_results_marker_error = 0;
   state.function_results_log_write_attempted = true;
   bool function_results_marker_written = ASC_LogFunctionResultToFileObserved(log_contract_marker,
                                                                             state.function_results_log_path,
                                                                             function_results_marker_error);
   state.function_results_log_write_succeeded = function_results_marker_written;
   state.function_results_log_last_error = function_results_marker_error;
   state.function_results_log_last_write_utc = TimeGMT();
   state.function_results_log_last_status = function_results_marker_written ? "bootstrap_marker_written" : "bootstrap_marker_write_failed";
   state.function_results_log_last_detail = function_results_marker_written
                                           ? ASC_ClaimEvidenceAppend("proof_row=function_results_contract_bootstrap_marker",
                                                                    ASC_CE_SRC_RT_UNPROVEN,
                                                                    "runtime.bootstrap.contract_marker;claim_evidence_contract_source_support",
                                                                    ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN030)
                                           : "proof_row_write_failed=function_results_contract_bootstrap_marker";
   if(!function_results_marker_written)
     {
      ASC_FunctionResultMarkUnavailableProof(result);
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_BOOTSTRAP_FAILED,
                               "Unable to write function-results bootstrap proof row.",
                               state.function_results_log_path);
      state.posture = ASC_RUNTIME_DEGRADED;
      return result;
     }

   ASC_FunctionResult phase3a_marker;
   ASC_FunctionResultBegin(phase3a_marker,
                           "ASC_Bootstrap",
                           "ASC_Phase3ALoggingSpineProof",
                           "runtime");
   ASC_FunctionResultSetTruthBoundary(phase3a_marker,
                                      "runtime.bootstrap",
                                      "phase3a_logging_spine");
   ASC_FunctionResultSetHydrationClass(phase3a_marker, "not_applicable");
   ASC_FunctionResultSetProof(phase3a_marker,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_RUNTIME_LOG_REQUIRED,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_RUNTIME_OBSERVED);
   ASC_FunctionResultFinish(phase3a_marker,
                            ASC_RESULT_OK,
                            ASC_RC_OK,
                            ASC_FRRun098Phase3AProofTokens("Phase_3A_Logging_Spine",
                                                            "closed_with_bounded_carry_forward_debt_into_RUN100R",
                                                            "source_supported_runtime_unproven",
                                                            "source_supported_runtime_unproven",
                                                            state.dossier_queue_state,
                                                            "source_supported_runtime_unproven",
                                                            "source_supported_runtime_unproven",
                                                            "bootstrap_marker_live_budget_unproven_until_heartbeat",
                                                            "source_identity_required_in_manifest_summary",
                                                            "file_exists_not_currentness_proof",
                                                            state.top10_run_full_batch_status,
                                                            "root_current_dossier_derivative_boundary",
                                                            state.top10_run_full_family_alignment_status,
                                                            0,
                                                            "none",
                                                            0,
                                                            false),
                            state.function_results_log_path);

   int phase3a_marker_error = 0;
   bool phase3a_marker_written = ASC_LogFunctionResultToFileObserved(phase3a_marker,
                                                                     state.function_results_log_path,
                                                                     phase3a_marker_error);
   state.function_results_log_write_attempted = true;
   state.function_results_log_write_succeeded = phase3a_marker_written;
   state.function_results_log_last_error = phase3a_marker_error;
   state.function_results_log_last_write_utc = TimeGMT();
   state.function_results_log_last_status = phase3a_marker_written ? "phase3a_bootstrap_marker_written" : "phase3a_bootstrap_marker_write_failed";
   state.function_results_log_last_detail = phase3a_marker_written ? ASC_PHASE3A_FUNCTIONRESULTS_GREP_TARGET : "proof_row_write_failed=phase3a_logging_spine";
   if(!phase3a_marker_written)
     {
      ASC_FunctionResultMarkUnavailableProof(result);
      ASC_FunctionResultFinish(result,
                               ASC_RESULT_ERROR,
                               ASC_RC_BOOTSTRAP_FAILED,
                               "Unable to write Phase 3A logging spine proof row.",
                               state.function_results_log_path);
      state.posture = ASC_RUNTIME_DEGRADED;
      return result;
     }

   if(!FileIsExist(state.heartbeat_log_path, FILE_COMMON))
     {
      string header = "heartbeat_id\tbeat_utc\tmode\tlane\tsublane\tphase3a_heartbeat_telemetry\tactive_lane\tmajor_work_type\telapsed_ms\tbudget_ms\tbudget_state\tqueue_remaining\tbackfill_remaining\tdossier_write_count\tglobaltop10_child_work_count\tscanner_status_write\tfunctionresults_write\tdeferred_work_count\tskipped_due_budget_count\ttimer_pressure_state\tno_freeze_state\trequires_operator_review\tscan_budget\twrite_budget\tpacket_target\tpacket_completed\tbursts\tdue_selected\tretry_selected\tscanned\tl2_processed\tl2_admitted\tl2_changed\tl2_due\tscan_streak\twrite_streak\twritten\twrite_failures\tdeferred_scan\tdeferred_write\tdeep_ms\tboard_compose_ms\tboard_publish_ms\tdossier_compose_ms\tdossier_publish_ms\tmanifest_compose_ms\tmanifest_publish_ms\twrite_queue_ms\tartifact_attempted\twrite_bottleneck_family\twrite_bottleneck_reason\ttop10_ms\tside_duty_ms\tdossier_sweep_ms\tdossier_sweep_symbols\tdossier_sweep_reads\theartbeat_ms\theartbeat_budget_ms\tlane_p50_ms\tlane_p95_ms\tui_priority\twake_hot\twake_warm\twake_calm\twake_dormant\tl2_live_entitled\tdossier_open_entitled\tretention_only\tlayer1_readiness_trace\tshortlist_publication_trace\tlane_reason\tdefer\tyield\tbundle_trace\tmanual_refresh_trace\tforced_downstream_trace\ttop10_batch_trace\tl3_trace\tl4_trace\n";
      if(!ASC_WriteTextFile(state.heartbeat_log_path, header))
        {
         ASC_FunctionResultMarkDependencyBlocked(result);
         ASC_FunctionResultFinish(result,
                                  ASC_RESULT_ERROR,
                                  ASC_RC_BOOTSTRAP_FAILED,
                                  "Unable to initialize heartbeat telemetry log file.",
                                  state.heartbeat_log_path);
         state.posture = ASC_RUNTIME_DEGRADED;
         return result;
        }
     }

   ASC_RestoreCurrentFocusRuntimeTruth(state);

   ASC_FunctionResultFinish(result,
                            ASC_RESULT_OK,
                            ASC_RC_OK,
                            "Runtime bootstrap initialized with dispatcher/governor control paths.",
                            server_root);
   return result;
  }

#endif
