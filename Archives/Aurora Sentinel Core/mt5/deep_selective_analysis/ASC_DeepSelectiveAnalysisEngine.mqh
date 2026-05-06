#ifndef __ASC_DEEP_SELECTIVE_ANALYSIS_ENGINE_MQH__
#define __ASC_DEEP_SELECTIVE_ANALYSIS_ENGINE_MQH__

#include "../market_state/ASC_MarketStateEngine.mqh"
#include "../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"
#include "../shortlist_selection/ASC_ShortlistSelectionEngine.mqh"
#include "../menu/ASC_TraderControlRegistry.mqh"
#include "../artifacts/ASC_ArtifactTextHelpers.mqh"

struct ASC_DeepSelectiveAnalysisResult
  {
   bool built;
   bool lawful;
   string symbol;
   string canonical_symbol;
   string entitlement_state;
   string entitlement_reason;
   string freshness_posture;
   string continuity_posture;
   string preservation_state;
   string preservation_reason;
   string reset_reason;
   datetime last_refreshed_utc;
   int enabled_timeframe_count;
   int total_bars_requested;
   int total_bars_copied;
   string rates_support_status;
   string rates_partial_reason;
   string rates_unavailable_reason;
   string rates_window_age;
   string rates_sync_status;
   string rates_complete_support;
   int tick_window_requested;
   int tick_window_copied;
   string ticks_support_status;
   string ticks_partial_reason;
   string ticks_unavailable_reason;
   string ticks_window_age;
   string ticks_sync_status;
   string ticks_complete_support;
   int spread_window_requested;
   int spread_window_copied;
   string timeframe_requested;
   string timeframe_available;
   string sample_size_status;
   string sample_window_age;
   string sample_limit_reason;
   string partial_timeframe_reason;
   string unavailable_timeframe_reason;
   string summary_line;
   string block_text;
   string execution_context;
   string shortlist_context;
   int shortlist_rank;
   string market_state_context;
   string support_posture;
   string build_context;
   string data_tier;
   string l5_support_posture;
   string rates_status;
   string ticks_status;
   string timeframe_coverage;
   string data_window_age;
   string sample_status;
   string l3_l4_authority;
   string resolver_limit;
   string artifact_projection;
   string tactical_snapshot_summary;
   string structure_liquidity_summary;
   string session_timing_summary;
   string score_context_summary;
   string microstructure_summary;
   double tick_bias_now;
   double tick_bias_prev_window;
   double tick_shift;
   double pressure_shift_score;
   string pressure_shift_posture;
   double momentum_delta;
   double momentum_speed;
   double momentum_acceleration_score;
   string momentum_acceleration_posture;
   int time_since_last_impulse_sec;
   int impulse_count_window;
   double move_age_score;
   string move_age_posture;
   double position_in_range_pct;
   double distance_to_recent_high_pct;
   double distance_to_recent_low_pct;
   double liquidity_proximity_score;
   string liquidity_zone;
   string liquidity_proximity_posture;
   double participation_score;
   double participation_delta;
   string participation_posture;
   string participation_state;
   double execution_score;
   double execution_penalty;
   string execution_posture;
   double spread_quality_score;
   double friction_quality_score;
   double liquidity_quality_score;
   bool tick_burst_flag;
   double tick_burst_score;
   string tick_burst_posture;
   string scalp_tradable;
   string intraday_tradable;
   string short_term_bias;
   string mid_term_bias;
   string higher_timeframe_bias;
   string alignment;
   string micro_direction;
   string micro_conviction;
   string impulse_state;
   string sweep_state;
   double session_sweep_score;
   string session_sweep_state;
   double failed_break_score;
   string failed_break_state;
   double reclaim_score;
   string reclaim_state;
   double trap_pressure_score;
   string trap_pressure_state;
   double pullback_depth_score;
   double pullback_quality_score;
   string pullback_state;
   double continuation_readiness_score;
   string continuation_state;
   double reversal_pressure_score;
   string reversal_state;
   double move_freshness_score;
   string freshness_state;
   string siam_tactical_summary;
   int upward_timeframe_count;
   int downward_timeframe_count;
   int expansion_timeframe_count;
   int compression_timeframe_count;
   double siam_breakout_fit_score;
   double siam_pullback_fit_score;
   double siam_reversal_fit_score;
   double siam_range_fit_score;
   double siam_trend_continuation_fit_score;
   double siam_fakeout_fit_score;
   string siam_fit_summary;
   string siam_primary_fit;
   double siam_primary_fit_score;
   string siam_primary_fit_posture;
   string siam_primary_fit_reason;
   string siam_secondary_fit;
   double siam_secondary_fit_score;
   string siam_secondary_fit_posture;
   string siam_secondary_fit_reason;
   double siam_fit_gap_score;
   string siam_fit_gap_posture;
   string path_quality_summary;
   string siam_setup_fit_caution;
   string siam_setup_fit_conclusion;
   string failure_invalidation_summary;
   string invalidation_trigger_summary;
   string confidence_break_summary;
   string vulnerability_summary;
   string path_split_state;
   string path_split_summary;
   string path_contest_summary;
  };

string ASC_DeepTimeframeLabel(const ENUM_TIMEFRAMES timeframe)
  {
   switch(timeframe)
     {
      case PERIOD_M1:  return "M1";
      case PERIOD_M5:  return "M5";
      case PERIOD_M15: return "M15";
      case PERIOD_H1:  return "H1";
      case PERIOD_H4:  return "H4";
      case PERIOD_D1:  return "D1";
     }
   return "unknown";
  }

int ASC_DeepRequestedBars(const ENUM_TIMEFRAMES timeframe)
  {
   switch(timeframe)
     {
      case PERIOD_M1:  return g_asc_trader_controls.deep_tf_m1_bars;
      case PERIOD_M5:  return g_asc_trader_controls.deep_tf_m5_bars;
      case PERIOD_M15: return g_asc_trader_controls.deep_tf_m15_bars;
      case PERIOD_H1:  return g_asc_trader_controls.deep_tf_h1_bars;
      case PERIOD_H4:  return g_asc_trader_controls.deep_tf_h4_bars;
      case PERIOD_D1:  return g_asc_trader_controls.deep_tf_d1_bars;
     }
   return 0;
  }

string ASC_DeepCoverageStatus(const ASC_DeepSelectiveAnalysisResult &result,
                              const int timeframe_count,
                              const bool fallback_timeframes_used)
  {
   if(timeframe_count <= 0)
      return "not_ready";

   bool live_packet_limited = (result.support_posture != "packet_live");
   bool tick_window_limited = (result.tick_window_requested > 0 && result.tick_window_copied < result.tick_window_requested);
   bool spread_window_limited = (result.spread_window_requested > 0 && result.spread_window_copied < result.spread_window_requested);
   bool directional_split_limited = (result.upward_timeframe_count <= 0 || result.downward_timeframe_count <= 0);
   bool compression_split_limited = (result.expansion_timeframe_count <= 0 || result.compression_timeframe_count <= 0);
   bool tier_limited = (result.data_tier != "tier_1_full_deep");

   if(!fallback_timeframes_used
      && !live_packet_limited
      && !tick_window_limited
      && !spread_window_limited
      && !directional_split_limited
      && !compression_split_limited
      && !tier_limited)
      return "full_enough_for_deep_support";

   return "partial_but_lawful_deep_support";
  }

string ASC_DeepCoverageLimitations(const ASC_DeepSelectiveAnalysisResult &result,
                                   const int timeframe_count,
                                   const bool fallback_timeframes_used)
  {
   string limitations = "";

   if(timeframe_count <= 0)
      return "enabled timeframes are unavailable";

   if(fallback_timeframes_used)
      limitations += "safe timeframe fallback used; ";

   if(result.support_posture != "packet_live")
      limitations += StringFormat("support posture %s limits live-packet confidence; ", result.support_posture);

   if(result.tick_window_requested > 0 && result.tick_window_copied < result.tick_window_requested)
      limitations += StringFormat("tick window copied %d/%d; ", result.tick_window_copied, result.tick_window_requested);

   if(result.spread_window_requested > 0 && result.spread_window_copied < result.spread_window_requested)
      limitations += StringFormat("spread samples copied %d/%d; ", result.spread_window_copied, result.spread_window_requested);

   if(result.upward_timeframe_count <= 0 || result.downward_timeframe_count <= 0)
      limitations += StringFormat("bias split up/down=%d/%d; ", result.upward_timeframe_count, result.downward_timeframe_count);

   if(result.expansion_timeframe_count <= 0 || result.compression_timeframe_count <= 0)
      limitations += StringFormat("structure split expansion/compression=%d/%d; ", result.expansion_timeframe_count, result.compression_timeframe_count);

   if(result.data_tier != "tier_1_full_deep")
      limitations += StringFormat("data tier %s; ", result.data_tier);

   StringTrimRight(limitations);
   while(StringLen(limitations) > 0 && StringSubstr(limitations, StringLen(limitations) - 1) == ";")
     {
      limitations = StringSubstr(limitations, 0, StringLen(limitations) - 1);
      StringTrimRight(limitations);
     }

   if(StringLen(limitations) <= 0)
      return "no material coverage limitations detected";

   return limitations;
  }

string ASC_DeepRatesStatusFromCoverage(const int timeframe_count,
                                       const int complete_timeframes,
                                       const int partial_timeframes,
                                       const int missing_timeframes,
                                       const int total_bars_copied)
  {
   if(timeframe_count <= 0)
      return "not_requested";
   if(total_bars_copied <= 0 || missing_timeframes >= timeframe_count)
      return "unavailable";
   if(missing_timeframes > 0 || partial_timeframes > 0 || complete_timeframes < timeframe_count)
      return "partial";
   return "complete";
  }

string ASC_DeepTicksStatusFromCopies(const int requested_ticks,const int copied_ticks)
  {
   if(requested_ticks <= 0)
      return "not_requested";
   if(copied_ticks <= 0)
      return "unavailable";
   if(copied_ticks < requested_ticks)
      return "partial";
   return "complete";
  }

string ASC_DeepTimeframeCoverageToken(const int timeframe_count,
                                      const int complete_timeframes,
                                      const int partial_timeframes,
                                      const int missing_timeframes)
  {
   if(timeframe_count <= 0)
      return "not_applicable";
   if(missing_timeframes >= timeframe_count)
      return "missing";
   if(missing_timeframes > 0 || partial_timeframes > 0 || complete_timeframes < timeframe_count)
      return "partial";
   return "complete";
  }

string ASC_DeepSampleStatusToken(const string rates_status,
                                 const string ticks_status,
                                 const int sufficient_timeframes,
                                 const int timeframe_count)
  {
   if(rates_status == "unavailable" && ticks_status == "unavailable")
      return "insufficient";
   if(timeframe_count > 0 && sufficient_timeframes < timeframe_count)
      return "insufficient";
   if(rates_status == "partial" || ticks_status == "partial")
      return "insufficient";
   if(rates_status == "complete" || ticks_status == "complete")
      return "sufficient";
   return "unknown";
  }

string ASC_DeepCompleteSupportToken(const string status)
  {
   return (status == "complete") ? "true" : "false";
  }

string ASC_DeepRatesPartialReasonToken(const int requested_bars,
                                      const int copied_bars,
                                      const int complete_timeframes,
                                      const int partial_timeframes,
                                      const int missing_timeframes)
  {
   if(requested_bars <= 0)
      return "not_requested";
   if(copied_bars <= 0 || missing_timeframes > 0)
      return StringFormat("missing_timeframes=%d", missing_timeframes);
   if(partial_timeframes > 0)
      return StringFormat("partial_timeframes=%d", partial_timeframes);
   if(complete_timeframes <= 0)
      return "no_complete_timeframe";
   return "none";
  }

string ASC_DeepRatesUnavailableReasonToken(const int requested_bars,
                                           const int copied_bars,
                                           const int missing_timeframes)
  {
   if(requested_bars <= 0)
      return "not_requested";
   if(copied_bars <= 0)
      return "copyrates_returned_no_bars_or_error";
   if(missing_timeframes > 0)
      return StringFormat("missing_timeframes=%d", missing_timeframes);
   return "none";
  }

string ASC_DeepTicksPartialReasonToken(const int requested_ticks,const int copied_ticks)
  {
   if(requested_ticks <= 0)
      return "not_requested";
   if(copied_ticks <= 0)
      return "copyticks_returned_no_ticks_or_error";
   if(copied_ticks < requested_ticks)
      return StringFormat("partial_tick_window=%d/%d", copied_ticks, requested_ticks);
   return "none";
  }

string ASC_DeepTicksUnavailableReasonToken(const int requested_ticks,const int copied_ticks)
  {
   if(requested_ticks <= 0)
      return "not_requested";
   if(copied_ticks <= 0)
      return "copyticks_returned_no_ticks_or_error";
   return "none";
  }

string ASC_DeepSampleLimitReasonToken(const string rates_status,
                                      const string ticks_status,
                                      const int sufficient_timeframes,
                                      const int timeframe_count)
  {
   if(timeframe_count <= 0)
      return "timeframes_not_requested";
   if(sufficient_timeframes < timeframe_count)
      return StringFormat("sufficient_timeframes=%d/%d", sufficient_timeframes, timeframe_count);
   if(rates_status == "partial" || rates_status == "unavailable")
      return "rates_support_limited";
   if(ticks_status == "partial" || ticks_status == "unavailable")
      return "ticks_support_limited";
   return "none";
  }

string ASC_DeepTimeframeBoundaryReasonToken(const int timeframe_count,
                                            const int partial_timeframes,
                                            const int missing_timeframes)
  {
   if(timeframe_count <= 0)
      return "not_requested";
   if(missing_timeframes > 0)
      return StringFormat("missing_timeframes=%d/%d", missing_timeframes, timeframe_count);
   if(partial_timeframes > 0)
      return StringFormat("partial_timeframes=%d/%d", partial_timeframes, timeframe_count);
   return "none";
  }

string ASC_DeepResolverLimitToken(const ASC_DeepSelectiveAnalysisResult &result)
  {
   if(result.rates_status == "unavailable")
      return "rates_unavailable";
   if(result.ticks_status == "unavailable")
      return "ticks_unavailable";
   if(result.sample_status == "insufficient")
      return "sample_insufficient";
   if(result.timeframe_coverage == "missing")
      return "timeframe_missing";
   if(result.ticks_status == "partial")
      return "tick_window_missing";
   if(result.continuity_posture == "continuity")
      return "retained_support";
   if(result.freshness_posture == "Stale" || result.freshness_posture == "Degraded")
      return "persistent_unavailable";
   return "none";
  }

string ASC_DeepL5SupportPostureToken(const ASC_DeepSelectiveAnalysisResult &result)
  {
   if(result.rates_status == "unavailable")
      return "rates_unavailable";
   if(result.ticks_status == "unavailable")
      return "ticks_unavailable";
   if(result.timeframe_coverage == "missing")
      return "timeframe_missing";
   if(result.sample_status == "insufficient")
      return "sample_insufficient";
   if(result.continuity_posture == "continuity")
      return "retained_support";
   if(result.support_posture == "packet_continuity_backed")
      return "retained_support";
   if(result.support_posture == "packet_degraded_or_stale" || result.data_window_age == "stale")
      return "degraded_support";
   if(result.data_tier == "tier_2_historical_only_deep")
      return "historical_only_support";
   if(result.rates_status == "partial" || result.ticks_status == "partial" || result.timeframe_coverage == "partial")
      return "fresh_partial_support";
   if(result.rates_status == "complete" && result.ticks_status == "complete" && result.timeframe_coverage == "complete" && result.data_window_age == "fresh")
      return "fresh_full_support";
   return "degraded_support";
  }

string ASC_DeepAuthorityToken(const ASC_DeepSelectiveAnalysisResult &result)
  {
   if(result.l5_support_posture == "fresh_full_support")
      return "clean";
   if(result.l5_support_posture == "fresh_partial_support" || result.l5_support_posture == "historical_only_support" || result.l5_support_posture == "retained_support")
      return "limited";
   if(result.l5_support_posture == "degraded_support")
      return "degraded";
   if(result.l5_support_posture == "rates_unavailable" || result.l5_support_posture == "ticks_unavailable" || result.l5_support_posture == "sample_insufficient")
      return "blocked";
   return "unknown";
  }

string ASC_DeepArtifactProjectionToken(const ASC_DeepSelectiveAnalysisResult &result)
  {
   if(result.l5_support_posture == "fresh_full_support")
      return "allowed";
   if(result.l5_support_posture == "fresh_partial_support"
      || result.l5_support_posture == "historical_only_support"
      || result.l5_support_posture == "retained_support"
      || result.l5_support_posture == "degraded_support")
      return "qualified";
   return "blocked";
  }


string ASC_DeepMetricInputSourceToken(const ASC_DeepSelectiveAnalysisResult &result)
  {
   if(result.rates_status == "complete" && result.ticks_status == "complete")
      return "mixed";
   if(result.rates_status == "complete" && result.ticks_status != "complete")
      return "copyrates";
   if(result.ticks_status == "complete" && result.rates_status != "complete")
      return "copyticks";
   if(result.support_posture == "packet_continuity_backed")
      return "retained";
   return "unknown";
  }

string ASC_DeepMetricTickWindowStatusToken(const ASC_DeepSelectiveAnalysisResult &result)
  {
   if(result.ticks_status == "complete")
      return "complete";
   if(result.ticks_status == "partial")
      return "partial";
   if(result.ticks_status == "missing" || result.ticks_status == "unavailable")
      return "missing";
   return "unknown";
  }

string ASC_DeepMetricValidityStatusToken(const ASC_DeepSelectiveAnalysisResult &result)
  {
   if(result.l5_support_posture == "fresh_full_support")
      return "valid";
   if(result.l5_support_posture == "fresh_partial_support" || result.l5_support_posture == "historical_only_support" || result.l5_support_posture == "retained_support")
      return "limited";
   if(result.l5_support_posture == "degraded_support")
      return "degraded";
   if(result.l5_support_posture == "rates_unavailable" || result.l5_support_posture == "ticks_unavailable" || result.l5_support_posture == "sample_insufficient")
      return "unavailable";
   return "unknown";
  }

string ASC_DeepMetricFalsifierToken(const ASC_DeepSelectiveAnalysisResult &result)
  {
   if(result.data_window_age == "stale" || result.l5_support_posture == "retained_support" || result.l5_support_posture == "degraded_support")
      return "stale_input";
   if(result.sample_status == "insufficient")
      return "insufficient_sample";
   if(result.timeframe_coverage == "missing" || result.timeframe_coverage == "partial")
      return "missing_timeframe";
   if(result.ticks_status == "missing" || result.ticks_status == "partial" || result.ticks_status == "unavailable")
      return "missing_ticks";
   if(result.rates_status == "missing" || result.rates_status == "partial" || result.rates_status == "unavailable")
      return "unavailable_dependency";
   return "not_applicable";
  }

string ASC_DeepSupportProofTokens(const ASC_DeepSelectiveAnalysisResult &result)
  {
   string validity_status = ASC_DeepMetricValidityStatusToken(result);
   string falsifier = ASC_DeepMetricFalsifierToken(result);
   return "metric_domain=l5_deep | metric_purpose=deep_selected_support | metric_owner=ASC_DeepSelectiveAnalysisEngine.ASC_RunDeepSelectiveAnalysis | input_source=" + ASC_DeepMetricInputSourceToken(result)
          + " | l5_meaning=deep_selected_symbol_analysis_only | l5_scope=selected_symbol_depth_context"
          + " | trade_permission=false | entry_signal=false | execution_permission=false | final_trade_decision=false | strategy_edge_proof=false"
          + " | complete_evidence=false | l5_not_complete_evidence=true | l5_not_decisive_when_partial=true"
          + " | built_does_not_mean_fresh=true | lawful_does_not_mean_complete_support=true | source_supported_not_runtime_observed=source_patched_live_unproven"
          + " | l5_not_implied_by_rank=true | selected_symbol_requires_l5_for_depth=true | l5_runs_selected_symbol_only=true | l5_not_market_board_truth_owner=true | l5_not_globaltop10_truth_owner=true"
          + " | artifact_projection=projection_only | dossier_l5_projection=consumer_only | current_focus_l5_projection=mirror_only_if_selected_symbol_exists | writers_do_not_own_l5_truth=true"
          + StringFormat(" | built_status=%s | lawful_status=%s",
                         result.built ? "built" : "not_built",
                         result.lawful ? "lawful" : "blocked")
          + StringFormat(" | freshness_status=%s | support_posture=%s | rates_status=%s | rates_requested=%d | rates_copied=%d | rates_support_status=%s | rates_partial_reason=%s | rates_unavailable_reason=%s | rates_window_age=%s | rates_history_sync_status=%s | rates_complete_support=%s",
                         result.l5_support_posture,
                         result.l5_support_posture,
                         result.rates_status,
                         result.total_bars_requested,
                         result.total_bars_copied,
                         result.rates_support_status,
                         result.rates_partial_reason,
                         result.rates_unavailable_reason,
                         result.rates_window_age,
                         result.rates_sync_status,
                         result.rates_complete_support)
          + StringFormat(" | ticks_status=%s | ticks_requested=%d | ticks_copied=%d | ticks_support_status=%s | ticks_partial_reason=%s | ticks_unavailable_reason=%s | ticks_window_age=%s | ticks_sync_status=%s | ticks_complete_support=%s",
                         result.ticks_status,
                         result.tick_window_requested,
                         result.tick_window_copied,
                         result.ticks_support_status,
                         result.ticks_partial_reason,
                         result.ticks_unavailable_reason,
                         result.ticks_window_age,
                         result.ticks_sync_status,
                         result.ticks_complete_support)
          + StringFormat(" | timeframe_coverage=%s | timeframe_requested=%s | timeframe_available=%s | tick_window_status=%s | data_window_age=%s | sample_status=%s | sample_size_status=%s | sample_window_age=%s | sample_limit_reason=%s | partial_timeframe_reason=%s | unavailable_timeframe_reason=%s | validity_status=%s | falsifier=%s | l3_l4_authority=%s | resolver_limit=%s | runtime_artifact_projection=%s | behavior_change=no",
                         result.timeframe_coverage,
                         result.timeframe_requested,
                         result.timeframe_available,
                         ASC_DeepMetricTickWindowStatusToken(result),
                         result.data_window_age,
                         result.sample_status,
                         result.sample_size_status,
                         result.sample_window_age,
                         result.sample_limit_reason,
                         result.partial_timeframe_reason,
                         result.unavailable_timeframe_reason,
                         validity_status,
                         falsifier,
                         result.l3_l4_authority,
                         result.resolver_limit,
                         result.artifact_projection);
  }
int ASC_DeepCollectEnabledTimeframes(ENUM_TIMEFRAMES &timeframes[])
  {
   ArrayResize(timeframes, 0);

   ENUM_TIMEFRAMES supported[6] =
     {
      PERIOD_M1,
      PERIOD_M5,
      PERIOD_M15,
      PERIOD_H1,
      PERIOD_H4,
      PERIOD_D1
     };

   for(int i = 0; i < 6; i++)
     {
      int requested = ASC_DeepRequestedBars(supported[i]);
      if(requested <= 0)
         continue;
      int next = ArraySize(timeframes);
      ArrayResize(timeframes, next + 1);
      timeframes[next] = supported[i];
     }

  return ArraySize(timeframes);
  }

int ASC_DeepCollectSafeFallbackTimeframes(ENUM_TIMEFRAMES &timeframes[])
  {
   ArrayResize(timeframes, 3);
   timeframes[0] = PERIOD_M15;
   timeframes[1] = PERIOD_H1;
   timeframes[2] = PERIOD_H4;
   return ArraySize(timeframes);
  }

void ASC_DeepInitResult(ASC_DeepSelectiveAnalysisResult &result)
  {
   result.built = false;
   result.lawful = false;
   result.symbol = "";
   result.canonical_symbol = "";
   result.entitlement_state = "NO_SELECTED_SYMBOL";
   result.entitlement_reason = "selected symbol is not yet entitled for Deep Analysis";
   result.freshness_posture = "Unavailable";
   result.continuity_posture = "not_run";
   result.preservation_state = "not_run";
   result.preservation_reason = "Deep Analysis has not been completed for this symbol in the active runtime";
   result.reset_reason = "awaiting explicit Deep Analysis request";
   result.last_refreshed_utc = 0;
   result.enabled_timeframe_count = 0;
   result.total_bars_requested = 0;
   result.total_bars_copied = 0;
   result.rates_support_status = "not_requested";
   result.rates_partial_reason = "not_requested";
   result.rates_unavailable_reason = "not_requested";
   result.rates_window_age = "unknown";
   result.rates_sync_status = "not_observed";
   result.rates_complete_support = "false";
   result.tick_window_requested = 0;
   result.tick_window_copied = 0;
   result.ticks_support_status = "not_requested";
   result.ticks_partial_reason = "not_requested";
   result.ticks_unavailable_reason = "not_requested";
   result.ticks_window_age = "unknown";
   result.ticks_sync_status = "not_observed";
   result.ticks_complete_support = "false";
   result.spread_window_requested = 0;
   result.spread_window_copied = 0;
   result.timeframe_requested = "0";
   result.timeframe_available = "0";
   result.sample_size_status = "unknown";
   result.sample_window_age = "unknown";
   result.sample_limit_reason = "not_built";
   result.partial_timeframe_reason = "not_requested";
   result.unavailable_timeframe_reason = "not_requested";
   result.summary_line = "deep analysis has not been built";
   result.block_text = "";
   result.execution_context = "explicit_selected_symbol_override";
   result.shortlist_context = "unknown";
   result.shortlist_rank = 0;
   result.market_state_context = "unknown";
  result.support_posture = "unknown";
  result.build_context = "not_run";
   result.data_tier = "tier_0_not_run";
   result.tick_bias_now = 0.0;
   result.tick_bias_prev_window = 0.0;
   result.tick_shift = 0.0;
   result.pressure_shift_score = 50.0;
   result.pressure_shift_posture = "unavailable";
   result.momentum_delta = 0.0;
   result.momentum_speed = 50.0;
   result.momentum_acceleration_score = 50.0;
   result.momentum_acceleration_posture = "unavailable";
   result.time_since_last_impulse_sec = -1;
   result.impulse_count_window = -1;
   result.move_age_score = 50.0;
   result.move_age_posture = "unavailable";
   result.position_in_range_pct = 50.0;
   result.distance_to_recent_high_pct = -1.0;
   result.distance_to_recent_low_pct = -1.0;
   result.liquidity_proximity_score = 50.0;
   result.liquidity_zone = "unavailable";
   result.liquidity_proximity_posture = "unavailable";
   result.participation_score = 50.0;
   result.participation_delta = 0.0;
   result.participation_posture = "unavailable";
   result.participation_state = "unavailable";
   result.execution_score = 50.0;
   result.execution_penalty = 50.0;
   result.execution_posture = "unavailable";
   result.spread_quality_score = 50.0;
   result.friction_quality_score = 50.0;
   result.liquidity_quality_score = 50.0;
   result.tick_burst_flag = false;
   result.tick_burst_score = 50.0;
   result.tick_burst_posture = "unavailable";
   result.scalp_tradable = "no";
   result.intraday_tradable = "no";
   result.short_term_bias = "unavailable";
   result.mid_term_bias = "unavailable";
   result.higher_timeframe_bias = "unavailable";
   result.alignment = "unavailable";
   result.micro_direction = "unavailable";
   result.micro_conviction = "unavailable";
   result.impulse_state = "unavailable";
   result.sweep_state = "none";
   result.session_sweep_score = 50.0;
   result.session_sweep_state = "unavailable";
   result.failed_break_score = 50.0;
   result.failed_break_state = "unavailable";
   result.reclaim_score = 50.0;
   result.reclaim_state = "unavailable";
   result.trap_pressure_score = 50.0;
   result.trap_pressure_state = "unavailable";
   result.pullback_depth_score = 50.0;
   result.pullback_quality_score = 50.0;
   result.pullback_state = "unavailable";
   result.continuation_readiness_score = 50.0;
   result.continuation_state = "unavailable";
   result.reversal_pressure_score = 50.0;
   result.reversal_state = "unavailable";
   result.move_freshness_score = 50.0;
   result.freshness_state = "unavailable";
   result.siam_tactical_summary = "siam tactical summary unavailable";
   result.upward_timeframe_count = 0;
   result.downward_timeframe_count = 0;
   result.expansion_timeframe_count = 0;
   result.compression_timeframe_count = 0;
   result.siam_breakout_fit_score = 50.0;
   result.siam_pullback_fit_score = 50.0;
   result.siam_reversal_fit_score = 50.0;
   result.siam_range_fit_score = 50.0;
   result.siam_trend_continuation_fit_score = 50.0;
   result.siam_fakeout_fit_score = 50.0;
   result.siam_fit_summary = "siam setup-fit unavailable";
   result.siam_primary_fit = "unavailable";
   result.siam_primary_fit_score = 0.0;
   result.siam_primary_fit_posture = "unavailable";
   result.siam_primary_fit_reason = "setup-fit reason unavailable";
   result.siam_secondary_fit = "unavailable";
   result.siam_secondary_fit_score = 0.0;
   result.siam_secondary_fit_posture = "unavailable";
   result.siam_secondary_fit_reason = "setup-fit reason unavailable";
   result.siam_fit_gap_score = 0.0;
   result.siam_fit_gap_posture = "unavailable";
   result.path_quality_summary = "primary path quality is unavailable";
   result.siam_setup_fit_caution = "deep setup-fit is supportive context only";
   result.siam_setup_fit_conclusion = "confirm against shortlist rank, Market Board field context, and live execution before acting";
   result.failure_invalidation_summary = "failure / invalidation path is unavailable";
   result.invalidation_trigger_summary = "active invalidation triggers are unavailable";
   result.confidence_break_summary = "confidence-break path is unavailable";
   result.vulnerability_summary = "current vulnerability is unavailable";
   result.path_split_state = "unresolved";
   result.path_split_summary = "active path split is unavailable";
   result.path_contest_summary = "active contest between paths is unavailable";
  }

double ASC_DeepClampScore(const double value)
  {
   return MathMax(0.0, MathMin(100.0, value));
  }

double ASC_DeepRoundScore(const double value)
  {
   return (MathRound(ASC_DeepClampScore(value) * 10.0) / 10.0);
  }

string ASC_DeepSiamFitPosture(const double score)
  {
   if(score >= 78.0)
      return "high_fit";
   if(score >= 64.0)
      return "workable_fit";
   if(score >= 50.0)
      return "conditional_fit";
   return "weak_fit";
  }

string ASC_DeepSiamFitReason(const string fit_name,
                             const ASC_ShortlistSymbolSummary &shortlist_entry)
  {
   if(fit_name == "breakout")
      return StringFormat("context %.1f, readiness %.1f, and momentum %.1f currently support continuation pressure",
                          shortlist_entry.filter.context_strength_score,
                          shortlist_entry.filter.entry_readiness_score,
                          shortlist_entry.filter.momentum_acceleration_score);
   if(fit_name == "pullback")
      return StringFormat("context %.1f with execution %.1f and session %.1f favors pullback continuation when extension/exhaustion stay contained",
                          shortlist_entry.filter.context_strength_score,
                          shortlist_entry.filter.execution_alignment_score,
                          shortlist_entry.filter.session_alignment_score);
   if(fit_name == "reversal")
      return StringFormat("pressure shift %.1f and extension/exhaustion profile favor reversal monitoring over continuation chase",
                          shortlist_entry.filter.pressure_shift_score);
   if(fit_name == "range")
      return StringFormat("structure %.1f with moderated momentum %.1f supports range rotation behavior",
                          shortlist_entry.filter.structure_context_score,
                          shortlist_entry.filter.momentum_acceleration_score);
   if(fit_name == "trend_continuation")
      return StringFormat("context %.1f, momentum %.1f, and timing %.1f support trend continuation preference",
                          shortlist_entry.filter.context_strength_score,
                          shortlist_entry.filter.momentum_acceleration_score,
                          shortlist_entry.filter.entry_readiness_score);
   if(fit_name == "fakeout")
      return StringFormat("pressure %.1f with elevated extension/exhaustion supports fakeout and failed-break awareness",
                          shortlist_entry.filter.pressure_shift_score);
   return "setup-fit reason unavailable";
  }

string ASC_DeepFitOperatorName(const string fit_name)
  {
   if(fit_name == "trend_continuation")
      return "trend continuation";
   if(fit_name == "mixed_balanced")
      return "mixed balanced";
   if(fit_name == "bullish_lean")
      return "bullish lean";
   if(fit_name == "bearish_lean")
      return "bearish lean";
   return ASC_ArtifactHumanizeLabel(fit_name);
  }

string ASC_DeepScoreStateLabel(const string state,
                               const double score)
  {
   return StringFormat("%s %.1f", ASC_DeepFitOperatorName(state), score);
  }

string ASC_DeepPullbackReadback(const string state,
                                const double depth_score,
                                const double quality_score)
  {
   return StringFormat("%s | depth %.1f | quality %.1f",
                       ASC_DeepFitOperatorName(state),
                       depth_score,
                       quality_score);
  }

string ASC_DeepCompactBiasSummary(const string short_term_bias,
                                  const string mid_term_bias,
                                  const string higher_timeframe_bias,
                                  const string alignment)
  {
   return StringFormat("short %s | mid %s | higher %s | alignment %s",
                       ASC_DeepFitOperatorName(short_term_bias),
                       ASC_DeepFitOperatorName(mid_term_bias),
                       ASC_DeepFitOperatorName(higher_timeframe_bias),
                       ASC_DeepFitOperatorName(alignment));
  }

string ASC_DeepCompactFitSummary(const double breakout_score,
                                 const double pullback_score,
                                 const double reversal_score,
                                 const double range_score,
                                 const double continuation_score,
                                 const double fakeout_score)
  {
   return StringFormat("breakout %.1f | pullback %.1f | continuation %.1f | reversal %.1f | range %.1f | fakeout %.1f",
                       breakout_score,
                       pullback_score,
                       continuation_score,
                       reversal_score,
                       range_score,
                       fakeout_score);
  }

string ASC_DeepFitGapPosture(const double gap)
  {
   if(gap >= 14.0)
      return "clear_separation";
   if(gap >= 7.0)
      return "contested_but_usable";
   if(gap >= 3.5)
      return "narrow_advantage";
   return "near_tie";
  }

string ASC_DeepPathQualitySummary(const string primary_fit,
                                  const double primary_score,
                                  const string primary_posture,
                                  const string secondary_fit,
                                  const double secondary_score,
                                  const string gap_posture,
                                  const double gap)
  {
   string primary_name = ASC_DeepFitOperatorName(primary_fit);
   string secondary_name = ASC_DeepFitOperatorName(secondary_fit);

   if(gap_posture == "clear_separation")
      return StringFormat("primary path quality is clearly separated for now: %s leads %s by %.1f points, but this remains supportive context until failure / invalidation and live execution still agree",
                          primary_name,
                          secondary_name,
                          gap);

   if(gap_posture == "contested_but_usable")
      return StringFormat("primary path quality is usable but still contested: %s leads %s by %.1f points, so failure / invalidation and confidence-break carry must still confirm the path",
                          primary_name,
                          secondary_name,
                          gap);

   if(gap_posture == "narrow_advantage")
      return StringFormat("primary path quality is only a narrow advantage: %s leads %s by %.1f points, so do not read this as a strong path winner without stronger confirmation",
                          primary_name,
                          secondary_name,
                          gap);

   return StringFormat("primary path quality is near-tied: %s %.1f vs %s %.1f, so the readback stays contested and must not be flattened into a clean single-path story",
                       primary_name,
                       primary_score,
                       secondary_name,
                       secondary_score);
  }

string ASC_DeepSetupFitConclusion(const string primary_fit,
                                  const double primary_score,
                                  const string primary_posture,
                                  const string secondary_fit,
                                  const double secondary_score,
                                  const string secondary_posture,
                                  const double gap,
                                  const string gap_posture)
  {
   return StringFormat("primary %s %.1f (%s) | alternate %s %.1f (%s) | fit_gap %.1f (%s) | supportive only; confirm with shortlist, Market Board context, and live execution",
                       ASC_DeepFitOperatorName(primary_fit),
                       primary_score,
                       ASC_DeepFitOperatorName(primary_posture),
                       ASC_DeepFitOperatorName(secondary_fit),
                       secondary_score,
                       ASC_DeepFitOperatorName(secondary_posture),
                       gap,
                       ASC_DeepFitOperatorName(gap_posture));
  }

string ASC_DeepPathSplitState(const double primary_score,
                              const double secondary_score)
  {
   if(primary_score <= 0.0 && secondary_score <= 0.0)
      return "unresolved";

   double gap = primary_score - secondary_score;
   if(gap >= 14.0)
      return "clear_primary_with_live_alternate";
   if(gap >= 7.0)
      return "contested_primary";
   return "tight_live_split";
  }

bool ASC_DeepFitIsContinuationFamily(const string fit_name)
  {
   return (fit_name == "breakout"
           || fit_name == "trend_continuation"
           || fit_name == "pullback");
  }

bool ASC_DeepFitIsCounterPressureFamily(const string fit_name)
  {
   return (fit_name == "reversal"
           || fit_name == "fakeout");
  }

string ASC_DeepPathSplitSummary(const ASC_DeepSelectiveAnalysisResult &result)
  {
   double gap = MathMax(0.0, result.siam_primary_fit_score - result.siam_secondary_fit_score);
   return StringFormat("active split: %s %.1f (%s) vs %s %.1f (%s) | gap %.1f | state %s",
                       ASC_DeepFitOperatorName(result.siam_primary_fit),
                       result.siam_primary_fit_score,
                       ASC_DeepFitOperatorName(result.siam_primary_fit_posture),
                       ASC_DeepFitOperatorName(result.siam_secondary_fit),
                       result.siam_secondary_fit_score,
                       ASC_DeepFitOperatorName(result.siam_secondary_fit_posture),
                       gap,
                       ASC_DeepFitOperatorName(result.path_split_state));
  }

string ASC_DeepPathContestSummary(const ASC_DeepSelectiveAnalysisResult &result)
  {
   bool primary_continuation = ASC_DeepFitIsContinuationFamily(result.siam_primary_fit);
   bool secondary_continuation = ASC_DeepFitIsContinuationFamily(result.siam_secondary_fit);
   bool primary_counter = ASC_DeepFitIsCounterPressureFamily(result.siam_primary_fit);
   bool secondary_counter = ASC_DeepFitIsCounterPressureFamily(result.siam_secondary_fit);

   if(primary_continuation && secondary_counter)
      return "continuation / reclaim still leads, but reversal / failed-break pressure is the active counter-path; treat this as a live two-path contest until continuation readiness stays ahead of reversal, failed-break, and trap pressure together";

   if(primary_counter && secondary_continuation)
      return "reversal / failed-break pressure leads for now, but continuation / reclaim still survives as the live alternate; treat this as a live path split until counter-pressure keeps control and the continuation branch stops rebuilding";

   if(result.siam_primary_fit == "range")
      return "balance still leads, but directional resolution remains live through the alternate path; do not flatten this into a clean one-way story until one side clearly takes control";

   if(primary_continuation && secondary_continuation)
      return "the split stays inside the continuation family; breakout acceleration and pullback / trend continuation are both still live, so execution and freshness must decide which path stays cleaner";

   return "multiple plausible paths still coexist; use the active split, failure path, and confidence-break lines together instead of flattening the readout into one muddy story";
  }

string ASC_DeepCompactTimeframeReadback(const string label,
                                        const string drift,
                                        const string momentum,
                                        const string position_in_range,
                                        const string dist_high,
                                        const string dist_low,
                                        const string participation)
  {
   return StringFormat("%s | drift %s | momentum %s | range position %s | high distance %s | low distance %s | participation %s\n",
                       label,
                       drift,
                       momentum,
                       position_in_range,
                       dist_high,
                       dist_low,
                       participation);
  }

string ASC_DeepSiamTacticalSummary(const ASC_DeepSelectiveAnalysisResult &result)
  {
   return StringFormat("freshness %s | sweep %s | reclaim %s | failed break %s | pullback %s | continuation %s | reversal %s | trap pressure %s",
                       ASC_DeepScoreStateLabel(result.freshness_state, result.move_freshness_score),
                       ASC_DeepScoreStateLabel(result.session_sweep_state, result.session_sweep_score),
                       ASC_DeepScoreStateLabel(result.reclaim_state, result.reclaim_score),
                       ASC_DeepScoreStateLabel(result.failed_break_state, result.failed_break_score),
                       ASC_DeepPullbackReadback(result.pullback_state, result.pullback_depth_score, result.pullback_quality_score),
                       ASC_DeepScoreStateLabel(result.continuation_state, result.continuation_readiness_score),
                       ASC_DeepScoreStateLabel(result.reversal_state, result.reversal_pressure_score),
                       ASC_DeepScoreStateLabel(result.trap_pressure_state, result.trap_pressure_score));
  }


string ASC_DeepInvalidationTriggerSummary(const ASC_DeepSelectiveAnalysisResult &result,
                                         const ASC_ShortlistSymbolSummary &shortlist_entry)
  {
   string trigger_a = "";
   string trigger_b = "";

   if(result.failed_break_score >= 68.0 || result.trap_pressure_score >= 68.0)
      trigger_a = "failed-break / trap pressure stays in control";

   if(StringLen(trigger_a) <= 0 && result.reclaim_score < 52.0)
      trigger_a = "reclaim quality does not hold";
   else if(StringLen(trigger_b) <= 0 && result.reclaim_score < 52.0)
      trigger_b = "reclaim quality does not hold";

   if(StringLen(trigger_a) <= 0 && result.continuation_readiness_score < 55.0)
      trigger_a = "continuation readiness fades";
   else if(StringLen(trigger_b) <= 0 && result.continuation_readiness_score < 55.0)
      trigger_b = "continuation readiness fades";

   if(StringLen(trigger_a) <= 0 && result.reversal_pressure_score >= 68.0)
      trigger_a = "reversal pressure becomes the cleaner story";
   else if(StringLen(trigger_b) <= 0 && result.reversal_pressure_score >= 68.0)
      trigger_b = "reversal pressure becomes the cleaner story";

   if(StringLen(trigger_a) <= 0 && (result.execution_score < 55.0 || result.execution_penalty > 58.0))
      trigger_a = "execution friction degrades";
   else if(StringLen(trigger_b) <= 0 && (result.execution_score < 55.0 || result.execution_penalty > 58.0))
      trigger_b = "execution friction degrades";

   if(StringLen(trigger_a) <= 0 && (result.move_freshness_score < 58.0 || shortlist_entry.filter.late_move_risk_score > 60.0))
      trigger_a = "freshness decays";
   else if(StringLen(trigger_b) <= 0 && (result.move_freshness_score < 58.0 || shortlist_entry.filter.late_move_risk_score > 60.0))
      trigger_b = "freshness decays";

   if(StringLen(trigger_a) <= 0 && (result.participation_score < 55.0 || result.participation_delta < -8.0))
      trigger_a = "participation weakens";
   else if(StringLen(trigger_b) <= 0 && (result.participation_score < 55.0 || result.participation_delta < -8.0))
      trigger_b = "participation weakens";

   if(StringLen(trigger_a) <= 0 && shortlist_entry.filter.exhaustion_risk_score > 62.0)
      trigger_a = "exhaustion risk stays elevated";
   else if(StringLen(trigger_b) <= 0 && shortlist_entry.filter.exhaustion_risk_score > 62.0)
      trigger_b = "exhaustion risk stays elevated";

   if(StringLen(trigger_a) <= 0)
      trigger_a = "the current pressure stack stops agreeing";
   if(StringLen(trigger_b) <= 0)
      return trigger_a;

   return trigger_a + " | next " + trigger_b;
  }

string ASC_DeepFailureInvalidationSummary(const ASC_DeepSelectiveAnalysisResult &result)
  {
   string primary_fit = result.siam_primary_fit;
   string leading_trigger = result.invalidation_trigger_summary;
   int next_split = StringFind(leading_trigger, " | next ");
   if(next_split >= 0)
      leading_trigger = StringSubstr(leading_trigger, 0, next_split);

   if(primary_fit == "breakout" || primary_fit == "trend_continuation")
      return StringFormat("continuation demotes when %s and the active path stops confirming continuation across readiness, reclaim, and counter-pressure together",
                          leading_trigger);

   if(primary_fit == "pullback")
      return StringFormat("pullback continuation fails when %s and the reclaim branch stops being the cleaner explanation",
                          leading_trigger);

   if(primary_fit == "reversal")
      return StringFormat("reversal monitoring loses authority when %s and continuation / reclaim retakes control of the path contest",
                          leading_trigger);

   if(primary_fit == "range")
      return StringFormat("range-rotation context fails when %s and one directional pressure path becomes clearly cleaner than balance",
                          leading_trigger);

   if(primary_fit == "fakeout")
      return StringFormat("fakeout pressure fails when %s and the prior continuation story rebuilds with cleaner structure control",
                          leading_trigger);

   return StringFormat("current path demotes when %s and the active continuation, reversal, and failed-break relationship stops supporting the same story",
                       leading_trigger);
  }

string ASC_DeepConfidenceBreakSummary(const ASC_DeepSelectiveAnalysisResult &result,
                                      const ASC_ShortlistSymbolSummary &shortlist_entry)
  {
   string first = "";
   string second = "";

   if(result.execution_score < 55.0 || result.execution_penalty > 58.0)
      first = "execution friction worsens";

   if(StringLen(first) <= 0 && (result.participation_score < 55.0 || result.participation_delta < -8.0))
      first = "participation weakens";
   else if(StringLen(second) <= 0 && (result.participation_score < 55.0 || result.participation_delta < -8.0))
      second = "participation weakens";

   if(StringLen(first) <= 0 && (result.move_freshness_score < 58.0 || shortlist_entry.filter.late_move_risk_score > 60.0))
      first = "freshness decays";
   else if(StringLen(second) <= 0 && (result.move_freshness_score < 58.0 || shortlist_entry.filter.late_move_risk_score > 60.0))
      second = "freshness decays";

   if(StringLen(first) <= 0 && (result.reversal_pressure_score >= 68.0 || result.failed_break_score >= 68.0))
      first = "counter-pressure keeps building";
   else if(StringLen(second) <= 0 && (result.reversal_pressure_score >= 68.0 || result.failed_break_score >= 68.0))
      second = "counter-pressure keeps building";

   if(StringLen(first) <= 0 && shortlist_entry.filter.exhaustion_risk_score > 62.0)
      first = "exhaustion risk stays elevated";
   else if(StringLen(second) <= 0 && shortlist_entry.filter.exhaustion_risk_score > 62.0)
      second = "exhaustion risk stays elevated";

   if(StringLen(first) <= 0)
      first = "execution, freshness, and participation stop agreeing";
   if(StringLen(second) <= 0)
      return first;

   return first + " and " + second;
  }

string ASC_DeepVulnerabilitySummary(const ASC_DeepSelectiveAnalysisResult &result,
                                    const int dominant_bias_sign,
                                    const bool near_upper_extreme,
                                    const bool near_lower_extreme)
  {
   if(near_upper_extreme && dominant_bias_sign > 0)
      return "pressing from upper-range structure where failed-break and reversal pressure can accelerate quickly if follow-through stalls";
   if(near_lower_extreme && dominant_bias_sign < 0)
      return "pressing from lower-range structure where failed-break and reversal pressure can accelerate quickly if follow-through stalls";
   if(near_upper_extreme && dominant_bias_sign <= 0)
      return "leaning against upper-range structure where reclaim failure can quickly turn the readback into trap or reversal pressure";
   if(near_lower_extreme && dominant_bias_sign >= 0)
      return "leaning against lower-range structure where reclaim failure can quickly turn the readback into trap or reversal pressure";
   if(result.execution_score < 55.0)
      return "execution quality is the soft spot; weaker spread and friction behavior can demote the current deep story quickly";
   if(result.move_freshness_score < 58.0)
      return "freshness is the soft spot; an older or slowing move can demote the current path before structure fully breaks";
   return "the setup is most vulnerable where continuation strength, counter-pressure, and reclaim quality stop pointing to the same path";
  }

double ASC_DeepClampSigned(const double value,const double limit=100.0)
  {
   double safe_limit = MathMax(0.0, limit);
   return MathMax(-safe_limit, MathMin(safe_limit, value));
  }

int ASC_DeepDirectionalSign(const double value,const double epsilon)
  {
   if(value > epsilon)
      return 1;
   if(value < -epsilon)
      return -1;
   return 0;
  }

double ASC_DeepTickBiasValue(const int upticks,const int downticks)
  {
   int directional = upticks + downticks;
   if(directional <= 0)
      return 0.0;
   return ASC_DeepClampSigned((100.0 * (upticks - downticks)) / directional, 100.0);
  }

string ASC_DeepLiquidityZone(const double position_in_range_pct)
  {
   if(position_in_range_pct < 0.0)
      return "unavailable";
   if(position_in_range_pct >= 90.0)
      return "upper_extreme";
   if(position_in_range_pct >= 67.5)
      return "upper_range";
   if(position_in_range_pct <= 10.0)
      return "lower_extreme";
   if(position_in_range_pct <= 32.5)
      return "lower_range";
   return "mid_range";
  }

string ASC_DeepMoveAgePosture(const double move_age_score)
  {
   if(move_age_score >= 75.0)
      return "fresh";
   if(move_age_score >= 58.0)
      return "developing";
   if(move_age_score >= 38.0)
      return "maturing";
   return "stale";
  }

string ASC_DeepExecutionPosture(const double execution_score,const double execution_penalty)
  {
   if(execution_score >= 82.0 && execution_penalty <= 18.0)
      return "strong";
   if(execution_score >= 68.0 && execution_penalty <= 32.0)
      return "constructive";
   if(execution_score >= 52.0)
      return "neutral";
   if(execution_score >= 35.0 || execution_penalty <= 65.0)
      return "guarded";
   return "restricted";
  }

string ASC_DeepTacticalScorePosture(const double score)
  {
   if(score >= 90.0)
      return "extreme";
   if(score >= 75.0)
      return "strong";
   if(score >= 60.0)
      return "constructive";
   if(score >= 40.0)
      return "balanced";
   if(score >= 25.0)
      return "fading";
   return "weak";
  }

string ASC_DeepBiasFromDirectionalCounts(const int up_count,const int down_count,const int total_count)
  {
   if(total_count <= 0)
      return "unavailable";
   int delta = up_count - down_count;
   if(MathAbs(delta) >= 2)
      return (delta > 0 ? "bullish" : "bearish");
   if(delta != 0)
      return (delta > 0 ? "bullish_lean" : "bearish_lean");
   return "mixed_balanced";
  }

string ASC_DeepBiasAlignment(const string short_term_bias,
                             const string mid_term_bias,
                             const string higher_timeframe_bias)
  {
   bool short_up = (short_term_bias == "bullish" || short_term_bias == "bullish_lean");
   bool short_down = (short_term_bias == "bearish" || short_term_bias == "bearish_lean");
   bool mid_up = (mid_term_bias == "bullish" || mid_term_bias == "bullish_lean");
   bool mid_down = (mid_term_bias == "bearish" || mid_term_bias == "bearish_lean");
   bool higher_up = (higher_timeframe_bias == "bullish" || higher_timeframe_bias == "bullish_lean");
   bool higher_down = (higher_timeframe_bias == "bearish" || higher_timeframe_bias == "bearish_lean");

   int bullish_count = (short_up ? 1 : 0) + (mid_up ? 1 : 0) + (higher_up ? 1 : 0);
   int bearish_count = (short_down ? 1 : 0) + (mid_down ? 1 : 0) + (higher_down ? 1 : 0);

   if(short_down && higher_up)
      return "short_term_bearish_vs_higher_timeframe_bullish_bias";
   if(short_up && higher_down)
      return "short_term_bullish_vs_higher_timeframe_bearish_bias";

   if(bullish_count == 3)
      return "bullish_multi_timeframe_bias_consensus";
   if(bearish_count == 3)
      return "bearish_multi_timeframe_bias_consensus";

   int known_count = 0;
   if(short_up || short_down || short_term_bias == "mixed_balanced")
      known_count++;
   if(mid_up || mid_down || mid_term_bias == "mixed_balanced")
      known_count++;
   if(higher_up || higher_down || higher_timeframe_bias == "mixed_balanced")
      known_count++;
   if(known_count <= 1)
      return "unavailable";
   if((short_up && mid_up) || (mid_up && higher_up) || (short_up && higher_up))
      return "partial_bullish_bias_alignment";
   if((short_down && mid_down) || (mid_down && higher_down) || (short_down && higher_down))
      return "partial_bearish_bias_alignment";

   if(bearish_count > bullish_count)
      return "mixed_with_bearish_tilt";
   if(bullish_count > bearish_count)
      return "mixed_with_bullish_tilt";
   return "mixed_two_way";
  }

string ASC_DeepMicroDirection(const double tick_bias_now)
  {
   if(tick_bias_now >= 12.0)
      return "buying_pressure";
   if(tick_bias_now <= -12.0)
      return "selling_pressure";
   if(tick_bias_now >= 4.0)
      return "mixed_with_bullish_tilt";
   if(tick_bias_now <= -4.0)
      return "mixed_with_bearish_tilt";
   return "mixed_flat";
  }

string ASC_DeepMicroConviction(const double tick_shift,const double participation_score)
  {
   double intensity = (MathAbs(tick_shift) * 0.55) + (participation_score * 0.45);
   if(intensity >= 70.0)
      return "elevated";
   if(intensity >= 45.0)
      return "measured";
   return "limited";
  }

string ASC_DeepImpulseState(const double move_age_score,const int impulse_count_window)
  {
   if(move_age_score >= 72.5)
     {
      if(impulse_count_window >= 2)
         return "fresh_with_reinforcement";
      if(impulse_count_window > 0)
         return "fresh_impulse_present";
      return "fresh_without_reinforcement";
     }
   if(move_age_score >= 40.0)
     {
      if(impulse_count_window > 0)
         return "maturing_with_active_impulses";
      return "maturing_without_new_impulse";
     }
   if(impulse_count_window > 0)
      return "late_stage_with_residual_impulses";
   return "exhausted_or_flat";
  }

string ASC_DeepParticipationState(const double participation_delta)
  {
   if(participation_delta >= 6.0)
      return "building";
   if(participation_delta <= -6.0)
      return "fading";
   return "steady";
  }

string ASC_DeepSpreadPostureFromAverage(const double avg_spread_points,const int sample_count)
  {
   if(sample_count <= 0)
      return "spread posture unavailable";
   if(avg_spread_points <= 5.0)
      return "spread window remains controlled";
   if(avg_spread_points <= 15.0)
      return "spread window is elevated but still readable";
   return "spread window is materially wide and needs caution";
  }

string ASC_DeepDriftDirection(const double drift)
  {
   if(drift > 0.0)
      return "upward drift";
   if(drift < 0.0)
      return "downward drift";
   return "flat drift";
  }

int ASC_DeepBiasSign(const string bias_text)
  {
   string normalized = bias_text;
   StringToLower(normalized);
   if(StringFind(normalized, "bullish") >= 0)
      return 1;
   if(StringFind(normalized, "bearish") >= 0)
      return -1;
   return 0;
  }

string ASC_DeepPressureFacingState(const double score,
                                   const double strong_threshold,
                                   const double constructive_threshold,
                                   const string strong_label,
                                   const string constructive_label,
                                   const string neutral_label)
  {
   if(score >= strong_threshold)
      return strong_label;
   if(score >= constructive_threshold)
      return constructive_label;
   return neutral_label;
  }

string ASC_DeepPullbackState(const double depth_score,const double quality_score)
  {
   if(quality_score >= 72.5)
     {
      if(depth_score >= 67.5)
         return "deep_pullback_but_still_clean";
      if(depth_score >= 42.5)
         return "workable_pullback";
      return "shallow_pullback";
     }
   if(depth_score >= 67.5)
      return "deep_pullback_with_noise";
   if(depth_score >= 42.5)
      return "pullback_quality_is_mixed";
   return "no_meaningful_pullback";
  }

string ASC_DeepFreshnessState(const double freshness_score)
  {
   if(freshness_score >= 75.0)
      return "fresh";
   if(freshness_score >= 57.5)
      return "workable";
   if(freshness_score >= 40.0)
      return "late";
   return "exhausted";
  }

bool ASC_DeepComputeAtrPrice(const MqlRates &rates[],
                             const int copied,
                             const int period,
                             double &atr_price_out,
                             int &samples_out)
  {
   atr_price_out = 0.0;
   samples_out = 0;
   if(copied <= period || period < 2)
      return false;

   double tr_sum = 0.0;
   int samples = 0;
   for(int i = 0; i < period; i++)
     {
      int bar_index = i;
      int prev_index = i + 1;
      if(prev_index >= copied)
         break;

      double high = rates[bar_index].high;
      double low = rates[bar_index].low;
      double prev_close = rates[prev_index].close;
      if(high <= 0.0 || low <= 0.0 || prev_close <= 0.0 || high < low)
         continue;

      double tr = MathMax(high - low, MathMax(MathAbs(high - prev_close), MathAbs(low - prev_close)));
      if(tr <= 0.0)
         continue;

      tr_sum += tr;
      samples++;
     }

   samples_out = samples;
   if(samples < period)
      return false;

   atr_price_out = tr_sum / samples;
   return (atr_price_out > 0.0);
  }

string ASC_DeepVolatilityPosture(const double atr_pct)
  {
   if(atr_pct <= 0.0)
      return "unavailable";
   if(atr_pct < 0.08)
      return "very compressed volatility";
   if(atr_pct < 0.20)
      return "controlled volatility";
   if(atr_pct < 0.45)
      return "balanced volatility";
   if(atr_pct < 0.85)
      return "elevated volatility";
   return "high volatility";
  }

string ASC_DeepRegimeLabel(const double atr_pct,const double range_pct,const double drift_pct)
  {
   if(atr_pct <= 0.0 || range_pct < 0.0)
      return "unavailable";

   double drift_abs = MathAbs(drift_pct);
   if(range_pct <= (atr_pct * 1.10) && drift_abs <= (atr_pct * 0.35))
      return "Compression";
   if(range_pct >= (atr_pct * 2.20) && drift_abs >= (atr_pct * 0.80))
      return "Expansion";
   if(drift_abs >= (atr_pct * 0.60))
      return "Directional";
   return "Balanced";
  }

string ASC_DeepDriftPosture(const double drift_pct,const double atr_pct)
  {
   if(atr_pct <= 0.0)
      return "unavailable";

   double drift_abs = MathAbs(drift_pct);
   if(drift_abs <= (atr_pct * 0.25))
      return "flat drift";
   if(drift_pct > 0.0)
      return drift_abs >= (atr_pct * 0.90) ? "strong upward drift" : "upward drift";
   return drift_abs >= (atr_pct * 0.90) ? "strong downward drift" : "downward drift";
  }

string ASC_DeepRangePosture(const double range_pct,const double atr_pct)
  {
   if(range_pct < 0.0 || atr_pct <= 0.0)
      return "unavailable";
   if(range_pct <= (atr_pct * 1.10))
      return "compressed range";
   if(range_pct >= (atr_pct * 2.20))
      return "expanded range";
   return "balanced range";
  }

string ASC_DeepPercentText(const double value,const int digits=3)
  {
   return DoubleToString(value, digits) + "%";
  }

string ASC_DeepWindowLocationPosture(const double close_location_pct)
  {
   if(close_location_pct < 0.0)
      return "unavailable";
   if(close_location_pct >= 80.0)
      return "pressing upper window";
   if(close_location_pct >= 60.0)
      return "upper-half control";
   if(close_location_pct <= 20.0)
      return "pressing lower window";
   if(close_location_pct <= 40.0)
      return "lower-half control";
   return "mid-window balance";
  }

string ASC_DeepMomentumPosture(const double return_3_pct,const double return_5_pct,const double atr_pct)
  {
   if(atr_pct <= 0.0)
      return "unavailable";
   double impulse = MathAbs(return_3_pct);
   double follow_through = MathAbs(return_5_pct);
   if(impulse <= (atr_pct * 0.15) && follow_through <= (atr_pct * 0.30))
      return "flat momentum";
   if(return_3_pct > 0.0)
      return (impulse >= (atr_pct * 0.80) || follow_through >= (atr_pct * 1.10))
             ? "upside momentum expanding"
             : "upside momentum present";
   if(return_3_pct < 0.0)
      return (impulse >= (atr_pct * 0.80) || follow_through >= (atr_pct * 1.10))
             ? "downside momentum expanding"
             : "downside momentum present";
   return "mixed momentum";
  }

string ASC_DeepStructureWindowState(const double close_location_pct,
                                    const double distance_high_pct,
                                    const double distance_low_pct,
                                    const double return_3_pct)
  {
   if(close_location_pct < 0.0)
      return "unavailable";
   if(close_location_pct >= 85.0 && return_3_pct >= 0.0)
      return "testing upper window edge";
   if(close_location_pct <= 15.0 && return_3_pct <= 0.0)
      return "testing lower window edge";
   if(close_location_pct >= 60.0)
      return "upper-half structure";
   if(close_location_pct <= 40.0)
      return "lower-half structure";
   if(distance_high_pct < distance_low_pct)
      return "leaning toward upper window";
   if(distance_low_pct < distance_high_pct)
      return "leaning toward lower window";
   return "balanced window structure";
  }

string ASC_DeepParticipationPosture(const double volume_ratio)
  {
   if(volume_ratio < 0.0)
      return "unavailable";
   if(volume_ratio >= 1.50)
      return "participation expanding";
   if(volume_ratio >= 1.10)
      return "participation constructive";
   if(volume_ratio >= 0.75)
      return "participation balanced";
   return "participation fading";
  }

string ASC_DeepTickBiasPosture(const int upticks,const int downticks,const int flat_ticks=0)
  {
   if(upticks <= 0 && downticks <= 0)
      return (flat_ticks > 0) ? "flat tape dominant" : "tick bias unavailable";

   if(upticks > downticks)
     {
      if(flat_ticks > upticks && flat_ticks > downticks)
         return "flat tape with slight uptick bias";
      return (upticks >= (downticks * 2)) ? "uptick pressure dominant" : "uptick pressure leading";
     }

   if(downticks > upticks)
     {
      if(flat_ticks > downticks && flat_ticks > upticks)
         return "flat tape with slight downtick bias";
      return (downticks >= (upticks * 2)) ? "downtick pressure dominant" : "downtick pressure leading";
     }

   if(flat_ticks > MathMax(upticks, downticks))
      return "flat tape with balanced pressure";
   return "tick pressure balanced";
  }

string ASC_DeepPacketFieldText(const bool ready,const double value,const int digits)
  {
   if(!ready)
      return "unavailable";
   return DoubleToString(value, digits);
  }

string ASC_DeepSpreadPctText(const bool ready,const double value)
  {
   if(!ready)
      return "unavailable";
   return DoubleToString(value, 3) + "%";
  }

string ASC_DeepSpreadPointsText(const bool ready,const double value)
  {
   if(!ready)
      return "unavailable";
   return DoubleToString(value, 2);
  }

string ASC_DeepSpreadPostureProjected(const bool spread_ready,const double spread_to_atr)
  {
   if(!spread_ready)
      return "unavailable (insufficient spread sample support)";
   if(spread_to_atr < 0.0)
      return "shared spread window readable (timeframe ATR unavailable)";
   if(spread_to_atr <= 0.25)
      return "spread controlled vs timeframe ATR (shared live spread window)";
   if(spread_to_atr <= 0.60)
      return "spread elevated vs timeframe ATR (shared live spread window)";
   return "spread wide vs timeframe ATR (shared live spread window)";
  }

string ASC_DeepFrictionPostureProjected(const bool spread_ready,const double spread_to_atr)
  {
   if(!spread_ready)
      return "unavailable (insufficient spread sample support)";
   if(spread_to_atr < 0.0)
      return "unavailable (timeframe ATR unavailable for friction ratio)";
   if(spread_to_atr <= 0.25)
      return "controlled friction (shared live spread window)";
   if(spread_to_atr <= 0.60)
      return "elevated friction (shared live spread window)";
   return "high friction (shared live spread window)";
  }

string ASC_DeepLiquidityPostureProjected(const bool spread_ready,const double spread_to_atr)
  {
   if(!spread_ready)
      return "unavailable (insufficient spread sample support)";
   if(spread_to_atr < 0.0)
      return "guarded liquidity (timeframe ATR unavailable)";
   if(spread_to_atr <= 0.25)
      return "strong liquidity (shared live spread window)";
   if(spread_to_atr <= 0.60)
      return "moderate liquidity (shared live spread window)";
   return "weak liquidity (shared live spread window)";
  }

bool ASC_DeepSymbolMatchesContext(const ASC_Layer1SymbolState &selected,const string symbol)
  {
   if(StringLen(symbol) <= 0)
      return false;
   if(selected.symbol == symbol)
      return true;
   if(selected.identity.normalized_symbol == symbol)
      return true;
   if(selected.classification.canonical_symbol == symbol)
      return true;
   return false;
  }

bool ASC_DeepSymbolEntitled(const string requested_symbol,
                            const string hud_selected_symbol,
                            const ASC_Layer1SymbolState &selected,
                            const bool has_packet,
                            const ASC_Layer2Packet &packet,
                            const ASC_ShortlistSymbolSummary &shortlist_rows[],
                            string &status_out,
                            string &reason_out,
                            ASC_ShortlistSymbolSummary &entry_out,
                            int &rank_out,
                            int &total_out,
                            string &shortlist_context_out,
                            string &market_state_context_out,
                            string &support_posture_out,
                            string &build_context_out)
  {
   status_out = "NO_SELECTED_SYMBOL";
   reason_out = "selected symbol is missing";
   rank_out = 0;
   total_out = 0;
   shortlist_context_out = "outside_shortlist";
   market_state_context_out = "unknown";
   support_posture_out = "packet_unavailable";
   build_context_out = "override_not_run";

   if(StringLen(requested_symbol) <= 0)
     {
      reason_out = "selected symbol context is missing";
      return false;
     }

   if(!ASC_DeepSymbolMatchesContext(selected, requested_symbol))
     {
      status_out = "PROVENANCE_MISMATCH";
      reason_out = "selected symbol evidence no longer matches the armed Deep Analysis request";
      return false;
     }

   bool shortlist_found = ASC_ShortlistFindSymbolSummary(shortlist_rows, requested_symbol, entry_out, rank_out, total_out);
   if(shortlist_found && entry_out.shortlisted && rank_out > 0)
     {
      if(rank_out <= 3)
         shortlist_context_out = StringFormat("promoted_rank_%d", rank_out);
      else
         shortlist_context_out = StringFormat("shortlisted_rank_%d", rank_out);
     }
   else if(shortlist_found)
      shortlist_context_out = "reserve_or_pending";

   if(selected.state == ASC_L1_OPEN)
      market_state_context_out = "open";
   else if(selected.state == ASC_L1_CLOSED)
      market_state_context_out = "closed_or_dormant";
   else if(selected.state == ASC_L1_UNKNOWN)
      market_state_context_out = "unknown";
   else
      market_state_context_out = "not_open";

   if(has_packet)
     {
      if(packet.freshness == ASC_L2_STALE || packet.freshness == ASC_L2_DEGRADED)
         support_posture_out = "packet_degraded_or_stale";
      else if(packet.continuity_backed)
         support_posture_out = "packet_continuity_backed";
      else
         support_posture_out = "packet_live";
     }

   if(has_packet && selected.state == ASC_L1_OPEN)
      build_context_out = "live_or_continuity_packet";
   else if(has_packet)
      build_context_out = "historical_with_packet_support";
   else
      build_context_out = "historical_only_no_packet";

   status_out = "ENTITLED_EXPLICIT_OVERRIDE";
   reason_out = StringFormat("explicit operator override accepted for selected symbol (%s, %s, %s)",
                             shortlist_context_out,
                             market_state_context_out,
                             support_posture_out);
   return true;
  }

string ASC_DeepAnalysisPostureTag(const ASC_Layer1SymbolState &symbol_state,const bool has_packet)
  {
   if(!symbol_state.classification.resolved)
      return "Override (classification unresolved context)";
   if(ASC_DeepEnabledTimeframeCount() <= 0)
      return "Override (safe timeframe fallback)";
   if(!has_packet)
      return "Override (historical-only support)";
   if(symbol_state.is_degraded)
      return "Override (degraded support)";
   if(symbol_state.is_stale)
      return "Override (stale support)";
   if(symbol_state.state != ASC_L1_OPEN)
      return "Override (closed/dormant context)";
   return "Ready on explicit trigger";
  }

string ASC_DeepAnalysisCompactSummary(const ASC_Layer1SymbolState &symbol_state,const bool has_packet)
  {
   string posture = ASC_DeepAnalysisPostureTag(symbol_state, has_packet);
   if(posture == "Ready on explicit trigger")
      return "Deep Analysis may be armed for the selected symbol with live support.";
   if(posture == "Override (classification unresolved context)")
      return "Deep Analysis may run under explicit override with unresolved classification context.";
   if(posture == "Override (safe timeframe fallback)")
      return "Deep Analysis may run under explicit override using safe fallback timeframes.";
   if(posture == "Override (degraded support)")
      return "Deep Analysis may run under explicit override with degraded packet support.";
   if(posture == "Override (stale support)")
      return "Deep Analysis may run under explicit override with stale packet support.";
   if(posture == "Override (historical-only support)")
      return "Deep Analysis may run under explicit override using historical-only support.";
   if(posture == "Override (closed/dormant context)")
      return "Deep Analysis may run under explicit override for closed/dormant market context.";
   return "Deep Analysis is unavailable for this symbol in the current posture.";
  }

bool ASC_BuildDeepSelectiveAnalysisResult(const ASC_Layer1SymbolState &selected,
                                          const string hud_selected_symbol,
                                          const ASC_ShortlistSymbolSummary &shortlist_rows[],
                                          const datetime now_utc,
                                          ASC_DeepSelectiveAnalysisResult &result)
  {
   ASC_DeepInitResult(result);

  result.symbol = selected.symbol;
  result.canonical_symbol = selected.classification.canonical_symbol;
  if(StringLen(result.canonical_symbol) <= 0)
      result.canonical_symbol = selected.identity.canonical_symbol;
   if(StringLen(result.canonical_symbol) <= 0)
      result.canonical_symbol = selected.identity.normalized_symbol;
  if(StringLen(result.canonical_symbol) <= 0)
      result.canonical_symbol = selected.symbol;

   ASC_Layer2Packet packet;
   bool has_packet = ASC_ShortlistTryGetPacketForState(selected, packet) && (packet.admitted || packet.tactical_only);

   ASC_ShortlistSymbolSummary shortlist_entry;
   int shortlist_rank = 0;
   int shortlist_total = 0;
   string gate_state = "";
   string gate_reason = "";
   if(!ASC_DeepSymbolEntitled(selected.symbol,
                              hud_selected_symbol,
                              selected,
                              has_packet,
                              packet,
                              shortlist_rows,
                              gate_state,
                              gate_reason,
                              shortlist_entry,
                              shortlist_rank,
                              shortlist_total,
                              result.shortlist_context,
                              result.market_state_context,
                              result.support_posture,
                              result.build_context))
     {
      result.entitlement_state = gate_state;
      result.entitlement_reason = gate_reason;
      result.freshness_posture = has_packet ? ASC_L2FreshnessToOperatorText(packet.freshness)
                                            : ASC_ArtifactFreshnessLabel(selected.is_degraded, selected.is_stale);
      result.continuity_posture = has_packet ? (packet.continuity_backed ? "continuity" : "live") : "not_run";
      result.preservation_state = "not_run";
      result.preservation_reason = gate_reason;
      result.reset_reason = "blocked before deep build";
      result.summary_line = gate_reason;
      return false;
     }

   result.lawful = true;
   result.built = true;
   result.entitlement_state = gate_state;
   result.entitlement_reason = gate_reason;
   result.execution_context = "explicit_selected_symbol_override";
   result.shortlist_rank = shortlist_rank;
   result.last_refreshed_utc = now_utc;

   if(has_packet)
      result.freshness_posture = ASC_L2FreshnessToOperatorText(packet.freshness);
   else
      result.freshness_posture = ASC_ArtifactFreshnessLabel(selected.is_degraded, selected.is_stale);

   result.continuity_posture = has_packet ? (packet.continuity_backed ? "continuity" : "live") : "historical_only";
   result.preservation_state = !has_packet
                               ? "historical_only_rebuild"
                               : (has_packet && packet.continuity_backed
                                  ? "continuity_backed_rebuild"
                                  : ((selected.is_degraded || selected.is_stale
                                      || (has_packet && (packet.freshness == ASC_L2_STALE || packet.freshness == ASC_L2_DEGRADED)))
                                     ? "degraded_rebuild"
                                     : "fresh_rebuild"));
   result.preservation_reason = "explicit Deep Analysis refreshed the selected symbol block without widening scope";
   result.reset_reason = "explicit Deep Analysis request from the HUD action row";

   double point = has_packet && packet.point > 0.0 ? packet.point : SymbolInfoDouble(selected.symbol, SYMBOL_POINT);
   if(point <= 0.0)
      point = 0.00001;

   int price_digits = has_packet && packet.digits > 0 ? packet.digits : 5;
   long selected_digits_raw = price_digits;
   if(SymbolInfoInteger(selected.symbol, SYMBOL_DIGITS, selected_digits_raw) && selected_digits_raw > 0)
      price_digits = (int)MathMin(10, selected_digits_raw);
   if(price_digits <= 0)
      price_digits = 5;

   string packet_bid_text = has_packet ? ASC_DeepPacketFieldText(packet.valid_bid, packet.bid, price_digits) : "unavailable";
   string packet_ask_text = has_packet ? ASC_DeepPacketFieldText(packet.valid_ask, packet.ask, price_digits) : "unavailable";
   string packet_last_text = has_packet ? ASC_DeepPacketFieldText(packet.valid_last_price, packet.last_price, price_digits) : "unavailable";
   string packet_spread_text = has_packet ? ASC_DeepSpreadPointsText(packet.valid_spread, packet.spread_points) : "unavailable";
   string packet_spread_pct_text = has_packet ? ASC_DeepSpreadPctText(packet.valid_spread_pct, packet.spread_pct) : "unavailable";
   string packet_freshness_text = has_packet ? ASC_L2FreshnessToOperatorText(packet.freshness) : ASC_ArtifactFreshnessLabel(selected.is_degraded, selected.is_stale);
   string packet_continuity_text = has_packet ? (packet.continuity_backed ? "continuity" : "live") : "historical_only";
   string packet_quote_observed_text = (has_packet && packet.quote_observed_utc > 0) ? ASC_ArtifactFormatUtc(packet.quote_observed_utc) : "unavailable";
   string packet_tick_time_text = (has_packet && packet.valid_tick_time) ? ASC_ArtifactFormatUtc(packet.tick_time_utc) : "unavailable";
   string packet_daily_change_text = (has_packet && packet.valid_daily_change_pct) ? ASC_DeepPercentText(packet.daily_change_pct, 3) : "unavailable";
   string packet_day_range_position_text = (has_packet && packet.valid_day_range_position) ? ASC_DeepPercentText(packet.day_range_position_pct, 2) : "unavailable";
   string packet_atr_pct_text = (has_packet && packet.valid_atr_pct) ? ASC_DeepPercentText(packet.atr_pct, 3) : "unavailable";
   string packet_trade_session_text = has_packet && StringLen(packet.trade_session_status) > 0 ? packet.trade_session_status : "unavailable";
   string packet_quote_session_text = has_packet && StringLen(packet.quote_session_status) > 0 ? packet.quote_session_status : "unavailable";
   string packet_session_notes_text = has_packet && StringLen(packet.session_notes) > 0 ? packet.session_notes : "unavailable";

   double execution_spread_cap_pct = (selected.classification.main_bucket_id == "crypto") ? 1.50 : 0.35;
   if(has_packet && packet.valid_day_range_position)
     {
      result.position_in_range_pct = ASC_DeepRoundScore(packet.day_range_position_pct);
      result.liquidity_zone = ASC_DeepLiquidityZone(packet.day_range_position_pct);
      if(packet.valid_last_price && packet.last_price > 0.0 && packet.day_high > 0.0 && packet.day_high >= packet.last_price)
         result.distance_to_recent_high_pct = ((packet.day_high - packet.last_price) / packet.last_price) * 100.0;
      if(packet.valid_last_price && packet.last_price > 0.0 && packet.day_low > 0.0 && packet.last_price >= packet.day_low)
         result.distance_to_recent_low_pct = ((packet.last_price - packet.day_low) / packet.last_price) * 100.0;
      result.liquidity_proximity_score = ASC_DeepRoundScore(MathAbs(packet.day_range_position_pct - 50.0) * 2.0);
      if(packet.day_range_position_pct >= 85.0 || packet.day_range_position_pct <= 15.0)
         result.liquidity_proximity_posture = "extreme";
      else if(packet.day_range_position_pct >= 70.0 || packet.day_range_position_pct <= 30.0)
         result.liquidity_proximity_posture = "edge";
      else
         result.liquidity_proximity_posture = "mid_range";
     }

   if(has_packet)
     {
      if(packet.valid_spread_pct && execution_spread_cap_pct > 0.0)
         result.spread_quality_score = ASC_DeepRoundScore(100.0 - MathMin(100.0, (packet.spread_pct / execution_spread_cap_pct) * 100.0));
      if(packet.valid_spread_to_atr && packet.spread_to_atr >= 0.0)
         result.friction_quality_score = ASC_DeepRoundScore(100.0 - MathMin(100.0, (packet.spread_to_atr / 0.85) * 100.0));

      string liquidity_state_text = packet.liquidity_state;
      StringToLower(liquidity_state_text);
      if(StringFind(liquidity_state_text, "deep") >= 0
         || StringFind(liquidity_state_text, "ample") >= 0
         || StringFind(liquidity_state_text, "strong") >= 0)
         result.liquidity_quality_score = 85.0;
      else if(StringFind(liquidity_state_text, "balanced") >= 0
              || StringFind(liquidity_state_text, "healthy") >= 0
              || StringFind(liquidity_state_text, "normal") >= 0)
         result.liquidity_quality_score = 70.0;
      else if(StringFind(liquidity_state_text, "thin") >= 0
              || StringFind(liquidity_state_text, "limited") >= 0)
         result.liquidity_quality_score = 40.0;
      else if(StringFind(liquidity_state_text, "illiquid") >= 0)
         result.liquidity_quality_score = 20.0;
      else
         result.liquidity_quality_score = 60.0;
     }

   result.execution_score = ASC_DeepRoundScore((result.spread_quality_score + result.friction_quality_score + result.liquidity_quality_score) / 3.0);
   result.execution_penalty = ASC_DeepRoundScore(100.0 - result.execution_score);
   result.execution_posture = ASC_DeepExecutionPosture(result.execution_score, result.execution_penalty);

   result.tactical_snapshot_summary = StringFormat("bid=%s | ask=%s | last=%s | spread_points=%s | spread_pct=%s | freshness=%s | continuity=%s | packet_age_ms=%d | quote_observed_utc=%s | tick_time_utc=%s",
                                                   packet_bid_text,
                                                   packet_ask_text,
                                                   packet_last_text,
                                                   packet_spread_text,
                                                   packet_spread_pct_text,
                                                   packet_freshness_text,
                                                   packet_continuity_text,
                                                   has_packet ? MathMax(0, packet.packet_age_sec) * 1000 : MathMax(0, (int)(now_utc - selected.observed_at_utc)) * 1000,
                                                   packet_quote_observed_text,
                                                   packet_tick_time_text);
   result.structure_liquidity_summary = StringFormat("day_direction=%s | price_action=%s | day_structure=%s | daily_change=%s | day_range_position=%s | volatility=%s | friction=%s | liquidity=%s",
                                                     has_packet && StringLen(packet.day_direction_snapshot) > 0 ? packet.day_direction_snapshot : "unavailable",
                                                     has_packet && StringLen(packet.day_price_action_snapshot) > 0 ? packet.day_price_action_snapshot : "unavailable",
                                                     has_packet && StringLen(packet.day_structure_posture) > 0 ? packet.day_structure_posture : "unavailable",
                                                     packet_daily_change_text,
                                                     packet_day_range_position_text,
                                                     has_packet && StringLen(packet.volatility_state) > 0 ? packet.volatility_state : "unavailable",
                                                     has_packet && StringLen(packet.friction_state) > 0 ? packet.friction_state : "unavailable",
                                                     has_packet && StringLen(packet.liquidity_state) > 0 ? packet.liquidity_state : "unavailable");
   result.session_timing_summary = StringFormat("market_state=%s | trade_session=%s | quote_session=%s | session_notes=%s | next_due_reason=%s | next_due_utc=%s",
                                                ASC_L1StateToOperatorText(selected.state),
                                                packet_trade_session_text,
                                                packet_quote_session_text,
                                                packet_session_notes_text,
                                                selected.next_due_reason,
                                                selected.next_due_utc > 0 ? ASC_ArtifactFormatUtc(selected.next_due_utc) : "awaiting-first-check");
   string overall_rank_text = (shortlist_entry.rank > 0) ? IntegerToString(shortlist_entry.rank) : "reserve";
   string raw_rank_text = (shortlist_entry.raw_rank > 0) ? IntegerToString(shortlist_entry.raw_rank) : "unranked";
   string bucket_rank_text = (shortlist_entry.bucket_rank > 0) ? IntegerToString(shortlist_entry.bucket_rank) : "outside_top5";
   string overall_membership_text = ASC_ShortlistHasLawfulMembership(shortlist_entry)
                                    ? "overall_member"
                                    : (ASC_ShortlistHasLawfulBucketMembership(shortlist_entry)
                                       ? "bucket_top5_reserve"
                                       : "outside_overall_board");
   result.score_context_summary = shortlist_rank > 0
                                  ? StringFormat("overall_rank=%s/%d | raw_rank=%s | bucket_rank=%s | overall_membership=%s | shortlist_score=%.1f | shortlist_l3_score=%.1f | shortlist_context_score=%.1f | shortlist_band=%s | shortlist_posture=%s | attention=%s",
                                                 overall_rank_text,
                                                 shortlist_total,
                                                 raw_rank_text,
                                                 bucket_rank_text,
                                                 overall_membership_text,
                                                 shortlist_entry.shortlist_score,
                                                 shortlist_entry.shortlist_l3_score,
                                                 shortlist_entry.shortlist_context_score,
                                                 StringLen(shortlist_entry.shortlist_band) > 0 ? shortlist_entry.shortlist_band : "unavailable",
                                                 StringLen(shortlist_entry.shortlist_posture) > 0 ? shortlist_entry.shortlist_posture : "unavailable",
                                                 StringLen(shortlist_entry.shortlist_attention_posture) > 0 ? shortlist_entry.shortlist_attention_posture : "unavailable")
                                  : "overall_rank=reserve | raw_rank=unranked | bucket_rank=outside_top5 | overall_membership=outside_overall_board";
   if(shortlist_entry.filter.score_pack_ready)
      result.score_context_summary += StringFormat(" | l3_net=%.1f | l3_gross=%.1f | price_engine=%.1f | microstructure=%.1f | volatility_transition=%.1f | structure_context=%.1f | session_timing=%.1f | execution_friction_penalty=%.1f | l3_pressure_shift=%.1f | l3_move_age=%.1f | l3_liquidity=%.1f | l3_participation=%.1f | l3_execution=%.1f | l3_tick_burst=%.1f | score_posture=%s | attention_posture=%s",
                                                   shortlist_entry.filter.score_net,
                                                   shortlist_entry.filter.score_gross,
                                                   shortlist_entry.filter.price_engine_score,
                                                   shortlist_entry.filter.microstructure_score,
                                                   shortlist_entry.filter.volatility_transition_score,
                                                   shortlist_entry.filter.structure_context_score,
                                                   shortlist_entry.filter.session_timing_score,
                                                   shortlist_entry.filter.execution_friction_penalty,
                                                   shortlist_entry.filter.pressure_shift_score,
                                                   shortlist_entry.filter.move_age_score,
                                                   shortlist_entry.filter.liquidity_proximity_score,
                                                   shortlist_entry.filter.participation_score,
                                                   shortlist_entry.filter.execution_score,
                                                   shortlist_entry.filter.tick_burst_score,
                                                   shortlist_entry.filter.score_posture,
                                                   shortlist_entry.filter.attention_posture);
   if(shortlist_entry.filter.score_pack_ready)
     {
      result.siam_breakout_fit_score = ASC_DeepRoundScore((shortlist_entry.filter.context_strength_score * 0.33)
                                                          + (shortlist_entry.filter.entry_readiness_score * 0.30)
                                                          + (shortlist_entry.filter.momentum_acceleration_score * 0.22)
                                                          + (shortlist_entry.filter.tick_burst_score * 0.15)
                                                          - (shortlist_entry.filter.late_move_risk_score * 0.12));
      result.siam_pullback_fit_score = ASC_DeepRoundScore((shortlist_entry.filter.context_strength_score * 0.34)
                                                          + (shortlist_entry.filter.execution_alignment_score * 0.22)
                                                          + (shortlist_entry.filter.session_alignment_score * 0.18)
                                                          + ((100.0 - shortlist_entry.filter.extension_risk_score) * 0.16)
                                                          + ((100.0 - shortlist_entry.filter.exhaustion_risk_score) * 0.10));
      result.siam_reversal_fit_score = ASC_DeepRoundScore((shortlist_entry.filter.pressure_shift_score * 0.32)
                                                          + ((100.0 - shortlist_entry.filter.move_age_score) * 0.24)
                                                          + ((100.0 - shortlist_entry.filter.extension_risk_score) * 0.22)
                                                          + (shortlist_entry.filter.participation_score * 0.12)
                                                          + (shortlist_entry.filter.execution_score * 0.10));
      result.siam_range_fit_score = ASC_DeepRoundScore((shortlist_entry.filter.structure_context_score * 0.35)
                                                       + (shortlist_entry.filter.execution_alignment_score * 0.25)
                                                       + ((100.0 - shortlist_entry.filter.momentum_acceleration_score) * 0.20)
                                                       + (shortlist_entry.filter.session_alignment_score * 0.20));
      result.siam_trend_continuation_fit_score = ASC_DeepRoundScore((shortlist_entry.filter.context_strength_score * 0.36)
                                                                    + (shortlist_entry.filter.momentum_acceleration_score * 0.26)
                                                                    + (shortlist_entry.filter.entry_readiness_score * 0.22)
                                                                    + ((100.0 - shortlist_entry.filter.late_move_risk_score) * 0.16));
      result.siam_fakeout_fit_score = ASC_DeepRoundScore((shortlist_entry.filter.pressure_shift_score * 0.30)
                                                         + ((100.0 - shortlist_entry.filter.context_strength_score) * 0.18)
                                                         + (shortlist_entry.filter.exhaustion_risk_score * 0.22)
                                                         + (shortlist_entry.filter.extension_risk_score * 0.18)
                                                         + (shortlist_entry.filter.execution_alignment_score * 0.12));
      result.siam_fit_summary = ASC_DeepCompactFitSummary(result.siam_breakout_fit_score,
                                                   result.siam_pullback_fit_score,
                                                   result.siam_reversal_fit_score,
                                                   result.siam_range_fit_score,
                                                   result.siam_trend_continuation_fit_score,
                                                   result.siam_fakeout_fit_score);
      result.score_context_summary += " | siam_fit " + result.siam_fit_summary;

      string fit_names[6] =
        {
         "breakout",
         "pullback",
         "reversal",
         "range",
         "trend_continuation",
         "fakeout"
        };
      double fit_scores[6] =
        {
         result.siam_breakout_fit_score,
         result.siam_pullback_fit_score,
         result.siam_reversal_fit_score,
         result.siam_range_fit_score,
         result.siam_trend_continuation_fit_score,
         result.siam_fakeout_fit_score
        };

      int top_index = 0;
      int second_index = 1;
      if(fit_scores[second_index] > fit_scores[top_index])
        {
         int swap_index = top_index;
         top_index = second_index;
         second_index = swap_index;
        }
      for(int fit_i = 2; fit_i < 6; fit_i++)
        {
         if(fit_scores[fit_i] > fit_scores[top_index])
           {
            second_index = top_index;
            top_index = fit_i;
           }
         else if(fit_scores[fit_i] > fit_scores[second_index])
            second_index = fit_i;
        }

      result.siam_primary_fit = fit_names[top_index];
      result.siam_primary_fit_score = fit_scores[top_index];
      result.siam_primary_fit_posture = ASC_DeepSiamFitPosture(result.siam_primary_fit_score);
      result.siam_primary_fit_reason = ASC_DeepSiamFitReason(result.siam_primary_fit, shortlist_entry);
      result.siam_secondary_fit = fit_names[second_index];
      result.siam_secondary_fit_score = fit_scores[second_index];
      result.siam_secondary_fit_posture = ASC_DeepSiamFitPosture(result.siam_secondary_fit_score);
      result.siam_secondary_fit_reason = ASC_DeepSiamFitReason(result.siam_secondary_fit, shortlist_entry);
      result.siam_fit_gap_score = ASC_DeepRoundScore(MathMax(0.0, result.siam_primary_fit_score - result.siam_secondary_fit_score));
      result.siam_fit_gap_posture = ASC_DeepFitGapPosture(result.siam_fit_gap_score);
      result.path_quality_summary = ASC_DeepPathQualitySummary(result.siam_primary_fit,
                                                               result.siam_primary_fit_score,
                                                               result.siam_primary_fit_posture,
                                                               result.siam_secondary_fit,
                                                               result.siam_secondary_fit_score,
                                                               result.siam_fit_gap_posture,
                                                               result.siam_fit_gap_score);
      result.siam_setup_fit_caution = "setup-fit is supportive only; it does not replace shortlist authority, Market Board field context, or live execution confirmation";
      result.siam_setup_fit_conclusion = ASC_DeepSetupFitConclusion(result.siam_primary_fit,
                                                                    result.siam_primary_fit_score,
                                                                    result.siam_primary_fit_posture,
                                                                    result.siam_secondary_fit,
                                                                    result.siam_secondary_fit_score,
                                                                    result.siam_secondary_fit_posture,
                                                                    result.siam_fit_gap_score,
                                                                    result.siam_fit_gap_posture);
     }

   ENUM_TIMEFRAMES timeframes[];
   int timeframe_count = ASC_DeepCollectEnabledTimeframes(timeframes);
   bool fallback_timeframes_used = false;
   if(timeframe_count <= 0)
     {
      timeframe_count = ASC_DeepCollectSafeFallbackTimeframes(timeframes);
      fallback_timeframes_used = (timeframe_count > 0);
     }
   result.enabled_timeframe_count = timeframe_count;

   string timeframe_analytic_summary = "";
   string timeframe_compact_summary = "";
   string ohlc_by_enabled_timeframe = "";

   int requested_ticks = MathMax(1, g_asc_trader_controls.deep_recent_tick_window);
   int requested_spread = MathMax(1, g_asc_trader_controls.deep_rolling_spread_window);
   int requested_capture = MathMax(requested_ticks, requested_spread);
   result.tick_window_requested = requested_ticks;
   result.spread_window_requested = requested_spread;

   string recent_tick_activity = "";
   string live_spread_rollover = "";
   string microstructure_notes = "";

   bool spread_support_ready = false;
   int spread_support_samples = 0;
   double spread_avg_points = -1.0;
   int uptick_count = 0;
   int downtick_count = 0;
   int flat_tick_count = 0;
   double first_mid_price = -1.0;
   double last_mid_price = -1.0;
   double newest_spread_points = -1.0;
   int tick_span_seconds = 0;
   datetime oldest_tick_utc = 0;
   datetime newest_tick_utc = 0;
   int rates_complete_timeframes = 0;
   int rates_partial_timeframes = 0;
   int rates_missing_timeframes = 0;
   int rates_sufficient_timeframes = 0;
   datetime newest_bar_utc = 0;

   MqlTick ticks[];
   ArraySetAsSeries(ticks, true);
   int copied_ticks = (int)CopyTicks(selected.symbol, ticks, COPY_TICKS_INFO, 0, requested_capture);
   if(copied_ticks < 0)
      copied_ticks = 0;

   result.tick_window_copied = MathMin(requested_ticks, copied_ticks);
   result.spread_window_copied = MathMin(requested_spread, copied_ticks);
   result.ticks_status = ASC_DeepTicksStatusFromCopies(requested_ticks, result.tick_window_copied);

   recent_tick_activity += StringFormat("requested_ticks=%d | copied_ticks=%d | ticks_status=%s\n", requested_ticks, result.tick_window_copied, result.ticks_status);
   if(copied_ticks <= 0)
     {
      recent_tick_activity += "no recent tick activity was returned for the selected symbol\n";
      live_spread_rollover += StringFormat("requested_spread_samples=%d | copied_spread_samples=0\n", requested_spread);
      live_spread_rollover += "rolling spread window is unavailable because no recent ticks were returned\n";
      microstructure_notes += "recent tick copy returned no data; microstructure notes are limited to packet-level posture\n";
      result.impulse_count_window = 0;
      result.time_since_last_impulse_sec = -1;
     }
   else
     {
      int tick_limit = MathMin(requested_ticks, copied_ticks);
      int mid_count = 0;
      double mid_prices[];
      datetime mid_times[];
      ArrayResize(mid_prices, tick_limit);
      ArrayResize(mid_times, tick_limit);

      if(tick_limit > 0)
        {
         oldest_tick_utc = (datetime)ticks[tick_limit - 1].time;
         newest_tick_utc = (datetime)ticks[0].time;
         tick_span_seconds = (int)MathMax(0, newest_tick_utc - oldest_tick_utc);
        }

      double previous_mid_price = -1.0;
      for(int i = tick_limit - 1; i >= 0; i--)
        {
         double spread_points = (ticks[i].ask > 0.0 && ticks[i].bid > 0.0 && point > 0.0)
                                ? ((ticks[i].ask - ticks[i].bid) / point)
                                : -1.0;
         double mid_price = (ticks[i].ask > 0.0 && ticks[i].bid > 0.0)
                            ? ((ticks[i].ask + ticks[i].bid) * 0.5)
                            : -1.0;
         if(mid_price > 0.0)
           {
            if(first_mid_price < 0.0)
               first_mid_price = mid_price;
            last_mid_price = mid_price;
            if(previous_mid_price > 0.0)
              {
               if(mid_price > previous_mid_price)
                  uptick_count++;
               else if(mid_price < previous_mid_price)
                  downtick_count++;
               else
                  flat_tick_count++;
              }
            previous_mid_price = mid_price;

            if(mid_count < tick_limit)
              {
               mid_prices[mid_count] = mid_price;
               mid_times[mid_count] = (datetime)ticks[i].time;
               mid_count++;
              }
           }

         recent_tick_activity += StringFormat("%s | bid=%s | ask=%s | spread_points=%s\n",
                                              ASC_ArtifactFormatUtc((datetime)ticks[i].time),
                                              ticks[i].bid > 0.0 ? DoubleToString(ticks[i].bid, price_digits) : "unavailable",
                                              ticks[i].ask > 0.0 ? DoubleToString(ticks[i].ask, price_digits) : "unavailable",
                                              spread_points >= 0.0 ? DoubleToString(spread_points, 2) : "unavailable");
        }

      int spread_limit = MathMin(requested_spread, copied_ticks);
      double spread_min = -1.0;
      double spread_max = -1.0;
      double spread_sum = 0.0;
      int spread_valid = 0;

      live_spread_rollover += StringFormat("requested_spread_samples=%d | copied_spread_samples=%d\n", requested_spread, spread_limit);
      for(int i = spread_limit - 1; i >= 0; i--)
        {
         double spread_points = (ticks[i].ask > 0.0 && ticks[i].bid > 0.0 && point > 0.0)
                                ? ((ticks[i].ask - ticks[i].bid) / point)
                                : -1.0;
         live_spread_rollover += StringFormat("%s | spread_points=%s\n",
                                              ASC_ArtifactFormatUtc((datetime)ticks[i].time),
                                              spread_points >= 0.0 ? DoubleToString(spread_points, 2) : "unavailable");
         if(spread_points < 0.0)
            continue;
         if(spread_min < 0.0 || spread_points < spread_min)
            spread_min = spread_points;
         if(spread_max < 0.0 || spread_points > spread_max)
            spread_max = spread_points;
         spread_sum += spread_points;
         spread_valid++;
        }

      if(spread_limit > 0 && ticks[0].ask > 0.0 && ticks[0].bid > 0.0 && point > 0.0)
         newest_spread_points = (ticks[0].ask - ticks[0].bid) / point;

      if(spread_valid > 0)
        {
         spread_avg_points = spread_sum / spread_valid;
         spread_support_samples = spread_valid;
         spread_support_ready = true;
         live_spread_rollover += StringFormat("spread_min_points=%s | spread_max_points=%s | spread_avg_points=%s\n",
                                              DoubleToString(spread_min, 2),
                                              DoubleToString(spread_max, 2),
                                              DoubleToString(spread_avg_points, 2));
         microstructure_notes += ASC_DeepSpreadPostureFromAverage(spread_avg_points, spread_valid) + "\n";
        }
      else
        {
         live_spread_rollover += "spread summary unavailable because every captured tick lacked valid bid/ask values\n";
         microstructure_notes += "captured ticks lacked enough bid/ask detail to produce a spread summary\n";
        }

      if(spread_support_ready && has_packet && packet.valid_last_price && packet.last_price > 0.0 && point > 0.0)
        {
         double live_spread_pct = ((spread_avg_points * point) / packet.last_price) * 100.0;
         result.spread_quality_score = ASC_DeepRoundScore(100.0 - MathMin(100.0, (live_spread_pct / execution_spread_cap_pct) * 100.0));
        }
      if(spread_support_ready)
        {
         double live_spread_to_atr = -1.0;
         if(has_packet && packet.valid_atr_points && packet.atr_points > 0.0)
            live_spread_to_atr = spread_avg_points / packet.atr_points;
         else if(has_packet && packet.valid_spread_to_atr && packet.spread_to_atr >= 0.0)
            live_spread_to_atr = packet.spread_to_atr;
         if(live_spread_to_atr >= 0.0)
            result.friction_quality_score = ASC_DeepRoundScore(100.0 - MathMin(100.0, (live_spread_to_atr / 0.85) * 100.0));
         result.execution_score = ASC_DeepRoundScore((result.spread_quality_score + result.friction_quality_score + result.liquidity_quality_score) / 3.0);
         result.execution_penalty = ASC_DeepRoundScore(100.0 - result.execution_score);
         result.execution_posture = ASC_DeepExecutionPosture(result.execution_score, result.execution_penalty);
        }

      bool trade_mode_full = (has_packet && packet.valid_trade_mode && packet.trade_mode == SYMBOL_TRADE_MODE_FULL);
      bool spec_lawful = (!has_packet || (packet.has_specification && !packet.spec_is_degraded));
      bool spread_context_ready = spread_support_ready;
      bool scalp_ready = (trade_mode_full && spec_lawful && spread_context_ready && result.execution_score >= 60.0 && result.friction_quality_score >= 45.0);
      bool intraday_ready = (trade_mode_full && spec_lawful && result.execution_score >= 50.0 && result.friction_quality_score >= 35.0);
      result.scalp_tradable = scalp_ready ? "yes" : "no";
      result.intraday_tradable = intraday_ready ? "yes" : "no";

      double base_move_pct = (has_packet && packet.valid_atr_pct && packet.atr_pct > 0.0) ? packet.atr_pct : 0.10;
      if(base_move_pct <= 0.0)
         base_move_pct = 0.10;

      int total_transitions = MathMax(0, mid_count - 1);
      if(total_transitions > 0)
        {
         int split_index = mid_count / 2;
         if(split_index <= 0)
            split_index = 1;
         if(split_index >= mid_count)
            split_index = mid_count - 1;

         int prev_up = 0;
         int prev_down = 0;
         int prev_flat = 0;
         int now_up = 0;
         int now_down = 0;
         int now_flat = 0;
         int current_run_sign = 0;
         datetime current_run_start_utc = 0;
         result.impulse_count_window = 0;

         for(int j = 1; j < mid_count; j++)
           {
            double step_change = mid_prices[j] - mid_prices[j - 1];
            int step_sign = ASC_DeepDirectionalSign(step_change, point * 0.10);
            bool in_now_window = (j > split_index);

            if(step_sign > 0)
              {
               if(in_now_window)
                  now_up++;
               else
                  prev_up++;
              }
            else if(step_sign < 0)
              {
               if(in_now_window)
                  now_down++;
               else
                  prev_down++;
              }
            else
              {
               if(in_now_window)
                  now_flat++;
               else
                  prev_flat++;
              }

            if(step_sign != 0)
              {
               if(current_run_sign == 0 || step_sign != current_run_sign)
                 {
                  current_run_sign = step_sign;
                  current_run_start_utc = mid_times[j - 1];
                  result.impulse_count_window++;
                 }
              }
           }

         if(result.impulse_count_window <= 0)
            result.impulse_count_window = 0;

         double prev_change_pct = (mid_prices[0] > 0.0)
                                  ? (((mid_prices[split_index] - mid_prices[0]) / mid_prices[0]) * 100.0)
                                  : 0.0;
         double now_change_pct = (mid_prices[split_index] > 0.0)
                                 ? (((mid_prices[mid_count - 1] - mid_prices[split_index]) / mid_prices[split_index]) * 100.0)
                                 : 0.0;

         result.tick_bias_prev_window = ASC_DeepTickBiasValue(prev_up, prev_down);
         result.tick_bias_now = ASC_DeepTickBiasValue(now_up, now_down);
         result.tick_shift = ASC_DeepClampSigned((result.tick_bias_now - result.tick_bias_prev_window), 100.0);
         result.pressure_shift_score = ASC_DeepRoundScore(50.0 + (result.tick_shift * 0.5));

         double bias_now_signed = result.tick_bias_now;
         result.pressure_shift_posture = ASC_DeepTacticalScorePosture(result.pressure_shift_score);

         result.momentum_delta = ASC_DeepClampSigned(now_change_pct - prev_change_pct, 100.0);
         result.momentum_speed = ASC_DeepRoundScore((MathAbs(now_change_pct) / base_move_pct) * 100.0);
         result.momentum_acceleration_score = ASC_DeepRoundScore(50.0 + ASC_DeepClampSigned(((MathAbs(now_change_pct) - MathAbs(prev_change_pct)) / base_move_pct) * 50.0, 50.0));
         result.momentum_acceleration_posture = ASC_DeepTacticalScorePosture(result.momentum_acceleration_score);

         double prev_participation = (100.0 * (prev_up + prev_down)) / MathMax(1, prev_up + prev_down + prev_flat);
         double now_participation = (100.0 * (now_up + now_down)) / MathMax(1, now_up + now_down + now_flat);
         result.participation_score = ASC_DeepRoundScore(now_participation);
         result.participation_delta = ASC_DeepClampSigned(now_participation - prev_participation, 100.0);
         if(result.participation_score >= 70.0 && result.participation_delta >= 8.0)
            result.participation_posture = "expanding";
         else if(result.participation_score >= 55.0 && result.participation_delta >= -5.0)
            result.participation_posture = "constructive";
         else if(result.participation_score >= 40.0)
            result.participation_posture = "balanced";
         else
            result.participation_posture = "fading";
         result.participation_state = ASC_DeepParticipationState(result.participation_delta);

         if(current_run_sign != 0 && current_run_start_utc > 0 && newest_tick_utc > 0)
            result.time_since_last_impulse_sec = (int)MathMax(0, newest_tick_utc - current_run_start_utc);
         else if(tick_span_seconds > 0)
            result.time_since_last_impulse_sec = tick_span_seconds;
         else
            result.time_since_last_impulse_sec = 0;

         double age_ratio = (tick_span_seconds > 0 && result.time_since_last_impulse_sec >= 0)
                            ? ((double)result.time_since_last_impulse_sec / MathMax(1.0, (double)tick_span_seconds))
                            : 1.0;
         double flip_penalty = MathMin(25.0, MathMax(0.0, (double)(result.impulse_count_window - 1) * 6.0));
         result.move_age_score = ASC_DeepRoundScore(100.0 - (age_ratio * 55.0) - flip_penalty);
         if(current_run_sign == 0 && MathAbs(now_change_pct) <= (base_move_pct * 0.05))
            result.move_age_score = 25.0;
         result.move_age_posture = ASC_DeepMoveAgePosture(result.move_age_score);
         result.impulse_state = ASC_DeepImpulseState(result.move_age_score, result.impulse_count_window);
         result.micro_direction = ASC_DeepMicroDirection(result.tick_bias_now);
         result.micro_conviction = ASC_DeepMicroConviction(result.tick_shift, result.participation_score);

         double pressure_energy_score = ASC_DeepRoundScore(50.0 + MathMin(50.0, MathAbs(result.tick_shift) * 0.5));
         result.tick_burst_score = ASC_DeepRoundScore((result.participation_score + result.momentum_speed + pressure_energy_score) / 3.0);
         result.tick_burst_flag = (result.tick_burst_score >= 70.0 && result.participation_score >= 55.0);
         if(result.tick_burst_score >= 80.0)
            result.tick_burst_posture = "active_burst";
         else if(result.tick_burst_score >= 65.0)
            result.tick_burst_posture = "watch_burst";
         else if(result.tick_burst_score >= 45.0)
            result.tick_burst_posture = "balanced";
         else
            result.tick_burst_posture = "quiet";
        }
      else
        {
         result.impulse_count_window = 0;
         result.time_since_last_impulse_sec = (tick_span_seconds > 0) ? tick_span_seconds : -1;
         result.impulse_state = "exhausted";
        }
     }

   double mid_change_pct = (first_mid_price > 0.0 && last_mid_price > 0.0)
                           ? (((last_mid_price - first_mid_price) / first_mid_price) * 100.0)
                           : 0.0;
   string tick_direction_bias = ASC_DeepTickBiasPosture(uptick_count, downtick_count, flat_tick_count);
   result.microstructure_summary = StringFormat("tick_bias=%s | upticks=%d | downticks=%d | flats=%d | mid_change=%s | newest_spread_points=%s | tick_span_seconds=%d | tick_bias_now=%.1f | tick_bias_prev=%.1f | tick_shift=%.1f | participation_score=%.1f | participation_delta=%.1f | participation_posture=%s | impulse_count_window=%d | time_since_last_impulse_sec=%d | oldest_tick_utc=%s | newest_tick_utc=%s",
                                                tick_direction_bias,
                                                uptick_count,
                                                downtick_count,
                                                flat_tick_count,
                                                (first_mid_price > 0.0 && last_mid_price > 0.0) ? ASC_DeepPercentText(mid_change_pct, 3) : "unavailable",
                                                newest_spread_points >= 0.0 ? DoubleToString(newest_spread_points, 2) : "unavailable",
                                                tick_span_seconds,
                                                result.tick_bias_now,
                                                result.tick_bias_prev_window,
                                                result.tick_shift,
                                                result.participation_score,
                                                result.participation_delta,
                                                result.participation_posture,
                                                result.impulse_count_window,
                                                result.time_since_last_impulse_sec,
                                                oldest_tick_utc > 0 ? ASC_ArtifactFormatUtc(oldest_tick_utc) : "unavailable",
                                                newest_tick_utc > 0 ? ASC_ArtifactFormatUtc(newest_tick_utc) : "unavailable");

   result.tactical_snapshot_summary += StringFormat(" | pressure_shift=%.1f (%s) | momentum_delta=%s | momentum_speed=%.1f | momentum_acceleration=%.1f (%s) | move_age=%.1f (%s) | participation=%.1f (%s) | execution=%.1f (%s) | tick_burst=%.1f (%s) | tick_burst_flag=%s",
                                                    result.pressure_shift_score,
                                                    result.pressure_shift_posture,
                                                    ASC_DeepPercentText(result.momentum_delta, 3),
                                                    result.momentum_speed,
                                                    result.momentum_acceleration_score,
                                                    result.momentum_acceleration_posture,
                                                    result.move_age_score,
                                                    result.move_age_posture,
                                                    result.participation_score,
                                                    result.participation_posture,
                                                    result.execution_score,
                                                    result.execution_posture,
                                                    result.tick_burst_score,
                                                    result.tick_burst_posture,
                                                    result.tick_burst_flag ? "yes" : "no");
   result.structure_liquidity_summary += StringFormat(" | position_in_range=%s | dist_high=%s | dist_low=%s | liquidity_score=%.1f | liquidity_zone=%s | liquidity_posture=%s",
                                                      ASC_DeepPercentText(result.position_in_range_pct, 2),
                                                      result.distance_to_recent_high_pct >= 0.0 ? ASC_DeepPercentText(result.distance_to_recent_high_pct, 3) : "unavailable",
                                                      result.distance_to_recent_low_pct >= 0.0 ? ASC_DeepPercentText(result.distance_to_recent_low_pct, 3) : "unavailable",
                                                      result.liquidity_proximity_score,
                                                      result.liquidity_zone,
                                                      result.liquidity_proximity_posture);
   microstructure_notes += result.microstructure_summary + "\n";

   int short_up_count = 0;
   int short_down_count = 0;
   int short_total_count = 0;
   int mid_up_count = 0;
   int mid_down_count = 0;
   int mid_total_count = 0;
   int higher_up_count = 0;
   int higher_down_count = 0;
   int higher_total_count = 0;

   for(int i = 0; i < timeframe_count; i++)
     {
      ENUM_TIMEFRAMES timeframe = timeframes[i];
      string label = ASC_DeepTimeframeLabel(timeframe);
      int requested_bars = ASC_DeepRequestedBars(timeframe);
      result.total_bars_requested += MathMax(0, requested_bars);

      MqlRates rates[];
      ArraySetAsSeries(rates, true);
      int copied = CopyRates(selected.symbol, timeframe, 0, requested_bars, rates);
      if(copied < 0)
         copied = 0;
      result.total_bars_copied += copied;
      if(copied <= 0)
         rates_missing_timeframes++;
      else if(copied < requested_bars)
         rates_partial_timeframes++;
      else
         rates_complete_timeframes++;
      if(copied > 0 && rates[0].time > newest_bar_utc)
         newest_bar_utc = rates[0].time;

      int sufficiency_floor = MathMin(requested_bars, 20);
      if(sufficiency_floor <= 0)
         sufficiency_floor = 1;
      int atr_period = 14;
      int minimum_bars_for_atr = atr_period + 1;
      bool bars_sufficient = (copied >= MathMax(sufficiency_floor, minimum_bars_for_atr));
      if(bars_sufficient)
         rates_sufficient_timeframes++;
      string bars_sufficiency = copied <= 0
                                ? "unavailable (no bars copied)"
                                : (bars_sufficient
                                   ? StringFormat("sufficient (%d/%d)", copied, requested_bars)
                                   : StringFormat("insufficient (%d/%d)", copied, requested_bars));

      if(copied <= 0)
        {
         ohlc_by_enabled_timeframe += StringFormat("[%s] requested=%d copied=0 | no OHLC bars returned\n", label, requested_bars);
         timeframe_analytic_summary += StringFormat("%s | Bars Requested=%d | Bars Copied=0 | Bar Sufficiency=%s | ATR=unavailable | ATR%%=unavailable | Regime=unavailable | Volatility Posture=unavailable | Friction Posture=unavailable | Liquidity Posture=unavailable | Spread Posture=unavailable | Drift Posture=unavailable | Range Posture=unavailable | Freshness/Readiness Note=unavailable (no bars copied)\n",
                                                    label,
                                                    requested_bars,
                                                    bars_sufficiency);
         timeframe_compact_summary += ASC_DeepCompactTimeframeReadback(label,
                                                              "unavailable",
                                                              "unavailable",
                                                              "unavailable",
                                                              "unavailable",
                                                              "unavailable",
                                                              "unavailable");
         continue;
        }

      ohlc_by_enabled_timeframe += StringFormat("[%s] requested=%d copied=%d\n", label, requested_bars, copied);
      for(int r = copied - 1; r >= 0; r--)
        {
         ohlc_by_enabled_timeframe += StringFormat("%s | O=%s H=%s L=%s C=%s V=%I64d\n",
                                                   ASC_ArtifactFormatUtc(rates[r].time),
                                                   DoubleToString(rates[r].open, 5),
                                                   DoubleToString(rates[r].high, 5),
                                                   DoubleToString(rates[r].low, 5),
                                                   DoubleToString(rates[r].close, 5),
                                                   rates[r].tick_volume);
        }

      int interpretation_window = MathMin(copied, 20);
      double highest = rates[0].high;
      double lowest = rates[0].low;
      double volume_sum = 0.0;
      int volume_samples = 0;
      for(int r = 0; r < interpretation_window; r++)
        {
         if(rates[r].high > highest)
            highest = rates[r].high;
         if(rates[r].low < lowest)
            lowest = rates[r].low;
         if(r > 0)
           {
            volume_sum += (double)rates[r].tick_volume;
            volume_samples++;
           }
        }

      double latest_close = rates[0].close;
      double window_open = rates[interpretation_window - 1].open;
      double window_range_price = highest - lowest;
      double drift_price = latest_close - window_open;
      double drift_pct = (window_open > 0.0) ? (drift_price / window_open) * 100.0 : 0.0;
      double range_pct = (latest_close > 0.0) ? (window_range_price / latest_close) * 100.0 : -1.0;
      bool return_1_ready = (copied > 1 && rates[1].close > 0.0);
      bool return_3_ready = (copied > 3 && rates[3].close > 0.0);
      bool return_5_ready = (copied > 5 && rates[5].close > 0.0);
      double return_1_pct = return_1_ready ? (((latest_close - rates[1].close) / rates[1].close) * 100.0) : 0.0;
      double return_3_pct = return_3_ready ? (((latest_close - rates[3].close) / rates[3].close) * 100.0) : 0.0;
      double return_5_pct = return_5_ready ? (((latest_close - rates[5].close) / rates[5].close) * 100.0) : 0.0;
      double close_location_pct = (window_range_price > 0.0) ? (((latest_close - lowest) / window_range_price) * 100.0) : -1.0;
      double distance_high_pct = (latest_close > 0.0 && highest >= latest_close) ? (((highest - latest_close) / latest_close) * 100.0) : 0.0;
      double distance_low_pct = (latest_close > 0.0 && latest_close >= lowest) ? (((latest_close - lowest) / latest_close) * 100.0) : 0.0;
      double average_prior_volume = (volume_samples > 0) ? (volume_sum / volume_samples) : 0.0;
      double volume_ratio = (average_prior_volume > 0.0) ? ((double)rates[0].tick_volume / average_prior_volume) : -1.0;

      double atr_price = 0.0;
      int atr_samples = 0;
      bool atr_ready = ASC_DeepComputeAtrPrice(rates, copied, atr_period, atr_price, atr_samples);
      double atr_points = atr_ready ? (atr_price / point) : 0.0;
      double atr_pct = (atr_ready && latest_close > 0.0) ? ((atr_price / latest_close) * 100.0) : -1.0;

      string regime = (bars_sufficient && atr_ready) ? ASC_DeepRegimeLabel(atr_pct, range_pct, drift_pct)
                                                     : "unavailable (insufficient bars)";
      string volatility_posture = (bars_sufficient && atr_ready) ? ASC_DeepVolatilityPosture(atr_pct)
                                                                 : "unavailable (insufficient bars)";
      string drift_posture = (bars_sufficient && atr_ready) ? ASC_DeepDriftPosture(drift_pct, atr_pct)
                                                            : ASC_DeepDriftDirection(drift_price);
      string range_posture = (bars_sufficient && atr_ready) ? ASC_DeepRangePosture(range_pct, atr_pct)
                                                            : (window_range_price > 0.0 ? "range evidence captured (insufficient bars for posture)" : "range evidence unavailable");
      string momentum_posture = (bars_sufficient && atr_ready && return_3_ready && return_5_ready)
                                ? ASC_DeepMomentumPosture(return_3_pct, return_5_pct, atr_pct)
                                : "unavailable (insufficient bars)";
      string location_posture = ASC_DeepWindowLocationPosture(close_location_pct);
      string structure_state = ASC_DeepStructureWindowState(close_location_pct, distance_high_pct, distance_low_pct, return_3_ready ? return_3_pct : drift_pct);
      string participation_posture = ASC_DeepParticipationPosture(volume_ratio);

      if(return_3_ready)
        {
         if(return_3_pct > 0.0)
            result.upward_timeframe_count++;
         else if(return_3_pct < 0.0)
            result.downward_timeframe_count++;

         if(timeframe == PERIOD_M1 || timeframe == PERIOD_M5)
           {
            short_total_count++;
            if(return_3_pct > 0.0)
               short_up_count++;
            else if(return_3_pct < 0.0)
               short_down_count++;
           }
         else if(timeframe == PERIOD_M15)
           {
            mid_total_count++;
            if(return_3_pct > 0.0)
               mid_up_count++;
            else if(return_3_pct < 0.0)
               mid_down_count++;
           }
         else if(timeframe == PERIOD_H1 || timeframe == PERIOD_H4 || timeframe == PERIOD_D1)
           {
            higher_total_count++;
            if(return_3_pct > 0.0)
               higher_up_count++;
            else if(return_3_pct < 0.0)
               higher_down_count++;
           }
        }
      if(regime == "Expansion")
         result.expansion_timeframe_count++;
      else if(regime == "Compression")
         result.compression_timeframe_count++;

      double spread_to_atr = (spread_support_ready && atr_ready && atr_points > 0.0) ? (spread_avg_points / atr_points) : -1.0;
      string spread_posture = ASC_DeepSpreadPostureProjected(spread_support_ready, spread_to_atr);
      string friction_posture = ASC_DeepFrictionPostureProjected(spread_support_ready, spread_to_atr);
      string liquidity_posture = ASC_DeepLiquidityPostureProjected(spread_support_ready, spread_to_atr);

      string readiness_note = "partial";
      if(!bars_sufficient)
         readiness_note = StringFormat("insufficient (bars copied=%d, required_min=%d for ATR(%d))", copied, MathMax(sufficiency_floor, minimum_bars_for_atr), atr_period);
      else if(!atr_ready)
         readiness_note = StringFormat("partial (ATR samples %d/%d unavailable)", atr_samples, atr_period);
      else if(!spread_support_ready)
         readiness_note = StringFormat("partial (insufficient spread sample support %d/%d)", spread_support_samples, requested_spread);
      else
         readiness_note = StringFormat("ready (bars and ATR(%d) sufficient; microstructure projected from shared live spread window %d samples)", atr_period, spread_support_samples);

      timeframe_analytic_summary += StringFormat("%s | Bars Requested=%d | Bars Copied=%d | Bar Sufficiency=%s | ATR=%s | ATR%%=%s | Regime=%s | Volatility Posture=%s | Friction Posture=%s | Liquidity Posture=%s | Spread Posture=%s | Drift Posture=%s | Range Posture=%s | Return1=%s | Return3=%s | Return5=%s | Momentum=%s | CloseLoc=%s | Structure=%s | DistHigh=%s | DistLow=%s | Participation=%s | Freshness/Readiness Note=%s\n",
                                                 label,
                                                 requested_bars,
                                                 copied,
                                                 bars_sufficiency,
                                                 atr_ready ? DoubleToString(atr_points, 2) : "unavailable (insufficient bars)",
                                                 atr_ready ? ASC_DeepPercentText(atr_pct, 3) : "unavailable (insufficient bars)",
                                                 regime,
                                                 volatility_posture,
                                                 friction_posture,
                                                 liquidity_posture,
                                                 spread_posture,
                                                 drift_posture,
                                                 range_posture,
                                                 return_1_ready ? ASC_DeepPercentText(return_1_pct, 3) : "unavailable",
                                                 return_3_ready ? ASC_DeepPercentText(return_3_pct, 3) : "unavailable",
                                                 return_5_ready ? ASC_DeepPercentText(return_5_pct, 3) : "unavailable",
                                                 momentum_posture,
                                                 close_location_pct >= 0.0 ? (ASC_DeepPercentText(close_location_pct, 1) + " | " + location_posture) : "unavailable",
                                                 structure_state,
                                                 ASC_DeepPercentText(distance_high_pct, 3),
                                                 ASC_DeepPercentText(distance_low_pct, 3),
                                                 participation_posture,
                                                 readiness_note);
      timeframe_compact_summary += ASC_DeepCompactTimeframeReadback(label,
                                                          drift_posture,
                                                          momentum_posture,
                                                          close_location_pct >= 0.0 ? ASC_DeepPercentText(close_location_pct, 1) : "unavailable",
                                                          ASC_DeepPercentText(distance_high_pct, 3),
                                                          ASC_DeepPercentText(distance_low_pct, 3),
                                                          participation_posture);
     }

   result.short_term_bias = ASC_DeepBiasFromDirectionalCounts(short_up_count, short_down_count, short_total_count);
   result.mid_term_bias = ASC_DeepBiasFromDirectionalCounts(mid_up_count, mid_down_count, mid_total_count);
   result.higher_timeframe_bias = ASC_DeepBiasFromDirectionalCounts(higher_up_count, higher_down_count, higher_total_count);
   result.alignment = ASC_DeepBiasAlignment(result.short_term_bias,
                                            result.mid_term_bias,
                                            result.higher_timeframe_bias);

   bool bars_available = (result.total_bars_copied > 0);
   bool ticks_available = (result.tick_window_copied > 0 || result.spread_window_copied > 0);
   if(bars_available && ticks_available)
      result.data_tier = "tier_1_full_deep";
   else if(bars_available)
      result.data_tier = "tier_2_historical_only_deep";
   else if(ticks_available)
      result.data_tier = "tier_3_microstructure_only_deep";
   else
      result.data_tier = "tier_4_metadata_spec_session_only";

   if(result.data_tier == "tier_1_full_deep")
      result.build_context = fallback_timeframes_used ? "tier_1_full_deep_with_safe_timeframe_fallback" : "tier_1_full_deep";
   else if(result.data_tier == "tier_2_historical_only_deep")
      result.build_context = fallback_timeframes_used ? "tier_2_historical_only_with_safe_timeframe_fallback" : "tier_2_historical_only";
   else if(result.data_tier == "tier_3_microstructure_only_deep")
      result.build_context = "tier_3_microstructure_only";
   else
      result.build_context = "tier_4_metadata_spec_session_only";

   result.rates_status = ASC_DeepRatesStatusFromCoverage(timeframe_count,
                                                         rates_complete_timeframes,
                                                         rates_partial_timeframes,
                                                         rates_missing_timeframes,
                                                         result.total_bars_copied);
   result.rates_support_status = result.rates_status;
   result.rates_partial_reason = ASC_DeepRatesPartialReasonToken(result.total_bars_requested,
                                                                result.total_bars_copied,
                                                                rates_complete_timeframes,
                                                                rates_partial_timeframes,
                                                                rates_missing_timeframes);
   result.rates_unavailable_reason = ASC_DeepRatesUnavailableReasonToken(result.total_bars_requested,
                                                                        result.total_bars_copied,
                                                                        rates_missing_timeframes);
   result.rates_complete_support = ASC_DeepCompleteSupportToken(result.rates_status);
   result.timeframe_coverage = ASC_DeepTimeframeCoverageToken(timeframe_count,
                                                              rates_complete_timeframes,
                                                              rates_partial_timeframes,
                                                              rates_missing_timeframes);
   result.sample_status = ASC_DeepSampleStatusToken(result.rates_status,
                                                    result.ticks_status,
                                                    rates_sufficient_timeframes,
                                                    timeframe_count);
   result.ticks_support_status = result.ticks_status;
   result.ticks_partial_reason = ASC_DeepTicksPartialReasonToken(result.tick_window_requested,
                                                                result.tick_window_copied);
   result.ticks_unavailable_reason = ASC_DeepTicksUnavailableReasonToken(result.tick_window_requested,
                                                                        result.tick_window_copied);
   result.ticks_complete_support = ASC_DeepCompleteSupportToken(result.ticks_status);
   result.timeframe_requested = IntegerToString(timeframe_count);
   result.timeframe_available = IntegerToString(rates_complete_timeframes + rates_partial_timeframes);
   result.sample_size_status = result.sample_status;
   result.sample_limit_reason = ASC_DeepSampleLimitReasonToken(result.rates_status,
                                                              result.ticks_status,
                                                              rates_sufficient_timeframes,
                                                              timeframe_count);
   result.partial_timeframe_reason = ASC_DeepTimeframeBoundaryReasonToken(timeframe_count,
                                                                         rates_partial_timeframes,
                                                                         0);
   result.unavailable_timeframe_reason = ASC_DeepTimeframeBoundaryReasonToken(timeframe_count,
                                                                             0,
                                                                             rates_missing_timeframes);
   datetime newest_data_utc = newest_tick_utc;
   if(newest_bar_utc > newest_data_utc)
      newest_data_utc = newest_bar_utc;
   int data_age_sec = newest_data_utc > 0 ? (int)MathMax(0, now_utc - newest_data_utc) : -1;
   if(newest_data_utc <= 0)
      result.data_window_age = "unknown";
   else if(data_age_sec <= 900)
      result.data_window_age = "fresh";
   else
      result.data_window_age = "stale";

   int rates_age_sec = newest_bar_utc > 0 ? (int)MathMax(0, now_utc - newest_bar_utc) : -1;
   int ticks_age_sec = newest_tick_utc > 0 ? (int)MathMax(0, now_utc - newest_tick_utc) : -1;
   result.rates_window_age = (newest_bar_utc > 0) ? (rates_age_sec <= 900 ? "fresh_or_within_window" : "stale_or_older_window") : "unknown";
   result.ticks_window_age = (newest_tick_utc > 0) ? (ticks_age_sec <= 900 ? "fresh_or_within_window" : "stale_or_older_window") : "unknown";
   result.sample_window_age = result.data_window_age;
   result.rates_sync_status = (result.rates_status == "complete") ? "complete_support_observed" : "partial_or_unavailable_history_support";
   result.ticks_sync_status = (result.ticks_status == "complete") ? "complete_support_observed" : "partial_or_unavailable_tick_support";
   result.resolver_limit = ASC_DeepResolverLimitToken(result);
   result.l5_support_posture = ASC_DeepL5SupportPostureToken(result);
   result.l3_l4_authority = ASC_DeepAuthorityToken(result);
   result.artifact_projection = ASC_DeepArtifactProjectionToken(result);

   if(has_packet)
     {
      microstructure_notes += StringFormat("market_watch_packet_freshness=%s | continuity=%s | packet_age_ms=%d\n",
                                           ASC_L2FreshnessToOperatorText(packet.freshness),
                                           packet.continuity_backed ? "continuity" : "live",
                                           MathMax(0, packet.packet_age_sec) * 1000);
     }
   else
      microstructure_notes += "market_watch_packet_state=unavailable | deep build relied on direct history/tick pulls where possible\n";

   string coverage_status = ASC_DeepCoverageStatus(result, timeframe_count, fallback_timeframes_used);
   string coverage_limitations = ASC_DeepCoverageLimitations(result, timeframe_count, fallback_timeframes_used);

   string decision_support = "";
   decision_support += "manual_review_only=yes\n";
   decision_support += "shortlist_authority_remains_shortlist_context=yes\n";
   decision_support += "deep_analysis_changed_shortlist_authority=no\n";
   decision_support += StringFormat("coverage_honesty=%s\n", coverage_status);
   decision_support += StringFormat("coverage_limitations=%s\n", coverage_limitations);
   decision_support += StringFormat("next_operator_check=review Selection Filter, Shortlist Context, live spread posture, tactical refresh snapshot, and the active failure path for %s\n", result.canonical_symbol);
   decision_support += "automation_rights=none\n";
   decision_support += "auto_run_on_page_open=no\n";
   decision_support += ASC_DeepSupportProofTokens(result) + "\n";
   decision_support += "built_lawful_boundary=built_and_lawful_mean_selected_symbol_packet_was_composed_not_trade_ready_not_fresh_decisive\n";
   decision_support += "execution_boundary=trade_permission=false | entry_signal=false | execution_permission=false | final_trade_decision=false | strategy_edge_proof=false\n";
   decision_support += "copy_support_boundary=rates_complete_support_and_ticks_complete_support_require_copied_equals_requested_no_partial_copyrates_copyticks_overclaim\n";

   int source_age_ms = 0;
   if(has_packet)
      source_age_ms = MathMax(0, packet.packet_age_sec) * 1000;
   else
      source_age_ms = (int)MathMax(0, now_utc - selected.observed_at_utc) * 1000;

   double spec_min_lot = SymbolInfoDouble(selected.symbol, SYMBOL_VOLUME_MIN);
   double spec_max_lot = SymbolInfoDouble(selected.symbol, SYMBOL_VOLUME_MAX);
   double spec_lot_step = SymbolInfoDouble(selected.symbol, SYMBOL_VOLUME_STEP);
   double spec_contract_size = SymbolInfoDouble(selected.symbol, SYMBOL_TRADE_CONTRACT_SIZE);
   double spec_tick_size = SymbolInfoDouble(selected.symbol, SYMBOL_TRADE_TICK_SIZE);
   double spec_tick_value = SymbolInfoDouble(selected.symbol, SYMBOL_TRADE_TICK_VALUE);
   double spec_swap_long = SymbolInfoDouble(selected.symbol, SYMBOL_SWAP_LONG);
   double spec_swap_short = SymbolInfoDouble(selected.symbol, SYMBOL_SWAP_SHORT);
   double spec_margin_initial = SymbolInfoDouble(selected.symbol, SYMBOL_MARGIN_INITIAL);
   string spec_trading_allowed = (has_packet && packet.valid_trade_mode && packet.trade_mode == SYMBOL_TRADE_MODE_DISABLED) ? "no" : "yes";
   result.sweep_state = "none";
   if(result.liquidity_zone == "upper_extreme")
      result.sweep_state = "recent_high_swept";
   else if(result.liquidity_zone == "lower_extreme")
      result.sweep_state = "recent_low_swept";

   int dominant_bias_sign = ASC_DeepBiasSign(result.alignment);
   if(dominant_bias_sign == 0)
      dominant_bias_sign = ASC_DeepBiasSign(result.mid_term_bias);
   if(dominant_bias_sign == 0)
      dominant_bias_sign = ASC_DeepBiasSign(result.short_term_bias);

   bool near_upper_extreme = (result.position_in_range_pct >= 85.0);
   bool near_lower_extreme = (result.position_in_range_pct <= 15.0);
   double upper_sweep_pressure = 50.0;
   if(near_upper_extreme)
      upper_sweep_pressure = 55.0 + (MathAbs(result.tick_shift) * 0.35) + (result.pressure_shift_score * 0.25);
   double lower_sweep_pressure = 50.0;
   if(near_lower_extreme)
      lower_sweep_pressure = 55.0 + (MathAbs(result.tick_shift) * 0.35) + ((100.0 - result.pressure_shift_score) * 0.25);

   if(upper_sweep_pressure >= lower_sweep_pressure)
     {
      result.session_sweep_score = ASC_DeepRoundScore(MathMin(100.0, upper_sweep_pressure));
      result.session_sweep_state = near_upper_extreme ? "recent_high_sweep_pressure" : "no_active_high_sweep";
     }
   else
     {
      result.session_sweep_score = ASC_DeepRoundScore(MathMin(100.0, lower_sweep_pressure));
      result.session_sweep_state = near_lower_extreme ? "recent_low_sweep_pressure" : "no_active_low_sweep";
     }

   double upper_reclaim_score = 0.0;
   if(near_upper_extreme)
      upper_reclaim_score = 45.0 + ((100.0 - result.pressure_shift_score) * 0.30) + (MathMax(0.0, -result.tick_shift) * 0.45) + (MathMax(0.0, 100.0 - result.move_age_score) * 0.15);
   double lower_reclaim_score = 0.0;
   if(near_lower_extreme)
      lower_reclaim_score = 45.0 + (result.pressure_shift_score * 0.30) + (MathMax(0.0, result.tick_shift) * 0.45) + (MathMax(0.0, 100.0 - result.move_age_score) * 0.15);

   if(upper_reclaim_score >= lower_reclaim_score)
     {
      result.reclaim_score = ASC_DeepRoundScore(MathMin(100.0, upper_reclaim_score));
      result.reclaim_state = near_upper_extreme ? ASC_DeepPressureFacingState(result.reclaim_score, 72.5, 57.5, "upper_sweep_reclaim_is_building", "upper_sweep_reclaim_attempt", "upper_sweep_reclaim_is_weak") : "no_upper_reclaim_context";
     }
   else
     {
      result.reclaim_score = ASC_DeepRoundScore(MathMin(100.0, lower_reclaim_score));
      result.reclaim_state = near_lower_extreme ? ASC_DeepPressureFacingState(result.reclaim_score, 72.5, 57.5, "lower_sweep_reclaim_is_building", "lower_sweep_reclaim_attempt", "lower_sweep_reclaim_is_weak") : "no_lower_reclaim_context";
     }

   result.failed_break_score = ASC_DeepRoundScore(MathMin(100.0,
                                                          (result.reclaim_score * 0.38)
                                                          + ((100.0 - result.move_age_score) * 0.16)
                                                          + ((near_upper_extreme || near_lower_extreme) ? 18.0 : 0.0)
                                                          + (MathAbs(result.tick_shift) * 0.22)
                                                          + ((dominant_bias_sign == 0) ? 6.0 : 0.0)));
   result.failed_break_state = ASC_DeepPressureFacingState(result.failed_break_score,
                                                           74.0,
                                                           58.0,
                                                           "failed_break_pressure_is_real",
                                                           "failed_break_watch",
                                                           "failed_break_not_confirmed");

   double pullback_anchor = 50.0;
   if(dominant_bias_sign > 0)
      pullback_anchor = 100.0 - result.position_in_range_pct;
   else if(dominant_bias_sign < 0)
      pullback_anchor = result.position_in_range_pct;
   result.pullback_depth_score = ASC_DeepRoundScore(pullback_anchor);

   double pullback_quality_seed = 0.0;
   if(dominant_bias_sign != 0)
     {
      pullback_quality_seed = (shortlist_entry.filter.context_strength_score * 0.28)
                              + (shortlist_entry.filter.execution_alignment_score * 0.18)
                              + (shortlist_entry.filter.session_alignment_score * 0.16)
                              + ((100.0 - shortlist_entry.filter.extension_risk_score) * 0.16)
                              + ((100.0 - shortlist_entry.filter.exhaustion_risk_score) * 0.12)
                              + ((100.0 - MathAbs(result.position_in_range_pct - 50.0) * 2.0) * 0.10);
     }
   else
      pullback_quality_seed = 45.0 + (shortlist_entry.filter.execution_alignment_score * 0.15) + (shortlist_entry.filter.session_alignment_score * 0.10);
   result.pullback_quality_score = ASC_DeepRoundScore(MathMin(100.0, pullback_quality_seed));
   result.pullback_state = ASC_DeepPullbackState(result.pullback_depth_score, result.pullback_quality_score);

   result.continuation_readiness_score = ASC_DeepRoundScore(MathMin(100.0,
                                                                    (shortlist_entry.filter.context_strength_score * 0.24)
                                                                    + (shortlist_entry.filter.entry_readiness_score * 0.26)
                                                                    + (shortlist_entry.filter.momentum_acceleration_score * 0.18)
                                                                    + (result.move_age_score * 0.14)
                                                                    + (result.reclaim_score * 0.10)
                                                                    + ((100.0 - result.failed_break_score) * 0.08)));

   result.reversal_pressure_score = ASC_DeepRoundScore(MathMin(100.0,
                                                               (result.failed_break_score * 0.28)
                                                               + (shortlist_entry.filter.pressure_shift_score * 0.18)
                                                               + (shortlist_entry.filter.exhaustion_risk_score * 0.20)
                                                               + (shortlist_entry.filter.late_move_risk_score * 0.18)
                                                               + ((near_upper_extreme || near_lower_extreme) ? 16.0 : 0.0)));

   result.trap_pressure_score = ASC_DeepRoundScore(MathMin(100.0,
                                                           (result.failed_break_score * 0.34)
                                                           + (result.reversal_pressure_score * 0.22)
                                                           + (shortlist_entry.filter.extension_risk_score * 0.18)
                                                           + (shortlist_entry.filter.exhaustion_risk_score * 0.16)
                                                           + ((dominant_bias_sign == 0) ? 8.0 : 0.0)
                                                           + ((near_upper_extreme || near_lower_extreme) ? 10.0 : 0.0)));

   result.move_freshness_score = ASC_DeepRoundScore(MathMin(100.0,
                                                            (result.move_age_score * 0.46)
                                                            + (result.tick_burst_score * 0.22)
                                                            + (result.momentum_acceleration_score * 0.18)
                                                            + ((100.0 - shortlist_entry.filter.late_move_risk_score) * 0.14)));
   result.freshness_state = ASC_DeepFreshnessState(result.move_freshness_score);

   result.continuation_state = ASC_DeepPressureFacingState(result.continuation_readiness_score,
                                                           74.0,
                                                           58.0,
                                                           "continuation_ready",
                                                           "continuation_building",
                                                           "continuation_fading");
   result.reversal_state = ASC_DeepPressureFacingState(result.reversal_pressure_score,
                                                       72.5,
                                                       57.5,
                                                       "reversal_pressure_is_building",
                                                       "reversal_watch",
                                                       "reversal_pressure_is_light");
   result.trap_pressure_state = ASC_DeepPressureFacingState(result.trap_pressure_score,
                                                            72.5,
                                                            57.5,
                                                            "trap_pressure_is_elevated",
                                                            "trap_pressure_watch",
                                                            "trap_pressure_is_light");

   result.siam_tactical_summary = ASC_DeepSiamTacticalSummary(result);
   result.path_split_state = ASC_DeepPathSplitState(result.siam_primary_fit_score, result.siam_secondary_fit_score);
   result.path_split_summary = ASC_DeepPathSplitSummary(result);
   result.path_contest_summary = ASC_DeepPathContestSummary(result);
   result.invalidation_trigger_summary = ASC_DeepInvalidationTriggerSummary(result, shortlist_entry);
   result.failure_invalidation_summary = ASC_DeepFailureInvalidationSummary(result);
   result.confidence_break_summary = ASC_DeepConfidenceBreakSummary(result, shortlist_entry);
   result.vulnerability_summary = ASC_DeepVulnerabilitySummary(result, dominant_bias_sign, near_upper_extreme, near_lower_extreme);
   decision_support += StringFormat("path_split_state=%s\n", result.path_split_state);
   decision_support += StringFormat("path_split_summary=%s\n", result.path_split_summary);
   decision_support += StringFormat("path_contest_summary=%s\n", result.path_contest_summary);
   decision_support += StringFormat("failure_invalidation=%s\n", result.failure_invalidation_summary);
   decision_support += StringFormat("invalidation_triggers=%s\n", result.invalidation_trigger_summary);
   decision_support += StringFormat("confidence_break=%s\n", result.confidence_break_summary);
   decision_support += StringFormat("vulnerability=%s\n", result.vulnerability_summary);

   result.tactical_snapshot_summary += StringFormat(" | freshness=%.1f (%s) | continuation=%.1f (%s) | reversal=%.1f (%s) | trap=%.1f (%s)",
                                                    result.move_freshness_score,
                                                    result.freshness_state,
                                                    result.continuation_readiness_score,
                                                    result.continuation_state,
                                                    result.reversal_pressure_score,
                                                    result.reversal_state,
                                                    result.trap_pressure_score,
                                                    result.trap_pressure_state);
   result.structure_liquidity_summary += StringFormat(" | sweep=%.1f (%s) | reclaim=%.1f (%s) | failed_break=%.1f (%s) | pullback_depth=%.1f | pullback_quality=%.1f (%s)",
                                                      result.session_sweep_score,
                                                      result.session_sweep_state,
                                                      result.reclaim_score,
                                                      result.reclaim_state,
                                                      result.failed_break_score,
                                                      result.failed_break_state,
                                                      result.pullback_depth_score,
                                                      result.pullback_quality_score,
                                                      result.pullback_state);

   result.summary_line = StringFormat("selected-symbol deep support packet | %d enabled timeframes | %d copied bars | %d recent ticks | %d spread samples | bias up/down %d/%d | expansion/compression %d/%d",
                                      timeframe_count,
                                      result.total_bars_copied,
                                      result.tick_window_copied,
                                      result.spread_window_copied,
                                      result.upward_timeframe_count,
                                      result.downward_timeframe_count,
                                      result.expansion_timeframe_count,
                                      result.compression_timeframe_count);
   if(fallback_timeframes_used)
      result.summary_line += " | safe timeframe fallback used";
   result.summary_line += StringFormat(" | packet_support %s", ASC_ArtifactHumanizeLabel(result.support_posture));
   result.summary_line += StringFormat(" | l5_support %s", result.l5_support_posture);
   result.summary_line += " | " + result.data_tier;
   result.summary_line += StringFormat(" | coverage %s", ASC_ArtifactHumanizeLabel(coverage_status));
   string cross_timeframe_summary = "";
   cross_timeframe_summary += StringFormat("deep_status=%s\n", result.built && result.lawful ? "completed" : "unavailable");
   cross_timeframe_summary += StringFormat("selected_symbol=%s\n", result.symbol);
   cross_timeframe_summary += StringFormat("canonical_symbol=%s\n", result.canonical_symbol);
   cross_timeframe_summary += "trigger_provenance=explicit_hud_deep_action\n";
   cross_timeframe_summary += StringFormat("execution_context=%s\n", result.execution_context);
   cross_timeframe_summary += StringFormat("shortlist_context=%s\n", result.shortlist_context);
   cross_timeframe_summary += StringFormat("shortlist_rank=%d\n", result.shortlist_rank);
   cross_timeframe_summary += StringFormat("market_state_context=%s\n", result.market_state_context);
   cross_timeframe_summary += StringFormat("support_posture=%s\n", result.support_posture);
   cross_timeframe_summary += StringFormat("build_context=%s\n", result.build_context);
   cross_timeframe_summary += StringFormat("data_tier=%s\n", result.data_tier);
   cross_timeframe_summary += ASC_DeepSupportProofTokens(result) + "\n";
   cross_timeframe_summary += StringFormat("rates_timeframes complete=%d partial=%d missing=%d sufficient=%d/%d\n", rates_complete_timeframes, rates_partial_timeframes, rates_missing_timeframes, rates_sufficient_timeframes, timeframe_count);
   cross_timeframe_summary += StringFormat("newest_bar_utc=%s | newest_tick_utc=%s\n", newest_bar_utc > 0 ? ASC_ArtifactFormatUtc(newest_bar_utc) : "unavailable", newest_tick_utc > 0 ? ASC_ArtifactFormatUtc(newest_tick_utc) : "unavailable");
   cross_timeframe_summary += StringFormat("entitlement_status=%s\n", result.entitlement_state);
   cross_timeframe_summary += StringFormat("last_refreshed_utc=%s\n", ASC_ArtifactFormatUtc(result.last_refreshed_utc));
   cross_timeframe_summary += StringFormat("deep_freshness=%s\n", result.freshness_posture);
   cross_timeframe_summary += StringFormat("deep_continuity=%s\n", result.continuity_posture);
   cross_timeframe_summary += StringFormat("coverage_status=%s\n", coverage_status);
   cross_timeframe_summary += StringFormat("coverage_limitations=%s\n", coverage_limitations);
   cross_timeframe_summary += StringFormat("enabled_timeframes_total=%d\n", timeframe_count);
   cross_timeframe_summary += StringFormat("copied_bars_total=%d\n", result.total_bars_copied);
   cross_timeframe_summary += StringFormat("copied_ticks_total=%d\n", result.tick_window_copied);
   cross_timeframe_summary += StringFormat("spread_samples_total=%d\n", result.spread_window_copied);
   cross_timeframe_summary += StringFormat("upward_timeframes=%d\n", result.upward_timeframe_count);
   cross_timeframe_summary += StringFormat("downward_timeframes=%d\n", result.downward_timeframe_count);
   cross_timeframe_summary += StringFormat("expansion_timeframes=%d\n", result.expansion_timeframe_count);
   cross_timeframe_summary += StringFormat("compression_timeframes=%d\n", result.compression_timeframe_count);
   cross_timeframe_summary += StringFormat("scalp_tradable=%s\n", result.scalp_tradable);
   cross_timeframe_summary += StringFormat("intraday_tradable=%s\n", result.intraday_tradable);
   cross_timeframe_summary += StringFormat("short_term_bias=%s\n", result.short_term_bias);
   cross_timeframe_summary += StringFormat("mid_term_bias=%s\n", result.mid_term_bias);
   cross_timeframe_summary += StringFormat("higher_timeframe_bias=%s\n", result.higher_timeframe_bias);
   cross_timeframe_summary += StringFormat("alignment=%s\n", result.alignment);
   cross_timeframe_summary += StringFormat("micro_direction=%s\n", result.micro_direction);
   cross_timeframe_summary += StringFormat("micro_conviction=%s\n", result.micro_conviction);
   cross_timeframe_summary += StringFormat("impulse_state=%s\n", result.impulse_state);
   cross_timeframe_summary += StringFormat("participation_state=%s\n", result.participation_state);
   cross_timeframe_summary += StringFormat("sweep_state=%s\n", result.sweep_state);
   cross_timeframe_summary += StringFormat("session_sweep_score=%.1f\n", result.session_sweep_score);
   cross_timeframe_summary += StringFormat("session_sweep_state=%s\n", result.session_sweep_state);
   cross_timeframe_summary += StringFormat("reclaim_score=%.1f\n", result.reclaim_score);
   cross_timeframe_summary += StringFormat("reclaim_state=%s\n", result.reclaim_state);
   cross_timeframe_summary += StringFormat("failed_break_score=%.1f\n", result.failed_break_score);
   cross_timeframe_summary += StringFormat("failed_break_state=%s\n", result.failed_break_state);
   cross_timeframe_summary += StringFormat("trap_pressure_score=%.1f\n", result.trap_pressure_score);
   cross_timeframe_summary += StringFormat("trap_pressure_state=%s\n", result.trap_pressure_state);
   cross_timeframe_summary += StringFormat("pullback_depth_score=%.1f\n", result.pullback_depth_score);
   cross_timeframe_summary += StringFormat("pullback_quality_score=%.1f\n", result.pullback_quality_score);
   cross_timeframe_summary += StringFormat("pullback_state=%s\n", result.pullback_state);
   cross_timeframe_summary += StringFormat("continuation_readiness_score=%.1f\n", result.continuation_readiness_score);
   cross_timeframe_summary += StringFormat("continuation_state=%s\n", result.continuation_state);
   cross_timeframe_summary += StringFormat("reversal_pressure_score=%.1f\n", result.reversal_pressure_score);
   cross_timeframe_summary += StringFormat("reversal_state=%s\n", result.reversal_state);
   cross_timeframe_summary += StringFormat("move_freshness_score=%.1f\n", result.move_freshness_score);
   cross_timeframe_summary += StringFormat("freshness_state=%s\n", result.freshness_state);
   cross_timeframe_summary += StringFormat("siam_tactical_summary=%s\n", result.siam_tactical_summary);
   cross_timeframe_summary += StringFormat("siam_primary_fit=%s\n", result.siam_primary_fit);
   cross_timeframe_summary += StringFormat("siam_primary_fit_score=%.1f\n", result.siam_primary_fit_score);
   cross_timeframe_summary += StringFormat("siam_primary_fit_posture=%s\n", result.siam_primary_fit_posture);
   cross_timeframe_summary += StringFormat("siam_primary_fit_reason=%s\n", result.siam_primary_fit_reason);
   cross_timeframe_summary += StringFormat("siam_secondary_fit=%s\n", result.siam_secondary_fit);
   cross_timeframe_summary += StringFormat("siam_secondary_fit_score=%.1f\n", result.siam_secondary_fit_score);
   cross_timeframe_summary += StringFormat("siam_secondary_fit_posture=%s\n", result.siam_secondary_fit_posture);
   cross_timeframe_summary += StringFormat("siam_secondary_fit_reason=%s\n", result.siam_secondary_fit_reason);
   cross_timeframe_summary += StringFormat("siam_setup_fit_caution=%s\n", result.siam_setup_fit_caution);
   cross_timeframe_summary += StringFormat("siam_setup_fit_conclusion=%s\n", result.siam_setup_fit_conclusion);
   cross_timeframe_summary += StringFormat("path_split_state=%s\n", result.path_split_state);
   cross_timeframe_summary += StringFormat("path_split_summary=%s\n", result.path_split_summary);
   cross_timeframe_summary += StringFormat("path_contest_summary=%s\n", result.path_contest_summary);
   cross_timeframe_summary += StringFormat("failure_invalidation_summary=%s\n", result.failure_invalidation_summary);
   cross_timeframe_summary += StringFormat("invalidation_trigger_summary=%s\n", result.invalidation_trigger_summary);
   cross_timeframe_summary += StringFormat("confidence_break_summary=%s\n", result.confidence_break_summary);
   cross_timeframe_summary += StringFormat("vulnerability_summary=%s\n", result.vulnerability_summary);
   cross_timeframe_summary += StringFormat("run_summary=%s\n", result.summary_line);
   string metadata_state = "fresh";
   if(result.preservation_state == "historical_only_rebuild")
      metadata_state = "historical";
   else if(result.preservation_state == "degraded_rebuild")
      metadata_state = "degraded";
   else if(result.continuity_posture == "continuity")
      metadata_state = "continuity";
   else if(selected.is_stale)
      metadata_state = "stale";

   string block = "";
   block += ASC_SectionMetadataBlock(metadata_state,
                                     result.entitlement_reason,
                                     IntegerToString(source_age_ms),
                                     result.continuity_posture,
                                     result.last_refreshed_utc);
   block += "Deep Selective Analysis [L5]: completed\n";
   block += "Deep Analysis Status: completed\n";
   block += "Deep Packet Focus: selected-symbol tactical support packet\n";
   block += StringFormat("Run Summary: %s\n", result.summary_line);
   block += StringFormat("L5 Support Proof: %s\n", ASC_DeepSupportProofTokens(result));

   block += "\nANALYST_HEADER\n";
   block += "----------------------------------------\n";
   block += StringFormat("symbol=%s | asset_class=%s | timestamp_utc=%s | freshness=%s | market_state=%s | tradable=%s\n",
                         result.canonical_symbol,
                         ASC_TextOrUnavailable(selected.classification.main_bucket_id),
                         ASC_ArtifactFormatUtc(result.last_refreshed_utc),
                         result.freshness_posture,
                         ASC_L1StateToOperatorText(selected.state),
                         spec_trading_allowed);

   block += "\nANALYST_EXECUTION\n";
   block += "----------------------------------------\n";
   block += StringFormat("bid=%s | ask=%s | spread_points=%s | spread_pct=%s | execution_score=%.1f | execution_posture=%s | friction_posture=%s | liquidity_quality=%.1f | scalp_tradable=%s | intraday_tradable=%s\n",
                         packet_bid_text,
                         packet_ask_text,
                         packet_spread_text,
                         packet_spread_pct_text,
                         result.execution_score,
                         result.execution_posture,
                         ASC_TextOrUnavailable(packet.friction_state),
                         result.liquidity_quality_score,
                         result.scalp_tradable,
                         result.intraday_tradable);

   block += "\nANALYST_POSITION_LIQUIDITY\n";
   block += "----------------------------------------\n";
   block += StringFormat("daily_open=%s | daily_change_pct=%s | position_in_range_pct=%s | distance_to_recent_high_pct=%s | distance_to_recent_low_pct=%s | liquidity_score=%.1f | liquidity_zone=%s | liquidity_posture=%s | sweep_state=%s\n",
                         has_packet && packet.valid_day_open ? DoubleToString(packet.day_open, price_digits) : "unavailable",
                         packet_daily_change_text,
                         ASC_DeepPercentText(result.position_in_range_pct, 2),
                         result.distance_to_recent_high_pct >= 0.0 ? ASC_DeepPercentText(result.distance_to_recent_high_pct, 3) : "unavailable",
                         result.distance_to_recent_low_pct >= 0.0 ? ASC_DeepPercentText(result.distance_to_recent_low_pct, 3) : "unavailable",
                         result.liquidity_proximity_score,
                         result.liquidity_zone,
                         result.liquidity_proximity_posture,
                         result.sweep_state);

   block += "\nANALYST_MICROSTRUCTURE\n";
   block += "----------------------------------------\n";
   block += StringFormat("tick_bias_now=%.1f | tick_bias_prev_window=%.1f | tick_shift=%.1f | upticks=%d | downticks=%d | flats=%d | pressure_shift_score=%.1f | pressure_shift_posture=%s | tick_burst_score=%.1f | tick_burst_flag=%s | micro_direction=%s | micro_conviction=%s\n",
                         result.tick_bias_now,
                         result.tick_bias_prev_window,
                         result.tick_shift,
                         uptick_count,
                         downtick_count,
                         flat_tick_count,
                         result.pressure_shift_score,
                         result.pressure_shift_posture,
                         result.tick_burst_score,
                         result.tick_burst_flag ? "yes" : "no",
                         result.micro_direction,
                         result.micro_conviction);

   block += "\nANALYST_MOMENTUM\n";
   block += "----------------------------------------\n";
   block += StringFormat("momentum_delta=%s | momentum_speed=%.1f | momentum_acceleration_score=%.1f | momentum_acceleration_posture=%s | move_age_score=%.1f | move_age_posture=%s | time_since_last_impulse_sec=%d | impulse_count_window=%d | impulse_state=%s\n",
                         ASC_DeepPercentText(result.momentum_delta, 3),
                         result.momentum_speed,
                         result.momentum_acceleration_score,
                         result.momentum_acceleration_posture,
                         result.move_age_score,
                         result.move_age_posture,
                         result.time_since_last_impulse_sec,
                         result.impulse_count_window,
                         result.impulse_state);
   block += StringFormat("siam_setup_fit=%s\n", result.siam_fit_summary);
   block += StringFormat("siam_primary_fit=%s (%.1f | %s)\n", result.siam_primary_fit, result.siam_primary_fit_score, result.siam_primary_fit_posture);
   block += StringFormat("siam_primary_fit_reason=%s\n", result.siam_primary_fit_reason);
   block += StringFormat("siam_secondary_fit=%s (%.1f | %s)\n", result.siam_secondary_fit, result.siam_secondary_fit_score, result.siam_secondary_fit_posture);
   block += StringFormat("siam_secondary_fit_reason=%s\n", result.siam_secondary_fit_reason);
   block += StringFormat("siam_setup_fit_caution=%s\n", result.siam_setup_fit_caution);
   block += StringFormat("siam_setup_fit_conclusion=%s\n", result.siam_setup_fit_conclusion);
   block += StringFormat("path_split_state=%s\n", result.path_split_state);
   block += StringFormat("path_split_summary=%s\n", result.path_split_summary);
   block += StringFormat("path_contest_summary=%s\n", result.path_contest_summary);
   block += StringFormat("failure_invalidation_summary=%s\n", result.failure_invalidation_summary);
   block += StringFormat("invalidation_trigger_summary=%s\n", result.invalidation_trigger_summary);
   block += StringFormat("confidence_break_summary=%s\n", result.confidence_break_summary);
   block += StringFormat("vulnerability_summary=%s\n", result.vulnerability_summary);

   block += "\nANALYST_SIAM_STRUCTURE\n";
   block += "----------------------------------------\n";
   block += StringFormat("move_freshness_score=%.1f | freshness_state=%s | session_sweep_score=%.1f | session_sweep_state=%s | reclaim_score=%.1f | reclaim_state=%s | failed_break_score=%.1f | failed_break_state=%s | trap_pressure_score=%.1f | trap_pressure_state=%s\n",
                         result.move_freshness_score,
                         result.freshness_state,
                         result.session_sweep_score,
                         result.session_sweep_state,
                         result.reclaim_score,
                         result.reclaim_state,
                         result.failed_break_score,
                         result.failed_break_state,
                         result.trap_pressure_score,
                         result.trap_pressure_state);
   block += StringFormat("pullback_depth_score=%.1f | pullback_quality_score=%.1f | pullback_state=%s | continuation_readiness_score=%.1f | continuation_state=%s | reversal_pressure_score=%.1f | reversal_state=%s\n",
                         result.pullback_depth_score,
                         result.pullback_quality_score,
                         result.pullback_state,
                         result.continuation_readiness_score,
                         result.continuation_state,
                         result.reversal_pressure_score,
                         result.reversal_state);

   block += "\nANALYST_PARTICIPATION\n";
   block += "----------------------------------------\n";
   block += StringFormat("participation_score=%.1f | participation_delta=%.1f | participation_posture=%s | participation_state=%s\n",
                         result.participation_score,
                         result.participation_delta,
                         result.participation_posture,
                         result.participation_state);

   block += "\nANALYST_HIERARCHY\n";
   block += "----------------------------------------\n";
   block += StringFormat("short_term_bias=%s | mid_term_bias=%s | higher_timeframe_bias=%s | alignment=%s\n",
                         result.short_term_bias,
                         result.mid_term_bias,
                         result.higher_timeframe_bias,
                         result.alignment);

   block += "\nANALYST_TIMEFRAME_DETAIL\n";
   block += "----------------------------------------\n";
   block += timeframe_count > 0 ? timeframe_compact_summary : "no enabled timeframes were configured\n";

   block += "\nANALYST_TRADING_SPECS\n";
   block += "----------------------------------------\n";
   block += StringFormat("min_lot=%s | max_lot=%s | lot_step=%s | contract_size=%s | tick_size=%s | tick_value=%s | swap_long=%s | swap_short=%s | margin_initial=%s | trading_allowed=%s\n",
                         spec_min_lot > 0.0 ? DoubleToString(spec_min_lot, 2) : "unavailable",
                         spec_max_lot > 0.0 ? DoubleToString(spec_max_lot, 2) : "unavailable",
                         spec_lot_step > 0.0 ? DoubleToString(spec_lot_step, 2) : "unavailable",
                         spec_contract_size > 0.0 ? DoubleToString(spec_contract_size, 2) : "unavailable",
                         spec_tick_size > 0.0 ? DoubleToString(spec_tick_size, 6) : "unavailable",
                         spec_tick_value > 0.0 ? DoubleToString(spec_tick_value, 6) : "unavailable",
                         DoubleToString(spec_swap_long, 4),
                         DoubleToString(spec_swap_short, 4),
                         spec_margin_initial > 0.0 ? DoubleToString(spec_margin_initial, 2) : "unavailable",
                         spec_trading_allowed);

   block += "\nDEBUG_FULL_VIEW\n";
   block += "----------------------------------------\n";
   block += "purpose=diagnostic_audit_and_full_trace\n";
   block += "scope=full metadata, preservation details, raw trace carry, and verbose timeframe detail\n";

   block += "\ndeep_analysis_overview\n";
   block += "----------------------------------------\n";
   block += StringFormat("symbol=%s\n", result.symbol);
   block += StringFormat("canonical_symbol=%s\n", result.canonical_symbol);
   block += StringFormat("entitlement_state=%s\n", result.entitlement_state);
   block += StringFormat("entitlement_reason=%s\n", result.entitlement_reason);
   block += StringFormat("execution_context=%s\n", result.execution_context);
   block += StringFormat("shortlist_context=%s\n", result.shortlist_context);
   block += StringFormat("shortlist_rank=%d\n", result.shortlist_rank);
   block += StringFormat("market_state_context=%s\n", result.market_state_context);
   block += StringFormat("support_posture=%s\n", result.support_posture);
   block += StringFormat("build_context=%s\n", result.build_context);
   block += StringFormat("data_tier=%s\n", result.data_tier);
   block += StringFormat("l5_support_posture=%s\n", result.l5_support_posture);
   block += StringFormat("rates_status=%s | rates_requested=%d | rates_copied=%d | rates_support_status=%s | rates_partial_reason=%s | rates_unavailable_reason=%s | rates_window_age=%s | rates_history_sync_status=%s | rates_complete_support=%s\n", result.rates_status, result.total_bars_requested, result.total_bars_copied, result.rates_support_status, result.rates_partial_reason, result.rates_unavailable_reason, result.rates_window_age, result.rates_sync_status, result.rates_complete_support);
   block += StringFormat("ticks_status=%s | ticks_requested=%d | ticks_copied=%d | ticks_support_status=%s | ticks_partial_reason=%s | ticks_unavailable_reason=%s | ticks_window_age=%s | ticks_sync_status=%s | ticks_complete_support=%s\n", result.ticks_status, result.tick_window_requested, result.tick_window_copied, result.ticks_support_status, result.ticks_partial_reason, result.ticks_unavailable_reason, result.ticks_window_age, result.ticks_sync_status, result.ticks_complete_support);
   block += StringFormat("timeframe_coverage=%s | timeframe_requested=%s | timeframe_available=%s | partial_timeframe_reason=%s | unavailable_timeframe_reason=%s\n", result.timeframe_coverage, result.timeframe_requested, result.timeframe_available, result.partial_timeframe_reason, result.unavailable_timeframe_reason);
   block += StringFormat("data_window_age=%s\n", result.data_window_age);
   block += StringFormat("sample_status=%s | sample_size_status=%s | sample_window_age=%s | sample_limit_reason=%s\n", result.sample_status, result.sample_size_status, result.sample_window_age, result.sample_limit_reason);
   block += StringFormat("l3_l4_authority=%s\n", result.l3_l4_authority);
   block += StringFormat("resolver_limit=%s\n", result.resolver_limit);
   block += StringFormat("artifact_projection=%s | dossier_l5_projection=consumer_only | current_focus_l5_projection=mirror_only_if_selected_symbol_exists | writers_do_not_own_l5_truth=true\n", result.artifact_projection);
   block += "l5_falsehoods=trade_permission=false | entry_signal=false | execution_permission=false | final_trade_decision=false | strategy_edge_proof=false | complete_evidence=false\n";
   block += StringFormat("freshness_posture=%s\n", result.freshness_posture);
   block += StringFormat("continuity_posture=%s\n", result.continuity_posture);
   block += StringFormat("coverage_status=%s\n", coverage_status);
   block += StringFormat("coverage_limitations=%s\n", coverage_limitations);
   block += StringFormat("tactical_snapshot_summary=%s\n", result.tactical_snapshot_summary);
   block += StringFormat("structure_liquidity_summary=%s\n", result.structure_liquidity_summary);
   block += StringFormat("session_timing_summary=%s\n", result.session_timing_summary);
   block += StringFormat("score_context_summary=%s\n", result.score_context_summary);
   block += StringFormat("microstructure_summary=%s\n", result.microstructure_summary);
   block += StringFormat("debug_recent_tick_activity_chars=%d\n", StringLen(recent_tick_activity));
   block += StringFormat("debug_spread_rollover_chars=%d\n", StringLen(live_spread_rollover));
   block += StringFormat("debug_ohlc_capture_chars=%d\n", StringLen(ohlc_by_enabled_timeframe));
   block += StringFormat("pressure_shift_score=%.1f\n", result.pressure_shift_score);
   block += StringFormat("pressure_shift_posture=%s\n", result.pressure_shift_posture);
   block += StringFormat("momentum_delta=%.3f\n", result.momentum_delta);
   block += StringFormat("momentum_speed=%.1f\n", result.momentum_speed);
   block += StringFormat("momentum_acceleration_score=%.1f\n", result.momentum_acceleration_score);
   block += StringFormat("momentum_acceleration_posture=%s\n", result.momentum_acceleration_posture);
   block += StringFormat("time_since_last_impulse_sec=%d\n", result.time_since_last_impulse_sec);
   block += StringFormat("impulse_count_window=%d\n", result.impulse_count_window);
   block += StringFormat("move_age_score=%.1f\n", result.move_age_score);
   block += StringFormat("move_age_posture=%s\n", result.move_age_posture);
   block += StringFormat("position_in_range_pct=%.2f\n", result.position_in_range_pct);
   block += StringFormat("distance_to_recent_high_pct=%s\n", result.distance_to_recent_high_pct >= 0.0 ? DoubleToString(result.distance_to_recent_high_pct, 3) : "unavailable");
   block += StringFormat("distance_to_recent_low_pct=%s\n", result.distance_to_recent_low_pct >= 0.0 ? DoubleToString(result.distance_to_recent_low_pct, 3) : "unavailable");
   block += StringFormat("liquidity_proximity_score=%.1f\n", result.liquidity_proximity_score);
   block += StringFormat("liquidity_zone=%s\n", result.liquidity_zone);
   block += StringFormat("liquidity_proximity_posture=%s\n", result.liquidity_proximity_posture);
   block += StringFormat("participation_score=%.1f\n", result.participation_score);
   block += StringFormat("participation_delta=%.1f\n", result.participation_delta);
   block += StringFormat("participation_posture=%s\n", result.participation_posture);
   block += StringFormat("execution_score=%.1f\n", result.execution_score);
   block += StringFormat("execution_penalty=%.1f\n", result.execution_penalty);
   block += StringFormat("execution_posture=%s\n", result.execution_posture);
   block += StringFormat("spread_quality_score=%.1f\n", result.spread_quality_score);
   block += StringFormat("friction_quality_score=%.1f\n", result.friction_quality_score);
   block += StringFormat("liquidity_quality_score=%.1f\n", result.liquidity_quality_score);
   block += StringFormat("tick_bias_now=%.1f\n", result.tick_bias_now);
   block += StringFormat("tick_bias_prev_window=%.1f\n", result.tick_bias_prev_window);
   block += StringFormat("tick_shift=%.1f\n", result.tick_shift);
   block += StringFormat("tick_burst_flag=%s\n", result.tick_burst_flag ? "yes" : "no");
   block += StringFormat("tick_burst_score=%.1f\n", result.tick_burst_score);
   block += StringFormat("tick_burst_posture=%s\n", result.tick_burst_posture);
   block += StringFormat("micro_direction=%s\n", result.micro_direction);
   block += StringFormat("micro_conviction=%s\n", result.micro_conviction);
   block += StringFormat("scalp_tradable=%s\n", result.scalp_tradable);
   block += StringFormat("intraday_tradable=%s\n", result.intraday_tradable);
   block += StringFormat("short_term_bias=%s\n", result.short_term_bias);
   block += StringFormat("mid_term_bias=%s\n", result.mid_term_bias);
   block += StringFormat("higher_timeframe_bias=%s\n", result.higher_timeframe_bias);
   block += StringFormat("alignment=%s\n", result.alignment);
   block += StringFormat("impulse_state=%s\n", result.impulse_state);
   block += StringFormat("participation_state=%s\n", result.participation_state);
   block += StringFormat("sweep_state=%s\n", result.sweep_state);
   block += StringFormat("session_sweep_score=%.1f\n", result.session_sweep_score);
   block += StringFormat("session_sweep_state=%s\n", result.session_sweep_state);
   block += StringFormat("reclaim_score=%.1f\n", result.reclaim_score);
   block += StringFormat("reclaim_state=%s\n", result.reclaim_state);
   block += StringFormat("failed_break_score=%.1f\n", result.failed_break_score);
   block += StringFormat("failed_break_state=%s\n", result.failed_break_state);
   block += StringFormat("trap_pressure_score=%.1f\n", result.trap_pressure_score);
   block += StringFormat("trap_pressure_state=%s\n", result.trap_pressure_state);
   block += StringFormat("pullback_depth_score=%.1f\n", result.pullback_depth_score);
   block += StringFormat("pullback_quality_score=%.1f\n", result.pullback_quality_score);
   block += StringFormat("pullback_state=%s\n", result.pullback_state);
   block += StringFormat("continuation_readiness_score=%.1f\n", result.continuation_readiness_score);
   block += StringFormat("continuation_state=%s\n", result.continuation_state);
   block += StringFormat("reversal_pressure_score=%.1f\n", result.reversal_pressure_score);
   block += StringFormat("reversal_state=%s\n", result.reversal_state);
   block += StringFormat("move_freshness_score=%.1f\n", result.move_freshness_score);
   block += StringFormat("freshness_state=%s\n", result.freshness_state);

   block += "\ncross_timeframe_summary\n";
   block += "----------------------------------------\n";
   block += cross_timeframe_summary;

   block += "\ntimeframe_analytic_summary\n";
   block += "----------------------------------------\n";
   block += timeframe_count > 0 ? timeframe_analytic_summary : "no enabled timeframes were configured\n";

   block += "\ndecision_support\n";
   block += "----------------------------------------\n";
   block += decision_support;

   block += "\nohlc_by_enabled_timeframe\n";
   block += "----------------------------------------\n";
   block += timeframe_count > 0 ? ohlc_by_enabled_timeframe : "no enabled timeframes were configured\n";

   block += "\nrecent_tick_activity\n";
   block += "----------------------------------------\n";
   block += recent_tick_activity;

   block += "\nlive_spread_rollover\n";
   block += "----------------------------------------\n";
   block += live_spread_rollover;

   block += "\nsiam_tactical_readback_canonical\n";
   block += "----------------------------------------\n";
   block += StringFormat("siam_tactical_summary=%s\n", result.siam_tactical_summary);
   block += StringFormat("freshness=%s (%.1f)\n", result.freshness_state, result.move_freshness_score);
   block += StringFormat("session_sweep=%s (%.1f) | reclaim=%s (%.1f) | failed_break=%s (%.1f)\n",
                         result.session_sweep_state,
                         result.session_sweep_score,
                         result.reclaim_state,
                         result.reclaim_score,
                         result.failed_break_state,
                         result.failed_break_score);
   block += StringFormat("pullback=%s (depth %.1f | quality %.1f) | continuation=%s (%.1f)\n",
                         result.pullback_state,
                         result.pullback_depth_score,
                         result.pullback_quality_score,
                         result.continuation_state,
                         result.continuation_readiness_score);
   block += StringFormat("reversal=%s (%.1f) | trap_pressure=%s (%.1f)\n",
                         result.reversal_state,
                         result.reversal_pressure_score,
                         result.trap_pressure_state,
                         result.trap_pressure_score);
   block += StringFormat("siam_primary_fit=%s (%.1f | %s)\n", result.siam_primary_fit, result.siam_primary_fit_score, result.siam_primary_fit_posture);
   block += StringFormat("siam_primary_fit_reason=%s\n", result.siam_primary_fit_reason);
   block += StringFormat("siam_secondary_fit=%s (%.1f | %s)\n", result.siam_secondary_fit, result.siam_secondary_fit_score, result.siam_secondary_fit_posture);
   block += StringFormat("siam_secondary_fit_reason=%s\n", result.siam_secondary_fit_reason);
   block += StringFormat("siam_setup_fit_caution=%s\n", result.siam_setup_fit_caution);
   block += StringFormat("siam_setup_fit_conclusion=%s\n", result.siam_setup_fit_conclusion);
   block += StringFormat("path_split_state=%s\n", result.path_split_state);
   block += StringFormat("path_split_summary=%s\n", result.path_split_summary);
   block += StringFormat("path_contest_summary=%s\n", result.path_contest_summary);
   block += StringFormat("alignment=%s | micro_direction=%s | micro_conviction=%s | scalp_tradable=%s | intraday_tradable=%s\n",
                         result.alignment,
                         result.micro_direction,
                         result.micro_conviction,
                         result.scalp_tradable,
                         result.intraday_tradable);

   block += "\ntactical_refresh_snapshot\n";
   block += "----------------------------------------\n";
   block += StringFormat("summary=%s\n", result.tactical_snapshot_summary);
   block += StringFormat("structure_liquidity=%s\n", result.structure_liquidity_summary);
   block += StringFormat("session_timing=%s\n", result.session_timing_summary);
   block += StringFormat("score_context=%s\n", result.score_context_summary);
   block += StringFormat("microstructure=%s\n", result.microstructure_summary);
   block += "canonical_readback=siam_tactical_readback_canonical\n";

   block += "\npreservation_state\n";
   block += "----------------------------------------\n";
   block += StringFormat("state=%s\n", result.preservation_state);
   block += StringFormat("continuity_posture=%s\n", result.continuity_posture);
   block += StringFormat("coverage_status=%s\n", coverage_status);
   block += StringFormat("coverage_limitations=%s\n", coverage_limitations);
   block += StringFormat("freshness_posture=%s\n", result.freshness_posture);
   block += StringFormat("l5_support_proof=%s\n", ASC_DeepSupportProofTokens(result));
   block += StringFormat("reason=%s\n", result.preservation_reason);
   block += StringFormat("reset_reason=%s\n", result.reset_reason);
   block += StringFormat("last_refreshed_utc=%s\n", ASC_ArtifactFormatUtc(result.last_refreshed_utc));
   block += StringFormat("microstructure_notes=%s\n", ASC_TextOrUnavailable(microstructure_notes));

   result.block_text = block;
   return true;
  }

#endif
