#ifndef __ASC_SHORTLIST_SELECTION_ENGINE_MQH__
#define __ASC_SHORTLIST_SELECTION_ENGINE_MQH__

#include "ASC_ATRSummaryEngine.mqh"
#include "ASC_RegimeSummaryEngine.mqh"
#include "ASC_LiquidityFrictionSummaryEngine.mqh"
#include "ASC_CorrelationSummaryEngine.mqh"
#include "../market_state/ASC_MarketStateEngine.mqh"
#include "../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"
#include "../logging/ASC_FunctionResults.mqh"
#include "../candidate_filtering/ASC_SelectionFilter.mqh"
#include "../artifacts/ASC_ArtifactTextHelpers.mqh"

struct ASC_ShortlistCorrelationSummary
  {
   double average_score;
   string high_a_symbol;
   double high_a_score;
   string high_b_symbol;
   double high_b_score;
   string low_a_symbol;
   double low_a_score;
   string low_b_symbol;
   double low_b_score;
   int peers_compared;
   int peers_packet_ready;
   bool anchor_packet_ready;
   bool summary_ready;
   string summary_posture;
   string summary_reason;
  };

struct ASC_ShortlistSymbolSummary
  {
   string symbol;
   ASC_Layer1SymbolState state;
   ASC_Layer2Packet packet;
   bool has_packet;
   ASC_SelectionFilterEvaluation filter;
   double shortlist_score;
   double shortlist_l3_score;
   double shortlist_context_score;
   double shortlist_stability_bias;
   int raw_rank;
   int rank;
   int bucket_rank;
   int sub_bucket_rank;
   bool shortlisted;
   bool bucket_shortlisted;
   bool sub_bucket_rank_available;
   double overall_board_score;
   double overall_board_quality_adjustment;
   double overall_board_correlation_penalty;
   double overall_board_bucket_penalty;
   double overall_board_conflict_penalty;
   double relative_field_rank_score;
   double relative_opportunity_percentile;
   double leader_separation_score;
   double top10_compression_score;
   string field_opportunity_regime;
   string overall_board_peer_symbol;
   double overall_board_peer_correlation;
   int overall_board_cluster_count;
   string overall_board_posture;
   string overall_board_reason;
   string membership_state;
   string shortlist_band;
   string shortlist_stability_posture;
   string shortlist_posture;
   string shortlist_attention_posture;
   string shortlist_score_summary;
   string shortlist_reason;
   double cleanliness_score;
   string cleanliness_posture;
   double session_fit_for_style_score;
   string session_fit_for_style;
   double asset_execution_penalty;
   string asset_execution_penalty_posture;
   double style_fit_score;
   string style_fit_posture;
   string style_fit_reason;
   double deep_request_priority_score;
   string deep_request_priority;
   string deep_request_reason;
   string evidence_intake_state;
   string evidence_intake_claim_evidence_status;
   string evidence_intake_detail;
   string l4_meaning_token;
   string trade_permission_token;
   string entry_signal_token;
   string l3_authority_source_token;
   string l3_authority_age_token;
   string l4_rank_reason_token;
   string why_not_higher_token;
   string exclusion_reason_token;
   string correlation_status_token;
   string exposure_status_token;
   string top_list_authority_token;
   string artifact_projection_token;
   string behavior_change_token;
   string l4_proof_tokens;
   ASC_ShortlistCorrelationSummary correlation_summary;
   datetime shortlist_evaluated_utc;
  };

string g_asc_shortlist_symbols[];
datetime g_asc_shortlist_last_rebuild_utc = 0;
bool ASC_ShortlistSymbolMatchesContext(const ASC_ShortlistSymbolSummary &entry,const string symbol);

datetime g_asc_shortlist_hold_until_utc = 0;
string g_asc_shortlist_posture = "pending";
string g_asc_shortlist_reason = "awaiting shortlist initialization";
int g_asc_shortlist_dirty_challenge_beats = 0;
const int ASC_SHORTLIST_SIZE = 10;
const int ASC_SHORTLIST_BUCKET_SIZE = 5;
const int ASC_SHORTLIST_HOLD_SECONDS = 30;
const int ASC_SHORTLIST_DIRTY_CHALLENGE_BEATS_REQUIRED = 1;
const double ASC_SHORTLIST_NEAR_TIE_DELTA = 1.25;
const double ASC_SHORTLIST_MATERIAL_TOP_SHIFT = 3.0;
const double ASC_SHORTLIST_REPLACEMENT_CHALLENGE_MARGIN = 3.5;
const double ASC_SHORTLIST_REPLACEMENT_RELIEF_PENALTY_DELTA = 2.0;
const double ASC_SHORTLIST_REPLACEMENT_RELIEF_BOARD_ADVANTAGE = 1.0;
const double ASC_SHORTLIST_REPLACEMENT_EXECUTION_RELIEF_DELTA = 8.0;
const double ASC_SHORTLIST_REPLACEMENT_EXECUTION_RELIEF_BOARD_ADVANTAGE = 0.75;
const double ASC_SHORTLIST_REPLACEMENT_EXECUTION_FRICTION_IMPROVEMENT_MIN = 2.5;
const double ASC_SHORTLIST_REPLACEMENT_MIN_LIQUIDITY_QUALITY = 55.0;
const double ASC_SHORTLIST_OVERALL_CORRELATION_WATCH = 0.55;
const double ASC_SHORTLIST_OVERALL_CORRELATION_CROWD = 0.72;



string ASC_ShortlistTraceIdentity(const ASC_ShortlistSymbolSummary &entry)
  {
   string membership = (entry.shortlisted && entry.rank > 0) ? "overall" : "reserve";
   string bucket_membership = (entry.bucket_shortlisted && entry.bucket_rank > 0) ? "bucket_top5" : "bucket_outside";
   string sub_bucket_rank = entry.sub_bucket_rank_available ? IntegerToString(entry.sub_bucket_rank) : "reserved";
   return StringFormat("l4_rank=%d bucket_rank=%d sub_bucket_rank=%s membership=%s bucket_membership=%s shortlist_posture=%s",
                       entry.rank,
                       entry.bucket_rank,
                       sub_bucket_rank,
                       membership,
                       bucket_membership,
                       ASC_ArtifactHumanizeLabel(entry.shortlist_posture));
  }

string ASC_ShortlistFieldRegimeOperatorText(const string regime)
  {
   if(regime == "thin_day_best_available")
      return "selective day";
   if(regime == "rare_clean_day")
      return "rare clean day";
   if(regime == "strong_day")
      return "strong day";
   if(regime == "workable_day")
      return "workable day";
   return ASC_ArtifactHumanizeLabel(regime);
  }

string ASC_ShortlistOrdinaryCorrelationClause(const string peer_symbol,
                                              const double peer_corr,
                                              const int cluster_count)
  {
   string peer_text = ((StringLen(peer_symbol) > 0 && peer_symbol != "n/a") ? peer_symbol : "n/a");
   if(peer_text == "n/a")
      return "ordinary peer support unavailable";

   string concentration_text = "contained";
   if(peer_corr >= ASC_SHORTLIST_OVERALL_CORRELATION_CROWD || cluster_count >= 2)
      concentration_text = "crowded";
   else if(peer_corr >= ASC_SHORTLIST_OVERALL_CORRELATION_WATCH || cluster_count == 1)
      concentration_text = "watch";

   return StringFormat("peer support %s via %s %.2f",
                       concentration_text,
                       peer_text,
                       peer_corr);
  }

string ASC_ShortlistDecisionEvidence(const int membership_delta,
                                     const int proposed_count,
                                     const int existing_count)
  {
   return StringFormat("delta %d | proposed %d | existing %d",
                       membership_delta,
                       proposed_count,
                       existing_count);
  }


string ASC_ShortlistMetricPurposeToken()
  {
   return "metric_domain=l4_shortlist | metric_purpose=ranking_support | metric_owner=ASC_ShortlistSelectionEngine.ASC_RebuildShortlist";
  }

string ASC_ShortlistMetricFreshnessToken(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.l3_authority_age_token == "fresh")
      return "fresh";
   if(entry.l3_authority_age_token == "stale")
      return "stale";
   if(entry.l3_authority_age_token == "retained")
      return "retained";
   if(entry.l3_authority_source_token == "blocked")
      return "unavailable";
   if(entry.l3_authority_source_token == "limited" || entry.correlation_status_token == "partial")
      return "partial";
   if(entry.correlation_status_token == "unavailable")
      return "degraded";
   return "unknown";
  }

string ASC_ShortlistMetricSampleStatusToken(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.top_list_authority_token == "clean" && (entry.correlation_status_token == "complete" || entry.correlation_status_token == "not_applicable"))
      return "sufficient";
   if(entry.top_list_authority_token == "limited" || entry.correlation_status_token == "partial")
      return "partial";
   if(entry.top_list_authority_token == "pending" || entry.correlation_status_token == "pending")
      return "insufficient";
   if(entry.correlation_status_token == "unavailable")
      return "unavailable";
   return "unknown";
  }

string ASC_ShortlistMetricValidityToken(const ASC_ShortlistSymbolSummary &entry)
  {
   string freshness = ASC_ShortlistMetricFreshnessToken(entry);
   string sample = ASC_ShortlistMetricSampleStatusToken(entry);
   if(freshness == "fresh" && sample == "sufficient" && entry.artifact_projection_token == "allowed")
      return "valid";
   if(sample == "unavailable" || freshness == "unavailable")
      return "unavailable";
   if(freshness == "stale" || freshness == "retained" || freshness == "degraded")
      return "degraded";
   if(sample == "partial" || sample == "insufficient" || freshness == "partial")
      return "limited";
   return "unknown";
  }

string ASC_ShortlistMetricFalsifierToken(const ASC_ShortlistSymbolSummary &entry)
  {
   string freshness = ASC_ShortlistMetricFreshnessToken(entry);
   string sample = ASC_ShortlistMetricSampleStatusToken(entry);
   if(freshness == "stale" || freshness == "retained" || freshness == "degraded")
      return "stale_input";
   if(sample == "insufficient" || sample == "partial")
      return "insufficient_sample";
   if(entry.correlation_status_token == "pending")
      return "missing_timeframe";
   if(entry.correlation_status_token == "unavailable")
      return "unavailable_dependency";
   return "not_applicable";
  }

string ASC_ShortlistMetricProofToken(const ASC_ShortlistSymbolSummary &entry)
  {
   string freshness = ASC_ShortlistMetricFreshnessToken(entry);
   string sample = ASC_ShortlistMetricSampleStatusToken(entry);
   string validity = ASC_ShortlistMetricValidityToken(entry);
   string falsifier = ASC_ShortlistMetricFalsifierToken(entry);
   string projection = (validity == "valid") ? "allowed" : ((validity == "unavailable") ? "blocked" : "qualified");
   return ASC_ShortlistMetricPurposeToken()
          + " | trade_permission=false | entry_signal=false | execution_permission=false"
          + " | final_trade_decision=false | strategy_edge_proof=false | input_source=mixed"
          + " | freshness_status=" + freshness
          + " | sample_status=" + sample
          + " | timeframe_coverage=" + entry.correlation_status_token
          + " | tick_window_status=not_applicable"
          + " | validity_status=" + validity
          + " | falsifier=" + falsifier
          + " | artifact_projection=" + projection
          + " | behavior_change=no";
  }

string ASC_ShortlistAuthorityBoundaryProofToken(const ASC_ShortlistSymbolSummary &entry)
  {
   string correlation_source = (entry.correlation_status_token == "complete") ? "shortlist_correlation_summary" : "unproven_or_partial_shortlist_correlation_summary";
   string correlation_support = (entry.correlation_status_token == "complete") ? "support_available" : ((entry.correlation_status_token == "not_applicable") ? "not_applicable" : "support_limited");
   string exposure_support = (entry.exposure_status_token == "clean") ? "support_available" : ((entry.exposure_status_token == "not_applicable") ? "not_applicable" : "support_limited");
   return "l4_scope=contextual_priority_support"
          + " | rank_validity_scope=contextual_priority_ordering_support"
          + " | l3_score_is_support_input_only=true"
          + " | l4_consumes_l3_support_only=true"
          + " | l3_to_l4_authority_scope=committed_l3_support_only"
          + " | rank_may_differ_from_raw_l3_score=true"
          + " | score_vs_rank_mismatch=advisory_only"
          + " | limitation_reason=" + entry.why_not_higher_token
          + " | dependency_reason=" + entry.exclusion_reason_token
          + " | freshness_reason=" + entry.l3_authority_age_token
          + " | correlation_source=" + correlation_source
          + " | correlation_support_status=" + correlation_support
          + " | correlation_limitation_reason=" + entry.correlation_status_token
          + " | active_exposure_status=" + entry.exposure_status_token
          + " | future_exposure_status=pending_orders_are_future_exposure"
          + " | closed_history_context_status=closed_history_context_only"
          + " | closed_history_not_active_exposure=true"
          + " | open_positions_are_active_exposure=true"
          + " | pending_orders_are_future_exposure=true"
          + " | exposure_limitation_reason=" + exposure_support
          + " | l4_not_deep_analysis=true"
          + " | l4_not_final_trade_decision=true"
          + " | selected_symbol_requires_l5_for_depth=true"
          + " | l5_not_implied_by_rank=true"
          + " | complete_evidence=false"
          + " | fresh_evidence_when_stale=false"
          + " | clean_evidence_when_partial_or_unavailable=false"
          + " | dossier_l4_projection=consumer_only"
          + " | market_board_l4_projection=consumer_only"
          + " | current_focus_l4_projection=mirror_only_if_selected_symbol_exists"
          + " | writers_do_not_own_l4_truth=true";
  }

string ASC_ShortlistEvidenceIntakeState(const ASC_SelectionFilterEvaluation &filter,
                                      const bool has_linked_l3,
                                      const bool source_ready)
  {
   if(!has_linked_l3 || !source_ready)
      return ASC_SHORTLIST_EVID_INTAKE_SRC_RT_UNPROVEN;
   return ASC_ShortlistEvidenceIntakeText(filter.evidence_intake_state);
  }

string ASC_ShortlistEvidenceIntakeDetail(const ASC_SelectionFilterEvaluation &filter,
                                         const bool has_linked_l3,
                                         const bool source_ready)
  {
   string state = ASC_ShortlistEvidenceIntakeState(filter, has_linked_l3, source_ready);
   string detail = "shortlist_evidence_intake_boundary=present";
   detail += " | upstream_candidate_evidence_state=" + ASC_ShortlistEvidenceIntakeText(filter.evidence_intake_state);
   detail += " | shortlist_evidence_intake_state=" + state;
   detail += " | shortlist_evidence_intake_claim_evidence_status=" + ASC_ShortlistEvidenceIntakeClaimEvidenceStatus(state);
   detail += " | l3_source_linked=" + (has_linked_l3 ? "yes" : "no");
   detail += " | l3_source_ready=" + (source_ready ? "yes" : "no");
   detail += " | shortlist_score_change=no";
   detail += " | shortlist_rank_change=no";
   detail += " | top_list_change=no";
   detail += " | market_board_selection_change=no";
   detail += " | unavailable_is_not_shortlist_gate=yes";
   detail += " | metric_domain=l4_shortlist";
   detail += " | metric_purpose=ranking_support";
   detail += " | metric_owner=ASC_ShortlistSelectionEngine.ASC_RebuildShortlist";
   detail += " | input_source=mixed";
   detail += " | freshness_status=summary_row";
   detail += " | sample_status=summary_row";
   detail += " | timeframe_coverage=summary_row";
   detail += " | tick_window_status=not_applicable";
   detail += " | validity_status=summary_row";
   detail += " | falsifier=stale_input_or_insufficient_sample_or_missing_timeframe";
   detail += " | artifact_projection=qualified";
   detail += " | behavior_change=no";
   detail += " | metadata_only=yes";
   return detail;
  }


string ASC_ShortlistLayer3AuthoritySourceToken(const ASC_SelectionFilterEvaluation &filter,
                                               const bool has_linked_l3,
                                               const bool source_ready)
  {
   if(!has_linked_l3)
      return "unknown";
   if(!source_ready)
      return "pending";

   string intake_state = ASC_ShortlistEvidenceIntakeText(filter.evidence_intake_state);
   if(intake_state == ASC_SHORTLIST_EVID_INTAKE_CLEAN_SUPPORTED)
      return "clean";
   if(intake_state == ASC_SHORTLIST_EVID_INTAKE_STALE_RECOVERABLE)
      return "degraded";
   if(intake_state == ASC_SHORTLIST_EVID_INTAKE_DEP_BLOCKED)
      return "blocked";
   if(intake_state == ASC_SHORTLIST_EVID_INTAKE_UNAVAILABLE_RECOVERABLE || intake_state == ASC_SHORTLIST_EVID_INTAKE_INSUFFICIENT_NOW)
      return "limited";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "pending";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "blocked";
   return "limited";
  }

string ASC_ShortlistLayer3AuthorityAgeToken(const ASC_SelectionFilterEvaluation &filter,
                                            const bool has_linked_l3,
                                            const bool source_ready)
  {
   if(!has_linked_l3 || !source_ready)
      return "unknown";
   if(filter.freshness_is_current && !filter.continuity_backed)
      return "fresh";
   if(filter.continuity_backed)
      return "retained";

   string intake_state = ASC_ShortlistEvidenceIntakeText(filter.evidence_intake_state);
   if(intake_state == ASC_SHORTLIST_EVID_INTAKE_STALE_RECOVERABLE)
      return "stale";
   if(filter.quote_freshness_is_acceptable || filter.corroboration_packet_is_available)
      return "retained";
   return "unknown";
  }

string ASC_ShortlistRankReasonToken(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      return "fallback_priority";
   if(entry.overall_board_correlation_penalty > 0.0 || entry.overall_board_conflict_penalty > 0.0)
      return "diversification_support";
   if(entry.cleanliness_score >= entry.session_fit_for_style_score && entry.cleanliness_score >= 57.5)
      return "cleanliness";
   if(entry.session_fit_for_style_score >= 57.5)
      return "session_support";
   if(entry.shortlist_stability_bias > 0.0)
      return "stability_support";
   if(entry.filter.execution_alignment_score >= 57.5 || entry.filter.friction_quality_score >= 57.5 || entry.filter.liquidity_quality_score >= 57.5)
      return "friction_support";
   return "score_priority";
  }

string ASC_ShortlistCorrelationStatusToken(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.correlation_summary.peers_compared <= 0)
      return "not_applicable";
   if(entry.correlation_summary.summary_ready)
      return "complete";
   if(entry.correlation_summary.summary_posture == "pending")
      return "pending";
   if(entry.correlation_summary.summary_posture == "unavailable")
      return "unavailable";
   if(entry.correlation_summary.summary_posture == "limited")
      return "partial";
   return "unavailable";
  }

string ASC_ShortlistExposureStatusToken(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.overall_board_conflict_penalty > 0.0)
      return "conflict";
   if(entry.overall_board_posture == "pending")
      return "unknown";
   if(entry.overall_board_bucket_penalty > 0.0 || entry.overall_board_correlation_penalty > 0.0)
      return "limited";
   if(entry.shortlisted || entry.raw_rank > 0)
      return "clean";
   return "not_applicable";
  }

string ASC_ShortlistWhyNotHigherToken(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.rank == 1 || entry.bucket_rank == 1 || entry.sub_bucket_rank == 1)
      return "not_applicable";
   if(entry.l3_authority_source_token == "limited")
      return "limited_authority";
   if(entry.l3_authority_source_token == "degraded" || entry.l3_authority_age_token == "stale")
      return "stale_dependency";
   if(entry.l3_authority_source_token == "blocked" || entry.l3_authority_source_token == "pending")
      return "insufficient_authority";
   if(entry.overall_board_conflict_penalty > 0.0)
      return "exposure_conflict";
   if(entry.overall_board_correlation_penalty > 0.0)
      return "correlation_limit";
   if(entry.filter.execution_friction_penalty > 50.0 || entry.asset_execution_penalty > 0.0)
      return "friction_penalty";
   if(entry.session_fit_for_style_score < 50.0)
      return "session_penalty";
   return "lower_priority";
  }

string ASC_ShortlistExclusionReasonToken(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.shortlisted)
      return "not_excluded";
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "dependency_missing";
   if(entry.l3_authority_source_token == "blocked" || entry.l3_authority_source_token == "limited" || entry.l3_authority_source_token == "pending")
      return "insufficient_authority";
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
     {
      if(!entry.filter.market_state_is_open || !entry.filter.tradability_is_open)
         return "closed_or_unavailable";
      return "insufficient_authority";
     }
   if(entry.overall_board_conflict_penalty > 0.0)
      return "exposure_conflict";
   if(entry.overall_board_correlation_penalty > 0.0)
      return "correlation_limit";
   if(entry.overall_board_bucket_penalty > 0.0)
      return "diversification_limit";
   return "budget_limit";
  }

string ASC_ShortlistTopListAuthorityToken(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.l3_authority_source_token == "pending" || entry.correlation_status_token == "pending")
      return "pending";
   if(entry.l3_authority_source_token == "degraded" || entry.l3_authority_age_token == "stale")
      return "degraded";
   if(entry.l3_authority_source_token == "clean"
      && (entry.correlation_status_token == "complete" || entry.correlation_status_token == "not_applicable")
      && (entry.exposure_status_token == "clean" || entry.exposure_status_token == "not_applicable"))
      return "clean";
   return "limited";
  }

string ASC_ShortlistArtifactProjectionToken(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL && entry.l3_authority_source_token == "blocked")
      return "blocked";
   if(entry.top_list_authority_token == "clean")
      return "allowed";
   return "qualified";
  }

void ASC_ShortlistFinalizeTruthProofTokens(ASC_ShortlistSymbolSummary &entry)
  {
   entry.l4_meaning_token = "shortlist_priority_ordering_only";
   entry.trade_permission_token = "false";
   entry.entry_signal_token = "false";
   entry.behavior_change_token = "no";
   entry.l4_rank_reason_token = ASC_ShortlistRankReasonToken(entry);
   entry.correlation_status_token = ASC_ShortlistCorrelationStatusToken(entry);
   entry.exposure_status_token = ASC_ShortlistExposureStatusToken(entry);
   entry.why_not_higher_token = ASC_ShortlistWhyNotHigherToken(entry);
   entry.exclusion_reason_token = ASC_ShortlistExclusionReasonToken(entry);
   entry.top_list_authority_token = ASC_ShortlistTopListAuthorityToken(entry);
   entry.artifact_projection_token = ASC_ShortlistArtifactProjectionToken(entry);

   entry.l4_proof_tokens = "l4_meaning=" + entry.l4_meaning_token
                           + " | trade_permission=" + entry.trade_permission_token
                           + " | entry_signal=" + entry.entry_signal_token
                           + " | l3_authority_source=" + entry.l3_authority_source_token
                           + " | l3_authority_age=" + entry.l3_authority_age_token
                           + " | l4_rank_reason=" + entry.l4_rank_reason_token
                           + " | why_not_higher=" + entry.why_not_higher_token
                           + " | exclusion_reason=" + entry.exclusion_reason_token
                           + " | correlation_status=" + entry.correlation_status_token
                           + " | exposure_status=" + entry.exposure_status_token
                           + " | top_list_authority=" + entry.top_list_authority_token
                           + " | artifact_projection=" + entry.artifact_projection_token
                           + " | " + ASC_ShortlistAuthorityBoundaryProofToken(entry)
                           + " | " + ASC_ShortlistMetricProofToken(entry)
                           + " | atr_support={" + ASC_SummaryAtrMetricProofToken(entry.packet) + "}"
                           + " | behavior_change=" + entry.behavior_change_token;
  }

bool ASC_ShortlistContains(const string &symbols[],const string symbol)
  {
   for(int i = 0; i < ArraySize(symbols); i++)
     {
      if(symbols[i] == symbol)
         return true;
     }
   return false;
  }

bool ASC_ShortlistHasLawfulMembership(const ASC_ShortlistSymbolSummary &entry)
  {
   return (entry.shortlisted && entry.rank > 0);
  }

bool ASC_ShortlistHasLawfulBucketMembership(const ASC_ShortlistSymbolSummary &entry)
  {
   return (entry.bucket_shortlisted && entry.bucket_rank > 0);
  }

void ASC_ShortlistMarkMembershipInvalid(ASC_ShortlistSymbolSummary &entry)
  {
   entry.shortlisted = false;
   entry.rank = 0;
   entry.bucket_shortlisted = false;
   entry.bucket_rank = 0;
   entry.membership_state = "invalid";
   entry.shortlist_stability_posture = "invalid";
   entry.shortlist_band = "blocked";
   entry.shortlist_posture = "invalid";
   entry.overall_board_posture = "invalid";
   entry.overall_board_reason = "shortlist row matched the symbol but has no lawful rank; rebuild required before shortlist-owned truth can be trusted";
   entry.shortlist_reason = entry.overall_board_reason;
  }

int ASC_ShortlistMembershipDelta(const string &before_symbols[],const string &after_symbols[])
  {
   int delta = 0;
   for(int i = 0; i < ArraySize(before_symbols); i++)
     {
      if(!ASC_ShortlistContains(after_symbols, before_symbols[i]))
         delta++;
     }
   for(int i = 0; i < ArraySize(after_symbols); i++)
     {
      if(!ASC_ShortlistContains(before_symbols, after_symbols[i]))
         delta++;
     }
   return delta;
  }

int ASC_ShortlistCount(const ASC_ShortlistSymbolSummary &rows[])
  {
   int count = 0;
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(ASC_ShortlistHasLawfulMembership(rows[i]))
         count++;
     }
   return count;
  }

bool ASC_ShortlistFindCommittedLayer3State(const ASC_CommittedLayer3SymbolState &rows[],
                                           const string symbol,
                                           ASC_CommittedLayer3SymbolState &row_out)
  {
   if(StringLen(symbol) <= 0)
      return false;

   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(rows[i].symbol == symbol || rows[i].canonical_symbol == symbol)
        {
         row_out = rows[i];
         return true;
        }
     }
   return false;
  }

bool ASC_ShortlistSymbolIsLawful(const ASC_ShortlistSymbolSummary &rows[],const string symbol)
  {
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(!ASC_ShortlistSymbolMatchesContext(rows[i], symbol))
         continue;
      return (rows[i].filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS);
     }
   return false;
  }

bool ASC_ShortlistExistingMembershipInvalid(const string &existing_symbols[],
                                            const ASC_ShortlistSymbolSummary &rows[],
                                            string &invalid_symbol)
  {
   invalid_symbol = "";
   for(int i = 0; i < ArraySize(existing_symbols); i++)
     {
      if(!ASC_ShortlistSymbolIsLawful(rows, existing_symbols[i]))
        {
         invalid_symbol = existing_symbols[i];
         return true;
        }
     }
   return false;
  }

void ASC_ShortlistCommit(const string &symbols[],const datetime now_utc)
  {
   ArrayResize(g_asc_shortlist_symbols, ArraySize(symbols));
   for(int i = 0; i < ArraySize(symbols); i++)
      g_asc_shortlist_symbols[i] = symbols[i];
   g_asc_shortlist_last_rebuild_utc = now_utc;
   g_asc_shortlist_hold_until_utc = now_utc + ASC_SHORTLIST_HOLD_SECONDS;
  }

void ASC_ShortlistCopySymbols(const string &source[],string &target[])
  {
   ArrayResize(target, ArraySize(source));
   for(int i = 0; i < ArraySize(source); i++)
      target[i] = source[i];
  }

void ASC_ShortlistCopyWithoutSymbol(const string &source[],const string exclude_symbol,string &target[])
  {
   ArrayResize(target, 0);
   for(int i = 0; i < ArraySize(source); i++)
     {
      if(source[i] == exclude_symbol)
         continue;

      int next = ArraySize(target);
      ArrayResize(target, next + 1);
      target[next] = source[i];
     }
  }

int ASC_ShortlistIncumbentRank(const string symbol)
  {
   if(StringLen(symbol) <= 0)
      return 0;
   for(int i = 0; i < ArraySize(g_asc_shortlist_symbols); i++)
      if(g_asc_shortlist_symbols[i] == symbol)
         return (i + 1);
   return 0;
  }

bool ASC_ShortlistSymbolMatchesContext(const ASC_ShortlistSymbolSummary &entry,const string symbol)
  {
   if(StringLen(symbol) <= 0)
      return false;
   if(entry.symbol == symbol)
      return true;
   if(entry.state.symbol == symbol)
      return true;
   if(entry.state.identity.normalized_symbol == symbol)
      return true;
   if(entry.state.identity.canonical_symbol == symbol)
      return true;
   if(entry.state.classification.canonical_symbol == symbol)
      return true;
   return false;
  }

string ASC_ShortlistMembershipLabel(const ASC_ShortlistSymbolSummary &entry)
  {
   if(ASC_ShortlistHasLawfulMembership(entry))
     {
      if(entry.rank <= 3)
         return "Promoted";
      if(entry.rank <= 5)
         return "Shortlisted";
     }

   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "Scored Candidate";
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "Pending Context";
   if(entry.filter.eligibility_posture == "blocked")
      return "Blocked";
   if(entry.filter.eligibility_posture == "degraded")
      return "Degraded";
   if(entry.filter.eligibility_posture == "stale")
      return "Stale";
   return "Context Unavailable";
  }

string ASC_ShortlistSelectionBand(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.membership_state == "invalid")
      return "blocked";
   if(ASC_ShortlistHasLawfulMembership(entry))
     {
      if(entry.rank <= 3)
         return "promoted";
      return "shortlisted";
     }
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "reserve";
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "pending";
   return "blocked";
  }

double ASC_ShortlistRoundScore(const double value)
  {
   return (MathRound(value * 10.0) / 10.0);
  }

double ASC_ShortlistExecutionEfficiencyScore(const ASC_Layer1SymbolState &symbol_state,
                                             const ASC_Layer2Packet &packet,
                                             const bool has_packet)
  {
   if(!has_packet || !ASC_L2PacketHasLawfulSnapshot(packet))
      return 0.0;
   if(packet.bid <= 0.0 || packet.point <= 0.0)
      return 0.0;

   double spread_abs = packet.spread_points * packet.point;
   if(spread_abs < 0.0)
      return 0.0;

   double spread_pct = (spread_abs / packet.bid) * 100.0;
   double spread_cap = (symbol_state.classification.main_bucket_id == "crypto") ? 1.50 : 0.35;
   if(spread_cap <= 0.0)
      return 0.0;

   double spread_ratio = MathMax(0.0, MathMin(1.0, spread_pct / spread_cap));
   return 20.0 * (1.0 - spread_ratio);
  }

double ASC_ShortlistFreshnessPriorityScore(const ASC_Layer2Packet &packet,
                                           const bool has_packet)
  {
   if(!has_packet || !ASC_L2PacketHasLawfulSnapshot(packet))
      return 0.0;
   if(packet.freshness == ASC_L2_DEGRADED || packet.freshness == ASC_L2_STALE || packet.freshness == ASC_L2_CONTINUITY)
      return 0.0;
   if(!packet.valid_tick_time)
      return 0.0;

   double age_ratio = (double)packet.packet_age_sec / (double)MathMax(1, ASC_L2_STALE_AGE_SEC);
   age_ratio = MathMax(0.0, MathMin(1.0, age_ratio));
   return 20.0 * (1.0 - age_ratio);
  }

double ASC_ShortlistContextReadinessScore(const ASC_Layer2Packet &packet,
                                          const bool has_packet)
  {
   if(!has_packet || !ASC_L2PacketHasLawfulSnapshot(packet))
      return 0.0;

   double score = 0.0;
   if(ASC_SummaryAtrReady(packet))
      score += 4.0;
   if(ASC_SummarySpreadAtrReady(packet))
      score += 3.0;
   if(ASC_L2PacketHasLawfulDayRange(packet))
      score += 3.0;
   return score;
  }

double ASC_CandidateDisplayScore(const ASC_Layer1SymbolState &symbol_state,
                                 const ASC_Layer2Packet &packet,
                                 const ASC_SelectionFilterEvaluation &filter,
                                 const bool has_packet)
  {
   if(filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      return 0.0;

   // Layer-4 context score remains shortlist-priority context only.
   // The full composite ranking is built by the Layer-4 ranking spine below.
   double score = 50.0;
   score += ASC_ShortlistExecutionEfficiencyScore(symbol_state, packet, has_packet);
   score += ASC_ShortlistFreshnessPriorityScore(packet, has_packet);
   score += ASC_ShortlistContextReadinessScore(packet, has_packet);
   score = MathMax(0.0, MathMin(100.0, score));
   return ASC_ShortlistRoundScore(score);
  }

double ASC_ShortlistLayer3SpineScore(const ASC_SelectionFilterEvaluation &filter)
  {
   if(!filter.score_pack_ready)
      return ASC_ShortlistRoundScore(filter.score_net);

   double score = 0.55 * filter.score_net;
   score += 0.15 * filter.price_engine_score;
   score += 0.10 * filter.microstructure_score;
   score += 0.08 * filter.volatility_transition_score;
   score += 0.07 * filter.structure_context_score;
   score += 0.05 * filter.session_timing_score;
   score = MathMax(0.0, MathMin(100.0, score));
   return ASC_ShortlistRoundScore(score);
  }

double ASC_ShortlistStabilityBias(const string symbol,
                                  const ASC_SelectionFilterEvaluation &filter)
  {
   if(filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      return 0.0;

   int incumbent_rank = ASC_ShortlistIncumbentRank(symbol);
   if(incumbent_rank <= 0)
      return 0.0;

   double bias = 0.6;
   if(incumbent_rank <= 3)
      bias = 1.6;
   else if(incumbent_rank <= 5)
      bias = 1.1;

   if(filter.score_net < 35.0 || filter.execution_friction_penalty >= 65.0)
      bias *= 0.50;

   return ASC_ShortlistRoundScore(bias);
  }

int ASC_ShortlistFilterStatePriority(const ASC_SelectionFilterEvaluation &filter)
  {
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return 0;
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return 1;
   return 2;
  }

int ASC_ShortlistAttentionPriority(const string posture)
  {
   string normalized = posture;
   StringToLower(normalized);
   if(normalized == "high_attention")
      return 0;
   if(normalized == "monitor")
      return 1;
   if(normalized == "watch")
      return 2;
   if(normalized == "background")
      return 3;
   if(normalized == "low_attention")
      return 4;
   return 5;
  }

string ASC_ShortlistSignedScoreText(const double value)
  {
   if(value > 0.0)
      return "+" + DoubleToString(value, 1);
   if(value < 0.0)
      return DoubleToString(value, 1);
   return "0.0";
  }

string ASC_ShortlistTimingUsefulnessLabel(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.filter.entry_readiness_score >= 72.5 && entry.filter.late_move_risk_score <= 40.0 && entry.filter.exhaustion_risk_score <= 35.0)
      return "usable now";
   if(entry.filter.context_strength_score >= 65.0 && (entry.filter.late_move_risk_score >= 60.0 || entry.filter.exhaustion_risk_score >= 55.0))
      return "strong but late";
   if(entry.filter.entry_readiness_score >= 57.5)
      return "developing";
   if(entry.filter.context_strength_score >= 57.5)
      return "watch pullback";
   return "unclear";
  }

string ASC_ShortlistExecutionUsefulnessLabel(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.filter.execution_alignment_score >= 72.5
      && entry.filter.execution_friction_penalty <= 27.5
      && entry.filter.spread_stability_score >= 60.0
      && entry.filter.quote_stability_score >= 60.0)
      return "clean";
   if(entry.filter.execution_alignment_score >= 56.0
      && entry.filter.execution_friction_penalty <= 47.5
      && entry.filter.quote_stability_score >= 45.0)
      return "workable";
   if(entry.filter.execution_alignment_score >= 47.5)
      return "dragging";
   return "poor";
  }

string ASC_ShortlistRiskDragLabel(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.filter.risk_drag_score >= 72.5)
      return "heavy";
   if(entry.filter.risk_drag_score >= 57.5)
      return "elevated";
   if(entry.filter.risk_drag_score >= 42.5)
      return "contained";
   return "light";
  }

string ASC_ShortlistCleanlinessPosture(const double score)
  {
   if(score >= 75.0)
      return "clean";
   if(score >= 62.0)
      return "usable";
   if(score >= 48.0)
      return "guarded";
   return "messy";
  }

double ASC_ShortlistCleanlinessScore(const ASC_SelectionFilterEvaluation &filter)
  {
   double score = 0.40 * filter.execution_score
                  + 0.28 * filter.liquidity_proximity_score
                  + 0.17 * filter.friction_quality_score
                  + 0.15 * filter.spread_quality_score;
   score -= (filter.execution_friction_penalty * 0.18);
   return ASC_ShortlistRoundScore(MathMax(0.0, MathMin(100.0, score)));
  }

string ASC_ShortlistSessionFitPosture(const double score)
  {
   if(score >= 78.0)
      return "ideal_now";
   if(score >= 64.0)
      return "strong_now";
   if(score >= 50.0)
      return "workable_now";
   if(score > 0.0)
      return "low_priority_now";
   return "unavailable";
  }

double ASC_ShortlistSessionFitForStyleScore(const ASC_SelectionFilterEvaluation &filter)
  {
   if(!filter.session_timing_supported && !filter.move_age_supported)
      return 0.0;
   double score = 0.50 * filter.session_timing_score
                  + 0.30 * filter.timing_quality_score
                  + 0.20 * filter.move_age_score;
   return ASC_ShortlistRoundScore(MathMax(0.0, MathMin(100.0, score)));
  }

string ASC_ShortlistAssetExecutionPenaltyPosture(const double penalty)
  {
   if(penalty <= 1.0)
      return "none";
   if(penalty <= 3.0)
      return "low";
   if(penalty <= 6.0)
      return "moderate";
   return "high";
  }

double ASC_ShortlistAssetExecutionPenalty(const ASC_Layer1SymbolState &symbol_state,
                                          const ASC_SelectionFilterEvaluation &filter)
  {
   double penalty = 0.0;
   string bucket = ASC_ClassificationEffectiveMainBucketId(symbol_state.classification);
   if(bucket == "crypto")
      penalty += 2.2;
   else if(bucket == "indices")
      penalty += 1.0;
   else if(bucket == "stocks")
      penalty += 1.3;

   penalty += (filter.execution_friction_penalty * 0.04);
   penalty += (filter.spread_penalty_score * 0.03);
   penalty = MathMax(0.0, MathMin(10.0, penalty));
   return ASC_ShortlistRoundScore(penalty);
  }

double ASC_ShortlistCompositePriorityScore(const ASC_Layer1SymbolState &symbol_state,
                                           const ASC_Layer2Packet &packet,
                                           const ASC_SelectionFilterEvaluation &filter,
                                           const bool has_packet,
                                           const string symbol,
                                           double &l3_score_out,
                                           double &context_score_out,
                                           double &stability_bias_out)
  {
   l3_score_out = ASC_ShortlistLayer3SpineScore(filter);
   context_score_out = ASC_CandidateDisplayScore(symbol_state, packet, filter, has_packet);
   stability_bias_out = ASC_ShortlistStabilityBias(symbol, filter);
   double cleanliness_score = ASC_ShortlistCleanlinessScore(filter);
   double session_fit_score = ASC_ShortlistSessionFitForStyleScore(filter);
   double asset_penalty = ASC_ShortlistAssetExecutionPenalty(symbol_state, filter);

   double composite = (0.60 * l3_score_out) + (0.18 * context_score_out) + stability_bias_out;
   if(filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      composite = (0.70 * l3_score_out) + (0.30 * context_score_out);
   else
     {
      composite += (filter.context_strength_score - 50.0) * 0.09;
      composite += (filter.entry_readiness_score - 50.0) * 0.15;
      composite += (filter.execution_alignment_score - 50.0) * 0.09;
      composite += (filter.session_alignment_score - 50.0) * 0.05;
      composite -= (filter.risk_drag_score - 50.0) * 0.12;
      composite -= (filter.late_move_risk_score - 50.0) * 0.06;
      composite += (cleanliness_score - 50.0) * 0.06;
      composite += (session_fit_score - 50.0) * 0.03;
      composite -= asset_penalty * 0.45;
     }

   composite = MathMax(0.0, MathMin(100.0, composite));
   return ASC_ShortlistRoundScore(composite);
  }

double ASC_ShortlistSpreadPctForTieBreak(const ASC_ShortlistSymbolSummary &entry)
  {
   if(!entry.has_packet || !ASC_L2PacketHasLawfulSnapshot(entry.packet))
      return 9999.0;
   double spread_abs = entry.packet.spread_points * entry.packet.point;
   if(entry.packet.bid <= 0.0 || spread_abs < 0.0)
      return 9999.0;
   return ((spread_abs / entry.packet.bid) * 100.0);
  }

bool ASC_ShortlistRightOutranksLeft(const ASC_ShortlistSymbolSummary &left,
                                    const ASC_ShortlistSymbolSummary &right)
  {
   int left_priority = ASC_ShortlistFilterStatePriority(left.filter);
   int right_priority = ASC_ShortlistFilterStatePriority(right.filter);
   if(left_priority != right_priority)
      return (right_priority < left_priority);

   double score_delta = right.shortlist_score - left.shortlist_score;
   if(MathAbs(score_delta) > ASC_SHORTLIST_NEAR_TIE_DELTA)
      return (score_delta > 0.0);

   double left_execution_tie = ASC_ShortlistOverallExecutionTieScore(left);
   double right_execution_tie = ASC_ShortlistOverallExecutionTieScore(right);
   if(MathAbs(right_execution_tie - left_execution_tie) > 0.75)
      return (right_execution_tie > left_execution_tie);

   if(right.shortlist_l3_score != left.shortlist_l3_score)
      return (right.shortlist_l3_score > left.shortlist_l3_score);

   if(right.shortlist_context_score != left.shortlist_context_score)
      return (right.shortlist_context_score > left.shortlist_context_score);

   int left_attention = ASC_ShortlistAttentionPriority(left.shortlist_attention_posture);
   int right_attention = ASC_ShortlistAttentionPriority(right.shortlist_attention_posture);
   if(left_attention != right_attention)
      return (right_attention < left_attention);

   if(right.shortlist_stability_bias != left.shortlist_stability_bias)
      return (right.shortlist_stability_bias > left.shortlist_stability_bias);

   bool left_open = (left.state.state == ASC_L1_OPEN);
   bool right_open = (right.state.state == ASC_L1_OPEN);
   if(left_open != right_open)
      return right_open;

   bool left_fresh_quote = (left.has_packet && left.filter.quote_freshness_is_acceptable);
   bool right_fresh_quote = (right.has_packet && right.filter.quote_freshness_is_acceptable);
   if(left_fresh_quote != right_fresh_quote)
      return right_fresh_quote;

   double left_spread_pct = ASC_ShortlistSpreadPctForTieBreak(left);
   double right_spread_pct = ASC_ShortlistSpreadPctForTieBreak(right);
   if(left_spread_pct != right_spread_pct)
      return (right_spread_pct < left_spread_pct);

   int left_tick_age = (left.has_packet && left.packet.valid_tick_time ? left.packet.packet_age_sec : 2147483647);
   int right_tick_age = (right.has_packet && right.packet.valid_tick_time ? right.packet.packet_age_sec : 2147483647);
   if(left_tick_age != right_tick_age)
      return (right_tick_age < left_tick_age);

   return (StringCompare(right.symbol, left.symbol) < 0);
  }

bool ASC_ShortlistTryGetPacketForState(const ASC_Layer1SymbolState &symbol_state,ASC_Layer2Packet &packet_out)
  {
   if(ASC_Layer2TryGetPacketBySymbol(symbol_state.symbol, packet_out))
      return true;
   if(StringLen(symbol_state.identity.normalized_symbol) > 0
      && ASC_Layer2TryGetPacketBySymbol(symbol_state.identity.normalized_symbol, packet_out))
      return true;
   if(StringLen(symbol_state.classification.canonical_symbol) > 0
      && ASC_Layer2TryGetPacketBySymbol(symbol_state.classification.canonical_symbol, packet_out))
      return true;
   if(StringLen(symbol_state.identity.canonical_symbol) > 0
      && ASC_Layer2TryGetPacketBySymbol(symbol_state.identity.canonical_symbol, packet_out))
      return true;
   return false;
  }

bool ASC_ShortlistTryGetLayer1StateBySymbol(const string symbol,ASC_Layer1SymbolState &state_out)
  {
   if(StringLen(symbol) <= 0)
      return false;

   int total = ASC_Layer1CachedSymbolCount();
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState candidate;
      if(!ASC_Layer1GetCachedSymbol(i, candidate))
         continue;
      if(candidate.symbol == symbol)
        {
         state_out = candidate;
         return true;
        }
     }
   return false;
  }

bool ASC_ShortlistTryGetRowBySymbol(const ASC_ShortlistSymbolSummary &rows[],
                                    const string symbol,
                                    ASC_ShortlistSymbolSummary &row_out)
  {
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(!ASC_ShortlistSymbolMatchesContext(rows[i], symbol))
         continue;
      row_out = rows[i];
      return true;
     }
   return false;
  }

int ASC_ShortlistSymbolRankInSet(const string &symbols[],const string symbol)
  {
   for(int i = 0; i < ArraySize(symbols); i++)
     {
      if(symbols[i] == symbol)
         return (i + 1);
     }
   return 0;
  }

double ASC_ShortlistOverallExecutionTieScore(const ASC_ShortlistSymbolSummary &entry)
  {
   double score = 0.0;
   score += entry.filter.execution_alignment_score * 0.42;
   score += entry.cleanliness_score * 0.28;
   score += entry.filter.entry_readiness_score * 0.16;
   score += entry.filter.quote_stability_score * 0.14;
   score -= entry.asset_execution_penalty * 1.20;
   return ASC_ShortlistRoundScore(MathMax(0.0, MathMin(100.0, score)));
  }

double ASC_ShortlistOverallQualityAdjustment(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      return 0.0;

   double sum = 0.0;
   int count = 0;
   ASC_SelectionFilterIncludeScore(entry.filter.participation_score, sum, count);
   ASC_SelectionFilterIncludeScore(entry.filter.execution_score, sum, count);
   ASC_SelectionFilterIncludeScore(entry.filter.execution_alignment_score, sum, count);
   ASC_SelectionFilterIncludeScore(entry.filter.liquidity_proximity_score, sum, count);
   ASC_SelectionFilterIncludeScore(entry.cleanliness_score, sum, count);
   ASC_SelectionFilterIncludeScore(entry.session_fit_for_style_score, sum, count);
   ASC_SelectionFilterIncludeScore(entry.filter.entry_readiness_score, sum, count);
   ASC_SelectionFilterIncludeScore(entry.filter.pressure_shift_score, sum, count);
   ASC_SelectionFilterIncludeScore(entry.filter.momentum_acceleration_score, sum, count);

   if(count <= 0)
      return 0.0;

   double average = sum / count;
   double adjustment = (average - 50.0) * 0.08;
   adjustment += (entry.filter.execution_alignment_score - 50.0) * 0.05;
   adjustment += (entry.cleanliness_score - 50.0) * 0.05;
   adjustment += (entry.filter.entry_readiness_score - 50.0) * 0.03;
   adjustment += (entry.style_fit_score - 50.0) * 0.03;
   adjustment += (entry.deep_request_priority_score - 50.0) * 0.01;
   adjustment -= entry.asset_execution_penalty * 0.32;

   if(entry.filter.execution_friction_penalty > 45.0)
      adjustment -= (entry.filter.execution_friction_penalty - 45.0) * 0.05;
   if(entry.filter.spread_penalty_score > 40.0)
      adjustment -= (entry.filter.spread_penalty_score - 40.0) * 0.035;
   if(entry.filter.quote_stability_score < 50.0)
      adjustment -= (50.0 - entry.filter.quote_stability_score) * 0.04;

   if(entry.filter.execution_alignment_score >= 72.5
      && entry.cleanliness_score >= 72.5
      && entry.filter.execution_friction_penalty <= 30.0)
      adjustment += 1.25;
   else if(entry.filter.execution_alignment_score < 52.5
           && entry.filter.execution_friction_penalty >= 50.0)
      adjustment -= 1.25;

   adjustment = MathMax(-8.0, MathMin(6.0, adjustment));
   return ASC_ShortlistRoundScore(adjustment);
  }

int ASC_ShortlistSelectedBucketCount(const ASC_ShortlistSymbolSummary &rows[],
                                     const string &selected_symbols[],
                                     const string bucket_id,
                                     const string exclude_symbol = "")
  {
   if(StringLen(bucket_id) <= 0)
      return 0;

   int count = 0;
   for(int i = 0; i < ArraySize(selected_symbols); i++)
     {
      if(StringLen(exclude_symbol) > 0 && selected_symbols[i] == exclude_symbol)
         continue;

      ASC_ShortlistSymbolSummary selected_row;
      if(!ASC_ShortlistTryGetRowBySymbol(rows, selected_symbols[i], selected_row))
         continue;

      string selected_bucket = ASC_ClassificationEffectiveMainBucketId(selected_row.state.classification);
      if(StringLen(selected_bucket) <= 0)
         selected_bucket = "unknown";
      if(selected_bucket == bucket_id)
         count++;
     }
   return count;
  }

double ASC_ShortlistOverallBucketPenalty(const int bucket_count)
  {
   if(bucket_count <= 0)
      return 0.0;
   if(bucket_count == 1)
      return 3.0;
   if(bucket_count == 2)
      return 7.0;
   return (12.0 + ((double)(bucket_count - 3) * 4.0));
  }

int ASC_ShortlistSelectedSubBucketCount(const ASC_ShortlistSymbolSummary &rows[],
                                        const string &selected_symbols[],
                                        const string bucket_id,
                                        const string sub_bucket_id,
                                        const string exclude_symbol = "")
  {
   if(StringLen(bucket_id) <= 0 || StringLen(sub_bucket_id) <= 0)
      return 0;

   int count = 0;
   for(int i = 0; i < ArraySize(selected_symbols); i++)
     {
      if(StringLen(exclude_symbol) > 0 && selected_symbols[i] == exclude_symbol)
         continue;

      ASC_ShortlistSymbolSummary selected_row;
      if(!ASC_ShortlistTryGetRowBySymbol(rows, selected_symbols[i], selected_row))
         continue;

      string selected_bucket = ASC_ClassificationEffectiveMainBucketId(selected_row.state.classification);
      if(StringLen(selected_bucket) <= 0)
         selected_bucket = "unknown";
      if(selected_bucket != bucket_id)
         continue;

      string selected_sub_bucket = ASC_ClassificationEffectiveSubBucketId(selected_row.state.classification);
      if(StringLen(selected_sub_bucket) <= 0)
         selected_sub_bucket = ASC_ClassificationFallbackSubBucketId(selected_bucket);
      if(StringLen(selected_sub_bucket) <= 0)
         continue;

      if(selected_sub_bucket == sub_bucket_id)
         count++;
     }
   return count;
  }

double ASC_ShortlistOverallSubBucketPenalty(const int sub_bucket_count)
  {
   if(sub_bucket_count <= 0)
      return 0.0;
   if(sub_bucket_count == 1)
      return 2.5;
   if(sub_bucket_count == 2)
      return 5.5;
   return (9.0 + ((double)(sub_bucket_count - 3) * 2.5));
  }

double ASC_ShortlistOverallConflictPenalty(const int open_positions,const int pending_orders)
  {
   int total = open_positions + pending_orders;
   if(total <= 0)
      return 0.0;
   if(total == 1)
      return 4.0;
   if(total == 2)
      return 8.0;
   return 12.0;
  }

void ASC_ShortlistOverallCorrelationPressure(const ASC_ShortlistSymbolSummary &entry,
                                             const ASC_ShortlistSymbolSummary &rows[],
                                             const string &selected_symbols[],
                                             const string exclude_symbol,
                                             double &max_corr_out,
                                             double &avg_corr_out,
                                             int &crowded_peers_out,
                                             string &peer_symbol_out,
                                             double &peer_corr_out)
  {
   max_corr_out = 0.0;
   avg_corr_out = 0.0;
   crowded_peers_out = 0;
   peer_symbol_out = "n/a";
   peer_corr_out = 0.0;

   int compared = 0;
   for(int i = 0; i < ArraySize(selected_symbols); i++)
     {
      string peer_symbol = selected_symbols[i];
      if(StringLen(peer_symbol) <= 0)
         continue;
      if(peer_symbol == exclude_symbol || peer_symbol == entry.symbol)
         continue;

      ASC_ShortlistSymbolSummary peer_row;
      if(!ASC_ShortlistTryGetRowBySymbol(rows, peer_symbol, peer_row))
         continue;

      double corr = 0.0;
      int corr_samples = 0;
      string corr_reason = "";
      bool corr_ready = ASC_TrySummaryTrueCorrelationScore(entry.symbol,
                                                           peer_row.symbol,
                                                           corr,
                                                           corr_samples,
                                                           corr_reason);
      if(!corr_ready)
         continue;

      avg_corr_out += corr;
      compared++;

      if(corr >= ASC_SHORTLIST_OVERALL_CORRELATION_WATCH)
         crowded_peers_out++;

      if(corr > max_corr_out)
        {
         max_corr_out = corr;
         peer_symbol_out = peer_row.symbol;
         peer_corr_out = corr;
        }
     }

   if(compared > 0)
      avg_corr_out = avg_corr_out / compared;
  }

double ASC_ShortlistOverallCorrelationPenalty(const double max_corr,
                                              const double avg_corr,
                                              const int crowded_peers)
  {
   double penalty = 0.0;
   if(max_corr > 0.40)
      penalty += (max_corr - 0.40) * 36.0;
   if(avg_corr > 0.30)
      penalty += (avg_corr - 0.30) * 18.0;
   if(crowded_peers > 0)
      penalty += (double)crowded_peers * 4.0;
   if(max_corr >= ASC_SHORTLIST_OVERALL_CORRELATION_CROWD)
      penalty += 5.0;

   penalty = MathMax(0.0, MathMin(32.0, penalty));
   return ASC_ShortlistRoundScore(penalty);
  }

bool ASC_ShortlistOverallLowCorrelationCandidate(const double peer_corr,
                                                 const int cluster_count)
  {
   return (peer_corr < ASC_SHORTLIST_OVERALL_CORRELATION_WATCH && cluster_count <= 0);
  }

bool ASC_ShortlistOverallWatchlistSafeCandidate(const double peer_corr,
                                                const int cluster_count)
  {
   return (peer_corr < ASC_SHORTLIST_OVERALL_CORRELATION_CROWD && cluster_count < 2);
  }

double ASC_ShortlistOverallAdmissionScore(const ASC_ShortlistSymbolSummary &entry,
                                          const ASC_ShortlistSymbolSummary &rows[],
                                          const string &selected_symbols[],
                                          const string exclude_symbol,
                                          double &quality_adjust_out,
                                          double &correlation_penalty_out,
                                          double &bucket_penalty_out,
                                          double &conflict_penalty_out,
                                          string &peer_symbol_out,
                                          double &peer_corr_out,
                                          int &cluster_count_out)
  {
   quality_adjust_out = 0.0;
   correlation_penalty_out = 0.0;
   bucket_penalty_out = 0.0;
   conflict_penalty_out = 0.0;
   peer_symbol_out = "n/a";
   peer_corr_out = 0.0;
   cluster_count_out = 0;

   if(entry.filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      return 0.0;

   quality_adjust_out = ASC_ShortlistOverallQualityAdjustment(entry);

   double max_corr = 0.0;
   double avg_corr = 0.0;
   ASC_ShortlistOverallCorrelationPressure(entry,
                                           rows,
                                           selected_symbols,
                                           exclude_symbol,
                                           max_corr,
                                           avg_corr,
                                           cluster_count_out,
                                           peer_symbol_out,
                                           peer_corr_out);
   correlation_penalty_out = ASC_ShortlistOverallCorrelationPenalty(max_corr,
                                                                    avg_corr,
                                                                    cluster_count_out);

   string bucket_id = ASC_ClassificationEffectiveMainBucketId(entry.state.classification);
   if(StringLen(bucket_id) <= 0)
      bucket_id = "unknown";
   string sub_bucket_id = ASC_ClassificationEffectiveSubBucketId(entry.state.classification);
   if(StringLen(sub_bucket_id) <= 0)
      sub_bucket_id = ASC_ClassificationFallbackSubBucketId(bucket_id);

   int bucket_count = ASC_ShortlistSelectedBucketCount(rows,
                                                       selected_symbols,
                                                       bucket_id,
                                                       exclude_symbol);
   int sub_bucket_count = ASC_ShortlistSelectedSubBucketCount(rows,
                                                              selected_symbols,
                                                              bucket_id,
                                                              sub_bucket_id,
                                                              exclude_symbol);
   bucket_penalty_out = ASC_ShortlistRoundScore(ASC_ShortlistOverallBucketPenalty(bucket_count)
                                                + ASC_ShortlistOverallSubBucketPenalty(sub_bucket_count));

   int open_positions = 0;
   int pending_orders = 0;
   ASC_OpenPendingConflictValue(entry.symbol, open_positions, pending_orders);
   conflict_penalty_out = ASC_ShortlistRoundScore(ASC_ShortlistOverallConflictPenalty(open_positions, pending_orders));

   double score = entry.shortlist_score
                  + quality_adjust_out
                  - correlation_penalty_out
                  - bucket_penalty_out
                  - conflict_penalty_out;
   score = MathMax(0.0, MathMin(100.0, score));
   return ASC_ShortlistRoundScore(score);
  }

void ASC_ShortlistBuildDiversifiedOverallSymbols(const ASC_ShortlistSymbolSummary &rows[],
                                                 const int limit,
                                                 string &selected_symbols[])
  {
   ArrayResize(selected_symbols, 0);
   int capped = MathMax(0, limit);

   while(ArraySize(selected_symbols) < capped)
     {
      int best_clean_index = -1;
      double best_clean_score = -1.0;
      int best_watch_safe_index = -1;
      double best_watch_safe_score = -1.0;
      int best_fallback_index = -1;
      double best_fallback_score = -1.0;

      for(int i = 0; i < ArraySize(rows); i++)
        {
         if(rows[i].filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
            continue;
         if(ASC_ShortlistContains(selected_symbols, rows[i].symbol))
            continue;

         double quality_adjust = 0.0;
         double corr_penalty = 0.0;
         double bucket_penalty = 0.0;
         double conflict_penalty = 0.0;
         string peer_symbol = "n/a";
         double peer_corr = 0.0;
         int cluster_count = 0;
         double admission_score = ASC_ShortlistOverallAdmissionScore(rows[i],
                                                                     rows,
                                                                     selected_symbols,
                                                                     "",
                                                                     quality_adjust,
                                                                     corr_penalty,
                                                                     bucket_penalty,
                                                                     conflict_penalty,
                                                                     peer_symbol,
                                                                     peer_corr,
                                                                     cluster_count);

         if(best_fallback_index < 0
            || admission_score > best_fallback_score
            || (MathAbs(admission_score - best_fallback_score) <= 0.05
                && ASC_ShortlistRightOutranksLeft(rows[best_fallback_index], rows[i])))
           {
            best_fallback_index = i;
            best_fallback_score = admission_score;
           }

         bool low_correlation_candidate = ASC_ShortlistOverallLowCorrelationCandidate(peer_corr, cluster_count);
         bool watch_safe_candidate = ASC_ShortlistOverallWatchlistSafeCandidate(peer_corr, cluster_count);

         if(low_correlation_candidate)
           {
            if(best_clean_index < 0
               || admission_score > best_clean_score
               || (MathAbs(admission_score - best_clean_score) <= 0.05
                   && ASC_ShortlistRightOutranksLeft(rows[best_clean_index], rows[i])))
              {
               best_clean_index = i;
               best_clean_score = admission_score;
              }
            continue;
           }

         if(watch_safe_candidate)
           {
            if(best_watch_safe_index < 0
               || admission_score > best_watch_safe_score
               || (MathAbs(admission_score - best_watch_safe_score) <= 0.05
                   && ASC_ShortlistRightOutranksLeft(rows[best_watch_safe_index], rows[i])))
              {
               best_watch_safe_index = i;
               best_watch_safe_score = admission_score;
              }
           }
        }

      int best_index = (best_clean_index >= 0)
                       ? best_clean_index
                       : ((best_watch_safe_index >= 0) ? best_watch_safe_index : best_fallback_index);
      if(best_index < 0)
         break;

      int next = ArraySize(selected_symbols);
      ArrayResize(selected_symbols, next + 1);
      selected_symbols[next] = rows[best_index].symbol;
     }
  }

void ASC_ShortlistApplyOverallBoardContext(ASC_ShortlistSymbolSummary &rows[],
                                           const string &active_symbols[])
  {
   int overall_total = ArraySize(active_symbols);
   double best_overall = -1.0;
   double pass_sum = 0.0;
   int pass_count = 0;

   for(int i = 0; i < ArraySize(rows); i++)
     {
      rows[i].overall_board_score = 0.0;
      rows[i].overall_board_quality_adjustment = 0.0;
      rows[i].overall_board_correlation_penalty = 0.0;
      rows[i].overall_board_bucket_penalty = 0.0;
      rows[i].overall_board_conflict_penalty = 0.0;
      rows[i].relative_field_rank_score = 0.0;
      rows[i].relative_opportunity_percentile = 0.0;
      rows[i].leader_separation_score = 0.0;
      rows[i].top10_compression_score = 0.0;
      rows[i].field_opportunity_regime = "unavailable";
      rows[i].overall_board_peer_symbol = "n/a";
      rows[i].overall_board_peer_correlation = 0.0;
      rows[i].overall_board_cluster_count = 0;
      rows[i].overall_board_posture = "unavailable";
      rows[i].overall_board_reason = "overall board context unavailable";

      if(rows[i].filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
         continue;

      string exclude_symbol = rows[i].shortlisted ? rows[i].symbol : "";
      double quality_adjust = 0.0;
      double corr_penalty = 0.0;
      double bucket_penalty = 0.0;
      double conflict_penalty = 0.0;
      string peer_symbol = "n/a";
      double peer_corr = 0.0;
      int cluster_count = 0;
      double board_score = ASC_ShortlistOverallAdmissionScore(rows[i],
                                                              rows,
                                                              active_symbols,
                                                              exclude_symbol,
                                                              quality_adjust,
                                                              corr_penalty,
                                                              bucket_penalty,
                                                              conflict_penalty,
                                                              peer_symbol,
                                                              peer_corr,
                                                              cluster_count);

      rows[i].overall_board_score = board_score;
      if(board_score > best_overall)
         best_overall = board_score;
      pass_sum += board_score;
      pass_count++;
      rows[i].overall_board_quality_adjustment = quality_adjust;
      rows[i].overall_board_correlation_penalty = corr_penalty;
      rows[i].overall_board_bucket_penalty = bucket_penalty;
      rows[i].overall_board_conflict_penalty = conflict_penalty;
      rows[i].overall_board_peer_symbol = peer_symbol;
      rows[i].overall_board_peer_correlation = peer_corr;
      rows[i].overall_board_cluster_count = cluster_count;

      string correlation_clause = ASC_ShortlistOrdinaryCorrelationClause(peer_symbol,
                                                                          peer_corr,
                                                                          cluster_count);

      if(rows[i].shortlisted)
        {
         rows[i].overall_board_posture = "selected";
         rows[i].overall_board_reason = StringFormat("diversified overall board rank #%d/%d | raw rank #%d | board %.1f | %s | diversification pressure %.1f | exposure load %.1f | status %s",
                                                     rows[i].rank,
                                                     overall_total,
                                                     rows[i].raw_rank,
                                                     rows[i].overall_board_score,
                                                     correlation_clause,
                                                     rows[i].overall_board_bucket_penalty,
                                                     rows[i].overall_board_conflict_penalty,
                                                     (rows[i].rank <= 3 ? "promoted overall" : "shortlisted overall"));
        }
      else if(rows[i].bucket_shortlisted)
        {
         rows[i].overall_board_posture = "bucket-top5-only";
         rows[i].overall_board_reason = StringFormat("bucket top-5 strength confirmed | reserve outside diversified overall board | bucket rank #%d | raw rank #%d | board %.1f | %s | diversification pressure %.1f | exposure load %.1f",
                                                     rows[i].bucket_rank,
                                                     rows[i].raw_rank,
                                                     rows[i].overall_board_score,
                                                     correlation_clause,
                                                     rows[i].overall_board_bucket_penalty,
                                                     rows[i].overall_board_conflict_penalty);
        }
      else
        {
         rows[i].overall_board_posture = "reserve";
         rows[i].overall_board_reason = StringFormat("reserve only | outside diversified overall board and bucket top-5 | raw rank #%d | board %.1f | %s | diversification pressure %.1f | exposure load %.1f",
                                                     rows[i].raw_rank,
                                                     rows[i].overall_board_score,
                                                     correlation_clause,
                                                     rows[i].overall_board_bucket_penalty,
                                                     rows[i].overall_board_conflict_penalty);
        }
     }

   double pass_avg = (pass_count > 0) ? (pass_sum / pass_count) : 0.0;
   double top_score = -1.0;
   double tenth_score = -1.0;
   int pass_seen = 0;
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(rows[i].filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
         continue;
      pass_seen++;
      if(pass_seen == 1)
         top_score = rows[i].overall_board_score;
      if(pass_seen == 10)
        {
         tenth_score = rows[i].overall_board_score;
         break;
        }
     }
   if(tenth_score < 0.0)
      tenth_score = pass_avg;
   double leader_gap = MathMax(0.0, top_score - pass_avg);
   double top10_compression = MathMax(0.0, 100.0 - MathMin(100.0, MathMax(0.0, top_score - tenth_score) * 5.0));
   string field_regime = "thin_day_best_available";
   if(pass_avg >= 76.0 && top10_compression <= 45.0)
      field_regime = "rare_clean_day";
   else if(pass_avg >= 67.5)
      field_regime = "strong_day";
   else if(pass_avg >= 56.0)
      field_regime = "workable_day";

   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(rows[i].filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
         continue;

      double relative_pct = 0.0;
      if(best_overall > 0.0)
         relative_pct = MathMax(0.0, MathMin(100.0, (rows[i].overall_board_score / best_overall) * 100.0));
      rows[i].relative_opportunity_percentile = ASC_ShortlistRoundScore(relative_pct);
      rows[i].relative_field_rank_score = ASC_ShortlistRoundScore((rows[i].overall_board_score * 0.60)
                                                                   + (rows[i].relative_opportunity_percentile * 0.40));
      rows[i].leader_separation_score = ASC_ShortlistRoundScore(MathMin(100.0, leader_gap * 5.0));
      rows[i].top10_compression_score = ASC_ShortlistRoundScore(top10_compression);
      rows[i].field_opportunity_regime = field_regime;
      rows[i].overall_board_reason += StringFormat(" | field %s | relative %.1f | rank blend %.1f | leader separation %.1f | top-10 compression %.1f",
                                                   ASC_ShortlistFieldRegimeOperatorText(rows[i].field_opportunity_regime),
                                                   rows[i].relative_opportunity_percentile,
                                                   rows[i].relative_field_rank_score,
                                                   rows[i].leader_separation_score,
                                                   rows[i].top10_compression_score);
     }
  }

double ASC_ShortlistTopScoreShift(const ASC_ShortlistSymbolSummary &rows[],
                                  const string current_top_symbol,
                                  const string proposed_top_symbol)
  {
   ASC_ShortlistSymbolSummary current_top;
   ASC_ShortlistSymbolSummary proposed_top;
   bool has_current_top = ASC_ShortlistTryGetRowBySymbol(rows, current_top_symbol, current_top);
   bool has_proposed_top = ASC_ShortlistTryGetRowBySymbol(rows, proposed_top_symbol, proposed_top);
   if(!has_current_top || !has_proposed_top)
      return 0.0;
   return (proposed_top.shortlist_score - current_top.shortlist_score);
  }

double ASC_ShortlistChallengeStrength(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      return 0.0;

   double score = 0.62 * entry.shortlist_score;
   score += 0.23 * ASC_ShortlistOverallExecutionTieScore(entry);
   score += 0.10 * entry.shortlist_context_score;
   score += 0.05 * entry.shortlist_l3_score;
   score -= entry.shortlist_stability_bias * 0.20;
   score = MathMax(0.0, MathMin(100.0, score));
   return ASC_ShortlistRoundScore(score);
  }

bool ASC_ShortlistFindReplacementPair(const string &existing_symbols[],
                                      const string &proposed_symbols[],
                                      string &removed_symbol_out,
                                      string &added_symbol_out)
  {
   removed_symbol_out = "";
   added_symbol_out = "";

   for(int i = 0; i < ArraySize(existing_symbols); i++)
     {
      if(ASC_ShortlistContains(proposed_symbols, existing_symbols[i]))
         continue;
      removed_symbol_out = existing_symbols[i];
      break;
     }

   for(int i = 0; i < ArraySize(proposed_symbols); i++)
     {
      if(ASC_ShortlistContains(existing_symbols, proposed_symbols[i]))
         continue;
      added_symbol_out = proposed_symbols[i];
      break;
     }

   return (StringLen(removed_symbol_out) > 0 && StringLen(added_symbol_out) > 0);
  }

bool ASC_ShortlistReplacementClearsStabilityGate(const ASC_ShortlistSymbolSummary &rows[],
                                                 const string &existing_symbols[],
                                                 const string &proposed_symbols[],
                                                 string &reason_out)
  {
   reason_out = "";

   string removed_symbol = "";
   string added_symbol = "";
   if(!ASC_ShortlistFindReplacementPair(existing_symbols, proposed_symbols, removed_symbol, added_symbol))
     {
      reason_out = "replacement pair unresolved";
      return true;
     }

   ASC_ShortlistSymbolSummary removed_row;
   ASC_ShortlistSymbolSummary added_row;
   bool has_removed = ASC_ShortlistTryGetRowBySymbol(rows, removed_symbol, removed_row);
   bool has_added = ASC_ShortlistTryGetRowBySymbol(rows, added_symbol, added_row);
   if(!has_removed || !has_added)
     {
      reason_out = "replacement row unavailable";
      return true;
     }

   if(removed_row.filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
     {
      reason_out = "incumbent no longer lawful";
      return true;
     }

   double added_strength = ASC_ShortlistChallengeStrength(added_row);
   double removed_strength = ASC_ShortlistChallengeStrength(removed_row);
   double delta = added_strength - removed_strength;
   if(delta >= ASC_SHORTLIST_REPLACEMENT_CHALLENGE_MARGIN)
     {
      reason_out = StringFormat("replacement cleared stability gate %.1f >= %.1f",
                                delta,
                                ASC_SHORTLIST_REPLACEMENT_CHALLENGE_MARGIN);
      return true;
     }

   string incumbent_survivors[];
   ASC_ShortlistCopyWithoutSymbol(existing_symbols, removed_symbol, incumbent_survivors);

   double added_quality_adjust = 0.0;
   double added_corr_penalty = 0.0;
   double added_bucket_penalty = 0.0;
   double added_conflict_penalty = 0.0;
   string added_peer_symbol = "n/a";
   double added_peer_corr = 0.0;
   int added_cluster_count = 0;
   double added_board_score = ASC_ShortlistOverallAdmissionScore(added_row,
                                                                 rows,
                                                                 incumbent_survivors,
                                                                 "",
                                                                 added_quality_adjust,
                                                                 added_corr_penalty,
                                                                 added_bucket_penalty,
                                                                 added_conflict_penalty,
                                                                 added_peer_symbol,
                                                                 added_peer_corr,
                                                                 added_cluster_count);

   double removed_quality_adjust = 0.0;
   double removed_corr_penalty = 0.0;
   double removed_bucket_penalty = 0.0;
   double removed_conflict_penalty = 0.0;
   string removed_peer_symbol = "n/a";
   double removed_peer_corr = 0.0;
   int removed_cluster_count = 0;
   double removed_board_score = ASC_ShortlistOverallAdmissionScore(removed_row,
                                                                   rows,
                                                                   incumbent_survivors,
                                                                   "",
                                                                   removed_quality_adjust,
                                                                   removed_corr_penalty,
                                                                   removed_bucket_penalty,
                                                                   removed_conflict_penalty,
                                                                   removed_peer_symbol,
                                                                   removed_peer_corr,
                                                                   removed_cluster_count);

   double removed_pressure = removed_corr_penalty + removed_bucket_penalty;
   double added_pressure = added_corr_penalty + added_bucket_penalty;
   double pressure_relief = removed_pressure - added_pressure;
   double board_delta = added_board_score - removed_board_score;

   if(pressure_relief >= ASC_SHORTLIST_REPLACEMENT_RELIEF_PENALTY_DELTA
      && board_delta >= ASC_SHORTLIST_REPLACEMENT_RELIEF_BOARD_ADVANTAGE)
     {
      reason_out = StringFormat("replacement cleared diversification-relief gate board %.1f >= %.1f with pressure relief %.1f >= %.1f (%s over %s)",
                                board_delta,
                                ASC_SHORTLIST_REPLACEMENT_RELIEF_BOARD_ADVANTAGE,
                                pressure_relief,
                                ASC_SHORTLIST_REPLACEMENT_RELIEF_PENALTY_DELTA,
                                added_symbol,
                                removed_symbol);
      return true;
     }

   double execution_relief = (added_row.filter.execution_alignment_score - removed_row.filter.execution_alignment_score)
                             + ((added_row.cleanliness_score - removed_row.cleanliness_score) * 0.50)
                             + ((removed_row.asset_execution_penalty - added_row.asset_execution_penalty) * 0.75);
   double execution_friction_improvement = (removed_row.filter.execution_friction_penalty - added_row.filter.execution_friction_penalty);
   bool execution_liquidity_ready = (added_row.filter.liquidity_quality_score >= ASC_SHORTLIST_REPLACEMENT_MIN_LIQUIDITY_QUALITY);
   if(execution_relief >= ASC_SHORTLIST_REPLACEMENT_EXECUTION_RELIEF_DELTA
      && board_delta >= ASC_SHORTLIST_REPLACEMENT_EXECUTION_RELIEF_BOARD_ADVANTAGE
      && pressure_relief >= 0.0
      && execution_friction_improvement >= ASC_SHORTLIST_REPLACEMENT_EXECUTION_FRICTION_IMPROVEMENT_MIN
      && execution_liquidity_ready)
     {
      reason_out = StringFormat("replacement cleared execution-relief gate board %.1f >= %.1f with execution relief %.1f >= %.1f, friction improvement %.1f >= %.1f, liquidity %.1f >= %.1f, and non-worse pressure %.1f (%s over %s)",
                                board_delta,
                                ASC_SHORTLIST_REPLACEMENT_EXECUTION_RELIEF_BOARD_ADVANTAGE,
                                execution_relief,
                                ASC_SHORTLIST_REPLACEMENT_EXECUTION_RELIEF_DELTA,
                                execution_friction_improvement,
                                ASC_SHORTLIST_REPLACEMENT_EXECUTION_FRICTION_IMPROVEMENT_MIN,
                                added_row.filter.liquidity_quality_score,
                                ASC_SHORTLIST_REPLACEMENT_MIN_LIQUIDITY_QUALITY,
                                pressure_relief,
                                added_symbol,
                                removed_symbol);
      return true;
     }

   reason_out = StringFormat("replacement deferred by stability gate %.1f < %.1f, diversification-relief gate board %.1f < %.1f or pressure relief %.1f < %.1f, and execution-relief gate board %.1f < %.1f or execution relief %.1f < %.1f or friction improvement %.1f < %.1f or liquidity %.1f < %.1f or pressure %.1f < 0 (%s over %s)",
                             delta,
                             ASC_SHORTLIST_REPLACEMENT_CHALLENGE_MARGIN,
                             board_delta,
                             ASC_SHORTLIST_REPLACEMENT_RELIEF_BOARD_ADVANTAGE,
                             pressure_relief,
                             ASC_SHORTLIST_REPLACEMENT_RELIEF_PENALTY_DELTA,
                             board_delta,
                             ASC_SHORTLIST_REPLACEMENT_EXECUTION_RELIEF_BOARD_ADVANTAGE,
                             execution_relief,
                             ASC_SHORTLIST_REPLACEMENT_EXECUTION_RELIEF_DELTA,
                             execution_friction_improvement,
                             ASC_SHORTLIST_REPLACEMENT_EXECUTION_FRICTION_IMPROVEMENT_MIN,
                             added_row.filter.liquidity_quality_score,
                             ASC_SHORTLIST_REPLACEMENT_MIN_LIQUIDITY_QUALITY,
                             pressure_relief,
                             added_symbol,
                             removed_symbol);
   return false;
  }

bool ASC_ShortlistMaterialShiftDetected(const ASC_ShortlistSymbolSummary &rows[],
                                        const string &existing_symbols[],
                                        const string &proposed_symbols[],
                                        const int membership_delta)
  {
   if(membership_delta >= 1)
      return true;
   if(ArraySize(existing_symbols) <= 0 || ArraySize(proposed_symbols) <= 0)
      return false;

   if(existing_symbols[0] == proposed_symbols[0])
      return false;

   double top_shift = ASC_ShortlistTopScoreShift(rows, existing_symbols[0], proposed_symbols[0]);
   return (top_shift >= ASC_SHORTLIST_MATERIAL_TOP_SHIFT);
  }

string ASC_ShortlistMemberBandFromRank(const int rank)
  {
   if(rank <= 0)
      return "blocked";
   if(rank <= 3)
      return "promoted";
   return "shortlisted";
  }

string ASC_ShortlistMembershipStateLabel(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.membership_state == "invalid")
      return "invalid";
   if(ASC_ShortlistHasLawfulMembership(entry))
      return (entry.rank <= 3) ? "promoted_overall" : "shortlisted_overall";
   if(ASC_ShortlistHasLawfulBucketMembership(entry))
      return "bucket_local_reserve";
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "reserve_only";
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "pending";
   return "blocked";
  }

string ASC_ShortlistReserveStatusText(const ASC_ShortlistSymbolSummary &entry)
  {
   if(ASC_ShortlistHasLawfulMembership(entry))
      return (entry.rank <= 3) ? "promoted overall" : "shortlisted overall";
   if(ASC_ShortlistHasLawfulBucketMembership(entry))
      return StringFormat("bucket-local reserve | bucket rank #%d", entry.bucket_rank);
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "reserve only | outside bucket top-5 and diversified overall board";
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "pending upstream shortlist context";
   return "outside current shortlist authority";
  }

string ASC_ShortlistDiversifiedOverallRankText(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total=0)
  {
   if(ASC_ShortlistHasLawfulMembership(entry))
     {
      if(shortlist_total > 0)
         return StringFormat("overall diversified #%d/%d", entry.rank, shortlist_total);
      return StringFormat("overall diversified #%d", entry.rank);
     }
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "overall diversified pending";
   return "overall diversified reserve";
  }

string ASC_ShortlistBucketRankText(const ASC_ShortlistSymbolSummary &entry)
  {
   if(ASC_ShortlistHasLawfulBucketMembership(entry))
      return StringFormat("bucket-local #%d", entry.bucket_rank);
   if(entry.bucket_rank > 0)
      return StringFormat("bucket-local #%d outside top-5", entry.bucket_rank);
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "bucket-local pending";
   return "bucket-local outside top-5";
  }

string ASC_ShortlistSubgroupRankText(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.sub_bucket_rank_available && entry.sub_bucket_rank > 0)
      return StringFormat("subgroup-local #%d", entry.sub_bucket_rank);
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "subgroup-local pending";
   return "subgroup-local reserved";
  }

string ASC_ShortlistRawFieldRankText(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.raw_rank > 0)
      return StringFormat("raw field #%d", entry.raw_rank);
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "raw field pending";
   return "raw field unranked";
  }

string ASC_ShortlistRankStackReadbackText(const ASC_ShortlistSymbolSummary &entry,const int shortlist_total=0)
  {
   return ASC_ShortlistDiversifiedOverallRankText(entry, shortlist_total)
          + " | " + ASC_ShortlistBucketRankText(entry)
          + " | " + ASC_ShortlistSubgroupRankText(entry)
          + " | " + ASC_ShortlistRawFieldRankText(entry);
  }

bool ASC_ShortlistOrdinaryL2AuthorityReady(const ASC_ShortlistSymbolSummary &entry,string &reason_out)
  {
   reason_out = "ready";

   if(!entry.has_packet || !ASC_L2PacketHasLawfulSnapshot(entry.packet))
     {
      reason_out = "quote_snapshot_not_live";
      return false;
     }

   if(entry.packet.hydration_gate_code == "blocked_by_warmup")
     {
      reason_out = "blocked_by_warmup";
      return false;
     }

   if(entry.packet.continuity_backed || entry.packet.freshness == ASC_L2_CONTINUITY)
     {
      reason_out = "continuity_backed_only";
      return false;
     }

   if(entry.packet.is_stale
      || entry.packet.freshness == ASC_L2_STALE
      || entry.packet.freshness == ASC_L2_DEGRADED)
     {
      reason_out = "snapshot_freshness_not_current";
      return false;
     }

   if(entry.packet.hydration_family != ASC_L2_HYDRATION_READY)
     {
      reason_out = (StringLen(entry.packet.hydration_reason_code) > 0 ? entry.packet.hydration_reason_code : "hydration_incomplete");
      return false;
     }

   string hydration_reason = "";
   if(!ASC_SelectionFilterPostWarmupHydrationReady(entry.packet, hydration_reason))
     {
      reason_out = hydration_reason;
      return false;
     }

   return true;
  }

string ASC_ShortlistMembershipScopeReadbackText(const ASC_ShortlistSymbolSummary &entry)
  {
   if(ASC_ShortlistHasLawfulMembership(entry))
     {
      string ordinary_l2_reason = "";
      bool ordinary_l2_ready = ASC_ShortlistOrdinaryL2AuthorityReady(entry, ordinary_l2_reason);
      if(ordinary_l2_ready)
         return (entry.rank <= 3)
                ? "promoted overall member | ordinary board authority active"
                : "shortlisted overall member | ordinary board authority active";

      return (entry.rank <= 3)
             ? "promoted overall member | ordinary board membership carried | ordinary board authority pending lawful Layer-2 truth"
             : "shortlisted overall member | ordinary board membership carried | ordinary board authority pending lawful Layer-2 truth";
     }
   if(ASC_ShortlistHasLawfulBucketMembership(entry))
      return StringFormat("bucket-local reserve | strong in bucket only | bucket rank #%d", entry.bucket_rank);
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "reserve only | scored candidate outside diversified overall and bucket top-5";
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "pending shortlist context | membership not yet admitted";
   return "outside shortlist authority | not admitted";
  }

string ASC_ShortlistPriorityPosture(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "pending";
   if(entry.filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      return "blocked";

   if(entry.shortlisted)
     {
      if(entry.rank <= 3)
        {
         if(entry.shortlist_score >= 75.0 || ASC_ShortlistAttentionPriority(entry.shortlist_attention_posture) <= 1)
            return "priority";
         return "elevated";
        }
      if(entry.shortlist_score >= 65.0)
         return "elevated";
      return "watch";
     }

   if(entry.bucket_shortlisted && entry.bucket_rank <= 3 && entry.shortlist_score >= 60.0)
      return "watch";
   return "reserve";
  }

string ASC_ShortlistBuildScoreSummary(const ASC_ShortlistSymbolSummary &entry)
  {
   string score_posture = ASC_TextOrUnavailable(entry.filter.score_posture);
   string attention_posture = ASC_TextOrUnavailable(entry.shortlist_attention_posture);
   string timing_usefulness = ASC_ShortlistTimingUsefulnessLabel(entry);
   string execution_usefulness = ASC_ShortlistExecutionUsefulnessLabel(entry);
   string risk_drag_label = ASC_ShortlistRiskDragLabel(entry);
   string field_regime = ASC_TextOrUnavailable(entry.field_opportunity_regime);
   if(entry.filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
      return StringFormat("state %s | composite %.1f | timing %s | attention %s | %s | %s",
                          ASC_ShortlistReserveStatusText(entry),
                          entry.shortlist_score,
                          timing_usefulness,
                          attention_posture,
                          score_posture,
                          entry.l4_proof_tokens);

   return StringFormat("state %s | composite %.1f | board %.1f | l3 %.1f | context %.1f | execution %.1f (%s) | timing %.1f (%s) | risk drag %.1f (%s) | %s | relative %.1f | rank blend %.1f | field %s | pressure %.1f | liquidity %.1f | corr -%.1f | bucket -%.1f | exposure -%.1f | quality %s | attention %s | %s",
                       ASC_ShortlistReserveStatusText(entry),
                       entry.shortlist_score,
                       entry.overall_board_score,
                       entry.shortlist_l3_score,
                       entry.filter.context_strength_score,
                       entry.filter.execution_alignment_score,
                       execution_usefulness,
                       entry.filter.entry_readiness_score,
                       timing_usefulness,
                       entry.filter.risk_drag_score,
                       risk_drag_label,
                       ASC_SelectionFilterOverlaySummary(entry.filter),
                       entry.relative_opportunity_percentile,
                       entry.relative_field_rank_score,
                       field_regime,
                       entry.filter.pressure_shift_score,
                       entry.filter.liquidity_proximity_score,
                       entry.overall_board_correlation_penalty,
                       entry.overall_board_bucket_penalty,
                       entry.overall_board_conflict_penalty,
                       ASC_ShortlistSignedScoreText(entry.overall_board_quality_adjustment),
                       attention_posture,
                       entry.l4_proof_tokens);
  }

double ASC_ShortlistBuildStyleFitScore(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return 0.0;

   double weighted = 0.0;
   weighted += entry.filter.execution_score * 0.27;
   weighted += entry.filter.liquidity_proximity_score * 0.21;
   weighted += entry.filter.timing_quality_score * 0.20;
   weighted += entry.filter.participation_score * 0.14;
   weighted += entry.filter.pressure_shift_score * 0.10;
   weighted += entry.filter.momentum_acceleration_score * 0.08;
   weighted += entry.overall_board_quality_adjustment;
   weighted -= entry.overall_board_correlation_penalty * 0.60;
   weighted -= entry.overall_board_conflict_penalty * 0.80;

   if(!entry.has_packet)
      weighted -= 12.0;
   else if(entry.state.is_stale)
      weighted -= 10.0;
   else if(entry.state.is_degraded)
      weighted -= 5.0;

   return ASC_ShortlistRoundScore(MathMax(0.0, MathMin(100.0, weighted)));
  }

string ASC_ShortlistStyleFitPosture(const ASC_ShortlistSymbolSummary &entry,const double score)
  {
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "unavailable";
   if(!entry.has_packet)
      return "unavailable";
   if(score >= 82.5)
      return "ideal";
   if(score >= 70.0)
      return "strong";
   if(score >= 56.0)
      return "workable";
   if(score >= 42.0)
      return "guarded";
   return "weak";
  }

string ASC_ShortlistStyleFitReason(const ASC_ShortlistSymbolSummary &entry,const double score)
  {
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "unavailable due to failed execution-readiness context";
   if(!entry.has_packet)
      return "unavailable due to packet/freshness gap";

   string execution_text = (entry.filter.execution_score >= 72.5) ? "tight execution"
                           : ((entry.filter.execution_score >= 55.0) ? "workable execution" : "guarded execution");
   string liquidity_text = (entry.filter.liquidity_proximity_score >= 70.0) ? "strong liquidity"
                           : ((entry.filter.liquidity_proximity_score >= 52.0) ? "workable liquidity" : "thin liquidity");
   string timing_text = (entry.filter.timing_quality_score >= 68.0) ? "active timing"
                        : ((entry.filter.timing_quality_score >= 50.0) ? "steady timing" : "slow timing");

   string caution = "";
   if(entry.state.is_stale)
      caution = "stale";
   else if(entry.state.is_degraded)
      caution = "degraded";
   else if(entry.overall_board_conflict_penalty > 0.0)
      caution = "active exposure";
   else if(entry.overall_board_correlation_penalty >= 4.0)
      caution = "crowded";

   string reason = execution_text + " " + liquidity_text + " " + timing_text;
   if(StringLen(caution) > 0)
      reason += " | " + caution;
   else if(score < 45.0)
      reason += " | weak composite carry";
   return reason;
  }

double ASC_ShortlistBuildDeepRequestPriorityScore(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return 0.0;

   double score = 0.0;
   score += entry.overall_board_score * 0.32;
   score += entry.style_fit_score * 0.22;
   score += entry.filter.timing_quality_score * 0.16;
   score += entry.filter.pressure_shift_score * 0.12;
   score += entry.filter.momentum_acceleration_score * 0.10;
   score += entry.filter.execution_score * 0.08;

   if(entry.shortlisted && entry.rank > 0)
     {
      if(entry.rank <= 3)
         score += 10.0;
      else if(entry.rank <= 5)
         score += 6.0;
      else
         score += 3.0;
     }
   else if(entry.bucket_shortlisted && entry.bucket_rank > 0)
      score += 2.0;
   else
      score -= 8.0;

   score -= entry.overall_board_correlation_penalty * 0.35;
   score -= entry.overall_board_conflict_penalty * 0.60;

   if(!entry.has_packet)
      score -= 14.0;
   else if(entry.state.is_stale)
      score -= 8.0;
   else if(entry.state.is_degraded)
      score -= 4.0;

   return ASC_ShortlistRoundScore(MathMax(0.0, MathMin(100.0, score)));
  }

string ASC_ShortlistDeepRequestPriorityLabel(const ASC_ShortlistSymbolSummary &entry,const double score)
  {
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL || !entry.has_packet)
      return "unavailable";
   if(score >= 75.0)
      return "high";
   if(score >= 60.0)
      return "elevated";
   if(score >= 42.0)
      return "moderate";
   return "low";
  }

string ASC_ShortlistDeepRequestReason(const ASC_ShortlistSymbolSummary &entry,const double score)
  {
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "blocked state lowers immediate deep-review value";
   if(!entry.has_packet)
      return "packet missing lowers immediate deep-review value";

   string scope = "reserve candidate";
   if(entry.shortlisted && entry.rank > 0)
      scope = (entry.rank <= 3) ? "top overall" : "overall member";
   else if(entry.bucket_shortlisted && entry.bucket_rank > 0)
      scope = "strong bucket leader";

   string tactical = (entry.filter.timing_quality_score >= 65.0 && entry.filter.pressure_shift_score >= 60.0)
                     ? "strong tactical carry"
                     : ((entry.filter.timing_quality_score >= 52.0 || entry.filter.momentum_acceleration_score >= 55.0)
                        ? "workable tactical carry"
                        : "lower tactical urgency");

   string caution = "";
   if(entry.overall_board_conflict_penalty > 0.0)
      caution = "active exposure conflict";
   else if(entry.overall_board_correlation_penalty >= 6.0)
      caution = "crowded overall";
   else if(score < 45.0)
      caution = "weak immediate review value";

   string reason = scope + " " + tactical;
   if(StringLen(caution) > 0)
      reason += " | " + caution;
   return reason;
  }

string ASC_ShortlistBuildReason(const ASC_ShortlistSymbolSummary &entry)
  {
   string base_reason = "";
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      base_reason = ASC_TextOrUnavailable(entry.overall_board_reason);
   else if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      base_reason = ASC_TextOrUnavailable(entry.filter.next_required_step);
   else
      base_reason = ASC_TextOrUnavailable(entry.filter.reason_summary);

   return base_reason + " | " + entry.l4_proof_tokens;
  }

void ASC_ShortlistAssignBucketRanks(ASC_ShortlistSymbolSummary &rows[])
  {
   string bucket_ids[];
   ArrayResize(bucket_ids, 0);

   for(int i = 0; i < ArraySize(rows); i++)
     {
      rows[i].bucket_rank = 0;
      rows[i].bucket_shortlisted = false;
      if(rows[i].filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
         continue;

      string bucket_id = ASC_ClassificationEffectiveMainBucketId(rows[i].state.classification);
      if(StringLen(bucket_id) <= 0)
         bucket_id = "unknown";

      bool seen = false;
      for(int b = 0; b < ArraySize(bucket_ids); b++)
        {
         if(bucket_ids[b] == bucket_id)
           {
            seen = true;
            break;
           }
        }
      if(!seen)
        {
         int next_bucket = ArraySize(bucket_ids);
         ArrayResize(bucket_ids, next_bucket + 1);
         bucket_ids[next_bucket] = bucket_id;
        }
     }

   for(int b = 0; b < ArraySize(bucket_ids); b++)
     {
      int bucket_indexes[];
      ArrayResize(bucket_indexes, 0);

      for(int i = 0; i < ArraySize(rows); i++)
        {
         if(rows[i].filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
            continue;
         string bucket_id = ASC_ClassificationEffectiveMainBucketId(rows[i].state.classification);
         if(StringLen(bucket_id) <= 0)
            bucket_id = "unknown";
         if(bucket_id != bucket_ids[b])
            continue;

         int next = ArraySize(bucket_indexes);
         ArrayResize(bucket_indexes, next + 1);
         bucket_indexes[next] = i;
        }

      int bucket_count = ArraySize(bucket_indexes);
      for(int i = 0; i < bucket_count; i++)
        {
         for(int j = i + 1; j < bucket_count; j++)
           {
            if(ASC_ShortlistRightOutranksLeft(rows[bucket_indexes[i]], rows[bucket_indexes[j]]))
              {
               int tmp = bucket_indexes[i];
               bucket_indexes[i] = bucket_indexes[j];
               bucket_indexes[j] = tmp;
              }
           }
        }

      for(int i = 0; i < bucket_count; i++)
        {
         int row_index = bucket_indexes[i];
         rows[row_index].bucket_rank = i + 1;
         rows[row_index].bucket_shortlisted = ((i + 1) <= ASC_SHORTLIST_BUCKET_SIZE);
        }
     }
  }

void ASC_ShortlistAssignSubBucketRanks(ASC_ShortlistSymbolSummary &rows[])
  {
   string scope_keys[];
   ArrayResize(scope_keys, 0);

   for(int i = 0; i < ArraySize(rows); i++)
     {
      rows[i].sub_bucket_rank = 0;
      rows[i].sub_bucket_rank_available = false;
      if(rows[i].filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
         continue;

      string bucket_id = ASC_ClassificationEffectiveMainBucketId(rows[i].state.classification);
      if(StringLen(bucket_id) <= 0)
         bucket_id = "unknown";
      string sub_bucket_id = ASC_ClassificationEffectiveSubBucketId(rows[i].state.classification);
      if(StringLen(sub_bucket_id) <= 0)
         sub_bucket_id = ASC_ClassificationFallbackSubBucketId(bucket_id);
      if(StringLen(sub_bucket_id) <= 0)
         continue;

      string scope_key = bucket_id + "|" + sub_bucket_id;
      bool seen = false;
      for(int s = 0; s < ArraySize(scope_keys); s++)
        {
         if(scope_keys[s] == scope_key)
           {
            seen = true;
            break;
           }
        }
      if(!seen)
        {
         int next_scope = ArraySize(scope_keys);
         ArrayResize(scope_keys, next_scope + 1);
         scope_keys[next_scope] = scope_key;
        }
     }

   for(int s = 0; s < ArraySize(scope_keys); s++)
     {
      int scoped_indexes[];
      ArrayResize(scoped_indexes, 0);

      for(int i = 0; i < ArraySize(rows); i++)
        {
         if(rows[i].filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
            continue;

         string bucket_id = ASC_ClassificationEffectiveMainBucketId(rows[i].state.classification);
         if(StringLen(bucket_id) <= 0)
            bucket_id = "unknown";
         string sub_bucket_id = ASC_ClassificationEffectiveSubBucketId(rows[i].state.classification);
         if(StringLen(sub_bucket_id) <= 0)
            sub_bucket_id = ASC_ClassificationFallbackSubBucketId(bucket_id);
         if(StringLen(sub_bucket_id) <= 0)
            continue;

         string scope_key = bucket_id + "|" + sub_bucket_id;
         if(scope_key != scope_keys[s])
            continue;

         int next = ArraySize(scoped_indexes);
         ArrayResize(scoped_indexes, next + 1);
         scoped_indexes[next] = i;
        }

      int scoped_count = ArraySize(scoped_indexes);
      if(scoped_count <= 0)
         continue;

      for(int i = 0; i < scoped_count; i++)
        {
         for(int j = i + 1; j < scoped_count; j++)
           {
            if(ASC_ShortlistRightOutranksLeft(rows[scoped_indexes[i]], rows[scoped_indexes[j]]))
              {
               int tmp = scoped_indexes[i];
               scoped_indexes[i] = scoped_indexes[j];
               scoped_indexes[j] = tmp;
              }
           }
        }

      for(int i = 0; i < scoped_count; i++)
        {
         int row_index = scoped_indexes[i];
         rows[row_index].sub_bucket_rank = i + 1;
         rows[row_index].sub_bucket_rank_available = true;
        }
     }
  }

void ASC_ShortlistBuildSummarySet(const ASC_CommittedLayer3SymbolState &committed_l3_rows[],
                                  ASC_ShortlistSymbolSummary &rows[])
  {
   ArrayResize(rows, 0);
   datetime now_utc = TimeGMT();
   ASC_Layer1PassSummary l1_summary;
   bool has_l1_summary = ASC_Layer1TryGetLatestSummary(l1_summary);
   bool post_warmup_authority_gate_active = (has_l1_summary && l1_summary.warmup_ready);
   int total = ASC_Layer1CachedSymbolCount();
   for(int i = 0; i < total; i++)
     {
      ASC_Layer1SymbolState symbol_state;
      if(!ASC_Layer1GetCachedSymbol(i, symbol_state))
         continue;
      if(StringLen(symbol_state.symbol) <= 0)
         continue;

      ASC_Layer2Packet packet;
      bool has_packet = ASC_ShortlistTryGetPacketForState(symbol_state, packet);
      bool has_lawful_packet = has_packet && ASC_L2PacketHasLawfulSnapshot(packet);

      ASC_SelectionFilterEvaluation live_filter;
      ASC_SelectionFilterEvaluate(symbol_state, packet, has_lawful_packet, live_filter);

      ASC_CommittedLayer3SymbolState linked_l3;
      bool has_linked_l3 = ASC_ShortlistFindCommittedLayer3State(committed_l3_rows, symbol_state.symbol, linked_l3);

      ASC_SelectionFilterEvaluation ranking_filter = live_filter;
      if(has_linked_l3 && linked_l3.source_ready)
        {
         bool allow_linked_authority = true;
         if(post_warmup_authority_gate_active)
           {
            string hydration_reason = "";
            bool live_hydration_ready = ASC_SelectionFilterPostWarmupHydrationReady(packet, hydration_reason);
            bool live_pass_ready = (live_filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS);
            allow_linked_authority = (live_pass_ready && live_hydration_ready);
            if(!allow_linked_authority)
              {
               ASC_SelectionFilterSetOutcome(live_filter,
                                             ASC_SELECTION_FILTER_RESULT_PENDING,
                                             "Layer-4 authority deferred while hydration completes",
                                             "l4_authority_hydration_pending",
                                             "building: post-warmup Layer-2 hydration is still completing, so Layer-4 authority remains transitional",
                                             "building",
                                             "l2 hydration pending: " + hydration_reason,
                                             "await hydrated trader-facing Layer-2 truth");
              }
           }

         if(allow_linked_authority)
            ranking_filter = linked_l3.evaluation;
        }

      double l3_score = 0.0;
      double context_score = 0.0;
      double stability_bias = 0.0;
      double composite_score = ASC_ShortlistCompositePriorityScore(symbol_state,
                                                                   packet,
                                                                   ranking_filter,
                                                                   has_lawful_packet,
                                                                   symbol_state.symbol,
                                                                   l3_score,
                                                                   context_score,
                                                                   stability_bias);

      int next = ArraySize(rows);
      ArrayResize(rows, next + 1);
      rows[next].symbol = symbol_state.symbol;
      rows[next].state = symbol_state;
      rows[next].packet = packet;
      rows[next].has_packet = has_lawful_packet;
      rows[next].filter = ranking_filter;
      rows[next].shortlist_score = composite_score;
      rows[next].shortlist_l3_score = l3_score;
      rows[next].shortlist_context_score = context_score;
      rows[next].shortlist_stability_bias = stability_bias;
      rows[next].cleanliness_score = ASC_ShortlistCleanlinessScore(ranking_filter);
      rows[next].cleanliness_posture = ASC_ShortlistCleanlinessPosture(rows[next].cleanliness_score);
      rows[next].session_fit_for_style_score = ASC_ShortlistSessionFitForStyleScore(ranking_filter);
      rows[next].session_fit_for_style = ASC_ShortlistSessionFitPosture(rows[next].session_fit_for_style_score);
      rows[next].asset_execution_penalty = ASC_ShortlistAssetExecutionPenalty(symbol_state, ranking_filter);
      rows[next].asset_execution_penalty_posture = ASC_ShortlistAssetExecutionPenaltyPosture(rows[next].asset_execution_penalty);
      rows[next].raw_rank = 0;
      rows[next].rank = 0;
      rows[next].bucket_rank = 0;
      rows[next].sub_bucket_rank = 0;
      rows[next].shortlisted = false;
      rows[next].bucket_shortlisted = false;
      rows[next].sub_bucket_rank_available = false;
      rows[next].overall_board_score = 0.0;
      rows[next].overall_board_quality_adjustment = 0.0;
      rows[next].overall_board_correlation_penalty = 0.0;
      rows[next].overall_board_bucket_penalty = 0.0;
      rows[next].overall_board_conflict_penalty = 0.0;
      rows[next].relative_field_rank_score = 0.0;
      rows[next].relative_opportunity_percentile = 0.0;
      rows[next].leader_separation_score = 0.0;
      rows[next].top10_compression_score = 0.0;
      rows[next].field_opportunity_regime = "unavailable";
      rows[next].overall_board_peer_symbol = "n/a";
      rows[next].overall_board_peer_correlation = 0.0;
      rows[next].overall_board_cluster_count = 0;
      rows[next].overall_board_posture = "pending";
      rows[next].overall_board_reason = "awaiting diversified overall-board authority";
      rows[next].membership_state = "pending";
      rows[next].shortlist_band = "pending";
      rows[next].shortlist_stability_posture = "pending";
      rows[next].shortlist_posture = "pending";
      rows[next].shortlist_attention_posture = ASC_TextOrUnavailable(ranking_filter.attention_posture);
      rows[next].shortlist_score_summary = "awaiting Layer-4 ranking summary";
      rows[next].shortlist_reason = "awaiting shortlist authority evaluation";
      rows[next].style_fit_score = rows[next].cleanliness_score;
      rows[next].style_fit_posture = rows[next].cleanliness_posture;
      rows[next].style_fit_reason = "awaiting style-fit synthesis";
      rows[next].deep_request_priority_score = rows[next].session_fit_for_style_score;
      rows[next].deep_request_priority = "unavailable";
      rows[next].deep_request_reason = "awaiting deep-request priority synthesis";
      bool linked_l3_source_ready = (has_linked_l3 && linked_l3.source_ready);
      rows[next].evidence_intake_state = ASC_ShortlistEvidenceIntakeState(ranking_filter, has_linked_l3, linked_l3_source_ready);
      rows[next].evidence_intake_claim_evidence_status = ASC_ShortlistEvidenceIntakeClaimEvidenceStatus(rows[next].evidence_intake_state);
      rows[next].evidence_intake_detail = ASC_ShortlistEvidenceIntakeDetail(ranking_filter, has_linked_l3, linked_l3_source_ready);
      rows[next].l4_meaning_token = "shortlist_priority_ordering_only";
      rows[next].trade_permission_token = "false";
      rows[next].entry_signal_token = "false";
      rows[next].l3_authority_source_token = ASC_ShortlistLayer3AuthoritySourceToken(ranking_filter, has_linked_l3, linked_l3_source_ready);
      rows[next].l3_authority_age_token = ASC_ShortlistLayer3AuthorityAgeToken(ranking_filter, has_linked_l3, linked_l3_source_ready);
      rows[next].l4_rank_reason_token = "mixed";
      rows[next].why_not_higher_token = "not_applicable";
      rows[next].exclusion_reason_token = "not_excluded";
      rows[next].correlation_status_token = "pending";
      rows[next].exposure_status_token = "unknown";
      rows[next].top_list_authority_token = "pending";
      rows[next].artifact_projection_token = "qualified";
      rows[next].behavior_change_token = "no";
      rows[next].l4_proof_tokens = "";
      rows[next].correlation_summary.average_score = 0.0;
      rows[next].correlation_summary.high_a_symbol = "n/a";
      rows[next].correlation_summary.high_a_score = 0.0;
      rows[next].correlation_summary.high_b_symbol = "n/a";
      rows[next].correlation_summary.high_b_score = 0.0;
      rows[next].correlation_summary.low_a_symbol = "n/a";
      rows[next].correlation_summary.low_a_score = 0.0;
      rows[next].correlation_summary.low_b_symbol = "n/a";
      rows[next].correlation_summary.low_b_score = 0.0;
      rows[next].correlation_summary.peers_compared = 0;
      rows[next].correlation_summary.peers_packet_ready = 0;
      rows[next].correlation_summary.anchor_packet_ready = false;
      rows[next].correlation_summary.summary_ready = false;
      rows[next].correlation_summary.summary_posture = "pending";
      rows[next].correlation_summary.summary_reason = "true correlation deferred from the ordinary Layer-4 hot path";
      rows[next].shortlist_evaluated_utc = now_utc;
     }

   int count = ArraySize(rows);
   for(int i = 0; i < count; i++)
     {
      for(int j = i + 1; j < count; j++)
        {
         if(ASC_ShortlistRightOutranksLeft(rows[i], rows[j]))
           {
            ASC_ShortlistSymbolSummary tmp = rows[i];
            rows[i] = rows[j];
            rows[j] = tmp;
           }
        }
     }

   int raw_rank = 1;
   for(int r = 0; r < count; r++)
     {
      if(rows[r].filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
         rows[r].raw_rank = raw_rank++;
      else
         rows[r].raw_rank = 0;
     }

   string proposed_symbols[];
   ASC_ShortlistBuildDiversifiedOverallSymbols(rows, ASC_SHORTLIST_SIZE, proposed_symbols);

   bool has_existing = (ArraySize(g_asc_shortlist_symbols) > 0);
   int existing_count_before = ArraySize(g_asc_shortlist_symbols);
   int membership_delta = ASC_ShortlistMembershipDelta(g_asc_shortlist_symbols, proposed_symbols);
   bool material_shift = ASC_ShortlistMaterialShiftDetected(rows,
                                                            g_asc_shortlist_symbols,
                                                            proposed_symbols,
                                                            membership_delta);

   string invalid_symbol = "";
   bool existing_membership_invalid = has_existing
                                      && ASC_ShortlistExistingMembershipInvalid(g_asc_shortlist_symbols, rows, invalid_symbol);
   bool shortlist_invalid = (ArraySize(proposed_symbols) <= 0 || existing_membership_invalid);
   bool hold_active = (g_asc_shortlist_hold_until_utc > now_utc);
   string replacement_gate_reason = "";
   bool replacement_gate_blocked = has_existing
                                   && !existing_membership_invalid
                                   && membership_delta == 2
                                   && !ASC_ShortlistReplacementClearsStabilityGate(rows,
                                                                                   g_asc_shortlist_symbols,
                                                                                   proposed_symbols,
                                                                                   replacement_gate_reason);
   string active_symbols[];

   if(!has_existing && !shortlist_invalid)
     {
      ASC_ShortlistCommit(proposed_symbols, now_utc);
      g_asc_shortlist_dirty_challenge_beats = 0;
      g_asc_shortlist_posture = "material-shift";
      g_asc_shortlist_reason = "first Layer-4 shortlist committed from current score-led ranking (" +
                               ASC_ShortlistDecisionEvidence(membership_delta, ArraySize(proposed_symbols), existing_count_before) + ")";
      ASC_ShortlistCopySymbols(g_asc_shortlist_symbols, active_symbols);
     }
   else if(shortlist_invalid)
     {
      g_asc_shortlist_dirty_challenge_beats = 0;
      if(has_existing)
        {
         if(ArraySize(proposed_symbols) > 0 && existing_membership_invalid)
           {
            ASC_ShortlistCommit(proposed_symbols, now_utc);
            ASC_ShortlistCopySymbols(g_asc_shortlist_symbols, active_symbols);
            g_asc_shortlist_posture = "material-shift";
            g_asc_shortlist_reason = "unlawful existing shortlist replaced by current lawful Layer-4 survivors (" +
                                     ASC_ShortlistDecisionEvidence(membership_delta, ArraySize(proposed_symbols), existing_count_before) + ")";
           }
         else
           {
            ASC_ShortlistCopySymbols(g_asc_shortlist_symbols, active_symbols);
            g_asc_shortlist_posture = "invalid";
            g_asc_shortlist_reason = existing_membership_invalid
                                     ? ("existing shortlist membership is no longer lawful (" + invalid_symbol + ")")
                                     : "shortlist held as invalid because no lawful ranked survivors are available";
           }
        }
      else
        {
         ArrayResize(active_symbols, 0);
         g_asc_shortlist_posture = "pending";
         g_asc_shortlist_reason = "awaiting lawful Layer-4 shortlist candidates";
        }
     }
   else if(replacement_gate_blocked)
     {
      g_asc_shortlist_dirty_challenge_beats = 0;
      ASC_ShortlistCopySymbols(g_asc_shortlist_symbols, active_symbols);
      g_asc_shortlist_posture = "stable";
      g_asc_shortlist_reason = "single-slot Layer-4 replacement deferred until the challenger is materially stronger ("
                               + replacement_gate_reason + "; "
                               + ASC_ShortlistDecisionEvidence(membership_delta, ArraySize(proposed_symbols), existing_count_before) + ")";
     }
   else if(material_shift && hold_active)
     {
      g_asc_shortlist_dirty_challenge_beats++;
      ASC_ShortlistCopySymbols(g_asc_shortlist_symbols, active_symbols);
      g_asc_shortlist_posture = "dirty-held";
      g_asc_shortlist_reason = StringFormat("material Layer-4 shortlist challenge deferred by hold (%d/%d; hold %d sec remaining; %s)",
                                            g_asc_shortlist_dirty_challenge_beats,
                                            ASC_SHORTLIST_DIRTY_CHALLENGE_BEATS_REQUIRED,
                                            (int)MathMax(0, g_asc_shortlist_hold_until_utc - now_utc),
                                            ASC_ShortlistDecisionEvidence(membership_delta, ArraySize(proposed_symbols), existing_count_before));
     }
   else if(material_shift)
     {
      if(has_existing)
         g_asc_shortlist_dirty_challenge_beats++;
      if(has_existing && g_asc_shortlist_dirty_challenge_beats < ASC_SHORTLIST_DIRTY_CHALLENGE_BEATS_REQUIRED)
        {
         ASC_ShortlistCopySymbols(g_asc_shortlist_symbols, active_symbols);
         g_asc_shortlist_posture = "stable";
         g_asc_shortlist_reason = StringFormat("hold ended but Layer-4 shortlist pressure is still building (%d/%d; %s)",
                                               g_asc_shortlist_dirty_challenge_beats,
                                               ASC_SHORTLIST_DIRTY_CHALLENGE_BEATS_REQUIRED,
                                               ASC_ShortlistDecisionEvidence(membership_delta, ArraySize(proposed_symbols), existing_count_before));
        }
      else
        {
         ASC_ShortlistCommit(proposed_symbols, now_utc);
         ASC_ShortlistCopySymbols(g_asc_shortlist_symbols, active_symbols);
         g_asc_shortlist_posture = "material-shift";
         g_asc_shortlist_reason = "material Layer-4 shortlist change accepted after sustained pressure (" +
                                  ASC_ShortlistDecisionEvidence(membership_delta, ArraySize(proposed_symbols), existing_count_before) + ")";
         g_asc_shortlist_dirty_challenge_beats = 0;
        }
     }
   else
     {
      if(!has_existing)
         ASC_ShortlistCommit(proposed_symbols, now_utc);
      g_asc_shortlist_dirty_challenge_beats = 0;
      ASC_ShortlistCopySymbols(g_asc_shortlist_symbols, active_symbols);
      g_asc_shortlist_posture = "stable";
      g_asc_shortlist_reason = "shortlist remains stable under current Layer-4 ranking (" +
                               ASC_ShortlistDecisionEvidence(membership_delta, ArraySize(proposed_symbols), existing_count_before) + ")";
     }

   bool any_degraded = false;
   bool any_stale = false;
   for(int r = 0; r < count; r++)
     {
      rows[r].shortlisted = ASC_ShortlistContains(active_symbols, rows[r].symbol);
      if(rows[r].shortlisted && rows[r].state.is_degraded)
         any_degraded = true;
      if(rows[r].shortlisted && rows[r].state.is_stale)
         any_stale = true;
     }

   if(g_asc_shortlist_posture == "stable" && any_degraded)
      g_asc_shortlist_posture = "degraded";
   else if(g_asc_shortlist_posture == "stable" && any_stale)
      g_asc_shortlist_posture = "stale";

   string shortlist_stability_posture = g_asc_shortlist_posture;

   for(int r = 0; r < count; r++)
     {
      rows[r].rank = ASC_ShortlistSymbolRankInSet(active_symbols, rows[r].symbol);
      rows[r].shortlist_evaluated_utc = now_utc;
     }

   ASC_ShortlistAssignBucketRanks(rows);
   ASC_ShortlistAssignSubBucketRanks(rows);
   ASC_ShortlistApplyOverallBoardContext(rows, active_symbols);

   for(int r = 0; r < count; r++)
     {
      if(rows[r].shortlisted)
        {
         rows[r].shortlist_band = ASC_ShortlistMemberBandFromRank(rows[r].rank);
         rows[r].shortlist_stability_posture = shortlist_stability_posture;
        }
      else if(rows[r].filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
        {
         rows[r].shortlist_band = "reserve";
         rows[r].shortlist_stability_posture = ASC_ShortlistHasLawfulBucketMembership(rows[r]) ? "bucket_local_reserve" : "reserve_only";
        }
      else if(rows[r].filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
        {
         rows[r].shortlist_band = "pending";
         rows[r].shortlist_stability_posture = "pending";
        }
      else
        {
         rows[r].shortlist_band = "blocked";
         rows[r].shortlist_stability_posture = "not_selected";
        }

      rows[r].membership_state = ASC_ShortlistMembershipStateLabel(rows[r]);
      rows[r].shortlist_band = ASC_ShortlistSelectionBand(rows[r]);
      rows[r].shortlist_posture = ASC_ShortlistPriorityPosture(rows[r]);
      rows[r].shortlist_score_summary = ASC_ShortlistBuildScoreSummary(rows[r]);
      rows[r].shortlist_reason = ASC_ShortlistBuildReason(rows[r]);
      rows[r].style_fit_score = ASC_ShortlistBuildStyleFitScore(rows[r]);
      rows[r].style_fit_posture = ASC_ShortlistStyleFitPosture(rows[r], rows[r].style_fit_score);
      rows[r].style_fit_reason = ASC_ShortlistStyleFitReason(rows[r], rows[r].style_fit_score);
      rows[r].deep_request_priority_score = ASC_ShortlistBuildDeepRequestPriorityScore(rows[r]);
      rows[r].deep_request_priority = ASC_ShortlistDeepRequestPriorityLabel(rows[r], rows[r].deep_request_priority_score);
      rows[r].deep_request_reason = ASC_ShortlistDeepRequestReason(rows[r], rows[r].deep_request_priority_score);
     }

   for(int r = 0; r < count; r++)
      ASC_ShortlistBuildCorrelationSummary(rows[r].symbol, rows, rows[r].correlation_summary);

   for(int r = 0; r < count; r++)
     {
      ASC_ShortlistFinalizeTruthProofTokens(rows[r]);
      rows[r].shortlist_score_summary = ASC_ShortlistBuildScoreSummary(rows[r]);
      rows[r].shortlist_reason = ASC_ShortlistBuildReason(rows[r]);
     }
  }

int ASC_ShortlistTakeTop(const ASC_ShortlistSymbolSummary &rows[],const int limit,ASC_ShortlistSymbolSummary &out_rows[])
  {
   ArrayResize(out_rows, 0);
   int count = MathMax(0, limit);
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(!ASC_ShortlistHasLawfulMembership(rows[i]))
         continue;
      int next = ArraySize(out_rows);
      ArrayResize(out_rows, next + 1);
      out_rows[next] = rows[i];
     }

   int total = ArraySize(out_rows);
   for(int i = 0; i < total; i++)
     {
      for(int j = i + 1; j < total; j++)
        {
         if(out_rows[j].rank > 0 && (out_rows[i].rank <= 0 || out_rows[j].rank < out_rows[i].rank))
           {
            ASC_ShortlistSymbolSummary tmp = out_rows[i];
            out_rows[i] = out_rows[j];
            out_rows[j] = tmp;
           }
        }
     }

   if(total > count)
      ArrayResize(out_rows, count);
   return ArraySize(out_rows);
  }

bool ASC_ShortlistFindSymbolSummary(const ASC_ShortlistSymbolSummary &rows[],
                                    const string symbol,
                                    ASC_ShortlistSymbolSummary &entry,
                                    int &rank,
                                    int &total)
  {
   total = ASC_ShortlistCount(rows);
   rank = 0;

   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(!ASC_ShortlistSymbolMatchesContext(rows[i], symbol))
         continue;
      entry = rows[i];
      rank = rows[i].rank;
      if(entry.shortlisted && !ASC_ShortlistHasLawfulMembership(entry))
        {
         ASC_ShortlistMarkMembershipInvalid(entry);
         rank = 0;
        }
      return true;
     }
   return false;
  }

void ASC_ShortlistBuildCorrelationSummary(const string anchor_symbol,
                                          const ASC_ShortlistSymbolSummary &rows[],
                                          ASC_ShortlistCorrelationSummary &summary)
  {
   summary.average_score = 0.0;
   summary.high_a_symbol = "n/a";
   summary.high_a_score = 0.0;
   summary.high_b_symbol = "n/a";
   summary.high_b_score = 0.0;
   summary.low_a_symbol = "n/a";
   summary.low_a_score = 0.0;
   summary.low_b_symbol = "n/a";
   summary.low_b_score = 0.0;
   summary.peers_compared = 0;
   summary.peers_packet_ready = 0;
   summary.anchor_packet_ready = false;
   summary.summary_ready = false;
   summary.summary_posture = "pending";
   summary.summary_reason = "awaiting shortlist-owned true-correlation summary";

   ASC_Layer2Packet anchor_packet;
   bool anchor_has_packet = false;
   bool anchor_found = false;
   for(int a = 0; a < ArraySize(rows); a++)
     {
      if(!ASC_ShortlistSymbolMatchesContext(rows[a], anchor_symbol))
         continue;
      anchor_packet = rows[a].packet;
      anchor_has_packet = rows[a].has_packet;
      anchor_found = true;
      break;
     }
   summary.anchor_packet_ready = (anchor_has_packet && ASC_L2PacketHasLawfulSnapshot(anchor_packet));

   if(!anchor_found)
     {
      summary.summary_posture = "unavailable";
      summary.summary_reason = "anchor symbol is not present in shortlist scope";
      return;
     }

   if(!summary.anchor_packet_ready)
     {
      summary.summary_posture = "limited";
      summary.summary_reason = "anchor market-watch packet is unavailable for shortlist-owned true-correlation support";
      return;
     }

   double high_a_score = -1.0;
   double high_b_score = -1.0;
   double low_a_score = 2.0;
   double low_b_score = 2.0;
   int successful_pairs = 0;
   string first_failure_reason = "";

   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(!ASC_ShortlistHasLawfulMembership(rows[i]))
         continue;
      if(ASC_ShortlistSymbolMatchesContext(rows[i], anchor_symbol))
         continue;

      summary.peers_compared++;
      if(rows[i].has_packet && ASC_L2PacketHasLawfulSnapshot(rows[i].packet))
         summary.peers_packet_ready++;

      double corr = 0.0;
      int corr_samples = 0;
      string corr_reason = "";
      if(!ASC_TrySummaryTrueCorrelationScore(anchor_symbol,
                                             rows[i].symbol,
                                             corr,
                                             corr_samples,
                                             corr_reason))
        {
         if(StringLen(first_failure_reason) <= 0)
            first_failure_reason = corr_reason;
         continue;
        }

      summary.average_score += corr;
      successful_pairs++;
      summary.summary_ready = true;

      if(corr > high_a_score)
        {
         high_b_score = high_a_score;
         summary.high_b_symbol = summary.high_a_symbol;
         summary.high_b_score = summary.high_a_score;
         high_a_score = corr;
         summary.high_a_symbol = rows[i].symbol;
         summary.high_a_score = corr;
        }
      else if(corr > high_b_score)
        {
         high_b_score = corr;
         summary.high_b_symbol = rows[i].symbol;
         summary.high_b_score = corr;
        }

      if(corr < low_a_score)
        {
         low_b_score = low_a_score;
         summary.low_b_symbol = summary.low_a_symbol;
         summary.low_b_score = summary.low_a_score;
         low_a_score = corr;
         summary.low_a_symbol = rows[i].symbol;
         summary.low_a_score = corr;
        }
      else if(corr < low_b_score)
        {
         low_b_score = corr;
         summary.low_b_symbol = rows[i].symbol;
         summary.low_b_score = corr;
        }
     }

   if(summary.summary_ready)
     {
      summary.average_score = summary.average_score / MathMax(1, successful_pairs);
      summary.summary_posture = "ready";
      summary.summary_reason = StringFormat("shortlist-owned true-correlation summary ready across %d pairs", successful_pairs);
      return;
     }

   if(summary.peers_compared <= 0)
     {
      summary.summary_posture = "pending";
      summary.summary_reason = "no lawful shortlist peers are available for true-correlation summary";
      return;
     }

   summary.summary_posture = "limited";
   summary.summary_reason = (StringLen(first_failure_reason) > 0)
                           ? first_failure_reason
                           : "true-correlation summary remains unavailable for the current shortlist scope";
  }

bool ASC_ShortlistCorrelationReady(const ASC_ShortlistSymbolSummary &rows[])
  {
   int packet_ready = 0;
   int shortlisted_count = 0;
   for(int i = 0; i < ArraySize(rows); i++)
     {
      if(!ASC_ShortlistHasLawfulMembership(rows[i]))
         continue;
      shortlisted_count++;
      if(rows[i].has_packet && ASC_L2PacketHasLawfulSnapshot(rows[i].packet))
         packet_ready++;
     }
   if(shortlisted_count <= 1)
      return false;
   return (packet_ready >= MathMin(3, shortlisted_count));
  }

#endif
