#ifndef __ASC_SEMI_AUTO_TYPES_MQH__
#define __ASC_SEMI_AUTO_TYPES_MQH__

#include "ASC_SemiAutoContracts.mqh"

struct ASC_L6_LineageStamp
  {
   string symbol;
   string canonical_symbol;
   string source_layer_ref;
   string source_revision_ref;
   string source_packet_ref;
   string source_owner;
  };

struct ASC_L6_AvailabilityStamp
  {
   bool valid;
   bool available;
   bool missing_surface;
   bool continuity_backed;
   string availability_state;
   string reason_summary;
   string missing_surface_notes;
  };

struct ASC_Layer5WorkbenchPacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   string source_layer_id;
   string source_result_revision;
   datetime source_build_utc;
   string source_context;
   bool packet_valid;
   bool packet_lawful;
   string packet_reason_summary;

   string entitlement_state;
   string entitlement_reason;
   string freshness_posture;
   string continuity_posture;
   string preservation_state;
   string preservation_reason;
   string build_context;
   string data_tier;
   string missing_surface_notes;
   string degraded_surface_notes;

   double execution_score;
   double execution_penalty;
   string execution_posture;
   double spread_quality_score;
   double friction_quality_score;
   double liquidity_quality_score;
   double pressure_shift_score;
   string pressure_shift_posture;
   double momentum_acceleration_score;
   string momentum_acceleration_posture;
   double move_age_score;
   string move_age_posture;
   double participation_score;
   string participation_posture;
   double tick_burst_score;
   string tick_burst_posture;
   bool tick_burst_flag;
   string scalp_tradable;
   string intraday_tradable;
   string micro_direction;
   string micro_conviction;
   string impulse_state;
   string participation_state;

   string short_term_bias;
   string mid_term_bias;
   string higher_timeframe_bias;
   string alignment;
   int upward_timeframe_count;
   int downward_timeframe_count;
   int expansion_timeframe_count;
   int compression_timeframe_count;
   double position_in_range_pct;
   double distance_to_recent_high_pct;
   double distance_to_recent_low_pct;
   string liquidity_zone;
   double liquidity_proximity_score;
   string liquidity_proximity_posture;

   double session_sweep_score;
   string session_sweep_state;
   double reclaim_score;
   string reclaim_state;
   double failed_break_score;
   string failed_break_state;
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

   string siam_primary_fit;
   double siam_primary_fit_score;
   string siam_primary_fit_posture;
   string siam_primary_fit_reason;
   string siam_secondary_fit;
   double siam_secondary_fit_score;
   string siam_secondary_fit_posture;
   string siam_secondary_fit_reason;
   string siam_fit_summary;
   string siam_setup_fit_caution;
   string siam_setup_fit_conclusion;

   string summary_line;
   string tactical_snapshot_summary;
   string structure_liquidity_summary;
   string session_timing_summary;
   string score_context_summary;
   string microstructure_summary;
   string siam_tactical_summary;

   bool source_deep_packet_available;
   bool source_shortlist_context_available;
   string source_trigger_family;
   string source_trigger_reason;
   string source_context_summary;
   string source_contract_note;
  };

struct ASC_L6_NormalizedContextPacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   bool packet_valid;
   bool packet_lawful;
   string source_packet_revision;
   datetime source_build_utc;
   string freshness_posture;
   string continuity_posture;
   string preservation_state;
   string preservation_reason;
   string data_tier;
   string entitlement_state;
   string entitlement_reason;
   string support_context;
   string missing_surface_notes;
   string degraded_surface_notes;
   string concise_reason_summary;

   double execution_score;
   string execution_posture;
   double liquidity_score;
   string liquidity_posture;
   double participation_score;
   string participation_posture;
   double momentum_score;
   string momentum_posture;
   double pressure_score;
   string pressure_posture;
   double move_freshness_score;
   string move_freshness_posture;
   string scalp_tradability;
   string intraday_tradability;
   string alignment_baseline;
   string shortlist_context_carry;
   string build_context_carry;

   ASC_L6_HorizonClass horizon_class;
   string market_state_ref;
   string packet_ref;
   string shortlist_ref;
   string normalization_reason_summary;
   string normalization_notes;
  };

struct ASC_L6_MtfPosturePacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   string context_timeframe_role;
   string bias_timeframe_role;
   string trigger_timeframe_role;
   string short_term_bias;
   string mid_term_bias;
   string higher_timeframe_bias;
   string alignment;
   int upward_timeframe_count;
   int downward_timeframe_count;
   int expansion_timeframe_count;
   int compression_timeframe_count;
   ASC_L6_MtfConflictClass conflict_class;
   string path_viability_posture;
   string reversal_pressure_posture;
   string allowed_style_hint;
   string lower_timeframe_posture;
   string trigger_timeframe_posture;
   string higher_timeframe_posture;
   string conflict_reason_summary;
   string timeframe_notes;
  };

struct ASC_L6_FamilyCandidatePacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   ASC_L6_FamilyId family_id;
   ASC_L6_OpportunityStatus opportunity_status;
   string family_ref;
   string candidate_reason_summary;
   string disqualifier_summary;
   string candidate_notes;
  };

struct ASC_L6_FamilyCompetitionPacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   ASC_L6_FamilyCompetitionStatus competition_status;
   ASC_L6_FamilyId primary_family_id;
   string primary_family_reason;
   string secondary_family_reason;
   string competition_notes;
  };

struct ASC_L6_OpportunityPathPacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   ASC_L6_OpportunityStatus opportunity_status;
   ASC_L6_HorizonClass horizon_class;
   string opportunity_path_id;
   string execution_invalid_reason;
   string structure_invalid_reason;
   string path_notes;
  };

struct ASC_L6_GeometryCandidatePacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   ASC_L6_GeometryValidity geometry_validity;
   ASC_L6_FamilyId primary_family_id;
   ASC_L6_FamilyId alternate_family_id;
   bool primary_candidate_supported;
   bool alternate_candidate_supported;
   string primary_candidate_summary;
   string alternate_candidate_summary;
   string entry_reference;
   string invalidation_reference;
   string target_reference;
   string timebox_posture;
   string execution_burden_posture;
   string review_burden_posture;
   string timing_posture;
   string blocker_summary;
   string insufficiency_reason;
   string geometry_reason_summary;
   string geometry_notes;
  };

struct ASC_L6_AdvancedPatternPacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   ASC_L6_PatternLaneAvailability lane_availability;
   ASC_L6_PatternCandidateStatus candidate_status;
   ASC_L6_PatternConfidencePosture confidence_posture;
   ASC_L6_PatternFamilyType candidate_family_type;
   ASC_L6_FamilyId supportive_family_id;
   bool candidate_available;
   bool geometry_affinity_present;
   bool boundary_preserved;
   string lane_availability_text;
   string candidate_family_type_text;
   string candidate_pattern_family;
   string candidate_status_text;
   string confidence_posture_text;
   string geometry_affinity_note;
   string invalidation_note;
   string confirmation_note;
   string preservation_note;
   string boundary_note;
   double supportive_weight;
   string candidate_reason_summary;
   string owner_boundary_summary;
   string packet_notes;
  };

struct ASC_L6_ReadinessPacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   ASC_L6_ReadinessClass readiness_class;
   ASC_L6_DeployabilityClass deployability_class;
   ASC_L6_OpportunityStatus opportunity_status;
   ASC_L6_HorizonClass horizon_class;
   ASC_L6_GeometryValidity geometry_validity;
   string deployability_class_text;
   string opportunity_status_text;
   string readiness_class_text;
   string horizon_class_text;
   string geometry_validity_text;
   string primary_blocker;
   string downgrade_reason;
   string why_not_top_rank_ready;
   string allowed_style;
   string review_posture;
   string readiness_reason_summary;
   string blocked_by_summary;
   string next_revisit_trigger;
   string path_stage_posture;
   string expiry_hint;
   string readiness_notes;
  };

struct ASC_L6_SemiAutoSurfacePacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   ASC_L6_ReadinessClass readiness_class;
   ASC_L6_DeployabilityClass deployability_class;
   ASC_L6_OpportunityStatus opportunity_status;
   ASC_L6_HorizonClass active_horizon;
   ASC_L6_FamilyCompetitionStatus competition_status;
   ASC_L6_GeometryValidity geometry_validity;
   ASC_L6_FamilyId strongest_family_now;
   ASC_L6_FamilyId strongest_alternate_family;
   string strongest_family_now_text;
   string strongest_alternate_family_text;
   string directional_posture;
   string deployability_class_text;
   string opportunity_status_text;
   string readiness_class_text;
   string allowed_style;
   string geometry_validity_posture;
   string geometry_primary_summary;
   string geometry_alternate_summary;
   string geometry_entry_path_summary;
   string geometry_invalidation_path_summary;
   string geometry_target_path_summary;
   string geometry_timebox_posture;
   string geometry_execution_burden_posture;
   string geometry_review_burden_posture;
   string geometry_timing_posture;
   string geometry_reason_summary;
   string geometry_blocker_summary;
   string primary_blocker;
   string path_stage_posture;
   string expiry_hint;
   string revisit_trigger_summary;
   string family_confidence_posture;
   string lineage_workbench_ref;
   string lineage_normalized_context_ref;
   string lineage_mtf_posture_ref;
   string lineage_geometry_ref;
   string lineage_readiness_ref;
   string operator_surface_summary;
   string preserve_revisit_summary;
   string section_lineage_summary;
   string surface_notes;
  };



struct ASC_L6_MaturityPacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   string maturity_state;
   string maturity_reason_summary;
   string maturity_blocker_summary;
   string maturity_promotion_condition;
   string maturity_demotion_condition;
   string maturity_boundary_note;
   string trigger_family_state;
   string trigger_canon_note;
   string maturity_notes;
  };

struct ASC_L6_ReviewSnapshotPacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   bool snapshot_available;
   datetime review_timestamp_utc;
   string review_timestamp_text;
   string review_revision_context;
   string primary_family;
   string alternate_family;
   string deployability_class;
   string readiness_class;
   string stage_posture;
   string geometry_posture;
   string expiry_hint;
   string top_blocker;
   string downgrade_reason;
  };

struct ASC_L6_HandoffPacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   bool packet_valid;
   bool packet_lawful;
   bool handoff_available;
   bool requires_trigger_confirmation;
   bool requires_patience_review;
   datetime review_timestamp_utc;
   string review_timestamp_text;
   string review_revision_context;
   string packet_ref;
   string symbol;
   string canonical_symbol;
   string primary_family;
   string alternate_family;
   string stage_posture;
   string deployability_class;
   string readiness_class;
   string geometry_validity_posture;
   string horizon_class;
   string allowed_style;
   string expiry_hint;
   string primary_blocker;
   string downgrade_reason;
   string trigger_family_description;
   string entry_zone_family_description;
   string invalidation_zone_family_description;
   string target_zone_family_description;
   string review_posture;
   string execution_burden_posture;
   string timebox_posture;
   string confirmation_burden;
   string safety_boundary_state;
   string safety_boundary_note;
   string handoff_availability_state;
   string handoff_reason_summary;
   string handoff_notes;
  };

struct ASC_L6_ReviewDeltaPacket
  {
   bool prior_review_available;
   string prior_review_availability_note;
   string previous_primary_family;
   string current_primary_family;
   string previous_alternate_family;
   string current_alternate_family;
   string primary_delta;
   string alternate_delta;
   string stage_delta;
   string deployability_delta;
   string readiness_delta;
   string geometry_delta;
   string blocker_delta;
   string expiry_pressure_delta;
   string lifecycle_delta;
   string self_audit_classification;
   string self_audit_summary;
  };

struct ASC_L6_TraderChatHandoffPacket
  {
   ASC_L6_LineageStamp lineage;
   ASC_L6_AvailabilityStamp availability;
   ASC_L6_ReadinessClass readiness_class;
   ASC_L6_OpportunityStatus opportunity_status;
   string trader_chat_summary;
   string trader_chat_constraints;
   string trader_chat_missing_context;
   string handoff_notes;
  };

#endif
