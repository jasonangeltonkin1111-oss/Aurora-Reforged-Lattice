#ifndef __ASC_FUNCTION_RESULTS_MQH__
#define __ASC_FUNCTION_RESULTS_MQH__

#include "../core/ASC_Types.mqh"
#include "../core/ASC_ResultCodes.mqh"
#include "../core/ASC_Version.mqh"
#include "../core/ASC_Constants.mqh"

#define ASC_FUNCTION_RESULTS_LOG_EXPECTED_RELATIVE_PATH "Workbench/logs/function_results.log"
#define ASC_FUNCTION_RESULTS_LOG_REQUIRED_KEYS "source_owner,truth_boundary,hydration_class,proof_event,proof_status,claim_evidence_status,proof_row_class"
#define ASC_FUNCTION_RESULTS_LOG_BUDGET_STATUS "required_bounded"
#define ASC_FUNCTION_RESULTS_SPAM_GUARD_STATUS "source_supported_runtime_unproven"
#define ASC_FUNCTION_RESULTS_REQUIRED_ROWS_MUST_NOT_BE_THROTTLED "bootstrap,manifest_writer,dossier_hydration,current_focus_expectation,artifact_publication,selected_current_alignment,market_board_compression,cross_artifact_alignment,operator_surface_claim_boundary,errors_failures"
#define ASC_FUNCTION_RESULTS_LOG_BUDGET_RUN040_CHECKS "log_exists,exists_readable,header_fields_exist,row_keys_exist,bootstrap_marker_exists,size_reasonable,row_count_reasonable,required_rows_present,repeated_proof_contract_rows_not_excessive,proof_row_class_details_present,claim_evidence_status_details_present,no_required_rows_suppressed,no_strategy_ranking_hud_or_operator_content_change"
#define ASC_FUNCTION_RESULTS_LOG_BUDGET_RUN050_CHECKS "log_exists,exists_readable,header_fields_exist,row_keys_exist,compact_seam_detail_keys_exist_where_emitted,seam_status_runtime_observed_requires_actual_log_row,bootstrap_marker_exists,file_size_recorded,row_count_recorded,size_reasonable,row_count_reasonable,required_rows_present,repeated_identical_proof_rows_inspected,repeated_bootstrap_proof_contract_rows_not_excessive,proof_row_class_distribution_visible_if_emitted,proof_row_class_details_present,claim_evidence_status_details_present,no_required_rows_suppressed,error_rows_not_suppressed,no_per_symbol_proof_spam,no_strategy_ranking_hud_or_operator_content_change"
#define ASC_FUNCTION_RESULTS_LOG_BUDGET_SUMMARY_KEYS "function_results_log_budget_summary=present;actual_log_required=yes;row_count_check_required=yes;file_size_check_required=yes;repeated_row_noise_check_required=yes;required_rows_must_not_be_suppressed=yes;per_symbol_proof_spam_forbidden=yes;budget_runtime_proof=deferred_to_run050"
#define ASC_FUNCTION_RESULTS_LOG_BUDGET_JUDGEMENT_TAXONOMY "reasonable,watch,excessive,unreadable,missing,source_supported_runtime_unproven"
#define ASC_FUNCTION_RESULTS_LOG_BUDGET_SUMMARY_RUN050_CHECKS "Function Results Log Budget Summary line exists;actual Workbench/logs/function_results.log included and readable;total file size recorded;total row count recorded;repeated identical proof rows inspected;repeated bootstrap/proof-contract rows not excessive;required rows present;required proof rows not suppressed;errors/failures not suppressed;proof row classes used where emitted;no per-symbol proof spam;no log schema change;no FileIO rewrite"
#define ASC_FUNCTION_RESULTS_REQUIRED_ROW_VS_SPAM_RULES "missing_required_rows=proof_failure;excessive_repeated_required_rows=spam_risk;error_rows_must_not_be_suppressed=yes;required_once_rows_should_not_repeat_excessively=yes;artifact_boundary_rows_may_emit_per_artifact_not_per_symbol_unless_already_lawful=yes;state_change_rows_should_not_repeat_without_state_change=yes;diagnostic_summary_rows_must_stay_compact=yes"
#define ASC_FUNCTION_RESULTS_BOUNDED_CONTRADICTION_PROOF_LINE_NAME "Function Results Bounded Contradiction Proof Observability"
#define ASC_FUNCTION_RESULTS_BOUNDED_CONTRADICTION_PROOF_KEYS "contradiction_proof_observability,functionresults_truth_owner,functionresults_publication_blocker,functionresults_schema_change,functionresults_high_cardinality,per_symbol_rows,per_trade_rows,per_closed_trade_rows,per_timeframe_rows,per_bar_rows,per_tick_rows,per_artifact_section_rows,proof_debt_closed_by_log,source_supported_runtime_observed_boundary,source_patched_live_unproven_boundary,l3_l4_l5_support_only,portfolio_history_boundary,globaltop10_category_only,no_new_runtime_lane,no_fileio_change,no_flush_frequency_change,no_dispatcher_lane_change,no_hud_change"
#define ASC_FUNCTION_RESULTS_BOUNDED_CONTRADICTION_PROOF_RUN074R_CHECKS "single_aggregate_manifest_line_exists,finish_detail_contains_same_compact_tokens,no_schema_change,no_new_rows,no_per_symbol_per_trade_per_timeframe_per_section_spam,no_fileio_or_flush_frequency_change,no_dispatcher_lane_change,no_truth_owner_no_publication_blocker_no_trade_signal_no_execution_decision_no_live_proof_closure"
#define ASC_FUNCTION_RESULTS_OUTPUT_PACKAGE_REQUIRED_FILE "Workbench/logs/function_results.log"
#define ASC_FUNCTION_RESULTS_OUTPUT_PACKAGE_OMISSION_CLASS "output_package_omission"
#define ASC_FUNCTION_RESULTS_RUNTIME_WRITE_FAILED_CLASS "runtime_write_failed"
#define ASC_FUNCTION_RESULTS_SOURCE_CONTRACT_MISSING_CLASS "source_contract_missing"
#define ASC_FUNCTION_RESULTS_RUNTIME_UNPROVEN_CLASS "runtime_unproven"
#define ASC_FUNCTION_RESULTS_PACKAGE_PRESENCE_UNVERIFIED_CLASS "runtime_write_succeeded_package_presence_unverified"
#define ASC_PACKAGE_COMPLETENESS_COMPLETE_REQUIRED_CLASS "complete_for_required_proof"
#define ASC_PACKAGE_COMPLETENESS_MISSING_REQUIRED_CLASS "missing_required_artifact"
#define ASC_PACKAGE_COMPLETENESS_MISSING_OPTIONAL_CLASS "missing_optional_artifact"
#define ASC_PACKAGE_COMPLETENESS_DERIVATIVE_EXPECTED_CLASS "derivative_artifact_expected"
#define ASC_PKG_COMPLETE_SRC_RT_UNPROVEN_CLASS "source_supported_runtime_unproven"
#define ASC_PACKAGE_COMPLETENESS_OUTPUT_PACKAGE_OMISSION_CLASS "output_package_omission"
#define ASC_PACKAGE_COMPLETENESS_NOT_APPLICABLE_CLASS "not_applicable"
#define ASC_PACKAGE_COMPLETENESS_RUNTIME_UNPROVEN_CLASS "runtime_unproven"
#define ASC_PACKAGE_COMPLETENESS_CURRENT_OUTPUT_PRESENT_CLASS "current_output_present"
#define ASC_PACKAGE_COMPLETENESS_ARCHIVE_ONLY_CLASS "archive_only"
#define ASC_PACKAGE_COMPLETENESS_PREVIOUS_RUN_ONLY_CLASS "previous_run_only"
#define ASC_PACKAGE_COMPLETENESS_RETAINED_LAST_GOOD_CLASS "retained_last_good"
#define ASC_PACKAGE_COMPLETENESS_STALE_TIMESTAMP_CLASS "stale_timestamp"
#define ASC_PACKAGE_COMPLETENESS_SOURCE_SUPPORTED_ONLY_CLASS "source_supported_only"
#define ASC_PACKAGE_COMPLETENESS_CURRENT_RUNTIME_UNPROVEN_CLASS "current_runtime_unproven"
#define ASC_PACKAGE_COMPLETENESS_TAXONOMY "complete_for_required_proof,missing_required_artifact,missing_optional_artifact,derivative_artifact_expected,source_supported_runtime_unproven,output_package_omission,not_applicable,runtime_unproven,current_output_present,archive_only,previous_run_only,retained_last_good,stale_timestamp,source_supported_only,current_runtime_unproven"
#define ASC_OUTPUT_ARTIFACT_LOCATOR_REQUIRED_ARTIFACTS "manifest,dossier,globaltop10,function_results_log"
#define ASC_OUTPUT_ARTIFACT_LOCATOR_REQUIRED_PATHS "Artifact Bundle Manifest.txt,Dossier.txt,Dossiers/GlobalTop10/,Workbench/logs/function_results.log"
#define ASC_OUTPUT_ARTIFACT_LOCATOR_OPTIONAL_ARTIFACTS "market_board,scanner_status,open_symbol_snapshot,expert_logs,compile_output"
#define ASC_OUTPUT_ARTIFACT_LOCATOR_OPTIONAL_PATHS "Market Board.txt if produced,Scanner Status.txt if produced,Open Symbol Snapshot.txt if produced,Expert logs/screenshots if available,MetaEditor compile output if available"
#define ASC_OUTPUT_ARTIFACT_LOCATOR_DERIVATIVE_ARTIFACTS "current_focus"
#define ASC_OUTPUT_ARTIFACT_LOCATOR_CURRENT_FOCUS_EXPECTATION "derivative_or_explicit_contract"
#define ASC_OUTPUT_ARTIFACT_LOCATOR_RUNTIME_PROOF "deferred_to_run050"
#define ASC_OUTPUT_ARTIFACT_LOCATOR_ACTUAL_PACKAGE_PROOF_REQUIREMENT "manifest_locator_is_not_uploaded_package_proof; run050_must_inspect_actual_current_output_package; archive_folders_are_historical_evidence_only"
#define ASC_FUNCTION_RESULTS_ROW_LEVEL_PROOF_SUMMARY_SUPPORT "row_keys,detail_keys,proof_row_classes,bootstrap_marker,actual_log_required_for_row_level_proof,row_level_seam_emission_contract,compact_seam_detail_key_standard,required_seam_inventory,no_spam_guard"
#define ASC_CANONICAL_BASELINE_RECONCILIATION_SUPPORT "run041_function_results_output_package_contract,run042_function_results_row_level_proof_summary,run043_output_artifact_locator"
#define ASC_CANONICAL_BASELINE_RECONCILIATION_REQUIRED_LINES "Function Results Output Package Contract:,RUN050 Required Output Package:,Function Results Row-Level Proof Summary:,Row-Level Seam Emission Contract:,Function Results Log Budget Summary:,Output Artifact Locator:,Current vs Archive Artifact Boundary:"
#define ASC_CANONICAL_BASELINE_RECONCILIATION_SOURCE_DECISION "reconciled_from_supplied_run043_source;run042_report_not_supplied;support_verified_in_source_not_assumed_from_report"
#define ASC_CANONICAL_BASELINE_RECONCILIATION_PROOF_BOUNDARY "source_reconciled_runtime_actual_log_and_package_proof_deferred_to_run050"
#define ASC_CURRENT_ARCHIVE_ARTIFACT_BOUNDARY_KEYS "current_artifact_required_for_run050=yes;archive_artifact_is_evidence_only=yes;previous_run_file_not_current_proof=yes;retained_last_good_requires_label=yes;source_supported_not_runtime_proof=yes;current_output_package_required=yes"
#define ASC_CURRENT_ARCHIVE_ARTIFACT_BOUNDARY_CLASSIFICATION "current_output_present,archive_only,previous_run_only,retained_last_good,stale_timestamp,source_supported_only,current_runtime_unproven"
#define ASC_CURRENT_ARCHIVE_ARTIFACT_BOUNDARY_PROOF_RULE "run050_must_use_fresh_current_output_package;archive_and_previous_run_files_are_evidence_only;retained_last_good_supports_continuity_only_when_labelled;source_supported_lines_are_not_runtime_proof"
#define ASC_CURRENT_ARCHIVE_CURRENT_FOCUS_RULE "root_Dossier_txt_can_satisfy_Current_Focus_derivative_package_presence_only_when_current_output;retained_last_good_Dossier_is_continuity_evidence_not_fresh_Current_Focus_proof;separate_Current_Focus_file_required_only_if_source_contract_expects_separate_file"
#define ASC_ROW_LEVEL_SEAM_EMISSION_CONTRACT_KEYS "row_level_seam_contract=present;actual_log_required=yes;manifest_line_not_row_proof=yes;conditional_seams_may_be_runtime_unobserved=yes;runtime_observed_requires_log_row=yes;row_level_runtime_proof=deferred_to_run050"
#define ASC_ROW_LEVEL_SEAM_DETAIL_KEY_STANDARD "seam,seam_status,claim_evidence_status,proof_row_class,runtime_observed,source_supported,behavior_change"
#define ASC_ROW_LEVEL_SEAM_DETAIL_KEY_EXPECTATION "seam=<stable.seam.name>;seam_status=<taxonomy>;claim_evidence_status=<taxonomy>;proof_row_class=<required_once|artifact_boundary|state_change|error_only|diagnostic_summary>;runtime_observed=<yes|no>;source_supported=<yes|no>;behavior_change=no"
#define ASC_ROW_LEVEL_SEAM_STATUS_TAXONOMY "runtime_observed,source_supported_runtime_unobserved,missing,not_applicable,stale,output_package_omission,runtime_write_failed,source_contract_missing,insufficient_evidence"
#define ASC_ROW_LEVEL_REQUIRED_SEAM_INVENTORY "runtime.bootstrap.contract_marker,artifact.manifest.proof_boundary,dossier.hydration_required_token_validation,artifact.publication_status_boundary,selected_artifact.alignment_boundary,market_board.artifact_compression_boundary,cross_artifact.alignment_witness,operator_surface.claim_boundary,current_focus.expectation_boundary,evidence.availability_boundary,evidence.recovery_boundary,evidence.recheck_boundary,candidate.evidence_intake_boundary,shortlist.evidence_intake_boundary,market_board.evidence_intake_boundary,evidence.intake_chain,current_vs_archive.artifact_boundary,output_artifact.locator_boundary,function_results.output_package_contract,function_results.row_level_summary"
#define ASC_ROW_LEVEL_SEAM_NO_SPAM_GUARD "emit_required_once_artifact_boundary_state_change_error_only_or_diagnostic_summary_only;no_per_symbol_proof_spam=yes;no_every_heartbeat_proof_spam=yes;no_heavy_log_loop=yes;required_proof_rows_must_not_be_suppressed=yes;run050_must_inspect_size_row_count_and_repeated_row_noise=yes"
#define ASC_ROW_LEVEL_SEAM_CONTRACT_RUN050_CHECKS "Row-Level Seam Emission Contract line exists;actual Workbench/logs/function_results.log included and readable;emitted rows contain compact seam detail keys where applicable;runtime_observed requires actual row evidence;source_supported_runtime_unobserved remains unclosed;manifest lines are not row proof;no per-symbol proof spam;no log schema change;no FileIO rewrite"
#define ASC_FUNCTION_RESULTS_RUN050_REQUIRED_OUTPUT_PACKAGE "fresh/current Artifact Bundle Manifest.txt,fresh/current Dossier.txt,fresh/current Dossiers/GlobalTop10/,fresh/current Workbench/logs/function_results.log,Market Board.txt if produced from current output,Scanner Status.txt if produced from current output,Open Symbol Snapshot.txt if produced from current output,Selected-Symbol Dossier / current root Dossier derivative evidence or explicit separate contract,Expert logs/screenshots if available,MetaEditor compile output if available"
#define ASC_FUNCTION_RESULTS_ACTUAL_LOG_PROOF_REQUIREMENT "manifest_write_success_is_not_actual_log_proof; actual_function_results_log_required_for_header_row_size_spam_budget_summary_proof"
#define ASC_FUNCTION_RESULTS_LOG_HEADER_FIELDS "timestamp_utc,module,function,scope,state,state_code,code,duration_ms,source_owner,truth_boundary,hydration_class,proof_event,proof_status,detail,target"
#define ASC_FUNCTION_RESULTS_LOG_HEADER_LINE "timestamp_utc\tmodule\tfunction\tscope\tstate\tstate_code\tcode\tduration_ms\tsource_owner\ttruth_boundary\thydration_class\tproof_event\tproof_status\tdetail\ttarget\n"
#define ASC_FUNCTION_RESULTS_PHASE2A_CLOSEOUT_REQUIRED "yes"
#define ASC_RUN019_REQUIRED_FILES "Artifact Bundle Manifest.txt,Dossier.txt,Dossiers/GlobalTop10,Workbench/logs/function_results.log"
#define ASC_RUN019_REQUIRED_DOSSIER_TOKENS "Hydration Class:,Hydration Reason:,Hydration Boundary:"
#define ASC_RUN019_REQUIRED_FUNCTION_RESULT_ROW_KEYS "source_owner=,truth_boundary=,hydration_class=,proof_event=,proof_status="
#define ASC_RUN019_PHASE2A_CLOSEOUT_REQUIRES "root_dossier_hydration,globaltop10_hydration,function_results_log,manifest_no_stale_wording"
#define ASC_RUN019_PHASE2A_HOLD_IF "missing_function_results_log,missing_header_fields,missing_row_keys,missing_hydration_labels,stale_manifest_wording,false_proof_claim"
#define ASC_RUN019_PHASE3A_BRIDGE_REQUIRES "proof event rows and proof status rows are visible; missing, unavailable, stale, and dependency-blocked states stay visible"
#define ASC_RUN019_FORBIDDEN_STALE_WORDING "run010_required,run3_required,run3_live_evidence_required,old_fixed_proof_targets"
#define ASC_RUN019_MISSING_LOG_CLASSIFICATION "missing_from_output_package"
#define ASC_RUN030_REQUIRED_FILES "Artifact Bundle Manifest.txt,Dossier.txt,Dossiers/GlobalTop10,Workbench/logs/function_results.log"
#define ASC_RUN050_REQUIRED_FILES ASC_FUNCTION_RESULTS_RUN050_REQUIRED_OUTPUT_PACKAGE
#define ASC_RUN030_REQUIRED_DOSSIER_TOKENS "Hydration Class:,Hydration Reason:,Hydration Boundary:"
#define ASC_RUN030_REQUIRED_FUNCTION_RESULT_ROW_KEYS "source_owner=,truth_boundary=,hydration_class=,proof_event=,proof_status=,claim_evidence_status=,proof_row_class="
#define ASC_RUN030_PHASE2A_CLOSEOUT_REQUIRES "root Dossier hydration, GlobalTop10 hydration, function-results log, manifest stale-wording check"
#define ASC_RUN030_PHASE2A_HOLD_IF "hold if function-results log, header fields, row keys, hydration labels, stale-wording check, or proof honesty fails"
#define ASC_RUN030_PHASE3A_BRIDGE_REQUIRES "function-results rows include proof event and proof status fields; missing, unavailable, stale, and dependency-blocked states remain visible"
#define ASC_RUN030_CLAIM_EVIDENCE_REQUIRES "source support present; manifest witness present; proof details present; evidence availability boundary present; evidence recovery boundary present; evidence recheck boundary present; evidence intake chain present; candidate evidence intake boundary present; shortlist evidence intake boundary present; market board evidence intake boundary present; Dossier hydration failures handled honestly; artifact publication states handled honestly; selected artifact alignment handled honestly; Selected-Symbol Dossier expectation handled explicitly; Market Board compression boundary handled honestly; Market Board evidence intake remains metadata only; cross-artifact alignment witness present; operator surface claim boundary witness present; unavailable is not clean support; unavailable is not a permanent gate; unavailable is not a Market Board gate; recovery upgrade requires fresh support; existing cadence only; no heavy refresh loop; Candidate Filtering score/gate behavior unchanged; Shortlist score/rank/top-list behavior unchanged; Market Board selection/order/wording unchanged; no strategy, ranking, or HUD logic changed"
#define ASC_RUN030_CLAIM_EVIDENCE_SAFE_CALLSITES "runtime.bootstrap.contract_marker,artifact.manifest.proof_boundary,evidence.availability_boundary,evidence.recovery_boundary,evidence.recheck_boundary,evidence.intake_chain,candidate_filtering.evidence_intake_boundary,shortlist_selection.evidence_intake_boundary,market_board.evidence_intake_boundary,l1.market_state_recheck_cadence,l2.open_symbol_snapshot_recheck_cadence,dossier.hydration_required_token_validation,artifact.publication_status_boundary,selected_artifact.alignment_boundary,current_focus.expectation_boundary,market_board.artifact_compression_boundary,cross_artifact.alignment_witness,operator_surface.claim_boundary"
#define ASC_RUN030_CE_PUB_STATUSES "artifact_supported,source_supported_runtime_unproven,insufficient_evidence,unavailable,stale,dependency_blocked,contradiction_pending,no_claim"
#define ASC_RUN030_CE_SELECTED_ARTIFACT_STATUSES "artifact_supported,data_supported,source_supported_runtime_unproven,insufficient_evidence,unavailable,stale,dependency_blocked,contradiction_pending,no_claim"
#define ASC_RUN030_CE_MKT_BOARD_STATUSES "artifact_supported,data_supported,source_supported_runtime_unproven,insufficient_evidence,unavailable,stale,dependency_blocked,contradiction_pending,no_claim"
#define ASC_RUN030_CE_CROSS_ARTIFACT_STATUSES "artifact_supported,data_supported,source_supported_runtime_unproven,insufficient_evidence,unavailable,stale,dependency_blocked,contradiction_pending,no_claim"
#define ASC_RUN030_CE_OP_SURF_STATUSES "proof_required,claim_evidence_present,source_supported_runtime_unproven,insufficient_evidence,unavailable,stale,contradiction_pending,no_claim"
#define ASC_OP_SURF_BOUNDARY_TARGETS "dossier.operator_snapshot,current_focus.summary,market_board.compression,hud.truth_surface"
#define ASC_OP_SURF_SCOPE "proof_metadata_only"
#define ASC_CURRENT_FOCUS_EXPECTATION_STATUSES "separate_artifact_expected,dossier_derivative_expected,selected_dossier_copy_expected,not_applicable_no_selected_symbol,dependency_blocked,retained_last_good,stale,unavailable,contradiction_pending,source_supported_runtime_unproven"
#define ASC_CURRENT_FOCUS_EXPECTATION_SCOPE "root_dossier_current_focus_derivative_path"
#define ASC_RUN030_REQUIRED_MANIFEST_LINES "Cross-Artifact Alignment Witness:,Selected-Symbol Dossier Proof:,Proof Class Ledger:,Checkpoint Evidence:,Evidence Boundary:,Evidence Availability Boundary:,Evidence Recovery Boundary:,Evidence Recheck Boundary:,Evidence Intake Chain:,Candidate Evidence Intake Boundary:,Shortlist Evidence Intake Boundary:,Market Board Evidence Intake Boundary:,Hydration Proof Summary:,Function Results Log Evidence:,Function Results Log Budget:,Function Results Log Budget Summary:,Function Results Row-Level Proof Summary:,Row-Level Seam Emission Contract:,Function Results Output Package Contract:,RUN050 Required Output Package:,Output Artifact Locator:,Current vs Archive Artifact Boundary:,Operator Surface Claim Boundary Witness:,Claim Evidence Contract:,RUN050 Proof Checklist:,Phase 2A Open Proof Ledger:"
#define ASC_RUN030_ACCEPTANCE_RULES "Phase 2A closes only after hydration, manifest, stale-wording, and function-results proof pass; Phase 3A becomes runtime-proven only after log header, row keys, and bootstrap marker pass; Phase 4A is runtime-observed only for emitted seams"
#define ASC_RUN030_HOLD_RULES "hold on missing function-results log, missing hydration labels, missing manifest lines, stale wording, claim-evidence witness gap, operator content drift, strategy drift, ranking drift, or HUD drift"
#define ASC_RUN030_REGRESSION_CHECKS "no ranking formula changed; no strategy logic changed; no indicator added; no HUD work; no Market Board selection logic changed; no Market Board ordering changed; no Market Board opportunity risk wording changed; no Top 3 Top 5 Top 10 changed; no Selected-Symbol Dossier strategy content changed; no Dossier operator claim text rewritten; no execution logic changed; no FileIO rewrite; no new artifact family; no heavy per-symbol logging; no heavy per-symbol refresh loop; no unavailable hard gate; no Market Board unavailable gate; no separate Selected-Symbol Dossier artifact claim unless source contract changes; no archive or retained artifact counted as fresh current proof"
#define ASC_RUN030_FORBIDDEN_STALE_WORDING "run010_required,run3_required,run3_live_evidence_required,old_fixed_proof_targets"
#define ASC_RUN030_MISSING_LOG_CLASSIFICATION "missing_from_output_package"

#define ASC_FUNCTION_RESULT_PROOF_EVENT_SOURCE_SUPPORT "source_support"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_ARTIFACT_PUBLICATION "artifact_publication"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_HYDRATION_OBSERVED "hydration_observed"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_MANIFEST_BOUNDARY "manifest_boundary"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_RUNTIME_LOG_REQUIRED "runtime_log_required"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_CHECKPOINT_DEFERRED "checkpoint_deferred"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_PENDING_STALLED_UNKNOWN "pending_stalled_unknown"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_MISSING_PROOF "missing_proof"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_UNAVAILABLE_PROOF "unavailable_proof"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_STALE_PROOF "stale_proof"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_INSUFFICIENT_EVIDENCE "insufficient_evidence"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_DEPENDENCY_BLOCKED "dependency_blocked"
#define ASC_FUNCTION_RESULT_PROOF_EVENT_NO_CLAIM "no_claim"

#define ASC_FUNCTION_RESULT_PROOF_STATUS_SOURCE_ONLY "source_only"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_RUNTIME_OBSERVED "runtime_observed"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_ARTIFACT_OBSERVED "artifact_observed"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN019 "deferred_to_run019"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_NOT_CLAIMED "not_claimed"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_MISSING_FROM_OUTPUT_PACKAGE "missing_from_output_package"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_UNAVAILABLE "unavailable"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_STALE "stale"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_INSUFFICIENT_EVIDENCE "insufficient_evidence"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_DEPENDENCY_BLOCKED "dependency_blocked"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_RUNTIME_WRITE_FAILED ASC_FUNCTION_RESULTS_RUNTIME_WRITE_FAILED_CLASS
#define ASC_PROOF_STATUS_SRC_RT_UNPROVEN "source_supported_runtime_unproven"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050 "deferred_to_run050"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN040 ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050
#define ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN031 ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050
#define ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN030 ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN050

#define ASC_CE_DATA_SUPPORTED "data_supported"
#define ASC_CE_FORMULA_SUPPORTED "formula_supported"
#define ASC_CE_ARTIFACT_SUPPORTED "artifact_supported"
#define ASC_CE_SRC_RT_UNPROVEN "source_supported_runtime_unproven"
#define ASC_CE_INSUFFICIENT "insufficient_evidence"
#define ASC_CE_UNAVAILABLE "unavailable"
#define ASC_CE_STALE "stale"
#define ASC_CE_DEPENDENCY_BLOCKED "dependency_blocked"
#define ASC_CE_CONTRADICTION_PENDING "contradiction_pending"
#define ASC_CE_NO_CLAIM "no_claim"
#define ASC_CE_STATUS_TAXONOMY "data_supported,formula_supported,artifact_supported,source_supported_runtime_unproven,insufficient_evidence,unavailable,stale,dependency_blocked,contradiction_pending,no_claim"

#define ASC_EVID_AVAIL_SUPPORTED "available_supported"
#define ASC_EVID_AVAIL_UNAVAILABLE "unavailable"
#define ASC_EVID_AVAIL_STALE "stale"
#define ASC_EVID_AVAIL_PLACEHOLDER "placeholder"
#define ASC_EVID_AVAIL_ZERO_DEFAULT "zero_default"
#define ASC_EVID_AVAIL_EMPTY_DEFAULT "empty_default"
#define ASC_EVID_AVAIL_INSUFFICIENT "insufficient_evidence"
#define ASC_EVID_AVAIL_DEP_BLOCKED "dependency_blocked"
#define ASC_EVID_AVAIL_NOT_APPLICABLE "not_applicable"
#define ASC_EVID_AVAIL_CONTRADICTION_PENDING "contradiction_pending"
#define ASC_EVID_AVAIL_SRC_RT_UNPROVEN "source_supported_runtime_unproven"
#define ASC_EVID_AVAIL_TAXONOMY "available_supported,unavailable,stale,placeholder,zero_default,empty_default,insufficient_evidence,dependency_blocked,not_applicable,contradiction_pending,source_supported_runtime_unproven"
#define ASC_EVID_AVAIL_RUN040_CHECKS "manifest_availability_boundary_present,non_clean_mapping_for_unavailable_stale_placeholder_default,detail_keys_searchable,no_strategy_ranking_hud_operator_drift"

#define ASC_EVID_REC_REFRESH_DUE "refresh_due"
#define ASC_EVID_REC_REFRESH_PENDING "refresh_pending"
#define ASC_EVID_REC_RETRY_SCHEDULED "retry_scheduled"
#define ASC_EVID_REC_DEP_BLOCKED "dependency_blocked"
#define ASC_EVID_REC_STALE_RECOVERABLE "stale_but_recoverable"
#define ASC_EVID_REC_INSUFFICIENT_NOW "insufficient_now"
#define ASC_EVID_REC_UNAVAILABLE_NOW "unavailable_now"
#define ASC_EVID_REC_RECOVERED_SUPPORTED "recovered_to_supported"
#define ASC_EVID_REC_STILL_UNAVAILABLE "still_unavailable_after_refresh"
#define ASC_EVID_REC_NOT_APPLICABLE "not_applicable"
#define ASC_EVID_REC_SRC_RT_UNPROVEN "source_supported_runtime_unproven"
#define ASC_EVID_REC_TAXONOMY "refresh_due,refresh_pending,retry_scheduled,dependency_blocked,stale_but_recoverable,insufficient_now,unavailable_now,recovered_to_supported,still_unavailable_after_refresh,not_applicable,source_supported_runtime_unproven"
#define ASC_EVID_REC_RUN040_CHECKS "manifest_recovery_boundary_present,unavailable_not_permanent_gate,recovery_upgrade_requires_fresh_support,no_heavy_refresh_loop,no_strategy_ranking_hud_operator_drift"
#define ASC_EVID_RECHECK_BOUNDARY_SCOPE "l1_market_state_l2_open_symbol_snapshot_existing_cadence_only"
#define ASC_EVID_RECHECK_RUN040_CHECKS "manifest_recheck_boundary_present,l1_l2_existing_cadence_support_present,refresh_due_pending_retry_states_searchable,recovered_to_supported_requires_fresh_support,failed_refresh_remains_non_clean,no_heavy_refresh_loop,no_strategy_ranking_hud_operator_drift"

#define ASC_CAND_EVID_INTAKE_CLEAN_SUPPORTED "clean_supported"
#define ASC_CAND_EVID_INTAKE_NON_CLEAN_AVAILABLE "non_clean_available"
#define ASC_CAND_EVID_INTAKE_UNAVAILABLE_RECOVERABLE "unavailable_recoverable"
#define ASC_CAND_EVID_INTAKE_STALE_RECOVERABLE "stale_recoverable"
#define ASC_CAND_EVID_INTAKE_INSUFFICIENT_NOW "insufficient_now"
#define ASC_CAND_EVID_INTAKE_DEP_BLOCKED "dependency_blocked"
#define ASC_CAND_EVID_INTAKE_NOT_APPLICABLE "not_applicable"
#define ASC_CAND_EVID_INTAKE_SRC_RT_UNPROVEN "source_supported_runtime_unproven"
#define ASC_CAND_EVID_INTAKE_TAXONOMY "clean_supported,non_clean_available,unavailable_recoverable,stale_recoverable,insufficient_now,dependency_blocked,not_applicable,source_supported_runtime_unproven"
#define ASC_CAND_EVID_INTAKE_RUN040_CHECKS "manifest_candidate_evidence_intake_boundary_present,selection_filter_source_support_present,no_candidate_score_change,no_candidate_gate_change,unavailable_is_not_candidate_gate,metadata_proof_only,no_shortlist_top10_market_board_hud_strategy_drift"
#define ASC_SHORTLIST_EVID_INTAKE_CLEAN_SUPPORTED ASC_CAND_EVID_INTAKE_CLEAN_SUPPORTED
#define ASC_SHORTLIST_EVID_INTAKE_NON_CLEAN_AVAILABLE ASC_CAND_EVID_INTAKE_NON_CLEAN_AVAILABLE
#define ASC_SHORTLIST_EVID_INTAKE_UNAVAILABLE_RECOVERABLE ASC_CAND_EVID_INTAKE_UNAVAILABLE_RECOVERABLE
#define ASC_SHORTLIST_EVID_INTAKE_STALE_RECOVERABLE ASC_CAND_EVID_INTAKE_STALE_RECOVERABLE
#define ASC_SHORTLIST_EVID_INTAKE_INSUFFICIENT_NOW ASC_CAND_EVID_INTAKE_INSUFFICIENT_NOW
#define ASC_SHORTLIST_EVID_INTAKE_DEP_BLOCKED ASC_CAND_EVID_INTAKE_DEP_BLOCKED
#define ASC_SHORTLIST_EVID_INTAKE_NOT_APPLICABLE ASC_CAND_EVID_INTAKE_NOT_APPLICABLE
#define ASC_SHORTLIST_EVID_INTAKE_SRC_RT_UNPROVEN ASC_CAND_EVID_INTAKE_SRC_RT_UNPROVEN
#define ASC_SHORTLIST_EVID_INTAKE_TAXONOMY ASC_CAND_EVID_INTAKE_TAXONOMY
#define ASC_SHORTLIST_EVID_INTAKE_RUN040_CHECKS "manifest_shortlist_evidence_intake_boundary_present,shortlist_selection_source_support_present,no_shortlist_score_change,no_shortlist_rank_change,no_top3_top5_top10_change,no_market_board_selection_change,unavailable_is_not_shortlist_gate,metadata_proof_only,no_candidate_filtering_hud_strategy_artifact_drift"
#define ASC_MARKET_BOARD_EVID_INTAKE_CLEAN_SUPPORTED ASC_CAND_EVID_INTAKE_CLEAN_SUPPORTED
#define ASC_MARKET_BOARD_EVID_INTAKE_NON_CLEAN_AVAILABLE ASC_CAND_EVID_INTAKE_NON_CLEAN_AVAILABLE
#define ASC_MARKET_BOARD_EVID_INTAKE_UNAVAILABLE_RECOVERABLE ASC_CAND_EVID_INTAKE_UNAVAILABLE_RECOVERABLE
#define ASC_MARKET_BOARD_EVID_INTAKE_STALE_RECOVERABLE ASC_CAND_EVID_INTAKE_STALE_RECOVERABLE
#define ASC_MARKET_BOARD_EVID_INTAKE_INSUFFICIENT_NOW ASC_CAND_EVID_INTAKE_INSUFFICIENT_NOW
#define ASC_MARKET_BOARD_EVID_INTAKE_DEP_BLOCKED ASC_CAND_EVID_INTAKE_DEP_BLOCKED
#define ASC_MARKET_BOARD_EVID_INTAKE_NOT_APPLICABLE ASC_CAND_EVID_INTAKE_NOT_APPLICABLE
#define ASC_MARKET_BOARD_EVID_INTAKE_SRC_RT_UNPROVEN ASC_CAND_EVID_INTAKE_SRC_RT_UNPROVEN
#define ASC_MARKET_BOARD_EVID_INTAKE_TAXONOMY ASC_CAND_EVID_INTAKE_TAXONOMY
#define ASC_MARKET_BOARD_EVID_INTAKE_RUN040_CHECKS "manifest_market_board_evidence_intake_boundary_present,market_board_source_support_present,no_market_board_selection_change,no_market_board_order_change,no_market_board_opportunity_risk_wording_change,no_top3_top5_top10_change,unavailable_is_not_market_board_gate,metadata_proof_only,no_candidate_shortlist_hud_strategy_artifact_drift"

#define ASC_FUNCTION_RESULT_PROOF_EVENT_TAXONOMY "source_support,artifact_publication,hydration_observed,manifest_boundary,runtime_log_required,checkpoint_deferred,pending_stalled_unknown,missing_proof,unavailable_proof,stale_proof,insufficient_evidence,dependency_blocked,no_claim"
#define ASC_FUNCTION_RESULT_PROOF_STATUS_TAXONOMY "source_only,runtime_observed,artifact_observed,deferred_to_run019,deferred_to_run050,not_claimed,missing_from_output_package,output_package_omission,runtime_write_failed,source_contract_missing,runtime_unproven,unavailable,stale,insufficient_evidence,dependency_blocked,source_supported_runtime_unproven"
#define ASC_PROOF_ROW_CLASS_REQUIRED_ONCE "required_once"
#define ASC_PROOF_ROW_CLASS_ARTIFACT_BOUNDARY "artifact_boundary"
#define ASC_PROOF_ROW_CLASS_STATE_CHANGE "state_change"
#define ASC_PROOF_ROW_CLASS_ERROR_ONLY "error_only"
#define ASC_PROOF_ROW_CLASS_DIAGNOSTIC_SUMMARY "diagnostic_summary"
#define ASC_PROOF_ROW_CLASS_TAXONOMY "required_once,artifact_boundary,state_change,error_only,diagnostic_summary"

string ASC_FunctionResultsLogExpectedRelativePath()
  {
   return ASC_FUNCTION_RESULTS_LOG_EXPECTED_RELATIVE_PATH;
  }

string ASC_FunctionResultsLogRequiredKeys()
  {
   return ASC_FUNCTION_RESULTS_LOG_REQUIRED_KEYS;
  }

string ASC_FunctionResultsLogHeaderExpected()
  {
   return ASC_FUNCTION_RESULTS_LOG_HEADER_FIELDS;
  }

string ASC_Run019RequiredFiles()
  {
   return ASC_RUN019_REQUIRED_FILES;
  }

string ASC_Run019RequiredDossierTokens()
  {
   return ASC_RUN019_REQUIRED_DOSSIER_TOKENS;
  }

string ASC_Run019RequiredFunctionResultRowKeys()
  {
   return ASC_RUN019_REQUIRED_FUNCTION_RESULT_ROW_KEYS;
  }

string ASC_Run019Phase2ACloseoutRequires()
  {
   return ASC_RUN019_PHASE2A_CLOSEOUT_REQUIRES;
  }

string ASC_Run019Phase2AHoldIf()
  {
   return ASC_RUN019_PHASE2A_HOLD_IF;
  }

string ASC_Run019Phase3ABridgeRequires()
  {
   return ASC_RUN019_PHASE3A_BRIDGE_REQUIRES;
  }

string ASC_Run019ForbiddenStaleWording()
  {
   return ASC_RUN019_FORBIDDEN_STALE_WORDING;
  }

string ASC_Run019MissingLogClassification()
  {
   return ASC_RUN019_MISSING_LOG_CLASSIFICATION;
  }

string ASC_Run030RequiredFiles()
  {
   return ASC_RUN030_REQUIRED_FILES;
  }

string ASC_Run050RequiredFiles()
  {
   return ASC_RUN050_REQUIRED_FILES;
  }

string ASC_FunctionResultsOutputPackageRequiredFile()
  {
   return ASC_FUNCTION_RESULTS_OUTPUT_PACKAGE_REQUIRED_FILE;
  }

string ASC_FunctionResultsOutputPackageOmissionClass()
  {
   return ASC_FUNCTION_RESULTS_OUTPUT_PACKAGE_OMISSION_CLASS;
  }

string ASC_FunctionResultsRuntimeWriteFailedClass()
  {
   return ASC_FUNCTION_RESULTS_RUNTIME_WRITE_FAILED_CLASS;
  }

string ASC_FunctionResultsSourceContractMissingClass()
  {
   return ASC_FUNCTION_RESULTS_SOURCE_CONTRACT_MISSING_CLASS;
  }

string ASC_FunctionResultsRuntimeUnprovenClass()
  {
   return ASC_FUNCTION_RESULTS_RUNTIME_UNPROVEN_CLASS;
  }

string ASC_FunctionResultsPackagePresenceUnverifiedClass()
  {
   return ASC_FUNCTION_RESULTS_PACKAGE_PRESENCE_UNVERIFIED_CLASS;
  }

string ASC_PackageCompletenessCompleteRequiredClass()
  {
   return ASC_PACKAGE_COMPLETENESS_COMPLETE_REQUIRED_CLASS;
  }

string ASC_PackageCompletenessMissingRequiredClass()
  {
   return ASC_PACKAGE_COMPLETENESS_MISSING_REQUIRED_CLASS;
  }

string ASC_PackageCompletenessMissingOptionalClass()
  {
   return ASC_PACKAGE_COMPLETENESS_MISSING_OPTIONAL_CLASS;
  }

string ASC_PackageCompletenessDerivativeExpectedClass()
  {
   return ASC_PACKAGE_COMPLETENESS_DERIVATIVE_EXPECTED_CLASS;
  }

string ASC_PackageCompletenessSourceSupportedRuntimeUnprovenClass()
  {
   return ASC_PKG_COMPLETE_SRC_RT_UNPROVEN_CLASS;
  }

string ASC_PackageCompletenessOutputPackageOmissionClass()
  {
   return ASC_PACKAGE_COMPLETENESS_OUTPUT_PACKAGE_OMISSION_CLASS;
  }

string ASC_PackageCompletenessNotApplicableClass()
  {
   return ASC_PACKAGE_COMPLETENESS_NOT_APPLICABLE_CLASS;
  }

string ASC_PackageCompletenessRuntimeUnprovenClass()
  {
   return ASC_PACKAGE_COMPLETENESS_RUNTIME_UNPROVEN_CLASS;
  }

string ASC_PackageCompletenessCurrentOutputPresentClass()
  {
   return ASC_PACKAGE_COMPLETENESS_CURRENT_OUTPUT_PRESENT_CLASS;
  }

string ASC_PackageCompletenessArchiveOnlyClass()
  {
   return ASC_PACKAGE_COMPLETENESS_ARCHIVE_ONLY_CLASS;
  }

string ASC_PackageCompletenessPreviousRunOnlyClass()
  {
   return ASC_PACKAGE_COMPLETENESS_PREVIOUS_RUN_ONLY_CLASS;
  }

string ASC_PackageCompletenessRetainedLastGoodClass()
  {
   return ASC_PACKAGE_COMPLETENESS_RETAINED_LAST_GOOD_CLASS;
  }

string ASC_PackageCompletenessStaleTimestampClass()
  {
   return ASC_PACKAGE_COMPLETENESS_STALE_TIMESTAMP_CLASS;
  }

string ASC_PackageCompletenessSourceSupportedOnlyClass()
  {
   return ASC_PACKAGE_COMPLETENESS_SOURCE_SUPPORTED_ONLY_CLASS;
  }

string ASC_PackageCompletenessCurrentRuntimeUnprovenClass()
  {
   return ASC_PACKAGE_COMPLETENESS_CURRENT_RUNTIME_UNPROVEN_CLASS;
  }

string ASC_PackageCompletenessTaxonomy()
  {
   return ASC_PACKAGE_COMPLETENESS_TAXONOMY;
  }

string ASC_OutputArtifactLocatorRequiredArtifacts()
  {
   return ASC_OUTPUT_ARTIFACT_LOCATOR_REQUIRED_ARTIFACTS;
  }

string ASC_OutputArtifactLocatorRequiredPaths()
  {
   return ASC_OUTPUT_ARTIFACT_LOCATOR_REQUIRED_PATHS;
  }

string ASC_OutputArtifactLocatorOptionalArtifacts()
  {
   return ASC_OUTPUT_ARTIFACT_LOCATOR_OPTIONAL_ARTIFACTS;
  }

string ASC_OutputArtifactLocatorOptionalPaths()
  {
   return ASC_OUTPUT_ARTIFACT_LOCATOR_OPTIONAL_PATHS;
  }

string ASC_OutputArtifactLocatorDerivativeArtifacts()
  {
   return ASC_OUTPUT_ARTIFACT_LOCATOR_DERIVATIVE_ARTIFACTS;
  }

string ASC_OutputArtifactLocatorCurrentFocusExpectation()
  {
   return ASC_OUTPUT_ARTIFACT_LOCATOR_CURRENT_FOCUS_EXPECTATION;
  }

string ASC_OutputArtifactLocatorRuntimeProof()
  {
   return ASC_OUTPUT_ARTIFACT_LOCATOR_RUNTIME_PROOF;
  }

string ASC_OutputArtifactLocatorActualPackageProofRequirement()
  {
   return ASC_OUTPUT_ARTIFACT_LOCATOR_ACTUAL_PACKAGE_PROOF_REQUIREMENT;
  }

string ASC_FunctionResultsRowLevelProofSummarySupport()
  {
   return ASC_FUNCTION_RESULTS_ROW_LEVEL_PROOF_SUMMARY_SUPPORT;
  }

string ASC_CanonicalBaselineReconciliationSupport()
  {
   return ASC_CANONICAL_BASELINE_RECONCILIATION_SUPPORT;
  }

string ASC_CanonicalBaselineReconciliationRequiredLines()
  {
   return ASC_CANONICAL_BASELINE_RECONCILIATION_REQUIRED_LINES;
  }

string ASC_CanonicalBaselineReconciliationSourceDecision()
  {
   return ASC_CANONICAL_BASELINE_RECONCILIATION_SOURCE_DECISION;
  }

string ASC_CanonicalBaselineReconciliationProofBoundary()
  {
   return ASC_CANONICAL_BASELINE_RECONCILIATION_PROOF_BOUNDARY;
  }

string ASC_CurrentArchiveArtifactBoundaryKeys()
  {
   return ASC_CURRENT_ARCHIVE_ARTIFACT_BOUNDARY_KEYS;
  }

string ASC_CurrentArchiveArtifactBoundaryClassification()
  {
   return ASC_CURRENT_ARCHIVE_ARTIFACT_BOUNDARY_CLASSIFICATION;
  }

string ASC_CurrentArchiveArtifactBoundaryProofRule()
  {
   return ASC_CURRENT_ARCHIVE_ARTIFACT_BOUNDARY_PROOF_RULE;
  }

string ASC_CurrentArchiveCurrentFocusRule()
  {
   return ASC_CURRENT_ARCHIVE_CURRENT_FOCUS_RULE;
  }

string ASC_RowLevelSeamEmissionContractKeys()
  {
   return ASC_ROW_LEVEL_SEAM_EMISSION_CONTRACT_KEYS;
  }

string ASC_RowLevelSeamDetailKeyStandard()
  {
   return ASC_ROW_LEVEL_SEAM_DETAIL_KEY_STANDARD;
  }

string ASC_RowLevelSeamDetailKeyExpectation()
  {
   return ASC_ROW_LEVEL_SEAM_DETAIL_KEY_EXPECTATION;
  }

string ASC_RowLevelSeamStatusTaxonomy()
  {
   return ASC_ROW_LEVEL_SEAM_STATUS_TAXONOMY;
  }

string ASC_RowLevelRequiredSeamInventory()
  {
   return ASC_ROW_LEVEL_REQUIRED_SEAM_INVENTORY;
  }

string ASC_RowLevelSeamNoSpamGuard()
  {
   return ASC_ROW_LEVEL_SEAM_NO_SPAM_GUARD;
  }

string ASC_RowLevelSeamContractRun050Checks()
  {
   return ASC_ROW_LEVEL_SEAM_CONTRACT_RUN050_CHECKS;
  }

string ASC_FunctionResultsLogBudgetSummaryKeys()
  {
   return ASC_FUNCTION_RESULTS_LOG_BUDGET_SUMMARY_KEYS;
  }

string ASC_FunctionResultsLogBudgetJudgementTaxonomy()
  {
   return ASC_FUNCTION_RESULTS_LOG_BUDGET_JUDGEMENT_TAXONOMY;
  }

string ASC_FunctionResultsLogBudgetSummaryRun050Checks()
  {
   return ASC_FUNCTION_RESULTS_LOG_BUDGET_SUMMARY_RUN050_CHECKS;
  }

string ASC_FunctionResultsRequiredRowVsSpamRules()
  {
   return ASC_FUNCTION_RESULTS_REQUIRED_ROW_VS_SPAM_RULES;
  }

string ASC_FunctionResultsActualLogProofRequirement()
  {
   return ASC_FUNCTION_RESULTS_ACTUAL_LOG_PROOF_REQUIREMENT;
  }

string ASC_Run030RequiredDossierTokens()
  {
   return ASC_RUN030_REQUIRED_DOSSIER_TOKENS;
  }

string ASC_Run030RequiredFunctionResultRowKeys()
  {
   return ASC_RUN030_REQUIRED_FUNCTION_RESULT_ROW_KEYS;
  }

string ASC_Run030Phase2ACloseoutRequires()
  {
   return ASC_RUN030_PHASE2A_CLOSEOUT_REQUIRES;
  }

string ASC_Run030Phase2AHoldIf()
  {
   return ASC_RUN030_PHASE2A_HOLD_IF;
  }

string ASC_Run030Phase3ABridgeRequires()
  {
   return ASC_RUN030_PHASE3A_BRIDGE_REQUIRES;
  }

string ASC_Run030ClaimEvidenceRequires()
  {
   return ASC_RUN030_CLAIM_EVIDENCE_REQUIRES;
  }

string ASC_Run030ClaimEvidenceSafeCallsites()
  {
   return ASC_RUN030_CLAIM_EVIDENCE_SAFE_CALLSITES;
  }

string ASC_Run030ClaimEvidencePublicationStatuses()
  {
   return ASC_RUN030_CE_PUB_STATUSES;
  }

string ASC_Run030ClaimEvidenceSelectedArtifactStatuses()
  {
   return ASC_RUN030_CE_SELECTED_ARTIFACT_STATUSES;
  }

string ASC_Run030ClaimEvidenceMarketBoardStatuses()
  {
   return ASC_RUN030_CE_MKT_BOARD_STATUSES;
  }

string ASC_Run030ClaimEvidenceCrossArtifactStatuses()
  {
   return ASC_RUN030_CE_CROSS_ARTIFACT_STATUSES;
  }

string ASC_Run030ClaimEvidenceOperatorSurfaceStatuses()
  {
   return ASC_RUN030_CE_OP_SURF_STATUSES;
  }

string ASC_CurrentFocusExpectationStatuses()
  {
   return ASC_CURRENT_FOCUS_EXPECTATION_STATUSES;
  }

string ASC_CurrentFocusExpectationScope()
  {
   return ASC_CURRENT_FOCUS_EXPECTATION_SCOPE;
  }

string ASC_OpSurfBoundaryTargets()
  {
   return ASC_OP_SURF_BOUNDARY_TARGETS;
  }

string ASC_OpSurfScope()
  {
   return ASC_OP_SURF_SCOPE;
  }

string ASC_Run030RequiredManifestLines()
  {
   return ASC_RUN030_REQUIRED_MANIFEST_LINES;
  }

string ASC_Run030AcceptanceRules()
  {
   return ASC_RUN030_ACCEPTANCE_RULES;
  }

string ASC_Run030HoldRules()
  {
   return ASC_RUN030_HOLD_RULES;
  }

string ASC_Run030RegressionChecks()
  {
   return ASC_RUN030_REGRESSION_CHECKS;
  }

string ASC_Run030ForbiddenStaleWording()
  {
   return ASC_RUN030_FORBIDDEN_STALE_WORDING;
  }

string ASC_Run030MissingLogClassification()
  {
   return ASC_RUN030_MISSING_LOG_CLASSIFICATION;
  }

string ASC_FunctionResultsProofEventTaxonomy()
  {
   return ASC_FUNCTION_RESULT_PROOF_EVENT_TAXONOMY;
  }

string ASC_FunctionResultsProofStatusTaxonomy()
  {
   return ASC_FUNCTION_RESULT_PROOF_STATUS_TAXONOMY;
  }

string ASC_FunctionResultsLogBudgetStatus()
  {
   return ASC_FUNCTION_RESULTS_LOG_BUDGET_STATUS;
  }

string ASC_FunctionResultsSpamGuardStatus()
  {
   return ASC_FUNCTION_RESULTS_SPAM_GUARD_STATUS;
  }

string ASC_FunctionResultsRequiredRowsMustNotBeThrottled()
  {
   return ASC_FUNCTION_RESULTS_REQUIRED_ROWS_MUST_NOT_BE_THROTTLED;
  }

string ASC_FunctionResultsLogBudgetRun040Checks()
  {
   return ASC_FUNCTION_RESULTS_LOG_BUDGET_RUN040_CHECKS;
  }

string ASC_FunctionResultsLogBudgetRun050Checks()
  {
   return ASC_FUNCTION_RESULTS_LOG_BUDGET_RUN050_CHECKS;
  }

string ASC_FunctionResultsProofRowClassTaxonomy()
  {
   return ASC_PROOF_ROW_CLASS_TAXONOMY;
  }

bool ASC_FunctionResultsProofRowClassKnown(const string proof_row_class)
  {
   return proof_row_class == ASC_PROOF_ROW_CLASS_REQUIRED_ONCE
          || proof_row_class == ASC_PROOF_ROW_CLASS_ARTIFACT_BOUNDARY
          || proof_row_class == ASC_PROOF_ROW_CLASS_STATE_CHANGE
          || proof_row_class == ASC_PROOF_ROW_CLASS_ERROR_ONLY
          || proof_row_class == ASC_PROOF_ROW_CLASS_DIAGNOSTIC_SUMMARY;
  }

string ASC_FunctionResultsProofRowClassText(const string proof_row_class)
  {
   if(ASC_FunctionResultsProofRowClassKnown(proof_row_class))
      return proof_row_class;
   return ASC_PROOF_ROW_CLASS_DIAGNOSTIC_SUMMARY;
  }

string ASC_ClaimEvidenceStatusTaxonomy()
  {
   return ASC_CE_STATUS_TAXONOMY;
  }

bool ASC_ClaimEvidenceStatusKnown(const string status)
  {
   return status == ASC_CE_DATA_SUPPORTED
          || status == ASC_CE_FORMULA_SUPPORTED
          || status == ASC_CE_ARTIFACT_SUPPORTED
          || status == ASC_CE_SRC_RT_UNPROVEN
          || status == ASC_CE_INSUFFICIENT
          || status == ASC_CE_UNAVAILABLE
          || status == ASC_CE_STALE
          || status == ASC_CE_DEPENDENCY_BLOCKED
          || status == ASC_CE_CONTRADICTION_PENDING
          || status == ASC_CE_NO_CLAIM;
  }

string ASC_ClaimEvidenceStatusText(const string status)
  {
   if(ASC_ClaimEvidenceStatusKnown(status))
      return status;
   if(StringLen(status) <= 0)
      return ASC_CE_UNAVAILABLE;
   return ASC_CE_CONTRADICTION_PENDING;
  }


string ASC_EvidenceAvailabilityTaxonomy()
  {
   return ASC_EVID_AVAIL_TAXONOMY;
  }

string ASC_EvidenceRecoveryTaxonomy()
  {
   return ASC_EVID_REC_TAXONOMY;
  }

string ASC_EvidenceAvailabilityRun040Checks()
  {
   return ASC_EVID_AVAIL_RUN040_CHECKS;
  }

string ASC_EvidenceRecoveryRun040Checks()
  {
   return ASC_EVID_REC_RUN040_CHECKS;
  }

string ASC_EvidenceRecheckBoundaryScope()
  {
   return ASC_EVID_RECHECK_BOUNDARY_SCOPE;
  }

string ASC_EvidenceRecheckRun040Checks()
  {
   return ASC_EVID_RECHECK_RUN040_CHECKS;
  }

bool ASC_EvidenceAvailabilityKnown(const string state)
  {
   return state == ASC_EVID_AVAIL_SUPPORTED
          || state == ASC_EVID_AVAIL_UNAVAILABLE
          || state == ASC_EVID_AVAIL_STALE
          || state == ASC_EVID_AVAIL_PLACEHOLDER
          || state == ASC_EVID_AVAIL_ZERO_DEFAULT
          || state == ASC_EVID_AVAIL_EMPTY_DEFAULT
          || state == ASC_EVID_AVAIL_INSUFFICIENT
          || state == ASC_EVID_AVAIL_DEP_BLOCKED
          || state == ASC_EVID_AVAIL_NOT_APPLICABLE
          || state == ASC_EVID_AVAIL_CONTRADICTION_PENDING
          || state == ASC_EVID_AVAIL_SRC_RT_UNPROVEN;
  }

string ASC_EvidenceAvailabilityText(const string state)
  {
   if(ASC_EvidenceAvailabilityKnown(state))
      return state;
   if(StringLen(state) <= 0)
      return ASC_EVID_AVAIL_UNAVAILABLE;
   return ASC_EVID_AVAIL_CONTRADICTION_PENDING;
  }

string ASC_EvidenceAvailabilityClaimEvidenceStatus(const string state)
  {
   string clean_state = ASC_EvidenceAvailabilityText(state);
   if(clean_state == ASC_EVID_AVAIL_SUPPORTED)
      return ASC_CE_DATA_SUPPORTED;
   if(clean_state == ASC_EVID_AVAIL_STALE)
      return ASC_CE_STALE;
   if(clean_state == ASC_EVID_AVAIL_PLACEHOLDER
      || clean_state == ASC_EVID_AVAIL_ZERO_DEFAULT
      || clean_state == ASC_EVID_AVAIL_EMPTY_DEFAULT
      || clean_state == ASC_EVID_AVAIL_INSUFFICIENT)
      return ASC_CE_INSUFFICIENT;
   if(clean_state == ASC_EVID_AVAIL_DEP_BLOCKED)
      return ASC_CE_DEPENDENCY_BLOCKED;
   if(clean_state == ASC_EVID_AVAIL_NOT_APPLICABLE)
      return ASC_CE_NO_CLAIM;
   if(clean_state == ASC_EVID_AVAIL_CONTRADICTION_PENDING)
      return ASC_CE_CONTRADICTION_PENDING;
   if(clean_state == ASC_EVID_AVAIL_SRC_RT_UNPROVEN)
      return ASC_CE_SRC_RT_UNPROVEN;
   return ASC_CE_UNAVAILABLE;
  }

bool ASC_EvidenceRecoveryKnown(const string state)
  {
   return state == ASC_EVID_REC_REFRESH_DUE
          || state == ASC_EVID_REC_REFRESH_PENDING
          || state == ASC_EVID_REC_RETRY_SCHEDULED
          || state == ASC_EVID_REC_DEP_BLOCKED
          || state == ASC_EVID_REC_STALE_RECOVERABLE
          || state == ASC_EVID_REC_INSUFFICIENT_NOW
          || state == ASC_EVID_REC_UNAVAILABLE_NOW
          || state == ASC_EVID_REC_RECOVERED_SUPPORTED
          || state == ASC_EVID_REC_STILL_UNAVAILABLE
          || state == ASC_EVID_REC_NOT_APPLICABLE
          || state == ASC_EVID_REC_SRC_RT_UNPROVEN;
  }

string ASC_EvidenceRecoveryText(const string state)
  {
   if(ASC_EvidenceRecoveryKnown(state))
      return state;
   if(StringLen(state) <= 0)
      return ASC_EVID_REC_UNAVAILABLE_NOW;
   return ASC_EVID_REC_STILL_UNAVAILABLE;
  }

string ASC_EvidenceRecoveryClaimEvidenceStatus(const string state)
  {
   string clean_state = ASC_EvidenceRecoveryText(state);
   if(clean_state == ASC_EVID_REC_RECOVERED_SUPPORTED)
      return ASC_CE_DATA_SUPPORTED;
   if(clean_state == ASC_EVID_REC_REFRESH_DUE
      || clean_state == ASC_EVID_REC_REFRESH_PENDING
      || clean_state == ASC_EVID_REC_SRC_RT_UNPROVEN)
      return ASC_CE_SRC_RT_UNPROVEN;
   if(clean_state == ASC_EVID_REC_RETRY_SCHEDULED
      || clean_state == ASC_EVID_REC_DEP_BLOCKED)
      return ASC_CE_DEPENDENCY_BLOCKED;
   if(clean_state == ASC_EVID_REC_STALE_RECOVERABLE)
      return ASC_CE_STALE;
   if(clean_state == ASC_EVID_REC_INSUFFICIENT_NOW)
      return ASC_CE_INSUFFICIENT;
   if(clean_state == ASC_EVID_REC_NOT_APPLICABLE)
      return ASC_CE_NO_CLAIM;
   return ASC_CE_UNAVAILABLE;
  }

bool ASC_CandidateEvidenceIntakeKnown(const string state)
  {
   return state == ASC_CAND_EVID_INTAKE_CLEAN_SUPPORTED
          || state == ASC_CAND_EVID_INTAKE_NON_CLEAN_AVAILABLE
          || state == ASC_CAND_EVID_INTAKE_UNAVAILABLE_RECOVERABLE
          || state == ASC_CAND_EVID_INTAKE_STALE_RECOVERABLE
          || state == ASC_CAND_EVID_INTAKE_INSUFFICIENT_NOW
          || state == ASC_CAND_EVID_INTAKE_DEP_BLOCKED
          || state == ASC_CAND_EVID_INTAKE_NOT_APPLICABLE
          || state == ASC_CAND_EVID_INTAKE_SRC_RT_UNPROVEN;
  }

string ASC_CandidateEvidenceIntakeText(const string state)
  {
   if(ASC_CandidateEvidenceIntakeKnown(state))
      return state;
   if(StringLen(state) <= 0)
      return ASC_CAND_EVID_INTAKE_SRC_RT_UNPROVEN;
   return ASC_CAND_EVID_INTAKE_NON_CLEAN_AVAILABLE;
  }

string ASC_CandidateEvidenceIntakeTaxonomy()
  {
   return ASC_CAND_EVID_INTAKE_TAXONOMY;
  }

string ASC_CandidateEvidenceIntakeRun040Checks()
  {
   return ASC_CAND_EVID_INTAKE_RUN040_CHECKS;
  }

string ASC_ShortlistEvidenceIntakeText(const string state)
  {
   return ASC_CandidateEvidenceIntakeText(state);
  }

string ASC_ShortlistEvidenceIntakeTaxonomy()
  {
   return ASC_SHORTLIST_EVID_INTAKE_TAXONOMY;
  }

string ASC_ShortlistEvidenceIntakeRun040Checks()
  {
   return ASC_SHORTLIST_EVID_INTAKE_RUN040_CHECKS;
  }

string ASC_MarketBoardEvidenceIntakeText(const string state)
  {
   return ASC_CandidateEvidenceIntakeText(state);
  }

string ASC_MarketBoardEvidenceIntakeTaxonomy()
  {
   return ASC_MARKET_BOARD_EVID_INTAKE_TAXONOMY;
  }

string ASC_MarketBoardEvidenceIntakeRun040Checks()
  {
   return ASC_MARKET_BOARD_EVID_INTAKE_RUN040_CHECKS;
  }

string ASC_MarketBoardEvidenceIntakeClaimEvidenceStatus(const string state)
  {
   return ASC_CandidateEvidenceIntakeClaimEvidenceStatus(state);
  }

string ASC_MarketBoardEvidenceIntakeDetailAppend(const string detail,
                                                 const string intake_state,
                                                 const string runtime_proof)
  {
   string result = detail;
   if(StringLen(result) > 0)
      result += " | ";
   string state = ASC_MarketBoardEvidenceIntakeText(intake_state);
   result += "market_board_evidence_intake_boundary=present";
   result += " | market_board_evidence_intake_state=" + state;
   result += " | market_board_evidence_intake_claim_evidence_status=" + ASC_MarketBoardEvidenceIntakeClaimEvidenceStatus(state);
   result += " | market_board_selection_change=no";
   result += " | market_board_order_change=no";
   result += " | market_board_wording_change=no";
   result += " | top_list_change=no";
   result += " | unavailable_is_not_market_board_gate=yes";
   result += " | market_board_evidence_intake_runtime_proof=" + (StringLen(runtime_proof) > 0 ? runtime_proof : ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN040);
   result += " | metadata_only=yes";
   result += " | future_consumer_ready=yes";
   return result;
  }

string ASC_ShortlistEvidenceIntakeClaimEvidenceStatus(const string state)
  {
   return ASC_CandidateEvidenceIntakeClaimEvidenceStatus(state);
  }

string ASC_ShortlistEvidenceIntakeDetailAppend(const string detail,
                                               const string intake_state,
                                               const string runtime_proof)
  {
   string result = detail;
   if(StringLen(result) > 0)
      result += " | ";
   string state = ASC_ShortlistEvidenceIntakeText(intake_state);
   result += "shortlist_evidence_intake_boundary=present";
   result += " | shortlist_evidence_intake_state=" + state;
   result += " | shortlist_evidence_intake_claim_evidence_status=" + ASC_ShortlistEvidenceIntakeClaimEvidenceStatus(state);
   result += " | shortlist_score_change=no";
   result += " | shortlist_rank_change=no";
   result += " | top_list_change=no";
   result += " | market_board_selection_change=no";
   result += " | unavailable_is_not_shortlist_gate=yes";
   result += " | shortlist_evidence_intake_runtime_proof=" + (StringLen(runtime_proof) > 0 ? runtime_proof : ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN040);
   result += " | metadata_only=yes";
   result += " | future_consumer_ready=yes";
   return result;
  }

string ASC_CandidateEvidenceIntakeClaimEvidenceStatus(const string state)
  {
   string clean_state = ASC_CandidateEvidenceIntakeText(state);
   if(clean_state == ASC_CAND_EVID_INTAKE_CLEAN_SUPPORTED)
      return ASC_CE_DATA_SUPPORTED;
   if(clean_state == ASC_CAND_EVID_INTAKE_STALE_RECOVERABLE)
      return ASC_CE_STALE;
   if(clean_state == ASC_CAND_EVID_INTAKE_UNAVAILABLE_RECOVERABLE)
      return ASC_CE_UNAVAILABLE;
   if(clean_state == ASC_CAND_EVID_INTAKE_INSUFFICIENT_NOW)
      return ASC_CE_INSUFFICIENT;
   if(clean_state == ASC_CAND_EVID_INTAKE_DEP_BLOCKED)
      return ASC_CE_DEPENDENCY_BLOCKED;
   if(clean_state == ASC_CAND_EVID_INTAKE_NOT_APPLICABLE)
      return ASC_CE_NO_CLAIM;
   if(clean_state == ASC_CAND_EVID_INTAKE_SRC_RT_UNPROVEN)
      return ASC_CE_SRC_RT_UNPROVEN;
   return ASC_CE_SRC_RT_UNPROVEN;
  }

string ASC_CandidateEvidenceIntakeDetailAppend(const string detail,
                                               const string intake_state,
                                               const string runtime_proof)
  {
   string result = detail;
   if(StringLen(result) > 0)
      result += " | ";
   string state = ASC_CandidateEvidenceIntakeText(intake_state);
   result += "candidate_evidence_intake_boundary=present";
   result += " | candidate_evidence_intake_state=" + state;
   result += " | candidate_evidence_intake_claim_evidence_status=" + ASC_CandidateEvidenceIntakeClaimEvidenceStatus(state);
   result += " | candidate_score_change=no";
   result += " | candidate_gate_change=no";
   result += " | unavailable_is_not_candidate_gate=yes";
   result += " | candidate_evidence_intake_runtime_proof=" + (StringLen(runtime_proof) > 0 ? runtime_proof : ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN040);
   result += " | metadata_only=yes";
   result += " | no_shortlist_rank_change=yes";
   result += " | no_top10_change=yes";
   return result;
  }

string ASC_EvidenceBoundaryDetailAppend(const string detail,
                                        const string availability_state,
                                        const string recovery_state,
                                        const string runtime_proof)
  {
   string result = detail;
   if(StringLen(result) > 0)
      result += " | ";
   string avail = ASC_EvidenceAvailabilityText(availability_state);
   string rec = ASC_EvidenceRecoveryText(recovery_state);
   result += "evidence_availability_boundary=present";
   result += " | evidence_availability_state=" + avail;
   result += " | evidence_availability_claim_evidence_status=" + ASC_EvidenceAvailabilityClaimEvidenceStatus(avail);
   result += " | evidence_recovery_boundary=present";
   result += " | evidence_recovery_state=" + rec;
   result += " | evidence_recovery_claim_evidence_status=" + ASC_EvidenceRecoveryClaimEvidenceStatus(rec);
   result += " | evidence_recheck_boundary=present";
   result += " | evidence_recheck_boundary_scope=" + ASC_EvidenceRecheckBoundaryScope();
   result += " | evidence_recheck_existing_cadence_only=yes";
   result += " | unavailable_cannot_create_confidence=yes";
   result += " | placeholder_cannot_create_confidence=yes";
   result += " | stale_requires_downgrade=yes";
   result += " | unavailable_is_recoverable=yes";
   result += " | unavailable_is_not_clean_support=yes";
   result += " | unavailable_is_not_permanent_gate=yes";
   result += " | recovery_upgrade_requires_fresh_support=yes";
   result += " | failed_refresh_remains_non_clean=yes";
   result += " | no_heavy_refresh_loop=yes";
   result += " | refresh_recheck_runtime_proof=" + (StringLen(runtime_proof) > 0 ? runtime_proof : ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN040);
   return result;
  }

string ASC_DossierHydrationClaimEvidenceStatus(const bool write_ok,
                                               const bool has_class,
                                               const bool has_reason,
                                               const bool has_boundary,
                                               const string write_state,
                                               const string write_reason)
  {
   if(write_state == "continuity")
      return ASC_CE_STALE;
   if(!has_class || !has_reason || !has_boundary)
      return ASC_CE_INSUFFICIENT;
   if(!write_ok)
     {
      if(StringFind(write_reason, "dependency") >= 0 || StringFind(write_reason, "blocked") >= 0)
         return ASC_CE_DEPENDENCY_BLOCKED;
      if(StringFind(write_reason, "unavailable") >= 0 || StringFind(write_reason, "path") >= 0 || StringFind(write_reason, "open") >= 0)
         return ASC_CE_UNAVAILABLE;
      return ASC_CE_INSUFFICIENT;
     }
   return ASC_CE_ARTIFACT_SUPPORTED;
  }

string ASC_DossierHydrationClaimEvidenceSupport(const bool has_class,
                                                const bool has_reason,
                                                const bool has_boundary)
  {
   return "dossier.hydration_required_token_validation"
          + StringFormat(";hydration_class_present=%s;hydration_reason_present=%s;hydration_boundary_present=%s",
                         has_class ? "yes" : "no",
                         has_reason ? "yes" : "no",
                         has_boundary ? "yes" : "no");
  }


string ASC_PubCEStatus(const bool write_ok,
                       const string write_state,
                       const string write_reason,
                       const string bundle_status)
  {
   if(write_state == "continuity")
      return ASC_CE_STALE;

   if(StringFind(bundle_status, "fresh") >= 0 && (StringFind(bundle_status, "pending") >= 0 || StringFind(bundle_status, "skipped") >= 0))
      return ASC_CE_CONTRADICTION_PENDING;

   if(StringFind(write_state, "pending") >= 0 || StringFind(bundle_status, "pending") >= 0 || StringFind(write_reason, "pending") >= 0)
      return ASC_CE_INSUFFICIENT;

   if(StringFind(write_state, "skipped") >= 0 || StringFind(write_state, "preserved") >= 0 || StringFind(write_reason, "skip") >= 0 || StringFind(write_reason, "no_material_change") >= 0)
      return ASC_CE_NO_CLAIM;

   if(!write_ok)
     {
      if(StringFind(write_reason, "directory_create_failed") >= 0 || StringFind(write_reason, "path") >= 0 || StringFind(write_reason, "open") >= 0 || StringFind(write_reason, "write failed") >= 0 || StringFind(write_reason, "promote failed") >= 0)
         return ASC_CE_UNAVAILABLE;
      if(StringFind(write_reason, "dependency") >= 0 || StringFind(write_reason, "blocked") >= 0)
         return ASC_CE_DEPENDENCY_BLOCKED;
      return ASC_CE_INSUFFICIENT;
     }

   if(StringFind(bundle_status, "failure") >= 0 || StringFind(write_state, "failure") >= 0)
      return ASC_CE_UNAVAILABLE;

   if(StringFind(bundle_status, "stale") >= 0 || StringFind(bundle_status, "last_good") >= 0 || StringFind(bundle_status, "continuity") >= 0)
      return ASC_CE_STALE;

   if(StringLen(write_state) <= 0 || write_state == "source_only")
      return ASC_CE_SRC_RT_UNPROVEN;

   return ASC_CE_ARTIFACT_SUPPORTED;
  }

string ASC_PubCESupport(const string write_state,
                        const string bundle_status)
  {
   return "artifact.publication_status_boundary;artifact.manifest.proof_boundary"
          + ";write_state=" + (StringLen(write_state) > 0 ? write_state : "unspecified")
          + ";bundle_status=" + (StringLen(bundle_status) > 0 ? bundle_status : "unspecified");
  }


string ASC_SelArtCEStatus(const bool selected_available,
                          const bool artifact_exists,
                          const bool payload_readable,
                          const bool symbol_match,
                          const bool canonical_match,
                          const bool current_or_verified,
                          const bool write_ok,
                          const string write_state,
                          const string write_reason)
  {
   string state_lc = write_state;
   string reason_lc = write_reason;
   StringToLower(state_lc);
   StringToLower(reason_lc);

   if(!selected_available)
      return ASC_CE_NO_CLAIM;

   if(StringFind(reason_lc, "dependency") >= 0
      || StringFind(reason_lc, "blocked") >= 0
      || StringFind(reason_lc, "backoff") >= 0
      || StringFind(reason_lc, "not_due") >= 0
      || StringFind(reason_lc, "waiting") >= 0)
      return ASC_CE_DEPENDENCY_BLOCKED;

   if(!write_ok)
     {
      if(StringFind(reason_lc, "path") >= 0
         || StringFind(reason_lc, "open") >= 0
         || StringFind(reason_lc, "write") >= 0
         || StringFind(reason_lc, "promote") >= 0
         || StringFind(reason_lc, "unavailable") >= 0)
         return ASC_CE_UNAVAILABLE;
      return ASC_CE_INSUFFICIENT;
     }

   if(payload_readable && (!symbol_match || !canonical_match))
      return ASC_CE_CONTRADICTION_PENDING;

   if(!artifact_exists || !payload_readable)
      return ASC_CE_UNAVAILABLE;

   if(StringFind(state_lc, "pending") >= 0)
      return ASC_CE_INSUFFICIENT;

   if(StringFind(state_lc, "continuity") >= 0
      || StringFind(reason_lc, "last_good") >= 0
      || StringFind(reason_lc, "retained") >= 0
      || !current_or_verified)
      return ASC_CE_STALE;

   if(StringLen(state_lc) <= 0 || state_lc == "source_only")
      return ASC_CE_SRC_RT_UNPROVEN;

   if(current_or_verified)
      return ASC_CE_ARTIFACT_SUPPORTED;

   return ASC_CE_INSUFFICIENT;
  }

string ASC_SelArtCESupport(const string write_state,
                           const string verification_reason,
                           const bool derivative_written)
  {
   return "selected_artifact.alignment_boundary;current_focus_root_dossier_pair"
          + ";write_state=" + (StringLen(write_state) > 0 ? write_state : "unspecified")
          + ";verification=" + (StringLen(verification_reason) > 0 ? verification_reason : "unspecified")
          + ";derivative_copy=" + (derivative_written ? "written" : "not_written_or_disabled");
  }


string ASC_CFExpectationState(const bool selected_available,
                              const bool focus_path_available,
                              const bool focus_is_root_dossier,
                              const bool support_copy_enabled,
                              const bool support_copy_written,
                              const bool stale_or_retained,
                              const bool dependency_blocked,
                              const bool contradiction_pending,
                              const bool source_only)
  {
   if(!selected_available)
      return "not_applicable_no_selected_symbol";
   if(contradiction_pending)
      return "contradiction_pending";
   if(dependency_blocked)
      return "dependency_blocked";
   if(stale_or_retained)
      return "retained_last_good";
   if(!focus_path_available)
      return "unavailable";
   if(source_only)
      return "source_supported_runtime_unproven";
   if(focus_is_root_dossier)
      return "dossier_derivative_expected";
   if(support_copy_enabled && support_copy_written)
      return "selected_dossier_copy_expected";
   return "separate_artifact_expected";
  }

string ASC_CFExpectationCEStatus(const string expectation_state,
                                 const bool focus_exists,
                                 const bool focus_has_payload,
                                 const bool write_ok)
  {
   if(expectation_state == "not_applicable_no_selected_symbol")
      return ASC_CE_NO_CLAIM;
   if(expectation_state == "contradiction_pending")
      return ASC_CE_CONTRADICTION_PENDING;
   if(expectation_state == "dependency_blocked")
      return ASC_CE_DEPENDENCY_BLOCKED;
   if(expectation_state == "retained_last_good" || expectation_state == "stale")
      return ASC_CE_STALE;
   if(expectation_state == "source_supported_runtime_unproven")
      return ASC_CE_SRC_RT_UNPROVEN;
   if(expectation_state == "unavailable" || !write_ok)
      return ASC_CE_UNAVAILABLE;
   if(expectation_state == "dossier_derivative_expected")
      return (focus_exists && focus_has_payload) ? ASC_CE_ARTIFACT_SUPPORTED : ASC_CE_SRC_RT_UNPROVEN;
   if(expectation_state == "selected_dossier_copy_expected")
      return (focus_exists && focus_has_payload) ? ASC_CE_ARTIFACT_SUPPORTED : ASC_CE_INSUFFICIENT;
   if(expectation_state == "separate_artifact_expected")
      return (focus_exists && focus_has_payload) ? ASC_CE_ARTIFACT_SUPPORTED : ASC_CE_INSUFFICIENT;
   return ASC_CE_INSUFFICIENT;
  }

string ASC_CFExpectationSupport(const string expectation_state,
                                const string focus_path,
                                const string selected_symbol,
                                const string write_state,
                                const string reason)
  {
   return "current_focus.expectation_boundary"
          + ";expectation=" + (StringLen(expectation_state) > 0 ? expectation_state : "unavailable")
          + ";expectation_scope=" + ASC_CurrentFocusExpectationScope()
          + ";path=" + (StringLen(focus_path) > 0 ? focus_path : "unavailable")
          + ";selected_symbol=" + (StringLen(selected_symbol) > 0 ? selected_symbol : "none")
          + ";write_state=" + (StringLen(write_state) > 0 ? write_state : "unspecified")
          + ";reason=" + (StringLen(reason) > 0 ? reason : "unspecified")
          + ";separate_current_focus_file_required=no_when_contract_path_is_root_dossier";
  }

string ASC_MktBoardCEStatus(const bool write_ok,
                            const string write_state,
                            const string write_reason,
                            const string board_status,
                            const string board_result,
                            const bool child_pending)
  {
   string state_lc = write_state;
   string reason_lc = write_reason;
   string status_lc = board_status;
   string result_lc = board_result;
   StringToLower(state_lc);
   StringToLower(reason_lc);
   StringToLower(status_lc);
   StringToLower(result_lc);

   if(StringFind(status_lc, "fresh") >= 0
      && (StringFind(result_lc, "pending") >= 0
          || StringFind(result_lc, "skipped") >= 0
          || child_pending))
      return ASC_CE_CONTRADICTION_PENDING;

   if(StringFind(reason_lc, "dependency") >= 0
      || StringFind(reason_lc, "blocked") >= 0
      || StringFind(reason_lc, "backoff") >= 0
      || StringFind(reason_lc, "not_due") >= 0
      || StringFind(reason_lc, "awaiting") >= 0)
      return ASC_CE_DEPENDENCY_BLOCKED;

   if(StringFind(state_lc, "pending") >= 0
      || StringFind(status_lc, "pending") >= 0
      || StringFind(result_lc, "pending") >= 0
      || StringFind(reason_lc, "pending") >= 0
      || child_pending)
      return ASC_CE_INSUFFICIENT;

   if(StringFind(state_lc, "continuity") >= 0
      || StringFind(status_lc, "continuity") >= 0
      || StringFind(result_lc, "continuity") >= 0
      || StringFind(reason_lc, "last_good") >= 0
      || StringFind(reason_lc, "retained") >= 0)
      return ASC_CE_STALE;

   if(StringFind(result_lc, "skipped") >= 0
      || StringFind(result_lc, "unchanged") >= 0
      || StringFind(state_lc, "preserved") >= 0
      || StringFind(reason_lc, "skip") >= 0
      || StringFind(reason_lc, "no_material_change") >= 0)
      return ASC_CE_NO_CLAIM;

   if(!write_ok)
     {
      if(StringFind(reason_lc, "path") >= 0
         || StringFind(reason_lc, "open") >= 0
         || StringFind(reason_lc, "write") >= 0
         || StringFind(reason_lc, "promote") >= 0
         || StringFind(reason_lc, "unavailable") >= 0)
         return ASC_CE_UNAVAILABLE;
      return ASC_CE_INSUFFICIENT;
     }

   if(StringFind(status_lc, "failure") >= 0 || StringFind(result_lc, "failure") >= 0)
      return ASC_CE_UNAVAILABLE;

   if(StringFind(status_lc, "degraded") >= 0 || StringFind(result_lc, "degraded") >= 0)
      return ASC_CE_INSUFFICIENT;

   if(StringLen(state_lc) <= 0 || StringLen(status_lc) <= 0 || state_lc == "source_only")
      return ASC_CE_SRC_RT_UNPROVEN;

   if(StringFind(status_lc, "fresh") >= 0 || StringFind(result_lc, "fresh") >= 0)
      return ASC_CE_ARTIFACT_SUPPORTED;

   return ASC_CE_INSUFFICIENT;
  }

string ASC_MktBoardCESupport(const string write_state,
                             const string write_reason,
                             const string board_status,
                             const string board_result,
                             const bool child_pending)
  {
   return "market_board.artifact_compression_boundary"
          + ";write_state=" + (StringLen(write_state) > 0 ? write_state : "unspecified")
          + ";write_reason=" + (StringLen(write_reason) > 0 ? write_reason : "unspecified")
          + ";board_status=" + (StringLen(board_status) > 0 ? board_status : "unspecified")
          + ";board_result=" + (StringLen(board_result) > 0 ? board_result : "unspecified")
          + ";child_pending=" + (child_pending ? "yes" : "no");
  }


string ASC_CrossArtCEStatus(const bool dossier_visible,
                            const bool focus_visible,
                            const bool board_visible,
                            const bool top10_visible,
                            const bool manifest_visible,
                            const bool stale_or_retained,
                            const bool dependency_blocked,
                            const bool contradiction_pending,
                            const bool runtime_observed,
                            const bool no_context)
  {
   if(no_context)
      return ASC_CE_NO_CLAIM;

   if(contradiction_pending)
      return ASC_CE_CONTRADICTION_PENDING;

   if(dependency_blocked)
      return ASC_CE_DEPENDENCY_BLOCKED;

   if(stale_or_retained)
      return ASC_CE_STALE;

   if(!manifest_visible || !board_visible || !top10_visible)
      return ASC_CE_UNAVAILABLE;

   if(!dossier_visible || !focus_visible)
      return ASC_CE_INSUFFICIENT;

   if(!runtime_observed)
      return ASC_CE_SRC_RT_UNPROVEN;

   return ASC_CE_ARTIFACT_SUPPORTED;
  }

string ASC_CrossArtCESupport(const bool dossier_visible,
                             const bool focus_visible,
                             const bool board_visible,
                             const bool top10_visible,
                             const bool manifest_visible,
                             const string divergence,
                             const string publication_ce_status)
  {
   return "cross_artifact.alignment_witness"
          + ";dossier=" + (dossier_visible ? "visible" : "missing_or_unverified")
          + ";current_focus=" + (focus_visible ? "visible" : "missing_or_unverified")
          + ";market_board=" + (board_visible ? "visible" : "missing_or_unverified")
          + ";global_top10=" + (top10_visible ? "visible" : "missing_or_unverified")
          + ";manifest=" + (manifest_visible ? "visible" : "missing_or_unverified")
          + ";divergence=" + (StringLen(divergence) > 0 ? divergence : "none")
          + ";artifact_publication_ce_status=" + (StringLen(publication_ce_status) > 0 ? publication_ce_status : "unspecified");
  }


string ASC_OpSurfCEStatus(const bool boundary_listed,
                          const bool manifest_written,
                          const bool contradiction_pending,
                          const bool stale_or_retained,
                          const bool unavailable,
                          const bool no_claim)
  {
   if(no_claim)
      return ASC_CE_NO_CLAIM;
   if(contradiction_pending)
      return ASC_CE_CONTRADICTION_PENDING;
   if(unavailable)
      return ASC_CE_UNAVAILABLE;
   if(stale_or_retained)
      return ASC_CE_STALE;
   if(!boundary_listed)
      return ASC_CE_INSUFFICIENT;
   return ASC_CE_SRC_RT_UNPROVEN;
  }

string ASC_OpSurfBoundaryState(const bool boundary_listed,
                               const bool manifest_written,
                               const bool contradiction_pending,
                               const bool stale_or_retained,
                               const bool unavailable,
                               const bool no_claim)
  {
   if(no_claim)
      return "no_claim";
   if(contradiction_pending)
      return "contradiction_pending";
   if(unavailable)
      return "unavailable";
   if(stale_or_retained)
      return "stale";
   if(!boundary_listed)
      return "insufficient_evidence";
   if(manifest_written)
      return "claim_evidence_present";
   return "proof_required";
  }

string ASC_OpSurfCESupport(const string boundary_state,
                           const string runtime_proof)
  {
   return "operator_surface.claim_boundary"
          + ";surface_claim_boundary=" + (StringLen(boundary_state) > 0 ? boundary_state : "proof_required")
          + ";surface_targets=" + ASC_OpSurfBoundaryTargets()
          + ";surface_scope=" + ASC_OpSurfScope()
          + ";proof_boundary=metadata_only_no_operator_text_rewrite"
          + ";runtime_proof=" + (StringLen(runtime_proof) > 0 ? runtime_proof : ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN030);
  }

string ASC_ClaimEvidenceAppend(const string detail,
                               const string status,
                               const string support,
                               const string runtime_proof)
  {
   string result = detail;
   if(StringLen(result) > 0)
      result += " | ";
   result += "claim_evidence_status=" + ASC_ClaimEvidenceStatusText(status);
   result += " | claim_evidence_support=" + (StringLen(support) > 0 ? support : "unspecified");
   result += " | claim_evidence_runtime_proof=" + (StringLen(runtime_proof) > 0 ? runtime_proof : ASC_FUNCTION_RESULT_PROOF_STATUS_NOT_CLAIMED);
   return result;
  }

struct ASC_FunctionResult
  {
   string module_name;
   string function_name;
   string scope;
   datetime started_utc;
   datetime finished_utc;
   ASC_FunctionResultState state;
   ASC_ResultCode code;
   string detail_message;
   string target_path;
   string source_owner;
   string truth_boundary;
   string hydration_class;
   string proof_event;
   string proof_status;
   string proof_row_class;
  };

void ASC_FunctionResultBegin(ASC_FunctionResult &result,
                             const string module_name,
                             const string function_name,
                             const string scope)
  {
   result.module_name = module_name;
   result.function_name = function_name;
   result.scope = scope;
   result.started_utc = TimeGMT();
   result.finished_utc = 0;
   result.state = ASC_RESULT_OK;
   result.code = ASC_RC_OK;
   result.detail_message = "";
   result.target_path = "";
   result.source_owner = "unspecified";
   result.truth_boundary = "unspecified";
   result.hydration_class = "unspecified";
   result.proof_event = ASC_FUNCTION_RESULT_PROOF_EVENT_NO_CLAIM;
   result.proof_status = ASC_FUNCTION_RESULT_PROOF_STATUS_NOT_CLAIMED;
   result.proof_row_class = ASC_PROOF_ROW_CLASS_DIAGNOSTIC_SUMMARY;
  }

void ASC_FunctionResultSetTruthBoundary(ASC_FunctionResult &result,
                                        const string source_owner,
                                        const string truth_boundary)
  {
   result.source_owner = (StringLen(source_owner) > 0 ? source_owner : "unspecified");
   result.truth_boundary = (StringLen(truth_boundary) > 0 ? truth_boundary : "unspecified");
  }

void ASC_FunctionResultSetHydrationClass(ASC_FunctionResult &result,
                                         const string hydration_class)
  {
   result.hydration_class = (StringLen(hydration_class) > 0 ? hydration_class : "unspecified");
  }

void ASC_FunctionResultSetProof(ASC_FunctionResult &result,
                                const string proof_event,
                                const string proof_status)
  {
   result.proof_event = (StringLen(proof_event) > 0 ? proof_event : ASC_FUNCTION_RESULT_PROOF_EVENT_NO_CLAIM);
   result.proof_status = (StringLen(proof_status) > 0 ? proof_status : ASC_FUNCTION_RESULT_PROOF_STATUS_NOT_CLAIMED);
  }

void ASC_FunctionResultSetProofRowClass(ASC_FunctionResult &result,
                                        const string proof_row_class)
  {
   result.proof_row_class = ASC_FunctionResultsProofRowClassText(proof_row_class);
  }

string ASC_FunctionResultResolvedProofRowClass(const ASC_FunctionResult &result)
  {
   if(result.state == ASC_RESULT_ERROR)
      return ASC_PROOF_ROW_CLASS_ERROR_ONLY;
   if(ASC_FunctionResultsProofRowClassKnown(result.proof_row_class)
      && result.proof_row_class != ASC_PROOF_ROW_CLASS_DIAGNOSTIC_SUMMARY)
      return result.proof_row_class;
   if(result.proof_event == ASC_FUNCTION_RESULT_PROOF_EVENT_SOURCE_SUPPORT
      || result.proof_event == ASC_FUNCTION_RESULT_PROOF_EVENT_RUNTIME_LOG_REQUIRED
      || result.proof_event == ASC_FUNCTION_RESULT_PROOF_EVENT_CHECKPOINT_DEFERRED)
      return ASC_PROOF_ROW_CLASS_REQUIRED_ONCE;
   if(result.proof_event == ASC_FUNCTION_RESULT_PROOF_EVENT_ARTIFACT_PUBLICATION
      || result.proof_event == ASC_FUNCTION_RESULT_PROOF_EVENT_HYDRATION_OBSERVED)
      return ASC_PROOF_ROW_CLASS_ARTIFACT_BOUNDARY;
   if(result.proof_event == ASC_FUNCTION_RESULT_PROOF_EVENT_MISSING_PROOF
      || result.proof_event == ASC_FUNCTION_RESULT_PROOF_EVENT_UNAVAILABLE_PROOF
      || result.proof_event == ASC_FUNCTION_RESULT_PROOF_EVENT_STALE_PROOF
      || result.proof_event == ASC_FUNCTION_RESULT_PROOF_EVENT_INSUFFICIENT_EVIDENCE
      || result.proof_event == ASC_FUNCTION_RESULT_PROOF_EVENT_DEPENDENCY_BLOCKED)
      return ASC_PROOF_ROW_CLASS_STATE_CHANGE;
   return ASC_PROOF_ROW_CLASS_DIAGNOSTIC_SUMMARY;
  }

string ASC_FunctionResultDetailWithProofRowClass(const ASC_FunctionResult &result)
  {
   string detail = result.detail_message;
   if(StringLen(detail) > 0)
      detail += " | ";
   detail += "proof_row_class=" + ASC_FunctionResultResolvedProofRowClass(result);
   return detail;
  }

void ASC_FunctionResultMarkSourceSupport(ASC_FunctionResult &result)
  {
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_SOURCE_SUPPORT,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_SOURCE_ONLY);
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_REQUIRED_ONCE);
  }

void ASC_FunctionResultMarkArtifactPublication(ASC_FunctionResult &result)
  {
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_ARTIFACT_PUBLICATION,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_ARTIFACT_OBSERVED);
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_ARTIFACT_BOUNDARY);
  }

void ASC_FunctionResultMarkRuntimeLogRequired(ASC_FunctionResult &result)
  {
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_RUNTIME_LOG_REQUIRED,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN030);
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_REQUIRED_ONCE);
  }

void ASC_FunctionResultMarkMissingProof(ASC_FunctionResult &result)
  {
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_MISSING_PROOF,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_MISSING_FROM_OUTPUT_PACKAGE);
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_STATE_CHANGE);
  }

void ASC_FunctionResultMarkUnavailableProof(ASC_FunctionResult &result)
  {
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_UNAVAILABLE_PROOF,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_UNAVAILABLE);
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_STATE_CHANGE);
  }

void ASC_FunctionResultMarkStaleProof(ASC_FunctionResult &result)
  {
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_STALE_PROOF,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_STALE);
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_STATE_CHANGE);
  }

void ASC_FunctionResultMarkInsufficientEvidence(ASC_FunctionResult &result)
  {
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_INSUFFICIENT_EVIDENCE,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_INSUFFICIENT_EVIDENCE);
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_STATE_CHANGE);
  }

void ASC_FunctionResultMarkDependencyBlocked(ASC_FunctionResult &result)
  {
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_DEPENDENCY_BLOCKED,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_DEPENDENCY_BLOCKED);
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_STATE_CHANGE);
  }

void ASC_FunctionResultMarkSourceSupportedRuntimeUnproven(ASC_FunctionResult &result)
  {
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_SOURCE_SUPPORT,
                              ASC_PROOF_STATUS_SRC_RT_UNPROVEN);
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_REQUIRED_ONCE);
  }

void ASC_FunctionResultMarkDeferredProof(ASC_FunctionResult &result)
  {
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_CHECKPOINT_DEFERRED,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_DEFERRED_TO_RUN030);
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_REQUIRED_ONCE);
  }

void ASC_FunctionResultMarkNoClaim(ASC_FunctionResult &result)
  {
   ASC_FunctionResultSetProof(result,
                              ASC_FUNCTION_RESULT_PROOF_EVENT_NO_CLAIM,
                              ASC_FUNCTION_RESULT_PROOF_STATUS_NOT_CLAIMED);
   ASC_FunctionResultSetProofRowClass(result, ASC_PROOF_ROW_CLASS_DIAGNOSTIC_SUMMARY);
  }

void ASC_FunctionResultMarkClaimEvidenceStatus(ASC_FunctionResult &result,
                                               const string status)
  {
   string normalized = ASC_ClaimEvidenceStatusText(status);
   if(normalized == ASC_CE_ARTIFACT_SUPPORTED || normalized == ASC_CE_DATA_SUPPORTED || normalized == ASC_CE_FORMULA_SUPPORTED)
     {
      ASC_FunctionResultMarkArtifactPublication(result);
      return;
     }
   if(normalized == ASC_CE_STALE)
     {
      ASC_FunctionResultMarkStaleProof(result);
      return;
     }
   if(normalized == ASC_CE_UNAVAILABLE)
     {
      ASC_FunctionResultMarkUnavailableProof(result);
      return;
     }
   if(normalized == ASC_CE_DEPENDENCY_BLOCKED)
     {
      ASC_FunctionResultMarkDependencyBlocked(result);
      return;
     }
   if(normalized == ASC_CE_SRC_RT_UNPROVEN)
     {
      ASC_FunctionResultMarkSourceSupportedRuntimeUnproven(result);
      return;
     }
   if(normalized == ASC_CE_NO_CLAIM)
     {
      ASC_FunctionResultMarkNoClaim(result);
      return;
     }
   ASC_FunctionResultMarkInsufficientEvidence(result);
  }


string ASC_Top5BucketSkeletonManifest(const string family_state,
                                      const int bucket_count,
                                      const int child_target_count,
                                      const int child_written_count,
                                      const int child_pending_count,
                                      const int child_failed_count,
                                      const int queue_remaining,
                                      const string last_symbol,
                                      const string last_error)
  {
   string state_token = (StringLen(family_state) > 0 ? family_state : ASC_TOP5_BUCKET_STATE_SKELETON_READY);
   string symbol_token = (StringLen(last_symbol) > 0 ? last_symbol : "none");
   string error_token = (StringLen(last_error) > 0 ? last_error : "none");
   string body = "artifact_family_id=" + ASC_TOP5_BUCKET_FAMILY_ID + "\n";
   body += "family_state=" + state_token + "\n";
   body += "path=" + ASC_TOP5_BUCKET_PATH_FRAGMENT + "\n";
   body += "family_manifest=" + ASC_TOP5_BUCKET_FAMILY_MANIFEST + "\n";
   body += "bucket_manifest=" + ASC_TOP5_BUCKET_BUCKET_MANIFEST + "\n";
   body += "staging_folder=" + ASC_TOP5_BUCKET_STAGING_FOLDER + "\n";
   body += "archive_folder=" + ASC_TOP5_BUCKET_ARCHIVE_FOLDER + "\n";
   body += "bucket_count=" + IntegerToString(MathMax(0, bucket_count)) + "\n";
   body += "bucket_child_target_count=" + IntegerToString(MathMax(0, child_target_count)) + "\n";
   body += "bucket_child_written_count=" + IntegerToString(MathMax(0, child_written_count)) + "\n";
   body += "bucket_child_pending_count=" + IntegerToString(MathMax(0, child_pending_count)) + "\n";
   body += "bucket_child_failed_count=" + IntegerToString(MathMax(0, child_failed_count)) + "\n";
   body += "bucket_family_promoted=false\n";
   body += "bucket_family_partial=false\n";
   body += "bucket_family_degraded=false\n";
   body += "bucket_manifest_written=false\n";
   body += "top5_per_bucket_queue_remaining=" + IntegerToString(MathMax(0, queue_remaining)) + "\n";
   body += "top5_per_bucket_last_symbol=" + symbol_token + "\n";
   body += "top5_per_bucket_last_error=" + error_token + "\n";
   body += "closed_symbols_actionable=false\n";
   body += "rank_formula_change=false\n";
   body += "trade_signal=false\n";
   body += "execution_change=false\n";
   body += "source_run_id=" + ASC_SourceRunId() + "\n";
   body += "proof_boundary=" + ASC_TOP5_BUCKET_PROOF_BOUNDARY + "\n";
   return body;
  }

string ASC_Top5BucketSkeletonProofTokens(const string family_state,
                                         const int bucket_count,
                                         const int child_target_count,
                                         const int child_written_count,
                                         const int child_pending_count,
                                         const int child_failed_count,
                                         const int queue_remaining,
                                         const string last_symbol,
                                         const string last_error)
  {
   string state_token = (StringLen(family_state) > 0 ? family_state : ASC_TOP5_BUCKET_STATE_SKELETON_READY);
   string symbol_token = (StringLen(last_symbol) > 0 ? last_symbol : "none");
   string error_token = (StringLen(last_error) > 0 ? last_error : "none");
   string line = "run110_top5_per_bucket_prelive_readiness_proof=present";
   line += " | artifact_family_id=" + ASC_TOP5_BUCKET_FAMILY_ID;
   line += " | family_display=" + ASC_TOP5_BUCKET_FAMILY_DISPLAY;
   line += " | family_path=" + ASC_TOP5_BUCKET_PATH_FRAGMENT;
   line += " | family_manifest=" + ASC_TOP5_BUCKET_FAMILY_MANIFEST;
   line += " | bucket_manifest=" + ASC_TOP5_BUCKET_BUCKET_MANIFEST;
   line += " | top5_per_bucket_family_state=" + state_token;
   line += " | bucket_count=" + IntegerToString(MathMax(0, bucket_count));
   line += " | bucket_child_target_count=" + IntegerToString(MathMax(0, child_target_count));
   line += " | bucket_child_written_count=" + IntegerToString(MathMax(0, child_written_count));
   line += " | bucket_child_pending_count=" + IntegerToString(MathMax(0, child_pending_count));
   line += " | bucket_child_failed_count=" + IntegerToString(MathMax(0, child_failed_count));
   line += " | bucket_family_promoted=false";
   line += " | bucket_family_partial=false";
   line += " | bucket_family_degraded=false";
   line += " | bucket_manifest_written=false";
   line += " | top5_per_bucket_queue_remaining=" + IntegerToString(MathMax(0, queue_remaining));
   line += " | top5_per_bucket_last_symbol=" + symbol_token;
   line += " | top5_per_bucket_last_error=" + error_token;
   line += " | closed_symbols_actionable=false";
   line += " | rank_formula_change=false";
   line += " | trade_signal=false";
   line += " | execution_change=false";
   line += " | top_level_buckets_first=true";
   line += " | sub_family_buckets_deferred=RUN111R_or_later";
   line += " | option_c_depth_policy=" + ASC_TOP5_BUCKET_HYDRATION_RANK1_3 + "," + ASC_TOP5_BUCKET_HYDRATION_RANK4_5;
   line += " | canonical_bucket_ids=" + ASC_TOP5_BUCKET_CANONICAL_IDS;
   line += " | closed_safety=" + ASC_TOP5_BUCKET_SAFETY_CLOSED_RETAINED;
   line += " | uncertain_safety=" + ASC_TOP5_BUCKET_SAFETY_UNCERTAIN;
   line += " | stale_safety=" + ASC_TOP5_BUCKET_SAFETY_STALE;
   line += " | child_queue_added=true";
   line += " | promoted_family_created=false";
   line += " | current_folder_promotion=false";
   line += " | sub_family_writer_active=false";
   line += " | dynamic_sub_family_readiness=" + ASC_TOP5_BUCKET_DYNAMIC_SUBFAMILY_READINESS;
   line += " | proof_boundary=" + ASC_TOP5_BUCKET_PROOF_BOUNDARY;
   line += " | source_run_id=" + ASC_SourceRunId();
   return line;
  }

string ASC_FunctionResultsRun090AggregateProofTokens(const int deferred_l5_pending_count,
                                                     const int deferred_l5_expired_count,
                                                     const int deferred_l5_retry_exhausted_count,
                                                     const int deferred_l5_completed_count,
                                                     const string dossier_queue_state,
                                                     const int dossier_queue_cursor,
                                                     const int dossier_queue_backlog_count,
                                                     const int dossier_queue_stall_count,
                                                     const int dossier_queue_recovered_count,
                                                     const string alignment_status,
                                                     const string board_signature,
                                                     const string derived_from_board_signature,
                                                     const string artifact_freshness_status,
                                                     const string current_focus_mirror_status)
  {
   string line = "run090_functionresults_aggregate_proof=present";
   line += " | source_run_id=" + ASC_SourceRunId();
   line += " | source_identity_token=" + ASC_SourceIdentityToken();
   line += " | artifact_written_by_run=" + ASC_SourceRunId();
   line += " | artifact_schema_version=" + ASC_ArtifactSchemaVersion();
   line += " | build_identity_present=true";
   line += " | deep_hydration_pending=" + IntegerToString(MathMax(0, deferred_l5_pending_count));
   line += " | deep_hydration_expired=" + IntegerToString(MathMax(0, deferred_l5_expired_count));
   line += " | deep_hydration_retry_exhausted=" + IntegerToString(MathMax(0, deferred_l5_retry_exhausted_count));
   line += " | deep_hydration_completed=" + IntegerToString(MathMax(0, deferred_l5_completed_count));
   line += " | dossier_queue_state=" + (StringLen(dossier_queue_state) > 0 ? dossier_queue_state : "idle");
   line += " | dossier_queue_cursor=" + IntegerToString(MathMax(0, dossier_queue_cursor));
   line += " | dossier_queue_backlog_count=" + IntegerToString(MathMax(0, dossier_queue_backlog_count));
   line += " | dossier_queue_stall_count=" + IntegerToString(MathMax(0, dossier_queue_stall_count));
   line += " | dossier_queue_recovered_count=" + IntegerToString(MathMax(0, dossier_queue_recovered_count));
   line += " | alignment_status=" + (StringLen(alignment_status) > 0 ? alignment_status : "unproven");
   line += " | board_signature=" + (StringLen(board_signature) > 0 ? board_signature : "unavailable");
   line += " | derived_from_board_signature=" + (StringLen(derived_from_board_signature) > 0 ? derived_from_board_signature : "unavailable");
   line += " | artifact_freshness_status=" + (StringLen(artifact_freshness_status) > 0 ? artifact_freshness_status : "current_runtime_unproven");
   line += " | freshness_taxonomy=file_exists_only,non_empty_unproven,written_by_current_run,promoted_current,current_runtime_unproven,staging_not_current,archive_historical_only,retained_last_good_not_current,stale_not_current,degraded_current,continuity_fallback,missing,selected_symbol_none_not_failure";
   line += " | promoted_current=written_by_run_and_promoted_required";
   line += " | staging_not_current=true | archive_historical_only=true | retained_last_good_not_current=true | stale_not_current=true | degraded_current=label_degraded_not_complete | continuity_fallback=last_good_continuity_not_new_current";
   line += " | current_focus_mirror_status=" + (StringLen(current_focus_mirror_status) > 0 ? current_focus_mirror_status : "selected_symbol_none_or_unobserved");
   line += " | current_focus_truth_owner=false | selected_symbol_dossier_mirror=true";
   line += " | file_exists_is_fresh_current_promoted_proof=false";
   line += " | retained_is_current=false | stale_is_current=false | staging_is_current=false | archive_is_current=false";
   line += " | current_requires_written_by_run_and_promoted=true";
   line += " | functionresults_schema_change=false | functionresults_rows_added=false";
   line += " | per_symbol_rows=false | per_trade_rows=false | per_timeframe_rows=false";
   line += " | source_patched_live_unproven=true | compile_hash=not_claimed | fake_hash=false";
   return line;
  }

string ASC_FunctionResultsRun091AggregateProofTokens(const int top10_total,
                                                     const int top10_cursor,
                                                     const string top10_batch_status,
                                                     const int top10_verify_pass_count,
                                                     const int top10_verify_fail_count,
                                                     const int heartbeat_last_duration_ms,
                                                     const int heartbeat_budget_scan_ms,
                                                     const int heartbeat_budget_write_ms,
                                                     const int contradiction_count,
                                                     const string worst_contradiction_severity,
                                                     const string contradiction_scope,
                                                     const int proof_debt_count)
  {
   string line = "run091_functionresults_aggregate_proof=present";
   line += " | source_run_id=" + ASC_SourceRunId();
   line += " | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN;
   line += " | proof_boundary=source_patched_live_unproven_until_RUN095R";
   line += " | timer_queue_skip_risk_visible=true";
   line += " | heartbeat_work_must_be_bounded=true";
   line += " | heartbeat_last_duration_ms=" + IntegerToString(MathMax(0, heartbeat_last_duration_ms));
   line += " | heartbeat_budget_scan_ms=" + IntegerToString(MathMax(0, heartbeat_budget_scan_ms));
   line += " | heartbeat_budget_write_ms=" + IntegerToString(MathMax(0, heartbeat_budget_write_ms));
   line += " | top10_hydration_progress=" + IntegerToString(MathMax(0, top10_cursor)) + "/" + IntegerToString(MathMax(0, top10_total));
   line += " | top10_batch_status=" + (StringLen(top10_batch_status) > 0 ? top10_batch_status : "unobserved");
   line += " | top10_verify_pass_count=" + IntegerToString(MathMax(0, top10_verify_pass_count));
   line += " | top10_verify_fail_count=" + IntegerToString(MathMax(0, top10_verify_fail_count));
   line += " | contradiction_count=" + IntegerToString(MathMax(0, contradiction_count));
   line += " | worst_contradiction_severity=" + (StringLen(worst_contradiction_severity) > 0 ? worst_contradiction_severity : "none");
   line += " | contradiction_scope=" + (StringLen(contradiction_scope) > 0 ? contradiction_scope : "none");
   line += " | requires_operator_review=" + (contradiction_count > 0 ? "true" : "false");
   line += " | proof_debt_count=" + IntegerToString(MathMax(0, proof_debt_count));
   line += " | file_exists_is_currentness_proof=false";
   line += " | non_empty_file_is_truth_proof=false";
   line += " | retained_last_good_is_current=false";
   line += " | partial_child_is_complete=false";
   line += " | history_not_ready_is_no_signal=false";
   line += " | missing_tick_is_zero_truth=false";
   line += " | edge_truth_context_only=true";
   line += " | trade_signal=false | lot_sizing=false | sl_tp_change=false | execution_change=false";
   line += " | functionresults_schema_change=false | functionresults_rows_added=false | functionresults_high_cardinality=false";
   return line;
  }

string ASC_FunctionResultsRun092AggregateProofTokens(const int top10_total,
                                                     const int top10_cursor,
                                                     const string alignment_status,
                                                     const string board_signature,
                                                     const string derived_from_board_signature,
                                                     const int top10_verify_pass_count,
                                                     const int top10_verify_fail_count,
                                                     const int alignment_contradiction_count,
                                                     const string worst_alignment_contradiction,
                                                     const int proof_debt_count)
  {
   string line = "run092_functionresults_aggregate_proof=present";
   line += " | source_run_id=" + ASC_SourceRunId();
   line += " | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN;
   line += " | proof_boundary=source_patched_live_unproven_until_RUN095R";
   line += " | alignment_scope=market_board_globaltop10_dossier";
   line += " | top10_child_expected_count=" + IntegerToString(MathMax(0, top10_total));
   line += " | top10_child_cursor=" + IntegerToString(MathMax(0, top10_cursor));
   line += " | top10_verify_pass_count=" + IntegerToString(MathMax(0, top10_verify_pass_count));
   line += " | top10_verify_fail_count=" + IntegerToString(MathMax(0, top10_verify_fail_count));
   line += " | alignment_status=" + (StringLen(alignment_status) > 0 ? alignment_status : "unproven");
   line += " | board_signature=" + (StringLen(board_signature) > 0 ? board_signature : "unavailable");
   line += " | derived_from_board_signature=" + (StringLen(derived_from_board_signature) > 0 ? derived_from_board_signature : "unavailable");
   line += " | alignment_contradiction_count=" + IntegerToString(MathMax(0, alignment_contradiction_count));
   line += " | worst_alignment_contradiction=" + (StringLen(worst_alignment_contradiction) > 0 ? worst_alignment_contradiction : "none");
   line += " | requires_operator_review=" + (alignment_contradiction_count > 0 ? "true" : "false");
   line += " | proof_debt_count=" + IntegerToString(MathMax(0, proof_debt_count));
   line += " | board_top_symbol_missing_child_detectable=true | board_rank_child_rank_mismatch_detectable=true | board_symbol_child_symbol_mismatch_detectable=true";
   line += " | board_signature_child_signature_mismatch_detectable=true | child_currentness_weaker_than_board_detectable=true | child_partial_but_board_complete_detectable=true";
   line += " | dossier_symbol_mismatch_detectable=true | dossier_source_run_mismatch_detectable=true | dossier_section_incomplete_but_child_complete_detectable=true";
   line += " | deep_pending_but_board_implies_deep_complete_detectable=true | retained_child_marked_current_detectable=true | stale_dossier_marked_current_detectable=true";
   line += " | functionresults_schema_change=false | functionresults_rows_added=false | per_symbol_rows=false | trade_signal=false | execution_change=false | rank_order_formula_change=false";
   return line;
  }


string ASC_FunctionResultsRun093AggregateProofTokens(const string selected_symbol_state,
                                                     const string current_focus_mirror_status,
                                                     const string dossier_completeness_state,
                                                     const string deep_section_state,
                                                     const int mirror_contradiction_count,
                                                     const string worst_mirror_contradiction,
                                                     const int proof_debt_count)
  {
   string line = "run093_functionresults_aggregate_proof=present";
   line += " | source_run_id=" + ASC_SourceRunId();
   line += " | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN;
   line += " | proof_boundary=source_patched_live_unproven_until_RUN095R";
   line += " | mirror_scope=dossier_current_focus_selected_symbol_derivative";
   line += " | selected_symbol_state=" + (StringLen(selected_symbol_state) > 0 ? selected_symbol_state : "unobserved");
   line += " | current_focus_mirror_status=" + (StringLen(current_focus_mirror_status) > 0 ? current_focus_mirror_status : "unobserved");
   line += " | dossier_completeness_state=" + (StringLen(dossier_completeness_state) > 0 ? dossier_completeness_state : "runtime_unproven_until_RUN100R");
   line += " | deep_section_state=" + (StringLen(deep_section_state) > 0 ? deep_section_state : "runtime_unproven_until_RUN100R");
   line += " | mirror_contradiction_count=" + IntegerToString(MathMax(0, mirror_contradiction_count));
   line += " | worst_mirror_contradiction=" + (StringLen(worst_mirror_contradiction) > 0 ? worst_mirror_contradiction : "none");
   line += " | requires_operator_review=" + (mirror_contradiction_count > 0 ? "true" : "false");
   line += " | proof_debt_count=" + IntegerToString(MathMax(0, proof_debt_count));
   line += " | current_focus_truth_owner=false | current_focus_derivative_only=true | same_symbol_mirror_required=true | selected_symbol_none_not_failure=true";
   line += " | section_completeness_taxonomy=" + ASC_DOSSIER_SECTION_COMPLETENESS_TAXONOMY;
   line += " | mirror_state_taxonomy=" + ASC_CURRENT_FOCUS_MIRROR_STATE_TAXONOMY;
   line += " | file_exists_is_mirror_proof=false | non_empty_file_is_mirror_proof=false | retained_last_good_is_current=false | stale_is_current=false | partial_is_complete=false";
   line += " | functionresults_schema_change=false | functionresults_rows_added=false | per_symbol_rows=false | per_section_rows=false | trade_signal=false | execution_change=false | rank_order_formula_change=false";
   return line;
  }



string ASC_FunctionResultsRun093RoadmapReanchorProofTokens(const string warmup_state,
                                                        const string queue_state,
                                                        const int queue_remaining,
                                                        const int stalled_count,
                                                        const int hydration_rows,
                                                        const string next_run_decision)
  {
   string line = "run093_roadmap_reanchor_phase2a_proof=present";
   line += " | source_run_id=" + ASC_SourceRunId();
   line += " | roadmap_authority=TRUTH_SEEKER_ROADMAP.md";
   line += " | proof_boundary=roadmap_reanchored_phase2a_source_audited_live_unproven";
   line += " | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN;
   line += " | true_current_phase=Immediate_Repair_plus_Phase_2A";
   line += " | run091_run092_are_support_work=true";
   line += " | phase2a_complete=false";
   line += " | hydration_class_taxonomy=" + ASC_DOSSIER_HYDRATION_CLASS_TAXONOMY;
   line += " | three_kb_reason_taxonomy=" + ASC_DOSSIER_3KB_REASON_TAXONOMY;
   line += " | warmup_first_publish_taxonomy=" + ASC_WARMUP_FIRST_PUBLISH_STATE_TAXONOMY;
   line += " | queue_proof_taxonomy=" + ASC_DOSSIER_QUEUE_PROOF_TAXONOMY;
   line += " | warmup_state=" + (StringLen(warmup_state) > 0 ? warmup_state : "source_supported_runtime_unproven");
   line += " | dossier_queue_state=" + (StringLen(queue_state) > 0 ? queue_state : "idle");
   line += " | queue_remaining=" + IntegerToString(MathMax(0, queue_remaining));
   line += " | stalled_count=" + IntegerToString(MathMax(0, stalled_count));
   line += " | hydration_rows_observed=" + IntegerToString(MathMax(0, hydration_rows));
   line += " | run095_allowed_only_if_phase2a_source_ready=true";
   line += " | next_run_decision=" + (StringLen(next_run_decision) > 0 ? next_run_decision : "RUN094R_phase2a_queue_resume_patch_before_live");
   line += " | file_exists_is_hydration_proof=false | non_empty_file_is_completion_proof=false | closed_compact_is_not_failure=true | open_shell_can_be_incomplete=true | dependency_blocked_explicit=true";
   line += " | functionresults_schema_change=false | functionresults_rows_added=false | per_symbol_rows=false | trade_signal=false | execution_change=false | rank_order_formula_change=false";
   return line;
  }


string ASC_FunctionResultsRun094Phase2AProofTokens(const string warmup_state,
                                                   const string queue_state,
                                                   const int queue_remaining,
                                                   const int queue_completed,
                                                   const int queue_stalled,
                                                   const int backfill_pending,
                                                   const int dependency_blocked_count,
                                                   const int hydration_rows,
                                                   const int requires_operator_review)
  {
   string line = "run094_phase2a_source_patch_proof=present";
   line += " | source_run_id=" + ASC_SourceRunId();
   line += " | proof_boundary=" + ASC_RUN094_PHASE2A_PROOF_BOUNDARY;
   line += " | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN;
   line += " | hydration_class_taxonomy=" + ASC_DOSSIER_HYDRATION_CLASS_TAXONOMY;
   line += " | three_kb_reason_taxonomy=" + ASC_DOSSIER_3KB_REASON_TAXONOMY;
   line += " | queue_required_fields=" + ASC_RUN094_PHASE2A_REQUIRED_QUEUE_FIELDS;
   line += " | warmup_required_fields=" + ASC_RUN094_WARMUP_FIRST_PUBLISH_REQUIRED_FIELDS;
   line += " | warmup_state=" + (StringLen(warmup_state) > 0 ? warmup_state : "source_supported_runtime_unproven");
   line += " | dossier_queue_state=" + (StringLen(queue_state) > 0 ? queue_state : "idle");
   line += " | queue_remaining=" + IntegerToString(MathMax(0, queue_remaining));
   line += " | queue_completed=" + IntegerToString(MathMax(0, queue_completed));
   line += " | queue_stalled=" + IntegerToString(MathMax(0, queue_stalled));
   line += " | backfill_pending=" + IntegerToString(MathMax(0, backfill_pending));
   line += " | dependency_blocked_count=" + IntegerToString(MathMax(0, dependency_blocked_count));
   line += " | hydration_rows_observed=" + IntegerToString(MathMax(0, hydration_rows));
   line += " | requires_operator_review=" + IntegerToString(MathMax(0, requires_operator_review));
   line += " | one_bounded_aggregate_line=true | per_symbol_rows=false | per_section_rows=false | functionresults_spam=false";
   line += " | compile_claim=false | metaeditor_compile_output_provided=false | live_runtime_output_observed=true | output_claim=inspected_live_artifacts_only | run096_live_audit_complete=true | run097_phase2a_closeout_required=true | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN;
   line += " | run096_proof_boundary=" + ASC_TRUTH_SEEKER_RUN096R_PROOF_BOUNDARY;
   line += " | file_exists_is_hydration_proof=false | file_filled_is_hydration_proof=false | retained_last_good_is_current=false | degraded_first_publish_is_complete=false";
   line += " | new_dossier_system=false | new_publication_system=false | new_runtime_lane=false | rank_order_formula_change=false | l3_l4_score_change=false | strategy_execution_change=false";
   return line;
  }


string ASC_FunctionResultsRun124ClaimEvidenceAggregateProofTokens()
  {
   string line = "claim_evidence_enabled=true | claim_evidence_aggregate=true";
   line += " | claim_unavailable_count=aggregate_from_surface";
   line += " | claim_blocked_count=aggregate_from_surface";
   line += " | claim_pending_count=aggregate_from_surface";
   line += " | claim_stale_count=aggregate_from_surface";
   line += " | claim_unknown_count=aggregate_from_surface";
   line += " | claim_retained_count=aggregate_from_surface";
   line += " | claim_degraded_count=aggregate_from_surface";
   line += " | claim_top_blocker=surface_specific";
   line += " | claim_top_source_owner=surface_specific";
   line += " | claim_next_check=next_surface_publish_or_RUN125_live_proof";
   line += " | claim_actionability_block_count=aggregate_from_surface";
   line += " | claim_evidence_live_unproven_until_RUN125=true";
   line += " | claim_section_level_enabled=true";
   line += " | claim_dossier_section_count=5";
   line += " | claim_market_board_lookup_enabled=true";
   line += " | claim_trader_chat_packet_enabled=true";
   line += " | claim_family_dossier_availability_enabled=true";
   line += " | claim_evidence_per_symbol_rows=false";
   line += " | claim_evidence_section_spam_avoided=true";
   line += " | claim_evidence_schema_token_parity=verified_RUN124R";
   line += " | claim_evidence_token=functionresults_claim_evidence_RUN124R";
   line += " | aggregate_only=true | per_symbol_rows=false | proof_spam_avoided=true";
   return line;
  }


string ASC_FunctionResultsRun202FailureTaxonomyTokens()
  {
   string line = "run202_failure_taxonomy=active";
   line += " | severity_taxonomy=success,lawful_noop,lawful_deferred,warning,failure,blocker";
   line += " | first_failure_priority=compile_source_identity_mismatch,path_guard_failed,missing_required_token,final_write_failed,manifest_status_write_failed,blocking_staging_failed,blocking_archive_failed,no_membership_no_snapshot_no_open_symbols,closed_market_not_applicable_weekend,not_due_deferred,no_change_skipped,retained_last_good,none";
   line += " | lawful_inactive_not_write_failure=true";
   line += " | stale_first_failure_reason_forbidden=true";
   line += " | final_staging_archive_counts_separated=true";
   line += " | scanner_status_manifest_functionresults_must_reconcile=true";
   line += " | live_proof_required_RUN205R=true";
   line += " | trade_signal_permission=false";
   return line;
  }

void ASC_FunctionResultFinish(ASC_FunctionResult &result,
                              const ASC_FunctionResultState state,
                              const ASC_ResultCode code,
                              const string detail_message,
                              const string target_path = "")
  {
   result.finished_utc = TimeGMT();
   result.state = state;
   result.code = code;
   string identity_suffix = "functionresults_aggregate_identity=source_run_id=" + ASC_SourceRunId()
                            + " | source_identity_token=" + ASC_SourceIdentityToken()
                            + " | artifact_written_by_run=" + ASC_SourceRunId()
                            + " | artifact_schema_version=" + ASC_ArtifactSchemaVersion()
                            + " | build_identity_present=true";
   result.detail_message = detail_message;
   if(StringLen(result.detail_message) > 0)
      result.detail_message += " | ";
   result.detail_message += identity_suffix;
   result.detail_message += " | " + ASC_FunctionResultsRun124ClaimEvidenceAggregateProofTokens();
   result.detail_message += " | " + ASC_FunctionResultsRun202FailureTaxonomyTokens();
   result.target_path = target_path;
  }

string ASC_FunctionResultsRun097Phase2ACloseoutProofTokens(const string scanner_status_surface_state,
                                                           const string functionresults_surface_state,
                                                           const string manifest_identity_state,
                                                           const string current_focus_boundary_state,
                                                           const string three_kb_classification_state,
                                                           const string globaltop10_child_proof_state,
                                                           const int operator_review_count)
  {
   string line = "run097_phase2a_closeout_aggregate_proof=present";
   line += " | proof_boundary=" + ASC_TRUTH_SEEKER_RUN097R_PROOF_BOUNDARY;
   line += " | latest_live_evidence_boundary=RUN096R";
   line += " | compile_transcript_observed=false";
   line += " | runtime_boot_observed_from_prior_live=true";
   line += " | live_output_requested_this_run=false";
   line += " | scanner_status_surface_state=" + (StringLen(scanner_status_surface_state) > 0 ? scanner_status_surface_state : "requires_RUN100_file_locator_proof");
   line += " | functionresults_surface_state=" + (StringLen(functionresults_surface_state) > 0 ? functionresults_surface_state : "log_only_aggregate_until_standalone_file_proven");
   line += " | manifest_identity_state=" + (StringLen(manifest_identity_state) > 0 ? manifest_identity_state : "source_identity_required_in_manifest_summary");
   line += " | current_focus_boundary_state=" + (StringLen(current_focus_boundary_state) > 0 ? current_focus_boundary_state : "root_current_dossier_derivative_boundary");
   line += " | three_kb_classification_state=" + (StringLen(three_kb_classification_state) > 0 ? three_kb_classification_state : "file_size_diagnostic_only_reason_class_required");
   line += " | globaltop10_child_proof_state=" + (StringLen(globaltop10_child_proof_state) > 0 ? globaltop10_child_proof_state : "ten_child_header_signature_deep_state_required");
   line += " | operator_review_count=" + IntegerToString(MathMax(0, operator_review_count));
   line += " | phase2a_closed_with_bounded_carry_forward_debt=true";
   line += " | phase3a_logging_spine_allowed_next=true";
   line += " | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN;
   line += " | aggregate_only=true | per_symbol_rows=false | per_section_rows=false | functionresults_spam=false";
   line += " | no_fileio_hud_rank_formula_strategy_execution_change=true";
   return line;
  }

string ASC_FunctionResultsBoundedContradictionProofObservabilityTokens()
  {
   return "contradiction_proof_observability=aggregate_only"
          + " | functionresults_truth_owner=false"
          + " | functionresults_publication_blocker=false"
          + " | functionresults_schema_change=false"
          + " | functionresults_high_cardinality=false"
          + " | per_symbol_rows=false"
          + " | per_trade_rows=false"
          + " | per_closed_trade_rows=false"
          + " | per_timeframe_rows=false"
          + " | per_bar_rows=false"
          + " | per_tick_rows=false"
          + " | per_artifact_section_rows=false"
          + " | proof_debt_closed_by_log=false"
          + " | dossier_contradiction_surface_source_supported=true"
          + " | market_board_contradiction_surface_source_supported=true"
          + " | selected_symbol_dossier_boundary_source_supported=true"
          + " | selected_symbol_runtime_observed=false"
          + " | source_patched_live_unproven=true"
          + " | source_supported_runtime_observed_boundary=preserved"
          + " | source_patched_live_unproven_boundary=preserved"
          + " | pre_patch_live_proven_post_patch_unproven=preserved"
          + " | selected_symbol_runtime_unobserved=preserved"
          + " | scenario_absent_untested=preserved"
          + " | l3_meaning=candidate_ranking_support_only"
          + " | l4_meaning=shortlist_priority_ordering_only"
          + " | l5_meaning=deep_selected_symbol_analysis_only"
          + " | trade_permission=false"
          + " | entry_signal=false"
          + " | execution_permission=false"
          + " | final_trade_decision=false"
          + " | strategy_edge_proof=false"
          + " | active_exposure=open_positions_only"
          + " | future_exposure=pending_orders_only"
          + " | closed_history_context_only=true"
          + " | closed_history_not_active_exposure=true"
          + " | history_unavailable_not_zero=true"
          + " | globaltop10_current_vs_archive_confusion=advisory_only"
          + " | globaltop10_truth_owner_unchanged=true"
          + " | no_globaltop10_publication_change=true"
          + " | no_globaltop10_selection_change=true"
          + " | no_new_runtime_lane=true"
          + " | no_fileio_change=true"
          + " | no_flush_frequency_change=true"
          + " | no_dispatcher_lane_change=true"
          + " | no_hud_change=true";
  }

string ASC_FunctionResultsBoundedContradictionProofObservabilityLine()
  {
   return ASC_FUNCTION_RESULTS_BOUNDED_CONTRADICTION_PROOF_LINE_NAME + ": "
          + ASC_FunctionResultsBoundedContradictionProofObservabilityTokens()
          + " | aggregate_keys=" + ASC_FUNCTION_RESULTS_BOUNDED_CONTRADICTION_PROOF_KEYS
          + " | run074r_must_verify=" + ASC_FUNCTION_RESULTS_BOUNDED_CONTRADICTION_PROOF_RUN074R_CHECKS
          + " | proof_boundary=source_supported_aggregate_contract_only_actual_runtime_output_still_required";
  }



string ASC_FRRun098Phase3AProofTokens(const string active_roadmap_phase,
                                      const string phase2a_carry_forward_status,
                                      const string hydration_class_counts,
                                      const string three_kb_reason_counts,
                                      const string queue_state,
                                      const string backfill_state,
                                      const string stall_state,
                                      const string heartbeat_budget_state,
                                      const string manifest_identity_state,
                                      const string currentness_state,
                                      const string globaltop10_child_state,
                                      const string current_focus_mirror_state,
                                      const string market_board_alignment_state,
                                      const int contradiction_count,
                                      const string worst_contradiction_severity,
                                      const int proof_debt_count,
                                      const bool requires_operator_review)
  {
   string line = "run099_phase3a_logging_spine_aggregate_proof=present | run098_phase3a_logging_spine_aggregate_proof=present";
   line += " | source_run_id=" + ASC_SourceRunId();
   line += " | active_roadmap_phase=" + (StringLen(active_roadmap_phase) > 0 ? active_roadmap_phase : "Phase_3A_Logging_Spine");
   line += " | phase3a_logging_spine_status=" + ASC_PHASE3A_LOGGING_SPINE_STATUS;
   line += " | phase2a_carry_forward_status=" + (StringLen(phase2a_carry_forward_status) > 0 ? phase2a_carry_forward_status : "closed_with_bounded_carry_forward_debt_into_RUN100R");
   line += " | hydration_class_counts=" + (StringLen(hydration_class_counts) > 0 ? hydration_class_counts : "source_supported_runtime_unproven");
   line += " | three_kb_reason_counts=" + (StringLen(three_kb_reason_counts) > 0 ? three_kb_reason_counts : "source_supported_runtime_unproven");
   line += " | queue_state=" + (StringLen(queue_state) > 0 ? queue_state : "idle");
   line += " | backfill_state=" + (StringLen(backfill_state) > 0 ? backfill_state : "source_supported_runtime_unproven");
   line += " | stall_state=" + (StringLen(stall_state) > 0 ? stall_state : "source_supported_runtime_unproven");
   line += " | heartbeat_budget_state=" + (StringLen(heartbeat_budget_state) > 0 ? heartbeat_budget_state : "aggregate_only_live_unproven_until_RUN100R");
   line += " | manifest_identity_state=" + (StringLen(manifest_identity_state) > 0 ? manifest_identity_state : "source_identity_required");
   line += " | currentness_state=" + (StringLen(currentness_state) > 0 ? currentness_state : "file_exists_not_currentness_proof");
   line += " | globaltop10_child_state=" + (StringLen(globaltop10_child_state) > 0 ? globaltop10_child_state : "child_header_signature_deep_state_required");
   line += " | current_focus_mirror_state=" + (StringLen(current_focus_mirror_state) > 0 ? current_focus_mirror_state : "root_current_dossier_derivative_boundary");
   line += " | market_board_alignment_state=" + (StringLen(market_board_alignment_state) > 0 ? market_board_alignment_state : "alignment_summary_only_no_rank_change");
   line += " | contradiction_count=" + IntegerToString(MathMax(0, contradiction_count));
   line += " | worst_contradiction_severity=" + (StringLen(worst_contradiction_severity) > 0 ? worst_contradiction_severity : "none");
   line += " | contradiction_severity_taxonomy=" + ASC_PHASE3A_CONTRADICTION_SEVERITY_TAXONOMY;
   line += " | support_boundary_taxonomy=" + ASC_PHASE3A_SUPPORT_BOUNDARY_TAXONOMY;
   line += " | horizon_permission_state=not_evaluated_yet | regime_permission_state=not_evaluated_yet | session_permission_state=not_evaluated_yet | timing_quality_state=not_evaluated_yet";
   line += " | no_strategy_permission_claim=true | proof_debt_count=" + IntegerToString(MathMax(0, proof_debt_count));
   line += " | requires_operator_review=" + (requires_operator_review ? "true" : "false");
   line += " | no_trade_signal_boundary=true | no_execution_boundary=true";
   line += " | bounded_logging_contract=" + ASC_PHASE3A_BOUNDED_LOGGING_CONTRACT;
   line += " | functionresults_required_fields=" + ASC_PHASE3A_FUNCTIONRESULTS_REQUIRED_FIELDS;
   line += " | heartbeat_required_fields=" + ASC_PHASE3A_HEARTBEAT_REQUIRED_FIELDS;
   line += " | dossier_evidence_fields=" + ASC_PHASE3A_DOSSIER_EVIDENCE_FIELDS;
   line += " | no_spam_boundary=" + ASC_PHASE3A_NO_SPAM_BOUNDARY;
   line += " | aggregate_only=true | per_symbol_rows=false | per_timeframe_rows=false | per_section_rows=false | functionresults_spam=false";
   line += " | run100_grep_target=" + ASC_PHASE3A_FUNCTIONRESULTS_GREP_TARGET + " | compile_claim=false | live_claim=false | latest_live_evidence_boundary=" + ASC_SourceRunId() + " | next_live_checkpoint=" + ASC_TRUTH_SEEKER_NEXT_LIVE_PROOF_RUN;
   line += " | run100_capture_contract=" + ASC_PHASE3A_RUN100_CAPTURE_CONTRACT + " | fileio_change=false | hud_change=false | rank_order_formula_change=false | l3_score_change=false | l4_rank_change=false | market_board_order_change=false | strategy_execution_change=false";
   return line;
  }

#endif
