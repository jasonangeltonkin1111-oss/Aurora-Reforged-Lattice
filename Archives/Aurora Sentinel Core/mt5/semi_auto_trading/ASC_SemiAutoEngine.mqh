#ifndef __ASC_SEMI_AUTO_ENGINE_MQH__
#define __ASC_SEMI_AUTO_ENGINE_MQH__

#include "ASC_SemiAutoState.mqh"
#include "family_registry/ASC_SemiAutoFamilyRegistry.mqh"
#include "mtf/ASC_SemiAutoMtfContracts.mqh"
#include "competition/ASC_SemiAutoCompetitionContracts.mqh"
#include "geometry/ASC_SemiAutoGeometryContracts.mqh"
#include "readiness/ASC_SemiAutoReadinessContracts.mqh"
#include "persistence/ASC_SemiAutoPersistenceContracts.mqh"

bool ASC_SemiAutoEngineIsDormant()
  {
   return true;
  }

void ASC_InitializeSemiAutoScaffold(ASC_SemiAutoState &state)
  {
   ASC_ResetSemiAutoState(state);
  }

string ASC_SemiAutoEnginePacketOrderNote()
  {
   return "layer5_workbench -> normalized_context -> mtf_posture -> readiness -> surface";
  }

string ASC_L6_DefaultOrValue(const string value,const string fallback)
  {
   return (value == "" ? fallback : value);
  }

string ASC_L6LowercaseCopy(const string value)
  {
   string lowered = value;
   StringToLower(lowered);
   return lowered;
  }


string ASC_L6ExtractLabeledLineValue(const string text,const string label)
  {
   if(StringLen(text) <= 0 || StringLen(label) <= 0)
      return "";

   int start = StringFind(text, label);
   if(start < 0)
      return "";

   start += StringLen(label);
   int end = StringFind(text, "\n", start);
   if(end < 0)
      end = StringLen(text);

   string value = StringSubstr(text, start, end - start);
   while(StringLen(value) > 0 && (StringGetCharacter(value, 0) == ' ' || StringGetCharacter(value, 0) == '\t'))
      value = StringSubstr(value, 1);
   while(StringLen(value) > 0)
     {
      int last = StringLen(value) - 1;
      ushort ch = (ushort)StringGetCharacter(value, last);
      if(ch == ' ' || ch == '\t' || ch == '\r')
         value = StringSubstr(value, 0, last);
      else
         break;
     }
   return value;
  }

bool ASC_L6TextIsUnresolved(const string value)
  {
   string lowered = ASC_L6LowercaseCopy(ASC_L6_DefaultOrValue(value, ""));
   return (StringLen(lowered) <= 0
           || lowered == "none"
           || lowered == "n/a"
           || lowered == "unavailable"
           || lowered == "pending / unresolved"
           || lowered == "unresolved"
           || lowered == "unknown"
           || lowered == "not available");
  }

int ASC_L6RankLifecycleState(const string value)
  {
   string lowered = ASC_L6LowercaseCopy(value);
   if(StringFind(lowered, "ready") >= 0 || StringFind(lowered, "mature") >= 0)
      return 4;
   if(StringFind(lowered, "confirm") >= 0)
      return 3;
   if(StringFind(lowered, "contested") >= 0 || StringFind(lowered, "develop") >= 0)
      return 2;
   if(StringFind(lowered, "review") >= 0 || StringFind(lowered, "pending") >= 0)
      return 1;
   if(StringFind(lowered, "invalid") >= 0 || StringFind(lowered, "blocked") >= 0 || StringFind(lowered, "expired") >= 0)
      return -1;
   return 0;
  }

int ASC_L6RankDeployabilityState(const string value)
  {
   string lowered = ASC_L6LowercaseCopy(value);
   if(StringFind(lowered, "deployable now") >= 0 || lowered == "deployable")
      return 4;
   if(StringFind(lowered, "deployable if trigger confirms") >= 0)
      return 3;
   if(StringFind(lowered, "degraded") >= 0 || StringFind(lowered, "constrained") >= 0)
      return 2;
   if(StringFind(lowered, "watch") >= 0 || StringFind(lowered, "review") >= 0)
      return 1;
   if(StringFind(lowered, "not deployable") >= 0)
      return 0;
   return 0;
  }

int ASC_L6RankReadinessState(const string value)
  {
   string lowered = ASC_L6LowercaseCopy(value);
   if(StringFind(lowered, "ready") >= 0 && StringFind(lowered, "degraded") < 0)
      return 4;
   if(StringFind(lowered, "near") >= 0)
      return 3;
   if(StringFind(lowered, "contested") >= 0 || StringFind(lowered, "conditional") >= 0)
      return 2;
   if(StringFind(lowered, "observe") >= 0 || StringFind(lowered, "review") >= 0)
      return 1;
   if(StringFind(lowered, "blocked") >= 0 || StringFind(lowered, "invalid") >= 0)
      return 0;
   return 0;
  }

int ASC_L6RankGeometryState(const string value)
  {
   string lowered = ASC_L6LowercaseCopy(value);
   if(StringFind(lowered, "valid") >= 0 && StringFind(lowered, "degraded") < 0)
      return 3;
   if(StringFind(lowered, "degraded") >= 0)
      return 2;
   if(StringFind(lowered, "unresolved") >= 0)
      return 1;
   if(StringFind(lowered, "invalid") >= 0 || StringFind(lowered, "blocked") >= 0)
      return 0;
   return 1;
  }

int ASC_L6RankExpiryPressure(const string value)
  {
   string lowered = ASC_L6LowercaseCopy(value);
   if(StringFind(lowered, "expired") >= 0 || StringFind(lowered, "invalidated") >= 0)
      return 3;
   if(StringFind(lowered, "contested") >= 0 || StringFind(lowered, "deepens") >= 0 || StringFind(lowered, "pressure") >= 0)
      return 2;
   if(StringFind(lowered, "pending") >= 0 || StringFind(lowered, "review") >= 0)
      return 1;
   return 0;
  }

string ASC_L6ResolveStateDelta(const int prior_rank,const int current_rank)
  {
   if(current_rank > prior_rank)
      return "improved";
   if(current_rank < prior_rank)
      return "degraded";
   return "unchanged";
  }

bool ASC_BuildL6ReviewSnapshotPacket(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                     const ASC_L6_ReadinessPacket &readiness_packet,
                                     const ASC_L6_SemiAutoSurfacePacket &surface_packet,
                                     ASC_L6_ReviewSnapshotPacket &snapshot_packet)
  {
   snapshot_packet.lineage = workbench_packet.lineage;
   snapshot_packet.availability = workbench_packet.availability;
   snapshot_packet.snapshot_available = (workbench_packet.packet_valid && workbench_packet.packet_lawful);
   snapshot_packet.review_timestamp_utc = workbench_packet.source_build_utc;
   snapshot_packet.review_timestamp_text = IntegerToString((int)workbench_packet.source_build_utc);
   snapshot_packet.review_revision_context = ASC_L6_DefaultOrValue(workbench_packet.source_result_revision, "unavailable");
   snapshot_packet.primary_family = ASC_L6_DefaultOrValue(surface_packet.strongest_family_now_text, ASC_L6_DefaultOrValue(workbench_packet.siam_primary_fit, "unresolved"));
   snapshot_packet.alternate_family = ASC_L6_DefaultOrValue(surface_packet.strongest_alternate_family_text, ASC_L6_DefaultOrValue(workbench_packet.siam_secondary_fit, "unresolved"));
   snapshot_packet.deployability_class = ASC_L6_DefaultOrValue(surface_packet.deployability_class_text, "unavailable");
   snapshot_packet.readiness_class = ASC_L6_DefaultOrValue(surface_packet.readiness_class_text, "unavailable");
   snapshot_packet.stage_posture = ASC_L6_DefaultOrValue(surface_packet.path_stage_posture, "unavailable");
   snapshot_packet.geometry_posture = ASC_L6_DefaultOrValue(surface_packet.geometry_validity_posture, "unavailable");
   snapshot_packet.expiry_hint = ASC_L6_DefaultOrValue(surface_packet.expiry_hint, "unavailable");
   snapshot_packet.top_blocker = ASC_L6_DefaultOrValue(readiness_packet.primary_blocker, ASC_L6_DefaultOrValue(surface_packet.primary_blocker, "none"));
   snapshot_packet.downgrade_reason = ASC_L6_DefaultOrValue(readiness_packet.downgrade_reason, "none");
   return snapshot_packet.snapshot_available;
  }

bool ASC_RestoreL6ReviewSnapshotFromPayload(const string prior_payload,
                                            ASC_L6_ReviewSnapshotPacket &snapshot_packet)
  {
   ZeroMemory(snapshot_packet);
   snapshot_packet.snapshot_available = false;
   if(StringLen(prior_payload) <= 0)
      return false;

   snapshot_packet.review_timestamp_text = ASC_L6ExtractLabeledLineValue(prior_payload, "Review Timestamp:");
   snapshot_packet.review_revision_context = ASC_L6ExtractLabeledLineValue(prior_payload, "Review Revision:");
   snapshot_packet.primary_family = ASC_L6ExtractLabeledLineValue(prior_payload, "Primary Family At Review:");
   snapshot_packet.alternate_family = ASC_L6ExtractLabeledLineValue(prior_payload, "Alternate Family At Review:");
   snapshot_packet.deployability_class = ASC_L6ExtractLabeledLineValue(prior_payload, "Deployability At Review:");
   snapshot_packet.readiness_class = ASC_L6ExtractLabeledLineValue(prior_payload, "Readiness At Review:");
   snapshot_packet.stage_posture = ASC_L6ExtractLabeledLineValue(prior_payload, "Stage At Review:");
   snapshot_packet.geometry_posture = ASC_L6ExtractLabeledLineValue(prior_payload, "Geometry At Review:");
   snapshot_packet.expiry_hint = ASC_L6ExtractLabeledLineValue(prior_payload, "Expiry Hint At Review:");
   snapshot_packet.top_blocker = ASC_L6ExtractLabeledLineValue(prior_payload, "Top Blocker At Review:");
   snapshot_packet.downgrade_reason = ASC_L6ExtractLabeledLineValue(prior_payload, "Downgrade Reason At Review:");

   snapshot_packet.snapshot_available = !(ASC_L6TextIsUnresolved(snapshot_packet.primary_family)
                                          && ASC_L6TextIsUnresolved(snapshot_packet.deployability_class)
                                          && ASC_L6TextIsUnresolved(snapshot_packet.readiness_class)
                                          && ASC_L6TextIsUnresolved(snapshot_packet.stage_posture));
   return snapshot_packet.snapshot_available;
  }

bool ASC_BuildL6ReviewDeltaPacket(const ASC_L6_ReviewSnapshotPacket &current_snapshot,
                                  const ASC_L6_ReviewSnapshotPacket &prior_snapshot,
                                  ASC_L6_ReviewDeltaPacket &delta_packet)
  {
   ZeroMemory(delta_packet);
   delta_packet.prior_review_available = prior_snapshot.snapshot_available;
   delta_packet.prior_review_availability_note = (prior_snapshot.snapshot_available
                                                  ? "Prior review snapshot is available from the last selected-symbol dossier."
                                                  : "No prior review snapshot is available yet.");
   delta_packet.previous_primary_family = (prior_snapshot.snapshot_available ? prior_snapshot.primary_family : "Unavailable");
   delta_packet.current_primary_family = current_snapshot.primary_family;
   delta_packet.previous_alternate_family = (prior_snapshot.snapshot_available ? prior_snapshot.alternate_family : "Unavailable");
   delta_packet.current_alternate_family = current_snapshot.alternate_family;

   if(!prior_snapshot.snapshot_available)
     {
      delta_packet.primary_delta = "unavailable";
      delta_packet.alternate_delta = "unavailable";
      delta_packet.stage_delta = "unavailable";
      delta_packet.deployability_delta = "unavailable";
      delta_packet.readiness_delta = "unavailable";
      delta_packet.geometry_delta = "unavailable";
      delta_packet.blocker_delta = "unavailable";
      delta_packet.expiry_pressure_delta = "unavailable";
      delta_packet.lifecycle_delta = "Review still pending";
      delta_packet.self_audit_classification = "no_prior_review_available";
      delta_packet.self_audit_summary = "No prior review available; current selected-symbol review lane starts here without pretending to know historical outcomes.";
      return true;
     }

   delta_packet.primary_delta = (ASC_L6LowercaseCopy(prior_snapshot.primary_family) == ASC_L6LowercaseCopy(current_snapshot.primary_family)
                                 ? "unchanged"
                                 : "changed");

   if(ASC_L6LowercaseCopy(prior_snapshot.alternate_family) == ASC_L6LowercaseCopy(current_snapshot.alternate_family))
      delta_packet.alternate_delta = "unchanged";
   else if(ASC_L6TextIsUnresolved(prior_snapshot.alternate_family) && !ASC_L6TextIsUnresolved(current_snapshot.alternate_family))
      delta_packet.alternate_delta = "strengthened";
   else if(!ASC_L6TextIsUnresolved(prior_snapshot.alternate_family) && ASC_L6TextIsUnresolved(current_snapshot.alternate_family))
      delta_packet.alternate_delta = "weakened";
   else if(ASC_L6LowercaseCopy(current_snapshot.alternate_family) == ASC_L6LowercaseCopy(prior_snapshot.primary_family))
      delta_packet.alternate_delta = "gaining_ground";
   else
      delta_packet.alternate_delta = "replaced";

   delta_packet.stage_delta = ASC_L6ResolveStateDelta(ASC_L6RankLifecycleState(prior_snapshot.stage_posture),
                                                      ASC_L6RankLifecycleState(current_snapshot.stage_posture));
   delta_packet.deployability_delta = ASC_L6ResolveStateDelta(ASC_L6RankDeployabilityState(prior_snapshot.deployability_class),
                                                              ASC_L6RankDeployabilityState(current_snapshot.deployability_class));
   delta_packet.readiness_delta = ASC_L6ResolveStateDelta(ASC_L6RankReadinessState(prior_snapshot.readiness_class),
                                                          ASC_L6RankReadinessState(current_snapshot.readiness_class));
   delta_packet.geometry_delta = ASC_L6ResolveStateDelta(ASC_L6RankGeometryState(prior_snapshot.geometry_posture),
                                                         ASC_L6RankGeometryState(current_snapshot.geometry_posture));

   if(ASC_L6TextIsUnresolved(prior_snapshot.top_blocker) && ASC_L6TextIsUnresolved(current_snapshot.top_blocker))
      delta_packet.blocker_delta = "unchanged";
   else if(!ASC_L6TextIsUnresolved(prior_snapshot.top_blocker) && ASC_L6TextIsUnresolved(current_snapshot.top_blocker))
      delta_packet.blocker_delta = "cleared";
   else if(ASC_L6LowercaseCopy(prior_snapshot.top_blocker) == ASC_L6LowercaseCopy(current_snapshot.top_blocker))
      delta_packet.blocker_delta = "persisted";
   else if(ASC_L6TextIsUnresolved(prior_snapshot.top_blocker) && !ASC_L6TextIsUnresolved(current_snapshot.top_blocker))
      delta_packet.blocker_delta = "worsened";
   else
      delta_packet.blocker_delta = "worsened";

   delta_packet.expiry_pressure_delta = ASC_L6ResolveStateDelta(ASC_L6RankExpiryPressure(prior_snapshot.expiry_hint),
                                                                ASC_L6RankExpiryPressure(current_snapshot.expiry_hint));

   delta_packet.lifecycle_delta = StringFormat("stage %s | deployability %s | readiness %s",
                                               delta_packet.stage_delta,
                                               delta_packet.deployability_delta,
                                               delta_packet.readiness_delta);

   if(delta_packet.primary_delta == "changed" && (delta_packet.alternate_delta == "gaining_ground" || delta_packet.alternate_delta == "replaced"))
     {
      delta_packet.self_audit_classification = "alternate_gaining_ground";
      delta_packet.self_audit_summary = "Alternate gaining ground: the previous thesis no longer stands unchanged and the preserved alternate is now explaining more of the current state.";
     }
   else if(delta_packet.geometry_delta == "improved" && delta_packet.blocker_delta == "cleared"
           && delta_packet.deployability_delta != "degraded" && delta_packet.readiness_delta != "degraded")
     {
      delta_packet.self_audit_classification = "thesis_holding";
      delta_packet.self_audit_summary = "Thesis holding: geometry improved, the blocker cleared, and the path did not degrade on deployability/readiness.";
     }
   else if(delta_packet.geometry_delta == "degraded" || delta_packet.deployability_delta == "degraded" || delta_packet.readiness_delta == "degraded")
     {
      delta_packet.self_audit_classification = "thesis_degrading";
      delta_packet.self_audit_summary = "Thesis degrading: the current selected-symbol path weakened on geometry, deployability, or readiness versus the last review snapshot.";
     }
   else if(delta_packet.blocker_delta == "persisted")
     {
      delta_packet.self_audit_classification = "blocker_persists";
      delta_packet.self_audit_summary = "Blocker persists: the same top blocker remains active since the last selected-symbol review snapshot.";
     }
   else if(delta_packet.expiry_pressure_delta == "degraded")
     {
      delta_packet.self_audit_classification = "invalidation_pressure_rising";
      delta_packet.self_audit_summary = "Invalidation pressure rising: expiry pressure increased even without pretending to know execution outcomes or PnL.";
     }
   else
     {
      delta_packet.self_audit_classification = "review_still_pending";
      delta_packet.self_audit_summary = "Review still pending: the thesis is neither clearly strengthened nor cleanly invalidated by the bounded review delta.";
     }

   return true;
  }

bool ASC_L6_TextSuggestsMissing(const string value)
  {
   string text = ASC_L6LowercaseCopy(value);
   return (StringFind(text, "unavailable") >= 0
           || StringFind(text, "missing") >= 0
           || StringFind(text, "pending") >= 0
           || StringFind(text, "not_run") >= 0);
  }

bool ASC_L6BiasIsBullish(const string bias)
  {
   string text = ASC_L6LowercaseCopy(bias);
   return (StringFind(text, "bullish") >= 0 || StringFind(text, "up") >= 0);
  }

bool ASC_L6BiasIsBearish(const string bias)
  {
   string text = ASC_L6LowercaseCopy(bias);
   return (StringFind(text, "bearish") >= 0 || StringFind(text, "down") >= 0);
  }

bool ASC_L6BiasesOppose(const string a,const string b)
  {
   return ((ASC_L6BiasIsBullish(a) && ASC_L6BiasIsBearish(b))
           || (ASC_L6BiasIsBearish(a) && ASC_L6BiasIsBullish(b)));
  }

bool ASC_L6BiasesAlign(const string a,const string b)
  {
   return ((ASC_L6BiasIsBullish(a) && ASC_L6BiasIsBullish(b))
           || (ASC_L6BiasIsBearish(a) && ASC_L6BiasIsBearish(b)));
  }

string ASC_L6ResolveAllowedStyleHint(const ASC_Layer5WorkbenchPacket &workbench_packet)
  {
   bool scalp_ok = (workbench_packet.scalp_tradable == "yes");
   bool intraday_ok = (workbench_packet.intraday_tradable == "yes");
   if(scalp_ok && intraday_ok)
      return "scalp_and_intraday_allowed";
   if(scalp_ok)
      return "scalp_allowed";
   if(intraday_ok)
      return "intraday_allowed";
   return "review_only";
  }

string ASC_L6ResolveDeployabilityDetailText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                            const ASC_L6_NormalizedContextPacket &normalized_packet,
                                            const ASC_L6_MtfPosturePacket &mtf_packet,
                                            const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                            const ASC_L6_ReadinessPacket &readiness_packet)
  {
   bool tradable = (normalized_packet.scalp_tradability == "yes" || normalized_packet.intraday_tradability == "yes");
   bool alternate_live = (geometry_packet.alternate_candidate_supported && workbench_packet.siam_secondary_fit != "");
   bool contested = (mtf_packet.conflict_class == ASC_L6_MTF_FRICTION || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING);

   if(readiness_packet.deployability_class == ASC_L6_NOT_DEPLOYABLE)
      return (alternate_live ? "review_only_primary_invalid_alternate_preserved" : "not_deployable_structure_invalid");
   if(readiness_packet.deployability_class == ASC_L6_UNKNOWN_DEPLOYABILITY)
      return "review_only_upstream_packet_not_lawful";
   if(normalized_packet.availability.missing_surface || ASC_L6_TextSuggestsMissing(normalized_packet.missing_surface_notes))
      return "review_only_waiting_for_support_carry";
   if(!tradable)
      return "review_only_broker_conditions_unconfirmed";
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
     {
      if(mtf_packet.conflict_class == ASC_L6_MTF_ALIGNED && workbench_packet.execution_score >= 60.0)
         return "deployable_if_trigger_confirms";
      return "deployable_but_patience_led";
     }
   if(readiness_packet.deployability_class == ASC_L6_DEPLOYABLE_DEGRADED)
     {
      if(contested)
         return "constrained_narrow_deployability";
      if(workbench_packet.move_freshness_score < 56.0 || workbench_packet.execution_score < 58.0)
         return "deployable_but_patience_led";
      return "deployable_with_review_burden";
     }
   if(readiness_packet.path_stage_posture == "active")
      return "deployable_now";
   if(readiness_packet.path_stage_posture == "confirmable")
      return "deployable_if_trigger_confirms";
   if(readiness_packet.path_stage_posture == "developing")
      return "deployable_but_patience_led";
   if(contested)
      return "constrained_narrow_deployability";
   return "deployable_now";
  }

string ASC_L6ResolveReadinessDetailText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                        const ASC_L6_NormalizedContextPacket &normalized_packet,
                                        const ASC_L6_MtfPosturePacket &mtf_packet,
                                        const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                        const ASC_L6_ReadinessPacket &readiness_packet)
  {
   bool contested = (mtf_packet.conflict_class == ASC_L6_MTF_FRICTION || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING);
   bool stale = (workbench_packet.move_freshness_score < 52.0);

   if(readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED)
      return ((geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID) ? "expired_or_invalid" : "blocked");
   if(readiness_packet.readiness_class == ASC_L6_READINESS_UNKNOWN)
      return "review_only";
   if(readiness_packet.readiness_class == ASC_L6_READINESS_OBSERVE)
      return "review_only";
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return ((mtf_packet.conflict_class == ASC_L6_MTF_ALIGNED) ? "confirm_first" : "patience_led");
   if(readiness_packet.readiness_class == ASC_L6_READINESS_READY_DEGRADED)
     {
      if(contested)
         return "contested";
      if(stale)
         return "patience_led";
      return "near_ready";
     }
   if(readiness_packet.path_stage_posture == "confirmable")
      return "confirm_first";
   if(readiness_packet.path_stage_posture == "developing")
      return "near_ready";
   if(contested)
      return "contested";
   return "ready_now";
  }

string ASC_L6ResolveStyleShapingText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                     const ASC_L6_NormalizedContextPacket &normalized_packet,
                                     const ASC_L6_MtfPosturePacket &mtf_packet,
                                     const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                     const ASC_L6_ReadinessPacket &readiness_packet)
  {
   bool scalp_ok = (normalized_packet.scalp_tradability == "yes");
   bool intraday_ok = (normalized_packet.intraday_tradability == "yes");
   bool pullback_soft = (workbench_packet.pullback_state == "developing" || workbench_packet.pullback_state == "shallow" || workbench_packet.pullback_state == "deep");
   bool contested = (mtf_packet.conflict_class == ASC_L6_MTF_FRICTION || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING);

   if(readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED)
      return ((scalp_ok || intraday_ok) ? "review_only_despite_tradable_broker_conditions" : "review_only");
   if(!scalp_ok && !intraday_ok)
      return "review_only";
   if(scalp_ok && intraday_ok)
     {
      if(readiness_packet.path_stage_posture == "active" && normalized_packet.horizon_class == ASC_L6_H1_FAST_INTRADAY)
         return "scalp_favored_intraday_allowed";
      if(normalized_packet.horizon_class == ASC_L6_H3_WIDE_INTRADAY)
         return pullback_soft ? "intraday_only_if_pullback_stabilizes" : "intraday_favored";
      if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
         return "mixed_but_patience_led";
      if(contested)
         return "scalp_only_if_trigger_confirms";
      return "mixed_but_patience_led";
     }
   if(scalp_ok)
      return (geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED || contested) ? "scalp_only_if_trigger_confirms" : "scalp_favored";
   if(intraday_ok)
      return pullback_soft ? "intraday_only_if_pullback_stabilizes" : "intraday_favored";
   return "review_only";
  }

string ASC_L6ResolveReviewPostureText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                      const ASC_L6_NormalizedContextPacket &normalized_packet,
                                      const ASC_L6_MtfPosturePacket &mtf_packet,
                                      const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                      const ASC_L6_ReadinessPacket &readiness_packet)
  {
   if(readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED)
      return "review_to_confirm_invalidation_or_alternate_takeover";
   if(normalized_packet.availability.missing_surface || ASC_L6_TextSuggestsMissing(normalized_packet.missing_surface_notes))
      return "review_after_selected_symbol_support_refresh";
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return "review_for_trigger_family_confirmation";
   if(mtf_packet.conflict_class == ASC_L6_MTF_HARD_CONFLICT)
      return "review_only_higher_timeframe_conflict";
   if(mtf_packet.conflict_class == ASC_L6_MTF_FRICTION || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING)
      return "review_with_mtf_conflict_and_patience";
   if(readiness_packet.path_stage_posture == "developing")
      return "review_until_path_matures";
   if(readiness_packet.path_stage_posture == "confirmable")
      return "review_for_clean_trigger_confirmation";
   return ASC_L6_DefaultOrValue(geometry_packet.review_burden_posture, "review_with_deep_and_board_context");
  }

string ASC_L6ResolveDowngradeReasonText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                        const ASC_L6_NormalizedContextPacket &normalized_packet,
                                        const ASC_L6_MtfPosturePacket &mtf_packet,
                                        const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                        const ASC_L6_ReadinessPacket &readiness_packet)
  {
   if(readiness_packet.readiness_class == ASC_L6_READINESS_UNKNOWN)
      return "selected_symbol_packet_not_lawful";
   if(normalized_packet.availability.missing_surface || ASC_L6_TextSuggestsMissing(normalized_packet.missing_surface_notes))
      return ASC_L6_DefaultOrValue(normalized_packet.missing_surface_notes, "selected_symbol_support_missing");
   if(readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED)
     {
      if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID)
         return ASC_L6_DefaultOrValue(geometry_packet.geometry_reason_summary, "geometry_invalid");
      return ASC_L6_DefaultOrValue(mtf_packet.conflict_reason_summary, "hard_mtf_conflict");
     }
   if((normalized_packet.scalp_tradability != "yes") && (normalized_packet.intraday_tradability != "yes"))
      return "broker_tradability_not_confirmed_for_allowed_styles";
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return ASC_L6_DefaultOrValue(geometry_packet.insufficiency_reason, "geometry_needs_cleaner_confirmation");
   if(mtf_packet.conflict_class == ASC_L6_MTF_FRICTION || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING)
      return ASC_L6_DefaultOrValue(mtf_packet.conflict_reason_summary, "mtf_friction_reduces_readiness");
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED)
      return ASC_L6_DefaultOrValue(geometry_packet.geometry_reason_summary, "geometry_is_degraded");
   if(ASC_L6_TextSuggestsMissing(normalized_packet.degraded_surface_notes))
      return ASC_L6_DefaultOrValue(normalized_packet.degraded_surface_notes, "selected_symbol_support_is_degraded");
   if(workbench_packet.move_freshness_score < 56.0)
      return "move_freshness_has_softened";
   return "none";
  }

string ASC_L6ResolveWhyNotTopRankReadyText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                           const ASC_L6_NormalizedContextPacket &normalized_packet,
                                           const ASC_L6_MtfPosturePacket &mtf_packet,
                                           const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                           const ASC_L6_ReadinessPacket &readiness_packet)
  {
   if(readiness_packet.readiness_class == ASC_L6_READINESS_READY && readiness_packet.path_stage_posture == "active")
      return "top_rank_readiness_not_owned_here";
   if(readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED)
      return "blocked_before_top_rank_readiness_can_be_considered";
   if(normalized_packet.availability.missing_surface || ASC_L6_TextSuggestsMissing(normalized_packet.missing_surface_notes))
      return "selected_symbol_support_is_not_complete_enough_yet";
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return "geometry_is_not_clean_enough_yet";
   if(mtf_packet.conflict_class == ASC_L6_MTF_FRICTION || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING)
      return "timeframe_alignment_still_contests_the_path";
   if(workbench_packet.execution_score < 60.0)
      return "execution_quality_is_not_clean_top_tier_yet";
   if(workbench_packet.move_freshness_score < 60.0)
      return "freshness_is_no_longer_clean_top_tier";
   return "top_rank_readiness_not_owned_here";
  }

ASC_L6_FamilyId ASC_L6FamilyFromFitName(const string fit_name)
  {
   string fit = ASC_L6LowercaseCopy(fit_name);
   if(fit == "pullback" || fit == "continuation" || fit == "trend_continuation")
      return ASC_L6_FAMILY_CONTINUATION;
   if(fit == "reversal")
      return ASC_L6_FAMILY_REVERSAL;
   if(fit == "reclaim")
      return ASC_L6_FAMILY_RECLAIM;
   if(fit == "failed_break" || fit == "fakeout")
      return ASC_L6_FAMILY_FAILED_BREAK;
   if(fit == "breakout")
      return ASC_L6_FAMILY_BREAKOUT_EXPANSION;
   if(fit == "range")
      return ASC_L6_FAMILY_BALANCE_ROTATION;
   return ASC_L6_FAMILY_UNKNOWN;
  }

ASC_L6_HorizonClass ASC_L6InferHorizonClass(const ASC_Layer5WorkbenchPacket &workbench_packet)
  {
   if(workbench_packet.intraday_tradable == "yes")
     {
      if(workbench_packet.move_age_score >= 68.0)
         return ASC_L6_H1_FAST_INTRADAY;
      if(workbench_packet.move_age_score >= 52.0)
         return ASC_L6_H2_STANDARD_INTRADAY;
      return ASC_L6_H3_WIDE_INTRADAY;
     }

   if(workbench_packet.scalp_tradable == "yes")
      return ASC_L6_H1_FAST_INTRADAY;

   if(workbench_packet.packet_valid && workbench_packet.packet_lawful)
      return ASC_L6_HORIZON_UNSUITABLE;

   return ASC_L6_HORIZON_UNKNOWN;
  }

string ASC_L6ResolveSupportContext(const ASC_Layer5WorkbenchPacket &workbench_packet)
  {
   string support = ASC_L6_DefaultOrValue(workbench_packet.source_context, "support_context_unavailable");
   if(workbench_packet.missing_surface_notes != "" && workbench_packet.missing_surface_notes != "none")
      support += " | missing=" + workbench_packet.missing_surface_notes;
   if(workbench_packet.degraded_surface_notes != "" && workbench_packet.degraded_surface_notes != "none")
      support += " | degraded=" + workbench_packet.degraded_surface_notes;
   return support;
  }


double ASC_L6ClampPct(const double value)
  {
   if(value < 0.0)
      return 0.0;
   if(value > 100.0)
      return 100.0;
   return value;
  }

string ASC_L6ZoneFromFamily(const ASC_L6_FamilyId family_id,const string fallback)
  {
   switch(family_id)
     {
      case ASC_L6_FAMILY_CONTINUATION:       return "pullback_re_entry_zone";
      case ASC_L6_FAMILY_REVERSAL:           return "range_rotation_boundary_zone";
      case ASC_L6_FAMILY_RECLAIM:            return "reclaim_hold_zone";
      case ASC_L6_FAMILY_FAILED_BREAK:       return "sweep_failure_invalidation_zone";
      case ASC_L6_FAMILY_BALANCE_ROTATION:   return "range_rotation_boundary_zone";
      case ASC_L6_FAMILY_BREAKOUT_EXPANSION: return "extension_target_continuation_zone";
      default:                               return fallback;
     }
  }

string ASC_L6DescribeEntryPath(const ASC_Layer5WorkbenchPacket &workbench_packet,
                               const ASC_L6_FamilyId family_id)
  {
   string zone = ASC_L6ZoneFromFamily(family_id, "bounded_entry_zone");
   if(family_id == ASC_L6_FAMILY_RECLAIM)
      return StringFormat("wait for reclaim hold zone to stay defended; avoid first touch chase | liquidity=%s | reclaim=%s",
                          ASC_L6_DefaultOrValue(workbench_packet.liquidity_zone, "liquidity zone unresolved"),
                          ASC_L6_DefaultOrValue(workbench_packet.reclaim_state, "reclaim state unresolved"));
   if(family_id == ASC_L6_FAMILY_FAILED_BREAK)
      return StringFormat("engage only after sweep failure zone confirms rejection back inside range | session sweep=%s | trap=%s",
                          ASC_L6_DefaultOrValue(workbench_packet.session_sweep_state, "sweep state unresolved"),
                          ASC_L6_DefaultOrValue(workbench_packet.trap_pressure_state, "trap pressure unresolved"));
   if(family_id == ASC_L6_FAMILY_BREAKOUT_EXPANSION)
      return StringFormat("use continuation extension zone only if pullback holds after expansion; avoid late extension entry | continuation=%s | freshness=%s",
                          ASC_L6_DefaultOrValue(workbench_packet.continuation_state, "continuation unresolved"),
                          ASC_L6_DefaultOrValue(workbench_packet.freshness_state, "freshness unresolved"));
   if(family_id == ASC_L6_FAMILY_BALANCE_ROTATION)
      return StringFormat("work the %s near range edge, not mid-range drift | position in range %.0f%%",
                          zone,
                          ASC_L6ClampPct(workbench_packet.position_in_range_pct));
   if(family_id == ASC_L6_FAMILY_REVERSAL)
      return StringFormat("only use reversal rotation zone after pressure shift persists; avoid early fade | reversal=%s | pressure=%s",
                          ASC_L6_DefaultOrValue(workbench_packet.reversal_state, "reversal unresolved"),
                          ASC_L6_DefaultOrValue(workbench_packet.pressure_shift_posture, "pressure unresolved"));
   return StringFormat("favor %s instead of impulse chase | pullback=%s | continuation=%s",
                       zone,
                       ASC_L6_DefaultOrValue(workbench_packet.pullback_state, "pullback unresolved"),
                       ASC_L6_DefaultOrValue(workbench_packet.continuation_state, "continuation unresolved"));
  }

string ASC_L6DescribeInvalidationPath(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                      const ASC_L6_FamilyId family_id)
  {
   if(family_id == ASC_L6_FAMILY_RECLAIM)
      return StringFormat("invalidate if reclaim hold zone loses acceptance or slips back below reclaimed boundary | reclaim=%.0f | failed break=%.0f",
                          workbench_packet.reclaim_score,
                          workbench_packet.failed_break_score);
   if(family_id == ASC_L6_FAMILY_FAILED_BREAK)
      return StringFormat("invalidate if sweep failure no longer rejects and range re-entry fails | sweep=%.0f | trap=%.0f",
                          workbench_packet.session_sweep_score,
                          workbench_packet.trap_pressure_score);
   if(family_id == ASC_L6_FAMILY_BREAKOUT_EXPANSION)
      return StringFormat("invalidate if extension cannot hold pullback support or freshness decays before follow-through | continuation=%.0f | freshness=%.0f",
                          workbench_packet.continuation_readiness_score,
                          workbench_packet.move_freshness_score);
   if(family_id == ASC_L6_FAMILY_BALANCE_ROTATION)
      return StringFormat("invalidate if range-rotation boundary breaks and price accepts the opposite side | dist high %.0f%% | dist low %.0f%%",
                          ASC_L6ClampPct(workbench_packet.distance_to_recent_high_pct),
                          ASC_L6ClampPct(workbench_packet.distance_to_recent_low_pct));
   if(family_id == ASC_L6_FAMILY_REVERSAL)
      return StringFormat("invalidate if reversal pressure fails to displace trend continuation or reclaim never stabilizes | reversal=%.0f | reclaim=%.0f",
                          workbench_packet.reversal_pressure_score,
                          workbench_packet.reclaim_score);
   return StringFormat("invalidate if pullback re-entry zone fails and continuation loses structure support | pullback depth=%.0f | pullback quality=%.0f",
                       workbench_packet.pullback_depth_score,
                       workbench_packet.pullback_quality_score);
  }

string ASC_L6DescribeTargetPath(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                const ASC_L6_FamilyId family_id)
  {
   if(family_id == ASC_L6_FAMILY_RECLAIM)
      return StringFormat("first target is extension away from reclaimed boundary toward recent range edge; reduce ambition if friction stays high | execution=%s",
                          ASC_L6_DefaultOrValue(workbench_packet.execution_posture, "execution unresolved"));
   if(family_id == ASC_L6_FAMILY_FAILED_BREAK)
      return StringFormat("target path is rotation back through trapped range and then toward opposite boundary if pressure persists | trap=%s",
                          ASC_L6_DefaultOrValue(workbench_packet.trap_pressure_state, "trap pressure unresolved"));
   if(family_id == ASC_L6_FAMILY_BREAKOUT_EXPANSION)
      return StringFormat("target path is continuation extension zone beyond recent breakout, but only while participation stays supportive | participation=%s",
                          ASC_L6_DefaultOrValue(workbench_packet.participation_posture, "participation unresolved"));
   if(family_id == ASC_L6_FAMILY_BALANCE_ROTATION)
      return "target path is opposite side of the active range first, then only a secondary extension if breakout evidence appears";
   if(family_id == ASC_L6_FAMILY_REVERSAL)
      return "target path is mean reversion into prior balance first; only promote to full reversal extension after cleaner alignment";
   return StringFormat("target path is continuation extension toward recent high/low boundary while move freshness holds | dist high %.0f%% | dist low %.0f%%",
                       ASC_L6ClampPct(workbench_packet.distance_to_recent_high_pct),
                       ASC_L6ClampPct(workbench_packet.distance_to_recent_low_pct));
  }

string ASC_L6ResolveGeometryTimebox(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                    const ASC_L6_MtfPosturePacket &mtf_packet,
                                    const ASC_L6_FamilyId family_id)
  {
   if(workbench_packet.move_age_score >= 72.0 && workbench_packet.tick_burst_flag)
      return "immediate window if trigger confirms soon; stale if it lingers";
   if(workbench_packet.move_age_score >= 58.0 || family_id == ASC_L6_FAMILY_RECLAIM || family_id == ASC_L6_FAMILY_FAILED_BREAK)
      return "near-term window; valid on next clean retest or reclaim hold";
   if(mtf_packet.conflict_class == ASC_L6_MTF_FRICTION || workbench_packet.pullback_quality_score < 55.0)
      return "delayed window; wait for cleaner confirmation before acting";
   return "patience window; monitor next lawful deep refresh before promoting geometry";
  }

string ASC_L6ResolveGeometryExecutionBurden(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                            const ASC_L6_MtfPosturePacket &mtf_packet)
  {
   bool heavy = (workbench_packet.execution_score < 55.0
                 || workbench_packet.execution_posture == "guarded"
                 || mtf_packet.conflict_class == ASC_L6_MTF_FRICTION
                 || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING);
   bool moderate = (workbench_packet.execution_score < 68.0
                    || workbench_packet.liquidity_quality_score < 60.0
                    || workbench_packet.participation_score < 60.0);
   if(heavy)
      return "high manual burden; execution quality needs patience and active discretion";
   if(moderate)
      return "moderate manual burden; acceptable only with cleaner trigger behavior";
   return "contained manual burden; geometry is reviewable without automation";
  }

string ASC_L6ResolveGeometryReviewBurden(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                         const ASC_L6_MtfPosturePacket &mtf_packet)
  {
   if(mtf_packet.conflict_class == ASC_L6_MTF_HARD_CONFLICT)
      return "heavy review burden; higher-timeframe conflict must clear first";
   if(workbench_packet.siam_secondary_fit != "" && workbench_packet.siam_secondary_fit_score >= workbench_packet.siam_primary_fit_score - 8.0)
      return "dual-path review burden; primary and alternate both need supervision";
   if(workbench_packet.reversal_pressure_score >= 62.0 || workbench_packet.failed_break_score >= 60.0)
      return "elevated review burden; monitor whether this stays continuation or rotates into reversal";
   return "standard review burden; geometry can be checked on the next deep refresh";
  }


bool ASC_L6AlternateIsLive(const ASC_Layer5WorkbenchPacket &workbench_packet)
  {
   return (workbench_packet.siam_secondary_fit != ""
           && ASC_L6FamilyFromFitName(workbench_packet.siam_secondary_fit) != ASC_L6_FAMILY_UNKNOWN
           && workbench_packet.siam_secondary_fit_score >= 50.0);
  }

bool ASC_L6AlternateIsThreatening(const ASC_Layer5WorkbenchPacket &workbench_packet)
  {
   return (ASC_L6AlternateIsLive(workbench_packet)
           && workbench_packet.siam_secondary_fit_score >= workbench_packet.siam_primary_fit_score - 8.0);
  }

string ASC_L6ResolvePathStagePosture(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                     const ASC_L6_NormalizedContextPacket &normalized_packet,
                                     const ASC_L6_MtfPosturePacket &mtf_packet,
                                     const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                     const ASC_L6_ReadinessPacket &readiness_packet)
  {
   bool lawful_packet = (workbench_packet.packet_valid && workbench_packet.packet_lawful && normalized_packet.availability.available);
   bool missing_support = (normalized_packet.availability.missing_surface || ASC_L6_TextSuggestsMissing(normalized_packet.missing_surface_notes));
   bool alternate_live = ASC_L6AlternateIsLive(workbench_packet);
   bool alternate_threat = ASC_L6AlternateIsThreatening(workbench_packet);
   bool freshness_soft = (workbench_packet.move_freshness_score < 52.0 || workbench_packet.move_age_score < 45.0 || workbench_packet.participation_score < 50.0);
   bool freshness_hard = (workbench_packet.move_freshness_score < 38.0 || workbench_packet.move_age_score < 30.0 || workbench_packet.participation_score < 42.0);
   bool conflict_heavy = (mtf_packet.conflict_class == ASC_L6_MTF_HARD_CONFLICT || readiness_packet.opportunity_status == ASC_L6_OPPORTUNITY_STRUCTURE_INVALID || readiness_packet.opportunity_status == ASC_L6_OPPORTUNITY_EXECUTION_INVALID);
   bool contested = (alternate_threat || mtf_packet.conflict_class == ASC_L6_MTF_FRICTION || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING || workbench_packet.reversal_pressure_score >= 62.0);

   if(!lawful_packet || missing_support)
      return "emergent";
   if(conflict_heavy)
      return (alternate_live ? "preserved alternate" : "invalid / expired");
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID)
      return (alternate_live ? "preserved alternate" : "invalid / expired");
   if(freshness_hard)
      return (alternate_live ? "preserved alternate" : "exhausted" );
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
     {
      if(workbench_packet.continuation_readiness_score >= 58.0 || workbench_packet.reclaim_score >= 56.0 || workbench_packet.failed_break_score >= 56.0)
         return "developing";
      return "emergent";
     }
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED)
     {
      if(freshness_soft)
         return "fading";
      return (contested ? "contested" : "confirmable");
     }
   if(readiness_packet.readiness_class == ASC_L6_READINESS_READY && !contested && workbench_packet.move_freshness_score >= 64.0 && workbench_packet.execution_score >= 60.0)
      return "active";
   if(readiness_packet.readiness_class == ASC_L6_READINESS_READY && !freshness_soft)
      return (contested ? "contested" : "confirmable");
   if(freshness_soft)
      return "fading";
   return (contested ? "contested" : "developing");
  }

string ASC_L6ResolveRevisitTrigger(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                   const ASC_L6_NormalizedContextPacket &normalized_packet,
                                   const ASC_L6_MtfPosturePacket &mtf_packet,
                                   const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                   const ASC_L6_ReadinessPacket &readiness_packet)
  {
   bool missing_support = (normalized_packet.availability.missing_surface || ASC_L6_TextSuggestsMissing(normalized_packet.missing_surface_notes));
   bool alternate_threat = ASC_L6AlternateIsThreatening(workbench_packet);

   if(missing_support)
      return "revisit when selected-symbol support surfaces refresh and lawful geometry inputs are restored";
   if(readiness_packet.opportunity_status == ASC_L6_OPPORTUNITY_STRUCTURE_INVALID || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID)
     {
      if(alternate_threat)
         return "revisit only if the alternate path strengthens or the conflict source materially clears";
      return "revisit only after the current invalidation source materially clears on a later lawful deep refresh";
     }
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return "revisit on the next lawful deep refresh once entry, invalidation, and target support stop arriving thin";
   if(alternate_threat)
      return "revisit when the next lawful deep refresh separates the primary path from the preserved alternate more clearly";
   if(mtf_packet.conflict_class == ASC_L6_MTF_FRICTION || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING)
      return "revisit when timeframe friction or reversal pressure either clears or decisively takes over";
   if(workbench_packet.move_freshness_score < 52.0 || workbench_packet.move_age_score < 45.0)
      return "revisit quickly; the path stays alive only while freshness and participation recover on the next lawful review";
   return "revisit on the next lawful deep refresh or sooner if structure confirms more cleanly";
  }

string ASC_L6ResolveExpiryHint(const ASC_Layer5WorkbenchPacket &workbench_packet,
                               const ASC_L6_MtfPosturePacket &mtf_packet,
                               const ASC_L6_GeometryCandidatePacket &geometry_packet,
                               const ASC_L6_ReadinessPacket &readiness_packet)
  {
   bool alternate_live = ASC_L6AlternateIsLive(workbench_packet);
   bool freshness_soft = (workbench_packet.move_freshness_score < 52.0 || workbench_packet.move_age_score < 45.0 || workbench_packet.participation_score < 50.0);
   bool freshness_hard = (workbench_packet.move_freshness_score < 38.0 || workbench_packet.move_age_score < 30.0 || workbench_packet.participation_score < 42.0);

   if(readiness_packet.opportunity_status == ASC_L6_OPPORTUNITY_STRUCTURE_INVALID || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID)
      return (alternate_live ? "current primary expired; preserved alternate stays reviewable only if fresh support rebuilds" : "invalidated by conflict or structure loss until a later lawful rebuild appears");
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return "pending clearer trigger; the path expires if bounded geometry support stays thin through the next lawful review";
   if(freshness_hard)
      return (alternate_live ? "primary is stale / exhausted; preserve only the alternate if it retains cleaner support" : "stale / expired unless freshness materially rebuilds on the next lawful refresh");
   if(freshness_soft)
      return "weakening; nearing expiry unless freshness and participation recover soon";
   if(mtf_packet.conflict_class == ASC_L6_MTF_FRICTION || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED)
      return "still alive but contested; expires if friction deepens or the alternate path starts explaining price more cleanly";
   if(readiness_packet.readiness_class == ASC_L6_READINESS_READY)
      return "still alive; expiry stays bounded to future structure loss, freshness decay, or a cleaner alternate takeover";
   return "nearing expiry unless the next lawful deep refresh strengthens structure and trigger support";
  }

bool ASC_BuildL6GeometryCandidatePacket(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                        const ASC_L6_NormalizedContextPacket &normalized_packet,
                                        const ASC_L6_MtfPosturePacket &mtf_packet,
                                        ASC_L6_GeometryCandidatePacket &geometry_packet)
  {
   geometry_packet.lineage = workbench_packet.lineage;
   geometry_packet.availability = workbench_packet.availability;
   geometry_packet.primary_family_id = ASC_L6FamilyFromFitName(workbench_packet.siam_primary_fit);
   geometry_packet.alternate_family_id = ASC_L6FamilyFromFitName(workbench_packet.siam_secondary_fit);
   geometry_packet.primary_candidate_supported = false;
   geometry_packet.alternate_candidate_supported = false;
   geometry_packet.primary_candidate_summary = "Primary geometry candidate unresolved";
   geometry_packet.alternate_candidate_summary = "Alternate geometry candidate not promoted";
   geometry_packet.entry_reference = "Entry path unresolved";
   geometry_packet.invalidation_reference = "Invalidation path unresolved";
   geometry_packet.target_reference = "Target path unresolved";
   geometry_packet.timebox_posture = "review window unresolved";
   geometry_packet.execution_burden_posture = "manual burden unresolved";
   geometry_packet.review_burden_posture = "review burden unresolved";
   geometry_packet.timing_posture = "needs cleaner confirmation";
   geometry_packet.blocker_summary = "geometry_support_unavailable";
   geometry_packet.insufficiency_reason = "lawful selected-symbol geometry inputs did not clear minimum support";
   geometry_packet.geometry_reason_summary = "bounded geometry not yet classified";
   geometry_packet.geometry_notes = "selected_symbol_only | explicit_deep_path_only | consumer_only";
   geometry_packet.geometry_validity = ASC_L6_GEOMETRY_UNRESOLVED;

   bool packet_ok = (workbench_packet.packet_valid && workbench_packet.packet_lawful && normalized_packet.availability.available);
   bool missing_support = (normalized_packet.availability.missing_surface || ASC_L6_TextSuggestsMissing(normalized_packet.missing_surface_notes));
   bool tradable = (normalized_packet.scalp_tradability == "yes" || normalized_packet.intraday_tradability == "yes");
   bool hard_conflict = (mtf_packet.conflict_class == ASC_L6_MTF_HARD_CONFLICT);
   bool degraded_conflict = (mtf_packet.conflict_class == ASC_L6_MTF_FRICTION || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING);
   bool entry_supported = (workbench_packet.pullback_quality_score >= 52.0
                           || workbench_packet.reclaim_score >= 56.0
                           || workbench_packet.failed_break_score >= 56.0
                           || workbench_packet.continuation_readiness_score >= 58.0);
   bool invalidation_supported = (workbench_packet.distance_to_recent_high_pct > 0.0
                                  || workbench_packet.distance_to_recent_low_pct > 0.0
                                  || workbench_packet.session_sweep_score >= 45.0
                                  || workbench_packet.reclaim_score >= 45.0);
   bool target_supported = (workbench_packet.continuation_readiness_score >= 50.0
                            || workbench_packet.participation_score >= 55.0
                            || workbench_packet.position_in_range_pct >= 0.0);
   bool execution_heavy = (workbench_packet.execution_score < 50.0 || workbench_packet.execution_posture == "guarded");

   geometry_packet.primary_candidate_supported = (packet_ok && entry_supported && invalidation_supported && target_supported && geometry_packet.primary_family_id != ASC_L6_FAMILY_UNKNOWN);
   geometry_packet.alternate_candidate_supported = (packet_ok && workbench_packet.siam_secondary_fit != "" && geometry_packet.alternate_family_id != ASC_L6_FAMILY_UNKNOWN && workbench_packet.siam_secondary_fit_score >= 50.0);
   geometry_packet.execution_burden_posture = ASC_L6ResolveGeometryExecutionBurden(workbench_packet, mtf_packet);
   geometry_packet.review_burden_posture = ASC_L6ResolveGeometryReviewBurden(workbench_packet, mtf_packet);
   geometry_packet.timebox_posture = ASC_L6ResolveGeometryTimebox(workbench_packet, mtf_packet, geometry_packet.primary_family_id);

   if(!packet_ok)
     {
      geometry_packet.geometry_validity = ASC_L6_GEOMETRY_UNRESOLVED;
      geometry_packet.blocker_summary = "upstream_packet_unavailable";
      geometry_packet.insufficiency_reason = "selected-symbol deep packet is not lawful or not available";
      geometry_packet.geometry_reason_summary = "Idea may exist, but lawful geometry cannot be projected without a valid selected-symbol deep packet";
      return false;
     }

   if(missing_support)
     {
      geometry_packet.geometry_validity = ASC_L6_GEOMETRY_UNRESOLVED;
      geometry_packet.blocker_summary = "missing_geometry_support";
      geometry_packet.insufficiency_reason = normalized_packet.missing_surface_notes;
      geometry_packet.geometry_reason_summary = "Idea remains reviewable, but geometry is unresolved because required support surfaces are still missing";
      return true;
     }

   if(hard_conflict || !tradable)
     {
      geometry_packet.geometry_validity = ASC_L6_GEOMETRY_INVALID;
      geometry_packet.blocker_summary = (hard_conflict ? "hard_mtf_conflict" : "tradability_not_confirmed");
      geometry_packet.insufficiency_reason = (hard_conflict ? mtf_packet.conflict_reason_summary : "scalp and intraday tradability remain no");
      geometry_packet.geometry_reason_summary = "Idea quality does not grant executable geometry when structure conflict or tradability blocks the path";
      geometry_packet.timing_posture = "manual patience only";
      return true;
     }

   if(!geometry_packet.primary_candidate_supported)
     {
      geometry_packet.geometry_validity = ASC_L6_GEOMETRY_UNRESOLVED;
      geometry_packet.blocker_summary = "primary_geometry_support_insufficient";
      geometry_packet.insufficiency_reason = "entry, invalidation, or target support stayed too thin for a lawful bounded path";
      geometry_packet.geometry_reason_summary = "Idea can stay alive while geometry remains unresolved; support was not strong enough to classify a bounded path";
      return true;
     }

   geometry_packet.primary_candidate_summary = StringFormat("Primary candidate: %s pathway | fit=%s | score %.0f",
                                                            ASC_L6FamilyIdToText(geometry_packet.primary_family_id),
                                                            ASC_L6_DefaultOrValue(workbench_packet.siam_primary_fit_posture, "fit posture unresolved"),
                                                            workbench_packet.siam_primary_fit_score);
   if(geometry_packet.alternate_candidate_supported)
      geometry_packet.alternate_candidate_summary = StringFormat("Alternate candidate: %s pathway | fit=%s | score %.0f",
                                                                ASC_L6FamilyIdToText(geometry_packet.alternate_family_id),
                                                                ASC_L6_DefaultOrValue(workbench_packet.siam_secondary_fit_posture, "fit posture unresolved"),
                                                                workbench_packet.siam_secondary_fit_score);
   geometry_packet.entry_reference = ASC_L6DescribeEntryPath(workbench_packet, geometry_packet.primary_family_id);
   geometry_packet.invalidation_reference = ASC_L6DescribeInvalidationPath(workbench_packet, geometry_packet.primary_family_id);
   geometry_packet.target_reference = ASC_L6DescribeTargetPath(workbench_packet, geometry_packet.primary_family_id);
   geometry_packet.timing_posture = ((workbench_packet.move_age_score >= 68.0 && !degraded_conflict && !execution_heavy)
                                     ? "immediate if trigger confirms"
                                     : ((degraded_conflict || execution_heavy) ? "delayed until cleaner confirmation" : "reviewable now but still patience-led"));

   if(degraded_conflict || execution_heavy || workbench_packet.reversal_pressure_score >= 62.0)
     {
      geometry_packet.geometry_validity = ASC_L6_GEOMETRY_DEGRADED;
      geometry_packet.blocker_summary = "geometry_degraded_by_context";
      geometry_packet.insufficiency_reason = (degraded_conflict ? mtf_packet.conflict_reason_summary : geometry_packet.execution_burden_posture);
      geometry_packet.geometry_reason_summary = "Idea stays workable, but the actual path is degraded by alignment friction, execution burden, or reversal pressure";
     }
   else
     {
      geometry_packet.geometry_validity = ASC_L6_GEOMETRY_VALID;
      geometry_packet.blocker_summary = "no_primary_geometry_blocker";
      geometry_packet.insufficiency_reason = "none";
      geometry_packet.geometry_reason_summary = "Bounded geometry is supported: entry, invalidation, and target paths can be reviewed without implying automation";
     }

   geometry_packet.geometry_notes = StringFormat("selected_symbol_only | explicit_deep_path_only | family=%s | alternate=%s | timing=%s",
                                                 ASC_L6FamilyIdToText(geometry_packet.primary_family_id),
                                                 ASC_L6FamilyIdToText(geometry_packet.alternate_family_id),
                                                 geometry_packet.timing_posture);
   return true;
  }


string ASC_L6ResolvePatternFamilyLabel(const ASC_L6_PatternFamilyType value)
  {
   switch(value)
     {
      case ASC_L6_PATTERN_FAMILY_HARMONIC_LIKE_REVERSAL:    return "Harmonic-like reversal";
      case ASC_L6_PATTERN_FAMILY_HARMONIC_LIKE_CONTINUATION:return "Harmonic-like continuation";
      case ASC_L6_PATTERN_FAMILY_BALANCED_ROTATION:          return "Balanced rotation";
      case ASC_L6_PATTERN_FAMILY_EXTENSION_RECLAIM:          return "Extension reclaim";
      case ASC_L6_PATTERN_FAMILY_BOUNDED_RECLAIM_REVERSAL:   return "Bounded reclaim reversal";
      case ASC_L6_PATTERN_FAMILY_NONE:                       return "No candidate admitted";
     }
   return "No candidate admitted";
  }

ASC_L6_PatternFamilyType ASC_L6ResolvePatternFamilyType(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                                        const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                                        const ASC_L6_ReadinessPacket &readiness_packet)
  {
   if(geometry_packet.primary_family_id == ASC_L6_FAMILY_UNKNOWN)
      return ASC_L6_PATTERN_FAMILY_NONE;

   if(geometry_packet.primary_family_id == ASC_L6_FAMILY_REVERSAL)
      return ASC_L6_PATTERN_FAMILY_HARMONIC_LIKE_REVERSAL;

   if(geometry_packet.primary_family_id == ASC_L6_FAMILY_CONTINUATION)
      return ASC_L6_PATTERN_FAMILY_HARMONIC_LIKE_CONTINUATION;

   if(geometry_packet.primary_family_id == ASC_L6_FAMILY_BALANCE_ROTATION)
      return ASC_L6_PATTERN_FAMILY_BALANCED_ROTATION;

   if(geometry_packet.primary_family_id == ASC_L6_FAMILY_RECLAIM)
      return ASC_L6_PATTERN_FAMILY_EXTENSION_RECLAIM;

   if(geometry_packet.primary_family_id == ASC_L6_FAMILY_FAILED_BREAK)
      return ASC_L6_PATTERN_FAMILY_BOUNDED_RECLAIM_REVERSAL;

   if(geometry_packet.primary_family_id == ASC_L6_FAMILY_BREAKOUT_EXPANSION)
     {
      if(readiness_packet.readiness_class == ASC_L6_READINESS_READY ||
         readiness_packet.readiness_class == ASC_L6_READINESS_READY_DEGRADED)
         return ASC_L6_PATTERN_FAMILY_HARMONIC_LIKE_CONTINUATION;

      return ASC_L6_PATTERN_FAMILY_EXTENSION_RECLAIM;
     }

   if(StringFind(workbench_packet.reversal_state, "active") >= 0 ||
      StringFind(workbench_packet.reversal_state, "building") >= 0)
      return ASC_L6_PATTERN_FAMILY_HARMONIC_LIKE_REVERSAL;

   if(StringFind(workbench_packet.continuation_state, "active") >= 0 ||
      StringFind(workbench_packet.continuation_state, "ready") >= 0)
      return ASC_L6_PATTERN_FAMILY_HARMONIC_LIKE_CONTINUATION;

   if(StringFind(workbench_packet.reclaim_state, "active") >= 0 ||
      StringFind(workbench_packet.reclaim_state, "ready") >= 0)
      return ASC_L6_PATTERN_FAMILY_EXTENSION_RECLAIM;

   return ASC_L6_PATTERN_FAMILY_NONE;
  }

double ASC_L6ResolvePatternSupportiveWeight(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                            const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                            const ASC_L6_ReadinessPacket &readiness_packet)
  {
   double weight = 0.0;

   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_VALID)
      weight += 45.0;
   else if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED)
      weight += 30.0;
   else if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      weight += 10.0;

   if(readiness_packet.readiness_class == ASC_L6_READINESS_READY)
      weight += 30.0;
   else if(readiness_packet.readiness_class == ASC_L6_READINESS_READY_DEGRADED)
      weight += 20.0;
   else if(readiness_packet.readiness_class == ASC_L6_READINESS_CONDITIONAL)
      weight += 12.5;
   else if(readiness_packet.readiness_class == ASC_L6_READINESS_OBSERVE)
      weight += 5.0;

   if(readiness_packet.deployability_class == ASC_L6_DEPLOYABLE)
      weight += 15.0;
   else if(readiness_packet.deployability_class == ASC_L6_DEPLOYABLE_DEGRADED)
      weight += 10.0;
   else if(readiness_packet.deployability_class == ASC_L6_WATCH_ONLY)
      weight += 5.0;

   if(StringFind(workbench_packet.alignment, "aligned") >= 0)
      weight += 10.0;
   else if(StringFind(workbench_packet.alignment, "friction") >= 0)
      weight -= 5.0;

   if(weight < 0.0)
      return 0.0;
   if(weight > 100.0)
      return 100.0;
   return weight;
  }

string ASC_L6ResolvePatternConfirmationRequirement(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                                   const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                                   const ASC_L6_ReadinessPacket &readiness_packet,
                                                   const ASC_L6_PatternFamilyType family_type)
  {
   string family_label = ASC_L6ResolvePatternFamilyLabel(family_type);

   if(family_type == ASC_L6_PATTERN_FAMILY_NONE)
      return "No confirmation path yet because no lawful bounded candidate is admitted.";

   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return StringFormat("Confirm %s only after geometry resolves on a later lawful deep refresh.", family_label);

   if(readiness_packet.readiness_class == ASC_L6_READINESS_CONDITIONAL)
      return StringFormat("Confirm %s only if the current conditional blocker clears and readiness improves.", family_label);

   if(readiness_packet.readiness_class == ASC_L6_READINESS_OBSERVE ||
      readiness_packet.deployability_class == ASC_L6_WATCH_ONLY)
      return StringFormat("Keep %s in review only until the preserve-only posture upgrades out of observe/watch-only.", family_label);

   if(StringLen(workbench_packet.source_trigger_reason) > 0)
      return StringFormat("Confirm %s only when trigger-family evidence stays aligned with current selected-symbol deep truth (%s).", family_label, workbench_packet.source_trigger_reason);

   return StringFormat("Confirm %s only on the next lawful selected-symbol deep refresh with preserved family, geometry, and readiness alignment.", family_label);
  }

string ASC_L6ResolvePatternInvalidationRequirement(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                                   const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                                   const ASC_L6_ReadinessPacket &readiness_packet,
                                                   const ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   string family_anchor = ASC_L6FamilyIdToText(geometry_packet.primary_family_id);

   if(readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED)
      return "Invalidate immediately while readiness is blocked.";

   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID)
      return "Invalidate immediately if geometry becomes invalid.";

   if(surface_packet.strongest_family_now != geometry_packet.primary_family_id &&
      surface_packet.strongest_family_now != ASC_L6_FAMILY_UNKNOWN)
      return StringFormat("Invalidate if selected-symbol authority shifts away from the current family anchor (%s).", family_anchor);

   if(StringLen(workbench_packet.source_trigger_family) > 0)
      return StringFormat("Invalidate if trigger-family carry (%s) conflicts with the current bounded candidate.", workbench_packet.source_trigger_family);

   return StringFormat("Invalidate if family anchor (%s), geometry, or readiness no longer support the bounded candidate.", family_anchor);
  }

string ASC_L6ResolvePatternPreservationNote(const ASC_L6_PatternFamilyType family_type,
                                            const ASC_Layer5WorkbenchPacket &workbench_packet,
                                            const ASC_L6_ReadinessPacket &readiness_packet,
                                            const bool preserve_only)
  {
   if(family_type == ASC_L6_PATTERN_FAMILY_NONE)
      return "No preserved candidate.";

   string family_label = ASC_L6ResolvePatternFamilyLabel(family_type);

   if(preserve_only)
      return StringFormat("Preserve %s for later selected-symbol review only; do not treat it as ordinary authority while observe/watch-only posture persists.", family_label);

   if(readiness_packet.readiness_class == ASC_L6_READINESS_CONDITIONAL)
      return StringFormat("Preserve %s as conditional support only until the current blocker clears.", family_label);

   if(StringLen(workbench_packet.preservation_reason) > 0)
      return StringFormat("Preserve %s within the current continuity posture (%s).", family_label, workbench_packet.preservation_reason);

   return StringFormat("Preserve %s as supportive selected-symbol context only; no Board override and no execution meaning.", family_label);
  }

bool ASC_BuildL6NormalizedContextPacket(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                        ASC_L6_NormalizedContextPacket &normalized_packet)
  {
   normalized_packet.lineage = workbench_packet.lineage;
   normalized_packet.availability = workbench_packet.availability;
   normalized_packet.packet_valid = workbench_packet.packet_valid;
   normalized_packet.packet_lawful = workbench_packet.packet_lawful;
   normalized_packet.source_packet_revision = workbench_packet.source_result_revision;
   normalized_packet.source_build_utc = workbench_packet.source_build_utc;
   normalized_packet.freshness_posture = ASC_L6_DefaultOrValue(workbench_packet.freshness_posture, "unavailable");
   normalized_packet.continuity_posture = ASC_L6_DefaultOrValue(workbench_packet.continuity_posture, "unavailable");
   normalized_packet.preservation_state = ASC_L6_DefaultOrValue(workbench_packet.preservation_state, "unavailable");
   normalized_packet.preservation_reason = ASC_L6_DefaultOrValue(workbench_packet.preservation_reason, "preservation_reason_unavailable");
   normalized_packet.data_tier = ASC_L6_DefaultOrValue(workbench_packet.data_tier, "tier_unavailable");
   normalized_packet.entitlement_state = ASC_L6_DefaultOrValue(workbench_packet.entitlement_state, "unavailable");
   normalized_packet.entitlement_reason = ASC_L6_DefaultOrValue(workbench_packet.entitlement_reason, workbench_packet.packet_reason_summary);
   normalized_packet.support_context = ASC_L6ResolveSupportContext(workbench_packet);
   normalized_packet.missing_surface_notes = ASC_L6_DefaultOrValue(workbench_packet.missing_surface_notes, workbench_packet.availability.missing_surface_notes);
   normalized_packet.degraded_surface_notes = ASC_L6_DefaultOrValue(workbench_packet.degraded_surface_notes, "none");
   normalized_packet.concise_reason_summary = ASC_L6_DefaultOrValue(workbench_packet.packet_reason_summary, workbench_packet.summary_line);

   normalized_packet.execution_score = workbench_packet.execution_score;
   normalized_packet.execution_posture = ASC_L6_DefaultOrValue(workbench_packet.execution_posture, "unavailable");
   normalized_packet.liquidity_score = workbench_packet.liquidity_quality_score;
   normalized_packet.liquidity_posture = ASC_L6_DefaultOrValue(workbench_packet.liquidity_proximity_posture, ASC_L6_DefaultOrValue(workbench_packet.liquidity_zone, "unavailable"));
   normalized_packet.participation_score = workbench_packet.participation_score;
   normalized_packet.participation_posture = ASC_L6_DefaultOrValue(workbench_packet.participation_posture, "unavailable");
   normalized_packet.momentum_score = workbench_packet.momentum_acceleration_score;
   normalized_packet.momentum_posture = ASC_L6_DefaultOrValue(workbench_packet.momentum_acceleration_posture, "unavailable");
   normalized_packet.pressure_score = workbench_packet.pressure_shift_score;
   normalized_packet.pressure_posture = ASC_L6_DefaultOrValue(workbench_packet.pressure_shift_posture, "unavailable");
   normalized_packet.move_freshness_score = workbench_packet.move_freshness_score;
   normalized_packet.move_freshness_posture = ASC_L6_DefaultOrValue(workbench_packet.freshness_state, ASC_L6_DefaultOrValue(workbench_packet.move_age_posture, "unavailable"));
   normalized_packet.scalp_tradability = ASC_L6_DefaultOrValue(workbench_packet.scalp_tradable, "no");
   normalized_packet.intraday_tradability = ASC_L6_DefaultOrValue(workbench_packet.intraday_tradable, "no");
   normalized_packet.alignment_baseline = ASC_L6_DefaultOrValue(workbench_packet.alignment, "unavailable");
   normalized_packet.shortlist_context_carry = (workbench_packet.source_shortlist_context_available ? ASC_L6_DefaultOrValue(workbench_packet.source_context_summary, workbench_packet.score_context_summary) : "shortlist_context_unavailable");
   normalized_packet.build_context_carry = ASC_L6_DefaultOrValue(workbench_packet.build_context, "build_context_unavailable");

   normalized_packet.horizon_class = ASC_L6InferHorizonClass(workbench_packet);
   normalized_packet.market_state_ref = normalized_packet.entitlement_state;
   normalized_packet.packet_ref = normalized_packet.source_packet_revision;
   normalized_packet.shortlist_ref = normalized_packet.shortlist_context_carry;
   normalized_packet.normalization_reason_summary = normalized_packet.concise_reason_summary;
   normalized_packet.normalization_notes = ASC_L6_DefaultOrValue(workbench_packet.source_contract_note, "read_only_l5_intake") + " | dormant normalized context only";
   return (workbench_packet.packet_valid && workbench_packet.packet_lawful);
  }

bool ASC_PrepareSemiAutoWorkbenchIntake(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                        ASC_L6_NormalizedContextPacket &normalized_packet)
  {
   return ASC_BuildL6NormalizedContextPacket(workbench_packet, normalized_packet);
  }

ASC_L6_MtfConflictClass ASC_L6ClassifyMtfConflict(const ASC_Layer5WorkbenchPacket &workbench_packet)
  {
   if(workbench_packet.alignment == "aligned" || workbench_packet.alignment == "fully_aligned")
      return ASC_L6_MTF_ALIGNED;

   if(workbench_packet.reversal_pressure_score >= 70.0)
      return ASC_L6_MTF_REVERSAL_RISK_BUILDING;

   bool short_vs_higher_opposed = ASC_L6BiasesOppose(workbench_packet.short_term_bias, workbench_packet.higher_timeframe_bias);
   bool short_vs_mid_opposed = ASC_L6BiasesOppose(workbench_packet.short_term_bias, workbench_packet.mid_term_bias);
   bool short_vs_mid_aligned = ASC_L6BiasesAlign(workbench_packet.short_term_bias, workbench_packet.mid_term_bias);
   bool mixed_counts = (workbench_packet.upward_timeframe_count > 0 && workbench_packet.downward_timeframe_count > 0);
   int diff = MathAbs(workbench_packet.upward_timeframe_count - workbench_packet.downward_timeframe_count);

   if(mixed_counts)
     {
      if(diff <= 1 && short_vs_mid_opposed && short_vs_higher_opposed)
         return ASC_L6_MTF_HARD_CONFLICT;

      if(short_vs_higher_opposed && !short_vs_mid_aligned && workbench_packet.continuation_readiness_score >= 60.0 && workbench_packet.reversal_pressure_score < 55.0)
         return ASC_L6_MTF_COUNTERTREND_ALLOWED;

      return ASC_L6_MTF_FRICTION;
     }

   if(workbench_packet.alignment == "mixed_two_way" || short_vs_higher_opposed)
      return ASC_L6_MTF_FRICTION;

   return ASC_L6_MTF_ALIGNED;
  }

bool ASC_BuildL6MtfPosturePacket(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                 ASC_L6_MtfPosturePacket &mtf_packet)
  {
   mtf_packet.lineage = workbench_packet.lineage;
   mtf_packet.availability = workbench_packet.availability;
   mtf_packet.context_timeframe_role = "H4_D1_context";
   mtf_packet.bias_timeframe_role = "H1_H4_bias";
   mtf_packet.trigger_timeframe_role = "M1_M15_trigger";
   mtf_packet.short_term_bias = ASC_L6_DefaultOrValue(workbench_packet.short_term_bias, "unavailable");
   mtf_packet.mid_term_bias = ASC_L6_DefaultOrValue(workbench_packet.mid_term_bias, "unavailable");
   mtf_packet.higher_timeframe_bias = ASC_L6_DefaultOrValue(workbench_packet.higher_timeframe_bias, "unavailable");
   mtf_packet.alignment = ASC_L6_DefaultOrValue(workbench_packet.alignment, "unavailable");
   mtf_packet.upward_timeframe_count = workbench_packet.upward_timeframe_count;
   mtf_packet.downward_timeframe_count = workbench_packet.downward_timeframe_count;
   mtf_packet.expansion_timeframe_count = workbench_packet.expansion_timeframe_count;
   mtf_packet.compression_timeframe_count = workbench_packet.compression_timeframe_count;
   mtf_packet.conflict_class = ASC_L6ClassifyMtfConflict(workbench_packet);
   mtf_packet.path_viability_posture = ((workbench_packet.continuation_readiness_score >= 70.0 && workbench_packet.reversal_pressure_score < 55.0) ? "actionable_support" : ((workbench_packet.continuation_readiness_score >= 60.0 || workbench_packet.move_freshness_score >= 60.0) ? "viable_but_contested" : "guarded"));
   mtf_packet.reversal_pressure_posture = ASC_L6_DefaultOrValue(workbench_packet.reversal_state, "unavailable");
   mtf_packet.allowed_style_hint = ASC_L6ResolveAllowedStyleHint(workbench_packet);
   mtf_packet.lower_timeframe_posture = mtf_packet.short_term_bias;
   mtf_packet.trigger_timeframe_posture = ASC_L6_DefaultOrValue(workbench_packet.micro_direction, "unavailable");
   mtf_packet.higher_timeframe_posture = mtf_packet.higher_timeframe_bias;
   mtf_packet.conflict_reason_summary = StringFormat("alignment=%s | up/down=%d/%d | expansion/compression=%d/%d",
                                                     mtf_packet.alignment,
                                                     mtf_packet.upward_timeframe_count,
                                                     mtf_packet.downward_timeframe_count,
                                                     mtf_packet.expansion_timeframe_count,
                                                     mtf_packet.compression_timeframe_count);
   mtf_packet.timeframe_notes = StringFormat("context=%s | bias=%s | trigger=%s | reversal=%s",
                                             mtf_packet.context_timeframe_role,
                                             mtf_packet.bias_timeframe_role,
                                             mtf_packet.trigger_timeframe_role,
                                             mtf_packet.reversal_pressure_posture);
   return (workbench_packet.packet_valid && workbench_packet.packet_lawful);
  }

bool ASC_BuildL6AdvancedPatternPacket(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                          const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                          const ASC_L6_ReadinessPacket &readiness_packet,
                                          const ASC_L6_SemiAutoSurfacePacket &surface_packet,
                                          ASC_L6_AdvancedPatternPacket &pattern_packet)
  {
   pattern_packet.lineage = workbench_packet.lineage;
   pattern_packet.availability = workbench_packet.availability;
   pattern_packet.lane_availability = ASC_L6_PATTERN_LANE_PREPARED;
   pattern_packet.candidate_status = ASC_L6_PATTERN_NONE;
   pattern_packet.confidence_posture = ASC_L6_PATTERN_CONFIDENCE_NONE;
   pattern_packet.candidate_family_type = ASC_L6_PATTERN_FAMILY_NONE;
   pattern_packet.supportive_family_id = geometry_packet.primary_family_id;
   pattern_packet.candidate_available = false;
   pattern_packet.geometry_affinity_present = false;
   pattern_packet.boundary_preserved = true;
   pattern_packet.lane_availability_text = ASC_L6PatternLaneAvailabilityToText(pattern_packet.lane_availability);
   pattern_packet.candidate_family_type_text = ASC_L6PatternFamilyTypeToText(pattern_packet.candidate_family_type);
   pattern_packet.candidate_pattern_family = ASC_L6ResolvePatternFamilyLabel(pattern_packet.candidate_family_type);
   pattern_packet.candidate_status_text = ASC_L6PatternCandidateStatusToText(pattern_packet.candidate_status);
   pattern_packet.confidence_posture_text = ASC_L6PatternConfidencePostureToText(pattern_packet.confidence_posture);
   pattern_packet.geometry_affinity_note = "No lawful advanced-pattern candidate is admitted from current selected-symbol evidence.";
   pattern_packet.invalidation_note = "Invalidate immediately if future pattern-family work conflicts with current primary-family, Layer 5 owner truth, or Board command truth.";
   pattern_packet.confirmation_note = "Confirmation requires a later explicit deep-path pattern-family implementation; this pass adds bounded candidate logic only.";
   pattern_packet.preservation_note = "No preserved candidate.";
   pattern_packet.boundary_note = "Supportive only | selected-symbol only | explicit deep path only | consumer-only | no Board override | no family rewrite | no execution semantics";
   pattern_packet.supportive_weight = 0.0;
   pattern_packet.candidate_reason_summary = "bounded lane prepared only; no pattern candidate detected in this pass";
   pattern_packet.owner_boundary_summary = "Primary/alternate family competition, Layer 5 owner truth, and Layer 4 Board authority remain unchanged.";
   pattern_packet.packet_notes = "first_bounded_pattern_candidate_logic | no_fake_harmonic_precision | no_hot_path_widening";

   bool lawful_packet = (workbench_packet.packet_valid && workbench_packet.packet_lawful && workbench_packet.availability.available);
   if(!lawful_packet)
     {
      pattern_packet.lane_availability = ASC_L6_PATTERN_LANE_UNAVAILABLE;
      pattern_packet.candidate_status = ASC_L6_PATTERN_CANDIDATE_UNAVAILABLE;
      pattern_packet.confidence_posture = ASC_L6_PATTERN_CONFIDENCE_DEFERRED;
      pattern_packet.lane_availability_text = ASC_L6PatternLaneAvailabilityToText(pattern_packet.lane_availability);
      pattern_packet.candidate_status_text = ASC_L6PatternCandidateStatusToText(pattern_packet.candidate_status);
      pattern_packet.confidence_posture_text = ASC_L6PatternConfidencePostureToText(pattern_packet.confidence_posture);
      pattern_packet.geometry_affinity_note = "Pattern lane remains unavailable until a lawful selected-symbol deep packet exists.";
      pattern_packet.candidate_reason_summary = "upstream selected-symbol packet unavailable for bounded pattern-lane implementation";
      return false;
     }

   pattern_packet.lane_availability = ASC_L6_PATTERN_LANE_ACTIVE_DEEP_ONLY;
   pattern_packet.lane_availability_text = ASC_L6PatternLaneAvailabilityToText(pattern_packet.lane_availability);

   bool geometry_usable = (geometry_packet.geometry_validity == ASC_L6_GEOMETRY_VALID || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED);
   bool family_known = (geometry_packet.primary_family_id != ASC_L6_FAMILY_UNKNOWN);
   bool preserve_only = (readiness_packet.readiness_class == ASC_L6_READINESS_OBSERVE || readiness_packet.deployability_class == ASC_L6_WATCH_ONLY);
   bool invalidated = (geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID || readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED);
   bool confirm_pending = (geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED || readiness_packet.readiness_class == ASC_L6_READINESS_CONDITIONAL);

   pattern_packet.candidate_family_type = ASC_L6ResolvePatternFamilyType(workbench_packet, geometry_packet, readiness_packet);
   pattern_packet.candidate_family_type_text = ASC_L6PatternFamilyTypeToText(pattern_packet.candidate_family_type);
   pattern_packet.candidate_pattern_family = ASC_L6ResolvePatternFamilyLabel(pattern_packet.candidate_family_type);
   pattern_packet.supportive_weight = ASC_L6ResolvePatternSupportiveWeight(workbench_packet, geometry_packet, readiness_packet);

   if(invalidated)
     {
      pattern_packet.candidate_status = ASC_L6_PATTERN_INVALIDATED;
      pattern_packet.confidence_posture = ASC_L6_PATTERN_CONFIDENCE_DEFERRED;
      pattern_packet.candidate_pattern_family = family_known ? StringFormat("%s near %s", ASC_L6ResolvePatternFamilyLabel(pattern_packet.candidate_family_type), ASC_L6FamilyIdToText(geometry_packet.primary_family_id)) : "Candidate invalidated before family anchor resolved";
      pattern_packet.geometry_affinity_note = "Any advanced-pattern candidate is blocked because current geometry/readiness is invalidated.";
      pattern_packet.candidate_reason_summary = "bounded pattern candidate invalidated by current geometry/readiness state";
     }
   else if(!family_known || pattern_packet.candidate_family_type == ASC_L6_PATTERN_FAMILY_NONE)
     {
      pattern_packet.candidate_status = ASC_L6_PATTERN_CANDIDATE_UNAVAILABLE;
      pattern_packet.confidence_posture = ASC_L6_PATTERN_CONFIDENCE_NONE;
      pattern_packet.candidate_pattern_family = "No candidate admitted";
      pattern_packet.geometry_affinity_note = "Current selected-symbol truth does not support a lawful bounded pattern-family candidate yet; exact named harmonics are intentionally not fabricated.";
      pattern_packet.candidate_reason_summary = "no lawful family-pattern anchor exists for bounded pattern admission";
      pattern_packet.supportive_weight = 0.0;
     }
   else if(preserve_only)
     {
      pattern_packet.candidate_status = ASC_L6_PATTERN_PRESERVED_FOR_REVIEW;
      pattern_packet.confidence_posture = ASC_L6_PATTERN_CONFIDENCE_THIN;
      pattern_packet.candidate_available = true;
      pattern_packet.geometry_affinity_present = geometry_usable;
      pattern_packet.candidate_pattern_family = StringFormat("%s near %s", ASC_L6ResolvePatternFamilyLabel(pattern_packet.candidate_family_type), ASC_L6FamilyIdToText(geometry_packet.primary_family_id));
      pattern_packet.geometry_affinity_note = geometry_usable
                                             ? "Geometry can host a bounded candidate, but current posture only allows preservation for later selected-symbol review."
                                             : "Pattern family stays preserved only; geometry support is still too thin for stronger admission.";
      pattern_packet.candidate_reason_summary = "bounded pattern candidate preserved for later review only";
     }
   else if(confirm_pending)
     {
      pattern_packet.candidate_status = ASC_L6_PATTERN_CONFIRMATION_PENDING;
      pattern_packet.confidence_posture = ASC_L6_PATTERN_CONFIDENCE_THIN;
      pattern_packet.candidate_available = true;
      pattern_packet.geometry_affinity_present = geometry_usable;
      pattern_packet.candidate_pattern_family = StringFormat("%s near %s", ASC_L6ResolvePatternFamilyLabel(pattern_packet.candidate_family_type), ASC_L6FamilyIdToText(geometry_packet.primary_family_id));
      pattern_packet.geometry_affinity_note = geometry_usable
                                             ? "Geometry has bounded affinity for this candidate family, but confirmation is still pending on the next lawful deep refresh."
                                             : "Candidate remains exploratory because geometry support is not yet fully resolved.";
      pattern_packet.candidate_reason_summary = "bounded pattern candidate admitted as confirmation-pending only";
     }
   else if(geometry_usable)
     {
      pattern_packet.candidate_status = ASC_L6_PATTERN_GEOMETRY_ALIGNED;
      pattern_packet.confidence_posture = ASC_L6_PATTERN_CONFIDENCE_BOUNDED;
      pattern_packet.candidate_available = true;
      pattern_packet.geometry_affinity_present = true;
      pattern_packet.candidate_pattern_family = StringFormat("%s near %s", ASC_L6ResolvePatternFamilyLabel(pattern_packet.candidate_family_type), ASC_L6FamilyIdToText(geometry_packet.primary_family_id));
      pattern_packet.geometry_affinity_note = "Current geometry supports a bounded candidate family, but only as supportive context beside the existing family / maturity / handoff model.";
      pattern_packet.candidate_reason_summary = "bounded pattern candidate is geometry-aligned and supportive-only";
     }
   else
     {
      pattern_packet.candidate_status = ASC_L6_PATTERN_EXPLORATORY_ONLY;
      pattern_packet.confidence_posture = ASC_L6_PATTERN_CONFIDENCE_THIN;
      pattern_packet.candidate_available = true;
      pattern_packet.candidate_pattern_family = StringFormat("%s near %s", ASC_L6ResolvePatternFamilyLabel(pattern_packet.candidate_family_type), ASC_L6FamilyIdToText(geometry_packet.primary_family_id));
      pattern_packet.geometry_affinity_note = "A primary family exists, but the evidence only supports an exploratory bounded candidate at this stage.";
      pattern_packet.candidate_reason_summary = "bounded pattern candidate remains exploratory without stronger geometry alignment";
     }

   pattern_packet.candidate_status_text = ASC_L6PatternCandidateStatusToText(pattern_packet.candidate_status);
   pattern_packet.confidence_posture_text = ASC_L6PatternConfidencePostureToText(pattern_packet.confidence_posture);
   pattern_packet.confirmation_note = ASC_L6ResolvePatternConfirmationRequirement(workbench_packet,
                                                                                  geometry_packet,
                                                                                  readiness_packet,
                                                                                  pattern_packet.candidate_family_type);
   pattern_packet.invalidation_note = ASC_L6ResolvePatternInvalidationRequirement(workbench_packet,
                                                                                  geometry_packet,
                                                                                  readiness_packet,
                                                                                  surface_packet);
   pattern_packet.preservation_note = ASC_L6ResolvePatternPreservationNote(pattern_packet.candidate_family_type,
                                                                           workbench_packet,
                                                                           readiness_packet,
                                                                           preserve_only);
   return true;
  }

bool ASC_BuildL6ReadinessPacket(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                const ASC_L6_NormalizedContextPacket &normalized_packet,
                                const ASC_L6_MtfPosturePacket &mtf_packet,
                                const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                ASC_L6_ReadinessPacket &readiness_packet)
  {
   readiness_packet.lineage = workbench_packet.lineage;
   readiness_packet.availability = workbench_packet.availability;
   readiness_packet.geometry_validity = geometry_packet.geometry_validity;
   readiness_packet.horizon_class = normalized_packet.horizon_class;
   readiness_packet.allowed_style = mtf_packet.allowed_style_hint;
   readiness_packet.primary_blocker = ASC_L6_DefaultOrValue(geometry_packet.blocker_summary, "none");
   readiness_packet.downgrade_reason = ASC_L6_DefaultOrValue(geometry_packet.insufficiency_reason, "none");
   readiness_packet.why_not_top_rank_ready = "not_evaluated_for_top_rank";
   readiness_packet.review_posture = ASC_L6_DefaultOrValue(geometry_packet.review_burden_posture, "review_with_deep_and_board_context");

   bool missing_support = (normalized_packet.availability.missing_surface || ASC_L6_TextSuggestsMissing(normalized_packet.missing_surface_notes));
   bool degraded_support = (ASC_L6_TextSuggestsMissing(normalized_packet.degraded_surface_notes)
                            || normalized_packet.execution_posture == "guarded"
                            || mtf_packet.conflict_class == ASC_L6_MTF_FRICTION
                            || mtf_packet.conflict_class == ASC_L6_MTF_REVERSAL_RISK_BUILDING
                            || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED);
   bool conflict_block = (mtf_packet.conflict_class == ASC_L6_MTF_HARD_CONFLICT || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID);
   bool tradable = (normalized_packet.scalp_tradability == "yes" || normalized_packet.intraday_tradability == "yes");

   if(!workbench_packet.packet_valid || !workbench_packet.packet_lawful)
     {
      readiness_packet.deployability_class = ASC_L6_UNKNOWN_DEPLOYABILITY;
      readiness_packet.opportunity_status = ASC_L6_OPPORTUNITY_OBSERVE_ONLY;
      readiness_packet.readiness_class = ASC_L6_READINESS_UNKNOWN;
      readiness_packet.primary_blocker = "upstream_packet_unavailable";
      readiness_packet.downgrade_reason = "workbench packet is not lawful";
     }
   else if(conflict_block)
     {
      readiness_packet.deployability_class = ASC_L6_NOT_DEPLOYABLE;
      readiness_packet.opportunity_status = ASC_L6_OPPORTUNITY_STRUCTURE_INVALID;
      readiness_packet.readiness_class = ASC_L6_READINESS_BLOCKED;
      if(readiness_packet.primary_blocker == "none")
         readiness_packet.primary_blocker = "hard_mtf_conflict";
      if(readiness_packet.downgrade_reason == "none")
         readiness_packet.downgrade_reason = mtf_packet.conflict_reason_summary;
     }
   else if(missing_support)
     {
      readiness_packet.deployability_class = ASC_L6_WATCH_ONLY;
      readiness_packet.opportunity_status = ASC_L6_OPPORTUNITY_OBSERVE_ONLY;
      readiness_packet.readiness_class = ASC_L6_READINESS_OBSERVE;
      readiness_packet.primary_blocker = "upstream_support_missing";
      readiness_packet.downgrade_reason = normalized_packet.missing_surface_notes;
     }
   else if(!tradable)
     {
      readiness_packet.deployability_class = ASC_L6_WATCH_ONLY;
      readiness_packet.opportunity_status = ASC_L6_OPPORTUNITY_EXECUTION_INVALID;
      readiness_packet.readiness_class = ASC_L6_READINESS_CONDITIONAL;
      readiness_packet.primary_blocker = "tradability_not_confirmed";
      readiness_packet.downgrade_reason = "scalp and intraday tradability remain no";
     }
   else if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
     {
      readiness_packet.deployability_class = ASC_L6_WATCH_ONLY;
      readiness_packet.opportunity_status = ASC_L6_OPPORTUNITY_ELIGIBLE;
      readiness_packet.readiness_class = ASC_L6_READINESS_CONDITIONAL;
      if(readiness_packet.primary_blocker == "none")
         readiness_packet.primary_blocker = "geometry_unresolved";
      if(readiness_packet.downgrade_reason == "none")
         readiness_packet.downgrade_reason = geometry_packet.geometry_reason_summary;
     }
   else if(degraded_support)
     {
      readiness_packet.deployability_class = ASC_L6_DEPLOYABLE_DEGRADED;
      readiness_packet.opportunity_status = ASC_L6_OPPORTUNITY_ELIGIBLE_DEGRADED;
      readiness_packet.readiness_class = ASC_L6_READINESS_READY_DEGRADED;
      if(readiness_packet.primary_blocker == "none")
         readiness_packet.primary_blocker = "degraded_support";
      if(readiness_packet.downgrade_reason == "none")
         readiness_packet.downgrade_reason = normalized_packet.degraded_surface_notes;
     }
   else
     {
      readiness_packet.deployability_class = ASC_L6_DEPLOYABLE;
      readiness_packet.opportunity_status = ASC_L6_OPPORTUNITY_ELIGIBLE;
      readiness_packet.readiness_class = ASC_L6_READINESS_READY;
     }

   readiness_packet.horizon_class_text = ASC_L6HorizonClassToText(readiness_packet.horizon_class);
   readiness_packet.geometry_validity_text = ASC_L6GeometryValidityToText(readiness_packet.geometry_validity);
   readiness_packet.path_stage_posture = ASC_L6ResolvePathStagePosture(workbench_packet, normalized_packet, mtf_packet, geometry_packet, readiness_packet);
   readiness_packet.expiry_hint = ASC_L6ResolveExpiryHint(workbench_packet, mtf_packet, geometry_packet, readiness_packet);
   readiness_packet.deployability_class_text = ASC_L6ResolveDeployabilityDetailText(workbench_packet, normalized_packet, mtf_packet, geometry_packet, readiness_packet);
   readiness_packet.opportunity_status_text = ASC_L6OpportunityStatusToText(readiness_packet.opportunity_status);
   readiness_packet.readiness_class_text = ASC_L6ResolveReadinessDetailText(workbench_packet, normalized_packet, mtf_packet, geometry_packet, readiness_packet);
   readiness_packet.allowed_style = ASC_L6ResolveStyleShapingText(workbench_packet, normalized_packet, mtf_packet, geometry_packet, readiness_packet);
   readiness_packet.review_posture = ASC_L6ResolveReviewPostureText(workbench_packet, normalized_packet, mtf_packet, geometry_packet, readiness_packet);
   readiness_packet.downgrade_reason = ASC_L6ResolveDowngradeReasonText(workbench_packet, normalized_packet, mtf_packet, geometry_packet, readiness_packet);
   readiness_packet.why_not_top_rank_ready = ASC_L6ResolveWhyNotTopRankReadyText(workbench_packet, normalized_packet, mtf_packet, geometry_packet, readiness_packet);
   readiness_packet.readiness_reason_summary = StringFormat("deployability=%s | opportunity=%s | readiness=%s",
                                                            readiness_packet.deployability_class_text,
                                                            readiness_packet.opportunity_status_text,
                                                            readiness_packet.readiness_class_text);
   readiness_packet.blocked_by_summary = readiness_packet.primary_blocker;
   readiness_packet.next_revisit_trigger = ASC_L6ResolveRevisitTrigger(workbench_packet, normalized_packet, mtf_packet, geometry_packet, readiness_packet);
   readiness_packet.readiness_notes = StringFormat("allowed_style=%s | horizon=%s | geometry=%s | mtf=%s | timebox=%s",
                                                   readiness_packet.allowed_style,
                                                   readiness_packet.horizon_class_text,
                                                   readiness_packet.geometry_validity_text,
                                                   ASC_L6MtfConflictClassToText(mtf_packet.conflict_class),
                                                   geometry_packet.timebox_posture);
   return (workbench_packet.packet_valid && workbench_packet.packet_lawful);
  }

string ASC_L6ResolveTriggerFamilyCanon(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                        const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                        const ASC_L6_ReadinessPacket &readiness_packet)
  {
   ASC_L6_FamilyId family_id = geometry_packet.primary_family_id;
   bool contested = (workbench_packet.siam_primary_fit != "" && workbench_packet.siam_secondary_fit != "");
   string entry_reference_lower = ASC_L6LowercaseCopy(geometry_packet.entry_reference);

   if(readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED
      || readiness_packet.opportunity_status == ASC_L6_OPPORTUNITY_STRUCTURE_INVALID
      || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID)
      return "manual_review_only";

   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return "no_clean_trigger_family";

   if(family_id == ASC_L6_FAMILY_CONTINUATION)
     {
      if(StringFind(entry_reference_lower, "pullback") >= 0
         || StringFind(entry_reference_lower, "re entry") >= 0
         || workbench_packet.pullback_quality_score >= 56.0
         || workbench_packet.pullback_depth_score >= 56.0)
         return "pullback_confirm";
      return "continuation_hold_confirm";
     }
   if(family_id == ASC_L6_FAMILY_RECLAIM)
      return "reclaim_confirm";
   if(family_id == ASC_L6_FAMILY_FAILED_BREAK)
      return "range_boundary_confirm";
   if(family_id == ASC_L6_FAMILY_BREAKOUT_EXPANSION)
     {
      if(workbench_packet.pullback_quality_score >= 58.0 || workbench_packet.pullback_depth_score >= 58.0)
         return "breakout_retest_confirm";
      return "continuation_hold_confirm";
     }
   if(family_id == ASC_L6_FAMILY_BALANCE_ROTATION)
      return "range_boundary_confirm";
   if(family_id == ASC_L6_FAMILY_REVERSAL)
      return "rejection_confirm";

   if(contested && readiness_packet.readiness_class != ASC_L6_READINESS_READY)
      return "manual_review_only";

   if(workbench_packet.reclaim_score >= 58.0)
      return "reclaim_confirm";
   if(workbench_packet.failed_break_score >= 58.0 || workbench_packet.session_sweep_score >= 58.0)
      return "range_boundary_confirm";
   if(workbench_packet.pullback_quality_score >= 58.0 || workbench_packet.pullback_depth_score >= 58.0)
      return "pullback_confirm";
   if(workbench_packet.continuation_readiness_score >= 60.0)
      return "continuation_hold_confirm";
   if(workbench_packet.reversal_pressure_score >= 58.0 || workbench_packet.trap_pressure_score >= 58.0)
      return "rejection_confirm";

   return "no_clean_trigger_family";
  }

string ASC_L6ResolveTriggerCanonNote(const ASC_L6_MaturityPacket &maturity_packet,
                                     const ASC_L6_ReadinessPacket &readiness_packet,
                                     const ASC_L6_GeometryCandidatePacket &geometry_packet)
  {
   if(maturity_packet.trigger_family_state == "manual_review_only")
      return "Trigger canon is intentionally withheld to manual review because geometry, readiness, or conflict pressure still blocks a clean family";
   if(maturity_packet.trigger_family_state == "no_clean_trigger_family")
      return "Trigger canon remains intentionally unresolved; wait for clearer defended-zone behavior without inventing execution detail";
   if(readiness_packet.readiness_class == ASC_L6_READINESS_READY
      && geometry_packet.geometry_validity == ASC_L6_GEOMETRY_VALID)
      return "Canonical trigger family is stable enough for non-executing handoff interpretation only; it is not a broker order instruction";
   return "Canonical trigger family is bounded guidance for selected-symbol review only and still requires confirmation inside the existing Layer 6 boundary";
  }

bool ASC_L6ExpiryHintSignalsHardExpiry(const string expiry_hint)
  {
   string lowered = ASC_L6LowercaseCopy(expiry_hint);
   if(StringLen(lowered) <= 0)
      return false;
   if(StringFind(lowered, "still alive") >= 0
      || StringFind(lowered, "preserved") >= 0
      || StringFind(lowered, "review") >= 0
      || StringFind(lowered, "contested") >= 0)
      return false;
   return (StringFind(lowered, "expired") >= 0
           || StringFind(lowered, "invalidated") >= 0
           || StringFind(lowered, "stale / expired") >= 0
           || StringFind(lowered, "passed beyond") >= 0);
  }

string ASC_L6ResolveMaturityState(const ASC_L6_ReadinessPacket &readiness_packet,
                                  const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                  const ASC_L6_HandoffPacket &handoff_packet,
                                  const string trigger_family_state)
  {
   bool trigger_is_canonical = (trigger_family_state == "reclaim_confirm"
                                || trigger_family_state == "pullback_confirm"
                                || trigger_family_state == "range_boundary_confirm"
                                || trigger_family_state == "breakout_retest_confirm"
                                || trigger_family_state == "rejection_confirm"
                                || trigger_family_state == "continuation_hold_confirm");

   if(ASC_L6ExpiryHintSignalsHardExpiry(readiness_packet.expiry_hint))
      return "expired";

   if(readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED
      || readiness_packet.opportunity_status == ASC_L6_OPPORTUNITY_STRUCTURE_INVALID
      || readiness_packet.opportunity_status == ASC_L6_OPPORTUNITY_EXECUTION_INVALID
      || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID)
      return "blocked";

   if(handoff_packet.handoff_available
      && geometry_packet.geometry_validity == ASC_L6_GEOMETRY_VALID
      && readiness_packet.readiness_class == ASC_L6_READINESS_READY)
      return "handoff_ready";

   if(trigger_is_canonical
      && (readiness_packet.readiness_class == ASC_L6_READINESS_READY
          || readiness_packet.readiness_class == ASC_L6_READINESS_READY_DEGRADED
          || readiness_packet.readiness_class == ASC_L6_READINESS_CONDITIONAL)
      && (geometry_packet.geometry_validity == ASC_L6_GEOMETRY_VALID
          || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED))
      return "prepare_with_trigger_only";

   if(readiness_packet.readiness_class == ASC_L6_READINESS_READY
      || readiness_packet.readiness_class == ASC_L6_READINESS_READY_DEGRADED
      || readiness_packet.readiness_class == ASC_L6_READINESS_CONDITIONAL
      || readiness_packet.deployability_class == ASC_L6_DEPLOYABLE_DEGRADED)
      return "prepare";

   if(readiness_packet.readiness_class == ASC_L6_READINESS_OBSERVE
      || readiness_packet.deployability_class == ASC_L6_WATCH_ONLY
      || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return "watch";

   return "ignore";
  }

string ASC_L6ResolveMaturityReasonSummary(const ASC_L6_ReadinessPacket &readiness_packet,
                                          const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                          const ASC_L6_HandoffPacket &handoff_packet,
                                          const string maturity_state,
                                          const string trigger_family_state)
  {
   return StringFormat("state=%s | readiness=%s | deployability=%s | geometry=%s | trigger_family=%s | handoff=%s",
                       maturity_state,
                       readiness_packet.readiness_class_text,
                       readiness_packet.deployability_class_text,
                       readiness_packet.geometry_validity_text,
                       trigger_family_state,
                       handoff_packet.handoff_availability_state);
  }

string ASC_L6ResolveMaturityPromotionCondition(const ASC_L6_ReadinessPacket &readiness_packet,
                                               const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                               const string trigger_family_state)
  {
   if(readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED
      || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID)
      return "Promotion requires geometry validity to recover and the current blocker to clear on the next lawful selected-symbol review";
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return "Promotion requires bounded geometry to resolve into a defended path with a lawful canonical trigger family";
   if(trigger_family_state == "manual_review_only" || trigger_family_state == "no_clean_trigger_family")
      return "Promotion requires a clean canonical trigger family to emerge without adding execution semantics";
   if(readiness_packet.readiness_class == ASC_L6_READINESS_READY_DEGRADED
      || readiness_packet.deployability_class == ASC_L6_DEPLOYABLE_DEGRADED)
      return "Promotion requires degraded support or friction pressure to improve while geometry stays valid";
   if(readiness_packet.readiness_class == ASC_L6_READINESS_READY)
      return "Promotion requires the current valid path to survive confirmation and remain consumable for non-executing handoff";
   return "Promotion requires stronger selected-symbol confirmation, cleaner geometry, and lower blocker pressure";
  }

string ASC_L6ResolveMaturityDemotionCondition(const ASC_L6_ReadinessPacket &readiness_packet,
                                              const ASC_L6_GeometryCandidatePacket &geometry_packet)
  {
   if(!ASC_L6ExpiryHintSignalsHardExpiry(readiness_packet.expiry_hint)
      && StringFind(ASC_L6LowercaseCopy(readiness_packet.expiry_hint), "expire") >= 0)
      return "Any further delay beyond the current bounded expiry window demotes the path";
   if(ASC_L6ExpiryHintSignalsHardExpiry(readiness_packet.expiry_hint))
      return "Demotion remains active because the current path is already beyond its lawful review window or invalidated";
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_VALID)
      return "Demotion occurs if geometry degrades, the blocker returns, or trigger confirmation fails on review";
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED)
      return "Demotion occurs if degraded support hardens into invalid geometry or tradability conflict";
   return "Demotion occurs if the current blocker persists or the next lawful review still fails to restore support";
  }

bool ASC_BuildL6MaturityPacket(const ASC_Layer5WorkbenchPacket &workbench_packet,
                               const ASC_L6_GeometryCandidatePacket &geometry_packet,
                               const ASC_L6_ReadinessPacket &readiness_packet,
                               const ASC_L6_HandoffPacket &handoff_packet,
                               ASC_L6_MaturityPacket &maturity_packet)
  {
   maturity_packet.lineage = workbench_packet.lineage;
   maturity_packet.availability = workbench_packet.availability;
   maturity_packet.maturity_blocker_summary = ASC_L6_DefaultOrValue(readiness_packet.primary_blocker, ASC_L6_DefaultOrValue(geometry_packet.blocker_summary, "none"));
   maturity_packet.trigger_family_state = ASC_L6ResolveTriggerFamilyCanon(workbench_packet, geometry_packet, readiness_packet);
   maturity_packet.maturity_state = ASC_L6ResolveMaturityState(readiness_packet, geometry_packet, handoff_packet, maturity_packet.trigger_family_state);
   maturity_packet.maturity_reason_summary = ASC_L6ResolveMaturityReasonSummary(readiness_packet,
                                                                                geometry_packet,
                                                                                handoff_packet,
                                                                                maturity_packet.maturity_state,
                                                                                maturity_packet.trigger_family_state);
   maturity_packet.maturity_promotion_condition = ASC_L6ResolveMaturityPromotionCondition(readiness_packet,
                                                                                          geometry_packet,
                                                                                          maturity_packet.trigger_family_state);
   maturity_packet.maturity_demotion_condition = ASC_L6ResolveMaturityDemotionCondition(readiness_packet, geometry_packet);
   maturity_packet.maturity_boundary_note = "Selected-symbol only | explicit deep path only | consumer-only | no Board override | no order placement authority";
   maturity_packet.trigger_canon_note = ASC_L6ResolveTriggerCanonNote(maturity_packet, readiness_packet, geometry_packet);
   maturity_packet.maturity_notes = StringFormat("expiry=%s | review=%s | handoff=%s",
                                                 ASC_L6_DefaultOrValue(readiness_packet.expiry_hint, "pending clearer trigger"),
                                                 ASC_L6_DefaultOrValue(readiness_packet.review_posture, "review_with_deep_and_board_context"),
                                                 handoff_packet.handoff_availability_state);
   return (workbench_packet.packet_valid && workbench_packet.packet_lawful);
  }

bool ASC_BuildL6SemiAutoSurfacePacket(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                      const ASC_L6_NormalizedContextPacket &normalized_packet,
                                      const ASC_L6_MtfPosturePacket &mtf_packet,
                                      const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                      const ASC_L6_ReadinessPacket &readiness_packet,
                                      ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   surface_packet.lineage = workbench_packet.lineage;
   surface_packet.availability = workbench_packet.availability;
   surface_packet.readiness_class = readiness_packet.readiness_class;
   surface_packet.deployability_class = readiness_packet.deployability_class;
   surface_packet.opportunity_status = readiness_packet.opportunity_status;
   surface_packet.active_horizon = readiness_packet.horizon_class;
   surface_packet.competition_status = (workbench_packet.siam_primary_fit != "" && workbench_packet.siam_secondary_fit != "" ? ASC_L6_CONTESTED_PRIMARY : (workbench_packet.siam_primary_fit != "" ? ASC_L6_CLEAR_PRIMARY : ASC_L6_DEFERRED_CLASSIFICATION));
   surface_packet.geometry_validity = readiness_packet.geometry_validity;
   surface_packet.strongest_family_now = ASC_L6FamilyFromFitName(workbench_packet.siam_primary_fit);
   surface_packet.strongest_alternate_family = ASC_L6FamilyFromFitName(workbench_packet.siam_secondary_fit);
   surface_packet.strongest_family_now_text = ASC_L6FamilyIdToText(surface_packet.strongest_family_now);
   surface_packet.strongest_alternate_family_text = ASC_L6FamilyIdToText(surface_packet.strongest_alternate_family);
   surface_packet.directional_posture = ASC_L6_DefaultOrValue(workbench_packet.micro_direction, ASC_L6_DefaultOrValue(workbench_packet.alignment, "unavailable"));
   surface_packet.deployability_class_text = readiness_packet.deployability_class_text;
   surface_packet.opportunity_status_text = readiness_packet.opportunity_status_text;
   surface_packet.readiness_class_text = readiness_packet.readiness_class_text;
   surface_packet.allowed_style = readiness_packet.allowed_style;
   surface_packet.geometry_validity_posture = readiness_packet.geometry_validity_text;
   surface_packet.geometry_primary_summary = geometry_packet.primary_candidate_summary;
   surface_packet.geometry_alternate_summary = geometry_packet.alternate_candidate_summary;
   surface_packet.geometry_entry_path_summary = geometry_packet.entry_reference;
   surface_packet.geometry_invalidation_path_summary = geometry_packet.invalidation_reference;
   surface_packet.geometry_target_path_summary = geometry_packet.target_reference;
   surface_packet.geometry_timebox_posture = geometry_packet.timebox_posture;
   surface_packet.geometry_execution_burden_posture = geometry_packet.execution_burden_posture;
   surface_packet.geometry_review_burden_posture = geometry_packet.review_burden_posture;
   surface_packet.geometry_timing_posture = geometry_packet.timing_posture;
   surface_packet.geometry_reason_summary = geometry_packet.geometry_reason_summary;
   surface_packet.geometry_blocker_summary = geometry_packet.blocker_summary;
   surface_packet.primary_blocker = readiness_packet.primary_blocker;
   surface_packet.path_stage_posture = readiness_packet.path_stage_posture;
   surface_packet.expiry_hint = readiness_packet.expiry_hint;
   surface_packet.revisit_trigger_summary = readiness_packet.next_revisit_trigger;
   surface_packet.family_confidence_posture = ((workbench_packet.siam_primary_fit_posture != "" && workbench_packet.siam_secondary_fit_posture != "") ? (workbench_packet.siam_primary_fit_posture + " vs " + workbench_packet.siam_secondary_fit_posture) : ASC_L6_DefaultOrValue(workbench_packet.siam_primary_fit_posture, "family_confidence_unresolved"));
   surface_packet.lineage_workbench_ref = workbench_packet.source_result_revision;
   surface_packet.lineage_normalized_context_ref = normalized_packet.packet_ref;
   surface_packet.lineage_mtf_posture_ref = mtf_packet.conflict_reason_summary;
   surface_packet.lineage_geometry_ref = geometry_packet.geometry_reason_summary;
   surface_packet.lineage_readiness_ref = readiness_packet.readiness_reason_summary;
   surface_packet.operator_surface_summary = StringFormat("family=%s | deployability=%s | opportunity=%s | readiness=%s | geometry=%s | style=%s",
                                                         surface_packet.strongest_family_now_text,
                                                         surface_packet.deployability_class_text,
                                                         surface_packet.opportunity_status_text,
                                                         surface_packet.readiness_class_text,
                                                         surface_packet.geometry_validity_posture,
                                                         surface_packet.allowed_style);
   surface_packet.preserve_revisit_summary = StringFormat("stage=%s | preserved alternate=%s | expiry=%s | next review=%s",
                                                          surface_packet.path_stage_posture,
                                                          surface_packet.strongest_alternate_family_text,
                                                          surface_packet.expiry_hint,
                                                          surface_packet.revisit_trigger_summary);
   surface_packet.section_lineage_summary = StringFormat("workbench=%s | normalized=%s | mtf=%s | geometry=%s | readiness=%s",
                                                         surface_packet.lineage_workbench_ref,
                                                         surface_packet.lineage_normalized_context_ref,
                                                         ASC_L6MtfConflictClassToText(mtf_packet.conflict_class),
                                                         surface_packet.lineage_geometry_ref,
                                                         surface_packet.lineage_readiness_ref);
   surface_packet.surface_notes = StringFormat("selected_symbol_surface_only | primary_reason=%s | alternate_reason=%s | geometry_blocker=%s",
                                               ASC_L6_DefaultOrValue(workbench_packet.siam_primary_fit_reason, "primary_family_unavailable"),
                                               ASC_L6_DefaultOrValue(workbench_packet.siam_secondary_fit_reason, "secondary_family_unavailable"),
                                               surface_packet.geometry_blocker_summary);
   return (workbench_packet.packet_valid && workbench_packet.packet_lawful);
  }

string ASC_L6ResolveTriggerFamilyDescription(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                             const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                             const ASC_L6_ReadinessPacket &readiness_packet)
  {
   string canon = ASC_L6ResolveTriggerFamilyCanon(workbench_packet, geometry_packet, readiness_packet);
   if(canon == "reclaim_confirm")
      return "reclaim confirm";
   if(canon == "pullback_confirm")
      return "pullback confirm";
   if(canon == "range_boundary_confirm")
      return "range boundary confirm";
   if(canon == "breakout_retest_confirm")
      return "breakout retest confirm";
   if(canon == "rejection_confirm")
      return "rejection confirm";
   if(canon == "continuation_hold_confirm")
      return "continuation hold confirm";
   if(canon == "manual_review_only")
      return "manual review only";
   return "no clean trigger family";
  }

string ASC_L6ResolveHandoffAvailabilityState(const ASC_L6_GeometryCandidatePacket &geometry_packet,
                                             const ASC_L6_ReadinessPacket &readiness_packet)
  {
   if(readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED
      || readiness_packet.deployability_class == ASC_L6_NOT_DEPLOYABLE
      || geometry_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID)
      return "handoff_blocked_by_geometry_readiness_or_conflict";
   if(geometry_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return "handoff_requires_trigger_confirmation";
   if(readiness_packet.readiness_class == ASC_L6_READINESS_READY
      && geometry_packet.geometry_validity == ASC_L6_GEOMETRY_VALID)
      return "handoff_ready_for_future_layer7_interpretation";
   if(readiness_packet.readiness_class == ASC_L6_READINESS_OBSERVE
      || readiness_packet.deployability_class == ASC_L6_WATCH_ONLY)
      return "handoff_review_only";
   return "handoff_requires_patience_and_manual_review";
  }

string ASC_L6ResolveHandoffSafetyBoundaryNote(const ASC_L6_ReadinessPacket &readiness_packet,
                                              const ASC_L6_GeometryCandidatePacket &geometry_packet)
  {
   string state = ASC_L6ResolveHandoffAvailabilityState(geometry_packet, readiness_packet);
   if(state == "handoff_ready_for_future_layer7_interpretation")
      return "Non-executing Layer 6 handoff only: zone families are prepared for future Layer 7 interpretation with no order, sizing, stop, or target command emitted here";
   if(state == "handoff_requires_trigger_confirmation")
      return "Non-executing Layer 6 handoff stays withheld until trigger-family confirmation clears; no broker-level execution semantics are allowed here";
   if(state == "handoff_blocked_by_geometry_readiness_or_conflict")
      return "Non-executing Layer 6 handoff is blocked by geometry, readiness, or conflict pressure; no execution authority can be implied here";
   if(state == "handoff_review_only")
      return "Non-executing Layer 6 handoff remains review-only; Board authority and manual review stay primary";
   return "Non-executing Layer 6 handoff remains bounded to manual review and patience; no execution automation is emitted here";
  }

bool ASC_BuildL6HandoffPacket(const ASC_Layer5WorkbenchPacket &workbench_packet,
                              const ASC_L6_GeometryCandidatePacket &geometry_packet,
                              const ASC_L6_ReadinessPacket &readiness_packet,
                              const ASC_L6_SemiAutoSurfacePacket &surface_packet,
                              ASC_L6_HandoffPacket &handoff_packet)
  {
   handoff_packet.lineage = workbench_packet.lineage;
   handoff_packet.availability = workbench_packet.availability;
   handoff_packet.packet_valid = (workbench_packet.packet_valid && workbench_packet.packet_lawful);
   handoff_packet.packet_lawful = handoff_packet.packet_valid;
   handoff_packet.review_timestamp_utc = workbench_packet.source_build_utc;
   handoff_packet.review_timestamp_text = "";
   handoff_packet.review_revision_context = ASC_L6_DefaultOrValue(workbench_packet.source_result_revision, "l6_handoff_revision_unavailable");
   handoff_packet.packet_ref = StringFormat("L6-L7-HANDOFF|%s|%s|%s",
                                            ASC_L6_DefaultOrValue(workbench_packet.lineage.canonical_symbol, workbench_packet.lineage.symbol),
                                            ASC_L6_DefaultOrValue(workbench_packet.source_result_revision, "no_revision"),
                                            ASC_L6_DefaultOrValue(ASC_L6FamilyIdToText(geometry_packet.primary_family_id), "unknown_family"));
   handoff_packet.symbol = ASC_L6_DefaultOrValue(workbench_packet.lineage.symbol, "unknown_symbol");
   handoff_packet.canonical_symbol = ASC_L6_DefaultOrValue(workbench_packet.lineage.canonical_symbol, handoff_packet.symbol);
   handoff_packet.primary_family = ASC_L6OperatorFitName(workbench_packet.siam_primary_fit, "Unresolved");
   handoff_packet.alternate_family = ASC_L6OperatorFitName(workbench_packet.siam_secondary_fit, "Unresolved");
   handoff_packet.stage_posture = ASC_L6OperatorLabel(surface_packet.path_stage_posture, "developing");
   handoff_packet.deployability_class = ASC_L6OperatorLabel(surface_packet.deployability_class_text, "Unavailable");
   handoff_packet.readiness_class = ASC_L6OperatorLabel(surface_packet.readiness_class_text, "Unavailable");
   handoff_packet.geometry_validity_posture = ASC_L6ResolveGeometryValidityText(surface_packet.geometry_validity);
   handoff_packet.horizon_class = ASC_L6OperatorLabel(readiness_packet.horizon_class_text, "bounded horizon unresolved");
   handoff_packet.allowed_style = ASC_L6OperatorStyleHint(surface_packet.allowed_style);
   handoff_packet.expiry_hint = ASC_L6OperatorLabel(surface_packet.expiry_hint, "pending clearer trigger");
   handoff_packet.primary_blocker = ASC_L6OperatorLabel(readiness_packet.primary_blocker, "None");
   handoff_packet.downgrade_reason = ASC_L6OperatorLabel(readiness_packet.downgrade_reason, "None");
   handoff_packet.trigger_family_description = ASC_L6ResolveTriggerFamilyDescription(workbench_packet, geometry_packet, readiness_packet);
   handoff_packet.entry_zone_family_description = ASC_L6OperatorLabel(surface_packet.geometry_entry_path_summary, "Entry-zone family unresolved");
   handoff_packet.invalidation_zone_family_description = ASC_L6OperatorLabel(surface_packet.geometry_invalidation_path_summary, "Invalidation-zone family unresolved");
   handoff_packet.target_zone_family_description = ASC_L6OperatorLabel(surface_packet.geometry_target_path_summary, "Target-zone family unresolved");
   handoff_packet.review_posture = ASC_L6OperatorLabel(readiness_packet.review_posture, "review with deep and board context");
   handoff_packet.execution_burden_posture = ASC_L6OperatorLabel(surface_packet.geometry_execution_burden_posture, "Execution burden unresolved");
   handoff_packet.timebox_posture = ASC_L6OperatorLabel(surface_packet.geometry_timebox_posture, ASC_L6OperatorLabel(readiness_packet.horizon_class_text, "review window unresolved"));
   handoff_packet.confirmation_burden = ASC_L6OperatorLabel(surface_packet.geometry_review_burden_posture, "Review burden unresolved");
   handoff_packet.handoff_availability_state = ASC_L6ResolveHandoffAvailabilityState(geometry_packet, readiness_packet);
   handoff_packet.requires_trigger_confirmation = (handoff_packet.handoff_availability_state == "handoff_requires_trigger_confirmation");
   handoff_packet.requires_patience_review = (handoff_packet.handoff_availability_state == "handoff_review_only"
                                              || handoff_packet.handoff_availability_state == "handoff_requires_patience_and_manual_review");
   handoff_packet.handoff_available = (handoff_packet.handoff_availability_state == "handoff_ready_for_future_layer7_interpretation");
   handoff_packet.safety_boundary_state = (handoff_packet.handoff_available ? "non_executing_ready_boundary" : "non_executing_review_boundary");
   handoff_packet.safety_boundary_note = ASC_L6ResolveHandoffSafetyBoundaryNote(readiness_packet, geometry_packet);
   handoff_packet.handoff_reason_summary = StringFormat("availability=%s | trigger=%s | stage=%s | readiness=%s | deployability=%s",
                                                        handoff_packet.handoff_availability_state,
                                                        handoff_packet.trigger_family_description,
                                                        handoff_packet.stage_posture,
                                                        handoff_packet.readiness_class,
                                                        handoff_packet.deployability_class);
   handoff_packet.handoff_notes = StringFormat("selected_symbol_only | explicit_deep_path_only | consumer_only | no_board_override | no_order_object | no_sizing | no_tp_sl | packet_ref=%s",
                                               handoff_packet.packet_ref);
   return handoff_packet.packet_valid;
  }

bool ASC_BuildL6DormantPacketChain(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                   ASC_L6_NormalizedContextPacket &normalized_packet,
                                   ASC_L6_MtfPosturePacket &mtf_packet,
                                   ASC_L6_GeometryCandidatePacket &geometry_packet,
                                   ASC_L6_ReadinessPacket &readiness_packet,
                                   ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   bool normalized_ok = ASC_BuildL6NormalizedContextPacket(workbench_packet, normalized_packet);
   bool mtf_ok = ASC_BuildL6MtfPosturePacket(workbench_packet, mtf_packet);
   bool geometry_ok = ASC_BuildL6GeometryCandidatePacket(workbench_packet, normalized_packet, mtf_packet, geometry_packet);
   bool readiness_ok = ASC_BuildL6ReadinessPacket(workbench_packet, normalized_packet, mtf_packet, geometry_packet, readiness_packet);
   bool surface_ok = ASC_BuildL6SemiAutoSurfacePacket(workbench_packet, normalized_packet, mtf_packet, geometry_packet, readiness_packet, surface_packet);
   return (normalized_ok && mtf_ok && geometry_ok && readiness_ok && surface_ok);
  }

#endif
