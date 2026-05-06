#ifndef __ASC_SYMBOL_DATA_PACK_CONTRACTS_MQH__
#define __ASC_SYMBOL_DATA_PACK_CONTRACTS_MQH__

#include "../../core/ASC_Version.mqh"

// RUN161R Symbol Data Pack Lite contract layer.
// Declarative only: no runtime calls, no publication, no ranking, no broker action.

#define ASC_SYMBOL_DATA_PACK_FAMILY "Symbol Data Pack Lite"
#define ASC_SYMBOL_DATA_PACK_FOLDER "Symbol Data Packs"
#define ASC_SYMBOL_DATA_PACK_FILE_SUFFIX "_SYMBOL_DATA_PACK.txt"
#define ASC_SYMBOL_DATA_PACK_REFRESH_CONTEXT_ONLY "context_only_no_full_universe_refresh"
#define ASC_SYMBOL_DATA_PACK_NO_DIRECTION "factual_numeric_only_no_direction"
#define ASC_SYMBOL_DATA_PACK_NO_SIGNAL "safety_boundary_no_signal_output"
#define ASC_SYMBOL_DATA_PACK_NUMERIC_FIRST "numeric_first_value_formula_threshold_timeframe_owner_freshness_sample_count"
#define ASC_SYMBOL_DATA_PACK_ONE_FILE_PER_SYMBOL "one_operator_file_per_symbol"
#define ASC_SYMBOL_DATA_PACK_WRITER_COMPOSES_ONLY "writer_composes_only_existing_owners_supply_truth"
#define ASC_SYMBOL_DATA_PACK_NO_TINY_FILE_SPRAWL "no_public_section_files_no_per_timeframe_files_no_per_indicator_files"
#define ASC_SYMBOL_DATA_PACK_NO_LAZY_UNAVAILABLE "route_pending_retry_last_good_or_hard_absence_required_before_absence_label"
#define ASC_SYMBOL_DATA_PACK_MAIN_SYSTEM_PARALLEL "parallel_to_main_system_no_dossier_market_board_rank_order_formula_mutation"
#define ASC_SYMBOL_DATA_PACK_NEXT_LIVE_RUN "RUN185R_COMPILE_LIVE_READINESS_CHECK"
#define ASC_SYMBOL_DATA_PACK_RUN161_SCOPE "parallel_router_composer_writer_skeleton_only"
#define ASC_SYMBOL_DATA_PACK_RUN162_SCOPE "atomic_one_file_publication_last_good_no_change_writer"
#define ASC_SYMBOL_DATA_PACK_SHADOW_MODE_DEFAULT false
#define ASC_SYMBOL_DATA_PACK_FULL_RUNTIME_ACTIVATION true
#define ASC_SYMBOL_DATA_PACK_PUBLICATION_RUN "RUN162R"
#define ASC_SYMBOL_DATA_PACK_L2_FILL_RUN "RUN163R"
#define ASC_SYMBOL_DATA_PACK_OHLC_FILL_RUN "RUN164R"
#define ASC_SYMBOL_DATA_PACK_VOLATILITY_FILL_RUN "RUN165R"
#define ASC_SYMBOL_DATA_PACK_VWAP_FILL_RUN "RUN166R"
#define ASC_SYMBOL_DATA_PACK_INDICATOR_FILL_RUN "RUN167R"
#define ASC_SYMBOL_DATA_PACK_HEALTH_FILL_RUN "RUN168R"
#define ASC_SYMBOL_DATA_PACK_CLOSEOUT_RUN "RUN169R"
#define ASC_SYMBOL_DATA_PACK_RUN170_CONTRACT_RUN "RUN169R"
#define ASC_SYMBOL_DATA_PACK_RUN171_ACTIVATION_RUN "RUN171R"
#define ASC_SYMBOL_DATA_PACK_RUN172_TRIPLE_CHECK_RUN "RUN172R"
#define ASC_SYMBOL_DATA_PACK_RUN173_LIVE_PROOF_RUN "RUN173R"
#define ASC_SYMBOL_DATA_PACK_BOUNDED_RUNTIME_MODE "bounded_selected_or_top_symbol_write"
#define ASC_SYMBOL_DATA_PACK_RUNTIME_BUDGET_RULE "one_symbol_due_only_no_full_universe_activation"


// Truth Seeker RUN189R: Symbol Data Pack family topology source-contract lock.
// Contract-only: no runtime path implementation, no FileIO rewrite, no rank/order/formula mutation.
#define ASC_SYMBOL_DATA_PACK_RUN189_TOPOLOGY_CONTRACT_RUN "RUN189R"
#define ASC_SYMBOL_DATA_PACK_TARGET_TOPOLOGY "mirror_Dossiers_GlobalTop10_and_Dossiers_Top5PerBucket"
#define ASC_SYMBOL_DATA_PACK_TARGET_GLOBAL_TOP10_FOLDER "GlobalTop10"
#define ASC_SYMBOL_DATA_PACK_TARGET_TOP5_PER_BUCKET_FOLDER "Top5PerBucket"
#define ASC_SYMBOL_DATA_PACK_TARGET_FAMILY_MANIFEST "_family_manifest.txt"
#define ASC_SYMBOL_DATA_PACK_TARGET_BUCKET_MANIFEST "_bucket_manifest.txt"
#define ASC_SYMBOL_DATA_PACK_FLAT_ROOT_TRANSITION_STATUS "deprecated_transition_observation_only_not_target_authority"
#define ASC_SYMBOL_DATA_PACK_DIRECT_ROOT_DOSSIER_SYMBOL_STATUS "suppress_symbol_root_spam_after_mirror_ready_keep_root_Dossier_txt_selected_surface_separate"
#define ASC_SYMBOL_DATA_PACK_LITE_CONTENT_BOUNDARY "dossier_like_lighter_L0_to_L5_no_L6_no_heavy_deep_only_sections"
#define ASC_SYMBOL_DATA_PACK_MIRROR_OWNER_RULE "mirror_existing_Dossier_GlobalTop10_and_Top5PerBucket_membership_without_rank_order_formula_change"
#define ASC_SYMBOL_DATA_PACK_RUN195_PROOF_TARGET "prove_mirrored_GlobalTop10_and_Top5PerBucket_SDP_files_recurring_publication_and_root_spam_suppression"

// Truth Seeker RUN190R: route-aware Symbol Data Pack mirror topology helpers.
// Source patch only: these route identifiers do not publish family children,
// do not compute membership, and do not mutate rank/order/formula authority.
#define ASC_SYMBOL_DATA_PACK_RUN190_ROUTE_HELPER_RUN "RUN190R"
#define ASC_SYMBOL_DATA_PACK_RUN190_SCOPE "route_aware_sdp_target_path_helpers_no_family_publication_yet"
#define ASC_SYMBOL_DATA_PACK_GLOBALTOP10_MIRROR_STATUS "run191_globaltop10_route_publication_source_patched_live_unproven"
#define ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_MIRROR_STATUS "run192_top5perbucket_route_publication_source_patched_live_unproven"
#define ASC_SYMBOL_DATA_PACK_LEGACY_FLAT_ROUTE_NAME "flat_root_transition"
#define ASC_SYMBOL_DATA_PACK_GLOBALTOP10_ROUTE_NAME "globaltop10_mirror"
#define ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_ROUTE_NAME "top5perbucket_mirror"


// Truth Seeker RUN191R: GlobalTop10 Symbol Data Pack mirror publication.
// Source patch only: consumes existing GlobalTop10 membership/order snapshot, writes route-aware SDP children,
// and does not rank, filter, reorder, rewrite FileIO, or claim runtime/live proof.
#define ASC_SYMBOL_DATA_PACK_RUN191_GLOBALTOP10_PUBLICATION_RUN "RUN191R"
#define ASC_SYMBOL_DATA_PACK_RUN191_SCOPE "globaltop10_sdp_mirror_publication_consumes_existing_globaltop10_snapshot_no_rank_order_formula_change"
#define ASC_SYMBOL_DATA_PACK_GLOBALTOP10_PUBLICATION_CALLSITE "ASC_ServiceSymbolDataPackGlobalTop10MirrorPublication"
#define ASC_SYMBOL_DATA_PACK_GLOBALTOP10_PUBLICATION_BUDGET_RULE "one_globaltop10_sdp_child_per_write_lane_when_due"


// Truth Seeker RUN192R: Top5PerBucket Symbol Data Pack mirror publication.
// Source patch only: consumes existing Top5PerBucket bucket queue membership/order, writes route/bucket-aware SDP children,
// and does not rank, filter, reorder, rewrite FileIO, or claim runtime/live proof.
#define ASC_SYMBOL_DATA_PACK_RUN192_TOP5PERBUCKET_PUBLICATION_RUN "RUN192R"
#define ASC_SYMBOL_DATA_PACK_RUN192_SCOPE "top5perbucket_sdp_mirror_publication_consumes_existing_top5_bucket_queue_no_rank_order_formula_change"
#define ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_PUBLICATION_CALLSITE "ASC_ServiceSymbolDataPackTop5PerBucketMirrorPublication"
#define ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_PUBLICATION_BUDGET_RULE "one_top5perbucket_sdp_child_per_write_lane_when_due"

enum ASC_SymbolDataPackFamilyRoute
  {
   ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION = 0,
   ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10 = 1,
   ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET = 2
  };

string ASC_SymbolDataPackFamilyRouteText(const ASC_SymbolDataPackFamilyRoute route)
  {
   switch(route)
     {
      case ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10:
         return string(ASC_SYMBOL_DATA_PACK_GLOBALTOP10_ROUTE_NAME);
      case ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET:
         return string(ASC_SYMBOL_DATA_PACK_TOP5PERBUCKET_ROUTE_NAME);
      case ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION:
      default:
         return string(ASC_SYMBOL_DATA_PACK_LEGACY_FLAT_ROUTE_NAME);
     }
  }

string ASC_SymbolDataPackSafeFileToken(const string symbol_raw)
  {
   string token = symbol_raw;
   StringTrimLeft(token);
   StringTrimRight(token);
   if(StringLen(token) <= 0)
      return "ROUTE_REQUIRES_SYMBOL";

   StringReplace(token, "\\", "_");
   StringReplace(token, "/", "_");
   StringReplace(token, ":", "_");
   StringReplace(token, "*", "_");
   StringReplace(token, "?", "_");
   StringReplace(token, "<", "_");
   StringReplace(token, ">", "_");
   StringReplace(token, "|", "_");
   return token;
  }

string ASC_SymbolDataPackSafeBucketToken(const string bucket_raw)
  {
   string token = bucket_raw;
   StringTrimLeft(token);
   StringTrimRight(token);
   if(StringLen(token) <= 0)
      return "ROUTE_REQUIRES_BUCKET";

   StringReplace(token, "\\", "_");
   StringReplace(token, "/", "_");
   StringReplace(token, ":", "_");
   StringReplace(token, "*", "_");
   StringReplace(token, "?", "_");
   StringReplace(token, "<", "_");
   StringReplace(token, ">", "_");
   StringReplace(token, "|", "_");
   return token;
  }

string ASC_SymbolDataPackExpectedOutputPathTextForRoute(const string server_root,
                                                        const string symbol,
                                                        const ASC_SymbolDataPackFamilyRoute route,
                                                        const string bucket,
                                                        const bool temp_path)
  {
   if(StringLen(server_root) <= 0)
      return "route_pending_server_root";

   string path = server_root + "\\" + string(ASC_SYMBOL_DATA_PACK_FOLDER);
   if(route == ASC_SDP_FAMILY_ROUTE_GLOBAL_TOP10)
      path += "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_GLOBAL_TOP10_FOLDER);
   else if(route == ASC_SDP_FAMILY_ROUTE_TOP5_PER_BUCKET)
     {
      string safe_bucket = ASC_SymbolDataPackSafeBucketToken(bucket);
      if(safe_bucket == "ROUTE_REQUIRES_BUCKET")
         return "route_pending_bucket";
      path += "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_TOP5_PER_BUCKET_FOLDER) + "\\" + safe_bucket;
     }

   path += "\\" + ASC_SymbolDataPackSafeFileToken(symbol) + string(ASC_SYMBOL_DATA_PACK_FILE_SUFFIX);
   if(temp_path)
      path += ".tmp";
   return path;
  }

string ASC_SymbolDataPackExpectedOutputPathText(const string server_root,const string symbol,const bool temp_path)
  {
   return ASC_SymbolDataPackExpectedOutputPathTextForRoute(server_root,
                                                           symbol,
                                                           ASC_SDP_FAMILY_ROUTE_FLAT_TRANSITION,
                                                           "",
                                                           temp_path);
  }

string ASC_SymbolDataPackExpectedTop5PerBucketOutputPatternText(const string server_root,const string symbol,const bool temp_path)
  {
   if(StringLen(server_root) <= 0)
      return "route_pending_server_root";

   string bucket_placeholder = "<bucket>";
   string path = server_root + "\\" + string(ASC_SYMBOL_DATA_PACK_FOLDER)
                 + "\\" + string(ASC_SYMBOL_DATA_PACK_TARGET_TOP5_PER_BUCKET_FOLDER)
                 + "\\" + bucket_placeholder + "\\" + ASC_SymbolDataPackSafeFileToken(symbol)
                 + string(ASC_SYMBOL_DATA_PACK_FILE_SUFFIX);
   if(temp_path)
      path += ".tmp";
   return path;
  }

#define ASC_SYMBOL_DATA_PACK_SECTION_PUBLICATION "Publication / Atomic Status"
#define ASC_SYMBOL_DATA_PACK_SECTION_IDENTITY "Symbol Identity"
#define ASC_SYMBOL_DATA_PACK_SECTION_L4_CONTEXT "L4 Membership Context"
#define ASC_SYMBOL_DATA_PACK_SECTION_MARKET_STATE "Market State / Session Facts"
#define ASC_SYMBOL_DATA_PACK_SECTION_QUOTE "Quote / Tick Snapshot"
#define ASC_SYMBOL_DATA_PACK_SECTION_TICK "Tick Activity Statistics"
#define ASC_SYMBOL_DATA_PACK_SECTION_SPREAD "Spread / Friction Numbers"
#define ASC_SYMBOL_DATA_PACK_SECTION_RECENT_CANDLES "Recent Closed Candle Sequences"
#define ASC_SYMBOL_DATA_PACK_SECTION_MULTI_TF "Multi-Timeframe OHLC Summary"
#define ASC_SYMBOL_DATA_PACK_SECTION_DWM "Daily / Weekly / Monthly High-Low Facts"
#define ASC_SYMBOL_DATA_PACK_SECTION_SWING_RANGE "Swing / Range / Pullback Numeric Facts"
#define ASC_SYMBOL_DATA_PACK_SECTION_ATR "ATR / Volatility Facts"
#define ASC_SYMBOL_DATA_PACK_SECTION_VWAP "VWAP / Anchored VWAP Facts"
#define ASC_SYMBOL_DATA_PACK_SECTION_INDICATORS "Numeric Indicator Facts"
#define ASC_SYMBOL_DATA_PACK_SECTION_HEALTH "Freshness / Retry / Hydration / Health"
#define ASC_SYMBOL_DATA_PACK_SECTION_RUN170_CONTRACT "RUN170 Live Proof Contract"
#define ASC_SYMBOL_DATA_PACK_SECTION_OWNER_TRACE "Owner Trace"
#define ASC_SYMBOL_DATA_PACK_SECTION_SAFETY "Safety Boundary"

enum ASC_SymbolDataPackRouteState
  {
   ASC_SDP_ROUTE_READY = 0,
   ASC_SDP_ROUTE_PENDING_OWNER = 1,
   ASC_SDP_ROUTE_PLANNED_RUN = 2,
   ASC_SDP_ROUTE_REQUIRES_EXISTING_OWNER = 3,
   ASC_SDP_ROUTE_NOT_IMPLEMENTED_YET = 4,
   ASC_SDP_HYDRATION_REQUIRED = 5,
   ASC_SDP_RETRY_REQUIRED = 6,
   ASC_SDP_LAST_GOOD_REQUIRED = 7
  };

string ASC_SymbolDataPackRouteStateText(const ASC_SymbolDataPackRouteState state)
  {
   switch(state)
     {
      case ASC_SDP_ROUTE_READY:
         return "route_ready";
      case ASC_SDP_ROUTE_PENDING_OWNER:
         return "route_pending_owner";
      case ASC_SDP_ROUTE_PLANNED_RUN:
         return "route_planned_run";
      case ASC_SDP_ROUTE_REQUIRES_EXISTING_OWNER:
         return "route_requires_existing_owner";
      case ASC_SDP_ROUTE_NOT_IMPLEMENTED_YET:
         return "route_not_implemented_yet";
      case ASC_SDP_HYDRATION_REQUIRED:
         return "hydration_required";
      case ASC_SDP_RETRY_REQUIRED:
         return "retry_required";
      case ASC_SDP_LAST_GOOD_REQUIRED:
         return "last_good_required";
     }
   return "route_planned_run";
  }

string ASC_SymbolDataPackBoolText(const bool value)
  {
   return (value ? "true" : "false");
  }

string ASC_SymbolDataPackContractSummaryLine()
  {
   return "family=" + string(ASC_SYMBOL_DATA_PACK_FAMILY)
          + " | file_rule=" + string(ASC_SYMBOL_DATA_PACK_ONE_FILE_PER_SYMBOL)
          + " | numeric_rule=" + string(ASC_SYMBOL_DATA_PACK_NUMERIC_FIRST)
          + " | direction_rule=" + string(ASC_SYMBOL_DATA_PACK_NO_DIRECTION)
          + " | writer_rule=" + string(ASC_SYMBOL_DATA_PACK_WRITER_COMPOSES_ONLY)
          + " | next_live=" + string(ASC_SYMBOL_DATA_PACK_NEXT_LIVE_RUN);
  }


// RUN162R researched history-depth and tick/spread window contract.
// Declarative only: RUN162R does not copy OHLC, calculate ATR, calculate VWAP, create indicators, or publish live facts.
#define ASC_SDP_LTF_BARS_DEFAULT 500
#define ASC_SDP_LTF_BARS_MIN 350
#define ASC_SDP_LTF_BARS_RESEARCH_CANDIDATE 720
#define ASC_SDP_MTF_BARS_DEFAULT 250
#define ASC_SDP_D1_BARS_DEFAULT 50
#define ASC_SDP_W1_BARS_DEFAULT 50
#define ASC_SDP_MN1_BARS_DEFAULT 24
#define ASC_SDP_MN1_BARS_EXPANSION_CANDIDATE 50

#define ASC_SDP_TICK_WINDOW_PRIMARY_SECONDS 300
#define ASC_SDP_SPREAD_WINDOW_PRIMARY_SECONDS 300
#define ASC_SDP_TICK_WINDOW_IMMEDIATE_SECONDS 60
#define ASC_SDP_SPREAD_WINDOW_IMMEDIATE_SECONDS 60
#define ASC_SDP_QUOTE_REFRESH_TARGET_SECONDS 10
#define ASC_SDP_TICK_REFRESH_TARGET_SECONDS 10
#define ASC_SDP_SPREAD_REFRESH_TARGET_SECONDS 10

#define ASC_SDP_SECTION_CADENCE_PUBLICATION_SECONDS 10
#define ASC_SDP_SECTION_CADENCE_IDENTITY_SECONDS 3600
#define ASC_SDP_SECTION_CADENCE_L4_CONTEXT_SECONDS 1200
#define ASC_SDP_SECTION_CADENCE_MARKET_STATE_SECONDS 10
#define ASC_SDP_SECTION_CADENCE_QUOTE_SECONDS 10
#define ASC_SDP_SECTION_CADENCE_SPREAD_SECONDS 10
#define ASC_SDP_SECTION_CADENCE_TICK_SECONDS 10
#define ASC_SDP_SECTION_CADENCE_M1_SECONDS 60
#define ASC_SDP_SECTION_CADENCE_M5_SECONDS 300
#define ASC_SDP_SECTION_CADENCE_M15_SECONDS 900
#define ASC_SDP_SECTION_CADENCE_M30_SECONDS 1800
#define ASC_SDP_SECTION_CADENCE_H1_SECONDS 3600
#define ASC_SDP_SECTION_CADENCE_H4_SECONDS 14400
#define ASC_SDP_SECTION_CADENCE_D1_SECONDS 86400
#define ASC_SDP_SECTION_CADENCE_W1_SECONDS 604800
#define ASC_SDP_SECTION_CADENCE_MN1_SECONDS 2592000
#define ASC_SDP_SECTION_CADENCE_HEALTH_SECONDS 10
#define ASC_SDP_FULL_PACK_PROOF_HEARTBEAT_SECONDS 300

#define ASC_SDP_RECALC_RULE_DUE_ONLY "section_recalculates_only_when_due_or_source_timeframe_closes"
#define ASC_SDP_RECALC_RULE_H1_ATR "h1_atr_last_closed_recalculates_only_after_new_h1_bar_preview_must_be_labelled"
#define ASC_SDP_RECALC_RULE_FULL_PACK "full_pack_recomposed_atomically_after_changed_section_or_proof_heartbeat"
#define ASC_SDP_PUBLICATION_STATUS_SHADOW "shadow_mode_no_runtime_write"
#define ASC_SDP_PUBLICATION_STATUS_READY "atomic_writer_foundation_ready_disabled_by_default"
#define ASC_SDP_LAST_GOOD_CONTRACT "retained_final_file_is_last_good_continuity_baseline_no_extra_operator_file"
#define ASC_SDP_NO_CHANGE_CONTRACT "existing_payload_material_compare_before_write"

struct ASC_SymbolDataPackSectionRefreshContract
  {
   string section_name;
   int section_target_cadence_seconds;
   datetime section_last_refresh_utc;
   datetime section_next_due_utc;
   string section_source_owner;
   string section_status;
   string section_retry_state;
   int section_last_good_age_seconds;
   bool section_content_changed;
   bool section_recalculation_due;
   bool section_publish_included_in_full_pack;
   string future_run;
  };

string ASC_SymbolDataPackCadenceText(const int seconds)
  {
   if(seconds <= 0)
      return "cadence_not_started";
   return IntegerToString(seconds) + "s";
  }

string ASC_SymbolDataPackUtcText(const datetime value)
  {
   if(value <= 0)
      return "timestamp_pending_hydration";
   return TimeToString(value, TIME_DATE | TIME_SECONDS) + " UTC";
  }

void ASC_SymbolDataPackSetSectionRefreshContract(ASC_SymbolDataPackSectionRefreshContract &contract,
                                                  const string section_name,
                                                  const int cadence_seconds,
                                                  const string source_owner,
                                                  const string status,
                                                  const string retry_state,
                                                  const string future_run)
  {
   contract.section_name = section_name;
   contract.section_target_cadence_seconds = cadence_seconds;
   contract.section_last_refresh_utc = 0;
   contract.section_next_due_utc = 0;
   contract.section_source_owner = source_owner;
   contract.section_status = status;
   contract.section_retry_state = retry_state;
   contract.section_last_good_age_seconds = -1;
   contract.section_content_changed = false;
   contract.section_recalculation_due = false;
   contract.section_publish_included_in_full_pack = false;
   contract.future_run = future_run;
  }

string ASC_SymbolDataPackSectionRefreshLine(const ASC_SymbolDataPackSectionRefreshContract &contract)
  {
   return "| " + contract.section_name
          + " | " + ASC_SymbolDataPackCadenceText(contract.section_target_cadence_seconds)
          + " | " + ASC_SymbolDataPackUtcText(contract.section_last_refresh_utc)
          + " | " + ASC_SymbolDataPackUtcText(contract.section_next_due_utc)
          + " | " + contract.section_source_owner
          + " | " + contract.section_status
          + " | " + contract.section_retry_state
          + " | " + (contract.section_last_good_age_seconds >= 0 ? IntegerToString(contract.section_last_good_age_seconds) + "s" : "last_good_age_pending_hydration")
          + " | " + ASC_SymbolDataPackBoolText(contract.section_content_changed)
          + " | " + ASC_SymbolDataPackBoolText(contract.section_recalculation_due)
          + " | " + ASC_SymbolDataPackBoolText(contract.section_publish_included_in_full_pack)
          + " | " + contract.future_run
          + " |\n";
  }


// RUN163R quote/tick/spread factual fill contract.
// Dormant/read-only composition only: no broker action, no dispatcher activation, no rank/order/formula mutation.
#define ASC_SDP_QUOTE_HYDRATION_READY "l2_state_ready"
#define ASC_SDP_QUOTE_HYDRATION_COLLECTING "l2_state_collecting"
#define ASC_SDP_QUOTE_HYDRATION_RETRYING "l2_state_retrying"
#define ASC_SDP_QUOTE_HYDRATION_LAST_GOOD "l2_state_last_good"
#define ASC_SDP_QUOTE_HYDRATION_MARKET_CLOSED "l2_state_market_closed"
#define ASC_SDP_QUOTE_HYDRATION_SYMBOL_NOT_SELECTED "l2_state_symbol_not_selected"
#define ASC_SDP_QUOTE_HYDRATION_SYMBOL_NOT_SYNCHRONIZED "l2_state_symbol_not_synchronized"
#define ASC_SDP_QUOTE_HYDRATION_TICK_FAILED "l2_state_symbol_info_tick_failed"
#define ASC_SDP_QUOTE_HYDRATION_TICK_STALE "l2_state_tick_stale"
#define ASC_SDP_QUOTE_HYDRATION_BROKER_NOT_SUPPLYING "l2_state_broker_not_supplying"
#define ASC_SDP_QUOTE_HYDRATION_HARD_ABSENCE "l2_state_hard_absence_proven"
#define ASC_SDP_LAST_GOOD_PENDING "last_good_pending_no_prior_verified_quote_in_this_compose"
#define ASC_SDP_RETRY_DUE_NOW "retry_due_now"
#define ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET "retry_due_on_next_10s_target"
#define ASC_SDP_NO_SAMPLE_TEXT "no_sample"
#define ASC_SDP_WINDOW_VALID_TRUE "true"
#define ASC_SDP_WINDOW_VALID_FALSE "false"
#define ASC_SDP_INVALID_REASON_NONE "none"
#define ASC_SDP_COPY_TICKS_REQUEST_LIMIT 2000

struct ASC_SymbolDataPackQuoteSnapshot
  {
   string symbol;
   int quote_refresh_target_seconds;
   datetime quote_last_refresh_utc;
   int quote_age_seconds;
   bool symbol_info_tick_success;
   int symbol_info_tick_error_code;
   double bid;
   double ask;
   double last;
   bool last_price_available;
   string last_price_status;
   double last_price_raw;
   double spread_points;
   double spread_price;
   double spread_percent;
   datetime tick_time;
   int tick_age_seconds;
   bool market_watch_selected_state;
   bool symbol_synchronized_state;
   string quote_hydration_state;
   int quote_retry_attempts;
   string quote_retry_due;
   double quote_last_good_bid;
   double quote_last_good_ask;
   datetime quote_last_good_time;
   int quote_last_good_age_seconds;
   string hard_absence_reason;
   string absence_state;
   string absence_reason;
  };

struct ASC_SymbolDataPackTickSpreadStats
  {
   int tick_refresh_target_seconds;
   int tick_window_immediate_seconds;
   int tick_window_primary_seconds;
   int ticks_last_60s;
   int ticks_last_300s;
   int bid_change_count_60s;
   int bid_change_count_300s;
   int ask_change_count_60s;
   int ask_change_count_300s;
   int max_tick_gap_seconds_60s;
   int max_tick_gap_seconds_300s;
   double avg_tick_gap_seconds_60s;
   double avg_tick_gap_seconds_300s;
   int tick_sample_count_60s;
   int tick_sample_count_300s;
   bool tick_window_60s_valid;
   bool tick_window_300s_valid;
   string tick_window_60s_invalid_reason;
   string tick_window_300s_invalid_reason;
   string tick_stats_hydration_state;
   string tick_stats_collecting_until_full_window;
   string tick_stats_retry_due;
   int last_good_tick_stats_age_seconds;
   datetime tick_stats_snapshot_utc;
   int spread_refresh_target_seconds;
   int spread_window_immediate_seconds;
   int spread_window_primary_seconds;
   double spread_current_points;
   double spread_current_price;
   double spread_current_percent;
   double spread_min_points_60s;
   double spread_max_points_60s;
   double spread_avg_points_60s;
   double spread_min_points_300s;
   double spread_max_points_300s;
   double spread_avg_points_300s;
   int spread_sample_count_60s;
   int spread_sample_count_300s;
   bool spread_window_60s_valid;
   bool spread_window_300s_valid;
   string spread_window_60s_invalid_reason;
   string spread_window_300s_invalid_reason;
   double spread_widening_vs_300s_avg_percent;
   string spread_stats_hydration_state;
   string spread_stats_collecting_until_full_window;
   string spread_stats_retry_due;
   int last_good_spread_stats_age_seconds;
   datetime spread_stats_snapshot_utc;
   int copy_ticks_requested_limit;
   int copy_ticks_return_count;
   bool copy_ticks_cap_hit;
   string copy_ticks_truncation_state;
   int copy_ticks_error_code;
  };

int ASC_SymbolDataPackAgeSeconds(const datetime now_utc,const datetime value)
  {
   if(now_utc <= 0 || value <= 0) return -1;
   int age = (int)(now_utc - value);
   return (age < 0 ? 0 : age);
  }

double ASC_SymbolDataPackSafePercent(const double numerator,const double denominator)
  {
   if(denominator == 0.0) return 0.0;
   return (numerator / denominator) * 100.0;
  }

string ASC_SymbolDataPackDoubleText(const double value)
  {
   return DoubleToString(value, 10);
  }

string ASC_SymbolDataPackSampledDoubleText(const double value,const int sample_count)
  {
   if(sample_count <= 0) return string(ASC_SDP_NO_SAMPLE_TEXT);
   return ASC_SymbolDataPackDoubleText(value);
  }

string ASC_SymbolDataPackIntText(const int value)
  {
   if(value < 0) return "pending";
   return IntegerToString(value);
  }

void ASC_SymbolDataPackInitQuoteSnapshot(ASC_SymbolDataPackQuoteSnapshot &q,const string symbol)
  {
   q.symbol = symbol;
   q.quote_refresh_target_seconds = ASC_SDP_QUOTE_REFRESH_TARGET_SECONDS;
   q.quote_last_refresh_utc = 0;
   q.quote_age_seconds = -1;
   q.symbol_info_tick_success = false;
   q.symbol_info_tick_error_code = 0;
   q.bid = 0.0; q.ask = 0.0; q.last = 0.0;
   q.last_price_available = false;
   q.last_price_status = "tick_not_read_yet";
   q.last_price_raw = 0.0;
   q.spread_points = 0.0; q.spread_price = 0.0; q.spread_percent = 0.0;
   q.tick_time = 0; q.tick_age_seconds = -1;
   q.market_watch_selected_state = false;
   q.symbol_synchronized_state = false;
   q.quote_hydration_state = ASC_SDP_QUOTE_HYDRATION_COLLECTING;
   q.quote_retry_attempts = 0;
   q.quote_retry_due = ASC_SDP_RETRY_DUE_NOW;
   q.quote_last_good_bid = 0.0; q.quote_last_good_ask = 0.0; q.quote_last_good_time = 0;
   q.quote_last_good_age_seconds = -1;
   q.hard_absence_reason = "hard_absence_not_proven";
   q.absence_state = "absence_not_proven";
   q.absence_reason = "hard_absence_not_proven";
  }

bool ASC_SymbolDataPackReadQuoteSnapshot(const string symbol,ASC_SymbolDataPackQuoteSnapshot &q)
  {
   ASC_SymbolDataPackInitQuoteSnapshot(q, symbol);
   datetime now_utc = TimeCurrent();
   q.quote_last_refresh_utc = now_utc;
   q.quote_age_seconds = 0;

   long selected = 0;
   ResetLastError();
   bool selected_read = SymbolInfoInteger(symbol, SYMBOL_SELECT, selected);
   q.market_watch_selected_state = (selected_read && selected > 0);
   q.symbol_synchronized_state = SymbolIsSynchronized(symbol);

   MqlTick tick;
   ZeroMemory(tick);
   ResetLastError();
   q.symbol_info_tick_success = SymbolInfoTick(symbol, tick);
   q.symbol_info_tick_error_code = (q.symbol_info_tick_success ? 0 : GetLastError());

   if(q.symbol_info_tick_success)
     {
      q.bid = tick.bid; q.ask = tick.ask; q.last = tick.last; q.last_price_raw = tick.last; q.tick_time = tick.time;
      q.last_price_available = (tick.last > 0.0);
      q.last_price_status = (q.last_price_available ? "available" : "broker_not_supplying_last_price_zero_raw_retained");
      q.tick_age_seconds = ASC_SymbolDataPackAgeSeconds(now_utc, tick.time);
      double point = 0.0;
      SymbolInfoDouble(symbol, SYMBOL_POINT, point);
      q.spread_price = ((q.ask > 0.0 && q.bid > 0.0) ? (q.ask - q.bid) : 0.0);
      q.spread_points = (point > 0.0 ? q.spread_price / point : 0.0);
      q.spread_percent = ASC_SymbolDataPackSafePercent(q.spread_price, q.bid);
      if(q.bid > 0.0 && q.ask > 0.0)
        {
         q.quote_last_good_bid = q.bid; q.quote_last_good_ask = q.ask; q.quote_last_good_time = tick.time;
         q.quote_last_good_age_seconds = q.tick_age_seconds;
        }
     }

   if(!q.market_watch_selected_state)
     { q.quote_hydration_state = ASC_SDP_QUOTE_HYDRATION_SYMBOL_NOT_SELECTED; q.quote_retry_attempts = 1; q.quote_retry_due = ASC_SDP_RETRY_DUE_NOW; q.hard_absence_reason = "market_watch_selection_not_confirmed_no_hard_absence"; q.absence_state = "not_absent_retry_required"; q.absence_reason = q.hard_absence_reason; return false; }
   if(!q.symbol_synchronized_state)
     { q.quote_hydration_state = ASC_SDP_QUOTE_HYDRATION_SYMBOL_NOT_SYNCHRONIZED; q.quote_retry_attempts = 1; q.quote_retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET; q.hard_absence_reason = "symbol_sync_not_confirmed_no_hard_absence"; q.absence_state = "not_absent_retry_required"; q.absence_reason = q.hard_absence_reason; return false; }
   if(!q.symbol_info_tick_success)
     { q.quote_hydration_state = ASC_SDP_QUOTE_HYDRATION_TICK_FAILED; q.quote_retry_attempts = 1; q.quote_retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET; q.hard_absence_reason = "symbol_info_tick_failed_no_hard_absence"; q.absence_state = "not_absent_retry_required"; q.absence_reason = q.hard_absence_reason; q.last_price_status = "symbol_info_tick_failed_last_price_unavailable"; return false; }
   if(q.bid <= 0.0 || q.ask <= 0.0)
     { q.quote_hydration_state = ASC_SDP_QUOTE_HYDRATION_BROKER_NOT_SUPPLYING; q.quote_retry_attempts = 1; q.quote_retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET; q.hard_absence_reason = "bid_or_ask_zero_after_success_retry_before_hard_absence"; q.absence_state = "broker_not_supplying_bid_or_ask_retry_required"; q.absence_reason = q.hard_absence_reason; return false; }
   if(q.tick_age_seconds > ASC_SDP_QUOTE_REFRESH_TARGET_SECONDS)
     { q.quote_hydration_state = ASC_SDP_QUOTE_HYDRATION_TICK_STALE; q.quote_retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET; q.hard_absence_reason = "tick_stale_but_last_good_available"; q.absence_state = "not_absent_stale_last_good_available"; q.absence_reason = q.hard_absence_reason; return true; }

   q.quote_hydration_state = ASC_SDP_QUOTE_HYDRATION_READY;
   q.quote_retry_due = "retry_not_due";
   q.hard_absence_reason = "hard_absence_not_proven_quote_ready";
   q.absence_state = "absence_not_proven_quote_ready";
   q.absence_reason = q.hard_absence_reason;
   return true;
  }

void ASC_SymbolDataPackInitTickSpreadStats(ASC_SymbolDataPackTickSpreadStats &s)
  {
   s.tick_refresh_target_seconds = ASC_SDP_TICK_REFRESH_TARGET_SECONDS;
   s.tick_window_immediate_seconds = ASC_SDP_TICK_WINDOW_IMMEDIATE_SECONDS;
   s.tick_window_primary_seconds = ASC_SDP_TICK_WINDOW_PRIMARY_SECONDS;
   s.ticks_last_60s = 0; s.ticks_last_300s = 0;
   s.bid_change_count_60s = 0; s.bid_change_count_300s = 0;
   s.ask_change_count_60s = 0; s.ask_change_count_300s = 0;
   s.max_tick_gap_seconds_60s = -1; s.max_tick_gap_seconds_300s = -1;
   s.avg_tick_gap_seconds_60s = 0.0; s.avg_tick_gap_seconds_300s = 0.0;
   s.tick_sample_count_60s = 0; s.tick_sample_count_300s = 0;
   s.tick_window_60s_valid = false; s.tick_window_300s_valid = false;
   s.tick_window_60s_invalid_reason = string(ASC_SDP_NO_SAMPLE_TEXT);
   s.tick_window_300s_invalid_reason = string(ASC_SDP_NO_SAMPLE_TEXT);
   s.tick_stats_hydration_state = ASC_SDP_QUOTE_HYDRATION_COLLECTING;
   s.tick_stats_collecting_until_full_window = "collecting_until_300s_window_has_samples";
   s.tick_stats_retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET;
   s.last_good_tick_stats_age_seconds = -1;
   s.tick_stats_snapshot_utc = 0;
   s.spread_refresh_target_seconds = ASC_SDP_SPREAD_REFRESH_TARGET_SECONDS;
   s.spread_window_immediate_seconds = ASC_SDP_SPREAD_WINDOW_IMMEDIATE_SECONDS;
   s.spread_window_primary_seconds = ASC_SDP_SPREAD_WINDOW_PRIMARY_SECONDS;
   s.spread_current_points = 0.0; s.spread_current_price = 0.0; s.spread_current_percent = 0.0;
   s.spread_min_points_60s = 0.0; s.spread_max_points_60s = 0.0; s.spread_avg_points_60s = 0.0;
   s.spread_min_points_300s = 0.0; s.spread_max_points_300s = 0.0; s.spread_avg_points_300s = 0.0;
   s.spread_sample_count_60s = 0; s.spread_sample_count_300s = 0;
   s.spread_window_60s_valid = false; s.spread_window_300s_valid = false;
   s.spread_window_60s_invalid_reason = string(ASC_SDP_NO_SAMPLE_TEXT);
   s.spread_window_300s_invalid_reason = string(ASC_SDP_NO_SAMPLE_TEXT);
   s.spread_widening_vs_300s_avg_percent = 0.0;
   s.spread_stats_hydration_state = ASC_SDP_QUOTE_HYDRATION_COLLECTING;
   s.spread_stats_collecting_until_full_window = "collecting_until_300s_window_has_samples";
   s.spread_stats_retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET;
   s.last_good_spread_stats_age_seconds = -1;
   s.spread_stats_snapshot_utc = 0;
   s.copy_ticks_requested_limit = ASC_SDP_COPY_TICKS_REQUEST_LIMIT;
   s.copy_ticks_return_count = 0;
   s.copy_ticks_cap_hit = false;
   s.copy_ticks_truncation_state = "copy_ticks_not_called_yet";
   s.copy_ticks_error_code = 0;
  }

bool ASC_SymbolDataPackReadTickSpreadStats(const string symbol,ASC_SymbolDataPackTickSpreadStats &s)
  {
   ASC_SymbolDataPackInitTickSpreadStats(s);
   datetime now_utc = TimeCurrent();
   MqlTick ticks[];
   ulong from_msc = (ulong)((long)(now_utc - ASC_SDP_TICK_WINDOW_PRIMARY_SECONDS)) * 1000;
   ResetLastError();
   int copied = CopyTicks(symbol, ticks, COPY_TICKS_INFO, from_msc, ASC_SDP_COPY_TICKS_REQUEST_LIMIT);
   s.copy_ticks_return_count = copied;
   s.copy_ticks_error_code = (copied < 0 ? GetLastError() : 0);
   s.copy_ticks_cap_hit = (copied >= ASC_SDP_COPY_TICKS_REQUEST_LIMIT);
   s.copy_ticks_truncation_state = (s.copy_ticks_cap_hit ? "cap_hit_possible_truncated_to_request_limit" : "not_cap_hit");
   if(copied <= 0)
     { s.tick_stats_hydration_state = ASC_SDP_QUOTE_HYDRATION_RETRYING; s.spread_stats_hydration_state = ASC_SDP_QUOTE_HYDRATION_RETRYING; s.copy_ticks_truncation_state = "no_ticks_returned_no_sample"; return false; }

   double point = 0.0;
   SymbolInfoDouble(symbol, SYMBOL_POINT, point);
   double spread_sum_60 = 0.0, spread_sum_300 = 0.0;
   int gap_sum_60 = 0, gap_count_60 = 0, gap_sum_300 = 0, gap_count_300 = 0;
   datetime prev_60 = 0, prev_300 = 0;
   bool spread_init_60 = false, spread_init_300 = false;

   for(int i = 0; i < copied; i++)
     {
      int age = ASC_SymbolDataPackAgeSeconds(now_utc, ticks[i].time);
      if(age < 0 || age > ASC_SDP_TICK_WINDOW_PRIMARY_SECONDS) continue;
      bool in_60 = (age <= ASC_SDP_TICK_WINDOW_IMMEDIATE_SECONDS);
      bool bid_changed = ((ticks[i].flags & TICK_FLAG_BID) == TICK_FLAG_BID);
      bool ask_changed = ((ticks[i].flags & TICK_FLAG_ASK) == TICK_FLAG_ASK);
      double spread_price = ((ticks[i].ask > 0.0 && ticks[i].bid > 0.0) ? (ticks[i].ask - ticks[i].bid) : 0.0);
      double spread_points = (point > 0.0 ? spread_price / point : 0.0);

      s.ticks_last_300s++; s.tick_sample_count_300s++;
      if(bid_changed) s.bid_change_count_300s++;
      if(ask_changed) s.ask_change_count_300s++;
      if(prev_300 > 0)
        { int gap300 = (int)(ticks[i].time - prev_300); if(gap300 < 0) gap300 = 0; if(s.max_tick_gap_seconds_300s < 0 || gap300 > s.max_tick_gap_seconds_300s) s.max_tick_gap_seconds_300s = gap300; gap_sum_300 += gap300; gap_count_300++; }
      prev_300 = ticks[i].time;
      if(spread_points > 0.0)
        { if(!spread_init_300) { s.spread_min_points_300s = spread_points; s.spread_max_points_300s = spread_points; spread_init_300 = true; } if(spread_points < s.spread_min_points_300s) s.spread_min_points_300s = spread_points; if(spread_points > s.spread_max_points_300s) s.spread_max_points_300s = spread_points; spread_sum_300 += spread_points; s.spread_sample_count_300s++; }

      if(in_60)
        {
         s.ticks_last_60s++; s.tick_sample_count_60s++;
         if(bid_changed) s.bid_change_count_60s++;
         if(ask_changed) s.ask_change_count_60s++;
         if(prev_60 > 0)
           { int gap60 = (int)(ticks[i].time - prev_60); if(gap60 < 0) gap60 = 0; if(s.max_tick_gap_seconds_60s < 0 || gap60 > s.max_tick_gap_seconds_60s) s.max_tick_gap_seconds_60s = gap60; gap_sum_60 += gap60; gap_count_60++; }
         prev_60 = ticks[i].time;
         if(spread_points > 0.0)
           { if(!spread_init_60) { s.spread_min_points_60s = spread_points; s.spread_max_points_60s = spread_points; spread_init_60 = true; } if(spread_points < s.spread_min_points_60s) s.spread_min_points_60s = spread_points; if(spread_points > s.spread_max_points_60s) s.spread_max_points_60s = spread_points; spread_sum_60 += spread_points; s.spread_sample_count_60s++; }
        }
     }

   s.tick_window_60s_valid = (s.tick_sample_count_60s > 0);
   s.tick_window_300s_valid = (s.tick_sample_count_300s > 0);
   s.spread_window_60s_valid = (s.spread_sample_count_60s > 0);
   s.spread_window_300s_valid = (s.spread_sample_count_300s > 0);
   s.tick_window_60s_invalid_reason = (s.tick_window_60s_valid ? string(ASC_SDP_INVALID_REASON_NONE) : string(ASC_SDP_NO_SAMPLE_TEXT));
   s.tick_window_300s_invalid_reason = (s.tick_window_300s_valid ? string(ASC_SDP_INVALID_REASON_NONE) : string(ASC_SDP_NO_SAMPLE_TEXT));
   s.spread_window_60s_invalid_reason = (s.spread_window_60s_valid ? string(ASC_SDP_INVALID_REASON_NONE) : string(ASC_SDP_NO_SAMPLE_TEXT));
   s.spread_window_300s_invalid_reason = (s.spread_window_300s_valid ? string(ASC_SDP_INVALID_REASON_NONE) : string(ASC_SDP_NO_SAMPLE_TEXT));

   s.avg_tick_gap_seconds_60s = (gap_count_60 > 0 ? ((double)gap_sum_60 / (double)gap_count_60) : 0.0);
   s.avg_tick_gap_seconds_300s = (gap_count_300 > 0 ? ((double)gap_sum_300 / (double)gap_count_300) : 0.0);
   s.spread_avg_points_60s = (s.spread_sample_count_60s > 0 ? spread_sum_60 / (double)s.spread_sample_count_60s : 0.0);
   s.spread_avg_points_300s = (s.spread_sample_count_300s > 0 ? spread_sum_300 / (double)s.spread_sample_count_300s : 0.0);
   int last_index = copied - 1;
   double last_spread_price = ((ticks[last_index].ask > 0.0 && ticks[last_index].bid > 0.0) ? (ticks[last_index].ask - ticks[last_index].bid) : 0.0);
   s.spread_current_price = last_spread_price;
   s.spread_current_points = (point > 0.0 ? last_spread_price / point : 0.0);
   s.spread_current_percent = ASC_SymbolDataPackSafePercent(last_spread_price, ticks[last_index].bid);
   s.last_good_tick_stats_age_seconds = ASC_SymbolDataPackAgeSeconds(now_utc, ticks[last_index].time);
   if(s.tick_sample_count_300s > 0)
      s.tick_stats_snapshot_utc = ticks[last_index].time;
   s.last_good_spread_stats_age_seconds = s.last_good_tick_stats_age_seconds;
   if(s.spread_sample_count_300s > 0)
      s.spread_stats_snapshot_utc = ticks[last_index].time;
   if(s.spread_avg_points_300s > 0.0)
      s.spread_widening_vs_300s_avg_percent = ((s.spread_current_points - s.spread_avg_points_300s) / s.spread_avg_points_300s) * 100.0;

   s.tick_stats_hydration_state = (s.tick_sample_count_300s > 0 ? ASC_SDP_QUOTE_HYDRATION_READY : ASC_SDP_QUOTE_HYDRATION_COLLECTING);
   s.spread_stats_hydration_state = (s.spread_sample_count_300s > 0 ? ASC_SDP_QUOTE_HYDRATION_READY : ASC_SDP_QUOTE_HYDRATION_COLLECTING);
   s.tick_stats_collecting_until_full_window = (s.tick_sample_count_300s > 0 ? "sample_window_has_data_full_300s_maturity_time_bounded" : "collecting_until_first_300s_sample");
   s.spread_stats_collecting_until_full_window = (s.spread_sample_count_300s > 0 ? "sample_window_has_data_full_300s_maturity_time_bounded" : "collecting_until_first_300s_sample");
   s.tick_stats_retry_due = (s.tick_sample_count_300s > 0 ? "retry_not_due" : ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET);
   s.spread_stats_retry_due = (s.spread_sample_count_300s > 0 ? "retry_not_due" : ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET);
   return (s.tick_sample_count_300s > 0 || s.spread_sample_count_300s > 0);
  }


// RUN164R OHLC / high-low factual fill contract.
// Dormant/read-only composition only: CopyRates/MqlRates facts, no direction labels, no strategy, no runtime activation.
#define ASC_SDP_BAR_STATE_READY "bar_state_ready"
#define ASC_SDP_BAR_STATE_COLLECTING "bar_state_collecting"
#define ASC_SDP_BAR_STATE_RETRYING "bar_state_retrying"
#define ASC_SDP_BAR_STATE_HISTORY_LOADING "bar_state_history_loading"
#define ASC_SDP_BAR_STATE_PARTIAL_COPY "bar_state_partial_copy"
#define ASC_SDP_BAR_STATE_LAST_GOOD "bar_state_last_good"
#define ASC_SDP_BAR_STATE_MARKET_CLOSED_LAST_GOOD "bar_state_market_closed_but_last_good"
#define ASC_SDP_BAR_STATE_BROKER_LIMITED "bar_state_broker_limited"
#define ASC_SDP_BAR_STATE_HARD_ABSENCE "bar_state_hard_absence_proven"

#define ASC_SDP_OHLC_OWNER "CopyRates/MqlRates official timeseries wrapper"
#define ASC_SDP_OHLC_RECALC_RULE "timeframe_due_only_new_bar_or_current_period_high_low_change"
#define ASC_SDP_LTF_ROLE "ltf_precision_freshness_noise_context_only_not_decision_authority"
#define ASC_SDP_MTF_ROLE "m15_h1_h4_d1_intraday_context_priority_numeric_only"
#define ASC_SDP_HIGH_LOW_ROLE "previous_period_high_low_reference_facts_only_no_support_resistance_no_direction"

#define ASC_SDP_SEQUENCE_PRINT_M1 120
#define ASC_SDP_SEQUENCE_PRINT_M5 120
#define ASC_SDP_SEQUENCE_PRINT_M15 120
#define ASC_SDP_SEQUENCE_PRINT_M30 100
#define ASC_SDP_SEQUENCE_PRINT_H1 100
#define ASC_SDP_SEQUENCE_PRINT_H4 80
#define ASC_SDP_SEQUENCE_PRINT_D1 50
#define ASC_SDP_SEQUENCE_PRINT_W1 50
#define ASC_SDP_SEQUENCE_PRINT_MN1 24

struct ASC_SymbolDataPackTimeframeOhlc
  {
   string timeframe;
   ENUM_TIMEFRAMES period;
   int bars_requested;
   int bars_received;
   int sequence_print_count;
   bool copyrates_success;
   int copyrates_error_code;
   int terminal_bars_count;
   datetime oldest_bar_time;
   datetime newest_bar_time;
   datetime current_forming_bar_time;
   double current_forming_open;
   double current_forming_high;
   double current_forming_low;
   double current_forming_close;
   datetime last_closed_bar_time;
   double last_closed_open;
   double last_closed_high;
   double last_closed_low;
   double last_closed_close;
   long last_closed_tick_volume;
   int last_closed_spread;
   int bar_age_seconds;
   string hydration_state;
   int retry_attempts;
   string retry_due;
   datetime last_good_bar_time;
   int last_good_age_seconds;
   string source_proof;
   string role_boundary;
  };

struct ASC_SymbolDataPackDwmHighLowFacts
  {
   string source_proof;
   string signal_safety;
   string d1_hydration_state;
   string w1_hydration_state;
   string mn1_hydration_state;
   string d1_retry_due;
   string w1_retry_due;
   string mn1_retry_due;
   int d1_last_good_age_seconds;
   int w1_last_good_age_seconds;
   int mn1_last_good_age_seconds;
   double today_open,today_high,today_low,today_current_close,today_range_points;
   double yesterday_open,yesterday_high,yesterday_low,yesterday_close,yesterday_range_points;
   double two_days_ago_open,two_days_ago_high,two_days_ago_low,two_days_ago_close,two_days_ago_range_points;
   double five_day_high,five_day_low,twenty_day_high,twenty_day_low;
   double current_week_open,current_week_high,current_week_low,current_week_current_close,current_week_range_points;
   double previous_week_open,previous_week_high,previous_week_low,previous_week_close,previous_week_range_points;
   double two_weeks_ago_high,two_weeks_ago_low,four_week_high,four_week_low,twelve_week_high,twelve_week_low;
   double current_month_open,current_month_high,current_month_low,current_month_current_close;
   double previous_month_open,previous_month_high,previous_month_low,previous_month_close;
   double three_month_high,three_month_low,six_month_high,six_month_low;
  };

string ASC_SymbolDataPackTimeframeText(const ENUM_TIMEFRAMES period)
  {
   switch(period)
     {
      case PERIOD_M1: return "M1";
      case PERIOD_M5: return "M5";
      case PERIOD_M15: return "M15";
      case PERIOD_M30: return "M30";
      case PERIOD_H1: return "H1";
      case PERIOD_H4: return "H4";
      case PERIOD_D1: return "D1";
      case PERIOD_W1: return "W1";
      case PERIOD_MN1: return "MN1";
     }
   return "UNKNOWN_TIMEFRAME";
  }

int ASC_SymbolDataPackBarsDefaultForPeriod(const ENUM_TIMEFRAMES period)
  {
   if(period == PERIOD_M1 || period == PERIOD_M5 || period == PERIOD_M15) return ASC_SDP_LTF_BARS_DEFAULT;
   if(period == PERIOD_M30 || period == PERIOD_H1 || period == PERIOD_H4) return ASC_SDP_MTF_BARS_DEFAULT;
   if(period == PERIOD_D1) return ASC_SDP_D1_BARS_DEFAULT;
   if(period == PERIOD_W1) return ASC_SDP_W1_BARS_DEFAULT;
   if(period == PERIOD_MN1) return ASC_SDP_MN1_BARS_DEFAULT;
   return ASC_SDP_MTF_BARS_DEFAULT;
  }

int ASC_SymbolDataPackSequencePrintCountForPeriod(const ENUM_TIMEFRAMES period)
  {
   if(period == PERIOD_M1) return ASC_SDP_SEQUENCE_PRINT_M1;
   if(period == PERIOD_M5) return ASC_SDP_SEQUENCE_PRINT_M5;
   if(period == PERIOD_M15) return ASC_SDP_SEQUENCE_PRINT_M15;
   if(period == PERIOD_M30) return ASC_SDP_SEQUENCE_PRINT_M30;
   if(period == PERIOD_H1) return ASC_SDP_SEQUENCE_PRINT_H1;
   if(period == PERIOD_H4) return ASC_SDP_SEQUENCE_PRINT_H4;
   if(period == PERIOD_D1) return ASC_SDP_SEQUENCE_PRINT_D1;
   if(period == PERIOD_W1) return ASC_SDP_SEQUENCE_PRINT_W1;
   if(period == PERIOD_MN1) return ASC_SDP_SEQUENCE_PRINT_MN1;
   return 50;
  }

int ASC_SymbolDataPackCadenceForPeriod(const ENUM_TIMEFRAMES period)
  {
   if(period == PERIOD_M1) return ASC_SDP_SECTION_CADENCE_M1_SECONDS;
   if(period == PERIOD_M5) return ASC_SDP_SECTION_CADENCE_M5_SECONDS;
   if(period == PERIOD_M15) return ASC_SDP_SECTION_CADENCE_M15_SECONDS;
   if(period == PERIOD_M30) return ASC_SDP_SECTION_CADENCE_M30_SECONDS;
   if(period == PERIOD_H1) return ASC_SDP_SECTION_CADENCE_H1_SECONDS;
   if(period == PERIOD_H4) return ASC_SDP_SECTION_CADENCE_H4_SECONDS;
   if(period == PERIOD_D1) return ASC_SDP_SECTION_CADENCE_D1_SECONDS;
   if(period == PERIOD_W1) return ASC_SDP_SECTION_CADENCE_W1_SECONDS;
   if(period == PERIOD_MN1) return ASC_SDP_SECTION_CADENCE_MN1_SECONDS;
   return ASC_SDP_SECTION_CADENCE_H1_SECONDS;
  }

string ASC_SymbolDataPackRoleBoundaryForPeriod(const ENUM_TIMEFRAMES period)
  {
   if(period == PERIOD_M1 || period == PERIOD_M5) return ASC_SDP_LTF_ROLE;
   if(period == PERIOD_M15 || period == PERIOD_M30 || period == PERIOD_H1 || period == PERIOD_H4 || period == PERIOD_D1) return ASC_SDP_MTF_ROLE;
   return ASC_SDP_HIGH_LOW_ROLE;
  }

void ASC_SymbolDataPackInitTimeframeOhlc(ASC_SymbolDataPackTimeframeOhlc &o,const ENUM_TIMEFRAMES period)
  {
   o.timeframe = ASC_SymbolDataPackTimeframeText(period);
   o.period = period;
   o.bars_requested = ASC_SymbolDataPackBarsDefaultForPeriod(period);
   o.bars_received = 0;
   o.sequence_print_count = ASC_SymbolDataPackSequencePrintCountForPeriod(period);
   o.copyrates_success = false;
   o.copyrates_error_code = 0;
   o.terminal_bars_count = 0;
   o.oldest_bar_time = 0;
   o.newest_bar_time = 0;
   o.current_forming_bar_time = 0;
   o.current_forming_open = 0.0; o.current_forming_high = 0.0; o.current_forming_low = 0.0; o.current_forming_close = 0.0;
   o.last_closed_bar_time = 0;
   o.last_closed_open = 0.0; o.last_closed_high = 0.0; o.last_closed_low = 0.0; o.last_closed_close = 0.0;
   o.last_closed_tick_volume = 0;
   o.last_closed_spread = 0;
   o.bar_age_seconds = -1;
   o.hydration_state = ASC_SDP_BAR_STATE_COLLECTING;
   o.retry_attempts = 0;
   o.retry_due = ASC_SDP_RETRY_DUE_NOW;
   o.last_good_bar_time = 0;
   o.last_good_age_seconds = -1;
   o.source_proof = ASC_SDP_OHLC_OWNER;
   o.role_boundary = ASC_SymbolDataPackRoleBoundaryForPeriod(period);
  }

bool ASC_SymbolDataPackReadTimeframeOhlc(const string symbol,const ENUM_TIMEFRAMES period,ASC_SymbolDataPackTimeframeOhlc &o)
  {
   ASC_SymbolDataPackInitTimeframeOhlc(o, period);
   datetime now_utc = TimeCurrent();
   o.terminal_bars_count = Bars(symbol, period);
   MqlRates rates[];
   ResetLastError();
   int copied = CopyRates(symbol, period, 0, o.bars_requested, rates);
   o.bars_received = copied;
   o.copyrates_success = (copied > 0);
   o.copyrates_error_code = (copied > 0 ? 0 : GetLastError());
   if(copied <= 0)
     {
      o.retry_attempts = 1;
      o.retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET;
      o.hydration_state = (o.terminal_bars_count <= 0 ? ASC_SDP_BAR_STATE_HISTORY_LOADING : ASC_SDP_BAR_STATE_RETRYING);
      return false;
     }
   ArraySetAsSeries(rates, true);
   o.newest_bar_time = rates[0].time;
   o.oldest_bar_time = rates[copied - 1].time;
   o.current_forming_bar_time = rates[0].time;
   o.current_forming_open = rates[0].open; o.current_forming_high = rates[0].high; o.current_forming_low = rates[0].low; o.current_forming_close = rates[0].close;
   if(copied > 1)
     {
      o.last_closed_bar_time = rates[1].time;
      o.last_closed_open = rates[1].open; o.last_closed_high = rates[1].high; o.last_closed_low = rates[1].low; o.last_closed_close = rates[1].close;
      o.last_closed_tick_volume = rates[1].tick_volume;
      o.last_closed_spread = rates[1].spread;
      o.bar_age_seconds = ASC_SymbolDataPackAgeSeconds(now_utc, o.last_closed_bar_time);
      o.last_good_bar_time = o.last_closed_bar_time;
      o.last_good_age_seconds = o.bar_age_seconds;
     }
   else
     {
      o.retry_attempts = 1;
      o.retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET;
      o.hydration_state = ASC_SDP_BAR_STATE_PARTIAL_COPY;
      return false;
     }
   if(copied < o.bars_requested)
     {
      o.retry_attempts = 1;
      o.retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET;
      o.hydration_state = ASC_SDP_BAR_STATE_PARTIAL_COPY;
      return true;
     }
   o.hydration_state = ASC_SDP_BAR_STATE_READY;
   o.retry_due = "retry_not_due";
   return true;
  }

double ASC_SymbolDataPackRangePoints(const double high,const double low,const double point)
  {
   if(point <= 0.0 || high <= 0.0 || low <= 0.0) return 0.0;
   return (high - low) / point;
  }

void ASC_SymbolDataPackHighLowOverRatesArray(MqlRates &rates[],const int start_index,const int count,double &high_out,double &low_out)
  {
   high_out = 0.0; low_out = 0.0;
   int total = ArraySize(rates);
   int end_index = start_index + count - 1;
   if(end_index >= total) end_index = total - 1;
   for(int i = start_index; i <= end_index; i++)
     {
      if(i < 0 || i >= total) continue;
      if(high_out <= 0.0 || rates[i].high > high_out) high_out = rates[i].high;
      if(low_out <= 0.0 || rates[i].low < low_out) low_out = rates[i].low;
     }
  }

int ASC_SymbolDataPackCopyRatesSeries(const string symbol,const ENUM_TIMEFRAMES period,const int requested,MqlRates &rates[],int &error_code_out)
  {
   error_code_out = 0;
   ResetLastError();
   int copied = CopyRates(symbol, period, 0, requested, rates);
   if(copied <= 0)
      error_code_out = GetLastError();
   else
      ArraySetAsSeries(rates, true);
   return copied;
  }

void ASC_SymbolDataPackInitDwmFacts(ASC_SymbolDataPackDwmHighLowFacts &f)
  {
   f.source_proof = ASC_SDP_OHLC_OWNER;
   f.signal_safety = ASC_SDP_HIGH_LOW_ROLE;
   f.d1_hydration_state = ASC_SDP_BAR_STATE_COLLECTING; f.w1_hydration_state = ASC_SDP_BAR_STATE_COLLECTING; f.mn1_hydration_state = ASC_SDP_BAR_STATE_COLLECTING;
   f.d1_retry_due = ASC_SDP_RETRY_DUE_NOW; f.w1_retry_due = ASC_SDP_RETRY_DUE_NOW; f.mn1_retry_due = ASC_SDP_RETRY_DUE_NOW;
   f.d1_last_good_age_seconds = -1; f.w1_last_good_age_seconds = -1; f.mn1_last_good_age_seconds = -1;
   f.today_open = 0.0; f.today_high = 0.0; f.today_low = 0.0; f.today_current_close = 0.0; f.today_range_points = 0.0;
   f.yesterday_open = 0.0; f.yesterday_high = 0.0; f.yesterday_low = 0.0; f.yesterday_close = 0.0; f.yesterday_range_points = 0.0;
   f.two_days_ago_open = 0.0; f.two_days_ago_high = 0.0; f.two_days_ago_low = 0.0; f.two_days_ago_close = 0.0; f.two_days_ago_range_points = 0.0;
   f.five_day_high = 0.0; f.five_day_low = 0.0; f.twenty_day_high = 0.0; f.twenty_day_low = 0.0;
   f.current_week_open = 0.0; f.current_week_high = 0.0; f.current_week_low = 0.0; f.current_week_current_close = 0.0; f.current_week_range_points = 0.0;
   f.previous_week_open = 0.0; f.previous_week_high = 0.0; f.previous_week_low = 0.0; f.previous_week_close = 0.0; f.previous_week_range_points = 0.0;
   f.two_weeks_ago_high = 0.0; f.two_weeks_ago_low = 0.0; f.four_week_high = 0.0; f.four_week_low = 0.0; f.twelve_week_high = 0.0; f.twelve_week_low = 0.0;
   f.current_month_open = 0.0; f.current_month_high = 0.0; f.current_month_low = 0.0; f.current_month_current_close = 0.0;
   f.previous_month_open = 0.0; f.previous_month_high = 0.0; f.previous_month_low = 0.0; f.previous_month_close = 0.0;
   f.three_month_high = 0.0; f.three_month_low = 0.0; f.six_month_high = 0.0; f.six_month_low = 0.0;
  }

bool ASC_SymbolDataPackReadDwmHighLowFacts(const string symbol,ASC_SymbolDataPackDwmHighLowFacts &f)
  {
   ASC_SymbolDataPackInitDwmFacts(f);
   double point = 0.0;
   SymbolInfoDouble(symbol, SYMBOL_POINT, point);
   ASC_SymbolDataPackTimeframeOhlc d1,w1,mn1;
   bool d1_ok = ASC_SymbolDataPackReadTimeframeOhlc(symbol, PERIOD_D1, d1);
   bool w1_ok = ASC_SymbolDataPackReadTimeframeOhlc(symbol, PERIOD_W1, w1);
   bool mn1_ok = ASC_SymbolDataPackReadTimeframeOhlc(symbol, PERIOD_MN1, mn1);
   f.d1_hydration_state = d1.hydration_state; f.w1_hydration_state = w1.hydration_state; f.mn1_hydration_state = mn1.hydration_state;
   f.d1_retry_due = d1.retry_due; f.w1_retry_due = w1.retry_due; f.mn1_retry_due = mn1.retry_due;
   f.d1_last_good_age_seconds = d1.last_good_age_seconds; f.w1_last_good_age_seconds = w1.last_good_age_seconds; f.mn1_last_good_age_seconds = mn1.last_good_age_seconds;
   MqlRates d1_rates[], w1_rates[], mn1_rates[];
   int err = 0;
   int d1_count = ASC_SymbolDataPackCopyRatesSeries(symbol, PERIOD_D1, ASC_SDP_D1_BARS_DEFAULT, d1_rates, err);
   int w1_count = ASC_SymbolDataPackCopyRatesSeries(symbol, PERIOD_W1, ASC_SDP_W1_BARS_DEFAULT, w1_rates, err);
   int mn1_count = ASC_SymbolDataPackCopyRatesSeries(symbol, PERIOD_MN1, ASC_SDP_MN1_BARS_DEFAULT, mn1_rates, err);
   if(d1_count > 0) { f.today_open = d1_rates[0].open; f.today_high = d1_rates[0].high; f.today_low = d1_rates[0].low; f.today_current_close = d1_rates[0].close; f.today_range_points = ASC_SymbolDataPackRangePoints(f.today_high, f.today_low, point); }
   if(d1_count > 1) { f.yesterday_open = d1_rates[1].open; f.yesterday_high = d1_rates[1].high; f.yesterday_low = d1_rates[1].low; f.yesterday_close = d1_rates[1].close; f.yesterday_range_points = ASC_SymbolDataPackRangePoints(f.yesterday_high, f.yesterday_low, point); }
   if(d1_count > 2) { f.two_days_ago_open = d1_rates[2].open; f.two_days_ago_high = d1_rates[2].high; f.two_days_ago_low = d1_rates[2].low; f.two_days_ago_close = d1_rates[2].close; f.two_days_ago_range_points = ASC_SymbolDataPackRangePoints(f.two_days_ago_high, f.two_days_ago_low, point); }
   ASC_SymbolDataPackHighLowOverRatesArray(d1_rates, 0, 5, f.five_day_high, f.five_day_low); ASC_SymbolDataPackHighLowOverRatesArray(d1_rates, 0, 20, f.twenty_day_high, f.twenty_day_low);
   if(w1_count > 0) { f.current_week_open = w1_rates[0].open; f.current_week_high = w1_rates[0].high; f.current_week_low = w1_rates[0].low; f.current_week_current_close = w1_rates[0].close; f.current_week_range_points = ASC_SymbolDataPackRangePoints(f.current_week_high, f.current_week_low, point); }
   if(w1_count > 1) { f.previous_week_open = w1_rates[1].open; f.previous_week_high = w1_rates[1].high; f.previous_week_low = w1_rates[1].low; f.previous_week_close = w1_rates[1].close; f.previous_week_range_points = ASC_SymbolDataPackRangePoints(f.previous_week_high, f.previous_week_low, point); }
   if(w1_count > 2) { f.two_weeks_ago_high = w1_rates[2].high; f.two_weeks_ago_low = w1_rates[2].low; }
   ASC_SymbolDataPackHighLowOverRatesArray(w1_rates, 0, 4, f.four_week_high, f.four_week_low); ASC_SymbolDataPackHighLowOverRatesArray(w1_rates, 0, 12, f.twelve_week_high, f.twelve_week_low);
   if(mn1_count > 0) { f.current_month_open = mn1_rates[0].open; f.current_month_high = mn1_rates[0].high; f.current_month_low = mn1_rates[0].low; f.current_month_current_close = mn1_rates[0].close; }
   if(mn1_count > 1) { f.previous_month_open = mn1_rates[1].open; f.previous_month_high = mn1_rates[1].high; f.previous_month_low = mn1_rates[1].low; f.previous_month_close = mn1_rates[1].close; }
   ASC_SymbolDataPackHighLowOverRatesArray(mn1_rates, 0, 3, f.three_month_high, f.three_month_low); ASC_SymbolDataPackHighLowOverRatesArray(mn1_rates, 0, 6, f.six_month_high, f.six_month_low);
   return (d1_ok || w1_ok || mn1_ok);
  }



// RUN165R ATR / volatility / range-position / pullback factual fill contract.
// Dormant/read-only composition only: CopyRates/MqlRates facts, manual true-range averages,
// numeric ratios, no direction labels, no strategy, no runtime activation.
#define ASC_SDP_ATR_PERIOD_DEFAULT 14
#define ASC_SDP_ATR_SOURCE_METHOD "manual_true_range_average_from_CopyRates_MqlRates_no_indicator_handle"
#define ASC_SDP_ATR_FORMULA_BASIS "TR=max(high-low,abs(high-prev_close),abs(low-prev_close)); ATR14=average(TR[closed bars])"
#define ASC_SDP_ATR_STATE_READY "atr_state_ready"
#define ASC_SDP_ATR_STATE_COLLECTING "atr_state_collecting"
#define ASC_SDP_ATR_STATE_RETRYING "atr_state_retrying"
#define ASC_SDP_ATR_STATE_INDICATOR_LOADING "atr_state_indicator_loading"
#define ASC_SDP_ATR_STATE_HISTORY_LOADING "atr_state_history_loading"
#define ASC_SDP_ATR_STATE_PARTIAL_COPY "atr_state_partial_copy"
#define ASC_SDP_ATR_STATE_LAST_GOOD "atr_state_last_good"
#define ASC_SDP_ATR_STATE_HARD_ABSENCE "atr_state_hard_absence_proven"
#define ASC_SDP_RANGE_STATE_READY "range_state_ready"
#define ASC_SDP_RANGE_STATE_COLLECTING "range_state_collecting"
#define ASC_SDP_PULLBACK_STATE_READY "pullback_state_ready"
#define ASC_SDP_PULLBACK_STATE_COLLECTING "pullback_state_collecting"
#define ASC_SDP_VOLATILITY_SIGNAL_SAFETY "numeric_volatility_range_position_pullback_cost_context_only_no_direction_no_permission"

struct ASC_SymbolDataPackAtrVolatilityFacts
  {
   string timeframe;
   ENUM_TIMEFRAMES period;
   int atr_period;
   string atr_source_method;
   datetime atr_last_closed_bar_time;
   double atr_last_closed_value;
   datetime atr_current_preview_bar_time;
   double atr_current_preview_value;
   double atr_points;
   double atr_price_units;
   double atr_percent_of_price;
   int atr_bars_used;
   int atr_sample_count;
   int bars_requested;
   int bars_received;
   int copyrates_error_code;
   string atr_hydration_state;
   int atr_retry_attempts;
   string atr_retry_due;
   double atr_last_good_value;
   int atr_last_good_age_seconds;
   string atr_formula_basis;
   double current_forming_range_points;
   double last_closed_range_points;
   double average_range_points;
   double median_range_points;
   double highest_range_points;
   double lowest_range_points;
   double range_to_atr14_ratio;
   int range_lookback_bars;
   string range_hydration_state;
   double position_last_50_range_percent;
   double position_last_100_range_percent;
   double position_last_20_range_percent;
   double position_last_12_range_percent;
   double distance_from_recent_high_points;
   double distance_from_recent_low_points;
   double distance_from_recent_high_percent;
   double distance_from_recent_low_percent;
   double distance_from_recent_high_atr_ratio;
   double distance_from_recent_low_atr_ratio;
   double pullback_from_recent_high_percent;
   double pullback_from_recent_low_percent;
   int pullback_lookback_bars;
   string pullback_hydration_state;
   string due_only_rule;
   string signal_safety;
  };

double ASC_SymbolDataPackAbsDouble(const double value)
  {
   return (value < 0.0 ? -value : value);
  }

double ASC_SymbolDataPackSafeRatio(const double numerator,const double denominator)
  {
   if(denominator == 0.0) return 0.0;
   return numerator / denominator;
  }

double ASC_SymbolDataPackTrueRangePrice(MqlRates &rates[],const int index)
  {
   int total = ArraySize(rates);
   if(index < 0 || index + 1 >= total) return 0.0;
   double high_low = rates[index].high - rates[index].low;
   double high_prev_close = ASC_SymbolDataPackAbsDouble(rates[index].high - rates[index + 1].close);
   double low_prev_close = ASC_SymbolDataPackAbsDouble(rates[index].low - rates[index + 1].close);
   double tr = high_low;
   if(high_prev_close > tr) tr = high_prev_close;
   if(low_prev_close > tr) tr = low_prev_close;
   if(tr < 0.0) tr = 0.0;
   return tr;
  }

double ASC_SymbolDataPackAverageTrueRangePrice(MqlRates &rates[],const int start_index,const int period,int &sample_count_out)
  {
   sample_count_out = 0;
   double sum = 0.0;
   int total = ArraySize(rates);
   for(int i = start_index; i < start_index + period; i++)
     {
      if(i < 0 || i + 1 >= total) break;
      double tr = ASC_SymbolDataPackTrueRangePrice(rates, i);
      if(tr <= 0.0) continue;
      sum += tr;
      sample_count_out++;
     }
   if(sample_count_out <= 0) return 0.0;
   return sum / (double)sample_count_out;
  }

int ASC_SymbolDataPackRangeLookbackForPeriod(const ENUM_TIMEFRAMES period)
  {
   if(period == PERIOD_M1 || period == PERIOD_M5) return 100;
   if(period == PERIOD_M15 || period == PERIOD_M30 || period == PERIOD_H1 || period == PERIOD_H4) return 50;
   if(period == PERIOD_D1) return 20;
   if(period == PERIOD_W1) return 12;
   if(period == PERIOD_MN1) return 6;
   return 50;
  }

void ASC_SymbolDataPackRangeStatsFromRates(MqlRates &rates[],const int start_index,const int count,const double point,double &avg_out,double &median_out,double &highest_out,double &lowest_out,int &sample_count_out)
  {
   avg_out = 0.0; median_out = 0.0; highest_out = 0.0; lowest_out = 0.0; sample_count_out = 0;
   int total = ArraySize(rates);
   double values[];
   ArrayResize(values, 0);
   double sum = 0.0;
   int end_index = start_index + count - 1;
   if(end_index >= total) end_index = total - 1;
   for(int i = start_index; i <= end_index; i++)
     {
      if(i < 0 || i >= total) continue;
      double rp = ASC_SymbolDataPackRangePoints(rates[i].high, rates[i].low, point);
      if(rp <= 0.0) continue;
      int n = ArraySize(values);
      ArrayResize(values, n + 1);
      values[n] = rp;
      sum += rp;
      if(highest_out <= 0.0 || rp > highest_out) highest_out = rp;
      if(lowest_out <= 0.0 || rp < lowest_out) lowest_out = rp;
      sample_count_out++;
     }
   if(sample_count_out <= 0) return;
   avg_out = sum / (double)sample_count_out;
   ArraySort(values);
   if(sample_count_out % 2 == 1)
      median_out = values[sample_count_out / 2];
   else
      median_out = (values[(sample_count_out / 2) - 1] + values[sample_count_out / 2]) / 2.0;
  }

double ASC_SymbolDataPackPositionPercent(const double price,const double range_low,const double range_high)
  {
   if(price <= 0.0 || range_high <= range_low) return 0.0;
   return ((price - range_low) / (range_high - range_low)) * 100.0;
  }

void ASC_SymbolDataPackInitAtrVolatilityFacts(ASC_SymbolDataPackAtrVolatilityFacts &f,const ENUM_TIMEFRAMES period)
  {
   f.timeframe = ASC_SymbolDataPackTimeframeText(period);
   f.period = period;
   f.atr_period = ASC_SDP_ATR_PERIOD_DEFAULT;
   f.atr_source_method = ASC_SDP_ATR_SOURCE_METHOD;
   f.atr_last_closed_bar_time = 0; f.atr_last_closed_value = 0.0;
   f.atr_current_preview_bar_time = 0; f.atr_current_preview_value = 0.0;
   f.atr_points = 0.0; f.atr_price_units = 0.0; f.atr_percent_of_price = 0.0;
   f.atr_bars_used = 0; f.atr_sample_count = 0;
   f.bars_requested = ASC_SymbolDataPackBarsDefaultForPeriod(period);
   if(f.bars_requested < ASC_SDP_ATR_PERIOD_DEFAULT + 2) f.bars_requested = ASC_SDP_ATR_PERIOD_DEFAULT + 2;
   f.bars_received = 0; f.copyrates_error_code = 0;
   f.atr_hydration_state = ASC_SDP_ATR_STATE_COLLECTING;
   f.atr_retry_attempts = 0; f.atr_retry_due = ASC_SDP_RETRY_DUE_NOW;
   f.atr_last_good_value = 0.0; f.atr_last_good_age_seconds = -1;
   f.atr_formula_basis = ASC_SDP_ATR_FORMULA_BASIS;
   f.current_forming_range_points = 0.0; f.last_closed_range_points = 0.0;
   f.average_range_points = 0.0; f.median_range_points = 0.0; f.highest_range_points = 0.0; f.lowest_range_points = 0.0;
   f.range_to_atr14_ratio = 0.0; f.range_lookback_bars = ASC_SymbolDataPackRangeLookbackForPeriod(period);
   f.range_hydration_state = ASC_SDP_RANGE_STATE_COLLECTING;
   f.position_last_50_range_percent = 0.0; f.position_last_100_range_percent = 0.0; f.position_last_20_range_percent = 0.0; f.position_last_12_range_percent = 0.0;
   f.distance_from_recent_high_points = 0.0; f.distance_from_recent_low_points = 0.0;
   f.distance_from_recent_high_percent = 0.0; f.distance_from_recent_low_percent = 0.0;
   f.distance_from_recent_high_atr_ratio = 0.0; f.distance_from_recent_low_atr_ratio = 0.0;
   f.pullback_from_recent_high_percent = 0.0; f.pullback_from_recent_low_percent = 0.0;
   f.pullback_lookback_bars = f.range_lookback_bars;
   f.pullback_hydration_state = ASC_SDP_PULLBACK_STATE_COLLECTING;
   f.due_only_rule = "last_closed_values_recalculate_only_on_new_source_timeframe_bar_preview_values_must_be_labelled";
   f.signal_safety = ASC_SDP_VOLATILITY_SIGNAL_SAFETY;
  }

bool ASC_SymbolDataPackReadAtrVolatilityFacts(const string symbol,const ENUM_TIMEFRAMES period,ASC_SymbolDataPackAtrVolatilityFacts &f)
  {
   ASC_SymbolDataPackInitAtrVolatilityFacts(f, period);
   datetime now_utc = TimeCurrent();
   double point = 0.0;
   SymbolInfoDouble(symbol, SYMBOL_POINT, point);
   MqlRates rates[];
   int copy_error = 0;
   int requested = f.bars_requested;
   int copied = ASC_SymbolDataPackCopyRatesSeries(symbol, period, requested, rates, copy_error);
   f.bars_received = copied;
   f.copyrates_error_code = copy_error;
   if(copied <= 0)
     {
      f.atr_retry_attempts = 1;
      f.atr_retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET;
      f.atr_hydration_state = (Bars(symbol, period) <= 0 ? ASC_SDP_ATR_STATE_HISTORY_LOADING : ASC_SDP_ATR_STATE_RETRYING);
      return false;
     }
   if(copied < ASC_SDP_ATR_PERIOD_DEFAULT + 2)
     {
      f.atr_retry_attempts = 1;
      f.atr_retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET;
      f.atr_hydration_state = ASC_SDP_ATR_STATE_PARTIAL_COPY;
     }
   int sample_count = 0;
   f.atr_last_closed_value = ASC_SymbolDataPackAverageTrueRangePrice(rates, 1, f.atr_period, sample_count);
   f.atr_sample_count = sample_count;
   f.atr_bars_used = sample_count;
   f.atr_last_closed_bar_time = (copied > 1 ? rates[1].time : 0);
   int preview_count = 0;
   f.atr_current_preview_value = ASC_SymbolDataPackAverageTrueRangePrice(rates, 0, f.atr_period, preview_count);
   f.atr_current_preview_bar_time = (copied > 0 ? rates[0].time : 0);
   f.atr_price_units = f.atr_last_closed_value;
   f.atr_points = (point > 0.0 ? f.atr_last_closed_value / point : 0.0);
   double price_basis = (copied > 1 ? rates[1].close : (copied > 0 ? rates[0].close : 0.0));
   f.atr_percent_of_price = ASC_SymbolDataPackSafePercent(f.atr_last_closed_value, price_basis);
   f.atr_last_good_value = f.atr_last_closed_value;
   f.atr_last_good_age_seconds = ASC_SymbolDataPackAgeSeconds(now_utc, f.atr_last_closed_bar_time);
   f.current_forming_range_points = (copied > 0 ? ASC_SymbolDataPackRangePoints(rates[0].high, rates[0].low, point) : 0.0);
   f.last_closed_range_points = (copied > 1 ? ASC_SymbolDataPackRangePoints(rates[1].high, rates[1].low, point) : 0.0);
   int range_samples = 0;
   ASC_SymbolDataPackRangeStatsFromRates(rates, 1, f.range_lookback_bars, point, f.average_range_points, f.median_range_points, f.highest_range_points, f.lowest_range_points, range_samples);
   f.range_to_atr14_ratio = ASC_SymbolDataPackSafeRatio(f.last_closed_range_points, f.atr_points);
   double high50 = 0.0, low50 = 0.0, high100 = 0.0, low100 = 0.0, high20 = 0.0, low20 = 0.0, high12 = 0.0, low12 = 0.0;
   ASC_SymbolDataPackHighLowOverRatesArray(rates, 1, 50, high50, low50);
   ASC_SymbolDataPackHighLowOverRatesArray(rates, 1, 100, high100, low100);
   ASC_SymbolDataPackHighLowOverRatesArray(rates, 1, 20, high20, low20);
   ASC_SymbolDataPackHighLowOverRatesArray(rates, 1, 12, high12, low12);
   double current_price = (copied > 0 ? rates[0].close : price_basis);
   f.position_last_50_range_percent = ASC_SymbolDataPackPositionPercent(current_price, low50, high50);
   f.position_last_100_range_percent = ASC_SymbolDataPackPositionPercent(current_price, low100, high100);
   f.position_last_20_range_percent = ASC_SymbolDataPackPositionPercent(current_price, low20, high20);
   f.position_last_12_range_percent = ASC_SymbolDataPackPositionPercent(current_price, low12, high12);
   double recent_high = high50;
   double recent_low = low50;
   if(period == PERIOD_D1) { recent_high = high20; recent_low = low20; }
   if(period == PERIOD_W1) { recent_high = high12; recent_low = low12; }
   f.distance_from_recent_high_points = (point > 0.0 && recent_high > 0.0 ? ASC_SymbolDataPackAbsDouble(recent_high - current_price) / point : 0.0);
   f.distance_from_recent_low_points = (point > 0.0 && recent_low > 0.0 ? ASC_SymbolDataPackAbsDouble(current_price - recent_low) / point : 0.0);
   f.distance_from_recent_high_percent = ASC_SymbolDataPackSafePercent(ASC_SymbolDataPackAbsDouble(recent_high - current_price), recent_high);
   f.distance_from_recent_low_percent = ASC_SymbolDataPackSafePercent(ASC_SymbolDataPackAbsDouble(current_price - recent_low), recent_low);
   f.distance_from_recent_high_atr_ratio = ASC_SymbolDataPackSafeRatio(f.distance_from_recent_high_points, f.atr_points);
   f.distance_from_recent_low_atr_ratio = ASC_SymbolDataPackSafeRatio(f.distance_from_recent_low_points, f.atr_points);
   f.pullback_from_recent_high_percent = f.distance_from_recent_high_percent;
   f.pullback_from_recent_low_percent = f.distance_from_recent_low_percent;
   if(sample_count >= f.atr_period && range_samples > 0)
     {
      f.atr_hydration_state = ASC_SDP_ATR_STATE_READY;
      f.range_hydration_state = ASC_SDP_RANGE_STATE_READY;
      f.pullback_hydration_state = ASC_SDP_PULLBACK_STATE_READY;
      f.atr_retry_due = "retry_not_due";
     }
   return (sample_count > 0 || range_samples > 0);
  }

string ASC_SymbolDataPackVolatilityFailureModeTableText()
  {
   string text = "| Failure / Pending Mode | Detection | Retry / Hydration Rule | Output State |\n";
   text += "|---|---|---|---|\n";
   text += "| atr history loading | CopyRates <= 0 and Bars <= 0 | retry on next due target; no hard absence | atr_state_history_loading |\n";
   text += "| atr retrying | CopyRates <= 0 with terminal series count | bounded retry; expose error code | atr_state_retrying |\n";
   text += "| atr partial copy | bars_received < period + 2 | show requested/received/sample_count | atr_state_partial_copy |\n";
   text += "| atr last-good | last closed ATR exists but refresh incomplete | retain value and age in same pack | atr_state_last_good |\n";
   text += "| range collecting | range sample count below lookback | show samples and lookback | range_state_collecting |\n";
   text += "| pullback collecting | recent high/low unavailable | show lookback and zero-guarded distances | pullback_state_collecting |\n";
   text += "| hard absence | only after future health proof confirms no source | never default to unavailable | atr_state_hard_absence_proven |\n";
   return text;
  }

string ASC_SymbolDataPackAtrVolatilityDueOnlyTableText()
  {
   string text = "| Data Family | Recalculate When | Preview Allowed? | Guard |\n";
   text += "|---|---|---:|---|\n";
   text += "| M1 ATR | new M1 closed bar | yes | preview labelled; LTF precision only |\n";
   text += "| M5 ATR | new M5 closed bar | yes | preview labelled; LTF precision only |\n";
   text += "| M15 ATR | new M15 closed bar | yes | MTF/intraday context starts here |\n";
   text += "| H1 ATR | new H1 closed bar | yes | no every-beat historical recalculation |\n";
   text += "| H4 ATR | new H4 closed bar | yes | no every-beat historical recalculation |\n";
   text += "| D1/W1/MN1 ATR | new source period closed bar | labelled only | last-closed value carries bar time |\n";
   text += "| range position | quote refresh if cheap; history only on source change | yes | divide-by-zero and high==low guards |\n";
   text += "| pullback distance | quote refresh if cheap; lookback refresh on source change | yes | numeric distance only; no action labels |\n";
   text += "| spread/ATR burden | quote/spread refresh plus ATR source freshness | yes | zero ATR/spread guards |\n";
   return text;
  }


// RUN166R VWAP / anchored VWAP / volume-source quality factual fill contract.
// Dormant/read-only composition only: CopyRates/MqlRates facts, time-based anchors,
// numeric distances, no direction labels, no strategy, no runtime activation.
#define ASC_SDP_VWAP_PERIOD PERIOD_M1
#define ASC_SDP_VWAP_MAX_M1_BARS 5000
#define ASC_SDP_VWAP_FORMULA_BASIS "VWAP=sum(HLC3*volume)/sum(volume)"
#define ASC_SDP_VWAP_TYPICAL_PRICE_METHOD "HLC3_high_low_close_div_3"
#define ASC_SDP_VWAP_SOURCE_METHOD "CopyRates_MqlRates_M1_tick_volume_or_real_volume_with_source_quality"
#define ASC_SDP_VWAP_STATE_READY "vwap_state_ready"
#define ASC_SDP_VWAP_STATE_COLLECTING "vwap_state_collecting"
#define ASC_SDP_VWAP_STATE_RETRYING "vwap_state_retrying"
#define ASC_SDP_VWAP_STATE_HISTORY_LOADING "vwap_state_history_loading"
#define ASC_SDP_VWAP_STATE_PARTIAL_COVERAGE "vwap_state_partial_coverage"
#define ASC_SDP_VWAP_STATE_ZERO_VOLUME_GUARD "vwap_state_zero_volume_guard"
#define ASC_SDP_VWAP_STATE_VOLUME_SOURCE_LIMITED "vwap_state_volume_source_limited"
#define ASC_SDP_VWAP_STATE_LAST_GOOD "vwap_state_last_good"
#define ASC_SDP_VWAP_STATE_HARD_ABSENCE "vwap_state_hard_absence_proven"
#define ASC_SDP_VWAP_VOLUME_REAL "real_volume"
#define ASC_SDP_VWAP_VOLUME_TICK_PROXY "tick_volume_proxy"
#define ASC_SDP_VWAP_VOLUME_UNAVAILABLE "unavailable"
#define ASC_SDP_VWAP_SIGNAL_SAFETY "numeric_vwap_anchor_distance_context_only_no_direction_no_permission_no_support_resistance"

struct ASC_SymbolDataPackVwapFacts
  {
   string family_name;
   string anchor_name;
   datetime anchor_time;
   string anchor_source;
   datetime coverage_start;
   datetime coverage_end;
   int sample_count;
   int bars_requested;
   int bars_received;
   int copyrates_error_code;
   string formula_basis;
   string typical_price_method;
   string volume_source_used;
   bool real_volume_available;
   bool tick_volume_available;
   string volume_source_quality;
   double cumulative_price_volume;
   double cumulative_volume;
   int volume_sample_count;
   int zero_volume_bar_count;
   int missing_volume_bar_count;
   double volume_coverage_percent;
   double volume_total;
   double vwap_value;
   double current_price;
   double current_price_distance_points;
   double current_price_distance_percent;
   double current_price_distance_atr_ratio;
   string hydration_state;
   int retry_attempts;
   string retry_due;
   double last_good_value;
   int last_good_age_seconds;
   string broker_time_basis;
   string partial_coverage_state;
   string broker_volume_limitation_reason;
   string signal_safety;
  };

void ASC_SymbolDataPackInitVwapFacts(ASC_SymbolDataPackVwapFacts &f,const string family_name,const string anchor_name,const datetime anchor_time,const string anchor_source)
  {
   f.family_name = family_name; f.anchor_name = anchor_name; f.anchor_time = anchor_time; f.anchor_source = anchor_source;
   f.coverage_start = 0; f.coverage_end = 0; f.sample_count = 0; f.bars_requested = ASC_SDP_VWAP_MAX_M1_BARS; f.bars_received = 0; f.copyrates_error_code = 0;
   f.formula_basis = ASC_SDP_VWAP_FORMULA_BASIS; f.typical_price_method = ASC_SDP_VWAP_TYPICAL_PRICE_METHOD;
   f.volume_source_used = ASC_SDP_VWAP_VOLUME_UNAVAILABLE; f.real_volume_available = false; f.tick_volume_available = false; f.volume_source_quality = "insufficient";
   f.cumulative_price_volume = 0.0; f.cumulative_volume = 0.0; f.volume_sample_count = 0; f.zero_volume_bar_count = 0; f.missing_volume_bar_count = 0; f.volume_coverage_percent = 0.0; f.volume_total = 0.0;
   f.vwap_value = 0.0; f.current_price = 0.0; f.current_price_distance_points = 0.0; f.current_price_distance_percent = 0.0; f.current_price_distance_atr_ratio = 0.0;
   f.hydration_state = ASC_SDP_VWAP_STATE_COLLECTING; f.retry_attempts = 0; f.retry_due = ASC_SDP_RETRY_DUE_NOW; f.last_good_value = 0.0; f.last_good_age_seconds = -1;
   f.broker_time_basis = "broker_server_time_from_MqlRates_time"; f.partial_coverage_state = "coverage_pending"; f.broker_volume_limitation_reason = "volume_source_not_checked_yet"; f.signal_safety = ASC_SDP_VWAP_SIGNAL_SAFETY;
  }

datetime ASC_SymbolDataPackDayStart(const datetime value)
  { MqlDateTime dt; TimeToStruct(value, dt); dt.hour = 0; dt.min = 0; dt.sec = 0; return StructToTime(dt); }

datetime ASC_SymbolDataPackMonthStart(const datetime value,const int month_offset)
  { MqlDateTime dt; TimeToStruct(value, dt); dt.day = 1; dt.hour = 0; dt.min = 0; dt.sec = 0; dt.mon += month_offset; while(dt.mon <= 0) { dt.mon += 12; dt.year--; } while(dt.mon > 12) { dt.mon -= 12; dt.year++; } return StructToTime(dt); }

datetime ASC_SymbolDataPackWeekStart(const datetime value,const int week_offset)
  { MqlDateTime dt; TimeToStruct(value, dt); datetime day_start = ASC_SymbolDataPackDayStart(value); int day_of_week = dt.day_of_week; int days_from_monday = (day_of_week == 0 ? 6 : day_of_week - 1); return day_start - (days_from_monday * 86400) + (week_offset * 604800); }

double ASC_SymbolDataPackTypicalPriceHlc3(const MqlRates &rate)
  { return (rate.high + rate.low + rate.close) / 3.0; }

long ASC_SymbolDataPackRateVolume(const MqlRates &rate,const bool prefer_real)
  { if(prefer_real && rate.real_volume > 0) return rate.real_volume; if(rate.tick_volume > 0) return rate.tick_volume; if(rate.real_volume > 0) return rate.real_volume; return 0; }

bool ASC_SymbolDataPackReadVwapFromAnchor(const string symbol,const string family_name,const string anchor_name,const datetime anchor_time,const string anchor_source,ASC_SymbolDataPackVwapFacts &f)
  {
   ASC_SymbolDataPackInitVwapFacts(f, family_name, anchor_name, anchor_time, anchor_source);
   datetime now_utc = TimeCurrent();
   if(anchor_time <= 0) { f.hydration_state = ASC_SDP_VWAP_STATE_COLLECTING; f.retry_attempts = 1; f.retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET; f.partial_coverage_state = "anchor_time_pending"; return false; }
   int shift = iBarShift(symbol, ASC_SDP_VWAP_PERIOD, anchor_time, false);
   if(shift < 0) { f.hydration_state = ASC_SDP_VWAP_STATE_HISTORY_LOADING; f.retry_attempts = 1; f.retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET; f.partial_coverage_state = "anchor_bar_not_loaded"; return false; }
   int requested = shift + 1; if(requested > ASC_SDP_VWAP_MAX_M1_BARS) requested = ASC_SDP_VWAP_MAX_M1_BARS; f.bars_requested = requested;
   MqlRates rates[]; ResetLastError(); int copied = CopyRates(symbol, ASC_SDP_VWAP_PERIOD, 0, requested, rates);
   f.bars_received = copied; f.copyrates_error_code = (copied > 0 ? 0 : GetLastError());
   if(copied <= 0) { f.hydration_state = (Bars(symbol, ASC_SDP_VWAP_PERIOD) <= 0 ? ASC_SDP_VWAP_STATE_HISTORY_LOADING : ASC_SDP_VWAP_STATE_RETRYING); f.retry_attempts = 1; f.retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET; f.partial_coverage_state = "copyrates_no_vwap_samples"; return false; }
   ArraySetAsSeries(rates, true);
   bool any_real = false, any_tick = false;
   for(int scan = 0; scan < copied; scan++) { if(rates[scan].time < anchor_time) continue; if(rates[scan].real_volume > 0) any_real = true; if(rates[scan].tick_volume > 0) any_tick = true; }
   bool prefer_real = any_real; f.real_volume_available = any_real; f.tick_volume_available = any_tick;
   if(any_real) f.volume_source_used = ASC_SDP_VWAP_VOLUME_REAL; else if(any_tick) f.volume_source_used = ASC_SDP_VWAP_VOLUME_TICK_PROXY; else f.volume_source_used = ASC_SDP_VWAP_VOLUME_UNAVAILABLE;
   double point = 0.0; SymbolInfoDouble(symbol, SYMBOL_POINT, point);
   for(int i = copied - 1; i >= 0; i--)
     {
      if(rates[i].time < anchor_time) continue;
      long volume = ASC_SymbolDataPackRateVolume(rates[i], prefer_real); f.sample_count++;
      if(f.coverage_start <= 0 || rates[i].time < f.coverage_start) f.coverage_start = rates[i].time;
      if(f.coverage_end <= 0 || rates[i].time > f.coverage_end) f.coverage_end = rates[i].time;
      if(volume <= 0) { f.zero_volume_bar_count++; f.missing_volume_bar_count++; continue; }
      double typical = ASC_SymbolDataPackTypicalPriceHlc3(rates[i]); f.cumulative_price_volume += typical * (double)volume; f.cumulative_volume += (double)volume; f.volume_total += (double)volume; f.volume_sample_count++;
     }
   f.volume_coverage_percent = ASC_SymbolDataPackSafePercent((double)f.volume_sample_count, (double)f.sample_count); f.current_price = (copied > 0 ? rates[0].close : 0.0);
   if(f.cumulative_volume <= 0.0 || f.volume_sample_count <= 0) { f.hydration_state = ASC_SDP_VWAP_STATE_ZERO_VOLUME_GUARD; f.retry_attempts = 1; f.retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET; f.volume_source_quality = "insufficient"; f.broker_volume_limitation_reason = "zero_or_missing_volume_across_anchor_window"; f.partial_coverage_state = "no_volume_weighted_samples"; return false; }
   f.vwap_value = f.cumulative_price_volume / f.cumulative_volume;
   f.current_price_distance_points = (point > 0.0 ? (f.current_price - f.vwap_value) / point : 0.0);
   f.current_price_distance_percent = ASC_SymbolDataPackSafePercent(f.current_price - f.vwap_value, f.vwap_value);
   ASC_SymbolDataPackAtrVolatilityFacts atr; ASC_SymbolDataPackReadAtrVolatilityFacts(symbol, PERIOD_M15, atr);
   f.current_price_distance_atr_ratio = ASC_SymbolDataPackSafeRatio(ASC_SymbolDataPackAbsDouble(f.current_price_distance_points), atr.atr_points);
   f.last_good_value = f.vwap_value; f.last_good_age_seconds = ASC_SymbolDataPackAgeSeconds(now_utc, f.coverage_end);
   f.volume_source_quality = (prefer_real ? "real_volume" : "tick_volume_proxy");
   f.broker_volume_limitation_reason = (prefer_real ? "real_volume_present_in_MqlRates" : "real_volume_not_observed_tick_volume_proxy_used_label_required");
   f.partial_coverage_state = (requested < shift + 1 ? "partial_coverage_anchor_window_exceeds_cap" : "coverage_from_anchor_to_latest_M1_bar");
   f.hydration_state = (requested < shift + 1 ? ASC_SDP_VWAP_STATE_PARTIAL_COVERAGE : (prefer_real ? ASC_SDP_VWAP_STATE_READY : ASC_SDP_VWAP_STATE_VOLUME_SOURCE_LIMITED));
   f.retry_due = (requested < shift + 1 ? ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET : "retry_not_due");
   return true;
  }

string ASC_SymbolDataPackVwapFailureModeTableText()
  {
   string text = "| Failure / Pending Mode | Detection | Retry / Hydration Rule | Output State |\n";
   text += "|---|---|---|---|\n";
   text += "| history loading | CopyRates <= 0 and Bars <= 0 | retry on next due target; no hard absence | vwap_state_history_loading |\n";
   text += "| retrying | CopyRates <= 0 with terminal series count | bounded retry; expose error code | vwap_state_retrying |\n";
   text += "| partial coverage | anchor window exceeds bounded M1 cap | show requested/received/sample_count/coverage window | vwap_state_partial_coverage |\n";
   text += "| zero volume | cumulative volume <= 0 | divide-by-zero guard; retry later | vwap_state_zero_volume_guard |\n";
   text += "| volume source limited | only tick_volume observed | publish tick_volume_proxy quality label | vwap_state_volume_source_limited |\n";
   text += "| last-good | prior computed VWAP exists but refresh incomplete | retain value and age in same pack | vwap_state_last_good |\n";
   text += "| hard absence | only after future health proof confirms no source | never default to unavailable | vwap_state_hard_absence_proven |\n";
   return text;
  }

string ASC_SymbolDataPackVwapDueOnlyTableText()
  {
   string text = "| VWAP Family | Recalculate When | Cumulative Reuse? | Guard |\n";
   text += "|---|---|---:|---|\n";
   text += "| session/current-day VWAP | new M1 bar or due quote/tick refresh target if cheap | yes | do not scan beyond bounded M1 cap |\n";
   text += "| previous-day VWAP | previous D1 anchor complete or hydration improves | yes | static once complete unless history improves |\n";
   text += "| today-open anchor | source M1/D1 boundary changes | yes | anchor time from broker server day start |\n";
   text += "| yesterday-open anchor | previous broker day boundary hydrated | yes | factual time anchor only |\n";
   text += "| week-open anchor | source M1/W1 boundary changes | yes | broker server week start with partial coverage label |\n";
   text += "| month-open anchor | source M1/MN1 boundary changes | yes | broker server month start with partial coverage label |\n";
   text += "| full pack publish | VWAP section changed or proof heartbeat due | n/a | no unchanged file churn |\n";
   return text;
  }

// RUN168R consolidated Symbol Data Pack Lite health map contract.
// Factual summary only: no owner recalculation, no dispatcher activation, no runtime publication activation.
#define ASC_SDP_HEALTH_MAP_CONTRACT "freshness_completeness_retry_hydration_last_good_summary_no_recalculation"
#define ASC_SDP_HEALTH_OUTPUT_CONTRACT "one_health_section_inside_one_symbol_data_pack_file"
#define ASC_SDP_HEALTH_SOURCE_BOUNDARY "health_map_reads_section_metadata_and_contract_states_only"
#define ASC_SDP_HEALTH_CONTEXT_ONLY_RULE "completeness_and_freshness_are_data_context_only"
#define ASC_SDP_HEALTH_LAST_GOOD_RULE "last_good_must_be_labelled_aged_and_never_mask_current_source_state"
#define ASC_SDP_HEALTH_PARTIAL_COPY_RULE "partial_copy_must_expose_requested_received_and_retry_state"
#define ASC_SDP_HEALTH_HISTORY_SYNC_RULE "history_not_synchronized_is_its_own_state_not_hard_absence"
#define ASC_SDP_HEALTH_HARD_ABSENCE_RULE "hard_absence_requires_bounded_proof_never_first_failure"
#define ASC_SDP_HEALTH_RUNTIME_RULE "no_full_universe_health_recompute_no_indicator_handle_churn_no_dispatcher_activation"
#define ASC_SDP_HEALTH_STATE_READY "health_ready"
#define ASC_SDP_HEALTH_STATE_FRESH "health_fresh"
#define ASC_SDP_HEALTH_STATE_STALE "health_stale"
#define ASC_SDP_HEALTH_STATE_COLLECTING "health_collecting"
#define ASC_SDP_HEALTH_STATE_RETRYING "health_retrying"
#define ASC_SDP_HEALTH_STATE_PARTIAL "health_partial"
#define ASC_SDP_HEALTH_STATE_LAST_GOOD "health_last_good"
#define ASC_SDP_HEALTH_STATE_INSUFFICIENT_HISTORY "health_insufficient_history"
#define ASC_SDP_HEALTH_STATE_HISTORY_NOT_SYNCHRONIZED "health_history_not_synchronized"
#define ASC_SDP_HEALTH_STATE_BUFFER_LOADING "health_buffer_loading"
#define ASC_SDP_HEALTH_STATE_SOURCE_NOT_SELECTED "health_source_not_selected"
#define ASC_SDP_HEALTH_STATE_SOURCE_NOT_READY "health_source_not_ready"
#define ASC_SDP_HEALTH_STATE_SOURCE_ERROR "health_source_error"
#define ASC_SDP_HEALTH_STATE_NOT_DUE "health_not_due"
#define ASC_SDP_HEALTH_STATE_DEFERRED_BY_BUDGET "health_deferred_by_budget"
#define ASC_SDP_HEALTH_STATE_HARD_ABSENCE_PROVEN "health_hard_absence_proven"
#define ASC_SDP_HEALTH_STATE_TIMESTAMP_MISSING "health_timestamp_missing"
#define ASC_SDP_HEALTH_STATE_DUE_PENDING "health_due_pending"

struct ASC_SymbolDataPackCompletenessContract
  {
   string section_name;
   int section_expected_fields;
   int section_present_fields;
   int section_missing_fields;
   double completeness_percent;
   string completeness_state;
   string first_missing_field;
   bool is_publish_blocking;
   bool is_live_blocking_for_RUN170;
   string notes;
  };

int ASC_SymbolDataPackClampMissingFields(const int expected_fields,const int present_fields)
  {
   if(expected_fields <= 0)
      return 0;
   if(present_fields <= 0)
      return expected_fields;
   if(present_fields >= expected_fields)
      return 0;
   return expected_fields - present_fields;
  }

double ASC_SymbolDataPackCompletenessPercent(const int expected_fields,const int present_fields)
  {
   if(expected_fields <= 0)
      return 0.0;
   int bounded_present = present_fields;
   if(bounded_present < 0)
      bounded_present = 0;
   if(bounded_present > expected_fields)
      bounded_present = expected_fields;
   return ((double)bounded_present / (double)expected_fields) * 100.0;
  }

string ASC_SymbolDataPackCompletenessStateText(const int expected_fields,const int present_fields)
  {
   if(expected_fields <= 0)
      return ASC_SDP_HEALTH_STATE_SOURCE_NOT_SELECTED;
   if(present_fields <= 0)
      return ASC_SDP_HEALTH_STATE_COLLECTING;
   if(present_fields >= expected_fields)
      return ASC_SDP_HEALTH_STATE_READY;
   return ASC_SDP_HEALTH_STATE_PARTIAL;
  }

void ASC_SymbolDataPackInitCompletenessContract(ASC_SymbolDataPackCompletenessContract &c,
                                                const string section_name,
                                                const int expected_fields,
                                                const int present_fields,
                                                const string first_missing_field,
                                                const bool live_blocking,
                                                const string notes)
  {
   c.section_name = section_name;
   c.section_expected_fields = expected_fields;
   c.section_present_fields = present_fields;
   c.section_missing_fields = ASC_SymbolDataPackClampMissingFields(expected_fields, present_fields);
   c.completeness_percent = ASC_SymbolDataPackCompletenessPercent(expected_fields, present_fields);
   c.completeness_state = ASC_SymbolDataPackCompletenessStateText(expected_fields, present_fields);
   c.first_missing_field = (StringLen(first_missing_field) > 0 ? first_missing_field : "none");
   c.is_publish_blocking = false;
   c.is_live_blocking_for_RUN170 = live_blocking;
   c.notes = notes;
  }

string ASC_SymbolDataPackCompletenessLine(const ASC_SymbolDataPackCompletenessContract &c)
  {
   return "| " + c.section_name
          + " | " + IntegerToString(c.section_expected_fields)
          + " | " + IntegerToString(c.section_present_fields)
          + " | " + IntegerToString(c.section_missing_fields)
          + " | " + ASC_SymbolDataPackDoubleText(c.completeness_percent)
          + " | " + c.completeness_state
          + " | " + c.first_missing_field
          + " | " + ASC_SymbolDataPackBoolText(c.is_publish_blocking)
          + " | " + ASC_SymbolDataPackBoolText(c.is_live_blocking_for_RUN170)
          + " | " + c.notes + " |\n";
  }

string ASC_SymbolDataPackHealthStateVocabularyText()
  {
   string text = "Canonical Health State Vocabulary\n";
   text += "| Health State | Meaning | Trigger | Retry Rule | Output Requirement |\n";
   text += "|---|---|---|---|---|\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_READY) + " | required facts present for the section contract | owner supplied enough fields | retry_not_due | show source owner and field counts |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_FRESH) + " | source timestamp is inside target cadence | age_seconds <= target_refresh_seconds | retry_not_due | show age_seconds and next_due_utc |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_STALE) + " | source timestamp exceeds target cadence after owner ran | age_seconds > target and owner ran | bounded retry on next due slot | show stale_reason |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_COLLECTING) + " | source is still gathering required samples | present_fields below expected or bars below required | bounded retry | show required and available counts |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_RETRYING) + " | retry is scheduled after recoverable miss | copy/api returned recoverable miss | no runaway retry | show retry_count and next_retry_utc |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_PARTIAL) + " | source returned less than requested | received_count < requested_count | retry at cadence | show requested_count and received_count |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_LAST_GOOD) + " | retained prior good payload exists | current refresh incomplete and prior final exists | do not treat as current | show last_good_age_seconds |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_INSUFFICIENT_HISTORY) + " | bars available below required | bars_available < bars_required | retry after history update | show bars_required and bars_available |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_HISTORY_NOT_SYNCHRONIZED) + " | terminal history sync is not ready | synchronization false | retry later | show exact sync state |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_BUFFER_LOADING) + " | indicator buffer not calculated yet | BarsCalculated <= 0 or CopyBuffer loading | retry later | show buffer_calculated |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_SOURCE_NOT_SELECTED) + " | source path intentionally not selected | route not selected | no retry until selected | show source_not_selected |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_SOURCE_NOT_READY) + " | owner did not run or is not hydrated | owner state pending | bounded retry if due | show owner and due status |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_SOURCE_ERROR) + " | source returned error code | error code captured | bounded retry or hold | show error code and family |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_NOT_DUE) + " | section is inside cadence | target cadence not elapsed | no retry | do not label stale |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_DEFERRED_BY_BUDGET) + " | work postponed by runtime budget | scheduler/budget guard | retry on budget window | show defer reason |\n";
   text += "| " + string(ASC_SDP_HEALTH_STATE_HARD_ABSENCE_PROVEN) + " | bounded proof shows source cannot exist | repeated bounded failures with proof | no blind retry storm | show proof basis |\n\n";
   return text;
  }

string ASC_SymbolDataPackHealthFamilyLine(const string family,const string owner,const string section,const string fields,const string guard)
  {
   return "| " + family + " | " + owner + " | " + section + " | " + fields + " | implemented | " + guard + " |\n";
  }

string ASC_SymbolDataPackHealthFamilyImplementationText()
  {
   string text = "Health Family Implementation Map\n";
   text += "| Health Family | Source Owner / Existing Section | Existing Section | Health Fields Required | Implemented? | Guard |\n";
   text += "|---|---|---|---|---:|---|\n";
   text += ASC_SymbolDataPackHealthFamilyLine("route health", "SymbolDataPackRouting", "Source Owner Trace / Route Readiness Map", "route_state, owner, selected/not_selected, deferred reason", "routing remains source-owner trace only");
   text += ASC_SymbolDataPackHealthFamilyLine("quote health", "OpenSymbolSnapshotEngine", string(ASC_SYMBOL_DATA_PACK_SECTION_QUOTE), "source_time, observed_time, age_seconds, bid/ask presence", "no quote recalculation by health section");
   text += ASC_SymbolDataPackHealthFamilyLine("tick health", "CopyTicks aggregate wrapper", string(ASC_SYMBOL_DATA_PACK_SECTION_TICK), "requested_count, received_count, tick_window, error_code", "partial copy is visible");
   text += ASC_SymbolDataPackHealthFamilyLine("spread health", "OpenSymbolSnapshotEngine + CopyTicks info", string(ASC_SYMBOL_DATA_PACK_SECTION_SPREAD), "spread samples, window coverage, current spread age", "spread facts remain numeric context");
   text += ASC_SymbolDataPackHealthFamilyLine("OHLC health", "CopyRates / MqlRates wrappers", string(ASC_SYMBOL_DATA_PACK_SECTION_RECENT_CANDLES), "bars_required, bars_available, current_bar_time, last_closed_bar_time", "current vs closed stays separated");
   text += ASC_SymbolDataPackHealthFamilyLine("high-low health", "CopyRates D1/W1/MN1 wrappers", string(ASC_SYMBOL_DATA_PACK_SECTION_DWM), "period coverage, bars_available, partial state", "no range interpretation labels");
   text += ASC_SymbolDataPackHealthFamilyLine("ATR/range/pullback health", "CopyRates/MqlRates manual numeric wrappers", string(ASC_SYMBOL_DATA_PACK_SECTION_ATR), "sample_count, bars_requested, bars_received, last_good_age", "zero guards and sample counts visible");
   text += ASC_SymbolDataPackHealthFamilyLine("VWAP / anchored VWAP health", "CopyRates M1 VWAP wrapper", string(ASC_SYMBOL_DATA_PACK_SECTION_VWAP), "anchor coverage, volume source, zero volume, partial coverage", "volume-source limitation labelled");
   text += ASC_SymbolDataPackHealthFamilyLine("volume-source health", "MqlRates tick/real volume fields", "Volume-Source Quality Facts", "real_volume_available, tick_volume_available, missing_volume_count", "quality context only");
   text += ASC_SymbolDataPackHealthFamilyLine("numeric indicator health", "official indicator handles + CopyBuffer", string(ASC_SYMBOL_DATA_PACK_SECTION_INDICATORS), "BarsCalculated, requested/received, buffer state, error code", "no handle churn requirement added");
   text += ASC_SymbolDataPackHealthFamilyLine("publication health", "SymbolDataPackWriter + ASC_FileIO", string(ASC_SYMBOL_DATA_PACK_SECTION_PUBLICATION), "token validation, no_change, temp/final/last_good path contracts", "writer composes only");
   text += ASC_SymbolDataPackHealthFamilyLine("section freshness summary", "section metadata contracts", string(ASC_SYMBOL_DATA_PACK_SECTION_HEALTH), "age_seconds, target_refresh_seconds, due_status", "no full-universe recompute");
   text += ASC_SymbolDataPackHealthFamilyLine("retry summary", "section owners", string(ASC_SYMBOL_DATA_PACK_SECTION_HEALTH), "retry_count, next_retry_utc, last_error_family", "bounded retry only");
   text += ASC_SymbolDataPackHealthFamilyLine("last-good summary", "retained final payload continuity", string(ASC_SYMBOL_DATA_PACK_SECTION_HEALTH), "last_good_available, last_good_age_seconds, fallback_reason", "last-good never appears current");
   text += ASC_SymbolDataPackHealthFamilyLine("completeness summary", "required token/field contracts", string(ASC_SYMBOL_DATA_PACK_SECTION_HEALTH), "expected/present/missing/completeness_percent", "complete is context only");
   text += "\n";
   return text;
  }

string ASC_SymbolDataPackCompletenessMapText()
  {
   ASC_SymbolDataPackCompletenessContract c;
   string text = "Section Completeness Map\n";
   text += "| Section | Expected Fields | Present Fields | Missing Fields | Completeness Percent | Completeness State | First Missing Field | Publish Blocking | Live Blocking For RUN170 | Notes |\n";
   text += "|---|---:|---:|---:|---:|---|---|---:|---:|---|\n";
   ASC_SymbolDataPackInitCompletenessContract(c, string(ASC_SYMBOL_DATA_PACK_SECTION_IDENTITY), 8, 0, "classification_source_snapshot", true, "source owner not hydrated in shadow contract"); text += ASC_SymbolDataPackCompletenessLine(c);
   ASC_SymbolDataPackInitCompletenessContract(c, string(ASC_SYMBOL_DATA_PACK_SECTION_QUOTE), 14, 14, "none", false, "RUN163R factual quote section present"); text += ASC_SymbolDataPackCompletenessLine(c);
   ASC_SymbolDataPackInitCompletenessContract(c, string(ASC_SYMBOL_DATA_PACK_SECTION_TICK), 11, 11, "none", false, "RUN163R aggregate tick section present"); text += ASC_SymbolDataPackCompletenessLine(c);
   ASC_SymbolDataPackInitCompletenessContract(c, string(ASC_SYMBOL_DATA_PACK_SECTION_SPREAD), 12, 12, "none", false, "RUN163R spread statistics section present"); text += ASC_SymbolDataPackCompletenessLine(c);
   ASC_SymbolDataPackInitCompletenessContract(c, string(ASC_SYMBOL_DATA_PACK_SECTION_RECENT_CANDLES), 9, 9, "none", false, "RUN164R recent candle section present"); text += ASC_SymbolDataPackCompletenessLine(c);
   ASC_SymbolDataPackInitCompletenessContract(c, string(ASC_SYMBOL_DATA_PACK_SECTION_MULTI_TF), 9, 9, "none", false, "RUN164R MTF OHLC section present"); text += ASC_SymbolDataPackCompletenessLine(c);
   ASC_SymbolDataPackInitCompletenessContract(c, string(ASC_SYMBOL_DATA_PACK_SECTION_DWM), 9, 9, "none", false, "RUN164R D/W/M high-low section present"); text += ASC_SymbolDataPackCompletenessLine(c);
   ASC_SymbolDataPackInitCompletenessContract(c, string(ASC_SYMBOL_DATA_PACK_SECTION_ATR), 16, 16, "none", false, "RUN165R ATR/range numeric facts present"); text += ASC_SymbolDataPackCompletenessLine(c);
   ASC_SymbolDataPackInitCompletenessContract(c, string(ASC_SYMBOL_DATA_PACK_SECTION_VWAP), 17, 17, "none", false, "RUN166R VWAP/anchor/volume sections present"); text += ASC_SymbolDataPackCompletenessLine(c);
   ASC_SymbolDataPackInitCompletenessContract(c, string(ASC_SYMBOL_DATA_PACK_SECTION_INDICATORS), 18, 18, "none", false, "RUN167R numeric indicators present"); text += ASC_SymbolDataPackCompletenessLine(c);
   ASC_SymbolDataPackInitCompletenessContract(c, string(ASC_SYMBOL_DATA_PACK_SECTION_HEALTH), 15, 15, "none", false, "RUN168R consolidated health section present"); text += ASC_SymbolDataPackCompletenessLine(c);
   text += "Completeness Boundary: " + string(ASC_SDP_HEALTH_CONTEXT_ONLY_RULE) + "\n\n";
   return text;
  }

string ASC_SymbolDataPackFreshnessMapText()
  {
   string text = "Section Freshness Map\n";
   text += "| Section | Freshness Source | Target Cadence Seconds | Source Time | Observed Time | Age Seconds | Due Status | Next Due UTC | Freshness State | Guard |\n";
   text += "|---|---|---:|---|---|---:|---|---|---|---|\n";
   text += "| " + string(ASC_SYMBOL_DATA_PACK_SECTION_QUOTE) + " | SymbolInfoTick / OpenSymbolSnapshot timestamp | " + IntegerToString(ASC_SDP_QUOTE_REFRESH_TARGET_SECONDS) + " | timestamp_from_owner | compose_time | -1 | due_pending_until_runtime | timestamp_pending_hydration | " + string(ASC_SDP_HEALTH_STATE_SOURCE_NOT_READY) + " | no health-triggered quote call |\n";
   text += "| " + string(ASC_SYMBOL_DATA_PACK_SECTION_TICK) + " | CopyTicks aggregate window end | " + IntegerToString(ASC_SDP_TICK_REFRESH_TARGET_SECONDS) + " | timestamp_from_owner | compose_time | -1 | due_pending_until_runtime | timestamp_pending_hydration | " + string(ASC_SDP_HEALTH_STATE_SOURCE_NOT_READY) + " | requested/received retained |\n";
   text += "| " + string(ASC_SYMBOL_DATA_PACK_SECTION_SPREAD) + " | tick/spread sample window end | " + IntegerToString(ASC_SDP_SPREAD_REFRESH_TARGET_SECONDS) + " | timestamp_from_owner | compose_time | -1 | due_pending_until_runtime | timestamp_pending_hydration | " + string(ASC_SDP_HEALTH_STATE_SOURCE_NOT_READY) + " | no stale label while owner not run |\n";
   text += "| " + string(ASC_SYMBOL_DATA_PACK_SECTION_RECENT_CANDLES) + " | CopyRates last closed bar time | " + IntegerToString(ASC_SDP_SECTION_CADENCE_M1_SECONDS) + " | last_closed_bar_time | compose_time | -1 | due_pending_until_runtime | timestamp_pending_hydration | " + string(ASC_SDP_HEALTH_STATE_SOURCE_NOT_READY) + " | bar index 0 preview separated from index 1 closed |\n";
   text += "| " + string(ASC_SYMBOL_DATA_PACK_SECTION_ATR) + " | ATR source timeframe last closed bar | " + IntegerToString(ASC_SDP_SECTION_CADENCE_M15_SECONDS) + " | last_closed_bar_time | compose_time | -1 | due_pending_until_runtime | timestamp_pending_hydration | " + string(ASC_SDP_HEALTH_STATE_SOURCE_NOT_READY) + " | no every-beat historical recalculation |\n";
   text += "| " + string(ASC_SYMBOL_DATA_PACK_SECTION_VWAP) + " | VWAP coverage_end / anchor coverage | " + IntegerToString(ASC_SDP_QUOTE_REFRESH_TARGET_SECONDS) + " | coverage_end | compose_time | -1 | due_pending_until_runtime | timestamp_pending_hydration | " + string(ASC_SDP_HEALTH_STATE_SOURCE_NOT_READY) + " | volume coverage labelled |\n";
   text += "| " + string(ASC_SYMBOL_DATA_PACK_SECTION_INDICATORS) + " | indicator timeframe last closed bar | " + IntegerToString(ASC_SDP_SECTION_CADENCE_H1_SECONDS) + " | last_closed_bar_time | compose_time | -1 | due_pending_until_runtime | timestamp_pending_hydration | " + string(ASC_SDP_HEALTH_STATE_SOURCE_NOT_READY) + " | handle cache required before live activation |\n";
   text += "Freshness Boundary: source freshness is diagnostic context only and does not override source-owner truth.\n\n";
   return text;
  }

string ASC_SymbolDataPackRetryHydrationMapText()
  {
   string text = "Retry / Hydration Health Map\n";
   text += "| Pending / Failure Mode | Detection | Retry / Hydration Rule | Output State | Guard |\n";
   text += "|---|---|---|---|---|\n";
   text += "| history not synchronized | SeriesInfoInteger/SymbolIsSynchronized false or Bars <= 0 | retry on due cadence only | " + string(ASC_SDP_HEALTH_STATE_HISTORY_NOT_SYNCHRONIZED) + " | not hard absence |\n";
   text += "| insufficient history | bars_available < bars_required | wait for history/hydration; expose counts | " + string(ASC_SDP_HEALTH_STATE_INSUFFICIENT_HISTORY) + " | no fake complete |\n";
   text += "| partial CopyRates/CopyTicks/CopyBuffer | received_count < requested_count | bounded retry; show requested/received | " + string(ASC_SDP_HEALTH_STATE_PARTIAL) + " | no hidden partial copy |\n";
   text += "| indicator buffer loading | BarsCalculated <= 0 or CopyBuffer <= 0 | retry later, no first-failure absence | " + string(ASC_SDP_HEALTH_STATE_BUFFER_LOADING) + " | no per-heartbeat handle churn |\n";
   text += "| source owner not run | owner metadata absent | expose source_not_ready/due_pending | " + string(ASC_SDP_HEALTH_STATE_SOURCE_NOT_READY) + " | health section does not call owner |\n";
   text += "| source error | error code captured | bounded retry or hold by future live run | " + string(ASC_SDP_HEALTH_STATE_SOURCE_ERROR) + " | show error family/code |\n";
   text += "| runtime budget deferred | scheduler defers refresh | next eligible cadence/budget slot | " + string(ASC_SDP_HEALTH_STATE_DEFERRED_BY_BUDGET) + " | no retry storm |\n";
   text += "| hard absence proof | repeated bounded absence with owner proof | stop lazy retry and label proof basis | " + string(ASC_SDP_HEALTH_STATE_HARD_ABSENCE_PROVEN) + " | never first failure |\n\n";
   return text;
  }

string ASC_SymbolDataPackLastGoodMapText()
  {
   string text = "Last-Good Health Map\n";
   text += "| Section | Last Good Available | Last Good Time | Last Good Age Seconds | Last Good Source | Current Source State | Fallback Used | Fallback Reason | Fallback Warning |\n";
   text += "|---|---:|---|---:|---|---|---:|---|---|\n";
   text += "| full_symbol_data_pack_file | false_until_first_live_publish | timestamp_pending_hydration | -1 | retained_final_file_contract | shadow_mode_no_runtime_write | false | no_live_publish_yet | last_good_must_not_look_current |\n";
   text += "| quote/tick/spread | false_until_owner_success | timestamp_pending_hydration | -1 | source_section_owner | source_not_ready_until_runtime | false | no_owner_refresh_in_health_section | current failure must remain visible |\n";
   text += "| OHLC/high-low | false_until_owner_success | timestamp_pending_hydration | -1 | CopyRates owner | source_not_ready_until_runtime | false | no_owner_refresh_in_health_section | bar coverage counts required |\n";
   text += "| ATR/range/pullback | false_until_owner_success | timestamp_pending_hydration | -1 | CopyRates numeric owner | source_not_ready_until_runtime | false | no_owner_refresh_in_health_section | last-good aged separately from current source |\n";
   text += "| VWAP/volume-source | false_until_owner_success | timestamp_pending_hydration | -1 | CopyRates VWAP owner | source_not_ready_until_runtime | false | no_owner_refresh_in_health_section | volume limitation remains visible |\n";
   text += "| numeric indicators | false_until_owner_success | timestamp_pending_hydration | -1 | indicator buffer owner | source_not_ready_until_runtime | false | no_owner_refresh_in_health_section | buffer loading remains visible |\n";
   text += "Last-Good Boundary: " + string(ASC_SDP_HEALTH_LAST_GOOD_RULE) + "\n\n";
   return text;
  }

string ASC_SymbolDataPackPublicationHealthText()
  {
   string text = "Publication Health Summary\n";
   text += "| Publication Health Field | Source | Value | Guard |\n";
   text += "|---|---|---|---|\n";
   text += "| one_file_per_symbol_contract | SymbolDataPackContracts | " + string(ASC_SYMBOL_DATA_PACK_ONE_FILE_PER_SYMBOL) + " | no per-health files |\n";
   text += "| writer_mode | SymbolDataPackWriter | shadow_mode_default | no runtime activation in RUN168R |\n";
   text += "| shadow_mode_status | SymbolDataPackWriter | true | no file write unless future activation |\n";
   text += "| last_publish_attempt | runtime writer metadata | timestamp_pending_hydration | no live claim |\n";
   text += "| last_publish_success | runtime writer metadata | timestamp_pending_hydration | no live claim |\n";
   text += "| last_publish_change_state | no-change comparator | not_evaluated_in_shadow_compose | no FileIO rewrite |\n";
   text += "| required_token_validation_status | writer token validation | required_tokens_extended_RUN168R | missing tokens block payload |\n";
   text += "| required_token_missing_count | writer validation | computed_by_payload_validator | no fake pass |\n";
   text += "| first_missing_required_token | writer validation | computed_by_first_missing_token_helper | first gap visible |\n";
   text += "| no_change_publish_skipped | no-change comparator | not_evaluated_without_existing_payload | avoids broad write churn |\n";
   text += "| temp_path_contract | writer path helper | target_path + .tmp | temp path contract only |\n";
   text += "| final_path_contract | writer path helper | server_root path plus symbol suffix | one final file per symbol |\n";
   text += "| last_good_path_contract | writer path helper | retained final file | no extra operator file |\n\n";
   return text;
  }

string ASC_SymbolDataPackConsolidatedHealthMapText()
  {
   string text = "Symbol Data Pack Lite Health Map\n";
   text += "Section: " + string(ASC_SYMBOL_DATA_PACK_SECTION_HEALTH) + "\n";
   text += "Contract: " + string(ASC_SDP_HEALTH_MAP_CONTRACT) + "\n";
   text += "Output Contract: " + string(ASC_SDP_HEALTH_OUTPUT_CONTRACT) + "\n";
   text += "Source Boundary: " + string(ASC_SDP_HEALTH_SOURCE_BOUNDARY) + "\n";
   text += "Runtime Boundary: " + string(ASC_SDP_HEALTH_RUNTIME_RULE) + "\n\n";
   text += ASC_SymbolDataPackHealthStateVocabularyText();
   text += ASC_SymbolDataPackHealthFamilyImplementationText();
   text += ASC_SymbolDataPackCompletenessMapText();
   text += ASC_SymbolDataPackFreshnessMapText();
   text += ASC_SymbolDataPackRetryHydrationMapText();
   text += ASC_SymbolDataPackLastGoodMapText();
   text += ASC_SymbolDataPackPublicationHealthText();
   return text;
  }

// RUN167R numeric indicator factual fill contract.
// Dormant/read-only composition only: official MQL5 handles + CopyBuffer, numeric values only,
// due-only source contract, no interpretation labels, no signal, no permission, no runtime activation.
#define ASC_SDP_INDICATOR_SOURCE_METHOD "official_MQL5_indicator_handles_CopyBuffer_with_release_after_bounded_shadow_compose"
#define ASC_SDP_INDICATOR_APPLIED_PRICE PRICE_CLOSE
#define ASC_SDP_INDICATOR_APPLIED_PRICE_TEXT "PRICE_CLOSE"
#define ASC_SDP_INDICATOR_BAR_CLOSED 1
#define ASC_SDP_INDICATOR_BAR_PREVIEW 0
#define ASC_SDP_INDICATOR_MA_PERIOD_FAST 20
#define ASC_SDP_INDICATOR_MA_PERIOD_MEDIUM 50
#define ASC_SDP_INDICATOR_MA_PERIOD_SLOW 200
#define ASC_SDP_INDICATOR_RSI_PERIOD 14
#define ASC_SDP_INDICATOR_MACD_FAST_EMA 12
#define ASC_SDP_INDICATOR_MACD_SLOW_EMA 26
#define ASC_SDP_INDICATOR_MACD_SIGNAL_EMA 9
#define ASC_SDP_INDICATOR_BANDS_PERIOD 20
#define ASC_SDP_INDICATOR_BANDS_SHIFT 0
#define ASC_SDP_INDICATOR_BANDS_DEVIATION 2.0
#define ASC_SDP_INDICATOR_ADX_PERIOD 14
#define ASC_SDP_INDICATOR_STDDEV_PERIOD 20
#define ASC_SDP_INDICATOR_ZSCORE_PERIOD 20
#define ASC_SDP_INDICATOR_STATE_READY "indicator_state_ready"
#define ASC_SDP_INDICATOR_STATE_COLLECTING "indicator_state_collecting"
#define ASC_SDP_INDICATOR_STATE_RETRYING "indicator_state_retrying"
#define ASC_SDP_INDICATOR_STATE_HANDLE_INVALID "indicator_state_handle_invalid"
#define ASC_SDP_INDICATOR_STATE_BUFFER_LOADING "indicator_state_buffer_loading"
#define ASC_SDP_INDICATOR_STATE_PARTIAL_COPY "indicator_state_partial_copy"
#define ASC_SDP_INDICATOR_STATE_LAST_GOOD "indicator_state_last_good"
#define ASC_SDP_INDICATOR_STATE_INSUFFICIENT_BARS "indicator_state_insufficient_bars"
#define ASC_SDP_INDICATOR_STATE_HARD_ABSENCE "indicator_state_hard_absence_proven"
#define ASC_SDP_INDICATOR_SIGNAL_SAFETY "numeric_indicator_facts_only_no_interpretation_no_direction_no_permission"
#define ASC_SDP_INDICATOR_CACHE_PLAN "runtime_activation_requires_handle_cache_by_symbol_timeframe_family_parameters_and_release_on_deinit_or_symbol_removal"

struct ASC_SymbolDataPackIndicatorValuePair
  {
   string family_name;
   string value_name;
   ENUM_TIMEFRAMES timeframe;
   string timeframe_text;
   int period;
   int bar_index_last_closed;
   int bar_index_preview;
   string applied_price;
   string source_method;
   int handle_value;
   int bars_calculated;
   int bars_required;
   int copybuffer_error_code;
   int values_requested;
   int values_received;
   double last_closed_value;
   double preview_value;
   bool preview_available;
   int sample_count;
   string hydration_state;
   int retry_attempts;
   string retry_due;
   double last_good_value;
   int last_good_age_seconds;
   string signal_safety;
  };

void ASC_SymbolDataPackInitIndicatorValuePair(ASC_SymbolDataPackIndicatorValuePair &f,
                                               const string family_name,
                                               const string value_name,
                                               const ENUM_TIMEFRAMES timeframe,
                                               const int period,
                                               const int bars_required)
  {
   f.family_name = family_name;
   f.value_name = value_name;
   f.timeframe = timeframe;
   f.timeframe_text = ASC_SymbolDataPackTimeframeText(timeframe);
   f.period = period;
   f.bar_index_last_closed = ASC_SDP_INDICATOR_BAR_CLOSED;
   f.bar_index_preview = ASC_SDP_INDICATOR_BAR_PREVIEW;
   f.applied_price = ASC_SDP_INDICATOR_APPLIED_PRICE_TEXT;
   f.source_method = ASC_SDP_INDICATOR_SOURCE_METHOD;
   f.handle_value = INVALID_HANDLE;
   f.bars_calculated = 0;
   f.bars_required = bars_required;
   f.copybuffer_error_code = 0;
   f.values_requested = 2;
   f.values_received = 0;
   f.last_closed_value = 0.0;
   f.preview_value = 0.0;
   f.preview_available = false;
   f.sample_count = 0;
   f.hydration_state = ASC_SDP_INDICATOR_STATE_COLLECTING;
   f.retry_attempts = 0;
   f.retry_due = ASC_SDP_RETRY_DUE_NOW;
   f.last_good_value = 0.0;
   f.last_good_age_seconds = -1;
   f.signal_safety = ASC_SDP_INDICATOR_SIGNAL_SAFETY;
  }

bool ASC_SymbolDataPackCopyIndicatorBufferPair(const int handle_value,
                                                const int buffer_index,
                                                ASC_SymbolDataPackIndicatorValuePair &f)
  {
   f.handle_value = handle_value;
   if(handle_value == INVALID_HANDLE)
     {
      f.hydration_state = ASC_SDP_INDICATOR_STATE_HANDLE_INVALID;
      f.retry_attempts = 1;
      f.retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET;
      return false;
     }

   ResetLastError();
   f.bars_calculated = BarsCalculated(handle_value);
   if(f.bars_calculated < f.bars_required)
     {
      f.hydration_state = (f.bars_calculated <= 0 ? ASC_SDP_INDICATOR_STATE_BUFFER_LOADING : ASC_SDP_INDICATOR_STATE_INSUFFICIENT_BARS);
      f.copybuffer_error_code = GetLastError();
      f.retry_attempts = 1;
      f.retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET;
      return false;
     }

   double values[];
   ArraySetAsSeries(values, true);
   ResetLastError();
   int copied = CopyBuffer(handle_value, buffer_index, 0, 2, values);
   f.values_received = copied;
   f.copybuffer_error_code = (copied >= 2 ? 0 : GetLastError());
   if(copied <= 0)
     {
      f.hydration_state = ASC_SDP_INDICATOR_STATE_BUFFER_LOADING;
      f.retry_attempts = 1;
      f.retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET;
      return false;
     }
   if(copied < 2)
     {
      f.hydration_state = ASC_SDP_INDICATOR_STATE_PARTIAL_COPY;
      f.retry_attempts = 1;
      f.retry_due = ASC_SDP_RETRY_DUE_ON_NEXT_10S_TARGET;
      return false;
     }

   f.preview_value = values[0];
   f.last_closed_value = values[1];
   f.preview_available = true;
   f.sample_count = f.bars_calculated;
   f.last_good_value = f.last_closed_value;
   f.last_good_age_seconds = 0;
   f.hydration_state = ASC_SDP_INDICATOR_STATE_READY;
   f.retry_due = "retry_not_due";
   return true;
  }

bool ASC_SymbolDataPackReadMAValue(const string symbol,
                                    const ENUM_TIMEFRAMES timeframe,
                                    const int period,
                                    const ENUM_MA_METHOD method,
                                    const string method_text,
                                    ASC_SymbolDataPackIndicatorValuePair &f)
  {
   ASC_SymbolDataPackInitIndicatorValuePair(f, "Moving Average Facts", method_text + "_" + IntegerToString(period), timeframe, period, period + 2);
   ResetLastError();
   int handle_value = iMA(symbol, timeframe, period, 0, method, ASC_SDP_INDICATOR_APPLIED_PRICE);
   bool ok = ASC_SymbolDataPackCopyIndicatorBufferPair(handle_value, 0, f);
   if(handle_value != INVALID_HANDLE) IndicatorRelease(handle_value);
   return ok;
  }

bool ASC_SymbolDataPackReadRSIValue(const string symbol,const ENUM_TIMEFRAMES timeframe,ASC_SymbolDataPackIndicatorValuePair &f)
  {
   ASC_SymbolDataPackInitIndicatorValuePair(f, "RSI Facts", "RSI_14", timeframe, ASC_SDP_INDICATOR_RSI_PERIOD, ASC_SDP_INDICATOR_RSI_PERIOD + 2);
   ResetLastError();
   int handle_value = iRSI(symbol, timeframe, ASC_SDP_INDICATOR_RSI_PERIOD, ASC_SDP_INDICATOR_APPLIED_PRICE);
   bool ok = ASC_SymbolDataPackCopyIndicatorBufferPair(handle_value, 0, f);
   if(handle_value != INVALID_HANDLE) IndicatorRelease(handle_value);
   return ok;
  }

struct ASC_SymbolDataPackMacdFacts
  {
   ASC_SymbolDataPackIndicatorValuePair macd_line;
   ASC_SymbolDataPackIndicatorValuePair signal_line;
   double histogram_last_closed_value;
   double histogram_preview_value;
   string histogram_formula_basis;
  };

bool ASC_SymbolDataPackReadMACDFacts(const string symbol,const ENUM_TIMEFRAMES timeframe,ASC_SymbolDataPackMacdFacts &f)
  {
   ASC_SymbolDataPackInitIndicatorValuePair(f.macd_line, "MACD Facts", "MACD_line", timeframe, ASC_SDP_INDICATOR_MACD_SLOW_EMA, ASC_SDP_INDICATOR_MACD_SLOW_EMA + ASC_SDP_INDICATOR_MACD_SIGNAL_EMA + 2);
   ASC_SymbolDataPackInitIndicatorValuePair(f.signal_line, "MACD Facts", "MACD_signal", timeframe, ASC_SDP_INDICATOR_MACD_SIGNAL_EMA, ASC_SDP_INDICATOR_MACD_SLOW_EMA + ASC_SDP_INDICATOR_MACD_SIGNAL_EMA + 2);
   f.histogram_last_closed_value = 0.0;
   f.histogram_preview_value = 0.0;
   f.histogram_formula_basis = "histogram=MACD_line-signal_line";
   ResetLastError();
   int handle_value = iMACD(symbol, timeframe, ASC_SDP_INDICATOR_MACD_FAST_EMA, ASC_SDP_INDICATOR_MACD_SLOW_EMA, ASC_SDP_INDICATOR_MACD_SIGNAL_EMA, ASC_SDP_INDICATOR_APPLIED_PRICE);
   bool ok_line = ASC_SymbolDataPackCopyIndicatorBufferPair(handle_value, 0, f.macd_line);
   bool ok_signal = ASC_SymbolDataPackCopyIndicatorBufferPair(handle_value, 1, f.signal_line);
   if(ok_line && ok_signal)
     {
      f.histogram_last_closed_value = f.macd_line.last_closed_value - f.signal_line.last_closed_value;
      f.histogram_preview_value = f.macd_line.preview_value - f.signal_line.preview_value;
     }
   if(handle_value != INVALID_HANDLE) IndicatorRelease(handle_value);
   return (ok_line && ok_signal);
  }

struct ASC_SymbolDataPackBandsFacts
  {
   ASC_SymbolDataPackIndicatorValuePair middle_band;
   ASC_SymbolDataPackIndicatorValuePair upper_band;
   ASC_SymbolDataPackIndicatorValuePair lower_band;
   double width_points_last_closed;
   double width_percent_last_closed;
   double position_percent_last_closed;
   string position_formula_basis;
   string divide_guard;
  };

bool ASC_SymbolDataPackReadBandsFacts(const string symbol,const ENUM_TIMEFRAMES timeframe,ASC_SymbolDataPackBandsFacts &f)
  {
   ASC_SymbolDataPackInitIndicatorValuePair(f.middle_band, "Bollinger Band Facts", "bands_middle", timeframe, ASC_SDP_INDICATOR_BANDS_PERIOD, ASC_SDP_INDICATOR_BANDS_PERIOD + 2);
   ASC_SymbolDataPackInitIndicatorValuePair(f.upper_band, "Bollinger Band Facts", "bands_upper", timeframe, ASC_SDP_INDICATOR_BANDS_PERIOD, ASC_SDP_INDICATOR_BANDS_PERIOD + 2);
   ASC_SymbolDataPackInitIndicatorValuePair(f.lower_band, "Bollinger Band Facts", "bands_lower", timeframe, ASC_SDP_INDICATOR_BANDS_PERIOD, ASC_SDP_INDICATOR_BANDS_PERIOD + 2);
   f.width_points_last_closed = 0.0;
   f.width_percent_last_closed = 0.0;
   f.position_percent_last_closed = 0.0;
   f.position_formula_basis = "band_position_percent=(current_price-lower_band)/(upper_band-lower_band)*100";
   f.divide_guard = "upper_minus_lower_zero_guard";
   ResetLastError();
   int handle_value = iBands(symbol, timeframe, ASC_SDP_INDICATOR_BANDS_PERIOD, ASC_SDP_INDICATOR_BANDS_SHIFT, ASC_SDP_INDICATOR_BANDS_DEVIATION, ASC_SDP_INDICATOR_APPLIED_PRICE);
   bool ok_middle = ASC_SymbolDataPackCopyIndicatorBufferPair(handle_value, 0, f.middle_band);
   bool ok_upper = ASC_SymbolDataPackCopyIndicatorBufferPair(handle_value, 1, f.upper_band);
   bool ok_lower = ASC_SymbolDataPackCopyIndicatorBufferPair(handle_value, 2, f.lower_band);
   if(ok_middle && ok_upper && ok_lower)
     {
      double point = 0.0;
      SymbolInfoDouble(symbol, SYMBOL_POINT, point);
      double width_price = f.upper_band.last_closed_value - f.lower_band.last_closed_value;
      f.width_points_last_closed = (point > 0.0 ? width_price / point : 0.0);
      f.width_percent_last_closed = ASC_SymbolDataPackSafePercent(width_price, f.middle_band.last_closed_value);
      double price = iClose(symbol, timeframe, ASC_SDP_INDICATOR_BAR_CLOSED);
      f.position_percent_last_closed = (width_price != 0.0 ? ((price - f.lower_band.last_closed_value) / width_price) * 100.0 : 0.0);
     }
   if(handle_value != INVALID_HANDLE) IndicatorRelease(handle_value);
   return (ok_middle && ok_upper && ok_lower);
  }

struct ASC_SymbolDataPackAdxFacts
  {
   ASC_SymbolDataPackIndicatorValuePair adx_value;
   ASC_SymbolDataPackIndicatorValuePair plus_di_value;
   ASC_SymbolDataPackIndicatorValuePair minus_di_value;
  };

bool ASC_SymbolDataPackReadADXFacts(const string symbol,const ENUM_TIMEFRAMES timeframe,ASC_SymbolDataPackAdxFacts &f)
  {
   ASC_SymbolDataPackInitIndicatorValuePair(f.adx_value, "ADX / DI Facts", "ADX", timeframe, ASC_SDP_INDICATOR_ADX_PERIOD, ASC_SDP_INDICATOR_ADX_PERIOD + 2);
   ASC_SymbolDataPackInitIndicatorValuePair(f.plus_di_value, "ADX / DI Facts", "+DI", timeframe, ASC_SDP_INDICATOR_ADX_PERIOD, ASC_SDP_INDICATOR_ADX_PERIOD + 2);
   ASC_SymbolDataPackInitIndicatorValuePair(f.minus_di_value, "ADX / DI Facts", "-DI", timeframe, ASC_SDP_INDICATOR_ADX_PERIOD, ASC_SDP_INDICATOR_ADX_PERIOD + 2);
   ResetLastError();
   int handle_value = iADX(symbol, timeframe, ASC_SDP_INDICATOR_ADX_PERIOD);
   bool ok_adx = ASC_SymbolDataPackCopyIndicatorBufferPair(handle_value, 0, f.adx_value);
   bool ok_plus = ASC_SymbolDataPackCopyIndicatorBufferPair(handle_value, 1, f.plus_di_value);
   bool ok_minus = ASC_SymbolDataPackCopyIndicatorBufferPair(handle_value, 2, f.minus_di_value);
   if(handle_value != INVALID_HANDLE) IndicatorRelease(handle_value);
   return (ok_adx && ok_plus && ok_minus);
  }

struct ASC_SymbolDataPackStdDevZScoreFacts
  {
   ASC_SymbolDataPackIndicatorValuePair stddev_value;
   ASC_SymbolDataPackIndicatorValuePair mean_value;
   double price_minus_mean_last_closed;
   double zscore_last_closed;
   string zscore_formula_basis;
   string stddev_zero_guard;
  };

bool ASC_SymbolDataPackReadStdDevZScoreFacts(const string symbol,const ENUM_TIMEFRAMES timeframe,ASC_SymbolDataPackStdDevZScoreFacts &f)
  {
   ASC_SymbolDataPackInitIndicatorValuePair(f.stddev_value, "StdDev / Z-Score Facts", "standard_deviation", timeframe, ASC_SDP_INDICATOR_STDDEV_PERIOD, ASC_SDP_INDICATOR_STDDEV_PERIOD + 2);
   ASC_SymbolDataPackInitIndicatorValuePair(f.mean_value, "StdDev / Z-Score Facts", "mean_SMA_20", timeframe, ASC_SDP_INDICATOR_ZSCORE_PERIOD, ASC_SDP_INDICATOR_ZSCORE_PERIOD + 2);
   f.price_minus_mean_last_closed = 0.0;
   f.zscore_last_closed = 0.0;
   f.zscore_formula_basis = "z_score=(current_price-mean_price)/standard_deviation";
   f.stddev_zero_guard = "standard_deviation_zero_guard";
   ResetLastError();
   int std_handle = iStdDev(symbol, timeframe, ASC_SDP_INDICATOR_STDDEV_PERIOD, 0, MODE_SMA, ASC_SDP_INDICATOR_APPLIED_PRICE);
   bool ok_std = ASC_SymbolDataPackCopyIndicatorBufferPair(std_handle, 0, f.stddev_value);
   if(std_handle != INVALID_HANDLE) IndicatorRelease(std_handle);
   ResetLastError();
   int ma_handle = iMA(symbol, timeframe, ASC_SDP_INDICATOR_ZSCORE_PERIOD, 0, MODE_SMA, ASC_SDP_INDICATOR_APPLIED_PRICE);
   bool ok_mean = ASC_SymbolDataPackCopyIndicatorBufferPair(ma_handle, 0, f.mean_value);
   if(ma_handle != INVALID_HANDLE) IndicatorRelease(ma_handle);
   if(ok_std && ok_mean)
     {
      double price = iClose(symbol, timeframe, ASC_SDP_INDICATOR_BAR_CLOSED);
      f.price_minus_mean_last_closed = price - f.mean_value.last_closed_value;
      f.zscore_last_closed = (f.stddev_value.last_closed_value != 0.0 ? f.price_minus_mean_last_closed / f.stddev_value.last_closed_value : 0.0);
     }
   return (ok_std && ok_mean && f.stddev_value.last_closed_value != 0.0);
  }

bool ASC_SymbolDataPackIndicatorTimeframeIsDue(const datetime last_closed_bar_time,const datetime last_refresh_time)
  {
   if(last_closed_bar_time <= 0) return false;
   if(last_refresh_time <= 0) return true;
   return (last_closed_bar_time > last_refresh_time);
  }

// RUN169R source closeout and RUN170R live contract finalization.
// Declarative only: no dispatcher activation, no writer activation, no rank/formula/main-artifact mutation.
#define ASC_SDP_RUN169_CLOSEOUT_CONTRACT "lite_source_sequence_coherent_enough_for_RUN170_live_proof_with_no_live_claim"
#define ASC_SDP_RUN170_LIVE_CONTRACT "live_proof_research_and_safe_source_repair_only"
#define ASC_SDP_RUN170_SOURCE_IDENTITY_RULE "source_identity_must_match_RUN169R_closeout_or_HOLD_FAIL_by_mismatch"
#define ASC_SDP_RUN170_CAPTURE_RULE "capture_scanner_status_artifact_manifest_symbol_data_pack_outputs_functionresults_timer_logs_errors_and_protected_area_evidence"
#define ASC_SDP_RUN170_PASS_RULE "pass_requires_visible_sections_or_truthful_pending_not_due_last_good_hard_absence_states_no_fake_complete"
#define ASC_SDP_RUN170_HOLD_RULE "hold_for_incomplete_capture_dormant_output_compile_absence_or_patchable_safe_source_gap"
#define ASC_SDP_RUN170_FAIL_RULE "fail_for_source_mismatch_corrupt_runtime_fake_complete_signal_leakage_fileio_break_or_protected_area_regression"
#define ASC_SDP_RUN170_SAFE_REPAIR_RULE "repair_only_proof_surface_token_health_mapping_path_diagnostic_bounded_retry_control_report_guidebook_version_identity_gaps"
#define ASC_SDP_RUN170_FORBIDDEN_REPAIR_RULE "no_strategy_execution_rank_order_formula_marketboard_top5_globaltop10_fileio_heartbeat_broad_hud_trade_history_or_full_universe_activation"

string ASC_SymbolDataPackRun170LiveContractText()
  {
   string text = "RUN170 Live Proof Contract\n";
   text += string(ASC_SDP_RUN170_SOURCE_IDENTITY_RULE) + "\n";
   text += string(ASC_SDP_RUN170_LIVE_CONTRACT) + "\n";
   text += string(ASC_SDP_RUN170_FORBIDDEN_REPAIR_RULE) + "\n\n";
   text += "| Contract Item | Required Evidence | PASS | HOLD | FAIL | Guard |\n";
   text += "|---|---|---|---|---|---|\n";
   text += "| source identity | version label, current run, next live run, package lineage | RUN169R closeout identity visible and RUN170 next-live marker present | compile output absent but source files coherent | source identity mismatch | no source-only live proof inflation |\n";
   text += "| output existence | Symbol Data Pack Lite final/temp/last-good path evidence if activated | expected one-file-per-symbol output exists or dormant mode truthfully explains none | output absent due dormant/shadow mode or capture gap | fake path, rootless path, or broken package | preserve one-file-per-symbol law |\n";
   text += "| required sections | writer token validation and output content | all required sections visible or truthfully marked pending/not_due/last_good/hard_absence_proven | recoverable missing token or incomplete capture | fake complete or lazy unavailable default | writer tokens block silent gaps |\n";
   text += "| health maps | completeness/freshness/retry/hydration/last-good/publication health | health section visible and states preserve uncertainty | collecting/retrying/buffer_loading with bounded retry evidence | hard absence without proof | health is context only |\n";
   text += "| timer pressure | heartbeat/timer telemetry and FunctionResults | bounded proof capture, no heavy every-heartbeat requirement | timer pressure unclear but no instability shown | unstable loop or proof spam | MQL5 timer events do not stack |\n";
   text += "| API loading states | CopyBuffer/CopyRates/CopyTicks/BarsCalculated/Bars/SeriesInfoInteger evidence | partial/loading/sync states classified | insufficient history or buffer loading is bounded | first miss converted to hard absence | no hidden retry storm |\n";
   text += "| protected areas | file list and runtime evidence | FileIO, Dossier, Market Board, Top5, GlobalTop10, HUD, strategy/execution untouched | evidence missing but source diff clean | protected area mutation or signal leakage | Lite Pack remains data infrastructure |\n\n";
   text += "RUN170 Capture Surface Checklist\n";
   text += "| Capture Surface | Exact Path / Pattern | Why Required | If Missing |\n";
   text += "|---|---|---|---|\n";
   text += "| Scanner Status | server-root scanner status artifact | proves runtime posture and source identity | HOLD unless absence proves disabled capture |\n";
   text += "| Artifact Bundle Manifest | server-root artifact manifest | proves bundle paths and publication context | HOLD for capture gap |\n";
   text += "| Symbol Data Pack Lite outputs | server-root/Symbol Data Packs/*_SYMBOL_DATA_PACK.txt | proves one-file-per-symbol contract | HOLD if dormant/shadow mode explains none, FAIL if expected output path broken |\n";
   text += "| Symbol Data Pack temp/final/last-good evidence | *_SYMBOL_DATA_PACK.txt and .tmp where generated | proves atomic/no-change/continuity behavior | HOLD if not generated by dormant mode |\n";
   text += "| FunctionResults logs | logs/function-results pattern | proves writer/token/timer/API outcomes | HOLD if package omitted logs |\n";
   text += "| Experts/Journal errors | MT5 Experts and Journal exports if available | proves runtime failures or quiet run | HOLD if unavailable, FAIL if critical protected-area errors found |\n";
   text += "| heartbeat/timer telemetry | runtime timing/function logs | proves bounded timer pressure | HOLD if unmeasured, FAIL if unstable loop |\n";
   text += "| protected-area evidence | source diff plus artifact timestamps | proves no main artifact/rank/HUD/FileIO mutation | FAIL on unexpected mutation |\n\n";
   text += "RUN170 Safe Source Repair Rule\n";
   text += "| Live Blocker Type | Patch Allowed In RUN170 | Repair Boundary | Required Evidence |\n";
   text += "|---|---:|---|---|\n";
   text += "| proof-surface detection bug | true | diagnostic/capture/source-visible correction only | live output shows missing or mislabelled proof surface |\n";
   text += "| writer token validation bug | true | required token list or first-missing-token visibility only | payload contains lawful section but validator blocks wrong token |\n";
   text += "| health mapping wording gap | true | state mapping/wording only, no calculation expansion | live state cannot distinguish partial/loading/not_due/last_good |\n";
   text += "| output path contract bug | true | path contract/manifest/report correction only | generated path differs from contract |\n";
   text += "| bounded retry/hydration gap | true | classify recoverable state, no cadence rewrite | CopyBuffer/CopyRates/CopyTicks/Bars/SeriesInfo evidence |\n";
   text += "| strategy/execution/rank/formula request | false | forbidden | any request to alter strategy/execution/rank/order/formula |\n";
   text += "| broad FileIO/HUD/heartbeat rewrite | false | forbidden | protected-area mutation would be required |\n\n";
   text += "RUN169 Closeout Boundary: " + string(ASC_SDP_RUN169_CLOSEOUT_CONTRACT) + "\n";
   text += "RUN170 Source Identity Rule: " + string(ASC_SDP_RUN170_SOURCE_IDENTITY_RULE) + "\n";
   text += "RUN170 Safe Repair Rule: " + string(ASC_SDP_RUN170_SAFE_REPAIR_RULE) + "\n";
   text += "RUN170 Forbidden Repair Rule: " + string(ASC_SDP_RUN170_FORBIDDEN_REPAIR_RULE) + "\n\n";
   return text;
  }
#endif
