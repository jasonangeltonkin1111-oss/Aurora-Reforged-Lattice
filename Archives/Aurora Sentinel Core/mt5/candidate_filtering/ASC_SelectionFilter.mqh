#ifndef __ASC_SELECTION_FILTER_MQH__
#define __ASC_SELECTION_FILTER_MQH__

#include "../market_state/ASC_MarketStateEngine.mqh"
#include "../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"

enum ASC_SelectionFilterResultState
  {
   ASC_SELECTION_FILTER_RESULT_PASS = 0,
   ASC_SELECTION_FILTER_RESULT_PENDING = 1,
   ASC_SELECTION_FILTER_RESULT_FAIL = 2
  };

struct ASC_SelectionFilterEvaluation
  {
   ASC_SelectionFilterResultState result_state;
   bool market_state_is_open;
   bool classification_is_resolved;
   bool freshness_is_current;
   bool confidence_is_acceptable;
   bool corroboration_packet_is_available;
   bool quote_freshness_is_acceptable;
   bool spread_is_sane;
   bool tick_age_is_sane;
   bool tradability_is_open;
   bool specification_is_acceptable;
   bool continuity_backed;
   bool score_pack_ready;
   bool price_engine_supported;
   bool microstructure_supported;
   bool volatility_transition_supported;
   bool structure_context_supported;
   bool session_timing_supported;
   bool uptick_balance_supported;
   bool buy_sell_pressure_supported;
   bool atr_relative_supported;
   bool pressure_shift_supported;
   bool move_age_supported;
   bool liquidity_proximity_supported;
   bool participation_supported;
   bool execution_quality_supported;
   bool microstructure_burst_supported;
   double recent_momentum_score;
   double directional_consistency_score;
   double acceleration_posture_score;
   double tick_activity_score;
   double uptick_balance_score;
   double buy_sell_pressure_score;
   double tick_speed_score;
   double atr_relative_score;
   double burst_activity_score;
   double structure_direction_score;
   double session_posture_score;
   double timing_quality_score;
   double spread_penalty_score;
   double spread_pct_penalty_score;
   double low_liquidity_penalty_score;
   double pressure_shift_score;
   double momentum_delta;
   double momentum_speed;
   double momentum_acceleration_score;
   double time_since_last_impulse_sec;
   int impulse_count_window;
   double move_age_score;
   double position_in_range_pct;
   double distance_to_recent_high_pct;
   double distance_to_recent_low_pct;
   double liquidity_proximity_score;
   double participation_score;
   double execution_score;
   double execution_penalty;
   double spread_quality_score;
   double spread_stability_score;
   double quote_stability_score;
   double session_execution_quality_score;
   double style_execution_fit_score;
   double friction_quality_score;
   double liquidity_quality_score;
   double context_strength_score;
   double entry_readiness_score;
   double extension_risk_score;
   double late_move_risk_score;
   double exhaustion_risk_score;
   double execution_alignment_score;
   double session_alignment_score;
   double opportunity_density_score;
   double risk_drag_score;
   double tick_burst_score;
   double price_engine_score;
   double microstructure_score;
   double volatility_transition_score;
   double structure_context_score;
   double session_timing_score;
   double execution_friction_penalty;
   double score_gross;
   double score_net;
   string result_state_text;
   string result_state_operator_text;
   string result_reason;
   string reason_code;
   string reason_summary;
   string eligibility_posture;
   string candidate_bucket;
   datetime evaluated_at_utc;
   string disqualifiers;
   string dependencies_text;
   string corroboration_text;
   string confidence_text;
   string next_required_step;
   string recent_momentum_posture;
   string directional_consistency_posture;
   string acceleration_posture;
   string tick_activity_posture;
   string uptick_balance_posture;
   string buy_sell_pressure_posture;
   string tick_speed_posture;
   string atr_relative_posture;
   string burst_posture;
   string pressure_shift_posture;
   string momentum_acceleration_posture;
   string move_age_posture;
   string liquidity_zone;
   string liquidity_proximity_posture;
   string participation_posture;
   string execution_posture;
   string spread_stability_posture;
   string quote_stability_posture;
   string session_execution_posture;
   string style_execution_fit_posture;
   bool tick_burst_flag;
   string tick_burst_posture;
   string scalp_tradable;
   string intraday_tradable;
   string structure_direction_posture;
   string structure_distance_posture;
   string structure_context_posture;
   string session_posture;
   string session_timing_posture;
   string timing_quality_posture;
   string execution_friction_posture;
   string score_posture;
   string attention_posture;
   string score_pack_summary;
   string score_pack_reason;
   string evidence_intake_state;
   string evidence_intake_claim_evidence_status;
   string evidence_intake_detail;
  };

struct ASC_CommittedLayer3SymbolState
  {
   string symbol;
   string canonical_symbol;
   ASC_SelectionFilterEvaluation evaluation;
   string result_state;
   string reason_code;
   string reason_summary;
   string disqualifiers;
   string dependencies_text;
   string corroboration_text;
   string confidence_text;
   string next_required_step;
   bool score_pack_ready;
   double score_gross;
   double score_net;
   double price_engine_score;
   double microstructure_score;
   double volatility_transition_score;
   double structure_context_score;
   double session_timing_score;
   double execution_friction_penalty;
   double pressure_shift_score;
   double momentum_delta;
   double momentum_speed;
   double momentum_acceleration_score;
   double move_age_score;
   double position_in_range_pct;
   double distance_to_recent_high_pct;
   double distance_to_recent_low_pct;
   double liquidity_proximity_score;
   double participation_score;
   double execution_score;
   double execution_penalty;
   double spread_quality_score;
   double spread_stability_score;
   double quote_stability_score;
   double session_execution_quality_score;
   double style_execution_fit_score;
   double friction_quality_score;
   double liquidity_quality_score;
   double context_strength_score;
   double entry_readiness_score;
   double extension_risk_score;
   double late_move_risk_score;
   double exhaustion_risk_score;
   double execution_alignment_score;
   double session_alignment_score;
   double opportunity_density_score;
   double risk_drag_score;
   double tick_burst_score;
   string score_posture;
   string attention_posture;
   string price_engine_posture;
   string microstructure_posture;
   string volatility_transition_posture;
   string structure_context_posture;
   string session_timing_posture;
   string execution_friction_posture;
   string pressure_shift_posture;
   string momentum_acceleration_posture;
   string move_age_posture;
   string liquidity_zone;
   string liquidity_proximity_posture;
   string participation_posture;
   string execution_posture;
   string spread_stability_posture;
   string quote_stability_posture;
   string session_execution_posture;
   string style_execution_fit_posture;
   bool tick_burst_flag;
   string tick_burst_posture;
   string scalp_tradable;
   string intraday_tradable;
   string score_pack_summary;
   string score_pack_reason;
   string evidence_intake_state;
   string evidence_intake_claim_evidence_status;
   string evidence_intake_detail;
   datetime evaluated_utc;
   datetime committed_utc;
   ulong committed_revision;
   ulong source_l1_revision;
   ulong source_l2_revision;
   string source_lineage;
   bool has_lawful_packet;
   bool source_ready;
  };


string ASC_SelectionFilterTraceIdentity(const ASC_SelectionFilterEvaluation &evaluation)
  {
   string result_text = ASC_ArtifactHumanizeLabel((evaluation.result_state == ASC_SELECTION_FILTER_RESULT_PASS) ? "pass" : ((evaluation.result_state == ASC_SELECTION_FILTER_RESULT_FAIL) ? "fail" : "pending"));
   string packet_text = evaluation.corroboration_packet_is_available ? "packet-lawful" : "packet-unavailable";
   string score_text = evaluation.score_pack_ready ? "score-ready" : "score-pending";
   return StringFormat("l3_closest=%s %s %s evaluated=%s",
                       result_text,
                       packet_text,
                       score_text,
                       TimeToString(evaluation.evaluated_at_utc, TIME_DATE | TIME_SECONDS));
  }

double ASC_SelectionFilterClampScore(const double value)
  {
   return MathMax(0.0, MathMin(100.0, value));
  }

double ASC_SelectionFilterRoundScore(const double value)
  {
   return (MathRound(ASC_SelectionFilterClampScore(value) * 10.0) / 10.0);
  }

double ASC_SelectionFilterDecayLatenessDragScore(const ASC_SelectionFilterEvaluation &evaluation,
                                                 const ASC_Layer2Packet &packet)
  {
   double drag_seed = 0.0;

   if(packet.continuity_backed)
      drag_seed += 12.0;

   if(packet.freshness == ASC_L2_AGING)
      drag_seed += 8.0;
   else
      if(packet.freshness == ASC_L2_STALE)
         drag_seed += 18.0;
      else
         if(packet.freshness == ASC_L2_DEGRADED)
            drag_seed += 26.0;

   if(evaluation.move_age_score < 57.5)
      drag_seed += (57.5 - evaluation.move_age_score) * 0.48;

   if(evaluation.quote_stability_score < 57.5)
      drag_seed += (57.5 - evaluation.quote_stability_score) * 0.42;

   if(evaluation.tick_speed_score < 50.0 && evaluation.burst_activity_score >= 62.5)
      drag_seed += (50.0 - evaluation.tick_speed_score) * 0.32;

   if(evaluation.tick_burst_score > evaluation.momentum_acceleration_score)
      drag_seed += MathMax(0.0, evaluation.tick_burst_score - evaluation.momentum_acceleration_score) * 0.34;

   if(evaluation.burst_activity_score >= 67.5 && evaluation.pressure_shift_score < 55.0)
      drag_seed += (55.0 - evaluation.pressure_shift_score) * 0.45;

   if(evaluation.session_timing_score < 50.0)
      drag_seed += (50.0 - evaluation.session_timing_score) * 0.24;

   return ASC_SelectionFilterRoundScore(MathMin(100.0, drag_seed));
  }

double ASC_SelectionFilterTradabilityLiftScore(const ASC_SelectionFilterEvaluation &evaluation,
                                               const ASC_Layer2Packet &packet)
  {
   double lift_seed = 50.0;

   if(evaluation.tradability_is_open)
      lift_seed += 8.0;
   if(evaluation.specification_is_acceptable)
      lift_seed += 4.0;

   lift_seed += MathMax(0.0, evaluation.execution_score - 60.0) * 0.25;
   lift_seed += MathMax(0.0, evaluation.execution_alignment_score - 57.5) * 0.12;
   lift_seed += MathMax(0.0, evaluation.session_execution_quality_score - 60.0) * 0.10;

   if(evaluation.tick_burst_flag)
      lift_seed += 4.0;
   if(evaluation.scalp_tradable == "yes")
      lift_seed += 6.0;
   else
      if(evaluation.intraday_tradable == "yes")
         lift_seed += 3.0;

   if(packet.continuity_backed)
      lift_seed -= 5.0;

   if(packet.freshness == ASC_L2_AGING)
      lift_seed -= 2.5;
   else
      if(packet.freshness == ASC_L2_STALE)
         lift_seed -= 8.0;
      else
         if(packet.freshness == ASC_L2_DEGRADED)
            lift_seed -= 12.0;

   lift_seed -= MathMax(0.0, evaluation.late_move_risk_score - 52.5) * 0.08;
   lift_seed -= MathMax(0.0, evaluation.exhaustion_risk_score - 47.5) * 0.06;

   return ASC_SelectionFilterRoundScore(lift_seed);
  }

double ASC_SelectionFilterEmergenceNoisePenaltyScore(const ASC_SelectionFilterEvaluation &evaluation,
                                                        const ASC_Layer2Packet &packet)
  {
   double penalty_seed = 0.0;
   bool bursty_context = (evaluation.tick_burst_score >= 62.5 || evaluation.burst_activity_score >= 67.5);

   if(!bursty_context)
      return 0.0;

   if(evaluation.participation_score < 55.0)
      penalty_seed += (55.0 - evaluation.participation_score) * 0.24;

   if(evaluation.quote_stability_score < 57.5)
      penalty_seed += (57.5 - evaluation.quote_stability_score) * 0.28;

   if(evaluation.spread_stability_score < 57.5)
      penalty_seed += (57.5 - evaluation.spread_stability_score) * 0.24;

   if(evaluation.liquidity_quality_score < 55.0)
      penalty_seed += (55.0 - evaluation.liquidity_quality_score) * 0.20;

   if(evaluation.execution_score < 57.5)
      penalty_seed += (57.5 - evaluation.execution_score) * 0.18;

   if(evaluation.pressure_shift_score < 55.0)
      penalty_seed += (55.0 - evaluation.pressure_shift_score) * 0.16;

   if(evaluation.directional_consistency_score < 52.5)
      penalty_seed += (52.5 - evaluation.directional_consistency_score) * 0.14;

   if(packet.continuity_backed)
      penalty_seed += 4.0;

   if(packet.freshness == ASC_L2_AGING)
      penalty_seed += 2.0;
   else
      if(packet.freshness == ASC_L2_STALE)
         penalty_seed += 5.0;
      else
         if(packet.freshness == ASC_L2_DEGRADED)
            penalty_seed += 8.0;

   return ASC_SelectionFilterRoundScore(MathMin(100.0, penalty_seed));
  }

double ASC_SelectionFilterEarlyEmergenceDeltaUpliftScore(const ASC_SelectionFilterEvaluation &evaluation,
                                                         const ASC_Layer2Packet &packet)
  {
   double uplift_seed = 50.0;

   double momentum_delta_uplift = MathMax(0.0, evaluation.momentum_acceleration_score - evaluation.recent_momentum_score);
   double pressure_delta_uplift = MathMax(0.0, evaluation.pressure_shift_score - evaluation.directional_consistency_score);
   double burst_delta_uplift = MathMax(0.0, evaluation.tick_burst_score - evaluation.tick_activity_score);
   double execution_delta_uplift = MathMax(0.0, evaluation.execution_alignment_score - evaluation.execution_score);
   double timing_delta_uplift = MathMax(0.0, evaluation.session_alignment_score - evaluation.session_timing_score);
   double emergence_noise_penalty = ASC_SelectionFilterEmergenceNoisePenaltyScore(evaluation, packet);

   uplift_seed += MathMin(12.0, momentum_delta_uplift * 0.28);
   uplift_seed += MathMin(10.0, pressure_delta_uplift * 0.24);
   uplift_seed += MathMin(8.0, burst_delta_uplift * 0.20);
   uplift_seed += MathMin(8.0, execution_delta_uplift * 0.18);
   uplift_seed += MathMin(6.0, timing_delta_uplift * 0.16);

   if(evaluation.move_age_score >= 62.5)
      uplift_seed += MathMin(8.0, (evaluation.move_age_score - 62.5) * 0.22);
   if(evaluation.tick_burst_flag && evaluation.move_age_score >= 57.5)
      uplift_seed += 4.0;
   if(evaluation.tradability_is_open)
      uplift_seed += 3.0;
   if(evaluation.specification_is_acceptable)
      uplift_seed += 2.0;
   if(evaluation.quote_stability_score >= 57.5 && evaluation.spread_stability_score >= 57.5)
      uplift_seed += 3.0;

   if(packet.continuity_backed)
      uplift_seed -= 6.0;

   if(packet.freshness == ASC_L2_AGING)
      uplift_seed -= 3.0;
   else
      if(packet.freshness == ASC_L2_STALE)
         uplift_seed -= 9.0;
      else
         if(packet.freshness == ASC_L2_DEGRADED)
            uplift_seed -= 14.0;

   uplift_seed -= MathMax(0.0, evaluation.late_move_risk_score - 50.0) * 0.14;
   uplift_seed -= MathMax(0.0, evaluation.exhaustion_risk_score - 45.0) * 0.12;
   uplift_seed -= MathMax(0.0, 50.0 - evaluation.pressure_shift_score) * 0.10;
   uplift_seed -= MathMax(0.0, 50.0 - evaluation.session_timing_score) * 0.08;
   uplift_seed -= emergence_noise_penalty * 0.42;

   return ASC_SelectionFilterRoundScore(uplift_seed);
  }

int ASC_SelectionFilterDirectionalSign(const double value,const double epsilon)
  {
   if(value > epsilon)
      return 1;
   if(value < -epsilon)
      return -1;
   return 0;
  }

string ASC_SelectionFilterNormalizeText(const string value)
  {
   string normalized = value;
   StringTrimLeft(normalized);
   StringTrimRight(normalized);
   StringToLower(normalized);
   return normalized;
  }

bool ASC_SelectionFilterTextAvailable(const string value)
  {
   string normalized = ASC_SelectionFilterNormalizeText(value);
   return (StringLen(normalized) > 0
           && normalized != "unavailable"
           && normalized != "unknown"
           && normalized != "n/a");
  }

void ASC_SelectionFilterIncludeScore(const double value,double &sum,int &count)
  {
   sum += ASC_SelectionFilterClampScore(value);
   count++;
  }

double ASC_SelectionFilterAverageOrNeutral(const double sum,const int count)
  {
   if(count <= 0)
      return 50.0;
   return ASC_SelectionFilterRoundScore(sum / (double)count);
  }

string ASC_SelectionFilterComponentPosture(const double score)
  {
   if(score >= 80.0)
      return "strong";
   if(score >= 62.5)
      return "constructive";
   if(score >= 42.5)
      return "balanced";
   if(score >= 25.0)
      return "fading";
   return "weak";
  }

string ASC_SelectionFilterPenaltyPosture(const double penalty)
  {
   if(penalty >= 75.0)
      return "heavy";
   if(penalty >= 45.0)
      return "moderate";
   if(penalty > 0.0)
      return "light";
   return "minimal";
  }

string ASC_SelectionFilterTacticalPosture(const double score)
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

string ASC_SelectionFilterScorePosture(const double score)
  {
   if(score >= 90.0)
      return "extreme";
   if(score >= 80.0)
      return "strong";
   if(score >= 62.5)
      return "constructive";
   if(score >= 42.5)
      return "balanced";
   if(score >= 25.0)
      return "fading";
   return "weak";
  }

string ASC_SelectionFilterAttentionPosture(const double score)
  {
   if(score >= 80.0)
      return "high_attention";
   if(score >= 62.5)
      return "monitor";
   if(score >= 42.5)
      return "watch";
   if(score >= 25.0)
      return "background";
   return "low_attention";
  }

string ASC_SelectionFilterTimingUsefulnessLabel(const ASC_SelectionFilterEvaluation &evaluation)
  {
   if(evaluation.entry_readiness_score >= 72.5 && evaluation.late_move_risk_score <= 40.0 && evaluation.exhaustion_risk_score <= 35.0)
      return "usable now";
   if(evaluation.context_strength_score >= 65.0 && (evaluation.late_move_risk_score >= 60.0 || evaluation.exhaustion_risk_score >= 55.0))
      return "strong but late";
   if(evaluation.entry_readiness_score >= 57.5)
      return "developing";
   if(evaluation.context_strength_score >= 57.5)
      return "watch pullback";
   return "early/unclear";
  }

string ASC_SelectionFilterExecutionUsefulnessLabel(const ASC_SelectionFilterEvaluation &evaluation)
  {
   if(evaluation.execution_alignment_score >= 72.5
      && evaluation.execution_friction_penalty <= 27.5
      && evaluation.spread_stability_score >= 60.0
      && evaluation.quote_stability_score >= 60.0)
      return "clean";
   if(evaluation.execution_alignment_score >= 56.0
      && evaluation.execution_friction_penalty <= 47.5
      && evaluation.quote_stability_score >= 45.0)
      return "workable";
   if(evaluation.execution_alignment_score >= 47.5)
      return "dragging";
   return "poor";
  }

string ASC_SelectionFilterRiskDragLabel(const ASC_SelectionFilterEvaluation &evaluation)
  {
   if(evaluation.risk_drag_score >= 72.5)
      return "heavy";
   if(evaluation.risk_drag_score >= 57.5)
      return "elevated";
   if(evaluation.risk_drag_score >= 42.5)
      return "contained";
   return "light";
  }

string ASC_SelectionFilterMotionOverlayLabel(const ASC_SelectionFilterEvaluation &evaluation)
  {
   if(evaluation.momentum_acceleration_score >= 67.5
      && evaluation.pressure_shift_score >= 60.0
      && evaluation.risk_drag_score <= 45.0)
      return "accelerating";
   if(evaluation.momentum_acceleration_score >= 57.5
      && evaluation.pressure_shift_score >= 55.0
      && evaluation.move_age_score >= 55.0
      && evaluation.late_move_risk_score <= 50.0)
      return "clean-continuation";
   if(evaluation.pressure_shift_score >= 60.0 && evaluation.momentum_acceleration_score < 50.0)
      return "pressure-build";
   if(evaluation.late_move_risk_score >= 62.5 || evaluation.exhaustion_risk_score >= 57.5)
      return "late-stretch";
   if(evaluation.momentum_acceleration_score < 45.0 && evaluation.pressure_shift_score < 47.5)
      return "stalling";
   return "mixed-pulse";
  }

string ASC_SelectionFilterWaveOverlayLabel(const ASC_SelectionFilterEvaluation &evaluation)
  {
   if(evaluation.entry_readiness_score >= 72.5
      && evaluation.tick_burst_score >= 55.0
      && evaluation.timing_quality_score >= 65.0)
      return "in-sync";
   if(evaluation.entry_readiness_score >= 57.5 && evaluation.timing_quality_score >= 55.0)
      return "building";
   if(evaluation.context_strength_score >= 60.0
      && (evaluation.late_move_risk_score >= 60.0 || evaluation.exhaustion_risk_score >= 55.0))
      return "extended";
   if(evaluation.tick_burst_score < 40.0 && evaluation.momentum_acceleration_score < 50.0)
      return "fading";
   return "between-pulses";
  }

string ASC_SelectionFilterFlowOverlayLabel(const ASC_SelectionFilterEvaluation &evaluation)
  {
   if(evaluation.execution_alignment_score >= 67.5
      && evaluation.session_alignment_score >= 62.5
      && evaluation.risk_drag_score <= 42.5)
      return "clean";
   if(evaluation.execution_alignment_score >= 57.5 && evaluation.entry_readiness_score >= 57.5)
      return "workable";
   if(evaluation.execution_alignment_score >= 50.0 && evaluation.risk_drag_score < 60.0)
      return "guarded";
   return "heavy";
  }

string ASC_SelectionFilterExecutionStyleOverlayLabel(const ASC_SelectionFilterEvaluation &evaluation)
  {
   if(evaluation.style_execution_fit_score >= 70.0
      && evaluation.scalp_tradable == "yes"
      && evaluation.session_execution_quality_score >= 62.5)
      return "scalp-clean";
   if(evaluation.style_execution_fit_score >= 60.0
      && evaluation.intraday_tradable == "yes")
      return "intraday-clean";
   if(evaluation.execution_alignment_score >= 52.5)
      return "mixed";
   return "friction-heavy";
  }

string ASC_SelectionFilterOverlayEffectLabel(const ASC_SelectionFilterEvaluation &evaluation)
  {
   double overlay_balance = ((evaluation.pressure_shift_score
                              + evaluation.momentum_acceleration_score
                              + evaluation.entry_readiness_score
                              + evaluation.execution_alignment_score) / 4.0)
                            - evaluation.risk_drag_score;
   if(overlay_balance >= 15.0)
      return "strengthened";
   if(overlay_balance <= -10.0)
      return "softened";
   return "stabilized";
  }

string ASC_SelectionFilterOverlaySummary(const ASC_SelectionFilterEvaluation &evaluation)
  {
   return StringFormat("motion=%s | wave=%s | flow=%s | style=%s | effect=%s",
                       ASC_SelectionFilterMotionOverlayLabel(evaluation),
                       ASC_SelectionFilterWaveOverlayLabel(evaluation),
                       ASC_SelectionFilterFlowOverlayLabel(evaluation),
                       ASC_SelectionFilterExecutionStyleOverlayLabel(evaluation),
                       ASC_SelectionFilterOverlayEffectLabel(evaluation));
  }

double ASC_SelectionFilterClampSigned(const double value,const double limit=100.0)
  {
   return MathMax(-limit, MathMin(limit, value));
  }

double ASC_SelectionFilterQualityScore(const double penalty)
  {
   return ASC_SelectionFilterRoundScore(100.0 - ASC_SelectionFilterClampScore(penalty));
  }

string ASC_SelectionFilterLiquidityZone(const double position_in_range_pct)
  {
   if(position_in_range_pct >= 92.5)
      return "recent_high_sweep_band";
   if(position_in_range_pct >= 75.0)
      return "recent_high_band";
   if(position_in_range_pct >= 60.0)
      return "upper_range";
   if(position_in_range_pct <= 7.5)
      return "recent_low_sweep_band";
   if(position_in_range_pct <= 25.0)
      return "recent_low_band";
   if(position_in_range_pct <= 40.0)
      return "lower_range";
   return "mid_range";
  }

string ASC_SelectionFilterMoveAgePosture(const double score)
  {
   if(score >= 80.0)
      return "fresh";
   if(score >= 62.5)
      return "building";
   if(score >= 42.5)
      return "aging";
   return "stale";
  }

string ASC_SelectionFilterExecutionPosture(const double score,
                                           const bool trade_mode_open,
                                           const bool specification_ok)
  {
   if(!trade_mode_open)
      return "restricted";
   if(!specification_ok)
      return "guarded";
   return ASC_SelectionFilterComponentPosture(score);
  }

string ASC_SelectionFilterYesNo(const bool value)
  {
   return value ? "yes" : "no";
  }

void ASC_SelectionFilterAppendDelimited(string &target,const string value,const string delimiter)
  {
   if(StringLen(value) <= 0)
      return;
   if(StringLen(target) > 0)
      target += delimiter;
   target += value;
  }

void ASC_SelectionFilterAppendNamedFlag(string &target,const string label,const string value)
  {
   ASC_SelectionFilterAppendDelimited(target, label + "=" + value, ", ");
  }

void ASC_SelectionFilterAppendNamedScore(string &target,const string label,const double value)
  {
   ASC_SelectionFilterAppendDelimited(target, label + "=" + DoubleToString(value, 1), ", ");
  }

string ASC_SelectionFilterCarryStateLabel(const ASC_SelectionFilterEvaluation &evaluation)
  {
   if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "unavailable";
   if(evaluation.eligibility_posture == "qualified")
      return "qualified for shortlist intake";
   if(evaluation.eligibility_posture == "restricted")
      return "qualified with restricted carry";
   if(evaluation.eligibility_posture == "degraded")
      return "degraded carry";
   if(evaluation.eligibility_posture == "stale")
      return "stale carry";
   if(evaluation.eligibility_posture == "guarded")
      return "guarded carry";
   if(evaluation.eligibility_posture == "building")
      return "building carry";
   if(evaluation.eligibility_posture == "pending")
      return "pending carry";
   return "candidate carry";
  }

string ASC_SelectionFilterBuildDependenciesText(const ASC_SelectionFilterEvaluation &evaluation,
                                                const string spread_text,
                                                const string spread_cap_text,
                                                const string trade_mode_text)
  {
   string satisfied = "";
   ASC_SelectionFilterAppendNamedFlag(satisfied, "open", ASC_SelectionFilterYesNo(evaluation.market_state_is_open));
   ASC_SelectionFilterAppendNamedFlag(satisfied, "classified", ASC_SelectionFilterYesNo(evaluation.classification_is_resolved));
   ASC_SelectionFilterAppendNamedFlag(satisfied, "l1_fresh", ASC_SelectionFilterYesNo(evaluation.freshness_is_current));
   ASC_SelectionFilterAppendNamedFlag(satisfied, "l2_packet", ASC_SelectionFilterYesNo(evaluation.corroboration_packet_is_available));
   ASC_SelectionFilterAppendNamedFlag(satisfied, "quote_fresh", ASC_SelectionFilterYesNo(evaluation.quote_freshness_is_acceptable));
   ASC_SelectionFilterAppendNamedFlag(satisfied, "tick_age", ASC_SelectionFilterYesNo(evaluation.tick_age_is_sane));
   ASC_SelectionFilterAppendNamedFlag(satisfied, "confidence", ASC_SelectionFilterYesNo(evaluation.confidence_is_acceptable));
   ASC_SelectionFilterAppendNamedFlag(satisfied, "tradable", ASC_SelectionFilterYesNo(evaluation.tradability_is_open));
   ASC_SelectionFilterAppendNamedFlag(satisfied, "spec", ASC_SelectionFilterYesNo(evaluation.specification_is_acceptable));

   string missing = "";
   if(evaluation.continuity_backed)
      ASC_SelectionFilterAppendDelimited(missing, "continuity-backed corroboration", ", ");
   if(!evaluation.spread_is_sane)
      ASC_SelectionFilterAppendDelimited(missing, "spread " + spread_text + " above preferred cap " + spread_cap_text, ", ");
   if(!evaluation.corroboration_packet_is_available)
      ASC_SelectionFilterAppendDelimited(missing, "live corroboration unavailable", ", ");
   if(!evaluation.market_state_is_open)
      ASC_SelectionFilterAppendDelimited(missing, "market not open", ", ");
   if(!evaluation.classification_is_resolved)
      ASC_SelectionFilterAppendDelimited(missing, "classification unresolved", ", ");
   if(!evaluation.freshness_is_current)
      ASC_SelectionFilterAppendDelimited(missing, "layer-1 freshness soft", ", ");
   if(!evaluation.quote_freshness_is_acceptable)
      ASC_SelectionFilterAppendDelimited(missing, "quote freshness outside preferred window", ", ");
   if(!evaluation.tick_age_is_sane)
      ASC_SelectionFilterAppendDelimited(missing, "tick age elevated", ", ");
   if(!evaluation.confidence_is_acceptable)
      ASC_SelectionFilterAppendDelimited(missing, "market-state confidence soft", ", ");
   if(!evaluation.tradability_is_open)
      ASC_SelectionFilterAppendDelimited(missing, "trade mode " + trade_mode_text, ", ");
   if(!evaluation.specification_is_acceptable)
      ASC_SelectionFilterAppendDelimited(missing, "specification truth not ready", ", ");
   if(StringLen(missing) <= 0)
      missing = "none";

   string supportive = "";
   ASC_SelectionFilterAppendDelimited(supportive, "bucket=" + evaluation.candidate_bucket, ", ");
   ASC_SelectionFilterAppendDelimited(supportive, "score_pack=" + (evaluation.score_pack_ready ? "ready" : "pending"), ", ");
   if(evaluation.score_pack_ready)
     {
      ASC_SelectionFilterAppendNamedScore(supportive, "net", evaluation.score_net);
      ASC_SelectionFilterAppendNamedScore(supportive, "gross", evaluation.score_gross);
      ASC_SelectionFilterAppendNamedScore(supportive, "opportunity", evaluation.opportunity_density_score);
      ASC_SelectionFilterAppendNamedScore(supportive, "context", evaluation.context_strength_score);
      ASC_SelectionFilterAppendNamedScore(supportive, "entry", evaluation.entry_readiness_score);
      ASC_SelectionFilterAppendNamedScore(supportive, "risk_drag", evaluation.risk_drag_score);
     }
   else
     {
      ASC_SelectionFilterAppendDelimited(supportive, "numeric_carry=withheld_until_score_pack_ready", ", ");
      ASC_SelectionFilterAppendDelimited(supportive, "reason=" + evaluation.score_pack_reason, ", ");
     }

   return "Met: " + satisfied + " | Missing/weak: " + missing + " | Supportive carry: " + supportive + " | Next evidence: " + evaluation.next_required_step;
  }

string ASC_SelectionFilterBuildCorroborationText(const ASC_SelectionFilterEvaluation &evaluation)
  {
   string market_watch = evaluation.corroboration_packet_is_available
                         ? (evaluation.continuity_backed
                            ? "continuity-backed packet only"
                            : "live packet available")
                         : "awaiting live packet";
   string support_posture = evaluation.score_pack_ready ? "score-pack synthesized" : "score-pack pending; numeric carry withheld";
   return "Market Watch: " + market_watch + " | Score pack: " + support_posture + " | Carry state: " + ASC_SelectionFilterCarryStateLabel(evaluation) + " | Next evidence: " + evaluation.next_required_step;
  }

string ASC_SelectionFilterEvidenceIntakeState(const ASC_Layer1SymbolState &symbol_state,
                                              const ASC_Layer2Packet &market_watch_packet,
                                              const bool corroboration_packet_is_available,
                                              const bool has_lawful_packet)
  {
   if(StringLen(symbol_state.symbol) <= 0)
      return ASC_CAND_EVID_INTAKE_NOT_APPLICABLE;

   if(symbol_state.state == ASC_L1_UNKNOWN || symbol_state.state == ASC_L1_UNCERTAIN || !symbol_state.classification.resolved)
      return ASC_CAND_EVID_INTAKE_DEP_BLOCKED;

   if(symbol_state.state != ASC_L1_OPEN)
      return ASC_CAND_EVID_INTAKE_NOT_APPLICABLE;

   if(symbol_state.is_stale || market_watch_packet.is_stale || market_watch_packet.freshness == ASC_L2_STALE || market_watch_packet.freshness == ASC_L2_CONTINUITY || market_watch_packet.spec_is_stale)
      return ASC_CAND_EVID_INTAKE_STALE_RECOVERABLE;

   if(symbol_state.is_degraded || market_watch_packet.is_degraded || market_watch_packet.freshness == ASC_L2_DEGRADED || market_watch_packet.spec_is_degraded || market_watch_packet.continuity_backed)
      return ASC_CAND_EVID_INTAKE_NON_CLEAN_AVAILABLE;

   if(!corroboration_packet_is_available || !has_lawful_packet || !market_watch_packet.valid_bid || !market_watch_packet.valid_ask || !market_watch_packet.valid_tick_time)
      return ASC_CAND_EVID_INTAKE_UNAVAILABLE_RECOVERABLE;

   if(!market_watch_packet.has_specification
      || !market_watch_packet.valid_trade_mode
      || !market_watch_packet.valid_spread
      || !market_watch_packet.valid_spread_pct
      || !market_watch_packet.valid_atr_points
      || !market_watch_packet.valid_atr_pct
      || !market_watch_packet.valid_day_range
      || !market_watch_packet.valid_daily_change_pct
      || !market_watch_packet.valid_day_range_position)
      return ASC_CAND_EVID_INTAKE_INSUFFICIENT_NOW;

   if(market_watch_packet.freshness == ASC_L2_FRESH || market_watch_packet.freshness == ASC_L2_AGING)
      return ASC_CAND_EVID_INTAKE_CLEAN_SUPPORTED;

   return ASC_CAND_EVID_INTAKE_SRC_RT_UNPROVEN;
  }

string ASC_SelectionFilterAuthoritySource(const ASC_Layer1SymbolState &symbol_state,
                                          const ASC_Layer2Packet &market_watch_packet,
                                          const bool corroboration_packet_is_available,
                                          const bool has_lawful_packet)
  {
   if(symbol_state.state == ASC_L1_UNKNOWN || symbol_state.state == ASC_L1_UNCERTAIN)
      return "uncertain_market";
   if(symbol_state.state != ASC_L1_OPEN)
      return "closed_market";
   if(!corroboration_packet_is_available || !has_lawful_packet)
      return "unavailable_dependency";
   if(symbol_state.is_degraded || market_watch_packet.is_degraded || market_watch_packet.freshness == ASC_L2_DEGRADED || market_watch_packet.spec_is_degraded)
      return "degraded_l1_l2";
   if(symbol_state.is_stale || market_watch_packet.is_stale || market_watch_packet.freshness == ASC_L2_STALE || market_watch_packet.spec_is_stale)
      return "retained_l1_l2";
   if(market_watch_packet.continuity_backed || market_watch_packet.freshness == ASC_L2_CONTINUITY)
      return "retained_l1_l2";
   return "fresh_l1_l2";
  }

string ASC_SelectionFilterFreshnessToken(const ASC_Layer1SymbolState &symbol_state,
                                         const ASC_Layer2Packet &market_watch_packet,
                                         const bool corroboration_packet_is_available,
                                         const bool has_lawful_packet)
  {
   if(symbol_state.state == ASC_L1_UNKNOWN || symbol_state.state == ASC_L1_UNCERTAIN)
      return "uncertain";
   if(symbol_state.state != ASC_L1_OPEN)
      return "closed";
   if(!corroboration_packet_is_available || !has_lawful_packet)
      return "unavailable";
   if(symbol_state.is_degraded || market_watch_packet.is_degraded || market_watch_packet.freshness == ASC_L2_DEGRADED || market_watch_packet.spec_is_degraded)
      return "degraded";
   if(symbol_state.is_stale || market_watch_packet.is_stale || market_watch_packet.freshness == ASC_L2_STALE || market_watch_packet.spec_is_stale)
      return "stale";
   if(market_watch_packet.continuity_backed || market_watch_packet.freshness == ASC_L2_CONTINUITY || market_watch_packet.freshness == ASC_L2_AGING)
      return "retained";
   return "fresh";
  }

string ASC_SelectionFilterDependencyStatusToken(const ASC_Layer1SymbolState &symbol_state,
                                                const ASC_Layer2Packet &market_watch_packet,
                                                const bool corroboration_packet_is_available,
                                                const bool has_lawful_packet)
  {
   if(symbol_state.state != ASC_L1_OPEN)
      return "session_closed";
   if(!symbol_state.classification.resolved || !corroboration_packet_is_available || !has_lawful_packet)
      return "missing";
   if(symbol_state.is_degraded || market_watch_packet.is_degraded || market_watch_packet.freshness == ASC_L2_DEGRADED || market_watch_packet.spec_is_degraded)
      return "degraded";
   if(!market_watch_packet.valid_tick_time || market_watch_packet.freshness == ASC_L2_STALE || market_watch_packet.is_stale)
      return "tick_stale";
   if(!market_watch_packet.has_specification
      || !market_watch_packet.valid_trade_mode
      || !market_watch_packet.valid_spread
      || !market_watch_packet.valid_spread_pct
      || !market_watch_packet.valid_atr_points
      || !market_watch_packet.valid_atr_pct
      || !market_watch_packet.valid_day_range
      || !market_watch_packet.valid_daily_change_pct
      || !market_watch_packet.valid_day_range_position)
      return "partial";
   return "complete";
  }

string ASC_SelectionFilterCandidateStateToken(const ASC_SelectionFilterEvaluation &evaluation,
                                              const string intake_state,
                                              const string freshness_token)
  {
   if(intake_state == ASC_CAND_EVID_INTAKE_UNAVAILABLE_RECOVERABLE)
      return "recoverable_unavailable";
   if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
     {
      if(intake_state == ASC_CAND_EVID_INTAKE_DEP_BLOCKED)
         return "blocked";
      return "pending";
     }
   if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "excluded";
   if(freshness_token == "stale" || freshness_token == "degraded" || freshness_token == "retained" || evaluation.reason_code == "score_led_penalty_carry")
      return "weak";
   return "eligible";
  }

string ASC_SelectionFilterRecoveryStateToken(const string intake_state,
                                             const string freshness_token)
  {
   if(intake_state == ASC_CAND_EVID_INTAKE_UNAVAILABLE_RECOVERABLE
      || intake_state == ASC_CAND_EVID_INTAKE_STALE_RECOVERABLE
      || freshness_token == "stale"
      || freshness_token == "degraded"
      || freshness_token == "retained"
      || freshness_token == "unavailable")
      return "recoverable";
   if(intake_state == ASC_CAND_EVID_INTAKE_DEP_BLOCKED)
      return "not_recoverable";
   return "not_applicable";
  }

string ASC_SelectionFilterL3ToL4AuthorityToken(const ASC_SelectionFilterEvaluation &evaluation,
                                               const string intake_state,
                                               const string freshness_token)
  {
   if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "pending";
   if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_FAIL || intake_state == ASC_CAND_EVID_INTAKE_DEP_BLOCKED)
      return "blocked";
   if(intake_state == ASC_CAND_EVID_INTAKE_CLEAN_SUPPORTED && freshness_token == "fresh")
      return "clean";
   if(freshness_token == "degraded" || intake_state == ASC_CAND_EVID_INTAKE_NON_CLEAN_AVAILABLE)
      return "degraded";
   if(freshness_token == "unavailable" || intake_state == ASC_CAND_EVID_INTAKE_UNAVAILABLE_RECOVERABLE)
      return "pending";
   return "limited";
  }


string ASC_SelectionFilterMetricPurposeToken()
  {
   return "metric_domain=l3_candidate"
          + " | metric_purpose=ranking_support"
          + " | metric_owner=ASC_SelectionFilter.ASC_EvaluateSelectionFilter"
          + " | l3_meaning=" + ASC_L3_MEANING_CANDIDATE_RANKING_SUPPORT_ONLY
          + " | l3_scope=" + ASC_L3_SCOPE_LIGHTWEIGHT_CANDIDATE_SUPPORT
          + " | source_owner=" + ASC_L3_SOURCE_OWNER_CANDIDATE_FILTERING
          + " | source_owner_code=" + ASC_L3_SOURCE_OWNER_SELECTION_FILTER;
  }

string ASC_SelectionFilterFalsehoodBoundaryToken()
  {
   return "trade_permission=" + ASC_FALSEHOOD_TRADE_PERMISSION_FALSE
          + " | entry_signal=" + ASC_FALSEHOOD_ENTRY_SIGNAL_FALSE
          + " | execution_permission=" + ASC_FALSEHOOD_EXECUTION_PERMISSION_FALSE
          + " | final_rank=" + ASC_FALSEHOOD_FINAL_RANK_FALSE
          + " | strategy_edge_proof=" + ASC_FALSEHOOD_STRATEGY_EDGE_PROOF_FALSE
          + " | complete_evidence=" + ASC_FALSEHOOD_COMPLETE_EVIDENCE_FALSE
          + " | fresh_evidence_when_stale=" + ASC_FALSEHOOD_FRESH_EVIDENCE_WHEN_STALE_FALSE
          + " | clean_evidence_when_partial_or_unavailable=" + ASC_FALSEHOOD_CLEAN_EVIDENCE_WHEN_PARTIAL_OR_UNAVAILABLE_FALSE;
  }

string ASC_SelectionFilterInputSourceToken(const ASC_Layer2Packet &market_watch_packet,
                                           const bool corroboration_packet_is_available,
                                           const bool has_lawful_packet)
  {
   if(has_lawful_packet && corroboration_packet_is_available)
      return "l1_l2_live";
   if(market_watch_packet.continuity_backed)
      return "retained";
   if(has_lawful_packet)
      return "mixed";
   return "unknown";
  }

string ASC_SelectionFilterSampleStatusToken(const ASC_SelectionFilterEvaluation &evaluation)
  {
   if(evaluation.score_pack_ready)
      return "sufficient";
   if(evaluation.price_engine_supported || evaluation.microstructure_supported || evaluation.volatility_transition_supported || evaluation.structure_context_supported || evaluation.session_timing_supported)
      return "partial";
   return "unavailable";
  }

string ASC_SelectionFilterMetricValidityToken(const string freshness,
                                              const string dependency_status,
                                              const string sample_status)
  {
   if(dependency_status == "missing"
      || dependency_status == "session_closed"
      || dependency_status == "tick_stale"
      || sample_status == "unavailable")
      return "unavailable";
   if(freshness == "fresh" && dependency_status == "complete" && sample_status == "sufficient")
      return "valid_support";
   if(freshness == "stale" || freshness == "degraded" || freshness == "retained")
      return "degraded_support";
   if(sample_status == "partial" || dependency_status == "partial" || freshness == "unavailable")
      return "limited_support";
   return "unknown_support";
  }

string ASC_SelectionFilterMetricFalsifierToken(const string freshness,
                                               const string dependency_status,
                                               const string sample_status)
  {
   if(freshness == "stale" || freshness == "degraded" || freshness == "retained")
      return ASC_CONTRADICTION_STALE_SOURCE_PROJECTION;
   if(sample_status == "partial" || sample_status == "unavailable" || dependency_status == "partial")
      return ASC_CONTRADICTION_UNAVAILABLE_AS_CLEAN_TRUTH;
   if(dependency_status == "missing" || dependency_status == "session_closed" || dependency_status == "tick_stale")
      return "unavailable_dependency";
   return "not_applicable";
  }

string ASC_SelectionFilterProofToken(const ASC_Layer1SymbolState &symbol_state,
                                     const ASC_Layer2Packet &market_watch_packet,
                                     const bool corroboration_packet_is_available,
                                     const bool has_lawful_packet,
                                     const ASC_SelectionFilterEvaluation &evaluation,
                                     const string intake_state)
  {
   string authority_source = ASC_SelectionFilterAuthoritySource(symbol_state, market_watch_packet, corroboration_packet_is_available, has_lawful_packet);
   string freshness = ASC_SelectionFilterFreshnessToken(symbol_state, market_watch_packet, corroboration_packet_is_available, has_lawful_packet);
   string dependency_status = ASC_SelectionFilterDependencyStatusToken(symbol_state, market_watch_packet, corroboration_packet_is_available, has_lawful_packet);
   string candidate_state = ASC_SelectionFilterCandidateStateToken(evaluation, intake_state, freshness);
   string recovery_state = ASC_SelectionFilterRecoveryStateToken(intake_state, freshness);
   string l3_to_l4_authority = ASC_SelectionFilterL3ToL4AuthorityToken(evaluation, intake_state, freshness);
   string sample_status = ASC_SelectionFilterSampleStatusToken(evaluation);
   string validity_status = ASC_SelectionFilterMetricValidityToken(freshness, dependency_status, sample_status);
   string falsifier = ASC_SelectionFilterMetricFalsifierToken(freshness, dependency_status, sample_status);
   string artifact_projection_status = (validity_status == "valid_support") ? "current_support_projection" : ((validity_status == "unavailable") ? "unavailable_projection_label_required" : "qualified_support_projection");
   return ASC_SelectionFilterMetricPurposeToken()
          + " | " + ASC_SelectionFilterFalsehoodBoundaryToken()
          + " | l3_not_trade_permission=true"
          + " | l3_not_entry_signal=true"
          + " | l3_not_final_rank=true"
          + " | l3_authority_source=" + authority_source
          + " | score_source=" + ASC_SelectionFilterInputSourceToken(market_watch_packet, corroboration_packet_is_available, has_lawful_packet)
          + " | score_freshness=" + freshness
          + " | quote_freshness=" + ASC_L2FreshnessToText(market_watch_packet.freshness)
          + " | market_state_freshness=" + ASC_L1FreshnessToOperatorText(symbol_state)
          + " | l3_freshness=" + freshness
          + " | l3_dependency_status=" + dependency_status
          + " | data_dependency_status=" + dependency_status
          + " | provenance_status=" + authority_source
          + " | input_snapshot_age_sec=" + IntegerToString((int)MathMax(0, TimeGMT() - market_watch_packet.last_built_utc))
          + " | l3_candidate_state=" + candidate_state
          + " | l3_recovery_state=" + recovery_state
          + " | recovery_status=" + recovery_state
          + " | unavailable_reason=" + ((sample_status == "unavailable" || dependency_status == "missing") ? "missing_or_unlawful_l1_l2_packet" : "not_applicable")
          + " | partial_reason=" + ((sample_status == "partial" || dependency_status == "partial") ? "some_l3_inputs_unavailable" : "not_applicable")
          + " | l3_to_l4_authority=" + l3_to_l4_authority
          + " | l3_to_l4_authority_scope=" + ASC_L3_TO_L4_AUTHORITY_COMMITTED_SUPPORT_ONLY
          + " | l4_consumes_l3_support_only=" + ASC_L4_CONSUMES_L3_SUPPORT_ONLY
          + " | committed_l3_status=source_supported"
          + " | input_source=" + ASC_SelectionFilterInputSourceToken(market_watch_packet, corroboration_packet_is_available, has_lawful_packet)
          + " | freshness_status=" + freshness
          + " | sample_status=" + sample_status
          + " | score_inputs_available=" + ((sample_status == "sufficient") ? "true" : "false")
          + " | score_inputs_partial=" + ((sample_status == "partial") ? "true" : "false")
          + " | score_inputs_unavailable=" + ((sample_status == "unavailable") ? "true" : "false")
          + " | timeframe_coverage=not_applicable"
          + " | tick_window_status=not_applicable"
          + " | validity_status=" + validity_status
          + " | falsifier=" + falsifier
          + " | artifact_projection=" + ASC_ARTIFACT_PROJECTION_PROJECTION_ONLY
          + " | artifact_projection_status=" + artifact_projection_status
          + " | dossier_l3_projection=" + ASC_ARTIFACT_PROJECTION_CONSUMER_ONLY
          + " | market_board_l3_projection=" + ASC_ARTIFACT_PROJECTION_CONSUMER_ONLY
          + " | current_focus_l3_projection=" + ASC_ARTIFACT_PROJECTION_MIRROR_ONLY
          + " | writers_do_not_own_l3_truth=" + ASC_WRITERS_DO_NOT_OWN_L3_TRUTH
          + " | contradiction_hooks=" + ASC_CONTRADICTION_SCORE_VS_RANK_MISMATCH + "," + ASC_CONTRADICTION_STALE_SOURCE_PROJECTION + "," + ASC_CONTRADICTION_SOURCE_SUPPORTED_NOT_RUNTIME_OBSERVED + "," + ASC_CONTRADICTION_UNAVAILABLE_AS_CLEAN_TRUTH + "," + ASC_CONTRADICTION_TRADE_PERMISSION_FALSEHOOD_MISSING + "," + ASC_CONTRADICTION_ENTRY_SIGNAL_FALSEHOOD_MISSING
          + " | behavior_change=" + ASC_L3_BEHAVIOR_CHANGE_NONE;
  }

string ASC_SelectionFilterEvidenceIntakeDetail(const ASC_Layer1SymbolState &symbol_state,
                                               const ASC_Layer2Packet &market_watch_packet,
                                               const bool corroboration_packet_is_available,
                                               const bool has_lawful_packet,
                                               const ASC_SelectionFilterEvaluation &evaluation,
                                               const string intake_state)
  {
   string state = ASC_CandidateEvidenceIntakeText(intake_state);
   string detail = "source_owner=ASC_SelectionFilter";
   detail += " | candidate_evidence_intake_state=" + state;
   detail += " | candidate_evidence_intake_claim_evidence_status=" + ASC_CandidateEvidenceIntakeClaimEvidenceStatus(intake_state);
   detail += " | " + ASC_SelectionFilterProofToken(symbol_state,
                                                    market_watch_packet,
                                                    corroboration_packet_is_available,
                                                    has_lawful_packet,
                                                    evaluation,
                                                    intake_state);
   detail += " | l1_state=" + ASC_L1StateToText(symbol_state.state);
   detail += " | l1_stale=" + (symbol_state.is_stale ? "yes" : "no");
   detail += " | l1_degraded=" + (symbol_state.is_degraded ? "yes" : "no");
   detail += " | l2_packet=" + (has_lawful_packet ? "lawful" : (corroboration_packet_is_available ? "non_lawful" : "unavailable"));
   detail += " | l2_freshness=" + ASC_L2FreshnessToText(market_watch_packet.freshness);
   detail += " | l2_continuity=" + (market_watch_packet.continuity_backed ? "yes" : "no");
   detail += " | score_gate_effect=none";
   detail += " | candidate_score_change=no";
   detail += " | candidate_gate_change=no";
   detail += " | unavailable_is_not_candidate_gate=yes";
   return detail;
  }

void ASC_SelectionFilterInitScorePack(ASC_SelectionFilterEvaluation &evaluation)
  {
   evaluation.score_pack_ready = false;
   evaluation.price_engine_supported = false;
   evaluation.microstructure_supported = false;
   evaluation.volatility_transition_supported = false;
   evaluation.structure_context_supported = false;
   evaluation.session_timing_supported = false;
   evaluation.uptick_balance_supported = false;
   evaluation.buy_sell_pressure_supported = false;
   evaluation.atr_relative_supported = false;
   evaluation.pressure_shift_supported = false;
   evaluation.move_age_supported = false;
   evaluation.liquidity_proximity_supported = false;
   evaluation.participation_supported = false;
   evaluation.execution_quality_supported = false;
   evaluation.microstructure_burst_supported = false;

   evaluation.recent_momentum_score = 50.0;
   evaluation.directional_consistency_score = 50.0;
   evaluation.acceleration_posture_score = 50.0;
   evaluation.tick_activity_score = 50.0;
   evaluation.uptick_balance_score = 50.0;
   evaluation.buy_sell_pressure_score = 50.0;
   evaluation.tick_speed_score = 50.0;
   evaluation.atr_relative_score = 50.0;
   evaluation.burst_activity_score = 50.0;
   evaluation.structure_direction_score = 50.0;
   evaluation.session_posture_score = 50.0;
   evaluation.timing_quality_score = 50.0;
   evaluation.spread_penalty_score = 0.0;
   evaluation.spread_pct_penalty_score = 0.0;
   evaluation.low_liquidity_penalty_score = 0.0;
   evaluation.pressure_shift_score = 50.0;
   evaluation.momentum_delta = 0.0;
   evaluation.momentum_speed = 50.0;
   evaluation.momentum_acceleration_score = 50.0;
   evaluation.time_since_last_impulse_sec = -1.0;
   evaluation.impulse_count_window = 0;
   evaluation.move_age_score = 50.0;
   evaluation.position_in_range_pct = 50.0;
   evaluation.distance_to_recent_high_pct = -1.0;
   evaluation.distance_to_recent_low_pct = -1.0;
   evaluation.liquidity_proximity_score = 50.0;
   evaluation.participation_score = 50.0;
   evaluation.execution_score = 50.0;
   evaluation.execution_penalty = 50.0;
   evaluation.spread_quality_score = 50.0;
   evaluation.spread_stability_score = 50.0;
   evaluation.quote_stability_score = 50.0;
   evaluation.session_execution_quality_score = 50.0;
   evaluation.style_execution_fit_score = 50.0;
   evaluation.friction_quality_score = 50.0;
   evaluation.liquidity_quality_score = 50.0;
   evaluation.context_strength_score = 50.0;
   evaluation.entry_readiness_score = 50.0;
   evaluation.extension_risk_score = 50.0;
   evaluation.late_move_risk_score = 50.0;
   evaluation.exhaustion_risk_score = 50.0;
   evaluation.execution_alignment_score = 50.0;
   evaluation.session_alignment_score = 50.0;
   evaluation.opportunity_density_score = 50.0;
   evaluation.risk_drag_score = 50.0;
   evaluation.tick_burst_score = 50.0;
   evaluation.price_engine_score = 50.0;
   evaluation.microstructure_score = 50.0;
   evaluation.volatility_transition_score = 50.0;
   evaluation.structure_context_score = 50.0;
   evaluation.session_timing_score = 50.0;
   evaluation.execution_friction_penalty = 0.0;
   evaluation.score_gross = 50.0;
   evaluation.score_net = 50.0;

   evaluation.recent_momentum_posture = "balanced";
   evaluation.directional_consistency_posture = "balanced";
   evaluation.acceleration_posture = "balanced";
   evaluation.tick_activity_posture = "balanced";
   evaluation.uptick_balance_posture = "unavailable";
   evaluation.buy_sell_pressure_posture = "unavailable";
   evaluation.tick_speed_posture = "balanced";
   evaluation.atr_relative_posture = "unavailable";
   evaluation.burst_posture = "balanced";
   evaluation.pressure_shift_posture = "balanced";
   evaluation.momentum_acceleration_posture = "balanced";
   evaluation.move_age_posture = "unavailable";
   evaluation.liquidity_zone = "unavailable";
   evaluation.liquidity_proximity_posture = "unavailable";
   evaluation.participation_posture = "unavailable";
   evaluation.execution_posture = "unavailable";
   evaluation.spread_stability_posture = "unavailable";
   evaluation.quote_stability_posture = "unavailable";
   evaluation.session_execution_posture = "unavailable";
   evaluation.style_execution_fit_posture = "unavailable";
   evaluation.tick_burst_flag = false;
   evaluation.tick_burst_posture = "unavailable";
   evaluation.scalp_tradable = "no";
   evaluation.intraday_tradable = "no";
   evaluation.structure_direction_posture = "balanced";
   evaluation.structure_distance_posture = "balanced";
   evaluation.structure_context_posture = "balanced";
   evaluation.session_posture = "balanced";
   evaluation.session_timing_posture = evaluation.session_posture;
   evaluation.timing_quality_posture = "balanced";
   evaluation.session_timing_posture = "balanced";
   evaluation.execution_friction_posture = "minimal";
   evaluation.score_posture = "balanced";
   evaluation.attention_posture = "watch";
   evaluation.score_pack_summary = "score pack pending";
   evaluation.score_pack_reason = "awaiting Layer-3 score-pack synthesis";
   evaluation.evidence_intake_state = ASC_CAND_EVID_INTAKE_SRC_RT_UNPROVEN;
   evaluation.evidence_intake_claim_evidence_status = ASC_CandidateEvidenceIntakeClaimEvidenceStatus(evaluation.evidence_intake_state);
   evaluation.evidence_intake_detail = "candidate evidence intake not evaluated";
  }

void ASC_SelectionFilterInitEvaluation(ASC_SelectionFilterEvaluation &evaluation)
  {
   evaluation.result_state = ASC_SELECTION_FILTER_RESULT_PENDING;
   evaluation.market_state_is_open = false;
   evaluation.classification_is_resolved = false;
   evaluation.freshness_is_current = false;
   evaluation.confidence_is_acceptable = false;
   evaluation.corroboration_packet_is_available = false;
   evaluation.quote_freshness_is_acceptable = false;
   evaluation.spread_is_sane = false;
   evaluation.tick_age_is_sane = false;
   evaluation.tradability_is_open = false;
   evaluation.specification_is_acceptable = false;
   evaluation.continuity_backed = false;
   evaluation.result_state_text = "pending";
   evaluation.result_state_operator_text = "Pending Candidate Filtering";
   evaluation.result_reason = "selection filter not initialized";
   evaluation.reason_code = "selection_filter_uninitialized";
   evaluation.reason_summary = "selection filter is awaiting runtime evaluation";
   evaluation.eligibility_posture = "pending";
   evaluation.candidate_bucket = "unassigned";
   evaluation.evaluated_at_utc = 0;
   evaluation.disqualifiers = "none";
   evaluation.dependencies_text = "awaiting evaluation";
   evaluation.corroboration_text = "awaiting corroboration";
   evaluation.confidence_text = "awaiting confidence";
   evaluation.next_required_step = "await candidate-filter refresh";
   ASC_SelectionFilterInitScorePack(evaluation);
  }

void ASC_SelectionFilterInitFallbackPending(ASC_SelectionFilterEvaluation &evaluation,
                                            const string result_reason,
                                            const string reason_code,
                                            const string reason_summary)
  {
   ASC_SelectionFilterInitEvaluation(evaluation);
   evaluation.result_state = ASC_SELECTION_FILTER_RESULT_PENDING;
   evaluation.result_state_text = "pending";
   evaluation.result_state_operator_text = "Pending Candidate Filtering";
   evaluation.result_reason = result_reason;
   evaluation.reason_code = reason_code;
   evaluation.reason_summary = reason_summary;
   evaluation.eligibility_posture = "pending";
   evaluation.next_required_step = "wait for runtime shortlist publication";
   evaluation.disqualifiers = "unavailable until shortlist publication";
   evaluation.dependencies_text = "unavailable until shortlist publication";
   evaluation.corroboration_text = "unavailable until shortlist publication";
   evaluation.confidence_text = "unavailable until shortlist publication";
   evaluation.score_pack_reason = "score pack unavailable until runtime shortlist publication";
   evaluation.score_pack_summary = "score pack unavailable until runtime shortlist publication";
   evaluation.attention_posture = "background";
  }

double ASC_SelectionFilterSpreadPct(const ASC_Layer2Packet &packet)
  {
   if(!ASC_L2PacketHasLawfulSnapshot(packet))
      return -1.0;
   double spread_abs = packet.spread_points * packet.point;
   if(packet.bid <= 0.0 || spread_abs < 0.0)
      return -1.0;
   return (spread_abs / packet.bid) * 100.0;
  }

void ASC_SelectionFilterPopulateScorePack(const ASC_Layer1SymbolState &symbol_state,
                                          const ASC_Layer2Packet &packet,
                                          ASC_SelectionFilterEvaluation &evaluation)
  {
   ASC_SelectionFilterInitScorePack(evaluation);

   bool has_snapshot = ASC_L2PacketHasLawfulSnapshot(packet);
   bool has_day_range = ASC_L2PacketHasLawfulDayRange(packet);
   bool atr_ready = (packet.valid_atr_pct && packet.atr_pct > 0.0);
   double spread_pct = ASC_SelectionFilterSpreadPct(packet);
   double spread_pct_cap = (symbol_state.classification.main_bucket_id == "crypto") ? 1.50 : 0.35;
   string direction_text = ASC_SelectionFilterNormalizeText(packet.day_direction_snapshot);
   string structure_text = ASC_SelectionFilterNormalizeText(packet.day_structure_posture);
   string action_text = ASC_SelectionFilterNormalizeText(packet.day_price_action_snapshot);
   string session_text = ASC_SelectionFilterNormalizeText(packet.trade_session_status);
   if(StringLen(session_text) <= 0 || session_text == "unavailable")
      session_text = ASC_SelectionFilterNormalizeText(packet.quote_session_status);
   string liquidity_text = ASC_SelectionFilterNormalizeText(packet.liquidity_state);
   string volatility_text = ASC_SelectionFilterNormalizeText(packet.volatility_state);

   evaluation.position_in_range_pct = packet.valid_day_range_position ? packet.day_range_position_pct : 50.0;
   if(packet.valid_last_price && packet.last_price > 0.0 && packet.day_high > 0.0 && packet.day_high >= packet.last_price)
      evaluation.distance_to_recent_high_pct = ((packet.day_high - packet.last_price) / packet.last_price) * 100.0;
   if(packet.valid_last_price && packet.last_price > 0.0 && packet.day_low > 0.0 && packet.last_price >= packet.day_low)
      evaluation.distance_to_recent_low_pct = ((packet.last_price - packet.day_low) / packet.last_price) * 100.0;

   if(packet.valid_day_range_position)
     {
      evaluation.liquidity_proximity_supported = true;
      evaluation.liquidity_zone = ASC_SelectionFilterLiquidityZone(packet.day_range_position_pct);
      evaluation.liquidity_proximity_score = ASC_SelectionFilterRoundScore(MathAbs(packet.day_range_position_pct - 50.0) * 2.0);

      if(packet.day_range_position_pct >= 85.0 || packet.day_range_position_pct <= 15.0)
         evaluation.liquidity_proximity_posture = "extreme";
      else if(packet.day_range_position_pct >= 70.0 || packet.day_range_position_pct <= 30.0)
         evaluation.liquidity_proximity_posture = "edge";
      else
         evaluation.liquidity_proximity_posture = "mid_range";
     }

   double family_sum = 0.0;
   int family_count = 0;

   if(has_day_range && packet.valid_daily_change_pct)
     {
      evaluation.price_engine_supported = true;
      double abs_change = MathAbs(packet.daily_change_pct);
      double reference_pct = 0.50;
      if(atr_ready && packet.atr_pct > 0.0)
         reference_pct = packet.atr_pct;
      else if(packet.valid_day_range && packet.day_range_pct > 0.0)
         reference_pct = MathMax(0.10, packet.day_range_pct * 0.75);

      double momentum_ratio = abs_change / MathMax(0.0001, reference_pct);
      evaluation.recent_momentum_score = ASC_SelectionFilterRoundScore(100.0 * MathMin(1.0, momentum_ratio));
      int momentum_sign = ASC_SelectionFilterDirectionalSign(packet.daily_change_pct, 0.03);
      if(momentum_sign > 0)
         evaluation.recent_momentum_posture = "bullish";
      else if(momentum_sign < 0)
         evaluation.recent_momentum_posture = "bearish";
      else
         evaluation.recent_momentum_posture = "flat";

      double price_sum = 0.0;
      int price_count = 0;
      ASC_SelectionFilterIncludeScore(evaluation.recent_momentum_score, price_sum, price_count);

      if(packet.valid_day_range_position)
        {
         double distance = MathAbs(packet.day_range_position_pct - 50.0) / 50.0;
         int position_bias = ASC_SelectionFilterDirectionalSign(packet.day_range_position_pct - 50.0, 5.0);
         bool direction_aligned = ((momentum_sign == 0 && distance <= 0.20)
                                   || (momentum_sign > 0 && position_bias >= 0)
                                   || (momentum_sign < 0 && position_bias <= 0));

         if(direction_aligned)
           {
            evaluation.directional_consistency_score = ASC_SelectionFilterRoundScore(45.0 + (55.0 * distance));
            evaluation.directional_consistency_posture = (distance >= 0.45 ? "consistent" : "building");
           }
         else
           {
            evaluation.directional_consistency_score = ASC_SelectionFilterRoundScore(25.0 + (20.0 * (1.0 - distance)));
            evaluation.directional_consistency_posture = "transition";
           }
         ASC_SelectionFilterIncludeScore(evaluation.directional_consistency_score, price_sum, price_count);

         if(momentum_sign == 0 || abs_change < 0.05)
           {
            evaluation.acceleration_posture_score = 35.0;
            evaluation.acceleration_posture = "flat";
           }
         else if(distance >= 0.70)
           {
            evaluation.acceleration_posture_score = ASC_SelectionFilterRoundScore(75.0 + (15.0 * distance));
            evaluation.acceleration_posture = "accelerating";
           }
         else if(distance <= 0.25)
           {
            evaluation.acceleration_posture_score = ASC_SelectionFilterRoundScore(30.0 + (25.0 * distance));
            evaluation.acceleration_posture = "decelerating";
           }
         else
           {
            evaluation.acceleration_posture_score = ASC_SelectionFilterRoundScore(52.5 + (20.0 * distance));
            evaluation.acceleration_posture = "balanced";
           }
         ASC_SelectionFilterIncludeScore(evaluation.acceleration_posture_score, price_sum, price_count);
         }
      else
        {
         evaluation.directional_consistency_posture = "unavailable";
         evaluation.acceleration_posture = "unavailable";
        }

      evaluation.pressure_shift_supported = true;
      double synthetic_prev_bias = (double)(momentum_sign * 30);
      double synthetic_now_bias = packet.valid_day_range_position
                                  ? ASC_SelectionFilterClampSigned((packet.day_range_position_pct - 50.0) * 2.0, 100.0)
                                  : synthetic_prev_bias;
      evaluation.pressure_shift_score = ASC_SelectionFilterRoundScore(50.0 + ((synthetic_now_bias - synthetic_prev_bias) * 0.40));
      evaluation.pressure_shift_posture = ASC_SelectionFilterTacticalPosture(evaluation.pressure_shift_score);
      evaluation.momentum_delta = ASC_SelectionFilterClampSigned(packet.daily_change_pct, 100.0);
      evaluation.momentum_speed = ASC_SelectionFilterRoundScore((MathAbs(packet.daily_change_pct) / MathMax(0.0001, reference_pct)) * 100.0);
      evaluation.momentum_acceleration_score = ASC_SelectionFilterRoundScore((evaluation.momentum_speed * 0.60)
                                                                             + (evaluation.acceleration_posture_score * 0.40));
      evaluation.momentum_acceleration_posture = ASC_SelectionFilterTacticalPosture(evaluation.momentum_acceleration_score);

      evaluation.price_engine_score = ASC_SelectionFilterAverageOrNeutral(price_sum, price_count);

      if(evaluation.recent_momentum_posture == "flat")
         evaluation.score_pack_reason = "price engine favors neutrality";
      else if(evaluation.directional_consistency_posture == "consistent" || evaluation.directional_consistency_posture == "building")
         evaluation.score_pack_reason = "price engine has directional carry";
      else
         evaluation.score_pack_reason = "price engine is transitional";
      ASC_SelectionFilterIncludeScore(evaluation.price_engine_score, family_sum, family_count);
     }

   if(has_snapshot)
     {
      evaluation.microstructure_supported = true;

      double freshness_score = 50.0;
      if(packet.freshness == ASC_L2_FRESH)
         freshness_score = 90.0;
      else if(packet.freshness == ASC_L2_AGING)
         freshness_score = 72.5;
      else if(packet.freshness == ASC_L2_CONTINUITY)
         freshness_score = 35.0;
      else if(packet.freshness == ASC_L2_STALE)
         freshness_score = 20.0;
      else if(packet.freshness == ASC_L2_DEGRADED)
         freshness_score = 10.0;

      double age_ratio = 1.0;
      if(packet.valid_tick_time)
         age_ratio = MathMax(0.0, MathMin(1.0, (double)packet.packet_age_sec / (double)MathMax(1, ASC_L2_STALE_AGE_SEC)));
      evaluation.tick_speed_score = ASC_SelectionFilterRoundScore(100.0 * (1.0 - age_ratio));
      evaluation.tick_speed_posture = ASC_SelectionFilterComponentPosture(evaluation.tick_speed_score);

      double liquidity_adjustment = 0.0;
      if(StringFind(liquidity_text, "high") >= 0 || StringFind(liquidity_text, "deep") >= 0 || StringFind(liquidity_text, "liquid") >= 0)
         liquidity_adjustment = 8.0;
      else if(StringFind(liquidity_text, "thin") >= 0 || StringFind(liquidity_text, "low") >= 0 || StringFind(liquidity_text, "poor") >= 0)
         liquidity_adjustment = -15.0;

      evaluation.tick_activity_score = ASC_SelectionFilterRoundScore((freshness_score * 0.60)
                                                                     + (evaluation.tick_speed_score * 0.40)
                                                                     + liquidity_adjustment);
      evaluation.tick_activity_posture = ASC_SelectionFilterComponentPosture(evaluation.tick_activity_score);

      double micro_sum = 0.0;
      int micro_count = 0;
      ASC_SelectionFilterIncludeScore(evaluation.tick_activity_score, micro_sum, micro_count);
      ASC_SelectionFilterIncludeScore(evaluation.tick_speed_score, micro_sum, micro_count);
      evaluation.microstructure_score = ASC_SelectionFilterAverageOrNeutral(micro_sum, micro_count);

      evaluation.uptick_balance_supported = false;
      evaluation.uptick_balance_posture = "neutral-unavailable";
      evaluation.buy_sell_pressure_supported = false;
      evaluation.buy_sell_pressure_posture = "neutral-unavailable";

      evaluation.participation_supported = true;
      evaluation.participation_score = evaluation.microstructure_score;
      evaluation.participation_posture = "balanced";

      ASC_SelectionFilterIncludeScore(evaluation.microstructure_score, family_sum, family_count);
     }

   if(has_day_range || atr_ready || ASC_SelectionFilterTextAvailable(packet.volatility_state))
     {
      evaluation.volatility_transition_supported = true;
      double volatility_sum = 0.0;
      int volatility_count = 0;

      if(atr_ready && packet.atr_pct > 0.0 && packet.valid_day_range)
        {
         evaluation.atr_relative_supported = true;
         double atr_ratio = packet.day_range_pct / MathMax(0.0001, packet.atr_pct);
         evaluation.atr_relative_score = ASC_SelectionFilterRoundScore(100.0 * MathMin(1.0, atr_ratio / 1.50));

         if(atr_ratio < 0.45)
            evaluation.atr_relative_posture = "compressed";
         else if(atr_ratio < 0.90)
            evaluation.atr_relative_posture = "building";
         else if(atr_ratio <= 1.80)
            evaluation.atr_relative_posture = "expanded";
         else if(atr_ratio <= 2.50)
            evaluation.atr_relative_posture = "burst";
         else
            evaluation.atr_relative_posture = "spike";

         if(atr_ratio < 0.30)
           {
            evaluation.burst_activity_score = 10.0;
            evaluation.burst_posture = "dead-market";
           }
         else if(atr_ratio < 0.70)
           {
            evaluation.burst_activity_score = 45.0;
            evaluation.burst_posture = "compression";
           }
         else if(atr_ratio <= 1.80)
           {
            evaluation.burst_activity_score = 85.0;
            evaluation.burst_posture = "tradable-burst";
           }
         else if(atr_ratio <= 2.50)
           {
            evaluation.burst_activity_score = 60.0;
            evaluation.burst_posture = "spike";
           }
         else
           {
            evaluation.burst_activity_score = 35.0;
            evaluation.burst_posture = "exhausted-spike";
           }

         ASC_SelectionFilterIncludeScore(evaluation.atr_relative_score, volatility_sum, volatility_count);
         ASC_SelectionFilterIncludeScore(evaluation.burst_activity_score, volatility_sum, volatility_count);
        }
      else
        {
         evaluation.atr_relative_supported = false;
         evaluation.atr_relative_posture = "neutral-unavailable";

         if(StringFind(volatility_text, "quiet") >= 0 || StringFind(volatility_text, "compress") >= 0)
           {
            evaluation.burst_activity_score = 35.0;
            evaluation.burst_posture = "dead-market";
           }
         else if(StringFind(volatility_text, "spike") >= 0)
           {
            evaluation.burst_activity_score = 55.0;
            evaluation.burst_posture = "spike";
           }
         else if(StringFind(volatility_text, "elevated") >= 0 || StringFind(volatility_text, "high") >= 0 || StringFind(volatility_text, "burst") >= 0)
           {
            evaluation.burst_activity_score = 72.5;
            evaluation.burst_posture = "tradable-burst";
           }
         else
           {
            evaluation.burst_activity_score = 52.5;
            evaluation.burst_posture = "balanced";
           }

         ASC_SelectionFilterIncludeScore(evaluation.burst_activity_score, volatility_sum, volatility_count);
        }

      evaluation.volatility_transition_score = ASC_SelectionFilterAverageOrNeutral(volatility_sum, volatility_count);

      evaluation.move_age_supported = true;
      evaluation.move_age_score = ASC_SelectionFilterAverageOrNeutral(evaluation.acceleration_posture_score
                                                                      + evaluation.tick_speed_score
                                                                      + evaluation.burst_activity_score,
                                                                      3);
      evaluation.move_age_posture = ASC_SelectionFilterMoveAgePosture(evaluation.move_age_score);
      evaluation.time_since_last_impulse_sec = -1.0;
      evaluation.impulse_count_window = 0;

      evaluation.microstructure_burst_supported = true;
      evaluation.tick_burst_score = ASC_SelectionFilterAverageOrNeutral(evaluation.burst_activity_score
                                                                        + evaluation.tick_activity_score
                                                                        + evaluation.tick_speed_score,
                                                                        3);
      evaluation.tick_burst_flag = (evaluation.tick_burst_score >= 80.0
                                    && evaluation.burst_activity_score >= 70.0
                                    && evaluation.tick_speed_score >= 55.0);
      if(evaluation.tick_burst_flag)
         evaluation.tick_burst_posture = "active_burst";
      else if(evaluation.tick_burst_score >= 62.5)
         evaluation.tick_burst_posture = "building";
      else if(evaluation.tick_burst_score >= 42.5)
         evaluation.tick_burst_posture = "balanced";
      else
         evaluation.tick_burst_posture = "quiet";

      if(evaluation.participation_supported)
        {
         double participation_seed = (evaluation.tick_activity_score * 0.42)
                                     + (evaluation.tick_speed_score * 0.18)
                                     + (evaluation.pressure_shift_score * 0.18)
                                     + (evaluation.tick_burst_score * 0.12)
                                     + (evaluation.burst_activity_score * 0.10);

         if(StringFind(liquidity_text, "thin") >= 0 || StringFind(liquidity_text, "low") >= 0 || StringFind(liquidity_text, "poor") >= 0)
            participation_seed -= 10.0;
         else if(StringFind(liquidity_text, "high") >= 0 || StringFind(liquidity_text, "deep") >= 0 || StringFind(liquidity_text, "liquid") >= 0)
            participation_seed += 4.0;

         if(packet.continuity_backed)
            participation_seed -= 8.0;
         if(packet.freshness == ASC_L2_AGING)
            participation_seed -= 3.0;
         else if(packet.freshness == ASC_L2_STALE)
            participation_seed -= 10.0;
         else if(packet.freshness == ASC_L2_DEGRADED)
            participation_seed -= 18.0;

         evaluation.participation_score = ASC_SelectionFilterRoundScore(participation_seed);
         if(evaluation.participation_score >= 80.0)
            evaluation.participation_posture = "expanding";
         else if(evaluation.participation_score >= 62.5)
            evaluation.participation_posture = "constructive";
         else if(evaluation.participation_score >= 42.5)
            evaluation.participation_posture = "balanced";
         else if(evaluation.participation_score >= 25.0)
            evaluation.participation_posture = "fading";
         else
            evaluation.participation_posture = "thin";
      }

      ASC_SelectionFilterIncludeScore(evaluation.volatility_transition_score, family_sum, family_count);
     }

   if(has_day_range || ASC_SelectionFilterTextAvailable(packet.day_structure_posture) || ASC_SelectionFilterTextAvailable(packet.day_direction_snapshot))
     {
      evaluation.structure_context_supported = true;

      double position_distance = 0.0;
      if(packet.valid_day_range_position)
         position_distance = MathAbs(packet.day_range_position_pct - 50.0) / 50.0;

      if(StringFind(structure_text, "trend") >= 0 || StringFind(direction_text, "up") >= 0 || StringFind(direction_text, "down") >= 0)
        {
         evaluation.structure_direction_score = ASC_SelectionFilterRoundScore(55.0 + (35.0 * position_distance));
         evaluation.structure_direction_posture = "directional";
        }
      else if(StringFind(structure_text, "range") >= 0)
        {
         evaluation.structure_direction_score = ASC_SelectionFilterRoundScore(35.0 + (20.0 * (1.0 - position_distance)));
         evaluation.structure_direction_posture = "range";
        }
      else if(StringFind(structure_text, "transition") >= 0 || StringFind(action_text, "reversal") >= 0)
        {
         evaluation.structure_direction_score = 55.0;
         evaluation.structure_direction_posture = "transition";
        }
      else
        {
         evaluation.structure_direction_score = ASC_SelectionFilterRoundScore(45.0 + (15.0 * position_distance));
         evaluation.structure_direction_posture = "mixed";
        }

      if(packet.valid_day_range_position)
        {
         if(packet.day_range_position_pct >= 75.0)
            evaluation.structure_distance_posture = "near-high";
         else if(packet.day_range_position_pct <= 25.0)
            evaluation.structure_distance_posture = "near-low";
         else
            evaluation.structure_distance_posture = "mid-range";
        }
      else
         evaluation.structure_distance_posture = "distance-unavailable";

      evaluation.structure_context_score = evaluation.structure_direction_score;
      if(evaluation.liquidity_proximity_supported)
         evaluation.structure_context_score = ASC_SelectionFilterAverageOrNeutral(evaluation.structure_direction_score
                                                                                  + evaluation.liquidity_proximity_score,
                                                                                  2);
      if(evaluation.structure_direction_posture == "directional")
         evaluation.structure_context_posture = "directional";
      else if(evaluation.structure_direction_posture == "range")
         evaluation.structure_context_posture = "range";
      else
         evaluation.structure_context_posture = "transition";

      ASC_SelectionFilterIncludeScore(evaluation.structure_context_score, family_sum, family_count);
     }

   if(symbol_state.state == ASC_L1_OPEN
      || packet.valid_trade_session_status
      || packet.valid_quote_session_status
      || ASC_SelectionFilterTextAvailable(packet.session_notes))
     {
      evaluation.session_timing_supported = true;

      bool session_is_open = (symbol_state.state == ASC_L1_OPEN);
      if(StringFind(session_text, "open") >= 0 || StringFind(session_text, "active") >= 0)
         session_is_open = true;
      if(StringFind(session_text, "closed") >= 0)
         session_is_open = false;

      if(session_is_open)
        {
         evaluation.session_posture_score = 75.0;
         evaluation.session_posture = "active-session";
         evaluation.session_timing_posture = evaluation.session_posture;
        }
      else
        {
         evaluation.session_posture_score = 25.0;
         evaluation.session_posture = "closed-session";
         evaluation.session_timing_posture = evaluation.session_posture;
        }

      double timing_base = evaluation.session_posture_score;
      if(has_snapshot)
         timing_base = (timing_base * 0.50) + (evaluation.tick_speed_score * 0.50);
      if(packet.continuity_backed)
         timing_base -= 12.5;
      evaluation.timing_quality_score = ASC_SelectionFilterRoundScore(timing_base);
      evaluation.timing_quality_posture = ASC_SelectionFilterComponentPosture(evaluation.timing_quality_score);
      evaluation.session_timing_posture = evaluation.timing_quality_posture;

      double session_sum = 0.0;
      int session_count = 0;
      ASC_SelectionFilterIncludeScore(evaluation.session_posture_score, session_sum, session_count);
      ASC_SelectionFilterIncludeScore(evaluation.timing_quality_score, session_sum, session_count);
      evaluation.session_timing_score = ASC_SelectionFilterAverageOrNeutral(session_sum, session_count);

      ASC_SelectionFilterIncludeScore(evaluation.session_timing_score, family_sum, family_count);
     }

   if(has_snapshot)
     {
      evaluation.spread_penalty_score = 0.0;
      if(spread_pct >= 0.0 && spread_pct_cap > 0.0)
         evaluation.spread_penalty_score = ASC_SelectionFilterRoundScore(100.0 * MathMin(1.0, spread_pct / spread_pct_cap));

      if(packet.valid_spread_to_atr && packet.spread_to_atr > 0.0)
         evaluation.spread_pct_penalty_score = ASC_SelectionFilterRoundScore(100.0 * MathMin(1.0, packet.spread_to_atr / 0.25));
      else
         evaluation.spread_pct_penalty_score = evaluation.spread_penalty_score;

      if(StringFind(liquidity_text, "thin") >= 0 || StringFind(liquidity_text, "low") >= 0 || StringFind(liquidity_text, "poor") >= 0)
         evaluation.low_liquidity_penalty_score = 65.0;
      else if(packet.continuity_backed || packet.freshness == ASC_L2_CONTINUITY)
         evaluation.low_liquidity_penalty_score = 50.0;
      else if(StringFind(liquidity_text, "high") >= 0 || StringFind(liquidity_text, "deep") >= 0)
         evaluation.low_liquidity_penalty_score = 10.0;
      else
         evaluation.low_liquidity_penalty_score = 25.0;

      evaluation.execution_friction_penalty = ASC_SelectionFilterAverageOrNeutral(evaluation.spread_penalty_score
                                                                                  + evaluation.spread_pct_penalty_score
                                                                                  + evaluation.low_liquidity_penalty_score,
                                                                                  3);
      evaluation.execution_friction_posture = ASC_SelectionFilterPenaltyPosture(evaluation.execution_friction_penalty);

      evaluation.execution_quality_supported = true;
      evaluation.spread_quality_score = ASC_SelectionFilterQualityScore(MathMax(evaluation.spread_penalty_score,
                                                                                evaluation.spread_pct_penalty_score));
      double spread_stability_penalty = 0.0;
      if(packet.valid_spread_to_atr && packet.spread_to_atr > 0.0)
         spread_stability_penalty += MathMin(55.0, packet.spread_to_atr * 140.0);
      else
         spread_stability_penalty += 25.0;
      if(packet.valid_spread_type && packet.spread_type_mode != 0)
         spread_stability_penalty += 12.5;
      if(packet.continuity_backed)
         spread_stability_penalty += 14.0;
      if(packet.freshness == ASC_L2_STALE || packet.freshness == ASC_L2_DEGRADED)
         spread_stability_penalty += 10.0;
      spread_stability_penalty += MathMin(15.0, (double)MathMax(0, packet.live_quote_micro_retry_attempts) * 3.0);
      evaluation.spread_stability_score = ASC_SelectionFilterQualityScore(spread_stability_penalty);
      evaluation.spread_stability_posture = ASC_SelectionFilterComponentPosture(evaluation.spread_stability_score);

      double quote_stability_penalty = 0.0;
      if(packet.packet_age_sec > 0)
         quote_stability_penalty += MathMin(40.0, ((double)packet.packet_age_sec / (double)MathMax(1, ASC_L2_STALE_AGE_SEC)) * 40.0);
      if(packet.continuity_backed)
         quote_stability_penalty += 22.5;
      if(packet.freshness == ASC_L2_AGING)
         quote_stability_penalty += 10.0;
      else if(packet.freshness == ASC_L2_STALE)
         quote_stability_penalty += 20.0;
      else if(packet.freshness == ASC_L2_DEGRADED)
         quote_stability_penalty += 27.5;
      quote_stability_penalty += MathMin(20.0, (double)MathMax(0, packet.live_quote_micro_retry_attempts) * 4.0);
      quote_stability_penalty += MathMin(10.0, (double)MathMax(0, packet.live_quote_micro_retry_elapsed_ms) / 120.0);
      evaluation.quote_stability_score = ASC_SelectionFilterQualityScore(quote_stability_penalty);
      evaluation.quote_stability_posture = ASC_SelectionFilterComponentPosture(evaluation.quote_stability_score);

      evaluation.friction_quality_score = ASC_SelectionFilterQualityScore(evaluation.execution_friction_penalty);
      evaluation.liquidity_quality_score = ASC_SelectionFilterQualityScore(evaluation.low_liquidity_penalty_score);

      double execution_readiness = 100.0;
      if(!packet.valid_trade_mode)
         execution_readiness = 40.0;
      else if(!evaluation.tradability_is_open)
         execution_readiness = 55.0;

      double specification_quality = 100.0;
      if(!packet.has_specification)
         specification_quality = 35.0;
      else if(packet.spec_is_degraded)
         specification_quality = 40.0;
      else if(packet.spec_is_stale)
         specification_quality = 55.0;

      evaluation.execution_score = ASC_SelectionFilterAverageOrNeutral(evaluation.spread_quality_score
                                                                       + evaluation.friction_quality_score
                                                                       + evaluation.liquidity_quality_score
                                                                       + evaluation.spread_stability_score
                                                                       + evaluation.quote_stability_score
                                                                       + execution_readiness
                                                                       + specification_quality,
                                                                       7);
      evaluation.execution_penalty = ASC_SelectionFilterRoundScore(100.0 - evaluation.execution_score);
      evaluation.execution_posture = ASC_SelectionFilterExecutionPosture(evaluation.execution_score,
                                                                         evaluation.tradability_is_open,
                                                                         evaluation.specification_is_acceptable);
      evaluation.scalp_tradable = (evaluation.tradability_is_open
                                   && evaluation.specification_is_acceptable
                                   && evaluation.execution_score >= 60.0
                                   && evaluation.friction_quality_score >= 45.0)
                                  ? "yes"
                                  : "no";
      evaluation.intraday_tradable = (evaluation.tradability_is_open
                                      && evaluation.specification_is_acceptable
                                      && evaluation.execution_score >= 50.0
                                      && evaluation.friction_quality_score >= 35.0)
                                     ? "yes"
                                     : "no";

      double session_exec = ASC_SelectionFilterAverageOrNeutral(evaluation.execution_score
                                                                + evaluation.quote_stability_score
                                                                + evaluation.spread_stability_score
                                                                + evaluation.session_posture_score,
                                                                4);
      if(packet.continuity_backed)
         session_exec = ASC_SelectionFilterRoundScore(session_exec - 10.0);
      evaluation.session_execution_quality_score = session_exec;
      evaluation.session_execution_posture = ASC_SelectionFilterComponentPosture(evaluation.session_execution_quality_score);

      evaluation.style_execution_fit_score = ASC_SelectionFilterAverageOrNeutral((evaluation.scalp_tradable == "yes" ? 72.5 : 45.0)
                                                                                 + (evaluation.intraday_tradable == "yes" ? 65.0 : 47.5)
                                                                                 + evaluation.session_execution_quality_score,
                                                                                 3);
      evaluation.style_execution_fit_posture = ASC_SelectionFilterComponentPosture(evaluation.style_execution_fit_score);
     }

   evaluation.context_strength_score = ASC_SelectionFilterAverageOrNeutral(evaluation.price_engine_score
                                                                           + evaluation.structure_context_score
                                                                           + evaluation.pressure_shift_score
                                                                           + evaluation.participation_score,
                                                                           4);
   double execution_alignment_seed = (evaluation.execution_score * 0.34)
                                     + (evaluation.spread_quality_score * 0.14)
                                     + (evaluation.spread_stability_score * 0.12)
                                     + (evaluation.quote_stability_score * 0.12)
                                     + (evaluation.friction_quality_score * 0.10)
                                     + (evaluation.liquidity_quality_score * 0.08)
                                     + (evaluation.session_execution_quality_score * 0.06)
                                     + (evaluation.style_execution_fit_score * 0.04);
   execution_alignment_seed -= (evaluation.execution_friction_penalty * 0.12);
   if(packet.continuity_backed)
      execution_alignment_seed -= 4.0;
   evaluation.execution_alignment_score = ASC_SelectionFilterRoundScore(execution_alignment_seed);
   evaluation.session_alignment_score = ASC_SelectionFilterAverageOrNeutral(evaluation.session_timing_score
                                                                            + evaluation.timing_quality_score
                                                                            + evaluation.tick_speed_score,
                                                                            3);

   double extension_drag = (MathMax(0.0, evaluation.liquidity_proximity_score - 72.5) * 0.85);
   extension_drag += (MathMax(0.0, evaluation.burst_activity_score - 76.0) * 0.35);
   evaluation.extension_risk_score = ASC_SelectionFilterRoundScore(MathMin(100.0, extension_drag));
   double decay_lateness_drag_score = ASC_SelectionFilterDecayLatenessDragScore(evaluation, packet);
   double base_late_move_risk = MathMax(0.0, 100.0 - evaluation.move_age_score);
   evaluation.late_move_risk_score = ASC_SelectionFilterRoundScore(MathMin(100.0,
                                                                           (base_late_move_risk * 0.62)
                                                                           + (decay_lateness_drag_score * 0.38)));
   double exhaustion_drag = 0.0;
   if(evaluation.move_age_score < 45.0)
      exhaustion_drag += (45.0 - evaluation.move_age_score) * 1.15;
   if(evaluation.tick_burst_score < 42.5)
      exhaustion_drag += (42.5 - evaluation.tick_burst_score) * 0.75;
   if(evaluation.momentum_acceleration_score < 50.0)
      exhaustion_drag += (50.0 - evaluation.momentum_acceleration_score) * 0.60;
   if(decay_lateness_drag_score > 45.0)
      exhaustion_drag += (decay_lateness_drag_score - 45.0) * 0.52;
   evaluation.exhaustion_risk_score = ASC_SelectionFilterRoundScore(MathMin(100.0, exhaustion_drag));
   double tradability_lift_score = ASC_SelectionFilterTradabilityLiftScore(evaluation, packet);
   string tradability_lift_posture = ASC_SelectionFilterComponentPosture(tradability_lift_score);
   double early_emergence_delta_uplift_score = ASC_SelectionFilterEarlyEmergenceDeltaUpliftScore(evaluation, packet);
   string early_emergence_delta_posture = ASC_SelectionFilterComponentPosture(early_emergence_delta_uplift_score);
   evaluation.entry_readiness_score = ASC_SelectionFilterAverageOrNeutral(evaluation.execution_alignment_score
                                                                          + evaluation.session_alignment_score
                                                                          + evaluation.move_age_score
                                                                          + evaluation.tick_burst_score
                                                                          + tradability_lift_score
                                                                          + early_emergence_delta_uplift_score,
                                                                          6);
   evaluation.risk_drag_score = ASC_SelectionFilterAverageOrNeutral(evaluation.execution_friction_penalty
                                                                    + evaluation.extension_risk_score
                                                                    + evaluation.late_move_risk_score
                                                                    + evaluation.exhaustion_risk_score
                                                                    + decay_lateness_drag_score,
                                                                    5);
   evaluation.opportunity_density_score = ASC_SelectionFilterRoundScore(MathMax(0.0,
                                                                                 MathMin(100.0,
                                                                                         (evaluation.context_strength_score * 0.36)
                                                                                         + (evaluation.entry_readiness_score * 0.29)
                                                                                         + (evaluation.momentum_acceleration_score * 0.16)
                                                                                         + (tradability_lift_score * 0.10)
                                                                                         + (early_emergence_delta_uplift_score * 0.11)
                                                                                         - (evaluation.risk_drag_score * 0.18))));

   evaluation.score_gross = ASC_SelectionFilterAverageOrNeutral(family_sum, family_count);
   evaluation.score_net = ASC_SelectionFilterRoundScore((evaluation.score_gross * 0.56)
                                                        + (evaluation.opportunity_density_score * 0.44)
                                                        - (evaluation.execution_friction_penalty * 0.18)
                                                        - (evaluation.risk_drag_score * 0.14));
   evaluation.score_posture = ASC_SelectionFilterScorePosture(evaluation.score_net);
   evaluation.attention_posture = ASC_SelectionFilterAttentionPosture(evaluation.score_net);
   evaluation.score_pack_ready = (family_count > 0);

   string volatility_summary = evaluation.burst_posture;
   if(StringLen(volatility_summary) <= 0)
      volatility_summary = evaluation.atr_relative_posture;

   string timing_usefulness = ASC_SelectionFilterTimingUsefulnessLabel(evaluation);
   string execution_usefulness = ASC_SelectionFilterExecutionUsefulnessLabel(evaluation);
   string risk_drag_label = ASC_SelectionFilterRiskDragLabel(evaluation);
   string overlay_summary = ASC_SelectionFilterOverlaySummary(evaluation);

   evaluation.score_pack_summary = StringFormat("metric_domain=l3_candidate | metric_purpose=ranking_support | metric_owner=ASC_SelectionFilter.ASC_EvaluateSelectionFilter | input_source=l1_l2_live | trade_permission=false | entry_signal=false | validity_status=limited | falsifier=stale_input_or_insufficient_sample | artifact_projection=qualified | behavior_change=no | meaning=candidate_ranking_support_only | net %.1f (%s) | gross %.1f | opportunity %.1f | context %.1f | entry %.1f | execution %.1f (%s) | timing %.1f (%s) | risk_drag %.1f (%s) | emergence %.1f (%s) | tradability %.1f (%s) | decay %.1f | late %.1f | exhaustion %.1f | %s | families price %.1f / micro %.1f / vol %.1f / structure %.1f / session %.1f",
                                               evaluation.score_net,
                                               evaluation.score_posture,
                                               evaluation.score_gross,
                                               evaluation.opportunity_density_score,
                                               evaluation.context_strength_score,
                                               evaluation.entry_readiness_score,
                                               evaluation.execution_alignment_score,
                                               execution_usefulness,
                                               evaluation.session_alignment_score,
                                               timing_usefulness,
                                               evaluation.risk_drag_score,
                                               risk_drag_label,
                                               early_emergence_delta_uplift_score,
                                               early_emergence_delta_posture,
                                               tradability_lift_score,
                                               tradability_lift_posture,
                                               decay_lateness_drag_score,
                                               evaluation.late_move_risk_score,
                                               evaluation.exhaustion_risk_score,
                                               overlay_summary,
                                               evaluation.price_engine_score,
                                               evaluation.microstructure_score,
                                               evaluation.volatility_transition_score,
                                               evaluation.structure_context_score,
                                               evaluation.session_timing_score);

   if(!evaluation.score_pack_ready)
     {
      evaluation.score_pack_reason = "score pack remains provisional because upstream support is still missing";
      evaluation.score_pack_summary = "score pack pending | numeric carry withheld until upstream support is available";
     }
   else if(!evaluation.price_engine_supported && !evaluation.microstructure_supported && !evaluation.volatility_transition_supported)
      evaluation.score_pack_reason = "score pack is present but still mostly neutral because live packet support is thin";
   else
     {
      string layer3_method_posture = "candidate ranking support only; trade_permission=false; entry_signal=false; early bursts still need liquidity/quote confirmation; not edge proof";
      string l4_handoff_posture = "upstream handoff only; Layer 4 still owns execution-adjusted ordering and must read l3_to_l4_authority proof";
      evaluation.score_pack_reason = StringFormat("execution=%s | timing=%s | risk_drag=%s | emergence=%s | tradability=%s | %s | pressure=%s | momentum=%s | move_age=%s | liquidity=%s | participation=%s | spread_stability=%s | quote_stability=%s | session_exec=%s | style_exec=%s | volatility=%s | burst=%s | method=%s | handoff=%s",
                                                  execution_usefulness,
                                                  timing_usefulness,
                                                  risk_drag_label,
                                                  early_emergence_delta_posture,
                                                  tradability_lift_posture,
                                                  overlay_summary,
                                                  evaluation.pressure_shift_posture,
                                                  evaluation.momentum_acceleration_posture,
                                                  evaluation.move_age_posture,
                                                  evaluation.liquidity_proximity_posture,
                                                  evaluation.participation_posture,
                                                  evaluation.spread_stability_posture,
                                                  evaluation.quote_stability_posture,
                                                  evaluation.session_execution_posture,
                                                  evaluation.style_execution_fit_posture,
                                                  volatility_summary,
                                                  evaluation.tick_burst_posture,
                                                  layer3_method_posture,
                                                  l4_handoff_posture);
     }
  }

struct ASC_SelectionFilterSummary
  {
   int assessed_symbols;
   int candidate_baseline_symbols;
   int pass_count;
   int pending_count;
   int fail_count;
  };

string ASC_SelectionFilterCandidateBucket(const ASC_Layer1SymbolState &symbol_state,
                                          const ASC_Layer2Packet &market_watch_packet,
                                          const bool corroboration_packet_is_available)
  {
   string base_bucket = symbol_state.classification.main_bucket_id;
   if(StringLen(base_bucket) <= 0)
      base_bucket = "unassigned";
   return base_bucket;
  }

string ASC_SelectionFilterOperatorState(const ASC_SelectionFilterEvaluation &evaluation)
  {
   if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
     {
      if(evaluation.eligibility_posture == "qualified")
         return "Candidate context qualified";
      if(evaluation.eligibility_posture == "restricted")
         return "Candidate context qualified with restricted carry";
      if(evaluation.eligibility_posture == "degraded")
         return "Candidate context degraded";
      if(evaluation.eligibility_posture == "stale")
         return "Candidate context stale";
      return "Candidate context carrying drag";
     }
   if(evaluation.eligibility_posture == "degraded")
      return "Candidate context degraded";
   if(evaluation.eligibility_posture == "stale")
      return "Candidate context stale";
   if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "Candidate context unavailable";
  return "Candidate context building";
  }

string ASC_SelectionFilterSpecificationReasonCode(const ASC_Layer2Packet &market_watch_packet)
  {
   if(!market_watch_packet.has_specification)
      return "specification_unavailable";
   if(market_watch_packet.spec_is_degraded)
      return "specification_degraded";
   if(market_watch_packet.spec_is_stale)
      return "specification_stale";
  return "specification_unavailable";
  }

string ASC_SelectionFilterOperatorState(const ASC_SelectionFilterEvaluation &evaluation);

bool ASC_SelectionFilterTradeModeAllowsEntry(const long trade_mode)
  {
   // Layer-3 remains scanner-only. Full entry permission improves ranking carry,
   // while direction-limited modes stay visible but score lower instead of becoming a new veto lane.
   return (trade_mode == SYMBOL_TRADE_MODE_FULL);
  }

void ASC_SelectionFilterSetOutcome(ASC_SelectionFilterEvaluation &evaluation,
                                   const ASC_SelectionFilterResultState result_state,
                                   const string result_reason,
                                   const string reason_code,
                                   const string reason_summary,
                                   const string eligibility_posture,
                                   const string disqualifiers,
                                   const string next_required_step)
  {
   evaluation.result_state = result_state;
   evaluation.result_state_text = (result_state == ASC_SELECTION_FILTER_RESULT_PASS
                                   ? "pass"
                                   : (result_state == ASC_SELECTION_FILTER_RESULT_FAIL ? "fail" : "pending"));
   evaluation.result_reason = result_reason;
   evaluation.reason_code = reason_code;
   evaluation.reason_summary = reason_summary;
   evaluation.eligibility_posture = eligibility_posture;
   evaluation.disqualifiers = disqualifiers;
   evaluation.next_required_step = next_required_step;
  }


void ASC_SelectionFilterAppendIssue(string &issues,const string issue)
  {
   if(StringLen(issue) <= 0)
      return;
   if(StringLen(issues) > 0)
      issues += " | ";
   issues += issue;
  }

void ASC_SelectionFilterApplyScoringFirstCarry(const ASC_Layer1SymbolState &symbol_state,
                                               const ASC_Layer2Packet &market_watch_packet,
                                               const double spread_pct,
                                               const double spread_pct_cap,
                                               ASC_SelectionFilterEvaluation &evaluation)
  {
   if(!evaluation.market_state_is_open || !evaluation.classification_is_resolved)
      return;

   string carry_issues = "";
   double carry_penalty = 0.0;

   if(!evaluation.freshness_is_current)
     {
      carry_penalty += (symbol_state.is_degraded ? 18.0 : 12.0);
      ASC_SelectionFilterAppendIssue(carry_issues,
                                     symbol_state.is_degraded ? "upstream degraded" : "upstream stale");
     }

   if(!evaluation.corroboration_packet_is_available)
     {
      carry_penalty += 18.0;
      ASC_SelectionFilterAppendIssue(carry_issues, "live packet unavailable");
     }
   else
     {
      if(evaluation.continuity_backed)
        {
         carry_penalty += 14.0;
         ASC_SelectionFilterAppendIssue(carry_issues, "continuity-backed packet");
        }

      if(!evaluation.quote_freshness_is_acceptable)
        {
         carry_penalty += 10.0;
         ASC_SelectionFilterAppendIssue(carry_issues, "quote freshness outside preferred window");
        }

      if(!evaluation.tick_age_is_sane)
        {
         carry_penalty += 8.0;
         ASC_SelectionFilterAppendIssue(carry_issues, "tick age elevated");
        }
     }

   if(!market_watch_packet.valid_trade_mode)
     {
      carry_penalty += 10.0;
      ASC_SelectionFilterAppendIssue(carry_issues, "trade mode unavailable");
     }
   else if(!evaluation.tradability_is_open)
     {
      carry_penalty += 12.0;
      ASC_SelectionFilterAppendIssue(carry_issues, "trade mode restricted");
     }

   if(!evaluation.specification_is_acceptable)
     {
      carry_penalty += (market_watch_packet.spec_is_degraded ? 12.0 : 10.0);
      ASC_SelectionFilterAppendIssue(carry_issues,
                                     market_watch_packet.spec_is_degraded
                                     ? "specification degraded"
                                     : (market_watch_packet.spec_is_stale ? "specification stale" : "specification unavailable"));
     }

   if(!evaluation.spread_is_sane)
     {
      carry_penalty += 15.0;
      ASC_SelectionFilterAppendIssue(carry_issues,
                                     StringFormat("spread %s above preferred cap %s",
                                                  spread_pct >= 0.0 ? (DoubleToString(spread_pct, 3) + "%") : "unavailable",
                                                  DoubleToString(spread_pct_cap, 3) + "%"));
     }

   if(!evaluation.confidence_is_acceptable)
     {
      carry_penalty += 12.0;
      ASC_SelectionFilterAppendIssue(carry_issues, "market-state confidence soft");
     }

   if(!evaluation.score_pack_ready)
     {
      carry_penalty += 8.0;
      ASC_SelectionFilterAppendIssue(carry_issues, "score pack carrying neutral support");
     }

   if(carry_penalty > 0.0)
     {
      evaluation.score_net = ASC_SelectionFilterRoundScore(evaluation.score_net - carry_penalty);
      evaluation.score_posture = ASC_SelectionFilterScorePosture(evaluation.score_net);
      evaluation.attention_posture = ASC_SelectionFilterAttentionPosture(evaluation.score_net);
      evaluation.score_pack_summary += StringFormat(" | carry_penalty %.1f", carry_penalty);

      string carry_posture = "guarded";
      if(StringFind(carry_issues, "stale") >= 0)
         carry_posture = "stale";
      else if(StringFind(carry_issues, "degraded") >= 0 || StringFind(carry_issues, "continuity") >= 0)
         carry_posture = "degraded";
      else if(StringFind(carry_issues, "trade mode restricted") >= 0)
         carry_posture = "restricted";
      else if(evaluation.execution_alignment_score >= 60.0
              && evaluation.entry_readiness_score >= 62.5
              && evaluation.tick_burst_score >= 57.5
              && evaluation.move_age_score >= 55.0
              && evaluation.directional_consistency_score >= 52.5
              && evaluation.friction_quality_score >= 50.0
              && evaluation.liquidity_quality_score >= 52.5
              && evaluation.execution_friction_penalty <= 45.0
              && evaluation.risk_drag_score < 50.0)
         carry_posture = "building";

      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PASS,
                                    "candidate context carried with drag",
                                    "score_led_penalty_carry",
                                    "qualified-with-drag: Layer-3 keeps best-available carry while penalties reduce reserve quality; shortlist ownership still remains downstream",
                                    carry_posture,
                                    (StringLen(carry_issues) > 0 ? carry_issues : "none"),
                                    "allow shortlist reserve carry only after weaker support improves");
     }
   else
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PASS,
                                    "candidate context qualified for shortlist intake",
                                    "score_led_candidate_ready",
                                    "qualified: live Layer-3 carry is clean enough for shortlist intake; shortlist selection still decides promotion and board visibility",
                                    "qualified",
                                    "none",
                                    "allow shortlist owner intake");
     }

   evaluation.result_state_operator_text = ASC_SelectionFilterOperatorState(evaluation);
  }

string ASC_SelectionFilterTradeModeText(const bool valid_trade_mode,const long trade_mode)
  {
   if(!valid_trade_mode)
      return "unavailable";
   if(trade_mode == SYMBOL_TRADE_MODE_DISABLED)
      return "disabled";
   if(trade_mode == SYMBOL_TRADE_MODE_CLOSEONLY)
      return "close only";
   if(trade_mode == SYMBOL_TRADE_MODE_LONGONLY)
      return "long only";
   if(trade_mode == SYMBOL_TRADE_MODE_SHORTONLY)
      return "short only";
   if(trade_mode == SYMBOL_TRADE_MODE_FULL)
      return "full";
  return "restricted";
  }

bool ASC_SelectionFilterPendingOrUnavailableText(const string value)
  {
   string normalized = ASC_SelectionFilterNormalizeText(value);
   return (normalized == "pending" || normalized == "unavailable" || normalized == "unknown" || StringLen(normalized) <= 0);
  }

bool ASC_SelectionFilterPostWarmupHydrationReady(const ASC_Layer2Packet &packet,string &reason_out)
  {
   reason_out = "hydrated";
   if(!ASC_L2PacketHasLawfulSnapshot(packet))
     {
      reason_out = "quote_snapshot_not_live";
      return false;
     }
   if(packet.continuity_backed)
     {
      reason_out = "continuity_backed_only";
      return false;
     }
   if(!packet.valid_day_range || !packet.valid_daily_change_pct || !packet.valid_day_range_position)
     {
      reason_out = "day_structure_not_ready";
      return false;
     }
   if(!packet.valid_atr_points || !packet.valid_atr_pct || !packet.valid_spread_to_atr)
     {
      reason_out = "atr_family_not_ready";
      return false;
     }
   if(ASC_SelectionFilterPendingOrUnavailableText(packet.volatility_state))
     {
      reason_out = "volatility_helper_not_ready";
      return false;
     }
   if(ASC_SelectionFilterPendingOrUnavailableText(packet.friction_state))
     {
      reason_out = "friction_helper_not_ready";
      return false;
     }
   if(ASC_SelectionFilterPendingOrUnavailableText(packet.liquidity_state))
     {
      reason_out = "liquidity_helper_not_ready";
      return false;
     }
   return true;
  }

void ASC_SelectionFilterEvaluate(const ASC_Layer1SymbolState &symbol_state,
                                 const ASC_Layer2Packet &market_watch_packet,
                                 const bool corroboration_packet_is_available,
                                 ASC_SelectionFilterEvaluation &evaluation)
  {
   ASC_SelectionFilterInitEvaluation(evaluation);
   datetime now_utc = TimeGMT();
   evaluation.market_state_is_open = (symbol_state.state == ASC_L1_OPEN);
   evaluation.classification_is_resolved = symbol_state.classification.resolved;
   evaluation.freshness_is_current = (!symbol_state.is_stale && !symbol_state.is_degraded);

   string confidence_state = symbol_state.confidence;
   StringToLower(confidence_state);
   evaluation.confidence_is_acceptable = (confidence_state != "low" && confidence_state != "unknown");
   evaluation.corroboration_packet_is_available = corroboration_packet_is_available;
   evaluation.continuity_backed = market_watch_packet.continuity_backed;
   evaluation.quote_freshness_is_acceptable = (market_watch_packet.freshness == ASC_L2_FRESH || market_watch_packet.freshness == ASC_L2_AGING);
   evaluation.tick_age_is_sane = (market_watch_packet.valid_tick_time && market_watch_packet.packet_age_sec <= ASC_L2_STALE_AGE_SEC);
   double spread_pct = ASC_SelectionFilterSpreadPct(market_watch_packet);
   double spread_pct_cap = (symbol_state.classification.main_bucket_id == "crypto") ? 1.50 : 0.35;
   evaluation.spread_is_sane = (spread_pct >= 0.0 && spread_pct <= spread_pct_cap);
   evaluation.tradability_is_open = market_watch_packet.valid_trade_mode
                                    && ASC_SelectionFilterTradeModeAllowsEntry(market_watch_packet.trade_mode);
   evaluation.specification_is_acceptable = (market_watch_packet.has_specification
                                             && !market_watch_packet.spec_is_stale
                                             && !market_watch_packet.spec_is_degraded);
   bool has_lawful_packet = (corroboration_packet_is_available && ASC_L2PacketHasLawfulSnapshot(market_watch_packet));
   evaluation.evidence_intake_state = ASC_SelectionFilterEvidenceIntakeState(symbol_state,
                                                                             market_watch_packet,
                                                                             corroboration_packet_is_available,
                                                                             has_lawful_packet);
   evaluation.evidence_intake_claim_evidence_status = ASC_CandidateEvidenceIntakeClaimEvidenceStatus(evaluation.evidence_intake_state);
   ASC_Layer1PassSummary l1_summary;
   bool has_l1_summary = ASC_Layer1TryGetLatestSummary(l1_summary);
   bool post_warmup_hydration_gate_active = (has_l1_summary && l1_summary.warmup_ready);
   string post_warmup_hydration_reason = "hydrated";
   bool post_warmup_hydration_ready = true;
   if(post_warmup_hydration_gate_active)
      post_warmup_hydration_ready = ASC_SelectionFilterPostWarmupHydrationReady(market_watch_packet, post_warmup_hydration_reason);

   ASC_SelectionFilterSetOutcome(evaluation,
                                 ASC_SELECTION_FILTER_RESULT_PENDING,
                                 "filter refresh pending",
                                 "awaiting_refresh",
                                 "pending: awaiting next score-context refresh pass",
                                 "guarded",
                                 "none",
                                 "await next candidate-context refresh");
   evaluation.candidate_bucket = ASC_SelectionFilterCandidateBucket(symbol_state,
                                                                    market_watch_packet,
                                                                    corroboration_packet_is_available);
   evaluation.evaluated_at_utc = now_utc;

   if(!evaluation.market_state_is_open)
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    "market is not open",
                                    "market_not_open",
                                    "pending: market is not open, so score-led carry pauses until the symbol reopens",
                                    "guarded",
                                    "state is not open",
                                    "await open-state transition");
     }
   else if(!evaluation.classification_is_resolved)
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    "classification unresolved",
                                    "classification_unresolved",
                                    "guarded: classification owner truth is unresolved, so score-led carry cannot normalize the symbol yet",
                                    "guarded",
                                    "classification unresolved",
                                    "await classification refresh");
     }
   else if(!evaluation.freshness_is_current)
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    symbol_state.is_degraded ? "upstream data degraded" : "upstream data stale",
                                    symbol_state.is_degraded ? "upstream_degraded" : "upstream_stale",
                                    symbol_state.is_degraded
                                    ? "degraded: upstream Layer-1 packet is degraded; score carry should stay conservative until freshness recovers"
                                    : "stale: upstream Layer-1 packet is stale; score carry should wait for refreshed context",
                                    symbol_state.is_degraded ? "degraded" : "stale",
                                    symbol_state.is_degraded ? "degraded freshness" : "stale freshness",
                                    "await freshness recovery");
     }
   else if(!evaluation.corroboration_packet_is_available)
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    "market watch is unavailable",
                                    "market_watch_unavailable",
                                    "guarded: Layer-2 corroboration packet is unavailable, so score-led carry is waiting on live packet truth",
                                    "guarded",
                                    "market-watch snapshot unavailable",
                                    "await open-symbol snapshot corroboration");
     }
   else if(evaluation.continuity_backed)
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    "market watch continuity is active",
                                    "market_watch_continuity",
                                    "degraded: corroboration is continuity-backed and should return to live packet truth before priority can improve",
                                    "degraded",
                                    "live market-watch continuity",
                                    "await live market-watch refresh");
     }
   else if(!evaluation.quote_freshness_is_acceptable || !evaluation.tick_age_is_sane)
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    "market watch is stale",
                                    "market_watch_stale",
                                    "stale: corroboration freshness/tick-age is outside the preferred carry window and should refresh before priority improves",
                                    "stale",
                                    "market-watch freshness outside preferred window",
                                    "await fresher market-watch update");
     }
   else if(!market_watch_packet.valid_trade_mode)
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    "trading permission is unavailable",
                                    "trading_permission_unavailable",
                                    "guarded: trade-mode owner truth is unavailable, so lawful entry context cannot be confirmed yet",
                                    "guarded",
                                    "trade mode unavailable",
                                    "await tradability owner refresh");
     }
   else if(!evaluation.tradability_is_open)
     {
      string trade_mode_text = ASC_SelectionFilterTradeModeText(market_watch_packet.valid_trade_mode, market_watch_packet.trade_mode);
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    "trading permission is restricted",
                                    "trading_permission_restricted",
                                    "guarded: trade mode is restricted; score carry can keep visibility, but full entry permission is not currently available",
                                    "guarded",
                                    "trade mode " + trade_mode_text,
                                    "await unrestricted trade mode");
     }
   else if(!evaluation.specification_is_acceptable)
     {
      string specification_reason_code = ASC_SelectionFilterSpecificationReasonCode(market_watch_packet);
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    "specification truth is not ready",
                                    specification_reason_code,
                                    "guarded: specification owner truth is unavailable for score-carry normalization",
                                    "guarded",
                                    ASC_L2SpecificationReasonToOperatorText(market_watch_packet),
                                    "await specification owner refresh");
      if(specification_reason_code == "specification_degraded")
        {
         evaluation.reason_summary = "degraded: specification owner truth is degraded and score carry should stay conservative until it recovers";
         evaluation.eligibility_posture = "degraded";
        }
      else if(specification_reason_code == "specification_stale")
        {
         evaluation.reason_summary = "stale: specification owner truth is stale and should refresh before priority improves";
         evaluation.eligibility_posture = "stale";
        }
     }
   else if(post_warmup_hydration_gate_active && !post_warmup_hydration_ready)
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    "post-warmup hydration still completing",
                                    "l2_post_warmup_hydration_pending",
                                    "guarded: post-warmup Layer-2 trader-facing hydration is still completing, so full score/context-ready carry is deferred",
                                    "building",
                                    "l2 hydration pending: " + post_warmup_hydration_reason,
                                    "await post-warmup L2 hydration completion");
     }
   else if(!evaluation.spread_is_sane)
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    "execution quality is unfavorable",
                                    "spread_out_of_bounds",
                                    StringFormat("guarded: spread %.3f%% is above the preferred carry cap %.3f%%",
                                                 spread_pct,
                                                 spread_pct_cap),
                                    "guarded",
                                    "spread above preferred cap",
                                    "await tighter spread");
     }
   else if(!evaluation.confidence_is_acceptable)
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PENDING,
                                    "market-state confidence is too low",
                                    "confidence_too_low",
                                    "guarded: market-state confidence is below the preferred carry range",
                                    "guarded",
                                    "confidence too low",
                                    "await confidence recovery");
     }
   else
     {
      ASC_SelectionFilterSetOutcome(evaluation,
                                    ASC_SELECTION_FILTER_RESULT_PASS,
                                    "candidate context qualified for shortlist intake",
                                    "gate_checks_satisfied",
                                    StringFormat("qualified: core Layer-3 inputs are clean for shortlist intake (open state, resolved classification, live corroboration, spread %.3f%% within cap %.3f%%, full tradability, and specification readiness); shortlist ownership remains downstream",
                                                 spread_pct,
                                                 spread_pct_cap),
                                    "qualified",
                                    "none",
                                    "allow shortlist owner intake");
     }

   evaluation.result_state_operator_text = ASC_SelectionFilterOperatorState(evaluation);

   evaluation.candidate_bucket = ASC_SelectionFilterCandidateBucket(symbol_state,
                                                                    market_watch_packet,
                                                                    evaluation.corroboration_packet_is_available);

   ASC_SelectionFilterPopulateScorePack(symbol_state,
                                        market_watch_packet,
                                        evaluation);
   ASC_SelectionFilterApplyScoringFirstCarry(symbol_state,
                                             market_watch_packet,
                                             spread_pct,
                                             spread_pct_cap,
                                             evaluation);

   string spread_text = (spread_pct >= 0.0) ? (DoubleToString(spread_pct, 3) + "%") : "unavailable";
   string trade_mode_text = ASC_SelectionFilterTradeModeText(market_watch_packet.valid_trade_mode, market_watch_packet.trade_mode);

   string spread_cap_text = DoubleToString(spread_pct_cap, 3) + "%";
   evaluation.dependencies_text = ASC_SelectionFilterBuildDependenciesText(evaluation,
                                                                           spread_text,
                                                                           spread_cap_text,
                                                                           trade_mode_text);
   evaluation.corroboration_text = ASC_SelectionFilterBuildCorroborationText(evaluation);
   evaluation.confidence_text = ASC_L1ConfidenceToOperatorText(symbol_state.confidence);
   if(evaluation.continuity_backed)
      evaluation.confidence_text += " | continuity-backed corroboration";
   else if(!evaluation.corroboration_packet_is_available)
      evaluation.confidence_text += " | live corroboration pending";

   evaluation.evidence_intake_detail = ASC_SelectionFilterEvidenceIntakeDetail(symbol_state,
                                                                               market_watch_packet,
                                                                               corroboration_packet_is_available,
                                                                               has_lawful_packet,
                                                                               evaluation,
                                                                               evaluation.evidence_intake_state);
  }

void ASC_SelectionFilterEvaluate(const ASC_Layer1SymbolState &symbol_state,
                                 const bool corroboration_packet_is_available,
                                 ASC_SelectionFilterEvaluation &evaluation)
  {
   ASC_Layer2Packet market_watch_packet;
   bool has_packet = ASC_Layer2TryGetPacketBySymbol(symbol_state.symbol, market_watch_packet)
                     && (market_watch_packet.admitted || market_watch_packet.tactical_only);
   if(!has_packet)
      ASC_L2InitPacket(market_watch_packet, symbol_state.symbol);
   bool packet_has_lawful_snapshot = has_packet && ASC_L2PacketHasLawfulSnapshot(market_watch_packet);
   bool effective_corroboration_available = (corroboration_packet_is_available || packet_has_lawful_snapshot);
   ASC_SelectionFilterEvaluate(symbol_state,
                               market_watch_packet,
                               effective_corroboration_available,
                               evaluation);
  }

void ASC_SelectionFilterBuildSummary(ASC_SelectionFilterSummary &summary)
  {
   summary.assessed_symbols = 0;
   summary.candidate_baseline_symbols = 0;
   summary.pass_count = 0;
   summary.pending_count = 0;
   summary.fail_count = 0;

   int total = ASC_Layer1CachedSymbolCount();
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState symbol_state;
      if(!ASC_Layer1GetCachedSymbol(i, symbol_state))
         continue;
      if(StringLen(symbol_state.symbol) <= 0)
         continue;

      summary.assessed_symbols++;
      if(symbol_state.state == ASC_L1_OPEN && symbol_state.classification.resolved)
         summary.candidate_baseline_symbols++;

      ASC_Layer2Packet market_watch_packet;
      bool market_watch_packet_is_available = ASC_Layer2TryGetPacketBySymbol(symbol_state.symbol, market_watch_packet)
                                              && (market_watch_packet.admitted || market_watch_packet.tactical_only)
                                              && ASC_L2PacketHasLawfulSnapshot(market_watch_packet);
      ASC_SelectionFilterEvaluation evaluation;
      ASC_SelectionFilterEvaluate(symbol_state, market_watch_packet, market_watch_packet_is_available, evaluation);
      if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
         summary.pass_count++;
      else if(evaluation.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
         summary.fail_count++;
      else
         summary.pending_count++;
     }
  }

#endif
