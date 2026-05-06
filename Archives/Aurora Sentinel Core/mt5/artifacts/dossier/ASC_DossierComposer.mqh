#ifndef __ASC_DOSSIER_COMPOSER_MQH__
#define __ASC_DOSSIER_COMPOSER_MQH__

#include "../ASC_ArtifactTextHelpers.mqh"
#include "../ASC_ConsumerVisibilityProof.mqh"
#include "ASC_DossierContracts.mqh"
#include "deep_selective_analysis/ASC_DossierDeepSectionPolicy.mqh"
#include "ASC_DossierScaffold.mqh"
#include "ASC_DossierSectionCommon.mqh"
#include "../../core/ASC_Constants.mqh"
#include "../../core/ASC_Version.mqh"
#include "../../market_state/ASC_MarketStateEngine.mqh"
#include "../../open_symbol_snapshot/ASC_OpenSymbolSnapshotEngine.mqh"
#include "../../candidate_filtering/ASC_SelectionFilter.mqh"
#include "../../shortlist_selection/ASC_ShortlistSelectionEngine.mqh"
#include "../../shortlist_selection/ASC_ATRSummaryEngine.mqh"
#include "../../shortlist_selection/ASC_RegimeSummaryEngine.mqh"
#include "../../shortlist_selection/ASC_LiquidityFrictionSummaryEngine.mqh"
#include "../../deep_selective_analysis/ASC_DeepSelectiveAnalysisEngine.mqh"
#include "../../semi_auto_trading/ASC_SemiAutoEngine.mqh"
#include "semi_auto_trading/ASC_DossierStrategyCompetitionSection.mqh"
#include "semi_auto_trading/ASC_DossierTimeframePressureSection.mqh"
#include "semi_auto_trading/ASC_DossierOpportunityPathsSection.mqh"
#include "semi_auto_trading/ASC_DossierGeometryWorkbenchSection.mqh"
#include "semi_auto_trading/ASC_DossierSemiAutoReadinessSection.mqh"
#include "semi_auto_trading/ASC_DossierPreserveRevisitSection.mqh"
#include "../../io/ASC_FileIO.mqh"

string ASC_TimeSeriesValueOrUnavailable(const string symbol,
                                        const ENUM_TIMEFRAMES timeframe,
                                        const int shift,
                                        const int mode)
  {
   double value = 0.0;
   if(mode == 0)
      value = iOpen(symbol, timeframe, shift);
   else if(mode == 1)
      value = iHigh(symbol, timeframe, shift);
   else
      value = iLow(symbol, timeframe, shift);

   if(value <= 0.0)
      return "unavailable";
   long digits_raw = 5;
   if(!SymbolInfoInteger(symbol, SYMBOL_DIGITS, digits_raw) || digits_raw < 0)
      digits_raw = 5;
   int digits = (int)MathMin(10, digits_raw);
   return DoubleToString(value, digits);
  }

string ASC_DossierLiveSectionReason(const ASC_Layer1SymbolState &symbol_state,
                                    const bool has_packet,
                                    const bool has_market_watch,
                                    const ASC_Layer2Packet &packet)
  {
   if(has_market_watch)
      return "live market watch snapshot refreshed for the current dossier publish";
   if(has_packet && packet.continuity_backed)
      return "continuity-backed market-watch snapshot retained while completion is pending";
   if(symbol_state.state == ASC_L1_CLOSED)
      return "market watch is unavailable because the current session is closed";
   if(has_packet && packet.hydration_gate_code == "blocked_by_warmup")
      return "market watch is still building during warmup";
   if(has_packet && packet.hydration_reason_code == "spec_owner_hard_absence_confirmed")
      return "market watch has a confirmed hard-absence constraint from broker specification ownership";
   if(has_packet && packet.hydration_family != ASC_L2_HYDRATION_READY)
      return "market watch completion is pending on the active repair queue";
   return "market watch is building for the current dossier publish";
  }

string ASC_DossierFreshnessLabel(const ASC_Layer1SymbolState &symbol_state,
                                 const bool has_market_watch,
                                 const ASC_Layer2Packet &packet)
  {
   if(has_market_watch)
      return ASC_L2FreshnessToOperatorText(packet.freshness);

   if(symbol_state.state == ASC_L1_CLOSED)
      return "Unavailable (Closed Session)";

   if(packet.hydration_gate_code == "blocked_by_warmup")
      return "Warmup Pending";
   if(packet.hydration_reason_code == "spec_owner_hard_absence_confirmed")
      return "Hard Unavailable";
   if(packet.continuity_backed)
      return "Retained (Completion Pending)";
   if(packet.hydration_family != ASC_L2_HYDRATION_READY)
      return "Completion Pending";

   return ASC_L1FreshnessToOperatorText(symbol_state);
  }

string ASC_DossierOrdinaryL34GuardReason(const ASC_Layer1SymbolState &symbol_state,
                                          const bool has_packet,
                                          const bool has_market_watch,
                                          const ASC_Layer2Packet &packet,
                                          const bool shortlist_found,
                                          const ASC_SelectionFilterEvaluation &filter,
                                          const bool layer4_context)
  {
   if(!ASC_ConsumerAllowsOrdinaryL34(symbol_state))
      return "closed-market not entitled to ordinary Layer-3/4 meaning";

   if(has_packet && packet.hydration_gate_code == "blocked_by_warmup")
      return "warmup pending packet";

   if(has_packet && packet.hydration_reason_code == "spec_owner_hard_absence_confirmed")
      return "data unavailable";

   if(!has_packet)
      return "data unavailable";

   if(!has_market_watch && packet.continuity_backed)
      return "support partial / provisional";

   if(!has_market_watch && packet.hydration_family != ASC_L2_HYDRATION_READY)
      return "support partial / provisional";

   if(layer4_context && !shortlist_found)
     {
      if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
         return "support partial / provisional";
      if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
         return "ordinary Layer-4 shortlist context unavailable";
      return "ordinary Layer-4 data unavailable";
     }

   return "lawful ordinary Layer-3/4 support";
  }


string ASC_DossierRankText(const int rank,const string unavailable_text="unranked")
  {
   return (rank > 0) ? ("#" + IntegerToString(rank)) : unavailable_text;
  }

string ASC_DossierBucketMembershipText(const ASC_ShortlistSymbolSummary &entry)
  {
   return ASC_ShortlistMembershipScopeReadbackText(entry);
  }

string ASC_DossierOverallBoardContextText(const ASC_ShortlistSymbolSummary &entry)
  {
   return ASC_ShortlistRankStackReadbackText(entry, 10);
  }

string ASC_DossierOverallBoardStatusText(const ASC_ShortlistSymbolSummary &entry)
  {
   if(ASC_ShortlistHasLawfulMembership(entry))
      return StringFormat("diversified overall-board member | overall rank #%d", entry.rank);
   if(ASC_ShortlistHasLawfulBucketMembership(entry))
      return "bucket-local reserve outside diversified overall board | bucket-local strength confirmed";
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "reserve only outside bucket top-5 and diversified overall board";
   if(entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "overall-board status pending upstream shortlist context";
   return "not admitted to diversified overall board";
  }

string ASC_DossierTacticalStackLine(const ASC_SelectionFilterEvaluation &filter)
  {
   if(!filter.score_pack_ready)
      return ASC_TextOrUnavailable(filter.score_pack_summary);

   string burst_text = filter.tick_burst_flag ? "burst yes" : "burst no";
   return StringFormat("participation %.1f (%s) | execution %.1f (%s) | liquidity %.1f (%s %s) | pressure %.1f (%s) | momentum %.1f (%s) | timing %.1f (%s) | move age %.1f (%s) | %s | %s",
                       filter.participation_score,
                       ASC_ArtifactHumanizeLabel(filter.participation_posture),
                       filter.execution_score,
                       ASC_ArtifactHumanizeLabel(filter.execution_posture),
                       filter.liquidity_proximity_score,
                       ASC_ArtifactHumanizeLabel(filter.liquidity_proximity_posture),
                       ASC_ArtifactHumanizeLabel(filter.liquidity_zone),
                       filter.pressure_shift_score,
                       ASC_ArtifactHumanizeLabel(filter.pressure_shift_posture),
                       filter.momentum_acceleration_score,
                       ASC_ArtifactHumanizeLabel(filter.momentum_acceleration_posture),
                       filter.timing_quality_score,
                       ASC_ArtifactHumanizeLabel(filter.timing_quality_posture),
                       filter.move_age_score,
                       ASC_ArtifactHumanizeLabel(filter.move_age_posture),
                       burst_text,
                       ASC_SelectionFilterOverlaySummary(filter));
  }

string ASC_DossierShortlistOpportunityShapeLine(const ASC_ShortlistSymbolSummary &entry)
  {
   string execution_usefulness = ASC_ShortlistExecutionUsefulnessLabel(entry);
   string timing_usefulness = ASC_ShortlistTimingUsefulnessLabel(entry);
   string risk_drag_label = ASC_ShortlistRiskDragLabel(entry);

   return StringFormat("context %.1f | execution %.1f (%s) | spread stability %.1f | quote stability %.1f | timing %.1f (%s) | risk drag %.1f (%s) | %s | late %.1f",
                       entry.filter.context_strength_score,
                       entry.filter.execution_alignment_score,
                       execution_usefulness,
                       entry.filter.spread_stability_score,
                       entry.filter.quote_stability_score,
                       entry.filter.entry_readiness_score,
                       timing_usefulness,
                       entry.filter.risk_drag_score,
                       risk_drag_label,
                       ASC_SelectionFilterOverlaySummary(entry.filter),
                       entry.filter.late_move_risk_score);
  }

string ASC_DossierShortlistFieldContextLine(const ASC_ShortlistSymbolSummary &entry)
  {
   string field_regime = ASC_TextOrUnavailable(entry.field_opportunity_regime);
   if(field_regime != "Unavailable")
     {
      if(field_regime == "thin_day_best_available")
         field_regime = "selective day";
      else
         field_regime = ASC_ArtifactHumanizeLabel(field_regime);
     }

   return StringFormat("relative %.1f | rank blend %.1f | field %s | leader separation %.1f | top-10 compression %.1f",
                       entry.relative_opportunity_percentile,
                       entry.relative_field_rank_score,
                       field_regime,
                       entry.leader_separation_score,
                       entry.top10_compression_score);
  }

string ASC_DossierShortlistDayFraming(const ASC_ShortlistSymbolSummary &entry)
  {
   if(entry.field_opportunity_regime == "thin_day_best_available")
      return "best available on a selective day";
   if(entry.field_opportunity_regime == "rare_clean_day" && entry.rank == 1)
      return "high-quality leader on a rare clean day";
   if(entry.field_opportunity_regime == "strong_day" && entry.rank > 0 && entry.rank <= 3)
      return "high-quality symbol on a strong day";
   if(entry.field_opportunity_regime == "workable_day")
      return "credible board member on a workable day";
   if(entry.rank > 0)
      return "credible board member relative to the active field";
   return "relative field read is awaiting the next shortlist pass";
  }

string ASC_DossierDeepPacketSummary(const bool deep_completed,
                                    const bool deep_preserved,
                                    const bool has_deep_result,
                                    const ASC_DeepSelectiveAnalysisResult &deep_result)
  {
   if(has_deep_result && deep_result.built && deep_result.lawful)
     {
      return StringFormat("explicit selected-symbol deep packet refreshed now | freshness %s | pressure %.1f (%s) | momentum %.1f (%s) | move age %.1f (%s) | liquidity %.1f (%s %s) | participation %.1f (%s) | execution %.1f (%s) | burst %.1f (%s)",
                          ASC_TextOrUnavailable(deep_result.freshness_posture),
                          deep_result.pressure_shift_score,
                          ASC_ArtifactHumanizeLabel(deep_result.pressure_shift_posture),
                          deep_result.momentum_acceleration_score,
                          ASC_ArtifactHumanizeLabel(deep_result.momentum_acceleration_posture),
                          deep_result.move_age_score,
                          ASC_ArtifactHumanizeLabel(deep_result.move_age_posture),
                          deep_result.liquidity_proximity_score,
                          ASC_ArtifactHumanizeLabel(deep_result.liquidity_proximity_posture),
                          ASC_ArtifactHumanizeLabel(deep_result.liquidity_zone),
                          deep_result.participation_score,
                          ASC_ArtifactHumanizeLabel(deep_result.participation_posture),
                          deep_result.execution_score,
                          ASC_ArtifactHumanizeLabel(deep_result.execution_posture),
                          deep_result.tick_burst_score,
                          ASC_ArtifactHumanizeLabel(deep_result.tick_burst_posture));
     }

   if(deep_completed)
     {
      if(deep_preserved)
         return "explicit selected-symbol deep packet is preserved from the last confirmed Deep Analysis publish";
      return "explicit selected-symbol deep packet is available for this symbol";
     }

   return "explicit selected-symbol deep packet has not been published yet";
  }



string ASC_DossierBoardAuthorityBoundaryLine(const bool explicit_selected_symbol_path,
                                              const bool deep_completed)
  {
   if(explicit_selected_symbol_path)
      return "selected-symbol deep support is active for this dossier within the same artifact family; ordinary trade-picking baseline and diversified overall authority stay with the Market Board";
   if(deep_completed)
      return "explicit selected-symbol deep support exists separately within the same artifact family; this ordinary dossier stays passive and does not carry Market Board authority";
   return "ordinary trade-picking baseline and diversified overall authority stay with the Market Board";
  }

string ASC_DossierSameSymbolRoleLine(const bool explicit_selected_symbol_path,
                                     const bool deep_completed)
  {
   if(explicit_selected_symbol_path)
      return "same symbol, same family, split role: the Market Board keeps ordinary pick priority while this selected-symbol dossier inherits the board baseline and adds explicit deep support only";
   if(deep_completed)
      return "same symbol, same family, split role: explicit deep support exists separately, but ordinary pick priority still belongs to the Market Board";
   return "same symbol, same family, split role: the Market Board owns ordinary pick priority and this dossier remains a passive symbol readback";
  }

string ASC_DossierBoardBaselineStatusLine(const ASC_PublicationBundleState &bundle)
  {
   string outcome = ASC_BoardPublishOutcomeClass(bundle.board_publish_result);
   string baseline_state = ASC_BoardBaselineAdvanceState(bundle.board_publish_result);
   string baseline_reason = ASC_BoardBaselineAdvanceReason(bundle.board_publish_result,
                                                           bundle.board_publish_skip_reason);

   if(bundle.board_publish_result == "fresh" && bundle.board_publish_finished_utc > 0)
      return StringFormat("Board outcome %s | baseline %s | %s",
                          outcome,
                          baseline_state,
                          baseline_reason);
   if(bundle.board_publish_result == "unchanged" && bundle.board_baseline_confirmed_utc > 0)
      return StringFormat("Board outcome %s | baseline %s | %s",
                          outcome,
                          baseline_state,
                          baseline_reason);
   if(bundle.board_baseline_confirmed_utc > 0)
      return StringFormat("Board outcome %s | baseline %s | confirmed Board baseline carried from the last Market Board publish",
                          outcome,
                          baseline_state);
   if(bundle.board_publish_result == "continuity" || bundle.overall_bundle_status == "continuity")
      return StringFormat("Board outcome %s | baseline %s | %s",
                          outcome,
                          baseline_state,
                          baseline_reason);
   if(StringLen(bundle.board_publish_result) > 0 && bundle.board_publish_result != "fresh")
      return StringFormat("Board outcome %s | baseline %s | current Board publish is still pending explicit confirmation",
                          outcome,
                          baseline_state);
   if(bundle.publication_utc > 0)
      return StringFormat("Board outcome %s | baseline %s | family publish landed before the Board baseline timestamp was captured",
                          outcome,
                          baseline_state);
   return StringFormat("Board outcome %s | baseline %s | Board baseline publish is still pending explicit confirmation",
                       outcome,
                       baseline_state);
  }

string ASC_DossierBundleTimingLine(const ASC_PublicationBundleState &bundle,
                                   const datetime generated_utc,
                                   const bool explicit_selected_symbol_path)
  {
   datetime board_publish_utc = (bundle.board_baseline_confirmed_utc > 0 ? bundle.board_baseline_confirmed_utc : bundle.board_publish_finished_utc);
   datetime dossier_publish_utc = bundle.publication_utc;
   if(dossier_publish_utc <= 0)
      dossier_publish_utc = generated_utc;

   if(board_publish_utc <= 0)
      return StringFormat("same-family timing: Board baseline timestamp pending | %s publish %s | near-time split is still lawful and does not change authority",
                          explicit_selected_symbol_path ? "selected-symbol dossier" : "dossier",
                          ASC_ArtifactFormatUtc(dossier_publish_utc));

   string timing_note = (board_publish_utc == dossier_publish_utc && board_publish_utc > 0)
                        ? "same-family timing aligned"
                        : "near-time split is expected";
   return StringFormat("same-family timing: Board baseline %s | %s publish %s | %s and does not change authority",
                       ASC_ArtifactFormatUtc(board_publish_utc),
                       explicit_selected_symbol_path ? "selected-symbol dossier" : "dossier",
                       ASC_ArtifactFormatUtc(dossier_publish_utc),
                       timing_note);
  }

string ASC_L6OperatorLabel(const string raw_value,
                           const string fallback = "unresolved")
  {
   if(StringLen(raw_value) <= 0)
      return fallback;
   return ASC_ArtifactHumanizeLabel(raw_value);
  }

string ASC_L6OperatorFitName(const string raw_value,
                             const string fallback = "unresolved")
  {
   if(StringLen(raw_value) <= 0 || raw_value == "unavailable")
      return fallback;
   return ASC_ArtifactHumanizeLabel(raw_value);
  }

string ASC_L6OperatorStyleHint(const string raw_value)
  {
   if(raw_value == "scalp_and_intraday_allowed")
      return "Scalp and intraday allowed";
   if(raw_value == "scalp_allowed")
      return "Scalp allowed";
   if(raw_value == "intraday_allowed")
      return "Intraday allowed";
   if(raw_value == "scalp_favored_intraday_allowed")
      return "Scalp favored, intraday allowed";
   if(raw_value == "intraday_favored")
      return "Intraday favored";
   if(raw_value == "scalp_favored")
      return "Scalp favored";
   if(raw_value == "scalp_only_if_trigger_confirms")
      return "Scalp only if trigger confirms";
   if(raw_value == "intraday_only_if_pullback_stabilizes")
      return "Intraday only if pullback stabilizes";
   if(raw_value == "mixed_but_patience_led")
      return "Mixed but patience led";
   if(raw_value == "review_only_despite_tradable_broker_conditions")
      return "Review only despite tradable broker conditions";
   if(raw_value == "review_only")
      return "Review only";
   return ASC_L6OperatorLabel(raw_value, "Review only");
  }

string ASC_L6OperatorMtfConflictClass(const ASC_L6_MtfConflictClass value)
  {
   switch(value)
     {
      case ASC_L6_MTF_ALIGNED:                return "Aligned";
      case ASC_L6_MTF_FRICTION:               return "Mixed but workable";
      case ASC_L6_MTF_COUNTERTREND_ALLOWED:   return "Countertrend path allowed";
      case ASC_L6_MTF_REVERSAL_RISK_BUILDING: return "Reversal risk building";
      case ASC_L6_MTF_HARD_CONFLICT:          return "Hard conflict";
     }
   return "Hard conflict";
  }

string ASC_L6OperatorPathViability(const string raw_value)
  {
   if(raw_value == "actionable_support")
      return "Support-actionable (review only)";
   if(raw_value == "viable_but_contested")
      return "Viable but contested";
   if(raw_value == "guarded")
      return "Guarded";
   return ASC_L6OperatorLabel(raw_value, "Guarded");
  }

string ASC_L6ResolveAlternatePromotionText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                           const ASC_L6_ReadinessPacket &readiness_packet,
                                           const ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   string alternate = ASC_L6OperatorFitName(workbench_packet.siam_secondary_fit, "alternate path");
   string alternate_reason = ASC_L6OperatorLabel(workbench_packet.siam_secondary_fit_reason, "alternate structure stays workable");
   if(!ASC_L6AlternateIsLive(workbench_packet))
      return "No preserved alternate is close enough yet to justify promotion language";
   if(surface_packet.path_stage_posture == "preserved alternate")
      return StringFormat("Promote %s if fresh support rebuilds around it and the invalid current primary does not recover", alternate);
   return StringFormat("Promote %s only if %s and the current primary path stops strengthening on the next lawful review", alternate, alternate_reason);
  }

string ASC_L6ResolvePreserveReasonText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                       const ASC_L6_ReadinessPacket &readiness_packet,
                                       const ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   if(!ASC_L6AlternateIsLive(workbench_packet))
      return StringFormat("Preservation stays bounded to the current primary path while stage is %s and no lawful alternate has earned carry yet", ASC_L6OperatorLabel(surface_packet.path_stage_posture, "developing"));

   string alternate = ASC_L6OperatorFitName(workbench_packet.siam_secondary_fit, "alternate path");
   string alternate_reason = ASC_L6OperatorLabel(workbench_packet.siam_secondary_fit_reason, "its supporting evidence is still lawful");
   if(surface_packet.path_stage_posture == "preserved alternate")
      return StringFormat("Preserved because %s remains the cleaner surviving path after the current primary lost authority: %s", alternate, alternate_reason);
   return StringFormat("Preserved because %s still has lawful support even though the primary path remains in %s stage", alternate, ASC_L6OperatorLabel(surface_packet.path_stage_posture, "review"));
  }

string ASC_L6ResolveKeepsAliveText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                   const ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   string primary = ASC_L6OperatorFitName(workbench_packet.siam_primary_fit, "primary path");
   bool alternate_live = ASC_L6AlternateIsLive(workbench_packet);
   if(surface_packet.path_stage_posture == "preserved alternate" && alternate_live)
      return StringFormat("The preserved alternate stays alive only while %s keeps cleaner structure support and does not lose freshness", ASC_L6OperatorFitName(workbench_packet.siam_secondary_fit, "alternate path"));
   return StringFormat("%s stays alive while geometry remains %s, freshness does not fade, and the next lawful review does not hand the read to a cleaner alternate", primary, ASC_L6OperatorLabel(surface_packet.geometry_validity_posture, "reviewable"));
  }

string ASC_L6ResolveStrengthenText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                   const ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   string primary = ASC_L6OperatorFitName(workbench_packet.siam_primary_fit, "primary path");
   string reason = ASC_L6OperatorLabel(workbench_packet.siam_primary_fit_reason, "primary context improves further");
   if(surface_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
      return StringFormat("Strengthens if %s upgrades from thin support into bounded geometry and the existing read becomes cleaner: %s", primary, reason);
   return StringFormat("Strengthens if %s keeps structure, refreshes participation/freshness, and confirms more cleanly than the alternate: %s", primary, reason);
  }

string ASC_L6ResolveWeakenText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                               const ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   string primary = ASC_L6OperatorFitName(workbench_packet.siam_primary_fit, "primary path");
   string alternate = ASC_L6OperatorFitName(workbench_packet.siam_secondary_fit, "alternate path");
   if(surface_packet.path_stage_posture == "fading" || surface_packet.path_stage_posture == "exhausted")
      return StringFormat("Already weakening: %s must stop losing freshness, participation, or reclaim quality before %s becomes the cleaner explanation", primary, alternate);
   return StringFormat("Weakens if %s loses freshness, structure hold, or clarity before %s can be ruled out", primary, alternate);
  }

string ASC_L6ResolveInvalidatesOrDemotesText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                             const ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   string invalidation = ASC_L6OperatorLabel(surface_packet.geometry_invalidation_path_summary, "Current invalidation path is unresolved");
   if(surface_packet.path_stage_posture == "preserved alternate")
      return StringFormat("Current primary is already demoted. The preserved alternate also fails if %s", invalidation);
   return StringFormat("Invalidates / demotes if %s or if the next lawful review confirms the current path lost structure authority", invalidation);
  }

string ASC_L6ResolveFlipCallText(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                 const ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   if(!ASC_L6AlternateIsLive(workbench_packet))
      return "No flip is earned yet; first a lawful alternate must become real enough to challenge the primary";
   string alternate = ASC_L6OperatorFitName(workbench_packet.siam_secondary_fit, "alternate path");
   string alternate_reason = ASC_L6OperatorLabel(workbench_packet.siam_secondary_fit_reason, "alternate structure takes over");
   if(surface_packet.path_stage_posture == "preserved alternate")
      return StringFormat("Flip has already begun in posture terms: keep %s primary only if the old read rebuilds and %s fails to hold", alternate, alternate);
   return StringFormat("Flip only if %s, the current primary fails its own strengthen conditions, and the next lawful review shows %s explaining price more cleanly", alternate_reason, alternate);
  }

string ASC_L6ResolveGeometryValidityText(const ASC_L6_GeometryValidity value)
  {
   if(value == ASC_L6_GEOMETRY_UNRESOLVED)
      return "Geometry not yet resolved";
   return ASC_L6OperatorLabel(ASC_L6GeometryValidityToText(value), "Geometry not yet resolved");
  }

string ASC_L6OperatorFamilyPathSummary(const string primary_fit,
                                       const string secondary_fit)
  {
   string primary = ASC_L6OperatorFitName(primary_fit, "Unresolved");
   string alternate = ASC_L6OperatorFitName(secondary_fit, "Unresolved");
   return StringFormat("primary=%s | alternate=%s", primary, alternate);
  }

string ASC_L6FormatExpansionCompressionCarry(const ASC_L6_MtfPosturePacket &mtf_packet)
  {
   return StringFormat("expansion=%d | compression=%d | up/down=%d/%d",
                       mtf_packet.expansion_timeframe_count,
                       mtf_packet.compression_timeframe_count,
                       mtf_packet.upward_timeframe_count,
                       mtf_packet.downward_timeframe_count);
  }

string ASC_L6BuildGeometryPlaceholderSummary(const string prefix,
                                             const string reason)
  {
   return prefix + ": " + reason;
  }

string ASC_L6BuildAdvancedPatternLaneBlock(const ASC_L6_AdvancedPatternPacket &pattern_packet)
  {
   string block = "------------------------------------------------------------------------------\n";
   block += "Advanced Pattern Lane\n";
   block += "------------------------------------------------------------------------------\n";
   block += StringFormat("Pattern-Lane Status: %s\n", ASC_L6OperatorLabel(pattern_packet.lane_availability_text, "Unavailable"));
   block += StringFormat("Candidate Availability: %s\n", pattern_packet.candidate_available ? "Available as bounded support only" : "No lawful candidate admitted");
   block += StringFormat("Pattern Candidate Family: %s\n", ASC_L6OperatorLabel(pattern_packet.candidate_pattern_family, "No candidate admitted"));
   block += StringFormat("Candidate State: %s\n", ASC_L6OperatorLabel(pattern_packet.candidate_status_text, "Unavailable"));
   block += StringFormat("Candidate Confidence: %s\n", ASC_L6OperatorLabel(pattern_packet.confidence_posture_text, "Unavailable"));
   block += StringFormat("Supportive Weight: %.1f / 100\n", pattern_packet.supportive_weight);
   block += StringFormat("Geometry Affinity: %s\n", ASC_L6OperatorLabel(pattern_packet.geometry_affinity_note, "Unavailable"));
   block += StringFormat("Confirmation Requirement: %s\n", ASC_L6OperatorLabel(pattern_packet.confirmation_note, "Unavailable"));
   block += StringFormat("Invalidation Requirement: %s\n", ASC_L6OperatorLabel(pattern_packet.invalidation_note, "Unavailable"));
   block += StringFormat("Preservation Note: %s\n", ASC_L6OperatorLabel(pattern_packet.preservation_note, "Unavailable"));
   block += StringFormat("Boundary Note: %s\n", ASC_L6OperatorLabel(pattern_packet.boundary_note, "Unavailable"));
   return block + "\n";
  }

string ASC_L6ResolveStrongestActiveContradiction(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                                 const ASC_L6_ReadinessPacket &readiness_packet,
                                                 const ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   bool alternate_present = !ASC_L6TextIsUnresolved(workbench_packet.siam_secondary_fit);
   bool geometry_blocked = (surface_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID);
   bool geometry_degraded = (surface_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED);
   bool review_only = (readiness_packet.readiness_class == ASC_L6_READINESS_OBSERVE
                       || readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED
                       || readiness_packet.deployability_class == ASC_L6_WATCH_ONLY
                       || readiness_packet.deployability_class == ASC_L6_NOT_DEPLOYABLE);
   bool blocker_active = !ASC_L6TextIsUnresolved(surface_packet.primary_blocker);

   string primary = ASC_L6OperatorFitName(workbench_packet.siam_primary_fit, "Unresolved");
   string alternate = ASC_L6OperatorFitName(workbench_packet.siam_secondary_fit, "alternate path");
   string blocker = ASC_L6OperatorLabel(surface_packet.primary_blocker, "top blocker unresolved");

   if(alternate_present && geometry_blocked)
      return StringFormat("Primary %s still leads, but geometry is blocked while %s remains alive as the cleaner preserved alternate.",
                          primary,
                          alternate);

   if(alternate_present && geometry_degraded)
      return StringFormat("Primary %s still leads, but geometry is degraded and %s is still contesting the read with cleaner structure.",
                          primary,
                          alternate);

   if(alternate_present && review_only)
      return StringFormat("Primary %s still leads, but deployability/readiness is capped at review-only while %s remains a live alternate.",
                          primary,
                          alternate);

   if(alternate_present && blocker_active)
      return StringFormat("Primary %s still leads, but %s is holding the path back while %s remains alive enough to prevent a clean one-path read.",
                          primary,
                          blocker,
                          alternate);

   if(geometry_blocked)
      return StringFormat("Primary %s still leads, but geometry is currently blocked, so the thesis survives only as analysis support and not as a lawful bounded path.",
                          primary);

   if(geometry_degraded)
      return StringFormat("Primary %s still leads, but geometry is degraded, so the path remains live only as patience-first support rather than a clean bounded path.",
                          primary);

   if(review_only)
      return StringFormat("Primary %s still leads, but deployability/readiness is capped at review-only, so the path is informational support rather than executable structure.",
                          primary);

   if(blocker_active)
      return StringFormat("Primary %s still leads, but %s remains the active blocker keeping the thesis from reading as clean support.",
                          primary,
                          blocker);

   if(alternate_present)
      return StringFormat("Primary %s still leads, but %s remains close enough to keep the read contested instead of one-path clean.",
                          primary,
                          alternate);

   return StringFormat("Primary %s leads without a stronger surviving alternate, but the path still remains bounded support rather than command authority.",
                       primary);
  }

string ASC_L6ResolveContradictionCompressionSummary(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                                    const ASC_L6_ReadinessPacket &readiness_packet,
                                                    const ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   bool alternate_present = !ASC_L6TextIsUnresolved(workbench_packet.siam_secondary_fit);
   bool geometry_blocked = (surface_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID);
   bool geometry_degraded = (surface_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED);
   bool review_only = (readiness_packet.readiness_class == ASC_L6_READINESS_OBSERVE
                       || readiness_packet.readiness_class == ASC_L6_READINESS_BLOCKED
                       || readiness_packet.deployability_class == ASC_L6_WATCH_ONLY
                       || readiness_packet.deployability_class == ASC_L6_NOT_DEPLOYABLE);
   bool blocker_active = !ASC_L6TextIsUnresolved(surface_packet.primary_blocker);

   string primary = ASC_L6OperatorFitName(workbench_packet.siam_primary_fit, "Unresolved");
   string alternate = ASC_L6OperatorFitName(workbench_packet.siam_secondary_fit, "alternate path");
   string blocker = ASC_L6OperatorLabel(surface_packet.primary_blocker, "top blocker unresolved");

   string compression = StringFormat("Lead with %s as the active thesis", primary);

   if(alternate_present)
      compression += StringFormat("; keep %s as the preserved challenger", alternate);
   else
      compression += "; no lawful alternate is currently close enough to displace it";

   if(geometry_blocked)
      compression += "; treat geometry blockage as the decisive cap";
   else if(geometry_degraded)
      compression += "; treat degraded geometry as the decisive cap";
   else if(review_only)
      compression += "; treat review-only deployability/readiness as the decisive cap";
   else if(blocker_active)
      compression += StringFormat("; treat %s as the decisive cap", blocker);
   else
      compression += "; the remaining tension is path contest, not authority drift";

   compression += "; do not flatten the preserved alternate or upgrade this support surface into board authority";
   return compression;
  }

string ASC_L6ResolveSupportPriorityNowSummary(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                                  const ASC_L6_ReadinessPacket &readiness_packet,
                                                  const ASC_L6_SemiAutoSurfacePacket &surface_packet)
  {
   string blocker = ASC_L6OperatorLabel(surface_packet.primary_blocker, "");
   string contradiction = ASC_L6ResolveStrongestActiveContradiction(workbench_packet, readiness_packet, surface_packet);
   bool geometry_blocked = (surface_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID);
   bool geometry_degraded = (surface_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED);
   string allowed_style_text = ASC_L6LowercaseCopy(surface_packet.allowed_style);
   string deployability_text = ASC_L6LowercaseCopy(surface_packet.deployability_class_text);
   bool review_only = (StringFind(allowed_style_text, "review") >= 0
                       || StringFind(deployability_text, "review") >= 0
                       || StringFind(allowed_style_text, "watch") >= 0
                       || StringFind(deployability_text, "watch") >= 0);

   if(geometry_blocked)
      return "Fix geometry first; keep the primary family as a support hypothesis only until the setup becomes lawful again.";
   if(geometry_degraded)
      return "Treat degraded geometry as the first compression target; support usefulness is secondary until the shape cleans up.";
   if(StringLen(blocker) > 0 && blocker != "None")
      return StringFormat("Resolve %s first; do not let cleaner support wording hide the active blocker.", blocker);
   if(review_only)
      return "Keep this in review-only posture; preserve the alternate path and wait for a lawful revisit trigger before leaning harder.";
   if(StringLen(contradiction) > 0 && contradiction != "No material contradiction is active right now")
      return StringFormat("Carry %s as the main support tension now; do not flatten the alternate family just because the summary is cleaner.", contradiction);
   if(StringLen(surface_packet.revisit_trigger_summary) > 0)
      return StringFormat("Primary family is currently the cleanest support readout, but the next highest-value check is %s.", ASC_L6OperatorLabel(surface_packet.revisit_trigger_summary));
   return "Primary family is currently the cleanest support readout; keep board authority first and use Layer 6 only to compress what to revisit next.";
  }

string ASC_L6BuildCurrentFocusSummaryBlock(const ASC_Layer5WorkbenchPacket &workbench_packet,
                                           const ASC_L6_ReadinessPacket &readiness_packet,
                                           const ASC_L6_SemiAutoSurfacePacket &surface_packet,
                                           const string latest_meaningful_change,
                                           const string contested_read_now)
  {
   string strongest_active_contradiction = ASC_L6ResolveStrongestActiveContradiction(workbench_packet,
                                                                                     readiness_packet,
                                                                                     surface_packet);
   string contradiction_compression = ASC_L6ResolveContradictionCompressionSummary(workbench_packet,
                                                                                   readiness_packet,
                                                                                   surface_packet);
   string support_priority_now = ASC_L6ResolveSupportPriorityNowSummary(workbench_packet,
                                                                        readiness_packet,
                                                                        surface_packet);
   string block = "LAYER 6 CURRENT FOCUS SUMMARY\n";
   block += "----------------------------------------\n";
   block += StringFormat("Primary Family Now: %s\n", ASC_L6OperatorFitName(workbench_packet.siam_primary_fit, "Unresolved"));
   block += StringFormat("Alternate Family: %s\n", ASC_L6OperatorFitName(workbench_packet.siam_secondary_fit, "Unresolved"));
   block += StringFormat("Deployability Class: %s\n", ASC_L6OperatorLabel(surface_packet.deployability_class_text));
   block += StringFormat("Opportunity Status: %s\n", ASC_L6OperatorLabel(surface_packet.opportunity_status_text));
   block += StringFormat("Readiness Class: %s\n", ASC_L6OperatorLabel(surface_packet.readiness_class_text));
   block += StringFormat("Allowed Style: %s\n", ASC_L6OperatorStyleHint(surface_packet.allowed_style));
   block += StringFormat("Geometry Posture: %s\n", ASC_L6ResolveGeometryValidityText(surface_packet.geometry_validity));
   block += StringFormat("Path Stage Posture: %s\n", ASC_L6OperatorLabel(surface_packet.path_stage_posture, "developing"));
   block += StringFormat("Review Posture: %s\n", ASC_L6OperatorLabel(readiness_packet.review_posture, "review with deep and board context"));
   block += StringFormat("Downgrade Reason: %s\n", ASC_L6OperatorLabel(readiness_packet.downgrade_reason, "None"));
   block += StringFormat("Expiry Hint: %s\n", ASC_L6OperatorLabel(surface_packet.expiry_hint, "pending clearer trigger"));
   block += StringFormat("Primary Blocker: %s\n", ASC_L6OperatorLabel(surface_packet.primary_blocker, "None"));
   block += StringFormat("Strongest Active Contradiction: %s\n", strongest_active_contradiction);
   block += StringFormat("Contradiction Compression: %s\n", contradiction_compression);
   block += StringFormat("Support Priority Now: %s\n", support_priority_now);
   block += StringFormat("Latest Meaningful Change: %s\n", ASC_L6OperatorLabel(latest_meaningful_change, "First selected-symbol review snapshot captured"));
   block += StringFormat("Still Contested Now: %s\n", ASC_L6OperatorLabel(contested_read_now, "No material contradiction is active right now"));
   block += StringFormat("Revisit Trigger Summary: %s\n", ASC_L6OperatorLabel(surface_packet.revisit_trigger_summary, "Revisit on next lawful deep refresh"));
   block += "Consumer Boundary: Layer 6 remains a bounded replay surface (no order command, no TP/SL command, no lot sizing, no broker instruction)\n";
   block += StringFormat("Flip Condition Summary: %s\n\n",
                         ASC_L6OperatorLabel(StringLen(workbench_packet.siam_secondary_fit_reason) > 0
                                             ? workbench_packet.siam_secondary_fit_reason
                                             : readiness_packet.next_revisit_trigger,
                                             "Await stronger alternate-family evidence"));
   return block;
  }

string ASC_L6ReviewSnapshotCompactChange(const ASC_L6_ReviewSnapshotPacket &snapshot_packet)
  {
   return StringFormat("primary %s | readiness %s | stage %s | blocker %s",
                       ASC_L6OperatorLabel(snapshot_packet.primary_family, "Unresolved"),
                       ASC_L6OperatorLabel(snapshot_packet.readiness_class, "Unavailable"),
                       ASC_L6OperatorLabel(snapshot_packet.stage_posture, "Unavailable"),
                       ASC_L6OperatorLabel(snapshot_packet.top_blocker, "None"));
  }

string ASC_L6ReviewDeltaLatestMeaningfulChange(const ASC_L6_ReviewDeltaPacket &delta_packet,
                                               const ASC_L6_ReviewSnapshotPacket &current_snapshot)
  {
   if(!delta_packet.prior_review_available)
      return "first selected-symbol review snapshot captured | " + ASC_L6ReviewSnapshotCompactChange(current_snapshot);

   if(delta_packet.primary_delta == "changed" && (delta_packet.alternate_delta == "gaining_ground" || delta_packet.alternate_delta == "replaced"))
      return StringFormat("primary thesis changed while alternate gained ground | current primary %s | alternate %s | lifecycle %s",
                          ASC_L6OperatorLabel(current_snapshot.primary_family, "Unresolved"),
                          ASC_L6OperatorLabel(current_snapshot.alternate_family, "Unresolved"),
                          ASC_L6OperatorLabel(delta_packet.lifecycle_delta, "Unavailable"));

   if(delta_packet.geometry_delta == "degraded" || delta_packet.deployability_delta == "degraded" || delta_packet.readiness_delta == "degraded")
      return StringFormat("current thesis degraded on geometry/deployability/readiness | lifecycle %s | geometry %s | blocker %s",
                          ASC_L6OperatorLabel(delta_packet.lifecycle_delta, "Unavailable"),
                          ASC_L6OperatorLabel(delta_packet.geometry_delta, "Unavailable"),
                          ASC_L6OperatorLabel(delta_packet.blocker_delta, "Unavailable"));

   if(delta_packet.blocker_delta == "persisted")
      return StringFormat("same blocker still caps the thesis | blocker %s | lifecycle %s | geometry %s",
                          ASC_L6OperatorLabel(current_snapshot.top_blocker, "Unavailable"),
                          ASC_L6OperatorLabel(delta_packet.lifecycle_delta, "Unavailable"),
                          ASC_L6OperatorLabel(delta_packet.geometry_delta, "Unavailable"));

   return StringFormat("%s | lifecycle %s | geometry %s | blocker %s",
                       ASC_L6OperatorLabel(delta_packet.self_audit_summary, "Review still pending"),
                       ASC_L6OperatorLabel(delta_packet.lifecycle_delta, "Unavailable"),
                       ASC_L6OperatorLabel(delta_packet.geometry_delta, "Unavailable"),
                       ASC_L6OperatorLabel(delta_packet.blocker_delta, "Unavailable"));
  }

string ASC_L6ReviewDeltaPreviousMeaningfulChange(const ASC_L6_ReviewDeltaPacket &delta_packet,
                                                 const ASC_L6_ReviewSnapshotPacket &prior_snapshot)
  {
   if(!delta_packet.prior_review_available)
      return "first selected-symbol review snapshot now becomes the historical anchor";

   return ASC_L6ReviewSnapshotCompactChange(prior_snapshot);
  }

string ASC_L6ReviewDeltaSelectionTransitionNote(const ASC_L6_ReviewDeltaPacket &delta_packet,
                                                const ASC_L6_ReviewSnapshotPacket &current_snapshot)
  {
   if(!delta_packet.prior_review_available)
      return "selected-symbol review lane starts here | primary " + ASC_L6OperatorLabel(current_snapshot.primary_family, "Unresolved");

   if(delta_packet.primary_delta == "changed" && (delta_packet.alternate_delta == "gaining_ground" || delta_packet.alternate_delta == "replaced"))
      return StringFormat("primary flipped to %s while %s gained ground as the preserved alternate; this is a contested-thesis transition, not a one-path read",
                          ASC_L6OperatorLabel(current_snapshot.primary_family, "Unresolved"),
                          ASC_L6OperatorLabel(current_snapshot.alternate_family, "Unresolved"));

   return StringFormat("primary %s | alternate %s | primary delta %s | alternate delta %s",
                       ASC_L6OperatorLabel(current_snapshot.primary_family, "Unresolved"),
                       ASC_L6OperatorLabel(current_snapshot.alternate_family, "Unresolved"),
                       ASC_L6OperatorLabel(delta_packet.primary_delta, "Unavailable"),
                       ASC_L6OperatorLabel(delta_packet.alternate_delta, "Unavailable"));
  }

string ASC_L6ReviewDeltaStateTransitionNote(const ASC_L6_ReviewDeltaPacket &delta_packet,
                                            const ASC_L6_ReviewSnapshotPacket &current_snapshot)
  {
   if(!delta_packet.prior_review_available)
      return StringFormat("state baseline starts here | stage %s | deployability %s | readiness %s | geometry %s",
                          ASC_L6OperatorLabel(current_snapshot.stage_posture, "Unavailable"),
                          ASC_L6OperatorLabel(current_snapshot.deployability_class, "Unavailable"),
                          ASC_L6OperatorLabel(current_snapshot.readiness_class, "Unavailable"),
                          ASC_L6OperatorLabel(current_snapshot.geometry_posture, "Unavailable"));

   if(delta_packet.stage_delta == "improved" || delta_packet.deployability_delta == "improved"
      || delta_packet.readiness_delta == "improved" || delta_packet.geometry_delta == "improved")
      return StringFormat("state improved | lifecycle %s | geometry %s | blocker %s",
                          ASC_L6OperatorLabel(delta_packet.lifecycle_delta, "Unavailable"),
                          ASC_L6OperatorLabel(delta_packet.geometry_delta, "Unavailable"),
                          ASC_L6OperatorLabel(delta_packet.blocker_delta, "Unavailable"));

   if(delta_packet.stage_delta == "degraded" || delta_packet.deployability_delta == "degraded"
      || delta_packet.readiness_delta == "degraded" || delta_packet.geometry_delta == "degraded")
      return StringFormat("state degraded | lifecycle %s | geometry %s | blocker %s",
                          ASC_L6OperatorLabel(delta_packet.lifecycle_delta, "Unavailable"),
                          ASC_L6OperatorLabel(delta_packet.geometry_delta, "Unavailable"),
                          ASC_L6OperatorLabel(delta_packet.blocker_delta, "Unavailable"));

   return StringFormat("state steady | lifecycle %s | geometry %s | blocker %s",
                       ASC_L6OperatorLabel(delta_packet.lifecycle_delta, "Unavailable"),
                       ASC_L6OperatorLabel(delta_packet.geometry_delta, "Unavailable"),
                       ASC_L6OperatorLabel(delta_packet.blocker_delta, "Unavailable"));
  }

string ASC_L6ReviewDeltaDeepTransitionNote(const ASC_L6_ReviewDeltaPacket &delta_packet,
                                           const ASC_L6_ReviewSnapshotPacket &current_snapshot)
  {
   if(!delta_packet.prior_review_available)
      return StringFormat("deep-support baseline starts here | expiry %s | blocker %s",
                          ASC_L6OperatorLabel(current_snapshot.expiry_hint, "Unavailable"),
                          ASC_L6OperatorLabel(current_snapshot.top_blocker, "None"));

   if(delta_packet.expiry_pressure_delta == "degraded")
      return StringFormat("deep-support invalidation pressure increased | expiry %s | blocker %s",
                          ASC_L6OperatorLabel(delta_packet.expiry_pressure_delta, "Unavailable"),
                          ASC_L6OperatorLabel(delta_packet.blocker_delta, "Unavailable"));

   if(delta_packet.expiry_pressure_delta == "improved" || delta_packet.blocker_delta == "cleared")
      return StringFormat("deep-support pressure eased | expiry %s | blocker %s",
                          ASC_L6OperatorLabel(delta_packet.expiry_pressure_delta, "Unavailable"),
                          ASC_L6OperatorLabel(delta_packet.blocker_delta, "Unavailable"));

   return StringFormat("deep-support pressure steady | expiry %s | blocker %s",
                       ASC_L6OperatorLabel(delta_packet.expiry_pressure_delta, "Unavailable"),
                       ASC_L6OperatorLabel(delta_packet.blocker_delta, "Unavailable"));
  }

void ASC_L6PopulateWorkbenchFromDeepResult(const ASC_DeepSelectiveAnalysisResult &deep_result,
                                           ASC_Layer5WorkbenchPacket &workbench_packet)
  {
   workbench_packet.lineage.symbol = deep_result.symbol;
   workbench_packet.lineage.canonical_symbol = deep_result.canonical_symbol;
   workbench_packet.lineage.source_layer_ref = "L5";
   workbench_packet.lineage.source_revision_ref = IntegerToString((int)deep_result.last_refreshed_utc);
   workbench_packet.lineage.source_packet_ref = IntegerToString((int)deep_result.last_refreshed_utc);
   workbench_packet.lineage.source_owner = "deep_selective_analysis";

   workbench_packet.availability.valid = deep_result.built;
   workbench_packet.availability.available = deep_result.lawful;
   workbench_packet.availability.missing_surface = false;
   workbench_packet.availability.continuity_backed = (deep_result.continuity_posture == "continuity" || deep_result.continuity_posture == "last_confirmed_value");
   workbench_packet.availability.availability_state = deep_result.lawful ? "available" : "unavailable";
   workbench_packet.availability.reason_summary = deep_result.entitlement_reason;
   workbench_packet.availability.missing_surface_notes = "none";

   workbench_packet.source_layer_id = "L5";
   workbench_packet.source_result_revision = "deep_refresh_" + IntegerToString((int)deep_result.last_refreshed_utc);
   workbench_packet.source_build_utc = deep_result.last_refreshed_utc;
   workbench_packet.source_context = deep_result.execution_context;
   workbench_packet.packet_valid = deep_result.built;
   workbench_packet.packet_lawful = deep_result.lawful;
   workbench_packet.packet_reason_summary = deep_result.summary_line;

   workbench_packet.entitlement_state = deep_result.entitlement_state;
   workbench_packet.entitlement_reason = deep_result.entitlement_reason;
   workbench_packet.freshness_posture = deep_result.freshness_posture;
   workbench_packet.continuity_posture = deep_result.continuity_posture;
   workbench_packet.preservation_state = deep_result.preservation_state;
   workbench_packet.preservation_reason = deep_result.preservation_reason;
   workbench_packet.build_context = deep_result.build_context;
   workbench_packet.data_tier = deep_result.data_tier;
   workbench_packet.missing_surface_notes = "none";
   workbench_packet.degraded_surface_notes = "none";

   workbench_packet.execution_score = deep_result.execution_score;
   workbench_packet.execution_penalty = deep_result.execution_penalty;
   workbench_packet.execution_posture = deep_result.execution_posture;
   workbench_packet.spread_quality_score = deep_result.spread_quality_score;
   workbench_packet.friction_quality_score = deep_result.friction_quality_score;
   workbench_packet.liquidity_quality_score = deep_result.liquidity_quality_score;
   workbench_packet.pressure_shift_score = deep_result.pressure_shift_score;
   workbench_packet.pressure_shift_posture = deep_result.pressure_shift_posture;
   workbench_packet.momentum_acceleration_score = deep_result.momentum_acceleration_score;
   workbench_packet.momentum_acceleration_posture = deep_result.momentum_acceleration_posture;
   workbench_packet.move_age_score = deep_result.move_age_score;
   workbench_packet.move_age_posture = deep_result.move_age_posture;
   workbench_packet.participation_score = deep_result.participation_score;
   workbench_packet.participation_posture = deep_result.participation_posture;
   workbench_packet.tick_burst_score = deep_result.tick_burst_score;
   workbench_packet.tick_burst_posture = deep_result.tick_burst_posture;
   workbench_packet.tick_burst_flag = deep_result.tick_burst_flag;
   workbench_packet.scalp_tradable = deep_result.scalp_tradable;
   workbench_packet.intraday_tradable = deep_result.intraday_tradable;
   workbench_packet.micro_direction = deep_result.micro_direction;
   workbench_packet.micro_conviction = deep_result.micro_conviction;
   workbench_packet.impulse_state = deep_result.impulse_state;
   workbench_packet.participation_state = deep_result.participation_state;

   workbench_packet.short_term_bias = deep_result.short_term_bias;
   workbench_packet.mid_term_bias = deep_result.mid_term_bias;
   workbench_packet.higher_timeframe_bias = deep_result.higher_timeframe_bias;
   workbench_packet.alignment = deep_result.alignment;
   workbench_packet.upward_timeframe_count = deep_result.upward_timeframe_count;
   workbench_packet.downward_timeframe_count = deep_result.downward_timeframe_count;
   workbench_packet.expansion_timeframe_count = deep_result.expansion_timeframe_count;
   workbench_packet.compression_timeframe_count = deep_result.compression_timeframe_count;
   workbench_packet.position_in_range_pct = deep_result.position_in_range_pct;
   workbench_packet.distance_to_recent_high_pct = deep_result.distance_to_recent_high_pct;
   workbench_packet.distance_to_recent_low_pct = deep_result.distance_to_recent_low_pct;
   workbench_packet.liquidity_zone = deep_result.liquidity_zone;
   workbench_packet.liquidity_proximity_score = deep_result.liquidity_proximity_score;
   workbench_packet.liquidity_proximity_posture = deep_result.liquidity_proximity_posture;

   workbench_packet.session_sweep_score = deep_result.session_sweep_score;
   workbench_packet.session_sweep_state = deep_result.session_sweep_state;
   workbench_packet.reclaim_score = deep_result.reclaim_score;
   workbench_packet.reclaim_state = deep_result.reclaim_state;
   workbench_packet.failed_break_score = deep_result.failed_break_score;
   workbench_packet.failed_break_state = deep_result.failed_break_state;
   workbench_packet.trap_pressure_score = deep_result.trap_pressure_score;
   workbench_packet.trap_pressure_state = deep_result.trap_pressure_state;
   workbench_packet.pullback_depth_score = deep_result.pullback_depth_score;
   workbench_packet.pullback_quality_score = deep_result.pullback_quality_score;
   workbench_packet.pullback_state = deep_result.pullback_state;
   workbench_packet.continuation_readiness_score = deep_result.continuation_readiness_score;
   workbench_packet.continuation_state = deep_result.continuation_state;
   workbench_packet.reversal_pressure_score = deep_result.reversal_pressure_score;
   workbench_packet.reversal_state = deep_result.reversal_state;
   workbench_packet.move_freshness_score = deep_result.move_freshness_score;
   workbench_packet.freshness_state = deep_result.freshness_state;

   workbench_packet.siam_primary_fit = deep_result.siam_primary_fit;
   workbench_packet.siam_primary_fit_score = deep_result.siam_primary_fit_score;
   workbench_packet.siam_primary_fit_posture = deep_result.siam_primary_fit_posture;
   workbench_packet.siam_primary_fit_reason = deep_result.siam_primary_fit_reason;
   workbench_packet.siam_secondary_fit = deep_result.siam_secondary_fit;
   workbench_packet.siam_secondary_fit_score = deep_result.siam_secondary_fit_score;
   workbench_packet.siam_secondary_fit_posture = deep_result.siam_secondary_fit_posture;
   workbench_packet.siam_secondary_fit_reason = deep_result.siam_secondary_fit_reason;
   workbench_packet.siam_fit_summary = deep_result.siam_fit_summary;
   workbench_packet.siam_setup_fit_caution = deep_result.siam_setup_fit_caution;
   workbench_packet.siam_setup_fit_conclusion = deep_result.siam_setup_fit_conclusion;

   workbench_packet.summary_line = deep_result.summary_line;
   workbench_packet.tactical_snapshot_summary = deep_result.tactical_snapshot_summary;
   workbench_packet.structure_liquidity_summary = deep_result.structure_liquidity_summary;
   workbench_packet.session_timing_summary = deep_result.session_timing_summary;
   workbench_packet.score_context_summary = deep_result.score_context_summary;
   workbench_packet.microstructure_summary = deep_result.microstructure_summary;
   workbench_packet.siam_tactical_summary = deep_result.siam_tactical_summary;

   workbench_packet.source_deep_packet_available = deep_result.built && deep_result.lawful;
   workbench_packet.source_shortlist_context_available = (StringLen(deep_result.score_context_summary) > 0 || StringLen(deep_result.shortlist_context) > 0);
   workbench_packet.source_trigger_family = "explicit_selected_symbol_deep";
   workbench_packet.source_trigger_reason = deep_result.entitlement_reason;
   workbench_packet.source_context_summary = deep_result.score_context_summary;
   workbench_packet.source_contract_note = "consumer_only_l6_projection_from_l5";
  }

bool ASC_DossierBuildLayer6SurfaceBlocks(const string server_root,
                                         const string canonical_symbol,
                                         const ASC_DeepSelectiveAnalysisResult &deep_result,
                                         string &current_focus_summary_out,
                                         string &dossier_band_out,
                                         string &review_latest_change_out,
                                         string &review_previous_change_out,
                                         string &review_state_transition_out,
                                         string &review_selection_transition_out,
                                         string &review_deep_transition_out)
  {
   current_focus_summary_out = "";
   dossier_band_out = "";
   review_latest_change_out = "";
   review_previous_change_out = "";
   review_state_transition_out = "";
   review_selection_transition_out = "";
   review_deep_transition_out = "";

   if(!(deep_result.built && deep_result.lawful))
      return false;

   ASC_Layer5WorkbenchPacket workbench_packet;
   ZeroMemory(workbench_packet);
   ASC_L6_NormalizedContextPacket normalized_packet;
   ZeroMemory(normalized_packet);
   ASC_L6_MtfPosturePacket mtf_packet;
   ZeroMemory(mtf_packet);
   ASC_L6_GeometryCandidatePacket geometry_packet;
   ZeroMemory(geometry_packet);
   ASC_L6_ReadinessPacket readiness_packet;
   ZeroMemory(readiness_packet);
   ASC_L6_SemiAutoSurfacePacket surface_packet;
   ZeroMemory(surface_packet);

   ASC_L6PopulateWorkbenchFromDeepResult(deep_result, workbench_packet);
   if(!ASC_BuildL6DormantPacketChain(workbench_packet,
                                     normalized_packet,
                                     mtf_packet,
                                     geometry_packet,
                                     readiness_packet,
                                     surface_packet))
      return false;

   ASC_L6_HandoffPacket handoff_packet;
   ZeroMemory(handoff_packet);
   ASC_BuildL6HandoffPacket(workbench_packet,
                            geometry_packet,
                            readiness_packet,
                            surface_packet,
                            handoff_packet);

   ASC_L6_MaturityPacket maturity_packet;
   ZeroMemory(maturity_packet);
   ASC_BuildL6MaturityPacket(workbench_packet,
                             geometry_packet,
                             readiness_packet,
                             handoff_packet,
                             maturity_packet);

   ASC_L6_AdvancedPatternPacket pattern_packet;
   ZeroMemory(pattern_packet);
   ASC_BuildL6AdvancedPatternPacket(workbench_packet,
                                    geometry_packet,
                                    readiness_packet,
                                    surface_packet,
                                    pattern_packet);
   handoff_packet.review_timestamp_text = ASC_ArtifactFormatUtc(deep_result.last_refreshed_utc);

   ASC_L6_ReviewSnapshotPacket current_review_snapshot;
   ZeroMemory(current_review_snapshot);
   ASC_BuildL6ReviewSnapshotPacket(workbench_packet, readiness_packet, surface_packet, current_review_snapshot);
   current_review_snapshot.review_timestamp_text = ASC_ArtifactFormatUtc(deep_result.last_refreshed_utc);

   ASC_L6_ReviewSnapshotPacket prior_review_snapshot;
   ZeroMemory(prior_review_snapshot);
   string prior_payload = "";
   if(StringLen(server_root) > 0 && StringLen(canonical_symbol) > 0)
     {
      ASC_ArtifactContract prior_contract = ASC_DossierContract(server_root, canonical_symbol);
      if(ASC_ReadTextFile(prior_contract.target_path, prior_payload))
         ASC_RestoreL6ReviewSnapshotFromPayload(prior_payload, prior_review_snapshot);
     }

   ASC_L6_ReviewDeltaPacket review_delta_packet;
   ZeroMemory(review_delta_packet);
   ASC_BuildL6ReviewDeltaPacket(current_review_snapshot, prior_review_snapshot, review_delta_packet);

   review_latest_change_out = ASC_L6ReviewDeltaLatestMeaningfulChange(review_delta_packet, current_review_snapshot);
   review_previous_change_out = ASC_L6ReviewDeltaPreviousMeaningfulChange(review_delta_packet, prior_review_snapshot);
   review_state_transition_out = ASC_L6ReviewDeltaStateTransitionNote(review_delta_packet, current_review_snapshot);
   review_selection_transition_out = ASC_L6ReviewDeltaSelectionTransitionNote(review_delta_packet, current_review_snapshot);
   review_deep_transition_out = ASC_L6ReviewDeltaDeepTransitionNote(review_delta_packet, current_review_snapshot);

   current_focus_summary_out = ASC_L6BuildCurrentFocusSummaryBlock(workbench_packet,
                                                                   readiness_packet,
                                                                   surface_packet,
                                                                   review_latest_change_out,
                                                                   ASC_L6ResolveStrongestActiveContradiction(workbench_packet,
                                                                                                            readiness_packet,
                                                                                                            surface_packet));

   ASC_DossierSectionStatus strategy_status;
   ASC_DossierSectionStatus timeframe_status;
   ASC_DossierSectionStatus opportunity_status;
   ASC_DossierSectionStatus geometry_status;
   ASC_DossierSectionStatus readiness_status;
   ASC_DossierSectionStatus preserve_status;

   string geometry_resolution_note = (surface_packet.geometry_validity == ASC_L6_GEOMETRY_UNRESOLVED)
                                     ? "The idea can be reviewed here, but geometry still needs cleaner support before a bounded path becomes lawful."
                                     : (surface_packet.geometry_validity == ASC_L6_GEOMETRY_DEGRADED
                                        ? "Geometry is live but degraded; patience and manual review still outrank aggression."
                                        : (surface_packet.geometry_validity == ASC_L6_GEOMETRY_INVALID
                                           ? "Geometry is blocked even if the idea remains interesting elsewhere in the stack."
                                           : "Geometry posture is now packet-fed, bounded, selected-symbol only, and still consumer-only."));

   dossier_band_out = "LAYER 6 STRATEGY SURFACE [L6]\n";
   dossier_band_out += "----------------------------------------\n";
   dossier_band_out += ASC_BuildDossierStrategyCompetitionSection(
      ASC_L6OperatorFitName(workbench_packet.siam_primary_fit, "Unresolved"),
      ASC_L6OperatorFitName(workbench_packet.siam_secondary_fit, "Pending / unresolved"),
      ASC_L6OperatorLabel(surface_packet.family_confidence_posture, "Family confidence unresolved"),
      ASC_L6OperatorLabel(surface_packet.directional_posture, "Directional posture unresolved"),
      ASC_L6OperatorLabel(workbench_packet.siam_primary_fit_reason, "Primary family reason unavailable"),
      ASC_L6OperatorLabel(workbench_packet.siam_secondary_fit_reason, "Alternate family reason unavailable"),
      ASC_L6OperatorLabel(workbench_packet.siam_setup_fit_caution, "No broader family rejection detail is lawfully available yet"),
      ASC_L6ResolveAlternatePromotionText(workbench_packet, readiness_packet, surface_packet),
      true,
      strategy_status);

   dossier_band_out += ASC_BuildDossierTimeframePressureSection(
      ASC_L6OperatorLabel(mtf_packet.context_timeframe_role),
      ASC_L6OperatorLabel(mtf_packet.bias_timeframe_role),
      ASC_L6OperatorLabel(mtf_packet.trigger_timeframe_role),
      ASC_L6OperatorLabel(mtf_packet.short_term_bias),
      ASC_L6OperatorLabel(mtf_packet.mid_term_bias),
      ASC_L6OperatorLabel(mtf_packet.higher_timeframe_bias),
      ASC_L6OperatorLabel(mtf_packet.alignment),
      ASC_L6OperatorMtfConflictClass(mtf_packet.conflict_class),
      ASC_L6OperatorPathViability(mtf_packet.path_viability_posture),
      ASC_L6OperatorLabel(mtf_packet.reversal_pressure_posture),
      ASC_L6OperatorStyleHint(mtf_packet.allowed_style_hint),
      ASC_L6FormatExpansionCompressionCarry(mtf_packet),
      ASC_L6OperatorLabel(mtf_packet.conflict_reason_summary),
      true,
      timeframe_status);

   dossier_band_out += ASC_BuildDossierOpportunityPathsSection(
      ASC_L6OperatorFitName(workbench_packet.siam_primary_fit, "Unresolved"),
      ASC_L6OperatorFitName(workbench_packet.siam_secondary_fit, "Pending / unresolved"),
      ASC_L6OperatorLabel(surface_packet.opportunity_status_text),
      ASC_L6OperatorLabel(surface_packet.path_stage_posture, ASC_L6FamilyCompetitionStatusToText(surface_packet.competition_status)),
      ASC_L6OperatorLabel(readiness_packet.horizon_class_text),
      ASC_L6ResolvePreserveReasonText(workbench_packet, readiness_packet, surface_packet),
      ASC_L6OperatorLabel(surface_packet.primary_blocker, "No primary blocker"),
      ASC_L6ResolveStrengthenText(workbench_packet, surface_packet),
      ASC_L6ResolveWeakenText(workbench_packet, surface_packet),
      ASC_L6ResolveInvalidatesOrDemotesText(workbench_packet, surface_packet),
      ASC_L6OperatorLabel(surface_packet.revisit_trigger_summary),
      ASC_L6OperatorLabel(surface_packet.expiry_hint, "Pending / not yet available"),
      true,
      opportunity_status);

   dossier_band_out += ASC_BuildDossierGeometryWorkbenchSection(
      ASC_L6ResolveGeometryValidityText(surface_packet.geometry_validity),
      ASC_L6OperatorLabel(surface_packet.geometry_primary_summary, "Primary geometry candidate unresolved"),
      ASC_L6OperatorLabel(surface_packet.geometry_alternate_summary, "Alternate geometry candidate not promoted"),
      ASC_L6OperatorLabel(surface_packet.geometry_entry_path_summary, "Entry path unresolved"),
      ASC_L6OperatorLabel(surface_packet.geometry_invalidation_path_summary, "Invalidation path unresolved"),
      ASC_L6OperatorLabel(surface_packet.geometry_target_path_summary, "Target path unresolved"),
      ASC_L6OperatorLabel(surface_packet.geometry_timebox_posture, ASC_L6OperatorLabel(readiness_packet.horizon_class_text)),
      ASC_L6OperatorLabel(surface_packet.geometry_execution_burden_posture, "Execution burden unresolved"),
      ASC_L6OperatorLabel(surface_packet.geometry_review_burden_posture, "Review burden unresolved"),
      ASC_L6OperatorLabel(surface_packet.geometry_timing_posture, "Timing posture unresolved"),
      ASC_L6OperatorLabel(surface_packet.geometry_reason_summary, "Geometry reason unresolved"),
      ASC_L6OperatorLabel(surface_packet.geometry_blocker_summary, "No geometry blocker"),
      geometry_resolution_note,
      true,
      geometry_status);

   dossier_band_out += ASC_BuildDossierSemiAutoReadinessSection(
      ASC_L6OperatorLabel(surface_packet.deployability_class_text),
      ASC_L6OperatorLabel(surface_packet.opportunity_status_text),
      ASC_L6OperatorLabel(surface_packet.readiness_class_text),
      ASC_L6OperatorLabel(readiness_packet.horizon_class_text),
      ASC_L6OperatorStyleHint(surface_packet.allowed_style),
      ASC_L6OperatorLabel(readiness_packet.review_posture),
      ASC_L6OperatorLabel(readiness_packet.primary_blocker, "None"),
      ASC_L6OperatorLabel(readiness_packet.downgrade_reason, "None"),
      ASC_L6OperatorLabel(readiness_packet.why_not_top_rank_ready),
      StringFormat("scalp=%s | intraday=%s",
                   ASC_L6OperatorLabel(workbench_packet.scalp_tradable, "no"),
                   ASC_L6OperatorLabel(workbench_packet.intraday_tradable, "no")),
      ASC_L6OperatorLabel(workbench_packet.execution_posture),
      true,
      readiness_status);

   dossier_band_out += ASC_BuildDossierPreserveRevisitSection(
      ASC_L6ResolvePreserveReasonText(workbench_packet, readiness_packet, surface_packet),
      ASC_L6ResolveKeepsAliveText(workbench_packet, surface_packet),
      ASC_L6ResolveStrengthenText(workbench_packet, surface_packet),
      ASC_L6ResolveWeakenText(workbench_packet, surface_packet),
      ASC_L6ResolveFlipCallText(workbench_packet, surface_packet),
      ASC_L6OperatorLabel(surface_packet.revisit_trigger_summary),
      ASC_L6OperatorLabel(surface_packet.expiry_hint, "Ambiguity is still intentionally bounded here."),
      StringFormat("Layer 6 stays consumer-only here and selected-symbol only; current stage is %s and does not override Layer 4 or Layer 5 ownership.",
                   ASC_L6OperatorLabel(surface_packet.path_stage_posture, "developing")),
      ASC_L6OperatorLabel(readiness_packet.review_posture),
      true,
      preserve_status);


   dossier_band_out += ASC_L6BuildAdvancedPatternLaneBlock(pattern_packet);

   dossier_band_out += ASC_L6BuildMaturityTriggerCanonBlock(maturity_packet);

   dossier_band_out += ASC_L6BuildHandoffInterfaceBlock(handoff_packet);


   dossier_band_out += "------------------------------------------------------------------------------\n";
   dossier_band_out += "Review / Replay / Self-Audit\n";
   dossier_band_out += "------------------------------------------------------------------------------\n";
   dossier_band_out += StringFormat("Prior Review Availability: %s\n", review_delta_packet.prior_review_availability_note);
   dossier_band_out += StringFormat("Review Timestamp: %s\n", ASC_L6OperatorLabel(current_review_snapshot.review_timestamp_text, "Unavailable"));
   dossier_band_out += StringFormat("Review Revision: %s\n", ASC_L6OperatorLabel(current_review_snapshot.review_revision_context, "Unavailable"));
   dossier_band_out += StringFormat("Primary Family At Review: %s\n", ASC_L6OperatorLabel(current_review_snapshot.primary_family, "Unresolved"));
   dossier_band_out += StringFormat("Alternate Family At Review: %s\n", ASC_L6OperatorLabel(current_review_snapshot.alternate_family, "Unresolved"));
   dossier_band_out += StringFormat("Deployability At Review: %s\n", ASC_L6OperatorLabel(current_review_snapshot.deployability_class, "Unavailable"));
   dossier_band_out += StringFormat("Readiness At Review: %s\n", ASC_L6OperatorLabel(current_review_snapshot.readiness_class, "Unavailable"));
   dossier_band_out += StringFormat("Stage At Review: %s\n", ASC_L6OperatorLabel(current_review_snapshot.stage_posture, "Unavailable"));
   dossier_band_out += StringFormat("Geometry At Review: %s\n", ASC_L6OperatorLabel(current_review_snapshot.geometry_posture, "Unavailable"));
   dossier_band_out += StringFormat("Expiry Hint At Review: %s\n", ASC_L6OperatorLabel(current_review_snapshot.expiry_hint, "Unavailable"));
   dossier_band_out += StringFormat("Top Blocker At Review: %s\n", ASC_L6OperatorLabel(current_review_snapshot.top_blocker, "None"));
   dossier_band_out += StringFormat("Downgrade Reason At Review: %s\n", ASC_L6OperatorLabel(current_review_snapshot.downgrade_reason, "None"));
   dossier_band_out += StringFormat("Strongest Active Contradiction: %s\n",
                                    ASC_L6ResolveStrongestActiveContradiction(workbench_packet,
                                                                              readiness_packet,
                                                                              surface_packet));
   dossier_band_out += StringFormat("Contradiction Compression: %s\n",
                                    ASC_L6ResolveContradictionCompressionSummary(workbench_packet,
                                                                                 readiness_packet,
                                                                                 surface_packet));
   dossier_band_out += StringFormat("Previous Primary / Current Primary: %s -> %s\n",
                                    ASC_L6OperatorLabel(review_delta_packet.previous_primary_family, "Unavailable"),
                                    ASC_L6OperatorLabel(review_delta_packet.current_primary_family, "Unresolved"));
   dossier_band_out += StringFormat("Previous Alternate / Current Alternate: %s -> %s\n",
                                    ASC_L6OperatorLabel(review_delta_packet.previous_alternate_family, "Unavailable"),
                                    ASC_L6OperatorLabel(review_delta_packet.current_alternate_family, "Unresolved"));
   dossier_band_out += StringFormat("Lifecycle Delta: %s\n", ASC_L6OperatorLabel(review_delta_packet.lifecycle_delta, "Unavailable"));
   dossier_band_out += StringFormat("Geometry Delta: %s\n", ASC_L6OperatorLabel(review_delta_packet.geometry_delta, "Unavailable"));
   dossier_band_out += StringFormat("Blocker Delta: %s\n", ASC_L6OperatorLabel(review_delta_packet.blocker_delta, "Unavailable"));
   dossier_band_out += StringFormat("Self-Audit Summary: %s\n", ASC_L6OperatorLabel(review_delta_packet.self_audit_summary, "Review still pending"));
   dossier_band_out += StringFormat("Review Boundary Note: %s\n",
                                    "Selected-symbol only | explicit deep path only | bounded strategy-truth replay only | no Board override | no execution journaling | no PnL hindsight");

   dossier_band_out += "\n";
   return true;
  }


string ASC_L6BuildMaturityTriggerCanonBlock(const ASC_L6_MaturityPacket &maturity_packet)
  {
   string block = "------------------------------------------------------------------------------\n";
   block += "Layer 6 Maturity / Trigger Canon\n";
   block += "------------------------------------------------------------------------------\n";
   block += StringFormat("Maturity State: %s\n", ASC_L6OperatorLabel(maturity_packet.maturity_state, "Unavailable"));
   block += StringFormat("Maturity Reason: %s\n", ASC_L6OperatorLabel(maturity_packet.maturity_reason_summary, "Unavailable"));
   block += StringFormat("Trigger Family: %s\n", ASC_L6OperatorLabel(maturity_packet.trigger_family_state, "Unavailable"));
   block += StringFormat("Trigger Canon Note: %s\n", ASC_L6OperatorLabel(maturity_packet.trigger_canon_note, "Unavailable"));
   block += StringFormat("Promotion Condition: %s\n", ASC_L6OperatorLabel(maturity_packet.maturity_promotion_condition, "Unavailable"));
   block += StringFormat("Demotion Condition: %s\n", ASC_L6OperatorLabel(maturity_packet.maturity_demotion_condition, "Unavailable"));
   block += StringFormat("Boundary Note: %s\n", ASC_L6OperatorLabel(maturity_packet.maturity_boundary_note, "Unavailable"));
   return block + "\n";
  }

string ASC_L6BuildHandoffInterfaceBlock(const ASC_L6_HandoffPacket &handoff_packet)
  {
   string block = "------------------------------------------------------------------------------\n";
   block += "Layer 6 -> Layer 7 Interface\n";
   block += "------------------------------------------------------------------------------\n";
   block += StringFormat("Handoff Availability: %s\n", ASC_L6OperatorLabel(handoff_packet.handoff_availability_state, "Unavailable"));
   block += StringFormat("Primary Family: %s\n", ASC_L6OperatorLabel(handoff_packet.primary_family, "Unresolved"));
   block += StringFormat("Trigger Family: %s\n", ASC_L6OperatorLabel(handoff_packet.trigger_family_description, "Unresolved"));
   block += StringFormat("Entry-Zone Family: %s\n", ASC_L6OperatorLabel(handoff_packet.entry_zone_family_description, "Unresolved"));
   block += StringFormat("Invalidation-Zone Family: %s\n", ASC_L6OperatorLabel(handoff_packet.invalidation_zone_family_description, "Unresolved"));
   block += StringFormat("Target-Zone Family: %s\n", ASC_L6OperatorLabel(handoff_packet.target_zone_family_description, "Unresolved"));
   block += StringFormat("Deployability / Readiness: %s / %s\n",
                         ASC_L6OperatorLabel(handoff_packet.deployability_class, "Unavailable"),
                         ASC_L6OperatorLabel(handoff_packet.readiness_class, "Unavailable"));
   block += StringFormat("Stage / Timebox: %s / %s\n",
                         ASC_L6OperatorLabel(handoff_packet.stage_posture, "Unavailable"),
                         ASC_L6OperatorLabel(handoff_packet.timebox_posture, "Unavailable"));
   block += StringFormat("Confirmation Burden: %s\n", ASC_L6OperatorLabel(handoff_packet.confirmation_burden, "Unavailable"));
   block += StringFormat("Safety Boundary: %s\n", ASC_L6OperatorLabel(handoff_packet.safety_boundary_note, "Unavailable"));
   block += "Execution Boundary: handoff language is descriptive only; final execution semantics stay outside Layer 6\n";
   return block + "\n";
  }

string ASC_DossierStripNamedBlock(const string text_in,
                                  const string block_header,
                                  const string next_header)
  {
   string text = text_in;
   int start = StringFind(text, block_header);
   if(start < 0)
      return text;
   int end = (StringLen(next_header) > 0 ? StringFind(text, next_header, start + StringLen(block_header)) : -1);
   if(end < 0)
      return StringSubstr(text, 0, start);
   return StringSubstr(text, 0, start) + StringSubstr(text, end);
  }

string ASC_DossierEnhanceDeepSection(const string section_in,
                                     const string view_state,
                                     const string operator_use,
                                     const string current_focus_summary_block = "",
                                     const string l6_dossier_band = "")
  {
   string header = "Deep Analysis\n----------------------------------------\n";
   string body = section_in;
   int start = StringFind(body, header);
   if(start >= 0)
      body = StringSubstr(body, start + StringLen(header));

   string prior_view_prefix = "Working Deep View:";
   string prior_operator_prefix = "Operator Use:";
   if(StringFind(body, prior_view_prefix) == 0)
     {
      int first_newline = StringFind(body, "\n");
      if(first_newline >= 0)
         body = StringSubstr(body, first_newline + 1);
     }
   if(StringFind(body, prior_operator_prefix) == 0)
     {
      int second_newline = StringFind(body, "\n");
      if(second_newline >= 0)
         body = StringSubstr(body, second_newline + 1);
     }

   string readback_header = "SIAM TACTICAL READBACK\n----------------------------------------\n";
   int readback_start = StringFind(body, readback_header);
   if(readback_start >= 0)
     {
      int readback_end = StringFind(body, "\nANALYST_HEADER\n", readback_start);
      if(readback_end >= 0)
         body = StringSubstr(body, 0, readback_start) + StringSubstr(body, readback_end + 1);
      else
         body = StringSubstr(body, 0, readback_start);
     }

   body = ASC_DossierStripNamedBlock(body,
                                     "LAYER 6 CURRENT FOCUS SUMMARY\n----------------------------------------\n",
                                     "LAYER 6 STRATEGY SURFACE [L6]\n----------------------------------------\n");
   body = ASC_DossierStripNamedBlock(body,
                                     "LAYER 6 STRATEGY SURFACE [L6]\n----------------------------------------\n",
                                     "ANALYST_HEADER\n");

   string section = "\nDeep Analysis\n";
   section += "----------------------------------------\n";
   section += StringFormat("Working Deep View: %s\n", ASC_TextOrUnavailable(view_state));
   section += StringFormat("Operator Use: %s\n", ASC_TextOrUnavailable(operator_use));
   section += ASC_DossierBuildSiamTacticalReadback(body);
   if(StringLen(current_focus_summary_block) > 0)
      section += current_focus_summary_block;
   if(StringLen(l6_dossier_band) > 0)
      section += l6_dossier_band;
   section += body;
   return section;
  }

string ASC_DossierDeepSummaryLine(const bool deep_completed,
                                  const bool deep_preserved,
                                  const bool has_deep_result,
                                  const ASC_DeepSelectiveAnalysisResult &deep_result)
  {
   if(has_deep_result && deep_result.built && deep_result.lawful)
     {
      if(StringLen(deep_result.summary_line) > 0)
         return "Completed in this publish | " + deep_result.summary_line;
      return "Completed in this publish";
     }

   if(deep_completed)
     {
      if(deep_preserved)
         return "Last confirmed deep analysis is preserved for this symbol";
      return "Completed deep analysis is available for this symbol";
     }

   return "No completed deep analysis is available yet";
  }


string ASC_DossierDeepReadbackValue(const string section_text,
                                   const string primary_label,
                                   const string secondary_label = "")
  {
   string value = ASC_TextExtractLabeledLineValue(section_text, primary_label);
   if(StringLen(value) > 0)
      return value;
   if(StringLen(secondary_label) > 0)
      return ASC_TextExtractLabeledLineValue(section_text, secondary_label);
   return "";
  }

string ASC_DossierDeepReadbackHumanizedValue(const string section_text,
                                             const string primary_label,
                                             const string secondary_label = "")
  {
   string value = ASC_DossierDeepReadbackValue(section_text, primary_label, secondary_label);
   if(StringLen(value) <= 0)
      return "unavailable";
   return ASC_ArtifactHumanizeLabel(value);
  }

string ASC_DossierDeepReadbackScoreState(const string section_text,
                                         const string score_label,
                                         const string state_label,
                                         const string fallback_state_label = "")
  {
   string score = ASC_DossierDeepReadbackValue(section_text, score_label);
   string state = ASC_DossierDeepReadbackHumanizedValue(section_text, state_label, fallback_state_label);
   if(StringLen(score) > 0)
      return state + " (" + score + ")";
   return state;
  }

string ASC_DossierBuildSiamTacticalReadback(const string section_text)
  {
   if(StringLen(section_text) <= 0)
      return "";

   string freshness = ASC_DossierDeepReadbackScoreState(section_text,
                                                        "move_freshness_score=",
                                                        "freshness_state=",
                                                        "Deep Analysis Freshness:");
   string session_sweep = ASC_DossierDeepReadbackScoreState(section_text,
                                                            "session_sweep_score=",
                                                            "session_sweep_state=",
                                                            "sweep_state=");
   string reclaim = ASC_DossierDeepReadbackScoreState(section_text,
                                                      "reclaim_score=",
                                                      "reclaim_state=");
   string failed_break = ASC_DossierDeepReadbackScoreState(section_text,
                                                           "failed_break_score=",
                                                           "failed_break_state=");
   string trap_pressure = ASC_DossierDeepReadbackScoreState(section_text,
                                                            "trap_pressure_score=",
                                                            "trap_pressure_state=");
   string pullback_state = ASC_DossierDeepReadbackHumanizedValue(section_text,
                                                                 "pullback_state=");
   string pullback_depth = ASC_DossierDeepReadbackValue(section_text,
                                                        "pullback_depth_score=");
   string pullback_quality = ASC_DossierDeepReadbackValue(section_text,
                                                          "pullback_quality_score=");
   string continuation = ASC_DossierDeepReadbackScoreState(section_text,
                                                           "continuation_readiness_score=",
                                                           "continuation_state=");
   string reversal = ASC_DossierDeepReadbackScoreState(section_text,
                                                       "reversal_pressure_score=",
                                                       "reversal_state=");
   string tactical_summary = ASC_DossierDeepReadbackValue(section_text,
                                                          "siam_tactical_summary=",
                                                          "Siam Tactical Summary:");
   string primary_fit = ASC_DossierDeepReadbackHumanizedValue(section_text,
                                                              "siam_primary_fit=");
   string primary_fit_score = ASC_DossierDeepReadbackValue(section_text,
                                                           "siam_primary_fit_score=");
   string primary_fit_posture = ASC_DossierDeepReadbackHumanizedValue(section_text,
                                                                      "siam_primary_fit_posture=");
   string primary_fit_reason = ASC_DossierDeepReadbackValue(section_text,
                                                            "siam_primary_fit_reason=");
   string secondary_fit = ASC_DossierDeepReadbackHumanizedValue(section_text,
                                                                "siam_secondary_fit=");
   string secondary_fit_score = ASC_DossierDeepReadbackValue(section_text,
                                                             "siam_secondary_fit_score=");
   string secondary_fit_posture = ASC_DossierDeepReadbackHumanizedValue(section_text,
                                                                        "siam_secondary_fit_posture=");
   string secondary_fit_reason = ASC_DossierDeepReadbackValue(section_text,
                                                              "siam_secondary_fit_reason=");
   string fit_caution = ASC_DossierDeepReadbackValue(section_text,
                                                     "siam_setup_fit_caution=");
   string fit_conclusion = ASC_DossierDeepReadbackValue(section_text,
                                                        "siam_setup_fit_conclusion=");
   string failure_invalidation = ASC_DossierDeepReadbackValue(section_text,
                                                              "failure_invalidation_summary=",
                                                              "failure_invalidation=");
   string invalidation_triggers = ASC_DossierDeepReadbackValue(section_text,
                                                               "invalidation_trigger_summary=",
                                                               "invalidation_triggers=");
   string confidence_break = ASC_DossierDeepReadbackValue(section_text,
                                                          "confidence_break_summary=",
                                                          "confidence_break=");
   string vulnerability = ASC_DossierDeepReadbackValue(section_text,
                                                       "vulnerability_summary=",
                                                       "vulnerability=");
   string path_quality = ASC_DossierDeepReadbackValue(section_text,
                                                      "path_quality_summary=",
                                                      "path_quality=");
   string run_summary = ASC_DossierDeepReadbackValue(section_text,
                                                     "Run Summary:",
                                                     "run_summary=");
   string freshness_posture = ASC_DossierDeepReadbackValue(section_text,
                                                           "freshness_posture=",
                                                           "Deep Analysis Freshness:");
   string alignment = ASC_DossierDeepReadbackHumanizedValue(section_text,
                                                            "alignment=");
   string micro_direction = ASC_DossierDeepReadbackHumanizedValue(section_text,
                                                                  "micro_direction=");
   string micro_conviction = ASC_DossierDeepReadbackHumanizedValue(section_text,
                                                                   "micro_conviction=");
   string pullback = pullback_state;
   if(StringLen(pullback_depth) > 0 || StringLen(pullback_quality) > 0)
     {
      pullback += " (";
      pullback += StringFormat("depth %s", StringLen(pullback_depth) > 0 ? pullback_depth : "unavailable");
      pullback += StringFormat(" | quality %s", StringLen(pullback_quality) > 0 ? pullback_quality : "unavailable");
      pullback += ")";
     }

   if(StringLen(tactical_summary) <= 0)
      tactical_summary = ASC_TextOrUnavailable(run_summary);

   string block = "SIAM TACTICAL READBACK\n";
   block += "----------------------------------------\n";
   block += "Decision posture: supportive deep readback only; confirm against current shortlist and Market Board context before acting\n";
   block += StringFormat("Tactical freshness: %s | Packet freshness: %s\n",
                         ASC_TextOrUnavailable(freshness),
                         ASC_TextOrUnavailable(freshness_posture));
   block += StringFormat("Structure states: sweep %s | reclaim %s | failed break %s\n",
                         ASC_TextOrUnavailable(session_sweep),
                         ASC_TextOrUnavailable(reclaim),
                         ASC_TextOrUnavailable(failed_break));
   block += StringFormat("Continuation states: pullback %s | continuation %s | reversal %s | trap pressure %s\n",
                         ASC_TextOrUnavailable(pullback),
                         ASC_TextOrUnavailable(continuation),
                         ASC_TextOrUnavailable(reversal),
                         ASC_TextOrUnavailable(trap_pressure));
   block += StringFormat("Failure / invalidation: %s\n",
                         ASC_TextOrUnavailable(failure_invalidation));
   block += StringFormat("Invalidation triggers now: %s\n",
                         ASC_TextOrUnavailable(invalidation_triggers));
   block += StringFormat("Confidence breaks first if: %s\n",
                         ASC_TextOrUnavailable(confidence_break));
   block += StringFormat("Current vulnerability: %s\n",
                         ASC_TextOrUnavailable(vulnerability));
   block += StringFormat("Path quality honesty: %s\n",
                         ASC_TextOrUnavailable(path_quality));
   block += StringFormat("Bias carry: alignment %s | micro direction %s | conviction %s\n",
                         ASC_TextOrUnavailable(alignment),
                         ASC_TextOrUnavailable(micro_direction),
                         ASC_TextOrUnavailable(micro_conviction));
   block += StringFormat("Tactical carry: %s\n",
                         ASC_TextOrUnavailable(tactical_summary));
   block += StringFormat("Setup-fit carry: primary %s %s (%s) | alternate %s %s (%s)\n",
                         ASC_TextOrUnavailable(primary_fit),
                         StringLen(primary_fit_score) > 0 ? primary_fit_score : "unavailable",
                         ASC_TextOrUnavailable(primary_fit_posture),
                         ASC_TextOrUnavailable(secondary_fit),
                         StringLen(secondary_fit_score) > 0 ? secondary_fit_score : "unavailable",
                         ASC_TextOrUnavailable(secondary_fit_posture));
   block += StringFormat("Primary fit reason: %s\n",
                         ASC_TextOrUnavailable(primary_fit_reason));
   block += StringFormat("Secondary fit reason: %s\n",
                         ASC_TextOrUnavailable(secondary_fit_reason));
   block += StringFormat("Setup-fit caution: %s\n",
                         ASC_TextOrUnavailable(fit_caution));
   block += StringFormat("Setup-fit conclusion: %s\n",
                         ASC_TextOrUnavailable(fit_conclusion));
   return block;
  }


string ASC_DossierDeepSectionPlaceholder()
  {
   string section = "";
   section += ASC_SectionMetadataBlock("fresh",
                                       "no completed deep analysis is currently on record for this symbol",
                                       "unavailable",
                                       "none",
                                       0);
   section += "Deep Selective Analysis [L5]: not yet available\n";
   section += "Deep Analysis Status: not yet available\n";
   section += "Trigger Provenance: explicit trigger required\n";
   section += "Deep Analysis Overview: no completed deep analysis is currently available for this symbol\n";
   section += "Deep Analysis Posture: not yet available\n";
   section += "Deep Analysis Summary: run explicit Deep Analysis from HUD to publish timeframe interpretation and raw proof sections\n";
   section += "Deep Analysis Outcome: unavailable\n";
   section += "L5 Boundary: l5_meaning=deep_selected_symbol_analysis_only | l5_scope=selected_symbol_depth_context | trade_permission=false | entry_signal=false | execution_permission=false | final_trade_decision=false | strategy_edge_proof=false | complete_evidence=false | built_does_not_mean_fresh=true | lawful_does_not_mean_complete_support=true | rates_complete_support=false | ticks_complete_support=false | artifact_projection=projection_only | dossier_l5_projection=consumer_only | current_focus_l5_projection=mirror_only_if_selected_symbol_exists | writers_do_not_own_l5_truth=true\n";
   section += "Deep Analysis Freshness: awaiting next refresh\n";
   section += "Refresh Request Id: awaiting_explicit_completion\n";
   section += "Last Refreshed UTC: Not yet observed\n";
   section += "Preservation State: unavailable\n";
   section += "Preservation Reason: no completed deep analysis is on record for this symbol\n";
   section += "Reset Reason: not applicable until the first completed deep analysis is published\n";

   section += "\nANALYST_HEADER\n";
   section += "----------------------------------------\n";
   section += "symbol=not_yet_available | asset_class=not_yet_available | timestamp_utc=Not yet observed | freshness=awaiting_explicit_completion | market_state=unavailable | tradable=unavailable\n";
   section += "\nANALYST_EXECUTION\n";
   section += "----------------------------------------\n";
   section += "bid=unavailable | ask=unavailable | spread_points=unavailable | spread_pct=unavailable | execution_score=unavailable | execution_posture=unavailable | friction_posture=unavailable | liquidity_quality=unavailable | scalp_tradable=unavailable | intraday_tradable=unavailable\n";
   section += "\nANALYST_POSITION_LIQUIDITY\n";
   section += "----------------------------------------\n";
   section += "daily_open=unavailable | daily_change_pct=unavailable | position_in_range_pct=unavailable | distance_to_recent_high_pct=unavailable | distance_to_recent_low_pct=unavailable | liquidity_score=unavailable | liquidity_zone=unavailable | liquidity_posture=unavailable | sweep_state=unavailable\n";
   section += "\nANALYST_MICROSTRUCTURE\n";
   section += "----------------------------------------\n";
   section += "tick_bias_now=unavailable | tick_bias_prev_window=unavailable | tick_shift=unavailable | upticks=unavailable | downticks=unavailable | flats=unavailable | pressure_shift_score=unavailable | pressure_shift_posture=unavailable | tick_burst_score=unavailable | tick_burst_flag=unavailable | micro_direction=unavailable | micro_conviction=unavailable\n";
   section += "\nANALYST_MOMENTUM\n";
   section += "----------------------------------------\n";
   section += "momentum_delta=unavailable | momentum_speed=unavailable | momentum_acceleration_score=unavailable | momentum_acceleration_posture=unavailable | move_age_score=unavailable | move_age_posture=unavailable | time_since_last_impulse_sec=unavailable | impulse_count_window=unavailable | impulse_state=unavailable\n";
   section += "\nANALYST_PARTICIPATION\n";
   section += "----------------------------------------\n";
   section += "participation_score=unavailable | participation_delta=unavailable | participation_posture=unavailable | participation_state=unavailable\n";
   section += "\nANALYST_HIERARCHY\n";
   section += "----------------------------------------\n";
   section += "short_term_bias=unavailable | mid_term_bias=unavailable | higher_timeframe_bias=unavailable | alignment=unavailable\n";
   section += "\nANALYST_TIMEFRAME_DETAIL\n";
   section += "----------------------------------------\n";
   section += "not yet available (explicit deep completion required)\n";
   section += "\nANALYST_TRADING_SPECS\n";
   section += "----------------------------------------\n";
   section += "min_lot=unavailable | max_lot=unavailable | lot_step=unavailable | contract_size=unavailable | tick_size=unavailable | tick_value=unavailable | swap_long=unavailable | swap_short=unavailable | margin_initial=unavailable | trading_allowed=unavailable\n";

   section += "\nDEBUG_FULL_VIEW\n";
   section += "----------------------------------------\n";
   section += "purpose=diagnostic_audit_and_full_trace\n";
   section += "scope=full metadata, preservation details, raw trace carry, and verbose timeframe detail\n";

   section += "\ndeep_analysis_overview\n";
   section += "----------------------------------------\n";
   section += "status=not yet available\n";
   section += "summary=no completed deep analysis is currently available for this symbol\n";
   section += "tactical_snapshot_summary=unavailable\n";
   section += "structure_liquidity_summary=unavailable\n";
   section += "session_timing_summary=unavailable\n";
   section += "score_context_summary=unavailable\n";
   section += "microstructure_summary=unavailable\n";
   section += "failure_invalidation_summary=deep failure / invalidation readout is not yet available until explicit completion lands\n";
   section += "invalidation_trigger_summary=deep invalidation-trigger readout is not yet available until explicit completion lands\n";
   section += "confidence_break_summary=deep confidence-break readout is not yet available until explicit completion lands\n";
   section += "vulnerability_summary=deep vulnerability readout is not yet available until explicit completion lands\n";

   section += "\ncross_timeframe_summary\n";
   section += "----------------------------------------\n";
   section += "deep_status=not_yet_available\n";
   section += "selected_symbol=not_yet_available\n";
   section += "canonical_symbol=not_yet_available\n";
   section += "trigger_provenance=explicit_trigger_required\n";
   section += "entitlement_status=not_yet_available\n";
   section += "last_refreshed_utc=Not yet observed\n";
   section += "deep_freshness=awaiting_explicit_completion\n";
   section += "deep_continuity=none\n";
   section += "coverage_status=not_yet_available\n";
   section += "coverage_limitations=deep coverage is not yet available until explicit completion lands\n";
   section += "failure_invalidation_summary=deep failure / invalidation readout is awaiting explicit completion\n";
   section += "invalidation_trigger_summary=deep invalidation-trigger readout is awaiting explicit completion\n";
   section += "confidence_break_summary=deep confidence-break readout is awaiting explicit completion\n";
   section += "vulnerability_summary=deep vulnerability readout is awaiting explicit completion\n";
   section += "enabled_timeframes_total=0\n";
   section += "copied_bars_total=0\n";
   section += "copied_ticks_total=0\n";
   section += "spread_samples_total=0\n";
   section += "run_summary=no completed deep analysis has been published yet\n";

   section += "\ntimeframe_analytic_summary\n";
   section += "----------------------------------------\n";
   section += "not yet available (explicit deep completion required)\n";

   section += "\ndecision_support\n";
   section += "----------------------------------------\n";
   section += "manual_review_only=yes\n";
   section += "deep_analysis_outcome=unavailable_until_explicit_completion\n";
   section += "coverage_honesty=not_yet_available\n";
   section += "coverage_limitations=deep support is still incomplete until explicit completion is published\n";
   section += "failure_invalidation=awaiting explicit completion\n";
   section += "invalidation_triggers=awaiting explicit completion\n";
   section += "confidence_break=awaiting explicit completion\n";
   section += "vulnerability=awaiting explicit completion\n";
   section += "next_operator_check=review Market State, Open-Symbol Snapshot, Shortlist Context, coverage limits, and the pending failure path until deep completion is published\n";

   section += "\ntactical_refresh_snapshot\n";
   section += "----------------------------------------\n";
   section += "summary=unavailable\n";
   section += "structure_liquidity=unavailable\n";
   section += "session_timing=unavailable\n";
   section += "score_context=unavailable\n";
   section += "microstructure=unavailable\n";
   section += "failure_invalidation=awaiting explicit completion\n";
   section += "invalidation_triggers=awaiting explicit completion\n";
   section += "confidence_break=awaiting explicit completion\n";
   section += "vulnerability=awaiting explicit completion\n";

   return ASC_DossierEnhanceDeepSection(section,
                                        "not yet available",
                                        "Use the current market-state and shortlist sections until a completed deep analysis is available.");
  }

bool ASC_DossierTryExtractDeepSection(const string payload_or_body,string &section_out)
  {
   section_out = "";

   string text = payload_or_body;
   if(StringLen(text) <= 0)
      return false;
   StringReplace(text, "\r", "");

   string start_token = "Deep Analysis\n----------------------------------------\n";
   int start = StringFind(text, start_token);
   if(start < 0)
     {
      start_token = "Deep Analysis\n";
      start = StringFind(text, start_token);
     }
   if(start < 0)
      return false;

   int search_from = start + StringLen(start_token);
   int stop = StringFind(text, "\n===============================================================================\n", search_from);
   if(stop < 0)
     {
      string end_token = "\nTRADER CONTEXT\n";
      stop = StringFind(text, end_token, search_from);
     }
   if(stop < 0)
     {
      string end_token = "\nCHANGE TRACE\n";
      stop = StringFind(text, end_token, search_from);
     }
   if(stop < 0)
     {
      string end_token = "\nAurora Signal / Semi-Auto / Full Auto Scaffolds\n";
      stop = StringFind(text, end_token, search_from);
     }
   if(stop < 0)
     {
      string end_token = "\nCANDIDATE FILTERING [L3]\n";
      stop = StringFind(text, end_token, search_from);
     }
   if(stop < 0)
      stop = StringLen(text);

   section_out = StringSubstr(text, start, stop - start);
   bool has_deep_heading = (StringFind(section_out, "Deep Analysis") >= 0);
   bool has_legacy_overview = (StringFind(section_out, "Deep Analysis Overview:") >= 0);
   bool has_canonical_outline = (StringFind(section_out, "deep_analysis_overview") >= 0
                                 || StringFind(section_out, "cross_timeframe_summary") >= 0
                                 || StringFind(section_out, "tactical_refresh_snapshot") >= 0);
   bool has_completed_marker = ASC_DossierDeepPolicyHasCompletedMarker(section_out);
   bool has_any_status_marker = (StringFind(section_out, "Deep Analysis Status:") >= 0
                                 || StringFind(section_out, "Deep Selective Analysis [L5]:") >= 0
                                 || StringFind(section_out, "Deep Analysis Outcome:") >= 0);
   if(!has_deep_heading || (!has_legacy_overview && !has_canonical_outline && !has_completed_marker && !has_any_status_marker))
      return false;
   return true;
  }


bool ASC_DossierDeepSectionHasRun055SupportTokens(const string section_text)
  {
   string lower_section = section_text;
   StringToLower(lower_section);

   bool has_l5_meaning = (StringFind(lower_section, "l5_meaning=deep_selected_symbol_analysis_only") >= 0);
   bool has_no_trade = (StringFind(lower_section, "trade_permission=false") >= 0);
   bool has_no_entry = (StringFind(lower_section, "entry_signal=false") >= 0);
   bool has_no_execution = (StringFind(lower_section, "execution_permission=false") >= 0);
   bool has_no_final_decision = (StringFind(lower_section, "final_trade_decision=false") >= 0);
   bool has_no_strategy_edge = (StringFind(lower_section, "strategy_edge_proof=false") >= 0);
   bool has_support_posture = (StringFind(section_text, "support_posture=") >= 0);
   bool has_l5_support = (StringFind(section_text, "l5_support_posture=") >= 0);
   bool has_rates_status = (StringFind(section_text, "rates_status=") >= 0);
   bool has_ticks_status = (StringFind(section_text, "ticks_status=") >= 0);
   bool has_timeframe_coverage = (StringFind(section_text, "timeframe_coverage=") >= 0);
   bool has_data_window_age = (StringFind(section_text, "data_window_age=") >= 0);
   bool has_sample_status = (StringFind(section_text, "sample_status=") >= 0);
   bool has_resolver_limit = (StringFind(section_text, "resolver_limit=") >= 0);
   bool has_artifact_projection = (StringFind(section_text, "artifact_projection=") >= 0);
   bool has_copy_support_boundary = (StringFind(lower_section, "rates_complete_support=") >= 0
                                    && StringFind(lower_section, "ticks_complete_support=") >= 0);

   return (has_l5_meaning
           && has_no_trade
           && has_no_entry
           && has_no_execution
           && has_no_final_decision
           && has_no_strategy_edge
           && has_copy_support_boundary
           && has_support_posture
           && has_l5_support
           && has_rates_status
           && has_ticks_status
           && has_timeframe_coverage
           && has_data_window_age
           && has_sample_status
           && has_resolver_limit
           && has_artifact_projection);
  }

bool ASC_DossierDeepSectionHasCompletedTruth(const string payload_or_section)
  {
   string section_text = payload_or_section;
   StringReplace(section_text, "\r", "");
   if(StringFind(section_text, "Deep Analysis\n----------------------------------------\n") >= 0
      || StringFind(section_text, "deep_analysis_overview") < 0)
     {
      string extracted = "";
      if(!ASC_DossierTryExtractDeepSection(payload_or_section, extracted))
         return false;
      section_text = extracted;
     }
   string lower_section = section_text;
   StringToLower(lower_section);

   if(ASC_DossierDeepPolicyHasBlockedPlaceholderMarker(section_text))
      return false;

   bool has_completed_marker = ASC_DossierDeepPolicyHasCompletedMarker(section_text);
   if(!has_completed_marker)
      return false;

   bool legacy_completed =
      (StringFind(section_text, "Deep Analysis Overview:") >= 0
       && StringFind(section_text, "Deep Analysis Summary:") >= 0
       && StringFind(section_text, "Preservation State:") >= 0
       && StringFind(section_text, "Last Refreshed UTC:") >= 0);

   bool canonical_completed =
      ((StringFind(lower_section, "deep analysis status: completed") >= 0
        || StringFind(lower_section, "deep selective analysis [l5]: completed") >= 0)
       && (StringFind(section_text, "Run Summary:") >= 0
           || StringFind(lower_section, "run_summary=") >= 0)
       && (StringFind(lower_section, "cross_timeframe_summary") >= 0
           || StringFind(lower_section, "timeframe_analytic_summary") >= 0)
       && (StringFind(lower_section, "tactical_refresh_snapshot") >= 0
           || StringFind(lower_section, "decision_support") >= 0));

   if(!legacy_completed && !canonical_completed)
      return false;

   if(!ASC_DossierDeepSectionHasRun055SupportTokens(section_text))
      return false;

   bool has_overview_context = (StringFind(lower_section, "deep_analysis_overview") >= 0
                                || StringFind(lower_section, "deep analysis overview:") >= 0);
   bool has_preservation_context = (StringFind(lower_section, "preservation_state") >= 0
                                    || StringFind(lower_section, "preservation state:") >= 0);
   bool has_evidence_block = (StringFind(lower_section, "ohlc_by_enabled_timeframe") >= 0
                              || StringFind(lower_section, "recent_tick_activity") >= 0
                              || StringFind(lower_section, "live_spread_rollover") >= 0
                              || StringFind(lower_section, "analyst_timeframe_detail") >= 0);
   if(!has_overview_context || !has_preservation_context || !has_evidence_block)
      return false;

   string blocked_phrases[];
   ArrayResize(blocked_phrases, 7);
   blocked_phrases[0] = "command-only until explicitly triggered";
   blocked_phrases[1] = "no deep analysis has been landed for this symbol yet";
   blocked_phrases[2] = "Deep Analysis Outcome: not yet available";
   blocked_phrases[3] = "Preservation State: not_run";
   blocked_phrases[4] = "Preservation Reason: deep analysis has not yet been requested for this symbol";
   blocked_phrases[5] = "Reset Reason: no explicit Deep Analysis completion has been published yet";
   blocked_phrases[6] = "- note: waiting for explicit Deep Analysis completion";

   for(int i = 0; i < ArraySize(blocked_phrases); i++)
      if(StringFind(section_text, blocked_phrases[i]) >= 0)
         return false;

   return true;
  }

bool ASC_DossierPayloadHasFreshDeepTruth(const string payload_text,
                                         const ASC_DeepSelectiveAnalysisResult &deep_result)
  {
   if(!deep_result.built || !deep_result.lawful || StringLen(deep_result.block_text) <= 0)
      return false;

   string section_text = "";
   if(!ASC_DossierTryExtractDeepSection(payload_text, section_text))
      return false;
   if(!ASC_DossierDeepSectionHasCompletedTruth(section_text))
      return false;
   if(StringFind(section_text, deep_result.block_text) < 0)
      return false;
   bool outcome_completed = (StringFind(section_text, "Deep Analysis Outcome: completed") >= 0
                             || StringFind(section_text, "Deep Analysis Status: completed") >= 0
                             || StringFind(section_text, "Deep Selective Analysis [L5]: completed") >= 0);
   if(!outcome_completed)
      return false;
   if(StringLen(deep_result.canonical_symbol) > 0
      && StringFind(section_text, "canonical_symbol=" + deep_result.canonical_symbol) < 0)
      return false;
   if(StringLen(deep_result.execution_context) > 0
      && StringFind(section_text, "execution_context=" + deep_result.execution_context) < 0)
      return false;
   if(StringLen(deep_result.shortlist_context) > 0
      && StringFind(section_text, "shortlist_context=" + deep_result.shortlist_context) < 0)
      return false;
   if(StringFind(section_text, "shortlist_rank=" + IntegerToString(deep_result.shortlist_rank)) < 0)
      return false;
   if(StringLen(deep_result.market_state_context) > 0
      && StringFind(section_text, "market_state_context=" + deep_result.market_state_context) < 0)
      return false;
   if(StringLen(deep_result.support_posture) > 0
      && StringFind(section_text, "support_posture=" + deep_result.support_posture) < 0)
      return false;
   if(StringLen(deep_result.l5_support_posture) > 0
      && StringFind(section_text, "l5_support_posture=" + deep_result.l5_support_posture) < 0)
      return false;
   if(StringLen(deep_result.rates_status) > 0
      && StringFind(section_text, "rates_status=" + deep_result.rates_status) < 0)
      return false;
   if(StringLen(deep_result.ticks_status) > 0
      && StringFind(section_text, "ticks_status=" + deep_result.ticks_status) < 0)
      return false;
   if(StringLen(deep_result.timeframe_coverage) > 0
      && StringFind(section_text, "timeframe_coverage=" + deep_result.timeframe_coverage) < 0)
      return false;
   if(StringLen(deep_result.data_window_age) > 0
      && StringFind(section_text, "data_window_age=" + deep_result.data_window_age) < 0)
      return false;
   if(StringLen(deep_result.sample_status) > 0
      && StringFind(section_text, "sample_status=" + deep_result.sample_status) < 0)
      return false;
   if(StringLen(deep_result.resolver_limit) > 0
      && StringFind(section_text, "resolver_limit=" + deep_result.resolver_limit) < 0)
      return false;
   if(StringLen(deep_result.artifact_projection) > 0
      && StringFind(section_text, "artifact_projection=" + deep_result.artifact_projection) < 0)
      return false;
   if(StringFind(section_text, "trade_permission=false") < 0
      || StringFind(section_text, "entry_signal=false") < 0
      || StringFind(section_text, "execution_permission=false") < 0
      || StringFind(section_text, "final_trade_decision=false") < 0
      || StringFind(section_text, "strategy_edge_proof=false") < 0)
      return false;
   if(StringLen(deep_result.build_context) > 0
      && StringFind(section_text, "build_context=" + deep_result.build_context) < 0)
      return false;
   return true;
  }


string ASC_DossierExtractIdentityLineValue(const string payload_text,
                                         const string label)
  {
   if(StringLen(payload_text) <= 0 || StringLen(label) <= 0)
      return "";

   string text = payload_text;
   StringReplace(text, "\r", "");
   int cursor = 0;
   int text_len = (int)StringLen(text);
   while(cursor < text_len)
     {
      int next_break = StringFind(text, "\n", cursor);
      string line = (next_break >= 0)
                    ? StringSubstr(text, cursor, next_break - cursor)
                    : StringSubstr(text, cursor);
      string trimmed = line;
      StringTrimLeft(trimmed);
      if(StringFind(trimmed, "- ") == 0)
         trimmed = StringSubstr(trimmed, 2);
      if(StringFind(trimmed, label) == 0)
        {
         string value = StringSubstr(trimmed, (int)StringLen(label));
         StringTrimLeft(value);
         StringTrimRight(value);
         return value;
        }
      if(next_break < 0)
         break;
      cursor = next_break + 1;
     }

   return "";
  }

bool ASC_DossierPayloadMatchesSymbolContext(const string payload_text,
                                            const ASC_Layer1SymbolState &symbol_state,
                                            const string canonical_symbol)
  {
   if(StringLen(payload_text) <= 0)
      return false;

   string payload_symbol = ASC_DossierExtractIdentityLineValue(payload_text, "Symbol:");
   string payload_canonical = ASC_DossierExtractIdentityLineValue(payload_text, "Canonical Symbol:");
   string aliases[];
   ArrayResize(aliases, 0);

   if(StringLen(symbol_state.symbol) > 0)
     {
      int next = ArraySize(aliases);
      ArrayResize(aliases, next + 1);
      aliases[next] = symbol_state.symbol;
     }
   if(StringLen(symbol_state.identity.raw_symbol) > 0)
     {
      int next = ArraySize(aliases);
      ArrayResize(aliases, next + 1);
      aliases[next] = symbol_state.identity.raw_symbol;
     }
   if(StringLen(symbol_state.identity.normalized_symbol) > 0)
     {
      int next = ArraySize(aliases);
      ArrayResize(aliases, next + 1);
      aliases[next] = symbol_state.identity.normalized_symbol;
     }
   if(StringLen(symbol_state.identity.canonical_symbol) > 0)
     {
      int next = ArraySize(aliases);
      ArrayResize(aliases, next + 1);
      aliases[next] = symbol_state.identity.canonical_symbol;
     }
   if(StringLen(symbol_state.classification.raw_symbol) > 0)
     {
      int next = ArraySize(aliases);
      ArrayResize(aliases, next + 1);
      aliases[next] = symbol_state.classification.raw_symbol;
     }
   if(StringLen(symbol_state.classification.canonical_symbol) > 0)
     {
      int next = ArraySize(aliases);
      ArrayResize(aliases, next + 1);
      aliases[next] = symbol_state.classification.canonical_symbol;
     }
   if(StringLen(canonical_symbol) > 0)
     {
      int next = ArraySize(aliases);
      ArrayResize(aliases, next + 1);
      aliases[next] = canonical_symbol;
     }

   bool payload_symbol_alias_match = false;
   bool payload_canonical_alias_match = false;
   for(int i = 0; i < ArraySize(aliases); i++)
     {
      string alias = aliases[i];
      if(StringLen(alias) <= 0)
         continue;
      if(StringLen(payload_symbol) > 0 && payload_symbol == alias)
         payload_symbol_alias_match = true;
      if(StringLen(payload_canonical) > 0 && payload_canonical == alias)
         payload_canonical_alias_match = true;
      if(payload_symbol_alias_match && payload_canonical_alias_match)
         break;
     }

   bool symbol_match = false;
   if(StringLen(payload_symbol) > 0)
     {
      if(ASC_DeepSymbolMatchesContext(symbol_state, payload_symbol))
         symbol_match = true;
      else if(payload_symbol_alias_match)
         symbol_match = true;
      else if(StringLen(canonical_symbol) > 0 && payload_symbol == canonical_symbol)
         symbol_match = true;
     }

   bool canonical_match = false;
   if(StringLen(payload_canonical) > 0)
     {
      if(ASC_DeepSymbolMatchesContext(symbol_state, payload_canonical))
         canonical_match = true;
      else if(payload_canonical_alias_match)
         canonical_match = true;
      else if(StringLen(canonical_symbol) > 0 && payload_canonical == canonical_symbol)
         canonical_match = true;
     }

   return (symbol_match || canonical_match);
  }

bool ASC_DossierPayloadMatchesCanonicalSymbol(const string payload_text,
                                              const string canonical_symbol)
  {
   if(StringLen(payload_text) <= 0 || StringLen(canonical_symbol) <= 0)
      return false;

   string payload_symbol = ASC_DossierExtractIdentityLineValue(payload_text, "Symbol:");
   string payload_canonical = ASC_DossierExtractIdentityLineValue(payload_text, "Canonical Symbol:");
   if(payload_symbol == canonical_symbol || payload_canonical == canonical_symbol)
      return true;

   ASC_SymbolIdentity canonical_identity = ASC_NormalizeSymbol(canonical_symbol);
   if(StringLen(canonical_identity.normalized_symbol) > 0)
     {
      ASC_SymbolIdentity payload_symbol_identity = ASC_NormalizeSymbol(payload_symbol);
      ASC_SymbolIdentity payload_canonical_identity = ASC_NormalizeSymbol(payload_canonical);
      if(payload_symbol_identity.normalized_symbol == canonical_identity.normalized_symbol
         || payload_canonical_identity.normalized_symbol == canonical_identity.normalized_symbol)
         return true;
     }

   return false;
  }

bool ASC_VerifyRetainedDossierCurrentFocusPair(const string dossier_path,
                                               const string focus_path,
                                               const ASC_Layer1SymbolState &symbol_state,
                                               const string canonical_symbol,
                                               const datetime truth_floor_utc,
                                               const bool require_completed_deep_truth,
                                               string &verification_reason)
  {
   verification_reason = "pending";

   string dossier_readback = "";
   if(!ASC_ReadTextFile(dossier_path, dossier_readback) || StringLen(dossier_readback) <= 0)
     {
      verification_reason = "retained_dossier_missing path=" + dossier_path;
      return false;
     }

   string focus_readback = "";
   if(!ASC_ReadTextFile(focus_path, focus_readback) || StringLen(focus_readback) <= 0)
     {
      verification_reason = "retained_current_focus_missing path=" + focus_path;
      return false;
     }

   if(dossier_readback != focus_readback)
     {
      string dossier_publication_id = ASC_PublicationPayloadId(dossier_readback);
      string focus_publication_id = ASC_PublicationPayloadId(focus_readback);
      if(StringLen(dossier_publication_id) > 0
         && StringLen(focus_publication_id) > 0
         && dossier_publication_id != focus_publication_id)
        {
         verification_reason = StringFormat("retained_pair_publication_id_mismatch dossier_id=%s focus_id=%s",
                                            dossier_publication_id,
                                            focus_publication_id);
         return false;
        }

      if(!ASC_PublicationPayloadMateriallyEqual(dossier_readback, focus_readback))
        {
         verification_reason = "retained_pair_payload_mismatch";
         return false;
        }
     }

   if(!ASC_DossierPayloadMatchesSymbolContext(dossier_readback, symbol_state, canonical_symbol))
     {
      verification_reason = "retained_pair_symbol_mismatch";
      return false;
     }

   if(!ASC_DossierPayloadMatchesSymbolContext(focus_readback, symbol_state, canonical_symbol))
     {
      verification_reason = "retained_pair_current_focus_symbol_mismatch";
      return false;
     }

   if(StringLen(canonical_symbol) > 0)
     {
      if(!ASC_DossierPayloadMatchesCanonicalSymbol(dossier_readback, canonical_symbol))
        {
         verification_reason = "retained_pair_canonical_mismatch";
         return false;
        }
      if(!ASC_DossierPayloadMatchesCanonicalSymbol(focus_readback, canonical_symbol))
        {
         verification_reason = "retained_pair_current_focus_canonical_mismatch";
         return false;
        }
     }

   datetime dossier_modified_utc = 0;
   datetime focus_modified_utc = 0;
   bool dossier_has_modify_utc = ASC_FileTryGetModifyUtc(dossier_path, dossier_modified_utc);
   bool focus_has_modify_utc = ASC_FileTryGetModifyUtc(focus_path, focus_modified_utc);
   if(truth_floor_utc > 0)
     {
      if(!dossier_has_modify_utc || dossier_modified_utc < truth_floor_utc)
        {
         verification_reason = StringFormat("retained_pair_dossier_stale truth_floor=%s dossier_modified=%s",
                                            ASC_ArtifactFormatUtc(truth_floor_utc),
                                            dossier_has_modify_utc ? ASC_ArtifactFormatUtc(dossier_modified_utc) : "unavailable");
         return false;
        }
      if(!focus_has_modify_utc || focus_modified_utc < truth_floor_utc)
        {
         verification_reason = StringFormat("retained_pair_current_focus_stale truth_floor=%s focus_modified=%s",
                                            ASC_ArtifactFormatUtc(truth_floor_utc),
                                            focus_has_modify_utc ? ASC_ArtifactFormatUtc(focus_modified_utc) : "unavailable");
         return false;
        }
     }

   string retained_publication_id = ASC_PublicationPayloadId(dossier_readback);
   if(require_completed_deep_truth && !ASC_DossierDeepSectionHasCompletedTruth(dossier_readback))
     {
      verification_reason = StringFormat("retained_pair_deep_truth_incomplete publication_id=%s",
                                         (StringLen(retained_publication_id) > 0 ? retained_publication_id : "unavailable"));
      return false;
     }
   if(require_completed_deep_truth && !ASC_DossierDeepSectionHasCompletedTruth(focus_readback))
     {
      verification_reason = StringFormat("retained_pair_current_focus_deep_truth_incomplete publication_id=%s",
                                         (StringLen(retained_publication_id) > 0 ? retained_publication_id : "unavailable"));
      return false;
     }
   if(require_completed_deep_truth
      && StringLen(canonical_symbol) > 0
      && StringFind(dossier_readback, "canonical_symbol=" + canonical_symbol) < 0)
     {
      verification_reason = StringFormat("retained_pair_deep_truth_symbol_mismatch publication_id=%s canonical_symbol=%s",
                                         (StringLen(retained_publication_id) > 0 ? retained_publication_id : "unavailable"),
                                         canonical_symbol);
      return false;
     }

   if(require_completed_deep_truth
      && StringLen(canonical_symbol) > 0
      && StringFind(focus_readback, "canonical_symbol=" + canonical_symbol) < 0)
     {
      verification_reason = StringFormat("retained_pair_current_focus_deep_truth_symbol_mismatch publication_id=%s canonical_symbol=%s",
                                         (StringLen(retained_publication_id) > 0 ? retained_publication_id : "unavailable"),
                                         canonical_symbol);
      return false;
     }

   if(require_completed_deep_truth)
     {
      string required_override_tokens[];
      ArrayResize(required_override_tokens, 16);
      required_override_tokens[0] = "execution_context=";
      required_override_tokens[1] = "shortlist_context=";
      required_override_tokens[2] = "shortlist_rank=";
      required_override_tokens[3] = "market_state_context=";
      required_override_tokens[4] = "support_posture=";
      required_override_tokens[5] = "build_context=";
      required_override_tokens[6] = "l5_meaning=deep_selected_symbol_analysis_only";
      required_override_tokens[7] = "trade_permission=false";
      required_override_tokens[8] = "entry_signal=false";
      required_override_tokens[9] = "l5_support_posture=";
      required_override_tokens[10] = "rates_status=";
      required_override_tokens[11] = "ticks_status=";
      required_override_tokens[12] = "timeframe_coverage=";
      required_override_tokens[13] = "data_window_age=";
      required_override_tokens[14] = "resolver_limit=";
      required_override_tokens[15] = "artifact_projection=";

      for(int token_i = 0; token_i < ArraySize(required_override_tokens); token_i++)
        {
         string token = required_override_tokens[token_i];
         if(StringFind(dossier_readback, token) < 0)
           {
            verification_reason = StringFormat("retained_pair_override_context_missing token=%s publication_id=%s",
                                               token,
                                               (StringLen(retained_publication_id) > 0 ? retained_publication_id : "unavailable"));
            return false;
           }
         if(StringFind(focus_readback, token) < 0)
           {
            verification_reason = StringFormat("retained_pair_current_focus_override_context_missing token=%s publication_id=%s",
                                               token,
                                               (StringLen(retained_publication_id) > 0 ? retained_publication_id : "unavailable"));
            return false;
           }
        }
     }

   verification_reason = StringFormat("retained_pair_verified publication_id=%s",
                                      (StringLen(retained_publication_id) > 0 ? retained_publication_id : "unavailable"));
   return true;
  }


string ASC_ResolveDossierDeepSection(const string server_root,
                                     const string canonical_symbol,
                                     const bool has_deep_result,
                                     const ASC_DeepSelectiveAnalysisResult &deep_result)
  {
   string current_focus_summary_block = "";
   string l6_dossier_band = "";
   string l6_review_latest_change = "";
   string l6_review_previous_change = "";
   string l6_review_state_transition = "";
   string l6_review_selection_transition = "";
   string l6_review_deep_transition = "";
   if(has_deep_result)
      ASC_DossierBuildLayer6SurfaceBlocks(server_root,
                                          canonical_symbol,
                                          deep_result,
                                          current_focus_summary_block,
                                          l6_dossier_band,
                                          l6_review_latest_change,
                                          l6_review_previous_change,
                                          l6_review_state_transition,
                                          l6_review_selection_transition,
                                          l6_review_deep_transition);

   if(ASC_DossierDeepPolicyAllowFreshPayloadProjection(has_deep_result, deep_result))
     {
      return ASC_DossierEnhanceDeepSection(deep_result.block_text,
                                           "completed",
                                           StringLen(deep_result.summary_line) > 0
                                           ? deep_result.summary_line
                                           : "Completed deep analysis is available for the selected symbol.",
                                           current_focus_summary_block,
                                           l6_dossier_band);
     }

   string existing_payload = "";
   if(ASC_DossierDeepPolicyAllowPreservedPayloadAccess(server_root, canonical_symbol))
     {
      ASC_ArtifactContract contract = ASC_DossierContract(server_root, canonical_symbol);
      if(ASC_ReadTextFile(contract.target_path, existing_payload))
        {
         if(!ASC_DossierPayloadMatchesCanonicalSymbol(existing_payload, canonical_symbol))
            return ASC_DossierDeepSectionPlaceholder();

         string preserved_section = "";
         if(ASC_DossierTryExtractDeepSection(existing_payload, preserved_section))
           {
            bool deep_completed = ASC_DossierDeepSectionHasCompletedTruth(preserved_section);
            if(deep_completed)
               return ASC_DossierEnhanceDeepSection(preserved_section,
                                                    "last confirmed value",
                                                    "The most recent completed deep analysis for this symbol is being preserved.",
                                                    current_focus_summary_block,
                                                    l6_dossier_band);
            return ASC_DossierEnhanceDeepSection(preserved_section,
                                                 "not yet available",
                                                 "Use the current market-state and shortlist sections until a completed deep analysis is available.",
                                                 current_focus_summary_block,
                                                 l6_dossier_band);
           }
        }
     }

   return ASC_DossierDeepSectionPlaceholder();
  }


string ASC_BuildDossierSelectedSymbolContradictionSurface(const bool explicit_selected_symbol_path,
                                                         const bool include_l3_section,
                                                         const bool include_l4_section,
                                                         const bool include_l5_section,
                                                         const bool has_deep_result,
                                                         const bool deep_completed,
                                                         const bool explicit_global_top10_path,
                                                         const int open_positions,
                                                         const int pending_orders,
                                                         const string deep_status_line,
                                                         const string dossier_shortlist_source_label,
                                                         const string runtime_selected_symbol_context)
  {
   string section = "";
   section += ASC_DOSSIER_CONTRADICTION_SECTION_NAME + "\n";
   section += "----------------------------------------\n";
   section += "section_name=" + ASC_DOSSIER_CONTRADICTION_SECTION_NAME
              + " | contradiction_surface=" + ASC_DOSSIER_CONTRADICTION_SURFACE_ADVISORY_ONLY
              + " | publication_blocker=" + ASC_DOSSIER_CONTRADICTION_PUBLICATION_BLOCKER_FALSE
              + " | trade_permission=false | entry_signal=false | execution_permission=false | final_trade_decision=false | strategy_edge_proof=false"
              + " | veto_power=" + ASC_DOSSIER_CONTRADICTION_VETO_POWER_FALSE
              + " | truth_owner=" + ASC_DOSSIER_CONTRADICTION_TRUTH_OWNER_FALSE
              + " | artifact_projection=" + ASC_DOSSIER_CONTRADICTION_ARTIFACT_PROJECTION_ONLY
              + " | behavior_change=" + ASC_DOSSIER_CONTRADICTION_BEHAVIOR_CHANGE_NONE + "\n";
   section += "Proof Scope: source_supported=" + (explicit_selected_symbol_path ? "true" : "qualified")
              + " | runtime_observed=false | source_patched_live_unproven=true | pre_patch_live_proven_post_patch_unproven=RUN065R_scope_only"
              + " | source_supported_runtime_unobserved=" + (explicit_selected_symbol_path ? "true" : "not_selected_symbol_path")
              + " | scenario_absent_untested=open_positions_and_pending_orders_nonzero_cases"
              + " | held_for_future_live=RUN076R_or_later | retained_last_good=possible | current=qualified | archive=not_current_truth"
              + " | unavailable=must_be_labeled | partial=must_be_labeled | stale=must_be_labeled\n";
   section += "Layer Contradiction Categories: l3_score_support_only=" + (include_l3_section ? "visible" : "not_visible_on_this_path")
              + " | l4_rank_support_only=" + (include_l4_section ? "visible" : "not_visible_on_this_path")
              + " | l5_deep_support_only=" + (include_l5_section ? "visible" : "not_visible_on_this_path")
              + " | score_vs_rank_mismatch=advisory_only | deep_analysis_overclaim=advisory_only"
              + " | stale_source_projection=advisory_only | unavailable_as_clean_truth=advisory_only"
              + " | retained_last_good_as_current=advisory_only | source_supported_not_runtime_observed=advisory_only\n";
   section += "Portfolio / History Boundaries: active_exposure=open_positions_only | future_exposure=pending_orders_only"
              + " | closed_history_context_only=true | closed_history_not_active_exposure=true | closed_history_candidate_blocker=false"
              + " | portfolio_history_vs_active_exposure_confusion=advisory_only"
              + " | open_positions_count=" + IntegerToString(open_positions)
              + " | pending_orders_count=" + IntegerToString(pending_orders) + "\n";
   section += "GlobalTop10 Current / Archive Boundary: globaltop10_current_vs_archive_confusion=advisory_only"
              + " | globaltop10_truth_owner_unchanged=true | no_globaltop10_publication_change=true"
              + " | explicit_global_top10_path=" + (explicit_global_top10_path ? "true" : "false") + "\n";
   section += "Dossier Ownership Boundary: dossier_truth_artifact=true | dossier_writer_composes_only=true"
              + " | current_focus_mirror_only_if_selected_symbol_exists=true | market_board_summary_projection_only=true"
              + " | writers_do_not_own_layer_truth=true | selected_symbol_path=" + (explicit_selected_symbol_path ? "true" : "false")
              + " | shortlist_source=" + ASC_TextOrUnavailable(dossier_shortlist_source_label)
              + " | runtime_selected_symbol_context=" + ASC_TextOrUnavailable(runtime_selected_symbol_context) + "\n";
   section += "Root Dossier Selected-Symbol Mirror Boundary: dossier_selected_symbol_role=" + ASC_CURRENT_FOCUS_ROLE_DOSSIER_DERIVATIVE_MIRROR
              + " | current_focus_truth_owner=" + ASC_CURRENT_FOCUS_TRUTH_OWNER_FALSE
              + " | current_focus_recomputes_truth=" + ASC_CURRENT_FOCUS_RECOMPUTES_TRUTH_FALSE
              + " | current_focus_selects_symbol=" + ASC_CURRENT_FOCUS_SELECTS_SYMBOL_FALSE
              + " | current_focus_changes_rank=" + ASC_CURRENT_FOCUS_CHANGES_RANK_FALSE
              + " | current_focus_changes_top10=" + ASC_CURRENT_FOCUS_CHANGES_TOP10_FALSE
              + " | current_focus_publication_blocker=" + ASC_CURRENT_FOCUS_PUBLICATION_BLOCKER_FALSE
              + " | artifact_projection=" + ASC_CURRENT_FOCUS_ARTIFACT_PROJECTION_MIRROR_ONLY
              + " | selected_symbol_required=" + ASC_CURRENT_FOCUS_SELECTED_SYMBOL_REQUIRED_TRUE
              + " | selected_symbol_none_status=" + ASC_CURRENT_FOCUS_SELECTED_SYMBOL_NONE_STATUS
              + " | selected_symbol_none_not_failure=" + ASC_CURRENT_FOCUS_SELECTED_SYMBOL_NONE_NOT_FAILURE_TRUE
              + " | selected_symbol_none_not_live_proof=" + ASC_CURRENT_FOCUS_SELECTED_SYMBOL_NONE_NOT_LIVE_PROOF_TRUE
              + " | current_focus_only_for_selected_symbol=" + ASC_CURRENT_FOCUS_ONLY_FOR_SELECTED_SYMBOL_TRUE
              + " | same_symbol_readback_required=" + ASC_CURRENT_FOCUS_SAME_SYMBOL_READBACK_REQUIRED_TRUE
              + " | cross_symbol_overwrite_forbidden=" + ASC_CURRENT_FOCUS_CROSS_SYMBOL_OVERWRITE_FORBIDDEN_TRUE
              + " | protected_same_symbol_readback=" + ASC_CURRENT_FOCUS_PROTECTED_SAME_SYMBOL_READBACK_TRUE
              + " | richer_same_symbol_payload_preserved=" + ASC_CURRENT_FOCUS_RICHER_SAME_SYMBOL_PAYLOAD_PRESERVED_TRUE
              + " | poorer_payload_cannot_overwrite_richer=" + ASC_CURRENT_FOCUS_POORER_PAYLOAD_CANNOT_OVERWRITE_RICHER_TRUE
              + " | dossier_contradiction_surface_recognized=" + ASC_CURRENT_FOCUS_DOSSIER_CONTRADICTION_RECOGNIZED_TRUE
              + " | market_board_contradiction_context=board_context_only"
              + " | behavior_change=" + ASC_CURRENT_FOCUS_BEHAVIOR_CHANGE_NONE + "\n";
   section += "Deep Boundary Carry: has_deep_result=" + (has_deep_result ? "true" : "false")
              + " | deep_completed=" + (deep_completed ? "true" : "false")
              + " | deep_status=" + ASC_TextOrUnavailable(deep_status_line)
              + " | l5_meaning=deep_selected_symbol_analysis_only | l5_not_trade_permission=true | l5_not_entry_signal=true | l5_not_execution_decision=true\n";
   section += "Publication Guard: optional_section=true | optional_section_may_block_dossier=false | optional_section_may_block_market_board=false | optional_section_may_block_current_focus=false | optional_section_may_block_globaltop10=false\n";
   section += "Observability Guard: functionresults_emit_scope=none_from_this_section | aggregate_only=true | per_symbol_spam=false | per_trade_spam=false | per_timeframe_spam=false | per_bar_spam=false | per_tick_spam=false\n\n";
   return section;
  }

string ASC_DossierHydrationClassLabel(const ASC_DossierProductMode dossier_mode,
                                      const bool explicit_selected_symbol_path,
                                      const bool explicit_global_top10_path,
                                      const bool deep_completed,
                                      const bool has_deep_result,
                                      const ASC_Layer1SymbolState &symbol_state,
                                      const bool has_packet,
                                      const bool has_market_watch,
                                      const bool include_l4_section,
                                      const ASC_Layer2Packet &packet)
  {
   if(dossier_mode == ASC_DOSSIER_MODE_CLOSED_MARKET || symbol_state.state == ASC_L1_CLOSED)
      return "closed_compact_l0_l2";

   if(explicit_selected_symbol_path)
     {
      if(deep_completed && explicit_global_top10_path)
         return "top10_deep_l0_l6";
      if(deep_completed)
         return "selected_deep_l0_l6";
      if(has_deep_result)
         return "stalled_or_dependency_blocked";
      return "pending_publication";
     }

   if(symbol_state.state == ASC_L1_OPEN)
     {
      if(has_market_watch && include_l4_section)
         return "open_broad_l0_l4";
      if(has_packet && packet.hydration_family != ASC_L2_HYDRATION_READY)
         return "pending_publication";
      if(symbol_state.is_stale || symbol_state.is_degraded)
         return "stalled_or_dependency_blocked";
      return "pending_publication";
     }

   return "unknown_unclassified";
  }

string ASC_DossierHydrationClassReason(const string hydration_class,
                                       const ASC_DossierProductMode dossier_mode,
                                       const bool explicit_selected_symbol_path,
                                       const bool explicit_global_top10_path,
                                       const bool deep_completed,
                                       const bool has_deep_result,
                                       const ASC_Layer1SymbolState &symbol_state,
                                       const bool has_packet,
                                       const bool has_market_watch,
                                       const bool include_l3_section,
                                       const bool include_l4_section,
                                       const ASC_Layer2Packet &packet,
                                       const bool shortlist_found,
                                       const bool shortlist_ranked)
  {
   if(hydration_class == "closed_compact_l0_l2")
      return "closed or closed-mode Dossier keeps Layer 0-2 truth compact and does not fabricate live/ranking/deep evidence";
   if(hydration_class == "top10_deep_l0_l6")
      return "GlobalTop10 batch path has completed Deep Analysis truth for this child artifact";
   if(hydration_class == "selected_deep_l0_l6")
      return "explicit selected-symbol path has completed Deep Analysis truth available for this symbol only";
   if(hydration_class == "open_broad_l0_l4")
      return "open-market Dossier has a lawful market-watch packet and ordinary Layer 3/4 consumer sections are visible";
   if(hydration_class == "pending_publication")
     {
      if(explicit_selected_symbol_path && !deep_completed)
         return "explicit selected-symbol path is waiting for completed Deep Analysis before it can claim deep hydration";
      if(has_packet && packet.hydration_family != ASC_L2_HYDRATION_READY)
         return "open-symbol snapshot packet exists but its hydration family is not ready yet";
      if(!has_market_watch)
         return "market-watch snapshot is not ready for broad Dossier evidence yet";
      if(!include_l3_section || !include_l4_section)
         return "ordinary Layer 3/4 consumer visibility is not admitted for this publish";
      return "publication is queued or awaiting a dependency before a stronger hydration class can be claimed";
     }
   if(hydration_class == "stalled_or_dependency_blocked")
     {
      if(has_deep_result && !deep_completed)
         return "deep packet was attempted but did not produce completed lawful deep truth";
      if(symbol_state.is_stale || symbol_state.is_degraded)
         return "market-state freshness is stale or degraded, so broad truth must be guarded";
      return "one or more publication dependencies are blocking stronger Dossier hydration";
     }
   return "Dossier publish path could not classify hydration from the currently available state";
  }

string ASC_DossierHydrationClassProofLine(const string hydration_class,
                                          const string hydration_reason,
                                          const ASC_DossierProductMode dossier_mode,
                                          const bool has_packet,
                                          const bool has_market_watch,
                                          const bool shortlist_found,
                                          const bool shortlist_ranked,
                                          const bool deep_completed,
                                          const bool explicit_selected_symbol_path,
                                          const bool explicit_global_top10_path)
  {
   string line = "Hydration Classification\n";
   line += "  - Hydration Class: " + hydration_class + "\n";
   line += "  - Hydration Reason: " + hydration_reason + "\n";
   line += "  - Hydration Evidence: mode=" + IntegerToString((int)dossier_mode)
           + " | has_packet=" + (has_packet ? "yes" : "no")
           + " | market_watch=" + (has_market_watch ? "yes" : "no")
           + " | shortlist_found=" + (shortlist_found ? "yes" : "no")
           + " | shortlist_ranked=" + (shortlist_ranked ? "yes" : "no")
           + " | deep_completed=" + (deep_completed ? "yes" : "no")
           + " | explicit_selected_path=" + (explicit_selected_symbol_path ? "yes" : "no")
           + " | explicit_global_top10_path=" + (explicit_global_top10_path ? "yes" : "no") + "\n";
   line += "  - Hydration Boundary: file size is diagnostic only; this class is derived from owner-state availability, not payload size.\n\n";
   return line;
  }

void ASC_DossierRequiredTokens(const ASC_DossierProductMode dossier_mode,
                               const bool include_l3_section,
                               const bool include_l4_section,
                               const bool include_l5_section,
                               string &required_tokens[])
  {
   if(dossier_mode == ASC_DOSSIER_MODE_CLOSED_MARKET)
     {
      ASC_DossierClosedCanonicalRequiredTokens(required_tokens);
      int closed_next = ArraySize(required_tokens);
      ArrayResize(required_tokens, closed_next + 3);
      required_tokens[closed_next] = "Hydration Class:";
      required_tokens[closed_next + 1] = "Hydration Reason:";
      required_tokens[closed_next + 2] = "Hydration Boundary:";
      return;
     }

   ArrayResize(required_tokens, 15);
   required_tokens[0] = "Publication Id:";
   required_tokens[1] = "Publication UTC:";
   required_tokens[2] = "AURORA SENTINEL SCANNER — SYMBOL DOSSIER";
   required_tokens[3] = "OPERATOR SNAPSHOT";
   required_tokens[4] = "PUBLICATION HEALTH";
   required_tokens[5] = "SYMBOL IDENTITY [L0]";
   required_tokens[6] = "MARKET STATE [L1]";
   required_tokens[7] = "MARKET WATCH [L2]";
   required_tokens[8] = "TRADING CONDITIONS & CONTRACT [L2]";
   required_tokens[9] = "SESSIONS, SWAP & MARGIN [L2]";
   required_tokens[10] = "Surface Truth:";
   required_tokens[11] = "Surface Provenance:";
   required_tokens[12] = "Hydration Class:";
   required_tokens[13] = "Hydration Reason:";
   required_tokens[14] = "Hydration Boundary:";

   if(include_l3_section)
     {
      int next = ArraySize(required_tokens);
      ArrayResize(required_tokens, next + 1);
      required_tokens[next] = "CANDIDATE FILTERING [L3]";
     }

   if(include_l4_section)
     {
      int next = ArraySize(required_tokens);
      ArrayResize(required_tokens, next + 1);
      required_tokens[next] = "SHORTLIST SELECTION [L4]";
     }

   if(include_l5_section)
     {
      int next = ArraySize(required_tokens);
      ArrayResize(required_tokens, next + 1);
      required_tokens[next] = "DEEP SELECTIVE ANALYSIS [L5]";
     }
  }


bool ASC_DossierPayloadPassesMinimumIntegrity(const string payload,
                                              const ASC_DossierProductMode dossier_mode)
  {
   int minimum_payload_chars = (dossier_mode == ASC_DOSSIER_MODE_CLOSED_MARKET) ? 2500 : 5000;
   if(StringLen(payload) < minimum_payload_chars)
      return false;

   if(StringFind(payload, "OPERATOR SNAPSHOT") >= 0)
     {
      string analyst_conclusion = ASC_TextExtractLabeledLineValue(payload, "Analyst Conclusion:");
      string selection_reason = ASC_TextExtractLabeledLineValue(payload, "Selection Reason:");
      string main_caution = ASC_TextExtractLabeledLineValue(payload, "Main Caution:");
      if(StringLen(analyst_conclusion) <= 0 || StringLen(selection_reason) <= 0 || StringLen(main_caution) <= 0)
         return false;
      if(analyst_conclusion == selection_reason
         || analyst_conclusion == main_caution
         || selection_reason == main_caution)
         return false;
     }

   if(StringFind(payload, "TRADING CONDITIONS & CONTRACT [L2]") >= 0)
     {
      if(StringFind(payload, "Raw Broker Specification (Exact Platform Fields)") < 0)
         return false;
      if(StringFind(payload, "Interpretation: none (raw field fidelity)") < 0)
         return false;
     }

   if(StringFind(payload, "SESSIONS, SWAP & MARGIN [L2]") >= 0
      && StringFind(payload, "commission_symbol_spec=") < 0)
      return false;

   return true;
  }

string ASC_DossierHeaderLastSuccessfulPublish(const string server_root,
                                              const string canonical_symbol,
                                              const string publication_state,
                                              const ASC_PublicationBundleState &bundle,
                                              const datetime generated_utc)
  {
   datetime current_publish_utc = bundle.publication_utc;
   if(current_publish_utc <= 0)
      current_publish_utc = generated_utc;

   if(publication_state != "continuity")
      return ASC_ArtifactFormatUtc(current_publish_utc);

   if(StringLen(server_root) > 0 && StringLen(canonical_symbol) > 0)
     {
      ASC_ArtifactContract contract = ASC_DossierContract(server_root, canonical_symbol);
      string existing_payload = "";
      if(ASC_ReadTextFile(contract.target_path, existing_payload) && StringLen(existing_payload) > 0)
        {
         string prior_publication_utc = ASC_TextExtractLabeledLineValue(existing_payload, "Publication UTC:");
         if(StringLen(prior_publication_utc) > 0)
            return prior_publication_utc;

         string prior_success = ASC_TextExtractLabeledLineValue(existing_payload, "Last Successful Publish:");
         if(StringLen(prior_success) > 0)
            return prior_success;
        }
     }

   return ASC_ArtifactFormatUtc(current_publish_utc);
  }

string ASC_DossierHeaderStateRevision(const ASC_Layer1SymbolState &symbol_state,
                                      const bool has_packet,
                                      const ASC_Layer2Packet &packet)
  {
   ulong l1_revision = ASC_Layer1StructuralRevision();
   ulong l2_revision = (has_packet ? packet.revision : 0);
   return StringFormat("L1 %I64u | L2 %I64u | observed %s",
                       (ulong)l1_revision,
                       (ulong)l2_revision,
                       ASC_ArtifactFormatUtc(symbol_state.observed_at_utc));
  }

string ASC_DossierHeaderContinuityStatus(const string publication_state,
                                         const bool has_packet,
                                         const ASC_Layer2Packet &packet)
  {
   if(publication_state == "degraded")
      return "Degraded";
   if(publication_state == "stale")
      return "Stale";
   if(has_packet && packet.continuity_backed)
      return "Retained (Continuity-backed)";
   return "Fresh";
  }

bool ASC_DossierRuntimeContextIsGlobalTop10Child(const string runtime_selected_symbol_context)
  {
   return (StringLen(runtime_selected_symbol_context) > 0
           && StringFind(runtime_selected_symbol_context, "global_top10_batch:") == 0);
  }

string ASC_DossierHeaderSchemaVersion(const string runtime_selected_symbol_context)
  {
   if(ASC_DossierRuntimeContextIsGlobalTop10Child(runtime_selected_symbol_context))
      return "global_top10_child_operator_schema_v1";
   return "current_focus_operator_schema_v1";
  }

string ASC_DossierHeaderSelectedSymbolStatus(const ASC_Layer1SymbolState &symbol_state,
                                             const string canonical_symbol,
                                             const string runtime_selected_symbol_context)
  {
   if(ASC_DossierRuntimeContextIsGlobalTop10Child(runtime_selected_symbol_context))
      return "Global Top 10 Child";

   if(StringLen(runtime_selected_symbol_context) <= 0)
      return "Current Selected Symbol";

   if(ASC_DeepSymbolMatchesContext(symbol_state, runtime_selected_symbol_context))
      return "Current Selected Symbol";

   if(StringLen(runtime_selected_symbol_context) > 0
      && StringLen(canonical_symbol) > 0
      && runtime_selected_symbol_context == canonical_symbol)
      return "Current Selected Symbol";

   return "Not Selected";
  }

string ASC_DossierHeaderDeepAnalysisStatus(const string deep_status_line)
  {
   if(StringFind(deep_status_line, "Completed in this publish") == 0)
      return "Completed in this publish";
   if(StringFind(deep_status_line, "Last confirmed deep analysis is preserved") == 0)
      return "Last confirmed deep analysis is preserved";
   if(StringFind(deep_status_line, "Completed deep analysis is available") == 0)
      return "Completed deep analysis is available";
   if(StringFind(deep_status_line, "No completed deep analysis is available yet") == 0)
      return "Not yet available";
   return deep_status_line;
  }

#include "top_header/ASC_DossierTopHeaderSection.mqh"
#include "operator_snapshot/ASC_DossierOperatorSnapshotSection.mqh"
#include "publication_integrity/ASC_DossierPublicationIntegritySection.mqh"
#include "symbol_identity/ASC_DossierIdentityCoreSection.mqh"
#include "symbol_identity/ASC_DossierClassificationAuthoritySection.mqh"
#include "symbol_identity/ASC_DossierSymbolMetadataSection.mqh"

#include "market_state/ASC_DossierMarketStateCoreSection.mqh"
#include "market_state/ASC_DossierMarketStateTimingSection.mqh"

#include "market_watch/ASC_DossierQuoteSnapshotSection.mqh"
#include "market_watch/ASC_DossierDayStructureSection.mqh"
#include "market_watch/ASC_DossierVolatilityFrictionSection.mqh"

#include "trading_conditions_contract_specs/ASC_DossierPriceContractSection.mqh"
#include "trading_conditions_contract_specs/ASC_DossierTradingPermissionsSection.mqh"
#include "trading_conditions_contract_specs/ASC_DossierVolumeRulesSection.mqh"

#include "sessions_swap_margin/ASC_DossierSessionsSection.mqh"
#include "sessions_swap_margin/ASC_DossierSwapSection.mqh"
#include "sessions_swap_margin/ASC_DossierMarginSection.mqh"

string ASC_AccountMarginModeText(const long margin_mode)
  {
   if(margin_mode == ACCOUNT_MARGIN_MODE_RETAIL_NETTING)
      return "Retail Netting";
   if(margin_mode == ACCOUNT_MARGIN_MODE_EXCHANGE)
      return "Exchange";
   if(margin_mode == ACCOUNT_MARGIN_MODE_RETAIL_HEDGING)
      return "Retail Hedging";
   return "unavailable";
  }

string ASC_DossierSpreadTypeText(const ASC_SymbolSpecification &spec)
  {
   if(!spec.has_spread_float_mode)
      return "unavailable";
   return (spec.spread_float_mode != 0) ? "floating" : "fixed";
  }

string ASC_DossierFillingModeText(const ASC_SymbolSpecification &spec)
  {
   if(!spec.has_filling_mode)
      return "unavailable";

   bool has_fok = ((spec.filling_mode & ORDER_FILLING_FOK) == ORDER_FILLING_FOK);
   bool has_ioc = ((spec.filling_mode & ORDER_FILLING_IOC) == ORDER_FILLING_IOC);
   bool has_return = ((spec.filling_mode & ORDER_FILLING_RETURN) == ORDER_FILLING_RETURN);
   if(has_fok && has_ioc && has_return)
      return "ALL (FOK, IOC, RETURN)";

   string parts = "";
   if(has_fok)
      parts += "FOK, ";
   if(has_ioc)
      parts += "IOC, ";
   if(has_return)
      parts += "RETURN, ";

   if(StringLen(parts) <= 0)
      return "unavailable";

   return StringSubstr(parts, 0, StringLen(parts) - 2);
  }

string ASC_DossierExpirationModeText(const ASC_SymbolSpecification &spec)
  {
   if(!spec.has_expiration_mode)
      return "unavailable";

   bool has_gtc = ((spec.expiration_mode & SYMBOL_EXPIRATION_GTC) == SYMBOL_EXPIRATION_GTC);
   bool has_day = ((spec.expiration_mode & SYMBOL_EXPIRATION_DAY) == SYMBOL_EXPIRATION_DAY);
   bool has_specified = ((spec.expiration_mode & SYMBOL_EXPIRATION_SPECIFIED) == SYMBOL_EXPIRATION_SPECIFIED);
   bool has_specified_day = ((spec.expiration_mode & SYMBOL_EXPIRATION_SPECIFIED_DAY) == SYMBOL_EXPIRATION_SPECIFIED_DAY);
   if(has_gtc && has_day && has_specified && has_specified_day)
      return "ALL (GTC, DAY, SPECIFIED, SPECIFIED_DAY)";

   string parts = "";
   if(has_gtc)
      parts += "GTC, ";
   if(has_day)
      parts += "DAY, ";
   if(has_specified)
      parts += "SPECIFIED, ";
   if(has_specified_day)
      parts += "SPECIFIED_DAY, ";

   if(StringLen(parts) <= 0)
      return "unavailable";

   return StringSubstr(parts, 0, StringLen(parts) - 2);
  }

string ASC_DossierOrderModeText(const ASC_SymbolSpecification &spec)
  {
   if(!spec.has_order_mode)
      return "unavailable";

   bool has_market = ((spec.order_mode & SYMBOL_ORDER_MARKET) == SYMBOL_ORDER_MARKET);
   bool has_limit = ((spec.order_mode & SYMBOL_ORDER_LIMIT) == SYMBOL_ORDER_LIMIT);
   bool has_stop = ((spec.order_mode & SYMBOL_ORDER_STOP) == SYMBOL_ORDER_STOP);
   bool has_stop_limit = ((spec.order_mode & SYMBOL_ORDER_STOP_LIMIT) == SYMBOL_ORDER_STOP_LIMIT);
   bool has_sl = ((spec.order_mode & SYMBOL_ORDER_SL) == SYMBOL_ORDER_SL);
   bool has_tp = ((spec.order_mode & SYMBOL_ORDER_TP) == SYMBOL_ORDER_TP);
   bool has_closeby = ((spec.order_mode & SYMBOL_ORDER_CLOSEBY) == SYMBOL_ORDER_CLOSEBY);
   if(has_market && has_limit && has_stop && has_stop_limit && has_sl && has_tp && has_closeby)
      return "ALL (MARKET, LIMIT, STOP, STOP_LIMIT, SL, TP, CLOSEBY)";

   string parts = "";
   if(has_market)
      parts += "MARKET, ";
   if(has_limit)
      parts += "LIMIT, ";
   if(has_stop)
      parts += "STOP, ";
   if(has_stop_limit)
      parts += "STOP_LIMIT, ";
   if(has_sl)
      parts += "SL, ";
   if(has_tp)
      parts += "TP, ";
   if(has_closeby)
      parts += "CLOSEBY, ";

   if(StringLen(parts) <= 0)
      return "unavailable";

   return StringSubstr(parts, 0, StringLen(parts) - 2);
  }

string ASC_DossierGtcModeText(const string symbol)
  {
   long gtc_mode = 0;
   if(!SymbolInfoInteger(symbol, SYMBOL_ORDER_GTC_MODE, gtc_mode))
      return "unavailable";
   return ASC_SymbolSpecHumanizeEnum(EnumToString((ENUM_SYMBOL_ORDER_GTC_MODE)gtc_mode));
  }

string ASC_DossierSpecValidationStatus(const bool has_packet,
                                       const ASC_Layer2Packet &packet,
                                       const bool has_spec_snapshot,
                                       const ASC_SymbolSpecification &spec_snapshot)
  {
   if(has_packet)
      return ASC_L2SpecificationFreshnessToOperatorText(packet);
   if(!has_spec_snapshot || spec_snapshot.last_refreshed_utc <= 0)
      return "Unavailable";

   int age_sec = (int)MathMax(0, TimeGMT() - spec_snapshot.last_refreshed_utc);
   if(age_sec > ASC_L2_SPEC_DEGRADED_AGE_SEC)
      return "Degraded";
   if(age_sec > ASC_L2_SPEC_STALE_AGE_SEC)
      return "Stale";
   return "Fresh";
  }

string ASC_DossierPermissionStatusText(const bool has_trade_mode,
                                       const long trade_mode)
  {
   if(!has_trade_mode)
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
   return "unavailable";
  }

string ASC_DossierCandidateFilterStateText(const ASC_SelectionFilterEvaluation &filter)
  {
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      return "Score-ready";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      return "Filtered out";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      return "Pending evidence";
   return ASC_TextOrUnavailable(filter.result_state_operator_text);
  }

#include "candidate_filtering/ASC_DossierGateStatusSection.mqh"
#include "candidate_filtering/ASC_DossierBlockersDependenciesSection.mqh"
#include "candidate_filtering/ASC_DossierSortingInputsSection.mqh"

#include "shortlist_selection/ASC_DossierShortlistCoreSection.mqh"
#include "shortlist_selection/ASC_DossierStabilityHoldSection.mqh"
#include "shortlist_selection/ASC_DossierCorrelationExposureSection.mqh"

string ASC_DossierGateInputBinaryText(const bool passed,const bool uses_pending)
  {
   if(passed)
      return "Ready";
   return uses_pending ? "Watching" : "Unavailable";
  }


#include "trader_context/ASC_DossierTraderContextSection.mqh"
#include "recent_change_trace/ASC_DossierRecentChangeTraceSection.mqh"

void ASC_BuildDossierOperatorSnapshot(const ASC_Layer1SymbolState &symbol_state,
                                      const ASC_DossierProductMode dossier_mode,
                                      const bool deep_completed,
                                      const bool explicit_selected_symbol_path,
                                      const bool has_market_watch,
                                      const bool has_packet,
                                      const ASC_Layer2Packet &packet,
                                      const ASC_SelectionFilterEvaluation &filter,
                                      const bool shortlist_ranked,
                                      const int shortlist_rank,
                                      const string market_state_truth,
                                      const string snapshot_truth,
                                      const string shortlist_truth,
                                      string &primary_read_out,
                                      string &primary_risk_out,
                                      string &primary_opportunity_out,
                                      string &primary_constraint_out,
                                      string &primary_next_check_out,
                                      string &one_line_summary_out)
  {
   primary_read_out = market_state_truth;
   if(has_market_watch)
      primary_read_out = snapshot_truth;

   primary_risk_out = (dossier_mode == ASC_DOSSIER_MODE_CLOSED_MARKET)
                      ? "Session is currently closed"
                      : "No dominant risk is elevated from current Layer-0 to Layer-4 truth";
   if(symbol_state.is_degraded)
      primary_risk_out = "Market status is degraded";
   else if(symbol_state.is_stale)
      primary_risk_out = "Market status is stale";
   else if(!symbol_state.classification.resolved)
      primary_risk_out = "Classification remains unresolved";
   else if(!has_packet)
      primary_risk_out = "Open-symbol snapshot is unavailable";
   else if(packet.continuity_backed)
      primary_risk_out = "Market watch is continuity-backed";
   else if(filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      primary_risk_out = "Layer-3 score context is weak";

   primary_opportunity_out = (dossier_mode == ASC_DOSSIER_MODE_CLOSED_MARKET)
                             ? "Monitor next scheduled market-state recheck"
                             : ((deep_completed && explicit_selected_symbol_path)
                                ? "Explicit selected-symbol deep packet is completed for this symbol; " + ASC_DossierBoardAuthorityBoundaryLine(explicit_selected_symbol_path, deep_completed)
                                : ((deep_completed && !explicit_selected_symbol_path)
                                   ? "Explicit selected-symbol deep packet is available separately; " + ASC_DossierBoardAuthorityBoundaryLine(explicit_selected_symbol_path, deep_completed)
                                   : "Awaiting next shortlist authority refresh"));
   if(dossier_mode != ASC_DOSSIER_MODE_CLOSED_MARKET && shortlist_ranked && shortlist_rank <= 3)
      primary_opportunity_out = "Diversified overall-board promotion is active";
   else if(dossier_mode != ASC_DOSSIER_MODE_CLOSED_MARKET && shortlist_ranked)
      primary_opportunity_out = "Diversified overall-board membership is active";
   else if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      primary_opportunity_out = "Score-ready reserve candidate awaiting Layer-4 selection; ordinary board authority still waits on the Market Board";
   else if(has_market_watch && !packet.continuity_backed)
      primary_opportunity_out = "Live market-watch snapshot is available";

   primary_constraint_out = (dossier_mode == ASC_DOSSIER_MODE_CLOSED_MARKET)
                            ? "Closed session; live-entry confirmation is deferred"
                            : "Awaiting ranking / corroboration";
   if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PENDING)
      primary_constraint_out = ASC_TextOrUnavailable(filter.reason_summary);
   else if(filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      primary_constraint_out = ASC_TextOrUnavailable(filter.disqualifiers);
   else if(dossier_mode != ASC_DOSSIER_MODE_CLOSED_MARKET && !shortlist_ranked)
      primary_constraint_out = "Symbol is outside the current diversified overall board; " + ASC_DossierBoardAuthorityBoundaryLine(explicit_selected_symbol_path, deep_completed);
   else if(!has_market_watch)
      primary_constraint_out = "Market-watch snapshot is missing";

   primary_next_check_out = ASC_TextOrUnavailable(filter.next_required_step);
   if(StringLen(primary_next_check_out) <= 0 || primary_next_check_out == "unavailable")
      primary_next_check_out = ASC_L1DueReasonToOperatorText(symbol_state.next_due_reason);

   one_line_summary_out = StringFormat("Read: %s | Opportunity: %s | Constraint: %s | Next: %s",
                                       primary_read_out,
                                       primary_opportunity_out,
                                       primary_constraint_out,
                                       primary_next_check_out);
  }

void ASC_BuildDossierPublicationIntegrity(const string server_root,
                                          const string canonical_symbol,
                                          const ASC_DossierProductMode dossier_mode,
                                          const bool deep_completed,
                                          const bool explicit_selected_symbol_path,
                                          const string publication_state,
                                          const ASC_PublicationBundleState &bundle,
                                          const ASC_Layer1SymbolState &symbol_state,
                                          const bool has_packet,
                                          const bool has_market_watch,
                                          const ASC_Layer2Packet &packet,
                                          const ASC_SelectionFilterEvaluation &filter,
                                          const bool shortlist_ranked,
                                          const string deep_status_line,
                                          const datetime generated_utc,
                                          string &publication_status_out,
                                          string &last_published_out,
                                          string &last_good_fallback_out,
                                          string &current_bundle_status_out,
                                          string &continuity_mode_out,
                                          string &missing_delayed_areas_out,
                                          string &integrity_notes_out)
  {
   publication_status_out = ASC_ArtifactHumanizeLabel(publication_state);
   if(publication_state == "fresh")
      publication_status_out = "Current publish landed";
   else if(publication_state == "stale")
      publication_status_out = "Current publish delayed";
   else if(publication_state == "degraded")
      publication_status_out = "Current publish degraded";
   else if(publication_state == "continuity")
      publication_status_out = "Retained last-good publish";

   last_published_out = ASC_ArtifactFormatUtc(generated_utc);
   if(bundle.publication_utc > 0)
      last_published_out = ASC_ArtifactFormatUtc(bundle.publication_utc);

   continuity_mode_out = "Live current publish";
   if(publication_state == "degraded")
      continuity_mode_out = "Current publish degraded";
   else if(publication_state == "stale")
      continuity_mode_out = "Current publish delayed";
   else if(has_packet && packet.continuity_backed)
      continuity_mode_out = "Retained last-good support";
   else if(bundle.overall_bundle_status == "continuity" || publication_state == "continuity")
      continuity_mode_out = "Retained last-good support";

   string bundle_family_status = "Pending";
   if(StringLen(bundle.overall_bundle_status) > 0)
      bundle_family_status = ASC_ArtifactHumanizeLabel(bundle.overall_bundle_status);
   if(bundle.dossier_failure_count > 0)
      bundle_family_status = "Partial (Dossier Failures Present)";
   else if(bundle.dossier_attempted_count > 0 && bundle.dossier_success_count == bundle.dossier_attempted_count)
      bundle_family_status = "Complete (No Dossier Failures)";

   string board_baseline_status = ASC_DossierBoardBaselineStatusLine(bundle);
   current_bundle_status_out = explicit_selected_symbol_path
                               ? ("Selected-symbol child follows Board baseline contract | " + board_baseline_status + " | " + bundle_family_status)
                               : ("Dossier family readback follows Board baseline contract | " + board_baseline_status + " | " + bundle_family_status);
   if(deep_completed)
      current_bundle_status_out += " | explicit deep support active";

   last_good_fallback_out = "No retained last-good fallback active";
   if(StringFind(continuity_mode_out, "Retained last-good") >= 0 || publication_status_out == "Current publish degraded")
     {
      string existing_payload = "";
      ASC_ArtifactContract contract = ASC_DossierContract(server_root, canonical_symbol);
      if(ASC_ReadTextFile(contract.target_path, existing_payload) && StringLen(existing_payload) > 0)
        {
         string fallback_utc = ASC_TextExtractLabeledLineValue(existing_payload, "Publication UTC:");
         if(StringLen(fallback_utc) > 0)
            last_good_fallback_out = "Retained last-good dossier from " + fallback_utc + " while the current publish/support catches up";
         else
            last_good_fallback_out = "Retained last-good dossier is active while the current publish/support catches up";
        }
      else
        {
         last_good_fallback_out = "Retained last-good posture is active but the prior dossier timestamp is unavailable";
        }
     }

   string delayed = "";
   if(!symbol_state.classification.resolved)
      delayed = "classification unresolved";
   if(!has_market_watch)
      delayed = (StringLen(delayed) > 0) ? delayed + "; market watch unavailable" : "market watch unavailable";
   if(dossier_mode != ASC_DOSSIER_MODE_CLOSED_MARKET)
     {
      if(filter.result_state != ASC_SELECTION_FILTER_RESULT_PASS)
         delayed = (StringLen(delayed) > 0) ? delayed + "; Layer-3 candidate evidence not yet score-ready" : "Layer-3 candidate evidence not yet score-ready";
      if(!shortlist_ranked)
         delayed = (StringLen(delayed) > 0) ? delayed + "; outside current Layer-4 shortlist authority" : "outside current Layer-4 shortlist authority";
      if(!deep_completed)
         delayed = (StringLen(delayed) > 0) ? delayed + "; selected-symbol Layer-5 deep analysis not yet published" : "selected-symbol Layer-5 deep analysis not yet published";
     }
   if(StringLen(delayed) <= 0)
      delayed = "none";
   missing_delayed_areas_out = delayed;

   integrity_notes_out = "Current publish landed with no known delayed areas";
   if(publication_status_out == "Current publish degraded" || StringFind(continuity_mode_out, "Retained last-good") >= 0)
      integrity_notes_out = "Retained last-good support is active; delayed score/rank/deep areas may still be catching up";
   else if(publication_status_out == "Current publish delayed")
      integrity_notes_out = "Current publish is delayed; recheck after the next bundle beat";
   else if(StringLen(delayed) > 0 && delayed != "none")
      integrity_notes_out = "Current publish landed with known delayed areas: " + delayed;

   integrity_notes_out += " | " + ASC_DossierSameSymbolRoleLine(explicit_selected_symbol_path, deep_completed);
   integrity_notes_out += " | surface truth " + ASC_ArtifactSurfaceFreshnessBoundaryLine(publication_state, false);
   integrity_notes_out += " | " + ASC_ArtifactSurfaceProvenanceLine();
   integrity_notes_out += " | " + ASC_DossierBundleTimingLine(bundle, generated_utc, explicit_selected_symbol_path);
  }

string ASC_DossierIdentityAssetType(const ASC_SymbolClassification &classification)
  {
   string asset = classification.asset_class;
   StringTrimLeft(asset);
   StringTrimRight(asset);
   StringToUpper(asset);
   if(StringLen(asset) > 0 && asset != "UNKNOWN")
      return ASC_ArtifactHumanizeLabel(asset);

   string main_bucket_id = ASC_ClassificationEffectiveMainBucketId(classification);
   if(main_bucket_id == "fx")
      return "Fx";
   if(main_bucket_id == "indices")
      return "Index";
   if(main_bucket_id == "metals")
      return "Metals";
   if(main_bucket_id == "energy")
      return "Energy";
   if(main_bucket_id == "crypto")
      return "Crypto";
   if(main_bucket_id == "stocks")
      return "Stock";
   return "Unresolved";
  }

string ASC_DossierIdentityInstrumentFamily(const ASC_SymbolClassification &classification)
  {
   string family = classification.main_bucket_name;
   StringTrimLeft(family);
   StringTrimRight(family);
   if(StringLen(family) > 0 && ASC_TrimUpper(family) != "UNKNOWN")
      return ASC_ArtifactHumanizeLabel(family);

   family = ASC_MainBucketOperatorNameFromId(ASC_ClassificationEffectiveMainBucketId(classification));
   if(family != "Unknown / Needs Review")
      return ASC_ArtifactHumanizeLabel(family);
   return "Unresolved";
  }

void ASC_BuildDossierIdentityCore(const ASC_Layer1SymbolState &symbol_state,
                                  const string canonical_symbol,
                                  string &symbol_out,
                                  string &display_name_out,
                                  string &broker_symbol_out,
                                  string &asset_type_out,
                                  string &instrument_family_out,
                                  string &calculation_type_out,
                                  string &chart_mode_out)
  {
   symbol_out = ASC_TextOrUnavailable(canonical_symbol);
   broker_symbol_out = ASC_TextOrUnavailable(symbol_state.identity.raw_symbol);
   if(broker_symbol_out == "unavailable")
      broker_symbol_out = ASC_TextOrUnavailable(symbol_state.symbol);

   display_name_out = "";
   if(!SymbolInfoString(symbol_state.symbol, SYMBOL_DESCRIPTION, display_name_out) || StringLen(display_name_out) <= 0)
      display_name_out = broker_symbol_out;
   display_name_out = ASC_TextOrUnavailable(display_name_out);

   asset_type_out = ASC_DossierIdentityAssetType(symbol_state.classification);
   instrument_family_out = ASC_DossierIdentityInstrumentFamily(symbol_state.classification);

   ASC_SymbolSpecification spec;
   ASC_SymbolSpecificationRead(symbol_state.symbol, spec);
   calculation_type_out = spec.has_calculation_mode
                          ? ASC_SymbolSpecificationCalcModeText(spec.calculation_mode)
                          : "Unavailable";
   chart_mode_out = spec.has_chart_mode
                    ? ASC_SymbolSpecHumanizeEnum(EnumToString((ENUM_SYMBOL_CHART_MODE)spec.chart_mode))
                    : "Unavailable";
  }

void ASC_BuildDossierClassificationAuthority(const ASC_Layer1SymbolState &symbol_state,
                                             const ASC_BrokerDescriptors &broker_descriptors,
                                             string &advanced_status_out,
                                             string &advanced_main_bucket_out,
                                             string &advanced_sub_group_out,
                                             string &advanced_asset_class_out,
                                             string &advanced_source_out,
                                             string &advanced_confidence_out,
                                             string &broker_main_bucket_out,
                                             string &broker_sector_out,
                                             string &broker_industry_out,
                                             string &broker_exchange_out,
                                             string &broker_country_out,
                                             string &broker_notes_out,
                                             string &resolved_main_bucket_out,
                                             string &resolved_sub_group_out,
                                             string &resolved_asset_class_out,
                                             string &resolution_rule_out,
                                             string &conflict_status_out,
                                             string &classification_notes_out)
  {
   advanced_status_out = symbol_state.classification.resolved ? "Resolved" : "Unresolved";
   string effective_main_bucket_id = ASC_ClassificationEffectiveMainBucketId(symbol_state.classification);
   advanced_main_bucket_out = ASC_DossierIdentityInstrumentFamily(symbol_state.classification);
   advanced_sub_group_out = ASC_ArtifactHumanizeLabel(ASC_ClassificationEffectiveSubBucketName(symbol_state.classification));
   if(StringLen(advanced_sub_group_out) <= 0 || advanced_sub_group_out == "Unresolved")
      advanced_sub_group_out = "Unassigned";
   advanced_asset_class_out = ASC_TextOrUnavailable(symbol_state.classification.asset_class);
   advanced_source_out = ASC_ClassificationAuthoritySource(symbol_state.classification);
   advanced_confidence_out = ASC_ArtifactHumanizeLabel(symbol_state.classification.confidence);

   broker_sector_out = broker_descriptors.has_sector ? broker_descriptors.sector : "unavailable";
   broker_industry_out = broker_descriptors.has_industry ? broker_descriptors.industry : "unavailable";
   broker_main_bucket_out = (broker_descriptors.has_sector || broker_descriptors.has_industry)
                            ? ASC_BrokerDescriptorsCompactText(broker_descriptors)
                            : "unavailable";
   broker_exchange_out = "unavailable";
   SymbolInfoString(symbol_state.symbol, SYMBOL_EXCHANGE, broker_exchange_out);
   broker_exchange_out = ASC_TextOrUnavailable(broker_exchange_out);
   broker_country_out = "unavailable";
   broker_notes_out = broker_descriptors.has_sector || broker_descriptors.has_industry || broker_descriptors.has_isin
                      ? "Broker metadata is supporting evidence only"
                      : "Broker classification metadata is sparse";

   resolved_main_bucket_out = advanced_main_bucket_out;
   resolved_sub_group_out = advanced_sub_group_out;
   resolved_asset_class_out = advanced_asset_class_out;
   resolution_rule_out = symbol_state.classification.resolved
                         ? "Advanced classification is authoritative; broker metadata is supporting only"
                         : "Advanced classification is unresolved; broker metadata remains supporting context";

   conflict_status_out = "Aligned";
   if(!symbol_state.classification.resolved)
      conflict_status_out = "Advanced Unresolved";
   else if(!broker_descriptors.has_sector && !broker_descriptors.has_industry)
      conflict_status_out = "Broker Incomplete";
   else if(effective_main_bucket_id == "unknown")
      conflict_status_out = "Needs Review";

   classification_notes_out = ASC_TextOrUnavailable(symbol_state.classification.notes);
   if(conflict_status_out == "Broker Incomplete")
      classification_notes_out = "Advanced classification is resolved; broker metadata remains incomplete.";
   else if(conflict_status_out == "Advanced Unresolved")
      classification_notes_out = "Advanced classification unresolved; awaiting authoritative row match.";
   else if(effective_main_bucket_id == "stocks")
      classification_notes_out = classification_notes_out
                                 + " | Hierarchy L1/L2/L3: "
                                 + ASC_TextOrUnavailable(symbol_state.classification.hierarchy_l1_name)
                                 + " / "
                                 + ASC_TextOrUnavailable(symbol_state.classification.hierarchy_l2_name)
                                 + " / "
                                 + ASC_TextOrUnavailable(symbol_state.classification.hierarchy_l3_name);
  }

void ASC_BuildDossierSymbolMetadata(const ASC_Layer1SymbolState &symbol_state,
                                    const ASC_BrokerDescriptors &broker_descriptors,
                                    string &exchange_out,
                                    string &sector_out,
                                    string &industry_out,
                                    string &country_out,
                                    string &isin_out,
                                    string &base_currency_out,
                                    string &quote_currency_out,
                                    string &margin_currency_out,
                                    string &digits_out,
                                    string &point_out,
                                    string &contract_profile_summary_out)
  {
   exchange_out = "unavailable";
   SymbolInfoString(symbol_state.symbol, SYMBOL_EXCHANGE, exchange_out);
   exchange_out = ASC_TextOrUnavailable(exchange_out);

   sector_out = broker_descriptors.has_sector ? broker_descriptors.sector : "unavailable";
   industry_out = broker_descriptors.has_industry ? broker_descriptors.industry : "unavailable";
   isin_out = broker_descriptors.has_isin ? broker_descriptors.isin : "unavailable";

   country_out = "unavailable";

   ASC_SymbolSpecification spec;
   ASC_SymbolSpecificationRead(symbol_state.symbol, spec);

   string base_currency = "";
   if(!SymbolInfoString(symbol_state.symbol, SYMBOL_CURRENCY_BASE, base_currency))
      base_currency = "";
   base_currency_out = ASC_TextOrUnavailable(base_currency);

   quote_currency_out = spec.has_profit_currency ? spec.profit_currency : "unavailable";
   margin_currency_out = spec.has_margin_currency ? spec.margin_currency : "unavailable";
   digits_out = ASC_SymbolSpecificationIntegerText(spec.has_digits, spec.digits);
   point_out = ASC_SymbolSpecificationValueText(spec.has_point, spec.point, 8);

   string profile_parts = "";
   string asset_type = ASC_DossierIdentityAssetType(symbol_state.classification);
   string family = ASC_DossierIdentityInstrumentFamily(symbol_state.classification);
   profile_parts = asset_type + " | " + family;
   profile_parts += " | " + base_currency_out + "/" + quote_currency_out;
   profile_parts += " | margin " + margin_currency_out;
   profile_parts += " | venue " + exchange_out;
   profile_parts += " | digits " + digits_out;
   profile_parts += " | point " + point_out;
   contract_profile_summary_out = profile_parts;
  }

bool ASC_BuildCanonicalDossierPayload(const string server_root,
                                      const ASC_Layer1SymbolState &symbol_state,
                                      const ASC_PublicationBundleState &bundle,
                                      const ASC_ShortlistSymbolSummary &shortlist_rows[],
                                      const ASC_DossierProductMode dossier_mode,
                                      const bool has_deep_result,
                                      const ASC_DeepSelectiveAnalysisResult &deep_result,
                                      const string runtime_selected_symbol_context,
                                      string &canonical_symbol_out,
                                      string &payload_out,
                                      string &publication_state_out,
                                      string &required_tokens[])
  {
   canonical_symbol_out = symbol_state.classification.canonical_symbol;
   if(StringLen(canonical_symbol_out) <= 0)
      canonical_symbol_out = symbol_state.identity.canonical_symbol;
   if(StringLen(canonical_symbol_out) <= 0)
      canonical_symbol_out = symbol_state.identity.normalized_symbol;
   if(StringLen(canonical_symbol_out) <= 0)
      canonical_symbol_out = symbol_state.symbol;

   datetime generated_utc = (bundle.publication_utc > 0 ? bundle.publication_utc : TimeGMT());

   ASC_Layer2Packet packet;
   bool has_packet = ASC_Layer2TryGetPacketBySymbol(symbol_state.symbol, packet) && (packet.admitted || packet.tactical_only);
   bool has_market_watch = has_packet && ASC_L2PacketHasLawfulSnapshot(packet);
   bool has_day_range = has_packet && ASC_L2PacketHasLawfulDayRange(packet);
   bool atr_ready = has_packet && ASC_SummaryAtrReady(packet);

   ASC_SelectionFilterEvaluation filter;
   ASC_SelectionFilterInitFallbackPending(filter,
                                          "shortlist-owner filter snapshot unavailable",
                                          "shortlist_owner_unavailable",
                                          "selection filter details are waiting for runtime shortlist publication");

   ASC_ShortlistSymbolSummary shortlist_entry;
   int shortlist_rank = 0;
   int shortlist_total = 0;
   bool shortlist_found = ASC_ShortlistFindSymbolSummary(shortlist_rows,
                                                         symbol_state.symbol,
                                                         shortlist_entry,
                                                         shortlist_rank,
                                                         shortlist_total);
   if(shortlist_found)
      filter = shortlist_entry.filter;
   bool shortlist_ranked = (shortlist_found && ASC_ShortlistHasLawfulMembership(shortlist_entry));
   bool explicit_selected_symbol_path = (dossier_mode == ASC_DOSSIER_MODE_DEEP_OVERRIDE);
   bool explicit_global_top10_path = (StringFind(runtime_selected_symbol_context, "global_top10_batch:") == 0);
   bool ordinary_l34_visible = ASC_ConsumerAllowsOrdinaryL34(symbol_state);
   bool include_l3_section = (ordinary_l34_visible || explicit_selected_symbol_path);
   bool include_l4_section = include_l3_section;
   bool include_l5_section = explicit_selected_symbol_path;
   string dossier_shortlist_source_label = explicit_selected_symbol_path ? "committed_l4_rows" : "publication_shortlist_rows";

   ASC_ShortlistCorrelationSummary cor;
   cor.average_score = 0.0;
   cor.high_a_symbol = "n/a";
   cor.high_a_score = 0.0;
   cor.high_b_symbol = "n/a";
   cor.high_b_score = 0.0;
   cor.low_a_symbol = "n/a";
   cor.low_a_score = 0.0;
   cor.low_b_symbol = "n/a";
   cor.low_b_score = 0.0;
   cor.peers_compared = 0;
   cor.peers_packet_ready = 0;
   cor.anchor_packet_ready = false;
   cor.summary_ready = false;
   cor.summary_posture = "pending";
   cor.summary_reason = "awaiting shortlist-owned true-correlation summary";
   if(shortlist_found)
      cor = shortlist_entry.correlation_summary;

   int open_positions = 0;
   int pending_orders = 0;
   ASC_OpenPendingConflictValue(symbol_state.symbol, open_positions, pending_orders);

   publication_state_out = ASC_ArtifactPublicationState(symbol_state.is_degraded, symbol_state.is_stale);
   string group_name = ASC_MainBucketOperatorNameFromId(ASC_ClassificationEffectiveMainBucketId(symbol_state.classification));
   string subgroup_name = ASC_ArtifactHumanizeLabel(ASC_ClassificationEffectiveSubBucketName(symbol_state.classification));

   double spread_abs = 0.0;
   string quote_bid_text = "";
   string quote_ask_text = "";
   string quote_last_text = "";
   string quote_spread_text = "";
   string spread_pct_text = "";
   string packet_age_text = "";
   string quote_freshness = "";
   string quote_last_tick_time_text = "";
   string quote_observed_time_text = "";
   string quote_continuity_status_text = "";
   bool quote_freshness_degraded_or_stale = false;
   string quote_unavailable_owner_text = has_packet ? packet.quote_unavailable_owner : "ASC_OpenSymbolSnapshotEngine";
   string quote_unavailable_reason_text = has_packet ? packet.quote_unavailable_reason : "packet_missing_or_not_admitted";
   string quote_unavailable_next_check_text = has_packet ? ASC_ArtifactFormatUtc(packet.quote_unavailable_next_check_utc) : ASC_ArtifactFormatUtc(0);
   string quote_unavailable_symbol_select_state_text = has_packet ? (packet.quote_unavailable_symbol_select_state ? "true" : "false") : "unknown";
   string quote_unavailable_symbol_sync_state_text = has_packet ? (packet.quote_unavailable_symbol_sync_state ? "true" : "false") : "unknown";
   string quote_unavailable_tick_success_text = has_packet ? (packet.quote_unavailable_tick_success ? "true" : "false") : "false";
   string quote_unavailable_tick_last_error_text = has_packet ? IntegerToString(packet.quote_unavailable_tick_last_error) : "unknown";
   string top5_quote_hydration_source_text = has_packet ? packet.top5_quote_hydration_source : "ASC_OpenSymbolSnapshotEngine/SymbolInfoTick+SymbolInfoDouble";

   ASC_L2BuildMarketWatchQuoteProjection(has_packet,
                                         has_market_watch,
                                         packet,
                                         ((has_packet && packet.digits > 0) ? packet.digits : 5),
                                         spread_abs,
                                         quote_bid_text,
                                         quote_ask_text,
                                         quote_last_text,
                                         quote_spread_text,
                                         spread_pct_text,
                                         packet_age_text,
                                         quote_freshness,
                                         quote_last_tick_time_text,
                                         quote_observed_time_text,
                                         quote_continuity_status_text,
                                         quote_freshness_degraded_or_stale);

   ASC_BrokerDescriptors broker_descriptors;
   ASC_GetBrokerDescriptors(symbol_state.symbol, broker_descriptors);

   string day_open_text = ASC_TimeSeriesValueOrUnavailable(symbol_state.symbol, PERIOD_D1, 0, 0);
   string prev_day_high_text = ASC_TimeSeriesValueOrUnavailable(symbol_state.symbol, PERIOD_D1, 1, 1);
   string prev_day_low_text = ASC_TimeSeriesValueOrUnavailable(symbol_state.symbol, PERIOD_D1, 1, 2);

   ASC_ArtifactAccountSnapshot account_snapshot;
   ASC_BuildAccountSnapshot(account_snapshot);

   string continuity_state = (has_packet && packet.continuity_backed) ? "continuity" : "live";
   datetime market_refreshed_at = has_packet ? packet.last_built_utc : symbol_state.observed_at_utc;

   string selection_state = "Awaiting shortlist context";
   if(shortlist_found)
     {
      string shortlist_band_text = ASC_ArtifactHumanizeLabel(shortlist_entry.shortlist_band);
      if(StringLen(shortlist_band_text) > 0 && shortlist_band_text != "Unavailable")
         selection_state = shortlist_band_text;
      else
         selection_state = ASC_ShortlistMembershipLabel(shortlist_entry);
      if(!shortlist_ranked && shortlist_entry.shortlist_posture == "invalid")
         selection_state = "Shortlist Rebuild Required";
     }
   else if(filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
      selection_state = "Candidate";
   else if(filter.result_state == ASC_SELECTION_FILTER_RESULT_FAIL)
      selection_state = "Filtered Out";

   string selection_bucket = group_name;
   if(StringLen(filter.candidate_bucket) > 0)
      selection_bucket = ASC_CandidateBucketOperatorText(filter.candidate_bucket);
   if(StringLen(subgroup_name) > 0 && subgroup_name != "Unassigned")
      selection_bucket += " / " + subgroup_name;
   else if(StringLen(selection_bucket) <= 0)
      selection_bucket = subgroup_name;

   string deep_section = ASC_ResolveDossierDeepSection(server_root,
                                                       canonical_symbol_out,
                                                       has_deep_result,
                                                       deep_result);

   string l6_review_latest_change = "";
   string l6_review_previous_change = "";
   string l6_review_state_transition = "";
   string l6_review_selection_transition = "";
   string l6_review_deep_transition = "";

   bool deep_completed = ASC_DossierDeepSectionHasCompletedTruth(deep_section);
   if(deep_completed && has_deep_result && deep_result.built && deep_result.lawful)
     {
      string unused_current_focus_summary = "";
      string unused_l6_dossier_band = "";
      ASC_DossierBuildLayer6SurfaceBlocks(server_root,
                                          canonical_symbol_out,
                                          deep_result,
                                          unused_current_focus_summary,
                                          unused_l6_dossier_band,
                                          l6_review_latest_change,
                                          l6_review_previous_change,
                                          l6_review_state_transition,
                                          l6_review_selection_transition,
                                          l6_review_deep_transition);
     }
   bool deep_preserved = (deep_completed && !(has_deep_result && deep_result.built && deep_result.lawful));
   string deep_status_line = ASC_DossierDeepSummaryLine(deep_completed,
                                                        deep_preserved,
                                                        has_deep_result,
                                                        deep_result);
   string deep_packet_summary_line = ASC_DossierDeepPacketSummary(deep_completed,
                                                                  deep_preserved,
                                                                  has_deep_result,
                                                                  deep_result);
   if(dossier_mode == ASC_DOSSIER_MODE_CLOSED_MARKET)
      deep_status_line = "Not applicable in closed-market canonical mode";
   string deep_status_header_text = ASC_DossierHeaderDeepAnalysisStatus(deep_status_line);
   string last_successful_publish = ASC_DossierHeaderLastSuccessfulPublish(server_root,
                                                                            canonical_symbol_out,
                                                                            publication_state_out,
                                                                            bundle,
                                                                            generated_utc);
   string state_revision_text = ASC_DossierHeaderStateRevision(symbol_state, has_packet, packet);
   string continuity_status_text = ASC_DossierHeaderContinuityStatus(publication_state_out, has_packet, packet);
   string selected_symbol_status_text = ASC_DossierHeaderSelectedSymbolStatus(symbol_state,
                                                                               canonical_symbol_out,
                                                                               runtime_selected_symbol_context);
   string freshness_status_text = ASC_DossierFreshnessLabel(symbol_state, has_market_watch, packet);
   ASC_DossierSectionStatus header_status;
   ASC_DossierSectionStatus snapshot_status;
   ASC_DossierSectionStatus publication_integrity_status;
   ASC_DossierSectionStatus identity_core_status;
   ASC_DossierSectionStatus classification_authority_status;
   ASC_DossierSectionStatus symbol_metadata_status;
   ASC_DossierSectionStatus market_state_core_status;
   ASC_DossierSectionStatus market_state_timing_status;
   ASC_DossierSectionStatus market_watch_quote_snapshot_status;
   ASC_DossierSectionStatus market_watch_volatility_friction_status;
   ASC_DossierSectionStatus trading_conditions_price_contract_status;
   ASC_DossierSectionStatus trading_conditions_permissions_status;
   ASC_DossierSectionStatus trading_conditions_volume_rules_status;
   ASC_DossierSectionStatus sessions_status;
   ASC_DossierSectionStatus swap_status;
   ASC_DossierSectionStatus margin_status;
   ASC_DossierSectionStatus candidate_filtering_gate_status;
   ASC_DossierSectionStatus candidate_filtering_blockers_dependencies_status;
   ASC_DossierSectionStatus candidate_filtering_sorting_inputs_status;
   ASC_DossierSectionStatus shortlist_core_status;
   ASC_DossierSectionStatus shortlist_stability_hold_status;
   ASC_DossierSectionStatus shortlist_correlation_exposure_status;
   ASC_DossierSectionStatus recent_change_trace_status;
   string primary_read = "";
   string primary_risk = "";
   string primary_opportunity = "";
   string primary_constraint = "";
   string primary_next_check = "";
   string one_line_summary = "";
   string publication_status_line = "";
   string last_published_line = "";
   string last_good_fallback_line = "";
   string current_bundle_status_line = "";
   string continuity_mode_line = "";
   string missing_delayed_areas_line = "";
   string integrity_notes_line = "";
   string ordinary_l34_guard_reason = ASC_DossierOrdinaryL34GuardReason(symbol_state,
                                                                        has_packet,
                                                                        has_market_watch,
                                                                        packet,
                                                                        shortlist_found,
                                                                        filter,
                                                                        false);
   string ordinary_l4_guard_reason = ASC_DossierOrdinaryL34GuardReason(symbol_state,
                                                                       has_packet,
                                                                       has_market_watch,
                                                                       packet,
                                                                       shortlist_found,
                                                                       filter,
                                                                       true);
   string consumer_market_posture_text = ASC_ConsumerMarketPostureReadback(symbol_state);
   string consumer_visible_ceiling_text = explicit_selected_symbol_path ? "Layer 0-6" : ASC_ConsumerVisibleLayerCeilingReadback(symbol_state);
   string consumer_l34_source_text = explicit_selected_symbol_path
                                     ? (ASC_ConsumerShortlistSourceIdentityReadback(dossier_shortlist_source_label) + " | explicit deep path remains separate")
                                     : ASC_ConsumerL34SourceIdentityReadback(symbol_state, dossier_shortlist_source_label, include_l3_section, explicit_selected_symbol_path);
   string consumer_path_identity_text = ASC_ConsumerPathIdentityReadback(explicit_selected_symbol_path);
   string identity_symbol = "";
   string identity_display_name = "";
   string identity_broker_symbol = "";
   string identity_asset_type = "";
   string identity_instrument_family = "";
   string identity_calculation_type = "";
   string identity_chart_mode = "";
   string advanced_status = "";
   string advanced_main_bucket = "";
   string advanced_sub_group = "";
   string advanced_asset_class = "";
   string advanced_source = "";
   string advanced_confidence = "";
   string broker_main_bucket = "";
   string broker_sector = "";
   string broker_industry = "";
   string broker_exchange = "";
   string broker_country = "";
   string broker_notes = "";
   string resolved_main_bucket = "";
   string resolved_sub_group = "";
   string resolved_asset_class = "";
   string resolution_rule = "";
   string classification_conflict_status = "";
   string classification_notes = "";
   string metadata_exchange = "";
   string metadata_sector = "";
   string metadata_industry = "";
   string metadata_country = "";
   string metadata_isin = "";
   string metadata_base_currency = "";
   string metadata_quote_currency = "";
   string metadata_margin_currency = "";
   string metadata_digits = "";
   string metadata_point = "";
   string metadata_contract_profile_summary = "";

   string market_state_truth = StringFormat("%s | %s | Next %s",
                                            ASC_L1StateToOperatorText(symbol_state.state),
                                            ASC_L1ReasonToOperatorText(symbol_state.reason),
                                            ASC_L1DueReasonToOperatorText(symbol_state.next_due_reason));

   string completion_placeholder = ASC_DossierFreshnessLabel(symbol_state, has_market_watch, packet);
   string completion_placeholder_lower = completion_placeholder;
   StringToLower(completion_placeholder_lower);
   string snapshot_truth = "Quotes " + completion_placeholder_lower;
   if(has_market_watch)
      snapshot_truth = StringFormat("%s | Bid %s | Ask %s | Spread %s",
                                    ASC_L2FreshnessToOperatorText(packet.freshness),
                                    DoubleToString(packet.bid, (packet.digits > 0 ? packet.digits : 5)),
                                    DoubleToString(packet.ask, (packet.digits > 0 ? packet.digits : 5)),
                                    DoubleToString(spread_abs, (packet.digits > 0 ? packet.digits : 5)));
   else if(has_packet && packet.continuity_backed)
      snapshot_truth = "Last confirmed value | continuity-backed open-symbol snapshot";
   else if(symbol_state.state == ASC_L1_CLOSED)
      snapshot_truth = "Unavailable | session is currently closed";

   string candidate_truth = StringFormat("%s | %s",
                                         filter.result_state_operator_text,
                                         ASC_SelectionReasonToOperatorText(filter.reason_code));

   string shortlist_truth = selection_state;
   if(shortlist_ranked)
     {
      shortlist_truth += StringFormat(" | Rank %d of %d | %s",
                                      shortlist_rank,
                                      shortlist_total,
                                      selection_bucket);
     }
   else
     {
      shortlist_truth += StringFormat(" | %s", selection_bucket);
     }
   ASC_BuildDossierOperatorSnapshot(symbol_state,
                                    dossier_mode,
                                    deep_completed,
                                    explicit_selected_symbol_path,
                                    has_market_watch,
                                    has_packet,
                                    packet,
                                    filter,
                                    shortlist_ranked,
                                    shortlist_rank,
                                    market_state_truth,
                                    snapshot_truth,
                                    shortlist_truth,
                                    primary_read,
                                    primary_risk,
                                    primary_opportunity,
                                    primary_constraint,
                                    primary_next_check,
                                    one_line_summary);

   if(shortlist_found)
     {
      string tactical_stack_text = ASC_DossierTacticalStackLine(filter);
      primary_read = StringFormat("%s | %s", shortlist_truth, tactical_stack_text);
      if(explicit_selected_symbol_path)
         primary_opportunity = deep_packet_summary_line + " | " + ASC_DossierBoardAuthorityBoundaryLine(explicit_selected_symbol_path, deep_completed);
      else if(deep_completed)
         primary_opportunity = "Explicit selected-symbol deep packet is available separately; " + ASC_DossierBoardAuthorityBoundaryLine(explicit_selected_symbol_path, deep_completed);

      if(shortlist_entry.shortlisted && shortlist_entry.rank > 0)
        {
         primary_constraint = (shortlist_entry.rank <= 3)
                              ? "Diversified overall-board promotion is already active"
                              : "Diversified overall-board shortlist membership is already active";
         primary_next_check = (shortlist_entry.rank <= 3)
                              ? "Maintain current promoted overall-board posture until the next lawful shortlist refresh"
                              : "Maintain current shortlisted overall-board posture until the next lawful shortlist refresh";
        }
      else if(shortlist_entry.bucket_shortlisted && !shortlist_entry.shortlisted)
        {
         primary_constraint = "Bucket-local strength is confirmed, but the symbol remains reserve-only on the diversified overall board";
         primary_next_check = "Watch for diversified overall-board admission on the next lawful shortlist refresh";
        }
      else if(!shortlist_entry.bucket_shortlisted && shortlist_entry.filter.result_state == ASC_SELECTION_FILTER_RESULT_PASS)
        {
         primary_constraint = "Score context is live, but current Layer-4 status is reserve only outside bucket top-5 and diversified overall-board membership; " + ASC_DossierBoardAuthorityBoundaryLine(explicit_selected_symbol_path, deep_completed);
         primary_next_check = "Await the next lawful shortlist refresh for diversified overall-board admission; keep explicit deep readback in analysis-support role only";
        }
      one_line_summary = explicit_selected_symbol_path
                         ? StringFormat("Selected Symbol: %s | %s | L3: %s | L4: %s | L5: %s",
                                        canonical_symbol_out,
                                        ASC_TextOrUnavailable(selection_bucket),
                                        tactical_stack_text,
                                        ASC_TextOrUnavailable(shortlist_entry.overall_board_reason),
                                        deep_packet_summary_line)
                         : StringFormat("Selected Symbol: %s | %s | L3: %s | L4: %s | L5 separate: %s",
                                        canonical_symbol_out,
                                        ASC_TextOrUnavailable(selection_bucket),
                                        tactical_stack_text,
                                        ASC_TextOrUnavailable(shortlist_entry.overall_board_reason),
                                        deep_completed ? "available on explicit selected-symbol path" : "awaiting explicit completion");
     }
   else if(filter.score_pack_ready)
     {
      string tactical_stack_text = ASC_DossierTacticalStackLine(filter);
      primary_read = StringFormat("%s | %s", shortlist_truth, tactical_stack_text);
      if(explicit_selected_symbol_path)
         primary_opportunity = deep_packet_summary_line + " | " + ASC_DossierBoardAuthorityBoundaryLine(explicit_selected_symbol_path, deep_completed);
      else if(deep_completed)
         primary_opportunity = "Explicit selected-symbol deep packet is available separately; " + ASC_DossierBoardAuthorityBoundaryLine(explicit_selected_symbol_path, deep_completed);
      one_line_summary = explicit_selected_symbol_path
                         ? StringFormat("Selected Symbol: %s | %s | L3: %s | L5: %s",
                                        canonical_symbol_out,
                                        ASC_TextOrUnavailable(selection_bucket),
                                        tactical_stack_text,
                                        deep_packet_summary_line)
                         : StringFormat("Selected Symbol: %s | %s | L3: %s | L5 separate: %s",
                                        canonical_symbol_out,
                                        ASC_TextOrUnavailable(selection_bucket),
                                        tactical_stack_text,
                                        deep_completed ? "available on explicit selected-symbol path" : "awaiting explicit completion");
     }
   ASC_BuildDossierPublicationIntegrity(server_root,
                                        canonical_symbol_out,
                                        dossier_mode,
                                        deep_completed,
                                        explicit_selected_symbol_path,
                                        publication_state_out,
                                        bundle,
                                        symbol_state,
                                        has_packet,
                                        has_market_watch,
                                        packet,
                                        filter,
                                        shortlist_ranked,
                                        deep_status_line,
                                        generated_utc,
                                        publication_status_line,
                                        last_published_line,
                                        last_good_fallback_line,
                                        current_bundle_status_line,
                                        continuity_mode_line,
                                        missing_delayed_areas_line,
                                        integrity_notes_line);

   integrity_notes_line += " | consumer market posture " + consumer_market_posture_text;
   integrity_notes_line += " | visible ceiling " + consumer_visible_ceiling_text;
   integrity_notes_line += " | L3/L4 source " + consumer_l34_source_text;
   integrity_notes_line += " | path " + consumer_path_identity_text;
   ASC_BuildDossierIdentityCore(symbol_state,
                                canonical_symbol_out,
                                identity_symbol,
                                identity_display_name,
                                identity_broker_symbol,
                                identity_asset_type,
                                identity_instrument_family,
                                identity_calculation_type,
                                identity_chart_mode);
   ASC_BuildDossierClassificationAuthority(symbol_state,
                                           broker_descriptors,
                                           advanced_status,
                                           advanced_main_bucket,
                                           advanced_sub_group,
                                           advanced_asset_class,
                                           advanced_source,
                                           advanced_confidence,
                                           broker_main_bucket,
                                           broker_sector,
                                           broker_industry,
                                           broker_exchange,
                                           broker_country,
                                           broker_notes,
                                           resolved_main_bucket,
                                           resolved_sub_group,
                                           resolved_asset_class,
                                           resolution_rule,
                                           classification_conflict_status,
                                           classification_notes);
   ASC_BuildDossierSymbolMetadata(symbol_state,
                                  broker_descriptors,
                                  metadata_exchange,
                                  metadata_sector,
                                  metadata_industry,
                                  metadata_country,
                                  metadata_isin,
                                  metadata_base_currency,
                                  metadata_quote_currency,
                                  metadata_margin_currency,
                                  metadata_digits,
                                  metadata_point,
                                  metadata_contract_profile_summary);

   int quote_digits = (has_packet && packet.digits > 0) ? packet.digits : 5;
   double atr_value_points = atr_ready ? ASC_SummaryAtrValue(packet) : 0.0;
   double atr_value_price = (atr_ready && packet.point > 0.0) ? (atr_value_points * packet.point) : 0.0;
   string day_range_text = has_day_range ? DoubleToString(packet.day_range_points, quote_digits) : completion_placeholder_lower;
   string day_range_pct_text = has_day_range ? DoubleToString(packet.day_range_pct, 2) + "%" : completion_placeholder_lower;
   string daily_change_pct_text = packet.valid_daily_change_pct
                                  ? DoubleToString(packet.daily_change_pct, 2) + "%"
                                  : completion_placeholder_lower;
   string spread_over_atr_text = (packet.valid_spread_to_atr && atr_ready && atr_value_points > 0.0)
                                 ? DoubleToString(packet.spread_to_atr, 3)
                                 : completion_placeholder_lower;
   string atr_value_text = (atr_ready && atr_value_price > 0.0) ? DoubleToString(atr_value_price, quote_digits) : completion_placeholder_lower;
   string atr_pct_text = (atr_ready && packet.bid > 0.0 && atr_value_price > 0.0)
                         ? DoubleToString((atr_value_price / packet.bid) * 100.0, 2) + "%"
                         : completion_placeholder_lower;
   string day_high_text = has_day_range ? DoubleToString(packet.day_high, quote_digits) : completion_placeholder_lower;
   string day_low_text = has_day_range ? DoubleToString(packet.day_low, quote_digits) : completion_placeholder_lower;
   string day_range_position_text = completion_placeholder_lower;
   string day_direction_snapshot_text = completion_placeholder_lower;
   string day_price_action_snapshot_text = completion_placeholder_lower;
   if(packet.valid_day_range_position)
      day_range_position_text = DoubleToString(packet.day_range_position_pct, 1) + "%";
   if(StringLen(packet.day_direction_snapshot) > 0 && packet.day_direction_snapshot != "Unavailable")
      day_direction_snapshot_text = packet.day_direction_snapshot;
   if(StringLen(packet.day_price_action_snapshot) > 0 && packet.day_price_action_snapshot != "Unavailable")
      day_price_action_snapshot_text = packet.day_price_action_snapshot;
   if(!has_packet)
      quote_observed_time_text = ASC_ArtifactFormatUtc(symbol_state.observed_at_utc);
   string volatility_posture_text = has_packet ? ASC_SummaryRegimeLabel(packet) : completion_placeholder;
   string friction_posture_text = has_packet ? ASC_SummaryFrictionClass(packet) : completion_placeholder;
   string liquidity_posture_text = has_packet ? ASC_SummaryLiquidityLabel(packet) : completion_placeholder;
   string market_watch_notes_text = ASC_DossierLiveSectionReason(symbol_state, has_packet, has_market_watch, packet);
   if(has_packet && packet.continuity_backed)
      market_watch_notes_text = "Continuity-backed market-watch snapshot is in use; treat volatility/friction posture as guarded.";
   else if(has_market_watch)
      market_watch_notes_text = StringFormat("Freshness %s | Volatility %s | Friction %s | Liquidity %s",
                                             quote_freshness,
                                             volatility_posture_text,
                                             friction_posture_text,
                                             liquidity_posture_text);
   bool volatility_continuity_sensitive = (!has_market_watch
                                           || (has_packet && packet.continuity_backed)
                                           || quote_freshness_degraded_or_stale);
   bool regime_liquidity_helpers_available = (volatility_posture_text != "Unavailable"
                                              || friction_posture_text != "Unavailable"
                                              || liquidity_posture_text != "Unavailable");
   ASC_SymbolSpecification spec_snapshot;
   bool has_spec_snapshot = ASC_GetSymbolSpecification(symbol_state.symbol, spec_snapshot, true);
   string calc_mode_text = spec_snapshot.has_calculation_mode
                           ? ASC_SymbolSpecificationCalcModeText(spec_snapshot.calculation_mode)
                           : "unavailable";
   ASC_SymbolSpecification permissions_snapshot = spec_snapshot;
   if(packet.valid_filling_mode)
     {
      permissions_snapshot.has_filling_mode = true;
      permissions_snapshot.filling_mode = packet.filling_mode;
     }
   if(packet.valid_expiration_mode)
     {
      permissions_snapshot.has_expiration_mode = true;
      permissions_snapshot.expiration_mode = packet.expiration_mode;
     }
   if(packet.valid_order_mode)
     {
      permissions_snapshot.has_order_mode = true;
      permissions_snapshot.order_mode = packet.order_mode;
     }
   string fill_mode_text = ASC_DossierFillingModeText(permissions_snapshot);
   string expiration_mode_text = ASC_DossierExpirationModeText(permissions_snapshot);
   string gtc_mode_text = packet.valid_gtc_mode
                          ? ASC_SymbolSpecHumanizeEnum(EnumToString((ENUM_SYMBOL_ORDER_GTC_MODE)packet.gtc_mode))
                          : ASC_DossierGtcModeText(symbol_state.symbol);
   string order_mode_text = ASC_DossierOrderModeText(permissions_snapshot);
   bool has_digits_value = (has_packet && packet.digits > 0) || (spec_snapshot.has_digits && spec_snapshot.digits > 0);
   long digits_value = (has_packet && packet.digits > 0) ? packet.digits : spec_snapshot.digits;
   bool has_point_value = (has_packet && packet.point > 0.0) || (spec_snapshot.has_point && spec_snapshot.point > 0.0);
   double point_value = (has_packet && packet.point > 0.0) ? packet.point : spec_snapshot.point;
   bool has_contract_size_value = packet.valid_contract_size || (spec_snapshot.has_contract_size && spec_snapshot.contract_size > 0.0);
   double contract_size_value = packet.valid_contract_size ? packet.contract_size : spec_snapshot.contract_size;
   bool has_tick_size_value = packet.valid_tick_size || (spec_snapshot.has_tick_size && spec_snapshot.tick_size > 0.0);
   double tick_size_value = packet.valid_tick_size ? packet.tick_size : spec_snapshot.tick_size;
   bool has_tick_value_value = packet.valid_tick_value || (spec_snapshot.has_tick_value && spec_snapshot.tick_value > 0.0);
   double tick_value_value = packet.valid_tick_value ? packet.tick_value : spec_snapshot.tick_value;

   string price_contract_digits_text = has_digits_value ? IntegerToString((int)digits_value) : "unavailable";
   string price_contract_point_text = has_point_value ? DoubleToString(point_value, 8) : "unavailable";
   string price_contract_contract_size_text = has_contract_size_value ? DoubleToString(contract_size_value, 2) : "unavailable";
   string price_contract_tick_size_text = has_tick_size_value ? DoubleToString(tick_size_value, 8) : "unavailable";
   string price_contract_tick_value_text = has_tick_value_value ? DoubleToString(tick_value_value, 8) : "unavailable";
   string price_contract_spread_type_text = ASC_DossierSpreadTypeText(spec_snapshot);
   string price_contract_notes_text = "raw source unavailable";
   if(has_packet)
      price_contract_notes_text = "raw source: packet/spec owner snapshot";
   else if(has_spec_snapshot)
      price_contract_notes_text = "raw source: symbol specification snapshot fallback (packet unavailable)";
   bool price_contract_packet_values_available = (has_contract_size_value
                                                  || has_tick_size_value
                                                  || has_tick_value_value
                                                  || has_point_value
                                                  || has_digits_value);
   bool price_contract_spec_values_available = has_spec_snapshot;
   bool has_trade_mode_value = packet.valid_trade_mode || spec_snapshot.has_trade_mode;
   long trade_mode_value = packet.valid_trade_mode ? packet.trade_mode : spec_snapshot.trade_mode;
   bool has_execution_mode_value = packet.valid_execution_mode || spec_snapshot.has_execution_mode;
   long execution_mode_value = packet.valid_execution_mode ? packet.execution_mode : spec_snapshot.execution_mode;
   string trade_permissions_trade_mode_text = has_trade_mode_value ? ASC_ArtifactTradeModeText(trade_mode_value) : "unavailable";
   string trade_permissions_execution_mode_text = has_execution_mode_value ? ASC_ArtifactExecutionModeText(execution_mode_value) : "unavailable";
   string trade_permissions_filling_mode_text = fill_mode_text;
   string trade_permissions_expiration_mode_text = expiration_mode_text;
   string trade_permissions_gtc_mode_text = gtc_mode_text;
   string trade_permissions_orders_allowed_text = order_mode_text;
   string trade_permissions_status_text = ASC_DossierPermissionStatusText(has_trade_mode_value, trade_mode_value);
   string trade_permissions_broker_validation_status_text = ASC_DossierSpecValidationStatus(has_packet,
                                                                                             packet,
                                                                                             has_spec_snapshot,
                                                                                             spec_snapshot);
   bool trade_permissions_packet_values_available = (has_trade_mode_value
                                                     || has_execution_mode_value
                                                     || trade_permissions_filling_mode_text != "unavailable"
                                                     || trade_permissions_expiration_mode_text != "unavailable"
                                                     || trade_permissions_orders_allowed_text != "unavailable");
   bool trade_permissions_spec_freshness_available = (trade_permissions_broker_validation_status_text != "Unavailable");
   bool has_volume_min_value = packet.valid_volume_min || (spec_snapshot.has_volume_min && spec_snapshot.volume_min > 0.0);
   bool has_volume_max_value = packet.valid_volume_max || (spec_snapshot.has_volume_max && spec_snapshot.volume_max > 0.0);
   bool has_volume_step_value = packet.valid_volume_step || (spec_snapshot.has_volume_step && spec_snapshot.volume_step > 0.0);
   bool has_stops_level_value = packet.valid_stop_distance || (spec_snapshot.has_stop_distance_points && spec_snapshot.has_point);
   double stops_level_value = packet.valid_stop_distance
                              ? packet.min_stop_distance
                              : (spec_snapshot.stop_distance_points * spec_snapshot.point);
   string volume_rules_minimum_volume_text = has_volume_min_value ? DoubleToString(packet.valid_volume_min ? packet.volume_min : spec_snapshot.volume_min, 2) : "unavailable";
   string volume_rules_maximum_volume_text = has_volume_max_value ? DoubleToString(packet.valid_volume_max ? packet.volume_max : spec_snapshot.volume_max, 2) : "unavailable";
   string volume_rules_step_text = has_volume_step_value ? DoubleToString(packet.valid_volume_step ? packet.volume_step : spec_snapshot.volume_step, 2) : "unavailable";
   string volume_rules_stops_level_text = has_stops_level_value ? DoubleToString(stops_level_value, 5) : "unavailable";
   string volume_rules_freeze_level_text = packet.valid_freeze_distance
                                           ? DoubleToString(packet.freeze_distance, 5)
                                           : ((spec_snapshot.has_freeze_distance_points && spec_snapshot.has_point)
                                              ? DoubleToString(spec_snapshot.freeze_distance_points * spec_snapshot.point, 5)
                                              : "unavailable");
   string volume_rules_position_notes_text = "raw source: symbol specification owner (packet/spec values only)";
   bool volume_rules_packet_values_available = (has_volume_min_value
                                                || has_volume_max_value
                                                || has_volume_step_value);
   bool volume_rules_stop_freeze_completeness_available = (has_stops_level_value
                                                           || (spec_snapshot.has_freeze_distance_points && spec_snapshot.has_point));
   ASC_SymbolSessionSummary session_summary;
   bool has_session_summary = ASC_GetSymbolSessionSummary(symbol_state.symbol, session_summary, true);
   string sessions_quote_session_status_text = packet.valid_quote_session_status
                                               ? packet.quote_session_status
                                               : ((has_session_summary && session_summary.available)
                                                  ? ASC_ArtifactHumanizeLabel(session_summary.posture)
                                                  : ASC_L1StateToOperatorText(symbol_state.state));
   string sessions_trade_session_status_text = packet.valid_trade_session_status
                                               ? packet.trade_session_status
                                               : sessions_quote_session_status_text;
   string sessions_quote_sessions_text = (packet.valid_quote_session_status && StringLen(packet.quote_session_hours) > 0)
                                         ? packet.quote_session_hours
                                         : ((has_session_summary && session_summary.available) ? session_summary.windows : "unavailable");
   string sessions_trade_sessions_text = (packet.valid_trade_session_status && StringLen(packet.trade_session_hours) > 0)
                                         ? packet.trade_session_hours
                                         : sessions_quote_sessions_text;
   string sessions_notes_text = ASC_L1ReasonToOperatorText(symbol_state.reason);
   if(packet.valid_quote_session_status || packet.valid_trade_session_status)
      sessions_notes_text += StringFormat(" | packet session posture=%s/%s",
                                          sessions_quote_session_status_text,
                                          sessions_trade_session_status_text);
   else if(has_session_summary && session_summary.available)
      sessions_notes_text += StringFormat(" | session-owner posture=%s", session_summary.posture);
   bool sessions_state_available = (StringLen(sessions_quote_session_status_text) > 0
                                    && StringLen(sessions_trade_session_status_text) > 0);
   bool sessions_schedule_detail_available = (sessions_quote_sessions_text != "unavailable"
                                              || sessions_trade_sessions_text != "unavailable");
   string swap_type_text = packet.valid_swap_mode
                           ? ASC_SymbolSpecificationSwapModeText(packet.swap_mode)
                           : (spec_snapshot.has_swap_mode ? ASC_SymbolSpecificationSwapModeText(spec_snapshot.swap_mode) : "unavailable");
   string swap_long_text = packet.valid_swap_long
                           ? DoubleToString(packet.swap_long, 5)
                           : (spec_snapshot.has_swap_long ? DoubleToString(spec_snapshot.swap_long, 5) : "unavailable");
   string swap_short_text = packet.valid_swap_short
                            ? DoubleToString(packet.swap_short, 5)
                            : (spec_snapshot.has_swap_short ? DoubleToString(spec_snapshot.swap_short, 5) : "unavailable");
   bool has_swap_monday = packet.valid_swap_monday;
   bool has_swap_tuesday = packet.valid_swap_tuesday;
   bool has_swap_wednesday = packet.valid_swap_wednesday;
   bool has_swap_thursday = packet.valid_swap_thursday;
   bool has_swap_friday = packet.valid_swap_friday;
   string swap_monday_text = has_swap_monday ? DoubleToString(packet.swap_monday, 2) : "unavailable";
   string swap_tuesday_text = has_swap_tuesday ? DoubleToString(packet.swap_tuesday, 2) : "unavailable";
   string swap_wednesday_text = has_swap_wednesday ? DoubleToString(packet.swap_wednesday, 2) : "unavailable";
   string swap_thursday_text = has_swap_thursday ? DoubleToString(packet.swap_thursday, 2) : "unavailable";
   string swap_friday_text = has_swap_friday ? DoubleToString(packet.swap_friday, 2) : "unavailable";
   string swap_notes_text = "swap terms unavailable from broker specification owner.";
   bool swap_values_available = (packet.valid_swap_mode
                                 || packet.valid_swap_long
                                 || packet.valid_swap_short
                                 || spec_snapshot.has_swap_mode
                                 || spec_snapshot.has_swap_long
                                 || spec_snapshot.has_swap_short);
   bool swap_schedule_available = (has_swap_monday || has_swap_tuesday || has_swap_wednesday || has_swap_thursday || has_swap_friday);
   if(swap_values_available && swap_schedule_available)
      swap_notes_text = "swap terms and weekday carry multipliers are sourced from broker specification owner.";
   else if(swap_values_available)
      swap_notes_text = "swap value terms are sourced from broker specification owner; weekday carry multipliers are unavailable.";
   else if(swap_schedule_available)
      swap_notes_text = "weekday carry multipliers are available; primary swap mode/long/short terms are unavailable.";
   string margin_mode_text = packet.valid_margin_mode
                             ? ASC_AccountMarginModeText(packet.margin_mode)
                             : ASC_AccountMarginModeText(AccountInfoInteger(ACCOUNT_MARGIN_MODE));
   bool margin_hedged_available = packet.valid_margin_hedged;
   string margin_hedged_text = margin_hedged_available ? DoubleToString(packet.margin_hedged, 2) : "unavailable";
   bool margin_buy_from_packet = packet.valid_buy_initial_margin;
   bool margin_buy_maintenance_from_packet = packet.valid_buy_maintenance_margin;
   bool margin_sell_from_packet = packet.valid_sell_initial_margin;
   bool margin_sell_maintenance_from_packet = packet.valid_sell_maintenance_margin;

   string margin_buy_initial_text = margin_buy_from_packet ? DoubleToString(packet.buy_initial_margin, 2) : (spec_snapshot.has_margin_initial ? DoubleToString(spec_snapshot.margin_initial, 2) : "unavailable");
   string margin_buy_maintenance_text = margin_buy_maintenance_from_packet ? DoubleToString(packet.buy_maintenance_margin, 2) : (spec_snapshot.has_margin_maintenance ? DoubleToString(spec_snapshot.margin_maintenance, 2) : "unavailable");
   string margin_sell_initial_text = margin_sell_from_packet ? DoubleToString(packet.sell_initial_margin, 2) : (spec_snapshot.has_margin_initial ? DoubleToString(spec_snapshot.margin_initial, 2) : "unavailable");
   string margin_sell_maintenance_text = margin_sell_maintenance_from_packet ? DoubleToString(packet.sell_maintenance_margin, 2) : (spec_snapshot.has_margin_maintenance ? DoubleToString(spec_snapshot.margin_maintenance, 2) : "unavailable");
   bool margin_account_context_available = account_snapshot.margin_level_available;
   bool margin_broker_spec_margin_detail_available = (packet.valid_buy_initial_margin
                                                      || packet.valid_buy_maintenance_margin
                                                      || packet.valid_margin_hedged
                                                      || spec_snapshot.has_margin_initial
                                                      || spec_snapshot.has_margin_maintenance
                                                      || margin_hedged_available);
   bool directional_margin_fields_available = (margin_buy_from_packet
                                               || margin_buy_maintenance_from_packet
                                               || margin_sell_from_packet
                                               || margin_sell_maintenance_from_packet);
   bool fallback_non_directional_margin_used = (!directional_margin_fields_available
                                                && (spec_snapshot.has_margin_initial
                                                    || spec_snapshot.has_margin_maintenance));
   string margin_notes_text = StringFormat("account_margin_context=%s | symbol_margin_fields=%s | directional_margin_fields=%s | hedged_margin=%s",
                                           margin_account_context_available ? "available" : "unavailable",
                                           margin_broker_spec_margin_detail_available ? "available" : "unavailable",
                                           directional_margin_fields_available ? "available" : "unavailable",
                                           margin_hedged_available ? "available" : "unavailable");

   if(StringLen(packet.margin_notes) > 0)
      margin_notes_text += " | " + packet.margin_notes;
   if(fallback_non_directional_margin_used)
      margin_notes_text += " | buy/sell initial/maintenance values are spec fallback and may be shared non-directional values";

   double symbol_commission_value = 0.0;
   bool symbol_commission_available = false;
#ifdef SYMBOL_TRADE_COMMISSION
   symbol_commission_available = SymbolInfoDouble(symbol_state.symbol, SYMBOL_TRADE_COMMISSION, symbol_commission_value);
#endif
   if(symbol_commission_available)
      margin_notes_text += " | commission_symbol_spec=" + DoubleToString(symbol_commission_value, 8) + " (SYMBOL_TRADE_COMMISSION)";
   else
      margin_notes_text += " | commission_symbol_spec=unavailable (not exposed via active SYMBOL_* API surface)";

   string gate_status_filter_state_text = ASC_DossierCandidateFilterStateText(filter);
   string gate_status_eligibility_text = ASC_ArtifactHumanizeLabel(filter.eligibility_posture);
   string gate_status_freshness_text = ASC_DossierFreshnessLabel(symbol_state, has_market_watch, packet);
   string gate_status_reason_summary_text = ASC_TextOrUnavailable(filter.reason_summary);
   string filter_score_summary_text = ASC_TextOrUnavailable(filter.score_pack_summary);
   if(!explicit_selected_symbol_path)
     {
      if(gate_status_reason_summary_text == "Unavailable")
         gate_status_reason_summary_text = "ordinary path posture " + ordinary_l34_guard_reason;
      else
         gate_status_reason_summary_text += " | ordinary path posture " + ordinary_l34_guard_reason;
     }
   string gate_status_decision_confidence_text = ASC_TextOrUnavailable(filter.confidence_text);
   string gate_score_posture_text = ASC_TextOrUnavailable(filter.score_posture);
   string gate_attention_posture_text = ASC_TextOrUnavailable(filter.attention_posture);
   if(gate_status_decision_confidence_text == "Unavailable")
     {
      if(gate_score_posture_text != "Unavailable" || gate_attention_posture_text != "Unavailable")
        {
         gate_status_decision_confidence_text = "";
         if(gate_score_posture_text != "Unavailable")
            gate_status_decision_confidence_text = "score posture " + ASC_ArtifactHumanizeLabel(gate_score_posture_text);
         if(gate_attention_posture_text != "Unavailable")
            gate_status_decision_confidence_text += (StringLen(gate_status_decision_confidence_text) > 0 ? " | " : "") + "attention " + ASC_ArtifactHumanizeLabel(gate_attention_posture_text);
        }
     }
   else
     {
      if(gate_score_posture_text != "Unavailable")
         gate_status_decision_confidence_text += " | score posture " + ASC_ArtifactHumanizeLabel(gate_score_posture_text);
      if(gate_attention_posture_text != "Unavailable")
         gate_status_decision_confidence_text += " | attention " + ASC_ArtifactHumanizeLabel(gate_attention_posture_text);
     }
   if(StringLen(gate_status_decision_confidence_text) <= 0 || gate_status_decision_confidence_text == "Unavailable")
      gate_status_decision_confidence_text = "unavailable";
   bool gate_status_owner_truth_available = (StringLen(gate_status_filter_state_text) > 0
                                             && StringLen(gate_status_eligibility_text) > 0
                                             && StringLen(gate_status_reason_summary_text) > 0);
   bool gate_status_freshness_available = (StringLen(gate_status_freshness_text) > 0
                                           && gate_status_freshness_text != "Unavailable");
   bool gate_status_freshness_degraded = (StringFind(gate_status_freshness_text, "Stale") >= 0
                                          || StringFind(gate_status_freshness_text, "Degraded") >= 0
                                          || StringFind(gate_status_freshness_text, "Continuity") >= 0);
   string blockers_disqualifiers_text = ASC_TextOrUnavailable(filter.disqualifiers);
   string blockers_dependencies_text = ASC_TextOrUnavailable(filter.dependencies_text);
   string blockers_missing_confirmation_text = ASC_TextOrUnavailable(filter.corroboration_text);
   string blockers_next_required_step_text = ASC_TextOrUnavailable(filter.next_required_step);
   string blockers_constraint_notes_text = ASC_TextOrUnavailable(filter.score_pack_reason);
   if(blockers_constraint_notes_text == "Unavailable")
      blockers_constraint_notes_text = ASC_TextOrUnavailable(filter.result_reason);
   bool blockers_owner_truth_available = (StringLen(blockers_disqualifiers_text) > 0
                                          && StringLen(blockers_dependencies_text) > 0
                                          && StringLen(blockers_missing_confirmation_text) > 0);
   bool blockers_dependency_context_available = (StringLen(filter.dependencies_text) > 0
                                                 || StringLen(filter.corroboration_text) > 0
                                                 || StringLen(filter.next_required_step) > 0);
   string sorting_inputs_spread_gate_text = ASC_DossierGateInputBinaryText(filter.spread_is_sane, false);
   string sorting_inputs_freshness_gate_text = ASC_DossierGateInputBinaryText(filter.freshness_is_current, true);
   string sorting_inputs_state_gate_text = ASC_DossierGateInputBinaryText(filter.market_state_is_open, false);
   string sorting_inputs_liquidity_gate_text = ASC_DossierGateInputBinaryText(filter.quote_freshness_is_acceptable, true);
   string sorting_inputs_volatility_gate_text = has_market_watch ? ASC_SummaryRegimeLabel(packet) : "unavailable";
   string sorting_inputs_quality_gate_text = ASC_DossierGateInputBinaryText(filter.confidence_is_acceptable, true);
   string sorting_inputs_notes_text = ASC_DossierTacticalStackLine(filter);
   if(sorting_inputs_notes_text == "Unavailable")
      sorting_inputs_notes_text = (filter_score_summary_text != "Unavailable") ? filter_score_summary_text : ASC_TextOrUnavailable(filter.reason_summary);
   bool sorting_inputs_owner_truth_available = (StringLen(sorting_inputs_spread_gate_text) > 0
                                                && StringLen(sorting_inputs_freshness_gate_text) > 0
                                                && StringLen(sorting_inputs_state_gate_text) > 0
                                                && StringLen(sorting_inputs_liquidity_gate_text) > 0
                                                && StringLen(sorting_inputs_quality_gate_text) > 0
                                                && StringLen(sorting_inputs_notes_text) > 0);
   bool sorting_inputs_gate_context_available = (has_market_watch
                                                 || StringLen(sorting_inputs_volatility_gate_text) > 0);
   string shortlist_core_status_text = selection_state;
   if(!explicit_selected_symbol_path && ordinary_l34_visible && !shortlist_found)
      shortlist_core_status_text += " | " + ordinary_l4_guard_reason;
   string shortlist_core_rank_text = "overall diversified reserve | bucket-local outside top-5 | subgroup-local reserved | raw field unranked";
   if(shortlist_found)
      shortlist_core_rank_text = ASC_DossierOverallBoardContextText(shortlist_entry);
   else if(shortlist_ranked)
      shortlist_core_rank_text = StringFormat("overall diversified #%d | bucket-local pending | subgroup-local reserved | raw field unranked",
                                              shortlist_rank);
   string shortlist_core_priority_score_text = shortlist_found
                                               ? StringFormat("overall board %.1f | shortlist %.1f | Candidate Filtering %.1f | l3_score_is_support_input_only=true | rank_may_differ_from_raw_l3_score=true | %s | %s | quality adj %s | corr pen %.1f | diversity pen %.1f | exposure pen %.1f",
                                                              shortlist_entry.overall_board_score,
                                                              shortlist_entry.shortlist_score,
                                                              shortlist_entry.shortlist_l3_score,
                                                              ASC_DossierShortlistOpportunityShapeLine(shortlist_entry),
                                                              ASC_DossierShortlistFieldContextLine(shortlist_entry),
                                                              ASC_ShortlistSignedScoreText(shortlist_entry.overall_board_quality_adjustment),
                                                              shortlist_entry.overall_board_correlation_penalty,
                                                              shortlist_entry.overall_board_bucket_penalty,
                                                              shortlist_entry.overall_board_conflict_penalty)
                                               : "n/a";
   string shortlist_attention_text = shortlist_found ? ASC_TextOrUnavailable(shortlist_entry.shortlist_attention_posture) : "Unavailable";
   string shortlist_core_selection_posture_text = shortlist_found
                                                   ? StringFormat("%s | shortlist %s | attention %s | stability %s | membership %s | %s",
                                                                  ASC_ShortlistMembershipScopeReadbackText(shortlist_entry),
                                                                  ASC_ArtifactHumanizeLabel(shortlist_entry.shortlist_posture),
                                                                  shortlist_attention_text != "Unavailable" ? ASC_ArtifactHumanizeLabel(shortlist_attention_text) : "unavailable",
                                                                  ASC_ArtifactHumanizeLabel(shortlist_entry.shortlist_stability_posture),
                                                                  ASC_ArtifactHumanizeLabel(shortlist_entry.membership_state),
                                                                  ASC_DossierShortlistDayFraming(shortlist_entry))
                                                   : "awaiting";
   string shortlist_core_reason_summary_text = shortlist_found
                                                ? (ASC_DossierShortlistDayFraming(shortlist_entry)
                                                   + " | "
                                                   + ASC_DossierShortlistOpportunityShapeLine(shortlist_entry)
                                                   + " | "
                                                   + ASC_DossierShortlistFieldContextLine(shortlist_entry))
                                                : "awaiting next shortlist refresh";
    string shortlist_reason_fallback_text = shortlist_found
                                            ? ASC_TextOrUnavailable(shortlist_entry.overall_board_reason)
                                            : "awaiting next shortlist refresh";
    if(shortlist_reason_fallback_text == "Unavailable")
       shortlist_reason_fallback_text = shortlist_found ? ASC_TextOrUnavailable(shortlist_entry.shortlist_reason) : "awaiting next shortlist refresh";
    if(shortlist_found && shortlist_reason_fallback_text != "Unavailable")
       shortlist_core_reason_summary_text += " | board readback " + shortlist_reason_fallback_text;
    if(shortlist_core_reason_summary_text == "Unavailable")
       shortlist_core_reason_summary_text = shortlist_reason_fallback_text;
   string shortlist_core_promotion_status_text = shortlist_found
                                                 ? StringFormat("%s | %s",
                                                                ASC_ArtifactHumanizeLabel(shortlist_entry.shortlist_band),
                                                                ASC_DossierBucketMembershipText(shortlist_entry))
                                                 : ((shortlist_ranked && shortlist_rank <= 3)
                                                    ? "promoted overall member | ordinary board authority active"
                                                    : "not promoted");
   bool shortlist_core_owner_truth_available = (StringLen(shortlist_core_status_text) > 0
                                                && StringLen(shortlist_core_rank_text) > 0
                                                && StringLen(shortlist_core_priority_score_text) > 0
                                                && StringLen(shortlist_core_selection_posture_text) > 0
                                                && StringLen(shortlist_core_reason_summary_text) > 0
                                                && StringLen(shortlist_core_promotion_status_text) > 0);
   bool shortlist_core_context_available = shortlist_found || shortlist_ranked;
   string shortlist_hold_status_text = "unavailable";
    if(shortlist_found)
      {
       string shortlist_posture_text = ASC_TextOrUnavailable(shortlist_entry.shortlist_posture);
       string shortlist_stability_posture_text = ASC_TextOrUnavailable(shortlist_entry.shortlist_stability_posture);
       string shortlist_membership_text = ASC_TextOrUnavailable(shortlist_entry.membership_state);
       string overall_board_status = ASC_DossierOverallBoardStatusText(shortlist_entry);
       shortlist_hold_status_text = StringFormat("%s | posture %s | stability %s | membership %s | %s",
                                                overall_board_status,
                                                shortlist_posture_text,
                                                shortlist_stability_posture_text,
                                                shortlist_membership_text,
                                                ASC_DossierShortlistOpportunityShapeLine(shortlist_entry));
      }

   string shortlist_stability_status_text = "unavailable";
   if(shortlist_found)
     {
      if(shortlist_ranked)
         shortlist_stability_status_text = StringFormat("overall rank #%d | band %s | bucket rank %d",
                                                        shortlist_entry.rank,
                                                        ASC_ArtifactHumanizeLabel(shortlist_entry.shortlist_band),
                                                        shortlist_entry.bucket_rank);
      else
         shortlist_stability_status_text = StringFormat("%s | band %s | bucket rank %d",
                                                        ASC_DossierOverallBoardStatusText(shortlist_entry),
                                                        ASC_ArtifactHumanizeLabel(shortlist_entry.shortlist_band),
                                                        shortlist_entry.bucket_rank);
      if(shortlist_attention_text != "Unavailable")
         shortlist_stability_status_text += " | attention " + ASC_ArtifactHumanizeLabel(shortlist_attention_text);
     }

   string shortlist_replacement_pressure_text = shortlist_found
                                                 ? (ASC_DossierShortlistFieldContextLine(shortlist_entry)
                                                    + " | "
                                                    + ASC_TextOrUnavailable(shortlist_entry.shortlist_score_summary))
                                                 : "unavailable";
    if(shortlist_found && StringFind(shortlist_replacement_pressure_text, "Unavailable") >= 0)
       shortlist_replacement_pressure_text = ASC_DossierShortlistFieldContextLine(shortlist_entry) + " | " + ASC_TextOrUnavailable(shortlist_entry.shortlist_reason);
    if(shortlist_replacement_pressure_text == "Unavailable")
       shortlist_replacement_pressure_text = shortlist_found ? ASC_TextOrUnavailable(shortlist_entry.shortlist_reason) : "unavailable";
   string shortlist_selection_continuity_text = (has_packet && packet.continuity_backed) ? "continuity-backed" : "live";
   string shortlist_notes_text = shortlist_found
                                 ? (explicit_selected_symbol_path
                                    ? ("Shortlist Selection rank/score fields are producer-owned priority-ordering support only; not trade permission, not entry signal, not final execution decision, and not Deep Selective Analysis; " + ASC_DossierSameSymbolRoleLine(explicit_selected_symbol_path, deep_completed) + ".")
                                    : ("Shortlist Selection rank/score fields are producer-owned priority-ordering support only; not trade permission, not entry signal, not final execution decision, and not Deep Selective Analysis; " + ASC_DossierSameSymbolRoleLine(explicit_selected_symbol_path, deep_completed) + "."))
                                 : ("Shortlist Selection fields are unavailable for this symbol in the current shortlist projection | " + ordinary_l4_guard_reason);
   bool shortlist_hold_owner_truth_available = (StringLen(shortlist_hold_status_text) > 0
                                                && StringLen(shortlist_stability_status_text) > 0
                                                && StringLen(shortlist_replacement_pressure_text) > 0
                                                && StringLen(shortlist_selection_continuity_text) > 0
                                                && StringLen(shortlist_notes_text) > 0);
   bool shortlist_hold_context_available = shortlist_found || shortlist_ranked || has_packet;
   string shortlist_correlation_score_text = cor.summary_ready ? DoubleToString(cor.average_score, 2) : "unavailable";
   string shortlist_highest_correlations_text = cor.summary_ready
                                                ? (ASC_CorrelationPeerWithValue(cor.high_a_symbol, cor.high_a_score) + ", " + ASC_CorrelationPeerWithValue(cor.high_b_symbol, cor.high_b_score))
                                                : "n/a";
   string shortlist_lowest_correlations_text = cor.summary_ready
                                               ? (ASC_CorrelationPeerWithValue(cor.low_a_symbol, cor.low_a_score) + ", " + ASC_CorrelationPeerWithValue(cor.low_b_symbol, cor.low_b_score))
                                               : "n/a";
   string shortlist_exposure_conflict_status_text = ASC_ConflictCountsText(open_positions, pending_orders);
   string shortlist_open_pending_conflict_notes_text = ASC_CorrelationConflictInterpretationState(cor.summary_ready, cor.average_score, open_positions, pending_orders);
   string shortlist_portfolio_conflict_notes_text = ASC_CorrelationExposureInterpretationState(cor.summary_ready, cor.average_score, open_positions, pending_orders);
   bool shortlist_correlation_owner_truth_available = (StringLen(shortlist_correlation_score_text) > 0
                                                       && StringLen(shortlist_highest_correlations_text) > 0
                                                       && StringLen(shortlist_lowest_correlations_text) > 0
                                                       && StringLen(shortlist_exposure_conflict_status_text) > 0
                                                       && StringLen(shortlist_open_pending_conflict_notes_text) > 0
                                                       && StringLen(shortlist_portfolio_conflict_notes_text) > 0);
   bool shortlist_correlation_context_available = true;
   bool score_authority_is_deep = (deep_completed && explicit_selected_symbol_path);
   string trader_context_watchlist_priority_text = score_authority_is_deep
                                                   ? "explicit selected-symbol deep packet (owner-backed for this symbol only; Market Board still owns ordinary pick priority)"
                                                   : (deep_completed ? "ordinary passive path | explicit deep path remains separate" : selection_bucket);
   string trader_context_changed_recently_text = score_authority_is_deep
                                                 ? (ASC_TextOrUnavailable(deep_packet_summary_line) + " | " + ASC_DossierSameSymbolRoleLine(explicit_selected_symbol_path, deep_completed))
                                                 : (deep_completed ? (ASC_TextOrUnavailable(market_state_truth) + " | " + ASC_DossierSameSymbolRoleLine(explicit_selected_symbol_path, deep_completed)) : ASC_TextOrUnavailable(market_state_truth));
   string trader_context_needs_recheck_text = score_authority_is_deep
                                              ? (ASC_TextOrUnavailable(deep_status_line) + " | " + ASC_DossierSameSymbolRoleLine(explicit_selected_symbol_path, deep_completed))
                                              : (deep_completed ? "ordinary path stays passive; consult explicit Deep Analysis section separately when needed" : filter.next_required_step);
   string change_trace_latest_meaningful_change_text = score_authority_is_deep
                                                       ? ASC_TextOrUnavailable(l6_review_latest_change)
                                                       : (deep_completed ? (ASC_TextOrUnavailable(market_state_truth) + " | " + ASC_DossierSameSymbolRoleLine(explicit_selected_symbol_path, deep_completed)) : ASC_TextOrUnavailable(market_state_truth));
   string change_trace_previous_meaningful_change_text = score_authority_is_deep
                                                         ? ASC_TextOrUnavailable(l6_review_previous_change)
                                                         : "historical anchor is not tracked on the ordinary non-selected-symbol path";
   string change_trace_state_transition_notes_text = score_authority_is_deep
                                                     ? ASC_TextOrUnavailable(l6_review_state_transition)
                                                     : ASC_TextOrUnavailable(ASC_L1ReasonToOperatorText(symbol_state.reason));
   string change_trace_selection_transition_notes_text = score_authority_is_deep
                                                         ? ASC_TextOrUnavailable(l6_review_selection_transition)
                                                         : ASC_TextOrUnavailable(shortlist_truth);
   string change_trace_publication_transition_notes_text = ASC_TextOrUnavailable(publication_state_out);
   string change_trace_deep_transition_notes_text = score_authority_is_deep
                                                    ? ASC_TextOrUnavailable(l6_review_deep_transition)
                                                    : ASC_TextOrUnavailable(deep_status_line);
   bool change_trace_owner_truth_available = (StringLen(change_trace_latest_meaningful_change_text) > 0
                                              && change_trace_latest_meaningful_change_text != "unavailable"
                                              && StringLen(change_trace_state_transition_notes_text) > 0
                                              && StringLen(change_trace_selection_transition_notes_text) > 0
                                              && StringLen(change_trace_publication_transition_notes_text) > 0
                                              && StringLen(change_trace_deep_transition_notes_text) > 0);
   bool change_trace_transition_context_available = (StringLen(change_trace_state_transition_notes_text) > 0
                                                     && StringLen(change_trace_selection_transition_notes_text) > 0
                                                     && StringLen(change_trace_publication_transition_notes_text) > 0
                                                     && StringLen(change_trace_deep_transition_notes_text) > 0);

   string hydration_class = ASC_DossierHydrationClassLabel(dossier_mode,
                                                          explicit_selected_symbol_path,
                                                          explicit_global_top10_path,
                                                          deep_completed,
                                                          has_deep_result,
                                                          symbol_state,
                                                          has_packet,
                                                          has_market_watch,
                                                          include_l4_section,
                                                          packet);
   string hydration_reason = ASC_DossierHydrationClassReason(hydration_class,
                                                            dossier_mode,
                                                            explicit_selected_symbol_path,
                                                            explicit_global_top10_path,
                                                            deep_completed,
                                                            has_deep_result,
                                                            symbol_state,
                                                            has_packet,
                                                            has_market_watch,
                                                            include_l3_section,
                                                            include_l4_section,
                                                            packet,
                                                            shortlist_found,
                                                            shortlist_ranked);

   string body = "===============================================================================\n";
   body += "AURORA SENTINEL SCANNER — SYMBOL DOSSIER\n";
   body += "===============================================================================\n\n";
   string schema_version_text = ASC_DossierHeaderSchemaVersion(runtime_selected_symbol_context);
   string logic_version_text = "layer6_surface_prompt4";
   string freshness_compact_text = StringFormat("generated=%s | continuity=%s | deep=%s",
                                                ASC_ArtifactFormatUtc(generated_utc),
                                                continuity_status_text,
                                                deep_status_header_text);
   body += ASC_BuildDossierTopHeaderSection(generated_utc,
                                            last_successful_publish,
                                            ASC_TextOrUnavailable(bundle.publication_id),
                                            state_revision_text,
                                            schema_version_text,
                                            logic_version_text,
                                            freshness_compact_text,
                                            continuity_status_text,
                                            freshness_status_text,
                                            selected_symbol_status_text,
                                            deep_status_header_text,
                                            header_status);
   body += ASC_DossierHydrationClassProofLine(hydration_class,
                                             hydration_reason,
                                             dossier_mode,
                                             has_packet,
                                             has_market_watch,
                                             shortlist_found,
                                             shortlist_ranked,
                                             deep_completed,
                                             explicit_selected_symbol_path,
                                             explicit_global_top10_path);

   bool snapshot_continuity_sensitive = (symbol_state.is_degraded
                                         || symbol_state.is_stale
                                         || (has_packet && packet.continuity_backed));
   body += ASC_BuildDossierOperatorSnapshotSection(primary_read,
                                                   primary_risk,
                                                   primary_opportunity,
                                                   primary_constraint,
                                                   primary_next_check,
                                                   one_line_summary,
                                                   snapshot_continuity_sensitive,
                                                   snapshot_status);

   string surface_truth_line = ASC_ArtifactSurfaceFreshnessBoundaryLine(publication_state_out, false);
   string surface_provenance_line = ASC_ArtifactSurfaceProvenanceLine();

   body += ASC_BuildDossierPublicationIntegritySection(publication_status_line,
                                                       last_published_line,
                                                       last_good_fallback_line,
                                                       current_bundle_status_line,
                                                       continuity_mode_line,
                                                       missing_delayed_areas_line,
                                                       integrity_notes_line,
                                                       surface_truth_line,
                                                       surface_provenance_line,
                                                       publication_integrity_status);

   string section_order[];
   ASC_DossierCanonicalSectionOrder(section_order);

   ASC_DossierAppendSectionHeader(body, section_order[2]);
   bool identity_partially_resolved = (!symbol_state.classification.resolved
                                       || identity_asset_type == "Unresolved"
                                       || identity_instrument_family == "Unresolved"
                                       || identity_calculation_type == "Unavailable"
                                       || identity_chart_mode == "Unavailable");
   string identity_visible_symbol = ASC_TextOrUnavailable(symbol_state.symbol);
   string identity_canonical_symbol_id = ASC_TextOrUnavailable(canonical_symbol_out);
   string identity_exact_broker_symbol = ASC_TextOrUnavailable(identity_broker_symbol);
   string identity_broker_suffix = "unavailable_owner=DossierComposer_reason=suffix_not_safely_parseable_no_guessing";
   if(identity_exact_broker_symbol != "Unavailable" && identity_canonical_symbol_id != "Unavailable")
     {
      if(identity_exact_broker_symbol == identity_canonical_symbol_id)
         identity_broker_suffix = "none";
      else if(StringFind(identity_exact_broker_symbol, identity_canonical_symbol_id) == 0 && StringLen(identity_exact_broker_symbol) > StringLen(identity_canonical_symbol_id))
         identity_broker_suffix = StringSubstr(identity_exact_broker_symbol, StringLen(identity_canonical_symbol_id));
     }

   body += ASC_BuildDossierIdentityCoreSection(identity_symbol,
                                               identity_display_name,
                                               identity_broker_symbol,
                                               identity_visible_symbol,
                                               identity_canonical_symbol_id,
                                               identity_exact_broker_symbol,
                                               identity_broker_suffix,
                                               identity_asset_type,
                                               identity_instrument_family,
                                               identity_calculation_type,
                                               identity_chart_mode,
                                               identity_partially_resolved,
                                               identity_core_status);

   bool advanced_resolved = (advanced_status == "Resolved");
   bool broker_support_present = (broker_main_bucket != "unavailable"
                                  || broker_sector != "unavailable"
                                  || broker_industry != "unavailable");
   body += ASC_BuildDossierClassificationAuthoritySection(advanced_status,
                                                          advanced_main_bucket,
                                                          advanced_sub_group,
                                                          advanced_asset_class,
                                                          advanced_source,
                                                          advanced_confidence,
                                                          broker_main_bucket,
                                                          broker_sector,
                                                          broker_industry,
                                                          broker_exchange,
                                                          broker_country,
                                                          broker_notes,
                                                          resolved_main_bucket,
                                                          resolved_sub_group,
                                                          resolved_asset_class,
                                                          resolution_rule,
                                                          classification_conflict_status,
                                                          classification_notes,
                                                          advanced_resolved,
                                                          broker_support_present,
                                                          classification_authority_status);

   int broker_supported_count = 0;
   if(metadata_sector != "unavailable")
      broker_supported_count++;
   if(metadata_industry != "unavailable")
      broker_supported_count++;
   if(metadata_isin != "unavailable")
      broker_supported_count++;

   int symbol_spec_supported_count = 0;
   if(metadata_base_currency != "unavailable")
      symbol_spec_supported_count++;
   if(metadata_quote_currency != "unavailable")
      symbol_spec_supported_count++;
   if(metadata_margin_currency != "unavailable")
      symbol_spec_supported_count++;
   if(metadata_digits != "unavailable")
      symbol_spec_supported_count++;
   if(metadata_point != "unavailable")
      symbol_spec_supported_count++;

   body += ASC_BuildDossierSymbolMetadataSection(metadata_exchange,
                                                 metadata_sector,
                                                 metadata_industry,
                                                 metadata_country,
                                                 metadata_isin,
                                                 metadata_base_currency,
                                                 metadata_quote_currency,
                                                 metadata_margin_currency,
                                                 metadata_digits,
                                                 metadata_point,
                                                 metadata_contract_profile_summary,
                                                 broker_supported_count,
                                                 symbol_spec_supported_count,
                                                 symbol_metadata_status);

   ASC_DossierAppendSectionHeader(body, section_order[3]);
   string market_state_status_text = ASC_L1StateToOperatorText(symbol_state.state);
   string tradeability_status_text = ASC_L2TradeabilityToOperatorText(packet);
   string session_status_text = ASC_L1SessionStatusToOperatorText(symbol_state);
   string open_closed_uncertain_text = ASC_L1StateToOperatorText(symbol_state.state);
   string open_closed_uncertain_reason_text = ASC_L1ReasonToOperatorText(symbol_state.reason);
   bool state_uncertain_or_degraded = (symbol_state.state == ASC_L1_UNCERTAIN
                                       || symbol_state.is_degraded
                                       || symbol_state.is_stale);
   bool tradeability_available = ASC_L2TradeabilityTruthAvailable(packet);
   body += ASC_BuildDossierMarketStateCoreSection(market_state_status_text,
                                                  tradeability_status_text,
                                                  session_status_text,
                                                  open_closed_uncertain_text,
                                                  open_closed_uncertain_reason_text,
                                                  state_uncertain_or_degraded,
                                                  tradeability_available,
                                                  market_state_core_status);

   string state_last_checked_text = ASC_ArtifactFormatUtc(symbol_state.observed_at_utc);
   string state_next_due_text = ASC_ArtifactFormatUtc(symbol_state.next_due_utc);
   string state_freshness_text = ASC_DossierFreshnessLabel(symbol_state, has_market_watch, packet);
   string state_confidence_text = ASC_L1ConfidenceToOperatorText(symbol_state.confidence);
   string state_bid_ask_presence_text = ASC_L2BidAskPresenceToOperatorText(has_packet, has_market_watch, packet);
   string state_notes_text = ASC_L1TimingStatusNotesToOperatorText(symbol_state);
   bool state_freshness_degraded_or_stale = (symbol_state.is_degraded
                                             || symbol_state.is_stale
                                             || (has_packet && (packet.freshness == ASC_L2_STALE
                                                                || packet.freshness == ASC_L2_DEGRADED
                                                                || packet.freshness == ASC_L2_CONTINUITY)));
   bool state_confidence_available = (StringLen(state_confidence_text) > 0
                                      && state_confidence_text != "unavailable"
                                      && state_confidence_text != "Unavailable");
   body += ASC_BuildDossierMarketStateTimingSection(state_last_checked_text,
                                                    state_next_due_text,
                                                    state_freshness_text,
                                                    state_confidence_text,
                                                    state_bid_ask_presence_text,
                                                    state_notes_text,
                                                    state_freshness_degraded_or_stale,
                                                    state_confidence_available,
                                                    market_state_timing_status);

   ASC_DossierAppendSectionHeader(body, section_order[4]);
   body += ASC_BuildDossierMarketWatchQuoteSnapshotSection(quote_bid_text,
                                                           quote_ask_text,
                                                           quote_last_text,
                                                           quote_spread_text,
                                                           spread_pct_text,
                                                           quote_last_tick_time_text,
                                                           packet_age_text,
                                                           quote_freshness,
                                                           quote_observed_time_text,
                                                           quote_continuity_status_text,
                                                           quote_unavailable_owner_text,
                                                           quote_unavailable_reason_text,
                                                           quote_unavailable_next_check_text,
                                                           quote_unavailable_symbol_select_state_text,
                                                           quote_unavailable_symbol_sync_state_text,
                                                           quote_unavailable_tick_success_text,
                                                           quote_unavailable_tick_last_error_text,
                                                           top5_quote_hydration_source_text,
                                                           has_market_watch,
                                                           has_packet && packet.continuity_backed,
                                                           quote_freshness_degraded_or_stale,
                                                           market_watch_quote_snapshot_status);

   body += ASC_BuildDossierDayStructureSection(day_open_text,
                                               day_high_text,
                                               day_low_text,
                                               daily_change_pct_text,
                                               day_range_text,
                                               day_range_pct_text,
                                               day_range_position_text,
                                               day_direction_snapshot_text,
                                               day_price_action_snapshot_text);

   body += ASC_BuildDossierMarketWatchVolatilityFrictionSection(atr_value_text,
                                                                atr_pct_text,
                                                                spread_over_atr_text,
                                                                volatility_posture_text,
                                                                friction_posture_text,
                                                                liquidity_posture_text,
                                                                market_watch_notes_text,
                                                                atr_ready,
                                                                volatility_continuity_sensitive,
                                                                regime_liquidity_helpers_available,
                                                                market_watch_volatility_friction_status);

   ASC_DossierAppendSectionHeader(body, section_order[5]);
   body += "Raw Broker Specification (Exact Platform Fields)\n";
   body += "  - Source: SYMBOL_* and packet/spec owner surfaces\n";
   body += "  - Interpretation: none (raw field fidelity)\n\n";
   body += ASC_BuildDossierTradingConditionsPriceContractSection(price_contract_digits_text,
                                                                 price_contract_point_text,
                                                                 price_contract_contract_size_text,
                                                                 price_contract_tick_size_text,
                                                                 price_contract_tick_value_text,
                                                                 price_contract_spread_type_text,
                                                                 calc_mode_text,
                                                                 price_contract_notes_text,
                                                                 price_contract_packet_values_available,
                                                                 price_contract_spec_values_available,
                                                                 trading_conditions_price_contract_status);

   body += ASC_BuildDossierTradingConditionsPermissionsSection(trade_permissions_trade_mode_text,
                                                               trade_permissions_execution_mode_text,
                                                               trade_permissions_filling_mode_text,
                                                               trade_permissions_expiration_mode_text,
                                                               trade_permissions_gtc_mode_text,
                                                               trade_permissions_orders_allowed_text,
                                                               trade_permissions_status_text,
                                                               trade_permissions_broker_validation_status_text,
                                                               trade_permissions_packet_values_available,
                                                               trade_permissions_spec_freshness_available,
                                                               trading_conditions_permissions_status);

   body += ASC_BuildDossierTradingConditionsVolumeRulesSection(volume_rules_minimum_volume_text,
                                                               volume_rules_maximum_volume_text,
                                                               volume_rules_step_text,
                                                               volume_rules_stops_level_text,
                                                               volume_rules_freeze_level_text,
                                                               volume_rules_position_notes_text,
                                                               volume_rules_packet_values_available,
                                                               volume_rules_stop_freeze_completeness_available,
                                                               trading_conditions_volume_rules_status);

   ASC_DossierAppendSectionHeader(body, section_order[6]);
   body += ASC_BuildDossierSessionsSection(sessions_quote_session_status_text,
                                           sessions_trade_session_status_text,
                                           sessions_quote_sessions_text,
                                           sessions_trade_sessions_text,
                                           sessions_notes_text,
                                           sessions_state_available,
                                           sessions_schedule_detail_available,
                                           sessions_status);

   body += ASC_BuildDossierSwapSection(swap_type_text,
                                       swap_long_text,
                                       swap_short_text,
                                       swap_monday_text,
                                       swap_tuesday_text,
                                       swap_wednesday_text,
                                       swap_thursday_text,
                                       swap_friday_text,
                                       swap_notes_text,
                                       swap_values_available,
                                       swap_schedule_available,
                                       swap_status);

   body += ASC_BuildDossierMarginSection(margin_mode_text,
                                         margin_hedged_text,
                                         margin_buy_initial_text,
                                         margin_buy_maintenance_text,
                                         margin_sell_initial_text,
                                         margin_sell_maintenance_text,
                                         margin_notes_text,
                                         margin_account_context_available,
                                         margin_broker_spec_margin_detail_available,
                                         margin_status);

   if(dossier_mode == ASC_DOSSIER_MODE_CLOSED_MARKET)
     {
      ASC_DossierRequiredTokens(dossier_mode, false, false, false, required_tokens);
      string closed_preview_payload = ASC_BuildPublicationHeader(bundle.publication_id, generated_utc) + body;
      body += ASC_PublicationResilienceBlock(closed_preview_payload,
                                             required_tokens,
                                             "symbol_dossier",
                                             "ASC_DossierComposer",
                                             "closed-market or missing dossier section truth is degraded/review debt, not a file-publication blocker",
                                             true);
      payload_out = ASC_BuildPublicationHeader(bundle.publication_id, generated_utc) + body;
      if(!ASC_DossierPayloadPassesMinimumIntegrity(payload_out, dossier_mode))
         return false;
      return true;
     }

   if(include_l3_section)
     {
      ASC_DossierAppendSectionHeader(body, section_order[7]);
      body += "Interpreted Tactical Analysis (Derived Labels)\n";
      body += "  - Source: Layer-3/4/5 computation stack\n";
      body += "  - Interpretation: calibrated thresholds and posture synthesis\n\n";
      body += ASC_BuildDossierCandidateFilteringGateStatusSection(gate_status_filter_state_text,
                                                               gate_status_eligibility_text,
                                                               gate_status_freshness_text,
                                                               gate_status_reason_summary_text,
                                                               gate_status_decision_confidence_text,
                                                               gate_status_owner_truth_available,
                                                               gate_status_freshness_available,
                                                               gate_status_freshness_degraded,
                                                               candidate_filtering_gate_status);

   body += ASC_BuildDossierCandidateFilteringBlockersDependenciesSection(blockers_disqualifiers_text,
                                                                         blockers_dependencies_text,
                                                                         blockers_missing_confirmation_text,
                                                                         blockers_next_required_step_text,
                                                                         blockers_constraint_notes_text,
                                                                         blockers_owner_truth_available,
                                                                         blockers_dependency_context_available,
                                                                         candidate_filtering_blockers_dependencies_status);

   body += ASC_BuildDossierCandidateFilteringSortingInputsSection(sorting_inputs_spread_gate_text,
                                                                  sorting_inputs_freshness_gate_text,
                                                                  sorting_inputs_state_gate_text,
                                                                  sorting_inputs_liquidity_gate_text,
                                                                  sorting_inputs_volatility_gate_text,
                                                                  sorting_inputs_quality_gate_text,
                                                                  sorting_inputs_notes_text,
                                                                  sorting_inputs_owner_truth_available,
                                                                  sorting_inputs_gate_context_available,
                                                                  candidate_filtering_sorting_inputs_status);
     }

   if(include_l4_section)
     {
      ASC_DossierAppendSectionHeader(body, section_order[8]);
   body += ASC_BuildDossierShortlistCoreSection(shortlist_core_status_text,
                                                shortlist_core_rank_text,
                                                shortlist_core_priority_score_text,
                                                shortlist_core_selection_posture_text,
                                                shortlist_core_reason_summary_text,
                                                shortlist_core_promotion_status_text,
                                                shortlist_core_owner_truth_available,
                                                shortlist_core_context_available,
                                                shortlist_core_status);

   body += ASC_BuildDossierShortlistStabilityHoldSection(shortlist_hold_status_text,
                                                         shortlist_stability_status_text,
                                                         shortlist_replacement_pressure_text,
                                                         shortlist_selection_continuity_text,
                                                         shortlist_notes_text,
                                                         shortlist_hold_owner_truth_available,
                                                         shortlist_hold_context_available,
                                                         shortlist_stability_hold_status);

   body += ASC_BuildDossierShortlistCorrelationExposureSection(shortlist_correlation_score_text,
                                                               shortlist_highest_correlations_text,
                                                               shortlist_lowest_correlations_text,
                                                               shortlist_exposure_conflict_status_text,
                                                               shortlist_open_pending_conflict_notes_text,
                                                               shortlist_portfolio_conflict_notes_text,
                                                               shortlist_correlation_owner_truth_available,
                                                               shortlist_correlation_context_available,
                                                               shortlist_correlation_exposure_status);
     }

   if(include_l5_section)
     {
      ASC_DossierAppendSectionHeader(body, section_order[9]);
      body += deep_section;
     }

   if(explicit_selected_symbol_path)
      body += ASC_BuildDossierSelectedSymbolContradictionSurface(explicit_selected_symbol_path,
                                                                 include_l3_section,
                                                                 include_l4_section,
                                                                 include_l5_section,
                                                                 has_deep_result,
                                                                 deep_completed,
                                                                 explicit_global_top10_path,
                                                                 open_positions,
                                                                 pending_orders,
                                                                 deep_status_line,
                                                                 dossier_shortlist_source_label,
                                                                 runtime_selected_symbol_context);
   ASC_DossierAppendSectionHeader(body, section_order[10]);
   string trader_risk_context_text = account_snapshot.open_risk_available ? DoubleToString(account_snapshot.open_risk_estimate, 2) : "unavailable";
   body += ASC_BuildDossierTraderContextSection(trader_risk_context_text,
                                                filter.dependencies_text,
                                                open_positions,
                                                pending_orders,
                                                trader_context_watchlist_priority_text,
                                                trader_context_changed_recently_text,
                                                trader_context_needs_recheck_text);

   body += ASC_BuildDossierRecentChangeTraceSection(change_trace_latest_meaningful_change_text,
                                                    change_trace_previous_meaningful_change_text,
                                                    change_trace_state_transition_notes_text,
                                                    change_trace_selection_transition_notes_text,
                                                    change_trace_publication_transition_notes_text,
                                                    change_trace_deep_transition_notes_text,
                                                    change_trace_owner_truth_available,
                                                    change_trace_transition_context_available,
                                                    recent_change_trace_status);

   ASC_DossierRequiredTokens(dossier_mode, include_l3_section, include_l4_section, include_l5_section, required_tokens);
   string dossier_preview_payload = ASC_BuildPublicationHeader(bundle.publication_id, generated_utc) + body;
   body += ASC_PublicationResilienceBlock(dossier_preview_payload,
                                          required_tokens,
                                          "symbol_dossier",
                                          "ASC_DossierComposer",
                                          "missing L3/L4/L5 or broker/trade-readiness facts degrade review/trade readiness but must not hide the dossier file",
                                          true);
   payload_out = ASC_BuildPublicationHeader(bundle.publication_id, generated_utc) + body;
   if(!ASC_DossierPayloadPassesMinimumIntegrity(payload_out, dossier_mode))
      return false;
   return true;
  }


#endif
