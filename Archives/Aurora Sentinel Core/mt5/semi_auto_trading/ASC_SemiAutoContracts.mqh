#ifndef __ASC_SEMI_AUTO_CONTRACTS_MQH__
#define __ASC_SEMI_AUTO_CONTRACTS_MQH__

enum ASC_L6_DeployabilityClass
  {
   ASC_L6_DEPLOYABLE = 0,
   ASC_L6_DEPLOYABLE_DEGRADED,
   ASC_L6_WATCH_ONLY,
   ASC_L6_NOT_DEPLOYABLE,
   ASC_L6_UNKNOWN_DEPLOYABILITY
  };

enum ASC_L6_OpportunityStatus
  {
   ASC_L6_OPPORTUNITY_ELIGIBLE = 0,
   ASC_L6_OPPORTUNITY_ELIGIBLE_DEGRADED,
   ASC_L6_OPPORTUNITY_OBSERVE_ONLY,
   ASC_L6_OPPORTUNITY_EXECUTION_INVALID,
   ASC_L6_OPPORTUNITY_STRUCTURE_INVALID
  };

enum ASC_L6_HorizonClass
  {
   ASC_L6_H1_FAST_INTRADAY = 0,
   ASC_L6_H2_STANDARD_INTRADAY,
   ASC_L6_H3_WIDE_INTRADAY,
   ASC_L6_HORIZON_UNSUITABLE,
   ASC_L6_HORIZON_UNKNOWN
  };

enum ASC_L6_GeometryValidity
  {
   ASC_L6_GEOMETRY_VALID = 0,
   ASC_L6_GEOMETRY_DEGRADED,
   ASC_L6_GEOMETRY_INVALID,
   ASC_L6_GEOMETRY_UNRESOLVED
  };

enum ASC_L6_FamilyCompetitionStatus
  {
   ASC_L6_CLEAR_PRIMARY = 0,
   ASC_L6_CONTESTED_PRIMARY,
   ASC_L6_MULTIPLE_LIVE,
   ASC_L6_DEFERRED_CLASSIFICATION,
   ASC_L6_NO_VALID_FAMILY,
   ASC_L6_INVALID_COMPETITION_INPUT
  };

enum ASC_L6_ReadinessClass
  {
   ASC_L6_READINESS_READY = 0,
   ASC_L6_READINESS_READY_DEGRADED,
   ASC_L6_READINESS_CONDITIONAL,
   ASC_L6_READINESS_OBSERVE,
   ASC_L6_READINESS_BLOCKED,
   ASC_L6_READINESS_UNKNOWN
  };

enum ASC_L6_MtfConflictClass
  {
   ASC_L6_MTF_ALIGNED = 0,
   ASC_L6_MTF_FRICTION,
   ASC_L6_MTF_COUNTERTREND_ALLOWED,
   ASC_L6_MTF_REVERSAL_RISK_BUILDING,
   ASC_L6_MTF_HARD_CONFLICT
  };

enum ASC_L6_PatternLaneAvailability
  {
   ASC_L6_PATTERN_LANE_UNAVAILABLE = 0,
   ASC_L6_PATTERN_LANE_PREPARED,
   ASC_L6_PATTERN_LANE_ACTIVE_DEEP_ONLY
  };

enum ASC_L6_PatternCandidateStatus
  {
   ASC_L6_PATTERN_NONE = 0,
   ASC_L6_PATTERN_CANDIDATE_UNAVAILABLE,
   ASC_L6_PATTERN_EXPLORATORY_ONLY,
   ASC_L6_PATTERN_GEOMETRY_ALIGNED,
   ASC_L6_PATTERN_CONFIRMATION_PENDING,
   ASC_L6_PATTERN_INVALIDATED,
   ASC_L6_PATTERN_PRESERVED_FOR_REVIEW
  };

enum ASC_L6_PatternConfidencePosture
  {
   ASC_L6_PATTERN_CONFIDENCE_NONE = 0,
   ASC_L6_PATTERN_CONFIDENCE_THIN,
   ASC_L6_PATTERN_CONFIDENCE_BOUNDED,
   ASC_L6_PATTERN_CONFIDENCE_DEFERRED
  };

enum ASC_L6_PatternFamilyType
  {
   ASC_L6_PATTERN_FAMILY_NONE = 0,
   ASC_L6_PATTERN_FAMILY_HARMONIC_LIKE_REVERSAL,
   ASC_L6_PATTERN_FAMILY_HARMONIC_LIKE_CONTINUATION,
   ASC_L6_PATTERN_FAMILY_BALANCED_ROTATION,
   ASC_L6_PATTERN_FAMILY_EXTENSION_RECLAIM,
   ASC_L6_PATTERN_FAMILY_BOUNDED_RECLAIM_REVERSAL
  };

enum ASC_L6_FamilyId
  {
   ASC_L6_FAMILY_UNKNOWN = 0,
   ASC_L6_FAMILY_CONTINUATION,
   ASC_L6_FAMILY_REVERSAL,
   ASC_L6_FAMILY_RECLAIM,
   ASC_L6_FAMILY_FAILED_BREAK,
   ASC_L6_FAMILY_BALANCE_ROTATION,
   ASC_L6_FAMILY_BREAKOUT_EXPANSION
  };

string ASC_L6DeployabilityClassToText(const ASC_L6_DeployabilityClass value);
string ASC_L6OpportunityStatusToText(const ASC_L6_OpportunityStatus value);
string ASC_L6HorizonClassToText(const ASC_L6_HorizonClass value);
string ASC_L6GeometryValidityToText(const ASC_L6_GeometryValidity value);
string ASC_L6FamilyCompetitionStatusToText(const ASC_L6_FamilyCompetitionStatus value);
string ASC_L6ReadinessClassToText(const ASC_L6_ReadinessClass value);
string ASC_L6MtfConflictClassToText(const ASC_L6_MtfConflictClass value);
string ASC_L6PatternLaneAvailabilityToText(const ASC_L6_PatternLaneAvailability value);
string ASC_L6PatternCandidateStatusToText(const ASC_L6_PatternCandidateStatus value);
string ASC_L6PatternConfidencePostureToText(const ASC_L6_PatternConfidencePosture value);
string ASC_L6PatternFamilyTypeToText(const ASC_L6_PatternFamilyType value);
string ASC_L6FamilyIdToText(const ASC_L6_FamilyId value);

string ASC_L6DeployabilityClassToText(const ASC_L6_DeployabilityClass value)
  {
   switch(value)
     {
      case ASC_L6_DEPLOYABLE:             return "deployable";
      case ASC_L6_DEPLOYABLE_DEGRADED:    return "deployable_degraded";
      case ASC_L6_WATCH_ONLY:             return "watch_only";
      case ASC_L6_NOT_DEPLOYABLE:         return "not_deployable";
      case ASC_L6_UNKNOWN_DEPLOYABILITY:  return "unknown_deployability";
     }
   return "unknown_deployability";
  }

string ASC_L6OpportunityStatusToText(const ASC_L6_OpportunityStatus value)
  {
   switch(value)
     {
      case ASC_L6_OPPORTUNITY_ELIGIBLE:            return "eligible";
      case ASC_L6_OPPORTUNITY_ELIGIBLE_DEGRADED:   return "eligible_degraded";
      case ASC_L6_OPPORTUNITY_OBSERVE_ONLY:        return "observe_only";
      case ASC_L6_OPPORTUNITY_EXECUTION_INVALID:   return "execution_invalid";
      case ASC_L6_OPPORTUNITY_STRUCTURE_INVALID:   return "structure_invalid";
     }
   return "observe_only";
  }

string ASC_L6HorizonClassToText(const ASC_L6_HorizonClass value)
  {
   switch(value)
     {
      case ASC_L6_H1_FAST_INTRADAY:   return "h1_fast_intraday";
      case ASC_L6_H2_STANDARD_INTRADAY:return "h2_standard_intraday";
      case ASC_L6_H3_WIDE_INTRADAY:   return "h3_wide_intraday";
      case ASC_L6_HORIZON_UNSUITABLE: return "horizon_unsuitable";
      case ASC_L6_HORIZON_UNKNOWN:    return "horizon_unknown";
     }
   return "horizon_unknown";
  }

string ASC_L6GeometryValidityToText(const ASC_L6_GeometryValidity value)
  {
   switch(value)
     {
      case ASC_L6_GEOMETRY_VALID:       return "geometry_valid";
      case ASC_L6_GEOMETRY_DEGRADED:    return "geometry_degraded";
      case ASC_L6_GEOMETRY_INVALID:     return "geometry_invalid";
      case ASC_L6_GEOMETRY_UNRESOLVED:  return "geometry_unresolved";
     }
   return "geometry_unresolved";
  }

string ASC_L6FamilyCompetitionStatusToText(const ASC_L6_FamilyCompetitionStatus value)
  {
   switch(value)
     {
      case ASC_L6_CLEAR_PRIMARY:            return "clear_primary";
      case ASC_L6_CONTESTED_PRIMARY:        return "contested_primary";
      case ASC_L6_MULTIPLE_LIVE:            return "multiple_live";
      case ASC_L6_DEFERRED_CLASSIFICATION:  return "deferred_classification";
      case ASC_L6_NO_VALID_FAMILY:          return "no_valid_family";
      case ASC_L6_INVALID_COMPETITION_INPUT:return "invalid_competition_input";
     }
   return "invalid_competition_input";
  }

string ASC_L6ReadinessClassToText(const ASC_L6_ReadinessClass value)
  {
   switch(value)
     {
      case ASC_L6_READINESS_READY:           return "ready";
      case ASC_L6_READINESS_READY_DEGRADED:  return "ready_degraded";
      case ASC_L6_READINESS_CONDITIONAL:     return "conditional";
      case ASC_L6_READINESS_OBSERVE:         return "observe";
      case ASC_L6_READINESS_BLOCKED:         return "blocked";
      case ASC_L6_READINESS_UNKNOWN:         return "unknown";
     }
   return "unknown";
  }

string ASC_L6MtfConflictClassToText(const ASC_L6_MtfConflictClass value)
  {
   switch(value)
     {
      case ASC_L6_MTF_ALIGNED:                 return "aligned";
      case ASC_L6_MTF_FRICTION:                return "friction";
      case ASC_L6_MTF_COUNTERTREND_ALLOWED:    return "countertrend_allowed";
      case ASC_L6_MTF_REVERSAL_RISK_BUILDING:  return "reversal_risk_building";
      case ASC_L6_MTF_HARD_CONFLICT:           return "hard_conflict";
     }
   return "hard_conflict";
  }

string ASC_L6PatternLaneAvailabilityToText(const ASC_L6_PatternLaneAvailability value)
  {
   switch(value)
     {
      case ASC_L6_PATTERN_LANE_UNAVAILABLE:       return "pattern_lane_unavailable";
      case ASC_L6_PATTERN_LANE_PREPARED:          return "pattern_lane_prepared";
      case ASC_L6_PATTERN_LANE_ACTIVE_DEEP_ONLY:  return "pattern_lane_active_deep_only";
     }
   return "pattern_lane_unavailable";
  }

string ASC_L6PatternCandidateStatusToText(const ASC_L6_PatternCandidateStatus value)
  {
   switch(value)
     {
      case ASC_L6_PATTERN_NONE:                    return "no_candidate";
      case ASC_L6_PATTERN_CANDIDATE_UNAVAILABLE:   return "candidate_unavailable";
      case ASC_L6_PATTERN_EXPLORATORY_ONLY:        return "candidate_exploratory_only";
      case ASC_L6_PATTERN_GEOMETRY_ALIGNED:        return "candidate_geometry_aligned";
      case ASC_L6_PATTERN_CONFIRMATION_PENDING:    return "candidate_confirmation_pending";
      case ASC_L6_PATTERN_INVALIDATED:             return "candidate_invalidated";
      case ASC_L6_PATTERN_PRESERVED_FOR_REVIEW:    return "candidate_preserved_for_review";
     }
   return "candidate_unavailable";
  }

string ASC_L6PatternConfidencePostureToText(const ASC_L6_PatternConfidencePosture value)
  {
   switch(value)
     {
      case ASC_L6_PATTERN_CONFIDENCE_NONE:      return "confidence_none";
      case ASC_L6_PATTERN_CONFIDENCE_THIN:      return "confidence_thin";
      case ASC_L6_PATTERN_CONFIDENCE_BOUNDED:   return "confidence_bounded";
      case ASC_L6_PATTERN_CONFIDENCE_DEFERRED:  return "confidence_deferred";
     }
   return "confidence_deferred";
  }

string ASC_L6PatternFamilyTypeToText(const ASC_L6_PatternFamilyType value)
  {
   switch(value)
     {
      case ASC_L6_PATTERN_FAMILY_NONE:                      return "pattern_family_none";
      case ASC_L6_PATTERN_FAMILY_HARMONIC_LIKE_REVERSAL:   return "harmonic_like_reversal_candidate";
      case ASC_L6_PATTERN_FAMILY_HARMONIC_LIKE_CONTINUATION:return "harmonic_like_continuation_candidate";
      case ASC_L6_PATTERN_FAMILY_BALANCED_ROTATION:         return "balanced_rotation_candidate";
      case ASC_L6_PATTERN_FAMILY_EXTENSION_RECLAIM:         return "extension_reclaim_candidate";
      case ASC_L6_PATTERN_FAMILY_BOUNDED_RECLAIM_REVERSAL:  return "bounded_reclaim_reversal_candidate";
     }
   return "pattern_family_none";
  }

string ASC_L6FamilyIdToText(const ASC_L6_FamilyId value)
  {
   switch(value)
     {
      case ASC_L6_FAMILY_CONTINUATION:      return "continuation";
      case ASC_L6_FAMILY_REVERSAL:          return "reversal";
      case ASC_L6_FAMILY_RECLAIM:           return "reclaim";
      case ASC_L6_FAMILY_FAILED_BREAK:      return "failed_break";
      case ASC_L6_FAMILY_BALANCE_ROTATION:  return "balance_rotation";
      case ASC_L6_FAMILY_BREAKOUT_EXPANSION:return "breakout_expansion";
      case ASC_L6_FAMILY_UNKNOWN:           return "unknown";
     }
   return "unknown";
  }

#endif
